Return-Path: <linux-kernel+bounces-863889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 227F4BF96B0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A22445087DB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726B52ED17C;
	Tue, 21 Oct 2025 23:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HOncEZi1"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1BC2E7637;
	Tue, 21 Oct 2025 23:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761091004; cv=fail; b=eh4l8vAJZTnaJ+of5xXYRaiuWYayBvzc9uJajB+bKClzIP0RlG3UigUaerVi450KX2WOzRn+8Gu8J6+PUc+aikQ9vQ/cJOguyWH/Sy8ZKkQyoy7TTNngsl+Cv7fIAYXqUrRpEjp4QjzLqWEVy/cgWjQAz0ZhmnjogVCjTCHEjJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761091004; c=relaxed/simple;
	bh=lct4U/Nz3hW1ybi/k3izq3YcZJSl3yZn7w5ukcL9OU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AR4VmWmk823kFczDTAzKL5g+wJ7BoTrD5Xs8Lat3PHEHgldPZ4rGXtmlG2YqEIA99nsqt1NRpa7Tb/T/RjZM5hMBKmXglb0PKaPJOUYjTF6LwvAUPg+pkUDZSOFJxGqPgUDD+01F7/us/W942O53I/8rr8LPZmau4ubbwP9GqsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HOncEZi1; arc=fail smtp.client-ip=52.101.48.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7cmXZyg1uubDAUvkmQed/oS7BImLsQ6xrV6ZxEAPEvmEx3z/cL++nKsJVwLAkSj2Cnrquwla/UmCXJ1U36ipCXnkfl8NVEjdxnkrm9P9x/wLb0hEyEUGtDcpazTjnai2vASIf514mLeQli0x/2l8ZG3bbhoPuiT6lu/hWYRCKexZ2x2Tvqk+4U+wAMLQhiS1eZpevnCo4ugGRJxmfs53wGXxpioOXNYKjDuYsGDMIWxY53KypmbAhWryaZEjwZ5bd7XRLgpi/s5YxfKcRx3zr0svKqMkm5HQznELOfuIUXgkWYYY0BYu0TUWd9Bot+7AQTtVeDMpkxsQ6R0N1HZKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPuVxZUCgLyGL6zJbxIEvN5aSbwuJXoYe7bBeVO+8ec=;
 b=cuxgc457hN1lJ4z/rn1cJzLYcBFFStu218g0ZIcL8OiuWT3UIPr2gUlOs+9x2K2Mg6RWYa6MkC6V9TAZtqPlA5PlzQTdIsveoQlttXxOx6r+5nhC2MlafFufk4Yc39P5UeDq+2lTbDJFF6Rm7nOfwYPkrO1g32FFYUABuQDiF0b8CuBupfucCMAfXnGkQ3T0Oe751sslhi6QFbTzBwfwXTxstyMC9vflj7beL+O2nJ3PpsbYniPYx6YiVmHnsR4/yKptef1XPhQ/0l6zLl2h8NGGBGx4k5m5GeNGDTmj7vtwNR+QkxXmmNOV2xBnqZx2jzzyfXYiAkcs9SgHnryjIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPuVxZUCgLyGL6zJbxIEvN5aSbwuJXoYe7bBeVO+8ec=;
 b=HOncEZi1SXfQrbU4wujrAnkEQ/sPKEhnl0GfMqur+rvgeBCerOytzCohswUciK3+V3HQlah0sBCarjNMlAWaGb8t5VvDhMQsasGmpewuFO5pNs0BUFd4cJkLZpgWWkBIOLVAHXaR2XF0qFAzRVq+IfTLN6mA2dO/Z8uO9pH4xhE=
Received: from BL0PR02CA0041.namprd02.prod.outlook.com (2603:10b6:207:3d::18)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 23:56:37 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::be) by BL0PR02CA0041.outlook.office365.com
 (2603:10b6:207:3d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Tue,
 21 Oct 2025 23:56:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 23:56:37 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Oct
 2025 16:56:35 -0700
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
	<peternewman@google.com>
Subject: [PATCH v10 08/10] fs/resctrl: Modify struct rdt_parse_data to pass mode and CLOSID
Date: Tue, 21 Oct 2025 18:54:51 -0500
Message-ID: <cb2f1cd20744db1f3f5e5c2f2327d1b80f0143bf.1761090860.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1761090859.git.babu.moger@amd.com>
References: <cover.1761090859.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: f2fdbf3a-42de-4fe0-7972-08de10fd78e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/yKKsFzpEuGMr19+AwABv/Ue52UjSm6n0yFIb9sCejr0hT1SDgVeTWoYnRlo?=
 =?us-ascii?Q?6ODxDGNlNUiP0+Ax9QBgwUp37HQA0z1y9zhZvSP8ZyCo12TKnnjXtZ6fJ0qN?=
 =?us-ascii?Q?XNvsB82HsMT4/LrxN+pCeVz+Ojm9dEoJ7VhWByVE7TNzIUBH1zJOx86spqpv?=
 =?us-ascii?Q?E6L+uTaGHwDksUDk7JbQw/5z0zHaXqe04IqX1XtUAPfR9Xtop3+Np8xh6Mah?=
 =?us-ascii?Q?D66NesBDzlq/4vJPVaMrGs9dHDc+luXpICiSLN/tE5r/RoyY0v8IImS4xGNK?=
 =?us-ascii?Q?x5eRw9yXU+qvee2osmkpiuQLfdfUjCt1eoPlh/bmkFe/OCXqQiETrx4hUme5?=
 =?us-ascii?Q?uH7Oxc5lw7ZqpFNjyALm3voSqVjLAGWMBWdL9ciWWkpQ4OsIrlFEOScYQHj7?=
 =?us-ascii?Q?7gKoDxAba6Xtm7KZ2Z1OVRVGGLC6EUPjE0Vd7j0ivzCqGlTGSTQaGuW8sPZc?=
 =?us-ascii?Q?A2xt51KwhNhLLFVsDTi0EcW9GwUzHbUWlUeFhMCfVyikeB/Q0/uaYa+szhce?=
 =?us-ascii?Q?TGd8k/d3YpCjcF5icFjE0IGQ6tOmMv5Gy50Xpzib2na/7k+HZogjFJhyUb+T?=
 =?us-ascii?Q?m043q/qpnpsboTLf1Y92P3NSY2xqtL//y2ZHNCrzDPZVJ/IqnA8/dcteosQz?=
 =?us-ascii?Q?jRKfCXkFqWlYMoMtz99e8cz2mq9dlzm5knH5xaCD/Pjk3pYn/ZHxNOCxI756?=
 =?us-ascii?Q?P07w4qeZfhtKe18YdqFY3pq3axI0An6pB7/2q/xCuRzP8c5UWJdWVNi/TEUa?=
 =?us-ascii?Q?Faxj/zmXb98zFbvq1uf+AAPEViNzh56d65yGxQUrpQlwyWfLJG6JS+IrJlG9?=
 =?us-ascii?Q?Z1JFad5aLf4es2jBb5E3c0lC5K0UX4An2+6F86kQ2EbDDJoN7Lu3OvEtJLn/?=
 =?us-ascii?Q?9dgKfHdA5vKSTlZ0f14cgcJLoch5mYnoGPlcxZcVAe1T208sxnK36Gfusc5W?=
 =?us-ascii?Q?7V+HK6FWmuKwC9jxPVXnJ2acbvCXq9LFZwmjEtevNwbc2yrWLLdnLaQSHAsA?=
 =?us-ascii?Q?3fRerpOZ9lzlJpm6iWrGa7NcpBQAkXjol+/PmUbB3n+lEU6sTvlM09ZertU1?=
 =?us-ascii?Q?C+O5mP7eQ8ZlvX+iEfhL/smgbJ8jBYbzjXc34TyxX2rN/WludEvvWPE2LpYn?=
 =?us-ascii?Q?uBSm2azYzZzRpzCRvta9fshSstINIcHNYhdNkzgYwG4w7JnUm2Qp8SrJ7kmi?=
 =?us-ascii?Q?oTDT7qey8TT54YuiFX3uOcGgLhBbxteEcD0dTp6rZLzYis79eDRygA/+ShyX?=
 =?us-ascii?Q?9uPDJ7y3aF48tm4MKnaA7kcA64zpsMJGIDAjjTLKOmrKJONRJW6wMU5CViam?=
 =?us-ascii?Q?Ns/qqI+MZrBjjxrJGI+OPJunnZGBp0hPO0tzEvwt2M5N+zkzOlUIWKSqU/de?=
 =?us-ascii?Q?wfSUEkawnm2uYf7y2Sv+yjcjt43cqYfowr+DHl3s7ilD90y2NXzsLFOI+wD9?=
 =?us-ascii?Q?vPvFyObYdXzCu3INVfhr3IGEjAYIJbgQp6tICudWsHPkOEVvxdtm9FFtwptP?=
 =?us-ascii?Q?6JCWltjMinDv4lxJvBDt1zSHYdsZq5XfcODPSFjC3z7h/+GBTtPBy+/ZcHC+?=
 =?us-ascii?Q?M6ZVq/C1N1nC2BxSuvw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 23:56:37.4084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fdbf3a-42de-4fe0-7972-08de10fd78e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218

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
index b4cfa55aa9f3..813e298c48d8 100644
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


