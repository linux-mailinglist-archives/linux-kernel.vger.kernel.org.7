Return-Path: <linux-kernel+bounces-897153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF71C522E5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 104104F5D93
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ACD3191CD;
	Wed, 12 Nov 2025 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CqmYfIIO"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1A7318142;
	Wed, 12 Nov 2025 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948570; cv=fail; b=F+t7kTyJIZ/hVWNhL1GmB1HHNnuSdv6+gTz829kg2otwUDxYdUpYFhLDXN8ffVI48P9DdU+SZwqUHPnY8TA4zorsO7bfZVwEjPFK5LcWRhRVKUCOeTJ7+4sDZvHi8b67YbIkmflikZDgQQxJblL0HynM3dzELTNxCk1DiIBYA94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948570; c=relaxed/simple;
	bh=J0aeSCHwA9bsw4Rr7xsRXTdpycpQuszepvKNkKXWvYo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9LNcKdFr4qJt0RMe1l+0/P65+BXKzC0ozDQ5PkkDD4uJVUg4d1/QlnMOGbDGxVN4XIRqlyegPEUL1LaEUSY0C1+9SHyh1qZ2dc953uBKU2Q5Pd8+S97DYZgELvCmHBGEmD/mRkJINgamkKc1AyH7gKkSBmEl8FYdcdJMNStIn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CqmYfIIO; arc=fail smtp.client-ip=52.101.193.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3uH1ksUu05aa0o7TA61QEjelJhgfxSrcsOF6PbempurXc585wkpDnAB9vRhtKU6J0zy5BAQLuXRG/8K1ifvcz1P0orzsqNTi78ljEjoGWl/V2rXjzGv2hiHuE3tQbogkr4ho91XbaAb2MZQ+BV6H6W7c6/dJQTlyYYB99vIBfqa3P0B5WG6eU6Auegd7Y3JlYz2h/6BUGWkODKcp/2j7bMuZ8NcZU5xJkacGZ047oqWTnWSA1KGtwtwYZQ4bRA3UY8863ZntXbovusbcgB9nicw+j/mV9QLOoRFb3g4hGqkC97vyrYvaRktNV2XvC1BwqH7gvtmBEonKfpa/oJXbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqNTVaWZ/p9SlTWrnwupjvaH7BXaLH5kT2yXzh4Npr4=;
 b=VQAFyIjPKIhqZz9gvILx+qJU0SwVaNXHLfCtRU0y+dkxmPi0WHCWvq5hVXrC0d/c26QLP3s5dq5715ZGVEy32ercaXYey8gA8tURz/dAc8MmK1uoJlfDsFojQp85EC55OdbVZQUgNPZtzmSuPvklIOIkLZNqnNZZaenBOByoYdT7Q8hIYT7FPPztrpMuWaLRh2dwIiGI1aTSEtbjztqgTZ6HGpeq6lMpo0V+SvM6cD6rPwtRe3fp6JcdvNrnfH6yJswW7L0KXIW2oFG0v6e1MMTZi1HEHQThBn0VkGEhcooOiatF63UMVsW/xrsHyvcqlfvNG7/Lhvk+abgkB6xtIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqNTVaWZ/p9SlTWrnwupjvaH7BXaLH5kT2yXzh4Npr4=;
 b=CqmYfIIOKirVwvr7ytoG1wJhmRfr5OfTgoYHxfolmrYJ67NrTmshPg2CASUOKe1p8oLN8rsN7OIRcsA0eDma66v5Vxwvvz6lHxYWqV4Jw3Rj4HE7f5veKXQMczlVRVlraQrNTaVn79ZEX9i84IlsBtA6J0Z/MUDxy955Q6UI2gg=
Received: from CH0PR07CA0001.namprd07.prod.outlook.com (2603:10b6:610:32::6)
 by IA3PR10MB8489.namprd10.prod.outlook.com (2603:10b6:208:583::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 11:56:03 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::ef) by CH0PR07CA0001.outlook.office365.com
 (2603:10b6:610:32::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 11:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:56:03 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:00 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:00 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:56:00 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxbw2638977;
	Wed, 12 Nov 2025 05:55:53 -0600
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
Subject: [PATCH v8 08/18] media: ti: j721e-csi2rx: Move to .enable/disable_streams API
Date: Wed, 12 Nov 2025 17:24:49 +0530
Message-ID: <20251112115459.2479225-9-r-donadkar@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|IA3PR10MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b38fcf6-f64b-4fe8-7af2-08de21e27456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2DB3xyi+qBwvFkQnXNsx9+/zm3nbX5hip6qANc8xCGYRIbOXcoN6pD7Bd6Bn?=
 =?us-ascii?Q?GuN6NSzA9FsuzWHRfGw/HJ3KKgFlKqfKlPonvTEeHlmWbLP4fQ5KTFYMaQqA?=
 =?us-ascii?Q?4tgzfp/fLRrmLVuwpQp2wufpGxRmqYi87L8yw8ALN4qP+RmP3HbVVxSk56L9?=
 =?us-ascii?Q?zOzurGk31HzBb2aXvAZOdcEI9bdDIiF1gXUxx8pWR7zuK3zS3ZsSUl6KZ4GA?=
 =?us-ascii?Q?P0fliRO2EAjP9OYxh1GBhRvxE32rIYG41zBoIVZLVywv69xC3jKP1BGzCgqZ?=
 =?us-ascii?Q?cCCWE6MQLqHD0a4Gc6fP0840VLpuvRdbcZYDa6LN+3/t0pOR9L/24Oxe8QYy?=
 =?us-ascii?Q?b/Og1glMJo8mAS8qj7i9hJ5/4q5nL+pcxjU5YiKa52VyUxQFrMN4eeW2uI+N?=
 =?us-ascii?Q?wr5p5a7T3nNwCnQiW6BJDvVrdXyDB2pNnS0DZImf8bH8bFBXrhdEXmy0SCd7?=
 =?us-ascii?Q?38l6YAA1WRpwvmJWlqePqReOrrPRgk5nonfz3MajLCca2Npfjbi75BoEJ7A3?=
 =?us-ascii?Q?v3G0TnrfFkb4Q0xCHgkJAUF+OP5PhVnJzqYWbM6XjNk3DdQRzK9K4NdrdtUN?=
 =?us-ascii?Q?8n4NXr2KkI1mjPKdIM7suyYuYDqmXFGHOWtrrT4YLpTuE9hp1pVt6MFC2o+2?=
 =?us-ascii?Q?2fQHOPSi9IR/cX7kXg+9epcR6tjFALERC3npmaqT6VG2+KtrkJbtyL8rX0in?=
 =?us-ascii?Q?TGYVecLEx2SNQpRYt0AevAERn4XFwRevyEByrjuJVn530MjSINMzvNxjuYwF?=
 =?us-ascii?Q?4PIuwZXH3rlKoayWsT4IwEWu/deybuf3nloJMurdjZeKjVfSbvji8ryKc8Os?=
 =?us-ascii?Q?2J64PAiuDEYv/KkvljYMS9ku573kzTLqebSqTqQ9w5OWkyVTSk5DHbAHlzeQ?=
 =?us-ascii?Q?tpXzqbMYi8UZlvynLqOKZTUkx6BifatuIIfGSotolekmKk9PsJmEch/ySoa+?=
 =?us-ascii?Q?TjWoDdNftnMh2oc5xLmqxUcAEIR6QCjJD8dFb4sqwAJbWPwxP6UteEfOktgN?=
 =?us-ascii?Q?1z27gJblJYWRyBzANM3KnkiaIc3UHYxlORPx+lmjA7FNsaHreO4L7Pp5Gkiy?=
 =?us-ascii?Q?xYSQxsMpFVdPIbDH2GaV63auHuQlGEYDo4N4UXyMytcwvuvOj1Nh48cns2N6?=
 =?us-ascii?Q?EGZFZ7E/3XEGCnwQ1D+7Lg+XU4zrmY/8wcNZo0Ob9iDmw/0vpIntCmWHzs1C?=
 =?us-ascii?Q?T0UbzpMpfQNLHa/Ok89tz1xifNMxT6Y7HCWI3B0Gf8DdjQgmJ1saiwam8IEs?=
 =?us-ascii?Q?SX6yqfJ3z62BnzW+xNLrCKrbcDRdSJnSvLOz52V8SHlHBME8CFI8zyIxH3/d?=
 =?us-ascii?Q?rkOe1IbScbdL3HCAJfJgvvrwuTu5uFPDiajTxQdaJbQseasdrxzHBZHfxn9h?=
 =?us-ascii?Q?qKCXJK0+eOgnEX8bi7yRcHcZf+j8w2p7KNKH6pRjPC6mCsylaIFC/nR13h8/?=
 =?us-ascii?Q?uzf32Mf8T0seBxtglgUhibUMFLud5599lgTx0wBI15yzoBk+BJZPtMcE7dUs?=
 =?us-ascii?Q?KJ2HxJtAJPTYMXguC5DGHXuLG7NBr0ytULnkzMY/pXqnBjUNTWJzjmXpWRjD?=
 =?us-ascii?Q?cLm8a8+kjFy627ZVBK0=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:56:03.0815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b38fcf6-f64b-4fe8-7af2-08de21e27456
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8489

Support the new enable_stream()/disable_stream() APIs in the subdev
instead of s_stream() hook.

Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
---
 .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 71 +++++++++++--------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 327b8e5fb7d5e..372a4035d78a0 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -921,7 +921,9 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 	dma->state = TI_CSI2RX_DMA_ACTIVE;
 	spin_unlock_irqrestore(&dma->lock, flags);
 
-	ret = v4l2_subdev_call(&csi->subdev, video, s_stream, 1);
+	ret = v4l2_subdev_enable_streams(&csi->subdev,
+					 TI_CSI2RX_PAD_FIRST_SOURCE,
+					 BIT(0));
 	if (ret)
 		goto err_dma;
 
@@ -949,7 +951,9 @@ static void ti_csi2rx_stop_streaming(struct vb2_queue *vq)
 	writel(0, csi->shim + SHIM_CNTL);
 	writel(0, csi->shim + SHIM_DMACNTX(ctx->idx));
 
-	ret = v4l2_subdev_call(&csi->subdev, video, s_stream, 0);
+	ret = v4l2_subdev_disable_streams(&csi->subdev,
+					  TI_CSI2RX_PAD_FIRST_SOURCE,
+					  BIT(0));
 	if (ret)
 		dev_err(csi->dev, "Failed to stop subdev stream\n");
 
@@ -1016,53 +1020,60 @@ static int ti_csi2rx_sd_init_state(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static int ti_csi2rx_sd_s_stream(struct v4l2_subdev *sd, int enable)
+static int ti_csi2rx_sd_enable_streams(struct v4l2_subdev *sd,
+				       struct v4l2_subdev_state *state,
+				       u32 pad, u64 streams_mask)
 {
 	struct ti_csi2rx_dev *csi = to_csi2rx_dev(sd);
+	struct media_pad *remote_pad;
 	int ret = 0;
 
-	mutex_lock(&csi->mutex);
+	remote_pad = media_entity_remote_source_pad_unique(&csi->subdev.entity);
+	if (!remote_pad)
+		return -ENODEV;
 
-	if (enable) {
-		if (csi->enable_count > 0) {
-			csi->enable_count++;
-			goto out;
-		}
+	ret = v4l2_subdev_enable_streams(csi->source, remote_pad->index,
+					 BIT(0));
+	if (ret)
+		return ret;
 
-		ret = v4l2_subdev_call(csi->source, video, s_stream, 1);
-		if (ret)
-			goto out;
+	csi->enable_count++;
 
-		csi->enable_count++;
-	} else {
-		if (csi->enable_count == 0) {
-			ret = -EINVAL;
-			goto out;
-		}
+	return 0;
+}
+
+static int ti_csi2rx_sd_disable_streams(struct v4l2_subdev *sd,
+					struct v4l2_subdev_state *state,
+					u32 pad, u64 streams_mask)
+{
+	struct ti_csi2rx_dev *csi = to_csi2rx_dev(sd);
+	struct media_pad *remote_pad;
+	int ret = 0;
 
-		if (--csi->enable_count > 0)
-			goto out;
+	remote_pad = media_entity_remote_source_pad_unique(&csi->subdev.entity);
+	if (!remote_pad)
+		return -ENODEV;
 
-		ret = v4l2_subdev_call(csi->source, video, s_stream, 0);
-	}
+	if (csi->enable_count == 0)
+		return -EINVAL;
 
-out:
-	mutex_unlock(&csi->mutex);
-	return ret;
+	ret = v4l2_subdev_disable_streams(csi->source, remote_pad->index,
+					  BIT(0));
+	if (!ret)
+		--csi->enable_count;
+
+	return 0;
 }
 
 static const struct v4l2_subdev_pad_ops ti_csi2rx_subdev_pad_ops = {
 	.enum_mbus_code	= ti_csi2rx_enum_mbus_code,
 	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = ti_csi2rx_sd_set_fmt,
-};
-
-static const struct v4l2_subdev_video_ops ti_csi2rx_subdev_video_ops = {
-	.s_stream = ti_csi2rx_sd_s_stream,
+	.enable_streams = ti_csi2rx_sd_enable_streams,
+	.disable_streams = ti_csi2rx_sd_disable_streams,
 };
 
 static const struct v4l2_subdev_ops ti_csi2rx_subdev_ops = {
-	.video = &ti_csi2rx_subdev_video_ops,
 	.pad = &ti_csi2rx_subdev_pad_ops,
 };
 
-- 
2.34.1


