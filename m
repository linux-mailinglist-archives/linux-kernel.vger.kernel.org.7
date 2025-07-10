Return-Path: <linux-kernel+bounces-726217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D814B009AC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7D25A10CE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2995225A646;
	Thu, 10 Jul 2025 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SzpGTUBv"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50512EAF6;
	Thu, 10 Jul 2025 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167801; cv=fail; b=avzZYFPOVGULmIP+AtOklsO8ZKvK95cn5w0J7ilhfBKr08lZNi+aYMRqZgQBuzL6CboRAe7vyrn3gwC5dWHKxuvQ1ZiBra+c7g/hyN/7y//ZKcLEmv5K64y2VkjGUQIh2wqRLbour0ul544Vj4/9tm6ARKXQKsROFS7KxZp+Az8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167801; c=relaxed/simple;
	bh=wz/TaIYaSUryJYemytrtIPtl3JlcBF8OYjccx6D5YKA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BWD9HgQowOTeVk/lnIe7fiebQqpAl9Fm0hidP5RBEhTNVxBRXNUEFof67N8YsDahR1tcyT2j3pUOLzfQahSVIspdMjaQsSwnjwlS3tRHClrQG+GGGCMhCz/4tvXbGChKUeHGXzfme5AE6oe5GieppUXfnrtKuIHNIZ0YzwC6dqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SzpGTUBv; arc=fail smtp.client-ip=40.107.102.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUcP64NormEZkVN9+jbBQf6m68Z/6twT/1yYfNJBdJmxPVF+7l7Mg3h3XOOoU7JEceSw9icA7GShQk0Ia2+E8jSKi1/UV7U4jFTiq0G6bDFM8Bfac32Me1wjbuq6E4XnNGfitelt2cnFRCHoT8rup30G7LCHa/V3PNNp4a7N8Qaevz14hMQ4h90bhvTBecWrhRUf2QEaiKe9811dq7lQrCPEyhWa1nXsSfhUylrqmfp98Y2JUWrSfDS60ruCSuL2YMJ/JHmSHbP00ICTIia/c9NqzKQ2AqMuVd7dgNt6NZ6Iwlp0TZ8S+9yXp3bwunvufoS61x7ZNyelQfIV5DLB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POlEkEftMFSSNrz1ZB1R778BBFFobxhLv7TTHrVk3+U=;
 b=BrQAg5zb6TkhGGQeDBilBC8707mgyLyrPK4XAyTiwLDY52MdN7Dqk/4VWIOLyNMVsCT+juoxfAXllVtl/rhBm0gRQqSdsbN3TMfFKHWWb7CGcJbIrTbbKyrzt67Xe56k/LLAIyFHQYPIBtbYZigDV9hj5G4EH0tw5/qHvbt4Q/obEJ1nc15LMc9e7qfHXmbgcPm2vdkJwgPno6e9wVI68hVBol9IPXofPH9E1Q4RquU89yq4wrh3Td7zEdPRMO40Tn1ZAHo97Pc41hz5qJjt5WaiE2m8rXB27wRyxERRNdA0FF4k9/2gXfFfonPkQ25NryYrO5AQFPuJwoaUP46c4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POlEkEftMFSSNrz1ZB1R778BBFFobxhLv7TTHrVk3+U=;
 b=SzpGTUBvPrIVgmXC9x8/nqfs9VMCNtffBqhvtwCY4f2isFEGHnopqOIihFv3B5MGXDkB7niTkGJWnoeK9CSzLf30xwMiPgLjzG5xxEfSXZR9ATYMjeF+JvE+LGVvl3ewDVvnET5xPGkui+/U9afI7Q7LX7x7TKIQlIdNf6e0Cqg=
Received: from BY3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:254::9)
 by DS2PR12MB9776.namprd12.prod.outlook.com (2603:10b6:8:2bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 17:16:33 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::d4) by BY3PR05CA0004.outlook.office365.com
 (2603:10b6:a03:254::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.7 via Frontend Transport; Thu,
 10 Jul 2025 17:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 17:16:33 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 12:16:30 -0500
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
Subject: [PATCH v7 00/10] x86,fs/resctrl: Support L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE)
Date: Thu, 10 Jul 2025 12:16:14 -0500
Message-ID: <cover.1752167718.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|DS2PR12MB9776:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c8cd2a-e337-40c3-690c-08ddbfd584ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u0HwOBYGtRpOe82oPCIyppzYw0ZshRN6seEBkwk9Wr4cBcfWixjDQZcU80fo?=
 =?us-ascii?Q?pT3YVH0k/1+13SEQQCzRwquX1KORCGfpNeAA+PxhacrPKbOJiEfKiFn/n0Xi?=
 =?us-ascii?Q?2P1P6h8UdUjYONnH7cMW8JkUCMWtstJfzMREJcFySpCNOEbImuUK8fzKj7m4?=
 =?us-ascii?Q?xJQPknstODeSukrL9QCSpj9YQjR5QZYjn6ncEbOITdVkHOqTjhed316UM4Yu?=
 =?us-ascii?Q?aQ/I/FYYgegQx61jdOXDL5JFdN9pkAdJMge82OivAOx8w6kFsuKZiiaUJ++k?=
 =?us-ascii?Q?kzvF42RSc4gPoTs+8uWkPB0YOuW59Tf2OgJasHxyUF6UL/ZpePHL2AamlFAa?=
 =?us-ascii?Q?0wr8wrRHb9tgRwpyDJrMbl9VQe3q28VDZPA6AEju/lnlOu/++C2dBGuixqaV?=
 =?us-ascii?Q?HDVrF8eSFPr9jHxRZNt08HsnRVOUj0rZZZlNBAH9zfC4ZwdoKNkZ8VyEnMn9?=
 =?us-ascii?Q?UuMpaBQurODn+v5Bem2hgkhvJ++qGX3BIEQjY2O7MMkZoyrAqTDuQbEIT4aZ?=
 =?us-ascii?Q?nz3Ah68nAP40K6m3X6W35GKgvpgNv4OOsevjL3RulQnGwNeLn1b58vqtHIqt?=
 =?us-ascii?Q?3BosrDlW5vGOTHKRWWtnAf6cW0+x/cT7f4zjsIR+uSu7BVEbr4kq2WiJKDQr?=
 =?us-ascii?Q?hbo5QIQ6Y4EkdV+V2PkIQpQ+vubnWJFSXHKaVJqXTUW6wrsYehpZI8Q031Ze?=
 =?us-ascii?Q?APHdqUpRYFgB43f2osL2QNJdG1hutKPEtUY4GSDhD9UbHfZhyDqPyKaI3pSX?=
 =?us-ascii?Q?uUN5+eVfzloYKDRehyFXVb8rBWtos72dgx37UnYThBIAei8elziLBYOTLMp6?=
 =?us-ascii?Q?WPN39kkHrO5lGsl97fdN/PPwcKQKuiID7zlmNs+yW+O3tCGKuMJfuvyXPPnn?=
 =?us-ascii?Q?JJUAtwaGEfW6N10PddM5woUXlsHUoNlsVIeSBUpLpnN4ukGHGulSgM0GrymU?=
 =?us-ascii?Q?FypxJcxAoy7LsJkpDmENUtWbPjQYjSm/v+s9Lxuodo9+IjfCe6ShdFPXxi6T?=
 =?us-ascii?Q?M4ciYmW5sECh6UAw1fi9IokKkELi9MxxurUKqcDhEITAxzYRqER6WKcG/oAH?=
 =?us-ascii?Q?ZloRT9TVPkyk6TOBvCjvLnleMbT5u2d8+NmCINjRusAbnK4MuisqaEieOV95?=
 =?us-ascii?Q?etWiVvrJS6DO12yoPtDuw2OgrZRjy4l4VzV53qG0AW4+YmN6WBeQMMuQK734?=
 =?us-ascii?Q?CzNrRqU4SgYaAhACepq/nb2G0nrKtKZpMAC+xk/YKE0pa0OoFUwh35I2TpAq?=
 =?us-ascii?Q?qIBQP33TJhhhytG/+Qrpq/1+v9XcZBGerVidcbwu5g6GDnNc+ypyiGxchVkH?=
 =?us-ascii?Q?c+YsgB2Vz5/5ofnpAxCMqpI/dn0n16mzD/1GX3dXYg3U0cEiTzCP8usjigNf?=
 =?us-ascii?Q?ldrqV/jYPDky3hz0Gb2fj6jxW1qgEQ8WPMuh/tl33s+I4LFuNXEhmifqAr6p?=
 =?us-ascii?Q?rQkN2D2UzJdwcLAO1E1JCtQkcVrY8UihhQUUbzFL+rjapIckGcM3bDKPAlLL?=
 =?us-ascii?Q?hEgVA6fsCcBNhASag9gW+SBg5aOV6Dx9hWhfWKsR1x7o3JxW8r7wnjHlEg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:16:33.0128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c8cd2a-e337-40c3-690c-08ddbfd584ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9776


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

The feature details are documented in the APM listed below [1].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.4.7 L3 Smart Data Cache
Injection Allocation Enforcement (SDCIAE)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537

The feature requires linux support of TPH (TLP Processing Hints).
The support is available in linux kernel after the commit
48d0fd2b903e3 ("PCI/TPH: Add TPH documentation")

The patches are based on top of commit (6.16.0-rc5)
commit b4ec95e3bc3f ("Merge x86/microcode into tip/master")

# Linux Implementation

Feature adds following interface files when the resctrl "io_alloc" feature
is supported on the resource:

/sys/fs/resctrl/info/L3/io_alloc: Report the feature status. Enable/disable the
				  feature by writing to the interface.

/sys/fs/resctrl/info/L3/io_alloc_cbm:  List the Capacity Bit Masks (CBMs) available
				       for I/O devices when io_alloc feature is enabled.
				       Configure the CBM by writing to the interface.

When CDP is enabled, these files will be created both in L3CODE and L3DATA.

# Examples:

a. Check if io_alloc feature is available
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

d. Change the CBM value for the domain 1:
	# echo 1=FF > /sys/fs/resctrl/info/L3/io_alloc_cbm

	# cat /sys/fs/resctrl/info/L3/io_alloc_cbm 
	0=ffff;1=00ff

d. Disable io_alloc feature and exit.

	# echo 0 > /sys/fs/resctrl/info/L3/io_alloc 
	# cat /sys/fs/resctrl/info/L3/io_alloc
	disabled

	# umount /sys/fs/resctrl/

---
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
  fs/resctrl: Update bit_usage to reflect io_alloc
  fs/resctrl: Introduce interface to display "io_alloc" support
  fs/resctrl: Add user interface to enable/disable io_alloc feature
  fs/resctrl: Introduce interface to display io_alloc CBMs
  fs/resctrl: Modify rdt_parse_data to pass mode and CLOSID
  fs/resctrl: Introduce interface to modify io_alloc Capacity Bit Masks

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/filesystems/resctrl.rst         |  79 +++-
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   1 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
 arch/x86/kernel/cpu/resctrl/core.c            |   9 +
 arch/x86/kernel/cpu/resctrl/internal.h        |   5 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        |  40 ++
 arch/x86/kernel/cpu/scattered.c               |   1 +
 fs/resctrl/ctrlmondata.c                      |  41 +-
 fs/resctrl/internal.h                         |  10 +
 fs/resctrl/rdtgroup.c                         | 374 +++++++++++++++++-
 include/linux/resctrl.h                       |  24 ++
 13 files changed, 558 insertions(+), 30 deletions(-)

-- 
2.34.1


