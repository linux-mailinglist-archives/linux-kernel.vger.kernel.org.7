Return-Path: <linux-kernel+bounces-589331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3253A7C414
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 21:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE4287A977F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 19:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB4424BC14;
	Fri,  4 Apr 2025 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwR6Q7e9"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACADE248861
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795687; cv=none; b=VXuvwhcCP9IVIyhki7eyQm4Yc/r0z8VNdTm+9kkQEWWJti3mynFynMtXL7VdJZNlaUPHR8zR6OvRgYrNjK0SIVPt85dkXH+n2ZvuEB32PCNycFcS+W72Av+ZPMPKO1gVmN4DASLQwIKL3V+YiBYd1wNb2gdPp/fWptlpgzchC/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795687; c=relaxed/simple;
	bh=CJbM5ki6wbRFycki9+F8amVo8XEDR5j/tEEiEsSHYK4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q/1zpTE0JAqse2vkDiMI968Jn3r/p4fK0aPi+0kgTkoWILP+Ll/xTgOGSl7rEWqB3pHneFlW+D0tNwnKbDorrj23ApQTGoYsDqtXDX/NFxaPcfplNxnh1f4/gRkufIxzhDLeq58ZdmvLyfwMvJjP2gehjBGCqTZ8JVfp+lrZ2cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uwR6Q7e9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff78bd3026so2295924a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Apr 2025 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795685; x=1744400485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4PrXQXNJnenxPucuA/yaggd1GFmcPYwGnyvurjMeKTM=;
        b=uwR6Q7e9Trwz05/kEicsgJC1kcNkci0WLv6X7ApIqiwVaQ4AJK6ZFE3pGkl+8TasiM
         evqDkS9GZ+SoIiRVMZ/MZKa3DwhYHOBiuixyXkHTMpe+ws1Z5HxEnBFNUHuYi3CYIFZl
         aoIoGcwgaqRXktEb37WMZF6z+3GGTkEC7c8vgDEgAIGCvMd4QB38L5k3ZtjMjGB1ma0U
         LSEUjBLV9eo6x+szQrSWSGnSSDvaj768AP6P5CQ1POOX5UbkUz98urbHoJDBQGijPbvp
         L6M+lLDrZer5mcO0/jkjiP7JvH5JBo5Al917dBeXVBtTXs+uw6SlEFm5miqYU+qG4TMD
         AZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795685; x=1744400485;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PrXQXNJnenxPucuA/yaggd1GFmcPYwGnyvurjMeKTM=;
        b=unc3g3tR1s7T307Z9Yu6jZ0R6Gmy9eqcX8uIT2IVFMtESFn1ZLu4Cuc3JlWl2E5LnI
         O7huLyw8AOImxWBh/uroASAglmufGUH/+q8UrGnylMWIr72LCu4hx5A1P3T6RziTLOvV
         Gl411h65vUeAnyb4TulidhBQPSt62LlTTkIQE9E7HNgl/jDaFQ+YLgv7zQcsTpNI6B2j
         11QlOGgVJTEeLrDXVRc0ra7x0XE8RUkv6Zg+Gxe1t9zSvVl7OHeoHNvcRU5ZXTw13+h4
         1fQb8Gjdmpy0X1s67+3eOte1weuXv1UggJgnwzIgRMDVJWqgun5hKpjjV8HCskkHnpP4
         594Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkOvQl/8ZR4tRuUpLXCE4CamqbADk91qzBy5of2izfjEgrldAZ2xMP7tBXMLu7P0ZcPZvxCeBQWC3JuyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxumDV6HxVUyxeK5ozInfEuvsXEYAuuUb/Fsii3HtDKeXhBmNpJ
	C0pd7bW9xNXGNrm44bDRhnB5pOdHN0JsyYWZmtUDaNZ0nqVW7qwYeuvY8q4NOaoO/iOvtwz2uMu
	iZQ==
X-Google-Smtp-Source: AGHT+IHQ6ptEcPjIqq3mLe7k3SWbX89UMoO78N6d4VQjJKucTdQNZ9R4r8s6zKowOLbjvdi2tyWJH46WVgk=
X-Received: from pjbsd12.prod.google.com ([2002:a17:90b:514c:b0:2ff:6e58:89f7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d0b:b0:2ff:6bd0:ff26
 with SMTP id 98e67ed59e1d1-306af7b7889mr596948a91.34.1743795685197; Fri, 04
 Apr 2025 12:41:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:39:12 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-58-seanjc@google.com>
Subject: [PATCH 57/67] KVM: x86: Decouple device assignment from IRQ bypass
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
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
 arch/x86/include/asm/kvm_host.h    |  3 ++-
 arch/x86/kvm/vmx/main.c            |  2 +-
 arch/x86/kvm/vmx/posted_intr.c     | 16 ++++++++++------
 arch/x86/kvm/vmx/posted_intr.h     |  2 +-
 arch/x86/kvm/x86.c                 | 12 +++++++++---
 6 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 823c0434bbad..435b9b76e464 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -111,7 +111,7 @@ KVM_X86_OP_OPTIONAL(update_cpu_dirty_logging)
 KVM_X86_OP_OPTIONAL(vcpu_blocking)
 KVM_X86_OP_OPTIONAL(vcpu_unblocking)
 KVM_X86_OP_OPTIONAL(pi_update_irte)
-KVM_X86_OP_OPTIONAL(pi_start_assignment)
+KVM_X86_OP_OPTIONAL(pi_start_bypass)
 KVM_X86_OP_OPTIONAL(apicv_pre_state_restore)
 KVM_X86_OP_OPTIONAL(apicv_post_state_restore)
 KVM_X86_OP_OPTIONAL_RET0(dy_apicv_has_pending_interrupt)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cb98d8d3c6c2..88b842cd8959 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1372,6 +1372,7 @@ struct kvm_arch {
 	atomic_t noncoherent_dma_count;
 #define __KVM_HAVE_ARCH_ASSIGNED_DEVICE
 	atomic_t assigned_device_count;
+	unsigned long nr_possible_bypass_irqs;
 	struct kvm_pic *vpic;
 	struct kvm_ioapic *vioapic;
 	struct kvm_pit *vpit;
@@ -1840,7 +1841,7 @@ struct kvm_x86_ops {
 			      unsigned int host_irq, uint32_t guest_irq,
 			      struct kvm_kernel_irq_routing_entry *new,
 			      struct kvm_vcpu *vcpu, u32 vector);
-	void (*pi_start_assignment)(struct kvm *kvm);
+	void (*pi_start_bypass)(struct kvm *kvm);
 	void (*apicv_pre_state_restore)(struct kvm_vcpu *vcpu);
 	void (*apicv_post_state_restore)(struct kvm_vcpu *vcpu);
 	bool (*dy_apicv_has_pending_interrupt)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 43ee9ed11291..95371f26ce20 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -133,7 +133,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.nested_ops = &vmx_nested_ops,
 
 	.pi_update_irte = vmx_pi_update_irte,
-	.pi_start_assignment = vmx_pi_start_assignment,
+	.pi_start_bypass = vmx_pi_start_bypass,
 
 #ifdef CONFIG_X86_64
 	.set_hv_timer = vmx_set_hv_timer,
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 2958b631fde8..457a5b21c9d3 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -132,8 +132,13 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 
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
@@ -251,12 +256,11 @@ bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu)
 
 
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
index ee3e19e976ac..c3f12a35a7c1 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -17,7 +17,7 @@ int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		       unsigned int host_irq, uint32_t guest_irq,
 		       struct kvm_kernel_irq_routing_entry *new,
 		       struct kvm_vcpu *vcpu, u32 vector);
-void vmx_pi_start_assignment(struct kvm *kvm);
+void vmx_pi_start_bypass(struct kvm *kvm);
 
 static inline int pi_find_highest_vector(struct pi_desc *pi_desc)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 49c3360eb4e8..fec43d6a2b63 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13511,8 +13511,7 @@ bool kvm_arch_can_dequeue_async_page_present(struct kvm_vcpu *vcpu)
 
 void kvm_arch_start_assignment(struct kvm *kvm)
 {
-	if (atomic_inc_return(&kvm->arch.assigned_device_count) == 1)
-		kvm_x86_call(pi_start_assignment)(kvm);
+	atomic_inc(&kvm->arch.assigned_device_count);
 }
 EXPORT_SYMBOL_GPL(kvm_arch_start_assignment);
 
@@ -13630,10 +13629,15 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 	spin_lock_irq(&kvm->irqfds.lock);
 	irqfd->producer = prod;
 
+	if (!kvm->arch.nr_possible_bypass_irqs++)
+		kvm_x86_call(pi_start_bypass)(kvm);
+
 	if (irqfd->irq_entry.type == KVM_IRQ_ROUTING_MSI) {
 		ret = kvm_pi_update_irte(irqfd, NULL, &irqfd->irq_entry);
-		if (ret)
+		if (ret) {
+			kvm->arch.nr_possible_bypass_irqs--;
 			kvm_arch_end_assignment(irqfd->kvm);
+		}
 	}
 	spin_unlock_irq(&kvm->irqfds.lock);
 
@@ -13666,6 +13670,8 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	}
 	irqfd->producer = NULL;
 
+	kvm->arch.nr_possible_bypass_irqs--;
+
 	spin_unlock_irq(&kvm->irqfds.lock);
 
 
-- 
2.49.0.504.g3bcea36a83-goog


