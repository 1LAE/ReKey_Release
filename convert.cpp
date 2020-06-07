#include <QString>
#include <string>
#include <iostream>
#include "helper.h"


HSV Helper::convert(RGB rgb){
    //#rrggbb

    HSV hsv;
    float maximum, minimum;
    float r, g ,b;

    r = rgb.r;
    g = rgb.g;
    b = rgb.b;

    maximum = std::max(b,g);
    maximum = std::max(maximum, r);
    minimum = std::min(b,g);
    minimum = std::max(minimum, r);

    if(maximum == minimum){
        hsv.V = 0;
    } else if(maximum == r){
        if(g >= b){
            hsv.H = 60 * (g - b) / (maximum - minimum) + 0;
        } else {
            hsv.H = 60 * (g - b) / (maximum - minimum) + 360;
        }
    } else if(maximum == g) {
        hsv.H = 60 * (b - r) / (maximum - minimum) + 120;
    } else {
        hsv.H = 60 * (r - g) / (maximum - minimum) + 240;
    }

    if(maximum == 0){
        hsv.S = 0;
    } else {
        hsv.S = 1.0 - (minimum / maximum);
    }

    hsv.V = maximum;

    return hsv;
}

RGB Helper::toRGB(QString color){

    RGB rgb;
    QString buf;    

    buf = color.mid(1,2);
    rgb.r = (float)stoi(buf.toStdString(), 0, 16) / 255;
    buf = color.mid(3,2);
    rgb.g = (float)stoi(buf.toStdString(), 0, 16) / 255;
    buf = color.mid(5,2);
    rgb.b = (float)stoi(buf.toStdString(), 0, 16) / 255;        

    return rgb;

}
