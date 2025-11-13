Return-Path: <linux-kernel+bounces-898403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20017C5534D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23C774F142A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F267F184524;
	Thu, 13 Nov 2025 00:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xkGh9ZhJ"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013045.outbound.protection.outlook.com [40.93.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF6156678;
	Thu, 13 Nov 2025 00:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762995564; cv=fail; b=ahE5qzfUedgtgOiCbb2eE4ebyDbmBelxV9ZvjiwmnkB7NicQyR2E5C5EYXmta+l8F76KTCbX1L/CSFd0Azk56EBaPlom4fQMmYcWoBrZrGn6xh3Fc2v4zy2lZ2B+qsAkT2B85g5nshLv2tNFN+LyQGzN4OiiAGdWPIjfjMWNNT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762995564; c=relaxed/simple;
	bh=xJHwg6UcAG25FYhIgQQaqv5g9AQ92XcZqqUmTlIyTHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwCQanie7VtfcNebIH4YQuk6Px+KcBDSe5zHIUpJyBjJzidLbAPSivUxn85frFiaTX1LcNJtKJo0hhdAerlt+hMfbXSpzVI/cgKAgCF4t1vmOoKttBc7mUOlScSzCIsvifY0f82qdamNpwRFjeSSLR9Fgs05F5Ix7Jn3PKEJL8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xkGh9ZhJ; arc=fail smtp.client-ip=40.93.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FB0nNewh9JxNEWb1ithTkB9USYwFVSg93niePy0jkkf59w5y/LST6mv8mlpFbyMN5XBjxITdKklY2RsH+o2cFJFkbgauJlzoxL+EaaLGUvzqmyYQ3pNNjQffZh7XIRNgEgm1nKmGqA1/nPEaiJuhAQkw11hwSmQrVEEZJvhJ0HmE5Ic5Dyyb28Z1vEIDe1rXF+fwVW/ZafLbP8hytCIdzmWosZMBGrwBN1Caxmb+cB5vNftJ5U8WG+kPvttIDoiJw0m0NBbhasc1D+SfHbK+4gWNjwfxY+9HZ3RpCBQKe5+WmCrpL2sIuyiSjkJux4avV8BiGJ4v8napC2b1Wa9r+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEjn3uj1YCJtCKGvEgA1V3p6U78ugcZcPGq/9fVSitw=;
 b=kgpSDqnhSt2STHB3rlzU8mru14LQgpAm6EgA8rsBRN/7/+WWbd7uz/4HoGAtLe8QJ760TawkoLx1h3yppsRN9OR4yeO8g7XvM9JGybQ+lEp7eWi2BMhes19BNJ8oHQMyOISCS0IIo1bbYoEQVeCC/YLNVROg6dLGWaNUBu7/Q7+ol8nPU5aeRHDOjGalmD5qXb1tGSfOQjkkvzF9+gnqOS/vd7yNHecJoYlySgKh606cjpy5rilhxldhXoPOr3GmOiF7c14IAkDyV+lXA1yUb44Ue5e1Fp8X3ye0QYzFZ+693aGKd2fdwJ8KWJywElfAkex1uCOpwKgg5r0xe2Yb9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEjn3uj1YCJtCKGvEgA1V3p6U78ugcZcPGq/9fVSitw=;
 b=xkGh9ZhJvXBvH+Q7x4n//2B/W+KGJ7SWIjKDychkcdLcjTx9mmW4WLK0wvjDiJ1+ridWDzE77f9h5DxNyEymv83QsZNW9oqY8XfmT2OVwzSLtFtaFR/3aRz48pCmMzdriaW4h6aNxiZHfv7Y3RC0UxU7Zc4XjQvYQ96I8/WhTK8=
Received: from CH0PR03CA0431.namprd03.prod.outlook.com (2603:10b6:610:10e::22)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 00:59:16 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::2d) by CH0PR03CA0431.outlook.office365.com
 (2603:10b6:610:10e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 00:59:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 00:59:16 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 16:59:15 -0800
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
Subject: [PATCH v12 10/10] fs/resctrl: Update bit_usage to reflect io_alloc
Date: Wed, 12 Nov 2025 18:57:36 -0600
Message-ID: <e02a0d424129fd7f3e45822a559b1c614ae4652a.1762995456.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1762995456.git.babu.moger@amd.com>
References: <cover.1762995456.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|LV8PR12MB9229:EE_
X-MS-Office365-Filtering-Correlation-Id: e4839909-15f5-44c2-222d-08de224fdeb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?siYphtL5Dk4+7VKUoPalqxQAOcUDKxwyQUqYRQ5YGWzzFmCNzN9OLfDzo5Lr?=
 =?us-ascii?Q?AUl7RwaGOE4dJjy2PbB7OxLwcONsxe2FXhwrDRFHd5WLUHlKc/RnP13pkzq5?=
 =?us-ascii?Q?TwUsT+CONIf2OR/PqFltTPETLDdqx3YPQvubpk0Rv0hvWer8OUdVkjfvEQBi?=
 =?us-ascii?Q?I7gaQJqoe7TtxIMpsX5b/wMsWV3hyfONmaOtar2P6n6oEPlBQutSjHIQb2Rn?=
 =?us-ascii?Q?Lr6W0slCfsdul76cluoihrrWGRhAEVp5klZ3K9RYWxnXchzzOI0ZzawsFCb8?=
 =?us-ascii?Q?iBlx558DW72NpBs21rk9AbLkPzPOFQIjFoJVZHfh2ShV3CPwg/VLUWa4AkY6?=
 =?us-ascii?Q?+bDNvtImeJWF5mjKdgdZYTrjsR+ccRytUOkIMpXZSlj8qjb9aVeC0jZGwBJC?=
 =?us-ascii?Q?MLZMGfSwaxNrsfFMIKh38QxXVfUJ4xcvPzW0OP6NBecxoC8yE1eVuAGG2rNp?=
 =?us-ascii?Q?OemRj71gpe2O2j/1I3IulaeMTXw9M0FYlPGbf+BGLdLDPORZsTDKFhybbLsi?=
 =?us-ascii?Q?A5TLfYQ8IZZBySHSvtaM0kLM8JQebdrOwNT3LPWonQ2By7ZV2rKYOauNM40Z?=
 =?us-ascii?Q?bpKTEJQI+rFCA+NpdK8pXN+qQM8YEGCJaphSMwHK/meZg+UfZqguf66ayT/Z?=
 =?us-ascii?Q?HtuJlR+LWqrVysDm2l85Hy4tgYeXVtclTH45WRmSnyP8m2bA28ep9HpBEKOW?=
 =?us-ascii?Q?VZkMA/oCdUS3cdHoe+/DuJxI+NRmVHIVf6P70AeC1VE+nbgd1N3GldWUO6Ae?=
 =?us-ascii?Q?2t3Hto0/754Am1v7W6CVCADrFkHsZSZMehz+8FmNDKiVZiUfoFoD7Kb9oIwt?=
 =?us-ascii?Q?H5hVHdDYlOlrKPk7ozjmcaDQiSNi0pRYEFzwg3w9Up9NQbpMW7ZmQgzoQ0SE?=
 =?us-ascii?Q?FXeCAOTgbWmrGN6TOhKLXxM997w2hfxCq4Q0du2KsBdfhEdLBmZCuqNeZmOF?=
 =?us-ascii?Q?0bj6mcmVXkIMJnSTl7R5cDShJk9G3MryxsBW8fNxH3X8FslLS4h754IEGCQ8?=
 =?us-ascii?Q?YuZWmG0qRHNNVmqojzAQMmKZzFGAmVMKXXIoZ68lnp2zM6C0+oJrOwwX45HV?=
 =?us-ascii?Q?OQUJG+OjNFBkFFCE/ifjOBElcryCnIvWPcZRkrtA3H5ID226f9ZpA/FCJsPc?=
 =?us-ascii?Q?oIlwJ+OGR6JCpUXIPSDmjIiLrSL2LB3PJ4iubvhDEB96bWN+k1itzws43zUL?=
 =?us-ascii?Q?CF7YiTFcLzDWmSGuKggKUE84iRQb7jpYqlyhuEb/iLAleP2TGieBxTzRD8gn?=
 =?us-ascii?Q?Kgf8r4mBg1/aIJlIl5ifg0M586YXsCoKLEDmXVdwSXWOeDS03j3iQ231lWQs?=
 =?us-ascii?Q?yvE4OX31pAesBT6pgrfiUiEJVPqYM4nsvJlEy+easByeYsqDE2NHIktnfeGb?=
 =?us-ascii?Q?hOKCHh62kwMzRmC9G4P324n3V4VQ65G/yksZF8V9sQ7eD0KdaYx7x7sBt3Bi?=
 =?us-ascii?Q?CDmdfxo7MHny/hgeDpe2E4+9nDw/UHctBcNetSxX/yIadnPMMsVK5Vxlv+nf?=
 =?us-ascii?Q?wED6KznlOBJYqzMmHujTQxcMM3vjtr/5RBbcM0U3v3Byq1/qj+QM0TwIxSg5?=
 =?us-ascii?Q?ta540w7x21hieGq1cnU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 00:59:16.6558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4839909-15f5-44c2-222d-08de224fdeb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229

The "shareable_bits" and "bit_usage" resctrl files associated with cache
resources give insight into how instances of a cache is used.

Update the annotated capacity bitmasks displayed by "bit_usage" to include the
cache portions allocated for I/O via the "io_alloc" feature. "shareable_bits"
is a global bitmask of shareable cache with I/O and can thus not present the
per-domain I/O allocations possible with the "io_alloc" feature. Revise the
"shareable_bits" documentation to direct users to "bit_usage" for accurate
cache usage information.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v12: No changes.

v11: Fixed the minor conflict in internal.h.
     Added Reviewed-by tag.

v10: Changelog update.
     Updated schematas to schemata.

v9: Changelog update.
    Added code comments about CDP.
    Updated the "bit_usage" section of resctrl.rst for io_alloc.

v8: Moved the patch to last after all the concepts are initialized.
    Updated user doc resctrl.rst.
    Simplified the CDT check  in rdt_bit_usage_show() as CDP_DATA and CDP_CODE
    are in sync with io_alloc enabled.

v7: New patch split from earlier patch #5.
    Added resctrl_io_alloc_closid() to return max COSID.
---
 Documentation/filesystems/resctrl.rst | 35 ++++++++++++++++-----------
 fs/resctrl/ctrlmondata.c              |  2 +-
 fs/resctrl/internal.h                 |  1 +
 fs/resctrl/rdtgroup.c                 | 21 ++++++++++++++--
 4 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index bbc4b6cbb71d..8c8ce678148a 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -96,12 +96,19 @@ related to allocation:
 		must be set when writing a mask.
 
 "shareable_bits":
-		Bitmask of shareable resource with other executing
-		entities (e.g. I/O). User can use this when
-		setting up exclusive cache partitions. Note that
-		some platforms support devices that have their
-		own settings for cache use which can over-ride
-		these bits.
+		Bitmask of shareable resource with other executing entities
+		(e.g. I/O). Applies to all instances of this resource. User
+		can use this when setting up exclusive cache partitions.
+		Note that some platforms support devices that have their
+		own settings for cache use which can over-ride these bits.
+
+		When "io_alloc" is enabled, a portion of each cache instance can
+		be configured for shared use between hardware and software.
+		"bit_usage" should be used to see which portions of each cache
+		instance is configured for hardware use via "io_alloc" feature
+		because every cache instance can have its "io_alloc" bitmask
+		configured independently via "io_alloc_cbm".
+
 "bit_usage":
 		Annotated capacity bitmasks showing how all
 		instances of the resource are used. The legend is:
@@ -115,16 +122,16 @@ related to allocation:
 			"H":
 			      Corresponding region is used by hardware only
 			      but available for software use. If a resource
-			      has bits set in "shareable_bits" but not all
-			      of these bits appear in the resource groups'
-			      schematas then the bits appearing in
-			      "shareable_bits" but no resource group will
-			      be marked as "H".
+			      has bits set in "shareable_bits" or "io_alloc_cbm"
+			      but not all of these bits appear in the resource
+			      groups' schemata then the bits appearing in
+			      "shareable_bits" or "io_alloc_cbm" but no
+			      resource group will be marked as "H".
 			"X":
 			      Corresponding region is available for sharing and
-			      used by hardware and software. These are the
-			      bits that appear in "shareable_bits" as
-			      well as a resource group's allocation.
+			      used by hardware and software. These are the bits
+			      that appear in "shareable_bits" or "io_alloc_cbm"
+			      as well as a resource group's allocation.
 			"S":
 			      Corresponding region is used by software
 			      and available for sharing.
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 332918fc961a..b2d178d3556e 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -750,7 +750,7 @@ static int resctrl_io_alloc_init_cbm(struct resctrl_schema *s, u32 closid)
  * resource. Note that if Code Data Prioritization (CDP) is enabled, the number
  * of available CLOSIDs is reduced by half.
  */
-static u32 resctrl_io_alloc_closid(struct rdt_resource *r)
+u32 resctrl_io_alloc_closid(struct rdt_resource *r)
 {
 	if (resctrl_arch_get_cdp_enabled(r->rid))
 		return resctrl_arch_get_num_closid(r) / 2  - 1;
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index e1eda74881a9..bff4a54ae333 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -442,6 +442,7 @@ int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of, struct seq_file *seq,
 			      void *v);
 ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
 				   size_t nbytes, loff_t off);
+u32 resctrl_io_alloc_closid(struct rdt_resource *r);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 3527bb8fa2ff..ea320dcf8aba 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1062,15 +1062,17 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
-	hw_shareable = r->cache.shareable_bits;
 	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
 		if (sep)
 			seq_putc(seq, ';');
+		hw_shareable = r->cache.shareable_bits;
 		sw_shareable = 0;
 		exclusive = 0;
 		seq_printf(seq, "%d=", dom->hdr.id);
 		for (i = 0; i < closids_supported(); i++) {
-			if (!closid_allocated(i))
+			if (!closid_allocated(i) ||
+			    (resctrl_arch_get_io_alloc_enabled(r) &&
+			     i == resctrl_io_alloc_closid(r)))
 				continue;
 			ctrl_val = resctrl_arch_get_config(r, dom, i,
 							   s->conf_type);
@@ -1098,6 +1100,21 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 				break;
 			}
 		}
+
+		/*
+		 * When the "io_alloc" feature is enabled, a portion of the cache
+		 * is configured for shared use between hardware and software.
+		 * Also, when CDP is enabled the CBMs of CDP_CODE and CDP_DATA
+		 * resources are kept in sync. So, the CBMs for "io_alloc" can
+		 * be accessed through either resource.
+		 */
+		if (resctrl_arch_get_io_alloc_enabled(r)) {
+			ctrl_val = resctrl_arch_get_config(r, dom,
+							   resctrl_io_alloc_closid(r),
+							   s->conf_type);
+			hw_shareable |= ctrl_val;
+		}
+
 		for (i = r->cache.cbm_len - 1; i >= 0; i--) {
 			pseudo_locked = dom->plr ? dom->plr->cbm : 0;
 			hwb = test_bit(i, &hw_shareable);
-- 
2.34.1


