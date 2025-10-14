Return-Path: <linux-kernel+bounces-851611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FD4BD6E35
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1ED2B4E2735
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FED1DE3DF;
	Tue, 14 Oct 2025 00:40:17 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08161DF49
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760402416; cv=none; b=rMTPT2BHTGsQIcmawxQBA3t8Hwk4e8L7cViVj9Au8ZCF5aGgHRL/tqeIJSYnws5vpRCc6LOgUH6ju0D5U969LtM1/D13YMx1zwzCWT0+isA475mixwg5HlqxzbFyWRO1Q98uWdgM8s2MmypxjeDe4GHNSyfLSTYnrK3cqyHCa4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760402416; c=relaxed/simple;
	bh=IPl9EQf6BtNRNurlVLQ0RfL/LiGQBF5rKGa+SxOTBeg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K7DVoB0JqR4vMAl17+kpG2BTlRynlV7maRveolhLbdgaq5n6GpNW9KnAH9CzxGBHRAyhtb7LTjsNs7NYl/9+jQ48KkiMuWYgPafTjI8eZE268VD1uIaPAK87+yMeyB6AatJngWx81FSqWZslF76K0mjKOo+K3r4amQ3DGvoE/GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9374627bb7eso1426844039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760402414; x=1761007214;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9XtdkcOQ7DKkYuGh3zZQxXfk2Er/NZSi44IpJOI6IQ=;
        b=EKwjX9XpTb7Q3BKXcgYsvtpmew4gLGso6OByo1yz2a8FHd05/S9+PAYFLVG3GdzSzW
         10aOA8lHSc71XUDpT3lVtCOeToXdgyhUqt0xnKUkWOLSPzPUlQ7fRKn1RWq+Q+2wpfwO
         SwJX3xv2950vEZLGbTdBfmAVod26euegMDuPW7UVq/r84dtMIqJz2fiHPG3ibeeT4jfl
         DlWMdZrN8YkQ5qScAkLquMPQAKwss3dKBu/vUtTEIyL2lICUobfPUfUxvPx20xWv2/xP
         VfY1V2t7yH6+ppoiZywXvKOjXQzuqW0JaZrGj2R0lEJ7aotjp8QgiGB+ClUs03/R7aec
         F2IA==
X-Gm-Message-State: AOJu0YyEfXjk1U2dxXj9XvKHcZmDOqVimZacVJx70gfk1ZUFWWAzqPJf
	KAHi6QK7oo4vGfvnlA2c5g/aqfTXUb/oJmwXmbUeGP+PQI+hMvG5Y1mBhOO+yS2eH3/NgraWjq2
	HfpLRXYKPHx5wsK9zxkBOKI7ew9UTdGUWlped7rly2fRsrtszMg73X8k6zJI=
X-Google-Smtp-Source: AGHT+IEKcZq5FiWlny6p4umqLu9/Ab9hITRo0l/imo9+vZzkT7IAskDYT0KKdXxdAUtIut6opgSh+xQ+HI7fAl7QQAykg/LcnC0g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2787:b0:42f:9c5e:4d57 with SMTP id
 e9e14a558f8ab-42f9c5e4e17mr175990665ab.6.1760402414092; Mon, 13 Oct 2025
 17:40:14 -0700 (PDT)
Date: Mon, 13 Oct 2025 17:40:14 -0700
In-Reply-To: <68d26261.a70a0220.4f78.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ed9bee.050a0220.91a22.01f4.GAE@google.com>
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
 mm/hugetlb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

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


