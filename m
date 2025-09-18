Return-Path: <linux-kernel+bounces-790464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EBDB3A76F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021E3565AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9C7343D98;
	Thu, 28 Aug 2025 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvZR6zua"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF00343D63;
	Thu, 28 Aug 2025 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401179; cv=none; b=GP0LGUVVrH650kSjEGFG9/uJbGnXTqbhj+trQdpAReO55FbD3uTBW04NFT8aep2H4maL9IYuw2hwmqG9483MftJjUkz2tmjqLCloiQeUmXVMzjQzSXe0ZLgCVQMi0aMgp1n+l/inmeDVd5dAzC8arT5a7sqpx4BEWZvUsRBndDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401179; c=relaxed/simple;
	bh=ISBNZAiFGy5WkoKys1iRyS5Q+6KEjLYzz0QUShR4E/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lQ9+D+7zQuVQtbM8fBHN5lH2GFu39D53/1oQfxtAOJ1HJ2P8T5IazBYDz4dpsxriNgQ9ki9cWGmaDWnNFv3R/3Iq0nFdDC9kvnk2tvwLucCa0F75neE3qaHeS+ePTxZLIv2HxPAjIyTube5Z1o/DP75BuFpvoCTv4T4VZoln1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvZR6zua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6147C4AF0F;
	Thu, 28 Aug 2025 17:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756401179;
	bh=ISBNZAiFGy5WkoKys1iRyS5Q+6KEjLYzz0QUShR4E/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TvZR6zuaMQ8xUu6z2O0D5OY8ClcZ9OdQxE/JwTu8UZo5KOl4F+B37gDbkDUndVJUI
	 nZOzmiHj8Xg24XUDf7zj3znl1H4BA88sorOqEhrzUQYs22TYG/9SHaG6QCGgmhED/P
	 C9f0LECcgtoKN9x8GHS7av3E7F+WzUVFA/8gxkqd+WCyiFn8YkJKrRiLqtWi22Xx5A
	 xvDpHiGmIVQipS4BHdfEjltpOzui7u3VeoDfgE49YfGKbRVfc6A0ERe6pguEMNNTq2
	 +/48WiACzXYobqVimfI28kaVCNC6xcSehzlEelH/K1twxI8yuKPQa47H9nWyrGubLt
	 hoTGCgwMfrb9g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: [PATCH v3 11/11] mm/damon: add damon_ctx->min_sz_region
Date: Thu, 28 Aug 2025 10:12:42 -0700
Message-Id: <20250828171242.59810-12-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250828171242.59810-1-sj@kernel.org>
References: <20250828171242.59810-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quanmin Yan <yanquanmin1@huawei.com>

Adopting addr_unit would make DAMON_MINREGION 'addr_unit * 4096'
bytes and cause data alignment issues[1].

Add damon_ctx->min_sz_region to change DAMON_MIN_REGION from a global
macro value to per-context variable.

[1] https://lore.kernel.org/all/527714dd-0e33-43ab-bbbd-d89670ba79e7@huawei.com

Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h        |  4 ++-
 mm/damon/core.c              | 67 ++++++++++++++++++++----------------
 mm/damon/sysfs.c             |  8 +++--
 mm/damon/tests/core-kunit.h  | 21 ++++++-----
 mm/damon/tests/vaddr-kunit.h |  2 +-
 mm/damon/vaddr.c             |  2 +-
 6 files changed, 61 insertions(+), 43 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6fa52f7495d9..ec8716292c09 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -747,6 +747,7 @@ struct damon_attrs {
  *
  * @ops:	Set of monitoring operations for given use cases.
  * @addr_unit:	Scale factor for core to ops address conversion.
+ * @min_sz_region:		Minimum region size.
  * @adaptive_targets:	Head of monitoring targets (&damon_target) list.
  * @schemes:		Head of schemes (&damos) list.
  */
@@ -789,6 +790,7 @@ struct damon_ctx {
 
 	struct damon_operations ops;
 	unsigned long addr_unit;
+	unsigned long min_sz_region;
 
 	struct list_head adaptive_targets;
 	struct list_head schemes;
@@ -877,7 +879,7 @@ static inline void damon_insert_region(struct damon_region *r,
 void damon_add_region(struct damon_region *r, struct damon_target *t);
 void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
-		unsigned int nr_ranges);
+		unsigned int nr_ranges, unsigned long min_sz_region);
 void damon_update_region_access_rate(struct damon_region *r, bool accessed,
 		struct damon_attrs *attrs);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index acea2964b9cc..7aeb3f24aae8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -201,6 +201,7 @@ static int damon_fill_regions_holes(struct damon_region *first,
  * @t:		the given target.
  * @ranges:	array of new monitoring target ranges.
  * @nr_ranges:	length of @ranges.
+ * @min_sz_region:	minimum region size.
  *
  * This function adds new regions to, or modify existing regions of a
  * monitoring target to fit in specific ranges.
@@ -208,7 +209,7 @@ static int damon_fill_regions_holes(struct damon_region *first,
  * Return: 0 if success, or negative error code otherwise.
  */
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
-		unsigned int nr_ranges)
+		unsigned int nr_ranges, unsigned long min_sz_region)
 {
 	struct damon_region *r, *next;
 	unsigned int i;
@@ -245,16 +246,16 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 			/* no region intersects with this range */
 			newr = damon_new_region(
 					ALIGN_DOWN(range->start,
-						DAMON_MIN_REGION),
-					ALIGN(range->end, DAMON_MIN_REGION));
+						min_sz_region),
+					ALIGN(range->end, min_sz_region));
 			if (!newr)
 				return -ENOMEM;
 			damon_insert_region(newr, damon_prev_region(r), r, t);
 		} else {
 			/* resize intersecting regions to fit in this range */
 			first->ar.start = ALIGN_DOWN(range->start,
-					DAMON_MIN_REGION);
-			last->ar.end = ALIGN(range->end, DAMON_MIN_REGION);
+					min_sz_region);
+			last->ar.end = ALIGN(range->end, min_sz_region);
 
 			/* fill possible holes in the range */
 			err = damon_fill_regions_holes(first, last, t);
@@ -545,6 +546,7 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.max_nr_regions = 1000;
 
 	ctx->addr_unit = 1;
+	ctx->min_sz_region = DAMON_MIN_REGION;
 
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
@@ -1127,8 +1129,8 @@ static struct damon_target *damon_nth_target(int n, struct damon_ctx *ctx)
  *
  * If @src has no region, @dst keeps current regions.
  */
-static int damon_commit_target_regions(
-		struct damon_target *dst, struct damon_target *src)
+static int damon_commit_target_regions(struct damon_target *dst,
+		struct damon_target *src, unsigned long src_min_sz_region)
 {
 	struct damon_region *src_region;
 	struct damon_addr_range *ranges;
@@ -1145,18 +1147,19 @@ static int damon_commit_target_regions(
 	i = 0;
 	damon_for_each_region(src_region, src)
 		ranges[i++] = src_region->ar;
-	err = damon_set_regions(dst, ranges, i);
+	err = damon_set_regions(dst, ranges, i, src_min_sz_region);
 	kfree(ranges);
 	return err;
 }
 
 static int damon_commit_target(
 		struct damon_target *dst, bool dst_has_pid,
-		struct damon_target *src, bool src_has_pid)
+		struct damon_target *src, bool src_has_pid,
+		unsigned long src_min_sz_region)
 {
 	int err;
 
-	err = damon_commit_target_regions(dst, src);
+	err = damon_commit_target_regions(dst, src, src_min_sz_region);
 	if (err)
 		return err;
 	if (dst_has_pid)
@@ -1178,7 +1181,8 @@ static int damon_commit_targets(
 		if (src_target) {
 			err = damon_commit_target(
 					dst_target, damon_target_has_pid(dst),
-					src_target, damon_target_has_pid(src));
+					src_target, damon_target_has_pid(src),
+					src->min_sz_region);
 			if (err)
 				return err;
 		} else {
@@ -1201,7 +1205,8 @@ static int damon_commit_targets(
 		if (!new_target)
 			return -ENOMEM;
 		err = damon_commit_target(new_target, false,
-				src_target, damon_target_has_pid(src));
+				src_target, damon_target_has_pid(src),
+				src->min_sz_region);
 		if (err) {
 			damon_destroy_target(new_target, NULL);
 			return err;
@@ -1248,6 +1253,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	}
 	dst->ops = src->ops;
 	dst->addr_unit = src->addr_unit;
+	dst->min_sz_region = src->min_sz_region;
 
 	return 0;
 }
@@ -1280,8 +1286,8 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 
 	if (ctx->attrs.min_nr_regions)
 		sz /= ctx->attrs.min_nr_regions;
-	if (sz < DAMON_MIN_REGION)
-		sz = DAMON_MIN_REGION;
+	if (sz < ctx->min_sz_region)
+		sz = ctx->min_sz_region;
 
 	return sz;
 }
@@ -1625,6 +1631,7 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
  * @t:	The target of the region.
  * @rp:	The pointer to the region.
  * @s:	The scheme to be applied.
+ * @min_sz_region:	minimum region size.
  *
  * If a quota of a scheme has exceeded in a quota charge window, the scheme's
  * action would applied to only a part of the target access pattern fulfilling
@@ -1642,7 +1649,7 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
  * Return: true if the region should be entirely skipped, false otherwise.
  */
 static bool damos_skip_charged_region(struct damon_target *t,
-		struct damon_region **rp, struct damos *s)
+		struct damon_region **rp, struct damos *s, unsigned long min_sz_region)
 {
 	struct damon_region *r = *rp;
 	struct damos_quota *quota = &s->quota;
@@ -1664,11 +1671,11 @@ static bool damos_skip_charged_region(struct damon_target *t,
 		if (quota->charge_addr_from && r->ar.start <
 				quota->charge_addr_from) {
 			sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
-					r->ar.start, DAMON_MIN_REGION);
+					r->ar.start, min_sz_region);
 			if (!sz_to_skip) {
-				if (damon_sz_region(r) <= DAMON_MIN_REGION)
+				if (damon_sz_region(r) <= min_sz_region)
 					return true;
-				sz_to_skip = DAMON_MIN_REGION;
+				sz_to_skip = min_sz_region;
 			}
 			damon_split_region_at(t, r, sz_to_skip);
 			r = damon_next_region(r);
@@ -1693,7 +1700,8 @@ static void damos_update_stat(struct damos *s,
 }
 
 static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
-		struct damon_region *r, struct damos_filter *filter)
+		struct damon_region *r, struct damos_filter *filter,
+		unsigned long min_sz_region)
 {
 	bool matched = false;
 	struct damon_target *ti;
@@ -1710,8 +1718,8 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		matched = target_idx == filter->target_idx;
 		break;
 	case DAMOS_FILTER_TYPE_ADDR:
-		start = ALIGN_DOWN(filter->addr_range.start, DAMON_MIN_REGION);
-		end = ALIGN_DOWN(filter->addr_range.end, DAMON_MIN_REGION);
+		start = ALIGN_DOWN(filter->addr_range.start, min_sz_region);
+		end = ALIGN_DOWN(filter->addr_range.end, min_sz_region);
 
 		/* inside the range */
 		if (start <= r->ar.start && r->ar.end <= end) {
@@ -1747,7 +1755,7 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 
 	s->core_filters_allowed = false;
 	damos_for_each_filter(filter, s) {
-		if (damos_filter_match(ctx, t, r, filter)) {
+		if (damos_filter_match(ctx, t, r, filter, ctx->min_sz_region)) {
 			if (filter->allow)
 				s->core_filters_allowed = true;
 			return !filter->allow;
@@ -1882,7 +1890,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	if (c->ops.apply_scheme) {
 		if (quota->esz && quota->charged_sz + sz > quota->esz) {
 			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
-					DAMON_MIN_REGION);
+					c->min_sz_region);
 			if (!sz)
 				goto update_stat;
 			damon_split_region_at(t, r, sz);
@@ -1930,7 +1938,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (quota->esz && quota->charged_sz >= quota->esz)
 			continue;
 
-		if (damos_skip_charged_region(t, &r, s))
+		if (damos_skip_charged_region(t, &r, s, c->min_sz_region))
 			continue;
 
 		if (!damos_valid_target(c, t, r, s))
@@ -2328,7 +2336,8 @@ static void damon_split_region_at(struct damon_target *t,
 }
 
 /* Split every region in the given target into 'nr_subs' regions */
-static void damon_split_regions_of(struct damon_target *t, int nr_subs)
+static void damon_split_regions_of(struct damon_target *t, int nr_subs,
+				  unsigned long min_sz_region)
 {
 	struct damon_region *r, *next;
 	unsigned long sz_region, sz_sub = 0;
@@ -2338,13 +2347,13 @@ static void damon_split_regions_of(struct damon_target *t, int nr_subs)
 		sz_region = damon_sz_region(r);
 
 		for (i = 0; i < nr_subs - 1 &&
-				sz_region > 2 * DAMON_MIN_REGION; i++) {
+				sz_region > 2 * min_sz_region; i++) {
 			/*
 			 * Randomly select size of left sub-region to be at
 			 * least 10 percent and at most 90% of original region
 			 */
 			sz_sub = ALIGN_DOWN(damon_rand(1, 10) *
-					sz_region / 10, DAMON_MIN_REGION);
+					sz_region / 10, min_sz_region);
 			/* Do not allow blank region */
 			if (sz_sub == 0 || sz_sub >= sz_region)
 				continue;
@@ -2384,7 +2393,7 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 		nr_subregions = 3;
 
 	damon_for_each_target(t, ctx)
-		damon_split_regions_of(t, nr_subregions);
+		damon_split_regions_of(t, nr_subregions, ctx->min_sz_region);
 
 	last_nr_regions = nr_regions;
 }
@@ -2773,7 +2782,7 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 
 	addr_range.start = *start;
 	addr_range.end = *end;
-	return damon_set_regions(t, &addr_range, 1);
+	return damon_set_regions(t, &addr_range, 1, DAMON_MIN_REGION);
 }
 
 /*
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 98bf15d403b2..0ed404c89f80 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1329,7 +1329,8 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 }
 
 static int damon_sysfs_set_regions(struct damon_target *t,
-		struct damon_sysfs_regions *sysfs_regions)
+		struct damon_sysfs_regions *sysfs_regions,
+		unsigned long min_sz_region)
 {
 	struct damon_addr_range *ranges = kmalloc_array(sysfs_regions->nr,
 			sizeof(*ranges), GFP_KERNEL | __GFP_NOWARN);
@@ -1351,7 +1352,7 @@ static int damon_sysfs_set_regions(struct damon_target *t,
 		if (ranges[i - 1].end > ranges[i].start)
 			goto out;
 	}
-	err = damon_set_regions(t, ranges, sysfs_regions->nr);
+	err = damon_set_regions(t, ranges, sysfs_regions->nr, min_sz_region);
 out:
 	kfree(ranges);
 	return err;
@@ -1372,7 +1373,7 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 			/* caller will destroy targets */
 			return -EINVAL;
 	}
-	return damon_sysfs_set_regions(t, sys_target->regions);
+	return damon_sysfs_set_regions(t, sys_target->regions, ctx->min_sz_region);
 }
 
 static int damon_sysfs_add_targets(struct damon_ctx *ctx,
@@ -1430,6 +1431,7 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	if (err)
 		return err;
 	ctx->addr_unit = sys_ctx->addr_unit;
+	ctx->min_sz_region = max(DAMON_MIN_REGION / sys_ctx->addr_unit, 1);
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)
 		return err;
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 5f5dc9db2e90..51369e35298b 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -230,14 +230,14 @@ static void damon_test_split_regions_of(struct kunit *test)
 	t = damon_new_target();
 	r = damon_new_region(0, 22);
 	damon_add_region(r, t);
-	damon_split_regions_of(t, 2);
+	damon_split_regions_of(t, 2, DAMON_MIN_REGION);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 2u);
 	damon_free_target(t);
 
 	t = damon_new_target();
 	r = damon_new_region(0, 220);
 	damon_add_region(r, t);
-	damon_split_regions_of(t, 4);
+	damon_split_regions_of(t, 4, DAMON_MIN_REGION);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);
 	damon_free_target(t);
 	damon_destroy_ctx(c);
@@ -303,7 +303,7 @@ static void damon_test_set_regions(struct kunit *test)
 
 	damon_add_region(r1, t);
 	damon_add_region(r2, t);
-	damon_set_regions(t, &range, 1);
+	damon_set_regions(t, &range, 1, DAMON_MIN_REGION);
 
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 3);
 	damon_for_each_region(r, t) {
@@ -450,25 +450,29 @@ static void damos_test_filter_out(struct kunit *test)
 	damon_add_region(r, t);
 
 	/* region in the range */
-	KUNIT_EXPECT_TRUE(test, damos_filter_match(NULL, t, r, f));
+	KUNIT_EXPECT_TRUE(test,
+			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region before the range */
 	r->ar.start = DAMON_MIN_REGION * 1;
 	r->ar.end = DAMON_MIN_REGION * 2;
-	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f));
+	KUNIT_EXPECT_FALSE(test,
+			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region after the range */
 	r->ar.start = DAMON_MIN_REGION * 6;
 	r->ar.end = DAMON_MIN_REGION * 8;
-	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f));
+	KUNIT_EXPECT_FALSE(test,
+			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1);
 
 	/* region started before the range */
 	r->ar.start = DAMON_MIN_REGION * 1;
 	r->ar.end = DAMON_MIN_REGION * 4;
-	KUNIT_EXPECT_FALSE(test, damos_filter_match(NULL, t, r, f));
+	KUNIT_EXPECT_FALSE(test,
+			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 1);
 	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 2);
@@ -481,7 +485,8 @@ static void damos_test_filter_out(struct kunit *test)
 	/* region started in the range */
 	r->ar.start = DAMON_MIN_REGION * 2;
 	r->ar.end = DAMON_MIN_REGION * 8;
-	KUNIT_EXPECT_TRUE(test, damos_filter_match(NULL, t, r, f));
+	KUNIT_EXPECT_TRUE(test,
+			damos_filter_match(NULL, t, r, f, DAMON_MIN_REGION));
 	/* filter should have split the region */
 	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 2);
 	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 6);
diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index d2b37ccf2cc0..fce38dd53cf8 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -141,7 +141,7 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 		damon_add_region(r, t);
 	}
 
-	damon_set_regions(t, three_regions, 3);
+	damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION);
 
 	for (i = 0; i < nr_expected / 2; i++) {
 		r = __nth_region_of(t, i);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 66ef9869eafe..8c048f9b129e 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -299,7 +299,7 @@ static void damon_va_update(struct damon_ctx *ctx)
 	damon_for_each_target(t, ctx) {
 		if (damon_va_three_regions(t, three_regions))
 			continue;
-		damon_set_regions(t, three_regions, 3);
+		damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION);
 	}
 }
 
-- 
2.39.5

