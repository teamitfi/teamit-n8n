-- Create the "users" table
CREATE TABLE IF NOT EXISTS users (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    cognito_id TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    created_at TIMESTAMPTZ DEFAULT now()
    );

-- Insert sample data
INSERT INTO users (cognito_id, email)
VALUES
    ('test-cognito-id-1', 'test1@example.com'),
    ('test-cognito-id-2', 'test2@example.com');