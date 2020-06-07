#include <opencv4/opencv2/core.hpp>
#include <opencv4/opencv2/opencv.hpp>
#include <opencv4/opencv2/videoio.hpp>
#include <algorithm>
#include <iostream>
#include "helper.h"

using namespace cv;

void Helper::process(Mat* frame, HSV hsv, int hue, int sat, int val, int ai){

    HSV f_hsv;
    RGB rgb;
    bool flag = false;
    if(ai > 0){
        ai = (ai / 20 * 2) + 1;
        flag = true;
    }

    int bottom = (hsv.H - hue / 2) < 0 ? (hsv.H - hue / 2 + 360) : (hsv.H - hue / 2);
    int top = (hsv.H + hue / 2) > 360 ? (hsv.H + hue / 2 - 360) : (hsv.H + hue / 2);

    //std::cout << hue << ' ' << sat << ' ' << val << "\n";

    for(int row = 0; row < frame->rows; row++){
        for(int col = 0; col < frame->cols; col++){

            rgb.b = (float)frame->at<Vec3b>(row, col)[0] / 255;
            rgb.g = (float)frame->at<Vec3b>(row, col)[1] / 255;
            rgb.r = (float)frame->at<Vec3b>(row, col)[2] / 255;

            f_hsv = convert(rgb);                       


            /* For S,V */
            if(f_hsv.S <= hsv.S + ((float)sat / 100) && f_hsv.S > hsv.S - ((float)sat /100)){
                if(f_hsv.V <= hsv.V + ((float)val / 100) && f_hsv.V > hsv.V - ((float)val /100)){
                    if( top >= bottom ? ( f_hsv.H <= top && f_hsv.H > bottom ) : ( f_hsv.H <= top || f_hsv.H > bottom )){

                                frame->at<Vec3b>(row, col)[0] = (unsigned short)round(f_hsv.V/3*255*2) + (unsigned short)round(f_hsv.S/3*255);
                                frame->at<Vec3b>(row, col)[1] = (unsigned short)round(f_hsv.V/3*255*2) + (unsigned short)round(f_hsv.S/3*255);
                                frame->at<Vec3b>(row, col)[2] = (unsigned short)round(f_hsv.V/3*255*2) + (unsigned short)round(f_hsv.S/3*255);
                                continue;

                    }
                }
            }

            frame->at<Vec3b>(row, col)[0] = 0x0;
            frame->at<Vec3b>(row, col)[1] = 0x0;
            frame->at<Vec3b>(row, col)[2] = 0x0;

        }
    }

    if(flag){
        Mat buf;
        medianBlur(*frame, buf, ai);
        *frame = buf;
    }
}
