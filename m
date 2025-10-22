Return-Path: <linux-kernel+bounces-864963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C433BFBF7B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63EED4E93A7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F0134676C;
	Wed, 22 Oct 2025 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FLlJWJlU"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E797348441;
	Wed, 22 Oct 2025 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137485; cv=fail; b=lPgU0FnXVY/Me2jyOh43veZmE/UKR7400RwSJ16Widas091RCZZGoGjL8BKANTty0guXIvJ8HebPn3PA3Iz8rjwzpY6cvv1gxY9X90HomgceEkJo132jIQ8nCzQ3bEUs+vD96axf45jnbQKGERmEin2+EL2Kgi5jgCl15oAkjio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137485; c=relaxed/simple;
	bh=OrKv3i1Ag20eu+0RVgdJP0iZJQfwR8TDF3IG6jTcCzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PiY/bgxGRT4xM9zqq75KfCPO5x/f9Qh3IMaknWmPIidwoQVbdE0CdMYodOUooVF5WLKFzxwze4Y54c2GIkj+C/gfJl83nVqcJirwmoyWKPewGyuEVrruvGWnSy3IfenRWK+sSTr3GYMWi9LGdb/NYbEh4YQG1n5TdKDJD8G4foA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FLlJWJlU; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRCmseK+ORqp4drODF5Ijjzo6Sk84BtFT0R3sKJnGjBNZjUZ6zEOu2I7bREcov5fzlfcOLJOuN9hp3bL4MwpgocIP8MYVnSd+L86TYVK9p4lcJjsXUc6flG9vBApcHK3Ri3p6XKIv7hi9Vx4R3gBNrGyPi4kVNeMI7K+DHd6droDkCY88EmOzqJSM/a6fgKf7yy1YUb6F6+GdkcFlaxUOKQXBGHdbtg5Qstd23xe+z8Pf1h+kRl0/kfDYsT8rnb9l9l7jwE4uimgFD73vMFHtjvR/RH8DyFL2Yg9+3Y5ASqwVGS3agxv/hKNbCUFJWHHa1CJ7XJb+m2zUt5zNKwodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jT3lDddqMFsc+6SHYoQRSzE3tFPv0MjuNQ72aOttWFw=;
 b=lPngKPHFo0Suzfxn4T4XL7uZiFsw4AvqEwrBWgSuHDBlr6q4hwwT0iLiJauO3q4TT9fkoqpk5HQtFRZOicCfgOK2f/R1WmweAPAlWwbyxXsda8aJ+BowkarYSGUUGBpYiYS2sy5izZkRahPeyZAdzID5Duoms7K8UoLb74aY2AV8koYGt4yWiKIeo2P4VYiTX8MbPYk2LV7v25MtMx1FfmVFTScMDx4lYjxmYXMWh8icLXTNTKUrbkBJWCmrauitsF0PWQURszWTGEojIJJoRzlPv2AHTPhCWzZ/SffgHDPf/ej6rhYkyYWfIxRIsNJqkwbRy1bAsBomC51rq8GPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jT3lDddqMFsc+6SHYoQRSzE3tFPv0MjuNQ72aOttWFw=;
 b=FLlJWJlUkQWo4UgGFgxX8Zi2UugNUxUk5qOEBVTCdihUHJfdfMl0P8g3f6V/W1Luet+NIr9NbxiUWCJmjX67OLOCm1KUyPZOX0WY0WN6rKpWUD1Tisd7AQAQZ8da6oOfTmOYBRqRNov9p8Hmek+EVZwGMTDZOLw2rz/stVUqoWJX3qcmN5T9rTOP8ZCSABgLqotYQZvMquOwHq0Gq4HUIhoDiD/eZuXrycGtqMmDtPshE1SAGODoBztrhwKWtnlHnkbd4Il68bXqM+mzoCH/9P0ZfCD1/ehVJEYr5LgQjGX1JauQ4XCSNnufyTk/8nlsIdFSruy97aT7Oa8rKVrggQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10222.eurprd04.prod.outlook.com (2603:10a6:800:221::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 12:51:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 12:51:08 +0000
Date: Wed, 22 Oct 2025 22:03:15 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 3/8] clk: imx: add driver for imx8ulp's sim lpav
Message-ID: <20251022140315.GA11174@nxa18884-linux.ap.freescale.net>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-4-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017112025.11997-4-laurentiumihalcea111@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10222:EE_
X-MS-Office365-Filtering-Correlation-Id: df496d2f-55d7-4f23-a608-08de1169ab3a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0fjLI+oBTS6zM/5nnqYzFldH1S86+G2qLDYpx/8iT7dqncgHFP/QjJtpH+UU?=
 =?us-ascii?Q?Uh7SsLkb3sE70iEXgM1YSc0ZRDe24nx2j2cBX5JUbRZidz8qc7hpwAQUTGSC?=
 =?us-ascii?Q?WS8DnCdhN4jQuX5EKxE+NMq715DNjaUimfH4+vtHyoWe4hy+edf6Ht89mRY1?=
 =?us-ascii?Q?154Mkbc4bS8sPEUsa90cmEarEjRdIepriMKkc6qy8UdU9QNJ0yvKxRBpjUpr?=
 =?us-ascii?Q?fKmFhI0o9Uwa10QUdW54ci7xS4PcqGvEqZ1dy4FfOIGVpaTidL2qlZR6RJP0?=
 =?us-ascii?Q?hKS+w+B+ehfGIG1wwzPcUSpKFoMKw9B2mZgtt1BihQZhjaG7nroiDCX0DaPd?=
 =?us-ascii?Q?VBDWqqQVdQA0LUZWU3cFge93+tgF8595fLAQzAsxdPwqt6rs/3gTA+UMnQtQ?=
 =?us-ascii?Q?OojdPo0tSJxcaM0HYc3QwtnqWFdz1vXAOUR8py/x1WU2noiNuWxZ99AbJzgv?=
 =?us-ascii?Q?3Xq1LXd8xHbjg6sgb2U+bC/S2UfzBDGvdiFG3B6w9Q7J9BswGu31bcesRb2k?=
 =?us-ascii?Q?KO4M9WhRjwWekQi6W8boKnF9GEEgjvYPlLNOY1vXZzeEJeaGuzcSnzH3FUR8?=
 =?us-ascii?Q?kaPOznyFeZWv4TCyYPvx+MOw8RBhoSoZ2pwD7Za3wAISqdlEOiNVY8RRavzR?=
 =?us-ascii?Q?S/jZ3G+s8rkgHzIwEnMmKx9CUDefzcCgXGx350ai+NVKxcsOVL6NPxW3S8eD?=
 =?us-ascii?Q?1LYqzQKUFUCr7xwy1OOtobdAQ+lXWEzlYeOW6L+n3QdLE8JtgGuapMvQhTPc?=
 =?us-ascii?Q?wvoG4HsFl0pZWC2EFbS0KRmqNZgSz9sSK9i9XcubBprq0U9HTiGpMEcLGCBf?=
 =?us-ascii?Q?jF9Oz+MYRPAjb3IMX4Xaaddk7ap3iF1qp8ssNnTQqo+zfyNoQ7EKI+7vfeUx?=
 =?us-ascii?Q?fcPsWngaR6rXyWvQWaGFG9/nbZbvQyUjPwZmgiBveCK8gj6meZiaRiJ65vkh?=
 =?us-ascii?Q?YWF2BxtzWsSMMEC4bHDqHVtynJAh4IpZ2lK6uuMpE+Bt8o69h7mBehr2i5Nw?=
 =?us-ascii?Q?6S7Lv58N3mmAiXZGezpGw8Bc2RiHJPxNAn0mKLTQs12LDYPIcJy8se4310zT?=
 =?us-ascii?Q?ytDAefMci+MYznuoSUWgKyF9FTwXmfJ48bfZhOn3FvwURd96SIQYCVVe0NwT?=
 =?us-ascii?Q?1g9AP3Pf45Jb5g3TucuUCaicJw33YGe8DBQzVo2Qgm7EJZVduzZ9SBPsQ8pX?=
 =?us-ascii?Q?Yk7kOdDXbRNpjsVajvOVtjXUyWlPKcC0KTbgdzpM6EjJTObYnfMdY+4p7HFt?=
 =?us-ascii?Q?W3rjgCcjJ7ow6OD5RfiLH8TOkOIoPlp0iaoiOIY5Riqcy2zBztUqNES6uxbp?=
 =?us-ascii?Q?sZUsn/QwTczlcpytktlfwmTRKtt6EbakNxL74XCevC0bcc15UwcYjuk2kpHJ?=
 =?us-ascii?Q?bDSthDtKr3rGDadObNtChpr7ignfe13/3j563p1LoKJQEv0WJSmMYlHLYkjq?=
 =?us-ascii?Q?TsVn0YE7Uq8ix745/FGKlxNwW9YthP6+9CNwn1PQrGTVM/U5Q1+mfkrtxNVK?=
 =?us-ascii?Q?LFhO4bTIU4DdERblnqkyuuNmJjiyGejWAE0F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kBzZ8fJdHlXZElCSGC4+PNDOLI+aHHwutTKKxIIbxStiJMyuX8zWJ0uSKWJt?=
 =?us-ascii?Q?CcPahMxENrSAcS1XCRDitlA4R/f4O+k309CakABn0OcPwP2CN2nfvthzqKh8?=
 =?us-ascii?Q?tWsocMrtqaQRxWDdF7+MQ5kBJbW6XEytpJVTEJQvofsD40bzybpy5L0oETfO?=
 =?us-ascii?Q?Az5sR/yGwuK8Vs9BfqOgBHjhvjkiEtxWWt2P69SCUNKj2CBEMytX97v/oSPx?=
 =?us-ascii?Q?zfReH0E2lj02XRGltvNHgnbvxnjjK8mJWc1g0klAn0DoAnPbrhi3a4bfqwbI?=
 =?us-ascii?Q?aYGfuWH0FhTneBvg7wDGv/37rqA9JeIV6OFjhVyATdaXNzRn80ejN+wB3IaW?=
 =?us-ascii?Q?4XWU5i7KsH7qghqBfkgHBgp3zEUw+6qIJYKMLTsLZkK4N+Z8/0Jd9SYPzGFq?=
 =?us-ascii?Q?FEdk9hgr+W9AGc57xb+3FMgW83pXflRMwMTSqzcO9TuV011n2PjnLMDSUfp7?=
 =?us-ascii?Q?ZCSzpu+8SgpEYX5Eteca+94Sl0MT/cKwKQzgjc/P0zCMGL0TdXPlhma3e1cz?=
 =?us-ascii?Q?qI1kJ/VFdqealdNSAhhzmazbuZ7G2j9Ed56eUXgLJ/h//nv1AJCj30w3qCHC?=
 =?us-ascii?Q?wm2zc/qqHTDsLiRsoN0kGc6L8/CPhEczDou/OooZWf5tiU4To1c2kMPuCzGj?=
 =?us-ascii?Q?g0HnqrW8/IGRaodjdhdRU5KF4JbsGrso7XQIc+oIdE82yqwRVDZXK2AW2GIP?=
 =?us-ascii?Q?G77M3I++Vbrq4nT3pqldbb89Z065Z0jHaePhaoEJ7RyN8/ZaAGFJJo/yT9q0?=
 =?us-ascii?Q?1FBvTXr/WlYKkXRWATXMlj8zZXFOcCaEO5ovbIRQTICiEdhFzOSC2cAobIWP?=
 =?us-ascii?Q?VQbtQLH5TwiHa0K7ONxYy9uAohK7b/+p6ZgD+/19tcTBkMT8c4O/zDxDVkjz?=
 =?us-ascii?Q?9eYf6z+Vs12e6+UprQD5Bem8hRGU/OXraj37Jy3eItEzu+m/CVSlT5lwlLt8?=
 =?us-ascii?Q?bbKv3PnBZ3Fd9KJJNIGxdt/h3FuavJwJHpM9irSkdzZ/bvaFbdwoXPknE/iU?=
 =?us-ascii?Q?CjQ2OYKGu4GeaHELX1mxVbehB4q3IEaloc1zdkNvXsFgio0HbAiMqALOvxTj?=
 =?us-ascii?Q?/x+5pNWLPBX3YRfjDDLVRo1SrIHiov7tylsyATO5EDSjZsm19bNSpKsgPFYr?=
 =?us-ascii?Q?Vu1a4owUxjt6YUr+sUeJIEFS1zCeqnjImmNUa4GXpmgvOpG2FnYdPLse0f/A?=
 =?us-ascii?Q?mi0IhOVxvtyG/zbOl0Px7tPnmpLiaELS8MYqBHIFTR05T65bJRXplkYvbtx0?=
 =?us-ascii?Q?3//P7t+346aOl4pG64Yt0M9pFY560TAFnhywF2wqr7+zrB+pfzT6lqScF9Oa?=
 =?us-ascii?Q?rREHXjw2sq/7zmxrXWRkHl1wqlgcceungV/IXySslpo1QamOgntn8WIcKXNY?=
 =?us-ascii?Q?ktPM09mnBvJKk3fq1AUicLQ45saw3AFQXbGPqqoNon9OAboFzNZLyfeHsNmY?=
 =?us-ascii?Q?3NsSFMsc9k+/WFHahPQMaxsdIoFVHjEmphair/tbfRO+yHqqOGSWVXL466rk?=
 =?us-ascii?Q?xajRczSrnVf6SyoMobUf1uzziUZNiYDVXmOgcer86AxwsAMRmBJTIypBxE+5?=
 =?us-ascii?Q?V4pJoNGsgaillcqJH0xMX6Ed6bzyAWaWNwhVWpdc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df496d2f-55d7-4f23-a608-08de1169ab3a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 12:51:08.0194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JEGUK5glhjhcB62HC+bY5KmsmrFTVJyN217QOWI86E12EQdAO6MdWWH2eG5I++HLIMLYyCwjDunjrfffKdqC9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10222

Hi Laurentiu,

On Fri, Oct 17, 2025 at 04:20:20AM -0700, Laurentiu Mihalcea wrote:
>From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
>The i.MX8ULP System Integration Module (SIM) LPAV module is a block
>control module found inside the LPAV subsystem, which offers some clock
>gating options and reset line assertion/de-assertion capabilities.
>
>Therefore, the clock gate management is supported by registering the
>module's driver as a clock provider, while the reset capabilities are
>managed via the auxiliary device API to allow the DT node to act as a
>reset and clock provider.
>
>Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>---
....
>+struct clk_imx8ulp_sim_lpav_data {
>+	void __iomem *base;
>+	struct regmap *regmap;
>+	spinlock_t lock; /* shared by MUX, clock gate and reset */
>+	unsigned long flags; /* for spinlock usage */

This does not need to be here, put it as function local variable should
be fine.

>+	struct clk_hw_onecell_data clk_data; /*  keep last */
>+};
>+
>+struct clk_imx8ulp_sim_lpav_gate {
>+	const char *name;
>+	int id;
>+	const struct clk_parent_data parent;
>+	u8 bit;
>+};
>+
>+static struct clk_imx8ulp_sim_lpav_gate gates[] = {
>+	IMX8ULP_HIFI_CLK_GATE("hifi_core", CORE, "hifi_core", 17),
>+	IMX8ULP_HIFI_CLK_GATE("hifi_pbclk", PBCLK, "lpav_bus", 18),
>+	IMX8ULP_HIFI_CLK_GATE("hifi_plat", PLAT, "hifi_plat", 19)

For the parent name, my understanding is they should be the one
from clk-imx8ulp.c, but I not find them, or may I miss something?

>+};
>+
>+#ifdef CONFIG_RESET_CONTROLLER
>+static void clk_imx8ulp_sim_lpav_aux_reset_release(struct device *dev)
>+{
>+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
>+
>+	kfree(adev);
>+}
>+
>+static void clk_imx8ulp_sim_lpav_unregister_aux_reset(void *data)
>+{
>+	struct auxiliary_device *adev = data;
>+
>+	auxiliary_device_delete(adev);
>+	auxiliary_device_uninit(adev);
>+}
>+
>+static int clk_imx8ulp_sim_lpav_register_aux_reset(struct platform_device *pdev)
>+{
>+	struct auxiliary_device *adev __free(kfree) = NULL;
>+	int ret;
>+
>+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
>+	if (!adev)
>+		return -ENOMEM;
>+
>+	adev->name = "reset";
>+	adev->dev.parent = &pdev->dev;
>+	adev->dev.release = clk_imx8ulp_sim_lpav_aux_reset_release;
>+
>+	ret = auxiliary_device_init(adev);
>+	if (ret) {
>+		dev_err(&pdev->dev, "failed to initialize aux dev\n");
>+		return ret;
>+	}
>+
>+	ret = auxiliary_device_add(adev);
>+	if (ret) {
>+		auxiliary_device_uninit(adev);
>+		dev_err(&pdev->dev, "failed to add aux dev\n");
>+		return ret;
>+	}
>+
>+	return devm_add_action_or_reset(&pdev->dev,
>+					clk_imx8ulp_sim_lpav_unregister_aux_reset,
>+					no_free_ptr(adev));

clk_imx8ulp_sim_lpav_unregister_aux_reset() clean up the resources, if
moving this before auxiliary_device_add(), then no need
auxiliary_device_uninit() when add fails?

>+}

Regards
Peng

