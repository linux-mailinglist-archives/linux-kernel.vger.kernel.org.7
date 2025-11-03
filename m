Return-Path: <linux-kernel+bounces-882440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A20C2A73D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A897E1882DE5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D482D3225;
	Mon,  3 Nov 2025 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ekTeyNX7"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazhn15010016.outbound.protection.outlook.com [52.102.128.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198732C158B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.128.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156771; cv=fail; b=TuUFnlirk+Qc31MT6Je8aYZgJmCVyhZdqfVhUM2z71eLiC3v7G7nXUCnF0E5WbEftcQKrOzapTj8sN/Ees8xwpTHljEah6DU9JI28BU7bYvXHgUzJrBKao9ZkmxlLcLHuCbz5ktVF+hQeLxZIMcKzgCJniSF6eAN1xta0AOvxRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156771; c=relaxed/simple;
	bh=cjV1kJ8p9nfwoliDfKPM5vWJ9lK5bi1oacNPHYOi4/k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lkiDpXQpI05dU2LW1ClSlNiLRP0azdVGdE5bna3Dw2wG1AqhP0FzI8v18iKlhpj+tdO91wFLVSvGVjABE8cdsUhR6MGQrop25q3NlgbOpYUZkfF4xO+mTgzKr/webSHISa1Rr2Z0XVBNgkuqwKhttsVfFI7OM56T/yRZDC4kQxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ekTeyNX7; arc=fail smtp.client-ip=52.102.128.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awh0KTIjb/GQPmIi6r0aVnGWNN6EwRaBg+UOgCUjkmsp9G2yFCxuN1/BaJk1FYvpdgJB7kjBjLp687oHz21iV/l3W4SemYVT7B4FbAaF26gwxLlp6q+55GBwJqUM1J7MrA1LvWPGZNSinbgQ1ccelwIXrSGY3hMEvSbYE9htW7FdL6ogO9CCOTuS8qZnT8YunmQQCirig01KZ1D+09lTrKTTBzdvGINnIQKeWwR4YLA7cgZrQKBnTUofAs2HzvY2rqKYg3a1LGZA/moXdvQekivD+KoJf9cM03A2cAlA4yaM2tyVuCUpXIJxJN/HDHSeukdEPg2PbvmB0TF00VKkFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o48iUwF6UxeV1Jxgf6MlWjsmztSeKccLTFf9qK5BpCA=;
 b=vcO8tOzQyzBatb3lCEmziYOiNGRBackWId9ZX8XE9XaMGD1jCtyuFf9imUwGVmM0fOcZDu0s5+iZfglQ4+Y1u/pA06TIZp4xrsIGBa0dB035TEgn3IBCm/0i2w2FroJ+r59voxlU2WmXcYmYJd1nguDvR2HSRo0s6KMgaMzEiWGBcIG5kJQx+/lPRVXbj32rh29gZRyWa0eQfirpm+UXsp5Ox9djvJsYBTmqurlpyh3GJ2qkkrtf/eK/eSD7ZVYanA0Iu2vQl2IL45H0ycAU07wUNU0bgIW0JDPb3bHcYwE5VvRwT4OousNgsONPn85K7HD5femK7i/WBTiWOTntWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o48iUwF6UxeV1Jxgf6MlWjsmztSeKccLTFf9qK5BpCA=;
 b=ekTeyNX7ZLUc1pz9tAVPY2HNY4oox8kRAbIA91oPg1YI8erLA91d4M0HVCA8ACYHpOB8M0Cr4wt9mBsQTHDwj9kUh/2eXvM8fCbNLR2QwhbMvuZRo4+1hO0HrWxTby2GzgFgAXr9Ulxho90AZIwqotDmpFWzz4pOTnKYN8yF8U4=
Received: from BL1PR13CA0250.namprd13.prod.outlook.com (2603:10b6:208:2ba::15)
 by MW6PR10MB7686.namprd10.prod.outlook.com (2603:10b6:303:24a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 07:59:26 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::52) by BL1PR13CA0250.outlook.office365.com
 (2603:10b6:208:2ba::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Mon, 3
 Nov 2025 07:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 07:59:26 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 01:59:24 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 01:59:24 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 01:59:24 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A37xLxT3746939;
	Mon, 3 Nov 2025 01:59:21 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
	<hiago.franco@toradex.com>, <francesco.dolcini@toradex.com>
CC: <afd@ti.com>, <hnagalla@ti.com>, <u-kumar1@ti.com>, <nm@ti.com>,
	<vigneshr@ti.com>, <b-padhi@ti.com>
Subject: [PATCH] mailbox: omap-mailbox: Check for pending msgs only when mbox is exclusive
Date: Mon, 3 Nov 2025 13:29:20 +0530
Message-ID: <20251103075920.2611642-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|MW6PR10MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af1e0b9-2d77-427f-59f1-08de1aaee895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|34020700016|7053199007|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7oXkldcoiwO0LB3Sl09bZP8e/zDX7azs1wjE/rTVB+2wRTTNgFoSbvA51Yrq?=
 =?us-ascii?Q?KEEXcitkTJAEPPDubAQkswKD4bHFPvup4s5IGKs0QRk+wj1cbTeK7B5jZqUg?=
 =?us-ascii?Q?GPaLn3mrMwnKcvadp1lgOEP267xKVD8DcWitJ4M09plrjFw1u2YSknj4Z6E+?=
 =?us-ascii?Q?WzJFNrzOMkP3opIHPk+8BDbBr7NCiLPz7RnV83h3nY+gs+6Z+VpQ/bNk8ljf?=
 =?us-ascii?Q?p1CNGpeJ7SA0NfTn3Morrb8dhqTSfRUMv5J/BwIUhUz3/ttr1j1YdG7Ac6dn?=
 =?us-ascii?Q?gNLqdjUq+tmjlYI//DF86BYprNDx/35iBjNwxs7fyMeOnEA0qEwcFNcph16U?=
 =?us-ascii?Q?z8RHSD6mxqWak1qOkxeESsTuiz2G7HbJl+68c/t5uHeAp4Tl7TNx3anea4y+?=
 =?us-ascii?Q?bsofQU1UvJBd80jP/sC6rDJJe962MWIDs1JE+NN8m5QXnTnHGevJGZQ+MAap?=
 =?us-ascii?Q?OW33HwTfLPyyhAVpYOhjYx7BNiqfjeGFFKoA/KItrsN3NdjeUIPgIBIU8bEj?=
 =?us-ascii?Q?UP8lN3kfH+rUGApQuM28nlkPae0jQAwK3k7jRq5WLRM0f8frw1LrEOUQ8JMd?=
 =?us-ascii?Q?H/fBJ3WY7aVEeSNr4Sjp3HG08HES8p9t5PK4idxjNjLD+IC7aZL8OD+Y/upX?=
 =?us-ascii?Q?H7E6xRFvT4k9Svlm8XxUCuQapGediYWHBnsQmiqJ5RTkq4eG0ly/BOHgyLCF?=
 =?us-ascii?Q?f858r4RzuqQMbjiUR5QUipmYX5wOXUeewSZmHrX6/W1YnWza1qjuLugzRooZ?=
 =?us-ascii?Q?sD+Yw53KVE80xQh4AKGr7aJc3jIFzEYxDuAKKqGv6/w+M91xTQr+tiivM/rk?=
 =?us-ascii?Q?e3o8XQPVyHmcJcRcoUaPDRRj0ejVc6TWPFjW52qtZC3jfzU/7OF0cYInwMOI?=
 =?us-ascii?Q?/3s/uLCNqpwwMGiG8Jjd9lp4XzkvyEL5cIhHCEiChkiRAhI6Em8nB33cYpi+?=
 =?us-ascii?Q?WVTN4bmDda5ZYOBH0LDVMLibIAlLf0v8mqfj+L+m2bPLgsPZNvcryX6EcfuR?=
 =?us-ascii?Q?evEHx1wFk4M66FvLwo8gaVyXwrp91FfamnDDK5QZk0MOkCaBryOgGOzRSpFG?=
 =?us-ascii?Q?8MxBdjoQkXBWd7DZ/jGezQpS6SEj+AUC82alN4gzYH4agTqgGxh/hizDDYpI?=
 =?us-ascii?Q?rNVKfbtsKd2frFuave7JkPyYMA6UCRm8OzMrfgDxQytjn5C+86/Eqjuwyth0?=
 =?us-ascii?Q?lXBr+IaWbRHmzz1Rd/utkEBhYfl2rpq+vhilfopIa+vG+TyRfPn91PfQF4Ph?=
 =?us-ascii?Q?6DY3FRd2dPo49TWhN0ccWB0j9tJxTr4gwDbMbigsmmOvug4tuxrp7voaSiqH?=
 =?us-ascii?Q?YEmEmpbgQU46f+GOtjktMO7HazUvPtWWMQ0AIG9U+wNRR8JLlKOtPt2f7BQj?=
 =?us-ascii?Q?vet99IkerdItD6or96i3+mW8YmGyPBFA1X5L9s4vdOv340SPuRPaWeAFa8jx?=
 =?us-ascii?Q?neiv76ZVv202UKKocnWQNU1qC8wWcWuTiYMjhsAQ4j/AAd5Fn+50QBr0Zwj/?=
 =?us-ascii?Q?yDLfgSJT9BK+rKBMTgmGkss5RqA1nbJqVuoNapO+rIc1jMjT3pP/8y3ZK9Gs?=
 =?us-ascii?Q?euoaPz9GlGKGyBC1WIE=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(34020700016)(7053199007)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 07:59:26.0745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af1e0b9-2d77-427f-59f1-08de1aaee895
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7686

On TI K3 devices, the mailbox resides in the Always-On power domain
(LPSC_main_alwayson) and is shared among multiple processors. The
mailbox is not solely exclusive to Linux.

Currently, the suspend path checks all FIFO queues for pending messages
and blocks suspend if any are present. This behavior is unnecessary for
K3 devices, since some of the FIFOs are used for RTOS<->RTOS
communication and are independent of Linux.

For FIFOs used in Linux<->RTOS communication, any pending message would
trigger an interrupt, which naturally prevents suspend from completing.
Hence, there is no need for the mailbox driver to explicitly check for
pending messages on K3 platforms.

Introduce a device match flag to indicate whether the mailbox instance
is exclusive to Linux, and skip the pending message check for
non-exclusive instances (such as in K3).

Fixes: a49f991e740f ("arm64: dts: ti: k3-am62-verdin: Add missing cfg for TI IPC Firmware")
Closes: https://lore.kernel.org/all/sid7gtg5vay5qgicsl6smnzwg5mnneoa35cempt5ddwjvedaio@hzsgcx6oo74l/
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Please help in testing the patch on Toradex platforms.

Testing Done:
1. Tested Boot across all TI K3 EVM/SK boards.
2. Tested IPC on all TI K3 J7* EVM/SK boards (& AM62x SK).
3. Tested that the patch generates no new warnings/errors.

Changes since RFC:
1. Skip checking pending messages instead of flushing
them explicitly for K3 devices.

Link to RFC Version:
https://lore.kernel.org/all/20251022102015.1345696-1-b-padhi@ti.com/

 drivers/mailbox/omap-mailbox.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 680243751d62..b90ce9d60a80 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -68,6 +68,7 @@ struct omap_mbox_fifo {
 
 struct omap_mbox_match_data {
 	u32 intr_type;
+	bool is_exclusive;
 };
 
 struct omap_mbox_device {
@@ -336,16 +337,21 @@ static const struct mbox_chan_ops omap_mbox_chan_ops = {
 static int omap_mbox_suspend(struct device *dev)
 {
 	struct omap_mbox_device *mdev = dev_get_drvdata(dev);
+	const struct omap_mbox_match_data *mbox_dev_data;
 	u32 usr, fifo, reg;
 
+	mbox_dev_data = of_device_get_match_data(dev);
+
 	if (pm_runtime_status_suspended(dev))
 		return 0;
 
-	for (fifo = 0; fifo < mdev->num_fifos; fifo++) {
-		if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
-			dev_err(mdev->dev, "fifo %d has unexpected unread messages\n",
-				fifo);
-			return -EBUSY;
+	if (mbox_dev_data->is_exclusive) {
+		for (fifo = 0; fifo < mdev->num_fifos; fifo++) {
+			if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
+				dev_err(mdev->dev, "fifo %d has unexpected unread messages\n",
+					fifo);
+				return -EBUSY;
+			}
 		}
 	}
 
@@ -378,8 +384,9 @@ static const struct dev_pm_ops omap_mbox_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(omap_mbox_suspend, omap_mbox_resume)
 };
 
-static const struct omap_mbox_match_data omap2_data = { MBOX_INTR_CFG_TYPE1 };
-static const struct omap_mbox_match_data omap4_data = { MBOX_INTR_CFG_TYPE2 };
+static const struct omap_mbox_match_data omap2_data = { MBOX_INTR_CFG_TYPE1, true };
+static const struct omap_mbox_match_data omap4_data = { MBOX_INTR_CFG_TYPE2, true };
+static const struct omap_mbox_match_data am654_data = { MBOX_INTR_CFG_TYPE2, false };
 
 static const struct of_device_id omap_mailbox_of_match[] = {
 	{
@@ -396,11 +403,11 @@ static const struct of_device_id omap_mailbox_of_match[] = {
 	},
 	{
 		.compatible	= "ti,am654-mailbox",
-		.data		= &omap4_data,
+		.data		= &am654_data,
 	},
 	{
 		.compatible	= "ti,am64-mailbox",
-		.data		= &omap4_data,
+		.data		= &am654_data,
 	},
 	{
 		/* end */
-- 
2.34.1


