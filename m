Return-Path: <linux-kernel+bounces-760086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A66B1E649
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D565C18996DF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492042749C0;
	Fri,  8 Aug 2025 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PizlP/8d"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3260E27466D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754648038; cv=none; b=Jx/1EG2Ke4rcSkvpaTaQe5YrU8B8ScZ10E6yUoVhO2OguXkGl4B1Mld67/FsxI5SEaG1Wyneko8XIklr4ULaeSfkH32e3c6Xm7Fe0M7v2MINRvmDc/3H+0WaGkKPk9X01I3KIUIrEQfhkt5dh/mMvsigpQyQx1xnVT8XxKtx4Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754648038; c=relaxed/simple;
	bh=CT5uKBplR8Fx97PYW0K6EMnv04+79EodmPFrpoehyPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkUJ55U7Ss98ozhiXTPkjASXWS4ys+weIZOQPWgcqBYcZcACqARYxTcNyqZ7BK/NPBXGZJPXJSez71bLp0lllcyDcqvAWOWL8IUdL2qRJzQYw4936D6zY3zgdcFGqYD469q4deBzPdpORshOcXZXnvIW/eFmBOT+qkUIcLf45Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PizlP/8d; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b423b13e2c3so1485090a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 03:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754648035; x=1755252835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H6w7Q+X7KMIFjgnGmMmusOPLy4cippV/zV2BqSjFLeY=;
        b=PizlP/8doJwrF9sUyKGo6U6nKFmw+DXsCLTziWwJbFRXPJ+0AdCR+VDqzOhs90FCQO
         YtBXhKbtlz8jeBsNxeOWO9eqFiBfQyzixBNki1xHFAPrRyyUQ3Rm57mkhiWf5T4cqpm8
         HLBqbLWe2wz+SNfB8JFvfvoE6hV4nAdKHSJqRBiJtcQKJIbffxhY82+GWEzSkBRwXfEL
         /NkZpI2MdLKAuUTGCtmIjxhbT+nXF2Esg4vYHiHSy6bPX3IBG6Q4yLk1flPuZ5IHKd8s
         iGrzUPz4/U3StTqttDfng9guLaReQsVZNG2AyFJqK2kGceMr2DgJdrMP3OqGQhK9xj+n
         7GXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754648035; x=1755252835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6w7Q+X7KMIFjgnGmMmusOPLy4cippV/zV2BqSjFLeY=;
        b=pIMhg44U7JfKYkm2EUYPoet46qaA+RA9SWClX/8SKEg6yKwbxyPbaf8QPR+/TIqzfh
         lSIlLBYIq+mOaYGLSQZ0vEUxwr3Qh8zEcaY98gpHAeEOIE47t88wlj35PVb/GyHWI55d
         p0t+0B7yRVfqxCxLcKeK7HyudD8eM/r4pEk8rPljoiio7Ow9/sOimCGv35IS6BWV/oyd
         akT8za7DLzpHfTtOr2RmCLWsDCyTdC0w0LuSC5Tl4qMNFZbO1YTyXWy6Hien3XCDkowW
         kA5KZYHVu+4ao8j0+P28J2OBVKftRiy/zcl9GwFAbUwgMlc4zxT0hUlqgt+8Q6zSdlNU
         XjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHfzT6o++vclfeczTDv8s0biwCFDlhN7dPdtevyvZAV0iKyhN/lYueiTB3EeIWNDRxO/ugwtCVuxrDjYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOmPxEFryVM6Vk11JK4XvP70Wv4uB3cZJhgLbLqqy3cha/KNxq
	VqwLJF0gwfP8V9nIoCGU/JppQ7E0m5w9LTyEmdTwavk89B87l75yTKJwlYYSs93QLg==
X-Gm-Gg: ASbGnctaJ+PHTs9ZIVNbyJ/CNm0ZVdqfFuJ0qil0PCJFaOpuCX+JrnMqmMs1b5ra5Vg
	d60bt6DVVEtnvQOjKc1o7e1dTHmlMRwwRSSCHXRAuX/rdb16XK4xG3sj5LorqsC+uSbkn5PmfBo
	abt/3+hvTLBBRS72SkgP0F6s/wyMcADzN3nlQsvL4jO94GywiXTGMMbwGeG94e2GR6sERnPPB5x
	Qj+ow4KAvCZGKockfcJW1CJfcFldNMwWxPLCSA5xqDzXLKinT2aHbEsylPlerOYJwgXlUi7mw75
	MRwoP80XO8EKoEB6u72TVeVbupdzjgRyysMPh9nl3O5zBjxh+xOWLd+pu3sK1bELtU6nIETfaTx
	OM5z7a7B7KosiH98T73gboat3/OK55A5gbS194LL5TZk=
X-Google-Smtp-Source: AGHT+IFFgAJQvR5CsIxZq+2mS9NxGTCjlxDbPkVk6NrHqfc3VKotYsB4QNLDmIv76aaCdHIOG4KDHg==
X-Received: by 2002:a17:902:e74e:b0:240:8369:9b9d with SMTP id d9443c01a7336-242c1fdc961mr36999635ad.9.1754648035183;
        Fri, 08 Aug 2025 03:13:55 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bae2fe7sm17731021a12.44.2025.08.08.03.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 03:13:54 -0700 (PDT)
Date: Fri, 8 Aug 2025 18:13:30 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250808101330.GA75@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-4-ziqianlu@bytedance.com>
 <xhsmhv7myp46n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhv7myp46n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Fri, Aug 08, 2025 at 11:12:48AM +0200, Valentin Schneider wrote:
> On 15/07/25 15:16, Aaron Lu wrote:
> > From: Valentin Schneider <vschneid@redhat.com>
> >
> > In current throttle model, when a cfs_rq is throttled, its entity will
> > be dequeued from cpu's rq, making tasks attached to it not able to run,
> > thus achiveing the throttle target.
> >
> > This has a drawback though: assume a task is a reader of percpu_rwsem
> > and is waiting. When it gets woken, it can not run till its task group's
> > next period comes, which can be a relatively long time. Waiting writer
> > will have to wait longer due to this and it also makes further reader
> > build up and eventually trigger task hung.
> >
> > To improve this situation, change the throttle model to task based, i.e.
> > when a cfs_rq is throttled, record its throttled status but do not remove
> > it from cpu's rq. Instead, for tasks that belong to this cfs_rq, when
> > they get picked, add a task work to them so that when they return
> > to user, they can be dequeued there. In this way, tasks throttled will
> > not hold any kernel resources. And on unthrottle, enqueue back those
> > tasks so they can continue to run.
> >
> 
> Moving the actual throttle work to pick time is clever. In my previous
> versions I tried really hard to stay out of the enqueue/dequeue/pick paths,
> but this makes the code a lot more palatable. I'd like to see how this
> impacts performance though.
> 

Let me run some scheduler benchmark to see how it impacts performance.

I'm thinking maybe running something like hackbench on server platforms,
first with quota not set and see if performance changes; then also test
with quota set and see how performance changes.

Does this sound good to you? Or do you have any specific benchmark and
test methodology in mind?

> > Throttled cfs_rq's PELT clock is handled differently now: previously the
> > cfs_rq's PELT clock is stopped once it entered throttled state but since
> > now tasks(in kernel mode) can continue to run, change the behaviour to
> > stop PELT clock only when the throttled cfs_rq has no tasks left.
> >
> 
> I haven't spent much time looking at the PELT stuff yet; I'll do that next
> week. Thanks for all the work you've been putting into this, and sorry it
> got me this long to get a proper look at it!
> 

Never mind and thanks for taking a look now :)

> > Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > Suggested-by: Chengming Zhou <chengming.zhou@linux.dev> # tag on pick
> > Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> > Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> 
> > +static bool enqueue_throttled_task(struct task_struct *p)
> > +{
> > +	struct cfs_rq *cfs_rq = cfs_rq_of(&p->se);
> > +
> > +	/*
> > +	 * If the throttled task is enqueued to a throttled cfs_rq,
> > +	 * take the fast path by directly put the task on target
> > +	 * cfs_rq's limbo list, except when p is current because
> > +	 * the following race can cause p's group_node left in rq's
> > +	 * cfs_tasks list when it's throttled:
> > +	 *
> > +	 *        cpuX                       cpuY
> > +	 *   taskA ret2user
> > +	 *  throttle_cfs_rq_work()    sched_move_task(taskA)
> > +	 *  task_rq_lock acquired
> > +	 *  dequeue_task_fair(taskA)
> > +	 *  task_rq_lock released
> > +	 *                            task_rq_lock acquired
> > +	 *                            task_current_donor(taskA) == true
> > +	 *                            task_on_rq_queued(taskA) == true
> > +	 *                            dequeue_task(taskA)
> > +	 *                            put_prev_task(taskA)
> > +	 *                            sched_change_group()
> > +	 *                            enqueue_task(taskA) -> taskA's new cfs_rq
> > +	 *                                                   is throttled, go
> > +	 *                                                   fast path and skip
> > +	 *                                                   actual enqueue
> > +	 *                            set_next_task(taskA)
> > +	 *                          __set_next_task_fair(taskA)
> > +	 *                    list_move(&se->group_node, &rq->cfs_tasks); // bug
> > +	 *  schedule()
> > +	 *
> > +	 * And in the above race case, the task's current cfs_rq is in the same
> > +	 * rq as its previous cfs_rq because sched_move_task() doesn't migrate
> > +	 * task so we can use its current cfs_rq to derive rq and test if the
> > +	 * task is current.
> > +	 */
> 
> OK I think I got this; I slightly rephrased things to match similar
> comments in the sched code:
> 
> --->8---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3a7c86c5b8a2b..8566ee0399527 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5827,37 +5827,38 @@ static bool enqueue_throttled_task(struct task_struct *p)
>  	struct cfs_rq *cfs_rq = cfs_rq_of(&p->se);
>  
>  	/*
> -	 * If the throttled task is enqueued to a throttled cfs_rq,
> -	 * take the fast path by directly put the task on target
> -	 * cfs_rq's limbo list, except when p is current because
> -	 * the following race can cause p's group_node left in rq's
> -	 * cfs_tasks list when it's throttled:
> +	 * If the throttled task @p is enqueued to a throttled cfs_rq,
> +	 * take the fast path by directly putting the task on the
> +	 * target cfs_rq's limbo list.
> +
> +	 * Do not do that when @p is current because the following race can
> +	 * cause @p's group_node to be incorectly re-insterted in its in rq's
> +	 * cfs_tasks list, despite being throttled:
>  	 *
>  	 *        cpuX                       cpuY
> -	 *   taskA ret2user
> -	 *  throttle_cfs_rq_work()    sched_move_task(taskA)
> -	 *  task_rq_lock acquired
> -	 *  dequeue_task_fair(taskA)
> -	 *  task_rq_lock released
> -	 *                            task_rq_lock acquired
> -	 *                            task_current_donor(taskA) == true
> -	 *                            task_on_rq_queued(taskA) == true
> -	 *                            dequeue_task(taskA)
> -	 *                            put_prev_task(taskA)
> -	 *                            sched_change_group()
> -	 *                            enqueue_task(taskA) -> taskA's new cfs_rq
> -	 *                                                   is throttled, go
> -	 *                                                   fast path and skip
> -	 *                                                   actual enqueue
> -	 *                            set_next_task(taskA)
> -	 *                          __set_next_task_fair(taskA)
> -	 *                    list_move(&se->group_node, &rq->cfs_tasks); // bug
> +	 *  p ret2user
> +	 *    throttle_cfs_rq_work()  sched_move_task(p)
> +	 *    LOCK task_rq_lock
> +	 *    dequeue_task_fair(p)
> +	 *    UNLOCK task_rq_lock
> +	 *                              LOCK task_rq_lock
> +	 *                              task_current_donor(p) == true
> +	 *                              task_on_rq_queued(p) == true
> +	 *                              dequeue_task(p)
> +	 *                              put_prev_task(p)
> +	 *                              sched_change_group()
> +	 *                              enqueue_task(p) -> p's new cfs_rq
> +	 *                                                 is throttled, go
> +	 *                                                 fast path and skip
> +	 *                                                 actual enqueue
> +	 *                              set_next_task(p)
> +	 *                                list_move(&se->group_node, &rq->cfs_tasks); // bug
>  	 *  schedule()
>  	 *
> -	 * And in the above race case, the task's current cfs_rq is in the same
> -	 * rq as its previous cfs_rq because sched_move_task() doesn't migrate
> -	 * task so we can use its current cfs_rq to derive rq and test if the
> -	 * task is current.
> +	 * In the above race case, @p current cfs_rq is in the same
> +	 * rq as its previous cfs_rq because sched_move_task() only moves a task
> +	 * to a different group from the same rq, so we can use its current
> +	 * cfs_rq to derive rq and test if the * task is current.
>  	 */
>  	if (throttled_hierarchy(cfs_rq) &&
>  	    !task_current_donor(rq_of(cfs_rq), p)) {
> ---8<---
>

Will follow your suggestion in next version.

> > +	if (throttled_hierarchy(cfs_rq) &&
> > +	    !task_current_donor(rq_of(cfs_rq), p)) {
> > +		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
> > +		return true;
> > +	}
> > +
> > +	/* we can't take the fast path, do an actual enqueue*/
> > +	p->throttled = false;
> 
> So we clear p->throttled but not p->throttle_node? Won't that cause issues
> when @p's previous cfs_rq gets unthrottled?
> 

p->throttle_node is already removed from its previous cfs_rq at dequeue
time in dequeue_throttled_task().

This is done so because in enqueue time, we may not hold its previous
rq's lock so can't touch its previous cfs_rq's limbo list, like when
dealing with affinity changes.

> > +	return false;
> > +}
> > +
> 
> > @@ -7145,6 +7142,11 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
> >   */
> >  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  {
> > +	if (unlikely(task_is_throttled(p))) {
> > +		dequeue_throttled_task(p, flags);
> > +		return true;
> > +	}
> > +
> 
> Handling a throttled task's move pattern at dequeue does simplify things,
> however that's quite a hot path. I think this wants at the very least a
> 
>   if (cfs_bandwidth_used())
> 
> since that has a static key underneath. Some heavy EQ/DQ benchmark wouldn't
> hurt, but we can probably find some people who really care about that to
> run it for us ;)
> 

No problem.

I'm thinking maybe I can add this cfs_bandwidth_used() in
task_is_throttled()? So that other callsites of task_is_throttled() can
also get the benefit of paying less cost when cfs bandwidth is not
enabled.

> >  	if (!p->se.sched_delayed)
> >  		util_est_dequeue(&rq->cfs, p);
> >  
> 

