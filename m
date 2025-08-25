Return-Path: <linux-kernel+bounces-785499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B9AB34BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFBB51B21649
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58F3287257;
	Mon, 25 Aug 2025 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QV21P/zk"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8746221723
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153450; cv=none; b=azGy+DCz9eYV8U/idDH7N2XECJ5e68GWf6vLlkcaCZQtdVobCHPWLoTZwOb4wys/C35C2pQovYMA7USgl07/QEt/y967Dtn4QsfjDEjn1rYaiQe9Ue6JSo1uKwPbETTb7HnnMBdg0df6lupJGcbgHgefzMKQ0aE2kgaYDbYEyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153450; c=relaxed/simple;
	bh=oBYsy2dGjp8KZ+/DuQQXTbF9GxJ8i62u5vDSrFY6u6U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EV+orEMg2tTyfGi4UsiOovnugk+rRR62Ufo/n0WbCiXUvuGZRJhtmfUJlDv8oH7p4N5yMZNelqYUtKvwIH78CiEmd24essFOErKWGXe/9twpWpPz5aPsSjPWsLsZYLOrhn1mzjq3fRkMgJtHxzH6W0ktO3Q9FzQ78McZ+JyUSfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QV21P/zk; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-325ce108e16so1394472a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756153448; x=1756758248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X3irZq2EKmo98nOKk8/qdYJ67a9zE2koGg2BwOtXngs=;
        b=QV21P/zknAayhTRK1bgjhEcqUvKHBIeo+tm1ZJqsMRJEymP7+y92or9j0jpFks0bZA
         gm2vQO0WClkDfLja1FXetqoDVC+d86JhTXOM9fKbVfq0FO1GvYNR5nq9lIFSfHiS/wMJ
         WN0VeI/zCAjbghrZXEgSYdkQQGfdC8soLxKSQgMr6Hv9GGkcmctDz7iC6NoYi54EE0yP
         h6C2le2j3ihVZm5fafj4ypp0atD2udrAfwhR80Nh932NdnYR4rIsH61U6TtPvlXwu0TW
         T0nRumYTViGMc+SCwpSPRNbPNgl5i2dzgtgFDMb5mG5A8gukssCSW6K2N/inev+exPEp
         qqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756153448; x=1756758248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3irZq2EKmo98nOKk8/qdYJ67a9zE2koGg2BwOtXngs=;
        b=UV8YHxoxbu09C1Xgbvj5CA4Q8yV/nrYd8uhVsFDd54020g8kgOWa6Pg/t6R6h1LvEE
         mXyOIjUPb7VblK2gTRa+w9chUWMP3mC+M7XzZdEdfNK2NAedYS3WoFf74V0FfPHyXjJs
         EJ1aQi1oBygza9F3sphzEOs9t8yd+brQcxIMDsHi5FKZGytGviFUBhDg5o+4jTtU3lG9
         UQpPdDCSwdEC6euvrBcHen17B3NAalBv8W+ZiBomW0+SMdheLgE50PTYK66AI1rAF+e/
         BN4fGK4/lGnZ3+HDQ2ztCKJei1+Rtfj4VHGsoqvlJWhEGVP7ASo/qHVU1O3EOZSDPRO4
         8R4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxdqEXYkX4iIFYei+tDVXUIUP09FnySDdraDgmBiFapiAWIJJJqWTrL/Al2Z3woxx5MfXpMmqoUHc/xuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUxEfw9LseF0AfrwyZzJHroL4kTI8hgqJ4twXVPD0fKswfzM1y
	RRp42lWzOzHjoEQETsk2jpsWMVUOFw6s3EM2NHPXA0O+YO42AVwPdEfThfkbr6HZMWFz8TW+Ijl
	lFKTcfw==
X-Google-Smtp-Source: AGHT+IGwSliumLLZwtOwblP8ltBFgmo3oudUxKkWK+mqldI+5rfcEHefLHov/ZF8h7oqksZygjXg/VzI3qE=
X-Received: from pjay6.prod.google.com ([2002:a17:90a:1546:b0:325:620d:ed89])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f91:b0:325:83:e1d6
 with SMTP id 98e67ed59e1d1-32515ee21bbmr14999385a91.2.1756153447982; Mon, 25
 Aug 2025 13:24:07 -0700 (PDT)
Date: Mon, 25 Aug 2025 13:24:06 -0700
In-Reply-To: <d8c69b7a-43ca-41b7-af8a-6eb1772c55a4@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823161326.635281786@linutronix.de> <20250823161653.711118277@linutronix.de>
 <d8c69b7a-43ca-41b7-af8a-6eb1772c55a4@efficios.com>
Message-ID: <aKzGZjyEQq3u-M68@google.com>
Subject: Re: [patch V2 07/37] rseq, virt: Retrigger RSEQ after vcpu_run()
From: Sean Christopherson <seanjc@google.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Peter Zijlstra <peterz@infradead.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 25, 2025, Mathieu Desnoyers wrote:
> On 2025-08-23 12:39, Thomas Gleixner wrote:
> > Hypervisors invoke resume_user_mode_work() before entering the guest, which
> > clears TIF_NOTIFY_RESUME. The @regs argument is NULL as there is no user
> > space context available to them, so the rseq notify handler skips
> > inspecting the critical section, but updates the CPU/MM CID values
> > unconditionally so that the eventual pending rseq event is not lost on the
> > way to user space.
> > 
> > This is a pointless exercise as the task might be rescheduled before
> > actually returning to user space and it creates unnecessary work in the
> > vcpu_run() loops.
> 
> One question here: AFAIU, this removes the updates to the cpu_id_start,
> cpu_id, mm_cid, and node_id fields on exit to virt usermode. This means
> that while the virt guest is running in usermode, the host hypervisor
> process has stale rseq fields, until it eventually returns to the
> hypervisor's host userspace (from ioctl).
> 
> Considering the rseq uapi documentation, this should not matter.
> Each of those fields have this statement:
> 
> "This field should only be read by the thread which registered this data
> structure."
> 
> I can however think of use-cases for reading the rseq fields from other
> hypervisor threads to figure out information about thread placement.
> Doing so would however go against the documented uapi.
> 
> I'd rather ask whether anyone is misusing this uapi in that way before
> going ahead with the change, just to prevent surprises.
> 
> I'm OK with the re-trigger of rseq, as it does indeed appear to fix
> an issue, but I'm concerned about the ABI impact of skipping the
> rseq_update_cpu_node_id() on return to virt userspace.
> 
> Thoughts ?

I know the idea of exposing rseq to paravirtualized guests has been floated (more
than once), but I don't _think_ anyone has actually shipped anything of that 
nature.

> > @@ -49,6 +49,7 @@
> >   #include <linux/lockdep.h>
> >   #include <linux/kthread.h>
> >   #include <linux/suspend.h>
> > +#include <linux/rseq.h>
> >   #include <asm/processor.h>
> >   #include <asm/ioctl.h>
> > @@ -4466,6 +4467,8 @@ static long kvm_vcpu_ioctl(struct file *
> >   		r = kvm_arch_vcpu_ioctl_run(vcpu);
> >   		vcpu->wants_to_run = false;
> > +		rseq_virt_userspace_exit();

I don't love bleeding even more entry/rseq details into KVM.  Rather than optimize
KVM and then add TIF_RSEQ, what if we do the opposite?  I.e. add TIF_RSEQ to
XFER_TO_GUEST_MODE_WORK as part of "rseq: Switch to TIF_RSEQ if supported", and
then drop TIF_RSEQ from XFER_TO_GUEST_MODE_WORK in a new patch?

That should make it easier to revert the KVM/virt change if it turns out PV setups
are playing games with rseq, and it would give the stragglers (arm64 in particular)
some motiviation to implement TIF_RSEQ and/or switch to generic TIF bits.

