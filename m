Return-Path: <linux-kernel+bounces-746170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF04B123D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43535811B1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABC524EF76;
	Fri, 25 Jul 2025 18:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a8D+AumY"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B961224A079;
	Fri, 25 Jul 2025 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468296; cv=fail; b=sO552eisZZPPAULtw+NMeduvB7CFZ4/CtA5NCVy1BzTqKGw4dFx/eIsDsEtGcHSg1bSD0W4yzCJIbF0e1J7ze2SvfIC7iTqksRIac0kQrQLNU0yR4YtSLYIXaH/OgIHt2lnvfrvW2Rv3cYe6B5euqBr6DHlsQBCyNJrTSArUS94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468296; c=relaxed/simple;
	bh=qDgBlQ8PkeQysYdW7tHHCt9KF2Y85t9r77ZIFwwdw9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkNSME2ft6AwXj3FHXdr8s0jRTgm+sXZ4wsWRG1Ix1HFmFrMyxnocMWK3QmjUDDlxBAtAbKvXxwki70j46T5MeLclJSo25/j19Nsq8Bgm33SvZ4AO8GLqKEqUCn31DuHoR2HLotKcal8Qxfl1ZyHUivlKn3BXOIcHPB7Ml9Ebis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a8D+AumY; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3xFevYjURHU4vjcl7PV+xGKiFJ6GOXDa4oBSLIyM8Koxt5SxikYiD1jvcjCKf3zeYbWNL8Nvrl/5mkTY9vRYTbZh6LXYFHOWghet81N/9VccRQVOi2WFc+zZKmfLBMzzRhhAP8ZUmpOaVxJo3T9uND9SJsQt6eaApasujdVLnCuQn22jkTtAOQ1XI4GP3cY88jhW33YFpvZpotFTXdI/BK5W2ihs+xa5vUOW3sN8QWMQQht7c8CsAHKXlA0PMFYYjR9qlCIlWShfetS2wQM41vNsl4KFcgwxbscgXvN/Et1x248XkTsZ14dgvzx31d/f7a5loVzGmcNvgWmREGMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku71Tai/ECAGbOId8A/xg4U6M3+urC+pOgHI5734cqk=;
 b=m8Z/AieIOMYlJhaBzVCRFHmxIDsvczi3duqT7VqJUSG7U++AM+l59dFztQsdL7C8Mnw1zXHTafLVkzjzVpJZQ48DMTpQG4czHXsNtVOE0pzTPsT/BSvO8XA4jh39UFqYlOTcshyBp80NB7HEfarlCwUgPNYdrvJwgyp1u0LinRqBaZERMd3f/k4Cwr24tjBfzW1U6ejDw/OLifeHEqChyXXFPPqi0FJJu+nI4a3zuHjFxzaJ6cAIuAFTCu6Vq7F5IqQIfWPfTOAx5PbGI2dzC9hiXgH88TzXbhwOyALco144YOot0XV6K2U8ENIFKLqWxPA6HGVt5046DKt4jzK81A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku71Tai/ECAGbOId8A/xg4U6M3+urC+pOgHI5734cqk=;
 b=a8D+AumYwahBxaZifgPl7IBFrtpavBpfW+uel4XzMd9h7qNK8sjP3lWWPvbT56rczPL+n1kiqjJIB9Zcln7cTgk8UHaP/C+ADkV5CNVDdCd90au7b2CFrLwRpBGR4DKHhF0Fv/QjYWr/BpDXXzTQqCVSGpGvhR1u9vDQ4vl/jmU=
Received: from MW4PR03CA0129.namprd03.prod.outlook.com (2603:10b6:303:8c::14)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.22; Fri, 25 Jul 2025 18:31:32 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::6c) by MW4PR03CA0129.outlook.office365.com
 (2603:10b6:303:8c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Fri,
 25 Jul 2025 18:31:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:31:31 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:31:29 -0500
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
Subject: [PATCH v16 07/34] x86,fs/resctrl: Consolidate monitoring related data from rdt_resource
Date: Fri, 25 Jul 2025 13:29:26 -0500
Message-ID: <c4e749bffee016bf307f2639af22a4943eed7a99.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: dffc3eb1-2bbf-48d0-8d81-08ddcba97a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QcagSVEHK/RYWoBmlfyllBCr9UO3WOJ8COQU7i1zn/vx+mUutJ23qLzFmTpU?=
 =?us-ascii?Q?BYh5s+xTYNogckA4oaG1dxiBSKcAJln6GWonsy8F9gMQ1EyQYiEVMBqlaPZO?=
 =?us-ascii?Q?wpQYqbmXl7JOooH00J7WdHOhe+5WD+W1iNES9G74G3NxeY6UyEC0k1vSRY3R?=
 =?us-ascii?Q?e3wWkzGpv0DUgOYiLgD2QsJa7+z3EVaWN3vavgF3hi+7RxVz0v3YVhbt1FA0?=
 =?us-ascii?Q?9Yp2utpBXmQeiiIgX/c8RdpVyysaTE8o8ZtYsXfcOnZZ13ABamjfhltZ6pGp?=
 =?us-ascii?Q?atSo48PSw2M9Y3bnuGN3/hY6RCVkA3eyAod0bU9v5Yj6XpmKr6GlQRfrjwDj?=
 =?us-ascii?Q?EtGUp2g4dbVEBfz34N1Kp32IvOJ8FiZeobosVmOqBflSt8VNm76Hnv3sbIu3?=
 =?us-ascii?Q?9DdPJS66XMfAgNxTmEhRnQtvGVvS2IPuEDNmqBwy4FBa8qGTaBMmtDeFZ16H?=
 =?us-ascii?Q?sS+wB5nqopW9c3TDt6o/8p8WLmrVlsEbt7+YEWQCrylmfDNPzLaL290Hbx9v?=
 =?us-ascii?Q?YV25UnZ93xvfcUVzwEohlEQJGCXJrDQoBSJEd8a+JdpPa/etxUipLlfNB74u?=
 =?us-ascii?Q?MMk7O7S9rQ2nYrAKzNkpiecRpvyYKT+D+vVOpqpPYVydGmRKL7zpb599G8kd?=
 =?us-ascii?Q?kBe1NgVH2vBRjJIIg3RM56Drd9MhOSuguPxlcYiqP60Zst1/C4UKxRg5lY0t?=
 =?us-ascii?Q?pfG1ZckXyDFItx1PMGIACz2TxMg4vLXtxdUpuJcYppBtB3JQE32dL/EbwfWW?=
 =?us-ascii?Q?igbG2XwK7ENwW651tmclvlbFtu7+1LdGP675xV5Wqd8+ig4bmi2ozd4Bfsr1?=
 =?us-ascii?Q?rfofX3IiYEoGNo0CeOhj7TIb95UvG5PAT4SgH2a2xnams83VcI0HpRi9Sk1A?=
 =?us-ascii?Q?f0tp8ikiGLvTmd8HEnAJusW6nPXbSC4UIUEBLeidqdC3NDmf6wqRXZ0Tm/Yc?=
 =?us-ascii?Q?cjviydHIDioDkmdbNvB4Oh9F/YNZqNdTvv5Ugkt3IBLPKVdEgqbq0vjq087T?=
 =?us-ascii?Q?XYhxXcjMi6ZFhPuG1FvZxa2yeqWo3AVY5dBNliqeGbS8GPu7eeysOtXGx1oZ?=
 =?us-ascii?Q?pSRWVfLi2YlVZtp66tFhTPxNXiH/EN6WbuMfrrPbX+uWd9Q+7+h6M+oKg/Ai?=
 =?us-ascii?Q?Wb+3p4UMHRs0uHl3uwPV9U5hVC+SB5jXcYDuDnxDukZnuLyLwuUir1v4KkG5?=
 =?us-ascii?Q?uRbXrTkTachuCGAcvNFBPj2nuw7/I8W6FIKvQAlobQxAiXqiS6f621BiITNV?=
 =?us-ascii?Q?pG4PSiG+IswPPS+OFZD69yAlxxUToF09G8IjYmAokjduGpUzQPKu0PYXDbtX?=
 =?us-ascii?Q?ItdyxS+DVpAanBWt/tPZklxrmPp7CUHiecgpYv4sRCuA5L4FU1zpPNxXui+T?=
 =?us-ascii?Q?IPrYBcm5hUeSu4MkJL5oesXyLhrK7tZS7IQDwjRFiUQsZDQXJO1/XlJGmYqo?=
 =?us-ascii?Q?Ibfe6n8RRm1fMYeB2B+HlEnzBCzfdZgzzweM/9TXT3KoHrMNizwJ0rZUz2GQ?=
 =?us-ascii?Q?wBBg+zK3Fyan61C9NhLVOdWrZKQWjyppBULX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:31:31.5544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dffc3eb1-2bbf-48d0-8d81-08ddcba97a2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285

The cache allocation and memory bandwidth allocation feature properties
are consolidated into struct resctrl_cache and struct resctrl_membw
respectively.

In preparation for more monitoring properties that will clobber the
existing resource struct more, re-organize the monitoring specific
properties to also be in a separate structure.

Also switch "bandwidth sources" term to "memory transactions" to use
consistent term within resctrl for related monitoring features.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v16: Added the Reviewed-by tag.

v15: Updated changelog.
     Minor update in code comment in resctrl.h.

v14: Updated the code comment in resctrl.h.

v13: Changes due to FS/ARCH restructure.

v12: Fixed the conflicts due to recent changes in rdt_resource data structure.
     Added new mbm_cfg_mask field to resctrl_mon.
     Removed Reviewed-by tag as patch has changed.

v11: No changes.

v10: No changes.

v9: No changes.

v8: Added Reviewed-by from Reinette. No other changes.

v7: Added kernel doc for data structure. Minor text update.

v6: Update commit message and update kernel doc for rdt_resource.

v5: Commit message update.
    Also changes related to data structure updates does to SNC support.

v4: New patch.
---
 arch/x86/kernel/cpu/resctrl/core.c    |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c | 10 +++++-----
 fs/resctrl/rdtgroup.c                 |  6 +++---
 include/linux/resctrl.h               | 18 +++++++++++++-----
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b07b12a05886..267e9206a999 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -107,7 +107,7 @@ u32 resctrl_arch_system_num_rmid_idx(void)
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
 	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
-	return r->num_rmid;
+	return r->mon.num_rmid;
 }
 
 struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
@@ -541,7 +541,7 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
 
 	arch_mon_domain_online(r, d);
 
-	if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
+	if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
 		mon_domain_free(hw_dom);
 		return;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f01db2034d08..2558b1bdef8b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -130,7 +130,7 @@ static int logical_rmid_to_physical_rmid(int cpu, int lrmid)
 	if (snc_nodes_per_l3_cache == 1)
 		return lrmid;
 
-	return lrmid + (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->num_rmid;
+	return lrmid + (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->mon.num_rmid;
 }
 
 static int __rmid_read_phys(u32 prmid, enum resctrl_event_id eventid, u64 *val)
@@ -205,7 +205,7 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *
 			continue;
 		idx = MBM_STATE_IDX(eventid);
 		memset(hw_dom->arch_mbm_states[idx], 0,
-		       sizeof(*hw_dom->arch_mbm_states[0]) * r->num_rmid);
+		       sizeof(*hw_dom->arch_mbm_states[0]) * r->mon.num_rmid);
 	}
 }
 
@@ -344,7 +344,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 
 	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
 	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale / snc_nodes_per_l3_cache;
-	r->num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_cache;
+	r->mon.num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_cache;
 	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
 
 	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
@@ -359,7 +359,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	 *
 	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
 	 */
-	threshold = resctrl_rmid_realloc_limit / r->num_rmid;
+	threshold = resctrl_rmid_realloc_limit / r->mon.num_rmid;
 
 	/*
 	 * Because num_rmid may not be a power of two, round the value
@@ -373,7 +373,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 
 		/* Detect list of bandwidth sources that can be tracked */
 		cpuid_count(0x80000020, 3, &eax, &ebx, &ecx, &edx);
-		r->mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
+		r->mon.mbm_cfg_mask = ecx & MAX_EVT_CONFIG_BITS;
 	}
 
 	r->mon_capable = true;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 77336d5e4915..ca0475b75390 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1135,7 +1135,7 @@ static int rdt_num_rmids_show(struct kernfs_open_file *of,
 {
 	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
 
-	seq_printf(seq, "%d\n", r->num_rmid);
+	seq_printf(seq, "%d\n", r->mon.num_rmid);
 
 	return 0;
 }
@@ -1731,9 +1731,9 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
 	}
 
 	/* Value from user cannot be more than the supported set of events */
-	if ((val & r->mbm_cfg_mask) != val) {
+	if ((val & r->mon.mbm_cfg_mask) != val) {
 		rdt_last_cmd_printf("Invalid event configuration: max valid mask is 0x%02x\n",
-				    r->mbm_cfg_mask);
+				    r->mon.mbm_cfg_mask);
 		return -EINVAL;
 	}
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 478d7a935ca3..fe2af6cb96d4 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -255,38 +255,46 @@ enum resctrl_schema_fmt {
 	RESCTRL_SCHEMA_RANGE,
 };
 
+/**
+ * struct resctrl_mon - Monitoring related data of a resctrl resource.
+ * @num_rmid:		Number of RMIDs available.
+ * @mbm_cfg_mask:	Memory transactions that can be tracked when bandwidth
+ *			monitoring events can be configured.
+ */
+struct resctrl_mon {
+	int			num_rmid;
+	unsigned int		mbm_cfg_mask;
+};
+
 /**
  * struct rdt_resource - attributes of a resctrl resource
  * @rid:		The index of the resource
  * @alloc_capable:	Is allocation available on this machine
  * @mon_capable:	Is monitor feature available on this machine
- * @num_rmid:		Number of RMIDs available
  * @ctrl_scope:		Scope of this resource for control functions
  * @mon_scope:		Scope of this resource for monitor functions
  * @cache:		Cache allocation related data
  * @membw:		If the component has bandwidth controls, their properties.
+ * @mon:		Monitoring related data.
  * @ctrl_domains:	RCU list of all control domains for this resource
  * @mon_domains:	RCU list of all monitor domains for this resource
  * @name:		Name to use in "schemata" file.
  * @schema_fmt:		Which format string and parser is used for this schema.
- * @mbm_cfg_mask:	Bandwidth sources that can be tracked when bandwidth
- *			monitoring events can be configured.
  * @cdp_capable:	Is the CDP feature available on this resource
  */
 struct rdt_resource {
 	int			rid;
 	bool			alloc_capable;
 	bool			mon_capable;
-	int			num_rmid;
 	enum resctrl_scope	ctrl_scope;
 	enum resctrl_scope	mon_scope;
 	struct resctrl_cache	cache;
 	struct resctrl_membw	membw;
+	struct resctrl_mon	mon;
 	struct list_head	ctrl_domains;
 	struct list_head	mon_domains;
 	char			*name;
 	enum resctrl_schema_fmt	schema_fmt;
-	unsigned int		mbm_cfg_mask;
 	bool			cdp_capable;
 };
 
-- 
2.34.1


