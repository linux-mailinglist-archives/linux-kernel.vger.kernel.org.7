Return-Path: <linux-kernel+bounces-833843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C90BA3317
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454EE16EFF8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A5826C391;
	Fri, 26 Sep 2025 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ar88Xfdv"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C5829B8CF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879492; cv=none; b=bLZyxx+X8WG54HBtjAahuP0kECq72P8CHfPQf3pSpM/AQzIIn2ZEWr2+KORxu5e5iNJJcQHUpMt0wi461xPg7JWVN3DO6EBsHT2/qzC8dmyCUzv21rTl4ZvqGaosSpLLKuJZNpPg+lKfYwuxN7wM3RjmRyGSloLmhqtlo+QdXYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879492; c=relaxed/simple;
	bh=p0+qKG09QTuUs+lJdSX0sz2V9tpuU9a8sW4ZzbE42ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jddRgoJ+7Jlng6cY6i9aBo3N47DaL/JY0LWPNsj9kGSnF35EjZawqt3Uac3LW3vx/9tKwPO1PVul8R1+elz7lhwHdjxJ6fApoR+MgYG2vNW8j6INXPMwxYiY0k2saYppGWgzH6+rrYUq3wzNCA3/+EGlajr4fS41Gucb9wOkRjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ar88Xfdv; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b556b3501easo1718447a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758879490; x=1759484290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=319Aaa2ClsYBmOGjJYnvX/xavv/h+b/5/KtENbr9Jp8=;
        b=Ar88XfdvDVhAnHSnXOpqUgn83wyYFRuba5V5KyssaF1cGPP1HkusYEtxif8lzu0KhP
         crnvU7ykPnWkBb1luKq+N1ydo6iuyco3gK4cnGSumrEKgHJhog025Ymli9SjWNkYI2iy
         h4ld+z6aTJJEuV94/lDni3vFZXNyeeVaKJ0//yB76+hewr1IdvOTjS1rbjGt419yTkrw
         cPBOKWRddpnUnXf/E3u8yH5Fdw65rx1yWDdiWqNOhw2L6w0Mbcs/lhGT33OhHWfhUcdU
         BnjVNRBt06ZeMM7qhoDoEDBpR8LRkbYdVU3+nK0Fvv7qME4e6/0qHZtDBknsulgRwnAB
         S6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879490; x=1759484290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=319Aaa2ClsYBmOGjJYnvX/xavv/h+b/5/KtENbr9Jp8=;
        b=qHqOe/vzUHe4BBopThSV9qlGw9jqgGOjpezGV/OWsRZjhOi1ppQjypFB5clvd7TXzE
         w0c9VaOqJfAMCp1rIRv9PYWZEwcQaSsCzIVt79dBwHe3ySpXwfA6Kbz7M6V11Gxjlyqg
         vqyqEOSq63GGocttWJY5rSwN2nvc9MNGKIQGR89zv4XdSumouB6rlvwb5o7pnKhnhZTC
         SWAwWnA97Z06V04PGvSCru6NJnY6YZnq6SLjAIb6jCTV8aZau5uvvt4V8oGIVMCcMo9z
         DeyJCDIPjVEZYHlu8mJmmoPL64EJMnkbJPEVvh1I10VXp8+3GjnP2Eks/dTtfQ+7RuWO
         m8Dw==
X-Forwarded-Encrypted: i=1; AJvYcCV8ebnIQyipZdyWZSmH89AEzsqyUakcmo4HuK8akxSILV9S/GnmduCVORFlcADAhd2hCHgWw8Al5Qiwkr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9HsY4IDkeAdMCaDVKLY+k3CWcTdTXnDHSWUpIdauGRZ6aeSs4
	Hm52U/wmRuB5SLM+L4Rhy3PpXe4vGjxhDyT5yhrQlGaF2HEL2ehyg11IZN4LoUgXxA==
X-Gm-Gg: ASbGnct+KSemZkHVQmIbh7OX+JFwJPI3ZXF2nDemA/FvKiZ2zyWltm5QVpC9LDaV8pu
	RdBqT8dUPOBCS0rVt91kk2xVgrwjUA5lKy8Dh+15IibyvGHn7J962Gt3PVi5KBveUiJG5c6mEKY
	ApqLDGdrZqWelyn/MPxi+E9ouLwBjl+PHH2+mzkg0rMroN1YG1LVPCoCkNBNYKk6Ln18Jc2uCdr
	YnV86992SUpxlHgpcsMksmG3dr+Aiy0T3eriyvM7A71cdBgPklDhpXauepEyDxPKrhG9++5rhdO
	4IVng8zsTL1vn5Tg1MKKdiSNe6DDlc7GGAXuwSMPEIYnUupIe0ad6iOcVRmYqk1kniAS3sKrt3j
	9449QmsHLFFhctMlkU/+45qB/MhlfJK6sjExfrt3NGHOaDcJUQQ==
X-Google-Smtp-Source: AGHT+IHRbM4vO8CuqreACP8VtswVBHBHyqdG9EYejry2yf3znTIK8yfzElgJ69f60r+wZ+IbIG5CXw==
X-Received: by 2002:a05:6a21:329b:b0:2b1:c9dc:6da0 with SMTP id adf61e73a8af0-2e7d85a3e50mr8191693637.46.1758879490053;
        Fri, 26 Sep 2025 02:38:10 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810210c076sm3942671b3a.0.2025.09.26.02.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 02:38:09 -0700 (PDT)
Date: Fri, 26 Sep 2025 17:38:01 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched/fair: Start a cfs_rq on throttled hierarchy with
 PELT clock throttled
Message-ID: <20250926093801.GE120@bytedance>
References: <e2e558b863c929c5019264b2ddefd4c0@codethink.co.uk>
 <20250926081918.30488-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926081918.30488-1-kprateek.nayak@amd.com>

On Fri, Sep 26, 2025 at 08:19:17AM +0000, K Prateek Nayak wrote:
> Matteo reported hitting the assert_list_leaf_cfs_rq() warning from
> enqueue_task_fair() post commit fe8d238e646e ("sched/fair: Propagate
> load for throttled cfs_rq") which transitioned to using
> cfs_rq_pelt_clock_throttled() check for leaf cfs_rq insertions in
> propagate_entity_cfs_rq().
> 
> The "cfs_rq->pelt_clock_throttled" flag is used to indicate if the
> hierarchy has its PELT frozen. If a cfs_rq's PELT is marked frozen, all
> its descendants should have their PELT frozen too or weird things can
> happen as a result of children accumulating PELT signals when the
> parents have their PELT clock stopped.
> 
> Another side effect of this is the loss of integrity of the leaf cfs_rq
> list. As debugged by Aaron, consider the following hierarchy:
> 
>     root(#)
>    /    \
>   A(#)   B(*)
>          |
>          C <--- new cgroup
>          |
>          D <--- new cgroup
> 
>   # - Already on leaf cfs_rq list
>   * - Throttled with PELT frozen
> 
> The newly created cgroups don't have their "pelt_clock_throttled" signal
> synced with cgroup B. Next, the following series of events occur:
> 
> 1. online_fair_sched_group() for cgroup D will call
>    propagate_entity_cfs_rq(). (Same can happen if a throttled task is
>    moved to cgroup C and enqueue_task_fair() returns early.)
> 
>    propagate_entity_cfs_rq() adds the cfs_rq of cgroup C to
>    "rq->tmp_alone_branch" since its PELT clock is not marked throttled
>    and cfs_rq of cgroup B is not on the list.
> 
>    cfs_rq of cgroup B is skipped since its PELT is throttled.
> 
>    root cfs_rq already exists on cfs_rq leading to
>    list_add_leaf_cfs_rq() returning early.
> 
>    The cfs_rq of cgroup C is left dangling on the
>    "rq->tmp_alone_branch".
> 
> 2. A new task wakes up on cgroup A. Since the whole hierarchy is already
>    on the leaf cfs_rq list, list_add_leaf_cfs_rq() keeps returning early
>    without any modifications to "rq->tmp_alone_branch".
> 
>    The final assert_list_leaf_cfs_rq() in enqueue_task_fair() sees the
>    dangling reference to cgroup C's cfs_rq in "rq->tmp_alone_branch".
> 
>    !!! Splat !!!
> 
> Syncing the "pelt_clock_throttled" indicator with parent cfs_rq is not
> enough since the new cfs_rq is not yet enqueued on the hierarchy. A
> dequeue on other subtree on the throttled hierarchy can freeze the PELT
> clock for the parent hierarchy without setting the indicators for this
> newly added cfs_rq which was never enqueued.
>

Sigh...

> Since there are no tasks on the new hierarchy, start a cfs_rq on a
> throttled hierarchy with its PELT clock throttled. The first enqueue, or
> the distribution (whichever happens first) will unfreeze the PELT clock
> and queue the cfs_rq on the leaf cfs_rq list.
> 

Makes sense.

> While at it, add an assert_list_leaf_cfs_rq() in
> propagate_entity_cfs_rq() to catch such cases in the future.
> 
> Suggested-by: Aaron Lu <ziqianlu@bytedance.com>
> Reported-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
> Closes: https://lore.kernel.org/lkml/58a587d694f33c2ea487c700b0d046fa@codethink.co.uk/
> Fixes: eb962f251fbb ("sched/fair: Task based throttle time accounting")

Should be Fixes: e1fad12dcb66("sched/fair: Switch to task based throttle
model")? "Task based throttle time accounting" doesn't touch pelt bits.

> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>
Tested-by: Aaron Lu <ziqianlu@bytedance.com>

Thanks for the fix.

BTW, I'm thinking in propagate_entity_cfs_rq(), we shouldn't check the
ancestor cfs_rq's pelt clock throttled status but only the first level
cfs_rq's, because the purpose is to have the first level cfs_rq to stay
on the leaf list and all those list_add_leaf_cfs_rq() for its ancestors
are just to make sure the list is fully connected. I mean something like
this:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 75c615f5ed640..6a6d9200ab93c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13170,6 +13170,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 static void propagate_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+	bool add = !cfs_rq_pelt_clock_throttled(cfs_rq);
 
 	/*
 	 * If a task gets attached to this cfs_rq and before being queued,
@@ -13177,7 +13178,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 	 * change, make sure this cfs_rq stays on leaf cfs_rq list to have
 	 * that removed load decayed or it can cause faireness problem.
 	 */
-	if (!cfs_rq_pelt_clock_throttled(cfs_rq))
+	if (add)
 		list_add_leaf_cfs_rq(cfs_rq);
 
 	/* Start to propagate at parent */
@@ -13188,7 +13189,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 
-		if (!cfs_rq_pelt_clock_throttled(cfs_rq))
+		if (add)
 			list_add_leaf_cfs_rq(cfs_rq);
 	}

But this is a different thing and can be taken care of if necessary
later. Current logic doesn't have a problem, it's just not as clear as
the above diff to me.

