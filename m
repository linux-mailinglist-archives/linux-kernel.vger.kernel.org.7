Return-Path: <linux-kernel+bounces-782697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1584DB323CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA8B44E062A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33982FCBF7;
	Fri, 22 Aug 2025 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tCNXTSfN"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75E82BCF46
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 20:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755896079; cv=none; b=a3+gsL/Zq0Cy8nEbq+Hkad1BndbuJzvEcU6yMap/sOSUnlD1Go/4YfGpQCGXJaLBmxL8d3kU47QkWWHSCVT8DkcgOdxLI54XA+USvCSpB1LNSrPDcdfcKXF+5KVmBEr2aI3I2QMD1c2vIkbeiPt/8ATIUSwZM1j+cgvv782fHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755896079; c=relaxed/simple;
	bh=1ml9cP/F8jht6mr/WdPwrpiZvX/USpp6ahfk4q7p+7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XcJCGWswcbEPtnQ5Bj0JWg5AppvFSo5PuXUMSDgpjFAZz2XAxzorm9vpiFAZ/znJmjqf82otVjbID8uQ2mB579AfXPaEDDiOChRA8oMP/K404jRNlYqNYttCeW+BZ0UaQNHmjbly1QTOSPAiuJ+5jTrB28FTqbJ8QLQfqAm4Q6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tCNXTSfN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457ef983fso50908985ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755896077; x=1756500877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qoGsok8ax9ANgqhEfYfFzNj29eee9JEF8TtR6Jw5Ls=;
        b=tCNXTSfNS/4nWekX/t4EfpDVgr8a4HoOfKrQ0V1Zi91Hx80SvDQPLavlBwh65/NDUo
         nOnn0zlkPJ8PxTY7YG0JLIuO7JFO7+/rkj7RWClS0qTPGMYmWEmxkDhVtcMrD2LXqog1
         xMJqq3QyKmAV7OquExxXhEfDIMREgGXIFpoJ7+xUEL4I4nGbKAiXd2t3u9eE50FDXoLX
         eOOYJf3WCb3gb1vaA2I/u/3Y/Lklz/8EGbIWmJMtNwSjRkhRSgRjP6KNGt1Mg2lDO7Jb
         yfukZZrNuF0QBzjn0LSMIoHt0ya03DoFEjJ3ljW5aF7FXKK6Fgi/NfBY/XjlWXWHc7TX
         swEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755896077; x=1756500877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qoGsok8ax9ANgqhEfYfFzNj29eee9JEF8TtR6Jw5Ls=;
        b=XWDJsxMu4eZxHWvf9Cxchk5eIS6TByQWJE1lfB4vGGscGSSUAYUz723dH7e9NxmTpi
         icB8Ul3nMPY3To/rzR4pBF0f2dbr32v8xmv9q6Xs0auxLjn/FqgPFAAmfTpyWGVLQmCZ
         C9a75WZDopoMHcDoY7HIXgzMAuKdW9HdC1bJncQzES0rCwmTHDICBgbH6DYDbFWkie1C
         He86J2Y0PQYBWh0LYck4FKuwuH0/x8zp1XgeBoQWJVqhJH7SKVC87/dtm7IC1DNP/B08
         A/GIgh+yIJNUaPhfAWn3qG8f1oyF0LS6ouWWD5Injc8BRtH5SDjADSIp3231fGyFnStE
         q0Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUV/5ajEB74Ytapr877emENMP+sECYLnhg4Ee4o/Gciqtem6JkzU4Bj/AfIE3aWqa0JsubC63hpcNrbqNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEaA+UosxaUs8A63rHKf/3UfIFJn2hFEDXxU9DRavL7Ih+MQaR
	bhvpDcsYDemrpFKA4KFuWSYloPzjEbL9t5zivFXGaslAc/i4dUQjdCmTns6CbTTVpNvVrx55Xhi
	kQglF0Q==
X-Google-Smtp-Source: AGHT+IHGCqV6hiRFqaBvONeHtVVp5VM1BXrYesclvI0pJ5OQl5SzJOVxJ8kHtf3elBS4oakmh5ZQVoFZp8Y=
X-Received: from pjvb16.prod.google.com ([2002:a17:90a:d890:b0:31f:b2f:aeed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1249:b0:240:3dbb:7603
 with SMTP id d9443c01a7336-2462edf1af9mr69750505ad.19.1755896077020; Fri, 22
 Aug 2025 13:54:37 -0700 (PDT)
Date: Fri, 22 Aug 2025 13:54:35 -0700
In-Reply-To: <zx4aiu65mmk72mo2kooj52q4k3vsp43znlrdadajivsw6ns7ou@7xtzfms3de66>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1755609446.git.maciej.szmigiero@oracle.com>
 <2b2cfff9a2bd6bcc97b97fee7f3a3e1186c9b03c.1755609446.git.maciej.szmigiero@oracle.com>
 <aKeDuaW5Df7PgA38@google.com> <zx4aiu65mmk72mo2kooj52q4k3vsp43znlrdadajivsw6ns7ou@7xtzfms3de66>
Message-ID: <aKjZC3peGKPj9NPq@google.com>
Subject: Re: [PATCH 1/2] KVM: SVM: Sync TPR from LAPIC into VMCB::V_TPR when
 setting LAPIC regs
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 22, 2025, Naveen N Rao wrote:
> On Thu, Aug 21, 2025 at 01:38:17PM -0700, Sean Christopherson wrote:
> > On Tue, Aug 19, 2025, Maciej S. Szmigiero wrote:
> > > +	/*
> > > +	 * Sync TPR from LAPIC TASKPRI into V_TPR field of the VMCB.
> > > +	 *
> > > +	 * When AVIC is enabled the normal pre-VMRUN sync in sync_lapic_to_cr8()
> > > +	 * is inhibited so any set TPR LAPIC state would not get reflected
> > > +	 * in V_TPR.
> > 
> > Hmm, I think that code is straight up wrong.  There's no justification, just a
> > claim:
> > 
> >   commit 3bbf3565f48ce3999b5a12cde946f81bd4475312
> >   Author:     Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> >   AuthorDate: Wed May 4 14:09:51 2016 -0500
> >   Commit:     Paolo Bonzini <pbonzini@redhat.com>
> >   CommitDate: Wed May 18 18:04:31 2016 +0200
> > 
> >     svm: Do not intercept CR8 when enable AVIC
> >     
> >     When enable AVIC:
> >         * Do not intercept CR8 since this should be handled by AVIC HW.
> >         * Also, we don't need to sync cr8/V_TPR and APIC backing page.   <======
> >     
> >     Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> >     [Rename svm_in_nested_interrupt_shadow to svm_nested_virtualize_tpr. - Paolo]
> >     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > That claim assumes APIC[TPR] will _never_ be modified by anything other than
> > hardware. 
> 
> It also isn't clear to me why only sync_lapic_to_cr8() was gated when 
> AVIC was enabled, while sync_cr8_to_lapic() continues to copy V_TRP to 
> the backing page. If AVIC is enabled, then the AVIC hardware updates 
> both the backing page and V_TPR on a guest write to TPR.
> 
> > That's obviously false for state restore from userspace, and it's also
> > technically false at steady state, e.g. if KVM managed to trigger emulation of a
> > store to the APIC page, then KVM would bypass the automatic harware sync.
> 
> Do you mean emulation due to AVIC being inhibited? I initially thought 
> this could be a problem, but in this scenario, AVIC would be disabled on 
> the next VMRUN, so we will end up sync'ing TPR from the lapic to V_TPR.

No, if emulation is triggered when AVIC isn't inhibited.  E.g. a contrived but
entirely possible situation would be if MOVBE isn't supported in hardware, KVM
is emulating MOVBE for emulation, and the guest sets the TPR via MOVBE.  The MOVBE
#UDs, KVM emulates in response to the #UD, and Bob's your uncle.

There are other scenarios where KVM would emulate, though they're even more
contrived.

> > There's also the comically ancient KVM_SET_VAPIC_ADDR, which AFAICT appears to
> > be largely dead code with respect to vTPR (nothing sets KVM_APIC_CHECK_VAPIC
> > except for the initial ioctl), but could again set APIC[TPR] without updating
> > V_TPR.
> >
> > So, rather than manually do the update during state restore, my vote 
> > is to restore the sync logic.  And if we want to optimize that code 
> > (seems unnecessary), then we should hook all TPR writes.
> 
> I guess you mean apic_set_tpr()? 

Yep.

> We will need to hook into that in addition to updating
> avic_apicv_post_state_restore() since KVM_SET_LAPIC just does a memcpy of the
> register state.

Yeah, or explicitly call the hook, e.g. like kvm_apic_set_state() does for
hwapic_isr_update().  But I don't think we should add a hook unless someone
proves that unconditionally synchronizing before VMRUN affects performance.

> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index d9931c6c4bc6..1bfebe40854f 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -4046,8 +4046,7 @@ static inline void sync_lapic_to_cr8(struct kvm_vcpu *vcpu)
> >         struct vcpu_svm *svm = to_svm(vcpu);
> >         u64 cr8;
> >  
> > -       if (nested_svm_virtualize_tpr(vcpu) ||
> > -           kvm_vcpu_apicv_active(vcpu))
> > +       if (nested_svm_virtualize_tpr(vcpu))
> >                 return;
> >  
> >         cr8 = kvm_get_cr8(vcpu);
> 
> I agree that this is a simpler fix, so would be good to do for backport 
> ease.
> 
> The code in sync_lapic_to_cr8 ends up being a function call to 
> kvm_get_cr8() and ~6 instructions, which isn't that much. But if we can 
> gate sync'ing V_TPR to the backing page in sync_cr8_to_lapic() as well, 
> then it might be good to do so.
> 
> 
> - Naveen
> 

