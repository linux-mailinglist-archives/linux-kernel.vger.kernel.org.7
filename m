Return-Path: <linux-kernel+bounces-759995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F107B1E567
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DB96267EF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519EE268C73;
	Fri,  8 Aug 2025 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrOGEREN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3381E008B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644380; cv=none; b=oVZtH+AF7ApV9RleVoiZXZRcyY/1kSEba/5Zv+YYlLX+mHD4vWa+j9/7t1MjC4JcOR9texTckLJ3KlHesHbCvithE8W9iYvYLhfCVL97lji/6uzJlmDcqdN6TpTPogm7d9ckaAaNnHTQZ2/r/KY/hmXo/clxAcVR/M+rzI28+Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644380; c=relaxed/simple;
	bh=3pcy8nVGUKCoYRSYLcERVNt16fR+vrhQyWJ+T5G5wMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FlgqOoGNrvj/Oq2F/0c/py1oPsoSntwUolNjQKjpcUdVCuefH24KYEH3sR5Lr7hDwdn7fmMjxkkA9m4oFmbFgCcNFhK1/N8AzKqvuEOfxUfZkh6P2dNrVb5Q1PPm9KuAcFEmYMDYAVNqyim7pmcmVPgRTn8Mu44J/ySvh6FN0aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IrOGEREN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754644377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V5dsEmpLVKpu1BUFhYJ0hVqi6LHrYzocxh5eNR1ls7c=;
	b=IrOGERENLf4MCp3X+jLFp6FNKAGLiTY2UTzr1phUSluHOgeSIQeB605EDTl5Pe28o3Xvw9
	/Y6G77tUlfRV3KruL5FXIl2v8mGE4+1dOdJAMzHdSF/f9+/SmFwIEbgk5NKVfym/aiJcoq
	X5XigjIoUfuRk1+uiUqnk2+rb8FXUdI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-Hngqn4mrOn6aLpZiyU6x5Q-1; Fri, 08 Aug 2025 05:12:55 -0400
X-MC-Unique: Hngqn4mrOn6aLpZiyU6x5Q-1
X-Mimecast-MFC-AGG-ID: Hngqn4mrOn6aLpZiyU6x5Q_1754644375
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e7ffcbce80so417361885a.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 02:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754644375; x=1755249175;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5dsEmpLVKpu1BUFhYJ0hVqi6LHrYzocxh5eNR1ls7c=;
        b=nVydiSMawCQq+aAjzO2t7k+oopm7PbNB6UBSxGEe9vttp1UzDKQ2PgCoL93sA2boIi
         TrME1mV1it0GrcqMHCfO5c5iGZPo1pKG3MzVofkgAd+8ru2Fob2jj+CShoZ++aF01eQM
         yj6xIKPZDTeKwr4kjc+mT+7zS/j/2fVBknsl10xmin/nlzINh68tlOC7j0JGrxtoAuFx
         nk38pE+Oefip8pPfJ5dEIIUPK7r+gxCswz3xwKic6W+zdFG+ck2jvoZurYclLUJyTxd8
         xoi0WuHJXaXVdp0teX2dEW/hmO7RaO68fzDMmXtoBXQqqoPB/cvFI7sH1zXuva8h8Ipq
         MZlg==
X-Gm-Message-State: AOJu0Yz9F7h6gSyqZP5GecHTc6y9HQX9/0vXwgCKxhhXh5pGmwhcjL5S
	j45C2mHstLwmbixWZxiT0zZiFaI95umGZ0uzwLq1XXs58eWcnvaojSsHT611UfnBNB5BotKSbUK
	zDWxNsQ15GvGPr6e9LfE+yeUWHVy9985D/kLXS3C9skF14wJULFQEbz5FZqlvpwZP1Q==
X-Gm-Gg: ASbGncubnnq2z4fgJepbci6+Qs8NTFBptSXMwxSd9qono3XNLbpNQvNFDNWSBwszXWL
	e0MEvUhIkQ36navGo7aoDakajGySzhdfqwehzyZDqfnMivq69hzOeZ4SsUS8zIbj/XD+jhvH3Ne
	X78TQpGz1rOpnG3v1IJXhfGvZ1fR7jKr4u9ZKKrq3BMS4JuTT87sb1ciNit65z/dSLosW6WqDw5
	gEfRmuJMIdHQQRZ/H+tEKQGkAwbXwmTaWWOEjWH7vf0szBruiZhzJ0VouFhbQZkKHMf32CChkEE
	c+CCvC4C8vBOdxLVjxEi4FkWeL1khGq2R8N2eHDT2BEExiOBKResmdqJe/dpktpLnOXe5qu2d+p
	LlQ==
X-Received: by 2002:a05:622a:180b:b0:4b0:8c29:f6e1 with SMTP id d75a77b69052e-4b0aec596d0mr43231851cf.7.1754644374972;
        Fri, 08 Aug 2025 02:12:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaa9e6T7Eka0zdRLX+WCet63ibmu7UgiCTwbRLavIRqrYcLN0wecQJXc6Ic2/7Utq3NRAOww==
X-Received: by 2002:a05:622a:180b:b0:4b0:8c29:f6e1 with SMTP id d75a77b69052e-4b0aec596d0mr43231411cf.7.1754644374427;
        Fri, 08 Aug 2025 02:12:54 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb ([2a04:cec0:107e:d29c:76ef:3842:1ccc:76b2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b09c11bf8bsm26277061cf.20.2025.08.08.02.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 02:12:53 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Aaron Lu <ziqianlu@bytedance.com>, Ben Segall <bsegall@google.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra
 <peterz@infradead.org>, Chengming Zhou <chengming.zhou@linux.dev>, Josh
 Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
 <zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>, Florian
 Bezdeka <florian.bezdeka@siemens.com>, Songtang Liu
 <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
In-Reply-To: <20250715071658.267-4-ziqianlu@bytedance.com>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-4-ziqianlu@bytedance.com>
Date: Fri, 08 Aug 2025 11:12:48 +0200
Message-ID: <xhsmhv7myp46n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 15/07/25 15:16, Aaron Lu wrote:
> From: Valentin Schneider <vschneid@redhat.com>
>
> In current throttle model, when a cfs_rq is throttled, its entity will
> be dequeued from cpu's rq, making tasks attached to it not able to run,
> thus achiveing the throttle target.
>
> This has a drawback though: assume a task is a reader of percpu_rwsem
> and is waiting. When it gets woken, it can not run till its task group's
> next period comes, which can be a relatively long time. Waiting writer
> will have to wait longer due to this and it also makes further reader
> build up and eventually trigger task hung.
>
> To improve this situation, change the throttle model to task based, i.e.
> when a cfs_rq is throttled, record its throttled status but do not remove
> it from cpu's rq. Instead, for tasks that belong to this cfs_rq, when
> they get picked, add a task work to them so that when they return
> to user, they can be dequeued there. In this way, tasks throttled will
> not hold any kernel resources. And on unthrottle, enqueue back those
> tasks so they can continue to run.
>

Moving the actual throttle work to pick time is clever. In my previous
versions I tried really hard to stay out of the enqueue/dequeue/pick paths,
but this makes the code a lot more palatable. I'd like to see how this
impacts performance though.

> Throttled cfs_rq's PELT clock is handled differently now: previously the
> cfs_rq's PELT clock is stopped once it entered throttled state but since
> now tasks(in kernel mode) can continue to run, change the behaviour to
> stop PELT clock only when the throttled cfs_rq has no tasks left.
>

I haven't spent much time looking at the PELT stuff yet; I'll do that next
week. Thanks for all the work you've been putting into this, and sorry it
got me this long to get a proper look at it!

> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Suggested-by: Chengming Zhou <chengming.zhou@linux.dev> # tag on pick
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>

> +static bool enqueue_throttled_task(struct task_struct *p)
> +{
> +	struct cfs_rq *cfs_rq = cfs_rq_of(&p->se);
> +
> +	/*
> +	 * If the throttled task is enqueued to a throttled cfs_rq,
> +	 * take the fast path by directly put the task on target
> +	 * cfs_rq's limbo list, except when p is current because
> +	 * the following race can cause p's group_node left in rq's
> +	 * cfs_tasks list when it's throttled:
> +	 *
> +	 *        cpuX                       cpuY
> +	 *   taskA ret2user
> +	 *  throttle_cfs_rq_work()    sched_move_task(taskA)
> +	 *  task_rq_lock acquired
> +	 *  dequeue_task_fair(taskA)
> +	 *  task_rq_lock released
> +	 *                            task_rq_lock acquired
> +	 *                            task_current_donor(taskA) == true
> +	 *                            task_on_rq_queued(taskA) == true
> +	 *                            dequeue_task(taskA)
> +	 *                            put_prev_task(taskA)
> +	 *                            sched_change_group()
> +	 *                            enqueue_task(taskA) -> taskA's new cfs_rq
> +	 *                                                   is throttled, go
> +	 *                                                   fast path and skip
> +	 *                                                   actual enqueue
> +	 *                            set_next_task(taskA)
> +	 *                          __set_next_task_fair(taskA)
> +	 *                    list_move(&se->group_node, &rq->cfs_tasks); // bug
> +	 *  schedule()
> +	 *
> +	 * And in the above race case, the task's current cfs_rq is in the same
> +	 * rq as its previous cfs_rq because sched_move_task() doesn't migrate
> +	 * task so we can use its current cfs_rq to derive rq and test if the
> +	 * task is current.
> +	 */

OK I think I got this; I slightly rephrased things to match similar
comments in the sched code:

--->8---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3a7c86c5b8a2b..8566ee0399527 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5827,37 +5827,38 @@ static bool enqueue_throttled_task(struct task_struct *p)
 	struct cfs_rq *cfs_rq = cfs_rq_of(&p->se);
 
 	/*
-	 * If the throttled task is enqueued to a throttled cfs_rq,
-	 * take the fast path by directly put the task on target
-	 * cfs_rq's limbo list, except when p is current because
-	 * the following race can cause p's group_node left in rq's
-	 * cfs_tasks list when it's throttled:
+	 * If the throttled task @p is enqueued to a throttled cfs_rq,
+	 * take the fast path by directly putting the task on the
+	 * target cfs_rq's limbo list.
+
+	 * Do not do that when @p is current because the following race can
+	 * cause @p's group_node to be incorectly re-insterted in its in rq's
+	 * cfs_tasks list, despite being throttled:
 	 *
 	 *        cpuX                       cpuY
-	 *   taskA ret2user
-	 *  throttle_cfs_rq_work()    sched_move_task(taskA)
-	 *  task_rq_lock acquired
-	 *  dequeue_task_fair(taskA)
-	 *  task_rq_lock released
-	 *                            task_rq_lock acquired
-	 *                            task_current_donor(taskA) == true
-	 *                            task_on_rq_queued(taskA) == true
-	 *                            dequeue_task(taskA)
-	 *                            put_prev_task(taskA)
-	 *                            sched_change_group()
-	 *                            enqueue_task(taskA) -> taskA's new cfs_rq
-	 *                                                   is throttled, go
-	 *                                                   fast path and skip
-	 *                                                   actual enqueue
-	 *                            set_next_task(taskA)
-	 *                          __set_next_task_fair(taskA)
-	 *                    list_move(&se->group_node, &rq->cfs_tasks); // bug
+	 *  p ret2user
+	 *    throttle_cfs_rq_work()  sched_move_task(p)
+	 *    LOCK task_rq_lock
+	 *    dequeue_task_fair(p)
+	 *    UNLOCK task_rq_lock
+	 *                              LOCK task_rq_lock
+	 *                              task_current_donor(p) == true
+	 *                              task_on_rq_queued(p) == true
+	 *                              dequeue_task(p)
+	 *                              put_prev_task(p)
+	 *                              sched_change_group()
+	 *                              enqueue_task(p) -> p's new cfs_rq
+	 *                                                 is throttled, go
+	 *                                                 fast path and skip
+	 *                                                 actual enqueue
+	 *                              set_next_task(p)
+	 *                                list_move(&se->group_node, &rq->cfs_tasks); // bug
 	 *  schedule()
 	 *
-	 * And in the above race case, the task's current cfs_rq is in the same
-	 * rq as its previous cfs_rq because sched_move_task() doesn't migrate
-	 * task so we can use its current cfs_rq to derive rq and test if the
-	 * task is current.
+	 * In the above race case, @p current cfs_rq is in the same
+	 * rq as its previous cfs_rq because sched_move_task() only moves a task
+	 * to a different group from the same rq, so we can use its current
+	 * cfs_rq to derive rq and test if the * task is current.
 	 */
 	if (throttled_hierarchy(cfs_rq) &&
 	    !task_current_donor(rq_of(cfs_rq), p)) {
---8<---

> +	if (throttled_hierarchy(cfs_rq) &&
> +	    !task_current_donor(rq_of(cfs_rq), p)) {
> +		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
> +		return true;
> +	}
> +
> +	/* we can't take the fast path, do an actual enqueue*/
> +	p->throttled = false;

So we clear p->throttled but not p->throttle_node? Won't that cause issues
when @p's previous cfs_rq gets unthrottled?

> +	return false;
> +}
> +

> @@ -7145,6 +7142,11 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>   */
>  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  {
> +	if (unlikely(task_is_throttled(p))) {
> +		dequeue_throttled_task(p, flags);
> +		return true;
> +	}
> +

Handling a throttled task's move pattern at dequeue does simplify things,
however that's quite a hot path. I think this wants at the very least a

  if (cfs_bandwidth_used())

since that has a static key underneath. Some heavy EQ/DQ benchmark wouldn't
hurt, but we can probably find some people who really care about that to
run it for us ;)

>  	if (!p->se.sched_delayed)
>  		util_est_dequeue(&rq->cfs, p);
>  


