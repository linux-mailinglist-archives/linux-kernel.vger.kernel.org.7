Return-Path: <linux-kernel+bounces-715649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C824DAF7BDA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 17:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF22B5A31FE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4A02EF9A6;
	Thu,  3 Jul 2025 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="DFRl4H5D"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC482D781F;
	Thu,  3 Jul 2025 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556047; cv=none; b=lsjkTxssiST9iXHNDGTS7SFP9x+LoAMRrG+miMuM7kxpRLp32E76TJMapHMEsy7/ilAULymHUMsQnaRO7IYFH2e97iBKEXlLdGWs2CfenmMNld8WW/cIGw1LAwdZs8aJ6BujE5kw2jFCBpBwb1kVSUsoSSNVVquOTl+Kt1a5WSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556047; c=relaxed/simple;
	bh=6NWEvR+7to9bTswyTiWXgqxCA45ln/MuXwjaBeula/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K791hp09OmpFfL4V4CA/o0/YpkSkweF3hmA/yWUpLQ+/kuuOYE7LhzW413k0M+W4c8N/8p1iYbUwmzaPvBIwPiZKHgSavbGZsvsv5sLAJkFZ+RJ7t4xuE4lp0rZt91kbvbLX4oYqmlDt6KM/NsSChoG1qej+mAruQhRcRA/7lZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=DFRl4H5D; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1751556044;
	bh=6NWEvR+7to9bTswyTiWXgqxCA45ln/MuXwjaBeula/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DFRl4H5D2Qkkl69EwGXmAgYdFK2PqityJ4SC99Ubx8nHG0SX/M1Zdiek3I2fSRgMw
	 GNYvjUDzP6wlPP0tuoWjJuV/r51oqhdjcrEjpl+iBcIx8BZlVR2i/zSZvPfAj1ufVp
	 6iPzjzLAzNKNbm/fBE9XNZnhJQy4RR4YJypVedJIquKO416GE8kn12v9Bof5GiZ25x
	 jgN4orbOncPfG+/ciDV2an7wTm0lA9aJ0rHEAGrtD5q0Rrqkp2vqs2HJ4V/rz3a/wd
	 QBK5Wfied77AVIaRpWyNLaD1M3eWaL6EzwvEaJpLx8Y4LI1gkwKKLGin9WQMI7HlWe
	 CY819dT9rNquw==
Received: from thinkos.internal.efficios.com (192-222-132-26.qc.cable.ebox.net [192.222.132.26])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4bY0p41Wmgz1Mhs;
	Thu,  3 Jul 2025 11:20:44 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>,
	christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sweet Tea Dorminy <sweettea@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [RFC PATCH v4 2/2] mm: Fix OOM killer inaccuracy on large many-core systems
Date: Thu,  3 Jul 2025 11:20:32 -0400
Message-Id: <20250703152032.10507-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703152032.10507-1-mathieu.desnoyers@efficios.com>
References: <20250703152032.10507-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use hierarchical per-cpu counters for rss tracking to fix the per-mm RSS
tracking which has become too inaccurate for OOM killer purposes on
large many-core systems.

The following rss tracking issues were noted by Sweet Tea Dorminy [1],
which lead to picking wrong tasks as OOM kill target:

  Recently, several internal services had an RSS usage regression as part of a
  kernel upgrade. Previously, they were on a pre-6.2 kernel and were able to
  read RSS statistics in a backup watchdog process to monitor and decide if
  they'd overrun their memory budget. Now, however, a representative service
  with five threads, expected to use about a hundred MB of memory, on a 250-cpu
  machine had memory usage tens of megabytes different from the expected amount
  -- this constituted a significant percentage of inaccuracy, causing the
  watchdog to act.

  This was a result of f1a7941243c1 ("mm: convert mm's rss stats into
  percpu_counter") [1].  Previously, the memory error was bounded by
  64*nr_threads pages, a very livable megabyte. Now, however, as a result of
  scheduler decisions moving the threads around the CPUs, the memory error could
  be as large as a gigabyte.

  This is a really tremendous inaccuracy for any few-threaded program on a
  large machine and impedes monitoring significantly. These stat counters are
  also used to make OOM killing decisions, so this additional inaccuracy could
  make a big difference in OOM situations -- either resulting in the wrong
  process being killed, or in less memory being returned from an OOM-kill than
  expected.

Here is a (possibly incomplete) list of the prior approaches that were
used or proposed, along with their downside:

1) Per-thread rss tracking: large error on many-thread processes.

2) Per-CPU counters: up to 12% slower for short-lived processes and 9%
   increased system time in make test workloads [1]. Moreover, the
   inaccuracy increases with O(n^2) with the number of CPUs.

3) Per-NUMA-node counters: requires atomics on fast-path (overhead),
   error is high with systems that have lots of NUMA nodes (32 times
   the number of NUMA nodes).

The approach proposed here is to replace this by the hierarchical
per-cpu counters, which bounds the inaccuracy based on the system
topology with O(N*logN).

Link: https://lore.kernel.org/lkml/20250331223516.7810-2-sweettea-kernel@dorminy.me/ # [1]
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Martin Liu <liumartin@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: christian.koenig@amd.com
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Sweet Tea Dorminy <sweettea@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@Oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-mm@kvack.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: Yu Zhao <yuzhao@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 include/linux/mm.h          |  8 ++++----
 include/linux/mm_types.h    |  4 ++--
 include/trace/events/kmem.h |  2 +-
 kernel/fork.c               | 31 +++++++++++++++++++++----------
 4 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e51dba8398f7..79defe89aefa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2705,28 +2705,28 @@ static inline bool get_user_page_fast_only(unsigned long addr,
  */
 static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
 {
-	return percpu_counter_read_positive(&mm->rss_stat[member]);
+	return percpu_counter_tree_approximate_sum(&mm->rss_stat[member]);
 }
 
 void mm_trace_rss_stat(struct mm_struct *mm, int member);
 
 static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
 {
-	percpu_counter_add(&mm->rss_stat[member], value);
+	percpu_counter_tree_add(&mm->rss_stat[member], value);
 
 	mm_trace_rss_stat(mm, member);
 }
 
 static inline void inc_mm_counter(struct mm_struct *mm, int member)
 {
-	percpu_counter_inc(&mm->rss_stat[member]);
+	percpu_counter_tree_add(&mm->rss_stat[member], 1);
 
 	mm_trace_rss_stat(mm, member);
 }
 
 static inline void dec_mm_counter(struct mm_struct *mm, int member)
 {
-	percpu_counter_dec(&mm->rss_stat[member]);
+	percpu_counter_tree_add(&mm->rss_stat[member], -1);
 
 	mm_trace_rss_stat(mm, member);
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 56d07edd01f9..85b15109106a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -18,7 +18,7 @@
 #include <linux/page-flags-layout.h>
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
-#include <linux/percpu_counter.h>
+#include <linux/percpu_counter_tree.h>
 #include <linux/types.h>
 
 #include <asm/mmu.h>
@@ -1059,7 +1059,7 @@ struct mm_struct {
 
 		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
 
-		struct percpu_counter rss_stat[NR_MM_COUNTERS];
+		struct percpu_counter_tree rss_stat[NR_MM_COUNTERS];
 
 		struct linux_binfmt *binfmt;
 
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index f74925a6cf69..d6199b99c771 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -477,7 +477,7 @@ TRACE_EVENT(rss_stat,
 		__entry->mm_id = mm_ptr_to_hash(mm);
 		__entry->curr = !!(current->mm == mm);
 		__entry->member = member;
-		__entry->size = (percpu_counter_sum_positive(&mm->rss_stat[member])
+		__entry->size = (percpu_counter_tree_approximate_sum(&mm->rss_stat[member])
 							    << PAGE_SHIFT);
 	),
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 168681fc4b25..dd458adc5543 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -129,6 +129,11 @@
  */
 #define MAX_THREADS FUTEX_TID_MASK
 
+/*
+ * Batch size of rss stat approximation
+ */
+#define RSS_STAT_BATCH_SIZE	32
+
 /*
  * Protected counters by write_lock_irq(&tasklist_lock)
  */
@@ -843,11 +848,10 @@ static void check_mm(struct mm_struct *mm)
 			 "Please make sure 'struct resident_page_types[]' is updated as well");
 
 	for (i = 0; i < NR_MM_COUNTERS; i++) {
-		long x = percpu_counter_sum(&mm->rss_stat[i]);
-
-		if (unlikely(x))
-			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
-				 mm, resident_page_types[i], x);
+		if (unlikely(percpu_counter_tree_precise_compare_value(&mm->rss_stat[i], 0) != 0))
+			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%d\n",
+				 mm, resident_page_types[i],
+				 percpu_counter_tree_precise_sum(&mm->rss_stat[i]));
 	}
 
 	if (mm_pgtables_bytes(mm))
@@ -930,6 +934,8 @@ static void cleanup_lazy_tlbs(struct mm_struct *mm)
  */
 void __mmdrop(struct mm_struct *mm)
 {
+	int i;
+
 	BUG_ON(mm == &init_mm);
 	WARN_ON_ONCE(mm == current->mm);
 
@@ -945,8 +951,8 @@ void __mmdrop(struct mm_struct *mm)
 	put_user_ns(mm->user_ns);
 	mm_pasid_drop(mm);
 	mm_destroy_cid(mm);
-	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
-
+	for (i = 0; i < NR_MM_COUNTERS; i++)
+		percpu_counter_tree_destroy(&mm->rss_stat[i]);
 	free_mm(mm);
 }
 EXPORT_SYMBOL_GPL(__mmdrop);
@@ -1285,6 +1291,8 @@ static void mmap_init_lock(struct mm_struct *mm)
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	struct user_namespace *user_ns)
 {
+	int i;
+
 	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
 	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
 	atomic_set(&mm->mm_users, 1);
@@ -1332,15 +1340,18 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (mm_alloc_cid(mm, p))
 		goto fail_cid;
 
-	if (percpu_counter_init_many(mm->rss_stat, 0, GFP_KERNEL_ACCOUNT,
-				     NR_MM_COUNTERS))
-		goto fail_pcpu;
+	for (i = 0; i < NR_MM_COUNTERS; i++) {
+		if (percpu_counter_tree_init(&mm->rss_stat[i], RSS_STAT_BATCH_SIZE, GFP_KERNEL_ACCOUNT))
+			goto fail_pcpu;
+	}
 
 	mm->user_ns = get_user_ns(user_ns);
 	lru_gen_init_mm(mm);
 	return mm;
 
 fail_pcpu:
+	for (i--; i >= 0; i--)
+		percpu_counter_tree_destroy(&mm->rss_stat[i]);
 	mm_destroy_cid(mm);
 fail_cid:
 	destroy_context(mm);
-- 
2.39.5


