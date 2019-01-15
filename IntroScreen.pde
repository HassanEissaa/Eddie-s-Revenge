public class IntroScreen {
  
  public void displayIntro() {
  background(0);
  fill(#CB5F17);
  rect(300, 100, 400, 200);
  
  line(300, 140, 700, 140); //Top Line
  line(300, 260, 700, 260); //Bottom Line
  line(360, 100, 360, 300); //Left Line
  line(640, 100, 640, 300); //Right Line
  
  fill(#B7040A);
  rect(width/2-160, 108, 25, 25); //Upper left
  rect(width/2 + 180, 108, 25, 25); //Upper right
  rect(width/2-160, 268, 25, 25); //Lower left
  rect(width/2+180, 268, 25, 25); //Lower right
  
  fill(#FFD605);
  textSize(30);
  text("EDDIE'S", width/2-40, 190);
  text("REVENGE", width/2-40, 230);
  
  fill(255,255,255);
  textSize(40);
  text("PRESS ENTER", width/2-100, 400);
}
}