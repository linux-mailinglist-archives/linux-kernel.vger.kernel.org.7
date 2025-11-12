Return-Path: <linux-kernel+bounces-897149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57122C52276
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2E63B5D18
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5F7316185;
	Wed, 12 Nov 2025 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="deevkO+6"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6D2314D05;
	Wed, 12 Nov 2025 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948547; cv=fail; b=dPh9pMygxgPMLuqdsctGi/U7siJgxS23MJZmw5iAQj0TWhy0uy/17w2KACOxIkyk3oD8/AjhaVuxVhiratVXhpmyUn4mRlUeqOxID0Vop4GhgNMgd1bkL2YFih3Mk/36Il4KDuKeRTNuMCERVgEEKkL2vEeb/edikHjFsZNUXrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948547; c=relaxed/simple;
	bh=2AzDDQ/c33gDTUejdZzmjwebk2IrQn3OwFoYgpL3lnQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cr6VceF8oC/+6D59uYUTjcfOjPMPz8koxBLxjvs21TkccxbbrnpfVCPjpILLBkW4xrwXXBjQmYcL708XTpEh0W1Psmd86Ksnk4ngbChcJsI1tnqvA4uKtkW9fm5zkhLO+ZACfR2x/xIKt8605iPh74Vp1y398bG7CnB2NCPcslY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=deevkO+6; arc=fail smtp.client-ip=52.101.46.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NR/4yjykcvgjK0UqeHkH7RGKM8jGrJU4iLloLlcTA3DCra5eG9QzOUYAaYZEqpgD17uWg1g4gjfJNRpoZHdB949EUZcAGu3LMwm5ZZeHqriPEnf2jnNRerz1qdt9wayEvJ0RNiQcRByFB/s3GfXmRGqqdszs80bY12P80qReFGCSd/AJmsVt8YF26ZvzYEQkiXnNCmwVsx6gdxfZ7tbE0t4/mgaRKODdsS4q2VCO3sid5hJ3NPwKki+wuw+1iEuHukiIM2Y9OsVEWEF0cldJY99OOTYdZ31aiVGF2+0pwV9ZTonRybjU+ArqIOtAPU6wEm88czOVhRTUXecJM+tKsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2uVnM4fJLG2Q8yNrNtcnhK4gAywDIJhuWg84A8RS4A=;
 b=QzU1IE/Z9NCialdX6UJAKpBbK/Kad/oOILEmSnxKg6BiNI9q2LzefCsWFT5MWGaLgqLcN/5gQYU3EP2Z73KGU+Da/QNAJhW9vw+qMlyNyqWc1xaJWItAWEVg6hz/pd0ERQA8QZD/Dmo23qR/iU1+K1b12TlpET5Ka1zEEbAOWNfr0A1xGsX1OHAzP0HFSYnmGUNbIf9yQTlbwmLvzCfEHUzx5ayjX0Nbp4JSCEypiaQHBon8/Q3DPt6jlSbF8n4FUknFlVL0nzJ69bEdABybfdGx7+6ErsuaFNUVJOCcDq6s1kXh5/UrfP2jVUXtFMl88Xs5LdEhSl6USfyMyui4yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2uVnM4fJLG2Q8yNrNtcnhK4gAywDIJhuWg84A8RS4A=;
 b=deevkO+6V9gq5IqLGSkVeEIlJpTIWfsBMzPX61Zpvxf0+RwFkUcxisjgAmn+4UWOPbz8g3/hmsGPO3BqQRvUDelwIACAjMc1b0iwpaIQHqByXxC+OLDMD4ls2+HBtkYQLNmLaZe8ZWBbftAHn2qBoyJ3qIC3leWDFntooGwQ5nY=
Received: from BYAPR02CA0048.namprd02.prod.outlook.com (2603:10b6:a03:54::25)
 by MW4PR10MB6348.namprd10.prod.outlook.com (2603:10b6:303:1ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 11:55:41 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::81) by BYAPR02CA0048.outlook.office365.com
 (2603:10b6:a03:54::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 11:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:55:39 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:55:33 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:55:33 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:55:33 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxbs2638977;
	Wed, 12 Nov 2025 05:55:27 -0600
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
Subject: [PATCH v8 04/18] media: ti: j721e-csi2rx: prepare SHIM code for multiple contexts
Date: Wed, 12 Nov 2025 17:24:45 +0530
Message-ID: <20251112115459.2479225-5-r-donadkar@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|MW4PR10MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 04773e69-2606-4cad-3e7c-08de21e2662c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EY1VPh+A8pYpruR3SE95qaPVgHvEjCLkzfAkf8XWFDnRf/g8SBv+nQxNo4W3?=
 =?us-ascii?Q?A3EBHTI1nliL5AXWlnvpdTmfgrn+b7dt4QHSJl1NkwV2rB9/CNlBJfKSHoPh?=
 =?us-ascii?Q?AS2Ou2RFUoGjSFSP9eFjFIfhT2BNat0AzVkOPhhf6dgRmSu/qgEw3owhflRy?=
 =?us-ascii?Q?Y28rH4s96eLeCeJ3bUvn7/y+S6JxeuqSKZlXTHmPeORtf24ZJJ8cM5SpiX+l?=
 =?us-ascii?Q?lR5CvXzxtsHIQ5Faj6BkVoAViBH5E2EBLlcemet14AUfY+/pPbcHK5kymz6z?=
 =?us-ascii?Q?ryCdJdqKtZ1mqlE6A6NzvOZ/VxOT+aTwIDaaSQSgXV+lxofsBeaoAvHAP7xe?=
 =?us-ascii?Q?7emsdZ6hEZk1AFbHnv1PwypUybT1tYLQzKYyR3wfjjkhPsxw1A0I91879dol?=
 =?us-ascii?Q?AXVjesJc0d1csCQ5lAPjUtxo1ywX+aJjnj46rqcRfUVSuIKTh9ve9c7h2W3v?=
 =?us-ascii?Q?QTS3C7JYSfzrD9TVBvGRt54lv9SNfzKT8VCVLu/nAdb8CQLkasEn37YI0Qsg?=
 =?us-ascii?Q?whc3/fh8wiKD5TsBWSBW8QC6nvt7MnzHZk7dToPL8jeKagcJAk9WH0xwlIo1?=
 =?us-ascii?Q?0u4/OAE+KsK4s7CyeDNgSla3sInq67qIVi2WGjAz2wzHgxEOboeaKYNh29/t?=
 =?us-ascii?Q?UCuT4kG50sFbOnRgewXdPzwlBbI3xN8l3LihkosqyMPIlIRpAoe7M3C4kvhG?=
 =?us-ascii?Q?wE8Dy3Dg8fCY7wR3oW71+h5HVYBCcv7AdJ6U1dXw86Smf6JtkJiCcTpV+L4V?=
 =?us-ascii?Q?7oEDGmd/CVwQ+Ku6gKYtpg0qUE82O2R+DmI3aMfCYdAD5PQjszv/Jdl5P4Bv?=
 =?us-ascii?Q?EVViGnlL7TjXOeffWGDoiAaJAPCwvlB+Y+EG7/O4ls2z3o3hxQrIqzZB5DJp?=
 =?us-ascii?Q?WR8+QCWB5AgKV87hikHPQoV4SKRS04/Z1lpEXwOI4zm9fm+iQby16NZv5wAW?=
 =?us-ascii?Q?l1uv45ikgEAbV3g9Y3Sel4yrcp3l+6vyolZUwlYAlPzc0YYA+1oFndwWQoFF?=
 =?us-ascii?Q?zxTuTvSJEbiHv8ZyBxVZm9u6acZzwblf9GkUCxYekbhOTZSM+aL5/bWa877i?=
 =?us-ascii?Q?lAdsFY5XLzjEJyEe3WiVvopXgJA0dWPbqCUZQPDspGqdk1FNSyK6QV+DBnat?=
 =?us-ascii?Q?EkTiznULr1XuXhzk8zPs1142LOOtX4Yp2O4wKX94J/CDUHsTrLUNXiY3pMSQ?=
 =?us-ascii?Q?36KYpqVcGVyMAUKN2fistYrUbXibbNx/WEbanM6lfJo8+yz3Jzk5jzW50uBi?=
 =?us-ascii?Q?QoTDlYj60MsYMQ85PmZ4Gm5jPr8l6CEqo1nZBfZ7sCtodaJSLANT3SrDrBcu?=
 =?us-ascii?Q?t5GVCHHI9n5LhTrtz+XZHbvQ/ETOvoo+IgbeKk9U8HjuUUoIU99fgfmBYF6s?=
 =?us-ascii?Q?jUA7e7lWv7ysHgfoHrnBwTfY+ByuSPZ/5FT0NQ97xknoMeTKyoPTTByXHWTQ?=
 =?us-ascii?Q?14+OLqB01VJVdqS47WeqzlVpguSXov44tGiNsgY+O+ObyDKBKIbkhMhZ2oCM?=
 =?us-ascii?Q?LWxfiPOzLQGG+kdYJCXsjaOd1EGKjBBbNnheGnVJ0ZahImVMy81dO9kk5zPi?=
 =?us-ascii?Q?aBphiFr3/4r+FQj0E18=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:55:39.2948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04773e69-2606-4cad-3e7c-08de21e2662c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6348

From: Pratyush Yadav <p.yadav@ti.com>

Currently the SHIM code to configure the context only touches the first
context. Add support for writing to the context's registers based on the
context index.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
---
 .../media/platform/ti/j721e-csi2rx/j721e-csi2rx.c  | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 23717a3b6c4cf..fdbe72df5c5f8 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -27,7 +27,7 @@
 #define SHIM_CNTL			0x10
 #define SHIM_CNTL_PIX_RST		BIT(0)
 
-#define SHIM_DMACNTX			0x20
+#define SHIM_DMACNTX(i)			(0x20 + ((i) * 0x20))
 #define SHIM_DMACNTX_EN			BIT(31)
 #define SHIM_DMACNTX_YUV422		GENMASK(27, 26)
 #define SHIM_DMACNTX_DUAL_PCK_CFG	BIT(24)
@@ -38,7 +38,7 @@
 #define SHIM_DMACNTX_SIZE_16		1
 #define SHIM_DMACNTX_SIZE_32		2
 
-#define SHIM_PSI_CFG0			0x24
+#define SHIM_PSI_CFG0(i)		(0x24 + ((i) * 0x20))
 #define SHIM_PSI_CFG0_SRC_TAG		GENMASK(15, 0)
 #define SHIM_PSI_CFG0_DST_TAG		GENMASK(31, 16)
 
@@ -568,11 +568,13 @@ static void ti_csi2rx_setup_shim(struct ti_csi2rx_ctx *ctx)
 		break;
 	}
 
-	writel(reg, csi->shim + SHIM_DMACNTX);
+	reg |= FIELD_PREP(SHIM_DMACNTX_SIZE, fmt->size);
+
+	writel(reg, csi->shim + SHIM_DMACNTX(ctx->idx));
 
 	reg = FIELD_PREP(SHIM_PSI_CFG0_SRC_TAG, 0) |
 	      FIELD_PREP(SHIM_PSI_CFG0_DST_TAG, 0);
-	writel(reg, csi->shim + SHIM_PSI_CFG0);
+	writel(reg, csi->shim + SHIM_PSI_CFG0(ctx->idx));
 }
 
 static void ti_csi2rx_drain_callback(void *param)
@@ -890,7 +892,7 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
 err_pipeline:
 	video_device_pipeline_stop(&ctx->vdev);
 	writel(0, csi->shim + SHIM_CNTL);
-	writel(0, csi->shim + SHIM_DMACNTX);
+	writel(0, csi->shim + SHIM_DMACNTX(ctx->idx));
 err:
 	ti_csi2rx_cleanup_buffers(ctx, VB2_BUF_STATE_QUEUED);
 	return ret;
@@ -905,7 +907,7 @@ static void ti_csi2rx_stop_streaming(struct vb2_queue *vq)
 	video_device_pipeline_stop(&ctx->vdev);
 
 	writel(0, csi->shim + SHIM_CNTL);
-	writel(0, csi->shim + SHIM_DMACNTX);
+	writel(0, csi->shim + SHIM_DMACNTX(ctx->idx));
 
 	ret = v4l2_subdev_call(csi->source, video, s_stream, 0);
 	if (ret)
-- 
2.34.1


