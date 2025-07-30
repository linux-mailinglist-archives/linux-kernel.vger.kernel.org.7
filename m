Return-Path: <linux-kernel+bounces-751419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DC2B16957
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E45E7B5B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC08239E62;
	Wed, 30 Jul 2025 23:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxpBHqFz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326082222D8
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753918866; cv=none; b=taCsNXxY477IX1TGk6p+Hs9zPZrrJjNccB6ZaRHJquVhZhdAcVBZWFifP/Ybgvl+p94pFY/q+5NeaugfJHCNeE12ZiPcRVr/1Uyg/8qNJo3uNUJzIzYYU1+x+6tua9LUiG6XJ8gpEGpphG1aWu4P9vFvFIzcWsDsZTQlCGzTglg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753918866; c=relaxed/simple;
	bh=+lHkUh0H44hhPseDEoyNcZJEQoFHl6NXX96JTxTqX7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pKXRlgmrkL/coeG9TJqIsOTodA+75YC/YR0lECdoVhzQszu0TGTY2w6xsj9loOLNaatZqWJaeY0T9+LLMoV9DyKXfEI09JhQemWvXc6CTAzZRTlVPi8VAfrBhT4NfMU94lfQN4D9Edv7d6K63elWGqblpSrIg8SW4WwxtXOPOqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxpBHqFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606EAC4CEE3;
	Wed, 30 Jul 2025 23:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753918865;
	bh=+lHkUh0H44hhPseDEoyNcZJEQoFHl6NXX96JTxTqX7U=;
	h=From:To:Cc:Subject:Date:From;
	b=fxpBHqFzPkzrmD1L+ehP7qPjsRYnQtH+6WRiv0iI7/+Fk1KBSERZRgKlESZLqa+kv
	 O8t6QeVJ7wQsJP0OIvyb2Wcd2xkTVQjYVMjq/uiup9ujWyrTJLRDMzYYX1Z34EOQYg
	 Jy3r28bn4OYTC56EQ4sHXFpbbDdG8mnjLW7ZtIotm4M7nYGn53IMv9qVbzNiAaLbsF
	 hQkSEyVeI/Kzu3gTsED5QXVsF+AH76hrSjroVYKKGxXdMu/tYJMc5OXStoUxngOtKA
	 TNVC1bwf73PkOVChaNZ2BEpNE+3FrBn7eZsos20fFV3S5151LPkb2o7SQFb4m+G7ld
	 yxPguxQkZBHiQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Takero Funaki <flintglass@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/zswap: store compression failed page as-is
Date: Wed, 30 Jul 2025 16:40:59 -0700
Message-Id: <20250730234059.4603-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When zswap writeback is enabled and it fails compressing a given page,
zswap lets the page be swapped out to the backing swap device.  This
behavior breaks the zswap's writeback LRU order, and hence users can
experience unexpected latency spikes.

Keep the LRU order by storing the original content in zswap as-is.  The
original content is saved in a dynamically allocated page size buffer,
and the pointer to the buffer is kept in zswap_entry, on the space for
zswap_entry->pool.  Whether the space is used for the original content
or zpool is identified by 'zswap_entry->length == PAGE_SIZE'.

This avoids increasing per zswap entry metadata overhead.  But as the
number of incompressible pages increases, zswap metadata overhead is
proportionally increased.  The overhead should not be problematic in
usual cases, since the zswap metadata for single zswap entry is much
smaller than PAGE_SIZE, and in common zswap use cases there should be
sufficient amount of compressible pages.  Also it can be mitigated by
the zswap writeback.

When the memory pressure comes from memcg's memory.high and zswap
writeback is set to be triggered for that, however, the penalty_jiffies
sleep could degrade the performance.  Add a parameter, namely
'save_incompressible_pages', to turn the feature on/off as users want.
It is turned off by default.

When the writeback is just disabled, the additional overhead could be
problematic.  For the case, keep the behavior that just returns the
failure and let swap_writeout() puts the page back to the active LRU
list in the case.  It is known to be suboptimal when the incompressible
pages are cold, since the incompressible pages will continuously be
tried to be zswapped out, and burn CPU cycles for compression attempts
that will anyway fails.  But that's out of the scope of this patch.

Tests
-----

I tested this patch using a simple self-written microbenchmark that is
available at GitHub[1].  You can reproduce the test I did by executing
run_tests.sh of the repo on your system.  Note that the repo's
documentation is not good as of this writing, so you may need to read
and use the code.

The basic test scenario is simple.  Run a test program making artificial
accesses to memory having artificial content under memory.high-set
memory limit and measure how many accesses were made in given time.

The test program repeatedly and randomly access three anonymous memory
regions.  The regions are all 500 MiB size, and accessed in same
probability.  Two of those are filled up with a simple content that can
easily be compressed, while the remaining one is filled up with a
content that read from /dev/urandom, which is easy to fail at
compressing.  The program runs for two minutes and prints out the number
of accesses made every five seconds.

The test script runs the program under below seven configurations.

- 0: memory.high is set to 2 GiB, zswap is disabled.
- 1-1: memory.high is set to 1350 MiB, zswap is disabled.
- 1-2: Same to 1-1, but zswap is enabled.
- 1-3: Same to 1-2, but save_incompressible_pages is turned on.
- 2-1: memory.high is set to 1200 MiB, zswap is disabled.
- 2-2: Same to 2-1, but zswap is enabled.
- 2-3: Same to 2-2, but save_incompressible_pages is turned on.

Configuration '0' is for showing the original memory performance.
Configurations 1-1, 1-2 and 1-3 are for showing the performance of swap,
zswap, and this patch under a level of memory pressure (~10% of working
set).

Configurations 2-1, 2-2 and 2-3 are similar to 1-1, 1-2 and 1-3 but to
show those under a severe level of memory pressure (~20% of the working
set).

Because the per-5 seconds performance is not very reliable, I measured
the average of that for the last one minute period of the test program
run.  I also measured a few vmstat counters including zswpin, zswpout,
zswpwb, pswpin and pswpout during the test runs.

The measurement results are as below.  To save space, I show performance
numbers that are normalized to that of the configuration '0' (no memory
pressure), only.  The averaged accesses per 5 seconds of configuration
'0' was 34612740.66.

    config            0       1-1     1-2      1-3      2-1     2-2      2-3
    perf_normalized   1.0000  0.0060  0.0230   0.0310   0.0030  0.0116   0.0003
    perf_stdev_ratio  0.06    0.04    0.11     0.14     0.03    0.05     0.26
    zswpin            0       0       1701702  6982188  0       2479848  815742
    zswpout           0       0       1725260  7048517  0       2535744  931420
    zswpwb            0       0       0        0        0       0        0
    pswpin            0       468612  481270   0        476434  535772   0
    pswpout           0       574634  689625   0        612683  591881   0

'perf_normalized' is the performance metric, normalized to that of
configuration '0' (no pressure).  'perf_stdev_ratio' is the standard
deviation of the averaged data points, as a ratio to the averaged metric
value.  For example, configuration '0' performance was showing 6% stdev.
Configurations 1-2 and 1-3 were having about 11% and 14% stdev.  So the
measurement is not very stable.  Please keep this in your mind when
reading these results.  It shows some rough patterns, though.

Under about 10% of working set memory pressure, the performance was
dropped to about 0.6% of no-pressure one, when the normal swap is used
(1-1).  Actually ~10% working set pressure is not a mild one, at least
on this test setup.

By turning zswap on (1-2), the performance was improved about 4x,
resulting in about 2.3% of no-pressure one.  Because of the
incompressible pages in the third memory region, a significant amount of
(non-zswap) swap I/O operations were made, though.

By enabling the incompressible pages handling feature that is introduced
by this patch (1-3), about 34% performance improvement was made,
resulting in about 3.1% of no-pressure one.  As expected, compression
failed pages were handled by zswap, and hence no (non-zswap) swap I/O
was made in this configuration.

Under about 20% of working set memory pressure, which could be extreme,
the performance drops down to 0.3% of no-pressure one when only the
normal swap is used (2-1).  Enabling zswap significantly improves it, up
to 1.16%, though again showing a significant number of (non-zswap) swap
I/O due to incompressible pages.

Enabling the incompressible pages handling feature of this patch (2-3)
reduced non-zswap swap I/O as expected, but the performance became
worse, 0.03% of no-pressure one.  It turned out this is because of
memory.high-imposed penalty_jiffies sleep.  By commenting out the
penalty_jiffies sleep code of mem_cgroup_handle_over_high(), the
performance became higher than 2-2.

20% of working set memory pressure is pretty extreme, but anyway the
incompressible pages handling feature could make it worse in certain
setups.  Hence this version of the patch adds the parameter for turning
the feature on/off as needed, and makes it disabled by default.

Related Works
-------------

This is not an entirely new attempt.  There were a couple of similar
approaches in the past.  Nhat Pham tried a very same approach[2] in
October 2023.  Takero Funaki also tried a very similar approach[3] in
April 2024.

The two approaches didn't get merged mainly due to the metadata overhead
concern.  I described why I think that shouldn't be a problem for this
change, which is automatically disabled when writeback is disabled, at
the beginning of this changelog.

This patch is not particularly different from those, and actually built
upon those.  I wrote this from scratch again, though.  I have no good
idea about how I can give credits to the authors of the previously made
nearly-same attempts, and I should be responsible to maintain this
change if this is upstreamed, so taking the authorship for now.  Please
let me know if you know a better way to give them their deserved
credits.

[1] https://github.com/sjp38/eval_zswap/blob/master/run.sh
[2] https://lore.kernel.org/20231017003519.1426574-3-nphamcs@gmail.com
[3] https://lore.kernel.org/20240706022523.1104080-6-flintglass@gmail.com

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/zswap.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 8 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 7e02c760955f..e021865696c6 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -45,6 +45,9 @@
 /* The number of compressed pages currently stored in zswap */
 atomic_long_t zswap_stored_pages = ATOMIC_LONG_INIT(0);
 
+/* The number of uncompressed pages currently stored in zswap */
+atomic_long_t zswap_stored_uncompressed_pages = ATOMIC_LONG_INIT(0);
+
 /*
  * The statistics below are not protected from concurrent access for
  * performance reasons so they may not be a 100% accurate.  However,
@@ -129,6 +132,11 @@ static bool zswap_shrinker_enabled = IS_ENABLED(
 		CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
 module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644);
 
+/* Store incompressible pages as is */
+static bool zswap_save_incompressible_pages;
+module_param_named(save_incompressible_pages, zswap_save_incompressible_pages,
+		bool, 0644);
+
 bool zswap_is_enabled(void)
 {
 	return zswap_enabled;
@@ -190,7 +198,8 @@ static struct shrinker *zswap_shrinker;
  *              writeback logic. The entry is only reclaimed by the writeback
  *              logic if referenced is unset. See comments in the shrinker
  *              section for context.
- * pool - the zswap_pool the entry's data is in
+ * orig_data - uncompressed original data of the page, if length is PAGE_SIZE
+ * pool - the zswap_pool the entry's data is in, if length is not PAGE_SIZE
  * handle - zpool allocation handle that stores the compressed page data
  * objcg - the obj_cgroup that the compressed memory is charged to
  * lru - handle to the pool's lru used to evict pages.
@@ -199,7 +208,10 @@ struct zswap_entry {
 	swp_entry_t swpentry;
 	unsigned int length;
 	bool referenced;
-	struct zswap_pool *pool;
+	union {
+		void *orig_data;
+		struct zswap_pool *pool;
+	};
 	unsigned long handle;
 	struct obj_cgroup *objcg;
 	struct list_head lru;
@@ -500,7 +512,7 @@ unsigned long zswap_total_pages(void)
 		total += zpool_get_total_pages(pool->zpool);
 	rcu_read_unlock();
 
-	return total;
+	return total + atomic_long_read(&zswap_stored_uncompressed_pages);
 }
 
 static bool zswap_check_limits(void)
@@ -805,8 +817,13 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
 static void zswap_entry_free(struct zswap_entry *entry)
 {
 	zswap_lru_del(&zswap_list_lru, entry);
-	zpool_free(entry->pool->zpool, entry->handle);
-	zswap_pool_put(entry->pool);
+	if (entry->length == PAGE_SIZE) {
+		kfree(entry->orig_data);
+		atomic_long_dec(&zswap_stored_uncompressed_pages);
+	} else {
+		zpool_free(entry->pool->zpool, entry->handle);
+		zswap_pool_put(entry->pool);
+	}
 	if (entry->objcg) {
 		obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
 		obj_cgroup_put(entry->objcg);
@@ -937,6 +954,36 @@ static void acomp_ctx_put_unlock(struct crypto_acomp_ctx *acomp_ctx)
 	mutex_unlock(&acomp_ctx->mutex);
 }
 
+/*
+ * If the compression is failed, try saving the content as is without
+ * compression, to keep the LRU order.  This can increase memory overhead from
+ * metadata, but in common zswap use cases where there are sufficient amount of
+ * compressible pages, the overhead should be not ciritical, and can be
+ * mitigated by the writeback.  Also, the decompression overhead is optimized.
+ *
+ * When the writeback is disabled, however, the additional overhead could be
+ * problematic.  For the case, just return the failure.  swap_writeout() will
+ * put the page back to the active LRU list in the case.
+ */
+static int zswap_handle_compression_failure(int comp_ret, struct page *page,
+		struct zswap_entry *entry)
+{
+	if (!zswap_save_incompressible_pages)
+		return comp_ret;
+	if (!mem_cgroup_zswap_writeback_enabled(
+				folio_memcg(page_folio(page))))
+		return comp_ret;
+
+	entry->orig_data = kmalloc_node(PAGE_SIZE, GFP_NOWAIT | __GFP_NORETRY |
+			__GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
+	if (!entry->orig_data)
+		return -ENOMEM;
+	memcpy_from_page(entry->orig_data, page, 0, PAGE_SIZE);
+	entry->length = PAGE_SIZE;
+	atomic_long_inc(&zswap_stored_uncompressed_pages);
+	return 0;
+}
+
 static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 			   struct zswap_pool *pool)
 {
@@ -976,8 +1023,11 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	 */
 	comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
 	dlen = acomp_ctx->req->dlen;
-	if (comp_ret)
+	if (comp_ret) {
+		comp_ret = zswap_handle_compression_failure(comp_ret, page,
+				entry);
 		goto unlock;
+	}
 
 	zpool = pool->zpool;
 	gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE;
@@ -1009,6 +1059,11 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	int decomp_ret, dlen;
 	u8 *src, *obj;
 
+	if (entry->length == PAGE_SIZE) {
+		memcpy_to_folio(folio, 0, entry->orig_data, entry->length);
+		return true;
+	}
+
 	acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool);
 	obj = zpool_obj_read_begin(zpool, entry->handle, acomp_ctx->buffer);
 
@@ -1518,7 +1573,8 @@ static bool zswap_store_page(struct page *page,
 	 * The opposite actions will be performed by zswap_entry_free()
 	 * when the entry is removed from the tree.
 	 */
-	zswap_pool_get(pool);
+	if (entry->length != PAGE_SIZE)
+		zswap_pool_get(pool);
 	if (objcg) {
 		obj_cgroup_get(objcg);
 		obj_cgroup_charge_zswap(objcg, entry->length);
@@ -1535,7 +1591,8 @@ static bool zswap_store_page(struct page *page,
 	 *    The publishing order matters to prevent writeback from seeing
 	 *    an incoherent entry.
 	 */
-	entry->pool = pool;
+	if (entry->length != PAGE_SIZE)
+		entry->pool = pool;
 	entry->swpentry = page_swpentry;
 	entry->objcg = objcg;
 	entry->referenced = true;

base-commit: b771a67861b3538324c3df25d337f4713ee53e03
-- 
2.39.5

