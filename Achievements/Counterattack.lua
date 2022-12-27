local _G = _G
local _achievement = CreateFrame("Frame")
_G.passive_achievements.Counterattack = _achievement

-- General info
_achievement.name = "Counterattack"
_achievement.title = "Counterattack!"
_achievement.class = "All"
_achievement.icon_path = "Interface\\Addons\\Hardcore\\Media\\icon_counterattack.blp"
_achievement.level_cap = 20
_achievement.quest_num = 4021
_achievement.description =
	"Complete |cffffff00Counterattack!|r before reaching level " .. _achievement.level_cap .. "."
_achievement.restricted_game_versions = {
	["WotLK"] = 1,
}

-- Registers
function _achievement:Register(succeed_function_executor)
	_achievement:RegisterEvent("QUEST_TURNED_IN")
	_achievement.succeed_function_executor = succeed_function_executor 
end

function _achievement:Unregister()
	_achievement:UnregisterEvent("QUEST_TURNED_IN")
end

-- Register Definitions
_achievement:SetScript("OnEvent", function(self, event, ...)
	local arg = { ... }
	if event == "QUEST_TURNED_IN" then
		if arg[1] == _achievement.quest_num and UnitLevel("player") <= _achievement.level_cap then
			Hardcore:Print("Congrats! You have achieved " .. _achievement.title)
			_achievement.succeed_function_executor.Succeed(_achievement.name)
		end
	end
end)