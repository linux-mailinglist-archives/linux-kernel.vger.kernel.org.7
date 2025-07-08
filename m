Return-Path: <linux-kernel+bounces-722447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A03ADAFDADC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E691887910
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CE226158C;
	Tue,  8 Jul 2025 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="guHUrFw8"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0E2259C92;
	Tue,  8 Jul 2025 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013168; cv=fail; b=f8M2oYhKXuNcoGnhwEbpMJqDOWMUbhQE/1HAfJxogeAoEFSTOfjPtUcSLMiH6ZkhnCP09wQR8yltqfRMMEaKGqf5x3qg7jVeiYzRcfwrnAeE/kJf+X0zn2F/gsSxH8i3Ku/F9cq5ojNzioHlFajKuW7hD0Jncp02bhm0JGtKsmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013168; c=relaxed/simple;
	bh=dRcrhjT7nt+U2wQRV/FWHd5DT16YLJK2rsjgsIxWLAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDGE5h274RGvvpn9oVz8B1hIJcTTP3QAZVFgzpiaSQM9+klj48ldN5u26kJPS8FTKG4xlbE8v9bDgdUzKN2R8qmh7m3zlB56soazDXKJdypYkucG+kv5iVu1kyi6lWUJSOBm0TUbh7FzCgMqaK7DhZsD5XBWBfJhwclkaNIn0Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=guHUrFw8; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vz6SJomtOsxSUSKadIIJuMWe8kEVs74Q8IrJ8O6fT7oyG7C5TU+ilefEDvAlCPus4arK0iSFizwxjmxF68RldU12dFQgpBuwVJ63+gEIHIFcBB3FvSbNno4xsI/wJRzSAYI+ZY4M31GdJhglv+wbThEbjw93DbcldC6ca7fVpweC7Z9q7T9mU+Sp306/+Avm+REvzmumHDoxVpIpAqC+SKlrh0t2yHAlbTHP1ZqgjRrEgNuWXhsuSiKWRNw/8HeEtedML/Yx/03VQMbMa/YOGPgoPMEmBUek6/tJAIsOrO3KsvDCKblqob/CeX0WWstpmcJ8QBaTl+u7fXo4h6fsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGcgLZPPKbc8L3aGvyPVFyb1r2fm53UtInAYqYndJr0=;
 b=RQTo2IWx/a95dQSeTLnARCtn1Q5MWHkTbA4xcRzbmiHCkaVjhQ8VR1SIuyMnCEkT0fBugHVNZwj9yswjKmQ8AsCzenMdbHEVziMHjdRMFr4hjVEHdrliVqII0mtZFWG2Q3BAu+DIjYSKLRj289nF9BvrgaLv0Z3vRcrClgCGim6eB3DuJm4PFE/q/AhPZ3cD+WaRsfNc8IRlQS0WbLfT0na1fM+fDyo3NEarRQKHuAO0eVyIaSgYY82BvcNPPpgs9t/lYT9asfYqYp/lkGHZ6gJBi13OS/RXe+x2GShLeBUtxtOAuoECXwUFnt344QxrBt0oCF+JZoTtdI5ZK7v4IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGcgLZPPKbc8L3aGvyPVFyb1r2fm53UtInAYqYndJr0=;
 b=guHUrFw8T2egftkG32D4fRD2TFr4bAN8t8uh/fhjJB/0nvsw7RZrwOs6lecq8ymH3aKVW31PpXN3RGZKi2I9n5P2aaLjt1y0UPF3U9UN2BGMA9mZTqNFB+P6u0lrdZsumz5EPbGXNSMhLaLxYfrB8lRswAmGGIJW3yeAC6VfuVg=
Received: from BYAPR07CA0045.namprd07.prod.outlook.com (2603:10b6:a03:60::22)
 by SA3PR12MB9159.namprd12.prod.outlook.com (2603:10b6:806:3a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 22:19:22 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::9f) by BYAPR07CA0045.outlook.office365.com
 (2603:10b6:a03:60::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 22:19:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:19:21 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:19:16 -0500
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
Subject: [PATCH v15 09/34] x86/resctrl: Add support to enable/disable AMD ABMC feature
Date: Tue, 8 Jul 2025 17:17:18 -0500
Message-ID: <1dd845e0cc1d7a771da1afdf65e799e4fde6b5ed.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|SA3PR12MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 065b5286-addd-412c-70ff-08ddbe6d7d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nvN5s72ao+EHtKAy6XIQzWGdL8eGP6cu3z+s1WLqA+mW3H/UIj3Y+6Oxc4hR?=
 =?us-ascii?Q?sKrpIKtOPGoAF3ralv9uK2tczIDMJ/75mLIOpurY3nBclg/S1IdHn+aGRb3M?=
 =?us-ascii?Q?oBkVKuSOucYIk6hncaOoMsas1AF2n5985Jg3/pIpaAYVUuX3M7W0rOIlZtIJ?=
 =?us-ascii?Q?1E/fGlLCeuzJlOFhhitODSTSb3/2KReAppLeg4PNibB1ZzzSALmHfhzyYcNo?=
 =?us-ascii?Q?2p6TjFjlhkcGTP+SZt84Vq7ZTGJxtGd47fDR/TWQS/xDBgMPI1BH2Mr8fNpc?=
 =?us-ascii?Q?j0Sv5QroOHNaXx++T2sdg8YHxrDnTVC4tMlh59PYfbav2o/qs+oEcdep+jD6?=
 =?us-ascii?Q?bYQPe14LFQdU9QVLiIvQWO5dDpgZWE8mJAOalgbEDewKJtYKmXJhYRLvrveU?=
 =?us-ascii?Q?VM+mCsVXK4vYdWMOPV4lO/9KNpospMbtqZfLV/mZigKdX7I8hxN/1B9B2I98?=
 =?us-ascii?Q?UR4qga1juHqxZdoqvIuM6RcpkmPpGgD09oqeVHZzpOUjKzBsqlsKOC5Kc2NZ?=
 =?us-ascii?Q?4MOpHFgJsfgiS6I0Lh8eTkknkRBa8+4ZMAM4ZLWK/5g4XKcNh8bJzyLT2++6?=
 =?us-ascii?Q?6zHGXlY1qGeICOSpuI+bB4k6J+Ft3Ch/zJ/D1oF37nzIIu2GSyO7DM/X90+z?=
 =?us-ascii?Q?BcRUbaVaOqnmkl3wufW5kontqM5RS+d8XndzBkmIagvBgn4MiJUxDN7mxb9o?=
 =?us-ascii?Q?GT0g/Zbq+vwCXj98ob4bj+PJK73acZKxKVqquVABKEmq34zaG90TnrO2d4Ah?=
 =?us-ascii?Q?QIqkIQTwD+gAfPoMYYsW+pnP3Q0j6ss33Eo+LyQK8iZVysYj38X5XvrdzSNh?=
 =?us-ascii?Q?uYVBtLVB1YzT4ZrfJuxgPr8bcpLpk4PEmxgMqsmxkFXCO9kZi6edOPj47yxj?=
 =?us-ascii?Q?bU3PY+wxJlolgIpDLg1gj5GSS7y7WIggYK0yQQiMKSPV3APKmQgbv/UpcDCS?=
 =?us-ascii?Q?hDi9ZvANVxJiLeTe94sNJRwFnWWqP4pTQuWutZy+X3Vi4neUkYm12MUCv1SV?=
 =?us-ascii?Q?9WjDwcbZIi8IeMNHTTpe3oFbf8JoCKJCgfAG/fcMD8lBLc7hjGIpApIOtuGc?=
 =?us-ascii?Q?9QHgDK6xP9aaP5fKMBgUz2QijoYPltx34nyVGsTmr3DLF1GLn/6RfrVErvw5?=
 =?us-ascii?Q?lB/SD6x0yN/tDCWhNg9QCXE6uXN7yzdRVwF5y5voR4a5oMfnf84p3765Uu25?=
 =?us-ascii?Q?iZnG9TunTwfAKRRHn+E4c8qsOSMZ4dReWYgrBaLBbBMMIMx74fy+L7BVY4ur?=
 =?us-ascii?Q?C9VIxkizO/8zpXX5XHUFX2Q72i6lsxnR5oH4w00lppXbt3sFK3wkNouuSCN3?=
 =?us-ascii?Q?3EJBo6VFjRH4h0Hya0TwFgPW/d6elrTgGU9tqKWueEYff9E/UuI+vmG4Cv1E?=
 =?us-ascii?Q?jhg7YK2AftzMOM3RK8n48LiBzyGihto1YkNyavlqCE3fCPWBARUHlZVSNSOV?=
 =?us-ascii?Q?zYgMw/ZRtHH61kdOwNV+3x5GCaA4YssrBSJxPcnHDDPtELUbY9O7NE91Z1Wp?=
 =?us-ascii?Q?h2lvhwHWpVnW79PcmUqntI5YL+zycJBgkW7XTEFBWOr1yYCC/QSFpe98AQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:19:21.5056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 065b5286-addd-412c-70ff-08ddbe6d7d1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9159

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
---
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
index ff7e9743250f..a98367a353a5 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1216,6 +1216,7 @@
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


