Return-Path: <linux-kernel+bounces-589294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D921A7C45C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 21:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAA217DFB9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 19:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFF0229B2C;
	Fri,  4 Apr 2025 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fDmLFnyb"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027EB22836C
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795626; cv=none; b=Qy8PQQWwkAkaPLux0nn4M75Au5z4sesPygHonydJ7aw7WLEXrq7vsKRLTNY121W/QiE4S5+esBmznJQV1EdfDAKz77Et/pIXK1R3KD+nUcyhRGtByBvjsNWAeC1QIl/Qk2yTO2KSxH2HREE0KDEILRFBcUw17+nTsbgFezXB7sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795626; c=relaxed/simple;
	bh=5pXZ3KhcB5o+xbYbyX54m7GfflzbLKKvgK9HfTcDpYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FkboOYmzH9z5IZuHnUKNkCleY8i50ol87+g5F3f9z0bHskg1BKG9/d58PTkBA6pr4e27g+PswWz9G1Aq0LieiQpIc1QNAlrXg/Jy/eXEYUb8qZEqiKLNOg+HunNa32Nubt6SrGAoPWMI91o2dMjtC7XM4katU7JnM703fHxYa78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fDmLFnyb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff62f96b10so3673391a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Apr 2025 12:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795623; x=1744400423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0B7t2SIwhqflBHejHEDsNeeI2B/K5AMETQZXAxeeglw=;
        b=fDmLFnyb9Uni0x9nQAewF0eP68Oy3fZawvq2BR4YfbPO2p0x8Y9CZIOVpOhxs+u4YX
         CjFH4Bsjye7/O3Tb9y7pOqHw7OBbKYdPM9vfSkSK3Pt0i1L5izYcEVRL5ZaNenccrbrE
         qotfm5VOUSR1HzJYAXOmuxerXsyz37UUFwEI7Eegq7+aZJGXU1htXgXKatkaK7fPFKZ3
         VY9syC+5kkI811tLmMO9DZJPZ5XIin2rU5kk+03bySbR9bZ17SR5ZHNxBKW0QXl9i0oE
         jR31YhNxaU1wwRwdMYk0mWIfv7qb2j8QSoa9uRXhm4kypZldzpShFkKXKUguFMDvTBgH
         Vcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795623; x=1744400423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0B7t2SIwhqflBHejHEDsNeeI2B/K5AMETQZXAxeeglw=;
        b=CnSv37ybOD6371nEjNTax4Lyxl8ECyZf8RIXjSMnO5Ae8wVddAwaM6s/VKES1flUMh
         RhkNH5iv7/we1fW3tk541+/qOl2hPkxSRHt2jignmUgSqnyoPDm6LUgV6GHcOd/jcqH4
         +48XbfGWKE6Pr0not9t+y5XzN2WBVE5Qungj4bdeNX1jnZHuznOliVyeMd5nYMR0KMhh
         u6PqiUVV9KjU0MQ5HwLPzzhJDxs5o0wJV7yLV+zojJIfAnlk65FcSsn3AAd51zXAadZM
         7ms6obvq9TQraeRRaaNUbNGiAJqAgxd42UbBcKlWVhbYVrof0PBzYi9L6oD0QjoDpfF9
         0zhw==
X-Forwarded-Encrypted: i=1; AJvYcCUqKGKJdhWoPJB9wdjbMaLd34tlNNENhJYeQzaZw0P2lauvpYbLKuPiiVRmtnpF81nbYuHpAfzR3T3VgWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/8/hVNAcDTwFuEeszCdJYgxTVB4GDTzOpEvzTzug73jqxwCaT
	oWTfzIOi9G1wtAsn9g2SFldMeuUwtFdKCjIZAQQE8fx7RvlS4OtwS2eoZhH93t9gB4Q8S3L7FVg
	llQ==
X-Google-Smtp-Source: AGHT+IE/kINVfoZrJ4qY9CHehtr/vzhchg2tVy6B+yeCOOea3l97XGuuqzOWftR5UeAUcXh68E3v1s4JzR8=
X-Received: from pfbbe17.prod.google.com ([2002:a05:6a00:1f11:b0:730:9951:c9ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5387:b0:2fa:3b6b:3370
 with SMTP id 98e67ed59e1d1-3057a68c61amr11505416a91.16.1743795623377; Fri, 04
 Apr 2025 12:40:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:36 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-22-seanjc@google.com>
Subject: [PATCH 21/67] KVM: SVM: Add enable_ipiv param, never set IsRunning if disabled
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
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
 arch/x86/kvm/svm/svm.h  |  9 +++++++++
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index c4e6c97b736f..eea362cd415d 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -301,6 +301,13 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
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
@@ -778,8 +785,6 @@ static int svm_ir_list_add(struct vcpu_svm *svm,
 			   struct amd_iommu_pi_data *pi)
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
-	struct kvm *kvm = vcpu->kvm;
-	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
 	unsigned long flags;
 	u64 entry;
 
@@ -797,7 +802,7 @@ static int svm_ir_list_add(struct vcpu_svm *svm,
 	 * will update the pCPU info when the vCPU awkened and/or scheduled in.
 	 * See also avic_vcpu_load().
 	 */
-	entry = READ_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id]);
+	entry = svm->avic_physical_id_entry;
 	if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK)
 		amd_iommu_update_ga(entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK,
 				    true, pi->ir_data);
@@ -1010,14 +1015,26 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
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
@@ -1042,7 +1059,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 	 * can't be scheduled out and thus avic_vcpu_{put,load}() can't run
 	 * recursively.
 	 */
-	entry = READ_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id]);
+	entry = svm->avic_physical_id_entry;
 
 	/* Nothing to do if IsRunning == '0' due to vCPU blocking. */
 	if (!(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK))
@@ -1061,7 +1078,10 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 	avic_update_iommu_vcpu_affinity(vcpu, -1, 0);
 
 	entry &= ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
-	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
+	svm->avic_physical_id_entry = entry;
+
+	if (enable_ipiv)
+		WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index def76e63562d..43c4933d7da6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -230,6 +230,7 @@ module_param(tsc_scaling, int, 0444);
  */
 static bool avic;
 module_param(avic, bool, 0444);
+module_param(enable_ipiv, bool, 0444);
 
 module_param(enable_device_posted_irqs, bool, 0444);
 
@@ -5440,6 +5441,7 @@ static __init int svm_hardware_setup(void)
 	enable_apicv = avic = avic && avic_hardware_setup();
 
 	if (!enable_apicv) {
+		enable_ipiv = false;
 		svm_x86_ops.vcpu_blocking = NULL;
 		svm_x86_ops.vcpu_unblocking = NULL;
 		svm_x86_ops.vcpu_get_apicv_inhibit_reasons = NULL;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e223e57f7def..6ad0aa86f78d 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -302,6 +302,15 @@ struct vcpu_svm {
 	u32 ldr_reg;
 	u32 dfr_reg;
 
+	/*
+	 * This is essentially a shadow of the vCPU's actual entry in the
+	 * Physical ID table that is programmed into the VMCB, i.e. that is
+	 * seen by the CPU.  If IPI virtualization is disabled, IsRunning is
+	 * only ever set in the shadow, i.e. is never propagated to the "real"
+	 * table, so that hardware never sees IsRunning=1.
+	 */
+	u64 avic_physical_id_entry;
+
 	/*
 	 * Per-vcpu list of struct amd_svm_iommu_ir:
 	 * This is used mainly to store interrupt remapping information used
-- 
2.49.0.504.g3bcea36a83-goog


