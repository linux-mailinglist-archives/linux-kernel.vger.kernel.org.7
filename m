Return-Path: <linux-kernel+bounces-888788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D40E9C3BEB3
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0010E1B2688C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C716333C532;
	Thu,  6 Nov 2025 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IMEaU9gE";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="AgdpYilK"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3602531326A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440855; cv=fail; b=pFX/VyWSpGT4Ywi9Xsc+69t7Dvr9E0kKnlHYzf/v9bIQHbmU1FjJA5iBD3eyjvBcQmH0eeskU9hmxjVV3DmsAK1sjyGAgi8kUkQDWreBYE9T90o0MzDQHIs9wvFxCP8cdH/mg31ZBGk5CKkrER8E0xe4RJ61otJ5ZijfrdE6eR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440855; c=relaxed/simple;
	bh=oAQ6E8ny0BtpSwk3m6z+cbQHN3Lo4RD/H0qJWWpvkZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fcnclonwUStwnv7G7FA0v6FiAPDMvoBkK2Fl4zlAhXf78D0DXIcphudXvX6EM66C7o/HDUattOxtAvvfoobLB56nnLENlmVz0+iSYF7Y3UtW6qwX3Ls/xUolQMDjDgQd1BBNwtq6q3BeySedkmdh0TGtIUhLNAZpPfX2OenZAc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=IMEaU9gE; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=AgdpYilK; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6ElWKK1095908;
	Thu, 6 Nov 2025 08:54:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=eSZYPycs0gI2AUKa
	pA7bkyhGGgbHGbnkBhdHLkZfJgE=; b=IMEaU9gEvzM8Ftgs19i3sYF1zwD2qRWc
	gMWgEBw/uVODKdwgUTYYg+iKDTC9ONIogOS9wjEO+F2sXTgGLaKCoI9ZamqQMJVt
	uymFzHox0DJSI8ipjJtMMhupBkBwtOFi4PRuj8xJ4Q1ssSzoZVTu69O1HDBkQaLX
	qyfjyFqQhcXNAs9ONx8THy2gSFG+g57agt49DpY+Smkdwmqs8VUmtAsMtNIQijZr
	+XuCY8N9bnCFLf5afrhZTmM8tpMScbhGVWD5IPplJHfPC2jqmjH6jtzOQ/khVva+
	wcazepLAjtZRe1jZogJeh55xHOV5xNL9AzaxOAhAqn4/GUzBR+3jWw==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11021080.outbound.protection.outlook.com [52.101.62.80])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4a8wre00ew-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 08:54:10 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llmcQVU1hyamVqecvvMSMNWIZGJnTWggQtqjykhbuOSK53s89QE/GG762rOmU+EmBxSJ1idzXb+fWZ4MDWny0vTtzzA5My6d2/RcVaDrfQPBI9VqQH2COLJKgVnvv2Hkh4D9vPQ+PVYnVCFDau1dmQj5sI5t1ZVMP2U2wmRCUOM2JBRToFQeDaudiA/BIjzlVZOnGpfnnrcjqcdRdAWXDSRnxAaun0GYzZNer1b67CykRIwOT/J1TZNXjkfmeIwowrLCKMopXdkKAfggPi2HYZlkHb9x+ZNKYgXk5itVc/UZk8CZi0+I6qylrvq8sLmJ1a3uBMURSW9NQGV7OQm6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSZYPycs0gI2AUKapA7bkyhGGgbHGbnkBhdHLkZfJgE=;
 b=i1pooi+HuEBEsFAaZRH5zMbZVcMNM2DHthmMXJDlIgYjBVoVNvj5HpHWEx8LdN5ptJNp9eths9i0dhd3ZMo4uLBvTAXbJjZYQxS2QlAKpd6kpBQD67YwN4JkbzaWuvIbE9Qq+5u8JO4IH8Lia1ME11PinzdEQN9peuD+n+K5agIO/MqyVMa/6G9SG2hHEl4oSlcJ21R7hNuA9AU6Yxvk5iwNPvURhP+MBozTsneYlJDsDkCj66OPmYy7TpXf/bybkxjV/SH8w21aaNUNxyEkzPDtLclCBs6zBm6iXpZC/prEIJ4XKvBFIWBEl2lr0mZnjRGg7m23RAMvYh5Ef/b2Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSZYPycs0gI2AUKapA7bkyhGGgbHGbnkBhdHLkZfJgE=;
 b=AgdpYilKxHXn+RQ4Z2wFvfO2GIS3vfVyAJsNs79bKqTQwDiaegek4O+Vk2ANx/2iVfsmBLCjC3T9wgBw37QcKxz3KgwFhXrioKRKTNZt794K2X2RS1a8ItFjIohfNwbzJ2nhURR6+9g8sQ8rn3ONOlIbzKOpEoXgGC4jll4lmKc=
Received: from MW3PR05CA0008.namprd05.prod.outlook.com (2603:10b6:303:2b::13)
 by LV5PR19MB9155.namprd19.prod.outlook.com (2603:10b6:408:2b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 14:54:08 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:303:2b:cafe::9a) by MW3PR05CA0008.outlook.office365.com
 (2603:10b6:303:2b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Thu, 6
 Nov 2025 14:54:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.6
 via Frontend Transport; Thu, 6 Nov 2025 14:54:07 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id ECBB1406540;
	Thu,  6 Nov 2025 14:54:05 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C34EA820257;
	Thu,  6 Nov 2025 14:54:05 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: [PATCH] regmap: sdw-mbq: Reorder regmap_mbq_context struct for better packing
Date: Thu,  6 Nov 2025 14:54:02 +0000
Message-ID: <20251106145402.1077903-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|LV5PR19MB9155:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 53ea147e-666e-4692-e00d-08de1d445669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?85mjSgZ5JoA4QVJ5GQnRO1oX4fehxgM4JzfFXdNNoSfaYrIIQ09PKqN/RrVj?=
 =?us-ascii?Q?KZ7JmkNyMsY5TEJ6yWYM3KDUnuVO9Cgsj4bFqJ865/zqroTzpCMNzraYbgbQ?=
 =?us-ascii?Q?A7gZeBANa/nBbAN5fG4UwfxYnEhuSi28lPr9jcAoyzLIuXKaFOJ3BCwzQGI7?=
 =?us-ascii?Q?rr2sfYgcqRYpzA1adAPrIJMM01QKSnm5Y7u/DB8HmHndSiliYEMcFOdFSfNN?=
 =?us-ascii?Q?gz238CDi0w8KP7yZm4x1eQo9tC3+KS2NhrfSslXZrgYWHRItyjTm6RloWzbs?=
 =?us-ascii?Q?Y9asuuO0SZssV4ErW2J0hLrEjwtoVh46BO/QHtjR2FDFaSUqrfAJkxdIM7d8?=
 =?us-ascii?Q?sNtxhjDSH9ZOkXdKiTCkMURbRdj63vivx6psVb+IFaqhxmcaMSYo/tn9Blcy?=
 =?us-ascii?Q?evPtH1CFiIhcbJorv+2uxhWbF5IOA5MzjEstlXWilEkQJG0PWAnM7YCzvWgR?=
 =?us-ascii?Q?ciiv4bSPWR81Q9QVAX3Ni0nyeb/usR1TOWA6pXe4HLY51BVjB1Qt1/x3A9g4?=
 =?us-ascii?Q?yXbhtFwLVogncs3zJr7+d/U6mGbkvms19auUHXRcL6+SyyUeKnKrVyIFo6Hq?=
 =?us-ascii?Q?3XdDF8MMoOprbh7V0iPrFC0NZlHitrwOmodgTAnPjU2IM76tlfss5Lt+Z1gz?=
 =?us-ascii?Q?ySIVvZCRNpcdRtDq8eoyu2mx3poOqnOUhSkOpThZfMWQXBNQM6c4tHU9iCig?=
 =?us-ascii?Q?0vUTbUq6xIW40jW62HJUjT4PTBYn2EUDfYbTsyUigJvAY0GF3BcDiP2KTirs?=
 =?us-ascii?Q?n1myTQUszDlS60r0RB1JlSdeiLVI7MY0yeEvtF+MHHe7tpQlQKG9m1WTCbiJ?=
 =?us-ascii?Q?mUd4Cl9C01WHEJfonUeCObK6j3YxnUUW/xmE6znRTRnhJeaWntnRfk7k7stH?=
 =?us-ascii?Q?wkL73iiVLoTotseZj5VLltcnihldgcaYO1+d3qVghsC1bYhW+QiXONLy0NKF?=
 =?us-ascii?Q?a3tzqFWlKOD+ygWLnvjH9//FbkCfNdFq2swj/orxMS3ceHOZMDVz96FF8a3N?=
 =?us-ascii?Q?r5a0AVPXiQCWZ53pwYfGLr1gGMMTFfhlqokM6ct3L3lHvyggdrWb8ZeC2WTE?=
 =?us-ascii?Q?3KY5RDpbYSkA4h/iKtEvGZ7B2819uJHqMadBPdHeRPJXm9OyDpV71Lod8VWc?=
 =?us-ascii?Q?auXe6eIDHVAAqpPFJDwhap/mNs0DV/Dvhdcg1tE+5jQVFu6OlZdtndmBCWcs?=
 =?us-ascii?Q?rFEMVrC3ORvE3wmjx3aJ97pXTL0bcCxu5xeSIAMGELGlPb040By2m1V0PwNn?=
 =?us-ascii?Q?HD3nXXjSncLpPXEGha9Q8X/DUQLuha2HJvim2sY0aX4M0rRA5uqpTaueIJ7F?=
 =?us-ascii?Q?Bcm+rh+Hx08b7GtFxbqSY4u5GevxROX9bPLVhzdVgtpEI1w0Xnu+M2kuj+4r?=
 =?us-ascii?Q?NH8B+NdbEQbIXLvg31x9QSGHtjqZmEwGJRh5ktd1mNjkOkpvyI1MhfY3sPiI?=
 =?us-ascii?Q?9a9ikNqe9GSLvpa9paxWuSAdDbdMh1gvH2T5m97Bu8CRQ5Tn87GYB9+zQwhb?=
 =?us-ascii?Q?4coFXALByIvV9jAEsmgB5as6ouR+XYGUwAM3J006Sbb4J8oXOnwgXJOmUN1e?=
 =?us-ascii?Q?oC65/Lm8/12RlAOw1pA=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 14:54:07.4548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ea147e-666e-4692-e00d-08de1d445669
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR19MB9155
X-Proofpoint-GUID: EHU_xTMUwhSLITuR-6EgMBn55bW2xQA0
X-Authority-Analysis: v=2.4 cv=CIwnnBrD c=1 sm=1 tr=0 ts=690cb692 cx=c_pps
 a=rDyEm/81vvKQCy/iKDMZrQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=XizkbrLwjgilIa8vboAA:9
X-Proofpoint-ORIG-GUID: EHU_xTMUwhSLITuR-6EgMBn55bW2xQA0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDExOCBTYWx0ZWRfX4uvYJ5DRM/Gy
 YL30DbYaps64i6Pna5wPxjJ6S74yfJwgFlDgSEceNUGRk97nm46FexAI76+XvcLK+lVM/ZN7dV/
 6IxF86Uhbh6dO+x5ODgM+Zev7d27ZKnD07KqwvzqDp0rQW+SU1sjqSHA7S+lO0ZAnrR/76XSx2P
 BHOxkoYjIj7tdmgyWaRRJhTyNLeu3wgysuUbxRgzOF438RZHspHaYhvfWNmISdv1qmf7KBKbiOD
 gN7OTJKCQxjfYl/3WPi0t6pIWJSqS1o9JebxMrNKT8w8utWxX9aYNYv1ynIVweklr/IcpKVrdAy
 puLcH4YHWTGAUZKNy7HmHZIj79UOcWrGPk02JuEsjEFQQI9lGIlJEhktv2Tmc+2D6cfSsG2FG3t
 VqP124NJ5lWacUqqUGO7KWzY5FxZ2Q==
X-Proofpoint-Spam-Reason: safe

Reduce the packing by reordering the regmap_mbq_context structure.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-sdw-mbq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-sdw-mbq.c b/drivers/base/regmap/regmap-sdw-mbq.c
index 86644bbd07100..225c158d7f9d7 100644
--- a/drivers/base/regmap/regmap-sdw-mbq.c
+++ b/drivers/base/regmap/regmap-sdw-mbq.c
@@ -16,10 +16,11 @@
 struct regmap_mbq_context {
 	struct device *dev;
 
+	bool (*readable_reg)(struct device *dev, unsigned int reg);
+
 	struct regmap_sdw_mbq_cfg cfg;
 
 	int val_size;
-	bool (*readable_reg)(struct device *dev, unsigned int reg);
 };
 
 static int regmap_sdw_mbq_size(struct regmap_mbq_context *ctx, unsigned int reg)
-- 
2.47.3


