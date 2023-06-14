local splashCount = 0;
local OppSplash = 0;

local splashThing = '';

local sickTrack = 0;

local enableNewSystem = false; -- Toggles Psych Splashes or New Splashes On/Off

local texture = 'AuraSplashes';

local SplashVarient = 2; --Max Value only!

local PStartPoint = 0;
local OStartPoint = 0;

-- No longer messes with your ClientPrefs! Which means Note Splashes no longer randomly turn off!

-- function onCreate()
	-- setProperty('skipCountdown', true)
-- end

function onUpdatePost(elapsed)
	for i= 0, 15 do
		if getProperty('notePlayerSplash'..i..'.animation.curAnim.finished') then
			setProperty('notePlayerSplash'..i..'.alpha', 0)
		end
	end
	for j= 0, 15 do
		if getProperty('noteOppSplash'..j..'.animation.curAnim.finished') then
			setProperty('noteOppSplash'..j..'.alpha', 0)
		end
	end
	
	if enableNewSystem then
		for s = 0, getProperty('grpNoteSplashes.length')-1 do
			setPropertyFromGroup('grpNoteSplashes', s, 'visible', false);
		end	
	end
end

function onStepHit()
end

-- function goodNoteHit(note, direction, type, sus)
	-- if enableNewSystem then
		-- if sickTrack < getProperty('sicks') then
			-- sickTrack = sickTrack + 1;
			-- spawnCustomSplash(note, direction, type, sus);
		-- end
	-- end
-- end

function opponentNoteHit(note, direction, type, sus)
	if not sus and not lowQuality and framerate >= 200 then
		spawnOppSplash(note, direction, type, sus);
	end
end

function spawnOppSplash(note, direction, type, sus)
	OppSplash = OppSplash + 1;
	if OppSplash == 16 then
		OppSplash = 0;
	end
	
    if type == '' or type == 'No Animation' or type == 'Alt Animation' or type == 'Hey!' or type == 'GF Sing' then
		if direction == 0 then
			splashThing = 'note splash purple '..getRandomInt(1, SplashVarient);
		elseif direction == 1 then
			splashThing = 'note splash blue '..getRandomInt(1, SplashVarient);
		elseif direction == 2 then
			splashThing = 'note splash green '..getRandomInt(1, SplashVarient);
		else
			splashThing = 'note splash red '..getRandomInt(1, SplashVarient);
		end
	end
	
	if type == '' or type == 'No Animation' or type == 'Alt Animation' or type == 'Hey!' or type == 'GF Sing' then
		makeAnimatedLuaSprite('noteOppSplash' .. OppSplash, texture, getPropertyFromGroup('opponentStrums', direction, 'x')-35, getPropertyFromGroup('opponentStrums', direction, 'y')-40);
	end
	addAnimationByPrefix('noteOppSplash' .. OppSplash, 'anim', splashThing, 23, false);
	setObjectCamera('noteOppSplash' .. OppSplash, 'hud');
	addLuaSprite('noteOppSplash' .. OppSplash, true);
	
	setProperty('noteOppSplash' .. OppSplash .. '.offset.x', 85);
	setProperty('noteOppSplash' .. OppSplash .. '.offset.y', 85);
	setProperty('noteOppSplash' .. OppSplash .. '.alpha', getPropertyFromGroup('opponentStrums', 0, 'alpha')-0.15);
end

function spawnCustomSplash(note, direction, type, sus)
	splashCount = splashCount + 1;
	if splashCount == 16 then
		splashCount = 0;
	end
	
    if type == '' or type == 'No Animation' or type == 'Alt Animation' or type == 'Hey!' or type == 'GF Sing' then
		if direction == 0 then
			splashThing = 'note splash purple '..getRandomInt(1, SplashVarient);
		elseif direction == 1 then
			splashThing = 'note splash blue '..getRandomInt(1, SplashVarient);
		elseif direction == 2 then
			splashThing = 'note splash green '..getRandomInt(1, SplashVarient);
		else
			splashThing = 'note splash red '..getRandomInt(1, SplashVarient);
		end
	end
	
	if type == '' or type == 'No Animation' or type == 'Alt Animation' or type == 'Hey!' or type == 'GF Sing' then
		makeAnimatedLuaSprite('notePlayerSplash' .. splashCount, texture, getPropertyFromGroup('playerStrums', direction, 'x')-35, getPropertyFromGroup('playerStrums', direction, 'y')-40);
	end
	addAnimationByPrefix('notePlayerSplash' .. splashCount, 'anim', splashThing, 23, false);
	setObjectCamera('notePlayerSplash' .. splashCount, 'hud');
	addLuaSprite('notePlayerSplash' .. splashCount, true);
	
	setProperty('notePlayerSplash' .. splashCount .. '.offset.x', 85);
	setProperty('notePlayerSplash' .. splashCount .. '.offset.y', 85);
	setProperty('notePlayerSplash' .. splashCount .. '.alpha', getPropertyFromGroup('playerStrums', 0, 'alpha')-0.15);
end

function onTimerCompleted(tag, loops, loopsLeft)

end