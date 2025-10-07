Return-Path: <linux-kernel+bounces-843801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 90030BC04B1
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 08:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0790034BB25
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 06:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEAF1E5B7C;
	Tue,  7 Oct 2025 06:01:58 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1006084039
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 06:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759816917; cv=none; b=hoW1OxNnraID3t4j+OIaR2B0vLb0jY70eWlyxz+dXMcA4IUaThkQrLY88hipHCwN8pzBdBN59FQDtz60nnrpHoNRFnbI+V+heFcppX4b7LzzKk2N9KJcE9KtAvnozq1dPlvFJPWgtOlUyhsqw8SDBiEIfaqUwwRorSRNlHPZ/Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759816917; c=relaxed/simple;
	bh=O/Fh3tju1B/Uk3/0Ms2vmbrmERUaNnzVEKfZVEmdFDU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TG83uTsS+B90dPFIpBI7xLNQuGoJbo68SAs7MMjj9i+567bWn54CHBjLy0VxA/QS/L1+tFe1yAUkuOasiUP4FElsR/sD1kqSFY+tI5dRRTNKkyG8McRAfSO1r5f23DwkM1fRycFy0nmPHJ/kXQ0A3muHICu4UglnmoKT0ak5qM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4257e203f14so184536465ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 23:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759816915; x=1760421715;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2hipv64f+ztM8s8DWNbBHKH7vt22H80a5RN5otO+IM=;
        b=aFu259odcjPfbe/Yb9Th8FstpNm/AJWkdIYV7aPvYHaJqylDlwLyLQw36jguNvteHd
         1jKx/HbcnCHB87LsnZmeparTjHEu2zQZM517Mew7X67Jb+CuAp38gL81wTtdoKcqbfkE
         FqId3rxt/DKXF4iHGXVeNCb6bu5LKMnyZERyFEdgX5/oKQ6lIUS4n/RSOEzdWoTu4KL9
         fJaa+fSlah7n33yD6j88rXJv/Ud9jvS/6oFm7EobKHn7BD31secQPxrjfgidutJuYpiv
         vzzwFY/hpddv5+3k5rFWzCjCS30RWXL1bGG3e9y7hEN6xUitEwr3HSismgxXLl9RkroC
         FoIg==
X-Gm-Message-State: AOJu0YxSLwPLXblIx/seYTS/yT/FvYySXyx8+jtdwphS7XsX5hKuF9kC
	Oxx6f0Q8Rp69CHulKrKuN1ZOkAkwc6Tsl68Pe/zYkEwQAgBQE+DBdapVWuHOoxCmDA7NRJ4xir8
	AP0PZuQ0INZvW1JMCneV4rVWsnOelMxkII96VG+hOKdk/MCxw9GjgyENkXHs=
X-Google-Smtp-Source: AGHT+IGY+5av2DJo4BpZ/C5/gAbGEC0k+c+jsLIml8QHswCKOM1s6OVg0M31L1iBI8PXEdqWZMK0rf8cOXExdpOMJviveE21eGrw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4a:b0:42e:70f3:4dc8 with SMTP id
 e9e14a558f8ab-42e7ada971fmr202592825ab.27.1759816915046; Mon, 06 Oct 2025
 23:01:55 -0700 (PDT)
Date: Mon, 06 Oct 2025 23:01:55 -0700
In-Reply-To: <68d26261.a70a0220.4f78.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e4acd3.050a0220.256323.0017.GAE@google.com>
Subject: Forwarded: [PATCH v4] hugetlbfs: check for shareable lock before
 calling  huge_pmd_unshare()
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH v4] hugetlbfs: check for shareable lock before calling  huge_pmd_unshare()
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

Instead of skipping VMAs or adding new flags, check __vma_shareable_lock()
directly in __unmap_hugepage_range() right before calling huge_pmd_unshare().
This ensures PMD unsharing only happens when the VMA has a shareable lock
structure, while still allowing page unmapping and freeing to proceed for
all VMAs.

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Reported-by: Mark Brown <broonie@kernel.org>
Fixes: dd83609b8898 ("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
Suggested-by: Oscar Salvador <osalvador@suse.de>
Suggested-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/mm-commits/20250925203504.7BE02C4CEF7@smtp.kernel.org/ [v1]
Link: https://lore.kernel.org/mm-commits/20250928185232.BEDB6C4CEF0@smtp.kernel.org/ [v2]
Link: https://lore.kernel.org/linux-mm/20251003174553.3078839-1-kartikey406@gmail.com/ [v3]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v4:
- Simplified approach per Oscar's suggestion: check __vma_shareable_lock()
  directly in __unmap_hugepage_range() before calling huge_pmd_unshare()
- Removed ZAP_FLAG_NO_UNSHARE flag per David's feedback to avoid polluting
  generic mm.h header
- Reverted hugetlb_vmdelete_list() to not skip VMAs

Changes in v3:
- Added ZAP_FLAG_NO_UNSHARE to skip only PMD unsharing, not entire VMA

Changes in v2:
- Skip entire VMAs without shareable locks in hugetlb_vmdelete_list()
  (caused PUNCH_HOLE regression)

Changes in v1:
- Initial fix attempt
---
 fs/hugetlbfs/inode.c | 10 +---------
 mm/hugetlb.c         |  2 +-
 2 files changed, 2 insertions(+), 10 deletions(-)

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
index 6cac826cb61f..9ed85ab8420e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5885,7 +5885,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		}
 
 		ptl = huge_pte_lock(h, mm, ptep);
-		if (huge_pmd_unshare(mm, vma, address, ptep)) {
+		if (__vma_shareable_lock(vma) && huge_pmd_unshare(mm, vma, address, ptep)) {
 			spin_unlock(ptl);
 			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
 			force_flush = true;
-- 
2.43.0


