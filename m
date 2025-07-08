Return-Path: <linux-kernel+bounces-722468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F212AFDB04
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA72188F527
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28D725A2C2;
	Tue,  8 Jul 2025 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kXQNs4zN"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1804F26CE07;
	Tue,  8 Jul 2025 22:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013342; cv=fail; b=CQ78jzSF18bqsiyoPXr/UeduijFRKGxfkCu/hEtBsgwBa0MN32jES7DQwsSAL1iob4rGWrCZubj/rltEMMWIj3hyc7Gpdula4vI8+Xqo0Py1b8qFXCtvIP6UbM8690aY0ktKpcuxZQpWsLtWBj34+sZQjz9Ls+fi8GKK/5y/Fz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013342; c=relaxed/simple;
	bh=U0c7xrFD79ylRM1PhZ8rzXsXL0N5GxWEN1WDTseRyz0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9asZ3xYgH5NVXb0gjYp8omdIvoY93bTTO6MB43WKvkgh2UpkyIm6JM6oAriyABSM57z+bzGej2UPBKmt7A8WyPEHN+otWNxAS+mg1BLdGvq2+uPQBtmze69ICbb4dSfUZV+aqWgnMTfRwUIke3Tv3cTRuaMTpsfGDHFsG7xRkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kXQNs4zN; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/pD20+kop1nU/Q29JkrBfZXwDVJfkkFttxlIO8/DATlzQrZb64dlZQJQFTSLgmxgZC53k0D2Vb+XABDL7o/98r0dFG4r4AdmJyjMcQzxOra/CRpr8bz9fqPO+6BkONt8CDP0KiCNOz4I7HlPqQcRIK2z0eD+tRTrbtEeL079vVangnZLAgpkpBb+x064epZjskQkcCNj3cCEGUVZfaNjALmrFYlMRsyqvkidxXlWRc6yKP4U5LFw+YTrMA0BgatCk3LDSFYSQSsirC5B3UEDYeroJNFdHRefbgAVQhPebmQ8/fEzVEvE4l6e0h6sOhTGjT9UuvvL/gOI5qM8cGBmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYIkrFTpCWjvCjrI4Cv6oNY2FMYcF5xSwvOyaGDQ3pk=;
 b=I913t6m1A8B0XSPu/oHOXoyIN9jF0EEbN2u1lRF2+1TpcdyQfgS4cHWcUSnVD1Q68v002HiTU2uwmpklvy8dyMY9kcXbgqOxqLTKTXpvVAez/SazPOZC2QCRj82rkEJz3Q2hwy8HJlaoyUwSHxkAFI08J6ZWKd9truHi27AlUaVcBuowHWWyLxJ4wDsGgDEkjqxvAo9DLOTVNsUWWAICS6sb2qtcB52BF8DcQdIXi48pFK6I9oQl++GKrqUPqzgeIQDZQq9S22nqtog+fz38DSz73bCg8t9uzocUJliatSyaNQdp0KWf/wVfpng0Mak+T5JJfKdGL2BPqBjuf3vPog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYIkrFTpCWjvCjrI4Cv6oNY2FMYcF5xSwvOyaGDQ3pk=;
 b=kXQNs4zNSo3fNi38c/qEzMTs0BuoNMVwnjbhvqGLUygj8tHXD5DKPxOhylopiED6ODQ+LsvfY7+X8uD5aZ5zTlRjoK7DBot8UXFhjydGwav/ZSSrJbrAr+PPxzFTGXP0S3GQ1yxPuWx1VJ8fviNHIbrboHWHxZUnWevd+74weBg=
Received: from BN6PR17CA0060.namprd17.prod.outlook.com (2603:10b6:405:75::49)
 by LV5PR12MB9777.namprd12.prod.outlook.com (2603:10b6:408:2b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 22:22:17 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:405:75:cafe::c9) by BN6PR17CA0060.outlook.office365.com
 (2603:10b6:405:75::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 22:22:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:22:17 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:22:02 -0500
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
Subject: [PATCH v15 28/34] fs/resctrl: Introduce mbm_assign_on_mkdir to enable assignments on mkdir
Date: Tue, 8 Jul 2025 17:17:37 -0500
Message-ID: <ef5934fc2b04654c7ff3e6bb910e7c5cf38ba62d.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|LV5PR12MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8d36e1-41b6-4063-b0a0-08ddbe6de5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uKw8esBzdUzc65h+iI8L923NZLIsjOH+0EP+372Y7G87j5nx1+FYpLTN9hM8?=
 =?us-ascii?Q?DcEnLUv+Ph386FXNXPY+k1hMe0cdHqPJwiPNNHQyCt1bXU86ToYvYwqG98uU?=
 =?us-ascii?Q?0n41lsX/YAUyr7TN8ZZcb3EMDkKS7VIs3MeCFGLpi3XfX24UDyfojPm7RqUU?=
 =?us-ascii?Q?CypbneJjAdtaJEUPpeNLM/kXLFtorrOWUIK7K+OSR6T/hPlnvXtUdLKZKutz?=
 =?us-ascii?Q?EhJ5/rxl/NFM1xL/WmLYiHM8feVJ92wTq3FjINJlHUOfYVy6ayBOKAwybjxO?=
 =?us-ascii?Q?3Gy1gaWOBWH3zOxfKRi5ooNhd5aOmBh6KN2KYtxYeUe4ISMnvSoVGBzCfFVG?=
 =?us-ascii?Q?ggGgtLziUYMQWXJ+xR8XpeQIKjkQF435KErpArU9rIF3GGTE3ocauZ0TSuNt?=
 =?us-ascii?Q?g3DnnOT/TSeXP60wXNgobdVIYf8jvhvd9pNSO4jFyeHlekurCFEWtNNxq3ga?=
 =?us-ascii?Q?U38MiwyOzTY4FD94zN7uUsTX91/EYVmXij5ax0xRRDfEPbC9TDTt7HFuKWwt?=
 =?us-ascii?Q?AHZte/JYwhrnvobcj7NbMRhimK39h9/EWCioF+keevmK9FqUfn9NGi3KmsK1?=
 =?us-ascii?Q?Cu7QZTpKwvHrRoNrUAFg6547X+h7OQmiAhmhnt7pcXxibxKiO8UnOTUSegEq?=
 =?us-ascii?Q?Vo7cmj3s6aqyCjQOL+24p3QgNmA+VWCwy4JkEyTIolTHs3g+u6V++XsKLB7s?=
 =?us-ascii?Q?21wbRneNn9AfCDvC3BOM4X2JdUDG09TAMA4fG7JnJOJhhhEL+hm9kVFd+/is?=
 =?us-ascii?Q?JeXF9c7JeyJxStobj5H4F1tnOBBVxmfBgq83x623X/xuabERebPfDoae0lNl?=
 =?us-ascii?Q?6VhRzNM09qqK+jZFzjFUwGcq0kCC6W3mdramrERix0vVB3PNL4g/25OSHr/S?=
 =?us-ascii?Q?i3sUofQhXb3LhMzETGSPWNtyBF73CRDXAjcjen9m3SGRAgp4wAhoqM/R7S22?=
 =?us-ascii?Q?7p0feXPaQlZjX/PJMTwpqnj7VWnJQpVYD43bRbxjt+w2Ojm+XGLlILN0G+rQ?=
 =?us-ascii?Q?d9j1OM+4Tz0xNNvvHUfoK+TFRByz91/vu1pxZpYPZB+HKqNUEdvtFEE47u7a?=
 =?us-ascii?Q?Sdk948ZP1DjZ4Zvq5PjREQjGwLIuq8mXgL/mN51WNSuqhTxkVgdiGEP/03Wt?=
 =?us-ascii?Q?kA60xFck2nHjCMMjCh53IRa8hXsP1HO9mR6nUebDbTkaHmYL5VbZd1NlSclH?=
 =?us-ascii?Q?306Hcx10bFOLr03S1aRlrs5Zv2JOv/MgwnbFu/N6iPqR/R/87jRG9I3HqQoE?=
 =?us-ascii?Q?KvW1FR2rfdY7Vqzhk1kSq00izCh7v9qEhoBqX0CEUCjQ6miJ8dO2lTuku4e8?=
 =?us-ascii?Q?OYbhCkCbRiiF49AqXIJ9XVMhJUhtPUtMEuntOCSP1nCfH7wv4wAjRAJVm+tn?=
 =?us-ascii?Q?nvJMreDmdtzqBfQtiR2dXq7+qPVYvTO0Z76plN8T/IxnBDhj14uuVVvaRINq?=
 =?us-ascii?Q?+7nm4+jzBWKC6m6vRBvzKiL/uPJ+JwKOuuKb1iMLm0pkzKUFB3W4ZVgAsEK9?=
 =?us-ascii?Q?peThosNIREEW15bJ+3wc/PI0z5eqr2M40YEvQER5PGPPUxb6HuagIMGYtw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:22:17.1053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8d36e1-41b6-4063-b0a0-08ddbe6de5bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9777

The "mbm_event" counter assignment mode allows users to assign a hardware
counter to an RMID, event pair and monitor the bandwidth as long as it is
assigned.

Introduce a user-configurable option that determines if a counter will
automatically be assigned to an RMID, event pair when its associated
monitor group is created via mkdir.

Suggested-by: Peter Newman <peternewman@google.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: Fixed the static checker warning in resctrl_mbm_assign_on_mkdir_write() reported in
     https://lore.kernel.org/lkml/dd4a1021-b996-438e-941c-69dfcea5f22a@intel.com/

v14: Added rdtgroup_mutex in resctrl_mbm_assign_on_mkdir_show().
     Updated resctrl.rst for clarity.
     Fixed squashing of few previous changes.
     Added more code documentation.

v13: Added Suggested-by tag.
     Resolved conflicts caused by the recent FS/ARCH code restructure.
     The rdtgroup.c/monitor.c file has now been split between the FS and ARCH directories.

v12: New patch. Added after the discussion on the list.
     https://lore.kernel.org/lkml/CALPaoCh8siZKjL_3yvOYGL4cF_n_38KpUFgHVGbQ86nD+Q2_SA@mail.gmail.com/
---
 Documentation/filesystems/resctrl.rst | 16 ++++++++++
 fs/resctrl/monitor.c                  |  2 ++
 fs/resctrl/rdtgroup.c                 | 43 +++++++++++++++++++++++++++
 include/linux/resctrl.h               |  3 ++
 4 files changed, 64 insertions(+)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 06c8c08d0341..f9e9a8a66cae 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -354,6 +354,22 @@ with the following files:
 	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
 	   local_reads,local_non_temporal_writes
 
+"mbm_assign_on_mkdir":
+	Determines if a counter will automatically be assigned to an RMID, event pair
+	when its associated monitor group is created via mkdir. It is enabled by default
+	on boot and users can disable by writing to the interface.
+
+	"0":
+		Auto assignment is disabled.
+	"1":
+		Auto assignment is enabled.
+
+	Example::
+
+	  # echo 0 > /sys/fs/resctrl/info/L3_MON/mbm_assign_on_mkdir
+	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_on_mkdir
+	  0
+
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
 		bytes) at which a previously used LLC_occupancy
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 0722e72f6cb1..ccca2330eebd 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -984,6 +984,8 @@ int resctrl_mon_resource_init(void)
 		resctrl_file_fflags_init("available_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		resctrl_file_fflags_init("event_filter", RFTYPE_ASSIGN_CONFIG);
+		resctrl_file_fflags_init("mbm_assign_on_mkdir", RFTYPE_MON_INFO |
+					 RFTYPE_RES_CACHE);
 	}
 
 	return 0;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 4889e7556cc7..b7289ce2b3a6 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1987,6 +1987,42 @@ static ssize_t event_filter_write(struct kernfs_open_file *of, char *buf,
 	return ret ?: nbytes;
 }
 
+static int resctrl_mbm_assign_on_mkdir_show(struct kernfs_open_file *of,
+					    struct seq_file *s, void *v)
+{
+	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
+
+	mutex_lock(&rdtgroup_mutex);
+	rdt_last_cmd_clear();
+
+	seq_printf(s, "%u\n", r->mon.mbm_assign_on_mkdir);
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return 0;
+}
+
+static ssize_t resctrl_mbm_assign_on_mkdir_write(struct kernfs_open_file *of,
+						 char *buf, size_t nbytes, loff_t off)
+{
+	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
+	bool value;
+	int ret;
+
+	ret = kstrtobool(buf, &value);
+	if (ret)
+		return ret;
+
+	mutex_lock(&rdtgroup_mutex);
+	rdt_last_cmd_clear();
+
+	r->mon.mbm_assign_on_mkdir = value;
+
+	mutex_unlock(&rdtgroup_mutex);
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1996,6 +2032,13 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdt_last_cmd_status_show,
 		.fflags		= RFTYPE_TOP_INFO,
 	},
+	{
+		.name		= "mbm_assign_on_mkdir",
+		.mode		= 0644,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= resctrl_mbm_assign_on_mkdir_show,
+		.write		= resctrl_mbm_assign_on_mkdir_write,
+	},
 	{
 		.name		= "num_closids",
 		.mode		= 0444,
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 96679ad49d66..74a036067135 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -277,12 +277,15 @@ enum resctrl_schema_fmt {
  *			monitoring events can be configured.
  * @num_mbm_cntrs:	Number of assignable counters.
  * @mbm_cntr_assignable:Is system capable of supporting counter assignment?
+ * @mbm_assign_on_mkdir:True if counters should automatically be assigned to MBM
+ *			events of monitor groups created via mkdir.
  */
 struct resctrl_mon {
 	int			num_rmid;
 	unsigned int		mbm_cfg_mask;
 	int			num_mbm_cntrs;
 	bool			mbm_cntr_assignable;
+	bool			mbm_assign_on_mkdir;
 };
 
 /**
-- 
2.34.1


