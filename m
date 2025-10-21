Return-Path: <linux-kernel+bounces-863881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FA2BF968E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 387945073D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AD328D8FD;
	Tue, 21 Oct 2025 23:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZsrIQla7"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A828725B;
	Tue, 21 Oct 2025 23:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090917; cv=fail; b=EPWMWZIIRQt6qsqke5GEm9eEnyjkuZpappB9kBPN68jAM8a7ESBEYgUvBvQnMQvKXhpDrrDiKBEB6a7rHZ0hyBJ8WhsHNEZ6yy4eyE6E1hPrIq23TKMtNd+lPm7XgaSq+IOF3rAK9CnGd6ag8Fjq69pG7/5PJF6evaYpjpM4OCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090917; c=relaxed/simple;
	bh=LUoT45vethiJbfY19CO2Y9hy102gMM7htNyc3VcXgdo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DK7OxAQ+Ca6O3xP9Ic7fDAQIVkX2ZdhLzk0+rRX5VfqZdLxsIYDSH3fytt6SoZwv4PltjRZRNSwvVDdLZ59NsBduPdq7kAV8sH24vQ2V4VIPKxcySPCJ2LvuUEyulwx0CijpROABjnqnifOg5ueQOtpOJnPIOXHidtPv8eikXU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZsrIQla7; arc=fail smtp.client-ip=40.93.195.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcuzvv7dhCUPaiu7q/lezJHILLuS0beFEti/kenDUmlK1N4o6RvQ6X4a/+tqy1TZT4XaScqoneI1zJhRWGTFo3Lq8/r417Ld8f/AMxWCAKwaZOH1ZQDX0iAwaWS5FZk21lox/Hm9pPOgm2IblBPNZduE4Itc5WuWMOq/uEstJjeefNFET684Yy0ORdCAjneoOEHCX3o691gMXnvarmMVCa8EF156aUDYydJripZDarvYxXMiNZIwQKjYCzHD2tXFk011c3sFGsAXnhEriMOO5UNVmzgorigpu9usS67tJaCbCObSmDPOkvd1pc7oguvFJVd1E4iLfbl7H7Cj4RLRyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/5gxDRPaIhORGVMURTRpsHpXYo+tf7xU6U6HeXxS+M=;
 b=ACd9wV82/JeTJJ2Km80gZg85p+MYnleuW9BT72sXJ/lJ2PgbmjSTSMLirxPNEnMbDlKVJHcM6u9dQobm4G1pYdxGhOOQiKZaNUAfnNJpd12rYx/ywbvP5dTFM3obAolpfc51c3qaT9LLnPPDR0vP1pztSJuhbuj9FutQw6miuRm1Q73rk7BbSYeQDRsJ/uxcCqygrTJjceBfCxdEMUbeN89gjXN3geYZTL/DYtsIBAP1GxgMt7QBcsHBeXpiq+X+nXnOv4Y8yLcYtqscIpc7DUaZGtimAHFZh2G1TuKjvHkeIBnWtnKbgjVBts/BP9NdRLFmHSCiNr/lMm7cpnClKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/5gxDRPaIhORGVMURTRpsHpXYo+tf7xU6U6HeXxS+M=;
 b=ZsrIQla7YAdkBf5f8D2Tt4Yx3K3aopK3/pA+KsLp/AAtjjxv6s58CwhtQRbfIyaXSBEL9E7RnqaMBiHb5FCb81LWbqIB7wmXFLGrYa1rmnS4pU1D+s3us/e2YdZqhQZGlZf3lgQ9NgLlqaHwsjVQFw29Nt7BP7aSDPLz+Rbnblc=
Received: from BL1PR13CA0303.namprd13.prod.outlook.com (2603:10b6:208:2c1::8)
 by SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 23:55:10 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:2c1:cafe::e9) by BL1PR13CA0303.outlook.office365.com
 (2603:10b6:208:2c1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 23:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Tue, 21 Oct 2025 23:55:09 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Oct
 2025 16:55:07 -0700
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
Subject: [PATCH v10 00/10] x86,fs/resctrl: Support L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE)
Date: Tue, 21 Oct 2025 18:54:43 -0500
Message-ID: <cover.1761090859.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|SJ2PR12MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: 075989f7-32f7-4705-23f7-08de10fd44af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6CbMrZE51//uDcYFonrqAJwTFQ+8u5eCecX7xNJehL76mCJR7S/iyjCT/FqQ?=
 =?us-ascii?Q?3FW5/By5sNP0k0BJsnclYn1VlZXMrhEgZ4bQvhwIisacm9JfG3EnVmuc+qQ5?=
 =?us-ascii?Q?eoPd81zvdw8P+zTOs9rt7uX1dkIN8aZxMtOMzieRDrM8B/p0s4ZgDklmvoC7?=
 =?us-ascii?Q?PDnKl8Lb1JytCwaaULlITvbCfiRHpoY4uWZG4jjIc3QqNK0UYYtG9YbIX3Md?=
 =?us-ascii?Q?NLlvJIStxXNR6LKQWIAIPqT9lVZIEp6LAAH1XVpUrcDQPm+Zt0U6bVTbd8Sn?=
 =?us-ascii?Q?n4MycUz6Iialwi+BbCHCnou9AGigDjPVCC59w20I3psFPiy/WNPG/Ja/aaXf?=
 =?us-ascii?Q?hbpHKD9rvK5XJvdOhJ6oWtSXLfwnaT+06o/kIJ6Y9/T/+xWM36DW0sEhRehH?=
 =?us-ascii?Q?XeYyQvPE11FfDWlFRRfYKFiJbt5bstk95EXTD6YLumD8DxH/Dx4/C/pVnuCs?=
 =?us-ascii?Q?SN95RghjSkhJBxRLRr/HG2lLkbr6/SuG4sUEnNXkiB3Uu7PfdMTT99XhkHiO?=
 =?us-ascii?Q?IBZuPfCs28CImsqpmepQhmuWyWYt+AtMweTVk0ElIi9Dd50tkOuFiNLIONwq?=
 =?us-ascii?Q?jSfy2e4TrRnxs1yPaqb70Pm8r6rwZvc8z6VbQtDeD/DvYL0O9JUm+ksUGJez?=
 =?us-ascii?Q?2cXOcCRuZXYOZCazETOFEM9XPiuE3tVyx/pVM73MYBb/SHRCcsSljnhOWI2d?=
 =?us-ascii?Q?lYGVLlHvlf5yWb2dKjONQavGROqE/ROtw6N+86Zla3hUQ6jOpvKBO5IwD8yD?=
 =?us-ascii?Q?oWy2V/08/EDdmyjkldxwmKWAeybHemd8HTzy+lhumlpNhxzgSu+hmwBv7wkw?=
 =?us-ascii?Q?lsPRkV/4T9h0i0uytneZ/OfkWxnYLUHhYzQXbrFeXOpMtdFcQstliGw9ia+Z?=
 =?us-ascii?Q?FaIPMMq9OYyuBp9IHUG3jOeiRQ9yWqexhk1udneO+1sLXV7XF/DI4O1pTkgw?=
 =?us-ascii?Q?zvbn9+uVv58yYJTwQ/XdrjbDsq9QKr9CKcXvTtgigO+OO5DRLC3dyDiis0zE?=
 =?us-ascii?Q?K95VlGUPSV/UlFX9UH7c533TCyy+gNcliYM/c7y0BuOfqIUFGvreg5L47MEK?=
 =?us-ascii?Q?5pm3dmmgusrbDmg+K4Vim8Cz+c22M1HKNEAwQuT4bov9iZRO8vE9d6xop/Zq?=
 =?us-ascii?Q?VurKKD8v8r8BjMZKDT0ZsuA2RJyhMl7KFEV3BOWHOdfDx0DAVf2lmesWS+Ba?=
 =?us-ascii?Q?GXi0uIhRjE4DaOHhwwIZSQyDb65jJ/XduErXonnvy9xfc67Y+oFwtgGkc9uP?=
 =?us-ascii?Q?u6yHgrR+Xm3stjfQgt4VvXVwDXMGGwjNRS87MS33+8q1iGZzwMirmk2qHf0u?=
 =?us-ascii?Q?LUiFp8jkYh2OoYZCBIM/0i1VJ8fijKU+Hm/7lCVdmvOkGlvVj1MDMX91OAwu?=
 =?us-ascii?Q?f61LNxFf63ojv0X2ebLa0DIJnJDksqgLynqSIW1KvJQACI4BXnn+UyoD7K08?=
 =?us-ascii?Q?0PZdEx+/LdQ/GkUbbM1MsH0oasB8OqoD2/j9xUS6EPNbjdvziKK8SfISu07r?=
 =?us-ascii?Q?MAxG87Jw6CwP4FJDxu5JEb4zh5BgWi+Qqnp2Mr7EGBKZ1zhyHUuX5f5noN+d?=
 =?us-ascii?Q?1TvUexMwyWWwN3CMYwM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 23:55:09.7889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 075989f7-32f7-4705-23f7-08de10fd44af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181


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

The patches are based on top of commit (v6.18.0-rc2)
commit a417e63bf225 (tip/master) ("Merge branch into tip/master: 'x86/sgx'")

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
 Documentation/filesystems/resctrl.rst         | 127 ++++++--
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
 arch/x86/kernel/cpu/resctrl/core.c            |   9 +
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |  40 +++
 arch/x86/kernel/cpu/resctrl/internal.h        |   5 +
 arch/x86/kernel/cpu/scattered.c               |   1 +
 fs/resctrl/ctrlmondata.c                      | 305 +++++++++++++++++-
 fs/resctrl/internal.h                         |  20 ++
 fs/resctrl/rdtgroup.c                         |  75 ++++-
 include/linux/resctrl.h                       |  24 ++
 12 files changed, 566 insertions(+), 44 deletions(-)

-- 
2.34.1


