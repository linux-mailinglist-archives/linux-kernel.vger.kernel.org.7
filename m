Return-Path: <linux-kernel+bounces-746192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10051B12417
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3960F3BA80E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3B9254877;
	Fri, 25 Jul 2025 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vaFqA0B3"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A7D253B66;
	Fri, 25 Jul 2025 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468510; cv=fail; b=rrB9D6m1ciuqTZaV42X01g+k15gg8EfFYKp5xkes8gAjx1Ko+AJC9nRIBaM8x3aR/sB0xINaG5LGkz3vfWv3jEOpDWoAPn+pFlGu7HP4aiGNrSZFhaMFJ2Y6y5+2X9wUx8sSze1FTFzEL3YbEQ3LmkJaF3fFiyKgs7Iq3GmmVqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468510; c=relaxed/simple;
	bh=i8qwNf9/OEwOIUPMT2djHtEDt9s83mNADT753UcJwoI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXfLHuEgoesFfbX/SlIv6zK9OPLdnvzp6R/4rXSljnT7KSllzpr9Y5nyo8syty04stZlpGk04rHrH0de62M0GnTwm20ywIOH6V9JAAr8EhUi9C0ZCMNuOemMIVj2NOeGJzMkW6R54vWHQFste9y1PxNog/8/aWM5u/vZFMtNvtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vaFqA0B3; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUjRZUDu5+ZIgASD4SUftPaCcNs9w6qCyfXMMsf9ED3+21xZPkufSyuMqnrIJxZZ9Mi9jTcH11teIUOU+w0vIj2scg894J9+j713hcQhI21gD7YGAJElXup2dBy44Da5wJHXrrVPIPqVvi2MyXlkv5j4KJc+6hXf6ZtBeSKIZ9SSDIvBBtKEYj2PUR9tr/f3KmrTzc6iknAdoihWjInpDMUtuDEow5mOKIcN9vVs0o2e2JTwCyX5qG9f+UiKYLpJhP/CCDP8DrnMWuCbxGMqY4VtcKk/ikdGtZWgIb0xlo3G72jUFGQ7umn14lmikvam9oHHFTCnQN90Yy4zRf31Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYNnqeTq45TYW5l1HN9pTKADPMSEBtmnRa/fUcbebzw=;
 b=Oz5OTWLW/2ZgOpQnW7+/Hqx4RRWjeGcILp63TlFC4REs+dRL1xzLWKZ8qfW6uqNBtVBjaW/QWo8m/2W8O/H2Nw2pzi7S/hO3lNbrV97WKin1P9Rbp3it+lE4M9P4QrxuhtLF3m4Hvcbk6Y+qu6Vm3/mzxAaopthWwu/MKIb2HPlqnxolqlOtzHeVRQhcvRWsay0N25TKz35/9B16+g2ScoSbroiT5NXesDQMR9OwAOacKRT3xt6stghA4hyN8jzINjC4tY6+LGFgXxhUo2xsjsNStJKvSLpZn4PDY4adwEf6npzcmr8Yp89E+j3UWKUyR1fWKUpJRIeI6cdNatizGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYNnqeTq45TYW5l1HN9pTKADPMSEBtmnRa/fUcbebzw=;
 b=vaFqA0B3UplBxMRnEy2EFvki7ffPqRltGVP8kd8mVRbw1PLIEL4+5YlgfWLvtCZW4gcYuUn/au4ve9eUYNg4mYTA42V4jH7eXcWwzyNc2lGionf2JgCPgeHSRT0wLMwXPzAq+qHHjTWAQSvHbypWhuSbt5Wy84OXwfHj5/38NrA=
Received: from CH0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::13)
 by DS5PPF482CFEB7D.namprd12.prod.outlook.com (2603:10b6:f:fc00::64a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Fri, 25 Jul
 2025 18:35:01 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:610:ef:cafe::b) by CH0P220CA0011.outlook.office365.com
 (2603:10b6:610:ef::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.31 via Frontend Transport; Fri,
 25 Jul 2025 18:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:35:01 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:34:58 -0500
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
Subject: [PATCH v16 28/34] fs/resctrl: Auto assign counters on mkdir and clean up on group removal
Date: Fri, 25 Jul 2025 13:29:47 -0500
Message-ID: <df758bfeb3f8a3e975891029b3a0ca90da3744f0.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DS5PPF482CFEB7D:EE_
X-MS-Office365-Filtering-Correlation-Id: 642e8b3c-3c1b-4aed-4a37-08ddcba9f737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/uWKM8k3fGSPuRBhYmBLUNBA2fc1nEGMguRJYP2rNzofO894A8dlyjtEt9RU?=
 =?us-ascii?Q?NBr+ajQk5Giwceqes6TbzB+qJ8qrfLbIvwz2xUe38+LVGsGgUmaXx/FgoXlx?=
 =?us-ascii?Q?eZjBMnbExiZ6nlLKDA66QhqKMBSij/7CBDy3bRTwCGzHWSRgU2Vwfiedh/AM?=
 =?us-ascii?Q?zBRl1zhhf1a1/cD3vcHEyGEyp2jNmCXvoUXha32Jnja1XCtdOMSae/vpqGwL?=
 =?us-ascii?Q?EqFARwuZe0/Tz2KnHCWhbHB5RtRn5fM/IBWb8N4VjHhvqUvx1KdckzfjdBP1?=
 =?us-ascii?Q?xie1KavCwW53fhf7Y8kBXgWwW3K2J9/Nhn7EY6sN2iKhWa5qMCcESvlgl/W2?=
 =?us-ascii?Q?JLACklIHAHpc2zD1kvh3KTENZ2tZsEcBUVQPYcARxbYjDN39nKue2OBVqtUe?=
 =?us-ascii?Q?ix+W3fYKI0eedcTj6iVWHJXbSo/heDlnskT49GKSCHs1WJwi9UeDGw4ACZAE?=
 =?us-ascii?Q?Qe+twH1cdsUPyUmigiZd54TqSV24gTTZVi9tu7WGZ0M7PVTPe/F0Bid0YCA4?=
 =?us-ascii?Q?ba89FcLlhVdF1+wnoV2k/vLHo0Co1i/fxtYoDUt9Ppr6qGNVwysoJnBHICGh?=
 =?us-ascii?Q?WecfRgMS1s4l1ga0RCSE+DSuOiiJogxl8/6CgeMWXWpODJHB6vfK4m3TkFth?=
 =?us-ascii?Q?A/5Nn8FR+pSBAmuOmZxC//Nmp2mwt08n5hAKyYmct4OUweAd7T1jb79EGn5j?=
 =?us-ascii?Q?WgRM3F39Gdsin1KQsAnVPYRgh53NQZmDaQumKjieaTgU5pONscwf+UTAgPaH?=
 =?us-ascii?Q?90bH9jDADpXIHK3kcfF4cejZ+V66wpd0ZNgZXbD9MooAq9nGCiQZRMcGs1ek?=
 =?us-ascii?Q?gVs+osrz+o+KLZgUsT1/3EvbOsGN2pbMvChHDtLiOgWPyqPPycyQeeKjQBpH?=
 =?us-ascii?Q?Ljrc3p3lfOPxEl1DA9xv+tiojgb3GveIlLN4ZNf3wYdycJtLu+ZGIb8Y+Si8?=
 =?us-ascii?Q?6+fVqw5OGFN5tl52xo5dGinwSUzm5FoFQwKUxbu8cnndam8OsPR4j1WhbFy+?=
 =?us-ascii?Q?jBLdCw7IINjD3xlzEzLobnFMU6rMtUaS86LtGYYhRfe8KBHlBF/4csq3BqIe?=
 =?us-ascii?Q?QrHmijbLb3Iw/OJLbs+3p23ttigoY6esjb4Q+CD9kuzJgkqDKjhv4LpY5+8s?=
 =?us-ascii?Q?4fFR+wBZhLnygnOHt6a9Nv2FQjQydMMMapSi5FewtineFUsiH38cXhqK4rkZ?=
 =?us-ascii?Q?gjk6MXXwOq+3B/rx+5BL5O7WIVjEbGP41AJUh8+k9TWAgWdt++OnJMjXNBAM?=
 =?us-ascii?Q?nRqFnSI7PFuZ3e28A3WUE61/px5M439a45Q6TZf2hzBzlD5Yeok09LRKeXXx?=
 =?us-ascii?Q?nKTtwJb1aZg7YHqKUMBxf9gyrT5pAwfDUNeytlcdnwo6N8dnbyl3kaygLG4B?=
 =?us-ascii?Q?crNYIqj5hm7JAgf/KT9eyJSPWXfbz/UXFrrl7ILZj9MJuQNCkNybV0XoHFmX?=
 =?us-ascii?Q?hwHBoE4HeYYgyww7PEgiits8N25lt17IwX36JaKxhlMk+XryY2tYEA3J5wvZ?=
 =?us-ascii?Q?ExuzqLySKNyJ2LqVoO/OcMBatQBpgpbJBYQ5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:35:01.3093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 642e8b3c-3c1b-4aed-4a37-08ddcba9f737
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF482CFEB7D

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
 fs/resctrl/monitor.c  |  1 +
 fs/resctrl/rdtgroup.c | 70 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 6205bbfe08fb..5cf1b79c17f5 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1072,6 +1072,7 @@ int resctrl_mon_resource_init(void)
 		mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = READS_TO_LOCAL_MEM |
 								   READS_TO_LOCAL_S_MEM |
 								   NON_TEMP_WRITE_TO_LOCAL_MEM;
+		r->mon.mbm_assign_on_mkdir = true;
 		resctrl_file_fflags_init("num_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		resctrl_file_fflags_init("available_mbm_cntrs",
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index bf04235d2603..d087ba990cd3 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2792,6 +2792,54 @@ static void schemata_list_destroy(void)
 	}
 }
 
+/*
+ * rdtgroup_assign_cntrs() - Assign counters to MBM events. Called when
+ *			     a new group is created.
+ * If "mbm_event" counter assignment mode is enabled, counters should be
+ * automatically assigned if the "mbm_assign_on_mkdir" is set.
+ * Each group can accommodate two counters per domain: one for the total
+ * event and one for the local event. Assignments may fail due to the limited
+ * number of counters. However, it is not necessary to fail the group creation
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
@@ -2848,6 +2896,8 @@ static int rdt_get_tree(struct fs_context *fc)
 		if (ret < 0)
 			goto out_info;
 
+		rdtgroup_assign_cntrs(&rdtgroup_default);
+
 		ret = mkdir_mondata_all(rdtgroup_default.kn,
 					&rdtgroup_default, &kn_mondata);
 		if (ret < 0)
@@ -2886,8 +2936,10 @@ static int rdt_get_tree(struct fs_context *fc)
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
@@ -3033,6 +3085,7 @@ static void free_all_child_rdtgrp(struct rdtgroup *rdtgrp)
 
 	head = &rdtgrp->mon.crdtgrp_list;
 	list_for_each_entry_safe(sentry, stmp, head, mon.crdtgrp_list) {
+		rdtgroup_unassign_cntrs(sentry);
 		free_rmid(sentry->closid, sentry->mon.rmid);
 		list_del(&sentry->mon.crdtgrp_list);
 
@@ -3073,6 +3126,8 @@ static void rmdir_all_sub(void)
 		cpumask_or(&rdtgroup_default.cpu_mask,
 			   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
 
+		rdtgroup_unassign_cntrs(rdtgrp);
+
 		free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 		kernfs_remove(rdtgrp->kn);
@@ -3157,6 +3212,7 @@ static void resctrl_fs_teardown(void)
 		return;
 
 	rmdir_all_sub();
+	rdtgroup_unassign_cntrs(&rdtgroup_default);
 	mon_put_kn_priv();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
@@ -3637,9 +3693,12 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
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
@@ -3649,8 +3708,10 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 
 static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
 {
-	if (resctrl_arch_mon_capable())
+	if (resctrl_arch_mon_capable()) {
+		rdtgroup_unassign_cntrs(rgrp);
 		free_rmid(rgrp->closid, rgrp->mon.rmid);
+	}
 }
 
 /*
@@ -3926,6 +3987,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	update_closid_rmid(tmpmask, NULL);
 
 	rdtgrp->flags = RDT_DELETED;
+
+	rdtgroup_unassign_cntrs(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 
 	/*
@@ -3973,6 +4037,8 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	cpumask_or(tmpmask, tmpmask, &rdtgrp->cpu_mask);
 	update_closid_rmid(tmpmask, NULL);
 
+	rdtgroup_unassign_cntrs(rdtgrp);
+
 	free_rmid(rdtgrp->closid, rdtgrp->mon.rmid);
 	closid_free(rdtgrp->closid);
 
-- 
2.34.1


