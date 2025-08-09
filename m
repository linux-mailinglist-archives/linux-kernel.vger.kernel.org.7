Return-Path: <linux-kernel+bounces-760936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6EEB1F22F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612D01AA27FB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 05:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF5C274B39;
	Sat,  9 Aug 2025 05:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7C5KF6q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE9D226CFC
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 05:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754716079; cv=none; b=mzMpUPIBhCIfqgfGYLirSyVew1DiGNGy8kHH9pByDFwjQLg/R08SklG4sqt+h9F0MjNW8uROdXW9EhU0eQGBZx9K4bKZLpb32NTZ568kuQTL5xijzNnbyKAfpI4nekWx9gHcKn2NZrcT76Sz4xJ2qgXu5qqYX/ksmmq4ZH9u+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754716079; c=relaxed/simple;
	bh=57gcT4d4kI048m64jkmqBDrfcowgupEqZQwQ5AEee0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3RQRxzvnj66spzaJhbe9MgqAYCa98AUSZuwljPsRXInxq/Oxk06wgAT2vRlhS0ehsQOQHM82nnzblQnvrJvdVfOkRoSiG94h3cOAWLd5yBkPjkPpHdCL+rW9rkGbaTLW4RhQdXSHhYol4ZYkaUUjpFkZLW21Gb6+B8vqJUbOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7C5KF6q; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754716078; x=1786252078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=57gcT4d4kI048m64jkmqBDrfcowgupEqZQwQ5AEee0w=;
  b=c7C5KF6q/sRDGDVG+lM2wu4H0TzbLyHIoFXYrwK1PhMTWehBhmUrl96S
   T3NkwyIpBdauVKsc3hrNWBirHezNT+Ts0OE7838wAraS+qmqOaNyn/zFO
   uMSRssAaGwLukBsRJhTXc1N5I0Xy/egiTw1fhkKvS4U8SfrTfRWrmwRa3
   RPU4tMB524z4Z6MxtH6azdWGiN57MoFd2/dFpTSaE7cXAWavDizO4/WkF
   yI3XD8KwS9r/rQo9E5DRI45b4Vgd1JhUvkVPHt9fZqza6Nai4EKnx1UNE
   0Vq3A218YIyzDKDxbIwkrtpMqkq0EWb+pBp1au3p6UMfK3D2O6VNQOM+h
   A==;
X-CSE-ConnectionGUID: Fqgj+0eySbSqlUZZn4AFOw==
X-CSE-MsgGUID: Y/ZbdGdBSSKyPLJRd4lBYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="60682928"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="60682928"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 22:07:58 -0700
X-CSE-ConnectionGUID: vDQ06Yc6TseUjHJDDorjIA==
X-CSE-MsgGUID: sVVKpPMjSQmXlszsGV2bRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="170841605"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa005.jf.intel.com with ESMTP; 08 Aug 2025 22:07:52 -0700
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
Subject: [RFC PATCH v4 03/28] sched: Avoid task migration within its preferred LLC
Date: Sat,  9 Aug 2025 13:01:41 +0800
Message-Id: <37376d2072f6175d2fb909a29b66a3da0bcfcce3.1754712565.git.tim.c.chen@linux.intel.com>
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

It was found that when running schbench, there is a
significant amount of in-LLC task migrations, even if
the wakee is woken up on its preferred LLC. This
leads to core-to-core latency and impairs performance.

Inhibit task migration if the wakee is already in its
preferred LLC.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e97ab46509e3..00bd0d25bc91 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8835,6 +8835,8 @@ static int select_cache_cpu(struct task_struct *p, int prev_cpu)
 	if (cpu < 0)
 		return prev_cpu;
 
+	if (cpus_share_cache(cpu, prev_cpu))
+		return prev_cpu;
 
 	if (static_branch_likely(&sched_numa_balancing) &&
 	    __migrate_degrades_locality(p, prev_cpu, cpu, false) > 0) {
-- 
2.25.1


