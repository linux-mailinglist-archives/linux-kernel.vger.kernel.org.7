Return-Path: <linux-kernel+bounces-750090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1866B15735
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A045A1419
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD621C3C04;
	Wed, 30 Jul 2025 01:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6IYEpWP"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450521ACEDE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840381; cv=none; b=C4V9SAl45VVG3GvXTWZgxfwYbEXDpIwYk7sTJxMTyaNEkE6NwZSYMos5f0rW2ToAyocNIKv3gBrOJpMQCo0RxPzYFHCacIq0+xL6j74hC2wyL0zAkmIUDaYFCkoge7OsLqOEQnJRFWBTvPOuQ7y7r1Z2wOwRckCBLm7dnddQyfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840381; c=relaxed/simple;
	bh=O9XlaVi+t9Iw0lUXpUHlLLCuOSeTamS35o68KXmOAI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qLqHaE96/4G5QNtX/DNS+v+sYPYHLvDQsiUGRkf2LaNl4jHq4TcwBx4tAtJGRDcyeRXXQj+1dZnSJ3aKLSPmfoc7RsNHycvCJqo9YxQxgBAUEUOY3R3wmI4p4s4c3vQvoO/3JR/DZakZVFPe3kjtran4gZSgjEIw1fpeUPp4V+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6IYEpWP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e8bb626b2b3so7353901276.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840378; x=1754445178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EFr/UvDdK6SWWx6RBLxb5NvZO6MxbSmkX1gTh8Tsnig=;
        b=L6IYEpWPwPJmuL3GabwliAl07puer060u7nbtc8Z3eaDlp5eH6PtA31s/hfJSqxIR7
         aGmfGCB4M/6DfYFF3mH+vn//r5HzNCG9UtVvz5CiffbnmKpB3OXxeX56uWDGti/uD/cC
         u4GV+GykOhbf8AyXAdKc5qXsV25xhKJjGSpTRS1N7TWW1SGw42XedmNx72IcnimkMIHe
         L8BnDmA2RuK6Z5f4ZkSE5Yo4Vuxtzx+cJk2BLZcXDTTpNiwdcg6Zo0b7qSRs1v09YQCc
         x3GJn/fN27I7ba+QdnAe/pb5g7amw3J5xkE7fHnCt+EgbahSJxgN01KQCoaQJ46x3pKj
         1Xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840378; x=1754445178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EFr/UvDdK6SWWx6RBLxb5NvZO6MxbSmkX1gTh8Tsnig=;
        b=mRN+RGtMxu6SZUPmAotaq6zvcZeW+cnQ2jyzPgHFFfFAFxrYdIOTM3+lRhSLOWTBVB
         0t82/KyZf6lIuOOk6Be8Ts3mCkZIpC9oAop2XFLUI94VcW3AbZUkj6yp5yjFzl+rFXwJ
         xDpCg1l79DSwkPJxgf0iECVPgw/U4NkpVWpFS4EQRxvhIMYqzBRXX/hP7MABblBprKUh
         IHdoaE4dH2HNsNfmgRhVAoJGcgY4MUfja/qNcu2EPDaYgWkbHw4i30gm/RkOHOREzjgN
         vO00QQsz9l121tQO7TUiNwSlgm4/RkuN7EdtxDBjLk0SiUtoUEbCMMYaDpGZTEgsWYUQ
         ELQg==
X-Forwarded-Encrypted: i=1; AJvYcCU1d6NWtO13wplU9wSy7K1xWakL/IpuKwFBPl/b6QjZCyt1h69i321D7Z1nmKIUSo8u373+BtqaAO1z8gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbDL/cTqc9IKgbXV+n7MjooVWlB8dFWpgAnKe88HWNGnHbdSZW
	IGOtnmfS6HJGAjxgbiKB70v/lgGlOrsDzofh4gM1T1W37QTHVuyQdilK5E227QMyONZIzJ6ZRug
	g6iOPcEz8qanLU18ghwPUAq50hRTIgzDWbxYJLw==
X-Google-Smtp-Source: AGHT+IG1cJhmCCZIkkMafM0jzony5iZe8ksvoa9M4ezF0eX0aWEDihWVZCPpSJiee5XVHyXovfPD3ubRCc8t5wyjc8VHNw==
X-Received: from ybbdt4.prod.google.com ([2002:a05:6902:2504:b0:e8e:be3:249e])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:160b:b0:e8e:290b:7f91 with SMTP id 3f1490d57ef6-e8e314d390amr2232654276.6.1753840378293;
 Tue, 29 Jul 2025 18:52:58 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:52:41 -0700
In-Reply-To: <20250730015247.30827-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730015247.30827-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730015247.30827-3-isaacmanjarres@google.com>
Subject: [PATCH 6.1.y 2/4] mm: update memfd seal write check to include F_SEAL_WRITE
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, gregkh@linuxfoundation.org, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: aliceryhl@google.com, stable@vger.kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Lorenzo Stoakes <lstoakes@gmail.com>

[ Upstream commit 28464bbb2ddc199433383994bcb9600c8034afa1 ]

The seal_check_future_write() function is called by shmem_mmap() or
hugetlbfs_file_mmap() to disallow any future writable mappings of an memfd
sealed this way.

The F_SEAL_WRITE flag is not checked here, as that is handled via the
mapping->i_mmap_writable mechanism and so any attempt at a mapping would
fail before this could be run.

However we intend to change this, meaning this check can be performed for
F_SEAL_WRITE mappings also.

The logic here is equally applicable to both flags, so update this
function to accommodate both and rename it accordingly.

Link: https://lkml.kernel.org/r/913628168ce6cce77df7d13a63970bae06a526e0.1697116581.git.lstoakes@gmail.com
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 fs/hugetlbfs/inode.c |  2 +-
 include/linux/mm.h   | 15 ++++++++-------
 mm/shmem.c           |  2 +-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 330729445d8a..d4b2a199cb9d 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -136,7 +136,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vma->vm_flags |= VM_HUGETLB | VM_DONTEXPAND;
 	vma->vm_ops = &hugetlb_vm_ops;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b1509be77efb..fcd61558ebcb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3526,25 +3526,26 @@ static inline void mem_dump_obj(void *object) {}
 #endif
 
 /**
- * seal_check_future_write - Check for F_SEAL_FUTURE_WRITE flag and handle it
+ * seal_check_write - Check for F_SEAL_WRITE or F_SEAL_FUTURE_WRITE flags and
+ *                    handle them.
  * @seals: the seals to check
  * @vma: the vma to operate on
  *
- * Check whether F_SEAL_FUTURE_WRITE is set; if so, do proper check/handling on
- * the vma flags.  Return 0 if check pass, or <0 for errors.
+ * Check whether F_SEAL_WRITE or F_SEAL_FUTURE_WRITE are set; if so, do proper
+ * check/handling on the vma flags.  Return 0 if check pass, or <0 for errors.
  */
-static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
+static inline int seal_check_write(int seals, struct vm_area_struct *vma)
 {
-	if (seals & F_SEAL_FUTURE_WRITE) {
+	if (seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
 		/*
 		 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
-		 * "future write" seal active.
+		 * write seals are active.
 		 */
 		if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
 			return -EPERM;
 
 		/*
-		 * Since an F_SEAL_FUTURE_WRITE sealed memfd can be mapped as
+		 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
 		 * MAP_SHARED and read-only, take care to not allow mprotect to
 		 * revert protections on such mappings. Do this only for shared
 		 * mappings. For private mappings, don't need to mask
diff --git a/mm/shmem.c b/mm/shmem.c
index 2e6b7db7f14b..2034b9b3fb71 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2302,7 +2302,7 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	struct shmem_inode_info *info = SHMEM_I(file_inode(file));
 	int ret;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
-- 
2.50.1.552.g942d659e1b-goog


