Return-Path: <linux-kernel+bounces-760937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D84B1F230
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269E5625E86
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58A4226CFC;
	Sat,  9 Aug 2025 05:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCQ9b2gg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029841DC994
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716096; cv=none; b=WeFRqzbJuIG6rs2oBAOGSTvUwR0GN2LxtVKltBBp1IAWJ1/M5927lhVOryPqkDV68MiNoDiPeaUuIGeJXy1yxTNPU+76g8h8o2kq0++bTNlmXdtCkgRKkjAyvo6JUXPfk9qDPu5fNyxlfwrmUYWgRrIiKd3DbVL5bDFDsKlvmIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716096; c=relaxed/simple;
	bh=3Uph+Pq82/wD/SKt6Wb33FmEmMZN7GyPmlnOYYynb0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o3E1Bq0Hs0dTChFZYVm4GVOaPeXcpLPhZZEQJ43VOlsuNVair0TGmjdyd1fLlVjeODS5guLeDmjO76w+loIt+jPuKVqUMOnTWw1sIHx/QjCLlCjeJzEknh9dFn7KMZ1m1CPRGI1DknlEPNf/b1KDvycj+UhJPpZyr/+EIpZ7wE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCQ9b2gg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716095; x=1786252095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Uph+Pq82/wD/SKt6Wb33FmEmMZN7GyPmlnOYYynb0Q=;
  b=KCQ9b2ggnvTfhFeV/E50fpZUEEpmBsHHnpwH10t35fPh5GZQ4EVxbF9O
   iwfbtGzsyddng/NZIteqbsCZ21Nl1B6x7QxI9972j42g46j13xjdwRoZ3
   8A5ColX2OkCXP0fikLLx5ox8/8xMCGNiAOuHNT4EVTgK2VkSLTjB4x6k2
   OuuokNSBejb3QbstBidVgae5eMr6rPiKsjUpKeIv2M/QgpCk+dAN8C98Z
   9hQOg7BYjmAjMdUmUQXdfIf7u4hNaX6qUCPOtPPWVhaIxMAKXUR8DS4hA
   yBD3fm5G5+abwatbqRE6FgrAva6LfJ6mMuAuKCPYQ9SPgzZrUlqukRs7B
   A==;
X-CSE-ConnectionGUID: 2W0v7dR/SgiRTYDXa05aZw==
X-CSE-MsgGUID: hTr8aLcoRrKUtcFs+hv2jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="60682947"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="60682947"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:08:15 -0700
X-CSE-ConnectionGUID: /DUYqfzETGitdTxBYN+2cg==
X-CSE-MsgGUID: /4qu8b2ATfih1n9Fc4FHNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="170841644"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa005.jf.intel.com with ESMTP; 08 Aug 2025 22:08:09 -0700
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
Subject: [RFC PATCH v4 04/28] sched: Avoid calculating the cpumask if the system is overloaded
Date: Sat,  9 Aug 2025 13:02:04 +0800
Message-Id: <88d1c3bc1e817cc72346f566153a4618604b9ecd.1754712565.git.tim.c.chen@linux.intel.com>
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

From: K Prateek Nayak <kprateek.nayak@amd.com>

If SIS_UTIL terminates the search for idle CPUs, the result of
cpumask_and() becomes irrelevant. Given that select_idle_cpu()
may now be invoked twice per wake-up within select_idle_sibling()
due to cache-aware wake-ups, this overhead can be observed in
benchmarks such as hackbench.

To conserve additional cycles-particularly in scenarios where
the LLC is frequently targeted and the search aborts because
the LLC is busy - calculate the cpumask only when the system is
not overloaded.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 00bd0d25bc91..a7be5c5ecba3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7940,8 +7940,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
 	struct sched_domain_shared *sd_share;
 
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
-
 	if (sched_feat(SIS_UTIL)) {
 		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
 		if (sd_share) {
@@ -7953,6 +7951,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 	}
 
+	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+
 	if (static_branch_unlikely(&sched_cluster_active)) {
 		struct sched_group *sg = sd->groups;
 
-- 
2.25.1


