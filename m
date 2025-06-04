Return-Path: <linux-kernel+bounces-673665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0270ACE45D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 20:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B997A17330D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 18:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE8A20D4F2;
	Wed,  4 Jun 2025 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG5ZZg5y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8445020B207;
	Wed,  4 Jun 2025 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749061895; cv=none; b=noJ/EGS13RtOyq3J2aoOlzroGDpv5Kvic4RHmP5qHJZB5m63VfybGSFVfnnBMMznG8LCDsmj9xDb9Ea7dLXw7EcCSi6Wd1CjpaJ315NNerXvoRJ43AnoV+AJ2nP5r0jwsnRJi/lSEjpeThn0Fypua1mxLVrdgBByRCxyk6r9LgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749061895; c=relaxed/simple;
	bh=99xhNIYjrRRHYJ4jwFEOfM7WQzxpqK4uF5YCwTKBiUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=evMOWWUCFpVkuPM12VxnihB59q6FRfMy6zCAHFXjlyPEHsCL5vZLvYX6ZGVqfEbu6YNL3LSmWkNIP7XVmtBkXle3vsclOfvWfhGMP+kXFSiwL5atQ71SZ2V908cLBg5fUWWgnfVacW+NM9qD80PVsOGyxyiMWYN08NOS+thfut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG5ZZg5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBEEC4CEE4;
	Wed,  4 Jun 2025 18:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749061894;
	bh=99xhNIYjrRRHYJ4jwFEOfM7WQzxpqK4uF5YCwTKBiUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HG5ZZg5yjYnEaaix5srRYEyzL36MLTuD9nbxi2c+uLFjCBf7zFxzUa/ftmegZ+/YC
	 bbIGjqGWh2/SoYrwiwNuF8/SXHWzZbt51ZGSQT9F467CDdC8MbWRR3DWgbUzttnS16
	 6P40rJuqK+3xLyv3dBc2GzQFMxsL2A0T/9gKN2snqOl4whMhBt+AiD8ldGG8G55t/O
	 Rrdnw/hS46mBMDF0SxmdtDGa6LiZQzctEUkWO3F3QENZ1ntWq4ztU7pZmBqbgxu8zc
	 iApOW0H4mGuPfYniatP5oQh+lltr1JoydkgptStbQsTKjIpctqAFruQNvi9ofqNykG
	 JJQUC3RFJIgqw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 3/4] mm/damon/stat: calculate and expose idle time percentiles
Date: Wed,  4 Jun 2025 11:31:26 -0700
Message-Id: <20250604183127.13968-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604183127.13968-1-sj@kernel.org>
References: <20250604183127.13968-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Knowing how much memory is how cold can be useful for understanding
coldness and utilization efficiency of memory.  The raw form of DAMON's
monitoring results has the information.  Convert the raw results into
the per-byte idle time distributions and expose it as percentiles metric
to users, as a read-only DAMON_STAT parameter.

In detail, the metrics are calculated as follows.  First, DAMON's
per-region access frequency and age information is converted into
per-byte idle time.  If access frequency of a region is higher than
zero, every byte of the region has zero idle time.  If the access
frequency of a region is zero, every byte of the region has idle time as
the age of the region.  Then the logic sorts the per-byte idle times and
provides the value at 0/100, 1/100, ..., 99/100 and 100/100 location of
the sorted array.

The metric can be easily aggregated and compared on large scale
production systems.  For example, if an average of 75-th percentile idle
time  of machines that collected on similar time is two minutes, it
means the system's 25 percent memory is not accessed at all for two
minutes or more on average.  If a workload considers two minutes as unit
work time, we can conclude its working set size is only 75 percent of
the memory.  If the system utilizes proactive reclamation and it
supports coldness-based thresholds like DAMON_RECLAIM, the idle time
percentiles can be used to find a more safe or aggressive coldness
threshold for aimed memory saving.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index f9ae44db265b..7ef13ea22221 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -33,6 +33,11 @@ module_param(estimated_memory_bandwidth, ulong, 0400);
 MODULE_PARM_DESC(estimated_memory_bandwidth,
 		"Estimated memory bandwidth usage in bytes per second");
 
+static unsigned long memory_idle_ms_percentiles[101] __read_mostly = {0,};
+module_param_array(memory_idle_ms_percentiles, ulong, NULL, 0400);
+MODULE_PARM_DESC(memory_idle_ms_percentiles,
+		"Memory idle time percentiles in milliseconds");
+
 static struct damon_ctx *damon_stat_context;
 
 static void damon_stat_set_estimated_memory_bandwidth(struct damon_ctx *c)
@@ -50,6 +55,72 @@ static void damon_stat_set_estimated_memory_bandwidth(struct damon_ctx *c)
 		MSEC_PER_SEC / c->attrs.aggr_interval;
 }
 
+static unsigned int damon_stat_idletime(const struct damon_region *r)
+{
+	if (r->nr_accesses)
+		return 0;
+	return r->age + 1;
+}
+
+static int damon_stat_cmp_regions(const void *a, const void *b)
+{
+	const struct damon_region *ra = *(const struct damon_region **)a;
+	const struct damon_region *rb = *(const struct damon_region **)b;
+
+	return damon_stat_idletime(ra) - damon_stat_idletime(rb);
+}
+
+static int damon_stat_sort_regions(struct damon_ctx *c,
+		struct damon_region ***sorted_ptr, int *nr_regions_ptr,
+		unsigned long *total_sz_ptr)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	struct damon_region **region_pointers;
+	unsigned int nr_regions = 0;
+	unsigned long total_sz = 0;
+
+	damon_for_each_target(t, c) {
+		/* there is only one target */
+		region_pointers = kmalloc_array(damon_nr_regions(t),
+				sizeof(*region_pointers), GFP_KERNEL);
+		if (!region_pointers)
+			return -ENOMEM;
+		damon_for_each_region(r, t) {
+			region_pointers[nr_regions++] = r;
+			total_sz += r->ar.end - r->ar.start;
+		}
+	}
+	sort(region_pointers, nr_regions, sizeof(*region_pointers),
+			damon_stat_cmp_regions, NULL);
+	*sorted_ptr = region_pointers;
+	*nr_regions_ptr = nr_regions;
+	*total_sz_ptr = total_sz;
+	return 0;
+}
+
+static void damon_stat_set_idletime_percentiles(struct damon_ctx *c)
+{
+	struct damon_region **sorted_regions, *region;
+	int nr_regions;
+	unsigned long total_sz, accounted_bytes = 0;
+	int err, i, next_percentile = 0;
+
+	err = damon_stat_sort_regions(c, &sorted_regions, &nr_regions,
+			&total_sz);
+	if (err)
+		return;
+	for (i = 0; i < nr_regions; i++) {
+		region = sorted_regions[i];
+		accounted_bytes += region->ar.end - region->ar.start;
+		while (next_percentile <= accounted_bytes * 100 / total_sz)
+			memory_idle_ms_percentiles[next_percentile++] =
+				damon_stat_idletime(region) *
+				c->attrs.aggr_interval / USEC_PER_MSEC;
+	}
+	kfree(sorted_regions);
+}
+
 static int damon_stat_after_aggregation(struct damon_ctx *c)
 {
 	static unsigned long last_refresh_jiffies;
@@ -61,6 +132,7 @@ static int damon_stat_after_aggregation(struct damon_ctx *c)
 	last_refresh_jiffies = jiffies;
 
 	damon_stat_set_estimated_memory_bandwidth(c);
+	damon_stat_set_idletime_percentiles(c);
 	return 0;
 }
 
-- 
2.39.5

