Return-Path: <linux-kernel+bounces-898934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6EFC5659C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F33624E79F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57EF33123E;
	Thu, 13 Nov 2025 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PPGw9FDM"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89F332F74B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023268; cv=none; b=oBwl8sN4N5t2gruHmdvghsTd024mj4Vc+aXM9riciAceVlcQ+IDQxh7oSAfJAbfHQakdxqCuljKxI2gdwo4xrAW38fE7wb8y4J8h1aY5V4/pAgLtPrNF6ICFgqd7VBrIkUllu+4V+k8OReLcmw1C7i24PjycJmADPcY7rOOEDe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023268; c=relaxed/simple;
	bh=wbnSfifTTr+KlNdbADNWCuAJSxJvOgHlhLJJuY337YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHwBRdesiXkpi/emukbky/+nP0nT3Yc9l5om0w7QXk2ms8KBrfUvSCyMBYJWtoLOnw+QaIvqQJBFoO+haz+lNb9P+NlBD6HNmU6XcX/HON8G0GJtZ51zleSefvwkdHUTRqO6msfajKJASI5xCSfqn2hiXB+5UuJQ+1dR3B8PpNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PPGw9FDM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SLSX4DOJ24jpmL8C+rE9YIq14cjiu43POZtmTFc1PVY=; b=PPGw9FDMf0vYmOdiobYSpS9GCq
	wR9JkNMm5buGTM52RbeybuVyEp00+w6XATsRCb/CEfI+/JLyTYpI/CjPBzn/IMZ1cObYFJK1HXXT5
	HpKcJiejW80K2epHLAr8R+ewdvRabW6TFtyJ2EAfJVqNCHcmpoKxiEO+UbqtrDNH+m314PnIP8g9d
	hQ2gTaBpe/Vx0tc6w9vouxD7qnzpN0PvVVd55fVZQ4PUA3+4LDMn1PPoCStT+mCgUQn+ASSMh8aqC
	ds9UDfYEvQjDcZmn88bFkQtlHg0hk7Jty8tNlwG/joWTiXTxX7zYEnAJJHAJFqoAl+RxqkSkZqU4b
	fI0s49Cg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJSt5-0000000A7Re-1Smj;
	Thu, 13 Nov 2025 08:41:03 +0000
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
Subject: [PATCH 05/11] mempool: factor out a mempool_adjust_gfp helper
Date: Thu, 13 Nov 2025 09:39:46 +0100
Message-ID: <20251113084022.1255121-6-hch@lst.de>
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

Add a helper to better isolate and document the gfp flags adjustments.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/mempool.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 5cf59779cc3d..a0718a35c34f 100644
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
 		pr_info("forcing mempool usage for %pS\n",
-- 
2.47.3


