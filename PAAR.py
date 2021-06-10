import os
import csv

# Funcs for installing packages
def install_pac(pkg):
    os.system("sudo pacman --needed --noconfirm -S " + pkg)

def install_aur(pkg):
    os.system("yay --noconfirm -S " + pkg)

# Funcs for configuration
def move_config_file(source, dest):
    os.system("cp " + source + " " + dest)

# Package installation
with open('Packages.csv', mode='r') as pkgfile:
    packages = csv.reader(pkgfile)

    for package_entry in packages:
        if package_entry[0] == "A":
            install_aur(package_entry[1])
        elif package_entry[0] == "P":
            install_pac(package_entry[1])

# Move/Copy configuration files
with open('ConfigFiles.csv', mode='r') as conffile:
    config_files = csv.reader(conffile)

    for conf_entry in config_files:
        move_config_file(conf_entry[0], conf_entry[1])

# Move/Copy wallpapers
os.system("mkdir ~/.mystuff")
os.system("mkdir ~/.mystuff/wallpapers")
os.system("cp -r  ./wallpapers/ ~/.mystuff/wallpapers/")
