Return-Path: <linux-kernel+bounces-757068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66808B1BD53
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA45618C0019
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCBE24467A;
	Tue,  5 Aug 2025 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r51GEpxQ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0F1244677;
	Tue,  5 Aug 2025 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436672; cv=fail; b=B7RjNFyXSP+K0t/+ml44ZyMN/FSDvVs3uxHxN/QuHV+IH8YI79S52HPSGdlMsCENvszPmPMW2TxASa9mQQ0tux/U9wp+tRCM50Y3FFAX5wQVPxcSMKUARcyckd152h9vaCYTjZ4q0szRzZ5khx9Ee+p7zYY7OsIp0k2JJgKSZ0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436672; c=relaxed/simple;
	bh=8nbfpEC0qRMQzqmxoXHSmjkFhFdg16e/o2WQLwSUUWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMP66Fs6detOFefljru6D4RxKiQWWwkBrB06yWMqoVwHR9ZxtD+jZ9vVGbRRjZr62pYej7/PptbRyqFlbvFHsNxwyA9GU1zYVSOJo4TEPLUsXyHXfs8TrcPVtKlExciAUtqugqbf6nsOJxtE+PSbLEUkyg3sI5uSeDpF+JoLeAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r51GEpxQ; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDeK7j6zKgpesXZ2BgQ09+QdeB1nbotn7CjluQN2qtxKVGOVzmtYlqK6D5p0frg7dWyxeuuIQHlOnL1U0W2bNw39XEtbvDvCULruBH4xvyxW5uANedcUdxUhQaYX74Q685zbTMBDs0i6G/osDnv+hmBGLcVHOm20kAMx+xDRZi36MOxgp5PJ7nvnduY11vFXObe4L6hDnzZQsOMgKBNhAtI+scJWQljg0QUauGhgDZ12eh29JEqVbE1Uz9pv4CU0H3m4mJydLLwOjBdG1hY8oQvrQopZw1I+o7O/vBLqKfL0HgMvqk2uduXxkFXklHMg1HZK6fOpHV9UCSHf0v0kAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=301tWcpLdHMcJvRtBmAxzwV9vjLpS/gkN8o71OqPebo=;
 b=p2cKq0pL4hCPGMHgrTioJ15M1FEMIuXmcwnzrKb1vEw3S6QmoFaY1i7Ygi6FD3aAcf0gCF+O746cg/VBsW6vfnILYZGf8kZp2LIiWfLUvOrHXQvck9iN4AzOqTVBsoIpXsUxrc3F8b9l8bL6wp7JFgaQq1n1Z+XeAzv54gFPqSXgjXcA6bod5z750Rq/IsSosssoaKItw2U2z61bx8rvX1hP+wZMNX/i2LmBRYANEK0opiTA7r6iJfzKt/XU/htMJKzuaKyNL+NXHWKlN9UGQVHBoF/TNB9eKf/ulN51jj8oR/idpSo5RRfSD2rrhmEN1mgV/T3bdCcddOAp+7X7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=301tWcpLdHMcJvRtBmAxzwV9vjLpS/gkN8o71OqPebo=;
 b=r51GEpxQrJBgeSV4D+fIGi8dkPSE97XZZhPeoCO6eor+fY8Jp++fPZKT2u4nsvDeuBxgAP9wSpC4faQFEE5K+mYo1+Xd8iPO/QoftlMxotWURsLyTsatoi0BK+x7nUGZx8N4fcfAH9WHiFGL/ATA3AXBIagwmxhUWVxAeNgVc8w=
Received: from SA0PR11CA0069.namprd11.prod.outlook.com (2603:10b6:806:d2::14)
 by CH3PR12MB8355.namprd12.prod.outlook.com (2603:10b6:610:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 23:31:04 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::9b) by SA0PR11CA0069.outlook.office365.com
 (2603:10b6:806:d2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 23:31:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 23:31:04 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 18:31:01 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<babu.moger@amd.com>, <yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>,
	<xin@zytor.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <me@mixaill.net>, <mario.limonciello@amd.com>,
	<xin3.li@intel.com>, <ebiggers@google.com>, <ak@linux.intel.com>,
	<chang.seok.bae@intel.com>, <andrew.cooper3@citrix.com>,
	<perry.yuan@amd.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <manali.shukla@amd.com>,
	<gautham.shenoy@amd.com>
Subject: [PATCH v8 02/10] x86/resctrl: Add SDCIAE feature in the command line options
Date: Tue, 5 Aug 2025 18:30:22 -0500
Message-ID: <c6fb4ecdf3412fbfeb1c12dd0cee5d52b7306e01.1754436586.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1754436586.git.babu.moger@amd.com>
References: <cover.1754436586.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|CH3PR12MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: a67b312c-0a14-4c37-8393-08ddd4782571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7YmtrRqMivtPtGIp8y4TJRQoIRkiHGCv5sO4/Gq0WZc2nmXmssGWMDYoQOXV?=
 =?us-ascii?Q?AkaQ6iFwnv8eGWsZY4uwh4WMDKomQdF4AE162xLhbUbnj/YGgMacqMMqomsi?=
 =?us-ascii?Q?NzIomnhLSKs+8bIJicNGcX/8p391mr/wnsteYtsyXi2UxCOTNEy9R/DIodtd?=
 =?us-ascii?Q?GUL5fpVWNO5ruQQEWJxIaxfk+Y1lGDWPm33eNLZjHlCd6/cBkypdWOO/mZyT?=
 =?us-ascii?Q?iurCEG2B/0ycLTtJDCdiQMBmQ2QlydyJ7LaskZLuBDtvmSsMQ4lWKGjpxiZC?=
 =?us-ascii?Q?jh8ty4zBajOKY9DO+nwob03GIUcxFUqA4LxApoz12CPPxxGEqnR0XIvBpTLw?=
 =?us-ascii?Q?Y0bBbSd28g3bNjzdolBADChrBUuyroD9RANGEVuUfhlAsIRn7u+R/p6HOf3l?=
 =?us-ascii?Q?tsxOSo02GRveL/1q3T2zrBNLu+q4lW4Qe211HAxX74MVZMYxos4rjAZaNFpG?=
 =?us-ascii?Q?QpLQlp2MNIG9J2pLDPaP7eO2nr7nxvWOspOmv8PZlYwHGQFhdYgygGestzlY?=
 =?us-ascii?Q?4AMEq+DUICSO8EhLqr8fvOQyyG8igwzaI1Nab1+q191jHYHWrFvVBlCi5+nB?=
 =?us-ascii?Q?fnEFRrWfIw3cmLysI5/7OrFFnUkf4XXHiE6QvMb3+Y/RPssrmUp2XwycCnba?=
 =?us-ascii?Q?ytY3EB+t3rlDGYF6rqTEF70C9frkVxhLkFkRAPtiyLhjtPkfJ1ra3UI+EQoY?=
 =?us-ascii?Q?9wzf/XuQkk+Y4ugqGFJzsJhsRx1lb5cUzyb/WiD4CK+oW3M6Yik95GrHSaLG?=
 =?us-ascii?Q?YXySHUTTEoIMCZTCpXcD0LeHz8MNBrLGvWIr5dmQS1oikSDra+oil6SnCJAW?=
 =?us-ascii?Q?e1hYLJR9uzShRVFy0gMt0G967BQ9O4KlLxU8YHbgERpougOK6A1GIqSc6YBe?=
 =?us-ascii?Q?EXKUeTz110NuJlzdpN41c7RkOTfCMK+LZE62351JHY+ze4R/3FRV1kBByCrH?=
 =?us-ascii?Q?0X4UV7/hcSk4ErtYH0mTiypm0hF2p9cIO0XpJeBOKLPHihwZoe+LflMDLXwH?=
 =?us-ascii?Q?sfH5xPFp9bQroi4uduUtmF0cK8JHE5TpHLLIjuo67aKJWcsksm6VMccPjXHM?=
 =?us-ascii?Q?s0OokJfRxbF32TJsbAMtk/p26nU2LLNUoazgnXEXDTPSarcoZ4RSk3T+Zpd8?=
 =?us-ascii?Q?MB1sy/CEUfwUGviXNEDKmKqHokDLRDFlPIULNow4f1j+gaMABktLOKfJu/eR?=
 =?us-ascii?Q?dOnYg7XRpHhPsxtM7bhpJ8Put9c2w7kOJsXI/SrYCzghFArTinbu3/fhEYzH?=
 =?us-ascii?Q?4FSGa8DbAoVir8hR6Sbrk2iLQQHw/bDo0O1vbKyLSp4clqZ0cwZItKb+PbVh?=
 =?us-ascii?Q?sS/6S0iS99EQb8otPRbgN6W9FJXzBfg6DnpLxQSlOuFpvsrXQ/0wc5SHwFXF?=
 =?us-ascii?Q?TydbyZt03/007hmEe0bJ8TsXG86lk/+x4z2MiExKDfdcyC+QZrIqkYNZCmrM?=
 =?us-ascii?Q?kBBlonZ31741KTq2kMJ5l16dKJqEd+VzNdVjsAfWP//AQVI9dRNzaLWm1k4k?=
 =?us-ascii?Q?7qipxWfoitHZtcVoFI5EcxEl20H5RZyp3dlX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 23:31:04.5190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a67b312c-0a14-4c37-8393-08ddd4782571
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8355

Add the command line options to enable or disable the new resctrl feature
L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE).

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Updated Documentation/filesystems/resctrl.rst.

v7: No changes.

v6: No changes.

v5: No changes.

v4: No changes.

v3: No changes.

v2: No changes.
---
 .../admin-guide/kernel-parameters.txt         |  2 +-
 Documentation/filesystems/resctrl.rst         | 21 ++++++++++---------
 arch/x86/kernel/cpu/resctrl/core.c            |  2 ++
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0d2ea9a60145..0170c0af03cc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6089,7 +6089,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec.
+			mba, smba, bmec, sdciae.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index c7949dd44f2f..f08699030312 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -17,16 +17,17 @@ AMD refers to this feature as AMD Platform Quality of Service(AMD QoS).
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
-===============================================	================================
+=============================================================== ================================
+RDT (Resource Director Technology) Allocation			"rdt_a"
+CAT (Cache Allocation Technology)				"cat_l3", "cat_l2"
+CDP (Code and Data Prioritization)				"cdp_l3", "cdp_l2"
+CQM (Cache QoS Monitoring)					"cqm_llc", "cqm_occup_llc"
+MBM (Memory Bandwidth Monitoring)				"cqm_mbm_total", "cqm_mbm_local"
+MBA (Memory Bandwidth Allocation)				"mba"
+SMBA (Slow Memory Bandwidth Allocation)         		""
+BMEC (Bandwidth Monitoring Event Configuration) 		""
+SDCIAE (Smart Data Cache Injection Allocation Enforcement)	""
+=============================================================== ================================
 
 Historically, new features were made visible by default in /proc/cpuinfo. This
 resulted in the feature flags becoming hard to parse by humans. Adding a new
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 187d527ef73b..f6d84882cc4e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -707,6 +707,7 @@ enum {
 	RDT_FLAG_MBA,
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
+	RDT_FLAG_SDCIAE,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -732,6 +733,7 @@ static struct rdt_options rdt_options[]  __ro_after_init = {
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
+	RDT_OPT(RDT_FLAG_SDCIAE,    "sdciae",	X86_FEATURE_SDCIAE),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
-- 
2.34.1


