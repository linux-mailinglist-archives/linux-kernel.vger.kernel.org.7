Return-Path: <linux-kernel+bounces-770002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9DCB275CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9B2AA36EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA59929B8FE;
	Fri, 15 Aug 2025 02:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yechazYG"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1242BDC25;
	Fri, 15 Aug 2025 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224861; cv=fail; b=VK/Jpv6UCIXdJmjIs7QMGR5SkXKfozuMoLNkIG9rPruLBvhfTNwEezhwCn+Vhba3qRDXC894PAnCGIMfCB1BuYYhdrrI3BGi5g5zrDlNQs7TAOe2sBPUcwt5fYd9hUXK1z3aJJaKu0VfUiL1reI18xJPhZGTCNZTIZ0i4sG50Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224861; c=relaxed/simple;
	bh=bSTRSdq+/VU9SXJBoz2rcUOIHk8fxLdRGBf17b0aT9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAMPf3jmhmkxuggVxl5DMQ2XfUOwjZjSWkonEAL2UVJTJcaIh4+Yybw17xi2uHUdPbjSThyZb6trTgi7J7/o0SRL5ol+V07rpD16cgyB1kX/lDF9lUuppaHENZsxAmDrc4qYzpek9R7qEDw8lLpsGdT8BV3Y8cKF3g91wWfMr3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yechazYG; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxshOc1DTrOUmxKyk+UobjDzWpfnCN0pOaB9QJ84P4L01F9AIwQ4rZ1iMu5oNhPsgirAVzdddtFjpMoCRugivSVe+6EYx39X/Bl39rXxISOwEhbWjAQdT/MoHKPS/Xwe2eCO76xb114Y2icBvbt/Mf0f8zeZW3W0hs5TCUXJwQ6JAqr6zx4jE97moW1Wvy2vb4P15Sbno+bZNvNiMUL1zfjprFZYCYNi6+BRVArg47TwtKbVPp8umLTpl4FBnfqevqTs87YPxRedfYLk9GbRHo4xnJAQh8B3teGGS6B7DemNg8j1WwP1gUopMfia1oLZZUV5HVCYH6n5B2TkwEj6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AX36/lPni676YFts0VsIJkjjMVAPwCcp8pSkJxpilL4=;
 b=NX9koollisW0vLGspedBtusN4IeMU9CAFo0czcQkFrhUpCA9IohMNYZvCjidJHdCKWMgqp9RZp36ciMJYi3wyDYNqGhfCC70NMeqEHxcbRJrvEP26NhLVWYDw7e1r1Y+rfqYu/Y48kNR2xynUKt9bKFDkZnV4eBw5HAE6oSkzqnCep4gVx2MIMSxMe3ufd+K8ON1xxPPZrn7txwLBqI53e0o1cgNJPnX+DcHNEUiMzvXkt3IiCiWeoOh1rVbg1xL6fhX7jyVRcIwjjNCBefY67i0xGU92W5jXdd0R3Lqq4E50QtoS/mT9rUwF97PA7gEmVF+94d/uuzl0eVqtzArAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AX36/lPni676YFts0VsIJkjjMVAPwCcp8pSkJxpilL4=;
 b=yechazYGhj+3sv9fh4BGVJMlihyC+0i5KjvMcStwwJz6y922jKxzPtLK0TTLFR4o3vhO764KRaiWXlwytmw2F7cRl1J9Jk/XnfUv//tZeChDSQZfijzA/NUIANm2oj4Ue/disym0bo2odHfHt5EEVr1uhniL2GxrQnCKBk6Rh28=
Received: from SJ0PR13CA0224.namprd13.prod.outlook.com (2603:10b6:a03:2c1::19)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 02:27:36 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::5) by SJ0PR13CA0224.outlook.office365.com
 (2603:10b6:a03:2c1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.6 via Frontend Transport; Fri,
 15 Aug 2025 02:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:27:35 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:27:32 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <babu.moger@amd.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<rostedt@goodmis.org>, <paulmck@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <thomas.lendacky@amd.com>,
	<yosry.ahmed@linux.dev>, <xin@zytor.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<mario.limonciello@amd.com>, <xin3.li@intel.com>, <perry.yuan@amd.com>,
	<chang.seok.bae@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peternewman@google.com>,
	<eranian@google.com>, <gautham.shenoy@amd.com>
Subject: [PATCH v17 12/33] fs/resctrl: Introduce mbm_cntr_cfg to track assignable counters per domain
Date: Thu, 14 Aug 2025 21:25:16 -0500
Message-ID: <82e821e046eb1d4ea8780bbd7339a7e5aa09c621.1755224735.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755224735.git.babu.moger@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: d73818ff-13e2-42f2-6540-08dddba34bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zKebqIdjlz0GLanCV/kZMjINz9RV+hwGeL/xDbgj+k20Vk3Z68JKkIXBiHhz?=
 =?us-ascii?Q?YHWTaswt5PK2FTunyBgtsU/djb5ZlCGIZds4NHSQEn2VAJLis7zxG58K8Ftx?=
 =?us-ascii?Q?43SQN7QGY3p7FcHfmvSVUYifsPsmlWXF9k5bA07MmORZdFhs0p+3S2CGC2Zg?=
 =?us-ascii?Q?62roa29+jxRJoHB7mcfrSYvun+ZiCGQdcRMLy3LyGdTVayb58mPFX9L3+LLR?=
 =?us-ascii?Q?G9WF+5vTlAtQrIWlOiIXKmRbbo9talPwOwG/qAdc2pAxgzaJUWFX9icA5OZ0?=
 =?us-ascii?Q?OC8XkeDGnhwfkNR6xgMOOpmfXGeOO2/50lg+nhxRH/tYE8UMaYtzAz/hn1YZ?=
 =?us-ascii?Q?cg3RRnpZQ/Pyg11lIwIfVJGFy2jFUbL1Gsxyom6898S8kGnL+N8IUd2VgKt6?=
 =?us-ascii?Q?EcrqVnfzXo0XROsPu4myiHNjheoTzLZzpsz/0Ki0CwuCQRm/QYICI0GTOl7Y?=
 =?us-ascii?Q?JHKufZgvJwpy0AtMHzHYHkB7ZLptL7EZ3P6ASMaXpetbK7biJmWaTfN2mYej?=
 =?us-ascii?Q?Jcsn1qIkv0BVoXG/WR9/lMFLrcErVB50fAR7PFIfVadr2mM4Lw7k0lBmkLSB?=
 =?us-ascii?Q?Q8y2g/hzkRLkFFk+1OJikh7p4aMZ4MnWgvszm7vf35lOHr7gZqujpW2/C7ys?=
 =?us-ascii?Q?7y5SryDVmX6uwS8USlV2lnrDcA7yP7ggfBegTKxfMjk2HwAqpcDqWoGlTNIp?=
 =?us-ascii?Q?24BtuEjsh8VUoxS81u4UhHW3NFuGM4S8zKwX/xTzZh2oGkf0FFpzhv9VBYn2?=
 =?us-ascii?Q?K8x6i20rGHuS3ybyi2JiJ9aWVeB2Q5NN9qoWjYwgasVVezsn+yqVSaanU04l?=
 =?us-ascii?Q?GuMS1vcazkJUVR66OgSwHi0SB07fbKiuOJyp+NJVZbi9kVAt/+TumJM9vRpm?=
 =?us-ascii?Q?I1vPraiRn0f6QpTw53F85KN7SHGx7uKtXBmKYSTdVNMtrzLe0kHgi8bcau4L?=
 =?us-ascii?Q?NpreIi7SwAdD0q/g68jxKU7pMMXzzdn530X0AYzKgYQRJPWGc7ekN96GGgb1?=
 =?us-ascii?Q?V6Ngj0IISrkKG8tM6qtft5zXmga/VjSfdaznuI3RkBvDv8wvnj6n2pklokoW?=
 =?us-ascii?Q?vqvN8SfqeS1R62Ujb0UHPzFhh/bL8sfWzesyb/31vfmFR8/uLup0oLmeB8Ti?=
 =?us-ascii?Q?kIiKKmY/oSs3r0wUwZ2HIX152+/Upr4u8NXTGCmvTuZU47A7UZyPvOtUqzF7?=
 =?us-ascii?Q?V46hYd/7cZW+RCMLcKfXrwAxS6j1I0fgznLaUW+B7OnZ/uKaUyDiJ5aw7vAc?=
 =?us-ascii?Q?pR9pEtlDgc7wDtWrpcIMZxsOtr3S6iQ+l0gN7O4uPUqYftNlWZc4NTByQp03?=
 =?us-ascii?Q?2MExUQIurb5wyaERW5iothZtuv2zTIwYSbc2GynItXsCLUJs0F5hkXlvqPeA?=
 =?us-ascii?Q?rRLVFa9N7IsIr7QbemlSRiGSiI4XvboDg7W2p2pfh3VD4sSxohqlbROeUOKb?=
 =?us-ascii?Q?XERe2V7QulKYP6QsADwRMcJhtt5J2pXWz9fxb4UkJ8os9joG14u+JsQUkjJP?=
 =?us-ascii?Q?l1ppvAIa5LWqw8K4Qv9/1Yz/K5n6XL1WaEj9ROXWLjEnNKAXLDhxGhwEeA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:27:35.2333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d73818ff-13e2-42f2-6540-08dddba34bc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628

The "mbm_event" counter assignment mode allows users to assign a hardware
counter to an RMID, event pair and monitor bandwidth usage as long as it is
assigned.  The hardware continues to track the assigned counter until it is
explicitly unassigned by the user. Counters are assigned/unassigned at
monitoring domain level.

Manage a monitoring domain's hardware counters using a per monitoring
domain array of struct mbm_cntr_cfg that is indexed by the hardware
counter ID. A hardware counter's configuration contains the MBM event
ID and points to the monitoring group that it is assigned to, with a NULL
pointer meaning that the hardware counter is available for assignment.

There is no direct way to determine which hardware counters are assigned
to a particular monitoring group. Check every entry of every hardware
counter configuration array in every monitoring domain to query which
MBM events of a monitoring group is tracked by hardware. Such queries are
acceptable because of a very small number of assignable counters (32
to 64).

Suggested-by: Peter Newman <peternewman@google.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v17: No changes.

v16: Added Reviewed-by tag.

v15: Minor changelog update.
     Removed evt_cfg from struct mbm_cntr_cfg based on the discussion.
     https://lore.kernel.org/lkml/887bad33-7f4a-4b6d-95a7-fdfe0451f42b@intel.com/

v14: Updated code documentation and changelog.
     Fixed up the indentation in resctrl.h.
     Changed subject line to fs/resctrl.

v13: Resolved conflicts caused by the recent FS/ARCH code restructure.
     The files monitor.c/rdtgroup.c have been split between FS and ARCH directories.

v12: Fixed the struct mbm_cntr_cfg code documentation.
     Removed few strange charactors in changelog.
     Added the counter range for better understanding.
     Moved the struct mbm_cntr_cfg definition to resctrl/internal.h as
     suggested by James.

v11: Refined the change log based on Reinette's feedback.
     Fixed few style issues.

v10: Patch changed completely to handle the counters at domain level.
     https://lore.kernel.org/lkml/CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com/
     Removed Reviewed-by tag.
     Did not see the need to add cntr_id in mbm_state structure. Not used in the code.

v9: Added Reviewed-by tag. No other changes.

v8: Minor commit message changes.

v7: Added check mbm_cntr_assignable for allocating bitmap mbm_cntr_map

v6: New patch to add domain level assignment.
---
 fs/resctrl/rdtgroup.c   |  8 ++++++++
 include/linux/resctrl.h | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 9b97cadbb5c5..ce1c894dab18 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -4032,6 +4032,7 @@ static void domain_destroy_mon_state(struct rdt_mon_domain *d)
 {
 	int idx;
 
+	kfree(d->cntr_cfg);
 	bitmap_free(d->rmid_busy_llc);
 	for_each_mbm_idx(idx) {
 		kfree(d->mbm_states[idx]);
@@ -4115,6 +4116,13 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_mon_domain
 			goto cleanup;
 	}
 
+	if (resctrl_is_mbm_enabled() && r->mon.mbm_cntr_assignable) {
+		tsize = sizeof(*d->cntr_cfg);
+		d->cntr_cfg = kcalloc(r->mon.num_mbm_cntrs, tsize, GFP_KERNEL);
+		if (!d->cntr_cfg)
+			goto cleanup;
+	}
+
 	return 0;
 cleanup:
 	bitmap_free(d->rmid_busy_llc);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 919806122c50..e013caba6641 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -156,6 +156,18 @@ struct rdt_ctrl_domain {
 	u32				*mbps_val;
 };
 
+/**
+ * struct mbm_cntr_cfg - Assignable counter configuration.
+ * @evtid:		MBM event to which the counter is assigned. Only valid
+ *			if @rdtgroup is not NULL.
+ * @rdtgrp:		resctrl group assigned to the counter. NULL if the
+ *			counter is free.
+ */
+struct mbm_cntr_cfg {
+	enum resctrl_event_id	evtid;
+	struct rdtgroup		*rdtgrp;
+};
+
 /**
  * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor resource
  * @hdr:		common header for different domain types
@@ -168,6 +180,8 @@ struct rdt_ctrl_domain {
  * @cqm_limbo:		worker to periodically read CQM h/w counters
  * @mbm_work_cpu:	worker CPU for MBM h/w counters
  * @cqm_work_cpu:	worker CPU for CQM h/w counters
+ * @cntr_cfg:		array of assignable counters' configuration (indexed
+ *			by counter ID)
  */
 struct rdt_mon_domain {
 	struct rdt_domain_hdr		hdr;
@@ -178,6 +192,7 @@ struct rdt_mon_domain {
 	struct delayed_work		cqm_limbo;
 	int				mbm_work_cpu;
 	int				cqm_work_cpu;
+	struct mbm_cntr_cfg		*cntr_cfg;
 };
 
 /**
-- 
2.34.1


