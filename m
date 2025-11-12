Return-Path: <linux-kernel+bounces-897158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E5AC522C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 614334FB8F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5802935CBCB;
	Wed, 12 Nov 2025 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vbLAk7R3"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF72231A7F1;
	Wed, 12 Nov 2025 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948602; cv=fail; b=LqP+JxGZtdivNzzM9R8K1b0iJ3EbV7dzaPkJOXG7j1W2QAHGSnZea62HCdAbxSxiuNXXOMTtcGh49jQJ6RFpjVKyzB2067hyhAV8fJ7i1PtNF2VjUQeOyNpZqji4pCjeaRNKLwgjvxuuIZ4IOEVUMzhvRqkRqEFmoFy+22FMirg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948602; c=relaxed/simple;
	bh=fTI5jbjxfGXvA7Z04ULj0RvNHRp4QsQWL8Kmj2K3VM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAba+plNmfyLrUuPg1Wsp2rQ/3BkxmvurlrDWRR17hXnRPRSLI5bUPxfBRO8EqL9W1aRJ4maovfih9DISUwbEw7BE8HakG1KVBJsqkVOjyruZ2cxb5br+cFpDobavVRwFl7JBh7ayjQJr+Gqk1Ybw0ShbBe8q2+pA/s9mIrcFyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vbLAk7R3; arc=fail smtp.client-ip=52.101.46.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IehL22IOhApwpnUQZeXWCyhHx1sSOAE0sZRAMshDeToWf/31lDclYoaGsFfr54JYavwY6g4JukX5WYt37fyoS9nKCz1g4Lw/6yICqnxuf+hZ7GLlJ2lbpT0D280xKOqcDjGrrAEyLmTPZVioWKmhHdRUuqgJgd3W0Nm8K5YK1cRjGKisVUBMNIVgdcKnnlI9MD26oYsPeyzzqYGLNzR4+nX2rX9/0N+u6P7LTx5IB3GlEy2I8Cesz0Jlzx6VD/c+whlrxgudlxf3Mui3npV/ebQFgJX2KFdIXOjX/rHj9lJQm5fEPEP5UaH94M1dSBwvO09dN3E2D6bG+nQg9NDrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M727L5xtM9OvZa4d1en9A35M0WZ3xkKEtg1wcrH6D1U=;
 b=x0y72nNHe1cKArWSqFHlYi7Y/0uLo9Ne2Ohbmv+FF9FDscaA2NWnoO/v6vj4uz7VJ+LGeEVWVD2fJ+KO2/yTU/wHrN2tlRCo6+uAyjbH29mIWZir97GK4NB9uBl1U5dwjc7B1prpV1wJcqZEWn7foVjt7UejCpIltJYzp0quVCwG4RIBzmpaTTQ1kfZ3yNpLLBeBrUhJosz9cJe3QLRubFxf4et5mqcTJUcTlyD2JduVzmRH7KJOJqFSGNrPoNcYn8CUzx6GjXuV6gOo3vSUtB44fobPGlrXVg5QHJyVe1qb9TFjc35dm4bZXp/2Dwq9QGZQD0y+WSoNI9WiBIFc7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M727L5xtM9OvZa4d1en9A35M0WZ3xkKEtg1wcrH6D1U=;
 b=vbLAk7R3rtzFUMu4lye05O/Y4Fbm4cbVpr4EekGuKdG3errPaDLwbuJcztkUdp8EQXW5BwvIr1lpf8WYp4lVTl7O+8xryAfHIPNzFtdG+osAJ6AKs5nrMqSbG/6h0Obs1Uoeo20roA6VuH/xShO0jGyJ7a40zlSQ5t7z9G7InJk=
Received: from SJ0PR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:33b::24)
 by CH0PR10MB5209.namprd10.prod.outlook.com (2603:10b6:610:da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 11:56:36 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::2a) by SJ0PR05CA0019.outlook.office365.com
 (2603:10b6:a03:33b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 11:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:56:34 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:33 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:33 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:56:33 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxc32638977;
	Wed, 12 Nov 2025 05:56:27 -0600
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
Subject: [PATCH v8 13/18] media: ti: j721e-csi2rx: add multistream support
Date: Wed, 12 Nov 2025 17:24:54 +0530
Message-ID: <20251112115459.2479225-14-r-donadkar@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|CH0PR10MB5209:EE_
X-MS-Office365-Filtering-Correlation-Id: 3164dea9-bd3a-404d-5499-08de21e28745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1+/FAc5mPO82WM06lCJQ4l0jq+TGXp+7YDotZuYt7D4m6Ro4ySQbek5AU9M2?=
 =?us-ascii?Q?kt62ufiAgejFLhjrT0Zpqozkd2BcbYLH4jO8cjPcP/sDc48o97SHFdVH5JfV?=
 =?us-ascii?Q?chFB4hkULcZ6cztjTctKXSoJH7hw+Za934T0BeNgs1AkHM3m7Rw7PYi1fp88?=
 =?us-ascii?Q?j6KoFZmMkywMFmIa9OEyUfmuxrlyHlepXChlUiNmJ4twZsZVbcYhpncjSk/X?=
 =?us-ascii?Q?hRv2AwN5wwgNU3av/DSfh/1EqpZeLsMIn+mgRyk85XwXNDTpqcfZohjLDIYK?=
 =?us-ascii?Q?j4ynea3B2bUzmcv97ZdMBvyVpxBJlKQmRk5olC8Ecx3oe8IUpHUsJxj7XXYf?=
 =?us-ascii?Q?D2/MP7W4LNeYtJUKs7fkeuljYIZRa6oCXMRP5TBjBqdogwgibTgac9hIiVW5?=
 =?us-ascii?Q?QIbG2eugDT95s3QJNM6vC0xBM41SioTQ4Wx2rZRKon66nu408/mraAxBlOwq?=
 =?us-ascii?Q?ZCnMd1oebQVmj+QANAwTvFaBaRauPe1nG74ijjjkhPGdYh1vQYWabq6h9VR0?=
 =?us-ascii?Q?q+YlR7mNWYp+daxAH9HGof93Ro77yKmkeotI2wy2k9EjpEsrrUKvZ+1oTVdM?=
 =?us-ascii?Q?qiOVJaMXiDK3BKBKsGcYlJ7XsuUFgoqR0nKlGlB+3Qe1nwRNqNVXJbGOWqKk?=
 =?us-ascii?Q?IiDg8pdeQonDsMbLu3etVn8RXVpUA7SYThJHuN8JJp55hIVqvnR6GpPX6rqw?=
 =?us-ascii?Q?/Dj6yP20BTMF7E5+x1N0ICEQfbmOL/6pdqPkxeoQCNB7Osei53M5Yvz5GJbb?=
 =?us-ascii?Q?6+wnwlcUQgJf9LWY2JkxH/9coLeX/cJuz+YNh81TMkkkt2wfxXRXpggtG3GM?=
 =?us-ascii?Q?G1UHQZAperfzdU0afHRsK3trb7xNalF6IO2g619H/dwqSMdXgTZeGwndR2ti?=
 =?us-ascii?Q?Xn/pMOQ/rdX9AEpWrp0hItg+Y4k8ynFQSd4XsOtG9uWAwHduUmebDKaxiuhL?=
 =?us-ascii?Q?mzck9ENXStBYYrPM+TjpYuMNefZSfpe6487UhJn1UA7U4b8RvjbptjT8t33T?=
 =?us-ascii?Q?Kzji84Xn5fG5CdcUwvYOAaFpwKygCos0RBKipDudWxDayrqRqOv2EZvzAHks?=
 =?us-ascii?Q?CKTQjigIxbq4vxXipXORt4NJtueAij2DR6GkwTIIwX2Cn3Hl/XQgo3qKcpuq?=
 =?us-ascii?Q?ZhE+a3ENTZLX38Wb+7SQjb1fe+pwYG2iXtipn3DWjLuOS9LZFitS86knl6RC?=
 =?us-ascii?Q?MeSSK+FgiI6BRLPq5UcWZwKR2OfdnhD9oJv+NQAIqGgWM5yhKzSKMBOob252?=
 =?us-ascii?Q?h3JMg83VNfJgyWCyVTLZy0vZdRn5J0fLE2HfM88WHr8RZFyzJBa5AP/dbeTt?=
 =?us-ascii?Q?TLFTtvfru1W8zpE82tj2ePsxR0A7Q0dLmnRywbITpOr24SN+noNgtTxDlWKC?=
 =?us-ascii?Q?5gOSbAtclG8eql5Kk2W/5SM0vvfIVCETA9kTeeVTstQTHFBFRjVDipa3t0C+?=
 =?us-ascii?Q?hGU0ouAvfSYXCJfzZKGOtkp84TOxcwlF9UYLkAN4BSq0+Oly60pOJJgJf6Ta?=
 =?us-ascii?Q?X0ZrP0+3+HaFJEffYaOUms7DZDsj47tDCNi1Di2UBFlOy6TqGnP26WH9YrS7?=
 =?us-ascii?Q?LGOYrELdM4EKjLlAe8o=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:56:34.7985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3164dea9-bd3a-404d-5499-08de21e28745
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5209

From: Jai Luthra <j-luthra@ti.com>

Each CSI2 stream can be multiplexed into 4 independent streams, each
identified by its virtual channel number and data type. The incoming
data from these streams can be filtered on the basis of either the
virtual channel or the data type.

To capture this multiplexed stream, the application needs to tell
the driver how it wants to route the data. It needs to specify
which context should process which stream. This is done via the
new routing APIs.

Add ioctls to accept routing information from the application and save
that in the driver. This can be used when starting streaming on a
context to determine which route and consequently which virtual channel
it should process.

De-assert the pixel interface reset on first start_streaming() and assert
it on the last stop_streaming().

Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Co-developed-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Co-developed-by: Rishikesh Donadkar <r-donadkar@ti.com>
Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
---
 .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 224 ++++++++++++++----
 1 file changed, 179 insertions(+), 45 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 126a62fa2c4c4..c8e0e761f2802 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -103,6 +103,7 @@ struct ti_csi2rx_dev;
 
 struct ti_csi2rx_ctx {
 	struct ti_csi2rx_dev		*csi;
+	struct v4l2_subdev_route        *route;
 	struct video_device		vdev;
 	struct vb2_queue		vidq;
 	struct mutex			mutex; /* To serialize ioctls. */
@@ -136,6 +137,7 @@ struct ti_csi2rx_dev {
 		dma_addr_t		paddr;
 		size_t			len;
 	} drain;
+	bool                            vc_cached;
 };
 
 static inline struct ti_csi2rx_dev *to_csi2rx_dev(struct v4l2_subdev *sd)
@@ -143,17 +145,6 @@ static inline struct ti_csi2rx_dev *to_csi2rx_dev(struct v4l2_subdev *sd)
 	return container_of(sd, struct ti_csi2rx_dev, subdev);
 }
 
-static const struct v4l2_mbus_framefmt ti_csi2rx_default_fmt = {
-	.width = 640,
-	.height = 480,
-	.code = MEDIA_BUS_FMT_UYVY8_1X16,
-	.field = V4L2_FIELD_NONE,
-	.colorspace = V4L2_COLORSPACE_SRGB,
-	.ycbcr_enc = V4L2_YCBCR_ENC_601,
-	.quantization = V4L2_QUANTIZATION_LIM_RANGE,
-	.xfer_func = V4L2_XFER_FUNC_SRGB,
-};
-
 static const struct ti_csi2rx_fmt ti_csi2rx_formats[] = {
 	{
 		.fourcc			= V4L2_PIX_FMT_YUYV,
@@ -566,8 +557,10 @@ static void ti_csi2rx_setup_shim(struct ti_csi2rx_ctx *ctx)
 	fmt = find_format_by_fourcc(ctx->v_fmt.fmt.pix.pixelformat);
 
 	/* De-assert the pixel interface reset. */
-	reg = SHIM_CNTL_PIX_RST;
-	writel(reg, csi->shim + SHIM_CNTL);
+	if (!csi->enable_count) {
+		reg = SHIM_CNTL_PIX_RST;
+		writel(reg, csi->shim + SHIM_CNTL);
+	}
 
 	/* Negotiate pixel count from the source */
 	ti_csi2rx_request_max_ppc(csi);
@@ -888,30 +881,80 @@ static void ti_csi2rx_buffer_queue(struct vb2_buffer *vb)
 	}
 }
 
+static int ti_csi2rx_get_route(struct ti_csi2rx_ctx *ctx)
+{
+	struct ti_csi2rx_dev *csi = ctx->csi;
+	struct media_pad *pad;
+	struct v4l2_subdev_state *state;
+	struct v4l2_subdev_route *r;
+
+	/* Get the source pad connected to this ctx */
+	pad = media_entity_remote_source_pad_unique(ctx->pad.entity);
+	if (!pad) {
+		dev_err(csi->dev, "No pad connected to ctx %d\n", ctx->idx);
+		return -ENODEV;
+	}
+
+	state = v4l2_subdev_lock_and_get_active_state(&csi->subdev);
+
+	for_each_active_route(&state->routing, r) {
+		if (!(r->flags & V4L2_SUBDEV_ROUTE_FL_ACTIVE))
+			continue;
+		if (r->source_pad != pad->index)
+			continue;
+
+		ctx->route = r;
+	}
+
+	v4l2_subdev_unlock_state(state);
+
+	if (!ctx->route)
+		return -ENODEV;
+
+	return 0;
+}
+
 static int ti_csi2rx_get_vc(struct ti_csi2rx_ctx *ctx)
 {
 	struct ti_csi2rx_dev *csi = ctx->csi;
+	struct ti_csi2rx_ctx *curr_ctx;
 	struct v4l2_mbus_frame_desc fd;
-	struct media_pad *pad;
-	int ret, i;
+	struct media_pad *source_pad;
+	struct v4l2_subdev_route *curr_route;
+	int ret;
+	unsigned int i, j;
 
-	pad = media_entity_remote_pad_unique(&csi->subdev.entity, MEDIA_PAD_FL_SOURCE);
-	if (!pad)
+	/* Get the frame desc form source */
+	source_pad = media_entity_remote_pad_unique(&csi->subdev.entity, MEDIA_PAD_FL_SOURCE);
+	if (!source_pad)
 		return -ENODEV;
 
-	ret = v4l2_subdev_call(csi->source, pad, get_frame_desc, pad->index, &fd);
+	ret = v4l2_subdev_call(csi->source, pad, get_frame_desc, source_pad->index, &fd);
 	if (ret)
 		return ret;
 
 	if (fd.type != V4L2_MBUS_FRAME_DESC_TYPE_CSI2)
 		return -EINVAL;
 
-	for (i = 0; i < fd.num_entries; i++) {
-		if (ctx->stream == fd.entry[i].stream)
-			return fd.entry[i].bus.csi2.vc;
+	for (i = 0; i < csi->num_ctx; i++) {
+		curr_ctx = &csi->ctx[i];
+
+		/* Capture VC 0 by default */
+		curr_ctx->vc = 0;
+
+		ret = ti_csi2rx_get_route(curr_ctx);
+		if (ret)
+			continue;
+
+		curr_route = curr_ctx->route;
+		curr_ctx->stream = curr_route->sink_stream;
+
+		for (j = 0; j < fd.num_entries; j++)
+			if (curr_ctx->stream == fd.entry[j].stream)
+				curr_ctx->vc = fd.entry[j].bus.csi2.vc;
 	}
 
-	return -ENODEV;
+	return 0;
 }
 
 static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
@@ -934,13 +977,24 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 	if (ret)
 		goto err;
 
-	ret = ti_csi2rx_get_vc(ctx);
-	if (ret == -ENOIOCTLCMD)
-		ctx->vc = 0;
-	else if (ret < 0)
+	/* If no stream is routed to this ctx, exit early */
+	ret = ti_csi2rx_get_route(ctx);
+	if (ret)
 		goto err;
-	else
-		ctx->vc = ret;
+
+	/* Get the VC for all enabled ctx on first stream start */
+	mutex_lock(&csi->mutex);
+	if (!csi->vc_cached) {
+		ret = ti_csi2rx_get_vc(ctx);
+		if (ret == -ENOIOCTLCMD) {
+			ctx->vc = 0;
+		} else if (ret < 0) {
+			mutex_unlock(&csi->mutex);
+			goto err;
+		}
+		csi->vc_cached = true;
+	}
+	mutex_unlock(&csi->mutex);
 
 	ti_csi2rx_setup_shim(ctx);
 
@@ -960,8 +1014,9 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 	dma->state = TI_CSI2RX_DMA_ACTIVE;
 	spin_unlock_irqrestore(&dma->lock, flags);
 
+	/* Start stream 0, we don't allow multiple streams on the source pad */
 	ret = v4l2_subdev_enable_streams(&csi->subdev,
-					 TI_CSI2RX_PAD_FIRST_SOURCE,
+					 TI_CSI2RX_PAD_FIRST_SOURCE + ctx->idx,
 					 BIT(0));
 	if (ret)
 		goto err_dma;
@@ -985,17 +1040,26 @@ static void ti_csi2rx_stop_streaming(struct vb2_queue *vq)
 	struct ti_csi2rx_dev *csi = ctx->csi;
 	int ret;
 
-	video_device_pipeline_stop(&ctx->vdev);
+	mutex_lock(&csi->mutex);
 
-	writel(0, csi->shim + SHIM_CNTL);
 	writel(0, csi->shim + SHIM_DMACNTX(ctx->idx));
 
+	/* assert pixel reset to prevent stale data */
+	if (csi->enable_count == 1) {
+		writel(0, csi->shim + SHIM_CNTL);
+		csi->vc_cached = false;
+	}
+
+	video_device_pipeline_stop(&ctx->vdev);
+
 	ret = v4l2_subdev_disable_streams(&csi->subdev,
-					  TI_CSI2RX_PAD_FIRST_SOURCE,
+					  TI_CSI2RX_PAD_FIRST_SOURCE + ctx->idx,
 					  BIT(0));
 	if (ret)
 		dev_err(csi->dev, "Failed to stop subdev stream\n");
 
+	mutex_unlock(&csi->mutex);
+
 	ti_csi2rx_stop_dma(ctx);
 	ti_csi2rx_cleanup_buffers(ctx, VB2_BUF_STATE_ERROR);
 }
@@ -1038,25 +1102,84 @@ static int ti_csi2rx_sd_set_fmt(struct v4l2_subdev *sd,
 	fmt = v4l2_subdev_state_get_format(state, format->pad, format->stream);
 	*fmt = format->format;
 
-	fmt = v4l2_subdev_state_get_format(state, TI_CSI2RX_PAD_FIRST_SOURCE,
-					   format->stream);
+	fmt = v4l2_subdev_state_get_opposite_stream_format(state, format->pad,
+							   format->stream);
+	if (!fmt)
+		return -EINVAL;
+
 	*fmt = format->format;
 
 	return 0;
 }
 
-static int ti_csi2rx_sd_init_state(struct v4l2_subdev *sd,
-				   struct v4l2_subdev_state *state)
+static int _ti_csi2rx_sd_set_routing(struct v4l2_subdev *sd,
+				     struct v4l2_subdev_state *state,
+				     struct v4l2_subdev_krouting *routing)
 {
-	struct v4l2_mbus_framefmt *fmt;
+	int ret;
 
-	fmt = v4l2_subdev_state_get_format(state, TI_CSI2RX_PAD_SINK);
-	*fmt = ti_csi2rx_default_fmt;
+	const struct v4l2_mbus_framefmt format = {
+		.width = 640,
+		.height = 480,
+		.code = MEDIA_BUS_FMT_UYVY8_1X16,
+		.field = V4L2_FIELD_NONE,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.ycbcr_enc = V4L2_YCBCR_ENC_601,
+		.quantization = V4L2_QUANTIZATION_LIM_RANGE,
+		.xfer_func = V4L2_XFER_FUNC_SRGB,
+	};
 
-	fmt = v4l2_subdev_state_get_format(state, TI_CSI2RX_PAD_FIRST_SOURCE);
-	*fmt = ti_csi2rx_default_fmt;
+	ret = v4l2_subdev_routing_validate(sd, routing,
+					   V4L2_SUBDEV_ROUTING_ONLY_1_TO_1 |
+					   V4L2_SUBDEV_ROUTING_NO_SOURCE_MULTIPLEXING);
 
-	return 0;
+	if (ret)
+		return ret;
+
+	/* Only stream ID 0 allowed on source pads */
+	for (unsigned int i = 0; i < routing->num_routes; ++i) {
+		const struct v4l2_subdev_route *route = &routing->routes[i];
+
+		if (route->source_stream != 0)
+			return -EINVAL;
+	}
+
+	ret = v4l2_subdev_set_routing_with_fmt(sd, state, routing, &format);
+
+	return ret;
+}
+
+static int ti_csi2rx_sd_set_routing(struct v4l2_subdev *sd,
+				    struct v4l2_subdev_state *state,
+				    enum v4l2_subdev_format_whence which,
+				    struct v4l2_subdev_krouting *routing)
+{
+	struct ti_csi2rx_dev *csi = to_csi2rx_dev(sd);
+
+	if (csi->enable_count > 0)
+		return -EBUSY;
+
+	return _ti_csi2rx_sd_set_routing(sd, state, routing);
+}
+
+static int ti_csi2rx_sd_init_state(struct v4l2_subdev *sd,
+				   struct v4l2_subdev_state *state)
+{
+	struct v4l2_subdev_route routes[] = { {
+		.sink_pad = 0,
+		.sink_stream = 0,
+		.source_pad = TI_CSI2RX_PAD_FIRST_SOURCE,
+		.source_stream = 0,
+		.flags = V4L2_SUBDEV_ROUTE_FL_ACTIVE,
+	} };
+
+	struct v4l2_subdev_krouting routing = {
+		.num_routes = 1,
+		.routes = routes,
+	};
+
+	/* Initialize routing to single route to the fist source pad */
+	return _ti_csi2rx_sd_set_routing(sd, state, &routing);
 }
 
 static int ti_csi2rx_sd_enable_streams(struct v4l2_subdev *sd,
@@ -1065,14 +1188,18 @@ static int ti_csi2rx_sd_enable_streams(struct v4l2_subdev *sd,
 {
 	struct ti_csi2rx_dev *csi = to_csi2rx_dev(sd);
 	struct media_pad *remote_pad;
+	u64 sink_streams;
 	int ret = 0;
 
 	remote_pad = media_entity_remote_source_pad_unique(&csi->subdev.entity);
 	if (!remote_pad)
 		return -ENODEV;
+	sink_streams = v4l2_subdev_state_xlate_streams(state, pad,
+						       TI_CSI2RX_PAD_SINK,
+						       &streams_mask);
 
 	ret = v4l2_subdev_enable_streams(csi->source, remote_pad->index,
-					 BIT(0));
+					 sink_streams);
 	if (ret)
 		return ret;
 
@@ -1087,17 +1214,21 @@ static int ti_csi2rx_sd_disable_streams(struct v4l2_subdev *sd,
 {
 	struct ti_csi2rx_dev *csi = to_csi2rx_dev(sd);
 	struct media_pad *remote_pad;
+	u64 sink_streams;
 	int ret = 0;
 
 	remote_pad = media_entity_remote_source_pad_unique(&csi->subdev.entity);
 	if (!remote_pad)
 		return -ENODEV;
+	sink_streams = v4l2_subdev_state_xlate_streams(state, pad,
+						       TI_CSI2RX_PAD_SINK,
+						       &streams_mask);
 
 	if (csi->enable_count == 0)
 		return -EINVAL;
 
 	ret = v4l2_subdev_disable_streams(csi->source, remote_pad->index,
-					  BIT(0));
+					  sink_streams);
 	if (!ret)
 		--csi->enable_count;
 
@@ -1106,6 +1237,7 @@ static int ti_csi2rx_sd_disable_streams(struct v4l2_subdev *sd,
 
 static const struct v4l2_subdev_pad_ops ti_csi2rx_subdev_pad_ops = {
 	.enum_mbus_code	= ti_csi2rx_enum_mbus_code,
+	.set_routing = ti_csi2rx_sd_set_routing,
 	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = ti_csi2rx_sd_set_fmt,
 	.enable_streams = ti_csi2rx_sd_enable_streams,
@@ -1284,7 +1416,7 @@ static int ti_csi2rx_v4l2_init(struct ti_csi2rx_dev *csi)
 	v4l2_subdev_init(sd, &ti_csi2rx_subdev_ops);
 	sd->internal_ops = &ti_csi2rx_internal_ops;
 	sd->entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
-	sd->flags = V4L2_SUBDEV_FL_HAS_DEVNODE;
+	sd->flags = V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_STREAMS;
 	strscpy(sd->name, dev_name(csi->dev), sizeof(sd->name));
 	sd->dev = csi->dev;
 	sd->entity.ops = &ti_csi2rx_subdev_entity_ops;
@@ -1347,6 +1479,8 @@ static int ti_csi2rx_init_ctx(struct ti_csi2rx_ctx *ctx)
 
 	ti_csi2rx_fill_fmt(fmt, &ctx->v_fmt);
 
+	ctx->route = NULL;
+
 	ctx->pad.flags = MEDIA_PAD_FL_SINK;
 	vdev->entity.ops = &ti_csi2rx_video_entity_ops;
 	ret = media_entity_pads_init(&ctx->vdev.entity, 1, &ctx->pad);
-- 
2.34.1


