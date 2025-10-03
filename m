Return-Path: <linux-kernel+bounces-841486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD77BB77FC
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82BBD3ACBB0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0D72BD001;
	Fri,  3 Oct 2025 16:11:52 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9565C26E6FA
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507912; cv=none; b=Td7RCpDpZbtYuFpncLs6HoRRC+PX2z3XfGTK77miYMA6JgqWiV1weniMpZyPGxxHHtOyLLtXS40bwTjy3w2bIyClKwf2fsoc029fAD5XK4pX4SXhxVSyL5cGnRr/E6m01GnIKIGQpeT48aQe732gjrY7ue4euM2cP/0w83HhV0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507912; c=relaxed/simple;
	bh=MCB7Uuj+bcnO37OYnfvqezeYus9dr2yQQs7xODWXmyk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AiScBjrfS4KtMiXAOpTgau4Hr/RRlXIbHMlRz52VELB5xK4ImiHis7kHt+97bqoSfXx2m4wdGHapJgXhzfvaL2gO2uMjNq430NNrA2IQNJstrf2POoPGl+tuDAh4Z3qv7k3+gnKM7iVdbIjqaZPfoY0FdhgaJT1LixabQJ+jvrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-90efeb58159so305696139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759507910; x=1760112710;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAfYRnayLv9RGHspEWeLNh/nILt1ebBjq4P0vnqySKM=;
        b=ufqZYZ6QH4dVBtNnrlZlKe1xLa1nvTqlCpSl0Uu3+UEVcDNIwJPzy4v9K5zOPfxn4A
         qaGbMJ0C/HRWyQ1eP3Hwqg4iGr5eAjwIOOqE0N1L8BjjAzta9qsbkKYib5fwGSznijgn
         1mQ/15E3cbFxWyWI6LsibKo621dKcl6c//PSSY6s0X9AMyQ9ScitIMsv1hT0bbn08u6Y
         +yprSdUaoYR3z+axR+N0fS9EcAUKLM1BTbUv68BQPgO0ri2mFC3m3ysz8G29LXiSMi9Z
         SNaVi58rQMMuEGx7J0C7pBqvqpMW785IP02+8hioCANO3vYkdO3KbaImKEbouxfY8/Qw
         AONg==
X-Gm-Message-State: AOJu0Yx/0ObPDy3om9vr/M65K802gPQjiyCQXuC6sH+PJDkKJLnNn6mg
	9zZh+inGMTRijjPFv/8/0BKRhzcPLhKSUOaKsoAsisikeYWcvy+nP4v+ze+nWvV7I1Z0Qb1l/VB
	KczRXbsgCg2u+J3OO512NIeMpFgKDFDTg7Yt9jQAeuRarOAPrBGNM96B+JJU=
X-Google-Smtp-Source: AGHT+IHvDvMLABZqMvXdi3xZSbNErXy55MAvhzM1dc8Ap9ekadvLbH9EO2wpdZG9oCgtnvpMZviBsgwPKDje2XnkV8wUInE93fSG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda2:0:b0:42d:7f38:a9b4 with SMTP id
 e9e14a558f8ab-42e7adc9d0cmr41245055ab.31.1759507909758; Fri, 03 Oct 2025
 09:11:49 -0700 (PDT)
Date: Fri, 03 Oct 2025 09:11:49 -0700
In-Reply-To: <68d26261.a70a0220.4f78.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dff5c5.a00a0220.102ee.0115.GAE@google.com>
Subject: Forwarded: [PATCH] hugetlbfs: skip PMD unsharing when shareable lock unavailable
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] hugetlbfs: skip PMD unsharing when shareable lock unavailable
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

When hugetlb_vmdelete_list() cannot acquire the shareable lock for a VMA,
the original code skipped the entire VMA, leaving pages unmapped. This
caused a regression where pages were not freed during fallocate(PUNCH_HOLE)
operations, as reported by Mark Brown.

The issue occurs because:
1. hugetlb_vmdelete_list() tries to acquire the VMA lock
2. For shareable VMAs, this includes the shareable lock via
   hugetlb_vma_trylock_write()
3. If successful and VMA is shareable type, we have the shareable lock
4. huge_pmd_unshare() requires this lock and asserts it is held

The previous fix (dd83609b8898) avoided the assertion by skipping entire
VMAs without shareable locks, but this prevented pages from being unmapped
and freed, breaking PUNCH_HOLE behavior.

This fix takes a different approach: instead of skipping the VMA entirely,
we skip only the PMD unsharing operation when we don't have the required
lock, while still proceeding with page unmapping. This is safe because:
- PMD unsharing is an optimization to reduce shared page table overhead
- Page unmapping can proceed safely with just the VMA write lock
- Pages get freed immediately as expected by PUNCH_HOLE callers

We add a new ZAP_FLAG_NO_UNSHARE flag to communicate to
__unmap_hugepage_range() that it should skip huge_pmd_unshare() while
still clearing page table entries and freeing pages.

Fixes: dd83609b8898 ("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
Reported-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/all/20251003150956.2870745-1-kartikey406@gmail.com/T/
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
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


