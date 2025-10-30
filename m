Return-Path: <linux-kernel+bounces-878769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1699C2170E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4757C4EE106
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45983277C88;
	Thu, 30 Oct 2025 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1PaoWUco"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957123678D7;
	Thu, 30 Oct 2025 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844560; cv=fail; b=enSfh9OuRZDtxph+d3ttHeaEmhxK7sRkJiLaAtL5fPJdelrHGZ2gRaS7aGy40gPIxLlmBPE7XniXDhawxgIjoThNYFmQNFOYehfuzKSj0wIlpvInU5ixCW/KH8bnRgUvMRwmwNDNetZNJaAodLfZCPehEMB75jh96UAm41lOcrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844560; c=relaxed/simple;
	bh=0hoqXLnvNzgbuLCSHQ4XCKd/eIw/+jSnqd0IdiGwj9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBTVubvE507rb03zh6qn4KcU89uIUW7qiC9Z3TikCMsKIeMIcEckJgPlV1dZ3tAsUgxrYt6IKmQdetnYZuzHRiL0D3I/ja48sA5fYA8kzav/93Vc1ghlqXLprQJtBLQVDnYSDDaNgzYQkDYWwTkyvK2Akw6i5c1bip7B6NcPy3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1PaoWUco; arc=fail smtp.client-ip=52.101.62.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmeZ7sOMJYjyiIoiuFeGBXcCwV+GVFCgYJQUpvaFToEskT/7NlgkpE3nHulwIxeLQbCGnJYxCiRcexZcwiMjZsMnwZn5/4uY0u+eGMgpldIXk9KKW49mKP/TwpnwgSuwZh6+45Pkeyg1So5g9aCVY9zCnvbclhiSrY1ZVNph03Y6L+8wY0wnkVykRCBDFswgBbq/rGcyKciJGdQFGUHu19oAU4a6XIlu3+6JWoeapLqYVYykngbQZJbEf5QME4hOUq89mGEirQgpVgILcFntGappWERiv11ttJ/zGR0UgMbIoq/MzM0fcOTXt4aFsXpLhAxTWUX+tXg4hI0uNKhZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtMKLa3EBWrEmfTNdAZu+nFG+DuaN61HQl6LIexhOEM=;
 b=c6FuiV9iB3t35qxaXSa26LOX2zkTpRH2mcwBau2i4sAk06KyLOcW5QQ2KBg+YIh7XQAmyX0UYMoGclENBpFWjT3545BgYnoylDFJ2qPX0BMyfcAEj+n3NFKhvu48A6VTpcEgOAyHgN1SctZtWv871PT3fWJaDMGIzBzNFCdE9HIwqFyZYHiFcyS9H6lPP6tTB9QZVm/LsKlo5TX6caKAx2URkqZenNbK3R9+gb5GPjXeqf4OF7y+0A5nmcl0RlMd3PQfTIy3/Cda0et9oGDbFqfjc3hruMDRt2ZjzpAiRbAzUSqDUgrflC9P6zJX5c8vsvLE0igDToekFpKrZuGyWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtMKLa3EBWrEmfTNdAZu+nFG+DuaN61HQl6LIexhOEM=;
 b=1PaoWUcoQ9HETuTklqTBOAG7cn7EncnAQvA+IYR2V7E/ISniU6uv8c6cSX3yZ0FUfCX1mSWMKICuYXdvSaLa7jZrCjJIzF2QVvzF1jQ/+sYjD/CUDKxpt6NcDNi6jWw8g8rwhgBK9wyuFwDpEpq8xbaI7mG9LcCKIhYY9gnpArI=
Received: from MN2PR02CA0035.namprd02.prod.outlook.com (2603:10b6:208:fc::48)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 17:15:54 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:fc:cafe::ef) by MN2PR02CA0035.outlook.office365.com
 (2603:10b6:208:fc::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 17:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 17:15:54 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 10:15:52 -0700
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
Subject: [PATCH v11 01/10] x86/cpufeatures: Add support for L3 Smart Data Cache Injection Allocation Enforcement
Date: Thu, 30 Oct 2025 12:15:30 -0500
Message-ID: <b4487301475c01df39787834a8182476619c2a6d.1761844489.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 3534f516-74bc-4711-8b42-08de17d7fbce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UN/OP8xA8PPvCqkfUi4gkUPKAqeMpy59KED1MRY7WB8f7m7xBjJ16YSADgeg?=
 =?us-ascii?Q?Ep6ojqc5+E9B+VIARoGtuoEtwkueOQ9CFWIiT5C2+yvIFRIlsXOL+FJ8ygLM?=
 =?us-ascii?Q?6KamRWMsN834mTcufd+hVO3DrwBuvYpPveHarnuekUDK+w6ssWJo5QIJNz40?=
 =?us-ascii?Q?T96/aCxgwIJFtr+nVP1dyFrPkWLAG08uA3xUJOcn6o5TJT6BVDE2mBzn9p+m?=
 =?us-ascii?Q?QyJhiSLoUMpDoIbuw7qrGiJsZwAUCQETuG3ZKWL1KG4Ji0ncl8QrrpxCE7K8?=
 =?us-ascii?Q?CBH7KW2/4Y+MG8jKCdbGiD2B6rTP2zI4UEFf8vZWh01cbSVujCh9uVm0IhzH?=
 =?us-ascii?Q?tzen7eWKPCDQVdQKuG9jYvC882YZjjZxk1HzWWV8h62bXLMTfjpEJwRFbkEC?=
 =?us-ascii?Q?wa0MlP3CJGd9ncf2AaMA+tLBjAkFdSGXqEwuMzJFoFBk5ugxUIWKPyN1IgHd?=
 =?us-ascii?Q?QU0gAInH1FAUY8rxGeYwJRfT+nbSUyE2701TrG0eNSSNhMnAqdA5zMlog4r7?=
 =?us-ascii?Q?SysYKIYUGZawcarIMPXeU1NAvR4aZJmmw0tChVKorT4wgBDY9ZPgThBO0n8w?=
 =?us-ascii?Q?a45qDIze0yozxusSmkdv4M5j+ihDfPQ0yi/+YurhvEhhECZdgEh6WCIMKwiR?=
 =?us-ascii?Q?XIHs0dIDOjpW9BWWPZ1mxGdQitF5xf6ZKSJ6BPFmyqMNvO1Lme53QX46Qm+9?=
 =?us-ascii?Q?GTL4cT5NNdpiTZzAPrNtNuHkHA4eaihogE8KKFD+YNhEF+Bi+VoLhYLZfaCF?=
 =?us-ascii?Q?mhhT/HAM9jtINSw1xLvVhiJNjxh6Bnma48rBBYwfgQ5tUJQVo/eZLttwKp0Y?=
 =?us-ascii?Q?W3VJUudK3AJVHh6P79J49cYV/G2SgiNo8zpSPxN+FD4jh4U5Yc3uzsCjwEid?=
 =?us-ascii?Q?PAw2RyLbpoz3DVaKsQJCBhkYNaom0VnybSPI+4/ZpXGtxUZWgIPJMuzAgOyJ?=
 =?us-ascii?Q?gvErS6ai2+aQBQgH1SWD+SR9JB0GDmdi1VjaU505QMersmXQ5rKWmPjTtxX9?=
 =?us-ascii?Q?yNa31nIp4EPxnfNO456A0FHjkYZm33IHTmId8xyL+bD6qypRSUIrGOjMSf19?=
 =?us-ascii?Q?xkHnGfOMALR7gZPMGV/xTUgNa5k/mkPDXM5bgSz2Ty5ZO10mBiBstsKHAEnX?=
 =?us-ascii?Q?6y5Lo2q4ePwNxD9mp7Xy87xiDwN72w0lQ/HP/iGI6cCZUPadGrpdqhtucrgB?=
 =?us-ascii?Q?HQkJ2AqsdIVP0B4CcYNNlnnAJCuVoX7zMgbN/mIbVDohVWSQEsrYVcyU7OFu?=
 =?us-ascii?Q?hYwOT6+PhUnuCCBT7CMR1Hcxp9WEtIZDDPD2z0wfcH7DGayXoStLz/U13bkc?=
 =?us-ascii?Q?SdXwxCZUTcqVY1YpKq/OF092yYHsjBEz7ewVlCEfmZnnBqaqAz5eDOphPGBC?=
 =?us-ascii?Q?S5JJHnW84Q1cX7Aqk3qYqomyN5vqpwYcnA/xrd/XpFiR4iHluqeUE3BYTYVi?=
 =?us-ascii?Q?YP6JrkK7a28LEqdKW6+/y5xlX4ymQwRRRnA9cNOOUYQXkwsYPqyYyrnwR9GZ?=
 =?us-ascii?Q?vE0DbPXc0Cfd6M7yejI6W9id7TbIhpvqJqRpX+rUR8Xztui2tw+2xpnDUnKi?=
 =?us-ascii?Q?Uvo01asDD6fb5kucA6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:15:54.2734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3534f516-74bc-4711-8b42-08de17d7fbce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536

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
index 592909dbe0a8..7b9fe554c66a 100644
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


