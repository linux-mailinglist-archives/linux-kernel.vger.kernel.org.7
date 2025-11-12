Return-Path: <linux-kernel+bounces-896995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845E0C51C22
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02903B1A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EB929BD82;
	Wed, 12 Nov 2025 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U4idYq82"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8082FF641
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943871; cv=none; b=DxZnhflKcQ/WfhCEgTBeMWCYsJ1jId/IugKWRq/ib/Xq8qCYnlUqHGr+QdqCIr2ptjc4Ga0L9yGVUYBy3DJMraTsFN5I/YyFvSJnf7v3/YGhlQ6UK1vVhw7Sdx+qnVpToc1nmnNppJPamEch8r6sxebAxXSN3Fw9oJkw1jjADCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943871; c=relaxed/simple;
	bh=du6Z/4TzwA2ib75lKXcFt2JvZucBdCXVVkrXUxivlyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ns2H61aPDonBGgWsGuBNRIkTHCuJfskhuud0zh+qV41IHVUg1v/EG9qJb759svtB0aHZzCsyRMFB/1IU2VgxiEkWFhO68qPO4ClBmE+6iXFbW9VKKy58Kz005ktcQyIjsjP2qMblpyIowV3ZcnG60fA/hSIaIwVpcYP97L0D2Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U4idYq82; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xAPxPJeYEUT9DjJ5HB6IV7L9sttkpsN/2Pkbpl/WoB4=; b=U4idYq82Oxmj4RBuYc5E+MQAOM
	h61DmDmvV5hq+Uj1nTCoRwBKSIjV5/S2NDBCIScWQqYDp9Y1o3qQuQOO3OJMnT2hvejs2QvTro/Tc
	NsHmNtsYvcitUYoKKYHCZtAHWYlmpY8tM978BsF9TE7VTyK2zhCfxiEaKOuK4Sj6PvbKfnfQsQzbc
	SRb0MhJ0BAlWYqHtCFU1GRdqjZRbJlkBdRvCl2U7blSn8CDfzTo1MxIjzoCSXahJo46fIY/80ySpb
	QuABfvh8pEAOwWc/WQT3qg9iIgiQVYR0p69nMXcCl6kYnR0O3q06qyToyRRtFxX5TUsoCZ7LetkBq
	PZx8oL8A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ8EQ-00000005kCc-0foA;
	Wed, 12 Nov 2025 10:37:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A1FBC300325; Wed, 12 Nov 2025 11:37:40 +0100 (CET)
Date: Wed, 12 Nov 2025 11:37:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
	Chen Yu <yu.c.chen@intel.com>, Doug Nelson <doug.nelson@intel.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>,
	linux-kernel@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v4] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
Message-ID: <20251112103740.GF4067720@noisy.programming.kicks-ass.net>
References: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
 <aRQ_D1vyNfGVo-xK@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRQ_D1vyNfGVo-xK@linux.ibm.com>

On Wed, Nov 12, 2025 at 01:32:23PM +0530, Srikar Dronamraju wrote:
> >  	group = sched_balance_find_src_group(&env);
> >  	if (!group) {
> >  		schedstat_inc(sd->lb_nobusyg[idle]);
> > @@ -11892,6 +11916,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
> >  			if (!cpumask_subset(cpus, env.dst_grpmask)) {
> >  				env.loop = 0;
> >  				env.loop_break = SCHED_NR_MIGRATE_BREAK;
> > +				if (need_unlock)
> > +					atomic_set_release(&sched_balance_running, 0);
> > +
> 
> One nit:
> While the current code is good, would conditionally resetting the
> need_unlock just after resetting the atomic variable better than
> unconditional reset that we do now?

Right, I had the same thought when grabbed the patch yesterday, but
ignored it.

But perhaps something like so?

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11717,14 +11717,20 @@ static int sched_balance_rq(int this_cpu
 		.fbq_type	= all,
 		.tasks		= LIST_HEAD_INIT(env.tasks),
 	};
-	bool need_unlock;
+	bool need_unlock = false;
 
 	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
 
 	schedstat_inc(sd->lb_count[idle]);
 
+	if (0) {
 redo:
-	need_unlock = false;
+		if (need_unlock) {
+			atomic_set_release(&sched_balance_running, 0);
+			need_unlock = false;
+		}
+	}
+
 	if (!should_we_balance(&env)) {
 		*continue_balancing = 0;
 		goto out_balanced;
@@ -11861,9 +11867,6 @@ static int sched_balance_rq(int this_cpu
 			if (!cpumask_subset(cpus, env.dst_grpmask)) {
 				env.loop = 0;
 				env.loop_break = SCHED_NR_MIGRATE_BREAK;
-				if (need_unlock)
-					atomic_set_release(&sched_balance_running, 0);
-
 				goto redo;
 			}
 			goto out_all_pinned;


---

The other option is something like this, but Linus hated on this pattern
when we started with things.

---
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11692,6 +11692,8 @@ static void update_lb_imbalance_stat(str
  */
 static atomic_t sched_balance_running = ATOMIC_INIT(0);
 
+DEFINE_FREE(balance_unlock, atomic_t *, if (_T) atomic_set_release(_T, 0));
+
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
@@ -11717,24 +11719,23 @@ static int sched_balance_rq(int this_cpu
 		.fbq_type	= all,
 		.tasks		= LIST_HEAD_INIT(env.tasks),
 	};
-	bool need_unlock;
 
 	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
 
 	schedstat_inc(sd->lb_count[idle]);
 
 redo:
-	need_unlock = false;
 	if (!should_we_balance(&env)) {
 		*continue_balancing = 0;
-		goto out_balanced;
+		return 0;
 	}
 
+	atomic_t *lock __free(balance_unlock) = NULL;
 	if (sd->flags & SD_SERIALIZE) {
-		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1)) {
-			goto out_balanced;
-		}
-		need_unlock = true;
+		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, 0, 1))
+			return 0;
+
+		lock = &sched_balance_running;
 	}
 
 	group = sched_balance_find_src_group(&env);
@@ -11861,9 +11862,6 @@ static int sched_balance_rq(int this_cpu
 			if (!cpumask_subset(cpus, env.dst_grpmask)) {
 				env.loop = 0;
 				env.loop_break = SCHED_NR_MIGRATE_BREAK;
-				if (need_unlock)
-					atomic_set_release(&sched_balance_running, 0);
-
 				goto redo;
 			}
 			goto out_all_pinned;
@@ -11980,9 +11978,6 @@ static int sched_balance_rq(int this_cpu
 	    sd->balance_interval < sd->max_interval)
 		sd->balance_interval *= 2;
 out:
-	if (need_unlock)
-		atomic_set_release(&sched_balance_running, 0);
-
 	return ld_moved;
 }
 

