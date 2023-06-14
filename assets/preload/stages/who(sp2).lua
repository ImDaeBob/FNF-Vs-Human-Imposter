local xx = -25; --750
local yy = 1250; --750
local zoom = 0.85;
local followchars = true;
local damage = false;
local beating = true;
local beat_skip = 0;

function onCreatePost()
	
	setProperty('gf.alpha', 0);
end

function onCreate()
	--background boi
	addCharacterToList('bluewho')
	addCharacterToList('whitemad')
	makeLuaSprite('bg','BG/who/deadguy', -1100, 250)
	makeLuaSprite('star','BG/who/starBG2', 0, 0)
	setObjectCamera('star', 'other');
    addLuaSprite('bg')
	addLuaSprite('star')
	setProperty('star.alpha', 0);
    
	makeLuaSprite('csdown','cutscene1', 0, 0)
	makeLuaSprite('csup','cutscene2', 0, 0)
	
	addLuaSprite('csup')
	addLuaSprite('csdown')
	
	
	setProperty('csup.alpha', 1);
	setObjectCamera('csup', 'hud');
	setProperty('csdown.alpha', 1);
	setObjectCamera('csdown', 'hud');
	setProperty('flash.alpha', 1);
	setObjectCamera('flash', 'other');
	
	
	makeAnimatedLuaSprite('warning','BG/who/meeting', -50, 50)
	addAnimationByPrefix('warning','loop','meeting buzz',24,false)
    objectPlayAnimation('warning','loop',false);
	addLuaSprite('warning')
	setObjectCamera('warning', 'other');
	scaleObject('warning',1.5,1.5)
	
	makeLuaSprite('KILLYOURSELF','BG/who/KILLYOURSELF2', 400, 100)
	setObjectCamera('KILLYOURSELF', 'other');
	addLuaSprite('KILLYOURSELF', true)
	scaleObject('KILLYOURSELF',0.75,0.75)
	
	makeLuaSprite('emergency','BG/who/emergency', 430, 400)
	setObjectCamera('emergency', 'other');
	addLuaSprite('emergency', true)
	scaleObject('emergency',0.5,0.5)
	
	makeLuaSprite('angrydude','BG/who/mad mad dude2', -300, 200)
	setObjectCamera('angrydude', 'other');
	addLuaSprite('angrydude', true)
	
	setProperty('warning.alpha', 0);
	setProperty('KILLYOURSELF.alpha', 0);
	setProperty('emergency.alpha', 0);
	
	makeLuaText('SubWhite', ' ', 0, 300, 535)
	setTextFont('SubWhite', 'CookieRun Black.ttf')
	setTextSize('SubWhite', 46)
	setObjectCamera('SubWhite', 'other');
	addLuaText('SubWhite', true)
	setTextAlignment('SubWhite', 'SubWhite.center')
	setTextColor('SubWhite', 'ffffff')
	
	makeLuaSprite('Name','WHO2', -500, 100)
	addLuaSprite('Name')
	setObjectCamera('Name', 'hud');
	scaleObject('Name',0.75,0.75)
	
end

function onStepHit()
    if curStep == 384 then
	setTextString('SubWhite', '"I didn′t do it."')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 396 then
	setTextString('SubWhite', '"Nope."')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 402 then
	setTextString('SubWhite', '"And neither did you."')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 411 then
	setTextString('SubWhite', '"Negative."')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 437 then
	setTextString('SubWhite', '"...so who did."')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 448 then
	setTextString('SubWhite', ' ')
	end
	if curStep == 504 then
	setTextString('SubWhite', '"...what the FUCK?!"')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 512 then
	setTextString('SubWhite', '"What the fuck is a bastard!"')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 528 then
	setTextString('SubWhite', '"Someone who′s parent′s arent married,"')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 544 then
	setTextString('SubWhite', '"why are you asking?!"')
	end
	if curStep == 559 then
	setTextString('SubWhite', '"Are you high or something?"')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 576 then
	setTextString('SubWhite', '"Right-Right, e-enough. Stop it."')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 592 then
	setTextString('SubWhite', '"I didnt do it, who did?"')
	end
	if curStep == 611 then
	setTextString('SubWhite', '"Precisely!"')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 630 then
	setTextString('SubWhite', '"FOR FUCK SAKE!!"')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 642 then
	setTextString('SubWhite', '"FOR FUCK SAKE! he′s dead!"')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 655 then
	setTextString('SubWhite', '"who killed him!"')
	end
	if curStep == 662 then
	setTextString('SubWhite', '"That′s what I want to know!"')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 672 then
	setTextString('SubWhite', '"who killed Noob69?"')
	end
	if curStep == 688 then
	setTextString('SubWhite', '"NOW you′re getting it!"')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 696 then
	setTextString('SubWhite', '"You′re gonna get it in a second!"')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 708 then
	setTextString('SubWhite', '"WHOA!!"')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 712 then
	setTextString('SubWhite', '"No need for that, I′m just trying to help!"')
	end
	if curStep == 728 then
	setTextString('SubWhite', '"I′m sorry, I guess I′m just getting paranoid."')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 759 then
	setTextString('SubWhite', '"Everybody is SUS"')
	end
	if curStep == 767 then
	setTextString('SubWhite', '"Everyone? I thought Yellow was SUS"')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 783 then
	setTextString('SubWhite', '"Yellow is SUS?"')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 790 then
	setTextString('SubWhite', '"She was when I met her."')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 800 then
	setTextString('SubWhite', '"As early as that? She kill 69?"')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 818 then
	setTextString('SubWhite', '"Not WHO?"')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 824 then
	setTextString('SubWhite', '"Who what?"')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 830 then
	setTextString('SubWhite', '"What′s What got to do with it?"')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 843 then
	setTextString('SubWhite', '"WHAT DO YOU MEAN!"')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 852 then
	setTextString('SubWhite', '"I MEAN WHO!"')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 872 then
	setTextString('SubWhite', '"WHAT THE FUCK!"')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 881 then
	setTextString('SubWhite', '"Leave that bastard out of it!"')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 896 then
	setTextString('SubWhite', '"Leave who out of it?!"')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 904 then
	setTextString('SubWhite', '"BUT HE′S IS IMPOSTER!"')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 912 then
	setTextString('SubWhite', '"WHO IS THE IMPOSTER?!!"')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 924 then
	setTextString('SubWhite', '"YES!!!"')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 928 then
	setTextString('SubWhite', '"WHAT ARE YOU SAYING?!"')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 942 then
	setTextString('SubWhite', '"I TOLD you he′s in the medical bay!"')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 960 then
	setTextString('SubWhite', '"Arrrrrhhh... why me!!"')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 976 then
	setTextString('SubWhite', '"NO! I AM!"')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 986 then
	setTextString('SubWhite', '"you WHAT?"')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 991 then
	setTextString('SubWhite', '"NO! WHAT IS IN THE MEDICAL BAY! I′M Y!!"')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 1024 then
	setTextString('SubWhite', '"You′re why what?"')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 1040 then
	setTextString('SubWhite', '"Y-FRONTS"')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 1066 then
	setTextString('SubWhite', '"...get it?"')
	end
	if curStep == 1080 then
	setTextString('SubWhite', '"ARRRRRRRRRHHHH!!!!"')
	setTextColor('SubWhite', 'ffffff')
	end
	if curStep == 1088 then
	setTextString('SubWhite', '"IM Going2killevery1startingwithU!!!"')
	end
	if curStep == 1122 then
	setTextString('SubWhite', '"AH HA! SO IT WAS YOU ALL ALONG!!"')
	setTextColor('SubWhite', '6666FF')
	end
	if curStep == 1152 then
	setTextString('SubWhite', ' ')
	end
	-- subs
    if curStep == 1152 then
	setProperty('camHUD.visible', false);
	setProperty('warning.alpha', 1);
	objectPlayAnimation('warning','loop',false);
	end
	if curStep == 1154 then
	setProperty('KILLYOURSELF.alpha', 1);
	setProperty('emergency.alpha', 1);
	end
	if curStep == 1168 then
	setProperty('warning.alpha', 0);
	setProperty('KILLYOURSELF.alpha', 0);
	setProperty('emergency.alpha', 0);
	setProperty('csup.alpha', 0);
	setProperty('csdown.alpha', 0);
	setProperty('bg.alpha', 0);
	setProperty('dad.alpha', 0);
	setProperty('boyfriend.alpha', 0);
	setProperty('star.alpha', 1);
	doTweenAngle('angrydudespinning', 'angrydude', 359, 8, 'linear');
	doTweenX('angrydudeX', 'angrydude', 1300, 8, 'linear');
	end
	if curStep == 1 then
	doTweenX('NameTweenX', 'Name', 0, 2, 'CircInOut');
	runTimer('nameout', 5);
    end
    if curStep == 420 or curStep == 448 or curStep == 708 or curStep == 862 or curStep == 912 or curStep == 1056 or curStep == 1080 then
	--duet
	xx = -25
	yy = 1250
	zoom = 0.85
	end
    if curStep == 396 or curStep == 411 or curStep == 512 or curStep == 560 or curStep == 611 or curStep == 642 or curStep == 688 or curStep == 712 or curStep == 768 or curStep == 790 or curStep == 818 or curStep == 829 or curStep == 852 or curStep == 880 or curStep == 904 or curStep == 942 or curStep == 976 or curStep == 992 or curStep == 1040 or curStep == 1122 then
	--blue
	xx = -360
	yy = 1250
	zoom = 1.15
	end
    if curStep == 384 or curStep == 402 or curStep == 437 or curStep == 504 or curStep == 529 or curStep == 576 or curStep == 629 or curStep == 662 or curStep == 696 or curStep == 728 or curStep == 724 or curStep == 784 or curStep == 800 or curStep == 824 or curStep == 843 or curStep == 871 or curStep == 896 or curStep == 928 or curStep == 959 or curStep == 986 or curStep == 1024 or curStep == 1072 or curStep == 1088  then
	--white
	xx = 425
	yy = 1250
	zoom = 1.15
	end
end

function onUpdate()
    triggerEvent('Camera Follow Pos',xx,yy)
	setProperty('camFollowPos.x',xx)
    setProperty('camFollowPos.y',yy)
	setProperty('camGame.zoom',zoom)
end

function onTimerCompleted(tag, loops, loopsleft)
    if tag == 'nameout' then
	doTweenX('NameTweenX2', 'Name', -500, 2, 'CircInOut');
    end
end