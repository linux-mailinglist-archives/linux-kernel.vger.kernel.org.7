Return-Path: <linux-kernel+bounces-844835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC85BC2E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97496189DDC4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8EF259C80;
	Tue,  7 Oct 2025 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cw/xybFL"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A985C23D281
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759876590; cv=none; b=PRCUIQhFDMCBOIgGB0tfbzD9c2neeWnMLd9S3DCGEJ+lV/mAl50wRDbZZxMsCTjwBXDCLz7tnDc/pwgomsi3Dmv62CFYUcRSmGkhyqiLtfK3Vbvr6NdlcM/nhKAl6TdRYIGThlHVnR9g29Zc8bqMvzhpb2wpQzM7zRw1EnvZ5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759876590; c=relaxed/simple;
	bh=8m9s5ewUnOI8HOC6LmCn+j18kEaFqyw5sp0EdYi5yfU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VhVL20EVXHkHrW91jDjZg6z2jJ6MoySrHJ4NTnx98oSDwk0q6OiYVIYv5WcF52onXxUw3VLJaBGTDKuLCAJHn3ImFy2KMSguWmHrUZ7+5HtAOpW7rBG9/tJc+TtZIGv4e/ycM/OylrSCY3Vyf1bpbyRYWz0q5e/4z+VQFIalD1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cw/xybFL; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b57c2371182so5615587a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759876588; x=1760481388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68qo6n2TcvOcWthot2i6pnlKFOZE+Ug0E5pPbn/P/4I=;
        b=Cw/xybFLrITsOmLqrBcE9GRy3C9K0osP91GMpTD0ZOc201R0P3FIDXX/zHWSACe/3W
         xXLURWyA+xpCgcYdCLX3WRe4TDiK9M/xlPa5lMn/KFa/JqmyKysD95u0xy6RqTr/hgBU
         j+n63A+ee2Gr9j5wvdqpvstlcFBBPTTQIAC6X/bXG9hUOtfVR7xY+YttppzIqbSlbdEb
         4339RWerx1RjB60arXUopSJ6IjL02ORaAC6sSYMmYcx97hJSumN2KPeXXvicXAG8WI3S
         xgc541V53by26UPuzd7VlhiTOVF5yHzTHSd4s2YVzD1BrQqTWobCenwFM21TjJp1uS0/
         P0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759876588; x=1760481388;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68qo6n2TcvOcWthot2i6pnlKFOZE+Ug0E5pPbn/P/4I=;
        b=rPUi6orqsRTqdM8NsplO9T1G6llbf4Az4uxEojkD2HddO4fkW0wR+RTv1oiZzNPoP9
         NfCHHwJgp+yBpIg+TCuXD71wC0Dz+aJsdd/iLF0+PNAFCrt2Uwho2BXTMthH7qr3zSar
         HG+mlNm1VPQRRBIjJYjRe8yRYMEzYPH03rvtXRHa/dwbT3UUBAky1kefYkQq6l/soxXM
         YNPvBcgCWYhbGpI22vUeykjVWvcchHdn354xldrXxfrv9Nn4PmXRRGrU1lrRdrPxlwlF
         ufRag4TsK8yz1EK/rJSOAvra7rsFB+d9lEhqoGsPTpdAQ/kyHMcHnvAYXmF1UNRT52Bl
         gkyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv+TCVpF0BaeK0hXWPf5RLdkcX/QZfFGcyD9erxd/sxUzs+H/kP0YLLPapcqkmUyIvwcO/D5jddRZy/bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiADwXHY9N0VEJ1+S0A9WsB+qNScufM6kRbIclD+J/s5bqtFQl
	c+NCDcSV8YsXFFYZw6gUu4iv1F9qe28jT/kuKC/Kpt3aYzrvdpQFgFy3Q3K5ZcRVAqZg2p6qGNt
	kCd8lKw==
X-Google-Smtp-Source: AGHT+IHCZuGC68qasf7KAOUWdyDnwSOMgu3ErsL6HL80dAIVGS/k+xxOUSgxkSNZO0APtx0Mg4yaL0cDewI=
X-Received: from pjbpc1.prod.google.com ([2002:a17:90b:3b81:b0:327:e021:e61d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d06:b0:32c:2cd:4d67
 with SMTP id 98e67ed59e1d1-33b511188dcmr1161678a91.13.1759876587894; Tue, 07
 Oct 2025 15:36:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  7 Oct 2025 15:36:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251007223625.369939-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Rename "guest_paddr" variables to "gpa"
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename "guest_paddr" variables in vm_userspace_mem_region_add() and
vm_mem_add() to KVM's de facto standard "gpa", both for consistency and
to shorten line lengths.

Opportunistically fix the indentation of the
vm_userspace_mem_region_add() declaration.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  | 10 ++--
 tools/testing/selftests/kvm/lib/kvm_util.c    | 46 +++++++++----------
 2 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 26cc30290e76..3aa7a286d4a0 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -675,12 +675,12 @@ int __vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flag
 				 uint32_t guest_memfd, uint64_t guest_memfd_offset);
 
 void vm_userspace_mem_region_add(struct kvm_vm *vm,
-	enum vm_mem_backing_src_type src_type,
-	uint64_t guest_paddr, uint32_t slot, uint64_t npages,
-	uint32_t flags);
+				 enum vm_mem_backing_src_type src_type,
+				 uint64_t gpa, uint32_t slot, uint64_t npages,
+				 uint32_t flags);
 void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
-		uint64_t guest_paddr, uint32_t slot, uint64_t npages,
-		uint32_t flags, int guest_memfd_fd, uint64_t guest_memfd_offset);
+		uint64_t gpa, uint32_t slot, uint64_t npages, uint32_t flags,
+		int guest_memfd_fd, uint64_t guest_memfd_offset);
 
 #ifndef vm_arch_has_protected_memory
 static inline bool vm_arch_has_protected_memory(struct kvm_vm *vm)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 6743fbd9bd67..ce3230068482 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -963,8 +963,8 @@ void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flags
 
 /* FIXME: This thing needs to be ripped apart and rewritten. */
 void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
-		uint64_t guest_paddr, uint32_t slot, uint64_t npages,
-		uint32_t flags, int guest_memfd, uint64_t guest_memfd_offset)
+		uint64_t gpa, uint32_t slot, uint64_t npages, uint32_t flags,
+		int guest_memfd, uint64_t guest_memfd_offset)
 {
 	int ret;
 	struct userspace_mem_region *region;
@@ -978,30 +978,29 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		"Number of guest pages is not compatible with the host. "
 		"Try npages=%d", vm_adjust_num_guest_pages(vm->mode, npages));
 
-	TEST_ASSERT((guest_paddr % vm->page_size) == 0, "Guest physical "
+	TEST_ASSERT((gpa % vm->page_size) == 0, "Guest physical "
 		"address not on a page boundary.\n"
-		"  guest_paddr: 0x%lx vm->page_size: 0x%x",
-		guest_paddr, vm->page_size);
-	TEST_ASSERT((((guest_paddr >> vm->page_shift) + npages) - 1)
+		"  gpa: 0x%lx vm->page_size: 0x%x",
+		gpa, vm->page_size);
+	TEST_ASSERT((((gpa >> vm->page_shift) + npages) - 1)
 		<= vm->max_gfn, "Physical range beyond maximum "
 		"supported physical address,\n"
-		"  guest_paddr: 0x%lx npages: 0x%lx\n"
+		"  gpa: 0x%lx npages: 0x%lx\n"
 		"  vm->max_gfn: 0x%lx vm->page_size: 0x%x",
-		guest_paddr, npages, vm->max_gfn, vm->page_size);
+		gpa, npages, vm->max_gfn, vm->page_size);
 
 	/*
 	 * Confirm a mem region with an overlapping address doesn't
 	 * already exist.
 	 */
 	region = (struct userspace_mem_region *) userspace_mem_region_find(
-		vm, guest_paddr, (guest_paddr + npages * vm->page_size) - 1);
+		vm, gpa, (gpa + npages * vm->page_size) - 1);
 	if (region != NULL)
 		TEST_FAIL("overlapping userspace_mem_region already "
 			"exists\n"
-			"  requested guest_paddr: 0x%lx npages: 0x%lx "
-			"page_size: 0x%x\n"
-			"  existing guest_paddr: 0x%lx size: 0x%lx",
-			guest_paddr, npages, vm->page_size,
+			"  requested gpa: 0x%lx npages: 0x%lx page_size: 0x%x\n"
+			"  existing gpa: 0x%lx size: 0x%lx",
+			gpa, npages, vm->page_size,
 			(uint64_t) region->region.guest_phys_addr,
 			(uint64_t) region->region.memory_size);
 
@@ -1015,8 +1014,7 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 			"already exists.\n"
 			"  requested slot: %u paddr: 0x%lx npages: 0x%lx\n"
 			"  existing slot: %u paddr: 0x%lx size: 0x%lx",
-			slot, guest_paddr, npages,
-			region->region.slot,
+			slot, gpa, npages, region->region.slot,
 			(uint64_t) region->region.guest_phys_addr,
 			(uint64_t) region->region.memory_size);
 	}
@@ -1042,7 +1040,7 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
 		alignment = max(backing_src_pagesz, alignment);
 
-	TEST_ASSERT_EQ(guest_paddr, align_up(guest_paddr, backing_src_pagesz));
+	TEST_ASSERT_EQ(gpa, align_up(gpa, backing_src_pagesz));
 
 	/* Add enough memory to align up if necessary */
 	if (alignment > 1)
@@ -1106,20 +1104,18 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	region->unused_phy_pages = sparsebit_alloc();
 	if (vm_arch_has_protected_memory(vm))
 		region->protected_phy_pages = sparsebit_alloc();
-	sparsebit_set_num(region->unused_phy_pages,
-		guest_paddr >> vm->page_shift, npages);
+	sparsebit_set_num(region->unused_phy_pages, gpa >> vm->page_shift, npages);
 	region->region.slot = slot;
 	region->region.flags = flags;
-	region->region.guest_phys_addr = guest_paddr;
+	region->region.guest_phys_addr = gpa;
 	region->region.memory_size = npages * vm->page_size;
 	region->region.userspace_addr = (uintptr_t) region->host_mem;
 	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION2, &region->region);
 	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION2 IOCTL failed,\n"
 		"  rc: %i errno: %i\n"
 		"  slot: %u flags: 0x%x\n"
-		"  guest_phys_addr: 0x%lx size: 0x%lx guest_memfd: %d",
-		ret, errno, slot, flags,
-		guest_paddr, (uint64_t) region->region.memory_size,
+		"  guest_phys_addr: 0x%lx size: 0x%llx guest_memfd: %d",
+		ret, errno, slot, flags, gpa, region->region.memory_size,
 		region->region.guest_memfd);
 
 	/* Add to quick lookup data structures */
@@ -1143,10 +1139,10 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 
 void vm_userspace_mem_region_add(struct kvm_vm *vm,
 				 enum vm_mem_backing_src_type src_type,
-				 uint64_t guest_paddr, uint32_t slot,
-				 uint64_t npages, uint32_t flags)
+				 uint64_t gpa, uint32_t slot, uint64_t npages,
+				 uint32_t flags)
 {
-	vm_mem_add(vm, src_type, guest_paddr, slot, npages, flags, -1, 0);
+	vm_mem_add(vm, src_type, gpa, slot, npages, flags, -1, 0);
 }
 
 /*

base-commit: 6b36119b94d0b2bb8cea9d512017efafd461d6ac
-- 
2.51.0.710.ga91ca5db03-goog


