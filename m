Return-Path: <linux-kernel+bounces-740993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C2FB0DE85
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4395849E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905B12DF3CF;
	Tue, 22 Jul 2025 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kSPNKgWv"
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09C028C5D5
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193893; cv=none; b=C+uFFR/nfpJrhrOz/czXRH3vitde0H1fv2n+m1it/VFx4xe17b0tybmHg0qpps9UZv6bYGdIDSPhdQSiug4os8YpnMyxlQtyRNxa/PxE/os+K+c9OxOrsVc3YUwKat8rvQEd8j2YoQTvgBXkhsVwE/f8DaesR+yX8VfgY26pcQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193893; c=relaxed/simple;
	bh=5dNQ6R20gA18sSDnal2PdhhzzD3NLhbrHgMrNWEtiPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HgfROO0b2Ak9hm1OG7oMZvZBnYt7lwxQnumTHnZk8+aJElhmFFEqax1F9rDg/vz9MQ0YmmIDPOIl39h+ILvWHYbL6auo4HHHPvNfkZ1EMW61P20DCty8DQUKfvZhyeJZoYxB+eBSqPIwINEYvMIE+iaorghTXsX/0/2SwOourqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kSPNKgWv; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1753193892; x=1784729892;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5dNQ6R20gA18sSDnal2PdhhzzD3NLhbrHgMrNWEtiPg=;
  b=kSPNKgWvjvg3y4Cw4eU6z2XLUjR8aLS/G43ZVfwOznA8QhwuqePD1EcW
   X14QUiuUOtYn7AXvuhGqnBznZjkzQcKy3rznNwzb+z5cI9tEI9W7DmWko
   BTX8S6MGilRn8Rm6QF8VaKVApwtt+qOPVxnlJU4CrTimP9vuQf1HvHl3G
   Ria1Bent1evFMyX5Ss84nDjZJsAUdMSXHFXd02o3HB2r56UdND+H0DTTy
   y4stnAXCVNmisSTQ6kAQeY3gTOZCftQG8eJPxWaThYhhZ3tlrSMFlb7sI
   xh9htLkNQIOYP01T0lGYUbowVlWxQmPLYTWPgBR3U9uPDe/MhQTy7Y6XJ
   A==;
X-CSE-ConnectionGUID: 2klcz6qVSxicov6wOhy1WA==
X-CSE-MsgGUID: SlItDammRtKcpXrqZAXLNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="210300647"
X-IronPort-AV: E=Sophos;i="6.16,331,1744038000"; 
   d="scan'208";a="210300647"
Received: from unknown (HELO az2nlsmgr2.o.css.fujitsu.com) ([51.138.80.169])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:17:01 +0900
Received: from az2nlsmgm2.o.css.fujitsu.com (unknown [10.150.26.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr2.o.css.fujitsu.com (Postfix) with ESMTPS id 235A6154C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:17:01 +0000 (UTC)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id 88F481C0019A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.167.135.81])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 2C2F11A0071;
	Tue, 22 Jul 2025 22:16:51 +0800 (CST)
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
	Li Zhijian <lizhijian@fujitsu.com>,
	Ben Segall <bsegall@google.com>
Subject: [PATCH RFC v3] mm: memory-tiering: Fix PGPROMOTE_CANDIDATE counting
Date: Tue, 22 Jul 2025 22:16:50 +0800
Message-ID: <20250722141650.1821721-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Zhijian <lizhijian@fujitsu.com>

===
Changes since v2:
  1. According to Huang's suggestion, add a new stat to not count these
  pages into PGPROMOTE_CANDIDATE, to avoid changing the rate limit
  mechanism.
===

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

To solve this confusing statistics, introduce this
PGPROMOTE_CANDIDATE_NOLIMIT to count the missed promotion pages.  And
also, not counting these pages into PGPROMOTE_CANDIDATE is to avoid
changing the existing algorithm or performance of the promotion rate
limit.

Perhaps PGPROMOTE_CANDIDATE_NOLIMIT is not well named, please comment if
you have a better idea.


Cc: Huang Ying <ying.huang@linux.alibaba.com>
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
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Ruan Shiyang <ruansy.fnst@fujitsu.com>
---
 include/linux/mmzone.h | 2 ++
 kernel/sched/fair.c    | 6 ++++--
 mm/vmstat.c            | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 283913d42d7b..6216e2eecf3b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -231,6 +231,8 @@ enum node_stat_item {
 #ifdef CONFIG_NUMA_BALANCING
 	PGPROMOTE_SUCCESS,	/* promote successfully */
 	PGPROMOTE_CANDIDATE,	/* candidate pages to promote */
+	PGPROMOTE_CANDIDATE_NOLIMIT,	/* candidate pages without considering
+					 * hot threshold */
 #endif
 	/* PGDEMOTE_*: pages demoted */
 	PGDEMOTE_KSWAPD,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a14da5396fb..12dac3519c49 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1940,11 +1940,14 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 		struct pglist_data *pgdat;
 		unsigned long rate_limit;
 		unsigned int latency, th, def_th;
+		long nr = folio_nr_pages(folio);
 
 		pgdat = NODE_DATA(dst_nid);
 		if (pgdat_free_space_enough(pgdat)) {
 			/* workload changed, reset hot threshold */
 			pgdat->nbp_threshold = 0;
+			mod_node_page_state(pgdat, PGPROMOTE_CANDIDATE_NOLIMIT,
+					    nr);
 			return true;
 		}
 
@@ -1958,8 +1961,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 		if (latency >= th)
 			return false;
 
-		return !numa_promotion_rate_limit(pgdat, rate_limit,
-						  folio_nr_pages(folio));
+		return !numa_promotion_rate_limit(pgdat, rate_limit, nr);
 	}
 
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index a78d70ddeacd..ca44a2dd5497 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1272,6 +1272,7 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_NUMA_BALANCING
 	"pgpromote_success",
 	"pgpromote_candidate",
+	"pgpromote_candidate_nolimit",
 #endif
 	"pgdemote_kswapd",
 	"pgdemote_direct",
-- 
2.43.0


