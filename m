Return-Path: <linux-kernel+bounces-780649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 436BDB3077C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDBB764842B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E553568F3;
	Thu, 21 Aug 2025 20:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4HMOKiV"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5399F3568F6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808700; cv=none; b=krLvsThzAvcnL44hMML63qKSJmUEeu6SpJF931vSsNu0b/jNYgNTKDZOz6x5qFecD8TGOCoEBqddHeDUd6Nx96XQIIm2EWU1TbZJZFjmwWNUmHKRBb+buA9bVpS49ZbLyY46k+wFBY8aWHqdSXOAevf6h9hISJc1V//iSN8JkzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808700; c=relaxed/simple;
	bh=CCWyrizXqh6azDRIlEbtuLy92d9UOttaWpx8GvlyZH8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e12FW6y/ll24QxMs6YSWy6Lu6SWyxiSTTS4J9ljF7UD8PmmLBVfSg75IkmIqWryOMq/ihKcASzP3MdyrkoeHtBohhFqPsNRgMFvQOYwOripD+9S8OPfM60fr0ybulvpXC3B8hjurp723MSpBpE4cWG1ZN9MEMcj4q28DxH1VMwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J4HMOKiV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47538030bfso1189489a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755808698; x=1756413498; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0DT+LN0N/uSj+iDQVx56WV7qQae5b12UpmwE1JIpSnE=;
        b=J4HMOKiVZn3062sSZbrT8a+iPMy+jnFWemauDYir0wUCXKDus6hvt19X/z4B4t+/xK
         x6gLGKLNHKoUS4xBSElC5+pAPe9iNOqPysazjz4Fv9h/oJ2iv/nR+Gak6UtMi7KRhzcL
         5tvPrFYecqMFPHoi3rwg3z7Bics+l4ePNh2eabQu4gskK9+hP3hldauUU/tLrJDrxVkg
         6E/8pneEaptECBjkTAiTdVkKVBi8w9JH0kKAIjukL5TYAEIaMdKo1l/oMCCFEuPoi8nN
         GWWj/kADinM859KHGqsFKsvfGnQKPblprpt90LSJ8t28HXObdM4H/7BVtLlOnLObjxri
         D4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755808698; x=1756413498;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DT+LN0N/uSj+iDQVx56WV7qQae5b12UpmwE1JIpSnE=;
        b=mBFLmjHbn0SAZ6VSSBDcY9KT/rUOhcoXeOUF8s2v7SEQ8T+UCeARTwWvzPaVUOP8KZ
         2yK4aJlHvfpQY762Xg4lwoSEiDT1STvvsyFXTO4X6nf1LC7awPPKDfsWq/Yk1ITX/OB9
         XwC3BN4nuXf+ef+DJMMgrcMyd9DWTqT577AG6yo3BVClOuTqQ0R441umGsT/6IKifmdv
         KwucFuxuI7HTiLWIsxcCotv+sAb8kD06FsttgUFOyYs6yB28wfbvfXxBIwy36i3Uu/pr
         o9goQbHUXAUBV45OiPdkIwiKT2L9IHPXMVTvSSMlXSbdwqZGOvY5cFyR01P72IWEdB0k
         VXUA==
X-Forwarded-Encrypted: i=1; AJvYcCXygCUkn1lkfhlS27xBf1Y6Tbwo+4SvduuTV9SKEAOryiCxMQy+u/LopC2jRTEVx0FioBWlgjEO7jHqZZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfXFWWV+qmy3LM1HCg7FnmbUqwPigyVrFCqIhxwZdTCJpqj2TH
	0upxY/sUDuh2bP8iEaUlHTIqdIfseEj0Zz9D3S1POMbsozDl1AAIyjRWT4V6AdcTsFslHNgbjO/
	yVbz4Pw==
X-Google-Smtp-Source: AGHT+IHLMb0Ev4JwGytUG/z778wSGXRQCiWY994aVKEonVuNvxifDjuhuy4KGJVbjfnt1w2f94VzQ8w6u2s=
X-Received: from pjbnb7.prod.google.com ([2002:a17:90b:35c7:b0:321:c9cf:de39])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3805:b0:31c:c661:e4e
 with SMTP id 98e67ed59e1d1-32518997f87mr991073a91.33.1755808698460; Thu, 21
 Aug 2025 13:38:18 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:38:17 -0700
In-Reply-To: <2b2cfff9a2bd6bcc97b97fee7f3a3e1186c9b03c.1755609446.git.maciej.szmigiero@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1755609446.git.maciej.szmigiero@oracle.com> <2b2cfff9a2bd6bcc97b97fee7f3a3e1186c9b03c.1755609446.git.maciej.szmigiero@oracle.com>
Message-ID: <aKeDuaW5Df7PgA38@google.com>
Subject: Re: [PATCH 1/2] KVM: SVM: Sync TPR from LAPIC into VMCB::V_TPR when
 setting LAPIC regs
From: Sean Christopherson <seanjc@google.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 19, 2025, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> When AVIC is enabled the normal pre-VMRUN sync in sync_lapic_to_cr8() is
> inhibited so any changed TPR in the LAPIC state would not get copied into
> the V_TPR field of VMCB.
> 
> AVIC does sync between these two fields, however it does so only on
> explicit guest writes to one of these fields, not on a bare VMRUN.
> 
> This is especially true when it is the userspace setting LAPIC state via
> KVM_SET_LAPIC ioctl() since userspace does not have access to the guest
> VMCB.
> 
> Practice shows that it is the V_TPR that is actually used by the AVIC to
> decide whether to issue pending interrupts to the CPU (not TPR in TASKPRI),
> so any leftover value in V_TPR will cause serious interrupt delivery issues
> in the guest when AVIC is enabled.
> 
> Fix this issue by explicitly copying LAPIC TPR to VMCB::V_TPR in
> avic_apicv_post_state_restore(), which gets called from KVM_SET_LAPIC and
> similar code paths when AVIC is enabled.
> 
> Fixes: 3bbf3565f48c ("svm: Do not intercept CR8 when enable AVIC")
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  arch/x86/kvm/svm/avic.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index a34c5c3b164e..877bc3db2c6e 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -725,8 +725,31 @@ int avic_init_vcpu(struct vcpu_svm *svm)
>  
>  void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu)
>  {
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	u64 cr8;
> +
>  	avic_handle_dfr_update(vcpu);
>  	avic_handle_ldr_update(vcpu);
> +
> +	/* Running nested should have inhibited AVIC. */
> +	if (WARN_ON_ONCE(nested_svm_virtualize_tpr(vcpu)))
> +		return;


> +
> +	/*
> +	 * Sync TPR from LAPIC TASKPRI into V_TPR field of the VMCB.
> +	 *
> +	 * When AVIC is enabled the normal pre-VMRUN sync in sync_lapic_to_cr8()
> +	 * is inhibited so any set TPR LAPIC state would not get reflected
> +	 * in V_TPR.

Hmm, I think that code is straight up wrong.  There's no justification, just a
claim:

  commit 3bbf3565f48ce3999b5a12cde946f81bd4475312
  Author:     Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
  AuthorDate: Wed May 4 14:09:51 2016 -0500
  Commit:     Paolo Bonzini <pbonzini@redhat.com>
  CommitDate: Wed May 18 18:04:31 2016 +0200

    svm: Do not intercept CR8 when enable AVIC
    
    When enable AVIC:
        * Do not intercept CR8 since this should be handled by AVIC HW.
        * Also, we don't need to sync cr8/V_TPR and APIC backing page.   <======
    
    Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
    [Rename svm_in_nested_interrupt_shadow to svm_nested_virtualize_tpr. - Paolo]
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

That claim assumes APIC[TPR] will _never_ be modified by anything other than
hardware.  That's obviously false for state restore from userspace, and it's also
technically false at steady state, e.g. if KVM managed to trigger emulation of a
store to the APIC page, then KVM would bypass the automatic harware sync.

There's also the comically ancient KVM_SET_VAPIC_ADDR, which AFAICT appears to
be largely dead code with respect to vTPR (nothing sets KVM_APIC_CHECK_VAPIC
except for the initial ioctl), but could again set APIC[TPR] without updating
V_TPR.

So, rather than manually do the update during state restore, my vote is to restore
the sync logic.  And if we want to optimize that code (seems unnecessary), then
we should hook all TPR writes.

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d9931c6c4bc6..1bfebe40854f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4046,8 +4046,7 @@ static inline void sync_lapic_to_cr8(struct kvm_vcpu *vcpu)
        struct vcpu_svm *svm = to_svm(vcpu);
        u64 cr8;
 
-       if (nested_svm_virtualize_tpr(vcpu) ||
-           kvm_vcpu_apicv_active(vcpu))
+       if (nested_svm_virtualize_tpr(vcpu))
                return;
 
        cr8 = kvm_get_cr8(vcpu);


> +	 *
> +	 * Practice shows that it is the V_TPR that is actually used by the
> +	 * AVIC to decide whether to issue pending interrupts to the CPU, not
> +	 * TPR in TASKPRI.

FWIW, the APM kinda sorta alludes to this:

  Enabling AVIC also affects CR8 behavior independent of V_INTR_MASKING enable
  (bit 24): writes to CR8 affect the V_TPR and update the backing page and reads
  from CR8 return V_TPR.


> +	 */
> +	cr8 = kvm_get_cr8(vcpu);
> +	svm->vmcb->control.int_ctl &= ~V_TPR_MASK;
> +	svm->vmcb->control.int_ctl |= cr8 & V_TPR_MASK;
> +	WARN_ON_ONCE(!vmcb_is_dirty(svm->vmcb, VMCB_INTR));


>  }
>  
>  static void svm_ir_list_del(struct kvm_kernel_irqfd *irqfd)

