Return-Path: <linux-kernel+bounces-897159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F65C52231
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4981D34D7FF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A998A31B110;
	Wed, 12 Nov 2025 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZbhWU87M"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE963314D17;
	Wed, 12 Nov 2025 11:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948612; cv=fail; b=lVBTM0G5xkTFW0mEJPeXZ3mWG40ipqB+cthV9nEe19kHUWhxShSigazktj2Itq8snmFh3ztbcBOQGoXoPrjrzN0bNHMZJ2q9SAovKXWeyhKgdF/SVSa0APA4DTynSmEq1Cz9/Ixu0xVuWWs2nNIXZqzQUrnriJ0YyXLDHjMGxss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948612; c=relaxed/simple;
	bh=lrHvVSvcI4Au22SCAJ9wLn7Oj7UrvTtvfuI/H1ai82E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jr2tb8dY3G0Trzb5eO4TNH4xdYEFCecf9h26EQ/fIGXQzHdyd81/+clzK6ywAKcuyVJ9pl5q+nzCvw+3QzaevyTwMi/VUNLAQWRnsk5QHiiO5MmX4n/Ges1Mzfq10ROKXWTu7qJCMJsbG1mhU3vmS4iS+7nGYrLxByxexuFV3FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZbhWU87M; arc=fail smtp.client-ip=52.101.61.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ru8zfa2pOAMyf6pU0OsvX14yxRDxKawZQem0yqt+W4Her2EC/yfhT+0eY/gN6//fROebdWeZghEK5G7Tq9GgY4Mhpg9FB3sqoZZNXmHHm9n5kEKKkQwnnYdBciM0aqczIxiAqRUIuG0LldNvXVNPHHWVmLTjB8EoAXG80cKvGOgcXBdFk6JbZH4QL8VrinbQU8Ff2zric1tcc9G3g1/EmMe6tnOWnZtSHbdWhg/+ePLuz5X4SUALF5Y0cBJrhK+j+dEEjA6BlJd6xNliUbGplaZlzmNvsu6mr/C03vt3NeEcujJNPChy/lOgPN2Zey+kAQOphHd81n64LlzqA0E4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9S/IBXvMG2N291nsrgbUbb0NOFtd87TZtUJ7BCBOcs=;
 b=lzv3DeB4Ml36iSQ2ppPvqar5+D+fKU6cSRjq9opH0QUSLW2PrK5a6bfNzmG5aa98C/HeOQEURujNvu6IEiIQUhbJZ3hfE1LIx6+6EXkzolkSkPSzgR26xLDmyyzRy8AS3z0MWHopSRvbwdrXvnpACdDw3U8Aq03Gp8SRXVTDxkCJ7IAu8MwR8ayec0+9zz6R6k+beCZKxoTSm7wF5q0BM1pCrB/yO2npRSjswQbrFkxXXJfMunK7luNNGlXq70nJ4DpRvrX8Q5mG1be6jJgj4UBzoJCmRnymQ0+o2Irtez/QAcv81FXY6QaG7qrWRFkaNxxNlVL7OpHed9rW68meoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9S/IBXvMG2N291nsrgbUbb0NOFtd87TZtUJ7BCBOcs=;
 b=ZbhWU87MqaHF9YmqTvL2qAxUBz6dsqHAbdoPfuNjp2UpByVPq33/Hd0U5T1cjRusqNOpj50d925of8SdRYaGC6poShvszxhnBEsQw2bHHiXdpC/H2QjXrhW/mnojV7omtYZqJdrjgFsFljT8GhIZb/yQ5duko0H1CYxA/QzCACY=
Received: from DS7P220CA0063.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::10) by
 SJ0PR10MB4605.namprd10.prod.outlook.com (2603:10b6:a03:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 11:56:46 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::61) by DS7P220CA0063.outlook.office365.com
 (2603:10b6:8:224::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 11:56:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:56:45 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:40 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:39 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:56:39 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxc42638977;
	Wed, 12 Nov 2025 05:56:33 -0600
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
Subject: [PATCH v8 14/18] media: ti: j721e-csi2rx: Submit all available buffers
Date: Wed, 12 Nov 2025 17:24:55 +0530
Message-ID: <20251112115459.2479225-15-r-donadkar@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|SJ0PR10MB4605:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed974e9-6045-4db2-3fbf-08de21e28dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V3nrzL4LKqeNv1bX0vxZPEBi2btWYqhZEUGBPVbJkwwOsF12iDDuNgk+LF5l?=
 =?us-ascii?Q?G/y0JwPkE20dJPZRtiyTWaFe7dB71tR/fKNfbH0B9NUdQHQEGcs1awz8dPeG?=
 =?us-ascii?Q?o2MZDdW+BK/vkZWxpogUDLys0QXpLmcoQPPBxXP7h/tjidLEe/LcQ4ISU09k?=
 =?us-ascii?Q?Qy8awJ8R07dny6W3349VNr+5WuQ7B+4U6eGgAktwplJtuHKNjekRlLSKtCNO?=
 =?us-ascii?Q?4HAMTQGYMB5WcxDLtsx14HO0qXsXDvwYcOz+B0rNv+3vchVatFkChSOEMaib?=
 =?us-ascii?Q?QhBk2zk1SMd0dXjqlxxNC1N/rqH7pDYtvSYymElrjYqmARBatvJJ7NiuEomM?=
 =?us-ascii?Q?3+MDvg86wVFvT52CI8amOqxYxHc3pENcjdhvTYuvOJB8Q+vzG/Sz3YvoPv7n?=
 =?us-ascii?Q?AXK63qcTZPQ8RhMiD8Miy7gSWGyG2a2FJ6CVuM9+eK+XXi6PXkvldkV6NoL1?=
 =?us-ascii?Q?ZJURWhEoj+McW+NyHRVBykwTsSDZTZxjSMOBsV7V8FsrszNbh7JtZk4RET1q?=
 =?us-ascii?Q?+Kvl7Sr0zCKD7Dw7GS2ycoGuoZM0btjB2Klm31kzKn5YIX9KTsOfelsYRzB3?=
 =?us-ascii?Q?R+WwnoxjvnVjc2N1e+9hdCrmftYZbEB96O6eul9bgW5DFZ8QDebLX6lPfYw2?=
 =?us-ascii?Q?xDOCJq1jihaXdROuIFuuCD0PeWKr10fnfsCBVNL+KLH8x6RP1ojyAJ08mYhZ?=
 =?us-ascii?Q?plaMO0VVyIfq04yfLmDaYq25BPEfDy2IdITmge6PLnQ0pVs9QmaZ93SwzYQd?=
 =?us-ascii?Q?jCRRS0sZqyTPmOBZOFujFgtdGAdiDXtnZbqk151nSAd6TP2BAzN9CE3kjp+/?=
 =?us-ascii?Q?73cRM0SUEcR+skI4lwdne3cgoohRs51Ibus/rdNgCVZBe2B1HN++IOGBTGet?=
 =?us-ascii?Q?wgA5AEmxgd/XVZ8XYC2Efa/sHEUeSWSnTSaeAKD7yKlDnNJMIpw1+OtbEdyR?=
 =?us-ascii?Q?QwB6evcpwKOYC3Iv5NBvcTeuB+Lb3w74Bi9unMJ5V7Qx1ZohgBhiQ1/jphuC?=
 =?us-ascii?Q?0nUi4izOsF/jSYw+sxJXMF6fk7e+GAZf8PtCwX0LirRoEiR0RcEWO/A5LQjR?=
 =?us-ascii?Q?TfFhW1ItwU9UY4BkdRvG46a0Fatd8bcl44A9bObexEc1o0F8b80K3HQhyPq/?=
 =?us-ascii?Q?6QrKqZoU3Ouk9UUj9J9qB2hrfI3CFx1iE9MYdTYhOhRFIf6OLgAONN8xyH0t?=
 =?us-ascii?Q?GHVfhQtMV3Qbp5Pt0ZERQRuG2BO/Uxa/JMwsUgMZj1HaQ2FrSGP8XNpxOt+b?=
 =?us-ascii?Q?S+9c4P9naWHbBOHNV0GLaKKqr9JsHqvNbC79lSLAkVxLp04X2marWgVBqrfh?=
 =?us-ascii?Q?nNJ5MT4oNaLDUT3ZU8rv4NH/rCvxrllXEBBNRQOZSETcJQVGBru2ENDevEhb?=
 =?us-ascii?Q?yC6R3oWmgu9NYCpUq2uj9dWDN1NQqK6LRkQglH4IVGZ0taVu2SZHSxc+o0/7?=
 =?us-ascii?Q?wv/m4JIotBCO9FKqfIgrkpOQbhi/Y3z/UngOmN9h+3mAvItR9MK9ZApILeVk?=
 =?us-ascii?Q?FB/lwDBfYe49/+9ILk/jMtol1SOpvmCJXdUAp+AXzm9RX/+Hkk+bN2hxZkIm?=
 =?us-ascii?Q?b7szymVar/TgMIzH5qA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:56:45.7208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed974e9-6045-4db2-3fbf-08de21e28dc5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4605

From: Jai Luthra <j-luthra@ti.com>

We already make sure to submit all available buffers to DMA in each DMA
completion callback.

Move that logic in a separate function, and use it during stream start
as well, as most application queue all their buffers before stream on.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Co-developed-by: Rishikesh Donadkar <r-donadkar@ti.com>
Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
---
 .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 45 ++++++++++---------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index c8e0e761f2802..e439e9814c74d 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -672,11 +672,32 @@ static int ti_csi2rx_drain_dma(struct ti_csi2rx_ctx *ctx)
 	return ret;
 }
 
+static int ti_csi2rx_dma_submit_pending(struct ti_csi2rx_ctx *ctx)
+{
+	struct ti_csi2rx_dma *dma = &ctx->dma;
+	struct ti_csi2rx_buffer *buf;
+	int ret = 0;
+
+	/* If there are more buffers to process then start their transfer. */
+	while (!list_empty(&dma->queue)) {
+		buf = list_entry(dma->queue.next, struct ti_csi2rx_buffer, list);
+		ret = ti_csi2rx_start_dma(ctx, buf);
+		if (ret) {
+			dev_err(ctx->csi->dev,
+				"Failed to queue the next buffer for DMA\n");
+			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+			list_del(&buf->list);
+		} else {
+			list_move_tail(&buf->list, &dma->submitted);
+		}
+	}
+	return ret;
+}
+
 static void ti_csi2rx_dma_callback(void *param)
 {
 	struct ti_csi2rx_buffer *buf = param;
 	struct ti_csi2rx_ctx *ctx = buf->ctx;
-	struct ti_csi2rx_dev *csi = ctx->csi;
 	struct ti_csi2rx_dma *dma = &ctx->dma;
 	unsigned long flags;
 
@@ -693,18 +714,7 @@ static void ti_csi2rx_dma_callback(void *param)
 	vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
 	list_del(&buf->list);
 
-	/* If there are more buffers to process then start their transfer. */
-	while (!list_empty(&dma->queue)) {
-		buf = list_entry(dma->queue.next, struct ti_csi2rx_buffer, list);
-
-		if (ti_csi2rx_start_dma(ctx, buf)) {
-			dev_err(csi->dev, "Failed to queue the next buffer for DMA\n");
-			list_del(&buf->list);
-			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-		} else {
-			list_move_tail(&buf->list, &dma->submitted);
-		}
-	}
+	ti_csi2rx_dma_submit_pending(ctx);
 
 	if (list_empty(&dma->submitted))
 		dma->state = TI_CSI2RX_DMA_IDLE;
@@ -962,7 +972,6 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 	struct ti_csi2rx_ctx *ctx = vb2_get_drv_priv(vq);
 	struct ti_csi2rx_dev *csi = ctx->csi;
 	struct ti_csi2rx_dma *dma = &ctx->dma;
-	struct ti_csi2rx_buffer *buf;
 	unsigned long flags;
 	int ret = 0;
 
@@ -1001,16 +1010,13 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 	ctx->sequence = 0;
 
 	spin_lock_irqsave(&dma->lock, flags);
-	buf = list_entry(dma->queue.next, struct ti_csi2rx_buffer, list);
 
-	ret = ti_csi2rx_start_dma(ctx, buf);
+	ret = ti_csi2rx_dma_submit_pending(ctx);
 	if (ret) {
-		dev_err(csi->dev, "Failed to start DMA: %d\n", ret);
 		spin_unlock_irqrestore(&dma->lock, flags);
-		goto err_pipeline;
+		goto err_dma;
 	}
 
-	list_move_tail(&buf->list, &dma->submitted);
 	dma->state = TI_CSI2RX_DMA_ACTIVE;
 	spin_unlock_irqrestore(&dma->lock, flags);
 
@@ -1025,7 +1031,6 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 
 err_dma:
 	ti_csi2rx_stop_dma(ctx);
-err_pipeline:
 	video_device_pipeline_stop(&ctx->vdev);
 	writel(0, csi->shim + SHIM_CNTL);
 	writel(0, csi->shim + SHIM_DMACNTX(ctx->idx));
-- 
2.34.1


