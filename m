Return-Path: <linux-kernel+bounces-835886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2DEBA843B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E3707A0335
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9143D2C08D0;
	Mon, 29 Sep 2025 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NfkMvMhL"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF092BEC26
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131510; cv=fail; b=U4Sn7T6lGykX2ThvYZ/aUAQ2OyoDvUU80MjFr8nBo4LkuS0NG6bFBJnS2HoIpvpFg4GQuZCKAkm/1lILVDPex89i63/TMCZ6VNd2jKYEwtUBPjvQRb7bYk1anCsnslwPCUyo6x1fOoWErVWgvXkzGxGG7HE00i9Q4TFuqTpfNU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131510; c=relaxed/simple;
	bh=yFxIoZ+vsEhWM2802SjmW/ljWj8NdXcTks/UdiNjPNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zm/44K4h0yYFT7DZCme+/WjPbUhntM9JJlvF4Wp8Xxhkwyv7rJE6HpigufxRx8iz81upQC4W1raDkBWLOJBSS+JFo4gru0Ju0LPgZTHsG3OIG99q2TuGnGEyjZmiqqr1wz1EbNxbHPJMsxaIKe230FrL7e9lEiDS7JQcXKVj3uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NfkMvMhL; arc=fail smtp.client-ip=40.107.208.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqj3KpZfJfI3GtBvQpKvfePdS8UYlrC2aOGSU6nZqO7F3sxLUVln9z0M///lTYRQSF/4G20mQzoWR2Lt6rgrscPl3g6mPeuN/kkeZCSYtIHkv5OqcjQyj6GqhpOse+st2hoFG8FZGOQDctrxkXKbhRNvJdqFsd0IJ34SaUn2mS0eymTvIC88yxAyhBO+Xtny4O7WPoIUTZk0vzDhwP1C9SIr9c0dRDs/gsYgWUFgJyKYdtIAZONQxOHARgWFCh6SAvs603mAb43gY9LCO14JNbyheOa74Yo39Vk6T7I9+RTCuKdZkynmeOc6RUglJkmP7mkHKPHFSpi6W1JA8loKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIJ3xA1SPOEd2mgilRha1ETEgH03qNaHwcw6RvQZfNM=;
 b=udN6HvZJoPpDPKpwquG/qMyO0WgNJeMd4ce8hv9TgbdUp8Q132CCBhgvQ/qcXYzMxtPeNiyFugByyYXGJVs2bP35yxvc84Kpe79FV71GXHpb5uqbM24pdqSxyZJ/N9AfwHfWSeSbG10W5UIP4nmGMSd7jItN/+EbcXkbYp/9m95W1BpvfT1IGVi1rshDqskc+JBL2qwBvi/LhUc+zD8NS5Ti1naLyzJViwznShagBIvtU0BWOriDdjhZMeVGLQXkTt07z46FMNoSRAejs8onXRi/7fB1OfS3KyebucWuHpjpbdoebZIWgjq6uTZM6e93/9Vfwm+tWrtKduHc64q5LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIJ3xA1SPOEd2mgilRha1ETEgH03qNaHwcw6RvQZfNM=;
 b=NfkMvMhLZcPlheCo3PwniKCHO0Pyle3e/NzQDSnasBiHdgNtJUkl6XZs2Lk3lbfMZZrs27xarDQM7nfCBfiCsy8vk5WzNbPHMsRggu0P6erpcw+U2EFGaNiL2bWftoDZZKoLcrX8cVwMMWVHFH1SQRHwKaCx8Rml0AIM5zik+2g=
Received: from BY3PR10CA0024.namprd10.prod.outlook.com (2603:10b6:a03:255::29)
 by CY1PR12MB9650.namprd12.prod.outlook.com (2603:10b6:930:105::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Mon, 29 Sep
 2025 07:38:24 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::c8) by BY3PR10CA0024.outlook.office365.com
 (2603:10b6:a03:255::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Mon,
 29 Sep 2025 07:38:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 07:38:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 29 Sep
 2025 00:37:55 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Sep
 2025 02:37:53 -0500
Received: from xhdharinit40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 29 Sep 2025 00:37:51 -0700
From: Harini T <harini.t@amd.com>
To: <jassisinghbrar@gmail.com>, <michal.simek@amd.com>, <peng.fan@nxp.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, Harini T <harini.t@amd.com>
Subject: [PATCH V2 1/4] mailbox: zynqmp-ipi: Remove redundant mbox_controller_unregister() call
Date: Mon, 29 Sep 2025 13:07:20 +0530
Message-ID: <20250929073723.139130-2-harini.t@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: harini.t@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|CY1PR12MB9650:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ca2b92-7aaa-443d-4a1c-08ddff2b2bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S/w/C653G3o7Hr3ZTeEd/TMY7/zBVJe7/v5UNCG0+eI9WJzh9WmEobczEOk8?=
 =?us-ascii?Q?N1oDaqkqmX+rNr7vkGw9RsBlbSwHKN77kQPMEjNCbNNZVWUPWyR8MyaALVEy?=
 =?us-ascii?Q?PyEKa3WrMA2pwrL3S+Ay+t7iFdwD3s4Ou+cdjEI9BSpyU4LdrY9dZUBnkB1B?=
 =?us-ascii?Q?pShF5nSqhGtQSG75DFYVGoWEmgolb17bVSK1BcXMvzSkuEDfA0DOlt1Dq/gO?=
 =?us-ascii?Q?87Bq3fVyEmrOZWbEeb2eKxaRQy9/JlQVfNuS25ymVnQ1TljNnbkeFexZTZwC?=
 =?us-ascii?Q?+2K/qhhVL6FgRqQ2vpPQpWoe/TjqljoW2mPVCp0loaz0XRGAhlykh16L1/L3?=
 =?us-ascii?Q?MeLJ07Zm6uwWdSLFOijqeB9RndDW/jBV60DkmpCw9tKiEML96z5I84mtDlf9?=
 =?us-ascii?Q?QmHLxpM1xDND26dtkCjTfMkv1dr2aUGrE2f2hRgolRpyo1uq2BYY/a78kjEB?=
 =?us-ascii?Q?2dM5OK0+OEVxFn6PFkq6lPU778CghoSvBG+cSgxtmO/EEiN/D7+At+/yKTRE?=
 =?us-ascii?Q?oL/QLMhYX/3A2NaznpX/csFBKTFAdmWoAxwoRswLfwV/ZLp1IQA8P42dHU+c?=
 =?us-ascii?Q?8+e7/e5Sr1kRiq7zxhWy+hcMByHK5FJPGKEO/zxyaUNCftvR/MTYaqNWAwf7?=
 =?us-ascii?Q?adAU/56CJj4Qq/Igb6OiT7w/m6dPPhbl6ediQbC+cc0LeeOSJ4V16jkmD2/w?=
 =?us-ascii?Q?23ldmIBFJ4SCiXKJfn2+3qIBVvn2Avc7cRNvVlwwt+9/JlvidnxtzY7SZUH6?=
 =?us-ascii?Q?h5Srh35HodVzoy/LXx3j6Dld7uU45kfSk0RWs35u2WvWYK0roMyUulne6Iuo?=
 =?us-ascii?Q?l79xV2HIZTZEmmFnBgEXwwMdMZyyOaf3GPnFfJA2/gYXIDQC8Qhj+5nrqlps?=
 =?us-ascii?Q?mCtdt0rAT0L/Lt7+uLcTm7vCoa3UWmAlPVYay4VNtdXT2RFTiSUklhlKWkA+?=
 =?us-ascii?Q?CcSd14oZ4yssJs3TdR+H4Ke32ujjH+Kx8l16STBkPnIF5mtZxLhyPs80s64t?=
 =?us-ascii?Q?qyWYrcJVA6d9ZUBfEGVEefShcDJ1QZS9AU1q5CtGJTrH48tTnXDfX2pt/Klg?=
 =?us-ascii?Q?+pPLXbYDfA9q95lGckYjIpz7n5YavlnFjH5+FErDGcCH8ppg/uiIeq//ZEMn?=
 =?us-ascii?Q?gNOXUqTfQhfvV+cfjIJ9xWx03Meyh23dyt/mSZgOMIQDru7VbVRDWeBvjqg4?=
 =?us-ascii?Q?a/xkcAgbvoTLGm1iNhRGU1YGBkhQaQ2c8piWWWRTHvfmlx/evcbl5njnzkeR?=
 =?us-ascii?Q?jdv4zDufR5YHJJ7s7YVVV8zlf1qIR24hwMfYRFKSTg5gFWxF9ILgIq/UiDB2?=
 =?us-ascii?Q?QTZQor9gGNq6QiIZUIKQgO1Mk9AowWlrhHZdoQd26bVCue8ih3vv57dY8DsH?=
 =?us-ascii?Q?4VYUGcRAP1wUFxd9X9bKUigY5Uhq9ewxtzFa9Be/QYt7e4zhh2EpxUHqvQLC?=
 =?us-ascii?Q?6ua7zVKsJoG70FksLVo9mvzdpmuovOqicM5yVQFIxhJLYOjKZlQFHWJrWp4L?=
 =?us-ascii?Q?/7PGeNTXCzsDX4WmRfKdR5++uy5b/W5qlCx1nsRO3T5wqxhVYctBKjWIAu0+?=
 =?us-ascii?Q?FW1tI0v5Zkz9Sb/Mw9Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 07:38:24.0802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ca2b92-7aaa-443d-4a1c-08ddff2b2bec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9650

The controller is registered using the device-managed function
'devm_mbox_controller_register()'. As documented in mailbox.c, this
ensures the devres framework automatically calls
mbox_controller_unregister() when device_unregister() is invoked, making
the explicit call unnecessary.

Remove redundant mbox_controller_unregister() call as
device_unregister() handles controller cleanup.

Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
Signed-off-by: Harini T <harini.t@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 0c143beaafda..263a3413a8c7 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -894,7 +894,6 @@ static void zynqmp_ipi_free_mboxes(struct zynqmp_ipi_pdata *pdata)
 	for (; i >= 0; i--) {
 		ipi_mbox = &pdata->ipi_mboxes[i];
 		if (ipi_mbox->dev.parent) {
-			mbox_controller_unregister(&ipi_mbox->mbox);
 			if (device_is_registered(&ipi_mbox->dev))
 				device_unregister(&ipi_mbox->dev);
 		}
-- 
2.43.0


