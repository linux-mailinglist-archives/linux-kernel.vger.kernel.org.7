Return-Path: <linux-kernel+bounces-792067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66236B3BFE8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2313BE193
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FC4338F55;
	Fri, 29 Aug 2025 15:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Txvuw8E5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E360732BF25
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482547; cv=none; b=aIWaLI85sM1dCTQFe7dYx+saNr3n+Q3qTl9WflNACbU8xXs08s7BAMJpFwKNMKC7Bz5LWIO4vCCuOoMGPLoaZYwYwWRS2225XqVRTuj6s/OB/0/qkx/dfVyM8J6XsABoaR3Wz4C7DEPezEQNrhRVQgiuSWBZq8trT+2sznemrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482547; c=relaxed/simple;
	bh=2AKrGqjcDEQNktrx0AjvGJUm44a7opBORKSmeOdVWP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAkwsqnIYnKEl78TQGbYdqmx4BrfKnRnGS4f4+iUqKJiYaYnm6APqCMM67JiBJptFUr/cs++HIyIZ25mSqY0l7RlO3sXBe2L8TNILiGYuihRf+9/qhnUpVWhYBFAxEApoKBtTlOS176imd/Qwez3vp2B9qKzkkHGMnswyexf7Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Txvuw8E5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF56EC4CEF5;
	Fri, 29 Aug 2025 15:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482546;
	bh=2AKrGqjcDEQNktrx0AjvGJUm44a7opBORKSmeOdVWP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Txvuw8E5yTPsG09Tjpv6OmMLkfH+kmFBRxaLHs+eyP+UoV4kakVxkflji9xw907jH
	 sQp8aBkSqwIXZZRf9IdQ/UZT9lannJILBTTPoyVlTDB1KS7AHAGhl0g0HVqHhHTnxk
	 ZZDB3UtJ8VWcifGeJjmlJ42eHT9rLJHLF1GQ6F2RC+FF+yfYvZsDLt0EOLW2lkZucL
	 xWOgvL+ENrJobKRaKvx1bVMc+dWycLyO/F7g7kk3RIZdm17FK3FrWGhGt3vDq1Mn8r
	 wsDWhF4ZBpyflA3e+OCuLBS72S5hhtvj9evyI4zNoLHczcOE2GAzORnyqejY1wbhdY
	 ReuZz+MKUTF+g==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	linux-mm@kvack.org
Subject: [PATCH 16/33] sched/isolation: Flush vmstat workqueues on cpuset isolated partition change
Date: Fri, 29 Aug 2025 17:47:57 +0200
Message-ID: <20250829154814.47015-17-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
References: <20250829154814.47015-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HK_TYPE_DOMAIN housekeeping cpumask is now modifyable at runtime.
In order to synchronize against vmstat workqueue to make sure
that no asynchronous vmstat work is still pending or executing on a
newly made isolated CPU, the housekeeping susbsystem must flush the
vmstat workqueues.

This involves flushing the whole mm_percpu_wq workqueue, shared with
LRU drain, introducing here a welcome side effect.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/vmstat.h   | 2 ++
 kernel/sched/isolation.c | 1 +
 kernel/sched/sched.h     | 1 +
 mm/vmstat.c              | 5 +++++
 4 files changed, 9 insertions(+)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index c287998908bf..a81aa5635b47 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -303,6 +303,7 @@ int calculate_pressure_threshold(struct zone *zone);
 int calculate_normal_threshold(struct zone *zone);
 void set_pgdat_percpu_threshold(pg_data_t *pgdat,
 				int (*calculate_pressure)(struct zone *));
+void vmstat_flush_workqueue(void);
 #else /* CONFIG_SMP */
 
 /*
@@ -403,6 +404,7 @@ static inline void __dec_node_page_state(struct page *page,
 static inline void refresh_zone_stat_thresholds(void) { }
 static inline void cpu_vm_stats_fold(int cpu) { }
 static inline void quiet_vmstat(void) { }
+static inline void vmstat_flush_workqueue(void) { }
 
 static inline void drain_zonestat(struct zone *zone,
 			struct per_cpu_zonestat *pzstats) { }
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index e85f402b103a..86ce39aa1e9f 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -125,6 +125,7 @@ int housekeeping_update(struct cpumask *mask, enum hk_type type)
 	synchronize_rcu();
 
 	mem_cgroup_flush_workqueue();
+	vmstat_flush_workqueue();
 
 	kfree(old);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1dad1ac7fc61..2d4de083200a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -68,6 +68,7 @@
 #include <linux/types.h>
 #include <linux/u64_stats_sync_api.h>
 #include <linux/uaccess.h>
+#include <linux/vmstat.h>
 #include <linux/wait_api.h>
 #include <linux/wait_bit.h>
 #include <linux/workqueue_api.h>
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b90325ee49d3..69412b61fe1b 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -2113,6 +2113,11 @@ static void vmstat_shepherd(struct work_struct *w);
 
 static DECLARE_DEFERRABLE_WORK(shepherd, vmstat_shepherd);
 
+void vmstat_flush_workqueue(void)
+{
+	flush_workqueue(mm_percpu_wq);
+}
+
 static void vmstat_shepherd(struct work_struct *w)
 {
 	int cpu;
-- 
2.51.0


