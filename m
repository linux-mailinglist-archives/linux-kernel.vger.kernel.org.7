Return-Path: <linux-kernel+bounces-804240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F594B46E07
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923F4A41302
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05E92F069F;
	Sat,  6 Sep 2025 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QDuEVEpo"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013015.outbound.protection.outlook.com [52.101.83.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAB92882BD;
	Sat,  6 Sep 2025 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757165056; cv=fail; b=ANfQvQa7NLblj4BGgjozxX8DUxM35h4+5uwbcIyLcO3Nf4JN9D3giNWj6U0/IyrKTmaP476g6GyAJQevEYPnHdnM4IamqHNAL/NBeY11kmzCgJ1MqUacb8vZEzkW5D3fB0HwmohHXwpEBkXO9uTi78RyybQ/oZMPMP8FyQAWta4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757165056; c=relaxed/simple;
	bh=a2bbb81e42UuvWHOgIxhwdBxpNdBoV3ndBwVtXxU6Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=evEYq+5SWkNeYaCnTFE2rEM4ZpFe7n8BOaluerISAsjoI3KiH6NHEQlIaccvMcZbB7iWzZPlHY91NxqoJaguHzuZY9Kbc3XTl0bwZ0NNxLgi5O43nw7WbKGWY5jsqZOwBtx/LCadj4Wm5yqFpko+T/2XHk5jiZuZ86M53sOjIpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=QDuEVEpo; arc=fail smtp.client-ip=52.101.83.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPQ4a3ZKeYWfE5Bmp75Tphubl44mvAS5L96m7tootJ5Qvy7iRwMNDnnHvUBvMYsIYdnrhbP5KAvz300aZA5Z70zVHEpRYAABJXwQE0OIx4PCsqQ2HzsO8D36TmlSgKdt5krnLy8kzEcpESFs2gIPdPEPI1jetCGR8c5Mtn0846fPyj/3LEg8nqvIBUn/47r2mMobFQXwRtk/YRGOz3NXOonJMs6mhEnSlpaqbbic0dve16idBWVW+pIgklZuAVtCgED/jK3nKSs0/qP7WnF83f1WsjjN7MIpsDATQQTQw0za4segnbA1h/oA20eIXS8xC5/TRkPeuGD/YwpWp0Avjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2bbb81e42UuvWHOgIxhwdBxpNdBoV3ndBwVtXxU6Co=;
 b=BvrUX0hLurNzH+RVWHDd9t62s+xIZH/IrrdEK0oHUYLmWnkEplcC5pUZ61PgcujV18p2Ag7Yt6RIesOzGAy6jZU/1lXvz7XGJZNdsEOJe2kCCf0cZ0CAJUXN6Mpv8pCtQupHSvMABwCqvW//2KzFJ+O4z3Z4HACvKVCJ8qGGRVGY6RLZvPhyJYREtWUIj1mSzybv843sSnYTsFz8dYJ9qbwNnlRj8Rri8Q1PPwJC1okmZ2oQ5CiNqIW8C5i90gTpMb+NqiGmOqiU3V1/yahHMUNyzmKoMvHYrdLZo98qSAmHy8wVbRaGjErb7NpfHUKPWbvbX1bO6RlJIFniWaKhxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2bbb81e42UuvWHOgIxhwdBxpNdBoV3ndBwVtXxU6Co=;
 b=QDuEVEpoYPHbFetZhoe6QnwPCevECPwsqNL1YK6HEtP4SfXmU4jiWYGuIXEWrttgySrhgu+eaftKfIRD6PYpI5v0laECivYL3HH5BGHGT33RxDKw9eMpa0KjeMWuUgi5+f+cvZxbsnAhG0GyeuX5q3hDdIWFsXGeYGDJ13/r/yl/YLLqJmcg0Ph3fmTj+qcl6HDIM4F28XudbdTLhY4DAHWxIxgqXMMBHzbET8wIFbN6PAm1z6nYH4lZW9BdVF7VN7u7K5EWEnuRZUm3MpaXT/UBGoBL51Ab3nraPT909Z649G/PClOgPlWJdiOpJkJNpA2mTcSrI6MOWcwPQAZ92g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9909.eurprd04.prod.outlook.com (2603:10a6:102:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Sat, 6 Sep
 2025 13:24:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.018; Sat, 6 Sep 2025
 13:24:10 +0000
Date: Sat, 6 Sep 2025 22:35:36 +0800
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
Subject: Re: [PATCH 2/4] regulator: sy7636a: fix lifecycle of power good gpio
Message-ID: <20250906143536.GB12656@nxa18884-linux.ap.freescale.net>
References: <20250906-sy7636-rsrc-v1-0-e2886a9763a7@kernel.org>
 <20250906-sy7636-rsrc-v1-2-e2886a9763a7@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906-sy7636-rsrc-v1-2-e2886a9763a7@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9909:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef91881-bb25-482d-fabe-08dded48aa2d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vr1zKH90n1gQoCM+ZNxnz33IYkjjqhs6sytqqh60heZkFZwfLssPBE5/1RKG?=
 =?us-ascii?Q?SbGRLYAmjpNYook3g6o8IDJf6S9CrLy1Fbulai57W8Q/nNpXdbnOw+XfMfJN?=
 =?us-ascii?Q?J4ptMpz9VhZkcIo9UhWZ4PUzDfAhUWQXNikSWqepDPXNdqJiyBCe8iES09lR?=
 =?us-ascii?Q?rdlMl9X7Si3Liir6Qh//EfahKFkzLxYmSp2H5QPXqRWfjfeyOPsQdl4Gzd2s?=
 =?us-ascii?Q?WKTtzvZfjVCx4rt8QVVaDU1WBNig7gsq2Lujg2vmcn/8Cfka2t0ED8mw9thw?=
 =?us-ascii?Q?jKCo0p4Mo5vuoJsXBJIpFEA1xoR658Vyzqoo/5rRjK8snovuPaMcPDBaL2m2?=
 =?us-ascii?Q?8zPh+qDSz8pykE8w+xky97BWJ3tThG1wkyJU1D2cNdMlVNxcUPdH9wb3xotm?=
 =?us-ascii?Q?TuROANpO+zZ196aHUiIc2fpJTl51Zk5e+CrVxgmGxcwr0C+hfObiJsLMfwZa?=
 =?us-ascii?Q?65dfvXVhtm9hCm4w5ee4HY0jz0Qli4zhFZ+QB8aqKbBqmuUhU6GU7LqAhj01?=
 =?us-ascii?Q?Z0ePnI/wSUDZ4wt57YqqKxmN7WVM9F0BMdJDmW0uv8DTms2uUfbDIJekKe+k?=
 =?us-ascii?Q?XqCEYz6obnZFD/p/T2PNB3+MpNTNEDrWTcic06UgEKssvv3IG7wESbEs2blU?=
 =?us-ascii?Q?MZK+g5cQqMjLlrnH3QSGW+HVV7lXmSSElFzxP499PIqrIhLMeFBTMFkl1Lnd?=
 =?us-ascii?Q?sXAEC9F6GQECsaGfVlUoDdOxt4CgQTyE7mqrIG6xQGjR2O9hdbDlytWgqUem?=
 =?us-ascii?Q?zF4RiiL0YOkPwzbxqbtG/m0CZFpvpuJNT23vI4s1UvcYahk5jsKeB7uhNy4j?=
 =?us-ascii?Q?E/VfMhlPQkT7DDsQI5lTkGe4hk+hEGRyryIQrM9uQxrkj3BpqkfgMO5wt9La?=
 =?us-ascii?Q?As3UxQh0EqHuzQcbUhOCxF9nAXxN0xRTTK7dl1PTkcPxPATrl1HpzxSsDORm?=
 =?us-ascii?Q?7DSoHNBc0GqfNscR4e1QAKunW4AuyaTa84bTHBaWFQsmtEHIOhndgZLeYWXm?=
 =?us-ascii?Q?h5mSwr3AWReRSBgqEHI8FiDLfRBVaGBX3XccsvwmpqK1QPY/eW3dwmRermTD?=
 =?us-ascii?Q?pKBwOtCieGGr9tFQ110UGzI2bRjGF2fs1u4xYR3S8L0hWMYExhbSRba7YTty?=
 =?us-ascii?Q?sBSRnNkkdFomtqvpFke/DdTDeRW4EvkKZG8RvtalhAeGSetrrDoKNZMPuryu?=
 =?us-ascii?Q?llstJzZyjtmAgoqEFi8aZhxbIuE6RuDu9Wm96Mhuv11f2P39LG0TIabaGbIr?=
 =?us-ascii?Q?Gv6jADCnnLZOpVF+veghumb0YVOKUNo5BMZzzOsEocmrJ5YfGtNl4zZGsFjX?=
 =?us-ascii?Q?M8SuPJOcoAQDdXw3yiq8fWsOGjR0M6km1jOg8Gh/amqkRtF8IGvfuKlgRopf?=
 =?us-ascii?Q?NaM5jXifl7z90t1sDxqcoUWa/aKsIp/f0gbnp36nFlXHQmADTCbEVIrQbcKm?=
 =?us-ascii?Q?uO9awel9l7vxd4AAGjiLHwimaa8gCgtrv/JPxK6WZp6H52P1wuXsgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jtDar1Fs0RU7LqjEX6y4IFscjY7bv4gNp/uV+Hh7QyegIxPpb9ZHWnyCpkgm?=
 =?us-ascii?Q?BRo3VtYm8oohXlGNHa840tAH82tWzTfjzAOhQbSClDo9CgwFiADZuJN/iLSn?=
 =?us-ascii?Q?nDEsBTRMA1nptw0hr4T18HdB3/6Ha6ChTb/sBnGf/oqEWI5ko89vGyAuCNjL?=
 =?us-ascii?Q?dAc0iHKNxKfzH2BQyVzlQwcaeKla4Io3OqHH1sPw5aph7HBkfZHEtZVTM2vA?=
 =?us-ascii?Q?Ol/6W8DR46+M4LD55GXTjVoezH/BaLZF+uCBWhVBn7NtS+jZj0jViOt3abZW?=
 =?us-ascii?Q?4PntEKngz/GJ64lVGu4KpwUldTfKWdzQHpywoy4aHUvk2tyrqE4IunvV0dK8?=
 =?us-ascii?Q?24z6ZOz7F3Kr26f2lZwuTRudl7N/r8rLNz41FeKTrgerTOtFb5x+N9TIg7CL?=
 =?us-ascii?Q?zBQ+FuzGHTi8xIwl3w/jj0fdlsbNOl5YmM3vpg3J2R12gdI1HON58rmtVZbB?=
 =?us-ascii?Q?gQCzvYBjFjdcYgaTxJrdxnFMIPNUv2s5dFQ3MJ+HODgSKpABWvN7Ez1SzkaW?=
 =?us-ascii?Q?WHLrvtzFGG0gS9FyPHURcGh2C2lWedsZLIIcC7W0fOw8OQ5qmb0+Bh7CkK0i?=
 =?us-ascii?Q?usc7PEUSliC8oJrfjLxyns5tFr4t7y5tflEp9ea5w4uvZNq7K8CgduUNuYaf?=
 =?us-ascii?Q?aJox+uAbt6pd3ESY63XemlaPuLzCgIaACCYxuOQNn3tTdCZQ1NkV4CuBzUbD?=
 =?us-ascii?Q?5vhXsEucK7lPkApgL3idb2ztAsIRTL+qCgUFllz1GkneYBNI0yyOdnU6NoT6?=
 =?us-ascii?Q?9DzLBu/FG0n+lJd/JQxBN6V5N8xJZp3kbwkBi77ImD1Poy6Y2qSif+PrRuad?=
 =?us-ascii?Q?T1ol8bUU11EDU3zCNJaJbKge0KSluNtnuq4OxJZiPj6eknFh9bg8aa4UEPWm?=
 =?us-ascii?Q?iFR0LLn7HsfZ1wjfW8y8Z359DoAM04L7kunhJ/RNA/w3H4k5+h72WXfSOfq7?=
 =?us-ascii?Q?Gs1vBtUoCPJq3ZL5iXjQttGY2g+izXocAd+Y21OJkMPxb0Y92qSBz7HXTMr8?=
 =?us-ascii?Q?S7jx3AkNAoKg/KbGG8AqVZVPcKJpPPYwc1Aui4n6BcCTNOdUqnmq9UxaXVlc?=
 =?us-ascii?Q?ZPSKshW1BnkYUM7mKLBtAgzz90GV3K0PGuc/rFIRRbnPsDFFmvP8g6KWr4T4?=
 =?us-ascii?Q?UVUOXXP1NwDd4BlCEZhJM6yu1WaO4nAqQtSyOMgGdz9ro2tH0kyXMyrdYx7t?=
 =?us-ascii?Q?eAf7FkugeyH0NuJ3ltKS72tTrBZuJUdsZwODBquV/lyxhnHMn/d1U45d9YqJ?=
 =?us-ascii?Q?x2mqtmuyHQ8FYoJhTVHlTsWNfmK2oqt9EjUEtRdp6HcdfcfpJ+47/Pxjwyxe?=
 =?us-ascii?Q?Ou5zHRACHWQGkgcDn1jK1buKHEguAYPdJpsSaP6kREjopcMYVw1EWvGpcVOw?=
 =?us-ascii?Q?B3Vo+nbRT4fHo6KLu42rzDHgzfWFfeKxO8Jb0Sdq34cHvX5tMjC+yzUJhM5n?=
 =?us-ascii?Q?KYgiFFSRap2VaA14IHVnE1is0nnVjWZIDFEAG2SGc8+sThPfk8uAKF0eLMb+?=
 =?us-ascii?Q?Z4lSRORvQLfPPe/Y/aDP69hiqefSYjASF5UW2DDidkoETuP4OlFEklKYzW/K?=
 =?us-ascii?Q?024vQhWzg55FKThhPcSylKbZVT9zvxLrz6wvBYoE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef91881-bb25-482d-fabe-08dded48aa2d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 13:24:10.8927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUg+tNYIbk2pyCwQc8wCj9IXsQdJiYMRJ5Ugc1/EFheBYRKWJ086swXJtcVE5GhnX33nHj7SbzlssM5BUR/5Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9909

On Sat, Sep 06, 2025 at 11:09:13AM +0200, Andreas Kemnade wrote:
>Attach the power good gpio to the regulator device devres instead of the
>parent device to fix problems if probe is run multiple times
>(rmmod/insmod or some deferral).
>
>Fixes: 8c485bedfb785 ("regulator: sy7636a: Initial commit")
>Signed-off-by: Andreas Kemnade <akemnade@kernel.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

