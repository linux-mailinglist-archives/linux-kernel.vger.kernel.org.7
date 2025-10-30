Return-Path: <linux-kernel+bounces-878770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2710FC21717
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96EFF4EEF97
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5395A36838D;
	Thu, 30 Oct 2025 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nt1FjlE/"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56D223EA80;
	Thu, 30 Oct 2025 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844572; cv=fail; b=KconaYT44cirjacWe83j9FS1Wd+2N/JE+A3b3dUW9ga5tVYgio4Bl53xf6wWqLOTCAqfuRIPnMBlbjEy9IsvvFo4F6GxFC5SlV2HXYHUANrBxnuQedvy7wOMBnEF7FmjHEMiJALgKRnvmIrF7OeVVsz//hXUjqYTpQr2MFIBDBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844572; c=relaxed/simple;
	bh=YMOMOSDVSdn/51ZCvd6RVe2+r9VzqGQcg3+1pgq5yl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRnbXp93JyCjRyO2OX12toeE7JLtpQsCQJbndjNl7mp5169b5zDO2G/54TsvYSlKX/V6T49dW2ja7k9GWuGpD+GQBhQy0SKsdZBqRoMvLmXs4i6umXQi//Ca0f3jbFRA1DG8R6H43VFM0C/JIAviFH85nFopLs0YHyi4f4ZAdR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nt1FjlE/; arc=fail smtp.client-ip=40.107.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLDnUK9TrPy7venO0WnulL2+tyivbayr60fycTyiXdZduNTlEFfo8XFoE2gOsQBH6BAV6MvRfN2EiYzmigRjEtct7ENEjNrjLo9n10GzDX8TZqMVhf2c3ovUxVj4hcQdPvodIk2Yq776gN4a3AS8zcJ54j51JZMarQWAsnFcZzw5eirm0lHZ3xoKXOadgn7CPAHlcK5ISpxAO2cqKCA/MrXnNRJjsJ9WUHN5wHzPwNdtvFNZXdkoVhqtAW5k+LlgmKbfCMTND2vjUPFutLpFKfN8zBRrwMps3LHerZQwFScfLxvM3ox6IvF2ufWlu03n1t7rWzGAHkY0kO3SXdNbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOtCQxbTI+rioWWIiAedzqPFaxUVtOgIaEpZDgSr6tY=;
 b=PPUyFvHetjBKlKKbpLoqUcFI4EBpBesRC7gP8OmbKnzsZ2KO65T42Gz7vXDP8VmcVqNKAiNmfEumhXBOsx/WpN74LpEWwrlF7rfDyFyt1DYTMW+a2DvV16AU7d/w9wxJhu5qibI1l60qKGKG/2q8cdwNN5uQmXS+imWIgMOzX9TWA0OqmS2lTLB5Vhys9hwJcw5duXu8rDNZN8e4IPThkk0QrQZTdBcad2hXghlOpKlTSZHjgJ3L7PJK7hobYYVzcTr8/g0/gKe6BQdFziRajftUWoGRn7arO+poJcEEDUkp2ip1F6LN+7Za8XkK+Zun63kXVx+TnSvmDNByIcmGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOtCQxbTI+rioWWIiAedzqPFaxUVtOgIaEpZDgSr6tY=;
 b=Nt1FjlE/hsd9q9oDEk/NrxmslKRukB9x6QtIuFDrsLnLl6/XmJGyOpedhD8IctW4uincvs+L/B17F/d8fN8lSvQNAb8uBOLj+HvOWT36kLDqG7ZakV72XPUGtt3JEZv/ox+e1FMsqofIBK4Ng196eaZF2kW8b4Uau29ZnaRcHWo=
Received: from BN9PR03CA0984.namprd03.prod.outlook.com (2603:10b6:408:109::29)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 17:16:03 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::8e) by BN9PR03CA0984.outlook.office365.com
 (2603:10b6:408:109::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 17:16:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 17:16:02 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 10:16:00 -0700
From: Babu Moger <babu.moger@amd.com>
To: <tony.luck@intel.com>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <corbet@lwn.net>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<babu.moger@amd.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rdunlap@infradead.org>,
	<pmladek@suse.com>, <kees@kernel.org>, <arnd@arndb.de>, <fvdl@google.com>,
	<seanjc@google.com>, <pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<thomas.lendacky@amd.com>, <sohil.mehta@intel.com>, <jarkko@kernel.org>,
	<chang.seok.bae@intel.com>, <ebiggers@google.com>,
	<elena.reshetova@intel.com>, <ak@linux.intel.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <feng.tang@linux.alibaba.com>
Subject: [PATCH v11 02/10] x86/resctrl: Add SDCIAE feature in the command line options
Date: Thu, 30 Oct 2025 12:15:31 -0500
Message-ID: <f2d4b24c04d0e1db05af3c5c3d077f6fd09d158d.1761844489.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1761844489.git.babu.moger@amd.com>
References: <cover.1761844489.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DS7PR12MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b468fa-1f2d-45a3-744f-08de17d80079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5CDAGUesRjKDUXVjOOGA5AFrsO24XsXFPCJ8Ieixc96PybwSgDg5YIxHvZQN?=
 =?us-ascii?Q?3O7/yn6RB43TzMXJpP1jEsXuEq9jXBO/m4ra8CKt8Z1fNcdyVbj/ithZ/bAo?=
 =?us-ascii?Q?kb825217zYbhFq7fbSV4f8TpGcZui9HBOXdujOTuQ7hhOihYYAQARb1rtpYz?=
 =?us-ascii?Q?foFgjKHEoC8i13NFToVuKLnXW+GasSfYaYjdYiqNimD8oVrlZwpGMfGIGzvH?=
 =?us-ascii?Q?kYK9O5cvpHWiNcwyl2SDualu7GZAYXln8IM2o4Ovo4dnjukFLChyVhKQ3R51?=
 =?us-ascii?Q?ikTTPABxjr7oegzTyK6BSbSZW9F5vTB2ApGVCP1Y5YYddIZgyBknzi8veuh9?=
 =?us-ascii?Q?qE/tH8WWdQ92RH8RpvV6pusjXZXwikUiA1GJvvMSP8bYAoYahyCxS4i1RDcu?=
 =?us-ascii?Q?pHyShbWdNtepoqmvoqSpb41PzjLoGQGXeFBUIt63PtVPttxbR1FeKCiVnaUA?=
 =?us-ascii?Q?jBs4+ojsYZ7iTwrxH+krvsf8gh9JhX2ifRB6rTpN3e0Q5jc4VgEOZmCsy2aJ?=
 =?us-ascii?Q?DBpq6FeBezaEi3m8KiXVmabvZ2BlGfrEnK6D1Ueph1ZUOAZLnH+jBAuGdn2k?=
 =?us-ascii?Q?z6mgStBo60PisHXbMqDeD7EDLXYpWHBUs8SHEm1FsoZzcJKYGXAqFzDuRfZU?=
 =?us-ascii?Q?A8Pp8MyQv05ECTyCeNuGDHVkG91B/fdn1OSuj5fAgeDZwd+kwhs73Zfqiz5O?=
 =?us-ascii?Q?himYQYu3ZC3VjIujS3LZ2LR1eeJYSNuv3cTR8A22qzBQBIVz6TVFZiMcmuPB?=
 =?us-ascii?Q?pE8BwspaXSc+lLMbjANqvzOHYkFTrc6Lqh7nRfGNOiiRINllRU3sdldGc11z?=
 =?us-ascii?Q?ZQZ65J8F7rrSJSSkH6JoU1hVAXxp/Cd/AArmHbzCWGqCCznVIy3nvAs4Jl+X?=
 =?us-ascii?Q?UI5+5JLF5tMbNwhgn4uGWMSU6KmnNjE9r/RiVBAH6khcYNrqMVgOV9L7t2+N?=
 =?us-ascii?Q?xm/t//i+mLfoYGCpPBTWlSQhhja+a/FUlZStP+KMdTxRMV45vmZARVTCAQbT?=
 =?us-ascii?Q?TsgjX3CZihdgj0/wB+tpOBT31ngol3xQ+Z1TpBGWH3ldHCnUun51ua+3zOES?=
 =?us-ascii?Q?YIeyuDHteRIR6QVBfO37/GPQB0r4zctnpt+HOB5Ij+pJrNwStjEpQjZzqPK4?=
 =?us-ascii?Q?RH2xBL+06Ky0RW56dwPpzbcxt7LnK0FBli504FFkQkg7ADqxGgo2dwzIFwVZ?=
 =?us-ascii?Q?Z7Pq3IgQDBjxHLqMNzDNwh2JeIucPV8mLSOs7sEwg2gAkV4FL/t4dJ2gQ9ho?=
 =?us-ascii?Q?rW8QRbeiz1fowJA9KCFIY2PcRVIdzxdOwRWB2rY5rdE+YdONnuAqLJRsArNj?=
 =?us-ascii?Q?u2Wmc4VBlhp63EbhsV17W5YVAo722JWJmhz61VoRWRwtJHB1/3ExVLPq/Xt7?=
 =?us-ascii?Q?wJUO/3gcGYDCbWDH6q4EHFP1hxLwcuB8PaeXeNszRkYo4eme0Yu/08CGdOQB?=
 =?us-ascii?Q?OKY7l+GteNBgWyci9NXOupRubVfDu5ly2A3FfRyZ7IoD3ZTdeosAbafFIjMd?=
 =?us-ascii?Q?fPoOSZIhJqSoLbtEm6KcFkP7hfY02DxoWUJUDn1LRO48KBu3dpIMCKoEm7jG?=
 =?us-ascii?Q?1PiMu3VF+D9M2+5HZ/M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:16:02.1089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b468fa-1f2d-45a3-744f-08de17d80079
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083

Add a kernel command-line parameter to enable or disable the exposure of
the L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE) hardware
feature to resctrl.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v11: No changes.

v10: Changelog update.
     Fixed the few conflicts due to recent ABMC feature merge.

v9: Minor changelog update.
    Fixed the tabs in SMBA and BMEC lines.

v8: Updated Documentation/filesystems/resctrl.rst.

v7: No changes.

v6: No changes.

v5: No changes.

v4: No changes.

v3: No changes.

v2: No changes.
---
 .../admin-guide/kernel-parameters.txt         |  2 +-
 Documentation/filesystems/resctrl.rst         | 23 ++++++++++---------
 arch/x86/kernel/cpu/resctrl/core.c            |  2 ++
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6c42061ca20e..29db32a86815 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6207,7 +6207,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec, abmc.
+			mba, smba, bmec, abmc, sdciae.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index b7f35b07876a..d7a51cae6b26 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -17,17 +17,18 @@ AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
 This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cpuinfo
 flag bits:
 
-===============================================	================================
-RDT (Resource Director Technology) Allocation	"rdt_a"
-CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"
-CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"
-CQM (Cache QoS Monitoring)			"cqm_llc", "cqm_occup_llc"
-MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
-MBA (Memory Bandwidth Allocation)		"mba"
-SMBA (Slow Memory Bandwidth Allocation)         ""
-BMEC (Bandwidth Monitoring Event Configuration) ""
-ABMC (Assignable Bandwidth Monitoring Counters) ""
-===============================================	================================
+=============================================================== ================================
+RDT (Resource Director Technology) Allocation			"rdt_a"
+CAT (Cache Allocation Technology)				"cat_l3", "cat_l2"
+CDP (Code and Data Prioritization)				"cdp_l3", "cdp_l2"
+CQM (Cache QoS Monitoring)					"cqm_llc", "cqm_occup_llc"
+MBM (Memory Bandwidth Monitoring)				"cqm_mbm_total", "cqm_mbm_local"
+MBA (Memory Bandwidth Allocation)				"mba"
+SMBA (Slow Memory Bandwidth Allocation)				""
+BMEC (Bandwidth Monitoring Event Configuration)			""
+ABMC (Assignable Bandwidth Monitoring Counters)			""
+SDCIAE (Smart Data Cache Injection Allocation Enforcement)	""
+=============================================================== ================================
 
 Historically, new features were made visible by default in /proc/cpuinfo. This
 resulted in the feature flags becoming hard to parse by humans. Adding a new
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 06ca5a30140c..2b2935b3df8d 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -719,6 +719,7 @@ enum {
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
 	RDT_FLAG_ABMC,
+	RDT_FLAG_SDCIAE,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -745,6 +746,7 @@ static struct rdt_options rdt_options[]  __ro_after_init = {
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
 	RDT_OPT(RDT_FLAG_ABMC,	    "abmc",	X86_FEATURE_ABMC),
+	RDT_OPT(RDT_FLAG_SDCIAE,    "sdciae",	X86_FEATURE_SDCIAE),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
-- 
2.34.1


