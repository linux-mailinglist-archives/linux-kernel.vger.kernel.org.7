Return-Path: <linux-kernel+bounces-760938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6729B1F231
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A7317A4A6E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62DA274B43;
	Sat,  9 Aug 2025 05:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yz3P0As2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3651DE3BE
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716112; cv=none; b=PThukVAMb7sFuKxVcgD3wTM4phVJ8rI9r7+ebpAt9DmMUXFw/IDfhBgJzVDETnMraJUzTpjxdg0CH+MqsJFdZpG0+0YGabzIwZ03oS5dGUCpiuwcqMBi79EXkvVi691ZUTMUjUdIFwJpzWnQscUTpYi1EC8GJgP4BnZ2xG+wmR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716112; c=relaxed/simple;
	bh=LDYuA5WJyjvULccdhS0DHdWu2p7tGoJ/eeAWhiaAlrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bj8SEXlQMrLRUboVVGnQOu9JBe5g36Sf1XMNZ4Fxig9ZZalYOFEmmdY0+oe5Ky5U018MFmBrwaWfJieFQcobideyIOiTbWBmhitES6gj23mv2S9buVmE5umygmQde5ClZGVf904vuEv77RefIPDld9g1BbkRQFkgRCwN1dgJYBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yz3P0As2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716109; x=1786252109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LDYuA5WJyjvULccdhS0DHdWu2p7tGoJ/eeAWhiaAlrg=;
  b=Yz3P0As2P7sAAeLgT7nQe+nKKbEUL/+9rKdSGXrRCerJoyPyZVJiAIca
   rTCc2mIWo0r7xKXHBwJCzl+lhPLNxfq7ThXFDqw/086ptM6gsSmcdBYFy
   0XG6Bpx4G8F6WIlomNDg2uKFh3+Gf6iv4ohkTrkI1AR9d2HRIWlbSXqPg
   gjIc3qKxMHdoEmw84F/oRaqsVQVLHKyRLGcXSUZ869pJdp3tCl5EFYIHx
   RipzC73I4/a7J8WSfr1XW9s1QojcqMVZE0c1LndRlkFmT99Paa711cvo0
   L3/AK8mOeiqf6B9FcyzKS+XWq8jtfhVABayP9NRmDhXta4Wem5Y5cg2O/
   Q==;
X-CSE-ConnectionGUID: 1ql6YZT/RpyNFYw0G8nvRg==
X-CSE-MsgGUID: Py+W8Q8/QNGIYDmbtHMFoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="57019866"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57019866"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:08:29 -0700
X-CSE-ConnectionGUID: IcQ9RT+CQgWiji82ikx4LA==
X-CSE-MsgGUID: ojuGhmoFTkKNKnNcd1Z5hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="169704810"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa005.fm.intel.com with ESMTP; 08 Aug 2025 22:08:23 -0700
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
Subject: [RFC PATCH v4 05/28] sched: Add hysteresis to switch a task's preferred LLC
Date: Sat,  9 Aug 2025 13:02:18 +0800
Message-Id: <e51f8a6e172606d520c91c94c0c14b045639217e.1754712565.git.tim.c.chen@linux.intel.com>
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

From: Tim Chen <tim.c.chen@linux.intel.com>

Switching a process's preferred LLC generates lots of task
migrations across LLCs. To avoid frequent switches
of home LLC, implement the following policy:

1. Require a 2x occ change threshold to switch preferred LLC
2. Don't discard preferred LLC for a task

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a7be5c5ecba3..9e3c6f0eb934 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1175,6 +1175,14 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
 #define EPOCH_PERIOD	(HZ/100)	/* 10 ms */
 #define EPOCH_OLD	5		/* 50 ms */
 
+static int llc_id(int cpu)
+{
+	if (cpu < 0)
+		return -1;
+
+	return per_cpu(sd_llc_id, cpu);
+}
+
 void mm_init_sched(struct mm_struct *mm, struct mm_sched __percpu *_pcpu_sched)
 {
 	unsigned long epoch;
@@ -1307,6 +1315,7 @@ static void __no_profile task_cache_work(struct callback_head *work)
 	struct task_struct *p = current;
 	struct mm_struct *mm = p->mm;
 	unsigned long m_a_occ = 0;
+	unsigned long last_m_a_occ = 0;
 	int cpu, m_a_cpu = -1;
 	cpumask_var_t cpus;
 
@@ -1345,11 +1354,13 @@ static void __no_profile task_cache_work(struct callback_head *work)
 					     per_cpu(sd_llc_id, i), occ, m_occ, m_cpu, nr);
 			}
 
-			a_occ /= nr;
+			// a_occ /= nr;
 			if (a_occ > m_a_occ) {
 				m_a_occ = a_occ;
 				m_a_cpu = m_cpu;
 			}
+			if (llc_id(cpu) == llc_id(mm->mm_sched_cpu))
+				last_m_a_occ = a_occ;
 
 			trace_printk("(%d) a_occ: %ld m_a_occ: %ld\n",
 				     per_cpu(sd_llc_id, cpu), a_occ, m_a_occ);
@@ -1363,13 +1374,10 @@ static void __no_profile task_cache_work(struct callback_head *work)
 		}
 	}
 
-	/*
-	 * If the max average cache occupancy is 'small' we don't care.
-	 */
-	if (m_a_occ < (NICE_0_LOAD >> EPOCH_OLD))
-		m_a_cpu = -1;
-
-	mm->mm_sched_cpu = m_a_cpu;
+	if (m_a_occ > (2 * last_m_a_occ)) {
+		/* avoid the bouncing of mm_sched_cpu */
+		mm->mm_sched_cpu = m_a_cpu;
+	}
 
 	free_cpumask_var(cpus);
 }
-- 
2.25.1


