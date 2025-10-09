Return-Path: <linux-kernel+bounces-847345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8047BCA934
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86471A630C5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2CE24DCFD;
	Thu,  9 Oct 2025 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IrbHY63m"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A466224AEB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760034572; cv=fail; b=I5Z97WIHS+fA6657XiSReJ4ocMVMfcmz3QZ2AxvrKbyZW21SB4DWqf4lG+4qoI0Bm9jmUX7GfGn8CzjU0FtG53y0mVWGzPbL6FWenlj/uCbQNo/g6UYd6eIC2dd47IhkrMC0zK2aDLkZaTUCK2hX7bf/H9lqBMSr73EZdPgdMzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760034572; c=relaxed/simple;
	bh=fE5+KAO4Z0iXA4PP0ovvhA3Lr+t3H4x+NXWHOYIfMDI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lBKHK4pcu2dKS3zlTFIU4XFRjE0Q2gu2fMaAmOXccCMQX830J/Pw41HIFDMD8tooQZpGiN6tPOty1w1h7uYVR/BuKF2SwRQkERbDmMqaKDusZmYBASzICQe9WZZ+NF91Jec1AFJ5gwdZkQYI895fAwv4mDVvXmQBd5qCBHGzGHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IrbHY63m; arc=fail smtp.client-ip=52.101.48.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVFufae8XjKPCYaukOwlX60YzAICVD4Ea0WAT/NQ79++aLoyhsSW7uVfCbxf26fMtgQagcivo2XcadR2MNRV+sXMPunPcbFmAgU2aaiekK1ORlF3l4AomZXWvHOANiWIm2rEeQKK5hnNMg+td22dFJTscTVkbA1wDAUif7DYEvB2Fj+Aw36YBWIA8uJW7VO8JbP/JEpH6J9LbX5qYIBgIp/d29xcX6gsGJzlrnBjSKOewdvcyLtghQW0FjPWU38QqtoLZxSb8SRjjaLGW8qMAUCLnX47HcZ+50cY0OIyDLNSKhgSb7JYOGayCBIZ2vAgT+zZf9KVQK5nxhJABvdvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFYgRbC97sjETGF0HGh3BfCWa0gPdW4yqbgmq90DFH4=;
 b=EkuDpIZhIhKpVvpCfhq432HFEgzlFPn+ULjA5JG2NV588+BkjG8UyEMDTo0NA/e69+SUNuMWm4rXHo2UjcYuOi0QMsAdx7Nu/JMxbhorJhSaKE10rRzXHc0OURpeYtEQd2p4gAYV+WlyP4AD9ttjO6/klmjnHhtFfE46QDrOP46Lrgq8rEJ2CW/hvZf6lUDTmgfxwFNSJtm9w3KR28b8ITJaoW6lnXfk2YfTY+Oryp5oDKVTGqoO1wVlvWGr30Cn4KLa/YoWlf9Lslxk8IWt1kOKndruvbuHoCbKozeAQnZq7uCiEtaGRCRkQvc+B5HVVGwQdxt9pX7uyt6MwieX0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFYgRbC97sjETGF0HGh3BfCWa0gPdW4yqbgmq90DFH4=;
 b=IrbHY63mOfq0eNrELwsv88zgCS4aE3D0FVYAZf8AUHvFitZEoT8lzy5R0ADda7PcHTAxq6y4wwBtBr1eSvMmM/wdszSmBG5THvp41GCAFzw99miUQwaU/A6hDjuJ5ZQf/RueCRSv5Suha6zNQofV7Zt6rdq7Y5O527YMDWHrR7k=
Received: from CH2PR05CA0035.namprd05.prod.outlook.com (2603:10b6:610::48) by
 DM4PR12MB7575.namprd12.prod.outlook.com (2603:10b6:8:10d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9; Thu, 9 Oct 2025 18:29:26 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::cf) by CH2PR05CA0035.outlook.office365.com
 (2603:10b6:610::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Thu, 9
 Oct 2025 18:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 18:29:25 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 11:29:22 -0700
From: Babu Moger <babu.moger@amd.com>
To: <babu.moger@amd.com>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
Subject: [PATCH v3] x86/resctrl: Fix miscount of bandwidth event when reactivating previously Unavailable RMID
Date: Thu, 9 Oct 2025 13:29:17 -0500
Message-ID: <8eace6e47bb7e124ffb6c10150d1b7d38c2f5494.1760034251.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|DM4PR12MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: d469993f-5f09-4e90-2acf-08de0761c68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DBh4Y3sNGuHeBomkH4CSMcX/nCavKuU8MRDav4ZUnW3cVyhCwKHdH5rZYqs/?=
 =?us-ascii?Q?H6UOEIfPj8SAiVJqxY0+qfS7ItlQrAPqxwouiM36C1duxdGUkPJnPSmNhH09?=
 =?us-ascii?Q?FrAFMTKOVngYbqEF0Wks12qMuupu5HASus1sBskLSAn/dvLxU343Mi7wGtnF?=
 =?us-ascii?Q?EqMXSYAeJu56wRQ958v5chG9It5u3RETLF7XOdMsMTkm0QeEGm4Hvm/PCHz6?=
 =?us-ascii?Q?+833hxRGl2JvGv0CSmZjPucErtyNEpFbr3Dgf7MO1HDwXYsnhWEps0B87pF9?=
 =?us-ascii?Q?gYK9GZV/qgXPS8p2HfdM2OM4oN1irpA77SsHYoPJxvydk/s2D8vG5DAoLoLi?=
 =?us-ascii?Q?oATTET10LOEYDVcLtHtgX9lejqPdPvebJwZyfLYp+p0wm21faUyzABnKSc5t?=
 =?us-ascii?Q?e9vaEXE2zpp0kAz4lvce9ANSGAQDATnjzIyGK2t7rA59ul27nJqECSl9zMAe?=
 =?us-ascii?Q?w/bd9zzewlHyCktJyX/bIktKFC8cQktHLccoODhmn2dWXM4y+YA66XffEwq1?=
 =?us-ascii?Q?XqbUAh6krfOWmSF6cNM0QCOsRVM68EkIJIwbxLc39MnbgDirIPvQ0ViYI9y9?=
 =?us-ascii?Q?GGyGb5yciAetI/ffg6e0Z9CeQM1aox+90eD2myP0Lmt1JOeNkt1KbjY22lZ/?=
 =?us-ascii?Q?DmonvIddPxYVAPqoQhhOtoeyupNqajO4LzuEB27XbHGuzXBq7q3mn84LnLsQ?=
 =?us-ascii?Q?TtiZ+zkm+8fu89B1fmBxYJWV2WFoGHQ+umcZ1dQSDKFen/54TbTvbrUDCc5E?=
 =?us-ascii?Q?0wdR5Yuvvw2GJlbXDQ+KaUV4ejIXuSlVLv8w17vSqS7LnxLtOH3Ng1y5q3x1?=
 =?us-ascii?Q?XqUAoS81MV3LAmi3VDc3O7CPdYsruJTXvGKUmNDzkOnPwviRdK5BDIXHPRdY?=
 =?us-ascii?Q?bn3v0Rk3jy0rnlFHqs4exSYr8zZL0r6M0i8CT9w+GcIczbNv29XnnYU8gZGR?=
 =?us-ascii?Q?Om6gQfc6iYjEAnK6kTNWXwgtX//OXB+R5AVNl0jWiH21QQ1YLh9y3+JnOMlN?=
 =?us-ascii?Q?VQuXZoGY9XjPzSJt0ZesxkvoTvMLXh+3SYWuZ5k3U5hgMvFUfAK+caWtuFke?=
 =?us-ascii?Q?iPkK7J4EMeLfZk37rn28+AZcAIZOPGLAO2raZahkgcMXZX6Yki8UzlIydj65?=
 =?us-ascii?Q?ghh8t4YHwCcantBY6rcJaO9l6lguXP4a9/sM5HUPQgMYJk9Ns/hxAa/1YN6f?=
 =?us-ascii?Q?YnAevuP3gocFAm1aYR5j0Th/11LDC4Te2DSO6Nr6C6ndN7hUjpY1HUm6FRZA?=
 =?us-ascii?Q?hYoj2cagmOIP63FxON0pPef/M/p6xkizWGuvKdjSzKmg3L2jWshjtztBINhi?=
 =?us-ascii?Q?tK6plbhjcwaq3d7XRSFppAR9PhFgEzwY/dy17EHpFdopfpuw26Q1xSSdmOKm?=
 =?us-ascii?Q?e7NmoRH4p19IWtRs7gnOkaXHDzQwPslokobA+FRfyjcACbhw0cHjv8iszGUR?=
 =?us-ascii?Q?qDEQDRO932cppqmzTVCik+y3OX9YpY0VlfFphcwenGSYJ1GLF2xCZDI8We30?=
 =?us-ascii?Q?aBzRf9BDVZlTSOCr2wdx8rNfuhJgIptlSWE6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 18:29:25.6614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d469993f-5f09-4e90-2acf-08de0761c68b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7575

Users can create as many monitoring groups as the number of RMIDs supported
by the hardware. However, on AMD systems, only a limited number of RMIDs
are guaranteed to be actively tracked by the hardware. RMIDs that exceed
this limit are placed in an "Unavailable" state. When a bandwidth counter
is read for such an RMID, the hardware sets MSR_IA32_QM_CTR.Unavailable
(bit 62). When such an RMID starts being tracked again the hardware counter
is reset to zero. MSR_IA32_QM_CTR.Unavailable remains set on first read
after tracking re-starts and is clear on all subsequent reads as long as
the RMID is tracked.

resctrl miscounts the bandwidth events after an RMID transitions from the
"Unavailable" state back to being tracked. This happens because when the
hardware starts counting again after resetting the counter to zero, resctrl
in turn compares the new count against the counter value stored from the
previous time the RMID was tracked. This results in resctrl computing an
event value that is either undercounting (when new counter is more than
stored counter)	or a mistaken overflow (when new counter is less than
stored counter).

Reset the stored value (arch_mbm_state::prev_msr) of MSR_IA32_QM_CTR to
zero whenever the RMID is in the "Unavailable" state to ensure accurate
counting after the RMID resets to zero when it starts to be tracked again.

Example scenario that results in mistaken overflow
==================================================
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

In this case, the RMID on domain 0 transitions from "Unavailable" state to
active state. The hardware sets MSR_IA32_QM_CTR.Unavailable (bit 62) when
the counter is read and begins tracking the RMID counting from 0.
Subsequent reads succeed but returns a value smaller than the previously
saved MSR value (7345357). Consequently, the resctrl's overflow logic is
triggered, it compares the previous value (7345357) with the new, smaller
value and incorrectly interprets this as a counter overflow, adding a large
delta. In reality, this is a false positive: the counter did not overflow
but was simply reset when the RMID transitioned from "Unavailable" back to
active state.

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

Fixes: 4d05bf71f157d ("x86/resctrl: Introduce AMD QOS feature")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Cc: stable@vger.kernel.org # needs adjustments for <= v6.17
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
---
v3: Rephrasing changelog considering undercounting problem.
    Checked again for special charactors (grep -P '[^\t\n\x20-\x7E]').
    Removed few of them now. Thanks Reinette.

v2: Fixed few systax issues.
    Checked for special charachars.
    Added Fixes tag.
    Added CC to stable kernel.
    Rephrased most of the changelog.

v1:
   Tested this on multiple AMD systems, but not on Intel systems.
   Need help with that. If everything goes well, this patch needs to
   go to all the stable kernels.

v1: https://lore.kernel.org/lkml/515a38328989e48d403ef5a7d6dd321ba3343a61.1759791957.git.babu.moger@amd.com/
v2: https://lore.kernel.org/lkml/2ead4ece804b0f61aab01f47385d9a125714991e.1759952394.git.babu.moger@amd.com/
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


