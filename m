Return-Path: <linux-kernel+bounces-654177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8780FABC4D7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 18:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E973317BB51
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 16:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090AC2857CD;
	Mon, 19 May 2025 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVe2cC2L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB552749F5;
	Mon, 19 May 2025 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747673064; cv=none; b=UeWdjDzb2uXPtC98Dj1gPCZPcimLus5afTwpUgTF/lZ/GcqGPWGs+xV9DRqLPAZsVXgWhAvpjSV15vLQar+T8loXhaBruixCChXW/OeF+oK/RPt+EtfomBlAUL4Dv8QyKZz+rZKAV9rGXx0FEhvm6FijMJwgx8C/wk63u1bIZa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747673064; c=relaxed/simple;
	bh=/8/4pFjPPVhMHFQr9b7mNlWI254qxXmUWO34UkwncD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pfb19L6gb6pVfhxr+lzxOpfGb9tY7TOo8R9mts5gJ/EvuiqRXXRlj1EW8B5n9KeFX/TCiHemluICc1iUhOKjjK/DH36DWOjQBqTp45OdNAap8VIxaEM4I0ejjlXfcYXIorYTCLaax0zSjKeUre5rLnRuzI17Cota/pO2ztIl5oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVe2cC2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A74C4CEF0;
	Mon, 19 May 2025 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747673063;
	bh=/8/4pFjPPVhMHFQr9b7mNlWI254qxXmUWO34UkwncD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVe2cC2LWrFButcYacjM61U3B0tTyqTFHXvQXBW9j7iWzRkPUb2mn+annjBmoQzxH
	 kAbDowbPqUb5KzwvuonOxVMl0NX/vbim+YekttfSP4u7lw3dod7RaZCjwS1Lrtn29b
	 H4ojoYD1FA11sIDss8VMhsr76El3O98DAJo84Apc4biyP1Fwldctw6pQNMfAr5eyPC
	 keAyT3fR0/egdROn5n0hjeH0dv0LiWZNu048H8tgD65W2ilCqHG5M7g4NxBxZJDi+J
	 +E2GozUxhJwpnXxUVIScww6jCBeOBsJGXI+XwDPfEDhQZwoXuH/iv+2YiTXyWVXNQy
	 nQTelKv1FRUOw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/3] mm/damon/stat: calculate and expose idle time percentiles
Date: Mon, 19 May 2025 09:44:15 -0700
Message-Id: <20250519164415.43935-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519164415.43935-1-sj@kernel.org>
References: <20250519164415.43935-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Knowing how much memory are how cold can be useful for understanding
coldness and utilization efficiency of memory.  The raw form of DAMON's
monitoring results has the information.  Convert the raw results into
the per-byte idle time distributions and expose it as percentiles metric
to users, as a read-only DAMON_STAT parameter.

In detail, the metrics are calcualted as following.  First, DAMON's
per-region access frequency and age information is converted into
per-byte idle time.  If access frequency of a region is higher than
zero, every byte of the region has zero idle time.  If access frequency
of a region is zero, every byte of the region has idle time as the age
of the region.  Then the logic sorts the per-byte idle times and
provides the value at 0/100, 1/100, ..., 99/100 and 100/100 location of
the sorted array.

The metric can be easily aggregated and compared on large scale
production systems.  For example, if an average of 75-th percentile idle
time  of machines that collected on similar time is two minutes, it
means the system's 25 percent memory is not accessed at all for two
minutes or more in average.  If a workload considers two minutes as unit
work time, we can conclude its working set size is only 75 percent of
the memory.  If the system utilizes proactive reclamation and it
supports coldness-based thresholds like DAMON_RECLAIM, te idle time
percentiles can be used to find more safe or aggressive coldness
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

