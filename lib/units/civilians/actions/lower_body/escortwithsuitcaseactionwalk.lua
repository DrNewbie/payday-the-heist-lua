EscortWithSuitcaseActionWalk = EscortWithSuitcaseActionWalk or class(CopActionWalk)
EscortWithSuitcaseActionWalk._walk_anim_velocities = {
	stand = {
		run = {
			fwd = 138,
			bwd = 70,
			l = 93,
			r = 65
		}
	}
}
EscortWithSuitcaseActionWalk._walk_anim_lengths = {
	stand = {
		run = {
			fwd = 28,
			bwd = 32,
			l = 45,
			r = 39
		}
	}
}
do
	local (for generator), (for state), (for control) = pairs(EscortWithSuitcaseActionWalk._walk_anim_lengths)
	do
		do break end
		local (for generator), (for state), (for control) = pairs(speeds)
		do
			do break end
			local (for generator), (for state), (for control) = pairs(sides)
			do
				do break end
				sides[side] = speed * 0.03333
			end

		end

	end

end

EscortPrisonerActionWalk = EscortPrisonerActionWalk or class(CopActionWalk)
EscortPrisonerActionWalk._walk_anim_velocities = {
	stand = {
		run = {
			fwd = 329,
			bwd = 170,
			l = 170,
			r = 170
		}
	}
}
EscortPrisonerActionWalk._walk_anim_lengths = {
	stand = {
		run = {
			fwd = 22,
			bwd = 19,
			l = 25,
			r = 29
		}
	}
}
local (for generator), (for state), (for control) = pairs(EscortPrisonerActionWalk._walk_anim_lengths)
do
	do break end
	local (for generator), (for state), (for control) = pairs(speeds)
	do
		do break end
		local (for generator), (for state), (for control) = pairs(sides)
		do
			do break end
			sides[side] = speed * 0.03333
		end

	end

end

