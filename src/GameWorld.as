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
 * Created by joe on 15/12/2013.
 */
package {
    import net.flashpunk.FP;
    import net.flashpunk.World;

    public class GameWorld extends World {

        public function GameWorld() {
            // Spawn player and set up world
            add(new Player(100, 100));
        }


        private var frames:int = 0;
        override public function update():void {
            // Spawn enemies randomly
            if (frames > 200) {
                var choice:int = FP.rand(3);

                trace(choice);

                switch (choice) {
                    case 0:
                        add(new FollowingEnemy(-300, 200));
                        break;
                    case 1:
                        add(new FollowingEnemy(200, -300));
                        break;
                    case 2:
                        add(new FollowingEnemy(900, 200));
                        break;
                    case 4:
                        add(new FollowingEnemy(200, 600));
                        break;
                }

                frames = 0;
            }


            frames++;

            super.update();
        }
    }
}
