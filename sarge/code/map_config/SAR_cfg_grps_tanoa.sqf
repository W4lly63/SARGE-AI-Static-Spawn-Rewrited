// =========================================================================================================
//  Sarge's AI System: - DayZ AI library
//  Version: 1.5.0 
//  Author: Sarge (sarge@krumeich.ch) 
//  Edited by W4lly63	
//		Wiki: to come
//		Forum: to come
//	    
// ---------------------------------------------------------------------------------------------------------
//  Required:
//  UPSMon  
//  SHK_pos 
//  
// ---------------------------------------------------------------------------------------------------------
//   area, group & spawn  cfg file for Tanoa
//   last modified: 06 . 10 .2016
// ---------------------------------------------------------------------------------------------------------

_type = _this select 0;

if (_type == "static") then {

private["_markerArray","_k","_heliSpawnArray","_kk","_kkk","_groupAction","_infantrySpawnArray","_yy","_yyy","_vehPatrolArray","_vehPatrolDef","_xx","_xxx"];

////////////////////////////////////////settings/////////////////////////////////////////////////////////////////////////////
///////////////ATTENTION!!! _markerArray , _heliSpawnArray , _infantrySpawnArray , _vehPatrolDef   MUST BE WITH SAME NUMBERS OF ELEMENTS!!! ///////////////////////////

//////////////////MARKER ZONE SPAWN     Name , coords ,W and H  ////////////////////

_markerArray =[                     [ "SAR_marker_helipatrol_1",          [10975.4, 8872.47] , [6500, 2200]],
                                    [ "SAR_marker_helipatrol_2",          [7484.52,9047.01] ,  [2200, 6500]], 
				    [ "SAR_marker_helipatrol_3",          [8570.58,10967] ,    [2200, 6500]], 
				    [ "SAR_marker_helipatrol_4",          [10684.5,10908.8] ,  [6200, 3000]], 
				    [ "SAR_marker_DEBUG_Inf_1",           [11445.1,2777.09] ,  [500, 500]],
				    [ "SAR_marker_DEBUG_Inf_2",           [9498.84,3882.99] ,  [500, 500]],
				    [ "SAR_marker_DEBUG_Inf_3",           [9031.04,4657.61] ,  [500, 500]],
				    [ "SAR_marker_DEBUG_Patrol_1",        [10975.4, 8872.47] , [4000, 3000]],
				    [ "SAR_marker_DEBUG_Patrol_2",        [7484.52,9047.01] , [3000, 4000]],
				    [ "SAR_marker_DEBUG_Patrol_3",        [8570.58,10967] , [3000, 4000]],
				    [ "SAR_marker_DEBUG_Patrol_4",        [10684.5,10908.8] , [4000, 3000]] ];  //Marker name (need all different names)) , marker position x y, marker size (half W,H)
									
////////////// HELI SETTINGS   Heli number,type of group, respawn, respawn time/////////									
				
_heliSpawnArray = [                 [1,1,true,60],
                                    [1,1,true,60],
				    [1,1,true,60],
				    [1,1,true,60],
				    [0,1,true,60],
				    [0,1,true,60],
				    [0,1,true,60],
				    [0,1,true,60],
				    [0,1,true,60],
				    [0,1,true,60],
				    [0,1,true,60] ];  // number of heli spawn x marker ( array content elements number need to be equal of markers number!!!)	: heli spawn numb (0= no spawn), type( 1= soldier 2=civilian 3=bandits) (1,2,true,60) 1 heli civilian (2,1,true,60) 2 heli Soldiers, respawn (true or false) , respawn time
									
////////////// INFANTRY SETTINGS   Infantry Groups Number,type of group,umb sniper, numb rifleman,action,respawn,respawn time /////////////////////////										

_infantrySpawnArray = [             [0,0,0,0,"ambush",true,60],
                                    [0,0,0,0,"fortify",true,60],
			            [0,0,0,0,"fortify",true,60],
	                            [0,0,0,0,"fortify",true,60],
	                            [1,1,0,5,"patrol",true,60],
				    [1,1,0,5,"patrol",true,60],
			            [1,1,0,4,"patrol",true,60],
				    [0,1,0,9,"fortify",true,60],
				    [0,1,0,9,"fortify",true,60],
				    [0,1,0,9,"fortify",true,60],
				    [0,1,0,6,"patrol",true,60] ];  // number of infantry group ( array content elements number need to be equal of markers number!!!) : units  group numbers (0= no spawn),type ( 1= soldier 2=civilian 3=bandits), numb sniper, numb rifleman, action type ("ambush" "fortify" or "patrol"), respawn true or false, respawntime
									
////////////// VEHICLES PATROL SETTINGS   number of veh, type of group, leader numb,leader numb,sniper numb,rifleman numb,respawn,respawn time/////////////////////////										

									
_vehPatrolDef =[                    [0,1,1,2,2,true,60],
                                    [0,1,1,2,2,true,60],
				    [0,1,1,1,1,true,60],
				    [0,1,1,1,2,true,60],
				    [0,1,1,1,2,true,60],
				    [0,1,1,1,2,true,60],
				    [0,1,1,1,2,true,60],
			            [1,1,1,1,2,true,60],
	                            [1,1,1,1,2,true,60],
				    [1,1,1,2,2,true,60],
				    [1,1,1,2,2,true,60] ];// ( array content elements number need to be equal of markers number!!!) : number of veh patrol (0= no spawn), type of group ( 1= soldier 2=civilian 3=bandits), leader numb,sniper numb,rifleman numb,respawn true or false ,time respawn

									
_vehPatrolArray =[	
                                    ["Exile_Car_LandRover_Green"],
                                    ["Exile_Bike_QuadBike_Black"],
                                    ["Exile_Car_UAZ_Open_Green"], 
                                    ["Exile_Car_Hunter"],
                                    ["Exile_Car_HEMMT"],
                                    ["Exile_Car_Zamak"],
                                    ["Exile_Car_Offroad_Armed_Guerilla12"],
                                    ["Exile_Car_Offroad_Armed_Guerilla03"],
                                    ["Exile_Car_Tempest"] ];  // vehicles used x patrol 
									
///////////////////////////////////////////////////////////////////////////////////////////////////////////
// ---- end of configuration area ----

diag_log format["Sarge's AI System: Static spawning area definition started"];

for "_k" from 0 to ((count _markerArray) -1) do {
	_this = createMarker [((_markerArray select _k) select 0), ((_markerArray select _k) select 1)];
    _this setMarkerShape "RECTANGLE";
    _this setMarkeralpha 0;
    _this setMarkerType "Flag";
    _this setMarkerBrush "Solid";
    _this setMarkerSize ((_markerArray select _k) select 2);
missionNamespace setVariable [((_markerArray select _k) select 0),_this];
};

diag_log format["Sarge's AI System: Static spawning area definition finished"];


diag_log format["Sarge's AI System: Static Spawning for Helicopter patrols started"];


for "_kk" from 0 to ((count _markerArray) -1) do {
	if (((_heliSpawnArray select _kk) select 0) > 0) then {
        for "_kkk" from 0 to (((_heliSpawnArray select _kk)select 0)-1) do {
		    [(missionNamespace getVariable ((_markerArray select _kk) select 0)),((_heliSpawnArray select _kk)select 1),((_heliSpawnArray select _kk)select 2),((_heliSpawnArray select _kk)select 3)] call SAR_fnc_AI_heli;
	    };
	};
};

diag_log format["Sarge's AI System: Static Spawning for Helicopter patrols finished"];



diag_log format["Sarge's AI System: Static Spawning for infantry patrols started"];



for "_yy" from 0 to ((count _markerArray) -1) do {
	if (((_infantrySpawnArray select _yy) select 0) > 0) then {
        for "_yyy" from 0 to (((_infantrySpawnArray select _yy) select 0) -1) do {
		    [(missionNamespace getVariable ((_markerArray select _yy) select 0)),((_infantrySpawnArray select _yy) select 1),((_infantrySpawnArray select _yy) select 2),((_infantrySpawnArray select _yy) select 3), ((_infantrySpawnArray select _yy) select 4),((_infantrySpawnArray select _yy) select 5),((_infantrySpawnArray select _yy) select 6)] call SAR_fnc_AI_infantry;
	    };
	};
};

diag_log format["Sarge's AI System: Static Spawning for infantry patrols finished"];


diag_log format["Sarge's AI System: Static Spawning for vehicle patrols started"];



////////////////////////////////////////////////////////////////////////////////////////////////
for "_xx" from 0 to ((count _markerArray) -1) do {
	if (((_vehPatrolDef select _xx) select 0) > 0) then {
        for "_xxx" from 0 to (((_vehPatrolDef select _xx) select 0) -1) do {
		    [(missionNamespace getVariable ((_markerArray select _xx) select 0)),((_vehPatrolDef select _xx) select 1),(_vehPatrolArray call  BIS_fnc_selectRandom),[[((_vehPatrolDef select _xx) select 2),((_vehPatrolDef select _xx) select 3), ((_vehPatrolDef select _xx) select 4)]],((_vehPatrolDef select _xx) select 5),((_vehPatrolDef select _xx) select 6)] call SAR_fnc_AI_vehicle;
	    };
	};
};									
};
diag_log format["Sarge's AI System: Static Spawning for vehicle patrols finished"];

/*
	Tanoa coords possibile spawn point can be used first 2 coords x,y    .......
	[[11445.1,2777.09,14.9027],],
	[[9498.84,3882.99,6.99544],],
	[[9031.04,4657.61,14.6991],],
	[[10353.7,5018.35,17.8903],],
	[[11359.1,5178.95,8.85151],],
	[[12661.5,4695.4,16.472],],
	[[13273.9,2971.61,48.3899],],
	[[6981.08,4253.08,27.2753],],
	[[5885.68,4274.23,2.70322],],
	[[3649.86,2183.63,36.262],],
	[[3091.97,3291.75,27.6226],],
	[[2078.29,3479.49,12.95],],
	[[1202.48,2957.81,8.81037],],
	[[4641.4,5155.96,12.0174],],
	[[3395.46,6610.2,16.5717],],
	[[1729.14,6220.22,2.67962],],
	[[2555.56,7319.17,15.1961],],
	[[1076.57,7692.57,6.75743],],
	[[2267.02,8191.89,6.79715],],
	[[2679.53,9215.02,7.60189],],
	[[3147.7,11311.2,20.7343],],
	[[1929.23,12087.6,18.6113],],
	[[2165.62,13151.4,12.5956],],
	[[3840.31,13898,7.10656],],
	[[11584.7,12951.2,32.6357],],
	[[10619.3,13256.7,57.6429],],
	[[9572.67,13192.2,46.0847],],
	[[6637.53,12877.3,4.34075],],
	[[5749.84,11373.4,26.3095],],
	[[6317.2,10510.2,64.9575],],
	[[5041.32,9918.39,4.5397],],
	[[7309.17,8443.18,7.81665],],
	[[7257.21,7746.83,2.77916],],
	[[5073.59,8860.6,2.79584],],
	[[11091.3,9672.76,108.518],],
	[[12833.7,7647.19,5.88306],],
	[[14130,8502.78,3.24],],
	[[13081.4,12090.9,13.5481],],
	[[14075.8,11850.1,21.9232],],
	[[11901.3,13076.3,6.95],],
	[[9998.9,13472.6,2.51255],],
	[[9345.84,13526,12.3382],],
	[[8639.14,10321.8,26.5633],],
	[[11453.9,12312.1,111.518],],
	[[6138.13,8677.26,33.6393],],
	[[11096.7,8046.77,117.692],],
	[[9224.12,8713.17,217.387],],
	
	[1[12867.9,540.979,-3.74005],],// center left right up down
	[2[2033.7,14487.3,50.5993],],
	[3[562.427,284.472,50.7873],],
	[4[8342.52,14720,50.6329],],
	
	[7653.68,7230.37,9.61621],
	[13334.6,11345.1,26.4877],
	[6172.32,12388.1,55.6247],
	[12736.8,8084.7,64.0777],
	[9491.71,9977.15,37.9962],
	[2302.6,3424.3,12.5232],
	[11015.1,3883.96,98.7938],
	
	[10975.4,8872.47,252.35],
	[7484.52,9047.01,67.0064],
	[8570.58,10967,76.7383],
	[10684.5,10908.8,252.091]
	*/
