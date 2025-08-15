Return-Path: <linux-kernel+bounces-770021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7BDB275F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA8E188167E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FA92BCF5C;
	Fri, 15 Aug 2025 02:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TOgy7tky"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D362C15A4;
	Fri, 15 Aug 2025 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225000; cv=fail; b=GhthNZq2SpExND4sTmwp9TzAjisrZF/ygg23OsiMjoS9FkqM/jcpLpSQWSvOjPBIs+4b1n8SCjgOG2EeSj3vYAWis4WDhvw2xuD/xxgxb3seeKokB8pK9uYmGv6o8kqDA4gJH2pnq4stWk+eYVUS0AlSmQT4qk+hLfB+omqW/kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225000; c=relaxed/simple;
	bh=xy2AbMlNGiULGVwMXwZg0naqMEcKHNwDEKt8hp1EElc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mx4Le00/K2uHdMZO8LDmmahxokF3xEM7gkbJtRVl5lw1MN6H3RMKCY8Y0i4lxjmFEAEVIyByx2Kdzz03HeJbonwnKRyUNYSMZDGfsSkcfgJWVGLYbZSgWNfQdQXRnMa3vfpi7WPJQW4LDqC32o9Ewwy1J8KMpL6JoMvYxTAUXbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TOgy7tky; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p36I2eoUcpfXq1rkl3620dF2Fy0uTkE4+XKiCNz5foq/cF3SKxOA6K2gxD9SdMbxzrFsJtH6ZnN/QncdRhHZMxPCct4CALb/gUNjf0U/Dy8hlwtlQiw9ogJmC/lE4gqv0sY6zhfQx8KzyKrIdXLTyNTbWFBkv0YK278b34/awBexZh1v1XSsrhMZTFJvKGQ+jJGn9AID0yPY/SY4I7djhrHvE14BHACMWmDWWs2zYDj8D+54ggzzjawNYMj6sg89mUwhQrKhQggj+ShlMn+eunGd+6oGATUuAtzfby0+LehZTYFs/mZoQ6AmzxkorDdUiN9ODrS//rGNS2YkDgbF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wFgENzhddLOlJL5WXwrqHe+DIpfqicUmm9PsGJMpnw=;
 b=Xgsk6Vyjk7SQEPSHLCgV21P/z+tZgb8+DFcBduKuyDPM6A/Xjx46M5OAbMLEZgk4PijGEYOGJmXuG0yJtD7p+QYeHz126ijFqEo+tlEtfhu6XTDVKI+oRR8oEtAXeBBgAmYmwjZZzOPV2lSlQj41gIG76gVnQE6r5bd9hQcLkldxUVRfUDKprfKH+wNUgYZxXUmlrx10EZ61sDsBOpFYNy5iZm5h068jQNeLC7SUUNlXDNhrkmGou+7OFyZAVqDAh4PhzN1VlJORNFtubed37kJKnNvpxmqFfpD5S+GteET9hU3WeIuXzVrAXwqN2TbprP6l8g50p9pJlyBB8JEgLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wFgENzhddLOlJL5WXwrqHe+DIpfqicUmm9PsGJMpnw=;
 b=TOgy7tkyq8uPT1CztxKR5S2oVFRBqCk6okR2YfDY+NfZODvLwIScer6gPFitRaslHOV4JKCmIILnFP0PwZ1IU/oislkzj6fhNf59BNCz7yBLcwOmDMvhaFNpVT7HH8T2IvU9psTZHYBrctkTWFNAxauySZsQyVo9kDIoNiv9MH8=
Received: from MW4PR03CA0352.namprd03.prod.outlook.com (2603:10b6:303:dc::27)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Fri, 15 Aug
 2025 02:29:53 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:303:dc:cafe::bc) by MW4PR03CA0352.outlook.office365.com
 (2603:10b6:303:dc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Fri,
 15 Aug 2025 02:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:29:52 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:29:49 -0500
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
Subject: [PATCH v17 28/33] fs/resctrl: Introduce mbm_L3_assignments to list assignments in a group
Date: Thu, 14 Aug 2025 21:25:32 -0500
Message-ID: <ceb6a32f3d539fb52f5271242a4fa68b1a173279.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f51549-9169-4896-660d-08dddba39dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PCK1E0ODN/EmuGnUbbjuE4TBdbcfcbrzee7fwU+0qdzHGruitt5Tf5L5UxEh?=
 =?us-ascii?Q?Q5pl/bKc8mxynsuVKyyz1VYzyXbDiuZJkOMc9aF0nX6Sb33kGo/e8zce1GTm?=
 =?us-ascii?Q?n5tyoMnvHMquxmA5apevetufYWG0cdoNjw2qaOcXGmgxzMrF0SKN8yaLCYMi?=
 =?us-ascii?Q?2clkwE0ENWtPXhyKlmy5kNDitKH9LR4wnYZvpsTcd39MJN8I38yHnEuMM68R?=
 =?us-ascii?Q?LKg++ajeL3IB5ndyZrSDTOOr+RvEnr2faUn6PLxpMhsri2Qz7zLYbjR1LAjc?=
 =?us-ascii?Q?7MVkV1//KQEdMhUiHZC3O5L8ydVeyAQQ1kB1Fre/3l/R+YZXiztKSzIXC99P?=
 =?us-ascii?Q?NH7vethQ3WK4MVQfWcrcyDEEFnY9INuIABGRg9FHyPb0HDScsJ1sLlTiyC5z?=
 =?us-ascii?Q?QFvxSELZC7JB59qShCcIVyx+dqWgUcyZfkQva+wKYad5sjWqHNvDAdP0ZsLH?=
 =?us-ascii?Q?AZmYQALnQ/jlQ3fz6NGgl3Y7qrQ08BmK2nP+EArAbMIO8iJwRA/cQs9KxUgj?=
 =?us-ascii?Q?oKgESUzJw/gyrFZrwxYZLEZIIgdl/qlGL8DBjCxyBUJMtO1hFxBj3iLc+rUK?=
 =?us-ascii?Q?9iIQo4Ulrhr3dV1lhup9JGJ6pY09fiKzi6nvvbbIro+U+m+GBSK6R3dlSsL5?=
 =?us-ascii?Q?a3X573VCTrhiFTFK3GeLHtKssxc2dnBr7yMEHXrGbLBCvsjNT/xAzs544Geq?=
 =?us-ascii?Q?Yc/Oa6tg7sYLyRZahECiMiJnPwmB22+/RNbnj4EfdLWma4/HhdfSvyMNYzPe?=
 =?us-ascii?Q?ALS1G85jhwJxRaZEkscZqNvGURFgOXhDyQ2M0eq7I70wGMdfiyeqlWeBwFjJ?=
 =?us-ascii?Q?C33bHJg5Ljc+knpffAx6QDnmSzPpTaeKYinE1t5i1ePIXyUWH5ftVDjiAwM6?=
 =?us-ascii?Q?xqNcE0mspEF1Wp8MtdX/tqmFs2a5TQuq/zgaq2DOdsNn29Dn8lMoac0t0h5z?=
 =?us-ascii?Q?98HYQ1lEOmSgAnEJrW2ZW9LkVSatWVvujPXpB3Ek+LEetbyqzeFCb4SIuL/a?=
 =?us-ascii?Q?67rk1S+MkgqjiOb+VmCVymNXkCGGy9hraoqwLzm42T32gwToqNex6p49V3cr?=
 =?us-ascii?Q?PesoujyAkZ3Vf4+JRNG7mhXKqL8I0X2KRBZnI0M7RqxEUfW1CCe2rU3XveMX?=
 =?us-ascii?Q?LjpuaSMJZo3XLnwniVUC/tsCtmSTic7Ax6g265Rrf0gzgMeyRhffrRm/a8YR?=
 =?us-ascii?Q?HrKLhdO4UqCJe3rUi3pdSRiF3bNFdei/ELUhcq3XgnCILlewAUWz2fAspyJl?=
 =?us-ascii?Q?xuU3MN97TP6QfpHs+2aLbr0G6F2fuEJD6QOj5lmybBC7IpzhoWg17iKkxUOO?=
 =?us-ascii?Q?sWkrqU26A9ifDqHjN7yz7/JxNHI6YsbwogECk9s7w0NR6pBq7Fj0VpPqQu2W?=
 =?us-ascii?Q?wSHrMrN1ngHYqOTXupz1/J9JvqgsMpqpz+hrYsANglztYUFQraMBdQekgwge?=
 =?us-ascii?Q?hnXUO2eYJ/UqEoK6XiXLvNq2zFWFW3oOsRsOTi2b1G5H2YdrF3bUFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:29:52.7793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f51549-9169-4896-660d-08dddba39dbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120

Introduce the mbm_L3_assignments resctrl file associated with CTRL_MON and
MON resource groups to display the counter assignment states of the
resource group when "mbm_event" counter assignment mode is enabled.

Display the list in the following format:
<Event>:<Domain id>=<Assignment state>;<Domain id>=<Assignment state>

Event: A valid MBM event listed in
       /sys/fs/resctrl/info/L3_MON/event_configs directory.

Domain ID: A valid domain ID.

The assignment state can be one of the following:

_ : No counter assigned.

e : Counter assigned exclusively.

Example:
To list the assignment states for the default group
$ cd /sys/fs/resctrl
$ cat /sys/fs/resctrl/mbm_L3_assignments
mbm_total_bytes:0=e;1=e
mbm_local_bytes:0=e;1=e

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v17: Moved mbm_L3_assignments_show() to fs/resctrl/monitor.c.
     mbm_cntr_get() can stay static.
     Minor change in changelog for imperative mode.
     Fixed the return error for consistancy.

v16: Fixed minor merge conflicts with code displacement.
     Changed the check with mbm_cntr_get() to "< 0" from " >=".

v15: Updated the changelog with Reinette's text.
     Updated the event format list to list multiple domains.
     Changed the goto out_assing to out_unlock.
     Updated to use new loop for_each_mon_event() instead of hardcoding.

v14: Added missed rdtgroup_kn_lock_live on failure case.
     Updated the user doc resctrl.rst to clarify counter assignments.
     Updated the changelog.

v13: Changelog update.
     Few changes in mbm_L3_assignments_show() after moving the event config to evt_list.
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The rdtgroup.c/monitor.c files have been split between the FS and ARCH directories.

v12: New patch:
     Assignment interface moved inside the group based the discussion
     https://lore.kernel.org/lkml/CALPaoCiii0vXOF06mfV=kVLBzhfNo0SFqt4kQGwGSGVUqvr2Dg@mail.gmail.com/#t
---
 Documentation/filesystems/resctrl.rst | 28 +++++++++++++++
 fs/resctrl/internal.h                 |  2 ++
 fs/resctrl/monitor.c                  | 49 +++++++++++++++++++++++++++
 fs/resctrl/rdtgroup.c                 |  6 ++++
 4 files changed, 85 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 1de815b3a07b..af0c38206bab 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -519,6 +519,34 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
 	/sys/fs/resctrl/info/L3_MON/mon_features changes the input
 	event.
 
+"mbm_L3_assignments":
+	Exists when "mbm_event" counter assignment mode is supported and lists the
+	counter assignment states of the group.
+
+	The assignment list is displayed in the following format:
+
+	<Event>:<Domain ID>=<Assignment state>;<Domain ID>=<Assignment state>
+
+	Event: A valid MBM event in the
+	       /sys/fs/resctrl/info/L3_MON/event_configs directory.
+
+	Domain ID: A valid domain ID.
+
+	Assignment states:
+
+	_ : No counter assigned.
+
+	e : Counter assigned exclusively.
+
+	Example:
+	To display the counter assignment states for the default group.
+	::
+
+	 # cd /sys/fs/resctrl
+	 # cat /sys/fs/resctrl/mbm_L3_assignments
+	   mbm_total_bytes:0=e;1=e
+	   mbm_local_bytes:0=e;1=e
+
 Resource allocation rules
 -------------------------
 
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 9be1e53a73d3..88079ca0d57a 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -416,6 +416,8 @@ int resctrl_mbm_assign_on_mkdir_show(struct kernfs_open_file *of,
 ssize_t resctrl_mbm_assign_on_mkdir_write(struct kernfs_open_file *of, char *buf,
 					  size_t nbytes, loff_t off);
 
+int mbm_L3_assignments_show(struct kernfs_open_file *of, struct seq_file *s, void *v);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 56b2965d88c5..76967a49b4e8 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1461,6 +1461,54 @@ int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+int mbm_L3_assignments_show(struct kernfs_open_file *of, struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
+	struct rdt_mon_domain *d;
+	struct rdtgroup *rdtgrp;
+	struct mon_evt *mevt;
+	int ret = 0;
+	bool sep;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	rdt_last_cmd_clear();
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	for_each_mon_event(mevt) {
+		if (mevt->rid != r->rid || !mevt->enabled || !resctrl_is_mbm_event(mevt->evtid))
+			continue;
+
+		sep = false;
+		seq_printf(s, "%s:", mevt->name);
+		list_for_each_entry(d, &r->mon_domains, hdr.list) {
+			if (sep)
+				seq_putc(s, ';');
+
+			if (mbm_cntr_get(r, d, rdtgrp, mevt->evtid) < 0)
+				seq_printf(s, "%d=_", d->hdr.id);
+			else
+				seq_printf(s, "%d=e", d->hdr.id);
+
+			sep = true;
+		}
+		seq_putc(s, '\n');
+	}
+
+out_unlock:
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret;
+}
+
 /**
  * resctrl_mon_resource_init() - Initialise global monitoring structures.
  *
@@ -1519,6 +1567,7 @@ int resctrl_mon_resource_init(void)
 		resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
 		resctrl_file_fflags_init("mbm_assign_on_mkdir", RFTYPE_MON_INFO |
 					 RFTYPE_RES_CACHE);
+		resctrl_file_fflags_init("mbm_L3_assignments", RFTYPE_MON_BASE);
 	}
 
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index c6fd3bb45c19..9d3a58c76fe2 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1937,6 +1937,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= event_filter_show,
 		.write		= event_filter_write,
 	},
+	{
+		.name		= "mbm_L3_assignments",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= mbm_L3_assignments_show,
+	},
 	{
 		.name		= "mbm_assign_mode",
 		.mode		= 0444,
-- 
2.34.1


