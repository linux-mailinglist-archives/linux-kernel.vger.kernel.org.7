Return-Path: <linux-kernel+bounces-878777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D0DC216DB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E26CB34FFDF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C712E368F3D;
	Thu, 30 Oct 2025 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FOTkV+bI"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4FD32C938;
	Thu, 30 Oct 2025 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844617; cv=fail; b=MqzvBxRhOma3x1kLG1KZJFM3e8zWcJx95iOrNyasMdbqFTx8omJwko8GxUbOc/TcwHk29qY6dNIkLa3GJnUNWQAwSYxLn3qCslvmS+yFsXshmTKqAyJD518atEzSizM8adJNteCt4DhcKXcWnFOymCT6D0dcTN1oPNMZaweuDv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844617; c=relaxed/simple;
	bh=A1J/PZ59TA1eus7FC1K8YPaop5E6IymAoz+xOqcSM3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXw3fBHW5xuZgJc9i+4ksAmGiTLnelDHtUO/lv22QWA6y02RDAElvlusvUgx6GPpHt8zMSL0CqB2cdmJcSZkc7DrV/P7AAE5GfZHeB8b/wn1XM0+JPh05eDV8/FifGUwIqgQnThwTaYs2Vt7JY3Ob3/5wyiECcdqcgG3sLuGgYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FOTkV+bI; arc=fail smtp.client-ip=52.101.85.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jI5CEE36Wz8zjQFRGXnb61rfUXlHdLI5+q9by3iEymlxa6fMyBn/3oX0G868xJXxKaTkwLXilLUstN5ljMHjXC9Gis+OYhd19aQ28bk9a6WOjR8AI9qDVXfPb7Hem27wU6QmdmNaUcx7ox8gqrPNLrrz4OxVo5BGeUDZ3XSTaWYzuuDPqPX1jRPpDkKE/YwlHGzL8JQOcGuJANwfe3HI2CNCqYf0sgKQeaPm3qs8cdEfGErdnQiP3SOMULjrO9Pam5NLBYZHNu3YkI/TNg5A04kBJZyYv0XIlaYqpuBmkmyASiwTMy8zgJaV7BP/3dgG0luK6i8MDSOBzQiLgAt7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWVkINCq4A/qoM0SBqK6n3/ktmTcDQ+fMPZHv+62cHc=;
 b=yXMyC5tnDam07x6qVkoUzcQ9FKd1g8E0wGLOr8StRwLxcmUDKYZMfAhuHEKmbNI3+hwNBg2tEZYYo94o0soPcpKxICqlYkhGxtNKaHTXFBBykI1wOxPDgHgWrJvTmnYUSU9Ro2OJk0mLujjPP8d4qS/JiDXmYi+G+6otRazcWfTDYrnAocfzoOCRs5C5SgndMgLRb2bmSw76IZckZdgvet7rRFqmOTy0JDJ1UjMZVInV/+Pn2ijjrmjBXEfDensY3NlC0v3hs+CP9gQ9GraV6Ofzneg92PhztzmX8FmIcQjKfCR2IU9EhBKpdfjL7wXxKs/7NC8kAnC3qDMDoHVLEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWVkINCq4A/qoM0SBqK6n3/ktmTcDQ+fMPZHv+62cHc=;
 b=FOTkV+bIv1mm9XleiF0tAJp4J/FNgZtkYRhPwp+tQHBfJZQ6YopJBFwmWnEFRKUlarda3zUmLrd9soelyb9FPVSFSsMMhfJaA9s3oSlan10D3oc0+K2judlR8jV2rhNzqyy4qZrMI5snJh/yFbEfWC1XPdxHz3D+inx7kG8AMbU=
Received: from MN0P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::26)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 17:16:51 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::20) by MN0P221CA0002.outlook.office365.com
 (2603:10b6:208:52a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 17:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 17:16:51 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 10:16:49 -0700
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
	<peternewman@google.com>, <feng.tang@linux.alibaba.com>
Subject: [PATCH v11 07/10] fs/resctrl: Introduce interface to display io_alloc CBMs
Date: Thu, 30 Oct 2025 12:15:36 -0500
Message-ID: <c33a9f13bd04d0a5c143fb137676ffbc7430f8bd.1761844489.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1761844489.git.babu.moger@amd.com>
References: <cover.1761844489.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e5ffce-b6b8-47c8-2080-08de17d81dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c8ccFeE5Op4aItWnUUNThLD68IcES3u+aDmAhfGmnHd9h4KyQyqzUxpo8SWX?=
 =?us-ascii?Q?sEhu+fLDtMuzACtGhmDW5mFssONyWq3JwkDTcSdHgLvNI0eUwZW4lRE98ayz?=
 =?us-ascii?Q?uOVv0jDq/wWD3YrNuvCWkGJFtZxdpanO7V3e7IKI3/uK2HdLSb+dwu4xSVlR?=
 =?us-ascii?Q?cyH70F8DRWT2SHhZdg1JkRohTC/eTIQ6Hii1uTQnhAmuWTG0oG0dsbELl+X1?=
 =?us-ascii?Q?g0qc64dcMRrTURMoA+bwYSdH1QvDrZCSvC1aais6jibBvD7mJyL9T0MGplEl?=
 =?us-ascii?Q?21RteUw409HeEEvayrDd51MKb4wGI1bZpyiQUFh8kWgyBeaUlAMvV1YDt+xi?=
 =?us-ascii?Q?/3yLUWOHkVui4IQa4JcLhHQd1TgKV5ZbFMYg9OY1oO0YjdS4jJTrk3ILsMYz?=
 =?us-ascii?Q?LbjbKuA9iHOIu14MIoys3L6JGERETkV0MJr7LiBhpIOawt4ChXSRUmkVgpkE?=
 =?us-ascii?Q?SrEOtHcUC5u5nIcgLBA5zO3MczLAUKYNHO7G6/An1JJ1JSHFg5YOHUiIwgxG?=
 =?us-ascii?Q?9iaGWWI4mitF+/Evd0oJLvUt8kklCeQLH/HNliHJFtlCbDX0m0hEOD7pAMWo?=
 =?us-ascii?Q?+ouvQxWqNPjCZVzBELRelc+tVhL3NLzsT3cCswM/O4MS9/dkFp8ck7NN4wGs?=
 =?us-ascii?Q?yNcMWiJPWS6a5OPSoYMYerCenFceeO6S+V6zfL3Nr2KDL9uaReSfFieP21Rd?=
 =?us-ascii?Q?ji88EFKwE/iJFH8YNlDZKwj2Pi/NpYESTuyN1aFuOMnTLTuc+GscaSFuOynp?=
 =?us-ascii?Q?MvpSN0v5YT9viapTh4OeHLgQM6RC685p219HqXl226aBRVga7SMpqWCrlgIS?=
 =?us-ascii?Q?tg2q+mrzzCBJAbojfe2FEB03kZHBMR5bTAeng1ZYQCa9G0RCl5KesDKb8ube?=
 =?us-ascii?Q?gP3CGcLoFKPYaDQuEz3gnMh9tacNk4lL+PFJ44KMcCuJX+2G4/KjuUNsY7hC?=
 =?us-ascii?Q?Upsfj53QWgHnoyitKtDdNud18x23EsfYS/FjpkCNpfVo02Ts45EJiQDKeLrX?=
 =?us-ascii?Q?Hut06QWkvpj6D7eMTnGaQFXsH6BpsHzc5DSb1dELN+EYb9f7ns3qk+yhW8Zq?=
 =?us-ascii?Q?zq0TF1YjhztK6wqn2xKcxXUJuQU01HArbv0obVwdgQVdA8lyme7pepRkhiiS?=
 =?us-ascii?Q?opRZbUNILeACgUli4hSahWD8x7YMjRa7Qw3SNZJ8oYRfV3BvHUtoOvHxg+Ms?=
 =?us-ascii?Q?8chv7NzMyaigz4X8Xvavh1Un+4T/pUXsHYWa+GBjNvtIAgsQo4pbfO7He28w?=
 =?us-ascii?Q?OM8HeuXz1x8majzCHadpMsvNMfh5IWegsrFLuhSNx+gk+q3T75AgP119jHLP?=
 =?us-ascii?Q?Dq8aVdMxHIyRShz8zCPdZ/ebGRP2gsgp+3ZYPbqvPKba81W3WDTBzIo9Z69h?=
 =?us-ascii?Q?TksS6FWxcSwhxEWr1UFRd3El35PX0a3dnyPll2NfB2+flQjgfpEBaLmcg2Gm?=
 =?us-ascii?Q?oUNGmDvdpyyytNAoTtbYNg0ZikrQzpVvSTgPwAO5JcL1tvtHCCqpYjc4rhxu?=
 =?us-ascii?Q?z4CsYfgwLr0EEP+U21OBVOWFGf9WoPWp1ol5jTyGl6HkH+18ZoO65lZk9Zyg?=
 =?us-ascii?Q?1TaEUKHPo60lEyQzgf4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:16:51.5014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e5ffce-b6b8-47c8-2080-08de17d81dea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v11: Fixed the minor conflict due to previous patch.
     Added Reviewed-by: tag.

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
 fs/resctrl/internal.h                 |  2 ++
 fs/resctrl/rdtgroup.c                 | 11 ++++++-
 4 files changed, 73 insertions(+), 4 deletions(-)

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
index 454fdf3b9f3c..1ac89b107e6f 100644
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
@@ -823,3 +825,40 @@ ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
 
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
index 145e22f9a350..779a575e0828 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -438,6 +438,8 @@ ssize_t resctrl_io_alloc_write(struct kernfs_open_file *of, char *buf,
 			       size_t nbytes, loff_t off);
 
 const char *rdtgroup_name_by_closid(u32 closid);
+int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
+			      void *v);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 95d47b4b6505..44d419e4e63c 100644
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


