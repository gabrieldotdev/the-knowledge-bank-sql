-- Create table Auth.Roles
CREATE TABLE IF NOT EXISTS Auth.Roles (
    Id SERIAL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(255) NOT NULL DEFAULT ''
);
-- Create table Auth.Permissions
CREATE TABLE IF NOT EXISTS Auth.Permissions (
    Id SERIAL PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(255) NOT NULL DEFAULT ''
);
-- Create table Auth.Role_Permissions
CREATE TABLE IF NOT EXISTS Auth.Role_Permissions (
    Id SERIAL PRIMARY KEY,
    RoleId INT NOT NULL,
    PermissionId INT NOT NULL,
    FOREIGN KEY (RoleId) REFERENCES Auth.Roles (Id),
    FOREIGN KEY (PermissionId) REFERENCES Auth.Permissions (Id)
);
-- Create table Auth.Users
CREATE TABLE IF NOT EXISTS Auth.Users (
    Id SERIAL PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL UNIQUE,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Avatar VARCHAR(255) NOT NULL DEFAULT '',
    IsActivated BOOLEAN NOT NULL DEFAULT TRUE,
    IsStaff BOOLEAN NOT NULL DEFAULT FALSE,
    IsSuperuser BOOLEAN NOT NULL DEFAULT FALSE,
    IsVerified BOOLEAN NOT NULL DEFAULT FALSE,
    PublishedOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    LastLogin TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
-- Create table Auth.User_Roles
CREATE TABLE IF NOT EXISTS Auth.User_Roles (
    Id SERIAL PRIMARY KEY,
    UserId INT NOT NULL,
    RoleId INT NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Auth.Users (Id),
    FOREIGN KEY (RoleId) REFERENCES Auth.Roles (Id)
);

-- Tạo Strigger tự động tạo data cho bảng Role_Permissions
CREATE OR REPLACE FUNCTION create_role_permissions()
    RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO Auth.Role_Permissions (RoleId, PermissionId)
        SELECT NEW.Id, Id FROM Auth.Permissions;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER create_role_permissions
    AFTER INSERT ON Auth.Roles
    FOR EACH ROW
    EXECUTE PROCEDURE create_role_permissions();
-- Tạo Strigger tự động tạo data cho bảng User_Roles
CREATE OR REPLACE FUNCTION create_user_roles()
    RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO Auth.User_Roles (UserId, RoleId)
        SELECT NEW.Id, Id FROM Auth.Roles;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER create_user_roles
    AFTER INSERT ON Auth.Users
    FOR EACH ROW
    EXECUTE PROCEDURE create_user_roles();

-- INSERT DATA
INSERT INTO Auth.Roles (Name, Description)
VALUES ('Admin', 'Administrator with full access'),
    ('User', 'Standard user with basic access'),
    (
        'Editor',
        'Content editor with editing privileges'
    ),
    (
        'Manager',
        'Manager with managerial responsibilities'
    ),
    (
        'Moderator',
        'Moderator with content moderation privileges'
    );
INSERT INTO Auth.Permissions (Name, Description)
VALUES ('View', 'Permissions to view content'),
    ('Create', 'Permissions to create content'),
    ('Edit', 'Permissions to edit content'),
    ('Delete', 'Permissions to delete content'),
    ('Publish', 'Permissions to publish content'),
    ('Unpublish', 'Permissions to unpublish content'),
    ('Manage', 'Permissions to manage content'),
    ('Moderate', 'Permissions to moderate content'),
    (
        'Administer',
        'Permissions to administer content'
    );