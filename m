Return-Path: <linux-kernel+bounces-834414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D2DBA4A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CAD1C01B26
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2A82FBE07;
	Fri, 26 Sep 2025 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQ9iZP5g"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380B32FB095
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904292; cv=none; b=lQq+tem1S1J2cblCjgGe6lhRUH3AYw2kDK15PtkHyb86nuuQCgg+dzSu9RJM43wNIIJDrs9V09eb8JBzj3isbUsQrrkszNr8zKx2RFr7vihhZEpCCr9BOwkBNXJ5GYCvCibR/AxQ54AvJ2yontSPYBDKlSldu8KA+u6JYsvC8RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904292; c=relaxed/simple;
	bh=5ouYU1x+vQV1xYY+5NwCFVJzXzcYqHiWXy2oOvLpX98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H2/mLJi/VA7aD8xxV7tOGc4+i59m11GMTXGloe6D2ngy86JHiOhW12YIBXqdA5ZgmHG9XRsAjqMKW1SZv/WymktjbQfX3uBGHwH+Vc9J9TPPQh2ujkW/MVGRJ56HfHtEuHaP/5gPhYWTDeJ2U9FBK1qx8MYRSCzti/kdOp/QUx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQ9iZP5g; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-780fb254938so2203690b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758904289; x=1759509089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mIE13y709YZSO3EgVozYTZXl0zOqNdqn4QytTeuNFKg=;
        b=fQ9iZP5gzRGLMEY/rRgdyNZt5Uynrkp6YTpOXf247aUNwhyX6FX257a8Z/sxTt7m9X
         sy/qBCbgTn8fAfjFxUhiqErANzVcjnsTzVdhPFtVw7UcP8gxMKp/1LiHpothfjG9/gvh
         UHN+qQ2TQLXBMIL6J3kZVqyqzYJ74i6qTR0RkGHijpP73wgV8cj/eX7uv0LERlI8L/Hg
         BDvYefRmdR94wNFp+KrivYkiOMv4ho7S9kEfnq//9ccGsY6zdcLoNJgPY+GA5CQJNrHQ
         9HgccOkVeZ0ilUl4x/I/B+5DDeMrHvvNoGKNpaxzBKqPPhkO9hD8zwic1U4tkeN2nelN
         PXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758904289; x=1759509089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIE13y709YZSO3EgVozYTZXl0zOqNdqn4QytTeuNFKg=;
        b=DHfrcEiIhj8hQpuhyteaegXPJQK2aRJsV5dr5DkNpGsGMvi4xovgubZvfWMWeIBqbv
         32YMkiUK48lykFVw+Flr12cg6bo/pIA6DPvUeSUSu3Cpam1svNzCsH1EgswDWek3Ia+3
         LpMsPfpYYFOJ8sgekWBkDigx0DzNS6FwfH5LFAXvkZTu43OZ7MQZrEvKDEsh9GtsZhhd
         wvOC75sjhej9KUoXPE64v/3L713Vc/Ikp14BTuOZLIKg4dJoc3FT+Sxdn3FeE1WL1WaI
         hi2ysbog8VitHrWhcjJGMpbrnzNUptzcZci/sKUzKeENY8mpsIJM05CvokvUxbMWP01z
         c68Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZXOx+kWzndgw/hB/lwP+Dnjn0p6eJfmtxhJAf6BN7AhJl/A7xyt6om8Gan05skksMFzNN60DtSIFhtDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuL8/NsrNMjAZHfRX3EOU60t7T8HngH/6PEo8+YJ3W6kWcAl0h
	5fmL9DpOljlG/rU9xqd8g34wlXumvyM1KfjOzRfWnruhKK3/+bcQL9Suklhzj7XmQl/UkyMsiUl
	En4XfDA==
X-Google-Smtp-Source: AGHT+IFN1uUFZT9ExHhwPSN+VNtPUBMVdasrIKeFnHFvRbqS+XCpsvXfl4j9c/yE1lvIbD2pbYso9Ki0qGU=
X-Received: from pfde21.prod.google.com ([2002:aa7:8c55:0:b0:77c:b486:d17e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d14:b0:77c:556e:d6b1
 with SMTP id d2e1a72fcca58-780fce99850mr9670473b3a.21.1758904289567; Fri, 26
 Sep 2025 09:31:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Sep 2025 09:31:06 -0700
In-Reply-To: <20250926163114.2626257-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926163114.2626257-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926163114.2626257-6-seanjc@google.com>
Subject: [PATCH 5/6] KVM: selftests: Add wrappers for mmap() and munmap() to
 assert success
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Add and use wrappers for mmap() and munmap() that assert success to reduce
a significant amount of boilerplate code, to ensure all tests assert on
failure, and to provide consistent error messages on failure.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 21 +++------
 .../testing/selftests/kvm/include/kvm_util.h  | 25 +++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 44 +++++++------------
 tools/testing/selftests/kvm/mmu_stress_test.c |  5 +--
 .../selftests/kvm/s390/ucontrol_test.c        | 16 +++----
 .../selftests/kvm/set_memory_region_test.c    | 17 ++++---
 6 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 5a50a28ce1fa..5dd40b77dc07 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -50,8 +50,7 @@ static void test_mmap_supported(int fd, size_t total_size)
 	mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	TEST_ASSERT(mem == MAP_FAILED, "Copy-on-write not allowed by guest_memfd.");
 
-	mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-	TEST_ASSERT(mem != MAP_FAILED, "mmap() for guest_memfd should succeed.");
+	mem = kvm_mmap(total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
 
 	memset(mem, val, total_size);
 	for (i = 0; i < total_size; i++)
@@ -70,8 +69,7 @@ static void test_mmap_supported(int fd, size_t total_size)
 	for (i = 0; i < total_size; i++)
 		TEST_ASSERT_EQ(READ_ONCE(mem[i]), val);
 
-	ret = munmap(mem, total_size);
-	TEST_ASSERT(!ret, "munmap() should succeed.");
+	kvm_munmap(mem, total_size);
 }
 
 static sigjmp_buf jmpbuf;
@@ -89,10 +87,8 @@ static void test_fault_overflow(int fd, size_t total_size)
 	const char val = 0xaa;
 	char *mem;
 	size_t i;
-	int ret;
 
-	mem = mmap(NULL, map_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-	TEST_ASSERT(mem != MAP_FAILED, "mmap() for guest_memfd should succeed.");
+	mem = kvm_mmap(map_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
 
 	sigaction(SIGBUS, &sa_new, &sa_old);
 	if (sigsetjmp(jmpbuf, 1) == 0) {
@@ -104,8 +100,7 @@ static void test_fault_overflow(int fd, size_t total_size)
 	for (i = 0; i < total_size; i++)
 		TEST_ASSERT_EQ(READ_ONCE(mem[i]), val);
 
-	ret = munmap(mem, map_size);
-	TEST_ASSERT(!ret, "munmap() should succeed.");
+	kvm_munmap(mem, map_size);
 }
 
 static void test_mmap_not_supported(int fd, size_t total_size)
@@ -347,10 +342,9 @@ static void test_guest_memfd_guest(void)
 					     GUEST_MEMFD_FLAG_DEFAULT_SHARED);
 	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, size, NULL, fd, 0);
 
-	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-	TEST_ASSERT(mem != MAP_FAILED, "mmap() on guest_memfd failed");
+	mem = kvm_mmap(size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
 	memset(mem, 0xaa, size);
-	munmap(mem, size);
+	kvm_munmap(mem, size);
 
 	virt_pg_map(vm, gpa, gpa);
 	vcpu_args_set(vcpu, 2, gpa, size);
@@ -358,8 +352,7 @@ static void test_guest_memfd_guest(void)
 
 	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
 
-	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-	TEST_ASSERT(mem != MAP_FAILED, "mmap() on guest_memfd failed");
+	mem = kvm_mmap(size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
 	for (i = 0; i < size; i++)
 		TEST_ASSERT_EQ(mem[i], 0xff);
 
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 23a506d7eca3..1c68ff0fb3fb 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -278,6 +278,31 @@ static inline bool kvm_has_cap(long cap)
 #define __KVM_SYSCALL_ERROR(_name, _ret) \
 	"%s failed, rc: %i errno: %i (%s)", (_name), (_ret), errno, strerror(errno)
 
+static inline void *__kvm_mmap(size_t size, int prot, int flags, int fd,
+			       off_t offset)
+{
+	void *mem;
+
+	mem = mmap(NULL, size, prot, flags, fd, offset);
+	TEST_ASSERT(mem != MAP_FAILED, __KVM_SYSCALL_ERROR("mmap()",
+		    (int)(unsigned long)MAP_FAILED));
+
+	return mem;
+}
+
+static inline void *kvm_mmap(size_t size, int prot, int flags, int fd)
+{
+	return __kvm_mmap(size, prot, flags, fd, 0);
+}
+
+static inline void kvm_munmap(void *mem, size_t size)
+{
+	int ret;
+
+	ret = munmap(mem, size);
+	TEST_ASSERT(!ret, __KVM_SYSCALL_ERROR("munmap()", ret));
+}
+
 /*
  * Use the "inner", double-underscore macro when reporting errors from within
  * other macros so that the name of ioctl() and not its literal numeric value
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index c3f5142b0a54..da754b152c11 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -770,13 +770,11 @@ static void vm_vcpu_rm(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 	int ret;
 
 	if (vcpu->dirty_gfns) {
-		ret = munmap(vcpu->dirty_gfns, vm->dirty_ring_size);
-		TEST_ASSERT(!ret, __KVM_SYSCALL_ERROR("munmap()", ret));
+		kvm_munmap(vcpu->dirty_gfns, vm->dirty_ring_size);
 		vcpu->dirty_gfns = NULL;
 	}
 
-	ret = munmap(vcpu->run, vcpu_mmap_sz());
-	TEST_ASSERT(!ret, __KVM_SYSCALL_ERROR("munmap()", ret));
+	kvm_munmap(vcpu->run, vcpu_mmap_sz());
 
 	ret = close(vcpu->fd);
 	TEST_ASSERT(!ret,  __KVM_SYSCALL_ERROR("close()", ret));
@@ -810,20 +808,16 @@ void kvm_vm_release(struct kvm_vm *vmp)
 static void __vm_mem_region_delete(struct kvm_vm *vm,
 				   struct userspace_mem_region *region)
 {
-	int ret;
-
 	rb_erase(&region->gpa_node, &vm->regions.gpa_tree);
 	rb_erase(&region->hva_node, &vm->regions.hva_tree);
 	hash_del(&region->slot_node);
 
 	sparsebit_free(&region->unused_phy_pages);
 	sparsebit_free(&region->protected_phy_pages);
-	ret = munmap(region->mmap_start, region->mmap_size);
-	TEST_ASSERT(!ret, __KVM_SYSCALL_ERROR("munmap()", ret));
+	kvm_munmap(region->mmap_start, region->mmap_size);
 	if (region->fd >= 0) {
 		/* There's an extra map when using shared memory. */
-		ret = munmap(region->mmap_alias, region->mmap_size);
-		TEST_ASSERT(!ret, __KVM_SYSCALL_ERROR("munmap()", ret));
+		kvm_munmap(region->mmap_alias, region->mmap_size);
 		close(region->fd);
 	}
 	if (region->region.guest_memfd >= 0)
@@ -1080,12 +1074,9 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		region->fd = kvm_memfd_alloc(region->mmap_size,
 					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
 
-	region->mmap_start = mmap(NULL, region->mmap_size,
-				  PROT_READ | PROT_WRITE,
-				  vm_mem_backing_src_alias(src_type)->flag,
-				  region->fd, 0);
-	TEST_ASSERT(region->mmap_start != MAP_FAILED,
-		    __KVM_SYSCALL_ERROR("mmap()", (int)(unsigned long)MAP_FAILED));
+	region->mmap_start = kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
+				      vm_mem_backing_src_alias(src_type)->flag,
+				      region->fd);
 
 	TEST_ASSERT(!is_backing_src_hugetlb(src_type) ||
 		    region->mmap_start == align_ptr_up(region->mmap_start, backing_src_pagesz),
@@ -1156,12 +1147,10 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 
 	/* If shared memory, create an alias. */
 	if (region->fd >= 0) {
-		region->mmap_alias = mmap(NULL, region->mmap_size,
-					  PROT_READ | PROT_WRITE,
-					  vm_mem_backing_src_alias(src_type)->flag,
-					  region->fd, 0);
-		TEST_ASSERT(region->mmap_alias != MAP_FAILED,
-			    __KVM_SYSCALL_ERROR("mmap()",  (int)(unsigned long)MAP_FAILED));
+		region->mmap_alias = kvm_mmap(region->mmap_size,
+					      PROT_READ | PROT_WRITE,
+					      vm_mem_backing_src_alias(src_type)->flag,
+					      region->fd);
 
 		/* Align host alias address */
 		region->host_alias = align_ptr_up(region->mmap_alias, alignment);
@@ -1371,10 +1360,8 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
 	TEST_ASSERT(vcpu_mmap_sz() >= sizeof(*vcpu->run), "vcpu mmap size "
 		"smaller than expected, vcpu_mmap_sz: %i expected_min: %zi",
 		vcpu_mmap_sz(), sizeof(*vcpu->run));
-	vcpu->run = (struct kvm_run *) mmap(NULL, vcpu_mmap_sz(),
-		PROT_READ | PROT_WRITE, MAP_SHARED, vcpu->fd, 0);
-	TEST_ASSERT(vcpu->run != MAP_FAILED,
-		    __KVM_SYSCALL_ERROR("mmap()", (int)(unsigned long)MAP_FAILED));
+	vcpu->run = kvm_mmap(vcpu_mmap_sz(), PROT_READ | PROT_WRITE,
+			     MAP_SHARED, vcpu->fd);
 
 	if (kvm_has_cap(KVM_CAP_BINARY_STATS_FD))
 		vcpu->stats.fd = vcpu_get_stats_fd(vcpu);
@@ -1821,9 +1808,8 @@ void *vcpu_map_dirty_ring(struct kvm_vcpu *vcpu)
 			    page_size * KVM_DIRTY_LOG_PAGE_OFFSET);
 		TEST_ASSERT(addr == MAP_FAILED, "Dirty ring mapped exec");
 
-		addr = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, vcpu->fd,
-			    page_size * KVM_DIRTY_LOG_PAGE_OFFSET);
-		TEST_ASSERT(addr != MAP_FAILED, "Dirty ring map failed");
+		addr = __kvm_mmap(size, PROT_READ | PROT_WRITE, MAP_SHARED, vcpu->fd,
+				  page_size * KVM_DIRTY_LOG_PAGE_OFFSET);
 
 		vcpu->dirty_gfns = addr;
 		vcpu->dirty_gfns_count = size / sizeof(struct kvm_dirty_gfn);
diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 6a437d2be9fa..37b7e6524533 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -339,8 +339,7 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(max_gpa > (4 * slot_size), "MAXPHYADDR <4gb ");
 
 	fd = kvm_memfd_alloc(slot_size, hugepages);
-	mem = mmap(NULL, slot_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-	TEST_ASSERT(mem != MAP_FAILED, "mmap() failed");
+	mem = kvm_mmap(slot_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
 
 	TEST_ASSERT(!madvise(mem, slot_size, MADV_NOHUGEPAGE), "madvise() failed");
 
@@ -413,7 +412,7 @@ int main(int argc, char *argv[])
 	for (slot = (slot - 1) & ~1ull; slot >= first_slot; slot -= 2)
 		vm_set_user_memory_region(vm, slot, 0, 0, 0, NULL);
 
-	munmap(mem, slot_size / 2);
+	kvm_munmap(mem, slot_size / 2);
 
 	/* Sanity check that the vCPUs actually ran. */
 	for (i = 0; i < nr_vcpus; i++)
diff --git a/tools/testing/selftests/kvm/s390/ucontrol_test.c b/tools/testing/selftests/kvm/s390/ucontrol_test.c
index d265b34c54be..50bc1c38225a 100644
--- a/tools/testing/selftests/kvm/s390/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390/ucontrol_test.c
@@ -142,19 +142,17 @@ FIXTURE_SETUP(uc_kvm)
 	self->kvm_run_size = ioctl(self->kvm_fd, KVM_GET_VCPU_MMAP_SIZE, NULL);
 	ASSERT_GE(self->kvm_run_size, sizeof(struct kvm_run))
 		  TH_LOG(KVM_IOCTL_ERROR(KVM_GET_VCPU_MMAP_SIZE, self->kvm_run_size));
-	self->run = (struct kvm_run *)mmap(NULL, self->kvm_run_size,
-		    PROT_READ | PROT_WRITE, MAP_SHARED, self->vcpu_fd, 0);
-	ASSERT_NE(self->run, MAP_FAILED);
+	self->run = kvm_mmap(self->kvm_run_size, PROT_READ | PROT_WRITE,
+			     MAP_SHARED, self->vcpu_fd);
 	/**
 	 * For virtual cpus that have been created with S390 user controlled
 	 * virtual machines, the resulting vcpu fd can be memory mapped at page
 	 * offset KVM_S390_SIE_PAGE_OFFSET in order to obtain a memory map of
 	 * the virtual cpu's hardware control block.
 	 */
-	self->sie_block = (struct kvm_s390_sie_block *)mmap(NULL, PAGE_SIZE,
-			  PROT_READ | PROT_WRITE, MAP_SHARED,
-			  self->vcpu_fd, KVM_S390_SIE_PAGE_OFFSET << PAGE_SHIFT);
-	ASSERT_NE(self->sie_block, MAP_FAILED);
+	self->sie_block = __kvm_mmap(PAGE_SIZE, PROT_READ | PROT_WRITE,
+				     MAP_SHARED, self->vcpu_fd,
+				     KVM_S390_SIE_PAGE_OFFSET << PAGE_SHIFT);
 
 	TH_LOG("VM created %p %p", self->run, self->sie_block);
 
@@ -186,8 +184,8 @@ FIXTURE_SETUP(uc_kvm)
 
 FIXTURE_TEARDOWN(uc_kvm)
 {
-	munmap(self->sie_block, PAGE_SIZE);
-	munmap(self->run, self->kvm_run_size);
+	kvm_munmap(self->sie_block, PAGE_SIZE);
+	kvm_munmap(self->run, self->kvm_run_size);
 	close(self->vcpu_fd);
 	close(self->vm_fd);
 	close(self->kvm_fd);
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index ce3ac0fd6dfb..7fe427ff9b38 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -433,10 +433,10 @@ static void test_add_max_memory_regions(void)
 	pr_info("Adding slots 0..%i, each memory region with %dK size\n",
 		(max_mem_slots - 1), MEM_REGION_SIZE >> 10);
 
-	mem = mmap(NULL, (size_t)max_mem_slots * MEM_REGION_SIZE + alignment,
-		   PROT_READ | PROT_WRITE,
-		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
-	TEST_ASSERT(mem != MAP_FAILED, "Failed to mmap() host");
+
+	mem = kvm_mmap((size_t)max_mem_slots * MEM_REGION_SIZE + alignment,
+		       PROT_READ | PROT_WRITE,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1);
 	mem_aligned = (void *)(((size_t) mem + alignment - 1) & ~(alignment - 1));
 
 	for (slot = 0; slot < max_mem_slots; slot++)
@@ -446,9 +446,8 @@ static void test_add_max_memory_regions(void)
 					  mem_aligned + (uint64_t)slot * MEM_REGION_SIZE);
 
 	/* Check it cannot be added memory slots beyond the limit */
-	mem_extra = mmap(NULL, MEM_REGION_SIZE, PROT_READ | PROT_WRITE,
-			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-	TEST_ASSERT(mem_extra != MAP_FAILED, "Failed to mmap() host");
+	mem_extra = kvm_mmap(MEM_REGION_SIZE, PROT_READ | PROT_WRITE,
+			     MAP_PRIVATE | MAP_ANONYMOUS, -1);
 
 	ret = __vm_set_user_memory_region(vm, max_mem_slots, 0,
 					  (uint64_t)max_mem_slots * MEM_REGION_SIZE,
@@ -456,8 +455,8 @@ static void test_add_max_memory_regions(void)
 	TEST_ASSERT(ret == -1 && errno == EINVAL,
 		    "Adding one more memory slot should fail with EINVAL");
 
-	munmap(mem, (size_t)max_mem_slots * MEM_REGION_SIZE + alignment);
-	munmap(mem_extra, MEM_REGION_SIZE);
+	kvm_munmap(mem, (size_t)max_mem_slots * MEM_REGION_SIZE + alignment);
+	kvm_munmap(mem_extra, MEM_REGION_SIZE);
 	kvm_vm_free(vm);
 }
 
-- 
2.51.0.536.g15c5d4f767-goog


