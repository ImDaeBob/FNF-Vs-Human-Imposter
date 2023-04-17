local xx = -100; 
local yy = 1000; 
local xx2 = 200; 
local yy2 = 1000;
local ofs = 15;
local followchars = true;
local del = 0;
local del2 = 0;
local CZoom = 0.75;
local CZoom1 = 0.75;
local cam = 0; --Just for the Fancy Mid Cam at the start of the Song, nothing else :v

local DarkGrey = true; --For Dark

local OppTrail = false;

local Special = 0; -- 1 = Zoom | 2 = Move to the Note Direction | 3 = Up | 4 = Front;

local OppCount = 0;

local MaxTrail = 100;								  --{For better Quality control}
local TrailStartingAlpha = 0.65; --Default Value;		{For how much visibility the Trails start at}
local TrailDelay = 0.05; -- Default Value;				{For how long before a new Trail generated}
local TrailGoneIn = 0.25; -- Default Value (second);		{For how long do the Trails fade away}

local ScaleUp = 0.35; -- Default Value;					{For Special 1}
local Distance = 150; -- Default Value;					{For Special 2}
local DistanceUp = 200; -- Default Value; 				{For Special 3}

local OppTrailStored = 0;

function onCreate()
	makeLuaSprite('floor','Airship/Grey/graybg', -1500, 300)
	addLuaSprite('floor')
	
	makeAnimatedLuaSprite('grayglowy','Airship/Grey/grayglowy', 425, 750)
	addAnimationByPrefix('grayglowy','loop','jar??',24,true)
	addLuaSprite('grayglowy')
	
	makeAnimatedLuaSprite('black','Airship/Grey/black-watching', -1020, 500)
	addAnimationByPrefix('black','idle','idle',24,false)
	scaleObject('black', 1.25, 1.25)
	addLuaSprite('black')
	
	makeLuaSprite('darky','Airship/Grey/graymultiply', -1500, 300)
	setBlendMode('darky', 'MULTIPLY')
	addLuaSprite('darky', true)
	
	makeLuaSprite('overlay','Airship/Grey/grayoverlay', -1500, 300)
	setProperty('overlay.alpha', 0.4)
	setBlendMode('overlay', 'MULTIPLY')
	addLuaSprite('overlay', true)
	
	makeLuaSprite('Vignette', 'hudStuffs/vignette', 0, 0)
	setObjectCamera('Vignette', 'camOther')
	scaleObject('Vignette', 1, 1)
	setProperty('Vignette.alpha', 0.6)
	addLuaSprite('Vignette', true)
	
	makeLuaSprite('SuperVignette', 'hudStuffs/vignetteButDarker', 0, 0)
	setObjectCamera('SuperVignette', 'camOther')
	scaleObject('SuperVignette', 1, 1)
	setProperty('SuperVignette.alpha', 0)
	addLuaSprite('SuperVignette', true)
	
	makeLuaSprite('LightsOut', 'Airship/Grey/Darkness', -1040, 300)
	scaleObject('LightsOut', 1.5, 1.5)
	setProperty('LightsOut.alpha', 0)
	addLuaSprite('LightsOut', true)
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	makeLuaSprite('RedFlash', '', 0, 0)
	makeGraphic('RedFlash', 1300, 750, 'FF1000')
	setObjectCamera('RedFlash','hud')
	setProperty('RedFlash.alpha', 0.0001)
	addLuaSprite('RedFlash')
	
	makeLuaSprite('BarUp', '', 0, -110)	--Default y = 0
	makeGraphic('BarUp', 1280, 105, '000000')
	setObjectCamera('BarUp', 'camHUD')
	addLuaSprite('BarUp')
	
	makeLuaSprite('BarDown', '', 0, 735) --Default y = 620
	makeGraphic('BarDown', 1280, 105, '000000')
	setObjectCamera('BarDown', 'camHUD')
	addLuaSprite('BarDown')
	
	setProperty('healthGain', 0.25)
	setProperty('healthLoss', 2)
end

function onCreatePost()
	if framerate <= 100 then
		TrailDelay = 0.08 * 5;
	end

	midCam(true);
	setProperty('scoreTxt.color', getColorFromHex('8E8098'))
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	makeAnimatedLuaSprite('Grey_Dark', 'Airship/Grey/Grey_Dark', getProperty('dad.x'), getProperty('dad.y'))
	setProperty('Grey_Dark.offset.x', getProperty('dad.offset.x'))
	setProperty('Grey_Dark.offset.y', getProperty('dad.offset.y'))
	setProperty('Grey_Dark.scale.x', getProperty('dad.scale.x'))
	setProperty('Grey_Dark.scale.y', getProperty('dad.scale.y'))
	setProperty('Grey_Dark.flipX', getProperty('dad.flipX'))
	setProperty('Grey_Dark.alpha', 0)
	addAnimationByPrefix('Grey_Dark', 'Idle', 'idle', 24, false)
	addAnimationByPrefix('Grey_Dark', 'Up', 'up', 24, false)
	addAnimationByPrefix('Grey_Dark', 'Down', 'down', 24, false)
	addAnimationByPrefix('Grey_Dark', 'Left', 'left', 24, false)
	addAnimationByPrefix('Grey_Dark', 'Right', 'right', 24, false)
	addLuaSprite('Grey_Dark', true)
end


function onCountdownTick(counter)
	if counter % 2 == 0 then
		objectPlayAnimation('black', 'idle', true)
	end
end

function lightSab(intensity, value, timer)
	if intensity == 1 then
		doTweenAlpha('GreyDarkAlphaGone', 'Grey_Dark', 0, timer/2)
		---------------------------------------------------------------------
		cameraFlash('camOther', '0x000000', 0.5, true)
		doTweenAlpha('VignetteDark', 'Vignette', value, timer+0.75, 'sineInOut')
		doTweenAlpha('SuperVignetteDark', 'SuperVignette', 0, timer+0.75, 'sineInOut')
	elseif intensity == 2 then
		doTweenAlpha('GreyDarkAlphaGone', 'Grey_Dark', 0, timer/2)
		---------------------------------------------------------------------
		cameraFlash('camOther', '0x000000', 0.7, true)
		doTweenAlpha('VignetteDark', 'Vignette', 0, timer, 'sineInOut')
		doTweenAlpha('SuperVignetteDark', 'SuperVignette', value, timer, 'sineInOut')
	elseif intensity == 3 then
		DarkGrey = true;
		doTweenAlpha('GreyDarkAlpha', 'Grey_Dark', 1, timer*2)
		---------------------------------------------------------------------
		cameraFlash('camOther', '0x000000', 0.85, true)
		doTweenAlpha('LightsOutAlpha', 'LightsOut', 0.8, timer, 'sineInOut')
	elseif intensity == 4 then
		DarkGrey = true;
		doTweenAlpha('GreyDarkAlpha', 'Grey_Dark', 1, timer*2)
		---------------------------------------------------------------------
		cameraFlash('camOther', '0x000000', 1, true)
		doTweenAlpha('VignetteDark', 'Vignette', value, timer, 'sineInOut')
		doTweenAlpha('SuperVignetteDark', 'SuperVignette', value, timer, 'sineInOut')
		doTweenAlpha('LightsOutAlpha', 'LightsOut', 0.675, timer, 'sineInOut')	
	else
		doTweenAlpha('GreyDarkAlphaGone', 'Grey_Dark', 0, timer/2)
		---------------------------------------------------------------------
		doTweenAlpha('VignetteDark', 'Vignette', 0.6, timer, 'sineInOut')
		doTweenAlpha('SuperVignetteDark', 'SuperVignette', 0, timer, 'sineInOut')
		doTweenAlpha('LightsOutAlpha', 'LightsOut', 0, timer, 'sineInOut')
	end
end

function midCam(bool)
	if bool then
		xx = 0;		xx2 = 0;	yy = 950;	yy2 = 950;	CZoom = 0.7;	CZoom1 = 0.7;
	elseif not bool then
		xx = -100; 	xx2 = 200;	yy = 1020; 	yy2 = 1020;	CZoom = 0.8;	CZoom1 = 0.8;
	end
end

function flash(flashType, startAlpha, fadeTimer)
	if flashType == "Red" and flashingLights then
		setProperty('RedFlash.alpha', startAlpha)
		doTweenAlpha('FlashBye', 'RedFlash', 0, fadeTimer, 'sineInOut')
		triggerEvent('Add Camera Zoom', 0.035, 0.06)
		playSound('Alarm', 0.35)
	end
end

function cinematicView(bool, transitionTimer)
	if bool then
		doTweenY('BarUpY', 'BarUp', 0, transitionTimer, 'sineOut')
		doTweenY('BarDownY', 'BarDown', 620, transitionTimer, 'sineOut')
		-- if not downscroll then
			-- doTweenY('camHUDY', 'camHUD', 40, transitionTimer, 'sineOut')
		-- elseif downscroll then
			-- doTweenY('camHUDY', 'camHUD', -40, transitionTimer, 'sineOut')
		-- end
		-- doTweenAlpha('healthBarAlpha', 'healthBar', 0, transitionTimer)
		-- doTweenAlpha('iconP1Alpha', 'iconP1', 0, transitionTimer)
		-- doTweenAlpha('iconP2Alpha', 'iconP2', 0, transitionTimer)
		for i=0, 7 do
			cancelTween('NoteY'..i)
			-- noteTweenAngle('Spin'..i, i, 360, transitionTimer, 'sineOut')
			if not downscroll then
				noteTweenY('Y'..i, i, 120, transitionTimer+getRandomInt(15, 55)/100, 'backOut')
			elseif downscroll then
				noteTweenY('Y'..i, i, 500, transitionTimer+getRandomInt(15, 55)/100, 'backOut')
			end
		end
	elseif not bool then
		setBlendMode('RedFlash', 'NORMAL')
		doTweenY('BarUpY', 'BarUp', -110, transitionTimer, 'sineInOut')
		doTweenY('BarDownY', 'BarDown', 735, transitionTimer, 'sineInOut')
		-- if not downscroll then
			-- doTweenY('camHUDY', 'camHUD', 0, transitionTimer, 'sineInOut')
		-- elseif downscroll then
			-- doTweenY('camHUDY', 'camHUD', 0, transitionTimer, 'sineInOut')
		-- end
		-- doTweenAlpha('healthBarAlpha', 'healthBar', 1, transitionTimer)
		-- doTweenAlpha('iconP1Alpha', 'iconP1', 1, transitionTimer)
		-- doTweenAlpha('iconP2Alpha', 'iconP2', 1, transitionTimer)
		if not downscroll then
			for i=0, 3 do
				cancelTween('NoteY'..i)
				cancelTween('NoteY'..i+4)
				noteTweenY('NoteY'..i, i, _G['defaultOpponentStrumY'..i], transitionTimer+0.35, 'sineInOut')
				noteTweenY('NoteY'..i+4, i+4, _G['defaultPlayerStrumY'..i], transitionTimer+0.35, 'sineInOut')
				-- noteTweenAngle('Spin'..i, i, 0, transitionTimer, 'sineInOut')
				-- noteTweenAngle('Spin'..i+4, i+4, 0, transitionTimer, 'sineInOut')
			end
		end
	end
end

function trailToggle(bool1, v2)
	if not lowQuality then
		if not bool1 then
			cameraFlash('camOther', '0x000000', 1.5, false)
			OppTrail = false;
			for i=0, 3 do
				setPropertyFromGroup('strumLineNotes', i, 'x', _G['defaultOpponentStrumX'..i]) 
				setPropertyFromGroup('strumLineNotes', i+4, 'x', _G['defaultPlayerStrumX'..i])
				setPropertyFromGroup('strumLineNotes', i, 'y', _G['defaultOpponentStrumY'..i]) 
				setPropertyFromGroup('strumLineNotes', i+4, 'y', _G['defaultPlayerStrumY'..i])
				
				cancelTween('NoteALPHA'..i)
				cancelTween('NoteALPHA'..i+4)
				setPropertyFromGroup('strumLineNotes', i, 'alpha', 1)
				setPropertyFromGroup('strumLineNotes', i+4, 'alpha', 1)
			end
			cancelTimer('StartTrailing');
		elseif bool1 then
			OppTrail = true;
			cameraFlash('camOther', '0x000000', 0.8, false)
		end
		------------------------------------
		if v2 ~= '' then
			Special = v2;
		else
			Special = 0;
		end
		
		if OppTrail or BFTrail then
			runTimer('StartTrailing', TrailDelay, 0);
		end
	end
end

function onStepHit()
	if getProperty('health') >= 1.65 then
		cameraShake('hud', 0.0015, 0.05)
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Delusion' then
		if curStep == 32 or curStep == 800 then
			lightSab(1, 1, 2)
		end
		if curStep == 928 then
			lightSab(2, 1, 3)
		end
		if curStep == 544 or curStep == 1176 then
			lightSab(0, 0, 2)
		end
	
		if curStep == 288 or curStep == 928 or curStep == 1136 then
			midCam(true);
		end
		if curStep == 416 or curStep == 1056 then
			midCam(false);
		end
	
		if curStep == 32 or curStep == 288 or curStep == 800 then
			trailToggle(true, 4)
		end
		if curStep == 160 or curStep == 544 or curStep == 1176 then
			trailToggle(false)
		end
		
		if curStep == 416 or curStep == 1056 then
			flash('Red', 0.25, 0.4)
		end
		if curStep == 1180 then
			flash('Red', 0.4, 0.7)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Blackout' then	
		if curStep == 272 or curStep == 832 then
			lightSab(3, 0.6, 3)
		end
		if curStep == 1712 then
			lightSab(2, 1, 3)
		end
		if curStep == 528 or curStep == 1344 or curStep == 1968 then
			lightSab(0, 2, 3)
		end
	
	
		if curStep == 528 or curStep == 832 or curStep == 1343 or curStep == 1712 or curStep == 1968 then
			flash('Red', 0.25, 0.4)
		end
		
		if curStep == 336 or curStep == 560 or curStep == 1024 or curStep == 1216 or curStep == 1440 or curStep == 1776 then
			midCam(true);
		end
		if curStep == 528 or curStep == 688 or curStep == 1088 or curStep == 1344 or curStep == 1712 or curStep == 1968 then
			midCam(false);
		end
		
		if curStep == 1712 then
			cinematicView(true, 0.25)
		end
		if curStep == 1344 or curStep == 1968 then
			cinematicView(false, 1.5)
		end
		if curStep == 752 then
			cinematicView(true, 0.6)
		end
		if curStep == 816 then
			cinematicView(false, 1.35)
		end
		if curStep == 832 then
			cinematicView(true, 0.25)
		end
		
		if curStep == 1712 then
			trailToggle(true, 4)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Neurotic' then
		if curStep == 272 or curStep == 1568 then
			lightSab(2, 1, 3)
		end
		if curStep == 1040 then
			lightSab(4, 0.6, 3)
		end
		if curStep == 528  then
			lightSab(1, 1, 2)
		end
		if curStep == 1312 or curStep == 2080 then
			lightSab(0, 2, 3)
		end
	
		if curStep == 528 or curStep == 1568 then
			trailToggle(true, 4)
		end
		if curStep == 784 then
			trailToggle(false)
		end
	
		if curStep == 272 or curStep == 784 or curStep == 1568 then
			cinematicView(true, 0.35)
		end
		if curStep == 1039 then
			cinematicView(false, 1.85)
		end
		
		if curStep == 336 or curStep == 1376 or curStep == 1568 then
			midCam(true);
		end
		if curStep == 400 or curStep == 1440 then
			midCam(false);
		end
		
		if curStep == 1552 then
			triggerEvent('Change Scroll Speed', 1.07, 1)
		end
		
		if curStep == 2080 then
			cinematicView(false, 2)
		end
		if curStep == 2150 then
			flash('Red', 0.4, 0.8)
		end
	end
end

function onBeatHit()
	if curBeat % 2 == 0 then
		objectPlayAnimation('black', 'idle', true)
		if DarkGrey and getProperty('Grey_Dark.animation.curAnim.name') == 'Idle' then
			objectPlayAnimation('Grey_Dark', 'Idle', false)
			setProperty('Grey_Dark.offset.x', getProperty('dad.offset.x'))
			setProperty('Grey_Dark.offset.y', getProperty('dad.offset.y'))
		end
	end
	
	if curBeat % 3 == 0 and OppTrail then
		for i=0, 7 do
			noteTweenAlpha('NoteALPHA'..i, i, getRandomInt(35,100)/100, 2, 'sineInOut')
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Blackout' then
		if curBeat % 8 == 0 and (curBeat >= 432 and curBeat <= 488) then
			flash('Red', 0.25, 0.4)
		end
	end
end

function onUpdate()
	if OppTrail then --Hallucinating Notes!
		for i=0, 3 do
			currentBeat = (getSongPosition() / 1000) * (bpm / 60);
			
			setPropertyFromGroup('strumLineNotes', i, 'x', _G['defaultOpponentStrumX'..i] + 1 * 24 * math.sin(currentBeat*0.4 + i)) 
			setPropertyFromGroup('strumLineNotes', i+4, 'x', _G['defaultPlayerStrumX'..i] + -1 * 24 * math.sin(currentBeat*0.4 + (i+4))) 

			setPropertyFromGroup('strumLineNotes', i, 'y', _G['defaultOpponentStrumY'..i] + 1 * (24/2) * math.sin(currentBeat*0.4 + i * 2)) 
			setPropertyFromGroup('strumLineNotes', i+4, 'y', _G['defaultPlayerStrumY'..i] + 1 * (24/2) * math.sin(currentBeat*0.4 + (i+4) * 2))
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if getProperty('dad.animation.curAnim.name') == 'idle' and getProperty('Grey_Dark.animation.curAnim.name') ~= 'Idle' and DarkGrey then
		setProperty('Grey_Dark.offset.x', getProperty('dad.offset.x'))
		setProperty('Grey_Dark.offset.y', getProperty('dad.offset.y'))
		objectPlayAnimation('Grey_Dark', 'Idle', true)
		debugPrint('Idle')
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if del > 0 then
		del = del - 1;
	end
	if del2 > 0 then
		del2 = del2 - 1;
	end
    if followchars then
        if mustHitSection == false then
			setProperty('defaultCamZoom', CZoom)
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' or getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' or getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' or getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' or getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
			end
			if getProperty('dad.animation.curAnim.name') == 'idle' or getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
			end
        else
			setProperty('defaultCamZoom', CZoom1)
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
			end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if DarkGrey then
		if direction == 0 then
			setProperty('Grey_Dark.offset.x', getProperty('dad.offset.x'))
			setProperty('Grey_Dark.offset.y', getProperty('dad.offset.y'))
			objectPlayAnimation('Grey_Dark', 'Left', true)
		end
		if direction == 1 then
			setProperty('Grey_Dark.offset.x', getProperty('dad.offset.x'))
			setProperty('Grey_Dark.offset.y', getProperty('dad.offset.y'))
			objectPlayAnimation('Grey_Dark', 'Down', true)
		end
		if direction == 2 then
			setProperty('Grey_Dark.offset.x', getProperty('dad.offset.x'))
			setProperty('Grey_Dark.offset.y', getProperty('dad.offset.y'))
			objectPlayAnimation('Grey_Dark', 'Up', true)
		end
		if direction == 3 then
			setProperty('Grey_Dark.offset.x', getProperty('dad.offset.x'))
			setProperty('Grey_Dark.offset.y', getProperty('dad.offset.y'))
			objectPlayAnimation('Grey_Dark', 'Right', true)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if cam == 0 then
		cam = 1;
		midCam(false);
		doTweenZoom('CamGameCoolZoomy', 'camGame', 0.925, 0.5, 'sineInOut')
	end
	
	if getProperty('health') >= 1.65 then
		setProperty('health', getProperty('health')-0.035*getProperty('health'))
	else
		setProperty('health', getProperty('health')-0.0025*getProperty('health'))
	end
	
	if Special == 1 and OppTrail and OppTrailStored ~= 0 then
		doTweenX('OppTrailScaleX'..OppTrailStored, 'OppTrail'..OppTrailStored..'.scale', getProperty('OppTrail'..OppTrailStored..'.scale.x')+ScaleUp, TrailGoneIn, 'sineOut')
		doTweenY('OppTrailScaleY'..OppTrailStored, 'OppTrail'..OppTrailStored..'.scale', getProperty('OppTrail'..OppTrailStored..'.scale.y')+ScaleUp, TrailGoneIn, 'sineOut')
		OppTrailStored = 0;
	end
	
	if Special == 2 and OppTrail and OppTrailStored ~= 0 then -- No "direction == 1" because why would you want to go down?
		if direction == 0 then
			doTweenX('OppTrailXLeft'..OppTrailStored, 'OppTrail'..OppTrailStored, getProperty('OppTrail'..OppTrailStored..'.x')-Distance, TrailGoneIn, 'sineOut')
		elseif direction == 2 then
			doTweenY('OppTrailYUp'..OppTrailStored, 'OppTrail'..OppTrailStored, getProperty('OppTrail'..OppTrailStored..'.y')-Distance, TrailGoneIn, 'sineOut')
		elseif direction == 3 then
			doTweenX('OppTrailXRight'..OppTrailStored, 'OppTrail'..OppTrailStored, getProperty('OppTrail'..OppTrailStored..'.x')+Distance, TrailGoneIn, 'sineOut')
		end
		OppTrailStored = 0;
	end
	
	if Special == 3 and OppTrail and OppTrailStored ~= 0 then
		doTweenY('OppTrailYUp'..OppTrailStored, 'OppTrail'..OppTrailStored, getProperty('OppTrail'..OppTrailStored..'.y')-DistanceUp, TrailGoneIn, 'sineOut')
		OppTrailStored = 0;
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'StartTrailing' then
		if OppTrail then
			makeAnimatedLuaSprite('OppTrail'..OppCount, getProperty('dad.imageFile'), getProperty('dad.x'), getProperty('dad.y'));
			setProperty('OppTrail'..OppCount..'.offset.x', getProperty('dad.offset.x'));
			setProperty('OppTrail'..OppCount..'.offset.y', getProperty('dad.offset.y'));
			setProperty('OppTrail'..OppCount..'.scale.x', getProperty('dad.scale.x'));
			setProperty('OppTrail'..OppCount..'.scale.y', getProperty('dad.scale.y'));
			setProperty('OppTrail'..OppCount..'.flipX', getProperty('dad.flipX'));
			-- setProperty('OppTrail'..OppCount..'.color', getColorFromHex('333333'));
			setProperty('OppTrail'..OppCount..'.alpha', TrailStartingAlpha);
			setBlendMode('OppTrail'..OppCount, 'OVERLAY');
			addAnimationByPrefix('OppTrail'..OppCount, 'Anima', getProperty('dad.animation.frameName'), 0, false);
			if Special == 4 then addLuaSprite('OppTrail'..OppCount, true) setObjectOrder('OppTrail'..OppCount, getObjectOrder('darky')-1) end
			doTweenAlpha('OppTrailAlpha'..OppCount, 'OppTrail'..OppCount, 0, TrailGoneIn, 'sineInOut')
			if OppTrailStored == 0 then
				OppTrailStored = OppCount;
			end
			
			OppCount = OppCount + 1;
			if OppCount >= MaxTrail then
				OppCount = 0;
			end
		end
	end
end

function onTweenCompleted(tag)
	for a=0, MaxTrail-1 do
		if tag == 'OppTrailAlpha'..a then
			removeLuaSrite('OppTrail'..a, false);
		end
	end
	
	if tag == 'GreyDarkAlphaGone' then
		DarkGrey = false;	
	end
end
