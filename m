Return-Path: <linux-kernel+bounces-800252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF01DB4355A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1550B18830EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFA823817E;
	Thu,  4 Sep 2025 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cg0TBEAe"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845422AE68
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973785; cv=none; b=q5O3+B+3zWh2NQstLPSZdL7ov3Muk3ek0MF28yUr89Ha2lLVygvwG1PExrmoy+R+XADvARZne2ohHFD8dUZJVxYlj/9zOewlx1dTxf6jSBU1sTrW+9KyPJI+UDSVSGQnR/Ffk/TOX+D3ULfwK5r/yZOyRGSVpWCcim2PYa8yQQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973785; c=relaxed/simple;
	bh=lEAo/i+3UCtQzxnQIa3OX2Jw6ExCPfTRbgK3vT4vdPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+pi6wxPitmUwvLPHfwpbyAcR3CnN/QvxXeTK9NeeDCqWXAh4fOVbKKiL4vx499aV4mBnQuiSZCKmrb+jUE7Ir+8fyCCiNf+1UiLFYp10Hyqilp6pnA60t8uTzzVMFZXjs1qXAdWq8cXw8IUnlH+LYVXrBdINJbAkVupFEmxT2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cg0TBEAe; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4f9d61e7deso461231a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756973783; x=1757578583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ADLLJPjcyHqMqFotpE8rqFKN/fEUykCZgiIgkTBpDE=;
        b=cg0TBEAeOWhVFEUURnCTKfzdpOWvniVT9JwxfLzP1LebAddY3lsxN60xJ8Xa3SyiRk
         q9T/idpgLORo62CXQNFdmVEvANgcQgKFdTYCmBEMQILASdLcLSXepapB9RvFT/Osd5Dy
         zyFN9d4dHMBtrkeswyH0ZD5c5YO/KrddLjFk3fYhKIv+YhHjAx5iQfjLoowutka6JAjS
         DVysAcyilAvFWomsMquyXH+oD+DjSseNJ8+yJd161gyDhTZShFdRXLP0K9bWQTlH+FuJ
         UyRcC4NxihSvCqptUcoX+1NAm2n+fpRG1PXQmQAOoAb3sl1SUBKm/xm2ZjZcjCrwh30v
         3yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756973783; x=1757578583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ADLLJPjcyHqMqFotpE8rqFKN/fEUykCZgiIgkTBpDE=;
        b=Tv12sF6kuk8pDUE1q+/HeAXASLh2AisTFj5ScISfsm1fDmoQWV8nzID/9jSUXv+L1k
         /sxwDx24thuusDzUyyJzqTOcNSuJZLhO9q5Un7OjwvTqBsdatbLGDnce+lj20t2HEMzX
         rnTgPAhEfzrKKEBpEBiGn/tajYS4vrBuJGXmylV6gDwS8rwq2KIYcD+V475uBkBJ53i+
         JL/Exy44Y+hId8w8t8OtcTgSG2CHrpMElS68s053nnEEdYFc+2mZIY+t9T1MSstKpdvK
         3uOY2bFy2jxl3DMSUaHtGzwUOUPhzKzUj7o7hiV2OoDe2dP0Kk7fI3TUen8+w6aFzpBO
         HFTw==
X-Forwarded-Encrypted: i=1; AJvYcCUT1EMu5ukFp6X8nzs0yDHn1C2Rpcb5/XYX2Fz3GF3yJMTsbchYmLVZhNTjFVFkbxSh409soz9x/ie6Wlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6n2Bjyow5BFc3bo46zywEfga0sf5k5uteOC7Y80BfqPzwM0Yc
	ZVNWDloPEkyaZ8G/lQrKkRolQKseS8AADq2dosdZItuhiTsIoAubKIlV7oA8NcoKPA==
X-Gm-Gg: ASbGncviqebmdGJxk7R3E6uSReiojCzFFSrUBzAMOCzdXAyVP1Sza/3eADFR6C+mpPW
	tmSvjKyMQGvoT6JhWdXBs/SdxGbp3KiepnY5SKuQOOKR1dhK6XlfS8tQVm6w+wZ6HmcMaMEAsSQ
	YtnT7VUxwyqHQvaV/G04twoiC3DpnClK7+MXUM7Mek4nN6Su2Aq/vXbD8kyrC+v9E8332rzkVya
	hm7we899DJ0/0g4QoCGeD7/RWkXako5VjRwZfUCNmpfj8OzVKGJFPduacO8YrpIVK1qgRDt8Zl+
	ugo0hOdZH8J40L9blGb+lgp7cuTHJFxabW4mV9oFJAJzyvxPPrA3/cedG5HSlcqrjmoDWBPiiZW
	QTfpjzfdjv1WGFOPyx1Z7SgNcVxCJhEHwKqB256yw9YeRULHlmw==
X-Google-Smtp-Source: AGHT+IG31mZwNCOcdnsyBIHLSET1LHfkzf8HUmPQ3hOewg/SGDXYr3rw24rtaKmNjAbwfDspCWCIKg==
X-Received: by 2002:a17:902:ecc1:b0:24c:b54e:bf0a with SMTP id d9443c01a7336-24cb54ec1c4mr40210455ad.0.1756973782487;
        Thu, 04 Sep 2025 01:16:22 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903702396sm183459885ad.14.2025.09.04.01.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 01:16:21 -0700 (PDT)
Date: Thu, 4 Sep 2025 16:16:11 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Benjamin Segall <bsegall@google.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
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
	Michal Koutn?? <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250904081611.GE42@bytedance>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
 <20250829081120.806-4-ziqianlu@bytedance.com>
 <20250903145124.GM4067720@noisy.programming.kicks-ass.net>
 <14be66aa-e088-4267-ac10-d04d600b1294@amd.com>
 <xm26o6rrtgav.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26o6rrtgav.fsf@google.com>

On Wed, Sep 03, 2025 at 01:46:48PM -0700, Benjamin Segall wrote:
> K Prateek Nayak <kprateek.nayak@amd.com> writes:
> 
> > Hello Peter,
> >
> > On 9/3/2025 8:21 PM, Peter Zijlstra wrote:
> >>>  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >>>  {
> >>> +	if (task_is_throttled(p)) {
> >>> +		dequeue_throttled_task(p, flags);
> >>> +		return true;
> >>> +	}
> >>> +
> >>>  	if (!p->se.sched_delayed)
> >>>  		util_est_dequeue(&rq->cfs, p);
> >>>  
> >> 
> >> OK, so this makes it so that either a task is fully enqueued (all
> >> cfs_rq's) or full not. A group cfs_rq is only marked throttled when all
> >> its tasks are gone, and unthrottled when a task gets added. Right?
> >
> > cfs_rq (and the hierarchy below) is marked throttled when the quota
> > has elapsed. Tasks on the throttled hierarchies will dequeue
> > themselves completely via task work added during pick. When the last
> > task leaves on a cfs_rq of throttled hierarchy, PELT is frozen for
> > that cfs_rq.
> >
> > When a new task is added on the hierarchy, the PELT is unfrozen and
> > the task becomes runnable. The cfs_rq and the hierarchy is still
> > marked throttled.
> >
> > Unthrottling of hierarchy is only done at distribution.
> >
> >> 
> >> But propagate_entity_cfs_rq() is still doing the old thing, and has a
> >> if (cfs_rq_throttled(cfs_rq)) break; inside the for_each_sched_entity()
> >> iteration.
> >> 
> >> This seems somewhat inconsistent; or am I missing something ? 
> >
> > Probably an oversight. But before that, what was the reason to have
> > stopped this propagation at throttled_cfs_rq() before the changes?
> >
> 
> Yeah, this was one of the things I was (slowly) looking at - with this
> series we currently still abort in:
> 
> 1) update_cfs_group
> 2) dequeue_entities's set_next_buddy
> 3) check_preempt_fair
> 4) yield_to
> 5) propagate_entity_cfs_rq
> 
> In the old design on throttle immediately remove the entire cfs_rq,
> freeze time for it, and stop adjusting load. In the new design we still
> pick from it, so we definitely don't want to stop time (and don't). I'm
> guessing we probably also want to now adjust load for it, but it is
> arguable - since all the cfs_rqs for the tg are likely to throttle at the
> same time, so we might not want to mess with the shares distribution,
> since when unthrottle comes around the most likely correct distribution
> is the distribution we had at the time of throttle.
>

I can give it a test to see how things change by adjusting load and share
distribution using my previous performance tests.

> Assuming we do want to adjust load for a throttle then we probably want
> to remove the aborts from update_cfs_group and propagate_entity_cfs_rq.
> I'm guessing that we need the list_add_leaf_cfs_rq from propagate, but
> I'm not 100% sure when they are actually doing something in propagate as
> opposed to enqueue.
>

Yes, commit 0258bdfaff5bd("sched/fair: Fix unfairness caused by missing 
load decay") added that list_add_leaf_cfs_rq() in
propagate_entity_cfs_rq() to fix a problem.

> The other 3 are the same sort of thing - scheduling pick heuristics
> which imo are pretty arbitrary to keep. We can reasonably say that "the
> most likely thing a task in a throttled hierarchy will do is just go
> throttle itself, so we shouldn't buddy it or let it preempt", but it
> would also be reasonable to let them preempt/buddy normally, in case
> they hold locks or such.

I think we do not need to special case tasks in throttled hierarchy in
check_preempt_wakeup_fair().

> 
> yield_to is used by kvm and st-dma-fence-chain.c. Yielding to a
> throttle-on-exit kvm cpu thread isn't useful (so no need to remove the
> abort there). The dma code is just yielding to a just-spawned kthread,
> so it should be fine either way.

Get it.

The cumulated diff I'm going to experiment is below, let me know if
something is wrong, thanks.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3e927b9b7eeb6..c2e46b8e5e3d9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3957,9 +3957,6 @@ static void update_cfs_group(struct sched_entity *se)
 	if (!gcfs_rq || !gcfs_rq->load.weight)
 		return;
 
-	if (throttled_hierarchy(gcfs_rq))
-		return;
-
 	shares = calc_group_shares(gcfs_rq);
 	if (unlikely(se->load.weight != shares))
 		reweight_entity(cfs_rq_of(se), se, shares);
@@ -5234,6 +5231,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
+static inline int cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq);
 
 static void
 requeue_delayed_entity(struct sched_entity *se);
@@ -5729,6 +5727,11 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 	return cfs_bandwidth_used() && cfs_rq->throttled;
 }
 
+static inline int cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
+{
+	return cfs_bandwidth_used() && cfs_rq->pelt_clock_throttled;
+}
+
 /* check whether cfs_rq, or any parent, is throttled */
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 {
@@ -6721,6 +6724,11 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 	return 0;
 }
 
+static inline int cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
+{
+	return 0;
+}
+
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 {
 	return 0;
@@ -7074,7 +7082,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			 * Bias pick_next to pick a task from this cfs_rq, as
 			 * p is sleeping when it is within its sched_slice.
 			 */
-			if (task_sleep && se && !throttled_hierarchy(cfs_rq))
+			if (task_sleep && se)
 				set_next_buddy(se);
 			break;
 		}
@@ -8722,15 +8730,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (unlikely(se == pse))
 		return;
 
-	/*
-	 * This is possible from callers such as attach_tasks(), in which we
-	 * unconditionally wakeup_preempt() after an enqueue (which may have
-	 * lead to a throttle).  This both saves work and prevents false
-	 * next-buddy nomination below.
-	 */
-	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
-		return;
-
 	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
 		set_next_buddy(pse);
 	}
@@ -13154,10 +13153,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-	if (cfs_rq_throttled(cfs_rq))
-		return;
-
-	if (!throttled_hierarchy(cfs_rq))
+	if (!cfs_rq_pelt_clock_throttled(cfs_rq))
 		list_add_leaf_cfs_rq(cfs_rq);
 
 	/* Start to propagate at parent */
@@ -13168,10 +13164,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 
-		if (cfs_rq_throttled(cfs_rq))
-			break;
-
-		if (!throttled_hierarchy(cfs_rq))
+		if (!cfs_rq_pelt_clock_throttled(cfs_rq))
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 }
-- 
2.39.5


