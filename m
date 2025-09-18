Return-Path: <linux-kernel+bounces-759395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6914B1DCF4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58AE73BA53D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072E52222B6;
	Thu,  7 Aug 2025 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzMn77k2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B06E14884C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754590581; cv=none; b=ZJtpa7i9HYD6Iuk59PvJQwT2GV+ZOkX7VuiTdi6flbACOptfWdWDkVzoE3u/VXwvAW9sRgLVxi0ZX+zfbDgR01KcXAMa5LpQRgmh3fduEw9V6fX0XPA66efEceDU76en+GOdWQaNCogd6kDpG9Ejq6PEj0jVcl9JlBWkIzrbHDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754590581; c=relaxed/simple;
	bh=JoQgC6zNM11H86q8TF9fAO+e/aCVUyMLSqBJpfu95H8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bgcjI/E9t4rV8W3FIyU8Gtk/xHLJmKdbsltpwcvFupI+J7hA90rGoEIb6goWd9Wk88W8SYMJeCWmBfYCbgWOV7Nkg3rqmFRXo8jcgGf2S7TaHVG9RO1QgLz+gOinSKg94GVD3B8mbJKtgrKTRlbi4iz8Wa7DCt3UfqAtkUXxvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzMn77k2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B93C4CEEB;
	Thu,  7 Aug 2025 18:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754590580;
	bh=JoQgC6zNM11H86q8TF9fAO+e/aCVUyMLSqBJpfu95H8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZzMn77k2ksIyI9xlWR9kEvK2b2tFCP8Q8Qm6WSHyBjRVPBTvl6TWkvl/9usnCXYtc
	 acHPXKErc8Ka+AN+P1sk7Vd83JAGhfPeFjpJ1WyyNiWUpnry/meTX+u0T6RmaJEZqJ
	 uw50R2P3OZ8q3Zyk4gXi/P9wdVQXjoWk+dO5zgC5C3pgvJaeUrkCvrARoUUZcIBsZk
	 mdfgweslTJhSkU69YvSQ7BVMlg0zvTnI49RbDhl5IUMD0/A8jOlKz8IFRsYnyIzIYw
	 sys4H/Do/fhgbgQUrOotwoP3KgY0Gdrt0lwSMF9wFpunwCb10tHTav24TzhesUeROV
	 bM1bydVaxB/Gw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>
Subject: [PATCH] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Thu,  7 Aug 2025 11:16:16 -0700
Message-Id: <20250807181616.1895-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When zswap writeback is enabled and it fails compressing a given page,
the page is swapped out to the backing swap device.  This behavior
breaks the zswap's writeback LRU order, and hence users can experience
unexpected latency spikes.  If the page is compressed without failure,
but results in a size of PAGE_SIZE, the LRU order is kept, but the
decompression overhead for loading the page back on the later access is
unnecessary.

Keep the LRU order and optimize unnecessary decompression overheads in
those cases, by storing the original content as-is in zpool.  The length
field of zswap_entry will be set appropriately, as PAGE_SIZE,  Hence
whether it is saved as-is or not (whether decompression is unnecessary)
is identified by 'zswap_entry->length == PAGE_SIZE'.

Because the uncompressed data is saved in zpool, same to the compressed
ones, this introduces no change in terms of memory management including
movability and migratability of involved pages.

This change is also not increasing per zswap entry metadata overhead.
But as the number of incompressible pages increases, total zswap
metadata overhead is proportionally increased.  The overhead should not
be problematic in usual cases, since the zswap metadata for single zswap
entry is much smaller than PAGE_SIZE, and in common zswap use cases
there should be a sufficient amount of compressible pages.  Also it can
be mitigated by the zswap writeback.

When the writeback is disabled, the additional overhead could be
problematic.  For the case, keep the current behavior that just returns
the failure and let swap_writeout() put the page back to the active LRU
list in the case.  It is known to be suboptimal when the incompressible
pages are cold, since the incompressible pages will continuously be
tried to be zswapped out, and burn CPU cycles for compression attempts
that will anyway fails.  One imaginable solution for the problem is
reusing the swapped-out page and its struct page to store in the zswap
pool.  But that's out of the scope of this patch.

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
regions.  The regions are all 500 MiB size, and accessed in the same
probability.  Two of those are filled up with a simple content that can
easily be compressed, while the remaining one is filled up with a
content that read from /dev/urandom, which is easy to fail at
compressing to <PAGE_SIZE size.  The program runs for two minutes and
prints out the number of accesses made every five seconds.

The test script runs the program under below seven configurations.

- 0: memory.high is set to 2 GiB, zswap is disabled.
- 1-1: memory.high is set to 1350 MiB, zswap is disabled.
- 1-2: On 1-1, zswap is enabled without this patch.
- 1-3: On 1-2, this patch is applied.

For all zswap enabled case, zswap shrinker is enabled.

Configuration '0' is for showing the original memory performance.
Configurations 1-1, 1-2 and 1-3 are for showing the performance of swap,
zswap, and this patch under a level of memory pressure (~10% of working
set).

Because the per-5 seconds performance is not very reliable, I measured
the average of that for the last one minute period of the test program
run.  I also measured a few vmstat counters including zswpin, zswpout,
zswpwb, pswpin and pswpout during the test runs.

The measurement results are as below.  To save space, I show performance
numbers that are normalized to that of the configuration '0' (no memory
pressure), only.  The averaged accesses per 5 seconds of configuration
'0' was 36493417.75.

    config            0       1-1     1-2      1-3
    perf_normalized   1.0000  0.0057  0.0235   0.0367
    perf_stdev_ratio  0.0582  0.0652  0.0167   0.0346
    zswpin            0       0       3548424  1999335
    zswpout           0       0       3588817  2361689
    zswpwb            0       0       10214    340270
    pswpin            0       485806  772038   340967
    pswpout           0       649543  144773   340270

'perf_normalized' is the performance metric, normalized to that of
configuration '0' (no pressure).  'perf_stdev_ratio' is the standard
deviation of the averaged data points, as a ratio to the averaged metric
value.  For example, configuration '0' performance was showing 5.8%
stdev.  Configurations 1-1 and 1-3 were having about 6.5% and 6.1%
stdev.  Also the results were highly variable between multiple runs.  So
this result is not very stable but just showing ball park figures.
Please keep this in your mind when reading these results.

Under about 10% of working set memory pressure, the performance was
dropped to about 0.57% of no-pressure one, when the normal swap is used
(1-1).  Note that ~10% working set pressure is already extreme, at least
on this test setup.  No one would desire system setups that can degrade
performance to 0.57% of the best case.

By turning zswap on (1-2), the performance was improved about 4x,
resulting in about 2.35% of no-pressure one.  Because of the
incompressible pages in the third memory region, a significant amount of
(non-zswap) swap I/O operations were made, though.

By applying this patch (1-3), about 56% performance improvement was
made, resulting in about 3.67% of no-pressure one.  Reduced pswpin of
1-3 compared to 1-2 let us see where this improvement came from.

Related Works
-------------

This is not an entirely new attempt.  Nhat Pham and Takero Funaki tried
very similar approaches in October 2023[2] and April 2024[3],
respectively.  The two approaches didn't get merged mainly due to the
metadata overhead concern.  I described why I think that shouldn't be a
problem for this change, which is automatically disabled when writeback
is disabled, at the beginning of this changelog.

This patch is not particularly different from those, and actually built
upon those.  I wrote this from scratch again, though.  Hence adding
Suggested-by tags for them.  Actually Nhat first suggested this to me
offlist.

[1] https://github.com/sjp38/eval_zswap/blob/master/run.sh
[2] https://lore.kernel.org/20231017003519.1426574-3-nphamcs@gmail.com
[3] https://lore.kernel.org/20240706022523.1104080-6-flintglass@gmail.com

Suggested-by: Nhat Pham <nphamcs@gmail.com>
Suggested-by: Takero Funaki <flintglass@gmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from RFC v2
(https://lore.kernel.org/20250805002954.1496-1-sj@kernel.org)
- Fix race conditions at decompressed pages identification.
- Remove the parameter and make saving as-is the default behavior.
- Open-code main changes.
- Clarify there is no memory management changes on the cover letter.
- Remove 20% pressure case from test results, since it is arguably too
  extreme and only adds confusion.
- Drop RFC tag.

Changes from RFC v1
(https://lore.kernel.org/20250730234059.4603-1-sj@kernel.org)
- Consider PAGE_SIZE compression successes as failures.
- Use zpool for storing incompressible pages.
- Test with zswap shrinker enabled.
- Wordsmith changelog and comments.
- Add documentation of save_incompressible_pages parameter.

 mm/zswap.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 3c0fd8a13718..2db2da130ec4 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -976,8 +976,25 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
 	 */
 	comp_ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
 	dlen = acomp_ctx->req->dlen;
-	if (comp_ret)
-		goto unlock;
+
+	/*
+	 * If a page cannot be compressed into a size smaller than PAGE_SIZE,
+	 * save the content as is without a compression, to keep the LRU order
+	 * of writebacks.  If writeback is disabled, reject the page since it
+	 * only adds metadata overhead.  swap_writeout() will put the page back
+	 * to the active LRU list in the case.
+	 */
+	if (comp_ret || dlen >= PAGE_SIZE) {
+		if (mem_cgroup_zswap_writeback_enabled(
+					folio_memcg(page_folio(page)))) {
+			comp_ret = 0;
+			dlen = PAGE_SIZE;
+			memcpy_from_page(dst, page, 0, dlen);
+		} else {
+			comp_ret = comp_ret ? : -EINVAL;
+			goto unlock;
+		}
+	}
 
 	zpool = pool->zpool;
 	gfp = GFP_NOWAIT | __GFP_NORETRY | __GFP_HIGHMEM | __GFP_MOVABLE;
@@ -1012,6 +1029,14 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 	acomp_ctx = acomp_ctx_get_cpu_lock(entry->pool);
 	obj = zpool_obj_read_begin(zpool, entry->handle, acomp_ctx->buffer);
 
+	/* zswap entries of PAGE_SIZE are not compressed. */
+	if (entry->length == PAGE_SIZE) {
+		memcpy_to_folio(folio, 0, obj, entry->length);
+		zpool_obj_read_end(zpool, entry->handle, obj);
+		acomp_ctx_put_unlock(acomp_ctx);
+		return true;
+	}
+
 	/*
 	 * zpool_obj_read_begin() might return a kmap address of highmem when
 	 * acomp_ctx->buffer is not used.  However, sg_init_one() does not

base-commit: 2ec534125ae474292175ae198483c545eac2161d
-- 
2.39.5

