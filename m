Return-Path: <linux-kernel+bounces-898394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 183FBC55322
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82DB34E5A91
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF8722689C;
	Thu, 13 Nov 2025 00:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gcI36EL0"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012048.outbound.protection.outlook.com [40.107.200.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003422147FB;
	Thu, 13 Nov 2025 00:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762995477; cv=fail; b=q7Ql3wmRrOYKSJPf47EDNPRoRIE5TDkan2cfH9G+/VWk3WaIIYalwG1skF6gSHmUwnezePDpnq0UMP+H/wCxTu2UEKrCFXWRzJoXCaM26b2MlTBm7j3ue7zPF9Y6EcB4eJODHGsYQfYJdc0dEO7DcqyUPvqVwEtgDYOj4k8LXcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762995477; c=relaxed/simple;
	bh=jhiLxUCEUmhYdWChUc4Bs3CQH0DZuKBhWE6nW3o4mnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtP97l9FDYIhx/WS5LVovpwUkEUMs0FUeDii8tD7WS95fs/eyHcruw/0fO/UUDL+I4r78kDs+33AWGpF0fxxCedCorWlytsiWsHoTHxtXFcAwMeZl2F8G12jQHUtADJJQBl0F9bfj5lZJomulQpwqTQWXkaM1bCZf8J8V2wJ9CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gcI36EL0; arc=fail smtp.client-ip=40.107.200.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNAmoty4RBjnLNiYtE4kJajNE8xe/1HioR8gitzpmnCx07DNBLwbIxitBSNI8FDm8sKRXTT8Z7JXe8wEgOvDVgUfPCW04eU+Pc8sOVY2E8dgNA5okaIKJBoYt3l9B6sfGNybaGRQfpp6SKil2wPVDW8aRBeiWSQTtDExoqd/L1HAMJYGUdCAVz+sw51TxQwFx1E2Zf749iRYcldkgznZ7V9Mq6mLajCceTIpl80PYOvtcILfeEEFEglpnJqvwWaCiqUcK+13ZYIw89Ys1X04w4Rlpd9EU3RrzZml4qdcmd2goEYq8HE84H8/A0aQxuYuergxPUNUzR6MzYgSh82uvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLJBw78mcUXfC7EMRYrs4nkE6G/r2AeusoM1toBOkyc=;
 b=r1DNirru8p9znUwRFfmTSaqCCmnk189k4jRgiLIW+xz8Sy7xgkNx/QB9g6GpomGWtVOirw7mbL6rmRXOzmKQ5RsHfNGR4hnb+OlLbIDwmPSacU5A7MCNQl3itR54KbXX5PBJghQ4QHV0a49CaVBkeBCeNNAhMHOHV4koNby1KuYmJJi4Fcxy13DEJ8dMTLx9StA/0jWApd8nb3T27pb0RjGsg9AH1ViTBgZKm52bMXlsb6HJZdwbTMwMNuUTKOppzN1ms2KsENeIQ51CcAMeE3gPHn2w9rEcTZzikFGvf21Rs+n/DFFbij74jriGYUVKETHpLWeMcqXv+7AKTxXtzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLJBw78mcUXfC7EMRYrs4nkE6G/r2AeusoM1toBOkyc=;
 b=gcI36EL09MUBWql+VscIPq152NcGpvcZt529ceGo4iOAl7kTc5REGTiUkCpq7WQmbLvcjHpQwjFt+Ty4B12Gjtc27fo66MfXiN+/pyGciYhcl1hUt8F3xlE50hxUhAboMRDptEgJemMxQJXQhyRdA45Eis6nmBXYF7xlHthxzVM=
Received: from CH0PR03CA0438.namprd03.prod.outlook.com (2603:10b6:610:10e::14)
 by LV8PR12MB9082.namprd12.prod.outlook.com (2603:10b6:408:180::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 00:57:51 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::91) by CH0PR03CA0438.outlook.office365.com
 (2603:10b6:610:10e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 00:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 00:57:51 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 16:57:49 -0800
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
Subject: [PATCH v12 01/10] x86/cpufeatures: Add support for L3 Smart Data Cache Injection Allocation Enforcement
Date: Wed, 12 Nov 2025 18:57:27 -0600
Message-ID: <83ca10d981c48e86df2c3ad9658bb3ba3544c763.1762995456.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|LV8PR12MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: a3617c2a-5e62-4ed1-2199-08de224fabed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wWxVcobkNGNQs9YHTRU04oqZLrt0sUPunZUc04nU1M+zjpcCCaL6M1PJbEoB?=
 =?us-ascii?Q?D2m5+iut/r4Gh6okl3385vSanvY55ajRANYToKQaLq/1skry303sent5+J1O?=
 =?us-ascii?Q?5VS7elqAelhc9ztLQs/A3p9u37JxtAmvdeJMqEKuW7NGSYK3oZyMO0tcslh9?=
 =?us-ascii?Q?D9Z/PAdZdcZZoZgTTZvVLgWBY5OPj0fMX7j+00gNUYZBcordTZk2gNvb/9Is?=
 =?us-ascii?Q?nxFxS7w4gzeYvftHIbIehHg/aEbyWU3L6qbJ89K628wk4iB1Ze2Suj5J+huk?=
 =?us-ascii?Q?JG0ZdGRgrMa7F/8chA9B4CAjNlRJZrVYPC9vhSa6e7bj9tc3zy9MXfJVQLRc?=
 =?us-ascii?Q?aLOtlS89hsO3vVypDXh3VWIu4vApvBkrcwNvUKaXw/AdlKEs/+Isuxr7Wmm3?=
 =?us-ascii?Q?JQRqjf/vP0FPuNbpM4SKfb+wWPsjOm7vRQ+Cim4R5y5jOKKIgMoQ7+ccSF3O?=
 =?us-ascii?Q?Tf3dEZkuEvD5DKkUkL7fqKkyR85LTQzWyFk9zjffJcjFMtnMT3TXq100iyfE?=
 =?us-ascii?Q?7zDEqejdCL2MIZXq/wl4uMbX1DVkrOCVpVLYUNwNKLfP66BGJWAmpu3HOnJ2?=
 =?us-ascii?Q?yt+WLsx6ZW56nvwWIpkGP5mY4J8rTrRzxoGBM9/OURrll8Z34uSBMwFerb+B?=
 =?us-ascii?Q?w1TQaMWbkqNTRT84u1QJnjBk2DblEjHSg76SaXzKy8/TO+Jc1SDkRxjUODRx?=
 =?us-ascii?Q?oNFxcJj3TOb4ziviRncHqXhGsg2m5FyTOATXgnAhC+VXei6yxmGqY/6M1ewz?=
 =?us-ascii?Q?Em5cUA1jPHpL3YGwkmF8q9DS+lgyXYZQdTV6GpaXolo7tO5g4nBvoHS/zdL1?=
 =?us-ascii?Q?/8m5KZt5Hh81MCuQEeHhFQtIiXWdlr8IJiuaHvm+xrJLKGRewqosIDObiGBL?=
 =?us-ascii?Q?HuE9mWowPIJ+EQNEusAQSl2YTM0EG1Kx66gFW95sXeS89P5LilS49m81XdBC?=
 =?us-ascii?Q?48VL1uULSCHpUctD1HzWlBA+o73HIvzRM+wkd4A+bxQ/NUe+E4SatTzLcjrH?=
 =?us-ascii?Q?kcsmokr/8tctpHPBP46Pz5ESIODy9nE5DIfj+DMeU5l1bgM1ATBKWVVwAsH5?=
 =?us-ascii?Q?5+cS7w1jjMV5jKnYIu3N2oqqONCEEe7Pk818IKGfVBLGw7hFuqesCGn71aVq?=
 =?us-ascii?Q?iBBdqm/M0nTiMDS7pCpyO4pNRotiublaU3cE6L9rX5/kigKX7c/hyqva8HPa?=
 =?us-ascii?Q?AblYGyG71Epw3687Jj/cdMXvVkgMcciElZdCFybimXoJ/F3eF0RRVd6e53Mc?=
 =?us-ascii?Q?r+cAF7TPv9WA3xrtEN3O35s4ktHyGd/ZTauMhL64VPZkjq6B8CpJgFfrNOFy?=
 =?us-ascii?Q?GIpDQp6Oi9SFHJ1ucFjufVvzdmRMS7C6OOxabmW/vy5ue9EUoxMwNPWqaAlG?=
 =?us-ascii?Q?6M2+8tS+eP9GmgRIfVS3cbC79dvmL+jk47DNXssIKlOeKlvG22ywlj527mEG?=
 =?us-ascii?Q?8bZZY743TKoOtqix8mUd5O8B+IGCBxHVzcifP8C2ZTJ6/gKASP/Fgp2Cqrcg?=
 =?us-ascii?Q?1tz8s48cmeHFR6DrsoK5w2RJj99ZuIQwqBP1y1kntHZkbkJ6XiWv/EbNOJbX?=
 =?us-ascii?Q?RyV3d4vBrRzAMwYm3ag=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 00:57:51.4856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3617c2a-5e62-4ed1-2199-08de224fabed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9082

Smart Data Cache Injection (SDCI) is a mechanism that enables direct
insertion of data from I/O devices into the L3 cache. By directly caching
data from I/O devices rather than first storing the I/O data in DRAM,
SDCI reduces demands on DRAM bandwidth and reduces latency to the processor
consuming the I/O data.

The SDCIAE (SDCI Allocation Enforcement) PQE feature allows system software
to control the portion of the L3 cache used for SDCI.

When enabled, SDCIAE forces all SDCI lines to be placed into the L3 cache
partitions identified by the highest-supported L3_MASK_n register, where n
is the maximum supported CLOSID.

Add CPUID feature bit that can be used to configure SDCIAE.

The SDCIAE feature details are documented in APM [1] available from [2].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
    Injection Allocation Enforcement (SDCIAE).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
---
v12: No changes.

v11: No changes.

v10: Fixed the minor conflicts in scattered.c and cpufeatures.h.
     Updated the changelog to fix minor formating.

v9: No changes.

v8: Added Acked-by, Reviewed-by tags.

v7: No changes. Fixed few conflicts in
   arch/x86/include/asm/cpufeatures.h
   arch/x86/kernel/cpu/scattered.c

v6: Resolved conflicts in cpufeatures.h.

v5: No changes.

v4: Resolved a minor conflict in cpufeatures.h.

v3: No changes.

v2: Added dependancy on X86_FEATURE_CAT_L3
    Removed the "" in CPU feature definition.
    Minor text changes.
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c   | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 6b5a16e33c8f..c0da99b12008 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -503,6 +503,7 @@
 #define X86_FEATURE_ABMC		(21*32+15) /* Assignable Bandwidth Monitoring Counters */
 #define X86_FEATURE_MSR_IMM		(21*32+16) /* MSR immediate form instructions */
 #define X86_FEATURE_SGX_EUPDATESVN	(21*32+17) /* Support for ENCLS[EUPDATESVN] instruction */
+#define X86_FEATURE_SDCIAE		(21*32+18) /* L3 Smart Data Cache Injection Allocation Enforcement */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 3d9f49ad0efd..a40f5545e25b 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -72,6 +72,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
 	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_TOTAL   },
 	{ X86_FEATURE_BMEC,			X86_FEATURE_CQM_MBM_LOCAL   },
+	{ X86_FEATURE_SDCIAE,			X86_FEATURE_CAT_L3    },
 	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
 	{ X86_FEATURE_AVX512_FP16,		X86_FEATURE_AVX512BW  },
 	{ X86_FEATURE_ENQCMD,			X86_FEATURE_XSAVES    },
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index a227563042e7..cde4b6cd3471 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -57,6 +57,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_SMBA,			CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,			CPUID_EBX,  3, 0x80000020, 0 },
 	{ X86_FEATURE_ABMC,			CPUID_EBX,  5, 0x80000020, 0 },
+	{ X86_FEATURE_SDCIAE,			CPUID_EBX,  6, 0x80000020, 0 },
 	{ X86_FEATURE_TSA_SQ_NO,		CPUID_ECX,  1, 0x80000021, 0 },
 	{ X86_FEATURE_TSA_L1_NO,		CPUID_ECX,  2, 0x80000021, 0 },
 	{ X86_FEATURE_AMD_WORKLOAD_CLASS,	CPUID_EAX, 22, 0x80000021, 0 },
-- 
2.34.1


