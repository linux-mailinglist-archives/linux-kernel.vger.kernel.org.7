Return-Path: <linux-kernel+bounces-897005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B358C51C8E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40F764F9AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CA6307AE4;
	Wed, 12 Nov 2025 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O82Azvq7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9A30102A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944364; cv=none; b=DJjYZ6UPptMleHeXtKcQbkfFhbpoiiIDY5ouD8qBEviK/D1zIdFIkYu4oBoXyAj5pZomo1XzxtF1BX5FkYAWauIyPbjAQ3YJ++XBgKx5AY4Ppe4Cw5HWOKbA7VHRVODWP3zMhNvvAQgWdUl8+AXJlJnKOBgP2BTUFPObd02hcVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944364; c=relaxed/simple;
	bh=PMWGwa24zXDDUfVWqmNMXwClGUeYoamVgg+EUXV/v3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VF6p1+Ph33BNfKhm7RaMQPYYBXQY3ZWmFrJP2LX+I7sbJR+Ca9g5f1UQ7tHA8xgX1cXUcjnwswYpWB9FlO8HWUHnfMQCdamFOvvhSz2AA30nWnHtciS6Z30nHeBpBaYke6xUULAgG8D9iNpBvx/mHPXk93XcaEBlfz1yfd/n880=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O82Azvq7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ERXOWokKUxhtN8s42NOojsw8vOOselxVDezjW/Syzi4=; b=O82Azvq7EVZ61EMMDMlYr0I/Ww
	r6gBjkvFkheps8K3t63C8Pxde6Q2dPz8Zfy4STIXEzWyjY+pRTcqcbcz+ZObczomeQFK0dpjJ1+IN
	7+LsJyh3Ys43LJklJQZFRQ2Pxt5R5V2SST2u7/VDzKlyLk11S4x6MjrP/1HsVhGDL4Mq3VJICwuR4
	7NNe0qoHq9iR5feWNe6fHDlvfOFABUvqJVx8I/QG+ldQiGJuyhBD701fT2Nds9UPmTIkEga2kahhF
	iE1i02X5BZxsgODOhe3m+luPX0iVc+EkuW4UYt4ClIWQRhuVP0rExH4UkzxSp4mP0TTJ1LQZLBMay
	L3UZ/7Tg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ8MN-00000005l4h-2hRn;
	Wed, 12 Nov 2025 10:45:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 293E2300325; Wed, 12 Nov 2025 11:45:55 +0100 (CET)
Date: Wed, 12 Nov 2025 11:45:55 +0100
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
Message-ID: <20251112104555.GE4068168@noisy.programming.kicks-ass.net>
References: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
 <aRQ_D1vyNfGVo-xK@linux.ibm.com>
 <20251112103740.GF4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112103740.GF4067720@noisy.programming.kicks-ass.net>

On Wed, Nov 12, 2025 at 11:37:40AM +0100, Peter Zijlstra wrote:
> On Wed, Nov 12, 2025 at 01:32:23PM +0530, Srikar Dronamraju wrote:
> > >  	group = sched_balance_find_src_group(&env);
> > >  	if (!group) {
> > >  		schedstat_inc(sd->lb_nobusyg[idle]);
> > > @@ -11892,6 +11916,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
> > >  			if (!cpumask_subset(cpus, env.dst_grpmask)) {
> > >  				env.loop = 0;
> > >  				env.loop_break = SCHED_NR_MIGRATE_BREAK;
> > > +				if (need_unlock)
> > > +					atomic_set_release(&sched_balance_running, 0);
> > > +
> > 
> > One nit:
> > While the current code is good, would conditionally resetting the
> > need_unlock just after resetting the atomic variable better than
> > unconditional reset that we do now?
> 
> Right, I had the same thought when grabbed the patch yesterday, but
> ignored it.
> 

Hmm, should we not redo while keeping the lock? Doesn't make much sense
to drop and try to reacquire things here.

So perhaps this is the better option -- or did I overlook something with
should_we_balance? It doesn't look like that will make a different
decision on the retry.

---
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11717,26 +11717,25 @@ static int sched_balance_rq(int this_cpu
 		.fbq_type	= all,
 		.tasks		= LIST_HEAD_INIT(env.tasks),
 	};
-	bool need_unlock;
+	bool need_unlock = false;
 
 	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
 
 	schedstat_inc(sd->lb_count[idle]);
 
-redo:
-	need_unlock = false;
 	if (!should_we_balance(&env)) {
 		*continue_balancing = 0;
 		goto out_balanced;
 	}
 
 	if (sd->flags & SD_SERIALIZE) {
-		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1)) {
+		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, 0, 1))
 			goto out_balanced;
-		}
+
 		need_unlock = true;
 	}
 
+redo:
 	group = sched_balance_find_src_group(&env);
 	if (!group) {
 		schedstat_inc(sd->lb_nobusyg[idle]);
@@ -11861,9 +11860,6 @@ static int sched_balance_rq(int this_cpu
 			if (!cpumask_subset(cpus, env.dst_grpmask)) {
 				env.loop = 0;
 				env.loop_break = SCHED_NR_MIGRATE_BREAK;
-				if (need_unlock)
-					atomic_set_release(&sched_balance_running, 0);
-
 				goto redo;
 			}
 			goto out_all_pinned;

