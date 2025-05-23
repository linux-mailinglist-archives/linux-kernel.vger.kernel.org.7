Return-Path: <linux-kernel+bounces-660107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B49FEAC192C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 03:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2049E1672
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 01:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B343625E450;
	Fri, 23 May 2025 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y1lRMV0w"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276A825178E
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962038; cv=none; b=fJgE5KyMRNkyrmLc8AXL2GLMkf5MNoYCEXqzFgPZ7nwdc2EshgxFr5DjdADB3szoc5PvGlY14pCLRQWm5DhrmXaPJTqpOEfggsszt3eb35qvZCN0NRj1EVlgQGIFxf+RPDtvM24nGPws7SLrGTwiLKxT5zWip+ETLT8BS4c4m40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962038; c=relaxed/simple;
	bh=RZFsW6qFlraESQBEs5rfLtFloxBZh5YHOEXcImlGM/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rDPcHh8qr1ZWs2+V9j4OKzWLuApkX01wlvIFlww3Wq9ltycrtOeD13iPuKwAhOT4GHkbsBlu9XiBDTQTyA1n+3M+s8ouaqhlTy8fck4P27sWyFuZP5Mic7Zq3ahyL0wRkzBWDIBhe3lMecQ+F4XGsXtEhoSTVkpX4KHXS7qqdsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y1lRMV0w; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b1ffc678adfso5532446a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 18:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962036; x=1748566836; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=v7+beRxhk1Z6lswHDIGdsgi9gbmmpiHmcppYR2/XJao=;
        b=y1lRMV0wIdofWmN43Giu8RQVwV/vFxmWxDeqHDeco7XWiWtJVwtuAH59BFrXLtv5TI
         EcjeoslE/HLAsorriSHG6DiMxSDHkQcsirub944teYBtI06YswbOmFo70mFAfuolQd6w
         wi0/t3Er5N1wmEkVBmm6cPNeE1rHqZ7avVVOOCIYpGi2dHr0M6gtlqm0gf+wfUiF+COo
         M1I/8iTFiQWCmHwlaNv/ZqZarZv0XNKA0SwSLED0mYtAIE6+m2cMB9GMXerx1DdJOTie
         Vz/oRoSzOsyNGQjPbFqg6ejZ9s8a/JE8CzERScgAvoEjiXxw1fWHzO2oILbfzc3+lGqt
         HHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962036; x=1748566836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7+beRxhk1Z6lswHDIGdsgi9gbmmpiHmcppYR2/XJao=;
        b=YRiEIADIJU4GHbW+qFQZ9BLW61ebz7iq+IMPGZLErGNqc2AC3KCjJXsjj40A/6qqpx
         wyFukrhAqfcSht02mHyXiSYdm35TpUdyIGMiDVFxY/rBUBMkvscK6hg9+jtt8XaxjBqc
         6lX6mfdrGMHd1rcS4ClwdqCd9GUznXIs7UwTw/ltScG7JXpGhPJPcR5ZU5YdzlycIxOx
         reU/Dw5i1zaKkDP9tPJcE6pge+YUMEGJTb4w2ecu9hdxSihE63tcVxyYXx3kiewzDqF7
         KA3QLMCkMTFmZhisGo3MLzMqRz5HjeSbV+DGW/mKKxFImIDGiUKlj35+RllfQ+zhoxy8
         Ki2g==
X-Forwarded-Encrypted: i=1; AJvYcCXPtXNHRwCmYvwCsGqZLbYA78ibBqd//oz0YYaM9j6Jdn0+r3JwiVPJ1PaWC+ZeyWWUvmnSqyDtdFuvWFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcugZeQfVpQN2BkpoxJy3b1/sMUybJso6htBj/ThbRu3fkylIQ
	rG7jFL4yWU6HUDreuCPe2iHBctQvOxE3kNvUESm9OxtM1t0JN4T0dW5rY5JrpliJgh6t4QL3oVz
	TszJkYw==
X-Google-Smtp-Source: AGHT+IGN4WqjP5AS34icJap3ZKQQtP5FF3Ggc2KLquv6lW3PDaM97SY0/Y7I+AQ0F4GmpynVDAdw2DfaNtI=
X-Received: from pjbsi6.prod.google.com ([2002:a17:90b:5286:b0:2fc:1158:9fe5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d2ce:b0:30a:29be:8fe1
 with SMTP id 98e67ed59e1d1-30e7d5212b9mr43135285a91.9.1747962036484; Thu, 22
 May 2025 18:00:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:20 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-16-seanjc@google.com>
Subject: [PATCH v2 15/59] KVM: SVM: Add enable_ipiv param, never set IsRunning
 if disabled
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Maxim Levitsky <mlevitsk@redhat.com>

Let userspace "disable" IPI virtualization for AVIC via the enable_ipiv
module param, by never setting IsRunning.  SVM doesn't provide a way to
disable IPI virtualization in hardware, but by ensuring CPUs never see
IsRunning=1, every IPI in the guest (except for self-IPIs) will generate a
VM-Exit.

To avoid setting the real IsRunning bit, while still allowing KVM to use
each vCPU's entry to update GA log entries, simply maintain a shadow of
the entry, without propagating IsRunning updates to the real table when
IPI virtualization is disabled.

Providing a way to effectively disable IPI virtualization will allow KVM
to safely enable AVIC on hardware that is susceptible to erratum #1235,
which causes hardware to sometimes fail to detect that the IsRunning bit
has been cleared by software.

Note, the table _must_ be fully populated, as broadcast IPIs skip invalid
entries, i.e. won't generate VM-Exit if every entry is invalid, and so
simply pointing the VMCB at a common dummy table won't work.

Alternatively, KVM could allocate a shadow of the entire table, but that'd
be a waste of 4KiB since the per-vCPU entry doesn't actually consume an
additional 8 bytes of memory (vCPU structures are large enough that they
are backed by order-N pages).

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
[sean: keep "entry" variables, reuse enable_ipiv, split from erratum]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 32 ++++++++++++++++++++++++++------
 arch/x86/kvm/svm/svm.c  |  2 ++
 arch/x86/kvm/svm/svm.h  |  8 ++++++++
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 0c0be274d29e..48c737e1200a 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -292,6 +292,13 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	/* Setting AVIC backing page address in the phy APIC ID table */
 	new_entry = avic_get_backing_page_address(svm) |
 		    AVIC_PHYSICAL_ID_ENTRY_VALID_MASK;
+	svm->avic_physical_id_entry = new_entry;
+
+	/*
+	 * Initialize the real table, as vCPUs must have a valid entry in order
+	 * for broadcast IPIs to function correctly (broadcast IPIs ignore
+	 * invalid entries, i.e. aren't guaranteed to generate a VM-Exit).
+	 */
 	WRITE_ONCE(kvm_svm->avic_physical_id_table[id], new_entry);
 
 	return 0;
@@ -769,8 +776,6 @@ static int svm_ir_list_add(struct vcpu_svm *svm,
 			   struct amd_iommu_pi_data *pi)
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
-	struct kvm *kvm = vcpu->kvm;
-	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
 	unsigned long flags;
 	u64 entry;
 
@@ -788,7 +793,7 @@ static int svm_ir_list_add(struct vcpu_svm *svm,
 	 * will update the pCPU info when the vCPU awkened and/or scheduled in.
 	 * See also avic_vcpu_load().
 	 */
-	entry = READ_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id]);
+	entry = svm->avic_physical_id_entry;
 	if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK)
 		amd_iommu_update_ga(entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK,
 				    true, pi->ir_data);
@@ -998,14 +1003,26 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	 */
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
 
-	entry = READ_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id]);
+	entry = svm->avic_physical_id_entry;
 	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
 
 	entry &= ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
 	entry |= (h_physical_id & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK);
 	entry |= AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
 
+	svm->avic_physical_id_entry = entry;
+
+	/*
+	 * If IPI virtualization is disabled, clear IsRunning when updating the
+	 * actual Physical ID table, so that the CPU never sees IsRunning=1.
+	 * Keep the APIC ID up-to-date in the entry to minimize the chances of
+	 * things going sideways if hardware peeks at the ID.
+	 */
+	if (!enable_ipiv)
+		entry &= ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
+
 	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
+
 	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, true);
 
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
@@ -1030,7 +1047,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 	 * can't be scheduled out and thus avic_vcpu_{put,load}() can't run
 	 * recursively.
 	 */
-	entry = READ_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id]);
+	entry = svm->avic_physical_id_entry;
 
 	/* Nothing to do if IsRunning == '0' due to vCPU blocking. */
 	if (!(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK))
@@ -1049,7 +1066,10 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 	avic_update_iommu_vcpu_affinity(vcpu, -1, 0);
 
 	entry &= ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
-	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
+	svm->avic_physical_id_entry = entry;
+
+	if (enable_ipiv)
+		WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0ad1a6d4fb6d..56d11f7b4bef 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -231,6 +231,7 @@ module_param(tsc_scaling, int, 0444);
  */
 static bool avic;
 module_param(avic, bool, 0444);
+module_param(enable_ipiv, bool, 0444);
 
 module_param(enable_device_posted_irqs, bool, 0444);
 
@@ -5594,6 +5595,7 @@ static __init int svm_hardware_setup(void)
 	enable_apicv = avic = avic && avic_hardware_setup();
 
 	if (!enable_apicv) {
+		enable_ipiv = false;
 		svm_x86_ops.vcpu_blocking = NULL;
 		svm_x86_ops.vcpu_unblocking = NULL;
 		svm_x86_ops.vcpu_get_apicv_inhibit_reasons = NULL;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index f225d0bed152..939ff0e35a2b 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -307,6 +307,14 @@ struct vcpu_svm {
 	u32 ldr_reg;
 	u32 dfr_reg;
 
+	/* This is essentially a shadow of the vCPU's actual entry in the
+	 * Physical ID table that is programmed into the VMCB, i.e. that is
+	 * seen by the CPU.  If IPI virtualization is disabled, IsRunning is
+	 * only ever set in the shadow, i.e. is never propagated to the "real"
+	 * table, so that hardware never sees IsRunning=1.
+	 */
+	u64 avic_physical_id_entry;
+
 	/*
 	 * Per-vCPU list of irqfds that are eligible to post IRQs directly to
 	 * the vCPU (a.k.a. device posted IRQs, a.k.a. IRQ bypass).  The list
-- 
2.49.0.1151.ga128411c76-goog


