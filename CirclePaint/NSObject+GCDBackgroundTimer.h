//
//  NSObject+GCDBackgroundTimer.h
//  DXLight
//
//  Created by LEE CHIEN-MING on 9/7/13.
//  Copyright (c) 2013 LEE CHIEN-MING. All rights reserved.
//

CG_INLINE dispatch_source_t CreateDispatchTimer(uint64_t interval, uint64_t leeway, dispatch_queue_t queue, dispatch_block_t block){
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    if(timer) {
        dispatch_source_set_timer(timer, dispatch_walltime(NULL,0), interval, leeway);
        dispatch_source_set_event_handler(timer, block);
        dispatch_resume(timer);
    }
    return timer;
}


