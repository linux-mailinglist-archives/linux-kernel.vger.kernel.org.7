Return-Path: <linux-kernel+bounces-841601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A3FBB7CCE
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B5604EE63E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8B329E117;
	Fri,  3 Oct 2025 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT5n4jtm"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2DD3594F
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513576; cv=none; b=FIYyP/MyypN/gNqvS71CDYgZNLzh7oxVbR1eXQFFeuz+7NEApQVZB/8LIpLXYVFwQB863RoLQ6KE6iX+wuLSFF+O2zZyVhe0rxsuzZDmeQIvH+TniiHbEqPfN6rkSmLhlJSjAbbp3P3oHPdoJ//LQTVOZcKf9nlJV/vBRZDfAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513576; c=relaxed/simple;
	bh=Zd7/p905Jif2sRMSAaHOPk+IGg+QMJ7g09k0XzShdxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YOIbN/oS9KyrPjec9KK5oFPbTvP3e/JHyndsoRFRfUzrh++TmROyI9ggkBXUmr0VcFSA/pz6jhCjd5JWi2dshf/jeSkc/bHgCPev7qP3ObL6PU06hT60Mw881XbCwRXxsWV1juPKKPo7Y8PwEI7qRk3W8mTFrgYWoMmiAwa9+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT5n4jtm; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso3093122a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759513574; x=1760118374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oNWiu2+oUY794rWhMeFavwyt00FjZeL072iyEDl7YH0=;
        b=LT5n4jtmyUWsPq7DsGWRNMTDjDdcnOHS95P6iXbhqINXa57wgB6u+X3B0vTf3jhTjF
         /oGej5xsKV/+lIGjMhEILtRcIikqYmD5CKfoZ9ARLgJtKpyOt1jvBZFVk3oYkXxxWjq0
         SGSRwOnVJ42Dc65SO4md7F6gE0V3g0GjePNqyF+BldKkXVMgsipIX32bzzZp3bB61fUx
         iTXtUNudvCSeC96kM4wpdWo8TdK8BbYEtPAC50XqXsODz3PCkWZ15tjfadO8t3DBa6Kz
         lOVkkrCqDMfstY2DQNCCbL2SSZCTW3ooNRc3qUA851gQlwhfFB6qR6tGGC8UZl5CbMBD
         QC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759513574; x=1760118374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oNWiu2+oUY794rWhMeFavwyt00FjZeL072iyEDl7YH0=;
        b=UQjY4kJCIIn6CXxP+gKqTV9MkliPgDtRoKBHub8YgbPYlzhvXkoZKBOhWnIK3Bh3Jc
         Fe5ltiO32T18i+zA3KoocoSV2umNYvB4OFNhg2a1/p1yQiGQtC09IXdcAFStgOzEGuTj
         tgjrNaRDWmdrJah4QOvYFooZJ7NmuUBqwZd2x6yku+dGfSFC5m2E21VikF2dusfn5jwN
         Kh4WQ0ilYtxprMIiQlSolzMnJjBGvIPPQbopSOh6ETfWFqZuL6CwrU3584wQOPCUql8x
         BswOeULqNK14+BZuv+jdhaGqJ0+Ujra3vdX/Jj5ncOs8REk8jCyj9Uy/Zg2yXmCizh2K
         BY4w==
X-Forwarded-Encrypted: i=1; AJvYcCWn1AHO1XNIxwLX431wRzP8r/LcLO3o8iLlD2keBwBhTkx3pyLzXte+BaWx/fFpbkZ0gSqMGptw2n/v6+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Dmk2hJTLwoqWUun+p73d0PsxWK77dIoyBlvwFvy6VTLOVGge
	x8tRMMRXswiVTTmSqQIQfJ9AeSG1ZpB6C6hFpgc+gQEq+wq1rRAb8wl/
X-Gm-Gg: ASbGncuqwr1PUyamXEU/HIAjQZLggBD7BeCHA7JDOw87kvv9EzOQ9zO9bVGvaloHr5Y
	gioCGf4qRHm8P316b1I7a9jLB2mGqVFD5TgNYgijRk21RnFnjRTk/mkDGEoWOOTgLsIYgCQxFjN
	Ye9D+5L3EzUgWiS39zvUEARnIXPmz8ef+xHQToB3NLSf1Uyh61XawDfHAw3kcmcROn/vUN7COrs
	IQHLeUWAbDV3UJ9P25Ub7CM8ZFRyi1LCLBrZm3Cw/WMX1kVB9y+OpquC96feraawHNGmKRRK+hf
	b0YPEpx/QbFPUWabGbOnnCSe3ksEyJufvre0XAjq9RhUuPWsaXe30LBZjWVUvHPU9MDWgQ8+tIJ
	MQ3qCA5leM0jKAGd3meVb9M7R5bmMyzqWTgAdYfsI+M604Uysi0W2t0aE/ANBZLA6w76pIM3pls
	pOlTcJsvHwVuKAS0aXCKC6HzCmVQ==
X-Google-Smtp-Source: AGHT+IGhNAhoxUdEhhWoPmYNGwknobI9JaYXWSCnKleeWR/UvDtXieXQKqYoy4C04Jsm1xwP15Ya1g==
X-Received: by 2002:a17:90b:3ec5:b0:32e:1b61:309 with SMTP id 98e67ed59e1d1-339c27865b8mr4941526a91.23.1759513574165;
        Fri, 03 Oct 2025 10:46:14 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:38c3:a5e9:d69a:7a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a0c666sm2838991a91.1.2025.10.03.10.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 10:46:13 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	broonie@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Subject: [PATCH v3] hugetlbfs: skip PMD unsharing when shareable lock unavailable
Date: Fri,  3 Oct 2025 23:15:53 +0530
Message-ID: <20251003174553.3078839-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hugetlb_vmdelete_list() cannot acquire the shareable lock for a VMA,
the previous fix (dd83609b8898) skipped the entire VMA to avoid lock
assertions in huge_pmd_unshare(). However, this prevented pages from being
unmapped and freed, causing a regression in fallocate(PUNCH_HOLE) operations
where pages were not freed immediately, as reported by Mark Brown.

The issue occurs because:
1. hugetlb_vmdelete_list() calls hugetlb_vma_trylock_write()
2. For shareable VMAs, this attempts to acquire the shareable lock
3. If successful, huge_pmd_unshare() expects the lock to be held
4. huge_pmd_unshare() asserts the lock via hugetlb_vma_assert_locked()

The v2 fix avoided calling code that requires locks, but this prevented
page unmapping entirely, breaking the expected behavior where pages are
freed during punch hole operations.

This v3 fix takes a different approach: instead of skipping the entire VMA,
we skip only the PMD unsharing operation when we don't have the required
lock, while still proceeding with page unmapping. This is safe because:

- PMD unsharing is an optimization to reduce shared page table overhead
- Page unmapping can proceed safely with just the VMA write lock
- Pages get freed immediately as expected by PUNCH_HOLE operations
- The PMD metadata will be cleaned up when the VMA is destroyed

We introduce a new ZAP_FLAG_NO_UNSHARE flag that communicates to
__unmap_hugepage_range() that it should skip huge_pmd_unshare() while
still clearing page table entries and freeing pages.

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Reported-by: Mark Brown <broonie@kernel.org>
Fixes: dd83609b8898 ("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

---
Changes in v3:
- Instead of skipping entire VMAs, skip only PMD unsharing operation
- Add ZAP_FLAG_NO_UNSHARE flag to communicate lock status
- Ensure pages are still unmapped and freed immediately
- Fixes regression in fallocate PUNCH_HOLE reported by Mark Brown

Changes in v2:
- Check for shareable lock before trylock to avoid lock leaks
- Add comment explaining why non-shareable VMAs are skipped
---
 fs/hugetlbfs/inode.c | 22 ++++++++++++----------
 include/linux/mm.h   |  2 ++
 mm/hugetlb.c         |  3 ++-
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9c94ed8c3ab0..519497bc1045 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -474,29 +474,31 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 	vma_interval_tree_foreach(vma, root, start, end ? end - 1 : ULONG_MAX) {
 		unsigned long v_start;
 		unsigned long v_end;
+		bool have_shareable_lock;
+		zap_flags_t local_flags = zap_flags;
 
 		if (!hugetlb_vma_trylock_write(vma))
 			continue;
-
+
+		have_shareable_lock = __vma_shareable_lock(vma);
+
 		/*
-		 * Skip VMAs without shareable locks. Per the design in commit
-		 * 40549ba8f8e0, these will be handled by remove_inode_hugepages()
-		 * called after this function with proper locking.
+		 * If we can't get the shareable lock, set ZAP_FLAG_NO_UNSHARE
+		 * to skip PMD unsharing. We still proceed with unmapping to
+		 * ensure pages are properly freed, which is critical for punch
+		 * hole operations that expect immediate page freeing.
 		 */
-		if (!__vma_shareable_lock(vma))
-			goto skip;
-
+		if (!have_shareable_lock)
+			local_flags |= ZAP_FLAG_NO_UNSHARE;
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
 
-		unmap_hugepage_range(vma, v_start, v_end, NULL, zap_flags);
-
+		unmap_hugepage_range(vma, v_start, v_end, NULL, local_flags);
 		/*
 		 * Note that vma lock only exists for shared/non-private
 		 * vmas.  Therefore, lock is not held when calling
 		 * unmap_hugepage_range for private vmas.
 		 */
-skip:
 		hugetlb_vma_unlock_write(vma);
 	}
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 06978b4dbeb8..9126ab44320d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2395,6 +2395,8 @@ struct zap_details {
 #define  ZAP_FLAG_DROP_MARKER        ((__force zap_flags_t) BIT(0))
 /* Set in unmap_vmas() to indicate a final unmap call.  Only used by hugetlb */
 #define  ZAP_FLAG_UNMAP              ((__force zap_flags_t) BIT(1))
+/* Skip PMD unsharing when unmapping hugetlb ranges without shareable lock */
+#define  ZAP_FLAG_NO_UNSHARE         ((__force zap_flags_t) BIT(2))
 
 #ifdef CONFIG_SCHED_MM_CID
 void sched_mm_cid_before_execve(struct task_struct *t);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6cac826cb61f..c4257aa568fe 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5885,7 +5885,8 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		}
 
 		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, vma, address, ptep)) {
+		if (!(zap_flags & ZAP_FLAG_NO_UNSHARE) &&
+		      huge_pmd_unshare(mm, vma, address, ptep)) {
 			spin_unlock(ptl);
 			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
 			force_flush = true;
-- 
2.43.0


