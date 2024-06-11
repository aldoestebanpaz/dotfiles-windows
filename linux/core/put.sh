put() {
  local YELLOW='\033[1;33m'
  local NC='\033[0m' # No Color
  printf "${YELLOW}$@${NC}\n"
}

err() {
  local YELLOW='\033[1;31m'
  local NC='\033[0m' # No Color
  printf "${YELLOW}$@${NC}\n"
}
