Return-Path: <linux-kernel+bounces-787407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82635B375D1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E06A7C035B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A871A23AC;
	Wed, 27 Aug 2025 00:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4d9xCaaR"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53175147C9B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 00:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756253132; cv=none; b=Hjm8l9hqirewdXj3EM/wnbwoa5ShD/aScz6lwo0cU4uYyZJuikTZughk9zN0LAr8iXhs4e6zzL0k0k5uqbaHW1lAh05engQ9aGGuIrQFHw/NLyb220hzNKfwJo04o1oeHNd6yP6/Qn0uF674lYGVvoGiCT1Tae+gRtA6UeZ3ENE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756253132; c=relaxed/simple;
	bh=RbqmG58uhBhjrLT78S9J9lpdJ5PH/vbaqH0T6Bch28M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MacC8boGoOWpG5coAoJq3F8OuCoJMgVjz+il865T4Gi+v0Ls1p/EWBC3H5d8tAgacOfaxlVbHDU2E10Ci69dykz2N1fKI4LusMxviE/Nu806ncxw+6a4ofICkn1xdp+N/UnRHpfKfPfGlEXu+KOq3pMz89zTlE96nkE6GJQhg7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4d9xCaaR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77053dd5eecso6055510b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756253128; x=1756857928; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2nP5VgV7dQdp6ICPvqC1VWWnjFhF5zNCGEmNjA5VkF4=;
        b=4d9xCaaRmeU1h4hQkBhGurPgTcoIbr4k7xnSGlo0eWeuKfdK2y61jvv7PSSJK8osKx
         86PpV2576RdkXndMRZRCRpigVRR140wKttp0jJtWDrN0RlADkGzQo6YYouM3COLK4mWR
         cezAQATqGWg7o2BS400OTDvrZpyYemU6OUa7yIvQmkOrCq4T0O6LnkpsIuEQbtGQc324
         D1Fs+wTmRAeB5FY/svmyIOzYacGYbXMqRzSGwdvmzmGnFixfFvMefmQd/DZQVI25acEq
         5V0xeYY+G0XCqzA8dZMD+grMv6JQCUJEKjiLPzHcWaR1OB62kFpcFmL4NVI2e8A4vZz+
         BpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756253128; x=1756857928;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nP5VgV7dQdp6ICPvqC1VWWnjFhF5zNCGEmNjA5VkF4=;
        b=ZxlVRYrQvNSeWW0HOFpyP/JbNq6PtNNRJMLO1+SaqDd/vz67xMSvu6FrUC/mOxLTnk
         1PXnEae8wPhHLm0x3my8ByaJ3UOO2/Gpom0fIX5Vht/refVOBwGQHZ19wbYoXphjjX1f
         aWyRgh8HhfaeU2w8hgCFnw1drOUhYCzlFysMhvRWesPLzCzb66D9RszVDdU1HnvYs81g
         idyBnxa/guZ7y48NhXi2A6qlJ7VWedu/AKVZ3zKREmEZ8vFibm5Vj1IZgNXGX7T8ys06
         vsWyfWFKtW9AWSuaQft4b/m298pcYHubE6VSZaDIkycBP1rqmg3SSgAykFH9SzHX4wYx
         b3rQ==
X-Forwarded-Encrypted: i=1; AJvYcCU04bSqoZBwpF405nnl9uUvY8ARSMLKtIzCibsoyWmyHMAeeDTypd12K1DI254LidalUELxAFPw34kvUf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNvZ3aq1jRlHXvzNrlYtF7Du2iJkcuQfpe5mcpL6abxJek2Xbq
	mUsueZt5Poe+6pcOZGCyrTiL/QYQSCQqtyKZOQ52rHesQ4egnixt0P6TDKqGK87/e/tAPldca+B
	fbDyOYA==
X-Google-Smtp-Source: AGHT+IH4TtfixO/LkRqrqjGe0+WgYZdthXCwbo+C5IyNGWTfUVUR8IHRsMWYV78QScDxcstww+dDYkTkTno=
X-Received: from pjbof15.prod.google.com ([2002:a17:90b:39cf:b0:325:8cfb:6444])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d99:b0:240:75c:6f40
 with SMTP id adf61e73a8af0-24340ca36a1mr28404494637.14.1756253127998; Tue, 26
 Aug 2025 17:05:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 26 Aug 2025 17:05:12 -0700
In-Reply-To: <20250827000522.4022426-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827000522.4022426-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250827000522.4022426-3-seanjc@google.com>
Subject: [RFC PATCH 02/12] KVM: x86/mmu: Add dedicated API to map guest_memfd
 pfn into TDP MMU
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add and use a new API for mapping a private pfn from guest_memfd into the
TDP MMU from TDX's post-populate hook instead of partially open-coding the
functionality into the TDX code.  Sharing code with the pre-fault path
sounded good on paper, but it's fatally flawed as simulating a fault loses
the pfn, and calling back into gmem to re-retrieve the pfn creates locking
problems, e.g. kvm_gmem_populate() already holds the gmem invalidation
lock.

Providing a dedicated API will also removing several MMU exports that
ideally would not be exposed outside of the MMU, let alone to vendor code.
On that topic, opportunistically drop the kvm_mmu_load() export.  Leave
kvm_tdp_mmu_gpa_is_mapped() alone for now; the entire commit that added
kvm_tdp_mmu_gpa_is_mapped() will be removed in the near future.

Cc: Michael Roth <michael.roth@amd.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Link: https://lore.kernel.org/all/20250709232103.zwmufocd3l7sqk7y@amd.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu.h     |  1 +
 arch/x86/kvm/mmu/mmu.c | 60 +++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/tdx.c | 10 +++----
 3 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index b4b6860ab971..697b90a97f43 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -259,6 +259,7 @@ extern bool tdp_mmu_enabled;
 
 bool kvm_tdp_mmu_gpa_is_mapped(struct kvm_vcpu *vcpu, u64 gpa);
 int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code, u8 *level);
+int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn);
 
 static inline bool kvm_memslots_have_rmaps(struct kvm *kvm)
 {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6e838cb6c9e1..d3625e00baf9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4990,6 +4990,65 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 	return min(range->size, end - range->gpa);
 }
 
+int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
+{
+	struct kvm_page_fault fault = {
+		.addr = gfn_to_gpa(gfn),
+		.error_code = PFERR_GUEST_FINAL_MASK | PFERR_PRIVATE_ACCESS,
+		.prefetch = true,
+		.is_tdp = true,
+		.nx_huge_page_workaround_enabled = is_nx_huge_page_enabled(vcpu->kvm),
+
+		.max_level = KVM_MAX_HUGEPAGE_LEVEL,
+		.req_level = PG_LEVEL_4K,
+		.goal_level = PG_LEVEL_4K,
+		.is_private = true,
+
+		.gfn = gfn,
+		.slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn),
+		.pfn = pfn,
+		.map_writable = true,
+	};
+	struct kvm *kvm = vcpu->kvm;
+	int r;
+
+	lockdep_assert_held(&kvm->slots_lock);
+
+	if (KVM_BUG_ON(!tdp_mmu_enabled, kvm))
+		return -EIO;
+
+	if (kvm_gfn_is_write_tracked(kvm, fault.slot, fault.gfn))
+		return -EPERM;
+
+	r = kvm_mmu_reload(vcpu);
+	if (r)
+		return r;
+
+	r = mmu_topup_memory_caches(vcpu, false);
+	if (r)
+		return r;
+
+	do {
+		if (signal_pending(current))
+			return -EINTR;
+
+		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
+			return -EIO;
+
+		cond_resched();
+
+		guard(read_lock)(&kvm->mmu_lock);
+
+		r = kvm_tdp_mmu_map(vcpu, &fault);
+	} while (r == RET_PF_RETRY);
+
+	if (r != RET_PF_FIXED)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvm_tdp_mmu_map_private_pfn);
+
 static void nonpaging_init_context(struct kvm_mmu *context)
 {
 	context->page_fault = nonpaging_page_fault;
@@ -5973,7 +6032,6 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
 out:
 	return r;
 }
-EXPORT_SYMBOL_GPL(kvm_mmu_load);
 
 void kvm_mmu_unload(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index a6155f76cc6a..1724d82c8512 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -3151,15 +3151,12 @@ struct tdx_gmem_post_populate_arg {
 static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 				  void __user *src, int order, void *_arg)
 {
-	u64 error_code = PFERR_GUEST_FINAL_MASK | PFERR_PRIVATE_ACCESS;
-	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 	struct tdx_gmem_post_populate_arg *arg = _arg;
-	struct kvm_vcpu *vcpu = arg->vcpu;
+	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
+	u64 err, entry, level_state;
 	gpa_t gpa = gfn_to_gpa(gfn);
-	u8 level = PG_LEVEL_4K;
 	struct page *src_page;
 	int ret, i;
-	u64 err, entry, level_state;
 
 	/*
 	 * Get the source page if it has been faulted in. Return failure if the
@@ -3171,7 +3168,7 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 	if (ret != 1)
 		return -ENOMEM;
 
-	ret = kvm_tdp_map_page(vcpu, gpa, error_code, &level);
+	ret = kvm_tdp_mmu_map_private_pfn(arg->vcpu, gfn, pfn);
 	if (ret < 0)
 		goto out;
 
@@ -3234,7 +3231,6 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
 	    !vt_is_tdx_private_gpa(kvm, region.gpa + (region.nr_pages << PAGE_SHIFT) - 1))
 		return -EINVAL;
 
-	kvm_mmu_reload(vcpu);
 	ret = 0;
 	while (region.nr_pages) {
 		if (signal_pending(current)) {
-- 
2.51.0.268.g9569e192d0-goog


