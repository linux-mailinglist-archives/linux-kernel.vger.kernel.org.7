Return-Path: <linux-kernel+bounces-856630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8CEBE4A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 555C7544C04
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBEF330D5E;
	Thu, 16 Oct 2025 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BodyCeZR"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CD332AAD1
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632890; cv=none; b=iCTp6isMo1aDmEZ6n97PS27YVCr0JN66/WMZnIx/fSlow5W8O8ekfoz7X7dYiI91qB/z5aPXKh2ACxPy3ce5ee/A0j79wqK/jXRGeLjQULExcByKPPq++WE4gv3vhepk8i3LNuXItsvlb4pEDFjOGAgbNe1mjwnHAzQJk5vvOi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632890; c=relaxed/simple;
	bh=5b1uR8avD8EX9RbCfc4WzXyX47hnxxWVjpS3uPNgpoM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q14eYUYQNzqZsTgw+74Ws5dyrWnegMO7kZk3NexsFYFz+xHVUqfiI/RHSbQJicGdgE8a7B0tPoMSPdbXyJnTJ3aBUsy5Cgczd69qaBXVcFve1a5gwpNIdZX3bhmch5ADQwjHbU91VzY+L6RoDzqd0eYo7pajGp9gGOQYg+tRjzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BodyCeZR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3352a336ee1so1916933a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760632887; x=1761237687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aqPVZGf9T95ct2jENQJ/yrYIEM39mRcHNNeOoVIpqFE=;
        b=BodyCeZRQf8EZA6lxMp52+7EVaV5Jdxo4dpoCPuqy0qnv2Qdy1MTLw1PsQvth4XWv7
         oxrdvsVJUbnHLPAWbAz2vtGk8w+4sGckC44O4yRKFK1MhYpkS+0Jlyo7jM1LtUjBKyg3
         KBBmQec8v7nBpZvN6QFNuuYtj4fY60PnO4PzwIxJKdjzzEV7QdLp3JXOBW/hURjYRfch
         bFcn1a29dFI52u3zsmkcJugoKTWBSxq4sjr6uqS2P7WV0YWjrg5rU+k42CbUXeDAJ6Wi
         3AOIhoB4bG8Whm1c3vDXDVb0O4b57V0/mtHyjN8SWJVr1aNmPf/WvZUcx6L/3BviEF8y
         abwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760632887; x=1761237687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqPVZGf9T95ct2jENQJ/yrYIEM39mRcHNNeOoVIpqFE=;
        b=Q+yF5P2WVg5J+enx/27nb2FckM265PfNvbt098q7DGj0A8oTRI8Nl+CQWJXj75LlVw
         dvRlqpRR1imTI6qlB3eCzkgMpWDAFJHwaOxkNspszqaIHt4IDD0/hOJeVtrXgNJk3r7i
         oE4w7D7AVQA1R9YM7OtyNRN7VMrVbZ3s9TkLKwCP2s2PYfCUSrucr4VK1lKB37lc00ZF
         wU6OY7kDih7K1hYGS7vt4FRyzOfXF59Th5eclclmjg7Z8SjlVNbK8A09+qCd9tNqbgVQ
         Ui55jcZBpsZdad/auNQc94dJblkaNT8XbqoL6zb/GCTouVOSdOllb7eWNmct7mMNBmkW
         KkDA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ1N/5V0aWFdyS++CPQoUNkdfqmGG5aCL5Oj/9t3O/H2q9jSAyviUgjS28RxyJGM4bu4IoXPqqFaaPVy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2kbldWnWwFZyvx2KKZ1yz8TT2YO32aO+qAcl2hVZib6NQbEwU
	gZxerXSN4CcsDGcfjHHlP8Pmd/1fKXkOQdacCRRZafPgEKdGilkNr4ZfqSgU1G6xftayYW/KVib
	r20fbJQ==
X-Google-Smtp-Source: AGHT+IGhQCW4K3xGX6fHaK8K6Q7a6yeDvd3mZnDRJdbIdt8yNVVVAesk9LWWVf9TBIUrZur8H6SkRRXBuRY=
X-Received: from pjbpm17.prod.google.com ([2002:a17:90b:3c51:b0:33b:b692:47b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2690:b0:32e:d16c:a8c6
 with SMTP id 98e67ed59e1d1-33bcf87d120mr509076a91.16.1760632887537; Thu, 16
 Oct 2025 09:41:27 -0700 (PDT)
Date: Thu, 16 Oct 2025 09:41:25 -0700
In-Reply-To: <DDJVZU914RVD.1HXRX01BELY4L@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251015-b4-l1tf-percpu-v2-1-6d7a8d3d40e9@google.com>
 <aPEULoJUUadbb3nn@google.com> <DDJVZU914RVD.1HXRX01BELY4L@google.com>
Message-ID: <aPEgNdjr0j4LdSYq@google.com>
Subject: Re: [PATCH v2] KVM: x86: Unify L1TF flushing under per-CPU variable
From: Sean Christopherson <seanjc@google.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 16, 2025, Brendan Jackman wrote:
> On Thu Oct 16, 2025 at 3:50 PM UTC, Sean Christopherson wrote:
> > On Wed, Oct 15, 2025, Brendan Jackman wrote:
> >> Currently the tracking of the need to flush L1D for L1TF is tracked by
> >> two bits: one per-CPU and one per-vCPU.
> >> 
> >> The per-vCPU bit is always set when the vCPU shows up on a core, so
> >> there is no interesting state that's truly per-vCPU. Indeed, this is a
> >> requirement, since L1D is a part of the physical CPU.
> >> 
> >> So simplify this by combining the two bits.
> >> 
> >> The vCPU bit was being written from preemption-enabled regions. For
> >> those cases, use raw_cpu_write() (via a variant of the setter function)
> >> to avoid DEBUG_PREEMPT failures. If the vCPU is getting migrated, the
> >> CPU that gets its bit set in these paths is not important; vcpu_load()
> >> must always set it on the destination CPU before the guest is resumed.
> >> 
> >> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> >> ---
> >
> > ...
> >
> >> @@ -78,6 +79,11 @@ static __always_inline void kvm_set_cpu_l1tf_flush_l1d(void)
> >>  	__this_cpu_write(irq_stat.kvm_cpu_l1tf_flush_l1d, 1);
> >>  }
> >>  
> >> +static __always_inline void kvm_set_cpu_l1tf_flush_l1d_raw(void)
> >> +{
> >> +	raw_cpu_write(irq_stat.kvm_cpu_l1tf_flush_l1d, 1);
> >> +}
> >
> > TL;DR: I'll post a v3 with a slightly tweaked version of this patch at the end.
> >
> > Rather than add a "raw" variant, I would rather have a wrapper in arch/x86/kvm/x86.h
> > that disables preemption, with a comment explaining why it's ok to enable preemption
> > after setting the per-CPU flag.  Without such a comment, choosing between the two
> > variants looks entirely random
> >
> > Alternatively, all writes could be raw, but that
> > feels wrong/weird, and in practice disabling preemption in the relevant paths is a
> > complete non-issue.
> 
> Hm, why does making every write _raw feel weird but adding
> preempt_disable() to every write doesn't? Both feel equally weird to me.

I completely agree that both approaches are odd/weird.

> But the latter has the additional weirdness of using preempt_disable()
> as a way to signal "I know what I'm doing", when that signal is already
> explicitly documented as the purpose of raw_cpu_write().

True.  Aha!

With the #ifdefs in place, KVM doesn't need arch/x86/include/asm/hardirq.h to
provide a wrapper.  irq_stat is already exported, the wrapper exists purely so
that kvm_set_cpu_l1tf_flush_l1d() can be invoked without callers having to check
CONFIG_KVM_INTEL.

Not yet tested, but how about this?

static __always_inline void kvm_request_l1tf_flush_l1d(void)
{
#if IS_ENABLED(CONFIG_CPU_MITIGATIONS) && IS_ENABLED(CONFIG_KVM_INTEL)
	/*
	 * Use a raw write to set the per-CPU flag, as KVM will ensure a flush
	 * even if preemption is currently enabled..  If the current vCPU task
	 * is migrated to a different CPU (or userspace runs the vCPU on a
	 * different task) before the next VM-Entry, then kvm_arch_vcpu_load()
	 * will request a flush on the new CPU.
	 */
	raw_cpu_write(irq_stat.kvm_cpu_l1tf_flush_l1d, 1);
#endif
}

