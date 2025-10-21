Return-Path: <linux-kernel+bounces-863716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B37BBF8E90
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D59F34F245C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A7F285C8C;
	Tue, 21 Oct 2025 21:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sxuh6gdZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8C15CD74
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081050; cv=none; b=GfOfVhvdWI5fYlXqTbl88Y1PS25wP0WlkFyVAUUipBGQtN+lJxXcWW0T27bMZwbZnXJKzChs+wyldbYTNqtrHYVjSXo0cLIyhZZcz9ivT7O6ZjsizqLmnROEhxs/K6hwIx7za9Rmp04iMiYybzw6gqFeHCFSjt5TKeuhR1mIyjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081050; c=relaxed/simple;
	bh=CyjoCB+nOz0XloI/00jaAfTOPYcrftUYJkwBXkzSnRU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QX6s72R30yKq1f+ESdlspmJGnptU/6xVyVwcL7p+xdBJzvgzp4TDleqj3sDQiPC2N0hRR7VkBUwfJBcmnrU71DSWZy9VNlU0hOs7qpeM8C5lWPZzFG5oxr2hVji/YRGG0kSNX/70NXUmmXFC4NEcFqOtt1dRsxrsC/TJEdmrC9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Sxuh6gdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F431C4CEF1;
	Tue, 21 Oct 2025 21:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761081048;
	bh=CyjoCB+nOz0XloI/00jaAfTOPYcrftUYJkwBXkzSnRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sxuh6gdZ8tBwi/FrddVvT6zN/S0xQu3CcZiR4deQfvK2CEmOAWnhlV6otHUg2G+Me
	 4bVTKWRgfLsUgPo5eBXVGtvk+HYc4988REnbdEPfC5xVCmfjZqiqJnGkjOQsIxYzvi
	 rLggorjf66h1/4Z5DRmHyf0slgeeXXfNWVFLRAIU=
Date: Tue, 21 Oct 2025 14:10:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, muchun.song@linux.dev,
 osalvador@suse.de, david@redhat.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com,
 Aishwarya.TCV@arm.com, torvalds@linux-foundation.org
Subject: Re: [PATCH v2] hugetlbfs: skip VMAs without shareable locks in
 hugetlb_vmdelete_list
Message-Id: <20251021141047.532542aecdb0dc5fdb95696a@linux-foundation.org>
In-Reply-To: <9d20e689-c06e-43f8-811f-3e66f3e86d2b@sirena.org.uk>
References: <20250926033255.10930-1-kartikey406@gmail.com>
	<7a1d0eb0-ab08-4fa8-bdab-b193b69a8c9d@sirena.org.uk>
	<9d20e689-c06e-43f8-811f-3e66f3e86d2b@sirena.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 18:52:11 +0100 Mark Brown <broonie@kernel.org> wrote:

> > For the past few days I've been seeing failures on Raspberry Pi 4 in
> > the hugetlbfs-madvise kselftest in -next which bisect to this patch.
> > The test reports:
> > 
> > # # -------------------------
> > # # running ./hugetlb-madvise
> > # # -------------------------
> > # # Unexpected number of free huge pages line 252
> > # # [FAIL]
> > # not ok 6 hugetlb-madvise # exit=1
> 
> This issue is now present in mainline:
> 
> Raspberry Pi 4: https://lava.sirena.org.uk/scheduler/job/1976561#L1798
> Orion O6:       https://lava.sirena.org.uk/scheduler/job/1977081#L1779
> 
> and still bisects to this patch.

Thanks.  Were you able to test the proposed fix?

From: Deepanshu Kartikey <kartikey406@gmail.com>
Subject: hugetlbfs: move lock assertions after early returns in huge_pmd_unshare()
Date: Tue, 14 Oct 2025 17:03:44 +0530

When hugetlb_vmdelete_list() processes VMAs during truncate operations, it
may encounter VMAs where huge_pmd_unshare() is called without the required
shareable lock.  This triggers an assertion failure in
hugetlb_vma_assert_locked().

The previous fix in commit dd83609b8898 ("hugetlbfs: skip VMAs without
shareable locks in hugetlb_vmdelete_list") skipped entire VMAs without
shareable locks to avoid the assertion.  However, this prevented pages
from being unmapped and freed, causing a regression in
fallocate(PUNCH_HOLE) operations where pages were not freed immediately,
as reported by Mark Brown.

Instead of checking locks in the caller or skipping VMAs, move the lock
assertions in huge_pmd_unshare() to after the early return checks.  The
assertions are only needed when actual PMD unsharing work will be
performed.  If the function returns early because sz != PMD_SIZE or the
PMD is not shared, no locks are required and assertions should not fire.

This approach reverts the VMA skipping logic from commit dd83609b8898
("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
while moving the assertions to avoid the assertion failure, keeping all
the logic within huge_pmd_unshare() itself and allowing page unmapping and
freeing to proceed for all VMAs.

Link: https://lkml.kernel.org/r/20251014113344.21194-1-kartikey406@gmail.com
Fixes: dd83609b8898 ("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Reported-by: <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Oscar Salvador <osalvador@suse.de>
Tested-by: <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/hugetlbfs/inode.c |    9 ---------
 mm/hugetlb.c         |    5 ++---
 2 files changed, 2 insertions(+), 12 deletions(-)

--- a/fs/hugetlbfs/inode.c~hugetlbfs-move-lock-assertions-after-early-returns-in-huge_pmd_unshare
+++ a/fs/hugetlbfs/inode.c
@@ -478,14 +478,6 @@ hugetlb_vmdelete_list(struct rb_root_cac
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
 
@@ -496,7 +488,6 @@ hugetlb_vmdelete_list(struct rb_root_cac
 		 * vmas.  Therefore, lock is not held when calling
 		 * unmap_hugepage_range for private vmas.
 		 */
-skip:
 		hugetlb_vma_unlock_write(vma);
 	}
 }
--- a/mm/hugetlb.c~hugetlbfs-move-lock-assertions-after-early-returns-in-huge_pmd_unshare
+++ a/mm/hugetlb.c
@@ -7614,13 +7614,12 @@ int huge_pmd_unshare(struct mm_struct *m
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
_


