local xx = -100; 
local yy = 900; 
local xx2 = 100; 
local yy2 = 900;
local ofs = 22;
local followchars = true;
local CZoom = 0.5;
local CZoom1 = 0.5;
local cam = 0; --Just for the Fancy Mid Cam at the start of the Song, nothing else :v

local Pinky = false;

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

------------------------------------------
--These following func() are used for stopping the song and for me to check the stage... that's all :v
-- function onStartCountdown()
	-- if not allowCountdown then
		-- return Function_Stop;
	-- end
	-- return Function_Continue;
-- end

-- function onUpdatePost(elapsed)
	-- if keyJustPressed('space') then
		-- allowCountdown = true;
		-- startCountdown();
	-- end
-- end
------------------------------------------

local MaxClouds = 6;

function onCreate()
	addCharacterToList('BF_Dead', 'boyfriend')

	if songName == 'Heartbeat' or songName == 'Pinkwave' then
		makeLuaSprite('sky','MiraHQ/Pink/Happy/bg sky', -1650, -200)
		addLuaSprite('sky')
		
		makeLuaSprite('cloudBehind', 'MiraHQ/Pink/Happy/cloud fathest', -1500, 600)
		addLuaSprite('cloudBehind')
		
		makeLuaSprite('cloud', 'MiraHQ/Pink/Happy/cloud front', -1500, 730)
		addLuaSprite('cloud')
		
		makeLuaSprite('cloudUpLeft', 'MiraHQ/Pink/Happy/cloud_4', -1700, 250)
		scaleObject('cloudUpLeft', 4, 4)
		addLuaSprite('cloudUpLeft')
		
		
		Clouds = getRandomInt(2, MaxClouds)
		for i=1, Clouds do
			makeLuaSprite('cloud'..i, 'MiraHQ/Pink/Happy/cloud_'..getRandomInt(1,4), getRandomInt(-1800, 1200), getRandomInt(300, 800))
			randomScale = getRandomFloat(2, 4.5)
			scaleObject('cloud'..i, randomScale, randomScale)
			addLuaSprite('cloud'..i)
			doTweenX('cloudX'..i, 'cloud'..i, -2400, getRandomFloat(30, 120))
		end
		
		if Clouds ~= MaxClouds then
			for i=Clouds, MaxClouds do
				makeLuaSprite('cloud'..i, 'MiraHQ/Pink/Happy/cloud_'..getRandomInt(1,4), getRandomInt(1500, 2800), getRandomInt(300, 800))
				randomScale = getRandomFloat(2, 4.5)
				scaleObject('cloud'..i, randomScale, randomScale)
				setObjectOrder('cloud'..i, getObjectOrder('cloudDownRight')-1)
				addLuaSprite('cloud'..i)
				doTweenX('cloudX'..i, 'cloud'..i, -2400, getRandomFloat(40, 120))
			end
		end
		
		makeLuaSprite('cloudDownRight', 'MiraHQ/Pink/Happy/bigcloud', -2200, -370)
		addLuaSprite('cloudDownRight')	
		
		makeLuaSprite('floor','MiraHQ/Pink/Happy/glasses', -1500, -100)
		setBlendMode('floor', 'OVERLAY')
		addLuaSprite('floor')
		
		makeAnimatedLuaSprite('grey','MiraHQ/Pink/Happy/uglyass', -620, 450)
		addAnimationByPrefix('grey','loop','grey',24,false)
		addLuaSprite('grey')
		
		makeAnimatedLuaSprite('coral','MiraHQ/Pink/Happy/uglyass', 400, 550)
		addAnimationByPrefix('coral','loop','CT',24,false)
		addLuaSprite('coral')
		
		makeLuaSprite('what is this','MiraHQ/Pink/Happy/what is this', -317, 0)
		addLuaSprite('what is this')
		
		makeLuaSprite('lmao','MiraHQ/Pink/Happy/lmao', -1050, 670)
		scaleObject('lmao', 0.85, 0.85)
		addLuaSprite('lmao')
	
		makeAnimatedLuaSprite('flowerguy','MiraHQ/Pink/Happy/Backgroundbois', -1480, 545)
		addAnimationByPrefix('flowerguy','loop','flowerguy',24,false)
		scaleObject('flowerguy', 1.1, 1.1)
		setScrollFactor('flowerguy', 1.2, 1);
		addLuaSprite('flowerguy', true)
		
		makeAnimatedLuaSprite('righthandman','MiraHQ/Pink/Happy/Backgroundbois', 700, 850)
		addAnimationByPrefix('righthandman','loop','righthandman',24,false)
		setScrollFactor('righthandman', 1.2, 1);
		scaleObject('righthandman', 1.1, 1.1)
		addLuaSprite('righthandman', true)
		
		makeLuaSprite('front pot','MiraHQ/Pink/Happy/front pot', -1500, 1300)
		addLuaSprite('front pot', true)
		
		makeAnimatedLuaSprite('vines','MiraHQ/Pink/Happy/vines', -1300, -450)
		addAnimationByPrefix('vines','loop','green',24,true)
		addLuaSprite('vines', true)	
		
		if songName == 'Pinkwave' then
			makeAnimatedLuaSprite('black','Airship/Grey/black-watching', -500, 380)
			addAnimationByPrefix('black','idle','idle', bpm/10, false)
			scaleObject('black', 1.3, 1.3)
			setProperty('black.alpha', 0.001)
			addLuaSprite('black')
		end
		---------------------------------------------------------------------
		makeLuaSprite('Pinkish', 'MiraHQ/Pink/Happy/vignette', 0, 0)
		setProperty('Pinkish.alpha', 0.001)
		setBlendMode('Pinkish', 'ADD')
		setObjectCamera('Pinkish', 'other')
		addLuaSprite('Pinkish', false)	
	
		makeLuaSprite('Vignette', 'MiraHQ/Pink/Happy/vignette2', 0, 0)
		setProperty('Vignette.alpha', 0.001)
		setBlendMode('Vignette', 'ADD')
		setObjectCamera('Vignette', 'other')
		addLuaSprite('Vignette', false)
		
		makeAnimatedLuaSprite('Hearts', 'MiraHQ/Pink/Happy/hearts', -15, 0)
		addAnimationByPrefix('Hearts', 'heart', 'Symbol', 24, true)
		setBlendMode('Hearts', 'OVERLAY')
		setObjectCamera('Hearts', 'other')
		setProperty('Hearts.alpha', 0.001)
		addLuaSprite('Hearts', false)
		
		if songName == 'Heartbeat' then
			setProperty('cameraSpeed', 1.5)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Pretender' then
		makeLuaSprite('sky','MiraHQ/Pink/Onslaught/bg sky', -1650, -200)
		addLuaSprite('sky')
		
		makeLuaSprite('cloudBehind', 'MiraHQ/Pink/Onslaught/cloud fathest', -1500, 600)
		addLuaSprite('cloudBehind')
		
		makeLuaSprite('cloud', 'MiraHQ/Pink/Onslaught/cloud front', -1500, 730)
		addLuaSprite('cloud')
		
		makeLuaSprite('cloudUpLeft', 'MiraHQ/Pink/Onslaught/cloud_3', -1700, 300)
		scaleObject('cloudUpLeft', 4, 4)
		addLuaSprite('cloudUpLeft')
		
		
		Clouds = getRandomInt(2, MaxClouds)
		for i=1, Clouds do
			makeLuaSprite('cloud'..i, 'MiraHQ/Pink/Onslaught/cloud_'..getRandomInt(1,3), getRandomInt(-1800, 1200), getRandomInt(300, 800))
			randomScale = getRandomFloat(2, 4.5)
			scaleObject('cloud'..i, randomScale, randomScale)
			addLuaSprite('cloud'..i)
			doTweenX('cloudX'..i, 'cloud'..i, -2400, getRandomFloat(30, 120))
		end
		
		if Clouds ~= MaxClouds then
			for i=Clouds, MaxClouds do
				makeLuaSprite('cloud'..i, 'MiraHQ/Pink/Onslaught/cloud_'..getRandomInt(1,3), getRandomInt(1500, 2800), getRandomInt(300, 800))
				randomScale = getRandomFloat(2, 4.5)
				scaleObject('cloud'..i, randomScale, randomScale)
				setObjectOrder('cloud'..i, getObjectOrder('cloudDownRight')-1)
				addLuaSprite('cloud'..i)
				doTweenX('cloudX'..i, 'cloud'..i, -2400, getRandomFloat(40, 120))
			end
		end
		
		makeLuaSprite('cloudDownRight', 'MiraHQ/Pink/Onslaught/bigcloud', -2200, -370)
		addLuaSprite('cloudDownRight')
		
		makeLuaSprite('floor','MiraHQ/Pink/Onslaught/ground', -1500, -100)
		setBlendMode('floor', 'OVERLAY')
		addLuaSprite('floor')
		
		makeLuaSprite('PlantTube','MiraHQ/Pink/Onslaught/front plant', -317, -31)
		addLuaSprite('PlantTube')
		
		makeLuaSprite('knockedPot','MiraHQ/Pink/Onslaught/knocked over plant 2', -1030, 1000)
		scaleObject('knockedPot', 0.85, 0.85)
		addLuaSprite('knockedPot')
		
		makeLuaSprite('knockedPot2', 'MiraHQ/Pink/Onslaught/knocked over plant', 870, 830)
		addLuaSprite('knockedPot2')
		
		makeLuaSprite('Tomato', 'MiraHQ/Pink/Onslaught/tomatodead', 870, 900)
		addLuaSprite('Tomato')
		
		makeAnimatedLuaSprite('black','Airship/Grey/black-watching', 120, 380)
		addAnimationByPrefix('black','idle','idle', bpm/10, false)
		scaleObject('black', 1.3, 1.3)
		setProperty('black.flipX', true)
		setProperty('black.angle', 5)
		addLuaSprite('black')
			
		makeLuaSprite('DedBF', 'MiraHQ/Pink/Onslaught/ripbozo', 830, 1260)
		scaleObject('DedBF', 0.68, 0.64)
		addLuaSprite('DedBF', true)
	
		makeAnimatedLuaSprite('deadflowerguy','MiraHQ/Pink/Onslaught/deadflowerguy', -1365, 1065)
		addAnimationByPrefix('deadflowerguy','loop','flowerguy',24, false)
		scaleObject('deadflowerguy', 1.15, 1.15)
		setScrollFactor('deadflowerguy', 1.2, 1);
		addLuaSprite('deadflowerguy', true)
		
		makeLuaSprite('FrontPot','MiraHQ/Pink/Onslaught/front pot', -1500, 1300)
		addLuaSprite('FrontPot', true)
		
		makeLuaSprite('DedVines','MiraHQ/Pink/Onslaught/green', -1280, -450)
		scaleObject('DedVines', 0.85, 1)
		addLuaSprite('DedVines', true)
		
		makeLuaSprite('DarkVignette', 'MiraHQ/Pink/Onslaught/lightingpretender', -1500, -65)
		scaleObject('DarkVignette', 0.85, 1)
		addLuaSprite('DarkVignette', true)
		
		setProperty('healthGain', 0.25)
		setProperty('healthLoss', 2)
		setPropertyFromClass('HealthIcon', 'iconFPS', bpm/6)
		setProperty('winningValue', 70)
		setProperty('losingValue', 40)
		
		makeLuaSprite('Vignette', 'hudStuffs/vignette', 0, 0)
		setObjectCamera('Vignette', 'camOther')
		scaleObject('Vignette', 1, 1)
		setProperty('Vignette.alpha', 0.75)
		addLuaSprite('Vignette', true)
		
		makeLuaSprite('SuperVignette', 'hudStuffs/vignetteButDarker', 0, 0)
		setObjectCamera('SuperVignette', 'camOther')
		scaleObject('SuperVignette', 1, 1)
		setProperty('SuperVignette.alpha', 0)
		addLuaSprite('SuperVignette', true)
	end
	-- setProperty('skipCountdown', true)
	
	makeLuaSprite('RedFlash', '', 0, 0)
	makeGraphic('RedFlash', 1300, 750, 'FF1000')
	setObjectCamera('RedFlash','hud')
	setProperty('RedFlash.alpha', 0.0001)
	addLuaSprite('RedFlash')
	
	makeLuaSprite('BarUp', '', 0, -110)	--Default y = 0
	makeGraphic('BarUp', 1280, 105, '000000')
	setObjectCamera('BarUp', 'camHUD')
	-- setObjectOrder('BarUp', getObjectOrder('Glow')-1)
	addLuaSprite('BarUp')
	
	makeLuaSprite('BarDown', '', 0, 735) --Default y = 620
	makeGraphic('BarDown', 1280, 105, '000000')
	setObjectCamera('BarDown', 'camHUD')
	addLuaSprite('BarDown')
end

function onCreatePost()
	if songName == 'Pinkwave' or songName == 'Heartbeat' then		
		makeLuaSprite('BigHeart', 'MiraHQ/Pink/Happy/BigHeart', getProperty('dad.x')+440, getProperty('dad.y')+250)
		scaleObject('BigHeart', 0.5, 0.5)
		setBlendMode('BigHeart', 'ADD')
		setProperty('BigHeart.alpha', 0.01)
		addLuaSprite('BigHeart', true)
	end
	if songName == 'Pretender' then
		setProperty('dad.x', 150)
		setProperty('dad.y', 730)
		setProperty('boyfriend.x', -700)
		setProperty('boyfriend.y', 680)
		xx = 100; 	xx2 = -100;	yy = 950; 	yy2 = 950;	CZoom = 0.55;	CZoom1 = 0.55;
		
		if not middlescroll then
			for i=0, 3 do
				setPropertyFromGroup('strumLineNotes', i, 'x', _G['defaultPlayerStrumX'..i])
				setPropertyFromGroup('strumLineNotes', i+4, 'x', _G['defaultOpponentStrumX'..i])
			end
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if framerate <= 100 then
		TrailDelay = 0.08 * 5;
	end
	
	midCam(true);
	setProperty('scoreTxt.color', getColorFromHex('FF94E9'))
	if songName == 'Pretender' then
		setProperty('scoreTxt.color', getColorFromHex('E35EC5'))
	end
end

function midCam(bool)
	if songName == 'Heartbeat' or songName == 'Pinkwave' then
		if bool then
			xx = 63;	xx2 = 63;	yy = 950;	yy2 = 950;	CZoom = 0.65;	CZoom1 = 0.65;
		elseif not bool then
			xx = -70; 	xx2 = 70;	yy = 900; 	yy2 = 900;	CZoom = 0.5;	CZoom1 = 0.5;
		end
	end
end

function PinkyToggle(flashy)
	if flashy == true then
		Pinky = true;
		setBlendMode('Hearts', 'OVERLAY')
		doTweenAlpha('HeartsAlpha', 'Hearts', 1, 0.25, 'backOut')
		setProperty('Pinkish.alpha', 1)
		doTweenAlpha('PinkishAlpha', 'Pinkish', 0.3, 1.5)
		setProperty('Vignette.alpha', 0.4)
		
		triggerEvent('Add Camera Zoom', 0.03, 0.06)
		-- setBlendMode('BigHeart', 'NORMAL')
		setProperty('BigHeart.alpha', 1)
		doTweenX('BigHeartScaleX', 'BigHeart.scale', 2.5, 1, 'sineOut')
		doTweenY('BigHeartScaleY', 'BigHeart.scale', 2.5, 1, 'sineOut')
		doTweenAlpha('BigHeartAlpha', 'BigHeart', 0, 1)
	elseif flashy == false then
		midCam(false);
		Pinky = false;
		setBlendMode('Hearts', 'ADD')
		doTweenAlpha('HeartsAlpha', 'Hearts', 0, 10, 'backOut')
		setProperty('Pinkish.alpha', 1)
		doTweenAlpha('PinkishAlpha', 'Pinkish', 0, 5)
		setProperty('Vignette.alpha', 1)
		doTweenAlpha('VignetteAlpha', 'Vignette', 0, 5)
		
		triggerEvent('Add Camera Zoom', 0.02, 0.05)
		-- setBlendMode('BigHeart', 'ADD')
		setProperty('BigHeart.alpha', 1)
		doTweenX('BigHeartScaleX', 'BigHeart.scale', 2.75, 1.7, 'sineOut')
		doTweenY('BigHeartScaleY', 'BigHeart.scale', 2.75, 1.7, 'sineOut')
		doTweenAlpha('BigHeartAlpha', 'BigHeart', 0, 1.7)
		
		canelTween('turn')
		canelTween('tuin')
		canelTween('rrr')
		canelTween('rtr')
		canelTween('rir')
		canelTween('ryr')
	elseif flashy == 'flash' and flashingLights then
		setProperty('Pinkish.alpha', 0.8)
		doTweenAlpha('PinkishAlpha', 'Pinkish', 0.3, 0.5)
		setProperty('Vignette.alpha', 0.7)
		doTweenAlpha('VignetteAlpha', 'Vignette', 0.3, 0.5)
	end
end

function setGameZoom(amount, addAmount, timer)
	if timer ~= nil then
		if amount ~= 0 then
			CZoom = amount;
			CZoom1 = amount;
		else
			CZoom =  CZoom + addAmount;
			CZoom1 = CZoom1 + addAmount;
		end
		doTweenZoom('camGameZoom', 'camGame', CZoom, timer, 'sineInOut')
	else
		if amount ~= 0 then
			CZoom = amount;
			CZoom1 = amount;
		else
			CZoom =  CZoom + addAmount;
			CZoom1 = CZoom1 + addAmount;
		end
	end
end

function lightSab(intensity, value, timer)
	if intensity == 1 then
		cameraFlash('camOther', '0x000000', 0.5, true)
		doTweenAlpha('VignetteDark', 'Vignette', value, timer, 'sineInOut')
		doTweenAlpha('SuperVignetteDark', 'SuperVignette', 0, timer, 'sineInOut')
	elseif intensity == 2 then
		cameraFlash('camOther', '0x000000', 0.7, true)
		doTweenAlpha('VignetteDark', 'Vignette', 0, timer, 'sineInOut')
		doTweenAlpha('SuperVignetteDark', 'SuperVignette', value, timer, 'sineInOut')
	elseif intensity == 3 then
		cameraFlash('camOther', '0x000000', 1, true)
		doTweenAlpha('VignetteDark', 'Vignette', value, timer, 'sineInOut')
		doTweenAlpha('SuperVignetteDark', 'SuperVignette', value, timer, 'sineInOut')
	else
		doTweenAlpha('VignetteDark', 'Vignette', 0.75, timer, 'sineInOut')
		doTweenAlpha('SuperVignetteDark', 'SuperVignette', 0, timer, 'sineInOut')
	end
end

function flash(flashType, startAlpha, fadeTimer)
	if flashType == "Red" and flashingLights then
		setProperty('RedFlash.alpha', startAlpha)
		doTweenAlpha('FlashBye', 'RedFlash', 0, fadeTimer, 'sineInOut')
		triggerEvent('Add Camera Zoom', 0.035, 0.06)
		playSound('Alarm', 0.5)
	end
end

function cinematicView(bool, transitionTimer)
	if bool then
		doTweenY('BarUpY', 'BarUp', 0, transitionTimer, 'sineOut')
		doTweenY('BarDownY', 'BarDown', 620, transitionTimer, 'sineOut')
		for i=0, 7 do
			cancelTween('NoteY'..i)
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
		for i=0, 3 do
			cancelTween('NoteY'..i)
			cancelTween('NoteY'..i+4)
			noteTweenY('NoteY'..i, i, _G['defaultOpponentStrumY'..i], transitionTimer+0.35, 'sineInOut')
			noteTweenY('NoteY'..i+4, i+4, _G['defaultPlayerStrumY'..i], transitionTimer+0.35, 'sineInOut')
		end
	end
end

function trailToggle(bool1, v2)
	if not lowQuality then
		if not bool1 then
			cameraFlash('camOther', '0x000000', 1.5, false)
			OppTrail = false;
			for i=0, 3 do
				if not middlescroll then
					setPropertyFromGroup('strumLineNotes', i, 'x', _G['defaultPlayerStrumX'..i]) 
					setPropertyFromGroup('strumLineNotes', i+4, 'x', _G['defaultOpponentStrumX'..i])
					setPropertyFromGroup('strumLineNotes', i, 'y', _G['defaultPlayerStrumY'..i]) 
					setPropertyFromGroup('strumLineNotes', i+4, 'y', _G['defaultOpponentStrumY'..i])
				end
				
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
		
		if OppTrail then
			runTimer('StartTrailing', TrailDelay, 0);
		end
	end
end

function onCountdownTick(counter)
	if songName == 'Heartbeat' then
		if counter % 2 == 0 then
			objectPlayAnimation('grey', 'loop', true)
			objectPlayAnimation('coral', 'loop', true)
			objectPlayAnimation('flowerguy', 'loop', true)
			objectPlayAnimation('righthandman', 'loop', true)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Pinkwave' then
		if counter % 2 == 0 then
			objectPlayAnimation('coral', 'loop', true)
			objectPlayAnimation('flowerguy', 'loop', true)
			objectPlayAnimation('righthandman', 'loop', true)
		end
		if counter % 4 == 0 then
			objectPlayAnimation('grey', 'loop', true)
		end
	end
end

local Summoning = false;
local Smoke = 0;
local maxSmoke = 250;
local smokeRate = 7;
local smokeMultPerMils = 1;
local smokeScaleDiv = 4;

local Particle = 0;
local ParRate = 4;

local Stop = false;

function onStepHit()
	if songName == 'Heartbeat' then
		if curStep == 288 or curStep == 544 then
			PinkyToggle(true);
		end
		if curStep == 416 or curStep == 672 then
			PinkyToggle(false);
		end
		if curStep == 400 or curStep == 403 or curStep == 406 or curStep == 612 or curStep == 620 or curStep == 644 or curStep == 652 or curStep == 656 or curStep == 659 or curStep == 662 then
			PinkyToggle(flash);
			CZoom = CZoom + 0.0525;
			CZoom1 = CZoom1 + 0.0525;
		end
		
		if curStep == 384 or curStep == 624 then
			midCam(true);
		end
		if curStep == 288 or curStep == 544 then
			midCam(false);
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Pinkwave' then
		if curStep == 136 or curStep == 520 or curStep == 776 or curStep == 1032 or curStep == 1288 then
			PinkyToggle(true);
		end
		if curStep == 264 or curStep == 648 or curStep == 904 or curStep == 1160 or curStep == 1448 then
			PinkyToggle(false);
		end
		
		if curStep == 520 or curStep == 1288 or curStep == 1352 or curStep == 1426 then
			midCam(true);
		end
		if curStep == 640 or curStep == 1320 or curStep == 1418 then
			midCam(false);
		end
		
		--Smoke Code Part:
		if curStep == 1028 then
			Summoning = true;
		end
		if curStep == 1160 then
			smokeRate = 5;
			smokeScaleDiv = 3;
		end
		if curStep == 1288 then
			smokeRate = 3;
			smokeScaleDiv = 2;
		end
		if curStep == 1320 then
			smokeRate = 2;
			smokeScaleDiv = 1.6;
		end
		if curStep == 1352 then
			smokeRate = 1;
			smokeScaleDiv = 1.6;
		end
		if curStep == 1384 then
			smokeScaleDiv = 1.1;
			smokeMultPerMils = 2;
		end
		if curStep == 1414 then
			setProperty('black.alpha', 1)
			doTweenX('greyX', 'grey', -770, 0.7, 'sineInOut')
			smokeRate = 3;
		end
		if curStep == 1445 then
			Summoning = false;
		end
		
		if curStep == 1482 then --1483
			Stop = true;
			setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0)
			setProperty('vocals.volume', 0)
			setPropertyFromClass('PlayState', 'instance.generatedMusic', false)
		
			makeLuaSprite('BlackScreen', '', 0, 0)
			makeGraphic('BlackScreen', 1300, 750, '000000')
			setObjectCamera('BlackScreen','other')
			addLuaSprite('BlackScreen', true)
			playSound('onslaught', 1, 'Onslaught')
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Pretender' then --I decided to remove some Events cuz it's too much and doesn't fit...
		if getProperty('health') >= 1.4 then
			cameraShake('hud', 0.0015, 0.05)
		end
	
		if curStep == 800 or curStep == 1344 then
			cinematicView(true, 0.25)
		end
		if curStep == 1056 or curStep == 2144 then
			cinematicView(false, 0.94)
		end
		
		-- if curStep == 256 or curStep == 1344 then
			-- lightSab(3, 0.7, 2)
		-- end
		-- if curStep == 1632 then
			-- lightSab(1, 1, 1)
		-- end
		-- if curStep == 545 then
			-- lightSab(0, 0, 3)
		-- end
		
		-- if curStep == 1344 then --1344
			-- trailToggle(true, 4)
		-- end	
		-- if curStep == 2144 then
			-- trailToggle(false, 4)
		-- end
		
		if curStep == 2452 then
			setBlendMode('RedFlash', 'ADD')
			setObjectCamera('RedFlash', 'other')
			flash('Red', 1, 2)
		end	
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if Pinky and songName == 'Heartbeat' then
		if curStep % 4 == 0 then
			doTweenY('rrr', 'camHUD', -12, stepCrochet*0.002, 'circOut')
			doTweenY('rtr', 'camGame.scroll', 12, stepCrochet*0.002, 'sineIn')
		end
		if curStep % 4 == 2 then
			doTweenY('rir', 'camHUD', 0, stepCrochet*0.002, 'sineIn')
			doTweenY('ryr', 'camGame.scroll', 0, stepCrochet*0.002, 'sineIn')
		end
	end
	
	if curStep % ParRate == 0 and Pinky then
		ParticleX = getRandomInt(0, 1300)
		makeAnimatedLuaSprite('particle'..Particle, 'MiraHQ/Pink/Happy/littleheart', ParticleX, 770)
		addAnimationByPrefix('particle'..Particle, 'hearts', 'littleheart', 24, true)
		rngScale = getRandomInt(9,22)/10;
		scaleObject('particle'..Particle, rngScale, rngScale)
		setObjectCamera('particle'..Particle, 'hud')
		setProperty('particle'..Particle..'.flipX', getRandomBool(50))
		addLuaSprite('particle'..Particle, getRandomBool(30))
		TweenTime = getRandomInt(30,40)/10;
		doTweenY('particleY'..Particle, 'particle'..Particle, -100, TweenTime, 'linear')
		doTweenX('particleX'..Particle, 'particle'..Particle, ParticleX+getRandomInt(-300, 300), TweenTime, 'linear')
		SmallTime = getRandomInt(-10, 30)/10;
		doTweenX('particleYScale'..Particle, 'particle'..Particle..'.scale', 0.01, TweenTime+SmallTime, 'sineInOut')
		doTweenY('particleXScale'..Particle, 'particle'..Particle..'.scale', 0.01, TweenTime+SmallTime, 'sineInOut')
		Particle=Particle+1; if Particle >= 30 then Particle = 0 end
	end
end

local Angle;
local anglevar = 1;

function onBeatHit()
	if Pinky and songName == 'Heartbeat' then
		triggerEvent('Add Camera Zoom', '0.02', '0.03')
	
		if curBeat % 2 == 0 then
			Angle = anglevar;
		else
			Angle = -anglevar;
		end
		-- setProperty('camHUD.angle',angleshit*3)
		doTweenAngle('turn', 'camHUD', Angle, stepCrochet*0.002, 'circOut')
		doTweenX('tuin', 'camHUD', -Angle*4, crochet*0.000075, 'sineInOut')
	elseif not Pinky and Angle ~= 0 then
		doTweenX('camHUDx', 'camHUD', 0, 4.5, 'sineInOut')
		doTweenY('camHUDy', 'camHUD', 0, 4.5, 'sineInOut')
		doTweenAngle('camHUDAngle', 'camHUD', 0, 4.5, 'sineInOut')
		Angle = 0;
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Heartbeat' then
		if curBeat % 2 == 0 then
			objectPlayAnimation('grey', 'loop', true)
		end
		objectPlayAnimation('coral', 'loop', true)
		objectPlayAnimation('flowerguy', 'loop', true)
		objectPlayAnimation('righthandman', 'loop', true)
		
		if curBeat % 2 == 0 and Pinky and flashingLights then
			setProperty('Pinkish.alpha', 0.7)
			doTweenAlpha('PinkishAlpha', 'Pinkish', 0.3, 1.5)
			setProperty('Vignette.alpha', 0.45)
			doTweenAlpha('VignetteAlpha', 'Vignette', 0.3, 2)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Pinkwave' then
		objectPlayAnimation('flowerguy', 'loop', true)
		if curBeat % 2 == 0 then
			objectPlayAnimation('coral', 'loop', true)		
			objectPlayAnimation('righthandman', 'loop', true)
		end
		if curBeat % 4 == 0 then
			objectPlayAnimation('grey', 'loop', true)
			objectPlayAnimation('black', 'idle', true)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Pretender' then
		if curBeat % 2 == 0 then	
			objectPlayAnimation('deadflowerguy', 'loop', true)
		end
		if curBeat % 4 == 0 then
			objectPlayAnimation('black', 'idle', true)
		end

		if curBeat % 8 == 0 and ((curBeat >= 32 and curBeat <= 56) or (curBeat >= 200 and curBeat <= 320) or (curBeat >= 536 and curBeat <= 600)) then
			flash('Red', 0.25, 0.3)
		end
		if (curBeat-8) % 16 == 0 and (curBeat >= 72 and curBeat <= 120) then
			flash('Red', 0.4, 0.4)
		end
		if curBeat % 16 == 0 and (curBeat >= 336 and curBeat <= 384) then
			flash('Red', 0.4, 0.4)
		end
		if curBeat % 4 == 0 and (curBeat >= 136 and curBeat <= 196) then
			flash('Red', 0.3, 0.3)
		end
		if curBeat % 8 == 0 and (curBeat >= 408 and curBeat <= 528) then
			flash('Red', 0.475, 0.45)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if curBeat % 3 == 0 and OppTrail then
		for i=0, 7 do
			noteTweenAlpha('NoteALPHA'..i, i, getRandomInt(35,100)/100, 2, 'sineInOut')
		end
	end
end

function onUpdate(elapsed)
	if songName == 'Pinkwave' then 
		if curStep % smokeRate == 0 and Summoning then
			for i=0, smokeMultPerMils-1 do 
				makeLuaSprite('Smoke'..Smoke, 'MiraHQ/Pink/Happy/BlackParticle', getProperty('black.x')+getRandomFloat(50, 500), getProperty('black.y')+getRandomFloat(0,850))
				scaleObject('Smoke'..Smoke, 0.001, 0.001)
				BlackScale = getRandomFloat(0.75, 1.75)/smokeScaleDiv;
				BlackTime = getRandomInt(18, 30)/50;
				doTweenX('SmokeScaleX'..Smoke, 'Smoke'..Smoke..'.scale', BlackScale, BlackTime, 'sineOut')
				doTweenY('SmokeScaleY'..Smoke, 'Smoke'..Smoke..'.scale', BlackScale, BlackTime, 'sineOut')
				addLuaSprite('Smoke'..Smoke)
				runTimer('Rise'..Smoke, BlackTime/getRandomFloat(0.86,2))
				
				Smoke=Smoke+1; if Smoke >= maxSmoke then Smoke = 0 end
			end
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if OppTrail then --Hallucinating Notes!
		currentBeat = (getSongPosition() / 1000) * (bpm / 60);
		if not middlescroll then
			for i=0, 3 do			
				setPropertyFromGroup('strumLineNotes', i, 'x', _G['defaultPlayerStrumX'..i] + 1 * 24 * math.sin(currentBeat*0.4 + i)) 
				setPropertyFromGroup('strumLineNotes', i+4, 'x', _G['defaultOpponentStrumX'..i] + -1 * 24 * math.sin(currentBeat*0.4 + (i+4))) 
	
				setPropertyFromGroup('strumLineNotes', i, 'y', _G['defaultPlayerStrumY'..i] + 1 * (24/2) * math.sin(currentBeat*0.4 + i * 2)) 
				setPropertyFromGroup('strumLineNotes', i+4, 'y', _G['defaultOpponentStrumY'..i] + 1 * (24/2) * math.sin(currentBeat*0.4 + (i+4) * 2))
			end
		elseif middlescroll then
			setPropertyFromGroup('strumLineNotes', i, 'x', _G['defaultOpponentStrumX'..i] + 1 * 24 * math.sin(currentBeat*0.4 + i)) 
			setPropertyFromGroup('strumLineNotes', i+4, 'x', _G['defaultPlayerStrumX'..i] + -1 * 24 * math.sin(currentBeat*0.4 + (i+4))) 

			setPropertyFromGroup('strumLineNotes', i, 'y', _G['defaultOpponentStrumY'..i] + 1 * (24/2) * math.sin(currentBeat*0.4 + i * 2)) 
			setPropertyFromGroup('strumLineNotes', i+4, 'y', _G['defaultPlayerStrumY'..i] + 1 * (24/2) * math.sin(currentBeat*0.4 + (i+4) * 2))
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
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

function onUpdatePost(elapsed)
	if songName == 'Pinkwave' then
		if Stop then
			setPropertyFromClass('Conductor', 'songPosition', getPropertyFromClass('Conductor', 'songPosition') - elapsed * 1000  ) -- it is counted by milliseconds, 1000 = 1 second
			setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
			setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
		end
	end
	if songName == 'Pretender' then
		--Flip Health Bar
		P1Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) + (150 * getProperty('iconP1.scale.x') - 150) / 2 - 26)
		P2Mult = getProperty('healthBar.x') + ((getProperty('healthBar.width') * getProperty('healthBar.percent') * 0.01) - (150 * getProperty('iconP2.scale.x')) / 2 - 26 * 2)
	
		setProperty('iconP1.x',P1Mult - 105)
		setProperty('iconP1.origin.x',240)
		setProperty('iconP1.flipX',true)
	
		setProperty('iconP2.x',P2Mult + 120)
		setProperty('iconP2.origin.x',-100)
		setProperty('iconP2.flipX',true)
		setProperty('healthBar.flipX',true)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	for b=0, maxSmoke do
		if tag == 'Rise'..b then
			BlackfloatTime = getRandomInt(70, 100)/50;
			doTweenX('SmokeX'..b, 'Smoke'..b, getProperty('Smoke'..b..'.x')+getRandomInt(-200, 200), BlackfloatTime/1.2, 'linear')
			doTweenY('SmokeYUp'..b, 'Smoke'..b, getProperty('black.y')-getRandomInt(100,300), BlackfloatTime, 'sineInOut')
			BlackshrinkTime = getRandomInt(15, 30)/50;
			doTweenX('SmokeXShrink'..b, 'Smoke'..b..'.scale', 0.0001, BlackfloatTime+BlackshrinkTime, 'sineInOut')
			doTweenY('SmokeYShrink'..b, 'Smoke'..b..'.scale', 0.0001, BlackfloatTime+BlackshrinkTime, 'sineInOut')
		end
	end
	
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
	
	if tag == 'ChromReset' then
		setProperty('chromMinimum', 0)
	end
end

function onTweenCompleted(tag)
	if songName == 'Heartbeat' or songName == 'Pinkwave' then
		for i=1, MaxClouds do
			if tag == 'cloudX'..i then
				makeLuaSprite('cloud'..i, 'MiraHQ/Pink/Happy/cloud_'..getRandomInt(1,4), getRandomInt(1500, 2800), getRandomInt(300, 800))
				randomScale = getRandomFloat(2, 4.5)
				scaleObject('cloud'..i, randomScale, randomScale)
				setObjectOrder('cloud'..i, getObjectOrder('cloudDownRight')-1)
				addLuaSprite('cloud'..i)
				doTweenX('cloudX'..i, 'cloud'..i, -2400, getRandomFloat(30, 80))
			end
		end
		
		if tag == 'BigHeartAlpha' then
			setProperty('BigHeart.scale.x', 0.5)
			setProperty('BigHeart.scale.y', 0.5)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Pretender' then
		for i=1, MaxClouds do
			if tag == 'cloudX'..i then
				makeLuaSprite('cloud'..i, 'MiraHQ/Pink/Onslaught/cloud_'..getRandomInt(1,3), getRandomInt(1500, 2800), getRandomInt(300, 800))
				randomScale = getRandomFloat(2, 4.5)
				scaleObject('cloud'..i, randomScale, randomScale)
				setObjectOrder('cloud'..i, getObjectOrder('cloudDownRight')-1)
				addLuaSprite('cloud'..i)
				doTweenX('cloudX'..i, 'cloud'..i, -2400, getRandomFloat(30, 80))
			end
		end
		
		for a=0, MaxTrail-1 do
			if tag == 'OppTrailAlpha'..a then
				removeLuaSrite('OppTrail'..a, false);
			end
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	for p=0, Particle do
		if tag == 'particleY'..p then
			removeLuaSprite('particle'..p)
		end
	end
	
	for a=0, maxSmoke do
		if tag == 'BlackParticleScaleYShrink'..a then
			removeLuaSprite('BlackParticle'..a, true)
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if songName == 'Heartbeat' then
		if ((curStep >= 272 and curStep <= 286) or (curStep >= 528 and curStep <= 542)) and not isSustainNote then
			setGameZoom(0, 0.055, 0)
			xx = xx + 42;
			xx2 = xx2 + 42;
			yy = yy + 27;
			yy2 = yy2 + 27;
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Pinkwave' then
		if curStep >= 1384 and curStep <= 1414 and not isSustainNote then
			setGameZoom(0, 0.025, 0)
			xx = xx + 27;
			xx2 = xx2 + 27;
			yy = yy + 12;
			yy2 = yy2 + 12;
		end
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if cam == 0 then
		cam = 1;
		midCam(false);
		doTweenZoom('CamGameCoolZoomy', 'camGame', 0.775, 0.65, 'sineInOut')
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Pinkwave' then
		if curStep >= 1320 and curStep <= 1350 and not isSustainNote then
			setGameZoom(0, 0.015, 0)
			xx = xx - 15;
			xx2 = xx2 - 15;
			yy = yy + 5;
			yy2 = yy2 + 5;
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Pretender' then
		if OppTrail then
			setProperty('chromMinimum', getProperty('chromMinimum')+0.004)
			runTimer('ChromReset', 0.045)
		else
			setProperty('chromMinimum', getProperty('chromMinimum')+0.0035)
			runTimer('ChromReset', 0.03)
		end
	
		if getProperty('health') >= 1.4 then
			setProperty('health', getProperty('health')-0.035*getProperty('health'))
		else
			setProperty('health', getProperty('health')-0.0025*getProperty('health'))
		end
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

function onDestroy()
	setPropertyFromClass('HealthIcon', 'iconFPS', 17)
end

function onSoundFinished(tag)
	if tag == 'Onslaught' then
		Stop = false;
		setPropertyFromClass('PlayState', 'instance.generatedMusic', true)
	end
end