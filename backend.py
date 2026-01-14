from flask import Flask, request, jsonify
import psycopg2
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  

# Connect to Neon Postgres
conn = psycopg2.connect(
    host="ep-tiny-glade-a1k2fdv0-pooler.ap-southeast-1.aws.neon.tech",
    port=5432,
    database="neondb",
    user="neondb_owner",
    password="npg_EPUue4Qs6GMj",
    sslmode="require"
)

@app.route("/api/login", methods=["POST"])
def login():
    data = request.json
    username = data.get("username")
    password = data.get("password")

    cur = conn.cursor()
    cur.execute("SELECT username, passwordhash, role FROM Users WHERE username=%s", (username,))
    user = cur.fetchone()
    cur.close()

    if not user:
        return jsonify({"error": "Invalid username"}), 401

    db_username, db_passwordhash, role = user

    if password != db_passwordhash:  # just match the plain string
        return jsonify({"error": "Invalid password"}), 401

    return jsonify({"username": db_username, "role": role})

@app.route("/api/register", methods=["POST"])
def register():
    data = request.json
    username = data.get("username")
    email = data.get("email")
    password = data.get("password")
    role = "Viewer"  # default role

    # Basic validation
    if not username or not email or not password:
        return jsonify({"error": "Username, email, and password are required"}), 400

    cur = conn.cursor()
    try:
        # Check if username or email already exists
        cur.execute("SELECT userid FROM Users WHERE username=%s OR email=%s", (username, email))
        if cur.fetchone():
            return jsonify({"error": "Username or email already exists"}), 409

        # Insert new user with plain password
        cur.execute(
            "INSERT INTO Users (username, email, passwordhash, role) VALUES (%s, %s, %s, %s) RETURNING username, email, role",
            (username, email, password, role)
        )
        new_user = cur.fetchone()
        conn.commit()

        return jsonify({"message": "Account created!", "user": {
            "username": new_user[0],
            "email": new_user[1],
            "role": new_user[2]
        }}), 201

    except Exception as e:
        conn.rollback()
        print(e)
        return jsonify({"error": "Registration failed"}), 500
    finally:
        cur.close()

@app.route("/api/expenditures", methods=["GET"])
def get_expenditures():
    cur = conn.cursor()
    try:
        cur.execute("""
            SELECT 
                expenseid,
                allocationid,
                projectid,
                categoryid,
                description,
                expenseamount,
                expensedate,
                recordedby
            FROM Expenditures
            ORDER BY expensedate DESC
        """)

        rows = cur.fetchall()

        expenditures = []
        for row in rows:
            expenditures.append({
                "expenseid": row[0],
                "allocationid": row[1],
                "projectid": row[2],
                "categoryid": row[3],
                "description": row[4],
                "amount": float(row[5]),
                "date": row[6],
                "recordedby": row[7]
            })

        return jsonify(expenditures), 200

    except Exception as e:
        print("Fetch expenditures error:", e)
        return jsonify({"error": "Failed to fetch expenditures"}), 500
    finally:
        cur.close()

@app.route("/api/dashboard/stats", methods=["GET"])
def get_dashboard_stats():
    cur = conn.cursor()
    try:
        cur.execute("SELECT COUNT(*) FROM Departments")
        total_departments = cur.fetchone()[0]

        cur.execute("SELECT COUNT(*) FROM Projects")
        total_projects = cur.fetchone()[0]

        cur.execute("SELECT COUNT(*) FROM BudgetAllocations")
        total_allocations = cur.fetchone()[0]

        cur.execute("SELECT COUNT(*) FROM Expenditures")
        total_expenditures = cur.fetchone()[0]

        return jsonify({
            "totalDepartments": total_departments,
            "totalProjects": total_projects,
            "totalAllocations": total_allocations,
            "totalExpenditures": total_expenditures
        }), 200

    except Exception as e:
        print("Dashboard stats error:", e)
        return jsonify({"error": "Failed to fetch dashboard stats"}), 500
    finally:
        cur.close()

@app.route("/api/allocations", methods=["GET"])
def get_allocations():
    cur = conn.cursor()
    try:
        cur.execute("""
            SELECT 
                allocationid,
                allocationamount,
                allocationdate
            FROM BudgetAllocations
            ORDER BY allocationdate DESC
        """)
        rows = cur.fetchall()

        allocations = []
        for r in rows:
            allocations.append({
                "allocationid": r[0],
                "amount": float(r[1]),
                "date": r[2]
            })

        return jsonify(allocations), 200

    except Exception as e:
        print("Fetch allocations error:", e)
        return jsonify({"error": "Failed to fetch allocations"}), 500
    finally:
        cur.close()

@app.route("/api/audit-logs", methods=["GET"])
def get_audit_logs():
    current_user_role = request.headers.get("role")  # from login/session
    current_user_id = request.headers.get("userid")  # from login/session

    cur = conn.cursor()
    try:
        if current_user_role == "Viewer":
            # Just return empty list, no access denied
            return jsonify([]), 200

        elif current_user_role == "Admin":
            cur.execute("""
                SELECT
                    a.logid,
                    u.username,
                    a.entitytype,
                    a.entityid,
                    a.action,
                    a.timestamp,
                    a.details
                FROM AuditLogs a
                LEFT JOIN Users u ON a.userid = u.userid
                ORDER BY a.timestamp DESC
            """)
        elif current_user_role == "Accountant":
            cur.execute("""
                SELECT
                    a.logid,
                    u.username,
                    a.entitytype,
                    a.entityid,
                    a.action,
                    a.timestamp,
                    a.details
                FROM AuditLogs a
                LEFT JOIN Users u ON a.userid = u.userid
                WHERE a.entitytype IN ('BudgetAllocations', 'Expenditures')
                ORDER BY a.timestamp DESC
            """)
        else:
            cur.execute("""
                SELECT
                    a.logid,
                    u.username,
                    a.entitytype,
                    a.entityid,
                    a.action,
                    a.timestamp,
                    a.details
                FROM AuditLogs a
                LEFT JOIN Users u ON a.userid = u.userid
                WHERE a.entitytype IN ('Projects', 'Departments')
                ORDER BY a.timestamp DESC
            """)

        rows = cur.fetchall()
        logs = []
        for r in rows:
            logs.append({
                "id": r[0],
                "user": r[1],
                "entity": r[2],
                "entityid": r[3],
                "action": r[4],
                "timestamp": r[5],
                "details": r[6]
            })

        return jsonify(logs), 200

    except Exception as e:
        print("Audit logs fetch error:", e)
        return jsonify({"error": "Failed to fetch audit logs"}), 500
    finally:
        cur.close()


if __name__ == "__main__":
    app.run(debug=True)
