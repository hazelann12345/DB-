-- Audit trigger for BudgetAllocations
DROP TRIGGER IF EXISTS audit_budgetallocations ON budgetallocations;

CREATE TRIGGER audit_budgetallocations
AFTER INSERT OR UPDATE OR DELETE
ON budgetallocations
FOR EACH ROW
EXECUTE FUNCTION audit_log_trigger();

-- Audit trigger for Expenditures
DROP TRIGGER IF EXISTS audit_expenditures ON expenditures;

CREATE TRIGGER audit_expenditures
AFTER INSERT OR UPDATE OR DELETE
ON expenditures
FOR EACH ROW
EXECUTE FUNCTION audit_log_trigger();