Return-Path: <linux-kernel+bounces-682704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC93AD6382
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 01:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DCA23ACB48
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 23:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C324A273806;
	Wed, 11 Jun 2025 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3+rDFCFB"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAF024EAAF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 22:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682119; cv=none; b=FQ6v9+kcnrEX/3j19r9xHwSS4xuS1jH7Z9ez38O/dDhyRYb7f0FmfbU5lr8+92nAh7elb3zAzWn/XTDQ9+DWEJr5LtyFkVJ3j0LVX2H12fHRaOK9vxhLKw10iff5OyhspESjR7/xfbfFFZw6cHKU2wfMvHhPtrUG9bWv5i6Zv8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682119; c=relaxed/simple;
	bh=WeRv3qsDDbsHqZ7Lj+dTG4f6h8cg/1Q7VSdMcR5QYHw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o3kZlLlLl0C+xDw299Az1d/Q8O4z2IWBINfHPP/sTIbOPdY/Gq69c3sD6Wk8dho0HnxpKjS9K/MrIJ/tBrwMpPcTLN34DmokDaMGkTB2+ZXL6/FPXwkaI1uU6GixBKnp4WTVnZ7AhQvMwM+CtCQ1B6eoQkG94PW+BUsEdXTogwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3+rDFCFB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23536f7c2d7so4091165ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 15:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682116; x=1750286916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FezZVwAIX27yOhkNPTycKKVEi5uWL2iUiKq6QlVZHOU=;
        b=3+rDFCFBlO7sz0yr/31P7d1hwm+BLbSvJQR8SDesbcnLonGISGn41YzNf95H+yCfK0
         UCxSUdvuYgrvqTbvATa7Ju79oNCLP9u6u4tlrRKxIOw9JbTIqM2ZABnsupLJHi/vjNeJ
         7wZ3OsAxicxC+NGpZrbfKtSyjfuq35R6ozXVvqFZbwMoGjMjonZXODBsX9Yat87AK0K9
         k0zwoaTqazPfsRuvH8HIIsf9TclCuOdZ+lJoHl2iVv2+XZj2Dg9vCvPBa8zCXLfiXu1F
         u6Lz7TZahdd34d+1s8eUdqa/UULinAwqR+EWMeezhfBG3aooc3DZBWk+br/EJCFn+n3c
         fP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682116; x=1750286916;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FezZVwAIX27yOhkNPTycKKVEi5uWL2iUiKq6QlVZHOU=;
        b=bnUevLj1PnZ9bPeE0meIpwuVFlcjNqlarHOT85pkT371tc+dn3qn5AkgcQXVkKrGCR
         WvGkccUmk2N8IGsouQ9netGWmkvDPJYR3s7Z/mWbk4fdodGvAcOGB56KlZI+6I+7XTw4
         ohlZHDZx6gJPAwkKqIP5vBgauugJMu8+ndYJWeCEnfiGwYniPgekDIbrqQdwc2+HwgIH
         Ta/fGEKI7lnEwTD0NeJGTD5LeoEU3/LAC+RzuGg6VlkHjZWXExxKagwWIL9NKJeELR88
         4Y2wyAIo9f4dfqfFRAJv82KUrqXrufU+bsVmGvNS4/h/93tAwtZ2+NkUxHqp6KeJvZDM
         dilA==
X-Forwarded-Encrypted: i=1; AJvYcCXhlhUt/QEZpQnVit/hjaFjpJB4HVyzQGuRxcLH2/t+GPdNBwB/sMwzS8DDlSPmtsb3/iDZQPb95Lqll3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvH/xnjYMgR4g6FfpCcjdAufonP0+2T3OfRLYs743gYTZYsSHF
	fygLLH8UGH9LnHmlZk/ShFK/Fdc48m6iSY40vpaQV7lBWYLRKlMNDhC/zqSBUvOTeZTH19/pojg
	tAlWhmA==
X-Google-Smtp-Source: AGHT+IE0mnhzPmaGDjcFYBs1HKY/3aqg20RLoeGBLv7o8irQVmRVOs75AEwPqXs1TaFQwm4uFyelNA0uq7s=
X-Received: from pjbsg18.prod.google.com ([2002:a17:90b:5212:b0:311:ff32:a85d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4acb:b0:313:28f1:fc33
 with SMTP id 98e67ed59e1d1-313c06872aemr1120199a91.10.1749682116501; Wed, 11
 Jun 2025 15:48:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:46:01 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-60-seanjc@google.com>
Subject: [PATCH v3 58/62] KVM: SVM: Don't check vCPU's blocking status when
 toggling AVIC on/off
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

Don't query a vCPU's blocking status when toggling AVIC on/off; barring
KVM bugs, the vCPU can't be blocking when refreshing AVIC controls.  And
if there are KVM bugs, ensuring the vCPU and its associated IRTEs are in
the correct state is desirable, i.e. well worth any overhead in a buggy
scenario.

Isolating the "real" load/put flows will allow moving the IOMMU IRTE
(de)activation logic from avic_refresh_apicv_exec_ctrl() to
avic_update_iommu_vcpu_affinity(), i.e. will allow updating the vCPU's
physical ID entry and its IRTEs in a common path, under a single critical
section of ir_list_lock.

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 65 +++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 9ddec6f3ad41..1e6e5d1f6b4e 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -828,7 +828,7 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu)
 		WARN_ON_ONCE(amd_iommu_update_ga(cpu, irqfd->irq_bypass_data));
 }
 
-void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
 	int h_physical_id = kvm_cpu_get_apicid(cpu);
@@ -844,16 +844,6 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (WARN_ON_ONCE(vcpu->vcpu_id * sizeof(entry) >= PAGE_SIZE))
 		return;
 
-	/*
-	 * No need to update anything if the vCPU is blocking, i.e. if the vCPU
-	 * is being scheduled in after being preempted.  The CPU entries in the
-	 * Physical APIC table and IRTE are consumed iff IsRun{ning} is '1'.
-	 * If the vCPU was migrated, its new CPU value will be stuffed when the
-	 * vCPU unblocks.
-	 */
-	if (kvm_vcpu_is_blocking(vcpu))
-		return;
-
 	/*
 	 * Grab the per-vCPU interrupt remapping lock even if the VM doesn't
 	 * _currently_ have assigned devices, as that can change.  Holding
@@ -888,31 +878,33 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
 
-void avic_vcpu_put(struct kvm_vcpu *vcpu)
+void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+{
+	/*
+	 * No need to update anything if the vCPU is blocking, i.e. if the vCPU
+	 * is being scheduled in after being preempted.  The CPU entries in the
+	 * Physical APIC table and IRTE are consumed iff IsRun{ning} is '1'.
+	 * If the vCPU was migrated, its new CPU value will be stuffed when the
+	 * vCPU unblocks.
+	 */
+	if (kvm_vcpu_is_blocking(vcpu))
+		return;
+
+	__avic_vcpu_load(vcpu, cpu);
+}
+
+static void __avic_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
 	struct vcpu_svm *svm = to_svm(vcpu);
 	unsigned long flags;
-	u64 entry;
+	u64 entry = svm->avic_physical_id_entry;
 
 	lockdep_assert_preemption_disabled();
 
 	if (WARN_ON_ONCE(vcpu->vcpu_id * sizeof(entry) >= PAGE_SIZE))
 		return;
 
-	/*
-	 * Note, reading the Physical ID entry outside of ir_list_lock is safe
-	 * as only the pCPU that has loaded (or is loading) the vCPU is allowed
-	 * to modify the entry, and preemption is disabled.  I.e. the vCPU
-	 * can't be scheduled out and thus avic_vcpu_{put,load}() can't run
-	 * recursively.
-	 */
-	entry = svm->avic_physical_id_entry;
-
-	/* Nothing to do if IsRunning == '0' due to vCPU blocking. */
-	if (!(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK))
-		return;
-
 	/*
 	 * Take and hold the per-vCPU interrupt remapping lock while updating
 	 * the Physical ID entry even though the lock doesn't protect against
@@ -932,7 +924,24 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 		WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
+}
 
+void avic_vcpu_put(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Note, reading the Physical ID entry outside of ir_list_lock is safe
+	 * as only the pCPU that has loaded (or is loading) the vCPU is allowed
+	 * to modify the entry, and preemption is disabled.  I.e. the vCPU
+	 * can't be scheduled out and thus avic_vcpu_{put,load}() can't run
+	 * recursively.
+	 */
+	u64 entry = to_svm(vcpu)->avic_physical_id_entry;
+
+	/* Nothing to do if IsRunning == '0' due to vCPU blocking. */
+	if (!(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK))
+		return;
+
+	__avic_vcpu_put(vcpu);
 }
 
 void avic_refresh_virtual_apic_mode(struct kvm_vcpu *vcpu)
@@ -973,9 +982,9 @@ void avic_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 	avic_refresh_virtual_apic_mode(vcpu);
 
 	if (activated)
-		avic_vcpu_load(vcpu, vcpu->cpu);
+		__avic_vcpu_load(vcpu, vcpu->cpu);
 	else
-		avic_vcpu_put(vcpu);
+		__avic_vcpu_put(vcpu);
 
 	/*
 	 * Here, we go through the per-vcpu ir_list to update all existing
-- 
2.50.0.rc1.591.g9c95f17f64-goog


