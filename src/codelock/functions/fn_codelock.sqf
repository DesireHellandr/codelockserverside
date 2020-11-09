(_this select 3) params [["_password", 1234567890], ["_objectname", false], ["_ok", "<t size='1.3' color='#7fbf7f'>Дверь открылась</t>"], ["_reject", "<t size='1.3' color='#ff4040'>В доступе отказано</t>"]];
// h = [] spawn {
	missionNamespace setVariable ['LS_pswd_data', [_password, _objectname, _ok, _reject]];
	waitUntil {!isNull findDisplay 46};
	disableSerialization;
	_display = (findDisplay 46) createDisplay "RscDisplayEmpty";
	_ctrlEdit = _display ctrlCreate ["RscEdit", 19998];
	private _width = 30 / 108*safeZoneH /(4/3);
	private _height = 4/ 108*safeZoneH;
	private _bufferY = 15 / 108*safeZoneH;
	private _bufferX = ((safeZoneW / 2) - (_width / 2));
	_ctrlEdit ctrlSetPosition [safeZoneX + _bufferX, safeZoneY + safeZoneH - _bufferY, _width, _height];
	_ctrlEdit ctrlSetBackgroundColor [0,0,0,1];
	_ctrlEdit ctrlCommit 0;
	_ctrlEdit ctrlAddEventHandler ["KeyUp", {
		params ["_ctrl", "_key"];
		(missionNamespace getVariable ['LS_pswd_data', []]) params ["_password", "_objectname", "_ok", "_reject"];
		diag_log text format ["%1", [_password, _objectname, (isNil _objectname)]];
		_text = (ctrlText _ctrl);
		_isValid = !(parseNumber _text isEqualTo 0) || (count (_text splitString "0123456789.-") isEqualTo 0);

		if (_isValid) then {
			_number = parseNumber _text;
			if (_number isEqualTo _password) then {
				if (isNil _objectname) exitWith {hint "Связь потеряна";};
				_objectname = missionNamespace getVariable _objectname;
				player setPosATL (getPosATL _objectname);
				hintSilent "";
				(ctrlParent _ctrl) closeDisplay 1;
				titleText [_ok, "BLACK FADED", 0.2, true, true];
			} 
			else {
				if (_number isEqualTo 0) then {
				hint parseText "<t size='1.3'>Введите пароль</t>";
				}
				else {
				hint parseText _reject;
				};
			};
		};
	}];
	ctrlSetFocus _ctrlEdit;
	sleep 15;
	hintSilent "";
// };