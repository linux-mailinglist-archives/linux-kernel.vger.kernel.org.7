Return-Path: <linux-kernel+bounces-793693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E17DB3D6DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4AD3B8C4B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED1A218596;
	Mon,  1 Sep 2025 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UUTV/gkj"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8122080C0;
	Mon,  1 Sep 2025 02:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756695371; cv=fail; b=NP/Jb2aU53dgTCuueiRhqOvy/oMRkKRyWgk43JcCJxCnp8K6XEgQOI6Cv+Vy5GrElAbE+Q24bKsA96pR833oEAA3o38ODBlUwOTd+8CnyqEUSErlQXg0J4wpv9Hebr8t3IgJ2s9iEomPtAzVa3AW9U+o+MD0IesdVluNw08ujWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756695371; c=relaxed/simple;
	bh=5+Z/paSNhyj70ODOF54RYlJ49gxMHc0f2bIku5Fdacs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MpEW0+xq9Jv2tfw2NJ1gbGySbutw/blpyErXU+H6PYbeOVNI2EIWki+FNFlbOoY3QrvdlyM43GXTF/3JbzbvM2e+18gjmxoC60dKb30+BiU5UwUw6BRKdhK7en1UylmluwzAlvDJ5F9u6hlWBwlxZW/dOV5RZHriFRlg5AyX/rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UUTV/gkj; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AH1FHPAuHJt23Be7LsRqZd0Dm4IiZGMOB5orEZR3a4OLszxBVL/mj5y/kHKMnUk68Ze9SEEcnZtHcWCQNSaThb4aA5BjTWDZMWGGxIYk+fgaWndig5HD5TwXBFIPBkRUyxLN/ZrYgO4OV+jZsiAbgzA8UhYzXXFJs4ELxQdPZbj/KgAvPZ/4IW6zfWVqgXrk/RzqQXqPHlHPON9ofWXED43FhiC5xVzj/uGUocjFDNhqiRliyGmrx7MRemMwQPS3/26K/c6aeP8qks87Rrt195jUU8Yz9oRtsNn93ulP85/P05FXJD2lr3VjLyQ503fqcbrF8N8J6P6IyoqDs/abHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCPtxLJKpbWQiy3fMsMJhOv9LcaLxQxPrzc3XHqpA30=;
 b=ITxlwFpSMGX7DshtgXri40kRt7Dc9/yYutgFEMxXt3LYx3LbiDvNVQ/NVzSOX87224xNNfXGeSlGwTY6+0dixDq8fXzsi6WWE1hOn+D51+ebiZEQmb5lrCmpWaBK/ry35fENKh+95n6D015UfuUhXqBXYukBqkOf4KxIcUtyPDLY6y/Au8D7seVrliUrpedH+DQL2pKdqLK088HtvPgGkZQB3ZJFxH+cvW8iLc0hJ33z335A/BZ6bVlgx7gZ3Rh9zNvinZyasP3O/64mxq7bD/QW8KUkspjN03lTO2yEgnKWT7LySZS8gMDvJ7NDc/twAYRQsI1rPqTc2szmL08TrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCPtxLJKpbWQiy3fMsMJhOv9LcaLxQxPrzc3XHqpA30=;
 b=UUTV/gkjirWCGSwjaZxPmsBLi9R/L2F5XEXuWvMpccXaagBKWeWoyqXRXv1/Dil0Uduu+mFpchsn/KKwF5Y+1GFuM7kf7HyrhwpThk6KdJ8Gjcl6TX+IcE8a4wGlpPa7Kx/pnN28P2VwmPHPlIuslYCYgOZUGaj1JYfanD+dFkRyFJG7ShUt0eVIgUEkbf8VG7RRVkQ43jHVEyW1OYs++PhSCaQ2nAjokKcXa9sVRutQMRQs9NUcXBHd40OGAIbtTQFLpMH8RcCb73ok0sSI2nSX9HhzLz6VwAqxKsJ9rmj3yFJkg4cz4W2YZ06hOTNEfpmUVXwXE2h8f3K25MvGDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9269.eurprd04.prod.outlook.com (2603:10a6:102:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.12; Mon, 1 Sep
 2025 02:56:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 02:56:05 +0000
Date: Mon, 1 Sep 2025 12:07:21 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH 2/2] arm64: dts: freescale: add initial device tree for
 TQMa91xxCA/MBa91xxCA
Message-ID: <20250901040721.GB393@nxa18884-linux.ap.freescale.net>
References: <20250828094745.3733533-1-alexander.stein@ew.tq-group.com>
 <20250828094745.3733533-3-alexander.stein@ew.tq-group.com>
 <aLCfTswvqXDLtAhm@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLCfTswvqXDLtAhm@lizhi-Precision-Tower-5810>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: 409e5b45-df95-4fa9-afa1-08dde9031707
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nNPVCOInqNkY8roWmKEPnVu6FqvUquDSKdW+OkxwJfNLYRNzHOE+WbGAFZDu?=
 =?us-ascii?Q?r7BnsdcChhZjS7X/TspZbjHre4BINDH0Y0uvRHA6nUCxZf/9YiaFc/PC1w57?=
 =?us-ascii?Q?cCMgsM4UiSLX5+Rq26m6+xx/xrQmNDMdM+L/K2FKKLx9Jar2Z1dleW6oO0ex?=
 =?us-ascii?Q?s32ujgbp4p4Bx+mDNksG2FbP5WD1trhr9YxNyWmKhhb+m2ObQUWz5wei9mlc?=
 =?us-ascii?Q?sI29zgb/yc4YtVPRiFEdiT24lxMCVF2qjAwSQyKcZeeuxwCYeGlLoU/X7x6d?=
 =?us-ascii?Q?9MzuaqdLwticpIz1CF4oNWh/6ydL6fRp+iq4Yi1VqNN5QZpNnrgxb3CJTS52?=
 =?us-ascii?Q?G/PtIGlX9m+m9pDYpo/2uisfW6Pgyw0gdtXAX4PsQ+4IsLQP00/al/m95Flg?=
 =?us-ascii?Q?aHIjycCSEDKpxeiRsNw+qDLk20FhuXz6BZ8Nk8BxkBcFXk3z1KSBusH63lvu?=
 =?us-ascii?Q?zAkTzlalrOOwsZkwQhkIQGCFBce7Ivki8n6JpPdBzazzPz9M9f5zAB5g3MbP?=
 =?us-ascii?Q?1ChY3M716naGh3iH7F04EfsW6fTViJI7+QCunfE5ILAjTkl6tfD4vVZkNOL6?=
 =?us-ascii?Q?DRsVXDrWHnMILrmJAJA7x3BdiRaNIaHHKZ/gLLNcd5PS3O2Gij1xSugjFIwv?=
 =?us-ascii?Q?UcghRu360RHX2XxLDWf8DPLYBb9metpLQFjKEXShUTr3TU8tB0o35p6gwyZM?=
 =?us-ascii?Q?o0wwi5pNMq+bbONSfswegQcuBMTkOeNXOP0eZGgAM3c5CrUSvOXoDrrfj7c9?=
 =?us-ascii?Q?XyidA9Jwg1sgpSCYqxRpBVIqKM6MWJukd9Bj1Li85BX5ETuPfcRKpoNTu3cT?=
 =?us-ascii?Q?2yndUhkr4c3aRFpKKknFKa3p5lndjNwMvIiL4t4XzF78RJGzy14MSP+a/Bee?=
 =?us-ascii?Q?efzDlwWDYhv+ZItu83i0sTypjc3/K/lv/XoS5QE7wKJcSHID9S08CuDSIMED?=
 =?us-ascii?Q?I47LYsrEVuky4RG6YJqUevCA91wh7xN+kMoE/r5hY4s81zsDD+y604xJF7ge?=
 =?us-ascii?Q?soWxsbXJJfcskPUA8qQ6y2tMS53pYJiDmw9DIV4ZarYHOdkyuFwJ28NE/AxW?=
 =?us-ascii?Q?qa5UIxrS6+UPChsJ0NlBCKmfbKqRdHgEg+7mN5+EoXs3lYZv39Os/rbxN/uo?=
 =?us-ascii?Q?oipTclKRPn2LXZc6+YFbcNUw5BkVUg9oUQ4T891g3iBhhmkNjggFbnpsGD/6?=
 =?us-ascii?Q?u/um+iviehjML/A5b7Cz7pbHBuNSPEce3ajksPQLTwm14wW+0aIAMBohdF4k?=
 =?us-ascii?Q?ENSFqpwhcS3siTmqiq7y8P8XHrhpgw+3Nb0o16V701po/n6whPnTu+YcM80L?=
 =?us-ascii?Q?ph3NhNhef9jL9hkYzule6WS6kCkbkCU4s6TnNh1n3sFuGtaSkosWo0C0ildZ?=
 =?us-ascii?Q?PH9vGywD7cOZQDFDSNlD10Vy1noMJpX9xoWFYcttuPjWqAk96nqS/wKf9BVX?=
 =?us-ascii?Q?JbXM9fERlaP1AcdRQVO6zn+bJ3wgrKXhmDaoUum514W+rx5N0gvWYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zaMKhvNV5Nabh75qeYVtXJjdeacqgmK9912IFNp8VyAH5xBAny9cd7KQNfex?=
 =?us-ascii?Q?v9loJLvXu+mh2nq8mdoZshKmE9W6xnHLx8nPvUPjjBY73ETYbZ52dJl2ZjYx?=
 =?us-ascii?Q?3qTbKA9ph9aCUsDrxgKXRVQ5ZTKd6+6KWs0ZbeIHb5LnXYnXngzPDhSSUhvP?=
 =?us-ascii?Q?8Oortu5PwXeQJ2K7e2lxB7OkTi3FUWFQkOCKXerX8MJHKBXQCc1oAOoh05qn?=
 =?us-ascii?Q?VrDOar9tVTGSXvcGe2P01PSQaUPhMbrjemqs5fhbw58YXd9vDa0qXzZOmG7A?=
 =?us-ascii?Q?gEQ8T/8557CNyszadqh8Rv7Pl+1WoKq1gyjZNPL0ASoBWd5/J72ZQEleFBG+?=
 =?us-ascii?Q?9nZzrjFczXFl8oc+YBLxSfGiWIcCaE5WjosZil3mW7RLebJjOVpHzGR4p+xt?=
 =?us-ascii?Q?KBLKSHWniDtZvwipVj9MIU3a6do1E76dtTrOVHB9pxAvqo9USyjamWeonedp?=
 =?us-ascii?Q?83jGCE0XSatRBUkqRc8s8XUW/QuQsMvZf+AI0aihxoKgNyehrYcPYk4914Am?=
 =?us-ascii?Q?CBZgzeqlNbc9MN5HmquNDg6gcPPw6agzSUYHqNwMPLr8Qz3tebdyVJQWgOux?=
 =?us-ascii?Q?a8uUPDug85D6r4d+szDtWkN+HnN0gUCxEJa5Rhi3RYTx3a8Wil1MtsHsejM5?=
 =?us-ascii?Q?ACzJS8nDCk5d97iJ/PmOvgzt7Dmld28zE5SXh76xc5+oULzlk8r85q2tLzQR?=
 =?us-ascii?Q?EEiRQNUDHCBegTuzvI1R+wuhbD+Ux3PimgRZqRNoY2maUk3piqJexi2RIcul?=
 =?us-ascii?Q?701MtsqddExw7vQd12ea2vzgMRfJCTtFadwElKcrgW/a54fTPunxXCBgI/7B?=
 =?us-ascii?Q?GxdeGHemIIAO6p9cyK4iUZjZBpwpnKny/iYEBrFU9fioHwBMmjJbHFHhAn8x?=
 =?us-ascii?Q?bYjv46izc4DCLing5TW9GjZluh/F9hxb2VfpzNTW9sonyyVICnGaYx0bdbNI?=
 =?us-ascii?Q?vaN4krLdHtv/0pZc5xdpOutu7j+NEoYuYatkMxVJay8KOAQ1O+Ali5txJnF9?=
 =?us-ascii?Q?cWQjaZD/nc9xBbBhPFRq2QQ3MXYlCB/le4noCTBJiyKlwXRuJHCXhyef5elF?=
 =?us-ascii?Q?z8I2HekK0eU8ETkEn/HMnLUhHTd/YgOndSxupjzA/GdN3mlXNbcLVCVp7H4G?=
 =?us-ascii?Q?mEoVB6GKW+ZsRQJv0MwD3BR8mOQvxLkUR1BYPBfjlUBrfzLdrX3qyTMZ9z3S?=
 =?us-ascii?Q?jL+qpXddlfufLNIvpkfZYmSFW1T2l4M6BlVgvoCCJ1B55ArVJmfFvtVVawJ1?=
 =?us-ascii?Q?C5G3STGKuObS/vV2cgm8B/Gt5lI6dNlRaCQHtQ6xR0xHdjpAmE3MJMf/frDu?=
 =?us-ascii?Q?wC36fSb+CrvHGbTmzIajh6vhlBlHiVvUpbghj26jm/QTSfrLpMrMQt2uGOy9?=
 =?us-ascii?Q?+9PhqkRTtaEg+4CFkPEXb9BIAuKk8p8XYF8KQi+8cpckqnyCHPRzfp3WoFhb?=
 =?us-ascii?Q?jQTJQ/oUHPJQMs2N1l7w8cpaetN1l+5Zl4TqZDTFQXaO4zLFw3fYn2RYzxOi?=
 =?us-ascii?Q?QNo9+D0blfJGH5XBu76+p6rE67i4SIU1rMOdfH2bkvij2eYA6mEyxN6n/LCG?=
 =?us-ascii?Q?G21pgy3XGvcO+5Wq0/kMoRnSFtHkK2ospmc29m00?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409e5b45-df95-4fa9-afa1-08dde9031707
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 02:56:05.2387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s97ojztmYuN8EZC8qQHtjQNUaoiFQP56i4S0FBetvDZ7uIGA5uO6hVzuqZuT/GM20YC/TagtOAqW5tHhmOTHYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9269

On Thu, Aug 28, 2025 at 02:26:22PM -0400, Frank Li wrote:
>On Thu, Aug 28, 2025 at 11:47:43AM +0200, Alexander Stein wrote:
>> This adds support for TQMa91xxCA module attached to MBa91xxCA board.
>> TQMa91xx is a SOM using i.MX91 SOC. The SOM features PMIC, RAM, e-MMC and
>> some optional peripherals like SPI-NOR, RTC, EEPROM, gyroscope and
>> secure element.
>>
>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>> ---
>>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>>  .../freescale/imx91-tqma9131-mba91xxca.dts    | 737 ++++++++++++++++++
>>  .../boot/dts/freescale/imx91-tqma9131.dtsi    | 295 +++++++
>>  3 files changed, 1033 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-tqma9131-mba91xxca.dts
>>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-tqma9131.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>> index 947de7f125caf..3a937232d6f29 100644
>> --- a/arch/arm64/boot/dts/freescale/Makefile
>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>> @@ -338,6 +338,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqps-mb-smarc-2.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx8ulp-9x9-evk.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx91-11x11-evk.dtb
>> +dtb-$(CONFIG_ARCH_MXC) += imx91-tqma9131-mba91xxca.dtb
>>  dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
>>
>...
>> +
>> +	pinctrl_jtag: jtaggrp {
>> +		fsl,pins = <MX91_PAD_DAP_TCLK_SWCLK__JTAG_MUX_TCK	0x051e>,
>> +			   <MX91_PAD_DAP_TDI__JTAG_MUX_TDI		0x1200>,
>> +			   <MX91_PAD_DAP_TDO_TRACESWO__JTAG_MUX_TDO	0x031e>,
>> +			   <MX91_PAD_DAP_TMS_SWDIO__JTAG_MUX_TMS	0x1200>;
>> +	};
>
>Any one use it?
>
>> +
>> +	pinctrl_lpi2c3: lpi2c3grp {
>> +		fsl,pins = /* SION | HYS | OD | FSEL_3 | DSE X4 */
>> +			   <MX91_PAD_GPIO_IO28__LPI2C3_SDA		0x4000199e>,
>> +			   <MX91_PAD_GPIO_IO29__LPI2C3_SCL		0x4000199e>;
>> +	};
>> +
>...
>> +
>> +	/* protectable identification memory (part of M24C64-D @57) */
>> +	eeprom@5f {
>> +		compatible = "atmel,24c64d-wl";
>> +		reg = <0x5f>;
>> +		vcc-supply = <&buck4>;
>> +	};
>> +
>> +	imu@6a {
>
>I am not if "imu" is common node name.

accelerometer is a generic name in device tree spec.

Regards
Peng

>
>Frank
>> +		compatible = "st,ism330dhcx";
>> +		reg = <0x6a>;
>> +		vdd-supply = <&buck4>;
>> +		vddio-supply = <&buck4>;
>> +	};
>> +};
>> +
>> +&usdhc1 {
>> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>> +	pinctrl-0 = <&pinctrl_usdhc1>;
>> +	pinctrl-1 = <&pinctrl_usdhc1>;
>> +	pinctrl-2 = <&pinctrl_usdhc1>;
>> +	vmmc-supply = <&buck4>;
>> +	vqmmc-supply = <&buck5>;
>> +	bus-width = <8>;
>> +	non-removable;
>> +	no-sdio;
>> +	no-sd;
>> +	status = "okay";
>> +};
>> +
>...
>> +};
>> --
>> 2.43.0
>>

