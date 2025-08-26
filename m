Return-Path: <linux-kernel+bounces-785970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDF1B35307
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A221B25333
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483A4215077;
	Tue, 26 Aug 2025 05:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QkFiqtSt"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F28BA92E;
	Tue, 26 Aug 2025 05:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185140; cv=fail; b=hCIBP3sg02ezstxbWvBukyrzeTwrtEV8kxcKgLcoUa3DLD7pPJy8bambPsOhb0LWzmR23DEed8O4GWOLU2intVgUo3bpzV/EES/h3psswZJYldv+2fcUdNXYdqTNc5r1tl3sN/g2HuY5C/oc3V62Qng7WpaEpHaR4kaspa4UaAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185140; c=relaxed/simple;
	bh=1ksHutykAyCAs3ZIxz8+aGwFZ5EHhlZ7Mcm8WTeuMyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8V7GCpPEqVTJWwjbnE5Yyme+pKESgTbTN7eEtN4jYmhOJ7lGJasDTxn25CKZB36Es9W0vZetfxy/n8SLB/eELsKKvlEbbHj1fkwW4sbYVL+b4RjR/9HF/tk5KoZwJl3jEwJR4crARO9VpxreiRldrJqhIiJhsTImOPpTYQ7PC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QkFiqtSt; arc=fail smtp.client-ip=40.107.212.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akYhKClVSe+LBo4YTkD572OAF4ke6LsDEAAtUSGEjRtmp5rJpY7+ujFca8Tz7nFuBU2biUYAs0roS4siYxbk9RNqOnjjg6A9oaSVG7AhflDBxdBgnOiCZoDY+G0tbmSW1j6zTQ44t97WB5tgpRmh0i2G+6tHCTJgSf9M0tH3BGusy+7/28OZi0Z3QKvqsFBEnli6jVf7XuNZjWqcXa+8/LSPz0fqMCttuwuVy5kEn5CbHGLDloEZ8xhiuqaGuXZ6AqCNy3ShgMdplOPNj4b0XtoehxTMlcbwuQnaXtKecmUc9Sruaq9v+CoZsgnSLNXmuIW7prJ1yD1/8dLe56bm8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmfPCxHr4SSdqLB7mMRioZTXfR7oOdb555GIlHj+bgA=;
 b=Gt7JSjTuFLi0JWlispSenvj5vFuiqTHqoC1IGVa5gd1UqA+HAjG2nIgbaK/wLCiEaXC2Gbkw7EW9A3SMr7ijR5kf/vpOiFHpuQbt6+EOYxmBwVLXByPdOIPHxFfFAp5TfzGgVGLZKgZzaDzNv+aHXeyCL1QKrD0wsvN0xg1dpxFJ2VSTMEpEkujXKDUIqvqYi0/ZtbO9AGFAHuwnP8LMpeEZswt5ooveC1+Y9pooQV3TvW0631XGogL90nhYb53dfFxrHto9qEy1/gqi6FBxfkYDmDDDydG6UecTzMyPAMeZAUQBDcZ/BsbGsjaFBY2b/BLwAnCpYAualqRgqTvctA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmfPCxHr4SSdqLB7mMRioZTXfR7oOdb555GIlHj+bgA=;
 b=QkFiqtStC8Xe+FO0QHFyeioz8gm4piyxpDYHsl3U8UksZlopAvxl2Drob6zeOT9373fkGK9iOT7vlatuZ3OqCp9sz6FpcImM0bkYwTRANopn55NwwwQzLLOjZ+NHnh7QhUmvhANPASMdnwaiD1WZ0QqMbNErJtwnSj02NEUvW7s=
Received: from BYAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:a02:a8::40)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Tue, 26 Aug
 2025 05:12:13 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::d5) by BYAPR03CA0027.outlook.office365.com
 (2603:10b6:a02:a8::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Tue,
 26 Aug 2025 05:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 05:12:12 +0000
Received: from tapi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:11:59 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <corbet@lwn.net>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <iamjoonsoo.kim@lge.com>,
	<qyousef@layalina.io>, <sshegde@linux.ibm.com>, <alexs@kernel.org>,
	<lukasz.luba@arm.com>, <cpru@amazon.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v4 02/11] tools/lib: Add list_is_first()
Date: Tue, 26 Aug 2025 05:10:30 +0000
Message-ID: <20250826051039.2626894-3-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826051039.2626894-1-swapnil.sapkal@amd.com>
References: <20250826051039.2626894-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd7e52d-8946-465a-23ab-08dde45f1d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ligVK4jlJH86Z783nnKYVrv1zV5elnJvAm9ess+k3Wk0T7deFV4zLY3VNYU?=
 =?us-ascii?Q?GQf2QEC8voC5p9nVHM/VX65HlokQauQs5Of7JmiYdqCilEGhZGsbuVChCEGn?=
 =?us-ascii?Q?1UVKUm51sqZyJveAfegGRAYfLAw/1bJjeUYECpE+xtz+e+tGlcCauSxiIJbY?=
 =?us-ascii?Q?mKwIaRyPqjhSDw7IlLbivBpuW58b/IRmxFFXMXaqriRy6pledXUGNtAF+n8Q?=
 =?us-ascii?Q?W7EURUwx+PRcmNMGHhyzbH9VXpCJqZEuYWW4P4cRQ2S8z+6V1chRzW4umiLj?=
 =?us-ascii?Q?QwASvaX6whq/evGc6cmDlOIFQEDUsZxyAvpcVWhZs1YEBXW90W/kLkYoSbFi?=
 =?us-ascii?Q?pwDePXiSpGZAVDx4sm9mKl2Kr8Liel3kLeMzFB/CEsMlM/X1ETR/U5U4xxi+?=
 =?us-ascii?Q?MweKo2QB5ZwYcpEU4PS70+YWJPATEdImKGfSmvs39U8Ar66e8nFfk3+FO7yR?=
 =?us-ascii?Q?KvmLThIHcc6Qw7Qtikh9+6YrLIbfpFVAj2vzC9N9LNxYddetJb/B/jPYY7Uc?=
 =?us-ascii?Q?MlQ6E3HNekhC2Wh5Wa8sB//oLdSZ+ocRnoTgoY7lcWWwFwev0osWInwMXUD/?=
 =?us-ascii?Q?vi4JjRWRTxHsmugUJx11LA3XtaBCZzsSeX+Y6XxfR76EErzv+ws2/KZ/71/b?=
 =?us-ascii?Q?rbBfQh5UMTlzOPF1TZXA8PFB4xoEswPHE/wTmPSuiVA4StZh5p8u1fjU+ELq?=
 =?us-ascii?Q?Ad4GpC1gEaSLsba6S0sesHpPgiKDz1TRUnt6B/EGEQisY6K4yZ6edjqE/lat?=
 =?us-ascii?Q?4lHOhVWvoyzjnJXS8obv2vDmNVzXxSaHd516y9dqzG2+Z/nlW+n2rTv7OQvG?=
 =?us-ascii?Q?fGPwMJuT35qr3HTBb/pszl2n5Yw3+Oue2J3IFLzK0Iyy4ixVbkcIE32bIJp3?=
 =?us-ascii?Q?vtU1/QnP3jU20/AghfZafcy7ssuaBT8jqfzQCneBBrxzANO6Ick+iT6gqn71?=
 =?us-ascii?Q?6C5oO5UXF+srfjOMc+HSbZP9H/rPA30zIDyu5dCuWDkICa0ozt4+5bp1BaSB?=
 =?us-ascii?Q?D795LFCA5jUTmOuee5gwqRlY5R68olPDdWFYFbADuyHqmuOpjwQ56dqUVUnW?=
 =?us-ascii?Q?FgzaJGIvPZXCnD3cX41msCDQdzZH6+drFaInqHLsPYYBXkwQfynssUs/wLSW?=
 =?us-ascii?Q?Un8HkLDHvRs7u956VJ9WcQ+YSz/4Wqrgx2WG6m6h4oFjRekoSJAgBSbg2r66?=
 =?us-ascii?Q?i6jS0sL35FCOjP58WicQtKwwOCNt8Zt5mT6IX+m+BzpilVj3Knyd1mEWxwVd?=
 =?us-ascii?Q?Y3Y9mVqIaoK1ALceZZi0ZcLPdg2wEZuDTkJX/9+BawrXaIDpKAK5kHcYA3vm?=
 =?us-ascii?Q?bEPWVZzz3FAAYvD0UQrxQs4Gxtt76nvgaNeZvoul6KBPzUw1+Fp/7HL7IksB?=
 =?us-ascii?Q?7MybZFAsSbiTYfWsZxZp/OM8uKyjQ02Zak6y0oxXXb038uHX4AvcRrd8Qn3P?=
 =?us-ascii?Q?X8BQTfF3O6wVfivmFGUBwvkEtsZB78ig8Yzr6OcljHU1L68W4CoTsR1SfhOM?=
 =?us-ascii?Q?Zy6srk/RztmNjpIg9lXukhRRwpHLGCpX62mU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:12:12.3489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd7e52d-8946-465a-23ab-08dde45f1d86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106

Add list_is_first() to check whether @list is the first entry in list @head

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/include/linux/list.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/include/linux/list.h b/tools/include/linux/list.h
index a4dfb6a7cc6a..a692ff7aed5c 100644
--- a/tools/include/linux/list.h
+++ b/tools/include/linux/list.h
@@ -169,6 +169,16 @@ static inline void list_move_tail(struct list_head *list,
 	list_add_tail(list, head);
 }
 
+/**
+ * list_is_first -- tests whether @list is the first entry in list @head
+ * @list: the entry to test
+ * @head: the head of the list
+ */
+static inline int list_is_first(const struct list_head *list, const struct list_head *head)
+{
+	return list->prev == head;
+}
+
 /**
  * list_is_last - tests whether @list is the last entry in list @head
  * @list: the entry to test
-- 
2.43.0


