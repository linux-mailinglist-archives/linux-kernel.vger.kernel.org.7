Return-Path: <linux-kernel+bounces-895544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4531C4E403
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 596074EB5E0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FAB24BBEE;
	Tue, 11 Nov 2025 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KuxyIom3"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4FD359717
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869216; cv=none; b=sTsBY5NB//G5iAID8udQ9fCUZE5FLITUkYMRYQHj/h/ar3L59xbBvXU53HC330jrG+iZBT5fQIorBrFFX+EXneDI/Ym0q+wJwwicySAELHCh8gXREquu8c4fy/uKv7hc5JMobKhRihtxosXX/ps+vGvjv01q+9bhm9LrQ4MUwLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869216; c=relaxed/simple;
	bh=f7wsiels18Wm3C5k95cfg0AUGf0Qfu32XIpaRLmbnFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hF+Z4LwCJ8S0sIb267+HDYQVeZICOgpL7ZdavLugQo0kyfW7408sgPtSw2CbDj03yFLV2hfCKKbPrvVWeO258pjECS/K8v+8BjDW5ioMxaodtdgjY57U/kvvirs06p1Ht4VXkKNSGGGHS2nNn3hVSrGXK4eY19OeEo49AYc3eXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KuxyIom3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=p0rppA8e5n/RynaKchtzsVu3tIhHELjvyJLmV+KshVg=; b=KuxyIom3OhkUkh8uhojFIQPDxc
	v6/q2qsd0sHd11Cv8fXN5fMYyEhX10yZCnhWkqyMYyKTTBNKf6Znm4w5VyhodZSrRV4qrILiRmWHK
	q6dWiCPNANJ2TrxUkow59fPvTOhEWtWpeMzn/GuSHKT9BaEDoSW4866PcakzOPqzCj7O/9j9hymdE
	MEj/tvntfvkG3mpIztuOBFEquHIvKBgaazkcGSB5u4AscamGWRkzaSh+zVFARw64obDLQLgHixMjp
	9zkLPqV2IoMxKgc0jhy3LQzEv4tLAuVPR4UiZHHkGG5SfSLBHTEgmcVKSsUoIRKqALLIrqI6s9Cz5
	5bvsaQYw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIooO-00000007Gcj-3dPE;
	Tue, 11 Nov 2025 13:53:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] mempool: factor out a mempool_alloc_from_pool helper
Date: Tue, 11 Nov 2025 14:52:33 +0100
Message-ID: <20251111135300.752962-6-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111135300.752962-1-hch@lst.de>
References: <20251111135300.752962-1-hch@lst.de>
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
index 912364e279e9..850362f4ca7a 100644
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


