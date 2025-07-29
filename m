Return-Path: <linux-kernel+bounces-748869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D3AB146F8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 05:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D811F3B806C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9152522333D;
	Tue, 29 Jul 2025 03:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Uy8Vc7dy"
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4026D4409
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753761072; cv=none; b=CjuOYp1PpjMKF5VRYd2YDGATWBQCBOD2IEasdj+qssyPBW9fpsYYfKQYUrjrBwVFPrRDUaEpy4ZYTtDrQjGw9YAHf2kn/x0GuH+v3WdHWazpl1j+Cdf/VDef2kkrTnVzy2n2FRD3L0FraIpYfRN4lr+nkhmDbtskfOIKjqvxhFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753761072; c=relaxed/simple;
	bh=t4dePJYQNi95GjMpjzF3niKU/R6TTc6eXMIeT7hJrSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KoiNXX+viaUfBOzoo9YQJ9ZXQgE9AdH95K1xILc+XKEfQ5wa8MmfsXIONwLW6S5OYoxnvlkSNJKK2rlqSY9V/eswL9PU7hv0ZUXCocaaEmAQ4SCj6JfsrkpJqE5cn4rwVrilHQi8cfwwp75V+A3SS5+GtaDw/PjJ8+Vgbj3pXm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Uy8Vc7dy; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1753761070; x=1785297070;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t4dePJYQNi95GjMpjzF3niKU/R6TTc6eXMIeT7hJrSE=;
  b=Uy8Vc7dyMbkEj3kMjxEYq7VjRgSSyCD0Xz1h8PGWJD/7/3Dij566vYuu
   4JJkRBi4FRNrckqDGDdjVKoJKbPUKTG5s/0/O8k3s3AOmPEyS4XPJbNs8
   pngisQEBOMpuIyW8o+t5LFKCNpaKU4cq0oBrD02jSWZEkJJvNioUbKkiG
   6MKb1RZaFzCVPV6yfR5QO6FQ4yYPK0Q8Hb5GuEtC/RfX3eJj0yBMKiSq9
   TDkF2f8VqFa1KeEC+zLn+UZrMZRLYQ8mZeOHjGXK1d7MYhzUfxT7kIYBS
   xALAwJd6vWkoGskeEbbbWYPSWidmUhcEsbhsHwLq4RsD5K3MyR/dY+YRD
   g==;
X-CSE-ConnectionGUID: VhUJe4qXT+Gf04VxUugigQ==
X-CSE-MsgGUID: WJmJk9GfTqS5dIId4qtpLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="195134840"
X-IronPort-AV: E=Sophos;i="6.16,348,1744038000"; 
   d="scan'208";a="195134840"
Received: from unknown (HELO az2nlsmgr2.o.css.fujitsu.com) ([51.138.80.169])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 12:51:08 +0900
Received: from az2nlsmgm1.o.css.fujitsu.com (unknown [10.150.26.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr2.o.css.fujitsu.com (Postfix) with ESMTPS id 5E0361410
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:51:08 +0000 (UTC)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id C174AC0384E
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 03:51:07 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.167.135.81])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 99DC51A0071;
	Tue, 29 Jul 2025 11:51:02 +0800 (CST)
From: Ruan Shiyang <ruansy.fnst@fujitsu.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	lkp@intel.com,
	ying.huang@linux.alibaba.com,
	akpm@linux-foundation.org,
	y-goto@fujitsu.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	mgorman@suse.de,
	vschneid@redhat.com,
	Ben Segall <bsegall@google.com>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v1] mm: memory-tiering: Fix PGPROMOTE_CANDIDATE counting
Date: Tue, 29 Jul 2025 11:51:01 +0800
Message-ID: <20250729035101.1601407-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Goto-san reported confusing pgpromote statistics where the
pgpromote_success count significantly exceeded pgpromote_candidate.

On a system with three nodes (nodes 0-1: DRAM 4GB, node 2: NVDIMM 4GB):
 # Enable demotion only
 echo 1 > /sys/kernel/mm/numa/demotion_enabled
 numactl -m 0-1 memhog -r200 3500M >/dev/null &
 pid=$!
 sleep 2
 numactl memhog -r100 2500M >/dev/null &
 sleep 10
 kill -9 $pid # terminate the 1st memhog
 # Enable promotion
 echo 2 > /proc/sys/kernel/numa_balancing

After a few seconds, we observeed `pgpromote_candidate < pgpromote_success`
$ grep -e pgpromote /proc/vmstat
pgpromote_success 2579
pgpromote_candidate 0

In this scenario, after terminating the first memhog, the conditions for
pgdat_free_space_enough() are quickly met, and triggers promotion.
However, these migrated pages are only counted for in PGPROMOTE_SUCCESS,
not in PGPROMOTE_CANDIDATE.

To solve this confusing statistics, introduce this PGPROMOTE_CANDIDATE_NRL
to count the missed promotion pages.  And also, not counting these pages
into PGPROMOTE_CANDIDATE is to avoid changing the existing algorithm or
performance of the promotion rate limit.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Reported-by: Yasunori Gotou (Fujitsu) <y-goto@fujitsu.com>
Suggested-by: Huang Ying <ying.huang@linux.alibaba.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Ruan Shiyang <ruansy.fnst@fujitsu.com>
---
Changes since RFC v3:
  1. change the naming of new added stat to PGPROMOTE_CANDIDATE_NRL.
  2. improve the description of the two stats.
---
 include/linux/mmzone.h | 16 +++++++++++++++-
 kernel/sched/fair.c    |  5 +++--
 mm/vmstat.c            |  1 +
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 283913d42d7b..4345996a7d5a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -230,7 +230,21 @@ enum node_stat_item {
 #endif
 #ifdef CONFIG_NUMA_BALANCING
 	PGPROMOTE_SUCCESS,	/* promote successfully */
-	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
+	/**
+	 * Candidate pages for promotion based on hint fault latency.  This
+	 * counter is used to control the promotion rate and adjust the hot
+	 * threshold.
+	 */
+	PGPROMOTE_CANDIDATE,
+	/**
+	 * Not rate-limited (NRL) candidate pages for those can be promoted
+	 * without considering hot threshold because of enough free pages in
+	 * fast-tier node.  These promotions bypass the regular hotness checks
+	 * and do NOT influence the promotion rate-limiter or
+	 * threshold-adjustment logic.
+	 * This is for statistics/monitoring purposes.
+	 */
+	PGPROMOTE_CANDIDATE_NRL,
 #endif
 	/* PGDEMOTE_*: pages demoted */
 	PGDEMOTE_KSWAPD,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a14da5396fb..4022c9c1f346 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1940,11 +1940,13 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 		struct pglist_data *pgdat;
 		unsigned long rate_limit;
 		unsigned int latency, th, def_th;
+		long nr = folio_nr_pages(folio);
 
 		pgdat = NODE_DATA(dst_nid);
 		if (pgdat_free_space_enough(pgdat)) {
 			/* workload changed, reset hot threshold */
 			pgdat->nbp_threshold = 0;
+			mod_node_page_state(pgdat, PGPROMOTE_CANDIDATE_NRL, nr);
 			return true;
 		}
 
@@ -1958,8 +1960,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 		if (latency >= th)
 			return false;
 
-		return !numa_promotion_rate_limit(pgdat, rate_limit,
-						  folio_nr_pages(folio));
+		return !numa_promotion_rate_limit(pgdat, rate_limit, nr);
 	}
 
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index a78d70ddeacd..bb0d2b330dd5 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1272,6 +1272,7 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_NUMA_BALANCING
 	"pgpromote_success",
 	"pgpromote_candidate",
+	"pgpromote_candidate_nrl",
 #endif
 	"pgdemote_kswapd",
 	"pgdemote_direct",
-- 
2.43.0


