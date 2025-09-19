Return-Path: <linux-kernel+bounces-825256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAF0B8B6E8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB97317E0B6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DACC2DCC1A;
	Fri, 19 Sep 2025 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5o6JzBI"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540D92DA771
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319188; cv=none; b=MXGpHPUgnBWpvLXgJCzaLAhuCV1FxoHXWCq+WN49ZDAdSldrDjUgn6djnkHoKHzoioAiDpREf05IuUCmYnzOtwnOQcVchBFxC1A7J9GfMBSKVUQZWinCMxv1fRuFyekMnUnEisH3287Yuo5zTqQwnFxtjvULUb8teUDaQE8+b0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319188; c=relaxed/simple;
	bh=i9Iimsx4v+q1gBX8cJfdi0XkMDcu7LvFrbMJ+LPx1OQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AZer4jh3i/n9kOS39Uf1kDbeg7eAKPyP7zbbLM606d1QU9r57QiqH9U65ds1vfqgv1C5n9pll1nsSLIs+lG4Jt/9wxoFDpTqkXE/rIAmbLH94MnCyilRYdPCLMgr8WkMrTwhEOygJpWcRrpE2DrTXPmWqH9Jsdm33wK+MdMJnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5o6JzBI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32d4e8fe166so3308863a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758319187; x=1758923987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9y6Hp1rf7kd+0Pe5dJOMQ6fwcx2skAdjzi47qVJrNpQ=;
        b=V5o6JzBImqfAX5iPUlMOMr4FddgiowU77AGzXf/YJdPz7GOj09AR8hWQjanGnWoTiQ
         /6dGglGWfDbJZWzmdEOlk3L2ZWSyRS5zw5zcCvBYfWX5OBnVpVTl6TNsL+dcNhH7OVUr
         pyXbQa/uUbpjZtaI09vfTYTOxhXKI/q2liyW3zefy/V97SlWesqVjpiRoNyFDW2/g22C
         kAbl/cTNOGhEhw3S5TtVuHjFwcALJw6Y6vCIbzhgxf2JKGI5IHwNwyuk1lKSqBsKbr5p
         2byYjbzsSrIggeCcKGb49thVss8a32J42Zao3mvPlUMChXuTk7VGkbZSgiIst2KibUoJ
         QNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758319187; x=1758923987;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9y6Hp1rf7kd+0Pe5dJOMQ6fwcx2skAdjzi47qVJrNpQ=;
        b=Z0I+tBWlhJ913x7+uXFMCoDYLUn1usMartScN/XAlzN2dUbXI5S+sY+qcKqPkwmK/n
         h0kKKRMVN63GJO5n0qcgBh/Ng/r5eF0q5n9FlyBr3t9110FTaqdHs2ZwszK7J76xcqaF
         qGVdRggzLgmY6xOmuxkHjXtxi6gXUz+OS/TEAOf5JtmuuBebsjF5RoJY5Zp0/oXSWG2M
         mnZpuczHlRwPJD1nhYfEiPj0LvtMgJAdBNVL4lJZd8rqZNEy4HYGLEbu6l+DOmmUGeFZ
         gJJmM3PmiQGObv0OWopi1Jt3SRIJXVmpg2ZzgrFS5lKvR4SKP5Cz9UDG8IpL7LO8Za2F
         Sbag==
X-Forwarded-Encrypted: i=1; AJvYcCWq4OSTsv/jMarmx4prQN0geBbgOBBZoPJMnFgZnlb/fo0arLHYzStu9JZV+DEWtUq0I1IOBvkRnlFXzsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBKuDrgDZ0AiAHCTMP13r+D1oLSd0ZrQIRczAAhFZRMjsxBOUm
	5le0t/H/FsywF1RgHjiF6NpboorUtbZ7eHtCompNJskxjRNs1dkeu4I05g3lumR3LLlOvfwDu3P
	wZ/JjEw==
X-Google-Smtp-Source: AGHT+IE6eTCiYTaQBQ+5vfeBwBizOafjNWBZnVxWV3RwWacoWhikBPshDUc3hoEkxzJWDlK5a82nK4RpcvQ=
X-Received: from pjbpb2.prod.google.com ([2002:a17:90b:3c02:b0:330:6d2f:1b62])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e703:b0:32b:8b8d:c2d1
 with SMTP id 98e67ed59e1d1-33098246221mr5801081a91.21.1758319186659; Fri, 19
 Sep 2025 14:59:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 14:59:33 -0700
In-Reply-To: <20250919215934.1590410-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919215934.1590410-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919215934.1590410-7-seanjc@google.com>
Subject: [PATCH v4 6/7] KVM: SVM: Move global "avic" variable to avic.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
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

Acked-by: Naveen N Rao (AMD) <naveen@kernel.org>
Tested-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 33 +++++++++++++++++++++++++--------
 arch/x86/kvm/svm/svm.c  | 11 +----------
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 35dde7d89f56..ec214062d136 100644
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
-bool __init avic_hardware_setup(void)
+static bool __init avic_want_avic_enabled(void)
 {
-	if (!npt_enabled)
+	if (!avic || !npt_enabled)
 		return false;
 
 	/* AVIC is a prerequisite for x2AVIC. */
@@ -1173,6 +1175,21 @@ bool __init avic_hardware_setup(void)
 	if (!boot_cpu_has(X86_FEATURE_AVIC))
 		pr_warn("AVIC unsupported in CPUID but force enabled, your system might crash and burn\n");
 
+	return true;
+}
+
+/*
+ * Note:
+ * - The module param avic enable both xAPIC and x2APIC mode.
+ * - Hypervisor can support both xAVIC and x2AVIC in the same guest.
+ * - The mode can be switched at run-time.
+ */
+bool __init avic_hardware_setup(void)
+{
+	avic = avic_want_avic_enabled();
+	if (!avic)
+		return false;
+
 	pr_info("AVIC enabled\n");
 
 	/* AVIC is a prerequisite for x2AVIC. */
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 45ede8fcf5d2..c7799fc72f29 100644
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
 
-	enable_apicv = avic = avic && avic_hardware_setup();
-
+	enable_apicv = avic_hardware_setup();
 	if (!enable_apicv) {
 		enable_ipiv = false;
 		svm_x86_ops.vcpu_blocking = NULL;
-- 
2.51.0.470.ga7dc726c21-goog


