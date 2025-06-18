Return-Path: <linux-kernel+bounces-691265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18988ADE262
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 06:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D0717BFEF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 04:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B1520101D;
	Wed, 18 Jun 2025 04:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwLg6uqP"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA331E503D
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 04:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750220672; cv=none; b=dEySqRAF0mTBMzdimlgBhuEQ+WC0MnJXhGe7xwgDUDfHjX+GgcOCqIRDPdOiUTXuVxXJqXK37bzNKcZ1/8eEq9l79Vb0ezFpC+ZSFcm626419jrd6KiVPH/X9xrPXxk1fTZK89PEMwE7EndPEkKdMURWde7yPxLLbNIMdb+Po3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750220672; c=relaxed/simple;
	bh=jJzFpMIoMXrFEbFfMZHeGhQ7EoGOH6MxXy/6a5t1jZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nR/aTTgQFE2wGtZ+hwboRRMIXWa+WG4I8RBP7iP40SAnvVJDJlJO6DBpfSeUXoY60qhOIJYNcfuD3vSlBwzumgibmqNX+w78OZfaGdPz79J9MxgMXDtFKkRDkEBPxdj/+HcdjhxSbyOuqgP6+cwtKEc+5kYz0LYA6L7HJuU10K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwLg6uqP; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748e1e474f8so1022261b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 21:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750220670; x=1750825470; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JanEUXOf1XWVs3kpYfHVyTXFyH+qIidbAMdFV6akegY=;
        b=MwLg6uqPc6n6F5WmHItpxeOkI4sDtC4MPxdPxfn4A2XQRz5tn3TnCrODYxNvd4GzsV
         ljWhWGQBSg4g1vGOEnybtsItWlNWcNm3/IWM+jp3tekamoxCmISN2+SayyG3xeS3UTsc
         0aM1kRvlaHQvMjEOZtqqxZjSjNuDqqQECgaxnrXp8gIiGerLcSHNqzobW3K80B+Wsoh0
         iT9yUMfZlG7tZEgIBp9OAR/rUUJSX7PL5hzkwgFH3Ym+a6QdZ/42XKbyyupxqQy7mn7R
         caHz5iceJp1EZ9JyJlboZe7glbtF4oVmDZ/xLnDuEsQkE57vspNUADzqyQCWy+0f9F8E
         hQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750220670; x=1750825470;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JanEUXOf1XWVs3kpYfHVyTXFyH+qIidbAMdFV6akegY=;
        b=DYwPfUFDyHWy7g996IGb3yt5AvQK9XN6P82J9BXLQ1M4R5zMudXXlBt5/e7cdLJFwC
         MYaz8OykW9yod7P/02Me66K9S7+xmhFEmy4XxfLBporE1gZHDQipbo4XX9OszzU0+3sF
         wP9LSGkozFIHTKHg8DLsLpoGfssmlthNEpii7WgSsKzH5F1CLJy7gJCs3cACwZbY2JVm
         FVkRC9hCaumxq/wwWiGiRkRanp2gTAScb23jDc61NHE/2pvN4QA5asoI+agRnjuzrziY
         73HoPhC92S+h3Et32SMMozYmZodKLVTFSvBl/hLo+pENjSaCfoqo3+uue8gwOI+uxZfD
         iX6w==
X-Forwarded-Encrypted: i=1; AJvYcCUexDfO276c7K2nkeoyp/DHiL82Te9EmYkxvfWS9Inb6Z5nGSFg+rNATnmC6DnRvbK8D/BcRheS1A1/oX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdkNCCMl5Y2ibS9oUaCImzOfI/zgIPCGCEEZNhG7aDE6phCj+P
	UIi1iFFl7J8dE9Jd1YVi3kl+h4e5tCy9ix5OGo7t/6lt09/rJd08P9KpkE5IDXSo4KZXmdDsJve
	TlGII82iOdiMNLRpjXAU53w==
X-Google-Smtp-Source: AGHT+IGhGlpakj0eJizLYc0gxiQ3hQXVWEsMAv964wrGEVgAjsjBPQA9RJtsv4jH/rvULsmo/zU/Pq4mbBOQ1uSF
X-Received: from pfhp23.prod.google.com ([2002:a05:6a00:a17:b0:746:21fd:3f7a])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3a06:b0:748:e1e4:71d9 with SMTP id d2e1a72fcca58-748e1e475a6mr2959042b3a.22.1750220670239;
 Tue, 17 Jun 2025 21:24:30 -0700 (PDT)
Date: Wed, 18 Jun 2025 04:24:11 +0000
In-Reply-To: <20250618042424.330664-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250618042424.330664-1-jthoughton@google.com>
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250618042424.330664-3-jthoughton@google.com>
Subject: [PATCH v3 02/15] KVM: arm64: Add "struct kvm_page_fault" to gather
 common fault variables
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	James Houghton <jthoughton@google.com>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Anish Moorthy <amoorthy@google.com>, Peter Gonda <pgonda@google.com>, Peter Xu <peterx@redhat.com>, 
	David Matlack <dmatlack@google.com>, wei.w.wang@intel.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Introduce "struct kvm_page_fault" and use it in user_mem_abort() in lieu
of a collection of local variables.  Providing "struct kvm_page_fault"
will allow common KVM to provide APIs to take in said structure, e.g. when
preparing memory fault exits.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  9 +++++++++
 arch/arm64/kvm/mmu.c              | 32 +++++++++++++++++--------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 6ce2c51734820..ae83d95d11b74 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -413,6 +413,15 @@ struct kvm_vcpu_fault_info {
 	u64 disr_el1;		/* Deferred [SError] Status Register */
 };
 
+struct kvm_page_fault {
+	const bool exec;
+	const bool write;
+	const bool is_private;
+
+	gfn_t gfn;
+	struct kvm_memory_slot *slot;
+};
+
 /*
  * VNCR() just places the VNCR_capable registers in the enum after
  * __VNCR_START__, and the value (after correction) to be an 8-byte offset
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 2942ec92c5a4a..0c209f2e1c7b2 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1476,8 +1476,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  bool fault_is_perm)
 {
 	int ret = 0;
-	bool write_fault, writable, force_pte = false;
-	bool exec_fault, mte_allowed;
+	bool writable, force_pte = false;
+	bool mte_allowed;
 	bool device = false, vfio_allow_any_uc = false;
 	unsigned long mmu_seq;
 	phys_addr_t ipa = fault_ipa;
@@ -1485,7 +1485,6 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	struct vm_area_struct *vma;
 	short vma_shift;
 	void *memcache;
-	gfn_t gfn;
 	kvm_pfn_t pfn;
 	bool logging_active = memslot_is_logging(memslot);
 	long vma_pagesize, fault_granule;
@@ -1494,13 +1493,18 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	struct page *page;
 	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_HANDLE_FAULT | KVM_PGTABLE_WALK_SHARED;
 
+	struct kvm_page_fault fault = {
+		.write = kvm_is_write_fault(vcpu),
+		.exec = kvm_vcpu_trap_is_exec_fault(vcpu),
+
+		.slot = memslot,
+	};
+
 	if (fault_is_perm)
 		fault_granule = kvm_vcpu_trap_get_perm_fault_granule(vcpu);
-	write_fault = kvm_is_write_fault(vcpu);
-	exec_fault = kvm_vcpu_trap_is_exec_fault(vcpu);
-	VM_BUG_ON(write_fault && exec_fault);
+	VM_BUG_ON(fault.write && fault.exec);
 
-	if (fault_is_perm && !write_fault && !exec_fault) {
+	if (fault_is_perm && !fault.write && !fault.exec) {
 		kvm_err("Unexpected L2 read permission error\n");
 		return -EFAULT;
 	}
@@ -1516,7 +1520,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * only exception to this is when dirty logging is enabled at runtime
 	 * and a write fault needs to collapse a block entry into a table.
 	 */
-	if (!fault_is_perm || (logging_active && write_fault)) {
+	if (!fault_is_perm || (logging_active && fault.write)) {
 		int min_pages = kvm_mmu_cache_min_pages(vcpu->arch.hw_mmu);
 
 		if (!is_protected_kvm_enabled())
@@ -1614,7 +1618,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		ipa &= ~(vma_pagesize - 1);
 	}
 
-	gfn = ipa >> PAGE_SHIFT;
+	fault.gfn = ipa >> PAGE_SHIFT;
 	mte_allowed = kvm_vma_mte_allowed(vma);
 
 	vfio_allow_any_uc = vma->vm_flags & VM_ALLOW_ANY_UNCACHED;
@@ -1633,7 +1637,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	mmu_seq = vcpu->kvm->mmu_invalidate_seq;
 	mmap_read_unlock(current->mm);
 
-	pfn = __kvm_faultin_pfn(memslot, gfn, write_fault ? FOLL_WRITE : 0,
+	pfn = __kvm_faultin_pfn(memslot, fault.gfn, fault.write ? FOLL_WRITE : 0,
 				&writable, &page);
 	if (pfn == KVM_PFN_ERR_HWPOISON) {
 		kvm_send_hwpoison_signal(hva, vma_shift);
@@ -1654,7 +1658,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		 * change things at the last minute.
 		 */
 		device = true;
-	} else if (logging_active && !write_fault) {
+	} else if (logging_active && !fault.write) {
 		/*
 		 * Only actually map the page as writable if this was a write
 		 * fault.
@@ -1662,7 +1666,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		writable = false;
 	}
 
-	if (exec_fault && device)
+	if (fault.exec && device)
 		return -ENOEXEC;
 
 	/*
@@ -1722,7 +1726,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (writable)
 		prot |= KVM_PGTABLE_PROT_W;
 
-	if (exec_fault)
+	if (fault.exec)
 		prot |= KVM_PGTABLE_PROT_X;
 
 	if (device) {
@@ -1759,7 +1763,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 
 	/* Mark the page dirty only if the fault is handled successfully */
 	if (writable && !ret)
-		mark_page_dirty_in_slot(kvm, memslot, gfn);
+		mark_page_dirty_in_slot(kvm, memslot, fault.gfn);
 
 	return ret != -EAGAIN ? ret : 0;
 }
-- 
2.50.0.rc2.692.g299adb8693-goog


