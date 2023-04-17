package;

import flixel.FlxSprite;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;
	private var isOldIcon:Bool = false;
	private var isPlayer:Bool = false;
	private var char:String = '';
	var isAnimated:Bool = false;
	var hasLosingAnim:Bool = true;
	var hasWinningAnim:Bool = false;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		isOldIcon = (char == 'bf-old');
		this.isPlayer = isPlayer;
		changeIcon(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 12, sprTracker.y - 30);
	}

	public function swapOldIcon() {
		if(isOldIcon = !isOldIcon) changeIcon('bf-old');
		else changeIcon('bf');
	}

	private var iconOffsets:Array<Float> = [0, 0];
	public function changeIcon(char:String) {
		if(this.char != char) {
			var name:String = 'icons/' + char;
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-' + char; //Older versions of psych engine's support
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-face'; //Prevents crash from missing icon
			isAnimated = Paths.fileExists('images/' + name + '.xml', IMAGE);
			if(!isAnimated) {
				var file:Dynamic = Paths.image(name);
				loadGraphic(file); //Load stupidly first for getting the file size

				var widthDiv:Int = 2;
				hasWinningAnim = (width == 3 * height);
				if(hasWinningAnim) widthDiv = 3;
				hasLosingAnim = (width == 2 * height) || hasWinningAnim;
				if(!hasLosingAnim) widthDiv = 1;

				loadGraphic(file, true, Math.floor(width / widthDiv), Math.floor(height)); //Then load it fr
				iconOffsets[0] = (width - 150) / widthDiv;
				iconOffsets[1] = (width - 150) / widthDiv;
				updateHitbox();

				animation.add(char, [0, 1, 2], 0, false, isPlayer);
				animation.play(char);
			} else {
				frames = Paths.getSparrowAtlas(name);

				animation.addByPrefix('default', 'normal', 30, true, isPlayer);
				animation.addByPrefix('losing', 'losing', 30, true, isPlayer);
				animation.addByPrefix('winning', 'winning', 30, true, isPlayer);
				animation.play('default');
			}
			this.char = char;

			antialiasing = ClientPrefs.globalAntialiasing;
			if(char.endsWith('-pixel')) {
				antialiasing = false;
			}
		}
	}

	override function updateHitbox()
	{
		super.updateHitbox();
		offset.x = iconOffsets[0];
		offset.y = iconOffsets[1];
	}

	public function getCharacter():String {
		return char;
	}

	public function changeAnim(isLosing:Bool, ?isWinning:Bool = false) {
		if(!isAnimated) {
			if(!isLosing && !isWinning)
				animation.curAnim.curFrame = 0;
			else if(isLosing && hasLosingAnim)
				animation.curAnim.curFrame = 1;
			else if(isWinning && hasWinningAnim)
				animation.curAnim.curFrame = 2;
		} else {
			if(!isLosing && !isWinning)
				animation.play('default');
			else if(isLosing)
				animation.play('losing');
			else if(isWinning)
				animation.play('winning');
		}
	}
}
