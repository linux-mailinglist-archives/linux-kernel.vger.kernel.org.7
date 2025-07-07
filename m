Return-Path: <linux-kernel+bounces-720126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6387AAFB769
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B0C1AA3544
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C59613CF9C;
	Mon,  7 Jul 2025 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yp9tUfl1"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010029.outbound.protection.outlook.com [52.101.84.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72D3881E
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902293; cv=fail; b=YK7B/604m+4+CKA4jJDmrDHUBVasINBIz9CyRzBlLjp0XYUPAAKan5mEtf+ZxeF61cuXXltac2OxVlHvjA3/uqErwfuXCVC0wbcDI3FOZvKTc48JFWuuNyXFh4TXD/nrzGpUYeI87Y0d8MntDo1Z5qPNxf16H61tSZI5cO+uFm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902293; c=relaxed/simple;
	bh=whuIfdvBpChwalTYQpbKErXDFa+HF578th+AlfcFjPg=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=s3OJQsCjfk3G+wTKrCCiYaWyA0Fj/MmanFSKGEXhKESOQbqY3E5StDDXdEmcBlDWoQ7y0x011it7s+AnbG/9xP7A6AflDHQpkHlm1C6lICJ6qYQqAwQhLltKl8hTRFsnDim6hgLE9KSctrSQqiuEyRZnukHuQCCx19trNgFQN1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yp9tUfl1; arc=fail smtp.client-ip=52.101.84.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+L5sjnHtjrpbNpOhLlURQ0QgGzNGcDGHre0Y3UMCeWcSTHmhChhc8p/TcsxLvWC122YZghwrxS/5eDyfm4vA1IDgf0cXRxNLpMSRV81ZZ8oB9awzgyW2Jj2JYjkA+D8TLNjj8d6bIX3uWdD5eHMEQ0eRKY+b9pJrL16svLEGHHcX2BLuLKQEGredxf3WOff6kbZWdNgSzGfXQ4FhIf2vUMJnLpkmEUtLn2Dai8hy3LSOTuD7862xMbERsduPrttSBpMBw0LLONJrXxlC8Sa5HYMzJ9aFn/E0YgcyZlptag9k2ZAaZQkAQlqfYLpOoflcdrDH4arbB72U8phwGGB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVPfhF61PsF520HB8CSi2ou86b7V5AJlTAeCotQWckA=;
 b=cPelwITQA29mVQR+f6ZOfzXbNsiVAqrQrrChVtsFlEMSu6lNW4jYZPzsA9KPAZphLh/ROpW9FjXu9rS1xqAcv/9ArGVqg3hjqq5F0Z6SqO13XfEUg5Zcx+QANa700AYI1yp8a+GRw4SLJLKlNKfDzUpxvElDCDEPiBUTPHFqfyYUXxSMWD910KYyeIL5yJenlwyjtNJ/FI0Mda8Nq1rH04Jy7DBIuyBrr0NAaczUukqM1JbVWSDbDJuxMJ82yOUbA9/5sSgUGcW21MWkdEZdO8OnUiZP8LyKDRDfc8V6+RBXmj9SBG4IQ7WWDNg54uVjWWHI1CSrgPUEvJjb0OCgkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVPfhF61PsF520HB8CSi2ou86b7V5AJlTAeCotQWckA=;
 b=Yp9tUfl1CQrAgUf3/IHZPTwJWPuUl7DNRuZHZ+HWtHDdKx1JFh5pIdpxtOLsJHDrQP6VfSKl6l3QP8LcqBa8SiDIXDDga4PhriEqgTghlvC3g3Hgpzyih3Mkd3I/cl76G3k76wbOy8pKfXEkVEJmuVQ2aEl8S59eNWowsEI6s0G5qXGIcKw2/o9MBFJj7HRTOaA6V8gsu0fk/m9LRD5TdQ2VlBG0l5caIkBhsSr3W4AfMkc354hbtLjLqf7WNLVUb0bOygNJmolcUQ+SkW+W8pMi/UsFe4xpQ3SsPBIlremvCM2N3B90ds1fg/2OiHT/8OjjAf7ZUtol9pyy3J6M4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by AS1PR04MB9335.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Mon, 7 Jul
 2025 15:31:26 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%5]) with mapi id 15.20.8880.030; Mon, 7 Jul 2025
 15:31:26 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: simple-mfd-i2c: add compatible strings for Layerscape QIXIS FPGA
Date: Mon,  7 Jul 2025 18:31:20 +0300
Message-Id: <20250707153120.1371719-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::11) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|AS1PR04MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: e22a1115-61dd-407c-c6d9-08ddbd6b5658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pBrEcnHbg8lSCsGO4GsoA2dyxjt0SOoRpXhE1HJGDWD39LbsSHeEHw699eZH?=
 =?us-ascii?Q?y2pBq2k6DXKa3+Kd+dbnAR2EZgQfZy3+9CERw2tIIRKRjKn282WL9hOA4llr?=
 =?us-ascii?Q?/pl0oOoEa5MObdgcuAz8m83kf5Yw8//cwkV0Dcu5Xfa+d/tKQ8ATkytu19MN?=
 =?us-ascii?Q?Q0J88Z2IRM7qUEea3c/IrvEpH6QMvfcN8jznF8UbvwCFJSoGIaiHzdS6EIAD?=
 =?us-ascii?Q?DsKVckAgDO3x1XP2xqIhdb97+/nw6Y399BwOusscPAqJoBWwLuzO4njECX+u?=
 =?us-ascii?Q?FftXZK/HtrQecGVXqEl0UYc7YRpsqsKnNyMhHvD6XTw52Mn0yxZh4g6HrhA/?=
 =?us-ascii?Q?0esTonamzrSwLpVlqm0ld1MgtyCRghOVyjQvb9E3mI9jETl7NMvJ56GM7H9+?=
 =?us-ascii?Q?xE0gyO0Qvs4A6/gZO/+moM0xj9fa5KU4+0ItRSFKT1edCKUnQIi4mA+bN+kq?=
 =?us-ascii?Q?qvxyG3hXp9wOL5WbCimeuNsXo0qH4eh/XTLCB7ltznILsA8X6A928VMLH7+f?=
 =?us-ascii?Q?JbLAQq10/5Rzg7r6E15WZToP25835q5ZclvCPov13KQhiqccWpKIWkEOmLft?=
 =?us-ascii?Q?uZik2W6BOyd18FSDa31RxUdbU1yeMkI0+u1FGwDC8Iyypld/Tn7EbyMEd1P9?=
 =?us-ascii?Q?GgIhvYkb3RTQ9nDIvftMBc39S667ePjVmXj2oZq+5a+yMiSxT8Ajvtigufa9?=
 =?us-ascii?Q?c1D2qI86xiAFK/zTTOeBlgZG7RWLliUraGTfulEqsy1uOfcUuvj8l7M+RMFw?=
 =?us-ascii?Q?vvxQeEO5q8k2Ov0b5UIn6yfPMzU5rC1jA53ibwrA1UCjS2QVi05i+lzhIsP8?=
 =?us-ascii?Q?HEncEUxhLlj6GMHrUPacPBQLLUt4to/jfaRag4Ko1bMjb+4xVsKzVU5y3Fb5?=
 =?us-ascii?Q?4DmoicbV2vyvl3c+nPe4V/rr6PY2xIgvSrftHrp4CMf+EN1HusVOGvE90gnt?=
 =?us-ascii?Q?tp0iWU7hznovmeocNTalIlowYAmxjt6WcPOfOg0ne9ox8m3sUWmNued2LKtK?=
 =?us-ascii?Q?SHfmvab0jHp9XCKVw4S/6daEqcmxUwx7PUP+JklOoYzQM5sCvM2cWbBMYiWK?=
 =?us-ascii?Q?cyNWSoHTM7ARf6GaQzaKIgL0QX6U9OdBId7mNJAy5yTd9/b2+ikCiZulRKW0?=
 =?us-ascii?Q?g3FKqCBDrFOIAZMjPtw1Se0LLRmrWXn4Bfo1KFer8W7mDeBdRnUQ9Fxdya4Z?=
 =?us-ascii?Q?9+RUb2R0N9quM9LWw6jX1MbWEgEriv62xpjkV65BC1FZAJBwY2rjk1/jr+1h?=
 =?us-ascii?Q?0GSByXDOmDm7o2y7nYDRsc8LwWUUzoV46tSBXIzcs9Bg/iM4t3Awt6+1nZBj?=
 =?us-ascii?Q?mXsZJgn7UtVXVopo2X+9PogPO5TaTTN5G03agBl4c8WQ6ryVyEWSl9UXaOwi?=
 =?us-ascii?Q?+FQ4lDxAr2y5CUFBVDrwRXkFxzotmbmXF+Y9cmUIz60EO7wTMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NmkfuOlMuuSwsw3OGLJikyBjqrapfGNBYNJkI794ScuO0avompC+OsOjNfS7?=
 =?us-ascii?Q?oHw+k2fCnZ2ya7mfcYG79VyVnSbcXEVeoMzgnQfed0i6c8u6boskZ07/xBrv?=
 =?us-ascii?Q?utIj2e3uw186ee2dz9RmelsZuxqzC/Xm0zZMl4xSt9wJp0oDQbxErwMLMKKI?=
 =?us-ascii?Q?aCUHb5cHNHaPeSVhKhlywB5j+effePRyz4kU7dn+8CLCxK8CKo3ft0o2B6WP?=
 =?us-ascii?Q?bOlRYz9mMLY2eEEy0CIbowzHYt/8RCjFO5m7tdNoq5+bdelc8qOz0k8S/OYR?=
 =?us-ascii?Q?PuNH5SYKjSFrc41GGUyE9VBJ/8nDu547PjcQVSgs2G1RSlWJOL2SU9CMZ/4/?=
 =?us-ascii?Q?yVWgrj8Vnw66p51BlD4Gw9oIeHq5CU6VEa+0I9lHPiwX4623oJfX9+r37ym+?=
 =?us-ascii?Q?MQQMzEQlFXGcoFfHqEa1qZs7ZjNRHdTQFYTrl9htuvwGwVhLX318iswaVrjb?=
 =?us-ascii?Q?rg4hDDjAyPPnrgdWq5c6yc4VPDEyKpR3+eUNtT2giCfFf5SxufQYu6X0P37k?=
 =?us-ascii?Q?tpvP58bZ+zgGTnYUV3fLcvaVp3oYjAqsbdmJbqqZ7qMzjowF7ll0nOBjF7NH?=
 =?us-ascii?Q?5LTE99RVmjouJlD3EavgFAYx6JmGnsqzvlJ+0Il1n32ebMxru7Rx0ZFFAb/X?=
 =?us-ascii?Q?I4YGIMhgSlzvmar/vxWnshXRp1dEoA6vqXl9kceDANpmOSqE1hYTjm+ExzEx?=
 =?us-ascii?Q?B48BSvqnvoIiKiiQuy9cZHN/4h4VvUS+77gntUVCCQKE3+kK3poi4gt2hlAb?=
 =?us-ascii?Q?02DNaWDGaJRwTSrPcklbBapYAFDlgbJowyVMddpbVWjkNMgJR9Erq+7+5jx2?=
 =?us-ascii?Q?1hZYN3XgVVbPBOfaZjVlIAY0QiGpwYokDIuj5f83rgTZx5Ko8rBCRfphGy7k?=
 =?us-ascii?Q?G+i5RvTL3RTYdJYFGKu1RUR0v3OAcAvyxGwNnk+ZU09O0Mgc76L1rPxMCfUK?=
 =?us-ascii?Q?dAZyYlKRol7f1OyIM/zm91XGwqJynQMXY62M2fbMal1XlKUZo4TcqlzjLqsL?=
 =?us-ascii?Q?67TnqifOGUk0wK/N1gaPUIIYA6pljA4rkhKHfjmLAf4cLH/Ca0cPb5hUMBvX?=
 =?us-ascii?Q?hMa7hCtCvpaMYaJBF6tom5GSEWqlmb16eZjxgrG32FV4b6zTSOEqwn0OQzSC?=
 =?us-ascii?Q?bdGhNt9IjII0SDRW128xbkjfKc+7bqThO+vCgVIJy/W+2A6F4Wl3TyLZ2FBm?=
 =?us-ascii?Q?nKUXqymUYwgwbZ/aFBC2Jc3uXHpqZ5JCsHHhnLCsSb1czxSwQPUUbJ0n3DQK?=
 =?us-ascii?Q?kzoQIdPft4BSHpFNecA5AtG6Zqy7sVmBG8H9TDyr2NIuAFoKJjrZTU81vPh8?=
 =?us-ascii?Q?MO5YNeRVbTSHF7aW/XMa2cWCLzlTJoYd7b3r/PlEUN3I3vCTvF+qIzGY3dpR?=
 =?us-ascii?Q?HS2w4rEJMBNL3S5pW3ZWAeAPLtjMq6DIObRB27NzI/hEL4+JYASJStKSYMtu?=
 =?us-ascii?Q?iNHWxqZ4Q+NIo709WRn1k3LE+dxjMhj01iFlpOmzrDuadR8s+P54hYAxVGgK?=
 =?us-ascii?Q?Nmp0/3aeADV9tbMoOo1F901VEf/eLgObKlplAcL/NZCTgPMXim0q1t5Nb4yt?=
 =?us-ascii?Q?hm6MQkREQ4Gg7t3MtpOxafEz3Cs9oBZHTYtHnVDS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22a1115-61dd-407c-c6d9-08ddbd6b5658
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 15:31:26.8265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfjLUh16fjZtAoHhNDZLYu+WbdrS8ZFrUKvN6XTKngx3eoN52rtIsdmeAmXOgCjuQDiWT8X8jUySHHD3GHbJvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9335

The QIXIS FPGA found on Layerscape boards such as LX2160AQDS, LS1028AQDS
etc deals with power-on-reset timing, muxing etc. Use the simple-mfd-i2c
as its core driver by adding its compatible string (already found in
some dt files). By using the simple-mfd-i2c driver, any child device
will have access to the i2c regmap created by it.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/mfd/simple-mfd-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 22159913bea0..f7798bd92222 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -99,6 +99,8 @@ static const struct of_device_id simple_mfd_i2c_of_match[] = {
 	{ .compatible = "maxim,max5970", .data = &maxim_max5970},
 	{ .compatible = "maxim,max5978", .data = &maxim_max5970},
 	{ .compatible = "maxim,max77705-battery", .data = &maxim_mon_max77705},
+	{ .compatible = "fsl,lx2160aqds-fpga" },
+	{ .compatible = "fsl,ls1028aqds-fpga" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
-- 
2.25.1


