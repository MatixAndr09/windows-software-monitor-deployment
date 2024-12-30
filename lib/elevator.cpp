//
// Created by MateuszAndruszkiewic on 30.12.2024.
//

#include "elevator.h"
#include <windows.h>
#include <shellapi.h>

bool IsRunningAsAdmin() {
    BOOL isAdmin = FALSE;
    PSID adminGroup = NULL;
    SID_IDENTIFIER_AUTHORITY ntAuthority = SECURITY_NT_AUTHORITY;

    if (AllocateAndInitializeSid(&ntAuthority, 2, SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0, &adminGroup)) {
        CheckTokenMembership(NULL, adminGroup, &isAdmin);
        FreeSid(adminGroup);
    }

    return isAdmin;
}

int RelaunchAsAdmin() {
    if (IsRunningAsAdmin()) {
        return 0;
    }

    SHELLEXECUTEINFO sei = { sizeof(SHELLEXECUTEINFO) };
    sei.lpVerb = "runas";
    sei.lpFile = GetCommandLineA();
    sei.nShow = SW_SHOWNORMAL;

    if (!ShellExecuteEx(&sei)) {
        return GetLastError();
    }

    return 0;
}