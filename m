Return-Path: <linux-kernel+bounces-832267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD8EB9EC7D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729022E60C2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0702F998B;
	Thu, 25 Sep 2025 10:40:52 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A352F83D6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796851; cv=none; b=RVdCnwHa3jqRfXlBkc5z8v75k2Vj6/wvpKjjCboeFisMxyQqt1J62l+PlaobMjlNDKi55n3bpApWonaDjztwlHzny3DwCNEK1sQa1NmizDxqCyAsNqRG3euUnjKDa9ZVaLviOiSpZBclr6//9gwa1w960Gsdoj+j4wpwdWmA4uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796851; c=relaxed/simple;
	bh=oiwtV+C9gdCEl24Qyk3NmomI6tNcuAu2jUlrUx8kxuA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EvyY4qw2hYyxOXT8XDzyQ+iiXQWwHjiJKgDfYNPRIG+XFLGdtghvhj7sGPGvtSnT4NskF1looN5OHUH0xkuLK6S//zdsIAI+4BrL8SmiSQ8mLs8HZqZo+ZLMi63X2h7hhivimW4hb7ssBT3x8tkr9uiuMIrQ7kKrndeXJY6RBcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-425703f5d96so8982435ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758796849; x=1759401649;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ0jm3WguWLZA9RB1hvr02yC7fPUvdfzf1ZblUDKg7M=;
        b=HnHOnKTBj9+yjWPCIt7JUqb2thtf5FiX7KNAmviVVy+LMJv2vrry0Uy2F0MJD4eG48
         qWMWiD/CCgq5DkBirTI5booku9NAmFgTATYNVHFK8hhalE/3k3jFW9XOcetrzCknZFw+
         pgjcRHv3YoH8CgQbOW4C1e58ojVirNKGzUVAPaRlHAWu7uMRCR/vzKeg9B9HQc6JaqT3
         V3yG3e37QMuaCs20xuPstuqQunJj0Fqpcqk2z3JdbZWwxJoANS3lJhE9s97VbCvg9zWX
         tSKQ+bfvslPYMylW7fZT1q9OlgkIgyNkQxrguhNbZVIX0vdserZ328PiFmtPkjM+3465
         +P9A==
X-Gm-Message-State: AOJu0YyUv8KIJLJ4wz/DX6VM/Vs/6a+tUe7uRUZq4boMkbucojIeUcHe
	cy0tM7Bc7Q3ya44PfsUNvfdLmkeHBpbGwWKuo10UJUERnjGSCjlvjF8JvmhJn58c/uRDOXpswn+
	fS1HI0ziIpPJ07ShwGPizMiN9yfcSNo/eG1PYdrhN9CkpTIkvDvRCrCKzuqE=
X-Google-Smtp-Source: AGHT+IG/J2isZLtehVD7jgDzS4Mx5HiUeVLuEH2p0qmdoHdXPcUC7xGRss3zOTLf3JrFmutXAmL18MV5cMsrXpt2HrJYpDqPkTRr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a23:b0:424:89fd:73d6 with SMTP id
 e9e14a558f8ab-4259560a64cmr47164355ab.14.1758796849244; Thu, 25 Sep 2025
 03:40:49 -0700 (PDT)
Date: Thu, 25 Sep 2025 03:40:49 -0700
In-Reply-To: <68d26261.a70a0220.4f78.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d51c31.050a0220.3a612a.000b.GAE@google.com>
Subject: Forwarded: [PATCH] hugetlbfs: skip VMAs without locks in hugetlb_vmdelete_list
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] hugetlbfs: skip VMAs without locks in hugetlb_vmdelete_list
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

hugetlb_vmdelete_list() can call unmap_hugepage_range() on VMAs that
have no associated lock, causing assertion failures in huge_pmd_unshare().

The function hugetlb_vma_trylock_write() returns 1 (success) even when
a VMA has neither a shareable lock nor a private lock. This allows
processing to continue, but when unmap_hugepage_range() is called, it
eventually reaches huge_pmd_unshare() which calls hugetlb_vma_assert_locked()
to verify a lock is held. The assertion fails because no lock was actually
acquired.

This results in a kernel panic:

  WARNING: CPU: 1 PID: 6594 Comm: syz.0.28 Not tainted
  Call Trace:
   hugetlb_vma_assert_locked+0x1dd/0x250
   huge_pmd_unshare+0x2c8/0x540
   __unmap_hugepage_range+0x6e3/0x1aa0
   unmap_hugepage_range+0x32e/0x410
   hugetlb_vmdelete_list+0x189/0x1f0

Fix by skipping VMAs that have no lock before calling unmap_hugepage_range(),
as the unmap operation requires lock protection.

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/hugetlbfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9e0625167517..d2ecd83848e5 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -487,7 +487,8 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 
 		if (!hugetlb_vma_trylock_write(vma))
 			continue;
-
+		if (!__vma_shareable_lock(vma) && !__vma_private_lock(vma))
+			continue;
 		v_start = vma_offset_start(vma, start);
 		v_end = vma_offset_end(vma, end);
 
-- 
2.43.0


