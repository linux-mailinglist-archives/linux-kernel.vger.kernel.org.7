Return-Path: <linux-kernel+bounces-851777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C49CBD73A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907A218A2416
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B939307AD7;
	Tue, 14 Oct 2025 04:14:55 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2B73074BD
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760415294; cv=none; b=p7R0umoZtT9cilZU85rtHJ494dDD7L+arnzZ/5n+h1WkR81lKeSEE1NbjJy/oaB8dAmaGNzbTOC7POMXGXqWDJa8RRgCLJaTqhCHdGUU2IpEzzDHXm5QTyx00PIhHphnsk6GmpfiHj7Cj4ogKV0ReMdYGurQiTPhctS+91aluSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760415294; c=relaxed/simple;
	bh=kIvPmfBEgBtpAvEpXoAS7bDe7iZsb520ENnOs/hCpYo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sSIN5NF3FvyoOaNtCVGlHG/+iHQAmAlTTIIkqa8Lbs4Us7g1e8wN3HzhWSVsCmnmKha8GCNTjRsMgMhpx1Xs3LcXfIfBjRuaCkSu2XxEqbrZyS7rCmLFhoY8E+khABzSZGg2gR3e12X5lOJEM3LQ4gvTC2XRk+BQR5E6dd9TV3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-90f6e3cd204so1178664239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760415292; x=1761020092;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jwbkjR+ZzHATK8z4420j4Dt5fyZ0njfG80T687S5nI=;
        b=bJVCMjl5R/vpVMedoD1mFpAFw0TefnKN5d2EDDEoLjofG7xmhJyTTF7YVVI0Y9WjhD
         cgtjzsFyTjK3vI4PK7vfNGiqALf+rlmZzWMopYnGGA1JMRVPIedZx6nai+CkbyWbKugX
         rUKvOf1IjRHL+vsXJzYZPHIOogTe9W/xIuesWHRJebSldbJO7/7BxYle9q6t0aI6uVcb
         5U2kZTo5oW0u3OAoNNoUxcqfXVJQFvMFRSrRFSko+60OqbsPXmWWZSCM74x6hlgUiqMF
         uXwKWmzs4pNlr7eg1WQFzCKwop+zzcidMw1UT2NWkTvQL7fBgUNCNGI7IntZLcCmpFM5
         ytkw==
X-Gm-Message-State: AOJu0YzeX/oNDwny1wSqEIVjSepnk0R094KVrhKl0Cc/235kK4HmbyWz
	PwvTlufBx8ByQvMe9Nn24OokMzM45gYMUbzgMcovehkmUtcqU50QY+8E1TUHMRe/rieutld8vxr
	rNhajfDNqRdUgYQQ0QrIPenKm3Jh9X1P5TsBEYhSNBfxNpBVIAFp2e2+2x0k=
X-Google-Smtp-Source: AGHT+IHBl2n9b77zO57isMH/o6jLrI0I7yw8bUg1auh7HLYg/Az6aCobkk+usez83U0EAWcCG2Z4ZTKNoXQ2kbgprzlEpaVOB+or
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6184:b0:93e:2517:804e with SMTP id
 ca18e2360f4ac-93e251784d1mr1790740339f.2.1760415291958; Mon, 13 Oct 2025
 21:14:51 -0700 (PDT)
Date: Mon, 13 Oct 2025 21:14:51 -0700
In-Reply-To: <68d26261.a70a0220.4f78.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68edce3b.050a0220.91a22.01fa.GAE@google.com>
Subject: Forwarded: [PATCH v6] hugetlbfs: move lock assertions after early
 returns in huge_pmd_unshare()
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH v6] hugetlbfs: move lock assertions after early returns in huge_pmd_unshare()
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

A subsequent fix in commit 06e8ca1b3dca ("hugetlbfs: check for shareable
lock before calling huge_pmd_unshare()") addressed this by checking
__vma_shareable_lock() in the caller before calling huge_pmd_unshare().
However, a cleaner approach is to move the lock assertions in
huge_pmd_unshare() itself to after the early return checks. The assertions
are only needed when actual PMD unsharing work will be performed. If the
function returns early because sz != PMD_SIZE or the PMD is not shared,
no locks are required.

This patch removes the check added in commit 06e8ca1b3dca ("hugetlbfs:
check for shareable lock before calling huge_pmd_unshare()") and instead
moves the assertions inside huge_pmd_unshare(), keeping all the logic
within the function itself.

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
Fixes: dd83609b8898 ("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Link: https://lore.kernel.org/mm-commits/20250925203504.7BE02C4CEF7@smtp.kernel.org/ [v1]
Link: https://lore.kernel.org/mm-commits/20250928185232.BEDB6C4CEF0@smtp.kernel.org/ [v2]
Link: https://lore.kernel.org/linux-mm/20251003174553.3078839-1-kartikey406@gmail.com/ [v3]
Link: https://lore.kernel.org/linux-mm/20251008052759.469714-1-kartikey406@gmail.com/ [v4]
Link: https://lore.kernel.org/linux-mm/CADhLXY72yEVDjXWfxBUXfXhNfb8MWqwJmcb1daEHmDeFW+DRGw@mail.gmail.com/ [v5]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v6:
- Remove __vma_shareable_lock() check from __unmap_hugepage_range()
  that was added in v4 (commit 06e8ca1b3dca)
- Move lock assertions after early returns in huge_pmd_unshare()
- Complete implementation of David's cleaner approach

Changes in v5:
- Incomplete: only moved assertions, forgot to remove v4 check

Changes in v4:
- Check __vma_shareable_lock() in __unmap_hugepage_range() before calling
  huge_pmd_unshare() per Oscar's suggestion

Changes in v3:
- Add ZAP_FLAG_NO_UNSHARE to skip only PMD unsharing

Changes in v2:
- Skip entire VMAs without shareable locks (caused PUNCH_HOLE regression)

Changes in v1:
- Initial fix attempt
---
 mm/hugetlb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 85b2dac79d25..0455119716ec 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5885,7 +5885,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		}
 
 		ptl = huge_pte_lock(h, mm, ptep);
-		if (__vma_shareable_lock(vma) && huge_pmd_unshare(mm, vma, address, ptep)) {
+		if (huge_pmd_unshare(mm, vma, address, ptep)) {
 			spin_unlock(ptl);
 			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
 			force_flush = true;
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


