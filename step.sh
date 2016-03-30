#!/bin/bash

# exit if a command fails
set -e

#
# Required parameters
if [ -z "${manifest_file}" ] ; then
  echo " [!] Missing required input: manifest_file"
  exit 1
fi
if [ ! -f "${manifest_file}" ] ; then
  echo " [!] File doesn't exist at specified AndroidManifest.xml path: ${manifest_file}"
  exit 1
fi

if [ -z "${package_name}" ] ; then
  echo " [!] No package_name specified!"
  exit 1
fi

# ---------------------
# --- Configs:

echo " (i) Provided Android Manifest path: ${manifest_file}"
echo " (i) Package Name: ${package_name}"


PACKAGENAME=`grep package ${manifest_file} | sed 's/.*package\s*=\s*\"\([^\"]*\)\".*/\1/g'`

if [ -z "${PACKAGENAME}" ] ; then
  echo " [!] Could not find package name!"
  exit 1
fi
echo "Package name detected: ${PACKAGENAME}"


# ---------------------
# --- Main:

# verbose / debug print commands

set -v

# ---- Set Package Name:

sed -i.bak "s/package="\"${PACKAGENAME}\""/package="\"${package_name}\""/" ${manifest_file}


# ---- Remove backup:

rm -f ${manifest_file}.bak

# ==> Build Version changed