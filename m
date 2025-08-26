Return-Path: <linux-kernel+bounces-787318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DE8B37478
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C317AD79C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D5D2820BA;
	Tue, 26 Aug 2025 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BigFS8cY"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B63D26A09F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756244108; cv=none; b=fu/KulnJydn9XJvqErsODZaJHyd9+7pRREp0ejxUEdpvFfi46vAjWNEvQ3g4lPFl/bAwVxb1ajSufyVTcH78utI/z4bd08MrJZIqvvpP9ywwwZZBGO5FFSZqESmX36Z00XEPOdBe+TA6oe3HozJgvXne2X6Enb3QkNH5nGR189k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756244108; c=relaxed/simple;
	bh=eDv1zQV8t3I6XDw5Ypn7Rq/Co3rYQ5LUT/LOJTc2IM8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RuzrvpMTBTnnqSpv2qmyVDengqdr+yWrayGydLIwOj+tDJdWQqiPNF1PPVeiljRZ3UpZgylEuBoIBqhwtvMNFMJJIx78GsatLZ9l8ShzYKG+eXcwKUtuftktfzsT0wbjzf9iflXouOZqlHnIcL+GJK76JnlqDwr3Kkha19yy+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BigFS8cY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2488490fe4eso9685315ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756244107; x=1756848907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZBrP2IJDYDp+nJBUsDlQBqWj1EZD5PynNWw03NETOIg=;
        b=BigFS8cYOaf3v1BfeSf/4WUXSBNK4x5AooEY1ma9Qgo//O/LleWUdHOXipNxOeHZAk
         SGR2xKjXiCjvgx8xvFixXDKZ6JiiQ92VfpObRQZcHuEj2kgzZdTMdJIG8W3qpxaPEhF9
         xkEpOx817h+GX8wFcX7oZ2PxY8eKiba8fbL4VK1hCNWNLHudshEa0439VXZV4EZiLxK2
         Sp2+frgSYaGSHeZdBIOUPqGAIQJVNrlgEu8/tRDhpnqF+o3XwjnovpsIsQpTnXV8Y0+w
         n8vXyI2mSUfTBO5ObO187Ee5EWVZ9xDzXLnYvpqGp10EHQeuH12FMYLwFJ07iV7h+kyZ
         D4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756244107; x=1756848907;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZBrP2IJDYDp+nJBUsDlQBqWj1EZD5PynNWw03NETOIg=;
        b=Z4pgTrUAGhva78a4LUpA7gLvLOufeRP6xiS9qseISu5dg+neSbuag6K5esH0ZTs4ss
         rHXi442LhvP1qiEJfXdiUz5UKg93bTTQhTQ+dpJlnpJe9deXgTWWgMGs6rMm7tvk+PLZ
         kVFgrUFO69erjHR+BNvxbJC027Sh6QWlapgYKwzGm8ydVERvzNAMRn+qXfNGNNJZl0gs
         W84OortXzyXg0xk/fYMiBdDLcVKVOxTbnU7/o1PWgk6GLIU+iBpnJHVDP0IR10X5m8AM
         IUZYGebL3p5VRcwfXrBX4apjfrivIWgD+4GOThW2LJebXzhOKJKE0cQ+LhE6JahRx1OM
         oGtQ==
X-Gm-Message-State: AOJu0YzyH71CSyl3mheL35t7KqrV7M2rk48oSS/W1FdxWbv/WZ6hcPNF
	T8MtkaPt8Y57piYTSRynI3qQZ1XqZ4BSmRgYwuU7QAWvPHLo/Cbswio/bLr6qQOwWlvG2+FYk/c
	nwg==
X-Google-Smtp-Source: AGHT+IHoN7MaNxObnEwGY4TpogKs1gdVdQCBVzLtiNvSgRGxeubf+k4RO9hj+pKRT8sWTgZclIRaX0lelw==
X-Received: from pjbsp3.prod.google.com ([2002:a17:90b:52c3:b0:31f:2a78:943])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e888:b0:246:570:2d99
 with SMTP id d9443c01a7336-2462efc9965mr211397505ad.58.1756244106659; Tue, 26
 Aug 2025 14:35:06 -0700 (PDT)
Date: Tue, 26 Aug 2025 14:34:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826213455.2338722-1-sagis@google.com>
Subject: [PATCH] KVM: TDX: Force split irqchip for TDX at irqchip creation time
From: Sagi Shahar <sagis@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, 
	Sagi Shahar <sagis@google.com>
Content-Type: text/plain; charset="UTF-8"

TDX module protects the EOI-bitmap which prevents the use of in-kernel
I/O APIC. See more details in the original patch [1]

The current implementation already enforces the use of split irqchip for
TDX but it does so at the vCPU creation time which is generally to late
to fallback to split irqchip.

This patch follows Sean's recomendation from [2] and move the check if
I/O APIC is supported for the VM at irqchip creation time.

[1] https://lore.kernel.org/lkml/20250222014757.897978-11-binbin.wu@linux.intel.com/
[2] https://lore.kernel.org/lkml/aK3vZ5HuKKeFuuM4@google.com/

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/vmx/tdx.c          | 15 ++++++++-------
 arch/x86/kvm/x86.c              | 10 ++++++++++
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f19a76d3ca0e..cb22fc48cdec 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1357,6 +1357,7 @@ struct kvm_arch {
 	u8 vm_type;
 	bool has_private_mem;
 	bool has_protected_state;
+	bool has_protected_eoi;
 	bool pre_fault_allowed;
 	struct hlist_head *mmu_page_hash;
 	struct list_head active_mmu_pages;
@@ -2284,6 +2285,8 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
 
 #define kvm_arch_has_readonly_mem(kvm) (!(kvm)->arch.has_protected_state)
 
+#define kvm_arch_has_protected_eoi(kvm) (!(kvm)->arch.has_protected_eoi)
+
 static inline u16 kvm_read_ldt(void)
 {
 	u16 ldt;
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 66744f5768c8..8c270a159692 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -658,6 +658,12 @@ int tdx_vm_init(struct kvm *kvm)
 	 */
 	kvm->max_vcpus = min_t(int, kvm->max_vcpus, num_present_cpus());
 
+	/*
+	 * TDX Module doesn't allow the hypervisor to modify the EOI-bitmap,
+	 * i.e. all EOIs are accelerated and never trigger exits.
+	 */
+	kvm->arch.has_protected_eoi = true;
+
 	kvm_tdx->state = TD_STATE_UNINITIALIZED;
 
 	return 0;
@@ -671,13 +677,8 @@ int tdx_vcpu_create(struct kvm_vcpu *vcpu)
 	if (kvm_tdx->state != TD_STATE_INITIALIZED)
 		return -EIO;
 
-	/*
-	 * TDX module mandates APICv, which requires an in-kernel local APIC.
-	 * Disallow an in-kernel I/O APIC, because level-triggered interrupts
-	 * and thus the I/O APIC as a whole can't be faithfully emulated in KVM.
-	 */
-	if (!irqchip_split(vcpu->kvm))
-		return -EINVAL;
+	/* Split irqchip should be enforced at irqchip creation time. */
+	KVM_BUG_ON(irqchip_split(vcpu->kvm), vcpu->kvm);
 
 	fpstate_set_confidential(&vcpu->arch.guest_fpu);
 	vcpu->arch.apic->guest_apic_protected = true;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a1c49bc681c4..a846dd3dcb23 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6966,6 +6966,16 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		if (irqchip_in_kernel(kvm))
 			goto create_irqchip_unlock;
 
+		/*
+		 * Disallow an in-kernel I/O APIC for platforms that has protected
+		 * EOI (such as TDX). The hypervisor can't modify the EOI-bitmap
+		 * on these platforms which prevents the proper emulation of
+		 * level-triggered interrupts.
+		 */
+		r = -ENOTTY;
+		if (kvm_arch_has_protected_eoi(kvm))
+			goto create_irqchip_unlock;
+
 		r = -EINVAL;
 		if (kvm->created_vcpus)
 			goto create_irqchip_unlock;
-- 
2.51.0.261.g7ce5a0a67e-goog


