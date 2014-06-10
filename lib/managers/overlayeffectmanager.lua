core:import("CoreOverlayEffectManager")
OverlayEffectManager = OverlayEffectManager or class(CoreOverlayEffectManager.OverlayEffectManager)
function OverlayEffectManager:init()
	OverlayEffectManager.super.init(self)
	local (for generator), (for state), (for control) = pairs(tweak_data.overlay_effects)
	do
		do break end
		self:add_preset(name, setting)
	end

end

CoreClass.override_class(CoreOverlayEffectManager.OverlayEffectManager, OverlayEffectManager)
