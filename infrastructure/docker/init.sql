-- Database schema initialization

-- Create enum types
CREATE TYPE task_status AS ENUM ('pending', 'in_progress', 'completed', 'failed', 'cancelled');
CREATE TYPE task_type AS ENUM ('todo_fix', 'refactor', 'add_tests', 'add_docs', 'bug_fix', 'feature');
CREATE TYPE agent_type AS ENUM ('manager', 'editor', 'auditor', 'task_assessor');

-- Tasks table
CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    external_id UUID DEFAULT gen_random_uuid() UNIQUE NOT NULL,
    type task_type NOT NULL,
    status task_status DEFAULT 'pending' NOT NULL,
    priority INTEGER DEFAULT 5 CHECK (priority >= 1 AND priority <= 10),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    context JSONB,
    assigned_to agent_type,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    started_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE,
    result JSONB,
    error_message TEXT,
    retry_count INTEGER DEFAULT 0,
    parent_task_id INTEGER REFERENCES tasks(id)
);

-- Agent logs table
CREATE TABLE agent_logs (
    id SERIAL PRIMARY KEY,
    agent_type agent_type NOT NULL,
    task_id INTEGER REFERENCES tasks(id),
    action VARCHAR(100) NOT NULL,
    details JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Metrics table
CREATE TABLE metrics (
    id SERIAL PRIMARY KEY,
    metric_name VARCHAR(100) NOT NULL,
    metric_value DECIMAL,
    labels JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes
CREATE INDEX idx_tasks_status ON tasks(status);
CREATE INDEX idx_tasks_type ON tasks(type);
CREATE INDEX idx_tasks_created_at ON tasks(created_at);
CREATE INDEX idx_agent_logs_agent_type ON agent_logs(agent_type);
CREATE INDEX idx_agent_logs_created_at ON agent_logs(created_at);
CREATE INDEX idx_metrics_name_created ON metrics(metric_name, created_at);

-- Create update trigger for updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_tasks_updated_at BEFORE UPDATE ON tasks
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();