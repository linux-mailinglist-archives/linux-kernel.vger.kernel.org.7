Return-Path: <linux-kernel+bounces-863882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A4950BF9697
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B74B548991
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEF82D6E64;
	Tue, 21 Oct 2025 23:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="slkfNspO"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF8F2D6E78;
	Tue, 21 Oct 2025 23:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090942; cv=fail; b=CoJN7LlIAq+X8qWW3JJHZDmAWRyBar+cbBx1FLWelxLjoQ528/m+JgRb+2QVn1PVIIsIToyGNio/0gMpcRnXOJ4jzh6EX6xLEYxvZvzov0QNo/JFSGvKj0aaZ/M1seDTDViI6y+6DRF6YxGXMEN/kCmmc5AbRofFDLaw3wEI/Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090942; c=relaxed/simple;
	bh=Ek91/OneKOxV3SNpeHnu4bQZqY/Iexl9SzbvLdcmwwQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tku9eRoIznht/AN1W78L6VCamFIR6CH8oaPqn5DyT0j2fcSmyTPPGoLYhYN+rLrLSW84O1nxp6KO0SklkrNgXCC/Kr+3pEPs25qTNIWyCHGHRh2RelZWsFqW/j3yFELvn1zaLRykbH7upztOAtkQIzsfFV6Mlwj7ACLx1rqqFMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=slkfNspO; arc=fail smtp.client-ip=40.107.208.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pz/AMgAUgZz4/3kMPXC6NnNM7qXagdFHjGI686dlIQZQzz4HLh0VFf5/JFgUUpvWW9cLmTxTgN8V20OFMTT+lE3EXZ1+s9K0R5XMtWizzciWuuI/+8CNXdx5lbxA0V++CL7rxlCe7Fvj8djgdvIEcK22eREDaqcKFf/qphJpYMoJGHYgWwSPP5Pz0a8MzBAk3w2OLOfxYwEaUS4l+yleLDcpkLBppNGxTs7A5Ljzf/ZXEzMe5BqjDjA5xwfURnh7OOFDoPib/MbWWmevq/ojwx7LaFP2ogudfCEEmvDEUcNsu0FdbeB5kvBaXqFuAXfqhMzi93JFrfki2cuSM8FMmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Oj+pQdGpebeUyPaBPIoS8f0RWXPbt7pC+Ishz9UzkI=;
 b=P9poFgw0pRjDzIj14mig1gL6rGK2WVdBxoxdb2ndsD6bLpg1kMcSN6n195jPHC1PinLBsFEwRpwuM1hBz++kEntUc/T8og0CSMuFQ5nnZqcnRXPXM2GX7ZQl8lMLCx83l2bgSAIyMgi0RuINLVeR+JHcF65SKdZqQnC1yrBlw9pW18fZ9XwfbpDi4JyXxInIIXxvmi/zRIO7EOkq2FXk742seiAYr0Ve5cAs2vhYq/cRGtM37GNpShbaRX9HOcTof4G6SGRfcGl1tdw2kQrxEuqBDd+qPRRJO35aULDc4s6CZh+DWGMlveVje0pl4PrYy1xybKR0SN/kVXgLnxgljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Oj+pQdGpebeUyPaBPIoS8f0RWXPbt7pC+Ishz9UzkI=;
 b=slkfNspODPuxQu5BBl3iR/TlSyqN8VY453WM/qtocoOPbPHte4A1XvIR2npQrakiR9UW4MliIGyi5mvXEHPkvKvBPpbTWKgPhupqEE/CsGtA3/aU23fD12+fS+UPj7qu2aNbqUHExkJvC6YWZWy/yoUw0Twpynpp9FRPmtDXZqY=
Received: from BN9PR03CA0911.namprd03.prod.outlook.com (2603:10b6:408:107::16)
 by PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 23:55:25 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:107:cafe::59) by BN9PR03CA0911.outlook.office365.com
 (2603:10b6:408:107::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 23:55:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Tue, 21 Oct 2025 23:55:24 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Oct
 2025 16:55:21 -0700
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
Subject: [PATCH v10 01/10] x86/cpufeatures: Add support for L3 Smart Data Cache Injection Allocation Enforcement
Date: Tue, 21 Oct 2025 18:54:44 -0500
Message-ID: <a1aa9c0c4247a49d2b6be17caacd6573dbd4060f.1761090859.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|PH7PR12MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e982373-f212-48e0-8f63-08de10fd4d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MYznQ90tQbSpSF5CHAcEhvRGpzuhEry3JAjyZVDD6Cc+sH6YRTWkLbuHbu7F?=
 =?us-ascii?Q?J9o5dEF8YY0hluIpqjmBhvLXZ+zwiYl9CIFIHEnod8Ot1oPajv6691HbONua?=
 =?us-ascii?Q?jUODgiT1NZfVnBcFPYD+OFXu+OqhkAK2Ye04DzAQRVeZfscRAVFpORxz3gHM?=
 =?us-ascii?Q?WPEEpONW9P+2rsrIAyoQ4iqQHQndAaEW0FZ6u8pu5N83PCgULuM8+c0JPlAo?=
 =?us-ascii?Q?cMYPO0URiZP+GipntVsbVhDsNHL3rsmhO+YGrOJEo19oYRndtwioiEqyz7OU?=
 =?us-ascii?Q?uiLULa55qSTNjkrNgCfJCQR/aTFQHeiGkoS7dg95yYLicjskXORCEv0TCWMj?=
 =?us-ascii?Q?HyIM6jTizKznFgzuUEhfG0sulkt5YkpoUtsGL8fUm6zrk0TQ3+1g+79wlu1s?=
 =?us-ascii?Q?P0t6fm+tv7NDvA7K46nnGAU61XCn8/lGv2ITNfKuCFbpWdbDHdNrqvw/sMkC?=
 =?us-ascii?Q?OhIQv8gLDykWkdNINreMtXk3EQPRb6WwALsjz3pNFO3SHy2zmxN9T7AzoSP0?=
 =?us-ascii?Q?Yl1YcIPC//5fV8+7ogHca1wQV54MZ3Ahlh8ZPcbYQoN+nbnpwcaIKEzSSBJR?=
 =?us-ascii?Q?nNIkW37h6ENgASQ9tJHSqQ8xTe/sA2YlMwUiLVxK/NjtBij9lGID7rt0zptH?=
 =?us-ascii?Q?W4xtj8lW5oj8Q7DQ73elA5qeD84MbkVCJL3YPYgalifmhb/1Ex/+Ms3tKzSE?=
 =?us-ascii?Q?oZsX41R1bWB37aqUWRd1Z+nVLb7RVYLdXC7OJTpiIdbIk9lUKxI/xzyxPOb0?=
 =?us-ascii?Q?AnoszEADQwD9bpIM5Tk7ryU7YiSqZrq8x/EIaCwunidWdaHETf8sBYAdWUGu?=
 =?us-ascii?Q?dtwbkBmmdNqj7IWYUnxppEt7UKbDZdhaDmMWkF/IO7/S68Ba8pld6uzgQLjI?=
 =?us-ascii?Q?cudBsrlSPF8SbU3V+zWIcmd7I+EmWIDRiLuPVI5jVs/vjCyBFwapl5R+6kGd?=
 =?us-ascii?Q?j3JHgFblnk+OriCgXOUSlD44W7MN2DBvn2DiLmH8/pLrv7AMp8gghkjAfWRM?=
 =?us-ascii?Q?t5wdCt0SgTDzAWVFZIcUj87YqNiBS9A3bvIxgeGk4X7GKQXIZIzvJAE+VjE9?=
 =?us-ascii?Q?5kwTR56AlzoRCgDSOBfsuehAWA43cHe0Z2synmiYio51YLdx39y9ffmadGT1?=
 =?us-ascii?Q?xyWlowe3rP6wC8GFZEw42tjmTPvR77B5Kwf6784d3KQe8hSWI1VUiRn10EV7?=
 =?us-ascii?Q?YoBjioXCIiXwr/j9UOBvhmaFI/SSRD9H6QE87c5XsycurFRlH6QxHBwTx/uD?=
 =?us-ascii?Q?YMzvOqAPaQPY2xhW8d9Sht+Xm6n2qhjPwN3D28en4iJTmYbh3srIpQNWaUcA?=
 =?us-ascii?Q?2PF6myvRfnwfpBBNr63dFPYvce1gTHzjIGdKcM9VNA8yvd2sRY9RSYd7e3t2?=
 =?us-ascii?Q?V5bXqfT5oUqa2L7YJ0UJOTWEr5sgADBX4Oijxd0a1vJrOdq3PbW2C1Fj8qDm?=
 =?us-ascii?Q?sGxDJQwyktMET1UyJrGIHRXJ/LvUt6AFQvDuEMmNdzgq4Y1N9ovJRVKrWZoV?=
 =?us-ascii?Q?0E0kza3FQFaPtpBnfuQ2P5QIW/4AfGb6GxAL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 23:55:24.0437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e982373-f212-48e0-8f63-08de10fd4d2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5902

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


