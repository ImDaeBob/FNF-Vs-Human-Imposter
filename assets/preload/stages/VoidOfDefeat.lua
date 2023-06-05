local xx = 1050;
local yy = 870;
local xx2 = 1170;
local yy2 = 1050; 
local ofs = 20;
local followchars = true;
local CZoom = 0.55;
local CZoom1 = 0.75;

local StartState = 0;
local Stop = false;

local SpecialHUD = false;

local SparkData = {{55, 335, 0.9}, {355, 160, 0.7}, {525, 160, 0.8}, {2180, 160, 0.8}, {2170, 305, 1}, {2540, 325, 0.9}};

local Quotes = {
	'Dare to dance on the edge of perfection, For greatness lies beyond the Miss Limit.',
	'Count your mistakes... In the end, you will die.',
	'Face me brave, or avoid like a coward?'
}

local MaxCombo = '';

function onStartCountdown()
	if not allowCountdown and StartState == 0 then
		return Function_Stop;
	end
	return Function_Continue;
end

function onCountdownTick(counter)
	setTextString('scoreTxt', 'Score: '..score..' • Misses: '..misses..' / '..tonumber(MaxCombo)..' • Rating: '..rating)
end

function onCreate()
	addCharacterToList('Black_Defeat', 'dad')
	addCharacterToList('Black', 'dad')
	addCharacterToList('BF_Defeat_Scared', 'boyfriend')
	addCharacterToList('BF_Defeat', 'boyfriend')
	addCharacterToList('BF_DefeatDeath', 'boyfriend')
	addCharacterToList('BF_DefeatDeath_Balls', 'boyfriend')
	
	if songName == 'Defeat' then
		setPropertyFromClass('PauseSubState', 'songName', 'blackPause');
		if getRandomBool(30) then
			setPropertyFromClass('GameOverSubstate', 'characterName', 'BF_DefeatDeath_Balls')
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'defeat_kill_ballz_sfx')
		else
			setPropertyFromClass('GameOverSubstate', 'characterName', 'BF_DefeatDeath')
			setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'defeat_kill_sfx')
		end
		
		setProperty('healthLoss', 0)
		setProperty('cameraSpeed', 0.75)
		
		makeAnimatedLuaSprite('BG', 'BlackDomain/Defeat/defeat', -560, -350)
		addAnimationByPrefix('BG', 'Glow', '', 24, false)
		scaleObject('BG', 1.5, 1.5)
		-- setBlendMode('BG', 'OVERLAY')
		setProperty('BG.alpha', 0.7)
		addLuaSprite('BG')
		
		makeLuaSprite('BodyPile', 'BlackDomain/Defeat/lol thing', -400, 350)
		scaleObject('BodyPile', 1.3, 1.3)
		setScrollFactor('BodyPile', 0.9, 0.9)
		setBlendMode('BodyPile', 'MULTIPLY')
		setProperty('BodyPile.alpha', 0.1)
		addLuaSprite('BodyPile')
		
		makeLuaSprite('SideBodyPile', 'BlackDomain/Defeat/deadBG', -420, 800)
		scaleObject('SideBodyPile', 0.4, 0.4)
		setScrollFactor('SideBodyPile', 0.9, 0.9)
		setProperty('SideBodyPile.alpha', 0.01)
		addLuaSprite('SideBodyPile')
		
		makeAnimatedLuaSprite('BlackKill', 'characters/BlackDomain/BlackKill', 175, 355)
		addAnimationByPrefix('BlackKill', 'death', 'death', 24, false)
		setProperty('BlackKill.alpha', 0.001)
		addLuaSprite('BlackKill', true)
		
		for i=1, 6 do
			makeLuaSprite('Spark'..i, 'BlackDomain/Defeat/Spark', getProperty('SideBodyPile.x')+ SparkData[i][1], getProperty('SideBodyPile.y') + SparkData[i][2])
			scaleObject('Spark'..i, SparkData[i][3] + getRandomInt(-10, 10)/100, SparkData[i][3] + getRandomInt(-10, 10)/100)
			setScrollFactor('Spark'..i, 0.9, 0.9)
			Blend = getRandomInt(1,2)
			if Blend == 1 then 
				setBlendMode('Spark'..i, 'ADD')
			elseif Blend == 2 then
				setBlendMode('Spark'..i, 'OVERLAY')
			end
			setProperty('Spark'..i..'.angle', getRandomInt(-15, 15))
			setProperty('Spark'..i..'.alpha', 0.01)
			addLuaSprite('Spark'..i)
		end
		
		makeLuaSprite('FrontBodyPile', 'BlackDomain/Defeat/deadFG', -580, 1200)
		scaleObject('FrontBodyPile', 0.4, 0.4)
		setScrollFactor('FrontBodyPile', 0.5, 1)
		setProperty('FrontBodyPile.alpha', 0.01)
		addLuaSprite('FrontBodyPile', true)
		
		makeLuaSprite('Overlay', 'BlackDomain/Defeat/iluminao omaga', -600, 50)
		scaleObject('Overlay', 1.3, 1.3)
		setBlendMode('Overlay', 'ADD')
		setProperty('Overlay.alpha', 0.3)
		addLuaSprite('Overlay', true)
		
		makeLuaSprite('Vignette', 'hudStuffs/vignette', 0, 0)
		setObjectCamera('Vignette', 'camOther')
		scaleObject('Vignette', 1, 1)
		setProperty('Vignette.alpha', 0)
		addLuaSprite('Vignette', true)
		
		makeLuaSprite('SuperVignette', 'hudStuffs/vignetteButDarker', 0, 0)
		setObjectCamera('SuperVignette', 'camOther')
		scaleObject('SuperVignette', 1, 1)
		setProperty('SuperVignette.alpha', 0)
		addLuaSprite('SuperVignette', true)
	end
	
	setProperty('losingValue', 25)
end

function onCreatePost()
	if songName == 'Defeat' then
		makeLuaSprite('AuraGlow', 'BlackDomain/Defeat/Aura', getProperty('dad.x')+250, getProperty('dad.y')+85)
		scaleObject('AuraGlow', 0.05, 0.05)
		setProperty('AuraGlow.color', getColorFromHex('FF1000'))
		setProperty('AuraGlow.alpha', 0.01)
		addLuaSprite('AuraGlow', true)
	
		if StartState == 0 then
			makeLuaSprite('BlackScreen', '', 0, 0)
			makeGraphic('BlackScreen', 1300, 750, '000000')
			setObjectCamera('BlackScreen','other')
			addLuaSprite('BlackScreen')
		
			makeLuaSprite('OverlayForStartState', 'BlackDomain/Defeat/Paritcles', -330, -10)
			scaleObject('OverlayForStartState', 5, 2)
			setProperty('OverlayForStartState.color', getColorFromHex('EA0000'))
			setObjectCamera('OverlayForStartState', 'other')
			setProperty('OverlayForStartState.alpha', 0.25)
			addLuaSprite('OverlayForStartState')
			
			runTimer('OverlayPulse', 2.4, 0)
			
			makeLuaText('Quote', Quotes[getRandomInt(1, #(Quotes))], 1300, 0, 200)
			setTextSize('Quote', 45)
			setTextColor('Quote', 'FF1000')
			setTextBorder('Quote', 2.5, 'C00000')
			setTextAlignment('Quote', 'center')
			setTextFont('Quote', 'Gravedigger.otf')
			setObjectCamera('Quote', 'other')
			setProperty('Quote.alpha', 0)
			addLuaText('Quote')
			doTweenY('QuoteY', 'Quote', 280, 2, 'sineOut')
			doTweenAlpha('QuoteAlpha', 'Quote', 1, 1.5)
			
			runTimer('Continue', 4)
			
			makeLuaText('ComboString', MaxCombo, 500, 390, 400)
			setTextSize('ComboString', 80)
			setTextAlignment('ComboString', 'center')
			setTextFont('ComboString', 'Gravedigger.otf')
			setObjectCamera('ComboString', 'other')
			addLuaText('ComboString')
			
			IllusX, IllusY = 300, 370; 
			for i=1, 3 do
				makeLuaSprite('Illus'..i, 'hudStuffs/Oof'..i, IllusX, IllusY)
				setObjectCamera('Illus'..i, 'other')
				scaleObject('Illus'..i, 1.3, 1.3)
				setProperty('Illus'..i..'.flipX', true)
				setProperty('Illus'..i..'.alpha', 0)
				addLuaSprite('Illus'..i)
				
				IllusX = IllusX + 7;
				IllusY = IllusY + 35;
			end
			
			IllusX, IllusY = 830, 370; 
			for i=4, 6 do
				makeLuaSprite('Illus'..i, 'hudStuffs/Oof'..(i-3), IllusX, IllusY)
				setObjectCamera('Illus'..i, 'other')
				scaleObject('Illus'..i, 1.3, 1.3)
				setProperty('Illus'..i..'.alpha', 0)
				addLuaSprite('Illus'..i)
				
				IllusX = IllusX + 7;
				IllusY = IllusY + 35;
			end
			
			makeLuaText('TimeLeft', '20', 1000, 0, 0)
			setTextSize('TimeLeft', 400)
			setTextColor('TimeLeft', 'FF1000')
			setTextBorder('TimeLeftShadow', 0, '000000')
			setTextAlignment('TimeLeft', 'center')
			setTextFont('TimeLeft', 'Gravedigger.otf')
			setObjectCamera('TimeLeft', 'other')
			setProperty('TimeLeft.alpha', 0)
			screenCenter('TimeLeft')
			addLuaText('TimeLeft', true)
			
			makeLuaText('TimeLeftShadow', getTextString('TimeLeft'), 1000, 0, 0)
			setTextSize('TimeLeftShadow', 400)
			setTextColor('TimeLeftShadow', 'FF1000')
			setTextBorder('TimeLeftShadow', 0, '000000')
			setTextAlignment('TimeLeftShadow', 'center')
			setTextFont('TimeLeftShadow', 'Gravedigger.otf')
			setObjectCamera('TimeLeftShadow', 'other')
			setProperty('TimeLeftShadow.alpha', 0)
			screenCenter('TimeLeftShadow')
			addLuaText('TimeLeftShadow', true)
			
			playSound('BlackStartTheme', 0.7, 'Ominous')	
		end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
		setProperty('scoreTxt.color', getColorFromHex('333333'))
	end
end

function camSet(camToggle, zoomValue, zoom1Value, addAmount)
	if string.lower(camToggle) == 'mid' then
		CZoom = zoomValue;
		CZoom1 = zoom1Value;
		xx, xx2 = 1070, 1070;
		yy, yy2 = 850, 850;
	elseif string.lower(camToggle) == 'set' then
		CZoom = zoomValue;
		CZoom1 = zoom1Value;
	elseif string.lower(camToggle) == 'add' then
		CZoom = CZoom + addAmount;
		CZoom1 = CZoom1 + addAmount;
		yy = yy + 10;
		yy2 = yy;
	elseif string.lower(camToggle) == 'reset' then
		xx = 950;	yy = 850;	xx2 = 1130;	yy2 = 850; CZoom = zoomValue;	CZoom1 = zoom1Value;
	end
end

local Particle = 0;
local maxParticle = 250;
local ParRate = 5;

local Dead = false;

function finishHim()
	Dead = true;
	doTweenZoom('camGameDeadZoom', 'camGame', 0.62, 1, 'backOut')
	
	setProperty('boyfriend.animation.curAnim.frameRate', 0)
	setProperty('dad.alpha', 0)
	objectPlayAnimation('BlackKill', 'death', true)
	setProperty('BlackKill.alpha', 1)
	playSound('edefeat', 1)
	
	Stop = true;
	setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0)
	setProperty('vocals.volume', 0)
	setPropertyFromClass('PlayState', 'instance.generatedMusic', false)
	
	doTweenAlpha('HUDBye', 'camHUD', 0, 0.25)
	
	runTimer('DIE', 3.07)
end

function onStepHit()
	if songName == 'Defeat' then	
		if curStep == 272 then
			xx, xx2 = 950, 1130;
			yy, yy2 = 850, 850;
			camSet('set', 0.55, 0.55)
		end
		if curStep == 784 then
			camSet('mid', 0.6, 0.6)
		end
		if curStep >= 800 and curStep < 1040 and curStep % 16 == 0 then
			camSet('add', 0, 0, 0.07)
		end
		if curStep == 848 or curStep == 912 or curStep == 976 then
			camSet('mid', 0.7, 0.7)
		end
		if curStep == 1040 then
			camSet('mid', 0.5, 0.5)
		end
		if curStep == 1168 then
			camSet('reset', 0.65, 0.65)
		end
		if curStep == 1440 then
			camSet('reset', 0.47, 0.47)
		end
		if curStep == 1696 or curStep == 1760 or curStep == 1824 then
			camSet('mid', 0.6, 0.6)
		end
		if ((curStep >= 1712 and curStep < 1760) or (curStep >= 1776 and curStep < 1824) or (curStep >= 1840 and curStep < 1952)) and curStep % 16 == 0 then
			camSet('add', 0, 0, 0.05)
		end
		if curStep == 1952 then
			doTweenAlpha('BlackScreenAlpha', 'BlackScreen', 1, 1)
			cameraFlash('camOther', '0xFF1000', 1, true)
		end
	
		if curStep == 246 then
			characterPlayAnim('dad', 'start', true)
			setProperty('dad.specialAnim', true)
		end
		if curStep == 270 then
			setProperty('AuraGlow.alpha', 1)
			doTweenX('AuraGlowScaleX', 'AuraGlow.scale', 6.7, 0.06)
			doTweenY('AuraGlowScaleY', 'AuraGlow.scale', 6.7, 0.06)
			runTimer('ByeAuraGlow', 0.5)
			
			MoveTime = 0;
			for i=0, 3 do
				noteTweenY('NoteY'..i, i, 900 + getRandomInt(-100, 400), 1.25, 'backIn')
				noteTweenX('NoteX'..i, i, _G['defaultOpponentStrumX'..i] + getRandomInt(-100, 100), 1.25, 'sineInOut')
				noteTweenAngle('NoteAngle'..i, i, getRandomInt(-700, 700)/10, 1, 'sineInOut')
				
				if not middlescroll then
					noteTweenX('NoteX'..i+4, i+4, _G['defaultPlayerStrumX'..i] - 322, 2 + MoveTime, 'elasticOut')
					MoveTime = MoveTime + 0.125;
				end
			end
			doTweenX('timeBarX', 'timeBar', getProperty('timeBar.x')+ 335, 2, 'elasticOut')
			doTweenX('timeTxtX', 'timeTxt', getProperty('timeTxt.x')+ 335, 2, 'elasticOut')
				
			doTweenAlpha('iconP1Alpha', 'iconP1', 0, 0.15)
			doTweenAlpha('iconP2Alpha', 'iconP2', 0, 0.15)
			doTweenAlpha('scoreTxtAlpha', 'scoreTxt', 0, 0.15)
			doTweenAlpha('healthBarAlpha', 'healthBar', 0, 0.15)
			doTweenAlpha('healthBarBGAlpha', 'healthBarBG', 0, 0.15)
		end
		if curStep == 272 then --272
			--Everything moved to function onTimerCompleted()
		end
		if curStep == 384 then
			SpecialHUD = true;
			
			setProperty('scoreTxt.color', getColorFromHex('FF0000'))
			doTweenAlpha('iconP1Alpha', 'iconP1', 1, 1.2)
			doTweenAlpha('iconP2Alpha', 'iconP2', 1, 1.2)
			doTweenAlpha('scoreTxtAlpha', 'scoreTxt', 1, 1.2)
		end	
		
		if curStep == 1040 then
			doTweenAlpha('BlackScreenAlpha', 'BlackScreen', 1, 7, 'sineInOut')
		end
		if curStep == 1152 then
			triggerEvent('Change Character', '0', 'BF_Defeat')
			triggerEvent('Change Character', '1', 'Black')
			
			setProperty('timeBar.alpha', 0)
			setProperty('timeTxt.alpha', 0)
			for i=4, 7 do
				setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
				noteTweenAlpha('Note'..i, i, 0.8, getRandomFloat(1,4))
			end
			setProperty('Vignette.alpha', 1)
			setProperty('SuperVignette.alpha', 1)
			setObjectCamera('BlackScreen', 'hud')
			
			setBlendMode('BodyPile', 'MULTIPLY')
			setProperty('SideBodyPile.alpha', 0)	
			setProperty('FrontBodyPile.alpha', 0)
			setProperty('Overlay.alpha', 0.3)
		end
		
		if curStep == 1440 then
			triggerEvent('Change Character', '0', 'BF_Defeat_Scared')
			triggerEvent('Change Character', '1', 'Black_Defeat')
			
			setBlendMode('BodyPile', 'NORMAL')
			setProperty('SideBodyPile.alpha', 1)	
			setProperty('FrontBodyPile.alpha', 1)
			setProperty('Overlay.alpha', 1)
			for i=1, 6 do
				setProperty('Spark'..i..'.alpha', getRandomFloat(6.5, 1))
			end			

			
			for i=4, 7 do
				setPropertyFromGroup('strumLineNotes', i, 'alpha', 1)
			end
			setProperty('timeBar.alpha', 1)
			setProperty('timeTxt.alpha', 1)
			cameraFlash('camOther', '0xFFFFFF', 1, true)
			removeLuaSprite('Vignette', true)
			removeLuaSprite('SuperVignette', true)
			setObjectCamera('BlackScreen', 'other')
			setProperty('BlackScreen.alpha', 0)
		end
		
		if curStep == 1696 then
			ParRate = 2;
		end
		if curStep == 1824 then
			ParRate = 1;
		end
	end
end

function onBeatHit()
	if songName == 'Defeat' then
		if curBeat % 4 == 0 then
			objectPlayAnimation('BG', 'Glow', true)
		end
	end
end

function onUpdatePost(elapsed)
	if SpecialHUD then
		setProperty('iconP2.x', 20)
		setProperty('iconP1.x', 1120)
	end
	
	if Stop then
		setPropertyFromClass('Conductor', 'songPosition', getPropertyFromClass('Conductor', 'songPosition') - elapsed * 1000  ) -- it is counted by milliseconds, 1000 = 1 second
		setPropertyFromClass('flixel.FlxG', 'sound.music.time', getPropertyFromClass('Conductor', 'songPosition'))
		setProperty('vocals.time', getPropertyFromClass('Conductor', 'songPosition'))
	end
end

local Numbers = {
	{'ZERO', 'NUMPADZERO'},
	{'ONE', 'NUMPADZERO'},
	{'TWO', 'NUMPADZERO'},
	{'THREE', 'NUMPADZERO'},
	{'FOUR', 'NUMPADZERO'},
	{'FIVE', 'NUMPADZERO'},
	{'SIX', 'NUMPADZERO'},
	{'SEVEN', 'NUMPADZERO'},
	{'EIGHT', 'NUMPADZERO'},
	{'NINE', 'NUMPADZERO'}
}

local TypeLinePrevCheck = 0;

local Flicker = false;

local scoreUpdate = false;

function onUpdate(elapsed)
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ANY') and StartState == 0 then
		StartState = 1;
		doTweenAlpha('QuoteGoneAlpha', 'Quote', 0, 0.7)
		doTweenAlpha('ContinueAlpha', 'Continue', 0, 0.7)
		
		playSound('TickTickTimeIsOver', 20, 'ticktock')
		runTimer('Tick_tock_tick_tock', 1)
		playSound('Task_Inprogress', 1)
	end
	if StartState == 1 and getProperty('WhiteLine.alpha') == 1 then
		for i=1, 10 do
			if (keyboardJustPressed(''..Numbers[i][1]) or keyboardJustPressed(''..Numbers[i][2])) and #MaxCombo < 3 then
				MaxCombo = MaxCombo..(i-1);
				MaxCombo = tonumber(MaxCombo);
				MaxCombo = tostring(MaxCombo);
				setTextString('ComboString', MaxCombo);
				if #MaxCombo > TypeLinePrevCheck then
					if i-1 == 1 then
						setProperty('TypeLine.x', getProperty('TypeLine.x')+23)
					else
						setProperty('TypeLine.x', getProperty('TypeLine.x')+46)
					end
				end
				TypeLinePrevCheck = #MaxCombo;
				
				playSound('Typing'..getRandomInt(1,3), 1)
			end
		end
		if (keyboardJustPressed(''..Numbers[1][1]) or keyboardJustPressed(''..Numbers[1][2])) and MaxCombo == '0' then
			setProperty('TypeLine.x', 682)
		end
		
		if keyJustPressed('back') and #MaxCombo > 0 and StartState == 1 then
			if tonumber(MaxCombo:sub(#MaxCombo, #MaxCombo)) == 1 then
				setProperty('TypeLine.x', getProperty('TypeLine.x')-23)
			else
				setProperty('TypeLine.x', getProperty('TypeLine.x')-46)
			end
			MaxCombo = MaxCombo:sub(1, #MaxCombo - 1);
			setTextString('ComboString', MaxCombo);
			
			if #MaxCombo == 0 then
				setProperty('TypeLine.x', 636)
			end
			
			TypeLinePrevCheck = #MaxCombo;
			
			playSound('Typing'..getRandomInt(1,3), 1)
		end
		
		if keyboardJustPressed('ENTER') and StartState == 1 then
			if #MaxCombo == 1 then
				StartState = 2;
				cancelTimer('TypeLineBlink')
				doTweenAlpha('TimeLeftText', 'TimeLeft', 0, 0.5)
				soundFadeOut('ticktock', 0.5, 0)
				if getRandomBool(80) then
					endStartState();
					
					playSound('Task_Complete', 1)
				elseif tonumber(MaxCombo) > 3 then
					setProperty('TypeLine.alpha', 0)
					cameraFlash('camOther', '0xFF1000', 0.5, true)
				
					makeAnimatedLuaSprite('KnifePierce', 'hudStuffs/KnifePierce', getProperty('ComboString.x')+70, getProperty('ComboString.y')-90)
					addAnimationByPrefix('KnifePierce', 'Stab', 'Knife', 48, false)
					setObjectCamera('KnifePierce', 'other')
					scaleObject('KnifePierce', 0.35, 0.35)
					addLuaSprite('KnifePierce', true)
					objectPlayAnimation('KnifePierce', 'Stab', true)
					
					playSound('Black_Stabs_Throgh_Screen', 1)
					playSound('Impostor_Discovered', 0.7)
					
					runTimer('KnifeGoesBruh', 0.7)
					soundFadeOut('Ominous', 0.75, 0)
				else
					endStartState();
				end
			elseif #MaxCombo > 1 then
				doTweenAlpha('TimeLeftText', 'TimeLeft', 0, 0.5)
				soundFadeOut('ticktock', 0.5, 0)
			
				StartState = 2;
				setProperty('TypeLine.alpha', 0)
				cameraFlash('camOther', '0xFF1000', 0.5, true)
				
				makeAnimatedLuaSprite('KnifePierce', 'hudStuffs/KnifePierce', getProperty('ComboString.x')+70, getProperty('ComboString.y')-90)
				addAnimationByPrefix('KnifePierce', 'Stab', 'Knife', 48, false)
				setObjectCamera('KnifePierce', 'other')
				scaleObject('KnifePierce', 0.35, 0.35)
				addLuaSprite('KnifePierce', true)
				objectPlayAnimation('KnifePierce', 'Stab', true)
				
				playSound('Black_Stabs_Throgh_Screen', 1)
				playSound('Impostor_Discovered', 0.7)
				
				runTimer('KnifeGoesBruh', 0.7)
				soundFadeOut('Ominous', 0.25, 0)
			end
		end
	end
	
	if StartState == 1 then
		if MaxCombo == nil or (tonumber(MaxCombo) >= 0 and tonumber(MaxCombo) <= 2) then
			setProperty('Illus1.alpha', 0)	setProperty('Illus4.alpha', 0)	setProperty('Illus2.alpha', 0)	setProperty('Illus5.alpha', 0)
			
			setProperty('Illus3.alpha', 1)	setProperty('Illus6.alpha', 1)
		elseif tonumber(MaxCombo) > 2 and tonumber(MaxCombo) <= 7 then
			setProperty('Illus3.alpha', 0)	setProperty('Illus6.alpha', 0)	setProperty('Illus1.alpha', 0)	setProperty('Illus4.alpha', 0)	

			setProperty('Illus2.alpha', 1)	setProperty('Illus5.alpha', 1)
		elseif tonumber(MaxCombo) > 7 then
			setProperty('Illus2.alpha', 0)	setProperty('Illus5.alpha', 0)	setProperty('Illus3.alpha', 0)	setProperty('Illus6.alpha', 0)

			setProperty('Illus1.alpha', 1)	setProperty('Illus4.alpha', 1)
		end
	end
	if Flicker then
		setProperty('RedFlicker.alpha', getRandomFloat(3, 6)/10)
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	if songName == 'Defeat' and curStep >= 1440 and curStep % ParRate == 0 then
		ParticleX = getRandomInt(350, 1950); -- -200 ~ 2100
		makeLuaSprite('particle'..Particle, 'BlackDomain/Defeat/Paritcles', ParticleX, 1600)
		rngScale = getRandomFloat(4,8)/10;
		scaleObject('particle'..Particle, rngScale, rngScale)
		setScrollFactor('particle'..Particle, 0.9, 0.9)
		if getRandomBool(50) then
			setBlendMode('particle'..Particle, 'ADD')
		end
		setProperty('particle'..Particle..'.color', getColorFromHex('EA0000'))
		setProperty('particle'..Particle..'.alpha', getRandomFloat(4,10)/10)
		setObjectOrder('particle'..Particle, getObjectOrder('FrontBodyPile')-1)	
		addLuaSprite('particle'..Particle, true)
		TweenTime = getRandomInt(10,40)/10;
		doTweenY('particleY'..Particle, 'particle'..Particle, -100, TweenTime)
		if getRandomBool(50) then
			doTweenX('particleX'..Particle, 'particle'..Particle, -200 + getRandomInt(-100, 500), TweenTime/getRandomFloat(1,3), 'backOut')
		else
			doTweenX('particleX'..Particle, 'particle'..Particle, 2100 + getRandomInt(-500, 100), TweenTime/getRandomFloat(1,3), 'backOut')
		end
		SmallTime = getRandomInt(-20, 7)/10;
		doTweenX('particleYScale'..Particle, 'particle'..Particle..'.scale', 0.01, TweenTime+SmallTime, 'sineInOut')
		doTweenY('particleXScale'..Particle, 'particle'..Particle..'.scale', 0.01, TweenTime+SmallTime, 'sineInOut')
		Particle=Particle+1; if Particle >= maxParticle then Particle = 0 end
	end
	
	if scoreUpdate then
		setTextString('scoreTxt', 'Score: '..score..' • Misses: '..misses..' / '..tonumber(MaxCombo)..' • Rating: '..(math.floor(rating * 10000)/100)..'% < '..ratingName ..' > ~ '..ratingFC)
	end
	
	if misses > tonumber(MaxCombo) and not Dead and not practice then
		finishHim();
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

function onSongStart()
	removeLuaText('Quote', true)
	removeLuaText('ComboString', true)
	removeLuaText('Continue', true)
	removeLuaSprite('EyeSpark', true)
	removeLuaSprite('KnifePierce', true)
	removeLuaSprite('WhiteLine', true)
	removeLuaSprite('TypeLine', true)
	removeLuaSprite('RedFlicker', true)
	removeLuaSprite('OverlayForStartState', true)
	removeLuaText('TimeLeft', true)
	removeLuaText('TimeLeftShadow', true)
	for i=1, 6 do 	
		removeLuaSprite('Illus'..i, true)
	end
	stopSound('Ominous')
	stopSound('ticktock')
end

function onPause()
	if Stop then
		return Function_Stop;
	else
		return Function_Continue;
	end
end

function endStartState()
	doTweenAlpha('ContinueAlpha', 'Continue', 0, 0.75)
	doTweenAlpha('QuoteAlphaGone', 'Quote', 0, 0.75)
	doTweenAlpha('WhiteLineAlphaGone', 'WhiteLine', 0, 0.75)
	doTweenAlpha('TypeLineAlphaGone', 'TypeLine', 0, 0.75)
	doTweenAlpha('ComboStringAlphaGone', 'ComboString', 0, 0.75)
	doTweenAlpha('OverlayForStartStateAlpha', 'OverlayForStartState', 0, 0.75)
	for i=1, 6 do 	
		doTweenAlpha('IllusAlpha'..i, 'Illus'..i, 0, 0.75)	
	end	
	doTweenAlpha('OverlayForStartStateAlpha', 'OverlayForStartState', 0, 0.75)
	cancelTimer('OverlayPulse')
	cancelTween('OverlayForStartStateAlphaFadeAway')
	cancelTween('OverlayForStartStateAlphaPulse')
	
	soundFadeOut('Ominous', 0.75, 0)
end

local PunishingQuote = {
	'NO!',
	'TOO MUCH!',
	'MUCH BETTER.',
	'YOU THOUGHT?',
	'MORE CHALLENGING NOW EY?'
}

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'DIE' then
		Stop = false;
		setPropertyFromClass('PlayState', 'instance.generatedMusic', true)
		setProperty('health', -2)
	end
	
	if tag == 'OverlayPulse' then
		doTweenAlpha('OverlayForStartStateAlphaPulse', 'OverlayForStartState', 0.45, 0.075)
	end
	
	if tag == 'Continue' then
		if StartState == 0 then
			makeLuaText('Continue', 'Press any button to Continue', 1300, 0, 700)
			setTextSize('Continue', 20)
			setTextColor('Continue', 'C00000')
			setTextAlignment('Continue', 'center')
			setTextFont('Continue', 'Gravedigger.otf')
			setObjectCamera('Continue', 'other')
			setProperty('Continue.alpha', 0)
			addLuaText('Continue')
			doTweenY('ContinueY', 'Continue', 650, 3, 'sineOut')
			doTweenAlpha('ContinueAlpha', 'Continue', 0.7, 2.5)
		elseif StartState == 1 then
			makeLuaText('Continue', 'Press Enter to Continue', 1300, 0, 700)
			setTextSize('Continue', 20)
			setTextColor('Continue', 'C00000')
			setTextAlignment('Continue', 'center')
			setTextFont('Continue', 'Gravedigger.otf')
			setObjectCamera('Continue', 'other')
			setProperty('Continue.alpha', 0)
			addLuaText('Continue')

			doTweenY('ContinueY', 'Continue', 650, 3, 'sineOut')
			doTweenAlpha('ContinueAlpha', 'Continue', 0.7, 2.5)
		end
	end
	
	if tag == 'TypeLineBlink' and StartState == 1 then
		setProperty('TypeLine.alpha', math.abs(getProperty('TypeLine.alpha')-1))
	end
	
	if tag == 'KnifeGoesBruh' then
		doTweenAngle('KnifePierceAngle', 'KnifePierce', -90, 0.3, 'elasticOut')
		runTimer('KnifeSwipe', 0.35)
	end
	if tag == 'KnifeSwipe' then
		doTweenX('KnifePierceX', 'KnifePierce', getProperty('KnifePierce.x')-300, 0.4, 'backOut')
		-- playSound('SwipeScratch', 0.3)
	end
	
	if tag == 'BlackKnows' then
		cameraFlash('camOther', '0xFF0000', 2, true)
	
		setProperty('KnifePierce.alpha', 0)
		
		for i=1, 6 do 	setProperty('Illus'..i..'.alpha', 0)	end	setProperty('Illus3.alpha', 1)	setProperty('Illus6.alpha', 1);
		
		makeAnimatedLuaSprite('EyeSpark', 'hudStuffs/EyeSpark', getRandomInt(-50, 800), getRandomInt(-25, 400))
		addAnimationByPrefix('EyeSpark', 'Eye', 'Spark_Up', getRandomInt(50, 100), true)
		setObjectCamera('EyeSpark', 'other')
		rngScale = getRandomFloat(8, 13)/10
		scaleObject('EyeSpark', rngScale, rngScale)
		setObjectOrder('EyeSpark', getObjectOrder('BlackScreen')+1)
		addLuaSprite('EyeSpark')
		
		makeLuaSprite('RedFlicker', '', 0, 0)
		makeGraphic('RedFlicker', 1300, 750, 'FF0000')
		setObjectCamera('RedFlicker','other')
		addLuaSprite('RedFlicker')
		setObjectOrder('RedFlicker', getObjectOrder('BlackScreen')+1)
		Flicker = true;
		
		setTextBorder('ComboString', 0, '000000')
		setTextColor('ComboString', 'FF1000')
		setProperty('WhiteLine.color', getColorFromHex('FF1000'))
		setTextBorder('Quote', 0, '000000')
		if #MaxCombo == 1 then
			setTextString('Quote', PunishingQuote[getRandomInt(1, #(PunishingQuote))])
			setTextSize('Quote', getTextSize('Quote')+17)
			MaxCombo = getRandomInt(0, math.ceil(tonumber(MaxCombo)/2))
		else
			setTextString('Quote', 'UNACCEPTABLE!!')
			setTextItalic('Quote')
			setTextSize('Quote', getTextSize('Quote')+40)
			rngDigit = getRandomInt(1, #MaxCombo);
			MaxCombo = MaxCombo:sub(rngDigit, rngDigit)
		end
		setTextString('ComboString', MaxCombo)
		
		playSound('Dramatic_Reveal_Impostor', 1)
		playSound('Vote_Screen_Player_Dead', 1)
		playSound('Defeated', 1)
		
		runTimer('IntenseBuildUp', 3.5)
		runTimer('StartState_Bye', 5)
	end
	
	if tag == 'IntenseBuildUp' then
		playSound('Intese_BuildUp', 0.7)
	end
	if tag == 'StartState_Bye' then
		endStartState()
		doTweenAlpha('EyeSparkAlphaBye', 'EyeSpark', 0, 0.5)
	end
	
	if tag == 'ByeAuraGlow' then --curStep 272
		setProperty('OppSplash', false)
		
		-- cameraFlash('camOther', '0xFFFFFF', 1, true)
		setProperty('BG.alpha', 1)
		setBlendMode('BodyPile', 'NORMAL')
		setProperty('BodyPile.alpha', 1)		
		setProperty('SideBodyPile.alpha', 1)	
		setProperty('FrontBodyPile.alpha', 1)
		setProperty('Overlay.alpha', 1)
		
		triggerEvent('Change Character', '0', 'BF_Defeat_Scared')
		triggerEvent('Change Character', '1', 'Black_Defeat')
	
		doTweenAlpha('AuraGlowAlpha', 'AuraGlow', 0, 2)
	end
	
	if tag == 'Tick_tock_tick_tock' and tonumber(getTextString('TimeLeft')) > 0 and StartState == 1 then
		setTextString('TimeLeft', tostring(tonumber(getTextString('TimeLeft'))-1))
		setTextString('TimeLeftShadow', getTextString('TimeLeft'))
		-- debugPrint(tonumber(getTextString('TimeLeft')))
		if tonumber(getTextString('TimeLeft')) == 7 then
			doTweenAlpha('TimeLeftText', 'TimeLeft', 0.6, 6)
		end
		if tonumber(getTextString('TimeLeft')) <= 5 then
			setProperty('TimeLeftShadow.scale.x', 1)
			setProperty('TimeLeftShadow.scale.y', 1)
			setProperty('TimeLeftShadow.alpha', getProperty('TimeLeft.alpha')-0.15)
			doTweenAlpha('TimeLeftShadowAlpha', 'TimeLeftShadow', 0, 0.7)
			rngScale = getRandomFloat(15, 25)/10;
			doTweenX('TimeLeftShadowScaleX', 'TimeLeftShadow.scale', rngScale, 0.9, 'sineOut')
			doTweenY('TimeLeftShadowScaleY', 'TimeLeftShadow.scale', rngScale, 0.9, 'sineOut')
		end
		runTimer('Tick_tock_tick_tock', 1)
	end
	if tag == 'Tick_tock_tick_tock' and tonumber(getTextString('TimeLeft')) <= 0 and StartState == 1 then
		StartState = 2;
		playSound('Final_Hide_alert', 1)
		doTweenAlpha('TimeLeftText', 'TimeLeft', 0, 0.25)
		MaxCombo = '0';
		setTextString('ComboString', MaxCombo)
		runTimer('BlackKnows', 0.01)
	end
end

function onTweenCompleted(tag)
	if tag == 'ByeAuraGlow' then
		removeLuaSprite('AuraGlowAlpha', true)
	end

	if tag == 'OverlayForStartStateAlphaPulse' then
		doTweenAlpha('OverlayForStartStateAlphaFadeAway', 'OverlayForStartState', 0.25, 1.5)
	end

	if tag == 'QuoteGoneAlpha' and StartState == 1 then
		setTextString('Quote', 'Set your Combo Break Limit:')
		setTextSize('Quote', 50)
		setProperty('Quote.y', 150)
		doTweenY('QuoteY', 'Quote', 200, 1, 'sineOut')
		doTweenAlpha('QuoteAlpha', 'Quote', 1, 0.75)
		
		makeLuaSprite('WhiteLine', '', 540, 500)
		makeGraphic('WhiteLine', 200, 10, 'FFFFFF')
		setObjectCamera('WhiteLine','other')
		setProperty('WhiteLine.alpha', 0.001)
		addLuaSprite('WhiteLine')
		doTweenAlpha('WhiteLineAlpha', 'WhiteLine', 1, 0.7)
		-- screenCenter('WhiteLine')
		-- debugPrint(getProperty('WhiteLine.x')..' '..getProperty('WhiteLine.y'))
		
		makeLuaSprite('TypeLine', '', 636, 405)
		makeGraphic('TypeLine', 8, 90, 'FFFFFF')
		setObjectCamera('TypeLine','other')
		setProperty('TypeLine.alpha', 0.001)
		addLuaSprite('TypeLine')
		runTimer('TypeLineBlink', 0.5, 0)
		-- screenCenter('TypeLine')
		-- debugPrint(getProperty('TypeLine.x')..' '..getProperty('TypeLine.y'))
		
		doTweenAlpha('Illus1Alpha', 'Illus1', 1, 0.75)
		doTweenAlpha('Illus4Alpha', 'Illus4', 1, 0.75)
		
		runTimer('Continue', 3.5)
	end
	if tag == 'TypeLineAlphaGone' and StartState == 2 then
		allowCountdown = true;
		startCountdown();
		doTweenAlpha('BlackScreenAlpha', 'BlackScreen', 0, 1.5)
		
		Flicker = false;
		doTweenAlpha('RedFlickerAlphaBye', 'RedFlicker', 0, 0.2)
	end
	
	if tag == 'KnifePierceX' then
		doTweenX('KnifePierceSwipe', 'KnifePierce', getProperty('KnifePierce.x')+800, 0.14)
		runTimer('BlackKnows', 0.09)
		
		-- playSound('Swipe', 0.3)
	end
-------------------------------------------------------------------------------------------------------------------------------------------------------------
	for i=0, 3 do
		if tag == 'NoteY'..i then
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
		end
	end
	
	for p=0, maxParticle do
		if tag == 'particleY'..p then
			removeLuaSprite('particle'..p)
		end
	end
end

function onGameOver()
	if ScreenState < 2 then
		return Function_Stop;
	else
		return Function_Continue;
	end
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
	if songName == 'Defeat' then
		if curStep >= 1168 and curStep < 1440 and not isSustainNote and getRandomBool(50) then
			cancelTween('BlackScreenAlpha')
			setProperty('BlackScreen.alpha', 0.3)
			doTweenAlpha('BlackScreenAlpha', 'BlackScreen', 1, 0.7)
		end
		
		if getProperty('health') > 0.5 and curStep >= 272 then
			setProperty('health', getProperty('health')-0.035*getProperty('health'))
		end
	end
end

function goodNoteHit(id, direction, noteType, isSustainNote)
	if songName == 'Defeat' and curStep >= 1168 and curStep < 1440 and not isSustainNote and getRandomBool(50) then
		cancelTween('BlackScreenAlpha')
		setProperty('BlackScreen.alpha', 0.3)
		doTweenAlpha('BlackScreenAlpha', 'BlackScreen', 1, 0.7)
	end
	
	if not scoreUpdate and not botPlay then
		scoreUpdate = true;
	end
end

function noteMissPress(direction)
	if not scoreUpdate and not botPlay then
		scoreUpdate = true;
	end
end

function noteMiss(id, direction, noteType, isSustainNote)
	if not scoreUpdate and not botPlay then
		scoreUpdate = true;
	end
end

function onDestroy()
	setPropertyFromClass('HealthIcon', 'iconFPS', 17)
end