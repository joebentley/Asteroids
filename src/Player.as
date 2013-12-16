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

    import net.flashpunk.Entity;
    import net.flashpunk.FP;
    import net.flashpunk.Sfx;
    import net.flashpunk.graphics.Image;
    import net.flashpunk.tweens.sound.SfxFader;
    import net.flashpunk.utils.Input;
    import net.flashpunk.utils.Key;


    public class Player extends Entity {
        [Embed(source="../assets/player.png")] private const PLAYER:Class;
        [Embed(source="../assets/thrust.mp3")] private const SFX_THRUST:Class;
        [Embed(source="../assets/shot.mp3")] private const SFX_SHOT:Class;


        private var acceleration:Number = 0.4;
        private var angle:Number = 0;
        private var maxVelocity:Vector2D;
        public var velocity:Vector2D;

        private var image:Image;

        private var fader:SfxFader;

        private var sfxShot:Sfx;

        public function Player(_x:int, _y:int) {
            // Set initial position
            x = _x;
            y = _y;


            // Set up player graphic and scaling
            image = new Image(PLAYER);
            image.scale = 4;

            // Set origin to center for rotation
            image.centerOrigin();

            graphic = image;


            // We use the SfxFader to fade to zero when finished thrusting
            var sfxThrust:Sfx = new Sfx(SFX_THRUST);
            fader = new SfxFader(sfxThrust);
            addTween(fader);

            // Start sound playing at zero volume, we just adjust the volume when we want to
            sfxThrust.loop(0);

            sfxShot = new Sfx(SFX_SHOT);


            // Set velocity and maxVelocity
            velocity = new Vector2D();

            maxVelocity = new Vector2D();
            maxVelocity.x = 10;
            maxVelocity.y = 10;


            // Set up collision and center on object
            type = "player";
            setHitbox(image.scaledWidth, image.scaledHeight, image.scaledWidth/2, image.scaledHeight/2);


            // Define our inputs
            Input.define("Thrust", Key.UP, Key.W);
            Input.define("Brake", Key.DOWN, Key.S);
            Input.define("Left", Key.LEFT, Key.A);
            Input.define("Right", Key.RIGHT, Key.D);
            Input.define("Shoot", Key.SPACE, Key.Z);
        }


        override public function update():void {

            // Thrust in facing direction
            if (Input.check("Thrust")) {
                // Only move if not already moving at maxVelocity
                if (Math.abs(velocity.x) < maxVelocity.x) {
                    velocity.x += Math.cos(angle) * acceleration;
                }

                if (Math.abs(velocity.y) < maxVelocity.y) {
                    velocity.y += Math.sin(angle) * acceleration;
                }
            }

            // Handle turning
            if (Input.check("Left")) {
                angle -= 0.1;
            }
            if (Input.check("Right")) {
                angle += 0.1;
            }


            // Thrust in reverse of movement direction
            if (Input.check("Brake")) {
                velocity.x -= velocity.x * 0.1;
                velocity.y -= velocity.y * 0.1;
            }

            // Apply friction gradually (slower than braking)
            velocity.x -= velocity.x * 0.03;
            velocity.y -= velocity.y * 0.03;


            // Bounce off walls
            if (((x + velocity.x) > FP.screen.width) || ((x + velocity.x) < 0)) {
                velocity.x = -velocity.x;
            }

            if (((y + velocity.y) > FP.screen.height) || ((y + velocity.y) < 0)) {
                velocity.y = -velocity.y;
            }


            // Fire bullet
            if (Input.pressed("Shoot")) {
                sfxShot.play();
                FP.world.add(new Bullet(x, y, angle, false));
            }


            // Play boost sound on thrust press
            if (Input.pressed("Thrust")) {
                // Fade to max volume
                fader.fadeTo(8, 0.2);
            }
            // Stop when not thrusting
            if (Input.released("Thrust")) {
                // Fade to zero volume
                fader.fadeTo(0, 0.5);
            }


            // Update position of entity
            x += velocity.x;
            y += velocity.y;


            // Update graphic with angle
            image.angle = FP.DEG * angle - 90;

            super.update();
        }
    }
}
