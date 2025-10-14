Return-Path: <linux-kernel+bounces-851757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C26BD7304
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 216D14F6C72
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592F7273804;
	Tue, 14 Oct 2025 03:35:44 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5AA19F43A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760412943; cv=none; b=lLs8JxbOW8SIPZ17AvUHsHags3cDHDhOpgNod7etmIqpfqxeDolRQm0pnRVb8OmMFOjrOwy6aONkr/LLJyUcM4glcPcMBhFkVByJxDCQP6V0eRHaZIW+4O3r1rLPAfPgMhPRGH/les7et5Y0q9+yCQtHL9XXD9nqQHw2NSo14k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760412943; c=relaxed/simple;
	bh=6HQf9ge5tV/YSPkVdWYdYNiOVQcmwpNSNT01kJ3kr2Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NOQtYBm1GPdSwBkm/MvcFr1TcmD+JccFHDfcUbMjgCtgOcOK6MUVKJjSmky4XIYM44H3VSPneCTb4gA1vL8KVsNrztu/5ad2MuRfaPohnAo8IN50F3PvuvacZD+o5lod1neAZT24vTnCR88Q/OcuqlO+dDo2zL4OWEqEKbVn714=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93bbaa774e2so1181043939f.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760412941; x=1761017741;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7zsBbEOiPceBFWAfYaITeXxB7rQF3O1VUKlbD74mTE=;
        b=B/K89RPlsFDuZm+QAgXOd0Xt2ds20CT9V9P9iumaYfcg0dpLlLnSB4oZ/ZXV7i/4eF
         qsQICUHs0aBvjr9iT6qW957szic6wn7sIDvhJjO08vp8atl29WF9+VDpbKmD3SSmU8cG
         /+VTbMpaNWBBJBEkFXDcYkZZQ/qC0HdmtzFiXyjGGh6Bvg7TrXYYPxYPnDUhIXP6o/h6
         LNT9at3eHw6J4rgkKq6sIUkYvGfItr7uI6+xQEP6jVSzWIYyenL8+SAVXEVk+FcAYCoL
         XfgdvU5cNHTKTMsdKBk5GuqGB4pissyCKXSD1AaZ/+TCv3Kms/ooWgz+EGp/+NPXhyPc
         kl5g==
X-Gm-Message-State: AOJu0YyMgewKZ0y+/lD8U+t1rl94OLoONK7PQhdYYU3iQ4MRaJguQjbh
	ON3wcOSFOXYQvw4HWSCB8JrGtQuDasg35yTROhKPagfIGWF4l/qxklwpdVHYM0nIh3ZkB8Oc+ky
	Wqqh4peWcBAftQmy+hG9PDFoAu809tbJd2YB1aRG5cDYUY2xlZxE9qbmH3ms=
X-Google-Smtp-Source: AGHT+IHq09EtMES2y01sYYcmF/CEW07SjSwai7btqwUlokkvGf4KukX5QBPFokEZ8htNuGEQA1475rnM+vIocR5sw/Xw77xy+3Ck
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c21:b0:42f:8e66:e8c5 with SMTP id
 e9e14a558f8ab-42f8e66e945mr235926755ab.4.1760412941344; Mon, 13 Oct 2025
 20:35:41 -0700 (PDT)
Date: Mon, 13 Oct 2025 20:35:41 -0700
In-Reply-To: <68d26261.a70a0220.4f78.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68edc50d.050a0220.91a22.01f7.GAE@google.com>
Subject: Forwarded: [PATCH v5] hugetlbfs: move lock assertions after early
 returns in huge_pmd_unshare()
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH v5] hugetlbfs: move lock assertions after early returns in huge_pmd_unshare()
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

When hugetlb_vmdelete_list() processes VMAs during truncate operations,
it may encounter VMAs where huge_pmd_unshare() is called without the
required shareable lock. This triggers an assertion failure in
hugetlb_vma_assert_locked().

The previous fix in commit dd83609b8898 ("hugetlbfs: skip VMAs without
shareable locks in hugetlb_vmdelete_list") skipped entire VMAs without
shareable locks to avoid the assertion. However, this prevented pages
from being unmapped and freed, causing a regression in fallocate(PUNCH_HOLE)
operations where pages were not freed immediately, as reported by Mark Brown.

Instead of checking locks in the caller or skipping VMAs, move the lock
assertions in huge_pmd_unshare() to after the early return checks. The
assertions are only needed when actual PMD unsharing work will be performed.
If the function returns early because sz != PMD_SIZE or the PMD is not
shared, no locks are required and assertions should not fire.

This is cleaner than previous approaches because it keeps all the logic
within huge_pmd_unshare() itself, while still allowing page unmapping and
freeing to proceed for all VMAs.

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
Fixes: dd83609b8898 ("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
Link: https://lore.kernel.org/mm-commits/20250925203504.7BE02C4CEF7@smtp.kernel.org/ [v1]
Link: https://lore.kernel.org/mm-commits/20250928185232.BEDB6C4CEF0@smtp.kernel.org/ [v2]
Link: https://lore.kernel.org/linux-mm/20251003174553.3078839-1-kartikey406@gmail.com/ [v3]
Link: https://lore.kernel.org/linux-mm/20251008052759.469714-1-kartikey406@gmail.com/ [v4]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v5:
- Move lock assertions after early return checks in huge_pmd_unshare()
  per David's suggestion - cleaner approach that keeps logic within the
  function itself
- Revert all previous approaches (VMA skipping, flag additions, caller checks)

Changes in v4:
- Check __vma_shareable_lock() in __unmap_hugepage_range() before calling
  huge_pmd_unshare() per Oscar's suggestion
- Remove ZAP_FLAG_NO_UNSHARE flag per David's feedback

Changes in v3:
- Add ZAP_FLAG_NO_UNSHARE to skip only PMD unsharing, not entire VMA

Changes in v2:
- Skip entire VMAs without shareable locks (caused PUNCH_HOLE regression)

Changes in v1:
- Initial fix attempt
---
 fs/hugetlbfs/inode.c | 10 +---------
 mm/hugetlb.c         |  5 ++---
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9c94ed8c3ab0..1e040db18b20 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -478,14 +478,6 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		if (!hugetlb_vma_trylock_write(vma))
 			continue;
 
-		/*
-		 * Skip VMAs without shareable locks. Per the design in commit
-		 * 40549ba8f8e0, these will be handled by remove_inode_hugepages()
-		 * called after this function with proper locking.
-		 */
-		if (!__vma_shareable_lock(vma))
-			goto skip;
-
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
 
@@ -496,7 +488,7 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		 * vmas.  Therefore, lock is not held when calling
 		 * unmap_hugepage_range for private vmas.
 		 */
-skip:
+
 		hugetlb_vma_unlock_write(vma);
 	}
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 795ee393eac0..0455119716ec 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7614,13 +7614,12 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 	p4d_t *p4d = p4d_offset(pgd, addr);
 	pud_t *pud = pud_offset(p4d, addr);
 
-	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
-	hugetlb_vma_assert_locked(vma);
 	if (sz != PMD_SIZE)
 		return 0;
 	if (!ptdesc_pmd_is_shared(virt_to_ptdesc(ptep)))
 		return 0;
-
+	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
+	hugetlb_vma_assert_locked(vma);
 	pud_clear(pud);
 	/*
 	 * Once our caller drops the rmap lock, some other process might be
-- 
2.34.1


