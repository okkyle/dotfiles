#########
# Utils #
#########

print_error() {
  printf "\033[31m    [×] $1\033[m\n"
}

print_success() {
  printf "\033[32m    [✓] $1\033[m\n"
}

print_warning() {
  printf "\033[33m    [!] $1\033[m\n"
}

print_title() {
  printf "\n\n\033[35m$1\033[m\n\n"
}

print_message() {
  printf "    $1\n"
}

print_info() {
  printf "\033[34m    [i] $1\033[m\n"
}

# is_exists returns true if executable $1 exsts in $PATH
is_exists() {
  which "$1" >/dev/null 2>&1
  return $?
}
