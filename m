Return-Path: <linux-kernel+bounces-802945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911D2B458AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA9D3AA683
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5271D5CC9;
	Fri,  5 Sep 2025 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qGeu3sbv"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274191E531
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757078490; cv=none; b=q4RlmmF8/JocTK3KChpXvldvlI/3MzuTAsPIF6hrNDG08xn7u2Pak1eEN97O0DKhIJaHI89i8tNzXeVqOE2sSpofxfrju8ptKCECiujyw21SDmnZ3+SOEgp7t94JhBhZK2vnbBj42CqQbZFKDCsdu+kYv+ceCiKBbGqt1FwrODE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757078490; c=relaxed/simple;
	bh=LK2+vtW1xckYUaT9tRrkr8jKCkiYgGMjAuujyGJiJ1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R0dAfi4dKfKcNX9dLTVyJl/TtGNfUdtLKi0+VaaEFdU+Y75iCllTSpQ0uwl4Ft3qt0VAPE7o4f7AGePT18mgiYHUsbUQfvDUpbMAW811r2Ajk34ur6O7X/9qEei0aRedq0ETZWylsmRn/0KEf3O32+o9xAhSRUUwFduPEuBo7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qGeu3sbv; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757078485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+ErkcM5ydIShVlp/tyt/SXag8Ues3JjwXCCvd9mJD34=;
	b=qGeu3sbvk+L1QKKYBhlIRF/rq4VAH22HI9Bl+BusQN9C4CgQhqRvbK9EtlLMfJ9HnYNQKI
	8cjWc1ZxpTsLzOLIozlvtI3Wl0cd18Z+0Tq8GSD4MCSppQG+UxXdlX7k+PemCmImmhUECn
	qaUoPE9F+Vohqoptq22pqqVMSgPuxLQ=
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	riel@surriel.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	harry.yoo@oracle.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/rmap: make num_children and num_active_vmas update in internally
Date: Fri,  5 Sep 2025 13:20:19 +0000
Message-ID: <20250905132019.18915-1-yajun.deng@linux.dev>
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
anon_vma_alloc().

The num_active_vmas are also updated outside of anon_vma.

Pass the parent of anon_vma to the anon_vma_alloc() and update the
num_children inside it.

Introduce anon_vma_attach() and anon_vma_detach() to update
num_active_vmas with the anon_vma.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/rmap.c | 63 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 34333ae3bd80..2a28edfa5734 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -86,15 +86,21 @@
 static struct kmem_cache *anon_vma_cachep;
 static struct kmem_cache *anon_vma_chain_cachep;
 
-static inline struct anon_vma *anon_vma_alloc(void)
+static inline struct anon_vma *anon_vma_alloc(struct anon_vma *parent)
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
+		anon_vma->parent = parent;
+		anon_vma->root = parent->root;
+	} else {
 		anon_vma->parent = anon_vma;
 		/*
 		 * Initialise the anon_vma root to point to itself. If called
@@ -102,6 +108,7 @@ static inline struct anon_vma *anon_vma_alloc(void)
 		 */
 		anon_vma->root = anon_vma;
 	}
+	anon_vma->parent->num_children++;
 
 	return anon_vma;
 }
@@ -146,6 +153,19 @@ static void anon_vma_chain_free(struct anon_vma_chain *anon_vma_chain)
 	kmem_cache_free(anon_vma_chain_cachep, anon_vma_chain);
 }
 
+static inline void anon_vma_attach(struct vm_area_struct *vma,
+				   struct anon_vma *anon_vma)
+{
+	vma->anon_vma = anon_vma;
+	vma->anon_vma->num_active_vmas++;
+}
+
+static inline void anon_vma_detach(struct vm_area_struct *vma)
+{
+	vma->anon_vma->num_active_vmas--;
+	vma->anon_vma = NULL;
+}
+
 static void anon_vma_chain_link(struct vm_area_struct *vma,
 				struct anon_vma_chain *avc,
 				struct anon_vma *anon_vma)
@@ -198,10 +218,9 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
 	anon_vma = find_mergeable_anon_vma(vma);
 	allocated = NULL;
 	if (!anon_vma) {
-		anon_vma = anon_vma_alloc();
+		anon_vma = anon_vma_alloc(NULL);
 		if (unlikely(!anon_vma))
 			goto out_enomem_free_avc;
-		anon_vma->num_children++; /* self-parent link for new root */
 		allocated = anon_vma;
 	}
 
@@ -209,9 +228,8 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
 	/* page_table_lock to protect against threads */
 	spin_lock(&mm->page_table_lock);
 	if (likely(!vma->anon_vma)) {
-		vma->anon_vma = anon_vma;
+		anon_vma_attach(vma, anon_vma);
 		anon_vma_chain_link(vma, avc, anon_vma);
-		anon_vma->num_active_vmas++;
 		allocated = NULL;
 		avc = NULL;
 	}
@@ -306,10 +324,8 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
 		if (!dst->anon_vma && src->anon_vma &&
 		    anon_vma->num_children < 2 &&
 		    anon_vma->num_active_vmas == 0)
-			dst->anon_vma = anon_vma;
+			anon_vma_attach(dst, anon_vma);
 	}
-	if (dst->anon_vma)
-		dst->anon_vma->num_active_vmas++;
 	unlock_anon_vma_root(root);
 	return 0;
 
@@ -356,31 +372,22 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
 		return 0;
 
 	/* Then add our own anon_vma. */
-	anon_vma = anon_vma_alloc();
+	anon_vma = anon_vma_alloc(pvma->anon_vma);
 	if (!anon_vma)
 		goto out_error;
-	anon_vma->num_active_vmas++;
 	avc = anon_vma_chain_alloc(GFP_KERNEL);
 	if (!avc)
 		goto out_error_free_anon_vma;
 
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
+	anon_vma_attach(vma, anon_vma);
 	anon_vma_lock_write(anon_vma);
 	anon_vma_chain_link(vma, avc, anon_vma);
-	anon_vma->parent->num_children++;
 	anon_vma_unlock_write(anon_vma);
 
 	return 0;
@@ -419,15 +426,9 @@ void unlink_anon_vmas(struct vm_area_struct *vma)
 		list_del(&avc->same_vma);
 		anon_vma_chain_free(avc);
 	}
-	if (vma->anon_vma) {
-		vma->anon_vma->num_active_vmas--;
+	if (vma->anon_vma)
+		anon_vma_detach(vma);
 
-		/*
-		 * vma would still be needed after unlink, and anon_vma will be prepared
-		 * when handle fault.
-		 */
-		vma->anon_vma = NULL;
-	}
 	unlock_anon_vma_root(root);
 
 	/*
-- 
2.25.1


