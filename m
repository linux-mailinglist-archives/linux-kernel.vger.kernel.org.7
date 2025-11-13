Return-Path: <linux-kernel+bounces-898939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0B5C5654B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E133A8A69
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73474331A45;
	Thu, 13 Nov 2025 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2ax2WoE2"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2F033122A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023305; cv=none; b=GwMXk8SZH2hPCJqAvRpNAium3VRVI0b/vk7BkM8OMLMFajEkjJLDt58UW1oVvWXPHlejV01BsbMtEkUFIxGmXCS5Er3pECt+PbkJ9J6w1HtAX3RucfOQiyTgzkqxKYnHsbqmbLszbuNumzDnuW/d8OXQc4Wj2QZ/jFpTlDqApBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023305; c=relaxed/simple;
	bh=p51EFJJy2kGl/YRAEf2FWG6l1tdOA0d2AJNEWs32EZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlGGchr/mw0SECbAs0M7JIM4SiEbNi5XOrqU2Ow7ZnTR/V6Iw2nrBvKzLygm/Qor3/Lo0E9Vw3DZK/Hk+JPa3RF6kKraaJVlpsnUkyi8Y984lGhbOMEFc4qWtddGgfuwdEZLvSyeAWxePcdb52DP1RkS7fRKVy3hWA9pfwwF+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2ax2WoE2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AfKEJ/8E556TJ//V6+LnkhkgNqFwxrbpTaLV4y74oRg=; b=2ax2WoE2DN/LkgU6bbBvf4xTF2
	c+bvilQkd2jAxEUSDT5CV1B0BClPkr6aBs4A9YPHK9Udtj9Fk2EctXUPW9fECd9Kw9egcjaHahjRO
	qpwgtMSw0eRZukdWdCP5TeCNBhL44f4gOLC+Yq666G9hw6VPnNS8u1ekvQxJ6xwYL+3vfj+9pqcnF
	KLvTNfQj6wZ0OGIAh29Uj3C05xfEoO/YGw8SONw0bN1af3oJZWwLqOxO4nBL66qAkZVamqT/gHGY3
	JPnocDHOSFY2VhuzD9E0JQfmB4ssOjkUBc2lgEixC9bjbKDrUgsiFrmCrrDBNF2mGT0GS4yrABUeo
	ebNnHqnQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJStf-0000000A7VA-1E7J;
	Thu, 13 Nov 2025 08:41:39 +0000
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
Subject: [PATCH 10/11] mempool: de-typedef
Date: Thu, 13 Nov 2025 09:39:51 +0100
Message-ID: <20251113084022.1255121-11-hch@lst.de>
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

Switch all uses of the deprecated mempool_t typedef in the core mempool
code to use struct mempool instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mempool.h | 39 ++++++++++++++++----------------
 mm/mempool.c            | 50 +++++++++++++++++++++--------------------
 2 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index d9332485e8ca..e8e440e04a06 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -27,32 +27,31 @@ typedef struct mempool {
 	wait_queue_head_t wait;
 } mempool_t;
 
-static inline bool mempool_initialized(mempool_t *pool)
+static inline bool mempool_initialized(struct mempool *pool)
 {
 	return pool->elements != NULL;
 }
 
-static inline bool mempool_is_saturated(mempool_t *pool)
+static inline bool mempool_is_saturated(struct mempool *pool)
 {
 	return READ_ONCE(pool->curr_nr) >= pool->min_nr;
 }
 
-void mempool_exit(mempool_t *pool);
-int mempool_init_node(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
-		      mempool_free_t *free_fn, void *pool_data,
-		      gfp_t gfp_mask, int node_id);
-
-int mempool_init_noprof(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
-		 mempool_free_t *free_fn, void *pool_data);
+void mempool_exit(struct mempool *pool);
+int mempool_init_node(struct mempool *pool, int min_nr,
+		mempool_alloc_t *alloc_fn, mempool_free_t *free_fn,
+		void *pool_data, gfp_t gfp_mask, int node_id);
+int mempool_init_noprof(struct mempool *pool, int min_nr,
+		mempool_alloc_t *alloc_fn, mempool_free_t *free_fn,
+		void *pool_data);
 #define mempool_init(...)						\
 	alloc_hooks(mempool_init_noprof(__VA_ARGS__))
 
-extern mempool_t *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
-			mempool_free_t *free_fn, void *pool_data);
-
-extern mempool_t *mempool_create_node_noprof(int min_nr, mempool_alloc_t *alloc_fn,
-			mempool_free_t *free_fn, void *pool_data,
-			gfp_t gfp_mask, int nid);
+struct mempool *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
+		mempool_free_t *free_fn, void *pool_data);
+struct mempool *mempool_create_node_noprof(int min_nr,
+		mempool_alloc_t *alloc_fn, mempool_free_t *free_fn,
+		void *pool_data, gfp_t gfp_mask, int nid);
 #define mempool_create_node(...)					\
 	alloc_hooks(mempool_create_node_noprof(__VA_ARGS__))
 
@@ -60,10 +59,10 @@ extern mempool_t *mempool_create_node_noprof(int min_nr, mempool_alloc_t *alloc_
 	mempool_create_node(_min_nr, _alloc_fn, _free_fn, _pool_data,	\
 			    GFP_KERNEL, NUMA_NO_NODE)
 
-extern int mempool_resize(mempool_t *pool, int new_min_nr);
-extern void mempool_destroy(mempool_t *pool);
+int mempool_resize(struct mempool *pool, int new_min_nr);
+void mempool_destroy(struct mempool *pool);
 
-extern void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask) __malloc;
+void *mempool_alloc_noprof(struct mempool *pool, gfp_t gfp_mask) __malloc;
 #define mempool_alloc(...)						\
 	alloc_hooks(mempool_alloc_noprof(__VA_ARGS__))
 int mempool_alloc_bulk_noprof(struct mempool *pool, void **elem,
@@ -71,8 +70,8 @@ int mempool_alloc_bulk_noprof(struct mempool *pool, void **elem,
 #define mempool_alloc_bulk(...)						\
 	alloc_hooks(mempool_alloc_bulk_noprof(__VA_ARGS__))
 
-extern void *mempool_alloc_preallocated(mempool_t *pool) __malloc;
-extern void mempool_free(void *element, mempool_t *pool);
+void *mempool_alloc_preallocated(struct mempool *pool) __malloc;
+void mempool_free(void *element, struct mempool *pool);
 unsigned int mempool_free_bulk(struct mempool *pool, void **elem,
 		unsigned int count);
 
diff --git a/mm/mempool.c b/mm/mempool.c
index 72c788888ed7..448ff2e578a0 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -40,7 +40,7 @@ static int __init mempool_faul_inject_init(void)
 late_initcall(mempool_faul_inject_init);
 
 #ifdef CONFIG_SLUB_DEBUG_ON
-static void poison_error(mempool_t *pool, void *element, size_t size,
+static void poison_error(struct mempool *pool, void *element, size_t size,
 			 size_t byte)
 {
 	const int nr = pool->curr_nr;
@@ -57,7 +57,7 @@ static void poison_error(mempool_t *pool, void *element, size_t size,
 	dump_stack();
 }
 
-static void __check_element(mempool_t *pool, void *element, size_t size)
+static void __check_element(struct mempool *pool, void *element, size_t size)
 {
 	u8 *obj = element;
 	size_t i;
@@ -73,7 +73,7 @@ static void __check_element(mempool_t *pool, void *element, size_t size)
 	memset(obj, POISON_INUSE, size);
 }
 
-static void check_element(mempool_t *pool, void *element)
+static void check_element(struct mempool *pool, void *element)
 {
 	/* Skip checking: KASAN might save its metadata in the element. */
 	if (kasan_enabled())
@@ -102,7 +102,7 @@ static void __poison_element(void *element, size_t size)
 	obj[size - 1] = POISON_END;
 }
 
-static void poison_element(mempool_t *pool, void *element)
+static void poison_element(struct mempool *pool, void *element)
 {
 	/* Skip poisoning: KASAN might save its metadata in the element. */
 	if (kasan_enabled())
@@ -123,15 +123,16 @@ static void poison_element(mempool_t *pool, void *element)
 	}
 }
 #else /* CONFIG_SLUB_DEBUG_ON */
-static inline void check_element(mempool_t *pool, void *element)
+static inline void check_element(struct mempool *pool, void *element)
 {
 }
-static inline void poison_element(mempool_t *pool, void *element)
+static inline void poison_element(struct mempool *pool, void *element)
 {
 }
 #endif /* CONFIG_SLUB_DEBUG_ON */
 
-static __always_inline bool kasan_poison_element(mempool_t *pool, void *element)
+static __always_inline bool kasan_poison_element(struct mempool *pool,
+		void *element)
 {
 	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
 		return kasan_mempool_poison_object(element);
@@ -141,7 +142,7 @@ static __always_inline bool kasan_poison_element(mempool_t *pool, void *element)
 	return true;
 }
 
-static void kasan_unpoison_element(mempool_t *pool, void *element)
+static void kasan_unpoison_element(struct mempool *pool, void *element)
 {
 	if (pool->alloc == mempool_kmalloc)
 		kasan_mempool_unpoison_object(element, (size_t)pool->pool_data);
@@ -153,7 +154,7 @@ static void kasan_unpoison_element(mempool_t *pool, void *element)
 					     (unsigned long)pool->pool_data);
 }
 
-static __always_inline void add_element(mempool_t *pool, void *element)
+static __always_inline void add_element(struct mempool *pool, void *element)
 {
 	BUG_ON(pool->min_nr != 0 && pool->curr_nr >= pool->min_nr);
 	poison_element(pool, element);
@@ -161,7 +162,7 @@ static __always_inline void add_element(mempool_t *pool, void *element)
 		pool->elements[pool->curr_nr++] = element;
 }
 
-static void *remove_element(mempool_t *pool)
+static void *remove_element(struct mempool *pool)
 {
 	void *element = pool->elements[--pool->curr_nr];
 
@@ -182,7 +183,7 @@ static void *remove_element(mempool_t *pool)
  * May be called on a zeroed but uninitialized mempool (i.e. allocated with
  * kzalloc()).
  */
-void mempool_exit(mempool_t *pool)
+void mempool_exit(struct mempool *pool)
 {
 	while (pool->curr_nr) {
 		void *element = remove_element(pool);
@@ -201,7 +202,7 @@ EXPORT_SYMBOL(mempool_exit);
  * Free all reserved elements in @pool and @pool itself.  This function
  * only sleeps if the free_fn() function sleeps.
  */
-void mempool_destroy(mempool_t *pool)
+void mempool_destroy(struct mempool *pool)
 {
 	if (unlikely(!pool))
 		return;
@@ -211,9 +212,9 @@ void mempool_destroy(mempool_t *pool)
 }
 EXPORT_SYMBOL(mempool_destroy);
 
-int mempool_init_node(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
-		      mempool_free_t *free_fn, void *pool_data,
-		      gfp_t gfp_mask, int node_id)
+int mempool_init_node(struct mempool *pool, int min_nr,
+		mempool_alloc_t *alloc_fn, mempool_free_t *free_fn,
+		void *pool_data, gfp_t gfp_mask, int node_id)
 {
 	spin_lock_init(&pool->lock);
 	pool->min_nr	= min_nr;
@@ -263,8 +264,9 @@ EXPORT_SYMBOL(mempool_init_node);
  *
  * Return: %0 on success, negative error code otherwise.
  */
-int mempool_init_noprof(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
-			mempool_free_t *free_fn, void *pool_data)
+int mempool_init_noprof(struct mempool *pool, int min_nr,
+		mempool_alloc_t *alloc_fn, mempool_free_t *free_fn,
+		void *pool_data)
 {
 	return mempool_init_node(pool, min_nr, alloc_fn, free_fn,
 				 pool_data, GFP_KERNEL, NUMA_NO_NODE);
@@ -290,11 +292,11 @@ EXPORT_SYMBOL(mempool_init_noprof);
  *
  * Return: pointer to the created memory pool object or %NULL on error.
  */
-mempool_t *mempool_create_node_noprof(int min_nr, mempool_alloc_t *alloc_fn,
-				      mempool_free_t *free_fn, void *pool_data,
-				      gfp_t gfp_mask, int node_id)
+struct mempool *mempool_create_node_noprof(int min_nr,
+		mempool_alloc_t *alloc_fn, mempool_free_t *free_fn,
+		void *pool_data, gfp_t gfp_mask, int node_id)
 {
-	mempool_t *pool;
+	struct mempool *pool;
 
 	pool = kmalloc_node_noprof(sizeof(*pool), gfp_mask | __GFP_ZERO, node_id);
 	if (!pool)
@@ -328,7 +330,7 @@ EXPORT_SYMBOL(mempool_create_node_noprof);
  *
  * Return: %0 on success, negative error code otherwise.
  */
-int mempool_resize(mempool_t *pool, int new_min_nr)
+int mempool_resize(struct mempool *pool, int new_min_nr)
 {
 	void *element;
 	void **new_elements;
@@ -530,7 +532,7 @@ EXPORT_SYMBOL_GPL(mempool_alloc_bulk_noprof);
  * an element.  Allocation failure can only happen when @gfp_mask does not
  * include %__GFP_DIRECT_RECLAIM.
  */
-void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
+void *mempool_alloc_noprof(struct mempool *pool, gfp_t gfp_mask)
 {
 	gfp_t gfp_temp = mempool_adjust_gfp(&gfp_mask);
 	void *element;
@@ -578,7 +580,7 @@ EXPORT_SYMBOL(mempool_alloc_noprof);
  * Return: pointer to the allocated element or %NULL if no elements are
  * available.
  */
-void *mempool_alloc_preallocated(mempool_t *pool)
+void *mempool_alloc_preallocated(struct mempool *pool)
 {
 	void *element = NULL;
 
-- 
2.47.3


