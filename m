Return-Path: <linux-kernel+bounces-898393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD1CC55310
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E866234AD5D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73476213E7A;
	Thu, 13 Nov 2025 00:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gtnjnwex"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC3B2B9A4;
	Thu, 13 Nov 2025 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762995474; cv=fail; b=YFnlEUck12pOSOFTejAk2Fjbi3+4fhFNUo4iCOzoYQ55hllkszeHeNgtrP1k4cHb4nI0O/cxSx2zA1zUEeNDnGQRBs1foKxFHaHA5DUp7vmZ00pdnMDirll8E+E7Bdj043v+sYgBbVkCHmbwpdXJg6+GYTigFJnoXpKoe5QKiqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762995474; c=relaxed/simple;
	bh=A6/z+yGQbbK9ymuO6SGFgFISJFSag6CoGIhiPJpsg9k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FCDbb5eUBb0I15PJ3kWEBUXO7bzLyUqSA0NXQhTkM1aEEiKZYEWVzqjW9RjJySdzTAoRIXXOre/gk6Ed1ZTWoGrrGetuZeJhzN0ClCM6DKkeTMPW3Wl9HbKelyUaixBrjee2HIDrvUYwpBut3gr9OH4ttQmgAS/Tyq9M/nc115c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gtnjnwex; arc=fail smtp.client-ip=52.101.43.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwtxAR334+mLHtuWht4jatgyEd2K3nmAsxRn4MBAM/rRUW2EjJgYgnH5DvTg2hY1s0y1mXIrtULw14OiFNXPe7t4jV/zvEeXDoPBwkEI9E7/dwbycLxdV+/GKrAURX5VD+Is2ozdd7QcEBngUdVAkYIT2WN85xxXM9xUGRuHHYqcSMLpdM3zwUMWZcb92bUGXlgioeQaVlWJnbH1DdkdhiIQoxyQfYb46/gXA9C02YjHvgK+H3YzwzbnMh4O4K9cQXaP0I4wpB1LuU3zIZDPCEhce3OR1ZV0FmGxRa8FL9zCUsJHzjBNxaDLxg2Kqeyz/CW5kNUmymJz5JjOkwpYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QTShY/a2JJ+Ii4mHdpkGrW0QyFO+c0KGyVBS+G65s8=;
 b=rIC7cmJ/NbmPeFEzdcGntPC5BZrsa5ju+WlOuRr4GcEkdLWkeOS95MeT7F0UhSaTmpknvfSqEH/AOrKIRfMF4+QjuraAeqMM+2Ba45om6DHg6JuIRms1vDlswhP5rQAuwtk6PN7E4TplWEtDI0d63kAbn/VVHCYsxSQCOXzKL8SBpktyR3JHPxYBW+CvXzZjHRJ4wKD56qnTKJsGPf0yxROHX6S4TyTw9mKFt+fnPXCzoPpAQvC8yMUexfdFUxOlDl6MZFQdglDUqD8DpFQtOpKUj+1uHz5tSlLLzn6ocE3beIrC9ywoiSR395t6lSkdqJJmOs7djsUnPwCbyu0s2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QTShY/a2JJ+Ii4mHdpkGrW0QyFO+c0KGyVBS+G65s8=;
 b=GtnjnwexndPdp/6lKcnr2L1AY9Ry51NEhEwuK0oFkGxNVNPUDbdAUyRj3EAjz91bVh5tO2IQj0WvkgVgZF9jt5mdpW7jCJ3SUwy8mO5URA8ITI4snHN5jS9ETbvh+73vEpv9oUBCNS/+w6PxKnIr2hxtIcjupkQxu9Jf9TUtxY8=
Received: from CH2PR19CA0009.namprd19.prod.outlook.com (2603:10b6:610:4d::19)
 by IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 00:57:43 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::91) by CH2PR19CA0009.outlook.office365.com
 (2603:10b6:610:4d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 00:57:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 00:57:43 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 16:57:42 -0800
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
Subject: [PATCH v12 00/10] x86,fs/resctrl: Support L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE)
Date: Wed, 12 Nov 2025 18:57:26 -0600
Message-ID: <cover.1762995456.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|IA4PR12MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: d75e1f46-c3b9-4c14-361c-08de224fa74b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gUwbTPgpdFgUfs1dWDuluOifBeysQvZxGO9k+3KHkAXw9gLuh4pl4R6If1ng?=
 =?us-ascii?Q?kVnklT1TqLkfOessikITfZxMI6MQkdRd41/8vMa3DVggbq/ohuiCFzhb04Hv?=
 =?us-ascii?Q?EZR8o7+4TB0c6+gokXmfpPT6GRbciLNsBZxGCTiFYwdnmcu2YHtLBE4ihyfQ?=
 =?us-ascii?Q?1paA3VWQ6UlrTssplxghMqTGGW/UMAbCEVvo7nUeDDytmjTMIl2SMPuodq08?=
 =?us-ascii?Q?OMx/ws7cJa/JCwk/iiq6bMpYetqlgmPCwnc0qLRxkOU/13iecbUmmHO2v+OU?=
 =?us-ascii?Q?VELKm/yIOo96efH4ya06RZT2jido56qakbbP6I5f7noi1AAxGgN50Ke4L3Pu?=
 =?us-ascii?Q?D8bPP6iYFxZ4eqwgcp7ZVMeBanxh/cSceLIUcW+5vMJo8Kr+WE/e4ZjLXa/Z?=
 =?us-ascii?Q?eq4x94L4jdaT42lfeQUtP38yDnU/hnTizXS1ac6if36W23RQ+0g9iU2cq29z?=
 =?us-ascii?Q?hvvKb+BojVkWAXNlTRUyiAH0+4IlOSUtIMOLEHj3P4yig9kq9dHcfzHwPIi4?=
 =?us-ascii?Q?AAe6y7fbXAS+bwbsJWGBjLqANxO0XTV9aKOjC8zRBudq2uHY1HUxvq10Ch39?=
 =?us-ascii?Q?sRc2JrTDz2jaX2tgl6UOmCVdMJ1JjgsED9QwQh7+RcK6vN4L4YAKcvzBovOc?=
 =?us-ascii?Q?x7NIkXiN1lM2tadixc4xR19wyoZB3kFgjKlaxFcBsaxPrlPV8Nn6edycrpY3?=
 =?us-ascii?Q?igDb7HtUJk90do7Rlvy/nqjgdpf3ejG3hed2KLlTfwPrNT5z9smwpYNITC+P?=
 =?us-ascii?Q?0iRIdojVjXPXOeo6gtKSE+3hikUNtQs/7oGf5KQFEyo8kkduSFZhbfx6BPmY?=
 =?us-ascii?Q?Zy+vy00yyEv0i8hxw0TDj0Jar/JM41sBHI4jokr/UBPrEgujHFfM+ZiMVnwm?=
 =?us-ascii?Q?GzWEHDk57zjje2FCnixinyyc6iIiOhw0n1vLVSZr9Pny3pY40+e/RYGg47O6?=
 =?us-ascii?Q?NkUOaoqregJo0gNDW4lRb/13WCUL6ld7dQx2uscFmZZz0yrtQWlOvih2OXAn?=
 =?us-ascii?Q?HRu8wf16j76wIQlmoFJkj+fCQV6IkBsP3AivuparPw9YYV/OQZ7h03XGogjy?=
 =?us-ascii?Q?WmO92D0iNaLdTNkyanTX8aVL3LQID+CP0eNw4xsEAPz3xTdlVRbLWoSwcj+f?=
 =?us-ascii?Q?C9uXqixG/kkZkdvtGzOJ+n5oMneg+JKOq1Mw5PaGB3YGgHxGFSP7FG6aMfYh?=
 =?us-ascii?Q?GOAlA7eATYYFCeda6bMmiRDqgDlvyxJ1jAnHOxiPalXd797iwkb+qyXJgLoq?=
 =?us-ascii?Q?ghXPftMflEqAfhuxL1gqBGIBa3GArhT2x5tBLp3Jocye3uC2eCfLOWirn0Mm?=
 =?us-ascii?Q?4Rk/kemLFqTbPgUHQ4iV7ftlKTRsCDMW+sqNhLwl2nTgNf2RCyLNyYA4mW4v?=
 =?us-ascii?Q?x0PtPRXvwmcIDBQdIrHYEzd323PDtGwg6pP2BkJB71VqiBnl+Jq5Zj7gf+e+?=
 =?us-ascii?Q?AyAyCzbrgstpOLU61zDxyKIcqTrjUdS7WBBKkEn+yZQdsISEAjsUN0mVVde2?=
 =?us-ascii?Q?aO8e5VCDGvGxEPw/v9Kazr+th/mWDr+QXJ2AhbsQzHCK31YXzi1eNdbISWR6?=
 =?us-ascii?Q?TA8a8uaM6GsFHqpItl4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 00:57:43.7146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d75e1f46-c3b9-4c14-361c-08de224fa74b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9763


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

The patches are based on top of commit (v6.18.0-rc5)
Commit 2f70cdbd7c20 (tip/master) ("Merge branch into tip/master: 'x86/sgx'")

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
v12: 
   Minor format fix in resctrl.rst (patch 6) and added text about writable files in the info section.
   Other patches did not change.
   There were some discussion about adding support to update all the domains of io_alloc_cbm
   with one command.
   https://lore.kernel.org/lkml/20251107012401.224515-2-atomlin@atomlin.com/
   Aaron will be adding that later.

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
v11: https://lore.kernel.org/lkml/cover.1761844489.git.babu.moger@amd.com/
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
 Documentation/filesystems/resctrl.rst         | 134 ++++++--
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
 12 files changed, 574 insertions(+), 44 deletions(-)

-- 
2.34.1


