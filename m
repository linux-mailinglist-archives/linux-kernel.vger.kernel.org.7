Return-Path: <linux-kernel+bounces-776354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB1BB2CC5D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3BE1B62507
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3805C31E10A;
	Tue, 19 Aug 2025 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PQWxKkIO"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B597922D78A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629146; cv=none; b=G3uE5oCxx5JnWGuC54CtXaQDH9cnQApY06ciO7xNBR0wK5eGdlGCLR+idMkjkWtxMH8a6kNHnegk+Ke9UVWkNhOzPSGWKVDeqNY5uIoRBJAB5GkhX0mLFMhQVWz36a7VNrEnsR/XYl/s9g04NWru5EOVNlJVqMLjoqAACvn9Vog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629146; c=relaxed/simple;
	bh=TTL4EqUCNjyV/uP44MW11hKcEj7eoV7nSrj6UfFEI+g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YedmXbsWffrHPEOG9ioSyzBd6kEbVCqDquC7XtXirgftnnx73ypFTLEtKef/F9yIWIHpZdcKj7qixG8jX3wGSufx7pB5FwASAb9Y4JknvAKqPNEuV2JjJ1DRVXRSjsI5GWN5Tb2mxTcY737yZsUW2GIgnDTKEI8saPxzsUc0ww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PQWxKkIO; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b471757d82fso4489405a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755629144; x=1756233944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dL5HtHdhdJWG4Dezo4hkSgPof2Jcf7TXqbAhrXxjT58=;
        b=PQWxKkIOz4zUHwLz5BVnL/cliy0zNUjcYSsCuURB/yCkHLfW/U7hHtTcq4j1WQpHPS
         nDfq5dC3Bh8pPiH6fv19vwI1uktTTglJ4r/vllObfIyFaXlMwm34WBCQlb3HEMim4OK8
         RexfOhIkgQehp/tnykiuEaup5EWUSn8hAuv8sIZEqtzFf+lfluRpuD2GlljcM/RYspUT
         Uznr+dcqNAOU6a265Hvh5e+0bFTFntyrdJPTjX/3JWcgs0j2ZRQXflGcbSLkLIheOJuu
         ERIdU/9ZRICOfa4q8LgJgE4NnNM7d9TtCWmRdCNq3E5TyirMxJxVrm9nhQPfN3aJgc6x
         TvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755629144; x=1756233944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dL5HtHdhdJWG4Dezo4hkSgPof2Jcf7TXqbAhrXxjT58=;
        b=fLTDXW2PsGGsoBF4zZJGcSvEwQX+mysuOpjimrZo/JoO7dlrChcox2LS+kjpym1t+l
         eW+HMrCT+TszACrA6lQSp/gXvqqYNLOQKWi4IUn0xpRW9KrGB9TadYHj9G/QxIc3fD5p
         yYZoKsmbRf99Hr/UzyJgBsZAzclWsPui78hvL7RdwkzW8C8B+UQJ55spA/CWK6a359MP
         +wDexunVdUEKLV/1ImvCIq6X4ll4n7MG3lASJdSJbLBKhzbATEMUzG/uB4R+3jzUvB0m
         F/2vcmwhdC4VfgoFA2Ovg+PvwyzBzL9g90x4ASv5ESiN3wJsd3KS+r95QZmXVuNqL9kE
         jUHw==
X-Forwarded-Encrypted: i=1; AJvYcCUIaiEK2hsh1V5g79Y6QYEfuUES53adBjToKyrkIcycPvOLyoXSMxs3ZSyZ9elSGIFy9logMjgaOG2crx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuhQ8R8qzDFZcILYeLX9xoienQR/B2V5S5zjBVEf903Y+m3Rra
	sDG9B9jXdh6m3e501j89vsYr4WNt60SFK5w9ThZhWqAe/VbKvJPCAGr3rldclI3cE055ZWE1ceK
	/oJ8g6A==
X-Google-Smtp-Source: AGHT+IHZ+b7fcv57ZQ8qNEhtUAa7AZF+5/24y9I69qzT4UEvUDk0IsdsCOq8kpM4DLUHcBRQMxFilCKwUEc=
X-Received: from pfkh2.prod.google.com ([2002:a05:6a00:2:b0:76e:287a:90e0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:938c:b0:239:374d:d729
 with SMTP id adf61e73a8af0-2431b7f6d10mr527097637.7.1755629144051; Tue, 19
 Aug 2025 11:45:44 -0700 (PDT)
Date: Tue, 19 Aug 2025 11:45:42 -0700
In-Reply-To: <77edb8d9-4093-49fe-963c-56da76514d4c@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812025606.74625-1-chao.gao@intel.com> <20250812025606.74625-18-chao.gao@intel.com>
 <aKSiNh43UCosGIVh@google.com> <77edb8d9-4093-49fe-963c-56da76514d4c@zytor.com>
Message-ID: <aKTGVvOb8PZ7mzVr@google.com>
Subject: Re: [PATCH v12 17/24] KVM: VMX: Set up interception for CET MSRs
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
Cc: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mlevitsk@redhat.com, rick.p.edgecombe@intel.com, weijiang.yang@intel.com, 
	Mathias Krause <minipli@grsecurity.net>, John Allen <john.allen@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 19, 2025, Xin Li wrote:
> On 8/19/2025 9:11 AM, Sean Christopherson wrote:
> > On Mon, Aug 11, 2025, Chao Gao wrote:
> > > From: Yang Weijiang <weijiang.yang@intel.com>
> > > 
> > > Enable/disable CET MSRs interception per associated feature configuration.
> > > 
> > > Shadow Stack feature requires all CET MSRs passed through to guest to make
> > > it supported in user and supervisor mode
> > 
> > I doubt that SS _requires_ CET MSRs to be passed through.  IIRC, the actual
> > reason for passing through most of the MSRs is that they are managed via XSAVE,
> > i.e. _can't_ be intercepted without also intercepting XRSTOR.
> > 
> > > while IBT feature only depends on
> > > MSR_IA32_{U,S}_CETS_CET to enable user and supervisor IBT.
> > > 
> > > Note, this MSR design introduced an architectural limitation of SHSTK and
> > > IBT control for guest, i.e., when SHSTK is exposed, IBT is also available
> > > to guest from architectural perspective since IBT relies on subset of SHSTK
> > > relevant MSRs.
> > > 
> > > Suggested-by: Sean Christopherson <seanjc@google.com>
> > > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > > Tested-by: Mathias Krause <minipli@grsecurity.net>
> > > Tested-by: John Allen <john.allen@amd.com>
> > > Signed-off-by: Chao Gao <chao.gao@intel.com>
> > > ---
> > >   arch/x86/kvm/vmx/vmx.c | 20 ++++++++++++++++++++
> > >   1 file changed, 20 insertions(+)
> > > 
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index bd572c8c7bc3..130ffbe7dc1a 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -4088,6 +4088,8 @@ void pt_update_intercept_for_msr(struct kvm_vcpu *vcpu)
> > >   void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
> > >   {
> > > +	bool set;
> > 
> > s/set/intercept
> > 
> 
> Maybe because you asked me to change "flag" to "set" when reviewing FRED
> patches, however "intercept" does sound better, and I just changed it :)

Ah crud.  I had a feeling I was flip-flopping.  I obviously don't have a strong
preference.

> > > +
> > >   	if (!cpu_has_vmx_msr_bitmap())
> > >   		return;
> > > @@ -4133,6 +4135,24 @@ void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
> > >   		vmx_set_intercept_for_msr(vcpu, MSR_IA32_FLUSH_CMD, MSR_TYPE_W,
> > >   					  !guest_cpu_cap_has(vcpu, X86_FEATURE_FLUSH_L1D));
> > > +	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
> > > +		set = !guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK);
> > > +
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL0_SSP, MSR_TYPE_RW, set);
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL1_SSP, MSR_TYPE_RW, set);
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL2_SSP, MSR_TYPE_RW, set);
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL3_SSP, MSR_TYPE_RW, set);
> > > +		vmx_set_intercept_for_msr(vcpu, MSR_IA32_INT_SSP_TAB, MSR_TYPE_RW, set);
> > 
> > MSR_IA32_INT_SSP_TAB isn't managed via XSAVE, so why is it being passed through?
> 
> It's managed in VMCS host and guest areas, i.e. HOST_INTR_SSP_TABLE and
> GUEST_INTR_SSP_TABLE, if the "load CET" bits are set in both VM entry
> and exit controls.

Ah, "because it's essentially free".  Unless there's a true need to pass it through,
I think it makes sense to intercept.  Merging KVM's bitmap with vmcs12's bitmap
isn't completely free (though it's quite cheap).  More importantly, this is technically
wrong due to MSR_IA32_INT_SSP_TAB not existing if the vCPU doesn't have LM.  That's
obviously easy to solve, I just don't see the point.

