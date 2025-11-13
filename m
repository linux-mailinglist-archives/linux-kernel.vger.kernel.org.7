Return-Path: <linux-kernel+bounces-898728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B08CC55DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 820FC4E34ED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F02930BB81;
	Thu, 13 Nov 2025 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NdPRaHju"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143152FF655
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763013617; cv=none; b=Bke++cBv52usxMX+9zS2b77ePaqPpAg7bj2TIC5n26BxLVUTppQJnSlBrxIP9FVLqrDU83Gzo7qgi4znENp8W0Lcy/uwCPvMngj4DR6xTp8J7yt6vv6UR83qOuPee93TnvPP/MESymT/4IvC62zdN+WuiEydCK7fG63m8ogoVPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763013617; c=relaxed/simple;
	bh=b7ZBbsmeQdCPNE6fAwdfiKOVRicRJSQ8AuYPSFdLT84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GlsDkQjVzpO9ueuQ0H2/i2+AcKzf+HYwSGTecyb9ToJpa9mfeiVRwzNDE2XvVc7kZTgtkcqdVtol3/USO6shRxYq4itVz7t7P2jXWW0sWd7PK54ZoSHOTo/D/+N5Qu4oE3gY26kXIRNcR0M4bvd/glstDU/21xh0gOkgLyum1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NdPRaHju; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-298144fb9bcso4333175ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763013614; x=1763618414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gf9JnjFax2bSnrfFfDZ9xY36eEdwvySsRzLc9kWlr7Y=;
        b=NdPRaHjuAlaXapYwvVSfiNFezpygo1xpr+cYxfXK19NrB4sBcR021BYuKXh2uuFdYx
         NA1Ieu3ipO3XUAATcPibgTMSfyTGFESb5idxWlr5v1a6V89JySereeVBzXKACuuIIozu
         d9mL7PzDXh4H9g5Y4VdUmWVMqCMdEU2Y2wqYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763013614; x=1763618414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gf9JnjFax2bSnrfFfDZ9xY36eEdwvySsRzLc9kWlr7Y=;
        b=kpSEucz6xew8uP8hvWMj03xjuvFLhhs9J+ZlMOf9kf2PswDYSsnIJesNTi6GIlU81O
         306p3djYnsdFW6lZ4FhdhBKmXT1jaCorkC0QGtLpB++qw34+bku8DHOwOO+IPc3yHDVn
         RF9AKEjTBYed7ATzBjSUDGp6GBI0kB2YawKTafmQG6JSiFKx1F/nByw54MSfrc0dCPYc
         VzshHuMYv5e1gJYNi1mBhyUgPIMSyKIo3fVv/rwUO+/ydeDai2usei+FcDCxnXsKNWp6
         ai7Ipn5dl86aD9EGokv/wrSmU8+dcb+DH2ryxOmMpthtovaak8V8dQCUNr1njr71tnTZ
         0ZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP+ftEHfrcg6SlWzwdc1+8EE6sFDO7r/TPfB03nyZHfDMaVFg8d4P0BDl4IHh7Qde6APm+ayQOIL8IxKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVW3Ipz3+jQgrLlqSktxRnXANIWpShYO2fiGspjOF2x9snCUKq
	bZN6TR42aoAvFIoyfy34O4DfnbuOC/f7J7BZKmM5j6AOWGLlnJKQAMiJV/pIQ/1lbw==
X-Gm-Gg: ASbGncvjc6xQEUdMRfSqVKparcm5LGIexjMhtfcy1fTIfL2P6vKnrigaRnYekE9LIlC
	RsYKgQ0ZyI9L/HuDdyWX7QAm5w4oxQFM5YSOE3HD1bHSTVFQc0lt1Vm7MaquRuTvdcqme8QTdOX
	GsFO0D4CJa7KaE4dbYkHIsIrMKYVcvu7umAMlBP2lRDitEoGxexyl2htfJiyuIfeV1Ox7XtRFg0
	Iue1+onioGkcQ5PngVdbQliXyPAuQ4BDmu7PB/f/rJcIrsOC5SB4Dno6+O02y68v3n35Xj582eq
	RHiRWhP3iKb6sjDWRbrGqOLujGkpITvCVf5nFOgnByAWJPV6Fqf/UorZL00ZuYtllRat0SCWYxv
	SLsvC8rbkZEX+RdDXGCduBCXKk3AcXR1vZvokOy0NELy2Avta4uDiqBi/uw1dP4UKK1w0ItocnJ
	tH7QvC1O9P0gnuaH+yMU3Z+smWSA73vuV7ZxS7Vw==
X-Google-Smtp-Source: AGHT+IHp9IXN06D8mebQBN6tkE/wcqbW6lp5Ww+zQ+/vmvl8yV7qM7Tl6bPvXkuBPsDwKSfwvVl0LA==
X-Received: by 2002:a17:903:94e:b0:297:dfae:1524 with SMTP id d9443c01a7336-2984ed45b64mr81617845ad.16.1763013614136;
        Wed, 12 Nov 2025 22:00:14 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2376f6sm11463145ad.21.2025.11.12.22.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:00:13 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>
Cc: Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 1/2] zram: introduce bio batching support for faster writeback
Date: Thu, 13 Nov 2025 14:59:38 +0900
Message-ID: <45b418277c6ae613783b9ecc714c96313ceb841d.1763013260.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuwen Chen <ywen.chen@foxmail.com>

Currently, zram writeback supports only a single bio writeback
operation, waiting for bio completion before post-processing
next pp-slot.  This works, in general, but has certain throughput
limitations.  Implement batched (multiple) bio writeback support
to take advantage of parallel requests processing and better
requests scheduling.

For the time being the writeback batch size (maximum number of
in-flight bio requests) is set to 1, so the behaviors is the
same as the previous single-bio writeback.  This is addressed
in a follow up patch, which adds a writeback_batch_size device
attribute.

Please refer to [1] and [2] for benchmarks.

[1] https://lore.kernel.org/linux-block/tencent_B2DC37E3A2AED0E7F179365FCB5D82455B08@qq.com
[2] https://lore.kernel.org/linux-block/tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com

[senozhatsky: significantly reworked the initial patch so that the
approach and implementation resemble current zram post-processing
code]

Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
Co-developed-by: Richard Chang <richardycc@google.com>
Co-developed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 323 +++++++++++++++++++++++++++-------
 1 file changed, 255 insertions(+), 68 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a43074657531..92af848d81f5 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -734,20 +734,206 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 	submit_bio(bio);
 }
 
-static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
-{
-	unsigned long blk_idx = 0;
-	struct page *page = NULL;
+struct zram_wb_ctl {
+	struct list_head idle_reqs;
+	struct list_head inflight_reqs;
+
+	atomic_t num_inflight;
+	struct completion done;
+	struct blk_plug plug;
+};
+
+struct zram_wb_req {
+	unsigned long blk_idx;
+	struct page *page;
 	struct zram_pp_slot *pps;
 	struct bio_vec bio_vec;
 	struct bio bio;
-	int ret = 0, err;
+
+	struct list_head entry;
+};
+
+static void release_wb_req(struct zram_wb_req *req)
+{
+	__free_page(req->page);
+	kfree(req);
+}
+
+static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
+{
+	/* We should never have inflight requests at this point */
+	WARN_ON(!list_empty(&wb_ctl->inflight_reqs));
+
+	while (!list_empty(&wb_ctl->idle_reqs)) {
+		struct zram_wb_req *req;
+
+		req = list_first_entry(&wb_ctl->idle_reqs,
+				       struct zram_wb_req, entry);
+		list_del(&req->entry);
+		release_wb_req(req);
+	}
+
+	kfree(wb_ctl);
+}
+
+/* XXX: should be a per-device sysfs attr */
+#define ZRAM_WB_REQ_CNT 1
+
+static struct zram_wb_ctl *init_wb_ctl(void)
+{
+	struct zram_wb_ctl *wb_ctl;
+	int i;
+
+	wb_ctl = kmalloc(sizeof(*wb_ctl), GFP_KERNEL);
+	if (!wb_ctl)
+		return NULL;
+
+	INIT_LIST_HEAD(&wb_ctl->idle_reqs);
+	INIT_LIST_HEAD(&wb_ctl->inflight_reqs);
+	atomic_set(&wb_ctl->num_inflight, 0);
+	init_completion(&wb_ctl->done);
+
+	for (i = 0; i < ZRAM_WB_REQ_CNT; i++) {
+		struct zram_wb_req *req;
+
+		/*
+		 * This is fatal condition only if we couldn't allocate
+		 * any requests at all.  Otherwise we just work with the
+		 * requests that we have successfully allocated, so that
+		 * writeback can still proceed, even if there is only one
+		 * request on the idle list.
+		 */
+		req = kzalloc(sizeof(*req), GFP_NOIO | __GFP_NOWARN);
+		if (!req)
+			break;
+
+		req->page = alloc_page(GFP_NOIO | __GFP_NOWARN);
+		if (!req->page) {
+			kfree(req);
+			break;
+		}
+
+		INIT_LIST_HEAD(&req->entry);
+		list_add(&req->entry, &wb_ctl->idle_reqs);
+	}
+
+	/* We couldn't allocate any requests, so writeabck is not possible */
+	if (list_empty(&wb_ctl->idle_reqs))
+		goto release_wb_ctl;
+
+	return wb_ctl;
+
+release_wb_ctl:
+	release_wb_ctl(wb_ctl);
+	return NULL;
+}
+
+static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
+{
 	u32 index;
+	int err;
 
-	page = alloc_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
+	index = req->pps->index;
+	release_pp_slot(zram, req->pps);
+	req->pps = NULL;
+
+	err = blk_status_to_errno(req->bio.bi_status);
+	if (err)
+		return err;
+
+	atomic64_inc(&zram->stats.bd_writes);
+	zram_slot_lock(zram, index);
+	/*
+	 * We release slot lock during writeback so slot can change under us:
+	 * slot_free() or slot_free() and zram_write_page(). In both cases
+	 * slot loses ZRAM_PP_SLOT flag. No concurrent post-processing can
+	 * set ZRAM_PP_SLOT on such slots until current post-processing
+	 * finishes.
+	 */
+	if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
+		goto out;
+
+	zram_free_page(zram, index);
+	zram_set_flag(zram, index, ZRAM_WB);
+	zram_set_handle(zram, index, req->blk_idx);
+	atomic64_inc(&zram->stats.pages_stored);
+	spin_lock(&zram->wb_limit_lock);
+	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
+		zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
+	spin_unlock(&zram->wb_limit_lock);
+
+out:
+	zram_slot_unlock(zram, index);
+	return 0;
+}
+
+static void zram_writeback_endio(struct bio *bio)
+{
+	struct zram_wb_ctl *wb_ctl = bio->bi_private;
+
+	if (atomic_dec_return(&wb_ctl->num_inflight) == 0)
+		complete(&wb_ctl->done);
+}
+
+static void zram_submit_wb_request(struct zram_wb_ctl *wb_ctl,
+				   struct zram_wb_req *req)
+{
+	atomic_inc(&wb_ctl->num_inflight);
+	list_add_tail(&req->entry, &wb_ctl->inflight_reqs);
+	submit_bio(&req->bio);
+}
+
+static struct zram_wb_req *select_idle_req(struct zram_wb_ctl *wb_ctl)
+{
+	struct zram_wb_req *req = NULL;
+
+	if (!list_empty(&wb_ctl->idle_reqs)) {
+		req = list_first_entry(&wb_ctl->idle_reqs,
+				       struct zram_wb_req, entry);
+		list_del(&req->entry);
+	}
+
+	return req;
+}
+
+static int zram_wb_wait_for_completion(struct zram *zram,
+				       struct zram_wb_ctl *wb_ctl)
+{
+	int ret = 0;
+
+	if (atomic_read(&wb_ctl->num_inflight) == 0)
+		return 0;
+
+	wait_for_completion_io(&wb_ctl->done);
+	reinit_completion(&wb_ctl->done);
+
+	while (!list_empty(&wb_ctl->inflight_reqs)) {
+		struct zram_wb_req *req;
+		int err;
+
+		req = list_first_entry(&wb_ctl->inflight_reqs,
+				       struct zram_wb_req, entry);
+		list_move(&req->entry, &wb_ctl->idle_reqs);
+
+		err = zram_writeback_complete(zram, req);
+		if (err)
+			ret = err;
+	}
+
+	return ret;
+}
+
+static int zram_writeback_slots(struct zram *zram,
+				struct zram_pp_ctl *ctl,
+				struct zram_wb_ctl *wb_ctl)
+{
+	struct zram_wb_req *req = NULL;
+	unsigned long blk_idx = 0;
+	struct zram_pp_slot *pps;
+	int ret = 0, err;
+	u32 index = 0;
 
+	blk_start_plug(&wb_ctl->plug);
 	while ((pps = select_pp_slot(ctl))) {
 		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
@@ -757,15 +943,34 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 		}
 		spin_unlock(&zram->wb_limit_lock);
 
+		while (!req) {
+			req = select_idle_req(wb_ctl);
+			if (req)
+				break;
+
+			blk_finish_plug(&wb_ctl->plug);
+			err = zram_wb_wait_for_completion(zram, wb_ctl);
+			blk_start_plug(&wb_ctl->plug);
+			/*
+			 * BIO errors are not fatal, we continue and simply
+			 * attempt to writeback the remaining objects (pages).
+			 * At the same time we need to signal user-space that
+			 * some writes (at least one, but also could be all of
+			 * them) were not successful and we do so by returning
+			 * the most recent BIO error.
+			 */
+			if (err)
+				ret = err;
+		}
+
 		if (!blk_idx) {
 			blk_idx = alloc_block_bdev(zram);
-			if (!blk_idx) {
+			if (blk_idx) {
 				ret = -ENOSPC;
 				break;
 			}
 		}
 
-		index = pps->index;
 		zram_slot_lock(zram, index);
 		/*
 		 * scan_slots() sets ZRAM_PP_SLOT and relases slot lock, so
@@ -775,67 +980,41 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
 		 */
 		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
 			goto next;
-		if (zram_read_from_zspool(zram, page, index))
+		if (zram_read_from_zspool(zram, req->page, index))
 			goto next;
 		zram_slot_unlock(zram, index);
 
-		bio_init(&bio, zram->bdev, &bio_vec, 1,
+		req->blk_idx = blk_idx;
+		req->pps = pps;
+		bio_init(&req->bio, zram->bdev, &req->bio_vec, 1,
 			 REQ_OP_WRITE | REQ_SYNC);
-		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
-		__bio_add_page(&bio, page, PAGE_SIZE, 0);
+		req->bio.bi_iter.bi_sector = req->blk_idx * (PAGE_SIZE >> 9);
+		req->bio.bi_end_io = zram_writeback_endio;
+		req->bio.bi_private = wb_ctl;
+		__bio_add_page(&req->bio, req->page, PAGE_SIZE, 0);
 
-		/*
-		 * XXX: A single page IO would be inefficient for write
-		 * but it would be not bad as starter.
-		 */
-		err = submit_bio_wait(&bio);
-		if (err) {
-			release_pp_slot(zram, pps);
-			/*
-			 * BIO errors are not fatal, we continue and simply
-			 * attempt to writeback the remaining objects (pages).
-			 * At the same time we need to signal user-space that
-			 * some writes (at least one, but also could be all of
-			 * them) were not successful and we do so by returning
-			 * the most recent BIO error.
-			 */
-			ret = err;
-			continue;
-		}
-
-		atomic64_inc(&zram->stats.bd_writes);
-		zram_slot_lock(zram, index);
-		/*
-		 * Same as above, we release slot lock during writeback so
-		 * slot can change under us: slot_free() or slot_free() and
-		 * reallocation (zram_write_page()). In both cases slot loses
-		 * ZRAM_PP_SLOT flag. No concurrent post-processing can set
-		 * ZRAM_PP_SLOT on such slots until current post-processing
-		 * finishes.
-		 */
-		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
-			goto next;
-
-		zram_free_page(zram, index);
-		zram_set_flag(zram, index, ZRAM_WB);
-		zram_set_handle(zram, index, blk_idx);
+		zram_submit_wb_request(wb_ctl, req);
 		blk_idx = 0;
-		atomic64_inc(&zram->stats.pages_stored);
-		spin_lock(&zram->wb_limit_lock);
-		if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
-			zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
-		spin_unlock(&zram->wb_limit_lock);
+		req = NULL;
+		continue;
+
 next:
 		zram_slot_unlock(zram, index);
 		release_pp_slot(zram, pps);
-
 		cond_resched();
 	}
 
-	if (blk_idx)
-		free_block_bdev(zram, blk_idx);
-	if (page)
-		__free_page(page);
+	/*
+	 * Selected idle req, but never submitted it due to some error or
+	 * wb limit.
+	 */
+	if (req)
+		release_wb_req(req);
+
+	blk_finish_plug(&wb_ctl->plug);
+	err = zram_wb_wait_for_completion(zram, wb_ctl);
+	if (err)
+		ret = err;
 
 	return ret;
 }
@@ -948,7 +1127,8 @@ static ssize_t writeback_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	u64 nr_pages = zram->disksize >> PAGE_SHIFT;
 	unsigned long lo = 0, hi = nr_pages;
-	struct zram_pp_ctl *ctl = NULL;
+	struct zram_pp_ctl *pp_ctl = NULL;
+	struct zram_wb_ctl *wb_ctl = NULL;
 	char *args, *param, *val;
 	ssize_t ret = len;
 	int err, mode = 0;
@@ -970,8 +1150,14 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	ctl = init_pp_ctl();
-	if (!ctl) {
+	pp_ctl = init_pp_ctl();
+	if (!pp_ctl) {
+		ret = -ENOMEM;
+		goto release_init_lock;
+	}
+
+	wb_ctl = init_wb_ctl();
+	if (!wb_ctl) {
 		ret = -ENOMEM;
 		goto release_init_lock;
 	}
@@ -1000,7 +1186,7 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			break;
 		}
 
@@ -1011,7 +1197,7 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			break;
 		}
 
@@ -1022,7 +1208,7 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			continue;
 		}
 
@@ -1033,17 +1219,18 @@ static ssize_t writeback_store(struct device *dev,
 				goto release_init_lock;
 			}
 
-			scan_slots_for_writeback(zram, mode, lo, hi, ctl);
+			scan_slots_for_writeback(zram, mode, lo, hi, pp_ctl);
 			continue;
 		}
 	}
 
-	err = zram_writeback_slots(zram, ctl);
+	err = zram_writeback_slots(zram, pp_ctl, wb_ctl);
 	if (err)
 		ret = err;
 
 release_init_lock:
-	release_pp_ctl(zram, ctl);
+	release_pp_ctl(zram, pp_ctl);
+	release_wb_ctl(wb_ctl);
 	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
 
-- 
2.51.2.1041.gc1ab5b90ca-goog


