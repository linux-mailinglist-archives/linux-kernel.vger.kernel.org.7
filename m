Return-Path: <linux-kernel+bounces-897146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBA1C5227B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EBBD4EAF28
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0EC314D05;
	Wed, 12 Nov 2025 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vnEbj21L"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FDD314B7F;
	Wed, 12 Nov 2025 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948525; cv=fail; b=uCyEkw+qVaqPE3d4YRZ4v8UVDKL1aUuMNgfNGg7ekpjJKWjjYygvUA4OgmZ7D+Ie6rAsiiAOFRtwO+wwPauedv4PH2l1jYR/OZVSP4Tialyq6VfIE3O1KX+jf/1orPUv0q/BtG8tnzRIB7tYODGh2vPqAsicNSdhgYwbbRq2Hmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948525; c=relaxed/simple;
	bh=/vdrfC+/IdBRirEA0hiy6QbbPz6x8edyrBK2udp3YU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLdUryYakY8Z2ix+OknjZTpqWLn52y4mR4114IBoXUK4T6CEX7zc0Xw50e0UINfkwO6Ge42s9aSoE6pmhRMBrNTKqhf0DYa58HmB+ENxxwjuAneSs5cGWeqFExLlOkYxmmdis9MDpg11annp3+h4NYVew7osTLbHbapzr1zvwXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vnEbj21L; arc=fail smtp.client-ip=40.107.209.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8EZ6/UwHM1+LwFuCl2CtNdrW/lyfWi3ejtBERbuRQa98hdl/MPBknU07EKz5o4Ef2AjeYS7GiX76zpOMKp1gOS4efAT3CSg0PvrxZflLweb49uMk+d91Kp6WwxzGHHLr8wfdCTOzrnn41SXPSPzDAfCARMm9aj80kjD59wdT0QYBfFiyyn9gc24lokXOW7fLHduXhBQuxVBJLmfzt2UZLWRDwomv6/lVlppq6Xhm8XKb3c/8nVPABK0+shIWruYFMtpmo8bS6EHQLxubzdX5LPpXFMkyJZMLAfCgEM1yaHRaVWCWtojaYCvCJ70eQT7UjWs2UGxJsVDndS+S68l/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbDqIeLvmaUWj3lULw14B/1USNYVxQPfNNOTDIAlqKI=;
 b=k6JdOuCtN+OujeRn5oWb3ZGTvpWkKs/7Vzuywda3TL7KzKR10TnfqaCKi8hXjQIxKZKyKTgTxfMINUzSL4+WH+lwin2aFvozDwJPApBbzJWP1+WznE4wpymh/UtJmztmLKCTJRXB/E6HJz/DE8Cu+JWxJHuE1N3aRP7LrzwWVZa/2tnsnmhC38i08UnZhKTSLfQxHIWe4rgalxhriQ+Akkvd8Y+WMvYYs81sP1uPqHEr5YFKzrL8zKC/PU+LbWgjduPCj1cAQd5uEOMhegAm9FvfiMGRqBBuwjKzsxHSeiHIKmJjNwsWiPlCCqmjrnaIv6lRsrwf5INuYTGCjSi2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbDqIeLvmaUWj3lULw14B/1USNYVxQPfNNOTDIAlqKI=;
 b=vnEbj21LdZT8rbHFsS9KhQdFBhuO5gB9IR+hIzlwDXhsZ5R+enStZtcjmipH/t6sXmewRaZgpRu7mZmQL1aZVACyFRBIDx5QagXkGpilmgC6L5rR6M+zrdPWhhAqYeqOuyb7IPeNt3etkyrYjT2gJdhSablkidCHNRZhjYiBTjQ=
Received: from BY5PR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:1d0::11)
 by SA6PR10MB8159.namprd10.prod.outlook.com (2603:10b6:806:43d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Wed, 12 Nov
 2025 11:55:21 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::33) by BY5PR04CA0001.outlook.office365.com
 (2603:10b6:a03:1d0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 11:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:55:19 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:55:13 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:55:13 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:55:13 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxbp2638977;
	Wed, 12 Nov 2025 05:55:07 -0600
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
Subject: [PATCH v8 01/18] media: ti: j721e-csi2rx: Remove word size alignment on frame width
Date: Wed, 12 Nov 2025 17:24:42 +0530
Message-ID: <20251112115459.2479225-2-r-donadkar@ti.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|SA6PR10MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 2132e383-de91-44c1-22de-08de21e25aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eY4UgGZTZtPquLcN8xjnRrHvzWkaYxNiaKF0DM7LLQYd5jCJ4F0S1s9WOJwg?=
 =?us-ascii?Q?wkLz8SzM5Qd+Eo1l+Jk0inePRjRruVl2Pw684KvlsZOS6lBg/lk3NPqF5490?=
 =?us-ascii?Q?lk6WZSKSkchEVMZ3EeXq88/ksT0t9/m50LK+jhB21LbVw56ArZyNcXljjqEW?=
 =?us-ascii?Q?FoQ9aRvhTR4nnS6OaLq4f0fhcT6ASLfkXWgXigex9yZHo8vdUkH2s/xaZr6E?=
 =?us-ascii?Q?VPFNNV3TeO7JDO9XRucMM6EsdndKsN32nJphc1mMOgwy62xVOHLNV6mXm7XO?=
 =?us-ascii?Q?wibs0QIMRv2qBCVtf5dQbOwnE8qlv/T5E9jll6at56DYPD8yDoCj6SiRdnaq?=
 =?us-ascii?Q?AnsaHzYMNbGZlOAHu5n7huT4NIyvlzgmitGr8rTA+CUbk5R69nbNLwnRNq/I?=
 =?us-ascii?Q?ntflvEE1WldByS51YDBaFtfLmdFETGbELVgm97+Xv5RcmbSzud1jnMV3U0+z?=
 =?us-ascii?Q?kTMXlJmUJcC2XvW/dQRq05bnfCYgxOfuAPcSFpU4sCTa/yGE6/SnVk3X1aZi?=
 =?us-ascii?Q?bUAmepwIOpoxbWpj6vVz0qwuHW6jUTyOKSZhGCtJ220CanUmN0+lYsB7lMlx?=
 =?us-ascii?Q?WlXsQJueQ5iU9lr1lTxrkbgeJu3FcP8EaC8T1IdXwQj+IDK2s18wjVCNb8ej?=
 =?us-ascii?Q?27hGqyZSvzxXsmlR8ygywLNK0UnJ/ouNxEYn7QEhicBMlF8NIw1Vr+2jZwdn?=
 =?us-ascii?Q?H94niV+lC0X75ebpS6oqR2rahV+p01WlfvwHB7/rjwvNuFA4Fi7RG/F3yzlo?=
 =?us-ascii?Q?e6bXZTzcvna1ziY/ripcsnQBStY0+KnyFnPOEXn5sQbF8tLX9GMMKaUy9CEr?=
 =?us-ascii?Q?MQlkCzdo3WEgQrmdN3KkrjsM4FKJABsKPhVylhhkggydNnpSQWrc5LUW/S/l?=
 =?us-ascii?Q?wFjY/ghsnEgyG02mMdd5ZdsyYBXTGrOYvprqVKkoQdvyg+M+DpAjeapEbT94?=
 =?us-ascii?Q?3lnSCBlufR+nQz2eh72F+Q4LdJQKPZ9vUKV1iJ/sjr1KcvmN1kEKNY66rcnV?=
 =?us-ascii?Q?DST6m9L/kaUSgTmOOQTqRIKrBGL2zLoMbVkMp5AX3N7MghOb5Vndc6N5mpY8?=
 =?us-ascii?Q?f1UpZFtoolzTURqq7fOeTj4GTZaiABPGn0MbW7Uh50hiyGzERCRgKgp1GkCZ?=
 =?us-ascii?Q?bXEq0KD6NOb9PZXvtxSjF3wgVwzgTgjGVOOaxQL7NUMVXHF7Z9wSARRJfcXM?=
 =?us-ascii?Q?VcYWXaFo+CgW1Pd5ZEmWPc4uRMLjc4H77dmPXatI4puvgKbfN6/gG6Qvzghj?=
 =?us-ascii?Q?FV14Q55cBjScEGano4jQ+RNHbQMuio73qPhgRMxkQsobQllqaHs87oEYyrns?=
 =?us-ascii?Q?fVfX4e3dw5KggGq9vc84s42Vx8MGUsrWD59cl4WWWPUVHvOYiKCT5pn6tjam?=
 =?us-ascii?Q?BcvpwJ4GyoAxW9b/PayFTjaFVncoJj83WVDI4Il/LizkgNhBq2/83virwNNq?=
 =?us-ascii?Q?uoMmaZpmlV8jDZ0l7GVSs4EVKfzmjhOo7Ww6BmQsqiOQ0FZymbJkBphbUmOP?=
 =?us-ascii?Q?HVAeRmRWdBW8IRjWPjiPw9WPZsRcWZw7mAYUq31DQIc2IryWg+sfyZKuTDr1?=
 =?us-ascii?Q?W+Kvach+eQH+TynCMLM=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:55:19.9145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2132e383-de91-44c1-22de-08de21e25aa8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8159

j721e-csi2rx driver has a limitation of frame width being a multiple
word size. However, there is no such limitation imposed by the
hardware [1].

Remove this limitation from the driver.

Link: https://www.ti.com/lit/pdf/spruj16
Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
---
 .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 24 ++++---------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index b75aa363d1bf2..710d05a053539 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -43,7 +43,6 @@
 #define SHIM_PSI_CFG0_DST_TAG		GENMASK(31, 16)
 
 #define TI_CSI2RX_MAX_PIX_PER_CLK	4
-#define PSIL_WORD_SIZE_BYTES		16
 /*
  * There are no hard limits on the width or height. The DMA engine can handle
  * all sizes. The max width and height are arbitrary numbers for this driver.
@@ -250,19 +249,12 @@ static void ti_csi2rx_fill_fmt(const struct ti_csi2rx_fmt *csi_fmt,
 			       struct v4l2_format *v4l2_fmt)
 {
 	struct v4l2_pix_format *pix = &v4l2_fmt->fmt.pix;
-	unsigned int pixels_in_word;
-
-	pixels_in_word = PSIL_WORD_SIZE_BYTES * 8 / csi_fmt->bpp;
 
 	/* Clamp width and height to sensible maximums (16K x 16K) */
 	pix->width = clamp_t(unsigned int, pix->width,
-			     pixels_in_word,
-			     MAX_WIDTH_BYTES * 8 / csi_fmt->bpp);
+			     1, MAX_WIDTH_BYTES * 8 / csi_fmt->bpp);
 	pix->height = clamp_t(unsigned int, pix->height, 1, MAX_HEIGHT_LINES);
 
-	/* Width should be a multiple of transfer word-size */
-	pix->width = rounddown(pix->width, pixels_in_word);
-
 	v4l2_fmt->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	pix->pixelformat = csi_fmt->fourcc;
 	pix->bytesperline = pix->width * (csi_fmt->bpp / 8);
@@ -360,23 +352,15 @@ static int ti_csi2rx_enum_framesizes(struct file *file, void *fh,
 				     struct v4l2_frmsizeenum *fsize)
 {
 	const struct ti_csi2rx_fmt *fmt;
-	unsigned int pixels_in_word;
 
 	fmt = find_format_by_fourcc(fsize->pixel_format);
 	if (!fmt || fsize->index != 0)
 		return -EINVAL;
 
-	/*
-	 * Number of pixels in one PSI-L word. The transfer happens in multiples
-	 * of PSI-L word sizes.
-	 */
-	pixels_in_word = PSIL_WORD_SIZE_BYTES * 8 / fmt->bpp;
-
 	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
-	fsize->stepwise.min_width = pixels_in_word;
-	fsize->stepwise.max_width = rounddown(MAX_WIDTH_BYTES * 8 / fmt->bpp,
-					      pixels_in_word);
-	fsize->stepwise.step_width = pixels_in_word;
+	fsize->stepwise.min_width = 1;
+	fsize->stepwise.max_width = MAX_WIDTH_BYTES * 8 / fmt->bpp;
+	fsize->stepwise.step_width = 1;
 	fsize->stepwise.min_height = 1;
 	fsize->stepwise.max_height = MAX_HEIGHT_LINES;
 	fsize->stepwise.step_height = 1;
-- 
2.34.1


