Return-Path: <linux-kernel+bounces-898932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 951DFC5651E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA593B5E89
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05A7331A57;
	Thu, 13 Nov 2025 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PBTHbG3m"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E332232F74B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023254; cv=none; b=BzasPaVyEZrd6olfmnE2Ji95vgM84Bgm8yJifMygaiwwI9qlRtps5ip7pRjo3j1JOdi3VUgKHZuhPSGI2HYFuXLmcMYsdmjkzAPCbxZ0B9oe9jqcpfi/4zF9XFjFHhjwrv/cjBniFXDUw/3vDPqDMKugkCRah5sNb2W3TEdzFXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023254; c=relaxed/simple;
	bh=64K+eNfb+pxvbzHTL7yO4Jm6nd4pQMRg8fwdoUcxgKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8lPfkylRL5tRgXGIX/FDOJDfp1xuOv9zmAPcT0YrCiB7YD+lMAr29osnizo05Hg0EaX7JGtHBS2H+ETdPGJW3a5DxrNYWn3DZCc0tnUdHZe0uiFvKD2cOdBKmTLUJURKjXpSmGzeUpgwIfP+unCEPMy/z5NAkgF+VdcPWN7QRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PBTHbG3m; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FRYgSq03HmqIdEUfSgNjXfP2N3YHwggqOiGsRy6ACtg=; b=PBTHbG3meCCUSPmQINxHAQ0VGY
	mzDlPoTYSNlFVwjcqevg+zlRIQq5YJpesza6VXUZow+sGbjG2/BwzU32T++ll7jSmJkTxz2lEiItZ
	sp5lr6DRzyC6B1e/E9hsQ/glB+P3kRH2nW2fBRO9yU96PBZ5u6HySiem/7Brwhy0qS8mjviVmYEcy
	ZmwGuLcDLY0pIlMW7ai83eDI/zFrr22gnZJIpN5RXubaLytZykGsSOL8J65f6Kl6jo3lh5Fb8ZtX/
	HSfNEWLXbzbUMuZpjx9xw4TQ6C7ZSEINGcK5T/f5qsM4gkpsO6t8k4FzJAaMTy3qfYwv4JYFMafkM
	yx12OyPg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJSsq-0000000A7PK-0UDb;
	Thu, 13 Nov 2025 08:40:48 +0000
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
Subject: [PATCH 03/11] mempool: improve kerneldoc comments
Date: Thu, 13 Nov 2025 09:39:44 +0100
Message-ID: <20251113084022.1255121-4-hch@lst.de>
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

Use proper formatting, use full sentences and reduce some verbosity in
function parameter descriptions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/mempool.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 1c38e873e546..1f4701713203 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -372,18 +372,20 @@ int mempool_resize(mempool_t *pool, int new_min_nr)
 EXPORT_SYMBOL(mempool_resize);
 
 /**
- * mempool_alloc - allocate an element from a specific memory pool
- * @pool:      pointer to the memory pool which was allocated via
- *             mempool_create().
- * @gfp_mask:  the usual allocation bitmask.
+ * mempool_alloc - allocate an element from a memory pool
+ * @pool:	pointer to the memory pool
+ * @gfp_mask:	GFP_* flags.  %__GFP_ZERO is not supported.
  *
- * this function only sleeps if the alloc_fn() function sleeps or
- * returns NULL. Note that due to preallocation, this function
- * *never* fails when called from process contexts. (it might
- * fail if called from an IRQ context.)
- * Note: using __GFP_ZERO is not supported.
+ * Allocate an element from @pool.  This is done by first calling into the
+ * alloc_fn supplied at pool initialization time, and dipping into the reserved
+ * pool when alloc_fn fails to allocate an element.
  *
- * Return: pointer to the allocated element or %NULL on error.
+ * This function only sleeps if the alloc_fn callback sleeps, or when waiting
+ * for elements to become available in the pool.
+ *
+ * Return: pointer to the allocated element or %NULL when failing to allocate
+ * an element.  Allocation failure can only happen when @gfp_mask does not
+ * include %__GFP_DIRECT_RECLAIM.
  */
 void *mempool_alloc_noprof(mempool_t *pool, gfp_t gfp_mask)
 {
@@ -456,11 +458,10 @@ EXPORT_SYMBOL(mempool_alloc_noprof);
 
 /**
  * mempool_alloc_preallocated - allocate an element from preallocated elements
- *                              belonging to a specific memory pool
- * @pool:      pointer to the memory pool which was allocated via
- *             mempool_create().
+ *                              belonging to a memory pool
+ * @pool:	pointer to the memory pool
  *
- * This function is similar to mempool_alloc, but it only attempts allocating
+ * This function is similar to mempool_alloc(), but it only attempts allocating
  * an element from the preallocated elements. It does not sleep and immediately
  * returns if no preallocated elements are available.
  *
@@ -492,12 +493,14 @@ void *mempool_alloc_preallocated(mempool_t *pool)
 EXPORT_SYMBOL(mempool_alloc_preallocated);
 
 /**
- * mempool_free - return an element to the pool.
- * @element:   pool element pointer.
- * @pool:      pointer to the memory pool which was allocated via
- *             mempool_create().
+ * mempool_free - return an element to a mempool
+ * @element:	pointer to element
+ * @pool:	pointer to the memory pool
+ *
+ * Returns @element to @pool if it needs replenishing, else frees it using
+ * the free_fn callback in @pool.
  *
- * this function only sleeps if the free_fn() function sleeps.
+ * This function only sleeps if the free_fn callback sleeps.
  */
 void mempool_free(void *element, mempool_t *pool)
 {
-- 
2.47.3


