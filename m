Return-Path: <linux-kernel+bounces-750966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9526CB1636B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51C61AA3CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7632DC35A;
	Wed, 30 Jul 2025 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3YCnuxJ+"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720272D94BF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888354; cv=fail; b=VHyHnG/63XA4Peacz8wq8Drpq8pcKRkjA80LLAkepCoKm38Cpthy0Vxyfk3o2qGqQzzKttjE/07Ff8QQAHylha5nh9gbxFCXA9DGTClusTujB6cwAThkRhKtbsLRZLGXduwS4l1/S3Ido3ZHkjrMAyhHC3BGG8HUInERRV2qcSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888354; c=relaxed/simple;
	bh=XxIcJmfUqHfXRMwL0Qig4tXaH8cv67DsVV37G6CnHWU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CX/SLllMoMlLGj4Qr8KYtq4et6PNxGAjgP1h3F2WBsCPcGhTEfq5J1VZTlP/PJATWQj+HKDY7/BNDWsZa4vabV3vjEDsEqn7d3GWKdqSNEHVasvkrwgY0ENcOxGhFO7D0YhVne9YeXJvOIJ6d+ty8nwjmsKctWAmOxCihgvyxSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3YCnuxJ+; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1yZouHHQ8exK2jN43/BkA4s6nNWwlUAjBHHTTRY/UnsBbSTgNfLH8ZNxE1K7HIt6ioFoN9If+7e3GgW5mAf/D9Qd11Mq3BJwJPkwd81oLrrJl1gz7+52rN14noVXJy14n8PmWt9B0F4T7KiSrD0G8yxTXnlA4Ym4RoP541LeDR17wR5lb06ozX7Qbajpocsg7jV/hwqou8RVe19iRH7dgANP1Ub9n0fFP+EHc2UzuMxKliyGw0hLm8tWPpiVwTgvwGIBZPb2Cwln3OJrkQGSoy3stiUrlsB1/9OSqhpdgtKhZj8Nzss81kr7sfZz5cgWiupa9DRYIgTcf9ReRr9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbt2FutoBHhnVXem/WxUrdS+tYuVTR2v8hor1QlqEj0=;
 b=L74nCmAEIqMhlvmsRpqibhqL1oXvSiy+GLZENow0GC50t8AXauveuXre5TuSPsYwyCuZqKHK+ol/nM0cQSMSvwOk4S2F8+s4cQO2gTg+sdLbScSdp7QRLYv88xp1m6rev3ING6FM2wqYEyMMrINg33VEQQMkWgjN+5w5RIEeRZbV59ywRhCEBp6VLkxvoR9ZpZ7hO7sboxmTLDJfN0mlU2tYjsDTUXF8GwpUSCjElIFK1Y6pWeo+gvpzcqvqhjVYrfLep+BOP8KkH2ioV5hY/NXXnSltuW53Locg9Yc1eRneGCTBFINjmkI0CxU4O28WyhJptJD9DU1RMNSb9oWBZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbt2FutoBHhnVXem/WxUrdS+tYuVTR2v8hor1QlqEj0=;
 b=3YCnuxJ+HsQ9e6MbE5HoJ67qQsUxMb5GaLhVJ+IW2o2hOaLaTJz7O3kwZXBhj/5rnKGo66F7ZOH1SknnXs+/qcqPe/o1YqEEmR9JwRrgFkX6Lks0PVVxtPP2iyL138UV8YixXYIx9pvQjcG3Ssfbhkphab3F245BEQxbBjQ5fks=
Received: from SA9PR13CA0075.namprd13.prod.outlook.com (2603:10b6:806:23::20)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 15:12:29 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::14) by SA9PR13CA0075.outlook.office365.com
 (2603:10b6:806:23::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.10 via Frontend Transport; Wed,
 30 Jul 2025 15:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 15:12:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 10:12:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 10:12:13 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Jul 2025 10:12:10 -0500
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <alexandre.belloni@bootlin.com>, <Frank.Li@nxp.com>,
	<wsa+renesas@sang-engineering.com>, <quic_msavaliy@quicinc.com>,
	<Shyam-sundar.S-k@amd.com>, <xiaopei01@kylinos.cn>,
	<billy_tsai@aspeedtech.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <michal.simek@amd.com>, <radhey.shyam.pandey@amd.com>,
	<srinivas.goud@amd.com>, <shubhrajyoti.datta@amd.com>,
	<manion05gk@gmail.com>, Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH V2] i3c: dw: Add shutdown support to dw_i3c_master driver
Date: Wed, 30 Jul 2025 20:42:07 +0530
Message-ID: <20250730151207.4113708-1-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: manikanta.guntupalli@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|IA0PR12MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b417e4-56a4-4ff0-78e8-08ddcf7b7f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aG5Fjn4GO71mwUsc2MwU7ygacR8/qu7m2rOc5N+07hrm0ObLhPTJUizP5iX2?=
 =?us-ascii?Q?kyWoHUW9KrF+d8AlsnH+P1kyR7QEMV5XIAejptkifGgPbaLXJtEJcuhRmj+l?=
 =?us-ascii?Q?ABbCFJ+a19YX2YFs2s2UyoWwTFZUJONY5cbHxrlgavo6C8vFE8bBC4m3TaMh?=
 =?us-ascii?Q?NCN62nKcrKhyjilpq0Q4AkInxwbKVf6NQBXh3WU0qRxVBbk9s32x34CRA02x?=
 =?us-ascii?Q?dPfj0jYBpkaRSZsJwuCEA3ieW/rMtD5g9kFygY75+Zc9OKkmj6Nx1iP4a6jh?=
 =?us-ascii?Q?9H3lTRmeYZRy55E7oCOQHWu2ZzI8vVKqF6BijeiBDxM4NqFRIPgDg0yjUv8U?=
 =?us-ascii?Q?tB957L8Jn48AJWwD5yV8rA18O4B95ZgvpWcZ/sNM5+0C6iStb1eLVgwIAlVg?=
 =?us-ascii?Q?OPU0962378UhUledjVLSXU1xJ5dZf7yqEbcC68AmafiQSE64Xa8gMRr/F7/i?=
 =?us-ascii?Q?W72EnYug+i/4QbRMqjG6TDsAQBzS0uod2p8izwOEdqR4bufw28ixQhhe5agw?=
 =?us-ascii?Q?Qn9xNOkL2q318Ili5RoSh5yBNJU1w2+3S/ngGkaNgmGTFsyQRI5OXy2N2qoI?=
 =?us-ascii?Q?2TJIzD7Stdj605kVE0fadnT5FX2qsLF0tH10JEkBK3I3MrNKzDNa2ACDx4s1?=
 =?us-ascii?Q?I/+DoxMdRagMiA9LINfih2x6/aTqQ4cKuijMwHyPnn11IoXy12l+MG+Mmvj/?=
 =?us-ascii?Q?HS334phUX6rcCpy5hh+P4CXtoJpLr7kEt4J3UoIabE6tHuAsVje7df0pBRmH?=
 =?us-ascii?Q?TAKV2N/SI17NmiyR+uDqRUsA9gxKwPcJx2gICK3H9GprM4ctT5hSbZ1Z9FHY?=
 =?us-ascii?Q?tnIae91Kh32s6+Y2+7Hf7QnZdn0UgyJGQ30SJrNQ5IVr5EH9RBRlYQGiuqi6?=
 =?us-ascii?Q?uxp11yyKaf0Gr0JQAiFhxn48RFQHwKF5ruPsZbSxnBeTmAJuBSFl8ei7gD3K?=
 =?us-ascii?Q?Y34yL30iZ/i0HIyqsTSG+cdevob1I/A+XWS6O3b9YVXZJ98sNr36t+s3pYOu?=
 =?us-ascii?Q?mJW9Mbqvpul09XFq+yICP8lAig1nsJxaQfASPJtscOXyYNvxWGn3b55xxPLd?=
 =?us-ascii?Q?P3TFknKnsRhSZXpnOISdA4KcScxx5T9xSB3bv947bgJdOMp7iH1P33TsrFrf?=
 =?us-ascii?Q?j+wyqLsV03mcC+8z+Itm+qHJmnuy90N9VLle1pDcEnDheaaMTqMD8G8ZXkqs?=
 =?us-ascii?Q?SdSxBKeh7LXHIMGF/9UhsBlijxRZWLbwZNIzc/iJ/mEgL09gq8wigzgchL9y?=
 =?us-ascii?Q?jgPXeeJMcUrkw6ajxTCaUV56SEvtMAsSxUR3Ov3N+Cs0CjmCHLnry5qIkRax?=
 =?us-ascii?Q?RhsyY6juyyZ448geaveUk4Km9H4GuU67pfUGUGKD0MehuiZGnkgDIgzNmLDM?=
 =?us-ascii?Q?DsZdqQL+evIJoCHHRmzGmsa5CDATVCOktWjIi2drWyX0WDQagHxKD8dY8G2w?=
 =?us-ascii?Q?w6MFXlIB7N4YyME07dX3LiPM6yHF+dE2AvLrbeDQ2eA2iKgubsjCy7oyC6Mu?=
 =?us-ascii?Q?pdr/2hrZnDYTI+2tpXi0FXaPbaq2myk/Ht6/u8UO8tOTsD4yHldnpzEm9Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 15:12:27.7435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b417e4-56a4-4ff0-78e8-08ddcf7b7f2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046

Add shutdown handler to the Synopsys DesignWare I3C master driver,
ensuring the device is gracefully disabled during system shutdown.

The shutdown handler cancels any pending hot-join work and disables
interrupts.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Removed pm_runtime_mark_last_busy() call from the shutdown handler,
as it is being removed in the following commit.
https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com/
---
 drivers/i3c/master/dw-i3c-master.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index ae1992665673..2d16b7d74743 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1762,6 +1762,28 @@ static const struct dev_pm_ops dw_i3c_pm_ops = {
 	SET_RUNTIME_PM_OPS(dw_i3c_master_runtime_suspend, dw_i3c_master_runtime_resume, NULL)
 };
 
+static void dw_i3c_shutdown(struct platform_device *pdev)
+{
+	struct dw_i3c_master *master = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(master->dev);
+	if (ret < 0) {
+		dev_err(master->dev,
+			"<%s> cannot resume i3c bus master, err: %d\n",
+			__func__, ret);
+		return;
+	}
+
+	cancel_work_sync(&master->hj_work);
+
+	/* Disable interrupts */
+	writel((u32)~INTR_ALL, master->regs + INTR_STATUS_EN);
+	writel((u32)~INTR_ALL, master->regs + INTR_SIGNAL_EN);
+
+	pm_runtime_put_autosuspend(master->dev);
+}
+
 static const struct of_device_id dw_i3c_master_of_match[] = {
 	{ .compatible = "snps,dw-i3c-master-1.00a", },
 	{},
@@ -1777,6 +1799,7 @@ MODULE_DEVICE_TABLE(acpi, amd_i3c_device_match);
 static struct platform_driver dw_i3c_driver = {
 	.probe = dw_i3c_probe,
 	.remove = dw_i3c_remove,
+	.shutdown = dw_i3c_shutdown,
 	.driver = {
 		.name = "dw-i3c-master",
 		.of_match_table = dw_i3c_master_of_match,
-- 
2.34.1


