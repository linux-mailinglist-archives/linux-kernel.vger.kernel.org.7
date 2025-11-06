Return-Path: <linux-kernel+bounces-889345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B24C3D55E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 21:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567A9188CC07
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 20:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1962EF67A;
	Thu,  6 Nov 2025 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHeMZ8eL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31B72EF654
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762460272; cv=none; b=LxU2PbzzMBAVbBuV0Ac0+JjB2R/x6xkEnI0jIVw3Z8yG29BdcAsj1DgozXRQIRZHh/eR9QG5TgkRVr/A7Ox3VemGnC3rhiWkkwG9PqIbRwm/UBg4aelu3a0V+gvSpxL+35bolM7zuog05Fbx01oFDqUPIEsdoGNgZs9CrtZn23Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762460272; c=relaxed/simple;
	bh=jWlPtYShWIQj4ZjbJsOK3U7ROWzVRERdqU9uRbHELDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlFAjuC4bXnjCbAdLPzyCkS7Gdf57LGZDDq2KYL3O1dACtT82WqF0A4Ld9Mj/yzqLygJ4tUy6KyXnEsKPg19bmfD2JnzYk/80H7pOwOE3J0dLnGAPiTnCRMm7RAugGjjKDWqVCMoxUNqVnxS1YZzWds9uHyoW/07T9MFMOrttDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHeMZ8eL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F97C4CEFB;
	Thu,  6 Nov 2025 20:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762460272;
	bh=jWlPtYShWIQj4ZjbJsOK3U7ROWzVRERdqU9uRbHELDI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=IHeMZ8eL7G3sbSn1NBVp4C/JHjhcnZJkAmt2Sw8Jq8ZicpBqivkrgtk9I5mkHRJph
	 awCzqiL/MX047DmEHR5km5PTnpCQkpWv6N/mst7TRbJB59fCNxLA7UKL7SfBE8zy1E
	 3qsW9GnVJWDUm2UZVtKMIP6CnZ64Ttxe4kqI/NZLCV0isg903TczfdwEojcx1JM/bN
	 NKCn9XFvPVv7kgkB0F3XB7J+lT2TsVSlNLuuKvWwHUYAB0MuGIETnplrZyTsmU/KiU
	 MqD1cjrwYLJ79WBoeV/RPMeBHnovpV136aZKPR4h7hLGJ+FRZ5msJidFTJZaVvR2eQ
	 eLr+jv34R8QOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2FD2ACE0B24; Thu,  6 Nov 2025 12:17:50 -0800 (PST)
Date: Thu, 6 Nov 2025 12:17:50 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 0/6] futex: Use RCU-based per-CPU reference counting
Message-ID: <969781b2-1bf4-4f8e-b694-452e593bb39a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250710110011.384614-1-bigeasy@linutronix.de>
 <e0f58203-22ef-44c0-9f7b-b15c6007249b@linux.ibm.com>
 <20250715163134.pM1J2XO9@linutronix.de>
 <88edcfdf-2253-4563-a895-6e8bb1625800@linux.ibm.com>
 <20250716142946.GD905792@noisy.programming.kicks-ass.net>
 <ae8c6fd5-cc9c-44f3-a489-0346873f4be5@linux.ibm.com>
 <20251106092929.GR4067720@noisy.programming.kicks-ass.net>
 <20251106110907.noLpnulw@linutronix.de>
 <20251106112339.GQ3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106112339.GQ3245006@noisy.programming.kicks-ass.net>

On Thu, Nov 06, 2025 at 12:23:39PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 06, 2025 at 12:09:07PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-11-06 10:29:29 [+0100], Peter Zijlstra wrote:
> > > Subject: futex: Optimize per-cpu reference counting
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > Date: Wed, 16 Jul 2025 16:29:46 +0200
> > > 
> > > Shrikanth noted that the per-cpu reference counter was still some 10%
> > > slower than the old immutable option (which removes the reference
> > > counting entirely).
> > > 
> > > Further optimize the per-cpu reference counter by:
> > > 
> > >  - switching from RCU to preempt;
> > >  - using __this_cpu_*() since we now have preempt disabled;
> > >  - switching from smp_load_acquire() to READ_ONCE().
> > > 
> > > This is all safe because disabling preemption inhibits the RCU grace
> > > period exactly like rcu_read_lock().
> > > 
> > > Having preemption disabled allows using __this_cpu_*() provided the
> > > only access to the variable is in task context -- which is the case
> > > here.
> > 
> > Right. Read and Write from softirq happens after the user transitioned
> > to atomics.
> > 
> > > Furthermore, since we know changing fph->state to FR_ATOMIC demands a
> > > full RCU grace period we can rely on the implied smp_mb() from that to
> > > replace the acquire barrier().
> > 
> > That is the only part I struggle with but having a smp_mb() after a
> > grace period sounds reasonable.
> 
> IIRC the argument goes something like so:
> 
> A grace-period (for rcu-sched, which is implied by regular rcu)
> implies that every task has done at least one voluntary context switch.

Agreed, except for: s/voluntary context switch/context switch/

It is Tasks RCU that pays attention only to voluntary context switches.

> A context switch implies a full barrier.
> 
> Therefore observing a state change separated by a grace-period implies
> an smp_mb().

Just to be pedantic, for any given CPU and any given grace period,
it is the case that:

1.	That CPU will have executed a full barrier between any code
	executed on any CPU that happens before the beginning of that
	grace period and any RCU read-side critical section on that CPU
	that extends beyond the end of that grace period, and

2.	That CPU will have executed a full barrier between any RCU
	read-side critical section on that CPU that extends before the
	beginning of that grace period and any code executed on any CPU
	that happens after the end of that grace period.

An RCU read-side critical sections is: (1) Any region code protected by
rcu_read_lock() and friends, and (2) Any region of code where preemption
is disabled that does not contain a call to schedule().

							Thanx, Paul

> > > This is very similar to the percpu_down_read_internal() fast-path.
> > >
> > > The reason this is significant for PowerPC is that it uses the generic
> > > this_cpu_*() implementation which relies on local_irq_disable() (the
> > > x86 implementation relies on it being a single memop instruction to be
> > > IRQ-safe). Switching to preempt_disable() and __this_cpu*() avoids
> > > this IRQ state swizzling. Also, PowerPC needs LWSYNC for the ACQUIRE
> > > barrier, not having to use explicit barriers safes a bunch.
> > > 
> > > Combined this reduces the performance gap by half, down to some 5%.
> > 
> > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > Sebastian

