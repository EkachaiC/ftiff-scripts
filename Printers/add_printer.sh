#!/usr/bin/env bash
#
# Installs two printers, using Xerox Drivers (Xerox_Print_Driver_3.52.0.pkg)
# Will use Kerberos and A4 default papersize

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace



readonly LPSTAT='/usr/bin/lpstat'
readonly LPADMIN='/usr/sbin/lpadmin'
readonly CUPSENABLE='/usr/sbin/cupsenable'
readonly CUPSACCEPT='/usr/sbin/cupsaccept'

readonly E_CANT_ADD=1
readonly E_PARAMETER=2
readonly W_ALREADY_EXISTS=3


#######################################
# Add printers using cups
# Globals:
#   LPSTAT
#   LPADMIN
#   CUPSENABLE
#   CUPSACCEPT
# Arguments:
#   name (name of printer, should contain only "[^a-zA-Z0-9_]")
#   uri (use smb://printserver/queue)
#   ppd (PostScript Printer Description file)
# Returns:
#   None
#######################################

add_printer() {

  local name="$1"
  local uri="$2"
  local ppd="$3"

  if [[ ${name} =~ [^a-zA-Z0-9_] ]] ; then
    echo "ERROR: \"${name}\" should contain only [^a-zA-Z0-9_]" >&2
    return ${E_PARAMETER}
  fi

  # Test if printer already exists
  if (! ${LPSTAT} -v "${name}"); then

    # Add printer
    if ! ${LPADMIN} -E -p "${name}" \
      -v "${uri}" \
      -P "${ppd}" \
      -o printer_is_shared=false \
      -o auth-info-required=negotiate \
      -o media=iso_a4_210x297mm; then
        echo "ERROR: ${name}: Unable to lpadmin (add printer)." >&2
        return ${E_CANT_ADD}
    fi

    # Accept jobs sent to this destination
    if ! ${CUPSACCEPT} "${name}"; then
      echo "ERROR: ${name}: Unable to cupsaccept." >&2
      return ${E_CANT_ADD}
    fi

    # Start printers and classes
    if ! ${CUPSENABLE} "${name}"; then
      echo "ERROR: ${name}: Unable to cupsenable." >&2
      return ${E_CANT_ADD}
    fi

    return 0

  else 
    echo "Printer ${name} already exists"
    return ${W_ALREADY_EXISTS}
  fi
}

# Example: 
#
# 
#
add_printer "My_Printer" \
            "smb://printserver/queue" \
            "/Library/Printers/PPDs/Contents/Resources/Xerox WC 7545.gz"


exit 0
