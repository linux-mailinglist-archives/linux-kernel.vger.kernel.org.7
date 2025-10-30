Return-Path: <linux-kernel+bounces-878778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED39BC216E4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 743D9346A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F969368F46;
	Thu, 30 Oct 2025 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EzV6Zf8n"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02636368F33;
	Thu, 30 Oct 2025 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844628; cv=fail; b=jjXn68FL28Fp43T9QRDHCBQ1hPRQdgY+3xRhT+FDJhMhNbBoEx0M+pgpV9S+/xdzRgt0sXQ+OodNv81YRlUvxEFeT5mmUaELw9AB+VlqvpMrabkFOqSAyN66vN6FyM37tk2sBYXRErs2nd6iYGh5B/Xk6sO9gdrPGviRkMBfYmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844628; c=relaxed/simple;
	bh=aDolMojF2eFkerRSnawDscierk3ze9yOqOJqdNVe38g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0OkV8p9++pFxePHWrTNaV+CnhIk9qBCcF2zUrnNIn01ZTYYd8pCOEY2VLSw6rff6zGcgW5EU223YZiFCPddvabY3qOTcGRFfsCXpR2at1D7ddtX4xjms7Nq6CvgiH9AogkHy+drYkJyKRdnViH/3mf9h/qilEmusfYLwH5Er3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EzV6Zf8n; arc=fail smtp.client-ip=52.101.62.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKWmDUgS97JHG2v4zkyeB2uVlbIizpc/9RWdB+Opm62ZTSqkQr7hpuIpRfX92sh0dsRye5C3n3ncn0uG/NlUEtxgF4Bk5xM8qxFHR0es9jz3ZlboTeJudk/wqFyn4FTpXY3b6LEMW33kWZiXkfw11JpP+TxSRf8SLsaaJocWiv9iuhV9jZK3s228PLtlbPnTN6TtIjTtfwL6WyaYaw6nRhmkrniupfoN0pQPtba033HUDlwZ7mam85EZKSP7kY8IJiy+164Z5dEhd6P2pERwla8FKWnLmmiHeGjDVKuF8LqI6Flu0xZutrT3asquY1jFFu38qWewc3U7zWI1O9a1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/Qh5tXa3YHbNRYpBfiCB3iVr63vUqdovB7yp8oCob4=;
 b=R0zv4kukTD6eThJxslhLABME8nke1c2qD/psr9YoeaBykWKnxTXEpZPknoFlI01vlJM5V6/ewa3mjCCffSjo/abe8Y5LxOq5zRJBztkMAPlYnOqRwZ6wjjwlV/hrRffLCDbwRWCHTrBi3LT5pvXB5mZNf+Tpv2iVZc71dY0RHJ8fGT48HVaKw5f2lnl3qnpn7+oxQijrvUlF1gDUuKugSIvflvwCvGsLwL4UrubZaMeDltWqq87aj9yLKUz6nZuDV5uPiMi5qdVeGUTTRje7wTWPcF4ps2aUdROxb0InOV61HsDnTsG8oSaR4/im8UZIScOB+drEoyEbv49T9QYtEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/Qh5tXa3YHbNRYpBfiCB3iVr63vUqdovB7yp8oCob4=;
 b=EzV6Zf8ngHiv6RJ4CoNkxH4oDPfjQGkXYPMQlLJqcacMazSCGwcT/vstGMk6NibmGBLMEXdvVK5Hbf80Z9KSrOfgo604Z/FXxjwW5p5GwJYTawcmlToX+kXiLVDI4ED5VidzWbQvgaZ6VnQFgIGTyz6Yyke3nxCqS37u6dYdKlY=
Received: from BLAPR05CA0039.namprd05.prod.outlook.com (2603:10b6:208:335::20)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 17:16:59 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::90) by BLAPR05CA0039.outlook.office365.com
 (2603:10b6:208:335::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.5 via Frontend Transport; Thu,
 30 Oct 2025 17:16:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 17:16:59 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 10:16:57 -0700
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
Subject: [PATCH v11 08/10] fs/resctrl: Modify struct rdt_parse_data to pass mode and CLOSID
Date: Thu, 30 Oct 2025 12:15:37 -0500
Message-ID: <72085972509ab4ee0bd2367fb1f4b6dfc869d05b.1761844489.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1761844489.git.babu.moger@amd.com>
References: <cover.1761844489.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a22b4e-7910-46d2-b762-08de17d8228f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nEDuLQInn927V7fwUetFvLMHXq0yj7dxhQwojsFJn29T4a6UeytCVssWB0pa?=
 =?us-ascii?Q?fidMTwR1ROKEjfg5JDaHAUMqj4BYJUSqf2yw8gjWp/wLS/v4C2bqOdn24rKw?=
 =?us-ascii?Q?nOY8h60gBkftuN9z9hSnmDc1OIWYzDNUsuOhbpMfffkH6vDJ0nqtLMSceNvM?=
 =?us-ascii?Q?JL0LOddnhFtjjUjvS4HR4PvMBTnYp+xCESjTTLtbW0kFj5RJ541nx6Jq3rFv?=
 =?us-ascii?Q?81wHK0cbMS9D8o6uiFoeZG43AMnomFBuIDEeoNfvflqWDXEao7DWahtuMD5v?=
 =?us-ascii?Q?bqmQwIGoCh0icv/ALPSY/dFmZ/ElDA/yqnRkHo9BF9NFsvlIOZ7bHnM/zc5i?=
 =?us-ascii?Q?5y4LKRiUgVGX1+j0hJ0onq0UB1YBNQBc/XcBPdbtvdN/sDzCJ8VIJ8v0VVp+?=
 =?us-ascii?Q?Pv2bOBhiW+6oBIOSN0yWD4N8vwUM4NLpIp8iygNYwoIM6Hk5amsTwp4ASlkY?=
 =?us-ascii?Q?4nCKLePgBYHE/wljF87XbAP+K0pitbp0w5YEh7mhM0nc5tOdpSxSpfDVcAfl?=
 =?us-ascii?Q?KiGYC2VHNiZYuEzoQFj8Fz3vh1DNG5wv5vxznmIVGMiQOGwJ5Z5y5iEw28Bo?=
 =?us-ascii?Q?zFQtxiRv0TKeRpUW+by1/pI8AR4a/DRoX/elMlSLMP+ZzuKNrewYkI+lxjGm?=
 =?us-ascii?Q?0W03GupDPhhabvMLtRp9dvcgyb7s/4OKcUFaElvqjcUD9l2ucRWR6wi6SFoB?=
 =?us-ascii?Q?gPdjrDxmAXNITHFcWM2r4h/HZfflORqrh5hnQrGt05ogJwCN+aJ2PhcZzhkd?=
 =?us-ascii?Q?T6iqYidZ9AwKSTZmW2ByewuKRZJzXlJxCKgr3v9vvlc+RY45mMaWG7IWX5rp?=
 =?us-ascii?Q?ud1Xh3//zLNMy4ASpnQg3X0KEw9zr4N3qyGpzTFsyPQu70zEyCbLN5IV834v?=
 =?us-ascii?Q?lod4WiPjrmPr9vZ3KHcKnSPzqlVWlqh55+tvlpMPHFZDvrmb5zbwWmVw9O4C?=
 =?us-ascii?Q?3gWffV7HJbUgJD2toTPKJxPblriGki8bOcRHiEc77K+TZ3lWXUOoHuNh4d/z?=
 =?us-ascii?Q?7CYRBDbgp0CsuV86fQsFkmt18hoRixU3s59s82ZN5mO8yZGx4GBxk8j4deKd?=
 =?us-ascii?Q?O7ed55nW6ctTs4HN8fs6mh4rXMD68bit1WthY5FrRhd0K4AOLURD02oN1EOu?=
 =?us-ascii?Q?WpTcGxlxdcAcS70W66h0HHHG1wMaewHcaO6Yj5CQkPApxjLgjkZXN19TC6yc?=
 =?us-ascii?Q?V08GvfqM63wAQnLlfmBKzlZ5wqW6UfcKjJ6xewi1/0upZpUgzIfsl5+h2apG?=
 =?us-ascii?Q?Ii9fQWkBM4lBWlVEfabBpMVFB+H5dJOmuNRfu3eDIsvq7Uk9XGGFvoqaHajN?=
 =?us-ascii?Q?xoTD3yPmPpvIetZjF0egTvLp07YfYu2Lh0zIm1ijEhWAaUPe2XZ9fE5csgQ+?=
 =?us-ascii?Q?1RcXmxH0EdUhFJUv/iYIOPk4lWKLCtaXM/N3rtZ3IV74tC5zyFYxaSEtAZwT?=
 =?us-ascii?Q?VfLBFYIEPG3W5A9qTCOC2WVSehbwc/woFEwb4j6XNDtVBRlG9Y2AnTvTc5HD?=
 =?us-ascii?Q?68p4Sh6LPLrausm+l+EvLfKqVfOZnjCByuC1d0HFZPCiYphrBp36hbNocr4I?=
 =?us-ascii?Q?JIBtKMLPZKaPfcaXFk8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:16:59.2966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a22b4e-7910-46d2-b762-08de17d8228f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155

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


