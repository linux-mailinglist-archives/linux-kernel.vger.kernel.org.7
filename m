Return-Path: <linux-kernel+bounces-882429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC85FC2A73A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BB93A9CD4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB642C2375;
	Mon,  3 Nov 2025 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="goHUFCmT"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFA62C21FE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156424; cv=none; b=Z5Qqdmdj5gY7Hm75PlheJAQ+MWu8fM7rjrlovUo56/JigIFQgZzcqBKgsi5B/hVDwXYfyy0f6/GPp1lp/Z0OIMhjAs7cGebSCjsnEP19wrlrhQAA8LYLoWNYIpXwrXSrJb6bKsLnX/n1qHV2hA6/mMSjs7Xk6AVJCE6EthLXIfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156424; c=relaxed/simple;
	bh=OmLwWXxI7QJzZiWhcnz2SV5WgtWUgdvsnEL6HRwukQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TC6OW5vrHjMr7vZlFLlr+ShJUGpY9E+QP5B/+iKrzhmLMeG3a0fQ4NdCTJBg6BLFuVaHjF0SE41ZEl1On60PJjCf8BMyN+N8SPdOajrR9/ealB/eCHwwH1fDeWFQUeTVYRAsvisTnDOaGyJdzIg4pdrV8qTC0NfZgyYOtI98Too=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=goHUFCmT; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso2777165a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 23:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762156422; x=1762761222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/3QOrXfaRRSLiQ4GSPcpWfsbztlf+4SFaNdg8ef6Oc=;
        b=goHUFCmT9TIem6fW5MbBAL4jeNK4tqdC3hrR3vlJaa4fl7PF2Z28m0hXfK99mo/Liz
         Ca8NtMagcfru49Vnu5p1v0rJtsfFt9anp0yDukC3a5aoHPFaggtkOGqC4XI+k/bVukuw
         O4hJ+/CLpu32tOEPYOaQbVYTEMalCduYk9l5EXIcrf1LapGDyBHJLn9Pql1v60LOO/yX
         hcBnlDrYYg33aOHowgJLbaZiuhl2VZBtVYfAxhCD/5masIVBMu1AD8EvbEClbpeEoxgZ
         nU89ROlE/XOdnKiCSYODkfmEFLGnApxnGh5MEpEobp1mooeF1nVln001+nRq/pVTVbrL
         T7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762156422; x=1762761222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/3QOrXfaRRSLiQ4GSPcpWfsbztlf+4SFaNdg8ef6Oc=;
        b=hc0kqXOVbfLWEG1TP4aV123rdxNC4b2XcLdIS/i7u/H+ZQXzSCDiz2sipErbUtn4j5
         h0QYbCy0OT9lZA8IE9AuUvof7ialqPxqjdg1RnK2caTUVVFT9FVrVJbxkYNQw/3FjwUF
         Bi+aCSpuYCekZaqL6/V2G2HWJz+V1PsX4kx+9H0IGY6O5nvx1+vSFkRcLTdMCr8tuzCw
         NL773OhfLjVdyfzTWyu2GSt8Qdc8LSq4ESqxM/SG9PoYYrv5TuvTkDaelNnrdQJH4reV
         Ln4+eMD9eu5ooWVwemKjfkHxiC6wy3qX4Wt9m+a/A1tIDtU0c2g1w6M6teV2/H4Zo9m1
         ODgA==
X-Forwarded-Encrypted: i=1; AJvYcCUffg5gCnuq/StqylqhfK48TDQRxKcJ9RPh2pN2E9pNjbQK0/REWd4+8EGohLUyc++KkPXnq05GdQ6hwr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt2Gke9S8d+lCsLjh6rk6e5vdWVqJ+rQUbAlC5XA2aBYzBpkuL
	RAXTC30HrC8JVFt4iZqjbDM4Z4ZMUxpJBZSPbB9bPgbNPa2PQLcmVxDPMo6bfhWiGtQ=
X-Gm-Gg: ASbGncvbGYan0ScVum0yG5Hf6GF2lMxPprNSVgXDn+LDChz3ogVhFwTbNToXzKYza7J
	XKaI1VBkg0PZwBNacLkvMy2ozMsIcyEJXEiLDgZLUkL95UfnviDTtCOMb12ubd/bn81FCX15Yen
	ba2JJcNeluyY4gTdXijZqWV/6AWODTEQqSpmdvRpT/q5M+t+j9ZmMdmWfly6/So0V83qLH81KQT
	4cl7trWETNCiCRYsrvdjLC2BJDzh7TsHno/9tTvTBmAxSUfRHJAiAmCrvNSodno+YqXx+bvH1kT
	zkztpyK3Qt9fUbGH7eeCmnh5L91970JbKRrNNJw+pRxdkTb1SJ3YXR9Uo7QGSvrF/3T7g1B6Z1+
	iEYZAJxWSBPIn+BMFKannDX8Lh9Miu0HdsYeDqVKIEdj6Da+50Cs25J4slZULAMxrJOCDXN5Q7o
	OkQvOGbvT5R6+wGw==
X-Google-Smtp-Source: AGHT+IHOYxavcvNCjMo8ESpp671IIFf4aThj7PcelCJSkknoZhse0VlY/vuaeqRwnpTxjujOeJrL1g==
X-Received: by 2002:a17:902:d50f:b0:267:f7bc:673c with SMTP id d9443c01a7336-2951a51e6bfmr165298515ad.44.1762156421802;
        Sun, 02 Nov 2025 23:53:41 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a16652sm34552a91.20.2025.11.02.23.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:53:41 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: stable@vger.kernel.org,
	greg@kroah.com
Cc: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	sjenning@redhat.com,
	ddstreet@ieee.org,
	vitaly.wool@konsulko.com,
	lance.yang@linux.dev,
	leon.huangfu@shopee.com,
	shy828301@gmail.com,
	yosryahmed@google.com,
	sashal@kernel.org,
	vishal.moola@gmail.com,
	cerasuolodomenico@gmail.com,
	nphamcs@gmail.com,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Chris Li <chrisl@kernel.org>,
	Greg Thelen <gthelen@google.com>,
	Ivan Babrou <ivan@cloudflare.com>,
	Michal Koutny <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Wei Xu <weixugc@google.com>
Subject: [PATCH 6.6.y 7/7] mm: memcg: restore subtree stats flushing
Date: Mon,  3 Nov 2025 15:51:35 +0800
Message-ID: <20251103075135.20254-8-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103075135.20254-1-leon.huangfu@shopee.com>
References: <20251103075135.20254-1-leon.huangfu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yosry Ahmed <yosryahmed@google.com>

[ Upstream commit 7d7ef0a4686abe43cd76a141b340a348f45ecdf2 ]

Stats flushing for memcg currently follows the following rules:
- Always flush the entire memcg hierarchy (i.e. flush the root).
- Only one flusher is allowed at a time. If someone else tries to flush
  concurrently, they skip and return immediately.
- A periodic flusher flushes all the stats every 2 seconds.

The reason this approach is followed is because all flushes are serialized
by a global rstat spinlock.  On the memcg side, flushing is invoked from
userspace reads as well as in-kernel flushers (e.g.  reclaim, refault,
etc).  This approach aims to avoid serializing all flushers on the global
lock, which can cause a significant performance hit under high
concurrency.

This approach has the following problems:
- Occasionally a userspace read of the stats of a non-root cgroup will
  be too expensive as it has to flush the entire hierarchy [1].
- Sometimes the stats accuracy are compromised if there is an ongoing
  flush, and we skip and return before the subtree of interest is
  actually flushed, yielding stale stats (by up to 2s due to periodic
  flushing). This is more visible when reading stats from userspace,
  but can also affect in-kernel flushers.

The latter problem is particulary a concern when userspace reads stats
after an event occurs, but gets stats from before the event. Examples:
- When memory usage / pressure spikes, a userspace OOM handler may look
  at the stats of different memcgs to select a victim based on various
  heuristics (e.g. how much private memory will be freed by killing
  this). Reading stale stats from before the usage spike in this case
  may cause a wrongful OOM kill.
- A proactive reclaimer may read the stats after writing to
  memory.reclaim to measure the success of the reclaim operation. Stale
  stats from before reclaim may give a false negative.
- Reading the stats of a parent and a child memcg may be inconsistent
  (child larger than parent), if the flush doesn't happen when the
  parent is read, but happens when the child is read.

As for in-kernel flushers, they will occasionally get stale stats.  No
regressions are currently known from this, but if there are regressions,
they would be very difficult to debug and link to the source of the
problem.

This patch aims to fix these problems by restoring subtree flushing, and
removing the unified/coalesced flushing logic that skips flushing if there
is an ongoing flush.  This change would introduce a significant regression
with global stats flushing thresholds.  With per-memcg stats flushing
thresholds, this seems to perform really well.  The thresholds protect the
underlying lock from unnecessary contention.

This patch was tested in two ways to ensure the latency of flushing is
up to par, on a machine with 384 cpus:

- A synthetic test with 5000 concurrent workers in 500 cgroups doing
  allocations and reclaim, as well as 1000 readers for memory.stat
  (variation of [2]). No regressions were noticed in the total runtime.
  Note that significant regressions in this test are observed with
  global stats thresholds, but not with per-memcg thresholds.

- A synthetic stress test for concurrently reading memcg stats while
  memory allocation/freeing workers are running in the background,
  provided by Wei Xu [3]. With 250k threads reading the stats every
  100ms in 50k cgroups, 99.9% of reads take <= 50us. Less than 0.01%
  of reads take more than 1ms, and no reads take more than 100ms.

[1] https://lore.kernel.org/lkml/CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com/
[2] https://lore.kernel.org/lkml/CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CAAPL-u9D2b=iF5Lf_cRnKxUfkiEe0AMDTu6yhrUAzX0b6a6rDg@mail.gmail.com/

[akpm@linux-foundation.org: fix mm/zswap.c]
[yosryahmed@google.com: remove stats flushing mutex]
  Link: https://lkml.kernel.org/r/CAJD7tkZgP3m-VVPn+fF_YuvXeQYK=tZZjJHj=dzD=CcSSpp2qg@mail.gmail.com
Link: https://lkml.kernel.org/r/20231129032154.3710765-6-yosryahmed@google.com
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Greg Thelen <gthelen@google.com>
Cc: Ivan Babrou <ivan@cloudflare.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Koutny <mkoutny@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Wei Xu <weixugc@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
---
 include/linux/memcontrol.h |  8 ++---
 mm/memcontrol.c            | 68 ++++++++++++++++++++++----------------
 mm/vmscan.c                |  2 +-
 mm/workingset.c            | 10 ++++--
 4 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b1fdb1554f2f..8aee8b75aad0 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1039,8 +1039,8 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return x;
 }

-void mem_cgroup_flush_stats(void);
-void mem_cgroup_flush_stats_ratelimited(void);
+void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
+void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);

 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			      int val);
@@ -1515,11 +1515,11 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return node_page_state(lruvec_pgdat(lruvec), idx);
 }

-static inline void mem_cgroup_flush_stats(void)
+static inline void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 {
 }

-static inline void mem_cgroup_flush_stats_ratelimited(void)
+static inline void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
 {
 }

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c31a5364f325..d3f4486a45d8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -667,7 +667,6 @@ struct memcg_vmstats {
  */
 static void flush_memcg_stats_dwork(struct work_struct *w);
 static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
-static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
 static u64 flush_last_time;

 #define FLUSH_TIME (2UL*HZ)
@@ -728,35 +727,40 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	}
 }

-static void do_flush_stats(void)
+static void do_flush_stats(struct mem_cgroup *memcg)
 {
-	/*
-	 * We always flush the entire tree, so concurrent flushers can just
-	 * skip. This avoids a thundering herd problem on the rstat global lock
-	 * from memcg flushers (e.g. reclaim, refault, etc).
-	 */
-	if (atomic_read(&stats_flush_ongoing) ||
-	    atomic_xchg(&stats_flush_ongoing, 1))
-		return;
-
-	WRITE_ONCE(flush_last_time, jiffies_64);
-
-	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
+	if (mem_cgroup_is_root(memcg))
+		WRITE_ONCE(flush_last_time, jiffies_64);

-	atomic_set(&stats_flush_ongoing, 0);
+	cgroup_rstat_flush(memcg->css.cgroup);
 }

-void mem_cgroup_flush_stats(void)
+/*
+ * mem_cgroup_flush_stats - flush the stats of a memory cgroup subtree
+ * @memcg: root of the subtree to flush
+ *
+ * Flushing is serialized by the underlying global rstat lock. There is also a
+ * minimum amount of work to be done even if there are no stat updates to flush.
+ * Hence, we only flush the stats if the updates delta exceeds a threshold. This
+ * avoids unnecessary work and contention on the underlying lock.
+ */
+void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 {
-	if (memcg_should_flush_stats(root_mem_cgroup))
-		do_flush_stats();
+	if (mem_cgroup_disabled())
+		return;
+
+	if (!memcg)
+		memcg = root_mem_cgroup;
+
+	if (memcg_should_flush_stats(memcg))
+		do_flush_stats(memcg);
 }

-void mem_cgroup_flush_stats_ratelimited(void)
+void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
 {
 	/* Only flush if the periodic flusher is one full cycle late */
 	if (time_after64(jiffies_64, READ_ONCE(flush_last_time) + 2*FLUSH_TIME))
-		mem_cgroup_flush_stats();
+		mem_cgroup_flush_stats(memcg);
 }

 static void flush_memcg_stats_dwork(struct work_struct *w)
@@ -765,7 +769,7 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	 * Deliberately ignore memcg_should_flush_stats() here so that flushing
 	 * in latency-sensitive paths is as cheap as possible.
 	 */
-	do_flush_stats();
+	do_flush_stats(root_mem_cgroup);
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }

@@ -1597,7 +1601,7 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	 *
 	 * Current memory state:
 	 */
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);

 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		u64 size;
@@ -4047,7 +4051,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 	int nid;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);

-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);

 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
 		seq_printf(m, "%s=%lu", stat->name,
@@ -4122,7 +4126,7 @@ static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)

 	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));

-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);

 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
@@ -4624,7 +4628,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;

-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);

 	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
 	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
@@ -6704,7 +6708,7 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 	int i;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);

-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);

 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		int nid;
@@ -7868,7 +7872,11 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 			break;
 		}

-		cgroup_rstat_flush(memcg->css.cgroup);
+		/*
+		 * mem_cgroup_flush_stats() ignores small changes. Use
+		 * do_flush_stats() directly to get accurate stats for charging.
+		 */
+		do_flush_stats(memcg);
 		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
 		if (pages < max)
 			continue;
@@ -7933,8 +7941,10 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
 static u64 zswap_current_read(struct cgroup_subsys_state *css,
 			      struct cftype *cft)
 {
-	cgroup_rstat_flush(css->cgroup);
-	return memcg_page_state(mem_cgroup_from_css(css), MEMCG_ZSWAP_B);
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	mem_cgroup_flush_stats(memcg);
+	return memcg_page_state(memcg, MEMCG_ZSWAP_B);
 }

 static int zswap_max_show(struct seq_file *m, void *v)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 774bae2f54d7..aba757e5c597 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2911,7 +2911,7 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
 	 * Flush the memory cgroup stats, so that we read accurate per-memcg
 	 * lruvec stats for heuristics.
 	 */
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(sc->target_mem_cgroup);

 	/*
 	 * Determine the scan balance between anon and file LRUs.
diff --git a/mm/workingset.c b/mm/workingset.c
index 6e61ad08df75..7bac9be1b87f 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -464,8 +464,12 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)

 	rcu_read_unlock();

-	/* Flush stats (and potentially sleep) outside the RCU read section */
-	mem_cgroup_flush_stats_ratelimited();
+	/*
+	 * Flush stats (and potentially sleep) outside the RCU read section.
+	 * XXX: With per-memcg flushing and thresholding, is ratelimiting
+	 * still needed here?
+	 */
+	mem_cgroup_flush_stats_ratelimited(eviction_memcg);

 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
 	refault = atomic_long_read(&eviction_lruvec->nonresident_age);
@@ -676,7 +680,7 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 		struct lruvec *lruvec;
 		int i;

-		mem_cgroup_flush_stats_ratelimited();
+		mem_cgroup_flush_stats_ratelimited(sc->memcg);
 		lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
 		for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
 			pages += lruvec_page_state_local(lruvec,
--
2.50.1

