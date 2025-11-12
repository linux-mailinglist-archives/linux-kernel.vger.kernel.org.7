Return-Path: <linux-kernel+bounces-897148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88220C521F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E863934D7C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBAB314B8F;
	Wed, 12 Nov 2025 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YCXa1FGm"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D84E314B87;
	Wed, 12 Nov 2025 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948541; cv=fail; b=YcVJVMW88Ap8Q8tdvum56ay3JkvAXVYD+WqF2zj2GZb+loa40tYXHUfjZD8h9ZRXGXUN0bU1OMIyE/Q6w4+quycB/EGaqk6EfnjXwQtNU4rS/iRLq04Q55+rbnlJ3zvRQ5d1lTZCpIPkZjPffDXCpf85OQy2z2AWsyomeatr1nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948541; c=relaxed/simple;
	bh=wVop2nav+d4ORBxkvdYrZ2TjQx/iSrxQZPxMGtZLp3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AbwBaZ7CucRLLJ1Z51Us4/97i9GBX8TnLYy6qzXRN6QCm6bXD2LFUqpk5VQIP54wCUGlrzD3CUVreMZBGcGqhJtIWSOS5KngEYAJN+zJFQ9/GLgX7Ps+A26EvzAHg8gmTWdVSo+GkKwEYkpEr9PydlgAdQ9eg3oKJL03QcaDbWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YCXa1FGm; arc=fail smtp.client-ip=52.101.53.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yc7/z4lto0lTKhQs5UwIGMZrN5JFW527dyj0DNJk5PTHhIWSbkW7waV1V+MK5Iqs/WBSkfA76Eto4sgtUs0QbEj22mJEdiTJCRNN63UuY1MOIcqctB33v+d+nmkVZNRGuUvtP0aouFcmwJakNKI4Ea4TRAplesx4FE9O6WjRBhLj2zxRvv05JHLteIvW9j4EN2CZ2OMiUl2uRfWjeKNeALyiMxFq0ArEtRp4QYHF/I8Cl7Ve4ifPeKhojJ1IjEQXuQNyWg9pIHJ36A6JNvGWw1ugcAh04XQxxsoEmdEIRrMWYl0+9NhrGKPZUZAyD2zZH2UzjnzWhKRt0PZI5fXbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bXk63iDezCt2psOMOzpLnVMeSYg+MD9VY7fXVcl8jQ=;
 b=DxlYKjlU8mcFVYA3sG9UyCBJNDS4MeJbXi48+Ww/Ii1B7WbCfX5QundOqZlB9IBRD4M/5yZAu2bQHgKSOMAu1wmpKl0RANzxACJQC9Fql4Ymzp6UWaUkRib4TSrh11Su7T5x3/sf5xfw3SWG/ShGiC6KdyPowm0nUl9kITa1YzsMt5OOSC3XZTmfa3Scjvm9F+Lteulj6HqF20AhUVQVsG4Xrk4VLhi6NEEteTfBpUfvrGKcLxXW+WHk2FspEGJ7EcwWfE6g9wjCqx1lKG94Gmn3XVLxkQu0Azm/FoQGURqLummz8a31xvNCoF5vwNZue6bn8fRhbjvszqxKSdIY7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bXk63iDezCt2psOMOzpLnVMeSYg+MD9VY7fXVcl8jQ=;
 b=YCXa1FGmWbm6Bt8ohg2VgSUixwvxgU4Xg+5qNicGfjliiKe5KiPTbjBXsCnMWEjKOjEv5FRsEVYiJ4tPOo7QILQIWONJ9r4GfEbObll7V8VDvTkvSCqa7I3yrt8yQiai10+iA9Q+v1md5bj73cAiHEGxZ8BpNzi4WXUDiD+EMQc=
Received: from SJ0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:33a::27)
 by SJ0PR10MB7692.namprd10.prod.outlook.com (2603:10b6:a03:51a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 11:55:34 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::cc) by SJ0PR03CA0022.outlook.office365.com
 (2603:10b6:a03:33a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 11:55:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:55:32 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:55:27 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:55:26 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:55:26 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxbr2638977;
	Wed, 12 Nov 2025 05:55:20 -0600
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
Subject: [PATCH v8 03/18] media: ti: j721e-csi2rx: separate out device and context
Date: Wed, 12 Nov 2025 17:24:44 +0530
Message-ID: <20251112115459.2479225-4-r-donadkar@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|SJ0PR10MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: e59d94b0-3c50-4afb-1d98-08de21e2623e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9u//jBVbfrY+p1DjGzv2YbTpP1O5zwgQmpvWUXEqJ2ZxqxZ1ZjvrnttRk3qC?=
 =?us-ascii?Q?k/1d3WBdDxjuC33cU1jjDWUEX16qf3YMBopn1ktfNRrs7d2sRo3QdcYPfk6K?=
 =?us-ascii?Q?7KNFYgODFMyaWPzfC9cNg5aPLC/cJBZCn32ob3QjK3L9ONYCFRtzESwDJEls?=
 =?us-ascii?Q?T+JI9yRe+io+lY98WMrY1XNX0zLsWpjQtERMaotYsI1MVCwqyAqo+4ILCeY6?=
 =?us-ascii?Q?eAzIoZX2jy589Nn/TcXajZxEuXAUJpXTvYqwEqFNgq84g8hk5bG8m/+tAA9d?=
 =?us-ascii?Q?OkO7cF4kMYEhMukLg7TdewfWvN36uMJlze0dTIyHVCClzVu0vAbklhEho195?=
 =?us-ascii?Q?sWf4YC2CewiW78iIk/tjiXBHW7GqpzT7eBmVtsytj9Nc7gVEA1R9uD4meZGb?=
 =?us-ascii?Q?7RRN/qvkbC6U6y5fP03KVZHB5bM+mNlB2KfnvjS23/Oz6vrBYQPUCe4hABhe?=
 =?us-ascii?Q?J0cxfBpZwDqp5b2G0rBlI1I2FjjSBPZJaZ9qf+8MvcGtMQ2v4ZxIJsuOwjrM?=
 =?us-ascii?Q?YwFgYoYr8sYfMcwBnMb3OFBvycgA7SQ/DGBJho/diCd+JS9jMnfW5hoS4TbK?=
 =?us-ascii?Q?At0mdbw4as2Q1OvYA33JUAw4FwGzlH++DOLZNc/cYU/5UBnxFygHywZY/f3Y?=
 =?us-ascii?Q?COSOdHlTLxQXIAzhvUR143gRFeRevUVdiyH8FhHPDrBv5NCIla8spa3J258P?=
 =?us-ascii?Q?GWnxCG3efwASUO9cLEbfSRDKaIaEehOkbEX9vqgZS1Y/M4xSPAs3g2Y4ylO6?=
 =?us-ascii?Q?G8pQFmlRu8LlIJW71fXzJ59Atsjtq8YQ6O7Dp4HfTSOhOgavUD5zG18elFXp?=
 =?us-ascii?Q?dhLy7jD0rpHCg7Vj1UQsEZreRRBcMfRwWReupjMijMGrpq4n/iBgzKaC53wD?=
 =?us-ascii?Q?1A/LuG+N45DtXN6wrmCoRw4SXFy/0VrEPrNmEGNLdwkB9zXxCin5lSfJfeGq?=
 =?us-ascii?Q?1xQ8bFFUgUUICkFdriGSyuDJGNsS6n1xnZ/mnETuKxrw27XLpbYEufIBQnLC?=
 =?us-ascii?Q?1axWZwGVeBo0GBF7H5Ohxsan15SC/rqFJUC3jo/1mVhnoWpnPactHKvSZdxl?=
 =?us-ascii?Q?FiX0iASsHYNbyuxoHZJn8iwAzpd7JQ+4rtSC9I1pmEiPayCFwqMG5XGQw4vf?=
 =?us-ascii?Q?xRwmuMdR+FjipN0KQksEaFNjAJGLwQhh5+BCwzzM84YOOWfvcBBg6953KWzn?=
 =?us-ascii?Q?1gd6dGCWOh5vw6FJFZF4Sj87pgQlGu27hNEnsOYqklXKYzO7nUeOMtA4Duae?=
 =?us-ascii?Q?y6gs/8hx0MTq9c2e9fGSI00Tu2BHx19SbNUL/EDbgmTHUCLPMCwSlA/G5GBv?=
 =?us-ascii?Q?1+y8hfZBO09rQgq48+9QEYozGLMNV3csuqGErTwijO+XEv49DgiVfFjJ8OLj?=
 =?us-ascii?Q?rkqh0NR2DqXUNdghuMnfzY/vOWNnlSVukPxfRwc+QoPoppKXsl0RA3Ffbtgz?=
 =?us-ascii?Q?89ypVhcUiKif9gpqDh4aH8wxv3HPPL9Nf2WXD6eNnIraX4jemyvyAbQ1ZCll?=
 =?us-ascii?Q?kMoCfNGrEqKhJjQ5z/4zNcuIDhPrSuhayhkiqajJKnyo8hoKWin+Es0nddNC?=
 =?us-ascii?Q?0I6TgMAV+iFjsT0+HHs=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:55:32.6961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e59d94b0-3c50-4afb-1d98-08de21e2623e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7692

From: Jai Luthra <j-luthra@ti.com>

The TI CSI2RX wrapper has two parts: the main device and the DMA
contexts. The driver was originally written with single camera capture
in mind, so only one DMA context was needed. For the sake of simplicity,
the context specific stuff was not modeled different to the main device.

To enable multiplexed stream capture, the contexts need to be separated
out from the main device. Create a struct ti_csi2rx_ctx that holds the
DMA context specific things. Separate out functions handling the device
and context related functionality.

Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Co-developed-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
---
 .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 423 ++++++++++--------
 1 file changed, 234 insertions(+), 189 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 710d05a053539..23717a3b6c4cf 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -43,6 +43,8 @@
 #define SHIM_PSI_CFG0_DST_TAG		GENMASK(31, 16)
 
 #define TI_CSI2RX_MAX_PIX_PER_CLK	4
+#define TI_CSI2RX_NUM_CTX		1
+
 /*
  * There are no hard limits on the width or height. The DMA engine can handle
  * all sizes. The max width and height are arbitrary numbers for this driver.
@@ -69,7 +71,7 @@ struct ti_csi2rx_buffer {
 	/* Common v4l2 buffer. Must be first. */
 	struct vb2_v4l2_buffer		vb;
 	struct list_head		list;
-	struct ti_csi2rx_dev		*csi;
+	struct ti_csi2rx_ctx		*ctx;
 };
 
 enum ti_csi2rx_dma_state {
@@ -89,30 +91,38 @@ struct ti_csi2rx_dma {
 	 * Queue of buffers submitted to DMA engine.
 	 */
 	struct list_head		submitted;
-	/* Buffer to drain stale data from PSI-L endpoint */
-	struct {
-		void			*vaddr;
-		dma_addr_t		paddr;
-		size_t			len;
-	} drain;
+};
+
+struct ti_csi2rx_dev;
+
+struct ti_csi2rx_ctx {
+	struct ti_csi2rx_dev		*csi;
+	struct video_device		vdev;
+	struct vb2_queue		vidq;
+	struct mutex			mutex; /* To serialize ioctls. */
+	struct v4l2_format		v_fmt;
+	struct ti_csi2rx_dma		dma;
+	u32				sequence;
+	u32				idx;
 };
 
 struct ti_csi2rx_dev {
 	struct device			*dev;
 	void __iomem			*shim;
 	struct v4l2_device		v4l2_dev;
-	struct video_device		vdev;
 	struct media_device		mdev;
 	struct media_pipeline		pipe;
 	struct media_pad		pad;
 	struct v4l2_async_notifier	notifier;
 	struct v4l2_subdev		*source;
-	struct vb2_queue		vidq;
-	struct mutex			mutex; /* To serialize ioctls. */
-	struct v4l2_format		v_fmt;
-	struct ti_csi2rx_dma		dma;
-	u32				sequence;
+	struct ti_csi2rx_ctx		ctx[TI_CSI2RX_NUM_CTX];
 	u8				pix_per_clk;
+	/* Buffer to drain stale data from PSI-L endpoint */
+	struct {
+		void			*vaddr;
+		dma_addr_t		paddr;
+		size_t			len;
+	} drain;
 };
 
 static const struct ti_csi2rx_fmt ti_csi2rx_formats[] = {
@@ -218,7 +228,7 @@ static const struct ti_csi2rx_fmt ti_csi2rx_formats[] = {
 };
 
 /* Forward declaration needed by ti_csi2rx_dma_callback. */
-static int ti_csi2rx_start_dma(struct ti_csi2rx_dev *csi,
+static int ti_csi2rx_start_dma(struct ti_csi2rx_ctx *ctx,
 			       struct ti_csi2rx_buffer *buf);
 
 static const struct ti_csi2rx_fmt *find_format_by_fourcc(u32 pixelformat)
@@ -301,7 +311,7 @@ static int ti_csi2rx_enum_fmt_vid_cap(struct file *file, void *priv,
 static int ti_csi2rx_g_fmt_vid_cap(struct file *file, void *priv,
 				   struct v4l2_format *f)
 {
-	struct ti_csi2rx_dev *csi = video_drvdata(file);
+	struct ti_csi2rx_ctx *csi = video_drvdata(file);
 
 	*f = csi->v_fmt;
 
@@ -332,7 +342,7 @@ static int ti_csi2rx_try_fmt_vid_cap(struct file *file, void *priv,
 static int ti_csi2rx_s_fmt_vid_cap(struct file *file, void *priv,
 				   struct v4l2_format *f)
 {
-	struct ti_csi2rx_dev *csi = video_drvdata(file);
+	struct ti_csi2rx_ctx *csi = video_drvdata(file);
 	struct vb2_queue *q = &csi->vidq;
 	int ret;
 
@@ -410,26 +420,35 @@ static int csi_async_notifier_bound(struct v4l2_async_notifier *notifier,
 static int csi_async_notifier_complete(struct v4l2_async_notifier *notifier)
 {
 	struct ti_csi2rx_dev *csi = dev_get_drvdata(notifier->v4l2_dev->dev);
-	struct video_device *vdev = &csi->vdev;
-	int ret;
+	int ret, i;
 
-	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
-	if (ret)
-		return ret;
-
-	ret = media_create_pad_link(&csi->source->entity, CSI2RX_BRIDGE_SOURCE_PAD,
-				    &vdev->entity, csi->pad.index,
-				    MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
+	for (i = 0; i < TI_CSI2RX_NUM_CTX; i++) {
+		struct ti_csi2rx_ctx *ctx = &csi->ctx[i];
+		struct video_device *vdev = &ctx->vdev;
 
-	if (ret) {
-		video_unregister_device(vdev);
-		return ret;
+		ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
+		if (ret)
+			goto unregister_dev;
 	}
 
+	ret = media_create_pad_link(&csi->source->entity,
+				    CSI2RX_BRIDGE_SOURCE_PAD,
+				    &csi->ctx[0].vdev.entity, csi->pad.index,
+				    MEDIA_LNK_FL_IMMUTABLE |
+				    MEDIA_LNK_FL_ENABLED);
+	if (ret)
+		goto unregister_dev;
+
 	ret = v4l2_device_register_subdev_nodes(&csi->v4l2_dev);
 	if (ret)
-		video_unregister_device(vdev);
+		goto unregister_dev;
 
+	return 0;
+
+unregister_dev:
+	i--;
+	for (; i >= 0; i--)
+		video_unregister_device(&csi->ctx[i].vdev);
 	return ret;
 }
 
@@ -474,13 +493,14 @@ static int ti_csi2rx_notifier_register(struct ti_csi2rx_dev *csi)
 }
 
 /* Request maximum possible pixels per clock from the bridge */
-static void ti_csi2rx_request_max_ppc(struct ti_csi2rx_dev *csi)
+static void ti_csi2rx_request_max_ppc(struct ti_csi2rx_ctx *ctx)
 {
+	struct ti_csi2rx_dev *csi = ctx->csi;
 	u8 ppc = TI_CSI2RX_MAX_PIX_PER_CLK;
 	struct media_pad *pad;
 	int ret;
 
-	pad = media_entity_remote_source_pad_unique(&csi->vdev.entity);
+	pad = media_entity_remote_source_pad_unique(&ctx->vdev.entity);
 	if (IS_ERR(pad))
 		return;
 
@@ -493,19 +513,20 @@ static void ti_csi2rx_request_max_ppc(struct ti_csi2rx_dev *csi)
 	}
 }
 
-static void ti_csi2rx_setup_shim(struct ti_csi2rx_dev *csi)
+static void ti_csi2rx_setup_shim(struct ti_csi2rx_ctx *ctx)
 {
+	struct ti_csi2rx_dev *csi = ctx->csi;
 	const struct ti_csi2rx_fmt *fmt;
 	unsigned int reg;
 
-	fmt = find_format_by_fourcc(csi->v_fmt.fmt.pix.pixelformat);
+	fmt = find_format_by_fourcc(ctx->v_fmt.fmt.pix.pixelformat);
 
 	/* De-assert the pixel interface reset. */
 	reg = SHIM_CNTL_PIX_RST;
 	writel(reg, csi->shim + SHIM_CNTL);
 
 	/* Negotiate pixel count from the source */
-	ti_csi2rx_request_max_ppc(csi);
+	ti_csi2rx_request_max_ppc(ctx);
 
 	reg = SHIM_DMACNTX_EN;
 	reg |= FIELD_PREP(SHIM_DMACNTX_FMT, fmt->csi_dt);
@@ -572,8 +593,9 @@ static void ti_csi2rx_drain_callback(void *param)
  * To prevent that stale data corrupting the subsequent transactions, it is
  * required to issue DMA requests to drain it out.
  */
-static int ti_csi2rx_drain_dma(struct ti_csi2rx_dev *csi)
+static int ti_csi2rx_drain_dma(struct ti_csi2rx_ctx *ctx)
 {
+	struct ti_csi2rx_dev *csi = ctx->csi;
 	struct dma_async_tx_descriptor *desc;
 	struct completion drain_complete;
 	dma_cookie_t cookie;
@@ -581,8 +603,8 @@ static int ti_csi2rx_drain_dma(struct ti_csi2rx_dev *csi)
 
 	init_completion(&drain_complete);
 
-	desc = dmaengine_prep_slave_single(csi->dma.chan, csi->dma.drain.paddr,
-					   csi->dma.drain.len, DMA_DEV_TO_MEM,
+	desc = dmaengine_prep_slave_single(ctx->dma.chan, csi->drain.paddr,
+					   csi->drain.len, DMA_DEV_TO_MEM,
 					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
 		ret = -EIO;
@@ -597,11 +619,11 @@ static int ti_csi2rx_drain_dma(struct ti_csi2rx_dev *csi)
 	if (ret)
 		goto out;
 
-	dma_async_issue_pending(csi->dma.chan);
+	dma_async_issue_pending(ctx->dma.chan);
 
 	if (!wait_for_completion_timeout(&drain_complete,
 					 msecs_to_jiffies(DRAIN_TIMEOUT_MS))) {
-		dmaengine_terminate_sync(csi->dma.chan);
+		dmaengine_terminate_sync(ctx->dma.chan);
 		dev_dbg(csi->dev, "DMA transfer timed out for drain buffer\n");
 		ret = -ETIMEDOUT;
 		goto out;
@@ -613,8 +635,9 @@ static int ti_csi2rx_drain_dma(struct ti_csi2rx_dev *csi)
 static void ti_csi2rx_dma_callback(void *param)
 {
 	struct ti_csi2rx_buffer *buf = param;
-	struct ti_csi2rx_dev *csi = buf->csi;
-	struct ti_csi2rx_dma *dma = &csi->dma;
+	struct ti_csi2rx_ctx *ctx = buf->ctx;
+	struct ti_csi2rx_dev *csi = ctx->csi;
+	struct ti_csi2rx_dma *dma = &ctx->dma;
 	unsigned long flags;
 
 	/*
@@ -622,7 +645,7 @@ static void ti_csi2rx_dma_callback(void *param)
 	 * hardware monitor registers.
 	 */
 	buf->vb.vb2_buf.timestamp = ktime_get_ns();
-	buf->vb.sequence = csi->sequence++;
+	buf->vb.sequence = ctx->sequence++;
 
 	spin_lock_irqsave(&dma->lock, flags);
 
@@ -634,7 +657,7 @@ static void ti_csi2rx_dma_callback(void *param)
 	while (!list_empty(&dma->queue)) {
 		buf = list_entry(dma->queue.next, struct ti_csi2rx_buffer, list);
 
-		if (ti_csi2rx_start_dma(csi, buf)) {
+		if (ti_csi2rx_start_dma(ctx, buf)) {
 			dev_err(csi->dev, "Failed to queue the next buffer for DMA\n");
 			list_del(&buf->list);
 			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
@@ -649,17 +672,17 @@ static void ti_csi2rx_dma_callback(void *param)
 	spin_unlock_irqrestore(&dma->lock, flags);
 }
 
-static int ti_csi2rx_start_dma(struct ti_csi2rx_dev *csi,
+static int ti_csi2rx_start_dma(struct ti_csi2rx_ctx *ctx,
 			       struct ti_csi2rx_buffer *buf)
 {
 	unsigned long addr;
 	struct dma_async_tx_descriptor *desc;
-	size_t len = csi->v_fmt.fmt.pix.sizeimage;
+	size_t len = ctx->v_fmt.fmt.pix.sizeimage;
 	dma_cookie_t cookie;
 	int ret = 0;
 
 	addr = vb2_dma_contig_plane_dma_addr(&buf->vb.vb2_buf, 0);
-	desc = dmaengine_prep_slave_single(csi->dma.chan, addr, len,
+	desc = dmaengine_prep_slave_single(ctx->dma.chan, addr, len,
 					   DMA_DEV_TO_MEM,
 					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc)
@@ -673,20 +696,20 @@ static int ti_csi2rx_start_dma(struct ti_csi2rx_dev *csi,
 	if (ret)
 		return ret;
 
-	dma_async_issue_pending(csi->dma.chan);
+	dma_async_issue_pending(ctx->dma.chan);
 
 	return 0;
 }
 
-static void ti_csi2rx_stop_dma(struct ti_csi2rx_dev *csi)
+static void ti_csi2rx_stop_dma(struct ti_csi2rx_ctx *ctx)
 {
-	struct ti_csi2rx_dma *dma = &csi->dma;
+	struct ti_csi2rx_dma *dma = &ctx->dma;
 	enum ti_csi2rx_dma_state state;
 	unsigned long flags;
 	int ret;
 
 	spin_lock_irqsave(&dma->lock, flags);
-	state = csi->dma.state;
+	state = ctx->dma.state;
 	dma->state = TI_CSI2RX_DMA_STOPPED;
 	spin_unlock_irqrestore(&dma->lock, flags);
 
@@ -697,30 +720,30 @@ static void ti_csi2rx_stop_dma(struct ti_csi2rx_dev *csi)
 		 * is stopped, as the module-level pixel reset cannot be
 		 * enforced before terminating DMA.
 		 */
-		ret = ti_csi2rx_drain_dma(csi);
+		ret = ti_csi2rx_drain_dma(ctx);
 		if (ret && ret != -ETIMEDOUT)
-			dev_warn(csi->dev,
+			dev_warn(ctx->csi->dev,
 				 "Failed to drain DMA. Next frame might be bogus\n");
 	}
 
-	ret = dmaengine_terminate_sync(csi->dma.chan);
+	ret = dmaengine_terminate_sync(ctx->dma.chan);
 	if (ret)
-		dev_err(csi->dev, "Failed to stop DMA: %d\n", ret);
+		dev_err(ctx->csi->dev, "Failed to stop DMA: %d\n", ret);
 }
 
-static void ti_csi2rx_cleanup_buffers(struct ti_csi2rx_dev *csi,
+static void ti_csi2rx_cleanup_buffers(struct ti_csi2rx_ctx *ctx,
 				      enum vb2_buffer_state state)
 {
-	struct ti_csi2rx_dma *dma = &csi->dma;
+	struct ti_csi2rx_dma *dma = &ctx->dma;
 	struct ti_csi2rx_buffer *buf, *tmp;
 	unsigned long flags;
 
 	spin_lock_irqsave(&dma->lock, flags);
-	list_for_each_entry_safe(buf, tmp, &csi->dma.queue, list) {
+	list_for_each_entry_safe(buf, tmp, &ctx->dma.queue, list) {
 		list_del(&buf->list);
 		vb2_buffer_done(&buf->vb.vb2_buf, state);
 	}
-	list_for_each_entry_safe(buf, tmp, &csi->dma.submitted, list) {
+	list_for_each_entry_safe(buf, tmp, &ctx->dma.submitted, list) {
 		list_del(&buf->list);
 		vb2_buffer_done(&buf->vb.vb2_buf, state);
 	}
@@ -731,8 +754,8 @@ static int ti_csi2rx_queue_setup(struct vb2_queue *q, unsigned int *nbuffers,
 				 unsigned int *nplanes, unsigned int sizes[],
 				 struct device *alloc_devs[])
 {
-	struct ti_csi2rx_dev *csi = vb2_get_drv_priv(q);
-	unsigned int size = csi->v_fmt.fmt.pix.sizeimage;
+	struct ti_csi2rx_ctx *ctx = vb2_get_drv_priv(q);
+	unsigned int size = ctx->v_fmt.fmt.pix.sizeimage;
 
 	if (*nplanes) {
 		if (sizes[0] < size)
@@ -748,11 +771,11 @@ static int ti_csi2rx_queue_setup(struct vb2_queue *q, unsigned int *nbuffers,
 
 static int ti_csi2rx_buffer_prepare(struct vb2_buffer *vb)
 {
-	struct ti_csi2rx_dev *csi = vb2_get_drv_priv(vb->vb2_queue);
-	unsigned long size = csi->v_fmt.fmt.pix.sizeimage;
+	struct ti_csi2rx_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
+	unsigned long size = ctx->v_fmt.fmt.pix.sizeimage;
 
 	if (vb2_plane_size(vb, 0) < size) {
-		dev_err(csi->dev, "Data will not fit into plane\n");
+		dev_err(ctx->csi->dev, "Data will not fit into plane\n");
 		return -EINVAL;
 	}
 
@@ -762,15 +785,15 @@ static int ti_csi2rx_buffer_prepare(struct vb2_buffer *vb)
 
 static void ti_csi2rx_buffer_queue(struct vb2_buffer *vb)
 {
-	struct ti_csi2rx_dev *csi = vb2_get_drv_priv(vb->vb2_queue);
+	struct ti_csi2rx_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
 	struct ti_csi2rx_buffer *buf;
-	struct ti_csi2rx_dma *dma = &csi->dma;
+	struct ti_csi2rx_dma *dma = &ctx->dma;
 	bool restart_dma = false;
 	unsigned long flags = 0;
 	int ret;
 
 	buf = container_of(vb, struct ti_csi2rx_buffer, vb.vb2_buf);
-	buf->csi = csi;
+	buf->ctx = ctx;
 
 	spin_lock_irqsave(&dma->lock, flags);
 	/*
@@ -799,18 +822,18 @@ static void ti_csi2rx_buffer_queue(struct vb2_buffer *vb)
 		 * the application and will only confuse it. Issue a DMA
 		 * transaction to drain that up.
 		 */
-		ret = ti_csi2rx_drain_dma(csi);
+		ret = ti_csi2rx_drain_dma(ctx);
 		if (ret && ret != -ETIMEDOUT)
-			dev_warn(csi->dev,
+			dev_warn(ctx->csi->dev,
 				 "Failed to drain DMA. Next frame might be bogus\n");
 
 		spin_lock_irqsave(&dma->lock, flags);
-		ret = ti_csi2rx_start_dma(csi, buf);
+		ret = ti_csi2rx_start_dma(ctx, buf);
 		if (ret) {
 			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
 			dma->state = TI_CSI2RX_DMA_IDLE;
 			spin_unlock_irqrestore(&dma->lock, flags);
-			dev_err(csi->dev, "Failed to start DMA: %d\n", ret);
+			dev_err(ctx->csi->dev, "Failed to start DMA: %d\n", ret);
 		} else {
 			list_add_tail(&buf->list, &dma->submitted);
 			spin_unlock_irqrestore(&dma->lock, flags);
@@ -820,8 +843,9 @@ static void ti_csi2rx_buffer_queue(struct vb2_buffer *vb)
 
 static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 {
-	struct ti_csi2rx_dev *csi = vb2_get_drv_priv(vq);
-	struct ti_csi2rx_dma *dma = &csi->dma;
+	struct ti_csi2rx_ctx *ctx = vb2_get_drv_priv(vq);
+	struct ti_csi2rx_dev *csi = ctx->csi;
+	struct ti_csi2rx_dma *dma = &ctx->dma;
 	struct ti_csi2rx_buffer *buf;
 	unsigned long flags;
 	int ret = 0;
@@ -833,18 +857,18 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 	if (ret)
 		return ret;
 
-	ret = video_device_pipeline_start(&csi->vdev, &csi->pipe);
+	ret = video_device_pipeline_start(&ctx->vdev, &csi->pipe);
 	if (ret)
 		goto err;
 
-	ti_csi2rx_setup_shim(csi);
+	ti_csi2rx_setup_shim(ctx);
 
-	csi->sequence = 0;
+	ctx->sequence = 0;
 
 	spin_lock_irqsave(&dma->lock, flags);
 	buf = list_entry(dma->queue.next, struct ti_csi2rx_buffer, list);
 
-	ret = ti_csi2rx_start_dma(csi, buf);
+	ret = ti_csi2rx_start_dma(ctx, buf);
 	if (ret) {
 		dev_err(csi->dev, "Failed to start DMA: %d\n", ret);
 		spin_unlock_irqrestore(&dma->lock, flags);
@@ -862,22 +886,23 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 	return 0;
 
 err_dma:
-	ti_csi2rx_stop_dma(csi);
+	ti_csi2rx_stop_dma(ctx);
 err_pipeline:
-	video_device_pipeline_stop(&csi->vdev);
+	video_device_pipeline_stop(&ctx->vdev);
 	writel(0, csi->shim + SHIM_CNTL);
 	writel(0, csi->shim + SHIM_DMACNTX);
 err:
-	ti_csi2rx_cleanup_buffers(csi, VB2_BUF_STATE_QUEUED);
+	ti_csi2rx_cleanup_buffers(ctx, VB2_BUF_STATE_QUEUED);
 	return ret;
 }
 
 static void ti_csi2rx_stop_streaming(struct vb2_queue *vq)
 {
-	struct ti_csi2rx_dev *csi = vb2_get_drv_priv(vq);
+	struct ti_csi2rx_ctx *ctx = vb2_get_drv_priv(vq);
+	struct ti_csi2rx_dev *csi = ctx->csi;
 	int ret;
 
-	video_device_pipeline_stop(&csi->vdev);
+	video_device_pipeline_stop(&ctx->vdev);
 
 	writel(0, csi->shim + SHIM_CNTL);
 	writel(0, csi->shim + SHIM_DMACNTX);
@@ -886,8 +911,8 @@ static void ti_csi2rx_stop_streaming(struct vb2_queue *vq)
 	if (ret)
 		dev_err(csi->dev, "Failed to stop subdev stream\n");
 
-	ti_csi2rx_stop_dma(csi);
-	ti_csi2rx_cleanup_buffers(csi, VB2_BUF_STATE_ERROR);
+	ti_csi2rx_stop_dma(ctx);
+	ti_csi2rx_cleanup_buffers(ctx, VB2_BUF_STATE_ERROR);
 }
 
 static const struct vb2_ops csi_vb2_qops = {
@@ -898,20 +923,43 @@ static const struct vb2_ops csi_vb2_qops = {
 	.stop_streaming = ti_csi2rx_stop_streaming,
 };
 
-static int ti_csi2rx_init_vb2q(struct ti_csi2rx_dev *csi)
+static void ti_csi2rx_cleanup_v4l2(struct ti_csi2rx_dev *csi)
 {
-	struct vb2_queue *q = &csi->vidq;
+	media_device_unregister(&csi->mdev);
+	v4l2_device_unregister(&csi->v4l2_dev);
+	media_device_cleanup(&csi->mdev);
+}
+
+static void ti_csi2rx_cleanup_notifier(struct ti_csi2rx_dev *csi)
+{
+	v4l2_async_nf_unregister(&csi->notifier);
+	v4l2_async_nf_cleanup(&csi->notifier);
+}
+
+static void ti_csi2rx_cleanup_ctx(struct ti_csi2rx_ctx *ctx)
+{
+	dma_release_channel(ctx->dma.chan);
+	vb2_queue_release(&ctx->vidq);
+
+	video_unregister_device(&ctx->vdev);
+
+	mutex_destroy(&ctx->mutex);
+}
+
+static int ti_csi2rx_init_vb2q(struct ti_csi2rx_ctx *ctx)
+{
+	struct vb2_queue *q = &ctx->vidq;
 	int ret;
 
 	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	q->io_modes = VB2_MMAP | VB2_DMABUF;
-	q->drv_priv = csi;
+	q->drv_priv = ctx;
 	q->buf_struct_size = sizeof(struct ti_csi2rx_buffer);
 	q->ops = &csi_vb2_qops;
 	q->mem_ops = &vb2_dma_contig_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->dev = dmaengine_get_dma_device(csi->dma.chan);
-	q->lock = &csi->mutex;
+	q->dev = dmaengine_get_dma_device(ctx->dma.chan);
+	q->lock = &ctx->mutex;
 	q->min_queued_buffers = 1;
 	q->allow_cache_hints = 1;
 
@@ -919,7 +967,7 @@ static int ti_csi2rx_init_vb2q(struct ti_csi2rx_dev *csi)
 	if (ret)
 		return ret;
 
-	csi->vdev.queue = q;
+	ctx->vdev.queue = q;
 
 	return 0;
 }
@@ -928,8 +976,9 @@ static int ti_csi2rx_link_validate(struct media_link *link)
 {
 	struct media_entity *entity = link->sink->entity;
 	struct video_device *vdev = media_entity_to_video_device(entity);
-	struct ti_csi2rx_dev *csi = container_of(vdev, struct ti_csi2rx_dev, vdev);
-	struct v4l2_pix_format *csi_fmt = &csi->v_fmt.fmt.pix;
+	struct ti_csi2rx_ctx *ctx = container_of(vdev, struct ti_csi2rx_ctx, vdev);
+	struct ti_csi2rx_dev *csi = ctx->csi;
+	struct v4l2_pix_format *csi_fmt = &ctx->v_fmt.fmt.pix;
 	struct v4l2_subdev_format source_fmt = {
 		.which	= V4L2_SUBDEV_FORMAT_ACTIVE,
 		.pad	= link->source->index,
@@ -982,47 +1031,63 @@ static const struct media_entity_operations ti_csi2rx_video_entity_ops = {
 	.link_validate = ti_csi2rx_link_validate,
 };
 
-static int ti_csi2rx_init_dma(struct ti_csi2rx_dev *csi)
+static int ti_csi2rx_init_dma(struct ti_csi2rx_ctx *ctx)
 {
 	struct dma_slave_config cfg = {
 		.src_addr_width = DMA_SLAVE_BUSWIDTH_16_BYTES,
 	};
 	int ret;
 
-	INIT_LIST_HEAD(&csi->dma.queue);
-	INIT_LIST_HEAD(&csi->dma.submitted);
-	spin_lock_init(&csi->dma.lock);
-
-	csi->dma.state = TI_CSI2RX_DMA_STOPPED;
+	ctx->dma.chan = dma_request_chan(ctx->csi->dev, "rx0");
+	if (IS_ERR(ctx->dma.chan))
+		return PTR_ERR(ctx->dma.chan);
 
-	csi->dma.chan = dma_request_chan(csi->dev, "rx0");
-	if (IS_ERR(csi->dma.chan))
-		return PTR_ERR(csi->dma.chan);
-
-	ret = dmaengine_slave_config(csi->dma.chan, &cfg);
+	ret = dmaengine_slave_config(ctx->dma.chan, &cfg);
 	if (ret) {
-		dma_release_channel(csi->dma.chan);
+		dma_release_channel(ctx->dma.chan);
 		return ret;
 	}
 
-	csi->dma.drain.len = DRAIN_BUFFER_SIZE;
-	csi->dma.drain.vaddr = dma_alloc_coherent(csi->dev, csi->dma.drain.len,
-						  &csi->dma.drain.paddr,
-						  GFP_KERNEL);
-	if (!csi->dma.drain.vaddr)
-		return -ENOMEM;
-
 	return 0;
 }
 
 static int ti_csi2rx_v4l2_init(struct ti_csi2rx_dev *csi)
 {
 	struct media_device *mdev = &csi->mdev;
-	struct video_device *vdev = &csi->vdev;
+	int ret;
+
+	mdev->dev = csi->dev;
+	mdev->hw_revision = 1;
+	strscpy(mdev->model, "TI-CSI2RX", sizeof(mdev->model));
+
+	media_device_init(mdev);
+
+	csi->v4l2_dev.mdev = mdev;
+
+	ret = v4l2_device_register(csi->dev, &csi->v4l2_dev);
+	if (ret)
+		return ret;
+
+	ret = media_device_register(mdev);
+	if (ret) {
+		v4l2_device_unregister(&csi->v4l2_dev);
+		media_device_cleanup(mdev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ti_csi2rx_init_ctx(struct ti_csi2rx_ctx *ctx)
+{
+	struct ti_csi2rx_dev *csi = ctx->csi;
+	struct video_device *vdev = &ctx->vdev;
 	const struct ti_csi2rx_fmt *fmt;
-	struct v4l2_pix_format *pix_fmt = &csi->v_fmt.fmt.pix;
+	struct v4l2_pix_format *pix_fmt = &ctx->v_fmt.fmt.pix;
 	int ret;
 
+	mutex_init(&ctx->mutex);
+
 	fmt = find_format_by_fourcc(V4L2_PIX_FMT_UYVY);
 	if (!fmt)
 		return -EINVAL;
@@ -1031,19 +1096,20 @@ static int ti_csi2rx_v4l2_init(struct ti_csi2rx_dev *csi)
 	pix_fmt->height = 480;
 	pix_fmt->field = V4L2_FIELD_NONE;
 	pix_fmt->colorspace = V4L2_COLORSPACE_SRGB;
-	pix_fmt->ycbcr_enc = V4L2_YCBCR_ENC_601;
-	pix_fmt->quantization = V4L2_QUANTIZATION_LIM_RANGE;
-	pix_fmt->xfer_func = V4L2_XFER_FUNC_SRGB;
-
-	ti_csi2rx_fill_fmt(fmt, &csi->v_fmt);
+	pix_fmt->ycbcr_enc = V4L2_YCBCR_ENC_601,
+	pix_fmt->quantization = V4L2_QUANTIZATION_LIM_RANGE,
+	pix_fmt->xfer_func = V4L2_XFER_FUNC_SRGB,
 
-	mdev->dev = csi->dev;
-	mdev->hw_revision = 1;
-	strscpy(mdev->model, "TI-CSI2RX", sizeof(mdev->model));
+	ti_csi2rx_fill_fmt(fmt, &ctx->v_fmt);
 
-	media_device_init(mdev);
+	csi->pad.flags = MEDIA_PAD_FL_SINK;
+	vdev->entity.ops = &ti_csi2rx_video_entity_ops;
+	ret = media_entity_pads_init(&ctx->vdev.entity, 1, &csi->pad);
+	if (ret)
+		return ret;
 
-	strscpy(vdev->name, TI_CSI2RX_MODULE_NAME, sizeof(vdev->name));
+	snprintf(vdev->name, sizeof(vdev->name), "%s context %u",
+		 dev_name(csi->dev), ctx->idx);
 	vdev->v4l2_dev = &csi->v4l2_dev;
 	vdev->vfl_dir = VFL_DIR_RX;
 	vdev->fops = &csi_fops;
@@ -1051,61 +1117,33 @@ static int ti_csi2rx_v4l2_init(struct ti_csi2rx_dev *csi)
 	vdev->release = video_device_release_empty;
 	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING |
 			    V4L2_CAP_IO_MC;
-	vdev->lock = &csi->mutex;
-	video_set_drvdata(vdev, csi);
-
-	csi->pad.flags = MEDIA_PAD_FL_SINK;
-	vdev->entity.ops = &ti_csi2rx_video_entity_ops;
-	ret = media_entity_pads_init(&csi->vdev.entity, 1, &csi->pad);
-	if (ret)
-		return ret;
+	vdev->lock = &ctx->mutex;
+	video_set_drvdata(vdev, ctx);
 
-	csi->v4l2_dev.mdev = mdev;
+	INIT_LIST_HEAD(&ctx->dma.queue);
+	INIT_LIST_HEAD(&ctx->dma.submitted);
+	spin_lock_init(&ctx->dma.lock);
+	ctx->dma.state = TI_CSI2RX_DMA_STOPPED;
 
-	ret = v4l2_device_register(csi->dev, &csi->v4l2_dev);
+	ret = ti_csi2rx_init_dma(ctx);
 	if (ret)
 		return ret;
 
-	ret = media_device_register(mdev);
-	if (ret) {
-		v4l2_device_unregister(&csi->v4l2_dev);
-		media_device_cleanup(mdev);
-		return ret;
-	}
+	ret = ti_csi2rx_init_vb2q(ctx);
+	if (ret)
+		goto cleanup_dma;
 
 	return 0;
-}
-
-static void ti_csi2rx_cleanup_dma(struct ti_csi2rx_dev *csi)
-{
-	dma_free_coherent(csi->dev, csi->dma.drain.len,
-			  csi->dma.drain.vaddr, csi->dma.drain.paddr);
-	csi->dma.drain.vaddr = NULL;
-	dma_release_channel(csi->dma.chan);
-}
-
-static void ti_csi2rx_cleanup_v4l2(struct ti_csi2rx_dev *csi)
-{
-	media_device_unregister(&csi->mdev);
-	v4l2_device_unregister(&csi->v4l2_dev);
-	media_device_cleanup(&csi->mdev);
-}
 
-static void ti_csi2rx_cleanup_subdev(struct ti_csi2rx_dev *csi)
-{
-	v4l2_async_nf_unregister(&csi->notifier);
-	v4l2_async_nf_cleanup(&csi->notifier);
-}
-
-static void ti_csi2rx_cleanup_vb2q(struct ti_csi2rx_dev *csi)
-{
-	vb2_queue_release(&csi->vidq);
+cleanup_dma:
+	dma_release_channel(ctx->dma.chan);
+	return ret;
 }
 
 static int ti_csi2rx_probe(struct platform_device *pdev)
 {
 	struct ti_csi2rx_dev *csi;
-	int ret;
+	int ret, i;
 
 	csi = devm_kzalloc(&pdev->dev, sizeof(*csi), GFP_KERNEL);
 	if (!csi)
@@ -1114,62 +1152,69 @@ static int ti_csi2rx_probe(struct platform_device *pdev)
 	csi->dev = &pdev->dev;
 	platform_set_drvdata(pdev, csi);
 
-	mutex_init(&csi->mutex);
 	csi->shim = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(csi->shim)) {
 		ret = PTR_ERR(csi->shim);
-		goto err_mutex;
+		return ret;
 	}
 
-	ret = ti_csi2rx_init_dma(csi);
-	if (ret)
-		goto err_mutex;
+	csi->drain.len = DRAIN_BUFFER_SIZE;
+	csi->drain.vaddr = dma_alloc_coherent(csi->dev, csi->drain.len,
+					      &csi->drain.paddr,
+					      GFP_KERNEL);
+	if (!csi->drain.vaddr)
+		return -ENOMEM;
 
 	ret = ti_csi2rx_v4l2_init(csi);
-	if (ret)
-		goto err_dma;
-
-	ret = ti_csi2rx_init_vb2q(csi);
 	if (ret)
 		goto err_v4l2;
 
+	for (i = 0; i < TI_CSI2RX_NUM_CTX; i++) {
+		csi->ctx[i].idx = i;
+		csi->ctx[i].csi = csi;
+		ret = ti_csi2rx_init_ctx(&csi->ctx[i]);
+		if (ret)
+			goto err_ctx;
+	}
+
 	ret = ti_csi2rx_notifier_register(csi);
 	if (ret)
-		goto err_vb2q;
+		goto err_ctx;
 
 	ret = devm_of_platform_populate(csi->dev);
 	if (ret) {
 		dev_err(csi->dev, "Failed to create children: %d\n", ret);
-		goto err_subdev;
+		goto err_notifier;
 	}
 
 	return 0;
 
-err_subdev:
-	ti_csi2rx_cleanup_subdev(csi);
-err_vb2q:
-	ti_csi2rx_cleanup_vb2q(csi);
-err_v4l2:
+err_notifier:
+	ti_csi2rx_cleanup_notifier(csi);
+err_ctx:
+	i--;
+	for (; i >= 0; i--)
+		ti_csi2rx_cleanup_ctx(&csi->ctx[i]);
 	ti_csi2rx_cleanup_v4l2(csi);
-err_dma:
-	ti_csi2rx_cleanup_dma(csi);
-err_mutex:
-	mutex_destroy(&csi->mutex);
+err_v4l2:
+	dma_free_coherent(csi->dev, csi->drain.len, csi->drain.vaddr,
+			  csi->drain.paddr);
 	return ret;
 }
 
 static void ti_csi2rx_remove(struct platform_device *pdev)
 {
 	struct ti_csi2rx_dev *csi = platform_get_drvdata(pdev);
+	unsigned int i;
 
-	video_unregister_device(&csi->vdev);
+	for (i = 0; i < TI_CSI2RX_NUM_CTX; i++)
+		ti_csi2rx_cleanup_ctx(&csi->ctx[i]);
 
-	ti_csi2rx_cleanup_vb2q(csi);
-	ti_csi2rx_cleanup_subdev(csi);
+	ti_csi2rx_cleanup_notifier(csi);
 	ti_csi2rx_cleanup_v4l2(csi);
-	ti_csi2rx_cleanup_dma(csi);
 
-	mutex_destroy(&csi->mutex);
+	dma_free_coherent(csi->dev, csi->drain.len, csi->drain.vaddr,
+			  csi->drain.paddr);
 }
 
 static const struct of_device_id ti_csi2rx_of_match[] = {
-- 
2.34.1


