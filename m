Return-Path: <linux-kernel+bounces-777657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C526BB2DC46
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3791C249C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35B22F5324;
	Wed, 20 Aug 2025 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="O23n0Gfm"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021101.outbound.protection.outlook.com [52.101.65.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09092EB87C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755692480; cv=fail; b=ofjyYOVuJZk5inmBJbZc6YnemHrJNPokH/2fdeL9+t8N/75yxYFzskYHJ8Txkrh46KUDVVGguWdshmOdvChZeYy+wcHd260Ny7hf57lcs8x/cWuq5Y6s+tcl9WLMr0R8Aeurkj/9NNISrAEMt24Up+1UPs8GceTehPoRoZ6UGEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755692480; c=relaxed/simple;
	bh=bQ5vLcmq2zdqLn0Tb7YCnOklNW5oaKe0nNgn2qnG1zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ImS3fwEuBM2281y0lZkuHp2qL7N1C3+BJ/VQAEuM8bS3SROin544VYMymPwCaujGNyi/VUKM5Wes7lyUQOdkXXAJ1XdmUjO3iYDLDn8FeRaVjJKUqGauN2IlJImV3AXukUCNKOcZvr/nfdFAMUKnNmxJvHhn1njUjdUT0GeSna4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=O23n0Gfm; arc=fail smtp.client-ip=52.101.65.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5mUWEkJmvJM0xjMlWJeGR1SAcX6Uco6zUEt4Jyfx6ZokWl5JS21DNwu7U+CnZYYnRhK/Em5AoFQ2Q1q6CrZUopzu1wrBetbtYn3OBRcHkoB7M4sMHeMDK9xMaZuqgcRU+tmlSC8az4c5bkqB4cvsPJrEYPnFGQcFQL2JxjnhyVMCXPPuaIJoxmMWxCsFKrHWQGmGbM080KCAERc+A6WolsdJ9WVsuUkECDNCSOuu2bQch7CNukzylBsgMNk5XM30UFNiwmTqssACGdd2T6aZQGCN6Vl988ATVS0seBpf6k2d/oo5olXoSs3QpWjMnpZWRv0eJK7etbfAP+hM8WdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VT9NMzqZCjVdBwvXOCsCUkrYxBVp8siKFy8LVUaPos=;
 b=flsZxsWRVbJHnw9t3BZM7F0T+Tshj6ADER/Qcm1JojwJmGzxdUxADQgOtQBX8uKn0oegvCBpyByZhNxlL0J/3JBw3uxzSA/eaiV9hEjj8Ph98OX9WFlLRMZOfDOTVj5/SqOH8n769uJCQUcsXxAwtfEeA3sTQ116rOQDAXWiCAmGh6Om6IJ6xswaN/BBHFfQR4hgYdoyAQOCZ3QvSx/uoXCefTkH167Ps27OEcHFaohqr7JmnZuPElaGoedUcsoRVbw4SmZcKDEA1YqZgMnromyGStZu3X3W1UYvwXpmT6RRKgQBzKuqTMiqIqM5oOta5MT3tdjm1rtqGwCUq1lBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VT9NMzqZCjVdBwvXOCsCUkrYxBVp8siKFy8LVUaPos=;
 b=O23n0Gfm/mFk7lmFh+k9iIdaV4WuXXQMJyrV60v193qRYQ0wek2uosDns3tcMTVSTWEaNz7w/aT58vDPelFfjeEc/9C3gD6m5QvAf5m0KobouTg4wFnxkGlm4SA4IUttdE2Uo+uWxU0TKF+rCsa0NjbHDcvD2qj/mBXdNmcHEzR6Xxsq92QZTi2n9UlhDpva5FL+MNlzFCIr4Hjp9327cbPa/Ol6QX+Yz3Q/YVG6cd2SqTeZvx6TZtVIdh1NNjRcmURcg2hUX6yZ3KHMD9SCM9FryVQAb0deqCQwO/52BM2nQYIwtc+chncd5Y4p4kRA6/skrl7JmTmwGz6PqSmj8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB10433.eurprd08.prod.outlook.com (2603:10a6:10:52f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 12:21:14 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 12:21:14 +0000
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
Subject: [PATCH v3 3/3] mtd: spinand: repeat reading in regular mode if continuous reading fails
Date: Wed, 20 Aug 2025 15:21:00 +0300
Message-ID: <20250820122100.726451-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB10433:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab55478-a70b-4e4b-5592-08dddfe40e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YOVrqDlEdxZCHNn2PZYhYMc1VQxj2CYhVUvqwRpv8ZRg/D/ShLHC6+9YZXe9?=
 =?us-ascii?Q?6ceqc9UW1mTxtYdYfXZDqK1WjdPjOwbJWRudF3sQ/4dVGdo8Rg5eHMVT4X0A?=
 =?us-ascii?Q?4XXmoU/D49R+RqQmT0NIqVqQ/ci2jFKYaHyjk7QVN/cAyf6MSbinWJ6fPtYY?=
 =?us-ascii?Q?wfdHVk3fVxaiZcKLeSC1ZHulLWv4t3QrYozzy69Dk58CsAORcOwH3Hco5lGA?=
 =?us-ascii?Q?dWc9RkGKzcaLC/TX+Zhd8lxANf4KvL+Vegj6pvHZT1u0xeX8ERa1va1kCnnE?=
 =?us-ascii?Q?0JulYxNw2tuP+xSgGJT7rHSof37gQfWY3ryNMGD5YRLylqwU1u3si2sR6EFu?=
 =?us-ascii?Q?Vt8+tf96cyGGC3Da8HGfky8uOZOt34X7OF0P+167qDuN8yngtZnFvHJz7WtY?=
 =?us-ascii?Q?Q9XbWzLFoLQniWK1DXDBlm/r0FjDTIs6UfQGgf005/7UEKJ3PVmVl9VIufxM?=
 =?us-ascii?Q?3NQ7TF4Nj/auYeW35S7nVoD4pd3hLf2PVlLFEyu4IQ46QcgGAW6AEjzFRDcG?=
 =?us-ascii?Q?lXB2vt90dqWIkQSW4v4+50px6iDkWFDT2djDOXTnDZ8Jy0wAIBu9gEN02O6+?=
 =?us-ascii?Q?yU9HyB19Lu1FCnGP6HTfUDScm1FGfEepXXEJbnng4JzwpKi/m2ac0L0mUSuw?=
 =?us-ascii?Q?wCkEeenV9p6lYmGizfnPp1bcZBqjZoujVtnExxWuOXSUFm3NMYxxpdZ8K5bi?=
 =?us-ascii?Q?XOEap8740qjAF7/6EiKrxwI9rN7P9P5Prh2cgmNQUojoOSudFvy+Q0o3JekY?=
 =?us-ascii?Q?F3FdI+COY5vdUGkcpbcNCoqIVVWtVri8OweSXYAAj/r9yqjfA8/2kxCVKciw?=
 =?us-ascii?Q?1n78783E22J+naclcD+gFwJAFZiEIZ9c0AekWEDQOVPut/zYPtLJsh220vJO?=
 =?us-ascii?Q?KMQbuO46MXI729Om1zpFXG4eE8mecdetEqX/5ggL2w8A9mriVfvLiDCMhrVT?=
 =?us-ascii?Q?39iKZT3yYhFb8BOy/64NmTvF3RQBvsA1ofBkMmJn3gAhctkso1aIKjN3EIbr?=
 =?us-ascii?Q?0mz5350mT6W3DlkTuN3Kd89m3KX2YTHgoruwdZIBguKW0678d7PHAUPLpDde?=
 =?us-ascii?Q?DbRR+KWbVOU8FDoSAkPkszJxA9nNPfEq9T2l4n9AMiwMyi63OfS6Hl075kqQ?=
 =?us-ascii?Q?7kCdL5lSyCwfkpUR5ncpzsDpnyfJSsa80Wbc8eG68FpF8GaRZdTMYxJyPI40?=
 =?us-ascii?Q?e3+HM7Uf12RlVHlhAbJNGJCr6C9TrBMpAck9mjXPX8AMbg6FV+jwPAy50GC5?=
 =?us-ascii?Q?cQF9xsoDp8G9ivzavPWOyVtKxgtcnWS8OFzmjnimhLIEMkMPSwdS9XGqJmCp?=
 =?us-ascii?Q?a5D6irkLqmyEVZiax9IFLoNL70naKOJ43neM+o8uZy2DlzwDG1zPuh8erWML?=
 =?us-ascii?Q?uWsFubQMiNGUguaN+InmTam/KildRNrkobqNkzRkm2EVlu0By3PxuzKVJL7U?=
 =?us-ascii?Q?HoPAiti3p1dpuSYBh/Gc1RwsFCaeLCl8BUJzh3UAxJ0vN4CiScudg1LxMMyr?=
 =?us-ascii?Q?L8gp+igspODPi4k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?slW3MPjQh5aIVgh90yDCTyBcERCDceJLJ03CuZa5ObQ0fLPKGkLAj7lvAUlv?=
 =?us-ascii?Q?VZTdy2Ofhmdfh+gMfKS4JWg8Slhk3t/NW+nw4MzZq2JtZp+nr6KmyxntpVL0?=
 =?us-ascii?Q?yrIhSr+KCXYrRJkRS+PZPvMl4j+VCS6gOVqPeGccE2O4SEUIdqPOsQgDPqyU?=
 =?us-ascii?Q?CMTrR0ZWIFh2cXzuszX1swGznfbBZ1gzt/4ynHGvHBSq7ZJNaB2bOMpLO9H1?=
 =?us-ascii?Q?EqlwE7+/6I8xrxXQMIkRAvv7GTP197dPbd5Xio+N20YHJP+zNboQlHmKC8L6?=
 =?us-ascii?Q?+2Z+i30McjuRZyKMhXsYXFzSLOsvPiCS1VAcCJfjxzQrYdYFMw7kPVIkkXLW?=
 =?us-ascii?Q?dumS2pK0tAMH9MB3i5Rz+VaN0e0wGgtjAac0O5uHYGgVndT3EI0vZVh9zw3t?=
 =?us-ascii?Q?Nuo7kQE2yxR2/GvOv1QSn6Fbjjfk4iflFa9EjgO9at7ghfWwuWXkIbsbBJN7?=
 =?us-ascii?Q?lPJzoPSBrnudseIY+hAl/am/4jtu5Wemmoq9Y6Nd6426C3ygGDtdQccc4q9W?=
 =?us-ascii?Q?iED8rPLKqcKITZX/wpGPato+g/RUxuzPdVzcVcx6wdicXcuxd4UaEucmWzdt?=
 =?us-ascii?Q?u2M2gEe4b4DOgyoZcNAJd5joefukyzWDH6NNJnrgJrLpb+WrhNgcdq5EV9cQ?=
 =?us-ascii?Q?rxBumbcqEG9yYTexY6cioHvKUvmZ6PXXd22PZdU1ZprMrSMd/QHHW8Bdcrl0?=
 =?us-ascii?Q?yAlqWvWZp9grn7/McTI1W/tQHrJshz9jIc3kPz82IbCq66bD6QNbVNNP7pIT?=
 =?us-ascii?Q?C5O8Be0SItggcYhd0+TjJzXnF2hi3Kos6WM3wUD/3ASvAuKP160qmQ0U4m0R?=
 =?us-ascii?Q?zx5FiE6BrZ1dyUfztpj4S2BJI6+c8Gdffk7j3Xeuo47HG2wg1aARVRR1PboM?=
 =?us-ascii?Q?A4OgtoQnZllF2Nc7Q7+16PH/7kNCsPDlwZE0MThlTs6XARPm9yMTxI3La9zO?=
 =?us-ascii?Q?hnnUW5+DLOHaX0sRPUeEwVZ6MkGix2iEj+Mk0+DXCALLS1I9zfso3tgm/Osu?=
 =?us-ascii?Q?B7zMaweDkmPhUNDqP6e2PArTHpR4X21qD9kNKxEh12gwaIsOe9J53Y0yBghf?=
 =?us-ascii?Q?rL1oT7cPBrukQ/kw15FfmKtmnhYi/ghJdiKj/+u5OYbhc8RH7LFB3rpgtPUY?=
 =?us-ascii?Q?zFMxYeIP31YBBgLcx8MwScRYwQ5oFKGacAHUONFHJrc4EN0XQcxYYV3bO9Y6?=
 =?us-ascii?Q?Ns7Fh7NKsXd4ZWDG9ZiKfr9qdJXqy+cRPl9XOnFffBHvFdvEL6dX+YBehf/H?=
 =?us-ascii?Q?O3R6nK0pEBVJjR/Dz/NsvPLx0cGzZ1CaCjGGlKnFVd2iIe3zJPDhAtAbxgcW?=
 =?us-ascii?Q?Hk2CfXfHVBFE2XaPraPfJeyz477kbHpsL1CnK5yxMLB21MYjHo1aK4MgjhD7?=
 =?us-ascii?Q?uVT71UgTicoWr7BHxdf3jlOkyb4MJ8zTHu9fV1QbcFlItpX8ib/mAVVzkROd?=
 =?us-ascii?Q?OTWyaoJWRM+Q6QowFvwuZbXSCTD6PkDmNLoyFHmGSvj0JWZYm7/WRS+4iAPR?=
 =?us-ascii?Q?bf8IRgNWRgrEsikNiL9ucag+7bflO8/KDYCtR8n0nCtlZ/7bgNC7yms1KNwf?=
 =?us-ascii?Q?ZyecdNNoV1mcZzodAKLVPOAFDrZgvmc8zWgerkB01kGWPNsYsdsdChmqAJQj?=
 =?us-ascii?Q?X4PQqb70TvC7lnCN1TNssFE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab55478-a70b-4e4b-5592-08dddfe40e11
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:21:13.9756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CYnQ4DweSC0J78D3kJDCHGJeyPAxSSCRiyWj/jZMrFtNIJXuoP2HndLp3p9kJFoSStuh+ZuOz7u+xidwvgWeyGw3NUh4hEKZCfLsd1rSUu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10433

Continuous reading may result in multiple flash pages reading in one
operation. Unfortunately, not all spinand controllers support such
large reading. They will read less data. Unfortunately, the operation
can't be continued.

In this case:
 * disable continuous reading on this (not good enough) spi controller
 * repeat reading in regular mode.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 39 ++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 0f8636047365..5528e1f72dbc 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -378,7 +378,8 @@ static int spinand_load_page_op(struct spinand_device *spinand,
 }
 
 static int spinand_read_from_cache_op(struct spinand_device *spinand,
-				      const struct nand_page_io_req *req)
+				      const struct nand_page_io_req *req,
+				      bool *controller_is_buggy)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct mtd_info *mtd = spinand_to_mtd(spinand);
@@ -430,8 +431,11 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		 * Dirmap accesses are allowed to toggle the CS.
 		 * Toggling the CS during a continuous read is forbidden.
 		 */
-		if (nbytes && req->continuous)
+		if (nbytes && req->continuous) {
+			if (controller_is_buggy)
+				*controller_is_buggy = true;
 			return -EIO;
+		}
 	}
 
 	if (req->datalen)
@@ -646,7 +650,7 @@ int spinand_read_page(struct spinand_device *spinand,
 
 	spinand_ondie_ecc_save_status(nand, status);
 
-	ret = spinand_read_from_cache_op(spinand, req);
+	ret = spinand_read_from_cache_op(spinand, req, NULL);
 	if (ret)
 		return ret;
 
@@ -770,7 +774,8 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
 
 static int spinand_mtd_continuous_page_read(struct mtd_info *mtd, loff_t from,
 					    struct mtd_oob_ops *ops,
-					    unsigned int *max_bitflips)
+					    unsigned int *max_bitflips,
+					    bool *controller_is_buggy)
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
@@ -808,7 +813,7 @@ static int spinand_mtd_continuous_page_read(struct mtd_info *mtd, loff_t from,
 		if (ret < 0)
 			goto end_cont_read;
 
-		ret = spinand_read_from_cache_op(spinand, &iter.req);
+		ret = spinand_read_from_cache_op(spinand, &iter.req, controller_is_buggy);
 		if (ret)
 			goto end_cont_read;
 
@@ -892,6 +897,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct mtd_ecc_stats old_stats;
+	bool controller_is_buggy = false;
 	unsigned int max_bitflips = 0;
 	int ret;
 
@@ -899,10 +905,25 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
 	old_stats = mtd->ecc_stats;
 
-	if (spinand_use_cont_read(mtd, from, ops))
-		ret = spinand_mtd_continuous_page_read(mtd, from, ops, &max_bitflips);
-	else
-		ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
+	if (spinand_use_cont_read(mtd, from, ops)) {
+		ret = spinand_mtd_continuous_page_read(mtd, from, ops,
+						       &max_bitflips,
+						       &controller_is_buggy);
+		if (controller_is_buggy) {
+			/*
+			 * Some spi controllers may not support reading up to
+			 * erase block size. They will read less data than
+			 * expected. If this happen disable continuous mode
+			 * and repeat reading in normal mode.
+			 */
+			spinand->cont_read_possible = false;
+			ret = spinand_mtd_regular_page_read(mtd, from, ops,
+							    &max_bitflips);
+		}
+	} else {
+		ret = spinand_mtd_regular_page_read(mtd, from, ops,
+						    &max_bitflips);
+	}
 
 	if (ops->stats) {
 		ops->stats->uncorrectable_errors +=
-- 
2.50.1


