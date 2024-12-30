//
// Created by MateuszAndruszkiewic on 18.12.2024.
//

#include "beauty_print.h"
#include <iostream>

#define COLOR_GREEN "\033[32m"
#define COLOR_RED "\033[31m"
#define COLOR_YELLOW "\033[33m"
#define COLOR_BLUE "\033[34m"
#define COLOR_RESET "\033[0m"

void printError(const std::string& message) {
    std::cout << COLOR_RED << " (X) " << COLOR_RESET << message << std::endl;
}

void printSuccess(const std::string& message) {
    std::cout << COLOR_GREEN << " (+) " << COLOR_RESET << message << std::endl;
}

void printInfo(const std::string& message) {
    std::cout << COLOR_BLUE << " (#) " << COLOR_RESET << message << std::endl;
}

void printWarning(const std::string& message) {
    std::cout << COLOR_YELLOW << " (!) " << COLOR_RESET << message << std::endl;
}