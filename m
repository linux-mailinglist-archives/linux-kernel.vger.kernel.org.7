Return-Path: <linux-kernel+bounces-783757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6B6B33203
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 20:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A29E3BA033
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 18:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3570622576C;
	Sun, 24 Aug 2025 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="vyACUuKU"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022078.outbound.protection.outlook.com [52.101.66.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2505A221555
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756059549; cv=fail; b=onEHqlm20gH0zTO3oPOi+Wm0LFrXEwqHOqTW9gWqZnlyjM0wZidTAdxGW+qrfV+wwK5qr9JhvaN8sZkpDi7OD3ihN+sG/q7V3zKQFHq2h2b4+eXq90egspWjo+1be97reWj8NXvfTdvRoJci2zsQlfZ6w8bPlK4U1/kK4x7pYO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756059549; c=relaxed/simple;
	bh=bI8+ngdWFHNa3d9Jzp7BKlzxPtUj9LXsmo9qIhIzCYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PUouJv/OTXuY+WjQby1DZgXJzACS0UKxZfZ7q19xX0GXwBTYySKixQWG6+3pnl3h5gn2JaQ3yuhGkIR7RA7opgM0Nwdk+MGHC3HGNsubhcr3g8EII+NEpgJIBpbZo7DgZI2sp9137WW5LyUO7W3b785Zuoo0i0jzTPxPRmo+nNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=vyACUuKU; arc=fail smtp.client-ip=52.101.66.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfabSPZ9Z3MqcAOVt4lxEqhb2kdK61cBfyif4Uo6yaiFdCZz/cZQ3eH2yY6cw83Y3DrJKddXwJeW50BXVUT43j4jsrkm3ZqKlhkts75AolttCQKAkOQk6zfZFm8AG2wBGvNsKXNOZbDm6zR2Bosc6w54OZTA63/puIhJtjTaX2I/PBIwjdgAB5JyoTV9icdaZkFZDWGSI4bpIEIC9jvTlNLqO2HxnDQlgpC/Rfxa1Xh6QpaTuRhGYQ+GQvxoXE1CypbHgoG+MzuZMEsGU7q/+SCfkNir//xZeX8D2P9cI7jvVAc+3CY+pEsR9qAMUPsoxGKQ0l66aHMIhftN7pjAjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kjmf3YIogIlr7PHbp3AGaPikD/o2Vv5hem7hDQQfpDA=;
 b=mbznbhdLDgs0CBh/rdTOWdlcrHAqt04Sf3AxSpeRu6/PnJI3uQAVfpwlfI+Tw6I0Bh3D7R984Qyvat0XSibFcDQv31EQ1BlAlAcGOgLUGriATLthxuY6IsCz1GpNAiBS9kbtRA23EFESMzatugOOMLBK6i4P3yovaU8zYnvDeKX/sH1V8JK+1jBxk6TswU0e0Ptlkid2CjPQP/ww8Zq8mpzaUZAmQU9Ca5PB7DmpqSBWQqWKY+3k+403Rs+meLuilMhgR6CIr5+++j5sPEvm5W9djdjyiq+DNlNBoZe1I1P3+8jw4oa9WApCEmcjSHBBaZNs4Izz/vteBuogCXpZqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kjmf3YIogIlr7PHbp3AGaPikD/o2Vv5hem7hDQQfpDA=;
 b=vyACUuKUPzYpyCR+tl3lKAeTHqD54QEqYSviJHrGWmPmsgb0G7S3ujmYgOkqNkDWx/dNP+KNC/un7gkHj5F4arqCBEvFc9n9hjJT1Ay7jz/iehjqptRPhNEmq0O7N67f4R2V1Dh9NdyhLOfCx57oKMcuFFqg6ujhIVPhq9N6w3oCmteamInFFtyNM1UptyGPCwZu5taq6COegbGHZQOB70NJZ24sonFp9DEF3qWhr1jZA9yYBWTd/C2Y83ob1bWblN6kgk0kIdqlseLqr4XSYE/gnUBHOFeXp/jIHdM0LAIqbbRaonNObmYRlP9I11664yjgjCqKR9J5jM5me0AIww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5810.eurprd08.prod.outlook.com (2603:10a6:20b:1d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 18:19:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sun, 24 Aug 2025
 18:19:00 +0000
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
Subject: [PATCH v5 2/3] mtd: spinand: try a regular dirmap if creating a dirmap for continuous reading fails
Date: Sun, 24 Aug 2025 21:18:49 +0300
Message-ID: <20250824181850.3994184-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250824181850.3994184-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250824171331.3964537-1-mikhail.kshevetskiy@iopsys.eu>
 <20250824181850.3994184-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0096.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5740a5-9688-4241-ddb4-08dde33ab299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FbP/ms7EBLNmr++YsdTKT0dvBt6I/rxtA2vcLy4RVY2xZqxiUXU6q6n6HNjr?=
 =?us-ascii?Q?8/5QLXqYlJb/Ud300Rf4hp3Bi5mZqUtmWzB/89hEVJWXoRrRoWGbUrVhOrgy?=
 =?us-ascii?Q?vt8sW+pac4iDp3GwiKBXrEhLHjm6eis/yGYvmXvLtcg9nx6ZvEk/XWR8IhEv?=
 =?us-ascii?Q?8aiHXKZcISGCC4rsSfXu3FBW7D42i73YdcoUIoXQmjqqETci6VaWqVawgfDy?=
 =?us-ascii?Q?TotPa1bVirYa2nGyHfkTVqPbuGr9EoeI2pFJ3anCnA1Fb0q6AIpXlcjoWAhL?=
 =?us-ascii?Q?t1eWTR5XF0VuajF8iN4ZDXaAzL4C6EQfIA0cRkzYXkbD4Ygk64fRVy8as8Dk?=
 =?us-ascii?Q?9cuCW0s+3sXRzRR43/gse/x3ep2OtH13fFwNNYhJ3MD8eSv90UBpaZF5JRSg?=
 =?us-ascii?Q?Bogo50Vh109MEiF0Rqf3k9624oGmvBrrOLTwEoGZN7IElzvBrInbWAM1ThNq?=
 =?us-ascii?Q?crEMj9ntQ6wjqrAeObgMkGR8F7paTofFb+1z+UZymWxmCH9Wuk2AgZR+ZgWG?=
 =?us-ascii?Q?kTTPBxAf3dgZyV12GSHy0e/onThzZj37fQ0I44JGcvXcX3L7V5WcW/hwK+Zq?=
 =?us-ascii?Q?cMlyNynSjlJnK/tvkdcE0TuA1nMW2pNA6wVcbNIWhC5dlfdcuIXDDI6ax3J0?=
 =?us-ascii?Q?PtIE+nucLO1/oST3s7cfiO9TucwqWtak0uwtEL5uDQpGz30P6veH6sg8SJnt?=
 =?us-ascii?Q?DnKnbQEucxCNCz3DjziJIEP7ZaxDbukzBMrp/IIn8NWnRg2Q3UAVGxTkZIQr?=
 =?us-ascii?Q?ZP/TnIshKtSQEReG/EpMJdWTGOeJKrdROqYkBTAX9UtOrUfBVQIm+HYzboww?=
 =?us-ascii?Q?RFbEueAeQSKd8W9O+NhlwPKpfsmeLlIjapWX6ybvNkD4kcdTTIR9B9GpD6g1?=
 =?us-ascii?Q?wXJZejDz8wImQ6Zy5wQpfQOiQvMMMV0ujFSzeKpeo/kn6JM7u2+pbRPCtblA?=
 =?us-ascii?Q?2jxp3hUxHN+k1aY71HnL2WUT3Bi7Rc5SV7XPSXwWapXvV2anXgZNFlasB5WQ?=
 =?us-ascii?Q?EikyYZqM3Ntdae67pmmFZ0jl/+DBDOJIXjTKfL6KfXR27BHkhAuxAypjRkpf?=
 =?us-ascii?Q?njo5S9mWtlX/w/v3uzWZixjf7TLF31wcQq4gjuliUWM0qWZqzLFItXsS5drk?=
 =?us-ascii?Q?d+9mfpS37H3Qkn8KIoUKP1GVWZbws+qKOerX0DBYFRjpkEJs5XbvuU88G/Wm?=
 =?us-ascii?Q?Fm0vQfxvbrbgHv85/dFPBXh4Kb/D0mwDSDwLutGAU/4m6OQfPosAwcpj83eb?=
 =?us-ascii?Q?ufp3MP73pTgOOh3SFJk04j/0S+TZ6fzOGs6Gm64d6G9a5JDEQeTpXNoyMlsg?=
 =?us-ascii?Q?fnT2IlaeVL+4rkfY1s11floyD+1yuUS2sconMBPyKbe/G99whXk55LzJSzjQ?=
 =?us-ascii?Q?agOtOOvab9A0nxgALjE8dUL/uwUFVnIweVNVneDzcCyb0quHzsbdMwEIMAL2?=
 =?us-ascii?Q?0cNo07Ep5MtDu3IIu0EXpCTTEVuNrtiaKhMRn9RU+bdQZzXixknFZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?owpvaA50zpW3ObeWx7tOKSLjfvN+I3bdN2FN2P1DzKGNocbqriiAhz6FzM74?=
 =?us-ascii?Q?W3FI/ShYsPYpc6Wk+C7v2sJuiG1fmL22SogwRFPuIdKvYqLjXTj4JEOO2Odm?=
 =?us-ascii?Q?Y/Uuc/d7Dt2zK3jwCeu4tw85B7elDNjpY3Gu2T8FwUfB6EmECTcjNlyo0dkl?=
 =?us-ascii?Q?LZjGagj+/FtZs1xoBEFv8poFP+N8ysHm2U7oic3pooxuQ0278xc5aqFjoh8c?=
 =?us-ascii?Q?WAwv3phtlW0e/7v76vB82zgmxBQG6G4OMuVE/LENZwnB2OJ3S7K+KvdtPiap?=
 =?us-ascii?Q?Gsb/GZ8/nsRKX9dnxrQqqOC9wnnyvewYmeBOisZPnYK4u4JaOHdky+FM539g?=
 =?us-ascii?Q?ab1PzieXy8LluezUfXqattMGyU9l+/NACgPKZgVNx15lEcP0KBbSuzLRT0Dg?=
 =?us-ascii?Q?tgvbLGkPHSy/EnxR1lRr4rhhJ1pfQICwJRLb2iQukGmYeEvmuXPhuIQpNkOT?=
 =?us-ascii?Q?jgHaAbInFuQWedHxYvzhxweWnzbbgZuTw7FW1sNyqoTbUKIDAA57WHuPq5FX?=
 =?us-ascii?Q?wDSoICTCYKkjBR7mOGRe8Nsd1sZqyWK9A8950lG0ygjz5AnRqj2YQ1zHVhHy?=
 =?us-ascii?Q?npaAAjiuPiU1P793Qo9MkOh9xdM624uiwg6IO4I0QtAw+4X69GG6cJ8WUa2k?=
 =?us-ascii?Q?Z9LCCEl9MjNvfeMk7ydWtTa7e4UB7hE3b89oUEejAnzTzN2xxnvzALocG+dO?=
 =?us-ascii?Q?E7tmDRodp+OQEFSsEoZPTaFVNeRLdXizFGqM10iW4fHsBQpGwqiWMOFac3e1?=
 =?us-ascii?Q?AGv4BsNfgQ4TafmSmUJjf0pUfskNPCCSw80NT0g20LWU3NathblQQqfugH2g?=
 =?us-ascii?Q?RAmG8OUidMbvUMhCpSpV+Vc1U+kFJxRvVos+4f03RQkLZFLlT1I2uIx29tp6?=
 =?us-ascii?Q?6vRU2RSTyU3dDhBxQBZmUof1C8sF63Xy6P7BGPdN9FejqHvaveovojuX67XI?=
 =?us-ascii?Q?mHze1J+IyVFeS/8CqkCVfKjC4yEdJlTapFFbP56y8btI3/aMR2AQY/GgEHzs?=
 =?us-ascii?Q?GpvbyOFHsTD6q2stPiWVZcZMB5Ocuj9L+D5/EtwxFDKfDsNHeec7VXGRQ2rW?=
 =?us-ascii?Q?FfH0AJNEIIyldWvOWOFhetWlvN3dfCkapMKeYDCV/xHv72YulW4r/6n1upwl?=
 =?us-ascii?Q?nBa3hjJVr7mzz3Owks0atxC2NgoCGX8NuVJp1k+CPrTbSSldNNik3A8FZeY/?=
 =?us-ascii?Q?rTX2nOvgL96x2pL3qsBOXDRhFAPWi56lbovRogx538pLmwNyNmQx7NDtk2Uj?=
 =?us-ascii?Q?ALa5I4L4fF7Yz/HyeLTG4Jd3XCXQlpP7lyGRhzpsQSrqyrr5vWqTV++TBHWm?=
 =?us-ascii?Q?ukQMDie6robvYXu40/fSS5qWRTRslYS4miyvmEJtCEz4pJk9bWFZzrKlrLW7?=
 =?us-ascii?Q?e3LcZj8wHMc/BWuXbJ87XfBHbzNwRm9dtJxUpeKWsFqs5fEov0nIR5j6ME1a?=
 =?us-ascii?Q?X3DoxPEJjOxb98fgSq17Q7JlXuCIrU1tSzeqdipvYDThzUY8XYxiKkCiB0rh?=
 =?us-ascii?Q?b3s7RkW+VSQ9GjpmCIPjCxG3I0Gxiitz32oHPt/l8nIBfOrIb/tS8lV0WPPg?=
 =?us-ascii?Q?a2iU2ydSFNTHkaIv5kXch1qNJJpulfrEix1jrPtX6AD8yeMNoY7KyoHPIXkL?=
 =?us-ascii?Q?5qLozQG3XJx39pBlR5JTBKA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5740a5-9688-4241-ddb4-08dde33ab299
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 18:19:00.2530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmaC9AIfWAKc4LdUBiqhmZBlX8E6u1pPT79+q1lMOriZvEgC8KOCZPA1gMFX4MseBARbTH0dmWH9SrcB2oBOFwctxREmBqZ/OwnEz85qPHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5810

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
2.50.1


