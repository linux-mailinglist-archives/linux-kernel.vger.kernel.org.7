Return-Path: <linux-kernel+bounces-770009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB34BB275DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00152588068
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE93829A32D;
	Fri, 15 Aug 2025 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V8lXpQNq"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A9C29A323;
	Fri, 15 Aug 2025 02:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224921; cv=fail; b=eGsC6gvBf18SzXNR8dfyiUksGtDEkwehTrLTo1Jzy73xvesy9bAyPLTsLFwTcdCLKQuC4rXvmzkR5BdO8c+0n5YjC4rpJGE4trSCzlS7qMTa582mfWU6LzTDz7r5FCWmIfSCcSeMNxXSj2LLzZLrgSG5IgfOOskAUxDwBUYeEXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224921; c=relaxed/simple;
	bh=u422pUZoZeo1JNtTpjtUaZG1mbJB3Mn0nMNzP2t9FHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQURaaZmotpM8cfJIKQle+doWCSONz62NMj2Lpb0eWgq+iyiPyeP2+reR4T1pS7gQLu+02O+ClntV6X0t1gIeWtLmGnHpMzZttKfD5bGWP0ntRmL4h1i3ejydSLYKAMeLyv5RBQrHEf5rLguys6aE2RL0G1Gfo6rVeDDq8fzlkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V8lXpQNq; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzypWfJg/jDYoRWlI9WdLbhBIl9fMutgnAdWzrS/HuDwN3wxRbNP6nOt3s63VZSftFsCrWNwqs3u2ujRJxPqRHLK5K7cSHS6zvUn3Krt9d46OSc3+zBYz3Cw2FXMeWNzDKTvLyXxJWk/wJzrzmwZHyoJeaYwAAHk+gmlm9adY26LLFgshCgGtSepoeYM06aLrfMM/Ym3uTfWGkTgyuJ7dylFHkw3YP4zYpwkgZfnn9hIXrVESkTwTXx15nCYwK470AsJ42NkQnh9hvXiLHyp1nJPPqYsbJpPtlTttEZRHCsfPEIaDZt7AbBh/pzXHzw+rZB1Vc04SBcKDFUjL+QrFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzpVTuhrJooC6KKVNRxPbhnM4uJvfG8TZiFUKho4Bec=;
 b=VtIojy1CbVKEl2dyDQ4WytUn7T9L5PgF2CtIysrNc1oJW6aWi4oXdLuK4Kv8dYd520EhqzYHRbQl5WN0fpceIysen2lYOfJ8BaRrPacIvaCEZBI3uaPhLDw7iB/ddTXBpCPeTtAf5dlfBAMv47Nal1oDeGttHjdSLRmdCs8rlI2I7ExVcyFwh3/ADfo7tmA8Rv8nQ551VavQfZs98xMIdSatdPWMwL27TNXyl4XKB/RyON6hoKyGG/Yx04jD9uaAk1aATNceV1qxwAUaTtEJObZ4qWPc3YYGDP7d31qjWcvXKHDq7ckX+49dL/T1+6eb1qq6aZvIrYbZBw3H9KetrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzpVTuhrJooC6KKVNRxPbhnM4uJvfG8TZiFUKho4Bec=;
 b=V8lXpQNqra65DtWAN7zcMljmMmU5mK1eIAsggUaqjvy226LtffnYKS/5ecEnHPzN9T9x+7OVziaTyfDXYYE26Hdga8C5ZvZiU2JLdDZaNgYC3L3d/CJv/YV2XQM7DYlok3OLeCKAUpqXyeddsQkWYvztQn+9UJfRWvtC5Yt6Ql0=
Received: from MW4P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::26)
 by DS4PR12MB9587.namprd12.prod.outlook.com (2603:10b6:8:282::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Fri, 15 Aug
 2025 02:28:35 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::df) by MW4P221CA0021.outlook.office365.com
 (2603:10b6:303:8b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 02:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 02:28:35 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 21:28:32 -0500
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
Subject: [PATCH v17 19/33] fs/resctrl: Pass struct rdtgroup instead of individual members
Date: Thu, 14 Aug 2025 21:25:23 -0500
Message-ID: <defab10e7fd53d2cda96a4678a6c6ca230bd6be6.1755224735.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|DS4PR12MB9587:EE_
X-MS-Office365-Filtering-Correlation-Id: f003e4cb-2d58-4976-762c-08dddba36f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dQ6dnJSqS4q2WFCaLqOkkHT2RDAnWlS9DeyUq/sK74gIYOWZKT24NULvkDS9?=
 =?us-ascii?Q?7lxni9JbB2h7enPImc1RcGZRyl2UMhx1yY7CAVqrjVCccffjEptoBWGPWblG?=
 =?us-ascii?Q?XbKc4dJOEn9hAY2St6odZFWJMk7MK3Oedlh5jbqnzQ39Vs7feow4YNfFSBT9?=
 =?us-ascii?Q?1Vb/9Ao8CWeBnT61Q0HLAfdrfmwQ8X9ATyZawSLc4rNRedI++NiJ+W/cYk7e?=
 =?us-ascii?Q?maCAK3nWhpg5YldNEi+Nvv9V/nbgAM1KggHDVduKuifzQ2qYOXipJ5PO0qiH?=
 =?us-ascii?Q?6xZvhraRHGDvLwqezJ4cb4ZyTmJoduzM7jHQ/lEUxRgyTRu4Y6YYBYUY8jMN?=
 =?us-ascii?Q?9HxQTEoKS6yx+AexYKab953hM+lm350Kvh2UkXSNpBbJwOKs0Q5zy1sPrNcA?=
 =?us-ascii?Q?fpyf8oQFgSRdJkFl78z9h+xNeNiR6iq1smrOFm31Uo4lPKk0zVH/GmBW25fc?=
 =?us-ascii?Q?eoco6RGc7xnVSciUaqhiYZcgvzbYJnrrqwkhnPb5dLiYNM60MqZDiDlpur2N?=
 =?us-ascii?Q?KBMqqhaeBBX1lnDUAvHE2VX7/JBD1XGzSszEIvSSvw90hbwPI9rWuTUfOrIl?=
 =?us-ascii?Q?p1kS/9TJxP9c2GK9jxD38nsFaQgJqVQVOQoYRIaHY87cjZS9dGeh+QjP4RNu?=
 =?us-ascii?Q?c/3URnQ5F+MbgsgZALh2M+eHX7VQ4WaVlcEHkKuBod0YDc+Xbkldnoc2Y4MV?=
 =?us-ascii?Q?QxWseJSQ2aGvjOPtmYRX5178s97DEmOuitjS7qooS4XYSde2eCw21ErIlRIn?=
 =?us-ascii?Q?k01RaI1p782Hjocsvt6tEaG2N5SrAUva3zW9R1W+h9+LsUsdo2dRhe/fBC0G?=
 =?us-ascii?Q?Lvv7mh5cK0yv+BgPMTTObPhnMEWyuAiYgQxFxMoefE+/+Cay1SKZt+MKm6nB?=
 =?us-ascii?Q?ZumY9PIADHeh2K/P+azejop1NivBzLxW6B7KvXHDfCmzV1L9k+ZoiYZBdMIC?=
 =?us-ascii?Q?mhl9WghL3MstJ0Ab4cMIkp/V6zMyPs+MRglFzmsGfTyLAWi2A+iv8kg8w0NP?=
 =?us-ascii?Q?MMBiR/2rFqt4wQewzKlDBjwUgFr+LjnBqFvxsZsNVP7iPVoUcXtLJCD2GR4v?=
 =?us-ascii?Q?4116vrChqyaKqMT7/6HF2xfZg2pPPi+b21c3k20rQe1BnVark/rdAkKxA1eC?=
 =?us-ascii?Q?JDcUKANyhiBheeT25C0rWyeCAWRsqpbZTk2tAdYtyj5QCAcA5+369fq/53ci?=
 =?us-ascii?Q?YUjGYmH9O9f1egoePwg4vhfyBgtoMqR8l2oEVEWgl87nHezIROp5g4dPSslW?=
 =?us-ascii?Q?S5R82P8VRQosdbqfwAOkoSts41cqQcur0ApMNQr/+kXKfgqV5uldFRwWL4Sx?=
 =?us-ascii?Q?J5OqTsw7PPbHE73U3tJSKaAO26dGR7GZ6iuXwWS/3OH/vzUfGl4zirM/fMjM?=
 =?us-ascii?Q?MMsIOSlZKK9b+XXOOo5Owj1SHcu+sT93subhy93fzGUK8HZiNvFUt6cBF1NG?=
 =?us-ascii?Q?Z6d+NxhL+dmKkPB3vmCVdjXN+4b9p7i0EMhHHnKHO43l1GRvWFUWVBoHqT99?=
 =?us-ascii?Q?bLU852DnNmUndGEBz8Xdmf+1sSFWy+8/W1kt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:28:35.1589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f003e4cb-2d58-4976-762c-08dddba36f7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9587

Reading monitoring data for a monitoring group requires both the RMID and
CLOSID. The RMID and CLOSID are members of struct rdtgroup but passed
separately to several functions involved in retrieving event data.

When "mbm_event" counter assignment mode is enabled, a counter ID is
required to read event data. The counter ID is obtained through
mbm_cntr_get(), which expects a struct rdtgroup pointer.

Provide a pointer to the struct rdtgroup as parameter to functions involved
in retrieving event data to simplify access to RMID, CLOSID, and counter
ID.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v17: Added Reviewed-by.

v16: Minor code comment update.

v15: Rephrased the changelog. Thanks to Reinette.

v14: Few text update to commit log.

v13: New patch to pass the entire struct rdtgroup to __mon_event_count(),
     mbm_update(), and related functions.
---
 fs/resctrl/monitor.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index c03266e36cba..85187273d562 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -413,9 +413,11 @@ static void mbm_cntr_free(struct rdt_mon_domain *d, int cntr_id)
 	memset(&d->cntr_cfg[cntr_id], 0, sizeof(*d->cntr_cfg));
 }
 
-static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
+static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 {
 	int cpu = smp_processor_id();
+	u32 closid = rdtgrp->closid;
+	u32 rmid = rdtgrp->mon.rmid;
 	struct rdt_mon_domain *d;
 	struct cacheinfo *ci;
 	struct mbm_state *m;
@@ -477,8 +479,8 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 /*
  * mbm_bw_count() - Update bw count from values previously read by
  *		    __mon_event_count().
- * @closid:	The closid used to identify the cached mbm_state.
- * @rmid:	The rmid used to identify the cached mbm_state.
+ * @rdtgrp:	resctrl group associated with the CLOSID and RMID to identify
+ *		the cached mbm_state.
  * @rr:		The struct rmid_read populated by __mon_event_count().
  *
  * Supporting function to calculate the memory bandwidth
@@ -486,9 +488,11 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
  * __mon_event_count() is compared with the chunks value from the previous
  * invocation. This must be called once per second to maintain values in MBps.
  */
-static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
+static void mbm_bw_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
 {
 	u64 cur_bw, bytes, cur_bytes;
+	u32 closid = rdtgrp->closid;
+	u32 rmid = rdtgrp->mon.rmid;
 	struct mbm_state *m;
 
 	m = get_mbm_state(rr->d, closid, rmid, rr->evtid);
@@ -517,7 +521,7 @@ void mon_event_count(void *info)
 
 	rdtgrp = rr->rgrp;
 
-	ret = __mon_event_count(rdtgrp->closid, rdtgrp->mon.rmid, rr);
+	ret = __mon_event_count(rdtgrp, rr);
 
 	/*
 	 * For Ctrl groups read data from child monitor groups and
@@ -528,8 +532,7 @@ void mon_event_count(void *info)
 
 	if (rdtgrp->type == RDTCTRL_GROUP) {
 		list_for_each_entry(entry, head, mon.crdtgrp_list) {
-			if (__mon_event_count(entry->closid, entry->mon.rmid,
-					      rr) == 0)
+			if (__mon_event_count(entry, rr) == 0)
 				ret = 0;
 		}
 	}
@@ -660,7 +663,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
 }
 
 static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *d,
-				 u32 closid, u32 rmid, enum resctrl_event_id evtid)
+				 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
 {
 	struct rmid_read rr = {0};
 
@@ -674,30 +677,30 @@ static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *
 		return;
 	}
 
-	__mon_event_count(closid, rmid, &rr);
+	__mon_event_count(rdtgrp, &rr);
 
 	/*
 	 * If the software controller is enabled, compute the
 	 * bandwidth for this event id.
 	 */
 	if (is_mba_sc(NULL))
-		mbm_bw_count(closid, rmid, &rr);
+		mbm_bw_count(rdtgrp, &rr);
 
 	resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
 }
 
 static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
-		       u32 closid, u32 rmid)
+		       struct rdtgroup *rdtgrp)
 {
 	/*
 	 * This is protected from concurrent reads from user as both
 	 * the user and overflow handler hold the global mutex.
 	 */
 	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
-		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_TOTAL_EVENT_ID);
+		mbm_update_one_event(r, d, rdtgrp, QOS_L3_MBM_TOTAL_EVENT_ID);
 
 	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
-		mbm_update_one_event(r, d, closid, rmid, QOS_L3_MBM_LOCAL_EVENT_ID);
+		mbm_update_one_event(r, d, rdtgrp, QOS_L3_MBM_LOCAL_EVENT_ID);
 }
 
 /*
@@ -770,11 +773,11 @@ void mbm_handle_overflow(struct work_struct *work)
 	d = container_of(work, struct rdt_mon_domain, mbm_over.work);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
-		mbm_update(r, d, prgrp->closid, prgrp->mon.rmid);
+		mbm_update(r, d, prgrp);
 
 		head = &prgrp->mon.crdtgrp_list;
 		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
-			mbm_update(r, d, crgrp->closid, crgrp->mon.rmid);
+			mbm_update(r, d, crgrp);
 
 		if (is_mba_sc(NULL))
 			update_mba_bw(prgrp, d);
-- 
2.34.1


