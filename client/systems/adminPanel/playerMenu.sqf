//	@file Version: 1.0
//	@file Name: playerMenu.sqf
//	@file Author: [404] Deadbeat
//	@file Created: 20/11/2012 05:19
//	@file Args:

#define playerMenuDialog 55500
#define playerMenuPlayerList 55505
                
disableSerialization;
				
private ["_start","_dialog","_playerListBox","_decimalPlaces","_health","_namestr","_index","_punishCount","_side"];
_uid = getPlayerUID player;
if ((_uid in moderators) OR (_uid in administrators) OR (_uid in serverAdministrators)) then {
	_start = createDialog "PlayersMenu";
	_punishCount = 0;
    _lockedSide = "None";		
	_dialog = findDisplay playerMenuDialog;
	_playerListBox = _dialog displayCtrl playerMenuPlayerList;
	                
	{
        _uid = getPlayerUID _x;
        {if((_x select 0) == _uid) then {_punishCount = (_x select 1);};}forEach pvar_teamKillList;
        {if((_x select 0) == _uid) then {if(_x select 1 == WEST) then {_lockedSide = "Blufor";};if(_x select 1 == EAST) then {_lockedSide = "Opfor";};};}forEach pvar_teamSwitchList;
        if(side _x == west) then {_side = "Blufor";};
        if(side _x == east) then {_side = "Opfor";};
        if(side _x == resistance) then {_side = "Indep";};
		_namestr = name(_x) + " [UID:" + getplayerUID(_x) + "] [Side:" + format["%1",_side] + "] [Team Lock:"+format["%1",_lockedSide]+"] [Punish Count:" + format["%1",_punishCount]+ "]";             
		_index = _playerListBox lbAdd _namestr;
		_playerListBox lbSetData [_index, str(_x)];
        _punishCount = 0;   
	} forEach playableUnits;
};  
