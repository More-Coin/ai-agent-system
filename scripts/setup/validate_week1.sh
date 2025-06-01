#!/bin/bash

echo "🔍 Validating Week 1 Setup..."

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Check function
check() {
    if eval "$2"; then
        echo -e "${GREEN}✓${NC} $1"
        return 0
    else
        echo -e "${RED}✗${NC} $1"
        return 1
    fi
}

# Validations
echo -e "\n📦 Checking Prerequisites..."
check "Docker installed" "docker --version > /dev/null 2>&1"
check "Python 3.11+ installed" "python3.11 --version > /dev/null 2>&1"
check "Node.js installed" "node --version > /dev/null 2>&1"
check "Git installed" "git --version > /dev/null 2>&1"

echo -e "\n📁 Checking Project Structure..."
check "Agents directory exists" "[ -d agents/manager ] && [ -d agents/editor ]"
check "Dashboard directory exists" "[ -d dashboard ]"
check "Docker Compose file exists" "[ -f docker-compose.yml ]"
check "Environment example exists" "[ -f .env.example ]"

echo -e "\n📝 Checking Test Repository..."
check "Test repo exists" "[ -d ../ai-agent-test-repo ]"
check "Sample code created" "[ -f ../ai-agent-test-repo/src/core/calculator.py ]"
check "Tests created" "[ -f ../ai-agent-test-repo/tests/unit/test_calculator.py ]"

echo -e "\n✅ Week 1 Setup Validation Complete!"