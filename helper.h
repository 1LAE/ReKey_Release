#ifndef HELPER_H
#define HELPER_H

#include <QObject>
#include <QString>
#include <string>
#include <opencv2/core/core.hpp>
#include <opencv2/videoio.hpp>


typedef struct Video{

    QString path;
    bool loaded = false;
    int width;
    int height;
    double fps;
    int totalFrames;
    cv::VideoCapture capture;

}Video;

typedef struct HSV{

    float H;
    float S;
    float V;

} HSV;


typedef struct RGB{
    float r;
    float b;
    float g;
}RGB;

class Helper : public QObject
{
    Q_OBJECT
public:
    explicit Helper(QObject *parent = nullptr);

signals:
    public slots:

    bool load(QString path);
    void prerender(QString color, int hue, int sat, int val, int ai, int time);
    bool render(QString key, int hue, int sat, int val, int ai);

private:
    void process(cv::Mat* frame, HSV hsv, int hue, int sat, int val, int ai);
    HSV convert(RGB rgb);
    RGB toRGB(QString color);
};

#endif // HELPER_H
