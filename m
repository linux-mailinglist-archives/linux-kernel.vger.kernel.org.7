Return-Path: <linux-kernel+bounces-897154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A830C52270
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A6118E31F4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B323195FF;
	Wed, 12 Nov 2025 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N4jDr0IB"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7699B3148D0;
	Wed, 12 Nov 2025 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948582; cv=fail; b=ZzABEhgkyPAZQ2i1c9yEZp4aBA/e9Htab6f3sY2w74GRK/HjG5Pr0KHyFJsWYJ3ft1y5lhkgErpXcW3B6Ckv7Hc5qllQZRPjWtnVvORctR0UVU1+eOfTC/vEMl8VGIh6cHjGxH9h/bZJcfmdRTdPb9Ddl1sUk7Pm5WW7j6R7GtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948582; c=relaxed/simple;
	bh=Pbnmktv6XQiVPxPj3Mtds3QRgcL0KkSbNTzzMB7Tve8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHzZ6m5xucInLctyBZ3WJQjA1mv3Z+HYRcO2h4QQ/uvcJHgIwuRiQFWdMTN/nEhLPPBvlhMaYsoTgK8TNAVt8S6ESwgojjOwMcwurzx0QXZdnxjyhYT1w9ixqUpT2cYYBteeazWXmENBDTGOtVsFN6BkgC8622tpjYZ5aEFGs64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N4jDr0IB; arc=fail smtp.client-ip=52.101.43.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xktn0sjJ1LbtwThatM47acNwkqeRJCX7aEuS36tXT3Hq++5TK33uAXVudllusk512qIOj0bXL7NVUiK5Rlz/6IvJSkRGMrd8Fv8Tsh9FAQXxkYzNDlA52hsYB2Wlcj5SWYQaxiSkDVXgxN8ypGOTT17BCoZnc+2geZZ1Rin0HzZB+FRPKL/aklcPSwuBKQ+2hNOVWbGbS5stsTtR9QKHKQ4+r9pE6dcxEzuPwTbc0vbOcolCpOEF4fi1/NGfPFsqmp70cOfxSfqlZOcOtIJXUqKoLReFiVtQz2MnStPDtneB9g5LtZ8uLskLiL+0CU/cdhxZx2vnLa+QQYfzOyOKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1QTMby1SWO7Kx8diCJA6c99NeAegvZgDoAELmAaeUE=;
 b=bvNPiCbCZ9GP1deRI0V1hWi+sZfdWAZZxjdNPaU9MhTDaXjUQU302H6O+WBGWOVaCb7NeqplVCqc9lDtlrRx8bzEw8oDQ5nKJ9Te915KB/IyBtMVmHnmlhofXuCwiOqNAst0p3OkhykPoQ78jDxwRzCqROQNZDylvmU+hAWOHSo+1vIPFORJXaLlukE0CT6oXodBkFjFb3lrYQ0TZK4h7PxzqeF6LZKfnvnCDBAYINsM50er03z+9KgkMbwuMcYw7x1iZ1H6vr/CUeIBImJFQ1y+8eZqfiaHOOBw+ZjljNHp/OgwzRwVAGwYVUcnfiGzpQUw1apNE061ulHCd3WLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1QTMby1SWO7Kx8diCJA6c99NeAegvZgDoAELmAaeUE=;
 b=N4jDr0IBO9q2a4D963/DE9amO6OV22wugaQ+PNT9J50Tcsl/2TBm1bCATxRdwcFBUIRxk6uIzPV+RkhSs2FDIkIaGMm2G55rM+zwnldBQa8rwwZDXTRSsHC/KcSjP6PNEVQZld0Lr0jU8ZfVFqlk+H7WklJroN23XptJ6gUd40U=
Received: from BYAPR07CA0042.namprd07.prod.outlook.com (2603:10b6:a03:60::19)
 by CO1PR10MB4532.namprd10.prod.outlook.com (2603:10b6:303:6d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 11:56:17 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::a3) by BYAPR07CA0042.outlook.office365.com
 (2603:10b6:a03:60::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 11:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:56:16 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:06 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:06 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:56:06 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxbx2638977;
	Wed, 12 Nov 2025 05:56:00 -0600
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
Subject: [PATCH v8 09/18] media: ti: j721e-csi2rx: get number of contexts from device tree
Date: Wed, 12 Nov 2025 17:24:50 +0530
Message-ID: <20251112115459.2479225-10-r-donadkar@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|CO1PR10MB4532:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2af6c5-e040-42c0-a5aa-08de21e27c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lgqe0nJL31xt6mE1laUO+ui/NkKMrOgqh/8WkHxSWMHKS9vEgJQTQgYF0Qyd?=
 =?us-ascii?Q?uqw1fED3BAS2Krj7hBfaWeY5fEG06bYIYeT+5XELbLmg4ZAE18oF4swH3N7Z?=
 =?us-ascii?Q?h7ZRvGGdq9JXBW0oQa/DJj5LTnmaSIb13E6y4fFZYoqhjaYrRXiFJ7FtgqT+?=
 =?us-ascii?Q?kJa6EPWiyqwe2riVk4PY3y7hm5mPYCKpH2oKRbv8ybDejJFvE4tUrzTd3Vl7?=
 =?us-ascii?Q?ABX01JI1E6OaWXfWeK0vL8Cs++HuTzdpX07HIQUgWTLCdVSZXeoEUOd4nY7Y?=
 =?us-ascii?Q?Tr0q5RwoJEqpvxCVjja1R3FShreNcaypEmuGXWuCwiAmlO7A272clGD6P0Qk?=
 =?us-ascii?Q?Wknpl6QmTcSNJYYjeWMQ8eY6tg+ge8tePVjTLsrvYBHSd1NHq6vbTxC6MhGD?=
 =?us-ascii?Q?fnmA5Gz2TT5TdBKkTqE1AXt/fUOCvuGXTURCs2pcf+A6NCL18/aCqU+F3vkm?=
 =?us-ascii?Q?KkvAnqyN5y2mA7b4DNrvGmejEpAY4lbEOaJ5A0YEGtrC2kxG/akVwvJ8RPEX?=
 =?us-ascii?Q?eZJhXxee/Djl7VwOr6LQ4sCa+0lXoyXsCXEvcd+vYU3vQPG2AKJwkf0NutN3?=
 =?us-ascii?Q?dDma/mZ18YPuREXscAgwZOIZhdphNbK1benSWXqgMTT+sEV/bGJfOHxD0RIg?=
 =?us-ascii?Q?ZMelVpvBkDxZrg/32LwFTOMoqBJabzTqTjPvj8+9437ULQ2mzmx3FX+vh+bM?=
 =?us-ascii?Q?qDn+PUXiFOAywG5c87FYzEJ6OzVsHV+hVD43myAtlxARyqyRZJszaNP9SBjt?=
 =?us-ascii?Q?Wq/dDcBsifFs7tdbagtzfV0pwXwxqBzHvMk56k2vltjPLXC9QRgHSdUbBoyd?=
 =?us-ascii?Q?FQLLgFvHR83p/eJgRO5J8eWCQ8aXOoWDkN3DvAmFv8UQwZAE9zL8sDNrMAo2?=
 =?us-ascii?Q?WkHaS94GmPlGQ02xzNld0cMMtx94PgjqulGW9lbtsUUwBieO07XQPiVNZD/Y?=
 =?us-ascii?Q?xpPIHk89iXKI35x5AQ+iRdf+EnTNxhcG4KhJlr6NqRMPlESRaQMxCSbAKQfz?=
 =?us-ascii?Q?9sJvhEyO5WGBWU14MLfZx7FmnmjHjS6Zq3dpdtWMiEmPw1RPL1WPpBItj7pX?=
 =?us-ascii?Q?CYgFeMipeGECD+MCW1KpUX7g2ptYUNAQNDDg2d9shbx+zGHWeV5CHfwAp/Mn?=
 =?us-ascii?Q?neSz2WBM0Fp55yoRerA0mtrk01HK3dEHPVXgJkSLrAzBOdMoaaoAQEvunLSy?=
 =?us-ascii?Q?iSgtbeqPcCNXfS9tTAqPqlVLWk+q42ZHUFexeTcCBbIz5G2hCJ4Esdka9Kjn?=
 =?us-ascii?Q?KrWBCwGaH3yzKXs2RFifPPOEZpdf8kfynxQlmkMEZ0uIQ/9sKfx3+n0VaFKF?=
 =?us-ascii?Q?b53JAJQ7lww77JWpiA6TWBdZ3Xuv8v0pzDZl8Rd/95aQ5jT7Z1GjIHoWM984?=
 =?us-ascii?Q?amlz4g/vNfSNFJ5ladMpSluFMJ8JYs76bc9HYzvNDPIDyLGbEQtC2F0H5A6y?=
 =?us-ascii?Q?DKPxmfx6ocPSRultWTiERorScAXqD8cG13ynwGhE2Y7uAyM322dYNoo9j19Z?=
 =?us-ascii?Q?AxpvvLOBFLq/USRDsIFfIK7KKwGvUJvle8EVcXHmloCGqG+Pjo+qCoJj5PxB?=
 =?us-ascii?Q?3BfNo5X6V3aYZ1H0zgo=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:56:16.6227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2af6c5-e040-42c0-a5aa-08de21e27c6f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4532

From: Pratyush Yadav <p.yadav@ti.com>

Different platforms that use this driver might have different number of
DMA channels allocated for CSI. So only as many DMA contexts can be used
as the number of DMA channels available. Get the number of channels
provided via device tree and only configure that many contexts, and
hence only that many pads.

Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Co-developed-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
---
 .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 43 ++++++++++++++-----
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 372a4035d78a0..5c4524bf42e6e 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -43,7 +43,7 @@
 #define SHIM_PSI_CFG0_DST_TAG		GENMASK(31, 16)
 
 #define TI_CSI2RX_MAX_PIX_PER_CLK	4
-#define TI_CSI2RX_NUM_CTX		1
+#define TI_CSI2RX_MAX_CTX		32
 
 /*
  * There are no hard limits on the width or height. The DMA engine can handle
@@ -56,8 +56,8 @@
 
 #define TI_CSI2RX_PAD_SINK		0
 #define TI_CSI2RX_PAD_FIRST_SOURCE	1
-#define TI_CSI2RX_NUM_SOURCE_PADS	1
-#define TI_CSI2RX_NUM_PADS		(1 + TI_CSI2RX_NUM_SOURCE_PADS)
+#define TI_CSI2RX_MAX_SOURCE_PADS	TI_CSI2RX_MAX_CTX
+#define TI_CSI2RX_MAX_PADS		(1 + TI_CSI2RX_MAX_SOURCE_PADS)
 
 #define DRAIN_TIMEOUT_MS		50
 #define DRAIN_BUFFER_SIZE		SZ_32K
@@ -117,14 +117,15 @@ struct ti_csi2rx_dev {
 	void __iomem			*shim;
 	struct mutex			mutex; /* To serialize ioctls. */
 	unsigned int			enable_count;
+	unsigned int			num_ctx;
 	struct v4l2_device		v4l2_dev;
 	struct media_device		mdev;
 	struct media_pipeline		pipe;
-	struct media_pad		pads[TI_CSI2RX_NUM_PADS];
+	struct media_pad		pads[TI_CSI2RX_MAX_PADS];
 	struct v4l2_async_notifier	notifier;
 	struct v4l2_subdev		*source;
 	struct v4l2_subdev		subdev;
-	struct ti_csi2rx_ctx		ctx[TI_CSI2RX_NUM_CTX];
+	struct ti_csi2rx_ctx		ctx[TI_CSI2RX_MAX_CTX];
 	u8				pix_per_clk;
 	/* Buffer to drain stale data from PSI-L endpoint */
 	struct {
@@ -459,7 +460,7 @@ static int csi_async_notifier_complete(struct v4l2_async_notifier *notifier)
 		return ret;
 
 	/* Create and link video nodes for all DMA contexts */
-	for (i = 0; i < TI_CSI2RX_NUM_CTX; i++) {
+	for (i = 0; i < csi->num_ctx; i++) {
 		struct ti_csi2rx_ctx *ctx = &csi->ctx[i];
 		struct video_device *vdev = &ctx->vdev;
 
@@ -1253,10 +1254,11 @@ static int ti_csi2rx_v4l2_init(struct ti_csi2rx_dev *csi)
 	csi->pads[TI_CSI2RX_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
 
 	for (unsigned int i = TI_CSI2RX_PAD_FIRST_SOURCE;
-	     i < TI_CSI2RX_NUM_PADS; i++)
+	     i < TI_CSI2RX_PAD_FIRST_SOURCE + csi->num_ctx; i++)
 		csi->pads[i].flags = MEDIA_PAD_FL_SOURCE;
 
-	ret = media_entity_pads_init(&sd->entity, ARRAY_SIZE(csi->pads),
+	ret = media_entity_pads_init(&sd->entity,
+				     TI_CSI2RX_PAD_FIRST_SOURCE + csi->num_ctx,
 				     csi->pads);
 	if (ret)
 		goto unregister_media;
@@ -1347,8 +1349,9 @@ static int ti_csi2rx_init_ctx(struct ti_csi2rx_ctx *ctx)
 
 static int ti_csi2rx_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct ti_csi2rx_dev *csi;
-	int ret, i;
+	int ret = 0, i, count;
 
 	csi = devm_kzalloc(&pdev->dev, sizeof(*csi), GFP_KERNEL);
 	if (!csi)
@@ -1370,13 +1373,30 @@ static int ti_csi2rx_probe(struct platform_device *pdev)
 	if (!csi->drain.vaddr)
 		return -ENOMEM;
 
+	/* Only use as many contexts as the number of DMA channels allocated. */
+	count = of_property_count_strings(np, "dma-names");
+	if (count < 0) {
+		dev_err(csi->dev, "Failed to get DMA channel count: %d\n", count);
+		ret = count;
+		goto err_dma_chan;
+	}
+
+	csi->num_ctx = count;
+	if (csi->num_ctx > TI_CSI2RX_MAX_CTX) {
+		dev_err(csi->dev,
+			"%u DMA channels passed. Maximum is %u.\n",
+			csi->num_ctx, TI_CSI2RX_MAX_CTX);
+		ret = -EINVAL;
+		goto err_dma_chan;
+	}
+
 	mutex_init(&csi->mutex);
 
 	ret = ti_csi2rx_v4l2_init(csi);
 	if (ret)
 		goto err_v4l2;
 
-	for (i = 0; i < TI_CSI2RX_NUM_CTX; i++) {
+	for (i = 0; i < csi->num_ctx; i++) {
 		csi->ctx[i].idx = i;
 		csi->ctx[i].csi = csi;
 		ret = ti_csi2rx_init_ctx(&csi->ctx[i]);
@@ -1405,6 +1425,7 @@ static int ti_csi2rx_probe(struct platform_device *pdev)
 	ti_csi2rx_cleanup_v4l2(csi);
 err_v4l2:
 	mutex_destroy(&csi->mutex);
+err_dma_chan:
 	dma_free_coherent(csi->dev, csi->drain.len, csi->drain.vaddr,
 			  csi->drain.paddr);
 	return ret;
@@ -1415,7 +1436,7 @@ static void ti_csi2rx_remove(struct platform_device *pdev)
 	struct ti_csi2rx_dev *csi = platform_get_drvdata(pdev);
 	unsigned int i;
 
-	for (i = 0; i < TI_CSI2RX_NUM_CTX; i++)
+	for (i = 0; i < csi->num_ctx; i++)
 		ti_csi2rx_cleanup_ctx(&csi->ctx[i]);
 
 	ti_csi2rx_cleanup_notifier(csi);
-- 
2.34.1


