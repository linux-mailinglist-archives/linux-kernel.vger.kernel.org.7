Return-Path: <linux-kernel+bounces-856278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57418BE3B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D04581AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D23A30507B;
	Thu, 16 Oct 2025 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ooemfm4R"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517B198A11
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621680; cv=fail; b=dwZwtl9ldHkJvTSFb/IBYT0UanbDSCbEedQguYWaJ6C6bldTEQ9rKed4N5o2e2SGwxcSnGtipHGyLjnHRtFpmltoCqD3HFGKqzyZysYpCujhFhbaNXemZlJ2An5cXrv46fmk3U5UGJcbSOt7InZtEnBLPcv3IkWd9mY49PXMxPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621680; c=relaxed/simple;
	bh=62lYqp+IW4E96wTZXafMykcFWA4vBjJvqELS14WFOTw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=erbwS6w5xrZlp31meyuBXUbN3lhtCx0R9t10qhRNpK5Hsv8zMpk0dRmleut7MW/hUu9q8H1uONwCGi5oT5S+13DuAnCoYeO/0e687B/X52c+tvxhXhRGa0soIoZ+fthS09xx0E7PWEJenN8ID4ramZfeuQfYJLAGjLgXdHfkFes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ooemfm4R; arc=fail smtp.client-ip=52.101.52.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSGuSwJadS4eHJCwS8FovJw1tyu9Z1l+bo1Zh+P/uYSWa+md+rCV7IuYEOu2ddR6qvxKmODjNBT6A6jMplHxDuIlBCZOAW7Ju8L1UDU5OoH2H3Vyxpa3SvGpkaXP2vVcZfetweOl7ZFK2EwDufWSIrX8HZeiEkoHQpFIRpPv3fWMG6pp/bSYbLuGCd0KIU8VgPWNCSsf+mFUSGwoZ7FHBQfCramyTS19cpcNmyZ/+qMJKJ7VK1aeNe5evgiH/aduGG4eCygyAMBPkp8NAcBelcOr3u14SCfPkWosEmIkLDS/0Zs9UjjvwVIQ3xuaCN1wktNJHSfMP4GG35fHAwzFOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iif4rvbjt+IwaSa4nKPSLkoVly6WhQpcE0JenUjVXGw=;
 b=bkPFyuYx01PkVA0ajmjX1QciJyn0k2sEd+h1khpSJAJBIOwM0z7zTNcMSHYWDn+N/DU1IQJ5YUKX3F7ADMJYRNllwezLhsT/XiRjbeZiS8zC3l3MCqcrXaEqpHUVi5UJG751/BXbi8NrwdtDz7CD/XpT/PeWpwidHeNohaFDEZECG03oviE5Dse6EDy4ohuUSSZVRUAyxNfm+wb3/2cPO1gn6nw3Cb2pl1ohUYy30ST9cFAiPVzLA/eZAzW04BFiup3zxig05K/zDFy1Mygow0ki8DBYHlhfVrQ8zI4l0k5EPJPf/RqRgR90IYuQGIqx1LxhUSJLpEEPnc13ftRQ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iif4rvbjt+IwaSa4nKPSLkoVly6WhQpcE0JenUjVXGw=;
 b=ooemfm4RndON9TIhlJOciEKb668Yn8Tv8wxVwGgDGQBjNM4mybqqZU+7G9pXvOdOaCLOQRKeXXByp4MH733/GPWnJSMmlDckuDbw9agyVZXbWgjGX36GdQsRulXASbOJ3gd/H864wSg1aIKIgFyuo6b+hcJvuhUaq3pObXUrSwY=
Received: from SJ0PR03CA0092.namprd03.prod.outlook.com (2603:10b6:a03:333::7)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 13:34:32 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::33) by SJ0PR03CA0092.outlook.office365.com
 (2603:10b6:a03:333::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Thu,
 16 Oct 2025 13:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 13:34:31 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 06:34:30 -0700
From: Babu Moger <babu.moger@amd.com>
To: <babu.moger@amd.com>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
Subject: [PATCH v2] x86,fs/resctrl: Fix NULL pointer dereference when events force disabled while in mbm_event mode
Date: Thu, 16 Oct 2025 08:34:19 -0500
Message-ID: <a62e6ac063d0693475615edd213d5be5e55443e6.1760560934.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: af40ff6d-7710-47c1-eb67-08de0cb8bd1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7qjVQb9kjrKGWXaYu6NOTpD2tF224KgKPXZfvEktfBtM585vGs/g2UGkh6Xp?=
 =?us-ascii?Q?eQAydUleCfwyP+iGXquNo+KxLs+zIT2lSwldDpyr6/DpcrBqpWpqmDBp54Dl?=
 =?us-ascii?Q?yatbPG2LcZ8vGTgRvVYuqPZ4XpeOvOppwoQhbG4bb1PePRF+X0D4+bJsZO1p?=
 =?us-ascii?Q?A+LeNbr+lEI4h6c8jGy/AqC6LEPRjbYRaBoSNwAkP0CxRmeHZ9s8TC3Rdc2x?=
 =?us-ascii?Q?4+ALs25iyz73iZSuDE9BBE2v+zyAug6ePdOIhgPliQwVm6fkZPW2lyf3zMtV?=
 =?us-ascii?Q?YFlhYmw17JqdLqDS4ybrfMAIqdRqgHGQcwYtwMah5ASnJNMqLcT9Sp1gV6HR?=
 =?us-ascii?Q?5T6g3PeDHoB+C01ICKNGbB06NBN/qGAA6VrmC9QxiU39fTiRv1FCeawgXtUo?=
 =?us-ascii?Q?useflYdAo/xRtZbThQ5YELFoGBh/JaQpFBOT0vr0+HHH13u2iLdC0elvpzIL?=
 =?us-ascii?Q?7jXZZpl54KpyqqDR3rruI3xp40Ng69o4PndZ/tPrV/6264X1boRB1X/CkNEI?=
 =?us-ascii?Q?Hd5eJiJl27YHX4xwLS63eq081Y3RWN9oQnWWt9Otq0nVI/bnyM5cnvSrsZOO?=
 =?us-ascii?Q?3tEz1CdSHLQcCPTEH+hUQM6etOGk1gfvdNUKwHpieDH9yyjonUqQtkMKZOiG?=
 =?us-ascii?Q?WKdUPrkxJU0BL4zaJJ7QVUAS5lT+le2YiezwRfWi18nZVp7So/zX5k8/RpKV?=
 =?us-ascii?Q?GY87KQXusoV4Te8oEv7qfGCt+n3iQrc0tQQhVWrDnHzCWkcI9W0/nf2txwqa?=
 =?us-ascii?Q?xb/5QezjmSv5H4DGmPp29B4urR7zCTkZVgJIsGwSsE3smJHE1EHW4JdW/IeW?=
 =?us-ascii?Q?5d/Nh00s6bzFjBfxgbLbSj1YuA3lKz+hsTkhV2CqkE7dzQ3Lj1QduuwY48SQ?=
 =?us-ascii?Q?cEJlbVMWo4mBIhDXV60FBJNRA1pEKS787gDELzKrHHSYTbijglb1+5vOBCmX?=
 =?us-ascii?Q?oI1iZnNJ1w88XkL8PO1A1GxSOBXqNTQxnqVdb+Rt5JzlXKq9lUMd1doMQ42V?=
 =?us-ascii?Q?C11ia7uP+5IjMfuPqhR5Gzb8o7JpYg3GIhVSvtdSXMXqy/GdkDaLgBKBh4xD?=
 =?us-ascii?Q?/NS1/VeAQZthTkrOe/m3MI3qgFOCx/FYvCMMBwNX4sbtUP1yUoCkmAO8Rrdn?=
 =?us-ascii?Q?Jvx1X+GL5+w7+sUkL8FyGR/k2Ii4aoU+VTmQ3Z6/HMuFj/S8EW88Wyd/TlFo?=
 =?us-ascii?Q?t2scQCZiKC3u2fEmqH0QjrIGsIaQu5jsrdGt/VxpG2oGmOrBZ3Rg5ivda3Yu?=
 =?us-ascii?Q?24Nx4VEhCNHr99G1Do1XMwMM8+QTVkgK0UvOHZemkj5B02QK6DkQCpC8+WqA?=
 =?us-ascii?Q?KciSNv6e+1Hkge8KkHbhFMWeuNjWsyOZQDt00WS0UpohzaRjnPZ+hMWdoAOx?=
 =?us-ascii?Q?T+lfyQ567QS3HZAmmu2h0w7uKkGzcPhCu0sU1ett1YGzGKQkz1Mhc60vkV2S?=
 =?us-ascii?Q?VERnXay0ArMq7+qLdWyCGbb5uhLixBnjrGmu6CcMEdymMfiTOjIP2VUHpFms?=
 =?us-ascii?Q?J/SIRDmOMfJua2iEdw4oO2zpFzqYXS5UtIVl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 13:34:31.7985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af40ff6d-7710-47c1-eb67-08de0cb8bd1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431

The following NULL pointer dereference is encountered on mount of resctrl
fs after booting a system that support assignable counters with the
"rdt=!mbmtotal,!mbmlocal" kernel parameters:

BUG: kernel NULL pointer dereference, address: 0000000000000008
RIP: 0010:mbm_cntr_get
Call Trace:
rdtgroup_assign_cntr_event
rdtgroup_assign_cntrs
rdt_get_tree

Specifying the kernel parameter "rdt=!mbmtotal,!mbmlocal" effectively
disables the legacy X86_FEATURE_CQM_MBM_TOTAL and X86_FEATURE_CQM_MBM_LOCAL
features and thus the MBM events they represent. This results in the
per-domain MBM event related data structures to not be allocated during
resctrl early initialization.

resctrl fs initialization follows by implicitly enabling both MBM total and
local events on a system that supports assignable counters (mbm_event
mode), but this enabling occurs after the per-domain data structures have
been created.

During runtime resctrl fs assumes that an enabled event can access all its
state.  This results in NULL pointer dereference when resctrl attempts to
access the un-allocated structures of an enabled event.

Remove the late MBM event enabling from resctrl fs.

This leaves a problem where the X86_FEATURE_CQM_MBM_TOTAL and
X86_FEATURE_CQM_MBM_LOCAL features may be disabled while assignable
counter (mbm_event) mode is enabled without any events to support.
Switching between the "default" and "mbm_event" mode without any events
is not practical.

Create a dependency between the
X86_FEATURE_CQM_MBM_TOTAL/X86_FEATURE_CQM_MBM_LOCAL and X86_FEATURE_ABMC
(assignable counter) hardware features. An x86 system that supports
assignable counters now requires support of X86_FEATURE_CQM_MBM_TOTAL or
X86_FEATURE_CQM_MBM_LOCAL.  This ensures all needed MBM related data
structures are created before use and that it is only possible to switch
between "default" and "mbm_event" mode when the same events are available
in both modes. This dependency does not exist in the hardware but this
usage of these feature settings work for known systems.

Fixes: 13390861b426e ("x86,fs/resctrl: Detect Assignable Bandwidth Monitoring feature details")
Co-developed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: Added dependancy of X86_FEATURE_CQM_MBM_TOTAL/X86_FEATURE_CQM_MBM_LOCAL for
    X86_FEATURE_ABMC.
    Rephrased changelog from Reinette. Thanks
    Added Fixes, Co-developed-by, Signed-off-by tags.

v1: https://lore.kernel.org/lkml/6082147693739c4514e4a650a62f805956331d51.1759263540.git.babu.moger@amd.com/
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 11 ++++++++++-
 fs/resctrl/monitor.c                  | 16 +++++++---------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 8da3069936be..dffcc8307500 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -459,7 +459,16 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		r->mon.mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
 	}
 
-	if (rdt_cpu_has(X86_FEATURE_ABMC)) {
+	/*
+	 * resctrl assumes a system that supports assignable counters can
+	 * switch to "default" mode. Ensure that there is a "default" mode
+	 * to switch to. This enforces a dependency between the independent
+	 * X86_FEATURE_ABMC and X86_FEATURE_CQM_MBM_TOTAL/X86_FEATURE_CQM_MBM_LOCAL
+	 * hardware features.
+	 */
+	if (rdt_cpu_has(X86_FEATURE_ABMC) &&
+	    (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL) ||
+	     rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL))) {
 		r->mon.mbm_cntr_assignable = true;
 		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 		r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 4076336fbba6..572a9925bd6c 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1782,15 +1782,13 @@ int resctrl_mon_resource_init(void)
 		mba_mbps_default_event = QOS_L3_MBM_TOTAL_EVENT_ID;
 
 	if (r->mon.mbm_cntr_assignable) {
-		if (!resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
-			resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
-		if (!resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
-			resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
-		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg = r->mon.mbm_cfg_mask;
-		mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = r->mon.mbm_cfg_mask &
-								   (READS_TO_LOCAL_MEM |
-								    READS_TO_LOCAL_S_MEM |
-								    NON_TEMP_WRITE_TO_LOCAL_MEM);
+		if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
+			mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg = r->mon.mbm_cfg_mask;
+		if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
+			mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = r->mon.mbm_cfg_mask &
+									   (READS_TO_LOCAL_MEM |
+									    READS_TO_LOCAL_S_MEM |
+									    NON_TEMP_WRITE_TO_LOCAL_MEM);
 		r->mon.mbm_assign_on_mkdir = true;
 		resctrl_file_fflags_init("num_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
-- 
2.34.1


