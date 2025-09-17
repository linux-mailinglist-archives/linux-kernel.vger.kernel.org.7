Return-Path: <linux-kernel+bounces-821711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2A2B82099
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA094A32ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA7A30E0C8;
	Wed, 17 Sep 2025 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="BJeJaDyz"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023075.outbound.protection.outlook.com [52.101.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A048830C365
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146059; cv=fail; b=sieUZw4CEDo8771LyWaE161HmBhJ4N5NxeKGKF4Gfgtbx/zIEGtUXjj6HZnLw6TANPJWpuwOD62BrW+qVfgo5un8AORveaXNpCEI69WEniK6Vr4outomi0lnehXDMKm14nHM7WbmbXUzVY3FX9KZ8DOhPnqRHzu67vC5UvKBHEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146059; c=relaxed/simple;
	bh=XAepcxSLgeHsy0b9ivNYHNsBXl5PoaZpRGHtKZ3r0As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EThNzoC7Uoa1Qgh9p+SMdD4GZg+ha7S5114i7l9EEL1cNrFRV1bfPMRtFoGnme6Uf2paFLf96adErPWydICsyxCU/jwv97NMdS5dpaHPPsskH/BJYGOi5lJ+K63+PoUTQdhq3uB2eanrQYg7SXknobHU56qydeTK6Pm8JFd3ESo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=BJeJaDyz; arc=fail smtp.client-ip=52.101.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fw+5+SBMZp5Jqbm3EFeifOqC2ssIJTVPUh2egjwMXT7tfUQRfkeJEVLcse8XDi7ZXFW2NquyimjwhziMS9uTyg4nMxZmreMjzVib0hydRRlFGuIe68B5foycjrILbOHT8UI7flPt2w66F56UR0+T1bWkpCUT+hbvYTzkcjLOK0RNKVAkJerCVZOiQ/aORW4f/PkNamiekQDv2+zc0/Jz21HBv7ibZNkkpsZQoA6fFzvuVd5xOWDtopzfjdLgZlZfyXnIuGPgVXcRAfuTkjFQbYPE4Jfs1iguDO54b7OF0AA6Q0Sg2g3xWWBY9pnc+1tHD3WfV6SnX5gRNJQpU316SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFwF+NE8DsI9DB7q0hBsjSci5MPJSQpZbQYGpyTYmFY=;
 b=eBa9Qhue3e6pKK5y9dGtaouWRkBRQKfoKNm45iqgGKqyeQzUrcXKyVb5xCjXqfMZCNsIUOtEh6Kd+bl8YJVJ+KM3uOCthPYReJ+v8l9vOpeEjY2mMJ76nDc+5kfaUPL+70i9+H7CMrk37DJvKNBtRcr0XaBvIWdIutPmJCggN0DWr0AWBGa8rVMBGF0CwaWyBGjLslxR8H5x6oCp2mjvhSPldGBFRv5w3+UZIfMuptWW5rhehLP59pxE3xRdDVx6e8QWZRLyb4YxCHAaBHyHa48L+Ux3/uff+GiRTdbfI5JDNiCWNz8HzJlOK3nWaa3byh/nC7SiEhjGGmU9fhYFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFwF+NE8DsI9DB7q0hBsjSci5MPJSQpZbQYGpyTYmFY=;
 b=BJeJaDyziS6GsXEAdaPkyGtrdfQEXXUlVs49J8zibnTxXVm3iRdQCIM1jbA3Ya0NkpTp1tZ3cxMqxdXUD1iuOuEEhMEOEUNCS+0P9pIDAcug/k+IHQNWhECrpCf2Z6vY8Z1Lsw531hV/CYKbq1WokK2cZpd0aDoHLV4SvemDs3jk7NUXC5bEIb2Q/qzL3LBeKSZphShNCfmr0rtEHaCsuJnMCejnkOds9sq9yVBxg6vEWAHxkVAW3yI9FgpVjsIgnBcRW33HpGgsOms7pxjvnjcmutK5n2ql9PlBbQ+PXOD5s3tnIH/37jXF09bhlvsZoPced2VxyUXsmyeMihm0dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6322.eurprd08.prod.outlook.com (2603:10a6:20b:361::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:54:11 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 21:54:11 +0000
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
Subject: [PATCH RESEND v5 2/3] mtd: spinand: try a regular dirmap if creating a dirmap for continuous reading fails
Date: Thu, 18 Sep 2025 00:54:00 +0300
Message-ID: <20250917215401.19132-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: dcc6ebe5-6d81-4566-82cb-08ddf634bbff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g/73jsXSyow+5u97empXMlCqKfKgu4N/t+wiAcuUweKPi/8vhfPZJD6KUTIy?=
 =?us-ascii?Q?FKKlLy9/ZDqjTdEiCnVTza/bJxcq5y4sjpdeRRcMkLGji13757ygIUR+C6Xd?=
 =?us-ascii?Q?6dONkcsd4X5+jFTc5XOykJSW9tWOTY6r9yf/fGTM3lndsAd6tQ9a1jsfJuCb?=
 =?us-ascii?Q?nptdCqzOkfZh+PuXG7b8N0aBk0NJYlJ2iGYQQ7bQCR5gmbD4CdIRS8r5zaOT?=
 =?us-ascii?Q?NcgNcztRj+7Ex8as4dZglb0bn1CNIvEFhglSY2F8EzJBXBGwKnTByfqP2IWq?=
 =?us-ascii?Q?ROk9IuJpgsNViZ8oavmkbso+yZ4jEC3jhqzvTRp9PHOkGPXTvmoVZLOaMDhK?=
 =?us-ascii?Q?KXEkXugN9aqFBKc/uX44aCrB/FecKcs2ektJNvk0Ty1kKexQ5kV2NuFyjA5z?=
 =?us-ascii?Q?RLRtRGAsapw9cmitFbv59IE1sx91FzfJ+7T7BWak54bBog3osls1iSC+WCbp?=
 =?us-ascii?Q?ued8jz72ICgLOsQhMVfzB74BAQypTMvVBRdTsuRnP65kKfmZEoRH6uB7Fwkv?=
 =?us-ascii?Q?j92K5ZQ7emJZSM3YKg2zcwa6pjN+n8XPn7WEgcOrp5abjLD4Mq/Mi/rMp4RJ?=
 =?us-ascii?Q?ZoPsjY6EUFIX0fV7guSiDsgrCJserP54myW7w2rsa29XIBqw14v5StYYILIR?=
 =?us-ascii?Q?bQYS0u+bLgG5zHI/1j57zeq4mo4n9Kbfp3gWdNNZaI+A/ED3TRAL9s9A0C5Y?=
 =?us-ascii?Q?TubcKSocTmmePhsNJst+Vnhc2NuymPUIKDVsPdaHlX9QdZKDbw3mBrXtYs48?=
 =?us-ascii?Q?7LQH0dUbQBjYe+MxD3GpjD/a7UBTfHzeoaGP0dqjBE0jWtyvIEJc7KyEt+Y4?=
 =?us-ascii?Q?3hdxCY5C8ORqfgJyWfSCnnCugu91cYEGNNtUqH090+QIp0FsWdoKRVQN1TRQ?=
 =?us-ascii?Q?YLLq1rmgUtztTwyH1kdflnFDA+KTtZKEYWhly8wksTmS0z52dhh7/O/mNOZX?=
 =?us-ascii?Q?UOmZrt/89gRMtOH8h0xK7BCAJt8k/EkKNhDDx9zK1RKttQ+h3iwLRNqDpKzw?=
 =?us-ascii?Q?gaIVUZDjnCN1iaavkpkRjNjs6AfqIfr/QCXPinPQauMGKg/3LEmVNHMwfFPa?=
 =?us-ascii?Q?z/sp3cXY07H3/9avGQ5JU/f0t2OoeH9KDTkccQhrwmKhJa0rVmyilwauFepd?=
 =?us-ascii?Q?kA0LAf5TtR7rkZGtDY7iyorZ+M0AJ4uNHS8DXhD44wq28DP9z2prU5NXCJ5g?=
 =?us-ascii?Q?h/D8qDfD8fAPzoXb3WP4GJ88kU6YF+xPgrVb+tTZJrtW1VDyipTdo9VkjPHX?=
 =?us-ascii?Q?SBCyeT+ByCNJ8OppuqEjbygvtcspquyKWbU+zllrRwgjzvmYZzw2CNVIreC/?=
 =?us-ascii?Q?9mua0SQhklJPTsOYHM2X+hiF1JVoUdv0I8doXKHHLE1tiW4QvjdAzeknw7+4?=
 =?us-ascii?Q?PmvM4gZtLV8hhTOPaajj2S0keqPy4iQbXamb/T9z05j5KESi0qwe0cswbJvA?=
 =?us-ascii?Q?jtpjdInh6RrZuEx0oJByEARA38BGtn+Q06kUVZwtynHvspg6Uu+9kQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/3hvkDrWop0UU+Utx8sJ0lXMAIJV2PgjqcQKzySZbWJFQUPZAhJA34kMW+Fq?=
 =?us-ascii?Q?8Ph9hRk1EfyyB5jawOf0oF/GEEL6Z8J0Tf65Z2Ca574JNEkwcbQRIoZVxk+q?=
 =?us-ascii?Q?fBSAgMbTPsI1gkRq0u6JfeKktkgN74eMHE8pg45sHbD3JDiLn43pHuFUAU4X?=
 =?us-ascii?Q?74KDjg47RARn2uqDl40xq5nbTGWoGtnfWtzsbmvZ5WNcpQyo6fxKkB/cAdh9?=
 =?us-ascii?Q?8XR0wJZLO7Yv+ZJwSAty34pzIupbaM4oXC7flxWTr5gMIaG46vXN8pd77N7C?=
 =?us-ascii?Q?fdw+Qo7CVPyvoFHzA3o5D9AIn7i0uG/0t/k+X48iszcJA82ggs/ZrhC8w9oU?=
 =?us-ascii?Q?ZvW0k1xfDh2skuRrwecXpCMoteSCYVLDL2cx9CtSxOdptSbkYOv+mmaJqEBa?=
 =?us-ascii?Q?cYFc+lL6lE1SEXZz5uA3yk4nCk0sMYdhhJfToyx62oK8p5sLUfZQNSqGRFtZ?=
 =?us-ascii?Q?Sttkh8zQGamw8Ll7H8QV/VNe7FECf4ZjxexsKIry6i3CwryaqlNwaKoogPsi?=
 =?us-ascii?Q?lOZ16bLz4/LH9Xvsyo6k7EkshG3c7JmKiLhQIKgYE24xabDDQqY5h/GUHkie?=
 =?us-ascii?Q?nyAux0Ik2Gb51em0vuZE9fU+MLYTvbt1Jv0AvIw740wXBhJZb59kCDuY7Wzr?=
 =?us-ascii?Q?fka5jqaU1tdz/8leRjRxF4F7L+V2GwvCdF1nWhy8ipbkhj4ZO70sZ9XX6jcF?=
 =?us-ascii?Q?zLr0i5JDwAn7d2AJjXzW4A9byjTFRL6l2rRKR+L0LP5t3yGRFSVq1F0faLge?=
 =?us-ascii?Q?WowrwIy36vFLmPv70Wvh8TGat+xFEiQLpJSfoZyzxpTgX4z5GhCLXyr228/h?=
 =?us-ascii?Q?N8hkmRfmiwTiouUouwHgQxuMLtI+lLXo6qj2/pwM9nHKgeLvqyfEtdv1BnzY?=
 =?us-ascii?Q?v4BWwgFshJy/DRsv6nSp23dLEIXbazcGsUrWT36sYeORPmUlAGs4B34MTDCL?=
 =?us-ascii?Q?CUL3iEFLeaqwVgh+uITrY3LJGUzdIzjS100w45MA+CAZdj4d02cX2H0QQVZq?=
 =?us-ascii?Q?MQBu4aMElqt6ZpL1i9smEpF9XMDrpLT6Ha0g7Q5Rq3c5UERnLM1MzpjvwgtS?=
 =?us-ascii?Q?0Sa3JJ8zV1x9rwqb/rlLulV2ZZXJpdDXPYkDRrhp0k8bdqcsukpL1AenAvBI?=
 =?us-ascii?Q?eZfu/8GLsyUgx5pfRUFCCyMSnm42tnamGqGP1T78JGgSa7PKM6SR5GEHmelr?=
 =?us-ascii?Q?4qg4FeTbd6qCpx9a8bWJHu+GF418c6vMNSuAUKPiHwC0yjAWVuh0K/S8F6Ie?=
 =?us-ascii?Q?MUv/agT94PntaxPZy8XbMnfpVu5VfG80drXGratP07RC9SVZmM9Q+ZFWXmmN?=
 =?us-ascii?Q?dvF5CdP/8ugyGFioPpNBMnkH/BK/JgpHtAafb5mitAB3nnkF5E9DlVQryODO?=
 =?us-ascii?Q?VxrbaLxM9JWwWpBa4v0HDDXNUasFJfKWfRVNbpdw/l1GiynQHA49D7/CxwbI?=
 =?us-ascii?Q?rD6jc58QvtIri/Yt27ZLLCBSQDnDIHNw/OR3c48aL863npoDmig7GtFu3FMe?=
 =?us-ascii?Q?Dp5de0RhxHJdnxxvt2+TGRi/dmT5LQOONSPVKuCWmk3Grl+6hQKRbpwC2U0w?=
 =?us-ascii?Q?UsJxKmuFVNY0uzoT4WGNgyszmfw0rTjRLHt6VccZosgtkYMAGv/jkavqNkbl?=
 =?us-ascii?Q?vzH1O+ueU8pbKN6v845Ak0Q=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc6ebe5-6d81-4566-82cb-08ddf634bbff
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:54:11.1381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFHTL+VV6iPMLsozJXfFf+p92pbp/ihmLL7tuNslkA/JuhmO0yLWIbcPbyW7ggJ00WnK8oaEsufmWb5XH20T/EBZsNChtv6znjSauxX+36k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6322

Continuous reading may result in multiple flash pages reading in one
operation. Typically only one flash page has read/written (a little bit
more than 2-4 Kb), but continuous reading requires the spi controller
to read up to 512 Kb in one operation without toggling CS in beetween.

Roughly speaking spi controllers can be divided on 2 categories:
 * spi controllers without dirmap acceleration support
 * spi controllers with dirmap acceleration support

Firt of them will have issues with continuous reading if restriction on
the transfer length is implemented in the adjust_op_size() handler.
Second group often supports acceleration of single page only reading.
Thus enabling of continuous reading can break flash reading.

This patch tries to create dirmap for continuous reading first and
fallback to regular reading if spi controller refuses to create it.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 43 ++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 09dd6e40e308..02e322490110 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1093,6 +1093,39 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
 	return ret;
 }
 
+static struct spi_mem_dirmap_desc *spinand_create_rdesc(
+					struct spinand_device *spinand,
+					struct spi_mem_dirmap_info *info)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+	struct spi_mem_dirmap_desc *desc = NULL;
+
+	if (spinand->cont_read_possible) {
+		/*
+		 * spi controller may return an error if info->length is
+		 * too large
+		 */
+		info->length = nanddev_eraseblock_size(nand);
+		desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
+						  spinand->spimem, info);
+	}
+
+	if (IS_ERR_OR_NULL(desc)) {
+		/*
+		 * continuous reading is not supported by flash or
+		 * its spi controller, use regular reading
+		 */
+		spinand->cont_read_possible = false;
+
+		info->length = nanddev_page_size(nand) +
+			       nanddev_per_page_oobsize(nand);
+		desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
+						  spinand->spimem, info);
+	}
+
+	return desc;
+}
+
 static int spinand_create_dirmap(struct spinand_device *spinand,
 				 unsigned int plane)
 {
@@ -1112,11 +1145,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
-	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
-					  spinand->spimem, &info);
+	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
@@ -1139,12 +1169,9 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc_ecc = desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
 	info.op_tmpl.data.ecc = true;
-	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
-					  spinand->spimem, &info);
+	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
-- 
2.51.0


