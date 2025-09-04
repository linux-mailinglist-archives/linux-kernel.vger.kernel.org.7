Return-Path: <linux-kernel+bounces-800442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 365D7B4379F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F431C24A71
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7449D2F9980;
	Thu,  4 Sep 2025 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZMFMJwT"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D792263C7F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979536; cv=none; b=pV0mfTDZR80Ua6kZ63+PWwBBdHY399LKitwcm2TIlw2h6R93Dlq9ckLK4pBpCBR58dH8Id79xmwvI5RfmfHVV926e+QBAa+5J3Ebww+yrqPZpQKaR4AFMPFo+z9Df2al8ohQK9obRIr8ikPl97/VUAnDk79O3cwxlRUus4gPNZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979536; c=relaxed/simple;
	bh=tXNM8QV1V6KcBb1Bjk/lG9wjgckN0gP7b34w2jg1jAU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iEo2+yoepsxy2UIDxKVGvaXbX8Pxw5s+r7X9LgAqvLVrqIkA4MOvy08/94CBYalok+PMycKAtA9bqu5plnezjddlvjZgtbZ9hMOtLJ3LPfaDS65J4yiQkdeWdfE3I9MrrKe5uoNujWzrMSGIff3+ro2mmuAbsYMp60RsQdjBaQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iZMFMJwT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4e796ad413so954966a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756979534; x=1757584334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bm1YkdG6kE4HKg21BLIKgodQsrmQe4L1Q/x5CEkKd/I=;
        b=iZMFMJwT7ajetTi+DL5jInRxG39OObIxGi2FPe0N9qB6hDvgSWQSST5AGoyv7BdOCi
         6YO9wehgJQ35U4d0oJVesdhSWUpSoiFKSAgThZrDgXZQVARqy8gnT0BK75jskHL87uqY
         ygaqiv6fy0CYVNNQ0MJcPDWa33fLrVHu59j3/njdwHbmk7jTbBCBkDRTVOgZReh87+k6
         Annm0GuZXeN6b4BoNoXYX0jnS3IAzYEXnG8qZHspDjyFJr1W4WceSTxdssOvG3xuL2W7
         pjWCM9ZRDsv0JXWco5/+yO46uCgJqT8J/J1GfGusIXw8gArtyPtj8qbRgXs6I/+AtcGZ
         84Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756979534; x=1757584334;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bm1YkdG6kE4HKg21BLIKgodQsrmQe4L1Q/x5CEkKd/I=;
        b=R0vsQe+XJFO/mkRwFX3THE2qQMYr4CEhOtgrz123XNpkAiTtHYq5wV0tOBpYND5GAq
         +E03ELPMc42vAbQcZkNLYW41GeO/0VwJfKemYNtskxBLnlSbEvvRqSj3GpPVq8fzRYyb
         imkqmhVpwEyAb98Ymc+KGC+6wBLz+gt2W7t+Nct7vmlZLHbEnfK4UgjtpWUHY1GRA7f/
         nkMLTtURFawVSebSiyxphmZ2sSzEKl5WCOZ7BtgAhaBqs9J/o+TfLOuzkAg2iZSw0G3P
         FXhb70FZ6XKMS7wK/QnqU8/1zPsDSKSAOt4mbSvWHaG149yKkHbBcp6xmHTiytxTdn+n
         oELg==
X-Forwarded-Encrypted: i=1; AJvYcCXkO0OG6RPT5rHvPVnhhHikjh2Wi8hqoiSWUKBfIlN+/uAhDPZY0aHN2BzYhzKGBwFO5KFBgm73oWP7BOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqynbzaPsnFay4wlw3RmKPZA4PrU9jOpaJhL3iew8vOEAr+ELc
	So5+6436mAGPC2E+VM5NvPr/RAIuD2Fjz4YDySUmkt24zb5ToWZ0b/h0OFOsVcV9nszhXRWzY2h
	kr7S5sw==
X-Google-Smtp-Source: AGHT+IFnZt2GEMhxdaJFhnVx39AzVGEQAIxMmtzYNM3ULz4lI81MMTcvwP1bl9/Oaf+xpP4hwYy7Nt3zb5I=
X-Received: from pjoo15.prod.google.com ([2002:a17:90b:582f:b0:329:ec3d:72ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:544c:b0:32b:6eed:d203
 with SMTP id 98e67ed59e1d1-32b6eedd3bamr6490437a91.24.1756979534366; Thu, 04
 Sep 2025 02:52:14 -0700 (PDT)
Date: Thu, 4 Sep 2025 02:52:10 -0700
In-Reply-To: <87o6rszrnp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823161326.635281786@linutronix.de> <20250823161654.869197102@linutronix.de>
 <0610d1be-15b4-40a6-8bec-307e62f810bb@efficios.com> <87o6rszrnp.ffs@tglx>
Message-ID: <aLlhSmeA_TPSheyu@google.com>
Subject: Re: [patch V2 25/37] rseq: Rework the TIF_NOTIFY handler
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 02, 2025, Thomas Gleixner wrote:
> On Tue, Aug 26 2025 at 11:12, Mathieu Desnoyers wrote:
> > On 2025-08-23 12:40, Thomas Gleixner wrote:
> >> +void __rseq_handle_notify_resume(struct pt_regs *regs)
> >> +{
> >> +	/*
> >> +	 * If invoked from hypervisors before entering the guest via
> >> +	 * resume_user_mode_work(), then @regs is a NULL pointer.
> >> +	 *
> >> +	 * resume_user_mode_work() clears TIF_NOTIFY_RESUME and re-raises
> >> +	 * it before returning from the ioctl() to user space when
> >> +	 * rseq_event.sched_switch is set.
> >> +	 *
> >> +	 * So it's safe to ignore here instead of pointlessly updating it
> >> +	 * in the vcpu_run() loop.
> >
> > I don't think any virt user should expect the userspace fields to be
> > updated on the host process while running in guest mode, but it's good
> > to clarify that we intend to change this user-visible behavior within
> > this series, to spare any unwelcome surprise.
> 
> Actually it is not really a user-visible change.

It's definitely a user-visible change in the sense that userspace, via the guest,
will see different behavior.

> TLS::rseq is thread local and any update to it becomes only visible to
> user space once the vCPU thread actually returns to user space. Arguably
> no guest has legitimately access to the hosts VCPU thread's TLS.
> 
> You might argue, that GDB might look at the thread's TLS::rseq while the
> task runs in VCPUs guest mode. But that's completely irrelevant because
> once a task enters the kernel the RSEQ CPU/NODE/MM ids have no meaning
> anymore. They are only valid as long as the task runs in user space.

Paravirt setups, e.g. hoisting host-controlled workloads into VMs, have explored
(ab)using rseq.  In such setups, host threads are often mapped 1:1 to vCPUs, in
which case the pCPU in particular becomes interesting.

> When a task hits a breakpoint GDB can only look at the state _before_
> that and that's all what it can see when it looks at the TLS of a
> thread, which voluntarily went into the kernel via the KVM ioctl.
> 
> That update is truly a kernel internal implementation detail and it got
> introduced way _after_ the initial RSEQ implementation.

Yes, but that doesn't change the fact that a user _could_ have come to depend on
the current behavior sometime in the last ~5 years.

I'm ok formally stating that exposing rseq directly to a KVM guest is unsupported,
but I would like to explicitly call out and document the change.

