Return-Path: <linux-kernel+bounces-897157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E208CC5221F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6820A346D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8168431A800;
	Wed, 12 Nov 2025 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hALkmQm0"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010012.outbound.protection.outlook.com [52.101.85.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B20316188;
	Wed, 12 Nov 2025 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948595; cv=fail; b=daHZBYq0In9lXW9ejmvc4j1aEOr2GqVM7mZ4J/u43QVOBp1+JsQO/+9njpGPcWSarJWGoz5iCUbtY/qkroZPcYz2vOuj4cw/TwsUQS2QlW8tf3HeMgHKQkK/tlSY5d1SAk4bm2sdFWUWaYwlvhhSgQLZTYUDWKtYMH9HWUcQzDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948595; c=relaxed/simple;
	bh=JzJeY1JLt4K6si3tY+ENy966UDYOieU42Zw2Py2Wo2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qB9yWvEzXpRVc/e5WlrIHwsBTY+xLxYHnyBpiYz0C1pHljrKovplahSFvlIKRYoK/BoeN4mwMi7mr3LTi/VYiX653lgPjI1BlIdTHWWCgP2JCeK1BNuFK/Cd2tNXuCeKkUhCXlpx1hZUOp7OykF7q0QN2a1qR9leCgvEfWHuiJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hALkmQm0; arc=fail smtp.client-ip=52.101.85.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVcn7FPKstWCcHxn8MSkPxDghR5XWOYJ5QjPWYDkAUwm+iolf+2TojKQ92IAknBJWHaFXD1A6qhbsMyTD+pmHRhPgq9L57FW74PS2vae5jBzfOVh3Yqvowx7vuYbqjUMiAGXZs1HsaVvPNmApfiz08Y6HOlSX/q+/D59FdAQlOkxeDtgESWMZrZ1+iFrwc1SuOs5CanVdy8bO6wpBSjNhYaM3YwvApAgEx1D8MqE8KJHAtFVO1R7ejptEsSlkWa+zWmPMjPhwBzyWpNE4Fimq/d2dW2B2DGe0oDGZI9hDa8f6rBhkNv1qzaBQKJknWqxHRmOeq3Mn2W2TzSS8BezeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Kk11llwVCMK9CQJFj3UA7MJmmys7UUm5/5GbiXaJxg=;
 b=ut+qhA1N3K3uwFLxwF+Ny8+T8A9Y2z+YuPAQx4m7nMymSA27wnBWG5iHX9ng6H1YU9DA6AgzQL7rBnohr6RKwDcv5nIgEABo7zgPHBfUjlXxRJ67H2lbgoGN7dVBuM2mqVCblrE0YvTa3LKJN6Fehy0Ng+c5CiV/6YKp3TX74haJWtOZzCJkoQM1qQk3/ZvJWiO3yVuU2bPqq7bhVcRxadp68YWQQj7KxIuAMXl/jw+Dk1uU8ZijUP10UiFFeQvMQArvvYib+0V+ra5MZ5C+M9dfXd6uicm2bSzjCFycLxs7cwG+224+Ns5oII5mLz9dJPrxm8xYeI6w8SjudprKiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Kk11llwVCMK9CQJFj3UA7MJmmys7UUm5/5GbiXaJxg=;
 b=hALkmQm0Wa/+fhpfbOXgCiMFs5vjBFMiOnIeNxwiJllTp+st3FCD7IO88EaGfjJka1U8aeg1PZglltAVaz+aLRxHxLhNY5Y6q4EPZra4fmG4yutjaakg7OVY0ti4lJYkcR837i7Zr4y5g2gWwqdSVaa1Y8k+8GfGyoNnkV0S/2Y=
Received: from SJ0PR03CA0276.namprd03.prod.outlook.com (2603:10b6:a03:39e::11)
 by CO1PR10MB4547.namprd10.prod.outlook.com (2603:10b6:303:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 11:56:30 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::f1) by SJ0PR03CA0276.outlook.office365.com
 (2603:10b6:a03:39e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 11:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:56:28 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:26 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:26 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:56:26 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxc22638977;
	Wed, 12 Nov 2025 05:56:20 -0600
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
Subject: [PATCH v8 12/18] media: cadence: csi2rx: add multistream support
Date: Wed, 12 Nov 2025 17:24:53 +0530
Message-ID: <20251112115459.2479225-13-r-donadkar@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|CO1PR10MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: 33794657-d38e-4c0e-b882-08de21e28393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RXeAjD9t+l2XXLRmbGILGrD2lmvjz/N5l9raLFMCUpYgyFTi2rMvYsmWsKl1?=
 =?us-ascii?Q?mkAZfjX6ADYyyDsnM418ohZj6yz9YwDb8RLIBlzBp8LMSL+JYbzkbWXTobg4?=
 =?us-ascii?Q?oQNwAI8IF3GeVs8DZgWn6e82H5Ps9t1XfgP2Xuh09+6jnyQD579yO+DxWrLZ?=
 =?us-ascii?Q?lA8bJg7ZzXPEXXeICrm6f7XpoYBeaw4gjQ/BWZnrv5XzdHj1xl5nAIQvJuIP?=
 =?us-ascii?Q?zwXzTnq6SAlyyuxIztcp0TgSOYKrBGUoS7uOVz0blAqn4YdweiG22f8hzT1I?=
 =?us-ascii?Q?dfuY2vYIufqgvN5JYZ0mbIccpqYWn4DHJRz177Dao/Je+jWbmQ1Tgh46UIPR?=
 =?us-ascii?Q?VRT0E8y8ZYOppwPLJfOwQpvrcqwR1bpmSzwlnmC2AYPGxiR15w6oQpjCIQ/j?=
 =?us-ascii?Q?W3Qyr+6Jcx5PyHpwIMoYw8BjET/DAGWktRO06FKQxJ4+BlxjxIoRjRRxh0fS?=
 =?us-ascii?Q?brjN+9XUDGulTHv0LTwO2rcEIaLM5li5yv+8gPQFshTDpu81tRF3dT83Bhhv?=
 =?us-ascii?Q?ME9cRzTKFb8nY+ueyar3LyDLYxvA8Ro3cgKQsjUCm8KmPfYymzh9Kxt0+WxV?=
 =?us-ascii?Q?AjGuVSzMXbaQx/VF/VjGtymN+YMSPMvloYsJSNXoK6pi1j0MPHnnvy1DL0WG?=
 =?us-ascii?Q?6tNThI8pfrn9jy3NieMGq4SK3OiwsXR5Dxf3PIPPRsTVT7kp6xHR/dLVCGXV?=
 =?us-ascii?Q?FtzVSxs0qMrtimyKyIwN/W2f/M9lYi5jsJVICkXRSpZtWAFiyFN2UPK6J7Ja?=
 =?us-ascii?Q?wUCXKobNpbSfD3ywrfsNKPT/5wbPzBp0wq8ufRVy3t602nIl6JH1uVkV3F6s?=
 =?us-ascii?Q?o+uTHFxJuKMqQF04HfLSbXL8U29Qu1ozm0fwCBiwPvDXkbXiubWh7DkM75+W?=
 =?us-ascii?Q?bhdyyIvohPieopm3Fe0iTGUUJm2nwEW0XuyiU3xY6bU4tnGmBhelpiW0Ne+f?=
 =?us-ascii?Q?8Ug0DBBKUk2/YLRsFpN+m7aBAk2NEtpjuimPRF44yuJ83ypX54VDVPlNZSdt?=
 =?us-ascii?Q?PUZwu0On3E/RFnRviSlD44t9F9slMjND135K0L83i5OtmNm+Z48BAs1ssLeq?=
 =?us-ascii?Q?BLs462iU99kyM5J7rsCzN/SMgSHzZYakqQFrgj9gNTxuwRrp8zVioRjHwR0w?=
 =?us-ascii?Q?PNsszmFZunYNpGjHx2Q2wrWFY33guof5WypcnSyztxVkdtQEwM7pRCaacGII?=
 =?us-ascii?Q?hU7PVNH23BbFAabfZsB8x7oOV7nxvQFXzsuxEOlJNnfEv3WD25buIV71nte4?=
 =?us-ascii?Q?5R6C4mr0yX1f33X746tueFO6fYWLYczzf3RARFSCwkZB6+/GjZhoFeeaqp85?=
 =?us-ascii?Q?wA795PztVIaRzvFdo4QmSPjLlRq58sQBN//YCKtjH3l1tjtqieIaEKU4sogC?=
 =?us-ascii?Q?mDK/MEtRKiCzb1R6KHki4pidrfIHb/XN+mpHVg/pAjBlN4D8tvmSI7DhTZiu?=
 =?us-ascii?Q?DCwH1CFtmxtmVJQdAae2Ir8rltXHM5oHi2huGLSWR/ldq+gBXteNy1vJGKXx?=
 =?us-ascii?Q?jqN4KDbVGtIu5lDcLFRH8Qxe/LtkjYFL0e1Nclyh7/dypJbAuTaD7ZOmjyLR?=
 =?us-ascii?Q?d4HL5f9U3REDGYGuPB4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:56:28.5955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33794657-d38e-4c0e-b882-08de21e28393
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4547

From: Jai Luthra <j-luthra@ti.com>

Cadence CSI-2 bridge IP supports capturing multiple virtual "streams"
of data over the same physical interface using MIPI Virtual Channels.

While the hardware IP supports usecases where streams coming in the sink
pad can be broadcasted to multiple source pads, the driver will need
significant re-architecture to make that possible. The two users of this
IP in mainline linux are TI Shim and StarFive JH7110 CAMSS, and both
have only integrated the first source pad i.e stream0 of this IP. So for
now keep it simple and only allow 1-to-1 mapping of streams from sink to
source, without any broadcasting.

Implement a fallback s_stream hook that internally calls enable_stream
on each source pad, for consumer drivers that don't use multi-stream
APIs to still work. The helper function v4l2_subdev_s_stream_helper()
form the v4l2 framework is not used here as it is meant only for the
subedvs that have a single source pad and this hardware IP supports
having multiple source pads.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Co-developed-by: Rishikesh Donadkar <r-donadkar@ti.com>
Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 283 ++++++++++++++++---
 1 file changed, 236 insertions(+), 47 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 3688077fa8347..833bc134f17cb 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -135,6 +135,7 @@ struct csi2rx_priv {
 	struct phy			*dphy;
 
 	u8				num_pixels[CSI2RX_STREAMS_MAX];
+	u32				vc_select[CSI2RX_STREAMS_MAX];
 	u8				lanes[CSI2RX_LANES_MAX];
 	u8				num_lanes;
 	u8				max_lanes;
@@ -273,30 +274,43 @@ static void csi2rx_reset(struct csi2rx_priv *csi2rx)
 
 static int csi2rx_configure_ext_dphy(struct csi2rx_priv *csi2rx)
 {
-	struct media_pad *src_pad =
-		&csi2rx->source_subdev->entity.pads[csi2rx->source_pad];
 	union phy_configure_opts opts = { };
 	struct phy_configure_opts_mipi_dphy *cfg = &opts.mipi_dphy;
-	struct v4l2_subdev_state *state;
 	struct v4l2_mbus_framefmt *framefmt;
+	struct v4l2_subdev_state *state;
 	const struct csi2rx_fmt *fmt;
+	int source_pad = csi2rx->source_pad;
+	struct media_pad *pad = &csi2rx->source_subdev->entity.pads[source_pad];
 	s64 link_freq;
 	int ret;
+	u32 bpp;
 
 	state = v4l2_subdev_get_locked_active_state(&csi2rx->subdev);
 
-	framefmt = v4l2_subdev_state_get_format(state, CSI2RX_PAD_SINK, 0);
-	if (!framefmt) {
-		dev_err(csi2rx->dev, "Did not find active sink format\n");
-		return -EINVAL;
-	}
+	/*
+	 * For multi-stream transmitters there is no single pixel rate.
+	 *
+	 * In multistream usecase pass bpp as 0 so that v4l2_get_link_freq()
+	 * returns an error if it falls back to V4L2_CID_PIXEL_RATE.
+	 */
+	if (state->routing.num_routes > 1) {
+		bpp = 0;
+	} else {
+		framefmt = v4l2_subdev_state_get_format(state, CSI2RX_PAD_SINK, 0);
+		if (!framefmt) {
+			dev_err(csi2rx->dev, "Did not find active sink format\n");
+			return -EINVAL;
+		}
 
-	fmt = csi2rx_get_fmt_by_code(framefmt->code);
+		fmt = csi2rx_get_fmt_by_code(framefmt->code);
+		bpp = fmt->bpp;
+	}
 
-	link_freq = v4l2_get_link_freq(src_pad,
-				       fmt->bpp, 2 * csi2rx->num_lanes);
-	if (link_freq < 0)
+	link_freq = v4l2_get_link_freq(pad, bpp, 2 * csi2rx->num_lanes);
+	if (link_freq < 0) {
+		dev_err(csi2rx->dev, "Unable to calculate link frequency\n");
 		return link_freq;
+	}
 
 	ret = phy_mipi_dphy_get_default_config_for_hsclk(link_freq,
 							 csi2rx->num_lanes, cfg);
@@ -394,11 +408,7 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 					  csi2rx->num_pixels[i]),
 		       csi2rx->base + CSI2RX_STREAM_CFG_REG(i));
 
-		/*
-		 * Enable one virtual channel. When multiple virtual channels
-		 * are supported this will have to be changed.
-		 */
-		writel(CSI2RX_STREAM_DATA_CFG_VC_SELECT(0),
+		writel(csi2rx->vc_select[i],
 		       csi2rx->base + CSI2RX_STREAM_DATA_CFG_REG(i));
 
 		writel(CSI2RX_STREAM_CTRL_START,
@@ -486,18 +496,59 @@ static int csi2rx_log_status(struct v4l2_subdev *sd)
 	return 0;
 }
 
+static void csi2rx_update_vc_select(struct csi2rx_priv *csi2rx,
+				    struct v4l2_subdev_state *state)
+{
+	struct v4l2_mbus_frame_desc fd = {0};
+	struct v4l2_subdev_route *route;
+	unsigned int i;
+	int ret;
+
+	/* Capture VC=0 by default */
+	for (i = 0; i < CSI2RX_STREAMS_MAX; i++)
+		csi2rx->vc_select[i] = CSI2RX_STREAM_DATA_CFG_VC_SELECT(0);
+
+	ret = csi2rx_get_frame_desc_from_source(csi2rx, &fd);
+	if (ret || fd.type != V4L2_MBUS_FRAME_DESC_TYPE_CSI2) {
+		dev_dbg(csi2rx->dev,
+			"Failed to get source frame desc, allowing only VC=0\n");
+		return;
+	}
+
+	/* If source provides per-stream VC info, use it to filter by VC */
+	memset(csi2rx->vc_select, 0, sizeof(csi2rx->vc_select));
+
+	for_each_active_route(&state->routing, route) {
+		u32 cdns_stream = route->source_pad - CSI2RX_PAD_SOURCE_STREAM0;
+
+		for (i = 0; i < fd.num_entries; i++) {
+			if (fd.entry[i].stream != route->sink_stream)
+				continue;
+
+			csi2rx->vc_select[cdns_stream] |=
+				CSI2RX_STREAM_DATA_CFG_VC_SELECT(fd.entry[i].bus.csi2.vc);
+		}
+	}
+}
+
 static int csi2rx_enable_streams(struct v4l2_subdev *subdev,
 				 struct v4l2_subdev_state *state, u32 pad,
 				 u64 streams_mask)
 {
 	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+	u64 sink_streams;
 	int ret;
 
+	sink_streams = v4l2_subdev_state_xlate_streams(state, pad,
+						       CSI2RX_PAD_SINK,
+						       &streams_mask);
+
 	/*
 	 * If we're not the first users, there's no need to
 	 * enable the whole controller.
 	 */
 	if (!csi2rx->count) {
+		csi2rx_update_vc_select(csi2rx, state);
 		ret = csi2rx_start(csi2rx);
 		if (ret)
 			return ret;
@@ -505,10 +556,11 @@ static int csi2rx_enable_streams(struct v4l2_subdev *subdev,
 
 	/* Start streaming on the source */
 	ret = v4l2_subdev_enable_streams(csi2rx->source_subdev, csi2rx->source_pad,
-					 BIT(0));
+					 sink_streams);
 	if (ret) {
 		dev_err(csi2rx->dev,
-			"Failed to start streams %d on subdev\n", 0);
+			"Failed to start streams %#llx on subdev\n",
+			sink_streams);
 		if (!csi2rx->count)
 			csi2rx_stop(csi2rx);
 		return ret;
@@ -523,9 +575,14 @@ static int csi2rx_disable_streams(struct v4l2_subdev *subdev,
 				  u64 streams_mask)
 {
 	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+	u64 sink_streams;
+
+	sink_streams = v4l2_subdev_state_xlate_streams(state, pad,
+						       CSI2RX_PAD_SINK,
+						       &streams_mask);
 
 	if (v4l2_subdev_disable_streams(csi2rx->source_subdev,
-					csi2rx->source_pad, BIT(0))) {
+						 csi2rx->source_pad, sink_streams)) {
 		dev_err(csi2rx->dev, "Couldn't disable our subdev\n");
 	}
 
@@ -538,6 +595,36 @@ static int csi2rx_disable_streams(struct v4l2_subdev *subdev,
 	return 0;
 }
 
+static int csi2rx_s_stream_fallback(struct v4l2_subdev *sd, int enable)
+{
+	struct v4l2_subdev_state *state;
+	struct v4l2_subdev_route *route;
+	u64 mask[CSI2RX_PAD_MAX] = {0};
+	int i, ret;
+
+	/* Find the stream mask on all source pads */
+	state = v4l2_subdev_lock_and_get_active_state(sd);
+	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++) {
+		for_each_active_route(&state->routing, route) {
+			if (route->source_pad == i)
+				mask[i] |= BIT_ULL(route->source_stream);
+		}
+	}
+	v4l2_subdev_unlock_state(state);
+
+	/* Start streaming on each pad */
+	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++) {
+		if (enable)
+			ret = v4l2_subdev_enable_streams(sd, i, mask[i]);
+		else
+			ret = v4l2_subdev_disable_streams(sd, i, mask[i]);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static int csi2rx_enum_mbus_code(struct v4l2_subdev *subdev,
 				 struct v4l2_subdev_state *state,
 				 struct v4l2_subdev_mbus_code_enum *code_enum)
@@ -550,12 +637,56 @@ static int csi2rx_enum_mbus_code(struct v4l2_subdev *subdev,
 	return 0;
 }
 
+static int _csi2rx_set_routing(struct v4l2_subdev *subdev,
+			       struct v4l2_subdev_state *state,
+			       struct v4l2_subdev_krouting *routing)
+{
+	static const struct v4l2_mbus_framefmt format = {
+		.width = 640,
+		.height = 480,
+		.code = MEDIA_BUS_FMT_UYVY8_1X16,
+		.field = V4L2_FIELD_NONE,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.ycbcr_enc = V4L2_YCBCR_ENC_601,
+		.quantization = V4L2_QUANTIZATION_LIM_RANGE,
+		.xfer_func = V4L2_XFER_FUNC_SRGB,
+	};
+	int ret;
+
+	if (routing->num_routes > V4L2_FRAME_DESC_ENTRY_MAX)
+		return -EINVAL;
+
+	ret = v4l2_subdev_routing_validate(subdev, routing,
+					   V4L2_SUBDEV_ROUTING_ONLY_1_TO_1);
+	if (ret)
+		return ret;
+
+	return v4l2_subdev_set_routing_with_fmt(subdev, state, routing, &format);
+}
+
+static int csi2rx_set_routing(struct v4l2_subdev *subdev,
+			      struct v4l2_subdev_state *state,
+			      enum v4l2_subdev_format_whence which,
+			      struct v4l2_subdev_krouting *routing)
+{
+	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+	int ret;
+
+	if (which == V4L2_SUBDEV_FORMAT_ACTIVE && csi2rx->count)
+		return -EBUSY;
+
+	ret = _csi2rx_set_routing(subdev, state, routing);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int csi2rx_set_fmt(struct v4l2_subdev *subdev,
 			  struct v4l2_subdev_state *state,
 			  struct v4l2_subdev_format *format)
 {
 	struct v4l2_mbus_framefmt *fmt;
-	unsigned int i;
 
 	/* No transcoding, source and sink formats must match. */
 	if (format->pad != CSI2RX_PAD_SINK)
@@ -567,14 +698,16 @@ static int csi2rx_set_fmt(struct v4l2_subdev *subdev,
 	format->format.field = V4L2_FIELD_NONE;
 
 	/* Set sink format */
-	fmt = v4l2_subdev_state_get_format(state, format->pad);
+	fmt = v4l2_subdev_state_get_format(state, format->pad, format->stream);
 	*fmt = format->format;
 
-	/* Propagate to source formats */
-	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++) {
-		fmt = v4l2_subdev_state_get_format(state, i);
-		*fmt = format->format;
-	}
+	/* Propagate to source format */
+	fmt = v4l2_subdev_state_get_opposite_stream_format(state, format->pad,
+							   format->stream);
+	if (!fmt)
+		return -EINVAL;
+
+	*fmt = format->format;
 
 	return 0;
 }
@@ -582,21 +715,22 @@ static int csi2rx_set_fmt(struct v4l2_subdev *subdev,
 static int csi2rx_init_state(struct v4l2_subdev *subdev,
 			     struct v4l2_subdev_state *state)
 {
-	struct v4l2_subdev_format format = {
-		.pad = CSI2RX_PAD_SINK,
-		.format = {
-			.width = 640,
-			.height = 480,
-			.code = MEDIA_BUS_FMT_UYVY8_1X16,
-			.field = V4L2_FIELD_NONE,
-			.colorspace = V4L2_COLORSPACE_SRGB,
-			.ycbcr_enc = V4L2_YCBCR_ENC_601,
-			.quantization = V4L2_QUANTIZATION_LIM_RANGE,
-			.xfer_func = V4L2_XFER_FUNC_SRGB,
+	struct v4l2_subdev_route routes[] = {
+		{
+			.sink_pad = CSI2RX_PAD_SINK,
+			.sink_stream = 0,
+			.source_pad = CSI2RX_PAD_SOURCE_STREAM0,
+			.source_stream = 0,
+			.flags = V4L2_SUBDEV_ROUTE_FL_ACTIVE,
 		},
 	};
 
-	return csi2rx_set_fmt(subdev, state, &format);
+	struct v4l2_subdev_krouting routing = {
+		.num_routes = ARRAY_SIZE(routes),
+		.routes = routes,
+	};
+
+	return _csi2rx_set_routing(subdev, state, &routing);
 }
 
 int cdns_csi2rx_negotiate_ppc(struct v4l2_subdev *subdev, unsigned int pad,
@@ -630,17 +764,70 @@ static int csi2rx_get_frame_desc(struct v4l2_subdev *subdev, unsigned int pad,
 				 struct v4l2_mbus_frame_desc *fd)
 {
 	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+	struct v4l2_mbus_frame_desc source_fd = {0};
+	struct v4l2_subdev_route *route;
+	struct v4l2_subdev_state *state;
+	int ret;
+
+	ret = csi2rx_get_frame_desc_from_source(csi2rx, &source_fd);
+	if (ret)
+		return ret;
+
+	fd->type = V4L2_MBUS_FRAME_DESC_TYPE_CSI2;
+
+	state = v4l2_subdev_lock_and_get_active_state(subdev);
+
+	for_each_active_route(&state->routing, route) {
+		struct v4l2_mbus_frame_desc_entry *source_entry = NULL;
+		unsigned int i;
+
+		if (route->source_pad != pad)
+			continue;
+
+		for (i = 0; i < source_fd.num_entries; i++) {
+			if (source_fd.entry[i].stream == route->sink_stream) {
+				source_entry = &source_fd.entry[i];
+				break;
+			}
+		}
+
+		if (!source_entry) {
+			dev_err(csi2rx->dev,
+				"Failed to find stream from source frame desc\n");
+			ret = -EPIPE;
+			goto err_missing_stream;
+		}
+
+		fd->entry[fd->num_entries].stream = route->source_stream;
+		fd->entry[fd->num_entries].flags = source_entry->flags;
+		fd->entry[fd->num_entries].length = source_entry->length;
+		fd->entry[fd->num_entries].pixelcode = source_entry->pixelcode;
+		fd->entry[fd->num_entries].bus.csi2.vc =
+			source_entry->bus.csi2.vc;
+		fd->entry[fd->num_entries].bus.csi2.dt =
+			source_entry->bus.csi2.dt;
+
+		fd->num_entries++;
+	}
+
+err_missing_stream:
+	v4l2_subdev_unlock_state(state);
 
-	return csi2rx_get_frame_desc_from_source(csi2rx, fd);
+	return ret;
 }
 
 static const struct v4l2_subdev_pad_ops csi2rx_pad_ops = {
-	.enum_mbus_code	= csi2rx_enum_mbus_code,
-	.get_fmt	= v4l2_subdev_get_fmt,
-	.set_fmt	= csi2rx_set_fmt,
-	.enable_streams         = csi2rx_enable_streams,
-	.disable_streams        = csi2rx_disable_streams,
-	.get_frame_desc	= csi2rx_get_frame_desc,
+	.enum_mbus_code		= csi2rx_enum_mbus_code,
+	.get_fmt		= v4l2_subdev_get_fmt,
+	.set_fmt		= csi2rx_set_fmt,
+	.get_frame_desc		= csi2rx_get_frame_desc,
+	.set_routing		= csi2rx_set_routing,
+	.enable_streams		= csi2rx_enable_streams,
+	.disable_streams	= csi2rx_disable_streams,
+};
+
+static const struct v4l2_subdev_video_ops csi2rx_video_ops = {
+	.s_stream	= csi2rx_s_stream_fallback,
 };
 
 static const struct v4l2_subdev_core_ops csi2rx_core_ops = {
@@ -649,6 +836,7 @@ static const struct v4l2_subdev_core_ops csi2rx_core_ops = {
 
 static const struct v4l2_subdev_ops csi2rx_subdev_ops = {
 	.core		= &csi2rx_core_ops,
+	.video		= &csi2rx_video_ops,
 	.pad		= &csi2rx_pad_ops,
 };
 
@@ -876,7 +1064,8 @@ static int csi2rx_probe(struct platform_device *pdev)
 	csi2rx->pads[CSI2RX_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
 	for (i = CSI2RX_PAD_SOURCE_STREAM0; i < CSI2RX_PAD_MAX; i++)
 		csi2rx->pads[i].flags = MEDIA_PAD_FL_SOURCE;
-	csi2rx->subdev.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	csi2rx->subdev.flags = V4L2_SUBDEV_FL_HAS_DEVNODE |
+		V4L2_SUBDEV_FL_STREAMS;
 	csi2rx->subdev.entity.ops = &csi2rx_media_ops;
 
 	ret = media_entity_pads_init(&csi2rx->subdev.entity, CSI2RX_PAD_MAX,
-- 
2.34.1


