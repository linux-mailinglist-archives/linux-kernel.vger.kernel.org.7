Return-Path: <linux-kernel+bounces-888344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 234B7C3A8F2
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 575894F918E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CDD30E0E9;
	Thu,  6 Nov 2025 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IzTlHh55"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5194F2DC772
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428233; cv=none; b=oJBkBzyOXqD6c77R3YK5Fj0Y9mrto/sGCs6iSd7iQlvY9TFkUHQpU35EBdMkrRuqb6xB0Kf4Ry5w7Gt2Jzl0qgKNiaS+oZtrBRTQ1mdF+jQzNmOGrNpHtuGilF6tLppM+gDw27vuTf4QmAx1aVdvt560ScnkIhCyt7XF5OvtqJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428233; c=relaxed/simple;
	bh=8ppx794pGtGPlpDEc1FMucl+Dmk0WYAnxnBIes+aoMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpmB/Nc77VpbUisMb6CubNJlRA5csrqh2NCzEUKZPT++LivF2GJfCs0uOviToJS1FlaqjQRKxZ6dxuODZgKA2r0H//QPSMAREn4g6KUex4xsdaQZ828MyFY3lbohsy0Np/Z8zbt4T5Roepf9kW9KFRPzSgBnbYES6dXrCoqtkMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IzTlHh55; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NRo75t32CyEPHLJJsdCHgw/V1D9FuevZedIuWhDM698=; b=IzTlHh55jT3f0QHI3l2BCWlxqY
	kYDt20Qw7QnDW8oQ+UZ3IU9/GMCYr9g/iCZNxY/ttck7UmZaol1BkVKfy82tEGDgpW++UDaxf5rio
	eWDRefmDmowwk5OIUbtQsw1SI7dcncC2J5njHHNAA8oYUR86RUxInPY5wNLG5tJv/2HLJzD6wcz8O
	xH8fsygXWsz/Zx2nB9qMtruR0ENhNtOFlPcqY0+roxt45hju1tdcl5gDWtgN5CklFhM8Y0M/w2cX1
	7n07rzAFsTY6rrYXcr/T/ccIJIEMyyQsZlktyLx7QpB8ewaacz2XvnPFjIoGU79NvHyXhElRhxVwp
	5Qt75SqQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGxDv-000000047cT-1zEr;
	Thu, 06 Nov 2025 10:28:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F0FF1300230; Thu, 06 Nov 2025 12:23:39 +0100 (CET)
Date: Thu, 6 Nov 2025 12:23:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v2 0/6] futex: Use RCU-based per-CPU reference counting
Message-ID: <20251106112339.GQ3245006@noisy.programming.kicks-ass.net>
References: <20250710110011.384614-1-bigeasy@linutronix.de>
 <e0f58203-22ef-44c0-9f7b-b15c6007249b@linux.ibm.com>
 <20250715163134.pM1J2XO9@linutronix.de>
 <88edcfdf-2253-4563-a895-6e8bb1625800@linux.ibm.com>
 <20250716142946.GD905792@noisy.programming.kicks-ass.net>
 <ae8c6fd5-cc9c-44f3-a489-0346873f4be5@linux.ibm.com>
 <20251106092929.GR4067720@noisy.programming.kicks-ass.net>
 <20251106110907.noLpnulw@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106110907.noLpnulw@linutronix.de>

On Thu, Nov 06, 2025 at 12:09:07PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-11-06 10:29:29 [+0100], Peter Zijlstra wrote:
> > Subject: futex: Optimize per-cpu reference counting
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Wed, 16 Jul 2025 16:29:46 +0200
> > 
> > Shrikanth noted that the per-cpu reference counter was still some 10%
> > slower than the old immutable option (which removes the reference
> > counting entirely).
> > 
> > Further optimize the per-cpu reference counter by:
> > 
> >  - switching from RCU to preempt;
> >  - using __this_cpu_*() since we now have preempt disabled;
> >  - switching from smp_load_acquire() to READ_ONCE().
> > 
> > This is all safe because disabling preemption inhibits the RCU grace
> > period exactly like rcu_read_lock().
> > 
> > Having preemption disabled allows using __this_cpu_*() provided the
> > only access to the variable is in task context -- which is the case
> > here.
> 
> Right. Read and Write from softirq happens after the user transitioned
> to atomics.
> 
> > Furthermore, since we know changing fph->state to FR_ATOMIC demands a
> > full RCU grace period we can rely on the implied smp_mb() from that to
> > replace the acquire barrier().
> 
> That is the only part I struggle with but having a smp_mb() after a
> grace period sounds reasonable.

IIRC the argument goes something like so:

A grace-period (for rcu-sched, which is implied by regular rcu)
implies that every task has done at least one voluntary context switch.
A context switch implies a full barrier.

Therefore observing a state change separated by a grace-period implies
an smp_mb().

> > This is very similar to the percpu_down_read_internal() fast-path.
> >
> > The reason this is significant for PowerPC is that it uses the generic
> > this_cpu_*() implementation which relies on local_irq_disable() (the
> > x86 implementation relies on it being a single memop instruction to be
> > IRQ-safe). Switching to preempt_disable() and __this_cpu*() avoids
> > this IRQ state swizzling. Also, PowerPC needs LWSYNC for the ACQUIRE
> > barrier, not having to use explicit barriers safes a bunch.
> > 
> > Combined this reduces the performance gap by half, down to some 5%.
> 
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Sebastian

