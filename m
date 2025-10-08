Return-Path: <linux-kernel+bounces-845914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA3DBC67BC
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E781404C96
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941E92652A6;
	Wed,  8 Oct 2025 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3zbI0AaS"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013013.outbound.protection.outlook.com [40.93.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D784237A4F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759952413; cv=fail; b=uk0dH4AE2MqMMNeZNx7CtpOb0SB+GGpnOYnTAhV3Y6D0VYPkh4UrwOXmmPNaANgyRKKvNGvRBtk+D7D1OGxfIOps8eGszpI6A7WhB6zkFXYaKazMR5YQsKTTGD++u9d+TciGDn2tQ3JCPmvz8nK0WtpLwmmcj0+EyuQiI6e1sB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759952413; c=relaxed/simple;
	bh=zxPuaVClKkCMw2QTHUcuWhQ5+YY1JDKLeWegw7/K0cc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DZ08nC8X3qAGRdQPJNvDB7tNUmHtM81Rvz9HpuMhniApIwrsmRob6FwOa61wPZeUuuuhVb+o1pZaY/sSuqivNxhncsvb3IdebwCgowJaqVixBjlvli+tgFci2xAvLiLVhZdwRg5Zyi9D3E+71UvPMObM7w3K1lZfMbj9djuSauc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3zbI0AaS; arc=fail smtp.client-ip=40.93.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0aPzWKFZkc1D9at0KvEzwm53Cn4EJewHQoyVd4nk73mqsTgcEraDVv+PQgS1s24Kju1RqOD61L7jFEFbETT0lB7TQtq0lgGgGzdw6TpMAno+k//h7DsJilcs8m7CXJYWb3FGg9Ughu/aaOuQfFVyPthDfrldLOYgQPR4FytFEcbq/wUUPajlXkMHjpFY3iaV2sgYEsuHLuZsxDpSBOfX6beMCETDeeRvdNCXZMoeoC5gqcfdMFqaYHoaw6nXXFUINk4LLiFiKfgtfbHF3RygWjEilIGu4XLOdtnXcskVUiiZN3G6zJvy0esI2FIhKUl3OJdiBsPOY+tF/N2h9WdWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evjx5gPQQ/cod5WGyQfMnIV4w8mCNPRGh03Y4eo+uWY=;
 b=VqgTnwKO7tRzA6mtBRMMiCnJQa+/pnwhiK4N8VTjOlpg7z6QcJnAX+H22mW8fKt+Gbly1hhfazyhK1Fu1mnaSMxtecsIX4OXI5TVJb/pyg3uh3HpZQTsaIJtfAy/T517eHAKfqfBq37sh8XqH7rUSVOb5O8ojf7i9ntPhfWnolWNiZ0333bhCzBXhIcGN+5sYwiWmW0AGLP03jkrJpr0TUZBH+ixegTErfw9rdny1it44PISz2wB7+DxutixjN+HRZH5Yrwo86pwDzxMyXbZcnK8kgTLNoJ7jd6+rP4hhEnQBKmwjyJayirTbXBkzKdd4r/7wszaKAgE6R5z7vNBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evjx5gPQQ/cod5WGyQfMnIV4w8mCNPRGh03Y4eo+uWY=;
 b=3zbI0AaSaAVpw8GxMrUiqgq3/X8zA/B8MQpAwSp8Q1krg5Fexz0cIxloY2CeWGYLWHkeWPfUDTVXsPLcJ3Ytj3CBttGoAH8y/nRkB9b1hd9guic0G5Mrktcmcra605wHLCVyyWpFPgoYeN97ODYccbvLt8Ra1ERCvuaWY53diFs=
Received: from BYAPR02CA0012.namprd02.prod.outlook.com (2603:10b6:a02:ee::25)
 by PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 19:40:01 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::8c) by BYAPR02CA0012.outlook.office365.com
 (2603:10b6:a02:ee::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 19:40:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 19:40:01 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 12:40:00 -0700
From: Babu Moger <babu.moger@amd.com>
To: <babu.moger@amd.com>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
Subject: [PATCH v2] x86/resctrl: Fix buggy overflow when reactivating previously Unavailable RMID
Date: Wed, 8 Oct 2025 14:39:54 -0500
Message-ID: <2ead4ece804b0f61aab01f47385d9a125714991e.1759952394.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff7d18c-da37-47f2-81d3-08de06a278ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDNiaXNMTkZHVk5LZnNWbVJyVlFHSzgvUmpIVU4xWW5DdWErNkI0QW9lNDhJ?=
 =?utf-8?B?cEcxQ3NPVTZYWkNIVmZjc21ZMnRMZ0p6NjBQWjEzdlFCYzhHeDF0aXMxSjlL?=
 =?utf-8?B?TERZT2d3YUhzNFJJRWFHQmNTb1d5UHZWWC91NVVUQWZDRmdZSFlPRlNFVFlK?=
 =?utf-8?B?azdKNVlabTlKZFc2RC9aa3pwcW5rU3ZpUjR6bUVkNnd3cHM5MklFZkpqMkQ5?=
 =?utf-8?B?YmlRVVArUXJxeTdwWk5tdXpMMERJYVBKbC9obWFXYUh2dXRqYWhrQzRCTHdk?=
 =?utf-8?B?cjdYcnFCaEVPWWZZaEhlMjRNK3A1cFdlQTdGYjQrNXZUK1lSaktlR1FDSEpE?=
 =?utf-8?B?QndoZC9FSVRMdVdxelJaZGx2TG5hZXhTcGVodlk5bEluemFuSzNMVysydmQv?=
 =?utf-8?B?YklUYTBQTDNvaHlQNThqT3FlSWg5ak8zVFB6MnBHVHVMMGl5MWpJRGxjb2dI?=
 =?utf-8?B?eERkTFBSeGoybjVGOWRNZVQxKzhRZ3QyT3BadHJtSDUwN0djUElxcE5PNC9Q?=
 =?utf-8?B?ZGhySXhaQXRJUEJETUs5L201ZzRrOUhHTWZZSExUQ2h6YWRSakZpTXMxS015?=
 =?utf-8?B?N1lmUlZ0K01kTnlCTjk3cGFGbjdHQVphRm9yVzAvL2JxUGg5MDBFQm1IcG9m?=
 =?utf-8?B?U3h6ZkNEaXBHbGVIcnRIRGJ0bFdnTW1wc0ZTK3d5VlZBeGdNVzBXcXlRZnhN?=
 =?utf-8?B?RlNNYW1VeGRCbUNUQitHR2YxYmdvWVkxV3R5WVVBNURVenQxMzMyeFRiRnVy?=
 =?utf-8?B?cDZDOWZmVlQySzhIUmUzM3BTQ0h5SjZiSk1sOWk1SGVXcVFzSlJyU0luNDZz?=
 =?utf-8?B?cUR5dWx2N0ZmaEl1TzF2VHNSSjF4MDV0RkFycnVvZllGWUJSeVZreGR2S0o3?=
 =?utf-8?B?THBVbE55U3h2dTh0TUVVWkdGRVB2c01VZ0QwYUxUWjZFOHdiNmhhMi9BN3l1?=
 =?utf-8?B?UFA2WS92WW9VREg3ejFHRjllN2J5bkh2Wm5maHVZR3A0VFZVR3JWdXFXZjNG?=
 =?utf-8?B?ZXNFY1J1NXNRZkp0SW4rWHVMM2NYeUtzNmVGN09IZ1RIcENlZFUrN3NMd2Mx?=
 =?utf-8?B?ZDFuTXFGWjA1MW5tZGpRK3ZlMlFKNmlNY2s2TFc5dzdxSmhyQk9PR0JLOXZU?=
 =?utf-8?B?a0ovVFF2aytNdHVaSzlKQ3pMWXA3clgzN1E2VFUyMlUwWjUvSkZkUUhkdGlN?=
 =?utf-8?B?dnRLQW0yQ0hMMExGV0QwalBaUUZ4OFNwRkhwN2FSOHIwY0N2YUFYbDU0eGgr?=
 =?utf-8?B?SjlBa3AzSzd4NWhhSjlWYTFsMW4yYUE2QmErN3pONkZDTFdmNXA3MzdJQXFU?=
 =?utf-8?B?WWdYYkU5bWlzNkhGSXNuSVUvQmY3eXpiY3UwSFFtNC9leWV2cUtVM1o4SGV3?=
 =?utf-8?B?NXpPNnhoZG1HYUdkZUZZYThqR29MVUtpQnN0Qkh3ZEpwalczeXc5eG0wNStY?=
 =?utf-8?B?WVpXYUFrZnVSWFVOOUptU3lSRU9IQkVaNFkwL0xiZDFJdzZYRkNaOTNTcjNo?=
 =?utf-8?B?VXhRbnNOb2ZCMDJxZk9RSHZqUlp5OS9GTnBscGFyOS9Zbkw4RlRzZmFyemZG?=
 =?utf-8?B?YW1Ia0JFQXBISTdyU2RQS2M0aVYva0FjUVo1Mmpia1lPT1JKWHNKSytRTnp1?=
 =?utf-8?B?ZXN0T0NDS1lBWlF2T1l1UlgzMzRTRnhuSnNxZEd2TEI1NmxUWTNqQ0NkSHZR?=
 =?utf-8?B?ZXB6bUE2RW9GUkJUMm5KSjdUUGRrODlTOVlqek5raHlUbDd0WHhNYXk5eUlj?=
 =?utf-8?B?VVVjVXFDYnQrOVYwRzZFV1JwSjA0V0JDOUV1QVRRc1o3REpoRUVGWjU5eTR6?=
 =?utf-8?B?V3dLaktzUkwxUXQ5aGNZR0Zoa3VReFRTeFIxWXJpZURQZ09JbWl0VVBTVzdP?=
 =?utf-8?B?VTFiZjB1YStraldOSUFIM0lVbWdFN0xYYm13bmZwRnJBY0pGN3B1KzdBSVdM?=
 =?utf-8?B?b0tVL3RhUEgyeEJvenZ3UHBoVmVCRHRhRkZGMXd0eTZ4czcxcS9LLy82NlpG?=
 =?utf-8?B?YllXNUg5TDRoNUdiRXZva3hNdk0xRC9ZaklEZk9NaWlETW1jTVpnbkhnQUJo?=
 =?utf-8?Q?p8oM23?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 19:40:01.6322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff7d18c-da37-47f2-81d3-08de06a278ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031

Users can create as many monitoring groups as the number of RMIDs supported
by the hardware. However, on AMD systems, only a limited number of RMIDs
are guaranteed to be actively tracked by the hardware. RMIDs that exceed
this limit are placed in an "Unavailable" state. When a bandwidth counter
is read for such an RMID, the hardware sets MSR_IA32_QM_CTR.Unavailable
(bit 62).

The problem occurs when an RMID transitions from the “Unavailable” state
back to the active state. When this happens, the hardware resets the
counter to zero, but the kernel compares this new smaller value with the
previously saved MSR value and mistakenly interprets it as an overflow.

Problem scenario:
1. The resctrl filesystem is mounted, and a task is assigned to a
   monitoring group.

   $mount -t resctrl resctrl /sys/fs/resctrl
   $mkdir /sys/fs/resctrl/mon_groups/test1/
   $echo 1234 > /sys/fs/resctrl/mon_groups/test1/tasks

   $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
   21323            <- Total bytes on domain 0
   "Unavailable"    <- Total bytes on domain 1

   Task is running on domain 0. Counter on domain 1 is "Unavailable".

2. The task runs on domain 0 for a while and then moves to domain 1. The
   counter starts incrementing on domain 1.

   $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
   7345357          <- Total bytes on domain 0
   4545             <- Total bytes on domain 1


3. At some point, the RMID in domain 0 transitions to the "Unavailable"
   state because the task is no longer executing in that domain.

   $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
   "Unavailable"    <- Total bytes on domain 0
   434341           <- Total bytes on domain 1

4.  Since the task continues to migrate between domains, it may eventually
    return to domain 0.

    $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
    17592178699059  <- Overflow on domain 0
    3232332         <- Total bytes on domain 1

    In this case, the RMID on domain 0 transitions from “Unavailable”
    state to the active state. The hardware sets MSR_IA32_QM_CTR.Unavailable
    (bit 62) when the counter is read and begins tracking the RMID counting
    from 0. Subsequent reads succeed but may return a value smaller than the
    previously saved MSR value (7345357). Consequently, the kernel’s overflow
    logic is triggered—it compares the previous value (7345357) with the new,
    smaller value and incorrectly interprets this as a counter overflow,
    adding a large delta. In reality, this is a false positive: the counter
    did not overflow but was simply reset when the RMID transitioned from
    “Unavailable” back to active.

Reset the stored value (arch_mbm_state::prev_msr) of MSR_IA32_QM_CTR, used
for handling counter overflows, whenever the RMID transitions to the
“Unavailable” state to resolve the issue.

Here is the text from APM [1] available from [2].

"In PQOS Version 2.0 or higher, the MBM hardware will set the U bit on the
first QM_CTR read when it begins tracking an RMID that it was not
previously tracking. The U bit will be zero for all subsequent reads from
that RMID while it is still tracked by the hardware. Therefore, a QM_CTR
read with the U bit set when that RMID is in use by a processor can be
considered 0 when calculating the difference with a subsequent read."

[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3 Monitoring L3 Memory
    Bandwidth (MBM).

Cc: stable@vger.kernel.org # needs adjustments for <= v6.17
Fixes: 4d05bf71f157d ("x86/resctrl: Introduce AMD QOS feature")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
---

v2: Fixed few systax issues.
    Checked for special charachars.
    Added Fixes tag.
    Added CC to stable kernel.
    Rephrased most of the changelog.

v1:
Tested this on multiple AMD systems, but not on Intel systems.
Need help with that. If everything goes well, this patch needs to
go to all the stable kernels.

https://lore.kernel.org/lkml/515a38328989e48d403ef5a7d6dd321ba3343a61.1759791957.git.babu.moger@amd.com/
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


