Return-Path: <linux-kernel+bounces-738918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF8FB0BF08
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2642177105
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF7E288528;
	Mon, 21 Jul 2025 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WAE8lNka"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AB12877E0;
	Mon, 21 Jul 2025 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086918; cv=fail; b=DSAXvsVmsmqhz+WeC3fLOJ2yWcxPy0EHeGQ0C9ggz08QDM6/A8yAJQjoVllteAafnObupea98UMWN3IlMmgk/tFzrePoJI1ludFJLIhxVzqb9pMTlm4vlcykH2/ZPZc/0ncX8LkQ5JrdBarD4JFMeFXXUGWT/kuc9LyBAkknEsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086918; c=relaxed/simple;
	bh=iUrUMmz1wKJt917kHVtFmZTJRQuNGOlJQcws1iA/UUc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZZVj1XqOXRRZTulr8RMY4a2w8FZ4bM1s7ua72OlWi9wYdVU1XA50g6v4S+5eipA4uhV2fcx7Q2jNfBpGud0LT8riyr5zBnza/hFkh4NRTk7N+2dX6VJWH8W6dcmdsQJ+vluPHoq6J8+MNIacnguyKzLRK+zO9XT68ybh9yAQNVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WAE8lNka; arc=fail smtp.client-ip=52.101.70.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M03VL8duF+sYYK1I2KdR3pXSREDFafAnMfpk6ESYdUMXbGOz/u+ypmIsF/Jf/gA3ubFahPSHkpqApNjfxtx9m3P3AmhceBm/8/v26/cCxaUWCeiNej9Cguior0m7LqzH21zthqsoOecmWi1os0NSNOnkYgyk10Ff5samOoAJKQ28r+VJoIReyAMj1kjmJekEip4pe3Y9smOhOuiCmCtFrOabU3qiD+H4O2hdrOBygMYRIjdmkE7kmTOcULAlJPBNya04P1gtHFF5fn1Pg22TIFmsTpmKUssYK3PPKy+zqP5rge+zmaI6Z9dFd/bk7cFoP2fAAyU9HJ6x0STRA24JNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2sqOKvDVRLbl03mZ8mgciKJ6y1L6WpruUTVTDlWSNc=;
 b=TatWWKu+7jW+FXaGemWS0DQg2qx2Hsz8TqSaPyA0YmaIjbCkBb4YAg+oW6d2iCsYoUAUJNkNcib7gu3XVdbtxTmrR2vpTrLJ28gyDaaijcrRd4si7PFEi0K09RWkjtmY7yohcCHshCqTKL6wqWZcqmhyelMqBSVDoDU4gK/R8qP7as/Ioln732zV3dlUxGw0ceF0+FOZ3dx5x+J0st5ngXe2Rg7gYKhlLf9zupXsaM1kTW7rNAiKCxgcCG506Ezrv+RkCKXUMhhyVFF1ORjZMGfrx/AdAfZ2aePBgyt2SmpjJIHLzTBt/Moz6aOvilipv5JFbU6IEdikTVdaJU/zTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2sqOKvDVRLbl03mZ8mgciKJ6y1L6WpruUTVTDlWSNc=;
 b=WAE8lNka7mgkT0IjAA2ov7mQM4igDWqahLV0iBhf/H6hKNsyFoO33r2kZs7kgeU9TwTVMi30Z0kMxRYh+mdTHF5KDHHh4XngqXpueCXm+55TmyMJegLwU2OkskmDziLiqM+EzOSkb1JtRPnn6FQWgUBA1WDOAMcUodRkUijsKxXrvLA3+NrHlJe4tyBu+Mkec1w6lKDJwAOQISHsptav5266eQjROMTwAxCOaZMYBRsQpjguQs6ChCUGpWtKJ5rJBd5y7XKZ8nHbZTElBErrm1kE4m2ELF/RFo6YyM4jMQ2Gzl/V/wayzyMUqF7HBFmSqiovnfXgBH6wZH9+jGzCPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by DBAPR04MB7223.eurprd04.prod.outlook.com (2603:10a6:10:1a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 08:35:13 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%5]) with mapi id 15.20.8943.024; Mon, 21 Jul 2025
 08:35:13 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: [PATCH v2 2/3] arm64: dts: imx8mq-evk: support more sample rates for wm8524 card
Date: Mon, 21 Jul 2025 16:34:32 +0800
Message-Id: <20250721083433.25711-3-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250721083433.25711-1-shengjiu.wang@nxp.com>
References: <20250721083433.25711-1-shengjiu.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::12) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|DBAPR04MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ca4699-73c7-48d2-2367-08ddc83182b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bX9KibAOKnpiOPdJkWj1RGA68Gc5v/riJJ3XUB9wAS5CEq1M6d18Wz79Exh0?=
 =?us-ascii?Q?6gWFbNwVt+85o2Al5nP4waLzVA3VabJFReUT2e9WPUVEWKCCtge1lSrrH1pK?=
 =?us-ascii?Q?kVXkJpAiq/GhSWVxOWvflGJWpnD3BD7M5+FHHlPKcb7nN48ET7gd6yb7TKPu?=
 =?us-ascii?Q?qWxA+5ZM/LxzRUid9rZgJnp8iMn5g5r5hHntJnHIxgEAiMq4dUhm5YbydQXx?=
 =?us-ascii?Q?AjZvKkszmvIeBI9tjladbCCM8m4F3hMFO2OOjsx/08xqnbJS18H1VNEOzZPu?=
 =?us-ascii?Q?j5WLQSEDKu3u5LwljTsRcApDNcs6oB2nN/GRKgWQyrjE8p4O5DMFASp4VP42?=
 =?us-ascii?Q?GjM+9KWYgDbGgwELa3QM4JWloh6PhsKkmFfGmIU8pZVO0h38dkqAuZIU/kfB?=
 =?us-ascii?Q?dkK42pKY5W3AZEeRtonCQOe52YTJw1/BYvKCscBuw+/1uOwNJH6RZ7t/qBzl?=
 =?us-ascii?Q?oW9Z4iwKKHZL52J8PsI0WPFhlE8uHfxKfQUB381pHCHzn+m0H8yO/cQjgBQ4?=
 =?us-ascii?Q?0ypTiSDbLpLVYQQH2okEOtCEDF5KrjV12RjHbwwzS0u0SZUtDF8LyOS1HxfR?=
 =?us-ascii?Q?huk8E5BAk8kT5lxV+MtZfS4itCqeTkl0rbXQVyhcXHVYXzfCjW6ln1DYrbti?=
 =?us-ascii?Q?m18BRaEYTOFZAPDxbXl7ZdhmSSAhQO0cGqaDBYcFzEl3qRbalud6PQ5O3CSE?=
 =?us-ascii?Q?sRUQlbhUDyiSnfJTJNqnf4rl/t8gQ03Ul3cUXe/mDGzff/pNGhNwcsU8/Qne?=
 =?us-ascii?Q?F6WN77Upo803IOownsPa4HShPfb2thaWsClKguVHqt9xipudOLCfrjeFNlma?=
 =?us-ascii?Q?p67IjKolKYBWnU0HvpIEA2nFtagnIi/A8ptJ/62EIkOrg+07B9JGco/bgea5?=
 =?us-ascii?Q?AoWFU6tGJvtHQ8TuAZJXgewsEib2oLvmmKPKljowUYbWGfshH3IbKp01QW8G?=
 =?us-ascii?Q?MZg/0R5Op9uJ01PUuPP9ZO9tZHk838DsVL12wZQPKbtYWkj8IhJU2aLSUYqg?=
 =?us-ascii?Q?O+qIGwfEcreXY8q6NZBvT7aYd5bVhE8S8QcHEENxGrOlmsGMoTH05EGF8hM0?=
 =?us-ascii?Q?3z2zjlP8rdPCyIIsQX5nGKifXtryIjwnBQjdpYZB650XACf3i7DgmnDj5ABK?=
 =?us-ascii?Q?xlXQ/bszY6lnJQF8o1NFWXJCBPRTVv7K3TY+3y5aNuLpqEAmukaEbpfxDl51?=
 =?us-ascii?Q?T6T8V/rFw8XruS86ZRdoM2MOtavsgIVyaNjzIjbAHVdjeituqNK57n0Qt4jx?=
 =?us-ascii?Q?I3tuT6Fr9BwAvHCaVQoc7nKIVplKu8kDeOw8ss6mPeMUs6nlPYAg8QvrP8Nj?=
 =?us-ascii?Q?Ga19qj6EQEJ3rqK7pwhxvaiHF+tO9cRonimuo8CZfQaRHKlmhx+oNgW8sEWO?=
 =?us-ascii?Q?0k6uP6E/pzbv3uoO/qZ8gtd9urjtU47C0AOkZVSmX0ZPLkZNu7+qbAE3yqFK?=
 =?us-ascii?Q?23QWRzyEKuNgF/s++n/vBTACtMfS1aEFljvNni2uQixubP4D3C+w61bZQPty?=
 =?us-ascii?Q?x8ZcdurleLvRGXE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZJdcXt/2adgzY3m3/Gj30GwI/LhgUIQpgMcIlW4GLF4YOI3plClbRU640pLg?=
 =?us-ascii?Q?KvsMwROj1FS0sZ5UmZ2hsHivvP3Rk59xENQJxjWlanLQAds9fAm0xc1DGYeW?=
 =?us-ascii?Q?wBReVoUHXi8+b9wYOriWzdq6cCqxn+Tdu0Ji9GnNdqG3GEjWAzLJwLkmEpov?=
 =?us-ascii?Q?gu/bMQlpT41Ale6+efFSbYtSpXqNrlWA9Tb0jygLrbfJNJeKhcJLTUVXO/7t?=
 =?us-ascii?Q?o5yU9yEj9O2+WcXSvWRpomosrr9/obmk3MnkzEtsRkkSt2zJCzUHnUcGCBOS?=
 =?us-ascii?Q?NcKTh4mxQvyBymtEd8uQ2SfBiOvJdo/Nhsj+E/6g+NThCBuNNL8PkajnrHNo?=
 =?us-ascii?Q?dL7ARc+Y5utJlH5P9psKLtGBnZAynTnNR1KltoDdlOl+buxLlZbAT20O2K5d?=
 =?us-ascii?Q?sSFO0mI12tcBY+VqfeoB1CGdbmh/m44VFmIrdodkgJRG+pqcNjmXZ0FDhx4S?=
 =?us-ascii?Q?iLB0tOjTxNZzkMW+8Rjo7ZFAE2A3nuPlwyeaQlWJhY187/9ger4H5RRhi66A?=
 =?us-ascii?Q?e3ra/9bQTY+4J9lzE707PNf26nT3tbjnBC5EGMPrex9viaZTDxlpQbC8cbxU?=
 =?us-ascii?Q?nyM25rfZA+Kda3x3mr2h5Z2BT1qpg+3laoYK2+lOtPl8HUPe4eDjWpc1eiWz?=
 =?us-ascii?Q?IwYpCSG1vxQXurnSgvkR55yRqr0G6Txy5RRorSTBrcSmnFy6MMfKNFiHTWzk?=
 =?us-ascii?Q?6NZbsC55Hn6dOcNYYXguDJZliks2w9CmzSNHsHWXdCpvaE+h03sMGz2D3Zlc?=
 =?us-ascii?Q?Le/QoyhcFp7yg2OcfhbPi88ZaqcekoZVwDqSSfM67RU6EhjycPyX4UrHBrsn?=
 =?us-ascii?Q?Z0k1HW+I1j4j450CEaE4yWsxaos06E9scgOYMGqbnkr7rUKSN6e5VPVyiM94?=
 =?us-ascii?Q?NTXWwHMjDS515t7AMMtnkwgWVsn2ibI1ei2So/wfBphWS00Jl4swk9HMoTy8?=
 =?us-ascii?Q?YpruULCiaKyEqMmS95wiN2YQSzrhy331pSVWry3PbbsfMaZ+nVX+H3I3/FqL?=
 =?us-ascii?Q?GJfwFUStjd0sXkRyKI5uanvF1bU0b1pAKnNxtgR8oikT5Hx+zJh76Chfllz4?=
 =?us-ascii?Q?8gsZunmCM8fNARJgimEbkuhOB9XGStT7DdV7u+ntkCNjSfrBrfS32UvywuoQ?=
 =?us-ascii?Q?ivvwGQR/VVX/+s5lfMStB7wMJCCVhFK/RT9k34xajpG25x5FLWDtp+tbPprX?=
 =?us-ascii?Q?jU05GpNv5OjU3QxAeDn1cmURRNlqIUf+J9KgfpMo13HHKAx7fJhu091WyW+U?=
 =?us-ascii?Q?sGBlUuGtqBcGmxZ27SJsgdvvmWpT6Dp9p+9aEvg2WnGT5eZ8C16YL+GHQlbw?=
 =?us-ascii?Q?RZFzuMTT72n4abO99pZOUSOPaO5Zn20lbjVZT74Hox/kFO+ZJ/NGBP5zkGDg?=
 =?us-ascii?Q?8SzOHrd3X2LG175tc6kDmAwCE+wj6wTCqrIxs5JooXnlfZsN1E0He2hqp1Zc?=
 =?us-ascii?Q?vQqn4TYYns0THygk7V8LT6ndhEE00dX5fFVHGjLtRJf3VP5ZIjk0FEs1cAe/?=
 =?us-ascii?Q?mvExEqnF6UYr/AtaguRIPvVXlPpOzvaYCHzydEf5ii9Zk3078OPkCBRmTkRj?=
 =?us-ascii?Q?+mjcMjZuayrovW/Y0YB/0tJ4mpgUoFx2BGlVc8rG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ca4699-73c7-48d2-2367-08ddc83182b7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 08:35:13.0901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEftLu7yLFbCUqGK3Aj7zBZmxr3JA01nTuN6dWfkZNXIJvAKotTTC0t9AjViJipeMDV2r0SRP3p81Cm9tXZzVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7223

The wm8524 codec is connected to the SAI interface. There are two audio
plls on i.MX8MQ, one pll can be the clock source of 44kHz series rates,
another pll can be clock source of 48kHz series rates.

Previously it only supported 48kHz series rates, with this change the
supported rates will include 44kHz series rates, from 8kHz to 192kHz.

As commit 17cc308b1833 ("ASoC: wm8524: enable constraints when sysclk is
configured.") make wm8524 release the constraint when codec's sysclk is
not configured, so we can configure the cpu dai's sysclk to support more
rates with the 'clocks' property removed.

Add mclk-fs property for the sysclk ratio, which is required by
calculating the sysclk, 256 is a common ratio for audio.

'system-clock-direction-out' is a must have property after
commit 5725bce709db ("ASoC: simple-card-utils: Unify clock direction by
clk_direction") to specify the clock direction.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 43e45b0bd0d1..a88bc9034663 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -108,6 +108,7 @@ sound-wm8524 {
 		simple-audio-card,format = "i2s";
 		simple-audio-card,frame-master = <&cpudai>;
 		simple-audio-card,bitclock-master = <&cpudai>;
+		simple-audio-card,mclk-fs = <256>;
 		simple-audio-card,widgets =
 			"Line", "Left Line Out Jack",
 			"Line", "Right Line Out Jack";
@@ -117,11 +118,11 @@ sound-wm8524 {
 
 		cpudai: simple-audio-card,cpu {
 			sound-dai = <&sai2>;
+			system-clock-direction-out;
 		};
 
 		link_codec: simple-audio-card,codec {
 			sound-dai = <&wm8524>;
-			clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
 		};
 	};
 
@@ -440,6 +441,11 @@ &sai2 {
 	assigned-clocks = <&clk IMX8MQ_AUDIO_PLL1_BYPASS>, <&clk IMX8MQ_CLK_SAI2>;
 	assigned-clock-parents = <&clk IMX8MQ_AUDIO_PLL1>, <&clk IMX8MQ_AUDIO_PLL1_OUT>;
 	assigned-clock-rates = <0>, <24576000>;
+	clocks = <&clk IMX8MQ_CLK_SAI2_IPG>, <&clk IMX8MQ_CLK_DUMMY>,
+		<&clk IMX8MQ_CLK_SAI2_ROOT>, <&clk IMX8MQ_CLK_DUMMY>,
+		<&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_AUDIO_PLL1_OUT>,
+		<&clk IMX8MQ_AUDIO_PLL2_OUT>;
+	clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3", "pll8k", "pll11k";
 	status = "okay";
 };
 
-- 
2.34.1


