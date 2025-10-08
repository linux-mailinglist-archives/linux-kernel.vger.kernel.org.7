Return-Path: <linux-kernel+bounces-845300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EC2BC44F0
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBD744EC866
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE6E2F5A24;
	Wed,  8 Oct 2025 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bnWlFFuS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888DE25C6F1
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919210; cv=none; b=rHyXATONuy3vvN1tHMFW27+e84Hlm6sMEvcPTr/4DqQY6XR3AiVen8AVIJc1ilUZtAkf9S/JJQb0V4nfP18KmQVUtU90h5hX2C9GehgqzRXAp4grJSC+xMd7FRUdTQntLWST1dew3HlXDrLQWTnT1g8IfOHsE3tvjVDG5nlbhd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919210; c=relaxed/simple;
	bh=/Va9MoXNCyzPFPF1o/beo01WOBOpFdQvAq6H7AxcJdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y74RRJN6w3yShYkhsydYYoHFV2LIxooFnoYMnSUxaBwi3IaRYol3ODn4MfvPi8COmCHe5HLrNr5pLUsdS69w1AqBa6twbnz200SkAqywUg3anMvFkzQUimOKlCv0Mt2Nthh/GTrqbz9MF+cL/WSkRaQ+RUSaZCTu5Jpzr+gydD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bnWlFFuS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759919207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NtyvxgK5HyNpaPYsgb5vRdVvk0Si3iYb34e4kAflJyI=;
	b=bnWlFFuSdXbHB8fGro937MQMV9EKKd+cwrTt+QZV1cPuMd4W95bpBrjcbnPHXmnPETNNtQ
	WC4zaLs7SAtJ0UA80kfM36ARSTZcyWqDMl5VEjWHqbbacjU4zJkD2ncRO1F0ICVEqZzQ36
	Zt6IvdEFou7mccbHWb9LXlDYRxQt//U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-y-tlYx3SOOmM4qQ8iUDWsQ-1; Wed, 08 Oct 2025 06:26:46 -0400
X-MC-Unique: y-tlYx3SOOmM4qQ8iUDWsQ-1
X-Mimecast-MFC-AGG-ID: y-tlYx3SOOmM4qQ8iUDWsQ_1759919205
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e45899798so27333455e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 03:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759919205; x=1760524005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtyvxgK5HyNpaPYsgb5vRdVvk0Si3iYb34e4kAflJyI=;
        b=ObcwbbXTTbQyUbx+H457srpsIiFFNNn+rZnQRlwgihce6MjoJPXvYfDBzyAVbmFpgi
         G4D5hpU6tE542sAnCfz8pJINUVBl22Om+8b/v+GIrwzPv3KQhgFphtK4uuUMQw03HLCm
         cK0Fzpo9f6/VUtReCEnUTcDt8h5vePjP31sqMZg8V7sHsTzu1P19Dp/0/cTnY5Kn7EoY
         aHawxVHhvsc502qNGcPY6axwQaTQKtPuFtOhoNW4x/eulxd0zW6I0AUcb7CW0gOHyEyn
         Hhv7l4EZI8Dd6vUwP7eEX3qNpBCMgnFih+ya2UOgzpQHcj15rzvLW1O7UZaojZMH60RF
         5bjg==
X-Forwarded-Encrypted: i=1; AJvYcCUjTe8UK2D40q86kV1sygYVGeYIA26Q07ADEiEaQLNFxeEhbharGLGTmk3xDanljxNBVD2TCSMcXdQetnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaT16EK2DQIICzB+AtCeCsdrnfLTKe1JXH4IXXlI1Puig+RIe5
	0gpPcO6bTdrLWhN6LZ/fQT0Zqg0Y2t52kClki1orBl3ZzRi1WlKrABSfyfI7B4kGWaF8PkWW6+0
	VCIn6KlJFNl9Vp2pt0xa71uZcDpfb5Wgz37HwoLErWGoVbx5UOknPdFTP8sBqk3I9xQ==
X-Gm-Gg: ASbGncu5LFzhOfTJACHYjepN7i+bFGIFD0sb5gKy4hA4l7gXfF0DxF2gI+pzWvNwjHS
	nPZSGABLp6eN0+l/lHxzx+0RYsg03bq7h5G0lXj/hFHIQpiFgwAmDSJpcURNX9a1qU4znUIU3c0
	7Ypdm4rdju2q3TVqTMsvIqPKbAHjMAW3QIRTj3yuLK4kOfhuQ/ZpmTbIusPC4+A37znYo3iNILf
	pTKHiNOfZUyvghof8WfJfX4QOb1NreYyXvU4fruI0OPIIZYf/EottxUxZwYra03QtK36BVq+BFL
	x2kdIttyZyRFNmTGVQtgY3D4dEO2uCNtskdUgF9t5KUk/RGnvlhFCA1itweLKfiPmYNLgwStK7g
	hRQ==
X-Received: by 2002:a05:600c:46d1:b0:46e:45fd:946e with SMTP id 5b1f17b1804b1-46fa9b078e2mr21791475e9.31.1759919204938;
        Wed, 08 Oct 2025 03:26:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELXkSaV+V/oFPkPdBOlrAaVQCKLDQEIwxpa/vR36bXcXrhwjk715qrjo1hC00ITujueWjuMA==
X-Received: by 2002:a05:600c:46d1:b0:46e:45fd:946e with SMTP id 5b1f17b1804b1-46fa9b078e2mr21791175e9.31.1759919204478;
        Wed, 08 Oct 2025 03:26:44 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42585989607sm6568441f8f.53.2025.10.08.03.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 03:26:43 -0700 (PDT)
Date: Wed, 8 Oct 2025 12:26:42 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v3 11/24] sched/rt: Add rt-cgroups' dl-servers
 operations.
Message-ID: <aOY8YpZrMXn8iB5f@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
 <20250929092221.10947-12-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929092221.10947-12-yurand2000@gmail.com>

Hello,

On 29/09/25 11:22, Yuri Andriaccio wrote:
> Implement the servers' functions that pick the next eligible task to run.
> Enable/Disable dl-servers on task enqueue/dequeue when necessary.
> Update dl-servers on task update.
> Account the number of active rt-tasks in the cgroups' specific runqueue.
> Account the number of active rt-tasks on the global counter of active tasks when
> a cgroup is enqueued/dequeued (dl-server started/stopped).
> Update rq's cpuprio only if the cgroup's is root control group.
> Record which dl_server is managing a task when it changes runqueue.

Changelog looks a little dry. Claude suggests a little rewrite like

---
sched/rt: Implement dl-server operations for rt-cgroups

Implement the dl-server backend that enables rt-cgroups to run as
deadline servers. This allows RT tasks within a cgroup to be scheduled
according to the cgroup's allocated bandwidth using deadline scheduling.

The implementation consists of three main parts:

1) Server task selection callbacks:
   - rt_server_has_tasks(): Check if the rt_rq has runnable tasks
   - rt_server_pick(): Pick and set the next RT task from the cgroup's
     rt_rq when the server gets CPU time

2) Server lifecycle management:
   - Start the dl-server when the first RT task enqueues to an idle
     rt-cgroup
   - Stop the dl-server when the last RT task dequeues from an rt-cgroup
   - Update the server's consumed runtime in update_curr_rt() via
     dl_server_update()

3) Per-cpu priority and nr_running accounting:
   - Only update rq->cpupri for the root rt_rq (not for cgroup rt_rqs)
     since cgroups are scheduled via their dl-server priority
   - For cgroup rt_rqs, update global nr_running only when the dl-server
     is active (not throttled), as the server acts as the runnable entity
   - Bulk update nr_running when the server starts/stops based on the
     rt_rq's current rt_nr_running count

The rt.parent field is removed as the new implementation doesn't use
hierarchical RT scheduling entities. Instead, tasks record their dl_rq
to track which dl-server manages them.
---

Which seems to correspond to what this patch does. If that's the case,
however, I wonder if we are maybe doing too many things at once?

> Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
> Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
> Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Co-developed-by: luca abeni <luca.abeni@santannapisa.it>
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> ---
>  kernel/sched/deadline.c | 16 ++++++---
>  kernel/sched/rt.c       | 79 ++++++++++++++++++++++++++++++++++++-----
>  kernel/sched/sched.h    |  3 +-
>  3 files changed, 85 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 754bfe231b4..1293b9a252b 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1869,9 +1869,13 @@ void inc_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
>  	u64 deadline = dl_se->deadline;
>  
>  	dl_rq->dl_nr_running++;
> -
> -	if (!dl_server(dl_se))
> +	if (!dl_server(dl_se)) {
>  		add_nr_running(rq_of_dl_rq(dl_rq), 1);
> +	} else if (dl_se != &rq_of_dl_rq(dl_rq)->fair_server) {

I fear this condition might get unwieldy with the addition of new
servers (e.g. sched_scx).

> +		struct rt_rq *rt_rq = &dl_se->my_q->rt;
> +
> +		add_nr_running(rq_of_dl_rq(dl_rq), rt_rq->rt_nr_running);
> +	}
>  
>  	inc_dl_deadline(dl_rq, deadline);
>  }
> @@ -1881,9 +1885,13 @@ void dec_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
>  {
>  	WARN_ON(!dl_rq->dl_nr_running);
>  	dl_rq->dl_nr_running--;
> -
> -	if (!dl_server(dl_se))
> +	if (!dl_server(dl_se)) {
>  		sub_nr_running(rq_of_dl_rq(dl_rq), 1);
> +	} else if (dl_se != &rq_of_dl_rq(dl_rq)->fair_server) {

Ditto.

> +		struct rt_rq *rt_rq = &dl_se->my_q->rt;
> +
> +		sub_nr_running(rq_of_dl_rq(dl_rq), rt_rq->rt_nr_running);
> +	}
>  
>  	dec_dl_deadline(dl_rq, dl_se->deadline);
>  }
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 3094f59d0c8..d9442f64c6b 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -144,14 +144,27 @@ void init_tg_rt_entry(struct task_group *tg, struct rq *served_rq,
>  	tg->dl_se[cpu] = dl_se;
>  }
>  
> +static struct task_struct *_pick_next_task_rt(struct rt_rq *rt_rq);
> +static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first);
> +
>  static bool rt_server_has_tasks(struct sched_dl_entity *dl_se)
>  {
> -	return false;
> +	return !!dl_se->my_q->rt.rt_nr_running;
>  }
>  
>  static struct task_struct *rt_server_pick(struct sched_dl_entity *dl_se)
>  {
> -	return NULL;
> +	struct rt_rq *rt_rq = &dl_se->my_q->rt;
> +	struct rq *rq = rq_of_rt_rq(rt_rq);
> +	struct task_struct *p;
> +
> +	if (dl_se->my_q->rt.rt_nr_running == 0)

Can't we use rt_server_has_tasks()?

> +		return NULL;
> +
> +	p = _pick_next_task_rt(rt_rq);
> +	set_next_task_rt(rq, p, true);
> +
> +	return p;

...

> @@ -953,9 +1011,14 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
>  	return next;
>  }
>  
> -static struct task_struct *_pick_next_task_rt(struct rq *rq)
> +static struct task_struct *_pick_next_task_rt(struct rt_rq *rt_rq)
>  {
> -	return NULL;
> +	struct sched_rt_entity *rt_se;
> +
> +	rt_se = pick_next_rt_entity(rt_rq);
> +	BUG_ON(!rt_se);

Can we WARN and recover somehow?

> +
> +	return rt_task_of(rt_se);
>  }
>  
>  static struct task_struct *pick_task_rt(struct rq *rq)
> @@ -965,7 +1028,7 @@ static struct task_struct *pick_task_rt(struct rq *rq)
>  	if (!sched_rt_runnable(rq))
>  		return NULL;
>  
> -	p = _pick_next_task_rt(rq);
> +	p = _pick_next_task_rt(&rq->rt);
>  
>  	return p;
>  }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 9853f321363..b2c87541257 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2170,7 +2170,7 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
>  	if (!rt_group_sched_enabled())
>  		tg = &root_task_group;
>  	p->rt.rt_rq  = tg->rt_rq[cpu];
> -	p->rt.parent = tg->rt_se[cpu];
> +	p->dl.dl_rq  = &cpu_rq(cpu)->dl;

Guess rt.parent is then removed in a subsequent patch? Do we want to
consolidate the cleanup?

>  #endif /* CONFIG_RT_GROUP_SCHED */
>  }
>  
> @@ -2726,6 +2726,7 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
>  
>  static inline void sub_nr_running(struct rq *rq, unsigned count)
>  {
> +	BUG_ON(rq->nr_running < count);

Can we WARN and recover somehow?

>  	rq->nr_running -= count;
>  	if (trace_sched_update_nr_running_tp_enabled()) {
>  		call_trace_sched_update_nr_running(rq, -count);

Thanks,
Juri


