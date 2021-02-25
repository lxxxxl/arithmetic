#include <QObject>
#include "ttswrapper.h"

TTSWrapper::TTSWrapper(QObject *parent) : QObject(parent)
{
    m_speech = new QTextToSpeech(this);
}

void TTSWrapper::say(QString text)
{
    m_speech->say(text);
}
