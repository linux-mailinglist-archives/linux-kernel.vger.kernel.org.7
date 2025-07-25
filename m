Return-Path: <linux-kernel+bounces-746190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA1AB12409
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109B2AE3BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364B42550A4;
	Fri, 25 Jul 2025 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YMsaHyll"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8976255F2F;
	Fri, 25 Jul 2025 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468489; cv=fail; b=TpdifdPTqlRheuX2Mk4iBScLa0WH7boUC5wyQW8Q2Z1R/G1lD16q4EyAjBLkNFvwKe3Ds2UDSwTYQmx1TF8IGJPAt/aGP++Ta63YwWJca7hxNRZ8rl/bKTwmyi7v55P7cikOghwwbe0kG/Lj0IWst4x2SxjAlERpCQKVrj4z6Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468489; c=relaxed/simple;
	bh=27tMKmK2t7rrxKQNLqDUqTI7fh6qj5ufwqrN7t9Dr4c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQZT+be1MEGWiM9IF4oOlt6dL3/DnuNz009+JINjCjCg+jp3Ys4fnCcS69eJc70m+MNYMVszRdZDAep00ToPSI6ZwsKrFG8eCHfJEBWED6GSVp3H1JDytf0EN8QasspWd2gZTpUuuBLMGYLvSm0mURXo7JPpIG6VP1CVEnmHa90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YMsaHyll; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jj2ykW0lgHd7nYa4pw04M3lJgwwSczvaBGX1fhVu+71uE1luP6WXFCo74Rlgj/tJ+y+btLVLueXAxg0Aj4K5UgDVtpcOm+XNs5iJLgi+jgVol/vXZUJK+qaqPFZRsdlza23MDcGd4CDI61x4g2PEa74DS3vIipS6N+8wMtnKo3jQY8iKy+EZLaUPm3Ks0jiVoww85TXWOW9LQi4crRUqdqZ3mjGBf9pgCEUku1xWDCi+fAfzdmlQj2qvqoyeYdraqCFtH5qZoCnalZQFCQVFgEU23KHvupnUlQOVJI7UioNcWy/LuxuW8t6EBGZ7d416zyvIczraL98XaGt88rBMkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fqcyS5KUHM1y4r1j4/bvXyp/+sBfji8dITO0CSjC5A=;
 b=IAKEZvrvXaBnKn/QUvwJ3iF48JhZ5fz5TmyQOsQkPh/nf2z1ALwKfh0ZCbo0PtUYc/maCrb8t3h1XrcuBFbH+UCMUnLQ1KGO0hH6MWFTOnydOsjVlxGkbZQ+IFE/DZH1g8G/rmVEzWsoiyutDM9lYEdbMPnQxLn4GKLFsAOLGeSv+DXc+Osk6IDJDSLViqYLqgzLdj3YTPe4JluSIpYPnxH6yMdxNi/l48rrKD6W7qoubHMx4ycgxvtJSFqrnxCVd/xQADqtwa+0vtB2PZhEEIxUsn7v3dl0hkRxYr83uxWnDPO5Zd6gRGaaGbpkg/oCjXXfWHQGfKyVejZG0MWDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fqcyS5KUHM1y4r1j4/bvXyp/+sBfji8dITO0CSjC5A=;
 b=YMsaHyllEfdstq3rJXIcTtrOQxRfcAELIHtVcW4HWHfB4yiGDl2UNv4DP/lLW6crdzwzr0kOn6lL9ZC5dJulfXT4YR5w4O9rfjF6HqEldIxVKSR8j93SGcQUbKVdGji0WlJGu6NiWxLdq6UebRHaRva3cwsm0BJwRvV9XYxE0Tk=
Received: from CY5PR19CA0026.namprd19.prod.outlook.com (2603:10b6:930:15::30)
 by DS4PR12MB9561.namprd12.prod.outlook.com (2603:10b6:8:282::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 18:34:44 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::14) by CY5PR19CA0026.outlook.office365.com
 (2603:10b6:930:15::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.23 via Frontend Transport; Fri,
 25 Jul 2025 18:34:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:34:43 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:34:41 -0500
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
Subject: [PATCH v16 26/34] fs/resctrl: Provide interface to update the event configurations
Date: Fri, 25 Jul 2025 13:29:45 -0500
Message-ID: <15ecac1be290452ff119f67f640c26b8203a4c01.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DS4PR12MB9561:EE_
X-MS-Office365-Filtering-Correlation-Id: e05b94ed-eea6-4244-eaeb-08ddcba9ecc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H3K3bSKckDtTYVrnd3sTyKADG0T4ckJFtizwLjfw2e1DrAAEwqxEML2oYYD6?=
 =?us-ascii?Q?NCiKz8zH2C+sV8a3jSzg5z6ENKAzSOEdjPridBNXvJ6noZ6x8GhiD5sr235h?=
 =?us-ascii?Q?uoItbFfhC6BUwcYWnBWqKHqdAJuRt6tIQOi25bh+cU9pPIPcRO5XBNGJ5f/9?=
 =?us-ascii?Q?jVRWBRsiNhpYrKl2DmRcWFTJqTpfWVxAbe0otnHneU5gcdSikyljsupqm7zs?=
 =?us-ascii?Q?XDSqT6+wEPU/DTu6/j+DnOuXca4T0KX9MuJtn3EegR9tsIJhw5eI+OxDKw7j?=
 =?us-ascii?Q?Pa6W2+cOekj2oxHuZqymkPs/k6PU6bz+hWS5XUuyDMUBbLHWPgi84x/gq6OX?=
 =?us-ascii?Q?S47G6btgJKXUQ1ZP2YrqfQZZaUZX4A4taXL6DTrRrccPV+xTgMdEh6gf707Q?=
 =?us-ascii?Q?AD3fX0q6zbV/QiYV1Su9KNw1RECxMbgQKDTCE1K4jDCejImAvg0toglmJSFo?=
 =?us-ascii?Q?UlWGyX7zhUqerIqYsx15HpP13JNg73UC+P7nYSarc3jNblnoq+wbd2k5Be/i?=
 =?us-ascii?Q?+LWkq5+wdrzp/n98zbk+uzd7g6DaJ05jcdcS3qT/qVNs0QIM90VWgw9N7qS/?=
 =?us-ascii?Q?zsw0lzz4d0W5Y+ls3BS5OKubnaBRCaoYlsrP4qI93VTOeuBXGue0TkUXeFxn?=
 =?us-ascii?Q?wbdj1ch//M9yI5p/xAvz9h7YoXODfL3x+8rdnuxC+K7sg5lJ9Kq1RFHmbCF4?=
 =?us-ascii?Q?hac9cHab+cSacXsrRTiActgQlbiFyrFRjsNNSe1ivcP+qk4u2D6e22zYr1O+?=
 =?us-ascii?Q?bwuapxkQBWln+zpxKhQjcWAOLEpjrb+fTlaWPCjXaitp/g2tvd36KEqbYJfP?=
 =?us-ascii?Q?4v6Rfg4cJF4eGxVA93XtAj3/CPnWfUtDG5feSpsBq4HK0eJ2mrixkdQTzNHl?=
 =?us-ascii?Q?IVjyItvu0+WAjUhrSeApf902ZO0LXu4GwzfJQ9GEOCquLN6ATZD2U4X9TZSS?=
 =?us-ascii?Q?Cgi9L1sSkS4flHPjfenasVWJG/Dh3MFJGWxH8gOiTY/qSn+UH+O10Xp+f1yT?=
 =?us-ascii?Q?gg8sq2y663LyhzcSdsRr/9CcM8hRr1760e8y22wY8QzTjWKp9VE1xwPyKZVT?=
 =?us-ascii?Q?Xd7phikO587sHBdjFy8N+xGS9oNOiap+sulP9q6O5W5j0KrbfvN/hFXIrIm1?=
 =?us-ascii?Q?Z5/lMVDpxv2j2rekKoA3thGqe5hEgv41Q52bJ0oXWVmlbVPxqLYOjYRrFHC2?=
 =?us-ascii?Q?wDABB8WSJYlsyUWqueJJH1o90NXEpVZg3IId9IcNgiz79tK+Y7FjU2G7tU0F?=
 =?us-ascii?Q?YD0ZEsYENv9vKGc1fevZIWX7Rh+P3GIUQh2u3jXA0wPZCYtKqQ2fHAIuTEPY?=
 =?us-ascii?Q?FYB8PkGNF1VgQKorgXyUL6wf+KrMkYrfG2zKjjrdhro/vVvQJwHGOGEzkq5u?=
 =?us-ascii?Q?0xCufjlmDsfzbelTCDNKYAdIzHkElZo5XKYYERkmQ/0KPDc+6ZbnNOdNUIHL?=
 =?us-ascii?Q?jq4zuC5EGu8T9AxHa280Rh8PgQ86+RiSbfMk+g0tgUZt30rvyP7DiMNKpKoQ?=
 =?us-ascii?Q?CC3b84gW5tHskOnGDtYEv25631zL1cd+mHxS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:34:43.7902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e05b94ed-eea6-4244-eaeb-08ddcba9ecc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9561

When "mbm_event" counter assignment mode is supported, users can modify
the event configuration by writing to the 'event_filter' resctrl file.
The event configurations for mbm_event mode are located in
/sys/fs/resctrl/info/L3_MON/event_configs/.

Update the assignments of all CTRL_MON and MON resource groups when the
event configuration is modified.

Example:
$ mount -t resctrl resctrl /sys/fs/resctrl

$ cd /sys/fs/resctrl/

$ cat info/L3_MON/event_configs/mbm_local_bytes/event_filter
  local_reads,local_non_temporal_writes,local_reads_slow_memory

$ echo "local_reads,local_non_temporal_writes" >
  info/L3_MON/event_configs/mbm_total_bytes/event_filter

$ cat info/L3_MON/event_configs/mbm_total_bytes/event_filter
  local_reads,local_non_temporal_writes

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v16: Moved resctrl_process_configs() and event_filter_write()
     to fs/resctrl/monitor.c.
     Renamed resctrl_process_configs() -> resctrl_parse_mem_transactions().
     Few minor code commnet update.

v15: Updated changelog.
     Updated spacing in resctrl.rst.
     Corrected the name counter_configs -> event_configs.
     Changed the name rdtgroup_assign_cntr() > rdtgroup_update_cntr_event().
     Removed the code to check d->cntr_cfg[cntr_id].evt_cfg.
     Fixed the partial initialization of val in resctrl_process_configs().
     Passed mon_evt where applicable. The struct rdt_resource can be obtained from mon_evt::rid.

v14: Passed struct mon_evt where applicable instead of just the event type.
     Fixed few text corrections about memory trasaction type.
     Renamed few functions resctrl_group_assign() -> rdtgroup_assign_cntr()
     resctrl_update_assign() -> resctrl_assign_cntr_allrdtgrp()
     Removed few extra bases.

v13: Updated changelog for imperative mode.
     Added function description in the prototype.
     Updated the user doc resctrl.rst to address few feedback.
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The rdtgroup.c/monitor.c file has now been split between the FS and ARCH directories.

v12: New patch to modify event configurations.
---
 Documentation/filesystems/resctrl.rst |  12 +++
 fs/resctrl/internal.h                 |   4 +
 fs/resctrl/monitor.c                  | 114 ++++++++++++++++++++++++++
 fs/resctrl/rdtgroup.c                 |   3 +-
 4 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 3dfc177f9792..37dbad4d50f7 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -342,6 +342,18 @@ with the following files:
 	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
 	  local_reads,local_non_temporal_writes,local_reads_slow_memory
 
+	Modify the event configuration by writing to the "event_filter" file within
+	the "event_configs" directory. The read/write "event_filter" file contains the
+	configuration of the event that reflects which memory transactions are counted by it.
+
+	For example::
+
+	  # echo "local_reads, local_non_temporal_writes" >
+	    /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
+
+	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
+	   local_reads,local_non_temporal_writes
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index e082d8718199..e2e3fc0c5fab 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -409,11 +409,15 @@ void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdt
 				  struct mon_evt *mevt);
 int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
 		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
+void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt);
 
 void *rdt_kn_parent_priv(struct kernfs_node *kn);
 
 int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v);
 
+ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
+			   loff_t off);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index fa5f63126682..8efbeb910f77 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -952,6 +952,77 @@ int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v
 	return 0;
 }
 
+static int resctrl_parse_mem_transactions(char *tok, u32 *val)
+{
+	u32 temp_val = 0;
+	char *evt_str;
+	bool found;
+	int i;
+
+next_config:
+	if (!tok || tok[0] == '\0') {
+		*val = temp_val;
+		return 0;
+	}
+
+	/* Start processing the strings for each memory transaction type */
+	evt_str = strim(strsep(&tok, ","));
+	found = false;
+	for (i = 0; i < NUM_MBM_TRANSACTIONS; i++) {
+		if (!strcmp(mbm_transactions[i].name, evt_str)) {
+			temp_val |= mbm_transactions[i].val;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		rdt_last_cmd_printf("Invalid memory transaction type %s\n", evt_str);
+		return -EINVAL;
+	}
+
+	goto next_config;
+}
+
+ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
+			   loff_t off)
+{
+	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r;
+	u32 evt_cfg = 0;
+	int ret = 0;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] = '\0';
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	r = resctrl_arch_get_resource(mevt->rid);
+	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	ret = resctrl_parse_mem_transactions(buf, &evt_cfg);
+	if (!ret && mevt->evt_cfg != evt_cfg) {
+		mevt->evt_cfg = evt_cfg;
+		resctrl_update_cntr_allrdtgrp(mevt);
+	}
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 /**
  * resctrl_mon_resource_init() - Initialise global monitoring structures.
  *
@@ -1193,3 +1264,46 @@ void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdt
 		rdtgroup_free_unassign_cntr(r, d, rdtgrp, mevt);
 	}
 }
+
+/*
+ * rdtgroup_update_cntr_event - Update the counter assignments for the event
+ *				in a group.
+ * @r:		Resource to which update needs to be done.
+ * @rdtgrp:	Resctrl group.
+ * @evtid:	MBM monitor event.
+ */
+static void rdtgroup_update_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
+				       enum resctrl_event_id evtid)
+{
+	struct rdt_mon_domain *d;
+	int cntr_id;
+
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
+		cntr_id = mbm_cntr_get(r, d, rdtgrp, evtid);
+		if (cntr_id >= 0)
+			resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
+						 rdtgrp->closid, cntr_id, true);
+	}
+}
+
+/*
+ * resctrl_update_cntr_allrdtgrp - Update the counter assignments for the event
+ *				   for all the groups.
+ * @mevt	MBM Monitor event.
+ */
+void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt)
+{
+	struct rdt_resource *r = resctrl_arch_get_resource(mevt->rid);
+	struct rdtgroup *prgrp, *crgrp;
+
+	/*
+	 * Find all the groups where the event is assigned and update the
+	 * configuration of existing assignments.
+	 */
+	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
+		rdtgroup_update_cntr_event(r, prgrp, mevt->evtid);
+
+		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
+			rdtgroup_update_cntr_event(r, crgrp, mevt->evtid);
+	}
+}
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 11fc8e362ead..c3d6540c3280 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2021,9 +2021,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "event_filter",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= event_filter_show,
+		.write		= event_filter_write,
 	},
 	{
 		.name		= "mbm_assign_mode",
-- 
2.34.1


