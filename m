Return-Path: <linux-kernel+bounces-746185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 427C3B123FE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B11D189464C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7260E253F03;
	Fri, 25 Jul 2025 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yLxfAdqi"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C2C248F63;
	Fri, 25 Jul 2025 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468444; cv=fail; b=sekmAw6Le5K8bRLsyVLsCyAQG8PE+MXTqZoZYKoPXWTjgTYk41SheM4qicaYShD0k4SgB+anMqbd1i40sodhy1BarFgTUWjk7cUIOdFjklmPYxrI6BhKEmh04fSuHSsxdL2rUutJlLFotseZkO95YgTrJi8J5ZbfXpymYWHqPKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468444; c=relaxed/simple;
	bh=S8oVp6bsB6adPGioc6Nje2I4ibyDx76f0SsFIRvIYsk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwzYqH4KV4VoUVBPMwstZZfHPyrVd+k48iot0myPR52IcEL/0Za+Wduvzvl68r0w9W5R/xq/BClFDqpb60qu09aGoFxQhp+8p6Sg7OXDbb9Vo4w3/1oaD7FJHDWH+wiFS4ous79CfaScHN96uf8C1tqrxuCZ2Kwml7pbjlVzQqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yLxfAdqi; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIeadYealoa5YZH8gjCAQmpW6ojvRmhKsxfVfh/e3K1NF2EoCiEGJs9aSgnNVHbTflQAwonlIKBH9UUsnRhQw40msZMl/i94L4GkDRve09M8hnRJli3ZbmhU0tHZV/2j8UQR4az9yvkVpHmKFaAxeAcBQ/LqY+C9dJNGAB4P1/T87VjKrBgEOg+3QIivs2dy4fh0x49Kxmxg8ddkoNjK8gV8grvFRS3sUAHux+781XmugbhGekFQxWtmPFmgW3aSfxZFFyjd76jRTdCmMwsJEiUhQhR2HeXEvSilN0fcu6pecM+0ulfGtg0J+h62q02J/xjnkHQRUff8EbRd3G8LLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gtdt9CAuvDML89r8vaBVSDFriuH/zRrwPGrQr7FvW7M=;
 b=wYDa6CKXPN/wd0lXRljHNu7GQrnns6GIqIX1hOvI2q3ze4gKUVotxDLeFsXYcedraUQzZKPDIdn3uPKQbo4UoHOPRKsYEOENQlIKMIF5fzoRnMxVb3y4eArH47m8aIu/mOptXnOlOIn/UP/OipThMTyQ9eprUpPjwgjE53XPrUe1CFvu0fXwqrBphqIbbgOunf1ARjs+/9Ac7lJMcatBi8+pUyx6o1Srj+UfV8djPoEBI+9NZaoTZMp4/LAv4370HFJvze4LwfmfFwXwrYj12uPwCz5JKe9fLZp1VGPWfFdfAuiDccStrJ/aUUTNeLbzvDm/KE2S9cIxqOeaLKqw0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gtdt9CAuvDML89r8vaBVSDFriuH/zRrwPGrQr7FvW7M=;
 b=yLxfAdqio4xs5OyQiS1UOtE+cvaNww4ImIaqcM1XiQtBjYA0pDeOxXsIluek5S23KhbQPCz0v/lpuNisc/XewXBkkQ7DdIOrOWD4IuDPcELLBGsoX+s6jcsDyIUhPAN9yP+9nEm2e5/0GJR/in6dzmqTgNteSBgb4EibiYXslIY=
Received: from SJ0PR03CA0070.namprd03.prod.outlook.com (2603:10b6:a03:331::15)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 18:33:59 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::f9) by SJ0PR03CA0070.outlook.office365.com
 (2603:10b6:a03:331::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.24 via Frontend Transport; Fri,
 25 Jul 2025 18:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:33:58 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:33:56 -0500
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
Subject: [PATCH v16 22/34] x86/resctrl: Implement resctrl_arch_reset_cntr() and resctrl_arch_cntr_read()
Date: Fri, 25 Jul 2025 13:29:41 -0500
Message-ID: <c11095389417ce2dec319f20619b3b13bddd5973.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 180a1bb7-deeb-4e81-68cb-08ddcba9d1e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hlCoypHamp7mpxeWCJPZVF60UXEAu/gEPvWegvscu/VrmsXP0KScTwixOux1?=
 =?us-ascii?Q?WiMkcWbsG/AEFvhbenp6XcsZCBCgf20PDNL0jYp/8xc6L2G421jUOfjhLM5b?=
 =?us-ascii?Q?SA7dHlSy3rpWgagxVf4ScJnoh570ZTp3mfWjB/+S9fH1r18xuWmavgM1AXTp?=
 =?us-ascii?Q?LjGSEjLyNpciCCeyGRQuofJRAljhk3pwadREXUohckqTCEkRC2Xhmhse745C?=
 =?us-ascii?Q?so945fYPpP+6Ifjj4eXdgmRDaX+T5ezpNUd0Gbq/HKqjkVYpczqXSI9nFiEj?=
 =?us-ascii?Q?HusEfivO8tQhXYhxVaOtL/tnpJdzSxLgPDo87x9Dl5Oj80LySLA4Dy+ujJyZ?=
 =?us-ascii?Q?tloRt5+LiJ6IJ+poQGbcXbeL8s0ngZbmgGsR70DP+bNPsvWXe0T8IjLOiw/L?=
 =?us-ascii?Q?nLL5R7dqk+MqEg0djXwKiWKsDDy7AopqSGgcFdlQhlunVkJNl1hzhbikZlko?=
 =?us-ascii?Q?xl54fp8axDRWQU3aUnwJHHr35gNcPW3P7WnolzSQePl/HnZhI4hUUGccCSHr?=
 =?us-ascii?Q?t3HrdUYHc6lKG7ke+R58cgCNHi82/TpZVtPTia44T/pRj/CNpbFDuhJhmSb9?=
 =?us-ascii?Q?XCXnefplr6i+xHo/n+AvVGu4VPuf+sutqKxtRPYg20VA9wqMaRJ09pWAv643?=
 =?us-ascii?Q?lKPun33Z+ja6abWKJzJjpdxMj6D6IYyVQN5RRWL9HEIaniI2OPZnO/T2nhmo?=
 =?us-ascii?Q?pi1nyYQklCPJ53va2SXOflWCXCuJE6ln9OJZr2aqov/FzGkhYeCAymIL3zut?=
 =?us-ascii?Q?22EzJGsb3sFItHqNEBj94jXAucAwMtkipQyZyYeyOMW5oQduCHHJO/6D//qa?=
 =?us-ascii?Q?032dmB63mWp5KfJc/NRbmUKR7ksMCZH+WixnR1kDIWkShtdwy5ahRVjECE9i?=
 =?us-ascii?Q?1c91n1ggvQQoy4howTwJPGcAHq+/GeDtrku8fiyfUC9VUum5zq3hKYVe59JX?=
 =?us-ascii?Q?xvLBsdSnNE9AeYFIFrdRFu79s6Yqnm11ZARRqhjb1W+QIAhRopXTbt+jdHa7?=
 =?us-ascii?Q?8li+HliMufPCNe/Ukt3+cCe5IOjVF6H1JnQipWcxGLLCsKEL18TkzIx/f19D?=
 =?us-ascii?Q?2ZFl5dfmtHHtmXO5uF6qxT6mwtKQokxn3yxPEcJJUfjDdAid6ixGjuycsHoo?=
 =?us-ascii?Q?4FamBkQeDIWmugbZh7HT9Tpr0RtCL+rsuMvsvD2vt9xpX8042XPJewsjlkEY?=
 =?us-ascii?Q?j1PqfUAMaBGYnrQfL1b7Ew81sIDurn9z7h6gOGzaI7WXkyZw/YHNwDWGxTIU?=
 =?us-ascii?Q?uSiI7rrAFH6vQsCRxf3/YymkxsehrzKhvQw7ZdOx8aXFki5/pUMy3V8HhmZ/?=
 =?us-ascii?Q?pT/Cnf7NLKw/PszX6U1MS6mmWK/6ynewcUoAmFQ96QTUvbP9M6+7k8p7K41c?=
 =?us-ascii?Q?ZIMQ3EV6iis3py3CZXOIIo52Zrq0ntRuUh26zOA50tgm4rI3k3QIPWQMGnOL?=
 =?us-ascii?Q?Fmyr8ejkixXVm635HcNUwBKiG4qzm0cXHiW80OII5LRWMVS4eJ+PIifMKOvb?=
 =?us-ascii?Q?ZEBPOlEJRyiEUHj3hAkqFn1+2JX307n6FuBk5+jJK0GGcMBI2oUXZsrf0g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:33:58.6974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 180a1bb7-deeb-4e81-68cb-08ddcba9d1e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239

System software can read resctrl event data for a particular resource by
writing the RMID and Event Identifier (EvtID) to the QM_EVTSEL register and
then reading the event data from the QM_CTR register.

In ABMC mode, the event data of a specific counter ID can be read by
setting the following fields: QM_EVTSEL.ExtendedEvtID = 1, QM_EVTSEL.EvtID
= L3CacheABMC (=1) and setting [RMID] to the desired counter ID. Reading
QM_CTR will then return the contents of the specified counter ID. The
RMID_VAL_ERROR bit will be set if the counter configuration was invalid, or
if an invalid counter ID was set in the QM_EVTSEL[RMID] field. If the
counter data is currently unavailable, the RMID_VAL_UNAVAIL bit will be
set.

Introduce resctrl_arch_reset_cntr() and resctrl_arch_cntr_read() to reset
and read event data for a specific counter.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v16: Updated the changelog.
     Removed the call resctrl_arch_rmid_read_context_check();
     Added the text about RMID_VAL_UNAVAIL error.

v15: Updated patch to add arch calls resctrl_arch_cntr_read() and resctrl_arch_reset_cntr()
     with mbm_event mode.
     https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/

v14: Updated the context in changelog. Added text in imperative tone.
     Added WARN_ON_ONCE() when cntr_id < 0.
     Improved code documentation in include/linux/resctrl.h.
     Added the check in mbm_update() to skip overflow handler when counter is unassigned.

v13: Split the patch into 2. First one to handle the passing of rdtgroup structure to few
     functions( __mon_event_count and mbm_update(). Second one to handle ABMC counter reading.
     Added new function __cntr_id_read_phys() to handle ABMC event reading.
     Updated kernel doc for resctrl_arch_reset_rmid() and resctrl_arch_rmid_read().
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The monitor.c file has now been split between the FS and ARCH directories.

v12: New patch to support extended event mode when ABMC is enabled.
---
 arch/x86/kernel/cpu/resctrl/internal.h |  6 +++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 68 ++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 6bf6042f11b6..ae4003d44df4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -40,6 +40,12 @@ struct arch_mbm_state {
 /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
 #define ABMC_ENABLE_BIT			0
 
+/*
+ * Qos Event Identifiers.
+ */
+#define ABMC_EXTENDED_EVT_ID		BIT(31)
+#define ABMC_EVT_ID			BIT(0)
+
 /**
  * struct rdt_hw_ctrl_domain - Arch private attributes of a set of CPUs that share
  *			       a resource for a control function
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 1f77fd58e707..57c8409a8247 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -259,6 +259,74 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 	return 0;
 }
 
+static int __cntr_id_read(u32 cntr_id, u64 *val)
+{
+	u64 msr_val;
+
+	/*
+	 * QM_EVTSEL Register definition:
+	 * =======================================================
+	 * Bits    Mnemonic        Description
+	 * =======================================================
+	 * 63:44   --              Reserved
+	 * 43:32   RMID            Resource Monitoring Identifier
+	 * 31      ExtEvtID        Extended Event Identifier
+	 * 30:8    --              Reserved
+	 * 7:0     EvtID           Event Identifier
+	 * =======================================================
+	 * The contents of a specific counter can be read by setting the
+	 * following fields in QM_EVTSEL.ExtendedEvtID(=1) and
+	 * QM_EVTSEL.EvtID = L3CacheABMC (=1) and setting [RMID] to the
+	 * desired counter ID. Reading QM_CTR will then return the
+	 * contents of the specified counter. The RMID_VAL_ERROR bit will
+	 * be set if the counter configuration was invalid, or if an invalid
+	 * counter ID was set in the QM_EVTSEL[RMID] field. If the counter
+	 * data is currently unavailable, the RMID_VAL_UNAVAIL bit will be set.
+	 */
+	wrmsr(MSR_IA32_QM_EVTSEL, ABMC_EXTENDED_EVT_ID | ABMC_EVT_ID, cntr_id);
+	rdmsrl(MSR_IA32_QM_CTR, msr_val);
+
+	if (msr_val & RMID_VAL_ERROR)
+		return -EIO;
+	if (msr_val & RMID_VAL_UNAVAIL)
+		return -EINVAL;
+
+	*val = msr_val;
+	return 0;
+}
+
+void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+			     u32 unused, u32 rmid, int cntr_id,
+			     enum resctrl_event_id eventid)
+{
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
+	struct arch_mbm_state *am;
+
+	am = get_arch_mbm_state(hw_dom, rmid, eventid);
+	if (am) {
+		memset(am, 0, sizeof(*am));
+
+		/* Record any initial, non-zero count value. */
+		__cntr_id_read(cntr_id, &am->prev_msr);
+	}
+}
+
+int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_mon_domain *d,
+			   u32 unused, u32 rmid, int cntr_id,
+			   enum resctrl_event_id eventid, u64 *val)
+{
+	u64 msr_val;
+	int ret;
+
+	ret = __cntr_id_read(cntr_id, &msr_val);
+	if (ret)
+		return ret;
+
+	*val = get_corrected_val(r, d, rmid, eventid, msr_val);
+
+	return 0;
+}
+
 /*
  * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
  * which indicates that RMIDs are configured in legacy mode.
-- 
2.34.1


