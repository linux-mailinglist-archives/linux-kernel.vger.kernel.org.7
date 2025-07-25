Return-Path: <linux-kernel+bounces-745690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 201FAB11D1E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E791899CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950572E54CA;
	Fri, 25 Jul 2025 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uleDv8os"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB32E4271
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441611; cv=fail; b=kYjtkgnsQxG6Ovn2RPWq7xNwaCbKiEnOVpxAaXAFVTsHAxV1jn6fvWE9a99tZepUDQmElNLKo4Y780Qsct7tF4cEiD6fpqNycUVFDnptF8f8lE8xKnPGQwun97EiIgqf5n2tbvdBeU58zftQ7GAI0X7y18ma/+FxOnYYdYrkiNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441611; c=relaxed/simple;
	bh=oMW8vtfsat9VwvLp3+zTwm0VobUF0GVgcAYrEv47Pek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tBh6pTgwG/tef52J6P3/4DpHdHaI8i81+wLCYDBGOxkFw0SSjbBsaDoTWlgCdaCa4zrx3g6hZ6G8/CaKru+K5JDnRHkp7WEeauQIqqTJrYKku+tgL+K535wc3xAY0V/rKxM2rfKKV2w6d64uAMElobpe8lm8WzVv4w86579edvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uleDv8os; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltcWMtTFGKWNwFnBgLMfojF9PE353du/VQu8sZolutIXJJHVlaSeRsAbvgbmkwv4AmjQh7Vuh+iZ5Ig5BPuejP0qIA1ImWrecfbwa43JIxmN7OkBfcku+X60xL4DwIssIPBjanArOWj9kB0oiVSBjDIZTsdW6BsFVAvt9c04xAphM7Bww6MjEkBK3NoAuT7hieHOOeaC9h/W7RLcgvO/vCf+nXjwmb5nXWNfpI2sc4OHT34CTYZFzXJnKIngqq1hHZSMpUwk+B9bL8rIIu22WydeXIs8wxmo6tn6QOHgUVB3T3fuc3Y/hAjFHDfR0Eg6RexuEwFVr1ZX9xBVynA3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQZQgusDJwskkNj29B8gmgPc0LYwhBHnG1hJ97nbXVU=;
 b=TWdvD+uDOOQdjN2t/Mud57bdRJPIFLYsoZgibcsmWwV68r17js3PFKGkWpSKF4OVygoSV/S8cZe7oEj2DF2vqST5OMyQV0k/fv3b0kQJjhVHLZEtVN+shUb2AmxMCVd43g3UoU3HG34fwnvusGFrtglgEjMz8/mwkWuUpJTHxhfEYF67ad111abNgJZzFRv1L5fOYoigg1q3Z1q1Zu3D7wg6wC7fo5EPv+1aF26KbN6szQKo3LcPA0RxQ6qUuZOGezI2jB5UOoQc9HrzuG0pQkGizj+YQ3jU6wxqHBi+DQwo4mg4K2OfV8iqemNclhJxWBYkhSLuvb2+126rVZiyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQZQgusDJwskkNj29B8gmgPc0LYwhBHnG1hJ97nbXVU=;
 b=uleDv8osZsalY+6tGdXYJ46+RCH0Lq7xqm4FlQQjuc7mbpIiFg44fE1fU35z6G+gCVavUJBU/dprdH0HqEcGMNGvJZkTfZHOvdv8JBXSahp7cZzWyWLlOECewbCUISwXuWcjmzIiC8LzDmk81uOk8GupFd0sidKyVJjws8vdS88=
Received: from MW4PR03CA0068.namprd03.prod.outlook.com (2603:10b6:303:b6::13)
 by BY5PR12MB4274.namprd12.prod.outlook.com (2603:10b6:a03:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 11:06:44 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::c1) by MW4PR03CA0068.outlook.office365.com
 (2603:10b6:303:b6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Fri,
 25 Jul 2025 11:06:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 11:06:44 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 06:06:39 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: Naveen rao <naveen.rao@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, "Xin Li (Intel)" <xin@zytor.com>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, <linux-kernel@vger.kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, Babu Moger <babu.moger@amd.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>
Subject: [PATCH v2 0/3] x86/cpu/topology: Work around the nuances of virtualization on AMD/Hygon
Date: Fri, 25 Jul 2025 11:06:19 +0000
Message-ID: <20250725110622.59743-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|BY5PR12MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ccd0459-3b37-41ef-1a40-08ddcb6b5763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ye8lMu9toLZYelKBWncbsu2/khWn5I+VYB073cFCfmd1c2syxT8vXS0rtVK9?=
 =?us-ascii?Q?twAimzQYSJejS/y8+W9KNeP1z1Kfjr8GL6/PVtxgrcHItQnMiCzYeoyV1MNa?=
 =?us-ascii?Q?RP8smnL1JHNfR+SX+vTmwSljhuvclC//xSrO2yST+L8r7idOMbK5mK+KIg08?=
 =?us-ascii?Q?62TiIS3nozQ5HodUKlVYtRlbsYHnzb1lX2B5dUcm69yF4JW7Y/V0oryM6LJB?=
 =?us-ascii?Q?rEYkaA80nB/loA1kkU3CHC8nBlX3YOW4uyaUnMqmsf3hO84xq6JBNvwa0Sdn?=
 =?us-ascii?Q?sRgqdCQgnVs4tkA3Vdr80V+5xCD+8HT4hEXmwWc+F/hyQpflq4rYbVD0hCCL?=
 =?us-ascii?Q?nGpqOdt/Hn1OzTNkC/RJMdc2WrEp/4N6VkUE9FIiWtj1IaY8sJKz+ym29FxB?=
 =?us-ascii?Q?PlY9gF/uN0gXikdx++NsQUgcKqomW3nLlHc1H/EKSHFO0N/yPWAJkUt1DqOF?=
 =?us-ascii?Q?s97UTcb+csjeeNzLZ7pwhtKk7tlQzh4GPi4Ma3PSdMjbIzGFEb7NKh1zDbj1?=
 =?us-ascii?Q?p+Ilu4FTeP04Q2G6/HoL61hVZCmmGj/fPQ+91YymlgWp5e78Q0QPYgh8hIuY?=
 =?us-ascii?Q?LldLT9CBtS9WodjhuANQqS2HBEB8gwDcTHDcTiX6KMJ85n6MTWqfZAu3wujs?=
 =?us-ascii?Q?hdfetY0j+loLyadDLAFilOKQXr6js4St+VKlMIzLyWByxmUVkmfLd8zAQXqG?=
 =?us-ascii?Q?IeP7AEk/RRLxiJjCUEkFYeo8oNUpNtj3tvPDMWsPuGG3q3DL/TUuLzMTbr2X?=
 =?us-ascii?Q?gukdyYMPkgARBrzsuawhMGgkpLtbynZQLGaTQWKdyVwoRcRdddLvF77mzSMm?=
 =?us-ascii?Q?72NZb9Xh5NVEJ3BPRH//D4UBAPja4vhbqCEYdIemwm8B4JH2BpUG4TmSiPti?=
 =?us-ascii?Q?YBw7TdZIXvt6lWfGecTHW9tws6O+uJ7RddnIEOkjrs1hCV0y3LRFGsWSqKK8?=
 =?us-ascii?Q?MGF0V1GROJxl68SmKcBCtszd6vJEkjUi4xyplbnPgXP/ITlukN3RoD2e4+YE?=
 =?us-ascii?Q?9Kp6zwLdW0gG+c+F17aqc2HAHEVUudYK0NcNox1iBuDxYXcpYh3RhE2EtIqw?=
 =?us-ascii?Q?LTw0Bg/jyj2Sd3C2TsCqCek+8g3F9/XJI+parB0hZ5xpndSAtnWNYD8PyxgA?=
 =?us-ascii?Q?ziCivBeDW61TsPYmk04C7bWxcdZpyv7VQVYIqiIumEq+3PWZDw716EuVTAI0?=
 =?us-ascii?Q?fZzsJbTQi9gMgILzW0+mhZ829eOjVTCpQujki25ZY3Vl7pZoSJ6N+uVkP66S?=
 =?us-ascii?Q?knEaJBhdE7InHZljC7/yp4Yb3M7z1YAWKXbfczkgSf70uTa3DXWOhN7+2TXL?=
 =?us-ascii?Q?5C8m9Z901GbKNGgN0BXo0DnTHaei/x7VvkXfY6MxmcJo3zSM0tWowntTr1Nb?=
 =?us-ascii?Q?x0R4qv/qDlIjoHMzUmSYAs8h8SMILIL1F881iRhJulPtyUr51R6BgjtPsutS?=
 =?us-ascii?Q?XkqM6EVLLhRc1pDujJ89zdzUFQS3sUwMlPdgosqgR+2hukhnxFlsdW5GSdcQ?=
 =?us-ascii?Q?I2P9v0I78qmMgGxNsDx8quiTy+MBzgYhpYHTuLWLhtb2y4ViZpqLZOHy+Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 11:06:44.3680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccd0459-3b37-41ef-1a40-08ddcb6b5763
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274

When running an AMD guest on QEMU with > 255 cores, the following FW_BUG
was noticed with recent kernels:

    [Firmware Bug]: CPU 512: APIC ID mismatch. CPUID: 0x0000 APIC: 0x0200

Naveen, Sairaj debugged the cause to commit c749ce393b8f ("x86/cpu: Use
common topology code for AMD") where, after the rework, the initial
APICID was set using the CPUID leaf 0x8000001e EAX[31:0] as opposed to
the value from CPUID leaf 0xb EDX[31:0] previously.

This led us down a rabbit hole of XTOPOEXT vs TOPOEXT support, preferred
order of their parsing, and QEMU nuances like [1] where QEMU 0's out the
CPUID leaf 0x8000001e on CPUs where Core ID crosses 255 fearing a
Core ID collision in the 8 bit field which leads to the reported FW_BUG.

Following were major observations during the debug which the two
patches address respectively:

1. The support for CPUID leaf 0xb is independent of the TOPOEXT feature
   and is rather linked to the x2APIC enablement. On baremetal, this has
   not been a problem since TOPOEXT support (Fam 0x15 and above)
   predates the support for CPUID leaf 0xb (Fam 0x17[Zen2] and above)
   however, in virtualized environment, the support for x2APIC can be
   enabled independent of topoext where QEMU expects the guest to parse
   the topology and the APICID from CPUID leaf 0xb.

2. Since CPUID leaf 0x8000001e cannot represent Core ID without
   collision for guests with > 255 cores, and QEMU 0's out the entire
   leaf when Core ID crosses 255. Prefer initial APIC read from the
   XTOPOEXT leaf before falling back to the APICID from 0x8000001e
   which is still better than 8-bit APICID from leaf 0x1 EBX[31:24].

More details are enclosed in the commit logs.

Ideally, these changes should not affect baremetal AMD/Hygon platforms
as they have supported TOPOEXT long before the support for CPUID leaf
0xb and the extended CPUID leaf 0x80000026 (famous last words).

Patch 3 is yak shaving to simplify the flow and avoid passing around
"has_topoext" when the same can be discovered using
X86_FEATURE_XTOPOLOGY.

This series has been tested on baremetal Zen1 (contains topoext but not
0xb leaf), Zen3 (contains both topoext and 0xb leaf), and Zen4 (contains
topoext, 0xb leaf, and 0x80000026 leaf) servers with no changes
observed in "/sys/kernel/debug/x86/topo/" directory.

The series was also tested on 255 and 512 vCPU (each vCPU is an
individual core from QEMU topology being passed) EPYC-Genoa guest with
and without x2apic and topoext enabled and this series solves the FW_BUG
seen on guest with > 255 VCPUs. No changes observed in
"/sys/kernel/debug/x86/topo/" for all other cases without warning.
0xb leaf is provided unconditionally on these guests (with or without
topoext, even with x2apic disabled on guests with <= 255 vCPU).

In all the cases initial_apicid matched the apicid in
"/sys/kernel/debug/x86/topo/" after applying this series.

Relevant bits of QEMU cmdline used during testing are as follows:

    qemu-system-x86_64 \
    -enable-kvm -m 32G -smp cpus=512,cores=512 \
    -cpu EPYC-Genoa,x2apic=on,kvm-msi-ext-dest-id=on,+kvm-pv-unhalt,kvm-pv-tlb-flush,kvm-pv-ipi,kvm-pv-sched-yield,[-topoext]  \
    -machine q35,kernel_irqchip=split \
    -global kvm-pit.lost_tick_policy=discard
    ...

References:

[1] https://github.com/qemu/qemu/commit/35ac5dfbcaa4b

Series is based on tip:x86/cpu at commit 65f55a301766 ("x86/CPU/AMD: Add
CPUID faulting support")
---
Changelog v1..v2:

o Collected tags from Naveen. (Thank you for testing!)

o Rebased the series on tip:x86/cpu.

o Swapped Patch 1 and Patch 2 from v1.

o Merged the body of two if blocks in Patch 1 to allow for cleanup in
  Patch 3.
---
K Prateek Nayak (3):
  x86/cpu/topology: Use initial APICID from XTOPOEXT on AMD/HYGON
  x86/cpu/topology: Always try cpu_parse_topology_ext() on AMD/Hygon
  x86/cpu/topology: Check for X86_FEATURE_XTOPOLOGY instead of passing
    has_topoext

 arch/x86/kernel/cpu/topology_amd.c | 48 ++++++++++++++++--------------
 1 file changed, 25 insertions(+), 23 deletions(-)


base-commit: 65f55a30176662ee37fe18b47430ee30b57bfc98
-- 
2.34.1


