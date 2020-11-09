{
	_x params ["_function","_file"];
	_code = '';

	_fileContent = preprocessFileLineNumbers _file;

	if (_fileContent isEqualTo '') then
	{
		diag_log format ["Ошибка при компиляции %1",_function];
	};

	_code = compileFinal _fileContent;                    
	diag_log format ["Скомпилирован %1",_function];
	missionNamespace setVariable [_function, _code, true];
}
forEach 
[
	['LS_fnc_codelock', 'codelock\functions\fn_codelock.sqf'],

];