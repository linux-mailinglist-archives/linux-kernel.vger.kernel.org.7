Return-Path: <linux-kernel+bounces-682553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E53DDAD619F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 23:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E181BC3DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 21:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AEC261586;
	Wed, 11 Jun 2025 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYe7GXYL"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E8925EF93
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677792; cv=none; b=AVTtUZdcEeDYPyc9Yw46kLnZs8DJe7dDAkFZzLJos0Dc4Sw5nei0dSTO0ylygU+5b8ncAsXwr2WEj/iS+HrVkP3AZC3ka+wndcQOKi5erltr5y/2XICaJ9XpREx3G04IUYCjzBPw6XWZ3sB2iCBCLFknWHG+1bYvpusEGyF+zDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677792; c=relaxed/simple;
	bh=UW/uvryfcoYKLgUyl50A/XgEdMtEQO2H+FcIsqMZYE4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NGtaHL8FmaUamIzlePAynS4c3z0xwhdUnNpsiYOynwGPQHjR+VnWvyrYJlQaThy9aFh213uZ4bHzSJv920cNSHMn8wCVP5uvCeCJhcD++p4lZhLrVigWcCSk6OOy0IXL8KtZd1HSWWS/xTjYZ7hP2qvuztpSuGEGmOUqt2j64ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YYe7GXYL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-747dd44048cso250180b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 14:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749677790; x=1750282590; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7K1mqWB732JikqOweFoR2E3lczFj+uEntOhDuHKFp5M=;
        b=YYe7GXYLGSGBb5YjLiL3irKtydOhkgnNL+QH80xAiH/VFOv1oae6gCcefDjKzkxGgM
         cu9lmmi0ijmTGx7n3pOwfiZvPzHwqTPRg0/+AI2LePHJ7pBUSzETecZqGjlISEspRU/e
         i/nmsSoSYyGOMXHfW6cJXZcBGNcAPY41BDMKhqazrcw/iEtKXJ3/pA9gGX7PbYNUuY4P
         dibnb2upeUKcGz6QllCUXceJGZ0m5ToacyPQp5f7CITt+mwcCKUEJtGcqTJ0mvpEroFy
         vTVX1T7UAD0qec84EpB+4oElLzrjmUEk5XtJRxLjhu424sjKpnDBGFsh+44FISWxU6Qv
         5LJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749677790; x=1750282590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7K1mqWB732JikqOweFoR2E3lczFj+uEntOhDuHKFp5M=;
        b=sh9H8xfD5jFG593bgHIjr3qMgcUGr0NXFfcsKp4M0xCUSLLf/nmJ1OMtZpayH+rtKW
         kMsFNkKVSspy+dvXX6KnCJEcV67kOSRQmWFjBjxaiFsNJxJKiKBCc4f7TYT+0Tz3XH0b
         kyiw79tFls9ue+IiXT0yNxvVDvCkzufYCfeU9zB6/MNEPjisXYzywSh5mB/iJoO0NhQU
         jd5OFDTmmvsn/FBLZ8g/f+xNI4QqjKt/WM28pgqcA8tEEPQ/x5uEsIJcmpqUYibhKeXW
         P6Sk7KY3GSKIFb2KO/P+2G5fIVvvoDNCIjtfE6t1GrB7lZXLQvhSHu2RcYY+HxsWqkF9
         oNRw==
X-Forwarded-Encrypted: i=1; AJvYcCUdyNSCsA4GfGlVqtdXpWBn/5oVKd42mzF+m4/1DqUFIL6wnTPMxQb0f4YGX0snFVtdyu/lV/l7tRgCtrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkAc8B0v1wS1v5aSzBya+H1jKlirI5/l3D5nnBsFOpJG3KqPKn
	yzb1JPtgRrNjWS/0Asrq/SxqF9mAcqqKHTzw6jUZ8ROERoSzDurEbrBc1r3kJo3Ui3cnKuDqYcV
	XaqDQng==
X-Google-Smtp-Source: AGHT+IF0AJp5zjM7O+4DgfrWlRKKJZ+9D1xF1XIaVW6Enm2otYNjDmEPFy0oaFaD5MAoVWU9l7pbSr8txmA=
X-Received: from pfxx12.prod.google.com ([2002:a05:6a00:10c:b0:746:fd4c:1fcf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3925:b0:748:323f:ba21
 with SMTP id d2e1a72fcca58-7487bfe8a14mr1415018b3a.1.1749677790486; Wed, 11
 Jun 2025 14:36:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 14:35:56 -0700
In-Reply-To: <20250611213557.294358-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611213557.294358-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611213557.294358-18-seanjc@google.com>
Subject: [PATCH v2 17/18] KVM: x86: Move IRQ mask notifier infrastructure to
 I/O APIC emulation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move the IRQ mask logic to ioapic.c as KVM's only user is its in-kernel
I/O APIC emulation.  In addition to encapsulating more I/O APIC specific
code, trimming down irq_comm.c helps pave the way for removing it entirely.

Acked-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 16 --------------
 arch/x86/kvm/i8254.h            |  2 ++
 arch/x86/kvm/i8259.c            |  2 ++
 arch/x86/kvm/ioapic.c           | 37 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/ioapic.h           | 16 ++++++++++++++
 arch/x86/kvm/irq_comm.c         | 33 -----------------------------
 arch/x86/kvm/x86.c              |  1 -
 7 files changed, 57 insertions(+), 50 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f5ff5174674c..21ccb122ab76 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1426,9 +1426,6 @@ struct kvm_arch {
 	struct delayed_work kvmclock_update_work;
 	struct delayed_work kvmclock_sync_work;
 
-	/* reads protected by irq_srcu, writes by irq_lock */
-	struct hlist_head mask_notifier_list;
-
 #ifdef CONFIG_KVM_HYPERV
 	struct kvm_hv hyperv;
 #endif
@@ -2038,19 +2035,6 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
 int emulator_write_phys(struct kvm_vcpu *vcpu, gpa_t gpa,
 			  const void *val, int bytes);
 
-struct kvm_irq_mask_notifier {
-	void (*func)(struct kvm_irq_mask_notifier *kimn, bool masked);
-	int irq;
-	struct hlist_node link;
-};
-
-void kvm_register_irq_mask_notifier(struct kvm *kvm, int irq,
-				    struct kvm_irq_mask_notifier *kimn);
-void kvm_unregister_irq_mask_notifier(struct kvm *kvm, int irq,
-				      struct kvm_irq_mask_notifier *kimn);
-void kvm_fire_mask_notifiers(struct kvm *kvm, unsigned irqchip, unsigned pin,
-			     bool mask);
-
 extern bool tdp_enabled;
 
 u64 vcpu_tsc_khz(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/i8254.h b/arch/x86/kvm/i8254.h
index e8bd59ad8a7c..60fa499d2f8a 100644
--- a/arch/x86/kvm/i8254.h
+++ b/arch/x86/kvm/i8254.h
@@ -8,6 +8,8 @@
 
 #include <uapi/asm/kvm.h>
 
+#include "ioapic.h"
+
 #ifdef CONFIG_KVM_IOAPIC
 struct kvm_kpit_channel_state {
 	u32 count; /* can be 65536 */
diff --git a/arch/x86/kvm/i8259.c b/arch/x86/kvm/i8259.c
index 4de055efc4ee..2ac7f1678c46 100644
--- a/arch/x86/kvm/i8259.c
+++ b/arch/x86/kvm/i8259.c
@@ -31,6 +31,8 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
+
+#include "ioapic.h"
 #include "irq.h"
 
 #include <linux/kvm_host.h>
diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index fa7481814bc6..2b5d389bca5f 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -310,6 +310,42 @@ void kvm_arch_post_irq_ack_notifier_list_update(struct kvm *kvm)
 	kvm_make_scan_ioapic_request(kvm);
 }
 
+void kvm_register_irq_mask_notifier(struct kvm *kvm, int irq,
+				    struct kvm_irq_mask_notifier *kimn)
+{
+	struct kvm_ioapic *ioapic = kvm->arch.vioapic;
+
+	mutex_lock(&kvm->irq_lock);
+	kimn->irq = irq;
+	hlist_add_head_rcu(&kimn->link, &ioapic->mask_notifier_list);
+	mutex_unlock(&kvm->irq_lock);
+}
+
+void kvm_unregister_irq_mask_notifier(struct kvm *kvm, int irq,
+				      struct kvm_irq_mask_notifier *kimn)
+{
+	mutex_lock(&kvm->irq_lock);
+	hlist_del_rcu(&kimn->link);
+	mutex_unlock(&kvm->irq_lock);
+	synchronize_srcu(&kvm->irq_srcu);
+}
+
+void kvm_fire_mask_notifiers(struct kvm *kvm, unsigned irqchip, unsigned pin,
+			     bool mask)
+{
+	struct kvm_ioapic *ioapic = kvm->arch.vioapic;
+	struct kvm_irq_mask_notifier *kimn;
+	int idx, gsi;
+
+	idx = srcu_read_lock(&kvm->irq_srcu);
+	gsi = kvm_irq_map_chip_pin(kvm, irqchip, pin);
+	if (gsi != -1)
+		hlist_for_each_entry_rcu(kimn, &ioapic->mask_notifier_list, link)
+			if (kimn->irq == gsi)
+				kimn->func(kimn, mask);
+	srcu_read_unlock(&kvm->irq_srcu, idx);
+}
+
 static void ioapic_write_indirect(struct kvm_ioapic *ioapic, u32 val)
 {
 	unsigned index;
@@ -710,6 +746,7 @@ int kvm_ioapic_init(struct kvm *kvm)
 		return -ENOMEM;
 	spin_lock_init(&ioapic->lock);
 	INIT_DELAYED_WORK(&ioapic->eoi_inject, kvm_ioapic_eoi_inject_work);
+	INIT_HLIST_HEAD(&ioapic->mask_notifier_list);
 	kvm->arch.vioapic = ioapic;
 	kvm_ioapic_reset(ioapic);
 	kvm_iodevice_init(&ioapic->dev, &ioapic_mmio_ops);
diff --git a/arch/x86/kvm/ioapic.h b/arch/x86/kvm/ioapic.h
index dc92bd7c37bc..bf28dbc11ff6 100644
--- a/arch/x86/kvm/ioapic.h
+++ b/arch/x86/kvm/ioapic.h
@@ -86,8 +86,24 @@ struct kvm_ioapic {
 	struct delayed_work eoi_inject;
 	u32 irq_eoi[IOAPIC_NUM_PINS];
 	u32 irr_delivered;
+
+	/* reads protected by irq_srcu, writes by irq_lock */
+	struct hlist_head mask_notifier_list;
 };
 
+struct kvm_irq_mask_notifier {
+	void (*func)(struct kvm_irq_mask_notifier *kimn, bool masked);
+	int irq;
+	struct hlist_node link;
+};
+
+void kvm_register_irq_mask_notifier(struct kvm *kvm, int irq,
+				    struct kvm_irq_mask_notifier *kimn);
+void kvm_unregister_irq_mask_notifier(struct kvm *kvm, int irq,
+				      struct kvm_irq_mask_notifier *kimn);
+void kvm_fire_mask_notifiers(struct kvm *kvm, unsigned irqchip, unsigned pin,
+			     bool mask);
+
 #ifdef DEBUG
 #define ASSERT(x)  							\
 do {									\
diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index 14fc8db0206c..76d1c85a1011 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -161,39 +161,6 @@ int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
 	return -EWOULDBLOCK;
 }
 
-void kvm_register_irq_mask_notifier(struct kvm *kvm, int irq,
-				    struct kvm_irq_mask_notifier *kimn)
-{
-	mutex_lock(&kvm->irq_lock);
-	kimn->irq = irq;
-	hlist_add_head_rcu(&kimn->link, &kvm->arch.mask_notifier_list);
-	mutex_unlock(&kvm->irq_lock);
-}
-
-void kvm_unregister_irq_mask_notifier(struct kvm *kvm, int irq,
-				      struct kvm_irq_mask_notifier *kimn)
-{
-	mutex_lock(&kvm->irq_lock);
-	hlist_del_rcu(&kimn->link);
-	mutex_unlock(&kvm->irq_lock);
-	synchronize_srcu(&kvm->irq_srcu);
-}
-
-void kvm_fire_mask_notifiers(struct kvm *kvm, unsigned irqchip, unsigned pin,
-			     bool mask)
-{
-	struct kvm_irq_mask_notifier *kimn;
-	int idx, gsi;
-
-	idx = srcu_read_lock(&kvm->irq_srcu);
-	gsi = kvm_irq_map_chip_pin(kvm, irqchip, pin);
-	if (gsi != -1)
-		hlist_for_each_entry_rcu(kimn, &kvm->arch.mask_notifier_list, link)
-			if (kimn->irq == gsi)
-				kimn->func(kimn, mask);
-	srcu_read_unlock(&kvm->irq_srcu, idx);
-}
-
 bool kvm_arch_can_set_irq_routing(struct kvm *kvm)
 {
 	return irqchip_in_kernel(kvm);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a39babc32a6a..28a20f0aa3dd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12676,7 +12676,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (ret)
 		goto out_uninit_mmu;
 
-	INIT_HLIST_HEAD(&kvm->arch.mask_notifier_list);
 	atomic_set(&kvm->arch.noncoherent_dma_count, 0);
 
 	raw_spin_lock_init(&kvm->arch.tsc_write_lock);
-- 
2.50.0.rc1.591.g9c95f17f64-goog


