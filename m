Return-Path: <linux-kernel+bounces-823593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58E7B86EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 429157AE19A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D072F3619;
	Thu, 18 Sep 2025 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0tHnUOhU"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CDD22D7A1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228258; cv=none; b=hPGtAgjN+/Mr+Y+clpxO/4BDszIC13U1b5vmJA973j/dGzIgBIn/za51dcFUE6AovdkzuriHSvbqCKwhbh60frO/Qzs0tLXOKigJa62jxVr8x/A55bF8GuzPg4bFGyLsdO7SssYQa0/LiKGmaBAqRhj0bYxKvIZ6QReHVeGd418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228258; c=relaxed/simple;
	bh=jC3k1ymd/dZgDbmyrykkCorYEW1b5+Hz+QLh39dH0bk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P9WViKtS8v9zNPx/wsax6RAc5sfn6ekJldxFXCOWh0WjZ7wsQmIAjT/X5X5uUotVJKX/3DUgcTgMllALKVfMZtfAHrkOnLBI9Y/MnABgcOyH2n2ONTH2U7/infXmq8o/4SFiQMGlK1K5HpighT32ng3yWCpnVBEr//eVP4Di5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0tHnUOhU; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5508cb189cso1038841a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758228255; x=1758833055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1YFlhjJvedjhpvE6gprZiZ57nnTy4ugh+ydYg7Ylgls=;
        b=0tHnUOhU74y/pG/SF3+J19+YkU4yj42wCT2XfCfGe6Dm7hgdJdDnaEio1NGk5aQZkD
         sjHVOOJq0H3EL/XLZ18PwShUFGwYrCR655q013z5QEX/xeHmpUDW0ilIJwkmnSX4N3UH
         /XwiGFELo1qZIvUNiYV8MCxOlU1Spoa+GnoHhQKvwOy3xuWkIlAkojVti9cITTYNmv7B
         DHJoj0/p5MVTXfrkiDeNh98o8fdPDZPIjMZVAqLsuUx06u9MJEfowlLJhz7c9+vyP3E8
         INA6YUMHYWwX8a0EUstHoOvu360fjQ1Zs9jfPB0V6++lCEgu2mzxCWPTlX77CrtrJZVJ
         tRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758228255; x=1758833055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1YFlhjJvedjhpvE6gprZiZ57nnTy4ugh+ydYg7Ylgls=;
        b=XeAgigu/DR9QopacfzTpXshL3IjRGu6BGxjjCcSkMiS8VVbtu+bFjmRFjE9QY9IrlC
         V1PvHsK+z+71gUJYSC0IrCQhdnNnyl+AJQZ8ZKVRu6OQTPlew9SdEV6a9kPoTFtpRT6B
         vGyR40OZpZadzSp8QSXDIjiw5ID5/A6LNa4jqxeA6axoWR/P32nR3jmlLtyDvq2rhS1J
         rw3g7IkQNRBkdG/jRrm2WAUOdE9UWs6Z+C5+Za40B1T6I/kcKZo9Vv5z5Hl0h6+JDR92
         Rl0p1tbVvEVkKmb936aJhK40699FzMYj0Rjk9WRWEAJO0cvaefQTKLl4N9nLouKgAOtR
         CtBA==
X-Forwarded-Encrypted: i=1; AJvYcCX/s/elskCW17zCTMIy3Ocy77/gUeazekEi0DwyBCEzPmaauDEECv4CQBEJkE3EZXco2FfJHN2fWwJM5Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0bh75H9OJgczeHbUlc5qxmFwEnBzrwYxd37u2WaJ9Bfg/l1E
	5Op9Ck/ixVgci4RA3CbO0uoCV4h1O8GH3y49P3sX8iFKilTUblNRpSWmMfUz8h1vmsOq6elGTeM
	sC71l4w==
X-Google-Smtp-Source: AGHT+IGCt2Kxo9j4wT8m6UzY14+TjRUVyhJNLbbSIY/uPT5b3Ro+ulDQTDQEAPftdkD2DH2hFxIqEdJ3mjo=
X-Received: from pjtu4.prod.google.com ([2002:a17:90a:c884:b0:32b:8b8d:c2ba])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:164d:b0:32e:e150:8937
 with SMTP id 98e67ed59e1d1-33097fd4137mr1040546a91.6.1758228254670; Thu, 18
 Sep 2025 13:44:14 -0700 (PDT)
Date: Thu, 18 Sep 2025 13:44:13 -0700
In-Reply-To: <aMxs2taghfiOQkTU@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com> <20250912232319.429659-30-seanjc@google.com>
 <aMmynhOnU/VkcXwI@AUSJOHALLEN.amd.com> <aMnAVtWhxQipw9Er@google.com>
 <aMnJYWKf63Ay+pIA@AUSJOHALLEN.amd.com> <aMnY7NqhhnMYqu7m@google.com>
 <aMnq5ceM3l340UPH@AUSJOHALLEN.amd.com> <aMxiIRrDzIqNj2Do@AUSJOHALLEN.amd.com> <aMxs2taghfiOQkTU@google.com>
Message-ID: <aMxvHbhsRn40x-4g@google.com>
Subject: Re: [PATCH v15 29/41] KVM: SEV: Synchronize MSR_IA32_XSS from the
 GHCB when it's valid
From: Sean Christopherson <seanjc@google.com>
To: John Allen <john.allen@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 18, 2025, Sean Christopherson wrote:
> On Thu, Sep 18, 2025, John Allen wrote:
> > On Tue, Sep 16, 2025 at 05:55:33PM -0500, John Allen wrote:
> > > Interesting, I see "Guest CPUID doesn't have XSAVES" times the number of
> > > cpus followed by "XSS already set to val = 0, eliding updates" times the
> > > number of cpus. This is with host tracing only. I can try with guest
> > > tracing too in the morning.
> > 
> > Ok, I think I see the problem. The cases above where we were seeing the
> > added print statements from kvm_set_msr_common were not situations where
> > we were going through the __kvm_emulate_msr_write via
> > sev_es_sync_from_ghcb. When we call __kvm_emulate_msr_write from this
> > context, we never end up getting to kvm_set_msr_common because we hit
> > the following statement at the top of svm_set_msr:
> > 
> > if (sev_es_prevent_msr_access(vcpu, msr))
> > 	return vcpu->kvm->arch.has_protected_state ? -EINVAL : 0;
> 
> Gah, I was looking for something like that but couldn't find it, obviously.
> 
> > So I'm not sure if this would force using the original method of
> > directly setting arch.ia32_xss or if there's some additional handling
> > here that we need in this scenario to allow the msr access.
> 
> Does this fix things?  If so, I'll slot in a patch to extract setting XSS to
> the helper, and then this patch can use that API.  I like the symmetry between
> __kvm_set_xcr() and __kvm_set_xss(), and I especially like not doing a generic
> end-around on svm_set_msr() by calling kvm_set_msr_common() directly.

Scratch that, KVM supports intra-host (and inter-host?) migration of SEV-ES
guests and so needs to allow the host to save/restore XSS, otherwise a guest
that *knows* its XSS hasn't change could get stale/bad CPUID emulation if the
guest doesn't provide XSS in the GHCB on every exit.

So while seemingly hacky, I'm pretty sure the right solution is actually:

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index cabe1950b160..d48bf20c865b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2721,8 +2721,8 @@ static int svm_get_feature_msr(u32 msr, u64 *data)
 static bool sev_es_prevent_msr_access(struct kvm_vcpu *vcpu,
                                      struct msr_data *msr_info)
 {
-       return sev_es_guest(vcpu->kvm) &&
-              vcpu->arch.guest_state_protected &&
+       return sev_es_guest(vcpu->kvm) && vcpu->arch.guest_state_protected &&
+              msr_info->index != MSR_IA32_XSS &&
               !msr_write_intercepted(vcpu, msr_info->index);
 }
 
Side topic, checking msr_write_intercepted() is likely wrong.  It's a bad
heuristic for "managed in the VMSA".  MSRs that _KVM_ loads into hardware and
context switches should still be accessible.  I haven't looked to see if this is
a problem in practice.

> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 945f7da60107..ace9f321d2c9 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2213,6 +2213,7 @@ unsigned long kvm_get_cr8(struct kvm_vcpu *vcpu);
>  void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
>  int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr);
>  int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu);
> +int __kvm_set_xss(struct kvm_vcpu *vcpu, u64 xss);
>  
>  int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
>  int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr);
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 94d9acc94c9a..462aebc54135 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3355,7 +3355,7 @@ static void sev_es_sync_from_ghcb(struct vcpu_svm *svm)
>                 __kvm_set_xcr(vcpu, 0, kvm_ghcb_get_xcr0(svm));
>  
>         if (kvm_ghcb_xss_is_valid(svm))
> -               __kvm_emulate_msr_write(vcpu, MSR_IA32_XSS, kvm_ghcb_get_xss(svm));
> +               __kvm_set_xss(vcpu, kvm_ghcb_get_xss(svm));
>  
>         /* Copy the GHCB exit information into the VMCB fields */
>         exit_code = kvm_ghcb_get_sw_exit_code(svm);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 5bbc187ab428..9b81e92a8de5 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1313,6 +1313,22 @@ int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu)
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_xsetbv);
>  
> +int __kvm_set_xss(struct kvm_vcpu *vcpu, u64 xss)
> +{
> +       if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))
> +               return KVM_MSR_RET_UNSUPPORTED;
> +
> +       if (xss & ~vcpu->arch.guest_supported_xss)
> +               return 1;
> +       if (vcpu->arch.ia32_xss == xss)
> +               return 0;
> +
> +       vcpu->arch.ia32_xss = xss;
> +       vcpu->arch.cpuid_dynamic_bits_dirty = true;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(__kvm_set_xss);
> +
>  static bool kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
>  {
>         return __kvm_is_valid_cr4(vcpu, cr4) &&
> @@ -4119,16 +4135,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                 }
>                 break;
>         case MSR_IA32_XSS:
> -               if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))
> -                       return KVM_MSR_RET_UNSUPPORTED;
> -
> -               if (data & ~vcpu->arch.guest_supported_xss)
> -                       return 1;
> -               if (vcpu->arch.ia32_xss == data)
> -                       break;
> -               vcpu->arch.ia32_xss = data;
> -               vcpu->arch.cpuid_dynamic_bits_dirty = true;
> -               break;
> +               return __kvm_set_xss(vcpu, data);
>         case MSR_SMI_COUNT:
>                 if (!msr_info->host_initiated)
>                         return 1;

