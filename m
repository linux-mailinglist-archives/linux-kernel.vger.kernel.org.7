Return-Path: <linux-kernel+bounces-878767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B721CC216E8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 257964E84AB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412742D47F5;
	Thu, 30 Oct 2025 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h2dR3gJE"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFD1264F96;
	Thu, 30 Oct 2025 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844554; cv=fail; b=a6Pc4t3haOwUv4YnZvuNt5KSunK5kA7u7C8QRzZXGStTQRCgdGd6UgVBlcy5g9cQptYTZcVrfj9bZcgL7oIS4ZvVFWSosT/Cl47FkkKlRwT0aW5wAi5dz6ZEDrLbGSgLpQ9XUPxiuwxP/1ySU7MHQuin3DW/iOVfevhG1AKoBbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844554; c=relaxed/simple;
	bh=IANQPtiRLIgpuYj3g3GbtbvtKXtfskO2WfzLiKBLDA8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tNaQuA3lktrN016qcW1jISf7seWpdib071pJ1RXkNMNKpERzxe1sYDqH1z+x7lxT2+SmG4Q7F/3aU1TnUODOs9ryvWhvYJ5bM7Rd45TB6gdKhtiE7eU/YVZ1jvvxdLsYftKSZdYLuBHUziMjPeuHeKgWbH86v4+gsmjPlUAWj2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h2dR3gJE; arc=fail smtp.client-ip=52.101.85.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsyh7361N149zb3d9+sGr3ai6EN9EHutiw6aTYdMh6QcK+A//JZPE+6H0/Xg2USJxwd0+Oe6iloQIlDl4jcj8QM8Bicsgtl1SjjHdpZ+bemmGa+wMTjbi3KBuool19AGFG4i3KHhSFId/agBK9jrALWBNeKPboJsVVQg7ikAGtDRF3tbNPBN0HNoKKLiNoXTD0yExkmRXyHt7MbshYDo2kRGG9ztg++I5YZ3u+YWFP+OjnFYIkpRe5k7jLAVFpp4lQgsexWG37eQGRNxTgydLCDOqB2PAPkZy8gTPaBpz9wSb3xggpjgZ3sOXkiMJp71aU1k2GxpuiLbHCuT2vCgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vo1qY9qfixwqI/E596zqZ677YLSWB50aruQJoNRzHVk=;
 b=A81BMkzE6QJg58H2NLJVuSG3AHtsLB/Y+oWkQZH9bWRftgsr/uXYgdAgj1bV/xHVo+F/ZGHszo9AUq0So4iXC0oHxmp7wnMX4qCFb7u9rzljGY8WtOD28invwEERGQF4yjAgA9Z1xFeGLEqwAdIonW2bhts24onIoKnqIa1JroioxLwARFJRmWxmfMssfaM5oHhJFCpiiTqHNsq9uYlh0G//EzTpLDkk7hCUqUIB6tuKHFze2k3h6hU1MFvhlvKyJdKTlFTFKNjZg4nCWjtxeWoM9ZavpT5lozp474kw9v97NVqBcuLIfJO4A9ICu1MdAxIYrNYdJq97Mo4rd+RVGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vo1qY9qfixwqI/E596zqZ677YLSWB50aruQJoNRzHVk=;
 b=h2dR3gJEbbQtvgAYLKUHgVbwpDpPLdXR7HLvHSxwdw7mSo9V9dVCmIK1M9VEe7E4A+PLxOjRYhoE9PbzlOqkU0MBAx3/45eHd1bqhnwX9bJI56k7Gllqsql7h62ECFLSVPUWL9FGq3Hsv7tybKbNyz2kzjY1XF2B4shQQiETYuI=
Received: from BN9PR03CA0990.namprd03.prod.outlook.com (2603:10b6:408:109::35)
 by SA1PR12MB9248.namprd12.prod.outlook.com (2603:10b6:806:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 17:15:48 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::5d) by BN9PR03CA0990.outlook.office365.com
 (2603:10b6:408:109::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 17:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 17:15:47 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 10:15:44 -0700
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
Subject: [PATCH v11 00/10] x86,fs/resctrl: Support L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE)
Date: Thu, 30 Oct 2025 12:15:29 -0500
Message-ID: <cover.1761844489.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SA1PR12MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: c75d20ea-3cba-4fc5-7880-08de17d7f80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3YrUcrGvg6u8wnGPoqeYYwiCpjrEElJ2Wt12GCCZhNNOSBbplRLI0Ry2/d82?=
 =?us-ascii?Q?FyYnsW9JZwbL8jKUioGzO+PxXswyHSDGnYdYj0LRIIIglaWD5vGD7yz4LGVW?=
 =?us-ascii?Q?uUWRrz0LqFfS240FUqhLFpgSV87m7d0tpMIq+RUiihx0OJcD+mVUXB3Vv9ZN?=
 =?us-ascii?Q?Thm9+XSL6K+ZL7HA6KzNHxIN3csOX+IGLs/qo6jQqUreSTmKuQLK4LgkKFs/?=
 =?us-ascii?Q?G+ExkQhOSteVBa2P8Llmi5h/TqnkgSyKG8fjk88aQLbelRTrWyL5SS0kNgtz?=
 =?us-ascii?Q?CnWGSPduyF1rvJXPDrIt8dFC4ceZSIuIBPp1KGIHYZCSut9XNHiB22oYkF+o?=
 =?us-ascii?Q?Yx2THPYWkcPpbPLK9sdADfaOw2L5U30ypVBPBm/G1B3fV1ncZtIz0HEYRaGn?=
 =?us-ascii?Q?paOiFCeu6iJYyvCoS0pMTCQ7zfgmhTL3bG9ghKYHqRfOEZHH/Fc97uCFImLy?=
 =?us-ascii?Q?bKLXxaTYm5Jr/aPgZMYcWci4cJpXykuKo6s5nNdOQldNu5Lnmj1hVoB250fX?=
 =?us-ascii?Q?IHuPefUpbrFk0XYR2wsQHJeGB1KllW6t/SeGly1+SmH2VoWLF26Xmoo1aIE/?=
 =?us-ascii?Q?EG4I3azBH8/WJH2LNmCs8Imen0QW95cxdrBo/HvftAFpEHIDOD2/0ekFU65t?=
 =?us-ascii?Q?QsDpNUsntl/ebGcclATBctr3giuLeHKryBd7Wm8K1pTOX5Pt0rsIAxdGVbPl?=
 =?us-ascii?Q?rfqVZogOsZ+PdtwRNU1lWM74ZL4Y01iZzJIgfeHOhy5sk6Cs+sFb3e+19MX5?=
 =?us-ascii?Q?Fc1NinHUpQus4mj/sPNflDaUsfnBmrcZUAd84Sw85o/BidM4ZECDzDKAuDNY?=
 =?us-ascii?Q?xU55aCsphKIvB2P4GK8VpAYc/AeRBgsqFl9kK7erEsbqe8/P3fx0Ue/OPfS8?=
 =?us-ascii?Q?UMoo+j5/9ngLrpm5zyv2eN+Xb7R7z660ucNLPcmqL6VXFUxFAiTHj5Fwe4BG?=
 =?us-ascii?Q?hUfQpYw1N0Mctp4LhGoRAMPbWkVlKSxrBfD3Jior4QzqPuEEg7bagOLfAw6j?=
 =?us-ascii?Q?BsOl9Y/lEv+Nzgv4tPS0Kme7IbLPDgYRH6kOBJ5IR2ejkwOz2UaXyEtSjap8?=
 =?us-ascii?Q?JAMX+4+6VgiXo04I9H4h1oeeRsKBK9A19DvbgjMXpizqbkQDuPMz8w1bBi4+?=
 =?us-ascii?Q?kn6Xnbkh1NL0pJ6ZwtR2ovmNZLanyMFpRe0d0DC1ZGRgomNWh34pLNfLDP4z?=
 =?us-ascii?Q?Fk9JU9OuNLarKUQjfjiXbOfQHfKKBcC1PA5WwUfes5OFtK5YZuHVDw3cQM4d?=
 =?us-ascii?Q?I9m+87K4TDdP9M+PhHFQyeByP4bBULwFHldI/2b/oImdHSAxu7m1dbzjMezu?=
 =?us-ascii?Q?/iwVyOUfrGLPpjvf2yOHhis1Ori2h2ULcXIqaBtcca+2CmHAQOu7irfmtxF7?=
 =?us-ascii?Q?sAYa8xXXwA6LUxZwvrZXm1rfNRIKK7XezDjpa6IWOmOA4GNFoHXqV/WYhWAh?=
 =?us-ascii?Q?7AjgHrq2lEoYRalmDtPIvyPdcKh94h7Dz5veSzzvTJ1b7c5miAELaqZ9jXQp?=
 =?us-ascii?Q?ygcbUH0oFJCJ8ag1ax0htUfgatzG4C05TQ87bqzIJ8za9HPEoo+7nk9AzzKf?=
 =?us-ascii?Q?sHm849QtsDp0DPZX9n4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:15:47.9664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c75d20ea-3cba-4fc5-7880-08de17d7f80b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248


This series adds the support for L3 Smart Data Cache Injection Allocation
Enforcement (SDCIAE) to resctrl infrastructure. It is referred to as
"io_alloc" in resctrl subsystem.

Upcoming AMD hardware implements Smart Data Cache Injection (SDCI).
Smart Data Cache Injection (SDCI) is a mechanism that enables direct
insertion of data from I/O devices into the L3 cache. By directly caching
data from I/O devices rather than first storing the I/O data in DRAM, SDCI
reduces demands on DRAM bandwidth and reduces latency to the processor
consuming the I/O data.

The SDCIAE (SDCI Allocation Enforcement) PQE feature allows system software
to control the portion of the L3 cache used for SDCI devices.

When enabled, SDCIAE forces all SDCI lines to be placed into the L3 cache
partitions identified by the highest-supported L3_MASK_n register, where n
is the maximum supported CLOSID.

Since CLOSIDs are managed by resctrl fs it is least invasive to make
the "io_alloc is supported by maximum supported CLOSID" part of the
initial resctrl fs support for io_alloc. Take care not to expose this
use of CLOSID for io_alloc to user space so that this is not required from
other architectures that may support io_alloc differently in the future.

The SDCIAE feature details are documented in APM [1] available from [2].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
    Injection Allocation Enforcement (SDCIAE)

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]

The feature requires linux support of TPH (TLP Processing Hints).
The support is available in linux kernel after the commit
48d0fd2b903e3 ("PCI/TPH: Add TPH documentation")

The patches are based on top of commit (v6.18.0-rc3)
Commit 1f7c44e84b9b (tip/master) ("Merge branch into tip/master: 'x86/sgx'")

Comments and suggestions are always welcome as usual.

# Linux Implementation

Feature adds following interface files when the resctrl "io_alloc" feature
is supported on the resource:

/sys/fs/resctrl/info/L3/io_alloc: Report the feature status. Enable/disable the
				  feature by writing to the interface.

/sys/fs/resctrl/info/L3/io_alloc_cbm:  List the Capacity Bit Masks (CBMs) available
				       for I/O devices when io_alloc feature is enabled.
				       Configure the CBM by writing to the interface.

When CDP is enabled, these files are created both in L3CODE and L3DATA.

# Examples:

a. Check if io_alloc feature is available.

	# mount -t resctrl resctrl /sys/fs/resctrl/

	# cat /sys/fs/resctrl/info/L3/io_alloc
	disabled

b. Enable the io_alloc feature. 

	# echo 1 > /sys/fs/resctrl/info/L3/io_alloc 
	# cat /sys/fs/resctrl/info/L3/io_alloc
	enabled

c. Check the CBM values for the io_alloc feature.

	# cat /sys/fs/resctrl/info/L3/io_alloc_cbm 
	0=ffff;1=ffff

d. Change the CBM value of domain 1.
	# echo 1=ff > /sys/fs/resctrl/info/L3/io_alloc_cbm

	# cat /sys/fs/resctrl/info/L3/io_alloc_cbm 
	0=ffff;1=00ff

e. Change the CBM value of domain 0 and 1.
	# echo "0=ff;1=f" > /sys/fs/resctrl/info/L3/io_alloc_cbm

	# cat /sys/fs/resctrl/info/L3/io_alloc_cbm
	0=00ff;1=000f


f. Disable io_alloc feature and exit.

	# echo 0 > /sys/fs/resctrl/info/L3/io_alloc 
	# cat /sys/fs/resctrl/info/L3/io_alloc
	disabled

	# umount /sys/fs/resctrl/
---
v11:
   Took care of review commnet on patch 6.
   Fixed typo CDP_3DATA -> CDP_DATA.
   Added code to free the CLOSID on resctrl_arch_io_alloc_enable() failure.
   Fixed the prototype of rdtgroup_name_by_closid().
   
   Other patches did not change.
   Added Reviewed-by: tag for few patches.
   Took care of few minor conflicts in fs/resctrl/internal.h due to code displacement.

v10:
  Updated the changelogs in most patches when there is some repetitions in texts. Thanks to Reinette.

  Fixed the minor conflicts in scattered.c and cpufeatures.h.

  Fixed the few conflicts due to recent ABMC feature merge.

  Code comment update to match MSR names correctly.

  Re-arranged the details in resctrl.rst file.

  Changed the text L3CODE to CDP_CODE and L3DATA to CDP_DATA.

  Updated the return code to EINVAL when feature is not enabled in resctrl_io_alloc_cbm_write().

  Few other text changes. Added details in each patch about the specifics.

v9:
  Major change is related to CDP.
  The processing and updating CBMs for CDP_CODE and CDP_DATA are done only once.
  The updated CBMs are copied to the peers using staged_config.
  
  Removed resctrl_get_schema(). Not required anymore.

  Updated the "bit_usage" section of resctrl.rst for io_alloc.

  Fixed the tabs in SMBA and BMEC lines in resctrl.rst.

  Improved the changelog for all the patches.
  
  Added the code comments about CDP_CODE and CDP_DATA where applicable.

  Added Reviewed-by: tag for couple of patches.
  
  Added comments in each patch about the changes.


v8:
  Added Acked-by, Reviewed-by tags to couple of patches.

  Updated Documentation/filesystems/resctrl.rst for each interface.
   
  Updated the changelog in most patches. 
  
  Moved the patch to update the rdt_bit_usage_show() for io_alloc changes to the end.
 
  Moved resctrl_arch_io_alloc_enable() and its dependancies to
  arch/x86/kernel/cpu/resctrl/ctrlmondata.c file.
  
  Moved resctrl_io_alloc_show() to fs/resctrl/ctrlmondata.c.
  Added prototype for rdt_kn_parent_priv() in fs/resctrl/internal.h
  so, it can be uses in other fs/resctrl/ files.
  
  Renamed resctrl_io_alloc_init_cat() to resctrl_io_alloc_init_cbm().
  Moved resctrl_io_alloc_write() and all its dependancies to fs/resctrl/ctrlmondata.c.
  Added prototypes for all the functions in fs/resctrl/internal.h.

  Moved resctrl_io_alloc_cbm_show() to fs/resctrl/ctrlmondata.c. show_doms remains
  static with this change.

  Moved resctrl_io_alloc_parse_line() and resctrl_io_alloc_cbm_write()
  to fs/resctrl/ctrlmondata.c.

  Added resctrl_arch_get_cdp_enabled() check inside resctrl_io_alloc_parse_line().
  parse_cbm() remains static as everything moved to ctrlmondata.c.

  Simplified the CDT check  in rdt_bit_usage_show() as CDP_DATA and CDP_CODE
  are in sync with io_alloc enabled.

v7:
  Fixed few conflicts in
  arch/x86/include/asm/cpufeatures.h
  arch/x86/kernel/cpu/scattered.c

  Updated the changelog in most patches. Removed the references of L3 in
  filesystem related changes.

  Removed the inline for resctrl_arch_get_io_alloc_enabled().
  Updated the code comment in resctrl.h.
  Changed the subject to x86,fs/resctrl where applicable.
 
  Split the patches based on the comment.
  https://lore.kernel.org/lkml/3bec3844-7fda-452b-988f-42b0de9d63ba@intel.com/
  Separated resctrl_io_alloc_show and bit_usage changes in two separate patches.

  Added new function resctrl_io_alloc_closid_supported() to verify io_alloc CLOSID.
 
  Added the code to initialize/update the schemata for both CDP_DATA and CDP_CODE when CDP is enabled.

  Rephrased the changelog and code comments in all the patches.

v6: 
   Sorry if you see this series duplicate. Messed up the
   emails linux-doc@vger.kernel.org and linux-kernel@vger.kernel.org.

   Sent v5 by mistake before completing all testing.
   Most of the changes are in resctrl.rst user doc.
   The resource name is no longer printed in io_alloc_cbms.
   Updated the related documentation accordingly.
   Resolved conflicts in cpufeatures.h
   Added lockdep_assert_cpus_held() in _resctrl_sdciae_enable() to protect
   r->ctrl_domains.

   Added more comments in include/linux/resctrl.h.

   Updated "io_alloc_cbm" details in user doc resctrl.rst. Resource name is
   not printed in CBM now.

   Updated subjects to fs/resctrl: where applicable.

v5: 
    Patches are created on top of recent resctrl FS/ARCH code restructure.
    The files monitor.c/rdtgroup.c have been split between FS and ARCH directories.
    Resolved the conflict due to the merge.

    Updated bit_usage to reflect the io_alloc CBM as discussed in the thread:
    https://lore.kernel.org/lkml/3ca0a5dc-ad9c-4767-9011-b79d986e1e8d@intel.com/
    Modified rdt_bit_usage_show() to read io_alloc_cbm in hw_shareable, ensuring
    that bit_usage accurately represents the CBMs.

    Moved prototypes of resctrl_arch_io_alloc_enable() and
    resctrl_arch_get_io_alloc_enabled() to include/linux/resctrl.h.

    Used rdt_kn_name to get the rdtgroup name instead of accesssing it directly
    while printing group name used by the io_alloc_closid.

    Updated show_doms() to print the resource if only it is valid. Pass NULL while
    printing io_alloc CBM.

    Changed the code to access io_alloc CBMs via either L3CODE or L3DATA resources.

v4: The "io_alloc" interface will report "enabled/disabled/not supported"
    instead of 0 or 1..

    Updated resctrl_io_alloc_closid_get() to verify the max closid availability
    using closids_supported().

    Updated the documentation for "shareable_bits" and "bit_usage".

    NOTE: io_alloc is about specific CLOS. rdt_bit_usage_show() is not designed
    handle bit_usage for specific CLOS. Its about overall system. So, we cannot
    really tell the user which CLOS is shared across both hardware and software.
    This is something we need to discuss.

    Introduced io_alloc_init() to initialize fflags.

    Printed the group name when io_alloc enablement fails to help user.
    
    Added rdtgroup_mutex before rdt_last_cmd_puts() in resctrl_io_alloc_cbm_show().
    Returned -ENODEV when resource type is CDP_DATA.

    Kept the resource name while printing the CBM (L3:0=ffff) that way we dont have
    to change show_doms() just for this feature and it is consistant across all the
    schemata display.

    Added new patch to call parse_cbm() directly to avoid code duplication.

    Checked all the series(v1-v3) again to verify if I missed any comment.

v3: Rewrote commit log for the last 3 patches. Changed the text to bit
    more generic than the AMD specific feature. Added AMD feature
    specifics in the end.

    Renamed the rdt_get_sdciae_alloc_cfg() to rdt_set_io_alloc_capable().
    Renamed the _resctrl_io_alloc_enable() to _resctrl_sdciae_enable()
    as it is arch specific.

    Changed the return to void in _resctrl_sdciae_enable() instead of int.
 
    The number of CLOSIDs is determined based on the minimum supported
    across all resources (in closid_init). It needs to match the max
    supported on the resource. Added the check to verify if MAX CLOSID
    availability on the system.

    Added CDP check to make sure io_alloc is configured in CDP_CODE.
    Highest CLOSID corresponds to CDP_CODE. 

    Added resctrl_io_alloc_closid_free() to free the io_alloc CLOSID.

    Added errors in few cases when CLOSID allocation fails.
    Fixes splat reported when info/L3/bit_usage is accesed when io_alloc is enabled.
    https://lore.kernel.org/lkml/SJ1PR11MB60837B532254E7B23BC27E84FC052@SJ1PR11MB6083.namprd11.prod.outlook.com/

v2: Added dependancy on X86_FEATURE_CAT_L3
    Removed the "" in CPU feature definition.

    Changed sdciae_capable to io_alloc_capable to make it as generic feature.
    Moved io_alloc_capable field in struct resctrl_cache.

    Changed the name of few arch functions similar to ABMC series.
    resctrl_arch_get_io_alloc_enabled()
    resctrl_arch_io_alloc_enable()

    Renamed the feature to "io_alloc".
    Added generic texts for the feature in commit log and resctrl.rst doc.
    Added resctrl_io_alloc_init_cat() to initialize io_alloc to default values
    when enabled.
    Fixed io_alloc interface to show only on L3 resource.
    Added the locks while processing io_alloc CBMs.

Previous versions:
v10: https://lore.kernel.org/lkml/cover.1761090859.git.babu.moger@amd.com/
 v9: https://lore.kernel.org/lkml/cover.1756851697.git.babu.moger@amd.com/
 v8: https://lore.kernel.org/lkml/cover.1754436586.git.babu.moger@amd.com/
 v7: https://lore.kernel.org/lkml/cover.1752167718.git.babu.moger@amd.com/
 v6: https://lore.kernel.org/lkml/cover.1749677012.git.babu.moger@amd.com/
 v5: https://lore.kernel.org/lkml/cover.1747943499.git.babu.moger@amd.com/
 v4: https://lore.kernel.org/lkml/cover.1745275431.git.babu.moger@amd.com/
 v3: https://lore.kernel.org/lkml/cover.1738272037.git.babu.moger@amd.com/
 v2: https://lore.kernel.org/lkml/cover.1734556832.git.babu.moger@amd.com/
 v1: https://lore.kernel.org/lkml/cover.1723824984.git.babu.moger@amd.com/


Babu Moger (10):
  x86/cpufeatures: Add support for L3 Smart Data Cache Injection
    Allocation Enforcement
  x86/resctrl: Add SDCIAE feature in the command line options
  x86,fs/resctrl: Detect io_alloc feature
  x86,fs/resctrl: Implement "io_alloc" enable/disable handlers
  fs/resctrl: Introduce interface to display "io_alloc" support
  fs/resctrl: Add user interface to enable/disable io_alloc feature
  fs/resctrl: Introduce interface to display io_alloc CBMs
  fs/resctrl: Modify struct rdt_parse_data to pass mode and CLOSID
  fs/resctrl: Introduce interface to modify io_alloc capacity bitmasks
  fs/resctrl: Update bit_usage to reflect io_alloc

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/filesystems/resctrl.rst         | 127 +++++--
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
 arch/x86/kernel/cpu/resctrl/core.c            |   9 +
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  40 +++
 arch/x86/kernel/cpu/resctrl/internal.h        |   5 +
 arch/x86/kernel/cpu/scattered.c               |   1 +
 fs/resctrl/ctrlmondata.c                      | 309 +++++++++++++++++-
 fs/resctrl/internal.h                         |  17 +
 fs/resctrl/rdtgroup.c                         |  75 ++++-
 include/linux/resctrl.h                       |  24 ++
 12 files changed, 567 insertions(+), 44 deletions(-)

-- 
2.34.1


