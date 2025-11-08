Return-Path: <linux-kernel+bounces-891544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D58C42E39
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 15:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24DA74E5BEC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 14:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6921F4188;
	Sat,  8 Nov 2025 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QZ74cWAz"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A39E14A8E;
	Sat,  8 Nov 2025 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762611845; cv=fail; b=CJ7bZn8mwbv13OZJHYtrmAZmocO2LYGNQ58Xz0e0QmlEiaPXa4Gqs5SKAsPEmlqo6OhKW086GtKvWCubfn95Sc15G15HvlGLtcuiqCHd3C5sgXDUtYLfzy87mzCkXayP5BXCxkQT9g1jjvkzkxIQRRKYK+TKNaq0E2b0uBgMIt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762611845; c=relaxed/simple;
	bh=6/c5tl3zkfVfQfdpwJkWKRfqdEBqTducFQU8f5keih4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZNsLwlzPfZ4J3tgGATtxtJ5uMqKiYleg1uDnccS8kCZOge2jd00/QiGI423cHYO4Of3oG7fES7R/SK1Ut2U1cxeR4Jg5go3gAdfO9TXROznbbgdK17EaXU4Z6H876UslrhAm+kv2m33cCfO/hikcT3E8TwglsdehVY+ZhBbRuxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QZ74cWAz; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lffbNaq3emi1fELbdoEgjDYraU8xb7Mix0Ou4MTj+sqNfOv0Oa6DKSh7y9mB7Iux3D9wq5XZve4NwfsJdUg9WAxWYYqkTEq0D0XdoIex2RZmMy8naowYvmsdH3Sr/9XwJLroROuqAgG0dnvNCI745xlKeSDLhscHeRNYk/si4jFFwkrY41QngRECQgqOCg9MMyGYBoqhWeIgmGVwWy4CNJSWTbbSNejtbJsxlWgLnwK/MbIcDzflLhSxRrfY5bTEaMMrdHHlxkdSsOQiFfEdAlJiXXSjxpHjwQtEAZLWtK+TXP18l0NfwpNijGoL/qvlLX2AIoJ4zO5HmRnhFNqL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VleNa4wSVod11xLvTiRfZuVhqyGxVx7VUD8PuFtmbw8=;
 b=oOajSWdLSldoqVcdtm54AoBl2NrbmLJqyV75PPli2O3Ot1h/279JTx4GsLKMhmtlPoP6xjFDnGSTXwTlgiUg5vF8g1eQ0clu5QFhdnAuIqUu3NWfGGB+lXmkOhAhmYb+9Ijuf/DK91BtLPNliw/0/ayuUNtQ6s+O0mPzKX1aH5T4gtK4OM/xaP5xHvzME0Eq+T/cuhvTxaEGofdiGRAt/JzXjqdYZ8mfAmII1WcKE9DRsxXLAkXV5NGJptYgtkPatrKr70z29fC78pzdTVsYr9FulrWfBSffT4EbmC7gUMd78a3wOf0Jz8sW0821w44d4WIxx+zRG0MGQF5kG17aeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VleNa4wSVod11xLvTiRfZuVhqyGxVx7VUD8PuFtmbw8=;
 b=QZ74cWAzpvrXFePzERS3cjIlsHOA/RvQA8Y/y0/hfrfhL8/3EwhJpiuSUUJXtH0NACoIshY0yWMLD3SEUG+y4Lfv6Rx8tSpCNIi8ln0H2j0/abEi9U8L8y4ATVVR9Q7e7Xa4JRNEUTj6lHdaPi/yIKjdBSkYMp2pwa1K0Ij241U=
Received: from BYAPR07CA0068.namprd07.prod.outlook.com (2603:10b6:a03:60::45)
 by CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sat, 8 Nov
 2025 14:23:59 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::1c) by BYAPR07CA0068.outlook.office365.com
 (2603:10b6:a03:60::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Sat,
 8 Nov 2025 14:23:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sat, 8 Nov 2025 14:23:58 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 8 Nov
 2025 08:23:57 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 8 Nov
 2025 08:23:56 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 8 Nov 2025 08:23:56 -0600
Received: from lelvem-mr05.itg.ti.com ([10.250.165.138])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A8ENn8M547304;
	Sat, 8 Nov 2025 08:23:50 -0600
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
	<lgirdwood@gmail.com>, <perex@perex.cz>, <shenghao-ding@ti.com>,
	<navada@ti.com>, <13916275206@139.com>, <v-hampiholi@ti.com>, <v-po@ti.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liam.r.girdwood@intel.com>, <yung-chuan.liao@linux.intel.com>,
	<baojun.xu@ti.com>, <broonie@kernel.org>, <antheas.dk@gmail.com>,
	<stuart.a.hayhurst@gmail.com>, <dan.carpenter@linaro.org>
Subject: [PATCH v1] ALSA: hda/tas2781: Add new quirk for HP new projects
Date: Sat, 8 Nov 2025 22:23:25 +0800
Message-ID: <20251108142325.2563-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|CO1PR10MB4531:EE_
X-MS-Office365-Filtering-Correlation-Id: ad115628-6961-4889-7bff-08de1ed274b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZdRkr+NtgofIH+if8Jj6f8634I57oA12Y+BTl927zh3NzKxOP/Qc1KhBqNCl?=
 =?us-ascii?Q?YLS+u2WxaxYSdnB9vf49l2wNNogMpQIrg1ryOsbqBzbOO0UvKHh82oNEo+iJ?=
 =?us-ascii?Q?XSeHq5l8n0JcQ9Goa9mSl0fGQe1DYbsmYi3TyocKPD/CYdc7VlpjZgYk1RgX?=
 =?us-ascii?Q?FAkQr9mDC1ggONURspn7ZgR9VfKqRYbqAtIjAyNy6UwxySn6gC+1NQcYMJ1M?=
 =?us-ascii?Q?SGAhGgxqBMQm2s5xEQ+VMMtOhCFK+lMAPKLB7Ha6lqlOhq0MfFLhtJLyax79?=
 =?us-ascii?Q?p1LvInK8EEL+JXGvi8AD4Q0QUsXNm2kFCFDCZd4rvlb4wPUIYkmeObUvX0zc?=
 =?us-ascii?Q?uXb5wKr6Mf1ECHX8GEYn6eSNsjpVGRPrBTYN7XAs2IhDneXB4k6Hn0FRGSr7?=
 =?us-ascii?Q?z/438LeeB03EGHGnyIuN/MzBpJ/gTxTpMTrE4p8KwBR24CFcLNESp3Rcda8b?=
 =?us-ascii?Q?NitZXDENKPqY+guJYFD1Kf10REAkF6s7lf6mFghopUB69j2ClkbhkENYwFQR?=
 =?us-ascii?Q?PsG+J64QCQckVfjX+eSkqJophn2jlYBVeYFVxS6VqjYP8Kx/Vkb3UTnZHsbL?=
 =?us-ascii?Q?SyO7wAXA3G5itSqbFUa1LwLMEuUNp4TFiApFRt0FwELI1XVDCCmrR4sOegZ6?=
 =?us-ascii?Q?H0V9PJi165BlOnrDF7IaZPo1n+mLVVXhmmaCcErpjobPlEmqlum/FCD6HLnX?=
 =?us-ascii?Q?0NSoHydPemVeJXqbpHhRcPY/ZtUdPQD1LgkgfvEJrL25HITipOeZOh6GSCDU?=
 =?us-ascii?Q?WSU7V+2GQsJliesRVTv9LRqPiSrUvsv6aokPewJBb4M992o9Yy9hmmHhzfLG?=
 =?us-ascii?Q?svunqYh5DSV1WvFE8MLOLiAmQZmK866GnuPzjk6kC9vkBtCptjNJe5Psb4PC?=
 =?us-ascii?Q?DjVFE7ff5nCnzYsktWPHiHfteRT5pDEC0TL2xaBkuWWDgiYUp0EgucTXjg7e?=
 =?us-ascii?Q?+D4bfRmDAyU0+64M77np2JZ7oEHrSlG+HRx0T7+IkH93Qml4Fj0V6zWF/aTr?=
 =?us-ascii?Q?b5LJW6PXrr3qBneNZzrK2NT5g9CMLoHutgPWq4tQ1NOU8SGzJ8dGeQgCgqi/?=
 =?us-ascii?Q?Zbx61fLlnCqe6SJKZ9WlkG4PiPh8bjR1r1fSkRikB8dHKC7CWWFr5+FcWcjR?=
 =?us-ascii?Q?VGw11oIfXQAK7U66LkL2YDEhwN7HXg4d/tsp4F5DiiFdjgJUn/v5+zmbKKV8?=
 =?us-ascii?Q?CH0P4LZflU9BHvGyImos1Mr9afQdtCwIcHcjJYi+28OWX8Fiyyi90ktXQt2v?=
 =?us-ascii?Q?V9DBhj13tf8vjaXIlnzabF13NlWUdWcXd7JALhnE8BSSQwkU+fVRdTyfmipY?=
 =?us-ascii?Q?5n8demM37JSvno42fsFlWewG9/CEtVpynwdQqrKCFppr8rC05aIWng1wfi6c?=
 =?us-ascii?Q?/ntre+poODY/4Xwd4rw2TnNgxXmIT4+eezCE3fkEQ+Qn8sdrDT3GbUNc5Ahu?=
 =?us-ascii?Q?RLPeZ0oKKrQcb6pMHB97pd8Dnemico8qDvf0Ue3rddnTs0cOylNEedbolUzO?=
 =?us-ascii?Q?IeeSM3CyHQnVhY1oQnZSARXqypxIrKFRYN2/WcdRX1y4uuCaP31RMeFibEqL?=
 =?us-ascii?Q?NlMf/fIltjC67phdFRA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 14:23:58.2056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad115628-6961-4889-7bff-08de1ed274b4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4531

Add new vendor_id and subsystem_id in quirk for HP new projects.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 sound/hda/codecs/realtek/alc269.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 4aec5067c59d..a9698bf26887 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6694,6 +6694,15 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8e60, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e61, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e62, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8ed5, "HP Merino13X", ALC245_FIXUP_TAS2781_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8ed6, "HP Merino13", ALC245_FIXUP_TAS2781_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8ed7, "HP Merino14", ALC245_FIXUP_TAS2781_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8ed8, "HP Merino16", ALC245_FIXUP_TAS2781_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8ed9, "HP Merino14W", ALC245_FIXUP_TAS2781_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8eda, "HP Merino16W", ALC245_FIXUP_TAS2781_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8f40, "HP Lampas14", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x103c, 0x8f41, "HP Lampas16", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x103c, 0x8f42, "HP LampasW14", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x1032, "ASUS VivoBook X513EA", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1034, "ASUS GU605C", ALC285_FIXUP_ASUS_GU605_SPI_SPEAKER2_TO_DAC1),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
-- 
2.25.1


