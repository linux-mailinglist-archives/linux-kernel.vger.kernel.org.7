Return-Path: <linux-kernel+bounces-898935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ECDC565A5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 358DD4EA86C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFD732E75E;
	Thu, 13 Nov 2025 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F8vH+9EI"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6390032F74B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023276; cv=none; b=bo6hMqscemdg0AwuLlTK9tWfLUp4O6WnRawuvJ8GzikNSxNz7ffKBIvZD41AIbjaHOnPtvBRgw0W+sW9g5WaSJRsrjK61dCwSMq5A2yUwmCYj//BVMMfge7enFds16CkTkQj5Bpj9nvwcySZZrIF3qJZqf6+c+jIKk2kKjzGSL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023276; c=relaxed/simple;
	bh=r8q+n3OcpvAzvWIQievAm0aAQtw2d6Pq5cNxFjQwoLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAv8+1wiu96uZwr8uRScaCx8rb3sfrhQQeVrdv5yC4T4xMtntvfDPc+xUDnKStEQzCFiQ92EeS0qBfTxUV1gPsesX32He97rNjxzmO1LByY/M9G1BUzqSTOs1KBR5345l1eKkbdJxMLSok1zYMo7cMjyCNYFqOO1kCkflQ7yph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F8vH+9EI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=aDSpBqpuPDvNgRiKLctHSSMS3KA13s/a0UYvKEJUm9Y=; b=F8vH+9EIobv+MIMPOxmAy+XOQN
	wGvS3vqQgDf7qirAMIahwxY8ZH5xWqd0FPz1x0Ucts2QO3m9pQLHBzwGnTL8HTTjczSs27XPIW2LV
	ABB7un6YVzZpogRbsbgObFbPEPjTD2KcLLPNenCRMbWRnDqf34XVFnDzvlOQfVqBzExqWLfv9Nsus
	KvD/L8HAXfvckRFLXZ1o0ZeOnx4EgvUB0JTQw2YokmyWee5YMFYeKaYHmbf4DE37M/dQXqlXiRONy
	3T68E9NsI6yruVXpJnTo2/DGKcpYlnnezyRVs0oex0VeyW4p0QaEcC4Xp5yt1JIJMf4ktpT8pc2qc
	hTazqwIg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJStD-0000000A7Sb-3YlU;
	Thu, 13 Nov 2025 08:41:12 +0000
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
Subject: [PATCH 06/11] mempool: factor out a mempool_alloc_from_pool helper
Date: Thu, 13 Nov 2025 09:39:47 +0100
Message-ID: <20251113084022.1255121-7-hch@lst.de>
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

Add a helper for the mempool_alloc slowpath to better separate it from the
fast path, and also use it to implement mempool_alloc_preallocated which
shares the same logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/mempool.c | 121 ++++++++++++++++++++++++---------------------------
 1 file changed, 57 insertions(+), 64 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index a0718a35c34f..c28087a3b8a9 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -380,6 +380,50 @@ int mempool_resize(mempool_t *pool, int new_min_nr)
 }
 EXPORT_SYMBOL(mempool_resize);
 
+static void *mempool_alloc_from_pool(struct mempool *pool, gfp_t gfp_mask)
+{
+	unsigned long flags;
+	void *element;
+
+	spin_lock_irqsave(&pool->lock, flags);
+	if (unlikely(!pool->curr_nr))
+		goto fail;
+	element = remove_element(pool);
+	spin_unlock_irqrestore(&pool->lock, flags);
+
+	/* Paired with rmb in mempool_free(), read comment there. */
+	smp_wmb();
+
+	/*
+	 * Update the allocation stack trace as this is more useful for
+	 * debugging.
+	 */
+	kmemleak_update_trace(element);
+	return element;
+
+fail:
+	if (gfp_mask & __GFP_DIRECT_RECLAIM) {
+		DEFINE_WAIT(wait);
+
+		prepare_to_wait(&pool->wait, &wait, TASK_UNINTERRUPTIBLE);
+		spin_unlock_irqrestore(&pool->lock, flags);
+
+		/*
+		 * Wait for someone else to return an element to @pool.
+		 *
+		 * FIXME: this should be io_schedule().  The timeout is there as
+		 * a workaround for some DM problems in 2.6.18.
+		 */
+		io_schedule_timeout(5 * HZ);
+		finish_wait(&pool->wait, &wait);
+	} else {
+		/* We must not sleep if __GFP_DIRECT_RECLAIM is not set. */
+		spin_unlock_irqrestore(&pool->lock, flags);
+	}
+
+	return NULL;
+}
+
 /*
  * Adjust the gfp flags for mempool allocations, as we never want to dip into
  * the global emergency reserves or retry in the page allocator.
@@ -413,8 +457,6 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
 {
 	gfp_t gfp_temp = mempool_adjust_gfp(&gfp_mask);
 	void *element;
-	unsigned long flags;
-	wait_queue_entry_t wait;
 
 	VM_WARN_ON_ONCE(gfp_mask & __GFP_ZERO);
 	might_alloc(gfp_mask);
@@ -428,53 +470,22 @@ void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
 		element = pool->alloc(gfp_temp, pool->pool_data);
 	}
 
-	if (likely(element))
-		return element;
-
-	spin_lock_irqsave(&pool->lock, flags);
-	if (likely(pool->curr_nr)) {
-		element = remove_element(pool);
-		spin_unlock_irqrestore(&pool->lock, flags);
-		/* paired with rmb in mempool_free(), read comment there */
-		smp_wmb();
+	if (unlikely(!element)) {
 		/*
-		 * Update the allocation stack trace as this is more useful
-		 * for debugging.
+		 * Try to allocate an element from the pool.
+		 *
+		 * The first pass won't have __GFP_DIRECT_RECLAIM and won't
+		 * sleep in mempool_alloc_from_pool.  Retry the allocation
+		 * with all flags set in that case.
 		 */
-		kmemleak_update_trace(element);
-		return element;
-	}
-
-	/*
-	 * We use gfp mask w/o direct reclaim or IO for the first round.  If
-	 * alloc failed with that and @pool was empty, retry immediately.
-	 */
-	if (gfp_temp != gfp_mask) {
-		spin_unlock_irqrestore(&pool->lock, flags);
-		gfp_temp = gfp_mask;
-		goto repeat_alloc;
-	}
-
-	/* We must not sleep if !__GFP_DIRECT_RECLAIM */
-	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
-		spin_unlock_irqrestore(&pool->lock, flags);
-		return NULL;
+		element = mempool_alloc_from_pool(pool, gfp_mask);
+		if (!element && gfp_temp != gfp_mask) {
+			gfp_temp = gfp_mask;
+			goto repeat_alloc;
+		}
 	}
 
-	/* Let's wait for someone else to return an element to @pool */
-	init_wait(&wait);
-	prepare_to_wait(&pool->wait, &wait, TASK_UNINTERRUPTIBLE);
-
-	spin_unlock_irqrestore(&pool->lock, flags);
-
-	/*
-	 * FIXME: this should be io_schedule().  The timeout is there as a
-	 * workaround for some DM problems in 2.6.18.
-	 */
-	io_schedule_timeout(5*HZ);
-
-	finish_wait(&pool->wait, &wait);
-	goto repeat_alloc;
+	return element;
 }
 EXPORT_SYMBOL(mempool_alloc_noprof);
 
@@ -492,25 +503,7 @@ EXPORT_SYMBOL(mempool_alloc_noprof);
  */
 void *mempool_alloc_preallocated(mempool_t *pool)
 {
-	void *element;
-	unsigned long flags;
-
-	spin_lock_irqsave(&pool->lock, flags);
-	if (likely(pool->curr_nr)) {
-		element = remove_element(pool);
-		spin_unlock_irqrestore(&pool->lock, flags);
-		/* paired with rmb in mempool_free(), read comment there */
-		smp_wmb();
-		/*
-		 * Update the allocation stack trace as this is more useful
-		 * for debugging.
-		 */
-		kmemleak_update_trace(element);
-		return element;
-	}
-	spin_unlock_irqrestore(&pool->lock, flags);
-
-	return NULL;
+	return mempool_alloc_from_pool(pool, GFP_NOWAIT);
 }
 EXPORT_SYMBOL(mempool_alloc_preallocated);
 
-- 
2.47.3


