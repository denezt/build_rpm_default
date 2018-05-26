#!/bin/bash

# Install Prereqs for scripts.
zypper in rpm-build || dnf in rpm-build
zypper in pwgen || dnf in pwgen

