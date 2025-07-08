Return-Path: <linux-kernel+bounces-722470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D897DAFDB0B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90511543280
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026D226B2BE;
	Tue,  8 Jul 2025 22:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bf9e6ZT1"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6299226E714;
	Tue,  8 Jul 2025 22:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013347; cv=fail; b=Ml2EPJ6z6hYDWYlfebG9KaiawE/SW8pecby3O8NncP+mp0cbRRHQL3eUuF0i054VhMz9v7oG1mqaYy46m4W/UVfXqnyVkJYBj0LoppLu5ehUCuakcHiEWWic2rnjQ+FB+WUHdVJcFR7I8vz2lVopCiJMENna3mNXLx1ldpv7CT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013347; c=relaxed/simple;
	bh=ofwlnReEjjlyrTc53LTk1d42Lj1EE9Ya0wgQdMnYIVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGtw8i3Euhmodsjs1Zoa28+g1WTzQOz2OwA/pzJJjq5LDZo/i7lnVf1kxZ8Bp2qYW4zK1dn+WDufL3mAqtjWfcymiHMifN5t7hLftTxau4rFiARQfhl4yshByTu9lLkgPZGUhkGxcyTM6jUcpngZrbLx9lNdvCYHVhyfz/38SeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bf9e6ZT1; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBK9bsSfAo0IN5wRcxMX2StAeD7KUqKTqw9tZdLbMO6cmhBfygewd4fkydKkDy9spMsSlNqhE2vcj6vEQab3eI6uNd63Wnlin/Cp3YopkjT3WWOJXfx6xcFwqY+JzmfLdpnDmMQ4QcJC9cH1VjUNxmrbQF0jY4nyWjz7mphuyGT0/Bfl2eWiFm0Nz6qDdFZz9xPW3d3WG6ERLmWQ/GJK2O9PQCHNUzxv3Pii3Tlzv8YJP3KcyC5/lXvdtNBd2MPD6/b2e+OJZGaMh3xjyrDNm8rxf1OALhL6GsulUYLPLXZLJ+qJ4OQBf1YxV+I2ptzKKtkdpCSoXwfwZmfSGyGLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7TmDpplwO2OnJjY4WYdezYPLnEGKpixGxJ38sq/76o=;
 b=SXvEu9G+8WHY2US2KuIj83i1H11phC4pSptCs/8O5/P5TMzjxwumDxwsT1RLjLnan08OAOt555aCDFpBeq8nA+FqzarxtEfm/I347ERgLUG8hYzroEW6duFGssJHRDnTzTbC7k6h6852GZdzDSak2ZIameJRf4kPYBQFX2TH/f7NsiaAQUjpexLOxqKni/Y7eQ3OzOHhAWRqls8YLnyM68bQhy3wAmwwkkq/U5D2Z8iPH3Coy2Equa8hkOtDmPtiE7dywsOPHQ88Cu4HPFp1wufV+2Zc2c50hjlLwY6g93ofZUgvMhg6bN0PMLjmysmsqwoFEb5lmNnrPI98NJNy2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7TmDpplwO2OnJjY4WYdezYPLnEGKpixGxJ38sq/76o=;
 b=bf9e6ZT1mRbriw4kpWmXZ6srk9cQoENdCd8g7tgfV2AHyGBz/l3kKwc7Vct5oHhFVx2zZBjIh7aLFb1pAx6H15u+xGpEgdy3fwesXnh89KRMovJcw5L8vNjlCF5fam9Y2HFiAHO5mYiCkGDgq9DxH5dppb1GYLG50xutsiWRrQI=
Received: from BL1P223CA0039.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::10)
 by IA4PR12MB9762.namprd12.prod.outlook.com (2603:10b6:208:5d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 22:22:22 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:5b6:cafe::7f) by BL1P223CA0039.outlook.office365.com
 (2603:10b6:208:5b6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 22:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:22:21 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:22:19 -0500
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
Subject: [PATCH v15 30/34] fs/resctrl: Introduce mbm_L3_assignments to list assignments in a group
Date: Tue, 8 Jul 2025 17:17:39 -0500
Message-ID: <e5f605a14d057c532de76cc4aa6635c5c1c7e388.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|IA4PR12MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7950fb-312f-4806-511c-08ddbe6de890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m+cZBdeKak51QULTOTLh2H/HBtkHW6vxAL/vwVO0NnzxvsInm9jot+6/PeLt?=
 =?us-ascii?Q?jUoDutLwaQPVwaIK1RuAuf+8IIBfyw9f5hX7UA8+zUxfPnPF+G6yrbGMbAFm?=
 =?us-ascii?Q?7s2WM83e2RPRdS7OHw6zkZLcAo5VtnCYudwG4xQW2/rghvwnBXrKscvF1xpD?=
 =?us-ascii?Q?nMQlpWH5YkzsHpRAFTq9Wnt1swzaPS4ar5FG7vAXbovt0yO7aFRsQe995bYp?=
 =?us-ascii?Q?tvzLn4n1TPNv68QvIsTeRFa26yst43D4/serNR8x60ExduR9vsEvAH2TpPmb?=
 =?us-ascii?Q?H/gPSvfHpbRm2n696AEWSp8bNF4R93oGNJgFrzb0Z9Us+cMnaGAS+xJud9uq?=
 =?us-ascii?Q?uR6A98odcEANphUsRQUATy1HXttp0ULINoDCcVVyOTK6GJlkNLEQX7fFkt/j?=
 =?us-ascii?Q?8yzb/XGxQrwdDdiaMZrc043/qROOu+fOF5PfhJXj+614Jk6/XCHzyrwd2OTi?=
 =?us-ascii?Q?Y5bm7v0Gt1RmLPEx0Mp7/yctYObCf24fNvozG3V9vqdc4QV2FWE5saMYPVMT?=
 =?us-ascii?Q?onbSDhBgqEd9So3A+l3BLiXTmCVJuiSgfnTCCvAQcptA4Mym6x3kjPnOgwwb?=
 =?us-ascii?Q?oDF/xG1cxE4iPsWc6RsgJrE8LMFD7Pyx/PljrjBel9TFg4DewOD5UVQsBG+Y?=
 =?us-ascii?Q?sqdfYBoI6MIZQLvAXtKq5N38CKxejjWiEslc8bvyayzzJsglV9whEL059bDu?=
 =?us-ascii?Q?Swr4ObRKK05D7M6ud3ral8rntCqLlTyQ8FHKyLFJqv0+IlEXq12eJurbIViR?=
 =?us-ascii?Q?1Q/QW0Xi3DC+wqu68EjS1fzFg84PLal8B07bPnk9qpYk2vLWu/2P0+oShQUn?=
 =?us-ascii?Q?EOSAiSn+m5nVYS0uIIg5EhltJRQhblubDYxfUQsXp0qFxQkW6153C4vlk68m?=
 =?us-ascii?Q?i5DmH1Ly3f+qY5VLrOqpxmb8Gk6bjqQKJx035/p7y43H389/7vFbpBtkmzwC?=
 =?us-ascii?Q?DuaILOi99k213dsKDaQ6FQiRQ3F3kAsER2pnHL9Tw3/QpvksO92E9ZVDsSzc?=
 =?us-ascii?Q?k/CADsNyh0LraCbRQKxe8gBl4xPzRVXinYxl3knVnRW3XdKgodi8IG2f68r/?=
 =?us-ascii?Q?SOoBf2Mp4MyRfYAcmoByYm5nSZ1hpcbmbTIEwOjkKGquhATuaw9OwXYW8SzS?=
 =?us-ascii?Q?gDRhtLcpYv7J6vuKuSUzUxdBZoTZyDdmsgz8PTcmJKEzqzroTHwLgnsznZ11?=
 =?us-ascii?Q?TRbjK+fpeHKoZWOQJdcDNIiTdAKn748sioWdcU1wYKtXGO8gve/JldMiLDc6?=
 =?us-ascii?Q?pq8qB3lxc4ycqiZx2UvNHjtozzvc0/+dL1kcgcCxZ8ad7oY6pkkdfm/9FkFb?=
 =?us-ascii?Q?7KENVFmBsyxNCN8mK4WRH6E3GgTIAJuCRdUKerE/bBU+VD6Vm0OEsIDJmqke?=
 =?us-ascii?Q?lCjO0u/k+BfYOYUZNDYEVZxN1DPX6SWrayVS1sf3eCjnaGuEu2IL2FYhT+Kz?=
 =?us-ascii?Q?MDsqOabo3rqw8StzwtZD/9TVy3Y3oc8YI/EZ6uoxmpcc1j5gzyVRKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:22:21.8542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7950fb-312f-4806-511c-08ddbe6de890
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9762

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
index f9e9a8a66cae..4dd1d605d6ad 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -516,6 +516,34 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
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
index ccca2330eebd..e30a867c00bb 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -986,6 +986,7 @@ int resctrl_mon_resource_init(void)
 		resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
 		resctrl_file_fflags_init("mbm_assign_on_mkdir", RFTYPE_MON_INFO |
 					 RFTYPE_RES_CACHE);
+		resctrl_file_fflags_init("mbm_L3_assignments", RFTYPE_MON_BASE);
 	}
 
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 645245f274e9..dc108c5db298 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2023,6 +2023,54 @@ static ssize_t resctrl_mbm_assign_on_mkdir_write(struct kernfs_open_file *of,
 	return 0;
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
+			if (mbm_cntr_get(r, d, rdtgrp, mevt->evtid) >= 0)
+				seq_printf(s, "%d=e", d->hdr.id);
+			else
+				seq_printf(s, "%d=_", d->hdr.id);
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
@@ -2161,6 +2209,12 @@ static struct rftype res_common_files[] = {
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


