Return-Path: <linux-kernel+bounces-872658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC87C11B84
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 640404E90FC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C04732C92A;
	Mon, 27 Oct 2025 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3GICERYW"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7981221DAC
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604406; cv=none; b=DWqTN3T1hkkmpKNP8UhtM/oOL/CTqx94Rr72YVZEgIq7jiJdl+pOM2KXhRC2ourzOLHnAZYhjz7DNqWKUslfrVKiWBzQ2pJ12UiO5k31rXNg6LS29hgN9jPkv/aecPjtqzMJXZlR0YxATPTcWV9j0w6rkwELSvXPwbaM81ldPvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604406; c=relaxed/simple;
	bh=zwrjCNlNufJVlJvBFlxfobQGeB1z+xEbVdASrKcBsTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dczz0Vymaa5bz9UdWNUto+8tp+YbZ0PaDBFhGYUX3yNzVoicmftnLtZqY+oSmLhuPuyX4cGoXku70QaTvZ4o1UreXqMa11cUWwtvbNET+dd+nKzp/tVfSU2HKj5XR9cMfxIMRXcUfVRxjn3/lSjQzQfBLQnevtJV64Ev02UlEd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3GICERYW; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27ee41e074dso54166985ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761604404; x=1762209204; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HEXV+uraTxvvaKOMTO48dDMDH/SBV1aHMUlVLszCNKE=;
        b=3GICERYWvnROoqKiVub/+GaU5K5gqhJMfxCkQRjoHSeiUr+bswE+zyZd92JaLkWcaG
         rvGRpDW+X4iEtHkmQst4BHv/b8CdBvn0kwPMuEI2KL4hrhowSluiyBPq+2JchCmPiJz/
         Jy2wcqZPkdXl0J9JGhrORFhvMme5lpTVSahHQR7BLxr6u1G4mIr3fMK7pnJ/wIihSXFS
         6cl2NbvJ19yDBiTeUWCiBoXYgXUnrAYFEYVLNig3nzwhRXw0vfsv1XdeUnnXAe9ZQ3rc
         f7V60+a8ZpDxFSwNHsqx/nM2D31jlgEJIw0E4wssV/4qcq44UKHgn9R8B74pIvMNGk/s
         afDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604404; x=1762209204;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEXV+uraTxvvaKOMTO48dDMDH/SBV1aHMUlVLszCNKE=;
        b=eYNDPuaHpmcR3mBFhecscNtLu0bk+K48W3LTUehI3CFoLdQuSTA78AEefEKUgoI+7+
         Gmy17WSgz8ErUUQiljA2pYOZbzZ+3SNposBCYeWxTRQibQnylWW/Wyu507gPSm1y2xfr
         P/s+35Q4NHihyNbRcj8NGKanT9s+8G3ChoxsOmZRiNuORAwFZk+N9MOa7oPr3PzHgnXn
         IOH2Fne+ns3JmSH2SytZ6rnz+a2T1pDJzpFqeq305P0B0SYbOvDOIKoYJsfMMVsMTawB
         xodghxJN7lpCgnJJ+fSQfLCi5HkXOb0j4u0MW2yRtu3Wi3wQjJHQRa0Qvw5+pRZuPiar
         F7Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWgCgBsi19Fa6pGWVUGjGqxwnkh4TfnGfBqIfthMv1PahKYS1Ru1dKCmwsG7M+5kvTdY5qhLwbir7kDuuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbHBL7B/QSYKb8/xrqzi2vTxyntMntrNpPHMGCh2htxSINdkD1
	R2tEbiN8hCTvT/jO2beRLHIaNUV9nT/CZ2cvWwEcHGrrbUjzlO2oB6CBoBuNR7hPOQ==
X-Gm-Gg: ASbGncuzYixPsrhhqYm6E3Yr2ayqEWHd5MYGBENj9wYvHlL64zB3IE2Ns000z9jxmeL
	DCuQnPnXQnCtoxtlm+a5ND4qAsV87KIAOeWRHYa3gpw+Fne+rLGQHsrtQR+yMvjVLU3V0td0CN+
	uPUJj8unHl43nIbb6XuLE5Xk8g0Qna5V4mxuw9VwtT9wkIbH8JHx9elcybyngnQpzr2boV8xqeh
	/IAIrylofA8FdW+GvaHMfI89xTJOIHyuSY2u8a76zmHZd0QBfatXLcLfR4Qv9sbCKTDJPNP0BlI
	87qbS4DNJHk5I9HX/y+7cgC2kSQ6up4W7Y6/k9eAlgNb4qllnymSsDkSJPBUc5H1CNR3bdtqeuN
	yP+yEJGl/qPjkeeBzUA4g0UWS07UDOJypeEgftdrVXG4Ud8Se1MEeAYXbGWKRdTVKNhCcp9Lu8k
	q29DURIy7TONU5I3YEka5OF5L2G97QVCa6dbUNyc6smMuttA/YPng=
X-Google-Smtp-Source: AGHT+IGEW8AEiOYwqGBJFhgBznMYateoc1MVARqrKNcIl/37iCw7vRpLGYq9XeitevU9mf+6X0ByDw==
X-Received: by 2002:a17:903:124c:b0:275:2328:5d3e with SMTP id d9443c01a7336-294cb3956cdmr17975895ad.18.1761604403595;
        Mon, 27 Oct 2025 15:33:23 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-76-132-13-32.hsd1.ca.comcast.net. [76.132.13.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e50dd9sm93198475ad.111.2025.10.27.15.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:33:23 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Valentin Schneider <vschneid@redhat.com>,  K Prateek Nayak
 <kprateek.nayak@amd.com>,  Peter Zijlstra <peterz@infradead.org>,  Hao Jia
 <jiahao.kernel@gmail.com>,  Chengming Zhou <chengming.zhou@linux.dev>,
  Josh Don <joshdon@google.com>,  Ingo Molnar <mingo@redhat.com>,  Vincent
 Guittot <vincent.guittot@linaro.org>,  Xi Wang <xii@google.com>,
  linux-kernel@vger.kernel.org,  Juri Lelli <juri.lelli@redhat.com>,
  Dietmar Eggemann <dietmar.eggemann@arm.com>,  Steven Rostedt
 <rostedt@goodmis.org>,  Mel Gorman <mgorman@suse.de>,  Chuyi Zhou
 <zhouchuyi@bytedance.com>,  Jan Kiszka <jan.kiszka@siemens.com>,  Florian
 Bezdeka <florian.bezdeka@siemens.com>,  Songtang Liu
 <liusongtang@bytedance.com>,  Chen Yu <yu.c.chen@intel.com>,  Matteo
 Martelli <matteo.martelli@codethink.co.uk>,  Michal =?utf-8?Q?Koutn=C3=BD?=
 <mkoutny@suse.com>,  Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] sched/fair: Prevent cfs_rq from being unthrottled
 with zero runtime_remaining
In-Reply-To: <20251023085604.244-1-ziqianlu@bytedance.com> (Aaron Lu's message
	of "Thu, 23 Oct 2025 16:56:04 +0800")
References: <20251023085604.244-1-ziqianlu@bytedance.com>
Date: Mon, 27 Oct 2025 15:33:19 -0700
Message-ID: <xm26ms5cug9c.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaron Lu <ziqianlu@bytedance.com> writes:

> When a cfs_rq is to be throttled, its limbo list should be empty and
> that's why there is a warn in tg_throttle_down() for non empty
> cfs_rq->throttled_limbo_list.
>
> When running a test with the following hierarchy:
>
>           root
>         /      \
>         A*     ...
>      /  |  \   ...
>         B
>        /  \
>       C*
>
> where both A and C have quota settings, that warn on non empty limbo list
> is triggered for a cfs_rq of C, let's call it cfs_rq_c(and ignore the cpu
> part of the cfs_rq for the sake of simpler representation).
>
> Debug showed it happened like this:
> Task group C is created and quota is set, so in tg_set_cfs_bandwidth(),
> cfs_rq_c is initialized with runtime_enabled set, runtime_remaining
> equals to 0 and *unthrottled*. Before any tasks are enqueued to cfs_rq_c,
> *multiple* throttled tasks can migrate to cfs_rq_c (e.g., due to task
> group changes). When enqueue_task_fair(cfs_rq_c, throttled_task) is
> called and cfs_rq_c is in a throttled hierarchy (e.g., A is throttled),
> these throttled tasks are directly placed into cfs_rq_c's limbo list by
> enqueue_throttled_task().
>
> Later, when A is unthrottled, tg_unthrottle_up(cfs_rq_c) enqueues these
> tasks. The first enqueue triggers check_enqueue_throttle(), and with zero
> runtime_remaining, cfs_rq_c can be throttled in throttle_cfs_rq() if it
> can't get more runtime and enters tg_throttle_down(), where the warning
> is hit due to remaining tasks in the limbo list.
>
> I think it's a chaos to trigger throttle on unthrottle path, the status
> of a being unthrottled cfs_rq can be in a mixed state at the end, so fix
> this by calling throttle_cfs_rq() in tg_set_cfs_bandwidth() immediately
> after enabling bandwidth and setting runtime_remaining = 0. This ensures
> cfs_rq_c is throttled upfront and cannot enter tg_unthrottle_up() with
> zero runtime_remaining.
>
> Also, update outdated comments in tg_throttle_down() since
> unthrottle_cfs_rq() is no longer called with zero runtime_remaining.
>
> While at it, remove a redundant assignment to se in tg_throttle_down().
>
> Fixes: e1fad12dcb66("sched/fair: Switch to task based throttle model")
> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> v2: add update_rq_clock() before throttle_cfs_rq() as reported by Hao
>     Jia, or a warn on outdated rq clock is trigged in tg_throttle_down().
>     This can happen when user specified a tiny quota.
>
> Note that Hao Jia also proposed another solution by using a special flag
> when doing enqueue_task_fair() in unthrottle path to avoid doing
> check_enqueue_throttle() [0]. I think that approach is fine too and it
> also has the benefit of not needing to worry about any other potential
> cases where a cfs_rq is unthrottled with <=0 runtime_remaining. Thoughts
> on which approach to go is welcome, thanks.
> [0]: https://lore.kernel.org/lkml/c4a1bcea-fb00-6f3f-6bf6-d876393190e4@gmail.com/
>
>  kernel/sched/core.c  | 11 ++++++++++-
>  kernel/sched/fair.c  | 16 +++++++---------
>  kernel/sched/sched.h |  1 +
>  3 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f1ebf67b48e21..58185ec5b8efd 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9608,7 +9608,16 @@ static int tg_set_cfs_bandwidth(struct task_group *tg,
>  		cfs_rq->runtime_enabled = runtime_enabled;
>  		cfs_rq->runtime_remaining = 0;
>  
> -		if (cfs_rq->throttled)
> +		/*
> +		 * Throttle cfs_rq now or it can be unthrottled with zero
> +		 * runtime_remaining and gets throttled on its unthrottle path.
> +		 */
> +		if (cfs_rq->runtime_enabled && !cfs_rq->throttled) {
> +			update_rq_clock(rq);
> +			throttle_cfs_rq(cfs_rq);
> +		}
> +
> +		if (!cfs_rq->runtime_enabled && cfs_rq->throttled)
>  			unthrottle_cfs_rq(cfs_rq);
>  	}
>

So if this is the only case it can come up, and it only occurs becasue
we set runtime_remaining = 0 and check in unthrottle with <= 0, then I
think we should just set runtime_remaining = 1 here. 

That seems simpler than either throttling immediately (despite likely
having plenty of cfs_b->runtime) or adding an enqueue flag. Adding NR_CPUs
nanoseconds worth of quota on configure seems fine.

unthrottle_cfs_rq/tg_unthrottle_up itself doesn't drop rq lock, so we
shouldn't be able to see cfs_rq->runtime_remaining being consumed during
it, even if it's running on a remote cpu so that threads in the cfs_rq
can be running. They should wind up stuck waiting for rq lock in order
to update runtime_remaining.

Is there anything you see missing from that approach? I think it doing =
0 in particular here is just an artifact, and while the extra check for
runtime_remaining in unthrottle isn't unreasonable, the conflict with
tg_set_cfs_bandwidth isn't a fundamental issue.

