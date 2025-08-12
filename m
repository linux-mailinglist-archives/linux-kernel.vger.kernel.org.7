Return-Path: <linux-kernel+bounces-764307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C628CB22158
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A061AA2D30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122F62E92DC;
	Tue, 12 Aug 2025 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ioBOVq4e"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D862E718B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987474; cv=none; b=Is1rB79uX13xx18/pNIuQGTMEEYopEow9ZS2HITo7R70Ty6VtbPTbtHu1Qd7jD6wtsihGT3lcpvt0JKvY/t7reELEBki0hpv8A9T8y+oRYCzMqpCio9/2zuog3NQAZIDIHI9eHvORT62e1mttQIoMJPtNXvTup66qtTVkKma0CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987474; c=relaxed/simple;
	bh=uRjNPKU+0QV+8oFpo6bxyvPUoWxPu/W+zkbOi5U2CTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tAWUm/bfJL4qwQ4xx/ZqPCVABy07QheL9S/aPyZ4+p66COVSMy+CD4a0O5SeZ1SKBOKS0bW7OlLEDOmx9WnHQ9CXJOktCv6zp/c3pTS0xVPlmzuj62x5lAA78dTKlqVakfZvmuq3YT0loRaucXtGhc5oNLp3gjTfT2SFVjUycT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ioBOVq4e; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=s7uIM6IQ2GnRJMINnamZt+nOZI6yL1Vh1Qs9yCS83nE=; b=ioBOVq4en/GVng08rmZuW1h3lg
	RZxJG/RDqoA9T+fOm+5PJFmOO/RE8IswpvBt5dYYYxAPc3KWWl6EKPI1KFaq8VZgObrSTPDMlhkGt
	6vHxsGr3k6vUZTlfaX35ZuTL00P522XjVVZJA3+MwqD+ilxtspWlCSRXD08SL7/CnmdEBREGRMa4h
	/F9blN+B0Pvac8vqzlJ+LRHGfpX0j4BDY9mqnBEqu9lWPL/gtFpPkyNHhF9vRBXGg0PoOxvyKkd4M
	jc+K241ZeUHYf70IaSEojbBCeKsZOeH+bJjKAWt/hLFDl9Uz73/wPgeAD2tuXCjKgi5ZCnMxzse9c
	2FM0bPew==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulkPU-0000000AFKh-1tta;
	Tue, 12 Aug 2025 08:31:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: vbabka@suse.cz,
	akpm@linux-foundation.org
Cc: cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	harry.yoo@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mempool: rename struct mempool_s to struct mempool
Date: Tue, 12 Aug 2025 10:30:08 +0200
Message-ID: <20250812083105.371295-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Drop the pointless _s prefix and align to the usual struct naming to
prepare for actually using the struct instead of the typedef so that
random headers don't need to include mempool.h for just having a
pointer to the mempool.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h  | 2 +-
 include/linux/mempool.h | 2 +-
 include/linux/netfs.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 95886b404b16..c3f3ec5bb864 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -199,7 +199,7 @@ struct gendisk {
 	unsigned int		zone_wplugs_hash_bits;
 	atomic_t		nr_zone_wplugs;
 	spinlock_t		zone_wplugs_lock;
-	struct mempool_s	*zone_wplugs_pool;
+	struct mempool		*zone_wplugs_pool;
 	struct hlist_head	*zone_wplugs_hash;
 	struct workqueue_struct *zone_wplugs_wq;
 #endif /* CONFIG_BLK_DEV_ZONED */
diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index 7b151441341b..34941a4b9026 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -15,7 +15,7 @@ struct kmem_cache;
 typedef void * (mempool_alloc_t)(gfp_t gfp_mask, void *pool_data);
 typedef void (mempool_free_t)(void *element, void *pool_data);
 
-typedef struct mempool_s {
+typedef struct mempool {
 	spinlock_t lock;
 	int min_nr;		/* nr of elements at *elements */
 	int curr_nr;		/* Current nr of elements at *elements */
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 185bd8196503..270ed0822efa 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -21,7 +21,7 @@
 #include <linux/rolling_buffer.h>
 
 enum netfs_sreq_ref_trace;
-typedef struct mempool_s mempool_t;
+typedef struct mempool mempool_t;
 struct folio_queue;
 
 /**
-- 
2.47.2


