#ifndef TTSWRAPPER_H
#define TTSWRAPPER_H

#include <QObject>
#include <QTextToSpeech>

class TTSWrapper : public QObject
{
    Q_OBJECT
public:
    QTextToSpeech *m_speech;
    explicit TTSWrapper(QObject *parent = nullptr);
    Q_INVOKABLE void say(QString text);

signals:

};

#endif // TTSWRAPPER_H
