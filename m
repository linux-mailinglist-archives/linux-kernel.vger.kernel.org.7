Return-Path: <linux-kernel+bounces-721268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1773AFC6E2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308504A6857
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0F9221555;
	Tue,  8 Jul 2025 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hEQ0dPuv"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010005.outbound.protection.outlook.com [52.101.84.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894673595C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751966272; cv=fail; b=KQnIcTdZOy09w0znmeVhfGm2a/lQ0O/DyTYGUk+47buvUOoqwL/hrJP3tViqe4TYyFqkzI0dr1MpAoW3w6rYz4SwIq5fIXsHbyR0KRF7ZtuRKJxkOEXmi+yy4EWTE92QIz4wSu0DqRqh+7ql8Ppu0EIqP/u8FX0nt6bL2ZiR4zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751966272; c=relaxed/simple;
	bh=kRId7lQavTtVmGNPhCSe8UaqqX0lnuaSvwjQcxk/a0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T/YdPeuxR9Dr69ZwwLi8LeEvM72oNs7VU6Rno7gTaXt9CZofE3ZH70HlzqHqbI2RRorR+YEoVyqErfXXdoyvOPFZ0w3gXR4Ci+KvUNrBv8tfj6t6C184S8w6xB7pQsD63/z2sYsBjCKh3C/orGMGrADrG2t3NkjrV0sJxyN/t0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hEQ0dPuv; arc=fail smtp.client-ip=52.101.84.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjTQqPA4HekpnIishzaCLAHQvObgOO9nXoHebRAmXol4snxYQFlH2AKFj167S4lKlRiNwIA8DBS1KMSVugew0iesWicseWGU/DbwQYs3Lxvm7lHOAII+Ez/EtFt5c2du8RMsTPRPHSptEmnB/2gUOU/CWIkdeh0Vmsjr8sokMSqkhFA1G1ezX7vTDoPwqUWrAYBz7+eB7ckO3ip9/Dix9nfxvvcJsmnltISyLPD1cZCN+H9tyf7F0QCBM+nPJyA5/Rku5UQwAbIJ4Yc5iVDtmCB9uOiLXIAKaakRNMbE3p1f49X3zNuqYB3pWM5vbj26gVUSiaxs6QdIOuMOA7pqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1S+BPIz+NfKHeL8GqxbLpUvoVRTYBkcuCT1NanJxW60=;
 b=pR/hv7TspHhZD/ouG2A//gsF3nsw4Bncs7RBz4n0x1NSBXV/VB25om18MRh8T2gLjGLWf9Ny2rAw62U8qUBnXqPFos+wcfMRWB1sWyZ3euuXLoWlcbCjVXgTMi8XrNsJjzWHJt8u3mFtXel6yrFTG2QnAhsrlDA0/xMp1snMHCyqCbALT6zP1NWc/7gxvXFOggyt5ybbmL6T2SQWIw7/jjy+p8npUwa2s503r7yPyYUJ6kvhAH0N/uedeH5cZh3pCe3WtVm0V/7gW1Vo0ltkXNeUSs/+Lq4g3s4e4ZZ/o6kEZHq5GEgEnmzlSeGBL/AqKaWPwzdAsR4oM0uUt4OCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1S+BPIz+NfKHeL8GqxbLpUvoVRTYBkcuCT1NanJxW60=;
 b=hEQ0dPuv660nGa5AsVsPD4NvxOPagKWB+5fsei6OiaR5PXO5DhGg176TQX8jqnJuHaQozJrSMNv0tNwWLaFT6ndNOmaNb9QZTa+19v8hggkPUtK+Vknq4unlBboUam6rjzpn5sXwGXUNr4UBrTexwtG68Kblu+oF+cNjwaN2ZKAt83Qu0XoG5dEZelGMmdYny7VNNd0brpKm4iIR0NEaiE5xmKDwgeLoMRSUn+MycxtDCqGbvKVjzFJ4f/kXvRdEqNRYOV+o2d8H+E9slNrsGx+YjHmob264UgiDX2dm0l9f2JRe/aY6KQPd5Q5OZ3rareakjh8d4eFP+61QmLhlrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by DB9PR04MB8170.eurprd04.prod.outlook.com (2603:10a6:10:24b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 09:17:48 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 09:17:48 +0000
From: ziniu.wang_1@nxp.com
To: pratyush@kernel.org,
	tudor.ambarus@linaro.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	haibo.chen@nxp.com,
	han.xu@nxp.com
Subject: [PATCH v3 2/2] mtd: spi-nor: core: avoid odd length/address writes in 8D-8D-8D mode
Date: Tue,  8 Jul 2025 17:16:46 +0800
Message-ID: <20250708091646.292-2-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.41.0.windows.1
In-Reply-To: <20250708091646.292-1-ziniu.wang_1@nxp.com>
References: <20250708091646.292-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::17) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|DB9PR04MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e58ee5-9782-4088-09a5-08ddbe004e38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bvxZXSSfWS4P+EirHjBL/mt7g8Ogf/4TBHGqgKM+fq03yPofab3LHyFWtM/q?=
 =?us-ascii?Q?7coo1MKHpnxn4b5BoPJFx9CCLId6lbR3o4nP7XcyE6VM1UQb97Zr4/dakJW4?=
 =?us-ascii?Q?1IHFoqPEnbt+fOUEnJKea9fjvtrbe3YXvqfl6/vYJub3nG+x4swaOQwho/pf?=
 =?us-ascii?Q?KLyR0gm5IEnYGgmApp/Sbq9lP/kEZKYZG0k8CGQki7lUGqe0XDKpS//09DEW?=
 =?us-ascii?Q?88v53L+3MKpgyWgpnE5xfZm0wa03NaWJhwoWLU6lwaVCmpTiXjvMLCkd8tPz?=
 =?us-ascii?Q?5FAd+CaA7aGaR8NvbmkJrGyB5VCshkOHY04QBVbqNYBszo//XhHlfvO1818j?=
 =?us-ascii?Q?YyPQcRKmKHr6nzBy+YuMro66Z7NGqlXfFOXhjx80j9cP8uWXb7vd/VM917ux?=
 =?us-ascii?Q?7zbgyR+OBdJToj5Qh4oC+KfbvWyce/2e7Z6QfPw6pc9vQR6ScoFdcmmDyiQ4?=
 =?us-ascii?Q?2sGF3ahNEw1XCs3aWqnXZDfk9tvWQYL225f6z08EXl0fi/I095B4JXpxWdqr?=
 =?us-ascii?Q?o0A136/q0R9r34DKvWVP2RneZbgwq1U09osJDk2mQ3l2vneCOPr2EC9yC5ly?=
 =?us-ascii?Q?Nn9JLMXsXjTE/p7yfH2nKQaGjMTq6iccMIoSjmXLL2jv2h5LSOluJWxx29f1?=
 =?us-ascii?Q?ekUKWKkTtuGRVi6Ar79JY5dhcvnRq9h02Rpaw+DYZt/hZrl1tYL1ip9Y8Z0Q?=
 =?us-ascii?Q?kuVLz2retPN8sKGtb2Uj0wLW5CHOzuUDdul+7d6yZ97mQHpGSZxQWxDmZTIM?=
 =?us-ascii?Q?fKU0vyA1Nd0AHIE5hbgbWlTeyUdw41SApKsRT3qsiB0HuYnIWCgIaw+5Nbha?=
 =?us-ascii?Q?Hk9K8QRaP6z6RLiPTsgI5o7aO4IS9NluDPgelBQ62cZYNq4/Qjy6IvlT2arL?=
 =?us-ascii?Q?jUg2WillywsgmkjjfixZURJ+TKdHdYZCwxfprnNN0yzG58uE+IjF/VizzbnZ?=
 =?us-ascii?Q?YBuZgRVnuvIin7h+vzsJOpxwdB2XDIh8cENv4oMNUg8Inpke4ieFxhzQRNBC?=
 =?us-ascii?Q?xByPMg70or8LnayhSgW5fZOkIinoBVZl9XAQmvkOt61RTCVOXYnhU/On5htz?=
 =?us-ascii?Q?RX6v4lgUrRhxhZcjStj0FBiaisadgBTjgN+wbyj9myql5MIS0/CcgvBZjyEj?=
 =?us-ascii?Q?pIyy0HidtJbxezZNnAR6AzH/sMWqcG+1WTfNRGInuhLWBMJStgm1F7WoSFlN?=
 =?us-ascii?Q?JezDLMlcji3VBUDJ/a4JNgYioHH2aWv+bTV9KwoxdeQrOeM3/Na/5TtcV6aA?=
 =?us-ascii?Q?HVq7+TQC1N1mTLG2TxP0oy3CvGV7H8iqG3c/TnkRdya7qSguvZA8UgzMcXlh?=
 =?us-ascii?Q?oViy0fEE5fGM04Yi8J0vgeWItdiDVtLcdHjsyzDUe6w5PL2K1i1BpPdtSfwE?=
 =?us-ascii?Q?lOPs9CEcXFdXcZpkjTywtwbdM/3Yk95Xrl4baCr5ZTxJu1hlFqEUMJ2C3epG?=
 =?us-ascii?Q?Q/30zS9bAFyfFi8BNtYo1ioucy7GdvUCIsa15ljUiQMIwURK1BY98A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1rrCIc2SP6XZqEnMYlIdUKOMq3G5blmM8e8chfmAGHIzHYCvxIR787nGrhDE?=
 =?us-ascii?Q?P45yT7w3qjpXds9VWARaTSo9Vmju5+LW0ewIphI3dKy6AMVRSkeMP1oN6Wge?=
 =?us-ascii?Q?yJWp36IMCjHpf1pvD2GBqg7YD7aetoV/sPwmQGsYMbxUywFVaiPfYjBsTWiZ?=
 =?us-ascii?Q?8ujcdqURVD6CpJeDzfHOFUI1wUBr6SHNu5F1pbM7GBtPwFnLu67dNC/jseOb?=
 =?us-ascii?Q?umdA1fWJH6dCwXr3ObmBuHd1UFSZE2/+AIZUFpnq+syKdZaiJCMC2MwXTJAc?=
 =?us-ascii?Q?vXkXd2Ryca9CgBuOYq/Jg4oo9yGVcjVEQEvdF7eToZ0QIXxNErxW98lMUBIk?=
 =?us-ascii?Q?yoKi+PSyqlU7R751Bs0yjNLWpOhQlkEWQe+jMyaPvnK6tw33/VdgKQPf8byP?=
 =?us-ascii?Q?kHY/bK/GSZcREG6UMF3eXLfG1ckxDjW76r1Ow6Pr1towhm+4OjD9rmOBVC9r?=
 =?us-ascii?Q?z770xs5Yk4fShUBG+VAFjBX/f/nH9RN/Ql2O0PHYdCFBReN77WBfwOpRiAW7?=
 =?us-ascii?Q?M83lM5TF5VJFv8N866P+AmMYh8nYpCreXsMaAD86TCfYrCvJmqRajUEGt6Et?=
 =?us-ascii?Q?09OsBHXglQzX+qpGXVP5y8mW9LPLhW9e97GvAKrJIXc63irB7eImKbTayqCT?=
 =?us-ascii?Q?kXZTkGSPiLaN/Fyt/W9EB3jCub01g+98mF7Zb+gUZQdHf73xXibmmNmLzBXm?=
 =?us-ascii?Q?NqwdnDgW1nIwTJx5ANXszdRxwID1aFemUGpbd+vKdYGTNHE3hSttUiKkh73A?=
 =?us-ascii?Q?T8SJKdszlacDMTGEYL1ddGq7QiU5V5A2UJVH5g+grEo4hpReTvsJgzKX8Iu8?=
 =?us-ascii?Q?QTTHrx+pjB1mFfIVb/ENfTN2RiSrlUxB2br7psvgSzhPhtKtdeY+PjqEtxVV?=
 =?us-ascii?Q?1qC2OAEDm2tWjEXkdu2px3+iHwGUfCuLUp6Y1Nm1dp9T6qvyx+vzV8kh0WzB?=
 =?us-ascii?Q?GApq4t2i/eSiFDSOcUDyvMjEeqFHrNn6SUazYR7E95jXWT0bRT4kmdZAIlux?=
 =?us-ascii?Q?381dDlatEUhRmSs62IVomCOBKmxCvMRxhZuNO+kpzIsLiNdL8BtD5Ny+PJKV?=
 =?us-ascii?Q?N8J/0Q7eeW4jJFvIgA/DyfhoHdnp0JWehiUnKAY+dibsV/R+Fa+Vv+LexSqB?=
 =?us-ascii?Q?X9tFE2B0QTAYd6IsOc7ZIHQ3sDVSR3UrSmvcl0KC9eaGVidzop8TcM9XRqt2?=
 =?us-ascii?Q?ZZD6IKSLIr0a1OVBdLGeoEnHpDQhYBLHwoalhKdNm+7bW8ubKc+SQRdBMGyk?=
 =?us-ascii?Q?gzuTnVpJoaeZbbVcGUemxgufWxEHchbHsbZoaCxefDgboHK/4lQBOnByreSC?=
 =?us-ascii?Q?6o+D4DhN4X0fdxHu/0MLn3lVJ9baLO3TOfi0QY1XG/mvarlCJfNjUZRZ9N6v?=
 =?us-ascii?Q?FPYWpFzrEutby5JOA7CjfSqc4BTUmLN5rrcFGylzRn3y+lFb+ImQxbIqVfDN?=
 =?us-ascii?Q?aeVm6NIl3pTzTHgPeKa+k3ZQfBZpJ66g1rbg4hWlZf0qw7QTl/7sZFMSKPPA?=
 =?us-ascii?Q?gcij7s5Uf+q+/ep22lTjsc6TGZuhcBA3CAxikRrq7ZGxbU2qC0HCqFvXVvbj?=
 =?us-ascii?Q?xoPwHuqyFsHSi77aSZBnGaqQVew8zPlu3xSLK/zd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e58ee5-9782-4088-09a5-08ddbe004e38
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 09:17:48.0773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ghj9xO36MX8+gTpJLrLeatjH307zcpDsj6j2nSXwUMShrORdkPy9RoaX3s8rBIRvdKpHl9Hm+mKC+tvSX0wLrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8170

From: Pratyush Yadav <p.yadav@ti.com>

On Octal DTR capable flashes like Micron Xcella the writes cannot start
or end at an odd address in Octal DTR mode. Extra 0xff bytes need to be
appended or prepended to make sure the start address and end address are
even. 0xff is used because on NOR flashes a program operation can only
flip bits from 1 to 0, not the other way round. 0 to 1 flip needs to
happen via erases.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
Changes in v3:
- remove last if (ret < 0) check, as ret always >= 0
- remove Micron manufacturers info in comments
- change nor->page_size to nor->params->page_size for latest kernel
---
 drivers/mtd/spi-nor/core.c | 69 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1b594f720b6c..20ea80450f22 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2128,6 +2128,68 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	return ret;
 }
 
+/*
+ * On Octal DTR capable flashes, writes cannot start or end at an odd address
+ * in Octal DTR mode. Extra 0xff bytes need to be appended or prepended to
+ * make sure the start address and end address are even. 0xff is used because
+ * on NOR flashes a program operation can only flip bits from 1 to 0, not the
+ * other way round. 0 to 1 flip needs to happen via erases.
+ */
+static int spi_nor_octal_dtr_write(struct spi_nor *nor, loff_t to, size_t len,
+				   const u8 *buf)
+{
+	u8 *tmp_buf;
+	size_t bytes_written;
+	loff_t start, end;
+	int ret;
+
+	if (IS_ALIGNED(to, 2) && IS_ALIGNED(len, 2))
+		return spi_nor_write_data(nor, to, len, buf);
+
+	tmp_buf = kmalloc(nor->params->page_size, GFP_KERNEL);
+	if (!tmp_buf)
+		return -ENOMEM;
+
+	memset(tmp_buf, 0xff, nor->params->page_size);
+
+	start = round_down(to, 2);
+	end = round_up(to + len, 2);
+
+	memcpy(tmp_buf + (to - start), buf, len);
+
+	ret = spi_nor_write_data(nor, start, end - start, tmp_buf);
+	if (ret == 0) {
+		ret = -EIO;
+		goto out;
+	}
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * More bytes are written than actually requested, but that number can't
+	 * be reported to the calling function or it will confuse its
+	 * calculations. Calculate how many of the _requested_ bytes were
+	 * written.
+	 */
+	bytes_written = ret;
+
+	if (to != start)
+		ret -= to - start;
+
+	/*
+	 * Only account for extra bytes at the end if they were actually
+	 * written. For example, if for some reason the controller could only
+	 * complete a partial write then the adjustment for the extra bytes at
+	 * the end is not needed.
+	 */
+	if (start + bytes_written == end)
+		ret -= end - (to + len);
+
+out:
+	kfree(tmp_buf);
+	return ret;
+}
+
 /*
  * Write an address range to the nor chip.  Data must be written in
  * FLASH_PAGESIZE chunks.  The address range may be any size provided
@@ -2164,7 +2226,12 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 			goto write_err;
 		}
 
-		ret = spi_nor_write_data(nor, addr, page_remain, buf + i);
+		if (nor->write_proto == SNOR_PROTO_8_8_8_DTR)
+			ret = spi_nor_octal_dtr_write(nor, addr, page_remain,
+						      buf + i);
+		else
+			ret = spi_nor_write_data(nor, addr, page_remain,
+						 buf + i);
 		spi_nor_unlock_device(nor);
 		if (ret < 0)
 			goto write_err;
-- 
2.34.1


