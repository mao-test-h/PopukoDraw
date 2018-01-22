
// ===========================================================
// Common Defines

// 肌の色
color SkinColor = color(255, 222, 205);

// アウトラインの太さ
int StrokeWeight = 3;


// ===========================================================

Popuko popuko;

void setup()
{
  size(600, 400);
  popuko = new Popuko(new PVector(width/2, height/2));
}

void draw()
{
  background(255);
  popuko.display();
}

