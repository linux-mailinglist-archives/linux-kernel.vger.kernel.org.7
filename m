Return-Path: <linux-kernel+bounces-831800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA934B9D93C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0D0327EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAB22E7F3C;
	Thu, 25 Sep 2025 06:23:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F332A1CA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781408; cv=none; b=Rsf40x9mO3Dw03B5vBxUKXzD/Dfz3Q0aqX2qJBXY4hsW2T/MpevuN5KB28DNSHMbBBHtlyLNO8znehZGDClMwnOU4JT0+m1NHQcOjFDGEePbLN5vpGP2pqPZT1h/5Y62rOauppiOHLwkZQDbevGNrjgPGr9/qptcIM/BWorb7Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781408; c=relaxed/simple;
	bh=T7CJqylTVPdNPHaOWkzepggtBVJzcRF7iryQTL+zuMM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xqmdc0QYBc+JfKxJ4Tv8ggmd86XxDjD4D+xrlu2CEJpowtb8zL85TNjrA1A8ydCEWINpzGqr5NDlRYXIfCbBw8wbn5nlY7AqAPi/GfCHEcp8XKNi4g9/rkm7tLmX5IDh56VgLgqxpUYXVWsBZC4nRIh2JJw5fig6zdVwTc8LoPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4257ae42790so8965415ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781406; x=1759386206;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GG90NKW8rBvVSrr4DzzksRdVGSMDJa3osFcBqlv/uVE=;
        b=kg14n9ZRQq9E91Brj8Kp0E6XemmXxH/PmC/JgxsQ94haSjWQamRMZ/wzxPNh5cW7OW
         vJLYmAFdFUxgeROmCKtI15ibDJGut5tyhiaqaphaz42+Fsd0VhZoe4tlSv4LmoRcRdHh
         8dzkRsGGJXZDLT1t2u+hPOcDy8Jq/hUVfITmFOpzRGap95fvshU2W7DncW1WQAZO9uWA
         WAe4uuI/vtL5wa/EfW+iJQENpkfWPDO1c0ZZHfXPbDhVQWXVB/dZ4Z6jXmE9QB7NooWp
         KQKjBWxOQR8OYCV5v90qk/XsDz2YGbqZp46VTLBPvqU0oTrVg3yOZBN02OQSpqAY9vKk
         ucQw==
X-Gm-Message-State: AOJu0YwJ4/MYE0LSu/A1KHt07aIAH4VZ9/tpOT3A20yiZsKcaUX+NmXl
	F4yb7udBe5D0pYjNHAAdMRY9voOsRaezJuqY44WcjpHxV/hIR5frFDrK+OtcZDfVPyzP9wDKzem
	9Fl6lRYyzTee0p58jtgBA0PiCEk/qV0ar56lz6h5V/scl8reKskV342B7lp8=
X-Google-Smtp-Source: AGHT+IE9DxXR0TIWTexgYUUCrKKE2yB46zCObKW9yJ465WxdLgdSxCZFjjvTYRQ00YrF9dFyYNb94EoTjRvQw+GHT5Y2nlDyZau2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3cc1:b0:424:8d44:a267 with SMTP id
 e9e14a558f8ab-4259566089fmr34406705ab.29.1758781406432; Wed, 24 Sep 2025
 23:23:26 -0700 (PDT)
Date: Wed, 24 Sep 2025 23:23:26 -0700
In-Reply-To: <68d26261.a70a0220.4f78.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d4dfde.050a0220.3a612a.0004.GAE@google.com>
Subject: Forwarded: [PATCH] hugetlbfs: fix lock imbalance in hugetlb_vmdelete_list
From: syzbot <syzbot+62edf7e27b2e8f754525@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] hugetlbfs: fix lock imbalance in hugetlb_vmdelete_list
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

hugetlb_vmdelete_list() has a lock imbalance bug where lock acquisition
and release evaluate VMA conditions at different times, potentially
causing unlock to be called on the wrong lock or skipped entirely.

The current code evaluates __vma_shareable_lock() and __vma_private_lock()
twice - once during hugetlb_vma_trylock_write() and again during
hugetlb_vma_unlock_write(). If VMA state changes between these calls
(due to unmap operations or concurrent access), the lock and unlock
paths may diverge, leading to:

1. Unlocking a lock that was never acquired
2. Unlocking the wrong lock type
3. Leaving a lock held

This manifests as "bad unlock balance detected" warnings:

  WARNING: bad unlock balance detected!
  trying to release lock (&vma_lock->rw_sema) at:
  hugetlb_vmdelete_list+0x179/0x1c0 fs/hugetlbfs/inode.c:501
  but there are no more locks to release!

Fix this by saving the lock type and pointer when acquiring the lock,
then using the saved information for unlock, ensuring symmetric lock
operations regardless of any VMA state changes.

Reported-by: syzbot+62edf7e27b2e8f754525@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=62edf7e27b2e8f754525
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/hugetlbfs/inode.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9e0625167517..2721ba2ee3f3 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -42,6 +42,10 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/hugetlbfs.h>
 
+#define HPAGE_RESV_OWNER    (1UL << 0)
+#define HPAGE_RESV_UNMAPPED (1UL << 1)
+#define HPAGE_RESV_MASK (HPAGE_RESV_OWNER | HPAGE_RESV_UNMAPPED)
+
 static const struct address_space_operations hugetlbfs_aops;
 static const struct file_operations hugetlbfs_file_operations;
 static const struct inode_operations hugetlbfs_dir_inode_operations;
@@ -475,6 +479,9 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		      zap_flags_t zap_flags)
 {
 	struct vm_area_struct *vma;
+	struct hugetlb_vma_lock *vma_lock;
+	struct resv_map *resv_map;
+	bool locked;
 
 	/*
 	 * end == 0 indicates that the entire range after start should be
@@ -484,8 +491,24 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 	vma_interval_tree_foreach(vma, root, start, end ? end - 1 : ULONG_MAX) {
 		unsigned long v_start;
 		unsigned long v_end;
-
-		if (!hugetlb_vma_trylock_write(vma))
+		vma_lock = NULL;
+		resv_map = NULL;
+		locked = false;
+
+		if (__vma_shareable_lock(vma)) {
+			vma_lock = vma->vm_private_data;
+			if (vma_lock && down_write_trylock(&vma_lock->rw_sema))
+				locked = true;
+		} else if (__vma_private_lock(vma)) {
+			resv_map = (struct resv_map *)((unsigned long)vma->vm_private_data & ~HPAGE_RESV_MASK);
+			if (resv_map && down_write_trylock(&resv_map->rw_sema))
+				locked = true;
+		} else {
+			/* No lock needed for this VMA */
+			locked = true;
+		}
+
+		if (!locked)
 			continue;
 
 		v_start = vma_offset_start(vma, start);
@@ -498,7 +521,10 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
 		 * vmas.  Therefore, lock is not held when calling
 		 * unmap_hugepage_range for private vmas.
 		 */
-		hugetlb_vma_unlock_write(vma);
+		if (vma_lock)
+			up_write(&vma_lock->rw_sema);
+		else if (resv_map)
+			up_write(&resv_map->rw_sema);
 	}
 }
 
-- 
2.43.0


