Return-Path: <linux-kernel+bounces-782665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E7FB32360
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2D91D61FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FDF2D77F6;
	Fri, 22 Aug 2025 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFOpc0BF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A182D73A8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755893246; cv=none; b=SwAzA6PZLkgb5T6GOKYmF9hB2sFYUiey0AQ1LndkSSuDtZjThxBXDsuuc1ncFvAzOJxroB5lEVnBNuYNeACg8WGtAgfOo/17AMa4s9zadwnQELzJ3HosGmtgsshpK7UJ4PysUL0F/YoJJQgcjScEjyE0KxGkP9LyylHjsR66EhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755893246; c=relaxed/simple;
	bh=K1xO6OVdfZLN64K8WYoauH/p+w/Rnsz0IbsLKltW1mw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QTcFjQBUsZu5tbeiwpfVLp06ktJjl1xay7Xv66sm1qdhTurptWcwdCO4dkvfv8W4ol5s7L1m2rFmzi0ZuKVPl1C2/xQnLKV4qb3NICOF71eaFnG9yxLYo4Kf19dtTaWgqbm39JKgkjTPxgR0c34EJP92vZmRqXJIPVNkCgi+ZDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFOpc0BF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755893245; x=1787429245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K1xO6OVdfZLN64K8WYoauH/p+w/Rnsz0IbsLKltW1mw=;
  b=cFOpc0BFLeaSiBBeuxx9d92bPpqE5Yo8OPFbUWLNcmfyE3+qQ3jw+wxq
   78g32mi78UhMBpDqPUy6v0Qcf8WpI4aoJwYsbProQndJGBwNjqqzQpq9Y
   veqRfeXqahkzKZLTWnZbOdtPJSSglVl6Om+jeyLli4SKXMlU/cazzYxpG
   +tj8gSLn+hDlQoABjQLtgyCCzMR5+roksvdBjBtFY8ovF14280kFjvygG
   v4tdUk6xMUiZbBLIxNuvlajiNC7VeswP2X+jzpplocfRQ1FyeA3RLHdEP
   8pSaR0ahWYzs80fYQk3nHKlzxWYiJmNs1MegUhH9yWjENtt0nYVte/6UO
   A==;
X-CSE-ConnectionGUID: O12tynCgQtKkcWYJRVJ4gQ==
X-CSE-MsgGUID: klVaZd4WQ4iM8wVHCC0l2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57224574"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="57224574"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 13:07:24 -0700
X-CSE-ConnectionGUID: 3nPKAdBVTNaieprWEs8c5g==
X-CSE-MsgGUID: UNpFSBnNRO6H2hNoWvo1FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="169145749"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmviesa008.fm.intel.com with ESMTP; 22 Aug 2025 13:07:21 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Libo Chen <libo.chen@oracle.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Len Brown <len.brown@intel.com>,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH 1/2] sched: topology: Fix topology validation error
Date: Fri, 22 Aug 2025 13:14:14 -0700
Message-Id: <a3de98387abad28592e6ab591f3ff6107fe01dc1.1755893468.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1755893468.git.tim.c.chen@linux.intel.com>
References: <cover.1755893468.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

As sd_numa_mask() (the function behind tl->mask() for the NUMA levels
of the topology) depends on the value of sched_domains_curr_level,
it's possible to be iterating over a level while, sd_numa_mask()
thinks we are in another, causing the topology validation to fail (for
valid cases).

Set sched_domains_curr_level to the current topology level while
iterating.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/topology.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 977e133bb8a4..9a7ac67e3d63 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2394,6 +2394,14 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
 	for_each_sd_topology(tl) {
 		int tl_common_flags = 0;
 
+#ifdef CONFIG_NUMA
+		/*
+		 * sd_numa_mask() (one of the possible values of
+		 * tl->mask()) depends on the current level to work
+		 * correctly.
+		 */
+		sched_domains_curr_level = tl->numa_level;
+#endif
 		if (tl->sd_flags)
 			tl_common_flags = (*tl->sd_flags)();
 
-- 
2.32.0


