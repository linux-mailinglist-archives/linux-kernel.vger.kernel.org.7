Return-Path: <linux-kernel+bounces-755249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C012EB1A396
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19FC17C325
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F9A26B2A5;
	Mon,  4 Aug 2025 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=agilent.com header.i=@agilent.com header.b="g/Y6Sir8"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B46026A1D9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314714; cv=fail; b=pfFov7a73k4yqhTVLzBK4B6V2Mlv1Wm1J+hzL4reJtplaANkam6B90HYfXonMaWBiNouVquK2r4iaXXWwxwYbNwohFIAyRzJhXwDGtW1ESGMMziyDQ9yNohZm8/CWH2PYPOx6LAM7hDaH3WPg3OIPpNQosnsg4yZFe1JTlZ73XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314714; c=relaxed/simple;
	bh=ZiV/yQMOHdH5MC+ausZCA58PA7xfW3GwBJIOwIMlbXc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SMkcNIF4TKPVcw+TvMQxTXBD0CfvxbYxYRllK1DkDXQXolD/QSBgXade3ltxfRYGaWepFIuRWZjpQdsN8vO1KD4F42cAkKDNawJGTbhVwK0ycNgjdEbsl7hd4yzvEnVOMfkDlpa/BCszjjyapfV51wlvL4AKWMbOmkGAQ26ym/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=agilent.com; spf=fail smtp.mailfrom=agilent.com; dkim=pass (2048-bit key) header.d=agilent.com header.i=@agilent.com header.b=g/Y6Sir8; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=agilent.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=agilent.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOe0Ov+ULIo9kRE7HWC/gIrFidrMAF9MgxJGyGVeEGdqd+2mRq8gjmnrNSI0Nk707goUo7q/OzkHMC/5OuuRHiTajSARimYmetce2wcPiuqcn71eqa1S7DELgoMFMxCp1nQmYSvr10z7lV+7KghAVOWD/kA/oEw4Fxn1bGmf9SV4gxcrEnWZhOoB1l/CZsseuPGv5mU/rFU86sfyg6h8LOI1fP6KFQkZMf2k700hiAouZsVD0LUkaJdh/jmnbXK/1FIeg8bLchzpRIK4oizKlFoj+Xfg3wl4d2oMdfnz6mRPGi3WXl6mCUfDsdKyo6a8AO5kjvr3DTgJ+XDeYtOQIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnZVvZyR9nyu6PmSw/TGv5Vmee5hRyhHwSoTYP7dWjc=;
 b=hh7d9lF+MjqYPqDa2VPjosjB5WW5W71BhP64MzUc9IngMAcrY/+UmHweK1ppqFZhS1ynbFjHD4KcDXO65mxBvI6ymvpycPy0Z1uc+pgwF2BVZCsQPxpOF+EpoKtwKOxCQ8gIn2mVfqKmrha5BvtfCIQ1Yw1RQhGu1MscG+84vvlVYzAyAEvlqUkA/xFBqE7+0xeni+ndX4cap50aElV814xILj1V39OlXS92L2zECBsmb2jt4qOoLp7/uOpDfLeq9Rzmu/rpmcM0heIRTTyavqMWe1ilvZ+nYOm386FZGlLG95BdS5rTjk7a09WAqYS6WxT83/CPmt3t1A5Hk2sqMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.37) smtp.rcpttodomain=diasemi.com smtp.mailfrom=agilent.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=agilent.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnZVvZyR9nyu6PmSw/TGv5Vmee5hRyhHwSoTYP7dWjc=;
 b=g/Y6Sir8dNpHm44PUaZ9IbYf+0xf+I0+5zmG1ZS0v2pLluo+Rzvov0d7lxANgecFSH0vOiXzk0BqQzFiLxlqazHE9U+pKM22L1eNZb/OjFrC4InUKZMsTVmlKQ6FHjThit8kgIswEqrOQksKoKKt8PvDtL7BBO7U06cQ3Q9TQSVkT9Rbkf6xIGyrtWUrx8rSuG98t5PfkC/cwnxZr76vKDCnW/SZWsmKaJ+fd23BVnhVIwbm6/ZSMZ/rgyuE8OhSNEvbMgpvMjncGPw4XNlZxC7ir64AxKAaTx5kMNoUzQb8CQQIb/Ais4zlaXhZ+cZVy4pcBAKrqIHE034ebuax4Q==
Received: from BL1PR13CA0121.namprd13.prod.outlook.com (2603:10b6:208:2bb::6)
 by BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 13:38:29 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::98) by BL1PR13CA0121.outlook.office365.com
 (2603:10b6:208:2bb::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.13 via Frontend Transport; Mon,
 4 Aug 2025 13:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.37)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.37 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.37; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.37) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 13:38:29 +0000
Received: from pl29imagebuilder.germany.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
 15.1.2507.57; Mon, 4 Aug 2025 07:38:23 -0600
From: Jens Kehne <jens.kehne@agilent.com>
To: Support Opensource <support.opensource@diasemi.com>, Lee Jones
	<lee@kernel.org>, <linux-kernel@vger.kernel.org>
CC: Jens Kehne <jens.kehne@agilent.com>
Subject: [PATCH] mfd: da9063: Split chip variant reading in two bus transactions
Date: Mon, 4 Aug 2025 15:37:54 +0200
Message-ID: <20250804133754.3496718-1-jens.kehne@agilent.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|BN5PR12MB9511:EE_
X-MS-Office365-Filtering-Correlation-Id: d10a5281-4574-484d-ca2f-08ddd35c32a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8+PBRrKRZShOzZZ3ZjqVKuBTysW5Eis9I5mFmgyjufIk5xECT2xMttxnylQ7?=
 =?us-ascii?Q?3jGoHkpxmynd8YwhFCKT34L8ZWotpejzHm4zkSBmscP9uIr51vlV2xdD9mGv?=
 =?us-ascii?Q?egzfUzdY8riOKUzwwyxfJNZhI/D9UEfTA7vVny5IYuevRQcWqnRa0+xVG6XU?=
 =?us-ascii?Q?ivIiIiY+MQ5xuwzUTr29YdIUPAW9QN3/ojO7UzZAT23tcas2M0qthYxLda7h?=
 =?us-ascii?Q?UFbxNJ2iYiSGiG0Tnl6VTGjnLLKduAr04j9NqbcE5xoE9jysyhth3OQLvjY+?=
 =?us-ascii?Q?3GOEecu2ObK5ATGyPKRDAt0wqfeJbZvrG3iq6lzMCpaRGiLMWpT6iF6hvFb/?=
 =?us-ascii?Q?6+Uz8LqXIwEP/BkO/WRAquGTTFqAZz+JfH4Jzzn21m9yemJoS4USIpkTaeJu?=
 =?us-ascii?Q?DTqQpRCzHd58aWBsJx4yuor7KRYMnYcQfJpxT8TKIi0VKR9G2EG9nWbNopYu?=
 =?us-ascii?Q?PfMLaBXeZK79ugTqXMlDs7UXoPjrOmaVrDx+Ol3rpMqCpvI4niu+TDOiSicJ?=
 =?us-ascii?Q?Nv85PzCdb46l8SH9ktOe63hU+VmlcVYWnquIG4bdAnydR/QfRFrhqydQbPH3?=
 =?us-ascii?Q?bhOm1Lbr6p/ee+FQVBz3I9OkXe9pMWabCk97xlZB+qSvbTkys4VyNzYy8k5j?=
 =?us-ascii?Q?86YPk+SclPdD/qx+eFMACmznf5DEd8lkryGK59ZAimVwEIiQ3CFGipEAFtL+?=
 =?us-ascii?Q?9IbPAkVo4LKteKU8paN0mtYm1lfStWaikLDY3dLdkVcjdkXQCVxFMJVQokjR?=
 =?us-ascii?Q?tSLxvDldnUMKzak5pnL3pELSbw5bSZLB1rDCsSH4OFC7VH2pec3EYoj0nB8d?=
 =?us-ascii?Q?U52CW3RzVsauzFFXw2hakgMcEOvKGlcxNqd72/PzhuQE/okF1I386VH/86IM?=
 =?us-ascii?Q?W3kmRA2x0xE0YKYWltWRiBKnC8E/C2/ikrQYieQ92v6PiFG7HTaWcuCGhoey?=
 =?us-ascii?Q?WrRXfBt1+v4cDfxcjPrXWZFTY7WCyhxsig00CzQOtRqA+S9XhyB/OtnaFSqk?=
 =?us-ascii?Q?CitdIYWyro1V3I97AfdjpeYhX5Oy4AiytV+FXlA3TrqsdIP2I+mndFebzU2i?=
 =?us-ascii?Q?C11Egfwqfu8P0EOYyjyVv1ea0yLs+DVe/F3/W0KCWinoXju9lMqvZpO82w89?=
 =?us-ascii?Q?Jq6hM5F7rtrG+S9C7fptIWtoMnZK6AOzp/d+1e0lZcPDNiesqv7uXZYcG7Az?=
 =?us-ascii?Q?Iazp8K5hDQl8hiu0e0QcyR9XF6H7UVf6jHCU8KSOO5Ba5wtPFvMjYTmXAa7P?=
 =?us-ascii?Q?DBiFUg5EGhVGDLKIiTeGhxp9jGYiVsXDZ5GUJQKuciBq+gzyAblGoN1Wn++W?=
 =?us-ascii?Q?k4OJL48BnnXInTW5YF1L0IFyUqCvrdUq+f2hfCffjp1WdDJcfbD3IFBSSl6g?=
 =?us-ascii?Q?nySR2Q+O/MoIoWQSuTYhQTssssDTAV8Dw7yI9GGskIK9D8ekCejMNLKJ9h0k?=
 =?us-ascii?Q?pnAX2mwYnEruapGgFavCcJEndNN/9cxgo788GikjG6yzJnkiiX44AEIDBeON?=
 =?us-ascii?Q?Lqy/cpQ8KHN8TWSybVrFhM7Ubw36ChQppR/M?=
X-Forefront-Antispam-Report:
	CIP:192.25.218.37;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg1.windmz.agilent.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 13:38:29.5377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d10a5281-4574-484d-ca2f-08ddd35c32a4
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.37];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9511

We observed the initial probe of the da9063 failing in
da9063_get_device_type in about 30% of boots on a Xilinx ZynqMP based
board. The problem originates in da9063_i2c_blockreg_read, which uses
a single bus transaction to turn the register page and then read a
register. On the bus, this should translate to a write to register 0,
followed by a read to the target register, separated by a repeated
start. However, we found that after the write to register 0, the
controller sometimes continues directly with the register address of
the read request, without sending the chip address or a repeated start
in between, which makes the read request invalid.

To fix this, separate turning the page and reading the register into
two separate transactions. This brings the initialization code in line
with the rest of the driver, which uses register maps (which to my
knowledge do not use repeated starts after turning the page). This has
been included in our kernel for several months and was recently
included in a shipped product. For us, it reliably fixes the issue,
and we have not observed any new issues.

While the underlying problem is probably with the i2c controller or
its driver, I still propose a change here in the interest of
robustness: First, I'm not sure this issue can be fixed on the
controller side, since there are other issues related to repeated
start which can't (AR# 60695, AR# 61664). Second, similar problems
might exist with other controllers.

Signed-off-by: Jens Kehne <jens.kehne@agilent.com>
---
 drivers/mfd/da9063-i2c.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index c6235cd0dbdc..1ec9ab56442d 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -37,9 +37,13 @@ enum da9063_page_sel_buf_fmt {
 	DA9063_PAGE_SEL_BUF_SIZE,
 };
 
+enum da9063_page_sel_msgs {
+	DA9063_PAGE_SEL_MSG = 0,
+	DA9063_PAGE_SEL_CNT,
+};
+
 enum da9063_paged_read_msgs {
-	DA9063_PAGED_READ_MSG_PAGE_SEL = 0,
-	DA9063_PAGED_READ_MSG_REG_SEL,
+	DA9063_PAGED_READ_MSG_REG_SEL = 0,
 	DA9063_PAGED_READ_MSG_DATA,
 	DA9063_PAGED_READ_MSG_CNT,
 };
@@ -65,10 +69,21 @@ static int da9063_i2c_blockreg_read(struct i2c_client *client, u16 addr,
 		(page_num << DA9063_I2C_PAGE_SEL_SHIFT) & DA9063_REG_PAGE_MASK;
 
 	/* Write reg address, page selection */
-	xfer[DA9063_PAGED_READ_MSG_PAGE_SEL].addr = client->addr;
-	xfer[DA9063_PAGED_READ_MSG_PAGE_SEL].flags = 0;
-	xfer[DA9063_PAGED_READ_MSG_PAGE_SEL].len = DA9063_PAGE_SEL_BUF_SIZE;
-	xfer[DA9063_PAGED_READ_MSG_PAGE_SEL].buf = page_sel_buf;
+	xfer[DA9063_PAGE_SEL_MSG].addr = client->addr;
+	xfer[DA9063_PAGE_SEL_MSG].flags = 0;
+	xfer[DA9063_PAGE_SEL_MSG].len = DA9063_PAGE_SEL_BUF_SIZE;
+	xfer[DA9063_PAGE_SEL_MSG].buf = page_sel_buf;
+
+	ret = i2c_transfer(client->adapter, xfer, DA9063_PAGE_SEL_CNT);
+	if (ret < 0) {
+		dev_err(&client->dev, "Page switch failed: %d\n", ret);
+		return ret;
+	}
+
+	if (ret != DA9063_PAGE_SEL_CNT) {
+		dev_err(&client->dev, "Page switch failed to complete\n");
+		return -EIO;
+	}
 
 	/* Select register address */
 	xfer[DA9063_PAGED_READ_MSG_REG_SEL].addr = client->addr;
-- 
2.34.1


