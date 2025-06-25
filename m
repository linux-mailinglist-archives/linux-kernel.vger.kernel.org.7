Return-Path: <linux-kernel+bounces-701235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1023AE7273
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 00:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D931D3BA2E1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 22:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BF025B313;
	Tue, 24 Jun 2025 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9scBxXX"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7134E259C98
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750805280; cv=none; b=fjiRxjMDSHLJoGE9VpR2sQrIjNHkc9nSveGrDfF2SQwcMIc/N1+LlUYVupHroXGRnFKAZk0HvkrgFJKC37KN3eqoNbflJ58EcSonjPkig0DVqPF1JuAjym1H+smg+48y/fR0w7aqxn4pmQcYLJiRWnIJeoJqx46osdOzPLzE1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750805280; c=relaxed/simple;
	bh=QRlwQ7AxJfaB9Xp67zuMrF26BDa3nMjIrCLRdvmF2YI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X63mOVo5oMxK5bO26JTJHbwsf9gp3vtp0V63pbfTnAL60qxCzZ/xKlLRoGF03zWcJGHKOu8cD2zV3++JEXWxlwmedgg8SNVJTywoQ8Caei8843p/JSeRuUM/ipi4NcE7dMWlE3lLgoIpMFcO0EV8oASlTIMP2g2CY7uxrishxFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O9scBxXX; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3208a7d2ebso2494273a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 15:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750805278; x=1751410078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSAz7u45fbiPnlHBfjqwquG39PEzYYRrtEXgVLny8hk=;
        b=O9scBxXXWVvoLRae6yX9Liz+gPgFZmP4vxTg4yDGqjl5/L/8/xnJcguSpbQczhszyV
         GgqqKDQMoh488aZZKRMGRA3vgR6tCR7wzudpZyPD+7HGzw+WJT4cVQseynQrYjLoOV5l
         cw9UCdUj+CjuXLkvOxSp+rfkAemUuemgXXfjWsxzaK+AkoFvIqwyTtlGxWw7GMBeikqI
         21Fq/dhPZC+A8VJuM8R3Au7hYPT5OQrDaPAX8SfttkcaDG3xPg3FS587AbLkCRJvyWSr
         4yy6f917HtAmfNYYPDFsLOaBNDCQBfkvQCwU//3+WC5zp0ssss5aPdzdmgBLwa/HClwO
         fwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750805278; x=1751410078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSAz7u45fbiPnlHBfjqwquG39PEzYYRrtEXgVLny8hk=;
        b=KtSrZ3gBrsPDPrwLVp1Lxapkqhu5o+IFjA5UCRmbFNbhUg0o//f1bOk5xud5vqZ//J
         f8IP2NdX5Yr48HkBO71qWXGPPxLwEV64P19/QU8CyukkPOAUxjFgnU9wPgKIT3EZ+8+x
         kR5WaGQVOwTpw+IrHZEBpWEjV63uwjO1uoqJ4aSWQxtAMLmdhZU3F3V3q31kP/cMmaDo
         MxM6KiKPWbMniw8ezYRKxcFMdlLKDIMTNB0lz66g8nO0CUhq9JkPcK29q8Elu2IJjZr/
         1X3e1wTJ1m4udJWuDRWk7UJCrXrR7PDOGWEnh9rAk0X7RfgFqOKDIJRdZ1S3+yOaqZE4
         Do3g==
X-Gm-Message-State: AOJu0YxqBgJPlVzUm/WUm4amBI69I9kSGdZ2KoqF3loupS7LLuCZr6If
	nrpW+gSUC39Uc8FUuXnlGtWWikSNPFjvO/9+dgG1eWp2b0GgrnrVJNy19g+KksjrrRj2mAy5G7u
	nLUabXQ==
X-Google-Smtp-Source: AGHT+IHDNXhSrhu+98ao/k9IymjwdfDSwrgsFvpAEAKHNdhVuvcez3bQBiC8pY5aIw1R4xkWPgsg769WHD8=
X-Received: from pjbeu7.prod.google.com ([2002:a17:90a:f947:b0:312:26c4:236])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2790:b0:313:352f:6620
 with SMTP id 98e67ed59e1d1-315f25e2d23mr917917a91.4.1750805277797; Tue, 24
 Jun 2025 15:47:57 -0700 (PDT)
Date: Tue, 24 Jun 2025 15:47:56 -0700
In-Reply-To: <20250612081947.94081-2-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612081947.94081-1-chao.gao@intel.com> <20250612081947.94081-2-chao.gao@intel.com>
Message-ID: <aFsrHCZfB_R1Fao7@google.com>
Subject: Re: [PATCH 1/2] KVM: x86: Deduplicate MSR interception enabling and disabling
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
	dapeng1.mi@linux.intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 12, 2025, Chao Gao wrote:
> Extract a common function from MSR interception disabling logic and create
> disabling and enabling functions based on it. This removes most of the
> duplicated code for MSR interception disabling/enabling.

Awesome!

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 5453478d1ca3..cc5f81afd8af 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -685,21 +685,21 @@ static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
>  	return svm_test_msr_bitmap_write(msrpm, msr);
>  }
>  
> -void svm_disable_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type)
> +void svm_set_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type, bool enable)

I don't love "enable", because without the context of the wrapper to clarify the
polarity, it might not be super obvious that "enable" means "enable interception".

I'm leaning towards "set", which is also flawed, mainly because it conflicts with
the "set" in the function name.  But IMO, that's more of a problem with the function
name.

Anyone have a strong opinion one way or the other?

> -void svm_enable_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type)
> +void svm_disable_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type)

The wrappers can be "static inline" in the header.

If no one objects to s/enable/set (or has an alternative name), I'll apply this:

---
 arch/x86/kvm/svm/svm.c | 21 +++------------------
 arch/x86/kvm/svm/svm.h | 18 ++++++++++--------
 arch/x86/kvm/vmx/vmx.c | 23 +++--------------------
 arch/x86/kvm/vmx/vmx.h | 24 +++++++++++++-----------
 4 files changed, 29 insertions(+), 57 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3c5e82ed6bd4..803574920e41 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -679,21 +679,21 @@ static bool msr_write_intercepted(struct kvm_vcpu *vcpu, u32 msr)
 	return svm_test_msr_bitmap_write(msrpm, msr);
 }
 
-void svm_disable_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type)
+void svm_set_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type, bool set)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	void *msrpm = svm->msrpm;
 
 	/* Don't disable interception for MSRs userspace wants to handle. */
 	if (type & MSR_TYPE_R) {
-		if (kvm_msr_allowed(vcpu, msr, KVM_MSR_FILTER_READ))
+		if (!set && kvm_msr_allowed(vcpu, msr, KVM_MSR_FILTER_READ))
 			svm_clear_msr_bitmap_read(msrpm, msr);
 		else
 			svm_set_msr_bitmap_read(msrpm, msr);
 	}
 
 	if (type & MSR_TYPE_W) {
-		if (kvm_msr_allowed(vcpu, msr, KVM_MSR_FILTER_WRITE))
+		if (!set && kvm_msr_allowed(vcpu, msr, KVM_MSR_FILTER_WRITE))
 			svm_clear_msr_bitmap_write(msrpm, msr);
 		else
 			svm_set_msr_bitmap_write(msrpm, msr);
@@ -703,21 +703,6 @@ void svm_disable_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type)
 	svm->nested.force_msr_bitmap_recalc = true;
 }
 
-void svm_enable_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type)
-{
-	struct vcpu_svm *svm = to_svm(vcpu);
-	void *msrpm = svm->msrpm;
-
-	if (type & MSR_TYPE_R)
-		svm_set_msr_bitmap_read(msrpm, msr);
-
-	if (type & MSR_TYPE_W)
-		svm_set_msr_bitmap_write(msrpm, msr);
-
-	svm_hv_vmcb_dirty_nested_enlightenments(vcpu);
-	svm->nested.force_msr_bitmap_recalc = true;
-}
-
 void *svm_alloc_permissions_map(unsigned long size, gfp_t gfp_mask)
 {
 	unsigned int order = get_order(size);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 8d3279563261..dabd69d6fd15 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -694,16 +694,18 @@ void svm_set_x2apic_msr_interception(struct vcpu_svm *svm, bool disable);
 void svm_complete_interrupt_delivery(struct kvm_vcpu *vcpu, int delivery_mode,
 				     int trig_mode, int vec);
 
-void svm_enable_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type);
-void svm_disable_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type);
+void svm_set_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type, bool set);
 
-static inline void svm_set_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr,
-					     int type, bool enable_intercept)
+static inline void svm_disable_intercept_for_msr(struct kvm_vcpu *vcpu,
+						 u32 msr, int type)
 {
-	if (enable_intercept)
-		svm_enable_intercept_for_msr(vcpu, msr, type);
-	else
-		svm_disable_intercept_for_msr(vcpu, msr, type);
+	svm_set_intercept_for_msr(vcpu, msr, type, false);
+}
+
+static inline void svm_enable_intercept_for_msr(struct kvm_vcpu *vcpu,
+						u32 msr, int type)
+{
+	svm_set_intercept_for_msr(vcpu, msr, type, true);
 }
 
 /* nested.c */
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e2de4748d662..f81710d7d992 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3963,7 +3963,7 @@ static void vmx_msr_bitmap_l01_changed(struct vcpu_vmx *vmx)
 	vmx->nested.force_msr_bitmap_recalc = true;
 }
 
-void vmx_disable_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type)
+void vmx_set_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type, bool set)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	unsigned long *msr_bitmap = vmx->vmcs01.msr_bitmap;
@@ -3974,37 +3974,20 @@ void vmx_disable_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type)
 	vmx_msr_bitmap_l01_changed(vmx);
 
 	if (type & MSR_TYPE_R) {
-		if (kvm_msr_allowed(vcpu, msr, KVM_MSR_FILTER_READ))
+		if (!set && kvm_msr_allowed(vcpu, msr, KVM_MSR_FILTER_READ))
 			vmx_clear_msr_bitmap_read(msr_bitmap, msr);
 		else
 			vmx_set_msr_bitmap_read(msr_bitmap, msr);
 	}
 
 	if (type & MSR_TYPE_W) {
-		if (kvm_msr_allowed(vcpu, msr, KVM_MSR_FILTER_WRITE))
+		if (!set && kvm_msr_allowed(vcpu, msr, KVM_MSR_FILTER_WRITE))
 			vmx_clear_msr_bitmap_write(msr_bitmap, msr);
 		else
 			vmx_set_msr_bitmap_write(msr_bitmap, msr);
 	}
 }
 
-void vmx_enable_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type)
-{
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	unsigned long *msr_bitmap = vmx->vmcs01.msr_bitmap;
-
-	if (!cpu_has_vmx_msr_bitmap())
-		return;
-
-	vmx_msr_bitmap_l01_changed(vmx);
-
-	if (type & MSR_TYPE_R)
-		vmx_set_msr_bitmap_read(msr_bitmap, msr);
-
-	if (type & MSR_TYPE_W)
-		vmx_set_msr_bitmap_write(msr_bitmap, msr);
-}
-
 static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu)
 {
 	/*
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 5a87be8854f3..87174d961c85 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -386,23 +386,25 @@ bool __vmx_vcpu_run(struct vcpu_vmx *vmx, unsigned long *regs,
 int vmx_find_loadstore_msr_slot(struct vmx_msrs *m, u32 msr);
 void vmx_ept_load_pdptrs(struct kvm_vcpu *vcpu);
 
-void vmx_disable_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type);
-void vmx_enable_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type);
+void vmx_set_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type, bool set);
+
+static inline void vmx_disable_intercept_for_msr(struct kvm_vcpu *vcpu,
+						 u32 msr, int type)
+{
+	vmx_set_intercept_for_msr(vcpu, msr, type, false);
+}
+
+static inline void vmx_enable_intercept_for_msr(struct kvm_vcpu *vcpu,
+						u32 msr, int type)
+{
+	vmx_set_intercept_for_msr(vcpu, msr, type, true);
+}
 
 u64 vmx_get_l2_tsc_offset(struct kvm_vcpu *vcpu);
 u64 vmx_get_l2_tsc_multiplier(struct kvm_vcpu *vcpu);
 
 gva_t vmx_get_untagged_addr(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 
-static inline void vmx_set_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr,
-					     int type, bool value)
-{
-	if (value)
-		vmx_enable_intercept_for_msr(vcpu, msr, type);
-	else
-		vmx_disable_intercept_for_msr(vcpu, msr, type);
-}
-
 void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);
 
 u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated);

base-commit: 58c81bc1e71de7d02848a1c1579256f5ebd38e07
--

