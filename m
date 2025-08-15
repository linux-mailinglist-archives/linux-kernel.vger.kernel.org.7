Return-Path: <linux-kernel+bounces-770028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B93F8B27609
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F387C189134A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233CF2D3235;
	Fri, 15 Aug 2025 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RlVaahBn"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED0D29B8FE;
	Fri, 15 Aug 2025 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225032; cv=fail; b=I6vsY6bZUOA4FOXFizSPD/P0HVXwlwEzhy9BVYb4E/eOPAT75FmqZx/cwnkU3kUBFDf9lDFwVy8uSQFOMobEk74px55P2B+qBJ/M8SLt3W3Tdw5tUtDOkqnnZrAaI8vkYb+vLlxTyy2MCjo0g6TsGIQf57pSwHuUHb5hGoIcAH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225032; c=relaxed/simple;
	bh=726I3ZZ063dOnLvzAAiheR6dK2W1d6Oo4q2BGFcO6KY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gGFcS9u8IjPAaxdmqapL6cz2rdFwbNrGmsbuKK21u5Lnon2v3/Avqf4Y05am6XFbcQq0YVG2MLNSFy9zLtdruyhfWZ1PfbsXgETLI6k2AE83ukeHPG8feelVtel91d0kvKnROtZOuCdMYR8e8fyUxwQ5katO5a5hhMdo5qeeyR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RlVaahBn; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irm2/j2goiA441T5Hk4Zs3N4m3aJCFXGDmcuCh9vcm54/KpXyAokm+8XtjdxuSDGXpF0/ZD2tVfEp4t3ymHM29em8jB6jDFoVp5znlkpFdRV90qMKoRoD1Dps3elf3NppRacr4h8PBpQoJOcP+0RV2V3UKkAP/4GeiQVZEcQK6SzeegzypkeCAx18TOthNO2VMmBWNzx3c/Ubx2Ed4mlcL9s0oPZcYkAHmN0W+nbq8qPKbPnwHQXsMeYKDlrc0w/ac3TR1sleGCspDkCPMePaJi6quLPcLvPlPq/Y0Nx02aqSGZaYRaXzRkDdifBYlyX3V1J2UbiM/mBApUVSA24NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYDoOhmi2NE1FlbqrDZlfCT842bSx6N7eUjtR0SSETI=;
 b=q272FD+wele7Z7PnCD6JdUw2tl2WPNtEtlnvav91ppz1I8snJTg1wvE2tBZx1B0UKLaPvqRm+R9uelKQ+aDftrKuf1HfB2XAQ/DXh/1KL6oisOiFCidYuoprrklRTOBIIDISmeLqa4O7wkAXY2NYDEvQ9enkR8c2tCAzaFMHuSHkJFq0DE36YgfytxVVvUSUvQdPvNS/vq9gaKLow4MC5xvCZyMvBNidyXa9oTlQapZ7h/vlECwco1WbOwTq5g/fHOVZ+xnIUTHEFWcvRHWzgxw1/5785G2aN0INQeDRccNS4Oy+U97xTZE8sTCLjiX39m1tqTpYwwF/j0qo+dLdYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYDoOhmi2NE1FlbqrDZlfCT842bSx6N7eUjtR0SSETI=;
 b=RlVaahBnOAeOViZyDclS9cQ09TgYqQQB6gQJX/BfDMUkkc5QG4DTM6p8HQG1itTtoNLVs8IoeFsMk3BeziP3WKvpHhNzwDGvNQSxLz7bcDkCr5+XvtBtzV4A760l3Y+3Vv5emrDAR2sxIzKvYplCsil6pr0PWQz633yvdBiFH+c=
Received: from SJ0PR03CA0192.namprd03.prod.outlook.com (2603:10b6:a03:2ef::17)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 02:30:27 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::ab) by SJ0PR03CA0192.outlook.office365.com
 (2603:10b6:a03:2ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 02:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:30:27 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:30:24 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <babu.moger@amd.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<rostedt@goodmis.org>, <paulmck@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <thomas.lendacky@amd.com>,
	<yosry.ahmed@linux.dev>, <xin@zytor.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<mario.limonciello@amd.com>, <xin3.li@intel.com>, <perry.yuan@amd.com>,
	<chang.seok.bae@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<eranian@google.com>, <gautham.shenoy@amd.com>
Subject: [PATCH v17 32/33] x86/resctrl: Configure mbm_event mode if supported
Date: Thu, 14 Aug 2025 21:25:36 -0500
Message-ID: <d134276ad684e324dcecef489db6eea5dfdb8f9d.1755224735.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755224735.git.babu.moger@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|CYXPR12MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad62edc-1335-47a6-bfee-08dddba3b23f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DZipgx97Wh9tdtXKEHRR3JsJDeDkTR1n8LNe8JWQWh9o0AsrQbAYlE4jswIK?=
 =?us-ascii?Q?2hfsuOjvmMeNmn1BdkdpV6uMN97sNMitfKQthy4zEeUn3JxewH9Z+LuJRzG0?=
 =?us-ascii?Q?83iiCZ5Kv9QWnOinlO5njZWa9P3KCHBVvQTpG9dVGZqYrtYb6N0LHKirKyP8?=
 =?us-ascii?Q?wodly0ERC5Nyg46IwliNa5PX2FtfokAdWQ2mFvirsRIr0yAfRw4KHGWKPB9u?=
 =?us-ascii?Q?67K36IpOmu2CVR25eBeBi1sjdH1pXEc19ZxiEkZjzSbg72dWJRT4CAhf/1NK?=
 =?us-ascii?Q?NWX152C8rjUOJg2fvl4igk4t74Wopm8ZcRuYrEQSYouubFcSPqaPf9MZhnCo?=
 =?us-ascii?Q?YlT7cRREvqv7fSofJ603N4Q6+52RNWDFslLXWnH/wIhMHlCFvElctsVttC0F?=
 =?us-ascii?Q?ca0vnWjFd/dH/8MWkV9vlOHsJzG4nI0EUyH5GaMcLVH2wuglyDUFxtHfFV/D?=
 =?us-ascii?Q?cf+Dvq88o+PpxlIeIrjjFjvGgMky8FQEHdJslhhcsaadIVhvrCjDV8DJvriZ?=
 =?us-ascii?Q?2ON3bQONKROC9k8pkh18d+a8ZxQa8RyV5sLuuEW/StvkFP15L1DdVv3m1CQq?=
 =?us-ascii?Q?CjYGW9Ok4oHigO2gxTaVkuYMVXkBoISRBupqI6+dqSdx7AGQyXJfkbqZAZD4?=
 =?us-ascii?Q?yEYB/fzVtkJz0RCrtKi7v8aFx5k/jIwvYZjbuUw2zlWPs8OnF3VnEDOTgz+h?=
 =?us-ascii?Q?qhs4mNCd83DxUtXLq01+4OrT5oWBIejgvHkf6uS6PtGbEksdUjP4HLdFwKzk?=
 =?us-ascii?Q?cK1WcNDj7gzy931jXQuud4/pShGM26eIGvZY7qRpOH2mJwBm/2z+UK4kD9/B?=
 =?us-ascii?Q?+7aLkwm9XZt1cYAN3XuoV0tRCy/1ApmLZl1tKkOjWu+R2p9PkEE/+QbaStrt?=
 =?us-ascii?Q?cUvaAN4I35rv97EMNgfK8Qzw88rax8udkB/qhQbNHCLGme4r83xlQkzQPvM7?=
 =?us-ascii?Q?EAusN4e4y+c1UCE2cYQCyxyS7XqQJEn3HQQ1KTJNrG3gFTN2K+ueg7pj8alW?=
 =?us-ascii?Q?pyrns6tNrwygDWxEdMAJn8pMBzYriGocq7vLKFfzYmqTJkmxhFtVzVqSmrLO?=
 =?us-ascii?Q?gBDQVn9eZIuELN1yM+/ZpLBJEsLAvHn7tZMqSKMq2CV9+TxxZ8JxFBJt+7Bi?=
 =?us-ascii?Q?XPDdtCtyhKkxYfxYTRl2Ag1RSNF20fmlAQVQVDvU2o6MCBkhuIGZ+6HEdmyN?=
 =?us-ascii?Q?c9m2R2f1c8jEfQwvaaJ5xk7E2z3pYLN7qPRJ2QbvCzV9hnBIA/bP8GSc7LeY?=
 =?us-ascii?Q?P5uqaTCV5WE2BAgukYLyEMBfjsj0qZjz0J0n4Nsr0hboIg1FTL/annl706yp?=
 =?us-ascii?Q?9GjTWAaxMLKtFXoSxKRo5GyT4Um1XR5lohX/mW0ndsulFOadX/xsYv6PvOyU?=
 =?us-ascii?Q?c5NCOMyUimbKYd/xSgy3+Yyl7Aw543wF4+rg5dx45FJ/2BDx6wbNpCoENlg7?=
 =?us-ascii?Q?uKv/ofEjz/9SasjBUdEMskFOpGtKzf2rQwrD/B6CLQBD+tampqwcEHHJUtyo?=
 =?us-ascii?Q?7qIz0SAFLH5UQAK1P7kr1djdHUB8RIYx7LeF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:30:27.1815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad62edc-1335-47a6-bfee-08dddba3b23f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317

Configure mbm_event mode on AMD platforms. On AMD platforms, it is
recommended to use the mbm_event mode, if supported, to prevent the
hardware from resetting counters between reads. This can result in
misleading values or display "Unavailable" if no counter is assigned
to the event.

Enable mbm_event mode, known as ABMC (Assignable Bandwidth Monitoring
Counters) on AMD, by default if the system supports it.

Update ABMC across all logical processors within the resctrl domain to
ensure proper functionality.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v17: Updated the changelog to imperative mode.

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
index 2e68aa02ad3f..06ca5a30140c 100644
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
index 0b3c199e9e01..c8945610d455 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -456,6 +456,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		r->mon.mbm_cntr_assignable = true;
 		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 		r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
+		hw_res->mbm_cntr_assign_enabled = true;
 	}
 
 	r->mon_capable = true;
@@ -557,3 +558,10 @@ void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
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


