Return-Path: <linux-kernel+bounces-796904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 354E8B40912
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70AD3A869E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F3B312830;
	Tue,  2 Sep 2025 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GC5HieO3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bM2xTufd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D45725EFBF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827475; cv=none; b=U0me1HKt+dqjXGmXrm/TNatufrSpxkXwtHBapz8kpxq6x9WIWMmDXijnOCiXwkZSlx+lWxzL3NgfnTMhcf8vhYMYKZU0CWa2pQmVzllYRmNISDcYejU6tUGkKptC9t+OTthCK5slIrSGUDfNtBb9gdASg8QrLVv/6KjFGIjNmJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827475; c=relaxed/simple;
	bh=W7Z/+xnHZ2xAtg7hetdlcN5zb+B5wk7QAXYp8SuxHNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jd54IrluONcdj/QneiKNDxBA3x9ZbxWPfBYrJW8CNpWgLc/FJdVIG4aMJyiVvw6Wr918S9CbzPBaSOrSRDuWIuqCisvAmuXF51bgp1C6od7GdraKvWHPaeqFE+u5bw4OoWDdPVRsyyf5K14fuoBpxouV7ob60UY2j2Vzj0a4td4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GC5HieO3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bM2xTufd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756827471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2voFApd0L/2HaIu7XOE6XjtZ1FUtQO3zfVOc0FfCnfA=;
	b=GC5HieO3uhwTXWruc7N4ZGreN/z9DlWuJSNPNrqbUgiRUU+VzwW5WYr4O6mEA3elDHSvTS
	cokNewrpmnvhPdctSN+xePx8rPFIg1q/+0o8ZjA0kEcfdY3ihzNXSyI1D8FualvUoAfsMM
	V5cdRSCI1yAuYijyCVSWKjKePiEP7Zdxo0oDmtFGLN3m4IU+4OI2bC2w3Fzlqec7yJDB7y
	VWLqIfPAW2Yc//W+6iLcnblMxIKO0iKSaqfeizeJjLx1xb1gCR+0VFWjgJsSf5DxsLVw+C
	yCa2VsPpLo94VTiBQA8HdwOgB1bM0HGLxP3PMDeRL8BkN+vX2W5m4h5ZlB2t4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756827471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2voFApd0L/2HaIu7XOE6XjtZ1FUtQO3zfVOc0FfCnfA=;
	b=bM2xTufdcO5L0yixJMv0GBIzu7ZdfpJu382PVImqJRQYYvPKFlfojXT+gmJEMH2r3iWaZn
	MeYvMjoH+eog8eCA==
To: Sean Christopherson <seanjc@google.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, Paolo
 Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Peter Zijlstra <peterz@infradead.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens
 <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>
Subject: Re: [patch V2 07/37] rseq, virt: Retrigger RSEQ after vcpu_run()
In-Reply-To: <aKzGZjyEQq3u-M68@google.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161653.711118277@linutronix.de>
 <d8c69b7a-43ca-41b7-af8a-6eb1772c55a4@efficios.com>
 <aKzGZjyEQq3u-M68@google.com>
Date: Tue, 02 Sep 2025 17:37:50 +0200
Message-ID: <87zfbczwz5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 25 2025 at 13:24, Sean Christopherson wrote:
> On Mon, Aug 25, 2025, Mathieu Desnoyers wrote:
>> > @@ -4466,6 +4467,8 @@ static long kvm_vcpu_ioctl(struct file *
>> >   		r = kvm_arch_vcpu_ioctl_run(vcpu);
>> >   		vcpu->wants_to_run = false;
>> > +		rseq_virt_userspace_exit();
>
> I don't love bleeding even more entry/rseq details into KVM.

Neither do I.

> Rather than optimize KVM and then add TIF_RSEQ, what if we do the
> opposite?

I'm not optimizing KVM. I'm simplifying the RSEQ parts to ignore
TIF_NOTIFY_RESUME when invoked with @regs == NULL.

> I.e. add TIF_RSEQ to XFER_TO_GUEST_MODE_WORK as part of "rseq: Switch
> to TIF_RSEQ if supported", and then drop TIF_RSEQ from
> XFER_TO_GUEST_MODE_WORK in a new patch?

The problem is that I have to keep all the architectures which

    - do not use the generic entry code
    - therefore can't be switched trivially over to the TIF_RSEQ scheme
    - have RSEQ support enabled

alive and working.

> That should make it easier to revert the KVM/virt change if it turns
> out PV setups are playing games with rseq,

I can't find a hint of such an insanity in kernel, so *shrug*.

If there is out of tree code which plays games with the vCPU's user
space thread::TLS::rseq, then it rightfully breaks. The update, which
happens today, is just coincidence and a kernel internal implementation
detail.

> and it would give the stragglers (arm64 in particular) some
> motiviation to implement TIF_RSEQ and/or switch to generic TIF bits.

There is enough motivation in this series to do so :)

Thanks,

        tglx

