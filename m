Return-Path: <linux-kernel+bounces-722455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 375A8AFDAEB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAE3562D3F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BF525E469;
	Tue,  8 Jul 2025 22:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5DSZKbKY"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC3D25B312;
	Tue,  8 Jul 2025 22:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013242; cv=fail; b=PwWKeBFV5t07/58Z27Z278wgD2WEzgdz7UmIuoxyUTT7AkH4XQjSOmVNF8b6OSDcNQ25oUZyCcF9+nDEIwpooB/Pi8g0XuyWvD3wBYQhdnl++sF22ygpa/KcR8NABW51jB4RsVyVbRHLO8ViR7HnfHybKFGwrD5Dng3ra3QUHD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013242; c=relaxed/simple;
	bh=PHmZjDn1o2XUtH/H+8kc4PNd3Yc+g5l8ZB2wAZyWYmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAmbuEtP+KSKOhw1hgo7UiWydWIZZGFErR2jVqXWRly2VVobR2++/H0/3El1ltV5/Bbj7/JGfFRRRMEmaEjYH5Ul5QvI44DPdWX/+11g/xwKvnvr0dQHd5ar8kXt21dhQab9phFZWnjV5RZfKKVszDXzmVEGfpfck6r2S7T1yeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5DSZKbKY; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEcmeLPbWFbt1b0sBTFtS+yM8Vf1yN1FWZNNqfi6Sa6Bb3eMlUfF8ZI1p7vnfvEIDpLLsgVmsnMyRhBbeNNV+yOl7R9VXsFtZsfZ9H5WHVCTpdGRnjByK++fAkITWZXuEnLMGvynsF878VI/lARaG+NzeAt+5NUdV29KIijT08vOCtor+OPw1hx4UWXLnEnLvwRVCoiOqvv8VZo7qiOzdLVehDCczhgk7Isum53S5Tr3XmU6BDU6J4ZDvZ8WVxTELdNg+4FBSX/N0ogfxVz/3DTUPFjUOAhbSTtl+eB6Zd9wXNTcV7r1nVj0zQMjmYCgEdiXDEzarq+XoOCdB2D2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yriiHQhCGwJt8FCv+0FyyaVAhb2kXF4DSjbXP8vaAyU=;
 b=IIYkgOXHI1ihy+nEP/Jt3LgM8WXOnClCKbC4Jld/dWBv8IUboOA6bufj5IOPIiLOWKbCw5YB57xhRtjP8OhSUAkeuzDo1eBxlh8jPZR6hygvxOx7g+8PZU0qBZhdDbDg+S/ifDUO50+E/i2o5/ee/Bf2EWGZT/hOCOeD53+pNs526bfXHSrgS/xeI4gGcO19bzHS+ZbaE/GNCGl24TkdldgGH4yyX5n6pxWSjg5ggqTpt02BpTzugUhigR+9o3b8HxeEZaT9myiSXizUoJ9hYdBTqUrP54R0lZFhGKrdYuSzpS+dqYEnyqJDEkmxiwT+yF9BJla+vIVS07lMlJxqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yriiHQhCGwJt8FCv+0FyyaVAhb2kXF4DSjbXP8vaAyU=;
 b=5DSZKbKYbm4Qv3PqRtZfzeI63rV4sTTHcHJmtqyHajpe0tG1L4VjtlPNy03cwLSN2OtThDI1228vY+qTDOalQNrMmyCgXBpUMN95aN93vvqETkHrpyW+Vt5TddJKoZWxidK8lHieqk2fJenWJXMOze0ThDjwJEm6Sfz/a7bGqzo=
Received: from MW4PR04CA0194.namprd04.prod.outlook.com (2603:10b6:303:86::19)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 22:20:37 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::b4) by MW4PR04CA0194.outlook.office365.com
 (2603:10b6:303:86::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 22:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 22:20:36 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:20:17 -0500
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
Subject: [PATCH v15 16/34] x86,fs/resctrl: Implement resctrl_arch_config_cntr() to assign a counter with ABMC
Date: Tue, 8 Jul 2025 17:17:25 -0500
Message-ID: <f68d591f2471953e082ce03fef18c309a002bfb4.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d714a5-3926-4205-c903-08ddbe6daa19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EnAHnP1mdhjcZmi9XqIc/fQ+2tBJJuYlrAO38IOJlxK+/fHQEtmhNU8FA15I?=
 =?us-ascii?Q?/OW95+iNrRS+s4rLVv8tGEDKJaqkPIgh4GjAVwq8LjfG0hUAJ8AJhufYLQ1J?=
 =?us-ascii?Q?+gqOBLYlVSPAEIEU75tjFkT9SU6uNLn984KAHNVXOwS9uV4g2nvnY7ay9+DN?=
 =?us-ascii?Q?EpURrIj6VMIe67RqzvGRbfgvwwlJ6V1Cm5eXBJSlZlPdJiKoeRVaKRh25Lv8?=
 =?us-ascii?Q?mY/VClFFOkLfhMPTi/qSOEFiuhIj86s7k+S6ms7lZwH+N8qwMwD3zVG2+MdX?=
 =?us-ascii?Q?OI/vn5g5px0JnUMF338BFco0sQlDL2BEGaZra9uakrn5rQkFhCFC0252w7gv?=
 =?us-ascii?Q?t8ZAhDwqU2rfz9B9aCounAzx9NPP9j0MXbQkG4ABzumWCDojtG8XYaGPoJib?=
 =?us-ascii?Q?hHYZAwVVl3kuwl/jR9o/9ZdQNCdV6R+yna/Gq8dY0Nh4DVven8M8S/kkZ1iV?=
 =?us-ascii?Q?1Ek7Xw2VfAKTn2OQw34AtdbRvXvVPopQxOkIpZnaCyWwQZ1vcKZoXhbt/Yw7?=
 =?us-ascii?Q?aOgLexYRgblkN2HeyJqiFnSjwqKg28QbsKjE/2WE9zNvUvGVF9iFoyzfbRlS?=
 =?us-ascii?Q?WH2sbs9p7tPVXha5yst62Zoc386kC3R+eVYsU1tRVBydN9vDCMZD5KyoFRjh?=
 =?us-ascii?Q?Cn4zuce+dOsWKNfrzPFRhRrM30aaHn5mch9hzhrymWHTPNF0YT7aBaMaJ4UH?=
 =?us-ascii?Q?SbAfnXvP6SjvSadxOtuIWpUzGQ9RM/y4BlsHZ/3M9pYb3DTQVpPK8dOzw9ym?=
 =?us-ascii?Q?RmoxrCThB9VsHQwV5X1B4VfKumfoHb84BlycCqYMKv+ODAW2tu2r4Hl8q2af?=
 =?us-ascii?Q?8dWh4kEfM8M7bbluVjvp5Spk+IZzwMwpQrx90i8b2X6pBLxfULHwXudA7mSf?=
 =?us-ascii?Q?oiFB8U/uTu3auciS6rLMcAy6yVqbwDj11DjvrWbJJxT8HFTIP93yIfPRhJ4E?=
 =?us-ascii?Q?+QgdY6vqr997DHyvi9ypvy/UVuQMaeHderba1Am8DPWRI2e7yfd6khCEdFw6?=
 =?us-ascii?Q?mb83z/THfxrRk9A9mA4pbZ8pdZypIsENqOeSiOf0Y1ctpFKTH1QY1ay/naI4?=
 =?us-ascii?Q?tHBSL5nyQg63Ip4tWpP2d6ebb7YG/wlxZrar8BPTAJEvOd8HQrCBoGnMolH3?=
 =?us-ascii?Q?E806LSm2R3SLM+IvlAN3zjZUBxEHd6PKb40SNly5tJo/dfmolJ5g3rLuBujc?=
 =?us-ascii?Q?I561Nf3pGsOp8wa5tSiIZ2sHW+aOB8Ga/GrjyzoO/v3Lxd3y8akH39JqlS8L?=
 =?us-ascii?Q?q8B/tJ7cl9TpZ1f9FsIBBmPxBoEC9CsuVsUzWIKayQAQdz49pNflmv06Mrz8?=
 =?us-ascii?Q?FfyDfRiE91ZWMT/ZMZzsIlvfVxe2lxaw4BpGr+gRCPpj5mS6f2C4CoQ1YEa4?=
 =?us-ascii?Q?omJcftlYWaaaMcdnDfpTtkBwV0jh8zIIhTrJaJgdw8TLzALcqxEcpPzGVdIx?=
 =?us-ascii?Q?8AEhUJ4d+PZ7yksR7+kCGgCqyZ+6Vt9BD2Uq/bYa7vozYmOT6JvRnCaFMK2Q?=
 =?us-ascii?Q?hf5uxV6+JFIY5IkcEUStVKc7HOkZ7+nRlpNLNisq9/gBRAGRwvCAaT8P9g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:20:36.9653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d714a5-3926-4205-c903-08ddbe6daa19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470

The ABMC feature allows users to assign a hardware counter to an RMID,
event pair and monitor bandwidth usage as long as it is assigned. The
hardware continues to track the assigned counter until it is explicitly
unassigned by the user.

Implement an architecture-specific handler to assign and unassign the
counter. Configure counters by writing to the L3_QOS_ABMC_CFG MSR,
specifying the counter ID, bandwidth source (RMID), and event
configuration.

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
    Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: Minor changelog update.
     Added few code comments in include/linux/resctrl.h.

v14: Removed evt_cfg parameter in resctrl_arch_config_cntr(). Get evt_cfg
     only when assign is required.
     Minor update to changelog.

v13: Moved resctrl_arch_config_cntr() prototype to include/linux/resctrl.h.
     Changed resctrl_arch_config_cntr() to retun void from int.
     Updated the kernal doc for the prototype.
     Updated the code comment.

12: Added the check to reset the architecture-specific state only when
     assign is requested.
     Added evt_cfg as the parameter as the user will be passing the event
     configuration from /info/L3_MON/event_configs/.

v11: Moved resctrl_arch_assign_cntr() and resctrl_abmc_config_one_amd() to
     monitor.c.
     Added the code to reset the arch state in resctrl_arch_assign_cntr().
     Also removed resctrl_arch_reset_rmid() inside IPI as the counters are
     reset from the callers.
     Re-wrote commit message.

v10: Added call resctrl_arch_reset_rmid() to reset the RMID in the domain
     inside IPI call.
     SMP and non-SMP call support is not required in resctrl_arch_config_cntr
     with new domain specific assign approach/data structure.
     Commit message update.

v9: Removed the code to reset the architectural state. It will done
    in another patch.

v8: Rename resctrl_arch_assign_cntr to resctrl_arch_config_cntr.

v7: Separated arch and fs functions. This patch only has arch implementation.
    Added struct rdt_resource to the interface resctrl_arch_assign_cntr.
    Rename rdtgroup_abmc_cfg() to resctrl_abmc_config_one_amd().

v6: Removed mbm_cntr_alloc() from this patch to keep fs and arch code
    separate.
    Added code to update the counter assignment at domain level.

v5: Few name changes to match cntr_id.
    Changed the function names to
      rdtgroup_assign_cntr
      resctr_arch_assign_cntr
      More comments on commit log.
      Added function summary.

v4: Commit message update.
      User bitmap APIs where applicable.
      Changed the interfaces considering MPAM(arm).
      Added domain specific assignment.

v3: Removed the static from the prototype of rdtgroup_assign_abmc.
      The function is not called directly from user anymore. These
      changes are related to global assignment interface.

v2: Minor text changes in commit message.
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 38 +++++++++++++++++++++++++++
 include/linux/resctrl.h               | 19 ++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index cce35a0ad455..017f3b8e28f9 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -444,3 +444,41 @@ bool resctrl_arch_mbm_cntr_assign_enabled(struct rdt_resource *r)
 {
 	return resctrl_to_arch_res(r)->mbm_cntr_assign_enabled;
 }
+
+static void resctrl_abmc_config_one_amd(void *info)
+{
+	union l3_qos_abmc_cfg *abmc_cfg = info;
+
+	wrmsrl(MSR_IA32_L3_QOS_ABMC_CFG, abmc_cfg->full);
+}
+
+/*
+ * Send an IPI to the domain to assign the counter to RMID, event pair.
+ */
+void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
+			      u32 cntr_id, bool assign)
+{
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
+	union l3_qos_abmc_cfg abmc_cfg = { 0 };
+	struct arch_mbm_state *am;
+
+	abmc_cfg.split.cfg_en = 1;
+	abmc_cfg.split.cntr_en = assign ? 1 : 0;
+	abmc_cfg.split.cntr_id = cntr_id;
+	abmc_cfg.split.bw_src = rmid;
+	if (assign)
+		abmc_cfg.split.bw_type = resctrl_get_mon_evt_cfg(evtid);
+
+	smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd, &abmc_cfg, 1);
+
+	/*
+	 * The hardware counter is reset (because cfg_en == 1) so there is no
+	 * need to record initial non-zero counts.
+	 */
+	if (assign) {
+		am = get_arch_mbm_state(hw_dom, rmid, evtid);
+		if (am)
+			memset(am, 0, sizeof(*am));
+	}
+}
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 87daa4ca312d..50e38445183a 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -594,6 +594,25 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *
  */
 void resctrl_arch_reset_all_ctrls(struct rdt_resource *r);
 
+/**
+ * resctrl_arch_config_cntr() - Configure the counter with its new RMID
+ *				and event details.
+ * @r:			Resource structure.
+ * @d:			The domain in which counter with ID @cntr_id should be configured.
+ * @evtid:		Monitoring event type (e.g., QOS_L3_MBM_TOTAL_EVENT_ID
+ *			or QOS_L3_MBM_LOCAL_EVENT_ID).
+ * @rmid:		RMID.
+ * @closid:		CLOSID.
+ * @cntr_id:		Counter ID to configure.
+ * @assign:		True to assign the counter or update an existing assignment,
+ *			false to unassign the counter.
+ *
+ * This can be called from any CPU.
+ */
+void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
+			      u32 cntr_id, bool assign);
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
 
-- 
2.34.1


