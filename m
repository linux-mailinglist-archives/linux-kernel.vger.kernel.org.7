Return-Path: <linux-kernel+bounces-746182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 732B3B123F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3988E1CE24AA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF62254AE4;
	Fri, 25 Jul 2025 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aHr2X2eH"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3614B199EAD;
	Fri, 25 Jul 2025 18:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468418; cv=fail; b=Yo8e1W6LE8bAtK773rSUDtb8DuGBA5R0hSs5eUH1Bf0w3iNZdeK1fGhOK+slaILqmvjiUy1zYsXxvGEKxQD7n+QlL2xspomdsb501JyvMaE0NWWMGlxL57lsNo8uzvGA1L91vwioPhGfkMHdz3iNiZiFyyHBaMLG8+YvnQvhKzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468418; c=relaxed/simple;
	bh=HuWEcG4NICdpesohiR449qi1Sf9yhYxmoPIDp2xjX6s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=peAsA+cjAzae22eofh4AdFjAhDlRrZRJdIFxJridS96c4YQORQ57ZtkcThxZuzDn4M6r6LIx45+OTwzrDWhLKe4OqlX0eaLrx10KI687pDkJJPrCdCgjIcYgz0zNIiioNbIALON9J2ObhYoHTTSjetB75Sr8jiyPBtrEpqGre9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aHr2X2eH; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fa/aD7EDTekUBFD2L0nUYMvVLJdJ7RJqxSrJqzNtgJ+RXHIiVW+97FtGDsX2xUXldVon1cU3nTcMMi8yjR1qTd9NCLqrCqUKPU/8ub1e83vO+27r2dKBqVEsuZL3pC1UnSECRded1Zye5XJRKIFA0A+QjNDMenMUHk5GQ9o/XbZ6ICl4+9M2hUHzD6P/kkV4CFpDXtxZrfJa6okCdWUqZ8pgqgIR68klBN0r8ay+V5/JJoEdz3yhAfmchF6cdqra8aD/zQrrNrse8nubMnUSgo8tGgafT+w7cVCraYpZ3c/fsteJlPNwDAHnfLeAqXNclKVK2rQM/J9LJVCGUXVtJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmJpN5+1GR+I0peRdZXyDUFculqRydQ7F296FFgSmLI=;
 b=RI41nv94h7YwNnTwY1kgXn9uhkSYhXKIeWxfdj3nkGDZeuwpA3fHUZ8tlWlVDIvEVxF0pEc666MkvRVEXDffVGicHiEdoMqIp0zKwuqT/lfsxvx/W2moN3rSCYkjUKPejRQsQofZhr2A7xelJC7cbLJHrkBBkjSMAjAQ/+KSZHS51Ci1OBjBe5u2/4sXA5jEOJHW7bT7LSHkYEupU1AqsHfR4kEwDBva6wBq6o2hHtU+JxzI10XpDAHuAu6FnRlbeJMpofzxpxWBqbaxtXFnk0k4PnVdyeVS9769Qflwq/KeJ9WpFfYiIw2318fh4of/rCogktlrJhdv2JNId0R8gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmJpN5+1GR+I0peRdZXyDUFculqRydQ7F296FFgSmLI=;
 b=aHr2X2eHVuxA4Fc8tXrF9bAVIu4/nUQ/5KTKtSc6L+OnMkF/ItVKOTKkA5ynYx4v4PeOEDz1Y86Iv9dGKUxnuz9E1Y2ri6TY8koygn3JNFbCEgPALBblh67hCVWGNxyOArN+uKpEx+eF8hLznXSmgqvFIWdZWfBDfnXxlU2s1VE=
Received: from SJ0PR13CA0161.namprd13.prod.outlook.com (2603:10b6:a03:2c7::16)
 by LV2PR12MB5797.namprd12.prod.outlook.com (2603:10b6:408:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Fri, 25 Jul
 2025 18:33:33 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::ea) by SJ0PR13CA0161.outlook.office365.com
 (2603:10b6:a03:2c7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.8 via Frontend Transport; Fri,
 25 Jul 2025 18:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 18:33:32 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 13:33:29 -0500
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
Subject: [PATCH v16 19/34] fs/resctrl: Pass struct rdtgroup instead of individual members
Date: Fri, 25 Jul 2025 13:29:38 -0500
Message-ID: <69f3501ba0851befc47063b593c3d180a7f2fb87.1753467772.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1753467772.git.babu.moger@amd.com>
References: <cover.1753467772.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|LV2PR12MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e22db4-2f81-4f8d-018e-08ddcba9c238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zw6uTuGkFbruypNSQGwacr57pXM6sMJbm/JXiz4/m2a2WjPzJ6Mr+t6T4Sbf?=
 =?us-ascii?Q?mZFSExYTsWrOkKZldnmXmX1DZQyq3Z1big5lJ9de8wRDyOCLi+8qXZ3jElSH?=
 =?us-ascii?Q?AYdsX75yyOiyCLT67mSu2A+7TdgcGl/qFLWdgVKgj0Ew6cg0hoMRRdaSQU2g?=
 =?us-ascii?Q?cJNjij/9yFsJ22j4xgQ0TvIzSZaMqICzYt3+KsenNVarCrncg+mB61sdMg/m?=
 =?us-ascii?Q?hq7CFKakW+xh3WIjvX5mLb0oeR41z8EakshWFqHSqatjke6t3ItrJwmeMl83?=
 =?us-ascii?Q?EDXaHp0psxc4GWelLrptzjWKLY4/R5NrB7nKD7pNFsh5R2YQn1rOwYCumVk9?=
 =?us-ascii?Q?OKG6NFdViOcu01H/WoSGHJ1hC97l4cGoyCEE9LDO7O+F6jSBG748PpgdkOTP?=
 =?us-ascii?Q?2bAaPG0JtMYrruc2+pf5iRSxl5fwstE02I3UDCZ4nXaEpsGZbVFt526t0nY6?=
 =?us-ascii?Q?4/f2k1dhRGHbbptTH7Zw52xN8/2vSMstKR35lPQOpkguEZUVtFnB8UBoImf9?=
 =?us-ascii?Q?XC4wvHtSSN9Pl9oavi+hU4YyrdznVUL11zMRS8HaMuhrfbewzYwMQFglVxo5?=
 =?us-ascii?Q?lgQiy8EouciFcJbZgnSiF3ZrjjB+swhp9ECIo6O3Q00OWHJO6v0yfIC84XWm?=
 =?us-ascii?Q?QL0XmsIB5RnYf3zA5Ua+J/7A7pYY/jsOh3GBHmyhGlUd2g115hT7U3M4im36?=
 =?us-ascii?Q?nXkTaZfqjBvq7n9mT7SkCedI367Wp+dzBjG/kJmj51uODaDpzEA7JS0bsL7S?=
 =?us-ascii?Q?6KOVEnEqGWFn0dteLYbidDUsqspH3YjJNC/iDw2aDcTJjGgmlM9Le9A+2bHl?=
 =?us-ascii?Q?c2LEGYzW3v2ktSlp+nPZq/Yvx8W08whV1/WphrsAhfuEcuFhU8LaCkDvEi8I?=
 =?us-ascii?Q?El78tidlAxtdbqcaa8Ks2/UFg2+OWtrwIQP4f03/gmbvjzhCt8nTf824EmL5?=
 =?us-ascii?Q?LEFgieaif468MbCkq1xjthzGSZSsnuaqLcnjSKFvkjObrbaTILoJKcyIYWao?=
 =?us-ascii?Q?4W5uQTvaKsFYC9H7T2l4bMSvTklon0SzWSeT0Xa41q4sR9/uCfe8uq1eRi+Z?=
 =?us-ascii?Q?oCiF1y83vmW2SlXzPr+pB8yVc0F0vUnOCAbh1UtrO0PZAhvb23Zstggmp8tY?=
 =?us-ascii?Q?Z4dj1nFW/bvbe9YO4eXlU16q7DmG8jrhU3T3zR1S2Gqi7adfCNFTKzMvG63u?=
 =?us-ascii?Q?xnYLWQKV2VmWDuegqyeRjpSiRhpIxNwGg2U/BknbzLxy4urxg7pLqGdsesYy?=
 =?us-ascii?Q?Jin/By1+wHtCO+jFpvThv4nSI9CkJSr3v2rBTwm+gOPeMi+OnJxgEaphCvMd?=
 =?us-ascii?Q?Dj0Mgj3NyGtSy8xv7aH/gMedjTnUUkdpix3Eer+y2YDl8phLxMvmxvr0Cwjm?=
 =?us-ascii?Q?Pr/7usjDfEglAB/FbqAlVBuTihoeOIs6Iuzj55lwjVLu1Gu8dZwhIX6nlFii?=
 =?us-ascii?Q?pIJehKolKDi69p5XSu5sXI/eSpejHEms+hSRESwyBJMKKDlnIufIGQqTCzhT?=
 =?us-ascii?Q?qp03f/Bd0SSL6TGfY2E4rMN99OWGDBetXX6W?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 18:33:32.3934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e22db4-2f81-4f8d-018e-08ddcba9c238
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5797

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
---
v16: Minor code comment update.

v15: Rephrased the changelog. Thanks to Reinette.

v14: Few text update to commit log.

v13: New patch to pass the entire struct rdtgroup to __mon_event_count(),
     mbm_update(), and related functions.
---
 fs/resctrl/monitor.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 049a82729c0b..070965d45770 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -356,9 +356,11 @@ static struct mbm_state *get_mbm_state(struct rdt_mon_domain *d, u32 closid,
 	return state ? &state[idx] : NULL;
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
@@ -420,8 +422,8 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
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
@@ -429,9 +431,11 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
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
@@ -460,7 +464,7 @@ void mon_event_count(void *info)
 
 	rdtgrp = rr->rgrp;
 
-	ret = __mon_event_count(rdtgrp->closid, rdtgrp->mon.rmid, rr);
+	ret = __mon_event_count(rdtgrp, rr);
 
 	/*
 	 * For Ctrl groups read data from child monitor groups and
@@ -471,8 +475,7 @@ void mon_event_count(void *info)
 
 	if (rdtgrp->type == RDTCTRL_GROUP) {
 		list_for_each_entry(entry, head, mon.crdtgrp_list) {
-			if (__mon_event_count(entry->closid, entry->mon.rmid,
-					      rr) == 0)
+			if (__mon_event_count(entry, rr) == 0)
 				ret = 0;
 		}
 	}
@@ -603,7 +606,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
 }
 
 static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *d,
-				 u32 closid, u32 rmid, enum resctrl_event_id evtid)
+				 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid)
 {
 	struct rmid_read rr = {0};
 
@@ -617,30 +620,30 @@ static void mbm_update_one_event(struct rdt_resource *r, struct rdt_mon_domain *
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
@@ -713,11 +716,11 @@ void mbm_handle_overflow(struct work_struct *work)
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


