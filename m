Return-Path: <linux-kernel+bounces-897160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A634C5223A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D586734C0C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD38A31B82F;
	Wed, 12 Nov 2025 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l70x5gjh"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB2331B11C;
	Wed, 12 Nov 2025 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948617; cv=fail; b=qRYRK0n6ABSCxKMcW4XGuU1e6HcKWxuJO6jtp/MEyyrxDICNOxsGLWNpg6WyUrFkdAdRskB9xekPgQRfTk2uJp34845vXnto2qjQO/o6PrO6v6ixYBNEGQt4cPT8zP8XMSFg4q9NYF73sdu1ahgMiiYtsRSxbSIDmzHpuoIcvzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948617; c=relaxed/simple;
	bh=jmr2wvftY/TL7QzAg4BG+2pC3zB5IyayEFK9oP+RPZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPJGJvrFM5WYGK0Wv5Vb5z0ThvIC9Irx58QAlzBXnrwenPHpNOTSd5iD9Q+FT/vWR582J7ypiWSXmrXG75VBgcNFaQcLLZkkHILwbV+gD2ppoNMhxGJyPjhob6ZEBPlX7CNib6kPegPkPqYGsVPBDhEW2Q7jvlwxSwSUF/tWmm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=l70x5gjh; arc=fail smtp.client-ip=40.93.196.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5xecIngtHr2eh+wxqTn6UmR/4JPZX2m1iq5z1pG5U/EixrPPCmKLA5XCJJDYpbjvIKau8Irlb/JCKyI7+umCoJtA/fTJ+Gw65et1sxCYn9EzcLekc52gKIxRw7R3cLrUSECOj8lSEaOPKsz5hjApvba1kWhJefrdw9OU4VWwbvvlDb8QRSfQabhPC3THYG3RF/h8iFNv9enHukFsK0CM4WcDNclsZbPFNOKiJEs2yFIWhIgviEsPmYWJgovEdyxM9Fozg2OAHZ3iSHmjXYBQyR9mraWz+GTEdYIEgdbB3Ycw+EtKdNsffBmf7l6ACVLgUm7H95MaEo/WMmKIy5tRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoGY6THN4dSbokYrFgNfFF/VaWvs2fCkBbrfI7lO0Yg=;
 b=h+Rh4P5jav4WBSWKQTxIjf569gMNkwR9O5lTbeOBSAQUaBGZcBgPf/WGwOnsHr2DMwd8z7GCnF2N7+Dsk8fijV2mCfLFJwmbAHfOw+CLlBE4eTSzA4WRrsb9c0zfyh4HzRxfnL4U2cO4l3hIMhDMPYibPYvmCKWQ5C5GFJASuX0B8/0ZUdhzcr0pN44m7FGfiSeLeyuopJx2QIt6UdjE8PpJ5YCo6HzmIpGIRdLYXinUSQ7KFmjKLwcDyuNhdZPGq/WPjsFsd2zky1rm9yvRNrntpSZmimyhmUhvfFVp3Mc6UtPQ7sqvC+WwWOrzXfXvAvAn2oGUp4q/cikqBl1ftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoGY6THN4dSbokYrFgNfFF/VaWvs2fCkBbrfI7lO0Yg=;
 b=l70x5gjh6YNcK/Rh4X6rpPXwpuge9hMJ2fdav/XvwCSoE6krEZjHmttPkzxvKRSM+C0oUueznteF2SBkPI/mIHMyBSdxNQhrgA0AsvtbjMwmjUGKwL8U8BUQkHtFTjm1bRfJRRAiW4SqG9RMnwNhtfoCvCNxya3af13AiTohF20=
Received: from MW4PR04CA0377.namprd04.prod.outlook.com (2603:10b6:303:81::22)
 by BL3PR10MB6020.namprd10.prod.outlook.com (2603:10b6:208:3b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 11:56:52 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::ae) by MW4PR04CA0377.outlook.office365.com
 (2603:10b6:303:81::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 11:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:56:51 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:46 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:46 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:56:46 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxc52638977;
	Wed, 12 Nov 2025 05:56:40 -0600
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
Subject: [PATCH v8 15/18] media: ti: j721e-csi2rx: Change the drain architecture for multistream
Date: Wed, 12 Nov 2025 17:24:56 +0530
Message-ID: <20251112115459.2479225-16-r-donadkar@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|BL3PR10MB6020:EE_
X-MS-Office365-Filtering-Correlation-Id: 893590e2-8333-45dd-6c3c-08de21e29115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yDcTEPA9Tjp67Xl6sSMrv26aSL50aVvXQ4DWCmbIuWLH+kMcsHJZDkbNBnGf?=
 =?us-ascii?Q?b0Exuf4ZhqZken7FsRpnapP0pZFis5PfAbOslrPEIVzJ11d48Kl/pNMTIXFU?=
 =?us-ascii?Q?qmV/c09ttmRp2FPqqoEPFxeoZod6lULrCuulNcAtkTHwbw6bCQpVXIIhp0oV?=
 =?us-ascii?Q?Ya+IqG7phOEOXJQw5qyYgKRLPpDvuWyYQGqZNHXR561zRexMGU9h9TMXeji8?=
 =?us-ascii?Q?UYHSocoYX4V0HYRmSPJPfsjrnW/GXhsbxNX3CvFL8rdHeLPVJGVsMNdqvzfx?=
 =?us-ascii?Q?LczN5g3o4xOLUqnL97m/sVFEokTS9IAy9tMptwfNL5BaMOChH3lk/paStW9N?=
 =?us-ascii?Q?k/vbiJPIkyECvd+QR68chhXDgDN77kJJbW0qtWvgnkhmWRdp1VecrxFYZRm0?=
 =?us-ascii?Q?JO8LQZGEa9CQRz7NM+7IIZV7QZETJPScpatSF301FC2R1tFITlHvnuw0NYal?=
 =?us-ascii?Q?5mDWLN8PUIgLSHcmBT62fqFMAqTvjSfmJ8JwDo7PYMlv2QZNSMf30g6rsCH1?=
 =?us-ascii?Q?/qWtemN1bDyvjhYSYkGXXA1yeggoxqLF51AJj9jOgTEQt26Ak3KtLYZgjQKs?=
 =?us-ascii?Q?lD42v4e7aQK38DOll7m4+1hZPrJD6FyljAWjbWnOdrA+NcvlAavpyQ9KZ+Ij?=
 =?us-ascii?Q?bqw+pN8vdVD/asBjI0aivw3DY8hw1gQ7/HfLDx0zqbH+lCtkvScc3LXJVhHh?=
 =?us-ascii?Q?ESIF51/5YJ+bXqUBcvaJ6w579yIr0bYXPUMv/GffWL9rNXwEKktYrVXjvHCo?=
 =?us-ascii?Q?XFHBp3G7YXlZwGMK1d65Nf+PtjJJZJmFIPeFQ+ouaJGcvbMM6s5+cGUIz6C+?=
 =?us-ascii?Q?+t7Lipb7lTO/FtEu4gwZOBRBhwxRMw9oGXgZvt12upNj1hSF5ddYaWQSRV9b?=
 =?us-ascii?Q?1gvFMhv+W3YZVow0dhYVAwDnSlEXzKE6AkFOH6ms0JVmgqMmRRX/kKT8hKb9?=
 =?us-ascii?Q?/qXPeDl00u6HWr6G1LtzxK3k+cXcY6UaExiS+eHGSlisDQB7ikbeCYitinkq?=
 =?us-ascii?Q?bIoqMg/Hdo+CG3dxvB/06C02Msj/pMvPXL03ptGIqKqMt99fOI6a+rTq/YaM?=
 =?us-ascii?Q?x3BARjM9MXMdSlAdrDPLC21gwCIRcR+P1jDQlwg0ALq1JdgNFSB8DVp4NIiS?=
 =?us-ascii?Q?yvolLDBLrwtCOK7sGLsTWcm/hAiUUUdjqmTuBD/9BgPXqwrIWJ/58tGcuW4w?=
 =?us-ascii?Q?tuAMMKdYYXQ2OpzQMZ08GYCVFfbu0jr/ZejQdEnmlLdCBxd1M3nnOZhk9uKy?=
 =?us-ascii?Q?TDrggTgKWObx/3Y8tA7TmaYX1W10QwyIT7AqteDMLzL/ixnq8NqbZ5oDD18s?=
 =?us-ascii?Q?SjL45I/Cc+BIonESp9mA6SpvHCom8uaMQQ0FmngAnZr/lbdPbPSn9b3y35L7?=
 =?us-ascii?Q?zGNkOyAPgLKdblWH+eEJM96DO8SoxpsVUJy1ne5fZ+8DdJdv7TjdjsygEJOZ?=
 =?us-ascii?Q?RWF3d0j7IP5qfe8guVMwBnYlLxQFtuQODOrroShWEWhfGiinbBNr1tFbgSYh?=
 =?us-ascii?Q?lIXEk984Ttp80yKWJ5oALdjgvfDZL3VUN84BlCplXyX10IHzE7bENwqPfJrq?=
 =?us-ascii?Q?koh4ewvux4EB8vNo9p0=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:56:51.2852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 893590e2-8333-45dd-6c3c-08de21e29115
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6020

On buffer starvation the DMA is marked IDLE, and the stale data in the
internal FIFOs gets drained only on the next VIDIOC_QBUF call from the
userspace. This approach works fine for a single stream case.

But in multistream scenarios, buffer starvation for one stream i.e. one
virtual channel, can block the shared HW FIFO of the CSI2RX IP. This can
stall the pipeline for all other virtual channels, even if buffers are
available for them.

This patch introduces a new architecture, that continuously drains data
from the shared HW FIFO into a small (32KiB) buffer if no buffers are made
available to the driver from the userspace. This ensures independence
between different streams, where a slower downstream element for one
camera does not block streaming for other cameras.

Additionally, after a drain is done for a VC, the next frame will be a
partial frame, as a portion of its data will have already been drained
before a valid buffer is queued by user space to the driver.

Use wait for completion barrier to make sure the shared hardware FIFO
is cleared of the data at the end of stream after the source has stopped
sending data.

Reviewed-by: Jai Luthra <jai.luthra@ideasonboard.com>
Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
---
 .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 112 ++++++++----------
 1 file changed, 50 insertions(+), 62 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index e439e9814c74d..528041ee78cf3 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -82,7 +82,6 @@ struct ti_csi2rx_buffer {
 
 enum ti_csi2rx_dma_state {
 	TI_CSI2RX_DMA_STOPPED,	/* Streaming not started yet. */
-	TI_CSI2RX_DMA_IDLE,	/* Streaming but no pending DMA operation. */
 	TI_CSI2RX_DMA_ACTIVE,	/* Streaming and pending DMA operation. */
 };
 
@@ -110,6 +109,7 @@ struct ti_csi2rx_ctx {
 	struct v4l2_format		v_fmt;
 	struct ti_csi2rx_dma		dma;
 	struct media_pad		pad;
+	struct completion		drain_complete;
 	u32				sequence;
 	u32				idx;
 	u32				vc;
@@ -251,6 +251,10 @@ static const struct ti_csi2rx_fmt ti_csi2rx_formats[] = {
 static int ti_csi2rx_start_dma(struct ti_csi2rx_ctx *ctx,
 			       struct ti_csi2rx_buffer *buf);
 
+/* Forward declarations needed by ti_csi2rx_drain_callback. */
+static int ti_csi2rx_drain_dma(struct ti_csi2rx_ctx *ctx);
+static int ti_csi2rx_dma_submit_pending(struct ti_csi2rx_ctx *ctx);
+
 static const struct ti_csi2rx_fmt *find_format_by_fourcc(u32 pixelformat)
 {
 	unsigned int i;
@@ -617,9 +621,32 @@ static void ti_csi2rx_setup_shim(struct ti_csi2rx_ctx *ctx)
 
 static void ti_csi2rx_drain_callback(void *param)
 {
-	struct completion *drain_complete = param;
+	struct ti_csi2rx_ctx *ctx = param;
+	struct ti_csi2rx_dma *dma = &ctx->dma;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dma->lock, flags);
+
+	if (dma->state == TI_CSI2RX_DMA_STOPPED) {
+		complete(&ctx->drain_complete);
+		spin_unlock_irqrestore(&dma->lock, flags);
+		return;
+	}
 
-	complete(drain_complete);
+	/*
+	 * If dma->queue is empty, it indicates that no buffer has been
+	 * provided by user space. In this case, initiate a transactions
+	 * to drain the DMA. Since one drain of size DRAIN_BUFFER_SIZE
+	 * will be done here, the subsequent frame will be a
+	 * partial frame, with a size of frame_size - DRAIN_BUFFER_SIZE
+	 */
+	if (list_empty(&dma->queue)) {
+		if (ti_csi2rx_drain_dma(ctx))
+			dev_warn(ctx->csi->dev, "DMA drain failed\n");
+	} else {
+		ti_csi2rx_dma_submit_pending(ctx);
+	}
+	spin_unlock_irqrestore(&dma->lock, flags);
 }
 
 /*
@@ -637,12 +664,9 @@ static int ti_csi2rx_drain_dma(struct ti_csi2rx_ctx *ctx)
 {
 	struct ti_csi2rx_dev *csi = ctx->csi;
 	struct dma_async_tx_descriptor *desc;
-	struct completion drain_complete;
 	dma_cookie_t cookie;
 	int ret;
 
-	init_completion(&drain_complete);
-
 	desc = dmaengine_prep_slave_single(ctx->dma.chan, csi->drain.paddr,
 					   csi->drain.len, DMA_DEV_TO_MEM,
 					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
@@ -652,7 +676,7 @@ static int ti_csi2rx_drain_dma(struct ti_csi2rx_ctx *ctx)
 	}
 
 	desc->callback = ti_csi2rx_drain_callback;
-	desc->callback_param = &drain_complete;
+	desc->callback_param = ctx;
 
 	cookie = dmaengine_submit(desc);
 	ret = dma_submit_error(cookie);
@@ -661,13 +685,6 @@ static int ti_csi2rx_drain_dma(struct ti_csi2rx_ctx *ctx)
 
 	dma_async_issue_pending(ctx->dma.chan);
 
-	if (!wait_for_completion_timeout(&drain_complete,
-					 msecs_to_jiffies(DRAIN_TIMEOUT_MS))) {
-		dmaengine_terminate_sync(ctx->dma.chan);
-		dev_dbg(csi->dev, "DMA transfer timed out for drain buffer\n");
-		ret = -ETIMEDOUT;
-		goto out;
-	}
 out:
 	return ret;
 }
@@ -716,9 +733,11 @@ static void ti_csi2rx_dma_callback(void *param)
 
 	ti_csi2rx_dma_submit_pending(ctx);
 
-	if (list_empty(&dma->submitted))
-		dma->state = TI_CSI2RX_DMA_IDLE;
-
+	if (list_empty(&dma->submitted)) {
+		if (ti_csi2rx_drain_dma(ctx))
+			dev_warn(ctx->csi->dev,
+				 "DMA drain failed on one of the transactions\n");
+	}
 	spin_unlock_irqrestore(&dma->lock, flags);
 }
 
@@ -754,6 +773,7 @@ static int ti_csi2rx_start_dma(struct ti_csi2rx_ctx *ctx,
 static void ti_csi2rx_stop_dma(struct ti_csi2rx_ctx *ctx)
 {
 	struct ti_csi2rx_dma *dma = &ctx->dma;
+	struct ti_csi2rx_dev *csi = ctx->csi;
 	enum ti_csi2rx_dma_state state;
 	unsigned long flags;
 	int ret;
@@ -763,6 +783,8 @@ static void ti_csi2rx_stop_dma(struct ti_csi2rx_ctx *ctx)
 	dma->state = TI_CSI2RX_DMA_STOPPED;
 	spin_unlock_irqrestore(&dma->lock, flags);
 
+	init_completion(&ctx->drain_complete);
+
 	if (state != TI_CSI2RX_DMA_STOPPED) {
 		/*
 		 * Normal DMA termination does not clean up pending data on
@@ -771,11 +793,20 @@ static void ti_csi2rx_stop_dma(struct ti_csi2rx_ctx *ctx)
 		 * enforced before terminating DMA.
 		 */
 		ret = ti_csi2rx_drain_dma(ctx);
-		if (ret && ret != -ETIMEDOUT)
+		if (ret)
 			dev_warn(ctx->csi->dev,
 				 "Failed to drain DMA. Next frame might be bogus\n");
 	}
 
+	/* We wait for the drain to complete so that the stream stops
+	 * cleanly, making sure the shared hardware FIFO is cleared of
+	 * data from the current stream. No more data will be coming from
+	 * the source after this.
+	 */
+	if (!wait_for_completion_timeout(&ctx->drain_complete,
+					 msecs_to_jiffies(DRAIN_TIMEOUT_MS)))
+		dev_dbg(csi->dev, "DMA transfer timed out for drain buffer\n");
+
 	ret = dmaengine_terminate_sync(ctx->dma.chan);
 	if (ret)
 		dev_err(ctx->csi->dev, "Failed to stop DMA: %d\n", ret);
@@ -838,57 +869,14 @@ static void ti_csi2rx_buffer_queue(struct vb2_buffer *vb)
 	struct ti_csi2rx_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct ti_csi2rx_buffer *buf;
 	struct ti_csi2rx_dma *dma = &ctx->dma;
-	bool restart_dma = false;
 	unsigned long flags = 0;
-	int ret;
 
 	buf = container_of(vb, struct ti_csi2rx_buffer, vb.vb2_buf);
 	buf->ctx = ctx;
 
 	spin_lock_irqsave(&dma->lock, flags);
-	/*
-	 * Usually the DMA callback takes care of queueing the pending buffers.
-	 * But if DMA has stalled due to lack of buffers, restart it now.
-	 */
-	if (dma->state == TI_CSI2RX_DMA_IDLE) {
-		/*
-		 * Do not restart DMA with the lock held because
-		 * ti_csi2rx_drain_dma() might block for completion.
-		 * There won't be a race on queueing DMA anyway since the
-		 * callback is not being fired.
-		 */
-		restart_dma = true;
-		dma->state = TI_CSI2RX_DMA_ACTIVE;
-	} else {
-		list_add_tail(&buf->list, &dma->queue);
-	}
+	list_add_tail(&buf->list, &dma->queue);
 	spin_unlock_irqrestore(&dma->lock, flags);
-
-	if (restart_dma) {
-		/*
-		 * Once frames start dropping, some data gets stuck in the DMA
-		 * pipeline somewhere. So the first DMA transfer after frame
-		 * drops gives a partial frame. This is obviously not useful to
-		 * the application and will only confuse it. Issue a DMA
-		 * transaction to drain that up.
-		 */
-		ret = ti_csi2rx_drain_dma(ctx);
-		if (ret && ret != -ETIMEDOUT)
-			dev_warn(ctx->csi->dev,
-				 "Failed to drain DMA. Next frame might be bogus\n");
-
-		spin_lock_irqsave(&dma->lock, flags);
-		ret = ti_csi2rx_start_dma(ctx, buf);
-		if (ret) {
-			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-			dma->state = TI_CSI2RX_DMA_IDLE;
-			spin_unlock_irqrestore(&dma->lock, flags);
-			dev_err(ctx->csi->dev, "Failed to start DMA: %d\n", ret);
-		} else {
-			list_add_tail(&buf->list, &dma->submitted);
-			spin_unlock_irqrestore(&dma->lock, flags);
-		}
-	}
 }
 
 static int ti_csi2rx_get_route(struct ti_csi2rx_ctx *ctx)
-- 
2.34.1


