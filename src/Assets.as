package {
	import net.flashpunk.graphics.Tilemap;
	
	/**
	 * ...
	 * @author Christopher Ferris
	 */
	public class Assets {
		// Tilesets
		[Embed(source = 'assets/jungle_tileset.png')] public static const JUNGLE_TILESET:Class;
		
		// Player	
		[Embed(source = 'assets/player/spaceman.png')] public static const PLAYER:Class;
		
		// Levels
		[Embed(source = 'assets/levels/level1.tmx', mimeType = "application/octet-stream")] public static const JUNGLE_LEVEL:Class;

	}
	
}