Return-Path: <linux-kernel+bounces-769996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E754CB275C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD4EAA7AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF1129ACCC;
	Fri, 15 Aug 2025 02:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="urRUBvzD"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874E7298CA6;
	Fri, 15 Aug 2025 02:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224830; cv=fail; b=VrJNGO7Xi9SzMesPtUIQ9IT4ceIwXnIqLOSFgVlZdUHtbayiIg6wm4DHMThLwvYj97RGLmzXLrTV8W6VnqV4VH6l3cEzYzTAPoLbU52Bh5WSj3yZeoh8UvXAvFG//s8yqGuTmOVvgKQVi+murL0+DafJ0VaxFApacsfHlUN8Kjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224830; c=relaxed/simple;
	bh=HLdiYBMVOHbTqLzGoxCWpsOYJf1wavgCsL9OzUcBH1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aO1khfz59RchjDlftuMaRsBKvPTdG9WS/b5dV9H+MvYm72tTBm83T4N+N5UfjbLfz9YnDL86lJJVmBl9qIrBKOPRHlwewTnC0RkOlk4vo384FsWBRDQL/wMq56/I/8HqHpSHBEwmhMErds8h+Pu22kCQwigCotUF+5TQySXfHw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=urRUBvzD; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzCnkR5n5jnJNdt/CyU0iOXUw2xOdNZ/mqguhxurZQ+gNgKaXxnD05gbEp3m2p00kXN095sNXdnHVvIwTWzvXaN2+PR4lNLznhiFFtoVoRHiHCVIvHnqP0ubjfP282+cHmu5SWoBnA094NAOtQxqqgRvm7cHlY0DXOfcxBRTIWZziNtSP4iQdmS+0OKQdMk9dCKPi6k34cUcW5Z42G3pzkTw7q6ezEkUVBqYB1ZiAGmo0/3mEh2mqbB5hPcRCBTFnkGY3xrLFV4LhtL73VDGAu/18ttBt1Zz3tSwsLolxB8pcX0xeBAiH8NNTapkVpSup/dG1tqikoB/SkEG/oBBaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YwtOC3jr1cRkssuizueagA9IEy9BIbRNUFyzEJ6KjE=;
 b=bcCGh+x9NWDTAfOJ3NXe2kzq9X0JWHcoNqL9gS+vOYPXCuT+M+/SKqpR2t9NBNqnJcKU1pwu7kvD73qJOGEgL9u2dPqx8CSMPRGvlnP3SWMeCpMO7wEXBeoDb1U/gNXKszPrN+4oc1AuiLO9yjuAoutrYfjmzzgrfEXUHVOAoDgX1iFcfKEciT9BNlhHDMTEDxIf44M+0TFBXfHombLxvyk+rHbInoHgiCgAgAXAKSmN3DX6a63jFPzVCm60UMINauwqV6xU58iPehegGIbI9FRD9sE+78g/xevjF1MPpAlYd+n6sr8pouWB8nlYxefpbdGhfxA37TgS9AxI/W21zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YwtOC3jr1cRkssuizueagA9IEy9BIbRNUFyzEJ6KjE=;
 b=urRUBvzDPY/FrHj/9Dk1XJj7L8m65pw8J2MQbANyfm5O1Nh1zo8IAziwU+HgrtHETJhHty7DOMK6RqxO5X6Hc5EJcHE2VJDX4xEUjUH3DlwWdM580w2z54GcUqbaRj97ue3Dz+je90f3/3EseKnCRrEJcnnVudSMpdIM051sELY=
Received: from MW4P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::35)
 by LV3PR12MB9268.namprd12.prod.outlook.com (2603:10b6:408:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 02:27:03 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::83) by MW4P221CA0030.outlook.office365.com
 (2603:10b6:303:8b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 02:27:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:27:02 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:26:58 -0500
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
Subject: [PATCH v17 08/33] x86,fs/resctrl: Detect Assignable Bandwidth Monitoring feature details
Date: Thu, 14 Aug 2025 21:25:12 -0500
Message-ID: <57c33dd8ed98603d5b434b3f8f32c3c1b19dac00.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|LV3PR12MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2ff006-af2a-4013-0725-08dddba33813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YycpSiqKtxkyJkrNMzQJeb1mv5SSEGLieMIWHC4v84AI2odEkyEztRrro8Q3?=
 =?us-ascii?Q?EePqeta/Hy3fRbQ7SD5gWXnkjjpiP8GB60l+w7f9Z6ZuLLsPcgGB4RPBPyLS?=
 =?us-ascii?Q?0AJ2dlhFyHbhX8TU52rPinGajnSQNn0/JuxPur/TIkm9DOYEklDv9pxyKW7J?=
 =?us-ascii?Q?ZGkUnenZ+198pb/fzdgRF8I1EeV4vN62ms3+P3VmAVxG34NILKeaCa6P/Jw7?=
 =?us-ascii?Q?xAAfuHlRLsI88xj1C9XGyOSG7arONEg1vrzyu9OD+01+6T+gOtZmIkDwbXEa?=
 =?us-ascii?Q?tHqNdEAna9chvFGcxcmlej9QxgUf7lBFWrH+0UAKQ4QZvWxmsb14d93KXdMK?=
 =?us-ascii?Q?sc0tcFSb8J0JwsdwlfPJ4IdZg5oCLt03glK9MiWsreI4ikfX0VggVmpHohK/?=
 =?us-ascii?Q?TNoC1bxeEfEMJ2DAtr+tS19ugxBf8Fdc07BKSl7JkA0bh6p5WlGMaDgYZYTE?=
 =?us-ascii?Q?XfRlRwmGO/7L4oRnzihsQsvlGo7wsFi1aewRvyOxh51bg4dc8kf4n/Z+pr0x?=
 =?us-ascii?Q?SyiKN7w9VqNQmBVYlu19iNfBcSsPwXPiSjs7FTfkhEZa8snysBBukWWOx2KZ?=
 =?us-ascii?Q?fdoR5pMwfUerFc6JzVJSr9/W+awRLAZyQ2Cke/BKpyUNnPLpOpmmM/z1bR3q?=
 =?us-ascii?Q?rKnZiL+2QxVZBZ0I041fALwWy3PY5igTUvEwxvtWNsTEDOo1gkYbXZwPNjqV?=
 =?us-ascii?Q?Vi0OE2p1LtqhqUKuHAwrl0w3H3orInAnoDN3u4qzEHKvaPpbJaIYUuPwKIWV?=
 =?us-ascii?Q?sLZOYpwh3FmbPClFC/692MJfuq259vO7BBh9tLA8mWfKahuXG3f8/DuiW/IM?=
 =?us-ascii?Q?FuebWwEvON+N5vNmtgXHSDDCnmtVfHbPMaGQyMxpXud7dr0VFwWFYqHGnLdm?=
 =?us-ascii?Q?DGy1LlZbPRtOg2KTqGq2YYeCDu09pTH058+Vfms2fCY2UCXfgsAKEfmf+dBs?=
 =?us-ascii?Q?b5f491sShYVuQNd3gzWxhxzJ4puifkl8Lvo9Yt0MMyGk4S9Q+TLETXpIbwsn?=
 =?us-ascii?Q?BdgY2ROOm0nev6f7VxnwKHAt6TaUnPOU+6L5PohGNCovLcnuuvp83Njn/5Nh?=
 =?us-ascii?Q?2KvPuvEy2hbyiONKNXbZwkv0jTU4UevXD5hr6aScCAGECL1+rLhuqe56432c?=
 =?us-ascii?Q?Uf4uPGiLbdZwVXhZK1x0SQSFRguMH2n1/I4QDPKzHvMkiIYrpUH2/inru3zK?=
 =?us-ascii?Q?v0TmbjPHc7VIcRtmEBVra1YZywnAmTaXH4BCaF8UiLhmJxgx8el30eYArnt2?=
 =?us-ascii?Q?vLF840TAF4Gnv4UZ5cB9mrBDzBinMaf22Kk+N1erru2aekDZ7ZmTaJbf84ko?=
 =?us-ascii?Q?THxPX6wKtbwpmpYtK/OSUm2e9AVgMcEkhsfedUZD0YIeRdPB6ZGFcv03qR4d?=
 =?us-ascii?Q?8P9Jq+t9TYW+N4zB31uPuM4Vd1/ZpvaoaVegLJfYfk8PYG8zUwR0TwcCLSD3?=
 =?us-ascii?Q?9PF/wE8OHOMxbGlrD5i4sUqEpUBT5YKtNZOps/IAg367vi33eFzjG7wlmA3t?=
 =?us-ascii?Q?8ijMObtMfvaVm5j4ZenjbYmfmaOwbSNQlO1tcgZB3ERovEv7a7mrUls9rQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:27:02.2057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2ff006-af2a-4013-0725-08dddba33813
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9268

ABMC feature details are reported via CPUID Fn8000_0020_EBX_x5.
Bits Description
15:0 MAX_ABMC Maximum Supported Assignable Bandwidth
     Monitoring Counter ID + 1

The feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Detect the feature and number of assignable counters supported. For
backward compatibility, upon detecting the assignable counter feature,
enable the mbm_total_bytes and mbm_local_bytes events that users are
familiar with as part of original L3 MBM support.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v17: Added another ABMC check in resctrl_cpu_detect().

v15: Minor update to changelog.
     Added check in resctrl_cpu_detect().
     Moved the resctrl_enable_mon_event() to resctrl_mon_resource_init().

v14: Updated enumeration to support ABMC regardless of MBM total and local support.
     Updated the changelog accordingly.

v13: No changes.

v12: Resolved conflicts because of latest merge.
     Removed Reviewed-by as the patch has changed.

v11: No changes.

v10: No changes.

v9: Added Reviewed-by tag. No code changes

v8: Used GENMASK for the mask.

v7: Removed WARN_ON for num_mbm_cntrs. Decided to dynamically allocate the
    bitmap. WARN_ON is not required anymore.
    Removed redundant comments.

v6: Commit message update.
    Renamed abmc_capable to mbm_cntr_assignable.

v5: Name change num_cntrs to num_mbm_cntrs.
    Moved abmc_capable to resctrl_mon.

v4: Removed resctrl_arch_has_abmc(). Added all the code inline. We dont
    need to separate this as arch code.

v3: Removed changes related to mon_features.
    Moved rdt_cpu_has to core.c and added new function resctrl_arch_has_abmc.
    Also moved the fields mbm_assign_capable and mbm_assign_cntrs to
    rdt_resource. (James)

v2: Changed the field name to mbm_assign_capable from abmc_capable.
---
 arch/x86/kernel/cpu/resctrl/core.c    |  7 +++++--
 arch/x86/kernel/cpu/resctrl/monitor.c | 11 ++++++++---
 fs/resctrl/monitor.c                  |  7 +++++++
 include/linux/resctrl.h               |  4 ++++
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 267e9206a999..2e68aa02ad3f 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -883,6 +883,8 @@ static __init bool get_rdt_mon_resources(void)
 		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
 		ret = true;
 	}
+	if (rdt_cpu_has(X86_FEATURE_ABMC))
+		ret = true;
 
 	if (!ret)
 		return false;
@@ -978,7 +980,7 @@ static enum cpuhp_state rdt_online;
 /* Runs once on the BSP during boot. */
 void resctrl_cpu_detect(struct cpuinfo_x86 *c)
 {
-	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
+	if (!cpu_has(c, X86_FEATURE_CQM_LLC) && !cpu_has(c, X86_FEATURE_ABMC)) {
 		c->x86_cache_max_rmid  = -1;
 		c->x86_cache_occ_scale = -1;
 		c->x86_cache_mbm_width_offset = -1;
@@ -990,7 +992,8 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
 
 	if (cpu_has(c, X86_FEATURE_CQM_OCCUP_LLC) ||
 	    cpu_has(c, X86_FEATURE_CQM_MBM_TOTAL) ||
-	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL)) {
+	    cpu_has(c, X86_FEATURE_CQM_MBM_LOCAL) ||
+	    cpu_has(c, X86_FEATURE_ABMC)) {
 		u32 eax, ebx, ecx, edx;
 
 		/* QoS sub-leaf, EAX=0Fh, ECX=1 */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 2558b1bdef8b..0a695ce68f46 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -339,6 +339,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	unsigned int threshold;
+	u32 eax, ebx, ecx, edx;
 
 	snc_nodes_per_l3_cache = snc_get_config();
 
@@ -368,14 +369,18 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	 */
 	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(threshold);
 
-	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
-		u32 eax, ebx, ecx, edx;
-
+	if (rdt_cpu_has(X86_FEATURE_BMEC) || rdt_cpu_has(X86_FEATURE_ABMC)) {
 		/* Detect list of bandwidth sources that can be tracked */
 		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
 		r->mon.mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
 	}
 
+	if (rdt_cpu_has(X86_FEATURE_ABMC)) {
+		r->mon.mbm_cntr_assignable = true;
+		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
+		r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
+	}
+
 	r->mon_capable = true;
 
 	return 0;
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index dcc6c00eb362..66c8c635f4b3 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -924,6 +924,13 @@ int resctrl_mon_resource_init(void)
 	else if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
 		mba_mbps_default_event = QOS_L3_MBM_TOTAL_EVENT_ID;
 
+	if (r->mon.mbm_cntr_assignable) {
+		if (!resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
+			resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
+		if (!resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
+			resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index fe2af6cb96d4..eb80cc233be4 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -260,10 +260,14 @@ enum resctrl_schema_fmt {
  * @num_rmid:		Number of RMIDs available.
  * @mbm_cfg_mask:	Memory transactions that can be tracked when bandwidth
  *			monitoring events can be configured.
+ * @num_mbm_cntrs:	Number of assignable counters.
+ * @mbm_cntr_assignable:Is system capable of supporting counter assignment?
  */
 struct resctrl_mon {
 	int			num_rmid;
 	unsigned int		mbm_cfg_mask;
+	int			num_mbm_cntrs;
+	bool			mbm_cntr_assignable;
 };
 
 /**
-- 
2.34.1


