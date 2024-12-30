//
// Created by MateuszAndruszkiewic on 17.12.2024.
//

#include "util.h"
#include "lib/beauty_print.h"
#include <cstdlib>

void checkAndInstallChocolatey() {
    printInfo("Checking for Chocolatey...");
    if (system("choco -v") != 0) {
        printError("Chocolatey is not installed. Installing Chocolatey...");
        system("Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))");
    } else {
        printSuccess("Chocolatey is already installed.");
    }
}

void configureDocker() {
    printInfo("Configuring Docker for the first run...");
    checkAndInstallChocolatey();
    if (system("docker --version") != 0) {
        printError("Docker is not installed. Installing Docker...");
        system("choco install docker-desktop -y");
    } else {
        printSuccess("Docker is already installed.");
    }
    printSuccess("Docker configuration completed.");
}

void installNmap() {
    printInfo("Installing Nmap...");
    checkAndInstallChocolatey();
    system("choco install nmap --version=7.40 -y");
    printSuccess("Nmap installation completed.");
}

void configureXampp() {
    printInfo("Configuring XAMPP...");
    checkAndInstallChocolatey();
    if (system("xampp --version") != 0) {
        printError("XAMPP is not installed. Installing XAMPP...");
        system("choco install xampp -y");
    } else {
        printSuccess("XAMPP is already installed.");
    }
    std::string xamppPath = "C:\\xampp";
    for (int i = 0; i <= 777; ++i) {
        std::string pathIni = xamppPath + (i == 0 ? "" : std::to_string(i)) + "\\xampp-control.ini";
        std::string pathLog = xamppPath + (i == 0 ? "" : std::to_string(i)) + "\\xampp-control.log";
        if (remove(pathIni.c_str()) == 0) {
            printSuccess("Removed: " + pathIni);
        } else {
            printInfo("No file: " + pathIni);
        }
        if (remove(pathLog.c_str()) == 0) {
            printSuccess("Removed: " + pathLog);
        } else {
            printInfo("No file: " + pathLog);
        }
    }
    printSuccess("XAMPP configuration completed.");
}