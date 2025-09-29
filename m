Return-Path: <linux-kernel+bounces-835885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE068BA8435
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A703A4DE6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7202C0282;
	Mon, 29 Sep 2025 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1iO/Av5u"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538982110E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131507; cv=fail; b=EF2B9jReh3b23oXV1F+Eduw/APUGjV+QyPkpxxOWJJywN66j1w4qpFVfcRqnx6PpyY1cxA1MDcVRPpNV1tMn53Um9550ZrXy6Yo+vBTUIjwYp4iGace0P5oKBB5kRGeyrY1krDVUZEaJ0OYSN8RARGEP7gnafK6L9hbueL00A60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131507; c=relaxed/simple;
	bh=9InhNtjHzPmcq5okkk9cVztk0AdyJI+GpjfOxGE7Dsw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLA4Q6YZYDWq5jy36ycj381phtb1xg5vUap+wHKAK+m4bHtvhSyE8v2dckwiKeHBiVPNbFSkP5jAYmURIH9NdAr+tgU8ZnApVvmhVW4GiF0+xb/ki/TbrjgwKCoAOf86/pYe+a8C7n7fjpsVfMVgX5zUnxnkVEYcH+rg61i7vz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1iO/Av5u; arc=fail smtp.client-ip=52.101.46.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abTejoXL2iC2+gsY6mfdORfn+a6Sz0YfZVkZ052l+fD2x0WITiT2QTkhY4XGJXcyOjOIScVimB+vDh5u/0P9sOzXl5CxUvmhPihnF4vHwHKoS7cFGFSyl6K9jtuzAKymT+s5qO3OS3N1O9DxCyXIUNARnS9A1+EaLVjCHSmKD/WvvXrtFS51LckqbSEhMFgAqh3ikhflxlcEWkAx79bo8JBMBT2PFV0mBDGLJSSnVIHRxkdhDUoRaTraDhkOKm8g9GgN5Z43cUV1Q8dlS6YlqdcJCI5zmoP8wj+QBWFBorckwr6Nl/3TdDshPGMEn3Dcn+Pw/td7qUXa2Tb1cAcI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkFA7lZHHJ2lADLG9juKzzsOf7dBEPZqf85miPqn4EY=;
 b=KeLTs2/6pCKGTxg2mDcznwiXEYz1jDLblhyRakMdDydJq3PpLFkJFA4trc3VbXhOXT+hss/cEwqSKGFzDuaCzTg8vOXyxBBq04G+lLwzPy39yT+gzu1wZHTl/hmfYxkGHAllfjQ8msySBgDsZvh+bjUEIFnta6kPHRzhsGCB1VOImj0bLX3MLgHvebSgstb3s72wVHzuQK3Ch1MQIGaj7+MIMla63UHirdA/hIdE1XfNQQqSTbZIBXc+q1kg/nGL56eQZPlSpQxNKSmnuPJaF55lIn8o2CNEe/3DCy49TlaI3KG0BjvQcfb44AAD7rchaTLuRTaNJGxaiefVluJEaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkFA7lZHHJ2lADLG9juKzzsOf7dBEPZqf85miPqn4EY=;
 b=1iO/Av5uTmSX3c/1UoOofCHTThORSv+0+P9ieW72MliEi/7XSlYZzga+lDlRNTXC9vX146cevEOUR89AN6z2oj1AIm4RheVZezEWQGCdkIP2bt1r4dfTHfEZLbCF16H/L0mOvlkNiadH8BoI+fRxgE0JmCqGxLVH86vQbQDT9mk=
Received: from SA1P222CA0035.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::10)
 by IA0PR12MB8838.namprd12.prod.outlook.com (2603:10b6:208:483::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 29 Sep
 2025 07:38:22 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::23) by SA1P222CA0035.outlook.office365.com
 (2603:10b6:806:2d0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 07:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 07:38:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 00:38:06 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 00:38:05 -0700
Received: from xhdharinit40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 29 Sep 2025 00:38:03 -0700
From: Harini T <harini.t@amd.com>
To: <jassisinghbrar@gmail.com>, <michal.simek@amd.com>, <peng.fan@nxp.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, Harini T <harini.t@amd.com>
Subject: [PATCH V2 4/4] mailbox: zynqmp-ipi: Fix SGI cleanup on unbind
Date: Mon, 29 Sep 2025 13:07:23 +0530
Message-ID: <20250929073723.139130-5-harini.t@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929073723.139130-1-harini.t@amd.com>
References: <20250929073723.139130-1-harini.t@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|IA0PR12MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 35af5335-d517-4305-2217-08ddff2b2a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AWdWXj/w6OAhwhVGG4kRIzzkgcrA/bQlaKn0fntRLLfJN0PkAqcPQSEsN+ed?=
 =?us-ascii?Q?7MMv6EClrIab27DMQneUC4uwLWX5mH+sfEygsdvtvTTcOoQWasH2YY6DyVMJ?=
 =?us-ascii?Q?BekE9AyKwU7zBOkjomRCCKi9yrsrCjWtZtbXC5bkFk4wk62/WIAkb4hQ75XW?=
 =?us-ascii?Q?hcfuF3yAiS09+TVbGIL/1IgqIidyevw33aJcaI9XkaIBPG1rm8WxaDnBHNcf?=
 =?us-ascii?Q?MyPugwUhzPaco5iH+zOmZkvf/ZDdGQ+9hjMndl6uwNUm+uBYphBOL3egiTDY?=
 =?us-ascii?Q?9yD9KfpbFhzasJdxHBp8AD7FyDr+wljK2eWP1llLkmzFoAFiGPEXraOyzUN/?=
 =?us-ascii?Q?u2/89RQpKeBAtRnkN4W+tcJNaI36AHY1KUmi74MNQ0KifAUYi75OkTQq6nhp?=
 =?us-ascii?Q?beNrgtmirmGbdV9fBJN02Qyegn/lB2lpUTHORUCNUVZzxofJj5CXesZgHsf1?=
 =?us-ascii?Q?8LCGKKFcDJQ+kDzKV6T+OEpJl1ZqvbXDAFMsvPCV9C+StF1tLeUQoC2EA1LH?=
 =?us-ascii?Q?M7y4FvkT05dmD4l17GVMxTXmQBbBgPBs8ua4BMhK3rofgV1klLGzMSEAPRm4?=
 =?us-ascii?Q?icMDTJa4IotJAAIdQa/wGsXVNFeyENemMVveBQgUmRycDNrcqPdNTr7VqSDY?=
 =?us-ascii?Q?imaeQvgyxqMCjURz6L8gwXa2aeuoUbjKiqSiTrA6WRNIDFKuiukWlhBqhVz2?=
 =?us-ascii?Q?htco8t5W5JTuiJMfMhsgJIfOl45D+jH5pLFSlaUXIPl+uJnp1hYklHqrGk2D?=
 =?us-ascii?Q?SlniO3Ulhnq/fTdJTERYdcRb+40LoLHmBGJ/S9Xl5l8VGoUov4Kih8jJrTQb?=
 =?us-ascii?Q?ZfoeyoDgWCntyC2gP/X5Uk5GDnmDz81zOUIJ2GJLmjmZE2LeqBWeDRmefAM5?=
 =?us-ascii?Q?uXCtP2kND1iEMXMh5NLDFA16jV2owLbR0WQF7mM/Jv/kl1jXkUqGSnPT95Ia?=
 =?us-ascii?Q?yZHgDgkzcvwFhBCHeD3dYCY9SBG1AzfJ5Xy2Fl2ZJVPnvyWNZFfHmQ//2jt/?=
 =?us-ascii?Q?fsy5t9pJYAaNqj4KSz7UC7mlfDLQ762/bH6JgmRHv3S7CeRIrTT79vL8wgXQ?=
 =?us-ascii?Q?eREZO21gnc+g264s8cpe5TtPGqnVW3v7XePYWlZLSLzx6fmIPgtq4ZIqxbrx?=
 =?us-ascii?Q?5+VATcVGyVbMoFe5mcx/7jvf0rHsV36QAXkDyLwZLE1slqOUxkBp+wAka0nL?=
 =?us-ascii?Q?kA0Og/miDyTZG6dqjK+4E9U/yeMm+pHOFOiKPZKvUj5XBquBcqyp49uml3d8?=
 =?us-ascii?Q?m/O/kirZP4qbIeKOlP+6uJYAg64mFTA5qhepGMUcqAhPYbnI9txsaOa5ZfzR?=
 =?us-ascii?Q?xrrQousaVp9I1Bp/GykcBnDFDceGZhIcMZaptqZC8E3etc3VU8mQnQuLHMc4?=
 =?us-ascii?Q?7cQN2X47CLVhKK65qXyWkBsRjmY54nXH8kLHSmLGYw1WDylJaDWd5eltasRU?=
 =?us-ascii?Q?OZFcb7EAD8uH5yVscu4gTCxYzRbC+CWVZ4QJYXLG293SnwU+6/jy3GQIaqfi?=
 =?us-ascii?Q?zhD04B48l94C+Rg1waqXE8nFiXZkZMKLWOVn2uZjdzJr2XKcoiO9sAUHnWE0?=
 =?us-ascii?Q?FDziPNk6qowYX9Xo8rg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 07:38:21.6827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35af5335-d517-4305-2217-08ddff2b2a77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8838

The driver incorrectly determines SGI vs SPI interrupts by checking IRQ
number < 16, which fails with dynamic IRQ allocation. During unbind,
this causes improper SGI cleanup leading to kernel crash.

Add explicit irq_type field to pdata for reliable identification of SGI
interrupts (type-2) and only clean up SGI resources when appropriate.

Fixes: 6ffb1635341b ("mailbox: zynqmp: handle SGI for shared IPI")
Signed-off-by: Harini T <harini.t@amd.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index dddbef6b2cb8..967967b2b8a9 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -62,7 +62,8 @@
 #define DST_BIT_POS	9U
 #define SRC_BITMASK	GENMASK(11, 8)
 
-#define MAX_SGI 16
+/* Macro to represent SGI type for IPI IRQs */
+#define IPI_IRQ_TYPE_SGI	2
 
 /*
  * Module parameters
@@ -121,6 +122,7 @@ struct zynqmp_ipi_mbox {
  * @dev:                  device pointer corresponding to the Xilinx ZynqMP
  *                        IPI agent
  * @irq:                  IPI agent interrupt ID
+ * @irq_type:             IPI SGI or SPI IRQ type
  * @method:               IPI SMC or HVC is going to be used
  * @local_id:             local IPI agent ID
  * @virq_sgi:             IRQ number mapped to SGI
@@ -130,6 +132,7 @@ struct zynqmp_ipi_mbox {
 struct zynqmp_ipi_pdata {
 	struct device *dev;
 	int irq;
+	unsigned int irq_type;
 	unsigned int method;
 	u32 local_id;
 	int virq_sgi;
@@ -887,7 +890,7 @@ static void zynqmp_ipi_free_mboxes(struct zynqmp_ipi_pdata *pdata)
 	struct zynqmp_ipi_mbox *ipi_mbox;
 	int i;
 
-	if (pdata->irq < MAX_SGI)
+	if (pdata->irq_type == IPI_IRQ_TYPE_SGI)
 		xlnx_mbox_cleanup_sgi(pdata);
 
 	i = pdata->num_mboxes - 1;
@@ -956,14 +959,16 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 		dev_err(dev, "failed to parse interrupts\n");
 		goto free_mbox_dev;
 	}
-	ret = out_irq.args[1];
+
+	/* Use interrupt type to distinguish SGI and SPI interrupts */
+	pdata->irq_type = out_irq.args[0];
 
 	/*
 	 * If Interrupt number is in SGI range, then request SGI else request
 	 * IPI system IRQ.
 	 */
-	if (ret < MAX_SGI) {
-		pdata->irq = ret;
+	if (pdata->irq_type == IPI_IRQ_TYPE_SGI) {
+		pdata->irq = out_irq.args[1];
 		ret = xlnx_mbox_init_sgi(pdev, pdata->irq, pdata);
 		if (ret)
 			goto free_mbox_dev;
-- 
2.43.0


