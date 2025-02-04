
-- This makes sure that foreign_key constraints are observed and that errors will be thrown for violations
PRAGMA foreign_keys=ON;

BEGIN TRANSACTION;

-- Create your tables with SQL commands here (watch out for slight syntactical differences with SQLite vs MySQL)

-- create table for articles
CREATE TABLE IF NOT EXISTS articles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    content TEXT,
    status TEXT NOT NULL CHECK(status IN ('draft', 'published')),
    created_at DATETIME NOT NULL,
    last_modified DATETIME NOT NULL,
    published_at DATETIME,
    reads INTEGER DEFAULT 0,
    likes INTEGER DEFAULT 0
);

-- create table for authors, to be edited in Settings 
CREATE TABLE IF NOT EXISTS authorSettings (
    author_id INTEGER PRIMARY KEY AUTOINCREMENT,
    blog_title TEXT NOT NULL,
    author_name TEXT NOT NULL
);

INSERT INTO authorSettings ('blog_title', 'author_name')VALUES('DBNW PROJECT', 'Elgin');


-- create table of comments
CREATE TABLE IF NOT EXISTS comments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    article_id INTEGER NOT NULL,
    commenterName TEXT NOT NULL,
    commentContent TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE
);


-- Create table of users, with authorisations or not
CREATE TABLE IF NOT EXISTS users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT NOT NULL,
    username TEXT NOT NULL,
    password TEXT NOT NULL,
    authorised BOOLEAN DEFAULT False
);

-- default author account
INSERT INTO users ('email', 'username', 'password', 'authorised')VALUES('author@mail.com', 'author', 'author123', True);
INSERT INTO users ('user_email', 'username', 'password', 'authorised')VALUES('user@mail.com', 'user', 'user123', False);


-- Setting up default data for articles function
INSERT INTO articles (title, content, status, created_at, last_modified, published_at, reads, likes) 
VALUES ('First Published Article', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris semper erat at sollicitudin rutrum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis in luctus massa, sit amet aliquam quam. Suspendisse ut sollicitudin tortor. Aenean suscipit convallis neque, sit amet venenatis risus consectetur et. Nam nec egestas purus. Vivamus ac accumsan libero. Integer posuere nibh a massa viverra euismod.

', 'published', datetime('now', '-10 days'), datetime('now', '-5 days'), datetime('now', '-9 days'), 150, 10);

INSERT INTO articles (title, content, status, created_at, last_modified, published_at, reads, likes) 
VALUES ('Second Published Article', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris semper erat at sollicitudin rutrum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis in luctus massa, sit amet aliquam quam. Suspendisse ut sollicitudin tortor. Aenean suscipit convallis neque, sit amet venenatis risus consectetur et. Nam nec egestas purus. Vivamus ac accumsan libero. Integer posuere nibh a massa viverra euismod.

', 'published', datetime('now', '-7 days'), datetime('now', '-3 days'), datetime('now', '-6 days'), 250, 20);

INSERT INTO articles (title, content, status, created_at, last_modified, published_at, reads, likes) 
VALUES ('First draft Article', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris semper erat at sollicitudin rutrum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis in luctus massa, sit amet aliquam quam. Suspendisse ut sollicitudin tortor. Aenean suscipit convallis neque, sit amet venenatis risus consectetur et. Nam nec egestas purus. Vivamus ac accumsan libero. Integer posuere nibh a massa viverra euismod.

', 'draft', datetime('now', '-5 days'), datetime('now', '-5 days'), datetime('now', '-9 days'), 150, 10);

INSERT INTO articles (title, content, status, created_at, last_modified, published_at, reads, likes) 
VALUES ('Second draft Article', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris semper erat at sollicitudin rutrum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis in luctus massa, sit amet aliquam quam. Suspendisse ut sollicitudin tortor. Aenean suscipit convallis neque, sit amet venenatis risus consectetur et. Nam nec egestas purus. Vivamus ac accumsan libero. Integer posuere nibh a massa viverra euismod.

', 'draft', datetime('now', '-3 days'), datetime('now', '-3 days'), datetime('now', '-6 days'), 250, 20);



COMMIT;

