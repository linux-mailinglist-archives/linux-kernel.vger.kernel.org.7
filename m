Return-Path: <linux-kernel+bounces-722469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D75AFDB08
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991C356198B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D81270553;
	Tue,  8 Jul 2025 22:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tBkSBj0b"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FD226E153;
	Tue,  8 Jul 2025 22:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013345; cv=fail; b=O+Wtl/1QaGjoxtuOVeJyXJ/wEzZwUNn1NomHKeyfPD4NEjs8Y2LS/A8DEu4TVJOrSy9R9ilx2gxyI6nMG9QlPIloScsRruWRM7/2Be7wAaduZqU4kXabeEBCZgV0+mhkTXpXIdgMEdlzakJGx27RK2zlhGD8UVzYfFnOBUo8fQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013345; c=relaxed/simple;
	bh=oFIDW3sgeH3YP7KKVKPAGmSe5aNJJ+EDyVJAMfOSRF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poAOYOjL/ppTDM3IXgPLw7L+fhgN1GebnR/z0spIDIQ43/fcmHap/ixA8IAoVrJiQLvoAx7hX0xl1u3Vh3xHGeAKQyJlrQ4ajuaVhqcjHkCrb605obWQpXXxDdA7ybxiq3WdcIAWG2jhVYqkPsfS7on1bu09Vwwk1cXcP9fdW6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tBkSBj0b; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bavUgmlDW87HY18bQ0ooyTpaacRSGEqfhH29z5mDWF/NiSPI06v8LVUlsP2dUuBCVkXNo7SCvFcJA1mMiISrFw25u0w7AofpBKUP81DMY5Re55+0RQr45960/IZiddCpUBleAQz6RMmIFnBS6ffNzL4Y8HiRErEiJrKUScp+udspxBXUC5IoLUb8AI5IGKnq4hBZFHRfOmF0gLbKTL5bfRWuCXLMphcBzUHvUP+HvhBMYwInTr77HwPOuB/+5t0EDuHjddl2dWlmfHBI6V1mbJsmr+48PZFP3Wy98xeacJo3zmES/APXQc7XjAVScdcge4jDF2i8k6XiturKUOux+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AZRQ55+YNBleXzmqs8haO4qqKUVOK0Q9PB7VGswxuk=;
 b=BJGvitsYqA5C+HeeQLGd1zpXWqhPPuQIvFJgaD7JT/LrHKGLb4S5wc+OFQPHJ0uNixzK391iDyDf/0Ni63e3aq3NjwiNbPIrQrn+ENU78cokXEwqNaqErXhPnnYb++SiiqvFNezf3u/dEZIG3GyOM8Ahd1TvC1BDXGA7auoaMtWPUpP7Q6VlP6cq+e9eHnfME74s/2xVAtbBnwkTokzTPWiJ4KjFZGluGCAXuoJwNSL/z/q3UZYZAEGvRdJfDI2GPccxT1xqXfCfUCHSb1ZarRbGtx4CWb49gF5eeRzs7Nl6ofPhvP7yb6Qqu2mfXCYEq0+StzbY1+oYclSoHAE1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AZRQ55+YNBleXzmqs8haO4qqKUVOK0Q9PB7VGswxuk=;
 b=tBkSBj0bPCoQLI2Z2f0850YhyrqI9+oUUuyRmQty5pE0Wr13Nd0IUPHVW5rOhr/ZCYVIqnhUwf3oRhhulPtYDaJxfWuOg9yHOuxrqzjIPY4tHREDVmJQl7wr33hLMRfeOqA6K1RD26CthU7Iia2nvCBYQUXdsoB6i/lHRrnGEr4=
Received: from BN9PR03CA0208.namprd03.prod.outlook.com (2603:10b6:408:f9::33)
 by LV3PR12MB9118.namprd12.prod.outlook.com (2603:10b6:408:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 22:22:20 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::20) by BN9PR03CA0208.outlook.office365.com
 (2603:10b6:408:f9::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 22:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:22:20 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:22:10 -0500
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
Subject: [PATCH v15 29/34] x86,fs/resctrl: Auto assign counters on mkdir and clean up on group removal
Date: Tue, 8 Jul 2025 17:17:38 -0500
Message-ID: <9c14b9534bb8fb8e7cd1b2e450312061d9c150d3.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|LV3PR12MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: c549f195-999f-481c-e38d-08ddbe6de7c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZwnSsuFa1pxP3HVhOt5hWMJmLU8PS3EYGjg0PoA5d89poqykf2AM8gga+F+X?=
 =?us-ascii?Q?0nBvmDql10aJx5J8L8QNuEPUq2usdCGqR1HeqeZUxhkMDfR5O5yOpxzDYwSk?=
 =?us-ascii?Q?N53FmjdnR9pM/nNFinZbhAAlQjvpT+pbPyR5LGUmDcD+P1QcpLSMJieVqUlu?=
 =?us-ascii?Q?i5rMnqSNO4rn2QpXyVaBNwpiOOGt4Wp1hYaPaomAMnjiKgJeucuUS1FsChZp?=
 =?us-ascii?Q?au84XZe6vqEkTMc8nU4ieIzj2hzUnAWBVcghpMurXBgh3uYYsb0G52+DCzEO?=
 =?us-ascii?Q?fZU8TkhjDjY00CywKFcByYTBfXDQZugqWm+FLDf8dGeSY0mfM8w/rymL3ahx?=
 =?us-ascii?Q?dQAEHtShB2k6LUeY2ELr3WU+ePqw6Jn6nWu2M4UfphefbHfmbH9YCyDeKYCW?=
 =?us-ascii?Q?JRFnNXf8doCzxiuRTReI44DRVt/fQGa7d5HudOfEF4FEUrH33HpMhsG65e02?=
 =?us-ascii?Q?9rBq9S0ujbZmvWCUECnrv3jIUhw9KpwX/Cx50gGjgkH6ZaXe17RuXUnoIcLL?=
 =?us-ascii?Q?p7xVDze058RaA8rzHmj9asjoMx7RwgXwkGNsfDrQ+h0Px24H2eBWCLkMfiAs?=
 =?us-ascii?Q?+U8npeVA3LX75+dQLn28M37vwts/FyPSWbzHewgRzNwZvb2z626fFyJCf+ZC?=
 =?us-ascii?Q?bKYArNCg3wupK1GYXKA1zo/iINg3uJyWG3VoMhLgOmfmFbrsdMBPtZwVePJM?=
 =?us-ascii?Q?r3hSJRc85Juwx+AMht6M+TRqg8XN0Sc+FddQhF/8roxQ+IcYdRugy151eAkE?=
 =?us-ascii?Q?w5iKuBiPfCv6j+fQtlq9HQUQPv2+FpkYekkBHc7FZyJyvvrQ/koJhrLzvzLv?=
 =?us-ascii?Q?3h8W5mhNtxoavhDZSoCJp7nGhnJuaWfAm9Gjk4/+9yMvvnFJgv+LXD/Pa92X?=
 =?us-ascii?Q?3ShBylTorxAux5FWF2aYs20hmRGWdRpyqKf9vWQrT0FtxJ+vT1HAZrIOdbqz?=
 =?us-ascii?Q?BTsLDagDL93I74TlQYqQcPJINeqfYxcymVrCaQyID0N/3upel6W/xo3/FuOm?=
 =?us-ascii?Q?ztQ01jiDTOQcU8BDEhnpEtTi6/ECC3h0/a+zz6OK/BY75i5x71RV9W+tvyo3?=
 =?us-ascii?Q?FnEPGl7kV07vMeRf/UqmYTnlLHQOzIj1aI30krxJ5RgeGsSH8+xdVISkNoiq?=
 =?us-ascii?Q?eGXcHt6Qy21u19xnTb7pxhhdtFwUWxL+dZBsoO2xipxpUrVqoYC4luPk+4Mi?=
 =?us-ascii?Q?SWQZvIuDF1ofqoHUUb8EjrXrXlYVHM+8uDz/0LBB6J7TC2VgWsnAck57Z9h2?=
 =?us-ascii?Q?mO+UfU6YCq7n6vswWPbehLQPwjQeB82jr5Dbrg8BCR7ZmKNvGyH4Ltig7NX6?=
 =?us-ascii?Q?xEhXpKMOVZtQBgIGCoPgjGfRaZ0x4KMohdOF4FU9fssh2FV5QQQhlLaNEtAo?=
 =?us-ascii?Q?P++yzYNUA/ZnxRHuE4eNQ4i1SfcQuXCeCS7vDRw9X2jxJ+AAVHcUXP5yAHq7?=
 =?us-ascii?Q?origKrfVzmWyQZe+z3p4xzmVC6LiChwSln2ODWsGOlNt2CJNXS+i8zZBDhlb?=
 =?us-ascii?Q?dllwNBLboABs6Ye/njwDt1ttqYm+ekCaCTW5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:22:20.5293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c549f195-999f-481c-e38d-08ddbe6de7c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9118

Resctrl provides a user-configurable option mbm_assign_on_mkdir that
determines if a counter will automatically be assigned to an RMID, event
pair when its associated monitor group is created via mkdir.

Enable mbm_assign_on_mkdir by default and automatically assign the counters
when a resctrl group is created.

Counters allocated to a resctrl group should be released when the group is
deleted. Add support to unassign and free counters during the group
teardown.

By default, each group requires two counters: one for the MBM total event
and one for the MBM local event.

If the counters are exhausted, the kernel will log the error message
"Unable to allocate counter in domain" in
/sys/fs/resctrl/info/last_cmd_status when a new group is created and the
counter assignment will fail. However, the creation of a group should not
fail due to assignment failures. Users have the flexibility to modify the
assignments at a later time.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: Updated the subject line.
     Updated changelog to add unassign part.
     Fixed the check in rdtgroup_assign_cntrs() to call assign correctly.
     Renamed resctrl_assign_cntr_event() -> rdtgroup_assign_cntr_event()
             resctrl_unassign_cntr_event() -> rdtgroup_unassign_cntr_event().

v14: Updated the changelog with changed name mbm_event.
     Update code comments with changed name mbm_event.
     Changed the code to reflect Tony's struct mon_evt changes.

v13: Changes due to calling of resctrl_assign_cntr_event() and resctrl_unassign_cntr_event().
     It only takes evtid. evt_cfg is not required anymore.
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The monitor.c/rdtgroup.c files have been split between the FS and ARCH directories.

v12: Removed mbm_cntr_reset() as it is not required while removing the group.
     Update the commit text.
     Added r->mon_capable  check in rdtgroup_assign_cntrs() and rdtgroup_unassign_cntrs.

v11: Moved mbm_cntr_reset() to monitor.c.
     Added code reset non-architectural state in mbm_cntr_reset().
     Added missing rdtgroup_unassign_cntrs() calls on failure path.

v10: Assigned the counter before exposing the event files.
    Moved the call rdtgroup_assign_cntrs() inside mkdir_rdt_prepare_rmid_alloc().
    This is called both CNTR_MON and MON group creation.
    Call mbm_cntr_reset() when unmounted to clear all the assignments.
    Taken care of few other feedback comments.

v9: Changed rdtgroup_assign_cntrs() and rdtgroup_unassign_cntrs() to return void.
    Updated couple of rdtgroup_unassign_cntrs() calls properly.
    Updated function comments.

v8: Renamed rdtgroup_assign_grp to rdtgroup_assign_cntrs.
    Renamed rdtgroup_unassign_grp to rdtgroup_unassign_cntrs.
    Fixed the problem with unassigning the child MON groups of CTRL_MON group.

v7: Reworded the commit message.
    Removed the reference of ABMC with mbm_cntr_assign.
    Renamed the function rdtgroup_assign_cntrs to rdtgroup_assign_grp.

v6: Removed the redundant comments on all the calls of
    rdtgroup_assign_cntrs. Updated the commit message.
    Dropped printing error message on every call of rdtgroup_assign_cntrs.

v5: Removed the code to enable/disable ABMC during the mount.
    That will be another patch.
    Added arch callers to get the arch specific data.
    Renamed fuctions to match the other abmc function.
    Added code comments for assignment failures.

v4: Few name changes based on the upstream discussion.
    Commit message update.

v3: This is a new patch. Patch addresses the upstream comment to enable
    ABMC feature by default if the feature is available.
---
 arch/x86/kernel/cpu/resctrl/monitor.c |  1 +
 fs/resctrl/rdtgroup.c                 | 70 ++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 026c2e2d19d3..e0706083fe0e 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -457,6 +457,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		r->mon.mbm_cntr_assignable = true;
 		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 		r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
+		r->mon.mbm_assign_on_mkdir = true;
 	}
 
 	r->mon_capable = true;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index b7289ce2b3a6..645245f274e9 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2884,6 +2884,54 @@ static void schemata_list_destroy(void)
 	}
 }
 
+/*
+ * rdtgroup_assign_cntrs() - Assign counters to MBM events. Called when
+ *			     a new group is created.
+ * If "mbm_event" counter assignment mode is enabled, counters should be
+ * automatically assigned if the "mbm_assign_on_mkdir" is set.
+ * Each group can accommodate two counters: one for the total event and
+ * one for the local event. Assignments may fail due to the limited number
+ * of counters. However, it is not necessary to fail the group creation
+ * and thus no failure is returned. Users have the option to modify the
+ * counter assignments after the group has been created.
+ */
+static void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
+
+	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r) ||
+	    !r->mon.mbm_assign_on_mkdir)
+		return;
+
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
+		rdtgroup_assign_cntr_event(NULL, rdtgrp,
+					   &mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID]);
+
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
+		rdtgroup_assign_cntr_event(NULL, rdtgrp,
+					   &mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID]);
+}
+
+/*
+ * rdtgroup_unassign_cntrs() - Unassign the counters associated with MBM events.
+ *			       Called when a group is deleted.
+ */
+static void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
+
+	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r))
+		return;
+
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
+		rdtgroup_unassign_cntr_event(NULL, rdtgrp,
+					     &mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID]);
+
+	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
+		rdtgroup_unassign_cntr_event(NULL, rdtgrp,
+					     &mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID]);
+}
+
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
@@ -2940,6 +2988,8 @@ static int rdt_get_tree(struct fs_context *fc)
 		if (ret < 0)
 			goto out_info;
 
+		rdtgroup_assign_cntrs(&rdtgroup_default);
+
 		ret = mkdir_mondata_all(rdtgroup_default.kn,
 					&rdtgroup_default, &kn_mondata);
 		if (ret < 0)
@@ -2978,8 +3028,10 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (resctrl_arch_mon_capable())
 		kernfs_remove(kn_mondata);
 out_mongrp:
-	if (resctrl_arch_mon_capable())
+	if (resctrl_arch_mon_capable()) {
+		rdtgroup_unassign_cntrs(&rdtgroup_default);
 		kernfs_remove(kn_mongrp);
+	}
 out_info:
 	kernfs_remove(kn_info);
 out_closid_exit:
@@ -3125,6 +3177,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
 
 	head = &rdtgrp->mon.crdtgrp_list;
 	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
+		rdtgroup_unassign_cntrs(sentry);
 		free_rmid(sentry->closid, sentry->mon.rmid);
 		list_del(&sentry->mon.crdtgrp_list);
 
@@ -3165,6 +3218,8 @@ static void rmdir_all_sub(void)
 		cpumask_or(&rdtgroup_default.cpu_mask,
 			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
 
+		rdtgroup_unassign_cntrs(rdtgrp);
+
 		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 		kernfs_remove(rdtgrp->kn);
@@ -3249,6 +3304,7 @@ static void resctrl_fs_teardown(void)
 		return;
 
 	rmdir_all_sub();
+	rdtgroup_unassign_cntrs(&rdtgroup_default);
 	mon_put_kn_priv();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
@@ -3729,9 +3785,12 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 	}
 	rdtgrp->mon.rmid = ret;
 
+	rdtgroup_assign_cntrs(rdtgrp);
+
 	ret = mkdir_mondata_all(rdtgrp->kn, rdtgrp, &rdtgrp->mon.mon_data_kn);
 	if (ret) {
 		rdt_last_cmd_puts("kernfs subdir error\n");
+		rdtgroup_unassign_cntrs(rdtgrp);
 		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 		return ret;
 	}
@@ -3741,8 +3800,10 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 
 static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
 {
-	if (resctrl_arch_mon_capable())
+	if (resctrl_arch_mon_capable()) {
+		rdtgroup_unassign_cntrs(rgrp);
 		free_rmid(rgrp->closid, rgrp->mon.rmid);
+	}
 }
 
 /*
@@ -4018,6 +4079,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	update_closid_rmid(tmpmask, NULL);
 
 	rdtgrp->flags = RDT_DELETED;
+
+	rdtgroup_unassign_cntrs(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 	/*
@@ -4065,6 +4129,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
 	update_closid_rmid(tmpmask, NULL);
 
+	rdtgroup_unassign_cntrs(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 	closid_free(rdtgrp->closid);
 
-- 
2.34.1


