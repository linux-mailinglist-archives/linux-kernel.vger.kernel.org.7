Return-Path: <linux-kernel+bounces-821712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BC9B8209C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAA51C20988
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2707630C10A;
	Wed, 17 Sep 2025 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Kv9i7dpg"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023075.outbound.protection.outlook.com [52.101.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDB129BDBC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146061; cv=fail; b=Q9wTRA4NN5JgxnrtieZNX0aEnlSCJYJHKL59/aOXjjdx+1ZJIgZHgoHG/U2hDujzhvBo5ZoES7A6hThycRZfqhwjF/vncmIN6clqY3kK04YNPN0YEoqZLEHK1ZPjooKMQm+iSAopGlFLv4qx2jTN3jTXpz/78EOam8gxXVnAlfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146061; c=relaxed/simple;
	bh=yT2Xg92eZjLo9+fJBO1jDd0C18YybAzWr/zs6c/2zLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WUFQi5nUjmYfkPXRW57RQmTFfV8SqyRuGFrLkqWSne2T4Jzd4U48HTtblGP4kJgB2qhLCRcbK7Z19odvtn+WILaD/gNadvkk5ViIfuUVJ+n/12GhMQ0LOP20/2Qg5rixqWnrasv8xens4inXVh/o5uGqgIDzEeb0O1HH5D6d768=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Kv9i7dpg; arc=fail smtp.client-ip=52.101.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ig6Y6JN+zT9lMOKhoV0o+eBs44FI3wlQOU+x+0vIme0irM9ubN6x0f0583ANB0li2wZYYmjQsbVJbr1AXIz0H3KSF9qJcLzJ0tFSW//2PrruCUmTkpHuT7bEDJLHXGIlwjXnPzPQ+YF09h8YcXo8on+fewefHkLU1566Vrbi2VnPpZ2PlWdGiaiSE+Uh2qPsWLV+BBALVt2mPNJM/zviKm/fiSWeKw3AZBQULVqTE7baTZrkhJYdmLeTw8QvIKyxo80EMJu9lf8KHRK0yPHd6tQptR5GVxcJu5N+vJxO4hQi7whbVVna60MBL1Ke3J/BOzI/EHB3r+TEj+I3wGufQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9ZYiPrLKfOXt3R8TtsBDbcnp8kOOOVaBqINP9TEutc=;
 b=a97RgYp5IfBxWrcvjFnp2PEQ/JtSoQIc80NSzn+p/GNx5v357tPsadRxirjzWM6a1pFFoLn+BH2mgYjJuNIbofYjalOwMNRq1FzaAhLQHZ5nDqxrtWu5VPYG8eaIaWO8Np0zLY0L3yAqVr2zAvrKhcfsUqJmh0YMDhmARQKbRpmbnCopxyPqakC7QDb2WwA0b2JCVJjtEH6OR9jXSgYh6Mhr9bP3orGptMMAXtqtDOK2ZiuFmz3yBu4mqT/eiiH+c+bFOp+3YvTIrYi+wyhsvxX03H3qQemk/iuiyCu2dw9D/KlUXkXK6qgLsQSsGrDyT4sq4rMqANo9cPKCrh5SmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9ZYiPrLKfOXt3R8TtsBDbcnp8kOOOVaBqINP9TEutc=;
 b=Kv9i7dpgyF3MF5MHPn4VFCh3r42K+wSdFNSriN6PdPSJ89NyP8w/E77L50AAnZfK3CBA7gUAWBYrg9z/wqDmvXMZzsl1mhSfGd5m7qVpB6tPu7Xw/9W1HMBWNnlN6ONHFne6DxRlNBv65Yiz/NW8CAfLiiWjXNUXx8fpsh50GFBKL8zocuOwUBFMeNrHNKh4cPc29VrrYu+7k7MEKTfRxINGWjEppfZ+kxdLFLTOo3P4H/5tFdGsSz5i9Qjh1f2nmwDjJzeMmD/2NfGJ/ihH8RBdtGkIaC60egWA/dTuTAwqDdFwYVPncJobeuu10U4JC/mFJDdMCPgrV4rHWbD8bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6322.eurprd08.prod.outlook.com (2603:10a6:20b:361::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:54:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 21:54:12 +0000
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
Subject: [PATCH RESEND v5 3/3] mtd: spinand: repeat reading in regular mode if continuous reading fails
Date: Thu, 18 Sep 2025 00:54:01 +0300
Message-ID: <20250917215401.19132-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 7180c28b-1be4-489c-8232-08ddf634bcac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5xGDeD66QBKKR4bIMtQFQL0sms6CSpXHHNQPHc8iKS8DQee+/bBk26FTI+69?=
 =?us-ascii?Q?cIncKz8j4GllS386K+lQsi3BfFLn+QqC+10sAdoT6Vt0H0j4SAX+Z9cKdbu5?=
 =?us-ascii?Q?H2SL1wdZRgMBJ4iuFqIQnZWJCPiu922fknepOjwskUGMZUN9jHdzW4XRite/?=
 =?us-ascii?Q?ybrsPRjHsCKGFDb/nQP97cCbYunDsNgTNrzLDKssHWxck5Q0eaNVOq/3Mnzr?=
 =?us-ascii?Q?AvnTGNKqDtDXBPUsDssNIzUIINPYtvS0wOBnJRBiYEJ6G0AzwY8DmRDxY/+b?=
 =?us-ascii?Q?95QZCt2ltqcRmh954wV3FQRy/rcI3WgHUMdc92ls7+JrGAJKTgx0EGAtY+O2?=
 =?us-ascii?Q?P/Sw/80oT1BShJseiI595dVvWcBIp07UU2GKEevL9sJ8NQzLL+eEOcEzWa9N?=
 =?us-ascii?Q?fUq7zSOHH7CKY4Qh4AXQ3jumD0tfYT+iQVKOT7ifTMy7rOMX9SJNGxmQcLL7?=
 =?us-ascii?Q?swnTT1ckcu8fwAe+jrwOWbPqWo2LL1rNbrzqlAlpZxSZ45yO7Fr83Xayml5r?=
 =?us-ascii?Q?ZeVNq77PRgvpgNOOkiQ7vWlVTlByYLoZN5Zvm7rqR+PiJFT28UDN0h8BU3aE?=
 =?us-ascii?Q?/i3rLF0mfYPTfhe1PPL72D6xDalcA7tx5p1CPbOLfwERd8aqBKPm2QJbhmNX?=
 =?us-ascii?Q?tI8B5eytMd0lNDxzFlXP9PvLFPCLV8VmXRb+vRdbuk7yiODvNBmlxJUqc2U0?=
 =?us-ascii?Q?tPJw9l+sF4G67rA2Q9iD3vaTXbSSmx7e3ba84HkneQ/wJAjfospXfg2br5KM?=
 =?us-ascii?Q?jXTxyyH2oZfBiaf4C/MRaLUD/O7lxHV0MBFPBJqNc/u7L7l9grquFUbiNgxr?=
 =?us-ascii?Q?/OvZQ+ewfr6UZGtJq2cPCe09uWZOsBQnWSGEaCCCpotFXMAmHdDvVy19C/xn?=
 =?us-ascii?Q?+/mHU0XH05S8rBED8F/IwmtOczNAiVYbVuHWi5VDgQUy/A6jG716Oni4VX4E?=
 =?us-ascii?Q?XHmA3JuyFQeG4XZN7LJeWjvP7i70yXh+SBPeHNvk4dhKzHav4g/2AZwqjhj6?=
 =?us-ascii?Q?a3VioK2XdQG7KatZSTTuc4BVarouUrHZs1rlKWdr0v9JJbhNNzxb/GVI1q1i?=
 =?us-ascii?Q?z/F6Q6rAhF5pOe5kqPJwkER7TNEcYbE1o4/eH6zA5LeckIbubbu9d/9YGUSS?=
 =?us-ascii?Q?wcLOYARbxXKMHbcvFLmhIsK+3+JiTwNWnl0Oow1L3RtzFNsmpkuntrAm5zy7?=
 =?us-ascii?Q?v7xn0i3UjvOH9lfbiMNBWbECGHuTy+f/mvSn/6Hh8VjM7FbsaaQ7JljeuwFY?=
 =?us-ascii?Q?HBciMbS8jx34YDMvqQ663+IdXspO1R1NbHA+K+nsrIa/eV+r8QGSxxhlzLI/?=
 =?us-ascii?Q?zD51IeO8qP3D7/fpdJNC7VlOm1CHM5+LXhD4aLLlN83cl4Hhq6vsVdp3BUQG?=
 =?us-ascii?Q?UsNLYZo7v895DTb4zIszro8V46eJoEOTmvbnV6xL7nyjXl4F62Ef6FqsoGKk?=
 =?us-ascii?Q?euEjpHm2lq6SWHolgiEvl4x6qUmj02VE4R1FcpSCR8FH1TjLog7Upg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aRJtUfwA6EIw0wPHNHXwacrB+KpU16RCeqHrCgGdgAnsUYi6qjnvfxP8A7E5?=
 =?us-ascii?Q?bROwFJ2QfyBT6K26eyxVL9SJCf7qayEQ++hy0Wb8t1E4cu9/jFNZzsrRE8OE?=
 =?us-ascii?Q?Ira195mYUKl82igS3LtrtDSKiVrkDUDsbtgKlUywKUczY+rQW/3ac0xaJ30p?=
 =?us-ascii?Q?NOsztgivtMz8CQSEWapt34c9PK1GB/u0TzhBwg8p2M779kl1a7brakGeVKOQ?=
 =?us-ascii?Q?888E8A4kIvy0gLPWF1m2QCp2eP7Nxe9qpc2o6pMBE7FKkh/pS0xU2Zlci4HG?=
 =?us-ascii?Q?CnHIeSQlOYzI/xb2nbvgr5pGoSCY525lUddXwRcBdxFP8q4OiD68sVw54Zi+?=
 =?us-ascii?Q?552Y+gY5kWPhjfghf+AsxZjYpoQKsnl7+PL6dBd/p7LvILV7JvMRh1bKj/4J?=
 =?us-ascii?Q?85hLRpj6CMxK/ZMndJctjEM2DaepTrIyxgegBDihBGgiFcQsN4s1Ua8TGrD7?=
 =?us-ascii?Q?+eg65y2SJZrnkbSF0dYC4WSJFsKniwU+p/LRHYXAG1Q0HePxPiVQE0Zr1CRz?=
 =?us-ascii?Q?PZZK1Aa5OtKSgy3XOyDTnVYUSuu6Mlggii1olCjuM0CH4+7IdWiBxS/g3amG?=
 =?us-ascii?Q?CWLfD2L59FSvoEn238KiuBWUBnAuQ7MfacJLEo4IReC50mmDXqf67hGiou/X?=
 =?us-ascii?Q?RoDblsW3cwxq5MSUBymPvyI20819sWk9ZPs4GwsXF7ZM5gV2W4CvlOV5TDyP?=
 =?us-ascii?Q?kD8hoZqvH2R1OW5d0TbH3tH7bttA9tkoSpcp9/EeXNf0CK9zGZI06m/2khB+?=
 =?us-ascii?Q?fQozAnNQ7pqzZZQPEQ5rajgmxajtGmNzemkdrUfVEgUT/msIXpQs1tzLCNgs?=
 =?us-ascii?Q?U8LZnhk2INBfkcTh4TTmY71sPMyvZfBObOwbYRqnev3RYAZNizGACmkt3dxI?=
 =?us-ascii?Q?bVVBlcZpFiYarEWkjQX9iGs9PVn8OT/ZrPHMpGwLNDmydAcItuwhMQF9X/MJ?=
 =?us-ascii?Q?EGkt3xj68VsFfBH+G6tRGY0SOqMeXobkiad/y3qzUZw8s96bBPC696QnCZ4H?=
 =?us-ascii?Q?siuEwpGI4BeqvNKHlNdi3TDnub9pV8D3LARPQIW18OO+NyiwG4dpFz52LYYh?=
 =?us-ascii?Q?N0EpF0mJxyllp/gu69v7mIjuLHVlu4YR+2cbvqORK3E5iTiGe5eoNDctWbaL?=
 =?us-ascii?Q?a7qIMH2A80AXBo5SjVlkcGpyC027LSTCix5LYUOkVnbGiUqRGgYdlb0Bfp5X?=
 =?us-ascii?Q?ffTzgEAU+3Z2d8jl0APyMyVcOvzPg3acSQ5J4IbDjcmBC2KmsMH/POdNrDEW?=
 =?us-ascii?Q?MzkQmx1KlIFbi7UgNE0KeS5zovckPOiR50WZcD2t2kY8oT4x7ocVKVDJqUCL?=
 =?us-ascii?Q?H0EdR6heT9g+o+5x1I2xSNxBr6FgN78TX47Gx67zM8uXBfrU7qvf+xWksGYG?=
 =?us-ascii?Q?xzgmRiSurCblWe+6MJgMQnXq/ZKBDTrMeRBj/3HFQKEjnTW0mpYINTNfdb3p?=
 =?us-ascii?Q?ngh3pHQZDhFYsO1f1y/OKY+w7e/h8Qa4nk76lpvwAtkzICXPEk8PPue4nlvl?=
 =?us-ascii?Q?SlHAd8vA1vo347raStYml775eQwjmG804avsRSkxcO7xKGzpQ54U8K/oP2Jr?=
 =?us-ascii?Q?+hYNWVLJgCX6hfWhewwG3PUPhAPyHgebK4aDJomHvVnARhGSXOtO8B/vudnM?=
 =?us-ascii?Q?GTr9TgzOWeoh+zIOH6e66v8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7180c28b-1be4-489c-8232-08ddf634bcac
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:54:12.2393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNY93YQDnZxKGl1yHBlETgxlg1aOC46hOFI2MO0M6ISmRqJiOrET4Uzi+Qt7sQXp53xqhxVcPNpFK72dupTteYK86u/eCk8CyVEyjkIL+Dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6322

Continuous reading may result in multiple flash pages reading in one
operation. Unfortunately, not all spinand controllers support such
large reading. They will read less data. Unfortunately, the operation
can't be continued.

In this case:
 * disable continuous reading on this (not good enough) spi controller
 * repeat reading in regular mode.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 02e322490110..8bbcc80aede0 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -430,8 +430,16 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		 * Dirmap accesses are allowed to toggle the CS.
 		 * Toggling the CS during a continuous read is forbidden.
 		 */
-		if (nbytes && req->continuous)
-			return -EIO;
+		if (nbytes && req->continuous) {
+			/*
+			 * Spi controller with broken support of continuous
+			 * reading was detected. Disable future use of
+			 * continuous reading and return -EAGAIN to retry
+			 * reading within regular mode.
+			 */
+			spinand->cont_read_possible = false;
+			return -EAGAIN;
+		}
 	}
 
 	if (req->datalen)
@@ -899,10 +907,19 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
 	old_stats = mtd->ecc_stats;
 
-	if (spinand_use_cont_read(mtd, from, ops))
+	if (spinand_use_cont_read(mtd, from, ops)) {
 		ret = spinand_mtd_continuous_page_read(mtd, from, ops, &max_bitflips);
-	else
+		if (ret == -EAGAIN && !spinand->cont_read_possible) {
+			/*
+			 * Spi controller with broken support of continuous
+			 * reading was detected (see spinand_read_from_cache_op()),
+			 * repeat reading in regular mode.
+			 */
+			ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
+		}
+	} else {
 		ret = spinand_mtd_regular_page_read(mtd, from, ops, &max_bitflips);
+	}
 
 	if (ops->stats) {
 		ops->stats->uncorrectable_errors +=
-- 
2.51.0


