Return-Path: <linux-kernel+bounces-898395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5AAC55313
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C331734DC82
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E052523909C;
	Thu, 13 Nov 2025 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JGK+pcoA"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010027.outbound.protection.outlook.com [52.101.193.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA6E2147FB;
	Thu, 13 Nov 2025 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762995488; cv=fail; b=eesD5gG8+ttiCq4hGXHYkTYRpmV25XU2CyqOfnJezAD+FmxyFMydpIOg3ueDQnfh/uB1HQJrvpP1e++adu3FEuFOM+vq6NZ29xkXJl3gCSVkX+6+gjSUFZNxpTpA4HKDoRVFG4zoHSta/Zkesl25/eX6QyRfwg/HokbbSV/L6wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762995488; c=relaxed/simple;
	bh=W8zT/AW3F0zhrowopmWgwzdIxHiZQsEjCFAtLYKck8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GyzYjyDKj40Foxt0Zq+aUrezyylC6rg3Jf8q9vARU4I4OIbEgluZhkiUC6di5YYr0gJS2u9iWsVqHEtydS4gnqlLhPEb+IsmnZXNiW6XuqBrviLqvh4pu2JUSLfgkehwJWBRhlyepAs76o4MydFF1Sv0B7dCknK9uQpi0Xek9Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JGK+pcoA; arc=fail smtp.client-ip=52.101.193.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/+7t0Y9ATxTjm25uhrAEn+1iL40XN2faOc2X6MY44egIY8+TgtWhmgadoq5QHuayPPKmol0RatN9JJ1GlNCMQyo+qh0/62VeI+6EdPFByt8N+bkxGjSCGXkWyJ+xFZDBpwcrbCX4+h9SH138n/+dZsJwu3pNIEeYPmhLawF5dHEPoPwdfFDjJNOxAszRJyA1eXyG6LK1eFnU/I9msETJkRgiIvD4VX3gUUR6br8WZiRBnqradlgFZdjt9d3vcvirN3aovf3LSxVflUcfhGgc54TezNWHfEySzXa3MTACeo4zkIpf/+LKglJRrbBFf8Vx/06kR1vbZQZMchwgQBiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogTSMzFtRvqTfYx9HOZ4V3VWdr7El9In8ZqtCY744o0=;
 b=d3cvAJlKBPUrOvth0yVy2AmU/v7xguG+1tfrTPU0DH5JPSoroEMDHd5l0voNijSPAxpAW8FrY5ta8lS6oHi98naqK/dcfmnLYGKx/pp2wIczqcxaICW1OEWfTbLIQXp2upGmQdbmueEynXaKC5rcBTKR1HuCdARE2JocXlx1ieKuv1/qeoGCgp6wmmzwGeWbo1xEnUyu1A/BWQa1HEAVb5iCcqGASuvTOdTyvnCzp8yA7cCp6F6Fiap8AzZh+rkFs2g87SmGJvLkn2ylSrpQYFRpSajwqDfaVI+MzgWQx4/CFvbLvLYuXGItogqrXkZnBcUCtVG1GlyhlACmc4R97w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogTSMzFtRvqTfYx9HOZ4V3VWdr7El9In8ZqtCY744o0=;
 b=JGK+pcoA6ntK8wPeZ7fwV74LZXxEJcL1q3/FdExuNtKc3b+CnaZrKXv0SdAQcLw+xBoPA6Onui52bFAoGlMUhGgWGWimbpp1yqtbEhhjJsXWXJHyHoHkbY3Ms6quEorme69U8NniHeWCfC4OP9sqPHfozSEt80LUXO8iHJJsczI=
Received: from CH0PR03CA0440.namprd03.prod.outlook.com (2603:10b6:610:10e::29)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 00:57:59 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::e5) by CH0PR03CA0440.outlook.office365.com
 (2603:10b6:610:10e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 00:57:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 00:57:59 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 16:57:57 -0800
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
Subject: [PATCH v12 02/10] x86/resctrl: Add SDCIAE feature in the command line options
Date: Wed, 12 Nov 2025 18:57:28 -0600
Message-ID: <c623edf7cb369ba9da966de47d9f1b666778a40e.1762995456.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1762995456.git.babu.moger@amd.com>
References: <cover.1762995456.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: 305e99c9-2773-4b4a-18cf-08de224fb095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TM7cJDIenKhKQOG2boOqKdtvC1FJJ00P/hQ190A5QGjDl57lm3O3kCuoqdcJ?=
 =?us-ascii?Q?Hrw7vhvH34AALDQGGESodEgm4NPLxjQ0iG+3bFziJ5T7PpJw0RKj6z7QW008?=
 =?us-ascii?Q?MQ+ax6Mjeh3dYJ8W29533dwbTZNz6BAvzitwBxOkvyCd/Pq7cEShiP/SkzRf?=
 =?us-ascii?Q?dW54AKYZGFlY8spJ042NRAxYTDSzalXPWk5bS2gIa38nSvuzhgXxTkOdJQwD?=
 =?us-ascii?Q?7zUxtY5yPB/NsMVf8/63SKHVel/+H6Seekg2q3+1EsaYsVft9SwbMjK1Tnks?=
 =?us-ascii?Q?WHbA5vAehXq1nkWOo6K3CakUXJGdAN+Lc99yLa+IFJRkZ7hYoHQHje1YfK2C?=
 =?us-ascii?Q?YJfbm9jbilxlhm3XCXugZx1+ksjwkw7Wk0KXvwX4J9lG3WAhMp+JJ0ILrrmW?=
 =?us-ascii?Q?JY6c0g727dmXHWyucbTv0OHoaQAVFriwv2V7C8jMXvd9f4SzAC6XJ4I9G0cZ?=
 =?us-ascii?Q?D1FM9FBXFI+imWcPxTf4EJNXI0r8nIiMIb/HjUBQzlgWzIBOHvkaqHCJ+48l?=
 =?us-ascii?Q?bobZivdrngp2EDPn+lG4BynLw0YoXdmkuvRsmvX69rnM9l56aWqrrxg7LO4W?=
 =?us-ascii?Q?1dgSNI2gpudaWgi4Dxjav9Ve0gqZc8Xk14k2Rp1oDQ+ems9NIk6Bi0hdYzmm?=
 =?us-ascii?Q?zPuvpeNX0bWBCED8Eauzrl9d0yvUrgCuTfNoEiQvX6E3w75N2xoEV4VoQSxQ?=
 =?us-ascii?Q?+5SlAaQzuhJUIVCnzpO5ORMMIaEjqbhJln20Vzy7NLcT2nc18ZmPiey0cCTH?=
 =?us-ascii?Q?jmit4Y/s061T0YVQD9/2gzVFUD5fK6vI8RFBrp+OLMaxfn6AkXPSiLS4OTpV?=
 =?us-ascii?Q?Qrv7eI1sIKgUpN6UXSnSjOMB84QLdK9ZGM9l5zmBD4futxvKvKtpkI9y/ey9?=
 =?us-ascii?Q?xJZ23Jcj2I95mbaQYD8CTjus48M6jp3U2z74W9KQrMu3zur+oyN9AFcIdTTX?=
 =?us-ascii?Q?WSb+BhKyKyih/brKw1ew7KyPjh0JVhPmCU0YIHT6hT5XgfOGUiFSzk9JW5Ds?=
 =?us-ascii?Q?c1zk+z0wSAjG61zEasyf/iezdehEyzQlzvhJiL4zR+MukR/50mvSo0wuEB2B?=
 =?us-ascii?Q?HX6Zlq3WMBZ80DHPJsM3lYpPjZ9SXGno1Coo7Muh7FKg9Td4Pr2atZGOE/41?=
 =?us-ascii?Q?fD13cp9Jf5kjX2dfkiDK3LREatD7WXNPOsHu+SBd0gHfgLqFzXJIND4qwyZC?=
 =?us-ascii?Q?7EObSAQJcSX0V+CH0wTPFrLZEEgkxOzoykXN+cMujJrH0ZXjECejR0ejCsXI?=
 =?us-ascii?Q?lQKQU0DaZdbCeO6A4Z63X7RHlaVHeP+FVQGLNQuHyq7EqYe44mb/1QWNbqtc?=
 =?us-ascii?Q?hw6VTLFqDdOb2XwYbs2nsJC6BzD9jWnjmT+gcbKT2zv8HwJzrFJ5pDkE8Dyj?=
 =?us-ascii?Q?UHpYCSMszRl2GfV/vpu/AZXQO2Qt2x0sv18uUkQp1/5g3BFPqjRs2x/US5xM?=
 =?us-ascii?Q?ibcO0NlaiX2INITBTxJaPCEv8BtIWp5hobgANoZ2b+dpzQLg0+xIFnO2nwcd?=
 =?us-ascii?Q?iHoEPMiav4cVvcSAu3XZtSb89XxzYRC+/NwxjlSNvruSJ++xVez+51dQhwAW?=
 =?us-ascii?Q?xOCBx9TJJwZOiEERxTA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 00:57:59.2961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 305e99c9-2773-4b4a-18cf-08de224fb095
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434

Add a kernel command-line parameter to enable or disable the exposure of
the L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE) hardware
feature to resctrl.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v12: No changes.

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
index e63827475792..8c5636a120ee 100644
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


