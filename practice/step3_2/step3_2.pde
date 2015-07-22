PImage shipImg; //画像を格納する変数
int shipX;
int shipY;

// 初期化
void setup() {
  size(480, 640);
  imageMode(CENTER);

  shipImg = loadImage("ship.png");
  shipX = 240;
  shipY = 550;
  
}

// 繰り返し
void draw() {
  background(0);
  
  image(shipImg, shipX, shipY);

  shipX = shipX + 10;
}
