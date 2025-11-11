Return-Path: <linux-kernel+bounces-895680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 135E3C4EA48
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5565E188F5E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB9C335067;
	Tue, 11 Nov 2025 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fIOBFml2"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049552F8BEE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872858; cv=fail; b=IUqMoPtKUy/o6nm+Nw5wHL42xTvqrPqoG31TqionC3WPXVIlFEigpo5YvYkOjcnut0ezfAn5wcRxexABrWrjj1RJ3Vo/20uJHEGGNxru2Z8dQHH0wAhyMvQDbO3iDlxDYV8Ri+tpSQDono5Gf9UGEqQOy27O0IQhjP1YOZSUSDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872858; c=relaxed/simple;
	bh=uR0D6CQjAYKSn19+7PPbn3tAkQqWfZP3a/AJpW5bNSk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KWXztUguK7o7J1+OWehpzSEk3zNMEhb3khsEL/vi9syX5juzmQM8aFsMm3Y9cNOMUhcuAMGdxw3ELzTSn4mxtGs7iJbc1kbGIYEdid2FArfyi132UnOpUCvLtk3iCJYqNqDCsX3YWPI+P4oK8FVLWVf0J/2YTzuRfD6plDagIEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fIOBFml2; arc=fail smtp.client-ip=52.101.85.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePJ2WGugsO903qw7Kayeuw2Q1h3292qJLEZmOSVK6vYJBJBK9zqUZrcwiT0jNM33ccAq2cGWn5Zb2UZHRuumbhgua0pM9ttJmUabsxmeIPcpH+gHhqumiDCR3hRVVmjUcrBvyVHs4bJFgb0tUM4zrUM2EpR4wwqqKMANJwVSplMC8Acj0D0mqQiQim8JkQMqyDrnMpyqRwW/J+uSt6FB+6MFQQIJ6TvB2UlH78PYLYhftR2oQrr8a5yn7JLzuKEesFg2GmPCqE0nfU9CM3KreoeX36pMiSJF+ReaJ3VtC/DIPIsdL1EssrM+93BymR2zZf2EeticA9QJ9zkW2BIlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ly6Tqcl2wfduKkMPMO9UWWk/rMOLN8x9PxjZnUD/8v4=;
 b=Sa0jc3/wO1Nhby97/XU8oGsFGGa74yDFOGki1kYpYjJFr512hNuf8483wGOZLlPvvJBJ+rcqSRYLyiceNs/BCdEkwr/B3A3Ojr7lt/T3gV+bMmOmKJBlR1IrwCLa28ul5905f718avpuFM0z0sayaLyP+7RdkAa8/lwxedkE8VU5ksqrgnrGycPmjd5zePMytWjgk6Kk8QjmKZLlkKoyaMvVGEqOsidNsrvPX9nFwdb+HzFZIuKTHSeSzVLe5cTKkw4tFoQBxHNiLxXv/XpXAJOEQws31LVYxj6TH6d/2o3lhw5bhxAjDx4zJ6vVJooV1IR3/gqsF4aix+u0OwQcuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ly6Tqcl2wfduKkMPMO9UWWk/rMOLN8x9PxjZnUD/8v4=;
 b=fIOBFml2Vz0R8HRF7XhB9GnVrb8U6Kyezcj5UboIf9n5lXW6Tcujh84q+EbK03MK3QvwGuiOLdBdN+sLIQzuaOy1OQ2Ra3Yes893pytCf0oFoH9TNBXtr6p6ZzOZcuJAEnExdHQpP9xfLU3hfJSKyGR2+zPP1Goeeq681hCRg5M=
Received: from PH7P220CA0130.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::14)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 14:54:09 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:327:cafe::7b) by PH7P220CA0130.outlook.office365.com
 (2603:10b6:510:327::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 14:54:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 14:54:09 +0000
Received: from purico-9eb2host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 06:54:08 -0800
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <x86@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Michal Pecio <michal.pecio@gmail.com>, Eric DeVolder
	<eric.devolder@oracle.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] x86/acpi/boot: Correct acpi_is_processor_usable() check again
Date: Tue, 11 Nov 2025 14:53:57 +0000
Message-ID: <20251111145357.4031846-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.51.2
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: cc2d45a4-05e6-4157-da22-08de21322b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hN9hs4Z4EDCfeSfv5/zzkSjrSVTRWK30a07TQPWH7vlOg/t1XDTurEGDDqL5?=
 =?us-ascii?Q?+YI1oODJOZU9lfGGVFzL4IiHEt0IImf92DvZcM7ua5+Ww4tdFzbtQ6ZpUr7L?=
 =?us-ascii?Q?LVO9hf+kDYBeDh8yKaWy8icAvEuq792cGtp4ZKlr5FZ+TZo3NABCvO/fvumE?=
 =?us-ascii?Q?7m75LdwCqzsUlNF+Asy+rk/kuR13WEHGqS/dVqgoNyvCEXgRmIIOu5xROybn?=
 =?us-ascii?Q?K1GriALKJbApO58aAteVjHRaftz5XvKfOT54wkaN9KO6HWhcqxTwbJTRfed8?=
 =?us-ascii?Q?Zsa/CXhFpm/COTPPFCYOvi3AQUQXEx1Nthph+7VtorX6m3Rk/vVkIvRvPGkD?=
 =?us-ascii?Q?ZTEmDw+FQkJoZM/nLsxJazld2P622pm5B1Ut/s81cRrQjWz/7KHwhQg8gD9y?=
 =?us-ascii?Q?rjGDNFKyRcRQL2G9/LfSsQgh0cK4juYs6st9vYYRB0CWc/Tchy3Rgr/LsMUw?=
 =?us-ascii?Q?Q8QBX3NIK6qI2AXOjnKJCnV1EX2HJlSOnhGOzVJYISk9IPsRrfDWAj3/r0qt?=
 =?us-ascii?Q?ICqyp5HdeYXdO43bNotqymC2NCMQGHBZbIqCe3nUqqH/ebCuLtF7ixAnTLLJ?=
 =?us-ascii?Q?5/4I4TQnc/ltZBRkxe8Ly0XIk+8eXFRgvkocdqWfTG5yQBnv9FJ6+4natdVN?=
 =?us-ascii?Q?7p8wDKOwBmHtzmNEWoMpl5tlnmyX4EFT3KC3ZooRKnmEVtqzZDeutgAPluYJ?=
 =?us-ascii?Q?WbMvfiIiA0oi4bA8m5DaBC/y0JrharptSbLiZwsvGpTP26Lm7ZGWu/pg5Ccc?=
 =?us-ascii?Q?Z7gOFXFTFOyVuP/+lPEcDg6czizNjzhW7x4KLKxxWWbasCtII5asCnjfmgpx?=
 =?us-ascii?Q?L7/7bDL9oMFxjO95ZEIgbhqWHVcOQY9JYkpV8rSwqDPnW4gLpNDIHXR/18AL?=
 =?us-ascii?Q?J7rwrEsbY9Srh0kUem83DBPFrgqOB4kNJYRLPjgSLjKOxxqglLl5PLqgERyx?=
 =?us-ascii?Q?p0hszzJku2LIBfpEJyNpNr13JygSfp77++Fj9z8PvrzR7OSJYS3B0ysdGl6v?=
 =?us-ascii?Q?G/ViCEC6cqK11RKv4G9XPxfT5h2H2g/h1hkA8m/GRZ2VW393DrQxPsd7VUMv?=
 =?us-ascii?Q?6TtQ7Bcn/HrNAb91QBPaLJwx4bhLl1fQ9bTbMWDv95Ih4Y40UMxucjOCd9ik?=
 =?us-ascii?Q?5YGCKVmHTPqCDhaSEV6VfIbHKjdQ/WjUpq/jsB8eHEyK7j+pP2P+8tScRSqE?=
 =?us-ascii?Q?68rOVdCGGyrWF3ZgthfEEC6BBnF/Wg82HjZq6yntbWAh7kNEt5M3TZszlCrd?=
 =?us-ascii?Q?/Ps+/erbRvxuRef8wEBFEzb0DZUnQdu+yQP1PVGz5VmM3oL7psvUkmncp3Oj?=
 =?us-ascii?Q?X2P1ylnSjdBa9FL4ushUf5s14Xx8wG3fG3E8o2jLs1ERgj1DhNTwxUv/+XqG?=
 =?us-ascii?Q?i3yNzoVmWFf9vfZ/T/ufDYS6gVZzWBi3yguDSNlyIxl/4TaJH+QtgLHyYkzE?=
 =?us-ascii?Q?YUuSAvaSyTljYByOIFE9btd+PMt1HrVqUsSPGtw/9bFsFnS1ru82DOhsGVpd?=
 =?us-ascii?Q?kdARGhRYNr1GxXG84UzsDu1WkWYNNy5GRDfIuqQs66vBTy07xuRSZ+5tDJc1?=
 =?us-ascii?Q?XGDxwoqtcTUA+Xtj3gc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 14:54:09.3342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2d45a4-05e6-4157-da22-08de21322b6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281

ACPI v6.3 defined a new "Online Capable" MADT LAPIC flag. This bit is
used in conjunction with the "Enabled" MADT LAPIC flag to determine if a
CPU can be enabled/hotplugged by the OS after boot.

Before the new bit was defined, the "Enabled" bit was explicitly
described like this (ACPI v6.0 wording provided):
"If zero, this processor is unusable, and the operating system
support will not attempt to use it"

This means that CPU hotplug (based on MADT) is not possible. Many BIOS
implementations follow this guidance. They may include LAPIC entries in
MADT for unavailable CPUs, but since these entries are marked with
"Enabled=0" it is expected that the OS will completely ignore these
entries.

However, QEMU will do the same (include entries with "Enabled=0") for
the purpose of allowing CPU hotplug within the guest.

Comment from QEMU function pc_madt_cpu_entry():
    /* ACPI spec says that LAPIC entry for non present
     * CPU may be omitted from MADT or it must be marked
     * as disabled. However omitting non present CPU from
     * MADT breaks hotplug on linux. So possible CPUs
     * should be put in MADT but kept disabled.
     */

Recent Linux topology changes broke the QEMU use case. A following fix
for the QEMU use case broke bare metal topology enumeration.

Rework the Linux MADT LAPIC flags check to allow the QEMU use case only
for guests and to maintain the ACPI spec behavior for bare metal.

Remove an unnecessary check added to fix a bare metal case introduced by
the QEMU "fix".

Fixes: fed8d8773b8e ("x86/acpi/boot: Correct acpi_is_processor_usable() check")
Fixes: f0551af02130 ("x86/topology: Ignore non-present APIC IDs in a present package")
Reported-by: Michal Pecio <michal.pecio@gmail.com>
Closes: https://lore.kernel.org/r/20251024204658.3da9bf3f.michal.pecio@gmail.com
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
Cc: Eric DeVolder <eric.devolder@oracle.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20251024204658.3da9bf3f.michal.pecio@gmail.com
    
    Hi all,
    
    This patch came out of the discussion above.
    
    A number of folks (myself included) understood the ACPI MADT LAPIC
    "Enabled" flag to be potentially used for CPU hotplug. This is
    explicitly false based on the wording in older revisions of the ACPI
    spec.
    
    However, this understanding is used for QEMU. Hence we need a check to
    differentiate the virtualization and bare metal use cases.
    
    Thanks,
    Yazen

 arch/x86/kernel/acpi/boot.c    | 12 ++++++++----
 arch/x86/kernel/cpu/topology.c | 15 ---------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 9fa321a95eb3..bc99398852c4 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -35,6 +35,7 @@
 #include <asm/smp.h>
 #include <asm/i8259.h>
 #include <asm/setup.h>
+#include <asm/hypervisor.h>
 
 #include "sleep.h" /* To include x86_acpi_suspend_lowlevel */
 static int __initdata acpi_force = 0;
@@ -164,11 +165,14 @@ static bool __init acpi_is_processor_usable(u32 lapic_flags)
 	if (lapic_flags & ACPI_MADT_ENABLED)
 		return true;
 
-	if (!acpi_support_online_capable ||
-	    (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
-		return true;
+	/*
+	 * QEMU expects legacy "Enabled=0" LAPIC entries to be counted as usable
+	 * in order to support CPU hotplug in guests.
+	 */
+	if (!acpi_support_online_capable)
+		return !hypervisor_is_type(X86_HYPER_NATIVE);
 
-	return false;
+	return (lapic_flags & ACPI_MADT_ONLINE_CAPABLE);
 }
 
 static int __init
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 6073a16628f9..425404e7b7b4 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -27,7 +27,6 @@
 #include <xen/xen.h>
 
 #include <asm/apic.h>
-#include <asm/hypervisor.h>
 #include <asm/io_apic.h>
 #include <asm/mpspec.h>
 #include <asm/msr.h>
@@ -240,20 +239,6 @@ static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
 		cpuid_to_apicid[cpu] = apic_id;
 		topo_set_cpuids(cpu, apic_id, acpi_id);
 	} else {
-		u32 pkgid = topo_apicid(apic_id, TOPO_PKG_DOMAIN);
-
-		/*
-		 * Check for present APICs in the same package when running
-		 * on bare metal. Allow the bogosity in a guest.
-		 */
-		if (hypervisor_is_type(X86_HYPER_NATIVE) &&
-		    topo_unit_count(pkgid, TOPO_PKG_DOMAIN, phys_cpu_present_map)) {
-			pr_info_once("Ignoring hot-pluggable APIC ID %x in present package.\n",
-				     apic_id);
-			topo_info.nr_rejected_cpus++;
-			return;
-		}
-
 		topo_info.nr_disabled_cpus++;
 	}
 

base-commit: ed4f9638d905a97cebd49ecea85cc9b706b73761
-- 
2.51.2


