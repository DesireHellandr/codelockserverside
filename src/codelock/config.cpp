class CfgPatches
{
	class LS_CODELOCK
	{
		requiredaddons[] = {};
		requiredversion = 1.9;
		units[] = {};
		weapons[] = {};
		magazines[] = {};
	};
};

class CfgFunctions
{
	class LSTest
	{
		class Functions
		{
			file = "codelock\functions";
			class preInit {preInit = 1;};
		};
	};
};