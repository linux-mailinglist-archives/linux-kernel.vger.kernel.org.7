Return-Path: <linux-kernel+bounces-726218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFDEB009AE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8412C3B5C35
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9580F1CD1E1;
	Thu, 10 Jul 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kfK5Tq/i"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D76EAF6;
	Thu, 10 Jul 2025 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167812; cv=fail; b=E6w6DW7A6NKVGwA4qLp6JnrDdjQ2WGV6o/TbUR+DJuiGSCIOb589wrm1U6xWJrTrmfQZkYnycXOMeW/R7v4P1tQVQ1w81C/00PXqsK4VT4Jalt7wd/W3zYTY9ql8Q3f5vC/+novMXp4ggbhzg6g7Nc4HK3kg8OKMUGibqTROc/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167812; c=relaxed/simple;
	bh=lwB+bj2flAzhjaaiNbl+g11vlFbgnsdeTJwelOnX9RA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ls75ABuDxKblLOn9pRrE9IzG5aZNCYHgtS+tdGePpwDY46X7oGWQTdLD8Y7FsNzA7O8j60WbS4Li6g1RZFkKmw1bAaWCKavWrEDa3tARWs+wEkpz8Wrcgqmlea1mT5jIHfsvKHcCdwSaO/4HBy4wjm18wVeDtNVJoarzraxXlCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kfK5Tq/i; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isDhFS6R3gvp9VcIIb5ojGi6L+8C5eZG5vDZiwhmGWA/8F98iSdX/ShZRloLD3/GS0XHx/BQ8PtTanB6IFOUzZHFKuDKyz4yBIfVQBQR7SEy13N5GqxEh57oJvcS3TIZyE02csnmU7MapBVyfoEfQCfJOEBipcmVUmaQW2o7lo1ct/niCPqJPI9e/9gQpUSsQius3RogS/MCGJp8BR8Ay6Pi8GVSNJ/5g6WYYA9+qupS/BQIihiGdR+I8F5E6pPbpI5uimvr4M/znZUFanx6fLh01TkbuMhZTLQOcBLQS8mi0M9LUWN2E2V8Txv4xcnEjxZIB0ajHebCMb/MJ5rh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7fBgOIQOjbLVirG1MLe/l0O+DIC3gAfrJG8lhgJHWw=;
 b=l3rPXqcyIArs88EnzytXR4IP7rvbszlbYkOK5hJvkD+WWQIBjXnXw3B2OXCVmsShVDSp2Wj/QXtYkT7HnhxKxMbbG94vWIQesLWXsVE8rhwVtwi5rU6LGOQfj0KMPzwl2eppKvh45wjedxnAeSKdvlsdvBJVx26tBtEginAk+/JuYGZUR6Zl6ttVGx2z6zbh2Xd1U8WgPQxXoSHLRwHVgCoB8VBVAQsK144hPgXmJP6vcxNUCY1riQJIjCCUhmspFLuo7cWr6q/TBzKAsOMpmx0FN2+JdERCgMA5flJ9SB+K8pOQni4zRG2lNuQec53Cd2ag8t1I4XegDXm/nmJOJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7fBgOIQOjbLVirG1MLe/l0O+DIC3gAfrJG8lhgJHWw=;
 b=kfK5Tq/iGHOA3xldPIFVuvC4oJL71uI9VPV5MJ8Kg12ClnT7GT99929GF2mh33oYD5xqLRcB/ojuB9pAo96C828uD5Ju0FLPn22RXRiK532L9yGEvYM9viWjaMhaAmdm/2teP/gU37+D9q6wvXj5qXl2nQ46DOfMvfefIIDRPe0=
Received: from MW4PR04CA0202.namprd04.prod.outlook.com (2603:10b6:303:86::27)
 by SJ2PR12MB9238.namprd12.prod.outlook.com (2603:10b6:a03:55d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 17:16:44 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::2b) by MW4PR04CA0202.outlook.office365.com
 (2603:10b6:303:86::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 17:16:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 17:16:41 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 12:16:39 -0500
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
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 01/10] x86/cpufeatures: Add support for L3 Smart Data Cache Injection Allocation Enforcement
Date: Thu, 10 Jul 2025 12:16:15 -0500
Message-ID: <e1ea4ad34a7ca4bca7fd03b96c961bb59bd43f9f.1752167718.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752167718.git.babu.moger@amd.com>
References: <cover.1752167718.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|SJ2PR12MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 06053634-978b-45bb-251f-08ddbfd589c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zVIGxZpR25P3JhSzXpf2WJ6VxhPRnjo3dGXP4VTBiLpC5HQI4V0QBxTQprRv?=
 =?us-ascii?Q?pEq+X1jEXiyakirE5qd6QwSerfIyaXQR+GanFVnDrePLHIE5w+T0BcAbNYln?=
 =?us-ascii?Q?NehwvNolQXq9fxt0yXc3q+NUklDPJxPE3bSqn1WjfOaJLEgTYTQgNCFg1Uzk?=
 =?us-ascii?Q?oVxlGTJ2kv6MLLFw2PZOM+QOg3svIqaq/LqnMti5gQZXsXKAmy7ajBYKuM3B?=
 =?us-ascii?Q?kNgbCtUP99bo4IUw5Ug//ydtrC24ECX2n9v6ECbWjBwDeXGkH/f1bETWDiAN?=
 =?us-ascii?Q?G4g7NrevKAe7nq6GuAsfrugdlTt6L3guxk2BRdyyoZfiJh4zeCfqge0YPvgr?=
 =?us-ascii?Q?7Kvbp9qb1LPyGKhwWlkB4N+Y/vTP7ZmF+absXujX2zg9SNtSGfcoa82lNVQ/?=
 =?us-ascii?Q?ZsTwLTeEUrVg82gG/oz2XbQF5vxkCHf9zJNhy2ecavMV2ndoy5SS/Y4SF5ZU?=
 =?us-ascii?Q?EPRvu2fCmwS7/Fs9Fz1X5CRQNblp1xyjGBUlbE4J5uOerw4ChEs+l6g1HBqi?=
 =?us-ascii?Q?jxiNIb0ZtoxhvgahTHFFbxYRONnzXtbSmyjyisWB6uiWi9lVv79l4fSHV1yt?=
 =?us-ascii?Q?o+L9pHD7yqqzg/t+YDlKB1pqwfa1kNPCgnj0kbiWTVGb4jJEURX5IHS5UQrb?=
 =?us-ascii?Q?Ocey1MZ6H+k+pEudTebACJOtKBUsh0ZMu16JJ7+c4C30NZ6Wo1nkYfTaDJwg?=
 =?us-ascii?Q?ROi+r1wwsY7maHtXT/Lg6BhFTC2foXZJ1plIaMAqBxESDdCr7EGG51AKKUG6?=
 =?us-ascii?Q?+y0oi4obJBqSa8TBJh74J+36HomcRCtfTwovFCUaCM51a+1c/G8N+vHSLXAl?=
 =?us-ascii?Q?3Hzp7f0IVAE65ligM50Y0epVFo0iUpWsXIgQci6gIRh2hBu+LPUfNXCY1Etn?=
 =?us-ascii?Q?yOxewL0ZBQ3Cx7d3vup0uxll2eGSeRSs9j/yOvcSrnnloTUGkt/wYvTUF980?=
 =?us-ascii?Q?uoCVkZ6OGbC64nfe9HjqMItdhDkA3H8Oxed0Tm2sbFHk/FCmW1RBVfBSRViv?=
 =?us-ascii?Q?YNojfJWrBFDuzCEPUmqeoqufyN7SW/1inEsDRsZVRu6dVtPYMsAgQ0Hd17Ad?=
 =?us-ascii?Q?TAxqc+5Q6oGMbchTzag0BUa6U83Lcu/y1UJGCQ/5NIEtnNoN2HQpW3BEBJpc?=
 =?us-ascii?Q?WtS3ovtxw8ldZ+9vNaLPojxIFdn6egOV7UkTkGNoejfJWOPn8Jd/VvyG6TQ3?=
 =?us-ascii?Q?LCXPrOwXb05TS36x9YlmuFak3TcPvIlfv76+2bzQ5GtahDDMYSlUVj7oeE7S?=
 =?us-ascii?Q?RoyKq3zQNah3L0Aoma6ufBeJSII4CDgEAcYI/pRutACiUqWwnFlboSVLM8B8?=
 =?us-ascii?Q?DMYy+slP8jRrmk9PCPPBMyu9e+KFa2kE+MdGKb3V3dtawi8sn+ZS4GJPq9qP?=
 =?us-ascii?Q?NtJnXaP9gzdNURBkfcz9iEbs/U0rWpZpvHqf6YDA3Ewoxv9N7qMIh7QRvHc7?=
 =?us-ascii?Q?9d2L1W56qSZDfsKreiyeCiWKh4YNXLgIopWF1smuAtT2Y2MerupvQvl2TVSr?=
 =?us-ascii?Q?m0yCBlwmz7XTQyZgmpdVOQGDxicBOuyHBYIg/oIgHe83DUVrO2hMxZZbIA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:16:41.5512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06053634-978b-45bb-251f-08ddbfd589c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9238

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

The feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
Injection Allocation Enforcement (SDCIAE)

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
index 602957dd2609..db020bd60edc 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -494,6 +494,7 @@
 #define X86_FEATURE_TSA_SQ_NO		(21*32+11) /* AMD CPU not vulnerable to TSA-SQ */
 #define X86_FEATURE_TSA_L1_NO		(21*32+12) /* AMD CPU not vulnerable to TSA-L1 */
 #define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using VERW before VMRUN */
+#define X86_FEATURE_SDCIAE		(21*32+14) /* L3 Smart Data Cache Injection Allocation Enforcement */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 46efcbd6afa4..87e78586395b 100644
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
index b4a1f6732a3a..b22bfe81d262 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -50,6 +50,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,			CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,			CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,			CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_SDCIAE,			CPUID_EBX,  6, 0x80000020, 0 },
 	{ X86_FEATURE_TSA_SQ_NO,		CPUID_ECX,  1, 0x80000021, 0 },
 	{ X86_FEATURE_TSA_L1_NO,		CPUID_ECX,  2, 0x80000021, 0 },
 	{ X86_FEATURE_AMD_WORKLOAD_CLASS,	CPUID_EAX, 22, 0x80000021, 0 },
-- 
2.34.1


