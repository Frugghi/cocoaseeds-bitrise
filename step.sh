#!/bin/bash

THIS_SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${THIS_SCRIPTDIR}/_bash_utils/utils.sh"
source "${THIS_SCRIPTDIR}/_bash_utils/formatted_output.sh"


if [ -z "${source_root_path}" ]; then
  write_section_to_formatted_output "# Error"
  write_section_start_to_formatted_output '* source_root_path input is missing'
  exit 1
fi
print_and_do_command_exit_on_error cd "${source_root_path}"

if [ ! -f "Seedfile" ]; then
  write_section_to_formatted_output "# Error"
  write_section_start_to_formatted_output '* Seedfile not found'
  exit 1
fi

seed_version=$(seed --version)
if [ $? -ne 0 ]; then
  write_section_start_to_formatted_output "# Installing CocoaSeeds"
  print_and_do_command_exit_on_error gem install cocoaseeds
  seed_version=$(seed --version)
  if [ $? -ne 0 ]; then
  	write_section_to_formatted_output "# Error"
  	write_section_start_to_formatted_output '* Failed to get current CocoaSeeds version'
  	exit 1
  fi
fi
write_section_start_to_formatted_output "## Current CocoaSeeds version"
write_section_start_to_formatted_output "    ${seed_version}"

write_section_to_formatted_output "# Run seed install"
print_and_do_command_exit_on_error seed install

exit 0
