// 参考
// http://blog.livedoor.jp/reona396/archives/55665479.html

class Eye
{
  PVector location;
  PVector localScale;
  boolean isLeft;

  Eye(PVector location_, PVector scale_, boolean isLeft_)
  {
    location = location_.get();
    localScale = scale_.get();
    isLeft = isLeft_;
  }

  void display()
  {
    pushMatrix();

    translate(location.x, location.y);
    scale(localScale.x, localScale.y);

    // 目のベース
    noStroke();
    fill(0);
    ellipse(0, 0, 190, 220);

    // 白目
    fill(255);
    ellipse(0, 30, 190, 220);

    // 黒目
    fill(0);
    ellipse(0, 50, 170, 180);

    // ハイライト1(上の方)
    fill(255);
    pushMatrix();
    translate(0, 0);
    rotate(radians(40));
    ellipse(-20, -20, 70, 110);
    popMatrix();

    // ハイライト2(下の方)
    noFill();
    strokeWeight(40);
    strokeCap(SQUARE);
    stroke(250, 246, 1);
    arc(0, 65, 100, 100, PI/6, PI*5/6);

    // まつ毛
    strokeCap(ROUND);
    strokeWeight(5);
    stroke(0);
    int sign = isLeft ? -1 : 1;
    line(90 * sign, -90, 60 * sign, -60);

    popMatrix();
  }
}