Return-Path: <linux-kernel+bounces-888088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AAEC39D16
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCDA44E7737
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33A330C36D;
	Thu,  6 Nov 2025 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LHD90CAO"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28B030BF7B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421411; cv=none; b=ux8EpWoSo8NMH1D2W3uIvZ3hgOrl7syIHsn78DGY0N0/ygkWDrJgIgSSJgAfqXNTEnEcNhU6hG0B5jd17//WpfmQK9vB0IprN5Viw8RZQvzDiCUJjeLodm+3RhMUquUYNfC3sT+w4++UEL8/veRwe108FRJEAgwfU7M6aAyJYOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421411; c=relaxed/simple;
	bh=5Q70uNZgvXMnG+FcWTm2thBI5YWNuANk3UsX8UcykQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQRhn/wPi8ExBw8bZ5X5e0i5X/XBwwhFGQyLDFYW1ynqS4y0BMSuHnbdE8CQXUUmeRYroVUilM5RDEDfxWkZAwpevvi+cmrVY+ANTXEjtw5Ch1+vyA+cZ/AC/p6n3kJ0CQQ9131thfpxXNtkXyVKEhPO1KUveaxdHU19h+FXUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LHD90CAO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z4MczQLnGpbhKtlh5ALVW+kByWj5MWmj7cgNf4sxqp8=; b=LHD90CAO3edTfbPh6pxHU4cTUu
	EinH0K2GaUMU/XKVWaysK3lnoiJ9l5hZ4urWkL6YwcUI6rauumxRaqXkD4LzA6pv2nbD8r5yNdPgH
	7MVgG+CZ40f0XTQakHCI2tmgOH2rMSlD2nOQshhNgK+bfhcHinFbF3sqPIbplQJyN8ai2ltYv8qBz
	waxqx+Snwltd/LmfS4yjSF0Bs4DnIPjeiyBdLacGJD3OozwArpOm+Jw0lC1O6qfmNo+PoEtRA71oN
	/eT77mBoQpw0zq6kGO3LXWVmS5foFse2la1Wq+qgfEgGdnHkxmn7x/p7wSggZs8ciuaCOQA9TeNFF
	Pj8y1KEg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGvRS-00000003sQs-00NQ;
	Thu, 06 Nov 2025 08:34:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 66B6F300265; Thu, 06 Nov 2025 10:29:29 +0100 (CET)
Date: Thu, 6 Nov 2025 10:29:29 +0100
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
Message-ID: <20251106092929.GR4067720@noisy.programming.kicks-ass.net>
References: <20250710110011.384614-1-bigeasy@linutronix.de>
 <e0f58203-22ef-44c0-9f7b-b15c6007249b@linux.ibm.com>
 <20250715163134.pM1J2XO9@linutronix.de>
 <88edcfdf-2253-4563-a895-6e8bb1625800@linux.ibm.com>
 <20250716142946.GD905792@noisy.programming.kicks-ass.net>
 <ae8c6fd5-cc9c-44f3-a489-0346873f4be5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae8c6fd5-cc9c-44f3-a489-0346873f4be5@linux.ibm.com>

On Wed, Jul 16, 2025 at 11:51:46PM +0530, Shrikanth Hegde wrote:

> > Anyway, I think we can improve both. Does the below help?
> > 
> > 
> > ---
> > diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> > index d9bb5567af0c..8c41d050bd1f 100644
> > --- a/kernel/futex/core.c
> > +++ b/kernel/futex/core.c
> > @@ -1680,10 +1680,10 @@ static bool futex_ref_get(struct futex_private_hash *fph)
> >   {
> >   	struct mm_struct *mm = fph->mm;
> > -	guard(rcu)();
> > +	guard(preempt)();
> > -	if (smp_load_acquire(&fph->state) == FR_PERCPU) {
> > -		this_cpu_inc(*mm->futex_ref);
> > +	if (READ_ONCE(fph->state) == FR_PERCPU) {
> > +		__this_cpu_inc(*mm->futex_ref);
> >   		return true;
> >   	}
> > @@ -1694,10 +1694,10 @@ static bool futex_ref_put(struct futex_private_hash *fph)
> >   {
> >   	struct mm_struct *mm = fph->mm;
> > -	guard(rcu)();
> > +	guard(preempt)();
> > -	if (smp_load_acquire(&fph->state) == FR_PERCPU) {
> > -		this_cpu_dec(*mm->futex_ref);
> > +	if (READ_ONCE(fph->state) == FR_PERCPU) {
> > +		__this_cpu_dec(*mm->futex_ref);
> >   		return false;
> >   	}
> 
> Yes. It helps. It improves "-b 512" numbers by at-least 5%.

While talking with Sebastian about this work, I realized this patch was
never committed. So I've written it up like so, and will commit to
tip/locking/urgent soonish.

---
Subject: futex: Optimize per-cpu reference counting
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed, 16 Jul 2025 16:29:46 +0200

Shrikanth noted that the per-cpu reference counter was still some 10%
slower than the old immutable option (which removes the reference
counting entirely).

Further optimize the per-cpu reference counter by:

 - switching from RCU to preempt;
 - using __this_cpu_*() since we now have preempt disabled;
 - switching from smp_load_acquire() to READ_ONCE().

This is all safe because disabling preemption inhibits the RCU grace
period exactly like rcu_read_lock().

Having preemption disabled allows using __this_cpu_*() provided the
only access to the variable is in task context -- which is the case
here.

Furthermore, since we know changing fph->state to FR_ATOMIC demands a
full RCU grace period we can rely on the implied smp_mb() from that to
replace the acquire barrier().

This is very similar to the percpu_down_read_internal() fast-path.

The reason this is significant for PowerPC is that it uses the generic
this_cpu_*() implementation which relies on local_irq_disable() (the
x86 implementation relies on it being a single memop instruction to be
IRQ-safe). Switching to preempt_disable() and __this_cpu*() avoids
this IRQ state swizzling. Also, PowerPC needs LWSYNC for the ACQUIRE
barrier, not having to use explicit barriers safes a bunch.

Combined this reduces the performance gap by half, down to some 5%.

Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/futex/core.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1680,10 +1680,10 @@ static bool futex_ref_get(struct futex_p
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
 
@@ -1694,10 +1694,10 @@ static bool futex_ref_put(struct futex_p
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
 

