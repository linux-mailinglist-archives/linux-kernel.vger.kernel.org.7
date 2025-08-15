Return-Path: <linux-kernel+bounces-769993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5551B275BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6BCB603C94
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D0F29DB76;
	Fri, 15 Aug 2025 02:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WFVvMDhC"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB6A29D295;
	Fri, 15 Aug 2025 02:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224800; cv=fail; b=WFzHq/1GiGYjarCEDEb/PAruEX/rYBDvdDyI0tgUvTk0b0CB7HpcZTQSEP5PauzOr1vqHa11VBF+HRG1W942HBTqllAATl+R0l4J0Hd15K6m4VlQ1CS66Yu9XQXRbDaaD4lgCDeuggx9AqjPdLD3gzXHQ/9asv9gSGTUcyp7ypc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224800; c=relaxed/simple;
	bh=POI7RQTRXtHhI5D9sBp9nIihAfTDDRM2aX2szRFOFVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8nIQYsOwy9JsFrEquGzP91E4412c+ln4jlNq//jpJ5oFaM0X+0/ZmURxkurYZboFjRATUOY5+uW55JoPRcIyKpkFjJJBvMyMcx47R+BuhZt7KiRaV8LczKuSKOhf9OniyH2D436uqxpGoI3GDA2p21vvTFEeFwE+aVqw5VW5tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WFVvMDhC; arc=fail smtp.client-ip=40.107.102.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJR6OejQr0iak0xxJxKTD2Iyp8gFfKr4c0EfegLheu/YmqzxNNDTV4nbqFSkPlMM6ow69FjJ4nOiV4E8pn/9hYJuE5vjabuUu+er2XcI2eF1Yv7IqrXzQ/7cEUNKz4dRAouyOlnRWnjAFQhHuL7iAY4N+gQRGy3oj2HHJULAuRv7SvTFuh0fD/mQ1L0R0/CTWCqsiT/qPuPxz2nMhynBzJo04AR2xjvKl1TYJIjg/FgMWZfYeZbUQfvLmml1LnyM7LVJD/cdvB33og5T34ItbAK1EYSFz0Ea7IMvpxpOptb+ETEnxE//GcD0s530Z4kIjywFHCqPKs9wYoeIu/05Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ueo79UU/Zew7t0mrRygpLacaT/zFD2+RNeBKg10EMCA=;
 b=SnzlvV+lGSXhD1Dg5moYSOCWsZi01b2fpejOfyCy45HvN44R9tgi80UhZ2IdkDdOo512iJP6bxLdVKXPG2n/5uhEer7w0Qu97qTqdz+L2rkFK4CH84ffSQ/vK+SQj4mRip7RBjHz42puavDP4HOsYJYJYhWx2egm3EMZ/BS2nS2hs1nIEDZuFtdY5kgBGLpBHqr/hm1FixjJNcylmthi8RmCT50neHl5+UbwKlQpk1nI+8BjsQVU5XTR+BNv98+1c59Nw/hvqs0BSrEg61Ciiu3P+x9RS6JbwlR8HFAGHY1mGmn+xprv7M9fAsanb5qiy5K0TxCq4UmUF3BjMpEU/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ueo79UU/Zew7t0mrRygpLacaT/zFD2+RNeBKg10EMCA=;
 b=WFVvMDhCyl436QMonPWPnKCmE30cG5wO7KnE8CIbeOicX3CErjjhsEpyQxTUqRcdzwxqlsy4U6er3vKQ+70K8/np34SQEDRrwsViHwESltRdkCDlcF8oFR+k/ezyeWpgF17VyyjQhicQvCEpWLRUo93gs7FZJs3SBEj5mU5mpOo=
Received: from SA9PR13CA0105.namprd13.prod.outlook.com (2603:10b6:806:24::20)
 by CYXPR12MB9387.namprd12.prod.outlook.com (2603:10b6:930:e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 02:26:35 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::4) by SA9PR13CA0105.outlook.office365.com
 (2603:10b6:806:24::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.6 via Frontend Transport; Fri,
 15 Aug 2025 02:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:26:35 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:26:32 -0500
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
Subject: [PATCH v17 05/33] x86/cpufeatures: Add support for Assignable Bandwidth Monitoring Counters (ABMC)
Date: Thu, 14 Aug 2025 21:25:09 -0500
Message-ID: <8f2c506c2e0bdc4ab3e4736435d683ceb5322839.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|CYXPR12MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: f65e3a06-14b7-4694-2e9c-08dddba327db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JOOSHc+U+6dsfr6+sjHvSd2geATTr85S5OEKieBynj7mUvWmw9n31CdA1W8x?=
 =?us-ascii?Q?x6pTiKLYaE0OekJuOX19S+Bp2hlBhxtK9EWLJKKVOt2SdRwLj1BmXh/fW/b9?=
 =?us-ascii?Q?jnAPIHmFumhGheTM74AbDTcvSOqBSTl9IG6sn7UvE9A8G3yLOrPfYlaadVBY?=
 =?us-ascii?Q?qGcHC9s5t/PvyIh/sanNDUmn4FaYUCLMcU1Bbi2fW2ulaGNCuJl583t5jnfD?=
 =?us-ascii?Q?IVXAEExaKhM81nehKMhgoU11c7gfZk4gJ/SxOhqVJvZF4/rKIFIe1qyoFFjr?=
 =?us-ascii?Q?e7vqa133d3kvcxcdchLBmWGJmCThM40MZRY9ngjX2JhnbS4JyqznhwOtVvhp?=
 =?us-ascii?Q?yQtuu530xe+/uHNgSqKAvxjw5VMu7uHwGDhUTRwujc0ildfR9qQ5EljrRr16?=
 =?us-ascii?Q?Sa41jeXI8bi8VWsCnvQGlAIVvShyI3ksp8RK6H8FCKJGBaT9H+M8fVcDYxbV?=
 =?us-ascii?Q?AFdpkDrG8x/XZpUC2ZM6av182wXU36yRSv7Ja8K+ewVItB2iIboAptjpL2q8?=
 =?us-ascii?Q?nzLNuTTWKfmV8uA4yk7r4lH9kr+mvV9ist0wokkAK7wJWNt4NXc0VCwU2lPy?=
 =?us-ascii?Q?myn7QYSv/b1JomkFHxmaNtZIkdRiSCQMlkUg0XvtPab9YjYWxO8puRoRMJnm?=
 =?us-ascii?Q?UzHh3y7HxwIHlQA02j7oTkXEzDAduzE7aMxkY7iBCOt6xBYEhTLxW95cEvzy?=
 =?us-ascii?Q?6OFW068lePDT8uH/U2t6/b/a3vjiLHENIMgc+u10BLpKZu5viqomDAkcOkZC?=
 =?us-ascii?Q?ArjsrW0dR4Cm02AUTeeKqUOMI6Ty+KyKOcp8yiFPwaSeO3QNum2jNRyAB854?=
 =?us-ascii?Q?kjXDNlg1vLn8yaVUOCOAa74JZgVFdCq/uXgIm1ADwqoabL4Ry+bNpaLvh6rI?=
 =?us-ascii?Q?cu4E8q1UtwyYMVDJExWPJVXkso2B/jytGAgpnKDnVIXxPDRTMmo1m1IEE6iL?=
 =?us-ascii?Q?l0reM12SgOPDmT9wtmu15SltWpCpkQafbyclkgNXsBwJSy/G8E9EgbzT0ZQo?=
 =?us-ascii?Q?hKTZSYmdnQKuX7hH/ipz/bdjG3J0TFEvJek0gybBebjEqlgM8XNscTKUqxPP?=
 =?us-ascii?Q?jL1CDAP9GGFMDQIJhCiz79cL7Zy0JZWnVmPKuffEccXc+B0rqNBnhaQfLUVE?=
 =?us-ascii?Q?5R6tao2qprSBWZG6nlYAAoTLgbfztfGdApqI2IurCc8cgGExspI3Ak0E4zz+?=
 =?us-ascii?Q?54aQQTKLt/mxm3JUNRKZ4oJBYktvRJQZXqTyHbymCGkiFouKOovELGUZxMoj?=
 =?us-ascii?Q?Jsb5vroM0GAxZmsF7b4/30K+bHGXmVTWdzOg+9mAw3TlZgoFqdtJXefdWfjk?=
 =?us-ascii?Q?ruHz9Zl4bvv1TSUy23R9eIcQ+RJOSfWX4RdSdsg2oQbuvkI6jSUlj2hCZMIn?=
 =?us-ascii?Q?XBFf4DcPq0HkQ7QeNrY/CXAcEdDVxZVgCCsPHCIO5nzZhOzATyLdhRETR6QM?=
 =?us-ascii?Q?Bpb3pnsuOkj6IzicNd5V+VN2h2tRB8jv0aQyHinx3KDoK6D1IGFNbMbxgVRN?=
 =?us-ascii?Q?3dnJIpS+wF3GzEigxvoX9j+jVp2lnx4zY4dYq3ctFnqsyeETHdPxV8wjFQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:26:35.0652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f65e3a06-14b7-4694-2e9c-08dddba327db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9387

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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
Note: Checkpatch checks/warnings are ignored to maintain coding style.

v17: Added Reviewed-by tag.

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
index 06fc0479a23f..9a3bbd61f885 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -495,6 +495,7 @@
 #define X86_FEATURE_TSA_SQ_NO		(21*32+11) /* AMD CPU not vulnerable to TSA-SQ */
 #define X86_FEATURE_TSA_L1_NO		(21*32+12) /* AMD CPU not vulnerable to TSA-L1 */
 #define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using VERW before VMRUN */
+#define X86_FEATURE_ABMC		(21*32+14) /* Assignable Bandwidth Monitoring Counters */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 6b868afb26c3..4cee6213d667 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -51,6 +51,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_COHERENCY_SFW_NO,		CPUID_EBX, 31, 0x8000001f, 0 },
 	{ X86_FEATURE_SMBA,			CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,			CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_ABMC,			CPUID_EBX,  5, 0x80000020, 0 },
 	{ X86_FEATURE_TSA_SQ_NO,		CPUID_ECX,  1, 0x80000021, 0 },
 	{ X86_FEATURE_TSA_L1_NO,		CPUID_ECX,  2, 0x80000021, 0 },
 	{ X86_FEATURE_AMD_WORKLOAD_CLASS,	CPUID_EAX, 22, 0x80000021, 0 },
-- 
2.34.1


