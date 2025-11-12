Return-Path: <linux-kernel+bounces-897299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A131C528A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C58BD4FD766
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D1D3370E4;
	Wed, 12 Nov 2025 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rhpbHYjl"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F155219A8E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954792; cv=none; b=TSSax+F3/50jRJkzbE6AjEkNJhCE7rXfFTntVvey6jWSBQAoTS+skCcOJSwTUtanTCYUm/6rOBDVwEQPpwdvhwqxCAUzyd+9+vP7laHE9hpHgdmGbatRkuofDQX9IkFtyb9VVcg2RA3k1wJNSaW0yfQS6EsS4iBPbXqMKOM1Y4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954792; c=relaxed/simple;
	bh=mFshK5Bl9f8kBI2gah2M1mQFvPC8OzR5oTyh+qmW1J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUQlp+ej4jNfYszS86zJhjIM6KIAzraq8I7bcI3d6n/S4cArg0cVl9giYzLtUNMoxRB8T8P+0Wab+o5UtpSsGBRJjdPNCBg81/L72lsWK1Ts9qVKyqoKssLVACp+7VtZMt8sK/gBXV1757eQwzPgN2/rX4VmIl7ncfiL/CC6h28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rhpbHYjl; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=710+h6M6UjVYSfJKVCEVEweLeNntQIE+OfWK6856a9M=; b=rhpbHYjlMAIS8J3Zhg5Bz5Gaxt
	H9L8McNCQH5chk+sDaz24+pMWrsauAmD4sHSb0H/2+8YRibRyAJASbkqLg/OzpD6S8cJYbUG9un/T
	JrER8PGH23OORWDs463mViniL+LdwgZ//gHPmZw5/xmrhREuCbUyHWOG5+2qgUvSl1p23wUtHG6XC
	2r+opxa67Y/Sn/EVTFlQF+Najw92hKrTnJFUx4W1zmRUZgd3jnom3LSWdWK9rxHhBkZOR4oZInFuf
	M/ZgLtaF3rYUKc9usxqGPjMk/dhCLzfN4KztMPRszCSy5Xp56R8w2OimuSMn9uIBEGPriXGMbKbNo
	wLGqDYSA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJACp-0000000FVlw-3NPh;
	Wed, 12 Nov 2025 12:44:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 52B1D300265; Wed, 12 Nov 2025 14:39:37 +0100 (CET)
Date: Wed, 12 Nov 2025 14:39:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
	Doug Nelson <doug.nelson@intel.com>,
	Mohini Narkhede <mohini.narkhede@intel.com>,
	linux-kernel@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v4] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
Message-ID: <20251112133937.GC3245006@noisy.programming.kicks-ass.net>
References: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
 <aRQ_D1vyNfGVo-xK@linux.ibm.com>
 <20251112103740.GF4067720@noisy.programming.kicks-ass.net>
 <20251112104555.GE4068168@noisy.programming.kicks-ass.net>
 <aRRuvLKvMdxw8bZV@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRRuvLKvMdxw8bZV@linux.ibm.com>

On Wed, Nov 12, 2025 at 04:55:48PM +0530, Srikar Dronamraju wrote:

> If the CPU that was doing the balance was not the first CPU of the domain
> span, but it was doing the balance since the first CPU was busy, and the
> first CPU now happens to be idle at redo, the scheduler would have chosen the
> first CPU to do the balance. However it will now choose the CPU that had the atomic..
> 
> I think this is better because 
> - The first CPU may have tried just before this CPU dropped the atomic and
>   hence we may miss the balance opportunity.
> - The first CPU and the other CPU may not be sharing cache and hence there
>   may be a cache-miss, which we are avoiding by doing this.

I'm not sure I understand what you're arguing for. Are you saying it
would be better to retain the lock where possible?


--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11717,23 +11717,22 @@ static int sched_balance_rq(int this_cpu
 		.fbq_type	= all,
 		.tasks		= LIST_HEAD_INIT(env.tasks),
 	};
-	bool need_unlock;
+	bool need_unlock = false;
 
 	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
 
 	schedstat_inc(sd->lb_count[idle]);
 
 redo:
-	need_unlock = false;
 	if (!should_we_balance(&env)) {
 		*continue_balancing = 0;
 		goto out_balanced;
 	}
 
-	if (sd->flags & SD_SERIALIZE) {
-		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1)) {
+	if (!need_unlock && sd->flags & SD_SERIALIZE) {
+		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, 0, 1))
 			goto out_balanced;
-		}
+
 		need_unlock = true;
 	}
 
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

