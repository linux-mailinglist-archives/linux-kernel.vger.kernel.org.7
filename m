Return-Path: <linux-kernel+bounces-746193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EE6B1241B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB2D4E07BE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D3824DD12;
	Fri, 25 Jul 2025 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Go3mDAM6"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513A4248F70;
	Fri, 25 Jul 2025 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468524; cv=fail; b=X99H3kRYv/Uk8yqyMtvZ0dDrVhCsI11W5rsvdBlooIQHuCVkU6Y+aS2gbgMdUoRYlOOhXvzn7l5TEiRbJwzG+qE1iUZNvsrTChWwZ/DUPNO7L2dzKRkUO1+qYMyNZAfkkTUg5Qxy0VROUyy0moKI5l87RY//o6hfpsqCVXMWqM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468524; c=relaxed/simple;
	bh=4Pc6eqc/kAOQlp4gg11Fwspb0KcGNBlzFgtKuFW2H8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LoSrODmlWZGiCv4gE/p7zrPVF5IacxOjohWj7W7p3RveBk7K7vHVV19FRpPP5O65k3lRGnEni+ziYXka0d1+amXOPPe/eHcRnBv8nl0YdB2M/aTLNzwJ5JYdPbzAXhXcDm7DyYIrk4yLOmeDtrUAtTA623z1J5/Q5DUhDT9qZ7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Go3mDAM6; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSX5un2ngP+63LIo8ju2aQJcTHjVPieEMUDa2iKYyLS7rq8gYxezn0OtffdjwcitvIWx4GYgktLvGMkz/pppnqN4MUNPZoUIZxycnGVVgbZaz+6X33Ti+1bDeTbQCgyYFoXMKdY+Jj1cG/Uvv5DHKC8H13u5/QJi8+F1rtZ/xQjYJwVQbBcrlMJCnAABqF5Wpw2fR+uhk1wowwB5Exb1EW8dmwtxfpBSz3uObzI8Tbga1VVhGkBJBesRTWL69ZlXU+gYjEZhV398FgYGaLIwSCRepUlpOmcrJTPNE+1UZ4WWU9b2q4RHu4JGYadMt7YIgM47yd0vBQI6GSbX/BZp3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9gtk/ndO42c0i2799BKWsy/EMqg6x3BBWGUruB3VD4=;
 b=I6WmmJRkM4l5PvErXhADwp52Q5UK/p2Mt9S30oeFKjRDlDLdzZ4supSWsL5vYAB/f9oHIosvNoVUD0XXrLnCZfeZhdfrC99wJfBVLn6IElwwgrP6Z4YGuyr3fPn2rnCrLb72wAE5ojC8UwwTY9GLTiRDE3a4Ytdv/SQdbFLNs0ur2YQcsQ06Wrcz4WVRwcgxoeDKxy9h9bFXj0fG8Cmryvn/aGCC8C/APATuv65SeTYLaShfiw0KJRJFi3pZyP4NuTGTt2C1OEhgzkQ/lc8pAz2/hnKosebScJZE68geElISwGMx7QD4AxksZ+YyEJ/1sSExYvK2y6oZaOfuy0/dyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9gtk/ndO42c0i2799BKWsy/EMqg6x3BBWGUruB3VD4=;
 b=Go3mDAM6z6mhf9HVPGcm3TIq1pkLfDIbPvON0kISwtpkLtbOPQYyOFq5+ETlf4C9chOZ/FNKprYQhp4f4kG/iDFp7aDyJnazrp/jnRdfdv4jNMbNgTGO+dOgfFGEtu6ovQCrhFcQCuhYUVD31GI9GSq2cyHHC+yn5dNDBJu/BPo=
Received: from CH2PR14CA0026.namprd14.prod.outlook.com (2603:10b6:610:60::36)
 by LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.27; Fri, 25 Jul
 2025 18:35:15 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::56) by CH2PR14CA0026.outlook.office365.com
 (2603:10b6:610:60::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.24 via Frontend Transport; Fri,
 25 Jul 2025 18:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:35:14 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:35:12 -0500
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
Subject: [PATCH v16 29/34] fs/resctrl: Introduce mbm_L3_assignments to list assignments in a group
Date: Fri, 25 Jul 2025 13:29:48 -0500
Message-ID: <1a031e141affd6dfb8693de5a0bda83f3cf4a330.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b45f4e4-306e-4563-9023-08ddcba9ff4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hndIPmdrOZNV2vv2XRm3EuMz0W+9Sg1YeygBPtxP/51CW/PXFH7MGQLZoT4i?=
 =?us-ascii?Q?YKn/fgtIFsXkk6AhC7RakFe76/hox7j6i2ZiAZ+yJcXfYRN7BWBhqjcHfnHo?=
 =?us-ascii?Q?Jkm8zET2QokPxvjNA6PiXvHQ1nHywPMSyp3lrvnpaZON3xFaxAKQ/oT3w8tr?=
 =?us-ascii?Q?Gmat62vf2jFdARiushDAK+W4O5Hi90mg+4GV+yHs5LQKyAipMCgDMpE2igTv?=
 =?us-ascii?Q?GSXMn4pZygWk3TugRJyfls61z7J/JpHTBYA3KFjHqeAmDu1Y9U+Tw9Sj90uw?=
 =?us-ascii?Q?MDOU/UwHVlhaYmhCaeqkEq41wjb0/GzA0ybA14463GPfhOFJDJI0T7fPOZKC?=
 =?us-ascii?Q?XOzYs8A5uHxTcIdwXpbFWueGbtGxdPoe5jP74N84bg1WmoG0sSwXvLILwYgE?=
 =?us-ascii?Q?p9IfdwKaG8PnI6+QDGu9PNfFscqOzQo0ducZWxeKfBbDz9EZcxyqSDsDYzzX?=
 =?us-ascii?Q?xBwMaDJKkH9uWtp7I/xwrwgOD9mCyHfDDrQQUTNjKp+FZs0IvyVqQmQBNJoF?=
 =?us-ascii?Q?laERH6/nm//ny8ip5rwYaHqVxa2Lhud5hJBIbzuKNiwgIq2bFbpWbXVp2cYS?=
 =?us-ascii?Q?bxZuJn8LQvhH5lWgE+HNHcERdPOEYlfKQIJ1gw9W3aMXrH1R+aQqj51d+4eW?=
 =?us-ascii?Q?ocPrkGJvR905OQTYpLRRedwKr8tsyzxE/mrxYxyJefZ0cLMxG8CgUqd79Iss?=
 =?us-ascii?Q?r7TOD6ZOIFQNGtaVSHDR9g0B+RnLKH3JLCEq/q1/PPo2EmcJAiIPwNt7Wn8H?=
 =?us-ascii?Q?EiDaFHlenUfEG3B2hbXrG3Bsf5pbQoC8ZKaQazzXn/M3tVQlwJCROYh4Et7L?=
 =?us-ascii?Q?ZpiqHHlnOkxv4sNDh3ixDLl3kejV6ej7nJYbMNaReKWRlwtNMzaBZ019SzOe?=
 =?us-ascii?Q?eiLapWsLImKzg13L++B6+2UCj/kvqQcLewTLOaY5BQ9+5VhglGKE454K8d7b?=
 =?us-ascii?Q?89GME82JTLYbeNFiQrBNchvEXQZGUzDhttuYHl/miyr1nygoklcsdwWGUWww?=
 =?us-ascii?Q?u7hut2esAlWFNZ/vVprdLYAtrqSkOujvWLgVGqlngap7qpBl05mqhc9G93YP?=
 =?us-ascii?Q?izjw1+rwYS/eyAi1w6pCyE4bvykkwYUqR+CGPqu4TvdvwqOoICPSwNEbQXQs?=
 =?us-ascii?Q?BR/2R2RSfSEUl6iCUI4EcwQ46KBsYu70e5AA8kpDU8aWndlYzxgqk/JMZdX8?=
 =?us-ascii?Q?gNfMM99DlP3hkja4JlmbcRjga3ApyHZH6Z0JQi+Uv7BdbYf1fWSUEbeF/2ze?=
 =?us-ascii?Q?1CGz9vGWP5N8we4b2xF7KndSStwYAcK6w5jMomEMU4vdHjnCxYSiPNqO7GuH?=
 =?us-ascii?Q?q8kVaefrS9y4wgyXUFbHkY+J2Mg/zg6spwmP45z4Daro2Wr0ihiiHSee5AV9?=
 =?us-ascii?Q?Pq/pV/jK0vkBfPy745kjcOi9h9PhO5JzYfnq5BUjsQhG1Uqq+6VNAYsuWeV2?=
 =?us-ascii?Q?/C2UeqTrJrXefRFwXWk6WS0w5+hw35BTRRMuod0HEwEKWmT1KI7tfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:35:14.9062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b45f4e4-306e-4563-9023-08ddcba9ff4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213

Introduce the mbm_L3_assignments resctrl file associated with CTRL_MON and
MON resource groups to display the counter assignment states of the
resource group when "mbm_event" counter assignment mode is enabled.

The list is displayed in the following format:
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
 Documentation/filesystems/resctrl.rst | 28 ++++++++++++++
 fs/resctrl/monitor.c                  |  1 +
 fs/resctrl/rdtgroup.c                 | 54 +++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 165e0d315af7..0b8ce942f112 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -514,6 +514,34 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
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
 
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 5cf1b79c17f5..ebc049105949 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1080,6 +1080,7 @@ int resctrl_mon_resource_init(void)
 		resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
 		resctrl_file_fflags_init("mbm_assign_on_mkdir", RFTYPE_MON_INFO |
 					 RFTYPE_RES_CACHE);
+		resctrl_file_fflags_init("mbm_L3_assignments", RFTYPE_MON_BASE);
 	}
 
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index d087ba990cd3..47716e623a9c 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1931,6 +1931,54 @@ static ssize_t resctrl_mbm_assign_on_mkdir_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static int mbm_L3_assignments_show(struct kernfs_open_file *of, struct seq_file *s, void *v)
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
+		rdt_last_cmd_puts("mbm_event mode is not enabled\n");
+		ret = -ENOENT;
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
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -2069,6 +2117,12 @@ static struct rftype res_common_files[] = {
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


