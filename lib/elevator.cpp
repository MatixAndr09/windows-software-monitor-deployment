//
// Created by MateuszAndruszkiewic on 30.12.2024.
//

#include "elevator.h"
#include <windows.h>
#include <shellapi.h>
#include <tchar.h>
#include <iostream>

bool IsRunningAsAdmin() {
    BOOL isAdmin    = FALSE;
    PSID adminGroup = nullptr;

    SID_IDENTIFIER_AUTHORITY ntAuthority = SECURITY_NT_AUTHORITY;
    if (AllocateAndInitializeSid(&ntAuthority,
                                 2,
                                 SECURITY_BUILTIN_DOMAIN_RID,
                                 DOMAIN_ALIAS_RID_ADMINS,
                                 0, 0, 0, 0, 0, 0,
                                 &adminGroup))
    {
        CheckTokenMembership(nullptr, adminGroup, &isAdmin);
        FreeSid(adminGroup);
    }

    return isAdmin;
}

int RelaunchAsAdmin() {
    TCHAR modulePath[MAX_PATH];
    if (GetModuleFileName(nullptr, modulePath, MAX_PATH)) {
        SHELLEXECUTEINFO sei = { sizeof(SHELLEXECUTEINFO) };
        sei.lpVerb   = _T("runas");
        sei.lpFile   = modulePath;
        sei.nShow    = SW_SHOWNORMAL;

        if (!ShellExecuteEx(&sei)) {
            DWORD error = GetLastError();
            if (error == ERROR_CANCELLED) {
                std::cerr << "Użytkownik anulował podniesienie uprawnień." << std::endl;
            } else {
                std::cerr << "Nie udało się uruchomić jako administrator. Kod błędu: " << error << std::endl;
            }
        }
    }
    return 0;
}

// Na początku IsRunningAsAdmin i jak zwróci false to RelaunchAsAdmin
