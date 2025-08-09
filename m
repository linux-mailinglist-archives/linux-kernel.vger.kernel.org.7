Return-Path: <linux-kernel+bounces-760956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1818FB1F245
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10123B9A69
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1C7274B43;
	Sat,  9 Aug 2025 05:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZsq9eJL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A7D2749D5
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716450; cv=none; b=IeQpUvuEInOqzZCCDB3S2FFJC3zSp4/XkEtNAu2D98UQxwsXgo2BbwLtaxH6iJwbi4gN7aV60Aez3K8ydwiJFAzlJgHRf/3+aORKqKYd4JzlvthQfT5xmROL82OUpU66n+lqag40QZb3zB8TfPDePjvzD5oeSB7VRw6J3Cixx+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716450; c=relaxed/simple;
	bh=aXXr09emE5m1BA8+F+9P+Qieum2q8rFMJHj2OrnZISQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S5MR0P7NeiK39j0s1bhGmWRhNoCo1BGGAp0DbGAVUu/cKCksVWgSVTBQqiegxZ+gsioGdqPIL8dWWDic13tfdX1SnoZ6qXprsQhZj7vCqF2cTb/xO8jcfhLxZaWGG0ZCiaJ0gxuXgS+7OA9TZAf4d9OKuUhX4CnNCW42X+VS4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZsq9eJL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716449; x=1786252449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aXXr09emE5m1BA8+F+9P+Qieum2q8rFMJHj2OrnZISQ=;
  b=GZsq9eJL5DGjYunKJTsof+Ln2cKfOk2BGwjzrC+sKFMATJMkyxO99PMo
   2Oyl5uVHYhRF8Tm0YmjjPIUI3d++yQ67YwJyf8GQHF8cYeMonziUJgHhH
   kWHsp/STcLEVX42oVsCvQJlHA6eoqh5JKSyBBe3w1N12e5vNle7MdQRuI
   9sPdUfMBH0dbovuNFtw5OfBzc2eoiu4kiBY1XCFzj5eShFF03nf9Tv2B/
   ClF5YQoCu+HTwDDVvM9QKGz82gKXl8kYElV4byqv5tvHmI7Psovf6yI1d
   zi0XGuLMMAQ/QyWVmk7U53AdlwCTHAyvtt6E7DmP/8gc3IF+ydRquzbUa
   g==;
X-CSE-ConnectionGUID: Q9jwphPASBiXZUHMOabB2g==
X-CSE-MsgGUID: 2ZVJmYQUSISFufuXvDLTyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="60860025"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="60860025"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:14:08 -0700
X-CSE-ConnectionGUID: ilrvcjmWQsiRa7CRb1DYVw==
X-CSE-MsgGUID: Uh2zL5Q0RAa3BSoaBdHAzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="169693092"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa003.jf.intel.com with ESMTP; 08 Aug 2025 22:14:02 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Libo Chen <libo.chen@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jianyong Wu <jianyong.wu@outlook.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>,
	Vern Hao <vernhao@tencent.com>,
	Len Brown <len.brown@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Aubrey Li <aubrey.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 22/28] sched: Turn EPOCH_PERIOD and EPOCH_OLD into tunnable debugfs
Date: Sat,  9 Aug 2025 13:07:59 +0800
Message-Id: <79c8fdcf7e875617935cfaba2ea1f2c2ae5ce62c.1754712565.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1754712565.git.tim.c.chen@linux.intel.com>
References: <cover.1754712565.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert EPOCH_PERIOD and EPOCH_OLD into tunable debugfs
entries. Users can adjust the decay rate as needed.
By default, occupancy decays by half every 10 ms.

Suggested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/debug.c | 2 ++
 kernel/sched/fair.c  | 9 ++++++---
 kernel/sched/sched.h | 2 ++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 682fd91a42a0..7a9ec03704b9 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -535,6 +535,8 @@ static __init int sched_init_debug(void)
 #ifdef CONFIG_SCHED_CACHE
 	debugfs_create_u32("llc_aggr_cap", 0644, debugfs_sched, &sysctl_llc_aggr_cap);
 	debugfs_create_u32("llc_aggr_imb", 0644, debugfs_sched, &sysctl_llc_aggr_imb);
+	debugfs_create_u32("llc_period", 0644, debugfs_sched, &sysctl_llc_period);
+	debugfs_create_u32("llc_old", 0644, debugfs_sched, &sysctl_llc_old);
 #endif
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 194ec594561b..64f757ad39fc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1175,6 +1175,9 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
 #define EPOCH_PERIOD	(HZ/100)	/* 10 ms */
 #define EPOCH_OLD	5		/* 50 ms */
 
+__read_mostly unsigned int sysctl_llc_period    = EPOCH_PERIOD;
+__read_mostly unsigned int sysctl_llc_old       = EPOCH_OLD;
+
 DEFINE_STATIC_KEY_FALSE(sched_cache_present);
 
 static int llc_id(int cpu)
@@ -1283,9 +1286,9 @@ static inline void __update_mm_sched(struct rq *rq, struct mm_sched *pcpu_sched)
 	long delta = now - rq->cpu_epoch_next;
 
 	if (delta > 0) {
-		n = (delta + EPOCH_PERIOD - 1) / EPOCH_PERIOD;
+		n = (delta + sysctl_llc_period - 1) / sysctl_llc_period;
 		rq->cpu_epoch += n;
-		rq->cpu_epoch_next += n * EPOCH_PERIOD;
+		rq->cpu_epoch_next += n * sysctl_llc_period;
 		__shr_u64(&rq->cpu_runtime, n);
 	}
 
@@ -1346,7 +1349,7 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	 * has only 1 thread, invalidate
 	 * it's preferred state.
 	 */
-	if (epoch - READ_ONCE(mm->mm_sched_epoch) > EPOCH_OLD ||
+	if (epoch - READ_ONCE(mm->mm_sched_epoch) > sysctl_llc_old ||
 	    get_nr_threads(p) <= 1) {
 		mm->mm_sched_cpu = -1;
 		pcpu_sched->occ = 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3e60618a88e9..d752d64d4acd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2858,6 +2858,8 @@ extern unsigned int sysctl_numa_balancing_hot_threshold;
 extern unsigned int sysctl_llc_aggr_cap;
 extern unsigned int sysctl_llc_aggr_imb;
 extern struct static_key_false sched_cache_present;
+extern unsigned int sysctl_llc_period;
+extern unsigned int sysctl_llc_old;
 #endif
 
 #ifdef CONFIG_SCHED_HRTICK
-- 
2.25.1


