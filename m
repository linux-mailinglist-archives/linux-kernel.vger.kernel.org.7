Return-Path: <linux-kernel+bounces-589307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27774A7C459
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 21:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5286B3BC971
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 19:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E802F22E40E;
	Fri,  4 Apr 2025 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CiJ/bJcR"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5758922DFA9
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795648; cv=none; b=KNTHhAGvPd7YNW5X9ie9/mcF71nZh2usjlz9gRTkbchNIa6v5EbdYewrXqzEstzNOqtaeEqDYfyItMj+iIawK1Mvuh0S7euCAdgGNDsUboiszbxrpptmcZQRFvelPG6Ey8uRZgjAk1o4FoclCHin2kZPQo4wHPP3DgSP1RFO78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795648; c=relaxed/simple;
	bh=S1IQCpBa9erCP4/lm9a+T/slv15e6a/B9F7tRfkzXTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pip+PwwKMjZRsV3LiF33y3sdZDXY4XEdR7UGuIhrMvKnwlywwFZQctJl6ehzydiGMmvAyHRjcNo+kuDohcWC/wupPZ6glbwnsHFFF7DLQ2wkeV8wASHE0pxVG8+nIQ5w9CGMaLgJY6s2yL1Zf2PwP3LTgVgQW5YIYcy7HHHpo4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CiJ/bJcR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7394792f83cso1891189b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Apr 2025 12:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795646; x=1744400446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uaVpxlbnDgtNQ9eArDqZS6RnH4UAPqkG1v5XnP6kRe0=;
        b=CiJ/bJcRDGfhiMp8nRs17hBZl77Hnzs9FB3jdyAVsfJmhIodgAfvt+b1dg53t2DOux
         SQ7Dp4OXeVssclGWIDlz9gAec09GWcDzw+/LRgXMT3bVf0MNy5JkuQY/UrdwcBqRgYRz
         z2SWr5rZBzoVoWObigTimfkpDTM47u33SzasjmwkMyeicwvjwmiUVKhEdX96g97ikPMg
         Tbwx0v16Z1KSLFg2EEvm7YZB7+ov2UbHJvqV3iPJ+yXMOyvmtdsOTPLRxgpn+c6zDC0O
         MqyfGCaIZR9wdw035d10GY/+WD25cjIqcQlJ3evh7Mmak6FGbz6lyIoZ30/ujBZaTgbA
         pchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795646; x=1744400446;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uaVpxlbnDgtNQ9eArDqZS6RnH4UAPqkG1v5XnP6kRe0=;
        b=dVIs6fB+AMHGVLE6T8veTMRAnehTFhQKSsRvGd//AS1St8cNv3w471mQfR00mAlXHE
         VtiUnUKcrQZxyYdKU44Viv+Jpz2hVTImzoN3JRBbVA6kQSwaGrJ9RTzg67ArkQ2xQHqY
         6h5r8IjYzxZkShQopQcWJMjrn1rZnOEgk9p4jBtNOpArokyhI4/tcGE7IbIBXLylO3J1
         wlv4j0yYXbJwgPr1IkCKyxznoUHTcxW7O8mUkACsUdHanGP7RUG0uFtKL4cv0wGPOUWm
         tjg2ZSaeeETOXgom12IAEkipTugyb8vi/CFiiX/BICmqD7qb5LivZsOzy/3DllD0yb7Y
         7GIg==
X-Forwarded-Encrypted: i=1; AJvYcCUxWiVc76tC4wC5OhNANx/AvVrx2cAT+jbKuIfG35jhNBw3VVBigAQaHiQNH0/n+w92wVgwEiU7f4DSSk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCCfFgzK4MIjyqG5jKkGL0Dgwindtnf6RmyYnzAYwh6HtQcbv4
	Kz9icdbUG0ZTEUP4Q+SavOcMgI56MsFHaWIDmnDFhGWPSJUTx1pp7MlUDAmQ7FQCySk4+yr7GAe
	E0g==
X-Google-Smtp-Source: AGHT+IEaPgjswzlO8HHW+mHK05gIj6Syjqlu81aOJEReqz978dEgQfNJanfgf5aiklETS63POvgyQk3Fmxw=
X-Received: from pfhh19.prod.google.com ([2002:a05:6a00:2313:b0:736:ab5f:21f4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2289:b0:736:755b:8317
 with SMTP id d2e1a72fcca58-73b6b8f8f45mr861882b3a.21.1743795645870; Fri, 04
 Apr 2025 12:40:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:49 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-35-seanjc@google.com>
Subject: [PATCH 34/67] KVM: x86: Move posted interrupt tracepoint to common code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Move the pi_irte_update tracepoint to common x86, and call it whenever the
IRTE is modified.  Tracing only the modifications that result in an IRQ
being posted to a vCPU makes the tracepoint useless for debugging.

Drop the vendor specific address; plumbing that into common code isn't
worth the trouble, as the address is meaningless without a whole pile of
other information that isn't provided in any tracepoint.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c        |  6 ------
 arch/x86/kvm/trace.h           | 19 +++++++------------
 arch/x86/kvm/vmx/posted_intr.c |  3 ---
 arch/x86/kvm/x86.c             | 12 +++++++++---
 4 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 666f518340a7..dcfe908f5b98 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -825,9 +825,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	 */
 	svm_ir_list_del(irqfd);
 
-	pr_debug("SVM: %s: host_irq=%#x, guest_irq=%#x, set=%#x\n",
-		 __func__, host_irq, guest_irq, !!vcpu);
-
 	/**
 	 * Here, we setup with legacy mode in the following cases:
 	 * 1. When cannot target interrupt to a specific vcpu.
@@ -863,9 +860,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 */
 		if (!ret)
 			ret = svm_ir_list_add(to_svm(vcpu), irqfd, &pi);
-
-		trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id, guest_irq,
-					 vector, vcpu_info.pi_desc_addr, true);
 	} else {
 		ret = irq_set_vcpu_affinity(host_irq, NULL);
 	}
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index ccda95e53f62..be4f55c23ec7 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -1089,37 +1089,32 @@ TRACE_EVENT(kvm_smm_transition,
  * Tracepoint for VT-d posted-interrupts and AMD-Vi Guest Virtual APIC.
  */
 TRACE_EVENT(kvm_pi_irte_update,
-	TP_PROTO(unsigned int host_irq, unsigned int vcpu_id,
-		 unsigned int gsi, unsigned int gvec,
-		 u64 pi_desc_addr, bool set),
-	TP_ARGS(host_irq, vcpu_id, gsi, gvec, pi_desc_addr, set),
+	TP_PROTO(unsigned int host_irq, struct kvm_vcpu *vcpu,
+		 unsigned int gsi, unsigned int gvec, bool set),
+	TP_ARGS(host_irq, vcpu, gsi, gvec, set),
 
 	TP_STRUCT__entry(
 		__field(	unsigned int,	host_irq	)
-		__field(	unsigned int,	vcpu_id		)
+		__field(	int,		vcpu_id		)
 		__field(	unsigned int,	gsi		)
 		__field(	unsigned int,	gvec		)
-		__field(	u64,		pi_desc_addr	)
 		__field(	bool,		set		)
 	),
 
 	TP_fast_assign(
 		__entry->host_irq	= host_irq;
-		__entry->vcpu_id	= vcpu_id;
+		__entry->vcpu_id	= vcpu ? vcpu->vcpu_id : -1;
 		__entry->gsi		= gsi;
 		__entry->gvec		= gvec;
-		__entry->pi_desc_addr	= pi_desc_addr;
 		__entry->set		= set;
 	),
 
-	TP_printk("PI is %s for irq %u, vcpu %u, gsi: 0x%x, "
-		  "gvec: 0x%x, pi_desc_addr: 0x%llx",
+	TP_printk("PI is %s for irq %u, vcpu %d, gsi: 0x%x, gvec: 0x%x",
 		  __entry->set ? "enabled and being updated" : "disabled",
 		  __entry->host_irq,
 		  __entry->vcpu_id,
 		  __entry->gsi,
-		  __entry->gvec,
-		  __entry->pi_desc_addr)
+		  __entry->gvec)
 );
 
 /*
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index fd5f6a125614..baf627839498 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -275,9 +275,6 @@ int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			.vector = vector,
 		};
 
-		trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id, guest_irq,
-					 vcpu_info.vector, vcpu_info.pi_desc_addr, true);
-
 		return irq_set_vcpu_affinity(host_irq, &vcpu_info);
 	} else {
 		return irq_set_vcpu_affinity(host_irq, NULL);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0ab818bba743..a20d461718cc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13571,9 +13571,11 @@ static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 			      struct kvm_kernel_irq_routing_entry *old,
 			      struct kvm_kernel_irq_routing_entry *new)
 {
+	unsigned int host_irq = irqfd->producer->irq;
 	struct kvm *kvm = irqfd->kvm;
 	struct kvm_vcpu *vcpu = NULL;
 	struct kvm_lapic_irq irq;
+	int r;
 
 	if (!irqchip_in_kernel(kvm) ||
 	    !kvm_arch_has_irq_bypass() ||
@@ -13600,8 +13602,13 @@ static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 			vcpu = NULL;
 	}
 
-	return kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, irqfd->producer->irq,
-					    irqfd->gsi, new, vcpu, irq.vector);
+	r = kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, host_irq, irqfd->gsi,
+					 new, vcpu, irq.vector);
+	if (r)
+		return r;
+
+	trace_kvm_pi_irte_update(host_irq, vcpu, irqfd->gsi, irq.vector, !!vcpu);
+	return 0;
 }
 
 int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
@@ -14074,7 +14081,6 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_nested_intercepts);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_write_tsc_offset);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_ple_window_update);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_pml_full);
-EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_pi_irte_update);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_avic_unaccelerated_access);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_avic_incomplete_ipi);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_avic_ga_log);
-- 
2.49.0.504.g3bcea36a83-goog


