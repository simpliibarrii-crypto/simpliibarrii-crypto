# Makefile for Raven AI Ecosystem Profile Repository
# Manages all sub-projects: raven-ai, hermes-edge, home-for-ai, openclinical-ai

.PHONY: help install-all install-dev install-docker install-demo clean test-all docker-up docker-down demo-all

# Default target
help:
	@echo "Raven AI Ecosystem - Profile Repository"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Installation Targets:"
	@echo "  install-all      Install all projects in development mode"
	@echo "  install-dev      Alias for install-all"
	@echo "  install-docker   Pull Docker images for all projects"
	@echo "  install-demo     Open all Hugging Face Space demos in browser"
	@echo ""
	@echo "Project-Specific Install:"
	@echo "  install-raven-ai       Install Raven AI (dev)"
	@echo "  install-hermes-edge    Install Hermes Edge (dev)"
	@echo "  install-home-for-ai    Install Home for AI (dev)"
	@echo "  install-openclinical   Install OpenClinical AI (dev)"
	@echo ""
	@echo "Docker Targets:"
	@echo "  docker-up        Start all services via docker-compose"
	@echo "  docker-down      Stop all services"
	@echo "  docker-logs      View logs from all services"
	@echo "  docker-build     Build all Docker images locally"
	@echo ""
	@echo "Testing & Quality:"
	@echo "  test-all         Run tests for all projects"
	@echo "  lint-all         Lint all projects"
	@echo ""
	@echo "Maintenance:"
	@echo "  clean            Remove build artifacts and virtual environments"
	@echo "  update           Pull latest changes for all submodules"
	@echo "  status           Show git status for all projects"
	@echo ""
	@echo "Paper & Site:"
	@echo "  paper            Open scientific paper in browser"
	@echo "  deploy-site      Deploy profile site to GitHub Pages"

# Installation targets
install-all: install-raven-ai install-hermes-edge install-home-for-ai install-openclinical
	@echo "✅ All projects installed in development mode"

install-dev: install-all

install-raven-ai:
	@echo "📦 Installing Raven AI..."
	pip install raven-ai
	@echo "✅ Raven AI installed. Run: raven serve --port 8000"

install-hermes-edge:
	@echo "📦 Installing Hermes Edge..."
	@if [ ! -d "hermes-edge" ]; then git clone https://github.com/simpliibarrii-crypto/hermes-edge.git; fi
	cd hermes-edge && pip install -e ".[runtime]"
	@echo "✅ Hermes Edge installed. Run: hermes --model dist/hermes-mobile-270m-int4.litertlm --backend auto"

install-home-for-ai:
	@echo "📦 Installing Home for AI..."
	@if [ ! -d "home-for-ai" ]; then git clone https://github.com/simpliibarrii-crypto/home-for-ai.git; fi
	cd home-for-ai && npm install && npm run tauri:build
	@echo "✅ Home for AI built. Run: npm run tauri:dev"

install-openclinical:
	@echo "📦 Installing OpenClinical AI..."
	@if [ ! -d "openclinical-ai" ]; then git clone https://github.com/simpliibarrii-crypto/openclinical-ai.git; fi
	cd openclinical-ai && python -m venv .venv && . .venv/bin/activate && pip install -e . pytest pynacl
	@echo "✅ OpenClinical AI installed. Run: ./run_dev.sh"

# Docker targets
install-docker:
	@echo "🐳 Pulling Docker images..."
	docker pull ghcr.io/simpliibarrii-crypto/raven-ai:latest || true
	docker pull ghcr.io/simpliibarrii-crypto/openclinical-ai:latest || true
	@echo "✅ Docker images pulled"

docker-up:
	@echo "🚀 Starting all services..."
	docker-compose up -d
	@echo "✅ Services started:"
	@echo "  Raven AI:        http://localhost:8000"
	@echo "  Hermes Edge:     http://localhost:7860"
	@echo "  Home for AI:     http://localhost:8001"
	@echo "  OpenClinical AI: http://localhost:8088"

docker-down:
	@echo "🛑 Stopping all services..."
	docker-compose down

docker-logs:
	docker-compose logs -f

docker-build:
	@echo "🔨 Building Docker images..."
	docker-compose build

# Demo targets
install-demo: demo-all

demo-all: demo-raven-ai demo-hermes-edge demo-home-for-ai demo-openclinical

demo-raven-ai:
	@xdg-open "https://huggingface.co/spaces/bclermo/raven-ai" 2>/dev/null || open "https://huggingface.co/spaces/bclermo/raven-ai" 2>/dev/null || echo "Open: https://huggingface.co/spaces/bclermo/raven-ai"

demo-hermes-edge:
	@xdg-open "https://huggingface.co/spaces/bclermo/hermes-edge" 2>/dev/null || open "https://huggingface.co/spaces/bclermo/hermes-edge" 2>/dev/null || echo "Open: https://huggingface.co/spaces/bclermo/hermes-edge"

demo-home-for-ai:
	@xdg-open "https://huggingface.co/spaces/bclermo/home-for-ai" 2>/dev/null || open "https://huggingface.co/spaces/bclermo/home-for-ai" 2>/dev/null || echo "Open: https://huggingface.co/spaces/bclermo/home-for-ai"

demo-openclinical:
	@xdg-open "https://huggingface.co/spaces/bclermo/openclinical-ai" 2>/dev/null || open "https://huggingface.co/spaces/bclermo/openclinical-ai" 2>/dev/null || echo "Open: https://huggingface.co/spaces/bclermo/openclinical-ai"

# Testing & Quality
test-all: test-raven-ai test-hermes-edge test-openclinical

test-raven-ai:
	@if [ -d "raven-ai" ]; then cd raven-ai && pytest -q; fi

test-hermes-edge:
	@if [ -d "hermes-edge" ]; then cd hermes-edge && pytest tests -q; fi

test-home-for-ai:
	@if [ -d "home-for-ai" ]; then cd home-for-ai && npm test; fi

test-openclinical:
	@if [ -d "openclinical-ai" ]; then cd openclinical-ai && pytest -q; fi

lint-all: lint-raven-ai lint-hermes-edge lint-home-for-ai lint-openclinical

lint-raven-ai:
	@if [ -d "raven-ai" ]; then cd raven-ai && ruff check .; fi

lint-hermes-edge:
	@if [ -d "hermes-edge" ]; then cd hermes-edge && ruff check hermes/ tests/; fi

lint-home-for-ai:
	@if [ -d "home-for-ai" ]; then cd home-for-ai && npm run lint; fi

lint-openclinical:
	@if [ -d "openclinical-ai" ]; then cd openclinical-ai && ruff check runtime/; fi

# Maintenance
clean:
	@echo "🧹 Cleaning build artifacts..."
	@rm -rf hermes-edge/dist hermes-edge/build hermes-edge/*.egg-info
	@rm -rf home-for-ai/dist home-for-ai/build
	@rm -rf openclinical-ai/dist openclinical-ai/build openclinical-ai/*.egg-info
	@rm -rf raven-ai/dist raven-ai/build raven-ai/*.egg-info
	@find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	@find . -type d -name ".ruff_cache" -exec rm -rf {} + 2>/dev/null || true
	@echo "✅ Cleaned"

update:
	@echo "🔄 Updating all projects..."
	@for dir in raven-ai hermes-edge home-for-ai openclinical-ai; do \
		if [ -d "$$dir" ]; then \
			echo "  Updating $$dir..."; \
			cd $$dir && git pull && cd ..; \
		fi; \
	done
	@echo "✅ All projects updated"

status:
	@echo "📊 Git status for all projects:"
	@for dir in raven-ai hermes-edge home-for-ai openclinical-ai; do \
		if [ -d "$$dir" ]; then \
			echo ""; \
			echo "=== $$dir ==="; \
			cd $$dir && git status --short && cd ..; \
		fi; \
	done

# Paper
paper:
	@echo "📄 Opening scientific paper..."
	@xdg-open "https://github.com/simpliibarrii-crypto/simpliibarrii-crypto/blob/main/PAPER.md" 2>/dev/null || open "https://github.com/simpliibarrii-crypto/simpliibarrii-crypto/blob/main/PAPER.md" 2>/dev/null || echo "View: https://github.com/simpliibarrii-crypto/simpliibarrii-crypto/blob/main/PAPER.md"

# Deploy profile site
deploy-site:
	@echo "🚀 Deploying profile site to GitHub Pages..."
	@cd simpliibarrii-crypto.github.io && git add . && git commit -m "Update profile site" && git push origin main
	@echo "✅ Deployed to https://simpliibarrii-crypto.github.io"