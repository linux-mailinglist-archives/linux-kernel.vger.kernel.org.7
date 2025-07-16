Return-Path: <linux-kernel+bounces-733709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A128B07817
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38DF07B4795
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A642620E4;
	Wed, 16 Jul 2025 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qbqR++jt"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691BD218589
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676196; cv=none; b=muRPXkD9FbJtRSpScL6bOtyMfOxWrZQUsKRiyyfRsmQ6ZHH8i8zMuWKFtXgUUXTXNYM9keEkuubmZJZRh6R9eaDzyf14rHs8nnGWNntY/IYOcO+FfulRrUy+XEZbWcPKk1yTqiC8uQcO5NOAK4KxULDw/8EX5Bqx6MhwDM4ybco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676196; c=relaxed/simple;
	bh=lHUAlulKvLPGKAlWK7JOVViPUVgEHzL6adbDYX1mZzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfBnWDvNtDrgjnPYA8Rcgi5z3EjP6j7a5pEULYdeMJKIgTkQrY+EPZWFryeudXkJe/qyOiodMOvDIAgu4DbpV/pwnXODwLTUSplYiD5+mjwijQ67irlR3D5bnw5akFJMa+D71NgGEWN0eGT1OdmXa6P2mjx1UpmA6WYlD03zP7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qbqR++jt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i8mQE0DKmWWS88DdOJJYoFKAUkm3QS3JFwZtaaN7eno=; b=qbqR++jtGe2DLlI6pMXgV6na9C
	KIPkGJoWcx/6Xy5GDIwJ3g/JzTyuwEPDQLITKXGCQYuswzZe4JeQRM4OIcZr5SPaTCmGpB9TQGoda
	sENghAtCJANGeGBkl+T9g5wlORqlZDxpYH+qUQQY4kPHytNCTsjBXltZ1SZZuO3CW7Pn7wkN2gtku
	DS7/AvY/fwSo6ZVdH2T0uZdkCJbUouUscoOLQGLO9XfkZ4QA2wLZkxIW2uZFbhdqrKfTZXNl/HhN4
	cpmmjtcmn7bPFnHmIfUmT3BIZSrFz3nPgVuFvEXLPbK/lJm1O2IPRtqCi/l0kinBSPBZoh99+mBvp
	0oZMcglA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc38m-0000000GpKm-1Az2;
	Wed, 16 Jul 2025 14:29:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D74FF300186; Wed, 16 Jul 2025 16:29:46 +0200 (CEST)
Date: Wed, 16 Jul 2025 16:29:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 0/6] futex: Use RCU-based per-CPU reference counting
Message-ID: <20250716142946.GD905792@noisy.programming.kicks-ass.net>
References: <20250710110011.384614-1-bigeasy@linutronix.de>
 <e0f58203-22ef-44c0-9f7b-b15c6007249b@linux.ibm.com>
 <20250715163134.pM1J2XO9@linutronix.de>
 <88edcfdf-2253-4563-a895-6e8bb1625800@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88edcfdf-2253-4563-a895-6e8bb1625800@linux.ibm.com>

On Tue, Jul 15, 2025 at 10:34:24PM +0530, Shrikanth Hegde wrote:

> I did try again by going to baseline, removed BROKEN and ran below. Which gives us immutable numbers.
> ./perf bench futex hash -Ib512
> Averaged 1536035 operations/sec (+- 0.11%), total secs = 10
> Futex hashing: 512 hash buckets (immutable)
> 
> So, with -b 512 option, it is around 8-10% less compared to immutable.

Urgh, can you run perf on that and tell me if this is due to
this_cpu_{inc,dec}() doing local_irq_disable() or the smp_load_acquire()
doing LWSYNC ?

Anyway, I think we can improve both. Does the below help?


---
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index d9bb5567af0c..8c41d050bd1f 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1680,10 +1680,10 @@ static bool futex_ref_get(struct futex_private_hash *fph)
 {
 	struct mm_struct *mm = fph->mm;
 
-	guard(rcu)();
+	guard(preempt)();
 
-	if (smp_load_acquire(&fph->state) == FR_PERCPU) {
-		this_cpu_inc(*mm->futex_ref);
+	if (READ_ONCE(fph->state) == FR_PERCPU) {
+		__this_cpu_inc(*mm->futex_ref);
 		return true;
 	}
 
@@ -1694,10 +1694,10 @@ static bool futex_ref_put(struct futex_private_hash *fph)
 {
 	struct mm_struct *mm = fph->mm;
 
-	guard(rcu)();
+	guard(preempt)();
 
-	if (smp_load_acquire(&fph->state) == FR_PERCPU) {
-		this_cpu_dec(*mm->futex_ref);
+	if (READ_ONCE(fph->state) == FR_PERCPU) {
+		__this_cpu_dec(*mm->futex_ref);
 		return false;
 	}
 

