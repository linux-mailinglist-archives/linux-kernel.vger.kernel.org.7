Return-Path: <linux-kernel+bounces-746181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9D0B123F1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555F11C86DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142DF2528F3;
	Fri, 25 Jul 2025 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G+cy104f"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A907483;
	Fri, 25 Jul 2025 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468407; cv=fail; b=e0lr0tZYrcNPzwvzt/dt0ig7hh1cVdzicKqIFAGx5ndf95irnTATWbqjJ89bscDEdS8/tI6tSVBb5JhQb9a4ZSK6UoFbDTPqJ/Wm+JhlTc9yaNiEyp8+E27yxmE9p8CF89k83X7I4LLV508APE1GUyMFo/HFsMdBJYXSCrlJ/XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468407; c=relaxed/simple;
	bh=ogUwuDTBxewhWQcl799F8Xmkp+m8Xuems0vUFEeNIbg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOrxIjr70OCamgI4MchKSzEBfxOGvU9BuIX1MHIjjh62xtxq0RjsCtE9w4SAx5BaxP+fqiJL5jDIxcCgPcKorQSzTb4efIjPovwiLoyzCn9xfUHH5kglKnDQDw42sbbkeUghzCTgSOFWJrcCrkwhQG4k/7r5rFK37RNAfaPjo74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G+cy104f; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/5L3DP/0nJdfI0eiP59rgOf32FkfVN+C7huO5zWuC+UC9GgqPi5z98DBQhQUe76WLxempFq+IVOR2aQSMPOGk6xkq86hdO5jEyu5YAcjyWCOoO0sbjVi/VeTmZaWLrgl4Y3tbU/xbniEugEfRkWhHIxpDiRISlzIoTIklYpQqRP/ZGUR+BeR4n+bjScf4KsXw/v0Cg6LTaUfHN92lgoSArX5LVRCvVhEtWiYCMhKeDu7bXCG3SVEdPEyrwHmBltkBJTJy3fkC3j3eAUM85CBcJVOTRmHUpBN7tBOleCIifngqI7sFIm6o16YCKr6CTP0LkCtNqlC4FCttqewdgM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Da+tXozeTS7zpp1Sp9+KiTi6LLYWZweAqnljNcy1Cno=;
 b=xTqRXoM1xCoBF2xBO78R8bSACwadm/pqPK7qZOjmPNg4oCVeSnFQmr4ajn6Y1skK60QIAnqYpHvDBKwimi0pNZXrmlNhZMpiq41aFK+07idZx9rndrMi1nc5IFPxARZ6C+tKSTNqvolXLrfoAYADfYQ9hh/1yv1JyN1EDf0rMbG/5frMriKbbr4oibXcgO5ZjdFgTsBS8bk8Y9gMqZRjbTeDklcN9e+QyAGgd/3Y790ioR844SMtHjXWOx+crjj7pv4Bc+8yrzqJVrCi5bpbKL3/0TlADho2EexTWsr/asoK68BU4lRuuQyBsX5aOkDJhsUOozRc7pjMFftFTDlWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Da+tXozeTS7zpp1Sp9+KiTi6LLYWZweAqnljNcy1Cno=;
 b=G+cy104fOG5OvfMTc/deod2GriPBU9ysoOkFUqDbuOy1zUPuiP2xrrFGwSLaS5+AvuvFSiX3S3oS+h+dc9Z8Ni9l9ttP1LPb62UMnGlVe6QXkXJ/UO4xiXncoTSfF+amKDinKAzatZZiZcBWBGZk9t2BG16WvEdjXzdqiH4F2z0=
Received: from CYXPR03CA0094.namprd03.prod.outlook.com (2603:10b6:930:d3::16)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 18:33:21 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:d3:cafe::16) by CYXPR03CA0094.outlook.office365.com
 (2603:10b6:930:d3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.24 via Frontend Transport; Fri,
 25 Jul 2025 18:33:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:33:19 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:33:16 -0500
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
Subject: [PATCH v16 18/34] fs/resctrl: Add the functionality to unassign MBM events
Date: Fri, 25 Jul 2025 13:29:37 -0500
Message-ID: <8289b3fcfabe6d820620429646b18660e7cf9ffa.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a49e40-66d5-4ccb-af7f-08ddcba9baaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IcKoeiDtwIB84N9G/Y5Pmkx+t4Otbr0I7F1I4d03r9RnZM8xInHoSFTp14tN?=
 =?us-ascii?Q?1GcT0Xq1/rZ6m851JFXirDn0QhPhQskQSQC+ThkcJYR0UIDkIGPublfiJRIn?=
 =?us-ascii?Q?IJANly0LtGSlswxT8LspGxF1PfAlP7BzYtJFdDYpGerGS6NopeqipPh6UKWs?=
 =?us-ascii?Q?MME78TA0aJnDQGD1TeJ/As93JTGik28K05JmRIdW7UBObfEebQ2Lh7R9Fsuv?=
 =?us-ascii?Q?+2imj9pWstU0T6aShPe1YCBh1zQchNLoZzwJtYJdoiN9krM2iCxyWkbjoaro?=
 =?us-ascii?Q?e+8CZeelwKQ3RDRb6IAmE+FHoKZdk+sZDpQ9GOmi2siV8P0BIu+S3PUyon4P?=
 =?us-ascii?Q?hpwrUYbMZHsIAV517kLVvV3gtS9HkqLawwysrGsTAUOLvrf2J7KeKUqqngxH?=
 =?us-ascii?Q?LkBWjUkrt8Ajsm9QrNndzS58RrgkT4eoYuN+WvDSHvwyEYMNEygqBvvJMGZl?=
 =?us-ascii?Q?dTWv3i6t8SYBIEKwIvvPMCucCRwxpzRrxwYHJ/Gi0Dc9fSsZRF/wzyhZ3m3A?=
 =?us-ascii?Q?jBjhEjpcJilA4MFNoi6xP8tf5UIHROxBXNOzXZDJDLYAXjFoBfQXI1vJyYNQ?=
 =?us-ascii?Q?1ZXa0LG7bt6HEUkHW3BOebs0vtDHvUF2I3pdbdfdpYRy9F/6DTz/MWLI01YJ?=
 =?us-ascii?Q?R+ululG2miswD3WafPwYgx4AnR2jRQyEggHC6GuAzoHqdeHdikQzrDS0KBZw?=
 =?us-ascii?Q?qrnHWr1GF0N6ANdBKwgXVEJ31w5oLcD+DXFq0aruD1/L6v8qxunGVGaRcbIx?=
 =?us-ascii?Q?5/ORS+vsT6jrNVlpoZW0n4xNXAGIms/rO2Ku01LPzJWKqVwelK/TvHhDs8Hk?=
 =?us-ascii?Q?dloQvojjoaMKq8Vz3qiJrYgtkTSFyu6yLA7sA5oyxHy450rEXkELnr5zy6m1?=
 =?us-ascii?Q?W1QFwTkuz0Op64sqmgUhmsoQHRIxkYD3u3GGJ1Vn0YlHhqwB6bFvX5Pm4w0k?=
 =?us-ascii?Q?K35tzjKZL9LnLCB4v6jz+c4gv8+mFKLIuFyOdlRlj3BJTDcqq9gjGS2LWgZW?=
 =?us-ascii?Q?EZFzm4qUZ7m7P0lzFHGGfqI1DsnjMDQICaMRaHD5crS7OtBNf5ABg8NMhp35?=
 =?us-ascii?Q?bh7cmSMwuTeKn3Xp2VhWIwbiIVzef1kVztnIsHWkwmupV0tb7hrGnYz7O2GB?=
 =?us-ascii?Q?tMKri9EfhjTTu0oRHYGW/V1tJFc8KbUUtM3bhhKkDqJVGoAHVQ4t91lKLo/p?=
 =?us-ascii?Q?XHTkIap/tiSfxi+4n9mQxZZmM9vj20PDhwJaZQC5gNfTfFJQg0qFcIyM+t6I?=
 =?us-ascii?Q?akJlgwxQRLMQPKg/Pksup9c/kPIn7VecFKU3pQSbowZriOWTtlUcftJmQin0?=
 =?us-ascii?Q?1SV715dpEzARH7e6ttch7ZXEVF0tJ4O9kGpRSEMqm18CrWzyXI2jNquboiea?=
 =?us-ascii?Q?fCdNNthVb+BYblONi5+f6UtaFz7BFZwGRuRAG5MDiSVskwajnnUTWd3ZiNG1?=
 =?us-ascii?Q?t9pCTPHJkiDCgPFjse3yEK6Yo7ni6J4QjNUBhc7xPNAaEeLZoLaLPo2X4LTK?=
 =?us-ascii?Q?mkKMqAdf2coNvh2nHCLG1TUId8sNvqZ26VmjOU1bExSWt2iV9K/M56U2PA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:33:19.7244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a49e40-66d5-4ccb-af7f-08ddcba9baaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375

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
v16: Function rename rdtgroup_free_config_cntr() -> rdtgroup_free_unassign_cntr().
     Updated rdtgroup_free_unassign_cntr() to pass struct mon_evt to match
     rdtgroup_alloc_assign_cntr() prototype.

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
 fs/resctrl/monitor.c  | 46 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 419423bdabdc..216588842444 100644
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
index 8b0aa2469643..049a82729c0b 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1023,6 +1023,14 @@ static int mbm_cntr_alloc(struct rdt_resource *r, struct rdt_mon_domain *d,
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
  * rdtgroup_alloc_assign_cntr() - Allocate a counter ID and assign it to the event
  * pointed to by @mevt and the resctrl group @rdtgrp within the domain @d.
@@ -1083,3 +1091,41 @@ int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp
 
 	return ret;
 }
+
+/*
+ * rdtgroup_free_unassign_cntr() - Unassign and reset the counter ID configuration
+ * for the event pointed to by @mevt within the domain @d and resctrl group @rdtgrp.
+ */
+static void rdtgroup_free_unassign_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
+					struct rdtgroup *rdtgrp, struct mon_evt *mevt)
+{
+	int cntr_id;
+
+	cntr_id = mbm_cntr_get(r, d, rdtgrp, mevt->evtid);
+
+	/* If there is no cntr_id assigned, nothing to do */
+	if (cntr_id < 0)
+		return;
+
+	rdtgroup_assign_cntr(r, d, mevt->evtid, rdtgrp->mon.rmid, rdtgrp->closid, cntr_id, false);
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
+			rdtgroup_free_unassign_cntr(r, d, rdtgrp, mevt);
+	} else {
+		rdtgroup_free_unassign_cntr(r, d, rdtgrp, mevt);
+	}
+}
-- 
2.34.1


