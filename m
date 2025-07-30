Return-Path: <linux-kernel+bounces-750095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4405AB15741
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A3317D006
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C6B1E0DEA;
	Wed, 30 Jul 2025 01:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKexWNxl"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C011BFE00
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840430; cv=none; b=M2YK1sX+433uiq3U1q0s8retU/A0Bn+q0OhJy6axH+jiAbSo8aFYiJICc+GvLnLKVweqTyOpici0wV26/WsCSpWYeZyCj/IOgK0drC/SusjN3scW6XTUu+tTC5nPGXf4HEWTKLLFazyTrOXifGhB7FjgggWP2BbCwi8y4pFBVVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840430; c=relaxed/simple;
	bh=yb5AchvzprDt6k5TvIEB28CA26wR5+Hnp1aXu/ymoG8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dVxsRw7RKeivaGidwUAloJu4bVrZUBuA+AOnLchMsVy/yXNa4Sq+rozkTK7434ZCqaqKXMjWDohtuZ5LmYtL1Nl/kqxtlc58ZAoMuQ4uiKKBsxtnL03x/zM5UJ9JnyhpMAb3OvWNv9rxamlCYA2/eYfWmx/4v5vpzFoshlXNFyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bKexWNxl; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e72ecef490dso9265960276.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840428; x=1754445228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=39x+FWPwzH2SKG6lIOzneDjaUlY8W/uoBQrpnBZb02Q=;
        b=bKexWNxlWLjRKemHPQhsq2LNEQiLlCjJjGKN4PExF80PZk8JQvoGdjRabIisQZBhNB
         GN3pEZnbnPaYI0mZ40+NA9iAh0FARjw2ZfESRBDG2KAJBfVsNyjm5UacZFAQ9GS+3qL3
         bksWeTwS4N/tXAm30NVA8WXU/01hWU76eOINLmQ4eDiF8GjNIGHmcj10mlR4G7g7GlJ3
         ioaLiNX0aLVkOearZzNWe7R4+nFHy7OzpaVdAqjJxx+kjtfxOvcP35oPNaxxHRIP/FAc
         EHk18zhXXRjHlbyMmFEvTE3j4B881+GlWLtLWcxUpHr6NSUSSXzUysa+RggzjAbrFtF6
         sXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840428; x=1754445228;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39x+FWPwzH2SKG6lIOzneDjaUlY8W/uoBQrpnBZb02Q=;
        b=Febb8v93b8KKrWLfZ6VlyYfNR1KFIKvzpI+ZA7XvQoBlszUhdYH/CN+9UR1wIF+PXZ
         YpVOSv1bv3ayaUbQEDu/Y3kxzFDAgP0/p7Pr9tuQj/JwmnWLkJEvRKf0vLTDbmVb5Ifz
         6jVbyqVjVo12ABmVz9BKeJtWHLdzcyUC2Vrkh+D2tudE4bIp8fWjoqDSWb89egOdYGlc
         EE3XW8WH1d5+c48lSCs08KdNvRdvC1+F/8KmnR88XWyDi039zDixoZnupVZxmRikGNw7
         aSxdPj5ZuRJnXs2TnriG1GtICind4rJMXj+sLwPRWmqh4RSJANPFj32iV1a0oRT4RZA2
         v+kg==
X-Forwarded-Encrypted: i=1; AJvYcCUzoxR+oA+hJUs/9Dpo7DuHHie9uUhvRCSLVKdEs0N+h3monIyb8CUGtNnK1RHSaVKW3a41ilTexYJJJR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwS9bkDDhkMwM8b7HEU9oWGf3TzDPJtQtAmZadLoTv7+D+wT4j
	LNvOooNl0TkxmjxfYVHUhs4D0rigsoP7Gh/yYepNYHsKvepYRv5ufv0K3HViRZ1zdRVV8qRpXGv
	NlsMkHrLxm6h688K6qg+g/Hfr0Rp0Ci4WTPazQA==
X-Google-Smtp-Source: AGHT+IGjCf5KwJgx9XGkjXLwUnllofZO1a2HLuupENahyAxK5jK5Et3l4fLbuwgKvSEACA7+q44be6tAId7B5VpbYdPrmQ==
X-Received: from ybdo28.prod.google.com ([2002:a05:6902:6c1c:b0:e8e:157e:e705])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a5b:ed1:0:b0:e8e:13f1:f174 with SMTP id 3f1490d57ef6-e8e315f2dddmr1583968276.37.1753840427764;
 Tue, 29 Jul 2025 18:53:47 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:53:31 -0700
In-Reply-To: <20250730015337.31730-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730015337.31730-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730015337.31730-3-isaacmanjarres@google.com>
Subject: [PATCH 5.15.y 2/4] mm: update memfd seal write check to include F_SEAL_WRITE
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
index 9b6004bc96de..c8a5d94561ff 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -148,7 +148,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vma->vm_flags |= VM_HUGETLB | VM_DONTEXPAND;
 	vma->vm_ops = &hugetlb_vm_ops;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0ec171c6557a..61874611d0e4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3287,25 +3287,26 @@ static inline void mem_dump_obj(void *object) {}
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
index 431a48e1b90c..06ed84ebdf3b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2262,7 +2262,7 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	struct shmem_inode_info *info = SHMEM_I(file_inode(file));
 	int ret;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
-- 
2.50.1.552.g942d659e1b-goog


