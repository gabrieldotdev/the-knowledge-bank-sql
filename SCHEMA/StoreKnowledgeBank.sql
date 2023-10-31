-- Create table StoreKnowledgeBank.Books
CREATE TABLE IF NOT EXISTS StoreKnowledgeBank.Books (
    Id SERIAL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Description TEXT NOT NULL DEFAULT '',
    Image VARCHAR(255) NOT NULL,
    PublishedOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UserId INT NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Auth.Users (Id)
);
-- Create table StoreKnowledgeBank.Authors
CREATE TABLE IF NOT EXISTS StoreKnowledgeBank.Authors (
    Id SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Description TEXT NOT NULL DEFAULT '',
    Image VARCHAR(255) NOT NULL,
    PublishedOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UserId INT NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Auth.Users (Id)
);
-- Create table StoreKnowledgeBank.Book_Authors
CREATE TABLE IF NOT EXISTS StoreKnowledgeBank.Book_Authors (
    Id SERIAL PRIMARY KEY,
    BookId INT NOT NULL,
    AuthorId INT NOT NULL,
    FOREIGN KEY (BookId) REFERENCES StoreKnowledgeBank.Books (Id),
    FOREIGN KEY (AuthorId) REFERENCES StoreKnowledgeBank.Authors (Id)
);

-- …or create a new repository on the command line
echo "# test" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:lilwxs/test.git
git push -u origin main

-- …or push an existing repository from the command line
git remote add origin git@github.com:lilwxs/test.git
git branch -M main
git push -u origin main