Return-Path: <linux-kernel+bounces-726225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3376BB009BC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55101BC8342
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF722F0E2B;
	Thu, 10 Jul 2025 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zGo5fRm6"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B16725B2FF;
	Thu, 10 Jul 2025 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167869; cv=fail; b=aCPm6PS5PgzFdn56mhsUmbZkA8RylJCGwr2LuUPwVWLlPBzt6SKWXp8kBNZT8awpdFk8TK2IxoA/Og3+9lKbm/2iWiGC7oJys/li21QwlhsgoSq2DPx03dHTY1plO37ceK+f1+570RNwQ05odImqRZRZSv4dkBgDmsylkPBSl1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167869; c=relaxed/simple;
	bh=qUD+RXcheNeow3UNRRgSzbkQ9VusjPjs52rFV3F/RUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEjVrXCbwcjzwtdWf2whOTT9bNS7jop5Rn255UrpMKrTPTBB7OJMBu4ThC9faToku1AFkBSO0rZW0tXvCnGXEVDsLaedUSdfH32HrLsLAJbhhabSffeQl4E5u6ME8efU0pF6c4fGgPcIo8/kOtdUwVAPp8UeLO+Gj8Kzs+uA64I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zGo5fRm6; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3nt0QkVO1oD2CSrSNlhAGjo93F78/MIr/52ZdCyU6+AmmmxSYGIC7+IepWeKW5TsRGQ9V8Zlxo1Ju8VD55thiEL4sFxyUNkbA2VjCVzmDtDr166XESVZ0Iz77fsezkWnyGdnThjjq45/q8HSUejiHpeZq5CQHcxH2+DlQyYtZveh5LFjkPjUF3OzWPz7qYjvgoSPa0SWqzi9QPGKDxGt6WFMiQGlLoZ+hUAoFo36RbzAiyBefkmrgPoYKqui6cddUKaL1XKvscJg4fd4BVhxaTUjOWu8PPQNt0qneCRZ1r8WKD0s/ri4tSfhPOlkvU7NkC260bhOpimCWuwStK35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcaH3fvVhZMcE6IzwsIWEdyNo3Qoq2nv4iMFRUM6IaQ=;
 b=VU8KWiuJ+U9XXFhV6lBo+48XYLUocladQPDhpXdZPOJL5PaHMX4hZbZ8dYG3PEA3w7cJFtfsNIjunZKSY7AbDegRl5bsXt3QRPAizxXwDPCSWpCmrQ3bfimGHoFcJYFEH9MJaS2lZc4X2tn9/ufL8LkhOirgC0gc8uYDwMvqHgBoCmM0Nw8eUkfnQznNEFzgBk6BO2h+mDntPm4bVTVihdw7UPKEnpYkiCuxWbA+QITvW4IyJAY7pcqJXtC89WQDu/rBbj+f621dlZXAkAYgNd1kChYLDaq/X7+/NbGKwKPjtphDk07FR0lknlpVF59x6zgx/llyPWbsaa4ADXbfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcaH3fvVhZMcE6IzwsIWEdyNo3Qoq2nv4iMFRUM6IaQ=;
 b=zGo5fRm6CDg3LRlosR3wo/41H6MMiMq3ILl3AuesNwecquCmHZpPFV2/UAQm/hOw3QbmASozuk73PXjD+l7Fje7CvyM6Fzn95mymBJIOBlHXRmFm4nft8n6LWvSil1i+2sJlwg7qZXrffBZ+d/5M7KAiB5DhJkY30rJRIUUlyoE=
Received: from BY3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:254::27)
 by PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 17:17:42 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::e6) by BY3PR05CA0022.outlook.office365.com
 (2603:10b6:a03:254::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.20 via Frontend Transport; Thu,
 10 Jul 2025 17:17:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 17:17:42 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 12:17:39 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<babu.moger@amd.com>, <yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>,
	<xin@zytor.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <me@mixaill.net>, <mario.limonciello@amd.com>,
	<xin3.li@intel.com>, <ebiggers@google.com>, <ak@linux.intel.com>,
	<chang.seok.bae@intel.com>, <andrew.cooper3@citrix.com>,
	<perry.yuan@amd.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 08/10] fs/resctrl: Introduce interface to display io_alloc CBMs
Date: Thu, 10 Jul 2025 12:16:22 -0500
Message-ID: <7ca0bdcc27d4033d04131e2feca5921f85df0ac2.1752167718.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752167718.git.babu.moger@amd.com>
References: <cover.1752167718.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|PH7PR12MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 640969c4-2891-428a-c583-08ddbfd5adff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C6jHU9jWMDAjTc91ie3kserWeuevDu1TsAThdCxityr8zTVbUUKzZxzifJDI?=
 =?us-ascii?Q?N+kanDmLqMRNgG3c0Mx4hipy3suS4XpjkaMARz+4qoW/6T87Pc8w3vbJeKok?=
 =?us-ascii?Q?3WUC1IndXklbcrFOZGqdY439JPpFEAllTOqFGaeOxk+KaEQEs3N2nHULLvvW?=
 =?us-ascii?Q?hCAXXaWW+9f87WdxGdp0vsSYfEnS8yC4oe/YZe7lkl/YIzmxvwR2mIJCr3TE?=
 =?us-ascii?Q?qRcMKE5skqAGhJI6f1B/GMqTC4rV6iRd2PWWi53vivChHTi7/n7HTn7HbmAv?=
 =?us-ascii?Q?Q7aZIbuytJcpJ6TT6ecLDPzLyHeyjq1LPEd0Fa4VIl+DOZyub7NdGHxEEnGu?=
 =?us-ascii?Q?gm4mZx0TvG9gy0PL9BaW7XeTvvB7ZXsYih9GXH9vC17W/QgXGxOPuBDhf4k3?=
 =?us-ascii?Q?q7KYajr2XSEDu+iTk8T2GjTVTLJiyZcxV8An2JGR21QYQ2tHAy7gswfLVrTk?=
 =?us-ascii?Q?b8myyAx5dsEkVfP2cZKfuhSILIhgaZEn6EQX1A1wAd8uncaFjoUFYO6AAYhy?=
 =?us-ascii?Q?tRKzwGrs5Tliv5Z9uLHDuKWs65icg0oyNWGmtRJelmx5Pnf/2ZNjk+WODK2/?=
 =?us-ascii?Q?RSki8j0s3fEXs4sAQGUUdWSKWtjKyTC+Vsmc3g8cpES1/+q4WCUj9o1MONeL?=
 =?us-ascii?Q?E0TL++SBU6CCoa3rG7bhuq2SbYjss2NPmiX6JfLxfJLzA5uUpC+wzinarowT?=
 =?us-ascii?Q?SGt6G/r5GxvHS7bj2nKsknJ2qPNHnCjVtp0D3qVfiHT7GDXp/1OGN/nEInWb?=
 =?us-ascii?Q?2ZP7vXzgdm0Z9+iDNYWMmZqaa05B5iNmpdRBXV965dTNJ8EQemhFThGraFxV?=
 =?us-ascii?Q?8K3KKhOF0uWvyj/ED8RzGWpokenAylS/oS6sl35L/W09CWyV1smWOzk5spw9?=
 =?us-ascii?Q?1ZKi7TOOH2PHx9RvTTeZI0qQ7Vu8fEjMNOcIGT2P6cHK+I3AKu0jLPxyrMML?=
 =?us-ascii?Q?f+H1BzdyLkMeErTPfTf5rqMmw95+Vsy+TjOBPTMP4Tck5mPzHr26DXCgy4Ap?=
 =?us-ascii?Q?C43kDg9k4MhCoOFJaTFx2hbakV5Fu2G0wP2qOkLNdj/ZCXRrnq0XRidtuZtW?=
 =?us-ascii?Q?DtqmQMdBGEwvuL7gFmatSll+Og9RAQ5yb3PHH5AIBrp0HtkcbjDYSsuIPK+L?=
 =?us-ascii?Q?KoU9TiagCzFFTy9r4uBjDflIlnt8xOAbWjafE2SrWHxTivm0U6S0ya/w6dPg?=
 =?us-ascii?Q?lHOvTNXKIAHZSZmSOhH0SCmhQAo9BaWzbIpYaae8A+npctKQtBEDSN3nmp/u?=
 =?us-ascii?Q?hXuxFlGXlsmyLH4tb0llZteTsxGecrgl9hN9z0hyW+bXps8blIQch2UtQ168?=
 =?us-ascii?Q?4MMSfrSN0f+LRHgECqNJZKSjWY0bZNCrKEaiP37YQPRLh4HBRIwxgvS2dwpq?=
 =?us-ascii?Q?N6dt+tTSQa+VNn7H7jIcM4ZjbEbKsGgnY/H/UEZ9VmB4vdJSJr15geqJDi5q?=
 =?us-ascii?Q?Q8RJOYGFdq0BjjgW+gwsvuT9h8tgOf9jglMVZWsKpehXx3W0J/sIq5HOYj1c?=
 =?us-ascii?Q?u/MrN6YbjPqUAMnZwZuMbjCzRBy14Fkp3bKO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:17:42.3332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 640969c4-2891-428a-c583-08ddbfd5adff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809

The io_alloc feature in resctrl enables system software to configure
the portion of the cache allocated for I/O traffic.

Add "io_alloc_cbm" resctrl file to display CBMs (Capacity Bit Mask) o
fio_alloc feature.

The CBM interface file io_alloc_cbm will reside in the info directory
(e.g., /sys/fs/resctrl/info/L3/). Displaying the resource name is not
necessary. Pass the resource name to show_doms() and print it only if
the name is valid. For io_alloc, pass NULL to suppress printing the
resource name.

When CDP is enabled, io_alloc routes traffic using the highest CLOSID
associated with an L3CODE resource. However, CBMs can be accessed via
either L3CODE or L3DATA resources.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: Updated changelog.
    Updated use doc (resctrl.rst).
    Removed if (io_alloc_closid < 0) check. Not required anymore.

v6: Added "io_alloc_cbm" details in user doc resctrl.rst.
    Resource name is not printed in CBM now. Corrected the texts about it
    in resctrl.rst.

v5: Resolved conflicts due to recent resctrl FS/ARCH code restructure.
    Updated show_doms() to print the resource if only it is valid. Pass NULL while
    printing io_alloc CBM.
    Changed the code to access the CBMs via either L3CODE or L3DATA resources.

v4: Updated the change log.
    Added rdtgroup_mutex before rdt_last_cmd_puts().
    Returned -ENODEV when resource type is CDP_DATA.
    Kept the resource name while printing the CBM (L3:0=fff) that way
    I dont have to change show_doms() just for this feature and it is
    consistant across all the schemata display.

v3: Minor changes due to changes in resctrl_arch_get_io_alloc_enabled()
    and resctrl_io_alloc_closid_get().
    Added the check to verify CDP resource type.
    Updated the commit log.

v2: Fixed to display only on L3 resources.
    Added the locks while processing.
    Rename the displat to io_alloc_cbm (from sdciae_cmd).
---
 Documentation/filesystems/resctrl.rst | 18 +++++++++++
 fs/resctrl/ctrlmondata.c              |  8 +++--
 fs/resctrl/internal.h                 |  2 ++
 fs/resctrl/rdtgroup.c                 | 43 ++++++++++++++++++++++++++-
 4 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 189c1ccb92d6..c22a9dd667cd 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -176,6 +176,24 @@ related to allocation:
 		When CDP is enabled, io_alloc routes I/O traffic using the highest
 		CLOSID allocated for the instruction cache (L3CODE).
 
+"io_alloc_cbm":
+		CBMs(Capacity Bit Masks) that describe the portions of cache instances
+		to which I/O traffic from supported I/O devices are routed.
+
+		CBMs are displayed in the following format:
+
+			<cache_id0>=<cbm>;<cache_id1>=<cbm>;...
+
+		Example::
+
+			# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
+			0=ffff;1=ffff
+
+		When CDP is enabled "io_alloc_cbm" associated with the DATA and CODE
+		resources may reflect the same values. For example, values read from and
+		written to /sys/fs/resctrl/info/L3DATA/io_alloc_cbm may be reflected by
+		/sys/fs/resctrl/info/L3CODE/io_alloc_cbm and vice versa.
+
 Memory bandwidth(MB) subdirectory contains the following files
 with respect to allocation:
 
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index d98e0d2de09f..e78828b0408a 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -381,7 +381,8 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
-static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
+void show_doms(struct seq_file *s, struct resctrl_schema *schema, char *resource_name,
+	       int closid)
 {
 	struct rdt_resource *r = schema->res;
 	struct rdt_ctrl_domain *dom;
@@ -391,7 +392,8 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
 	/* Walking r->domains, ensure it can't race with cpuhp */
 	lockdep_assert_cpus_held();
 
-	seq_printf(s, "%*s:", max_name_width, schema->name);
+	if (resource_name)
+		seq_printf(s, "%*s:", max_name_width, resource_name);
 	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
 		if (sep)
 			seq_puts(s, ";");
@@ -437,7 +439,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			closid = rdtgrp->closid;
 			list_for_each_entry(schema, &resctrl_schema_all, list) {
 				if (closid < schema->num_closid)
-					show_doms(s, schema, closid);
+					show_doms(s, schema, schema->name, closid);
 			}
 		}
 	} else {
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 0a1eedba2b03..3d4a3d7696d0 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -374,6 +374,8 @@ void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 
 int resctrl_find_cleanest_closid(void);
+void show_doms(struct seq_file *s, struct resctrl_schema *schema,
+	       char *name, int closid);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 06c854caa55c..008657e43656 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2004,6 +2004,38 @@ static ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
 	return ret ?: nbytes;
 }
 
+static int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of,
+				     struct seq_file *seq, void *v)
+{
+	struct resctrl_schema *s = rdt_kn_parent_priv(of->kn);
+	struct rdt_resource *r = s->res;
+	int ret = 0;
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	if (!r->cache.io_alloc_capable) {
+		rdt_last_cmd_printf("io_alloc is not supported on %s\n", s->name);
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	if (!resctrl_arch_get_io_alloc_enabled(r)) {
+		rdt_last_cmd_printf("io_alloc is not enabled on %s\n", s->name);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	show_doms(seq, s, NULL, resctrl_io_alloc_closid(r));
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+	return ret;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -2101,6 +2133,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= resctrl_io_alloc_show,
 		.write          = resctrl_io_alloc_write,
 	},
+	{
+		.name		= "io_alloc_cbm",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= resctrl_io_alloc_cbm_show,
+	},
 	{
 		.name		= "max_threshold_occupancy",
 		.mode		= 0644,
@@ -2274,9 +2312,12 @@ static void io_alloc_init(void)
 {
 	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
 
-	if (r->cache.io_alloc_capable)
+	if (r->cache.io_alloc_capable) {
 		resctrl_file_fflags_init("io_alloc", RFTYPE_CTRL_INFO |
 					 RFTYPE_RES_CACHE);
+		resctrl_file_fflags_init("io_alloc_cbm",
+					 RFTYPE_CTRL_INFO | RFTYPE_RES_CACHE);
+	}
 }
 
 void resctrl_file_fflags_init(const char *config, unsigned long fflags)
-- 
2.34.1


