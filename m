Return-Path: <linux-kernel+bounces-757066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE399B1BD50
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F67720827
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAE123BCFD;
	Tue,  5 Aug 2025 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="en6WY/+/"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6AD1C5D44;
	Tue,  5 Aug 2025 23:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436658; cv=fail; b=SjNkX2lVBx1TOBPBC1MJ7zrLSqa4isF3fTHyoCtWS7huaVnALDf4aJeet7R6RTlEKvYFypzrvb6yKqPUqoZpuMmGK6Bq4u6eicZC6zDHfe4RbK3yhpgQX+XaMOhYuCiiqySv3z3bw7UvSc+o79z0aB6CkVDWIaa6FLGm3DEux9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436658; c=relaxed/simple;
	bh=cxHqfOGeS323TucaO3PG+MfJEEQL5uYIcNAKGrbBSUc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CqVcuT94ux8OyK+62gntjYcJA/Lfxl01EitK2k+Twst5X01Hrus4wwiXWTiniouFd5+InTkGQ2VO0vTxrPduiB/KwwxGR1zzcPjEhDdSsBn+LYMHu1Sf3362yBWV3sY6+Mom1NQ01K9c9rBKSbjODx7alJH1rhFEFYwghGQlls8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=en6WY/+/; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjCC8pd7f27M6BxONe1CSNqrUeE+5Ijd1NzhwDd+TD2DlPkpguiBBq3IblZfXrvN/ugR4BaGzj3sO79Qe6+Tcm7GHEYMg+nyApLZ6KFMVQ367Auy5vzyHjyeVAV+TUZ3T8FtzdScuWSPwR9QN3PIL5zBLNt+Av+fpBq9XqmE8Z9p12A9BYWefbbPbc13tkOBTb97tTcH/Vs/V3cIetZi0QJY9PyREXRn5F6xHpmQ+9l1KJrQnYgLjTQlhIiYbEXRQmD1UR1MMe0yEsjU+8sXNoxV/SJA1rXknd1druU3H4rnI8Zevkdjxe7gqVMJBRRSGvipL+WTNS/4Scgx2hCcgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M85Kby2f1bEpRn0YzdLtG/5ueHzTnP2CeDn7AkqcaMA=;
 b=iULwHd5XUW5OlDTdgZ/SxHnCY7rEmueJpXl3Qxq0EVDlLcK/RAlMfJ31lNsFxYj5T8SzKgTNXHDmWN95qemJi3e06A29wEiBf+3LWRW3qy1T8990DOPIJzlnRVPjS7jgsX5QnhA8OwickTAUDbVflkpxh2Z2/lCdhY8uVE0vcGp7RvzLAKJy2hGQ4VKVTRnk5NT5CozVTbc82JDcI2FP6RqzdwMrrtxxE1j2plxcU00RhvoSPR2Dsi/RLRwV5ljXx2i1TnvJD5HCT3pDg5C8fUNgpy/00X3/mvZMj34c/UKo7atZePytDTjJ5s+25+xqwAOwTpWqJQsyKvXuZwN0Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M85Kby2f1bEpRn0YzdLtG/5ueHzTnP2CeDn7AkqcaMA=;
 b=en6WY/+/pVRHaWcL4nzOR4Px1jAvGjOOzFch0YKl46QpEBwUCbAMTFzSOUUi7j7hMQwJl4KYGi5FO3zMC6nqeILJU2WFAUdZTnnRZaMreT9EoxDPvlBYybUcOOPk60p/e3AsnIIkC/EFRiHiUTsjJW+9zHWYb9DR8XSjWB8gj8U=
Received: from SA0PR11CA0081.namprd11.prod.outlook.com (2603:10b6:806:d2::26)
 by DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.13; Tue, 5 Aug 2025 23:30:47 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:d2:cafe::16) by SA0PR11CA0081.outlook.office365.com
 (2603:10b6:806:d2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Tue,
 5 Aug 2025 23:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 23:30:46 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 18:30:43 -0500
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
	<linux-kernel@vger.kernel.org>, <manali.shukla@amd.com>,
	<gautham.shenoy@amd.com>
Subject: [PATCH v8 00/10] x86,fs/resctrl: Support L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE)
Date: Tue, 5 Aug 2025 18:30:20 -0500
Message-ID: <cover.1754436586.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|DM4PR12MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 8edd7f56-134a-4da0-02ac-08ddd4781ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yOkHcE+MFWxC7pZlcaZW6vecq2taXmrS5wxj2my7WYz1coxkMFuvkSm9iz57?=
 =?us-ascii?Q?pEGFvbmcRAJQoyj4gC68YYg44/K0t7YS+ql7tRtSYIHH3q4CwySApHEos2CP?=
 =?us-ascii?Q?M7ImubzJKDgbeY8JA02AHegqDSw4MgFuap53A12BA9PW+OHj1wZIjKoVENDQ?=
 =?us-ascii?Q?Mei1NfVNT0MBjPCKXLOpSIe5/p9d8wl4jI6tP+sSWiD1yksGOSjIa+0mA5TW?=
 =?us-ascii?Q?BxiSuDf5ciot8u+IBlYVaoujTj+d1aCai3aB2qMPJeCSlp/wvXAO7uxVMXcn?=
 =?us-ascii?Q?gPjwZtewbMzLelvHJltQoy8UbIMhHL5dbNE9CkV/6F+taTG79bGnbTQscaFU?=
 =?us-ascii?Q?s7ZvS9zL9+VDjFvIkhgdwocGdlPWjYXMpqxk7sOQHxKMVkqM24QXB/rQBh73?=
 =?us-ascii?Q?hwKj8zrP02WUkAfhRnT/2Bopk0DTVzgCOT/3QTa6lMVOS3VF19wYHqP8aIrt?=
 =?us-ascii?Q?eDyiVx1g50u5SzUOmho9SXOkAZ6dQlJM+zz/lWZP/xkop36zl9whaPhPwHI0?=
 =?us-ascii?Q?JnzzbQVWvjhxENip0HWjDq5KecDMu3NsN+NSCgZ1FRj8A4QdpFG9QUUNcunt?=
 =?us-ascii?Q?QY2gicF5+YPmlhplPatuKo9YXXu8lLxkMMiFvDeA4Rnt6cXVclCFN6cTYlCY?=
 =?us-ascii?Q?/djFIClnIq4EdpbukhAoZary/nfJB7EredfmDWndD0Q67YXo2pVThpczHp9a?=
 =?us-ascii?Q?MmqR0rw1OrU3xixQ7FeQoguQ4D6mhi8za3XaCNVPaGfvI5WrAG0mx0kBB4xc?=
 =?us-ascii?Q?fmDG8AXZ5MO/NKyguvfQyQBRn/5aXTrC93bygHlv8uC6xuihHl8ZiM1IUMVu?=
 =?us-ascii?Q?HaNbcJfiNmO8Gn/w5QBXwujApf+Nr8Og4PM8dEdAHddf1jcbKf05jQOqy++E?=
 =?us-ascii?Q?FqRSJH87a/wAbEBKSVz4hxi2icMQfxIUsxwj9qlsQPsYCBSaGzeSGHma36Mx?=
 =?us-ascii?Q?5KLe9XA6HzePugxoexefCxwsp8tJLUOF3B9aoGBbaGbuujHOacKhE0mth76L?=
 =?us-ascii?Q?sd8ysEktMns2njEkuF0d+V/hArzqhfysy+kJfl7nvgD31p2MutOQyA1vSgEP?=
 =?us-ascii?Q?d7hvaiWKASFIDt/DtawJ/CYOl7QCgSh/P8Ke2chdndMDF2PHwfq5HSvF/L1E?=
 =?us-ascii?Q?KtqI3tUg8P6MhzR73+dyKJBNBk92DiQwkTypD1nFSEJckvZ/X0GIDAXz5HBd?=
 =?us-ascii?Q?zv1+dN2iptD+ldVy3+fQykM+hpsAsclsvVmDVidnU4HgFHjgJmN+g3XuC7pX?=
 =?us-ascii?Q?Ks80CHduSKkreoXtoP2VKNFr+oA1qWDksBmGM9814d56mXqnpthGLgqm5LjQ?=
 =?us-ascii?Q?tFoY2pe8cSNa2AhQNsYe4KENK42AdXAVv1H6ZLI1SsGok1fclztR5wmKoune?=
 =?us-ascii?Q?5QOV/2J9eD2gOc8CO6pBKf7N5V5ucOu/JCxWKhtqG5f6VLhoSibVoAS2ZM6g?=
 =?us-ascii?Q?lkJvYpJLPfnkgfnTwfaoZIq/Oj+9fpM0t+U2usJKbs9knsqCUnsP+rrf06i1?=
 =?us-ascii?Q?2xHgxehaABjEU54xaQKwx2O4JNhI3K+9Yc14g4JxUxEJQrVbWkA84xYuBw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 23:30:46.5950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edd7f56-134a-4da0-02ac-08ddd4781ac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542


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

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
Injection Allocation Enforcement (SDCIAE)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

The feature requires linux support of TPH (TLP Processing Hints).
The support is available in linux kernel after the commit
48d0fd2b903e3 ("PCI/TPH: Add TPH documentation")

The patches are based on top of commit (v6.16)
commit 40d6e791ba3a ("Merge branch into tip/master: 'timers/clocksource')".

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
	# echo 1=FF > /sys/fs/resctrl/info/L3/io_alloc_cbm

	# cat /sys/fs/resctrl/info/L3/io_alloc_cbm 
	0=ffff;1=00ff

d. Disable io_alloc feature and exit.

	# echo 0 > /sys/fs/resctrl/info/L3/io_alloc 
	# cat /sys/fs/resctrl/info/L3/io_alloc
	disabled

	# umount /sys/fs/resctrl/
---
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
  fs/resctrl: Modify rdt_parse_data to pass mode and CLOSID
  fs/resctrl: Introduce interface to modify io_alloc Capacity Bit Masks
  fs/resctrl: Update bit_usage to reflect io_alloc

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/filesystems/resctrl.rst         | 104 +++++-
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   1 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
 arch/x86/kernel/cpu/resctrl/core.c            |   9 +
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  40 +++
 arch/x86/kernel/cpu/resctrl/internal.h        |   5 +
 arch/x86/kernel/cpu/scattered.c               |   1 +
 fs/resctrl/ctrlmondata.c                      | 319 +++++++++++++++++-
 fs/resctrl/internal.h                         |  24 ++
 fs/resctrl/rdtgroup.c                         |  74 +++-
 include/linux/resctrl.h                       |  24 ++
 13 files changed, 569 insertions(+), 36 deletions(-)

-- 
2.34.1


