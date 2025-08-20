Return-Path: <linux-kernel+bounces-777655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0388EB2DC45
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC264E6575
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D3E2F1FCD;
	Wed, 20 Aug 2025 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="PyTGuZmb"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021101.outbound.protection.outlook.com [52.101.65.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C112035335B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755692478; cv=fail; b=VHGAxj1ou22+DcFzdzvwmVs20xChP9U3bUGbl3yImZP6XpEW69e4qPsCwN/sqndCttJPA5eRD87OralUb2FSVStusd2DhatmppC0a6ySEOUNqHaGQiNW1TSx4CJ+Wb03/1bx8hOkiNikzHW6aDwismwwbiYvQ2ST8R8zbQax6Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755692478; c=relaxed/simple;
	bh=enXdG3k2lP8+ILqzF+56q4R63zfqfspac6Ynz69H75Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B4YTwY50S6LvO1u9yGsCb1+RAstbkf1qCUQiTVpnDxTyJI+kgtjwXJZomo8vPP6XPPjt6ziYiebCpE6RJ6nn8yTWYvLkDDk0txJ0ZC46tOgqut8ApZr7K/dzMXprNQeLlhBwD5+ahkN1dpewegyc0xG2T+Fh8UUu5VLNFnKyvlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=PyTGuZmb; arc=fail smtp.client-ip=52.101.65.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eb557knxIlMAvBl4z3oevHqrS2o6GUeGrCeaBFRqZdrD4Af+zCnmW3HXaWBrXJAR1n376xUxPlrYX7xO0dF0orITjTiMF2tZ89vu0KJN5NCXvsiOVSQtUkfWZ0ooNiNeUL6TveKgTopNujZa9QCcfcgqZ+EV52q6QHAQgXhft0h4ElYYTkIFitrafHEA6Mu3bME8i5at99g0emFm5aMU0TmMpp6XoOnZVsWzFk2qDwUA2+wmlmB7pfPuDcggjDQIb7/zLtZG8xFTanBtZsxSarfGcEKRMofp68RYED88RKkCQaTDS1Nn0bIOJpOO3nUVqMO8JCjSINd+8qQq6Sy7mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQATUBF0fnU0xBIpNZ0UIwL9CHxB3T/bvR2BEeSydgQ=;
 b=gNSNqf1YvcjmCpEMocPn6GoFCh+dElAYdsQNdKtUUfVhX2fW3WPH1Kl00gkAjvfSZDFjSsQkQtvgJsVVaMJxsVXOTEt/hJTkeKO/JMEBBGtZPg/FXecYDg+oYYPH3zO0rcUlVR2/0nsHGnLMMxVjcGUCvaF4XrlxLgcXxzypAc0QyKB4KCUM7Mr75ELmMJo6e3cl7wLIok9EtQiGHDQ1qB2CQztAkVzyVfQKQZ5lY4nggNjMPL4VT/lIGyeJCkeH3xEOb8kjSEZiOFA4S1fYEtTsP1+hSGSNIsunfz3VRvcGGr0CT7LrLPEKpDJgVG3v9Yk6yyofpKtuKo2VYLj4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQATUBF0fnU0xBIpNZ0UIwL9CHxB3T/bvR2BEeSydgQ=;
 b=PyTGuZmb0dRdHQuPDcrQu2kbSk4dZaa8ohXx0yrHpufWaQdyVb1+aQEfciidyDoY07cgIIKNCxl6p7d25x1vapt3DSFC+vSHGgkJfoLHgZ3gmtQRBVSZbzu6KzPbixcs0mfo4eSh+IjQWw8AxOv16WGxR7v1AT9Z8XSwoBRoXd2PQqi/zNSeVYCNWPG6lVMxBxaMHibbHrKsdH0Q99vRH1GFalzcy+c1ffqZErLZXMZlCpokvrWN7bN6nq3YaSRlijhB+QNGMwzqsWUqgdX4TaizYAarlv/yZ8VVHLA7aoeb7rNkKTqEyM5G1qbq1zkYXlIo8FOryb/hnvoxgW76vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB10433.eurprd08.prod.outlook.com (2603:10a6:10:52f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Wed, 20 Aug
 2025 12:21:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 12:21:12 +0000
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
Subject: [PATCH v3 2/3] mtd: spinand: try a regular dirmap if creating a dirmap for continuous reading fails
Date: Wed, 20 Aug 2025 15:20:59 +0300
Message-ID: <20250820122100.726451-3-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: d01cde1f-08e7-4f5f-7c58-08dddfe40d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z6u26uVWBCyMmdef+8nJcYxlExh37feC69+/hGUWyct4bgttQY6W7ciFYg7+?=
 =?us-ascii?Q?bdj8g9WIpRLOVdMiFhyvhVjjw88vnfY2BtkN1BaFpd7TTgmHoPncJ/s9Way8?=
 =?us-ascii?Q?x06T4YbS+P68C0+eQUva4MswJGsFj73VQ0l9qv+6hTCz2d8zw/jxbszaH/qT?=
 =?us-ascii?Q?1IA0kN7qsZ9FBkb2LmE/3ZhNBTpZFpawrIPkDWdckLDbnSXmmDmNv/+IUJYz?=
 =?us-ascii?Q?K8MxhcXjER6YzOBV1ZQECYR0WpF/ifMIhd5Zw+pTex28K7CxdH9op3Y4pOA2?=
 =?us-ascii?Q?gkTpUgcaFEligrgLrtv8KdYW+riAnHeGIZiYLcGMnLlQAVr1Ze/cXOkOzIza?=
 =?us-ascii?Q?pGJFeBCY/v7k+QuF1obb2SPZ+OBkKGZoO8ZkomAWAlrt/pJMPtwBcXs4gXo6?=
 =?us-ascii?Q?mTEICZg+5Rdn0w3+edAAIfsly+/At/Pjy9I+SFjyOkhhvB4BCyYBnroYWLN6?=
 =?us-ascii?Q?lSxMItOyOD5Hpp2iU7Vn3W+VfB4V3RGS73iGvcH6gNUJrFewvPSvny/AR/No?=
 =?us-ascii?Q?WjYjkqQc4Aewh/Yq6vfeMipMrYzHWaGazIdQNs0M9wzervTkeTYrm3OB17yA?=
 =?us-ascii?Q?hHQqRlHzHma5jQ1ZLscRzRl0ODVagRWPwg2ENdsgp7J8qHNG1aJK0Zf0ePYr?=
 =?us-ascii?Q?nTIrcKuHyea7+kPW4UBtsW90WfEYbWZq3N2cuInPtoNuW7CANyIgTY4uW1IK?=
 =?us-ascii?Q?ciOC4KG+Ji0R8hi3z7nBKMqZj5cCFTCF+WO4/yZJUm2EzcL3pEMfXFtD6Dod?=
 =?us-ascii?Q?mSjoAaS/QEC5ik8ju17bBLYFJO/d6hQNiBijZs1Gm90E1g3kp8CwvCbFkRi/?=
 =?us-ascii?Q?QxeKTZHzZKfMMs2JZDc54c9It9i9+0OcohSxl+4ri9pz5ywQbRE1A4dIuLGF?=
 =?us-ascii?Q?BsXFqF0iCMk6iu84O/PBMNH9lrO8Ry594jsqz0QYfcbNHPhgZfrB8hUS2sVz?=
 =?us-ascii?Q?CqVYT6CS6JEPVkhdXGWaM9cp7JV8faq5Y3ZCcAXk71H1I8NpbHBY45bDQzog?=
 =?us-ascii?Q?2SL6WUjNesOHJ8Qgnsf8ndF6XJC/2LVTegsofsHX+SXSBUBAZgv0l19HoIKQ?=
 =?us-ascii?Q?zS1LO6uICOZv220mScl55FgkVD6EnnQhGm91/jV5YprTP0YJxN8mZUUTgEt0?=
 =?us-ascii?Q?zWE5Q4QId2W91Hxre78FeV5CJ/rfpiqKL+Bb9jWxXYOSA4icgUBYRUi55jo4?=
 =?us-ascii?Q?3lcJ8HEt98G5XrA0HwmwV7NpBYJCHvNW0dCaeamaWtgXGmzsZ3mecKiFV7kW?=
 =?us-ascii?Q?QEFV7/PBwMLSkv4EU2b2TgFTrDcQqI6KB19bz/Nx+qQogRZYlpgdwQe+z2a+?=
 =?us-ascii?Q?DEQ5SzhGopUgIBhzWaMbhStMCjDnh7VKlxINHEYsG/nb8CffcPwWLmfvu3aY?=
 =?us-ascii?Q?AZ7qAmsaOrb4prhYJHvpdB7u5HrZL4gVfe/xR4zrlwhpadiQgpYR4R/z3yoq?=
 =?us-ascii?Q?GgV/fUiFJQHRsrB/1yTENdprdsCrwKs27t0c9OTux/QwbpvFgsFRMa7nEc3C?=
 =?us-ascii?Q?DM1jASVOv32S5zk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zLgifLRqYy76Eqhlorkel4YTfOE81yjMfSy+9Ztv9QWGlqFJ+1jcGjc4VTip?=
 =?us-ascii?Q?ysmchK8I3KUerE0EAATjA0KJ3uUt/AYxLuHlrwJ8jkX2vwuuOM4uPDln3aY/?=
 =?us-ascii?Q?GtOlr1lWEUHsEA0WnHS9GdpWUraIiOGMjrMvUc1X6mSqqMJk3AlJWkteFRt2?=
 =?us-ascii?Q?tA8UGldQbPQaWLBHsKiciKJFgnM0W027jSxoURlOcEQoTbe1c8q10vY6vzpp?=
 =?us-ascii?Q?NVhtXz60Pbvp+ren49ODr6B3qYYuK8QkFD5bSsCsVF9o/sbLdnTLZ9WDB6P4?=
 =?us-ascii?Q?CV+SjRa5Av/Zy2ZBKaN0tsdPXL2BgGICOqZoi1OIOXEhiuTp3Y9I8NgCVpM5?=
 =?us-ascii?Q?hY81lUUvnqmo3LdUVptxUalos/uzhb2XFreJYoJUAB0BeAkghW5NeaMsG7Cx?=
 =?us-ascii?Q?B5SPfSFq1Z3rmqzPhR3+OFabNu+r1+Mz/Oe+p9x2oj/flWdCFyz/dNISpQ8E?=
 =?us-ascii?Q?rAwetJXtrlzI7Hc2utGCXxxyJIBWg9yjw+AIfMnCcOjB2DFtBE3ZUVRdXvN3?=
 =?us-ascii?Q?d159tiv1GVaOlwd906iVZtPvKaSSSaLYUA0k1Y4lgCpzIYN/ng3h0FmLjWwx?=
 =?us-ascii?Q?lQb+fDnWrqlawn4mTEMf40n7n/Wx72XflkSF9mtEFdx4Fd2zuvbxKKBle4Ri?=
 =?us-ascii?Q?MrKn+3Tkjb5UbTXP3EwnUx/myAFtsDcG2ZC/LoX0zM9FHi8DUZy+A83EbDJD?=
 =?us-ascii?Q?ts3xe28O6okYhPXMbkeY0w5yJu6L/ejjVPkojP5kEpTSrq4x2xg91VZp+YRW?=
 =?us-ascii?Q?jqJjZlrrcGsAlnsQ6w6NxLXD3y6NCNgaMNvaPAkx7cAUOIJDWbQq3dkcC+9r?=
 =?us-ascii?Q?rwrBEbUlRCcGI4C1YYYD1vqUHgqS4wv7KJXVSh/vh96K37f0XGRoCKz1VSN3?=
 =?us-ascii?Q?6W7mcV/vc5+a05TofUNQSOwy8sHmvRXezqsqA9gdE9Gl+83Da2VgwFyXT8Tj?=
 =?us-ascii?Q?IO7qPtS+GIdVnsAqnuU1TCIS5s01eii/DOVhRv5ZdFs8DAkF0JUqUH63fVXl?=
 =?us-ascii?Q?TibFremkywBymtOiLGRpib1ZaMC+L2JFhtKVB7YwRMIpiyZ47UsMRd8yARY1?=
 =?us-ascii?Q?ExwOGiX6OhLDhLwiTAP2EFyvG3ZNHVn+pmIaCrcxzEddsnYfGkEHSohfhTuh?=
 =?us-ascii?Q?CJ4E7bK4Uaui27VonKrMgE5RjqT3/ZfGRlIdcP+P63HnZP0HoXfjl/wow0IK?=
 =?us-ascii?Q?XLztqJ3JPmnGZ0r6H8tX0uhs7lu03A3eF+CnBECkTEC3C0f91+xIfSh7ka35?=
 =?us-ascii?Q?reDK2Oo+9bnfvi77OFY9ukzfsBorAwRW1wq/DhKHeo7vAAA73d21v+Os3Adp?=
 =?us-ascii?Q?PVSDuKBxLNquSY331pNKYl4Du9+s+QcCmRV8uBN9Q6Dzjg4vloUOxXfEmzzh?=
 =?us-ascii?Q?5PnhUbRZS+ttUW+89WhkbCjfIQZ4ZKfMfPrzPI222nNwF5OPE+uEyj6Jq/vg?=
 =?us-ascii?Q?D6SF9ptgxIt8vFnqenqIe/M41U0Axn1aNM0K72B8XjphvNabjTKS9hlSI/Ng?=
 =?us-ascii?Q?HahW8WqI6VqSUchbhA8Z8KAbeWodtGVD2vd3uVAHNevgvs9B+1i+mUsO7BZm?=
 =?us-ascii?Q?eeetK+hZ7vNQAZ9tt5eLSDsCFq9RKM77Q0wLZ4riA5PjTz75PqiuaHdLupDf?=
 =?us-ascii?Q?ZhQFl/09A1pB6+dBSQqvdJw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d01cde1f-08e7-4f5f-7c58-08dddfe40d4a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:21:12.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5G1KpKBGoFU+1n1j5PzdJtYctqjCb5VUypfIRhtzRHI4u1IbF9qwIsbnfikVko1uIR1vCHmozu5PYJC46P14NWED4d38ijG46QbeNnOZ7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10433

Continuous reading may result in multiple flash pages reading in one
operation. Typically only one flash page has read/written (a little bit
more than 2-4 Kb), but continuous reading requires the spi controller
to read up to 512 Kb in one operation without toggling CS in beetween.

Roughly speaking spi controllers can be divided on 2 categories:
 * spi controllers without dirmap acceleration support
 * spi controllers with dirmap acceleration support

Usually, first of them have no issues with large reading support.
Second group often supports acceleration of single page only reading.
Thus enabling of continuous reading can break flash reading.

This patch tries to create dirmap for continuous reading first and
fallback to regular reading if spi controller refuses to create it.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 43 ++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 09dd6e40e308..0f8636047365 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1093,6 +1093,39 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
 	return ret;
 }
 
+static struct spi_mem_dirmap_desc *spinand_create_rdesc_helper(
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
+	desc = spinand_create_rdesc_helper(spinand, &info);
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
+	desc = spinand_create_rdesc_helper(spinand, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
-- 
2.50.1


