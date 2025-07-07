Return-Path: <linux-kernel+bounces-720625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E1BAFBE63
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17C84803CE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56222E8E19;
	Mon,  7 Jul 2025 22:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G6WlA2/Z"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DCF2E8DEF
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751928518; cv=none; b=EhB3jC5DP3zZxslq5Fn04ldb7yuClNdN7sIBtti/YIS1lYq9/l0NiRmYxxSYk/KUFFaW8cx08O4Uqgzz86M2dqJ/GiL8yMcuQGPAX8X0/irmOydASzGrQIqObgQjXRK3zZ379Z8FhM5RSsXFGaiLEriDvNQpJ4RWyvaEI9Y4I7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751928518; c=relaxed/simple;
	bh=WHQD+wG5cjWj67PYFFOGP3SPCRZb1qKxvRff49PdsyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nOCCPsd7JZ4lvnlB0RI1LkFoPd1dsBn2tJ6epdHSYBucK9IBlB+DB0NOlD8fLnhyIg2bFTZtz11ViJGl3Uv5+Fj0BBdysrP4YswHJW6GsxGrdAIPnHscGhTnB44PSkgQpm11FdqQIdGdvSrU9uhjLIYoGGz74wpz5/Rb0nWkOSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G6WlA2/Z; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3928ad6176so445911a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 15:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751928515; x=1752533315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nlIdHQhnmUm7I8SnUJOzI4Momd1aXaHzR+xD0oVsTbQ=;
        b=G6WlA2/ZYkGSS/147OlH58TywKUkne0A3RvknwDxcyTuFkNuApBhZy7/rvJ4wglMEg
         zFIBhqiAk8S2YTTRuCnHd9NujKlkVxaVZqpNtmMjDALdQ8T22eEWO8HLwqQcw2yeD0Qb
         gQyD9ocjZxITDdyQgGei4+F7leVgRnFzMgsyZSiPfIJ6dIXyhiCKb4xEXL/Ku1yNDGf+
         yZtPqWoP91y2yw/48R/g2EwFTIuyQyGvxr1S7O8hUz7TvFSoR3SFwzBjJ1JhnQrOpScy
         rf15PiOTcCuI/sa6Nllh0cc8kzRw1E1ZXMQb569APs8GwrdwkFznVhEopjx3iPScpG8F
         vwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751928515; x=1752533315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlIdHQhnmUm7I8SnUJOzI4Momd1aXaHzR+xD0oVsTbQ=;
        b=m1ICowcwJywFcLBkYUFaU26gW/cp26Snymp8U0Q7jRtp/o5170sgKnZ/uFnrd+JKr/
         eyxnd8Ue+HPERexv5/hTLEgX6xpYzEUGgUUvKuGQe8dJprZhF2UX3sMGzoFuz2clPR2x
         RLvCUQDVzUENlFC76/mSiR7fshBl1URKrP6C78vRnSWgarbfQAdC+W91ocxPI4VUOMIQ
         XuYoH3dRMDGcYv3DVZzBBt6UvUqnabVX+KGejnE+w+wtWlJtLNptYhMNTzd1W4aRZhAX
         T8CYxYWeXFGCDQkSaqrG6svt10iiFiW6lXVAfmOE8Hf6eJIwj2M2aElTvG8KKDBXN68+
         V89g==
X-Forwarded-Encrypted: i=1; AJvYcCX6WFwgsYKFinrlyZu4qa1/SepxQ4fRsnIzzhp/Loi+6RNX7KC9vzaVl6bBT7KsTtT43pc0lL3ewqFEzuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3M9UBw+x5RFE8eyENKZE3R8tWMonZvKq6wKp55+00C3su6QQ
	m2YHygA9c5qP2O0xsvanwl0vLQQejAl4w61uvmbWl21TV8bONnDG4ghA1WiNaNdSW71Stv/JP2F
	tyf0ASRb/lyk3Od/N9mdhLA==
X-Google-Smtp-Source: AGHT+IGceyFHfr9U/9tL1Akpsxnk/yoBH0Lh/7wvDo2nwSnzWD120gq79KQyk4BX4Blz0eZnN4sxE/RhFMqKQVk3
X-Received: from pgah22.prod.google.com ([2002:a05:6a02:4e96:b0:b31:c90f:389d])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:430d:b0:21f:74b5:e8cf with SMTP id adf61e73a8af0-22b45046e6emr1374616637.25.1751928514982;
 Mon, 07 Jul 2025 15:48:34 -0700 (PDT)
Date: Mon,  7 Jul 2025 22:47:19 +0000
In-Reply-To: <20250707224720.4016504-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250707224720.4016504-1-jthoughton@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707224720.4016504-7-jthoughton@google.com>
Subject: [PATCH v5 6/7] KVM: selftests: Provide extra mmap flags in vm_mem_add()
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The immediate application here is to allow selftests to pass
MAP_POPULATE (to time fault time without having to allocate guest
memory).

Signed-off-by: James Houghton <jthoughton@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h    |  3 ++-
 tools/testing/selftests/kvm/lib/kvm_util.c        | 15 +++++++++------
 .../kvm/x86/private_mem_conversions_test.c        |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index bee65ca087217..4aafd5bf786e2 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -629,7 +629,8 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	uint32_t flags);
 void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		uint64_t guest_paddr, uint32_t slot, uint64_t npages,
-		uint32_t flags, int guest_memfd_fd, uint64_t guest_memfd_offset);
+		uint32_t flags, int guest_memfd_fd, uint64_t guest_memfd_offset,
+		int extra_mmap_flags);
 
 #ifndef vm_arch_has_protected_memory
 static inline bool vm_arch_has_protected_memory(struct kvm_vm *vm)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index a055343a7bf75..8157a0fd7f8b3 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -977,13 +977,15 @@ void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flags
 /* FIXME: This thing needs to be ripped apart and rewritten. */
 void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		uint64_t guest_paddr, uint32_t slot, uint64_t npages,
-		uint32_t flags, int guest_memfd, uint64_t guest_memfd_offset)
+		uint32_t flags, int guest_memfd, uint64_t guest_memfd_offset,
+		int extra_mmap_flags)
 {
 	int ret;
 	struct userspace_mem_region *region;
 	size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
 	size_t mem_size = npages * vm->page_size;
 	size_t alignment;
+	int mmap_flags;
 
 	TEST_REQUIRE_SET_USER_MEMORY_REGION2();
 
@@ -1066,9 +1068,11 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		region->fd = kvm_memfd_alloc(region->mmap_size,
 					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
 
+	mmap_flags = vm_mem_backing_src_alias(src_type)->flag |
+		     extra_mmap_flags;
+
 	region->mmap_start = mmap(NULL, region->mmap_size,
-				  PROT_READ | PROT_WRITE,
-				  vm_mem_backing_src_alias(src_type)->flag,
+				  PROT_READ | PROT_WRITE, mmap_flags,
 				  region->fd, 0);
 	TEST_ASSERT(region->mmap_start != MAP_FAILED,
 		    __KVM_SYSCALL_ERROR("mmap()", (int)(unsigned long)MAP_FAILED));
@@ -1143,8 +1147,7 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	/* If shared memory, create an alias. */
 	if (region->fd >= 0) {
 		region->mmap_alias = mmap(NULL, region->mmap_size,
-					  PROT_READ | PROT_WRITE,
-					  vm_mem_backing_src_alias(src_type)->flag,
+					  PROT_READ | PROT_WRITE, mmap_flags,
 					  region->fd, 0);
 		TEST_ASSERT(region->mmap_alias != MAP_FAILED,
 			    __KVM_SYSCALL_ERROR("mmap()",  (int)(unsigned long)MAP_FAILED));
@@ -1159,7 +1162,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 				 uint64_t guest_paddr, uint32_t slot,
 				 uint64_t npages, uint32_t flags)
 {
-	vm_mem_add(vm, src_type, guest_paddr, slot, npages, flags, -1, 0);
+	vm_mem_add(vm, src_type, guest_paddr, slot, npages, flags, -1, 0, 0);
 }
 
 /*
diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index 82a8d88b5338e..637e9e57fce46 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -399,7 +399,7 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, uint32_t
 	for (i = 0; i < nr_memslots; i++)
 		vm_mem_add(vm, src_type, BASE_DATA_GPA + slot_size * i,
 			   BASE_DATA_SLOT + i, slot_size / vm->page_size,
-			   KVM_MEM_GUEST_MEMFD, memfd, slot_size * i);
+			   KVM_MEM_GUEST_MEMFD, memfd, slot_size * i, 0);
 
 	for (i = 0; i < nr_vcpus; i++) {
 		uint64_t gpa =  BASE_DATA_GPA + i * per_cpu_size;
-- 
2.50.0.727.gbf7dc18ff4-goog


