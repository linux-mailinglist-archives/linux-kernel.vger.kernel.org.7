Return-Path: <linux-kernel+bounces-833473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E659BA219E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4C51C22DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6312B2DA;
	Fri, 26 Sep 2025 00:32:50 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BE3CA4B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846770; cv=none; b=jGaphUKAOrM/K8xRqeu4R75WoLb9Sb+iuUk4A5xNi2Uny1Z9NIm5WDMLnYeBjGzSp33YXKE4nr0uakmdUeS2lCyrE3HEgGcA2I60r2nvLvrhZ4aC8SRb/JoL+hyZesOr8SlLYGJ74adgPo94eND8YhgcQEGVB3pRqtN84J1WAfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846770; c=relaxed/simple;
	bh=FDyQHdxRkxbQ3ynMKxsQ1qMEJ8LqS3hJ+6RuY0eykxk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oxOSg433cGgeMvov+EltMMM6iI2O5oLraCDjdqkO4Brf7pMfXHSPNawrHf/O0mPZyrP4a67lmVrSJhEeZNa2MGb41rbfi5RPrAwHmyV4qQ/8wpnVMMQ5ITAAKseVD+/VS/dBy97XEc+v6+NYqOJ/1jTxruwUIZgoT23oiDYIwmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42595318a28so28752575ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758846767; x=1759451567;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SclqR6rpj2GzhVy+TdZ22Yh8EoBXtYdfPs1H5YMobeg=;
        b=h1l0akx4SQiZERi97ZW9umHd84HWZzBvqMZM+P3FAfyG9dA27ZGBkqxCq38h5GtNds
         Ugf7bIYq0/sL9ZOEzkb/ZRppPIEcLRLzk+8+uY5ZSGaxpmuI7TSvF9lJ82mRkHKHWdjv
         wh+T4AJKC0tB2LDMC3vmf7KhAH7iwnHy+j0uAixH556hbspQivZ/owoQCLyColvmq4fy
         fzDhvP33NdiroLrfe+VIyWbWL/S25SqEA+Xe0qQlz0OTtzxWFPKvPF9eNQe9u32/jBXe
         28VOeXDCaUB9jD5peH5t+/YV1oMg5YdtRQPCQHU9SC3i6lbtCdsVVXfKjvN6CbEv4HBc
         w5Ow==
X-Gm-Message-State: AOJu0YzzyviYoJGHDv+6iunRFE+cTjuXb+EDb2ftlj+qMtD8AY/vC8/y
	n6TkgM8VzKcsS06p2s3yFYy26Anc7GMmdslFofKLr5vgh/Vwrx2hZ1CKDODXJm2ktSf8JI06mx8
	zRnEMGETFcks5q1eyGNhxfsy9fr+LSvW7d3sYJtyCs+G2L/Ya24Ir6yKDVyc=
X-Google-Smtp-Source: AGHT+IFT5P71jWFCSRkZKAGhek3lQftA4tjm28rzNI7icwKTnQKJNd255Mnfzfdf45kCgK9rLmbOgXMwE3onLYLxT1Ud7Zls8TTr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1785:b0:424:7e21:3d8 with SMTP id
 e9e14a558f8ab-425c12dd0eamr61947565ab.1.1758846767641; Thu, 25 Sep 2025
 17:32:47 -0700 (PDT)
Date: Thu, 25 Sep 2025 17:32:47 -0700
In-Reply-To: <68d26261.a70a0220.4f78.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d5df2f.a00a0220.303701.001f.GAE@google.com>
Subject: Forwarded: [PATCH v2] hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH v2] hugetlbfs: skip VMAs without shareable locks in hugetlb=
_vmdelete_list
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.gi=
t master

hugetlb_vmdelete_list() uses trylock to acquire VMA locks during truncate
operations. As per the original design in commit 40549ba8f8e0 ("hugetlb:
use new vma_lock for pmd sharing synchronization"), if the trylock fails
or the VMA has no lock, it should skip that VMA. Any remaining mapped
pages are handled by remove_inode_hugepages() which is called after
hugetlb_vmdelete_list() and uses proper lock ordering to guarantee
unmapping success.

Currently, when hugetlb_vma_trylock_write() returns success (1) for VMAs
without shareable locks, the code proceeds to call unmap_hugepage_range().
This causes assertion failures in huge_pmd_unshare() =E2=86=92 hugetlb_vma_=
assert_locked()
because no lock is actually held:

  WARNING: CPU: 1 PID: 6594 Comm: syz.0.28 Not tainted
  Call Trace:
   hugetlb_vma_assert_locked+0x1dd/0x250
   huge_pmd_unshare+0x2c8/0x540
   __unmap_hugepage_range+0x6e3/0x1aa0
   unmap_hugepage_range+0x32e/0x410
   hugetlb_vmdelete_list+0x189/0x1f0

Fix by using goto to ensure locks acquired by trylock are always released, =
even
when skipping VMAs without shareable locks.

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=3Df26d7c75c26ec19790e7
Fixes: 40549ba8f8e0 ("hugetlb: use new vma_lock for pmd sharing synchroniza=
tion")
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

---
Changes in v2:
- Use goto to unlock after trylock, avoiding lock leaks (Andrew Morton)
- Add comment explaining why non-shareable VMAs are skipped (Andrew Morton)
---
 fs/hugetlbfs/inode.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9e0625167517..9fa7c72ac1a6 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -488,6 +488,14 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgo=
ff_t start, pgoff_t end,
 		if (!hugetlb_vma_trylock_write(vma))
 			continue;
=20
+		/*
+		 * Skip VMAs without shareable locks. Per the design in commit
+		 * 40549ba8f8e0, these will be handled by remove_inode_hugepages()
+		 * called after this function with proper locking.
+		 */
+		if (!__vma_shareable_lock(vma))
+			goto skip;
+
 		v_start =3D vma_offset_start(vma, start);
 		v_end =3D vma_offset_end(vma, end);
=20
@@ -498,7 +506,8 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgof=
f_t start, pgoff_t end,
 		 * vmas.  Therefore, lock is not held when calling
 		 * unmap_hugepage_range for private vmas.
 		 */
-		hugetlb_vma_unlock_write(vma);
+skip:
+		hugetlb_vma_unlock_write(vma);
 	}
 }
=20
--=20
2.43.0

