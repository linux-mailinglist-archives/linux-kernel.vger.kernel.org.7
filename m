Return-Path: <linux-kernel+bounces-800656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE73B43A3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C3B3BF5CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F322FA0C7;
	Thu,  4 Sep 2025 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eSV3rtrM"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC602F617D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985459; cv=none; b=rX9miCu1LApS1NiOKhDy+HZ23tYFwUMCeBOTxsYajOe66zQcEv+cF5aW85Jhu/0pdPfIBngvPQ0HoVU/FxM3ZvYCUewPFG51LV6imizDeT2rSFFmFr/Gc83E7hIlHRRFPqMv53gkswnZ/9s2MrszdrJdykfKj8/TCIUNFO1r3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985459; c=relaxed/simple;
	bh=Hp9BDo08+ttjouqdhSm6RM9IRbBsVBQU3hXMzM5d7e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exNksXjtaGz7fItfLzjTL4AMH7yVU+ke1FlVUUCmwoZXENJ3wxucBDvwU2BD9WPylHmRAOWx+yFf2LkkRFrjnJbotp1wfGxWwDkUSIFB7oncIFgqSASBuOGbJDaM25tDFBt46+LmlVll7dQwoGfvCgtcvaL2rU/Wls4H7dP2sq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eSV3rtrM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-249406d5878so9951745ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 04:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756985457; x=1757590257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2wpehmCZuPhVMi3yNUgYoiWqJkgOsf1rJIADIvoHRns=;
        b=eSV3rtrMkZA7LhtnVe5s+RMfAGfsCZ7gBPkf5eT3MgaW4YmZN1NQjWNrQ0a9xXy1vS
         E+0XuhVuR9eWb2mz9L8HE4fszRlzWQjE2hiWjnRaLIZ5e/n4O6EHFhQlWiJRgsamRiPA
         6YEqwX8nisCLbcLcgFkDtEieii0DtsmYfTd+8NZKmNU9V2O9FilQFSeF97WmrNb+xOwA
         PwC+sZlTW9k2xkUo0C703njWJWd1Y4Js20CXva/Ytrx+4GCPkS+qLs/BQdx7vUe/hf7a
         8GH6mu9iXR67eZXAcGw/pyu14br757kRjlKF+Luu6+CVou3n4MtJr8+mFUW69rCy+JC0
         aT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756985457; x=1757590257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wpehmCZuPhVMi3yNUgYoiWqJkgOsf1rJIADIvoHRns=;
        b=ecQpdQ4xak7o3Hgvr+g2OySQV2e3zmwZ4J/EFFXrDPKNanTbwMSFlckI8d/DgyXNy0
         J2/EnR6zLbbPuvvj88eXblHkfRnGIzj7xpOxYRCo1mj509TAn5kFrmI71fnyhSGPuhnp
         +0lsjW/yqW03c+VcYPBb0hEXOnYa4g8Xqnz5aTLfNVHxSnOY3DqeHA9bENP11Pq7aqLJ
         JSpRA/qwU9tL1EUXEWBiIgceb/RONBOyVx25BGxKWnenZXzzOeLuBTZk3NnOqoQHebeP
         aJYBy7EJKxiyMGJs2o5XebXuVZW9uN2BoDC/vAnILWgcZFgvzQ80GQsAA1hHhqAtZ0Gx
         uarA==
X-Forwarded-Encrypted: i=1; AJvYcCVmNNvsLm0lHnIMnKa870LMmh5PNmj0hFSZv/jb9oGdnf2BuW+v0TXiwRSEYAiS57jIOWpJpDuksUbsgyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT0bNEi2Jv6/Wd+X4uVde92GCpBOdi6OMqaYU36myZ0l7AXud5
	4+b/pd9GFn+vDX24rK95NCB+pipyZodyw8TondHbqxVVjMJa7l3SEEv1IAR6uLxtZg==
X-Gm-Gg: ASbGncu5Pw3vYeduGlhVdP3gz79hqsGVou9q28Nxc9HTDwrO0xjSaP2RJ4ZOFMOsrKY
	ZDFrGbGXIG6YTOqIcdN4Epiyf/fIWYcvIR7IiCohWKVUcjVJCXIp8vnzaTohHfX+CQTnsyroPib
	qWSHp5sXqBcVQQ5nS3/7RPCDbbhmi2hk2F3bVrzHMVJAPNCAUKMGDkOEtHnITTjjeW1WgOxFH3O
	rmo3IPnmOihAgxfXj2Wq0Fp6gmV2ii6S4ovdhtXCoXo3+8ustD7sDncQXhgiKhSbW0eiuQu857t
	6d0RcMOryPf1FV3kDfOwf0X0r7jUD960suzKnqND9RjWLxLmAx/+qi+HfqwWdShzzSpswSgjuL+
	LdhlFRjPF5sFuYdhN+/QbbxL813JNZtyLX+y1fRUSpXrrWfHHJl5AEGD/vExq
X-Google-Smtp-Source: AGHT+IEpg2qRwwbYVHn2CXlndjE4SjY1ah3J+t0Cq+9ilg7JkQLLAI+QPnGQf+vNl2uwWzzkYp16vw==
X-Received: by 2002:a17:903:2cf:b0:248:9e56:e806 with SMTP id d9443c01a7336-24944870a36mr280342425ad.12.1756985456857;
        Thu, 04 Sep 2025 04:30:56 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906390e6bsm188203085ad.96.2025.09.04.04.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 04:30:56 -0700 (PDT)
Date: Thu, 4 Sep 2025 19:30:45 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Benjamin Segall <bsegall@google.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
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
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250904113045.GI42@bytedance>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
 <20250829081120.806-4-ziqianlu@bytedance.com>
 <xm26jz2ftfw7.fsf@google.com>
 <20250904112610.GH42@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904112610.GH42@bytedance>

On Thu, Sep 04, 2025 at 07:26:10PM +0800, Aaron Lu wrote:
> On Wed, Sep 03, 2025 at 01:55:36PM -0700, Benjamin Segall wrote:
> > Aaron Lu <ziqianlu@bytedance.com> writes:
> > 
> > > +static bool enqueue_throttled_task(struct task_struct *p)
> > > +{
> > > +	struct cfs_rq *cfs_rq = cfs_rq_of(&p->se);
> > > +
> > > +	/* @p should have gone through dequeue_throttled_task() first */
> > > +	WARN_ON_ONCE(!list_empty(&p->throttle_node));
> > > +
> > > +	/*
> > > +	 * If the throttled task @p is enqueued to a throttled cfs_rq,
> > > +	 * take the fast path by directly putting the task on the
> > > +	 * target cfs_rq's limbo list.
> > > +	 *
> > > +	 * Do not do that when @p is current because the following race can
> > > +	 * cause @p's group_node to be incorectly re-insterted in its rq's
> > > +	 * cfs_tasks list, despite being throttled:
> > > +	 *
> > > +	 *     cpuX                       cpuY
> > > +	 *   p ret2user
> > > +	 *  throttle_cfs_rq_work()  sched_move_task(p)
> > > +	 *  LOCK task_rq_lock
> > > +	 *  dequeue_task_fair(p)
> > > +	 *  UNLOCK task_rq_lock
> > > +	 *                          LOCK task_rq_lock
> > > +	 *                          task_current_donor(p) == true
> > > +	 *                          task_on_rq_queued(p) == true
> > > +	 *                          dequeue_task(p)
> > > +	 *                          put_prev_task(p)
> > > +	 *                          sched_change_group()
> > > +	 *                          enqueue_task(p) -> p's new cfs_rq
> > > +	 *                                             is throttled, go
> > > +	 *                                             fast path and skip
> > > +	 *                                             actual enqueue
> > > +	 *                          set_next_task(p)
> > > +	 *                    list_move(&se->group_node, &rq->cfs_tasks); // bug
> > > +	 *  schedule()
> > > +	 *
> > > +	 * In the above race case, @p current cfs_rq is in the same rq as
> > > +	 * its previous cfs_rq because sched_move_task() only moves a task
> > > +	 * to a different group from the same rq, so we can use its current
> > > +	 * cfs_rq to derive rq and test if the task is current.
> > > +	 */
> > > +	if (throttled_hierarchy(cfs_rq) &&
> > > +	    !task_current_donor(rq_of(cfs_rq), p)) {
> > > +		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
> > > +		return true;
> > > +	}
> > > +
> > > +	/* we can't take the fast path, do an actual enqueue*/
> > > +	p->throttled = false;
> > > +	return false;
> > > +}
> > > +
> > 
> > Is there a reason that __set_next_task_fair cannot check p->se.on_rq as
> > well as (or instead of) task_on_rq_queued()? All of the _entity parts of
> > set_next/put_prev check se.on_rq for this sort of thing, so that seems
> > fairly standard. And se.on_rq should exactly match if the task is on
> > cfs_tasks since that add/remove is done in account_entity_{en,de}queue.
> 
> Makes sense to me.
> 
> Only thing that feels a little strange is, a throttled/dequeued task is
> set as next now. Maybe not a big deal. I booted a VM and run some tests,
> didn't notice anything wrong but I could very well miss some cases.

Sorry, I should have added: the above test was done with following diff:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cb93e74a850e8..7a6782617c0e8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5836,38 +5836,8 @@ static bool enqueue_throttled_task(struct task_struct *p)
 	 * If the throttled task @p is enqueued to a throttled cfs_rq,
 	 * take the fast path by directly putting the task on the
 	 * target cfs_rq's limbo list.
-	 *
-	 * Do not do that when @p is current because the following race can
-	 * cause @p's group_node to be incorectly re-insterted in its rq's
-	 * cfs_tasks list, despite being throttled:
-	 *
-	 *     cpuX                       cpuY
-	 *   p ret2user
-	 *  throttle_cfs_rq_work()  sched_move_task(p)
-	 *  LOCK task_rq_lock
-	 *  dequeue_task_fair(p)
-	 *  UNLOCK task_rq_lock
-	 *                          LOCK task_rq_lock
-	 *                          task_current_donor(p) == true
-	 *                          task_on_rq_queued(p) == true
-	 *                          dequeue_task(p)
-	 *                          put_prev_task(p)
-	 *                          sched_change_group()
-	 *                          enqueue_task(p) -> p's new cfs_rq
-	 *                                             is throttled, go
-	 *                                             fast path and skip
-	 *                                             actual enqueue
-	 *                          set_next_task(p)
-	 *                    list_move(&se->group_node, &rq->cfs_tasks); // bug
-	 *  schedule()
-	 *
-	 * In the above race case, @p current cfs_rq is in the same rq as
-	 * its previous cfs_rq because sched_move_task() only moves a task
-	 * to a different group from the same rq, so we can use its current
-	 * cfs_rq to derive rq and test if the task is current.
 	 */
-	if (throttled_hierarchy(cfs_rq) &&
-	    !task_current_donor(rq_of(cfs_rq), p)) {
+	if (throttled_hierarchy(cfs_rq)) {
 		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
 		return true;
 	}
@@ -13256,7 +13226,7 @@ static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool firs
 {
 	struct sched_entity *se = &p->se;
 
-	if (task_on_rq_queued(p)) {
+	if (se->on_rq) {
 		/*
 		 * Move the next running task to the front of the list, so our
 		 * cfs_tasks list becomes MRU one.

