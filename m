Return-Path: <linux-kernel+bounces-746180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E57DAB123EE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2491881368
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6170250BF2;
	Fri, 25 Jul 2025 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zqaPcVh7"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D817C2475C3;
	Fri, 25 Jul 2025 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468395; cv=fail; b=EPdg/pRCPDHwcWChpIno6/RmYXOGFL/gomjdTbOKrgz4FJ5nN0eiFv8G41k2HSNNhBE7EfMJta1yy+bm/JXV43EAgZCid6HR3IiQiZahfxxGQdfhRGKdgoqTvjwKJkcpbxw7yinsYp3Ac9ySK559NaiZG0X887942/ClL4Dl5MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468395; c=relaxed/simple;
	bh=HtY0Ooz3ieSXVwGH/4lQ908GlLlrBecYJ7+J34sbM0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAP4jAMcz4FbSeWUFgsKaMEgVtndi6tuF1herieBnhFZvuYbLMuDiClh0H2zQ5c7y1/rk14Q9GfW2WQmxTTSchXBVZRQ3xyNFXHaSQeX17Zes7ax9T8mmgnvwtSE5fqalMW/M6QY7xrXXbz6WBN6dsH2eGAa/l1PAIJUFFDVZHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zqaPcVh7; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6bQXhUVOEN0uSmbp6xClInW+8aJ5hFjfkj5pH2Ws6B9js6YFR85pu3AmaI1tL1YCWyl+upr5PE2nhrP6zcpXdRVgAa1MCiOBZF/b16QEtDcjZXXnBD3HotNXG/d+3BA5HoFaC9QFuBjM1cQQ372ChyyUAcbcbaJZy4HwW1wMWtwfmkGhZxD6sTZth7QinOXzR+oEQzhkYvPQ0LetZxHfzwHV/OE4I/NDPm/8jiBoFPn/eEJNn6nFpT2QZ9gGqo58lbn0yVra5RGhiZwJ65Z3MqdpAtEIXKcGOxyTQxClpEkeuNXGo9Ow3nnMMhKfiv+LdV4i/grwhIUz76TtSScjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EIDifkGJyHYf+AcNLOuaLmQjaVwHC9QCFc4b1T2yW0=;
 b=f575gze6xp86fz8N2YOnIHIo2kGXSzudZrq98VPSKAIbsk1MUWqpyCtM3OrxQuKfYszv17/g2KoyQr1URgRW0CsNasGHSDx0CprqDkHu7WF+qeHQR5QIdWaOh3vhZI3yEnxGNoW84ZRrbvJPg5XHOtc31Hm955OoAfrO70R95eXmzVdoYXrrPPHaRK7wUlvxleN7woMYcr35Ndg45KYwa8IKrgxmsr3alIf0G1psB/UKv+SMIxj5wSFU39dx+oojGEzNxIQF8NrM4q2h13rGsYI/N1TJAMcmIhAAV/3qU/o9Cj478bcCvhZemp/2VXtVIxjKqPWtN49nnrmNkfCXKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EIDifkGJyHYf+AcNLOuaLmQjaVwHC9QCFc4b1T2yW0=;
 b=zqaPcVh7AFmSAeS4OHgU2/aD6mDq+yVJrPxS8XiUiBZVZgrHGrLowl39wh2Q4uHjcsBzZpH2dOyW5o83VnZvNx3Qw5RmG945QhnSX88RnlwkKDbJu3W8c8Mj7nSlAt02xCXzetNX/MCc0m8ORB9rL+3HxoseRhPigCjf/+5eohQ=
Received: from CYXPR03CA0080.namprd03.prod.outlook.com (2603:10b6:930:d3::24)
 by DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Fri, 25 Jul 2025 18:33:09 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:d3:cafe::a8) by CYXPR03CA0080.outlook.office365.com
 (2603:10b6:930:d3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 18:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:33:06 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:33:02 -0500
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
Subject: [PATCH v16 17/34] fs/resctrl: Add the functionality to assign MBM events
Date: Fri, 25 Jul 2025 13:29:36 -0500
Message-ID: <09e6eb24212047908127b8b9fbd1673d6892cad2.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DS7PR12MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: e272add0-84b9-4069-1824-08ddcba9b2cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OmlhZLIfcd7zJCUzc7Xwt+bjGyH47hjn1SYVOmTPz/jSIikvogJGWRiJ+dU8?=
 =?us-ascii?Q?BnVqwYvOYkHWcmYVNHbnts+Zgl6KJRs3Z9kYfPNR1v5hxmpnoVOS87bi44Vk?=
 =?us-ascii?Q?JFc0KFT2zCcWNLCcCFfKQmqwNJqg3DXGGBOCSnVNoQLKmsUQrSrkACaEi5OK?=
 =?us-ascii?Q?NzQlSylNcA6uRmMtCIIFRXilJCtAvwQXmkyuVTernrjBWRSrQJkmzt73LhWF?=
 =?us-ascii?Q?QaQdAzpenemrqBdcAdMN1K3cq12uebYEe9O1muiU0zOd/I8IQIXRuxpvyoyl?=
 =?us-ascii?Q?lW/fpK7yXM+5TEQiLx24vgkhOBHzK65OBfQufhw5VY/a5QbLgh6Xz8kP4Gzm?=
 =?us-ascii?Q?lNMehkrSN8O6gYw2LYmg+ULPn1pdUwdTBKsv2VzdTAWgJdn5pmBEDo5p7BrJ?=
 =?us-ascii?Q?WqwfNGpyVUebhjdI9gorU6HT66Ddktoes4CxeplIJjkrX4kiwQU0CFZkj/vR?=
 =?us-ascii?Q?+/36arLYfZc/s71JiL0ngKV3ALdJI8iCCFFSCSOFaRzDaMhWqFhY9CSuKLZf?=
 =?us-ascii?Q?YII98LMUt9p7Dasb0gfibgPtncmwfaKCPWSVCXt8jNmDHFpNH+W1bA8++Ene?=
 =?us-ascii?Q?Hofw4Gx8skNs1ctVK5TvVHC/eacZbTQWdGxEAHBf35I0EqpD4IWYGm2DHq30?=
 =?us-ascii?Q?cYufR2iVqhUsj+XlGe2YSJ+YFU8T7ohqoPvhggHHrepBHiqS2d0n8hwr1fF1?=
 =?us-ascii?Q?YKzEvTfPrDHRcKvdRg0XrgP/O4YIbCN+stZOQB3o2iaR48/6cB8R/L6sXRv6?=
 =?us-ascii?Q?QaZO5HMlAkDVeqzjIIFZuIBLLW//kQfv2yK/nqkUY1RbhUYXVY8yPxRM5pbQ?=
 =?us-ascii?Q?w53JQgMHMP1fRCs8Hl9mspJ7z9o0/GQqYaza6Mpb2lmaJWMeBMjvmTOJ7p9f?=
 =?us-ascii?Q?WNWxOOovAsLclz58YkYTb1gfhW819Fnvm//y4B4ItPdP4zSmjqt9sCh3M8Bm?=
 =?us-ascii?Q?9f6OtdvMBlpSXzyzFaTlGvk/U29b3N1Qr0rA/V3HpCywjSBll0GmOnsgv4XI?=
 =?us-ascii?Q?+0Y/Kr6MeBV2CbjFbEQtNbs+8p+ZzwML+9aPzdOmZ/SH2ZYyG+8bZ/kM6YTM?=
 =?us-ascii?Q?XzfgP1CF1CqLDrnAoFnuYb1XgFSYh+pyF9wJASnF0c9cd+iiGmorm+Vaxsi6?=
 =?us-ascii?Q?yZRHdepl72+wQ7zlVmN0yb0BkGX/zF3eodmkAkQvakUE9o0rWxwQxeIY7qf5?=
 =?us-ascii?Q?dXGXo/+KqYrrxvAK5BkyvDBIKnfCIyP08Vw9cSuJeHpsZotUX/YbTsIj7Wox?=
 =?us-ascii?Q?tGpxnTtSEark+8kLPQA4kf21xAh954cvQzNtIYLTAUzqjkoAS9Cqtc4e2QET?=
 =?us-ascii?Q?xDj1EymlFTNjKAbCYZR8we4ryG0p937vRMiNtirYiaEKtNerG0AjP3SlVFrf?=
 =?us-ascii?Q?x+K1os4M2++wwwvGWuuwK32vjbQ6oPqNtJB9raNX/0LyeQ2IAEUK7MIUw5lw?=
 =?us-ascii?Q?ClijdcaYdWBy3UBvUKzVmC9XhZFpfT7E+ldUhk/BZkvMcwL4efpnf8tYa9CQ?=
 =?us-ascii?Q?fBe3M51ftNb7C6pMJYzdPi2cGEYsEX77UCQl3R5DPR3UPBYotawXsFb6WQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:33:06.5414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e272add0-84b9-4069-1824-08ddcba9b2cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215

When supported, "mbm_event" counter assignment mode offers "num_mbm_cntrs"
number of counters that can be assigned to RMID, event pairs and monitor
bandwidth usage as long as it is assigned.

Add the functionality to allocate and assign a counter to an RMID, event
pair in the domain.

If all the counters are in use, kernel will log the error message
"Failed to allocate counter for <event> in domain <id>" in
/sys/fs/resctrl/info/last_cmd_status when a new assignment is requested.
Exit on the first failure when assigning counters across all the domains.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v16: Function renames:
     resctrl_config_cntr() -> rdtgroup_assign_cntr()
     rdtgroup_alloc_config_cntr() -> rdtgroup_alloc_assign_cntr()
     Passed struct mevt to rdtgroup_alloc_assign_cntr so it can print event name on failure.
     Minor code comment update.

v15: Updated the changelog.
     Added the check !r->mon.mbm_cntr_assignable in mbm_cntr_get() to return error.
     Removed the check to verify evt_cfg in the domain as it is not required anymore.
     https://lore.kernel.org/lkml/887bad33-7f4a-4b6d-95a7-fdfe0451f42b@intel.com/
     Return success if the counter is already assigned.
     Rename resctrl_assign_cntr_event() -> rdtgroup_assign_cntr_event().
     Removed the parameter struct rdt_resource. It can be obtained from mevt->rid.

v14: Updated the changelog little bit.
     Updated the code documentation for mbm_cntr_alloc() and  mbm_cntr_get().
     Passed struct mon_evt to resctrl_assign_cntr_event() that way to avoid
     back and forth calls to get event details.
     Updated the code documentation about the failure when counters are exhasted.
     Changed subject line to fs/resctrl.

v13: Updated changelog.
     Changed resctrl_arch_config_cntr() to return void instead of int.
     Just passing evtid is to resctrl_alloc_config_cntr() and
     resctrl_assign_cntr_event(). Event configuration value can be easily
     obtained from mon_evt list.
     Introduced new function mbm_get_mon_event() to get event configuration value.
     Added prototype descriptions to mbm_cntr_get() and mbm_cntr_alloc().
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The files monitor.c/rdtgroup.c have been split between FS and ARCH directories.

v12: Fixed typo in the subjest line.
     Replaced several counters with "num_mbm_cntrs" counters.
     Changed the check in resctrl_alloc_config_cntr() to reduce the indentation.
     Fixed the handling error on first failure.
     Added domain id and event id on failure.
     Fixed the return error override.
     Added new parameter event configuration (evt_cfg) to get the event configuration
     from user space.

v11: Patch changed again quite a bit.
     Moved the functions to monitor.c.
     Renamed rdtgroup_assign_cntr_event() to resctrl_assign_cntr_event().
     Refactored the resctrl_assign_cntr_event().
     Added functionality to exit on the first error during assignment.
     Simplified mbm_cntr_free().
     Removed the function mbm_cntr_assigned(). Will be using mbm_cntr_get() to
     figure out if the counter is assigned or not.
     Updated commit message and code comments.

v10: Patch changed completely.
     Counters are managed at the domain based on the discussion.
     https://lore.kernel.org/lkml/CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com/
     Reset non-architectural MBM state.
     Commit message update.

v9: Introduced new function resctrl_config_cntr to assign the counter, update
    the bitmap and reset the architectural state.
    Taken care of error handling(freeing the counter) when assignment fails.
    Moved mbm_cntr_assigned_to_domain here as it used in this patch.
    Minor text changes.

v8: Renamed rdtgroup_assign_cntr() to rdtgroup_assign_cntr_event().
    Added the code to return the error if rdtgroup_assign_cntr_event fails.
    Moved definition of MBM_EVENT_ARRAY_INDEX to resctrl/internal.h.
    Updated typo in the comments.

v7: New patch. Moved all the FS code here.
    Merged rdtgroup_assign_cntr and rdtgroup_alloc_cntr.
    Adde new #define MBM_EVENT_ARRAY_INDEX.
---
 fs/resctrl/internal.h |   3 +
 fs/resctrl/monitor.c  | 130 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index db3a0f12ad77..419423bdabdc 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -387,6 +387,9 @@ bool closid_allocated(unsigned int closid);
 
 int resctrl_find_cleanest_closid(void);
 
+int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
+			       struct mon_evt *mevt);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index a089867262fa..8b0aa2469643 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -953,3 +953,133 @@ void resctrl_mon_resource_exit(void)
 
 	dom_data_exit(r);
 }
+
+/*
+ * rdtgroup_assign_cntr() - Assign/unassign the counter ID for the event, RMID
+ * pair in the domain.
+ *
+ * Assign the counter if @assign is true else unassign the counter. Reset the
+ * associated non-architectural state.
+ */
+static void rdtgroup_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+				 enum resctrl_event_id evtid, u32 rmid, u32 closid,
+				 u32 cntr_id, bool assign)
+{
+	struct mbm_state *m;
+
+	resctrl_arch_config_cntr(r, d, evtid, rmid, closid, cntr_id, assign);
+
+	m = get_mbm_state(d, closid, rmid, evtid);
+	if (m)
+		memset(m, 0, sizeof(*m));
+}
+
+/*
+ * mbm_cntr_get() - Return the counter ID for the matching @evtid and @rdtgrp.
+ *
+ * Return:
+ * Valid counter ID on success, or -ENOENT on failure.
+ */
+static int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
+			struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
+{
+	int cntr_id;
+
+	if (!r->mon.mbm_cntr_assignable)
+		return -ENOENT;
+
+	if (!resctrl_is_mbm_event(evtid))
+		return -ENOENT;
+
+	for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
+		if (d->cntr_cfg[cntr_id].rdtgrp == rdtgrp &&
+		    d->cntr_cfg[cntr_id].evtid == evtid)
+			return cntr_id;
+	}
+
+	return -ENOENT;
+}
+
+/*
+ * mbm_cntr_alloc() - Initialize and return a new counter ID in the domain @d.
+ * Caller must ensure that the specified event is not assigned already.
+ *
+ * Return:
+ * Valid counter ID on success, or -ENOSPC on failure.
+ */
+static int mbm_cntr_alloc(struct rdt_resource *r, struct rdt_mon_domain *d,
+			  struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
+{
+	int cntr_id;
+
+	for (cntr_id = 0; cntr_id < r->mon.num_mbm_cntrs; cntr_id++) {
+		if (!d->cntr_cfg[cntr_id].rdtgrp) {
+			d->cntr_cfg[cntr_id].rdtgrp = rdtgrp;
+			d->cntr_cfg[cntr_id].evtid = evtid;
+			return cntr_id;
+		}
+	}
+
+	return -ENOSPC;
+}
+
+/*
+ * rdtgroup_alloc_assign_cntr() - Allocate a counter ID and assign it to the event
+ * pointed to by @mevt and the resctrl group @rdtgrp within the domain @d.
+ *
+ * Return:
+ * 0 on success, < 0 on failure.
+ */
+static int rdtgroup_alloc_assign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+				      struct rdtgroup *rdtgrp, struct mon_evt *mevt)
+{
+	int cntr_id;
+
+	/* No action required if the counter is assigned already. */
+	cntr_id = mbm_cntr_get(r, d, rdtgrp, mevt->evtid);
+	if (cntr_id >= 0)
+		return 0;
+
+	cntr_id = mbm_cntr_alloc(r, d, rdtgrp, mevt->evtid);
+	if (cntr_id <  0) {
+		rdt_last_cmd_printf("Failed to allocate counter for %s in domain %d\n",
+				    mevt->name, d->hdr.id);
+		return cntr_id;
+	}
+
+	rdtgroup_assign_cntr(r, d, mevt->evtid, rdtgrp->mon.rmid, rdtgrp->closid, cntr_id, true);
+
+	return 0;
+}
+
+/*
+ * rdtgroup_assign_cntr_event() - Assign a hardware counter for the event in
+ * @mevt to the resctrl group @rdtgrp. Assign counters to all domains if @d is
+ * NULL; otherwise, assign the counter to the specified domain @d.
+ *
+ * If all counters in a domain are already in use, rdtgroup_alloc_assign_cntr()
+ * will fail. The assignment process will abort at the first failure encountered
+ * during domain traversal, which may result in the event being only partially
+ * assigned.
+ *
+ * Return:
+ * 0 on success, < 0 on failure.
+ */
+int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
+			       struct mon_evt *mevt)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(mevt->rid);
+	int ret = 0;
+
+	if (!d) {
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			ret = rdtgroup_alloc_assign_cntr(r, d, rdtgrp, mevt);
+			if (ret)
+				return ret;
+		}
+	} else {
+		ret = rdtgroup_alloc_assign_cntr(r, d, rdtgrp, mevt);
+	}
+
+	return ret;
+}
-- 
2.34.1


