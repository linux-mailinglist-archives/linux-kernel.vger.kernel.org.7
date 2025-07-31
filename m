Return-Path: <linux-kernel+bounces-751678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8FDB16C34
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3CF5563AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3967228DB56;
	Thu, 31 Jul 2025 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJe+p2O4"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E583C28D8D9
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753944660; cv=none; b=C2sFQ9nboT/1+aEqys8KrGLUI6ph2VNvWJTFt7Qo4yv6tV3vYpgDQ3TYYA2+V4bnQiYhb520PhIDyz/UNenh76tsncwqE7rIrNCLK1vOQkM2r5aKsn1wEcTVnFVGcbdJLHCqhoDsehWS11iYHvXJRaKDQEWGAChC11gYvifoFZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753944660; c=relaxed/simple;
	bh=G+UT1S3qj26BV2xnMB/dporrcHS4uOhh/Cg7uwxTjro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o/YbZCjrsp3H8ArlWgeOQ45R4bpf2Bz36AFxuStjpbseL1+qlbMsGr0Q+Oa9spOdDIJtqPzjrxIk8p4XcEpeEl+YrAWqN4lzwVabq76dXXHd0xkVvO9kKGGKYJ6a2mFofyhPsiIEMUIHO82Fuc2OywYxQwP+e17dN0xkNPGJ8kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WJe+p2O4; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--richardycc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bcf2cac36so315162b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 23:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753944658; x=1754549458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dGUE3+fkLdFpOKkrsZLlRFaze4JHwy3kWJ1YQNILIOw=;
        b=WJe+p2O4ETZ2eFhYQwXIBVoXUgd3Smrd/PHICyWg8Gjp/dUgRKxBF3HmWuDpKs+c97
         w1KIt+cEmOdaNqOjXpdI+Pk6KzsXVSxJwOMsCGmEyvnrGJx6d4aLN1+3e63ssdR74HIk
         5WJgxqxr3z7jD9xNxoiR4A5oZd27iG0O+YQwu+87vwH55L4ynW0H/rWfX+F0i/v6T3II
         Y/wvVfOVI9NAAe0LbACxGPCzE+3sULJXWVxNp7P1gMhnT/0PNJ41b0ab0cL0kv+Hzd3Z
         fQ0RobyuCAMbVmg6fGUSD/zX5/zWhsNpMzZMYfuYt8aFit6Zy3Gvrv1L+eL1Rg1IvqEV
         IGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753944658; x=1754549458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGUE3+fkLdFpOKkrsZLlRFaze4JHwy3kWJ1YQNILIOw=;
        b=GYpLrI7+z1IpHs9xzjO3RtogTLvq9Dt3vLFd8E8isasK2i9+OqM4cgx2qWBgcbbOC/
         VI5c6WjDSCJXQvMq22E2QN7oa9LYcajZTx+wJkkdZDELc2GMFy4P0n7FR2FtV1BWz48N
         +DQWn6/BDRWJjl3NnWzJg1XwqKYJSobJzc4DXIFHr80kZEvcEJTF7PLjR+tOpZYo62Z+
         2f2gKkTyQe8V/j1lvsc4VY6PrEt0doy8cv8OAdME1Lnd9w/QuH3CibWvEgrq+qrhQvsJ
         RlU1/giJZn4FiJ26ndkuzrUO8y6Xm/5+H2lwYc9Jmgxy4BEJpjwW0O0Ve2q0yfeuYdgv
         9mjg==
X-Forwarded-Encrypted: i=1; AJvYcCW5dHpragHDLV0b3mHtydx1Nkq0Io7conFjaOtFpTGSxAt84XZ7//VFagFcWb/L3u/cQsxP6aHCVBTYyjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEqOvVwH52MXIxsOVBKg47UUUB5vPr0hTX6r9Cfm9eKtlDenkX
	+V9Dox+QJX0Y1OSiE9Wk0IhRLor6pTpzHChNCI1MgOq7nOAxIQhJXGNeAGg8mnqH5Ddh57Jx3uk
	gYjyhulD+nuAEh/bRlop8
X-Google-Smtp-Source: AGHT+IEgVBWm/BLKTiVc6BPX/+JCFhdiQ8GmUIXhRNeX1+TmocJCuFg4OY1N6Lq5dY3Gt40NAXUyRmKvEykmSYEi
X-Received: from pgah15.prod.google.com ([2002:a05:6a02:4e8f:b0:b42:2a6f:4fcc])
 (user=richardycc job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6da1:b0:233:d85e:a69b with SMTP id adf61e73a8af0-23dc0eba156mr9493234637.39.1753944658322;
 Wed, 30 Jul 2025 23:50:58 -0700 (PDT)
Date: Thu, 31 Jul 2025 06:49:47 +0000
In-Reply-To: <20250731064949.1690732-1-richardycc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250731064949.1690732-1-richardycc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250731064949.1690732-2-richardycc@google.com>
Subject: [PATCH v2 1/3] zram: refactor writeback helpers
From: Richard Chang <richardycc@google.com>
To: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>
Cc: bgeffon@google.com, liumartin@google.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, 
	Richard Chang <richardycc@google.com>
Content-Type: text/plain; charset="UTF-8"

Move writeback-related functions and data structures from zram_drv.[ch]
to a new zram_wb.[ch] file. This is a pure refactoring patch with no
functional changes, preparing the ground for the upcoming asynchronous
writeback implementation.

Signed-off-by: Richard Chang <richardycc@google.com>
---
 drivers/block/zram/Makefile   |  1 +
 drivers/block/zram/zram_drv.c | 44 +----------------------------------
 drivers/block/zram/zram_drv.h | 19 +++++++++++++++
 drivers/block/zram/zram_wb.c  | 35 ++++++++++++++++++++++++++++
 drivers/block/zram/zram_wb.h  | 18 ++++++++++++++
 5 files changed, 74 insertions(+), 43 deletions(-)
 create mode 100644 drivers/block/zram/zram_wb.c
 create mode 100644 drivers/block/zram/zram_wb.h

diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 0fdefd576691..31ee1ed34e17 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -8,5 +8,6 @@ zram-$(CONFIG_ZRAM_BACKEND_LZ4HC)	+= backend_lz4hc.o
 zram-$(CONFIG_ZRAM_BACKEND_ZSTD)	+= backend_zstd.o
 zram-$(CONFIG_ZRAM_BACKEND_DEFLATE)	+= backend_deflate.o
 zram-$(CONFIG_ZRAM_BACKEND_842)		+= backend_842.o
+zram-$(CONFIG_ZRAM_WRITEBACK)		+= zram_wb.o
 
 obj-$(CONFIG_ZRAM)	+=	zram.o
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 8acad3cc6e6e..ec8649cad21e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -36,6 +36,7 @@
 #include <linux/kernel_read_file.h>
 
 #include "zram_drv.h"
+#include "zram_wb.h"
 
 static DEFINE_IDR(zram_index_idr);
 /* idr index must be protected */
@@ -233,22 +234,6 @@ static void zram_accessed(struct zram *zram, u32 index)
 }
 
 #if defined CONFIG_ZRAM_WRITEBACK || defined CONFIG_ZRAM_MULTI_COMP
-struct zram_pp_slot {
-	unsigned long		index;
-	struct list_head	entry;
-};
-
-/*
- * A post-processing bucket is, essentially, a size class, this defines
- * the range (in bytes) of pp-slots sizes in particular bucket.
- */
-#define PP_BUCKET_SIZE_RANGE	64
-#define NUM_PP_BUCKETS		((PAGE_SIZE / PP_BUCKET_SIZE_RANGE) + 1)
-
-struct zram_pp_ctl {
-	struct list_head	pp_buckets[NUM_PP_BUCKETS];
-};
-
 static struct zram_pp_ctl *init_pp_ctl(void)
 {
 	struct zram_pp_ctl *ctl;
@@ -697,31 +682,6 @@ static ssize_t backing_dev_store(struct device *dev,
 	return err;
 }
 
-static unsigned long alloc_block_bdev(struct zram *zram)
-{
-	unsigned long blk_idx = 1;
-retry:
-	/* skip 0 bit to confuse zram.handle = 0 */
-	blk_idx = find_next_zero_bit(zram->bitmap, zram->nr_pages, blk_idx);
-	if (blk_idx == zram->nr_pages)
-		return 0;
-
-	if (test_and_set_bit(blk_idx, zram->bitmap))
-		goto retry;
-
-	atomic64_inc(&zram->stats.bd_count);
-	return blk_idx;
-}
-
-static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
-{
-	int was_set;
-
-	was_set = test_and_clear_bit(blk_idx, zram->bitmap);
-	WARN_ON_ONCE(!was_set);
-	atomic64_dec(&zram->stats.bd_count);
-}
-
 static void read_from_bdev_async(struct zram *zram, struct page *page,
 			unsigned long entry, struct bio *parent)
 {
@@ -1111,8 +1071,6 @@ static int read_from_bdev(struct zram *zram, struct page *page,
 {
 	return -EIO;
 }
-
-static void free_block_bdev(struct zram *zram, unsigned long blk_idx) {};
 #endif
 
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 6cee93f9c0d0..2c7bc05fb186 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -139,4 +139,23 @@ struct zram {
 #endif
 	atomic_t pp_in_progress;
 };
+
+#if defined CONFIG_ZRAM_WRITEBACK || defined CONFIG_ZRAM_MULTI_COMP
+struct zram_pp_slot {
+	unsigned long		index;
+	struct list_head	entry;
+};
+
+/*
+ * A post-processing bucket is, essentially, a size class, this defines
+ * the range (in bytes) of pp-slots sizes in particular bucket.
+ */
+#define PP_BUCKET_SIZE_RANGE	64
+#define NUM_PP_BUCKETS		((PAGE_SIZE / PP_BUCKET_SIZE_RANGE) + 1)
+
+struct zram_pp_ctl {
+	struct list_head	pp_buckets[NUM_PP_BUCKETS];
+};
+#endif
+
 #endif
diff --git a/drivers/block/zram/zram_wb.c b/drivers/block/zram/zram_wb.c
new file mode 100644
index 000000000000..0bc10f725939
--- /dev/null
+++ b/drivers/block/zram/zram_wb.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define KMSG_COMPONENT "zram_wb"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+#include "zram_wb.h"
+
+unsigned long alloc_block_bdev(struct zram *zram)
+{
+	unsigned long blk_idx = 1;
+retry:
+	/* skip 0 bit to confuse zram.handle = 0 */
+	blk_idx = find_next_zero_bit(zram->bitmap, zram->nr_pages, blk_idx);
+	if (blk_idx == zram->nr_pages)
+		return 0;
+
+	if (test_and_set_bit(blk_idx, zram->bitmap))
+		goto retry;
+
+	atomic64_inc(&zram->stats.bd_count);
+	return blk_idx;
+}
+
+void free_block_bdev(struct zram *zram, unsigned long blk_idx)
+{
+	int was_set;
+
+	was_set = test_and_clear_bit(blk_idx, zram->bitmap);
+	WARN_ON_ONCE(!was_set);
+	atomic64_dec(&zram->stats.bd_count);
+}
+
diff --git a/drivers/block/zram/zram_wb.h b/drivers/block/zram/zram_wb.h
new file mode 100644
index 000000000000..c2f5984e7aa2
--- /dev/null
+++ b/drivers/block/zram/zram_wb.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _ZRAM_WRITEBACK_H_
+#define _ZRAM_WRITEBACK_H_
+
+#include <linux/bio.h>
+#include "zram_drv.h"
+
+#if IS_ENABLED(CONFIG_ZRAM_WRITEBACK)
+unsigned long alloc_block_bdev(struct zram *zram);
+void free_block_bdev(struct zram *zram, unsigned long blk_idx);
+#else
+inline unsigned long alloc_block_bdev(struct zram *zram) { return 0; }
+inline void free_block_bdev(struct zram *zram, unsigned long blk_idx) {};
+#endif
+
+#endif /* _ZRAM_WRITEBACK_H_ */
+
-- 
2.50.1.565.gc32cd1483b-goog


