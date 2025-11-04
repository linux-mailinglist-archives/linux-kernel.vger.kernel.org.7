Return-Path: <linux-kernel+bounces-884031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED60C2F28A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 04:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D8D44F2298
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 03:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786702737F8;
	Tue,  4 Nov 2025 03:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="DvMDGdph"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1DF280CD5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 03:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762226528; cv=none; b=ASz0sMy6cyXN4Vs1WdxiUHNKoCppst7IkNR1EwVtfCc9Va6wE6PT7Ppkas2/81Fe/z1Fe/hhgeF6a49Pb0AWzstP/WFZXBYJoOmjaDgby4Kn/P9XyUOhZ8TWlJY12KHIc2I576zyYjuV1L5eF1boeYrJGRfXQh08m3+gsrh9bhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762226528; c=relaxed/simple;
	bh=gdnFeUD55lC/200zV9LOApz48NpUIIYrrQ5duPDEENA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ix47VGZcJElnj/6xyPa7ljM3ANr37jGDr21lbwbrmkrZJar8jpNZ57lRCjSxeUvKpncnwZBTL1X+wJwLl5nxzE7uioph5EZHPH2TNW3rLy6rUaguF5aEg0c0HRjCX0hjpTQ7gD1O8TeVmZe7FtVCyiL1DOHdPCpcb2Ynd4FyEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=DvMDGdph; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27c369f8986so51912215ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 19:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762226525; x=1762831325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vXCmE7H6x7fyKpOMWrBQ1sPfqnG3V4Jxw1CcNvLnI7g=;
        b=DvMDGdphgHCq02uF3NPgWSWxEhXvhl5Td3KNYcawHqFfY9/uyX7uvX+UJWaTsEW526
         OVXxzf2NwSCF6Ljc6Xt9YcyNcezXP+G1Gurm0R36+1J3pxKNjidAeYjzWPUM1Dnju0SW
         RZwgWc1GugDZM2nbi/1HeYrmpqSl2ns1RYdcuUubYsRokV4auihUw/2mFGFP3BzaGwc/
         dpmnZk9OIB96KhNUtpd+n9AXm6P09mpbzA5PPbdbMfAURjDPBceG76mT5DDBGw0NDY7e
         R43YIAY5Afx6mKcKmj0Q08WcH+LzDMq4noC2QGsdMJexDj2vFkbISDZgkiOghVOQXhMF
         gEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762226525; x=1762831325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vXCmE7H6x7fyKpOMWrBQ1sPfqnG3V4Jxw1CcNvLnI7g=;
        b=h+6sqadg0vO7JGz+B2u/9qqhMfzPgbjxhRm+/m+k9TUvTd/3qPMFC56mZ3FSoRaMfk
         BeGtzE1lWIjtvSVA8Wd8eUbGhexmwh1HRCOz4lowHSfX8oTmcG2J8C7S4j+uQ7Ekl/hH
         YtKHlUdhB8fcnYpwVM+0K/9G6KSEMf4/eckD1/j0cdzY6rw9OpMmZ5IIbWqUDdOvb/q8
         czGdUMLUfx8wuU/jgCrZK/dGbu8XkwZ6lJYCvoxce9jpfbhrD6kHezglkf4G5v0+J60N
         yUXF5C56PcgR4v0iXnaaKxh1CuAjy9y3btp7cz1OCPXzaLUTLlrvvUEgON+B6ApSNfrP
         l9JA==
X-Forwarded-Encrypted: i=1; AJvYcCVad7HiNNL3fLmwtvK2VJDOVlc6sBYV9t4RyZn2yF7pK+cGorctGF2JW3h/GdahPeaiSf5nNunzSpIwNf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh9WV28LM5QhBWzZXFUFBFA/HDTaS880phtRq8o+kuN6aNpjKa
	/qJeP9spjOl1TrtTBnmSrdHlWMeXOFFcWxOYRuL/3iPkcqHfHjAtbtaqVJNJmXWfVQo=
X-Gm-Gg: ASbGncs87tpqa2HouheJUeQDA2UbrC5DwYlXKJUWRKT4FVYra0sZGIx14Kz69NNmFi6
	hTe71t3UwCUlRSlvM4hK0TD0AbLbqWl4eKaPANpgM6K4uIUmmskOHduuMtLW6TNYSjs6R9EGequ
	r68AfnMuCY5yHShAdlmPOdEzJAtmtuwIFHLJM1A1ANi3NGwUAUjtyFqtCYkdaioiooqWkPZ8mCK
	xlN7P9k43fyvtBbKaPnXxYn+LuStCEyx5VJ2WHTvmxlZA0VAWQ9cDmZHY2bJ+PhMQqsIFZLy19l
	7/C/7YS6wMOjc3tmlieAUSNyr3T4GgfQl5jioYVMqTFBoTCu7ka+2MWyE0ZvEoZPoOXkYRqxCxd
	PITP7+irRlTnTS+et19OTlRZCxPZ4sMLYSwuhbCQs7kzQR9yz2mcC29GWCVyJ8/DnBxCpLnOl8H
	LkQpN76kAVjYdEXg==
X-Google-Smtp-Source: AGHT+IF2TZ20FVdtcNu1/5M1Y2bthYAGkuFfgh/CKrUIJaaPONkop5s1tx0H2wZNuH9GtYdOsYlGuA==
X-Received: by 2002:a17:902:db0e:b0:295:6c26:9348 with SMTP id d9443c01a7336-2956c2696d4mr129368375ad.59.1762226525257;
        Mon, 03 Nov 2025 19:22:05 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a5751fsm7559125ad.82.2025.11.03.19.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 19:22:04 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	joel.granados@kernel.org,
	jack@suse.cz,
	laoar.shao@gmail.com,
	mclapinski@google.com,
	kyle.meyer@hpe.com,
	corbet@lwn.net,
	lance.yang@linux.dev,
	leon.huangfu@shopee.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [PATCH mm-new] mm/memcontrol: Introduce sysctl vm.memcg_stats_flush_threshold
Date: Tue,  4 Nov 2025 11:19:08 +0800
Message-ID: <20251104031908.77313-1-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation uses a flush threshold calculated as
MEMCG_CHARGE_BATCH * num_online_cpus() for determining when to
aggregate per-CPU memory cgroup statistics. On systems with high core
counts, this threshold can become very large (e.g., 64 * 256 = 16,384
on a 256-core system), leading to stale statistics when userspace reads
memory.stat files.

This is particularly problematic for monitoring and management tools
that rely on reasonably fresh statistics, as they may observe data that
is thousands of updates out of date.

Introduce a new sysctl, vm.memcg_stats_flush_threshold, that allows
administrators to override the flush threshold specifically for
userspace reads of memory.stat. When set to 0 (default), the behavior
remains unchanged, using the automatic calculation. When set to a
non-zero value, userspace reads will use the custom threshold for more
frequent flushing.

Importantly, this change only affects userspace paths. Internal kernel
paths continue to use the default threshold (or ratelimited flushing)
to maintain optimal performance. This is achieved by:

- Introducing mem_cgroup_flush_stats_user() for userspace reads
- Keeping mem_cgroup_flush_stats() unchanged for kernel internal paths
- Updating memory.stat read paths to use mem_cgroup_flush_stats_user()

The implementation adds comprehensive documentation in
Documentation/admin-guide/sysctl/vm.rst explaining the use cases,
examples for different system configurations, and the distinction
between userspace and kernel flush behaviors.

Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 48 ++++++++++++++
 include/linux/memcontrol.h              |  1 +
 mm/memcontrol-v1.c                      |  4 +-
 mm/memcontrol.c                         | 86 +++++++++++++++++++++----
 4 files changed, 124 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index ace73480eb9d..f40c629413ea 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -46,6 +46,7 @@ Currently, these files are in /proc/sys/vm:
 - lowmem_reserve_ratio
 - max_map_count
 - mem_profiling         (only if CONFIG_MEM_ALLOC_PROFILING=y)
+- memcg_stats_flush_threshold
 - memory_failure_early_kill
 - memory_failure_recovery
 - min_free_kbytes
@@ -515,6 +516,53 @@ memory allocations.
 The default value depends on CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT.
 
 
+memcg_stats_flush_threshold
+============================
+
+Control the threshold for flushing memory cgroup statistics when reading
+memory.stat from userspace. Memory cgroup stats are updated frequently in
+per-CPU counters, but these updates need to be periodically aggregated
+(flushed) to provide accurate statistics.
+
+**Important**: This setting ONLY affects userspace reads of memory.stat files.
+Internal kernel paths continue to use the default threshold (or ratelimited
+flushing) to maintain optimal performance in latency-sensitive code paths.
+
+When set to 0 (default), userspace reads use the automatic threshold:
+MEMCG_CHARGE_BATCH * num_online_cpus()
+
+This means on systems with many CPU cores, the threshold can become very high
+(e.g., 64 * 256 = 16,384 updates on a 256-core system), potentially resulting
+in stale statistics when reading memory.stat.
+
+Setting this to a non-zero value overrides the automatic calculation for
+userspace reads only. Lower values result in fresher statistics when reading
+memory.stat but may increase overhead due to more frequent flushing.
+
+Examples:
+
+- On a 256-core system with default (0):
+  Userspace reads use threshold = 64 * 256 = 16,384 updates
+  Internal kernel paths use default thresholds (unaffected)
+
+- Setting to 2048:
+  Userspace reads use threshold = 2,048 updates (much fresher stats)
+  Internal kernel paths use default thresholds (performance maintained)
+
+- Setting to 1024:
+  Userspace reads use threshold = 1,024 updates (even fresher stats)
+  Internal kernel paths use default thresholds (performance maintained)
+
+Note: Memory cgroup statistics are also flushed automatically every 2 seconds
+regardless of this threshold.
+
+Recommended for systems with high core counts where the default threshold
+results in statistics that are too stale for monitoring or management tools,
+while keeping internal kernel operations performant.
+
+Default: 0 (auto-calculate based on CPU count)
+
+
 memory_failure_early_kill
 =========================
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 8d2e250535a8..208895e6cf14 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -955,6 +955,7 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 				      enum node_stat_item idx);
 
 void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
+void mem_cgroup_flush_stats_user(struct mem_cgroup *memcg);
 void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
 
 void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val);
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 6eed14bff742..3eeb20f6c5ad 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1792,7 +1792,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 	int nid;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	mem_cgroup_flush_stats(memcg);
+	mem_cgroup_flush_stats_user(memcg);
 
 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
 		seq_printf(m, "%s=%lu", stat->name,
@@ -1873,7 +1873,7 @@ void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 
 	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
 
-	mem_cgroup_flush_stats(memcg);
+	mem_cgroup_flush_stats_user(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c34029e92bab..fffcf6518ae0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -63,6 +63,7 @@
 #include <linux/seq_buf.h>
 #include <linux/sched/isolation.h>
 #include <linux/kmemleak.h>
+#include <linux/sysctl.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -556,10 +557,40 @@ static u64 flush_last_time;
 
 #define FLUSH_TIME (2UL*HZ)
 
-static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
+#define FLUSH_DEFAULT_THRESHOLD (MEMCG_CHARGE_BATCH * num_online_cpus())
+
+/*
+ * Threshold for number of stat updates before triggering a flush.
+ *
+ * Default: 0
+ *   - When set to 0 (the default), the threshold is calculated as:
+ *         FLUSH_DEFAULT_THRESHOLD
+ *     (i.e. MEMCG_CHARGE_BATCH * num_online_cpus())
+ *
+ * Tunable:
+ *   - This value can be overridden at runtime using the sysctl:
+ *         /proc/sys/vm/memcg_stats_flush_threshold
+ *   - Useful for systems with many CPU cores, where the default threshold may
+ *     result in stale stats; a lower value leads to more frequent flushing.
+ */
+static int memcg_stats_flush_threshold __read_mostly;
+
+#ifdef CONFIG_SYSCTL
+static const struct ctl_table memcg_sysctl_table[] = {
+	{
+		.procname	= "memcg_stats_flush_threshold",
+		.data		= &memcg_stats_flush_threshold,
+		.maxlen		= sizeof(memcg_stats_flush_threshold),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
+};
+#endif
+
+static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats, int threshold)
 {
-	return atomic_read(&vmstats->stats_updates) >
-		MEMCG_CHARGE_BATCH * num_online_cpus();
+	return atomic_read(&vmstats->stats_updates) > threshold;
 }
 
 static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val,
@@ -581,7 +612,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val,
 		 * flushable as well and also there is no need to increase
 		 * stats_updates.
 		 */
-		if (memcg_vmstats_needs_flush(statc->vmstats))
+		if (memcg_vmstats_needs_flush(statc->vmstats, FLUSH_DEFAULT_THRESHOLD))
 			break;
 
 		stats_updates = this_cpu_add_return(statc_pcpu->stats_updates,
@@ -594,9 +625,9 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val,
 	}
 }
 
-static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
+static void __mem_cgroup_flush_stats_threshold(struct mem_cgroup *memcg, bool force, int threshold)
 {
-	bool needs_flush = memcg_vmstats_needs_flush(memcg->vmstats);
+	bool needs_flush = memcg_vmstats_needs_flush(memcg->vmstats, threshold);
 
 	trace_memcg_flush_stats(memcg, atomic_read(&memcg->vmstats->stats_updates),
 		force, needs_flush);
@@ -610,6 +641,20 @@ static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
 	css_rstat_flush(&memcg->css);
 }
 
+static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
+{
+	__mem_cgroup_flush_stats_threshold(memcg, force, FLUSH_DEFAULT_THRESHOLD);
+}
+
+static void mem_cgroup_flush_stats_threshold(struct mem_cgroup *memcg, int threshold)
+{
+	if (mem_cgroup_disabled())
+		return;
+
+	memcg = memcg ? : root_mem_cgroup;
+	__mem_cgroup_flush_stats_threshold(memcg, false, threshold);
+}
+
 /*
  * mem_cgroup_flush_stats - flush the stats of a memory cgroup subtree
  * @memcg: root of the subtree to flush
@@ -621,13 +666,24 @@ static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
  */
 void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 {
-	if (mem_cgroup_disabled())
-		return;
+	mem_cgroup_flush_stats_threshold(memcg, FLUSH_DEFAULT_THRESHOLD);
+}
 
-	if (!memcg)
-		memcg = root_mem_cgroup;
+/*
+ * mem_cgroup_flush_stats_user - flush stats when reading memory.stat from userspace
+ * @memcg: root of the subtree to flush
+ *
+ * This function uses a potentially custom threshold set via sysctl
+ * (memcg_stats_flush_threshold). It should only be used for userspace reads
+ * of memory.stat where fresher stats are desired. Internal kernel paths
+ * should use mem_cgroup_flush_stats() to maintain performance.
+ */
+void mem_cgroup_flush_stats_user(struct mem_cgroup *memcg)
+{
+	int threshold = READ_ONCE(memcg_stats_flush_threshold);
 
-	__mem_cgroup_flush_stats(memcg, false);
+	threshold = threshold ? : FLUSH_DEFAULT_THRESHOLD;
+	mem_cgroup_flush_stats_threshold(memcg, threshold);
 }
 
 void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
@@ -1474,7 +1530,7 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	 *
 	 * Current memory state:
 	 */
-	mem_cgroup_flush_stats(memcg);
+	mem_cgroup_flush_stats_user(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		u64 size;
@@ -4544,7 +4600,7 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 	int i;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	mem_cgroup_flush_stats(memcg);
+	mem_cgroup_flush_stats_user(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		int nid;
@@ -5176,6 +5232,10 @@ int __init mem_cgroup_init(void)
 	memcg_pn_cachep = KMEM_CACHE(mem_cgroup_per_node,
 				     SLAB_PANIC | SLAB_HWCACHE_ALIGN);
 
+#ifdef CONFIG_SYSCTL
+	register_sysctl_init("vm", memcg_sysctl_table);
+#endif
+
 	return 0;
 }
 
-- 
2.51.2


