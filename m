Return-Path: <linux-kernel+bounces-849251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E53EEBCFAB5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75FB04E728B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C79E28B501;
	Sat, 11 Oct 2025 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lw7L05el"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118912877EE
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206714; cv=none; b=Sgvo8eIzN/unUNmW2/+OixP9udhyNkmi4AZEZzDVPWK1PLnNoYAhA0isU11HgcQC7ul1i5aP8jgG2uHE7Cy8Asrdz+Y08qynhym2Y4X0S+xgTgNOkVzp41IhyzMl092I4cMjY7ziOvFvK6idsHZ/FR3VwQydRvg8d5aWYp64rpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206714; c=relaxed/simple;
	bh=HpgwI4hDixtTD/XOc2H/Ob5dO6FbxoYzkh6tbeLAGPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TyYasSHPSqMZlN51+4bjWq8Z7cAg9IakiA1ZSJzbhlx8KJc6/UktRCAzZaEkZtQ3d+2B5EUSEDoefcCsbcoCPxFRSCAzN4VD9lBw94R0aIvRHbenlFVxgsvkmUCy9pzg5jZh5zHq/4CLUC+EDPmK622ZE8JNMYgUcZgPpxmosck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lw7L05el; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760206713; x=1791742713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HpgwI4hDixtTD/XOc2H/Ob5dO6FbxoYzkh6tbeLAGPw=;
  b=Lw7L05elkbwdOCxozPfNxC8qRTe1i2iYshjZC2z6ZaIHRqDa3MmTXW5p
   zHG6+auYcjgaRRcY16sdCyIbi7MCQxhd1rhIdaLh0bWrCs4ImE5P1VD8f
   E+1GcTkJVgNbzLAR5f6+G7KZsA/sstlz5uIOTmFm5WpAXCY87MaYrAMAn
   AO+uoYvLDh1ME4/gSK2T7C+P7K4lX/jQuif20ZGD72jW5wnQNob4g08JW
   Z2MLtsd0WXxmCEXIKBfa0mtDIGY2FVs5/FvLd831/0grQYgT8vo1t80Kc
   spuxB5OU6NgYwRfX7rKRRiLNfth6YUS68l+iwJeWbASwMAqE6PVWIEmJu
   Q==;
X-CSE-ConnectionGUID: eDbtoCrOQHyIZtGmIsjSMQ==
X-CSE-MsgGUID: +ry6w/ChQZGrUwocr7gK9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62339887"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62339887"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2025 11:18:33 -0700
X-CSE-ConnectionGUID: 1LsFjRblTkmkQu9Zwyc6pQ==
X-CSE-MsgGUID: 7olPURVrSrW53T9U5Kz7mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,221,1754982000"; 
   d="scan'208";a="185487247"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2025 11:18:32 -0700
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jianyong Wu <jianyong.wu@outlook.com>,
	Yangyu Chen <cyy@cyyself.name>,
	Tingyin Duan <tingyin.duan@gmail.com>,
	Vern Hao <vernhao@tencent.com>,
	Len Brown <len.brown@intel.com>,
	Aubrey Li <aubrey.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Chen Yu <yu.chen.surf@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Libo Chen <libo.chen@oracle.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Tim Chen <tim.c.chen@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/19] sched/fair: Respect LLC preference in task migration and detach
Date: Sat, 11 Oct 2025 11:24:52 -0700
Message-Id: <d3afcff5622222523c843f5c1b023bfe43f9c67c.1760206683.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1760206683.git.tim.c.chen@linux.intel.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the final step of load balancing, can_migrate_task() now
considers a task's LLC preference before moving it out of its
preferred LLC.

Additionally, add checks in detach_tasks() to prevent selecting tasks
that prefer their current LLC.

Co-developed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0fafbfedb21d..65ff7c306a2f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9801,8 +9801,8 @@ static enum llc_mig can_migrate_llc(int src_cpu, int dst_cpu,
  * Check if task p can migrate from src_cpu to dst_cpu
  * in terms of cache aware load balance.
  */
-static __maybe_unused enum llc_mig can_migrate_llc_task(int src_cpu, int dst_cpu,
-							struct task_struct *p)
+static enum llc_mig can_migrate_llc_task(int src_cpu, int dst_cpu,
+					 struct task_struct *p)
 {
 	struct mm_struct *mm;
 	bool to_pref;
@@ -9969,6 +9969,12 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (env->flags & LBF_ACTIVE_LB)
 		return 1;
 
+#ifdef CONFIG_SCHED_CACHE
+	if (sched_cache_enabled() &&
+	    can_migrate_llc_task(env->src_cpu, env->dst_cpu, p) == mig_forbid)
+		return 0;
+#endif
+
 	degrades = migrate_degrades_locality(p, env);
 	if (!degrades)
 		hot = task_hot(p, env);
@@ -10227,6 +10233,20 @@ static int detach_tasks(struct lb_env *env)
 		if (env->imbalance <= 0)
 			break;
 
+#ifdef CONFIG_SCHED_CACHE
+		/*
+		 * Don't detach more tasks if the remaining tasks want
+		 * to stay. We know the remaining tasks all prefer the
+		 * current LLC, because after order_tasks_by_llc(), the
+		 * tasks that prefer the current LLC are at the tail of
+		 * the list. The inhibition of detachment is to avoid too
+		 * many tasks being migrated out of the preferred LLC.
+		 */
+		if (sched_cache_enabled() && detached && p->preferred_llc != -1 &&
+		    llc_id(env->src_cpu) == p->preferred_llc)
+			break;
+#endif
+
 		continue;
 next:
 		if (p->sched_task_hot)
-- 
2.32.0


