Return-Path: <linux-kernel+bounces-898936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2252BC56537
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF493A85D4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA10D3321D4;
	Thu, 13 Nov 2025 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vG62U7I3"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D2B3321C4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023282; cv=none; b=EDnUS1a7luFEh/hdepdG3w3bsw9VVJkY07Kt4dVfCnfwlGkLSXUaYts9kgJ0/qSshWDI1s1pXNdHUUek720zGL07fK3WzPFFKkPLTNp4cowVogYnp49/wUDZ1MSTdN3EuU3GKdPnPpXkn+lGP/Pl99iuw6eqZYmGpJ17wohFfis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023282; c=relaxed/simple;
	bh=rZ9oOdY3n5aGmjHwsDn5zHSn0nGDZOTD5GGpmfgAbJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzvnOkS3qn/j2PPHczh+qUC9U+rz1/JoxHAsP+ui24TWmOWIGK2hbMcVU/An0yFi8S2V9DiSubN7LUbkTo56tdc3gVO9fHbV+6/TSrTZ4kc3k7j5MtUcC+83hCGMS0Zj0u3yvo+Xx9V7vLnJ2T3c6/X29lwovBqa9HDkUL3RiGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vG62U7I3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PnHKzcO6wKUO2hUXwbtJ8h7p3RHH+OB61u/AP3cRlrA=; b=vG62U7I3gzI7SWYyjtkhCcwha5
	qiE/pO/2dR17nwx67X8CJhriUbEqQwcsQKiJaAs8sD29xPMNFlpmc5qTaViKXkGAgTLhK7o2fzDp5
	jVPVoZyBhBDtXa69oq7qcY44idMcBl3cguQrtEsxQIPChSaZhIaXguF62kEES9MARFSEBzN0ArmHj
	yC0VrCftVjNeewdYBQ5NHYCD+2KVB6arn+9KdUephu30FWO5Cx58TOgvdLQuiBc3i6RvNn0C3a2Tp
	HFJG8P/OCH0ILNDQFBPO2Fgn6lgVdxTY6eyKMCgsYBUV1zY8aAHupW8OEFUbGQ5p+DRoIBooQJ6lj
	gcjo4oUg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJStI-0000000A7TN-1ml7;
	Thu, 13 Nov 2025 08:41:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] mempool: add mempool_{alloc,free}_bulk
Date: Thu, 13 Nov 2025 09:39:48 +0100
Message-ID: <20251113084022.1255121-8-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113084022.1255121-1-hch@lst.de>
References: <20251113084022.1255121-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a version of the mempool allocator that works for batch allocations
of multiple objects.  Calling mempool_alloc in a loop is not safe because
it could deadlock if multiple threads are performing such an allocation
at the same time.

As an extra benefit the interface is build so that the same array can be
used for alloc_pages_bulk / release_pages so that at least for page
backed mempools the fast path can use a nice batch optimization.

Note that mempool_alloc_bulk does not take a gfp_mask argument as it
must always be able to sleep and doesn't support any non-trivial
modifiers.  NOFO or NOIO constrainst must be set through the scoped API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mempool.h |   6 ++
 mm/mempool.c            | 178 ++++++++++++++++++++++++++++++----------
 2 files changed, 142 insertions(+), 42 deletions(-)

diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index 34941a4b9026..e914fec0e119 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -66,9 +66,15 @@ extern void mempool_destroy(mempool_t *pool);
 extern void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask) __malloc;
 #define mempool_alloc(...)						\
 	alloc_hooks(mempool_alloc_noprof(__VA_ARGS__))
+int mempool_alloc_bulk_noprof(struct mempool *pool, void **elem,
+		unsigned int count, unsigned int allocated);
+#define mempool_alloc_bulk(...)						\
+	alloc_hooks(mempool_alloc_bulk_noprof(__VA_ARGS__))
 
 extern void *mempool_alloc_preallocated(mempool_t *pool) __malloc;
 extern void mempool_free(void *element, mempool_t *pool);
+unsigned int mempool_free_bulk(struct mempool *pool, void **elem,
+		unsigned int count);
 
 /*
  * A mempool_alloc_t and mempool_free_t that get the memory from
diff --git a/mm/mempool.c b/mm/mempool.c
index c28087a3b8a9..88b9a8476d31 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -21,11 +21,21 @@
 #include "slab.h"
 
 static DECLARE_FAULT_ATTR(fail_mempool_alloc);
+static DECLARE_FAULT_ATTR(fail_mempool_alloc_bulk);
 
 static int __init mempool_faul_inject_init(void)
 {
-	return PTR_ERR_OR_ZERO(fault_create_debugfs_attr("fail_mempool_alloc",
+	int error;
+
+	error = PTR_ERR_OR_ZERO(fault_create_debugfs_attr("fail_mempool_alloc",
 			NULL, &fail_mempool_alloc));
+	if (error)
+		return error;
+
+	/* booting will fail on error return here, don't bother to cleanup */
+	return PTR_ERR_OR_ZERO(
+		fault_create_debugfs_attr("fail_mempool_alloc_bulk", NULL,
+		&fail_mempool_alloc_bulk));
 }
 late_initcall(mempool_faul_inject_init);
 
@@ -380,15 +390,22 @@ int mempool_resize(mempool_t *pool, int new_min_nr)
 }
 EXPORT_SYMBOL(mempool_resize);
 
-static void *mempool_alloc_from_pool(struct mempool *pool, gfp_t gfp_mask)
+static unsigned int mempool_alloc_from_pool(struct mempool *pool, void **elems,
+		unsigned int count, unsigned int allocated,
+		gfp_t gfp_mask)
 {
 	unsigned long flags;
-	void *element;
+	unsigned int i;
 
 	spin_lock_irqsave(&pool->lock, flags);
-	if (unlikely(!pool->curr_nr))
+	if (unlikely(pool->curr_nr < count - allocated))
 		goto fail;
-	element = remove_element(pool);
+	for (i = 0; i < count; i++) {
+		if (!elems[i]) {
+			elems[i] = remove_element(pool);
+			allocated++;
+		}
+	}
 	spin_unlock_irqrestore(&pool->lock, flags);
 
 	/* Paired with rmb in mempool_free(), read comment there. */
@@ -398,8 +415,9 @@ static void *mempool_alloc_from_pool(struct mempool *pool, gfp_t gfp_mask)
 	 * Update the allocation stack trace as this is more useful for
 	 * debugging.
 	 */
-	kmemleak_update_trace(element);
-	return element;
+	for (i = 0; i < count; i++)
+		kmemleak_update_trace(elems[i]);
+	return allocated;
 
 fail:
 	if (gfp_mask & __GFP_DIRECT_RECLAIM) {
@@ -421,7 +439,7 @@ static void *mempool_alloc_from_pool(struct mempool *pool, gfp_t gfp_mask)
 		spin_unlock_irqrestore(&pool->lock, flags);
 	}
 
-	return NULL;
+	return allocated;
 }
 
 /*
@@ -437,6 +455,65 @@ static inline gfp_t mempool_adjust_gfp(gfp_t *gfp_mask)
 	return *gfp_mask & ~(__GFP_DIRECT_RECLAIM | __GFP_IO);
 }
 
+/**
+ * mempool_alloc_bulk - allocate multiple elements from a memory pool
+ * @pool:	pointer to the memory pool
+ * @elems:	partially or fully populated elements array
+ * @count:	number of entries in @elem that need to be allocated
+ * @allocated:	number of entries in @elem already allocated
+ *
+ * Allocate elements for each slot in @elem that is non-%NULL. This is done by
+ * first calling into the alloc_fn supplied at pool initialization time, and
+ * dipping into the reserved pool when alloc_fn fails to allocate an element.
+ *
+ * On return all @count elements in @elems will be populated.
+ *
+ * Return: Always 0.  If it wasn't for %$#^$ alloc tags, it would return void.
+ */
+int mempool_alloc_bulk_noprof(struct mempool *pool, void **elems,
+		unsigned int count, unsigned int allocated)
+{
+	gfp_t gfp_mask = GFP_KERNEL;
+	gfp_t gfp_temp = mempool_adjust_gfp(&gfp_mask);
+	unsigned int i = 0;
+
+	VM_WARN_ON_ONCE(count > pool->min_nr);
+	might_alloc(gfp_mask);
+
+	/*
+	 * If an error is injected, fail all elements in a bulk allocation so
+	 * that we stress the multiple elements missing path.
+	 */
+	if (should_fail_ex(&fail_mempool_alloc_bulk, 1, FAULT_NOWARN)) {
+		pr_info("forcing mempool usage for %pS\n",
+				(void *)_RET_IP_);
+		goto use_pool;
+	}
+
+repeat_alloc:
+	/*
+	 * Try to allocate the elements using the allocation callback first as
+	 * that might succeed even when the caller's bulk allocation did not.
+	 */
+	for (i = 0; i < count; i++) {
+		if (elems[i])
+			continue;
+		elems[i] = pool->alloc(gfp_temp, pool->pool_data);
+		if (unlikely(!elems[i]))
+			goto use_pool;
+		allocated++;
+	}
+
+	return 0;
+
+use_pool:
+	allocated = mempool_alloc_from_pool(pool, elems, count, allocated,
+			gfp_temp);
+	gfp_temp = gfp_mask;
+	goto repeat_alloc;
+}
+EXPORT_SYMBOL_GPL(mempool_alloc_bulk_noprof);
+
 /**
  * mempool_alloc - allocate an element from a memory pool
  * @pool:	pointer to the memory pool
@@ -478,8 +555,8 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
 		 * sleep in mempool_alloc_from_pool.  Retry the allocation
 		 * with all flags set in that case.
 		 */
-		element = mempool_alloc_from_pool(pool, gfp_mask);
-		if (!element && gfp_temp != gfp_mask) {
+		if (!mempool_alloc_from_pool(pool, &element, 1, 0, gfp_mask) &&
+		    gfp_temp != gfp_mask) {
 			gfp_temp = gfp_mask;
 			goto repeat_alloc;
 		}
@@ -503,26 +580,33 @@ EXPORT_SYMBOL(mempool_alloc_noprof);
  */
 void *mempool_alloc_preallocated(mempool_t *pool)
 {
-	return mempool_alloc_from_pool(pool, GFP_NOWAIT);
+	void *element = NULL;
+
+	mempool_alloc_from_pool(pool, &element, 1, 0, GFP_NOWAIT);
+	return element;
 }
 EXPORT_SYMBOL(mempool_alloc_preallocated);
 
 /**
- * mempool_free - return an element to a mempool
- * @element:	pointer to element
+ * mempool_free_bulk - return elements to a mempool
  * @pool:	pointer to the memory pool
+ * @elems:	elements to return
+ * @count:	number of elements to return
  *
- * Returns @element to @pool if it needs replenishing, else frees it using
- * the free_fn callback in @pool.
+ * Returns a number of elements from the start of @elem to @pool if @pool needs
+ * replenishing and sets their slots in @elem to NULL.  Other elements are left
+ * in @elem.
  *
- * This function only sleeps if the free_fn callback sleeps.
+ * Return: number of elements transferred to @pool.  Elements are always
+ * transferred from the beginning of @elem, so the return value can be used as
+ * an offset into @elem for the freeing the remaining elements in the caller.
  */
-void mempool_free(void *element, mempool_t *pool)
+unsigned int mempool_free_bulk(struct mempool *pool, void **elems,
+		unsigned int count)
 {
 	unsigned long flags;
-
-	if (unlikely(element == NULL))
-		return;
+	unsigned int freed = 0;
+	bool added = false;
 
 	/*
 	 * Paired with the wmb in mempool_alloc().  The preceding read is
@@ -556,21 +640,6 @@ void mempool_free(void *element, mempool_t *pool)
 	 * Waiters happen iff curr_nr is 0 and the above guarantee also
 	 * ensures that there will be frees which return elements to the
 	 * pool waking up the waiters.
-	 */
-	if (unlikely(READ_ONCE(pool->curr_nr) < pool->min_nr)) {
-		spin_lock_irqsave(&pool->lock, flags);
-		if (likely(pool->curr_nr < pool->min_nr)) {
-			add_element(pool, element);
-			spin_unlock_irqrestore(&pool->lock, flags);
-			if (wq_has_sleeper(&pool->wait))
-				wake_up(&pool->wait);
-			return;
-		}
-		spin_unlock_irqrestore(&pool->lock, flags);
-	}
-
-	/*
-	 * Handle the min_nr = 0 edge case:
 	 *
 	 * For zero-minimum pools, curr_nr < min_nr (0 < 0) never succeeds,
 	 * so waiters sleeping on pool->wait would never be woken by the
@@ -578,20 +647,45 @@ void mempool_free(void *element, mempool_t *pool)
 	 * allocation of element when both min_nr and curr_nr are 0, and
 	 * any active waiters are properly awakened.
 	 */
-	if (unlikely(pool->min_nr == 0 &&
+	if (unlikely(READ_ONCE(pool->curr_nr) < pool->min_nr)) {
+		spin_lock_irqsave(&pool->lock, flags);
+		while (pool->curr_nr < pool->min_nr && freed < count) {
+			add_element(pool, elems[freed++]);
+			added = true;
+		}
+		spin_unlock_irqrestore(&pool->lock, flags);
+	} else if (unlikely(pool->min_nr == 0 &&
 		     READ_ONCE(pool->curr_nr) == 0)) {
+		/* Handle the min_nr = 0 edge case: */
 		spin_lock_irqsave(&pool->lock, flags);
 		if (likely(pool->curr_nr == 0)) {
-			add_element(pool, element);
-			spin_unlock_irqrestore(&pool->lock, flags);
-			if (wq_has_sleeper(&pool->wait))
-				wake_up(&pool->wait);
-			return;
+			add_element(pool, elems[freed++]);
+			added = true;
 		}
 		spin_unlock_irqrestore(&pool->lock, flags);
 	}
 
-	pool->free(element, pool->pool_data);
+	if (unlikely(added) && wq_has_sleeper(&pool->wait))
+		wake_up(&pool->wait);
+
+	return freed;
+}
+EXPORT_SYMBOL_GPL(mempool_free_bulk);
+
+/**
+ * mempool_free - return an element to the pool.
+ * @element:	element to return
+ * @pool:	pointer to the memory pool
+ *
+ * Returns @element to @pool if it needs replenishing, else frees it using
+ * the free_fn callback in @pool.
+ *
+ * This function only sleeps if the free_fn callback sleeps.
+ */
+void mempool_free(void *element, struct mempool *pool)
+{
+	if (likely(element) && !mempool_free_bulk(pool, &element, 1))
+		pool->free(element, pool->pool_data);
 }
 EXPORT_SYMBOL(mempool_free);
 
-- 
2.47.3


