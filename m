Return-Path: <linux-kernel+bounces-722446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D63EAFDADB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1EA217400C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BC325A2CC;
	Tue,  8 Jul 2025 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nv6tnYFp"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2044.outbound.protection.outlook.com [40.107.96.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0847261593;
	Tue,  8 Jul 2025 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013148; cv=fail; b=WU7e/JdEs78873TLpF1+0vuoNNW6LeLAscPzOS0ou1ENnEPaE2WNWS8ocT0TopBsAnAecWi28LZK2l449HuBISX0eRgJbHQqYVwNF76kgCZVavbKzWbcSAR7zWUHsu2GansT8sONuh0rHYIY+kvvIkXhb7+tCOjD37i9rIzylVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013148; c=relaxed/simple;
	bh=OFeX+06tENAWZeeq9DqDoqXCxVs8jpSrAqLJP0N8ins=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBw4xl/ISZYzjnlHxMpLqEZ4WawLD6MRv5se39Z15oJ0eG2uSPl38TIozUWdDvPEL4hNx31L67i7af1sdHRkd+x4+sACMHQMpWvxbpep09EFntUZxTZP2Cfnu0e14IH7eV7k8LqD5Bq2Y30IpbYbi8S8ZytHtdMwIGIcqa270OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nv6tnYFp; arc=fail smtp.client-ip=40.107.96.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2yXeB0/4JXFph3lgejM7hcLf28h6+WiTU8+dO3hwwVp5WB7tFIidSalK4AWkqOIQwq62EOhYpxE3mL2wNIjjw1lvxveARo1wcpNEvZuhDiRawbGRTucGsFNAPioUHi653y8dM1h3kOkZVhkZILaLFZFMMwmknx91BgviuOj9rVngLRUwylVUTzUkPH2skqE9Ehn7rZzUDg7sTCBW/MwK3WRPgAbWW+ptrucyXklf0KPwgRah4HYSewVGIorJKuUmRmhiMjQw5HsXrEKH8o5QH/xa3xqRCE/P9DyaA8Gch2vs3m0XBJ9h1S77Le6HWN1huiu/KuEewy+FZZr4JA8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CBharA3fqktsnv0bauzeJ4Ab8HZ+1z3ZLuBOR38su8=;
 b=if7ZVUH/YcIT0f51KSgLjciRylD9+WVQjyj31R6PjAwkYmIGiI3nfyZRaE0jbEqiRBfrPI7ZfV+UtadA2Ld91Zww7ObHml2h5o1XTsOhGUwj63+IZaehSrSDBJjpaLiCiX5kzMLkvUZKk5pPNdDIBc0HKaGQ1n+yhKO2ZkbGF0QM3QUWfAoihDiIQKK2dwg8od1Xbb6alHVbqNs1r01nYT8gvXR4VtnyLW+x/bZZNqFzhkFQaBIGIIJ5RKGM0d6ec4gY6WYVDXOmiU6f5hcKHhPPeWBeNk4+0Rxh35gyXsETIhmiuFTc5oE1bp7NkUDxxKf9VU4qXXEhhkwLcf+nZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CBharA3fqktsnv0bauzeJ4Ab8HZ+1z3ZLuBOR38su8=;
 b=nv6tnYFpo861eodGkHbACMRojS6+K/sGS9lQnI4/2jFXgpO40pTxjJB+VA53Y6EEpvxVrBp+Ma8cxEHo4Ot/OBJAleLaeXBslBfmxomUZXeZTNafnxdJbRCvqtpi0jLSs7fousODvcG1WXz7VSC8qI1lUE+ui27q++H2d5vrbEE=
Received: from SJ0PR13CA0056.namprd13.prod.outlook.com (2603:10b6:a03:2c2::31)
 by MW4PR12MB7262.namprd12.prod.outlook.com (2603:10b6:303:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 8 Jul
 2025 22:19:01 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::63) by SJ0PR13CA0056.outlook.office365.com
 (2603:10b6:a03:2c2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 22:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:19:01 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:18:58 -0500
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
Subject: [PATCH v15 07/34] x86,fs/resctrl: Consolidate monitoring related data from rdt_resource
Date: Tue, 8 Jul 2025 17:17:16 -0500
Message-ID: <e8c63f228c30c45d82c72b679fcfab926cb26a8b.1752013061.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752013061.git.babu.moger@amd.com>
References: <cover.1752013061.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|MW4PR12MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a397ad8-328b-4505-ede0-08ddbe6d7133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5m0K+ph6m5Mc8EHNhy7P494OGe2nhtRrixi/tUzPWbmoJwt7PA7C7fcGolCG?=
 =?us-ascii?Q?EPrHeixQtfm8c0HhYIab6xhw+jae577HX3OBK+ICRZwIbgwHwkcVite3oaeY?=
 =?us-ascii?Q?27NsLSCanSJ84vzBNWgpBpnnp6WH8RP3PxVxLCjOVICEMInLI0s34tbdsOtv?=
 =?us-ascii?Q?z/JdKqdd8hBIBnkpf0XpRG3kRovOoQY1bItBxIkINE6cyaK68CHXUalGCxj9?=
 =?us-ascii?Q?6vS3wgjMxj4FM1UJco82RSLZ5NfPc8w7hCVQ7LzOWQoUtvkDUCCzM6gk5/wU?=
 =?us-ascii?Q?YtKX4wBKJFua7UClOUxPyRt6RPZVLjgHB3XXoq+2arAe8JQiHUX5+puLeJpM?=
 =?us-ascii?Q?9CchbemBpf08Ga2eDIDIp2kVsi2WRr0ELSx5gwidIpx8DJ8NgM4FInkj4P1N?=
 =?us-ascii?Q?QGcN8YZEbX+OCFpfi14jHsRZDXzrRJI32EGkzQvAHqlnqfx180bafGVxtYsI?=
 =?us-ascii?Q?uKdeKri3sL6Q4d9MaOX2H4iRu71KgOOHwLm4ZReWOLeuc888H8QENie93IPh?=
 =?us-ascii?Q?5GozgTQA/sHUA66f/ew+qQu92TcXLK7n0Uhh31t7w8rJYwdSeoAssZ491JyU?=
 =?us-ascii?Q?vjpWjwgTdIqCUeQUaupS7Qc76M6aUywOe/ed/vWeG8cfU04KElQ7z+IKTGaY?=
 =?us-ascii?Q?svQDl+WvcstssEHD758AlwYq01t6jStpMBBYu/rcq3P7I/1Ar5vHpkNGMU9J?=
 =?us-ascii?Q?77+kDE34BakeSTEpmbaqw99A96wg1UVEPGQZOF9IJw09Rdujs4wqIjL83LE0?=
 =?us-ascii?Q?xxOSl5GULPtm8Fkr+YYEsz8HBM+EV3fu3MjuKEJ0HzhSUDf0uwLKm+biV0sV?=
 =?us-ascii?Q?iMcyjbnzxFoIfu8tisKj+2IepH0N2QgaZzHvN8dfSXQygP6cwYUWlSGs88xY?=
 =?us-ascii?Q?9+P3SPu30HWrm1fUna94szh1hjlMGNew8s56IuEmvXu87a7vc4kj8CGTGry5?=
 =?us-ascii?Q?igTfu3uls9SaI9WjNhIgkwEfWdhyAAoJphzvl1DC4YY5zFQ98rHZscaczZoH?=
 =?us-ascii?Q?zIqvdmu1MuScxOCxjK6802hQCL0z5XYxZ00CLGJu4LEgG247MIeylzRFkDDZ?=
 =?us-ascii?Q?KfJzO3mGGfSXcO/vdnmTG6yqOQLdoqe27YP/WOu36HOuN1ptAsPe8eqhJtjc?=
 =?us-ascii?Q?Kr2frkB8zDuUjyV+ymWCFMkf4HCjNgBh+lS439krCK/zLJrYFMOFBvWtVxan?=
 =?us-ascii?Q?zN7ch+xiYvQaZpI9dyQQa8aWz1zrUVVCCT08i9bDF1MNhFox235kdjnBTsjR?=
 =?us-ascii?Q?vX82wFggl564OVA5c5aCDAvzKudNMBkL/+h7hn46S611oh4yjQgfBEOtvkav?=
 =?us-ascii?Q?62w64gt7m8DHnWyo/f2XAXnmrSTEVrRme7XpLFuHt9CyamCCBHlTE7/F1e4W?=
 =?us-ascii?Q?nNhQpSI4ciZo+2l8Kt6HIv6aYdOxwPYJd+0PUonP119EvWrjWpOuNMbiwBLZ?=
 =?us-ascii?Q?SYUMMoxg29H8i60hzkzhivPkOVMz+2AoFLCUsHZdi4u4qS7kOjS+5hTP8QiE?=
 =?us-ascii?Q?AsV++p07sBSeseuY3goC3TmpfvQj9hHAVHTB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:19:01.5041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a397ad8-328b-4505-ede0-08ddbe6d7133
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7262

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
---
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


