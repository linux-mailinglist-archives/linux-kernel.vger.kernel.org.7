Return-Path: <linux-kernel+bounces-848559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5201EBCE09A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663D3189A70A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7DD1FF5F9;
	Fri, 10 Oct 2025 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4oHkz34A"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BBD42049
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116127; cv=fail; b=aYT5jIz51ZjP2n6E9QJC7XGEyY97QbVBBRAF8tegZ2G9CIIweXfn/8DOWJbHcw0wk3vl1Xoqys7ZJ35j1RcjHhg3mBK4Ts+RdZsjnmM0LJ8hviWB3auCs6pZbz27cP1J3osXnyN/MAstNs6twIR0xwGsy510yG7tCKC0dI1ajz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116127; c=relaxed/simple;
	bh=t0dnY2N0UFa3myZkf1l8/doIiZa6Qe/ugsnMlsZfNfE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mV28kNN0h3Tn8E4BngEpdkp62+YGFtdF0pMYuI7CdVIQjVWi7T7xHjzSp8sLBht6emNpA1YK1aTEnzLalAhpjgWc1Ch0IRmb94lmLX4V5YJkhU4D68axwUZnNfL27n869tjgBTEbdd4rdTrzkDOHiyGoirMicDBDYefmotu2XiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4oHkz34A; arc=fail smtp.client-ip=52.101.61.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1sqySmUFtLqyW6xsdhNmFcttD6yW/uk/MABRgx7CTjme7CoVEFHfGq4MYMX9DI1df8mACoOIqZs2wbs3NFBmHUlZHEoPs+UbaW9MEX64iHytLREClNGTI+e/VlIjOCGoSmlw0/rKQ+g2BSol/oO+WC3+rd74OS2ktaUCAsj9g6dHS6tQqmOspgfrx0HgT/j7vQILKqjKvxgBAR+YqSUYP4AzmFm9aKbk0eJ4o3obC85jVvrXqt5kv+I8jwrqTIbIHJIiFd95AwQ3RMXNHHv6ycB4vof6QJKGA2utd5qYVdLAvb2lUnXvRCVfnupF4fQsHdwc9rJC67NkcNeMKq2iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TCAOgNNPDpNuaizvJA6ldZ1BTrVj1FtDQ7nhEMmiDE=;
 b=Z1JccxoDX9Mn9juOLoi8uGkA3eNdcm6lcUbIEVPRVqO7yrCgiLhBpEkDBu901/7oHuzLoBRheTG0o1NChGwIIlDKQqBCGnNfyQt3S/RPy8kzlMvxGGg8pYoAJ1EDAHJ0oU34lcH2Kuw5jUNmrzfHEqRMRqSqmiMouR9bRxqzAYqxsrCKAfRjmurZY6Eki4V7fHxtugy3mhJEt+RkrIJPgVQ6SLTDldy18Iz3fhtY35UH1g4lMIi3LPcn/rz0EudPpsCZcLM1YoG9WJGgXLvCxNtMJS8GWuufPN+duF7/xS2JjyKKBEk7Y0dWbgnSU7NXI1NJtERiq/Kd2Fg7yHWtgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TCAOgNNPDpNuaizvJA6ldZ1BTrVj1FtDQ7nhEMmiDE=;
 b=4oHkz34ABGq6gdKUJTzwRm6pitAymwaiYxbZrx3E5iEzvCHCpSkUUAorlS7jaLQodrTX3ODfRdSKxk3mOVeRCr+dXjqxXLN2op33Za2hlclZqzNRhh07iPifmbWQled+3wnLQ2LPohwgtNHcRyle0quvudM75FinVa5bsLXZMSk=
Received: from BY3PR05CA0047.namprd05.prod.outlook.com (2603:10b6:a03:39b::22)
 by DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Fri, 10 Oct 2025 17:08:42 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::c1) by BY3PR05CA0047.outlook.office365.com
 (2603:10b6:a03:39b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.6 via Frontend Transport; Fri,
 10 Oct 2025 17:08:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Fri, 10 Oct 2025 17:08:42 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 10:08:41 -0700
From: Babu Moger <babu.moger@amd.com>
To: <babu.moger@amd.com>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
Subject: [PATCH v4] x86/resctrl: Fix miscount of bandwidth event when reactivating previously Unavailable RMID
Date: Fri, 10 Oct 2025 12:08:35 -0500
Message-ID: <0475e18db309c3c912514a6c4e7f7626297faa2b.1760116015.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|DS0PR12MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: dec0c28d-b269-43a1-1e72-08de081faa4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/yCnuIB9H9iAPveKAVJ06acPOmWGQSyLo7r9/ZiQvN8H6DLaKWObEbJJ+HBh?=
 =?us-ascii?Q?fJXqbrLw8nt3ouRMA3IN8lMEFlrfeP1Y3J8CkgwyicvbVhEgRBkIHwF2MopX?=
 =?us-ascii?Q?ja/lSybu9M1F+OP5k0q4NChz0crgQ2y4uR/2IbzdD+XuF19naAHIpdKfXaBK?=
 =?us-ascii?Q?mz87XsgujDlDqYMYrlc7p3yOwRt+EUd/LBAJ8+ECak69Z6uijqOpberjtoVQ?=
 =?us-ascii?Q?QCfWNI4P9YOZ23weHaCyLRV44Za+hkHGzpbz253VM26GKmQWxOpJyeDG668L?=
 =?us-ascii?Q?huY1hc5XeE9ArOb4FUpipYy98L0xE4z2USrLw2GpyVEqKP8UoXu4jZ2xiHgv?=
 =?us-ascii?Q?LAj74108zMHqsqz53N8ERogZZ3CY2Vv6GCLMO8OrtJvoNuhQKEPIn0LdovYl?=
 =?us-ascii?Q?8yH7gocROB9JMu1PZ0iaVoJXUnKuSvq47+RkrvRke8f3QVE1jGruM4EXfdOl?=
 =?us-ascii?Q?+jZtwWA8wlzAZ2f27mqFfOzdWepwJ2fH8GOXOEZrkp/C+9kjvZv3tSKB8smU?=
 =?us-ascii?Q?gVoe2ifvFHsfnwL0XKva1J0YghNJ0rFLo8nKQcP8mtwKlUQs8mgsIUhPSG0q?=
 =?us-ascii?Q?kp/vZHQ5dmHSkQRhRbLLXlZ3SmhRB3CNdHxcDpHS8wFYbldvWgszjEFFYMek?=
 =?us-ascii?Q?A8XSjwLymsw4EJgO11sHUrRbHIcx2Qotr1HUSP3uvKmJpjUFM5eUBh36cq0c?=
 =?us-ascii?Q?i7JMvqgLUh79s1OHn8U/7yFnYdxZkt0qUdezgVPDeaT5ejVilrCUKY3BLD7f?=
 =?us-ascii?Q?3IBu7VJ2MTEyxti8MMzK2g8xUExBTXo2weRYW4Xe1LP7pT2rp1kAybcO217V?=
 =?us-ascii?Q?yJTmpqNwAsl2yISsq7o2l6RrOBrBjJJsdJCqm3miQjOjFgMY5uqN7wKt5ZJ9?=
 =?us-ascii?Q?ePCGCaByeDEZKANYh3gaMHFgWDnZqkR7igJuCsh8+3ORRl4P4wxisDzNUCJS?=
 =?us-ascii?Q?pxMO0MuSpP+0T/ZOAOlQRybS2O0yaO9WUtngwUZ0L2SVssm9HPGX8itxeAag?=
 =?us-ascii?Q?JYwGmLjZ2yo81/GfkyAfOvq2exNEW+7RTjgyF1M2GmMEHdOQCFMyYIv6LwSH?=
 =?us-ascii?Q?/ekUUK8D579MOWTiKhsrL5i/7SrowdTGJXTbrIxGmZCWIQJQCN7G11v4VTNf?=
 =?us-ascii?Q?ib7l6LNP2zd1XT1tXocclrFf4WWXiQk2ZRPMMU8cpxMrpASOlqscD0xZIdF9?=
 =?us-ascii?Q?ms36+2HUXIfKjWtUU1tcSCJx6RSZ+qef9sFHuL5wwiaSxq7vTXzRqfLg72Mn?=
 =?us-ascii?Q?3U9hRQp8zy1RDQVQCT97ssf14+QhnPK1ehjHPL9ARmbRco/ZirtbCU+eKcSj?=
 =?us-ascii?Q?EflECi4VXxrwtA3LNXTm1h5vLo72CW/JBgTl8IeSboKdxF+JPMjsRhE3BgJZ?=
 =?us-ascii?Q?5gQ3tV6wGtpM8qYpprb9LtNN3Gdepqc8UNt1JtzKZXwwJ4aSJDtdO9jB/0HJ?=
 =?us-ascii?Q?QRoZbGar/9ab7kpQ80KqmPGSll/DjJLjbb5xkTdiOGxpA+o10dtsPFD/wrRj?=
 =?us-ascii?Q?IV9liXM8Q0Q5hgCI3hiBfDaMMSVKNKhvotVh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 17:08:42.6060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dec0c28d-b269-43a1-1e72-08de081faa4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069

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
stored counter) or a mistaken overflow (when new counter is less than
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
v4: Removed switch and replaced with if else in the code. Tested again.
    Removed a stray tab in changelog.

v3: Rephrasing changelog considering undercounting problem.
    Checked again for special charactors (grep -P '[^\t\n\x20-\x7E]').
    Removed few of them now. Thanks Reinette.

v2: Fixed few systax issues.
    Checked for special charachars.
    Added Fixes tag.
    Added CC to stable kernel.
    Rephrased most of the changelog.

v1: Tested this on multiple AMD systems, but not on Intel systems.
    Need help with that. If everything goes well, this patch needs to go
    to all the stable kernels.

v1: https://lore.kernel.org/lkml/515a38328989e48d403ef5a7d6dd321ba3343a61.1759791957.git.babu.moger@amd.com/
v2: https://lore.kernel.org/lkml/2ead4ece804b0f61aab01f47385d9a125714991e.1759952394.git.babu.moger@amd.com/
v3: https://lore.kernel.org/lkml/8eace6e47bb7e124ffb6c10150d1b7d38c2f5494.1760034251.git.babu.moger@amd.com/
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c8945610d455..2cd25a0d4637 100644
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
@@ -251,12 +253,16 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
 
 	prmid = logical_rmid_to_physical_rmid(cpu, rmid);
 	ret = __rmid_read_phys(prmid, eventid, &msr_val);
-	if (ret)
-		return ret;
 
-	*val = get_corrected_val(r, d, rmid, eventid, msr_val);
+	if (!ret) {
+		*val = get_corrected_val(r, d, rmid, eventid, msr_val);
+	} else if (ret == -EINVAL) {
+		am = get_arch_mbm_state(hw_dom, rmid, eventid);
+		if (am)
+			am->prev_msr = 0;
+	}
 
-	return 0;
+	return ret;
 }
 
 static int __cntr_id_read(u32 cntr_id, u64 *val)
-- 
2.34.1


