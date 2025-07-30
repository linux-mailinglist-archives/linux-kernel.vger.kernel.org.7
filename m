Return-Path: <linux-kernel+bounces-751341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0770B167FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE95584836
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F3321FF39;
	Wed, 30 Jul 2025 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lIrPBonv"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95EA23741
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753909533; cv=none; b=gSQLKRRip/brHnxJ9r8U8PTNhoJIeTX2GZAktcfNJ7OrXT5V1hbg48EUHUTnhgBQLNBV2NHGr9z0g+Jwli+qMeLmP+5WFbTyx0hIPza0XuhLqofF1YYzxb6X7UoeiMG7RJHlNEvAC2pdkiphwe01SHaHkDeWecorn2ZQuPB+Z5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753909533; c=relaxed/simple;
	bh=ejHaO+1FfZjSrvLukt0TA1VGre71vAiwsp9uJdlAI58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjXTnFxfLHMGcFV7C5BWdDaR+2MChKX7lJrpeekEW0H/kCp7TgF0zRW1z1b41q7xJrVVTMMpScaephIuXlstthN8qhvakzpaia4NZJanwjgVUk/rcZiTv+wTV8PipLB9CBW/vXO0bt6PaxkSb7+ikX65Br+vfevgZ3KKRgIXVho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lIrPBonv; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-88bd5f7e43cso68578241.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753909530; x=1754514330; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mekhwe1ry/LVixmkYQVdrhwkkRPfG9OPN7QCxt8YDCo=;
        b=lIrPBonvuFjjoKeIiDjI4h8tf+tdRuqF7GrcuVsGqSVwsUZ1AqTRuhGILzuXSddq2X
         VjfAzyRDpPFfoZHJspcYaX2hn9h/1yC+u2akwLn99xp7lj6sH1oedZTmOptAvT8MJb9m
         8Mn2hQIOtzeUmfuNrhpVgP3oNVtXYESbdV+efSM5EAx1z2KggGXPtqmIEkUfmFyEs+D7
         9ewDbdDUWxBQqCYGw5SE0bxtYQl7rVUUS9JQdVfwAI7r0XXh7aLbCszeVdyWPn0BAEMC
         UsFwl6oBm59btBrjZVH2XRlt+YflhWKiHOj0EQP0o6JGAN71GJlE1aqNLdJpS5MesFA+
         /jBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753909530; x=1754514330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mekhwe1ry/LVixmkYQVdrhwkkRPfG9OPN7QCxt8YDCo=;
        b=HZxxXmJFceAn4BF5ZAMpJfF2+ogtM8DDq9g0mUwHzjV2V85sQxWbWjNzekoJHtXTbL
         WH2kZQ4CVhhak08kZcbdgYT9m28fYvOcgscEHgl2+3diugetzu+aKHdBryQYt58/FkjC
         /trkk7gfWrPm+9KQh0Js5Mj1M828gHuy5MpfLuOS6nzzOnOizbNuNIt/Se+MuKD/aU37
         fpDU4iX09u9/c2R9UpzCxPfUCKeS3EZmxTOexXezmk5+hZKnQ12vDuTW2TOR8jn5yn99
         B+aFFRu4YFYttzJuyZQ1mvvLzC6t5d7Mrg9E4/u1xcoFT2xlUYxNRZba8mhr9vwoLiui
         gUWg==
X-Forwarded-Encrypted: i=1; AJvYcCUM8P0o21lITUqD79XfoPvjF40votzEqtpK7J7IJXE/nWGcicfUR+NwMf8XTs5XxoN4vmnm1t/JYV7hOFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFHgX4yGtAgGnNh1a4TRMFgIIcqOdy+0ILQIOb26z4zVELIk+3
	RxccrTmyIyX9wiE+GaTWGaftaVOvi+MG+1qNjfnUHXozkKH/h2r84dmLGnQMMi359HpEY+Bu7S+
	nWKoXuPmO2Eyh9dPEjPxIz1ngxVaDdedHrelDC+bE
X-Gm-Gg: ASbGncs8LzJ5gJFM7kaxiqGFFbOyO0igAIQtUd1lRZwx4L69l9P9xHrR3vyCRblCGAa
	DR6kCq3T1QJ2kmu3DDGfLXrLHPO4SyS/l7PBbILfN3kb9F2jgQ7nc075RJ94JsCXDbTdcXd17/4
	nSY2zVN+LynNdi/BoMYu+Z2rjSpS4hjny01qSdh1ZCKVRpiXegS2WXtxQ5nVmvxWFqKS0o0UUsd
	LJiC0giDcrE3jrH3w==
X-Google-Smtp-Source: AGHT+IEnTCtoun42bREbAjSKeHaz9F9l2Q3VJWZQwImv3aBUV9h3OCiwrIAoR7C/7tjtL5PVMUr2yRTuyWwdKTPCetM=
X-Received: by 2002:a05:6102:3e24:b0:4f9:6a91:133a with SMTP id
 ada2fe7eead31-4fbe894841bmr3219994137.27.1753909530069; Wed, 30 Jul 2025
 14:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730205644.2595052-1-blakejones@google.com>
In-Reply-To: <20250730205644.2595052-1-blakejones@google.com>
From: Blake Jones <blakejones@google.com>
Date: Wed, 30 Jul 2025 14:05:18 -0700
X-Gm-Features: Ac12FXzxIf8wGwM4BfTglyT5rtXOMz8B-0C6i7g3rWOoyuvlUCjsHGsIfSzm6cE
Message-ID: <CAP_z_Cg1Yvyq1qEkYXcyL-=zqTxqMxpV3Ap7ggzd4Q8f+=Zd9A@mail.gmail.com>
Subject: Re: [PATCH v2] Reorder some fields in struct rq.
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Josh Don <joshdon@google.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Below is the source for the load test that I used. Although it
performs some timing calculations, the actual metric I used to
evaluate the change was "average amount of CPU time spent in
sched_balance_rq()", as described above.

------------------------------------------------------------------------

#include <poll.h>
#include <pthread.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

struct {
        /* "-m": Number of milliseconds to sleep for. */
        int sleep_ms;

        /* "-l": (base 2) Log of number of sleeps to do. */
        int log_loops;

        /* "-c": Number of children. */
        int children;
} params = {
        .sleep_ms = 1,
        .log_loops = 13,
        .children = 1000,
};

/* ------------------------------------------------------------------ */

typedef struct {
        pthread_mutex_t        mutex;
        pthread_cond_t        cv;
        pthread_cond_t        parent_cv;
        int                nthreads;
        int                nthreads_total;
        int                go;
        int                stop;
} thread_group_t;

void
thread_data_init(thread_group_t *tg)
{
        pthread_mutexattr_t mattr;
        pthread_mutexattr_init(&mattr);
        pthread_mutexattr_setpshared(&mattr, PTHREAD_PROCESS_SHARED);
        pthread_mutex_init(&tg->mutex, &mattr);
        pthread_mutexattr_destroy(&mattr);

        pthread_condattr_t cattr;
        pthread_condattr_init(&cattr);
        pthread_condattr_setpshared(&cattr, PTHREAD_PROCESS_SHARED);
        pthread_cond_init(&tg->cv, &cattr);
        pthread_cond_init(&tg->parent_cv, &cattr);
        pthread_condattr_destroy(&cattr);

        tg->nthreads = 0;
        tg->nthreads_total = params.children;
        tg->go = 0;
        tg->stop = 0;
}

void
parent_thread(thread_group_t *tg)
{
        pthread_mutex_lock(&tg->mutex);
        while (tg->nthreads != tg->nthreads_total) {
                pthread_cond_wait(&tg->parent_cv, &tg->mutex);
        }
        tg->go = 1;
        pthread_cond_broadcast(&tg->cv);
        pthread_mutex_unlock(&tg->mutex);

        pthread_mutex_lock(&tg->mutex);
        while (tg->nthreads != 0) {
                pthread_cond_wait(&tg->parent_cv, &tg->mutex);
        }
        tg->stop = 1;
        pthread_cond_broadcast(&tg->cv);
        pthread_mutex_unlock(&tg->mutex);
}

void
loop(unsigned long long loops)
{
        struct timespec ts;
        ts.tv_sec = 0;
        ts.tv_nsec = params.sleep_ms * 1000000;

        for (unsigned long long i = 0; i < loops; i++) {
                nanosleep(&ts, NULL);
        }
}

void *
child_thread(thread_group_t *tg)
{
        pthread_mutex_lock(&tg->mutex);
        ++tg->nthreads;
        if (tg->nthreads == tg->nthreads_total) {
                pthread_cond_signal(&tg->parent_cv);
        }
        while (!tg->go) {
                pthread_cond_wait(&tg->cv, &tg->mutex);
        }
        pthread_mutex_unlock(&tg->mutex);

        loop(1ULL << params.log_loops);

        pthread_mutex_lock(&tg->mutex);
        --tg->nthreads;
        if (tg->nthreads == 0) {
                pthread_cond_signal(&tg->parent_cv);
        }
        while (!tg->stop) {
                pthread_cond_wait(&tg->cv, &tg->mutex);
        }
        pthread_mutex_unlock(&tg->mutex);
        return NULL;
}

void
thread_data_fini(thread_group_t *tg)
{
        pthread_mutex_destroy(&tg->mutex);
        pthread_cond_destroy(&tg->cv);
        pthread_cond_destroy(&tg->parent_cv);
}

/* ------------------------------------------------------------------ */

void *
spawn_procs(thread_group_t *tg)
{
        pid_t *pids = malloc(params.children * sizeof (pid_t));
        for (int c = 0; c < params.children; c++) {
                pid_t pid;
                switch (pid = fork()) {
                case 0:
                        child_thread(tg);
                        _exit(0);
                        break;
                case -1:
                        perror("fork() failed");
                        return NULL;
                default:
                        pids[c] = pid;
                        break;
                }
        }
        return pids;
}

void
await_procs(void *data)
{
        pid_t *pids = (pid_t *)data;
        for (int c = 0; c < params.children; c++) {
                int rv = waitpid(pids[c], NULL, 0);
                if (rv != pids[c]) {
                        char msg[256];
                        snprintf(msg, sizeof(msg),
                            "waitpid(%d) = %d", pids[c], rv);
                        perror(msg);
                }
        }
        free(pids);
}

double
main_loop(void)
{
        void *mem = mmap(NULL, 4096, PROT_READ | PROT_WRITE,
                         MAP_ANONYMOUS | MAP_SHARED, -1, 0);
        if (mem == MAP_FAILED) {
                perror("mmap() failed");
                return 0;
        }
        thread_group_t *tg = mem;
        thread_data_init(tg);

        void *data = spawn_procs(tg);

        struct timespec ts1, ts2;
        if (clock_gettime(CLOCK_MONOTONIC, &ts1) == -1) {
                perror("clock_gettime(ts1)");
                return 1;
        }
        parent_thread(tg);
        if (clock_gettime(CLOCK_MONOTONIC, &ts2) == -1) {
                perror("clock_gettime(ts2)");
                return 1;
        }

        await_procs(data);
        thread_data_fini(tg);
        munmap(mem, 4096);

        double t1 = (double)ts1.tv_sec + (double)ts1.tv_nsec / 1e9;
        double t2 = (double)ts2.tv_sec + (double)ts2.tv_nsec / 1e9;
        return t2 - t1;
}

int
main(int argc, char **argv)
{
        int opt;
        while ((opt = getopt(argc, argv, "m:l:c:f")) != -1) {
                switch (opt) {
                case 'm':
                        params.sleep_ms = atoi(optarg);
                        break;
                case 'l':
                        params.log_loops = atoi(optarg);
                        break;
                case 'c':
                        params.children = atoi(optarg);
                        break;
                default:
                        fprintf(stderr, "Usage: "
                            "%s [-m <ms> -l <log> -c <children>]\n", argv[0]);
                        return 1;
                }
        }

        printf("Running: "
                "%5d children, 1<<%d loops, %d ms sleep/loop\n",
                params.children, params.log_loops, params.sleep_ms);

        printf("%.5lf\n", main_loop());

        return 0;
}

