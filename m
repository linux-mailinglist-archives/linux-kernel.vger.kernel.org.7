Return-Path: <linux-kernel+bounces-722444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A92AFDAD7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D935B56618A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185D32638B2;
	Tue,  8 Jul 2025 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="38PRDMCD"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917F3264A9C;
	Tue,  8 Jul 2025 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013129; cv=fail; b=Fap1IF1cHVfXufrQceL1ekwDYp8WjnqgpWs4SfNXULXdEM4qHbnDvPZZjkkEobw6kB0+fDBKHHkjX5V9xDUJanF+5bPGfo2HI2t7yLzF0NGunYxQRqbgAQ6pPucjtQly2rdEZaUmWf36ts9bKw6Lfhv/zGiapYo27fs1Bev/9Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013129; c=relaxed/simple;
	bh=0njqjGO0qb2p1FbUpAcJxmSjoYcQgd+byND8vNT7BIY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YN3rgua658c5WSIof9X/+Slr5SE46AJiHpv7nHl19Pw7HXz0JKvFLebVQBAYQbtTjruBdcXzQxfHMujhOVuiGD3jzG097YEGFfgtad8q4EGFiCSkGAvMvpm84ed90LDUxkFFJjBJiZmMWQdiN0PjB3ZqL+C4c6C5TMs1TcP1/iQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=38PRDMCD; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmNtRNWnp8ZSDa3B85abmEt5kim4WcydJHO07WX+zwxOsPzwnSN9LK9fJtwVFQKLBJgsEMU2tzb703vHha57TrHuqykB5t2Iw1y7E1ON8hEojSicyWNqiAWUqfAyDQenRFBIsetTjxRF2jdbSbh6LlcumuIh46UmgmJX0nLodF85CF0TZOPbjpy15fM/kInBCBeh6A9pMIeJFWYtD26fuTs7imid0mnnaY3YevZS/YsxxtuHQql6/4vfmuDhfkulT6eAwTXkuD8HmFLzSgFpx5ead/z4QbWOkTyvRls85Y9dM0vRAhiAoTwW4B3SSWNKfQPhMhxZ3qwk+kLbPfDBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deQ16UW5epwipfqvePKIN5RMY7l7bvRVsWDSRePRfb0=;
 b=QuUDcEr9RpQo4SJM+PMMoCP2/vM4PiWWyv4oj/iiz9N0CQRuwWeEyWeQ/GO7Q862yipzCyehdgxYInaLXi6Zie8XA3QBVV8VrHu6DYKLimNWvoQ7yW4CD0M/3RHNGISsYz4NsEVTn8NEruO8PWx5qAJOSjF8c65+Wk7CXwUftHoFVYysHxbzKD9g+r3vkm7pi7nwMM4pZAZBD+XTiWB25o/boZ+UO32RW/pRJo8w9HuFg68zLsnDEFde1EOC+iJajLGlhvEkqtarynJjMwAi3X2jcogDg6KRiJtYAfeBIWx7YsHZAe1y+KlEpELiJtPdFn2AMOrsTcmHT2/6aHHsnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deQ16UW5epwipfqvePKIN5RMY7l7bvRVsWDSRePRfb0=;
 b=38PRDMCDVd7JXujW+hVYDUhLAYjlSe0Q6hfjJ3jb8rml3P4SzLkNxDcf/xMMcx/nH1T5VLUNQSUkuuoGGmEdAANuXOlA2VpVOf7ZtD11a3fadKJeLrI9kqznkbwhn+U+cVD+D3neMG1fBkMlU28LZWrLqpGUilU05INrx21driw=
Received: from MW4PR04CA0194.namprd04.prod.outlook.com (2603:10b6:303:86::19)
 by LV8PR12MB9716.namprd12.prod.outlook.com (2603:10b6:408:2a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 22:18:45 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::76) by MW4PR04CA0194.outlook.office365.com
 (2603:10b6:303:86::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 22:18:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 22:18:44 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:18:41 -0500
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
Subject: [PATCH v15 05/34] x86/cpufeatures: Add support for Assignable Bandwidth Monitoring Counters (ABMC)
Date: Tue, 8 Jul 2025 17:17:14 -0500
Message-ID: <d55fea7bdb5df1e39de59b23289197ace08020b8.1752013061.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752013061.git.babu.moger@amd.com>
References: <cover.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|LV8PR12MB9716:EE_
X-MS-Office365-Filtering-Correlation-Id: 055de757-0e1d-4699-7447-08ddbe6d66e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z48Cf544n5IODHMOxv0GosJQS3coyf1jqBu3jZNHYC26JZZgrooE7ae2v7NR?=
 =?us-ascii?Q?Mc7YOv4ks+mroCuXbOQYKIsx0rbvu2K9/R8Asqc/8VsxB3eHRvOAEXuQ3bxI?=
 =?us-ascii?Q?bvSKZWVWui+mvOSGKzOguQqyES2tUaQ/rRbYseT8oLCaG8pXdOVavzx1Ju/K?=
 =?us-ascii?Q?3c1/DmhfY+t4ZyKMoiA/a85XTcU/Pvj1PJcWGpewBflZgQEBPJdPzhsSQiSx?=
 =?us-ascii?Q?bRSKLXDR/hC6Gz5mZLuK2a371uscpd22EZMyFmpasSLiW97Z68qwQiufpWaX?=
 =?us-ascii?Q?So5c/2B7G29KAtvgwn6uLINZrMpSBAvUr5PJruD20ciW7Q1VM4481PhL3Wo4?=
 =?us-ascii?Q?GA96fQd+g6NdccyiChlBC3p3TyMroxwV5aN+G8Dhzd51OWcY3WbHO4rEPdRk?=
 =?us-ascii?Q?xhUowZk3zxFjliST57LhQsstc6tCxvQicfY65Bu4So9ciDlblnER9dqeXZfE?=
 =?us-ascii?Q?1ON97xoVIYg/wK/X8W0E2FqKh4b9DyPvyiUKiGqvoijBgF8vz6caN5of1Wh9?=
 =?us-ascii?Q?oQumGL8sKAwH5QbMPXvvfn+dTsFDjDJLVaIglK9X47v2T82ruXQ2NtO01MjW?=
 =?us-ascii?Q?edueZ90sDTX/00wckwKrlABJlr+dHaUVwdslTLcnW/ds5gkarQyTUAI9vVH7?=
 =?us-ascii?Q?D9AfAwRUbq5gke24pG9RBfVpEClIq4pnhrgPs0lKmEkcHNtBKHJ0IBVaOMjZ?=
 =?us-ascii?Q?Sn2/8oJhn6+4pCkXpNmlVzPYBYnoyxWoNP7HBiuFVMZDqLbUHBoEglsLr0rE?=
 =?us-ascii?Q?oR2AiuNE+xv5A2WeD65epC/0Gf7yyUT8rOqi1wbxU4CM89IRPQfDdWHjHfMP?=
 =?us-ascii?Q?aDyF7fBE5wGkuBIJ/osCxnMonLUaEPmv9+HoysW/VNpAPeK+QiBc2Kuc1iBB?=
 =?us-ascii?Q?uittMrhB/C5sND9C3TCecWI7huA12Ln78mT6olbsbbWaRi0eHOZQXPkFbS90?=
 =?us-ascii?Q?QwD98ZvNKuL5sv/lKoOxC8XaFntgiIsJeFloDUnCulgb/R9mxy3kdvzJFlyl?=
 =?us-ascii?Q?Zvzb+2lG+L8hLcK2PIVRxoiu8GQ6H2lJXVuNWzMtDWwm2pFpy0G0JQtPEMsI?=
 =?us-ascii?Q?Qj5ETUbyRhNZ8NFFKZ5tHMFD3OzvKraWXkWqfCCMyjv4AO59xjs/x6gt0FwW?=
 =?us-ascii?Q?x5Z6i1SEy8GmSy5Rzs6MU1PaPftGfum+dc4diTkkifSoS8YxwCDda13Gqnr1?=
 =?us-ascii?Q?b5srrIeMndvSiyuFWND4/tFHhAI5kD6K+LSb4ba639aFPeocQk2MVKryMl/2?=
 =?us-ascii?Q?5ER7dj7a2U3/0Szo+D3gmjp1p5fYKkaHsWzy2iz10Vqhm37WBGaQ3oW2jWQ0?=
 =?us-ascii?Q?OYsPAMDoc1XackFB/tNKRTnE6YKcTCY1FTwcYhCU1ZvP7ahH1+804El8bSgJ?=
 =?us-ascii?Q?y+4tspYUqMQPWJkshqWZ8t21CilErFMhxQvVUq9pxlPBJkCz+rFeAXs6L5si?=
 =?us-ascii?Q?D6I+OYKJR5ULjsFmUymJ8s8XmywCf/fdb6NYLXzB9D1sKOQOz7rrAxTbljCY?=
 =?us-ascii?Q?5BI0M4ml65JkJG9Fy3qaft7AZ2YZ+j+Yv6q1fEDeDXjApCCftyiE8vcogg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:18:44.2222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 055de757-0e1d-4699-7447-08ddbe6d66e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9716

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
index b78af55aa22e..d2950a0177cd 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -490,6 +490,7 @@
 #define X86_FEATURE_PREFER_YMM		(21*32+ 8) /* Avoid ZMM registers due to downclocking */
 #define X86_FEATURE_APX			(21*32+ 9) /* Advanced Performance Extensions */
 #define X86_FEATURE_INDIRECT_THUNK_ITS	(21*32+10) /* Use thunk for indirect branches in lower half of cacheline */
+#define X86_FEATURE_ABMC		(21*32+11) /* Assignable Bandwidth Monitoring Counters */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index dbf6d71bdf18..d5d4a573aaf7 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -50,6 +50,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,			CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,			CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,			CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_ABMC,			CPUID_EBX,  5, 0x80000020, 0 },
 	{ X86_FEATURE_AMD_WORKLOAD_CLASS,	CPUID_EAX, 22, 0x80000021, 0 },
 	{ X86_FEATURE_PERFMON_V2,		CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,		CPUID_EAX,  1, 0x80000022, 0 },
-- 
2.34.1


