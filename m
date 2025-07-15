Return-Path: <linux-kernel+bounces-731219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A47B05133
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDBB31AA7FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6892D1916;
	Tue, 15 Jul 2025 05:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="t/SdT/4h"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010005.outbound.protection.outlook.com [52.101.69.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73862265CBD;
	Tue, 15 Jul 2025 05:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752558446; cv=fail; b=pyKIvc5msreB+HZ1LsXcWnQO+fqkALtyM8M/KOh2uUOarBA1RTj0bmVBorWJXF7cn2WWvowpY6knBUbeZbWuqhktBXBu/SFnBiU8NKJxB0VePU7+j5p7RGRKOuz7S4+Nur3dIK6Raow2oI4wedZEHDImwN6jjySdUrVnUUbu/zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752558446; c=relaxed/simple;
	bh=KCjGKzWbWmzfueUUC3Iss6OqNE5m+2lHSR68hwNF2MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ChmdvWDVj8fFahjgz40KxhlyA/13fx30Njf4oa3CA7sAPLKPsP+A3dIS7NBw9PXlNR0nthW6OSZNcGzLPP3hmJwt0dnk4kaQe8N58nCYF6gFUh/Q9kfXkHt9nHX2itJRvIG3dO5NZgl9G2FCQPmlm3QPMWFTTv5VC6lWeqIlXX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=t/SdT/4h; arc=fail smtp.client-ip=52.101.69.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFJ7AFtQUh+Yhuom6BCs5NRcYAORd72dxN4a3O17UPh2F7HPU03JDVNL40eEQHMMPqx158pGUbjSFYKpQrFRJZ5rz4NXI385PPKkhlxcR10X2u8ZD1VXTOwaBG9cnE8nk/+wqdokk9WbQfomTdUjgVQ3Csh68oxKjouzCOaKkQRuHbeTGFdrSwtzkytfsA0UIO6GbXOPBDXAZQjHK7TDOj875oa/F8W+aWFkQRaDbVLhp1eRCsXCBNwzsVcCsBJ3s48SUxE17NCOP29dS00abDAv7DW0Zt0uyabfrxQb2Gm94DYktUpPptKCZaMwWwIdPwJ4uyBu5N3XfNACILEImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SBEDoGFPiLPL3Ns4pnCJDA527hjLRBUGiMYrqaB0IM=;
 b=AmcTMXSBfl7OmzyV0ll9PKe5SqjNSp3SRS7qNb67gZQZNXHY6XL5In8m/u2R43836RX+pdx3QbysVJp9WoXVa1juQUoyW3NLDC7I9SoZReOfO6J4g8QQEgr2RR0S0LXgIXCrB0qvSOxKzQV/em5XfSakJhdb+OHjA9RpzTvnuftSWmKQxyEvzhFP2S1uWieO0UhzGB7azbB+RNOYBDOnNW3a6w0Dp2pgR/EORXOjwK39wnp2BaDWe0Lu9/CbTAgLcqAbAv1fQnGjAEFQumjsc23l2Zoa5ThAjkvpxCPirHNiM9SAJiQWliguhcQrzlgr+HBxFiItGgQGc0PPDZPsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SBEDoGFPiLPL3Ns4pnCJDA527hjLRBUGiMYrqaB0IM=;
 b=t/SdT/4heYRPPA18AeX3afvS3XisfZ5uRFvDIQg+RbhciA1oMZ6VC3yVisQjeuUEVTfywFSZ6pubD1PNctkuma2seb8Sa7V8/JNt6Y9QlS9sVj2XW40Lis8ZreRF9uEpURMiukMbrfPSOO22apn3kV9lhcvTCnWi7SGyTNFdhvtV+2O0KbNXm4EsDgclBvziyoU3T9TgTDPK9qjc35LrETDiUvotXmXPBVufI0qMWzGibtCvF04v+G6wzn2D7l5WgpPuAJmg5Wq3lhjSC3PvTSzEXMfaBrXxCNtXaLrDzh17iQTmsIzl8IZe01NZE2gAsQEuhtNo1OuyHg8Z86nwGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA2PR04MB10311.eurprd04.prod.outlook.com (2603:10a6:102:413::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 05:47:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 05:47:19 +0000
Date: Tue, 15 Jul 2025 14:57:42 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Maxime Ripard <mripard@kernel.org>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] clk: imx: convert from clk round_rate() to
 determine_rate()
Message-ID: <20250715065742.GD632@nxa18884-linux>
References: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA2PR04MB10311:EE_
X-MS-Office365-Filtering-Correlation-Id: e22ca01e-6e6d-430a-ae7c-08ddc3630fb9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ocNe+gtMdQG4moBmpOtpy9ERLmof25/AtUNHGz6MurDxj+bmN6xV986DZmfl?=
 =?us-ascii?Q?eYpdl2Tiwb7B/jzGqL8DUtzUvmO3Lye0wbc44FaAvLv1dVoT3lIM+yJBF7dY?=
 =?us-ascii?Q?cTR1cc5JOCkLDx55LbcWaCGi834RtsU7ZLLJw9l0HTvgsr/sLWCRUXzveV+S?=
 =?us-ascii?Q?zUKyJHt6x7PDnwypPoJOZKRFPoLFZ/elfsR1vRl0/0LGpnCHW4I+8M7gcSi2?=
 =?us-ascii?Q?nac7jlUy1ex4nCFNc8ev2mZ32iIJVwp/DdSDouARKBZOMD5Yc0+gHyYHO8aE?=
 =?us-ascii?Q?ws4v+JDl6NwADiRg41xQtG0SbpV2U7rmiIX6LqNio2iE5bCd/x1aaCyIpvmq?=
 =?us-ascii?Q?xGhsjaMsppmzc3nRY8QvZZ5xoEua2xkB2B8pHleImrrXyjE3dNdad23EfmNL?=
 =?us-ascii?Q?hZKyoEARdlMIC6EjU/g2zWJt8WbQUyb8MGRxshhm7U4x3g9kCwX1V6mRDRQr?=
 =?us-ascii?Q?Gbd3cQBQ9ZQE+oV/lu0Xu0GI6ofXOx3abQAdWd5kY+P5pQsQZwE7cS6/khYN?=
 =?us-ascii?Q?1kwe4ki3TjTnLN9BI5Tg4/EZJTrwuP4L3FrdIwPC9UZdnH88rpflwMwzOGNh?=
 =?us-ascii?Q?olH3kZ419etM3UNN8s8ae15E47k9HqkfHhWkegRWJH366Fz0ogIHJsAkomQG?=
 =?us-ascii?Q?kjGRNCDXgy2OlEiLe91W00q6qC7PAjwDdu4JwNCMuhIwI5/c8m8wloyOV6wf?=
 =?us-ascii?Q?rypciP8PGyupBf1eVzX6RWrQJXoHmJNKMuKXot+Q4cA7ycrUjJ/Prb59CX6R?=
 =?us-ascii?Q?HNayiegZUbYui7H203Qx2hIGOj/ji6/ZwUaRhwKgMyxE2UjZOe5dgTSRInCR?=
 =?us-ascii?Q?rcKhCi8w/vSiCqTFEyRlUiznCUVaNItTKzSHEp6uSk2XITNLCAkz690O3diE?=
 =?us-ascii?Q?s59B9dd4Xm5XaUzVsWahMcEtNDwiE6rFyFQ5qn+godugMLS3U9i9TqqcQPRS?=
 =?us-ascii?Q?fpG1IR+Mef9noy2Bil1g1/etbLI8Agn7Rna0vAJ2wGDJ8eO8eYuGRvjq/4GY?=
 =?us-ascii?Q?W0JEkhrdpla9EgVwzBCWslGwVxYvqH0zs5icYI4qMmkjfVHeVf3yeKabrK+j?=
 =?us-ascii?Q?eto5JCF4GZg+W5UtUJCpxrfbKzuHJimQMv+a6IjEj+iMS0an+ljhnTWEQIDu?=
 =?us-ascii?Q?qk/HBYe/LBBx1gGqdcu5iK4svtJWZaB1Nl9tClyhMBrwo75Br7hUKKKGwwc7?=
 =?us-ascii?Q?haHkrMcq35ff9JnEIyP4pNUnKvBJS0kmJmb3OoTkPHWkF3OD02sQ14VnpvTU?=
 =?us-ascii?Q?eBDXwhTOINZb7oQoL6iSlTCUVRxwuD8Nr3QIqSx/VCSOMqVBNo/fTiBnC5k2?=
 =?us-ascii?Q?8Xljqt6LI0sWA4gKubb+91EgXV/Upi3UJ22sfEOQBtBBi3FuFGS7M6reKOBe?=
 =?us-ascii?Q?I9YSB8WRjLl9bqdgKce33aU9xxDp2THmhlmzBDUOCjgeyM8lvlk1HGq7ugAC?=
 =?us-ascii?Q?wLlVWC4zvxQ0Mj5qm7+E0Ja32qhGk9NeJEgyjB0KDXVkw1I+FQD6rw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9ssu7gUVkDypsOdMAa0vwqwLUDbzVhcKlDYFJ/eAfoKm/VWVY2K7aQR/Arvh?=
 =?us-ascii?Q?4M+USDAsvv0v4kZ5GpX/wafAkZa7l0NXcMRJMMn7EtwJXm+plOt0E4eHphgj?=
 =?us-ascii?Q?GtAicKAA5EM4BCSHFlChdGyKk88cO5hqiWS2vxbiQMalMt66yoEw9MsTFnUG?=
 =?us-ascii?Q?5DqU2RYCoisyg3furl05oCXaTFMAvCT5y5AzRLXkL+AY+uTt0Nn6TSbyApo/?=
 =?us-ascii?Q?idTNyppRGQiPrh1fagspGy8U1qX977qWdaqkNWFDjWyoswEfzrJEwdE1KNlq?=
 =?us-ascii?Q?0DSk32MJodkAXg/6MLyWD+PjzJ60pXEl417taZClmK8m/xXW7ijQUU5sKtfJ?=
 =?us-ascii?Q?AlTsbwa1S3F3WT+GHqMlNMvktA2m/z96R1krRXVxLHRcUkQQCzyH8Mr9n4kS?=
 =?us-ascii?Q?cR5lKRWhVNuhgSVqSO0PZob1Ouscj/0VAysfphCGaCglh0NJWmAwYQ4SGyZM?=
 =?us-ascii?Q?z8jiK83q0tenUuFsRh5u+fej1wsR9aC+o4eCAl/xP2E1K+Uz39zgIFGaXEZp?=
 =?us-ascii?Q?Xja/SwTWA9QDFy1SAloRV2f4ZT6uAW+f59RiA/y7ChDNH/mW21qKNkAWUMt8?=
 =?us-ascii?Q?Chk0juIdqcc6qkvoJroOHznBk2L276tMabp/KdYeycDWLhENBxwp+qeJQssO?=
 =?us-ascii?Q?GbT6rd3G3SyMAdafVkXb1HdUiMKC1EytdNZ/bwu3g9f4rP89GHZEShATMnqS?=
 =?us-ascii?Q?NmtIqpIC57mL9iG6rr2uf7VaWMCceDgUGphhVg6Jo9lWK91OeauVssr+DZ4A?=
 =?us-ascii?Q?6609aQ1qfW7AQ+BGQ3oBrqf+h3yg8+kxfg0gvtagQZNSqGKRzSCwxUPDwchS?=
 =?us-ascii?Q?zsAsS99iD3cR5akIUoEQTSAtOWZioCiVwQuaGVwrm7QBdOTaPmL2pz5JM+Pc?=
 =?us-ascii?Q?T+dTOWDv9Ct5q3/+BVikMun3lDruGOkxJYEs4TS59WHmeEuYHczypBfxW1mo?=
 =?us-ascii?Q?B1On+HsM6jCMLjlrC75NM4SbNVL5dMod/8NTSUELX5QlKUdrvH9lZF4Hyp65?=
 =?us-ascii?Q?b8JIXjzIGDrNiNFAi5Nf+xD1xs/a5X+uXX2LWxtCG/biv7Uwl8UpshqWY/4V?=
 =?us-ascii?Q?4B4sDzKQnk8ah8fn46tSR0r7N0q8R/08oTwQLmnDsVKMAmXrriWPlwgkFBS1?=
 =?us-ascii?Q?W+bnoFW+8syw2+5f5NyLWqLFMuKic2Gn+svdp+QVSNsHqXcTda7QMipcxPxY?=
 =?us-ascii?Q?xerIT7dG9vr5uhCleZeXOHCYfCkP0Ehq0Kkc4hUo4dLJQQP7MnQ53HvesRSU?=
 =?us-ascii?Q?dYsrXhE7UAsJBm3mUHKKBpnMfN/GLFKunCh8IeH1099dhXkhZp9QxhJtYCTt?=
 =?us-ascii?Q?EHAdPagHOT8Ypu+k0rDrI1l9JH5nRl6RntkuZa2yyaw6b03+4u3hIrP+7aZ+?=
 =?us-ascii?Q?80iyiFFyVUY3tVjiM6T83hZTm3IndxZ4g1ceg/V7OcinaK2ADxLD1KxMjn/n?=
 =?us-ascii?Q?HCYEFiXtdHm0ovE+6rdTgDSyj4jvBENM/FBevPj1Ytwe7BmVBMsP3okV5OPS?=
 =?us-ascii?Q?96hlNa+fUtW7nHqpiGaaA8dY1xItM3GQ59gNUHs682tKZCSfB4iRUT4quc4V?=
 =?us-ascii?Q?UmmjpKpvwNU0UbsNSGh1F6g43th5W7et2h52jWnD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22ca01e-6e6d-430a-ae7c-08ddc3630fb9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 05:47:19.2017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U73MjSIboTNWGDH0fJek+vR1EpaL0ckD+itAS3ZPU2p1tTFrbVQiW9rEq1N+fJwvTUpQwfKrsoncsXwvAh6kKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10311

On Thu, Jul 10, 2025 at 05:10:32PM -0400, Brian Masney wrote:
>The round_rate() clk ops is deprecated in the clk framework in favor
>of the determine_rate() clk ops. The first two patches in this series
>drops the round_rate() function since a determine_rate() function is
>already implemented. The remaining patches convert the drivers using
>the Coccinelle semantic patch posted below. I did a few minor cosmetic
>cleanups of the code in a few cases.
>
>Coccinelle semantic patch:
>
>    virtual patch
>
>    // Look up the current name of the round_rate function
>    @ has_round_rate @
>    identifier round_rate_name =~ ".*_round_rate";
>    identifier hw_param, rate_param, parent_rate_param;
>    @@
>
>    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
>                  unsigned long *parent_rate_param)
>    {
>    	...
>    }
>
>    // Rename the route_rate function name to determine_rate()
>    @ script:python generate_name depends on has_round_rate @
>    round_rate_name << has_round_rate.round_rate_name;
>    new_name;
>    @@
>
>    coccinelle.new_name = round_rate_name.replace("_round_rate", "_determine_rate")
>
>    // Change rate to req->rate; also change occurrences of 'return XXX'.
>    @ chg_rate depends on generate_name @
>    identifier has_round_rate.round_rate_name;
>    identifier has_round_rate.hw_param;
>    identifier has_round_rate.rate_param;
>    identifier has_round_rate.parent_rate_param;
>    identifier ERR =~ "E.*";
>    expression E;
>    @@
>
>    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
>                  unsigned long *parent_rate_param)
>    {
>    <...
>    (
>    -return -ERR;
>    +return -ERR;
>    |
>    - return rate_param;
>    + return 0;
>    |
>    - return E;
>    + req->rate = E;
>    +
>    + return 0;
>    |
>    - rate_param
>    + req->rate
>    )
>    ...>
>    }
>
>    // Coccinelle only transforms the first occurrence of the rate parameter
>    // Run a second time. FIXME: Is there a better way to do this?
>    @ chg_rate2 depends on generate_name @
>    identifier has_round_rate.round_rate_name;
>    identifier has_round_rate.hw_param;
>    identifier has_round_rate.rate_param;
>    identifier has_round_rate.parent_rate_param;
>    @@
>
>    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
>                  unsigned long *parent_rate_param)
>    {
>    <...
>    - rate_param
>    + req->rate
>    ...>
>    }
>
>    // Change parent_rate to req->best_parent_rate
>    @ chg_parent_rate depends on generate_name @
>    identifier has_round_rate.round_rate_name;
>    identifier has_round_rate.hw_param;
>    identifier has_round_rate.rate_param;
>    identifier has_round_rate.parent_rate_param;
>    @@
>
>    long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
>                  unsigned long *parent_rate_param)
>    {
>    <...
>    (
>    - *parent_rate_param
>    + req->best_parent_rate
>    |
>    - parent_rate_param
>    + &req->best_parent_rate
>    )
>    ...>
>    }
>
>    // Convert the function definition from round_rate() to determine_rate()
>    @ func_definition depends on chg_rate @
>    identifier has_round_rate.round_rate_name;
>    identifier has_round_rate.hw_param;
>    identifier has_round_rate.rate_param;
>    identifier has_round_rate.parent_rate_param;
>    identifier generate_name.new_name;
>    @@
>
>    - long round_rate_name(struct clk_hw *hw_param, unsigned long rate_param,
>    -               unsigned long *parent_rate_param)
>    + int new_name(struct clk_hw *hw, struct clk_rate_request *req)
>    {
>        ...
>    }
>
>    // Update the ops from round_rate() to determine_rate()
>    @ ops depends on func_definition @
>    identifier has_round_rate.round_rate_name;
>    identifier generate_name.new_name;
>    @@
>
>    {
>        ...,
>    -   .round_rate = round_rate_name,
>    +   .determine_rate = new_name,
>        ...,
>    }
>
>Note that I used coccinelle 1.2 instead of 1.3 since the newer version
>adds unnecessary braces as described in this post.
>https://lore.kernel.org/cocci/67642477-5f3e-4b2a-914d-579a54f48cbd@intel.com/
>
>Signed-off-by: Brian Masney <bmasney@redhat.com>

patchset LGTM:
Reviewed-by: Peng Fan <peng.fan@nxp.com>

