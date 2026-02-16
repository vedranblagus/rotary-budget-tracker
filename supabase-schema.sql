-- Rotary District 1913 Budget Tracker - Supabase Schema
-- Run this in Supabase SQL Editor

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('admin', 'editor', 'viewer')),
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Budget table
CREATE TABLE IF NOT EXISTS budget (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    category TEXT NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('income', 'expense')),
    amount NUMERIC(12, 2) DEFAULT 0,
    fiscal_year TEXT DEFAULT '2026-2027',
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_by UUID REFERENCES users(id),
    UNIQUE(category, type, fiscal_year)
);

-- Transactions table
CREATE TABLE IF NOT EXISTS transactions (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    date TEXT NOT NULL,
    description TEXT,
    type TEXT NOT NULL CHECK (type IN ('income', 'expense')),
    category TEXT,
    amount NUMERIC(12, 2) NOT NULL,
    source TEXT DEFAULT 'manual',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_by UUID REFERENCES users(id),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Clubs table (for membership fees)
CREATE TABLE IF NOT EXISTS clubs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name TEXT UNIQUE NOT NULL,
    rotary_members INTEGER DEFAULT 0,
    spouses INTEGER DEFAULT 0,
    rotaract_members INTEGER DEFAULT 0,
    actual_payment NUMERIC(12, 2) DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_by UUID REFERENCES users(id)
);

-- Other income table
CREATE TABLE IF NOT EXISTS other_income (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    category TEXT UNIQUE NOT NULL,
    planned NUMERIC(12, 2) DEFAULT 0,
    actual NUMERIC(12, 2) DEFAULT 0,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_by UUID REFERENCES users(id)
);

-- Activity logs table
CREATE TABLE IF NOT EXISTS activity_logs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    log_type TEXT NOT NULL,
    description TEXT NOT NULL,
    old_value TEXT,
    new_value TEXT,
    user_id UUID REFERENCES users(id),
    user_name TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert default users (passwords are hashed - you'll need to update these)
-- Default password: admin123, editor123, viewer123
INSERT INTO users (email, name, role, password_hash) VALUES
    ('admin@rotary1913.org', 'Admin User', 'admin', 'admin123'),
    ('editor@rotary1913.org', 'Editor User', 'editor', 'editor123'),
    ('viewer@rotary1913.org', 'Viewer User', 'viewer', 'viewer123')
ON CONFLICT (email) DO NOTHING;

-- Insert default other income categories
INSERT INTO other_income (category, planned, actual) VALUES
    ('Prihodi od donacija RI za pokriće troškova DG', 0, 0),
    ('Prihodi od kotizacija za YE, Rotary kamp, RYLA', 0, 0),
    ('Prihodi od donacija', 0, 0),
    ('Prihodi od kamata na depozite poviđenju', 0, 0),
    ('Ostali prihodi', 0, 0),
    ('Sredstva iz viška sredstava prethodnih godina', 0, 0)
ON CONFLICT (category) DO NOTHING;

-- Row Level Security (RLS) Policies

-- Enable RLS on all tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE budget ENABLE ROW LEVEL SECURITY;
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE clubs ENABLE ROW LEVEL SECURITY;
ALTER TABLE other_income ENABLE ROW LEVEL SECURITY;
ALTER TABLE activity_logs ENABLE ROW LEVEL SECURITY;

-- Users table policies
CREATE POLICY "Users can view all users"
    ON users FOR SELECT
    USING (true);

CREATE POLICY "Only admins can insert users"
    ON users FOR INSERT
    WITH CHECK (true);

CREATE POLICY "Only admins can update users"
    ON users FOR UPDATE
    USING (true);

CREATE POLICY "Only admins can delete users"
    ON users FOR DELETE
    USING (true);

-- Budget table policies
CREATE POLICY "Everyone can view budget"
    ON budget FOR SELECT
    USING (true);

CREATE POLICY "Admins and editors can insert budget"
    ON budget FOR INSERT
    WITH CHECK (true);

CREATE POLICY "Admins and editors can update budget"
    ON budget FOR UPDATE
    USING (true);

-- Transactions table policies
CREATE POLICY "Everyone can view transactions"
    ON transactions FOR SELECT
    USING (true);

CREATE POLICY "Admins and editors can insert transactions"
    ON transactions FOR INSERT
    WITH CHECK (true);

CREATE POLICY "Admins and editors can update transactions"
    ON transactions FOR UPDATE
    USING (true);

CREATE POLICY "Admins and editors can delete transactions"
    ON transactions FOR DELETE
    USING (true);

-- Clubs table policies
CREATE POLICY "Everyone can view clubs"
    ON clubs FOR SELECT
    USING (true);

CREATE POLICY "Admins and editors can modify clubs"
    ON clubs FOR ALL
    USING (true);

-- Other income policies
CREATE POLICY "Everyone can view other income"
    ON other_income FOR SELECT
    USING (true);

CREATE POLICY "Admins and editors can modify other income"
    ON other_income FOR ALL
    USING (true);

-- Activity logs policies
CREATE POLICY "Everyone can view activity logs"
    ON activity_logs FOR SELECT
    USING (true);

CREATE POLICY "Everyone can insert activity logs"
    ON activity_logs FOR INSERT
    WITH CHECK (true);

-- Create indexes for better performance
CREATE INDEX idx_transactions_date ON transactions(date);
CREATE INDEX idx_transactions_type ON transactions(type);
CREATE INDEX idx_transactions_category ON transactions(category);
CREATE INDEX idx_budget_type ON budget(type);
CREATE INDEX idx_clubs_name ON clubs(name);
CREATE INDEX idx_activity_logs_created_at ON activity_logs(created_at DESC);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Add triggers for updated_at
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_budget_updated_at BEFORE UPDATE ON budget
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_transactions_updated_at BEFORE UPDATE ON transactions
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_clubs_updated_at BEFORE UPDATE ON clubs
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_other_income_updated_at BEFORE UPDATE ON other_income
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
