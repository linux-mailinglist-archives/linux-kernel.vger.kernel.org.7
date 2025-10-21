Return-Path: <linux-kernel+bounces-863883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD80BF9667
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9FC5189AA52
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329BF2D94B7;
	Tue, 21 Oct 2025 23:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="glV4wumP"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010025.outbound.protection.outlook.com [52.101.193.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689D22D5A13;
	Tue, 21 Oct 2025 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090944; cv=fail; b=sxFxZUKfVGDO9J7TeWF46oXkg9ZZ1zByoNeA2IhMF/3RLWY8pBy1Gmtow1eHhHTXhLGs57np602ZHp17J8bc/B0wTv1d91jjD20pzKFbYgLg+kLbhYOIj3hIoAJVXXTfShS0+pqthfSU4gvwko8jl4igEMmRHIci/Kg4d7T2q9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090944; c=relaxed/simple;
	bh=U9dQWck9naon7r79K43Wa5VBmemQTrcDEOQwbPUzPbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlz9K2gMYq3hDkaXt/k30zXRGF8dRgE3PzV5vpHy/3AwRr+97tKVjFCpZQo+dwC1XzwIJ3B6LQrQA2mjvifdC3RL3n6+DeEHRMK3of9dIYWUlkLbJKVx3hnTy2JTQS49ihqTlEDG4GFIUku+VBtBVdKUQTnizf6dJtfrZS71fIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=glV4wumP; arc=fail smtp.client-ip=52.101.193.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRvsmTUDL2OqLzq6U419TQNAmAvryTfX3nG+naIzDFCanbwP7aCT9OxXM3EvUOqzZDj6m2xwjuDj9RO0+RIukq5GRAbgrbwrAsQw+ar/toqkO7RNkgBI6ecOhA1MjXMbbygcLSXN1d0zyeVbeH3ZGRDcP4H943Bruv89GLjYiwrTjjnWM7P6wUpmDFdCkeCvT1zwNlcdxbJ8V1Kls7rBa4CjZhLxWV49VNlPzpG+8fKUivc9T0gQ26O3N3PrXRYi96PuMGQCzowGsm6g/RmmRXw+dYSr74XJwW2oHxlTJleURRC6irQGYFAXfBE3CqbueO0Fdo8WZUiiMt+1K2BXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8kJA3hKYUo1I/d1wDsZ7tHGRv3OKOMb3P7qDdRDFFs=;
 b=AFjB2fkAV+sC99xsHe6nvMAxVMkdLG+d0/PKIyux5fMk6CEnwsbUATNbkgOOqT48uk3chUAW+qIb9m3v/VVA3jxuBuOCzZlntQrTzJeALUs3bMLgKD+x7epswM+BnDfdeD6RnzzXDaf7s5Yem3hmvFK0oKiciSixQRaFfY2PyHKs9+vQrb3nuZQRj+vgBw/f7qr45OHP4sEiwSXyoGRBxLHqQp3fhTzCWr0ifHjCP20ERhUEQCLHUZ0jXEm4Xzak5M4EQdZnyWkCqDEpkZJBFIQ0xETzSjvy6nJ3pV7yetPMmIgAvpXF7wcrDNYbfyfepZuLGAxkkUQaJeYd/fGRmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8kJA3hKYUo1I/d1wDsZ7tHGRv3OKOMb3P7qDdRDFFs=;
 b=glV4wumPp0spWHgPa2aw3iGCgXl85y+AOHh1awEcNEfqIjesjoLu6KavpvR9our2K7/6oWfPyIHNNMiz0wWYnSran/aBcFTTxmjjxxysoc1xil3VuUj3LK9EV0imlbAK0o5PPLVgA/m0yUE+s9fq3umcA6VGD9fgZ73ap0bptwo=
Received: from BN9PR03CA0920.namprd03.prod.outlook.com (2603:10b6:408:107::25)
 by CH3PR12MB9250.namprd12.prod.outlook.com (2603:10b6:610:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 21 Oct
 2025 23:55:36 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:107:cafe::5b) by BN9PR03CA0920.outlook.office365.com
 (2603:10b6:408:107::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Tue,
 21 Oct 2025 23:55:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Tue, 21 Oct 2025 23:55:36 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Oct
 2025 16:55:34 -0700
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
	<peternewman@google.com>
Subject: [PATCH v10 02/10] x86/resctrl: Add SDCIAE feature in the command line options
Date: Tue, 21 Oct 2025 18:54:45 -0500
Message-ID: <490b84c9723027d4e7e4cf0018a6e472a2900469.1761090859.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1761090859.git.babu.moger@amd.com>
References: <cover.1761090859.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|CH3PR12MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: fc96928d-825b-46b9-248b-08de10fd5483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HAU9MPPfQ2BSmisrY/P7jQ/48XqxezmzSIckc9tldMGptwnWB7z1phijK2vV?=
 =?us-ascii?Q?uuovh9JvNJigUESqghrq17ZXBJwc9+NfZ5JJWbHv5lMMUBL5qqD88EuSSRI4?=
 =?us-ascii?Q?1XpzC+/X/hgdfGPzcr0XV+w7U+F7numBUwsYjbx3CGtDzgwgrA4S853ZIMSQ?=
 =?us-ascii?Q?otOdLk9davDVwAhAcOldxWnxgStN4dSadCw1Mk74xDTAktXJyJ7r/eoj7WHn?=
 =?us-ascii?Q?MTNcauhEyT5mDBl2Zzc+TzzCSfJQvki2EY8z6hUZs2zzaOSAsz+lIiVXRhnX?=
 =?us-ascii?Q?AFPQ18VoD40N1Y4/kwnsKgN8xJX7OBcJ3bOqdox9zu6wC1a66SDYMnw6cI+H?=
 =?us-ascii?Q?hwbXWwtv7BU90iy0qY1oh4oXz4TlgQ4X9dadeR1e0jeq8tPXquMIxuUS6iON?=
 =?us-ascii?Q?F9NYaNo1NX4hgj1EvlMKIfm30rYUMvFIUZ34nnnuCTLH5RaL6J1hhioByMCq?=
 =?us-ascii?Q?mHBf3X0klVFJQgs8p3En7IfcB1L3eUZMD6ZbeAJGOeXd6+QutKar8yFoAa6B?=
 =?us-ascii?Q?XhKo9dhjuY6YyuNJ1Eo2ZeCiRyTQ/lJGwc/+kNpGJ9dVUIT8sA/7NNhQcDfF?=
 =?us-ascii?Q?Tjlha4LdJLfb1ieMSDznlIEiIC07BRJ2Wti2JhYT3Bmg6i3wIj3VgNIBUjMD?=
 =?us-ascii?Q?sP7hVqh1WWRMQn6EWR8OsxtI2f9QxCzds4ylfnGBJIOzT6J4nfCU/jylMf1C?=
 =?us-ascii?Q?Z3tIOKussYyCwqWleiquzMUZhsbLlV1oYcnDc1OADHcehxuxskL0QDchfMPO?=
 =?us-ascii?Q?w7jqkBMetyO0bPCOcKE2G7kWPvx+Eg+CMOt/O5XfrgO0NDWqifOeaEvJxfX8?=
 =?us-ascii?Q?6pxnTMypDToCM7UZ7k1z29SHkDHx5q5ZhJHmWLbV1SRRPPVjqog8jFsM9QkV?=
 =?us-ascii?Q?lSrSFbDBZRuLEmdokXQloW/JIqE5Nl3bVWXMtVbCoFmTfTT4boEcq8GXYSoI?=
 =?us-ascii?Q?0DCBcYc1AYgG4d6shRelobssrGkgkSIHC9upYynBMcv0KmcSX2rijMggZvHB?=
 =?us-ascii?Q?G9fh+FIim/G6tC/JkKr+zqcU7hRye09Ei6EtRetpYKOvDGum/ykh6/M7wuT/?=
 =?us-ascii?Q?iOn6riuSduTDv/9YtxdzpOjrCNwn4zv39CgvwKzYNLTPTss2hQi9NjxaBVkZ?=
 =?us-ascii?Q?DRi397ENdYxOgQqfG09EjVa/vSyHkz+PffI7OfTSt3SL5YjMGAinGJbNWVZy?=
 =?us-ascii?Q?BQUchK9zN+dBHTxTw9heE8bcFcCpsNzBT+KvzAZLTY7sKkb70fduvRVTezdC?=
 =?us-ascii?Q?LpH459nnnZvAMTrZvz6Wx1uRpylJ+g+sl6Dkb7Q4/7gCiw/51TTaOrsXke8w?=
 =?us-ascii?Q?yqR87vCdQDFR+lLrLrdQ+Pa7+9FASWQfakNnX41s2Kn5SskmpwsQW189BQi+?=
 =?us-ascii?Q?jnwmErkZ7aR1OeitNfV8zRR5hTggI0dlksqvuQcN1wSxi7cQyR65m4S7YTrG?=
 =?us-ascii?Q?aEVYs/LxXvkcAAkz8XUx/eXn3dvP9sIBb3tqCcFbBehoz5Yk67g467ESiy2X?=
 =?us-ascii?Q?km7frD0qzOsqyov7LNtFPjysODqggeFeBghx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 23:55:36.3421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc96928d-825b-46b9-248b-08de10fd5483
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9250

Add a kernel command-line parameter to enable or disable the exposure of
the L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE) hardware
feature to resctrl.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
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


