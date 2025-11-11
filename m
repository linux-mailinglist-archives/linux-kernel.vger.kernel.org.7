Return-Path: <linux-kernel+bounces-895543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40793C4E400
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 807C44EA0FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DDD35970B;
	Tue, 11 Nov 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hcCD81pg"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E077231A81A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869210; cv=none; b=hF6cV+KbxVSbFwQ6a6MFtLYPUyx2lK+PpVK1055/k6TALKmzA1GVbraJBoFnSOVPpKejeeea3AZfGo9wWxU1QblLwl0ydXPl3b4mXjOaDvGZeZtZp7+WIiOs3xAXIbvuUl7YV+qg4g304C5i56KE3mV31QBiE+QHZ0/zzrCxukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869210; c=relaxed/simple;
	bh=9Nh438Z2KtChnfK+YQxbeMJiSB+LjbCYmx5PHUzFlCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYIduabY8MnKgUMohK+vV6whYVxbJRBQHxnukqahrGzzn+21sT3gdnqN+QMJtPeoRWIUxJh7yhSu4ymaXzpyoW9lsI128mYylurB2vG0uH+pqM/Vucxkvn9yJ9SYmayvAa9kXI5jnhRlMwd0ZWkBnU+D3v+IMxEFTrfx+YvlmXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hcCD81pg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OirQmgBsq9ZqcHQPfOm2bMkDUM1Tvp25rNeIxjb7fQI=; b=hcCD81pgtTW5SnfqMWQpI1ODvA
	wsPYKYS/5ih1YHfo+JQkkIryCABj8vH4cyOFrYqbRrg6k2zaeeADIebmygrUx8P9ZakmAECs03zmr
	Xod+fl/8T6O54USDCJSBYDvh/pEZQhVXSk0bZGDmVxSs6eQrWg1LvTKH6DeZOHVEa7Ye/W3qxRupG
	2cabM8mYUF/T54p/EXcT0/0Ydad9VtuD/YTmcuotvalRy5qPT6HMn3DB26iRiDdAoCivoiwRvO1VB
	jEZHlGl02Ah7BdbRrP1EMNjD0mcfR+p5mvev5H+6lBbLQ7gVAcQyc6GdV25DIX21x3+MjIYnxdHM7
	one97HtQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIooI-00000007GbY-1Ojh;
	Tue, 11 Nov 2025 13:53:26 +0000
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
Subject: [PATCH 4/7] mempool: factor out a mempool_adjust_gfp helper
Date: Tue, 11 Nov 2025 14:52:32 +0100
Message-ID: <20251111135300.752962-5-hch@lst.de>
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

Add a helper to better isolate and document the gfp flags adjustments.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/mempool.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 76ba4d5e656f..912364e279e9 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -380,6 +380,19 @@ int mempool_resize(mempool_t *pool, int new_min_nr)
 }
 EXPORT_SYMBOL(mempool_resize);
 
+/*
+ * Adjust the gfp flags for mempool allocations, as we never want to dip into
+ * the global emergency reserves or retry in the page allocator.
+ *
+ * The first pass also doesn't want to go reclaim, but the next passes do, so
+ * return a separate subset for that first iteration.
+ */
+static inline gfp_t mempool_adjust_gfp(gfp_t *gfp_mask)
+{
+	*gfp_mask |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
+	return *gfp_mask & ~(__GFP_DIRECT_RECLAIM | __GFP_IO);
+}
+
 /**
  * mempool_alloc - allocate an element from a memory pool
  * @pool:	pointer to the memory pool
@@ -398,20 +411,14 @@ EXPORT_SYMBOL(mempool_resize);
  */
 void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
 {
+	gfp_t gfp_temp = mempool_adjust_gfp(&gfp_mask);
 	void *element;
 	unsigned long flags;
 	wait_queue_entry_t wait;
-	gfp_t gfp_temp;
 
 	VM_WARN_ON_ONCE(gfp_mask & __GFP_ZERO);
 	might_alloc(gfp_mask);
 
-	gfp_mask |= __GFP_NOMEMALLOC;	/* don't allocate emergency reserves */
-	gfp_mask |= __GFP_NORETRY;	/* don't loop in __alloc_pages */
-	gfp_mask |= __GFP_NOWARN;	/* failures are OK */
-
-	gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO);
-
 repeat_alloc:
 	if (should_fail_ex(&fail_mempool_alloc, 1, FAULT_NOWARN)) {
 		pr_info("forcing mempool usage for pool %pS\n",
-- 
2.47.3


