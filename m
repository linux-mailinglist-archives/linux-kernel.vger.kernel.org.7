Return-Path: <linux-kernel+bounces-746166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142ECB123D1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8CB565FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D4224DD1E;
	Fri, 25 Jul 2025 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I6c2LJc2"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C758F2475C3;
	Fri, 25 Jul 2025 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468252; cv=fail; b=RIPyRzgxGd4zgSHo1ksLwNc6Xb2EEheX22o13BWb4tHNHYUgXkwJlBQepiJC7h7SKYEXqmmhSJHrMGaL5vfGgUSPRAfxqQZ2ItiQy3EmRwJ4aTzdtucl2Yy1JV0TKt2eKPldpkqJ50IgWoU6tqJiLQd5vsUDbCTTM7eOQFyhfZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468252; c=relaxed/simple;
	bh=1Dlt2pjwv5WsT3iy447fj6RIgAQoJZRdm0aBdUQT6+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/A1f19hIq9Co34HK30j+y5UpnB/1kkg9S8bT08g+afX7vRTRoSLQ51Ypi/SIwtkOGE01X79Hz8GF9Nv9JzL/oXmfxWAU4sLOGUdUdoRhirQkdYhMcy2WxqRWs9XlDZcDfr/z2G6gukbB08Y56gNDecdczYZZwFX5wcyDMbBDQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I6c2LJc2; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsiSJWC7A+NQLakhwGB85pBFWwLuetURdld8mHbecmHfX19ho0+ohK560z3mfDZW0wB4sss3pQFpKUM2QBaqO+hbIKvgEVEDUZC8Ac0Uu3hSnV2C2A7agDsjqXk+dv2Ct6ZR7WhI+D1BPQpGn9PYFfYoUd0Z5b4dJOep0hR3UbqzRagU59b72NVuCgVhANTWTFQ8NRyQSDGw9M5H9WePfc26pJYmNvRrbOo7EMuVEUxIA2s6QtCDJS+G3LygyOoS8dU81jhJ8RN8GcsMO7Ej1H+l63Wof9tp/wVU/yf4pobQWTQihkaFlrvqMCe/yIxLqgwc315DnQvZFuTMeSmnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeEL8F0c08m7nJP0X4MJwXUuWM9D8i1rH1SX1Hc7ceE=;
 b=FzPq8mKddLItWAKx4pWo+O6xg+5XxYt8VnQ+vLuOAaHGrIVwso7R3cHmeUBZxST8bxPbytfN8+dRWBnCpppXSowMTZ/r41pdhKUTitATodI3Ra7JfHZqSnN5QmZPadEDRJkAslw5purb+wOCnduLTc5busqc+f1tV2mdzZwrH2J6frWZ9FXeFa0TAOw6pxeeVN2fpn+ZotvT3ceVtMGEYaphqFVyuuFXGC+DKfr540Wd7fsQa7YbvDaSXbvE/6etgrKh6ydu3D2M2DpSkXDywECvSXkBED3VnU7s1S+0n1BgD1j2oG9lQkV48W6VZX0L4fvrddzMq79INvmpA8VTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeEL8F0c08m7nJP0X4MJwXUuWM9D8i1rH1SX1Hc7ceE=;
 b=I6c2LJc2XZ4d2zExaew9NcTGWfUQmDoHCQ1/6LA7nipWLPKxrIjVJcWQhK7FsrgYyWQhgr7486kL566xy8UiEfB4b19vxsCUnh6RW//TyPf8LIl0YjwWNihfiIT72mS8raTxvZ0Wjvlj2FKOC/pMe09BF3s88LN+VYNSzwGgvpQ=
Received: from SA0PR11CA0036.namprd11.prod.outlook.com (2603:10b6:806:d0::11)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 18:30:46 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::5d) by SA0PR11CA0036.outlook.office365.com
 (2603:10b6:806:d0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Fri,
 25 Jul 2025 18:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:30:46 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:30:43 -0500
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
Subject: [PATCH v16 03/34] x86/resctrl: Remove 'rdt_mon_features' global variable
Date: Fri, 25 Jul 2025 13:29:22 -0500
Message-ID: <c11cae52bb3372344770a21eb034989c507e9d9e.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: 47fb31f9-5db7-4c15-c55d-08ddcba95f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i5HQTn1ghcsz0msR8lRHEPrDNw9pYdFm35oSmUEYDrvcDTC7zbjVowGqzVdC?=
 =?us-ascii?Q?2ehZPvU0z33qbD1r241fUWi8/mXQeM1FZblJfhuSNib6ftPqRfnM4B5t/D+l?=
 =?us-ascii?Q?CM2xbytF9RcTpUOKPCiZ7ljGGFvtXqhUxM9NUMS5hB5QeBdA99mC3m2owXZA?=
 =?us-ascii?Q?mqTvRUrQOyalbvt6Cu2PAkyj/IvJRWBP3Jsjo2nxX+F2Duubc/ZTOpFkABzR?=
 =?us-ascii?Q?oNABmrrxopWt7NQlVxa0+frw12gKTRQkDDmcCMaqYhrDr1Vt0aKKu0uj08QN?=
 =?us-ascii?Q?w6P7sKi1XvSw0eujggjXoQar0n8rqCcWVa2NJimvUPT75K49CZJLbTF8pNRm?=
 =?us-ascii?Q?Kahkyvpeuf+HoIq/isyyhyYm1hHMdwnsQN8Ik760ZlHZeOU7pjSV5JEtGxcc?=
 =?us-ascii?Q?I5ka+iH3MfDd5qKwRaD8bSxa0HjvpoqcbMY1dFYmqkZzMgI9Ptz7ZnKvZnKy?=
 =?us-ascii?Q?yfhYIe9RjiWedF/J5jRdwsLbbLMXiBsekAzWGea26CvyEiYDMew+JWZhJPDE?=
 =?us-ascii?Q?jaccm1XjlDLWpFpzzjnGuPcfzRE1fHLHjyiP4KqVLG4bw8MAOnwBpuf/jKFL?=
 =?us-ascii?Q?wnQpFkP6VGjn80yVUU4rCKDBMkYy/x/+xJ5e97/+C0+V+CW9moeEhBIbHT0y?=
 =?us-ascii?Q?im5W7AvWdSqJznYZ0652neERcsgRiYOpSt3nV08OTEvFTshesutInTtvH22Q?=
 =?us-ascii?Q?Vp5uiCNh25avfSp85bII9hpKEsoASVfWt9ges/3AV/F6Pha01dNDCrYyvNIV?=
 =?us-ascii?Q?whmKt3FguuML/YwtxCgNGXAtzFgzH9jtXRiKlpop/84ka+sLGodiDEeRJxK1?=
 =?us-ascii?Q?4REyUugc+yKyi7GFK2CCcxrE6dWdegs0UzHtWqMqemtk4Mqn01iJ20CRzq/5?=
 =?us-ascii?Q?8cuNACU0o68ElsKB2qYf6/FtiiUToiGG4nkOKsXTi3hlvhSOAeSGg972O92F?=
 =?us-ascii?Q?+5HAuYZrJEaWucQjpLE37c5cg22fWpU+wtdfeP5cUpp94tCMbnnKONDuv5l5?=
 =?us-ascii?Q?ATdEJt/637eK0O40AUft/mmDxedXKQrQ3jnn4+f5ZfAdiIGdS1g1m1PfukQJ?=
 =?us-ascii?Q?l9xX/sg9QYfy+aX8K6Rk5P+H4CnU1nJfMLh/VHk9IuAg0OoeBh40ZYK3jMnq?=
 =?us-ascii?Q?Cry/V7j3s7Vf00B8Jgtj/C41p56Ldv3AANYKq8fwVc+jjoyiK4rea63KGMlD?=
 =?us-ascii?Q?O2XbnFittGGCFF9sBMZ5PIi6D8VUboo6RJHw3yRFpObuIfb8El7oL8n1mEIa?=
 =?us-ascii?Q?mhMRR6xHUTKwvCoxaljoBLb/fO2kaBhGKCfyRRnqMJwcwvnAstews8YQGyJj?=
 =?us-ascii?Q?VZ3pjAtBo3Ay/O2WdxBJcsNbIs2U8ZjZ7VsGwGGB3PX9xAw6eDBUdxu9b3mX?=
 =?us-ascii?Q?RCItXwbJv56jDY6/LNEIJ/zZq++Vav7LAc7GsNCenGfVIHJS2hHye/jmgfgG?=
 =?us-ascii?Q?wJLaKTMitdIMZrmw5HqUs2r/d/rFSqk1ZjULlffbc1suEbH3mWaVHnGW8Twh?=
 =?us-ascii?Q?IY5p5sXjMUPjxN0U1SJHuWZ4ibtMSJPH0m1dB4wBHfv+tAMu5DrmxgaSnw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:30:46.1717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fb31f9-5db7-4c15-c55d-08ddcba95f20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172

From: Tony Luck <tony.luck@intel.com>

rdt_mon_features is used as a bitmask of enabled monitor events. A monitor
event's status is now maintained in mon_evt::enabled with all monitor
events' mon_evt structures found in the filesystem's mon_event_all[] array.

Remove the remaining uses of rdt_mon_features.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Picked up first four patches from:
https://lore.kernel.org/lkml/20250711235341.113933-1-tony.luck@intel.com/
These patches have already been reviewed.
---
 arch/x86/include/asm/resctrl.h        | 1 -
 arch/x86/kernel/cpu/resctrl/core.c    | 9 +++++----
 arch/x86/kernel/cpu/resctrl/monitor.c | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index b1dd5d6b87db..575f8408a9e7 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -44,7 +44,6 @@ DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
 
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
-extern unsigned int rdt_mon_features;
 
 DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 1a319ce9328c..5d14f9a14eda 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -863,21 +863,22 @@ static __init bool get_rdt_alloc_resources(void)
 static __init bool get_rdt_mon_resources(void)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	bool ret = false;
 
 	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC)) {
 		resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID);
-		rdt_mon_features |= (1 << QOS_L3_OCCUP_EVENT_ID);
+		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
 		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
-		rdt_mon_features |= (1 << QOS_L3_MBM_TOTAL_EVENT_ID);
+		ret = true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
 		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
-		rdt_mon_features |= (1 << QOS_L3_MBM_LOCAL_EVENT_ID);
+		ret = true;
 	}
 
-	if (!rdt_mon_features)
+	if (!ret)
 		return false;
 
 	return !rdt_get_mon_l3_config(r);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 61d38517e2bf..07f8ab097cbe 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -31,11 +31,6 @@
  */
 bool rdt_mon_capable;
 
-/*
- * Global to indicate which monitoring events are enabled.
- */
-unsigned int rdt_mon_features;
-
 #define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
 
 static int snc_nodes_per_l3_cache = 1;
-- 
2.34.1


