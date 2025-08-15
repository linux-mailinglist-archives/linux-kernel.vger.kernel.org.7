Return-Path: <linux-kernel+bounces-771213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5399FB28437
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66E7B20E79
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33DC30EF8B;
	Fri, 15 Aug 2025 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pr6xGcpI"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E4530E849;
	Fri, 15 Aug 2025 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276270; cv=fail; b=NztunSRVGyzfDQWQCOrsZAXKQ+EUpCcDcY4ZCw2f/w7AZ6TtnSYcdPDwGk1dwmR3KMQuBAp+ysCtH2hJzUHoNIM/Pl+AfAf9/YcO9sKGOgdKOEnkZJgq99nRTNIEluZBGjHAV9jDHZPOcI4LdHNV3zNaY1u2og+qI6/wJd1d8yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276270; c=relaxed/simple;
	bh=T7aXfpx+q9V3uj+sUXlKgUEyYC+mGl7mNdYaihlw6ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mHF09H1pMkZ21wB5PE3bQG3OsTvXMTNcKFPcKT9s+6zHW7oXyFYnHDiuGDyEcoc0hCZhFHHg2SnjOzxsLAtDi7O5bIjmmne2ElAN+dY6RqtT7tJ4p5wKPMnhyoZxPE4GZXp/9/dt0fHl50QGOPatYrNPI1LPcnUtMMtFLAHMHAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pr6xGcpI; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+eoVE5NlFUEDa75Mk6jiffNHGb7o1O0WVZhF0nc3EuK2Lnwxu8+T3TmIvV+5W8ynEVHxUAp4xNHzzqKRWiUO33UN0EvtCcTq6rjZuBg6pbP1VDQAeV0X2fGsDS9dgmFUWC8TZNSy4oSRBvmNcFG45O6pBUCzgIGa/zXG59EAR7CvntXZ2YK4TyMoikW6N/HSjyOlgQpAQ3O3kPLRcNbuj8IA2wfwpVy3EPzcGTEauuJufrwbgC6Hc/HP8QDklxORkeUY/RIWj62RejvpCTFNg+zwpCisfvHNKofPWl/znl6qZIc4rXI/wa9YaogwzpX+K0tSfBrMA6vy3aBq8Q3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mC3aWiovDT+zoX+tA5ktgXu3+M1PE87z3BCnEU+BrZM=;
 b=Af8dvpKpJvqOtkg0MxK1Xeuh+TWBdsuIIogJ/XhFrjpPdmug7x1348FIxskTVvWquYIhfeViW2aLfavQfUw07ZlT1vftdrWHcOOniqvjdCkA4/ZeI49lhJrBpx0bRzCgZJB/fAVQ3e9CfW0iaDG8wn1eizDde18i57BE5M1UCop2NGRZxaY6oK0nzynIxEPpejeIcsHobdnUS4RhYcIbiQ7N+hDFj9kFMhW3+bza/ai7lqJkwLD/PGgsL7H+VHb+8frjEfT4/FGnnqITtkd5DHNPOnX3ESCY2Zq8XziV6a4MWDxO/yC6tcZixP+xdm1RBhVlvbincmoO3qNalkZ2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mC3aWiovDT+zoX+tA5ktgXu3+M1PE87z3BCnEU+BrZM=;
 b=Pr6xGcpIxi9f8rLLqJLRdKr8il//j89A2JI9z0vUZXaa1wUlMOvJfD2nzF4HDaeuFuRH9a46frpXbelj1B1oTbLhphOein3OnEgA8gejJb+qMQ6qkHXAgOra9yWgUaQP4GZwMk++rZgLv6cLgLsn7IBacghnUFODUV5NzwGh/0i6IwHk76/RrP8ogqNBaluH0Gs0P4b46GqqBb6UQTasEu1T+YObogyU4D8dyXfpTvwUOr0xxj8ZT4ICETw6G3znLIUZTaG+y7og/DHhScMidFYf6WEJesW4Di9eU7wKzqfLoVf55Fkeyt8aQPGACqyqAODeOvBqvUIXlohf1ToZVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7051.eurprd04.prod.outlook.com (2603:10a6:10:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 16:44:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 16:44:25 +0000
Date: Fri, 15 Aug 2025 12:44:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] arm64: dts: imx95-19x19-evk: Add pf09 and pf53
 thermal zones
Message-ID: <aJ9j4WxfYIbkcX14@lizhi-Precision-Tower-5810>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
 <20250815-imx9-dts-v1-11-e609eb4e3105@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-imx9-dts-v1-11-e609eb4e3105@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c468749-b542-4cdd-c85d-08dddc1afe3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gtijeum2E7JEhz3XlL7vSlfT+j9aD/3IX5ElSSHw8kR0279J7nJHjPb2mGEy?=
 =?us-ascii?Q?gfiUOjkEzj8M6n38KCU+RjDWukqPnpVFxJmwzVJPvCdq+ayL1oW13ves5q4f?=
 =?us-ascii?Q?iWxwKr9BmrKsp41PFwpJEOr+t4VpozHbUGLVafG4ygwTjOB5xZ8sFai7k1rS?=
 =?us-ascii?Q?IimZLsON7xW/Vy8yPZ/i8o8GDk7RLQl7VS+rJzGmuDmfG0bCg6SH0DIfYNsq?=
 =?us-ascii?Q?OlU5Q088nWQQ+ddoUn8z5xCjn2PhXO6A2fzx/tGzHRgCuLD93Jsm3fDhFBIV?=
 =?us-ascii?Q?2aYmqrHCMU8d5nmFfNzs96AMxOGXJjd3Bbq4ikhoRMK/+c4HRA3mELHat0pZ?=
 =?us-ascii?Q?BzZQN2YWTIrCp1MRfhYhY7S9N8TH9L+fr1oNBg+E0UHvIDuCTGazMgwE9YWm?=
 =?us-ascii?Q?MW0uLtatBQbsXjCpG0kb6MpTaPBVcElCppqGL+FfsZi+G9LtlBdWBTSnqDdN?=
 =?us-ascii?Q?82hW1w2nC1wXkC4bFE/wSiiuzULx6iexMozpkS8KBRNSpUtdCGoMenCCqgzm?=
 =?us-ascii?Q?OV65r/B1NgMaG0eV1GMdmcaEOsbOoU7g/+DnFnZ47wOjpgmNoIhcWJPCtI56?=
 =?us-ascii?Q?ELdMKKS/wJC9gB7yVGtuNKH8sx0X9M4B18sS0zkBvJFRSJgNHD1i9gldldnW?=
 =?us-ascii?Q?BIK9QVBRGxcOhK0LZZgUMdn4GOus9AJaKPm+1WG0S6K+LLx8IYbN/QP7i7H7?=
 =?us-ascii?Q?aB3Dm7biF6rT8uyzQ9emN92vwkSqHBN+XnW2nRDb1nRoME92GeI0yzo/3sLh?=
 =?us-ascii?Q?+H5ecBAfkXri1Oi5DZFPoSvMWswO3unzHy13JqSo6zSEmfbV68pExxzivFzB?=
 =?us-ascii?Q?ZgmEQLoUcHe0qGjh/w3QqjJQGWeTdF9xmHNlHlQrcdssFZ6zuwkbMiY6m7cI?=
 =?us-ascii?Q?NRDiISaMgH0MAxE++rEsBNwGDIpl1CLUBeWvFBoZAoX8XLx8itgF8EgCyYJP?=
 =?us-ascii?Q?x+55q5mKtJInSErb8lfRewCg3svB/9oQXUAksoAD4hmBUhfAdURdB5TuCY1n?=
 =?us-ascii?Q?xSz/xpXoPyjkNf0l0sfWp1cx0o55fQCECqGbKaBg54foNEQr/xDq06NgZxcY?=
 =?us-ascii?Q?HgThhB+0dQL/vJxQMgfiZv4UMVtcgsw9G3UC+zLPd9vuZ5reNZi0HCkfNwv2?=
 =?us-ascii?Q?Zv6rpiA/sIiLrSWNM/upmHAsWqaVPMLtZ3Wr7zmTmqfG3YbMECWv8a61MNdP?=
 =?us-ascii?Q?jS58oW7RuSzU7qbRP5RW7qu92DLLeYc4uI8ZCOZNCPsgrMHmNbbAtWhuL7b2?=
 =?us-ascii?Q?B/a+M4VkF/jcKc5x0y/8/rXwLScf/mb8HmKtqRy95YLdFTSoZLhZZ38R3299?=
 =?us-ascii?Q?Syhjevsv9tGyj4IzoK6EZ9vd8bGjcaIymzxNbDwrjaCXs7bOMZhGpcV1Jn3g?=
 =?us-ascii?Q?8Tgw/tykbmTAaNJiEC0aIdlbDu3BbnYWK/HNQg3I+/Uuj1NiUVqWU0SEHCs9?=
 =?us-ascii?Q?hCNvS82Byv7XZeE6Qf3BVwIzSwDRBwauQ/M2fO1QT/GxVxWjZuR67A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c7YOnKUOpYSVZpGQ9exW0qJqU7HXcD4f8iGfEHZQM8zSJDvvlgwvhNKCcfQY?=
 =?us-ascii?Q?Oflxj5JN4Iml8VD4rv6qdP7GnP5O8uOFM36yaeJYzh2Rvw0H/NiGTr0nRd74?=
 =?us-ascii?Q?UZNkFzqsZULLuzlBCY9H7NRjoMXcvFPyclFBOVez/G7hArgIZRcCsxscHh3x?=
 =?us-ascii?Q?u+aCiiZVzxwdS1SQzuBEBLYEDuapd1Q5aKcHcukxOpwB1a6gh4p88BXmL6jK?=
 =?us-ascii?Q?koymf6eiuFL8pHGmEM6gmAU5krbOXgy6WleoFubvwNcOtULAEeoHthN9Y92A?=
 =?us-ascii?Q?Ptj7r5lXvkaWy0vyrMIjxn++Xq6k7j7SFGga/UKYUFsq2TMe459GhpuY9zPB?=
 =?us-ascii?Q?KkwyPcTGqfU9/3ndnDG7WxwhNRSlN5mmttlxSpv1LTtEgVXTY11out/8z8DX?=
 =?us-ascii?Q?vBDyWYcIp79wdqOE2ZpfDzIC9ElzAh8l1aoDBbHF+IALjqF5kyg2TpKv0WlS?=
 =?us-ascii?Q?VblYte0z/+EET9j1F1+UHtyNIDporBlRUDE3N3pTtkowkcPzJAY/YtecnImF?=
 =?us-ascii?Q?DUHBwkf9uh9SPiLdishikZh+leeDNnAiRtOjswu3uEb6G1j7W4aCE1X4xncj?=
 =?us-ascii?Q?ZDZ1qEflSGRl9Gxj18qnqkNV+PI9IGyUamPDKp40EowUDVLPtayDtGCuqPPS?=
 =?us-ascii?Q?ouLJxVmXboku1Id4A8FQ+xYdn3wVTwQH0vairfz12lKvKJxqXtsJgZOIWcNd?=
 =?us-ascii?Q?AMFnt4u2Q8Xw0bT3EKRC7FX5dG6hpuuim+H8XJBOhTBHRTORdG9XnUrjf7Dd?=
 =?us-ascii?Q?v0XeL9D50AsGeI1AQ8YMblc7VP6c3PrpATRpCgPR+lCkthVw2IQhOMZARc5s?=
 =?us-ascii?Q?gQECAn846fmfuiba4Lfm09b7Ch0q4A8aE/xJzMzJgFUU+AHrUSVYwleL5K1s?=
 =?us-ascii?Q?XS2NcUASnzFRqiGiIO+a5bTtCY0j6i0KvwZ2O8yjL+FEdpWAkQU5PH7sroKU?=
 =?us-ascii?Q?oyk8HRSGBCdMb9XN5hsV2Pz4P935iahF0H0VoN+dH5JPafaP77oD/qhSZulF?=
 =?us-ascii?Q?KHUA5NlRC6NBe5U5KVoiWBLupEkoXkdI4WYzKJyqs5JxG8wTWLvkM11G3IRo?=
 =?us-ascii?Q?VeZIZE857YZHc+AwGkhgT0zaavjPw336f10rWSAuV4J4TImRv2iCm16ZYQsD?=
 =?us-ascii?Q?6b3hTYEf4yIHKdYxPaggFyhGkWM8Hfdkxmtwo+rx1g2MZj3DJcjGUhitM/QH?=
 =?us-ascii?Q?z3wF3VhvmWAHLhTvPACbc3Q3P5jwLuXNm5cb9LmDRCyWUoW+M5FHHhitcg2O?=
 =?us-ascii?Q?21tU/tgP8+/FrnVKDAtvNp25BJQAJTfdwallelb/ZrjYTk1cJLngr8goHeXe?=
 =?us-ascii?Q?gSxnGMTlHidPNouEn/7pTZhEtbStLNJNprdCo115loE0erWhxXUu/m48+01b?=
 =?us-ascii?Q?z2uIZfDjTl1UeCxHdj9zIpaU50D+jptu6WoDRGzwjvTlWI3YGbcNcIZCOfEJ?=
 =?us-ascii?Q?Lc+m1YC4igm8fjXkKLNMVzx3oZBWwt8FAGhmPa1XE+vaUQxN0RD3DN6Kogwt?=
 =?us-ascii?Q?j5DwuKkfAONYVoSG5wUi9+QIHu0GpOq8RmAmkPqilTqzeligw0AHJKuZRYcU?=
 =?us-ascii?Q?6IapYCDb+LKeF64IOkg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c468749-b542-4cdd-c85d-08dddc1afe3f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:44:25.2548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZNn43Fwsw1prC9hsHrJAZGCADjKUUocUsHuv6Ctzvpy2YI+OzM/jLc1vLTvWngXeooNW70nUoVqYXdc9I57fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7051

On Fri, Aug 15, 2025 at 05:03:57PM +0800, Peng Fan wrote:
> System Manager supports reading out pf09 and pf53 temperature and
> SCMI Agent could get the values through SCMI sensor protocol. So add
> the nodes to allow Linux to get the temperature.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 73 +++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> index c35a5083c837379804e07f98163c0a5d4301abd7..0ad5707314fb225b74d8940908b53dc2a444ed5d 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> @@ -1078,6 +1078,79 @@ map3 {
>  			};
>  		};
>  	};
> +
> +	pf09-thermal {
> +		polling-delay = <2000>;
> +		polling-delay-passive = <250>;
> +		thermal-sensors = <&scmi_sensor 2>;
> +
> +		trips {
> +			pf09_alert: trip0 {
> +				hysteresis = <2000>;
> +				temperature = <140000>;
> +				type = "passive";
> +			};
> +
> +			pf09_crit: trip1 {
> +				hysteresis = <2000>;
> +				temperature = <155000>;
> +				type = "critical";
> +			};
> +		};
> +	};
> +
> +	pf53arm-thermal {
> +		polling-delay = <2000>;
> +		polling-delay-passive = <250>;
> +		thermal-sensors = <&scmi_sensor 4>;
> +
> +		cooling-maps {
> +			map0 {
> +				trip = <&pf5301_alert>;
> +				cooling-device =
> +					<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +					<&A55_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +					<&A55_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +					<&A55_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +					<&A55_4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +					<&A55_5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +			};
> +		};
> +
> +		trips {
> +			pf5301_alert: trip0 {
> +				hysteresis = <2000>;
> +				temperature = <140000>;
> +				type = "passive";
> +			};
> +
> +			pf5301_crit: trip1 {
> +				hysteresis = <2000>;
> +				temperature = <155000>;
> +				type = "critical";
> +			};
> +		};
> +	};
> +
> +	pf53soc-thermal {
> +		polling-delay = <2000>;
> +		polling-delay-passive = <250>;
> +		thermal-sensors = <&scmi_sensor 3>;
> +
> +		trips {
> +			pf5302_alert: trip0 {
> +				hysteresis = <2000>;
> +				temperature = <140000>;
> +				type = "passive";
> +			};
> +
> +			pf5302_crit: trip1 {
> +				hysteresis = <2000>;
> +				temperature = <155000>;
> +				type = "critical";
> +			};
> +		};
> +	};
>  };
>
>  &tpm6 {
>
> --
> 2.37.1
>

