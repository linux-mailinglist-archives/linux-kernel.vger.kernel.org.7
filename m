Return-Path: <linux-kernel+bounces-800564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB8EB43949
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4FE17944F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318BA2F90E2;
	Thu,  4 Sep 2025 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HSthlnpA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FYqsm6XK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8B2571DA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756983240; cv=none; b=dGWB9V9obzfMz2l4dUY5araBOs/mcn/VMmJwXYQrxJSoJK2ABDu0ZtXK1Nsq6xn3bYSQDCYZK+ktLAJIl/eOhzbO6SHH0Af/bCLe7X5vpTAez4l7bS0cEUxVoyz3eimUcIHGqqemkprZTWUMLefmnu+bTchIXhlkibmlRWVpNBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756983240; c=relaxed/simple;
	bh=vL9kP0x4DF6DaHBZg4pnpaWpGodkCss2AAiVXgt5HX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LkDhACN8wyt3h6SAzUhsGvo04EkRJPkNz4PVSXmYrcdMZn32P7KLr2vGN8nL1PvDyt3GRyDoS9RQaO17gWD1jhzdyVUP89pxgqmu85d3AhLPOjZuF6/CQK3X62ZZCqmFvHvvekshH2c4jenAPpk6gjmjQ42WwnOUl92CRUSgdmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HSthlnpA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FYqsm6XK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756983236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AmB7w6xlmrwhQ+REPeeMMK1Is18J/ZJDUSQ7czuRif0=;
	b=HSthlnpAS0PLN9KfAWP9VU69lUmXWqMFw8DIO1ASDrybn0Hy4KtfyDsNROxF6g/paAi4hT
	fO9JtwgWNq9fyZkX2m/QsF867HLSFuBadQc0LOMJuSVML8cV9mP0RgQK4zboGhh3mi4FSA
	nkDwAWDIl7EZG179IATEuyKlezPwkrttmr5mGOP9Fqptp/+nKcKRmBaIuo4se+ucr8SsNX
	7qANOdfBysVJ61yGRLs7oyuaaSumExwTTUaLX2b6svaJ4JFtrpHkveL5tkAszMwCf9k0ys
	6ypNFKsz5/4IAO5t31ZIA2unTBR2HjBGR6YumLVd1feHc7WWWVxip/cjN8hzXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756983236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AmB7w6xlmrwhQ+REPeeMMK1Is18J/ZJDUSQ7czuRif0=;
	b=FYqsm6XK1QTUyQsB0fcmLxSEPuLZxLcAJn4vnid/YkHL325Pvd9FULN8cKM4uUk+OBargI
	27MeFckhmxaJErBA==
To: Sean Christopherson <seanjc@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Peter
 Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens
 <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>
Subject: Re: [patch V2 25/37] rseq: Rework the TIF_NOTIFY handler
In-Reply-To: <aLlhSmeA_TPSheyu@google.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161654.869197102@linutronix.de>
 <0610d1be-15b4-40a6-8bec-307e62f810bb@efficios.com> <87o6rszrnp.ffs@tglx>
 <aLlhSmeA_TPSheyu@google.com>
Date: Thu, 04 Sep 2025 12:53:55 +0200
Message-ID: <87ldmuxzcs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 04 2025 at 02:52, Sean Christopherson wrote:
> On Tue, Sep 02, 2025, Thomas Gleixner wrote:
>> > I don't think any virt user should expect the userspace fields to be
>> > updated on the host process while running in guest mode, but it's good
>> > to clarify that we intend to change this user-visible behavior within
>> > this series, to spare any unwelcome surprise.
>> 
>> Actually it is not really a user-visible change.
>
> It's definitely a user-visible change in the sense that userspace, via the guest,
> will see different behavior.
>
>> TLS::rseq is thread local and any update to it becomes only visible to
>> user space once the vCPU thread actually returns to user space. Arguably
>> no guest has legitimately access to the hosts VCPU thread's TLS.
>> 
>> You might argue, that GDB might look at the thread's TLS::rseq while the
>> task runs in VCPUs guest mode. But that's completely irrelevant because
>> once a task enters the kernel the RSEQ CPU/NODE/MM ids have no meaning
>> anymore. They are only valid as long as the task runs in user space.
>
> Paravirt setups, e.g. hoisting host-controlled workloads into VMs, have explored
> (ab)using rseq.  In such setups, host threads are often mapped 1:1 to vCPUs, in
> which case the pCPU in particular becomes interesting.

Why am I not suprised?

>> When a task hits a breakpoint GDB can only look at the state _before_
>> that and that's all what it can see when it looks at the TLS of a
>> thread, which voluntarily went into the kernel via the KVM ioctl.
>> 
>> That update is truly a kernel internal implementation detail and it got
>> introduced way _after_ the initial RSEQ implementation.
>
> Yes, but that doesn't change the fact that a user _could_ have come to depend on
> the current behavior sometime in the last ~5 years.

So it depends on a kernel internal implementation detail which happened
to be introduced by chance rather by design and without any guaranteed
behaviour vs. a guest.

> I'm ok formally stating that exposing rseq directly to a KVM guest is unsupported,
> but I would like to explicitly call out and document the change.

Fair enough. I've amended the change log accordingly.

If that turns out to be a real world problem, then it needs to be
brought back explicitly into the virt TIF work handling code, but I
prefer not to :)

Thanks,

        tglx

