Return-Path: <linux-kernel+bounces-897164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B280C522DF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AFE94FD402
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3149D31DDA9;
	Wed, 12 Nov 2025 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KdU6Y8gR"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED81E31D754;
	Wed, 12 Nov 2025 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948628; cv=fail; b=GntYc9WasJ6Sa/JM4Lx1traVSsVw9L6QNCGwxEcFDFU9cbTDrJRHrgZ0B5fqqjCR+0n+WdauNPA3TxnNxvSCwMMxKmE/UF5P3Am1ePtvTpNoutU/2rF78cwJtXTZxDo6ZdGwH21FwBCfo1kwFBUx8sPXGwUUtXmCoCvaLgb6PgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948628; c=relaxed/simple;
	bh=dhCSKrnqkUdOsVup1CklE00fzEU6wWmubHTlNjGZ/Lc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzXzRuKbUvsT8pMtTeygXwU+AlPWfVKoVIxm1HtocbQKjqy1W4bWYWJAitwBLas9I7uCzxUznh3oDey0O8mybMtGJY30V0fgK2a49nffRdCr9Oks0R0Fs2Hqj3pOixOBxkgpwBGrUO5xDQFjrbJulOyxdGPyFMc/B5uGNDgQGOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KdU6Y8gR; arc=fail smtp.client-ip=52.101.46.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqkE9+zJBmh+JuvIoileJw9i3LSMDQod/dYaf083L32W6RWK6Cs5R1ragNs6XPIrpuV1iHKjNSM5CoBxiNaZpMr+bytYP94Qj0E3D3kRvc87JQWkGnNZMYIAJ88X+tO4ncdqatkdu0ZoI8LfDBEFtR5ke6LFptZZwzmtO1wEA5RNmsjYDq7dLjBnzKvLaEsmVk+DidLKwmOwfZZrZjjLYqwbcRLyOEgC8pemwOR8MitpOb4aMNLO8DXUl9AgxPSuwob6sNUhSLYYndWbT0sU5LGBTKXT6i3sPvUC4CAUHhdG6RD2qaXtUBJws43MGLI2o3lgwjZhgPdHd0plThwIsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EGEWlt/QlPAqD37kCtPoNtm3JdUXqv65E/U3NShksQ=;
 b=fzr9OY7F6yeeTLMsfpymkO6Bf0fcb6RR4gsD5x02QKW/hgOQSIHtTFPDuvyUlVf3Z2Acwi49hKkgWMt3Vo1W7Q2TsTyZG6xE1TOR3BtcKYgpyPEA+0uHCs7hlYMFKhXBPCb1ODrp5G8/3j/qT30emQsEkTbNYV7iGag1KuYC4CqreJp+qn2CFkvXDlp92fqiCYxllmprlwfeI+6b8ieis9P9pcM+76hURBrnNKBF0gsm+Hs7TtIwqAMU+Ysz3WvYP1aei+sehg4D1T0PaZbCVq3G1t0pt6yEOacXhpVOJvJD46+rcc8XJGFWIlcITlXWEQ9K15veSO+H6bVQgFHdfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EGEWlt/QlPAqD37kCtPoNtm3JdUXqv65E/U3NShksQ=;
 b=KdU6Y8gRZGbBZXfzc0nQsVLTn5ynyEdozHfM+ugxVG1LNkTxISHdiJEw1TZ0XuQ+gKjXTV7WvcQ7XZv4hcKSehxjy/VNqAKLSxup9ulZCMXZ43OeCFudhqKNrrMOCwmR0432jFeAsAFzQ0Xu01tdDyyN7zmZNl+yeKhvlVvrCw4=
Received: from CH0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::26)
 by BN0PR10MB5062.namprd10.prod.outlook.com (2603:10b6:408:12c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 11:57:03 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::a6) by CH0P220CA0019.outlook.office365.com
 (2603:10b6:610:ef::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 11:57:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:57:02 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:57:00 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:59 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:56:59 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxc72638977;
	Wed, 12 Nov 2025 05:56:53 -0600
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
Subject: [PATCH v8 17/18] media: ti: j721e-csi2rx: Support runtime suspend
Date: Wed, 12 Nov 2025 17:24:58 +0530
Message-ID: <20251112115459.2479225-18-r-donadkar@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|BN0PR10MB5062:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfb9f10-7486-49bf-adcf-08de21e297f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BAeREnIf5yRUfNX01XeVZYyMiCGeyMstGT0/ypLsnuDBoIrNvGuEhgvTNDHR?=
 =?us-ascii?Q?kxpRuR2BvxfmciPPQzr+hmRzEJyBazcDj9/M0Q2xli9la0Mmzo57+oMdEYbU?=
 =?us-ascii?Q?LIAUpi/Jd7C/MEpiWzvGzeJ+qjSOdO+Prt3tYBdhqX+4IF+iA3NxlO8sTA3z?=
 =?us-ascii?Q?04XOG5RGNhSGrGTBn0EvWf30ebxc8XPxmfoHpZM8OvPoBT5YcRHKkrmIL9QZ?=
 =?us-ascii?Q?XzhDmZp+UkgLZMQP75mhXnuhzq7Ypr1/wbzIUV9pCHUSX4Do9K2s5ZC16hPW?=
 =?us-ascii?Q?uVn0ZxZEjJcamujf5jShaa3y3YGy9TAVhjwJDoUC2vyT1dGzIqCQXac5fyD2?=
 =?us-ascii?Q?q8zaZES4PVr2ZFpnMbgIiSnbfsS13vykBVoM1f5NK0ijA3lCZxqSXO1CdJtI?=
 =?us-ascii?Q?MRaGjATmHDHeZ8pOp71I9UMGb47kMvz+4CbLAV1tYSUUQ6webxm3+iG7eliB?=
 =?us-ascii?Q?LwhOqbaGcCEXZfj17QeqtmL6EvN50PDE/+uiGv9ktw53+O1zOrK0Oh+x79Li?=
 =?us-ascii?Q?46gbLGFXa+sslg2RAl2Y6pwOyMXjeaP7CGqEGSVdLId9ykbhGNM06y5ru5O8?=
 =?us-ascii?Q?jJuQjA9X0cOKWdZVjHvmE1+FlQ8HGW5eFrXaM9KyqtJ83q9hCYiNCYrK/cWm?=
 =?us-ascii?Q?Hdn4c5bLazBBj+BMK5WK6Epf1fa7HaRoDv1qJpfKMgi7rfOTvqshxIXoHfmz?=
 =?us-ascii?Q?V7mvL32XwkoYL9Fm4aJX5CtEct+1ygtAhQYSDnNfc5qHHKag3Azhd4mlGnUP?=
 =?us-ascii?Q?Nndp4IYCo66uND4kLM7Z4C20yN9vpizvHRQRFptfI2ezveU6D2S3iSnimZkd?=
 =?us-ascii?Q?GUVVVO+JrbgYGdEgc0gySddJY+kBihgm3j8SQjna5p5TBi6zfEwafyjXj+dV?=
 =?us-ascii?Q?nIPHesKoxwR4vGdy/2uHkcNCRXpHLYxaBqoquDkI6M4MAByBqaL4A3WULq9W?=
 =?us-ascii?Q?AjD+NSBlfKyJl5vWK9I7uTgIpqLCDwAi6FZwt7nONpIqt4G5jsH+cJobkbSK?=
 =?us-ascii?Q?WC3gSGarbQtZSNf8inDkgl9oUSuhJImPyztg4qGxPXBl7jxLFA7dYEWA2QS2?=
 =?us-ascii?Q?0bATgKEQG7NZbMYg11zso8fF/rbYp7VSJsHC0fK/SZ4RGueJbnawB4nYlBiY?=
 =?us-ascii?Q?V6dzN8H2S1Yz9iR7MN7h7V9bPPYG3TBD/mpdLkDPmBWvZYkX0WS5P3zIVRdx?=
 =?us-ascii?Q?WRh5lltEsXCoYHRBeOMcOVIDyefErBI9qbc/jY00lEx1BfblkBdX3Sz8x5We?=
 =?us-ascii?Q?koojnIkd7M/qNjuATKHkdE0NYwCG3cYC9+g1p+aZOHJfmC6OY4GLxL3rMcCW?=
 =?us-ascii?Q?kaZ/DK6nmuSlkbS24MNMboKc/t7GCoB4u4SToMyDLb5TtWLeTqUQ/k+NHkUy?=
 =?us-ascii?Q?C5LMt/qLoHVGZRDEo27wlQsEuNXtoPjzgRxllSQWZ9r1m1oY+t6GEu0NDczL?=
 =?us-ascii?Q?YdQvl3/g9dTHLCGaRaofjySSsJJE3S34Y2RTxNvlTlUfMnYlxj3xDuxIsurL?=
 =?us-ascii?Q?mLR8wyVUf73c6CTJV2mT9ZR4IJ0T0z9KH6dcKdZ1m4AXHfsiBBqw6zsqz5U4?=
 =?us-ascii?Q?GooxGpFfBBaLID6zaLc=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:57:02.8645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfb9f10-7486-49bf-adcf-08de21e297f7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5062

From: Jai Luthra <jai.luthra@ideasonboard.com>

Add support for runtime power-management to enable powering off the
shared power domain between Cadence CSI2RX and TI CSI2RX wrapper when
the device(s) are not in use.

When powering off the IP, the PSI-L endpoint loses the paired DMA
channels. Thus we have to release the DMA channels at runtime suspend
and request them again at resume.

Tested-by: Rishikesh Donadkar <r-donadkar@ti.com>
Reviewed-by: Rishikesh Donadkar <r-donadkar@ti.com>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
---
 drivers/media/platform/ti/Kconfig             |  1 +
 .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 55 ++++++++++++++++++-
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/ti/Kconfig b/drivers/media/platform/ti/Kconfig
index 3bc4aa35887e6..a808063e24779 100644
--- a/drivers/media/platform/ti/Kconfig
+++ b/drivers/media/platform/ti/Kconfig
@@ -70,6 +70,7 @@ config VIDEO_TI_J721E_CSI2RX
 	depends on VIDEO_CADENCE_CSI2RX
 	depends on PHY_CADENCE_DPHY_RX || COMPILE_TEST
 	depends on ARCH_K3 || COMPILE_TEST
+	depends on PM
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_FWNODE
 	help
diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 528041ee78cf3..21e032c64b901 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 
 #include <media/cadence/cdns-csi2rx.h>
@@ -963,12 +964,16 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 	unsigned long flags;
 	int ret = 0;
 
+	ret = pm_runtime_resume_and_get(csi->dev);
+	if (ret)
+		return ret;
+
 	spin_lock_irqsave(&dma->lock, flags);
 	if (list_empty(&dma->queue))
 		ret = -EIO;
 	spin_unlock_irqrestore(&dma->lock, flags);
 	if (ret)
-		return ret;
+		goto err;
 
 	ret = video_device_pipeline_start(&ctx->vdev, &csi->pipe);
 	if (ret)
@@ -1024,6 +1029,8 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 	writel(0, csi->shim + SHIM_DMACNTX(ctx->idx));
 err:
 	ti_csi2rx_cleanup_buffers(ctx, VB2_BUF_STATE_QUEUED);
+	pm_runtime_put(csi->dev);
+
 	return ret;
 }
 
@@ -1055,6 +1062,7 @@ static void ti_csi2rx_stop_streaming(struct vb2_queue *vq)
 
 	ti_csi2rx_stop_dma(ctx);
 	ti_csi2rx_cleanup_buffers(ctx, VB2_BUF_STATE_ERROR);
+	pm_runtime_put(csi->dev);
 }
 
 static const struct vb2_ops csi_vb2_qops = {
@@ -1261,7 +1269,9 @@ static void ti_csi2rx_cleanup_notifier(struct ti_csi2rx_dev *csi)
 
 static void ti_csi2rx_cleanup_ctx(struct ti_csi2rx_ctx *ctx)
 {
-	dma_release_channel(ctx->dma.chan);
+	if (!pm_runtime_status_suspended(ctx->csi->dev))
+		dma_release_channel(ctx->dma.chan);
+
 	vb2_queue_release(&ctx->vidq);
 
 	video_unregister_device(&ctx->vdev);
@@ -1512,6 +1522,39 @@ static int ti_csi2rx_init_ctx(struct ti_csi2rx_ctx *ctx)
 	return ret;
 }
 
+static int ti_csi2rx_runtime_suspend(struct device *dev)
+{
+	struct ti_csi2rx_dev *csi = dev_get_drvdata(dev);
+	int i;
+
+	if (csi->enable_count != 0)
+		return -EBUSY;
+
+	for (i = 0; i < csi->num_ctx; i++)
+		dma_release_channel(csi->ctx[i].dma.chan);
+
+	return 0;
+}
+
+static int ti_csi2rx_runtime_resume(struct device *dev)
+{
+	struct ti_csi2rx_dev *csi = dev_get_drvdata(dev);
+	int ret, i;
+
+	for (i = 0; i < csi->num_ctx; i++) {
+		ret = ti_csi2rx_init_dma(&csi->ctx[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops ti_csi2rx_pm_ops = {
+	RUNTIME_PM_OPS(ti_csi2rx_runtime_suspend, ti_csi2rx_runtime_resume,
+		       NULL)
+};
+
 static int ti_csi2rx_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1579,6 +1622,10 @@ static int ti_csi2rx_probe(struct platform_device *pdev)
 		goto err_notifier;
 	}
 
+	pm_runtime_set_active(csi->dev);
+	pm_runtime_enable(csi->dev);
+	pm_request_idle(csi->dev);
+
 	return 0;
 
 err_notifier:
@@ -1609,6 +1656,9 @@ static void ti_csi2rx_remove(struct platform_device *pdev)
 	mutex_destroy(&csi->mutex);
 	dma_free_coherent(csi->dev, csi->drain.len, csi->drain.vaddr,
 			  csi->drain.paddr);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+
 }
 
 static const struct of_device_id ti_csi2rx_of_match[] = {
@@ -1623,6 +1673,7 @@ static struct platform_driver ti_csi2rx_pdrv = {
 	.driver = {
 		.name = TI_CSI2RX_MODULE_NAME,
 		.of_match_table = ti_csi2rx_of_match,
+		.pm		= &ti_csi2rx_pm_ops,
 	},
 };
 
-- 
2.34.1


