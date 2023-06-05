local xx = {-200, -200, 0, -270, -100, -140, 300, 680};
local yy = {1040, 990, 1050, 1115, 1160, 920, 1050, 1050};
local xx2 = {200, 200, 0, -170, -230, 100, 250, 680};
local yy2 = {1040, 1040, 1050, 1150, 1160, 940, 1050, 1050}; 
local CZoom = {0.7, 0.6, 0.55, 1, 0.9, 0.5, 0.6, 1.4};
local CZoom1 = {0.7, 0.7, 0.55, 0.9, 0.9, 0.5, 0.6, 1.4};

local ofs = 20;
local followchars = true;

local startCam = true;
local cam = 0;	-- 1 = MonoBF | 2 = Montone/Red | 3 = Monotone/Red [Mid] | 4 = Green | 5 = Green [Mid] | 6 = Black | 7 = Black [Mid] | 8 = BF Only!

local BGState = 0; -- 0 = Skeld [Blue] || 1 = Skeld [Red] || 2 = Atmosphere || 3 = BlackDomain

local Pausable = false;

local Building = 0;
local MaxBuilding = 5;

local CloudAmount = 0;
local MaxCloud = 4;

local Lines = 0;
local MaxLines = 10;

local MoveUpTimer = 0.9; --Must be >= 0.3

local Particle = 0;
local maxParticle = 250;

local Par = 0;
local maxPar = 250;

function onStartCountdown() --Precache everything first for Ejected before starting the song :v
	if not allowCountdown and not seenCutscene and songName == 'Ejected' then
		setProperty('inCutscene', true)
		runTimer('Begin', 0.25)
		return Function_Stop;
	end
	return Function_Continue;
end

function onCreate()
	addCharacterToList('bf', 'boyfriend')
	addCharacterToList('BF_Dead', 'boyfriend')
	addCharacterToList('BF_FeltDead', 'boyfriend')
	addCharacterToList('BF_Falling', 'boyfriend')
	addCharacterToList('Monotone_Black', 'dad')
	addCharacterToList('Monotone_Red', 'dad')
	addCharacterToList('Monotone_Green_Parasite', 'dad')
	addCharacterToList('Monotone_BF', 'dad')
	addCharacterToList('Monotone', 'dad')

--Skeld:
	makeLuaSprite('SkeldBG', 'Skeld/Reactor/SkeldBack', -1955, -350)
	scaleObject('SkeldBG', 2, 2)
	setProperty('SkeldBG.alpha', 1)
	addLuaSprite('SkeldBG')
	
	makeLuaSprite('Floor', 'Skeld/Reactor/Floor', getProperty('SkeldBG.x'), getProperty('SkeldBG.y'))
	scaleObject('Floor', 2, 2)
	setProperty('Floor.alpha', getProperty('SkeldBG.alpha'))
	addLuaSprite('Floor')

	----------------------------------------------------------------------------------------------------------------
	--Blue
	makeLuaSprite('WallBlue', 'Skeld/Reactor/BackThings', getProperty('SkeldBG.x'), getProperty('SkeldBG.y'))
	scaleObject('WallBlue', 2, 2)
	setProperty('WallBlue.alpha', getProperty('SkeldBG.alpha'))
	addLuaSprite('WallBlue')
	
	makeLuaSprite('ReactorBlue', 'Skeld/Reactor/Reactor', getProperty('SkeldBG.x'), getProperty('SkeldBG.y'))
	scaleObject('ReactorBlue', 2, 2)
	setProperty('ReactorBlue.alpha', getProperty('WallBlue.alpha'))
	addLuaSprite('ReactorBlue')
	
	makeLuaSprite('BlueLights', 'Skeld/Reactor/Reactorlight', getProperty('SkeldBG.x'), getProperty('SkeldBG.y'))
	scaleObject('BlueLights', 2, 2)
	setBlendMode('BlueLights', 'ADD')
	setProperty('BlueLights.alpha', getProperty('WallBlue.alpha'))
	addLuaSprite('BlueLights')
	
	--Red
	makeLuaSprite('WallRed', 'Skeld/Reactor/backthingsred', getProperty('SkeldBG.x'), getProperty('SkeldBG.y'))
	scaleObject('WallRed', 2, 2)
	setProperty('WallRed.alpha', 0.001)
	addLuaSprite('WallRed')
	
	makeLuaSprite('ReactorRed', 'Skeld/Reactor/ReactorRed', getProperty('SkeldBG.x'), getProperty('SkeldBG.y'))
	scaleObject('ReactorRed', 2, 2)
	setProperty('ReactorRed.alpha', getProperty('WallRed.alpha'))
	addLuaSprite('ReactorRed')
	
	makeLuaSprite('RedLights', 'Skeld/Reactor/ReactorLightRed', getProperty('SkeldBG.x'), getProperty('SkeldBG.y'))
	scaleObject('RedLights', 2, 2)
	setBlendMode('RedLights', 'ADD')
	setProperty('RedLights.alpha', getProperty('WallRed.alpha'))
	addLuaSprite('RedLights')
	----------------------------------------------------------------------------------------------------------------
	
	makeLuaSprite('Wires', 'Skeld/Reactor/wires1', getProperty('SkeldBG.x'), getProperty('SkeldBG.y')-100)
	scaleObject('Wires', 2, 2)
	setProperty('Wires.alpha', getProperty('SkeldBG.alpha'))
	addLuaSprite('Wires', true)
	
	makeLuaSprite('Darkness', 'Skeld/Reactor/overlay', getProperty('SkeldBG.x'), getProperty('SkeldBG.y'))
	scaleObject('Darkness', 2, 2)
	setBlendMode('Darkness', 'MULTIPLY')
	setProperty('Darkness.alpha', 1)
	addLuaSprite('Darkness', true)
	
	makeLuaSprite('Overlay', 'Skeld/Reactor/overlay2', getProperty('SkeldBG.x'), getProperty('SkeldBG.y'))
	scaleObject('Overlay', 2, 2)
	setBlendMode('Overlay', 'ADD')
	setProperty('Overlay.alpha', 1)
	addLuaSprite('Overlay', true)
	
	
--Atmosphere:
	makeLuaSprite('Sky', 'Skeld/Reactor/evilejected', getProperty('SkeldBG.x')+600, getProperty('SkeldBG.y')-1100)
	setScrollFactor('Sky', 0.7, 0.7)
	scaleObject('Sky', 1.6, 1.6)
	setProperty('Sky.alpha', 0)
	addLuaSprite('Sky')
	
	
--Black's Domain:
	makeAnimatedLuaSprite('DomainBG', 'BlackDomain/Defeat/defeat', getProperty('SkeldBG.x')+350, getProperty('SkeldBG.y')+100)
	addAnimationByPrefix('DomainBG', 'Glow', '', 24, false)
	scaleObject('DomainBG', 1.5, 1.5)
	setProperty('DomainBG.alpha', 0.001) --1
	addLuaSprite('DomainBG')
	
	makeLuaSprite('BodyPile', 'BlackDomain/Defeat/lol thing', getProperty('DomainBG.x')+160, getProperty('DomainBG.y')+700)
	scaleObject('BodyPile', 1.3, 1.3)
	setScrollFactor('BodyPile', 0.9, 0.9)
	setBlendMode('BodyPile', 'MULTIPLY')
	setProperty('BodyPile.alpha', 0.001) --0.2
	addLuaSprite('BodyPile')
	
	makeLuaSprite('RedOverlay', 'BlackDomain/Defeat/iluminao omaga', getProperty('DomainBG.x')-40, getProperty('DomainBG.y')+400)
	scaleObject('RedOverlay', 1.3, 1.3)
	setProperty('RedOverlay.alpha', 0.001) --0.4
	setBlendMode('RedOverlay', 'ADD')
	addLuaSprite('RedOverlay', true)
	

	makeLuaSprite('BlackScreen', '', 0, 0)
	makeGraphic('BlackScreen', 1300, 750, '000000')
	setObjectCamera('BlackScreen','other')
	-- setProperty('BlackScreen.alpha', 0)
	addLuaSprite('BlackScreen', false)
	
	makeAnimatedLuaSprite('Threat', 'Skeld/Reactor/dialogue', 0, 0)
	addAnimationByPrefix('Threat', 'Threaten', '', 22, false)
	scaleObject('Threat', 0.7, 0.7)
	setObjectCamera('Threat', 'other')
	screenCenter('Threat')
	setProperty('Threat.alpha', 0.001)
	addLuaSprite('Threat')
	
	makeLuaSprite('BarUp', '', 0, -110)	--Default y = 0
	makeGraphic('BarUp', 1280, 105, '000000')
	setObjectCamera('BarUp', 'camHUD')
	addLuaSprite('BarUp')
	
	makeLuaSprite('BarDown', '', 0, 735) --Default y = 620
	makeGraphic('BarDown', 1280, 105, '000000')
	setObjectCamera('BarDown', 'camHUD')
	addLuaSprite('BarDown')
	
	setProperty('skipCountdown', true)
	setProperty('cameraSpeed', 0.75)
end

local FlashCol = '0xFFFFFF';
local FlashingOffBonusTimer = 0;

function onCreatePost()
	if not flashingLights then
		FlashCol = '0x333333';
		FlashingOffBonusTimer = 0.25;
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	midCam(true);
	setProperty('camFollowPos.x', xx[3])
	setProperty('camFollowPos.y', yy[3])
	setProperty('camFollow.x', xx[3])
	setProperty('camFollow.y', yy[3])
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	setProperty('camHUD.alpha', 0)
	
	for i=0, 3 do
		if not middlescroll then
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 1)
			setPropertyFromGroup('strumLineNotes', i, 'x', _G['defaultOpponentStrumX'..i] + 320)
			setPropertyFromGroup('strumLineNotes', i+4, 'x', _G['defaultPlayerStrumX'..i] - 320)
		end
		setPropertyFromGroup('strumLineNotes', i+4, 'alpha', 0)
	end
	setProperty('scoreTxt.color', getColorFromHex('31B0D1'))
end

function midCam(bool)
	if bool then
		if BGState == 0 or BGState == 1 then
			cam = 3;
		elseif BGState == 2 then
			cam = 5;
		elseif BGState == 3 then
			cam = 7;
		end
	elseif not bool then
		if BGState == 0 or BGState == 1 then
			cam = 2;
		elseif BGState == 2 then
			cam = 4;
		elseif BGState == 3 then
			cam = 6;
		end
	end
end

local AutoSetBG = false;

function stageSet(stage)
	BGState = stage;
	AutoSetBG = true;
	
	setProperty('cameraSpeed', 0.75)
	triggerEvent('Change Character', '0', 'bf')
	triggerEvent('Add Camera Zoom', 0.02, 0.05)
	setProperty('boyfriend.x', 500)
	setProperty('boyfriend.y', 975)
	setPropertyFromClass('GameOverSubstate', 'characterName', 'fnf_loss_sfx')
	setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'BF_Dead')
	cam = 2;
	
	for i=0, MaxBuilding do
		setProperty('Building'..i..'.alpha', 0)
	end
	for j=0, MaxCloud do
		setProperty('Cloud'..j..'.alpha', 0)
	end
	for l=0, MaxLines do
		setProperty('SpeedLines'..l..'.alpha', 0)
	end
	for p=0, maxParticle do
		setProperty('particle'..p..'.alpha', 0)
	end
	for d=0, maxPar do
		setProperty('Dust'..d..'.alpha', 0)
	end
	
	if BGState == 0 then
		cinematicView(true, 0.5);
		setProperty('scoreTxt.color', getColorFromHex('494949'))
		triggerEvent('Change Character', '1', 'Monotone')
		setProperty('SkeldBG.alpha', 1) setProperty('WallBlue.alpha', 1) setProperty('WallRed.alpha', 0)setProperty('Sky.alpha', 0) setProperty('DomainBG.alpha', 0)
	elseif BGState == 1 then
		cinematicView(true, 0.5);
		setProperty('scoreTxt.color', getColorFromHex('FF1000'))
		triggerEvent('Change Character', '1', 'Monotone_Red')
		setProperty('SkeldBG.alpha', 1) setProperty('WallBlue.alpha', 0) setProperty('WallRed.alpha', 1) setProperty('Sky.alpha', 0) setProperty('DomainBG.alpha', 0)
	elseif BGState == 2 then
		cinematicView(false, 0.25);
		cam = 4;
		setProperty('cameraSpeed', 2)
		setProperty('scoreTxt.color', getColorFromHex('346F3E'))
		triggerEvent('Change Character', '1', 'Monotone_Green_Parasite')
		triggerEvent('Change Character', '0', 'BF_Falling')
		setProperty('boyfriend.x', 40)
		setProperty('boyfriend.y', 1300)
		setPropertyFromClass('GameOverSubstate', 'characterName', 'BF_FeltDead')
		setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'ejected_death')
		setProperty('SkeldBG.alpha', 0) setProperty('WallBlue.alpha', 0) setProperty('WallRed.alpha', 0) setProperty('Sky.alpha', 1) setProperty('DomainBG.alpha', 0)
	elseif BGState == 3 then
		cinematicView(false, 0.25);
		cam = 6;
		setProperty('scoreTxt.color', getColorFromHex('FF0000'))
		triggerEvent('Change Character', '1', 'Monotone_Black')
		setProperty('SkeldBG.alpha', 0) setProperty('WallBlue.alpha', 0) setProperty('WallRed.alpha', 0) setProperty('Sky.alpha', 0) setProperty('DomainBG.alpha', 1)
	end
	
	if mustHitSection then
		setProperty('camFollowPos.x', xx[cam])
		setProperty('camFollowPos.y', yy[cam])
		setProperty('camFollow.x', xx[cam])
		setProperty('camFollow.y', yy[cam])
		doTweenZoom('camGameIntantZoom', 'camGame', CZoom[cam], 0.001)
	elseif not mustHitSection then
		setProperty('camFollowPos.x', xx2[cam])
		setProperty('camFollowPos.y', yy2[cam])
		setProperty('camFollow.x', xx2[cam])
		setProperty('camFollow.y', yy2[cam])
		doTweenZoom('camGameIntantZoom', 'camGame', CZoom1[cam], 0.001)
	end
end

function cinematicView(bool, transitionTimer)
	if bool then
		doTweenY('BarUpY', 'BarUp', 0, transitionTimer, 'sineOut')
		doTweenY('BarDownY', 'BarDown', 620, transitionTimer, 'sineOut')
	elseif not bool then
		doTweenY('BarUpY', 'BarUp', -110, transitionTimer, 'sineIn')
		doTweenY('BarDownY', 'BarDown', 735, transitionTimer, 'sineIn')
	end
end

--Store Curstep
local midCamOn = {352, 448, 768, 1016, 1824, 2368, 2592, 2720, 2862, 3074, 3266};
local midCamOff = {396, 512, 895, 1162, 1952, 2412, 2656, 2789, 2877, 3142, 3338};

local zoomInCam = {920, 928, 952, 960, 984, 992, 1008, 1048, 1052, 1056, 1080, 1087, 1120, 1136, 1144, 1152, 2656, 2664, 2672, 2680, 2688, 2696, 2704, 2712, 2728, 2736, 2744, 2748, 2752, 2760, 2764, 2768, 2772, 2776};

--Indexes call:
local OnCStep = 1;
local OffCStep = 1;

local ZoomCStep = 1;

function onStepHit()
	if curStep == midCamOn[OnCStep] then
		midCam(true);
		OnCStep = OnCStep + 1;
	end
	if curStep == midCamOff[OffCStep] then
		midCam(false);
		OffCStep = OffCStep + 1;
	end
	
	if curStep == zoomInCam[ZoomCStep] and curStep <= 1008 then
		CZoom[cam] = CZoom[cam] + 0.05;
		xx[cam] = xx[cam] - 14;
		yy[cam] = yy[cam] - 3;
		ZoomCStep = ZoomCStep + 1;
	elseif curStep == zoomInCam[ZoomCStep] and curStep >= 1048 and curStep <= 1152 then
		CZoom[cam] = CZoom[cam] + 0.027;
		CZoom1[cam] = CZoom1[cam] + 0.027;
		ZoomCStep = ZoomCStep + 1;
	elseif curStep == zoomInCam[ZoomCStep] and curStep >= 2656 and curStep <= 1152 then
		CZoom[cam] = CZoom[cam] + 0.035;
		xx[cam] = xx[cam] - 7;
		yy[cam] = yy[cam] - 2;
		ZoomCStep = ZoomCStep + 1;
	elseif curStep == zoomInCam[ZoomCStep] and curStep >= 2728 and curStep <= 2776 then
		CZoom[cam] = CZoom[cam] + 0.027;
		CZoom1[cam] = CZoom1[cam] + 0.027;
		ZoomCStep = ZoomCStep + 1;
	end
	
	if curStep == 1016 then
		CZoom[2] = 0.6;
		xx[2] = -200;
		yy[2] = 990;
	end
	if curStep == 1162 then
		CZoom[3] = 0.55;
		CZoom1[3] = 0.55;
	end
	if curStep == 2720 or curStep == 2789 then
		CZoom[3] = 0.55;
		CZoom1[3] = 0.55;		
		CZoom[2] = 0.6;
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if curStep >= 40 and curStep <= 312 and getProperty('BlackScreen.alpha') == 1 then
	-- if curStep >= 40 and curStep <= 312 then
		doTweenAlpha('BlackScreenAlpha', 'BlackScreen', 0, 21)
		doTweenZoom('camGameZoom', 'camGame', 0.4, 21, 'sineOut')
	end
	if curStep == 260 then
		doTweenAlpha('BlackScreenAlpha', 'BlackScreen', 0, 1)
		cancelTween('camGameZoom')
		
		cinematicView(true, 3);
	end
	if curStep >= 312 and getPropertyFromGroup('strumLineNotes', 4, 'alpha') == 0 then
		for i=0, 3 do
			if not middlescroll then
				noteTweenX('NoteX'..i, i, _G['defaultOpponentStrumX'..i], 1, 'sineInOut')
				noteTweenX('NoteX'..i+4, i+4, _G['defaultPlayerStrumX'..i], 1, 'sineInOut')
			end
			noteTweenAlpha('NoteAlpha'..i+4, i+4, 1, 1)
		end
	end
	if curStep == 384 then
		cameraFlash('camOther', FlashCol, 0.35 + FlashingOffBonusTimer, true)
		stageSet(0)
	end
	if curStep >= 511 and curStep <= 515 and getProperty('BlackScreen.alpha') == 0 then
		setProperty('BlackScreen.alpha', 1)
		cameraFlash('camOther', FlashCol, 0.55 + FlashingOffBonusTimer, true)
	end
	if curStep >= 575 and getProperty('Threat.alpha') ~= 1 then
		setProperty('Threat.alpha', 1)
		objectPlayAnimation('Threat', 'Threaten', true)
	end
	if curStep >= 640 and curStep <= 650 and getProperty('BlackScreen.alpha') == 1 then
		removeLuaSprite('Threat', true)
		setProperty('BlackScreen.alpha', 0)
		cameraFlash('camOther', FlashCol, 0.55 + FlashingOffBonusTimer, true)
		stageSet(1)
	end
	if curStep == 896 then
		cameraFlash('camOther', FlashCol, 0.35 + FlashingOffBonusTimer, true)
		stageSet(0)
	end
	if curStep >= 1161 and curStep <= 1165 and getProperty('BlackScreen.alpha') == 0 then
		setProperty('BlackScreen.alpha', 1)
		stageSet(2)
	end
	if curStep >= 1176 and curStep <= 1185 and getProperty('BlackScreen.alpha') == 1 then
		setProperty('BlackScreen.alpha', 0)
		cameraFlash('camOther', FlashCol, 0.35 + FlashingOffBonusTimer, true)
	end
	if curStep == 1440 then
		doTweenAlpha('BlackScreenFade', 'BlackScreen', 0.9, 0.4)
	end
	if curStep >= 1448 and curStep <= 1455 and getProperty('BlackScreen.alpha') ~= 1 then
		cancelTween('BlackScreenFade')
		setProperty('BlackScreen.alpha', 1)
		cameraFlash('camOther', FlashCol, 1, true)
		stageSet(0)
	end
	if curStep >= 1696 and curStep <= 1705 and getProperty('BlackScreen.alpha') == 1 then
		setProperty('BlackScreen.alpha', 0)
		cameraFlash('camOther', FlashCol, 0.35 + FlashingOffBonusTimer, true)
	end
	if curStep >= 1951 and curStep <= 1955 and getProperty('BlackScreen.alpha') == 0 then
		setProperty('BlackScreen.alpha', 1)
	end
	if curStep >= 1978 and curStep <= 1985 and getProperty('BlackScreen.alpha') == 1 then
		setProperty('BlackScreen.alpha', 0)
		cameraFlash('camOther', FlashCol, 0.35 + FlashingOffBonusTimer, true)
		stageSet(3)
	end
	if curStep >= 2248 and curStep <= 2255 and getProperty('BlackScreen.alpha') == 0 then
		setProperty('BlackScreen.alpha', 1)
	end
	if curStep >= 2276 and curStep <= 2285 and getProperty('BlackScreen.alpha') == 1 then
		setProperty('BlackScreen.alpha', 0)
		cameraFlash('camOther', FlashCol, 0.55 + FlashingOffBonusTimer, true)
		stageSet(0)
	end
	if curStep == 2776 then
		doTweenAlpha('BlackScreenFade', 'BlackScreen', 0.9, 1.25)
	end
	if curStep == 2788 then
		cancelTween('BlackScreenFade')
		setProperty('timeBar.alpha', 0)
		setProperty('timeBarBG.alpha', 0)
		setProperty('timeTxt.alpha', 0)
		setProperty('iconP1.alpha', 0)
		setProperty('iconP2.alpha', 0)
		setProperty('scoreTxt.alpha', 0)
		setProperty('healthBar.alpha', 0)
		setProperty('healthBarBG.alpha', 0)
		for i=0, 3 do
			if not middlescroll then
				setPropertyFromGroup('strumLineNotes', i, 'alpha', 0.7)
			end
			setPropertyFromGroup('strumLineNotes', i+4, 'alpha', getPropertyFromGroup('strumLineNotes', i, 'alpha'))
		end
		setObjectCamera('BlackScreen', 'hud')
		setProperty('BlackScreen.alpha', 1)
		cameraFlash('camOther', FlashCol, 0.7, true)
	end
	if curStep >= 2814 and curStep <= 2820 and getProperty('BlackScreen.alpha') == 1 then
		setProperty('timeBar.alpha', 1)
		setProperty('timeBarBG.alpha', 1)
		setProperty('timeTxt.alpha', 1)
		setProperty('iconP1.alpha', 1)
		setProperty('iconP2.alpha', 1)
		setProperty('scoreTxt.alpha', 1)
		setProperty('healthBar.alpha', 1)
		setProperty('healthBarBG.alpha', 1)
		for i=0, 3 do
			if not middlescroll then
				setPropertyFromGroup('strumLineNotes', i, 'alpha', 1)
			end
			setPropertyFromGroup('strumLineNotes', i+4, 'alpha', 1)
		end
		setObjectCamera('BlackScreen', 'other')
		setProperty('BlackScreen.alpha', 0)
		cameraFlash('camOther', FlashCol, 0.55 + FlashingOffBonusTimer, true)
		stageSet(1)
	end
	if curStep == 2878 then
		cameraFlash('camOther', FlashCol, 0.35 + FlashingOffBonusTimer, true)
		stageSet(2)	
	end
	if curStep == 3074 then
		cameraFlash('camOther', FlashCol, 0.35 + FlashingOffBonusTimer, true)
		stageSet(3)		
	end
	if curStep == 3198 then
		cameraFlash('camOther', FlashCol, 0.35 + FlashingOffBonusTimer, true)
		stageSet(1)		
	end
	if curStep == 3280 then
		cameraFlash('camOther', FlashCol, 0.35 + FlashingOffBonusTimer, true)
		stageSet(2)		
	end
	if curStep == 3296 then
		cameraFlash('camOther', FlashCol, 0.35 + FlashingOffBonusTimer, true)
		stageSet(3)		
	end
	if curStep >= 2878 and curStep <= 3320 and getProperty('BlackScreen.alpha') == 1 then
		setProperty('BlackScreen.alpha', 0)
		removeLuaSprite('Threat', true)
	end
	if curStep >= 3328 and curStep <= 3335 and getProperty('BlackScreen.alpha') == 0 then
		setProperty('BlackScreen.alpha', 1)
		cameraFlash('camOther', FlashCol, 1, true)
		stageSet(0)
		
		removeLuaSprite('DomainBG', true)
		removeLuaSprite('RedOverlay', true)
		removeLuaSprite('BodyPile', true)
		removeLuaSprite('Sky', true)
		
		setProperty('timeBar.alpha', 0)
		setProperty('timeBarBG.alpha', 0)
		setProperty('timeTxt.alpha', 0)
		setProperty('iconP1.alpha', 0)
		setProperty('iconP2.alpha', 0)
		setProperty('scoreTxt.alpha', 0)
		setProperty('healthBar.alpha', 0)
		setProperty('healthBarBG.alpha', 0)
		for i=0, 3 do
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
			setPropertyFromGroup('strumLineNotes', i+4, 'alpha', 0.5)
			noteTweenAlpha('NoteAlpha'..i+4, i+4, 1, 10)
		end
		cam = 8;
		
		setObjectCamera('BlackScreen', 'hud')
	end
	if curStep >= 3368 and curStep <= 3375 and getProperty('BlackScreen.alpha') == 1 then
		doTweenAlpha('BlackScreenAlpha', 'BlackScreen', 0.3, 17, 'sineInOut')
	
		ofs = ofs - 5;
	end
	if curStep >= 3368 and curStep <= 3584 and CZoom[cam] >= 0.2 then
		xx[cam] = xx[cam] - 2.925;
		yy[cam] = yy[cam] - 0.5;
		xx2[cam] = xx2[cam] - 2.925;
		yy2[cam] = yy2[cam] - 0.5;
		CZoom[cam] = CZoom[cam] - 0.004;
		CZoom1[cam] = CZoom1[cam] - 0.004;
	end
	if curStep == 3585 then
		cancelTween('BlackScreenAlpha')
		setObjectCamera('BlackScreen', 'other')
		setProperty('BlackScreen.alpha', 1)
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if getRandomBool(65) and BGState == 2 then
		makeLuaSprite('SpeedLines'..Lines,'MiraHQ/Green/Atmosphere/speedLines', getRandomInt(getProperty('Sky.x'), getProperty('Sky.x')+getProperty('Sky.width')), getProperty('Sky.y')+getProperty('Sky.height')-200)
		randomScale = getRandomFloat(10, 80)/100;
		scaleObject('SpeedLines'..Lines, randomScale, randomScale)
		setProperty('SpeedLines'..Lines..'.alpha', getRandomFloat(20, 40)/100)
		setScrollFactor('SpeedLines'..Lines, 0.8, 0.8)
		addLuaSprite('SpeedLines'..Lines, getRandomBool(50))
		
		doTweenY('SpeedY'..Lines, 'SpeedLines'..Lines, getProperty('Sky.y')+500, MoveUpTimer/1.5)
		
		Lines = Lines + 1; if Lines >= MaxLines then Lines = 0 end
	end
end

local BuildingCooldown = false;

function onBeatHit()
	if BGState == 3 and curBeat % 4 == 0 then
		objectPlayAnimation('DomainBG', 'Glow', true)
	end
	
	-- if BGState == 0 and curBeat % 4 == 0 and dadName == 'Monotone' and getProperty('dad.animation.curAnim.name') == 'idle' then
		-- characterPlayAnim('dad', 'idle', true)
		-- setProperty('dad.specialAnim', true)
	-- end

	if getRandomBool(40) and BGState == 2 and not BuildingCooldown then
		BuildingCooldown = true;
		-- rngOrder = getRandomBool(30)
		-- if not rngOrder then 
			makeLuaSprite('Building'..Building, 'Skeld/Reactor/Tower'..getRandomInt(1,3), getRandomInt(getProperty('Sky.x')+300, getProperty('Sky.x')+getProperty('Sky.width')-300), getProperty('Sky.y')+getProperty('Sky.height')-200)
		-- elseif rngOrder then
			-- makeLuaSprite('Building'..Building, 'Skeld/Reactor/Tower'..getRandomInt(1,3)..'Closer', getRandomInt(getProperty('Sky.x'), getProperty('Sky.x')+getProperty('Sky.width')), getProperty('Sky.y')+getProperty('Sky.height')-200)
		-- end
		randomScale = getRandomFloat(15, 45)/100;
		scaleObject('Building'..Building, randomScale, randomScale)
		setScrollFactor('Building'..Building, 0.9, 0.9)
		setProperty('Building'..Building..'.angle', getRandomInt(-15, 15)*getRandomInt(-1, 1))
		addLuaSprite('Building'..Building)
		
		moveTimer = MoveUpTimer*getRandomFloat(2,5);
		-- if rngOrder then
			-- closeTimer = getRandomFloat(2, 2.5)
		-- else
			closeTimer = 1;
		-- end
		doTweenAngle('BuildingAngle'..Building, 'Building'..Building, getProperty('Building'..Building..'.angle')+getRandomFloat(-50, 50), moveTimer*closeTimer, 'sineOut')
		doTweenY('BuildingUp'..Building, 'Building'..Building, getProperty('Sky.y')-getProperty('Building'..Building..'.height')/1.25, moveTimer*closeTimer, 'sineIn')
		
		Building = Building + 1; if Building >= MaxBuilding then Building = 0 end
		
		runTimer('BuildingCooldownOff', getRandomFloat(1, 3))
	end
	
	if getRandomBool(50) and BGState == 2 then
		CloudAmount = CloudAmount + 1; if CloudAmount >= MaxCloud then CloudAmount = 1; end
		makeAnimatedLuaSprite('Cloud'..CloudAmount,'MiraHQ/Green/Atmosphere/scrollingClouds', getRandomInt(-1250, 300), 2000)
		addAnimationByPrefix('Cloud'..CloudAmount, 'Cloud', 'Cloud'..getRandomInt(0,3), 1, false)
		randomScale = getRandomInt(40, 110)/100;
		setProperty('Cloud'..CloudAmount..'.alpha', getRandomInt(7,10)/10)
		scaleObject('Cloud'..CloudAmount, randomScale, randomScale)
		addLuaSprite('Cloud'..CloudAmount, getRandomBool(50)) 
	
		doTweenY('CloudY'..CloudAmount, 'Cloud'..CloudAmount, getProperty('Sky.y')+getProperty('Cloud'..CloudAmount..'.height')*2, (MoveUpTimer/1.5)+getRandomInt(-10, 20)/100)
	end
	
	if not lowQuality and (BGState == 0 or BGState == 1) then
		makeLuaSprite('Dust'..Par, 'BlackDomain/Defeat/Paritcles', getRandomInt(getProperty('SkeldBG.x')+500, getProperty('SkeldBG.x')+getProperty('SkeldBG.width')-500), getRandomInt(getProperty('SkeldBG.y')+350, getProperty('SkeldBG.y')+getProperty('SkeldBG.height')-350))
		scroll = getRandomInt(50, 90)/100;
		setScrollFactor('Dust'..Par, scroll, scroll)
		scaleObject('Dust'..Par, getRandomFloat(10, 80)/100, getRandomFloat(10, 80)/100)
		setProperty('Dust'..Par..'.alpha', 0)
		setProperty('Dust'..Par..'.color', getColorFromHex('808080'))
		setBlendMode('Dust'..Par, 'ADD')
		rngOrder = getRandomBool(50);
		if rngOrder then
			setObjectOrder('Dust'..Par, getObjectOrder('Darkness')-1)
		end
		addLuaSprite('Dust'..Par, rngOrder)
		
		timer = getRandomInt(40, 80)/100;
		doTweenX('DustX'..Par, 'Dust'..Par, getProperty('Dust'..Par..'.x') + getRandomInt(-500, 500), timer*getRandomInt(4, 5), 'sineOut')
		doTweenY('DustY'..Par, 'Dust'..Par, getProperty('Dust'..Par..'.y') + getRandomInt(-500, 500), timer*getRandomInt(4, 5), 'sineOut')
		doTweenAlpha('DustFadeIn'..Par, 'Dust'..Par, getRandomFloat(20, 60)/100, timer/1.5)
		
		Par = Par + 1; if Par >= maxPar then Par = 0 end
	end
end

function onUpdatePost(elapsed)
	if AutoSetBG then
		AutoSetBG = false;
		
		setProperty('Wires.alpha', getProperty('SkeldBG.alpha'))
		setProperty('Floor.alpha', getProperty('SkeldBG.alpha'))
		
		--Blue
		setProperty('ReactorBlue.alpha', getProperty('WallBlue.alpha'))
		setProperty('BlueLights.alpha', getProperty('WallBlue.alpha'))
		
		--Red
		setProperty('ReactorRed.alpha', getProperty('WallRed.alpha'))
		setProperty('RedLights.alpha', getProperty('WallRed.alpha'))	
				
		if getProperty('SkeldBG.alpha') == 1 or getProperty('Sky.alpha') == 1 then
			setProperty('Darkness.alpha', 1)
			setProperty('Overlay.alpha', 1)
			setProperty('BodyPile.alpha', 0)
			setProperty('RedOverlay.alpha', 0)
		else	--BGState 3
			setProperty('Darkness.alpha', 0)
			setProperty('Overlay.alpha', 0.8)
			setProperty('BodyPile.alpha', 0.2)
			setProperty('RedOverlay.alpha', 0.7)
		end	
	end
end

function onUpdate(elapsed)
	if BGState == 0 and dadName == 'Monotone' then
		currentBeat = (getSongPosition() / 1000) * (bpm / 60);
		for i=0, 3 do		
			setPropertyFromGroup('strumLineNotes', i, 'y', _G['defaultOpponentStrumY'..i] + 1 * (30/2) * math.sin(currentBeat*0.3 + i * 2)) 
			setPropertyFromGroup('strumLineNotes', i+4, 'y', _G['defaultPlayerStrumY'..i] + 1 * (30/2) * math.sin(currentBeat*0.3 + (i+4) * 2))
		end
	else
		for i=0, 3 do
			setPropertyFromGroup('strumLineNotes', i, 'y', _G['defaultOpponentStrumY'..i])
			setPropertyFromGroup('strumLineNotes', i+4, 'y', _G['defaultPlayerStrumY'..i])
		end
	end
	
	if BGState == 2 then
		setProperty('camHUD.y', math.sin((getSongPosition() / 1000) * (bpm / 60) * 1.0) * 15);
		setProperty('camHUD.angle', math.sin((getSongPosition() / 1200) * (bpm / 60) * -1.0) * 1.2);
	else
		setProperty('camHUD.y', 0);
		setProperty('camHUD.angle', 0);
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if BGState == 3 and curStep % 7 == 0 then
		ParticleX = getRandomInt(getProperty('DomainBG.x')+910, getProperty('DomainBG.x')+2510);
		makeLuaSprite('particle'..Particle, 'BlackDomain/Defeat/Paritcles', ParticleX, 1600)
		rngScale = getRandomFloat(3,5)/10;
		scaleObject('particle'..Particle, rngScale, rngScale)
		setScrollFactor('particle'..Particle, 0.9, 0.9)
		if getRandomBool(50) then
			setBlendMode('particle'..Particle, 'ADD')
		end
		setProperty('particle'..Particle..'.color', getColorFromHex('EA0000'))
		setProperty('particle'..Particle..'.alpha', getRandomFloat(3,7)/10)
		setObjectOrder('particle'..Particle, getObjectOrder('FrontBodyPile')-1)	
		addLuaSprite('particle'..Particle, true)
		TweenTime = getRandomInt(10,50)/10;
		doTweenY('particleY'..Particle, 'particle'..Particle, -100, TweenTime)
		if getRandomBool(50) then
			doTweenX('particleX'..Particle, 'particle'..Particle, getProperty('DomainBG.x')+300 + getRandomInt(-200, 100), TweenTime/getRandomFloat(0.75,3), 'backOut')
		else
			doTweenX('particleX'..Particle, 'particle'..Particle, getProperty('DomainBG.x')+2720 + getRandomInt(-100, 200), TweenTime/getRandomFloat(0.75,3), 'backOut')
		end
		SmallTime = getRandomInt(-20, 7)/10;
		doTweenX('particleYScale'..Particle, 'particle'..Particle..'.scale', 0.01, TweenTime+SmallTime, 'sineInOut')
		doTweenY('particleXScale'..Particle, 'particle'..Particle..'.scale', 0.01, TweenTime+SmallTime, 'sineInOut')
		Particle=Particle+1; if Particle >= maxParticle then Particle = 0 end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if followchars then
		if mustHitSection == false then
			setProperty('defaultCamZoom', CZoom[cam])
			if getProperty('dad.animation.curAnim.name') == 'singLEFT' or getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
				triggerEvent('Camera Follow Pos',xx[cam]-ofs,yy[cam])
			end
			if getProperty('dad.animation.curAnim.name') == 'singRIGHT' or getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
				triggerEvent('Camera Follow Pos',xx[cam]+ofs,yy[cam])
			end
			if getProperty('dad.animation.curAnim.name') == 'singUP' or getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
				triggerEvent('Camera Follow Pos',xx[cam],yy[cam]-ofs)
			end
			if getProperty('dad.animation.curAnim.name') == 'singDOWN' or getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
				triggerEvent('Camera Follow Pos',xx[cam],yy[cam]+ofs)
			end
			if getProperty('dad.animation.curAnim.name') == 'idle' or getProperty('dad.animation.curAnim.name') == 'idle-alt' then
			triggerEvent('Camera Follow Pos',xx[cam],yy[cam])
			end
		else
			setProperty('defaultCamZoom', CZoom1[cam])
			if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
				triggerEvent('Camera Follow Pos',xx2[cam]-ofs,yy2[cam])
			end
			if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
				triggerEvent('Camera Follow Pos',xx2[cam]+ofs,yy2[cam])
			end
			if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
				triggerEvent('Camera Follow Pos',xx2[cam],yy2[cam]-ofs)
			end
			if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
				triggerEvent('Camera Follow Pos',xx2[cam],yy2[cam]+ofs)
			end
			if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
				triggerEvent('Camera Follow Pos',xx2[cam],yy2[cam])
			end
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'Begin' then
		allowCountdown = true;
		startCountdown();
	end

	if tag == 'BuildingCooldownOff' then
		BuildingCooldown = false;
	end
	
	for b=0, Par do
		if tag == 'DustBye'..b then
			doTweenAlpha('DustFadeOut'..b, 'Dust'..b, 0, getRandomInt(30, 50)/100)
		end
	end
end

function onTweenCompleted(tag)
	for i=0, Building do
		if tag == 'BuildingUp'..i then
			cancelTween('BuildingAngle'..i)
			removeLuaSprite('Building'..i)
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
	
	for p=0, maxParticle do
		if tag == 'particleY'..p then
			removeLuaSprite('particle'..p)
		end
	end
	
	for d=0, maxPar do
		if tag == 'DustFadeIn'..d then
			runTimer('DustBye'..d, getRandomInt(10, 15)/10)
		end
		
		if tag == 'DustFadeOut'..d then
			cancelTween('DustX'..d)
			cancelTween('DustY'..d)
			cancelTween('DustFadeIn'..d)
			cancelTween('DustFadeOut'..d)
			removeLuaSprite('Dust'..d, true)
		end
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if startCam then
		startCam = false;
		cam = 1;
		midCam(false);
		Pausable = true;
		doTweenAlpha('camHUD', 'camHUD', 1, 0.75)
		doTweenZoom('camGameZoom', 'camGame', 1, 1.25, 'sineInOut')
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if curStep > 3567 and not isSustainNote then
		noteTweenAlpha('NoteAlpha'..direction, direction, 0, 1)
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if curStep > 3567 and not isSustainNote then
		noteTweenAlpha('NoteAlpha'..direction, direction, 0, 1)
	end
end

-- function onPause()
	-- if not Pausable then
		-- return Function_Stop;
	-- else
		-- return Function_Continue;
	-- end
-- end