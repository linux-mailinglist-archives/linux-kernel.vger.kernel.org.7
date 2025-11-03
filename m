Return-Path: <linux-kernel+bounces-883662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FD5C2E01F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 21:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2706E18951D4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 20:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039C229E0F7;
	Mon,  3 Nov 2025 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wp0HKFaT"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazhn15013061.outbound.protection.outlook.com [52.102.133.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3106329D282
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 20:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.133.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762200683; cv=fail; b=WA5OX4OP7qA9h0vTzKOviyQEvKYfKNvQvdjN//Tl+M54pa/2ruD5ZZHGXFuuqbfMjcfzTuo3CRORHTxB0w/xjQmQwFZ0lx4fO20N11d2ul3ilWqkytY9orS0ydAFMJzQrdco6kZAyWGyRxgqYzii83We3a71itCVJYTAz0gwTAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762200683; c=relaxed/simple;
	bh=pyK32oL0LYt3Hkp90nAHPMaq+RVzuXnorWcFWMiK0Ss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tp6VZOKlXILmiO71GyC2fJeDt2MqDD/phcgjFSKMFczUrFq4/8clvLc/9SevXGp7F0X8sMLFOzmoe6SL0ADvWbeEsYLVz68wzDJ/XbNL+WJKix2Kr4AmOzJfdX5AIm1Z09sA8rZk0HERZEAkB5bogkGa/MUKaJQ8eRlhByTJF4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wp0HKFaT; arc=fail smtp.client-ip=52.102.133.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFFnCy+Hwc56dp6FOWGExKm7C53L/V1Jdr4XDpFok23YuzYIzJ7aCi8I68NGP2mZDNcNFVI+bCMH6d3TefO4Jzs0AWUk+RnBWLktys6lW1ngua00t5um8H6au9ChuKpNXoqq+vrnRMeRfTboBDvAksrMn0OYZRNA1bgm6cB5PWaYg9/sHz1gyxlEItuc0k12+DstCAJe1H9kjlEs+AW859s4ikBHn3GNkpF4e+zH+OFozb1XN9Y0FRvwegdFC+tSsmquQRJaxNffi6UnT1yR1HrIEijT+plmX6INzyxKE0/nZ3plyWCENhBVuOGbLSKZd2VjDC0VBRq57AQwGKuhxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kz7nSXONOC8z75P2qwaYO9vBQjlMCDvX3R1SC3z7TO8=;
 b=zTDifitUzlgyeq0PAr7XuhDyaj3qSkQ7ldBG7gGW6MuICfZX+A35ATCL4lubQr8dgImv+DllHQADeZldKTwyz80+koemHjwjOBSivW2FqbnNjYxgzdGySGSWXxyL0K+rNio7Kehp634vgjhcz3ZzcpralZYbPvHMgYTGZm3z4HvPCgnEQiwwE/BISKiRFy1/9m7i7kPFZN76aRDvzaR61yf9rU8+XwNAvtz0pfcHgwe7Pg7MIeeJf8P3ZL5fsLIK0gnBRru3qZuggIiLaDe42JwKIkWmWkaGqONilJCIPCEd/Yo2ROtR/GJKGMFXNUWCkW8LoA9CrqVRz8wZqR/pqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz7nSXONOC8z75P2qwaYO9vBQjlMCDvX3R1SC3z7TO8=;
 b=wp0HKFaThOhgQysKCpMfIqyfYqw4Bptq8prfsqVIxCtSXneRFeo5OUbaXBZUnuXki2vmgccRYhQ75s1gHCe7RdslJgWwibAK1oi0ePpQ5ST3IWsn+ma1VavIGr2igLO1IJKpT4d+deGfeWMsqhY20gpkY5PzvFgEkwZJmAcNgCk=
Received: from SN6PR08CA0019.namprd08.prod.outlook.com (2603:10b6:805:66::32)
 by BN0PR10MB5125.namprd10.prod.outlook.com (2603:10b6:408:12e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 3 Nov
 2025 20:11:17 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:805:66:cafe::98) by SN6PR08CA0019.outlook.office365.com
 (2603:10b6:805:66::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 20:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 20:11:16 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:11:15 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:11:15 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 14:11:15 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A3KBCHo734860;
	Mon, 3 Nov 2025 14:11:12 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
	<hiago.franco@toradex.com>, <francesco.dolcini@toradex.com>
CC: <afd@ti.com>, <hnagalla@ti.com>, <u-kumar1@ti.com>, <nm@ti.com>,
	<vigneshr@ti.com>, <b-padhi@ti.com>
Subject: [PATCH v2] mailbox: omap-mailbox: Check for pending msgs only when mbox is exclusive
Date: Tue, 4 Nov 2025 01:41:11 +0530
Message-ID: <20251103201111.1417785-1-b-padhi@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|BN0PR10MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f716fc-3bf3-439d-0f3e-08de1b15253e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|34020700016|7053199007|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CkRY+uS6GvYz2oH3RejX20w03AoV5oxEojZ/Ey7aww8XIj2Zh2dntw/R+MHQ?=
 =?us-ascii?Q?vvJcJw4bedsEX9ZEKVNpMfPXZzFBeVJWsQyPaLmefKPfR9AtRxqrovcDRQsc?=
 =?us-ascii?Q?vD3wp/6zHg3zbHgMVRJVM+ZLb/fAoeRPuO4tfSm4KKmbpqptfrB5gQuYrunS?=
 =?us-ascii?Q?SUlWVmUa/TAB2oWBV7rbgBJ6AoXHyV0z62L7w0pXDJcInIjX0buH87RPGBiu?=
 =?us-ascii?Q?Qvve+GDV9R72TEq++oVL9UA2BkCR90CGkCg6P4jfn1uvzs87+H9NS2u28Tye?=
 =?us-ascii?Q?aJVVUkSyLJJcQZX8Lw7L8hD6JYJASFdv7PFEwTRoqoCvJkuL/4MLHd3AmQJB?=
 =?us-ascii?Q?MsVnbXa71u1fGk8lpvQYiOuLQSzhb9Fczi6RdMoxwjyES3qgWGln4uRX5Twd?=
 =?us-ascii?Q?YeV/oQjLparhsbQ+cbxhoJdQT+a7+o9C4YLOfxkriONkiXh0U7ySNPb8xgCx?=
 =?us-ascii?Q?5J62W9NRiV+RyW0DJKVvaUpZ48KpPlCxZ35+FhtGrMlo1jICV0dC06zbIvEK?=
 =?us-ascii?Q?rKbfXgcTJSHN/NOzi++568lT2BueF/rdBr1zEmjj+FVjuX1wb5b+7S8MD5mA?=
 =?us-ascii?Q?0xQYlpIBPgEAre3eS+j4OxjEpPmYKdu+4FH9AFyS6u4nFsNya2P0j8iBD5Cu?=
 =?us-ascii?Q?ggdDqV8YsLK7xv4x1I5uponJHPFjfKv01FD8wpMQPjdzJ3lGnptNfoR7TTnn?=
 =?us-ascii?Q?BJcJsPQA3OImML/cZWAzeUpWixqwVRoS40GWN6QVrYCr3D4So5b1VnxROjJW?=
 =?us-ascii?Q?oKPGr1/BfBFaxTLQgiRD0y/7bHU75/0Y7B6lfLgVjngL/hyM2TgbQlSFi8yq?=
 =?us-ascii?Q?PMsMpkphjYnTAN+BLDwqXB/02sf8tI9Ecqm83F/gqugwRX5s+Ot2VGJ4Jn80?=
 =?us-ascii?Q?qmqHdOtoTNepAQpLyPvmdmHbAXbvZAC/H5B5qM+TSg7J+eHfD7XUKMR8MQSH?=
 =?us-ascii?Q?LRgUu9uMvlSeu8aapbSQKDTbbIBliZcsA3w1h+bS/2Ce5RpMnA6/pWjgkE7M?=
 =?us-ascii?Q?J2/Dq4JYVLeuVns27mczV1osZTIstR/swlfvLmA1Qn6qmO/wFvZfAVGNuiF+?=
 =?us-ascii?Q?7Uh79KRLZFYY/sEZlRRewc5e+49HT/ddybi+iIrP8GAW2xDsbJQlA+fhdMhz?=
 =?us-ascii?Q?j67Zf/n7IdbvEvaIcy7Ax1Wu013DHHf4EkR4OXVlxq6GuSDqBOhWzv4TFhLc?=
 =?us-ascii?Q?gA4lwf3h7bVfDVaEqorq/nKkleP1KFc0Igxctm5yv1AEy4zBolKtI/HfNnWl?=
 =?us-ascii?Q?RPJjr+fG+2fJFr1PP2jG1sBlWSpiGsTVnfPRWI8g5ML5+hcqlrkT6uCmH33K?=
 =?us-ascii?Q?DDKM4Lp5XAsuv7PiCChAAPGTZohFsaFdS6TuM1N76vZtdIhhRR+tMhes10Tr?=
 =?us-ascii?Q?3D8MSKlZcTFXRFx6PzjehpgivHQvyColmrtqoTDNYXfMBe1J70oHDDoMx1pi?=
 =?us-ascii?Q?58ngY/V6HrGATRrh5uSH/loCajN5afeoDkYE9OPj6+wGH40KxCEbSS5w046C?=
 =?us-ascii?Q?WZ6vJS7cY18F+KTb5bqWuijL9oJtVpTSvpc9fqHO8lpHvGz+7AyAD0Lf515V?=
 =?us-ascii?Q?XdJTghWVnitO4imcDTw=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(34020700016)(7053199007)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 20:11:16.5953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f716fc-3bf3-439d-0f3e-08de1b15253e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5125

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
3. Tested mbox driver probe & device boot on AM57x-evm (OMAP5 based).
4. Tested that the patch generates no new warnings/errors.

Changes since v1:
1. Use device_get_match_data() in probe and store result for re-use.

Link to v1:
https://lore.kernel.org/all/20251103075920.2611642-1-b-padhi@ti.com/

Changes since RFC:
1. Skip checking pending messages instead of flushing
them explicitly for K3 devices.

Link to RFC Version:
https://lore.kernel.org/all/20251022102015.1345696-1-b-padhi@ti.com/

 drivers/mailbox/omap-mailbox.c | 35 +++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 680243751d62..17fe6545875d 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -68,6 +68,7 @@ struct omap_mbox_fifo {
 
 struct omap_mbox_match_data {
 	u32 intr_type;
+	bool is_exclusive;
 };
 
 struct omap_mbox_device {
@@ -78,6 +79,7 @@ struct omap_mbox_device {
 	u32 num_users;
 	u32 num_fifos;
 	u32 intr_type;
+	const struct omap_mbox_match_data *mbox_data;
 };
 
 struct omap_mbox {
@@ -341,11 +343,13 @@ static int omap_mbox_suspend(struct device *dev)
 	if (pm_runtime_status_suspended(dev))
 		return 0;
 
-	for (fifo = 0; fifo < mdev->num_fifos; fifo++) {
-		if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
-			dev_err(mdev->dev, "fifo %d has unexpected unread messages\n",
-				fifo);
-			return -EBUSY;
+	if (mdev->mbox_data->is_exclusive) {
+		for (fifo = 0; fifo < mdev->num_fifos; fifo++) {
+			if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
+				dev_err(mdev->dev, "fifo %d has unexpected unread messages\n",
+					fifo);
+				return -EBUSY;
+			}
 		}
 	}
 
@@ -378,8 +382,9 @@ static const struct dev_pm_ops omap_mbox_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(omap_mbox_suspend, omap_mbox_resume)
 };
 
-static const struct omap_mbox_match_data omap2_data = { MBOX_INTR_CFG_TYPE1 };
-static const struct omap_mbox_match_data omap4_data = { MBOX_INTR_CFG_TYPE2 };
+static const struct omap_mbox_match_data omap2_data = { MBOX_INTR_CFG_TYPE1, true };
+static const struct omap_mbox_match_data omap4_data = { MBOX_INTR_CFG_TYPE2, true };
+static const struct omap_mbox_match_data am654_data = { MBOX_INTR_CFG_TYPE2, false };
 
 static const struct of_device_id omap_mailbox_of_match[] = {
 	{
@@ -396,11 +401,11 @@ static const struct of_device_id omap_mailbox_of_match[] = {
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
@@ -449,7 +454,6 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	struct omap_mbox_fifo *fifo;
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *child;
-	const struct omap_mbox_match_data *match_data;
 	struct mbox_controller *controller;
 	u32 intr_type, info_count;
 	u32 num_users, num_fifos;
@@ -462,11 +466,6 @@ static int omap_mbox_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	match_data = of_device_get_match_data(&pdev->dev);
-	if (!match_data)
-		return -ENODEV;
-	intr_type = match_data->intr_type;
-
 	if (of_property_read_u32(node, "ti,mbox-num-users", &num_users))
 		return -ENODEV;
 
@@ -483,6 +482,12 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	if (!mdev)
 		return -ENOMEM;
 
+	mdev->mbox_data = device_get_match_data(&pdev->dev);
+	if (!mdev->mbox_data)
+		return -ENODEV;
+
+	intr_type = mdev->mbox_data->intr_type;
+
 	mdev->mbox_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mdev->mbox_base))
 		return PTR_ERR(mdev->mbox_base);
-- 
2.34.1


