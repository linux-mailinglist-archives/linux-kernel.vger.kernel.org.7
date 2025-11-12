Return-Path: <linux-kernel+bounces-897163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE174C522C1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306E61897FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A36131D749;
	Wed, 12 Nov 2025 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hzWMI1Qr"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010010.outbound.protection.outlook.com [52.101.193.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B333176E4;
	Wed, 12 Nov 2025 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948623; cv=fail; b=DPc4LbMjfrS3jMkK2/J70gkxV/df/gQKWkomezJeW2QNuxrHTV0uC+2jnvA28SFVpEKX3LnVQx2B5Oslu1kO4tymXWWbykgNFasYuklgti+IFZEAKfZLdxBwhjCwnPzOc2olCxqM7bi/IZVWV5b5L8at8IuljHsaI2pez7Ia2aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948623; c=relaxed/simple;
	bh=oV09HqdO5lAfwySv1WBueOYbJLKmwLm2DGBP93EeY1U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cY7QhghB2SGSrclHniHyWZdhbfNNJcmX5bhxLJ3jllmTXdS0D2E0gVXK1YZ+pjfgGxFjnN0I7JjlVjncMINWHaHbTj7Bzxz4rTBJZ+kiy483nbTu6Hj/McklMtEjowCk95sHAa+swofSeihjW4mNHQBjMWe/n8/AHKNrguDJ8c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hzWMI1Qr; arc=fail smtp.client-ip=52.101.193.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ju6dWOuM7oa5BAnfBi35byJYQeHdivxl7ZpWANxfRkd3htiMaERZeNQ5FSx6Ks7PACJynDBxXNEzZPMwz79vU8ulxxAYfGjkoRa6FzNtmx5vAx/TByXnd51n7APtrKH01IBa0qGATw9OVbQcK0ROk4670JKiKRscNaY+QtpTHa25ZrSmzsZcblgPvW6r89nOLOm4jrgzL4iLVwY+lkS2dRwJs+LzbNU27snxcbhGkKzbUPYktI4hYcjIr68ynGpUNddCvXs9B9T3Aj7bJw4nvu4ErCq3oBpWAumEfsYJxeK9dfv2z7On9f/PrPOjqvH8JTjpOw+jcArGk54sPmrjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxVOicTx+Kt457oktQ9FPfGBqJC3whauMUlmQgX51D4=;
 b=xgys1A7CPD34UqGSR+fMEQCH3L7YASUF1o51pIaim87SYIbp4TLhgiZqiIkC2V0cXDlmVyekjWFTSndMRWjFIYfDxox0FVjosBvTkk0K+mTW1gkom5uQBPp1BkuIggc0I5tpcK3ZEqpOP8oy7lPbWLIQzod+rrWjINNzDgqJhVC0E9Qa/g13W6pKnn1lOFPnSWFlJoUOuYKk4cWY6iydFk87JKmX6QmfDKFy6ln0rOPbdruf8ZMr1MJXgDlsrxzw1E+W+/lEQN+CHlyZpyUUjdyrFEr+soQffTPflrH9Q2xW8OicyD2GCd2Cs4TlK1Ow30Bpr4RXsrypgilQE7czxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxVOicTx+Kt457oktQ9FPfGBqJC3whauMUlmQgX51D4=;
 b=hzWMI1Qr2ruBpHIAdHUJ6VjxyBuODziaQHPLv+AUoaaNIqs/8r0eQBwtVY9ucMwDV9bV4bS1jiHp7oL3m4PgtotgLvCGxajHtFd3FLipp90hSMXaxEvNdcre7ZlXkVdXxnZBb1mf6IgVfe/jKxxe1Hw/rmAh4xX7HvOQdE289T8=
Received: from BYAPR05CA0073.namprd05.prod.outlook.com (2603:10b6:a03:e0::14)
 by IA0PR10MB6746.namprd10.prod.outlook.com (2603:10b6:208:43e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 11:56:58 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::33) by BYAPR05CA0073.outlook.office365.com
 (2603:10b6:a03:e0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.5 via Frontend Transport; Wed,
 12 Nov 2025 11:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:56:56 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:53 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:56:53 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:56:53 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxc62638977;
	Wed, 12 Nov 2025 05:56:47 -0600
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
Subject: [PATCH v8 16/18] media: cadence: csi2rx: Support runtime PM
Date: Wed, 12 Nov 2025 17:24:57 +0530
Message-ID: <20251112115459.2479225-17-r-donadkar@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|IA0PR10MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 85691873-2d09-4c75-2e99-08de21e29433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bk9b6h3D1GmHfe1jKR8kbwlBAFpXXFYwosdIDdQoVDFfBk+Oer8fa/U2AkNy?=
 =?us-ascii?Q?grXuD+9FTD5J3WCaRO3hTNwC4XEZCA1DBKfIOYTRf3mWGHCeeBp2mo5Ju4gk?=
 =?us-ascii?Q?LF5nTk2ACj7JahZ+0LNE+admQX8iRt9mLFMhTqPbyiXUWegwkiPxD06z3OcD?=
 =?us-ascii?Q?6U2tOJPpE0+em4+wCDwYf7WKVi0TNNP/3H/G9e4bUBN7G3vnhGHfGvtcy5g/?=
 =?us-ascii?Q?bMmJmCrnpmi0hmLhIulBB1FESJXXDVs0h7zCmgydPvgvj+P/vq/PE1n0/GxH?=
 =?us-ascii?Q?cb9ijOxH6+bHJkb3D7pz5zYlJo+oSYplf37Bs+BH6D+VrsvkYAIUSEAghOEQ?=
 =?us-ascii?Q?hVPZIhSh6JF0kKaty0NpnzJVmJewmaeBQzTMRpXV/KjUWixVdNPJVf8bh6Dx?=
 =?us-ascii?Q?VG894QvjU/eoBG8a76NDYL5GF4KF8Fg2AxkwlisWohWV81lpUGNgxFxyqdwS?=
 =?us-ascii?Q?PhbhyMG/AKG69kGTlmEa6Evbq64uTaEzSXw9PLzjwVPVikbAJKsCyeXEb9sM?=
 =?us-ascii?Q?e7foYTgY7OUq6fLj/m96JrT4Cc4HSZFMtQ2vngYbLZmjnV1+xCqbOcitddZs?=
 =?us-ascii?Q?K7i9UIYszzFQSoKjnswkpeDDfVe74ChgwI4nEW8sGQ8elT6XTnpYtNjE8j6n?=
 =?us-ascii?Q?LUYLyboZ0q10GvBt20oLeUAlm99yTVBFwKSWR91iY4nOrYSDcUi0vcZDpyyC?=
 =?us-ascii?Q?16QQhw3Oy28Q0/NzhSxQCC6JOmsclx6Y8DqpHM3i9B8jKH5RxnsfhQMucwr6?=
 =?us-ascii?Q?rLZ/qIiHNhlnKpSWK2WXL0hBDE/4mIDedWzNbLsUu4hvRx73bpPyjiTN8p3q?=
 =?us-ascii?Q?XgR9L9owBY1NGFzm9s0+wyj9fdgZ0b7QnWgHhTR8+cD940vTLPwnZi5YBCYJ?=
 =?us-ascii?Q?rzpmv3oNIbXqQHNLofKVjbjIR0bObqJ66s5PpZtN43iVijbeXReuxn/BPgyn?=
 =?us-ascii?Q?O2GBhCMFRRdLjhBtqLXyw9ATEo91qEjhYMgSvHe6kvxEYKJRMXAbNRnmPMzO?=
 =?us-ascii?Q?cGWvWXPguHJ92AhrfAjFV7WAGSKn1jjqqzO58I9u7/QnIkQaQSb6Hf1VWakf?=
 =?us-ascii?Q?6j2Yut/B40YQeEAQ2PfXp6Wxo3TnSLaZ3cPOCy4TUUiekWOPcC2UTcekxqSx?=
 =?us-ascii?Q?hLzp+H1UwtQSb699TkfTRsgfspT/YuGn0QKFmc2BmDsoB9mfy+17f09iVddP?=
 =?us-ascii?Q?jSFQ0v5RNCm/gVO9qiKevw/1K9X19ka0XsPo5DC/vPIVuk7azAqti5JHr4/T?=
 =?us-ascii?Q?NSpZXPRwRSpN7BBMVMUpicKBCPEgClg5Sp2jnC77+sTjaGX9jRJdWFSMA5ya?=
 =?us-ascii?Q?emwqKpUJ8ebhCLHC1L2azhZoPKL742dq+mwNUFiasfAOH4Tld0OjoKsWS4xt?=
 =?us-ascii?Q?4joJ+f82vI0xhsWzBcXKIFdyQ3AON5J0WStJWEIyquEf9PDJRiHoYolFWQNt?=
 =?us-ascii?Q?oTl53QTCWWn2fhL3t4JUivycUqG5bU/U0dZc8qLlLHPKQfxbRkAlSm+s5xG+?=
 =?us-ascii?Q?pFn2iWa19GK1auzOMxbdytp1SEy2XUNxVAUTslA0HiukiYD8BIi6l06C48cc?=
 =?us-ascii?Q?4fddJy0iGpFrdQ+dNzo=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:56:56.4913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85691873-2d09-4c75-2e99-08de21e29433
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6746

From: Changhuang Liang <changhuang.liang@starfivetech.com>

Use runtime power management hooks to save power when CSI-RX is not in
use.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Tested-by: Rishikesh Donadkar <r-donadkar@ti.com>
Reviewed-by: Rishikesh Donadkar <r-donadkar@ti.com>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
---
 drivers/media/platform/cadence/Kconfig       |   1 +
 drivers/media/platform/cadence/cdns-csi2rx.c | 129 ++++++++++++-------
 2 files changed, 83 insertions(+), 47 deletions(-)

diff --git a/drivers/media/platform/cadence/Kconfig b/drivers/media/platform/cadence/Kconfig
index 1aa608c00dbce..ea85ef82760e6 100644
--- a/drivers/media/platform/cadence/Kconfig
+++ b/drivers/media/platform/cadence/Kconfig
@@ -5,6 +5,7 @@ comment "Cadence media platform drivers"
 config VIDEO_CADENCE_CSI2RX
 	tristate "Cadence MIPI-CSI2 RX Controller"
 	depends on VIDEO_DEV
+	depends on PM
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
 	select V4L2_FWNODE
diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 833bc134f17cb..6447c225ba354 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -337,11 +337,6 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 	u32 reg;
 	int ret;
 
-	ret = clk_prepare_enable(csi2rx->p_clk);
-	if (ret)
-		return ret;
-
-	reset_control_deassert(csi2rx->p_rst);
 	csi2rx_reset(csi2rx);
 
 	if (csi2rx->error_irq >= 0)
@@ -382,7 +377,7 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 		if (ret) {
 			dev_err(csi2rx->dev,
 				"Failed to configure external DPHY: %d\n", ret);
-			goto err_disable_pclk;
+			return ret;
 		}
 	}
 
@@ -397,12 +392,6 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 	 * hence the reference counting.
 	 */
 	for (i = 0; i < csi2rx->max_streams; i++) {
-		ret = clk_prepare_enable(csi2rx->pixel_clk[i]);
-		if (ret)
-			goto err_disable_pixclk;
-
-		reset_control_deassert(csi2rx->pixel_rst[i]);
-
 		writel(CSI2RX_STREAM_CFG_FIFO_MODE_LARGE_BUF |
 			       FIELD_PREP(CSI2RX_STREAM_CFG_NUM_PIXELS_MASK,
 					  csi2rx->num_pixels[i]),
@@ -415,30 +404,8 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 		       csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
 	}
 
-	ret = clk_prepare_enable(csi2rx->sys_clk);
-	if (ret)
-		goto err_disable_pixclk;
-
-	reset_control_deassert(csi2rx->sys_rst);
-
-	clk_disable_unprepare(csi2rx->p_clk);
 
 	return 0;
-
-err_disable_pixclk:
-	for (; i > 0; i--) {
-		reset_control_assert(csi2rx->pixel_rst[i - 1]);
-		clk_disable_unprepare(csi2rx->pixel_clk[i - 1]);
-	}
-
-	if (csi2rx->dphy) {
-		writel(0, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
-		phy_power_off(csi2rx->dphy);
-	}
-err_disable_pclk:
-	clk_disable_unprepare(csi2rx->p_clk);
-
-	return ret;
 }
 
 static void csi2rx_stop(struct csi2rx_priv *csi2rx)
@@ -447,10 +414,6 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
 	u32 val;
 	int ret;
 
-	clk_prepare_enable(csi2rx->p_clk);
-	reset_control_assert(csi2rx->sys_rst);
-	clk_disable_unprepare(csi2rx->sys_clk);
-
 	writel(0, csi2rx->base + CSI2RX_ERROR_IRQS_MASK_REG);
 
 	for (i = 0; i < csi2rx->max_streams; i++) {
@@ -465,14 +428,8 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
 		if (ret)
 			dev_warn(csi2rx->dev,
 				 "Failed to stop streaming on pad%u\n", i);
-
-		reset_control_assert(csi2rx->pixel_rst[i]);
-		clk_disable_unprepare(csi2rx->pixel_clk[i]);
 	}
 
-	reset_control_assert(csi2rx->p_rst);
-	clk_disable_unprepare(csi2rx->p_clk);
-
 	if (csi2rx->dphy) {
 		writel(0, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
 
@@ -548,10 +505,17 @@ static int csi2rx_enable_streams(struct v4l2_subdev *subdev,
 	 * enable the whole controller.
 	 */
 	if (!csi2rx->count) {
+		ret = pm_runtime_resume_and_get(csi2rx->dev);
+		if (ret < 0)
+			return ret;
+
 		csi2rx_update_vc_select(csi2rx, state);
+
 		ret = csi2rx_start(csi2rx);
-		if (ret)
+		if (ret) {
+			pm_runtime_put(csi2rx->dev);
 			return ret;
+		}
 	}
 
 	/* Start streaming on the source */
@@ -561,8 +525,10 @@ static int csi2rx_enable_streams(struct v4l2_subdev *subdev,
 		dev_err(csi2rx->dev,
 			"Failed to start streams %#llx on subdev\n",
 			sink_streams);
-		if (!csi2rx->count)
+		if (!csi2rx->count) {
 			csi2rx_stop(csi2rx);
+			pm_runtime_put(csi2rx->dev);
+		}
 		return ret;
 	}
 
@@ -589,8 +555,10 @@ static int csi2rx_disable_streams(struct v4l2_subdev *subdev,
 	csi2rx->count--;
 
 	/* Let the last user turn off the lights. */
-	if (!csi2rx->count)
+	if (!csi2rx->count) {
 		csi2rx_stop(csi2rx);
+		pm_runtime_put(csi2rx->dev);
+	}
 
 	return 0;
 }
@@ -1092,6 +1060,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_cleanup;
 
+	pm_runtime_enable(csi2rx->dev);
 	ret = v4l2_async_register_subdev(&csi2rx->subdev);
 	if (ret < 0)
 		goto err_free_state;
@@ -1106,6 +1075,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 
 err_free_state:
 	v4l2_subdev_cleanup(&csi2rx->subdev);
+	pm_runtime_disable(csi2rx->dev);
 err_cleanup:
 	v4l2_async_nf_unregister(&csi2rx->notifier);
 	v4l2_async_nf_cleanup(&csi2rx->notifier);
@@ -1124,9 +1094,73 @@ static void csi2rx_remove(struct platform_device *pdev)
 	v4l2_async_unregister_subdev(&csi2rx->subdev);
 	v4l2_subdev_cleanup(&csi2rx->subdev);
 	media_entity_cleanup(&csi2rx->subdev.entity);
+	pm_runtime_disable(csi2rx->dev);
 	kfree(csi2rx);
 }
 
+static int csi2rx_runtime_suspend(struct device *dev)
+{
+	struct csi2rx_priv *csi2rx = dev_get_drvdata(dev);
+	unsigned int i;
+
+	reset_control_assert(csi2rx->sys_rst);
+	clk_disable_unprepare(csi2rx->sys_clk);
+
+	for (i = 0; i < csi2rx->max_streams; i++) {
+		reset_control_assert(csi2rx->pixel_rst[i]);
+		clk_disable_unprepare(csi2rx->pixel_clk[i]);
+	}
+
+	reset_control_assert(csi2rx->p_rst);
+	clk_disable_unprepare(csi2rx->p_clk);
+
+	return 0;
+}
+
+static int csi2rx_runtime_resume(struct device *dev)
+{
+	struct csi2rx_priv *csi2rx = dev_get_drvdata(dev);
+	unsigned int i;
+	int ret;
+
+	ret = clk_prepare_enable(csi2rx->p_clk);
+	if (ret)
+		return ret;
+
+	reset_control_deassert(csi2rx->p_rst);
+
+	for (i = 0; i < csi2rx->max_streams; i++) {
+		ret = clk_prepare_enable(csi2rx->pixel_clk[i]);
+		if (ret)
+			goto err_disable_pixclk;
+
+		reset_control_deassert(csi2rx->pixel_rst[i]);
+	}
+
+	ret = clk_prepare_enable(csi2rx->sys_clk);
+	if (ret)
+		goto err_disable_pixclk;
+
+	reset_control_deassert(csi2rx->sys_rst);
+
+	return 0;
+
+err_disable_pixclk:
+	for (; i > 0; i--) {
+		reset_control_assert(csi2rx->pixel_rst[i - 1]);
+		clk_disable_unprepare(csi2rx->pixel_clk[i - 1]);
+	}
+
+	reset_control_assert(csi2rx->p_rst);
+	clk_disable_unprepare(csi2rx->p_clk);
+
+	return ret;
+}
+
+static const struct dev_pm_ops csi2rx_pm_ops = {
+	RUNTIME_PM_OPS(csi2rx_runtime_suspend, csi2rx_runtime_resume, NULL)
+};
+
 static const struct of_device_id csi2rx_of_table[] = {
 	{ .compatible = "starfive,jh7110-csi2rx" },
 	{ .compatible = "cdns,csi2rx" },
@@ -1141,6 +1175,7 @@ static struct platform_driver csi2rx_driver = {
 	.driver	= {
 		.name		= "cdns-csi2rx",
 		.of_match_table	= csi2rx_of_table,
+		.pm		= &csi2rx_pm_ops,
 	},
 };
 module_platform_driver(csi2rx_driver);
-- 
2.34.1


