//gmaeState
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int gameState = 0; 

//game
PImage title;
PImage gameover;
PImage startNormal;
PImage startHovered;
PImage restartNormal;
PImage restartHovered;
int ButtonX = 248;
int ButtonY = 360;
int ButtonW = 144;
int ButtonH = 60;

//base
PImage skyImg;
PImage soilImg;
int soil = 80;

//life
PImage lifeImg;
int lifeCount=2;

//life cabbage 
PImage cabbageImg;
int cabbageX = floor(random(8))*80;
int cabbageY = floor(random(4))*80+160;
int cW = 80; //cabbage width
int cH = 80; //cabbage height

//groundhog
PImage groundhogIdle;
PImage groundhogDown;
PImage groundhogLeft;
PImage groundhogRight;
int groundhogX = 320;
int groundhogY = 80;
int gW=80; //groundhog width
int gH=80; //groundhog height
int groundhogMoveY;
int groundhogMoveX;

//time
float nowTime;
float lastTime;

//boolean
boolean downPressed=false;
boolean leftPressed=false;
boolean rightPressed=false;

//soldier
PImage soldierImg;
int soldierX;
int soldierY;
int soldierSpeed;
int sW=80;//soldier width
int sH=80;//soldier height

void setup() {
  
  size(640, 480, P2D);
  
  skyImg=loadImage("img/bg.jpg"); 
  soilImg=loadImage("img/soil.png");
  lifeImg=loadImage("img/life.png");
  cabbageImg=loadImage("img/cabbage.png");
  
  //groundhog
  groundhogDown=loadImage("img/groundhogDown.png");
  groundhogIdle=loadImage("img/groundhogIdle.png");
  groundhogLeft=loadImage("img/groundhogLeft.png");
  groundhogRight=loadImage("img/groundhogRight.png");
 
  //soldier
  soldierImg=loadImage("img/soldier.png");
  soldierX=-80;
  soldierY=160+floor(random(4))*80;
  soldierSpeed=2;
  
  //game
  title=loadImage("img/title.jpg");
  gameover=loadImage("img/gameover.jpg");
  startNormal=loadImage("img/startNormal.png");
  startHovered=loadImage("img/startHovered.png");
  restartNormal=loadImage("img/restartNormal.png");
  restartHovered=loadImage("img/restartHovered.png");

}


void draw() {
 switch(gameState){   
  case GAME_START:
   
   image(title,0,0);
   image(startNormal,ButtonX,ButtonY);
   if(mouseX >= ButtonX && mouseX <= ButtonX+ButtonW){
     if(mouseY >= ButtonY && mouseY <= ButtonY+ButtonH){
       image(startHovered,ButtonX,ButtonY);
       if(mousePressed){
         gameState = GAME_RUN;
       }
      }
    }
   break;
   
   
  case GAME_RUN:
     
     image(skyImg,0,0); //sky
     image(soilImg,0,160); //ground
     image(cabbageImg,cabbageX,cabbageY); //cabbage
     
     if(groundhogX+gW > cabbageX && groundhogX < cabbageX+cW){
        if(groundhogY+gH > cabbageY && groundhogY < cabbageY+cH ){ 
          cabbageX=-80;
          cabbageY=-80;
          lifeCount+=1;
        }
     }
     
     //heart
     if(lifeCount==3){
       image(lifeImg,10,10); //1heart
       image(lifeImg,80,10); //2heart
       image(lifeImg,150,10); //3heart
     }
     if(lifeCount==2){
       image(lifeImg,10,10); //1heart
       image(lifeImg,80,10); //2heart
     }
     if(lifeCount==1){
       image(lifeImg,10,10); //1heart
     }
     
        
     //grass
     fill(124,204,25);
     noStroke();
     rect(0,145,640,15);
    
     //sun
     stroke(255,255,0);
     strokeWeight(5);
     fill(253,184,19);
     ellipse(590,50,120,120);
    
    //groundhog side
     if(groundhogX <= 0){
       groundhogX=0;
     }
     if(groundhogX >= width-80){
       groundhogX=width-80;
     }
     if(groundhogY > height-80){
       groundhogY=height-80;
     }
     
     //groundhog moving
     if(downPressed){
       if( groundhogMoveY <= groundhogY ){
         groundhogMoveY+=80/15.0;
         image(groundhogDown,groundhogX,groundhogMoveY);
         nowTime = millis();
       }else{
         downPressed = false;
       }
     }
     else if(leftPressed){
       if( groundhogMoveX>=groundhogX ){
         groundhogMoveX-=80/15.0;
         image(groundhogLeft,groundhogMoveX,groundhogY);
         
       }else{
         leftPressed = false;
       }
     }
     else if(rightPressed){
       if( groundhogMoveX<=groundhogX ){
         groundhogMoveX+=80/15.0;
         image(groundhogRight,groundhogMoveX,groundhogY);
       } else{
          rightPressed = false;
       }
     }
     else{
       image(groundhogIdle,groundhogX,groundhogY);
     }
     
      //soldier
     image(soldierImg,soldierX,soldierY); 
     soldierX+=soldierSpeed;
        if(soldierX == width){
         soldierX=-80;
         soldierX+=soldierSpeed;
        } 
     
     //when game lose
     if(groundhogX+gW > soldierX && groundhogX < soldierX+sW){
        if(groundhogY+gH > soldierY && groundhogY < soldierY+sH ){ 
          groundhogX = 320;
          groundhogY = 80;
          lifeCount-=1;
          if(lifeCount==0){
            gameState = GAME_LOSE;
          }
        }
     }
   break;
       
       
       
   case GAME_LOSE:
   downPressed=false;
   leftPressed=false;
   rightPressed=false;
   lifeCount=2;
   cabbageX = floor(random(8))*80;
   cabbageY = floor(random(4))*80+160;
   image(gameover,0,0);
   image(restartNormal,ButtonX,ButtonY);
   if(mouseX >= ButtonX && mouseX <= ButtonX+ButtonW){
     if(mouseY >= ButtonY && mouseY <= ButtonY+ButtonH){
       image(restartHovered,ButtonX,ButtonY);
       if(mousePressed){
         gameState = GAME_RUN;
       }
      }
    }
   break; 
  }
}

void keyPressed(){
  nowTime = millis(); 
  if(key==CODED){
    switch(keyCode){
      case DOWN:
      if(nowTime - lastTime > 250){
         downPressed=true;
         groundhogMoveY = groundhogY; //start position
         groundhogY += soil;
         lastTime = millis();
         
       }
      break;
      
      case LEFT:
      if(nowTime - lastTime > 250){
         groundhogMoveX = groundhogX; 
         groundhogX -= soil;
         leftPressed=true;
         lastTime = millis();
        
      }
      break;
      
      case RIGHT:
      if(nowTime - lastTime > 250){
         groundhogMoveX = groundhogX;
         rightPressed = true;
         groundhogX += soil;
         lastTime = millis();
         
      }     
      break;
    }
 }
}


void keyReleased(){
  if(key==CODED){
    switch(keyCode){
      case DOWN:
      downPressed=false;
      break;
      
      case LEFT:
      leftPressed=false;
      break;
      
      case RIGHT:
      rightPressed=false;
      break;
     }
 }
 
}
