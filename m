Return-Path: <linux-kernel+bounces-897155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C510C522BE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34CA3A8214
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E95319864;
	Wed, 12 Nov 2025 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XX5nx0Yi"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013004.outbound.protection.outlook.com [40.93.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B127D315D37;
	Wed, 12 Nov 2025 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948585; cv=fail; b=T/Z2nAo7ORlwXtnuUY0/t0IkrYfA52jbqGS6OywITeh3Hr2sWj+aYg3QJlvJZDqnYrn0+orZ8SMMsMSnUNZzNeHYKClOzbDQ7RGu0AIFcjRVSKnHBT6kEytQHJDwFhmB59l9WtCGv8be8eZHngIGkGhWA4JmIZVksBl4Mj8vczY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948585; c=relaxed/simple;
	bh=25efr0AC8crj4qq1vibe7zMzRGXbTiWmeJVWWL7usPc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHXo+7SQKfCcSPzIEcoQN/jr2wcquPQFfbqL91ZQhPSBOBKOVMfFbRZwcAkfkd6z2EYwr4FcgF4pGAa1enr/z/d6ysz1Hra9NfnwfHRMWU/e5JyDCquWz8s/ZRiy5LcOSsnJ7KCvfQdmVjkjcQHaKkD4mOAmp++pN8tJNeGMGhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XX5nx0Yi; arc=fail smtp.client-ip=40.93.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9PQkFgCjLvQlpyPKnCxBIh/fBrjnvkFuPRWruZppsppCr/C4jxtVojqkYjduT53mE3Aesx2RqFopAf6oevJsSt1wfylwxFcG8QU2hseVJv+wdaYyzdO+aj5FEZWlNvMPPCir93dy0tv4sDJHZxuW4hF1YO6/nvIw8679Y8jB6hpUuLJjy8+uWDId1Aci7ksL7aJiN0nwcGvYX9TGQNEwB2xHUEg/WN4rNuoRHq6nFC0tWYbNC7V51slA8+kxEHBWRcnUgXqDhguzZkNqbQn11XX2lgde/+VV/yL4KsG3v6P2OmEqlKMyjsxjS/yTlsDhKAXzvp932IoHPeghViTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyaiJ/Vs5p8Q2pFuEgKqAmQnObit8dKHvKWeBeDEY5s=;
 b=m66XJxDwCWUQGgf4BTXhf8+bKvJs4NU13FofWQYltTZe9i6EwjjZfDOrlfwYJFJ2QNSxRK563LCCQcowrdFZj+GnNzSGOIpCpfJf1uaSurcT7TLP45IngEfhG5FNE6jiopu+ntdPa+VQfTOHOrszuCZMNoeXObBP3F9Q77LEQoeLUW2WfPuXbzglTnoVAYWaLeggqCc0t1+VrI3RUo/FHVv05quzRBjbh9K2PmbynF4BwRrwPOn4745xSEw2GZcRr/zF1y4+KRzl6ea7izjueBluGSNFFtz2a3qsrMoapi5VaX9FrtCotV8b+JoAaYF4dNJhrpnCCkjpN+eC8CWWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyaiJ/Vs5p8Q2pFuEgKqAmQnObit8dKHvKWeBeDEY5s=;
 b=XX5nx0YiF+MfDhahK6E6o9jSrKQeGUhuWFlSe/b+faHosBYjUvYCg63UV5epSDNVxrAeIvEw3e+Hsyuci4JB53LTDFk/U5+suBQZXkSKUNO/tPcpejRUIV0yLWLBYMEGd/cb7i5hwH/eGNUsMi9eWnKzof9uASJZ20L/SUGQmEg=
Received: from BY5PR17CA0030.namprd17.prod.outlook.com (2603:10b6:a03:1b8::43)
 by MW5PR10MB5807.namprd10.prod.outlook.com (2603:10b6:303:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 11:56:20 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::58) by BY5PR17CA0030.outlook.office365.com
 (2603:10b6:a03:1b8::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 11:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:56:19 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:13 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:13 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:56:13 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxc02638977;
	Wed, 12 Nov 2025 05:56:07 -0600
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
Subject: [PATCH v8 10/18] media: cadence: csi2rx: add get_frame_desc wrapper
Date: Wed, 12 Nov 2025 17:24:51 +0530
Message-ID: <20251112115459.2479225-11-r-donadkar@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|MW5PR10MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ea108a-84e9-4309-79ab-08de21e27e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1p9upny7sIV63eWhP04SSRgyu7Z+hj9wbWpE8FPWPh3s38Y/CCSF5AzSda18?=
 =?us-ascii?Q?7b7En/rK65exNYdj6WbT6Rw6g8QqZBnbFsppIDPSpFtyO1YsRfxu5HxIPykl?=
 =?us-ascii?Q?f5LtQ2jTg3Mx/nPpn2YJXdYQYQsg1nGM+r/VD2FzN1O0JasrjzgNqw+5cAnn?=
 =?us-ascii?Q?ChGkVFHvQ0Ks0zV7oiwXqG2cA7IcKGSCirEPDhRHxQRgCsZS1pr7nIuLS2NZ?=
 =?us-ascii?Q?o47+6cgjldrsROp0A41fqLOXOkjhoAtFfrenUmFiagcUF1OKNtakRrGOKwya?=
 =?us-ascii?Q?yevm87fLpnICdEoRrGokP+Udofqmzdk9+CXlaFvP2nYORVTuZF+HROkbwCSF?=
 =?us-ascii?Q?mg3Lxc/+1552UtJqZCo2OTw4vCnRDr2fhfcgTld6WN5mbTkNFRcxDpHt/uHY?=
 =?us-ascii?Q?aKB0sxLyfowmFPMB2/GI8/Fwh8dcTLwQnzDvEoecPx+htSRiYKNa3d7VDMJN?=
 =?us-ascii?Q?d/oTlEDFa8GgT35034p6zUxInSN47kEwQNNzNBwjUaji+Dr7wxujpoOHRu4q?=
 =?us-ascii?Q?HVMPCBghDxye60TZ4wQ/tMlGnzWXcKdIdm6sRhYnA0Zr3c5DRRtP2eKhvJVy?=
 =?us-ascii?Q?RXBuT3EdHYIRWEtXax8cQRmqOKFF6IxKg+rrofWXn9CuQG0LInsWAxrU+uHs?=
 =?us-ascii?Q?QhYbdLSM1Zu/YPnA3iNHuYUgP3uA751KPyjo2H1FtxmdcTSYAz3Su3kJpKok?=
 =?us-ascii?Q?F3jDdnAKt2j0R3YB3DtBGxcQ2JXWW6axjrI4ixStlztHBFRZNdTBktahsGp4?=
 =?us-ascii?Q?6G/4ZCSxQqt75OX0v5scXEUkoQcl0W4iAWoJILT6DGlcAVQJ6teVPieocwnG?=
 =?us-ascii?Q?J+5BavvAkuNAeSUdgFs+mUo4IXULCfoPwFaoCoFi+L0+sqVNBqFDrRPNwlkR?=
 =?us-ascii?Q?bY0mL1i+RWmpb7z38bG2Ql8wIcI3FSrn6OXXrWr6MydasGH6rSWm1FMW5MYd?=
 =?us-ascii?Q?jjebKuf3jbBxVt3Gt73S+1/2oXPuHHAqcdI6X3wUts58eIcN54tA14R/Vrfz?=
 =?us-ascii?Q?bS9jqL80Oa+bCmBVAlOsAe1JgrW27/WBjrdMMTOMNG1Mxh54e4uBDRRh60QW?=
 =?us-ascii?Q?ZKnluKrdFEOf/PmiC+5Bi2Mo9y2MWNiQV67eBxCvVK5DH5D/ILjljl4BVNb+?=
 =?us-ascii?Q?3NHoP+knMTycM1tVyNTUiPkVD96brnZsPrP7LBgSlynLR3tbVEcksc5BLnus?=
 =?us-ascii?Q?H6kXchDsPcB/pBTy27FdPPtzbTDEDLELE1QshlCdw9PLs9jZQQ3E3zjeLU02?=
 =?us-ascii?Q?8D2IUcicoKC5+egkAZLV8I8m1ftGI/fenXNFfichG2JfoHnyOmMDPE7HGz1a?=
 =?us-ascii?Q?X4ONThrWeszkPOZYqu6SR0WG/LxGNFSq5t4wD/bcourkKMGrrHjUDNlsPcXD?=
 =?us-ascii?Q?t9qDIVO3vhX+u3JUe0KH/AM6lJxvqPRXZaWXbeHOOaS5zfzKAuhT55EfXe89?=
 =?us-ascii?Q?bbP5OucFBOEfxBbS5/c5EjlW1IurtfptLvzTR/tKTlwSHMuD5O/EqE1+TX6b?=
 =?us-ascii?Q?GJPVstuHoHl4awHnx/NnQPZZyn7xbVBqTZa6cunfM95IWKCr9xfgmyuk+qI1?=
 =?us-ascii?Q?UPybAaxyyfZqz6IWnOg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:56:19.4280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ea108a-84e9-4309-79ab-08de21e27e1d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5807

From: Pratyush Yadav <p.yadav@ti.com>

J721E wrapper CSI2RX driver needs to get the frame descriptor from the
source to find out info about virtual channel. This driver itself does
not touch the routing or virtual channels in any way. So simply pass the
descriptor through from the source.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Reviewed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 34da81893308b..3688077fa8347 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -229,6 +229,21 @@ static const struct csi2rx_fmt *csi2rx_get_fmt_by_code(u32 code)
 	return NULL;
 }
 
+static int csi2rx_get_frame_desc_from_source(struct csi2rx_priv *csi2rx,
+					     struct v4l2_mbus_frame_desc *fd)
+{
+	struct media_pad *remote_pad;
+
+	remote_pad = media_entity_remote_source_pad_unique(&csi2rx->subdev.entity);
+	if (!remote_pad) {
+		dev_err(csi2rx->dev, "No remote pad found for sink\n");
+		return -ENODEV;
+	}
+
+	return v4l2_subdev_call(csi2rx->source_subdev, pad, get_frame_desc,
+				remote_pad->index, fd);
+}
+
 static inline
 struct csi2rx_priv *v4l2_subdev_to_csi2rx(struct v4l2_subdev *subdev)
 {
@@ -611,12 +626,21 @@ int cdns_csi2rx_negotiate_ppc(struct v4l2_subdev *subdev, unsigned int pad,
 }
 EXPORT_SYMBOL_FOR_MODULES(cdns_csi2rx_negotiate_ppc, "j721e-csi2rx");
 
+static int csi2rx_get_frame_desc(struct v4l2_subdev *subdev, unsigned int pad,
+				 struct v4l2_mbus_frame_desc *fd)
+{
+	struct csi2rx_priv *csi2rx = v4l2_subdev_to_csi2rx(subdev);
+
+	return csi2rx_get_frame_desc_from_source(csi2rx, fd);
+}
+
 static const struct v4l2_subdev_pad_ops csi2rx_pad_ops = {
 	.enum_mbus_code	= csi2rx_enum_mbus_code,
 	.get_fmt	= v4l2_subdev_get_fmt,
 	.set_fmt	= csi2rx_set_fmt,
 	.enable_streams         = csi2rx_enable_streams,
 	.disable_streams        = csi2rx_disable_streams,
+	.get_frame_desc	= csi2rx_get_frame_desc,
 };
 
 static const struct v4l2_subdev_core_ops csi2rx_core_ops = {
-- 
2.34.1


