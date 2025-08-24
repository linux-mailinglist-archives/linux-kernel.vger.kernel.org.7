Return-Path: <linux-kernel+bounces-783718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52C7B33197
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 19:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79949441CBA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 17:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDF62D7DEB;
	Sun, 24 Aug 2025 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="mBQg0LmO"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021093.outbound.protection.outlook.com [52.101.65.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1727472
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756055626; cv=fail; b=QdLe6oMcZslfebh6cqtUinS0ME8sct/RDKWBIlqMNBoVOg4OhRfL9zV/RKcB58FlscMllR/VWGbQobdvWDJh0jAsXb8bIY02qmPcxpCwEj7l85aE7v33uMLvGx1jrrL0Ic7I6Zi88wBGmcqpQUqFCqebGWzjGfih7QPVVdsCT4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756055626; c=relaxed/simple;
	bh=sj51G5bsVftDTcJAHNPm/6Bo4WsDkMgnxhUEzU9aki8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dZZWWD9YuYAJzl2cKxbUsm7Tbs50LpVuJ88/4FThy20uq0/7UqGilPekARpVzc3DoagfhVfOTPdj2tAjsN4pAB7Zx5kdgFEjTy82Qo5I4O+s8jrBZoJ4rKrPR5WhR1x02pIEzvgZng5DN1NYT2EsJIqBV1HlJJU4RKNs5TzZs0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=mBQg0LmO; arc=fail smtp.client-ip=52.101.65.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKSllLL2aEqQvDEfjiT2N3UcWWTTwhHMU6FULKYM6SAbl17ozzWmTB5ArqJQG5hJ6JBlylgRBhAZndjt8sEfrVZLrzB4HgYgaXWMIys+r0fjkorbgf1t5yOjKKixB4oSRnHCOabr+ewNtHZ4hDLgKKmukYXf2j4Fspp4x5xi3hCKI5FdfBIiZ5Ogoa/rpBXV6M58pFY9maMboT4uwVJVa4ZR/eYrDJKEQSfeBGl6WJDcOPmMDFmAqpy8xZ0XQDFdEz0883zew6P/5ZX7PaNonFFSXqym3RBYD2x5lZt+2fWNoPwF0/j+Mdb8ScCPSJnMTnPFaH31JhV7hnFI2NzzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/w2WIgLnuWOWmC0UgqGOLyNjwGVYChlJl+uuUstHaw=;
 b=P9ISWNZe/GGajyKmXySqjBrcFt24cvMMUcg8VjlFJQtSxOT2swqsDO3S3CR2x92A8QhI34snAkv1gs8/yW1E73jMPKpUb5G34f4ECjV9BnGa6g+++vgZT2FL3li1HZeBYP7UeYbk8/NK2YR8voxttulPJXnAsHQDJGstBrJHN24iAqiGrk20pGOpBGeBG38QlBieN2qsyH9WGx0Pajs1DsW/TtSmOnq1USgiOO7nAbktx2YIoqGjzJeX8n3cN92DXq1RCZy3aMaI/oILrgJmHCeI5E8MIDuUuRnmrJJMeQorzEGF3bI3hzP0XiLTu3QMwX8+YnoeM50QfvuvJxxSPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/w2WIgLnuWOWmC0UgqGOLyNjwGVYChlJl+uuUstHaw=;
 b=mBQg0LmOv0fU+tMJqt5q19qnP8e1nQwP2bv3Xusp9curDYL+3KPG8oK7zUfINt2Q/7qmdM8BQXCnXaSELKj96J44NQuzWDQQOnaJD9JdE8+Yi+YKarvcaQAhdhjxvAkeZg0LWb6ysPqWXb2Jxh+YgUT2fdc2hWTbYZ6ZZxHEO4O/xHsGPPXTTTZjlyed2vN4c2miQaD2TI8WF+YUUX9/zaN4r2Kk7iAw9tz67Xr/tNnWDW9D0wHCdTfsQUFoeRWo8N3ftTbRz3w8YmLgpdMnncuCjXoIZl729oZ9rDpYNVpqpaC1IAr1K/yrz94MRMkTZhaRvjXNOSWUGqn0uTANmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7908.eurprd08.prod.outlook.com (2603:10a6:10:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 17:13:41 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sun, 24 Aug 2025
 17:13:41 +0000
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
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 1/3] mtd: spinand: fix direct mapping creation sizes
Date: Sun, 24 Aug 2025 20:13:29 +0300
Message-ID: <20250824171331.3964537-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824171331.3964537-1-mikhail.kshevetskiy@iopsys.eu>
References: <87bjo4it13.fsf@bootlin.com>
 <20250824171331.3964537-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00004530.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::359) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4ea564-2714-4ef2-4f8f-08dde33192e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hh3mPc7pQtVcO6iq5atCo/iApBjkWjnCLskmoUfAct9YPFnIOqsKwvn4zyKJ?=
 =?us-ascii?Q?Cg1OucX3/debQ72GDPS36YRn8YvIb/iRxXurPtT5YDvSW55how0dNOnQkx0E?=
 =?us-ascii?Q?VGCIAJoU+I2DUc2k0Q6ZGd10G7R8uCfJ9YVOaKarKYSXmQEarPPNMxqzwQyC?=
 =?us-ascii?Q?AtD/KRNZEN9w/CwSj+bM5jLym1ZZL1xABGRgsWonrgyNl/UdtHGHzm6Mjh+N?=
 =?us-ascii?Q?3DksqUIZImZH74McgHr7opq49/mhIZag5m4eKNMc26Cn/qZvnFblaNVctbPG?=
 =?us-ascii?Q?SQS3wzx3A6RC6bQPxmO4jZQ1F2jcknXA3zeqeE/EYszlG05pWB3dAr6NbJN4?=
 =?us-ascii?Q?jzW3yHUPm5KEhP85nV7jjS6qVhk7WI6C9DOtzZfxl8x0OhCgu2nam2risFj8?=
 =?us-ascii?Q?MgYHduALh+fJDQWzXe1TApCSS9nUujgyimBiA65lOCHcq5r9L8Kb8YbG2Te2?=
 =?us-ascii?Q?EnIsfM7dwuQ6gDYFfUhYBFxdloi8Wh9mlEy8I7iESGoeDgWPhlGxQoXZmAKi?=
 =?us-ascii?Q?DU14Ba9HVIC+Qr6AcEtLTnE4x7u6COnIhR5wEyUWh80i6zYtYlGk4LHE0wM9?=
 =?us-ascii?Q?HMKPxc17QDhERMs21wpt+QrahpgJghUQIGm/D3eFv0tcv4hkRoBjr2FRZqtO?=
 =?us-ascii?Q?4E2NqMnqAyUcZfNvNnHvJSnZ48n1v/pngKL02KubX5lQ+TpB8d5fHtcuVa7h?=
 =?us-ascii?Q?+tuaQJzS1QRJxmSLfoSyeZ4f7ObFZhGoqz1Z8IIdz9qP+152x139ZfeaRDmj?=
 =?us-ascii?Q?Wo3ZkLCLQTK4+j1NBj6yGs5le6/pidh+rA/DJ4gOI0aRAbsPbBWzksOpVmb3?=
 =?us-ascii?Q?C+q1qg+U4DjavgDpwIAh1nkWRvsLM3xc8gr/Bq9eP/fI8N+KTi3xdWr6a7UB?=
 =?us-ascii?Q?Os8dCfTrenVaHbrG8FX4lC9KTLnKEpXbSf8wlXR+iaeMRnZG1S8DhCm5Dhmf?=
 =?us-ascii?Q?OzbYsavCCMhs4gkM3FLY40GBGSVYNank26a9qXe75RdZPJCIYFBLHU2W0rmF?=
 =?us-ascii?Q?0VM0SBvvBlsezpLhnNlqsVeljzDlwCGq9laQ7FrniXzxUefm6f3obZJ/1w+K?=
 =?us-ascii?Q?OdxdjTrcsv8H/T6pK2htF0WklQsUFBe2IunrwA4PpPPcSfh/rNZXsTjHCvWa?=
 =?us-ascii?Q?CnesQGFQ0Zp6VFenfyXyFakqZ6MRYK973W+hN3uCtHI5AEBXN4Uwrk/C7Ku6?=
 =?us-ascii?Q?z3ae5j1MH1q52r86nvszH924VWWRoYyWAymeaEN2ryNw5sjdTVdaFqmSoadF?=
 =?us-ascii?Q?FbCLrDKmOtEh8wNil1VLHOAf7nBVgC08jCc2sPITCNQJDKk4NYVUEdwWA/Iw?=
 =?us-ascii?Q?s5sg74nEIPYsQDwkTvTUvo1j/HSrDnru73UuTBBc9vHSd54+CNIEJTpmTG4C?=
 =?us-ascii?Q?M1eqqzh3k5gkWuTQRXVDBfJkTauyNhz/TF2m25NdH8osFa1aZyktz2TXU8aU?=
 =?us-ascii?Q?rgI+YOb09jjDsiHI7NXcGwGiKVHd5eemsClMUdI6TeFDV2uNWYHbZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y24nPaNB7U6QxHBnk6XBMF1eAOgWBLLt377C0/RRvPXCFulub2ABP9NumqX6?=
 =?us-ascii?Q?3BMO5/JBhfDJNyoXjU2ugvppi/jmIq4UVNU6flhm+XF/24RIw2w9Jza0vXfI?=
 =?us-ascii?Q?bq/fizgaZ3AFMubB3g+aq8i+fP13N5v3W8tQWJe3HuWX5TOT7IVlJkC4G/YN?=
 =?us-ascii?Q?OsWihNK34gXJYyUiTTRk25DTrmLpH/H0GwixkLPg9YEFltppQqK8y1nU12X7?=
 =?us-ascii?Q?TL2mb7YEOldEbNff7HAVm+QbI3XEoT4WRDhsvxdp2Z/FBRZ1pZcJfbPupOsq?=
 =?us-ascii?Q?q4vu4IV8RImWyZAipgnHIPggfI1L9EXokYIWZHKTINwQxNbJ6qd7Vao/Chbd?=
 =?us-ascii?Q?MIN3iLuUQfPs3BH9nTuTnm6FJ+HOLtPGAsP3Q9qHeBBhrIhOC4S64SKA+8dd?=
 =?us-ascii?Q?05VM749cOqWJ9Wbo1qUkdBGeNLZdMHy3Y+Cg/lxMlg29A+TKu+GEuwtSO+iu?=
 =?us-ascii?Q?Sa1DebomVnRbO/LkA1RUmlJ4M9/IqFRRFDCXHDXTSj1o9M5DpLVb1er0oEnu?=
 =?us-ascii?Q?B8jsmKlsCKQbQ36LUfs3KpOKgi3nZ++kSQFJTv9tDm93mllC/H7GlUQ8VogR?=
 =?us-ascii?Q?rcXvnzcnEFwU+SdzZd6zJoEIpo4r4r12DW3Yz/wIirM5aKFbN28pPHyYzYBr?=
 =?us-ascii?Q?djJ4Misf2pMgefMyBN6a8VnlQ61hpInAeFCRNI1/7oFYSjAmtwAp8ax6f4xJ?=
 =?us-ascii?Q?YY8LThLZ3tSep8YjAz4rUn0sUMqahBaNRG0ahuTPPSc3ttKJVuvdh518S1pD?=
 =?us-ascii?Q?Fk56SPwzRf6RIY+85U2IeU9SNz1dy2NiQmSbK06GbArFhkzk/Aaj5kSbrFx4?=
 =?us-ascii?Q?W53JPBYa7Sn4m4hyguaVdF5FCctkq3AghUQXdrL5w64SppAnIOffSx/x28lQ?=
 =?us-ascii?Q?APerIFPPZ+YU1kgIUs1vGd39uIIL8L+nmTRl/NoGcmAfMPNB3z9DiaHlNi2L?=
 =?us-ascii?Q?liQAKM9dPr0UO7UgVW1IIiPdj3rgrc7dudFlyKhamH0hIYZ38wFg75wfy6C4?=
 =?us-ascii?Q?ixBiwIRV1rOFxzJCbs19Nzw7XEjX9QOqssUcCvjwZZb7sTvPPqJRYLYw/orj?=
 =?us-ascii?Q?nHTyKbq+McGvl9meEsY4rBf9sCfbQ3hM8oC69DG7DMaR8gYpJt6BVxRnMGQL?=
 =?us-ascii?Q?uokG/u2EqIyhwJFrqtJHP3mck/vf4yN8tHFEiNowelyL6lumlqQhodCOX6sJ?=
 =?us-ascii?Q?vEJNJqsc1MKNATVnIrgj/3664zQKaF0pqNWcCg6aleTjZ9FJrtCP8F6YCgi+?=
 =?us-ascii?Q?+t6G1AI5GG+eZPODf9/9NXNSUz7AtptQDuLAx9XhVvh12kLJGp9K9Jrmo5Ku?=
 =?us-ascii?Q?IH6M7tyYjkZugrLm1Ig2O922pyXg1fMRVRoDfE7kq7XxvqS0XNlFNJ9nHPVM?=
 =?us-ascii?Q?zNmjrzXrhiW5zz1zjGGW+hoeDPEPII7cASl5RA5qAy4b2Ij/mxZsb2jgysT2?=
 =?us-ascii?Q?uNArKQ8LJGrsTfpM0UisodHArULRudpmhoPhDSfii38KVQZ+fqjvx79xHqKa?=
 =?us-ascii?Q?IBpybYzYLUmfgCvCuUZLB81tEeuXhLaZJwQwc36rZydb2PkbYLiwsUKqsuwN?=
 =?us-ascii?Q?TTNKf8ttkLQFNiCbrB7RAzyQ3MhzQaAjGVoowF2APVIbIPR2gIHU09IQsJkD?=
 =?us-ascii?Q?dinbp2Th5P+oCuRyKq49Bcg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4ea564-2714-4ef2-4f8f-08dde33192e7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 17:13:41.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4z6fCbi1pmAUpGzuzCzhe6LMQRm/9mYL5hwXYMd1nPIZIM48Xy0+k0N6+/AdzV09iDQBbgk2/AKrq/lD9VcDP53JhBaoVaeXogjGTu1Ne0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7908

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


