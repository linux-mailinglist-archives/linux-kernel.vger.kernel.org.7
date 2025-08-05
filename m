Return-Path: <linux-kernel+bounces-757067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A1DB1BD52
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013E07209A6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38DC244691;
	Tue,  5 Aug 2025 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ocZnV/fK"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AB32441A6;
	Tue,  5 Aug 2025 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436665; cv=fail; b=Lz+FFIfMhVe3BmnTpfuvuO0MC6S4CuR+xgUXRF+0RYFtfFqmlgD15d8ipqwFyS3ke2FyOtVHxJuod/94xTUuznjPo2NrSrEydIuKUcLdoIaQZsJg40UYu8hdOx6rYaB3tFlJtOZtX/g2Q6TWiMaLELZfbTsskBDMNSZ8mYzicp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436665; c=relaxed/simple;
	bh=6qboWdSIwEsSzECiUsTk9rS1D/3PpO0Guk/iQRp92Rw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TERsztMN8lBmCsgWb7gM+bd2zYWAW84w3E2mc9K1Piicpa7onnZ+vNJHw7rHfUDYfRibxG6uNVOMPJ6K9FSLMBx+rnGhaoDLVt9T3oKtEGj0JBd7FQ/psRipyt0jI2oUzryFz6kFkx93g5PX3vHrpRtDkPLandlPCPqBwmlWokM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ocZnV/fK; arc=fail smtp.client-ip=40.107.102.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxDtKZD0oc1iGm5Eis0BiIc6U8hjQ9o7lWBuQ6juGi0CpLbaW8SnzuYo8fIQPUD9p6qRWs6VEkLr+JWsvO05gmh5S7xs3AN7lyiMgwI9aCYWKiRSe2pUvKkatoMgyyXVIkv/i9DYi09e1c+RT4yzVaOMwGFIu2X9j1pg0Jjhocepj5KB662oA/BeN6hGvwpst+CqE8yUA0W48i78mH5QfcHywrthXXk5m8kpZTqUttTJ+aYK3TIWVnPTCno8uwZUBzoqIUYZY45dnenJ3I0pyky28Sn7GZjy87WcP5URaNNuNjAWwXmHfffRHQQHxKTfAPwzezrjgqf0nYgn7dAK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4wHN08ZcMU3HIT3GIne1uHiaEhKM5yWEyOnIinudRk=;
 b=uNFhY/QTCn6/o33fFmTQATM/aAUGwoWxA/ztWOe7GoJQ3vAlW9s9FTfKOkzikudjiuEBTvo6XWw9XwGavhJskBoQqSEroXgwYflXfGs8oar4WOZUPjvvFwhwzhuVqbQIL0kurLTV47Zb60R9sFS44VhCr4MR+mglPvuQD8ivZ4OMSKRGskbKGbot0Hl9jaGcZ+bj3lnNwA8iHWVBdUfyva16yM9di5zJpJ7Wo5w4z9q79Gqhz1hJCy/6dhDsIOR0/cNSxU1bPxp+iRBKgB8qLbjtYE9miPJbeg4vkmWsQj+r91wXavlmJjXEuCq0+INec1Cr8MukpNgHLIQmMg2tPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4wHN08ZcMU3HIT3GIne1uHiaEhKM5yWEyOnIinudRk=;
 b=ocZnV/fKV6W2X/bbRxzhb+w7VjGlWoKAezrX/2CnxHWmBCZIRRn1WpkhBTIdw5rvEEokJCNG8YCG7yNx7tQvGR6dNjSeenR1A8Z/++droq7Hc1q301assWqOygXXxt+uTlzwiaz0sitygYXXXPwA+Ftcn3HFjQgWvxnBFdy+tPA=
Received: from SA0PR11CA0072.namprd11.prod.outlook.com (2603:10b6:806:d2::17)
 by BN7PPF08EEA05B5.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 5 Aug
 2025 23:30:57 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::4c) by SA0PR11CA0072.outlook.office365.com
 (2603:10b6:806:d2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 23:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 23:30:55 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 18:30:52 -0500
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
Subject: [PATCH v8 01/10] x86/cpufeatures: Add support for L3 Smart Data Cache Injection Allocation Enforcement
Date: Tue, 5 Aug 2025 18:30:21 -0500
Message-ID: <87e2289042750892815dc804a9284290716deba7.1754436586.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|BN7PPF08EEA05B5:EE_
X-MS-Office365-Filtering-Correlation-Id: 624aacae-ea59-4337-42b9-08ddd4781fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yNHVo0BvBoNEuuQ4dowQ/s5nrc9LFxIErPtCeuMRbW3APqKJwCbjDkW/qSjF?=
 =?us-ascii?Q?2GpHa3vAE/GmXBs3EiVmdE+0GujC9fIdQ1je3iSpQTWQAUA4C3yjWpDv7p4d?=
 =?us-ascii?Q?a8CYdXD66cNnbPfocLrRDfcFZFJF3qoLtIABseGEE8UH9ykNzJ4gIueDZEKW?=
 =?us-ascii?Q?LJhwrwqbdLsDOiXd0M/864tsIb/aFpTm726IHuWClbQ3vbl+cBLLy3DEjR0x?=
 =?us-ascii?Q?dS58R88yuL4eM3e7N+fCvTdBWDdDQCxD+5QB78ULhrbqfiHmHs9uM8/dNZ36?=
 =?us-ascii?Q?LmUYg2v0ZNLJFa3upqdGjvXTUVfgsTVDIFj1zjleGUNzAlHNMyQr5c/qOaJs?=
 =?us-ascii?Q?JP3Zh63er3Pb2BwHLQWfNdtldYrsRMjkWDBBhoVbM7uErl4r+cQgB1kPnc+j?=
 =?us-ascii?Q?j0koJMHRt4d7IT4Nb+fNjUb6e4oXTnRBpHJPKzw8vSbEq+WGMhPivenXsCY8?=
 =?us-ascii?Q?Kr0jgOfR3YfUZC85KW1L/QwVuBSkRlvgf8vPd+WIwNmuXqsLAdmiiHBo7QyV?=
 =?us-ascii?Q?7kEr0aYnj3dJAaoXUfXCi5pJAy3ToYoeGcO0GKlh/hAiB/56RuTK9g4Wuc33?=
 =?us-ascii?Q?cmR6kQRGK5edAg8le7VNTfMzrC+HOw2naUHceX+okOVKpn71H2XaEPfvYU8j?=
 =?us-ascii?Q?BzEqcv3vGNclyf43iAlDWQZYkTekejKB6Hu/Osn8M/Ot79lWOzRtt//wJe+l?=
 =?us-ascii?Q?6GLuP7apftf/mLatsrSTfdQW58U3xBvQdO+YeYh17rmuA1vrfbqZNmqEcqDD?=
 =?us-ascii?Q?AGGJITfkpE93HXDkqljM6ApQtUts6+iPKsgSreEpb4sY2rpfxEetpwXFTz/n?=
 =?us-ascii?Q?hqdGWfz2J164WZN3vgiR33VKMdhfQ9HLhjDYpMlvYgy1+WU4IfnOqav0U381?=
 =?us-ascii?Q?15DcAEuTexWOGiETV+4az3FJ+s6/O0Af4lqp+NVkVYBJvlwVDkUq8ZYL8Mqu?=
 =?us-ascii?Q?Lku3CiGzZvp0UCzWemgI+1i7yFtpVlKvkzFYaCO8/b35Rd24sZW0ZvUTQMpR?=
 =?us-ascii?Q?Yc8VKm8xnkPe8bLj8fel/p2nR5mHvj6RAGiTgFGBMa2bSlhWgOtioD9Intg4?=
 =?us-ascii?Q?lgLP/amCROemii0jDLODC93khmzsjpzy9yLaRPUnb07KYvl4zIiUBnTrjXL7?=
 =?us-ascii?Q?TpZjs7DTf1XBR/hT+SoiJZUz4zZkXMGEC+D2hKUpvXwZ9ygsFmYwF+DEjlTv?=
 =?us-ascii?Q?7qgh+aN3wowMIhEUrlkQqHoJQnKFxmRI1AtJiXxNlgzglxmoaB9EvhaWWVDr?=
 =?us-ascii?Q?8gr31F5L7eWDHuxKdsKSMu3BQ4UE7BOmJwhzLXpYYlfIOQYUw07wnjF8OaWU?=
 =?us-ascii?Q?X1dlQfxWoxdqNBw8zxCMr3/8j14QN2m1TyCO1I/QR6tB8h6ejLSayg0XFQB3?=
 =?us-ascii?Q?5ubKGjwvqY0j+GjX0+AYvq3fHBnp4GOLXaCL9FpWr2qZlBXL+/jTX5SNORLi?=
 =?us-ascii?Q?lKaT6rBGq/M7bvv4SyqpgcUakqIR4FnLE2C/4t9FV6ePl/QNEbp5SZFUGOBF?=
 =?us-ascii?Q?2i5MpEIn6STdM2RI0Sw7wFW/K1QN8CNyboSt8zPo6H8fS/ig6u0C2fbumw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 23:30:55.1766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 624aacae-ea59-4337-42b9-08ddd4781fe0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF08EEA05B5

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
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
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


