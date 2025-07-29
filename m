Return-Path: <linux-kernel+bounces-749124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC800B14A68
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4DC1AA085B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC0828641C;
	Tue, 29 Jul 2025 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="FhSkqwt0"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C242F281525
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778901; cv=none; b=TZ5h3GnQ2Pdhas/5KBEIb8UQo1sDjyTCwfPE/LqLCJ4oRaKnum+mvPZZBEgxk5COV7p2+Elmlw9wbk1cA20Xm5SyCJYYiCV4eFafLOEFBKlGF66bNw/QVmka8nzgrNsEdJti8D2wue6OVvDOszBVn9SEjr8aJtfdVcaUvLKcMpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778901; c=relaxed/simple;
	bh=CzfVOeOWVqaknp53Rz/3Ro0C/F4X8MQKFsFvT1rYJ/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=byxxKaYXmx0x5FXI+9ryg1lMv1E+QJNbF6/ObEdIjUZD80sioN0OSX1gFDrdHY0Fe59hkUwLruRhIMqSfrV1fZOyP6Q0xyzYU0XJUDS/9CGrVXuA2sDBhBHJ1LwomU92hG1P3x2Es+3irjF50efynEpls5i+nmRx+X14l5K+80o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=FhSkqwt0; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1753778838;
	bh=VLq1PupNl4epQ/eqFgJeI/b4qy5mdRvi3g/owsVSuA0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=FhSkqwt0nnPtAqm4q6BL39Jc3uxBS83jgcblHf5g0aqL3IzQBIZAoJIo5hkgPPTH3
	 Jh4twdN2KH0rIeM0/PXyxbIuucpH7yIUzewM7GzlAiAB7D1+vuCeHHtjDmjmjffgn2
	 seym/xN47xtjMvsj1hIbtGmwP6xnRS03ulKDDPzE=
X-QQ-mid: zesmtpip3t1753778825te45995f8
X-QQ-Originating-IP: tSCf3VyPzUnUetiPvgXt758R68S3WC3VgNrI2JAXLJI=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 29 Jul 2025 16:47:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3458122844410139732
EX-QQ-RecipientCnt: 12
From: WangYuli <wangyuli@uniontech.com>
To: akpm@linux-foundation.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	pfalcato@suse.de
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>,
	Jun Zhan <zhanjun@uniontech.com>
Subject: [PATCH] tools/testing/vma: Fix function parameter declarations for GCC 8.3 compatibility
Date: Tue, 29 Jul 2025 16:47:00 +0800
Message-ID: <EFCEBE7E301589DE+20250729084700.208767-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NDxI9psdf3YV3rs/Uk6soLGD5nAjI0/HXoDZ1p+2PYOPR2S2BFwIibmh
	CsHbRkqMIPPkdWlFG5rjNvMG3WCYiXfHAj/PRqmur0tduhq9srmvTgKSRkimY4t/YPdDPF0
	aO1qB6b4KrJRZF3VethuVNe4VvoyAeugA+JOFpYXos+CpcOLNFXVz8+qCRX8bAEgPEqpeS1
	5SsFOnFWklX6AqoV+n0yFFP4MNXFmOfe1ngHweLQq7nqEZUK+hHxxU1ros2mbMFg/ARRJ8x
	7cVIbCkrkQYku9hU2+570PZUT0EYZ8SGWeFZEJEBOYtMK+N05OkIldnBdmrQ+bsMh1C8gMW
	FUCiYN1YkMX/uKRj/c/gM6D4n8JiG+06b17Mzi7TGCeduD4kyZ5mMMycXglG3hayVz9QUOd
	Ac2x1erNlzJdS6Zv3DkeuOHo6Wse6jzyKMBBg8M+j+kAr7KwQirVv0F0bzZulxcVVKa8YW9
	uesQToaiRpufzuXV1bZpWQy6vx70y/OCNy9czIJLyOYl0566tsTryX3jb0zcntJM1KueyZv
	isn0nPjvq9nUS/hfvEB7a8aQRFFSzkTl06Zrqe5UYNFC2fyQUehdiLH6KtVSkTOalofpxpG
	iSNTvTcBduH+STk51QwuvgC/ml130x8CoDRbezdTcfqgfVl/5gCWBRat7oJcW12GZVpig+r
	dr7SOkzrPU6+q7/xsnDkcpko6iApNNTChMCpMEhTO20HcXI79bqgXJromyaP6dxWQiNkYem
	YthoLCIdKm0HPHOu2X4YDDvh7ZJVP8c5aFLiGPpGPFmsZLTqTI6SjpW++QhakaCd3X5GQCl
	/9S+8vEbqhUTvpiuOG/08a8x5nrimNoaUKYgx308FKnAed4vjADTzglwlnab8WBLIJyFSTk
	/NUFeB20u8mEQcsHpwQs083W8dvHfWHJImgKyV3SFGto/9Tyhj3UkSZe2rvytmRQKpsknwC
	34o1i8rFPXvRb74CC5bLSdU0Jh693hznUYKdxyJoas1IS8uskbBxHFu01e4ulKybOI78+3Q
	m6M9ZFdYkwzHg6UTgD
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

The Linux kernel's minimum GCC version requirement has been bumped
from 4.3 to 8.3, but this tool still fails to compile with GCC 8.3.

Older compilers would fail if did not include parameter names in
function declarations that contained parameter types; newer compilers
are more lenient about this.

Fix many errors like this:
  In file included from vma.c:10:
  vma_internal.h: In function ‘arch_validate_flags’:
  vma_internal.h:1218:40: error: parameter name omitted
   static inline bool arch_validate_flags(unsigned long)
                                        ^~~~~~~~~~~~~
  vma.c: In function ‘dummy_close’:
  vma.c:281:25: error: parameter name omitted
   static void dummy_close(struct vm_area_struct *)
                         ^~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Jun Zhan <zhanjun@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 tools/testing/vma/vma.c          |   2 +-
 tools/testing/vma/vma_internal.h | 110 +++++++++++++++----------------
 2 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 2be7597a2ac2..390b6a711f97 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -278,7 +278,7 @@ static bool vma_write_started(struct vm_area_struct *vma)
 }
 
 /* Helper function providing a dummy vm_ops->close() method.*/
-static void dummy_close(struct vm_area_struct *)
+static void dummy_close(struct vm_area_struct *vma)
 {
 }
 
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 816e7e057585..4935460102e5 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -288,8 +288,8 @@ struct vm_area_desc {
 };
 
 struct file_operations {
-	int (*mmap)(struct file *, struct vm_area_struct *);
-	int (*mmap_prepare)(struct vm_area_desc *);
+	int (*mmap)(struct file *file, struct vm_area_struct *vma);
+	int (*mmap_prepare)(struct vm_area_desc *desc);
 };
 
 struct file {
@@ -840,11 +840,11 @@ static inline unsigned long vma_pages(struct vm_area_struct *vma)
 	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 }
 
-static inline void fput(struct file *)
+static inline void fput(struct file *file)
 {
 }
 
-static inline void mpol_put(struct mempolicy *)
+static inline void mpol_put(struct mempolicy *policy)
 {
 }
 
@@ -852,15 +852,15 @@ static inline void lru_add_drain(void)
 {
 }
 
-static inline void tlb_gather_mmu(struct mmu_gather *, struct mm_struct *)
+static inline void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm)
 {
 }
 
-static inline void update_hiwater_rss(struct mm_struct *)
+static inline void update_hiwater_rss(struct mm_struct *mm)
 {
 }
 
-static inline void update_hiwater_vm(struct mm_struct *)
+static inline void update_hiwater_vm(struct mm_struct *mm)
 {
 }
 
@@ -890,15 +890,15 @@ static inline void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 	(void)mm_wr_locked;
 }
 
-static inline void mapping_unmap_writable(struct address_space *)
+static inline void mapping_unmap_writable(struct address_space *mapping)
 {
 }
 
-static inline void flush_dcache_mmap_lock(struct address_space *)
+static inline void flush_dcache_mmap_lock(struct address_space *mapping)
 {
 }
 
-static inline void tlb_finish_mmu(struct mmu_gather *)
+static inline void tlb_finish_mmu(struct mmu_gather *tlb)
 {
 }
 
@@ -907,7 +907,7 @@ static inline struct file *get_file(struct file *f)
 	return f;
 }
 
-static inline int vma_dup_policy(struct vm_area_struct *, struct vm_area_struct *)
+static inline int vma_dup_policy(struct vm_area_struct *dst, struct vm_area_struct *src)
 {
 	return 0;
 }
@@ -940,7 +940,7 @@ static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
 	(void)next;
 }
 
-static inline void hugetlb_split(struct vm_area_struct *, unsigned long) {}
+static inline void hugetlb_split(struct vm_area_struct *vma, unsigned long addr) {}
 
 static inline void vma_iter_free(struct vma_iterator *vmi)
 {
@@ -957,31 +957,31 @@ static inline void vm_acct_memory(long pages)
 {
 }
 
-static inline void vma_interval_tree_insert(struct vm_area_struct *,
-					    struct rb_root_cached *)
+static inline void vma_interval_tree_insert(struct vm_area_struct *vma,
+					    struct rb_root_cached *root)
 {
 }
 
-static inline void vma_interval_tree_remove(struct vm_area_struct *,
-					    struct rb_root_cached *)
+static inline void vma_interval_tree_remove(struct vm_area_struct *vma,
+					    struct rb_root_cached *root)
 {
 }
 
-static inline void flush_dcache_mmap_unlock(struct address_space *)
+static inline void flush_dcache_mmap_unlock(struct address_space *mapping)
 {
 }
 
-static inline void anon_vma_interval_tree_insert(struct anon_vma_chain*,
-						 struct rb_root_cached *)
+static inline void anon_vma_interval_tree_insert(struct anon_vma_chain *avc,
+						 struct rb_root_cached *root)
 {
 }
 
-static inline void anon_vma_interval_tree_remove(struct anon_vma_chain*,
-						 struct rb_root_cached *)
+static inline void anon_vma_interval_tree_remove(struct anon_vma_chain *avc,
+						 struct rb_root_cached *root)
 {
 }
 
-static inline void uprobe_mmap(struct vm_area_struct *)
+static inline void uprobe_mmap(struct vm_area_struct *vma)
 {
 }
 
@@ -993,15 +993,15 @@ static inline void uprobe_munmap(struct vm_area_struct *vma,
 	(void)end;
 }
 
-static inline void i_mmap_lock_write(struct address_space *)
+static inline void i_mmap_lock_write(struct address_space *mapping)
 {
 }
 
-static inline void anon_vma_lock_write(struct anon_vma *)
+static inline void anon_vma_lock_write(struct anon_vma *anon_vma)
 {
 }
 
-static inline void vma_assert_write_locked(struct vm_area_struct *)
+static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
 }
 
@@ -1011,16 +1011,16 @@ static inline void unlink_anon_vmas(struct vm_area_struct *vma)
 	vma->anon_vma->was_unlinked = true;
 }
 
-static inline void anon_vma_unlock_write(struct anon_vma *)
+static inline void anon_vma_unlock_write(struct anon_vma *anon_vma)
 {
 }
 
-static inline void i_mmap_unlock_write(struct address_space *)
+static inline void i_mmap_unlock_write(struct address_space *mapping)
 {
 }
 
-static inline void anon_vma_merge(struct vm_area_struct *,
-				  struct vm_area_struct *)
+static inline void anon_vma_merge(struct vm_area_struct *vma,
+				  struct vm_area_struct *prev)
 {
 }
 
@@ -1037,19 +1037,19 @@ static inline int userfaultfd_unmap_prep(struct vm_area_struct *vma,
 	return 0;
 }
 
-static inline void mmap_write_downgrade(struct mm_struct *)
+static inline void mmap_write_downgrade(struct mm_struct *mm)
 {
 }
 
-static inline void mmap_read_unlock(struct mm_struct *)
+static inline void mmap_read_unlock(struct mm_struct *mm)
 {
 }
 
-static inline void mmap_write_unlock(struct mm_struct *)
+static inline void mmap_write_unlock(struct mm_struct *mm)
 {
 }
 
-static inline int mmap_write_lock_killable(struct mm_struct *)
+static inline int mmap_write_lock_killable(struct mm_struct *mm)
 {
 	return 0;
 }
@@ -1074,11 +1074,11 @@ static inline void arch_unmap(struct mm_struct *mm,
 	(void)end;
 }
 
-static inline void mmap_assert_locked(struct mm_struct *)
+static inline void mmap_assert_locked(struct mm_struct *mm)
 {
 }
 
-static inline bool mpol_equal(struct mempolicy *, struct mempolicy *)
+static inline bool mpol_equal(struct mempolicy *a, struct mempolicy *b)
 {
 	return true;
 }
@@ -1090,59 +1090,59 @@ static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
 	(void)vm_flags;
 }
 
-static inline bool mapping_can_writeback(struct address_space *)
+static inline bool mapping_can_writeback(struct address_space *mapping)
 {
 	return true;
 }
 
-static inline bool is_vm_hugetlb_page(struct vm_area_struct *)
+static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
 {
 	return false;
 }
 
-static inline bool vma_soft_dirty_enabled(struct vm_area_struct *)
+static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 {
 	return false;
 }
 
-static inline bool userfaultfd_wp(struct vm_area_struct *)
+static inline bool userfaultfd_wp(struct vm_area_struct *vma)
 {
 	return false;
 }
 
-static inline void mmap_assert_write_locked(struct mm_struct *)
+static inline void mmap_assert_write_locked(struct mm_struct *mm)
 {
 }
 
-static inline void mutex_lock(struct mutex *)
+static inline void mutex_lock(struct mutex *lock)
 {
 }
 
-static inline void mutex_unlock(struct mutex *)
+static inline void mutex_unlock(struct mutex *lock)
 {
 }
 
-static inline bool mutex_is_locked(struct mutex *)
+static inline bool mutex_is_locked(struct mutex *lock)
 {
 	return true;
 }
 
-static inline bool signal_pending(void *)
+static inline bool signal_pending(void *task)
 {
 	return false;
 }
 
-static inline bool is_file_hugepages(struct file *)
+static inline bool is_file_hugepages(struct file *file)
 {
 	return false;
 }
 
-static inline int security_vm_enough_memory_mm(struct mm_struct *, long)
+static inline int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
 	return 0;
 }
 
-static inline bool may_expand_vm(struct mm_struct *, vm_flags_t, unsigned long)
+static inline bool may_expand_vm(struct mm_struct *mm, vm_flags_t flags, unsigned long npages)
 {
 	return true;
 }
@@ -1167,7 +1167,7 @@ static inline void vm_flags_clear(struct vm_area_struct *vma,
 	vma->__vm_flags &= ~flags;
 }
 
-static inline int shmem_zero_setup(struct vm_area_struct *)
+static inline int shmem_zero_setup(struct vm_area_struct *vma)
 {
 	return 0;
 }
@@ -1177,20 +1177,20 @@ static inline void vma_set_anonymous(struct vm_area_struct *vma)
 	vma->vm_ops = NULL;
 }
 
-static inline void ksm_add_vma(struct vm_area_struct *)
+static inline void ksm_add_vma(struct vm_area_struct *vma)
 {
 }
 
-static inline void perf_event_mmap(struct vm_area_struct *)
+static inline void perf_event_mmap(struct vm_area_struct *vma)
 {
 }
 
-static inline bool vma_is_dax(struct vm_area_struct *)
+static inline bool vma_is_dax(struct vm_area_struct *vma)
 {
 	return false;
 }
 
-static inline struct vm_area_struct *get_gate_vma(struct mm_struct *)
+static inline struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
 {
 	return NULL;
 }
@@ -1215,16 +1215,16 @@ static inline void vma_set_page_prot(struct vm_area_struct *vma)
 	WRITE_ONCE(vma->vm_page_prot, vm_page_prot);
 }
 
-static inline bool arch_validate_flags(unsigned long)
+static inline bool arch_validate_flags(unsigned long flags)
 {
 	return true;
 }
 
-static inline void vma_close(struct vm_area_struct *)
+static inline void vma_close(struct vm_area_struct *vma)
 {
 }
 
-static inline int mmap_file(struct file *, struct vm_area_struct *)
+static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
 {
 	return 0;
 }
-- 
2.50.0


