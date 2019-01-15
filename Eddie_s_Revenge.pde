import ddf.minim.*;
Minim minim;
PImage blocking, open1, open2, open3, open4, wall, playerSprite, knife, shotgunSprite,
       enemy1, enemyBomb, enemyMachineGun, enemyShotgun, enemySniper, enemyGrenade, boss, finalBoss,
       explosion1, explosion2, explosion3, explosion4, explosion5, explosion6, explosion7, explosion8,
       motif1, motif2, motif3, motif4, motif5, motif6, motif7, motif8, motif9, motif10,
       arrowl, arrowr, arrowu, arrowd,
       healthPotionSprite, staminaPotionSprite,
       rageDaggerSprite, quickSilverSprite, jewelOfEnergySprite, heartOfVitalitySprite, weaponCraftSprite, galeReburstSprite;
AudioPlayer file;
Player player;
Game game;
Cards cards;
ArrayList<Enemy> enemyList;
PImage[] motifList;
ArrayList<Bullet> bulletList;
ArrayList<SecondaryAbility> secondaryList;
PImage[] explosionSpriteList;
PImage[] openTileList;

AudioPlayer[] backgroundsongs;
AudioPlayer pistol,shotgun,song1,song2,song3,song4, boomerang, explosion;
int currentSong;
AudioInput input;

PauseMenu pauseMenu;
IntroScreen introScreen;
boolean pauseScreen;
boolean dialouge;
boolean displayCards;
boolean pickedCard;
boolean dialouge2;
boolean intro;
boolean ending;

public void setup() {
  size(960, 640);
  blocking = loadImage("tile_35.png"); wall = loadImage("tile_180.png");
  open1 = loadImage("tile_43.png"); open2 = loadImage("tile_11.png"); open3 = loadImage("tile_12.png"); open4 = loadImage("tile_73.png"); 
  playerSprite = loadImage("player.png"); knife = loadImage("tile_241.png");
  enemy1 = loadImage("enemyBlue.png"); enemyBomb = loadImage("bomber.png"); enemyMachineGun = loadImage("survivor1_machine.png"); enemyShotgun = loadImage("shotgun.png"); 
  enemySniper = loadImage("sniper.png"); enemyGrenade = loadImage("grenadier.png"); boss = loadImage("bigboss.png"); finalBoss = loadImage("robot1_gun.png");
  explosion1 = loadImage("explosion1.png"); explosion2 = loadImage("explosion2.png"); explosion3 = loadImage("explosion3.png"); explosion4 = loadImage("explosion4.png");
  explosion5 = loadImage("explosion5.png"); explosion6 = loadImage("explosion6.png"); explosion7 = loadImage("explosion7.png"); explosion8 = loadImage("explosion8.png");
  motif1 = loadImage("tile_134.png"); motif2 = loadImage("tile_240.png"); motif3 = loadImage("tile_133.png"); motif4 = loadImage("tile_132.png"); motif5 = loadImage("tile_242.png");
  motif6 = loadImage("tile_156.png"); motif7 = loadImage("tile_157.png"); motif8 = loadImage("tile_477.png"); motif9 = loadImage("tile_478.png"); motif10 = loadImage("tile_479.png");
  arrowl = loadImage("arrowl.png"); arrowr = loadImage("arrowr.png"); arrowu = loadImage("arrowu.png"); arrowd = loadImage("arrowd.png");
  healthPotionSprite = loadImage("potionRed.png"); staminaPotionSprite = loadImage("potionGreen.png");
  rageDaggerSprite = loadImage("sword.png"); quickSilverSprite = loadImage("potionBlue.png"); jewelOfEnergySprite = loadImage("gemBlue.png"); heartOfVitalitySprite = loadImage("heart.png"); weaponCraftSprite = loadImage("tools.png");
  galeReburstSprite = loadImage("wand.png");
  shotgunSprite = loadImage("ShotgunSprite.png");

  motifList = new PImage[] { motif1, motif2, motif3, motif4, motif5, motif6, motif7, motif8, motif9, motif10 };
  player = new Player();
  bulletList = new ArrayList<Bullet>(); enemyList = new ArrayList<Enemy>();secondaryList = new ArrayList<SecondaryAbility>();
  explosionSpriteList = new PImage[] {explosion1, explosion2, explosion3, explosion4, explosion5, explosion6, explosion7, explosion8};
  openTileList =  new PImage[] { open1, open2, open3, open4 };
  smooth(8);
  game = new Game();
  minim = new Minim(this);
  pauseMenu = new PauseMenu();
  introScreen = new IntroScreen();
  pauseScreen = false;
  dialouge = true;
  displayCards = false;
  pickedCard = false;
  dialouge2 = true;
  intro = true;
  ending = false;
  
  //Audio
  minim = new Minim(this);
  backgroundsongs = new AudioPlayer[4];
  pistol = minim.loadFile("gunfire.mp3");
  shotgun = minim.loadFile("shotgun.mp3");
  boomerang = minim.loadFile("Boomerang Toss-SoundBible.com-704468067.mp3");
  explosion = minim.loadFile("Explosion_Ultra_Bass-Mark_DiAngelo-1810420658.mp3");
  backgroundsongs[0] = minim.loadFile("Traveler.wav");
  backgroundsongs[1] = minim.loadFile("Arcade Funk.mp3");
  backgroundsongs[2] = minim.loadFile("Platformer2.mp3");
  backgroundsongs[3] = minim.loadFile("monkey.wav");
  input = minim.getLineIn();
  currentSong = 0;
  backgroundsongs[currentSong].loop();  
  backgroundsongs[currentSong].setGain(-10);
}

public void draw() {
  if (intro) {
    introScreen.displayIntro();
  }
  
 else { 
 if (dialouge) {
     game.display();///////
    if (game.getCurrentFloorIndex() == 0) {
      pickedCard = false;
       noStroke();
      game.currentMessage = "I've entered the building and I'm on the first floor. Heh, I can't wait. I can see it already and\n I'm not even there yet" + 
      " to rip your fragile body in half. But Deja Vu all over again. Funny how\n I used to be a weapons specialist here and I regret every single moment of it now." + 
      " It sets\n me off every time I think about those years, but enough talking because right now I can\n taste my revenge.";
      
      fill(#F5F06A);
      rect(width- 900, height -150, 700, 140);
     fill(0);
     textSize(15);
     text(game.currentMessage, 80, 520);
    }
    else if (game.getCurrentFloorIndex() == 1) {
      pickedCard = false;
       noStroke();
      game.currentMessage = "Didn't expect that lowlife to be a hassle, but in the end he was nothing like always.\n Whatever. Nothing can stop me. I'm on the second floor now. The weak shall never\n " + 
    "bring me down, especially not these greedy pigs. Nothing will prevent me getting\n my revenge and these maggots won't leech that away from me.";
      fill(#F5F06A);
      rect(width- 900, height -200, 650, 150);
     fill(0);
     textSize(15);
     text(game.currentMessage, 80, 475);
    }
    else if (game.getCurrentFloorIndex() == 2) {
      pickedCard = false;
       noStroke();
      game.currentMessage = "Aha c'mon is that all? Pathetic. Nothing has ever changed. This building was always trash.\n Third floor better" + 
      " not dissapoint me or else all of you are getting brutally killed! Because the\n more I stay in this" +
      " wreteched building, the more I want to throw up. I can't believe I worked\n for this company all those years AND for him. This organization needs to end and I'll be the\n one to do it.";
      fill(#F5F06A);
      rect(width- 900, height -200, 700, 150);
     fill(0);
     textSize(15);
     text(game.currentMessage, 76, 475);
    }
    else if (game.getCurrentFloorIndex() == 3) {
      pickedCard = false;
       noStroke();
      game.currentMessage = "At last I'm on his floor. Everything is almost in it's rightful place and I just need his head by\n my feet for it to happen. I came this far and I won't let anything I've done die " +
      " vain.\n Master.... Or should I say monster. Yeah... that's right. Monster. You really are a monster.\n Making all these weapons not for the sake of protecting our country, but for your selfish\n ambitions." +
      "You don't care about us at all and you only manipulate your underlings. It's only about\n yourself you worthless pig! I'm done. Time to end this. Your fate is near.";
      fill(#F5F06A);
      rect(width- 900, height -180, 770, 165);
     fill(0);
     textSize(15);
     text(game.currentMessage, 80, 490);
    }///////
  }
  ///////
  else if (dialouge2 && game.getCurrentFloor().getCurrentRoom() instanceof BossRoom) {
      game.display();
        if (game.getCurrentFloorIndex() == 0) {
          noStroke();
          game.currentMessage = "What a familar face..... Didn't expect to see you here at these times Mr. weapon specialist\n loudmouth. You betrayed us for a good cause Eddy. " +
          "I fear you were going to become\n a threat to us because turns out you were one of those weak and soft-hearted vermins, so\n I must eliminate you. Get ready, 1st rank. Or shall I say, former 1st rank."
          + " You never\n were a part of us. Now die.";
            fill(#F24040);
            rect(width- 900, height -200, 700, 150);
           fill(0);
           textSize(15);
           text(game.currentMessage, 80, 470);
        }
        else if (game.getCurrentFloorIndex() == 1) {
          noStroke();
          game.currentMessage = "I guess David couldn't do it huh? I mean he was 4th in rank after all and plus, your\n experience as a 1st rank is still prominent from before so it's no big deal. " +
          "But you're still no\n match for me, I may have been lower than you but I feel I have the most skill in special\n weaponry than everyone else! The more profit we gain, the stronger I can become and\n " +
           "ascend through the rankings. But now since you left, you've been plummeting our\n company's success down ever since and now you shall pay. Prepare yourself Eddy.";
            fill(#F24040);
            rect(width- 900, height -200, 700, 170);
           fill(0);
           textSize(15);
           text(game.currentMessage, 80, 470);
       }
       else if (game.getCurrentFloorIndex() == 2) {
          noStroke();
          game.currentMessage = "Wow, both Spencer and David. Yeah, for someone as weak as David and arrogant as\n Spencer. You really want our buisness to go down kid? Well I'm sorry I can't let you do that.\n" +
          " You are blinded by your own foolishness, he gave you all that everyone can wish for but\n you decided to not take it, leave us afterwards then come back and want to kill us all." +
          " Pretty\n sad, you had so much potential and now you're turning on us. Well, I got no choice but to\n eliminate you Eddy. I can't let you reach him and I know that's who you want.";
            fill(#F24040);
            rect(width- 900, height -200, 700, 170);
           fill(0);
           textSize(15);
           text(game.currentMessage, 80, 470);
       }
       else if (game.getCurrentFloorIndex() == 3) {
          noStroke();
          game.currentMessage = "You went through all of my men. I see....... Ever since I saw that cheap load of nonsense\n called justice in your eyes, I figured it was you who'd be coming to cut my head off. " + 
          "From\n those striking eyes of yours, I thought it can be something useful for us and not only me.\n But I was afraid the worst would come and you were blinded by it and I'm sure my other\n employees " +
          "realized it too. When young people like you begin to garner that attribute,\n it can be really dangerous to continue keeping people like that under my wing. But you\n were my best person in charge and " +
          "I believed in your potential. I made you strong and\n successful and I was actually proud of it, and now you're the opposite. You've become\n a huge threat to my company... It's sad things have to be this way. " + 
          "But I must fufill my role\n as the founding leader of this organization and take down anyone who tries to go against\n us. This is goodbye Eddie...... Farewell my beloved student.";
            fill(#F24040);
            rect(width- 900, height -300, 700, 290);
           fill(0);
           textSize(15);
           text(game.currentMessage, 80, 370);
       }
  }/////
    
    
  else {
    if (!pauseScreen) {
      game.display();
      if (game.getCurrentFloor().getCurrentRoom() instanceof BossRoom) {
        if (enemyList.size() == 0 &&!pickedCard) {
          displayCards = true;
        }
      }
      if (displayCards) {
        cards = new Cards(game.getCurrentFloorIndex());
        cards.display();
      }
      
      
        
      //Display
      player.display();
      for (int i = 0; i < bulletList.size(); i++) {
        bulletList.get(i).display();
      }
      for (int i = 0; i < enemyList.size(); i++) {
        enemyList.get(i).display();
      }
      for (int i = 0; i < secondaryList.size(); i++) {
        secondaryList.get(i).display();
      }
  
      //Update
      player.update();
      game.update();
      for (int i = 0; i < bulletList.size(); i++) {
        bulletList.get(i).update();
        if (bulletList.get(i).getDead()) {
          bulletList.remove(i);
        }
      }
      for (int i = 0; i < enemyList.size(); i++) {
        enemyList.get(i).update();
        
        if (enemyList.get(i).getDead()) {
          enemyList.remove(i);
        }

      }
      for (int i = 0; i < secondaryList.size(); i++) {
        secondaryList.get(i).update();
        if (secondaryList.get(i).getDead()) {
          secondaryList.remove(i);
        }
      }
    }
    else { //pause
      background(0);
      pauseMenu.display();
      //Prevents automatic moving or run when moving at the same time beforehand and accessing the pause menu
      player.movingLeft = false;
      player.movingRight = false;
      player.movingUp = false;
      player.movingDown = false;
      player.isRunning = false;
    }
  }
 }
 
 if (game.getCurrentFloorIndex() ==3) {
    if (enemyList.size() == 0) {
      if (game.getCurrentFloor().getCurrentRoom() instanceof BossRoom) {
        background(0);
     fill(#F5EE11);
     textSize(50);
     text("YOU GOT YOUR REVENGE!!!", width/2-350, height/2);
      }
  }
   
 }
}

void keyPressed() {
  if (game.getCurrentFloorIndex() ==3) {
    if (enemyList.size() == 0) {
      if (game.getCurrentFloor().getCurrentRoom() instanceof BossRoom) {
        ending = true;
      }
    }
  }
  if (intro) {
     if (keyCode == ENTER)
       intro = false;
  }
  
 else if (dialouge) {
   if (keyCode == ENTER) {
     dialouge = false;
   }
  }
  
  else if (dialouge2 && game.getCurrentFloor().getCurrentRoom() instanceof BossRoom) {
     if (keyCode == ENTER)
     dialouge2 = false;
  }
  
  else if (!player.getDead()) {
    if (keyCode == TAB) {
       pauseScreen =! pauseScreen;
    }
  }
 if (!pauseScreen) {
  player.setMove(keyCode, true);
  player.setMove2(keyCode);
  /*
  if (keyCode == ENTER) {
    if(game.getCurrentFloor().isFinalRoom() && enemyList.size() == 0 && !displayCards) {
      game.nextFloor();
    }
  }
  */
 }
}
void keyReleased() {
  if (!pauseScreen) {
    if (!player.getDead()) {
      player.setMove(keyCode, false);
    }
  }
}
void mousePressed() {
  
 if (!dialouge) { 
 if (!pauseScreen) {
  if (!player.getDead()) {
    
     if (displayCards) {
      if(mouseButton == LEFT){
       
        if(mouseX>=cards.x1 && mouseX<=cards.x1 + cards.cardWidth && mouseY>=cards.y1 && mouseY<=cards.cardHeight + cards.y1  ){
        cards.cardSelected=1;
        cards.use();
        cards.dissappear = true;
        displayCards = false;
        pickedCard = true;
        game.getCurrentFloor().getCurrentRoom().setLeftExit(true);
        }
        else if(mouseX>=cards.x2 && mouseX<=cards.x2 + cards.cardWidth && mouseY>=cards.y2 && mouseY <= cards.cardHeight + cards.y2  ){
          cards.cardSelected=2; 
          cards.use();
          cards.dissappear = true;
           displayCards = false;
           pickedCard = true;
           game.getCurrentFloor().getCurrentRoom().setLeftExit(true);
        }
        else if(mouseX>=cards.x3 && mouseX<=cards.x3 + cards.cardWidth && mouseY>=cards.y3 && mouseY<= cards.y3 + cards.cardHeight){
          cards.cardSelected=3;  
          cards.use();
          cards.dissappear = true;
           displayCards = false;
           pickedCard = true;
           game.getCurrentFloor().getCurrentRoom().setLeftExit(true);
        } 
      }
    }
    else {
      if (mouseButton == LEFT && player.canShoot) {
        //Added to make the fire rate work for the player
        player.shootingTimer = millis();
        player.isShooting = true;
        pistol.loop(0);
        bulletList.add(new FriendlyBullet(player.getAngle() + (random(-1, 1)/10)));
        if (player.passive == "CriticalHit") { //If player has critical hit ability
          CriticalHit criticalHit = new CriticalHit();
          criticalHit.update();
        }
      }
    
      if (mouseButton == RIGHT) {
        player.useSecondary();
      }
    }
  }
 }
 else {
   //Click on the Resume button to go out of the pause screen
   if ((mouseX >= 586 && mouseX <= 772) && (mouseY >= 44 && mouseY <= 84)) {
     pauseScreen = false;
   }
 }
 }
 else { //Prevents the player to shoot when you click on the screen firsthand after going through
  //the dialouge
 }
   
}