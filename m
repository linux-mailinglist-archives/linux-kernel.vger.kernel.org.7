Return-Path: <linux-kernel+bounces-757074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E96FB1BD60
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1B6720C92
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AF3246BBB;
	Tue,  5 Aug 2025 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZNtmX4T5"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439B51E51EF;
	Tue,  5 Aug 2025 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436736; cv=fail; b=EoYo0+c0P//4dAVUY885amSUTeCbeshkEeX68ZYoG7B1oMXcyNwG7gI5mheW1hbwFtls8df9zqE2TiVrgelhe6rFM8qWxYDllhaF5mKC0CGiZokdIGY/H3kObOpD5MSqKRe/ovUUur/3pxFG7GIHoMtCyuS/fydFHhwSsbTzuGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436736; c=relaxed/simple;
	bh=IzVlft0HNJO2HyvmK5sbBcL1rfl/RLeQrHECZndcSn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbA318vNf/TGBwqz5WjUJoykocBhei6YpPohQjIei/TizeaDYCp0YvPfMukVTvLPw5PVMb46SSRcKEj79IlrmiY4WGH787gUjQ9EGz/ZJJ+gPhio56sJMA9Swe3/A8JTWPltNlb/o+Sfg2nuhW7T9RLQpO983+tL5hznEPU2Tu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZNtmX4T5; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQfo10s9QUyMiQceG1g+dCFJMZloIq5dK+ODjFPB1IuE7Cmf15crGuNzvOQdsP7rfR2milZwG1m5rDec2wduhNV9/vLWda5cBeOBkUq6eqb9jcxFtk27MC9b6jhPlnKuZvpO2ah8QEHIVN2s4lAByO/AfPtpKne1bcZ9dL51qvar7sFfVSOPWCMXt+ji4aTpR7Jq2UZT/Qkvjh+2bSfu8e3mRBTDPBaDmi+x9tEs/npw1Ybs7vlhm4rGWSRhDnIGlKAgsdI96pNMGVyrJuTjlpjode0TEcC+Or7gaOIJHrTgomIfFdqUjpT+k9SMsVN64K0fIMtWeiS41vVS1QEyLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fni/x8EdjoMJxGL3Vq6xmY1pVwDTzeON79XH66mwLOA=;
 b=uf8fwa/0RZ35hxIznzqGisj5hwvOCiWsDQ6cFPVe4cv/+jPMs34BLM7RykePxbQ+/vVXS4kJC4u6iQl3FKnePBVkn58gYEoGztXYHBAmiKoz9r1iy0EldFf4BXploT2+G9A3DdO+8/BALZtk3R3RuuT0hJkwr7iiSGpZsUtTAWne4iVPH36yEvOqBRzvMC0YBIvrTLYbVkhsOTwH8EPpih8+H6AogYTiLgm3NAG2cSe6xc4fy16uuOBCI/0s70P0I33+ldikizn1GvczXKItcon8aq+PP3NsnVwcTEe7Y39ktkqdS2yeFkwuSCG4y3VwoxK8F1KVfk4AyfN3dPHh3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fni/x8EdjoMJxGL3Vq6xmY1pVwDTzeON79XH66mwLOA=;
 b=ZNtmX4T5QTI6VhCD2GG4u2nn62uOTpWZAw5eDL+jwXnm4z+YaR4fsPjlR4xbXlc3UONy17tNeleCmZfusbXX2et5pVEZgw6xY5OzSxfhNv/cZ76TsFL9soEZX6/CVD330J4+dq3NHMD6We7aQglfH8V8czj3uq88L3Wf35tq/Fs=
Received: from SA1PR02CA0008.namprd02.prod.outlook.com (2603:10b6:806:2cf::13)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 5 Aug
 2025 23:32:11 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::53) by SA1PR02CA0008.outlook.office365.com
 (2603:10b6:806:2cf::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Tue,
 5 Aug 2025 23:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 23:32:10 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 18:32:04 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <tony.luck@intel.com>, <reinette.chatre@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<babu.moger@amd.com>, <yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>,
	<xin@zytor.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <me@mixaill.net>, <mario.limonciello@amd.com>,
	<xin3.li@intel.com>, <ebiggers@google.com>, <ak@linux.intel.com>,
	<chang.seok.bae@intel.com>, <andrew.cooper3@citrix.com>,
	<perry.yuan@amd.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <manali.shukla@amd.com>,
	<gautham.shenoy@amd.com>
Subject: [PATCH v8 08/10] fs/resctrl: Modify rdt_parse_data to pass mode and CLOSID
Date: Tue, 5 Aug 2025 18:30:28 -0500
Message-ID: <330b69d50c0161b7ac61986447a9867db7221f93.1754436586.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1754436586.git.babu.moger@amd.com>
References: <cover.1754436586.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: a8dca1b7-5fe1-41ae-a4f6-08ddd4784c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3THXXbcpyZOHFV07aK7haYjJ7ZQC6/jKPYvmcXsTdeE2FqatDt0Do6X+xNWo?=
 =?us-ascii?Q?YHIBi4J1hHt1Dc5MWR4S9gEDP3nNUpb7uMHj1AAdoZzDx1ZXcXTRl78Z3d8m?=
 =?us-ascii?Q?G6dispkDcHIMYIGmWzjVU8pKhi2oEnioGTT029WO144Q1umUvkZBiNUR/HQt?=
 =?us-ascii?Q?d9U+WFLyumClEEK7COa6j5nfJ6r0pnbvGJnpOoG9jKpOtsNO0fBbtt0fMaGX?=
 =?us-ascii?Q?CK3nat96i/xICuIJzdlLmZiyGU40tC/VbENRobkQ+SMKg5tYDKcUnMk6xzJK?=
 =?us-ascii?Q?K9VDjHp+YxCWU+sGODloe1uK4h9NlvNa78IOXOBo0LYILuCE89IwESYFoNhC?=
 =?us-ascii?Q?IIML/5XMZWleZ3E1jtj8oilfm+6gn4V+Yxp07Gsth3roR+I3As+BYQqesUOl?=
 =?us-ascii?Q?kKxtbhIRNJIE5WLAzkCkcAe9gNZnC8STgfQRLxSwkmd4t3Qav1J/SEKV2Lda?=
 =?us-ascii?Q?2QYGbYg8mhNTu6JlRGYeK/ZtiY96tQmZb7RDOrBo0OH2i6rfetqCSZHwc7LT?=
 =?us-ascii?Q?XO1CeSbcxAHYNcAwpOt5mnqh1VRLtmZkf0uJlhnF96/aCvy9OMMbb6bwhDrZ?=
 =?us-ascii?Q?1mwomNP3805uH14GldhK33a+lwUjQlcVoVoZ2u1VMxLqm83087a7pm5EmDOr?=
 =?us-ascii?Q?n/6RIkDIrNS+QecyPRYtzl999KyHRp0Gmw6INnbTS28HRYVyh9TgWyJSlCjA?=
 =?us-ascii?Q?4FkoIGJ81LbfHIoTdinBmV79PmrztpF8e0sIo9qbyMKZcu1mlnly9nLjOcjQ?=
 =?us-ascii?Q?lfQUFyW4tQi3KrtrIb+qpDo4FgDskApAhEM9S1WBT+y7wVYa403lZj/xSqvv?=
 =?us-ascii?Q?AEbaUtu7bSCFhAt1cAh0348HGM/W5iOm8WXYUh2Twj+FIDSGWLdYugEhow/w?=
 =?us-ascii?Q?69wYbLV7mvowJZsWrPV+UL4cHfEamTRdLZOa3XM51eIbPKGEM3fX+Hto5YJk?=
 =?us-ascii?Q?0JLRPOkuIn5eUWN/L4IwAZRzLvsn94P2Y79mQfcGK/suEh4k5xrQi/QrjehC?=
 =?us-ascii?Q?G0XkJsqvdEBRpUIL75zBUvfI+tjoSkzLYSWQg3UlYQZ9p9C7xSPUAUuW2+uj?=
 =?us-ascii?Q?NrXVg/jjXzkR9Bst3JSOMZSwbzBt9f5fvTwi1c6DTiLw2SjxvjCWdyfJcz8d?=
 =?us-ascii?Q?08Cr6m9KqJNp2UWwG43fQaERcJvmCJiWnxqaBhYWskMaNFQcfGFW/A/SwLDm?=
 =?us-ascii?Q?aimq+KbzUWCn3j0axvRawilzcfGecjQtqg+zqX8W3vwEz438gqgMcln2B5yf?=
 =?us-ascii?Q?+JM0khy7NnDE7UxkcMkdwAu86vY8uWsaIwHpmsIDtAmyQXHbgwWq3eXVzBjq?=
 =?us-ascii?Q?K5ZOBU/KB9izg63rO7Ca9Ev4IDVH2Yec2KTcSlp3MaMw7HWjswKFXIIFzvMA?=
 =?us-ascii?Q?Nh2RhBL3AYEL3tZ9LiHMJGI3WueaEmOFG9hceAs5HS1EMLOZ1hCBdRjvD6O8?=
 =?us-ascii?Q?2aPv4ll6uQ0BEm0+fgiqRvVmDFXnoL0T5h9foOYeARge7f9Y6SK71IaDFScC?=
 =?us-ascii?Q?OjODMMhvukyk2gjEM/eSmW9qD/oU0Eo86WaY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 23:32:10.0738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dca1b7-5fe1-41ae-a4f6-08ddd4784c85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373

parse_cbm() and parse_bw() require mode and CLOSID to validate the Capacity
Bit Mask (CBM). It is passed via struct rdtgroup in struct rdt_parse_data.

The io_alloc feature also uses CBMs to indicate which portions of cache are
allocated for I/O traffic. The CBMs are provided by user space and need to
be validated the same as CBMs provided for general (CPU) cache allocation.
parse_cbm() cannot be used as-is since io_alloc does not have rdtgroup
context.

Pass the mode and CLOSID directly to parse_cbm() via struct rdt_parse_data
instead of through the rdtgroup struct to facilitate calling parse_cbm() to
verify the CBM of the io_alloc feature.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v8: Rephrase of changelog.

v7: Rephrase of changelog.

v6: Changed the subject line to fs/resctrl.

v5: Resolved conflicts due to recent resctrl FS/ARCH code restructure.

v4: New patch to call parse_cbm() directly to avoid code duplication.
---
 fs/resctrl/ctrlmondata.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index edb9dd131eed..641094aac322 100644
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
@@ -180,8 +182,8 @@ static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	if (!cbm_validate(data->buf, &cbm_val, r))
 		return -EINVAL;
 
-	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
-	     rdtgrp->mode == RDT_MODE_SHAREABLE) &&
+	if ((mode == RDT_MODE_EXCLUSIVE ||
+	     mode == RDT_MODE_SHAREABLE) &&
 	    rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {
 		rdt_last_cmd_puts("CBM overlaps with pseudo-locked region\n");
 		return -EINVAL;
@@ -191,14 +193,14 @@ static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
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
@@ -262,7 +264,8 @@ static int parse_line(char *line, struct resctrl_schema *s,
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


