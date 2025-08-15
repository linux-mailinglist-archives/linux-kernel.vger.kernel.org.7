Return-Path: <linux-kernel+bounces-769994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769CEB275B4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3AE7AD998
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F23D29A9E1;
	Fri, 15 Aug 2025 02:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JqKn/Rfu"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D5E298264;
	Fri, 15 Aug 2025 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224809; cv=fail; b=gpBYEV4SFVRmwczCNZaUzbuvnNzS4f1Jwk5Rz/O8HF1obDE/xu68iOv49b05FS7aCL/Nj7dHItkR3JGnC8lcgRNsgeaJcqlu5+JRA8M0EA7r4XZGDTIWzIWhhMfoBac/vPhg+ZWaXje00NyfCCyHOMnR/Lfy74Bwomr/IZOgyHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224809; c=relaxed/simple;
	bh=X6xOGmrN/UIDVphW05+VK2x9RjSIHZCKsUF9XjiCcf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thCT8I7NTT04WK2W+vO5gBrJMSrjCU4H5LaEkvF4uVp0YTvuqQoSu49s61Gk/Ar1orstIqtARMrVsW0c4F3GIRwD1zkcDVI3H8JNqYB8HHOBgvD/oh+UN4y8YZHcyC1HFVUkYRrnugvOQU54tuB0X70XIrqYSfn6reLg4hRXZpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JqKn/Rfu; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRIqt99Id+caTJ4LOe3+16s1VvA7UP4lzh70yeImJIrkeZXVUFMmSQH/6A+AixZP8VXR9uThuXIIAdEdC0L29m5VaLj2nEgfigGlfMInxsjk47mT1Ed04N81kVo72RnDG2HfL7IZOGsfuFw4JLi6i3qZd26uPnN8JOkd3PGpbj/D+7vDCzgOMDkgIiOTduV5Z5rm3p/53P93j07kZxfaID1jMrl2MGyhWwztA8KzTWU3NHeJ9jmunaWnltALM7jhxlm0ewmDS+sRCrxKE/Pin+Qa0wuQ6LbIvvhL0FqK00kAvqO1cehHf/2D8OmaoNxeR5q6QWHhVIa2PgmcIrYblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIcu1gjiW2HRquOIe22oP4Ngeb6afAr1mqYJTXOc4qU=;
 b=ixapPW1vQ9hSSCgunSQuXb4WHSwvwCx/pUOfhnIj5qqBOElIMBbhcm2C0lfnZGIjzb+DvMG5/bdLecZUy4FgAlLFxwPSZCS8scsQSy5W3zhaok21M3ymVfJdNfxXh9wk3TYOIrnRTx5nIaZpmOrPZ7ciJAy08sShWbXPYz57munxUk/rB8ZKcAoD280UT3tPBYa2vK1uukSdD/qsz0XaafB3zn2V7k2NNtsFLdX1HbhpgybxlJcMSmnN/6UytXMaGBZX/fGBTw2FYfhvMTbJ8C/DEi1Q66apacDKllzVbmnJwJOSsycxLZgbaSswHZx0JXkXaPrRXtMPhwazKo2MZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIcu1gjiW2HRquOIe22oP4Ngeb6afAr1mqYJTXOc4qU=;
 b=JqKn/RfuCLrhex/jK9caRFWDIMSH1+iiE4k7HAGbzix92y97ZyqTfV8n/oPH/jXZ6deu/MeToTx3KPrbDGz0PnZrInxGCCs/g46mG3SaEGO0x4i0VNtK2fDLx+n+g5p2zNL70QC4Hrf4WsgTxBkowEjOtCM3IPvoK03Ae9TIWtU=
Received: from MW4PR03CA0136.namprd03.prod.outlook.com (2603:10b6:303:8c::21)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 02:26:44 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::1c) by MW4PR03CA0136.outlook.office365.com
 (2603:10b6:303:8c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 02:26:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:26:43 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:26:41 -0500
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
Subject: [PATCH v17 06/33] x86/resctrl: Add ABMC feature in the command line options
Date: Thu, 14 Aug 2025 21:25:10 -0500
Message-ID: <ddc1e96a788d215a7e72ff0ad89ec0a0e812a837.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: cf33172f-25ca-405a-ec3c-08dddba32d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XciuE1++zA1UpgbiIl6CEPUKGNJVwP51y3UXQ4PvOS2o4srm/1nmHxdKvk1r?=
 =?us-ascii?Q?mNbxIaLLWX1RmtbQtElrSWmSUa/ZBr+MRLeyTYw/f4j32MTPERxdDQYH8S/V?=
 =?us-ascii?Q?FY8M3MMBcMlOZNaEWqqrpsHJ0RPkdFne9s7DVJyMi3jSp86MP35zypZBJWzn?=
 =?us-ascii?Q?iQrC9O3bk4uMQ0mfYMAPlfh9+nj3vVp254vD/FxJngSa5mp15xJh8KKWGXkQ?=
 =?us-ascii?Q?3AY4/o7YXf6FHYXfFIEhpaLVCgVHvIyEXi5HSOTv3jeGvp2qKVzYNj8JYh2n?=
 =?us-ascii?Q?GZ/s2EovLCcV0ZWly9HBbZE1JnUw5sKlx++T2oThZbErjC0bRZ4kBizbths0?=
 =?us-ascii?Q?Y4ZWLv4ClgAweVpEJkvbeaCz7aOFadWnrpQljMgDag+YKM2wPHLlTWtNQ/Ap?=
 =?us-ascii?Q?qNG5UzMN6DWdTwF6otuZmlaEvQrFi1YAwfniJ5o5dvSu7DhPSwj5Tw5ZgRE+?=
 =?us-ascii?Q?iJtr+Kv6R/n6oytdE3x2Ie0WVb/D2gq3sUwsJfMbXJSrqNANb5mSzA9wAPuV?=
 =?us-ascii?Q?blo/AiMI2Cz60+zrzGRxeywYLm2vn9me8NRmKPg5jyNOJgXNJ2P+e0qOuj47?=
 =?us-ascii?Q?DNqjdiJViBYApYvBoYMlBilcLlXJZ938TM7OrydT9pQ6LYbHjB/AGQxdN3gl?=
 =?us-ascii?Q?mD6eHhZqG4KVNw+48B3eBGRtV1i0y1rpGZQA3CWmPOIJ2faRPLOPKWNeBJ0h?=
 =?us-ascii?Q?0EZdDUlCYZSq/lGufYpN7h7qAHGCIiYrXGi3KRrmFMqdQbP/BH2DRptqJMiT?=
 =?us-ascii?Q?3svKaqU4f9wjrxZtZDncGeB9wThVuh7r4SHdzN3165VaNzpAFAv7ZiANZDbv?=
 =?us-ascii?Q?eYYfUFxbYBIevW0OlUpLLU8pT6uTZuoXUsvbCRYN8oXhQdudpZD/Mz6UQfmI?=
 =?us-ascii?Q?gcMMAO7yCwCQD4kP8mQHBA4dnqsMLAU9QR98Mrv7ZfYpc91IUHhoilJEi7oy?=
 =?us-ascii?Q?MoemeLPmoIGdFROoVTHQD3dy0i/34btfDP3Ul28aJJyphjRkZXqvYmCcibEl?=
 =?us-ascii?Q?0L7/EsGV8crsO+27iurSAJg97DJ8XkpydIPo5uSaug57NMNlWpzdrxHs9NQb?=
 =?us-ascii?Q?2/oBpz6pNvtoObHUc6Dm2IJmRjlBynouVxhKrtq4NZ/suq1VVzuIDkWyJDJ9?=
 =?us-ascii?Q?SYFlJz+4nBCvAHtLvJSCZ/JHZl+Fp0sL0PabzrfLZYY9V3ShEvoPKhXcplVa?=
 =?us-ascii?Q?keu1QbHFREVuiV6l7/hpmw1cll9pcLP93Azrj0I6wpUUvSCchiPkQxCiiH8e?=
 =?us-ascii?Q?FuCn4kQD1/ih8liHaLhE7jcheuzeT4pyfJRGGhgUv/8qQZvx4guBfgC8vgdf?=
 =?us-ascii?Q?QS8jqJ1VDwhBVwjJl1cWnDekQRWHerRpT7D2ImRyYZl7Slz3wPCyOv4Siz6z?=
 =?us-ascii?Q?1IIXL4+Ss1LR7PSC+r285o6uSdX1LP4wR04xTnwdWY7dGcrtQA3zye4fze47?=
 =?us-ascii?Q?VgZAlxg+d187RDo9/Ifl+nDgjPf+wRgjMEY5kHXPbtHTUbQZ6q6xHP74Rtoh?=
 =?us-ascii?Q?109c2woKh9SseYEcsIRanPhRtfRed/6ldvTU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:26:43.6923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf33172f-25ca-405a-ec3c-08dddba32d00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809

Add a kernel command-line parameter to enable or disable the exposure of
the ABMC (Assignable Bandwidth Monitoring Counters) hardware feature to
resctrl.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v17: No changes.

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
index 747a55abf494..5bab2eff81eb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6154,7 +6154,7 @@
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


