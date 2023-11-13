-- Trigger function to automatically insert User_Roles when a new User is added
CREATE OR REPLACE FUNCTION Auth.InsertUserRoles() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Auth.User_Roles (UserId, RoleId)
    VALUES (NEW.Id, (SELECT Id FROM Auth.Roles WHERE Name = 'User'));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger function to automatically delete User_Roles when a User is deleted
CREATE OR REPLACE FUNCTION Auth.DeleteUserRoles() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM Auth.User_Roles WHERE UserId = OLD.Id;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Trigger to automatically insert User_Roles when a new User is added
DROP TRIGGER IF EXISTS InsertUserRoles ON Auth.Users CASCADE;
CREATE TRIGGER InsertUserRoles
AFTER INSERT ON Auth.Users
FOR EACH ROW
EXECUTE FUNCTION Auth.InsertUserRoles();

-- Trigger to automatically delete User_Roles when a User is deleted
DROP TRIGGER IF EXISTS DeleteUserRoles ON Auth.Users CASCADE;
CREATE TRIGGER DeleteUserRoles
AFTER DELETE ON Auth.Users
FOR EACH ROW
EXECUTE FUNCTION Auth.DeleteUserRoles();