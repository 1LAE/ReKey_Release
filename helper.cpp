/* helper.cpp
 * Функции для работы со структурами видеофайла
 * load: подгрузка файла, инициализация структур и фреймов
 * prerender: вывод исходного и обработанного изображения на мониторы пльзователя в качестве двух кадров
 * render: экспорт обработанного видео в файл
 * */



#include <QQuickImageProvider>
#include <QColor>
#include <QString>
#include <iostream>
#include <string>
#include <opencv2/imgproc.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/core.hpp>
#include <opencv2/videoio.hpp>
#include <opencv2/video.hpp>
#include "helper.h"

using namespace cv;

Video vid;

Helper::Helper(QObject *parent) : QObject(parent)
{

}


bool Helper::load(QString path){

    vid.path = path;

    if(vid.capture.isOpened()){
        vid.capture.release();
    }

    vid.capture.open(path.toStdString());

    if(!vid.capture.isOpened()){
        std::cerr << "Can't open video file\n";
        return false;
    }

    /* Инициализация структур видео */
    vid.totalFrames = vid.capture.get(CAP_PROP_FRAME_COUNT);
    vid.fps = vid.capture.get(CAP_PROP_FPS);
    vid.height = vid.capture.get(CAP_PROP_FRAME_HEIGHT);
    vid.width = vid.capture.get(CAP_PROP_FRAME_WIDTH);


    /* Инициализация шаблона мониторов */
    Mat image;
    image = imread((const std::string)"../ReKey_Release/template.jpg", IMREAD_COLOR);
    if(image.empty()){
        std::cerr << "Can't find template file\n";
        return false;
    }

    if(!(bool)imwrite("../ReKey_Release/image.jpg", image)){
            std::cerr << "ERROR: Can't write current frame\n";
    }
    if(!(bool)imwrite("../ReKey_Release/image_alpha.jpg", image)){
            std::cerr << "ERROR: Can't write current alpha frame\n";
    }

    return true;
}


void Helper::prerender(QString key, int hue, int sat, int val, int ai, int time){

    if(time == 100){
        time = 99;
    }    

    /* Находим номер кадра по таймингу */
    int current = round(vid.totalFrames * ((double)time / 100));

    Mat frame, prerender;

    /* Перемещаемся к нужному кадру */
    vid.capture.set(CAP_PROP_POS_FRAMES, current);
    vid.capture.read(frame);
    vid.capture.set(CAP_PROP_POS_FRAMES, current);
    vid.capture.read(prerender);   

    /* Применяем фильтр к текущему кадру */
    process(&prerender, convert(toRGB(key)), hue, sat, val, ai);

    double scale;
    if((double)vid.width / vid.height >= (double)250/140){
        scale = (double)500 / vid.width;
    } else {
        scale = (double)280 / vid.height;
    }

    /* Делаем downscale изображения, чтобы он поместился на монитор */
    Size size;
    Mat crop;
    resize(frame, crop, size, scale, scale, INTER_LINEAR);
    imwrite("../ReKey_Release/image.jpg", crop);
    resize(prerender, crop, size, scale, scale, INTER_LINEAR);
    imwrite("../ReKey_Release/image_alpha.jpg", crop);
}

bool Helper::render(QString key, int hue, int sat, int val, int ai){

    HSV hsv = convert(toRGB(key));
    QString Path;
    Path = vid.path.insert(vid.path.size() - 4, "_alpha"); //суффикс названия
    VideoWriter output; // Собирает видео покадрово
    output.open(Path.toStdString(), VideoWriter::fourcc('m', 'p', '4', 'v'), vid.fps, Size(vid.width, vid.height));

    /* Переходим к началу видео */
    vid.capture.set(CAP_PROP_POS_FRAMES, 0);
    Mat frame;

    /* Проход по всем кадрам */
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
