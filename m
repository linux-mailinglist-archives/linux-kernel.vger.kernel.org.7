Return-Path: <linux-kernel+bounces-897151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AE8C522AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E354A4F8079
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7637314D18;
	Wed, 12 Nov 2025 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dN60eEFA"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012027.outbound.protection.outlook.com [40.107.200.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1255314A63;
	Wed, 12 Nov 2025 11:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948555; cv=fail; b=aN00r/ispOauKTGL6X14vwCr0NB24OiT1dR38vJQoiUnecy94HNPV85D2M2r+4ph4WWa3KQQVn+YpE+dtz/Ni5YuwYz8aOT0mty606ce055VwHiM/sbvuamG3zJSd7uKUDyjHIqXrkGoOaG5n/GyAy48YZMRdaaNYOGGNokUsa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948555; c=relaxed/simple;
	bh=RFhNaLSPsdmYs34ZuDiXWU/k4fKhayVJOyV1KUVWsN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tfxB9c7TEqVbSYNs6w79LX3+qS0xt1nVy4X2bKSyURGfnFGeqicdmPh2b1OXlgy2PT1yeMf5jCVWLvg+jQ6qx+8g+ePYHfwr39WwZ2V54Gc0RrOF96CbI13C36vo/QZdReNpdEtnkJO3e+taCMJTgryy+QG3VyQ9avx5RZXZHpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dN60eEFA; arc=fail smtp.client-ip=40.107.200.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNrntUw1DYPrx+MBk1xn0xGEs37v3RHsTRvkMpUvxSdlc1LFnwcvtdlt3+nIprgA6DuQirYVX6Y/y5Fkc/Xfe09H+KefpccKEBVEp/ZrYZuL1cNJ+odSokyJ+Q0MEZ5n+a1BEWz0/YaMiIT6PvmEebgPLU8jJUAUADvX8XwZ4NF+BydugZynvV1ywQh5oOmpIVqWOToSLiSdWDW/oTgdDBgpgdTIacN5CMWCdPgNdnnuq+VTCZ97q2f3FOnqYx0zap+WT+9QdbbSs7PLCwTN7FA2mAeUeorVMDhITDgmV9N4tWoJHxhT0iEa3nRqIqWNUPPzkc/enYCJGWPzvzOY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooP38aOu3TddIZbyltlfA6OcKTRSV2FI6joizS2GcOE=;
 b=VADIuaRDWmonj5sjDyRZUKiAtUDytO2Q4tBUlBGCEXe5FoeEsVNXKGCLOoWbDLXf+Oda87mAJOFEgPNQcjGy7H+ldl5sjzncuQolcGoQwM91z8SufvGjE3H9Athp/2JC7dH+h+OIL6+BtPR5M8YXuKBpTQemzWWaw+iAt0ySpWCcHo30/xJwcv8wseS68s6aUcHTcnhIN0I0z1ciRwzd4qYZ79uYJ4T5wtSzCTsNZs7N3rPfTWT6sQPhtLOtOlmG0iTfVHpEGfNyz1sqjL/ZOFlxPSwQU+WmQMXc26GK8iG+hZuPwR7MG8+Y0RC2fss5Azki7056QVxMGN9WquFGOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooP38aOu3TddIZbyltlfA6OcKTRSV2FI6joizS2GcOE=;
 b=dN60eEFATglHfGYt3ta4gr9M8LAJrLRq7x35t0z7V2wQS4NIPQLSYyM0VDU23eloUyrE0iF8OeWEC8uAouAdTdJc5xTdLY+v3tQt8UTMQ8qN4aVpl2/YOFQDxguSW9XAUkcdtMTt2N6CvIzCsoa80CWGUsSfg4Wt6L68HJYSFpA=
Received: from MW4PR04CA0086.namprd04.prod.outlook.com (2603:10b6:303:6b::31)
 by SJ0PR10MB4701.namprd10.prod.outlook.com (2603:10b6:a03:2dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 11:55:50 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::b1) by MW4PR04CA0086.outlook.office365.com
 (2603:10b6:303:6b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 11:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:55:49 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:55:47 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:55:46 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:55:46 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxbu2638977;
	Wed, 12 Nov 2025 05:55:40 -0600
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
Subject: [PATCH v8 06/18] media: ti: j721e-csi2rx: add a subdev for the core device
Date: Wed, 12 Nov 2025 17:24:47 +0530
Message-ID: <20251112115459.2479225-7-r-donadkar@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|SJ0PR10MB4701:EE_
X-MS-Office365-Filtering-Correlation-Id: 424f714d-9bec-40cc-1eab-08de21e26c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hRi3SdkMzJ+rheUDEdlVmSYld8M3ouXinGdzw0Rk4T64MSU1VTI3P/i2lgoF?=
 =?us-ascii?Q?yXaM1y8GR57eQ80RgpouFuxq4z2mp6N010E5qhfNLFBy6vmhDLRbRdh+l+vf?=
 =?us-ascii?Q?Aq2wUsAQrjLdoG4Raw6XSatguxI7fr6L9nQGQhPQP0eA4wCQ0g1E7obOeHzx?=
 =?us-ascii?Q?y3kEiwre/NgDW6gfTIpuxzzVXmF0+WSznRrVWyo9T2cp7SxKM1cr3yApTuEr?=
 =?us-ascii?Q?HM2H+ULHJ0LCTUM4EWsRhKYGOXIy1FkGB2JmjnEQw/aDRHS8G33gA6NSUVeM?=
 =?us-ascii?Q?4pBAV514oQ5g/EV5hh/qiLFNZnkwJ9CVxq8dUdoCIjDMxU5weP8Lph8erkZP?=
 =?us-ascii?Q?piq8spbhX0ecwWo/5ZX619I44V4WpmRsctwaL26hagycEwONkUSNmpojeJt4?=
 =?us-ascii?Q?IgUWVnfhMNKNqlMCkXi8POL67P96MYRo+BriHi/2WDWEaFi33zZcOsjk088E?=
 =?us-ascii?Q?8BR0QdM183U0yet1q97RDKhOp9wnW65QrOJIp+NmBRzapBIqHpBmRSMzvoHQ?=
 =?us-ascii?Q?L52TCIt9a1oZv4xRQaYvT7jLt9N8B+SdYwAvtnu3VEAPR+lGm9s1ssiBP7PF?=
 =?us-ascii?Q?gDz0rNYyqNimaJ6dnFcYRZZncBOi0pCx8z+2TdceJ4d8nVKDQGT3AoGF2IYw?=
 =?us-ascii?Q?ekjx9pVly4F+iIiPpPLvliijxi1LT7qfP12yvESXQVjGZGYFqCTP2Qh4d8Pk?=
 =?us-ascii?Q?n06cjh3n6dXRjA/kqNbA90iDj4hvuRCDvtG7THdnBaacLHyykOXhVJ8Hqwui?=
 =?us-ascii?Q?MnQPV7FofVNS3fxLRBSCs+/SgPSE6R/TttCeqbBfNp1pGkaEK1yZdvCW5HPl?=
 =?us-ascii?Q?7szmR5iLVYGogWUOQByBNc9HazxYrmxmuR0FFsOTOD0ZJaRAcQeRyea1Ds69?=
 =?us-ascii?Q?8SYhSQM4DaIXyxM0urFW6fY2trNiQ9RDIe43Ovy4ptmxBQHwGbzKQDx6jA6D?=
 =?us-ascii?Q?wIirx0FgKKXhTbAtncGcA6hSq7VXe2YyrDfE+86v+JqSMITp70ORWkrgNagV?=
 =?us-ascii?Q?zPHUAoInEatM8FxMtIEHeRo+E5MXkG4d9P4TDMpK4eJL7l6OtUVii3/NbqQB?=
 =?us-ascii?Q?F1LCuIq8x3p1IR/5TIMau5srQNyoWvPpbLZoI8GXwTsl6HZzDoPZJXay8Aga?=
 =?us-ascii?Q?4PVMIeGLAYYM9z9FjaKWX2bL1jn7RM1WHf27Zowg545V98x7emEjKXlxjAj0?=
 =?us-ascii?Q?/D4GwSasvWG6R0j4rhC9lxhS7Nic+4bqRSKay24k9xrWCMAG3dFMSMe6dc/O?=
 =?us-ascii?Q?wj1AEZG6426DdOqlH3btrXHDScAdFVxPJXwogoWykWX7IWAXjY3CYezr9pbJ?=
 =?us-ascii?Q?RDx2bErsE8QsIv1B3dzGhUnsOCLHteSoc09uavL5SoDr4GRfOZ64NK7Ckafn?=
 =?us-ascii?Q?zhSOVmgjMS12EAFyhQUVW6ELepu5ZsW9wf2TShZki3YVip4vdU6OkMm75DjG?=
 =?us-ascii?Q?R0ta6BVaondada1O6cW7s+L5pJYkyVa1DgxeapTfZWrdIFqIXDIXfiOQpdeT?=
 =?us-ascii?Q?eRZUzKvElFFCa2fMpw9uFp0xzG4VB58OjuASeumtqXPRQIJMYUsej41QusXN?=
 =?us-ascii?Q?nkvIcKZx+1vZ4PXBaZg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:55:49.8107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 424f714d-9bec-40cc-1eab-08de21e26c77
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4701

From: Jai Luthra <j-luthra@ti.com>

With single stream capture, it was simpler to use the video device as
the media entity representing the main TI CSI2RX device. Now with multi
stream capture coming into the picture, the model has shifted to each
video device having a link to the main device's subdev. The routing
would then be set on this subdev.

Add this subdev, link each context to this subdev's entity and link the
subdev's entity to the source. Also add an array of media pads. It will
have one sink pad and source pads equal to the number of contexts.

Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Co-developed-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
---
 .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 281 +++++++++++++++---
 1 file changed, 237 insertions(+), 44 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index f66d68edcd57a..327b8e5fb7d5e 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -54,6 +54,11 @@
 #define MAX_WIDTH_BYTES			SZ_16K
 #define MAX_HEIGHT_LINES		SZ_16K
 
+#define TI_CSI2RX_PAD_SINK		0
+#define TI_CSI2RX_PAD_FIRST_SOURCE	1
+#define TI_CSI2RX_NUM_SOURCE_PADS	1
+#define TI_CSI2RX_NUM_PADS		(1 + TI_CSI2RX_NUM_SOURCE_PADS)
+
 #define DRAIN_TIMEOUT_MS		50
 #define DRAIN_BUFFER_SIZE		SZ_32K
 
@@ -102,6 +107,7 @@ struct ti_csi2rx_ctx {
 	struct mutex			mutex; /* To serialize ioctls. */
 	struct v4l2_format		v_fmt;
 	struct ti_csi2rx_dma		dma;
+	struct media_pad		pad;
 	u32				sequence;
 	u32				idx;
 };
@@ -109,12 +115,15 @@ struct ti_csi2rx_ctx {
 struct ti_csi2rx_dev {
 	struct device			*dev;
 	void __iomem			*shim;
+	struct mutex			mutex; /* To serialize ioctls. */
+	unsigned int			enable_count;
 	struct v4l2_device		v4l2_dev;
 	struct media_device		mdev;
 	struct media_pipeline		pipe;
-	struct media_pad		pad;
+	struct media_pad		pads[TI_CSI2RX_NUM_PADS];
 	struct v4l2_async_notifier	notifier;
 	struct v4l2_subdev		*source;
+	struct v4l2_subdev		subdev;
 	struct ti_csi2rx_ctx		ctx[TI_CSI2RX_NUM_CTX];
 	u8				pix_per_clk;
 	/* Buffer to drain stale data from PSI-L endpoint */
@@ -125,6 +134,22 @@ struct ti_csi2rx_dev {
 	} drain;
 };
 
+static inline struct ti_csi2rx_dev *to_csi2rx_dev(struct v4l2_subdev *sd)
+{
+	return container_of(sd, struct ti_csi2rx_dev, subdev);
+}
+
+static const struct v4l2_mbus_framefmt ti_csi2rx_default_fmt = {
+	.width = 640,
+	.height = 480,
+	.code = MEDIA_BUS_FMT_UYVY8_1X16,
+	.field = V4L2_FIELD_NONE,
+	.colorspace = V4L2_COLORSPACE_SRGB,
+	.ycbcr_enc = V4L2_YCBCR_ENC_601,
+	.quantization = V4L2_QUANTIZATION_LIM_RANGE,
+	.xfer_func = V4L2_XFER_FUNC_SRGB,
+};
+
 static const struct ti_csi2rx_fmt ti_csi2rx_formats[] = {
 	{
 		.fourcc			= V4L2_PIX_FMT_YUYV,
@@ -422,6 +447,18 @@ static int csi_async_notifier_complete(struct v4l2_async_notifier *notifier)
 	struct ti_csi2rx_dev *csi = dev_get_drvdata(notifier->v4l2_dev->dev);
 	int ret, i;
 
+	/* Create link from source to subdev */
+	ret = media_create_pad_link(&csi->source->entity,
+				    CSI2RX_BRIDGE_SOURCE_PAD,
+				    &csi->subdev.entity,
+				    TI_CSI2RX_PAD_SINK,
+				    MEDIA_LNK_FL_IMMUTABLE |
+				    MEDIA_LNK_FL_ENABLED);
+
+	if (ret)
+		return ret;
+
+	/* Create and link video nodes for all DMA contexts */
 	for (i = 0; i < TI_CSI2RX_NUM_CTX; i++) {
 		struct ti_csi2rx_ctx *ctx = &csi->ctx[i];
 		struct video_device *vdev = &ctx->vdev;
@@ -429,15 +466,17 @@ static int csi_async_notifier_complete(struct v4l2_async_notifier *notifier)
 		ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 		if (ret)
 			goto unregister_dev;
-	}
 
-	ret = media_create_pad_link(&csi->source->entity,
-				    CSI2RX_BRIDGE_SOURCE_PAD,
-				    &csi->ctx[0].vdev.entity, csi->pad.index,
-				    MEDIA_LNK_FL_IMMUTABLE |
-				    MEDIA_LNK_FL_ENABLED);
-	if (ret)
-		goto unregister_dev;
+		ret = media_create_pad_link(&csi->subdev.entity,
+					    TI_CSI2RX_PAD_FIRST_SOURCE + ctx->idx,
+					    &vdev->entity, 0,
+					    MEDIA_LNK_FL_IMMUTABLE |
+					    MEDIA_LNK_FL_ENABLED);
+		if (ret) {
+			video_unregister_device(vdev);
+			goto unregister_dev;
+		}
+	}
 
 	ret = v4l2_device_register_subdev_nodes(&csi->v4l2_dev);
 	if (ret)
@@ -447,8 +486,10 @@ static int csi_async_notifier_complete(struct v4l2_async_notifier *notifier)
 
 unregister_dev:
 	i--;
-	for (; i >= 0; i--)
+	for (; i >= 0; i--) {
+		media_entity_remove_links(&csi->ctx[i].vdev.entity);
 		video_unregister_device(&csi->ctx[i].vdev);
+	}
 	return ret;
 }
 
@@ -493,14 +534,13 @@ static int ti_csi2rx_notifier_register(struct ti_csi2rx_dev *csi)
 }
 
 /* Request maximum possible pixels per clock from the bridge */
-static void ti_csi2rx_request_max_ppc(struct ti_csi2rx_ctx *ctx)
+static void ti_csi2rx_request_max_ppc(struct ti_csi2rx_dev *csi)
 {
-	struct ti_csi2rx_dev *csi = ctx->csi;
 	u8 ppc = TI_CSI2RX_MAX_PIX_PER_CLK;
 	struct media_pad *pad;
 	int ret;
 
-	pad = media_entity_remote_source_pad_unique(&ctx->vdev.entity);
+	pad = media_entity_remote_source_pad_unique(&csi->subdev.entity);
 	if (IS_ERR(pad))
 		return;
 
@@ -526,7 +566,7 @@ static void ti_csi2rx_setup_shim(struct ti_csi2rx_ctx *ctx)
 	writel(reg, csi->shim + SHIM_CNTL);
 
 	/* Negotiate pixel count from the source */
-	ti_csi2rx_request_max_ppc(ctx);
+	ti_csi2rx_request_max_ppc(csi);
 
 	reg = SHIM_DMACNTX_EN;
 	reg |= FIELD_PREP(SHIM_DMACNTX_FMT, fmt->csi_dt);
@@ -881,7 +921,7 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 	dma->state = TI_CSI2RX_DMA_ACTIVE;
 	spin_unlock_irqrestore(&dma->lock, flags);
 
-	ret = v4l2_subdev_call(csi->source, video, s_stream, 1);
+	ret = v4l2_subdev_call(&csi->subdev, video, s_stream, 1);
 	if (ret)
 		goto err_dma;
 
@@ -909,7 +949,7 @@ static void ti_csi2rx_stop_streaming(struct vb2_queue *vq)
 	writel(0, csi->shim + SHIM_CNTL);
 	writel(0, csi->shim + SHIM_DMACNTX(ctx->idx));
 
-	ret = v4l2_subdev_call(csi->source, video, s_stream, 0);
+	ret = v4l2_subdev_call(&csi->subdev, video, s_stream, 0);
 	if (ret)
 		dev_err(csi->dev, "Failed to stop subdev stream\n");
 
@@ -925,8 +965,114 @@ static const struct vb2_ops csi_vb2_qops = {
 	.stop_streaming = ti_csi2rx_stop_streaming,
 };
 
+static int ti_csi2rx_enum_mbus_code(struct v4l2_subdev *subdev,
+				    struct v4l2_subdev_state *state,
+				    struct v4l2_subdev_mbus_code_enum *code_enum)
+{
+	if (code_enum->index >= ARRAY_SIZE(ti_csi2rx_formats))
+		return -EINVAL;
+
+	code_enum->code = ti_csi2rx_formats[code_enum->index].code;
+
+	return 0;
+}
+
+static int ti_csi2rx_sd_set_fmt(struct v4l2_subdev *sd,
+				struct v4l2_subdev_state *state,
+				struct v4l2_subdev_format *format)
+{
+	struct v4l2_mbus_framefmt *fmt;
+
+	/* No transcoding, don't allow setting source fmt */
+	if (format->pad > TI_CSI2RX_PAD_SINK)
+		return v4l2_subdev_get_fmt(sd, state, format);
+
+	if (!find_format_by_code(format->format.code))
+		format->format.code = ti_csi2rx_formats[0].code;
+
+	format->format.field = V4L2_FIELD_NONE;
+
+	fmt = v4l2_subdev_state_get_format(state, format->pad, format->stream);
+	*fmt = format->format;
+
+	fmt = v4l2_subdev_state_get_format(state, TI_CSI2RX_PAD_FIRST_SOURCE,
+					   format->stream);
+	*fmt = format->format;
+
+	return 0;
+}
+
+static int ti_csi2rx_sd_init_state(struct v4l2_subdev *sd,
+				   struct v4l2_subdev_state *state)
+{
+	struct v4l2_mbus_framefmt *fmt;
+
+	fmt = v4l2_subdev_state_get_format(state, TI_CSI2RX_PAD_SINK);
+	*fmt = ti_csi2rx_default_fmt;
+
+	fmt = v4l2_subdev_state_get_format(state, TI_CSI2RX_PAD_FIRST_SOURCE);
+	*fmt = ti_csi2rx_default_fmt;
+
+	return 0;
+}
+
+static int ti_csi2rx_sd_s_stream(struct v4l2_subdev *sd, int enable)
+{
+	struct ti_csi2rx_dev *csi = to_csi2rx_dev(sd);
+	int ret = 0;
+
+	mutex_lock(&csi->mutex);
+
+	if (enable) {
+		if (csi->enable_count > 0) {
+			csi->enable_count++;
+			goto out;
+		}
+
+		ret = v4l2_subdev_call(csi->source, video, s_stream, 1);
+		if (ret)
+			goto out;
+
+		csi->enable_count++;
+	} else {
+		if (csi->enable_count == 0) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (--csi->enable_count > 0)
+			goto out;
+
+		ret = v4l2_subdev_call(csi->source, video, s_stream, 0);
+	}
+
+out:
+	mutex_unlock(&csi->mutex);
+	return ret;
+}
+
+static const struct v4l2_subdev_pad_ops ti_csi2rx_subdev_pad_ops = {
+	.enum_mbus_code	= ti_csi2rx_enum_mbus_code,
+	.get_fmt = v4l2_subdev_get_fmt,
+	.set_fmt = ti_csi2rx_sd_set_fmt,
+};
+
+static const struct v4l2_subdev_video_ops ti_csi2rx_subdev_video_ops = {
+	.s_stream = ti_csi2rx_sd_s_stream,
+};
+
+static const struct v4l2_subdev_ops ti_csi2rx_subdev_ops = {
+	.video = &ti_csi2rx_subdev_video_ops,
+	.pad = &ti_csi2rx_subdev_pad_ops,
+};
+
+static const struct v4l2_subdev_internal_ops ti_csi2rx_internal_ops = {
+	.init_state = ti_csi2rx_sd_init_state,
+};
+
 static void ti_csi2rx_cleanup_v4l2(struct ti_csi2rx_dev *csi)
 {
+	v4l2_subdev_cleanup(&csi->subdev);
 	media_device_unregister(&csi->mdev);
 	v4l2_device_unregister(&csi->v4l2_dev);
 	media_device_cleanup(&csi->mdev);
@@ -981,48 +1127,52 @@ static int ti_csi2rx_link_validate(struct media_link *link)
 	struct ti_csi2rx_ctx *ctx = container_of(vdev, struct ti_csi2rx_ctx, vdev);
 	struct ti_csi2rx_dev *csi = ctx->csi;
 	struct v4l2_pix_format *csi_fmt = &ctx->v_fmt.fmt.pix;
-	struct v4l2_subdev_format source_fmt = {
-		.which	= V4L2_SUBDEV_FORMAT_ACTIVE,
-		.pad	= link->source->index,
-	};
+	struct v4l2_mbus_framefmt *format;
+	struct v4l2_subdev_state *state;
 	const struct ti_csi2rx_fmt *ti_fmt;
-	int ret;
 
-	ret = v4l2_subdev_call_state_active(csi->source, pad,
-					    get_fmt, &source_fmt);
-	if (ret)
-		return ret;
+	state = v4l2_subdev_lock_and_get_active_state(&csi->subdev);
+	format = v4l2_subdev_state_get_format(state, link->source->index, 0);
+	v4l2_subdev_unlock_state(state);
 
-	if (source_fmt.format.width != csi_fmt->width) {
+	if (!format) {
+		dev_dbg(csi->dev,
+			"Skipping validation as no format present on \"%s\":%u:0\n",
+			link->source->entity->name, link->source->index);
+		return 0;
+	}
+
+	if (format->width != csi_fmt->width) {
 		dev_dbg(csi->dev, "Width does not match (source %u, sink %u)\n",
-			source_fmt.format.width, csi_fmt->width);
+			format->width, csi_fmt->width);
 		return -EPIPE;
 	}
 
-	if (source_fmt.format.height != csi_fmt->height) {
+	if (format->height != csi_fmt->height) {
 		dev_dbg(csi->dev, "Height does not match (source %u, sink %u)\n",
-			source_fmt.format.height, csi_fmt->height);
+			format->height, csi_fmt->height);
 		return -EPIPE;
 	}
 
-	if (source_fmt.format.field != csi_fmt->field &&
+	if (format->field != csi_fmt->field &&
 	    csi_fmt->field != V4L2_FIELD_NONE) {
 		dev_dbg(csi->dev, "Field does not match (source %u, sink %u)\n",
-			source_fmt.format.field, csi_fmt->field);
+			format->field, csi_fmt->field);
 		return -EPIPE;
 	}
 
-	ti_fmt = find_format_by_code(source_fmt.format.code);
+	ti_fmt = find_format_by_code(format->code);
 	if (!ti_fmt) {
 		dev_dbg(csi->dev, "Media bus format 0x%x not supported\n",
-			source_fmt.format.code);
+			format->code);
 		return -EPIPE;
 	}
 
 	if (ti_fmt->fourcc != csi_fmt->pixelformat) {
 		dev_dbg(csi->dev,
-			"Cannot transform source fmt 0x%x to sink fmt 0x%x\n",
-			ti_fmt->fourcc, csi_fmt->pixelformat);
+			"Cannot transform \"%s\":%u format %p4cc to %p4cc\n",
+			link->source->entity->name, link->source->index,
+			&ti_fmt->fourcc, &csi_fmt->pixelformat);
 		return -EPIPE;
 	}
 
@@ -1033,6 +1183,10 @@ static const struct media_entity_operations ti_csi2rx_video_entity_ops = {
 	.link_validate = ti_csi2rx_link_validate,
 };
 
+static const struct media_entity_operations ti_csi2rx_subdev_entity_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+};
+
 static int ti_csi2rx_init_dma(struct ti_csi2rx_ctx *ctx)
 {
 	struct dma_slave_config cfg = {
@@ -1058,6 +1212,7 @@ static int ti_csi2rx_init_dma(struct ti_csi2rx_ctx *ctx)
 static int ti_csi2rx_v4l2_init(struct ti_csi2rx_dev *csi)
 {
 	struct media_device *mdev = &csi->mdev;
+	struct v4l2_subdev *sd = &csi->subdev;
 	int ret;
 
 	mdev->dev = csi->dev;
@@ -1070,16 +1225,51 @@ static int ti_csi2rx_v4l2_init(struct ti_csi2rx_dev *csi)
 
 	ret = v4l2_device_register(csi->dev, &csi->v4l2_dev);
 	if (ret)
-		return ret;
+		goto cleanup_media;
 
 	ret = media_device_register(mdev);
-	if (ret) {
-		v4l2_device_unregister(&csi->v4l2_dev);
-		media_device_cleanup(mdev);
-		return ret;
-	}
+	if (ret)
+		goto unregister_v4l2;
+
+	v4l2_subdev_init(sd, &ti_csi2rx_subdev_ops);
+	sd->internal_ops = &ti_csi2rx_internal_ops;
+	sd->entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
+	sd->flags = V4L2_SUBDEV_FL_HAS_DEVNODE;
+	strscpy(sd->name, dev_name(csi->dev), sizeof(sd->name));
+	sd->dev = csi->dev;
+	sd->entity.ops = &ti_csi2rx_subdev_entity_ops;
+
+	csi->pads[TI_CSI2RX_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+
+	for (unsigned int i = TI_CSI2RX_PAD_FIRST_SOURCE;
+	     i < TI_CSI2RX_NUM_PADS; i++)
+		csi->pads[i].flags = MEDIA_PAD_FL_SOURCE;
+
+	ret = media_entity_pads_init(&sd->entity, ARRAY_SIZE(csi->pads),
+				     csi->pads);
+	if (ret)
+		goto unregister_media;
+
+	ret = v4l2_subdev_init_finalize(sd);
+	if (ret)
+		goto unregister_media;
+
+	ret = v4l2_device_register_subdev(&csi->v4l2_dev, sd);
+	if (ret)
+		goto cleanup_subdev;
 
 	return 0;
+
+cleanup_subdev:
+	v4l2_subdev_cleanup(sd);
+unregister_media:
+	media_device_unregister(mdev);
+unregister_v4l2:
+	v4l2_device_unregister(&csi->v4l2_dev);
+cleanup_media:
+	media_device_cleanup(mdev);
+
+	return ret;
 }
 
 static int ti_csi2rx_init_ctx(struct ti_csi2rx_ctx *ctx)
@@ -1106,9 +1296,9 @@ static int ti_csi2rx_init_ctx(struct ti_csi2rx_ctx *ctx)
 
 	ti_csi2rx_fill_fmt(fmt, &ctx->v_fmt);
 
-	csi->pad.flags = MEDIA_PAD_FL_SINK;
+	ctx->pad.flags = MEDIA_PAD_FL_SINK;
 	vdev->entity.ops = &ti_csi2rx_video_entity_ops;
-	ret = media_entity_pads_init(&ctx->vdev.entity, 1, &csi->pad);
+	ret = media_entity_pads_init(&ctx->vdev.entity, 1, &ctx->pad);
 	if (ret)
 		return ret;
 
@@ -1169,6 +1359,8 @@ static int ti_csi2rx_probe(struct platform_device *pdev)
 	if (!csi->drain.vaddr)
 		return -ENOMEM;
 
+	mutex_init(&csi->mutex);
+
 	ret = ti_csi2rx_v4l2_init(csi);
 	if (ret)
 		goto err_v4l2;
@@ -1201,6 +1393,7 @@ static int ti_csi2rx_probe(struct platform_device *pdev)
 		ti_csi2rx_cleanup_ctx(&csi->ctx[i]);
 	ti_csi2rx_cleanup_v4l2(csi);
 err_v4l2:
+	mutex_destroy(&csi->mutex);
 	dma_free_coherent(csi->dev, csi->drain.len, csi->drain.vaddr,
 			  csi->drain.paddr);
 	return ret;
@@ -1216,7 +1409,7 @@ static void ti_csi2rx_remove(struct platform_device *pdev)
 
 	ti_csi2rx_cleanup_notifier(csi);
 	ti_csi2rx_cleanup_v4l2(csi);
-
+	mutex_destroy(&csi->mutex);
 	dma_free_coherent(csi->dev, csi->drain.len, csi->drain.vaddr,
 			  csi->drain.paddr);
 }
-- 
2.34.1


