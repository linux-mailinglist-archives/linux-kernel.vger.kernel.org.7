Return-Path: <linux-kernel+bounces-821710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C873BB82096
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E20A3BBCA0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5753930CD8C;
	Wed, 17 Sep 2025 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="33BbvWND"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023075.outbound.protection.outlook.com [52.101.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661CF2FB989
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146056; cv=fail; b=c15QoZyQ9RHfG9/k31Yhk+cBGxpLVq+cjMiCS/E/VqOhUkxJKUgsNPSD/SFLpt9TM47jBckg/NeNgWon9aFisPhlY06ig/83Y3v3a6EjNwnIjYG21e9zB6nMLoZD7Rz52Dl8wBz9+L26yZi6j8Q9+SIGxuVvLwNgOM1Hsu7TnB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146056; c=relaxed/simple;
	bh=ocVO7n+AxflPUQnkTKufqoV/txcCrzsAKzeTEVu7qGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ozB/tomscys2tXBMcLFEuDsXd68+0v1FxfMyaVf2Q1gwnCdSIW2BDcHpUzb4ArPOlQRa93urIdyvE++/Dm+Y5Nuq/1/DFGcoPgVTueOmyUnKDX/4jEmjQ/hY7ArPARM8QZuqnHmchMZ1tUvNDYvbVMoEe/6+4OyBo8BRftAoiF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=33BbvWND; arc=fail smtp.client-ip=52.101.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRGJ+UKaqpGk8FfrbxQVj0HAzY3CilzSrw/BWeOdWfXXG4Qpl04QtdYA8Rkj3ie7lXeRTaX7q8FGbB7xb4hJjlyiQ78JLEBpTTr+n9OvxKv8vIhLrNIE+XgfnCMhYP+5lCjKQ8NC5e3qrtFNK7ySbgFwdd4M51jGqWmWcvCTBkO7lZEotbaHxONEORuigtndlXlBRBjv9oE8NDnXr3ClA1mWxvIBLXU/YqFD3qwWCeNQ2CgUwIaa2H2xy8F+Mg5d44je0HRv1X9EsfxE57wDKOcjxyP4TXsR54cs2cp9U/EUiav88IZBMZO1vICecCRaXkD9lJ1bC+qvMwLRNJzFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wObwak4G9XdrQWt8Qdyb2/NUc/ZXpsAlNvJR2C67iUY=;
 b=mel7P4wiJEpmpxZ+fD9lkmRAKx1Jfg7+gfZ+/FfEjQBMX/JJRHt6j/PozSV/3C0Y+1uf2H5aRaG7p8zGgLwCDyoy0t+fUHlg/DhAYN+6yk0+gcGxE1itYHeB5UOE75Awe37BEpji/PIIMKxmXt2BHrD1rETPK7ZCRQySbSCrJRY/Wr4KF2vqTE7FBxxiZ4QXpF43QoUvWupWI2StKH96OQ8F5ckrPXLQ+dI4HbUML65etH/Qg2mpfaKwmLdyJgS3BMulknxQ8+m7MDdVSBgcV69CjWH4QqmM5RIpmVuxeT6Z2etD8OOuBeL7bAAfZqKnWYKsp6nvNosyqFiYa06SdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wObwak4G9XdrQWt8Qdyb2/NUc/ZXpsAlNvJR2C67iUY=;
 b=33BbvWNDrc0mfX6dI4FzQI9RpEuRqvHNfH6iUB6k/I4LtYy9zZMvwoazjr2Le75expN6evHqn98xWH6Nk/jcsJ1ShQBUZB/s17uzHXwzGTZgIN3HJXqlpCzNF5kDSY4kQe7vMeURiyktFbzeWwk+2h28nVouW0vlPkAdhgw4ryV1lsShfaZeMDDT3YxPGMobUlnuZAWRnqwSYlxyAtpdEE9ejSVdJhQbO1UvhoyXkDJQmObs2a3J1Ce9LOGZc6O4F3FyllfyUR2y+uHNyrthuEUondeJjslZEOf+RwPArKvRJrpBq6ByfmJ3VBwe6lMp8misfnV8msQSSWQKaW0mdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6322.eurprd08.prod.outlook.com (2603:10a6:20b:361::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:54:10 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 21:54:10 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v5 1/3] mtd: spinand: fix direct mapping creation sizes
Date: Thu, 18 Sep 2025 00:53:59 +0300
Message-ID: <20250917215401.19132-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917215401.19132-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250917215401.19132-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0001A043.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::488) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: d441fbe8-8ca8-4269-63f4-08ddf634bb57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IEJ3W+OSQlscBfFbu7HPunl7Px1rNd5N0+xEFga/hTLE4i0XmTBuE1XUDfSH?=
 =?us-ascii?Q?KqCRF/zldzyb/QBfBxLpPvAwAOcsKhQISrfKiFclhuQQ0JmR/TmUoCXQ/J4/?=
 =?us-ascii?Q?ZXHcrK2PdD0YTcEAGzxYIuDtz3kazlD+JSEdKMK7+mlBfUTwFlSr0fU+98og?=
 =?us-ascii?Q?td65E/K+EsdaSO6x3FVt8q5C00j83Wd8S8Yl0/4QIQ3hrzamFEwiIGUUpJ6v?=
 =?us-ascii?Q?iob0Ea/aWED+/galT14eg+GMvB5AXSc61ZAr5Po8K07vKlUv+cfyFRLGpAil?=
 =?us-ascii?Q?TGJh5gzUOT7z7LXcX2eA3bk5YZRPUlhwCgC1or+E4BI452t+JECs8G0Rhzqe?=
 =?us-ascii?Q?+MS1h1Jl5z0DApq4K97PHVM4xaCLwuql6drxOK8JUQduZc3tq4QejMcErjhF?=
 =?us-ascii?Q?maVsR6cO/j+MfYeX9Pz9wgqlwbxI2YA/HHeeMW+egGV5jV02fi734ORvkIQf?=
 =?us-ascii?Q?tCjHpDgH3csoKDskMKvJygPnxY8pn666FI2fEl1h+nS8u7vQfm12H3JmaiG6?=
 =?us-ascii?Q?VRvZYj380EzOyWRTHbpxxjJwefDeuU+Czbt9EZtMc/gZb2m1W+A5DsMm+FOU?=
 =?us-ascii?Q?7P5HwU2e7WtamNRggv+jsGAKfckSwM2usgpD5cf9UOSHaBP0JSChv+UYix9Z?=
 =?us-ascii?Q?lAmYxyvv4iJJvIJR2HQuBkqO+42Q/ZqrAZd5c/X4sYlbTZnE63PRsv2bo6+H?=
 =?us-ascii?Q?W0ufdNzjoOAP1rlKHM4WdzZASug6opcLoYxMfRAskXZtVrzn0+Iv/va3oIY8?=
 =?us-ascii?Q?LjQhxsP8wzk0Os/svUZTGmMOOgodg3GQftjkQQ8MYNuyjTymM/YtY5yAeCTC?=
 =?us-ascii?Q?XPWZvhba93/OEtYcw+72MwRB6PD5F8F7zMOKQYqtg5lNet8BhQowFsSCfJI5?=
 =?us-ascii?Q?Tts684gpUFJrwHFyNxmWu8rVkhxLJOFrSLz1VFZzHOGks2fdZGHVap0wYqPy?=
 =?us-ascii?Q?Cw7WGEcuKMmOnPeq6+IIxxP+ryyPFEAl11MjRfjaqXXx6ucoD1E6B48bL/v6?=
 =?us-ascii?Q?WlsSMxk8F3SD9iitlJGyfCYNN/9vjl22zvtsw1IwzgBj0p3VcVHhR78QbxQm?=
 =?us-ascii?Q?uJMWx7JA/iNW4CKGI5UPBoG/YCLDKRYoG6ZIY4ZvMpfJS865P4u2M9HgBuIp?=
 =?us-ascii?Q?+yMxyQbzbQoSjJj3f9DF8VD9lHt4SmlN/kmszn4gbwkrZrTJLlh/2SzXBJpJ?=
 =?us-ascii?Q?QnwXtRZvumaJSiIAqvN6Iux+nS5GxLCKTyjV0jQBjcc/3BPNvdJotNTnO7xZ?=
 =?us-ascii?Q?Tb0mzdwDK+C/xEyZigjDAzLvi99Ie8KZ8zVCkUbxBqtzKrtv9FYPvZqa4Y2t?=
 =?us-ascii?Q?PBZrnfkY8mW9VHFOb2DTXHqITeqoEgOr4Sd3aMiPpHToKootbwAQskrW32Of?=
 =?us-ascii?Q?f8i4dmmQ6+QvbLTvwMIQmyP5buPC/dQubGns6aY2asVmF+AL9QynmVVBOZor?=
 =?us-ascii?Q?nIsD49gdYD54NiSO4n/y4/bUDxRBumddjzf/emnoozd8OMxia0rsSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NbQdPDeSGl0V39th6XpZawG2z+cL5JPo97B3elhaVfZZXgwvLDERVRwob2L9?=
 =?us-ascii?Q?bdor1Vtv6FkTA7N9QnQ3z1FtfqQfWO5h+zuV1DMTUImOc5p7tDsFIv9ghvgV?=
 =?us-ascii?Q?oBYMIC4mAe8rdtXoNkqiV0j1n4aYYKoaJ4utnXYEFtvjRjUpuaxWaiyVCjzM?=
 =?us-ascii?Q?T13oJ/mnR/X6yyOMppquMYl+4wPsnKrZa3D7SVnQtlWboALUKqwL5umNbaG9?=
 =?us-ascii?Q?1qC0kJhRwOfcIVq38lochnjICjY02crISgYw7SiYvrxod3z1Gys1pRT0QxlD?=
 =?us-ascii?Q?dBDc2GA276kPDRH+BF6ftkYIit+M5MHKY8z/0hRdvU4r4uLjH3m60gYHniS0?=
 =?us-ascii?Q?BV5SRLYbVi2muDtSVbWDKhpYNmNz0QXMN6SGvX1apQ+mB2z+9yLEDnL2zE6U?=
 =?us-ascii?Q?Dmtfxt9vHNpapw6gVOTHx5HTT6r+t5dABCLeKz87uAy2SFCqgp+FKgUYQImp?=
 =?us-ascii?Q?bPmIrYd6La5m+TWQMFhQ3bfX34decWUKBE3WG0uC4kf68DASKbXp6uSa3vJ/?=
 =?us-ascii?Q?aMIRy5JcBytNIfAQQcJ8asMaBtsQdQBZWmMNg+bDbAVe63/Y7i787TguQliz?=
 =?us-ascii?Q?sZyOe0W8HvUCWewANKbW0y8/Wrj6l2rW9KwpAW3Dsee1sd6mcB52Xck3X/bD?=
 =?us-ascii?Q?Lr0GMVa3UnOYVqBT81ggx6tuP/4marjjqFmre89HmZ44e4cyjIu8Oqtcgy9+?=
 =?us-ascii?Q?UHdvv+UiPHHCUMsdbq/mr0DNXTt/UkgTxWxaOwEg9vQhGKuYO9DPfHwAzBUu?=
 =?us-ascii?Q?ZQy9KGig+3hJw6ZU+XwonWpMUCXfyspijlzDFgqAVUjWJIXmdvb2U77vtKzf?=
 =?us-ascii?Q?s8R9980fhZkmt+EVUu6MjIKMmzFwaZD3dFO8KZ29zglMoPslcUbNHYX/xD75?=
 =?us-ascii?Q?mZIpznBttITknHD9YtmokAxAexzTFAwfSatTTN7+qGk1cHpRENJXYZA7ytmD?=
 =?us-ascii?Q?SsBncEqDFgsXmiMMJm8jtoQ/7UGbyrRsw5mWHDvHaE61CLFUX3wpE15qQsI7?=
 =?us-ascii?Q?XP3C9pxLzijQ2BH2SIy3gabbiKvWdbJrB3deU2XQisd6ldce5lfLxK2a9gCN?=
 =?us-ascii?Q?GD0J8T9k5Sn3TXevhz5XA602Y6o2734DiwmebFQeoMd6wH/y/aSuOpNhJsAA?=
 =?us-ascii?Q?3NbCY9Le7f95AdtE62jK2K3RcuLyO1nS0O0K2Q0Iyac6ToFYj9Mnos9NPhkd?=
 =?us-ascii?Q?Bsi3uk3gWBXFKtXJmYYdPeH8yfuhOGgseOKf2KMd5r182vAh+vDmiSSGKat5?=
 =?us-ascii?Q?WrXj1yXKxNjoFbe+FX8uIi4xS6IuIU+AQjp4YFps0IkBcsCoqBdVCznLxWjG?=
 =?us-ascii?Q?NRtng4nl1IXkEs/1FXhWDQIIuqO68dAMdZro+J7BR0PGaS1JwdsIQsfY5uzd?=
 =?us-ascii?Q?nmcqWllpIgyumNd5PyJkDBCXiyVXIpCmtj1X6h91/sdjvROeYxcxVTT3LyCa?=
 =?us-ascii?Q?vZPa2oZiG4Y9O5MZZuGod6J2sQ+WI8UccIU43miJURZAyoKTQT1A7vlQk4BK?=
 =?us-ascii?Q?M3NRfzTDHYEz65+UbKcp+Ua+oMvD4dSG8jxcCsVk6ZBCOQcbN61RY1vdwtRZ?=
 =?us-ascii?Q?jKU4PJYq+yhkDi9uwyDfQgKWOdXpuFNpSLAE9OjcJHrUdHXV6rjNBEgGPRGh?=
 =?us-ascii?Q?BZSoKn7Jwa6+eEFGS8gxnoI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d441fbe8-8ca8-4269-63f4-08ddf634bb57
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:54:10.0003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RaGwTchct1r3abcjr8tUvV0oSDrwMrZPJO59jm0v/vwecHT6I9u9TKcRMWUfp54xais+5bSmPIiAiKupL0gyW/lbScYrfHEMSxM3aC2eOfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6322

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
2.51.0


