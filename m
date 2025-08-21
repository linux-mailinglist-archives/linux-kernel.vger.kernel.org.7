Return-Path: <linux-kernel+bounces-780690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B05B30800
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658CC1BA14AC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884B83126C5;
	Thu, 21 Aug 2025 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJuGlz9I"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A4B30F80C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810074; cv=none; b=aZrqWfkuTs4yCyT9PUTL73uDkkE0NK4hUfuD+C9xvwKMDtE2O+mJQReFKCA31OP8W26kzlwP3nQ9qsI/MfBGt+bIowXNsljy+QW8jkXKNAyekzCd/hHzZ13YU05TcAcwLy02C4GChsWa5bOSOFau5FcgriiH9fw4qYxaygwdjp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810074; c=relaxed/simple;
	bh=wzbsuKcJ4wvLXzApjrI6i7l0No25qC4BNkAFtcIBLxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aGLpXq0y17t/w++EMwx3Mfo9rvxeRJHWtSVSL/ObYhosfFby5xNQkc5MZcxDNUrsIFt9xeoT/k4znqEncVWywAxw2tMqL0bK0uAo49ZoHVi5W3zc2nicthet7Dwof98ffR9iIFRkSrh5BkDtMFBFEi99RqHvlgAv1z5pEMyFhMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aJuGlz9I; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e364afb44so1171111b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755810071; x=1756414871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=WFOpvpsT1MnunRLl4T+BHRi0vN/i3KJyyI1xXmPrPlw=;
        b=aJuGlz9I6KiwYRC4JE4wLOGUF8Y1U08JgUYzOvgQzWr1U4pyrjVsLuqwlqXHiHiLoU
         k4ea5wcq+vY2bie+gYNMDPl1eZJJdHRoL7VunLVuW2DsP82ZmsOUKxaZjMb4T9RBCXuY
         gVoyDAcfZzstNl5LyxJCmckW8e/nWQvUDxzRjKLiXXdBne9GnHK5vB0v5zMD14EdJ9GA
         Oe3q7QjsYF7rQhz11UVHgy84GL4xMRvLbwlJdxdQOLUzS3Ty1Esv4oKLSSaxcDYDqlp+
         yJnICt0Ae703tV0dfsvGAeohRkkFOk/X9YDkcN55yFmwyCffsfCYmLJUtmZBz8hj0sH8
         /JBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755810071; x=1756414871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFOpvpsT1MnunRLl4T+BHRi0vN/i3KJyyI1xXmPrPlw=;
        b=wEoy3IQfGYug4JYPMrT3leJDZ0P5coP4du2o9rkofFwWLd3zFsOVvFTbRletRk0L8U
         4AJkm99x91HGxvsrjN5mrmQ2AbL6mJtFqCCEp915uc3kuyfPLV3PGIRnvda1vDpoqXhH
         iYD1+wo6ns6KhE2k10ZMMUxQLygUEYAHXLJHNJ7naSwZJRY0qlOTsngUqhWmw+/E+aKo
         fQ2rl4SNfbl30RfR8F0a8DTM+ayALSFBhq9VapxKxnxbDOBUHLwVXhW8qFk0HUU/C3D2
         ZDtk4L2lesLBjmX82AQKKJMfrtMiebCEjMyyTGi2jlwpgX0GxjyUJbdAMSbftbipek0J
         XTNg==
X-Forwarded-Encrypted: i=1; AJvYcCVv+cig8w6nHzoNue8ddr5UMFy+ibdc3RMZp311B8gBBwJTcBaa5dTM1YaCeQf9h5RTDMDctzmcjBzDd0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcCSiPdc+ZwHZ7QwEbgclsWMgxlKGWYcITRV/BVuuG1wGFOtYl
	CLA401f31cPaQVacqilblj3jToYJfcsRlqF/Hauob+iqejGEdcCp3pFIgKMalLIaGbwHz8l9BNl
	dA3D/dw==
X-Google-Smtp-Source: AGHT+IH2D5yvxXbQMYKp9CQ1/YsbKvTYEoUYMROb+eewLnOLV2mjTAu7kJckUk9DqMy3wtdy3hZnzxFFxu8=
X-Received: from pghz18.prod.google.com ([2002:a63:e112:0:b0:b42:8a4c:7b14])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2446:b0:240:1fb6:d335
 with SMTP id adf61e73a8af0-24340db0419mr735886637.37.1755810071501; Thu, 21
 Aug 2025 14:01:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 21 Aug 2025 14:00:41 -0700
In-Reply-To: <20250821210042.3451147-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821210042.3451147-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250821210042.3451147-16-seanjc@google.com>
Subject: [RFC PATCH 15/16] KVM: arm64: Extract mmap_lock-protected code to
 helper for user mem aborts
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Factor out the mmap_lock-protected portion of user_mem_abort() to a new
helper, partly to make user_mem_abort() easier to follow, but mostly so
that the scope of the mmap_lock-protected code is more explicitly bounded.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/mmu.c | 96 ++++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index fec3a6aeabd0..ea326d66f027 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1466,47 +1466,10 @@ static bool kvm_vma_is_cacheable(struct vm_area_struct *vma)
 	}
 }
 
-static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
+static int kvm_gather_fault_vma_info(struct kvm_vcpu *vcpu,
+				     struct kvm_page_fault *fault)
 {
-	int ret = 0;
-	bool writable;
-	struct kvm *kvm = vcpu->kvm;
 	struct vm_area_struct *vma;
-	void *memcache;
-	bool logging_active = memslot_is_logging(fault->slot);
-	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
-	struct kvm_pgtable *pgt;
-	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_HANDLE_FAULT | KVM_PGTABLE_WALK_SHARED;
-
-	VM_BUG_ON(fault->write && fault->exec);
-
-	if (fault->is_perm && !fault->write && !fault->exec) {
-		kvm_err("Unexpected L2 read permission error\n");
-		return -EFAULT;
-	}
-
-	if (!is_protected_kvm_enabled())
-		memcache = &vcpu->arch.mmu_page_cache;
-	else
-		memcache = &vcpu->arch.pkvm_memcache;
-
-	/*
-	 * Permission faults just need to update the existing leaf entry,
-	 * and so normally don't require allocations from the memcache. The
-	 * only exception to this is when dirty logging is enabled at runtime
-	 * and a write fault needs to collapse a block entry into a table.
-	 */
-	if (!fault->is_perm || (logging_active && fault->write)) {
-		int min_pages = kvm_mmu_cache_min_pages(vcpu->arch.hw_mmu);
-
-		if (!is_protected_kvm_enabled())
-			ret = kvm_mmu_topup_memory_cache(memcache, min_pages);
-		else
-			ret = topup_hyp_memcache(memcache, min_pages);
-
-		if (ret)
-			return ret;
-	}
 
 	/*
 	 * Let's check if we will get back a huge page backed by hugetlbfs, or
@@ -1520,11 +1483,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		return -EFAULT;
 	}
 
-	/*
-	 * logging_active is guaranteed to never be true for VM_PFNMAP
-	 * memslots.
-	 */
-	if (logging_active) {
+	/* Logging is guaranteed to never be active for VM_PFNMAP memslots. */
+	if (memslot_is_logging(fault->slot)) {
 		fault->force_pte = true;
 		fault->vma.pageshift = PAGE_SHIFT;
 	} else {
@@ -1613,6 +1573,54 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	fault->mmu_seq = vcpu->kvm->mmu_invalidate_seq;
 	mmap_read_unlock(current->mm);
 
+	return 0;
+}
+
+static int user_mem_abort(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
+{
+	int ret = 0;
+	bool writable;
+	struct kvm *kvm = vcpu->kvm;
+	void *memcache;
+	bool logging_active = memslot_is_logging(fault->slot);
+	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
+	struct kvm_pgtable *pgt;
+	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_HANDLE_FAULT | KVM_PGTABLE_WALK_SHARED;
+
+	VM_BUG_ON(fault->write && fault->exec);
+
+	if (fault->is_perm && !fault->write && !fault->exec) {
+		kvm_err("Unexpected L2 read permission error\n");
+		return -EFAULT;
+	}
+
+	if (!is_protected_kvm_enabled())
+		memcache = &vcpu->arch.mmu_page_cache;
+	else
+		memcache = &vcpu->arch.pkvm_memcache;
+
+	/*
+	 * Permission faults just need to update the existing leaf entry,
+	 * and so normally don't require allocations from the memcache. The
+	 * only exception to this is when dirty logging is enabled at runtime
+	 * and a write fault needs to collapse a block entry into a table.
+	 */
+	if (!fault->is_perm || (logging_active && fault->write)) {
+		int min_pages = kvm_mmu_cache_min_pages(vcpu->arch.hw_mmu);
+
+		if (!is_protected_kvm_enabled())
+			ret = kvm_mmu_topup_memory_cache(memcache, min_pages);
+		else
+			ret = topup_hyp_memcache(memcache, min_pages);
+
+		if (ret)
+			return ret;
+	}
+
+	ret = kvm_gather_fault_vma_info(vcpu, fault);
+	if (ret)
+		return ret;
+
 	fault->pfn = __kvm_faultin_pfn(fault->slot, fault->gfn,
 				       fault->write ? FOLL_WRITE : 0,
 				       &writable, &fault->page);
-- 
2.51.0.261.g7ce5a0a67e-goog


