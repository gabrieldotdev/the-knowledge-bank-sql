-- Create table Auth.Roles
CREATE TABLE IF NOT EXISTS Auth.Roles (
    Id SERIAL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(255) NOT NULL DEFAULT ''
);
-- Create Roles
INSERT INTO Auth.Roles (Name, Description)
VALUES ('Admin', 'Administrator with full access'),
    ('Editor', 'Content editor with editing privileges'),
    ('User', 'Standard user with basic access'),
    ('Moderator', 'Content moderator with moderation privileges');

-- Create table Auth.Permissions
CREATE TABLE IF NOT EXISTS Auth.Permissions (
    Id SERIAL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(255) NOT NULL DEFAULT ''
);

-- Create table Auth.Users
DROP TABLE IF EXISTS Auth.Users CASCADE;
CREATE TABLE IF NOT EXISTS Auth.Users (
    Id SERIAL PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(50) NOT NULL UNIQUE,
    PublishedOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create table Auth.User_Roles
DROP TABLE IF EXISTS Auth.User_Roles CASCADE;
CREATE TABLE IF NOT EXISTS Auth.User_Roles (
    Id SERIAL PRIMARY KEY,
    UserId INT NOT NULL,
    RoleId INT NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Auth.Users (Id),
    FOREIGN KEY (RoleId) REFERENCES Auth.Roles (Id)
);

-- Trigger function to automatically insert User_Roles when a new User is added
CREATE OR REPLACE FUNCTION Auth.InsertUserRoles() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Auth.User_Roles (UserId, RoleId)
    VALUES (NEW.Id, (SELECT Id FROM Auth.Roles WHERE Name = 'User'));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to automatically insert User_Roles when a new User is added
DROP TRIGGER IF EXISTS InsertUserRoles ON Auth.Users CASCADE;
CREATE TRIGGER InsertUserRoles
AFTER INSERT ON Auth.Users
FOR EACH ROW
EXECUTE FUNCTION Auth.InsertUserRoles();

-- INSERT DATA
-- Create Users
INSERT INTO Auth.Users (Username, Password, Email)
VALUES ('admin', '$hJb37hj', 'admin@test.com'),
    ('user', '$hJb37hj', 'user@test.com'),
    ('editor', '$hJb37hj', 'staff@test.com'),
    ('moderator', '$hJb37hj', 'moderator@test.com');
