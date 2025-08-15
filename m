Return-Path: <linux-kernel+bounces-770016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7BEB275E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0545D6043E2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653912BF014;
	Fri, 15 Aug 2025 02:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W0i4vV4Y"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECCA29B217;
	Fri, 15 Aug 2025 02:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224974; cv=fail; b=cpiZ7YbAO9ZvZFcEvbCBTqy40hU6+dsU9Takvc9SdnCf6WcJ07yAGRcwQKJVQL+IivnXMjBQk4FqJpvY3u0FXOCbH+soq3JJBBf3p38v5GPwHJDncR4oYnABhe2yjcXwgO/NOGl35X58DKMgPJykMmR+qfjLNZR2nozvxyoXAmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224974; c=relaxed/simple;
	bh=CWqus2TZRk47ltBjQQvTbsUBOlL9Wev4Lk9q5zetsIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSbzyQgH4swX5TYqiASBI/Vam7//Dbmi8Y9Duj3ZgrCsxMZ7jtHr+B+9I0ZkDGMsQ8bfhoDBl5OemEtoHub31pU3f6+liQqZMD09edjwfzmENeN7CwmEOHnGWtSZyJfhwfWLEmvOX2nCvTQDNvmgjt186N+8vddJnbLPGNAP1TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W0i4vV4Y; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d3HXoalqJCvdrIGsfO+j2T8s01Q389WKyTE3WEz9vLzW2HfwJIk83/jrm8OX6m0EHG7Jxj7NSbTXEJXMe/+SpzTdY89fkm245pJJ5kNeE90HQ9ZW9L0LnRQPyDcbUd/x5JoM85Hz5WMLdmXWVYEfBXACDJpzYtq2FIU1WRAAy+VluTY5h0jhfigO/NCgIoglc0WjEL4SZpeW6KMAfLBBiHSax+lZHhBj2p/d8uqPUIvJTBDNuAUuhmX5ZDOk4k4CL9HZ6djbjtuGtIQOYbw+H3AOorZDaJNhbkNkPr+jNsxN2MDTVYZVN+VXaABG8APqNWi50tVDcAqmPdq+mYwmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjHSyuQDSp/Kcl+RcgtmwvliQn0AIX8lNHTqUu58CVg=;
 b=ls8H7AtkWsRjBqHoWmEDfWOSMCiar9Av2o7LCBjHDcUwgZ3HrIxCIXCPLHiK8j/1t2mcZKRnNcQZ2266fI1laE5YnHwHxSJB6ilGonlPJpn3Few2wTTZ1tPmapPXd/QGCZqtwHWxDjCcMy5dHM6NmgMHxSLKS3U3Ks60rv/QSiPVF+Q3bWcJX/jx3RLIMmUg/XkK8JAPoD8ZeSWbA2ocPnRq92AnnNyqEIwrCYsDTip9jdwQc09K5+OkHvbG6XXryuLIwO9mJgbi5vze/r+5N7K26cV+mdCy0DyCVJiMM3bHxZ19BwpSkfAA8ANzPMlzSaqGA5I+/SIzQrsZec8VdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjHSyuQDSp/Kcl+RcgtmwvliQn0AIX8lNHTqUu58CVg=;
 b=W0i4vV4Yjx58aTCIwDWKScUDX0wDPznnXP2Ih20RYDxjrXvhlTJ+PLCkR0KvRrt5K0dLLtcV+VOAlKc6zhkoDKHG1dobhjdaLrFkZeJ7a/Wxng3X88I42tJe/2a6toQWWeqI092QhFdZUmHDrq+8Jekib26nmzxmwmDAbPH5W+w=
Received: from SJ0PR13CA0220.namprd13.prod.outlook.com (2603:10b6:a03:2c1::15)
 by BN5PR12MB9487.namprd12.prod.outlook.com (2603:10b6:408:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Fri, 15 Aug
 2025 02:29:27 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::19) by SJ0PR13CA0220.outlook.office365.com
 (2603:10b6:a03:2c1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.6 via Frontend Transport; Fri,
 15 Aug 2025 02:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:29:26 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:29:23 -0500
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
Subject: [PATCH v17 25/33] fs/resctrl: Provide interface to update the event configurations
Date: Thu, 14 Aug 2025 21:25:29 -0500
Message-ID: <4d497589d3bb5389565676512c2116e5cfa6df7c.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|BN5PR12MB9487:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a2abb40-a35e-4e6b-57d0-08dddba38dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/O6+q6zaCIxrb0IrbwIpVN2O/SnEhMY3w+aKwH0Sh0pa17IJBYMSK8IFW3Ey?=
 =?us-ascii?Q?C+sDW4GwK2A6s0t8x1igcCjpkSgzaaRAi8J0+yMGTZAMg0zRyOUnyqkUrQmw?=
 =?us-ascii?Q?7Ae6L1tZjaHVH2ZK0H2QxeeiVF8YWcbGclnKJSStsoVkuVHks9Kjzv5cD4ku?=
 =?us-ascii?Q?m8ybEF2pkn7YsTTUc2C3YMD2rGeiy5ddbg594Bm7lv/xkSerqZS/ETwiIIqk?=
 =?us-ascii?Q?VDJxQidQy6THlQNXFOhN0IGrT1w7xeeC0rKtgQNpPFrE9VrnCYsyas0ur+xL?=
 =?us-ascii?Q?qI+QCa1FR3YfgU/SeJAXpp74sQe0r5cc3vK1O3shzpOGmcf5EHQLBUFBeWFj?=
 =?us-ascii?Q?3lP9JUUoPVKoA7gZwgF/hoxhLnAtTip4v721RatDvQylrvBoDZfccS69e0xX?=
 =?us-ascii?Q?PFLy7DXPSbPhVRqoUTZ43GIKYrgNCsAD5PG/4qwKb3tVXWm17NNFbm1PbaIe?=
 =?us-ascii?Q?27p6n1eLbzga/KfAjxlUiMQ6FWLXMaOaH3lUxgTmxu3IQYAC21yrv1149v5x?=
 =?us-ascii?Q?HJ3yHRagFEb9plc/VU6oVTXuFswoIJc/1L+TX+whQopKNdaeckYCqN3orLMh?=
 =?us-ascii?Q?sv7Bnvk/pnRV0rBMkoYm7iTGPxx7TOFG2xjCkw4j4VhN1C202qqCxKHj4f7p?=
 =?us-ascii?Q?KhAf+ov6oUOaAEWO25BhhcwBn40+VgmrKs5VdEJRthVAnwj7m6YqoC0TDT35?=
 =?us-ascii?Q?UzYrwxr1CYGgdUzNU93Po6a+jAqehyJJsZJIOZbAzfRirB5IFdDSIcn0w4w/?=
 =?us-ascii?Q?SikXnCfKsgP5mrnIbKXga/N22ZazRagT3ic73XB0U6sGVckZ08morcsILETf?=
 =?us-ascii?Q?GigSexonkToETHyGR4vVFgG3qB+f8dLjJSR8uwhKxFYZu08XGF8wQcnBZqj1?=
 =?us-ascii?Q?7u4RiTObhTq84hrHFrf59x+Sqh8hPzQTaL+pIS/Fy9zKqjOleNMc7p9soJhZ?=
 =?us-ascii?Q?JOUADFemmAsoQO7Av7nE7d0hpsCb7zgH7C3SGvZOEVnXmOzNXDdOfUQX2UGm?=
 =?us-ascii?Q?igd876ln8l3qDZRokRSUMTr/1XpgbhAUVg3yXOkRr21+Qk5WqZWSLTesi1pY?=
 =?us-ascii?Q?SGJhO4aB1qAD9742PAsIsv7AVZmIlyn9TjIVv9GQ1aWBLIYwsC2DyahtiFZ1?=
 =?us-ascii?Q?Upr1c6I/VC80zlyJpsYBmfw/R1OtBAtpgOnekJMWgH65JamBZtja0Ngf/ZNy?=
 =?us-ascii?Q?Xdv7d91IsShKTKZEYN7BVkobE4AQd6K+XthfBropIf01scTcUcHigOUBKmYA?=
 =?us-ascii?Q?awy69xZXbuv98R9pDQb8xEoZ1KQhonssiFoiTP7RCMZUD56vavFwkHTKMNCX?=
 =?us-ascii?Q?IBklo6R8lD3ODuiIl3O2O5PjS1OT6COFY9sUYs8LPfSslFv/PLU18/n9QP7N?=
 =?us-ascii?Q?En9xnmz+CUTghpj1kURQcIVHsEjQJL9A/cjCA6Ey3rZfsnPx2/RqgoLcCmHS?=
 =?us-ascii?Q?Y/I1NFJcgcrsBQAo+PgVi7nFyR+OWjJho5WTNS0MR1895xbZw+KjY0upTkWw?=
 =?us-ascii?Q?rpi+fjcIOhVT0ghuZvr2nt+dokCUXJSiYfBC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:29:26.3469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2abb40-a35e-4e6b-57d0-08dddba38dfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9487

When "mbm_event" counter assignment mode is enabled, users can modify
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
v17: Minor changelog update.
     Cleared mbm_state on every assignment update.
     All the code moved monitor.c.

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
 fs/resctrl/internal.h                 |   3 +
 fs/resctrl/monitor.c                  | 119 ++++++++++++++++++++++++++
 fs/resctrl/rdtgroup.c                 |   3 +-
 4 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index ddd95f1472e6..2e840ef26f68 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -343,6 +343,18 @@ with the following files:
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
index 7b1206fff116..5956570d49fc 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -407,6 +407,9 @@ void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp);
 
 int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v);
 
+ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
+			   loff_t off);
+
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 25fec9bf2d61..9201fedd2796 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1029,6 +1029,125 @@ int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v
 	return ret;
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
+	struct mbm_state *m;
+	int cntr_id;
+
+	list_for_each_entry(d, &r->mon_domains, hdr.list) {
+		cntr_id = mbm_cntr_get(r, d, rdtgrp, evtid);
+		if (cntr_id >= 0) {
+			resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
+						 rdtgrp->closid, cntr_id, true);
+			m = get_mbm_state(d, rdtgrp->closid, rdtgrp->mon.rmid, evtid);
+			if (m)
+				memset(m, 0, sizeof(*m));
+		}
+	}
+}
+
+/*
+ * resctrl_update_cntr_allrdtgrp - Update the counter assignments for the event
+ *				   for all the groups.
+ * @mevt	MBM Monitor event.
+ */
+static void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt)
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
 /*
  * rdtgroup_assign_cntr() - Assign/unassign the counter ID for the event, RMID
  * pair in the domain.
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 25a653847f49..8187df7b85d2 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1925,9 +1925,10 @@ static struct rftype res_common_files[] = {
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


