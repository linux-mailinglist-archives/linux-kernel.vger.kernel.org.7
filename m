Return-Path: <linux-kernel+bounces-810790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EA6B51F76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A7E188BC6D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE23A26E71C;
	Wed, 10 Sep 2025 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jvdVsR8M"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977942737F2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526623; cv=none; b=cGcPhxdK2vtJGoudoPijyo24TsPIQ46dtkpdFHOUVw94UD+CLA4wPYqUmgI25+2nmt/VR4hXvp83vb5L+BcsV0Md7/khqo0mYcqFnlSZDW5Ev8Yj+hi2BO0u/cE+FxNpWYLrvxADkyexpB0NKD2u1ZJUyVfvtAVn5nojj0+YQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526623; c=relaxed/simple;
	bh=kPnVJMDAr/6Z3m/fScpPLFT8Oxlrmeg2w8pvxqaiJI8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AOFgqF6BYjEaZTBj01BkUUFFTlFdyOtmsIiBv06VQtbP0nqJ++dcGKeAFGEp2be4dMi1iXQgYwEBvfunRvwwQwZOo1JnQxZPslJAvpw4BWBWKAy1q2hxbcxbMzEo3W1kqOqkb9yNdEkDzmSfx+HJLtSE/m7JALHNdRoTmtgVCK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jvdVsR8M; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7722ef6c864so6678834b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757526621; x=1758131421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IUgfnEy4aH7Vf+d3WQbxgyXPH/BkEH0zY6EdXplzY4A=;
        b=jvdVsR8MAD/2AdHbrYttFysLT1a/tDQB7eV1NH/VzcKcEqwEu91fvHM6TIHN1TjUvG
         KBVY9ExIMTIbFYdx+R9PPtSC9S86kjvT1kjR5A5hO1ZGInRkleTntJ8Z/OLoSYjAeFtI
         Wtz1G+D0Bc983qvFhd9n+9W9crb0YhDR5SfA27HDUoAGHFE6QPlCooOzYROiQROjUUi+
         J9zoe3dZXIXtBT4wIJb39DUrlbh31NMvB/tKk4iR18++Z+qMpL5pb9iOxg6olbunyN+3
         eOYBQf7eZQViBHOEvKDsMcEKRyktgd57an+zMJt2QIVCq2rziLaE+3F8zCFbGw2CvWok
         9T9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757526621; x=1758131421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUgfnEy4aH7Vf+d3WQbxgyXPH/BkEH0zY6EdXplzY4A=;
        b=XfQgi8qmCG8DTIDYPVLKw/SYXkiRPgd+XCg0GYVvT/N+oKMLenFzzNYilDi6AtcVc+
         B4gc6Kg1Kbo33QHJDA9GfpXwKb3ZK9b2BxjjH4na5LV/eK+Mw+I2SvOwpVUPtHDD6zKB
         kElGYyGJ+ThHAmdjBQVi6UQjIGnp0yqHCFnU+HaDUEpcpTVlGF+AwcMRiSfl0LGbDHLV
         rT9qTNZfIU4AP4olYp8WPz7h3LTuBNDksraFLg/krf1oQZN6N/Q1I/T3fyCRWQCfruRd
         Dyi3AAYhknr4/pGp/oz5Z1y1+Ci72AmSqbxshyNpIQIemBrVnvrupMv1X/5jKDyBV3Au
         x/bw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Dw8c3cbgldmMC6DOxwRoK4ymNPeIkPgJtfKD2Q4juhoZBeDMtL8DqzaWHrMqc8PIdhaxov5R4wWncfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfHgU0A2xgzIYHBbuprpeQ3i3QnFYA62tYqFHpjH6DdmMAwNmx
	MWS6/aKRt7u0mFWIWq+mhqS3rUz5moFAQQ4jSM8EK5NruOy8ybJeZTok38+jc9acCsh/CSUS7bX
	8lx5Ddg==
X-Google-Smtp-Source: AGHT+IE0PBz+CoprrtHW8pDY4jQGWJaV/o6dVyl7o9HIHMuSqSir0HcUrugd2aROC3ZRJusmLA1OpAmyzDs=
X-Received: from pfll7.prod.google.com ([2002:a05:6a00:1587:b0:772:2f71:c54b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2316:b0:772:4759:e45d
 with SMTP id d2e1a72fcca58-7742de8f0e6mr20966795b3a.22.1757526620819; Wed, 10
 Sep 2025 10:50:20 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:50:19 -0700
In-Reply-To: <aMFedyAqac+S38P2@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909093953.202028-1-chao.gao@intel.com> <20250909093953.202028-7-chao.gao@intel.com>
 <be3459db-d972-4d46-a48a-2fab1cde7faa@intel.com> <aMFedyAqac+S38P2@intel.com>
Message-ID: <aMG6Wx9k2T47OTge@google.com>
Subject: Re: [PATCH v14 06/22] KVM: x86: Load guest FPU state when access
 XSAVE-managed MSRs
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acme@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	john.allen@amd.com, mingo@kernel.org, mingo@redhat.com, 
	minipli@grsecurity.net, mlevitsk@redhat.com, namhyung@kernel.org, 
	pbonzini@redhat.com, prsampat@amd.com, rick.p.edgecombe@intel.com, 
	shuah@kernel.org, tglx@linutronix.de, weijiang.yang@intel.com, x86@kernel.org, 
	xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 10, 2025, Chao Gao wrote:
> On Wed, Sep 10, 2025 at 05:37:50PM +0800, Xiaoyao Li wrote:
> >On 9/9/2025 5:39 PM, Chao Gao wrote:
> >> From: Sean Christopherson <seanjc@google.com>
> >> 
> >> Load the guest's FPU state if userspace is accessing MSRs whose values
> >> are managed by XSAVES. Introduce two helpers, kvm_{get,set}_xstate_msr(),
> >> to facilitate access to such kind of MSRs.
> >> 
> >> If MSRs supported in kvm_caps.supported_xss are passed through to guest,
> >> the guest MSRs are swapped with host's before vCPU exits to userspace and
> >> after it reenters kernel before next VM-entry.
> >> 
> >> Because the modified code is also used for the KVM_GET_MSRS device ioctl(),
> >> explicitly check @vcpu is non-null before attempting to load guest state.
> >> The XSAVE-managed MSRs cannot be retrieved via the device ioctl() without
> >> loading guest FPU state (which doesn't exist).
> >> 
> >> Note that guest_cpuid_has() is not queried as host userspace is allowed to
> >> access MSRs that have not been exposed to the guest, e.g. it might do
> >> KVM_SET_MSRS prior to KVM_SET_CPUID2.
> 
> ...
> 
> >> +	bool fpu_loaded = false;
> >>   	int i;
> >> -	for (i = 0; i < msrs->nmsrs; ++i)
> >> +	for (i = 0; i < msrs->nmsrs; ++i) {
> >> +		/*
> >> +		 * If userspace is accessing one or more XSTATE-managed MSRs,
> >> +		 * temporarily load the guest's FPU state so that the guest's
> >> +		 * MSR value(s) is resident in hardware, i.e. so that KVM can
> >> +		 * get/set the MSR via RDMSR/WRMSR.
> >> +		 */
> >> +		if (vcpu && !fpu_loaded && kvm_caps.supported_xss &&
> >
> >why not check vcpu->arch.guest_supported_xss?
> 
> Looks like Sean anticipated someone would ask this question.

I don't think so, I'm pretty sure querying kvm_caps.supported_xss is a holdover
from the early days of this patch, e.g. before guest_cpu_cap_has() existed, and
potentially even before vcpu->arch.guest_supported_xss existed.

I'm pretty sure we can make this less weird and more accurate:

/*
 * Returns true if the MSR in question is managed via XSTATE, i.e. is context
 * switched with the rest of guest FPU state.  Note!  S_CET is _not_ context
 * switched via XSTATE even though it _is_ saved/restored via XSAVES/XRSTORS.
 * Because S_CET is loaded on VM-Enter and VM-Exit via dedicated VMCS fields,
 * the value saved/restored via XSTATE is always the host's value.  That detail
 * is _extremely_ important, as the guest's S_CET must _never_ be resident in
 * hardware while executing in the host.  Loading guest values for U_CET and
 * PL[0-3]_SSP while executing in the kernel is safe, as U_CET is specific to
 * userspace, and PL[0-3]_SSP are only consumed when transitioning to lower
 * privilegel levels, i.e. are effectively only consumed by userspace as well.
 */
static bool is_xstate_managed_msr(struct kvm_vcpu *vcpu, u32 msr)
{
	if (!vcpu)
		return false;

	switch (msr) {
	case MSR_IA32_U_CET:
		return guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) ||
		       guest_cpu_cap_has(vcpu, X86_FEATURE_IBT);
	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
		return guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK);
	default:
		return false;
	}
}

Which is very desirable because the KVM_{G,S}ET_ONE_REG path also needs to
load/put the FPU, as found via a WIP selftest that tripped:

  KVM_BUG_ON(!vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm);

And if we simplify is_xstate_managed_msr(), then the accessors can also do:

  KVM_BUG_ON(!is_xstate_managed_msr(vcpu, msr_info->index), vcpu->kvm);

