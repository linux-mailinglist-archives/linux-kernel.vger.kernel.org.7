Return-Path: <linux-kernel+bounces-750544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC01B15DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7CF3A4785
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3AC275AE9;
	Wed, 30 Jul 2025 10:06:44 +0000 (UTC)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5EB26E71A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870004; cv=none; b=tJB/GfV61PsyKKHE0WWR8a4htlHR99erTwcO+idJtPREbipSenS63c3gz8MRzqLzTbMdSmbH+cnm6xaxPWcNfN/9xoLWDQmrEYymft6PKHZwy8V5ekOREI8MkQrdn+UeFw5JyALX3OL0N/KHYgWCa3aH5qz4cLHEuIg8sO32nmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870004; c=relaxed/simple;
	bh=Wu365XglTiD1XDf0deuZ6g4j72EDVPTtpoJYD/6wVls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cG9YKEhNahaNX2BL1WOF3x3eWKaLHDzvHky4QNSNxee6URpHqrxFMpApmWwgRJAbzYisxAQj2muJkij+AcXkRrX24QhjgNmzJAswAL6E+DYf1ypKvaL4RPQSW3u8hZ12cYPH63jgmQN7n50SyNuKGr/WMlc7onNyDxfYYIpqXl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-88bacb82a6dso705367241.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753870001; x=1754474801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bsrA2A2QMyCV/Ikd00XgPWtG5DcZPDcgRSJ6z3M0gt8=;
        b=tf/YNyTJDyipyRicDa1bKkYzvnxnrnJZvfEv9kqDmsqf129uhpML8HVoeJ89O/MWIZ
         8VqeTdhSJrnbeBJfofPRfN8U65n9FaDgbqXWcMg/63M4hUXc2m0qGiV8JJtVNJAgGsNl
         659bfFqQLfht9i8GxgVlcm46VkUmkjtwRTjgqyQ4hiMPEo/AFTATQLVqnTNhaMWy2T8s
         ihCbit25+ztn4V+f/n7I8CdJRH3b3VNrHvu8Ht9Q2Ho8UeGD7J7fTPssJ3G0AUiU8bgm
         PP3LR8KnVC87xFGHYk/w11DPmlaB0lWq1rDEbIdSnoAPNncmGP2Y27Aop0TYGHJkhS9H
         W0yw==
X-Forwarded-Encrypted: i=1; AJvYcCUl7Jg1z9XoIsuLjcM5SMbZoRLUDQw8fXb0vL9HMNiZS7/3xr1uBKyOaAJ1jV8CLB9KzmBsHXJh3okm2kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxxAgssPVxgkLN5+gL8CYaks4PQ7brZbO4KUpB3Q2ec5Ko4cJy
	HBPBc7SirY+rmebzmGD0Ohu2CPtXuRSe1eatA4B5+CbL3IJ9HUc4PSztb6/gP3yP
X-Gm-Gg: ASbGncthe97xUBTegAowxM6ePRc6q8T1mbxzWuAoHfLGa/fyjQ/JlqUoHMNQUollpKJ
	sihSImbinSSd6lwH6ZO2zjqzEOEUfwiL5jzv6lTmJ4hHkBF0EnXyOMRevpI+sXqJ36hwxo9JfkN
	Qc8YQbp6qMU+Dj0Iu3gvTtpkz6RpvzHvIdfUyUdGfCBMaK3sC1xnWSpFIywxRli7L/DpzW47Ioy
	LG3nHQdq3ksKPTq/L2aTxFOU3n2OWC6QM9dm8qTQqFIxX3ribo08ovZ25p/Q4bCohLsPTkXultz
	CV0VSCTOTkfkyPkkq9oSahlye4sa+bWZehgqksDEXdwoesxaDw1y2AdrzDxjf5rQFEQdcsMbgBq
	oR0X10Os9p4VrotPsmx50VPUQaX9AV1DUjNPPXbnbNUN9RVFqHJvk+ZfuZKfp
X-Google-Smtp-Source: AGHT+IG7941G5mjsfkah6mu/nrw5Lt2QH3lXuZhLMGFWnSLVToP0WKd45vs34VBPdW9+MSGNXmnEHg==
X-Received: by 2002:a05:6102:c02:b0:4e6:4e64:baeb with SMTP id ada2fe7eead31-4fbe8753cd0mr1517757137.17.1753870000953;
        Wed, 30 Jul 2025 03:06:40 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b8dcf7645sm2355149241.20.2025.07.30.03.06.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 03:06:40 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4fbfbda957fso59349137.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:06:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNEHXFzdngXO1olSANiYx7zht0svMNf3odlEHLbmh1T2yi2CQXU9SUmxlj2fHIjieOvdw5rl0gO01kPZg=@vger.kernel.org
X-Received: by 2002:a05:6102:3c81:b0:4fb:dd65:b97f with SMTP id
 ada2fe7eead31-4fbe87dd1aamr1637733137.23.1753869999913; Wed, 30 Jul 2025
 03:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615131129.954975-1-kuyo.chang@mediatek.com>
In-Reply-To: <20250615131129.954975-1-kuyo.chang@mediatek.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 Jul 2025 12:06:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWZHwr_nmMbVREKC9nQCYigT_gvKH3M9v+oyYqk6FLONw@mail.gmail.com>
X-Gm-Features: Ac12FXwS-l7uHGU1oTYcgJSesd4W3K8Q8G2IZz1kbq4jmTeRDTrEyXIFWqDBxL0
Message-ID: <CAMuHMdWZHwr_nmMbVREKC9nQCYigT_gvKH3M9v+oyYqk6FLONw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] sched/deadline: Fix RT task potential starvation
 when expiry time passed
To: Kuyo Chang <kuyo.chang@mediatek.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, jstultz <jstultz@google.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Kuyo,

On Mon, 16 Jun 2025 at 14:39, Kuyo Chang <kuyo.chang@mediatek.com> wrote:
> From: kuyo chang <kuyo.chang@mediatek.com>
>
> [Symptom]
> The fair server mechanism, which is intended to prevent fair starvation
> when higher-priority tasks monopolize the CPU.
> Specifically, RT tasks on the runqueue may not be scheduled as expected.
>
> [Analysis]
> ---------
> The log "sched: DL replenish lagged too much" triggered.
>
> By memory dump of dl_server:
> --------------
>     curr = 0xFFFFFF80D6A0AC00 (
>       dl_server = 0xFFFFFF83CD5B1470(
>         dl_runtime = 0x02FAF080,
>         dl_deadline = 0x3B9ACA00,
>         dl_period = 0x3B9ACA00,
>         dl_bw = 0xCCCC,
>         dl_density = 0xCCCC,
>         runtime = 0x02FAF080,
>         deadline = 0x0000082031EB0E80,
>         flags = 0x0,
>         dl_throttled = 0x0,
>         dl_yielded = 0x0,
>         dl_non_contending = 0x0,
>         dl_overrun = 0x0,
>         dl_server = 0x1,
>         dl_server_active = 0x1,
>         dl_defer = 0x1,
>         dl_defer_armed = 0x0,
>         dl_defer_running = 0x1,
>         dl_timer = (
>           node = (
>             expires = 0x000008199756E700),
>           _softexpires = 0x000008199756E700,
>           function = 0xFFFFFFDB9AF44D30 = dl_task_timer,
>           base = 0xFFFFFF83CD5A12C0,
>           state = 0x0,
>           is_rel = 0x0,
>           is_soft = 0x0,
>     clock_update_flags = 0x4,
>     clock = 0x000008204A496900,
>
> - The timer expiration time (rq->curr->dl_server->dl_timer->expires)
>   is already in the past, indicating the timer has expired.
> - The timer state (rq->curr->dl_server->dl_timer->state) is 0.
>
> [Suspected Root Cause]
> --------------------
> The relevant code flow in the throttle path of
> update_curr_dl_se() as follows:
>
> dequeue_dl_entity(dl_se, 0);                // the DL entity is dequeued
>
> if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(dl_se))) {
>     if (dl_server(dl_se))                   // timer registration fails
>         enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);//enqueue immediately
>     ...
> }
>
> The failure of `start_dl_timer` is caused by attempting to register a
> timer with an expiration time that is already in the past. When this
> situation persists, the code repeatedly re-enqueues the DL entity
> without properly replenishing or restarting the timer, resulting in RT
> task may not be scheduled as expected.
>
> [Proposed Solution]:
> ------------------
> Instead of immediately re-enqueuing the DL entity on timer registration
> failure, this change ensures the DL entity is properly replenished and
> the timer is restarted, preventing RT potential starvation.
>
> Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>

Thanks, this fixes the issue I was seeing!

Closes: https://lore.kernel.org/CAMuHMdXn4z1pioTtBGMfQM0jsLviqS2jwysaWXpoLxWYoGa82w@mail.gmail.com
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

