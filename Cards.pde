public class Cards { 
 float cardWidth;
 float cardHeight;
 float x1, x2, x3;
 float y1, y2, y3;
 int currentFloor;
 boolean dissappear;
 int cardSelected;
   
   Cards(int curr ){
     currentFloor = curr;
     dissappear = false;
      cardWidth = 100;
      cardHeight = 100;
      x1 = 200;
      x2 = 400;
      x3 = 600;
      y1 = 100;
      y2 = 100;
      y3 = 100;
   }
   
   public void display() {
     if (!dissappear) {
       if (currentFloor == 0) {
        fill(#F5F2F2);
        rect(x1,y1,cardWidth,cardHeight);
        rect(x2,y2,cardWidth,cardHeight);
        rect(x3,y3,cardWidth,cardHeight);
        imageMode(CENTER);
        image(explosion6, 250, 150);
        image(knife, 450, 150, 125, 125);
        image(shotgunSprite, 650, 150, 125, 125);
        fill(0);
        text("BOMB", 230, 185);
        text("BOOMERANG", 430, 185);
        text("SHOTGUN", 635, 185);
        
       }
       else if (currentFloor == 1) {
         fill(#F5F2F2);
        rect(x1,y1,cardWidth,cardHeight);
        rect(x2,y2,cardWidth,cardHeight);
        rect(x3,y3,cardWidth,cardHeight);
        
        fill(#D30F15, 200);
         ellipse(250, 150, 50, 50);
         fill(#D30F15, 150);
         ellipse(240, 130, 40, 40);
         fill(#D30F15, 100);
         ellipse(260, 160, 30, 30);
        
         fill(#047DC6, 200);
         ellipse(450, 150, 35, 70);
         
         fill(#FC4512);
         ellipse(650, 150, 40, 40);
         
         fill(0);
        text("HEALTH REGEN", 230, 185);
        text("REDUCE DAMAGE", 430, 185);
        text("CRITICAL DAMAGE", 635, 185);
       }
       else if (currentFloor == 2) {
          fill(255, 255, 255);
        rect(x1,y1,cardWidth,cardHeight);
        rect(x2,y2,cardWidth,cardHeight);
        rect(x3,y3,cardWidth,cardHeight);
        
        fill(0);
        rect(240, 110, 20, 80);
        rect(210, 140, 80, 20);
        
        fill(255,247,0);
        rect(440, 110, 20, 80);
        rect(410, 140, 80, 20);
        
        fill(#F2D7D7);
        rect(640, 110, 20, 80);
        rect(610, 140, 80, 20);
        
        fill(0);
        text("DAMAGE +", 230, 185);
        text("STAMINA USAGE -", 430, 185);
        text("DURATION +", 635, 185);
       }
      }
   }
   
   public void use() {
  if (currentFloor == 0) {   
     if (cardSelected == 1)
          player.secondary = "Bomb";
        else if (cardSelected == 2)  
          player.secondary = "Boomerang";
        
        else if (cardSelected == 3)
          player.secondary = "Shotgun";
   }
  
  else if (currentFloor == 1) {
    if (cardSelected == 1)
          player.passive = "HealthRegen";
        else if (cardSelected == 2)  
          player.passive = "ReduceDamage";
        else if (cardSelected == 3)
          player.passive = "CriticalHit";
  }
  
  else if (currentFloor == 2) {
    if (cardSelected == 1)
          player.augment = "Damage";
        else if (cardSelected == 2)  
          player.augment = "Stamina";
        else if (cardSelected == 3)
          player.augment = "Duration";
  }
}
}