Return-Path: <linux-kernel+bounces-746168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAAAB123D4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A941B563FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7597199EAD;
	Fri, 25 Jul 2025 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L3AU+1G5"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA312248869;
	Fri, 25 Jul 2025 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468274; cv=fail; b=n99MdnP/uK0Os3OrwysPtnx7hbivFEOoCLm0u/Uj8tzcncY+mzhP/VFB7sFzU2zh8yjdZYV+PlNiUR+a1HKewe8k+EGbUC6TPkaJzQOFbejdfjsGwABLavnXGcgEpeY9Gpgt1c3UjyRn03QcnRfn0ahL10JeKWRERBNDmNXZ9KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468274; c=relaxed/simple;
	bh=puIvZkNshZ8LHnu22QTcaE274k2xEvSwF5laNls5Qug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDNN4k1nSAYXYxyi9SbiwmyIozifiAtbxDcVp3tKteWeUPoq5msHZ6pP183t2us2QObwvmsEUej9PEYGEi4y+11ytVgNwXToSUG1xdjOSi92kgVtdvH6nIljCYfkZWZa5nv1hAzVWCJyYlGyCw45wBDFXwn1U3Aog6jMNkYcsXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L3AU+1G5; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6wKkLrdxPhRNdCECt0IbMJah4olISAfOvVBC4O1iSTNPPWq2V60ZBVPhydVp5nxaWa/5p2XSeo2B0jkHk7r//kAfVJu/C8Ft/PG9by0vMZQNYwXF2qnCwre1fItz/OtFBxeAydK3CZCGUIa8Ye2lF1Y6rtd91GZrtJ+V0eByu9bv6D/vAKIkbqT3AdnuTGofrlNeLNbYlFjKjnpWxkxgoV4utOHxxzFmmhQrY50NnpbvtHm++IZkEj6SlEJnsLXBstDUGZdkCgr+ZVjdILQsC2Go2uUaazXIWS4MmeP20ZhcMsEQLrWMEzbTuBAsxPV9B+78CDluGOD70Cgi0h4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XS1uTyS9FKUKhZA23c5i8Kl937iuC0noN5nbUAuMKD0=;
 b=vhB6BKv9DP0skWoUKpT8FVslTmNik4zPxacjvLVsfDXAf7/T1LZyCBWKFLPpcnSHegNm8J1XAyIj4bFQtNBiGf4OX/eohdwa3nVd3ixEYuxdgzanBgKkkYyTUIWC+Jb2m+iI9sCBNAHOvgPT1TMTIdWqNS7ermzpHATrcTpaX5w6o68t3oct7yTPlOg8TQ54pnBj90WtF858nsny9AKEpTffkOuxA2VyakX3VIdRBPc4LADpjf4QNesVAgi3Y46WJrjYTal/bzU60o9umcXqoB0IHkDNG5Ximm5l27bSKqNdh+O+deQnfrCsnhIRw1Zyl5Np0Lyzd/dWbrXr/O317g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XS1uTyS9FKUKhZA23c5i8Kl937iuC0noN5nbUAuMKD0=;
 b=L3AU+1G5QoFEbGq7YTFvg9NG/rxSyZc1a9kKCBZrROgswkvH17okrfWijKaZ0qsi9eqw4njc5cCesEpIhu5s/EWic0aKv1g23k7DvDxQOIYcWZGgZksCBn+mKrvdFIdbinnGyA7w36WdRnpIrPcNCknJqoISDSrKIC4VvnnMNjY=
Received: from BY3PR05CA0011.namprd05.prod.outlook.com (2603:10b6:a03:254::16)
 by LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 18:31:08 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::1c) by BY3PR05CA0011.outlook.office365.com
 (2603:10b6:a03:254::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.6 via Frontend Transport; Fri,
 25 Jul 2025 18:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:31:08 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:31:01 -0500
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
Subject: [PATCH v16 05/34] x86/cpufeatures: Add support for Assignable Bandwidth Monitoring Counters (ABMC)
Date: Fri, 25 Jul 2025 13:29:24 -0500
Message-ID: <e91505328b923e478d3d82141ecaf54ae4c06022.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|LV2PR12MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: 6703e705-98f8-451e-8a87-08ddcba96c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yct+HcxPwryLz2SCWPwl19WLawxB4YcT1z6SL/DQf0bpB9vya/SgcBRvacuc?=
 =?us-ascii?Q?JrsyNIFc/zGWguT6reH2fyJPYuPi6HDrg56DvFWUmKemImc8WfbGJl/t14+S?=
 =?us-ascii?Q?34+ohwiqHtBhkSbDafERPEKS8+SXmzpxeIhbvcD+db8Z8KDqO0qo9Uo/nxMT?=
 =?us-ascii?Q?iUlPNYj0ywg6oA+ayhNL2rGIAJ1ai/AqEpT7Hpj6c+loXaOB7PNHJTHBWhCT?=
 =?us-ascii?Q?60zP+DJL2QK5xGUA9ZywGrIY7orUYuwAjPspfNuTrebn1dpI3oZyyNV+3fY/?=
 =?us-ascii?Q?SJkN+PSqkVzesOw44VZKoS4GUfVAXtcacGae2rXEowc78DtZHDQ5Hhe0n75P?=
 =?us-ascii?Q?Q3Lz//G0ktR4teB5VX7I21h5eRndJYBqzCPhTqRiKEpDCT5BG7SWlXN4YlK+?=
 =?us-ascii?Q?IKFNPw1DROIAhyKaNfL5z6eBKis5d5RyvUl5uTLA0Q9CykQd4KtNlNNpQNVN?=
 =?us-ascii?Q?UrqVjjVS6L7Q0KYVW3w1QJjHEv155kFe5a0PabQMR3In6BDRqx6xKVWFrmLH?=
 =?us-ascii?Q?uQWvU05j7uxdAaz2qHycjP2W7RO0nAQnpod9vZdN9S7jbFK5Wzz8ICVsNxFe?=
 =?us-ascii?Q?93lCv+cAmUeMxKRUMhlKLV8G4d+waNVAE1+aK3nAtRLa9KZw5xjViIwVx/Yr?=
 =?us-ascii?Q?C9WzmC3hYVLf7DGbxH94YYKOSUUTGiSHMpNJFOvhFLWfnI4baJyrIqw5XcdY?=
 =?us-ascii?Q?TqxVRA710VzYt4hMXR35XtWlMLlgh4xbMbf/LJgAnJkhxQaTrwW8YwwEiliD?=
 =?us-ascii?Q?KGR7YaE47CQImvzpwzbcZONOKlu8Abm8qvj0WAtj8wch+2WcR0JZktWfInmT?=
 =?us-ascii?Q?TM66dVfzQteayHvz0I5b0a+8PjO05yYbhQ/eN7I1wUVLUjRjpPIsgXVffCro?=
 =?us-ascii?Q?rO4kxDC9A+qw+sUDmcHb+jSO8A8Gi0fnQvpNTNlmcNljWwKS2GZelcIt8F1C?=
 =?us-ascii?Q?lViVhMO4zahoiewLoOVaFFey3oAG0IC6LNh+ijnJO+TIJF8/z/ySjqwCOu18?=
 =?us-ascii?Q?arSU8qLtTlFc7pvKh+RXnlvoWxQf82CdVE2Y3uziqjG8T7cNgwQMQtPMEWz7?=
 =?us-ascii?Q?3Yz2AepdFAbCd5hcnG86VsvlRCbzGdLhjx0PurLrdhAx7Nvu0NLrywo6tpQi?=
 =?us-ascii?Q?UN8aazzEGx6ifAiZk6Ve3xwHn/ow+j3PRUsSFnGTnFeo1OtMmXlxQjKQHPA9?=
 =?us-ascii?Q?pzZix74QB/B0jVRV7c8liVtI1tSySPCdqG0WuI7F/P9WwJ9AzTjj6IzQkO5/?=
 =?us-ascii?Q?nUqYWqfCqPGade7BEtaIkZ4C1NNm5VwB4EkC+xvcOavep3wtPg6xRHt4rZAP?=
 =?us-ascii?Q?T0Ngbd/pD5QbGZgYmyuetu75a9ApuKsrP8C2SPAuhcAY7GbRoEp9RQYUIiZN?=
 =?us-ascii?Q?6PBp/5SU/4wtDqi5SQyqhDMrz/URLSs52y3lONKXRqYNyulwHi/HtPE9IjAG?=
 =?us-ascii?Q?BzQLNK2Mg/SFIFEwo60pZ5510NIG0OFyto0vCPzE9FFW7wnHYRDIb+M5Yzyn?=
 =?us-ascii?Q?mvSrV+REZmovZqGkrVa7sVnp84B86Lp/sYOJr1qdsh8eU/OvPzkNWxqpSg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:31:08.1520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6703e705-98f8-451e-8a87-08ddcba96c3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919

Users can create as many monitor groups as RMIDs supported by the hardware.
However, bandwidth monitoring feature on AMD system only guarantees that
RMIDs currently assigned to a processor will be tracked by hardware. The
counters of any other RMIDs which are no longer being tracked will be reset
to zero. The MBM event counters return "Unavailable" for the RMIDs that are
not tracked by hardware. So, there can be only limited number of groups
that can give guaranteed monitoring numbers. With ever changing
configurations there is no way to definitely know which of these groups are
being tracked during a particular time. Users do not have the option to
monitor a group or set of groups for a certain period of time without
worrying about RMID being reset in between.

The ABMC feature allows users to assign a hardware counter to an RMID,
event pair and monitor bandwidth usage as long as it is assigned. The
hardware continues to track the assigned counter until it is explicitly
unassigned by the user. There is no need to worry about counters being
reset during this period. Additionally, the user can specify the type of
memory transactions (e.g., reads, writes) for the counter to track.

Without ABMC enabled, monitoring will work in current mode without
assignment option.

The Linux resctrl subsystem provides an interface that allows monitoring of
up to two memory bandwidth events per group, selected from a combination of
available total and local events. When ABMC is enabled, two events will be
assigned to each group by default, in line with the current interface
design. Users will also have the option to configure which types of memory
transactions are counted by these events.

Due to the limited number of available counters (32), users may quickly
exhaust the available counters. If the system runs out of assignable ABMC
counters, the kernel will report an error. In such cases, users will need
to unassign one or more active counters to free up counters for new
assignments. resctrl will provide options to assign or unassign events
through the group-specific interface file.

The feature is detected via CPUID_Fn80000020_EBX_x00 bit 5.
Bits Description
5    ABMC (Assignable Bandwidth Monitoring Counters)

The feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
Note: Checkpatch checks/warnings are ignored to maintain coding style.

v16: Fixed the conflicts with latest cpufeatures.h and scattered.c files.

v15: Minor changelog update.

v14: Removed the dependancy on X86_FEATURE_CQM_MBM_TOTAL and X86_FEATURE_CQM_MBM_LOCAL.
     as discussed in https://lore.kernel.org/lkml/5f8b21c6-5166-46a6-be14-0c7c9bfb7cde@intel.com/
     Need to re-work on ABMC enumeration during the init.
     Updated changelog with few text update.

v13: Updated the commit log with Linux interface details.

v12: Removed the dependancy on X86_FEATURE_BMEC.
     Removed the Reviewed-by tag as patch has changed.

v11: No changes.

v10: No changes.

v9: Took care of couple of minor merge conflicts. No other changes.

v8: No changes.

v7: Removed "" from feature flags. Not required anymore.
    https://lore.kernel.org/lkml/20240817145058.GCZsC40neU4wkPXeVR@fat_crate.local/

v6: Added Reinette's Reviewed-by. Moved the Checkpatch note below ---.

v5: Minor rebase change and subject line update.

v4: Changes because of rebase. Feature word 21 has few more additions now.
    Changed the text to "tracked by hardware" instead of active.

v3: Change because of rebase. Actual patch did not change.

v2: Added dependency on X86_FEATURE_BMEC.
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 602957dd2609..43cba78a50e5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -494,6 +494,7 @@
 #define X86_FEATURE_TSA_SQ_NO		(21*32+11) /* AMD CPU not vulnerable to TSA-SQ */
 #define X86_FEATURE_TSA_L1_NO		(21*32+12) /* AMD CPU not vulnerable to TSA-L1 */
 #define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using VERW before VMRUN */
+#define X86_FEATURE_ABMC		(21*32+14) /* Assignable Bandwidth Monitoring Counters */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index b4a1f6732a3a..cdd3c3e2d4c6 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -50,6 +50,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,			CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,			CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,			CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_ABMC,			CPUID_EBX,  5, 0x80000020, 0 },
 	{ X86_FEATURE_TSA_SQ_NO,		CPUID_ECX,  1, 0x80000021, 0 },
 	{ X86_FEATURE_TSA_L1_NO,		CPUID_ECX,  2, 0x80000021, 0 },
 	{ X86_FEATURE_AMD_WORKLOAD_CLASS,	CPUID_EAX, 22, 0x80000021, 0 },
-- 
2.34.1


