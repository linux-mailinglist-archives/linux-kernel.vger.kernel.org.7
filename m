Return-Path: <linux-kernel+bounces-746169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B06B123DD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41ADF7BD1EF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D151248F51;
	Fri, 25 Jul 2025 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R7+FpQNz"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7142155C97;
	Fri, 25 Jul 2025 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468284; cv=fail; b=l8spdTLt1xZOTcIsOFIPLWWQ9jYERvGQFmoyIAiTP9rhSQiu/WzhV1e/v7DfelvdJ8EN3QXvtDLNXAEtjtnFE4EHfequyTQfSxu+gukt7TF6angvB3NG4oT/wUVg9OYf3TLBUda0FSfToNfDVWagKpdZSfpp7VJoBlEdbqnDGcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468284; c=relaxed/simple;
	bh=GrGKoAmjvBjE8nF8o3XT5GyfMLvPkWBk8cA3dCUX97A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pela/OBR2wCDbOx0jJq2tHj76x3OOhLbJCONXXDD9U9IYLvLCoy3rrvhDoYyxiOOkT+bcPZ9VXfV9t+Xtcxyub42O7Qg5q/7BjXKxmVsU0zibnms+Wu9e7q5K0wO6T+swZN/9neU1nLuup4VR7br/CHmm9nqRMvGc3HiLwHVI5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R7+FpQNz; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VK95fCjb/9P+H5UjKmDO2spimIQ395rTKfONpOpHnh7/GOuB1URYw4DFDx0inoJrkZY7CJum7SsylT1yrXvIQG4644n4QPkFY92cYeV5uHwoeB/Gif31L1xbDYGgpHAuREAwXZp87nd1KdkxjHmM2hsFkCbmwuppXB/92wvWGRKcudQ9HI7S3pFHXJcAhWuLzfTQ5q0WaZnbNoqrCoowX+CN/TNANA510faVqC1qoSyYC36Wo9QrGWg+4XhVylnuW52960gVxhAgOxFPYkpDXlPlvaokZwRk2CSIIp3OR7hSUryQJEjWmkGWxdAqRJSHWkvZIw7XmJ+04EZN8b460A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuruLJu7M26304ztQ3GErW2Ibraq4OGv4mtKSU2wC10=;
 b=SW08qBXDUcM5hsGcEEj/EnZbvibmhrMhunqpVDyHxO55KT/UnA9UCYKhwvQZ0AcDrn37HaIhHzWjpoRMFahI/kVAy9ZpL7qylXDPMoJQqbxyWJLoe4xRP7JQ/b+YvgOZZ24Qtrg7CuQlTxkizLCkUOgT1gw6YTwStwFOL7jI1HoD5oEiqUmRsPpuVT43Ar2HK43T5v4k0mI1hZIFR45WpoyCtprZtWxr2FHFWIladVhm40j2dTpuNDeco3mhpiXWV/eI1lmcZkuvDoAbSuls2dA1fnJyo/E00a1mz0EIeYLWfOd3OxV/AXnSoEjLkKcCJAL5su45jKeabjpFB7plhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuruLJu7M26304ztQ3GErW2Ibraq4OGv4mtKSU2wC10=;
 b=R7+FpQNzeUVI1LQLzk2fYIkRQ83CCGSiSvYHLDHG1Vo0Smeg3Mq5hLyZTL29doycXGwbeuEqDHJW1ZZ6S45f/dVqxqa58E43PXmGFVpeEthOA7TyGFtrZBzXzAWfqZhMl0eBC1oDyW3kZfbFDpD51KX1ESNjjC97n7AvqcQe8HY=
Received: from BY3PR05CA0008.namprd05.prod.outlook.com (2603:10b6:a03:254::13)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 18:31:18 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::89) by BY3PR05CA0008.outlook.office365.com
 (2603:10b6:a03:254::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.6 via Frontend Transport; Fri,
 25 Jul 2025 18:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:31:17 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:31:15 -0500
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
Subject: [PATCH v16 06/34] x86/resctrl: Add ABMC feature in the command line options
Date: Fri, 25 Jul 2025 13:29:25 -0500
Message-ID: <333d6f5ddf02d772ab6ad5cc26e65804f444fa0e.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SA1PR12MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c094708-7931-4dce-df14-08ddcba971e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X1S836AfzABIbHDk5aKjHb+8hhNCts84I5NT0o2ra3kj9aTqxu4Yvmw30ANy?=
 =?us-ascii?Q?eoDBG94s+PgFT8vgReWqyJHIY1fjHG5xSFGNbFuUvK5SFxdJOGg3dVGQxi0z?=
 =?us-ascii?Q?cdgKCWIIxfWYpuqRwhk3gpR+5Z6S0kIVeMKpSTogcjwRx2t/4ZpdOvOKYoWq?=
 =?us-ascii?Q?6IaI/2whP9J18ru7Z8szfKKLuUyWBxwqCZkwbVsKXRpgAHkiWTuAFoQ3RamY?=
 =?us-ascii?Q?lEprldPl/GRnmzGF7bWAOIg9RnePbBJpkc7FmmsfNhu4vD8ytVhjIHoOaNiq?=
 =?us-ascii?Q?vKu269hpQCJSd9Mi4CzU2/SsCaj2tOlcTxSM/ODm5EFmodcPB86KYC72ShV+?=
 =?us-ascii?Q?sLuf9LfTtWOi96PdItg27zHm+HxZp6mu731EsuLQKnRzs38mO184Rzydc+0G?=
 =?us-ascii?Q?FSVHW+08+jTIQWV5d1gOo1KEpzB81aYfKayIl0gQhj294NJYno4SooYpK+c6?=
 =?us-ascii?Q?BUd2dcm7eWdRRYb3FXF8dDMmu/5lEDeD0/xd1kG3bGvF/O1rLc2tnIAoxmfn?=
 =?us-ascii?Q?psFd2c/crxsrsPQIaiw11hKyYCgL+yYTgh2mgfBm92kbNJh5fWz6Pn4x4Xtv?=
 =?us-ascii?Q?yphoGcBYollu2A741b2uis+y/88XcTF/f7blw7sos6dAiObOInOLGO5ndTDu?=
 =?us-ascii?Q?U5WZg5TasfGa8buiP8WDQ0th+zQjrAjWUYifV6ddVF6GDwcBrDlZuW/Ye2T5?=
 =?us-ascii?Q?vtJkM04dtLJ3lkoeCSo+J4p+Qbo3OGYBqunEpb4j7hbVXDcbyBqyf+CpUsBT?=
 =?us-ascii?Q?1GefG7D8WkDSMjEl9S4IvIHfTcoNE1RPZtD37FnjRz2N/b1xHyubKjZO19JR?=
 =?us-ascii?Q?psFvFENafkn0XW1r9FdYpwngb6pfRZXQM/eykpVFW/YXnmd2yyLaFhpH3HFQ?=
 =?us-ascii?Q?culthnOo7qe79cMz2SS5acvRHXiA/UHQUS/BfFaQZCw/Ik0L9rP4T1ST6f4l?=
 =?us-ascii?Q?my1t0aiQINkvfBL7BzTRZ0zQa5lOJnJzVNTavHNL7ldXGo8sLsyh9mTPFg95?=
 =?us-ascii?Q?/vM4W1aTL3SIrHNraGqpZmeOwd7J5lX14FwZGoxt8X2hNm+IPCPGbCFEQ2Jf?=
 =?us-ascii?Q?XsZHOnJEvhceikAylcUbEFU/YsekbZH1WqSiIdACXSwJqmrU9n1LerC4qC4F?=
 =?us-ascii?Q?7/E9uBAqENl3fDtyojwb29Ykn0tI0odfWZbqJmYnLPwsna3RjYPKSUafgpnE?=
 =?us-ascii?Q?QPBMiOfLO2IRqctr5MpIS1VKItH/FUDiwteQQQXYJJr8s4C2JkZRZIGfd8i4?=
 =?us-ascii?Q?7hbjN60+bNqOEIsYJhidhKOLu+qsyvjDwP+BMAhNJ7Ne/5p9e7+aNxYk3qkX?=
 =?us-ascii?Q?Uw6RGn2YnuS9iz+Vp0mnVYRG2CON61oArLcwboDoamjdqfA0f/GZ+vMeimX/?=
 =?us-ascii?Q?tOUGl21XsHOIx40syBxvJQKL1Dq/OcNFZr8oms3hGdTIF7dTWzmTvggHsy6X?=
 =?us-ascii?Q?sg2qqodXXe+BWHoQ1KIyHZtgR8Ku2aj+NIdyzik1GtOqIqEQNhuyGduHFqcy?=
 =?us-ascii?Q?cx/AU+PfjvwUHOeFjk+W7Ycmh+YXE5z34rF5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:31:17.6349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c094708-7931-4dce-df14-08ddcba971e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857

Add a kernel command-line parameter to enable or disable the exposure of
the ABMC (Assignable Bandwidth Monitoring Counters) hardware feature to
resctrl.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v16: Added Reviewed-by tag.

v15: No changes.

v14: Slight changelog modification.

v13: Removed the Reviewed-by as the file resctrl.rst is moved to
     Documentation/filesystems/resctrl.rst. In that sense patch has changed.

v12: No changes.

v11: No changes.

v10: No changes.

v9: No code changes. Added Reviewed-by.

v8: Commit message update.

v7: No changes

v6: No changes

v5: No changes

v4: No changes

v3: No changes

v2: No changes
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/filesystems/resctrl.rst           | 1 +
 arch/x86/kernel/cpu/resctrl/core.c              | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b29c7a8dc7e6..6a74a32c9416 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6077,7 +6077,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec.
+			mba, smba, bmec, abmc.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index c7949dd44f2f..c97fd77a107d 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -26,6 +26,7 @@ MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
 MBA (Memory Bandwidth Allocation)		"mba"
 SMBA (Slow Memory Bandwidth Allocation)         ""
 BMEC (Bandwidth Monitoring Event Configuration) ""
+ABMC (Assignable Bandwidth Monitoring Counters) ""
 ===============================================	================================
 
 Historically, new features were made visible by default in /proc/cpuinfo. This
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index fbf019c1ff11..b07b12a05886 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -711,6 +711,7 @@ enum {
 	RDT_FLAG_MBA,
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
+	RDT_FLAG_ABMC,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -736,6 +737,7 @@ static struct rdt_options rdt_options[]  __ro_after_init = {
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
+	RDT_OPT(RDT_FLAG_ABMC,	    "abmc",	X86_FEATURE_ABMC),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
-- 
2.34.1


