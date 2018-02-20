public class PauseMenu {  
  PImage resumebutton;
  public void display() {
    noStroke();
    resumebutton=loadImage("green_button05.png");
   fill(#9B0E1A); 
    rect(width*0.05, height*0.025, width/2-140, 80);
    rect(width*0.05, height*0.025 + 90, width/2-140, 80);
    rect(width*0.05, height*0.025 + 180, width/2-140, 80);
    rect(width*0.05, height*0.025 + 270, width/2-140, 80);
    rect(width*0.05, height*0.025 + 360, width/2-140, 80);
    rect(width*0.05, height*0.025 + 450, width/2-140, 80);
    
        if (player.displayEquipment.rageDaggerNumb > 0) {
          fill(#F9FA12);
          textSize(15);
          text("X " + player.displayEquipment.rageDaggerNumb, width*0.05 + 40, height*0.025 + 35);
          fill(255,255,255);
          textSize(10);
          text(player.displayEquipment.rageDaggerDescrip, width*0.05 + 80, height*0.025 + 25);
        }
        else {
          fill(#F9FA12);
          textSize(15);
          text("X 0", width*0.05 + 40, height*0.025 + 35);
          fill(255,255,255);
          textSize(15);
          text("??????", width*0.05 + 100, height*0.025 + 35);
        }
           
        if (player.displayEquipment.jewelOfEnergyNumb > 0) {
          fill(#F9FA12);
          textSize(15);
          text("X " + player.displayEquipment.jewelOfEnergyNumb, width*0.05 + 40, height*0.025 + 125);
          fill(255,255,255);
          textSize(10);
          text(player.displayEquipment.jewelOfEnergyDescrip, width*0.05 + 100, height*0.025 + 115);
        }
        else {
          fill(#F9FA12);
          textSize(15);
          text("X 0", width*0.05 + 40, height*0.025 + 125);
          fill(255,255,255);
          textSize(15);
          text("??????", width*0.05 + 100, height*0.025 + 125);
        }
        
        if (player.displayEquipment.quickSilverNumb > 0) {
          fill(#F9FA12);
          textSize(15);
          text("X " + player.displayEquipment.quickSilverNumb, width*0.05 + 40, height*0.025 + 215);
          fill(255,255,255);
          textSize(10);
          text(player.displayEquipment.quickSilverDescrip, width*0.05 + 100, height*0.025 + 205);
        }
        else {
           fill(#F9FA12);
           textSize(15);
           text("X 0", width*0.05 + 40, height*0.025 + 215);
           fill(255,255,255);
           textSize(15);
           text("??????", width*0.05 + 100, height*0.025 + 215);
         }
        if (player.displayEquipment.weaponCraftNumb > 0) {
          fill(#F9FA12);
          textSize(15);
          text("X " + player.displayEquipment.weaponCraftNumb, width*0.05 + 50, height*0.025 + 305);
          fill(255,255,255);
          textSize(10);
          text(player.displayEquipment.weaponCraftDescrip, width*0.05 + 100, height*0.025 + 295);
        }
        else {
           fill(#F9FA12);
            textSize(15);
           text("X 0", width*0.05 + 50, height*0.025 + 305);
           fill(255,255,255);
           textSize(15);
           text("??????", width*0.05 + 100, height*0.025 + 305);
        }
        if (player.displayEquipment.heartOfVitalityNumb > 0) {
          fill(#F9FA12);
          textSize(15);
          text("X " + player.displayEquipment.heartOfVitalityNumb, width*0.05 + 50, height*0.025 + 395);
          fill(255,255,255);
          textSize(10);
          text(player.displayEquipment.heartOfVitalityDescrip, width*0.05 + 100, height*0.025 + 385);
        }
        else {
          fill(#F9FA12);
          textSize(15);
          text("X 0", width*0.05 + 50, height*0.025 + 395);
          fill(255,255,255);
          textSize(15);
          text("??????", width*0.05 + 100, height*0.025 + 395);
        }
        
        if (player.displayEquipment.galeReburstNumb > 0) {
          fill(#F9FA12);
          textSize(15);
          text("X " + player.displayEquipment.galeReburstNumb, width*0.05 + 40, height*0.025 + 485);
          fill(255,255,255);
          textSize(10);
          text(player.displayEquipment.galeReburstDescrip, width*0.05 + 100, height*0.025 + 475);
        }
        else {
          fill(#F9FA12);
          textSize(15);
          text("X 0", width*0.05 + 40, height*0.025 + 485);
          fill(255,255,255);
          textSize(15);
          text("??????", width*0.05 + 100, height*0.025 + 485);
        }
    
    imageMode(CENTER);
    image(rageDaggerSprite, width*0.05 + 25, height*0.025 + 40);
    image(jewelOfEnergySprite, width*0.05 + 25, height*0.025 + 130);
    image(quickSilverSprite, width*0.05 + 25, height*0.025 + 220);
    image(weaponCraftSprite, width*0.05 + 25, height*0.025 + 310);
    image(heartOfVitalitySprite, width*0.05 + 25, height*0.025 + 400);
    image(galeReburstSprite, width*0.05 + 25, height*0.025 + 490);
  
    image(resumebutton,680,65);
    textSize(20); 
     text("Resume",640,72); 
     
     //Abilities
    if (player.secondary != "") {
     fill(255,255,255);
     textSize(30);
     text("SECONDARY", 500, 200);
     fill(#5F6CBC);
     ellipse(580, 300, 160, 160);
     image(playerSprite, 540, 300);
     if (player.secondary == "Shotgun") {
       fill(255,255,255);
       text("Shotgun", 500, 410);
       fill(#1AEDE8);
       textSize(15);
       text("Shoot multiple bullets in an\n instant", 450, 430);
       
       fill(0);
       ellipse(600, 270, 10, 10);
       ellipse(590, 290, 10, 10);
       ellipse(580, 310, 10, 10);
       ellipse(590, 330, 10, 10);
       ellipse(600, 350, 10, 10);
       
       if (player.augment == "Damage") {
      fill(#F05016);
      textSize(17);
      text("INCREASED DAMAGE", 450, 490);
    }
    else if (player.augment == "Stamina") {
      fill(#F05016);
      textSize(17);
      text("REDUCED STAMINA USAGE", 450, 490);
    }
    else if (player.augment == "Duration") {
      fill(#F05016);
      textSize(17);
      text("INCREASED ATTACK DURATION", 450, 490);
    }
     }
     else if (player.secondary == "Bomb") {
       fill(255,255,255);
       text("Bomb", 500, 410);
       fill(#1AEDE8);
       textSize(15);
       text("A magical ability to obliterate\n your foes with a fiery\n explosion", 450, 430);
       
       image(explosion6, 610, 300);
       
       if (player.augment == "Damage") {
      fill(#F05016);
      textSize(17);
      text("INCREASED DAMAGE", 450, 510);
      }
      else if (player.augment == "Stamina") {
        fill(#F05016);
        textSize(17);
        text("REDUCED STAMINA USAGE", 450, 510);
      }
      else if (player.augment == "Duration") {
        fill(#F05016);
        textSize(17);
        text("INCREASED ATTACK DURATION", 450, 510);
      }
     }
     else if (player.secondary == "Boomerang") {
       fill(255,255,255);
       text("Boomerang", 440, 410);
       fill(#1AEDE8);
       textSize(15);
       text("A lethal non-firearm that\n can travel long ranges and be\n thrown an infinite amount\n of times", 450, 430);
       
       image(knife, 600, 300);
       
         if (player.augment == "Damage") {
        fill(#F05016);
        textSize(17);
        text("INCREASED DAMAGE", 450, 530);
      }
      else if (player.augment == "Stamina") {
        fill(#F05016);
        textSize(17);
        text("REDUCED STAMINA USAGE", 450, 530);
      }
      else if (player.augment == "Duration") {
        fill(#F05016);
        textSize(17);
        text("INCREASED ATTACK DURATION", 450, 530);
      }
     }
    }
    else {
     fill(#5F6CBC);
     ellipse(580, 300, 160, 160);
     fill(255,255,255);
     textSize(30);
     text("???????", 540, 200);
    }
    
    if (player.passive != "") {
     fill(#ED801A);
     ellipse(780, 300, 160, 160);
     fill(255,255,255);
     textSize(30);
     text("PASSIVE", 740, 200);
     image(playerSprite, 740, 300);
     if (player.passive == "HealthRegen") {
       fill(255,255,255);
       text("Health Regen", 700, 410);
       fill(#1AEDE8);
       textSize(15);
       text("Regenerate health slowly", 710, 430);
       
       fill(#D30F15, 150);
       ellipse(740, 320, 15, 15);
       fill(#D30F15, 200);
       ellipse(730, 310, 15, 15);
       fill(#D30F15, 250);
       ellipse(750, 300, 15, 15);
       fill(#D30F15, 200);
       ellipse(720, 305, 15, 15);
       fill(#D30F15, 250);
       ellipse(725, 280, 15, 15);
       fill(#D30F15, 150);
       ellipse(745, 280, 15, 15);
       
       
     }
     else if (player.passive == "CriticalHit") {
       fill(255,255,255);
       text("Critical Hit", 700, 410);
       fill(#1AEDE8);
       textSize(15);
       text("Gain 1/3 chance of increasing\n the damage for each shot you\n make\n (PRIMARY WEAPON)", 710, 430);
       
       fill(0);
       ellipse(780, 310, 10, 10);
       ellipse(800, 310, 10, 10);
       fill(#FC4512);
       ellipse(820, 310, 10, 10);
     }
     else if (player.passive == "ReduceDamage") {
       fill(255,255,255);
       text("Reduce Damage", 700, 410);
       fill(#1AEDE8);
       textSize(15);
       text("Gain 1/4 chance of reducing\n the damage for each bullet you\n take", 710, 430);
       
       fill(#047DC6, 200);
       ellipse(735, 290, 25, 15);
       fill(0);
       ellipse(780, 250, 10, 10);
       ellipse(760, 270, 10, 10);
       ellipse(740, 290, 10, 10);
     }
    }
    else {
      fill(#ED801A);
     ellipse(780, 300, 160, 160);
     fill(255,255,255);
     textSize(30);
     text("???????", 740, 200);
    }
    
    
  }
}