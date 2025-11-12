Return-Path: <linux-kernel+bounces-897523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E47C52F75
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 95D1F355A07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9358C33AD96;
	Wed, 12 Nov 2025 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y0YALBDM"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE04E339B28
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960114; cv=none; b=kfVZUL7sJ7jz14bOV3jCA7YnmS/u6turlDFsNb6oUwj8Xq3BSEGEDp73re4GwgeNCGzJKcE5QXLPwXQ/8JBYQ+PH7zAoe3eOYp4P3IRk1TBNtclys8KU6D4cKDS7Pthw4U/+lYK+sEMuO2FzfdL+dc5lyCQ6NKo76AsCYsAGm2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960114; c=relaxed/simple;
	bh=c1ZGVy0GBbaZDUUvStNCn9YOzbR/fEqU9mFTBpk1nqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dy4mb0LQkWefyxe1+g41Wo0mWIiuG0HovDIWE1EOTa4ZF3qUsFIKdBsSgwWEdA+aAgLpy66niKXeBImxU4Tf+oekceCUoaWdk9XStgf+dIZEN5Qz9eJ4/UcPA3/Pdad497YeMu/vZKEY2Gn8FWqYYj1niD1QYbTiEtilnCFXdMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y0YALBDM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gQbIhwDGbp7mfNBm+FgA2L4/WUZidm3LS5CMsg5hChc=; b=Y0YALBDMu2p6qNd858XIAocwcn
	tL0oazLUqxKmXYE8hJNHZoGDLQTEQSlCTteeWXKG5MMv7CIGQVNHfqaL1MCbE9yXOUWGW9ys/a6Q7
	I2u+BJns3qpBv2pbhH/4ErwscuA/XsZ2VN/uFuz7PNZv3UEdQVCJRJuHGlb/w1DmJPPS/YI6km4/I
	7I5qoKEVdlQLS3iSLDvxb+ec3WoWZdD4pwFieUdi/q8U3R0rmWD7AWl5pm2nlUl1NOU/h1mvwJ0Ca
	tifXCiWYLLyZbtwnTx8hYYycI6edTMbeRfnzNKn+ploy3Ba7stpO6d8v5mI/gZ8uUlq90cn82lM//
	63Z3NAVA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJBad-0000000Ffpw-384Q;
	Wed, 12 Nov 2025 14:12:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7B35E300265; Wed, 12 Nov 2025 16:08:18 +0100 (CET)
Date: Wed, 12 Nov 2025 16:08:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	Chris Mason <clm@meta.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	Josh Don <joshdon@google.com>
Subject: Re: [PATCH 2/4] sched/fair: Small cleanup to sched_balance_newidle()
Message-ID: <20251112150818.GG4068168@noisy.programming.kicks-ass.net>
References: <20251107160645.929564468@infradead.org>
 <20251107161739.525916173@infradead.org>
 <2acd7c1d-e2b4-40a0-85de-55f9b2635dad@linux.ibm.com>
 <20251112144241.GP278048@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112144241.GP278048@noisy.programming.kicks-ass.net>

On Wed, Nov 12, 2025 at 03:42:41PM +0100, Peter Zijlstra wrote:

> > if sd is null, i think we are skipping these compared to earlier.
> > 
> >         t0 = sched_clock_cpu(this_cpu);
> >         sched_balance_update_blocked_averages(this_cpu);
> 
> let me pull that sched_balance_update_blocked_averages() thing up a few
> lines.

Something like so..

---
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9946,15 +9946,11 @@ static unsigned long task_h_load(struct
 }
 #endif /* !CONFIG_FAIR_GROUP_SCHED */
 
-static void sched_balance_update_blocked_averages(int cpu)
+static void __sched_balance_update_blocked_averages(struct rq *rq)
 {
 	bool decayed = false, done = true;
-	struct rq *rq = cpu_rq(cpu);
-	struct rq_flags rf;
 
-	rq_lock_irqsave(rq, &rf);
 	update_blocked_load_tick(rq);
-	update_rq_clock(rq);
 
 	decayed |= __update_blocked_others(rq, &done);
 	decayed |= __update_blocked_fair(rq, &done);
@@ -9962,7 +9958,15 @@ static void sched_balance_update_blocked
 	update_blocked_load_status(rq, !done);
 	if (decayed)
 		cpufreq_update_util(rq, 0);
-	rq_unlock_irqrestore(rq, &rf);
+}
+
+static void sched_balance_update_blocked_averages(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	guard(rq_lock_irqsave)(rq);
+	update_rq_clock(rq);
+	__sched_balance_update_blocked_averages(rq);
 }
 
 /********** Helpers for sched_balance_find_src_group ************************/
@@ -12865,6 +12869,8 @@ static int sched_balance_newidle(struct
 	if (!cpu_active(this_cpu))
 		return 0;
 
+	__sched_balance_update_blocked_averages(this_rq);
+
 	/*
 	 * This is OK, because current is on_cpu, which avoids it being picked
 	 * for load-balance and preemption/IRQs are still disabled avoiding
@@ -12891,7 +12897,6 @@ static int sched_balance_newidle(struct
 	raw_spin_rq_unlock(this_rq);
 
 	t0 = sched_clock_cpu(this_cpu);
-	sched_balance_update_blocked_averages(this_cpu);
 
 	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {

