-- audio.lua 

function LOAD_AUDIO()
	Audio = {
		__call = function (self, entity)
			local audio = {
				_entity = nil,
				_config = nil,
				_path = '',
				_repeat_count = 0,
				_delay = 0,
				_on_complete = nil,
				_audio_id = -1,

				start = function(self)
					local audio_id = self._entity:play_audio(self._path, self._repeat_count, self._delay)
					ARLOG(' ----------- 系统 play_audio 调用 -------------- ')
					if (self._on_complete ~= nil) then
						if type(self._on_complete) == 'string' then
							local lua_handler = self._entity.lua_handler
							local handler_id = lua_handler:register_handle(self._on_complete)
							self._entity:set_action_completion_handler(audio_id, handler_id)
						end
						if type(self._on_complete) == 'function' then
							local lua_handler = self._entity.lua_handler
							local RANDOM_NAME = RES_CLOSURE(self._on_complete)
							local handler_id = lua_handler:register_handle(RANDOM_NAME)
							self._entity:set_action_completion_handler(audio_id, handler_id)	
						end
					end
					self._audio_id = audio_id

					return self
				end,


				pause = function(self)
					self._entity:pause_action(self._audio_id)
					ARLOG(' ------------ 系统 pause_action(audio) 调用 -------------- ')
					return self

				end,



				resume = function(self)
					self._entity:resume_action(self._audio_id)
					ARLOG(' ------------ 系统 resume_action(audio) 调用 -------------- ')
					return self

				end,




				stop = function(self)
					self._entity:stop_action(self._audio_id)
					ARLOG(' ------------ 系统 stop_action(audio) 调用 -------------- ')
					return self

				end,


				path = function (self,string)
					self._path = string
					return self
				end,

				repeat_count = function (self,count)
					self._repeat_count = count
					return self
				end,

				delay = function (self,value)
					self._delay = delay
					return self
				end,

				on_complete = function(self, handler)
					self._on_complete = handler
					return self
				end

				
			}
			audio._entity = entity
			return audio
		end
	}
	setmetatable(Audio,Audio)
	ARLOG('load audio')
end

LOAD_AUDIO()

-- audio.lua end



