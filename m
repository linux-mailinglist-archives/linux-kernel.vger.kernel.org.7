Return-Path: <linux-kernel+bounces-898938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3B2C565AB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DF6D3572E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4CC334394;
	Thu, 13 Nov 2025 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SId8SQyq"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB3033122B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023296; cv=none; b=lmfVvOTZVP2Dc90bBdUa7JafxstH09bg9GzX/++GEr+YBoo5OauEjyDo1222mIawjxX17i06VX5g2CL3lV97bM0kjR8ZFq3T7B3UjovrYy5VSIJZJEw5A2QiPv8opw+cQM7hvp6GK1wXf+fGMWlJ0FhTtIfE1KxrcBByZcJYPZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023296; c=relaxed/simple;
	bh=GznCIwKjMf2j4/lAu5fvaqPgMOm/xugE0YBpF+Fiirs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVqTgyewYaYUL+niyjqGesOSWaLOPqdSXw7bXXheT6Tp5oSn9u/xpCT73urcb+UlTjt8mOiF1E+Gc79PorJzzPtjWpRNSQL5ZWKkpqfDx7NUQP5eC7pGyQrxAAxKGtmOv6jXkj9woAK7mMgjbu9WzUnBy8BUdNozHPL+wM3EZB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SId8SQyq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9F5bDBG8GDPp+kf7AD7KCVOQnYGwaf8pnBFM8bXFoD0=; b=SId8SQyqkI6btSG1h/pGLfZpTm
	aht/Jr/q0ErAlO+P1ntGFZLZ1Jee5WOS8mzWUKjmMXtqx0PhGwGwV71l1o1lzOChagTV0YD0m9wV0
	wnnqKiksskWnT/hwmRDbxwNy+ODGMoIG3IamINoBcD7EvqCETxXX9m57dCdM2PhdkDlLlODSyqEgN
	Ggq+h8wKJPU9bDEcWTh5lS8S0D8EzduSi3ZAb8aFCcXdW9DzwMCrxC0F/1ga35Ijd6nhrRHkTp+8r
	rwZdKSuEh/k9qx2eeIr5EdWODSYsylK93w1pV7dRugfdZk+r8mgKH67UaIboLgHpOg6RYUBD1D8hm
	XZkkPt/A==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJStX-0000000A7Ub-2ZTs;
	Thu, 13 Nov 2025 08:41:32 +0000
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
Subject: [PATCH 09/11] mempool: remove mempool_{init,create}_kvmalloc_pool
Date: Thu, 13 Nov 2025 09:39:50 +0100
Message-ID: <20251113084022.1255121-10-hch@lst.de>
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

This was added for bcachefs and is unused now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mempool.h | 13 -------------
 mm/mempool.c            | 13 -------------
 2 files changed, 26 deletions(-)

diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index e914fec0e119..d9332485e8ca 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -103,19 +103,6 @@ void mempool_kfree(void *element, void *pool_data);
 	mempool_create((_min_nr), mempool_kmalloc, mempool_kfree,	\
 		       (void *)(unsigned long)(_size))
 
-void *mempool_kvmalloc(gfp_t gfp_mask, void *pool_data);
-void mempool_kvfree(void *element, void *pool_data);
-
-static inline int mempool_init_kvmalloc_pool(mempool_t *pool, int min_nr, size_t size)
-{
-	return mempool_init(pool, min_nr, mempool_kvmalloc, mempool_kvfree, (void *) size);
-}
-
-static inline mempool_t *mempool_create_kvmalloc_pool(int min_nr, size_t size)
-{
-	return mempool_create(min_nr, mempool_kvmalloc, mempool_kvfree, (void *) size);
-}
-
 /*
  * A mempool_alloc_t and mempool_free_t for a simple page allocator that
  * allocates pages of the order specified by pool_data
diff --git a/mm/mempool.c b/mm/mempool.c
index ea2f4f9bcfa1..72c788888ed7 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -724,19 +724,6 @@ void mempool_kfree(void *element, void *pool_data)
 }
 EXPORT_SYMBOL(mempool_kfree);
 
-void *mempool_kvmalloc(gfp_t gfp_mask, void *pool_data)
-{
-	size_t size = (size_t)pool_data;
-	return kvmalloc(size, gfp_mask);
-}
-EXPORT_SYMBOL(mempool_kvmalloc);
-
-void mempool_kvfree(void *element, void *pool_data)
-{
-	kvfree(element);
-}
-EXPORT_SYMBOL(mempool_kvfree);
-
 /*
  * A simple mempool-backed page allocator that allocates pages
  * of the order specified by pool_data.
-- 
2.47.3


