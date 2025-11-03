Return-Path: <linux-kernel+bounces-882148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B99FC29C12
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 02:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CFF188FE53
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 01:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9412652A2;
	Mon,  3 Nov 2025 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Vc4RjCX+"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023080.outbound.protection.outlook.com [52.101.83.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B9157493
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762131722; cv=fail; b=Xu7qIhYjMAmpg7qIRqMfytiAAneslN6g2Djai/3h2j6Rnkdr+Ck2HhQ3sEYJkDnpUCwarL9bxYS64ylEOn4bUsrPeKYt6kKlq1hAsEGtMBw+JDmsxalwzQ6UFpQVB5kfDhDWAkCc2m1zIUZA2xBNUiy+fUPTmxH+DgW7yFtc7MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762131722; c=relaxed/simple;
	bh=gowYpn+6zPPOIvmrJqNTGY9IsSyCxFzQME2kzXoRvdE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GnWxC588ihRCpcX/s2AJxAOCibuJCrkx0jONMhwZ7yaRn5Skj15y1BY2KUCA/75qUjfaACMpP0VEHCnHvafeAu/2cfJT9hVKgA2iAVw/FNISaaPRozUiCajtD4d3HWB/yiiepVP5/ZrPYAx1jBdBVj+aCJdc4c7AO17kFRy8zOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Vc4RjCX+; arc=fail smtp.client-ip=52.101.83.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8p9U56XyEm3NRaivPuciHIhxxl3ENXLVq0UzQt9U1foiDPCzbv7yerDkNIHyBAOCRfJEB6mhWKoeuXd6ha0RQOHdgrmodcvfgyyd2n4a6m0Qfc1N43/ei6zvudAItsPFMiNdJLDpeD5NicarCTiBvoDaeaj/tNzTcoz93vmoc2NE2aDCFY8nZXe7w3jUuRQJJS11mWVIlLI/jR9Rnb209qObRm+BMCwGp+lnRNo1SPr/q6bx04ctXx9KFJLpPkfponoc5o78m+bVsCWZ2frtA7NAoZiMAnVCfTLoVCGbZagttSXumdTVkX3CyAKcNH6nc0xkuHImFu6QlFpBXUkFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GaFjw+NJXzjeDMbfmbpglnj8O4f6WzHKqyWAibLSPeA=;
 b=fQZrZDLqOAnjASfn1ZTGJ2gjHlKSBoLFlD7aqHfUYNgoFG0nGmJxYxGyCiW060liYx9jh/SUUCLnArG0orY+04FRinQELj1qhDepyyOPb2PhSpk9ddAuOXHKVgX++TzELrrPxPLUjiQx8zjMIse26Ym7jv8+ZEndTB2p5J1Kz7IqfqNJiVZ0NTS0/uUJq/OX1K6li4tpa0wWovfW2pkkuBp3xAJnn3jneFrtniZpmmRRs0ilNHEAPykyFpF07BW+pS2xxvKgTa6r9ekditKOyXfHYgVrb2UpHFuWqgDreK/ieAvmCCLbBof2sl5O9OWy2A8o6exOO+2NwOCgM+IOhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaFjw+NJXzjeDMbfmbpglnj8O4f6WzHKqyWAibLSPeA=;
 b=Vc4RjCX+23QpVQDFRWsSDjCKt5ICGcCdFqbEXv9nHEVGQES/NttiD9cKJfViaTcTU3c711P/3HMVg9kLhmSNFU1mNBJHXalqhC4XHNNt91u6Tv0KUmFviW08ZNyeqb+lyMA7WhkUjv8JEuAZM7pK4xyvFoXYkm7CZAchj3vnbI5TJQcy5lBhDp4TvxmR9oWgGFJJ5NUhRuqpffX7wWCFKGmNgHof6PababgVSSZJ7dHiMAsVdMVb9kYbF5l3v2z779dq0QQuOJFF4w38UsCBoOnT7tNFlL3OIPLa4/7keOu3OzVBNieFoUmXFia0jDAhTPs8FwGzY7u6YZfwKXj2fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com (2603:10a6:10:384::19)
 by AS8PR08MB6183.eurprd08.prod.outlook.com (2603:10a6:20b:29e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 01:01:56 +0000
Received: from DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f]) by DB4PR08MB8125.eurprd08.prod.outlook.com
 ([fe80::e9de:ca06:dae1:ef2f%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 01:01:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tianling Shen <cnsztl@gmail.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH] mtd: spinand: fmsh: remove QE bit for FM25S01A flash
Date: Mon,  3 Nov 2025 04:01:48 +0300
Message-ID: <20251103010148.3855648-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004537.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::349) To DB4PR08MB8125.eurprd08.prod.outlook.com
 (2603:10a6:10:384::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR08MB8125:EE_|AS8PR08MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 11491559-167c-4067-3820-08de1a7495d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NoPWH6TVo0jAQbs4L40N7MMcFf1NsrX+nif5NX8Qm8WxUIrW+5GWVhaY8Cn6?=
 =?us-ascii?Q?6oxelV5UBVB0HzDQlmi8QaoCF1PEm3hxOTIl/ZVjFtoU8YFNwuyP5wrjBl+2?=
 =?us-ascii?Q?MiXbSrqHySfa9r1hJ+xMvmNKVlKO8A3NftXM8KZd79fmpU/nQ1aYUfCsL4Ib?=
 =?us-ascii?Q?FVf6kEmpW0Zmd2BeI9bnSvM0Fv2Dm4iAvQtEes4mcfiBazai9d4O0ccW6mxX?=
 =?us-ascii?Q?7bQtrwJ5BLQTBfNCuV4gJxDSo0YcuE0zXripW1wqw1VTgRqiKwvSgYzDPoCO?=
 =?us-ascii?Q?rCPAHDWKMhnQlCibSbDmsN52pIOigAUnBEgJQ4tPc5XhVh6RMmnxkTnKmGll?=
 =?us-ascii?Q?gc/8cCqiRQRfWvjUSk+/NE/8D2CJ3LT18tLfZeTSzG8SDpUryTUWGCeZQEdP?=
 =?us-ascii?Q?0+y1zAsydjavJqzkZC16gadcfNgr3rjmNnhaKOjaRPMbkOLtZEcaTB2NK8VY?=
 =?us-ascii?Q?VHaRBF55qKYzgX1G0U8XG8+KzeqPpY4Z3mUwxvfboPgbpWe9UyHeu+ff7hsv?=
 =?us-ascii?Q?4F+EkE7fpJWIV2EEeii0W8ciRKtIVBjAFigqS/ZHNhawyXiS2HNZWqNpE6OF?=
 =?us-ascii?Q?0AeEVw04bjcpY8JWlXCtuCy/VFaB1c6rSPe8S9e2nf3rUDTuaBPX1rh9gB/Z?=
 =?us-ascii?Q?vkfJzzTlRgmzez0y+JpFVRA+wmEJ40jCiP17bF8y8KtIShWnC+VfZfmvYJuw?=
 =?us-ascii?Q?9ye213EA5WJ5TvlGi8kV4Dd4P+kVgbY3lMAAQCRjYCZGEQ+NhNHEsW76UgHq?=
 =?us-ascii?Q?I0P7XU/g5VEOqfuKUHXGL90kS9a7HDxYdbddh3IKoDQxv3ecOr7R0OCVdSC0?=
 =?us-ascii?Q?VzWtjiE7G4Sq/sX61yF2i7ssB6nZ6aafjsq+tlZpUhDHPTUwQFkQ48uY0NXa?=
 =?us-ascii?Q?bCTcogcW6nHCsO6KnReM1SfWuukdRtqyuMGU4vKOxt93B5a+oDIPCl6dKkGK?=
 =?us-ascii?Q?vzQ4JZrGQPeTB+DuCnlEyrSrpOuHfY44r74oyA+eSfPBNWbkpDVtVCgF6w4p?=
 =?us-ascii?Q?VVqTonbBdiwbmUHawKRUEksdyXHeeTaEKuliWMpBpupwWXVJGzArRx+Ckomt?=
 =?us-ascii?Q?L9t9Kwi/y8J9bsUTWZhSbXJjxIvRykCGKArPFJzYtYR3dGP/IteLjR6Ufrim?=
 =?us-ascii?Q?YNQBi/imsjvSdWGLVslfVqM2cK1fiJwICrxImb/qIgTtM+Qv08NAaBdUFvyl?=
 =?us-ascii?Q?pL4ufHNYH5ysLLu+1kVPNXSeRzgDzl5/lIjwullcaft1n4nPnkPzaxHTw8Da?=
 =?us-ascii?Q?eiuNDsp1jf9GDOoloVHxyDPW98aj8PXuLttY2dLQZKfKqMYyrvSGkhEtBhGP?=
 =?us-ascii?Q?i28NAJiBO+teVctkxsHe9ygVUtOOjZuIj1yRSlho0JIUnntEZUmnL1/s2moc?=
 =?us-ascii?Q?GPb39R/DSAkAJhM++LCLVfED+KXhTXZWSKj2iKeZOag1La5BHrqIUMuF47Um?=
 =?us-ascii?Q?SW7/M0d7DDRUJBRivPdAqZr1vRqyPjiT141ExWAB/5U22ybXD71PMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR08MB8125.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i2zcqy4BouWqKwziAeYk0fGKyEWOBsdf/vZ1ho67FBKX5D6aQq1eigTKkmIJ?=
 =?us-ascii?Q?3MoSaR1kM9SvnBlmj9cGU16VDI8FlRPsVIHbDNluMv9NmTZFI9rL38Zt2qey?=
 =?us-ascii?Q?sm2LGAKhj/PIVVKNbYhymrdmjmXBYPh/YENvUVzeBDkEmUl/a1sOdet3fJgK?=
 =?us-ascii?Q?xhnBb2JwsnbZ9+gg/fFQYu00UrE0yTSAOGRcXQ7bw6m1ceJzkLP4jVGBpz1S?=
 =?us-ascii?Q?DOgFWUWhIjBUJnTixg4F8ajhT0lkcFno18Hxo2/QE+/8NNIgdauqKvkzwLJY?=
 =?us-ascii?Q?lf7cSdY4XrkN0pv9h9ONCjV7OSuIFtY+Ae4rpr+hiQe383k2uXb79nfpBuJf?=
 =?us-ascii?Q?1gm7UbE48cwJPPK1P22CdzUjalmN1wy03JWhCePs4W8kv3vFMRPCEdy3xPGP?=
 =?us-ascii?Q?OrETnU5U1/3YOmXFj8PRKZuyrDtaiEkrXqUWhAqUOkDbE5JYfnhRApelXo7U?=
 =?us-ascii?Q?+V06mbowPgztfpoaT8d+LIyrMn+89MZu7XRevI/DacLhkZ1eVK4jwbbZO81F?=
 =?us-ascii?Q?BENNdRjILYZPKSz5PdmyIJZY3NW+sQvbn0qVjpGnTtshgSW2w6m5kjOijYGz?=
 =?us-ascii?Q?mKw0WlLpylLNjZ6EKD+rR8oXnYtkgZL1hOLrUlLRLY81wNHo9hIqY3rOvT5T?=
 =?us-ascii?Q?DF4/PtYsziHFSlNLGlvOQ9skp3WA2CrMSQSVPR4ucluswFk8sjWirNETO5DD?=
 =?us-ascii?Q?W0LwLVKAHfvm+CeJuyxegvdeW3zJGREP7tq0WLqxKlS/p8tnsTrMAgXALTE7?=
 =?us-ascii?Q?80qdV4jx2QzDm1fp5f60FNGdipGP76H2VkR52hrFgceXFIOrqxzhKWpjRfum?=
 =?us-ascii?Q?3huFdrm9ErjjbRanct/8eMl5FXBJZslpnrFs09gmaf1CR9I2plFeHjR057ny?=
 =?us-ascii?Q?y86zb2FFW7eKKwzPP2pjBNYlo2us6oXU2rTpstKuj/SdJ6p54SA8839rZIFa?=
 =?us-ascii?Q?qTU60cPyBzQI4oXsG4GKx/w6xh7w5gMwtkmH5bZNRDfF5r8dB4kolwE3VeJV?=
 =?us-ascii?Q?OVtsya3cHBfT5B974uYZCL5zDxrDiuR9bTQI4h3NXlbxLVmuL3cdZzy6CA7k?=
 =?us-ascii?Q?lbpEuFAid68daA7C9jitLhvQmBgC+k9Pk1nSYPsWDd5Kz+0X/wYGw0jR8BH0?=
 =?us-ascii?Q?L6H7jmfzFtBMZKh1tn0778GTwVNBHB2ESL5Ot3sFSBSguoe0vLyNEDAsUCAu?=
 =?us-ascii?Q?/crt+SEA3jTwWzYYcas7tN1Q3aJnPP1W5vMjaz7nZm65DUNg9Ei51gRzog4w?=
 =?us-ascii?Q?+7mcBs0OL34utR2YhMSyplpt4XklCJFGWZ0VWfqnKvww5fw5ZkZUF10UL/8i?=
 =?us-ascii?Q?6lDf4QOhZbAJEb5NPD8hxKngFD115hGnzrlAiDQ1tSP6AkGbV69tvDc2hrNN?=
 =?us-ascii?Q?FkwzGBGWhzvpBQrchziWVo5gJ5EEM7zg3C/s90u8kktl/+o3kcIieOYyd2NG?=
 =?us-ascii?Q?dTzahK/Dne3IcCY+u9tePYFxnLUaz1HvYhZLB6JOhrTBU9PGCtRKSMYa6oOi?=
 =?us-ascii?Q?5iuv1CGg044bWNIG5HtxtGBiLYEsLZA+7W4GIsDfOhEJZiMwNgxSElSBkJpf?=
 =?us-ascii?Q?kTAWjc/zU2l35BJEjuFlAsydx0O58gaK/l/a92/vpDM4H5+5VmDSD2Y8NOg4?=
 =?us-ascii?Q?9uH5cBBo244WA1yaFATZP9o=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 11491559-167c-4067-3820-08de1a7495d1
X-MS-Exchange-CrossTenant-AuthSource: DB4PR08MB8125.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 01:01:56.7182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKtgxRAXz/jV77z/inYzs+dL7hjafOeCUA7rU17jjXziVOlDIp8c61mD6yNZxrCSj7hYHLrt4aVnPSxwSEQYozvLAcE0StAj2VzAb5wfONg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6183

According to datasheet (http://eng.fmsh.com/nvm/FM25S01A_ds_eng.pdf)
there is no QE (Quad Enable) bit for FM25S01A flash, so remove it.

Fixes: 5f284dc15ca86 ("mtd: spinand: add support for FudanMicro FM25S01A")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/fmsh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/fmsh.c b/drivers/mtd/nand/spi/fmsh.c
index 8b2097bfc771..c2b9a8c113cb 100644
--- a/drivers/mtd/nand/spi/fmsh.c
+++ b/drivers/mtd/nand/spi/fmsh.c
@@ -58,7 +58,7 @@ static const struct spinand_info fmsh_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
 					      &update_cache_variants),
-		     SPINAND_HAS_QE_BIT,
+		     0,
 		     SPINAND_ECCINFO(&fm25s01a_ooblayout, NULL)),
 };
 
-- 
2.51.0


