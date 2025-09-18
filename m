Return-Path: <linux-kernel+bounces-808932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DF3B506AC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DBB1B27648
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C48304BBA;
	Tue,  9 Sep 2025 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pY9xwt5G"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC11258EE9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448226; cv=none; b=LNV4drFuq97cyduQtrrPphTFFsRki8wXzgpFvbQXGSZsrVSqBJOMCL7TvdN5O5WCy+1yoOtQJF3dIt9qivttVjT2pjoqRdroPDHLWUsDLTuow4fJZaRVL3gdRmQUZVpOJD0KFyYN6msBUv647dD3KhxXGy0rtLTIflfBOJRdku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448226; c=relaxed/simple;
	bh=LdYN8MDVrw/vEmJHgw2beVqu/KZUZJzdNOG0uxgwmcQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n8n4eJWsyQ5xQ0hk6mQ8Zqhb/MeL8w4qLJOZl1pInZ/bLpRvayu+pggSG1VMQ9DA0reoYgcgafImStB1pv67CnT5NfilkIPlkv4Ua4i9mssC6pus9uE6dV8qSEX2P8c263EshsPPsSF1LKvuHXYHHK+VbHkdg9DUob5pC9BQCqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pY9xwt5G; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24ce3e62946so84345395ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 13:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757448224; x=1758053024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4ZS4UTQml9A1DLb0eVwlPnvEcdHxOGXLB0T09I3m+o=;
        b=pY9xwt5GJfuOUs0kebsBHHL5NUAnVecyG26o9z+IcDGNesIM8UGjVDWOPLhnyWsGCF
         RcTPtESdPCl9oWoQB3hrSt7LaAD8SD0dAl/H30RBS3t0IpP26aYYdq2CPtS2KOdv2Csl
         Dx2YLoBoFA2pUrFCEZHxaGCnwj7jqlc10DAJKJThwsNAJiBRr5s0Dv0ThUFT3M9x5aj7
         0AAAkNkc4CapnZCnxND76QSCVR4Lfr8fA/RAFRufPzgm4/NC6Nmgxwri1fI3Xy3yzAis
         zqTGMvq60eR56ChM0lSr/AP01hBUUlx6/b7+JIyTtrMZcZG0F0Lo5wJ0dTlmPPm4Gvxo
         fFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757448224; x=1758053024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4ZS4UTQml9A1DLb0eVwlPnvEcdHxOGXLB0T09I3m+o=;
        b=le+s3kmeGlhUBCCcNpClLVbkUd3Br6QQb0Zod0wStb6bluHKkxDK8+nxLBHG/MwQdG
         B2s0dbxVx64QujHj7eSSkPQ5pgO+Q5YmhISU3fDJl0VCieTNSgYm9IPk4DTcqbjIBFYs
         NxtGBJr3b4mkuypjK7Xs0ZcSUOx5DYSRB/WZ+KYo7YGFX+em0tYD+NQVCPywHSUv/dJ0
         J4C1nLvfEhjrwlNFhk+fiQA/ovQ82OORmmGl1Ui3JQgX6Z695SxuvNfX6rt8hufgz4yA
         6WEpaGlamDJZkxYlFz/3X0zIYG78DzA1ge+1NLfNnuhRgBViZmuYXgNjQmzHyqoC4HTu
         paJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIyILuSENzPaSBCA0+OL1QCHQ1+uNgPcqq1/0VJDKRPjh6qmqyQW+zlO4rTQrvjPuMckw+R5r/4R53dg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC8b2764uIn2YcK00sqfnnk4IF3mAypQw6jupX2I4/zFMnBG+L
	zGmOFCebSOOmGM9xEgKjmd+sXXyIul4mLh2dd+De1g2orDyEJeCGTj1Rwg4gs5KnNwuLTOM4qUW
	DHEFByw==
X-Google-Smtp-Source: AGHT+IHkemhohmCjqrISJAC5OGjCoW2vAjjMIqxgV1MrCrglKnhd+JJ4v9LMaB4PZUENUcVVuTTsmDta1zc=
X-Received: from pjyd16.prod.google.com ([2002:a17:90a:dfd0:b0:32b:5548:d659])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc4f:b0:24e:8a54:accc
 with SMTP id d9443c01a7336-2516fbdaf52mr152410875ad.13.1757448224426; Tue, 09
 Sep 2025 13:03:44 -0700 (PDT)
Date: Tue, 9 Sep 2025 13:03:43 -0700
In-Reply-To: <aL/i6cA6EjjZ1H6f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821133132.72322-1-chao.gao@intel.com> <20250821133132.72322-6-chao.gao@intel.com>
 <b61f8d7c-e8bf-476e-8d56-ce9660a13d02@zytor.com> <aKvP2AHKYeQCPm0x@intel.com> <aL/i6cA6EjjZ1H6f@intel.com>
Message-ID: <aMCIH-0dtjbSbWiI@google.com>
Subject: Re: [PATCH v13 05/21] KVM: x86: Load guest FPU state when access
 XSAVE-managed MSRs
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Xin Li <xin@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, john.allen@amd.com, 
	mingo@redhat.com, minipli@grsecurity.net, mlevitsk@redhat.com, 
	pbonzini@redhat.com, rick.p.edgecombe@intel.com, tglx@linutronix.de, 
	weijiang.yang@intel.com, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 09, 2025, Chao Gao wrote:
> On Mon, Aug 25, 2025 at 10:55:20AM +0800, Chao Gao wrote:
> >On Sun, Aug 24, 2025 at 06:52:55PM -0700, Xin Li wrote:
> >>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> >>> index 6b01c6e9330e..799ac76679c9 100644
> >>> --- a/arch/x86/kvm/x86.c
> >>> +++ b/arch/x86/kvm/x86.c
> >>> @@ -4566,6 +4569,21 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >>>   }
> >>>   EXPORT_SYMBOL_GPL(kvm_get_msr_common);
> >>> +/*
> >>> + *  Returns true if the MSR in question is managed via XSTATE, i.e. is context
> >>> + *  switched with the rest of guest FPU state.
> >>> + */
> >>> +static bool is_xstate_managed_msr(u32 index)
> >>> +{
> >>> +	switch (index) {
> >>> +	case MSR_IA32_U_CET:
> >>
> >>
> >>Why MSR_IA32_S_CET is not included here?

Because the guest's S_CET must *never* be resident in harware while running in
the host.  Doing so would create an egregious security issue due to letting the
guest disabled IBT and/or shadow stacks, or alternatively crash the host by
enabling one or the other.

Having guest MSR_IA32_PL[0-3]_SSP resident in hardware while the _kernel_ is
running is safe, because those MSRs are only consumed on transitions to lower
privilege levels, i.e. from KVM's perspective, they're effectively user-return
MSRs that get restored on exit to userspace thanks to kvm_{load,put}_guest_fpu()
context switching between VMM and guest state (if the vCPU task is preempted,
the normal context switch code handles swapping state between tasks, it's only
the VMM vs. guest state that needs dedicated handling since they are the same
task).

Context switching S_CET as part of XRSTORS very, VERY subtly works by virtue of
S_CET already being loaded with the host's value on VM-Exit.  I.e. the value
saved into guest FPU state is always the host's value, and thus the value loaded
from guest FPU state is always the host's value.

And because all of that isn't enough, the final wrinkle is that KVM_{G,S}ET_XSAVE
only operate on xcr0 / user state, i.e. don't allow userspace to load supervisor
(S_CET) state into the kernel.

> >Emm. I didn't think about this
> >
> >MSR_IA32_S_CET is read from or written to a dedicated VMCS/B field, so KVM
> >doesn't need to load the guest FPU to access MSR_IA32_S_CET. This pairs with
> >the kvm_{get,set}_xstate_msr() in kvm_{get,set}_msr_common().
> >
> >That said, userspace writes can indeed cause an inconsistency between the guest
> >FPU and VMCS fields regarding MSR_IA32_S_CET. If migration occurs right after a
> >userspace write (without a VM-entry, which would bring them in sync) and
> >userspace just restores MSR_IA32_S_CET from the guest FPU, the write before
> >migration could be lost.
> >
> >If that migration issue is a practical problem, I think MSR_IA32_S_CET should
> >be included here, and we need to perform a kvm_set_xstate_msr() after writing
> >to the VMCS/B.
> 
> I prefer to make guest FPU and VMCS always consistent regarding MSR_IA32_S_CET.
> The cost is to load guest FPU before userspace accesses the MSR and save guest
> FPU after that. It isn't a problem as MSR_IA32_S_CET accesses from userspace
> shouldn't be on any hot-path. So, I will add:
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 989008f5307e..92daf63c9487 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2435,6 +2435,7 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> 		break;
> 	case MSR_IA32_S_CET:
> 		vmcs_writel(GUEST_S_CET, data);
> +		kvm_set_xstate_msr(vcpu, msr_info);

As explained above, this is a fatal flaw, as it will allow userspace to write an
arbitrary value to S_CET.

> 		break;
> 	case MSR_KVM_INTERNAL_GUEST_SSP:
> 		vmcs_writel(GUEST_SSP, data);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a3770e3d5154..6f64a3355274 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4647,6 +4647,7 @@ EXPORT_SYMBOL_GPL(kvm_get_msr_common);
>  static bool is_xstate_managed_msr(u32 index)
>  {
> 	switch (index) {
> +	case MSR_IA32_S_CET:

And this is wrong too.  I'll add a big comment to explain all of this, especially
since I just spent an entire morning re-learning how all of this works.  *sigh*

> 	case MSR_IA32_U_CET:
> 	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:

