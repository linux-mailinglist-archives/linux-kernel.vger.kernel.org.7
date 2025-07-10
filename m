Return-Path: <linux-kernel+bounces-726226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A31CB009BF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB331BC81A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EF425B2FF;
	Thu, 10 Jul 2025 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0x9F3kAJ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4D42F0E29;
	Thu, 10 Jul 2025 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167878; cv=fail; b=HNZk/xlmNsMeCFmi6p/ZI5Qc4rP6jHXJXbRtDgXy1gI3QHGrc6KEMqsr1qQuCFTUjQy8n8zXjGqACEtPFiHUpZd9YArwvZtml3F9/TaFz0PFALvQOOPCnTKviwsixllAMFWbR6BpuWj4idG6NK3gXPo0d/omfgmkNAr3VSdmRns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167878; c=relaxed/simple;
	bh=fEcwk45JFtqQRINDWFLFJ+ovaazjRhOQA+8HFHyZal8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZe9LDQtGjSxQNjJFD2dfbYhSAup6KXyk1C6PyzrhdSe5gGfs0qeuceXCnKNLRdKkD64w0S/mvTXlyu1rBCR7fhRiF1LMieODuVebEY1wZoJs9vh59r91Ky1ShqJWF3UTzsVPWQC1DNUiw2q+jYu9NCyQdeQI1EMZ5JpH51mnro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0x9F3kAJ; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8jE5x34u3hnW32crZEn0o4VyjYZnMRGCWHkkBObwcm7GlSl9j1Z5939KUthdrX0pFzYcAGgxOYMUKtd/kBnSaUUBb+VuKnTr2cnbN8rfIHtUU4ivHakukDnDf2/8hj3+FNmlHPBJDc4pM9dKMVGHXSQ+rQnuKHEbehNEEXSl4+VVs2+b7oQPerSi08JXSXF2YXaifOOQNrxTajPAwY8/aLjVu4CELQbCqoszkMfabPIvAMTjBviqGypan2m/YpsC969mvbDo99QhkD/vmGhtNWdi3gSu+QjrIl9E9CiolYVJmCMiqJRG5hHHbd3/2ejrM0ON8x9wrVLxMWkdcYUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2WFa9QrcD3l21hhVJtfD2p++5zKYeVJiCNYfaHWTlw=;
 b=io2Z/qvfUaTjQ3x2wCUdml4/6Ttxx0ZT23uZ2NokTiJNJkBkIBYa+xcdLXw49SsDkap0rPFzJukRdHa0q/Rd+NJZ5g3cP2ADjm2v3VuFn/csEiZveUPx2yDqdUcD6xHNbmF1OtHhpj2+Zp5Pps+T/udXcLADYt2ybqcB56973A1qfWrl4Syg2hOEGKQqU39UCPA3d7DEnHrqc9yCc/PwJUZkscGhGcY6+6uv/P66eNPsv8p8xzALLjSpZjQxGuh7Idjx6YFnew7FFuS3j8Zi4B6fYPaqDKR2Wmd/ukvHPCZl+5OWpmUrYvTv9N9h2CcjM0MRjczjqoSzV2E9JNYPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2WFa9QrcD3l21hhVJtfD2p++5zKYeVJiCNYfaHWTlw=;
 b=0x9F3kAJtlaWCKHdpn0g6s90MRzrRcNz0UtMK/nWqlV/tP/j1UU2vZC0Xx5ZQW7x63+Il/GGkKwiG3DSOo1sfEakbbBTStcoXGAyej1hyjMQjxhL9GFmy0wDWkJ1ZnrjZ7TfheVDQdwQdCXfQJanxdkRrywkNQilFLZuBMXhI8s=
Received: from SJ0PR13CA0134.namprd13.prod.outlook.com (2603:10b6:a03:2c6::19)
 by SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 17:17:51 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::2d) by SJ0PR13CA0134.outlook.office365.com
 (2603:10b6:a03:2c6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.5 via Frontend Transport; Thu,
 10 Jul 2025 17:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 17:17:50 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 12:17:48 -0500
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
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 09/10] fs/resctrl: Modify rdt_parse_data to pass mode and CLOSID
Date: Thu, 10 Jul 2025 12:16:23 -0500
Message-ID: <f52c579262bbbc8bda4dbbb7341ad7bf0add0379.1752167718.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1752167718.git.babu.moger@amd.com>
References: <cover.1752167718.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: 193ffc1e-4562-4591-00cf-08ddbfd5b329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SiTNQrdLmV4gp0xiAxOMqCNBDPKeAHMH+5paB2xS/wiJDnVwz1czftNhv65b?=
 =?us-ascii?Q?e5XyS4izqZGgyKoCr1tKbVG2/px92sh8Q/sT/pV2uiKqnFgQ/RYelkFYKPZL?=
 =?us-ascii?Q?r0VzIVeM76ZY8omS2YWHipG7YUq6jBlUQHenwkA4TMG5Yo2B/ye1xjimzyid?=
 =?us-ascii?Q?A2VD3Ch6FKTtZxaXoIrAmCgieFDFX8z8OqKSG2WQjCzq6cykTs1FapHh6O6t?=
 =?us-ascii?Q?Ifkn7PvBEbykQxeUv2DwSgS1k3H9IQ61T9/cZ35gkSAuLlT66nExqGijKsCa?=
 =?us-ascii?Q?qz/oGkJQ+5ddEfSBgip7RdejyvLm77g9Mh1JLlinGCjEgbFD54qwoCAxkjJF?=
 =?us-ascii?Q?+LL6VDS1UQV5g/2QRsbxBIcOVM9ZYoSTXLczqwNLIk4UDma/5nTcuVaDADwH?=
 =?us-ascii?Q?z55sxARq0NgAh8IcVDayfLsJyWSkwJxymVEp1AZnwSo/Z7h5ySxtmDQc1NCT?=
 =?us-ascii?Q?CKLsAF5haueQ6Sn6FlhGWdjJbuGRviE5S/qy5rhXsWMBpsArhE2mHie7+o2i?=
 =?us-ascii?Q?BjEQzaa6OX10MoECD8tuTckIhhB8sReYshF+I0JMAWSsEsyNFDXi74WJlLhK?=
 =?us-ascii?Q?nMZf8fqIgfWRQ3TOgrzCF04p4ru6Hk28XzLESbITX4nNMCHfK+9S8ya/w8LH?=
 =?us-ascii?Q?2Qqm7ZWGPtk/iMoy1zz0ZUIHbo4z2SbAQq7vwoXN3K7N+rHW5qfoKcUGYpzT?=
 =?us-ascii?Q?P/ezXbQCjCUPonJRgsRxA1wO9F2zsVPrnA3l5vAqRzSEMBYkZvJHnUXtEPkn?=
 =?us-ascii?Q?A8EnO6ai8fk3X+LUHVzxjIg2iVfDwu0yI8VDZKRFemvmh9IEyxcbLtAR8DbB?=
 =?us-ascii?Q?/jy0nmqYdLnQtQ047EV+KCQz+ZnjC791twOew7aA2EYYGvYq5ZDK2ZxNd13V?=
 =?us-ascii?Q?v6idEE+6o7/9TPon3Xux9r+7YrtmIyBtkrXcjLb43cb4V5EclgrgjcyBOyOo?=
 =?us-ascii?Q?cbkGFv1M9QZnZXg6Ep/9oGxEgQpQskd2vMeB1mjODtRJMJrsLwb4fGGB3+r9?=
 =?us-ascii?Q?oON+lO0WUmkENyXahdS5mB85shvVpOPxzvD29UtawiFIwElZQmSGEzfrNHWi?=
 =?us-ascii?Q?TaJA0WAcuDVA94OrysYQA0kAQXO4b+CO5sUwt5T7rV8g7vMKKAvolIZu5iE8?=
 =?us-ascii?Q?5SyUNAaieD9bSCcx5+WF6/00AsoAkWZMzmRaW7F3+bQIAd7TS8/dcGO7kjqz?=
 =?us-ascii?Q?WMEFJzjBLJBIylmfN6ZYf0sc/r+bwBHVr8NUKdMw9dNEwHKfHaogII3SI1d4?=
 =?us-ascii?Q?HTg+JpQwvGIVZJR3aGzSI/y9b/XwB83asdsyG0vIyLraccjdalSmFB4V/KZ5?=
 =?us-ascii?Q?BTCIM1T+OzpLrdpTmnnjj2ikrlo2oj1aEfhya8UkfDWodlw7bMYe7lQBqxA1?=
 =?us-ascii?Q?P9m6IVitTxn2w2wAfFHXvfKRGsFWaC8N07gJ7vew95jJLVkKyyDZEq5Cpr9w?=
 =?us-ascii?Q?kN16kpB8hOXz2uD/I2NoCEELILoK6lgAM1qjvuUByMrMahygvJaJTB5P1Zqm?=
 =?us-ascii?Q?5Lr4L1YqumkkbugUyZ9UpYaXYYCDrNr9foX9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:17:50.9938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 193ffc1e-4562-4591-00cf-08ddbfd5b329
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880

The functions parse_cbm() and parse_bw() require mode and CLOSID to
validate the Capacity Bit Mask (CBM). It is passed through struct
rdtgroup in rdt_parse_data.

This can be simplified by passing the mode and closid directly, instead of
through the rdtgroup struct. Doing so also facilitates calling parse_cbm()
to verify the CBM within the io_alloc feature, since io_alloc does not
have rdtgroup context.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v7: Rephrase of changelog.

v6: Changed the subject line to fs/resctrl.

v5: Resolved conflicts due to recent resctrl FS/ARCH code restructure.

v4: New patch to call parse_cbm() directly to avoid code duplication.
---
 fs/resctrl/ctrlmondata.c | 29 +++++++++++++----------------
 fs/resctrl/internal.h    |  6 ++++++
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index e78828b0408a..5c16557fb7a8 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -23,11 +23,6 @@
 
 #include "internal.h"
 
-struct rdt_parse_data {
-	struct rdtgroup		*rdtgrp;
-	char			*buf;
-};
-
 typedef int (ctrlval_parser_t)(struct rdt_parse_data *data,
 			       struct resctrl_schema *s,
 			       struct rdt_ctrl_domain *d);
@@ -77,8 +72,8 @@ static int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 		    struct rdt_ctrl_domain *d)
 {
 	struct resctrl_staged_config *cfg;
-	u32 closid = data->rdtgrp->closid;
 	struct rdt_resource *r = s->res;
+	u32 closid = data->closid;
 	u32 bw_val;
 
 	cfg = &d->staged_config[s->conf_type];
@@ -156,9 +151,10 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
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
@@ -171,7 +167,7 @@ static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	 * Cannot set up more than one pseudo-locked region in a cache
 	 * hierarchy.
 	 */
-	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
+	if (mode == RDT_MODE_PSEUDO_LOCKSETUP &&
 	    rdtgroup_pseudo_locked_in_hierarchy(d)) {
 		rdt_last_cmd_puts("Pseudo-locked region in hierarchy\n");
 		return -EINVAL;
@@ -180,9 +176,9 @@ static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	if (!cbm_validate(data->buf, &cbm_val, r))
 		return -EINVAL;
 
-	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
-	     rdtgrp->mode == RDT_MODE_SHAREABLE) &&
-	    rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {
+	if ((mode == RDT_MODE_EXCLUSIVE ||
+	     mode == RDT_MODE_SHAREABLE) &&
+	     rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {
 		rdt_last_cmd_puts("CBM overlaps with pseudo-locked region\n");
 		return -EINVAL;
 	}
@@ -191,14 +187,14 @@ static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
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
@@ -262,7 +258,8 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		if (d->hdr.id == dom_id) {
 			data.buf = dom;
-			data.rdtgrp = rdtgrp;
+			data.closid = rdtgrp->closid;
+			data.mode = rdtgrp->mode;
 			if (parse_ctrlval(&data, s, d))
 				return -EINVAL;
 			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 3d4a3d7696d0..ab76a1e2e679 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -201,6 +201,12 @@ struct rdtgroup {
 	struct pseudo_lock_region	*plr;
 };
 
+struct rdt_parse_data {
+	u32			closid;
+	enum rdtgrp_mode	mode;
+	char			*buf;
+};
+
 /* rdtgroup.flags */
 #define	RDT_DELETED		1
 
-- 
2.34.1


