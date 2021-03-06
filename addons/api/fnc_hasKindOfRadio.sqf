#include "script_component.hpp"
/*
 * Author: ACRE2Team
 * Checks whether the provided unit has a radio of the specified radio type in their inventory.
 *
 * Arguments:
 * 0: Unit or array of item classnames <OBJECT, ARRAY>
 * 1: Radio base type <STRING>
 *
 * Return Value:
 * Has kind of radio <BOOLEAN>
 *
 * Example:
 * _hasRadio = [player, "ACRE_PRC148"] call acre_api_fnc_hasKindOfRadio
 *
 * Public: Yes
 */

params [
    ["_weaponArray", objNull, [objNull, []]],
    ["_type", "", [""]]
];

if (_type isEqualTo "") exitWith {false};

_type = toLower _type;

if (IS_OBJECT(_weaponArray)) then {
    _weaponArray = [_weaponArray] call EFUNC(sys_core,getGear);
};

private _ret = false;
if (_type in _weaponArray) then {
    _ret = true;
} else {
    {
        private _weapon = _x;
        _ret = [_weapon, _type] call FUNC(isKindOf);
        if (_ret) exitWith { };
    } foreach _weaponArray;
};

_ret
