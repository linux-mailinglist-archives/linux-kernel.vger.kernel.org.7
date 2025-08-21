Return-Path: <linux-kernel+bounces-780680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42443B307F2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0417E1D40A06
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D307D2D3ECD;
	Thu, 21 Aug 2025 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OiNY8cWg"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F7D2C0297
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810058; cv=none; b=fRh2kSIu2o9mLPXN/uA1t4T+cNkgUpUxQXHY5MX5s5SgJrV56DH9cn/wV/uzUbPiz8WoFNOSZzys68d94fJtvJvVzewbuliCugEWiEwF4DbqralAmVd0ezrORj6Hq5N8KvEY5+nH3hFrGu5renMtXHyjlXSmpUZEFJoVhk/X7nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810058; c=relaxed/simple;
	bh=Y+ltfZALifuJ1zLKcXiJdcTMewn8FXFncz1GJqx929M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZhEatdtnelrAXIxHW4rPcTTKOkFVuZsGQzeDrVoSEDaHeL+Qh/9ubfh6DgDP4Ia5Pi0yTNBHA20flZCv6cuIMvTYLJfjla6u/MLpWwjJGy9ximl1CoWNvYK9fXUVhZ7rN/LOv5mGnwGW9CtZLvsFHDQjzY1T4Cqvnyy2Ab1ESjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OiNY8cWg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-245fb4c8789so18068565ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755810054; x=1756414854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+0mq+aZ8FiVuglcge/zbddfw9AWlhCmxeevWfZs8Ufk=;
        b=OiNY8cWghqtXOuGEiSBXZ57VyUN5Lurv6938mNmDZonOgfABhNOcaqiRtKELWChW+k
         zrwylhRXKYb0wxAAWF/C3yCKxwavLl8OQ9icUWdQGQyw7zdm6lj1wRhcxM8BLPsHAAVC
         Ct1bJyZk8HvzPg34IuyqDIxVysIWxcHHpoJiygYuiuC/0HuKj8xgtDnvj6A1FHu4oYtP
         RDn77d1yaWf9RAxge1d7tWY+0hWjEH/z7TSxoT+PtLsKwOdytr5XLcO7vUb7elV/hYeD
         h6mRmbyVrix8MxoKkBsIOSt4LkYOwsGxx8oyVFOcjiH/Yfsl3CLF+bVSvEYbRmRNZKNs
         DNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755810054; x=1756414854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0mq+aZ8FiVuglcge/zbddfw9AWlhCmxeevWfZs8Ufk=;
        b=j0l0y7AD0oh//Va9iyufai3Z/u/I2FOGDPNgeaSh8KQ4MKSbDfF/oeHrF6jcBAC0YY
         csF1iMtbkwzIeK88LQjw8UpGRDpblm0p7qtvkcJQKotRwup9mmeX2BI3VxLMJ76kN4c1
         EFncWoZZjCTPNYy6irz10OqDmu/vrGcR95n0zny3+xU8AJlhUcdo4LSSKAczjFaeyix3
         V7546okfYXPwhI0NDs0EvoNi3tRG9jOytthIyaBAq8tPI8QtJRYzE8rCrALkbOCkcS6X
         6vu/zSk3NUTysgv+93bcN/zf7UXlyPCi7vZkHTiEKM1a9OiTQY5NNZQjvBQdK7niyrAE
         w4Og==
X-Forwarded-Encrypted: i=1; AJvYcCWMI8BfR8FLJSn68LygpmGCfGSy+PxLiaVv3ZXNxJ9WXYehBxAm0+mhvmP/49r2Lbh8yG26tFxLWOGMCFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoaXlgb7StwXDo4HyIv+3Uskw6CUsnxL9kkpQ9fnIj3Q6W/KtY
	gcFgg3Vqds5BlnhfQYIT3axAftUN9MPpqnWTupDSQn1zZkU7AhdwDdYSLuPTKYkidaVZvmVe/Uv
	QMWnnBg==
X-Google-Smtp-Source: AGHT+IGtL8cs3Nlow7DOdUj6noypYWB7mEAPGYg2neHXfT0CwVRf3Tt3Ig6UudknxiqaomdBF2z+yZTd9eo=
X-Received: from plcx18.prod.google.com ([2002:a17:903:d2:b0:23f:df55:cf6f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2c5:b0:246:570:2d91
 with SMTP id d9443c01a7336-2462efcb0bemr7750285ad.61.1755810054013; Thu, 21
 Aug 2025 14:00:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 21 Aug 2025 14:00:31 -0700
In-Reply-To: <20250821210042.3451147-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821210042.3451147-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821210042.3451147-6-seanjc@google.com>
Subject: [RFC PATCH 05/16] KVM: arm64: Introduce "struct kvm_page_fault" for
 tracking abort state
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Add and use a kvm_page_fault structure to track state when handling a
guest abort.  Collecting everything in a single structure will enable a
variety of cleanups (reduce the number of params passed to helpers), and
will pave the way toward using "struct kvm_page_fault" in arch-neutral KVM
code, e.g. to consolidate logic for KVM_EXIT_MEMORY_FAULT.

No functional change intended.

Cc: James Houghton <jthoughton@google.com>
Link: https://lore.kernel.org/all/20250618042424.330664-1-jthoughton@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  18 ++++
 arch/arm64/kvm/mmu.c              | 143 ++++++++++++++----------------
 2 files changed, 87 insertions(+), 74 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 2f2394cce24e..4623cbc1edf4 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -413,6 +413,24 @@ struct kvm_vcpu_fault_info {
 	u64 disr_el1;		/* Deferred [SError] Status Register */
 };
 
+struct kvm_page_fault {
+	const u64 esr;
+	const bool exec;
+	const bool write;
+	const bool is_perm;
+
+	phys_addr_t fault_ipa; /* The address we faulted on */
+	phys_addr_t ipa; /* Always the IPA in the L1 guest phys space */
+
+	struct kvm_s2_trans *nested;
+
+	gfn_t gfn;
+	struct kvm_memory_slot *slot;
+	unsigned long hva;
+	kvm_pfn_t pfn;
+	struct page *page;
+};
+
 /*
  * VNCR() just places the VNCR_capable registers in the enum after
  * __VNCR_START__, and the value (after correction) to be an 8-byte offset
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 49ce6bf623f7..ca98778989b2 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1477,38 +1477,29 @@ static bool kvm_vma_is_cacheable(struct vm_area_struct *vma)
 	}
 }
 
-static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
-			  struct kvm_s2_trans *nested,
-			  struct kvm_memory_slot *memslot, unsigned long hva,
-			  bool fault_is_perm)
+static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	int ret = 0;
-	bool write_fault, writable, force_pte = false;
-	bool exec_fault, mte_allowed, is_vma_cacheable;
+	bool writable, force_pte = false;
+	bool mte_allowed, is_vma_cacheable;
 	bool s2_force_noncacheable = false, vfio_allow_any_uc = false;
 	unsigned long mmu_seq;
-	phys_addr_t ipa = fault_ipa;
 	struct kvm *kvm = vcpu->kvm;
 	struct vm_area_struct *vma;
 	short vma_shift;
 	void *memcache;
-	gfn_t gfn;
-	kvm_pfn_t pfn;
-	bool logging_active = memslot_is_logging(memslot);
+	bool logging_active = memslot_is_logging(fault->slot);
 	long vma_pagesize, fault_granule;
 	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
 	struct kvm_pgtable *pgt;
-	struct page *page;
 	vm_flags_t vm_flags;
 	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_HANDLE_FAULT | KVM_PGTABLE_WALK_SHARED;
 
-	if (fault_is_perm)
+	if (fault->is_perm)
 		fault_granule = kvm_vcpu_trap_get_perm_fault_granule(vcpu);
-	write_fault = kvm_is_write_fault(vcpu);
-	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
-	VM_BUG_ON(write_fault && exec_fault);
+	VM_BUG_ON(fault->write && fault->exec);
 
-	if (fault_is_perm && !write_fault && !exec_fault) {
+	if (fault->is_perm && !fault->write && !fault->exec) {
 		kvm_err("Unexpected L2 read permission error\n");
 		return -EFAULT;
 	}
@@ -1524,7 +1515,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * only exception to this is when dirty logging is enabled at runtime
 	 * and a write fault needs to collapse a block entry into a table.
 	 */
-	if (!fault_is_perm || (logging_active && write_fault)) {
+	if (!fault->is_perm || (logging_active && fault->write)) {
 		int min_pages = kvm_mmu_cache_min_pages(vcpu->arch.hw_mmu);
 
 		if (!is_protected_kvm_enabled())
@@ -1541,9 +1532,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * get block mapping for device MMIO region.
 	 */
 	mmap_read_lock(current->mm);
-	vma = vma_lookup(current->mm, hva);
+	vma = vma_lookup(current->mm, fault->hva);
 	if (unlikely(!vma)) {
-		kvm_err("Failed to find VMA for hva 0x%lx\n", hva);
+		kvm_err("Failed to find VMA for hva 0x%lx\n", fault->hva);
 		mmap_read_unlock(current->mm);
 		return -EFAULT;
 	}
@@ -1556,13 +1547,13 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		force_pte = true;
 		vma_shift = PAGE_SHIFT;
 	} else {
-		vma_shift = get_vma_page_shift(vma, hva);
+		vma_shift = get_vma_page_shift(vma, fault->hva);
 	}
 
 	switch (vma_shift) {
 #ifndef __PAGETABLE_PMD_FOLDED
 	case PUD_SHIFT:
-		if (fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
+		if (fault_supports_stage2_huge_mapping(fault->slot, fault->hva, PUD_SIZE))
 			break;
 		fallthrough;
 #endif
@@ -1570,7 +1561,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		vma_shift = PMD_SHIFT;
 		fallthrough;
 	case PMD_SHIFT:
-		if (fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE))
+		if (fault_supports_stage2_huge_mapping(fault->slot, fault->hva, PMD_SIZE))
 			break;
 		fallthrough;
 	case CONT_PTE_SHIFT:
@@ -1585,19 +1576,19 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 
 	vma_pagesize = 1UL << vma_shift;
 
-	if (nested) {
+	if (fault->nested) {
 		unsigned long max_map_size;
 
 		max_map_size = force_pte ? PAGE_SIZE : PUD_SIZE;
 
-		ipa = kvm_s2_trans_output(nested);
+		WARN_ON_ONCE(fault->ipa != kvm_s2_trans_output(fault->nested));
 
 		/*
 		 * If we're about to create a shadow stage 2 entry, then we
 		 * can only create a block mapping if the guest stage 2 page
 		 * table uses at least as big a mapping.
 		 */
-		max_map_size = min(kvm_s2_trans_size(nested), max_map_size);
+		max_map_size = min(kvm_s2_trans_size(fault->nested), max_map_size);
 
 		/*
 		 * Be careful that if the mapping size falls between
@@ -1618,11 +1609,11 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * place.
 	 */
 	if (vma_pagesize == PMD_SIZE || vma_pagesize == PUD_SIZE) {
-		fault_ipa &= ~(vma_pagesize - 1);
-		ipa &= ~(vma_pagesize - 1);
+		fault->fault_ipa &= ~(vma_pagesize - 1);
+		fault->ipa &= ~(vma_pagesize - 1);
 	}
 
-	gfn = ipa >> PAGE_SHIFT;
+	fault->gfn = fault->ipa >> PAGE_SHIFT;
 	mte_allowed = kvm_vma_mte_allowed(vma);
 
 	vfio_allow_any_uc = vma->vm_flags & VM_ALLOW_ANY_UNCACHED;
@@ -1645,20 +1636,21 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	mmu_seq = vcpu->kvm->mmu_invalidate_seq;
 	mmap_read_unlock(current->mm);
 
-	pfn = __kvm_faultin_pfn(memslot, gfn, write_fault ? FOLL_WRITE : 0,
-				&writable, &page);
-	if (pfn == KVM_PFN_ERR_HWPOISON) {
-		kvm_send_hwpoison_signal(hva, vma_shift);
+	fault->pfn = __kvm_faultin_pfn(fault->slot, fault->gfn,
+				       fault->write ? FOLL_WRITE : 0,
+				       &writable, &fault->page);
+	if (fault->pfn == KVM_PFN_ERR_HWPOISON) {
+		kvm_send_hwpoison_signal(fault->hva, vma_shift);
 		return 0;
 	}
-	if (is_error_noslot_pfn(pfn))
+	if (is_error_noslot_pfn(fault->pfn))
 		return -EFAULT;
 
 	/*
 	 * Check if this is non-struct page memory PFN, and cannot support
 	 * CMOs. It could potentially be unsafe to access as cachable.
 	 */
-	if (vm_flags & (VM_PFNMAP | VM_MIXEDMAP) && !pfn_is_map_memory(pfn)) {
+	if (vm_flags & (VM_PFNMAP | VM_MIXEDMAP) && !pfn_is_map_memory(fault->pfn)) {
 		if (is_vma_cacheable) {
 			/*
 			 * Whilst the VMA owner expects cacheable mapping to this
@@ -1687,7 +1679,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			 */
 			s2_force_noncacheable = true;
 		}
-	} else if (logging_active && !write_fault) {
+	} else if (logging_active && !fault->write) {
 		/*
 		 * Only actually map the page as writable if this was a write
 		 * fault.
@@ -1695,7 +1687,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		writable = false;
 	}
 
-	if (exec_fault && s2_force_noncacheable)
+	if (fault->exec && s2_force_noncacheable)
 		return -ENOEXEC;
 
 	/*
@@ -1709,12 +1701,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * used to limit the invalidation scope if a TTL hint or a range
 	 * isn't provided.
 	 */
-	if (nested) {
-		writable &= kvm_s2_trans_writable(nested);
-		if (!kvm_s2_trans_readable(nested))
+	if (fault->nested) {
+		writable &= kvm_s2_trans_writable(fault->nested);
+		if (!kvm_s2_trans_readable(fault->nested))
 			prot &= ~KVM_PGTABLE_PROT_R;
 
-		prot |= kvm_encode_nested_level(nested);
+		prot |= kvm_encode_nested_level(fault->nested);
 	}
 
 	kvm_fault_lock(kvm);
@@ -1729,12 +1721,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * backed by a THP and thus use block mapping if possible.
 	 */
 	if (vma_pagesize == PAGE_SIZE && !(force_pte || s2_force_noncacheable)) {
-		if (fault_is_perm && fault_granule > PAGE_SIZE)
+		if (fault->is_perm && fault_granule > PAGE_SIZE)
 			vma_pagesize = fault_granule;
 		else
-			vma_pagesize = transparent_hugepage_adjust(kvm, memslot,
-								   hva, &pfn,
-								   &fault_ipa);
+			vma_pagesize = transparent_hugepage_adjust(kvm, fault->slot,
+								   fault->hva, &fault->pfn,
+								   &fault->fault_ipa);
 
 		if (vma_pagesize < 0) {
 			ret = vma_pagesize;
@@ -1742,10 +1734,10 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		}
 	}
 
-	if (!fault_is_perm && !s2_force_noncacheable && kvm_has_mte(kvm)) {
+	if (!fault->is_perm && !s2_force_noncacheable && kvm_has_mte(kvm)) {
 		/* Check the VMM hasn't introduced a new disallowed VMA */
 		if (mte_allowed) {
-			sanitise_mte_tags(kvm, pfn, vma_pagesize);
+			sanitise_mte_tags(kvm, fault->pfn, vma_pagesize);
 		} else {
 			ret = -EFAULT;
 			goto out_unlock;
@@ -1755,7 +1747,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (writable)
 		prot |= KVM_PGTABLE_PROT_W;
 
-	if (exec_fault)
+	if (fault->exec)
 		prot |= KVM_PGTABLE_PROT_X;
 
 	if (s2_force_noncacheable) {
@@ -1764,7 +1756,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		else
 			prot |= KVM_PGTABLE_PROT_DEVICE;
 	} else if (cpus_have_final_cap(ARM64_HAS_CACHE_DIC) &&
-		   (!nested || kvm_s2_trans_executable(nested))) {
+		   (!fault->nested || kvm_s2_trans_executable(fault->nested))) {
 		prot |= KVM_PGTABLE_PROT_X;
 	}
 
@@ -1773,26 +1765,26 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * permissions only if vma_pagesize equals fault_granule. Otherwise,
 	 * kvm_pgtable_stage2_map() should be called to change block size.
 	 */
-	if (fault_is_perm && vma_pagesize == fault_granule) {
+	if (fault->is_perm && vma_pagesize == fault_granule) {
 		/*
 		 * Drop the SW bits in favour of those stored in the
 		 * PTE, which will be preserved.
 		 */
 		prot &= ~KVM_NV_GUEST_MAP_SZ;
-		ret = KVM_PGT_FN(kvm_pgtable_stage2_relax_perms)(pgt, fault_ipa, prot, flags);
+		ret = KVM_PGT_FN(kvm_pgtable_stage2_relax_perms)(pgt, fault->fault_ipa, prot, flags);
 	} else {
-		ret = KVM_PGT_FN(kvm_pgtable_stage2_map)(pgt, fault_ipa, vma_pagesize,
-					     __pfn_to_phys(pfn), prot,
+		ret = KVM_PGT_FN(kvm_pgtable_stage2_map)(pgt, fault->fault_ipa, vma_pagesize,
+					     __pfn_to_phys(fault->pfn), prot,
 					     memcache, flags);
 	}
 
 out_unlock:
-	kvm_release_faultin_page(kvm, page, !!ret, writable);
+	kvm_release_faultin_page(kvm, fault->page, !!ret, writable);
 	kvm_fault_unlock(kvm);
 
 	/* Mark the page dirty only if the fault is handled successfully */
 	if (writable && !ret)
-		mark_page_dirty_in_slot(kvm, memslot, gfn);
+		mark_page_dirty_in_slot(kvm, fault->slot, fault->gfn);
 
 	return ret != -EAGAIN ? ret : 0;
 }
@@ -1814,12 +1806,17 @@ static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 static int __kvm_handle_guest_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 				    unsigned long esr)
 {
-	struct kvm_s2_trans nested_trans, *nested = NULL;
-	struct kvm_memory_slot *memslot;
-	bool write_fault, writable;
-	unsigned long hva;
-	phys_addr_t ipa; /* Always the IPA in the L1 guest phys space */
-	gfn_t gfn;
+	struct kvm_page_fault fault = {
+		.fault_ipa = fault_ipa,
+		.esr = esr,
+		.ipa = fault_ipa,
+
+		.write = kvm_is_write_fault(vcpu),
+		.exec  = kvm_vcpu_trap_is_exec_fault(vcpu),
+		.is_perm = esr_fsc_is_permission_fault(esr),
+	};
+	struct kvm_s2_trans nested_trans;
+	bool writable;
 	int ret;
 
 	/*
@@ -1849,15 +1846,14 @@ static int __kvm_handle_guest_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa
 			return ret;
 		}
 
-		ipa = kvm_s2_trans_output(&nested_trans);
-		nested = &nested_trans;
+		fault.ipa = kvm_s2_trans_output(&nested_trans);
+		fault.nested = &nested_trans;
 	}
 
-	gfn = ipa >> PAGE_SHIFT;
-	memslot = gfn_to_memslot(vcpu->kvm, gfn);
-	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
-	write_fault = kvm_is_write_fault(vcpu);
-	if (kvm_is_error_hva(hva) || (write_fault && !writable)) {
+	fault.gfn = fault.ipa >> PAGE_SHIFT;
+	fault.slot = gfn_to_memslot(vcpu->kvm, fault.gfn);
+	fault.hva = gfn_to_hva_memslot_prot(fault.slot, fault.gfn, &writable);
+	if (kvm_is_error_hva(fault.hva) || (fault.write && !writable)) {
 		/*
 		 * The guest has put either its instructions or its page-tables
 		 * somewhere it shouldn't have. Userspace won't be able to do
@@ -1882,7 +1878,7 @@ static int __kvm_handle_guest_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa
 		 * So let's assume that the guest is just being
 		 * cautious, and skip the instruction.
 		 */
-		if (kvm_is_error_hva(hva) && kvm_vcpu_dabt_is_cm(vcpu)) {
+		if (kvm_is_error_hva(fault.hva) && kvm_vcpu_dabt_is_cm(vcpu)) {
 			kvm_incr_pc(vcpu);
 			return 1;
 		}
@@ -1893,20 +1889,19 @@ static int __kvm_handle_guest_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa
 		 * faulting VA. This is always 12 bits, irrespective
 		 * of the page size.
 		 */
-		ipa |= kvm_vcpu_get_hfar(vcpu) & GENMASK(11, 0);
-		return io_mem_abort(vcpu, ipa);
+		fault.ipa |= kvm_vcpu_get_hfar(vcpu) & GENMASK(11, 0);
+		return io_mem_abort(vcpu, fault.ipa);
 	}
 
 	/* Userspace should not be able to register out-of-bounds IPAs */
-	VM_BUG_ON(ipa >= kvm_phys_size(vcpu->arch.hw_mmu));
+	VM_BUG_ON(fault.ipa >= kvm_phys_size(vcpu->arch.hw_mmu));
 
 	if (esr_fsc_is_access_flag_fault(esr)) {
-		handle_access_fault(vcpu, fault_ipa);
+		handle_access_fault(vcpu, fault.fault_ipa);
 		return 1;
 	}
 
-	ret = user_mem_abort(vcpu, fault_ipa, nested, memslot, hva,
-			     esr_fsc_is_permission_fault(esr));
+	ret = user_mem_abort(vcpu, &fault);
 	if (ret == 0)
 		ret = 1;
 out:
-- 
2.51.0.261.g7ce5a0a67e-goog


