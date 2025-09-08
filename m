Return-Path: <linux-kernel+bounces-806010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEE5B490B0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529A83BD067
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6629730BF59;
	Mon,  8 Sep 2025 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hmtlGjzm"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AFC22FE0D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340381; cv=none; b=W/UY6cMIahuIdHUZgKoYtjJlUpAq0a4eRHduu5+UklcxspxwYEY2mhPJUoZUVdeME+MdN1u+ovVe6JEGc49esqHMIFvyi9IJ+i2lLJfmRr8W6SSH/6rEKHPnivYQbhrrxdobXmv9rlb/bhYGSIr794xTuFWH6brGrp0LcxrNjvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340381; c=relaxed/simple;
	bh=UpWAeS+9ohByPvWTqYYKg9oIeq1Xk39/7J0w2jmCT+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X3Dq3pfcOjJwh8l2VH+w/2uYmvNGiF6B9z31YOJAXxFcZogaMyQDbFyoqitJRyaYqyYWj6CN0qBhd+XRP1TSwwv3bGTIKfJtwtCoSliOovZSa92ewOU1T/btC8zjn01RFfMxb4CZTKmS/7XupofJ/C9MQirmxMZLSHEUqt9cgTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hmtlGjzm; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757340375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VDoikzz6aWVYuIc2+JSxHrk0vkVl4ua3xQEWiywgjQ4=;
	b=hmtlGjzmkfcppimA56uWjEYY1cnvcf7MPxwCd9vwT/tKgyuIdhuI9MtM1Iy3ovuS0YOXf4
	UuQJgbo6L1fW9aGeUptsvj12mEN6JNArM86CWBX1Dj0ev2zl4ZTh3B9pi+Wv9dYRNaMRnZ
	rBZI3c2C2YBuCoOY97r6hoJ6HNpCvyg=
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	riel@surriel.com,
	harry.yoo@oracle.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [RFC PATCH v2] mm/rmap: make num_children and num_active_vmas update in internally
Date: Mon,  8 Sep 2025 14:05:04 +0000
Message-ID: <20250908140505.26237-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If the anon_vma_alloc() is called, the num_children of the parent of
the anon_vma will be updated. But this operation occurs outside of
anon_vma_alloc(). There are two callers, one has itself as its parent,
while another has a real parent. That means they have the same logic.

The update of num_active_vmas and vma->anon_vma are not performed
together. These operations should be performed under a function.

Add an __anon_vma_alloc() function that implements anon_vma_alloc().
If the caller has a real parent, called __anon_vma_alloc() and pass
the parent to it. If it not, called anon_vma_alloc() directly. It will
set the parent and root of the anon_vma and also updates the num_children
of its parent anon_vma.

Introduce vma_attach_anon() and vma_detach_anon() to update
num_active_vmas with vma->anon_vma together.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v2: fix a WARNING in unlink_anon_vmas and optimize the code
v1: https://lore.kernel.org/all/20250905132019.18915-1-yajun.deng@linux.dev/
---
 mm/internal.h | 17 ++++++++++++++
 mm/rmap.c     | 64 +++++++++++++++++++++++++++++----------------------
 2 files changed, 53 insertions(+), 28 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 9b0129531d00..12bc71bb2304 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -953,6 +953,23 @@ static inline bool free_area_empty(struct free_area *area, int migratetype)
 	return list_empty(&area->free_list[migratetype]);
 }
 
+static inline void vma_attach_anon(struct vm_area_struct *vma,
+				   struct anon_vma *anon_vma)
+{
+	mmap_assert_locked(vma->vm_mm);
+	lockdep_assert_held_write(&anon_vma->root->rwsem);
+	vma->anon_vma = anon_vma;
+	vma->anon_vma->num_active_vmas++;
+}
+
+static inline void vma_detach_anon(struct vm_area_struct *vma)
+{
+	mmap_assert_locked(vma->vm_mm);
+	lockdep_assert_held_write(&vma->anon_vma->root->rwsem);
+	vma->anon_vma->num_active_vmas--;
+	vma->anon_vma = NULL;
+}
+
 /* mm/util.c */
 struct anon_vma *folio_anon_vma(const struct folio *folio);
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 34333ae3bd80..de557707c34a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -86,15 +86,25 @@
 static struct kmem_cache *anon_vma_cachep;
 static struct kmem_cache *anon_vma_chain_cachep;
 
-static inline struct anon_vma *anon_vma_alloc(void)
+static inline struct anon_vma *__anon_vma_alloc(struct anon_vma *parent)
 {
 	struct anon_vma *anon_vma;
 
 	anon_vma = kmem_cache_alloc(anon_vma_cachep, GFP_KERNEL);
-	if (anon_vma) {
-		atomic_set(&anon_vma->refcount, 1);
-		anon_vma->num_children = 0;
-		anon_vma->num_active_vmas = 0;
+	if (!anon_vma)
+		return NULL;
+
+	atomic_set(&anon_vma->refcount, 1);
+	anon_vma->num_children = 0;
+	anon_vma->num_active_vmas = 0;
+	if (parent) {
+		/*
+		 * The root anon_vma's rwsem is the lock actually used when we
+		 * lock any of the anon_vmas in this anon_vma tree.
+		 */
+		anon_vma->parent = parent;
+		anon_vma->root = parent->root;
+	} else {
 		anon_vma->parent = anon_vma;
 		/*
 		 * Initialise the anon_vma root to point to itself. If called
@@ -102,10 +112,18 @@ static inline struct anon_vma *anon_vma_alloc(void)
 		 */
 		anon_vma->root = anon_vma;
 	}
+	anon_vma_lock_write(anon_vma);
+	anon_vma->parent->num_children++;
+	anon_vma_unlock_write(anon_vma);
 
 	return anon_vma;
 }
 
+static inline struct anon_vma *anon_vma_alloc(void)
+{
+	return __anon_vma_alloc(NULL);
+}
+
 static inline void anon_vma_free(struct anon_vma *anon_vma)
 {
 	VM_BUG_ON(atomic_read(&anon_vma->refcount));
@@ -201,7 +219,6 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
 		anon_vma = anon_vma_alloc();
 		if (unlikely(!anon_vma))
 			goto out_enomem_free_avc;
-		anon_vma->num_children++; /* self-parent link for new root */
 		allocated = anon_vma;
 	}
 
@@ -209,9 +226,8 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
 	/* page_table_lock to protect against threads */
 	spin_lock(&mm->page_table_lock);
 	if (likely(!vma->anon_vma)) {
-		vma->anon_vma = anon_vma;
+		vma_attach_anon(vma, anon_vma);
 		anon_vma_chain_link(vma, avc, anon_vma);
-		anon_vma->num_active_vmas++;
 		allocated = NULL;
 		avc = NULL;
 	}
@@ -355,38 +371,31 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
 	if (vma->anon_vma)
 		return 0;
 
-	/* Then add our own anon_vma. */
-	anon_vma = anon_vma_alloc();
-	if (!anon_vma)
-		goto out_error;
-	anon_vma->num_active_vmas++;
 	avc = anon_vma_chain_alloc(GFP_KERNEL);
 	if (!avc)
-		goto out_error_free_anon_vma;
+		goto out_error;
+
+	/* Then add our own anon_vma. */
+	anon_vma = __anon_vma_alloc(pvma->anon_vma);
+	if (!anon_vma)
+		goto out_error_free_avc;
 
-	/*
-	 * The root anon_vma's rwsem is the lock actually used when we
-	 * lock any of the anon_vmas in this anon_vma tree.
-	 */
-	anon_vma->root = pvma->anon_vma->root;
-	anon_vma->parent = pvma->anon_vma;
 	/*
 	 * With refcounts, an anon_vma can stay around longer than the
 	 * process it belongs to. The root anon_vma needs to be pinned until
 	 * this anon_vma is freed, because the lock lives in the root.
 	 */
 	get_anon_vma(anon_vma->root);
-	/* Mark this anon_vma as the one where our new (COWed) pages go. */
-	vma->anon_vma = anon_vma;
 	anon_vma_lock_write(anon_vma);
+	/* Mark this anon_vma as the one where our new (COWed) pages go. */
+	vma_attach_anon(vma, anon_vma);
 	anon_vma_chain_link(vma, avc, anon_vma);
-	anon_vma->parent->num_children++;
 	anon_vma_unlock_write(anon_vma);
 
 	return 0;
 
- out_error_free_anon_vma:
-	put_anon_vma(anon_vma);
+ out_error_free_avc:
+	anon_vma_chain_free(avc);
  out_error:
 	unlink_anon_vmas(vma);
 	return -ENOMEM;
@@ -420,14 +429,13 @@ void unlink_anon_vmas(struct vm_area_struct *vma)
 		anon_vma_chain_free(avc);
 	}
 	if (vma->anon_vma) {
-		vma->anon_vma->num_active_vmas--;
-
 		/*
 		 * vma would still be needed after unlink, and anon_vma will be prepared
 		 * when handle fault.
 		 */
-		vma->anon_vma = NULL;
+		vma_detach_anon(vma);
 	}
+
 	unlock_anon_vma_root(root);
 
 	/*
-- 
2.25.1


