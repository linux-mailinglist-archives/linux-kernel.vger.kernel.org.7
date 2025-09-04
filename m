Return-Path: <linux-kernel+bounces-800290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A46B435D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B7F1BC87E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D712C11EF;
	Thu,  4 Sep 2025 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lEt0HpEi"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013039.outbound.protection.outlook.com [52.101.72.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708AA21D5B3;
	Thu,  4 Sep 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974938; cv=fail; b=BwjNyIOY/KFTKL5VV0VUpl7tIZFyepa9gA5OYs8/cyckmhGe8OumooqWlVNfD9g1huvOCPwANrsZJCZFUGtvq6BbPqxLl4/i563l0u2TQ5KU5LSLy0E5nogaP9ozZz8mjB35pO9B6HCqBcb7DP1ysUeEdeLoLrBIxj6OgvVwzu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974938; c=relaxed/simple;
	bh=Fxxm9NQRthfYM0xuOJ9h1tn2K47FZa/Hdv3MP3ra4Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=snkw64Yjlcz6pJ0/Mtr0J9+2eWSZq5v8hogrDyKgavdcssHNx5Y06917XU3MD4TovJQy32JJE9VpktD1hbCUBFWvt4GqJ9HstENobK5A/91eMGu85nKyUQlqSC5Q1L6LKclsR+bowPw06HwMGvEu2kRPo710EZ3+Y+g5bqIOVWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lEt0HpEi; arc=fail smtp.client-ip=52.101.72.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ri2s7Di3RbnNRNCP5FnkNDa5dCDlyVRJLLMRDKXVsXgS+rOcxHF8izgQIBtNjR02OoddMq31V6dqWc0dbuwKDSoKdts2Z3B+7jHmXi0pJv3OoXfIe3lOgiZDWSkvMnJCatLf7Lv73kFTKNJD6ZmwsEBAtdZTjYJCJ3k3BqSVynmE5LfEDx4WUp8aMT4UHXNF6lN0tWity6anf8WBOzxFcPzOcqYevDQiPuhqjkrHnFX6m0zc4cH8PD/BiHDYSzP/G+4hBiHs+4D8fot/JhIzTZVnCPWgg457YUV3KzLMBXI5NOu1z6k25RiHiXH53DDYnKWbXKI7g3oMLW9h0LS8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlNx9bGxoDnjKd3QNWNUBtCaXIClePkwTvYWvTU0td8=;
 b=pTOaBVl49cP44zfwuzS+Rpe4qjpZtNYxvyAdp3Xn9N0yvFcaGI94XPUsTsdG/1f0nSXShK2hnUvKgQPGqfQJ3ckLQXWLkhOCvuIaK9cq9l1ZYZzWHgDwChgDrvTW0kIULabWbvY/G619RYoP1NdxSRZ4AB9iYAXpgbsAUcxa4Bqw8LFWzsidjIxFezUgGCCU0waRKNbdOJz8u6WhClBOdV3rsViCSy2VghDroPuYcPU2F8EvF8HtDo50iYyZJnPAC7afAKx61e21vD3yZBj/n3UoIzz6NR2foU7ZIbwkUZoPwSIRZK4IFevbi+xU6wThZFDrBTocHF3XSrvLS0TwTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlNx9bGxoDnjKd3QNWNUBtCaXIClePkwTvYWvTU0td8=;
 b=lEt0HpEizcjcY3cc98OKTgaTw1y36EGRViKOBH4XPSDw4EgUUcYsLgkut3ozr0Xn+b310Lef+RR664UNi2kYOYuWGlsO7bhPr3Ur+JIx9KrpDZHHrIVjW542RtXUk6j03fOkFML34Ti3rpzK53taRhMSzwnedLcJ1xUIqizDL66Tzkjj8PJxky5YRezShPV2fvLuFBCjkBVTjUiTicOBloOjgF2oJOWyMFt8CYeEIytf+XPvoGyql/iSjPvJX1qbNg5swXBgBVFLTZUIsco0jBiAbfD1IJnLmgTOFxWajT52n8huoR+oLgQvHWm0Yu4lgzGSICrh519KkJDMwmFI8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10828.eurprd04.prod.outlook.com (2603:10a6:150:227::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 08:35:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 08:35:26 +0000
Date: Thu, 4 Sep 2025 17:46:49 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] ARM: dts: imx6: clean up some dtb check warnings
Message-ID: <20250904094649.GC13411@nxa18884-linux.ap.freescale.net>
References: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10828:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc36807-031b-4aca-595f-08ddeb8dff0f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rC4VlbB65yCesw3nyNDQV0ht/QHAKHPq/AR6clQf9m1oT18hlQg/anPOa7PN?=
 =?us-ascii?Q?Ge9TVgQ1z4xti7sLsUZTKZuRDb8KlLF+kqcM+9VFW23WnzJr9rTfmoUq7Pr9?=
 =?us-ascii?Q?JENXKB+8PJFhTpLY9HE7fwMXVp1rzy398GfHPiiAQ2zzckYb7DEeHUc89+WC?=
 =?us-ascii?Q?XBaaXaFecwVzA/1MRuLyr6j5Jy10XlMUwpi4Du8TBn2c6H5TbOLKG/ZGK0wr?=
 =?us-ascii?Q?QEeJYmllB3pJQJaUQ71v5XgJy1afJspo1ys+oYoUO8n5g/7M18ewv4Kkui+d?=
 =?us-ascii?Q?roia7AxD1DtnAedKISIt8bw38CXFBRJ5UpxyYbx+MMRvHmf0bvbl1ipQi3VS?=
 =?us-ascii?Q?HwCrhzkwBSiSau+Coeu1Y6AwnKrIuRLguKnyuy16p0894jTgtlS9uQbunZZy?=
 =?us-ascii?Q?thJSEgr6wr/IWUkJ1bRkpmUpoHlC5PoQ7xzkRZX1z0tVnUx70dd/whc8bzYO?=
 =?us-ascii?Q?rC1qs6o3ldaVQVnT49fb+oFrxTXvhIOnv/uN6LTLHU+jZbCcn85CQUIaZusG?=
 =?us-ascii?Q?R3lI2oInHJfK7gVQXs862gEJgx5SeL442pfrYWxSMQT5JFCcXqDRLPgUVFls?=
 =?us-ascii?Q?Hq0PfzXd99UPmYVpeiUo1S7MdKMmp5DAnW8mq7UubyeF73PseMzuf3AxLzws?=
 =?us-ascii?Q?PG+/RLuIlXUDirUZ7rP6SVc8A51gZNxz6YyY0I47TkmVNC9MYp4yz84ZcAuw?=
 =?us-ascii?Q?nVXS6hQKwyIE9bB7kRMpHAwSDx8c+YZgzu9qzlPmk9JIHskrVIOqHDcmcdEn?=
 =?us-ascii?Q?/SfBCsm8Vng5d/pIoB6r1QuOotCzQT0oNz0K0G4OPei11OkSnbAsznHyx4Ly?=
 =?us-ascii?Q?XJdX0f3czTM7rCFqixs6AtzSRT6waSCO8wnr/VWmob9N1PlB/shlRiKrlsJn?=
 =?us-ascii?Q?XSjYJ2kT3yOSKkQhPv6mEvRiKMKqvHmDJJnXm0+GSzXFUnxiB4Fw7ywKo0//?=
 =?us-ascii?Q?ZWEpBDP9V9Nsu9Ycu8piEx6dqAeNf3PFwAHHB6U4dyTRspOMzzE8KoSQAe/8?=
 =?us-ascii?Q?W/a/GJ9lP0le05I52ruv1KA0uKcW88/QvXqUPgNANxjt1nL5ARe5UXb3y3xq?=
 =?us-ascii?Q?KunK2ods4BVy78limQZfoEcolAra0Q54SsR9YKX0oOrxtK5cVKGUGJDMjK4B?=
 =?us-ascii?Q?JalMZ0tH7909zp9sLqRmBPEtkK7uHAKuVIKaJo6Hg+kO8bYASsmSCTQCru+1?=
 =?us-ascii?Q?k2AOVuVURKBcXDhN774XVpqifl53OEraz73N0IQA33IlzkNwDjuaXG//ARQK?=
 =?us-ascii?Q?p6tLqhFwwLFOYfUnkYJZPOvPHRf8Uvj8ltN9CCw/X7EhScfWbwSyygEeLxWx?=
 =?us-ascii?Q?gzdua8QcQhw91XxSSlMlfPhqe9g5bpWcxU5/NLcPgwxxYZ6NPvmo/NSCYcMF?=
 =?us-ascii?Q?ifiGoJI3NnBaEVzyEukB1R+00AhLLK9oPMdEYCst5CG2E/fhIG455zEhjFRf?=
 =?us-ascii?Q?ePF/XMDhdcHqs5umbkothv6FO+xdUnJd15HPSxR7s0kioVC2eQJOcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8JuSL8jjB3QUli2LaGu/SRsqat1rsFaZIaZTSj9UVovEbb/A7EDNHpiR/qxM?=
 =?us-ascii?Q?f4At9vznnCanW5mjBI0d2gS24r5hja7HwRX0t9VwF79dM0u75uOm/olWD9KC?=
 =?us-ascii?Q?tMy0cRuG+ITd1d08zY1ETbS4Dp2vgouxaOhKg6qBuj7zSmV4o39ZluHGjiMk?=
 =?us-ascii?Q?Qilo/hoBm0ClmTUFAZhJbMXdzBv1ldwCrTqtKnllL77r3LL27Oh/8Z348zkR?=
 =?us-ascii?Q?Kyt4iJiVGHgdpf8LjcSJP2iRW967cJN6xyh/YDDbdN4Nx+DDJP1xpzU/J3hZ?=
 =?us-ascii?Q?6bQHSsBSvuk6MlG0h7UVjFLuYV1y9e7RdLFXZvkFK367c5as4e0uuDy0JoNh?=
 =?us-ascii?Q?6Pjhf6A0nn+e7vavawdmVaKvXkmicJbPGRJ+DuHTL39riXVa06/QWV9cu2Sq?=
 =?us-ascii?Q?eO2+uZfTrx9YGDrSZXOjx0GxIaEKV+VED0nSLhvslf4JVhznKIs0edPWgpsA?=
 =?us-ascii?Q?+g9TEnfKvGhmXL+XRMy3a9OwNPsP0ScQhN0rs6SuU3lKgM/ZqhhzKMu0Q/3W?=
 =?us-ascii?Q?9MqTMvtl/k5Whf76kMFTJFwOwv/Pve9ZcHdmJX9s0aGDMUxs7EAtpApNn80O?=
 =?us-ascii?Q?RqWrKkj5voJ9Wr1Y2EEzFgcd0OIG0CB8uf+fohy45J/ok7xX8IbMMlZ6YfYN?=
 =?us-ascii?Q?RdFucNMD+kewzcMmJBBHXDWtLPUxabh2I70m0fF2PZlMvje6G25s0MKSjslg?=
 =?us-ascii?Q?hWccJxZkZINmAP1OAQymz5tjFAhOwxUFcZVPo2JPdK9IQ1sMhoeQ+BFMuk4n?=
 =?us-ascii?Q?gqRyGV+QsKk7xit8J7sSIJQupikqRzafyTpD20s+5JS1ULGoL7PrKjSmrzK7?=
 =?us-ascii?Q?EsnD5usQUFYXFdzRl/YO3N2+qrizPQi6cxgQJ7KSAzxYmX4oPQg00mJeCQEn?=
 =?us-ascii?Q?86WDFPR2FLsoY0PGm40TSbBfuHidJZqGNuHzyiXXYI5VEn/XpbwfYb0rUD6T?=
 =?us-ascii?Q?JiI9sIB5Pds8GbZpn5Be6En1NnSMGF5X0UdpDC00nuR/YMVryVMkWcvCr8UQ?=
 =?us-ascii?Q?/O4AA0Jbt9T8ug0MnUIueTdpUGzho0diSWgQzwJd2FyHTXCRYwGNhxLjtN7C?=
 =?us-ascii?Q?TKAiKdQPyxY8VBlkanzV2wk38cnqGVIRD9Hx46CMExo3m1N5OEM68NZlcSZ3?=
 =?us-ascii?Q?QYxIMB/4/3ALrZ7y9fr59O9+resSCoqQA4ql84kO1ZOwGd6EXf6k8mgI7gZS?=
 =?us-ascii?Q?QBTK+05gwj/xhKHKEIFagWGfNoYzVh6Exf+o0n0NcHAmbkWf/Y7ILONH58K7?=
 =?us-ascii?Q?84vTozCXP1UXp9ZfSJKh98uENx7o44vL2/1JOd5cupe5m2orEf9jAZwABktl?=
 =?us-ascii?Q?lBp21Fv+K0/iM1DVKoeRoQuagXz9NWbUEkXkhW5aJATfBGrChXhiypBl5ccP?=
 =?us-ascii?Q?YOYe2x47+pvIW+gPTGKQShOw5ozHQN6HNte4iE0dfBaqE9okGe7YrjXMVgj/?=
 =?us-ascii?Q?ScIQng8ZUB1gjLbe+uXl7nHOhP7jIU9O83FLtbK9A9uRjcQFw2w9y+3B6CoA?=
 =?us-ascii?Q?yzUItbUvr4AYUEmjrLeyI8rQTH3Tatlb9prxvmfhAGyknvamFo6G0ihe4h2D?=
 =?us-ascii?Q?Dz5qhlRPgzYv/36YnXgl7KsWMi+3Xx27U9PUtnfE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc36807-031b-4aca-595f-08ddeb8dff0f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:35:26.3487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtzW2SL4nnu6pkTdhUJdWPHDdZgDhbeEkU0WcXLnPcKxtlTJ5fVzIuMA1h26IPcQMmqkqNF0VycrDBjqpdVrGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10828

On Wed, Sep 03, 2025 at 04:19:53PM -0400, Frank Li wrote:
>Cleanup some some dtb check warnings for imx6
>
>---
>Frank Li (16):
>      ARM: dts: imx6: add #address-cells for gsc@20
>      ARM: dts: imx6: add key- prefix for gpio-keys
>      ARM: dts: imx6: align rtc chip node name to 'rtc'
>      ARM: dts: imx6: add interrupt-cells for dlg,da9063 pmic
>      ARM: dts: imx6qdl-aristainetos2: rename ethernet-phy to ethernet-phy@0
>      ARM: dts: imx6: remove redundant pinctrl-names
>      ARM: dts: imx6: rename touch screen's node name to touchscreen
>      ARM: dts: imx6: rename node i2c-gpio to i2c.
>      ARM: dts: imx6: rename node name flash to eeprom
>      ARM: dts: imx6: rename i2c<n>mux i2c-mux-<n>
>      ARM: dts: imx6: replace gpio-key with gpio-keys compatible string
>      ARM: dts: imx6: replace isl,isl12022 with isil,isl12022 for RTC
>      ARM: dts: imx6ul-14x14-evk: add regulator for ov5640
>      ARM: dts: imx6ul-pico: add power-supply for vxt,vl050-8048nt-c01
>      ARM: dts: imx6: remove undefined linux,default-trigger source
>      ARM: dts: imx6: change rtc compatible string to st,m41t00 from m41t00
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

