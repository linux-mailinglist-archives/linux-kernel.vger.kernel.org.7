Return-Path: <linux-kernel+bounces-746171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6526CB123DA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4955832B4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA1C250BF2;
	Fri, 25 Jul 2025 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FDYMz6iZ"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63D02472AB;
	Fri, 25 Jul 2025 18:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468309; cv=fail; b=of6zvKJltqliXTf/kUyNdMa94bffbCxjRhnjNLxz/FU/4QYHYgFHJBs9l2o4PCUM7oZ3KzvAwV62F/VPXAtV+2/FtEQ4RrAWvzWpSMdCXPPu8RKf7cEsD0XRw4wqtsc3pOWcdg/LgSFJPSPsHWrjaStgh1PQ6CMsIsMeBCfJYfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468309; c=relaxed/simple;
	bh=PbdwAgX8mp9MNPfAVoKtfp3CnuvpShQkolYloOKqvjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPXd0khpjspVetN3zZHpkdfSU0ivbXP0cxrSpG8O3E2P3xlLrHHlAXGXz4zi4wISXauDLl+73pDC44XFrMyil+UHV6q6qtQJR6ttIgC9cY6s0Vbq/N7SQLMet1NFGkCUf1HWfyYkq9tNn58lLF3eL4kYMJeATNk5Od8Rw+WsYsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FDYMz6iZ; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VygXwkSj8jxmb36qNjtUl1vHXgGZLpL4UtUwS43d+tjPqaBOaCZz+kvpNGKizBo5WiK0vXf7iZ7nYXKytRFQWMnB0WEzMtJGUhWuffC8XK6l76XcvvCstYldC6hXkhi91XvK3+32p1ifpaXEPmMxyYgWYmDkJHixxxs7yNwi/IscSiM0x8alNCih5bwPN+aBI2UpB3vr2GhcJjgR/4Q5SqQrVw3F5rf6+c8sydHd/EQ5QLqpzVoWUqoO5IJ4AlAc5/QNhplDR5bGgrCaZYWA+XZFLnLSEb9CSosPYR0aBg6xmHKS56SQVbVIruGLtJvAwpTbFnmjJzUjLMpkTqtMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dg7zMAksRbS76WEHcxxsYZ+XN6eU5DjoVhFlBlFagOM=;
 b=y5NaBE9yJfGfUaRlx2nd4LvFuD+fIrg3y7oNBowptk/ZdsOYbKszCdhauXLjHxJ+O7j6T83fr+NqhYTD0BbXuRBhhf0tgsoeaYKSjEUQ7IxDOSb7KJJYC6wjFDcgTK2Q2JHoOOGGnnG5v/TAOYG7TXTQLt45fPlyFnXbMfbLLE4eygIE5Ngz6Ll7ze66fwQyBM0iJhyFDAfjhY7CpfQMxxFc19nPdG+5eVC1In47mnXiCfdWMhKEjZIxJBXrwj9Xvd80B8v/YpDb5NehyP0pxII3oZO5tZYq+mYGYwhs16bABljUYzwR5/Fa3IdDddCq1HIClap2mNs9UT+IiuBNyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dg7zMAksRbS76WEHcxxsYZ+XN6eU5DjoVhFlBlFagOM=;
 b=FDYMz6iZkUSj6VbFf8v4qLUFNwjB2hiLOdMjiCkORZEDwktt819kXxgDL+WCUvZzafsPzz6gACI4V+IWDq6UWhNdXwebBsq0fk9erF7U0TFSlZXi1M1H7yMjO4FteTKEcJS5joKqJKx87wJZ5/UvLvitaVCoxBR5OubFrqlKPtg=
Received: from BY3PR05CA0018.namprd05.prod.outlook.com (2603:10b6:a03:254::23)
 by PH0PR12MB7816.namprd12.prod.outlook.com (2603:10b6:510:28c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Fri, 25 Jul
 2025 18:31:40 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::8f) by BY3PR05CA0018.outlook.office365.com
 (2603:10b6:a03:254::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.7 via Frontend Transport; Fri,
 25 Jul 2025 18:31:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:31:40 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:31:38 -0500
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
Subject: [PATCH v16 08/34] x86,fs/resctrl: Detect Assignable Bandwidth Monitoring feature details
Date: Fri, 25 Jul 2025 13:29:27 -0500
Message-ID: <bb06941505a33df996fe0e8d997c2eb2c4f4b379.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|PH0PR12MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: 365e1640-24ae-44d3-074d-08ddcba97f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XtwMyT6Tj831Ura5aXHHNFQ7Veul5cCG4yaUuEXqVl0mtWdA07HzLyX1byi+?=
 =?us-ascii?Q?upTxcg6a+cXHjFH8zSbRlhVpvVUbsW/5DDNKu+Tv1VTVsa11obWq9viq+5or?=
 =?us-ascii?Q?uCBdfCxDXOJMri3doq5zvAOL2OMAVATGVoe2C69fYx7WBeXS6y7vAXQKJ82D?=
 =?us-ascii?Q?lcODUFvG8t3phoerQbGxkcgCQ4I8KXLi7f0hM6ZebJ9eAMSrtJZwjSW3kodR?=
 =?us-ascii?Q?OvINmm8DDXZ+7Aqhx1kJALYvAeTMI0NKN+Ke4lSwTFbkKqPYWos5uHSwj6ci?=
 =?us-ascii?Q?cTJpQ1hkp48rLNM0FxfAeTrdgAHoMYCsFAcH9m5yzlc1eI5K+fO3nEM9rmYP?=
 =?us-ascii?Q?ybb2ug0V9LjTVrrIvSNHB9fXMhPChrcnMHAedHPagaH5UpNdpSM2GI/7dPhZ?=
 =?us-ascii?Q?ImjnN0xNl0xEqsav1WiXXghgh1soA+nzRseGlbyvAlHszfVN9Y8EZpvScwRC?=
 =?us-ascii?Q?dsDkPEHMh99ZibCNk0O4OhEhwga2dnuU0md1raJ/DIXiQ+MaHt80+koHu30t?=
 =?us-ascii?Q?/WFtL07ruwJZamh79C9uo/PwjdFpTaLpYihCbrTAFRGnmZUqL9ogjTLDvX+s?=
 =?us-ascii?Q?SiunYa86Q/6EJ+RsvA7hTvLUb4WkKl8a2Jj9VFe5ixYNHcs1GjSN0tlhQ0oS?=
 =?us-ascii?Q?NavuIUYb0+31MS6/OuWV2OlJ14S6yJFmnchPjPubhAcQNZjKmecdked85AEl?=
 =?us-ascii?Q?nut/s+2Y+GFvGXGyhCgvFtZ/KLcVBZ3RvNLkVePSGdYsu/s8q+rzg0TCFeXy?=
 =?us-ascii?Q?xstJZ557stykYzE2eHZDxhhKvR3O7Wyf1zBMCnpX4YgCAo9U9oGXS4ixOeFp?=
 =?us-ascii?Q?r209aHq285OqdkGBZ6GlnaKqLPd8dxIXTqU84zcVGbn2U/opArtFBrs2gjtP?=
 =?us-ascii?Q?N0ll6MOe+SK5L2CA0eG0jPhDjKJLal+dQ1o7s9EbKTU5stPLBBI/uts/5UWY?=
 =?us-ascii?Q?hsvklJvEsjxODfj9HvR2lzsWeO6GAOeP6bcsFikDC6v0+aDWLlLtCYYDeT0j?=
 =?us-ascii?Q?mNHZyMbHtaj8dy393PXZIO9Yvs0IqGwHIDkGGUh1HYwFtCWEokGjTIlf963i?=
 =?us-ascii?Q?Fv2SN64Jl+z1wGVZ3qdLDhXcQEpDPHF2mzxcjv2X4/3O9LaA5kTkOq2qemUT?=
 =?us-ascii?Q?n0fkddl/XjJiFPz6rX2Pkd6Xj6A+jncmzTZN2sxxIA4kJkC5bnUsr+OQY5e6?=
 =?us-ascii?Q?diSmh1PX+993HGXY2RoQLjLwZtEosZF4AdlzFpBggbocTOBfA2evYG0x+8/7?=
 =?us-ascii?Q?t72CNeXYZlTAawl7dRh3c+FDJHvlQ3ZHgb4acU5xqCgmdfSEE77eN4Lsz1bZ?=
 =?us-ascii?Q?dCIeOUlFF20bNFbl6z2E1baGSKCHwQazO2b0cdqixYoRsyYvLVfhqErRk3sg?=
 =?us-ascii?Q?b35JhAKHiotda9ijteYtSAkflkR1hkZX2AAuQMzpfKv07Srd+xgNFoY4pQsm?=
 =?us-ascii?Q?IGrk0yY+4wMwLPwROKzoWjgpM9dO7dr8j4pYPAoTiq8e5Ty0FPf5eEgIO2mi?=
 =?us-ascii?Q?Sx09T26fck84HTDVKq2nS8iVhwVH36HvPglavqN27FXXt0k62SIWXOwbDQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:31:40.4167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 365e1640-24ae-44d3-074d-08ddcba97f76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816

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
v16: Added a new check in get_rdt_mon_resources().
     Added a check resctrl_is_mon_event_enabled() before enabling.

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
 arch/x86/kernel/cpu/resctrl/core.c    |  5 ++++-
 arch/x86/kernel/cpu/resctrl/monitor.c | 11 ++++++++---
 fs/resctrl/monitor.c                  |  7 +++++++
 include/linux/resctrl.h               |  4 ++++
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 267e9206a999..09cb5a70b1cb 100644
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


