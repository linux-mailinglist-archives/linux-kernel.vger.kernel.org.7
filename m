Return-Path: <linux-kernel+bounces-850715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5943ABD39B1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A911896305
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD903081D6;
	Mon, 13 Oct 2025 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VR7GsXkE"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88F626A0AF
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366128; cv=fail; b=gyQV1etj3GexfteaVWhaXzPWSkIrblbWu5j7bi4+vG1LV406dfpxRjBX0PDpbR4EhkwvX/E/RNU4awwDLpVZKtVJ3dmgQYsrGg+W840umNf75phHY5POiLucGjzN2kzSRBQgluosRWqVRRkrmJ2e1DXm6e8xGeGfmhblEc0+qQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366128; c=relaxed/simple;
	bh=n6F4QTqVp9J8A0CtdJUdmyBofxkompSnxyz7xacqd9I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PhnhangIAnoew0lPyj+4FCYS//d0CN9afoj8N8MVvfXivGnRaeDvShQ09udj3VFdnW3Z+dW5GaChfn7HIMIc4qLfvLDQ0hfEyYQqwFDpeF6D1PkpyfIqbNH5qzPoqimw4oHO+F4A9UjAonsEMwLBhGk/JLnB7RHOYF+FNZexnh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VR7GsXkE; arc=fail smtp.client-ip=52.101.46.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDbSkvMjXjJIx0Qi19otl9y+OIbwxAI2OJiny8Dg3j4YushxAO6pnou0jAnXGwPuYh87BxgGHE99p73C8K5qdRnheGX4YHkXq8AMAxby/xb0qoBS7AUIXQmJ4GK/lUOcL2yPP0SIBIVR/GXy9S+3j9yb3h99IQgeyVMwvjE/UY7Ku9dvaEdJBl5JgdZTW06Q8Z1KaD/dYbzBJeruiFFLz9sQ2ANu42yor2DuP4Hs/OFxpqHCDgNG+XAlfgMfO5En38IrVNUkISxgL5SxD32R1SbQ97rX0UTn3bwdsahIW9Bt8tM3lfAIUOomFXEjGObkTYx6YutVFnBhu8MUuYy6gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxTLW5AP1iN0IHnQeEaSC/gpj6xTD2vied+LHOPAZmY=;
 b=wgJZndzVfiLZQr1pesvR8dPiEh68ccUUv1BA6JhrdUTIqL6w+ORk3Q2M3AxJT0xLevDRVuO7KO9fuPxrP2fj+cRKq9HZnlrWC7e6JAxAVEByD0RdqMTYm1+oOsEx1yb7G6faPpA5jQXVLAVtVepp7cghSajPs0wH+RgNuPTl1YSLCmz1bCZrbsJAIiDQwNN/91a3JGEUaHZsqQrnb/6s9ZDGnhZavZdYkMq97n1LS37UysLXc8rs7/Yen089XXQg6vxbFROOLzS5BtZyYSdbRnU7mFiZv7yi8wAGAiw/S/7v2WsFy6MgRDy1wQJLHnzgvYxrUK8HsamOAav5RN5dwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxTLW5AP1iN0IHnQeEaSC/gpj6xTD2vied+LHOPAZmY=;
 b=VR7GsXkE/oYATPddVMrs+EZTmy1hfKWlXSXYaWOsoreKyVOGU4YxVX9iXCpgIpYEuKsX3POvwxLkSpym0wOiBQirVGXnDH0wp0EkxP53W8kZw8G12R77POkDMXwtsMr/nt3vxJLJwQ4h51oidk1gAQnkpffn4FNg52JFnML2Wv8=
Received: from PH8PR02CA0045.namprd02.prod.outlook.com (2603:10b6:510:2da::33)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 14:35:19 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::6e) by PH8PR02CA0045.outlook.office365.com
 (2603:10b6:510:2da::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:16 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:15 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 00/56] Dynamic mitigations
Date: Mon, 13 Oct 2025 09:33:48 -0500
Message-ID: <20251013143444.3999-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|DM4PR12MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c31755f-da53-45d8-5495-08de0a65ba6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4nTyJF6wRVirIuYuK0v4wsB9k0aeX9hQbNqg/UjleJmK59aa+J13tlgmY+a6?=
 =?us-ascii?Q?UEkC1yAi43JUY6EAFinOW3dWUoYCWYa8kDWa/yqBOZtzrsbp/XL4c2Ow4w2L?=
 =?us-ascii?Q?yZJ3HQZrj6PvDSp2wZSBfr3YO1ZUebHJAYuC1Gtzi1M5ekNH2Aqj76B9TX5b?=
 =?us-ascii?Q?Bv/4X2FKzXG9zTXEEphFR6xFAdfquV2LKBz2oGyAUl/vls4rSJr0AFDhGdNH?=
 =?us-ascii?Q?HatYT140A9vtsNbGeAW7HbqSwN/rksMdILkBx/JHJ69bV+y2icG5Q8ukZHUt?=
 =?us-ascii?Q?bcJa4XndnU9V1Dt5JUwvS1dqkOtlw0MkQIHHubnUoYgbYotVNGS1DvWFGw6r?=
 =?us-ascii?Q?IYmfOej6QgKf1yZert5Fb//En0EXCiOczWsOh6kHrLMeBRexOUCB/MfiIWth?=
 =?us-ascii?Q?ZxJa//7ECbZHu8fPN9+jSY63lff/0Fs/nS78w/uM04rxuQEw0JN1PNihfEWs?=
 =?us-ascii?Q?uXzQVozrpo/zkZKnFDxBtX8XDkmpVPTRP8umF4Z5Xhbtn8zn/fVxlKw3j3w6?=
 =?us-ascii?Q?NkKx46OkWZdR6APlc36M7+qIbSP1HlBriAaNWc+I4c2XobxSK4E7OrMjybUf?=
 =?us-ascii?Q?ystIDut1HDu7ldcDSSUYuPRfo7qlBeV2dUATxj25ksblWiFx1/hWMXrwYQ7R?=
 =?us-ascii?Q?ASIjgkWOJm4r4wkWUWo1hqJWzRD+oMQScYT4w2P1nwDqc4UwwQoKT0xbolm/?=
 =?us-ascii?Q?bxtcUI784nTc9aYk+DaDqQtOfEACemSbdjvXAGcROXWLjI1eSpPIzYR9VgTm?=
 =?us-ascii?Q?TsyMOS0KGWhhKUQwwLmY0bfHTFjevC+ZuvcRox1z+T1gfb54EE5mDZxytDHZ?=
 =?us-ascii?Q?OXEURYMiu3bUU8NQY6tZWdZUIYcMVlYueD5/F+7Djb+26t/+Hl/ZEDzfZw0k?=
 =?us-ascii?Q?peXeI/M5jIv2h3XLSCMd0uknESQOjHpZa9dvFeSOQVyhafTuMgLswgOqJM3c?=
 =?us-ascii?Q?ldCHaQsR6DeNGmpozgnu3rMuubqWC8bOBussePB0wTeuxio0LI66CEKOPMSY?=
 =?us-ascii?Q?ZPEuo8ck0wOpil+m2ndBVct4QrOJZmVP/48w5XvVhq0jebIiJw1gQSPHkd8a?=
 =?us-ascii?Q?UCowB51r3Lz7BhZgfDRaJ+yESQN0eind24Maz4PtGR7f9b/D9dwwc/OXdANW?=
 =?us-ascii?Q?wri3jgh7SUvHQjvPL2oGnBzBLDfo4QsUc7qCcPolfAA20SztjfBsq6i3Tk2n?=
 =?us-ascii?Q?sOyjBuhDCqvcckufUkz8ykyVQH2F7C7FmJLbEH9gqWBU1UuQouqnzizxmpgF?=
 =?us-ascii?Q?u6Cac5PalCuk38QsbkZpX3LiCArKkSQ8EzQeEe7xGAEt77r8UpwNB2SOX8Zf?=
 =?us-ascii?Q?OvqUHkSLkkg6vqzjgeJ4OjU1EQbv1c6G6ajgvAY8FFhvkMOmXrAmkkaatCRU?=
 =?us-ascii?Q?O5IHqZfse/Chtz+8KHjjAMlVI5yfkIXrU2BYvojyb+PTilqfDN8n3AZZrBq6?=
 =?us-ascii?Q?wUb1YqSlEil1T5XOtnXWx7G4WRtD5lZtFzeBGbyAlvEjqESJMRoF9U9Nn/t4?=
 =?us-ascii?Q?jY7XUSxK8dKSI7AEszXXTxWavXiipOLbbbsLfAT4hLOc9X4jmWS7NlxpD8d+?=
 =?us-ascii?Q?eCyd8FYbwVdA4tOrPWs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:16.8044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c31755f-da53-45d8-5495-08de0a65ba6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574

Dynamic mitigations enables changing the kernel CPU security mitigations at
runtime without a reboot/kexec.

Previously, mitigation choices had to be made on the kernel cmdline.  With
this feature an administrator can select new mitigation choices by writing
a sysfs file, after which the kernel will re-patch itself based on the new
mitigations.

As the performance cost of CPU mitigations can be significant, selecting
the right set of mitigations is important to achieve the correct balance of
performance/security.

Use
---
As described in the supplied documentation file, new mitigations are
selected by writing cmdline options to a new sysfs file.  Only cmdline
options related to mitigations are recognized via this interface.  All
previous mitigation-related cmdline options are ignored and selections are
done based on the new options.

Examples:
   echo "mitigations=off" > /sys/devices/system/cpu/mitigations
   echo "spectre_v2=retpoline tsa=off" > /sys/devices/system/cpu/mitigations


There are several use cases that will benefit from dynamic mitigations:

Use Cases
---------
1. Runtime Policy

Some workflows rely on booting a generic kernel before customizing the system.
cloud-init is a popular example of this where a VM is started typically with
default settings and then is customized based on a customer-provided
configuration file.

As flows like this rely on configuring the system after boot, they currently
cannot customize the mitigation policy.  With dynamic mitigations, this
configuration information can be augmented to include security policy
information.

For example, a cloud VM which runs only trusted workloads likely does not
need any CPU security mitigations applied.  But as this policy information
is not known at boot time, the kernel will be booted with unnecessary
mitigations enabled.  With dynamic mitigations, these mitigations can be
disabled during boot after policy information is retrieved, improving
performance.

2. Mitigation Changes

Sometimes there are needs to change the mitigation settings in light of new
security findings.  For example, AMD-SB-1036 advised of a security issue
with a spectre v2 mitigation and advised using a different one instead.

With dynamic mitigations, such changes can be made without a reboot/kexec
which minimizes disruption in environments which cannot easily tolerate
such an event.

3. Mitigation Testing

Being able to quickly change between different mitigation settings without
having to restart applications is beneficial when conducting mitigation
development and testing.

Note that some bugs have multiple mitigation options, which may have
varying performance impacts.  Being able to quickly switch between them
makes evaluating such options easier.


Implementation Details
----------------------
Re-patching the kernel is expected to be a very rare operation and is done
under very big hammers.  All tasks are put into the freezer and the
re-patching is then done under the (new) stop_machine_nmi() routine.

To re-patch the kernel, it is first reverted back to its compile-time
state.  The original bytes from alternatives, retpolines, etc. are saved
during boot so they can later be used to restore the original kernel image.
After that, the kernel is patched based on the new feature flags.

This simplifies the re-patch process as restoring the original kernel image
is relatively straightforward.  In other words, instead of having to
re-patch from mitigation A to mitigation B directly, we first restore the
original image and then patch from that to mitigation B, similar to if the
system had booted with mitigation B selected originally.


Performance
-----------
Testing so far has demonstrated that re-patching takes ~50ms on an AMD EPYC
7713 running a typical Ubuntu kernel with around 100 modules loaded.

Guide to Patch Series
---------------------
As this series is rather lengthy, this may help with understanding it:

Patches 3-18 focus on "resetting" mitigations.  Every bug that may set feature
flags, MSRs, static branches, etc. now has matching "reset" functions that will
undo all these changes.  This is used at the beginning of the re-patch flow.

Patches 20-22 move various functions and values out of the .init section.  Most
of the existing mitigation logic was marked as __init and the mitigation
settings as __ro_after_init but now these can be changed at runtime.  The
__ro_after_init marking functioned as a defense-in-depth measure but is arguably
of limited meaningful security value as an attacker who can modify kernel data
can do a lot worse than change some speculation settings.  As re-patching
requires being able to modify these settings, it was simplest to remove them
from that section.

Patches 23-27 involve linker and related modifications to keep alternative
information around at runtime instead of free'ing it after boot.  This does
result in slightly higher runtime memory consumption which is one reason why
this feature is behind a Kconfig option.  On a typical kernel, this was measured
at around 2MB of extra kernel memory usage.

Patches 28-30 focus on the new stop_machine_nmi() which behaves like
stop_machine() but runs the handler in NMI context, thus ensuring that even NMIs
cannot interrupt the handler.  As dynamic mitigations involves re-patching
functions used by NMI entry code, this is required for safety.

Patches 31-40 focus on support for restoring the kernel text at runtime.  This
involves saving the original kernel bytes when patched the first time and adding
support to then restore those later.

Patches 41-44 start building support for updating code, in particular module
code at runtime.

Patches 45-47 focus on support for the Indirect Target Selection mitigation
which is particularly challenging because it requires runtime memory allocations
and permission changes which are not possible in NMI context.  As a result, ITS
memory is pre-allocated before entering NMI context.

Patch 50 adds the complete function for resetting and re-patching the kernel.

Patches 51-53 build the sysfs interface for re-patching and support for parsing
the new options provided.

Patches 54-56 add debugfs interfaces to values which are important for
mitigations.  These are useful for userspace test utilities to be able to force
a CPU to appear to be vulnerable or immune to certain bugs as well as being able
to help verify if the kernel is correctly mitigating various vulnerabilities.

David Kaplan (56):
  Documentation/admin-guide: Add documentation
  x86/Kconfig: Add CONFIG_DYNAMIC_MITIGATIONS
  cpu: Reset global mitigations
  x86/bugs: Reset spectre_v1 mitigations
  x86/bugs: Reset spectre_v2 mitigations
  x86/bugs: Reset retbleed mitigations
  x86/bugs: Reset spectre_v2_user mitigations
  x86/bugs: Reset SSB mitigations
  x86/bugs: Reset L1TF mitigations
  x86/bugs: Reset MDS mitigations
  x86/bugs: Reset MMIO mitigations
  x86/bugs: Reset SRBDS mitigations
  x86/bugs: Reset SRSO mitigations
  x86/bugs: Reset GDS mitigations
  x86/bugs: Reset BHI mitigations
  x86/bugs: Reset ITS mitigation
  x86/bugs: Reset TSA mitigations
  x86/bugs: Reset VMSCAPE mitigations
  x86/bugs: Define bugs_smt_disable()
  x86/bugs: Move bugs.c logic out of .init section
  x86/callthunks: Move logic out of .init
  cpu: Move mitigation logic out of .init
  x86/vmlinux.lds: Move alternative sections
  x86/vmlinux.lds: Move altinstr_aux conditionally
  x86/vmlinux.lds: Define __init_alt_end
  module: Save module ELF info
  x86/mm: Conditionally free alternative sections
  stop_machine: Add stop_machine_nmi()
  x86/apic: Add self-NMI support
  x86/nmi: Add support for stop_machine_nmi()
  x86/alternative: Prepend nops with retpolines
  x86/alternative: Add module param
  x86/alternative: Avoid re-patching init code
  x86/alternative: Save old bytes for alternatives
  x86/alternative: Save old bytes for retpolines
  x86/alternative: Do not recompute len on re-patch
  x86/alternative: Reset alternatives
  x86/callthunks: Reset callthunks
  x86/sync_core: Add sync_core_nmi_safe()
  x86/alternative: Use sync_core_nmi_safe()
  static_call: Add update_all_static_calls()
  module: Make memory writeable for re-patching
  module: Update alternatives
  x86/module: Update alternatives
  x86/alternative: Use boot_cpu_has in ITS code
  x86/alternative: Add ITS re-patching support
  x86/module: Add ITS re-patch support for modules
  x86/bugs: Move code for updating speculation MSRs
  x86/fpu: Qualify warning in os_xsave
  x86/alternative: Add re-patch support
  cpu: Parse string of mitigation options
  x86/bugs: Support parsing mitigation options
  drivers/cpu: Re-patch mitigations through sysfs
  x86/debug: Create debugfs interface to x86_capabilities
  x86/debug: Show return thunk in debugfs
  x86/debug: Show static branch config in debugfs

 .../ABI/testing/sysfs-devices-system-cpu      |   8 +
 .../hw-vuln/dynamic_mitigations.rst           |  75 ++
 Documentation/admin-guide/hw-vuln/index.rst   |   1 +
 arch/x86/Kconfig                              |  12 +
 arch/x86/entry/vdso/vma.c                     |   2 +-
 arch/x86/include/asm/alternative.h            |  51 +-
 arch/x86/include/asm/bugs.h                   |   4 +
 arch/x86/include/asm/module.h                 |  10 +
 arch/x86/include/asm/sync_core.h              |  14 +
 arch/x86/kernel/alternative.c                 | 497 ++++++++++++-
 arch/x86/kernel/apic/ipi.c                    |   7 +
 arch/x86/kernel/callthunks.c                  |  85 ++-
 arch/x86/kernel/cpu/bugs.c                    | 686 +++++++++++++-----
 arch/x86/kernel/cpu/common.c                  |  65 +-
 arch/x86/kernel/cpu/cpu.h                     |   4 -
 arch/x86/kernel/fpu/xstate.h                  |   2 +-
 arch/x86/kernel/module.c                      |  96 ++-
 arch/x86/kernel/nmi.c                         |   4 +
 arch/x86/kernel/static_call.c                 |   3 +-
 arch/x86/kernel/vmlinux.lds.S                 | 110 +--
 arch/x86/mm/init.c                            |  12 +-
 arch/x86/mm/mm_internal.h                     |   2 +
 arch/x86/tools/relocs.c                       |   1 +
 drivers/base/cpu.c                            | 113 +++
 include/linux/cpu.h                           |  10 +
 include/linux/module.h                        |  11 +
 include/linux/static_call.h                   |   2 +
 include/linux/stop_machine.h                  |  32 +
 kernel/cpu.c                                  |  62 +-
 kernel/module/main.c                          |  78 +-
 kernel/static_call_inline.c                   |  22 +
 kernel/stop_machine.c                         |  79 +-
 32 files changed, 1876 insertions(+), 284 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/dynamic_mitigations.rst


base-commit: a5652f0f2a69fadcfb2f687a11a737a57f15b28e
-- 
2.34.1


