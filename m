Return-Path: <linux-kernel+bounces-774230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D82AB2B021
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD12B1B60117
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27982D24AC;
	Mon, 18 Aug 2025 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOrsX/+j"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8C62773FE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541230; cv=none; b=XbmbrPDjp+phzIBBpY2owBBmNIjV1RuC8R6EaVwMLIi7L7xD07gWBTA/Vh1twQc/q+4KbPREtX/KeYpVTnoUcmsza2n3igO3ReDfMjx/W6wrcH0/gOBB5hLcj5SCpcgablytnKizOaZ4mUAaNPsFK4Sh4ryZ1A0J6FJUNjDu0+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541230; c=relaxed/simple;
	bh=38sZH6JuVgSMOyf4B27yV9I0wAobtIYP27/Wcj+eUOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JUBuq/0qmmuvWKauXncdMj14K2H/vPoYRMpVW4FD7dqdddI4amRHwZD34LqwQhtWS7zSF/OjtVd8WlWC3e/IuDHF2PuwYL/Dd8rJJJQ4A+ncSqtI/u2XiIPBKDOm3EgNZLahlP1e9XvS3HaTRs/bHetqHfOhshNEMjXIGYWDQu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JOrsX/+j; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323266dca73so3783795a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755541228; x=1756146028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+Iq2txiStcKOuqn2xWSupDgERuUU7vo0HWget122Wg=;
        b=JOrsX/+jQNaoU4MBaOGyvA12GkFcFM52vtju6631noru5C8JEpHC407f2ogW808Lla
         iBhVV+R8p+u3QBlfMcUWZ/ICVlcc1tUtfl8p3+S5MLVcmVYrQ0GSybov+7jTdwRBdEeD
         Lf2W+sIXUXLLThO2Jydk4+mTtgmXzIY2iOeyfFaViaZJADhxfAgQNvna2ux7uu8ds4oD
         hh7cnjnYNwYH0z9mOJijhv9wygeDqAdzyTZKhFolpzFEixJUi8TxX9ECTZqwilApocBM
         v1yGLILiw9oOVAOd8eAhuvWNd7Vk9+yCj1z1q/nEd/8MoFinoN63QWnZ3DFYo5vFXwfJ
         F7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755541228; x=1756146028;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+Iq2txiStcKOuqn2xWSupDgERuUU7vo0HWget122Wg=;
        b=DikKIkQEZ02jw7V3GVWzRhw1NyU9pTSTdsGa8G/ZTpf5lscxlX4ux+LKLsxHVc4yh1
         7zrkPdpE/RMIgjpSr1hwfX2XUui7opEhj/LneZI20G6vL/61PaoJ6WGeocO+kdH+3OJh
         wIUBA0ecb69DE5KoVxRiOxzIRJAPMaeDaBWTOARSca1Cm+bP1kruDcPBunYUR0YTUNjk
         2a2vlvEBZMLszCF+49fFmZ0iEE9YsTsUjR5szCjcBBYF+jUDwSxzS92aSxUSZ7QWkjYx
         Ts+bIstKiUUOpxqDFNVWjb2IoKR1YnX/YD8AzHaqiLzcNZd+nlEoOJpx+s5aWg09nD/4
         TL7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvGLRrWmZpXu0QgKBBPTgDpDf5bmq49owQO3rPfkBzY2DpUjPA9BKaaMdNphj2XJ/ysIUMQipbC1+e3yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKnkwWnp9FuJdcz20Iv1CPhxrefW+T9pgU856/KFdvhgyQWfdd
	+HI2ZL2MhwjtGKX27VCcVCxyT0RqJa8jFkzgc4YgJSXGtcr6FjW0NEN5qBTWtbwwVHVLD01n0WI
	TidasBw==
X-Google-Smtp-Source: AGHT+IELTRFHW9KUb9D80Nbvrwyz0fNQE4bUdMf4smEIgxSpRcYtBKnsaEnIrAtTdAW2ja3MqRjx5g0/Rl8=
X-Received: from pjbpq4.prod.google.com ([2002:a17:90b:3d84:b0:30a:7da4:f075])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224e:b0:321:b953:85ad
 with SMTP id 98e67ed59e1d1-3234dc61e08mr12748477a91.30.1755541227800; Mon, 18
 Aug 2025 11:20:27 -0700 (PDT)
Date: Mon, 18 Aug 2025 11:20:26 -0700
In-Reply-To: <20250813192313.132431-4-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250813192313.132431-1-mlevitsk@redhat.com> <20250813192313.132431-4-mlevitsk@redhat.com>
Message-ID: <aKNu6gYNO1j_Wpdj@google.com>
Subject: Re: [PATCH 3/3] KVM: x86: Fix the interaction between SMM and the
 asynchronous pagefault
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, Borislav Petkov <bp@alien8.de>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 13, 2025, Maxim Levitsky wrote:
> Currently a #SMI can cause KVM to drop an #APF ready event and
> subsequently causes the guest to never resume the task that is waiting
> for it.
> This can result in tasks becoming permanently stuck within the guest.
> 
> This happens because KVM flushes the APF queue without notifying the guest
> of completed APF requests when the guest exits to real mode.
> 
> And the SMM exit code calls kvm_set_cr0 with CR.PE == 0, which triggers
> this code.
> 
> It must be noted that while this flush is reasonable to do for the actual
> real mode entry, it is actually achieves nothing because it is too late to
> flush this queue on SMM exit.
> 
> To fix this, avoid doing this flush altogether, and handle the real
> mode entry/exits in the same way KVM already handles the APIC
> enable/disable events:
> 
> APF completion events are not injected while APIC is disabled,
> and once APIC is re-enabled, KVM raises the KVM_REQ_APF_READY request
> which causes the first pending #APF ready event to be injected prior
> to entry to the guest mode.
> 
> This change also has the side benefit of preserving #APF events if the
> guest temporarily enters real mode - for example, to call firmware -
> although such usage should be extermery rare in modern operating systems.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 11 +++++++----
>  arch/x86/kvm/x86.h |  1 +
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 3d45a4cd08a4..5dfe166025bf 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1118,15 +1118,18 @@ void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned lon
>  	}
>  
>  	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
> -		kvm_clear_async_pf_completion_queue(vcpu);
> -		kvm_async_pf_hash_reset(vcpu);
> -
>  		/*
>  		 * Clearing CR0.PG is defined to flush the TLB from the guest's
>  		 * perspective.
>  		 */
>  		if (!(cr0 & X86_CR0_PG))
>  			kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
> +
> +		/*
> +		 * Re-check APF completion events, when the guest re-enables paging.
> +		 */
> +		if ((cr0 & X86_CR0_PG) && kvm_pv_async_pf_enabled(vcpu))

I'm tempted to make this an elif, i.e.

		if (!(cr0 & X86_CR0_PG))
			kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
		else if (kvm_pv_async_pf_enabled(vcpu))
			kvm_make_request(KVM_REQ_APF_READY, vcpu);

In theory, that could set us up to fail if another CR0.PG=1 case is added, but I
like to think future us will be smart enough to turn it into:

		if (!(cr0 & X86_CR0_PG)) {
			kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
		} else {
			if (kvm_pv_async_pf_enabled(vcpu))
				kvm_make_request(KVM_REQ_APF_READY, vcpu);

			if (<other thing>)
				...
		}


> +			kvm_make_request(KVM_REQ_APF_READY, vcpu);
>  	}
>  
>  	if ((cr0 ^ old_cr0) & KVM_MMU_CR0_ROLE_BITS)
> @@ -3547,7 +3550,7 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	return 0;
>  }
>  
> -static inline bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
> +bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)

This is in the same file, there's no reason/need to expose this via x86.h.  The
overall diff is small enough that I'm comfortable hoisting this "up" as part of
the fix, especially since this needs to go to stable@.

If we use an elif, this?

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6bdf7ef0b535..2bc41e562314 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1030,6 +1030,13 @@ bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr)
 }
 EXPORT_SYMBOL_GPL(kvm_require_dr);
 
+static inline bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
+{
+       u64 mask = KVM_ASYNC_PF_ENABLED | KVM_ASYNC_PF_DELIVERY_AS_INT;
+
+       return (vcpu->arch.apf.msr_en_val & mask) == mask;
+}
+
 static inline u64 pdptr_rsvd_bits(struct kvm_vcpu *vcpu)
 {
        return vcpu->arch.reserved_gpa_bits | rsvd_bits(5, 8) | rsvd_bits(1, 2);
@@ -1122,15 +1129,15 @@ void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned lon
        }
 
        if ((cr0 ^ old_cr0) & X86_CR0_PG) {
-               kvm_clear_async_pf_completion_queue(vcpu);
-               kvm_async_pf_hash_reset(vcpu);
-
                /*
                 * Clearing CR0.PG is defined to flush the TLB from the guest's
-                * perspective.
+                * perspective.  If the guest is (re)enabling, check for async
+                * #PFs that were completed while paging was disabled.
                 */
                if (!(cr0 & X86_CR0_PG))
                        kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
+               else if (kvm_pv_async_pf_enabled(vcpu))
+                       kvm_make_request(KVM_REQ_APF_READY, vcpu);
        }
 
        if ((cr0 ^ old_cr0) & KVM_MMU_CR0_ROLE_BITS)
@@ -3524,13 +3531,6 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
        return 0;
 }
 
-static inline bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
-{
-       u64 mask = KVM_ASYNC_PF_ENABLED | KVM_ASYNC_PF_DELIVERY_AS_INT;
-
-       return (vcpu->arch.apf.msr_en_val & mask) == mask;
-}
-
 static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
 {
        gpa_t gpa = data & ~0x3f;

