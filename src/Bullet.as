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
    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.graphics.Image;

    public class Bullet extends Entity {
        [Embed(source="../assets/bullet.png")] private const BULLET:Class;

        private var image:Image;

        private var angle:Number; // Direction to travel in
        private var speed:int = 10; // Speed of motion of the bullet

        // True if enemy bullet
        public var enemy:Boolean;

        public function Bullet(_x:int, _y:int, _angle:Number, _enemy:Boolean) {
            // Set initial position
            x = _x;
            y = _y;

            // Set up image and attach to entity
            image = new Image(BULLET);
            image.scale = 4;

            graphic = image;

            // Set angle to move in
            angle = _angle;

            // Set up collision and center on object
            type = "bullet";
            setHitbox(image.scaledWidth, image.scaledHeight, image.scaledWidth/2, image.scaledHeight/2);

            enemy = _enemy;
        }

        override public function update():void {
            // Move bullet along direction
            x += Math.cos(angle) * speed;
            y += Math.sin(angle) * speed;

            // Update image rotation
            image.angle = FP.DEG * angle - 90;


            // Remove this if off screen (i.e. not colliding with screen)
            if (!collideRect(x, y, 0, 0, FP.screen.width, FP.screen.height)) {
                FP.world.remove(this);
            }


            super.update();
        }
    }
}
