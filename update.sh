command -v docker >/dev/null 2>&1 || { echo >&2 "'docker' is required but not installed. See https://github.com/liberdus/validator-dashboard?tab=readme-ov-file#how-to-install-and-run-a-liberdus-validator-node for details."; exit 1; }
if command -v docker-compose &>/dev/null; then
  echo "docker-compose is installed on this machine"
elif docker --help | grep -q "compose"; then
  echo "docker compose subcommand is installed on this machine"
else
  echo "docker-compose or docker compose is not installed on this machine"
  exit 1
fi

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

echo "Updating validator image and rebuilding docker..."
./docker-down.sh
echo "Clearing validator images..."
./cleanup.sh
echo "Updating local repo..."
git pull origin main
echo "Rebuilding local validator image..."
docker-safe build --no-cache -t local-dashboard -f Dockerfile --build-arg RUNDASHBOARD=y .
./docker-up.sh
echo "Starting image. This could take a while..."
(docker-safe logs -f liberdus-dashboard &) | grep -q 'done'
