package xraybridge

import (
    "errors"
    "sync"
)

type MobileWriter interface {
    WritePacket(p []byte)
}

type Engine struct {
    mu      sync.Mutex
    started bool
    w       MobileWriter
}

var eng Engine

func Start(configJSON string, writer MobileWriter) error {
    eng.mu.Lock()
    defer eng.mu.Unlock()
    if eng.started {
        return nil
    }
    if writer == nil || configJSON == "" {
        return errors.New("invalid params")
    }
    eng.w = writer
    eng.started = true
    return nil
}

func FeedPacket(p []byte) {
    eng.mu.Lock()
    started := eng.started
    eng.mu.Unlock()
    if !started {
        return
    }
    // TODO: прокинуть пакет в движок
}

func Stop() {
    eng.mu.Lock()
    defer eng.mu.Unlock()
    if !eng.started {
        return
    }
    eng.started = false
    eng.w = nil
}

