#include <QQuickImageProvider>
#include <QColor>
#include <QString>
#include <QDir>
#include <iostream>
#include <experimental/filesystem>
#include <string>
#include <opencv4/opencv2/imgproc/imgproc.hpp>
#include <opencv4/opencv2/imgcodecs.hpp>
#include <opencv4/opencv2/core.hpp>
#include <opencv4/opencv2/videoio.hpp>
#include "helper.h"

using namespace cv;

Video vid;

Helper::Helper(QObject *parent) : QObject(parent)
{

}


bool Helper::load(QString path){

    vid.path = path;

    QFile file(path);
    if(!file.isOpen()){
        std::cerr << "No such file found\n";
        return false;
    }
    file.close();

    if(vid.capture.isOpened()){
        vid.capture.release();
    }

    vid.capture.open(path.toStdString());

    if(!vid.capture.isOpened()){
        std::cerr << "Cant open video file\n";
        return false;
    }

    vid.totalFrames = vid.capture.get(CAP_PROP_FRAME_COUNT);
    vid.fps = vid.capture.get(CAP_PROP_FPS);
    vid.height = vid.capture.get(CAP_PROP_FRAME_HEIGHT);
    vid.width = vid.capture.get(CAP_PROP_FRAME_WIDTH);

    Mat image;
    image = imread((const std::string)"../ReKey/template.jpg", IMREAD_COLOR);
    if(image.empty()){        
        return false;
    }

    if(!imwrite("../Rekey/image.jpg", image)){
            std::cerr << "ERROR: Can't write current frame";
    }
    if(!imwrite("../Rekey/image_alpha.jpg", image)){
            std::cerr << "ERROR: Can't write current alpha frame";
    }

    return true;
}


void Helper::prerender(QString key, int hue, int sat, int val, int ai, int time){

    if(time == 100){
        time = 99;
    }    

    int current = round(vid.totalFrames * ((double)time / 100));

    Mat frame, prerender;

    vid.capture.set(CAP_PROP_POS_FRAMES, current);
    vid.capture.read(frame);
    vid.capture.read(prerender);   

    process(&prerender, convert(toRGB(key)), hue, sat, val, ai);

    double scale;
    if((double)vid.width / vid.height >= (double)250/140){
        scale = (double)500 / vid.width;
    } else {
        scale = (double)280 / vid.height;
    }

    Size size;
    Mat crop;
    resize(frame, crop, size, scale, scale, INTER_LINEAR);
    imwrite("../ReKey/image.jpg", crop);
    resize(prerender, crop, size, scale, scale, INTER_LINEAR);
    imwrite("../ReKey/image_alpha.jpg", crop);
}

bool Helper::render(QString key, int hue, int sat, int val, int ai){

    HSV hsv = convert(toRGB(key));
    QString Path;
    Path = vid.path.insert(vid.path.size() - 4, "_alpha");
    VideoWriter output;
    output.open(Path.toStdString(), VideoWriter::fourcc('m', 'p', '4', 'v'), vid.fps, Size(vid.width, vid.height));

    vid.capture.set(CAP_PROP_POS_FRAMES, 0);
    Mat frame;

    for(int i = 0; i < vid.totalFrames; i++){

        if(vid.capture.read(frame)){
            process(&frame, hsv, hue, sat, val, ai);
            output.write(frame);
        } else {
            std::cerr << "ERROR: Cant read frame №" << i << "\n";
        }
    }

    output.release();

    return true;

}
