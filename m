Return-Path: <linux-kernel+bounces-749166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D38BCB14ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB34F540EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32137286D7C;
	Tue, 29 Jul 2025 09:13:13 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD2A15533F;
	Tue, 29 Jul 2025 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780392; cv=none; b=M/crgi7YjGVHCgGEObjlCWToEgOd5ue9VoSGKdkMOAhKft4PoALg7+zSJJOmA9enoAeJwDLwiNZ0c7CUrHmx/mFlcv+2pUXB76zZftXLjzzkKj9rx0ex+UUOssHmMFRuBdmFP9+D7MPllMRfil5xFOeqEW76VOLSc7xyYPSwnx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780392; c=relaxed/simple;
	bh=Rf/pYiSeKZKQ3QMlt8j/sMOFrRSsMTVmCW5/Ld6KOl8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JDqQad7VeLXvMPJ+I6W7ubrv4VtdPa+621KUXmoAV2YbdtJ1HFBnSIZoKdRLS9A2fvEc1kTdFDZhYoLz7iynmwjegd3OIShQtyF0PdFiEkG/2jH/5KiHKaFBgNMDghNHawbjVKmmRmA08x/e2VcZ09w//4s5KIrIDx1uk1El5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4brqPv27QFzKHMyN;
	Tue, 29 Jul 2025 17:13:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2A2FD1A1188;
	Tue, 29 Jul 2025 17:13:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDnYhOekIhoPut4Bw--.64796S4;
	Tue, 29 Jul 2025 17:13:03 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: hch@lst.de,
	houtao1@huawei.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH v2] brd: use page reference to protect page lifetime
Date: Tue, 29 Jul 2025 17:06:16 +0800
Message-Id: <20250729090616.1008288-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnYhOekIhoPut4Bw--.64796S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZr43Zr18ur4UGF4Utr17Awb_yoWrCw4fpF
	WUtFyIy3y5Gr4akw17Xwn8ur15KryIgayfKa4fJw4Skr4fGr9Fya4Iy34Fqa15GrWkCrWD
	AFsxtF1UCrZYq3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

As discussed [1], hold rcu for copying data from/to page is too heavy.
it's better to protect page with rcu around for page lookup and then
grab a reference to prevent page to be freed by discard.

[1] https://lore.kernel.org/all/eb41cab3-5946-4fe3-a1be-843dd6fca159@kernel.dk/

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
Changes from v1:
 - refer to filemap_get_entry(), use xas_load + xas_reload to fix
 concurrent problems.

 drivers/block/brd.c | 73 ++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 0c2eabe14af3..b7a0448ca928 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -44,45 +44,72 @@ struct brd_device {
 };
 
 /*
- * Look up and return a brd's page for a given sector.
+ * Look up and return a brd's page with reference grabbed for a given sector.
  */
 static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 {
-	return xa_load(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT);
+	struct page *page;
+	XA_STATE(xas, &brd->brd_pages, sector >> PAGE_SECTORS_SHIFT);
+
+	rcu_read_lock();
+repeat:
+	xas_reset(&xas);
+	page = xas_load(&xas);
+	if (xas_retry(&xas, page))
+		goto repeat;
+
+	if (!page || xa_is_value(page)) {
+		page = NULL;
+		goto out;
+	}
+
+	if (!get_page_unless_zero(page))
+		goto repeat;
+
+	if (unlikely(page != xas_reload(&xas))) {
+		put_page(page);
+		goto repeat;
+	}
+out:
+	rcu_read_unlock();
+
+	return page;
 }
 
 /*
  * Insert a new page for a given sector, if one does not already exist.
+ * The returned page will grab reference.
  */
 static struct page *brd_insert_page(struct brd_device *brd, sector_t sector,
 		blk_opf_t opf)
-	__releases(rcu)
-	__acquires(rcu)
 {
 	gfp_t gfp = (opf & REQ_NOWAIT) ? GFP_NOWAIT : GFP_NOIO;
 	struct page *page, *ret;
 
-	rcu_read_unlock();
 	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
-	if (!page) {
-		rcu_read_lock();
+	if (!page)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	xa_lock(&brd->brd_pages);
 	ret = __xa_cmpxchg(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT, NULL,
 			page, gfp);
-	rcu_read_lock();
-	if (ret) {
+	if (!ret) {
+		brd->brd_nr_pages++;
+		get_page(page);
 		xa_unlock(&brd->brd_pages);
-		__free_page(page);
-		if (xa_is_err(ret))
-			return ERR_PTR(xa_err(ret));
+		return page;
+	}
+
+	if (!xa_is_err(ret)) {
+		get_page(ret);
+		xa_unlock(&brd->brd_pages);
+		put_page(page);
 		return ret;
 	}
-	brd->brd_nr_pages++;
+
 	xa_unlock(&brd->brd_pages);
-	return page;
+	put_page(page);
+	return ERR_PTR(xa_err(ret));
 }
 
 /*
@@ -95,7 +122,7 @@ static void brd_free_pages(struct brd_device *brd)
 	pgoff_t idx;
 
 	xa_for_each(&brd->brd_pages, idx, page) {
-		__free_page(page);
+		put_page(page);
 		cond_resched();
 	}
 
@@ -117,7 +144,6 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
 
 	bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
 
-	rcu_read_lock();
 	page = brd_lookup_page(brd, sector);
 	if (!page && op_is_write(opf)) {
 		page = brd_insert_page(brd, sector, opf);
@@ -135,13 +161,13 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
 			memset(kaddr, 0, bv.bv_len);
 	}
 	kunmap_local(kaddr);
-	rcu_read_unlock();
 
 	bio_advance_iter_single(bio, &bio->bi_iter, bv.bv_len);
+	if (page)
+		put_page(page);
 	return true;
 
 out_error:
-	rcu_read_unlock();
 	if (PTR_ERR(page) == -ENOMEM && (opf & REQ_NOWAIT))
 		bio_wouldblock_error(bio);
 	else
@@ -149,13 +175,6 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
 	return false;
 }
 
-static void brd_free_one_page(struct rcu_head *head)
-{
-	struct page *page = container_of(head, struct page, rcu_head);
-
-	__free_page(page);
-}
-
 static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
 {
 	sector_t aligned_sector = round_up(sector, PAGE_SECTORS);
@@ -170,7 +189,7 @@ static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
 	while (aligned_sector < aligned_end && aligned_sector < rd_size * 2) {
 		page = __xa_erase(&brd->brd_pages, aligned_sector >> PAGE_SECTORS_SHIFT);
 		if (page) {
-			call_rcu(&page->rcu_head, brd_free_one_page);
+			put_page(page);
 			brd->brd_nr_pages--;
 		}
 		aligned_sector += PAGE_SECTORS;
-- 
2.39.2


