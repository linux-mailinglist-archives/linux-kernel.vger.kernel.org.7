Return-Path: <linux-kernel+bounces-783720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CF3B33199
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 19:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48FA1B255C4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 17:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65F327472;
	Sun, 24 Aug 2025 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="HPJjZP1N"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021093.outbound.protection.outlook.com [52.101.65.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2332DE6E5
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756055630; cv=fail; b=DtOstEyAKQlUBtxXPI0JWru7UuQcUi4OMlXqxVkmvttIBBjwbXG1rmOPJ4PjLkWspJK0Eskdz341F/djx3NxR7e23UvKJsm6UNyOGskTQsUZYytkjQLw+7bnYWBytXUacRhjkiOO6u4mUyaTP0KVsXhvhl90w10tNjITz5/aT4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756055630; c=relaxed/simple;
	bh=IKw57o1BtFyBXPbUKoPXcevfM5m7LrAq6E/VSDmw5SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i5zW7jjn1YlE/pZC9X7R6ybARww/imYRaqVXIc5y8caBqOjaGIWmb6k2EWX0xYP0gLdqiDIkt3aLFylDTTzU5mWT06SWg39CNubnqg4GScuqkEeC0scVCnBz4Kxkmi3Fbm9YnIB4jsSzfEDtmvy9H2VNMG5Vu+7IfWzu0Oh+Fp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=HPJjZP1N; arc=fail smtp.client-ip=52.101.65.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZwAOC7C9vUPXRtN12iUBwlykWDG7fmPG0dNA1RUMBAn2kR1Tzr3EbF07RkuL2w/xiC/TO42dXtWq8wSeEVZk4BaMv2/a+rOFz1RvGEI7euGyTaai8BGfidN4XO+p4lZGDh1Jc0aHpPTsrrJf5N6ILlIQdFJpeaFrUtcXlQajBKv6xbXjw0UR38jppIxtowDwb8h3z/IfmFtBRet7JqduyeXgWFWhqpUM33g7z4bCXBUU8QWlrN7dqVViGzW7pjqsVXaxnttudQ69TBvgSVXe8rpl0IfLHh0gVokHkfvRcA6Rv7cMxgvnJQqLnOpQhftQM9MT/m2t8O7CpIg2qFPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHqW31ABLSON3tm5N50WXaj5y1wAdAK/xnXxoGDcmA0=;
 b=LWkn3zzL6XqUz4800dG/xjLAOftR5PRizUzeKnDtsZNCmkWO27Uy7i1ynrN/97k8nzRFT1XCTSuTn5mCBh9Nl9uPQUV6NAmVwWnruGsq/TiMC+WVtafzj3vBJ5D8wAHvxt4prIivQH6919n0GcwZWAh4c+qNridhr/XVZE5qzbXvQ/0UNcxkmDj3zk2ZGDGBtPV16Mn6uFm/Bzyjd550q1GPRyGED1YAoyLmw91tgYS6RrPryQ8P3Cq07EC/VXUqUNEafFhgB190xjfOaFx8gMwARaTTIayM1I4/VtHY+UGly3O6D/8YUHUB+H6i9Ew9gYEZyPXV/ZZxRuWrrXgnTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHqW31ABLSON3tm5N50WXaj5y1wAdAK/xnXxoGDcmA0=;
 b=HPJjZP1Nl44lsCI+150yvg7UMg/TXNhpILN9sRdqneJX8l23ltvXbyarDC5oAbbRNeO7/Sp4ZtNJYJSuVwiyx2Jc8u4LedCgkgt9a+cuhbtXxHv+Sbgb4DGpKtAYjV+QdcL0psOa+Khj/26z0Gbw8HumN8Bpr/58UMDkCRb0gG+/sGOUoiW8ATc6pWv9DSUXgD7tvKyIsh/uuNd5rBpWwcxXdl4V0NoEgbeMT95OA6CEksjltoJiVCe/M5YbonjmmIHOAz2hsLQT2iZRIf6XpRZ8k3itWs9Pg1Z//zo1/6KCs/joEgF0R/w9fooUvPHbcyh/xQf0G7ZmkHTtsPEkWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7908.eurprd08.prod.outlook.com (2603:10a6:10:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 17:13:40 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sun, 24 Aug 2025
 17:13:39 +0000
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
Subject: [PATCH v4 0/3] mtd: spinand: fix continuous reading mode support
Date: Sun, 24 Aug 2025 20:13:28 +0300
Message-ID: <20250824171331.3964537-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <87bjo4it13.fsf@bootlin.com>
References: <87bjo4it13.fsf@bootlin.com>
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
X-MS-Office365-Filtering-Correlation-Id: 64f23d5f-e03b-455d-ac95-08dde33191cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+3JISG6PHYtO2ueIRCFLZ6UABdt6bq9ZAcfTE9/LXPSucVN1bt6UEmxH1YoE?=
 =?us-ascii?Q?oo0OcJLS3wH0zl/Hjwto/0lQzARUCeOYRczJSZGCbH7b7G65UL/vStiETgkl?=
 =?us-ascii?Q?O9YV4M6dc4ue4JhYe9lmStaMfBtTX2VBhAp1MvxY5TZVWyFazBvtBPx4tZfM?=
 =?us-ascii?Q?wwC3oNkfNYlCH/RU5ez8W4ofrzdG3VLwwMOA0/PPJG0/jY5MK+Hl3pdSFTO0?=
 =?us-ascii?Q?YpKfPi9ySl4TPYbCHOhF/FMQJMiOFVxqYxGeO4MTg4i2iPeoqZ9xxpETpFu4?=
 =?us-ascii?Q?ux+nKo1YaJbxPx78bA2xcLL5tv+4Hhj8a30xeomJKuvitFYA8dXzsnXxeQjr?=
 =?us-ascii?Q?ud2DABkLdNOwAMeck/el5nkVde+4NsthOCt7WAEu1uxvqNyVVHp0x+hfpvUY?=
 =?us-ascii?Q?jm0h3bQ01fWvh3i9SgJZQbmCPoRRPo0wkhEfi90uhe59XPJI3+mmxjp2FRNn?=
 =?us-ascii?Q?HB6ar5MME1XfoZYqqp6I2MlZoP1osMdjmFB3qSDGYBAlHGhumjKr4NzZVT/c?=
 =?us-ascii?Q?HzfARPaHhzYXRbfoOI09QuB2l2kf5+sWCAA41OUMJSHV7FcgKQHDhQqmmXXU?=
 =?us-ascii?Q?1NrWUe2ZFarzd2OvDfjPgdR7V51t1PFWhYC3QuCGF2h53E9E9+/tdYVEWbZU?=
 =?us-ascii?Q?a2OddfG7xzcCesucp1aNT21MN8f+OmudOGxoBkoyrhyX4RYqAZk+OH1LSvpx?=
 =?us-ascii?Q?0ZddvOKphZUHEYETHN4AwEvmGeOs7FHF3WK1nSUko0ZC03SlRYfI0MJb6kav?=
 =?us-ascii?Q?bbW16sT+pGkwXsUXGWc9nZatej6A2iEvrMV71oEz4o4rTvzvGk5KHDf1QByC?=
 =?us-ascii?Q?K9nK7GivSgbMxs4Ny8hgXJDuq8SXim0TAHpXTC6LMksWscJnDheAdi4lG2Aw?=
 =?us-ascii?Q?MNKq7NMKdt/Pj4YUxH61rUwQCoLS5vfMroQYkVKN9Xq9KK9i1lbanOkeQVzr?=
 =?us-ascii?Q?9gWTQXR+IN1+9G0OQNfJxy1QyRVZvjpQA3NG1/l6U2MRgmKjxCQNQ5PQGxYS?=
 =?us-ascii?Q?C5LazT2yorOyhMaSc3K7nXNmbNL1oX4pyLWp2Oi20SDSBoPqs3YZlXv/uClk?=
 =?us-ascii?Q?huV7SjErLWmK4eUcGT3WHYktjcmXcck8d8vX2EMVXZezpDDD2qUX5Q7/2E/M?=
 =?us-ascii?Q?XU96kTRNpKVSEKsGVnSprRA/7RVc/aFTgQDdSiIRAZ97sv4Ho78utM9SyWUb?=
 =?us-ascii?Q?W4bilw8nGk+nVfyNKi2S/7ZrxLp4/Y8EH0BDm3HZE0/h0WaB1KwsrAUmXtq/?=
 =?us-ascii?Q?1WztvtxSYcNns5Ol4fBufd49h0vgtHn6yg0Dfzw3sdI1oGrfiTv9Vn/bSrlD?=
 =?us-ascii?Q?UPMrwkXgB44ZUtBABInXrZV6UE/G+ng4OA3fCwHL8dKaqHHiSYVbZfxKt9AE?=
 =?us-ascii?Q?aRtDlyMmPsDKp6hfxp5+UaOEVM3zRWP8zzJYNBapwR+AoveKnWE6w71mlXC8?=
 =?us-ascii?Q?Fl1iRm+x7wXGyIPuPNS9iJbJP3xMSsmH99vrBOT7PNP7o0/n670L9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O5EtJSP0VIZZtCE3k1kcxAWxECJnpe6aG2GN4p7mIUgvNKLY7Sy2Z0v1sZDL?=
 =?us-ascii?Q?UMyauM3ItYg7j++ANozsnzfsyAunnxGHlG3Ti3SlcIMdaD3xDMg93AsElQ43?=
 =?us-ascii?Q?+0OhXQXVypAD9nsbFg9CaAOO/BPK7VM+PAQbe22p+9T4/0SN16UtZfsLZDzN?=
 =?us-ascii?Q?vK0B7Spvtz9jpBiH7xtL+JA/oifdsaKqdY0JDqWRgn/c1y5KvKuRgCov+i4i?=
 =?us-ascii?Q?q2RovXWeVvRRzuL433IWsneoIwUhCcowsz2R6bngEhCypzey/CcaoKO/r0DZ?=
 =?us-ascii?Q?J1KbrAScCAkBWnhYSgKtVMaWttQca+Mhk02qNC2dmic7XrGr6rfe7Rc8jUZ1?=
 =?us-ascii?Q?xnDGB7yuGRQEolYWJQ6MxwIceI+I2yFck+s3zcZ0OFkAIeNG/we27NhdTS42?=
 =?us-ascii?Q?FE6dLGFPvZCOHghbHW7/a9Ouazy8FbkYzFF5MwWyMjRAzLeqRT5IYK+JDeGO?=
 =?us-ascii?Q?jZEt9B5QiwA/FXVFkX0bzuGoLXuk3WRio8qSeF/SlS1fHqBLWwIX5OKufxoH?=
 =?us-ascii?Q?WK1hjsJH5sSZE3UiaD4IDjZQSPvMF9GZOl/uhQD8pquYJXcnt3VRi4uDQ4+1?=
 =?us-ascii?Q?8fqWxseeiIL7OiBgohOKOPsEHiD8+MeQU9egMLZRtOEfRdigillAisB/mFLh?=
 =?us-ascii?Q?JDb0W/Lkjh1T39y+leIvVQUljajWor6ML4BvJ1Kwa+aQ2AIj6dNtcV2t1wBn?=
 =?us-ascii?Q?QicN3gho8F9hB9YKWUIUMfK3GdI8TQM4ekOQTTvj4bBqRENtI8cXAF9qMZ+H?=
 =?us-ascii?Q?uTFVY8bsxMTsgZOSf2Q+hEEMzKaTUu1GF5qv2QPTXi1ppt5GsdTxBbix7HEt?=
 =?us-ascii?Q?h7jt2YIK3XcpS3ViVKlk0QH3/SDbVbV2WAlfneMD9+FpVKD7gWIVWU95y1kV?=
 =?us-ascii?Q?tkqZo8Cfmkyp2QFO2IwoGfhTcQgsP9Q/ojVyGJy+2f1siQ6utNEaahHNT4qF?=
 =?us-ascii?Q?Xeqw0wwvIZYtKRHRV+Rv35qAmLF5SeLP/U+zliJUDELITmpqZcvrfoV8NMK4?=
 =?us-ascii?Q?GOoCMaKNkDHkG00QYh+0wOIxcyZXLSyhc2/cYs1d4SIkdjJUPE0UKBZWTbhk?=
 =?us-ascii?Q?ueH42mZwTDZzNaiqlxX93RB8RLemz+Yfq8i+cYwWLs3+DEqwe8Wp8fYqX2x0?=
 =?us-ascii?Q?2j5HWilfC1/YJSfArG90nY66dzvk8G1mU8gXIrph53xQ0m35u+/TgmXygwIP?=
 =?us-ascii?Q?lJTKnUNfaICa+hN2PRnApUCI8pcE3fjvY3oTSHXZpUPp2X0tjr11kx5ugieq?=
 =?us-ascii?Q?HvmWTvBL4aStIQX3s1K0HrcFz1aa+fTlAcg5hMAoFgOwVBi3qNY+JkfNsRrV?=
 =?us-ascii?Q?DcjWct84KG4NU91Nsr5JvDNUVv/VY9vLeJP9rc9+a6WXRg3t3S+87vi/u4nk?=
 =?us-ascii?Q?5MODmlaDmCvJQ7/XEAmzmElcvEV+05AVpDHtIKLQCWeRz5fnrLl67k2AP14y?=
 =?us-ascii?Q?RmC7ssVYBYkH0B46SiQnSb1bosD1ba+mI3g/WevCLn+7Dml9+Xv7ob8gKDQ2?=
 =?us-ascii?Q?wMpncezlz0wkiFs/2Qf1O1BDrj3bNV/ZtcgLPQmdK5onIfc9d3Wc53cex+mJ?=
 =?us-ascii?Q?Ut/oGEUMvxzKqa8bfb9QiwHXRo+N34Vv14/s4bEmAjaq1epiJE/43hKX02iP?=
 =?us-ascii?Q?q0pUuqpeFWNeb7v/Reg8dmw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f23d5f-e03b-455d-ac95-08dde33191cc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 17:13:39.8217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYdZHT9QcBq/nU20bHgAWDiMjoA932vglSW2QH0au0/+gNAy9w1yT9FXTcX/Mh6n9kRFjTU4VYLKEdWmY9jim45SUSeeKMIuscX3xTESQs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7908

Continuous reading mode is broken for some spi controllers. There are two
possible bug scenarios:

1) "continuous mode" flash and spi controller without dirmap support,
   but with restriction on transfer length in adjust_op_size()

2) "continuous mode" flash and spi controller with dirmap support for a
   single flash page

In the first case, any read that exceeds the limit specified in adjust_op_size()
will result in an EIO error. The limit may even be less than a size of a single
flash page. In this case, any read will result in an error.

In the second case, any read larger than flash page size will result in an EIO
error or spinand driver spoofing (because the spi controller driver returns
more bytes than were actually read).

This patch series tries to fix continuous reading (spinand driver side).
Unfortunately these fixes can't resolve "spinand driver spoofing" case.
Spi controller drivers might need fixes as well.

Changes v2:
 * added helper to create reading dirmap descriptor
 * fix spelling
 * error code is not used for regular reading fallback anymore
 * it's possible (but very unlucky) that someone will do raw reading
   of the flash in continuous mode (i.e. without OOB), so fix dirmap
   creation for that case as well.

Changes v3:
 * improve description
 * move airoha spi controller driver fix to a separate airoha spi fix series

Changes v4:
 * the period '.' at the end of the commit title was removed

Mikhail Kshevetskiy (3):
  mtd: spinand: fix direct mapping creation sizes
  mtd: spinand: try a regular dirmap if creating a dirmap for continuous
    reading fails
  mtd: spinand: repeat reading in regular mode if continuous reading
    fails

 drivers/mtd/nand/spi/core.c | 88 ++++++++++++++++++++++++++++---------
 1 file changed, 68 insertions(+), 20 deletions(-)

-- 
2.50.1


