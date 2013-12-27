package {
	import flash.utils.ByteArray;	
	import flash.xml.XMLNode;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.graphics.Graphiclist;	
	import net.flashpunk.masks.Grid;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Christopher Ferris
	 */
	public class Level extends Entity {
		private var rawData:ByteArray;
		private var dataString:String;
		private var xmlData:XML;
		
		public var tiles:Tilemap;
		public var xml:Class;
		private var grid:Grid;
		private var _tilemap:Tilemap;
		protected var t:int; //Settings.TILESIZE		
		
		public var w:int;
		public var h:int;
		
		public var jungleTiles:Object;		
		protected var graphicList:Graphiclist;
		protected var notSolids:Array;
		
		// Aliases
		private var _tilesize:int;
		
		public function Level() {
			xml = Assets.JUNGLE_LEVEL;
			rawData = new xml;
			dataString = rawData.readUTFBytes(rawData.length);
			xmlData = new XML(dataString);
			
			w = xmlData.@width;
			h = xmlData.@height;
			
			type = "level";		
			
			jungleTiles = {
				"ground": {
					"topLeft": 1,
					"topMid": 2,
					"topRight": 3,
					"midLeft": 11,
					"middle": 12,
					"midRight": 13,
					"botLeft": 21,
					"botMid": 22,
					"botRight": 23,
					"topLeftTuft": 4,
					"topRightTuft": 5,
					"bottomLeftTuft": 14,
					"bottomRightTuft": 15
				},
				"structure": {
					"block": 7,
					"bg": 17
				},
				"plants": {
					"treeTrunk": 8,
					"treeLeaves": 9
				},
				"constructionBlock": 10,
				"water": 30
			};
			
			notSolids = [
				0,
				jungleTiles["water"],
				jungleTiles["structure"]["bg"],
				jungleTiles["plants"]["treeTrunk"],
				jungleTiles["plants"]["treeLeaves"]
			];
			
			_tilesize = Settings.TILESIZE;
		}
		
		override public function added():void {
			super.added();
			tiles = new Tilemap(Assets.JUNGLE_TILESET, w * _tilesize, h * _tilesize, _tilesize, _tilesize);
			grid = new Grid(w * _tilesize, h * _tilesize, _tilesize, _tilesize, 0, 0);
			mask = grid;
			graphic = new Graphiclist(tiles);
			
			Registry.player_ = new Player();
			FP.world.add(Registry.player_);

			Registry.camera_ = new Camera();
			FP.world.add(Registry.camera_);
			
			Registry.background_ = new Background(0xa29a8d);
			FP.world.add(Registry.background_);
			
			loadLevel();
		}
	
		private function loadLevel():void {
			loadTiles();
			setGrid();
		}
		
		protected function setGrid():void {
			forEachInGrid(function(column:int, row:int, gid:int):void {
				if (checkSolid(column, row)) grid.setTile(column, row, true);
				else grid.setTile(column, row, false);		
			});
		}
		
		private function loadTiles():void {
			var dataList:XMLList = xmlData.layer.(@name=="ground").data.tile.@gid;

			//set tiles
			forEachInGrid(function(column:int, row:int, gid:int):void {
				var index:int = dataList[gid] - 1;
				if (index >= 0) tiles.setTile(column, row, index);
			});
		}
		
		private function forEachInGrid(function_:Function):void {
			var column:int,
				row:int,
				gid:int = 0;			
			
			for(row = 0; row < h; row ++) {
				for(column = 0; column < w; column ++) {
					function_(column, row, gid);
					gid++;
				}
			}
		}
		
		/**
		 * Returns true if tile is solid, false if not
		 */
		private function checkSolid(x:int, y:int):Boolean {
			for (var i:int = 0; i < notSolids.length; i++) {
				if (tiles.getTile(x, y) == notSolids[i]) return false;
			}
			
			return true;
		}		
				
	}
	
}