Return-Path: <linux-kernel+bounces-823803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF14B87771
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9621A4634BC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E5F257435;
	Fri, 19 Sep 2025 00:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z8WynN0e"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE283242D90
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758241309; cv=none; b=HSnc2SBL7263dTAW/O/kl9hATjiUGOCAPI1L8fjjGcfzhxULdcGjsAMTp6YYGJAyUSrThUVsGpZUIVB24chpfJOPiyxmM87PUlFtv3F23lfTSNh2JClFDk/pIS+wDIHrR+O1K5f3eU3fPz5B/AiCfozc+uOG0XaAcTd+JPQBed4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758241309; c=relaxed/simple;
	bh=IfY/xWqLju6z1i9j08csVsCUWHiCD21f3aCojpm/vuY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D/X58uAD9BsxNFKq9k5UizcC+eEd90wIC1qCGDEexMnT5gkB3fikq9sPmnpGSMwXd7j9B+Qe64TixfprEvmCcyUGMCzamD3cgz37HGRGMRQrTc6RW3JQ3rQlHo0fQlbthvR6RcuXFriq+xL06arFEggOcNySxUfBAZffg6aiyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z8WynN0e; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32e09eaf85dso1828484a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758241307; x=1758846107; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=K7llSVRIs9U5C5CnaMI09gL0pcA7eLTkm/IDK1pERDI=;
        b=z8WynN0eGIdQVJWvrLWjnEHSX9GaEJDgxR8D+pJNp1RqoYdKtKAz4j/Zy347w8OUUA
         KdqYlVkGlTYtP9daUi57mpLdJiDPoq7CK/XCWOIO5wrBcQLd3X1dr3g5gWznVq+g+0SL
         tqWxJZe6wvOYKfGqT8kFpQkBksnlCM0DeMCuG/HQdVcjU7rgUdyiXEllYJsT3FivmzsW
         hwyE6Sc/z0WMg/1IZwnM2svgBYgFH+WcBudYwkGwCc6Z5a08v0FTIAcn/Kx72iSorLbQ
         qed9kjM7M5VHLZlo5TiamxcJi302frLK7URSkRy5yq3csBWNNnGPqFXTjUOl5cSsyOi7
         5WDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758241307; x=1758846107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7llSVRIs9U5C5CnaMI09gL0pcA7eLTkm/IDK1pERDI=;
        b=eRna99GxG4b9DehWtw+U2ARZ6VjAubIIgj6wr8AV18Ox7UYduNA++/OscSjWyFaMnr
         m3s/DIfqI2LgHdvApwFT7bdj+0n4B7oqJRTSD67YDq7zU2AP5cdRk68VPVuPEnN7hmlk
         K4R8m/vRz1Gi/wGt82S06bQuXs8PhIpM8dmLiQtbiOQIfUDNcGJ6PVPuBBf0kLGA0ySL
         RcAVtgfSuUOSHYVksAnyl9k5kkFQlTASjpi/eVPIPpLEl4Xl/2HFQ7Mq7TkdCx+wiSzv
         RJydVeKtneg5W33NDCZ3WQz0t8XN0IbREzE3YQO+yjn2l3aW0qVQI5DKp6FHJa4oTTL5
         FFSw==
X-Forwarded-Encrypted: i=1; AJvYcCUqK7JelZqgvFCFmU7Mm69HtCYgeabcccpErauH3LMaKCvH5bgA7mOjZdgzqpbtmoEhV1zOT4jb2rE2FrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo3tfRh+y333T6FYdaXnZNktpLXPai9eqXWVf3z1KrC7KypEnE
	Tca+APy6d+BpucPZ7l86hlJhWaF+6XOIpmJJsXFHm/M2pgM+YnhlkkNGwWca0Cd768y+tF4PPeD
	kkx8DEw==
X-Google-Smtp-Source: AGHT+IE1fE33AtDRuhYUTYDBtdduMosa7VBLL8B8ismrzSfpz/BCmq2WAHPLMuNvmljvZVAXcYQk40xb2Ss=
X-Received: from pjbsi16.prod.google.com ([2002:a17:90b:5290:b0:32e:8ff7:495])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d4d:b0:327:b2a1:2964
 with SMTP id 98e67ed59e1d1-33097ffc62amr1870188a91.15.1758241307360; Thu, 18
 Sep 2025 17:21:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Sep 2025 17:21:35 -0700
In-Reply-To: <20250919002136.1349663-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919002136.1349663-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919002136.1349663-6-seanjc@google.com>
Subject: [PATCH v3 5/6] KVM: SVM: Move global "avic" variable to avic.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Move "avic" to avic.c so that it's colocated with the other AVIC specific
globals and module params, and so that avic_hardware_setup() is a bit more
self-contained, e.g. similar to sev_hardware_setup().

Deliberately set enable_apicv in svm.c as it's already globally visible
(defined by kvm.ko, not by kvm-amd.ko), and to clearly capture the
dependency on enable_apicv being initialized (svm_hardware_setup() clears
several AVIC-specific hooks when enable_apicv is disabled).

Alternatively, clearing of the hooks (and enable_ipiv) could be moved to
avic_hardware_setup(), but that's not obviously better, e.g. it's helpful
to isolate the setting of enable_apicv when reading code from the generic
x86 side of the world.

No functional change intended.

Cc: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 32 ++++++++++++++++++++++++--------
 arch/x86/kvm/svm/svm.c  | 11 +----------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 497d755c206f..e059dcae6945 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -64,6 +64,14 @@
 
 static_assert(__AVIC_GATAG(AVIC_VM_ID_MASK, AVIC_VCPU_IDX_MASK) == -1u);
 
+/*
+ * enable / disable AVIC.  Because the defaults differ for APICv
+ * support between VMX and SVM we cannot use module_param_named.
+ */
+static bool avic;
+module_param(avic, bool, 0444);
+module_param(enable_ipiv, bool, 0444);
+
 static bool force_avic;
 module_param_unsafe(force_avic, bool, 0444);
 
@@ -1141,15 +1149,9 @@ void avic_vcpu_unblocking(struct kvm_vcpu *vcpu)
 	avic_vcpu_load(vcpu, vcpu->cpu);
 }
 
-/*
- * Note:
- * - The module param avic enable both xAPIC and x2APIC mode.
- * - Hypervisor can support both xAVIC and x2AVIC in the same guest.
- * - The mode can be switched at run-time.
- */
-bool __init avic_hardware_setup(struct kvm_x86_ops *svm_ops)
+static bool __init avic_want_avic_enable(void)
 {
-	if (!npt_enabled)
+	if (!avic || !npt_enabled)
 		return false;
 
 	/* AVIC is a prerequisite for x2AVIC. */
@@ -1174,6 +1176,20 @@ bool __init avic_hardware_setup(struct kvm_x86_ops *svm_ops)
 		pr_warn("AVIC unsupported in CPUID but force enabled, your system might crash and burn\n");
 
 	pr_info("AVIC enabled\n");
+	return true;
+}
+
+/*
+ * Note:
+ * - The module param avic enable both xAPIC and x2APIC mode.
+ * - Hypervisor can support both xAVIC and x2AVIC in the same guest.
+ * - The mode can be switched at run-time.
+ */
+bool __init avic_hardware_setup(struct kvm_x86_ops *svm_ops)
+{
+	avic = avic_want_avic_enable();
+	if (!avic)
+		return false;
 
 	/* AVIC is a prerequisite for x2AVIC. */
 	x2avic_enabled = boot_cpu_has(X86_FEATURE_X2AVIC);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d4643dce7c91..c473246f8881 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -158,14 +158,6 @@ module_param(lbrv, int, 0444);
 static int tsc_scaling = true;
 module_param(tsc_scaling, int, 0444);
 
-/*
- * enable / disable AVIC.  Because the defaults differ for APICv
- * support between VMX and SVM we cannot use module_param_named.
- */
-static bool avic;
-module_param(avic, bool, 0444);
-module_param(enable_ipiv, bool, 0444);
-
 module_param(enable_device_posted_irqs, bool, 0444);
 
 bool __read_mostly dump_invalid_vmcb;
@@ -5354,8 +5346,7 @@ static __init int svm_hardware_setup(void)
 			goto err;
 	}
 
-	enable_apicv = avic = avic && avic_hardware_setup(&svm_x86_ops);
-
+	enable_apicv = avic_hardware_setup(&svm_x86_ops);
 	if (!enable_apicv) {
 		enable_ipiv = false;
 		svm_x86_ops.vcpu_blocking = NULL;
-- 
2.51.0.470.ga7dc726c21-goog


