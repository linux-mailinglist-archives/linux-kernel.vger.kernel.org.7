Return-Path: <linux-kernel+bounces-819500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7041EB5A1B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 597707A13BD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE902E11D1;
	Tue, 16 Sep 2025 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HsgD5jbk"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8832D5C1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758052442; cv=none; b=X3Ue59DEtET1i8PbdzdBBNd4YpUz5pwV422M0ekuAOQA0nvqPPKlEB/vg4tZdrgdac3fzoH6Bv1hLjIgtAsATN6LHXrW9ebEqaKzzDMpxOZBxVL2A2sX8VsRnDRrb9vjUB2JZJLzFg9OIChCUsLOSrQp2wAKtA/dpaPZa+rbulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758052442; c=relaxed/simple;
	bh=K42TrTHCprp/z96FHfYhNr0g4AcPAvf8SJ9hfIxuUlY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EjZr3Yrb1Dd3/blvUzYrQWxwslirM7BfBi88MNFhj22BYmlXtLY9YIJyomhMuw7J3YmNq0R04aShRFI9+t8VdjbvayrpfBNNc33eZlmOcs4W/oJYEd/wrVghma6MMjyv75g6cO//GMPXi/vnNBXfJsmhOvLYHnu+4iwEs59ROrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HsgD5jbk; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eaa47c7c8so900044a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758052440; x=1758657240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ypCkSV2j4XpnxIOH+Xa4yIgQz4o/rWKDyEIeCFtvkq4=;
        b=HsgD5jbknGT83Tm4s3Z05jNWWI229EOEl1zn9+LSzWXCXomR9N/rjMEkn8CI+JuJm/
         Ku8wWLHb73zHZ8T9SVGkkezaWcdzKpQpa0sdIbjAf9AB+UrjMCSJWmrvhBXA6k0y4b7/
         sfQaVxWiEBbtSzVwH5txF+rLq1OMMhE7unEhFgSFr1W7d7NyOFh8I/bSKKtfzzhOxnKE
         uOmhFUEkz5PBP+XJ+Z2cCouNeeKCSpTNgEP8Sb5zOgVcujSBwizx7ccDT0K9E5V9oeOb
         9mxdW1oNBz+tFa4A/ShLRgLsHuQFpl4lfHVkfSrrI8sYqHNjm6veVYziY2x+goqipnz1
         eICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758052440; x=1758657240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypCkSV2j4XpnxIOH+Xa4yIgQz4o/rWKDyEIeCFtvkq4=;
        b=tk+xA/SWizINQ8L1yd3IyTUbEjFJOCbvO3lQ5kSsjNjxtRivtRbKLwnNhUPAlyhn97
         oZGAz3KIDO2LZNhT3avtwgTSS/WQbcawD7bVppbNWEF5w5Wmze+hcWlH2NtAZKBSE4BV
         rUmULuY0Pdn53AyaHiq10wbdVLnnUXWwCBQLHH+UF7sFRx+yEL1hYah5/EuumI9mD0Sr
         7Q0F0zBqgcdNmGHVMT5qRXPZxG1pH24mBqgXqpElrsIiI7+6AKXwG+g5u/Qn3VSRAQ+7
         93Xs2KKGrGXX1NCz30YueQFwX7+xyLLD1pDdXQNuPi6l+VqwFVrJ1qgO3hbfb1vtOLbG
         rcxg==
X-Forwarded-Encrypted: i=1; AJvYcCVu/plN4pECfHzGs34iwdfCW1hkzI6FJ8loc2+ywFZgxptUzu5GO89bCGxYFW0rP6ifm/ItxDJvqw6VZLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6+Y380RayDuGc60PaJuILEY2wpT8zPmVvqBq+Ol+dIOC/zO6
	8mhZmpZBL2JiX90ETwwQY5/BtWK8QylpYPFv0qEpVDR7WWoafLgSb0LSN1xfa8IixGlWGaek6jH
	+yVYQ7A==
X-Google-Smtp-Source: AGHT+IF7V5/RFWKziMu7+PnjJdaAV3vmh8rDnydpSEaIMymcODcxVrmX+z/O7AjuUkm0xOVeP/MX9RaLbHg=
X-Received: from pjbqi2.prod.google.com ([2002:a17:90b:2742:b0:32d:def7:e60f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1810:b0:32b:d8af:b636
 with SMTP id 98e67ed59e1d1-32de4f87766mr22838318a91.19.1758052440244; Tue, 16
 Sep 2025 12:54:00 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:53:58 -0700
In-Reply-To: <aMmynhOnU/VkcXwI@AUSJOHALLEN.amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com> <20250912232319.429659-30-seanjc@google.com>
 <aMmynhOnU/VkcXwI@AUSJOHALLEN.amd.com>
Message-ID: <aMnAVtWhxQipw9Er@google.com>
Subject: Re: [PATCH v15 29/41] KVM: SEV: Synchronize MSR_IA32_XSS from the
 GHCB when it's valid
From: Sean Christopherson <seanjc@google.com>
To: John Allen <john.allen@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 16, 2025, John Allen wrote:
> On Fri, Sep 12, 2025 at 04:23:07PM -0700, Sean Christopherson wrote:
> > Synchronize XSS from the GHCB to KVM's internal tracking if the guest
> > marks XSS as valid on a #VMGEXIT.  Like XCR0, KVM needs an up-to-date copy
> > of XSS in order to compute the required XSTATE size when emulating
> > CPUID.0xD.0x1 for the guest.
> > 
> > Treat the incoming XSS change as an emulated write, i.e. validatate the
> > guest-provided value, to avoid letting the guest load garbage into KVM's
> > tracking.  Simply ignore bad values, as either the guest managed to get an
> > unsupported value into hardware, or the guest is misbehaving and providing
> > pure garbage.  In either case, KVM can't fix the broken guest.
> > 
> > Note, emulating the change as an MSR write also takes care of side effects,
> > e.g. marking dynamic CPUID bits as dirty.
> > 
> > Suggested-by: John Allen <john.allen@amd.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/svm/sev.c | 3 +++
> >  arch/x86/kvm/svm/svm.h | 1 +
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 0cd77a87dd84..0cd32df7b9b6 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -3306,6 +3306,9 @@ static void sev_es_sync_from_ghcb(struct vcpu_svm *svm)
> >  	if (kvm_ghcb_xcr0_is_valid(svm))
> >  		__kvm_set_xcr(vcpu, 0, kvm_ghcb_get_xcr0(ghcb));
> >  
> > +	if (kvm_ghcb_xss_is_valid(svm))
> > +		__kvm_emulate_msr_write(vcpu, MSR_IA32_XSS, kvm_ghcb_get_xss(ghcb));
> > +
> 
> It looks like this is the change that caused the selftest regression
> with sev-es. It's not yet clear to me what the problem is though.

Do you see any WARNs in the guest kernel log?

The most obvious potential bug is that KVM is missing a CPUID update, e.g. due
to dropping an XSS write, consuming stale data, not setting cpuid_dynamic_bits_dirty,
etc.  But AFAICT, CPUID.0xD.1.EBX (only thing that consumes the current XSS) is
only used by init_xstate_size(), and I would expect the guest kernel's sanity
checks in paranoid_xstate_size_valid() to yell if KVM botches CPUID emulation.

Another possibility is that unconditionally setting cpuid_dynamic_bits_dirty
was masking a pre-existing (or just different) bug, and that "fixing" that flaw
by eliding cpuid_dynamic_bits_dirty when "vcpu->arch.ia32_xss == data" exposed
the bug.

