--Vista para revisar el historial de la sucursal 'US'
CREATE VIEW employeesUs AS
    SELECT employeeId, fullName, department, position FROM employeeAudit 
	INNER JOIN BranchOffice AS branch ON branch.name = employeeAudit.branchOffice
    WHERE branch.branchid = 5;

--Prueba
SELECT * FROM employeesUs;