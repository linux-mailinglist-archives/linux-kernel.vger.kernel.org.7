Return-Path: <linux-kernel+bounces-813309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B89B54360
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78255A57C0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC142289E30;
	Fri, 12 Sep 2025 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DuB71VKe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aT+AtM7L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9846A8D2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757660301; cv=none; b=Snzef5uM8AKYuUwdSxM08bf2jx6Uei277qa5N/z48ZDHu3YAaS1V5qYbvBAr0cXp2d+TBpBufuhsJOoA5HcAAHq96wZ8nvG85EQTXwpNx5XL6d+7NwuwYQY4eq5Ogk4sXLLAtFNBCy3ZC1Vlv37R8+8k2tz8mtP/qp0WAnCsCag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757660301; c=relaxed/simple;
	bh=q9G0fba5jvhf5MUfAghmTDdtPNy24PO18VHjsWhlIFw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m04OifBU2QmGHUzzoi87A7n/1gSi3RkCjYlGGDPArEutU3Ismygm87tR0VI2zEcacgBS4KuSN4yRuoj3fFsZYq0SMaQPjgHX2Wuj2hLfcx8Y2e1Ft77ifuUbz1VMW9sGpvKApulobmUaLMtWjgJX21kkJLVHDjl990xF9y0GolA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DuB71VKe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aT+AtM7L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757660297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xwp6LBrVbFO6XGEG3JCRGWhVbCu0Nj5SbsW5xu6o3bU=;
	b=DuB71VKexkDUVf/KqePM7C64r+FkonARo7EEgPDuQaqQiRHPDJQx2FSfTRTknywgBtWlv8
	0yVgu0w9kz3+9fKYQ6LXAuqd5ci+YEa1PaqjMIchr9pc8Q++Qk+HVPT3oOFmnMK7+4mXea
	mOj+GekMoSq2RcTwhxU3305Jew20okmNozDswVpMo6O7A5u8YOQwphvf+psBStyX1qcO7o
	z0VFi7+g3ZGvi797LvXnAdw2t2XLf3/iMwwGd1m5M8prjX1w+dhEIXW3Ugcya5XhD8RtFz
	N8ODc0LzVtVEHy8EGaCqNFrz/5BHQ80MeM7S3ayuM29+bPlPUW1pMLNnMCT+PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757660297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xwp6LBrVbFO6XGEG3JCRGWhVbCu0Nj5SbsW5xu6o3bU=;
	b=aT+AtM7LFStfZ9d0JE+qeCC2eFLPAh4vnTYTgxV65OxnHNBj//7MpdDYGvlXGx6HMI2Wx6
	0GMvPa+I8bNenvDA==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patch V4 26/36] rseq: Optimize event setting
In-Reply-To: <1cdacbf9-9564-4025-a5a8-777211a1fc2d@efficios.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212926.929787629@linutronix.de>
 <6e0bcd7c-f842-4db0-b30b-5f6857b45b66@efficios.com> <871podrn2i.ffs@tglx>
 <1cdacbf9-9564-4025-a5a8-777211a1fc2d@efficios.com>
Date: Fri, 12 Sep 2025 08:58:16 +0200
Message-ID: <87jz24qhrr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 11 2025 at 13:15, Mathieu Desnoyers wrote:
> On 2025-09-11 12:06, Thomas Gleixner wrote:
>> On Thu, Sep 11 2025 at 10:03, Mathieu Desnoyers wrote:
>>> On 2025-09-08 17:32, Thomas Gleixner wrote:
>>>>    static inline void rseq_handle_notify_resume(struct pt_regs *regs)
>>>>    {
>>>> -	if (current->rseq.event.has_rseq)
>>>> +	/* '&' is intentional to spare one conditional branch */
>>>> +	if (current->rseq.event.sched_switch & current->rseq.event.has_rseq)
>>>
>>> I wonder.. except for the corner case of rseq unregistration,
>>> when can we have sched_switch set but not has_rseq ?
>>>
>>> We could remove a load from the fast path and the AND if we
>>> clear the sched_switch flag on rseq unregistration.
>> 
>> We probably could. Though I doubt it matters much and I opted for
>> correctness instead of premature optimization.
> Note that this concerns code that documents an explicit " & " as
> intentional to spare a branch, which led me to assume that optimizing
> it was important.

Correct. Optimization and correctness are not mutually exclusive and it
was an obvious optimization to spare the second branch which the
compiler is forced to emit with &&.

A load/AND from them same cache line is definitely cheaper than an extra
conditional branch.

I'm happy to look into that once the dust has settled...

Thanks,

        tglx

