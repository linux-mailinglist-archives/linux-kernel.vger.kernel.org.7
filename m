Return-Path: <linux-kernel+bounces-746172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C260B123DC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ABDD1CE5A42
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF9D1DF247;
	Fri, 25 Jul 2025 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SEHDyiLZ"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDE824A07C;
	Fri, 25 Jul 2025 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468317; cv=fail; b=puPq6yBgAXb2annKYPZf7HXbp7PSV2FiPgry+9FwfPHknVcQFEM7rRyI9fImMlCF6UymYqTrYvLCk0SH7lrJIU5AOdGWL4plxq6deLCVxlRbKGWhhiyAuzq+ATAAq7JFp2znPSn4EgIFB2WwQBwKvSRJsPxw++CUvVL/aaZzyo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468317; c=relaxed/simple;
	bh=YOrVjL7APdbfJCezabMPX8AA1wQ/eNTRE5lSZ7BqMI8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7CVuSTT73fo10pcdeucyGK2+22SXg/fj5JfAXWm6inWGuyFqZXzoIi8cmjQ55Y75HcZbv+La1bD4bg5GuUH8hjpi4JnVHRQFT3LAsDKxjlD5Rm89Ve8m78fxpEIO0luBQsH/+gWRBqUor6Pg5wSuTTaOEN/DBXvhOIOLuP59lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SEHDyiLZ; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m19QW152UNcqOYeQK8CRKiOaZJlu7KCrhrFunmYRgUeaReJXdEnx/t3ffpT4pgUO88kSp6l47cO1Q+SGV5voPJKPXIasExq/dNlBhcOzuY3PXLdViUBuDPg/8zzvZK+gFOGtIXTJWR3geqJMQjngbO8ic8KjCFVGoI6EgrmrkrFgiftttn+Q5muhXOYwv7FvYanMF70i//OQHXwrh3k0PEASMVb/1dX2+8DyebGBewrbhMIzoQBcgsl4VdDZILUe1chYAloNbKM75QnXAekFJrc0mPyCU3M/qAAfu/49MjgYjgqhpQeIMzsFG6VImvCcjTERxOBV9NuBQHUJcV8Rmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ShULnPgzSwOdOR3JWXQdn/VGd+EEHB5ztuon49d8p4=;
 b=Qj5yDdHT+5ZDcSv98Y4uSlWg1AFMNTBGSVv4bgq4Nt82YW0MksWRLDPu5K9MpRD7/Pd6IsKdQqIlJddwTOV7RcnEQFS7qydfm3pYPuxS6oWKL51kwTkB+JpPzCTjdmwMmEwNydUN+bpaMrbFHXVaSS42pACNied4LN48P1MvrC1tfMy6wueLtCVRnWutoiJzwfpbMD/JooI4gi+iiKCQpFhnA1pUjjLWjGKTqOXIiLe/8Ja2flOqw7B/nNR3SqI70uUR1DHfD5RSdJcioxtcADSPYTsLLAlE2xSD66FLcbKbjPNMsBgakANpQRmVDWUH4hBKPbA1Mnpounqa0XTtag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ShULnPgzSwOdOR3JWXQdn/VGd+EEHB5ztuon49d8p4=;
 b=SEHDyiLZb3EzA8siUi4QoOzDRj9J7yohg3HGRJhuV2x4J71eaOTPC4e+AHPi6IE+7KLzaWAbmpR1Cx0GhlwG39kAIi9QQBe06b905zSZmgSok1/i+G1iBlFdNm9HEm8b05s/4hAzqtyukrbOheh0iMV0cQAyYWJdB5MSrFzDa5I=
Received: from SA0PR11CA0036.namprd11.prod.outlook.com (2603:10b6:806:d0::11)
 by MN0PR12MB5857.namprd12.prod.outlook.com (2603:10b6:208:378::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 18:31:49 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::7c) by SA0PR11CA0036.outlook.office365.com
 (2603:10b6:806:d0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Fri,
 25 Jul 2025 18:31:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:31:49 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:31:46 -0500
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
Subject: [PATCH v16 09/34] x86/resctrl: Add support to enable/disable AMD ABMC feature
Date: Fri, 25 Jul 2025 13:29:28 -0500
Message-ID: <0903bec452b28d99adf68ce168c64073fb9ef3de.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|MN0PR12MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: c945ceef-3029-4aa9-65dd-08ddcba984a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mKR7xUCwt7KD9ek9sUmOyk6XhYjRaMd5oR6Ks6gaFyH9V+HYdMoPlYgY0n2O?=
 =?us-ascii?Q?Vn4BJd8Pt0jnF7eX463LlKNgV76XPuysxZTpnZQktOZAWyDimmaSIgNUdy8c?=
 =?us-ascii?Q?dleEOx3J8/ru2dYagKNgWbWKYxMR7LbkFJVdiJzODXYqP7B1Fok2gO7pS1QY?=
 =?us-ascii?Q?3hQ/ATUjKCsRkxQT0D7AByaHvEFEXqfxApgjDOBDSkDSSCfMEvya5qWNZ7j/?=
 =?us-ascii?Q?RXWThWnW1KNt6GAdDYHMPgkEhe+31nC5pij3+11q/5VIy7PgKYoVaVj222ZD?=
 =?us-ascii?Q?VB5KzDn9NUcKa1vXwTz2rpcw/geHbME40txNUx+zqmQLyh1QB2LU8bP862A1?=
 =?us-ascii?Q?JEQA61e74cnpeyM0EXyzdMOZMZZLtkB6U4OIJRMQBu+9MjUM+MKwtXnHT1wz?=
 =?us-ascii?Q?zQdHagsIsl4M7dlbIgVT2z8mNyMJSu5jGWAUhvMfuf7SuhvCF6moj06yJeha?=
 =?us-ascii?Q?QjhOvCFJpYudoUGZueMV6yjKTrbqAN0aQfQ+9nnfGlm9r5pq3WfQLqxvdQyM?=
 =?us-ascii?Q?aVFTQRtLMkbRDgEPf5CWy3hjoYPxUPTyEtXei3NUDYGsUgsYrfNDmAP7GtsN?=
 =?us-ascii?Q?zwQnPGio1U1Aju/oqacOyNqg7F5bJUffsEhGbx6J0+8jE/a0DimzOtxebHGQ?=
 =?us-ascii?Q?WK/UEARsRRnaNHie9oBEtudnfZRLZv7My/aA2CSGjHJoHn3VlQ/tFipQveZc?=
 =?us-ascii?Q?7dVp36RtCEXx/gjXSQrE3wNb499k83b8iD7Uggf/nnZnXqbqD3f1tGu2jtIt?=
 =?us-ascii?Q?G3ShlTyISGy9SY+mavUAmJrUWaMTrjnB4Voa579QMZ1HF1OKeiihhtygR+/y?=
 =?us-ascii?Q?0o0TundhSEX6G18760axebEXmRSHTMVqLTFxZ3DRsW4JQDQ67S+dNieRo76w?=
 =?us-ascii?Q?uxgNKQaB3Me8b+VtN9nKpo+AnTPvX8q4I7VOPWpsDp7HUwRlGVTE7Q7yR2B4?=
 =?us-ascii?Q?hWnIbVUC74N2DghH+ExKXlKXS4SJCSDgbdQWEx3TJmNKvesrA/WxUaz9S4ZP?=
 =?us-ascii?Q?Xcn0QwtUgFm2U3ycCVsawZLGV2YSYgVfIqzjU7/+c/COApx4EG/bCj2ElSar?=
 =?us-ascii?Q?zOqUU3g9anAOGaRrVKpEYTKzmOYE5BdJaRU9gY1xvjfz5ifTPQqTUpLSb+II?=
 =?us-ascii?Q?37c0Osf3bJ31RiNFItz/PckGaAoCzTDo993V5ZUyY0y8fI0J7GJtK9jVQVOh?=
 =?us-ascii?Q?1iz5Om5EGdsvSYUSgw0u7vqneOGu28lXNKpoZGF5fgEzT7jvP1f5VGlMOeBW?=
 =?us-ascii?Q?5j91VkXQj3Uw01Zwv1lSGumKZ+0DSvAZ06leVAGivz4xmoAp8UbSGltkxKG+?=
 =?us-ascii?Q?bNfkQSIdmWY6zEbTGa7cvCuLMREUkHJKZipqJAMBvmQf7rBQCwmMoaIST9do?=
 =?us-ascii?Q?9pc6Jk26/oNMXKcc/pMYe8aQhGbHjzpEBjxYXUzLotup4YDSq+ruiWHrxdDI?=
 =?us-ascii?Q?s7Nz7WsaThgy64b8LWy2wcrcV9dLmkBAPecM6I+tkzmVDnXlkw9evamqKd1n?=
 =?us-ascii?Q?9Ect7/IV2MC2GrnCIzlAgZrTwzAEwkEsmVsH6iTyAmP1LtfNCGFiyZVGow?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:31:49.0892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c945ceef-3029-4aa9-65dd-08ddcba984a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5857

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
index 7490bb5c0776..c998cf0e1375 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1222,6 +1222,7 @@
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


