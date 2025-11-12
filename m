Return-Path: <linux-kernel+bounces-897156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1134CC52213
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94643346CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC4731A552;
	Wed, 12 Nov 2025 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="INvMfGmZ"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012035.outbound.protection.outlook.com [40.107.209.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430A0315D51;
	Wed, 12 Nov 2025 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948592; cv=fail; b=XFC89Z8CVKeZsZ9P4EtROnG0rWKwRzhL4LniaGmXcsb5v7APfT5e4tAoVQ+Fxc4/Pf+ohr55RMCU3gwtCXVlRj6ZO28xEA6T6O25TcVKbAQrVvgM2sOs/pqC/FOsHCfwwDFjbAKraABg3IPq8BOi4X0K3CPxGf8IhjzBH+2ABFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948592; c=relaxed/simple;
	bh=bQji5JLYYpNznaTfz6fyWDE8Kmvv59x52n66XFIuug0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uAStUSF1opvrjW1v/butAOYoJu6FWNUjtH5ZRuR7q1NSFMeb6kb3lqgfk2YgN6+ewwppDAV0HZ0KsZFKsunMKAIkyqx/JvrwC5PtC6hxTUns01Z+zGB5mtsAsWNfIk8xKKtCNYQKQibHpzOrhLZzxa1ey3HW3zLCSkjB7lMW8bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=INvMfGmZ; arc=fail smtp.client-ip=40.107.209.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2fhLSz/zKtXjMWSdOe4MTns/7Vu0MXmbP6q+aaomlpvG6NmgP8bLpAfyFNnCDiXXwmsCLPYf8j+BMoRCL08NEtAzHoVKAbG0cIpzglaWzhnL/rxW7LwYrY2QyMb1nmSlKT5jrcsvvwFzCwgiqcNcgLeRqKNcSFwTWGnXBjdvy0mUAFV/QTwhdTAjcuvozhaiqIwUlahFQ2NuNvzp2WgErshGhzf03bzECKmk3AEfOAWu+9sJl9EXYZDqTrhLBKhVU+SOCqOxE+jZ0vVqOTXXlQ9jx7CAS3MJY+FzIKygYSbemLxyG+nSV2zzxKOYQ5SAxm1yIbI5QILQaxDKx4ouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bx5/wXGZLI9elmSWtcV9d1y+VnRE8QDRzTuYN1DA4dk=;
 b=MebKXFriHwNlUU4TY5N2ggOHMMpLW9T9lc9wdZcURnE/XS/Ur2d/D98z606d8Im8F8Kva2RQuQfYeFuOEXyl+qNylVBvtq8tVA4lJpvkLAdBvbIZ7bOVQnHN7oMwidN31Spq5eusnqn6j7p+dtvUpV4UyJZSIJhen4WLV30q01l9K4DXd1eDNNLFSHoMqvRLv2xAQ55hzySlnjnAMirorSRafBacsA8jN/u6IeodipgJ0vZiV0axv9mbvAKI7GH330TL5hWjvm72xGehD26rjZ2HiJdSeBGesDaOYlafVWL3kxUoixEiAYoy9vc1Z6E9ybTeOTTd5UMBbMxHkSPEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bx5/wXGZLI9elmSWtcV9d1y+VnRE8QDRzTuYN1DA4dk=;
 b=INvMfGmZQxCJ+qBU2oDW83tLeBFOmmMtw4kv3R0R8kBPSxCVSV7OCqGt9sRAfngGqj1nnWhigb+VUmN4H9GJQb+OGfEdw/4HRlg0NDIhRf0sTHlwsGMLj0E+mKQQQBzWvhxz+yseDg202fcByvDlY1U2OTR+atXcmZLULEDrbdo=
Received: from SJ0PR05CA0167.namprd05.prod.outlook.com (2603:10b6:a03:339::22)
 by CO6PR10MB5618.namprd10.prod.outlook.com (2603:10b6:303:149::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 11:56:26 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::9c) by SJ0PR05CA0167.outlook.office365.com
 (2603:10b6:a03:339::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.5 via Frontend Transport; Wed,
 12 Nov 2025 11:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:56:25 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:20 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:19 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:56:19 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxc12638977;
	Wed, 12 Nov 2025 05:56:13 -0600
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
Subject: [PATCH v8 11/18] media: ti: j721e-csi2rx: add support for processing virtual channels
Date: Wed, 12 Nov 2025 17:24:52 +0530
Message-ID: <20251112115459.2479225-12-r-donadkar@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|CO6PR10MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: ca0a1e0e-c103-4260-8ede-08de21e281a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gw1IPLmEVozOBsXjpriQBdC8bpnASctuY13xFD8pWeqUuirnFUtnac08shZJ?=
 =?us-ascii?Q?4jL3pwc3Em0vHnJcHpJDkGnqfTSYSJx6hbO2MPAjVLvpiz1+XaBHVRTJ0er3?=
 =?us-ascii?Q?x0tsL7tJg2fCQTkfoBsdypmZv8MpVQh+esCipHQtzBRd7pgh0Wvz72EukU43?=
 =?us-ascii?Q?5PW+TcZzroV059uMYX2dx+0ubsuAL1us5JBl4meOQwPsFe9+HRjqfxdDPo/L?=
 =?us-ascii?Q?KOW8gTMY+HmiNceWXGqCpeyFH3kkwXw7aKbkFWfw+D9KAhA5VcbI9XKmJr5M?=
 =?us-ascii?Q?cuxnJuuXUZWN2pZRZVeRmHInXHdY8iwjVGfTcKz5TzPIknDe39bfgJnksN8+?=
 =?us-ascii?Q?k8FBWHBm6jVGoqRug41/tcyXh8dciladVIWu/fuea3JsPsNaMd9PjDsDDi80?=
 =?us-ascii?Q?dInOr2jeP75W5aPC/ycmS4nfSwxIAIO66xFDwnyBYYanZhUvuy1ZK91rHHuG?=
 =?us-ascii?Q?BZbEHrWJJsKLydMMzSoOgRgIWyzQbwy4h0fWGNu2eI6ArL2+zFRurbrdbyqu?=
 =?us-ascii?Q?3l1nKdCFH5wEBNIkMkripjmuUkWNyRFO0/gfzTsG7ujdpbqelA1rxME/ueUP?=
 =?us-ascii?Q?LgqWZnpP0x503//+SRpxXFqFP5AGpFB1D1c3BZKxdg1rlUdsgFXRK8KVHCyC?=
 =?us-ascii?Q?ylJZkRFtQjCodWm7cO+ywgXoLH18Rhmfp8mnTmIIRH8P9FDEj9C0HiasondC?=
 =?us-ascii?Q?xiVj2OCP3vvCZtjVsH4NvkdD+Gc0BtAxqc3/9l4/ipgLV3/U5e4gIytXRk8k?=
 =?us-ascii?Q?3fBq3MVdZBkbGONBp/HRK4F+nH5ljsIQs8mYFrqbjaMXY2xXC+pWAxNBSkUa?=
 =?us-ascii?Q?YKWgDbIpNztGBMcNsUUig5AFc3ANJwWy8Yu/Lj4nB8tJjwdBuqLDDdqrd+p4?=
 =?us-ascii?Q?mAviMuW2v9lqCFB6GtoZ0swrBG4gb1YJgfUns7DeoW/nouK4sVBROuBjO8Oq?=
 =?us-ascii?Q?sAkicxY91hZr7pQosQaKkMlo1faVhdCvsyq4jiIfT3TrQRA9ZOdcpMTKExDy?=
 =?us-ascii?Q?tlxoC0MoH4+f6vBl0/P4FBOUww/sC5SkxOzoAi3/Fg5BlK9c+aikpU05i0/R?=
 =?us-ascii?Q?FPZDBEHsZxuKk8pCaPkjJLewI1USLqxdDxZK6Pk/3UoLm/lCV3W2mV8bLwI5?=
 =?us-ascii?Q?3t8rU5HYkEIy3gJtIqROQI1WH15OK+ag6oYoUzxSMbCaoDPhIBAzltoWeWYY?=
 =?us-ascii?Q?z9Fr16Om48V2aSSnuolgdBpnryHPdaxK1VGUJmi+noq+4tuHqE5KBXTUJBC7?=
 =?us-ascii?Q?LLg12pJ7kCd0TeV4Tmswn5MeDQ8uqBfEev4G/amgRdNwuGbTJpt0oy/tbn3Y?=
 =?us-ascii?Q?YriAKb/jdVDjNuLlP1M6XOt5CsJdDfBy/1LJBXXkWyKeh8s0/LN1VZgGpczz?=
 =?us-ascii?Q?os0X6yxz0Rq5kJwDM5od8MQcCqBPKLsyIl9PQybxH45ajfDPZ9slq5e261TH?=
 =?us-ascii?Q?Ydbypc8Rb+MZREMlRwzZ9pUdV84RNwtO6MRGlw74Zltw8G19yRPs/pjntEgd?=
 =?us-ascii?Q?eQEGEm7KXwfQAtDV8ra0t2jgzaSFt66C001z0PbUOURXmhEfH1ebjLgr+7iQ?=
 =?us-ascii?Q?MMBZjcnOSLCvHg/8++0=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:56:25.3733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0a1e0e-c103-4260-8ede-08de21e281a3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5618

From: Jai Luthra <j-luthra@ti.com>

Use get_frame_desc() to get the frame desc from the connected source,
and use the provided virtual channel instead of hardcoded one.

get_frame_desc() returns the same information when called on each stream
start, so instead get the VCs for all the routed stream at first
stream start and cache this information in the driver.

get_frame_desc() works per stream, but as we don't support multiple
streams yet, we will just always use stream 0. If the source doesn't
support get_frame_desc(), fall back to the previous method of always
capturing virtual channel 0.

Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Co-developed-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
---
 .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 5c4524bf42e6e..126a62fa2c4c4 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -32,6 +32,7 @@
 #define SHIM_DMACNTX_YUV422		GENMASK(27, 26)
 #define SHIM_DMACNTX_DUAL_PCK_CFG	BIT(24)
 #define SHIM_DMACNTX_SIZE		GENMASK(21, 20)
+#define SHIM_DMACNTX_VC			GENMASK(9, 6)
 #define SHIM_DMACNTX_FMT		GENMASK(5, 0)
 #define SHIM_DMACNTX_YUV422_MODE_11	3
 #define SHIM_DMACNTX_SIZE_8		0
@@ -110,6 +111,8 @@ struct ti_csi2rx_ctx {
 	struct media_pad		pad;
 	u32				sequence;
 	u32				idx;
+	u32				vc;
+	u32				stream;
 };
 
 struct ti_csi2rx_dev {
@@ -610,6 +613,7 @@ static void ti_csi2rx_setup_shim(struct ti_csi2rx_ctx *ctx)
 	}
 
 	reg |= FIELD_PREP(SHIM_DMACNTX_SIZE, fmt->size);
+	reg |= FIELD_PREP(SHIM_DMACNTX_VC, ctx->vc);
 
 	writel(reg, csi->shim + SHIM_DMACNTX(ctx->idx));
 
@@ -884,6 +888,32 @@ static void ti_csi2rx_buffer_queue(struct vb2_buffer *vb)
 	}
 }
 
+static int ti_csi2rx_get_vc(struct ti_csi2rx_ctx *ctx)
+{
+	struct ti_csi2rx_dev *csi = ctx->csi;
+	struct v4l2_mbus_frame_desc fd;
+	struct media_pad *pad;
+	int ret, i;
+
+	pad = media_entity_remote_pad_unique(&csi->subdev.entity, MEDIA_PAD_FL_SOURCE);
+	if (!pad)
+		return -ENODEV;
+
+	ret = v4l2_subdev_call(csi->source, pad, get_frame_desc, pad->index, &fd);
+	if (ret)
+		return ret;
+
+	if (fd.type != V4L2_MBUS_FRAME_DESC_TYPE_CSI2)
+		return -EINVAL;
+
+	for (i = 0; i < fd.num_entries; i++) {
+		if (ctx->stream == fd.entry[i].stream)
+			return fd.entry[i].bus.csi2.vc;
+	}
+
+	return -ENODEV;
+}
+
 static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 {
 	struct ti_csi2rx_ctx *ctx = vb2_get_drv_priv(vq);
@@ -904,6 +934,14 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 	if (ret)
 		goto err;
 
+	ret = ti_csi2rx_get_vc(ctx);
+	if (ret == -ENOIOCTLCMD)
+		ctx->vc = 0;
+	else if (ret < 0)
+		goto err;
+	else
+		ctx->vc = ret;
+
 	ti_csi2rx_setup_shim(ctx);
 
 	ctx->sequence = 0;
-- 
2.34.1


