Return-Path: <linux-kernel+bounces-722462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C820AFDAFB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A009B4E364C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B0E25334B;
	Tue,  8 Jul 2025 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SRUZePXc"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789E262D27;
	Tue,  8 Jul 2025 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013282; cv=fail; b=lorRcr5HSqCD0OJVj1BluWNhJFohsevcKNVTt3R43ZGprtl3PKK9dMDoNZS9D+CgIGcM3IG28hFEbcmpj/eR+gp7GITpHLtpJhJ673O4rgIno7QvzCRHrJQfNmDnBzMSLvV5jHrzBrWWKqT02Vdhe0/5iATrEyxHT30+qFUmfw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013282; c=relaxed/simple;
	bh=90jwvp4R5DnHdutJd34No84IYZ3MgOAKGIUeQ9pQoCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGKjdVZOjnbrcUHRWY8Lbaj5EQmNeBwnK6ayGiPrb6mQFNYjVofyPmsrK5eYFkbKs3iNeuGFtKTDSHgBkaLcGKMtB30ijIhcons54+FHPEtDI+QT8CGCjZoU1fp8EaZfCN0M+Nlo3dJucJ2NTiuJIDfWmU0CTU630vRwtBgkoTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SRUZePXc; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGI5NSXXN879+J2KjoIx52PnuiBfnE2sZS60Bhb36Gpmtoa9163hWtBWgNg+GjLKKsKoOYhVN7apHPBSgkSiNMczf1A5TJQEoPYUE0uy4Y0XWko2VXPutyWlrWKPVm/P48/Yho3Lwyx+NmO9jLDoOCWTmhGDY5adHK8kqhzXGOG+7G3IcOvCUtZnDMsJzjgfscrN0Muta/0nCNF96HVUbyIfDo/TDo2cBcqX+7BalQmGKIDn7fOyjv42A7e1J0aVXuEMMFEbJ8HKlpMM+vN1KbLQyxBGTKR3aya6l3O7nu0vMkPKqoxGQBRs4HdNEKdY4Xl2EUm0BjcHOaloyULAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QnLw+GTHMW01ryrU7GboBcZblNS8OcavUh8Q4QFc3M=;
 b=S+Zik6PV7n6peTDoWde7ydnRvyIrKlVnv/DfERLdJExXzMTRBi0MhyQamMuGP63LQHEVcfchL4zQDS2qqCqq9YcQEcmc7147ARDnbUFDMTb7W8SiotxK6zsQzANp1jt/KNNTwho1pg076PE33ixKNX3+1soe6k2AEkN1ix7LfWmjFMSq8L6gwsS5iRmoo404/SE29LBIb23LhdigwGTbKDtS/jG5XbQAsXTkiPGDqke537TavTZ0ZcY6wJlRhCJG1WxK6rLHC+xkTlD8qYzKoSBdMr8mIL69cN/H67nGJujksJCzC4gXBDxxpCLUauFaHYLp5jANNj5wEUZDiCFZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QnLw+GTHMW01ryrU7GboBcZblNS8OcavUh8Q4QFc3M=;
 b=SRUZePXcR6EhrJ8N4LzJnneae2AQ7IMpbEDrtTLIxB1j4is5gueJre9Y8QiRVbXypYG8rcp48ro0cugVTGUI0NVk7fRtIWsy6hHMO+Wz9SzjivjkuTzOcW65wO089Y3t7PSfchrF3ODnOTw4PlfojXT3fIzFbf0trfgMar9usVQ=
Received: from SJ0PR13CA0056.namprd13.prod.outlook.com (2603:10b6:a03:2c2::31)
 by MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Tue, 8 Jul
 2025 22:21:16 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::fc) by SJ0PR13CA0056.outlook.office365.com
 (2603:10b6:a03:2c2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 22:21:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:21:15 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:21:09 -0500
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
Subject: [PATCH v15 22/34] x86/resctrl: Implement resctrl_arch_reset_cntr() and resctrl_arch_cntr_read()
Date: Tue, 8 Jul 2025 17:17:31 -0500
Message-ID: <d31ab6c51a57591423d3aa7b8e741972cd66eb91.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb1b7f0-28fa-45ed-1781-08ddbe6dc147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eOVq15nSceRgRgPiArXbKdHFnbQU4wyGSQFTaWGf+rYZXb/uYAut9xmHEvSr?=
 =?us-ascii?Q?Y8LYWntcnXnmRrnmrTAezo2o1V8oH2nHJlfecOxR6znfo31ERJMcuQpSComu?=
 =?us-ascii?Q?+iIGZJ0r3cXnfvw12Y5JNHCkSg9DPpb5/VEQOcXHUdqh8KUWc2dW/K7+Z4hK?=
 =?us-ascii?Q?MeEssrGx4tIMaIxnYM/NG59bmBzxXT102XLZvd4XeS928bZs77DzmDWD12LT?=
 =?us-ascii?Q?V+ODChAXNTxXaUVvl6w9F14YLaoEdGNbd+eoHyl4BSjJOZnGvcHdeo7GQ77N?=
 =?us-ascii?Q?5v8K2LjkiSkwu+3sj3WWsHax83hWO9Lj/xbMifG3Cd0wE2SYrfDHws2s9Yj1?=
 =?us-ascii?Q?8m0z0gh3dreVVfjzhVPUdJFPmpSysSparGSknF0dgexVZH4MSSsPF4NRiLan?=
 =?us-ascii?Q?bqY0K5YG7e4FJT4NVQxQbqzhAfgaga09NQ5bwqtoKcf73/S870S+/lGbr0oy?=
 =?us-ascii?Q?KDQQVPYSnD5JCzYHqta6HeeXQh+oBjUB8+0AgobeunngtnYDk5ohNmfmErFg?=
 =?us-ascii?Q?xxkL4QKSfExLM8RC8zKrKPMijcTJO9vNEbiOJ+t2nBzx8BJ83Kg6mgMQPh6c?=
 =?us-ascii?Q?aZF6Er7qPPSJ8Ksn6l/+ydE6XmeplCa/nfJVWZ421X+lv9D9VgiTU8lQvN2v?=
 =?us-ascii?Q?xcy/4nAiSLvL1eO6I/sNqO0RtvjR8OiqpQsJv/zWlQOxflvbcfQtoO5otbC+?=
 =?us-ascii?Q?lOHaoWJZnho536tlMQd+QaoqZIKLb4yoKqsTgnF6pEpe5JWGVaizqxFmQCV9?=
 =?us-ascii?Q?F3VN2jtGv5qdo8j3lRYnQlbZUY05m9Vbb9Ri+Mh4MNnjAmLvOy3LYtH7P6yu?=
 =?us-ascii?Q?IOEbQlboqAQUbiSNQYtQax6kXvV3vY3YJiEcCsJ4sR0wyBVggIG0Ycy9ngI2?=
 =?us-ascii?Q?05+elBlpVy7VI1YsBLiHIXv/t3xyQa3hVXH1OiFTRFS77Ssd1pGeoFcSsSwt?=
 =?us-ascii?Q?iRsVjGwSXgFkj+QvjxPdE6usC1/kobO9qz89C+Eo4j1QHf4v3ssFeYKcrFD5?=
 =?us-ascii?Q?FInE4tSPxJu8Qg2fAilUzsFMD9BuYNaWKv9qDJB0SOeuBg5i/HHFwhM4Niwg?=
 =?us-ascii?Q?MOJVcEFlDFOCFrEW+T2PgiwPGmc996qD4ijlUjOXlVaReqDXzjAJUV3CLGmS?=
 =?us-ascii?Q?GN+ZQ9ZzzgOBtCK/kD5jdp3rYmTTbSPnOCJlWjsc0iIUMEUs+aWqhMQu6KLg?=
 =?us-ascii?Q?CZo4zdTmb/SvRZz2VXKl0yUO6DJf3xecyDXJjv715lyPe0+Upu8/rKa/3bXd?=
 =?us-ascii?Q?tOP2f4jHeD/yekAvzb4OfJmBTpJBgUoRVnK8d9yqfZS08WbOFX7nNCsKFQFM?=
 =?us-ascii?Q?jHSUYvthN58pEPWRAMB/QzKnwKGmCIqm+ecs1J5qnsadiuhlIBpcPjEIP4Q7?=
 =?us-ascii?Q?bSVJswpxIIj/Qzc8rs0MQC03XIEyrDXJfhVyBZZHXjctZZLKphQIyFEcBVsC?=
 =?us-ascii?Q?105tx8/yWEQrzPfr39tniI40m3BZ/j+HnuXygq76CydRW7gaVdA5ZFrDmjjf?=
 =?us-ascii?Q?YNjomSu3kjXhTdy43DhcbpmBIL2ek+OlQqLLZgVzIPNu/Tebanst+pEvNQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:21:15.8501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb1b7f0-28fa-45ed-1781-08ddbe6dc147
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261

System software can read resctrl event data for a particular resource by
writing the RMID and Event Identifier (EvtID) to the QM_EVTSEL register
and then reading the event data from the QM_CTR register.

In ABMC mode, the event data of a specific counter ID can be read by
setting the following fields in QM_EVTSEL.ExtendedEvtID = 1,
QM_EVTSEL.EvtID = L3CacheABMC (=1) and setting [RMID] to the desired
counter ID. Reading QM_CTR will then return the contents of the specified
counter ID. The E bit will be set if the counter configuration was invalid,
or if an invalid counter ID was set in the QM_EVTSEL[RMID] field.

Introduce resctrl_arch_reset_cntr() and resctrl_arch_cntr_read() to read
event data for a specific counter.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 arch/x86/kernel/cpu/resctrl/monitor.c  | 70 ++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

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
index a230d98e9d73..026c2e2d19d3 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -259,6 +259,76 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
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
+	 * contents of the specified counter. The E bit will be set if the
+	 * counter configuration was invalid, or if an invalid counter ID
+	 * was set in the QM_EVTSEL[RMID] field.
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
+			   enum resctrl_event_id eventid,
+			   u64 *val, void *ignored)
+{
+	u64 msr_val;
+	int ret;
+
+	resctrl_arch_rmid_read_context_check();
+
+	ret = __cntr_id_read(cntr_id, &msr_val);
+	if (ret)
+		return ret;
+
+	*val = mbm_corrected_val(r, d, rmid, eventid, msr_val);
+
+	return 0;
+}
+
 /*
  * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
  * which indicates that RMIDs are configured in legacy mode.
-- 
2.34.1


