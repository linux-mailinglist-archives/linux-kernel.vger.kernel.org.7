Return-Path: <linux-kernel+bounces-777656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA46B2DC49
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF818562F73
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8E92F1FF4;
	Wed, 20 Aug 2025 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="b1YXp+3M"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023098.outbound.protection.outlook.com [40.107.159.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20E11F8724
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755692479; cv=fail; b=tvDKeK7u0jMrQYz6PQmdCT0IU0Cxg2RKiWk6XLgjeVRNvcN64aT8iuMVL8MXOsBw8goYCE9PV52p5OoL2MuojiR0Xr5UY7KneLYVGKk9UBBTqppPBcnr5C3nZRdloUaZucQvrJOIzJiWuYZQNbIW3FtMIIS7kUn0wwvpIkIXFoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755692479; c=relaxed/simple;
	bh=sj51G5bsVftDTcJAHNPm/6Bo4WsDkMgnxhUEzU9aki8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jV1tUh0u37ZIKhRO89tUqywtsBVetLhKOyG0ZhitL3aB9Op0bmd+sCICyQdLEbIl8rTk0Iv8K0GvfiSxm2vhond97b121UbgJMFEA93O1Adpve7HQCLQIuHATxTxgVAxH7lKNFtOsfsEtWd8+0iFbYNWdrcmWIWmokQIdEmcnRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=b1YXp+3M; arc=fail smtp.client-ip=40.107.159.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPibZ4qzgiZtuEB1q75SlVtc5Na+ADo4DSxoAIk3RHZGLefYMbUwyERHc/CjM1dirdC1oqaKhSISTTixbvOP9xKQgpYAfZN6qMCreEMjbtKdKdHOAc1Ioe6uPCet1ow2IWiFMDlRDbjW8Hdfi5CTbHSXlsXrdvVHaWuPXauoewz1d8/lliHsBqzHDZdd6C9t4V5ghEjRbkb9eMfJbwAc4MVCp/7uw8ZjPeQUYaJaZ1to2a0wXDRetHVDbbsC4hTpPaLIuy4iY/nQnedQ4nncksugX+rjP6jOaBW9r3a3v2CT37T9RX6Aa90wdmvhk1vwT3Q/bxtrsrb61P380dlqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/w2WIgLnuWOWmC0UgqGOLyNjwGVYChlJl+uuUstHaw=;
 b=TbzGtFL5YTKD4vVNtCQng4USNHNc9EcYHV31ehIvke8i6yDtuGjVEQ7c+P/tQTgamUxGTYflOtsxPiHUmejYajFLHPzRs0R90Fen6Hbwn6iHOJVrzg3P3kn4dJc01H8JGcQAySfXPaUi15blSy2+KUrgrXxr4eLTQUofksnLD6zmxpw2hC/p9nW/W7I2ZqXr3dN5nOUOyV41U5cgHy+aCVaPA3mxUcxFGVAMxj/8FHj2z1Brw8Rk7RnueLuCwyjflowfysGlviZeo09T3+rxV0MVt19I76bs7M55xWxNpDjh9XveIWGK7Vvw4ZIqqmNqDIAFjYJgad7tnwP445XpZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/w2WIgLnuWOWmC0UgqGOLyNjwGVYChlJl+uuUstHaw=;
 b=b1YXp+3M6CzjSq2hA3XtAtw3XDHyfNW2yADM0JnqMLgHAxuldWRtuWMf6mxbL0Jp/4O56O3MJHBLsdwgMpSzqXMtO21P1ep3vvogtPsGBi2cieabwVNgdq4fyYXyEw7zT9VRIYkSPeKxR98f/oSbR2P1PZn7VV4kiP0O0pZ8FguT72WPl4pWGpdx1FxFLdIUfI0U7T5V8x/PLSCaQq3DBSP57SCA+U/wDC7Uhm/meDSSJha174kRg4PPbVrff0TAADQjepdV5ywoGAxjnk+Iz3g8CeIzViYVIB9b8HP9jDc4XxLqJFFtlLdGUBTGNEucjbq1r1p5RAfFxEBf7vUoQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB7958.eurprd08.prod.outlook.com (2603:10a6:10:38f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Wed, 20 Aug
 2025 12:21:11 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 12:21:11 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Mark Brown <broonie@kernel.org>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 1/3] mtd: spinand: fix direct mapping creation sizes.
Date: Wed, 20 Aug 2025 15:20:58 +0300
Message-ID: <20250820122100.726451-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820122100.726451-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250820122100.726451-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00007A8E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::60b) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc60152-ad61-4b1b-6f84-08dddfe40c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6vwbCFQHr7rIYU0ZU/IQpuQTwCz/blOPiVoHlIBWaOk+p1gbObdy5Crtpc+g?=
 =?us-ascii?Q?VnZk+xfM7S5b+nPcUtfrU36dS1gOc7bTWwGO3zI5KM5MJu5FGrQmQMW6R+1L?=
 =?us-ascii?Q?lU2KWYGnKOHvC24F5fTbCPpgkx85YWxKkvJGYnTdlFyquj4eXKbJkUuDUSam?=
 =?us-ascii?Q?8qukrRRKU+Z9Vi1Fr2/BZItV9HR2fHJ/P1E7OWdkySwQP4c6OVBJ/qgdCN+E?=
 =?us-ascii?Q?UTNda5EtajhvV2CJAQ3rZO5iNHDnnXU5kn3+m7g7G4mG7XaN2/bkzNKDwKH8?=
 =?us-ascii?Q?8/cuaIiSWJD1CCDidQ87rvtGR1EXejxlH9y0otmE9GAOxQ6nw3E1XkjbEA/e?=
 =?us-ascii?Q?Je2+QLySNGGTfOUz3yyWyXWPhOJKob+gTS2ckk0SRTlzve+n0eYU/LZoVnCG?=
 =?us-ascii?Q?Tbu3UnFGMA6RLrHCkc6s3fvn4/XC/MQ8iq0hH5apxuwkEKatuFOQezlXHtE2?=
 =?us-ascii?Q?6d6UHo2SQZbphZm7mdSdEEGusbbCWvqjJ6UsEboMlt4KuFNMPnyiF1DzcMvm?=
 =?us-ascii?Q?inzZMey8Y6JhY28tM2A6nLc0MSUE23dqcEgAUw1W3xb3ktUp3AoSX/VVkr/J?=
 =?us-ascii?Q?N+DqJvKo0dbxsg80VGKG12rqHb0s55xscZIYIgVSVz16NpHmVm8WdeDp5mU7?=
 =?us-ascii?Q?Kv+TNXIfxVBFSZZ6ceqb0wWKvf4GO40l0AUbKzBzq30QYMLqiQVxQIJUmpSJ?=
 =?us-ascii?Q?VVmwdgF5xdhfveko4exjbIe2QvE7CkvZkoAKXU0Ct1maqi6jqczoE7cmbH/8?=
 =?us-ascii?Q?nWVyIbN+XjtSVyGhK2CWe+FUVa5Wp6MpISHY1B4ribTLlcPpU0OJDA0s+yCW?=
 =?us-ascii?Q?q8ciuY37HpKhjl7C6dsYOdI2sPXWjAAhQA2KwyQwEObQoxVYIhulLGMAc5r1?=
 =?us-ascii?Q?bIg+4yQYyyqjQJdWyXNtuvO+OaHRgFHDwymRHs8FrBvJ/ISD9MtW5CKQvFfB?=
 =?us-ascii?Q?dD9wJX3L0fv2oFE05wPo5OnEsElN1qYp5IkDgcYVB2xMJuCVurBoUW+ZUNy8?=
 =?us-ascii?Q?2YppYT3z2UzWmmvWhOaTSgH9RupEfrNeN5Fz/22IiKYbNNMBeiMRtTslcvBI?=
 =?us-ascii?Q?NHrxCo8s69kGdH5fFWTGxV5MBJ4fdoBCajLuIYNnQPuSM0oY4LCkSL8tzHtl?=
 =?us-ascii?Q?bCH+QjLI4sFM6WrVVDvMJTHzuA182lLSSDcgV58yNRtmLhrUFl1xLR6H4LgI?=
 =?us-ascii?Q?ZdWXIfHPv5etp1hwMAfhAPzSz5vlVy73DdamP9PZ9vrmVke+KlMK3V2W4y5J?=
 =?us-ascii?Q?vXDKR/77lDu70kSkGk2Oz+ozIpNWWX8gP34IQmWlKU7SEayob40A1KHi7oeG?=
 =?us-ascii?Q?mDL4xIOaX8bMxXAP5oAdDzYRE37ldvB5YgyjtfjZsaB4UJuxsYo2Fici6TUA?=
 =?us-ascii?Q?QhsOniMAbrkhnsAeLRIHR1n68p1yf2ygwbpk0iZ557iNChUvvIblyoLsNNck?=
 =?us-ascii?Q?I1a/vLoT52VpqKTSPihZAPisCRgY6EYLWuN4wvzZuFT+fhoNBfBM1soW3dfY?=
 =?us-ascii?Q?4QfFQqmsMi9uKvA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HsnnGflvziLfTvIa9R8q5O3QvKcGRrCx3paJyDOHKzQXzaUO/QfLs5/G0TMa?=
 =?us-ascii?Q?tU9arSbfyW6B0V209GrYn/vD30qUipuzpJVooUnZuqnaWIsMVRuhmm1tyRqY?=
 =?us-ascii?Q?qiqeLEvcfSGvd0Yuk8Tr/KuwdBah+qICdHvlvkDLlsEEFoUZwT7x4ZFdUy8W?=
 =?us-ascii?Q?pNB+3JAaTbQw+lnS189YZFicxBqcC17leANWIniu1Xl7IEhoCJiX4xE+/eC/?=
 =?us-ascii?Q?/pugAOB1ViMf1GF4a/CaE5N8MHJbFS0sH1iAWnnZYKh+wqI/zkZsgTViAv94?=
 =?us-ascii?Q?Fc7O8GjG3c9jc2UHAqstD8NQSimvMK4R+DeZ48xD0yM2+vkYtXRg7J1KeuBZ?=
 =?us-ascii?Q?FHd2i8270meZ0DfgykAKvM+4rRwDvLLb2HfBmwZP2nTry8hhnKdiSTIDEX1G?=
 =?us-ascii?Q?sL0sVESh3QuhRB/VcGerTwJSz3uEWa64ystWVJJyaG5i7fenW13mn8Klq4Ea?=
 =?us-ascii?Q?25q5M+zXWXqYCrhzsJ/soGtKe96w3HtZd6a19SU3U7avu9VQthsyUNgxWgm3?=
 =?us-ascii?Q?RxTB++IBn9TnW1cSQyS6+2FAU4UaMfiaHiT4C5IE4LEVuGudpCITo062vVh9?=
 =?us-ascii?Q?I0+aoo0ttoLaQqYnWkFjh/P/iMzte7aJTY4bS8tNeIWrfOIIaHDNx9z1dBNb?=
 =?us-ascii?Q?ssKFcB8T+ii2iw6KtopE7fE4K7lo54Xd+n5oAymlkhJ7qrfSFOYelWPJlew4?=
 =?us-ascii?Q?5JUQQc9WIbV1+TrhO60wRORDaBRLD8gfgHx/3HSsqH+I1fAfhqXZJp2eDftQ?=
 =?us-ascii?Q?yYh1C/ao/osi5Yl2/0mEcFQM6G0AZWkdbQL3CgrSjhX0yW8UYnyk7zR5Gqw1?=
 =?us-ascii?Q?W8g8FQUr7YLMIhEzuDmrhn7LsKNsWNsKLaNWuImFlzrLQKwbTEsyuA0dqHZL?=
 =?us-ascii?Q?pZfu2+6hX3dO40UwdGpqGCtzzsCZt8NkwJ/rl1tH7K+L2rW/II/ggA/kPY2D?=
 =?us-ascii?Q?tZU4+jtAIsagp0KxEcnzQjNcSZuNzgFZYZ/xt/XkIiytZo92LlD3FDBsGK/C?=
 =?us-ascii?Q?URSPKYFRklDyzNHrr7dyHsNcd41Na6rd+qfHd8STGtYRFle3MvbqoQcSsW6p?=
 =?us-ascii?Q?jxt31iiP4CsW//bTWF6qfJAl9OT/5E2kceiLTW91By85YCzl20vrD8CSj5YJ?=
 =?us-ascii?Q?LTDyukmIxpblFxj8vkI6+0PFcvRVFZuH27XjDBCPvGAx5ZgfO6u1TQIStEN4?=
 =?us-ascii?Q?q6HEYRHmMSUNZ+kUtBDd/zI7o9+ALw9prC2mHwK4z+pbNZIoiKRM7ja7CqR1?=
 =?us-ascii?Q?6YiiGoavIBrllYs8MeHNkwvMcPBAz9tALf8TCMqEBKbbd3YLoODAN/AjXQPD?=
 =?us-ascii?Q?tOtnIZ6QklVNL9GHfUigBe4Tw7aEiSgHz29JgHVvw+9KYbRE58axAB+zZc4X?=
 =?us-ascii?Q?piVR4/lhwkHx19T+az/w88cOa03AZk8H1xgie7IVSzMhGpFaMzlSpbaTWeOZ?=
 =?us-ascii?Q?38m7BOduse56j4AcXj63glQGkJJA1iLvdnEbLqFlV8aAeAkJhCPOZFy6220c?=
 =?us-ascii?Q?sfgFhGhyrbSiwDA8xFCeSEiXW7ScHiMuQSdiVA4cWSpFpWG4XMaP3Z0FVLtQ?=
 =?us-ascii?Q?gQ8sj4IiG93SkDS6ASCjztBsVQp/2Y7G1RLs45FNyy9M43AoIhLe5ISg2ZbM?=
 =?us-ascii?Q?I9yTel8jdrQfYrpP2NO8j+g=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc60152-ad61-4b1b-6f84-08dddfe40c49
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:21:11.0098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 514d7FLmVvc4P1KJPbQihw8L1sxOcQOU1/M51hg0QJsNwZACaYEE1pix7Ix3t9iNKoRE4eKfBqNLHbZe/oekD5aAyi8SKZJryTzHuwU0ASI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB7958

Continuous mode is only supported for data reads, thus writing
requires only single flash page mapping.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b0898990b2a5..09dd6e40e308 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1097,18 +1097,13 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 				 unsigned int plane)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
-	struct spi_mem_dirmap_info info = {
-		.length = nanddev_page_size(nand) +
-			  nanddev_per_page_oobsize(nand),
-	};
+	struct spi_mem_dirmap_info info = { 0 };
 	struct spi_mem_dirmap_desc *desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
-
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
+	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
 	info.op_tmpl = *spinand->op_templates.update_cache;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
@@ -1117,6 +1112,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
+	if (spinand->cont_read_possible)
+		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
@@ -1132,6 +1129,7 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 		return 0;
 	}
 
+	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
 	info.op_tmpl = *spinand->op_templates.update_cache;
 	info.op_tmpl.data.ecc = true;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
@@ -1141,6 +1139,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc_ecc = desc;
 
+	if (spinand->cont_read_possible)
+		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
 	info.op_tmpl.data.ecc = true;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
-- 
2.50.1


