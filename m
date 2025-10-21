Return-Path: <linux-kernel+bounces-863888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D776DBF967C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31E10348179
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EAB2ECD05;
	Tue, 21 Oct 2025 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nFU053e0"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010015.outbound.protection.outlook.com [40.93.198.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4CB2EC0A9;
	Tue, 21 Oct 2025 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090990; cv=fail; b=f1D5mBD+QkIRcKlCTfQp0e+BSNj8vjGCh6f4BG6VWfs2tbboDRqCp3HOl4Mrw4O5CuwrjDY5Rmz3oiNlWTOecihjjKy3RtFN9kyOcur6YJwBjHm79eyDGeQeM/ZPMZbfOo0gORDEyt3S+QhXKdPh8FpxnDFLKo1SkEfgWW6zXMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090990; c=relaxed/simple;
	bh=fEuhXlSJJIkiKo/tCk//+YwkHmOhq7EsxICakKUy7Tg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8S+ma2ecw6ZX4L5sgl6KVeZvwbKLIk+Rqv3j8Yfk+d06HkJu3ITvZrzp4sfhCkCjUUGxqGeLOw3yMt7y7mSOkzq9RqlcZY5YY9NDvK+YKZOWrBxUwRVCk+jCA/d9a7FPXAcnH7eGQqMiTVGD1NFQUj1ElcrqzWD1ox3WVn2aNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nFU053e0; arc=fail smtp.client-ip=40.93.198.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=db/RBxs0JHZuS4P7tGDVApgIBC5sX0m0LGlmqnKE5yX89bPIDgtwPvAbe0gl6K0pXsfGKdONd5ulTKcur+iU1SZVyP4FBE+RfMSdIt4ukDukcdPtPlyyvR7xt0AAMPq+sxbdw+7zD+B5tRDBveAZgxiSCz9mjIdTr/l0D9WDllOg8EcwEKLLxeNuk/JYOyqB32ksNOfrbHgIwkY0/O8pPjR1ojD4GLAy7/zqwBOKeVMXMAkcy6ZWDiv0RrC89oMpMYxCW9EWIgZULaGjqDal/Fxs2sa4dMgJ6ylnUm4D3HiPzZ6mrro+zRTy4mcHX7qyKd2LACVtIRIZFzSTPNHdPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0R85HmgF5/RK0ICZu+Oi84l4vnwvcfroZXzvMXMzbs=;
 b=WKcvFgR5C1GON4TDHo1CYkUEk7W7r++LOKe//J7usR4tjjZdt00J2pBZlUEpyNYC/ZiNlOGWTqoXhMk8BC+A07Y19SVWqXOJdoMDvri73C+ZenvL0oajbDtwF3YyczAbU6+7VDz9vnYj09V7qqa+GHDL64vARKXyvhkRtXE66RtBmfgjjFHvWni/rIaRJqaFLH8FuL0SQopMI6iZZ5QHDb2z3iDhigP5AzycEacpy+C+gnJe9hwQUBWaX2B7BnJiuvb4gnboxwcH8rUD05/hpx1Sr8rXavjlbLdKMJG9EW+90KC8mcwRpvFi2GhC/wfQcM8LWvfN2CmVtY421uXyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0R85HmgF5/RK0ICZu+Oi84l4vnwvcfroZXzvMXMzbs=;
 b=nFU053e0tfTUGilUVRSYdkUYjT8VQYPShjIvuXtNs7EREQckCwuX78SNLjCXh56cpbmFqAzk/wK3VKd/9szmoT8bP5e16oQKoEetEFKssRmuuVvLepSSH8j4Fs+QSIf5vulgnar63FwOwKboahbTETo8hKG3OR8t0vIcScbXBq8=
Received: from BL0PR02CA0068.namprd02.prod.outlook.com (2603:10b6:207:3d::45)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 23:56:24 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::2d) by BL0PR02CA0068.outlook.office365.com
 (2603:10b6:207:3d::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 23:56:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 23:56:23 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Oct
 2025 16:56:21 -0700
From: Babu Moger <babu.moger@amd.com>
To: <tony.luck@intel.com>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <corbet@lwn.net>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<babu.moger@amd.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rdunlap@infradead.org>,
	<pmladek@suse.com>, <kees@kernel.org>, <arnd@arndb.de>, <fvdl@google.com>,
	<seanjc@google.com>, <pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<thomas.lendacky@amd.com>, <sohil.mehta@intel.com>, <jarkko@kernel.org>,
	<chang.seok.bae@intel.com>, <ebiggers@google.com>,
	<elena.reshetova@intel.com>, <ak@linux.intel.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>
Subject: [PATCH v10 07/10] fs/resctrl: Introduce interface to display io_alloc CBMs
Date: Tue, 21 Oct 2025 18:54:50 -0500
Message-ID: <7aecf0ce36527b9c3b8b121272cb140a4fbf5658.1761090860.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1761090859.git.babu.moger@amd.com>
References: <cover.1761090859.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: caf6f80f-696a-4a2e-22c9-08de10fd70e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?st+Y+PtXpNcQNVOi860q0VKBY+gElnnQIKSTRxty5EyQJbO91zoUHbzGqVDS?=
 =?us-ascii?Q?04czyOnT0IBPqAaaI1Pcic3Xc5IJYfq+6r20+Ws4JF7nyCJmqDVr+dfG36Wc?=
 =?us-ascii?Q?mjPY4E37k8WFsVGzqbvJStRyoqk4u4X5V+rYdxNtyDpLOQdSuR1uZ3RA7ZFF?=
 =?us-ascii?Q?nRBVQTCvIn/Fe0g6YokUAeAY/3La0etVoRIvIfZ1MIgSUyE/dgnpLdy51J8g?=
 =?us-ascii?Q?cSvSQTCN+pmqYIl9bP8f95YS1xUhuCG+Ee4AMJjmXUKX9zaXakAViPvfrri+?=
 =?us-ascii?Q?cFlDzOpWwxGti7U4iieK+OcBrkN+O//WYyyqLDvuNawQ6IhmnEYl8NlzfhR/?=
 =?us-ascii?Q?+F6Ot9kZcB25AwxDR6u2N1/f5BVvh32sxTJ6HvDu17SKYnC11lFlOxtQJVdn?=
 =?us-ascii?Q?yVGONy/N9jq0mG/7i7dDkXp58sr+nlPosVXVzm+nN63VSb6ooN5C0lv3RlUC?=
 =?us-ascii?Q?amD+t0A5Apk9i8pyjJOj3BnZ5XEcJmHeO1HVhOFV15AL/cXev+zQnX0zNQ2o?=
 =?us-ascii?Q?pyQT2tl7kmSvm7T3PNaZVchFYd4x93nAgZwjCShPNQdmKfZz/61itx1s/XBe?=
 =?us-ascii?Q?nr0ZJXNiB/fxP2H2yfwJe1aLB1nMdB7R5MYpJk2FbF67Q//3bwUCJc/GrXDd?=
 =?us-ascii?Q?xTnlgQBDr/4NYIRcHG+vJHaoB5BSDIDfV6f1WD5ndw2TRc4PTnENkZ0yNfph?=
 =?us-ascii?Q?mS86Np3iz1gobbozlq+3PEWzE7qdLD+25DM69jHXCaQd7b8fkaeA0Lqio4Ji?=
 =?us-ascii?Q?Q/KIt0DPALkffoWhvsvrISKCQYmLTGeZl4xMKsIUPB2XZrQVhOrNdBiWX8Dc?=
 =?us-ascii?Q?WcUk9poILEKJzd4l2UAVXfeIdPRXewP4b0BP/eu/GeDENS+EMyNF0pN1CHh/?=
 =?us-ascii?Q?jRjPlG7amICU2Dkoju77EXpb5tyD/QfIycZq4s2waTM91xe3pSCprsCuPI8E?=
 =?us-ascii?Q?jefa69QS2mNEbKPF+1Wg77H+d3XS03hYov1QnK4v3CjCEZQH2M7DF4k3M/oI?=
 =?us-ascii?Q?VnvojY//u91O/PsAmsatYcnAO6GeHDJkEPtVrfNW5vqwFB6FmOfcmJPZNQQ1?=
 =?us-ascii?Q?cKOh0TVOyfAjUoCVeJvfeJBUGsr9D//QAnVIGjhJ9p8jkkE7QSWTO24rOSNf?=
 =?us-ascii?Q?ZckfkVoMkcQjl4smrJv4RGjsclA91hex/0Y8WAyfDXl6fEHyoxHsitTe9ulM?=
 =?us-ascii?Q?Ea/x4tKsBw3xiOAl5czrFLKVwk8iuMmEiqsoRzH3KsUhX6cYv8FRUQPOFg1t?=
 =?us-ascii?Q?T2CKX0tIS2QQ5b0FQjSfXFr5fuNtKvg5N4SGN8V3JRCD3hF8j0smw6hUV3TI?=
 =?us-ascii?Q?DE6/bJzFqFQ4n4ym4N6wVaBnoji45JnSqyv40Rtl7xvG3MhqGLtInKbeMAuG?=
 =?us-ascii?Q?Is6iO+gQdlAfMj8D52VyxXUAFaNr7mJv/ndTmG3IAald7yi7zO09WiDQMCz6?=
 =?us-ascii?Q?qBme3U7YdvEiZLxDEnyBotpN8HweIcfqt9KWmVhinxq5E+ot3H2AdMbtLGix?=
 =?us-ascii?Q?wR7XUS97QRmA6EIHbAI0ygwZX8CwGmlJc3Qr6e+IYBmoOAc63b57AS7RRTQK?=
 =?us-ascii?Q?41W10C/WzYjKeab60/8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 23:56:23.9709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caf6f80f-696a-4a2e-22c9-08de10fd70e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867

Introduce the "io_alloc_cbm" resctrl file to display the capacity bitmasks
(CBMs) that represent the portions of each cache instance allocated
for I/O traffic on a cache resource that supports the "io_alloc" feature.

io_alloc_cbm resides in the info directory of a cache resource, for example,
/sys/fs/resctrl/info/L3/. Since the resource name is part of the path, it
is not necessary to display the resource name as done in the schemata file.

When CDP is enabled, io_alloc routes traffic using the highest CLOSID
associated with the CDP_CODE resource and that CLOSID becomes unusable for
the CDP_DATA resource. The highest CLOSID of CDP_CODE and CDP_DATA resources
will be kept in sync to ensure consistent user interface. In preparation for
this, access the CBMs for I/O traffic through highest CLOSID of either
CDP_CODE or CDP_DATA resource.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v10: Rephrase of changelog.
     Minor code comment change.

v9: Updated the changelog with respect to CDP.
    Added code comment in resctrl_io_alloc_cbm_show().

v8: Updated the changelog.
    Moved resctrl_io_alloc_cbm_show() to fs/resctrl/ctrlmondata.c.
    show_doms is remains static with this change.

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
 Documentation/filesystems/resctrl.rst | 19 +++++++++++
 fs/resctrl/ctrlmondata.c              | 45 +++++++++++++++++++++++++--
 fs/resctrl/internal.h                 |  3 ++
 fs/resctrl/rdtgroup.c                 | 11 ++++++-
 4 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index 89e856e6892c..1826120ab5d5 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -175,6 +175,25 @@ related to allocation:
 		available for general (CPU) cache allocation for both the CDP_CODE
 		and CDP_DATA resources.
 
+"io_alloc_cbm":
+		Capacity bitmasks that describe the portions of cache instances to
+		which I/O traffic from supported I/O devices are routed when "io_alloc"
+		is enabled.
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
+		When CDP is enabled "io_alloc_cbm" associated with the CDP_DATA and CDP_CODE
+		resources may reflect the same values. For example, values read from and
+		written to /sys/fs/resctrl/info/L3DATA/io_alloc_cbm may be reflected by
+		/sys/fs/resctrl/info/L3CODE/io_alloc_cbm and vice versa.
+
 Memory bandwidth(MB) subdirectory contains the following files
 with respect to allocation:
 
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index bdec06bcf3e3..b4cfa55aa9f3 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -381,7 +381,8 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
-static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int closid)
+static void show_doms(struct seq_file *s, struct resctrl_schema *schema,
+		      char *resource_name, int closid)
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
@@ -819,3 +821,40 @@ ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
 
 	return ret ?: nbytes;
 }
+
+int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
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
+	/*
+	 * When CDP is enabled, the CBMs of the highest CLOSID of CDP_CODE and
+	 * CDP_DATA are kept in sync. As a result, the io_alloc CBMs shown for
+	 * either CDP resource are identical and accurately represent the CBMs
+	 * used for I/O.
+	 */
+	show_doms(seq, s, NULL, resctrl_io_alloc_closid(r));
+
+out_unlock:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+	return ret;
+}
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 26ab8f9b30d8..a28cc2541475 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -437,6 +437,9 @@ enum resctrl_conf_type resctrl_peer_type(enum resctrl_conf_type my_type);
 ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
 			       size_t nbytes, loff_t off);
 
+int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
+			      void *v);
+
 const char *rdtgroup_name_by_closid(int closid);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 5dec581336dd..8f40c4a078dd 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1971,6 +1971,12 @@ static struct rftype res_common_files[] = {
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
@@ -2171,9 +2177,12 @@ static void io_alloc_init(void)
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


