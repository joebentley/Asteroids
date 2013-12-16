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
    import net.flashpunk.Graphic;
    import net.flashpunk.Mask;
    import net.flashpunk.graphics.Image;

    public class Star extends Entity {
        [Embed(source="../assets/pixel.png")] private const STAR:Class;


        private var speed:int;

        private var image:Image = new Image(STAR);

        public function Star(_x:int, _y:int, _scale:int, _speed:int) {
            // Set initial position
            x = _x;
            y = _y;


            // Set up player graphic and scaling
            image.scale = _scale;

            graphic = image;

            layer = 100;

            speed = _speed;
        }


        private var frame:int = 0;
        override public function update():void {
            // Move down screen with constant speed
            y += speed;

            // Twinkle distant stars every few frames
            if (image.scale == 1 && frame > FP.rand(5)) {
                image.color = FP.rand(0xFFFFFF);

                frame = 0;
            }

            // Remove when off screen
            if (y > FP.screen.height) {
                FP.world.remove(this);
            }

            frame++;
        }
    }
}
