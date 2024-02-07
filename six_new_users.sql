SELECT 'DROPPING USER admin_001' AS 'INSTALLATION PROGRESSING';

DROP USER
IF EXISTS 'admin_001'@'%'

SELECT 'ADDING USER admin_001' AS 'INSTALLATION PROGRESSING';
CREATE user
IF NOT EXISTS 'admin_001'@'%'
IDENTIFIED BY 'guttmanGrizzlies_2024'
WITH

--SET RESOURCE LIMITS
MAX_QUERIES_PER_HOUR 20
MAX_UPDATES_PER_HOUR 10
MAX_CONNECTIONS_PER_HOUR 5
MAX_USER_CONNECTIONS 2
--SET PASSWORD OPTIONS
FAILED_LOGIN_ATTEMPTS 4
PASSWORD_LOCK_TIME UNBOUNDED
PASSWORD EXPIRE INTERVAL 90 DAY
PASSWORD HISTORY 5
PASSWORD REUSE INTERVAL 365 DAY;

SELECT user, show_db_priv, account_locked
FROM mysql.user;

SELECT 'ADDING ROLES' AS 'INSTALLATION PROGRESSING';
--CREATE ROLES
IF NOT EXISTS
'read_only_classicmodels_db',
'admin_user',
'read_only_employees_db',
'app_user';

SELECT user, show_db_priv, account_locked
FROM mysql.user;

--GRANT PRIVILEGES
GRANT SELECT
ON classicmodels. *
TO 'read_only_classicmodels_db'@'%';

GRANT CREATE, DROP
ON employees.*
TO 'admin_user'@'%';

GRANT CREATE, DROP
ON classicmodels.*
TO 'admin_user'@'%';

GRANT SHOW DATABASES
ON *.*
TO 'admin_user'@'%';

GRANT INSERT, UPDATE
ON employees.employees
TO 'app_user'@'%';

GRANT SELECT
ON employees.*
TO 'read_only_employees_db'@'%';

SELECT user, show_db_priv, account_locked
FROM mysql.user;

--CREATE ROLES
SELECT 'CREATING ROLES' AS 'INSTALLATION PROGRESSING';
GRANT 'admin_007' TO 'admin_006';

GRANT 'read_only_classicmodels_db' to 'admin_001', 'admin_003';

GRANT 'app_user' TO 'admin_006';

GRANT 'admin_user' TO 'admin_005';

FLUSH PRIVILIGES;

-- CREATE ROLES
SELECT 'ENABLING ROLES' AS 'INSTALLATION PROGRESSING'

SELECT DEFAULT
ROLE ALL TO 'admin_001'@'%', 'admin_002'@'%',
'admin_003'@'%', 'admin_004'@'%',
'admin_005'@'%', 'admin_006'@'%';

--CREATE ROLES
SELECT 'SCRIPT DONE' AS 'INSTALLATION PROGRESSING';
