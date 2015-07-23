PImage shipImg; // 自機の画像の宣言
int shipX;
int shipY;

imageMode(CENTER); // 画像座標の指定を中心にする
size(480, 640);

shipImg = loadImage("ship.png"); // 自機の画像を読み込む
shipX = 240;
shipY = 500;

image(shipImg, shipX, shipY); // 画像を表示

