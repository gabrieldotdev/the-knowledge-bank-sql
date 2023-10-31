-- Create table TheKnowledgeBank.Articles
CREATE TABLE IF NOT EXISTS TheKnowledgeBank.Articles (
    Id SERIAL PRIMARY KEY,
    Title VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(255) NOT NULL DEFAULT '',
    Content TEXT NOT NULL,
    PublishedOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CategoryId INT NOT NULL,
    UserId INT NOT NULL,
    FOREIGN KEY (CategoryId) REFERENCES Categories (Id),
    FOREIGN KEY (UserId) REFERENCES Auth.Users (Id)
);
-- Create table TheKnowledgeBank.Article_Tags
CREATE TABLE IF NOT EXISTS TheKnowledgeBank.Article_Tags (
    Id SERIAL PRIMARY KEY,
    ArticleId INT NOT NULL,
    TagId INT NOT NULL,
    FOREIGN KEY (ArticleId) REFERENCES TheKnowledgeBank.Articles (Id),
    FOREIGN KEY (TagId) REFERENCES Tags (Id)
);
-- Create table TheKnowledgeBank.Comments
CREATE TABLE IF NOT EXISTS TheKnowledgeBank.Comments (
    Id SERIAL PRIMARY KEY,
    Content TEXT NOT NULL,
    PublishedOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ArticleId INT NOT NULL,
    UserId INT NOT NULL,
    FOREIGN KEY (ArticleId) REFERENCES TheKnowledgeBank.Articles (Id),
    FOREIGN KEY (UserId) REFERENCES Auth.Users (Id)
);
-- Create table TheKnowledgeBank.Replies
CREATE TABLE IF NOT EXISTS TheKnowledgeBank.Replies (
    Id SERIAL PRIMARY KEY,
    Content TEXT NOT NULL,
    PublishedOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedOn TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CommentId INT NOT NULL,
    UserId INT NOT NULL,
    FOREIGN KEY (CommentId) REFERENCES TheKnowledgeBank.Comments (Id),
    FOREIGN KEY (UserId) REFERENCES Auth.Users (Id)
);
