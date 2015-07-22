PImage img; //画像を格納する変数

size(480, 640); //ウィンドウの大きさ．横(x方向)が480，縦(y方向)が640
img = loadImage("ship.png"); //Dataフォルダにあるship.png画像を読み込む．

image(img, 0, 0); //画像を座標(0,0)に出力する．画像の左上が座標(0, 0)にくる．
