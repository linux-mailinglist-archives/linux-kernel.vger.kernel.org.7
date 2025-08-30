Return-Path: <linux-kernel+bounces-792876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F21B3C9F3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F63C1C211D9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A01261388;
	Sat, 30 Aug 2025 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="KNckpyxY"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013009.outbound.protection.outlook.com [52.101.127.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10C224886A
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756548415; cv=fail; b=A1+gAoaIcGyTxo/h/kL3sjwzPTiiLFKmeMhMnmxlYYLKKfCq2pAq2UaD8u+OsIWH5d0fcS7/AO7n7ll5n0uHmBzx/z0dlYskOprSQ8mJutjdJ3MlIWvKL0TkJnM+t1B+As74+NNesHn5RrwhQJuQP2eC3dd05hpne98OwLteMhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756548415; c=relaxed/simple;
	bh=FqrZc/2ErgJQbAAS+bMSzDN114itKl2ZArE84Pm6rLc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CwEScerm5Ku9yConSSIbpppmY8v05fCuO0azx5VmoB13g2uXVUpjcSJqwGLPSwXL5lpSo3LB02R1Ua3CisgxkaMBs5ylSZ1s3yL+gF2E7d0NdMHG1UwbQtZ54rxJ4l8uFWg1nHXY4jETZYuKQEa/5d5KFENSznFUxIijvqRjh0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=KNckpyxY; arc=fail smtp.client-ip=52.101.127.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGSOvfjSmRnRAl5wXxmbbu2G4uUVY849fsBvel2zngZ8GqjGQUnE2XZH8E8mj3UpeQyRT5qaTOQLyphWTUe8PJaeJre9gPJ4bb0QM6WrJROhXEN3DfHJipnhxiPfLLYgwycMGHPCJltua3JCFrr4MKvCGFbSpVAF/8XkHEC5R4JeUwpAklv0aNqwJ28YpNIMzw3DwQhAIl/89SbUfgPFCZVEH7h+jOa+mBz3WMaI1DUuBjKMcdAp+SKqtINSidQVftACPAlt47lMVXJnSiUI1W1hupkZn+8BW/QH1c0NvSTagrngRu3tyenE48qowMeWFXeHmmhArGKvBJkIltuyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PurIhIw5qMQwn+YYnd3n2GMvgVWcBufyQkl55gvUoWQ=;
 b=GSPLZci5gkAfzoy/jW1nj5L6/VgHGgFRWPgTAqjuPrJtYWkAvgdMRzeuJEK/LoEsf9pptbTK2YmNWG087RGf4i4n92NXU2Pg2ikLLfPERsoqJHqnIJkgEyewsV2pfgKCzmQxV8QGQWllOiFR8+EKHEEVd5appG2PWS2iqukCF3a4SgKT1FSQ+neZIvyeIUlmQF6RKh49IP5eKWD1oTJPJ+LQr4W3/Dv8fLxYyCsSaXNDj4F6AWj50DXw5oXodEf3irqeygzLWSm8+LydmRfyo752gy9WN55SNizzPwVjh8sIGRNwk9s1zB7AEro5MN6KhA4OdhTIeL7nYYr/+I+Gwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PurIhIw5qMQwn+YYnd3n2GMvgVWcBufyQkl55gvUoWQ=;
 b=KNckpyxYxVdG6d9dAzzFLP16DpYEOUJk9vB+RVdrrhbfwPRHm/MYB9OUKJEotTaGpcj/Y3+vTgj1qnfxR7+bosVbVPipx2Atn+I8x2cu631bIFPfSQ9MJwwUVqwSkUCe06K2MVnzYKdRtXuShQ8NiUWF+OuiInmARyg8+Luq3gTmFnzezbrqWpLtDAYUs36cDlg0HtNEromR0oASwMy2Ve0iXKzehAnejj+8OpK81/olcBsulc5oAnaTj9G7ophL4rMqfGz9gxTw3rGPqnsOAqw35eiA5b30XSi6EewOQ74/p8xz6gLdZ5T9m/phruMKVFCVVZZMpohF2/rUKjnXWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 PUZPR06MB6055.apcprd06.prod.outlook.com (2603:1096:301:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Sat, 30 Aug
 2025 10:06:49 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.021; Sat, 30 Aug 2025
 10:06:48 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Michal Simek <michal.simek@amd.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] mtd: rawnand: pl353: Use int type to store negative error codes
Date: Sat, 30 Aug 2025 18:06:37 +0800
Message-Id: <20250830100637.14756-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0001.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::7) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|PUZPR06MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 39922657-9f7a-4c40-debd-08dde7aceee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s4MtDM+0TCCV4K3Bstz3TZ5L7nFTyRWR4krjQOqdsmNzRutfV18jLjW5mx1y?=
 =?us-ascii?Q?BN0MHw9dbKYQSFruUUys6bcS+1BfNpwJ9qHRtOwLQj3Xi1VldVcWRk793okX?=
 =?us-ascii?Q?asG4RdQU6y/6cv7AimvAD/mctoG0HlOCg59EK7wT6RaGkfJydVbY6Mc8eOHw?=
 =?us-ascii?Q?E0OXw/8IZKz8cZCppltnI/DGMMIzZSnMqcE9WIUD6i7vDeLDOZmIa46GQs4L?=
 =?us-ascii?Q?rvV6GlY+bmN7UJ4zdhmKCeZufqKTsQ1RED4KkTbh17UoS9Qr98hMVH28vu34?=
 =?us-ascii?Q?QxuDQWx+aFxnvjQygD2q3WVKIwZJBA+H0nca86l8KYTyGkQSgtCfMEUnbnGO?=
 =?us-ascii?Q?c2I64TKbBYTWYIpbAazb+UCnJSTxdTyjcgI59dN4vWMDNjuydwPjaj4jxNq2?=
 =?us-ascii?Q?NZRMIygv6gbaakkwvrqV0dGshrDXGmKndMzhEC8PimamSxScjaCFRy0Rli+Y?=
 =?us-ascii?Q?AtYWmr+p+E04+JIH9CPKqgg6Beac/Y857UKk1kneuuPFtEUyJ17ds+01s0Fi?=
 =?us-ascii?Q?2z+rFMGwRXbDC6tKMgkUi5WmRdB/s0b1Z98DEcZn9Js3kvf9+7fDbxuCqU1r?=
 =?us-ascii?Q?HIGclhSgojaxKCljjRXJROMl6tWkqNQEzzXV1jNG/I7eBO3D2cVlK+KXJrBt?=
 =?us-ascii?Q?6X2wsA0nekb6m2KYzyngEe1Cy0pBp/NvQIwEZb0ZFS2j0bUT9IPSp2hkyprd?=
 =?us-ascii?Q?ySJ1+Err9p1XZ4Y2adogARwct8s9G8xstA5TuHgqmeFe1X+QP9gd1nbPIgE4?=
 =?us-ascii?Q?phvkybyTIBgOLAJe9uxv4a1CvF4RGKI3AnHCkH1F1O+jS5GDfSnqHieDCMNP?=
 =?us-ascii?Q?gWgtdI/4jiybZTcKrLnIN9mfs/ElXK/UTHzNoMV68wRWxwsidGgB/njYHjP/?=
 =?us-ascii?Q?FaQLn8JvakqmslG2yzMJcpE3HA7Kz7wPqiTkc+F2sylRJAMbADsFt3sceXwT?=
 =?us-ascii?Q?+xFKABi+lUAkYcUhgzpwDdAhwYp8KwnXvQvP+7f/59MMu6LP6eA4Qh9XScSr?=
 =?us-ascii?Q?ouM5pcfW3h811JZuOQy/M5Ghhc9bTJcgLVcgLnUxnR0cNmzJqHL2K70/rpPg?=
 =?us-ascii?Q?9kcWVEgxZ0wEkEduLCfUX23GVakl9UQgWqXqONmPHAtr2iMn2wFVczl7PUIt?=
 =?us-ascii?Q?Yfqa2EsaX9MItcx2bSjRek2AP1puhYjdUO0BhbUE0XXwM7ND9WCTxBp4pEfW?=
 =?us-ascii?Q?8Y7F3nOtxsVKC29QterLHiKqcVSCNrxP42jcPDBPjHLUKKDO2KWLQ5mWKXnO?=
 =?us-ascii?Q?L2J7bsIn1AYO/N447PI/OFJ3KyHKSgiWjDnpX8Je+z2two0OlYhd6y83eKUP?=
 =?us-ascii?Q?QkC3OnvzP+JsLwHLtvmt0KI0cZZhgmG553Y21qVczaHBPXWTjV4oH9+XYeJE?=
 =?us-ascii?Q?8u1hmIMglc2YMHbdJmVETcz/hkXCyF0/SmKs+kpjEVfegsS0xMXF22yY8J+F?=
 =?us-ascii?Q?ZN5GYvYdO47FaaeWviBbEhFNh1aWXZKqVpzZUocAtoahQUsOlLuKGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gtxZ3F6v+L/00XTl/j0iV5rMP6clAQl/hsoRdX5aW4UyXR7iR9IZwNjL3969?=
 =?us-ascii?Q?BW1/K3WFRx/7B/CZKSD7Q7rvWwl/XRfSperO3OpEyrroGXlW9Cf8oMojSvXW?=
 =?us-ascii?Q?sbEFawgxEubfwMWCGrdfo+KYFfGIe34JSHphISvOmPGWT+BUBvC69cdJJ3S6?=
 =?us-ascii?Q?cSSMYX4Tqq59XM5j3IM4YN4WRfoujfBtVi4WXzrSnQEp3UuQyJ3Am/TduSvo?=
 =?us-ascii?Q?YNllmouFZkDWBfQc+Ssqh/uTxmB/qqlAS5LhyO8um7guj3R/PwStdsoics2t?=
 =?us-ascii?Q?+3VcMbyENJ0LERPciyV9SArcbiMiqUv8rKVIRnxyTep4PKy+wTVPZ9kc6skQ?=
 =?us-ascii?Q?UJpmWJ11gGqnQClII3uULH+hCjLwMEZ+kdA05XfFAvXgia+2IV95YUTeRPJL?=
 =?us-ascii?Q?+kJFiuK6m4e1/d/t9gOKG5YFs8K2V4NtaFyXR38rmOHFgO5qUbSppBHVnEWV?=
 =?us-ascii?Q?ZJunoac0iRjBcnxpN7GBMlQ2pT1+vR7jq0XqqVNMDZdhZkwED60rRGec2Mln?=
 =?us-ascii?Q?dNohMP2oblYSJLj8tXxYy3O7Gt2x2+Utdqqqm5VQu03T6Vg4yoHBIuOMVPFS?=
 =?us-ascii?Q?7pI4chAAuff+5GV1Y0yon+24TdUT0hdFDX9GVeyp20t9alyzIQ0nWjazxggw?=
 =?us-ascii?Q?7mtjLiclBlUrw/bgp6DZoir5NPC5JK9XyKLwpvmQLOWfkP6xCE7H7OEC9j6x?=
 =?us-ascii?Q?rmYczjeih/s4QAZgKx1IGI8PR8qIwmgvlts/wB/4oqAtmRaulos03ULeo7yF?=
 =?us-ascii?Q?wuQscJq8XRhPy3HAhWSKs2od6th/+F0z4laxHZiMFOxISY7YqdyTDDuaMvby?=
 =?us-ascii?Q?myS3LjziE3XKEW9DyzVCdIkySszkbWAgjf38BTbWftiJo/r5dozFOBJg1WrK?=
 =?us-ascii?Q?eF2n1x/HWDFVYHH0nmZVhUQPSmIH33S6KlRK+n8SPnWydyUHbjrXGJpPK858?=
 =?us-ascii?Q?s87R7CZ2Ckixy/OuIiRke/qg5v8fEPHrR1Vta9unZFAiZyHQ2nmEqR8YKv5n?=
 =?us-ascii?Q?UrfTsYSF/I83RPhUp8DaNiHq7PeKtOnx0CP64A8cWpCL1x2SrDhGzrZuB3r3?=
 =?us-ascii?Q?UHuvX48wwenUVyjGXHMfM6rNYfOkmoy37XDIi4tU54mBCy/eSYaAyKRE13q3?=
 =?us-ascii?Q?SRWZaSGCXnjT5p1fX6bWap11I34zOlj5aQJa3ztTkb9DHvDo3fD9OhSC6aWV?=
 =?us-ascii?Q?kLgvcZuiMzvPv8bnsRH2yRVQ9Eju2k2xcwLDkdp21cIkHytWTsa2ba6Vztqy?=
 =?us-ascii?Q?8JFRV/LVpcd5vgQh3rdwjnn0gahf2PKNHJhtZKvfBSbEOlQBmwUrHvIl3Ffa?=
 =?us-ascii?Q?qEY+HB5yV818RoYv0pSFGK+u5A/V5t726xOivU+KhiGbmjmEdztgEIIccLII?=
 =?us-ascii?Q?WjAw53J+xJonquxA+P6RUsuFFTVIJJj+TpNBEo2CjhFg67nnl1tllFTEcQft?=
 =?us-ascii?Q?AuDWvqC+r/YnWcYzQuRk8ddWpGML1kRapfBchV05etVlXDtrswLHWo4PuQmZ?=
 =?us-ascii?Q?eFhSfShyDgK2yF1POZ3Wa/FiPsNVvNu8TN2BdtdJWxOStUhjQRcV+wZPNv4O?=
 =?us-ascii?Q?qOYdu4l9rX0fnAq27qdM9gdd/SAomqHIWbNRfDwx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39922657-9f7a-4c40-debd-08dde7aceee2
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2025 10:06:48.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqwsKjPKX4po5MrrcokRpQv2ifE5AUxTqXzO5uJ3QgAxC4J6+hBT4LhyJoRf8IKi3adBNOxZVPQ9oNnWZkq4Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6055

Change the 'ret' variable from u32 to int in pl35x_nand_probe() to store
negative error codes or zero;

Storing the negative error codes in unsigned type, doesn't cause an issue
at runtime but can be confusing. Additionally, assigning negative error
codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
flag is enabled.

No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/mtd/nand/raw/pl35x-nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/pl35x-nand-controller.c b/drivers/mtd/nand/raw/pl35x-nand-controller.c
index 09440ed4652e..37e92b86bf26 100644
--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -1137,7 +1137,7 @@ static int pl35x_nand_probe(struct platform_device *pdev)
 	struct device *smc_dev = pdev->dev.parent;
 	struct amba_device *smc_amba = to_amba_device(smc_dev);
 	struct pl35x_nandc *nfc;
-	u32 ret;
+	int ret;
 
 	nfc = devm_kzalloc(&pdev->dev, sizeof(*nfc), GFP_KERNEL);
 	if (!nfc)
-- 
2.34.1


