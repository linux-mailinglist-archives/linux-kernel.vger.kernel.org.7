Return-Path: <linux-kernel+bounces-797123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4910AB40C21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19068563366
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111723451B4;
	Tue,  2 Sep 2025 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r/WsGZa4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1R5Ud52C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042752E0919
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834367; cv=none; b=s9XgLLOSnF/mFLfaBIja1O1jnTfmAKZMaaYCILqeKzOKQ3xHp/5iQuvsSzVDncaS6aJbWJBr6eetwKxvvlsytXFL6OUvqNSPmGIBbhc7U4WAcw9lDddfebtmws1wonWK2WymMj7IVJJR+7HlLQy7jE2bISFKsu1m71xKn++zKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834367; c=relaxed/simple;
	bh=t+fHihyGu3KCbChPFlZcoznzCcilj+lA4bQr5OWn2ME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NJQakkVW1OhPdVabXBdBDnyHjqGFNgxJoKc+IdNx4rufLVadzw5+2fOokktXOF0va0XcBM2pspG0yQnvDRjET8+tUzMM1VdLWQ0CjB+AQvZ5FhXZ4P67HUMJqJtN1OXkQWHxfoKefuGlMZiyrgh6r1WiGFf+lqHhWrzHvItrh30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r/WsGZa4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1R5Ud52C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756834364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H0cW7II2MIUrhNTSRyYVPIclUd2zrwbpxV7RNbGinWg=;
	b=r/WsGZa42/7fn+olSOkkASXPruY2/l3s0ALLTVrlLaHHEVpmbrV8kVIMM0S46SCTGe/tIM
	xnY34sjnPIfbLLc1/89ZFoZHgw1nVuDGs0C1gHR6Man9U1ItKYjXGsb0k43nTcvCzqsBMu
	b2ktQTr+/SFw0JLPFamPkjXzu/rnKT/WiHBL47iqA6GPgCAGs6JbaotKmClIs5sYb5ucZH
	pSHzz/mcbAYBuD+xcv4Az1odjs/da8o2fu2ql7SZ3CSH2zeA2FN9emisB3iau+RZ6EC90T
	CDpaWeVt4oX3qrEqFYIYB7vzsG0UroSDDnXzXr/NEIu9HrLd08yTd3UYfjnCDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756834364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H0cW7II2MIUrhNTSRyYVPIclUd2zrwbpxV7RNbGinWg=;
	b=1R5Ud52Cjz7ZigdMqoWcWFGX9ETOtaCSurFuFrHb1XME3rHJMd+Qb3Aeow5MA4dFwshcIA
	W4vQhC7+7OcZ8qAg==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Sean
 Christopherson <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Huacai
 Chen <chenhuacai@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patch V2 25/37] rseq: Rework the TIF_NOTIFY handler
In-Reply-To: <0610d1be-15b4-40a6-8bec-307e62f810bb@efficios.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161654.869197102@linutronix.de>
 <0610d1be-15b4-40a6-8bec-307e62f810bb@efficios.com>
Date: Tue, 02 Sep 2025 19:32:42 +0200
Message-ID: <87o6rszrnp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 26 2025 at 11:12, Mathieu Desnoyers wrote:
> On 2025-08-23 12:40, Thomas Gleixner wrote:
>> +void __rseq_handle_notify_resume(struct pt_regs *regs)
>> +{
>> +	/*
>> +	 * If invoked from hypervisors before entering the guest via
>> +	 * resume_user_mode_work(), then @regs is a NULL pointer.
>> +	 *
>> +	 * resume_user_mode_work() clears TIF_NOTIFY_RESUME and re-raises
>> +	 * it before returning from the ioctl() to user space when
>> +	 * rseq_event.sched_switch is set.
>> +	 *
>> +	 * So it's safe to ignore here instead of pointlessly updating it
>> +	 * in the vcpu_run() loop.
>
> I don't think any virt user should expect the userspace fields to be
> updated on the host process while running in guest mode, but it's good
> to clarify that we intend to change this user-visible behavior within
> this series, to spare any unwelcome surprise.

Actually it is not really a user-visible change.

TLS::rseq is thread local and any update to it becomes only visible to
user space once the vCPU thread actually returns to user space. Arguably
no guest has legitimately access to the hosts VCPU thread's TLS.

You might argue, that GDB might look at the thread's TLS::rseq while the
task runs in VCPUs guest mode. But that's completely irrelevant because
once a task enters the kernel the RSEQ CPU/NODE/MM ids have no meaning
anymore. They are only valid as long as the task runs in user space.
When a task hits a breakpoint GDB can only look at the state _before_
that and that's all what it can see when it looks at the TLS of a
thread, which voluntarily went into the kernel via the KVM ioctl.

That update is truly a kernel internal implementation detail and it got
introduced way _after_ the initial RSEQ implementation.

Before 5.9 KVM ignored most of the pending TIF work including
TIF_NOTIFY_RESUME. Once that got fixed it turned out that handling the
other TIF_NOTIFY_RESUME work could result in losing an RSEQ update. To
cure that the rseq handler got pulled in to that TIF_NOTIFY_RESUME
demultiplexing function and gained that NULL pointer check inside to
exclude the critical section check.

In hindsight RSEQ should have used a separate TIF bit right from the
beginning, but that's water under the bridge...

Thanks,

        tglx



