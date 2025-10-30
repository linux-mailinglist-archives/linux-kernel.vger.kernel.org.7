Return-Path: <linux-kernel+bounces-878780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E8DC21759
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09CDB4F2109
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206B83683B4;
	Thu, 30 Oct 2025 17:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Si8bUr3b"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA3369964;
	Thu, 30 Oct 2025 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844646; cv=fail; b=FsSVEjWw4rele0ZbAv46vGcWYj9OzYkMsW70IzjepglG666PrDUE5NfIOfxlAC++Do274Zyq1ADJFCzWHnTv3IrreMwdTyylKKuEwu3fyHrXBkv4futYX24RTtigiicov9cSw83TIQN9Xo7aW8YBzYp4c1uVLehRbmndywGCtgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844646; c=relaxed/simple;
	bh=e1qhdwiMc91quJJVZM30LJxNTevPsgKn8OWLYyvZqBY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCwJ+zMhh1ek6PQB1N/ScGFKcedtZ0+Ogux3/hSdHR+5AS2zkqKvJvRDUpTG6Ec9w6Pf1iQ2u11UlhLqSwiyXbaE2LILwER8IQ3JYJhui6c/gsjn/badU53ncesb2PU4Vgoq7LHN4GR0ncSNKxRxNJvZZDn1VgZHSZDiduzY0zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Si8bUr3b; arc=fail smtp.client-ip=40.93.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhx6kr63u9U6oCc/uK5wBPAZ2RmHjnPhJOfQ/Z1+LFkRS4y8elFlk1NBFeAUN+yup/9u5cenoRZ1NmlnTsHW3HQmQ+Q2AotaP7ptEOMZceX3UMsqvWmVpd4Brj9N6q2FMgdLGtTRO2JfQsK/HnsxVeFOqiRko04CnkBBrUfmlZmkde/hS5lCCqxhGFy4ZDZam8DKoMfxK8RxFMZhQ9hJpyPXJbzOe7r2lK94vsCd5c7mNqgXMExynoT1bQz1eWGsLPWrBQzjCeCHQF/hWWTvZf0xUdjpJeL06ASiv5iz97myH2A+1HNvV3T+6mBA+pYk2m/DhZlFDZK5wyVMJqsKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5Z3bPYBithQBoZ8uO/duc6mHxaZjz92KIEKGlGP1dQ=;
 b=kDAPJSyP6zFpY2kXvgiuVhWs0RDFxhlqrYqalxqtJsVC7q1QoDFSuNRXG31xvoU1qcIVg5+RfXskX+mB4fZSlKQgEi+GdV8B4HInz91FTQnaBfV4pDbpCLELnsE+ErUKeEIUyYRTeYmjEFdlpWmcve/SEYEVtk1EEGCYJZCkE5RlOF7AADIf8CDfjiHdO2fjCM7lVsAku5B3VF6wp/rO45voEYwvhiRaqkRkNPFb8IpVF/uVkbpxdBvWfCy/1edCSWogX/wLKKxUVZ25NE/tXSaYYbLRUviqDG2ZCdw9oGlF44etwIGS4D8p/oE1Zs7bMX0Qu0CZQkqOgkKdkweY/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5Z3bPYBithQBoZ8uO/duc6mHxaZjz92KIEKGlGP1dQ=;
 b=Si8bUr3bbEmekWabYwqGuXn2Zeef0mPvCXZuX2w2M9xb7aoNtMFUmyNHZW+OMDCBFt0H4t+hVtgftEo3T+I8qhTai9agsVWOzcQeab71PgzBphhix+p0UIA1nq2dxvYVfegHWYnrOCr0x6VpVAox8W+BjFZ1oMrYcTFJvb71LNY=
Received: from BN9PR03CA0966.namprd03.prod.outlook.com (2603:10b6:408:109::11)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 17:17:21 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::c1) by BN9PR03CA0966.outlook.office365.com
 (2603:10b6:408:109::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.16 via Frontend Transport; Thu,
 30 Oct 2025 17:17:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 17:17:20 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 10:17:18 -0700
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
Subject: [PATCH v11 10/10] fs/resctrl: Update bit_usage to reflect io_alloc
Date: Thu, 30 Oct 2025 12:15:39 -0500
Message-ID: <9fc558d6a5d66b6475daa71fc7b67b5c0c891384.1761844489.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: e95459ee-3bfd-446d-7bb4-08de17d82f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K34/trkRiqIRGz2E4cIkpDt8xVdK6y2dDB721b8denXmmDgnkvNOEGEmJKEm?=
 =?us-ascii?Q?7BhJ8Z1wKI8+FPvPMxDGOQ7eOV0EOM2IVaZ7+0GyayjQ257FvtSsrP4GAbLX?=
 =?us-ascii?Q?Zi5/s8HFt5iy8EcJFotJETAMK6LpB0znMsVX7Pij5OGhclBgXSJ/ve/Ar1Rz?=
 =?us-ascii?Q?UIOQYtOruW+AvCa+bWBA0EhPlwajaZ9ShBTD4LWo22TJm1q8/nlnMj+70Qa8?=
 =?us-ascii?Q?EtKqnKO+hRujcorOKlShNtuJv5CjPko59HRzo1h8tdyqROSwR1ZSOnJjX4gb?=
 =?us-ascii?Q?ScPPa0LLW9se51z3Yt3zIyEBoaZXiQVru4NK0fQMLOnC0S64k1rpLfG4FAZN?=
 =?us-ascii?Q?hrk4U39iSx3KUZ5QK8ICgrs+R1tDLUW4NbRRof/qYGhq2emzdFzRbViH9VBP?=
 =?us-ascii?Q?T2X8/mFUL9FSw/2drnQLSGWyNHP6i99iMitvN2HGoiVuBhetPo9YsGj7GRw9?=
 =?us-ascii?Q?po2HjCR2BW5SXpLrohl8vbngwQqEgJBUI3nZJa93jwpMtvnarGLekKm3e26z?=
 =?us-ascii?Q?EuYxgJmmOOimqja2p3FvzO1JpZXS8nBLdFqRXKbdWPLYqSvP8Dh6GuBq5Vd7?=
 =?us-ascii?Q?tBoh9YAvvaoAHcIVhaBLyQGdpyR4EwXtMMM3QI8xXKZI83dIdQN/rOmJLjnG?=
 =?us-ascii?Q?IdGiiiCMHo87qRKcphNhfcO+glHjPmIAm8XX/fr4carkcQZyfmGzxn8CBd+7?=
 =?us-ascii?Q?uD7XwuBoi5fTSIdJN8Dl9KhfCzYh1SmAGaix322DIBwgr+vT3kOXa7a/9C5F?=
 =?us-ascii?Q?MT3nd9XoIpIujZRcf3HJW3cJB+ilqjdAwPKeV+ubs4eefeBr+fxbsRAeO+UW?=
 =?us-ascii?Q?JgeHEOdO3FS3ILXMGvFYluTEj47gJ6msvip0npvxakhPj6DyGHia+Zbqfseh?=
 =?us-ascii?Q?6ABGBwnMsu1isEzbyjRdZcirnHL3FmEgKx52JnHP+MPOFiCFjp3SpE9aSj3n?=
 =?us-ascii?Q?gC+gfg87OC0OMDfi3Y8aBjF/yMZQFt2h9JlDrQV9qBa283wTL2LUIIyWlM9O?=
 =?us-ascii?Q?0yZADipxlDCk9lAS0rJMM8bPvyFrLWtuqpKVlUjYjALY1HikIB7ayqTg6jc4?=
 =?us-ascii?Q?C6xVIH2ND3jw6WobIbiz85Lf3a1RE7btnkU/c/776+Z7xry+W7r4guUcmQq3?=
 =?us-ascii?Q?50vS/nA22OaKsmUX0XtWhzRYMwWTdoaX4SkrFOY7Qk11DVa9PrU1OuDzFWi0?=
 =?us-ascii?Q?V3WmM7uZrnNURiXQHzWEGS8Fo/av/D4R1qySbpfBW76npJcPFSeQlUENAjR1?=
 =?us-ascii?Q?e8S8bXpEIslWD3McyPk4TK+hb93IveX/wTQz1JFMaZzPpYMYLyLQzrMGFYiB?=
 =?us-ascii?Q?YaexmCMSyovhSPENR6A9Uxcz07bbse5REwajAdI9PQTiTnNfYztq2Z40Tzi1?=
 =?us-ascii?Q?jBCKiFbFd099reHRxZVkjsZrLw2rUoTP71Zs8uKfrKPNiC74Xxv0WWbjaypx?=
 =?us-ascii?Q?hvTFfk62s37/yCxODRR47rjWjL0jecw/TiQlEs6uPo9FbixB1bmw93puiDSu?=
 =?us-ascii?Q?361hwJymovkRbN8MJrZmkkQcEu08/fMUy0iOQal8AMzL3ypkurXhKXNkWWVq?=
 =?us-ascii?Q?3QFCNoTPp2/5ThjOpso=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:17:20.6711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e95459ee-3bfd-446d-7bb4-08de17d82f4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

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
index dab4b430d3a3..ccc425b65b27 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -91,12 +91,19 @@ related to allocation:
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
@@ -110,16 +117,16 @@ related to allocation:
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


