Return-Path: <linux-kernel+bounces-746179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29019B123EB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120981CE613F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9190253B66;
	Fri, 25 Jul 2025 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Ib/mw4B"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464C8250BEC;
	Fri, 25 Jul 2025 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468382; cv=fail; b=VnmxpnZOmtgmqW4ZUhILQdzRd5FRfKOmfOdHr68ssaEcWUFuSHQLPNw7Ptrr7ymjVYKM/PN7rexmu4rMIAlH6/zuTJYQ1T1gtgsKqnnXB7iPLxmXBv1K4UkjEfuJ32Q5YkfTt5c7GdK/6RcnXrVeDSg4AWCTOr+xoDkACeVvt3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468382; c=relaxed/simple;
	bh=Q6fGApYAdWysqgR5yUv0yW4IhHom5HxPObCIZjGX4/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0fy0nq9LPSDjJLzIkj67hYvqTlGGx9QZpmVh8ZMAPNiO6RI0sriLWw824PGyrA6pIytZ2T/h5ABtaULVWgm4Gr2iiRzEN0sbCas6H85KIQNve9bHm0xh5NAWC3SR2pPL4c21xLX7lTNO9DxvB2Xq6ZfygcTQ2MGqfN7hfIVCYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Ib/mw4B; arc=fail smtp.client-ip=40.107.100.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coxTv1b7QWbyy0xV16ffPl+vhMq6EP938WqCwPhukXw2pbBf/4nefLHuHQO0E4+fpbJQC0mB46xVJPIzrdIo96odc6DkoMtg5NvFIQDa+3etlfC2mq6GTTSVk9H1h1AxPQPAG5UUyWfKt4iYzF4kgZIOY45hOvAl+o9Ctly7O2WvziK0mNdnZ7UMzh08hjmyArQ3zmdgYQEFX09PvfuTN7MVud9E3vteRXdO3kr16E7RvgbQPQFAhAts8ydsyxTADHLykWzPQh8Egl2jcuw990Fl8Prbq89S0C8WKg5cYQ+8gOLpD23YHpC6noUGzf9QOACjgVqDVonblT+MlBxFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzVG2Uj5kF2q+xGh/LoyU9EeWt8mIYnbDRX+Br0+fPc=;
 b=IQdEtw9lF4LCls4LJ6fx9P8ZBAlOZjTNDrL/+diDD/I1+vlmqikiv5lTL2Gd/zpizYLDdm7UBq4Y5XNTweCzHAVQDL/65DS2FR3JUkRy+UIngxoBZNmY2GR/YlsZk+1Yd9VArWVljK6wS8FUuW7EhrnUvMZFu+q8i8piRxn/4d6hOknr7zO363VKZ+MSWiIDYCV7zeVFBqtx9yB6Vi+sUkl4wgj9VTz1PPkPeKWT/aYn1LOqRUQ+e5Y4/vUu/S9c2+16sq/hIy9I0htU2f7p8XiLnj6gaUFS8fx/SkFABf1ykPWgM5YjcYslf2kDjuCbSNINWLvbHAYonFt86rqGxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzVG2Uj5kF2q+xGh/LoyU9EeWt8mIYnbDRX+Br0+fPc=;
 b=4Ib/mw4BDRF/C3cYxecW14K3tYFCKmkclEqw1wXaCRk8HMox0oyUyMwTr0JxfrCEo/aaOYz/yg377VzWp7CYErI4T3VnXE5SFkVlQ5HNYmAKav589bvMA2ZoUOVjK9ptBknmF3r0e8EDGGCtJM5vI5iQCiI5BFgThXOSfKHatfw=
Received: from SJ0PR03CA0135.namprd03.prod.outlook.com (2603:10b6:a03:33c::20)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 25 Jul
 2025 18:32:57 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::2b) by SJ0PR03CA0135.outlook.office365.com
 (2603:10b6:a03:33c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 18:32:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:32:56 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:32:53 -0500
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
Subject: [PATCH v16 16/34] x86,fs/resctrl: Implement resctrl_arch_config_cntr() to assign a counter with ABMC
Date: Fri, 25 Jul 2025 13:29:35 -0500
Message-ID: <5ce91d983fdb22648e13727866b0b5ebe1428b32.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f40283-3480-430f-0927-08ddcba9ac90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DHnXpU1NPgxxBfxuFmkLYezIxlG7A9TTVOGJ8V1IFm10E5QeokpP/n7Ruugt?=
 =?us-ascii?Q?qQGzQ/dpT1yy3AXDuU4Ry95zRGbzStZhXWyiJ74wv4QHez9lS8dj7tmVnW/Y?=
 =?us-ascii?Q?u/Te4nCUdieKyNH01h0b5D6xPAumtaiCF1Z9BPscBIRGH2oVUnBJs6QC2LvS?=
 =?us-ascii?Q?3eTGVLdwCaZFHD0yxHoxL3ovhN9GMiCeOpv0CeZYZcKcr4DKlTa5e0kHArwv?=
 =?us-ascii?Q?xczti8ZTaCFTiN0QKwHxXZ/sI7V5oCkVDA3/XEZKKdZiKx5eh38LzOCkN0WF?=
 =?us-ascii?Q?32m8zqUtkxMri/sIvVD8XTsQjcwrB7abJdsU+0bWPvcyLvpOv2jVF3FmNUWq?=
 =?us-ascii?Q?fohoBcj+bV7/94scY4Ni5cvsB8ZgsdXuFj2Sz5vFkqUNUlupr2nH/fqoNrIM?=
 =?us-ascii?Q?2gQ8L4lH3Kj8ex7YeDxyshQuZD8XXMIo1F7UOQPKg9aynpWEU1IenX/hA7vB?=
 =?us-ascii?Q?04m33FF+Zy7VMaOFiDHu5j0HItxE7OL+Mllgx6M8LlZYRpSWRKOmaeJuXnnq?=
 =?us-ascii?Q?vLD0xbbmlNI3GFyl/mTZeUQtciIwrKmg8pzabtWlZFPgfQdLuq9huD/9mCw7?=
 =?us-ascii?Q?4o0+VEow3v25OJyZGKdFc5EEMT8jAmiLxBbW81lYFdFEBdBqGMAS+hr03Xb0?=
 =?us-ascii?Q?T7PjCfur7dQm7OGOx/96DgZ67wfK8tzWUvR2tHOUwtU/K2v5u037Tv155EcO?=
 =?us-ascii?Q?PFygFCdRnKqfc1hT0Y9C4OqZaaE6flYAQbFG46KmeMcdxUepJsEgeDaod7PY?=
 =?us-ascii?Q?mOP/cHJ7bPS9sLowFj//w8FwDVU9/9/dXrnHf0EKZRE6j8WlD2uhfmcUHcO7?=
 =?us-ascii?Q?7LkmIDHGUtlWyy0vKUzcdG53IF0d1zzt5Jct4qXorl6j7SPzAp0XMKfY2MX1?=
 =?us-ascii?Q?Km92RIUsfxMM072S0Uz7pFpmMBZHh0OZsGH8/woJmjdgTJmtmfG3chQ9txKx?=
 =?us-ascii?Q?2WHSzocc0q6LhfJfmjqFxnl8usbm4u1sCSD88g2Za5QN07+lU5s7Wc/HqzGG?=
 =?us-ascii?Q?j3dXM+aEMBpXVulYpXNfi7LfKgRDnb7KomUoVzvSzAte48AkbXNCrt1ppGpu?=
 =?us-ascii?Q?g5j9TNrwSUGo13YqNO9e5BLgZY6E0EFHNWvdPZP1q8bQNbslPxxUbzRQYRI1?=
 =?us-ascii?Q?67iqjGN32JYn+mcPHVQrOCnrnQo3UxMftFXY2FqME17IFAwqLDWt0/CKFK6M?=
 =?us-ascii?Q?Px5FPUIMpjLEx/oGhauClvnvOhzpVcYtXeMG49mib/7XEyaLBEa/H8zl3Jum?=
 =?us-ascii?Q?2e+tz1PKhfKbifVvEEb7n7J+T+DPXPDC8+EaKuMvzayB1gmUcsTMAcxBU+HX?=
 =?us-ascii?Q?FflPSaN5mJgVEk6M5ImfC0TA+eCDOCDHAnJtrH/cbmUSiYkVa5XhAdAu9oDB?=
 =?us-ascii?Q?JDHQcDCQOJreXsRwk4+neociCzJY7CuJ9BgIRnCLwFj7M51ZRuVQmvfuX8mO?=
 =?us-ascii?Q?ugcsHfHW+KCPt3pVLbsRFkvJpklS/XpknTgQk/kg4pX8xGWYdh9htJpttxji?=
 =?us-ascii?Q?1SGjrwKig2lSuGJEXuCo1rnKDZXZwGODDlLL7LyFBU9cK4suZucKIoBj2g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:32:56.0615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f40283-3480-430f-0927-08ddcba9ac90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237

The ABMC feature allows users to assign a hardware counter to an RMID,
event pair and monitor bandwidth usage as long as it is assigned. The
hardware continues to track the assigned counter until it is explicitly
unassigned by the user.

Implement an x86 architecture-specific handler to configure a counter. This
architecture specific handler is called by resctrl fs when a counter is
assigned or unassigned as well as when an already assigned counter's
configuration should be updated. Configure counters by writing to the
L3_QOS_ABMC_CFG MSR, specifying the counter ID, bandwidth source (RMID),
and event configuration.

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
    Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v16: Updated the changelog.
     Reset the architectural state in resctrl_arch_config_cntr() in both
     assign and unassign cases.

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
 arch/x86/kernel/cpu/resctrl/monitor.c | 36 +++++++++++++++++++++++++++
 include/linux/resctrl.h               | 19 ++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index cce35a0ad455..ed295a6c5e66 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -444,3 +444,39 @@ bool resctrl_arch_mbm_cntr_assign_enabled(struct rdt_resource *r)
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
+	am = get_arch_mbm_state(hw_dom, rmid, evtid);
+	if (am)
+		memset(am, 0, sizeof(*am));
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


