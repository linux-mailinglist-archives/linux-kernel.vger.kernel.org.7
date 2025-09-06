Return-Path: <linux-kernel+bounces-804237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E261FB46DFA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6EB189063A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95912F0693;
	Sat,  6 Sep 2025 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KMlKKjeh"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011037.outbound.protection.outlook.com [52.101.70.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB662877D0;
	Sat,  6 Sep 2025 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164890; cv=fail; b=gmYemHZFExmjR4qek4Q5mmiwKGIf9n2AuYKcN/BMWye2Xq6eTR9zGK6UzzdwtOzSzDQEZgONbuLkwokJ3OpzxkVhm06ylf4Yp6bjvQ6O1BLi5R2M8Qygu1obnt9AHKLk4iKCZKeupcLlhJjAVN+QLPk8lajulkWvJrQKxfbxBu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164890; c=relaxed/simple;
	bh=yWIqZlHiQzjLGQXb9+5BOsvyKr46N+X2ozqoTqq2Hoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AcPavEA7Mb/evpJEiZ2lxTXSx8wuXO0JAdcMX8X6nuBVW+XN0p7pnVjd7LE2HQDiL+jCxhnSmD+nZQUfuQ1p39v6UxKFzigoXakpg1MByvjYb59oZyto0KMaNbiDsqvayB0BFIsLD/LOYCQSfKoteZkybsYk8OtLIXMo3Ua2E1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KMlKKjeh; arc=fail smtp.client-ip=52.101.70.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXhHVshjxLIi+d0rpS96fbPOEF7rXLcesz6zgj28EImkLk7c4/XPk8YlM7z8sdQR1n5L8D+RxKcFTnHxpszy3Il/uOTqFhvDYtfcr7YU72n/S7g2B5MRdi3SOa/gSZVbUor9IGDaak98pZjzr0hXW6hQTPyAPDA/EZE5BZyXkacpJyynVaIsep1lQu19b/zCpKkQSehZzdvbvCdy+is602+WuK2qScI5p+b0RaMuoOQFvAMlEbIDYo3ng6nevfJz7904fyHqFlJ1c5p50LBcc8oyv5NTGRGA/iSl0KjuwtfKRmG2vgigaw1cYPqyU943qHRMQaFg+WjRL/vUioIJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32BGebImINYcrPc+Aooy1umDxbxy78s1cEToN4QuUPU=;
 b=XeyrmOYFWFQ6qRppNgff1kVRLir0JJPO633vHi35kZwUi+oZBO203G5J+S6Mrr34xiDMmNA0PVkZINP1PVLnWTGUBxZKDeKXiTD+cR25mXS1/1y/PdNn5r1MNB4T6AFs2jhTE+xKdnghUiwGKlkINAEfWHtgQNRYYWwEKsGYkzghwLac1Gn1kfgTQp8BFrqkj9VndcxQUDYKpyCqE85oI2INLIXIH71vvYIbzJLSSJIpYPgd1jYDJmEwktEMG5WA5ZGsEzJ9Z6Cu+q6h/pPthWxQ53FftipOi6iEyTv+WVCtE9HBvww7NJznS92vwFmf5YHOyoI/bXOlt5Vy3pm3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32BGebImINYcrPc+Aooy1umDxbxy78s1cEToN4QuUPU=;
 b=KMlKKjehhus/6c8gLl5AGrNcnflNXEPHuYpvtYqYgOT3AA0ekh01daWMnw6ZXRa4096mBzNFz9xQBo/x1HqucDsJEPtkaUnBymKPMxGlhKzms6B6BZMzKJW9sfV1Ey/2gAJhzAl08cWaFdmKu5mk9j6TcDs38Qr/yvMNzX2ac0FCxJAYz9BEtbq9pDRpp/odKrLSrsh7+yscVXUmzxqs5fiubYrEpCRlSOhFG03Q1ruj4CU2ibvDdR2eht4/c7FFqptMFXfD+A1UcPCROTb9qxj+LRY+sAHG9fRatRjoL9k58OmBIFBJKGEULLFp43LCKmoiKE1Nfq6zBwu3inFJNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8056.eurprd04.prod.outlook.com (2603:10a6:20b:288::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Sat, 6 Sep
 2025 13:21:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.018; Sat, 6 Sep 2025
 13:21:21 +0000
Date: Sat, 6 Sep 2025 22:32:40 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Andreas Kemnade <akemnade@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alistair Francis <alistair@alistair23.me>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] regulator: sy7636a: add gpios and input regulator
Message-ID: <20250906143240.GA12656@nxa18884-linux.ap.freescale.net>
References: <20250906-sy7636-rsrc-v1-0-e2886a9763a7@kernel.org>
 <20250906-sy7636-rsrc-v1-3-e2886a9763a7@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906-sy7636-rsrc-v1-3-e2886a9763a7@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGXP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::23)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b5d78d-49ae-43ad-4341-08dded484462
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IgEiCyn7ggNzLcv9AYkqghYhKm9n+PKd2SOEfaEdYpoAde9HN96j+RKuvbDF?=
 =?us-ascii?Q?URMY426946norr0W/so2a0H3Jb666xbY8NR3Cz49oUs64aLyb2jLC9MfrqJL?=
 =?us-ascii?Q?0JuvZLKDjerUiguDatNGajgtUZGvXrJj89VF/v0nASNgRVsnQz/cyvLNnuSF?=
 =?us-ascii?Q?Nfj+CgziVGXJY4T0yZpLCQT5ayQfpBTUhuyLSLJ9fov6bIfGtgpeb/jmvFzS?=
 =?us-ascii?Q?e3GpP5o76H6bgznTb1GSLA5oMwCRgWSrxWRbINIGcjkexDinj9fdjzUNlJIa?=
 =?us-ascii?Q?0VzF3gZKjPWhA7JdInvJTwi3daCDPGbRYVHndwge+CW+WlwJraeJsq+p7+7X?=
 =?us-ascii?Q?548BKskrfbuZ3eCnGG4XSx5ui33cAu263Yr8IJUBiNqHY5hXJ/5J23BM8nPz?=
 =?us-ascii?Q?5rrLu5GWbGcFaL5xYq+Yk/mGhvZAA9GLc5pbNArhQEybIthpEaYDBWis4P+q?=
 =?us-ascii?Q?QdzNUTkmimyCyeEqCnrD3GcoqMJ9deS5Asiq+ton2YJAy+dwbPPDJBDIORUM?=
 =?us-ascii?Q?ydx9JC7vG/cRWJ9WS1hREF8qDpDud7Bpurrq/pacjSgYo2JBypMGSa4GhaF2?=
 =?us-ascii?Q?Eh4wMh+4jj9610V63y0aoMrvKQl+ShZ2w42oWsYs4qYOb0xmGAWkUm/DY7c+?=
 =?us-ascii?Q?C/3kZBbHanw1TeYW8A1aBaK8lGGT8eORlncVygBQpZ+0HZ6tgqBFJUVtXeP+?=
 =?us-ascii?Q?9KGwyAwUuXQdco4ZG177++gIjsScpGxNSzPNMbaT/1UojV6RiJZAHAsw+WB8?=
 =?us-ascii?Q?gm7O+TdD/ranWEWKkKb1hidcU2u0VQtdVNSpEwRb+8dskTmL5L9SduknUZuu?=
 =?us-ascii?Q?pDf8Tas6malMtSjv16i11Hrw4T4LZgUVij00HRewyBMGTZKbLkRXazmVFpkb?=
 =?us-ascii?Q?ABx2ibXEAooSLKa8JBE5ecHYgG7Lra3k6svk0eK2NWnzkzLFP9FqXYds+1D6?=
 =?us-ascii?Q?HfNYLFnW+y1C6LtnvgG2XUTEV6e4vErsfGKeLRVUTmVoUD8V7Z8NBs6IlpQH?=
 =?us-ascii?Q?o+7wgkUzeQZyDHSLnj5YeMcKZKWGurx2YH5zdkvjsGYxhUO5g2IMj/q2Guj5?=
 =?us-ascii?Q?8BveJ7+WjoXmOo2uUpZydCtBXKoeH8E5Js4dfMoc1NRYwbZZx6lOZgcakGWm?=
 =?us-ascii?Q?iRIgzCqpGOgN4O3bqX54r8LewDP2MYG/I0yxKSOB+3cWe3EyqPOxxeqLxusE?=
 =?us-ascii?Q?vhpkh+AsrSlDiafP8ZUIGI0c1ZydnkLoVqt/bSsxuxGVMDrwEfgOrPoQHnOw?=
 =?us-ascii?Q?0uT++x0OSTq0MDn0Azp/o74oebIO58KVdpthzfyvBQ9LwZd2Jlrl/wrKF8gV?=
 =?us-ascii?Q?ixCUUNalU1lD9TdoX70eXTed7FsyzTKVkOEA+qSZK9cZyXcVic6NeEhkOImp?=
 =?us-ascii?Q?mPc/S88glQTRfrZRwgAauvXy7dUCZDB0W4VLuxzZCWONWlLxfw1VOli0rFVb?=
 =?us-ascii?Q?2ByKfY/vkZGKATL3C1/AsUH3AymCqnx0gg2yi/ro96xMjuTFeESYog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LBEygINxYNmmgu2EMEQXRkjLt29ARloBfCsVZL0LU+UhZro9SCnSLrwZuPWH?=
 =?us-ascii?Q?t1pYWRt9omgkP9exXHi1OV97K7XDjMibNwBlihtclDKT+Eeft7ndMDueh5pi?=
 =?us-ascii?Q?ddRH8qiaiMNdGfs5/Seqrtnotrk9nd87Co19utf4zva5EBTOe0xZV6ozgWWK?=
 =?us-ascii?Q?rgCPTPXgCWmQC2oCCkR5U+r9IHGoZ1OPL69bpfwYelaZyiBRaFLxFmWsg8Ra?=
 =?us-ascii?Q?9BvXMWjmvsmtSWMVvXRsIcHoG2p7ds1/4+uS5AM548JXqjAarWk/bOzQ/SIU?=
 =?us-ascii?Q?GN8t40uec9jhrIW7/mXFkhv06potaRXkH6NdQLIJ+PaTouoKQgXrXSUoS3aT?=
 =?us-ascii?Q?8K3hBQCEhZqIkgv374yEOC3CDExjjlNl4x9IRVCwgSKg/y21nkrcL1w+pliv?=
 =?us-ascii?Q?lHoSvM88bCKGyyNDGFNIe69CaJQyZAtbdwAtMKP/UVDGfFJLLza+fo3ORDwP?=
 =?us-ascii?Q?3Bn0UGlQqAyvIEZsXWZK0LiT1GypSjPVgHuKnB2WLZPSt428SRxSHr2bMHH7?=
 =?us-ascii?Q?PLEVzK3wAXZVgCEUQ1dWxIajlJtdLV036KpXTBe58b/VrXWckEVQSiHoQNZo?=
 =?us-ascii?Q?35Z2ZJ2ujL3D7J4Zv0N9Tc+xCsb3EyUtmU3Ns6y3IZ/OA3Nz5IeKE0UomZvJ?=
 =?us-ascii?Q?n1f6wph8CjWvsar+SLFZh1oAWCyE442Q9lnz1R5zR/7RT9EYbaYbgaKhD4v3?=
 =?us-ascii?Q?vQhm3GYuL1i7ucL6zgvj58DMzG83UEdB6dYJafIHZXRNMUJlE00rUiNhHZ2G?=
 =?us-ascii?Q?hk7B/ezwfkEEo4TGGEPORCGe/JB5QNYYXPr8yg05gMBa0aqVjPZmuP58+Jbm?=
 =?us-ascii?Q?IyR5LUkZrOWEhzSVKJUALYEDjnDrk9w8ttZyB9pNsa6xRzGE4+9VCEfBxaIV?=
 =?us-ascii?Q?Ef05w5iB6UaZ0HCzNz5iaJYKEJXX0SfTeHU2QAM1GmP2EzVEbPaahfJZ0ZYv?=
 =?us-ascii?Q?t0dOa6Vg05tHkH3rfKV7d9n9oarCs1rv/lMdhHXU3D5IhZ4kEwaVnzQrf9mP?=
 =?us-ascii?Q?1UZZNiXfZulNiIjGo95j/3qScYOkBqFrpNEVUgxCIgbtRsPqVP9nrw52z7RW?=
 =?us-ascii?Q?43lTr1uEWqbq1mBObsm19sQWUh8XvaZgPMqLgtkv4JWm08r4OUvwefITUYxD?=
 =?us-ascii?Q?dgsAoqo64Z6bOVY1S2HSasJxIiLuWR+p1SNgo5hsgp9B6cKnLhz0ZsNluv6V?=
 =?us-ascii?Q?4k+bSypOR5rKKqL+Km68n3sx5FruM0mqpinf4DGP2V2LH0/YGqbuJTfF0og3?=
 =?us-ascii?Q?hreoLoChbFds/wdbP+3ytevDi1DsS9qdPSWXWMbfOLss59rJIPoWD9TJDGBh?=
 =?us-ascii?Q?r4iAoGmMU45SzYJsYW4bLicTIwBvv2OvFI9V5NEz3fv5tQgvnegIPeNeWhxz?=
 =?us-ascii?Q?ImPHDh6NjdehhqhxEULmm2CefEtYJdvPp0IR8194BYnWlgCbT/KBWwnhqVqP?=
 =?us-ascii?Q?oH0YBSuS1CKGeZ21FqCPi1qXIKd8BlDGakJ1pdy+78iY1MtIxp4stdAAmsGo?=
 =?us-ascii?Q?BekTObKJWfe64WqsDP8NLmwefqtrgbeUrlGwLQuBT6824JqOUXmVM4SikKRH?=
 =?us-ascii?Q?jqozlbqpgdRrQshFQc+1ZrdE+ecUdX3VJOcBwwzp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b5d78d-49ae-43ad-4341-08dded484462
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 13:21:21.8890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNsABBGVR7sloh6dftYYxAtU86JAJvhNOTbB7ne/vODihI8AjXwBEI8VLaydWwyU+903EqInZEQKsqkTU5hgNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8056

On Sat, Sep 06, 2025 at 11:09:14AM +0200, Andreas Kemnade wrote:
>Initialize input regulator and gpios to proper values to have things
>basically working as well as in the case when these things are
>hardwired.
>
>Signed-off-by: Andreas Kemnade <akemnade@kernel.org>
>---
> drivers/regulator/sy7636a-regulator.c | 26 ++++++++++++++++++++++++++
> 1 file changed, 26 insertions(+)
>
>diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
>index 27e3d939b7bb9..bd8739624c727 100644
>--- a/drivers/regulator/sy7636a-regulator.c
>+++ b/drivers/regulator/sy7636a-regulator.c
>@@ -12,6 +12,7 @@
> #include <linux/mfd/sy7636a.h>
> #include <linux/module.h>
> #include <linux/platform_device.h>
>+#include <linux/regulator/consumer.h>
> #include <linux/regulator/driver.h>
> #include <linux/regulator/machine.h>
> #include <linux/regmap.h>
>@@ -19,6 +20,8 @@
> struct sy7636a_data {
> 	struct regmap *regmap;
> 	struct gpio_desc *pgood_gpio;
>+	struct gpio_desc *en_gpio;
>+	struct gpio_desc *vcom_en_gpio;
> };
> 
> static int sy7636a_get_vcom_voltage_op(struct regulator_dev *rdev)
>@@ -98,6 +101,29 @@ static int sy7636a_regulator_probe(struct platform_device *pdev)
> 	data->regmap = regmap;
> 	data->pgood_gpio = gdp;
> 
>+	ret = devm_regulator_get_enable_optional(&pdev->dev, "vin");
>+	if (ret)
>+		return dev_err_probe(&pdev->dev, ret,
>+				     "failed to get vin regulator\n");
>+
>+	data->en_gpio = devm_gpiod_get_optional(&pdev->dev, "en",
>+						GPIOD_OUT_HIGH);
>+	if (IS_ERR(data->en_gpio))
>+		return dev_err_probe(&pdev->dev,
>+				     PTR_ERR(data->en_gpio),
>+				     "failed to get en gpio\n");
>+
>+	/* Let VCOM just follow the default power on sequence */
>+	data->vcom_en_gpio = devm_gpiod_get_optional(&pdev->dev,
>+						     "vcom-en", GPIOD_OUT_LOW);
>+	if (IS_ERR(data->vcom_en_gpio))
>+		return dev_err_probe(&pdev->dev,
>+				     PTR_ERR(data->en_gpio),
>+				     "failed to get en gpio\n");

Nit: s/en/vcom en/

>+
>+	if (data->en_gpio)
>+		usleep_range(2500, 4000);

It would be better to add a comment on this delay.

Regards
Peng

