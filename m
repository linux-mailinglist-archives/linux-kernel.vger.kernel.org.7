Return-Path: <linux-kernel+bounces-898401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B26F2C55325
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AA50345056
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E25242D7B;
	Thu, 13 Nov 2025 00:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F/kXnAla"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012003.outbound.protection.outlook.com [40.93.195.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F832248A5;
	Thu, 13 Nov 2025 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762995542; cv=fail; b=nxZPMh+q4bI7hUMOTeM1Bg5AP963QOkvKq3bQvIzttlBxH/LryFkvM9boz2sHg7izg9CL8Tb/71nQvYF0JZEqg/w6h+eoqMd+vbzO8jLjH2LlVAP4srS5Qz5QdhTZuM6sQnXGoFzfV8P0klqIkijd6vh/6TpKSl8XVt98J8ejDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762995542; c=relaxed/simple;
	bh=Hzl1JYxhZqwQbM19y2dZw7p5ZNyWikIGqmkdLfTBy5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IrmCqoaopir693yppgE6BCbLuR0a+J7pVVyQnqzIjGKTQo/OfLVwb0UWyFe85JbgKIkiY9FXmVxKHCaSx00q8JvUcUjo2TBmePBGcn4p8TCtnZ29UMehXwZltxkwdG8z3u5eTc+gDopZ3G5jucIyqnV0Xs6YZLJY1Vds0eOU0dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F/kXnAla; arc=fail smtp.client-ip=40.93.195.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbCCR/gahR76QvhELTAHp8qB9Flj1It3EP56LyLr3g34QdQTYyNpqFbBSwucfs7v5+oa/d/+eOlTgrsBLsZ3ZU9oQNqgoDeI1mptiuanphNWG/7O2kjbnpiyINS9XGzqvfw0gjO18hZvWdFmPbnHtGdG/IO3lb3UewXACC+JgeGFypumguimntpMI8X6rXbE94ZyjvYgFzkjEr+2A/1ADgy7sE0TNnyR1M2xdqsCoVa0JGj+9ASIAjOXQtd5bsoojrYDuHoPpCFngs41bpMlMb0tRVGblh75S/GNJip2dvG8z2ex7+lxbCQcVaslt2ZK6vhtik+9XgTGMWujZ/Ce/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipK5PykmwVQ974c378HdCDVGbngHT7J8AihuGjpFDzM=;
 b=ne9mUXf2/UoPGVejmsne7kYsw3T/wFVJw2TQVmFDlhGhJ914q2TcaIHTOgVISr0LttJBu4dLjbfSmIyhATk2QoSD61q84lFXlTKdlxfR13TERi2/UsczFXb0/KyJ1HkN/rVKLStJXJ4ivllprmh5P9wj245pl37YmkTfYtoTm2/DqVgTsQKiWnyQd8sedP8XQVfwVY9fVMpKSNd4hqv1gx5t8n5t31fybBTr6M6va47sc6NbddJ6xdNG3y9DalKCkRT2lMjY2IRkpBQTjphWjqpcMCUHIEeL1Cu8p1LYXsp3cDjh9sZDb8M40oME2Vlg0WzFMT3HN/SnNnuxCJAjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipK5PykmwVQ974c378HdCDVGbngHT7J8AihuGjpFDzM=;
 b=F/kXnAlabYXlsJyOPek/pZesN/vWniHIwgxFxyK/cAshaepXV306VGOw+s20J5gIhazOM5gVzA3+D1FQxkmBVjG7UH6NbWwc0dgPcBe2Cb2vghKaWhiIPROJlEbm0ciDR22I6K/jKVCKmkgZDCzJAFVDgwTlVtXoyQOMN+CTziM=
Received: from CH0PR04CA0019.namprd04.prod.outlook.com (2603:10b6:610:76::24)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 00:58:56 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::c7) by CH0PR04CA0019.outlook.office365.com
 (2603:10b6:610:76::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 00:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 00:58:56 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 16:58:54 -0800
From: Babu Moger <babu.moger@amd.com>
To: <tony.luck@intel.com>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <corbet@lwn.net>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<babu.moger@amd.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rdunlap@infradead.org>,
	<pmladek@suse.com>, <kees@kernel.org>, <arnd@arndb.de>, <fvdl@google.com>,
	<seanjc@google.com>, <pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<thomas.lendacky@amd.com>, <sohil.mehta@intel.com>, <jarkko@kernel.org>,
	<chang.seok.bae@intel.com>, <ebiggers@google.com>,
	<elena.reshetova@intel.com>, <ak@linux.intel.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <feng.tang@linux.alibaba.com>
Subject: [PATCH v12 08/10] fs/resctrl: Modify struct rdt_parse_data to pass mode and CLOSID
Date: Wed, 12 Nov 2025 18:57:34 -0600
Message-ID: <f8ec6ab5cf594d906a3fe75f56793d5fbd63f38f.1762995456.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1762995456.git.babu.moger@amd.com>
References: <cover.1762995456.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 545eaefe-e079-4bf3-efac-08de224fd277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BTr9N9r7gYML874pb59iAsTlPX66bh9hlq2w+0y6lL6E4EPt34BOJjzult00?=
 =?us-ascii?Q?uYDX0eihBAJNrt0sCXELLqPNY5veTYDhJRUhoNvGzlbTPJqXXnzOQu2WOn59?=
 =?us-ascii?Q?HR/hcBcFK5dQXmDwgHLt0ohjX5DFqBGlaqTuGqbhJHWy7nyTpRxlnRJ9zTui?=
 =?us-ascii?Q?1cCt+sBBL0r9eygzOXWd6W7+WQ0uovslHq57SjBUp4g8DrP9iwD/WO1zcQqQ?=
 =?us-ascii?Q?oYQJRZRnHVrtgQarrc21ZVmsbQjg9nh8rUK6OOXQgLNULQChaZ2tPqaZbvjr?=
 =?us-ascii?Q?KnZwBPbTTerMjGU4is2iQx3nQ7WpdeMIZpDBBMYaPcvt8v6ydi0BqJMutp/F?=
 =?us-ascii?Q?kyGx+wUgIBIwJWKx5kVITX5TYj7GS29SMxNqWXuCms2GZuQ5jeO1RgrK9hT7?=
 =?us-ascii?Q?WYrdOb/WWx3J0DgaTTLwLrvXfLT7SfBhtxCBgefL0fW+nB+Pp2WJDQ2TW2oH?=
 =?us-ascii?Q?rEGdFTrredsWnn7vh6GIx1bEYd59RCISDnNtd0VNMUbPYcniBTtTgVBTJlTA?=
 =?us-ascii?Q?Hv5N1tdI/x4ZB/n2tTfuJahVms1CMbmqIROsR/dA/2EWHZqUXAe1WTIRXlMz?=
 =?us-ascii?Q?OqVQdXAhyixwmXUZgxiX1MBXp5q4k9ib4Hped/QNJ6I4UfiQjUSvgqYx7esS?=
 =?us-ascii?Q?QzcvOJHbOdS2ireQSSZG3qXTET83iESWNVD6sO+g837m4unJz+eJ9LdqhKrm?=
 =?us-ascii?Q?pnKJy6dr7sghruWU/noEXfCeJHr+hsDt1o5VEv60ynmOBLr07w67cdj+7icF?=
 =?us-ascii?Q?9khOj3jbtOgpaabuemFpIgwR/Enz2bQDqGw0HrG7B6fEgtp28rI1uQr8Cf4U?=
 =?us-ascii?Q?ZWA1C49/Tf5LXrSMMjYqa+iKaHD9Kl0aQYBFVZeK9BM2Sx9Elqnz3VHBsWae?=
 =?us-ascii?Q?S8dFGsZIphEvcf2TE02Z8EAVj7spSjUMi3zVHHQXL8bO76PYgbew8I4H7ETf?=
 =?us-ascii?Q?K7ZVZq+bLuIa5K03k9kZ1nOcMTOPser7UbB4BeWdYWbeoVKAxkHFdX/go7gO?=
 =?us-ascii?Q?kR7Ggampc8kNBM3pmF+8AJxSG4SIKA7WKm4kE+pCozSL2r+3qH+p24nB/fxq?=
 =?us-ascii?Q?Me4LvZ0hB5zef2qTB6LU3bjtqJ6vIoO5alLCNPpk7KhzyPwIiYOM8qQi4fQk?=
 =?us-ascii?Q?9fYwJtbUMDdklCGnjgS++4M7JvJtlQ+j4SVwmd1sIW0L43XcTC7UO3hhNM3G?=
 =?us-ascii?Q?qTKlk0tAJ3TwRGqzcN+GhtaHTAPBpx5vc1YHhbjYfjsuxYR4qE39UDtIgPyi?=
 =?us-ascii?Q?xcZ/y08UcUH0ekdMByc40ecQlkJDFdrc5hm3gNBs1AdAOjx4TfNVXyJ8dMcv?=
 =?us-ascii?Q?2yI6eOq6nXUNWZLtejDVuPt/89YMT/ULl/palAuNMp1DBWFsIvsyJ1KJrpzE?=
 =?us-ascii?Q?HOw7h+38Qb9KAiMYwAP1KPXQefvfsgylUutTPEYrpCAzX8d+RYEUyLHoNcPb?=
 =?us-ascii?Q?CD2yx6ZbO0wajPr6+DlCjMZSFNFVXkUs6xvtN4N8GI4PFribduBdGib7GMCy?=
 =?us-ascii?Q?HFDfeJBXBKFxONGaFS6RupIW32xanejDXH+NV04mMYbkvzwa2BSe7sulOBZN?=
 =?us-ascii?Q?C4XNKVcHkmon6UDRuNc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 00:58:56.1488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 545eaefe-e079-4bf3-efac-08de224fd277
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449

parse_cbm() require resource group mode and CLOSID to validate the capacity
bitmask (CBM). It is passed via struct rdtgroup in struct rdt_parse_data.

The io_alloc feature also uses CBMs to indicate which portions of cache are
allocated for I/O traffic. The CBMs are provided by user space and need to
be validated the same as CBMs provided for general (CPU) cache allocation.
parse_cbm() cannot be used as-is since io_alloc does not have rdtgroup
context.

Pass the resource group mode and CLOSID directly to parse_cbm() via struct
rdt_parse_data, instead of through the rdtgroup struct, to facilitate
calling parse_cbm() to verify the CBM of the io_alloc feature.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v12: No changes.

v11: No changes.

v10: Subject line change. Added Reviewed-by tag.

v9: Rephrase of changelog.
    Minor code syntax update.

v8: Rephrase of changelog.

v7: Rephrase of changelog.

v6: Changed the subject line to fs/resctrl.

v5: Resolved conflicts due to recent resctrl FS/ARCH code restructure.

v4: New patch to call parse_cbm() directly to avoid code duplication.
---
 fs/resctrl/ctrlmondata.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 1ac89b107e6f..c43bedea70d7 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -24,7 +24,8 @@
 #include "internal.h"
 
 struct rdt_parse_data {
-	struct rdtgroup		*rdtgrp;
+	u32			closid;
+	enum rdtgrp_mode	mode;
 	char			*buf;
 };
 
@@ -77,8 +78,8 @@ static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 		    struct rdt_ctrl_domain *d)
 {
 	struct resctrl_staged_config *cfg;
-	u32 closid = data->rdtgrp->closid;
 	struct rdt_resource *r = s->res;
+	u32 closid = data->closid;
 	u32 bw_val;
 
 	cfg = &d->staged_config[s->conf_type];
@@ -156,9 +157,10 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 		     struct rdt_ctrl_domain *d)
 {
-	struct rdtgroup *rdtgrp = data->rdtgrp;
+	enum rdtgrp_mode mode = data->mode;
 	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
+	u32 closid = data->closid;
 	u32 cbm_val;
 
 	cfg = &d->staged_config[s->conf_type];
@@ -171,7 +173,7 @@ static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	 * Cannot set up more than one pseudo-locked region in a cache
 	 * hierarchy.
 	 */
-	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
+	if (mode == RDT_MODE_PSEUDO_LOCKSETUP &&
 	    rdtgroup_pseudo_locked_in_hierarchy(d)) {
 		rdt_last_cmd_puts("Pseudo-locked region in hierarchy\n");
 		return -EINVAL;
@@ -180,8 +182,7 @@ static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	if (!cbm_validate(data->buf, &cbm_val, r))
 		return -EINVAL;
 
-	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
-	     rdtgrp->mode == RDT_MODE_SHAREABLE) &&
+	if ((mode == RDT_MODE_EXCLUSIVE || mode == RDT_MODE_SHAREABLE) &&
 	    rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {
 		rdt_last_cmd_puts("CBM overlaps with pseudo-locked region\n");
 		return -EINVAL;
@@ -191,14 +192,14 @@ static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	 * The CBM may not overlap with the CBM of another closid if
 	 * either is exclusive.
 	 */
-	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, true)) {
+	if (rdtgroup_cbm_overlaps(s, d, cbm_val, closid, true)) {
 		rdt_last_cmd_puts("Overlaps with exclusive group\n");
 		return -EINVAL;
 	}
 
-	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, false)) {
-		if (rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
-		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
+	if (rdtgroup_cbm_overlaps(s, d, cbm_val, closid, false)) {
+		if (mode == RDT_MODE_EXCLUSIVE ||
+		    mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 			rdt_last_cmd_puts("Overlaps with other group\n");
 			return -EINVAL;
 		}
@@ -262,7 +263,8 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		if (d->hdr.id == dom_id) {
 			data.buf = dom;
-			data.rdtgrp = rdtgrp;
+			data.closid = rdtgrp->closid;
+			data.mode = rdtgrp->mode;
 			if (parse_ctrlval(&data, s, d))
 				return -EINVAL;
 			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
-- 
2.34.1


