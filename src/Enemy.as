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
    import net.flashpunk.Sfx;

    public class Enemy extends Entity {
        [Embed(source="../assets/kill.mp3")] private const SFX_DEATH:Class;


        private var sfxKill:Sfx;


        public function Enemy(_x:int, _y:int) {
            // Set initial position
            x = _x;
            y = _y;


            sfxKill = new Sfx(SFX_DEATH);


            // Set up collision type
            type = "enemy";
        }


        override public function update():void {
            // Check collision with bullets
            var b:Entity = collide("bullet", x, y);
            if (b) {
                FP.world.remove(this);
                FP.world.remove(b);
                sfxKill.play();

                FP.world.screenFlash = true;
            }



            super.update();
        }
    }
}
