Return-Path: <linux-kernel+bounces-750062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B18CB156D2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8310D4E00CB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657331A7AE3;
	Wed, 30 Jul 2025 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fG4jeJr/"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBE61A23B6
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753837124; cv=none; b=QeqndqYzksccePKUvFypTemf3jgd68aDj6IaoM0/IGneuYobgE1pau65izpuBCeNjGtCYrjUnQSA/v3OEGKBemCo6gFwWtA9PP8c6i+mrw6xIwtqW/alrXJU1vYHsdO4ZAavFWr8XxKctqB1uv1KdCC2Hk/hINuJMa0nl/XO1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753837124; c=relaxed/simple;
	bh=bYYBIY+R2ybqqUZSXToBTBV9G5yjx4LIU3VfXNJeE9s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uMPkZ6dGOTp3PwN9COk0D9DAw8CwBSacJfLCG8barYGMvUv0EyX2rO9Qo6Qe4/v3V00+9MMF+4YKrD9O5OQQK1836dDu4LXX6oeEr/kuIdFiG5FopjfJGoJEMzCOWqQHvETUaAvVfdMKo8ZGydNS9FsuwyYnseyiOIbmPtT8zZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fG4jeJr/; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b421d38d138so23584a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 17:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753837122; x=1754441922; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHML0fVTZol4DLLRqimo4jzJSjhp3AKS45z0vIHCf/Y=;
        b=fG4jeJr/MXueyShYCJKLpXPkNXCLyJkZZvZSqrKQ0Ekqe5+SiWgOwE2372Rx0miiRz
         8Y/xN6cyqROc1ouRvs/tO7WcP496pZNbErhIGWW+wL4Zz5VbHb26PzNdWXQ46Ozubk5P
         de5ES52oyhJHd9RqbT4sLnE9UxHIE9dCbvBesE5I7ZTe500M+HJ7LQGANKuUkp9GISEM
         +B7Xh282wBrkPufvc+R0tmtr7YtCyyjE06z1ZI/fTojI2jQLBOcb/uD3lIKVvfG7RFJl
         tPGLxqBB0R/oqgCkyjw5F5HZe8kEClQSEt2wVQeP1gqnxzRt7OeHM1/cuxvadMjuwFhc
         x5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753837122; x=1754441922;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHML0fVTZol4DLLRqimo4jzJSjhp3AKS45z0vIHCf/Y=;
        b=it0eczAJuttag8P7guQcYATMoA+HWx8SfV8XtrGO9Q8ogRzGdBl0mVwoGntiesLNlq
         mZ8TdRjuUCmthHIjvVPrQrAJRSigi1nUxofOJMn5tKQyarFsMQpBVej5ff5BKJFE5dvV
         74FU7WaNWDVXOrlFYoPEovXLTLK5fOi1UblXuc44QAsEPKiOfaeFajts1eEwyeO84shL
         KQIGxr7EA03Kb1LYDi7BxtA1+76D3xfXHEEswBbmIkph+0hiyKnLq8sG7349/A4WX7ex
         36U04UjDnEHMadn8JTx+qvxiFLErY8ZxrTn4ry23/IJezOWJxcMHpN4+TyrxsWYxhaNA
         x55A==
X-Forwarded-Encrypted: i=1; AJvYcCWWjMMcXTHOmbR9AdwotHV+zUPsxHYKdm+gTF2C71FW6Gwp5b7fi+YU7l8AWOuAZiWz2g/M9dYCB7XvotI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHB1UEHepHq7PpMEYJ65LiJ5QnfaylnxNGVQW7twAIUQXAO/Wi
	bQbydwGrf6D0nKjsRBlsOBa/mM7GXtQ3XOZY30exqr15a++g9Da2qUsr1C6tcRZc3VZPdO6u+zN
	fxV2ZmQqu60Ui0IQ0tWnllg24fO2RCFqb44zdFQ==
X-Google-Smtp-Source: AGHT+IGKKEl35BJsLTBrUz3LPVkFRFj381DprHeoXqPOiIsnE2zVrxKnAt1I6K+wzrAviCs9wMxmhgog+ERuVKqxrX5d2w==
X-Received: from pfbbw8.prod.google.com ([2002:a05:6a00:4088:b0:741:8e1a:2d09])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:32a6:b0:21d:a9d:ba3b with SMTP id adf61e73a8af0-23dc10a54edmr1953340637.39.1753837122323;
 Tue, 29 Jul 2025 17:58:42 -0700 (PDT)
Date: Tue, 29 Jul 2025 17:58:07 -0700
In-Reply-To: <20250730005818.2793577-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730005818.2793577-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730005818.2793577-3-isaacmanjarres@google.com>
Subject: [PATCH 5.4.y 2/3] mm: update memfd seal write check to include F_SEAL_WRITE
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, gregkh@linuxfoundation.org, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: aliceryhl@google.com, stable@vger.kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andy Lutomirski <luto@kernel.org>, 
	Mike Kravetz <mike.kravetz@oracle.com>
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
index 47b292f9b4f8..c18a47a86e8b 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -152,7 +152,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vma->vm_flags |= VM_HUGETLB | VM_DONTEXPAND;
 	vma->vm_ops = &hugetlb_vm_ops;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 47d56c96447a..57cba6e4fdcd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2946,25 +2946,26 @@ static inline int pages_identical(struct page *page1, struct page *page2)
 }
 
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
index 264229680ad7..8475d56f5977 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2215,7 +2215,7 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 	struct shmem_inode_info *info = SHMEM_I(file_inode(file));
 	int ret;
 
-	ret = seal_check_future_write(info->seals, vma);
+	ret = seal_check_write(info->seals, vma);
 	if (ret)
 		return ret;
 
-- 
2.50.1.552.g942d659e1b-goog


