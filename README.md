# AI Agent System

Multi-agent AI development system using MCP (Model Context Protocol).

## Quick Start

### Prerequisites
- Docker & Docker Compose
- Python 3.11+
- Node.js 18+
- GitHub account with personal access token

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/[YOUR_ORG]/ai-agent-system.git
   cd ai-agent-system
   ```

2. Copy environment template and add your API keys:
   ```bash
   cp .env.example .env
   # Edit .env with your actual API keys
   ```

3. Start infrastructure services:
   ```bash
   docker-compose up -d redis postgres mcp-server
   ```

4. Verify services are running:
   ```bash
   docker-compose ps
   curl http://localhost:8080/health
   ```

### Project Structure
- `agents/` - Agent implementations (Manager, Editor)
- `dashboard/` - Web UI for monitoring
- `shared/` - Shared utilities and protocols
- `infrastructure/` - Docker, K8s configs
- `tests/` - Test suites
- `docs/` - Documentation

### Development

Run tests:
```bash
make test
```

Start agents:
```bash
make run-agents
```

### Troubleshooting

If Redis connection fails:
```bash
docker-compose restart redis
```

If PostgreSQL won't start:
```bash
docker-compose logs postgres
```

For more details, see docs/development.md