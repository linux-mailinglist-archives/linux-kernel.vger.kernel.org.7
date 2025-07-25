Return-Path: <linux-kernel+bounces-746197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 116CEB1241A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2201CE6C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E38C254849;
	Fri, 25 Jul 2025 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ElH5/3bq"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3777B252917;
	Fri, 25 Jul 2025 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468562; cv=fail; b=h398oFTKUXtQIqn5VgFZuCAtcwnqY66cUcVteAISNCOQFGcvJoZvNYj01O3a9vZ7kT2VA7r2uux4zuiACP6jCp5b4CuoztQcHoJnFodafeoL4o4ZJGr/JTc0VN5UzIISLfzSdYgfH6HioyOW9F2brvK4pk1g7L9zvnn3nIXFv6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468562; c=relaxed/simple;
	bh=Lm74TRrGKd5Edx0ZcslLOv+8js6UqfTZZMSlNOPChFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMxrHSpN4mwhajYXLuGxIqXZAotuxjkd8l+sRtdG4AW1S7qKdQUuczHzOmTwMwnPOePYMBRMEBM1cPnT8uwqwzLF+wlqaV8qvWKdgzSu1lEZ/LRMskaH9pqQbV43pgRjryZzoZDciAmcf6z/dpzYJJtpmJkubQTTyTBGxIA0cao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ElH5/3bq; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gR36x1lxzDWYWBwzc3KWG1S45dHofZ7DKSKSJAPhEwAAmMfJ0BTMiY57BtoBagxPCSyXp/sN69vE6r7MTenkkN8twpOH0HQYjrr8IJjg5lj8D/tFxs70yfbtGkzq189gXpLHKDmtg3wq8Q80RGma88NYVAfVUN+RCRQNfh7Ma1xTe8RtCcV1QSlV3m242Y9zMOV+UKdGigzPeVI1vRMr8X0Tbrpdx69Xhloj291qpABv5l/9roxYp4Ol8MrBo+nW1OtRzhzAXH2YypjeIyPW2P7dc48TRK1JoKVk+gg3omNNmZ3cpwOSCrfV52kBYdd6qR2nOZCLChpV3J4gMuSiuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RQuBbfcOm+gSk/9wiCAqs69NRBp3EJ3sPNGnqGvlJA=;
 b=gQw598yOOnS7sw5CBgK/xsCd8paFrG0Bcs3NpLb5TKzLlN4KbT+CgZo0HVodM4ma581Y13zXkXFl9muLactj1JQNvPfl7DpcxRD7PiicdhNBse9WKbam1FoTGv2Omg/M1AHc8gxbaIjEGDGBHJqKuaxCHxq/2skdyeYHq2E5Rs6N/Rbqvi/U9I+kF4sdrty/jKMn4QvveoNHIIpGnhbcME3WurVTU8k6yExGv3Km/vG7SYFu+NJalBPQxSfvdpqp+Fh9USJFF03zPjAMbebZzT2Co/1M1EGYJwJWMwt/f+OmTW5chviy15WRsJyGEXkY+fjDOioebSFACedIMGYnJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RQuBbfcOm+gSk/9wiCAqs69NRBp3EJ3sPNGnqGvlJA=;
 b=ElH5/3bqj85Wbi8jBEsKOHuhJVn83ociKK5PQua5Yan7O4aejc8cX1zzVKoyyrIg0hMxAt+0dVNJxxbMPtAvVRrJe8gpIgLU8qnO0r0IfzrBjDyd4wmUL4K6W65ammeA7SAb9HyZ1yjCk6GZtrZxdRwVqKHMo9O+k8VQIIxxliU=
Received: from SJ0PR13CA0035.namprd13.prod.outlook.com (2603:10b6:a03:2c2::10)
 by LV9PR12MB9806.namprd12.prod.outlook.com (2603:10b6:408:2ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 18:35:57 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::70) by SJ0PR13CA0035.outlook.office365.com
 (2603:10b6:a03:2c2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.15 via Frontend Transport; Fri,
 25 Jul 2025 18:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:35:55 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:35:52 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <babu.moger@amd.com>, <tao1.su@linux.intel.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
Subject: [PATCH v16 33/34] x86/resctrl: Configure mbm_event mode if supported
Date: Fri, 25 Jul 2025 13:29:52 -0500
Message-ID: <dff9af435f3103a2e3750a563c753f65658dfebc.1753467772.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1753467772.git.babu.moger@amd.com>
References: <cover.1753467772.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|LV9PR12MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c5eb72-070d-4104-d1a8-08ddcbaa175a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OFB38k5tHCoXL6UWZnQ+GJU6uWLZVGPYl2lGJRSkTUYFKcTmON0pDowtLpZ+?=
 =?us-ascii?Q?ZtcwgqAIewKDQHCFzWe0ElptHiEIrq8rQIMTg9DHQZeA15tsAjsiYLzdztAI?=
 =?us-ascii?Q?Q5S/R4uRr+a+A6eUHj8pWnP6texPlckGVrFIZWelIW+N245Vmcm1vJk7VUoM?=
 =?us-ascii?Q?aqHN1xf0X4SHukyNS0nD6UhUr8VrH3Y8TZBBE/ggFyEodQgNjXwPkqzuZtn4?=
 =?us-ascii?Q?mwOhSz2fmMDkwPsyIq++gxQUB0Oqx3H4v7mC27oiQ1r3RM5NTPmvFG5tt8Ff?=
 =?us-ascii?Q?8pI04TpjBbTM1N8Y6tOjZaaEt7zHrbzV0U5AIFRzi96QQzQFdKOZKmqva+gn?=
 =?us-ascii?Q?lqv0Go0ab5k5BkqK0yxQUQgXvWKhiZCRcPK2Bb76B3duQv7Gq/30xVvt2mB9?=
 =?us-ascii?Q?8AgEt60iGKAvl2tjBKjkd6ZI2eXaLnC0FzPCRN5jxGrwJ2r3Vj8hsmkICK6S?=
 =?us-ascii?Q?bLXjyvu7Hdb9ftj/sjoPNOeo7yrzvVnclPrYkLjKP0Y1PWYZ8pTuIYDzBqxp?=
 =?us-ascii?Q?Jp+F1EL0JRC/EnAyH/K4vKqr6sM//t3sxBOEQKVmLRJRto9qDARohpAz72qH?=
 =?us-ascii?Q?zqvuJQzMwuKmP9a4YUYpmPtRyiBVZu9/H297+kqy/tdxsZtx6u7XYjtpCtJO?=
 =?us-ascii?Q?AgHuasQaVG0+cZjl1ZPsDXHPKpAGOhkx1VJKU8Qq/Jt3MeVhd/KUuhYTZQCU?=
 =?us-ascii?Q?JXa3YXyNbLwyx+vcaEQuBRPrEGZqFOBKnve7FzhLRpH4PuJf83JluRGN7W4i?=
 =?us-ascii?Q?hRCF49BCrhCx/fUGpM6dwGwNMxSW5ee2VH63csJBVSltN8AFD3KpB5ci80Py?=
 =?us-ascii?Q?MehTgOII0ENbhuiGNSFGB+w0T4vLQjU+Y5exMotu2b9B34p0t5PlnA/LjECO?=
 =?us-ascii?Q?83f+Ffw7b0k6yKC95j2pHShbjECKLAtQHsS5kuafnk+GBCe5d1I6ihvwjQ+x?=
 =?us-ascii?Q?ztjZ12HmygWM/Mt9c2gkj68PvXNDlHzKUMit9Y4Lcj4mWNiWfP4O/1jm0R3e?=
 =?us-ascii?Q?bydl5+JwmBvlvgFB/eJ49sNcRz41u5IwJ40lP8nrNapBFcrPDBfcL+4Xhd0h?=
 =?us-ascii?Q?5EDplLrhAHQuaPQlXH/clfHNTO69En1171KGJVf2uESJyHLbwTowxJNhgo5I?=
 =?us-ascii?Q?s7Syd9AUv6PMM7kXmQH0SFQ+kJ9tCLzDQ4vbNOwRNZmoCmlBABZSBUQvxjuh?=
 =?us-ascii?Q?4s+zKPfiTVPfZ/0S7MZshJ1ZEHu45YkdST5nA4QGQq59bjyeIN31YA3fkF6U?=
 =?us-ascii?Q?D/xqZr1xB66pnR4EY2QXlocQC8QGaATnVfR6w35U8d0mZlOJwUtmDV94VDSc?=
 =?us-ascii?Q?c5DDyXV2U+Aup3QFtkY387XZop01tDuJrl0Ta80QVGimaezvNjvVC9IjTLt0?=
 =?us-ascii?Q?wQeTdQ07ruJ4bKJAngmIfN/TcfC/1Qm8hz5h0FVSBpF7a53SeTbgwnr4pM9j?=
 =?us-ascii?Q?gLtqf8JYEh96Mm9nIBt6IM+rnEyFPKGO9y9dUI3LbM6x79Hwjf11gZEsqfmF?=
 =?us-ascii?Q?OYdNY1ZLAyrMqTb2p7K/fBlXztIxAvIo2Stb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:35:55.2304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c5eb72-070d-4104-d1a8-08ddcbaa175a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9806

Configure mbm_event mode on AMD platforms. On AMD platforms, it is
recommended to use the mbm_event mode, if supported, to prevent the
hardware from resetting counters between reads. This can result in
misleading values or display "Unavailable" if no counter is assigned
to the event.

The mbm_event mode, referred to as ABMC (Assignable Bandwidth Monitoring
Counters) on AMD, is enabled by default when supported by the system.

Update ABMC across all logical processors within the resctrl domain to
ensure proper functionality.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v16: Fixed a minor conflict in arch/x86/kernel/cpu/resctrl/monitor.c.

v15: Minor comment update.

v14: Updated the changelog to reflect the change in name of the monitor mode
     to mbm_event.

v13 : Added the call resctrl_init_evt_configuration() to setup the event
      configuration during init.
      Resolved conflicts caused by the recent FS/ARCH code restructure.

v12: Moved the resctrl_arch_mbm_cntr_assign_set_one to domain_add_cpu_mon().
     Updated the commit log.

v11: Commit text in imperative tone. Added few more details.
     Moved resctrl_arch_mbm_cntr_assign_set_one() to monitor.c.

v10: Commit text in imperative tone.

v9: Minor code change due to merge. Actual code did not change.

v8: Renamed resctrl_arch_mbm_cntr_assign_configure to
        resctrl_arch_mbm_cntr_assign_set_one.
    Adde r->mon_capable check.
    Commit message update.

v7: Introduced resctrl_arch_mbm_cntr_assign_configure() to configure.
    Moved the default settings to rdt_get_mon_l3_config(). It should be
    done before the hotplug handler is called. It cannot be done at
    rdtgroup_init().

v6: Keeping the default enablement in arch init code for now.
     This may need some discussion.
     Renamed resctrl_arch_configure_abmc to resctrl_arch_mbm_cntr_assign_configure.

v5: New patch to enable ABMC by default.
---
 arch/x86/kernel/cpu/resctrl/core.c     | 7 +++++++
 arch/x86/kernel/cpu/resctrl/internal.h | 1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 09cb5a70b1cb..bb707a762c53 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -520,6 +520,9 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 		d = container_of(hdr, struct rdt_mon_domain, hdr);
 
 		cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
+		/* Update the mbm_assign_mode state for the CPU if supported */
+		if (r->mon.mbm_cntr_assignable)
+			resctrl_arch_mbm_cntr_assign_set_one(r);
 		return;
 	}
 
@@ -539,6 +542,10 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 	d->ci_id = ci->id;
 	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
 
+	/* Update the mbm_assign_mode state for the CPU if supported */
+	if (r->mon.mbm_cntr_assignable)
+		resctrl_arch_mbm_cntr_assign_set_one(r);
+
 	arch_mon_domain_online(r, d);
 
 	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ae4003d44df4..ee81c2d3f058 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -215,5 +215,6 @@ bool rdt_cpu_has(int flag);
 void __init intel_rdt_mbm_apply_quirk(void);
 
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
+void resctrl_arch_mbm_cntr_assign_set_one(struct rdt_resource *r);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 57c8409a8247..61c0ac5f0be1 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -455,6 +455,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		r->mon.mbm_cntr_assignable = true;
 		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 		r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
+		hw_res->mbm_cntr_assign_enabled = true;
 	}
 
 	r->mon_capable = true;
@@ -556,3 +557,10 @@ void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
 	if (am)
 		memset(am, 0, sizeof(*am));
 }
+
+void resctrl_arch_mbm_cntr_assign_set_one(struct rdt_resource *r)
+{
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+
+	resctrl_abmc_set_one_amd(&hw_res->mbm_cntr_assign_enabled);
+}
-- 
2.34.1


