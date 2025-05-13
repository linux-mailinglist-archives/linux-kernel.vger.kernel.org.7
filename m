Return-Path: <linux-kernel+bounces-646314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CABABAB5AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 19:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0113B19E42D2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 17:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3251F2BF97C;
	Tue, 13 May 2025 17:17:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9612BF971
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747156621; cv=none; b=rnEqKx4HvrkRiP0XBRvn03lD7tSDOOLxla6hoeAHrNssgu6xmXgjH3eO3Ur4ABCiUsgO4ShmMPrWJ3kfyL7xpjn5aw8FvHf6g7gBVRDUr9+8kN3YaT++2YvLt4x8fFQCn8bI3YqcuxSiEdw2wfIHgAOaNrvtBUO+xSvFOM52BSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747156621; c=relaxed/simple;
	bh=mcJd5C1rmbVrBcpQDYtUkxevYUugjUYjzGHY+My/GS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KU55o+puoaGk7KNpxFBTK5yxzzMUda1tOvrKZF7lXcoV3v75bs4O1mIWCR4aeE1KB6hQ4czDTLuTZMGkUoFChfVgnnopq/6GyXvtzMHrN4oTrK3T3TEteaumEN3FuekZOp2MV+D+GD1919v9Y0L2sP35l6ORsJ+R+DBjrtI6QtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3764D293F;
	Tue, 13 May 2025 10:16:48 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF6893F63F;
	Tue, 13 May 2025 10:16:55 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Babu Moger <babu.moger@amd.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v11 09/30] x86/resctrl: Drop __init/__exit on assorted symbols
Date: Tue, 13 May 2025 17:15:26 +0000
Message-Id: <20250513171547.15194-10-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250513171547.15194-1-james.morse@arm.com>
References: <20250513171547.15194-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because ARM's MPAM controls are probed using MMIO, resctrl can't be
initialised until enough CPUs are online to have determined the
system-wide supported num_closid. Arm64 also supports 'late onlined
secondaries', where only a subset of CPUs are online during boot.

These two combine to mean the MPAM driver may not be able to initialise
resctrl until user-space has brought 'enough' CPUs online.

To allow MPAM to initialise resctrl after __init text has been free'd,
remove all the __init markings from resctrl.

The existing __exit markings cause these functions to be removed by the
linker as it has never been possible to build resctrl as a module. MPAM
has an error interrupt which causes the driver to reset and disable
itself. Remove the __exit markings to allow the MPAM driver to tear down
resctrl when an error occurs.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
---
Changes since v8:
 * Removed __exit from a new symbol.

Changes since v4:
 * Earlier __init marker removal migrated here.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 6 +++---
 arch/x86/kernel/cpu/resctrl/internal.h | 4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 ++++----
 include/linux/resctrl.h                | 6 +++---
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index cf29681d01e0..31538c65d9a2 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -737,7 +737,7 @@ struct rdt_options {
 	bool	force_off, force_on;
 };
 
-static struct rdt_options rdt_options[]  __initdata = {
+static struct rdt_options rdt_options[]  __ro_after_init = {
 	RDT_OPT(RDT_FLAG_CMT,	    "cmt",	X86_FEATURE_CQM_OCCUP_LLC),
 	RDT_OPT(RDT_FLAG_MBM_TOTAL, "mbmtotal", X86_FEATURE_CQM_MBM_TOTAL),
 	RDT_OPT(RDT_FLAG_MBM_LOCAL, "mbmlocal", X86_FEATURE_CQM_MBM_LOCAL),
@@ -777,7 +777,7 @@ static int __init set_rdt_options(char *str)
 }
 __setup("rdt", set_rdt_options);
 
-bool __init rdt_cpu_has(int flag)
+bool rdt_cpu_has(int flag)
 {
 	bool ret = boot_cpu_has(flag);
 	struct rdt_options *o;
@@ -797,7 +797,7 @@ bool __init rdt_cpu_has(int flag)
 	return ret;
 }
 
-__init bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
+bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
 {
 	if (!rdt_cpu_has(X86_FEATURE_BMEC))
 		return false;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 25b61e466715..576383a808a2 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -472,13 +472,13 @@ int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
 void resctrl_mon_resource_exit(void);
-bool __init rdt_cpu_has(int flag);
+bool rdt_cpu_has(int flag);
 void mon_event_count(void *info);
 int rdtgroup_mondata_show(struct seq_file *m, void *arg);
 void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 		    cpumask_t *cpumask, int evtid, int first);
-int __init resctrl_mon_resource_init(void);
+int resctrl_mon_resource_init(void);
 void mbm_setup_overflow_handler(struct rdt_mon_domain *dom,
 				unsigned long delay_ms,
 				int exclude_cpu);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index a93ed7d2a160..73e3fe4f4c87 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1204,7 +1204,7 @@ static __init int snc_get_config(void)
  *
  * Returns 0 for success, or -ENOMEM.
  */
-int __init resctrl_mon_resource_init(void)
+int resctrl_mon_resource_init(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 	int ret;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1e48c61db2aa..cfd846cc861e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -4144,7 +4144,7 @@ static void rdtgroup_destroy_root(void)
 	rdtgroup_default.kn = NULL;
 }
 
-static void __init rdtgroup_setup_default(void)
+static void rdtgroup_setup_default(void)
 {
 	mutex_lock(&rdtgroup_mutex);
 
@@ -4376,7 +4376,7 @@ void resctrl_offline_cpu(unsigned int cpu)
  *
  * Return: 0 on success or -errno
  */
-int __init resctrl_init(void)
+int resctrl_init(void)
 {
 	int ret = 0;
 
@@ -4433,7 +4433,7 @@ int __init resctrl_init(void)
 	return ret;
 }
 
-static bool __exit resctrl_online_domains_exist(void)
+static bool resctrl_online_domains_exist(void)
 {
 	struct rdt_resource *r;
 
@@ -4471,7 +4471,7 @@ static bool __exit resctrl_online_domains_exist(void)
  * resctrl_arch_get_resource() must continue to return struct rdt_resources
  * with the correct rid field to ensure the filesystem can be unmounted.
  */
-void __exit resctrl_exit(void)
+void resctrl_exit(void)
 {
 	cpus_read_lock();
 	WARN_ON_ONCE(resctrl_online_domains_exist());
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 880351ca3dfc..b8f8240050b4 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -358,7 +358,7 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 u32 resctrl_arch_system_num_rmid_idx(void);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
-__init bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
+bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
 
 /**
  * resctrl_arch_mon_event_config_write() - Write the config for an event.
@@ -514,7 +514,7 @@ void resctrl_arch_reset_all_ctrls(struct rdt_resource *r);
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
-int __init resctrl_init(void);
-void __exit resctrl_exit(void);
+int resctrl_init(void);
+void resctrl_exit(void);
 
 #endif /* _RESCTRL_H */
-- 
2.39.5


