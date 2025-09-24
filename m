Return-Path: <linux-kernel+bounces-830296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D84FB9957D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B9C4A44A8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C0D2DCF45;
	Wed, 24 Sep 2025 10:04:00 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ED22DCBFD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708240; cv=none; b=uPuZduO37Xsqj8MTMhKbi0pnkhDqMzOtXYCXiDYBfnbUIh5kOMoNMFe5ocnCVnAZenabI8E9nsIw/2Oz3j6fbmFQPHrpZP5XN/JOwa3uuy80sxi51WMwDGOtuxmS7aXCFrHjQhzRHsl4t9oH7afjRbVFgkv7DATWwrUcJkEVTro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708240; c=relaxed/simple;
	bh=0mtVf24+D/MQCrndIP6DN/PDPF6Ctgkw0o/5T/uyuYM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ujPVP/iQw7KnwP+dIFKQ2xgX3vKwjAhIA28Gh1FWJEHzR9L/thJuei/X4onUlN+yvTSKiNi+avgbu4X41KITndJBkH6nHdhHCbG2jT8kmI9HfJoyF7SRQXq+tAYr4EuPx5OTqJymuZ7jaQQP4RS+1yYikdyg9uPdH1PcRXh8+RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4257ae42790so43377065ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758708230; x=1759313030;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvny8gHoUWjEHeVJEQBH++fUzkBZJmoWZEK6GwrMEGY=;
        b=iKIOlXkwOR9sj79X24iq+dkq1gRi3N8zaHjveudRxAo0q+R9/BOUbTihQfKMdAsOd4
         sRV6GLMuNpEfoe6eq1iQohJQQRjM6Z269cq3biNShobU73hbTag26c/QIKpaA2bJ0PGz
         8gaBfcilIIoMbqgaOUnG6jBeFvYbvWeHxoBkv18JAdEeEh7gdDSfehnOPdoviV0dKCeq
         Ttfx5kkRiG58LdyW9Mnx9HEIqJMslDp5my1UmEMWJakjsRumcgyhfNNExvgsXIzVXWF6
         J0k+8KvVJXDONQZqpv77Xx1D9aju8+MSAnxhJAChcpqkNDOpZD32hI1d1wOstoDiyADx
         Oldw==
X-Gm-Message-State: AOJu0YwyPG8Pe3nvJym+GbQU9cHFD+ubJgBwOrp7o/V5+RgRu4jJ9Woz
	5+P0L0YKZBdVtkJSsX3NlFhJ+CyBIzh0Nhw8LrTMsHu+KgxzlxUai5u0ydBd7n5iaSOKYPKhDz4
	Tb5KDDah2o7X0uIJI4aDb+vtmVYMztzSJZUr6STbZjrKv+ZZiguH2YhRNLl0=
X-Google-Smtp-Source: AGHT+IGel8aEsO/KE8wGcjr6QZzs65cBkJKJo6UapeXoV6zU0oWYacRJaKk4qp9rywqOYAiSzzGVWSCfwUcsLd/NFkSmrBmJIk1f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2305:b0:402:b8e3:c9f5 with SMTP id
 e9e14a558f8ab-42581e04911mr86809035ab.2.1758708230134; Wed, 24 Sep 2025
 03:03:50 -0700 (PDT)
Date: Wed, 24 Sep 2025 03:03:50 -0700
In-Reply-To: <68d26261.a70a0220.4f78.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d3c206.050a0220.139b6.002f.GAE@google.com>
Subject: Forwarded: [PATCH] Fix a lock imbalance bug in hugetlb_vmdelete_list()
 that
From: syzbot <syzbot+62edf7e27b2e8f754525@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] Fix a lock imbalance bug in hugetlb_vmdelete_list() that
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.gi=
t master

Fix a lock imbalance bug in hugetlb_vmdelete_list() that causes:
WARNING: bad unlock balance detected!
  hugetlb_vmdelete_list+0x179/0x1c0 is trying to release lock=20
  (&vma_lock->rw_sema) but there are no more locks to release!

The issue is a race condition between multiple threads operating on the
same VMA:

1. Thread 1 calls hugetlb_vma_trylock_write() when vma->vm_private_data=3DN=
ULL
2. trylock returns success (no lock needed for this VMA type)
3. Thread 2 allocates a lock structure: vma->vm_private_data=3D&new_lock
4. Thread 1 calls hugetlb_vma_unlock_write(), sees non-NULL vm_private_data
5. Thread 1 tries to unlock a lock it never acquired =E2=86=92 crash

The fix is to save the VMA lock state at the time we make the locking
decision, rather than checking it again at unlock time. This prevents
the time-of-check-time-of-use (TOCTOU) race condition.

Reported-by: syzbot+62edf7e27b2e8f754525@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=3D62edf7e27b2e8f754525
Fixes: 8d9bfb2608cf ("hugetlb: add vma based lock for pmd sharing")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/hugetlbfs/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9e0625167517..ae3e07eacd37 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -475,15 +475,16 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pg=
off_t start, pgoff_t end,
 		      zap_flags_t zap_flags)
 {
 	struct vm_area_struct *vma;
-
 	/*
 	 * end =3D=3D 0 indicates that the entire range after start should be
 	 * unmapped.  Note, end is exclusive, whereas the interval tree takes
 	 * an inclusive "last".
 	 */
 	vma_interval_tree_foreach(vma, root, start, end ? end - 1 : ULONG_MAX) {
+		struct hugetlb_vma_lock *vma_lock;
 		unsigned long v_start;
 		unsigned long v_end;
+		vma_lock =3D vma->vm_private_data;
=20
 		if (!hugetlb_vma_trylock_write(vma))
 			continue;
@@ -498,7 +499,8 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgof=
f_t start, pgoff_t end,
 		 * vmas.  Therefore, lock is not held when calling
 		 * unmap_hugepage_range for private vmas.
 		 */
-		hugetlb_vma_unlock_write(vma);
+		if (vma_lock)
+			hugetlb_vma_unlock_write(vma);
 	}
 }
=20
--=20
2.43.0


