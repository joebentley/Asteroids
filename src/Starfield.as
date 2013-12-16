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

    public class Starfield {

        public function Starfield() {

        }

        private var frame:int = 0;

        public function update():void {

            if (frame > 10) {
                // Generate random number for scale (and speed), but bias for more smaller stars
                var rand:Number = Math.random();
                var scale:int;

                // More chance for smaller stars
                if (rand < 0.7) {
                    scale = 1;
                } else if (rand < 0.9) {
                    scale = 2;
                } else {
                    scale = 3;
                }

                // Generate a star in random position, use scale for speed as
                // we want distant stars to appear to travel slower and vice versa
                FP.world.add(new Star(FP.rand(FP.screen.width), -100, scale, scale));

                // Reset frame counter
                frame = 0;
            }

            frame++;
        }
    }
}
