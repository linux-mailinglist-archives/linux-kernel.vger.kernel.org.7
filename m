Return-Path: <linux-kernel+bounces-660143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CD3AC196E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 03:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783BF172AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 01:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CD92DFA46;
	Fri, 23 May 2025 01:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T7cx3MkF"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0682D8DD7
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 01:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962098; cv=none; b=JQKd8PLtdGKiBfpHV14ciOn6QFn+sPPaXcgs5ogpK0HQvYIllVrYzZh7+RmavzNDeObapzTQBCaEAF+FObL5Pqpx1KIP2uNI+uTx8kQ+BlpyViFJPg/1XlhTGo+3mL/L+0jNDa1pdRV76AIMPBBYu6gYGsWhWR5v25kMqTwIVHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962098; c=relaxed/simple;
	bh=Fn7KiHU3iwTubBKYwKGiV6sXLcq7ApYRqC3g9dRrbxA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f6p5mkGP6FAia/3y3alwugTjV0nBGOeLfsmGayceNkP2M3tBByfE01m6btLyCi41o7XRE7hsMbBW5gi/jHvSqFzglc10OTzRDowpoa08qIyw8wBfPY+KFwx4dxBzy7EjZGpUIIbh9zh2eEbnc82L+foqAsDR/EQjkD5V0X6REwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T7cx3MkF; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b1f71ae2181so5500695a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 18:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962096; x=1748566896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2sXU5NirlWI4vXwO4O+/fMttYQH02wVCGMPtDp7+cuU=;
        b=T7cx3MkFa4HMkaJu6JgdZuYCTwhsWJjAjX8ep4O2dCj4Xan0j/LvkgLfGx23cJeRAW
         n0B/+DuQasfeFqHPEaqfK6XYiSCGtDZYDfIoWMmG+HI8IXBabwlxoB4MKEJG5D8PxW1n
         EM8ujuMsSvA+beEPFUImplfrp9qmoyoiVw3qSAoj6e2POdof2Mhr/846d0CyL7l0bzxi
         7EYwtGxGMmKgG6z3/XOgKd2eFj2jURZ6MrMcKyjGSiVQHbHCgeNrC9zea3aaEY0kASjf
         UJB+ljy1Emh6zGzMyaXDsP+N2zc/cVjzV1rjS8WN3u4VdadOpmi7TRRXbRi5vcjOhfAv
         uNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962096; x=1748566896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sXU5NirlWI4vXwO4O+/fMttYQH02wVCGMPtDp7+cuU=;
        b=q9nLIl9k2KDGCna+sVuo2IvrETSOOiTRzyuIuRNeuA5K0cepU6bi/xKq3d7tqGQxDB
         8Zc7Jjx2UNwLaRyYotrvZftg06ld+aj155Uwup+THUQ7S5LP5zV//5KkrdZ/KYYJSdrv
         nfYW4AcKXYNeeRLBQOfDSIgDsVGsbnMGDP5c+Fw3afe6bZ7wQjDz0p1TR+GsRv/r1sY3
         Sv+Khzr6DR3kWxmc6Kh1nUvB4Jpbvo0S173Wi1WQmvfShpYe3+9vt2JjaDVvkC+AjQ8r
         P9cK/7cpEie/9Rjud+MnmaAt4kzngPooM/niiaRv3l+xn9DSiiD8rGzWktZIcmBXmeV5
         C7pw==
X-Forwarded-Encrypted: i=1; AJvYcCV1CC+UtIRCx67phY1QeMm85k/bzcp0l7hlpmHDaACRm6l9Fe3ULGJe1L1Xpvf+sBd9hiIvHSytH684/rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ16tx5MYcKmU69SoGsjobjIysBl8AQmjebf7hXsPC95JKPkwf
	bbDHsFeZS5BeOCF6BUeWAhDLt0m3c/xwQZM6otCXSO9l9tbWq8nO1fk5XOb8cHet47SU03TZWM+
	0F0QTng==
X-Google-Smtp-Source: AGHT+IGiMys227SN7kU9jYy897MYWWwW5oyGCez8BLejTJH7O2I8eA/lDZQP1siXEpwe3ZlPz5yF5IFZSwI=
X-Received: from pjbph7.prod.google.com ([2002:a17:90b:3bc7:b0:30a:9cb5:7622])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1645:b0:310:8d9a:ede1
 with SMTP id 98e67ed59e1d1-310e96b6007mr1848663a91.4.1747962096179; Thu, 22
 May 2025 18:01:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:56 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-52-seanjc@google.com>
Subject: [PATCH v2 51/59] KVM: x86: Decouple device assignment from IRQ bypass
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Use a dedicated counter to track the number of IRQs that can utilize IRQ
bypass instead of piggybacking the assigned device count.  As evidenced by
commit 2edd9cb79fb3 ("kvm: detect assigned device via irqbypass manager"),
it's possible for a device to be able to post IRQs to a vCPU without said
device being assigned to a VM.

Leave the calls to kvm_arch_{start,end}_assignment() alone for the moment
to avoid regressing the MMIO stale data mitigation.  KVM is abusing the
assigned device count when applying mmio_stale_data_clear, and it's not at
all clear if vDPA devices rely on this behavior.  This will hopefully be
cleaned up in the future, as the number of assigned devices is a terrible
heuristic for detecting if a VM has access to host MMIO.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  2 +-
 arch/x86/include/asm/kvm_host.h    |  4 +++-
 arch/x86/kvm/irq.c                 |  9 ++++++++-
 arch/x86/kvm/vmx/main.c            |  2 +-
 arch/x86/kvm/vmx/posted_intr.c     | 16 ++++++++++------
 arch/x86/kvm/vmx/posted_intr.h     |  2 +-
 arch/x86/kvm/x86.c                 |  3 +--
 7 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 8d50e3e0a19b..8897f509860c 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -112,7 +112,7 @@ KVM_X86_OP_OPTIONAL(update_cpu_dirty_logging)
 KVM_X86_OP_OPTIONAL(vcpu_blocking)
 KVM_X86_OP_OPTIONAL(vcpu_unblocking)
 KVM_X86_OP_OPTIONAL(pi_update_irte)
-KVM_X86_OP_OPTIONAL(pi_start_assignment)
+KVM_X86_OP_OPTIONAL(pi_start_bypass)
 KVM_X86_OP_OPTIONAL(apicv_pre_state_restore)
 KVM_X86_OP_OPTIONAL(apicv_post_state_restore)
 KVM_X86_OP_OPTIONAL_RET0(dy_apicv_has_pending_interrupt)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c722adfedd96..01edcefbd937 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1382,6 +1382,8 @@ struct kvm_arch {
 	atomic_t noncoherent_dma_count;
 #define __KVM_HAVE_ARCH_ASSIGNED_DEVICE
 	atomic_t assigned_device_count;
+	unsigned long nr_possible_bypass_irqs;
+
 #ifdef CONFIG_KVM_IOAPIC
 	struct kvm_pic *vpic;
 	struct kvm_ioapic *vioapic;
@@ -1855,7 +1857,7 @@ struct kvm_x86_ops {
 	int (*pi_update_irte)(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			      unsigned int host_irq, uint32_t guest_irq,
 			      struct kvm_vcpu *vcpu, u32 vector);
-	void (*pi_start_assignment)(struct kvm *kvm);
+	void (*pi_start_bypass)(struct kvm *kvm);
 	void (*apicv_pre_state_restore)(struct kvm_vcpu *vcpu);
 	void (*apicv_post_state_restore)(struct kvm_vcpu *vcpu);
 	bool (*dy_apicv_has_pending_interrupt)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index b6263ab4b18d..7586cf6f1215 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -570,10 +570,15 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 	spin_lock_irq(&kvm->irqfds.lock);
 	irqfd->producer = prod;
 
+	if (!kvm->arch.nr_possible_bypass_irqs++)
+		kvm_x86_call(pi_start_bypass)(kvm);
+
 	if (irqfd->irq_entry.type == KVM_IRQ_ROUTING_MSI) {
 		ret = kvm_pi_update_irte(irqfd, &irqfd->irq_entry);
-		if (ret)
+		if (ret) {
+			kvm->arch.nr_possible_bypass_irqs--;
 			kvm_arch_end_assignment(irqfd->kvm);
+		}
 	}
 	spin_unlock_irq(&kvm->irqfds.lock);
 
@@ -606,6 +611,8 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	}
 	irqfd->producer = NULL;
 
+	kvm->arch.nr_possible_bypass_irqs--;
+
 	spin_unlock_irq(&kvm->irqfds.lock);
 
 
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index d1e02e567b57..a986fc45145e 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -1014,7 +1014,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.nested_ops = &vmx_nested_ops,
 
 	.pi_update_irte = vmx_pi_update_irte,
-	.pi_start_assignment = vmx_pi_start_assignment,
+	.pi_start_bypass = vmx_pi_start_bypass,
 
 #ifdef CONFIG_X86_64
 	.set_hv_timer = vt_op(set_hv_timer),
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 3a23c30f73cb..5671d59a6b6d 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -146,8 +146,13 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 
 static bool vmx_can_use_vtd_pi(struct kvm *kvm)
 {
+	/*
+	 * Note, reading the number of possible bypass IRQs can race with a
+	 * bypass IRQ being attached to the VM.  vmx_pi_start_bypass() ensures
+	 * blockng vCPUs will see an elevated count or get KVM_REQ_UNBLOCK.
+	 */
 	return irqchip_in_kernel(kvm) && kvm_arch_has_irq_bypass() &&
-	       kvm_arch_has_assigned_device(kvm);
+	       READ_ONCE(kvm->arch.nr_possible_bypass_irqs);
 }
 
 /*
@@ -285,12 +290,11 @@ bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu)
 
 
 /*
- * Bail out of the block loop if the VM has an assigned
- * device, but the blocking vCPU didn't reconfigure the
- * PI.NV to the wakeup vector, i.e. the assigned device
- * came along after the initial check in vmx_vcpu_pi_put().
+ * Kick all vCPUs when the first possible bypass IRQ is attached to a VM, as
+ * blocking vCPUs may scheduled out without reconfiguring PID.NV to the wakeup
+ * vector, i.e. if the bypass IRQ came along after vmx_vcpu_pi_put().
  */
-void vmx_pi_start_assignment(struct kvm *kvm)
+void vmx_pi_start_bypass(struct kvm *kvm)
 {
 	if (!kvm_arch_has_irq_bypass())
 		return;
diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
index 94ed66ea6249..a4af39948cf0 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -17,7 +17,7 @@ bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu);
 int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		       unsigned int host_irq, uint32_t guest_irq,
 		       struct kvm_vcpu *vcpu, u32 vector);
-void vmx_pi_start_assignment(struct kvm *kvm);
+void vmx_pi_start_bypass(struct kvm *kvm);
 
 static inline int pi_find_highest_vector(struct pi_desc *pi_desc)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3966801bcb0d..3969e439a6bb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13563,8 +13563,7 @@ bool kvm_arch_can_dequeue_async_page_present(struct kvm_vcpu *vcpu)
 
 void kvm_arch_start_assignment(struct kvm *kvm)
 {
-	if (atomic_inc_return(&kvm->arch.assigned_device_count) == 1)
-		kvm_x86_call(pi_start_assignment)(kvm);
+	atomic_inc(&kvm->arch.assigned_device_count);
 }
 EXPORT_SYMBOL_GPL(kvm_arch_start_assignment);
 
-- 
2.49.0.1151.ga128411c76-goog


