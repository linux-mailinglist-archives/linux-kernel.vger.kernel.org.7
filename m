Return-Path: <linux-kernel+bounces-770020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023A7B275FC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA75AC078E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA3C2C0F8C;
	Fri, 15 Aug 2025 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GWCjgun6"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BC42C15A4;
	Fri, 15 Aug 2025 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224991; cv=fail; b=NY0E8bUttLA6RxD0/YdO573ynd9Sxy7QjFpiWCkxmyDhCLtlNXh+VGJ+R7K73KI4GzHgdw9bMHXrBWppmrD4o75j/MMcoq3TTc0p4L7HRzAhC9+/nu/LMFBivPEdVSsKfuduwu+w5CalsO0zBPtlJmL/WjhDrhdnsadTqo7/e3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224991; c=relaxed/simple;
	bh=rASOhszmEgQHeuzVQ82BYNbvxCGOwi1OGtfZ+qKVj5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/Ef3Zh0mJLD1NVp6nKvD6elA7QxFdh2zYisTIpREnQ/oFLWxBHAokl6A0CHkhV05hAgCd5pvhxW37zpm6MQ5VUeCr+JULLBJO7riCy/b5NHu45NDmd55gA/tE/BWCSYm5iVWE+gI9gBtDtIHdEVXWxUvaH2HQBvp9Roc2vV7TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GWCjgun6; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LG+KWLt3MIzctz7hL/3QOPWMJnPogRwAamvyNTejRzFr7iTAd7UUu+trrkgVnw24xpKUNxRi8EbaJz2Bd6yjtKKusBDZu5HVUXWl/gAMlTgadj+sDtzFVz+mU15Pydm2cTZFhJ36ETQHzFFQi39DhskOnLk07eEvenS68AJEnZgizlXIzvirJ/1fJy80wl4kQu5LOE9+v35PPsdYek1VG51gUQ3zygHAO4i60wt9zayYVGAFo7y78dhZJ83jDvYsUkW+wAvzeazTJQ2bHsojYqRa7k85ty2Laf0uY/BSGQRhhAITCh36lUi0/jDng3PKGbDjQ3atCQ5jUP7gcU4gnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ErPvZolHwvktLYpDh9Kyf3ueroXEAnS+8K4lWwBiOY=;
 b=ku29XRCzoGS2OendxEt1MOCEDhJ8m/IilYsLp/8PymLKOwnmzb8prxzotztphm14GBw7MgpmEp2ZCRSmEFDm3dGUnx1D7hBX8j1eodOBmQozegDQdI4Ysx8JDhgEZ/d+EZtgLnOdifQRFxG1u3BeIYILh/qFHKNPX0mKDIdv5EBPwL+xyXQOHA+XmDg0hF2PLe/MR5eDZijghzp4J12ot7Kf7aFhDAJ/7yMSsdF+bf99JD42miiPPxI/dYA/R9eTCBtTLEcaY2Ukhe5TqCQ39LuHZLC7TLIQMbQsjOupPJxXEFbZ2OMhWnLiOz61geWvP+nC4I87B1wL/95VO1dVVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ErPvZolHwvktLYpDh9Kyf3ueroXEAnS+8K4lWwBiOY=;
 b=GWCjgun60EEXTfxvaY1GS2TS+UBdMra8KJEPD+qf/WGOQNLfdNAX40QwOEth1MXszgXyHUgx5pyv85UvVSndlc/3yE7epH4Uvz9UEq6qnp8Fc5qMGgbwlcg6PGtyMGdxuk/mCBn8zEMoEsoIEWqz2SsR9p+ZTJ/mD98kLWDLBoE=
Received: from SJ0PR13CA0233.namprd13.prod.outlook.com (2603:10b6:a03:2c1::28)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Fri, 15 Aug
 2025 02:29:43 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::28) by SJ0PR13CA0233.outlook.office365.com
 (2603:10b6:a03:2c1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.7 via Frontend Transport; Fri,
 15 Aug 2025 02:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:29:43 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:29:41 -0500
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
Subject: [PATCH v17 27/33] fs/resctrl: Auto assign counters on mkdir and clean up on group removal
Date: Thu, 14 Aug 2025 21:25:31 -0500
Message-ID: <1ee0f8674f0ab48bdbc3e05c11b7df30d6fa53fe.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af0629f-a551-430a-642e-08dddba3981f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TqQm9QFMj3pmoxTBQ6PpGCJgonrbSEkrqxlSvthWodZr+Xj30nhNe+a9O8NT?=
 =?us-ascii?Q?Texv/Up0VnOCEEmzGaAKHaLFJz7iUkXcaUGsC78HmQdNZp9n1Nbrrv3vAT/B?=
 =?us-ascii?Q?wXei2yJSYemPpe/gT/kDxNjDlT2tWDaF4ML6XER/t0IPK7ljnIYLJDzfdGrY?=
 =?us-ascii?Q?MI0EEcVailDbRbh6gtoNJAEmqvvJV3KMBIiJWDYaEhe2z1eQCb38KJVSMoYd?=
 =?us-ascii?Q?7K7fwm5RZcjPD6UvxFZH36MxCwiWdidBMKFVBFh4WOJR+jnwagFWcuMm+jeC?=
 =?us-ascii?Q?8fTpFonZxIEg3Uz0jExrYzz1xrPux3D2EvPq9uAQpA7hdfAUYCR1Z7GhKMWd?=
 =?us-ascii?Q?Ay9DGorvYyUUqa31udD3a7i7sk+eKM/mMH/KB44Zl88AvyzDExqhMhX6DkI+?=
 =?us-ascii?Q?rAWXHpC7H33kgkhxlbMkWauC+IU/1FsM0+X8u071Yv/YODC3rXwMmQ/SEwwy?=
 =?us-ascii?Q?CmJ2Sf1xdF/cdoRXmF0+KgmBMg39CiwXzFTias5J8raa5LyXyhVlT8jSijU3?=
 =?us-ascii?Q?S2/LSKaokspr9AeDRphtqpj4uX3c/O9iBLg/Md+IZFatwclIP6c0dxRRR7Y9?=
 =?us-ascii?Q?XFmqYg/CA7hfzxQW2UAIg+hVhF0xc1Iz3skcjHcFgSGG+0wb+yJDSEbe8n+f?=
 =?us-ascii?Q?rSyZ82klcRSOEqSoS5oUNQpYpwIe39U86hu4vFEe9tm0ColLCJGBSGbvSxGP?=
 =?us-ascii?Q?Jo+ph2yI/44s1I4d4mfXJMQO39daAN2SbK3wEOV5XYjCXLPrD/lldS2CLfoh?=
 =?us-ascii?Q?jf9XEFPm/Sa2dPh8lpRIA/tmTt6b7ILUdGVDQb59XRN8wH+snoofXPUv5YGq?=
 =?us-ascii?Q?wKwV8YiKgeEEooxWGvRIprqbivpvjjkVUOZUQ57JZxZSMBAleu+sjAD0ayyn?=
 =?us-ascii?Q?5f0jaWj+ciEhtfXifL2ofO+gAO4XGGjACcqWeHX94bq+zySSDt8h4mQ97/pX?=
 =?us-ascii?Q?oniWJAZH2mhBqSdyorRX2vVRMJjpFW2S95PMScjfE3h6rjFk2YWnfeOmtYJG?=
 =?us-ascii?Q?u6sQwJM98LU4OYt/TAuKW10TbKeXhCkge77F1tW7h98Cmt7xX+PhuciHcbG2?=
 =?us-ascii?Q?MtpyqGM5IoLFF6xCrJsmSaHqCR6m8pTvODrAY7reZ8RwnPTu9MgQzkKkXK+F?=
 =?us-ascii?Q?7Re2FY4ohLfYCWGg5DUkXdcSyq1o29YbQZTf4UhR1gZzNdVx3uGtZ3Fke8lv?=
 =?us-ascii?Q?2WIHEvbX5epJdtPREeT6/7aZOuLbN3C2xV6ys4rRsfnO6PiOyJl/SVOuRsuN?=
 =?us-ascii?Q?O8QMqnDUmQBdTh6iFvgbf8KbXgpiNm9tEsGZciOcxp/a/YQYUPQxSHIBdZw7?=
 =?us-ascii?Q?and8eZOUsY5Ut4QO/Rjo6MPbndrrHu74qzUPfc20wtACM8VaGeyFkCEFON70?=
 =?us-ascii?Q?K5bEBbvqzOSnp86N7A7N0FcQ+/xnEXbMCKzkdB0C8m/KAmYU865AGJdiMh9l?=
 =?us-ascii?Q?j6Ar/LoUFWm9iby2gPqgb0oKX72vKR3cQ9XeZMkMYx0k7ndKqQgrUj6cMXiW?=
 =?us-ascii?Q?bfexZTACms7CHIH64rlmWgCsPv8labl1GK4V?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:29:43.3432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af0629f-a551-430a-642e-08dddba3981f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802

Resctrl provides a user-configurable option mbm_assign_on_mkdir that
determines if a counter will automatically be assigned to an RMID, event
pair when its associated monitor group is created via mkdir.

Enable mbm_assign_on_mkdir by default to automatically assign counters to
the two default events (MBM total and MBM local) of a new monitoring group
created via mkdir. This maintains backward compatibility with original
resctrl support for these two events.

Unassign and free counters belonging to a monitoring group when the group
is deleted.

Monitor group creation does not fail if a counter cannot be assigned to one
or both events. There may be limited counters and users have the
flexibility to modify counter assignments at a later time. Log the error
message "Failed to allocate counter for <event> in domain <id>" in
/sys/fs/resctrl/info/last_cmd_status when a new monitoring group is created
but counter assignment failed.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v17: rdtgroup_assign_cntrs() and rdtgroup_unassign_cntrs() have been moved to
     patch 17 and 18 respectively.

v16: Updated the changelog. Thanks to Reinette.
     Moved r->mon.mbm_assign_on_mkdir initialization to resctrl_mon_resource_init().
     Minor code comment update.
     Updated  the Subject line to fs/resctrl:

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
 fs/resctrl/monitor.c  |  4 +++-
 fs/resctrl/rdtgroup.c | 22 ++++++++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index b3b4d3f44295..56b2965d88c5 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1294,7 +1294,8 @@ void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 
-	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r))
+	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r) ||
+	    !r->mon.mbm_assign_on_mkdir)
 		return;
 
 	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
@@ -1510,6 +1511,7 @@ int resctrl_mon_resource_init(void)
 								   (READS_TO_LOCAL_MEM |
 								    READS_TO_LOCAL_S_MEM |
 								    NON_TEMP_WRITE_TO_LOCAL_MEM);
+		r->mon.mbm_assign_on_mkdir = true;
 		resctrl_file_fflags_init("num_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		resctrl_file_fflags_init("available_mbm_cntrs",
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index ced46eb4a959..c6fd3bb45c19 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2715,6 +2715,8 @@ static int rdt_get_tree(struct fs_context *fc)
 		if (ret < 0)
 			goto out_info;
 
+		rdtgroup_assign_cntrs(&rdtgroup_default);
+
 		ret = mkdir_mondata_all(rdtgroup_default.kn,
 					&rdtgroup_default, &kn_mondata);
 		if (ret < 0)
@@ -2753,8 +2755,10 @@ static int rdt_get_tree(struct fs_context *fc)
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
@@ -2900,6 +2904,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
 
 	head = &rdtgrp->mon.crdtgrp_list;
 	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
+		rdtgroup_unassign_cntrs(sentry);
 		free_rmid(sentry->closid, sentry->mon.rmid);
 		list_del(&sentry->mon.crdtgrp_list);
 
@@ -2940,6 +2945,8 @@ static void rmdir_all_sub(void)
 		cpumask_or(&rdtgroup_default.cpu_mask,
 			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
 
+		rdtgroup_unassign_cntrs(rdtgrp);
+
 		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 		kernfs_remove(rdtgrp->kn);
@@ -3024,6 +3031,7 @@ static void resctrl_fs_teardown(void)
 		return;
 
 	rmdir_all_sub();
+	rdtgroup_unassign_cntrs(&rdtgroup_default);
 	mon_put_kn_priv();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
@@ -3504,9 +3512,12 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
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
@@ -3516,8 +3527,10 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 
 static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
 {
-	if (resctrl_arch_mon_capable())
+	if (resctrl_arch_mon_capable()) {
+		rdtgroup_unassign_cntrs(rgrp);
 		free_rmid(rgrp->closid, rgrp->mon.rmid);
+	}
 }
 
 /*
@@ -3793,6 +3806,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	update_closid_rmid(tmpmask, NULL);
 
 	rdtgrp->flags = RDT_DELETED;
+
+	rdtgroup_unassign_cntrs(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 	/*
@@ -3840,6 +3856,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
 	update_closid_rmid(tmpmask, NULL);
 
+	rdtgroup_unassign_cntrs(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 	closid_free(rdtgrp->closid);
 
-- 
2.34.1


