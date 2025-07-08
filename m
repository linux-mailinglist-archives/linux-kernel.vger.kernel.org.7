Return-Path: <linux-kernel+bounces-722463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD3EAFDAFA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23A3162CC5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EBE274652;
	Tue,  8 Jul 2025 22:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gyRBhv76"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0172741C0;
	Tue,  8 Jul 2025 22:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013287; cv=fail; b=OKtJzrbPNWsuXZs4PUGe8LREZdIVcpAp4yZTTDRBLhDaxvwspNdxfYS3XVyzH4chVHuId+zNWsers+TFTi6boxIWSiOUkwvq1uOxXZ8LYhAL4bYbwmjvHmCfnLHPCwvWjDtDmn73ak17MEP9Cuq1VoYwH+fwfaLhIgZbiArZX9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013287; c=relaxed/simple;
	bh=2Y80cSNQIeyeU7nhg+G1s5C/11PcBmTEKRHU22Zt/zY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saUpmWH8LAHSE75cuCQ8Jyj4GKUQj1Teeq6woS6ALbtHDZw/HeQ7PKjBmuSZqmheix2uU7SaErqBoTEqHSWPmRws9K+bCycuFCR4CX705Huny70IEP92QF32l2Sg0fN5Bm/7zv+6/nsnCpO7GhKDtoYhJPgbrf+3S497HwIQapM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gyRBhv76; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fkw0wlM3nv7CbZ2/CdDgZTWpDyIPB7oY/hAgSHcXEzbk9sTafvrfVyFOgt+z33c4jr6sYKhQqLD1TreH+7GGMcoRvsP9Pgw3ec+YFNpUCTw4+QmQteRwpxfnfiBdEbHQkgEpCaWZ85PHRyqCDZmAfHfHIwi1aV0aZUwHkGOdxCOfcDexlAZbVCcBJviV/5ueAEpM/9qWHEaYS8YgyYgrcDUABQpCX/BSzVXmYsmcwgMSksppM4PEe9aVGhW2yFDp4/vgSMyM0RunpeyYlRYc3e6Puz4tr0YDqIY6aFgpiBW1Xpv9jE7S4EYlh8x7vdHtuwUI4bD3gQOXn5eTscEkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsvBCtyRqyAuL4ArLtlekdBfrm/+Ac03SdAUGX2duRs=;
 b=UuVShP9YKhblK/OrkedgPmXgcdhiDJnwxxkQ69OFDnoTHNNAuiHDR+haU1HQXdiTZzu5n0ZROrKdN7GAWYJ2qS39JykbLSQTqeV//mShW70GCbQLhICx7wm3AI3G5P7L0xgjuqcWPiMHIUK7nGYeWhrszG8hqRLOTYxi90TLhxly0gMg6ju8b4q2niXLRTx7UUxalHPW2OunEvceCYXb5stxjbL6D749JMBFjhAGwztmQdCm/Unk+chQLWk0VhiJbPmq4tWCh9jXc3zhjImO1ZPV1sryZTIpFZNY7FSl4HTBUlRvw2M4cj+lH1IoyzzxzRJhT3CX+rP4ccX4gbryRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsvBCtyRqyAuL4ArLtlekdBfrm/+Ac03SdAUGX2duRs=;
 b=gyRBhv76/bwFbHK4m82LSqHw9l7lkM7nPbOsciLZQKze/DUS6YHxVt1J+bLt4IoMI1n/hLkKTbVtDNFMcqUVRjnVk1y4uy/5fZdwJv11m7mYqF2zxNyNMQ7EZJl+yPxyLho+LxVkBCM/EIVOPro5smrO3eBcH/6uz9FY2dqvaN8=
Received: from BY3PR05CA0041.namprd05.prod.outlook.com (2603:10b6:a03:39b::16)
 by SA3PR12MB9197.namprd12.prod.outlook.com (2603:10b6:806:39e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 22:21:23 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::50) by BY3PR05CA0041.outlook.office365.com
 (2603:10b6:a03:39b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Tue,
 8 Jul 2025 22:21:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 22:21:20 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 17:21:18 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <babu.moger@amd.com>, <tao1.su@linux.intel.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
Subject: [PATCH v15 23/34] fs/resctrl: Support counter read/reset with mbm_event assignment mode
Date: Tue, 8 Jul 2025 17:17:32 -0500
Message-ID: <df215f02db88cad714755cd5275f20cf0ee4ae26.1752013061.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752013061.git.babu.moger@amd.com>
References: <cover.1752013061.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SA3PR12MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e0754f-057d-4c5a-293e-08ddbe6dc43f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gmhE3GP4pZwnGhulPm/wnJHQBh+LC//YI/OjZ7A2gRSsAmUC11ydQ2lAgfFe?=
 =?us-ascii?Q?w+i6NxSDkaWsuhkxVB7ltfGcAVMcIR3/Ib8Y/mwNiMiWNIV8tpiEsBC+ZXoy?=
 =?us-ascii?Q?rndzRE8fI/kJ3B1URK2IsmT915kQaxhJL4giPCHmRTUfzIMNsG94peKvO5Me?=
 =?us-ascii?Q?egP8//zjSw3KojaJ5OrANE+yROcasuT8Wr780P9XOd1gO+/Biw3HQ25reX/Y?=
 =?us-ascii?Q?HHvRSzAcrtXz2et1nYBxSjLgC8n01iP019Yyog7db47wYLgw4UO0K1DWZyfA?=
 =?us-ascii?Q?gaAGqhH6F2ke9sAVSktw8qq0fpf05uugRuST8rIZIrg/wXud7x5FHCzl2lmx?=
 =?us-ascii?Q?sStIml8PzTrFd+2oOOmP3xewhYkJ1Z2c3z4dof41ifcxRlTNJ4Kx3sF3wT26?=
 =?us-ascii?Q?WfuDYcvW2CJtj7k31VPJcgSpZL3/i0vUVNytRFkytvHUAKClzwjSHKihSMi/?=
 =?us-ascii?Q?gpdzNLRWyOUpRYVsjjkg5Z2z5z249sqOi23A/cab57AX7HClA1JCuWxpu4OD?=
 =?us-ascii?Q?4Zh4dfz9q5e4QhXnaCNQMe+pgmbHbO138su/dBgIaVeqbDe2dHqW7fR9uMp9?=
 =?us-ascii?Q?LnUR2ibcumKlqEeR/KOEiC0vvnZLrgwTwkWyiFTIEEfF/4q9xJGTYpMq3vO+?=
 =?us-ascii?Q?TTCBKWGyMkwAXDucGwqGt/V1sWZKb6MDFn8jLkwXjWpsOE/oR72GWj45VNQp?=
 =?us-ascii?Q?jsWLGIVQwq/IMConmwCKje3+REDplEIka0E4vw28ImUMWnExWgX1xGZ1HZNy?=
 =?us-ascii?Q?nVa1YbEJuD5HpwsnWJsO8GL9dsNdCf3qwEOGF52nYvEEAHvTeiyOSJzRwdwZ?=
 =?us-ascii?Q?eM1hQtcWLxlH4AeX7fvjujiqJwBA7lLCO6+zB3ZAbr7M87jlkrsvBZfUKmZ3?=
 =?us-ascii?Q?tEjsxMQFfS8H/T6CfBE8GnLGQ2OXEfKwgqPsTyu0UHPzF4fMREoKMcoXM6+t?=
 =?us-ascii?Q?y4JTMThvKc1w2AHBrzcO8jcXS76JvAyRB/7zJLnzVqd8R6t+owChJd9Gy8Zt?=
 =?us-ascii?Q?su6Zf7mE4ysvQIMZL7s/1ODeZgq2Dyk8OnQO/KVJV0fR2XNgc+YBwsqhYEj6?=
 =?us-ascii?Q?XmVfQJfsw5Fd6nqnf/aG0rY092i+OxceBEWZwGbGmlTl52IvPMxz4EjuSM8b?=
 =?us-ascii?Q?McmCKsdukUsAGnT+iKDjwIS1Vt6Y0WABi05bnmkA595YqvKaxRBWdYRCvLG3?=
 =?us-ascii?Q?zLFDigXHzH+T4LfZtCYsOsQxfRNtXiz8n1T5yvDbiyKJ/a7oPYa6OTyvAUOE?=
 =?us-ascii?Q?8/4l7nSkHytI8AmtTIhdJ+ienqvnjCSlxXKQ3mcjf+goOgcv0jFDi9Kzj1Wc?=
 =?us-ascii?Q?wU8PKAvSqSO28LxRpXvcHOO+ZYINc3wFvTPtsDHs0cX7SfEEkLWcoD2ZgWE7?=
 =?us-ascii?Q?nhqJhX1/NX8omyriJc7M1yi3NfcMd/wlrp0OWX8rhfYc4PtVcUSrzDwzbwQX?=
 =?us-ascii?Q?Gdhtjan7h0ZdpiNCrTctsRMw2Ul/NVQrbdiWlNVQuFBynz4F0Sd2aSO5i0HW?=
 =?us-ascii?Q?sSUuoByHm2cNK36eUeeLG9BKy/TvwhPRNREipArF03/56FlvYWyrkFlXJA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 22:21:20.8312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e0754f-057d-4c5a-293e-08ddbe6dc43f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9197

When "mbm_event" counter assignment mode is enabled, the architecture
requires a counter ID to read the event data.

Introduce an is_cntr field in struct rmid_read to indicate whether counter
assignment mode is in use.

Update the logic to call resctrl_arch_cntr_read() and
resctrl_arch_reset_cntr() when the assignment mode is active.

Declare mbm_cntr_get() in fs/resctrl/internal.h to make it accessible to
other functions within fs/resctrl.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v15: New patch to add is_cntr in rmid_read as discussed in
     https://lore.kernel.org/lkml/b4b14670-9cb0-4f65-abd5-39db996e8da9@intel.com/
---
 fs/resctrl/ctrlmondata.c |  8 ++++++++
 fs/resctrl/internal.h    |  5 +++++
 fs/resctrl/monitor.c     | 42 +++++++++++++++++++++++++++++++++-------
 3 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index ad7ffc6acf13..ce766b2cdfc1 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -569,6 +569,14 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		return;
 	}
 
+	if (resctrl_arch_mbm_cntr_assign_enabled(r) && resctrl_is_mbm_event(evtid)) {
+		if (mbm_cntr_get(r, d, rdtgrp, evtid) < 0) {
+			rr->err = -ENOENT;
+			return;
+		}
+		rr->is_cntr = true;
+	}
+
 	cpu = cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
 
 	/*
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 647a0466ffa0..fb4fec4a4cdc 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -110,6 +110,8 @@ struct mon_data {
  *	   domains in @r sharing L3 @ci.id
  * @evtid: Which monitor event to read.
  * @first: Initialize MBM counter when true.
+ * @is_cntr: Is the counter valid? true if "mbm_event" counter assignment mode is
+ *	   enabled and it is an MBM event.
  * @ci_id: Cacheinfo id for L3. Only set when @d is NULL. Used when summing domains.
  * @err:   Error encountered when reading counter.
  * @val:   Returned value of event counter. If @rgrp is a parent resource group,
@@ -124,6 +126,7 @@ struct rmid_read {
 	struct rdt_mon_domain	*d;
 	enum resctrl_event_id	evtid;
 	bool			first;
+	bool			is_cntr;
 	unsigned int		ci_id;
 	int			err;
 	u64			val;
@@ -391,6 +394,8 @@ int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp
 			       struct mon_evt *mevt);
 void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 				  struct mon_evt *mevt);
+int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
+		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
 
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 73f507942b6d..35faca7ff3b1 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -366,9 +366,21 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 	struct mbm_state *m;
 	int err, ret;
 	u64 tval = 0;
+	int cntr_id;
+
+	if (rr->is_cntr) {
+		cntr_id = mbm_cntr_get(rr->r, rr->d, rdtgrp, rr->evtid);
+		if (cntr_id < 0) {
+			rr->err = -ENOENT;
+			return -EINVAL;
+		}
+	}
 
 	if (rr->first) {
-		resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
+		if (rr->is_cntr)
+			resctrl_arch_reset_cntr(rr->r, rr->d, closid, rmid, cntr_id, rr->evtid);
+		else
+			resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
 		m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
 		if (m)
 			memset(m, 0, sizeof(struct mbm_state));
@@ -379,8 +391,12 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 		/* Reading a single domain, must be on a CPU in that domain. */
 		if (!cpumask_test_cpu(cpu, &rr->d->hdr.cpu_mask))
 			return -EINVAL;
-		rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
-						 rr->evtid, &tval, rr->arch_mon_ctx);
+		if (rr->is_cntr)
+			rr->err = resctrl_arch_cntr_read(rr->r, rr->d, closid, rmid, cntr_id,
+							 rr->evtid, &tval, rr->arch_mon_ctx);
+		else
+			rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid,
+							 rr->evtid, &tval, rr->arch_mon_ctx);
 		if (rr->err)
 			return rr->err;
 
@@ -405,8 +421,12 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
 		if (d->ci_id != rr->ci_id)
 			continue;
-		err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
-					     rr->evtid, &tval, rr->arch_mon_ctx);
+		if (rr->is_cntr)
+			err = resctrl_arch_cntr_read(rr->r, d, closid, rmid, cntr_id,
+						     rr->evtid, &tval, rr->arch_mon_ctx);
+		else
+			err = resctrl_arch_rmid_read(rr->r, d, closid, rmid,
+						     rr->evtid, &tval, rr->arch_mon_ctx);
 		if (!err) {
 			rr->val += tval;
 			ret = 0;
@@ -620,6 +640,14 @@ static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *
 		return;
 	}
 
+	if (resctrl_arch_mbm_cntr_assign_enabled(r) && resctrl_is_mbm_event(evtid)) {
+		if (mbm_cntr_get(r, d, rdtgrp, evtid) < 0) {
+			rr.err = -ENOENT;
+			return;
+		}
+		rr.is_cntr = true;
+	}
+
 	__mon_event_count(rdtgrp, &rr);
 
 	/*
@@ -982,8 +1010,8 @@ static void resctrl_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d
  * Return:
  * Valid counter ID on success, or -ENOENT on failure.
  */
-static int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
-			struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
+int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
+		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
 {
 	int cntr_id;
 
-- 
2.34.1


