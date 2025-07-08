Return-Path: <linux-kernel+bounces-722457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9654EAFDAEF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520C91C25E86
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567E8269823;
	Tue,  8 Jul 2025 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3RaafVN2"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7681A262FED;
	Tue,  8 Jul 2025 22:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013244; cv=fail; b=a6wdWUUAsSFENQ4twC7IHWdQC8V3K91JXMJD+Q3kx+UJzgh78B/Sp5bkLpO5apTuBkAjyT6Nb65WgNwH1FGnTOl8gk0I8b/sNk+ZcXcRr6D1fo+CFBHm37d8402YjKwGyZK9HHgs8xuDGzvLWu4a1nUfu+2LRkjDTj8NexEQYA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013244; c=relaxed/simple;
	bh=ofBjt3OGkCjG0ky4MBniuIEKSLez01fdBfO8AgX4xCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDxk9aI6PxpchTqugk0a/Wix8nZqjG8AP9ZhStnYKOpQHLExxsf+wo3nUCjx1U6JS/r73y2zDazSDH3uHhx2pVXRYNTvBhH5dlqprxMRhpr/0Vj2fLZ8BrZs2D3wmPlOEic7eY5P7F9aWd7JcXCWMktR1AS2eiIdUAkNDoeLbtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3RaafVN2; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4luycXOdksYJU/uXFoTcWlY+IoE0yWtOT4o6KW3MCKZJ07OqWHxCQM8gKaQul6QqiV6lyuSbUpjNtkafNnWwxuK6D6pqwvJGg3rBPvhmMR66K72q7tXSQzVY9RrJcWxPvXknhZSYeSW5F4+E8ZGi88zgSKFcSCVaNpQx3wwycGvOZ2CwXfoh9IiZkxwvu/R9yHV0bu1T9RjT903F+xxsYmQE8XGCkujSjdrfgtLUg44cchjpujSnDK4nEldjxnEPrgDKwpF7vS3mFHGdX0aqQ1HtGWTNhcrupO5K5NQIhTRevQ41kLt1AJmKlcQex3uGxtFboilsl84cNkRf9Y79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRbQxNBZwZ+6HfJ726jLUatupaFILCmCR1/mnSEJkxI=;
 b=cG/zW1YZLEkEkG6Mi3iDEzDLWm6h6Xh0HUqSBFSs8saE66RWw6hN1JVsloFjUgngsLDDJb//BGokoUdLUFCBcDQBZlJu6LHePM8jAfbORaLBjlLUsl13dcLmm8i8IfuruQJZr8VD5scUZXKnM1u9yhfJm6wjc1WV5QH43HTvrMGVAJ/Lmok536P7kKQ/b0mZfU5to5LfalIAdLsx/Vbzcp+XYhjhFAG3+jbEnTAevTLIgqNOybExxafHQV/qRZURkYIi9//qxOqGbAbHuAE9bStL+K++HMdGl2ig2zzcWxoIImF3KJjMF7MaycG2YVoJTuwkZBxkLty59rjc3pzWxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRbQxNBZwZ+6HfJ726jLUatupaFILCmCR1/mnSEJkxI=;
 b=3RaafVN2q2FIevixOuGrJ7FrLTGjRA+yQh67kNsT9pJZ7jm0G5fx9Kg/8yOe8u21B2n+Kfz8BgKtOguRw5nGX/AdKyQUtxO5/NUZZwkBGzrcaBUIg+2oFFUhsj/R2POMW5Jk/jkzS5kvxiQe7vFePxCJnz641g9uJGVbjUo+9w8=
Received: from MW4PR04CA0205.namprd04.prod.outlook.com (2603:10b6:303:86::30)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 22:20:39 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::c0) by MW4PR04CA0205.outlook.office365.com
 (2603:10b6:303:86::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 22:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 22:20:38 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:20:25 -0500
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
Subject: [PATCH v15 17/34] fs/resctrl: Add the functionality to assign MBM events
Date: Tue, 8 Jul 2025 17:17:26 -0500
Message-ID: <70ef9637d73825ee5e7409ab04df1039dec0873c.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a75f4ba-3ea6-42f7-6a16-08ddbe6dab45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UBtCb/cplgGQpW7sxJWFL6+UK/E3CbnCtIk+zXWMtdqo9Yw1WZDR+eosAUJy?=
 =?us-ascii?Q?kcNvLqTdzf7lSKoq+oiLv8schOhueeYUnoNzROo3gugZo/QGyy+q2W6vc41a?=
 =?us-ascii?Q?+GDh1l0h0Ex3GkyCXSkGQl4n+Y/S66yq0ETbPG1wfqYessyUhkXtaIlgpfM1?=
 =?us-ascii?Q?SchNWsyEEFHzFP9ubeiky9Drf/FGE3y+UVxm316cPyH2DeML6bBK13qBpicV?=
 =?us-ascii?Q?H9NqkBYnAACmR396XB4hJkEn5Pj7lGLsaiRmc0HIwwX4shLJ+Lir3WD/El7e?=
 =?us-ascii?Q?w2U3x9KaktO9/vLWRFhpvpHdMA39/kfbQ+7Q3ATbLG1iB5pKCCWxIPFUbfqD?=
 =?us-ascii?Q?FfhIbLwTjiXGqyAKg2ywUjJDHEdARhaSwBMJ5d8Dp96R6+/xrvw2mwr6FO4I?=
 =?us-ascii?Q?lDiSwAmW7a0xA6oCBAqYbq1bw2e52RBbwxIbUo6aFq6OWGE3VaaU3VedAm8n?=
 =?us-ascii?Q?Gfz8o2eSwJKaJoQu9N7uOrbUMY8TMDj3mWzxeTVknLnGz/SMOIQRl9LsYObg?=
 =?us-ascii?Q?HaAHw5vXIU/QS/5VUJWuK8vlqI7xLOfcPkMAiYtbrcNJ6VyKkRhqBhsORpY5?=
 =?us-ascii?Q?U/XpWMxIu/P0h3Eywc2KA3JTfLdq2nikib9Gz5rG5VMimIak1DR4j65RcFw3?=
 =?us-ascii?Q?o+ESpxOVGbwIhESvsVeHaRZ8noL58Xo6fep2Gk0RFCSjUgrj9MwOCYogKY4D?=
 =?us-ascii?Q?sAZ9ZMWOcLBonAQYFBLqbZa/345EcoFztuFgRdNizzcpWOfEzVZ8NRa3aXQG?=
 =?us-ascii?Q?VEyGWy0RJGs3coib9k8ZqS0LFX6d11VkS1NPtIWHSEzo/VcmGLsjwfS+sSic?=
 =?us-ascii?Q?ZUWVcjmpKlbTcxJNX2fdgdeMV79gj5DPFNjy+2KrypTwjf+vc/OUvFiSdcco?=
 =?us-ascii?Q?efvmBNQSQV4lV1XUvjiM1TPFUBftdWShh2qZqu72toWXEft+hbpqG1r5msnI?=
 =?us-ascii?Q?3F9W6mcZNchF0wxyaNnmmavV4y8syoefbpap0VAo4FyOOyPHZbgmjBzVg6Dr?=
 =?us-ascii?Q?eVKc0qlJbP/hMwtvLmtKxoyB4OWk3Ica8jGXfRgXd4wrvsVwjrQ3kKl5zIFq?=
 =?us-ascii?Q?R/cQAo+HjqnZplter8uuEgPZcz5m/VFKMUHMZO++L9pW7p9VPSW9Imz7YSjm?=
 =?us-ascii?Q?KJv19IcjM0AnyUwAsKdRVdTiPJg4JRZx7xgwj8GQGJYlxSbFQ5rcdpETlikF?=
 =?us-ascii?Q?SNvCmeT9cOIvDUGVqL3YEaFThUap/PF/PV/rhws50AR89kd/yO0tZ2hWJNEm?=
 =?us-ascii?Q?9HN+PzCFNZ6ZWS9CsbqLAPRPMg2k+MA5GL7/bQu4QZzKekGv1ihB9jp5d/XB?=
 =?us-ascii?Q?rOoa+or8AQEQrykfXPZ5RHawNMJO3IBLiEZItZQgUvyVE/r6PUIKFc/7Zz9T?=
 =?us-ascii?Q?7+INTiccRG5qmKd1kMaE/0RWQ19Dqhle+IcfIxyA/9TMvV6ka2HhZ4fQn5QL?=
 =?us-ascii?Q?oKv3Y1oh2NCMF8GCpGolgPZDUUHQVJmYX3PSxNTnGCTBOVkEeK1nbYVYRwky?=
 =?us-ascii?Q?FgpEKb5Qoqkhd96BFL787aD00YRLqtMo8aJghYtq+Pvuwx71OsDhIBYXXg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:20:38.9297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a75f4ba-3ea6-42f7-6a16-08ddbe6dab45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258

When supported, "mbm_event" counter assignment mode offers "num_mbm_cntrs"
number of counters that can be assigned to RMID, event pairs and monitor
bandwidth usage as long as it is assigned.

Add the functionality to allocate and assign a counter to an RMID, event
pair in the domain.

If all the counters are in use, kernel will log the error message "Unable
to allocate counter in domain" in /sys/fs/resctrl/info/last_cmd_status
when a new assignment is requested. Exit on the first failure when
assigning counters across all the domains.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
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
 fs/resctrl/monitor.c  | 131 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index ea5c9fa932aa..8879e127a8b8 100644
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
index 11327bd8cf72..bb074773420d 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -952,3 +952,134 @@ void resctrl_mon_resource_exit(void)
 
 	dom_data_exit(r);
 }
+
+/*
+ * resctrl_config_cntr() - Configure the counter ID for the event, RMID pair in
+ * the domain.
+ *
+ * Assign the counter if @assign is true else unassign the counter. Reset the
+ * associated non-architectural state.
+ */
+static void resctrl_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+				enum resctrl_event_id evtid, u32 rmid, u32 closid,
+				u32 cntr_id, bool assign)
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
+ * rdtgroup_alloc_config_cntr() - Allocate a counter ID and configure it for the
+ * event pointed to by @mevt and the resctrl group @rdtgrp within the domain @d.
+ *
+ * Return:
+ * 0 on success, < 0 on failure.
+ */
+static int rdtgroup_alloc_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+				      struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
+{
+	int cntr_id;
+
+	/* No action required if the counter is assigned already. */
+	cntr_id = mbm_cntr_get(r, d, rdtgrp, evtid);
+	if (cntr_id >= 0)
+		return 0;
+
+	cntr_id = mbm_cntr_alloc(r, d, rdtgrp, evtid);
+	if (cntr_id <  0) {
+		rdt_last_cmd_printf("Unable to allocate counter in domain %d\n",
+				    d->hdr.id);
+		return cntr_id;
+	}
+
+	resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid, rdtgrp->closid,
+			    cntr_id, true);
+
+	return 0;
+}
+
+/*
+ * rdtgroup_assign_cntr_event() - Assign a hardware counter for the event in
+ * @mevt to the resctrl group @rdtgrp. Assign counters to all domains if @d is
+ * NULL; otherwise, assign the counter to the specified domain @d.
+ *
+ * If all counters in a domain are already in use, resctrl_alloc_config_cntr()
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
+			ret = rdtgroup_alloc_config_cntr(r, d, rdtgrp, mevt->evtid);
+			if (ret)
+				return ret;
+		}
+	} else {
+		ret = rdtgroup_alloc_config_cntr(r, d, rdtgrp, mevt->evtid);
+	}
+
+	return ret;
+}
-- 
2.34.1


