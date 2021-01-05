waituntil {!isNil 'lt_camo_var'};

if (hasInterface) then {

	_rangerCamoArray = ["ML700_Skitarii_Uniform","ML700_Skitarii_Ranger_Armor","ML700_Skitarii_Rucksack","ML700_Skitarii_Ranger_Helmet","None"];
	_priestCamoArray = ["U_TIOW_Priest","TIOW_Priest_Gear","None","TIOW_Priest_Hood","None"];
	_sistersCamoArray = ["ML700_SoB_Uniform1","ML700_SoB_Armor0","ML700_SoB_Backpack","ML700_SoB_Helmet1","None"];
	_sistersMedicArray = ["ML700_SoB_Uniform1","ML700_SoB_Armor2","ML700_SoB_Hospitaller_Backpack","ML700_SoB_Helmet3","None"];

	_lt_smarine_camo_var_array = call compile LT_Camo_var_SMARINE;
	_lt_camo_var_array = switch (side player) do {
		case WEST: {call compile lt_camo_var};
		case EAST: {if (isNil "LT_Camo_var_OPF") then {call compile lt_camo_var} else {call compile LT_Camo_var_OPF};};
		case resistance: {if (isNil "LT_Camo_var_GUER") then {call compile lt_camo_var} else {call compile LT_Camo_var_GUER};};
		case civilian: {};
		default {call compile lt_camo_var};
	};
	_exclude = player getVariable ["LT_camo_exclude", 0];

	diag_log format ["LT template DEBUG: lt_camo_var compiled: %1", _lt_camo_var_array];

	_officerGear_array	= _lt_camo_var_array select 5;
	_commisarGear_array	= _lt_camo_var_array select 6;
	_smarineSergeant_array	= _lt_smarine_camo_var_array select 4;

	_role = player getVariable ["lt_unit_role","none"];

	switch (_role) do {
    case "co";
    case "coplas": {
			_camo = _officerGear_array select 0;
			_vest = _officerGear_array select 1;
			_pack = _officerGear_array select 2;
			_helm = _officerGear_array select 3;
			_mask = _officerGear_array select 4;
		};
    case "com";
    case "complas": {
			_camo = _officerGear_array select 0;
			_vest = _officerGear_array select 1;
			_pack = _officerGear_array select 2;
			_helm = _officerGear_array select 3;
			_mask = _officerGear_array select 4;
		};
    case "pri": {
			_camo = _priestCamoArray select 0;
			_vest = _priestCamoArray select 1;
			_pack = _priestCamoArray select 2;
			_helm = _priestCamoArray select 3;
			_mask = _lt_camo_var_array select 5;
		};
    case "ranger";
    case "rangerAT": {
			_camo = _rangerCamoArray select 0;
			_vest = _rangerCamoArray select 1;
			_pack = _rangerCamoArray select 2;
			_helm = _rangerCamoArray select 3;
			_mask = _rangerCamoArray select 4;
		};
    case "sister": {
			_camo = _sistersCamoArray select 0;
			_vest = _sistersCamoArray select 1;
			_pack = _sistersCamoArray select 2;
			_helm = _sistersCamoArray select 3;
			_mask = _sistersCamoArray select 4;
		};
    case "sisterMedic": {
			_camo = _sistersMedicArray select 0;
			_vest = _sistersMedicArray select 1;
			_pack = _sistersMedicArray select 2;
			_helm = _sistersMedicArray select 3;
			_mask = _sistersMedicArray select 4;
		};
    case "smarine";
    case "smarineHeavy";
    case "smarineMelta";
    case "smarineFlameth": {
			_camo = _lt_smarine_camo_var_array select 0;
			_vest = _lt_smarine_camo_var_array select 1;
			_pack = _lt_smarine_camo_var_array select 2;
			_helm = _lt_smarine_camo_var_array select 3;
			_mask = "";
		};
    case "smarineSergeant": {
			_camo = _smarineSergeant_array select 0;
			_vest = _smarineSergeant_array select 1;
			_pack = _smarineSergeant_array select 2;
			_helm = _smarineSergeant_array select 3;
			_mask = "";
		};
    default {
			_camo	= _lt_camo_var_array select 0;
			_vest	= _lt_camo_var_array select 1;
			_pack	= _lt_camo_var_array select 2;
			_helm	= _lt_camo_var_array select 3;
			_mask = _lt_camo_var_array select 5;
		};
	};

	diag_log format ["LT template DEBUG: lt_camo_var: %1", lt_camo_var];

	diag_log format ["LT Template DEBUG: Exclude: %1", _exclude];


	if (_exclude == 0) then {
	diag_log format ["LT Template DEBUG: Camo: %1 *-* Vest: %2 *-* Pack: %3 *-* Helm: %4", _camo, _vest, _pack, _helm];
		if (typename _camo == "ARRAY") then {

			diag_log format ["LT Template DEBUG: _camo: %1 *-* _exclude: %2", _camo, _exclude];

			removeHeadgear player;
			_CamoUniform 	= if (typename _camo == "ARRAY") then {[player, selectRandom _camo] call lt_fnc_changeUniform;} else {[player, _camo] call lt_fnc_changeUniform;};
			_CamoVest 	  = if (typename _vest == "ARRAY") then {[player, selectRandom _vest] call lt_fnc_changeVest;} else {[player, _vest] call lt_fnc_changeVest;};
			_CamoBackpack = if (typename _pack == "ARRAY") then {[player, selectRandom _pack] call lt_fnc_changeBackpack;} else {[player, _pack] call lt_fnc_changeBackpack;};
			if (typename _helm == "ARRAY") then {player addHeadgear selectRandom _helm;} else {player addHeadGear _helm};
			if (typename _mask == "ARRAY") then {player addGoggles selectRandom _mask;} else {player addGoggles _mask};
			diag_log format ["LT Template DEBUG: Camo functions have been finished. Uniform: %1 *-* Vest: %2 *-* Backpack: %3", _CamoUniform,_CamoVest,_CamoBackpack];
		} else {
			if (_camo != "None") then {

				diag_log format ["LT Template DEBUG: _camo: %1 *-* _exclude: %2", _camo, _exclude];

				removeHeadgear player;
				_CamoUniform 	= if (typename _camo == "ARRAY") then {[player, selectRandom _camo] call lt_fnc_changeUniform;} else {[player, _camo] call lt_fnc_changeUniform;};
				_CamoVest 	  = if (typename _vest == "ARRAY") then {[player, selectRandom _vest] call lt_fnc_changeVest;} else {[player, _vest] call lt_fnc_changeVest;};
				_CamoBackpack = if (typename _pack == "ARRAY") then {[player, selectRandom _pack] call lt_fnc_changeBackpack;} else {[player, _pack] call lt_fnc_changeBackpack;};
				if (typename _helm == "ARRAY") then {player addHeadgear selectRandom _helm;} else {player addHeadGear _helm};
				if (typename _mask == "ARRAY") then {player addGoggles selectRandom _mask;} else {player addGoggles _mask};
				diag_log format ["LT Template DEBUG: Camo functions have been finished. Uniform: %1 *-* Vest: %2 *-* Backpack: %3", _CamoUniform,_CamoVest,_CamoBackpack];
			};
		};
	};
};
