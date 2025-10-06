Return-Path: <linux-kernel+bounces-843577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC9DBBFC1C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21D9E4E96DB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2721FF1AD;
	Mon,  6 Oct 2025 23:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BiIBGuKL"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081C51FDA82
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759792445; cv=fail; b=KjdIjF4z9bEO2yoq03avnuQpeGHcexG+m5q1hMPuSYTGE4+hYah9qwIK4ZkfVZ47PlPfq9jPpluyAr3brp4swszgz8GZVkAxjFKL9wq9T+UvDrWBUUHYNuPMMOhhzagKQsysTruMNJZrPlhGR8+83HGBvmBT2B0GVZc6r7Zfdp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759792445; c=relaxed/simple;
	bh=POhnrhnYJVmsarT1bwjNnP11cF+1TbgJmg1LDxHTUfE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X6lGUzDVQQBR5Sx2yCp5Hdio3cevT31dPJFnlPdfKu/Hi4Ln5JjE0ucikyF3h6vUZiEKDKYK/6ryKoSR7yAKq1/B7ZRQdVoM6xzDawbgCQxXmb18+x9iYj5BfsZhYkLBoTRkOh6ieiVznd163L4BzhssXtTv5l8uLWTjRdGvFCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BiIBGuKL; arc=fail smtp.client-ip=52.101.52.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUHZEoJBe7sAYeA7Q3e83/WjLiksT0xREdxJz615iedBHd+YCuJUIk7cPEwWxHqZtnvdXfYichFbYMbo8lUSC7B5pvVld1n4SWg+eESyOS+4gJTRBTmcqSpKXzpZwRvzOFBIaD4gXqQijdI/K2yp8ZYQE0BX6ssqa9pxvzFSI1+kwhpDAxQnzviqMj80HH+bhXl1ZIIQgw5D+sPq9s4sfJDBrNW9krhntocbHt2W03oZUkjVqypJDuqcmdLeuUSQM5JIWIjPRtdluJWtj6757BmwYDODKwMA385jgxuA/BYmzx5iLPvIMt8qyPYK3G0TyPcYMbU/XCn6VLdMRcgHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXV4te1jwq7x3dRWAWUBjM5Vp7NUjZGsFVezgHldXD0=;
 b=pvhUWJR+PQcCE3kTcmZkJov3s50tqtMi9Dr2X+ebxWZS9PT+DbwxBwgjvnkqzX++CWn4zrvl6cIE2SedAWGngF6elscmHpfpUniVIbtxvnupmCuH+IiOh8vR5eafsm7CdSkD5UvQETteKnTnHbQDxVVu3j4J7v/YbTeQf7oU4EDCZto8Mr65xtsov3OLpd5lT7SXR2+zlw3dQ90pQVa78pGzpvOuHwxB03Qnvpq6cRCu7pP7q5QzDYdjFcPPba6HP7sFjIYzFbn0P1AIR+HT4+mvPb6mo8mmSl2woXeXlDSauABBLVTKX/IdYj6rSFan32lXdg9msAiOZq5dDloZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXV4te1jwq7x3dRWAWUBjM5Vp7NUjZGsFVezgHldXD0=;
 b=BiIBGuKL1eJA0fvAnWxbjD+GFNpDfGZgRAOJJRAAG20g1ckDZ9qGTG+/3JTqwHGEUiclcCyNQAnvht+6pT98X1W+8R7yLHIFhpeWHKpH8nDtb0892dA8xqNmZ5S5j2qc6td49o6qAfNM7w5Gmpkrjdz1E+s93GFBxOYA1+DjQYQ=
Received: from SA1P222CA0062.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::13)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 23:13:53 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::b3) by SA1P222CA0062.outlook.office365.com
 (2603:10b6:806:2c1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 23:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 23:13:52 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 16:13:50 -0700
From: Babu Moger <babu.moger@amd.com>
To: <babu.moger@amd.com>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
Subject: [PATCH] x86/resctrl: Fix buggy overflow when reactivating previously Unavailable RMID
Date: Mon, 6 Oct 2025 18:13:44 -0500
Message-ID: <515a38328989e48d403ef5a7d6dd321ba3343a61.1759791957.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: c2af85a4-cb8f-4745-7e72-08de052e03f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlRmQU5CUTFEdXkrNC9pY0F6S1lxSjE2VHNWYmZlbkp1d3F1bFdPaTRDbmdl?=
 =?utf-8?B?UzI3S1JtOTlMV2orK3ZFTDJaSnZPU01BNnZrYzBYK2Frc1MzamdwT0FNcXlp?=
 =?utf-8?B?dFZIdm5sT3NUcVJtdTU3NmhMYjRUV2M1RFp3dlJZd0JZZ2lwZENhcS9mZ3d6?=
 =?utf-8?B?Mk52Zk03alBrLzRLTTRmdkNKQ0tNZE9SZk9MSDdCV2NmaDFyaHBIeWxHd0cz?=
 =?utf-8?B?a3dQd3ltUG5yS0EzTzV4V2VWMmRrbWV3TkoxcU1lRU1yQUpRMkU4UE9GZG5k?=
 =?utf-8?B?bXdtUkNNZ2VDc2t1MFlUOHpiY2dvUy9Jd1RjNDBOeWRpRUY2VTNQeVNMNUho?=
 =?utf-8?B?QVVLbDRETFVyR3RqV0U3L1IrZjB1WDJoRDk4T0Z6UGUwVUlCaVF6ZjdiZ0Vi?=
 =?utf-8?B?V1ZsMVNKcFRra3NZUWNqVWQzb01MRm9IQkpGbzI3bVByLzAwSVFYbHdqTTZm?=
 =?utf-8?B?Qi9VNG5obEx0OWFTL3VTTGlnY1N2a3V6RWh0NmlqTHFqQTZldmJZVVVnUHZQ?=
 =?utf-8?B?V0ZHZTVORnJnTTNaQWorUmlLMzI1UUlBQnZnN0c5MHlCbFFWZ1BmZzdpSjQr?=
 =?utf-8?B?NE14eFZSZkRXYTVvREhEZDByUzVaYWxBNTdaTnB4ckwvY0pTSXNOZTc3cGgw?=
 =?utf-8?B?allpK1lTVGtMQUNnY3FEaEViUnVRL1FmdWN2TFVXbFRCU05WMFQvREorRHAr?=
 =?utf-8?B?WUEzS3o3K29nT3gydUJkUndKOGRxcmZ1aWI4Mk1zUlgyU2JhK0tMRTA4U1A4?=
 =?utf-8?B?YTJneWdBUUJNa1pmdFpkNmhTeFlHQkFuVnUwOXM5YitQb1hGdWluemFqUmdO?=
 =?utf-8?B?Y3UrcmNTSFE2NnkyNVF4TTdRRDdqUE5DY2E1eElsK1dJOUEyUnArb2dsQmxT?=
 =?utf-8?B?U3RhMUVqZ2VkOGNnbURqOG1sc3RMdTRZcGk1djVJdi92OUFPQWN4MEpBY0tC?=
 =?utf-8?B?VUtuZW1hVmVHcTB5T0c0NnBYNnpqeVZUU3VzMVNYU1YzNG54K3o2cDdBQkdU?=
 =?utf-8?B?VmxTdkhQc0JSczEyODJvc2w4cWJQc09qNTNrSWplN3pCZWlQK003T0R5cTkv?=
 =?utf-8?B?UFp6cUlFSVcyL29KT1F4R21RRVY1THlMTzAwc2Zxa3NVYW41bDA2QlFYUXZF?=
 =?utf-8?B?a052RDhEU2tVdmlMTVUxb2x3Si9ucmVSUWtZdDFhUmRab3h0ZDFlYktYU1Zm?=
 =?utf-8?B?WkhCMUFDZTZvZDg0N21TYSt5M3I4dEhBTHVUQ2grZU9vWnc4UXpqeEh6NENW?=
 =?utf-8?B?Q2lmdVovbVEvUFFJekN2eDJGbW5mdXg0cnMzYW4xVUdtV0lLZ1pQK1FHL3F6?=
 =?utf-8?B?S0NiZ0lTcmRhT0dsaU9BUk1YOWNBT0hXRnlyYzQzOHBYUzdrY3g1OTgrbHps?=
 =?utf-8?B?bk50cjkvaHR6S3hmRDQyeU95Zm9hdFpEMlVSSVR0bHRuZWJnTWZjS1JNRW9z?=
 =?utf-8?B?S3hLQmtyMkRpYnJNV3NoQlZ0ek1jdjlkSkNpYWFZZm5COS9VaEh1TjN4OXU2?=
 =?utf-8?B?a0dHYXpQRWllUTVzN3J5cnNEelpPVFUzWXVxODZ0SE5CMCtaRjcvd21wYkdY?=
 =?utf-8?B?NUN1OXFYSmxMeXNuZGNBTVpnQ3lFRTYzVTVaOFEyN0t3dkhsQVpYdk1hc2I4?=
 =?utf-8?B?eCsyc29LZWRkbXAwcUFiZVhsc1RUMW9EYXkvcUp6KzJETUVsWnZtR1o0WnA5?=
 =?utf-8?B?dWg2U1lIQ3ZrbjEzRVJJbFZvSDlLbHEyWjc4b3dVMTVOak1rWVVmK1hGd3Vl?=
 =?utf-8?B?UzY3UitoeXV6c1dxL1N5b3htSzRxWGQxMmR6UzI0L1RaV3VPdmlSVWM5b2Nw?=
 =?utf-8?B?MWZlcmVkajBiditzRldoS1IwSHVhaXhvcGdpNTI1ZUozRENJK21BTE15dG1o?=
 =?utf-8?B?VHZvekVXV2dIdFdGUitOc1JFdFo4NjRjeW9EeGFzY3FrTmtHMkNsZTk1QVBn?=
 =?utf-8?B?c2JYbTV1VlVyaEVEZnZVZHdnYWNIU2hNNVg0UlI0STFKbVhOR3RMYjUyNElP?=
 =?utf-8?B?NjVkQWNlRUU2aE8yM29BbWg5UWpJS2FCTGwzUFpLWmxMV3ZxTmp4MUJGNE5S?=
 =?utf-8?Q?lOMZYe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 23:13:52.5255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2af85a4-cb8f-4745-7e72-08de052e03f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440

The issue was observed during testing on systems with multiple resctrl
domains, where tasks were dynamically moved between domains.

Users can create as many monitoring groups as the number of RMIDs supported
by the hardware. However, on AMD systems, only a limited number of RMIDs
are guaranteed to be actively tracked by the hardware. RMIDs that exceed
this limit are placed in an "Unavailable" state.

When an RMID transitions from "Unavailable" back to active, the hardware
sets the IA32_QM_CTR.Unavailable (bit 62) on the first read from
MSR_IA32_QM_CTR. This indicates that the RMID was not previously tracked.
Once the hardware begins tracking the RMID, subsequent reads from that RMID
will have the Unavailable bit cleared, as long as it remains tracked.

Problem scenario:
1. The resctrl filesystem is mounted, and a task is assigned to a
   monitoring group.

   $mount -t resctrl resctr /sys/fs/resctrl
   $mkdir /sys/fs/resctr/mon_groups/test1
   $echo 1234 > /sys/fs/resctrl/mon_groups/test1/tasks

   $cat /sys/fs/resctrl/mon_groups/test1/mon_data/l3_mon_*/mbm_total_bytes
   21323            <- Total bytes on domain 0
   "Unavailable"    <- Total bytes on domain 1

   Task is running on domain 0. Counter on domain 1 is "Unavailable".

2. The task runs on domain 0 for a while and then moves to domain 1. The
   counter starts incrementing on domain 1.

   $cat /sys/fs/resctrl/mon_groups/mon_data/l3_mon_*/mbm_total_bytes
   7345357          <- Total bytes on domain 0
   4545             <- Total bytes on domain 1


3. At some point, the RMID in domain 0 transitions to the "Unavailable"
   state because the task is no longer executing in that domain.

   $cat /sys/fs/resctrl/mon_groups/mon_data/l3_mon_*/mbm_total_bytes
   "Unavailable"    <- Total bytes on domain 0
   434341           <- Total bytes on domain 1

4.  Since the task continues to migrate between domains, it may eventually
    return to domain 0.

    $cat /sys/fs/resctrl/mon_groups/mon_data/l3_mon_*/mbm_total_bytes
    17592178699059  <- Overflow on domain 0
    3232332         <- Total bytes on domain 1

    Because the RMID transitions from the “Unavailable” state to the
    active state, the first read sets IA32_QM_CTR.Unavailable (bit 62).
    The following read starts counting from zero, which can be lower than
    the previously saved MSR value (7345357). Consequently, the kernel’s
    overflow logic is triggered—it compares the previous value (7345357)
    with the new, smaller value and mistakenly interprets this as a counter
    overflow, adding a large delta. In reality, this is a false positive:
    the counter didn’t overflow but was simply reset when the RMID
    transitioned from “Unavailable” back to active.

Fix the issue by resetting the prev_msr value to zero when hardware
returns IA32_QM_CTR.Unavailable (bit 62) when the RMID becomes active from
"Unavailable".

Here is the text from APM [1].

"In PQOS Version 2.0 or higher, the MBM hardware will set the U bit on the
first QM_CTR read when it begins tracking an RMID that it was not
previously tracking. The U bit will be zero for all subsequent reads from
that RMID while it is still tracked by the hardware. Therefore, a QM_CTR
read with the U bit set when that RMID is in use by a processor can be
considered 0 when calculating the difference with a subsequent read."

The details are documented in APM [1] available from [2].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3 Monitoring L3 Memory
Bandwidth (MBM).

Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
---

Tested this on multiple AMD systems, but not on Intel systems.
Need help with that. If everything goes well, this patch needs to
go to all the stable kernels.
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c8945610d455..a685370dd160 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -242,7 +242,9 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
 			   u64 *val, void *ignored)
 {
+	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
 	int cpu = cpumask_any(&d->hdr.cpu_mask);
+	struct arch_mbm_state *am;
 	u64 msr_val;
 	u32 prmid;
 	int ret;
@@ -251,12 +253,21 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 
 	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
 	ret = __rmid_read_phys(prmid, eventid, &msr_val);
-	if (ret)
-		return ret;
 
-	*val = get_corrected_val(r, d, rmid, eventid, msr_val);
+	switch (ret) {
+	case 0:
+		*val = get_corrected_val(r, d, rmid, eventid, msr_val);
+		break;
+	case -EINVAL:
+		am = get_arch_mbm_state(hw_dom, rmid, eventid);
+		if (am)
+			am->prev_msr = 0;
+		break;
+	default:
+		break;
+	}
 
-	return 0;
+	return ret;
 }
 
 static int __cntr_id_read(u32 cntr_id, u64 *val)
-- 
2.34.1


