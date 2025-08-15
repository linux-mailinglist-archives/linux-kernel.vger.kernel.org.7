Return-Path: <linux-kernel+bounces-769998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B735B275C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4A73BD9AB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0871329E105;
	Fri, 15 Aug 2025 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u1d1PYMK"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C47929B21C;
	Fri, 15 Aug 2025 02:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224847; cv=fail; b=EkftHli4nak3HRoWHfzBx0GhJdxc1P5wTEfLTKzvndiS+6+OTpRaVzieY8ePSsQ3c0cC2Ba6amVwv8e7t5lytZdudHIH+EaRxDiLGxqPDKHAY24XL9laB7SpJG7vZ/EvOdFbPt5GkfO1BV0r2WfJ/Xz+oV/wpo0NQd4nnX4lJjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224847; c=relaxed/simple;
	bh=I1nm1GpTtox9KdpQmubhgXJlMJGCtlTWpoBf+U5mfj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNkpBoAG4Mk9AGwjE03PMqoRfdEm15NECsbficU9Ol7Ds04jRziNnUskCqChPHaWE5ZKtGiDCW5XJuvEaMHAIgKIrxcPXZApHmA1lewnCjaEGgT+xoiEafjVWLcPqEIn2FUfuQ0IhQOUqsnOJRL4lkkxh3V2Xjq3w6hvJGFfoQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u1d1PYMK; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6VQyuiBHikIyYAa39yfV6tYRA34DVmIAteclK1Zx7QJ7wGG7o18mC8FKkZHje6zVIOe1ztwV1uSYF4pxj1TQPsaLo4ZQ//BeUx262zESYXo9PxVJW6JVpa97ORMTkFqX9xDUOEeutY7HazuW65NenY22L/somNju5Ll0bSLcVU046/VcYJ3rCuseuXPCAsPXemgn1cw3C411NXymLlarKA+MYkpTuq5EGDwvdkJuRWBao+okLx6RjVUHZ5dt3H40TOMvrb+72MDu/Rmh9nEorcjSwkP8TNiZboQOflhbr+2VTXgZTq5elnRaqWQWPFAIgJDR6wWaf+syZgAJP5ZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwGdWsGNgWQLS47vN7XeB/aIzNibDYZ93WqWZ8xShEE=;
 b=KK5c3eUDFMN/XGKWwUDi+ukhkx2Vo6rGGyl6l4E38U9tQ8hTGnRkKdLxKt5y3AEaYtbvjo2WreHDxNdGF5ARrAOqkcTln91zp+86BnMXzGdMCvPJuMmGDgQcV3jB00P9+9Yv58eUiZyNmSgJdN/a+7Ou0Y8zJrGUhidvgcXjT4YmPsPY/Qe36MUJo9y7tULPVKbd41YAkAqCvNl9lMUh3O6nqsDqLXO1Dm79hzNMa09Do0nushGoGTS4SoINi1KQDODP/AtaFM0WluSA28Jpdk9b3XLWY6os1dnwVMlCi4w2ID3esA5HoCgId6SsEXjPxs6sN7IlU55rbawsZjo8gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwGdWsGNgWQLS47vN7XeB/aIzNibDYZ93WqWZ8xShEE=;
 b=u1d1PYMKDUvcL56Jhpo0V0rUnBViOouQcV1HDI4t0di2JN7Kd9weAweaHinRPe8HKLeaLLUe5+iyHVC0oOhArxxofxa2URb9sYPdcA30ygrORIRdQu/DiTlsxJIt2Lqcikrq/12Dc11vV37C7Uoq+DnXG04BQ9RoBNYnmeufkxU=
Received: from SJ0PR03CA0357.namprd03.prod.outlook.com (2603:10b6:a03:39c::32)
 by IA0PPFDC28CEE69.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Fri, 15 Aug
 2025 02:27:20 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::6d) by SJ0PR03CA0357.outlook.office365.com
 (2603:10b6:a03:39c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 02:27:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:27:19 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:27:07 -0500
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
Subject: [PATCH v17 09/33] x86/resctrl: Add support to enable/disable AMD ABMC feature
Date: Thu, 14 Aug 2025 21:25:13 -0500
Message-ID: <6d4a30336cef58ed922459e5f3122f86b03861bf.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|IA0PPFDC28CEE69:EE_
X-MS-Office365-Filtering-Correlation-Id: 901e93ac-e06d-4d4f-0792-08dddba34233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q71S79bU5Y8o/ZdUHww+ALavVslFlEK+607AAaEWX4IWHg+Vrl2820nYA8jO?=
 =?us-ascii?Q?Wsamx8+lPjn5URXa97MGOUG6l9NLY7pU9w94MnWhG3JZiax5LVCZAoDkFAKD?=
 =?us-ascii?Q?KRRaKkLLtNMKI9NL2KQ8GXQyWROK1UMpr3wZ+51izEz8tF4z58hBnQgsimxH?=
 =?us-ascii?Q?/8w99Z69hq1wfWBbyP81WMFCtmKEmLqQDkJnoqvUftQJhKsP8Y5FBEPQt/Vd?=
 =?us-ascii?Q?PeUimbVJRu+3bF4UlyWtfO0IYeFfc+WSKrbaSvdLKvrzrAM2y4ft7XDysLFY?=
 =?us-ascii?Q?EnabzzmCxTyNibpjZx6Z2l7f4v2u8wGCBSWr5vXOG/rjLWe4YK587Ar6/02I?=
 =?us-ascii?Q?GJcUxCVRFwGyoZAx74fD6wj2LSak78OahB0S3ak6vy9YN7PWpJaH1e27wld5?=
 =?us-ascii?Q?9eBXbwSRVLeRSrpdSVeroj7juC+dRr0mAdW5Jjq/MlR03/wnb8e5mGPdFyS0?=
 =?us-ascii?Q?CpttBLGxfQTfqL2YB9I3cCoOLsruDHID7dGd2uyY/fbygZ4md41+eut0hwIJ?=
 =?us-ascii?Q?wGEX7crWzKgnvD88Arv7KSS3LAXYZBUBL4fN3RFGJBJrxx6C5I6fVcoeDZvQ?=
 =?us-ascii?Q?bk3eNxUj0gAyMjzjAjE0/Cd7ULnmq7sWA4+2O2YYzJ7kgP6qL8p83wXlSpf0?=
 =?us-ascii?Q?oJp2SCgTZH3gH30qXq39k6wrHHv7N1dqZreL2+zLrFB7tzF1tCaiCG4+oMZK?=
 =?us-ascii?Q?hWLsLCwIv4y/ofrvy3C2IwFmcXTRlZ6DZs5GS6+dz24O5ChDLP/rRwc65vYf?=
 =?us-ascii?Q?dwlf37O/ZuXBkQYN9giTN9kAvc1upgRQ3CfnG+xQEpFoWpPdb+S+9sYhk/Qm?=
 =?us-ascii?Q?MShWulY41E7Wyy95h0iJhmX5r5kaTCQrnNMX44/REqOMH2hURQaQ2KL8yy7P?=
 =?us-ascii?Q?hWKfn74rQGSCoH/gvL8C23tMHQhIx9C947dofjNW834bup/nq79alKX+UEDR?=
 =?us-ascii?Q?tor/Kd4UuKxWIreu58XvCDxlNvPtFswLCVDXi4E7WaEqpprW551WRA66/BOE?=
 =?us-ascii?Q?BoJMzYJJFxYgQ3ZDP2ujTWGKxGAYNcs1jjirjEedUIZGQcORLOADZ+8V3vzZ?=
 =?us-ascii?Q?Tn+waLCxJUShsK7IpU8XqCSPZ72/4PSO9MopVtdA9ctG96NkQPXJybzJTD9y?=
 =?us-ascii?Q?iQeSgA+CHkFG5wE0urMfm+zr/lC+RJL6jJ6JoFp74a9tCJa27LlrPPlRW/9M?=
 =?us-ascii?Q?t5fLaGa1af+N6Z+oXUV5wElcKYsUBnofKHgUxrkEX4r+glANDdupWW8VXL3r?=
 =?us-ascii?Q?ZhwJI5YB4p1xn59vBasdgy/YuGFSm/hCZWdvAl/d6cmQfcgqCoHvutl+hDWh?=
 =?us-ascii?Q?3uvGHASmJlSVeBlc+NgpNsg2zqZNchLMepzAMKFWnYpx9MMcRsHTAS62SDxa?=
 =?us-ascii?Q?Vky/tAEyYtiJFIAQ6ZCrtMNZyxcXlufbfw25MP5Q1rBYunW2OZWIJ8VHxoXv?=
 =?us-ascii?Q?iQktQamxBCJyUulJpCuqIajpJmmiZ7sqG3Eg81IkF0OVRm+irMbwxCEWXx/0?=
 =?us-ascii?Q?0zWsPfEp1HPxrDhumhc6cER71fPfENgv81mhc2HUJePgqtI0amlj3xuGWg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:27:19.1930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 901e93ac-e06d-4d4f-0792-08dddba34233
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFDC28CEE69

Add the functionality to enable/disable AMD ABMC feature.

AMD ABMC feature is enabled by setting enabled bit(0) in MSR
L3_QOS_EXT_CFG. When the state of ABMC is changed, the MSR needs
to be updated on all the logical processors in the QOS Domain.

Hardware counters will reset when ABMC state is changed.

The ABMC feature details are documented in APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v17: No changes.

v16: Added Reviewed-by tag.

v15: Minor comment change in resctrl.h.

v14: Added lockdep_assert_cpus_held() in _resctrl_abmc_enable().
     Removed inline for resctrl_arch_mbm_cntr_assign_enabled().
     Added prototype descriptions for resctrl_arch_mbm_cntr_assign_enabled()
     and resctrl_arch_mbm_cntr_assign_set() in include/linux/resctrl.h.

v13: Resolved minor conflicts with recent FS/ARCH restructure.

v12: Clarified the comment on _resctrl_abmc_enable().
     Added the code to reset arch state in _resctrl_abmc_enable().
     Resolved the conflicts with latest merge.

v11: Moved the monitoring related calls to monitor.c file.
     Moved the changes from include/linux/resctrl.h to
     arch/x86/kernel/cpu/resctrl/internal.h.
     Removed the Reviewed-by tag as patch changed.
     Actual code did not change.

v10: No changes.

v9: Re-ordered the MSR and added Reviewed-by tag.

v8: Commit message update and moved around the comments about L3_QOS_EXT_CFG
    to _resctrl_abmc_enable.

v7: Renamed the function
    resctrl_arch_get_abmc_enabled() to resctrl_arch_mbm_cntr_assign_enabled().

    Merged resctrl_arch_mbm_cntr_assign_disable, resctrl_arch_mbm_cntr_assign_disable
    and renamed to resctrl_arch_mbm_cntr_assign_set().

    Moved the function definition to linux/resctrl.h.

    Passed the struct rdt_resource to these functions.
    Removed resctrl_arch_reset_rmid_all() from arch code. This will be done
    from the caller.

v6: Renamed abmc_enabled to mbm_cntr_assign_enabled.
    Used msr_set_bit and msr_clear_bit for msr updates.
    Renamed resctrl_arch_abmc_enable() to resctrl_arch_mbm_cntr_assign_enable().
    Renamed resctrl_arch_abmc_disable() to resctrl_arch_mbm_cntr_assign_disable().
    Made _resctrl_abmc_enable to return void.

v5: Renamed resctrl_abmc_enable to resctrl_arch_abmc_enable.
    Renamed resctrl_abmc_disable to resctrl_arch_abmc_disable.
    Introduced resctrl_arch_get_abmc_enabled to get abmc state from
    non-arch code.
    Renamed resctrl_abmc_set_all to _resctrl_abmc_enable().
    Modified commit log to make it clear about AMD ABMC feature.

v3: No changes.

v2: Few text changes in commit message.
---
 arch/x86/include/asm/msr-index.h       |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h |  5 +++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 45 ++++++++++++++++++++++++++
 include/linux/resctrl.h                | 20 ++++++++++++
 4 files changed, 71 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index b65c3ba5fa14..e4945e5c92ef 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1223,6 +1223,7 @@
 /* - AMD: */
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
 #define MSR_IA32_SMBA_BW_BASE		0xc0000280
+#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
 #define MSR_IA32_EVT_CFG_BASE		0xc0000400
 
 /* AMD-V MSRs */
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 58dca892a5df..a79a487e639c 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -37,6 +37,9 @@ struct arch_mbm_state {
 	u64	prev_msr;
 };
 
+/* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
+#define ABMC_ENABLE_BIT			0
+
 /**
  * struct rdt_hw_ctrl_domain - Arch private attributes of a set of CPUs that share
  *			       a resource for a control function
@@ -102,6 +105,7 @@ struct msr_param {
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
  * @mbm_width:		Monitor width, to detect and correct for overflow.
  * @cdp_enabled:	CDP state of this resource
+ * @mbm_cntr_assign_enabled:	ABMC feature is enabled
  *
  * Members of this structure are either private to the architecture
  * e.g. mbm_width, or accessed via helpers that provide abstraction. e.g.
@@ -115,6 +119,7 @@ struct rdt_hw_resource {
 	unsigned int		mon_scale;
 	unsigned int		mbm_width;
 	bool			cdp_enabled;
+	bool			mbm_cntr_assign_enabled;
 };
 
 static inline struct rdt_hw_resource *resctrl_to_arch_res(struct rdt_resource *r)
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 0a695ce68f46..cce35a0ad455 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -399,3 +399,48 @@ void __init intel_rdt_mbm_apply_quirk(void)
 	mbm_cf_rmidthreshold = mbm_cf_table[cf_index].rmidthreshold;
 	mbm_cf = mbm_cf_table[cf_index].cf;
 }
+
+static void resctrl_abmc_set_one_amd(void *arg)
+{
+	bool *enable = arg;
+
+	if (*enable)
+		msr_set_bit(MSR_IA32_L3_QOS_EXT_CFG, ABMC_ENABLE_BIT);
+	else
+		msr_clear_bit(MSR_IA32_L3_QOS_EXT_CFG, ABMC_ENABLE_BIT);
+}
+
+/*
+ * ABMC enable/disable requires update of L3_QOS_EXT_CFG MSR on all the CPUs
+ * associated with all monitor domains.
+ */
+static void _resctrl_abmc_enable(struct rdt_resource *r, bool enable)
+{
+	struct rdt_mon_domain *d;
+
+	lockdep_assert_cpus_held();
+
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
+		on_each_cpu_mask(&d->hdr.cpu_mask, resctrl_abmc_set_one_amd,
+				 &enable, 1);
+		resctrl_arch_reset_rmid_all(r, d);
+	}
+}
+
+int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable)
+{
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+
+	if (r->mon.mbm_cntr_assignable &&
+	    hw_res->mbm_cntr_assign_enabled != enable) {
+		_resctrl_abmc_enable(r, enable);
+		hw_res->mbm_cntr_assign_enabled = enable;
+	}
+
+	return 0;
+}
+
+bool resctrl_arch_mbm_cntr_assign_enabled(struct rdt_resource *r)
+{
+	return resctrl_to_arch_res(r)->mbm_cntr_assign_enabled;
+}
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index eb80cc233be4..919806122c50 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -445,6 +445,26 @@ static inline u32 resctrl_get_config_index(u32 closid,
 bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l);
 int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 
+/**
+ * resctrl_arch_mbm_cntr_assign_enabled() - Check if MBM counter assignment
+ *					    mode is enabled.
+ * @r:		Pointer to the resource structure.
+ *
+ * Return:
+ * true if the assignment mode is enabled, false otherwise.
+ */
+bool resctrl_arch_mbm_cntr_assign_enabled(struct rdt_resource *r);
+
+/**
+ * resctrl_arch_mbm_cntr_assign_set() - Configure the MBM counter assignment mode.
+ * @r:		Pointer to the resource structure.
+ * @enable:	Set to true to enable, false to disable the assignment mode.
+ *
+ * Return:
+ * 0 on success, < 0 on error.
+ */
+int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable);
+
 /*
  * Update the ctrl_val and apply this config right now.
  * Must be called on one of the domain's CPUs.
-- 
2.34.1


