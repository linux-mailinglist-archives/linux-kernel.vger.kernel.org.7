Return-Path: <linux-kernel+bounces-878217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D73C200B0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8FF4650B0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E923043C8;
	Thu, 30 Oct 2025 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="lbatI+8N"
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD5E2D0611
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827755; cv=pass; b=r+ExAyYbufokQaT8PoJ1ZHRYAGwgMZwZuVFJEYH4EbxbVYIb1Y09T/yqNxXDxfaTtzIE3nFu+Iaj9FSI2lOCHeXNYeL3TmC1Pcbn+diNB1ShXloaYxlUawCgAwcybDlivG0++twdHkdJk23fGilNLKlIPwA3VYLRtEr/RlhIOn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827755; c=relaxed/simple;
	bh=R/TbI84eFp9kXjDw88iosgHhX0aGRc0fsZmAH+tj+3k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9vuBAHNcAq5yiJm+eRoidnDQ4Cpy3LECKvawEIXgeDamNc5VQggPCVNzc1FN7obOP87IvB6fBZx1bboAKZ1CMluo1l8J0mTYwy3qp+8bPk9LdS5iGUs7wlQkHBcfixMWOTFMqurfkFasURY6OWirDwaFKIY80+w063cEvTSVew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=lbatI+8N; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1761827617; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jW2fwMCzE09dfCy78b4g11QE/M49jSAIXE+Y9Sff7O+1FrIrH8NVbainb1vE3/k4holpmeQvYzQREbmsHWAH2fHOsyqPDcIbYa6rNW0ttgnFrmNAYBCCYbBuKuHn2ie9OP4f//4BSxPx4wHFIWDVIWKHfsCRhAy9Xkt5HGAJ7eM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761827617; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=bL264gMYmKx98ivmk0jTfYv5p7G6wPZT+qugzMLjMzI=; 
	b=h+TE7ouf89pWxrWeDiEwoojWtc5WshKXB2X5lht74sFXzxc+0yYQyuhiRSNY9g8AGKmtFdTeobrzD5MYCU3RyV94GgJdA8g2A351C0rdsrpWBTdxF2aozJRDaaVI2p75ciYifStTl5WnBfbOzPBnzjpTDau/RmjA3fB63hlLfLc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761827617;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=bL264gMYmKx98ivmk0jTfYv5p7G6wPZT+qugzMLjMzI=;
	b=lbatI+8NOTCQd+b9qJcK7AzbijJiNb5/6tUejmud+25uJYqSfmSBGd7mhqW2Jk3v
	iL7RLZk5KZcgU6F8r3n/7QLVZPNiJ9BXe7P1fEHv6NGsDztNbma/wISi8Vp9Fwerzdp
	8aVQ8z1DI9In6pzXj8DoB024XBo4jySt/cpnh68Q=
Received: by mx.zohomail.com with SMTPS id 1761827614963359.7467821678007;
	Thu, 30 Oct 2025 05:33:34 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>
Subject: [PATCH 1/3] dm-pcache: allow built-in build and rename flush helper
Date: Thu, 30 Oct 2025 20:33:19 +0800
Message-ID: <20251030123323.967081-2-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030123323.967081-1-me@linux.beauty>
References: <20251030123323.967081-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

CONFIG_BCACHE is tristate, so dm-pcache can also be built-in.
Switch the Makefile to use obj-$(CONFIG_DM_PCACHE) so the target can be
linked into vmlinux instead of always being a loadable module.

Also rename cache_flush() to pcache_cache_flush() to avoid a global
symbol clash with sunrpc/cache.c's cache_flush().

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 drivers/md/dm-pcache/Makefile    | 2 +-
 drivers/md/dm-pcache/cache.c     | 2 +-
 drivers/md/dm-pcache/cache.h     | 2 +-
 drivers/md/dm-pcache/cache_req.c | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-pcache/Makefile b/drivers/md/dm-pcache/Makefile
index 86776e4acad24..cedfd38854f63 100644
--- a/drivers/md/dm-pcache/Makefile
+++ b/drivers/md/dm-pcache/Makefile
@@ -1,3 +1,3 @@
 dm-pcache-y := dm_pcache.o cache_dev.o segment.o backing_dev.o cache.o cache_gc.o cache_writeback.o cache_segment.o cache_key.o cache_req.o
 
-obj-m += dm-pcache.o
+obj-$(CONFIG_DM_PCACHE) += dm-pcache.o
diff --git a/drivers/md/dm-pcache/cache.c b/drivers/md/dm-pcache/cache.c
index d8e92367d9470..d516d49042272 100644
--- a/drivers/md/dm-pcache/cache.c
+++ b/drivers/md/dm-pcache/cache.c
@@ -411,7 +411,7 @@ void pcache_cache_stop(struct dm_pcache *pcache)
 {
 	struct pcache_cache *cache = &pcache->cache;
 
-	cache_flush(cache);
+	pcache_cache_flush(cache);
 
 	cancel_delayed_work_sync(&cache->gc_work);
 	flush_work(&cache->clean_work);
diff --git a/drivers/md/dm-pcache/cache.h b/drivers/md/dm-pcache/cache.h
index 1136d86958c8c..27613b56be54c 100644
--- a/drivers/md/dm-pcache/cache.h
+++ b/drivers/md/dm-pcache/cache.h
@@ -339,7 +339,7 @@ void cache_seg_put(struct pcache_cache_segment *cache_seg);
 void cache_seg_set_next_seg(struct pcache_cache_segment *cache_seg, u32 seg_id);
 
 /* cache request*/
-int cache_flush(struct pcache_cache *cache);
+int pcache_cache_flush(struct pcache_cache *cache);
 void miss_read_end_work_fn(struct work_struct *work);
 int pcache_cache_handle_req(struct pcache_cache *cache, struct pcache_request *pcache_req);
 
diff --git a/drivers/md/dm-pcache/cache_req.c b/drivers/md/dm-pcache/cache_req.c
index 27f94c1fa968c..7854a30e07b7f 100644
--- a/drivers/md/dm-pcache/cache_req.c
+++ b/drivers/md/dm-pcache/cache_req.c
@@ -790,7 +790,7 @@ static int cache_write(struct pcache_cache *cache, struct pcache_request *pcache
 }
 
 /**
- * cache_flush - Flush all ksets to persist any pending cache data
+ * pcache_cache_flush - Flush all ksets to persist any pending cache data
  * @cache: Pointer to the cache structure
  *
  * This function iterates through all ksets associated with the provided `cache`
@@ -802,7 +802,7 @@ static int cache_write(struct pcache_cache *cache, struct pcache_request *pcache
  * the respective error code, preventing the flush operation from proceeding to
  * subsequent ksets.
  */
-int cache_flush(struct pcache_cache *cache)
+int pcache_cache_flush(struct pcache_cache *cache)
 {
 	struct pcache_cache_kset *kset;
 	int ret;
@@ -827,7 +827,7 @@ int pcache_cache_handle_req(struct pcache_cache *cache, struct pcache_request *p
 	struct bio *bio = pcache_req->bio;
 
 	if (unlikely(bio->bi_opf & REQ_PREFLUSH))
-		return cache_flush(cache);
+		return pcache_cache_flush(cache);
 
 	if (bio_data_dir(bio) == READ)
 		return cache_read(cache, pcache_req);
-- 
2.51.0


