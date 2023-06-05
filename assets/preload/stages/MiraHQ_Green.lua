local xx = -70;
local yy = 1350;
local xx2 = 175;
local yy2 = 1350;
local ofs = 20;
local followchars = true;
local CZoom = 1.5;
local CZoom = 0.9

local HPDrain = true;

local CBuilding = 0;
local LBuilding = 0;
local RBuilding = 0;
local MaxBuilding = 3;

local CloudAmount = 0;
local MaxCloud = 4;

local Lines = 0;
local MaxLines = 10;

local MoveUpTimer = 0.9; --Must be >= 0.3
local EveythingStop = false;

local Bob = false;
local Mechanic = true;
local Fixable = false;
local ExplodeIn = 5;

function onStartCountdown() --Precache everything first for Ejected before starting the song :v
	if not allowCountdown and not seenCutscene and songName == 'Ejected' then
		setProperty('inCutscene', true)
		runTimer('Begin', 0.25)
		return Function_Stop;
	end
	return Function_Continue;
end


function onCreate()
	addCharacterToList('BF_Dead', 'boyfriend')
	addCharacterToList('BF_FeltDead', 'boyfriend')

	if (songName == "Sussus Toogus" or songName == "Lights Down") then
		makeLuaSprite('floor','MiraHQ/Green/Cafe/mirafg', -2750, 800)
		scaleObject('floor',1.25,1.25)
		addLuaSprite('floor')
		
		makeLuaSprite('bg','MiraHQ/Green/Cafe/mirabg', -2750, 800)
		scaleObject('bg',1.25,1.25)
		addLuaSprite('bg')
	
		makeAnimatedLuaSprite('Vent', 'MiraHQ/Green/Cafe/bf_mira_vent', -320, 940)
		addAnimationByIndices('Vent', 'Vent', 'bf vent', '148', 1)
		addAnimationByPrefix('Vent', 'BF_Vents', 'bf vent', 38, false)
		scaleObject('Vent', 1.4, 1.4)
		addLuaSprite('Vent')
		
		makeLuaSprite('table','MiraHQ/Green/Cafe/table_bg', -2750, 800)
		scaleObject('table',1.25,1.25)
		addLuaSprite('table')
	end
	
	if songName == "Sussus Toogus" then
		makeAnimatedLuaSprite('epicsax', 'MiraHQ/Green/Cafe/powersbg-sax', -1400, 1220)
		addAnimationByPrefix('epicsax', 'play', 'epicsaxguy', 24, false)
		scaleObject('epicsax', 1.4, 1.4)
		setProperty('epicsax.alpha', 0.001);
		addLuaSprite('epicsax', true)
		
		makeLuaSprite('Fanon', 'hudStuffs/Fanon', 0, 1000)
		setObjectCamera('Fanon', 'other');
		addLuaSprite('Fanon', true)
	end
	if songName == "Lights Down" then
		makeLuaSprite('BlackBG', '', -1400, 800)
		makeGraphic('BlackBG', 3000, 1500, '000000')
		setProperty('BlackBG.alpha', 0)
		addLuaSprite('BlackBG', false)
		
		makeLuaSprite('BlackBGFront', '', -1400, 800)
		makeGraphic('BlackBGFront', 3000, 1500, '000000')
		setProperty('BlackBGFront.alpha', 0)
		addLuaSprite('BlackBGFront', true)
		
		makeLuaSprite('Vignette', 'MiraHQ/Green/Cafe/lightsVignette', -1200, 600)
		setProperty('Vignette.alpha', 0)
		scaleObject('Vignette', 0.65, 0.65)
		addLuaSprite('Vignette', true)
		
		makeLuaSprite('Dark', '', -1200, 600)
		makeGraphic('Dark', 3000, 2000, '000000')
		setProperty('Dark.alpha', 0)
		addLuaSprite('Dark', true)
		
		makeAnimatedLuaSprite('SpeakerAlone', 'MiraHQ/Green/Cafe/stereo_taken', -290, 1255)
		addAnimationByPrefix('SpeakerAlone', 'Bye', 'stereo', 24, false)
		setProperty('SpeakerAlone.alpha', 0.001);
		addLuaSprite('SpeakerAlone')
	end
	
	if songName == 'Reactor' then
		makeLuaSprite('wall','MiraHQ/Green/Reactor/wallbgthing', -1550, 250)
		addLuaSprite('wall')
		
		makeLuaSprite('floor','MiraHQ/Green/Reactor/floornew', -1550, 250)
		addLuaSprite('floor')
		
		makeAnimatedLuaSprite('mungus1', 'MiraHQ/Green/Reactor/bgmungus1', -650, 1150)
		addAnimationByPrefix('mungus1', 'Bop', 'yallow', 24, false)
		addLuaSprite('mungus1')
		
		makeLuaSprite('BP1','MiraHQ/Green/Reactor/backbars', -1550, 250)
		addLuaSprite('BP1')
		
		makeAnimatedLuaSprite('core', 'MiraHQ/Green/Reactor/ball lol', -275, 250)
		addAnimationByPrefix('core', 'Reactor_Thing_I_guess', 'core instance', 24, true)
		setScrollFactor('core', 0.9, 0.9);
		addLuaSprite('core')
		
		makeAnimatedLuaSprite('mingus2', 'MiraHQ/Green/Reactor/bgmungus2', -1080, 1200)
		addAnimationByPrefix('mingus2', 'Bop','brown',24,false)
		scaleObject('mingus2', 1, 1);
		addLuaSprite('mingus2')
		
		makeLuaSprite('darksc','MiraHQ/Green/Reactor/frontblack', 0, 0)	
		setProperty('darksc.alpha', 0.25);
		setObjectCamera('darksc', 'other');
		addLuaSprite('darksc')
		
		makeAnimatedLuaSprite('Glow', 'MiraHQ/Green/Reactor/yeahman', -2000, -900)
		addAnimationByPrefix('Glow', 'Glow', 'Reactor', 24, true)
		scaleObject('Glow', 2, 2);
		addLuaSprite('Glow', true)
		
		makeAnimatedLuaSprite('Panel', 'hudStuffs/Pad', 390.4, 750) --Y = 110.4
		addAnimationByPrefix('Panel', 'Danger', 'PadClick', 20, true)
		addAnimationByPrefix('Panel', 'Safe', 'PadConfirm', 24, false)
		scaleObject('Panel', 0.8, 0.8)
		-- screenCenter('Panel')
		-- debugPrint(getProperty('Panel.x')..' '..getProperty('Panel.y'))
		setObjectCamera('Panel', 'camHUD')
		addLuaSprite('Panel')
		
		makeLuaText('ReactorTime', "10", 100, getProperty('Panel.x')+210, getProperty('Panel.y')+330) --Y = getProperty('Panel.y')+330
		setTextSize('ReactorTime', 35)
		setTextBorder('ReactorTime', 2.5, '000000')
		setTextColor('ReactorTime', 'FF2929')
		setTextAlignment('ReactorTime', 'center')
		setTextFont('ReactorTime', 'Gravedigger.otf')
		setObjectCamera('ReactorTime', 'camHUD')
		addLuaText('ReactorTime')
		
		makeLuaSprite('BlackScreen', '', 0, 0)
		makeGraphic('BlackScreen', 1300, 750, '000000')
		setObjectCamera('BlackScreen','other')
		addLuaSprite('BlackScreen', true)
		doTweenAlpha('BlackScreenAlpha', 'BlackScreen', 0, 1, 'sineInOut')
	end
	
	if songName == 'Ejected' then
		setProperty('skipCountdown', true)
		setPropertyFromClass('GameOverSubstate', 'characterName', 'BF_FeltDead')
		setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'ejected_death')
		
		makeLuaSprite('sky','MiraHQ/Green/Atmosphere/sky', -2700, 0)
		setScrollFactor('sky', 0.3, 0.3);
		addLuaSprite('sky')
		doTweenY('FallingDown', 'sky', -4700, songLength/1000, 'sineInOut')
		
		makeLuaSprite('cloudbg','MiraHQ/Green/Atmosphere/fgClouds', -550, 2300)
		setScrollFactor('cloudbg', 0.2, 0.2);
		scaleObject('cloudbg', 0.35, 0.35)
		addLuaSprite('cloudbg')
		doTweenY('CloudBGY', 'cloudbg', 200, (songLength/1000)/1.5, 'sineOut')
		
		----------------------------------------------------------------------------------------------
		--PreCache the Buildings:
		for i=0, 3 do
			if getRandomInt(1, 2) == 1 then
				makeLuaSprite('CenterBuilding'..CBuilding, 'MiraHQ/Green/Atmosphere/buildingA', -300, 2650)
				scaleObject('CenterBuilding'..CBuilding,0.35,0.35)
			else
				makeLuaSprite('CenterBuilding'..CBuilding, 'MiraHQ/Green/Atmosphere/buildingA2', -300, 2650)
			end
			if getRandomInt(1, 2) == 1 then setProperty('CenterBuilding'..CBuilding..'.flipX', true) else setProperty('CenterBuilding'..CBuilding..'.flipX', false) end
			addLuaSprite('CenterBuilding'..CBuilding)
			
			makeLuaSprite('LeftBuilding'..LBuilding, 'MiraHQ/Green/Atmosphere/buildingB', getProperty('CenterBuilding'..CBuilding..'.x')-350, getProperty('CenterBuilding'..CBuilding..'.y')-700)
			scaleObject('LeftBuilding'..LBuilding, 0.35, 0.35)
			if getRandomInt(1, 2) == 1 then setObjectOrder('LeftBuilding'..LBuilding, getObjectOrder('CenterBuilding'..CBuilding)) end
			if getRandomInt(3, 4) == 3 then setProperty('LeftBuilding'..LBuilding..'.flipY', true) end
			if getRandomInt(5, 6) == 5 then setProperty('LeftBuilding'..LBuilding..'.flipX', true) end
			addLuaSprite('LeftBuilding'..LBuilding)
			
			makeLuaSprite('RightBuilding'..RBuilding, 'MiraHQ/Green/Atmosphere/buildingB', getProperty('CenterBuilding'..CBuilding..'.x')+460, getProperty('CenterBuilding'..CBuilding..'.y')-700)
			scaleObject('RightBuilding'..RBuilding, 0.35, 0.35)
			if getRandomInt(1, 2) == 1 then setObjectOrder('RightBuilding'..RBuilding, getObjectOrder('CenterBuilding'..CBuilding)) end
			if getRandomInt(3, 4) == 3 then setProperty('RightBuilding'..RBuilding..'.flipY', true) end
			if getRandomInt(5, 6) == 5 then setProperty('RightBuilding'..RBuilding..'.flipX', true) end
			addLuaSprite('RightBuilding'..RBuilding)
			
			doTweenY('CBuildUp'..CBuilding, 'CenterBuilding'..CBuilding, getProperty('CenterBuilding'..CBuilding..'.y')-4250, MoveUpTimer)
			doTweenY('LBuildUp'..LBuilding, 'LeftBuilding'..LBuilding, getProperty('LeftBuilding'..CBuilding..'.y')-4250, MoveUpTimer)
			doTweenY('RBuildUp'..RBuilding, 'RightBuilding'..RBuilding, getProperty('RightBuilding'..CBuilding..'.y')-4250, MoveUpTimer)
			
			CBuilding = CBuilding + 1;
			LBuilding = LBuilding + 1;
			RBuilding = RBuilding + 1;
		end
		
		runTimer('GenerateNewBuilding', MoveUpTimer-0.25, 0)
		----------------------------------------------------------------------------------------------	

		makeAnimatedLuaSprite('Green_FreeFalling', 'MiraHQ/Green/Atmosphere/greencut', -300, 100)
		addAnimationByPrefix('Green_FreeFalling', 'Follow', '1cut', 24, true)
		addAnimationByPrefix('Green_FreeFalling', 'Glow', '2cut', 24, true)
		setScrollFactor('Green_FreeFalling', 0.7, 0.7)
		scaleObject('Green_FreeFalling', 0.825, 0.825)
		addLuaSprite('Green_FreeFalling', true)
		runTimer('ByeBF', 5.40)

		makeAnimatedLuaSprite('BF_FreeFalling', 'MiraHQ/Green/Atmosphere/wee', 300 , 800)
		addAnimationByPrefix('BF_FreeFalling', 'Falling', 'weeeeee', 26, true)
		setScrollFactor('BF_FreeFalling', 0.7, 0.7)
		scaleObject('BF_FreeFalling', 0.5, 0.5)
		addLuaSprite('BF_FreeFalling', true)
		
		makeLuaSprite('RedBG', '', -2500, 0)
		makeGraphic('RedBG', 3500, 3000, 'C80C01')
		setProperty('RedBG.alpha', 0.0001)
		addLuaSprite('RedBG', false)
		
		makeLuaSprite('BlackScreen', '', 0, 0)
		makeGraphic('BlackScreen', 1300, 750, '000000')
		setObjectCamera('BlackScreen','other')
		addLuaSprite('BlackScreen', true)
		doTweenAlpha('BlackScreenAlpha', 'BlackScreen', 0, 7, 'sineInOut')
		
		setPropertyFromClass('HealthIcon', 'iconFPS', bpm/6)
		setProperty('losingValue', 40)
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	makeLuaSprite('RedFlash', '', 0, 0)
	makeGraphic('RedFlash', 1300, 750, 'FF1000')
	setObjectCamera('RedFlash','hud')
	if songName == 'Sussus Toogus' then setObjectCamera('RedFlash','other') end
	setProperty('RedFlash.alpha', 0.0001)
	addLuaSprite('RedFlash', true)
	
	makeLuaSprite('BarUp', '', 0, -110)	--Default y = 0
	makeGraphic('BarUp', 1280, 105, '000000')
	setObjectCamera('BarUp', 'camOther')
	addLuaSprite('BarUp')
	
	makeLuaSprite('BarDown', '', 0, 735) --Default y = 620
	makeGraphic('BarDown', 1280, 105, '000000')
	setObjectCamera('BarDown', 'camOther')
	addLuaSprite('BarDown')
	
	addCharacterToList('BF_Dark', 'boyfriend')
	addCharacterToList('bf', 'boyfriend')
	addCharacterToList('Green_Dark', 'dad')
	addCharacterToList('Green_Imposter', 'dad')
end

function onCreatePost()
	if songName == "Sussus Toogus" then
		setProperty('scoreTxt.alpha', 0)
		setProperty('healthBar.alpha', 0)
		setProperty('iconP1.alpha', 0)
		setProperty('iconP2.alpha', 0)
		for i=0, 3 do
			if not downscroll then
				setPropertyFromGroup('strumLineNotes', i, 'y', _G['defaultOpponentStrumY'..i] - 180) 
				setPropertyFromGroup('strumLineNotes', i+4, 'y', _G['defaultPlayerStrumY'..i] - 180)
			elseif downscroll then
				setPropertyFromGroup('strumLineNotes', i, 'y', _G['defaultOpponentStrumY'..i] + 180) 
				setPropertyFromGroup('strumLineNotes', i+4, 'y', _G['defaultPlayerStrumY'..i] + 180)
			end
		end
		xx = 100;
		yy = 1350;
		xx2 = 100;
		yy2 = 1350;
	end
	if songName == "Reactor" then
		setProperty('defaultCamZoom', 0.75) --Default/Lowest: 0.6
		setProperty('dad.x', -810)
		setProperty('dad.y', 1060)
		setProperty('boyfriend.x', 450)
		setProperty('boyfriend.y', 1330)
		setProperty('gf.x', 20)
		setProperty('gf.y', 1300)
		xx = -50;
		yy = 1380; 		
		xx2 = 300; 		
		yy2 = 1380;
	end
	if songName == "Ejected" then
		setProperty('scoreTxt.color', getColorFromHex('336633'))
		
		setProperty('dad.x', -950)
		setProperty('dad.y', 1000)
		setProperty('boyfriend.x', 50)
		setProperty('boyfriend.y', 1480)
		setProperty('gf.x', 200)
		setProperty('gf.y', 0)
		scaleObject('gf', 0.8, 0.8)
		setProperty('dad.alpha', 0.01)
		setProperty('boyfriend.alpha', 0.01)
		setProperty('gf.alpha', 0.01)
		setProperty('camHUD.alpha', 0.01)
		cinematicView(true, 0.01)
		
		xx = -50; xx2 = -50; yy = 1100; yy2 = 1100; CZoom = 0.85; CZoom1 = 0.5;
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	triggerEvent('Camera Follow Pos', xx, yy)
	if songName ~= 'Ejected' then
		setProperty('scoreTxt.color', getColorFromHex('31AE38'))
	end
end

function reactorFix(bool)
	if bool then
		Fixable = true;
		objectPlayAnimation('Panel', 'Danger', true)
		setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)
		playSound('Panel Generic Appear', 1)
		setProperty('ReactorTime.alpha', 1)
		doTweenY('PanelUp', 'Panel', 110.4, 0.35, 'backOut')
		doTweenY('TimerUp', 'ReactorTime', 440.4, 0.35, 'backOut')
		
		ExplodeIn = getRandomInt(3, 5);
		setTextString('ReactorTime', ''..ExplodeIn);
		runTimer('TimeLeft', 1)
	end
end

function lightSabotage(bool)
	if bool == 'dark' then
		cameraFlash('camHUD', '0x000000', 0.75, true)
		setProperty('Vignette.alpha', 1)
		setProperty('Dark.alpha', 0.4)
	elseif bool == 'darker' then
		setProperty('Vignette.alpha', 1)
		setProperty('Dark.alpha', 0.4)
	elseif bool == 'light' then
		setProperty('Vignette.alpha', 0)
		setProperty('Dark.alpha', 0)
	elseif bool == 'lighter' then
		if flashingLights then
			cameraFlash('camHUD', '0xFFFFFF', 0.5, true)
			setProperty('Vignette.alpha', 0)
			setProperty('Dark.alpha', 0)
		elseif not flashingLights then
			doTweenAlpha('VignetteAlpha', 'Vignette', 0, 0.5)
			doTweenAlpha('DarkAlpha', 'Dark', 0, 0.5)
		end
	elseif bool == true then
		setProperty('BlackBG.alpha', 1)
		setProperty('BlackBGFront.alpha', 0)
		if flashingLights then
			cameraFlash('camHUD', '0xFFFFFF', 0.5, true)
		elseif not flashingLights then
			cameraFlash('camHUD', '0x000000', 0.5, true)
		end
		triggerEvent('Change Character', 0, 'BF_Dark')
		triggerEvent('Change Character', 1, 'Green_Dark')
		setProperty('gf.alpha', 0)
		cancelTween('scoreColor')
		setProperty('scoreTxt.color', getColorFromHex('000000'))
		setProperty('healthBar.alpha', 0)
		setProperty('iconP1.alpha', 0)
		setProperty('iconP2.alpha', 0)
		setProperty('winningAltAnim', false)
	elseif bool == false then
		setProperty('BlackBG.alpha', 0)
		setProperty('BlackBGFront.alpha', 1)
		doTweenAlpha('BlackBGFrontAlpha', 'BlackBGFront', 0, 0.5)	
		triggerEvent('Change Character', 0, 'bf')
		triggerEvent('Change Character', 1, 'Green_Imposter')
		setProperty('gf.alpha', 1)
		doTweenColor('scoreColor', 'scoreTxt', '31AE38', 1)
		doTweenAlpha('healthBarAlpha', 'healthBar', 1, 0.25)
		doTweenAlpha('iconP1Alpha', 'iconP1', 1, 0.25)
		doTweenAlpha('iconP2Alpha', 'iconP2', 1, 0.25)
	elseif bool == 'instance' then
		setProperty('BlackBG.alpha', 0)
		setProperty('BlackBGFront.alpha', 0)
		triggerEvent('Change Character', 0, 'bf')
		triggerEvent('Change Character', 1, 'Green_Imposter')
	end
end

function flash(flashType, startAlpha, fadeTimer)
	if flashType == "Red" and flashingLights then
		setProperty('RedFlash.alpha', startAlpha)
		doTweenAlpha('FlashBye', 'RedFlash', 0, fadeTimer, 'sineInOut')
		triggerEvent('Add Camera Zoom', 0.035, 0.06)
		if songName == 'Sussus Toogus' then playSound('Alarm', 0.25) end
	end
end

local BoppingPerBeat = 4;

function midCam(bool)
	if bool then
		BoppingPerBeat = getRandomInt(1, 2);
		xx = 170;
		yy = 1300;
		xx2 = 170;
		yy2 = 1300;
		setProperty('defaultCamZoom', 0.6)
		triggerEvent('Change Scroll Speed', 1.03, 2)
	elseif not bool then
		BoppingPerBeat = 4;
		xx = -50;
		yy = 1380; 		
		xx2 = 300; 		
		yy2 = 1380;	
		setProperty('defaultCamZoom', getRandomInt(70, 85)/100)
		triggerEvent('Change Scroll Speed', 1, 2)
	end
end

function cinematicView(bool, transitionTimer)
	if bool then
		setBlendMode('RedFlash', 'ADD')
		doTweenY('BarUpY', 'BarUp', 0, transitionTimer, 'sineOut')
		doTweenY('BarDownY', 'BarDown', 620, transitionTimer, 'sineOut')
		if not downscroll then
			doTweenY('camHUDY', 'camHUD', 40, transitionTimer, 'sineOut')
		elseif downscroll then
			doTweenY('camHUDY', 'camHUD', -40, transitionTimer, 'sineOut')
		end
		doTweenAlpha('healthBarAlpha', 'healthBar', 0, transitionTimer)
		doTweenAlpha('iconP1Alpha', 'iconP1', 0, transitionTimer)
		doTweenAlpha('iconP2Alpha', 'iconP2', 0, transitionTimer)
		for i=0, 7 do
			noteTweenAngle('Spin'..i, i, 360, transitionTimer, 'sineOut')
			if not downscroll then
				noteTweenY('Y'..i, i, 80, transitionTimer, 'backOut')
			elseif downscroll then
				noteTweenY('Y'..i, i, 540, transitionTimer, 'backOut')
			end
		end
	elseif not bool then
		setBlendMode('RedFlash', 'NORMAL')
		doTweenY('BarUpY', 'BarUp', -110, transitionTimer, 'sineInOut')
		doTweenY('BarDownY', 'BarDown', 735, transitionTimer, 'sineInOut')
		if not downscroll then
			doTweenY('camHUDY', 'camHUD', 0, transitionTimer, 'sineInOut')
		elseif downscroll then
			doTweenY('camHUDY', 'camHUD', 0, transitionTimer, 'sineInOut')
		end
		doTweenAlpha('healthBarAlpha', 'healthBar', 1, transitionTimer)
		doTweenAlpha('iconP1Alpha', 'iconP1', 1, transitionTimer)
		doTweenAlpha('iconP2Alpha', 'iconP2', 1, transitionTimer)
		if not downscroll then
			for i=0, 3 do
				noteTweenY('NoteY'..i, i, _G['defaultOpponentStrumY'..i], transitionTimer, 'backInOut')
				noteTweenY('NoteY'..i+4, i+4, _G['defaultPlayerStrumY'..i], transitionTimer, 'backInOut')
				noteTweenAngle('Spin'..i, i, 0, transitionTimer, 'sineInOut')
				noteTweenAngle('Spin'..i+4, i+4, 0, transitionTimer, 'sineInOut')
			end
		end
	end
end

function onSongStart()
	if songName == 'Sussus Toogus' then
		doTweenY('FanonUp', 'Fanon', 0, 2, 'sineOut');
		runTimer('FanonOut', 5);
	end
	if songName == 'Reactor' then
		flash('Red', 0.4, 0.4)
	end
end

function onCountdownTick(counter)
	if songName == 'Reactor' then
		if counter % 4 == 0 then
			objectPlayAnimation('mungus1', 'Bop', true)
			objectPlayAnimation('mingus2', 'Bop', true)
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'Begin' then
		allowCountdown = true;
		startCountdown();
	end

	if tag == 'FanonOut' then
		doTweenAlpha('FanonBye', 'Fanon', 0, 3)
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if tag == 'MechanicOn' then
		Mechanic = true;
	end
	
	if tag == 'TimeLeft' and Fixable then
		ExplodeIn = ExplodeIn - 1;
		setTextString('ReactorTime', ''..ExplodeIn)
		if ExplodeIn > 0 then
			runTimer('TimeLeft', 1)
		else
			runTimer('Boom', 0.15)
		end
	end
	if tag == 'PanelDown' then
		doTweenY('PanelUp', 'Panel', 750, 0.2, 'sineIn')
		doTweenY('TimerUp', 'ReactorTime', 750+330, 0.2, 'sineIn')
		playSound('Panel Generic Disappear', 1);
	end
	if tag == 'Boom' and Fixable then
		setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'Exploded')
		setProperty('health', -2)
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Ejected' then
		if tag == 'ByeBF' then
			doTweenY('GetOutOfTheWayBF', 'BF_FreeFalling', getProperty('BF_FreeFalling.y')+600, 2)
			doTweenX('GetOutOfTheWayBF', 'BF_FreeFalling', getProperty('BF_FreeFalling.x')+600, 2)
			doTweenY('GreenIsComing', 'Green_FreeFalling', getProperty('Green_FreeFalling.y')+500, 4, 'sineOut')
			setProperty('cameraSpeed', 0.6)
			xx = -350; xx2 = -350; yy = 950; yy2 = 950; CZoom = 1.15; CZoom1 = 1.15;
		end
		if tag == 'ZoomInNow' then
			CZoom = 1.25; CZoom1 = 1.25;
			doTweenZoom('camGameZoomInNow', 'camGame', 1.25, 10, 'sineInOut')
		end
		if tag == 'SoDark' then
			doTweenColor('RedBGTurnsBlack', 'RedBG', '000000', 4, 'sineOut')
			
			runTimer('LetsGO', 7.78)
		end
		if tag == 'LetsGO' then
			CZoom = 1.1; CZoom1 = 1.1;
			doTweenZoom('camGameZoomOUT', 'camGame', 1.1, 1.25, 'sineInOut')
			doTweenAngle('EyeAlpha', 'Green_FreeFalling', -130, 1.2, 'backInOut')
			doTweenX('EyeX', 'Green_FreeFalling', getProperty('Green_FreeFalling.x')-250, 1.2, 'backInOut')
			doTweenY('EyeY', 'Green_FreeFalling', getProperty('Green_FreeFalling.y')-40, 1.2, 'backInOut')
		end
		-----------------------------------------------------------------------------------
		if tag == 'GenerateNewBuilding' then
			CBuilding = CBuilding + 1;	if CBuilding >= MaxBuilding then CBuilding = 0 end;
			LBuilding = LBuilding + 1;	if LBuilding >= MaxBuilding then LBuilding = 0 end;
			RBuilding = RBuilding + 1;	if RBuilding >= MaxBuilding then RBuilding = 0 end;
			
			if getRandomInt(1, 2) == 1 then
				makeLuaSprite('CenterBuilding'..CBuilding, 'MiraHQ/Green/Atmosphere/buildingA', -300, 2650)
				scaleObject('CenterBuilding'..CBuilding,0.35,0.35)
			else
				makeLuaSprite('CenterBuilding'..CBuilding, 'MiraHQ/Green/Atmosphere/buildingA2', -300, 2650)
			end
			if getRandomInt(1, 2) == 1 then setProperty('CenterBuilding'..CBuilding..'.flipX', true) end
			setObjectOrder('CenterBuilding'..CBuilding, getObjectOrder('RedBG')-1)
			addLuaSprite('CenterBuilding'..CBuilding)
			
			makeLuaSprite('LeftBuilding'..LBuilding, 'MiraHQ/Green/Atmosphere/buildingB', getProperty('CenterBuilding'..CBuilding..'.x')-350, getProperty('CenterBuilding'..CBuilding..'.y')-700)
			scaleObject('LeftBuilding'..LBuilding, 0.35, 0.35)
			setObjectOrder('LeftBuilding'..LBuilding, getObjectOrder('RedBG')-1)
			if getRandomInt(1, 2) == 1 then setObjectOrder('LeftBuilding'..LBuilding, getObjectOrder('CenterBuilding'..CBuilding)-1) end
			if getRandomInt(3, 4) == 3 then setProperty('LeftBuilding'..LBuilding..'.flipY', true) end
			if getRandomInt(5, 6) == 5 then setProperty('LeftBuilding'..LBuilding..'.flipX', true) end
			addLuaSprite('LeftBuilding'..LBuilding)
			
			makeLuaSprite('RightBuilding'..RBuilding, 'MiraHQ/Green/Atmosphere/buildingB', getProperty('CenterBuilding'..CBuilding..'.x')+460, getProperty('CenterBuilding'..CBuilding..'.y')-700)
			scaleObject('RightBuilding'..RBuilding, 0.35, 0.35)
			setObjectOrder('RightBuilding'..RBuilding, getObjectOrder('RedBG')-1)
			if getRandomInt(1, 2) == 1 then setObjectOrder('RightBuilding'..RBuilding, getObjectOrder('CenterBuilding'..CBuilding)-1) end
			if getRandomInt(3, 4) == 3 then setProperty('RightBuilding'..RBuilding..'.flipY', true) end
			if getRandomInt(5, 6) == 5 then setProperty('RightBuilding'..RBuilding..'.flipX', true) end
			addLuaSprite('RightBuilding'..RBuilding)
			
			doTweenY('CBuildUp'..CBuilding, 'CenterBuilding'..CBuilding, getProperty('CenterBuilding'..CBuilding..'.y')-4250, MoveUpTimer)
			doTweenY('LBuildUp'..LBuilding, 'LeftBuilding'..LBuilding, getProperty('LeftBuilding'..CBuilding..'.y')-4250, MoveUpTimer)
			doTweenY('RBuildUp'..RBuilding, 'RightBuilding'..RBuilding, getProperty('RightBuilding'..CBuilding..'.y')-4250, MoveUpTimer)
			
			if EveythingStop then 
				setProperty('CenterBuilding'..CBuilding..'.alpha', 0)
				setProperty('LeftBuilding'..LBuilding..'.alpha', 0)
				setProperty('RightBuilding'..RBuilding..'.alpha', 0)
			end
		end
	end
end

function onTweenCompleted(tag)
	if tag == 'epicsaxJumps' then
		doTweenY('epicsaxBye', 'epicsax', 1900, 3, 'sineIn')
	end
	if tag == 'epicsaxBye' then
		removeLuaSprite('epicsaxBye', true)
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Ejected' then
		for i=0, MaxBuilding+1 do
			if tag == 'CBuildUp'..i then
				removeLuaSprite('CenterBuilding'..i)
				removeLuaSprite('LeftBuilding'..i)
				removeLuaSprite('RightBuilding'..i)
			end
		end
		
		for j=0, MaxCloud do
			if tag == 'CloudY'..j then
				removeLuaSprite('Cloud'..j)
			end
		end
		
		for l=0, MaxLines do
			if tag == 'SpeedY'..l then
				removeLuaSprite('SpeedLines'..l)
			end
		end
	end
end

function onStepHit()
	if songName == "Sussus Toogus" then
		if curStep == 108 then --112
			xx = -370;
			yy = 1350;
		end
		if curStep == 128 then
			setProperty('defaultCamZoom', 0.8)
			xx = -70;
			yy = 1320;
			xx2 = 175;
			yy2 = 1370;
			doTweenAlpha('scoreAlpha', 'scoreTxt', 1, 0.5)
			doTweenAlpha('healthBarAlpha', 'healthBar', 1, 0.75)
			doTweenAlpha('iconP1Alpha', 'iconP1', 1, 1)
			doTweenAlpha('iconP2Alpha', 'iconP2', 1, 1)
		end
		if curStep == 896 then
			doTweenAlpha('camHUDAlpha', 'camHUD', 0, 1)
			doTweenAlpha('epicsaxAlpha', 'epicsax', 1, 0.5, 'linear');
			objectPlayAnimation('epicsax','play', true);
			doTweenX('sassySlide', 'epicsax', 1000, 16, 'linear');
		end
		if curStep == 1024 then
			doTweenAlpha('camHUDAlpha', 'camHUD', 1, 1)
		end
		
		if curStep == 1472 then --1472
			scaleObject('epicsax', 1, 1)
			setProperty('epicsax.flipX', true)
			setProperty('epicsax.x', 200)
			setProperty('epicsax.y', 1900)
			objectPlayAnimation('epicsax', 'play', true)
			doTweenY('epicsaxJumps', 'epicsax', 1370, 0.4, 'backOut')
		end
		
		if curStep == 772 or curStep == 888 or curStep == 892 then
			flash('Red', 0.25, 0.3)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == "Lights Down" then
		if curStep == 128 then
			lightSabotage('dark');
		end
		if curStep == 768 or curStep == 1104 then
			lightSabotage('darker');
		end
		if curStep == 256 or curStep == 512 or curStep == 1600 then
			lightSabotage('light');
		end
		if curStep == 832 then
			lightSabotage('lighter');
		end
		if curStep == 256 or curStep == 640 or curStep == 784 or curStep == 1088 or curStep == 1120 or curStep == 1152 or curStep == 1184 or curStep == 1192 or curStep == 1200 or curStep == 1216 or curStep == 1472 then
			lightSabotage(true);
		end
		if curStep == 512 or curStep == 768 or curStep == 800 or curStep == 1104 or curStep == 1136 or curStep == 1168 or curStep == 1188 or curStep == 1196 or curStep == 1208 or curStep == 1451 then
			lightSabotage(false);
		end
		if curStep == 1600 then -- 1600
			lightSabotage('instance');
			setProperty('SpeakerAlone.alpha', 1);
			setProperty('boyfriend.alpha', 0)
			setProperty('gf.alpha', 0)
			setProperty('camHUD.alpha', 0)
			objectPlayAnimation('Vent', 'BF_Vents', true)
			objectPlayAnimation('SpeakerAlone', 'Bye', true)
			characterPlayAnim('dad', 'cut', true)
			setProperty('dad.specialAnim', true)
			xx = -120;
			yy = 1320;
			xx2 = -120;
			yy2 = 1320;
			triggerEvent('Camera Follow Pos', xx, yy)
		end
		if curStep == 1645 then
			setProperty('camGame.alpha', 0)
			setProperty('camHUD.alpha', 0)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == "Reactor" then
		if curStep == 504 or curStep == 1280 then
			cinematicView(true, 0.5);
		end
		if curStep == 768 then
			cinematicView(false, 0.75);
		end
		if curStep == 1792 then
			cinematicView(false, 2);
		end
		if curStep == 2176 then
			cinematicView(true, 0.2);
		end
		if curStep == 2432 then
			cinematicView(false, 0.2);
		end
		if curStep >= 2432 then
			triggerEvent('Change Scroll Speed', 1.125, 1)
		end
		if curStep == 1264 or curStep == 1266 then
			cinematicView(true, 0.05);
		elseif curStep == 1265 or curStep == 1267 then	
			cinematicView(false, 0.05);
		end
		
		if curStep == 128 then
			xx = 170;
			yy = 1300;
			xx2 = 170;
			yy2 = 1300;
			setProperty('defaultCamZoom', 0.6)
			doTweenZoom('camGameZoom', 'camGame', 0.6, 6.72, 'sineInOut')
		end
		if curStep == 512 or curStep == 1280 or curStep == 2176 then
			midCam(true)
		end
		if curStep == 256 or curStep == 768 or curStep == 1536 or curStep == 2432 or curStep == 2688 then
			midCam(false)
		end
		if curStep == 2688 then
			triggerEvent('Add Camera Zoom', 0.05, 0.05)
			xx = 170;
			yy = 1300;
			xx2 = 170;
			yy2 = 1300;
			setProperty('defaultCamZoom', 0.6)
			doTweenZoom('camGameZoom', 'camGame', 0.6, 6.72, 'sineInOut')
			doTweenAlpha('camHUDAlpha', 'camHUD', 0, 10)
			Bob = false;
			Mechanic = false;
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == "Ejected" then
		if curStep == 110 then
			removeLuaSprite('BF_FreeFalling', true)
			cameraFlash('camOther', '0xFFFFFF', 0.5, false)
			objectPlayAnimation('Green_FreeFalling', 'Glow', true)
			setProperty('chromMinimum', 0.0025)
			EveythingStop = true;
			for l=0, MaxLines do
				cancelTween('SpeedY'..l)
				removeLuaSprite('SpeedLines'..l)
			end
			for c=0, MaxCloud do
				cancelTween('CloudY'..c)
				removeLuaSprite('Cloud'..c)
			end
			for b=0, MaxBuilding do
				setProperty('CenterBuilding'..b..'.alpha', 0)
				setProperty('LeftBuilding'..b..'.alpha', 0)
				setProperty('RightBuilding'..b..'.alpha', 0)
			end

			CZoom = 0.7; CZoom1 = 0.7;
			doTweenZoom('camGameZoomOUT', 'camGame', 0.7, 0.3, 'backOut')
			setProperty('RedBG.alpha', 1)
			
			runTimer('ZoomInNow', 0.5)
			runTimer('SoDark', 5.5)
		end
		if curStep == 252 then
			EveythingStop = false;
		end
		if curStep == 256 then
			cancelTween('EyeAlpha')
			cancelTween('EyeX')
			cancelTween('EyeY')
			removeLuaSprite('Green_FreeFalling', true)
			removeLuaSprite('RedBG', true)
			
			cameraFlash('camOther', '0xFFFFFF', 1, true)
			setProperty('chromMinimum', 0)
		
			cinematicView(false, 0.01)
			xx = -200;
			yy = 1350;	
			xx2 = -170; 		
			yy2 = 1350;
			CZoom = 1.25; --1.25
			CZoom1 = 0.9;
			setProperty('camFollowPos.x', -200)
			setProperty('camFollowPos.y', 1350)
			setProperty('camFollow.x', -200)
			setProperty('camFollow.y', 1350)
			setProperty('dad.alpha', 1)
			setProperty('boyfriend.alpha', 1)
			setProperty('gf.alpha', 1)
			setProperty('cameraSpeed', 2)
			setProperty('camHUD.alpha', 1)
			followchars = true;
		end
		if curStep >= 288 and curStep <= 290 then
			doTweenY('gfY', 'gf', 840, 3, 'sineOut')
		end
		
		if getRandomInt(1,3) == 2 and not EveythingStop then
			makeLuaSprite('SpeedLines'..Lines,'MiraHQ/Green/Atmosphere/speedLines', getRandomInt(-1250, 400), 1900)
			randomScale = getRandomInt(10, 80)/100;
			scaleObject('SpeedLines'..Lines, randomScale, randomScale)
			setProperty('SpeedLines'..Lines..'.alpha', getRandomInt(20, 40)/100)
			addLuaSprite('SpeedLines'..Lines, true)
			
			doTweenY('SpeedY'..Lines, 'SpeedLines'..Lines, getProperty('SpeedLines'..Lines..'.y')-1600, MoveUpTimer/1.5)
			
			Lines = Lines + 1; if Lines >= MaxLines then Lines = 0 end
		end
	end
end

function onBeatHit()
	if songName == "Sussus Toogus" then
		if curBeat == 27 then
			BoingNum = 1;
			NoteInt = 0;
		end
		if (curBeat >= 28 and curBeat < 32) or (curBeat >= 156 and curBeat < 160) then
			triggerEvent('Add Camera Zoom', 0.05, 0.025)
		
			characterPlayAnim('dad', 'boing'..BoingNum, true)
			BoingNum = BoingNum + 1;
			if BoingNum >= 3 then
				BoingNum = 1;
			end
			
			if curBeat >= 28 and curBeat < 32 then
				noteTweenY('NoteY'..NoteInt, NoteInt, _G['defaultOpponentStrumY'..NoteInt], 0.25, 'backOut')
				noteTweenY('NoteY'..(7-NoteInt), (7-NoteInt), _G['defaultPlayerStrumY'..(3-NoteInt)], 0.25, 'backOut')
				NoteInt = NoteInt + 1;
			end
		end
		
		if curBeat % 16 == 0 and ((curBeat >= 80 and curBeat <= 208) or (curBeat >= 224 and curBeat <= 436)) then
			flash('Red', 0.25, 0.3)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Reactor' then
		if curBeat % BoppingPerBeat == 0 then
			objectPlayAnimation('mungus1', 'Bop', true)
			objectPlayAnimation('mingus2', 'Bop', true)
		end
		if curBeat <= 712 and curBeat % 8 == 0 then
			flash('Red', 0.4, 0.4)
			objectPlayAnimation('core', 'Reactor_Thing_I_guess', true)
		end
		
		if Bob then
			if Mechanic == true and getRandomInt(1, 50) == 1 then
				reactorFix(true);
				Mechanic = false;
				runTimer('MechanicOn', getRandomInt(5, 20))
			end
		end
		if Fixable then
			if curBeat % 3 == 0 then
				playSound('Panel Reactor Hand', 0.4)
			end
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Ejected' then
		if getRandomBool(80) and not EveythingStop then
			CloudAmount = CloudAmount + 1; if CloudAmount >= MaxCloud then CloudAmount = 1; end
			makeAnimatedLuaSprite('Cloud'..CloudAmount,'MiraHQ/Green/Atmosphere/scrollingClouds', getRandomInt(-1250, 300), 2000)
			addAnimationByPrefix('Cloud'..CloudAmount, 'Cloud', 'Cloud'..getRandomInt(0,3), 1, false)
			randomScale = getRandomInt(10, 110)/100;
			scaleObject('Cloud'..CloudAmount, randomScale, randomScale)
			randomOrder = getRandomInt(1,3);
			if randomOrder == 1 then setObjectOrder('Cloud'..CloudAmount, getObjectOrder('sky')); addLuaSprite('Cloud'..CloudAmount) elseif randomOrder == 2 then setObjectOrder('Cloud'..CloudAmount, getObjectOrder('Cloud'..CloudAmount-1)+4); addLuaSprite('Cloud'..CloudAmount) else addLuaSprite('Cloud'..CloudAmount, true) end
		
			doTweenY('CloudY'..CloudAmount, 'Cloud'..CloudAmount, getProperty('Cloud'..CloudAmount..'.y')-1600, (MoveUpTimer/1.7)+getRandomInt(-20, 30)/100)
		end
	end
end

function onUpdatePost(elapsed)
	if Fixable then
		if getMouseX('hud') <= getProperty('Panel.x') + getProperty('Panel.width') and getMouseX('hud') >= getProperty('Panel.x') and getMouseY('hud') <= getProperty('Panel.y') + getProperty('Panel.height') and getMouseY('hud') >= getProperty('Panel.y') and (mousePressed('left') or mousePressed('right')) then
			Fixable = false;
			objectPlayAnimation('Panel', 'Safe', true)
			runTimer('PanelDown', 0.75)
			setProperty('ReactorTime.alpha', 0)
			setPropertyFromClass('flixel.FlxG', 'mouse.visible', false)
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Sussus Toogus' or songName == 'Lights Down' then
		if getProperty('health') == 2 and getProperty('winningAltAnim') == false and getProperty('boyfriend.animation.curAnim.name') == 'idle' and boyfriendName == 'bf' then
			setProperty('winningAltAnim', true)
			triggerEvent('Alt Idle Animation', 'bf', '-alt')
		elseif getProperty('health') < 2 and getProperty('winningAltAnim') == true and getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' and boyfriendName == 'bf' then
			setProperty('winningAltAnim', false)
			triggerEvent('Alt Idle Animation', 'bf', '')
		end
	end
end

function onUpdate(elapsed)
	if songName == 'Reactor' and  curStep >= 2432 then --2432
		for i=0,3 do
			currentBeat = (getSongPosition() / 1000) * (bpm / 60);
			setPropertyFromGroup('strumLineNotes', i, 'x', _G['defaultOpponentStrumX'..i] + 10 * math.sin(currentBeat*1 + i))
			setPropertyFromGroup('strumLineNotes', i+4, 'x', _G['defaultPlayerStrumX'..i] - 10 * math.sin(currentBeat*1 + (i+4)))

			setPropertyFromGroup('strumLineNotes', i, 'y', _G['defaultOpponentStrumY'..i] + 5 * math.cos((currentBeat*1 + i) * math.pi)) 
			setPropertyFromGroup('strumLineNotes', i+4, 'y', _G['defaultPlayerStrumY'..i] + 5 * math.cos((currentBeat*1 + (i+4)) * math.pi))
		end
	end
	if songName == 'Ejected' then
		setProperty('camHUD.y', math.sin((getSongPosition() / 1000) * (bpm / 60) * 1.0) * 15);
		setProperty('camHUD.angle', math.sin((getSongPosition() / 1200) * (bpm / 60) * -1.0) * 1.2);
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
    if followchars then
        if not mustHitSection then
			if songName == 'Ejected' then setProperty('defaultCamZoom', CZoom) end
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
			if songName == 'Ejected' then setProperty('defaultCamZoom', CZoom1) end
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' or getProperty('boyfriend.animation.curAnim.name') == 'singLEFT-alt' or getProperty('boyfriend.animation.curAnim.name') == 'singLEFT-beatbox' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' or getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT-alt' or getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT-beatbox' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' or getProperty('boyfriend.animation.curAnim.name') == 'singUP-alt' or getProperty('boyfriend.animation.curAnim.name') == 'singUP-beatbox' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' or getProperty('boyfriend.animation.curAnim.name') == 'singDOWN-alt' or getProperty('boyfriend.animation.curAnim.name') == 'singDOWN-beatbox' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
			if getProperty('boyfriend.animation.curAnim.name') == 'idle' or getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' or getProperty('boyfriend.animation.curAnim.name') == 'idle-beatbox' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
			end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if songName == "Ejected" then
		triggerEvent('Add Camera Zoom', 0.0175, 0.0175)
		if HPDrain and not isSustainNote then
			setProperty('health', getProperty('health')-0.02*getProperty('health'))
		elseif HPDrain and isSustainNote then
			setProperty('health', getProperty('health')-0.008*getProperty('health'))
		end
	end
end

function onPause()
	if Fixable then
		return Function_Stop;
	else
		return Function_Continue;
	end
end

function onDestroy()
	setPropertyFromClass('HealthIcon', 'iconFPS', 17)
end