Return-Path: <linux-kernel+bounces-821706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD41FB8207B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBEF71C23F77
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83B730F93A;
	Wed, 17 Sep 2025 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JLIK5MZH"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4951930E85C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145876; cv=none; b=hgEvAPn1YUzx8z0Bpf74D8rz2Hfd/pmVaGoa/xyz+nUTfqBid2k85R+zBf1zaB35HP1sHweXeNmeUi5+AQDhtlLtR9/o+bNoi/Rr24a1VV6I4TYfd2DXtBylCYkkaoxvWpMg3vNjKBW2nwDbs3MU0/N2iNbq0wZfiYB84hM77BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145876; c=relaxed/simple;
	bh=iuAmp899u8/2zjg7JEkbN+8eGWOiV1+PDEp2ucfo3bo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uPEQv3z4apb4KJPsiBMjJNV6TXyVpr+1/O9UrE6QAJksce+xFBdOue4S6IoXL6TsKUKz1OTLcKbG6i6TdGsO0Nugg1biNJ6NHH9Usf7PRoC5g3rRhm7612ImO2HG+iGAHvcEjiDa97DU9pgf/j6waMs4EZ5u+osI8zyF+IjQJfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JLIK5MZH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4fb25c2e56so142421a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758145874; x=1758750674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QLzLvZWG+ClPdB8sQ82+qcHJiOj3WmonmSKG4nve6Ec=;
        b=JLIK5MZHBeKRen3fNXV7Sht7/2Iir1By+fOeyx19JLxY+uoqQSF8zWTE00fMwievsU
         mHCwVm29Bi4ML0PjWm0U9YGllMcko2gbvsOGSJJHh8mOtDK4L6uUGu80yqsGzV6kPZ8J
         FRH8W2MKORvsKYjMuOIua0tsFpd7k42+vd86GTPf858DUhx1L3TInm4MytZRPi75FmKM
         STerhSbkjgppVKWj8RmhDL67j9iDCoE+SmcwXIur8ILgsq25CvqOvg7Aq/GiTGigJ9JF
         DZQ4MO9UL7Q/GbFTG0Vz6Tl/XQ+ItqEx2ItbAw4Y0srqFJ3XJmp1V+pwavzd6Y/r3F7U
         Kq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758145874; x=1758750674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLzLvZWG+ClPdB8sQ82+qcHJiOj3WmonmSKG4nve6Ec=;
        b=AMiLyLyClQDWAIyb/miWSDiYfBOrW9WyMT2vOE19tOCEM64hznUZktt2gd2ZyJx4fK
         ofQxLwrCr0xCcm1ROjPYeYWXtI+q/2LWV9elWjddSvnS/LpXEk5kxV99ZKrCRCtZQlZG
         RuWp5rH6zXKV+rOYkvdDKDgpZTE/Sln4WmpRkeS/UPm6FUuqC2CFg90kCbK85oVpCVKO
         u3GLn8wuLrjIi4SlpZuB11uog5ypDgBLf+JKY1QcFU6L1KT2CLFUegf6jMG9Bl3NoaTF
         8njoI8H6b5rID+SVNzBOFIVVyHc6zQADgxztyHpwco6QG71oSlNk+ibLQyjTN52sZsfj
         liyA==
X-Forwarded-Encrypted: i=1; AJvYcCWkZ3zaBylCzeRUHY3vGgik9epayst60qpGNq+apkQV9bgImfEelKTbboHE+iNLlaOkJ+r5yGVJBUpSo0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSnWTtCo0CbJVvLOHs3vHYIuVdwkfaKQa+fgsj6efoYbz+VZiz
	6fxFYKMm0GaB+ZqyEmm/ePXntDiN918JF5P1LIyKAwckaRUXjzdvwzRBliHvRVkXb9QLIVLcGTB
	VM6XtK5oEiouTNQ==
X-Google-Smtp-Source: AGHT+IH5Sap/ei/fGQvx7x2RNFtD57XnmWHb91axnrJALJUHyDZUxhwHeWhmKptLbqe+jzHTmP2HVpx/C5MC1A==
X-Received: from pjbta13.prod.google.com ([2002:a17:90b:4ecd:b0:32e:879e:cac1])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db11:b0:25c:2a4c:1ca3 with SMTP id d9443c01a7336-268137f2209mr49570525ad.30.1758145874602;
 Wed, 17 Sep 2025 14:51:14 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:48:39 -0700
In-Reply-To: <20250917215031.2567566-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917215031.2567566-1-jmattson@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250917215031.2567566-4-jmattson@google.com>
Subject: [PATCH 3/4] KVM: selftests: Add VM_MODE_PXXV57_4K VM mode
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Eric Auger <eric.auger@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new VM mode, VM_MODE_PXXV57_4K, to support tests that require
5-level paging on x86. This mode sets up a 57-bit virtual address
space and sets CR4.LA57 in the guest.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 21 +++++++++++++++++
 .../testing/selftests/kvm/lib/x86/processor.c | 23 ++++++++++++-------
 tools/testing/selftests/kvm/lib/x86/vmx.c     |  7 +++---
 4 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 23a506d7eca3..b6ea5d966715 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -175,6 +175,7 @@ enum vm_guest_mode {
 	VM_MODE_P40V48_16K,
 	VM_MODE_P40V48_64K,
 	VM_MODE_PXXV48_4K,	/* For 48bits VA but ANY bits PA */
+	VM_MODE_PXXV57_4K,	/* For 48bits VA but ANY bits PA */
 	VM_MODE_P47V64_4K,
 	VM_MODE_P44V64_4K,
 	VM_MODE_P36V48_4K,
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index c3f5142b0a54..6b0e499c6e91 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -232,6 +232,7 @@ const char *vm_guest_mode_string(uint32_t i)
 		[VM_MODE_P40V48_16K]	= "PA-bits:40,  VA-bits:48, 16K pages",
 		[VM_MODE_P40V48_64K]	= "PA-bits:40,  VA-bits:48, 64K pages",
 		[VM_MODE_PXXV48_4K]	= "PA-bits:ANY, VA-bits:48,  4K pages",
+		[VM_MODE_PXXV57_4K]	= "PA-bits:ANY, VA-bits:57,  4K pages",
 		[VM_MODE_P47V64_4K]	= "PA-bits:47,  VA-bits:64,  4K pages",
 		[VM_MODE_P44V64_4K]	= "PA-bits:44,  VA-bits:64,  4K pages",
 		[VM_MODE_P36V48_4K]	= "PA-bits:36,  VA-bits:48,  4K pages",
@@ -259,6 +260,7 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
 	[VM_MODE_P40V48_16K]	= { 40, 48,  0x4000, 14 },
 	[VM_MODE_P40V48_64K]	= { 40, 48, 0x10000, 16 },
 	[VM_MODE_PXXV48_4K]	= {  0,  0,  0x1000, 12 },
+	[VM_MODE_PXXV57_4K]	= {  0,  0,  0x1000, 12 },
 	[VM_MODE_P47V64_4K]	= { 47, 64,  0x1000, 12 },
 	[VM_MODE_P44V64_4K]	= { 44, 64,  0x1000, 12 },
 	[VM_MODE_P36V48_4K]	= { 36, 48,  0x1000, 12 },
@@ -358,6 +360,25 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 		vm->va_bits = 48;
 #else
 		TEST_FAIL("VM_MODE_PXXV48_4K not supported on non-x86 platforms");
+#endif
+		break;
+	case VM_MODE_PXXV57_4K:
+#ifdef __x86_64__
+		kvm_get_cpu_address_width(&vm->pa_bits, &vm->va_bits);
+		kvm_init_vm_address_properties(vm);
+		/*
+		 * For 5-level paging, KVM requires LA57 to be enabled, which
+		 * requires a 57-bit virtual address space.
+		 */
+		TEST_ASSERT(vm->va_bits == 57,
+			    "Linear address width (%d bits) not supported for VM_MODE_PXXV57_4K",
+			    vm->va_bits);
+		pr_debug("Guest physical address width detected: %d\n",
+			 vm->pa_bits);
+		vm->pgtable_levels = 5;
+		vm->va_bits = 57;
+#else
+		TEST_FAIL("VM_MODE_PXXV57_4K not supported on non-x86 platforms");
 #endif
 		break;
 	case VM_MODE_P47V64_4K:
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 433365c8196d..d566190ea488 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -124,10 +124,11 @@ bool kvm_is_tdp_enabled(void)
 
 void virt_arch_pgd_alloc(struct kvm_vm *vm)
 {
-	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K, "Attempt to use "
-		"unknown or unsupported guest mode, mode: 0x%x", vm->mode);
+	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K ||
+		    vm->mode == VM_MODE_PXXV57_4K,
+		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
 
-	/* If needed, create page map l4 table. */
+	/* If needed, create the top-level page table. */
 	if (!vm->pgd_created) {
 		vm->pgd = vm_alloc_page_table(vm);
 		vm->pgd_created = true;
@@ -187,8 +188,9 @@ void __virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr, int level)
 	uint64_t *pte = &vm->pgd;
 	int current_level;
 
-	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K,
-		    "Unknown or unsupported guest mode, mode: 0x%x", vm->mode);
+	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K ||
+		    vm->mode == VM_MODE_PXXV57_4K,
+		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
 
 	TEST_ASSERT((vaddr % pg_size) == 0,
 		    "Virtual address not aligned,\n"
@@ -279,8 +281,9 @@ uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
 	TEST_ASSERT(*level >= PG_LEVEL_NONE && *level < PG_LEVEL_NUM,
 		    "Invalid PG_LEVEL_* '%d'", *level);
 
-	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K, "Attempt to use "
-		"unknown or unsupported guest mode, mode: 0x%x", vm->mode);
+	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K ||
+		    vm->mode == VM_MODE_PXXV57_4K,
+		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
 	TEST_ASSERT(sparsebit_is_set(vm->vpages_valid,
 		(vaddr >> vm->page_shift)),
 		"Invalid virtual address, vaddr: 0x%lx",
@@ -481,7 +484,9 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 {
 	struct kvm_sregs sregs;
 
-	TEST_ASSERT_EQ(vm->mode, VM_MODE_PXXV48_4K);
+	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K ||
+		    vm->mode == VM_MODE_PXXV57_4K,
+		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
 
 	/* Set mode specific system register values. */
 	vcpu_sregs_get(vcpu, &sregs);
@@ -495,6 +500,8 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 	sregs.cr4 |= X86_CR4_PAE | X86_CR4_OSFXSR;
 	if (kvm_cpu_has(X86_FEATURE_XSAVE))
 		sregs.cr4 |= X86_CR4_OSXSAVE;
+	if (vm->pgtable_levels == 5)
+		sregs.cr4 |= X86_CR4_LA57;
 	sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
 
 	kvm_seg_set_unusable(&sregs.ldt);
diff --git a/tools/testing/selftests/kvm/lib/x86/vmx.c b/tools/testing/selftests/kvm/lib/x86/vmx.c
index d4d1208dd023..1b6d4a007798 100644
--- a/tools/testing/selftests/kvm/lib/x86/vmx.c
+++ b/tools/testing/selftests/kvm/lib/x86/vmx.c
@@ -401,11 +401,12 @@ void __nested_pg_map(struct vmx_pages *vmx, struct kvm_vm *vm,
 	struct eptPageTableEntry *pt = vmx->eptp_hva, *pte;
 	uint16_t index;
 
-	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K, "Attempt to use "
-		    "unknown or unsupported guest mode, mode: 0x%x", vm->mode);
+	TEST_ASSERT(vm->mode == VM_MODE_PXXV48_4K ||
+		    vm->mode == VM_MODE_PXXV57_4K,
+		    "Unknown or unsupported guest mode: 0x%x", vm->mode);
 
 	TEST_ASSERT((nested_paddr >> 48) == 0,
-		    "Nested physical address 0x%lx requires 5-level paging",
+		    "Nested physical address 0x%lx is > 48-bits and requires 5-level EPT",
 		    nested_paddr);
 	TEST_ASSERT((nested_paddr % page_size) == 0,
 		    "Nested physical address not on page boundary,\n"
-- 
2.51.0.470.ga7dc726c21-goog


