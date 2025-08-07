Return-Path: <linux-kernel+bounces-759252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F7AB1DB02
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C657258EF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0277B262FE6;
	Thu,  7 Aug 2025 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z4NT5Pr+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vPXmgSTM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E200F2528F7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754581776; cv=none; b=LW96N4lvxJFjROdG7+hCC0JbSgt7JSPgsRwHVlwwhA+1QjdHgTzeS4TQ/lfzyJ1KgVPcUoOYAMwVy/4QWVMoHhL6fJ0DYWjxeS/cQXTtnR7uVVslXDien1NIP1vr0/ZUZQKjOUe8hnA1TCGf9wy6xX7nZPSsciSC3uVbRuEHmx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754581776; c=relaxed/simple;
	bh=WFr/gKTSVj67oOJqXVUcwXdGsZmIexqWWRTJaCEIZWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJip5H1tdHGf0SgzJxF/UdkOyaeDPBjX5uHHnMY6/qv2B1xmjJtUd1Gg+yaFHfssBMWj2m75j7fpVurLallSLfCN8ysmOkX6BciaaBvPu/79OYlqfTKF8NjkJU/D0ek6dRrlb6jDJsFeycN1amHW9cQi4pWn2Ee5SNVw1gwDXjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z4NT5Pr+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vPXmgSTM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 7 Aug 2025 17:49:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754581771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vg0fBlM3Xy11uHUlRTsjiMCsXySl1087EGrPp8lXIgs=;
	b=z4NT5Pr+POZMDa7h9M8qlxJI7SNC3HpqdprM3QxpGyRpAX5VVi8374th8xYTu2bJ7Bs8zM
	Xxk+n7ii9XZU41onLagxy0/EiAmF2JKIOlLcHG9r39WMyAvuhCqx9l08Gvc5rJp2da3pvh
	DXlATTe06kHzeQZTaFYzKNIPQ8ibFZHUBRXJ78c+6Kn8YwKvYMDieqicn1eIUlzO7HxVVS
	o2gW/lHEqN/G1Zb16kJ9qWxW3g6FmGT+dBWn6+Yz5QbS1hO2W/FNWRe1auPtCswcv76bD1
	4Lc+AcWyKHHCG7qEq7Mv+Zlm5HCGXe1U76t2DJXEUa+1UT+kp9NCL69u4MBc3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754581771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vg0fBlM3Xy11uHUlRTsjiMCsXySl1087EGrPp8lXIgs=;
	b=vPXmgSTMGNbjPVtJ5B3I0zacsObwq9fvm7SWNhbov1n6ndz+gZQ8sfm62ujxnt32CRRNYc
	0cPlS/rfMQocACDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	kprateek.nayak@amd.com, vineethr@linux.ibm.com
Subject: Re: [PATCH V7 01/11] sched: Scheduler time slice extension
Message-ID: <20250807154929.4Wpr6V4N@linutronix.de>
References: <20250724161625.2360309-2-prakash.sangappa@oracle.com>
 <87ms8cchqf.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87ms8cchqf.ffs@tglx>

On 2025-08-06 22:34:00 [+0200], Thomas Gleixner wrote:
> On Thu, Jul 24 2025 at 16:16, Prakash Sangappa wrote:
>=20
> The obvious way to solve both issues is to clear NEED_RESCHED when
> the delay is granted and then do in syscall_enter_from_user_mode_work()
>=20
>         rseq_delay_sys_enter()
>         {
>              if (unlikely(current->rseq_delay_resched =3D=3D GRANTED)) {
> 		    set_tsk_need_resched(current);
>                     schedule();
>              }      =20
>         }     =09
>=20
> No?
>=20
> It's debatable whether the schedule() there is necessary. Removing it
> would allow the task to either complete the syscall and reschedule on
> exit to user space or go to sleep in the syscall. But that's a trivial
> detail.

Either schedule() or setting NEED_RESCHED is enough.

> The important point is that the NEED_RESCHED semantics stay sane and the
> problem is solved right on the next syscall entry.
>=20
=E2=80=A6
> > +static inline bool rseq_delay_resched(unsigned long ti_work)
> > +{
> > +	if (!IS_ENABLED(CONFIG_RSEQ_RESCHED_DELAY))
> > +		return false;
> > +
> > +	if (unlikely(current->rseq_delay_resched !=3D RSEQ_RESCHED_DELAY_PROB=
E))

The functions and the task_struct member field share the same.

> > +		return false;
>=20
> Why unlikely? The majority of applications do not use this.
>=20
> > +
> > +	if (!(ti_work & (_TIF_NEED_RESCHED|_TIF_NEED_RESCHED_LAZY)))
> > +		return false;
>=20
> The caller already established that one of these flags is set, no?

correct, and if they are set, this never gets to false.

> > +	if (__rseq_delay_resched()) {
> > +		clear_tsk_need_resched(current);
>=20
> Why has this to be inline and is not done in __rseq_delay_resched()?

A SCHED_OTHER wake up sets _TIF_NEED_RESCHED_LAZY so
clear_tsk_need_resched() will revoke this granting an extension.

The RT/DL wake up will set _TIF_NEED_RESCHED and
clear_tsk_need_resched() will also clear it. However this one
additionally sets set_preempt_need_resched() so the next preempt
disable/ enable combo will lead to a scheduling event. A remote wakeup
will trigger an IPI (scheduler_ipi()) which also does
set_preempt_need_resched().

If I understand this correct then a RT/DL wake up while the task is in
kernel-mode should lead to a scheduling event assuming we pass a
spinlock_t (ignoring the irq argument).
Should the task be in user-mode then we return to user mode with the TIF
flag cleared and the NEED-RESCHED flag folded into the preemption
counter.

I am once again asking to limit this to _TIF_NEED_RESCHED_LAZY.

> > +		return true;
> > +	}
> > +	return false;
>=20

=E2=80=A6

> Thanks,
>=20
>         tglx

Sebastian

