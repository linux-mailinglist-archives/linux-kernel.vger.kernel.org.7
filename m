Return-Path: <linux-kernel+bounces-841467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06C7BB7681
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 17:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62393C21AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE7F288C2B;
	Fri,  3 Oct 2025 15:53:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CAA28851F
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759506799; cv=none; b=RRoeb3QS3Aj2ZtlL/f4N4me8adwSq8rN5nvrjKjJhrhDkt0XjpERCmt8TN2p4ZKI0GPWVcdG1X0CRwo9xTGboTOsIk2gyAo3qlvqJdpb1TDiSxMVWUv9OEK36ZmReoPzY09QI8hPW+HBHncmdAyp6r5I1ZaFglkPkdsQt6zon4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759506799; c=relaxed/simple;
	bh=948T6y+SoAB/1fb2XTfAsCv/cL83Psx5xDVckQ70ewk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oR8VgM223QNxolSihQ8J6/kSwGNGdH+dX3351ljeJGuDIHNIvNZdhoO/YuN212vpLnmxKO+DIGbr8PGmeEYIjwBTA6nrGRZdYDbXPR+S6X9znWprhKk2MHR3Y4Lfn3pKbcojq+3m1S8V/xOQZWLIQT5pDdbsgY1YCd7u2ggSyfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E39A1688;
	Fri,  3 Oct 2025 08:53:07 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5EAF3F5A1;
	Fri,  3 Oct 2025 08:53:13 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm: Consistently use current->mm in mm_get_unmapped_area()
Date: Fri,  3 Oct 2025 16:53:04 +0100
Message-ID: <20251003155306.2147572-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mm_get_unmapped_area() is a wrapper around arch_get_unmapped_area() /
arch_get_unmapped_area_topdown(), both of which search current->mm for
some free space. Neither take an mm_struct - they implicitly operate on
current->mm.

But the wrapper takes an mm_struct and uses it to decide whether to
search bottom up or top down. All callers pass in current->mm for this,
so everything is working consistently. But it feels like an accident
waiting to happen; eventually someone will call that function with a
different mm, expecting to find free space in it, but what gets returned
is free space in the current mm.

So let's simplify by removing the parameter and have the wrapper use
current->mm to decide which end to start at. Now everything is
consistent and self-documenting.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
Applies against today's mm-unstable (aa05a436eca8).

Build tested on arm64, x86 and Sparc. mm selftests show no regressions.

Thanks,
Ryan

 arch/sparc/kernel/sys_sparc_64.c |  6 +++---
 arch/x86/kernel/cpu/sgx/driver.c |  2 +-
 drivers/char/mem.c               |  2 +-
 drivers/dax/device.c             |  5 ++---
 fs/hugetlbfs/inode.c             |  3 +--
 fs/proc/inode.c                  |  2 +-
 fs/ramfs/file-mmu.c              |  2 +-
 include/linux/sched/mm.h         |  9 ++++-----
 io_uring/memmap.c                |  2 +-
 kernel/bpf/arena.c               |  2 +-
 kernel/bpf/syscall.c             |  2 +-
 mm/huge_memory.c                 |  4 ++--
 mm/mmap.c                        | 17 +++++++----------
 mm/shmem.c                       |  8 +++-----
 14 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 55faf2effa46..dbf118b40601 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -241,7 +241,7 @@ unsigned long get_fb_unmapped_area(struct file *filp, unsigned long orig_addr, u

 	if (flags & MAP_FIXED) {
 		/* Ok, don't mess with it. */
-		return mm_get_unmapped_area(current->mm, NULL, orig_addr, len, pgoff, flags);
+		return mm_get_unmapped_area(NULL, orig_addr, len, pgoff, flags);
 	}
 	flags &= ~MAP_SHARED;

@@ -254,7 +254,7 @@ unsigned long get_fb_unmapped_area(struct file *filp, unsigned long orig_addr, u
 		align_goal = (64UL * 1024);

 	do {
-		addr = mm_get_unmapped_area(current->mm, NULL, orig_addr,
+		addr = mm_get_unmapped_area(NULL, orig_addr,
 					    len + (align_goal - PAGE_SIZE), pgoff, flags);
 		if (!(addr & ~PAGE_MASK)) {
 			addr = (addr + (align_goal - 1UL)) & ~(align_goal - 1UL);
@@ -273,7 +273,7 @@ unsigned long get_fb_unmapped_area(struct file *filp, unsigned long orig_addr, u
 	 * be obtained.
 	 */
 	if (addr & ~PAGE_MASK)
-		addr = mm_get_unmapped_area(current->mm, NULL, orig_addr, len, pgoff, flags);
+		addr = mm_get_unmapped_area(NULL, orig_addr, len, pgoff, flags);

 	return addr;
 }
diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index 7f8d1e11dbee..3b3efadb8cae 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -113,7 +113,7 @@ static unsigned long sgx_get_unmapped_area(struct file *file,
 	if (flags & MAP_FIXED)
 		return addr;

-	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
+	return mm_get_unmapped_area(file, addr, len, pgoff, flags);
 }

 #ifdef CONFIG_COMPAT
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 34b815901b20..db1ca53a6d01 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -542,7 +542,7 @@ static unsigned long get_unmapped_area_zero(struct file *file,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	return thp_get_unmapped_area(file, addr, len, pgoff, flags);
 #else
-	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
+	return mm_get_unmapped_area(file, addr, len, pgoff, flags);
 #endif
 }
 #endif /* CONFIG_MMU */
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 2bb40a6060af..7f1ed0db8337 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -330,14 +330,13 @@ static unsigned long dax_get_unmapped_area(struct file *filp,
 	if ((off + len_align) < off)
 		goto out;

-	addr_align = mm_get_unmapped_area(current->mm, filp, addr, len_align,
-					  pgoff, flags);
+	addr_align = mm_get_unmapped_area(filp, addr, len_align, pgoff, flags);
 	if (!IS_ERR_VALUE(addr_align)) {
 		addr_align += (off - addr_align) & (align - 1);
 		return addr_align;
 	}
  out:
-	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff, flags);
+	return mm_get_unmapped_area(filp, addr, len, pgoff, flags);
 }

 static const struct address_space_operations dev_dax_aops = {
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9c94ed8c3ab0..7a39ac93495f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -184,8 +184,7 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	if (addr)
 		addr0 = ALIGN(addr, huge_page_size(h));

-	return mm_get_unmapped_area_vmflags(current->mm, file, addr0, len, pgoff,
-					    flags, 0);
+	return mm_get_unmapped_area_vmflags(file, addr0, len, pgoff, flags, 0);
 }

 /*
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 129490151be1..a1968821a55d 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -443,7 +443,7 @@ pde_get_unmapped_area(struct proc_dir_entry *pde, struct file *file, unsigned lo
 		return pde->proc_ops->proc_get_unmapped_area(file, orig_addr, len, pgoff, flags);

 #ifdef CONFIG_MMU
-	return mm_get_unmapped_area(current->mm, file, orig_addr, len, pgoff, flags);
+	return mm_get_unmapped_area(file, orig_addr, len, pgoff, flags);
 #endif

 	return orig_addr;
diff --git a/fs/ramfs/file-mmu.c b/fs/ramfs/file-mmu.c
index b11f5b20b78b..c3ed1c5117b2 100644
--- a/fs/ramfs/file-mmu.c
+++ b/fs/ramfs/file-mmu.c
@@ -35,7 +35,7 @@ static unsigned long ramfs_mmu_get_unmapped_area(struct file *file,
 		unsigned long addr, unsigned long len, unsigned long pgoff,
 		unsigned long flags)
 {
-	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
+	return mm_get_unmapped_area(file, addr, len, pgoff, flags);
 }

 const struct file_operations ramfs_file_operations = {
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 0232d983b715..89274cb5daf3 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -189,12 +189,11 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 			       unsigned long len, unsigned long pgoff,
 			       unsigned long flags, vm_flags_t);

-unsigned long mm_get_unmapped_area(struct mm_struct *mm, struct file *filp,
-				   unsigned long addr, unsigned long len,
-				   unsigned long pgoff, unsigned long flags);
+unsigned long mm_get_unmapped_area(struct file *filp, unsigned long addr,
+				   unsigned long len, unsigned long pgoff,
+				   unsigned long flags);

-unsigned long mm_get_unmapped_area_vmflags(struct mm_struct *mm,
-					   struct file *filp,
+unsigned long mm_get_unmapped_area_vmflags(struct file *filp,
 					   unsigned long addr,
 					   unsigned long len,
 					   unsigned long pgoff,
diff --git a/io_uring/memmap.c b/io_uring/memmap.c
index 2e99dffddfc5..55984007eabf 100644
--- a/io_uring/memmap.c
+++ b/io_uring/memmap.c
@@ -387,7 +387,7 @@ unsigned long io_uring_get_unmapped_area(struct file *filp, unsigned long addr,
 #else
 	addr = 0UL;
 #endif
-	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff, flags);
+	return mm_get_unmapped_area(filp, addr, len, pgoff, flags);
 }

 #else /* !CONFIG_MMU */
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 5b37753799d2..11f6543c4a07 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -334,7 +334,7 @@ static unsigned long arena_get_unmapped_area(struct file *filp, unsigned long ad
 			return -EINVAL;
 	}

-	ret = mm_get_unmapped_area(current->mm, filp, addr, len * 2, 0, flags);
+	ret = mm_get_unmapped_area(filp, addr, len * 2, 0, flags);
 	if (IS_ERR_VALUE(ret))
 		return ret;
 	if ((ret >> 32) == ((ret + len - 1) >> 32))
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0fbfa8532c39..7afd94172765 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1132,7 +1132,7 @@ static unsigned long bpf_get_unmapped_area(struct file *filp, unsigned long addr
 	if (map->ops->map_get_unmapped_area)
 		return map->ops->map_get_unmapped_area(filp, addr, len, pgoff, flags);
 #ifdef CONFIG_MMU
-	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff, flags);
+	return mm_get_unmapped_area(filp, addr, len, pgoff, flags);
 #else
 	return addr;
 #endif
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1b81680b4225..8b44f026a0b1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1126,7 +1126,7 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
 	if (len_pad < len || (off + len_pad) < off)
 		return 0;

-	ret = mm_get_unmapped_area_vmflags(current->mm, filp, addr, len_pad,
+	ret = mm_get_unmapped_area_vmflags(filp, addr, len_pad,
 					   off >> PAGE_SHIFT, flags, vm_flags);

 	/*
@@ -1163,7 +1163,7 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
 	if (ret)
 		return ret;

-	return mm_get_unmapped_area_vmflags(current->mm, filp, addr, len, pgoff, flags,
+	return mm_get_unmapped_area_vmflags(filp, addr, len, pgoff, flags,
 					    vm_flags);
 }

diff --git a/mm/mmap.c b/mm/mmap.c
index 5fd3b80fda1d..644f02071a41 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -797,12 +797,11 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 }
 #endif

-unsigned long mm_get_unmapped_area_vmflags(struct mm_struct *mm, struct file *filp,
-					   unsigned long addr, unsigned long len,
-					   unsigned long pgoff, unsigned long flags,
-					   vm_flags_t vm_flags)
+unsigned long mm_get_unmapped_area_vmflags(struct file *filp, unsigned long addr,
+					   unsigned long len, unsigned long pgoff,
+					   unsigned long flags, vm_flags_t vm_flags)
 {
-	if (mm_flags_test(MMF_TOPDOWN, mm))
+	if (mm_flags_test(MMF_TOPDOWN, current->mm))
 		return arch_get_unmapped_area_topdown(filp, addr, len, pgoff,
 						      flags, vm_flags);
 	return arch_get_unmapped_area(filp, addr, len, pgoff, flags, vm_flags);
@@ -848,7 +847,7 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		addr = thp_get_unmapped_area_vmflags(file, addr, len,
 						     pgoff, flags, vm_flags);
 	} else {
-		addr = mm_get_unmapped_area_vmflags(current->mm, file, addr, len,
+		addr = mm_get_unmapped_area_vmflags(file, addr, len,
 						    pgoff, flags, vm_flags);
 	}
 	if (IS_ERR_VALUE(addr))
@@ -864,12 +863,10 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 }

 unsigned long
-mm_get_unmapped_area(struct mm_struct *mm, struct file *file,
-		     unsigned long addr, unsigned long len,
+mm_get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		     unsigned long pgoff, unsigned long flags)
 {
-	return mm_get_unmapped_area_vmflags(mm, file, addr, len,
-					    pgoff, flags, 0);
+	return mm_get_unmapped_area_vmflags(file, addr, len, pgoff, flags, 0);
 }
 EXPORT_SYMBOL(mm_get_unmapped_area);

diff --git a/mm/shmem.c b/mm/shmem.c
index 7db01567b645..354ea20384fa 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2756,8 +2756,7 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 	if (len > TASK_SIZE)
 		return -ENOMEM;

-	addr = mm_get_unmapped_area(current->mm, file, uaddr, len, pgoff,
-				    flags);
+	addr = mm_get_unmapped_area(file, uaddr, len, pgoff, flags);

 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		return addr;
@@ -2835,8 +2834,7 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 	if (inflated_len < len)
 		return addr;

-	inflated_addr = mm_get_unmapped_area(current->mm, NULL, uaddr,
-					     inflated_len, 0, flags);
+	inflated_addr = mm_get_unmapped_area(NULL, uaddr, inflated_len, 0, flags);
 	if (IS_ERR_VALUE(inflated_addr))
 		return addr;
 	if (inflated_addr & ~PAGE_MASK)
@@ -5772,7 +5770,7 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 				      unsigned long addr, unsigned long len,
 				      unsigned long pgoff, unsigned long flags)
 {
-	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
+	return mm_get_unmapped_area(file, addr, len, pgoff, flags);
 }
 #endif

--
2.43.0


