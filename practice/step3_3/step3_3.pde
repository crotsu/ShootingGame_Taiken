PImage shipImg; // 自機の画像の宣言
int shipX;
int shipY;

void setup() {
  imageMode(CENTER); // 画像座標の指定を中心にする

  size(480, 640);
  shipImg = loadImage("ship.png");

  shipX = 240;
  shipY = 500;
}

void draw() {
  shipX = shipX + 10;
  image(shipImg, shipX, shipY); // 画像を表示
}
