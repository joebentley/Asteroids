/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2013 Joe Bentley
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

/**
 * Created by joe on 16/12/2013.
 */
package {
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;


    public class FollowingEnemy extends Enemy {
        [Embed(source="../assets/enemy.png")] private const ENEMY:Class;

        private var image:Image;

        private var angle:Number = 0;
        private var speed:int = 2;


        public function FollowingEnemy(_x:int, _y:int) {
            // Generate image and attach to entity
            image = new Image(ENEMY);
            image.scale = 4 ;

            image.centerOrigin();

            graphic = image;


            // Center hitbox on object
            setHitbox(image.scaledWidth, image.scaledHeight, image.scaledWidth/2, image.scaledHeight/2);

            super(_x, _y);
        }


        override public function update():void {
            // Get player and move towards them
            var player:Array = new Array();

            FP.world.getType("player", player);

            // Find angle between player and enemy
            angle = Math.atan2(player[0].y - y, player[0].x - x);

            // Move towards player
            x += Math.cos(angle) * speed;
            y += Math.sin(angle) * speed;


            // Update image sprite
            image.angle = FP.DEG * angle - 90;


            super.update();
        }
    }
}
