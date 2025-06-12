Return-Path: <linux-kernel+bounces-682688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0C3AD635B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 01:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396193AE674
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 23:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18D42E92CF;
	Wed, 11 Jun 2025 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jmhdv/WR"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1822E88BB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682091; cv=none; b=BO3V4lBbG4FnvM6xFGiUEYq9KsoNISl1I5IYz+YVOxfdJsnupCgvYIN/wPmzN3fJpo/ixcwOGGEQgQNTewoRIV/Tl76rZ2NmPBXA/e7B+AU6ToYDvQjMa6WYAmpngfifMPZIttGqD1GVsa3IRu9hkt4dJ9sE2F91eTXOmOkNMj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682091; c=relaxed/simple;
	bh=47YFOIh9wmd8i7Mcnx7lh2ptEgbhSWnaBgLRT6hXQw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fuEFDfBRFQ/xptJC4Koowo7euHdOcdU8ob4e5lPw/ZNjc9Lh6bUutxMgr4xee+wQIlG/X9+bZqyAkNtBLnX4T9pyBbhBYPsk5+Ix3dR1+1Lh3fgrbHsR6R61xMmysIIHSLFpP+FE7NW0vL3mc2mvmxw3RTcqXgFaSZAEouGG7/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jmhdv/WR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138f5e8ff5so307392a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 15:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682088; x=1750286888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KS4ZhJjLtMST2qssI3Whk6ZP+LPGaRlWl7UPUSpKiV0=;
        b=Jmhdv/WR5zXoPI4OdLd1oxBozGBl7JxT+VGkYFnKUoZomKwZYw1IzrhX4i7+Y5LK76
         4QpD4g2X9dTSDzu8JndzJ9s+brjMox0ILQfR3D54+fEKY4Q3MwGoriSj+bXmRjmSxkWp
         DzFYjwhs+yXNn1V49GLj8ph7nb8IJaoB6pQljsvk1AuWOeRsuWYS7KgviU+YdzWKwCYv
         a3hQgSng2csLX7lfaTrXsHXbg9uwkgrBpiEgwJtZJNVxprUuN6b/mw07hXfOqI7BV/C4
         Jhe4OSTdW9W6nrj1JSXq7KqJcRjIVDFb4tMVNTmYvE30Ucv6hrjf6IYSQhmTtcqKUYcC
         p27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682088; x=1750286888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KS4ZhJjLtMST2qssI3Whk6ZP+LPGaRlWl7UPUSpKiV0=;
        b=F6vRgS1UkW28Tv8ZPd9YmtA9CjVcKLI3SlU8AGwtqj1lvJe23VfjetJK2/WqtqoSti
         rY3ZbBLAJOQX+baa1Q56mTQeP5OLCKuEVprtZWjBpiL3jyDJvSl8dZXbeNr9WC1oAVwP
         vYhgaGlFEkdKjF/5Shfs8p7LzR81eTfFe9ophqqWN0y9t3NIuybJ/rWboRwsr51sUHEa
         247tcaAjIZcL4uGRjKU9ZznI1dUwoYnpv6hcaxGu7gNVsUFIIFiqbABC0/qKi0cT8sD/
         8z5aQLqA37dPBsAzXPFsa3jj+Zj20oYFO9dphh0AgXZXCOsN3zQJbUP3wyG1BiTjp7Uo
         4UXA==
X-Forwarded-Encrypted: i=1; AJvYcCXm/3PCnhG7oOcz78+sxu5D6SEDtmwSqChdUX/CMnU4S5mZYOv2E6XIlbM6d8RO0CkOPX1yhQuaNMQCT88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxizUNtilnlQHdlefdRy6Jk3u369+Rom8A3xGneJgGWyhFXUOyd
	nCMkEdeAkHAH67ej1x9hTjfJL5sxknWhY8SI7BbzrxB9gKZ9RPnhBN255cBj0lxtIt/1g183X/H
	LUy3S2w==
X-Google-Smtp-Source: AGHT+IGcAIh5/jCgSJHM9OE77+WuxjaqjsMwhH9KH8I+VMHw0eYOG8+vhK4ZHV69lh+B+DZ74wq8ooiPqEg=
X-Received: from pjbqo13.prod.google.com ([2002:a17:90b:3dcd:b0:311:a4ee:7c3d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e4a:b0:312:639:a062
 with SMTP id 98e67ed59e1d1-313bfbf5fcemr1696897a91.16.1749682088364; Wed, 11
 Jun 2025 15:48:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:45 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-44-seanjc@google.com>
Subject: [PATCH v3 42/62] iommu/amd: KVM: SVM: Set pCPU info in IRTE when
 setting vCPU affinity
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

Now that setting vCPU affinity is guarded with ir_list_lock, i.e. now that
avic_physical_id_entry can be safely accessed, set the pCPU info
straight-away when setting vCPU affinity.  Putting the IRTE into posted
mode, and then immediately updating the IRTE a second time if the target
vCPU is running is wasteful and confusing.

This also fixes a flaw where a posted IRQ that arrives between putting
the IRTE into guest_mode and setting the correct destination could cause
the IOMMU to ring the doorbell on the wrong pCPU.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/irq_remapping.h |  1 +
 arch/x86/kvm/svm/avic.c              | 26 ++++++++++++++------------
 drivers/iommu/amd/iommu.c            |  6 ++++--
 include/linux/amd-iommu.h            |  4 ++--
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 2dbc9cb61c2f..4c75a17632f6 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -35,6 +35,7 @@ struct amd_iommu_pi_data {
 	u64 vapic_addr;		/* Physical address of the vCPU's vAPIC. */
 	u32 ga_tag;
 	u32 vector;		/* Guest vector of the interrupt */
+	int cpu;
 	bool is_guest_mode;
 	void *ir_data;
 };
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index c79648d96752..16557328aa58 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -726,6 +726,7 @@ void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu)
 
 static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
 {
+	int apic_id = kvm_cpu_get_apicid(vcpu->cpu);
 	int ret = 0;
 	unsigned long flags;
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -745,7 +746,7 @@ static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
 
 	list_for_each_entry(irqfd, &svm->ir_list, vcpu_list) {
 		if (activate)
-			ret = amd_iommu_activate_guest_mode(irqfd->irq_bypass_data);
+			ret = amd_iommu_activate_guest_mode(irqfd->irq_bypass_data, apic_id);
 		else
 			ret = amd_iommu_deactivate_guest_mode(irqfd->irq_bypass_data);
 		if (ret)
@@ -809,6 +810,18 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 */
 		guard(spinlock_irqsave)(&svm->ir_list_lock);
 
+		/*
+		 * Update the target pCPU for IOMMU doorbells if the vCPU is
+		 * running.  If the vCPU is NOT running, i.e. is blocking or
+		 * scheduled out, KVM will update the pCPU info when the vCPU
+		 * is awakened and/or scheduled in.  See also avic_vcpu_load().
+		 */
+		entry = svm->avic_physical_id_entry;
+		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK)
+			pi_data.cpu = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
+		else
+			pi_data.cpu = -1;
+
 		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
 		if (ret)
 			return ret;
@@ -823,17 +836,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			return -EIO;
 		}
 
-		/*
-		 * Update the target pCPU for IOMMU doorbells if the vCPU is
-		 * running.  If the vCPU is NOT running, i.e. is blocking or
-		 * scheduled out, KVM will update the pCPU info when the vCPU
-		 * is awakened and/or scheduled in.  See also avic_vcpu_load().
-		 */
-		entry = svm->avic_physical_id_entry;
-		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK)
-			amd_iommu_update_ga(entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK,
-					    pi_data.ir_data);
-
 		irqfd->irq_bypass_data = pi_data.ir_data;
 		list_add(&irqfd->vcpu_list, &svm->ir_list);
 		return 0;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 15718b7b8bd4..718bd9604f71 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3850,7 +3850,7 @@ int amd_iommu_update_ga(int cpu, void *data)
 }
 EXPORT_SYMBOL(amd_iommu_update_ga);
 
-int amd_iommu_activate_guest_mode(void *data)
+int amd_iommu_activate_guest_mode(void *data, int cpu)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -3871,6 +3871,8 @@ int amd_iommu_activate_guest_mode(void *data)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
+	__amd_iommu_update_ga(entry, cpu);
+
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry);
 }
@@ -3937,7 +3939,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 		ir_data->ga_root_ptr = (pi_data->vapic_addr >> 12);
 		ir_data->ga_vector = pi_data->vector;
 		ir_data->ga_tag = pi_data->ga_tag;
-		ret = amd_iommu_activate_guest_mode(ir_data);
+		ret = amd_iommu_activate_guest_mode(ir_data, pi_data->cpu);
 	} else {
 		ret = amd_iommu_deactivate_guest_mode(ir_data);
 	}
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index fe0e16ffe0e5..c9f2df0c4596 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -32,7 +32,7 @@ extern int amd_iommu_register_ga_log_notifier(int (*notifier)(u32));
 
 extern int amd_iommu_update_ga(int cpu, void *data);
 
-extern int amd_iommu_activate_guest_mode(void *data);
+extern int amd_iommu_activate_guest_mode(void *data, int cpu);
 extern int amd_iommu_deactivate_guest_mode(void *data);
 
 #else /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
@@ -48,7 +48,7 @@ static inline int amd_iommu_update_ga(int cpu, void *data)
 	return 0;
 }
 
-static inline int amd_iommu_activate_guest_mode(void *data)
+static inline int amd_iommu_activate_guest_mode(void *data, int cpu)
 {
 	return 0;
 }
-- 
2.50.0.rc1.591.g9c95f17f64-goog


