Return-Path: <linux-kernel+bounces-722458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E37AFDAF0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DAD21C27C05
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C800626B2A9;
	Tue,  8 Jul 2025 22:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4HEKU0te"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F1C266EEF;
	Tue,  8 Jul 2025 22:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013244; cv=fail; b=VnJyBqByeb04tifOzEzbeKnaxkqgJOGBfTAIqIfj24ef/b4pN9JgI443dwBtzGodG8SqXFO/Rm3bnplIBctfXTCIuG27AP6Vaonz00GE8EbOdQQ9PC+FPe+RL+X1EXb4t+iY0qp3Wc2oV15jhLUxJupT3cD+njybBwFvSDHWB24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013244; c=relaxed/simple;
	bh=17cYtucM/gJ6meqcJJjrwBR1o1gKdZMKGiVkF6HeSQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5yfdwG/1xkKULz3A7rLilMo6FBYa8jREEUNriFJW1ytKPXCc/w4Bxv4MXxfKfZGLc8c4CkwOI1wmexdoBXwB0Do0YRBjMjudnKzINf05Q6kCQmkVVIAYZRINqu3u+LRymT4IqbM/OvjE4X314exjHoolCswkmLzd7aPYptsB6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4HEKU0te; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yN8uX4ncslCxor7ajBK25PItn0gLcdZZFXcR+OrSEF0S8DFYPRv9NLzO5o9l581SPH6Bvs9/uDywYBXWMuN+WaqOD3bypxV0INtdlPu/TOVX304tYBwqa8+eWZoM+4xRGQF/jW0+eKD9CQn65MyEPPieucN0KCgtoQUxZTSqjcd7uSiDQAlwGRTrDTIpffbr1HWxUBfquqJe5ok+V1Nr97oHBU1ePniI76VgO8LC0Ys7qGOIOaPGQPeR92SFy29TWAbtSOYhmwyd93r6ZvyhbR1d4mJev8Se0CMF35Fj/JkmnvxlHqMa2B/PByQD2RDZyWHQGlCXri2VHLG1RAqhug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ax6wGXcohChFMCpS/NomPces22f/DcBLAH4062U69Y=;
 b=HKLYayXS3i8AEQzb3pHg/WQC7vzRpH9skDPesrkAhZzilAY69mTwdtO2VE67NuvD6KcMOdt/Kl1LhdlbbMC5Z0h3ubyjzQdBZC+QqFygRaKn2ObO5t/qn0niqJkA8amJzA8TPk9v1viDiR63uqdCbJFOWsSLzeBckTa+4iD5klKoCW1xAo28dP/2xbK/Q3kBBpAgfQIzBt5ZBAKFJEERgq3d52hcp5rfHFf8/d8VOKbKo0u3xx1sjLOZdHrbnFWBQjH4y+lrn8bGIKqmIjpldCQdrH99nffXYOPWdsWEeqP+tALJoWHVlzDCg88kwBeZ2jGNdQHOQowKZUL6q1AhcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ax6wGXcohChFMCpS/NomPces22f/DcBLAH4062U69Y=;
 b=4HEKU0teabQNQJnnln4MGEXlCENqR4MsB9QRaPMNVOSPJQVwkrlj/Xmhjgj5xmeBIZv105VSCD/JWGZZJ548xbvZPQI1KOzemK/HV5Jm5QCDd5bEQ7E6tvA8IZ7fjrqgNLDyZ1pLu3DdXZPSIyfrBxZbcm8oM240U0Mh+6zbS90=
Received: from BYAPR07CA0066.namprd07.prod.outlook.com (2603:10b6:a03:60::43)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 22:20:40 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::4) by BYAPR07CA0066.outlook.office365.com
 (2603:10b6:a03:60::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 22:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:20:40 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:20:34 -0500
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
Subject: [PATCH v15 18/34] fs/resctrl: Add the functionality to unassign MBM events
Date: Tue, 8 Jul 2025 17:17:27 -0500
Message-ID: <ef1e3ce931bbbf5ebbf4d3e745c0e260117375e5.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e3157e-5aed-485e-67d4-08ddbe6dac46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VlxeVmEAtVP5YKtK3ong8/+Rk0eFRELZ2r+NS9brpC7yz1w6WzJbYXolLrU3?=
 =?us-ascii?Q?XyuNPAlfT3P7rize6VvTDABERfsBd7cfnKf64vjndgQdd+Q+YO6VLmVMQXYZ?=
 =?us-ascii?Q?sqqZUPJQKnHBjgFhzsZmeP3zI85pJ4BQsba+Ofd/NTz1NmfgcJHZM/szffxJ?=
 =?us-ascii?Q?pwSjBFJhxn5jm4n0ZO0MaL1wddRMzEPtTfnGEldSR5Ef6FeMRKSGQRuuu5pF?=
 =?us-ascii?Q?dvAVDIQ57XjTIbjx4NH/+jJj66hKMnmCPp/Xm/EVPcnfTJ0j5UrO9Q1JYPq7?=
 =?us-ascii?Q?5UGwHelqqQ5tCeA90nCb1TZloVd/jlnQ3Lm5MxzcGVGncqbg/BH2+sgMrIMG?=
 =?us-ascii?Q?d59tqSVgoTsMxSiMeq+ScucfzqBKY01VkzSlwVZXdHLcn23CMOM1hioj0k1q?=
 =?us-ascii?Q?m8D+krhMCYaYTJ6aOgeAqCZcihYTEbsYP5qQywLJsblAEq36fr84AhNVnlbv?=
 =?us-ascii?Q?Q+sZrbhjHbVlT/ubS1TchyQpA3WH1NysFq1s//ZAp8FWN0BUshHUlj8Qm1Ci?=
 =?us-ascii?Q?bNnJm/d2QJR4+oe0po+Bthl8/PBOxURaHHdvWWq88wvHacTAd8mfXvEIGwkW?=
 =?us-ascii?Q?MU/BUhr8SdKqBIJ/6rG8+0NkdhpyX0ew1UN50mrHhd8WVhn7H4mz6MqSHrit?=
 =?us-ascii?Q?F0rxPB03sykTse6VJi9g9qHnvvCCneSFLy4VuOS1Q1tziBC6EFmOp7eCCtOh?=
 =?us-ascii?Q?hTKL+ZevLQbLOpWfohj5Ld48mO9PujgPPkWyxVIC67Uy0GknQSsIVPj4a8RU?=
 =?us-ascii?Q?a4aA0QSMPSq4dV+X0NkIZKPtdkeRWn3UvMafZqTL76my+XpZsU991TNlqhdt?=
 =?us-ascii?Q?abPbLS0mbprtF28D8CT1KUv2nVxpx/rURONOUboStRXRQMeb7UMoYqt6mjfU?=
 =?us-ascii?Q?i3BSB04fisWsv5z/q+eXzAYaEahwXjNEuBJbZGYTyzoBF5ROH22kDFT0j+h2?=
 =?us-ascii?Q?AVoO551R6LXp1kHEm4AFEB/cXBXyEs1hruXMnz/0uVFqgobtnLQDJtLNotEt?=
 =?us-ascii?Q?SKT99Nf4gvJgORY+Xy+1xUt/xLpNG8bczIexhC+zNx8BwLal3IdNvhNKCW+w?=
 =?us-ascii?Q?Aw+Qn6PQ72pmqHc2joKKa6b/EiMH86U9JAXImwTb5QFwR9Zr3lXvWQUmEOcW?=
 =?us-ascii?Q?bpBfoe7XEwQarne4pLyZTjwCfKQKKhc+7s/XJYmQJbkOkECFVrZU4xe/rOJL?=
 =?us-ascii?Q?tI95dIOdGOBRXUBx49u2IBUvKgNE9BpsAEuUkPCPRQZqbH5Fx74Ko8DSmLVs?=
 =?us-ascii?Q?BQLHuOINPnxtHCHNoCScRdL138q7FElDVQbJjT0DIo3scvQi8lWL2li8DOz5?=
 =?us-ascii?Q?jF34Y5WZsxYEyzlEklz/0e1beKrZlUNlvj8kiRZx2xS5jHConX/WowU/se41?=
 =?us-ascii?Q?bfydPUISU0cVZ1QLkpQRrKhn4kHDZPNTji+6BZ+nawks2shrwTrWyeH82PUh?=
 =?us-ascii?Q?bWJBOBV8VAEy7VTHsFIuqQIn93N76FRIVDMVgEw7EJGEgc50vavqmhHiL7Wd?=
 =?us-ascii?Q?JQJ7Mcu3YQjpZFt4Ydo++giyIAFzq9SVdy+FVPJ8c5/TWLsd62Yy2rHOew?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:20:40.6141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e3157e-5aed-485e-67d4-08ddbe6dac46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461

The "mbm_event" counter assignment mode offers "num_mbm_cntrs" number of
counters that can be assigned to RMID, event pairs and monitor bandwidth
usage as long as it is assigned. If all the counters are in use, the
kernel logs the error message "Unable to allocate counter in domain" in
/sys/fs/resctrl/info/last_cmd_status when a new assignment is requested.

To make space for a new assignment, users must unassign an already
assigned counter and retry the assignment again.

Add the functionality to unassign and free the counters in the domain.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: Updated the changelog.
     Changed code in mbm_cntr_free to use the sizeof(*d->cntr_cfg)).
     Removed unnecessary return in resctrl_free_config_cntr().
     Rename resctrl_unassign_cntr_event() -> rdtgroup_unassign_cntr_event().
     Removed the parameter struct rdt_resource. It can be obtained from mevt->rid.

v14: Passing the struct mon_evt to resctrl_free_config_cntr() and removed
     the need for mbm_get_mon_event() call.
     Corrected the code documentation for mbm_cntr_free().
     Changed resctrl_free_config_cntr() and resctrl_unassign_cntr_event()
     to return void.
     Changed subject line to fs/resctrl.
     Updated the changelog.

v13: Moved mbm_cntr_free() to this patch as it is used in here first.
     Not required to pass evt_cfg to resctrl_unassign_cntr_event(). It is
     available via mbm_get_mon_event().
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The monitor.c file has now been split between the FS and ARCH directories.

v12: Updated the commit text to make bit more clear.
     Replaced several counters with "num_mbm_cntrs" counters.
     Fixed typo in the subjest line.
     Fixed the handling error on first failure.
     Added domain id and event id on failure.
     Added new parameter event configuration (evt_cfg) to provide the event from
     user space.

v11: Moved the functions to monitor.c.
     Renamed rdtgroup_unassign_cntr_event() to resctrl_unassign_cntr_event().
     Refactored the resctrl_unassign_cntr_event().
     Updated commit message and code comments.

v10: Patch changed again.
     Counters are managed at the domain based on the discussion.
     https://lore.kernel.org/lkml/CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com/
     commit message update.

v9: Changes related to addition of new function resctrl_config_cntr().
    The removed rdtgroup_mbm_cntr_is_assigned() as it was introduced
    already.
    Text changes to take care comments.

v8: Renamed rdtgroup_mbm_cntr_is_assigned to mbm_cntr_assigned_to_domain
    Added return error handling in resctrl_arch_config_cntr().

v7: Merged rdtgroup_unassign_cntr and rdtgroup_free_cntr functions.
    Renamed rdtgroup_mbm_cntr_test() to rdtgroup_mbm_cntr_is_assigned().
    Reworded the commit log little bit.

v6: Removed mbm_cntr_free from this patch.
    Added counter test in all the domains and free if it is not assigned to
    any domains.

v5: Few name changes to match cntr_id.
    Changed the function names to rdtgroup_unassign_cntr
    More comments on commit log.

v4: Added domain specific unassign feature.
    Few name changes.

v3: Removed the static from the prototype of rdtgroup_unassign_abmc.
    The function is not called directly from user anymore. These
    changes are related to global assignment interface.

v2: No changes.
---
 fs/resctrl/internal.h |  2 ++
 fs/resctrl/monitor.c  | 47 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 8879e127a8b8..647a0466ffa0 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -389,6 +389,8 @@ int resctrl_find_cleanest_closid(void);
 
 int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 			       struct mon_evt *mevt);
+void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
+				  struct mon_evt *mevt);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index bb074773420d..6c0410cf0195 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1022,6 +1022,14 @@ static int mbm_cntr_alloc(struct rdt_resource *r, struct rdt_mon_domain *d,
 	return -ENOSPC;
 }
 
+/*
+ * mbm_cntr_free() - Clear the counter ID configuration details in the domain @d.
+ */
+static void mbm_cntr_free(struct rdt_mon_domain *d, int cntr_id)
+{
+	memset(&d->cntr_cfg[cntr_id], 0, sizeof(*d->cntr_cfg));
+}
+
 /*
  * rdtgroup_alloc_config_cntr() - Allocate a counter ID and configure it for the
  * event pointed to by @mevt and the resctrl group @rdtgrp within the domain @d.
@@ -1083,3 +1091,42 @@ int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp
 
 	return ret;
 }
+
+/*
+ * rdtgroup_free_config_cntr() - Unassign and reset the counter ID configuration
+ * for the event pointed to by @mevt within the domain @d and resctrl group @rdtgrp.
+ */
+static void rdtgroup_free_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+				      struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
+{
+	int cntr_id;
+
+	cntr_id = mbm_cntr_get(r, d, rdtgrp, evtid);
+
+	/* If there is no cntr_id assigned, nothing to do */
+	if (cntr_id < 0)
+		return;
+
+	resctrl_config_cntr(r, d, evtid, rdtgrp->mon.rmid, rdtgrp->closid,
+			    cntr_id, false);
+
+	mbm_cntr_free(d, cntr_id);
+}
+
+/*
+ * rdtgroup_unassign_cntr_event() - Unassign a hardware counter associated with
+ * the event structure @mevt from the domain @d and the group @rdtgrp. Unassign
+ * the counters from all the domains if @d is NULL else unassign from @d.
+ */
+void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
+				  struct mon_evt *mevt)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(mevt->rid);
+
+	if (!d) {
+		list_for_each_entry(d, &r->mon_domains, hdr.list)
+			rdtgroup_free_config_cntr(r, d, rdtgrp, mevt->evtid);
+	} else {
+		rdtgroup_free_config_cntr(r, d, rdtgrp, mevt->evtid);
+	}
+}
-- 
2.34.1


