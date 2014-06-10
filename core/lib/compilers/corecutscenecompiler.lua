require("core/lib/compilers/CoreCompilerSystem")
require("core/lib/compilers/CoreCutsceneOptimizer")
require("core/lib/utils/dev/tools/cutscene_editor/CoreCutsceneEditorProject")
require("core/lib/utils/dev/tools/cutscene_editor/CoreCutsceneFootage")
CoreCutsceneCompiler = CoreCutsceneCompiler or class()
function CoreCutsceneCompiler:compile(file, dest, force_recompile)
	if file.type ~= "cutscene" then
		return false
	end

	if not force_recompile and dest:up_to_date(file.path, "cutscene", file.name, file.properties) then
		dest:skip_update("cutscene", file.name, file.properties)
		return true
	end

	cat_print("spam", "Compiling " .. file.path)
	local project = assert(self:_load_project(file.path), string.format("Failed to load cutscene \"%s\".", file.path))
	local optimizer = self:_create_optimizer_for_project(project)
	if optimizer:is_valid() then
		front.optimizer:export_to_compile_destination(dest, file.name)
		front.optimizer:free_cached_animations()
	else
		local error_msg = string.format("Cutscene \"%s\" is invalid:", file.path)
		do
			local (for generator), (for state), (for control) = ipairs(optimizer:problems())
			do
				do break end
				error_msg = error_msg .. "\t" .. problem
			end

		end

		Application:error(error_msg)
	end

	return true
end

function CoreCutsceneCompiler:_load_project(path)
	if managers.database:has(path) then
		local project = CoreCutsceneEditorProject:new()
		project:set_path(path)
		return project
	end

	return nil
end

function CoreCutsceneCompiler:_create_optimizer_for_project(project)
	local optimizer = CoreCutsceneOptimizer:new()
	optimizer:set_compression_enabled("win32", project:export_type() == "in_game_use")
	local exported_clip_descriptors = table.find_all_values(project:film_clips(), function(clip)
		return clip.track_index == 1
	end
)
	do
		local (for generator), (for state), (for control) = ipairs(exported_clip_descriptors)
		do
			do break end
			local clip = self:_create_clip(clip_descriptor)
			optimizer:add_clip(clip)
		end

	end

	do
		local (for generator), (for state), (for control) = ipairs(project:cutscene_keys())
		do
			do break end
			optimizer:add_key(key)
		end

	end

	do
		local (for generator), (for state), (for control) = pairs(project:animation_patches())
		do
			do break end
			local (for generator), (for state), (for control) = pairs(patches or {})
			do
				do break end
				optimizer:add_animation_patch(unit_name, blend_set, animation)
			end

		end

	end

	return optimizer
end

function CoreCutsceneCompiler:_create_clip(clip_descriptor)
	local cutscene = managers.cutscene:get_cutscene(clip_descriptor.cutscene)
	local footage = assert(CoreCutsceneFootage:new(cutscene), "Cutscene \"" .. clip_descriptor.cutscene .. "\" does not exist.")
	local clip = footage:create_clip(clip_descriptor.from, clip_descriptor.to, clip_descriptor.camera)
	clip:offset_by(clip_descriptor.offset - clip_descriptor.from)
	return clip
end

