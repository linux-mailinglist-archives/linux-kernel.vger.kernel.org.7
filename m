Return-Path: <linux-kernel+bounces-897165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48836C52327
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B88A420121
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6EA3203A7;
	Wed, 12 Nov 2025 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GEDuGhhc"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010015.outbound.protection.outlook.com [40.93.198.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96FD31D754;
	Wed, 12 Nov 2025 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948635; cv=fail; b=N5KV7LHOMmALuDYokHituJhzbNY1dfDmHi5aFi19aXY77VeXaeoY+7+Y2oolqBKdbDKGXkLSC5yWLR+jsxa6WmbyUwJL+tFhf+/a7YGsVGCTaPKRjDQDpftGbEU+x6N8J40lcojdF7xbB2dZIE/oMl9Ug7ZE+Xq+4gIg/FH+Tsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948635; c=relaxed/simple;
	bh=Nr1PrbXwMuX0nSCp7TA9WI7crkAUq7SkOU9CyUX0UnY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jm1AKnQB2jvhC0lon+ukK6JTBcQiYvgy5oGqwYLlyITia3dZyAfMvSiaCSNXUqhTVnuvuQMMcXLwLlZG3vBBGKq3YnHuIa+msqfhjcfU/Ko1y59zzfzQ05qVvcOKEC8SyvzD6p+QVzHVTff1hk1bZR/7NVdXTIAigPx3OC62s8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GEDuGhhc; arc=fail smtp.client-ip=40.93.198.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUgiG3UuQA+kUD0fsQJHF1l/vhl0nSj0yXSoxYSG+csq3Fb/h6Bs7v6O/V/lmJGZBTi0S1XzvGbXTaB2Zl+1TyeK9Y3Gl/TJH+UGaug2krV/QUoNTtQZc6/ANSE45IZaf1aCJ7xXfk9j8yBU3qzFF9xWM+sx8TmEGgk6qRETKJ7NnFzP3B/RY/Aw/lnxq2+OF+rqiIjr1GkD4Yp+DwcvrOYQi1r+3diqlSOvwU+y+EELmxUzLHE/q7t19AJ+5vwK/wOl9rNI22cXn8AxBchcsaqPsvbe7WwdhpBq5/6oc6J/icGux7T4vuCEKiJBXHO+GgsDINllepJfKMr2ao9QaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0ywUqN8SSdsa3kItg25Z75RSMbsaix8dHLJhcXwP4E=;
 b=bLP7VttlMv6i4+U/v3x+vC8mdIUvRfkO8Yp6QrXTBXLHt7U2RxfKv/klLmYGRSmS5VYzxxxQzGUCviyASp1OaBTF2f1FiNpWJpLXpkZb5fkwplZAlanT0aHUuQ72SGL2pMnPV92sWOMUAhTV6kf17PWRdDIQMSWNPVnlKgvI4zhqhHpkcj7V3zakVlrXpmUfGKSZ6geK/svD3hmDy9O8SHKo/9azQYc8atPMJOKrrt6JqZiwopqFs8AO5r0sL/hvFRd9vga7nlpEka9+viLAIojkdA0495OaDYU9X26FN9rvjQu7Hnm0NEAA/YM7yI2POLfdQpHEpv6LJNiqENqsqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0ywUqN8SSdsa3kItg25Z75RSMbsaix8dHLJhcXwP4E=;
 b=GEDuGhhcbeuP2Pqhik0r361/s49nT3N5dZSDjdGGdZBVYxTlU+W8vBeNUVP3znKpwPbv6J7vk1ZxXL/M/qPouzGuc10eQ3Mma+VG0k2YN6GPjRdf8s9YMBC/+156W0wuB4FzMDFq9tUnTtcZYYGWj7OAh77IhX4j/BvHtMbKINs=
Received: from CH0PR03CA0262.namprd03.prod.outlook.com (2603:10b6:610:e5::27)
 by IA4PR10MB8588.namprd10.prod.outlook.com (2603:10b6:208:569::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 11:57:10 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::de) by CH0PR03CA0262.outlook.office365.com
 (2603:10b6:610:e5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 11:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:57:09 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:57:06 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:57:06 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:57:06 -0600
Received: from ws.dhcp.ti.com (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBsxc82638977;
	Wed, 12 Nov 2025 05:57:00 -0600
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
Subject: [PATCH v8 18/18] media: ti: j721e-csi2rx: Support system suspend using pm_notifier
Date: Wed, 12 Nov 2025 17:24:59 +0530
Message-ID: <20251112115459.2479225-19-r-donadkar@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|IA4PR10MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: a4496a03-d470-4e85-1571-08de21e29bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zirHu1hraz5Bf7h2gOH4qf2nNkHylwE2P9hV+0Q0L9Tdxy9Y9bqb+EjxTBj3?=
 =?us-ascii?Q?LVlipqyCTaOfXtCIjS0gTjFWRGvXLXsE0OASH/4RIDOEj6n9oix+GOPfp1QM?=
 =?us-ascii?Q?730AxYTQTM13qOfY5a7PmhAnCPT+sbs3/GPwU4YkHHLrvliBZ6qTa/ztXFwW?=
 =?us-ascii?Q?4sFMK8gQq38s7jWsT1WmZbsFK+8JEJ1P0ZVYeWppHjikGYnffBdzSb3oZeZZ?=
 =?us-ascii?Q?MTqmrdbKKZFQYGPm89EmaDHJg4i91178IUqUiBuN7/7VBRy2ewDFAMsrhhB8?=
 =?us-ascii?Q?M8oQC90vRpMOs/BuwZSaFlF4B0Y5itNzyeNMaZ/nfoBNod6UTF9zjDtTVMLx?=
 =?us-ascii?Q?TkBcjvzYXjYgm2cy3XUWZRCG2hPabECPeE1PuOMhe42LnCkoikcv/7RypFfe?=
 =?us-ascii?Q?6D9FdSXS5ON/Sio3VvMPPuTL7LTEYou8Nm9DsM9JMVRCz/Qc/FvKyyq1xH4D?=
 =?us-ascii?Q?rXBoDCyfeMO39jio+baPk4wrcicI9Wd62uyEXwfYYBc86WStQzVRrsENGwzX?=
 =?us-ascii?Q?RogKTZ9SVygFWn/wdz5WGgJy/Bvarr8mtLarbBIWlRIXdUHeHEDTcAElGGA3?=
 =?us-ascii?Q?4KNke9/dE9Sbeo/gNywDTu1q5ESeOYIk19G4tXHSkS7gpUFHQuOrLWjqQfCk?=
 =?us-ascii?Q?1uvsrSr4ti7V1dx9bhZw/sMhWL9h3HER0ADfpka2+fadO0/TTlXuqQYXFaVy?=
 =?us-ascii?Q?9rmksz40VDqOSqHDmINdqHsEW9cKpVgjwc5+c07v+o8X1SFAaLwWtoUFyrEf?=
 =?us-ascii?Q?wta3g9zkIb//VECbcNRIH8MO7AyE55ww299ERXRuY/PaZTLn9hKfYAdCZvgl?=
 =?us-ascii?Q?1rawPY10zpd5LR8HzEvX9CvpxONGM6lqJFPEQgOKMOtrgR6WqeqDcTtLPH65?=
 =?us-ascii?Q?/+i7terrwwmEJTJ70UEMzskHko723UH/rQC8Q9aerMNeQxAAZQKgT2iXMByV?=
 =?us-ascii?Q?73921chgXYpsFC/rMc3+9w+lDDMhpD7is/DECR/cZj7ojpTHT2G1Q/qdG2fs?=
 =?us-ascii?Q?UCnOHNwY3yneMH3wJqMUi7wIx7wXUFY0tCZCI/kV75IfpXJk9DGHX0a24BfZ?=
 =?us-ascii?Q?RB9jlTkbTayryo6AFP2TgJ4bkWwgZZ5QbqPJDPwrhgKIn9lRN3Xy1RRRNf5a?=
 =?us-ascii?Q?hn5eQGqTLLclLCCg1WAOsJJVNDPXuMoTVDR4Ogec+VIo3OIdCoLGStGPz2MM?=
 =?us-ascii?Q?bJdWawy8uqJ6P240JcormuIGLUttEk5uxMAwRqL734UK7a6RGiJotDkyX2lm?=
 =?us-ascii?Q?gnS2OV/Dviz4xUynBaTolLRbDrCnorg5QdBWIKKvao7Qtc8rteG5qIL4SSPG?=
 =?us-ascii?Q?taJc39gBrPTIDZ2gXYSoQfXd8zE1Nhg9IxZrmUvZ9QJQ/ca1a3ka2Hhebjxu?=
 =?us-ascii?Q?ZNzltE5oFPMmd+RwaVZJQNM+0DDIt3MVDBybTkHalO0q0W61wOJzPNFfZY30?=
 =?us-ascii?Q?L+JVY3KGc/N2kXrl6+axnwWcrEJdFdWIc31pI0NQEdcfnVNLJCKaKZ+KYO/g?=
 =?us-ascii?Q?Gj4VfsYUGH8k6yaCjrXuTVhPD7z2IRhYKfPGmWLXOFxQIYRWE1RpEnOc1+xz?=
 =?us-ascii?Q?j4FrEGxi05UnImx9704=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:57:09.3422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4496a03-d470-4e85-1571-08de21e29bd9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8588

From: Jai Luthra <jai.luthra@ideasonboard.com>

As this device is the "orchestrator" for the rest of the media
pipeline, we need to stop all on-going streams before system suspend and
enable them back when the system wakes up from sleep.

Using .suspend/.resume callbacks does not work, as the order of those
callbacks amongst various devices in the camera pipeline like the sensor,
FPD serdes, CSI bridge etc. is impossible to enforce, even with
device links. For example, the Cadence CSI bridge is a child device of
this device, thus we cannot create a device link with the CSI bridge as
a provider and this device as consumer. This can lead to situations
where all the dependencies for the bridge have not yet resumed when we
request the subdev to start streaming again through the .resume callback
defined in this device.

Instead here we register a notifier callback with the PM framework
which is triggered when the system is fully functional. At this point we
can cleanly stop or start the streams, because we know all other devices
and their dependencies are functional. A downside of this approach is
that the userspace is also alive (not frozen yet, or just thawed), so
the suspend notifier might complete before the userspace has completed
all ioctls, like QBUF/DQBUF/STREAMON/STREAMOFF.

Tested-by: Rishikesh Donadkar <r-donadkar@ti.com>
Reviewed-by: Rishikesh Donadkar <r-donadkar@ti.com>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
---
 .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 21e032c64b901..dd47758d51a90 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -131,6 +131,7 @@ struct ti_csi2rx_dev {
 	struct v4l2_subdev		*source;
 	struct v4l2_subdev		subdev;
 	struct ti_csi2rx_ctx		ctx[TI_CSI2RX_MAX_CTX];
+	struct notifier_block		pm_notifier;
 	u8				pix_per_clk;
 	/* Buffer to drain stale data from PSI-L endpoint */
 	struct {
@@ -1550,6 +1551,124 @@ static int ti_csi2rx_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int ti_csi2rx_suspend(struct device *dev)
+{
+	struct ti_csi2rx_dev *csi = dev_get_drvdata(dev);
+	enum ti_csi2rx_dma_state state;
+	struct ti_csi2rx_ctx *ctx;
+	struct ti_csi2rx_dma *dma;
+	unsigned long flags = 0;
+	int i, ret = 0;
+
+	/* If device was not in use we can simply suspend */
+	if (pm_runtime_status_suspended(dev))
+		return 0;
+
+	/*
+	 * If device is running, assert the pixel reset to cleanly stop any
+	 * on-going streams before we suspend.
+	 */
+	writel(0, csi->shim + SHIM_CNTL);
+
+	for (i = 0; i < csi->num_ctx; i++) {
+		ctx = &csi->ctx[i];
+		dma = &ctx->dma;
+
+		spin_lock_irqsave(&dma->lock, flags);
+		state = dma->state;
+		spin_unlock_irqrestore(&dma->lock, flags);
+
+		if (state != TI_CSI2RX_DMA_STOPPED) {
+			/* Disable source */
+			ret = v4l2_subdev_disable_streams(&csi->subdev,
+							  TI_CSI2RX_PAD_FIRST_SOURCE + ctx->idx,
+							  BIT(0));
+			if (ret)
+				dev_err(csi->dev, "Failed to stop subdev stream\n");
+		}
+
+		/* Stop any on-going streams */
+		writel(0, csi->shim + SHIM_DMACNTX(ctx->idx));
+
+		/* Drain DMA */
+		ti_csi2rx_drain_dma(ctx);
+
+		/* Terminate DMA */
+		ret = dmaengine_terminate_sync(ctx->dma.chan);
+		if (ret)
+			dev_err(csi->dev, "Failed to stop DMA\n");
+	}
+
+	return ret;
+}
+
+static int ti_csi2rx_resume(struct device *dev)
+{
+	struct ti_csi2rx_dev *csi = dev_get_drvdata(dev);
+	struct ti_csi2rx_ctx *ctx;
+	struct ti_csi2rx_dma *dma;
+	struct ti_csi2rx_buffer *buf;
+	unsigned long flags = 0;
+	unsigned int reg;
+	int i, ret = 0;
+
+	/* If device was not in use, we can simply wakeup */
+	if (pm_runtime_status_suspended(dev))
+		return 0;
+
+	/* If device was in use before, restore all the running streams */
+	reg = SHIM_CNTL_PIX_RST;
+	writel(reg, csi->shim + SHIM_CNTL);
+
+	for (i = 0; i < csi->num_ctx; i++) {
+		ctx = &csi->ctx[i];
+		dma = &ctx->dma;
+		spin_lock_irqsave(&dma->lock, flags);
+		if (dma->state != TI_CSI2RX_DMA_STOPPED) {
+			/* Re-submit all previously submitted buffers to DMA */
+			list_for_each_entry(buf, &ctx->dma.submitted, list) {
+				ti_csi2rx_start_dma(ctx, buf);
+			}
+			spin_unlock_irqrestore(&dma->lock, flags);
+
+			/* Restore stream config */
+			ti_csi2rx_setup_shim(ctx);
+
+			ret = v4l2_subdev_enable_streams(&csi->subdev,
+							 TI_CSI2RX_PAD_FIRST_SOURCE + ctx->idx,
+							 BIT(0));
+			if (ret)
+				dev_err(ctx->csi->dev, "Failed to start subdev\n");
+		} else {
+			spin_unlock_irqrestore(&dma->lock, flags);
+		}
+	}
+
+	return ret;
+}
+
+static int ti_csi2rx_pm_notifier(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	struct ti_csi2rx_dev *csi =
+		container_of(nb, struct ti_csi2rx_dev, pm_notifier);
+
+	switch (action) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_SUSPEND_PREPARE:
+	case PM_RESTORE_PREPARE:
+		ti_csi2rx_suspend(csi->dev);
+		break;
+	case PM_POST_SUSPEND:
+	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
+		ti_csi2rx_resume(csi->dev);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
 static const struct dev_pm_ops ti_csi2rx_pm_ops = {
 	RUNTIME_PM_OPS(ti_csi2rx_runtime_suspend, ti_csi2rx_runtime_resume,
 		       NULL)
@@ -1622,6 +1741,13 @@ static int ti_csi2rx_probe(struct platform_device *pdev)
 		goto err_notifier;
 	}
 
+	csi->pm_notifier.notifier_call = ti_csi2rx_pm_notifier;
+	ret = register_pm_notifier(&csi->pm_notifier);
+	if (ret) {
+		dev_err(csi->dev, "Failed to create PM notifier: %d\n", ret);
+		goto err_notifier;
+	}
+
 	pm_runtime_set_active(csi->dev);
 	pm_runtime_enable(csi->dev);
 	pm_request_idle(csi->dev);
@@ -1652,6 +1778,8 @@ static void ti_csi2rx_remove(struct platform_device *pdev)
 		ti_csi2rx_cleanup_ctx(&csi->ctx[i]);
 
 	ti_csi2rx_cleanup_notifier(csi);
+	unregister_pm_notifier(&csi->pm_notifier);
+
 	ti_csi2rx_cleanup_v4l2(csi);
 	mutex_destroy(&csi->mutex);
 	dma_free_coherent(csi->dev, csi->drain.len, csi->drain.vaddr,
-- 
2.34.1


