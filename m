Return-Path: <linux-kernel+bounces-682675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FAFAD633A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 00:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE32F3A0849
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 22:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393CC28C87E;
	Wed, 11 Jun 2025 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x8XbHCi0"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694452DECA0
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682068; cv=none; b=S4WtBLoxZVof31/zQx5n4a+dKUASz2iBlcKgzylnk34S9Q60l08wDg93rU/VI2oLYTNoVXLDAIUDZ7pZ0zMOtrulKkePzsXuQVbqYtidFjaaCUL1E+7lGSvCN9vcnt/8NyV8rOndWzaJtMLlllBaKCjCq4DIX/TpDyomMmW1LEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682068; c=relaxed/simple;
	bh=EocGUl+znQ6+GySTsc5tfeFokKH4lMkbBdgnP/hNSw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IRp5mDoiNt8713OQbHKmJ9ufMrH3cIc/eAn8upiGkM+EMXYhH1hhzH3Bbny7KPe3hRN/mTFiO8Stzng9pFGrZhZHqnOE/eyGL5JoRfQR7piPlOzKCoRsRoNThJl0jjiIOP+aAvtRJr6xbfxgoaYAFQs2oqUURpkU+j4B/tPaWNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x8XbHCi0; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74299055c3dso487879b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 15:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682065; x=1750286865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MiX1cBSlPb3QAMFRj3O20TU/yzydIFIDo71+8w5lo7I=;
        b=x8XbHCi0bw14RMRU29u9CNgqgDyHWiGfGIe1/bwPAI5dcQyn/0IldpMsKK2Var9Bdd
         RFj+Q3mdkF3i+1aeQs8Pfpi2aslDa+y9JzmyxdS4hjZIKLVhuW+6s1N0dDF820wDHLxc
         ipgxvGzHK6x7swKEq52JlAPEnoV/2T22/FiY8L+3xtKqMp6q7QGHhnOaUkD+lN6tGEod
         PrgY2RCwMkANyyqasskNnMEAoFWBGXq+g3ERGxFJW74/jOfElhvRcJY1MUTPDwUUH755
         vZKma3GZs2zZqmqJT6ekeqempOBwMY8bzMcFF66JiuqMuZHYTViBdRDF5rZ7jRRhScZc
         eGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682065; x=1750286865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MiX1cBSlPb3QAMFRj3O20TU/yzydIFIDo71+8w5lo7I=;
        b=oTrGqSj8ev6pSf7+srRps1vIwXpagzWji8EjOlmgKm4ipNhtwSjfcOy2Cijx0qYXQu
         i3PxKt9TWhBhxd3aFf3WF321UsLm7x/ZtJJaTr9HCO9ZuLz7r+uioIB6AD+NjJOzDNbc
         vOUURL7Kif17uTfbXiYgtlMrZFHPDsbfm4fpiBZ3SMSpx90IVCxLwxbvuXmilIZpM6Z/
         bKvGAQeH4p/xuhvLMkziqv8FLIA7xesna8nMrrnLUiOQ9gQl7ai7o4mYBs1KB+RrsPO2
         hNBPOaXrZSw5iSx9aeCkEYFAuTQJvKL1mTwkPbGH+jg2AqcTUfc80N3xhuzwFzFTgrci
         Su1w==
X-Forwarded-Encrypted: i=1; AJvYcCUjH+e6+xIXp6mhS8IMMn+d9g+kOGZxgPxGzwRwz0uEW6GafWgymzNNytpMVcd8XKaPX4VS4nTIkR8mk+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/wmA/MGWLvuU0ok4f9ISAJf2U0iIyaOnfqPfcnED+si7baKiq
	0USchRCIS1mQjWXjBngOhC79IT36NuMOTP+fIN4wJ1kcW3b+CWIbcLrttm8OH2ZAv4tuAHFT7vr
	9wQ7+GA==
X-Google-Smtp-Source: AGHT+IHF9HHczJkxI6npdpQx+RAXhNVPsiYt0OqNmwwcKys/CyATwjqiplFRMGOAVQl4fRFJJoPj5M5Pf18=
X-Received: from pfbha15.prod.google.com ([2002:a05:6a00:850f:b0:747:b682:5cc0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:181c:b0:742:9bd3:238a
 with SMTP id d2e1a72fcca58-7486cb71821mr6183459b3a.4.1749682065649; Wed, 11
 Jun 2025 15:47:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:32 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-31-seanjc@google.com>
Subject: [PATCH v3 29/62] KVM: x86: Move posted interrupt tracepoint to common code
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Move the pi_irte_update tracepoint to common x86, and call it whenever the
IRTE is modified.  Tracing only the modifications that result in an IRQ
being posted to a vCPU makes the tracepoint useless for debugging.

Drop the vendor specific address; plumbing that into common code isn't
worth the trouble, as the address is meaningless without a whole pile of
other information that isn't provided in any tracepoint.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/irq.c             | 12 ++++++++++--
 arch/x86/kvm/svm/avic.c        |  6 ------
 arch/x86/kvm/trace.h           | 19 +++++++------------
 arch/x86/kvm/vmx/posted_intr.c |  3 ---
 arch/x86/kvm/x86.c             |  1 -
 5 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 5948aba9fdc0..ec13d1d7706d 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -511,9 +511,11 @@ void kvm_arch_irq_routing_update(struct kvm *kvm)
 static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 			      struct kvm_kernel_irq_routing_entry *entry)
 {
+	unsigned int host_irq = irqfd->producer->irq;
 	struct kvm *kvm = irqfd->kvm;
 	struct kvm_vcpu *vcpu = NULL;
 	struct kvm_lapic_irq irq;
+	int r;
 
 	if (!irqchip_in_kernel(kvm) ||
 	    !kvm_arch_has_irq_bypass() ||
@@ -540,8 +542,13 @@ static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 			vcpu = NULL;
 	}
 
-	return kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, irqfd->producer->irq,
-					    irqfd->gsi, vcpu, irq.vector);
+	r = kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, host_irq, irqfd->gsi,
+					 vcpu, irq.vector);
+	if (r)
+		return r;
+
+	trace_kvm_pi_irte_update(host_irq, vcpu, irqfd->gsi, irq.vector, !!vcpu);
+	return 0;
 }
 
 int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
@@ -595,6 +602,7 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 
 	spin_unlock_irq(&kvm->irqfds.lock);
 
+
 	kvm_arch_end_assignment(irqfd->kvm);
 }
 
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 14a1544af192..d8d50b8f14bb 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -815,9 +815,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	 */
 	svm_ir_list_del(irqfd);
 
-	pr_debug("SVM: %s: host_irq=%#x, guest_irq=%#x, set=%#x\n",
-		 __func__, host_irq, guest_irq, !!vcpu);
-
 	/**
 	 * Here, we setup with legacy mode in the following cases:
 	 * 1. When cannot target interrupt to a specific vcpu.
@@ -853,9 +850,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
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
index ababdba2c186..57d79fd31df0 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -1176,37 +1176,32 @@ TRACE_EVENT(kvm_smm_transition,
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
index 3de767c5d6b2..687ffde3b61c 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -308,9 +308,6 @@ int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			.vector = vector,
 		};
 
-		trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id, guest_irq,
-					 vcpu_info.vector, vcpu_info.pi_desc_addr, true);
-
 		return irq_set_vcpu_affinity(host_irq, &vcpu_info);
 	} else {
 		return irq_set_vcpu_affinity(host_irq, NULL);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5ba5e28532de..d3571c484790 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13891,7 +13891,6 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_nested_intercepts);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_write_tsc_offset);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_ple_window_update);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_pml_full);
-EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_pi_irte_update);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_avic_unaccelerated_access);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_avic_incomplete_ipi);
 EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_avic_ga_log);
-- 
2.50.0.rc1.591.g9c95f17f64-goog


