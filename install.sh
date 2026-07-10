#!/usr/bin/env bash
# Unified installation script for the Raven AI ecosystem
# Usage: ./install.sh [project] [--dev|--docker|--demo]

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

PROJECTS=("raven-ai" "hermes-edge" "home-for-ai" "openclinical-ai" "all")
MODES=("dev" "docker" "demo")

PROJECT=""
MODE="dev"

show_help() {
    cat << EOF
Raven AI Ecosystem - Unified Installer

Usage: $0 [PROJECT] [MODE]

PROJECTS:
  raven-ai         Flagship agent platform (pip install)
  hermes-edge      GPU-first on-device agent (pip install -e)
  home-for-ai      Tauri desktop orchestration (npm + cargo)
  openclinical-ai  Clinical deployment layer (pip install)
  all              Install all projects

MODES:
  --dev     Development install (default)
  --docker  Pull/run Docker images
  --demo    Open Hugging Face Space demos in browser

EXAMPLES:
  $0 raven-ai --dev
  $0 hermes-edge --docker
  $0 all --dev
  $0 openclinical-ai --demo

EOF
}

log_info() { echo -e "${BLUE}[INFO]${NC} $*"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $*"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
log_error() { echo -e "${RED}[ERROR]${NC} $*"; }

install_raven_ai() {
    case "$MODE" in
        dev)
            log_info "Installing Raven AI (development)..."
            pip install raven-ai
            log_success "Raven AI installed. Run: raven serve --port 8000"
            ;;
        docker)
            log_info "Pulling Raven AI Docker image..."
            docker pull ghcr.io/simpliibarrii-crypto/raven-ai:latest
            log_success "Run: docker run -p 8000:8000 ghcr.io/simpliibarrii-crypto/raven-ai:latest"
            ;;
        demo)
            log_info "Opening Raven AI demo..."
            xdg-open "https://huggingface.co/spaces/bclermo/raven-ai" 2>/dev/null || open "https://huggingface.co/spaces/bclermo/raven-ai" 2>/dev/null || log_warn "Open https://huggingface.co/spaces/bclermo/raven-ai manually"
            ;;
    esac
}

install_hermes_edge() {
    case "$MODE" in
        dev)
            log_info "Installing Hermes Edge (development)..."
            if [ ! -d "hermes-edge" ]; then
                git clone https://github.com/simpliibarrii-crypto/hermes-edge.git
            fi
            cd hermes-edge
            pip install -e ".[runtime]"
            log_success "Hermes Edge installed. Run: hermes --model dist/hermes-mobile-270m-int4.litertlm --backend auto"
            cd ..
            ;;
        docker)
            log_info "Hermes Edge Docker not yet published. Use --dev mode."
            ;;
        demo)
            log_info "Opening Hermes Edge demo..."
            xdg-open "https://huggingface.co/spaces/bclermo/hermes-edge" 2>/dev/null || open "https://huggingface.co/spaces/bclermo/hermes-edge" 2>/dev/null || log_warn "Open https://huggingface.co/spaces/bclermo/hermes-edge manually"
            ;;
    esac
}

install_home_for_ai() {
    case "$MODE" in
        dev)
            log_info "Installing Home for AI (development)..."
            if [ ! -d "home-for-ai" ]; then
                git clone https://github.com/simpliibarrii-crypto/home-for-ai.git
            fi
            cd home-for-ai
            log_info "Installing frontend dependencies..."
            npm install
            log_info "Building Tauri app..."
            npm run tauri:build
            log_success "Home for AI built. Run: npm run tauri:dev"
            cd ..
            ;;
        docker)
            log_info "Building Home for AI Docker image..."
            if [ ! -d "home-for-ai" ]; then
                git clone https://github.com/simpliibarrii-crypto/home-for-ai.git
            fi
            cd home-for-ai
            docker build -t home-for-ai .
            log_success "Run: docker run home-for-ai"
            cd ..
            ;;
        demo)
            log_info "Opening Home for AI demo..."
            xdg-open "https://huggingface.co/spaces/bclermo/home-for-ai" 2>/dev/null || open "https://huggingface.co/spaces/bclermo/home-for-ai" 2>/dev/null || log_warn "Open https://huggingface.co/spaces/bclermo/home-for-ai manually"
            ;;
    esac
}

install_openclinical_ai() {
    case "$MODE" in
        dev)
            log_info "Installing OpenClinical AI (development)..."
            if [ ! -d "openclinical-ai" ]; then
                git clone https://github.com/simpliibarrii-crypto/openclinical-ai.git
            fi
            cd openclinical-ai
            python -m venv .venv
            source .venv/bin/activate
            pip install -e . pytest pynacl
            log_success "OpenClinical AI installed. Run: ./run_dev.sh"
            cd ..
            ;;
        docker)
            log_info "Pulling OpenClinical AI Docker image..."
            docker pull ghcr.io/simpliibarrii-crypto/openclinical-ai:latest
            log_success "Run: docker run -p 8088:8088 ghcr.io/simpliibarrii-crypto/openclinical-ai:latest"
            ;;
        demo)
            log_info "Opening OpenClinical AI demo..."
            xdg-open "https://huggingface.co/spaces/bclermo/openclinical-ai" 2>/dev/null || open "https://huggingface.co/spaces/bclermo/openclinical-ai" 2>/dev/null || log_warn "Open https://huggingface.co/spaces/bclermo/openclinical-ai manually"
            ;;
    esac
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        raven-ai|hermes-edge|home-for-ai|openclinical-ai|all)
            PROJECT="$1"
            shift
            ;;
        --dev|--docker|--demo)
            MODE="${1#--}"
            shift
            ;;
        *)
            log_error "Unknown argument: $1"
            show_help
            exit 1
            ;;
    esac
done

if [ -z "$PROJECT" ]; then
    log_error "No project specified"
    show_help
    exit 1
fi

# Validate mode
if [[ ! " ${MODES[@]} " =~ " ${MODE} " ]]; then
    log_error "Invalid mode: $MODE"
    show_help
    exit 1
fi

log_info "Installing $PROJECT in $MODE mode..."

case "$PROJECT" in
    raven-ai)
        install_raven_ai
        ;;
    hermes-edge)
        install_hermes_edge
        ;;
    home-for-ai)
        install_home_for_ai
        ;;
    openclinical-ai)
        install_openclinical_ai
        ;;
    all)
        install_raven_ai
        install_hermes_edge
        install_home_for_ai
        install_openclinical_ai
        log_success "All projects installed!"
        ;;
esac