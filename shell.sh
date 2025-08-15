#!/usr/bin/env bash

# Function to detect if sudo is needed for docker commands
detect_docker_sudo() {
  # Check if docker command exists
  if ! command -v docker &>/dev/null; then
    echo "Docker is not installed"
    return 1
  fi
  
  # Try running docker without sudo first
  if docker info >/dev/null 2>&1; then
    USE_SUDO=""
  else
    # Check if docker works with sudo
    if sudo docker info >/dev/null 2>&1; then
      USE_SUDO="sudo"
    else
      echo "Docker is not accessible even with sudo"
      return 1
    fi
  fi
  return 0
}

# Detect sudo requirements
detect_docker_sudo

docker-safe() {
  if ! command -v docker &>/dev/null; then
    echo "docker is not installed on this machine"
    exit 1
  fi

  if [ -z "$USE_SUDO" ]; then
    docker $@
  else
    sudo docker $@
  fi
}

docker-safe exec -it liberdus-dashboard /bin/bash