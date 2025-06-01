.PHONY: help setup start stop test clean

help:
	@echo "Available commands:"
	@echo "  make setup    - Initial setup"
	@echo "  make start    - Start all services"
	@echo "  make stop     - Stop all services"
	@echo "  make test     - Run tests"
	@echo "  make clean    - Clean up"

setup:
	cp .env.example .env
	docker-compose pull
	docker-compose build

start:
	docker-compose up -d

stop:
	docker-compose down

test:
	cd ../ai-agent-test-repo && python -m pytest tests/

clean:
	docker-compose down -v
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete