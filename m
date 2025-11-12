Return-Path: <linux-kernel+bounces-897150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CBBC5229D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45E964F4C72
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363943164BC;
	Wed, 12 Nov 2025 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ShNaGBsk"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013069.outbound.protection.outlook.com [40.93.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A95C315D45;
	Wed, 12 Nov 2025 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948549; cv=fail; b=Tne4wmykBOC6IH/gtbYbmL1Jq43q814M9lBD/Aj1T9d9wqcA3vioDfSvpZRrz35NJ4ZdG+xcJq0GUF32sJPv7S2RGnx7BFzvIPlBGtYx8cMR9j1Z8NygjV96n9LDQnVwrJ0qNr6a1vqT59fr9ITB9lj2QKKpDF+zKVivYSikzyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948549; c=relaxed/simple;
	bh=4rBwKidSbn9blA+n5wuerKp3imV0bTVzcWPaBuglL20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h8Bilr12JWO/Ye08xPg1zyo8xoyiAV53FCVgMGb1bia6LPOxXHaovAsvhkd+1Ix1dwqyq3yxqvP0JSBCQ0AIJWgb9vHYWQE0UiVllVWKbSBBaXvLrrt1wDO7H1+MKVvh+IBoMTCyrMuLMcEq6XRtJiNzjqM0hXCxHHmOJJ0JrWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ShNaGBsk; arc=fail smtp.client-ip=40.93.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=joZhleOGtM9KOu8cXufPr52IK2FE/y74h3aDTEicTizqFnjjaR/iEHibzZsE6JodbbE2CXhAhpyXwgd7Qg2ur4hEq3T9k7upEOhh2gZ0wP4RmjYuDEec0PqsK+d/tdmh0xG76MoO/848GmVi9ZIP6RvTuAloFEJJJjor+SjkpehiIWlghEsasHBKJ2sgchbl0gwuJNJsjHbB2Ayl2lo/a9OydLyaCP0N9WWBzdSzkYqe+YxNLydrb/Vtbz2mb2IbcTL3OOP4PE66f0jQjQnOGRB3rP2QWsfX4fP1pIL0QebUchG309IKzsmo5ignHjHwxH4Tz/n13EQ5jhx+dTB0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyVyCVqgCQoXvGXC4P8xhVLXQaOeR+l2SevswnZsEgA=;
 b=mzXZ1A++fFt7PhdaiJLw/qD1VV0Wqv3vi5a1RO6y/izW1fubH7rPu6ba7EeC+olt+NFPtD+DBFR2vLgqaHBrPrBgpUrP5aXXIXN2hDDRf53aL9iIkr6NrI9iM5SP2AW6IUq62CfgkeyVD/ntENdXbVFNkMTPRRyswehtiOg7zj9joQvYxQ/oWHwKqAplqHRclqq9EVKMSC7iyeCs0ueWHD8E4K6xRspZ/DYGOGTYzTjJ9xIxTjh31qPVDzwXIe3BPbGlReGfYDjd51VOUBsYNFux3YwqpJyRQShptwAwRntNkQlEbXT4OiuaC9ziqL8eng6Sur6/qL6vs6i92HRwYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyVyCVqgCQoXvGXC4P8xhVLXQaOeR+l2SevswnZsEgA=;
 b=ShNaGBskLvg7oW8ar2gXdheT4rjpOcC+wBQqQnLAj2LWB/I7ruGwhdlGFZ0cDb0ol+/cPsH/wqUVNloaUiR/edbHUr5tdl/05dyfGNxQWq1gW36+AU2YzyYWkIfo2aIjVphYBV0orMvVgbstQf1GWUMSZN3XMpmDrEeRsMu85yE=
Received: from BY5PR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:1d0::28)
 by SJ1PR10MB5905.namprd10.prod.outlook.com (2603:10b6:a03:48c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 11:55:44 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::1e) by BY5PR04CA0018.outlook.office365.com
 (2603:10b6:a03:1d0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 11:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:55:43 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:55:40 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:55:40 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:55:40 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxbt2638977;
	Wed, 12 Nov 2025 05:55:33 -0600
From: Rishikesh Donadkar <r-donadkar@ti.com>
To: <jai.luthra@linux.dev>, <laurent.pinchart@ideasonboard.com>,
	<mripard@kernel.org>
CC: <r-donadkar@ti.com>, <y-abhilashchandra@ti.com>, <devarsht@ti.com>,
	<s-jain1@ti.com>, <vigneshr@ti.com>, <mchehab@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <p.zabel@pengutronix.de>, <conor+dt@kernel.org>,
	<sakari.ailus@linux.intel.com>, <hverkuil-cisco@xs4all.nl>,
	<tomi.valkeinen@ideasonboard.com>, <jai.luthra@ideasonboard.com>,
	<changhuang.liang@starfivetech.com>, <jack.zhu@starfivetech.com>,
	<sjoerd@collabora.com>, <dan.carpenter@linaro.org>,
	<hverkuil+cisco@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v8 05/18] media: ti: j721e-csi2rx: allocate DMA channel based on context index
Date: Wed, 12 Nov 2025 17:24:46 +0530
Message-ID: <20251112115459.2479225-6-r-donadkar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112115459.2479225-1-r-donadkar@ti.com>
References: <20251112115459.2479225-1-r-donadkar@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|SJ1PR10MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: f3c20b81-690d-418c-21fe-08de21e26871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UFztSly3HVb8C0XdQGT88KM5BQrvztdxGdNXTuynOucem0adVHfE5vs7xgMH?=
 =?us-ascii?Q?DP/KU77cRroejTt1IkKpG961DWo9vVJVrPUUmV4xITpKkWmKNEq2v3tLuWA2?=
 =?us-ascii?Q?qjBhID3IjmovhSkfdAfkZF/SQMAlkphwVMikKYlPyyyQbZb+pmQD5E85QX1O?=
 =?us-ascii?Q?rH4CW4aS3S+sm3JahmzaVpqaot8wqjaxgLVuqp9heOVMx1pYaMPUX2n6eatQ?=
 =?us-ascii?Q?DxsXDLisln5ZPB3+dMQc98DTnEb256OJQPmcJ8HBi6rMbI8XRi7zqTauKVaI?=
 =?us-ascii?Q?seYkx+nfOGXDksAze6l2eIr7qplTPHHVr26vsFXoO9DL+HqiWl35LTuRRd80?=
 =?us-ascii?Q?0yF+T/WRBJltuqHVarHCt4gRRIfy9Ch4WLkV5yenh/IL6wasV69ebPOOgMqL?=
 =?us-ascii?Q?RS9g8xGZby2SPlnM1aQp0nW/2sidLLNdzM6dH+8p1/8rsJbCG7RosZQQRsHX?=
 =?us-ascii?Q?beKIhtmyn5+0rRBpR0x/oFj64fJVe8cwHEv5Va1rlW210l5FT46xdlJuCCEi?=
 =?us-ascii?Q?5MIL+6BfivBi4y1UTiMHyBruA2YaAn3+FXxkRgqFMj/WvE1ojL2CBg+I3vzr?=
 =?us-ascii?Q?JRK9ckq4xEQLIfF0fpLVUo3kuvZNbec/lXzf+ZccrjRrInj7qQ0MHmXpHKYd?=
 =?us-ascii?Q?dSVLRxB9Zug2m9e2b2cIpKmA5tzbsTt6zF1CvkX8LuQYCuuMl+VQRk3JueIK?=
 =?us-ascii?Q?skdUk8o2sJyh1LDvwENLF9DcrwPghCPYlvculcTf0zXgBIIEVcjqs121sMlK?=
 =?us-ascii?Q?IfqZxdG+CtdFRSfXUFcODD2be/7fB5SUVmeGy/gjk137G6I2HDMyQSOp4eqj?=
 =?us-ascii?Q?2vyF1xw0H76SPXJNC18GEdiQZDlnY4NrvoEE+ZIb/F87wg65/4+IsZS3Rwhv?=
 =?us-ascii?Q?gUSZMYMTAzz80L4RVCmosQtrmeK6NozlzKCORN7G4G/A+wNe9/pDpreJmqI6?=
 =?us-ascii?Q?aN86/kv8wXC6bG2xmV5IWJ4RLcjUmYSO3p5HrK+xSEZL4gWfaic6FXNixexx?=
 =?us-ascii?Q?LrQUJz8xr9MDSkEH+OOsaz3VKKf55M6csASifxbu4AHw9qVdZu5eaAa/TlWs?=
 =?us-ascii?Q?C69TbPAwhdZgka0zUDV8ndlWbdESC31vjCaMS2P3TFzbogK1swRMFO7dh+jp?=
 =?us-ascii?Q?rAIXaHqI+1HYapKX03Xea7zvpBV2bQELFtE6SGhcxWB43mkmaDPDh7ETlXWd?=
 =?us-ascii?Q?3aqgd7J7ASOQK0MFu1j1r9OSVCFLl9QPFpVzczZIwR1v8oV+3yI/DOM6fJsr?=
 =?us-ascii?Q?LWPYnW5EjBLP98xxnah5jX7VnILYl+yyg1D4RMiwxvVYwK/zW24gXfE3seU3?=
 =?us-ascii?Q?Edi45s037BQR/PvSlCn97bl7wKm+dPdCgj8NsMtaePb3bgy/2cjyhrEoR50o?=
 =?us-ascii?Q?J1kNndO2kPQqCiVfDUmWiKX+OQaWvBKNTsBtf3eejzN9Se24fb3MUHtrJvCZ?=
 =?us-ascii?Q?6PCnzoutbMm3k5yh9zgMB8ucap55FYttelbVsBWPTXYdfUTG/hcMus9uIF8y?=
 =?us-ascii?Q?ZnMMVykDVL2lUIb42YnaYBkceCMyKgFZ49b0W3usbmqbJrFg9zn9IpNzat5C?=
 =?us-ascii?Q?DzkCxABdOpeGEKRxPO0=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:55:43.0717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3c20b81-690d-418c-21fe-08de21e26871
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5905

From: Pratyush Yadav <p.yadav@ti.com>

With multiple contexts, there needs to be a different DMA channel for
each context. Earlier, the DMA channel name was hard coded to "rx0" for
the sake of simplicity. Generate the DMA channel name based on its index
and get the channel corresponding to the context.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
---
 drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index fdbe72df5c5f8..f66d68edcd57a 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -1038,9 +1038,11 @@ static int ti_csi2rx_init_dma(struct ti_csi2rx_ctx *ctx)
 	struct dma_slave_config cfg = {
 		.src_addr_width = DMA_SLAVE_BUSWIDTH_16_BYTES,
 	};
+	char name[5];
 	int ret;
 
-	ctx->dma.chan = dma_request_chan(ctx->csi->dev, "rx0");
+	snprintf(name, sizeof(name), "rx%u", ctx->idx);
+	ctx->dma.chan = dma_request_chan(ctx->csi->dev, name);
 	if (IS_ERR(ctx->dma.chan))
 		return PTR_ERR(ctx->dma.chan);
 
-- 
2.34.1


