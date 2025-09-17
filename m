Return-Path: <linux-kernel+bounces-820890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69B4B7F937
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26953A3D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84400323407;
	Wed, 17 Sep 2025 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hpu5usbN"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9383233F2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116681; cv=none; b=jQCEYKQg2/fxFZnOxZi9LzqMr4URHH4Q8YdSJ0efj+lzEeOGbDexk5w+53E8d/PgDHSJl/C+FlcLHGlOAJqqR7K36wYC9xSWi/Xp0HdvXxVNNzMjAakGDXcz4cnpY1/ISgwSPIT8HkPP5yZOHVG1jjBSOeT4E+w8Sj1Ids68xPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116681; c=relaxed/simple;
	bh=ZJi7tdLPjgYbZFKjMGd/qK5hFXM6pG4kVFcidSClXdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qop1X8A4/pE3H+R1JhpAdjhyRnZwimvIYqexalmR7uh4WU6IW3YAHgj9oAXVGZCZDkQkL8BIlUJVEx7/ws+raMwi4wN2ujaa4jjHsMN2qd4AUEhEajcUKU3nqYgaUAc7aJhNeVgnakSYYShclZbhgCxItLznwg4FG4NXVUz/H4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hpu5usbN; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-772537d9f4aso5654264b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758116679; x=1758721479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5UH8viusCcDJDonuj7qTEeANJ2KzlVzvu/LxOGcZpS0=;
        b=hpu5usbNbjYjcz14Td1kYjMn8K/9P21WwiRRbHlNHhp+KQM+C0oSzN/y7cV8Ij4pgv
         GicgxeTgr6YIKHIJ9loVIY9dp975lUs+o8AtOJ7EK1aRxwqAZ+SuXq64OTawsHz59vTJ
         9w9FDtzAYIU3DF1LvqIgY7OFhbQWRSHBdTiU8tAPef7ofePxAWem4sC8fMF2fxJTp3/g
         l06BPANKu7hdxyH6MDZHs4e1QHdeah4zZShzHJQYSWSGQMv6buR9RJgKnEdDDn6KpVpU
         09yP6/ITgRQomMRL1W8h/0cy5/PDZLF0ApojszG+EspP3Cd4oSxX+AojmeEtmv5yZgvd
         FeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116679; x=1758721479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5UH8viusCcDJDonuj7qTEeANJ2KzlVzvu/LxOGcZpS0=;
        b=T4PkTy9RW/J/CniXzeGBNErtLM5JHOf3w918BOWN3xJ0zg9UT0j1Fg+j74Uj3owgAK
         rKm/JjC1kg2u0r2qhrXzO+Whtg/XtBlrVB5RU0yoMhl7x/ob9/infxDjMB9G+MWb4CbY
         XxiMlUBn0OyODoHppC3ALEb5fkyLhDrFQaSLeXz9dPbW64zPzGm/Z1Ptxy9skrLV0+sd
         /JHUfoS9JySFh8m2xDfMbhBmcUgMB9w20AZHRk9rpKE6OJgINojRd/qx+U/8vEhj1516
         0/3ivyWfyo3jPzvmEnGuhi7XC2qkg2rJnK/6UTh2qWsYaQi9i5SS4wuQ/dfmQusAMRRJ
         TXog==
X-Forwarded-Encrypted: i=1; AJvYcCWnomxwx8YaW+jv+ITm6HMM5ZmdtssYo+dLzyE/kTo4O156yCmiQqdxbPdE114t7XunnBUCZ1NMEHbskvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2U5OfifQTlI95CAB+YMl4s+th2v5IjRadQvoz1GfnI2RAjeKm
	5VRoQPWdgejSHDOPUUxdHOLtIMR+f+UX0zPvw1cbTSS7PK4rDzoouDcAdYtvvu9iMfIE0zNYzig
	eV/5a6Q==
X-Google-Smtp-Source: AGHT+IGhehI8LJgcP8zwkG2TeOHjRw58cboMOoOVQPKm4GebZDbEptszXX70rPMnZZtPIWQQz7TjslWvf4U=
X-Received: from pjbqi4.prod.google.com ([2002:a17:90b:2744:b0:327:50fa:eff9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9189:b0:263:57a:bb52
 with SMTP id adf61e73a8af0-27aab860c10mr3156731637.53.1758116679338; Wed, 17
 Sep 2025 06:44:39 -0700 (PDT)
Date: Wed, 17 Sep 2025 06:44:37 -0700
In-Reply-To: <52cc9795-970e-4940-80d1-490daed636c4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com> <20250912232319.429659-17-seanjc@google.com>
 <52cc9795-970e-4940-80d1-490daed636c4@linux.intel.com>
Message-ID: <aMq7RTmfPhfhDCtI@google.com>
Subject: Re: [PATCH v15 16/41] KVM: VMX: Set up interception for CET MSRs
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 17, 2025, Binbin Wu wrote:
> 
> 
> On 9/13/2025 7:22 AM, Sean Christopherson wrote:
> > From: Yang Weijiang <weijiang.yang@intel.com>
> > 
> > Enable/disable CET MSRs interception per associated feature configuration.
> > 
> > Pass through CET MSRs that are managed by XSAVE, as they cannot be
> > intercepted without also intercepting XSAVE. However, intercepting XSAVE
> > would likely cause unacceptable performance overhead.
> Here may be a bit confusing about the description of "managed by XSAVE" because
> KVM has a function is_xstate_managed_msr(), and MSR_IA32_S_CET is not xstate
> managed in it.

Ooh, yeah, definitely confusing.  And the XSAVE part is also misleading to some
extent, because strictly speaking it's XSAVES/XRSTORS.  And performance isn't
the main concern, it's the complexity of emulating XSAVES/XRSTORS that's the
non-starter.  I think it's also worth calling out that the code intentionally
doesn't check XSAVES support.

  Disable interception for CET MSRs that can be accessed ia vXSAVES/XRSTORS,
  as accesses through XSTATE aren't subject to MSR interception checks, i.e.
  cannot be intercepted without intercepting and emulating XSAVES/XRSTORS,
  and KVM doesn't support emulating XSAVE/XRSTOR instructions.

  Don't condition interception on the guest actually having XSAVES as there
  is no benefit to intercepting the accesses.  The MSRs in question are
  either context switched by the CPU on VM-Enter/VM-Exit or by KVM via
  XSAVES/XRSTORS (KVM requires XSAVES to virtualization SHSTK), i.e. KVM is
  going to load guest values into hardware irrespective of XSAVES support.

> Otherwise,
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> 
> > MSR_IA32_INT_SSP_TAB is not managed by XSAVE, so it is intercepted.
> > 
> > Note, this MSR design introduced an architectural limitation of SHSTK and
> > IBT control for guest, i.e., when SHSTK is exposed, IBT is also available
> > to guest from architectural perspective since IBT relies on subset of SHSTK
> > relevant MSRs.
> > 
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > Tested-by: Mathias Krause <minipli@grsecurity.net>
> > Tested-by: John Allen <john.allen@amd.com>
> > Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > Signed-off-by: Chao Gao <chao.gao@intel.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/vmx/vmx.c | 19 +++++++++++++++++++
> >   1 file changed, 19 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 4fc1dbba2eb0..adf5af30e537 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -4101,6 +4101,8 @@ void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu)
> >   void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
> >   {
> > +	bool intercept;
> > +
> >   	if (!cpu_has_vmx_msr_bitmap())
> >   		return;
> > @@ -4146,6 +4148,23 @@ void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
> >   		vmx_set_intercept_for_msr(vcpu, MSR_IA32_FLUSH_CMD, MSR_TYPE_W,
> >   					  !guest_cpu_cap_has(vcpu, X86_FEATURE_FLUSH_L1D));
> > +	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
> > +		intercept = !guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK);
> > +
> > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL0_SSP, MSR_TYPE_RW, intercept);
> > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL1_SSP, MSR_TYPE_RW, intercept);
> > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL2_SSP, MSR_TYPE_RW, intercept);
> > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL3_SSP, MSR_TYPE_RW, intercept);
> > +	}
> > +
> > +	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK) || kvm_cpu_cap_has(X86_FEATURE_IBT)) {
> > +		intercept = !guest_cpu_cap_has(vcpu, X86_FEATURE_IBT) &&
> > +			    !guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK);
> > +
> > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_U_CET, MSR_TYPE_RW, intercept);
> > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_S_CET, MSR_TYPE_RW, intercept);
> > +	}
> > +
> >   	/*
> >   	 * x2APIC and LBR MSR intercepts are modified on-demand and cannot be
> >   	 * filtered by userspace.
> 

