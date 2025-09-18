Return-Path: <linux-kernel+bounces-822256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF07B83655
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72D13ABE6B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7402EB851;
	Thu, 18 Sep 2025 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="atBbyiKD"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011066.outbound.protection.outlook.com [40.107.130.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55B2D781B;
	Thu, 18 Sep 2025 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181820; cv=fail; b=cGU6jE+eCYjvggOodVmTl7UfaxxXSsbBUa8am4Utz2LZvtTpahtHfcUj0xdFyjN7zgUbJRNSLP6zDkZtRgn4lEgVQ0/o6PYGJtZlJpbokz7q9YPLGZtLKIiJa5NgcrG8MLxooY4SUvvT2B9pwQsTtwtlf1oC4Mexyk3gLTozu/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181820; c=relaxed/simple;
	bh=bux/rUo4j4e/pZSHrMG0CjcwdouOFPgL5Q5YzhkaTlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=myl+BejyhNWHH0tRv2zVR2eksj5NQ494sDInUyAVYX/1554ypLRAwdi8jzDOdXdMN0ep1L7PLgt5tH9VVCK/Nkp9QT7NaohoJv2txzpBJzDzKxACARFjgrd8X2MyL/EScYD8IRz8Ba7s/9J5Bu3TrBiBVKJbBTQLGVWvdtbLSS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=atBbyiKD; arc=fail smtp.client-ip=40.107.130.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5/xQ30oTSIhmHFZOTe9F1ZMkr8DRiyzGOhmgDClcrGqZzl8LpjxN3+KBFQbFgg49GNf3A4DZS4nJhG1YqSY+rsUZlt3ymlFiFnn3F1KsxL0z8C7WSTLp7JO1gdem+h4h8mOV60diU63LOIRLELTW9+smU7nlzcASMPnl4goKhChTa7IBVXKPpD1iPyYqrsiBNBTycwyykQVGuhcP1o82vmKQsG29P0awqRGncAQYyb4KXbv34twZO/CXfCoUByu9/pp13nqGTpuPf/mrofdLCX+D60sM8N6dKt0k4v0uC2bEF71DF0sZgFrCFVlL8X0VlRV4Q4YZmsRPnkzSp5wvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bux/rUo4j4e/pZSHrMG0CjcwdouOFPgL5Q5YzhkaTlI=;
 b=agnggOVr6jZEK6s6rsCaqwMZgHxH9KN6J9Mi0b/ZylQW5GcVMIm++21BZFbsSOHr2OADE6mFUvMJVw7hkcFH2iCU5CAdFOij90jIoyT8n3/dHiC9frrkLvMp9cuPvRQdbm1wxFSpuEBT2mak1bafJXLJQLKfjPBDCxu8g320InIcMhn79FrMiTQQlvyomeTY1cou5k9Ib1Ha6w0R691Up1TolspY2702HNe983xaqu6Ob4fimMFdIsy1en1WnK0HHgvIphGsysG2DYC2WkFs1FEMwdxMT09WNimc6s4T5Wr0ev+Sgdf0ScCH/spHsXlAwmpAFyiigRw+VrI/VLvhqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bux/rUo4j4e/pZSHrMG0CjcwdouOFPgL5Q5YzhkaTlI=;
 b=atBbyiKD/zw7VGzJ55kWmIu0Ez025qyMrk0vmLfpylwcablb5f1ValXr6odtNLXzgGMa+KGU/FYjC+plGR8Ob8CsHkAC6/dvuO9dCXSoAR4giiwlO3bG6RMYCvr8bxq3WrPuk+l2npngUbc00CMqiZAbE1Az4DyAcExRtC+3mEh9RWemtrETUoWRM/IbYJMkO3T2BWYBs8wZiU1Y/G5Lh23VEBCRq4eysvQYGOVqekH6hRctm+biNvayQC5sRL8iNamyVvFBe2RKiHal0lsbcxUQPEdowTxmLO+XAXqevEpwYng9X/iLlmJ0/VuThp36MuEHrmcG5YWkPvgyzMpfdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8268.eurprd04.prod.outlook.com (2603:10a6:10:240::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 07:50:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 07:50:14 +0000
Date: Thu, 18 Sep 2025 17:01:51 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Walle <michael@walle.cc>, Peng Fan <peng.fan@nxp.com>,
	Frank Li <frank.li@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>,
	Han Xu <han.xu@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: dts: imx8mm-evk: limit the max frequency
 of spi nor chip
Message-ID: <20250918090151.GB23028@nxa18884-linux.ap.freescale.net>
References: <20250917-flexspi-dts-v2-0-7e2a95e3cf4d@nxp.com>
 <20250917-flexspi-dts-v2-3-7e2a95e3cf4d@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-flexspi-dts-v2-3-7e2a95e3cf4d@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0154.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d985ad2-ebf8-4949-3e03-08ddf6880086
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?85JhfnIAKghI/Mdp7phRdL5ZTcCFWrusyyZpQIMNiWmG75qg5GmaRABB18Eg?=
 =?us-ascii?Q?iiyJK8zg3QZFB0QbAWrj9Nu1/tJGa1HY0Z80pPAZjUVEikd1wst4D94FQw/i?=
 =?us-ascii?Q?9VgZfSXcUsE4/yals8HYAUdOHmCsAUpuB0D123WbC7mC5pW3fc6IVeE1CQYL?=
 =?us-ascii?Q?ySqPXiqENF5yx28ZcTeV1Sc+P08o4TnYjzPAf8xgUZxOLmBlANK11ta5bJVE?=
 =?us-ascii?Q?QF9vVwf72zano7GAGxMFFT6WpL80FBxnBxXRfjPI4S7GsYZMYdKHJPc9lUrq?=
 =?us-ascii?Q?44BThsNZgyVVLUbfy0m2r/xapGMHSdWFx0E+HBzWLMDjALBHyrsUPtLT2l6D?=
 =?us-ascii?Q?odvhVJFmRl8uxndngl9/7yKNa/NLVT1i+H/Dzt9zEub/qq2xjW65l6cynV3E?=
 =?us-ascii?Q?J5lHeAt8/cH/ULQYatj4M59qrV4omSHdUdTxuAQ8HZVmo67Rq8C+YlJj5rSR?=
 =?us-ascii?Q?/4IcUwqt4W1S8oru24FuiBjRXyjUsa7KnbLvmCsoEbjrz2Mg3NfoQJRcKJ8W?=
 =?us-ascii?Q?Th3Uovr86sRgux4MxYAqcF7/9uU0IghWLC63rFpp4EV+ZAiOM5m1UuB+iiof?=
 =?us-ascii?Q?hZxc+RlLFmK8yhFKR4YZDPrtwIFNAx85Jk+YySkTOLM8xtB15HFywuez1wUH?=
 =?us-ascii?Q?20I1kd8GbGei2KlNPkQTY25Yh6WECqPAWPGBVCxBzoN/3W8ulx2gFLxuijSR?=
 =?us-ascii?Q?uNzgC+2dM+UbN9WUE4lvCJoFMx+tSjUx0zwmSNLzcFtFrKebAaUmcZyMtGOE?=
 =?us-ascii?Q?Zi4AVMe98m3FBtJXS0yPjuVJ4Ba4qhKO+Qv2G7tKIxos1/3zgAt5JubjqSuH?=
 =?us-ascii?Q?VpbJK6SMWJNWnaxn3MhewNWBQpcvM7A6NtxeDI5iCTC+5NDOxdg1tkWjCiyy?=
 =?us-ascii?Q?dtscyiiwlmRQfsheQ0/C+ebBzNwoVVaw9khRFeXlx4U8Pzj1A9ASe53CnHyk?=
 =?us-ascii?Q?XSuyuFRsFgSJfJHxTEFojOhPM1QjrKE3ga/1UbHy9OnKoV9iLp0fskM+jjFz?=
 =?us-ascii?Q?VCnoPkY/GmKy1rOKOqPrV136Ccb+Z0j0v11fSpEY1BoP4SjbeZ/ZIpW1dfGm?=
 =?us-ascii?Q?P3OucyCbPohG4765/0gV7fH8T38hojTiveQViX/epG+7c+kUnMgJ9/+SEWIC?=
 =?us-ascii?Q?3PRTM8UBWxg/CUv0/MEUx4bWUePThxRO1iB4SDSbnvK2K4Nb4U+RcdjZAu0q?=
 =?us-ascii?Q?lAd4MEDd0KTCybmHaK1AIeM0nD6bWQmH6J52rhP5sggLn8McOFJDmJGpI3Y5?=
 =?us-ascii?Q?hsO7Jdl1u5MuE6s6Z319hHidUgFn5L2mZSW35fXVmMq1nlf9vgzA0cB2mDIv?=
 =?us-ascii?Q?II8aeXg//EjHCCCW81n3nBoK0CGNWpJQTb08kEinbWDvjDYilSCm6SRfn7q2?=
 =?us-ascii?Q?j1BL693urSUZ0QOTf4zVGbt5mHzhUQwwaNi2Si9E6Ed140cFUmTJHr1JB26N?=
 =?us-ascii?Q?HH3hwKKCM+0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5oRNhDeXa2Qy5YPgBtnethhR7t4ZPSChblTrqW5JwpAMF+GlZws4EH9YGyOG?=
 =?us-ascii?Q?6bs/A/bwAn6J1qDhtsLyYCj2gJvUnuzBzDFJdlJSoeT4sqQgIdMouLJxK8LC?=
 =?us-ascii?Q?FzDNgeSMCEI8F3z0idZMzISFD3LgexDxx8M7HG2u3crHg40ssy2AGPYJjRlV?=
 =?us-ascii?Q?j2YSIPAvSj77Y8etMfCoyfbw0ulfXB9qAZcZLrxyWg5A7gOuFsmuDrCY8TWl?=
 =?us-ascii?Q?0fKJ+XAKzpaBa08oRwZJyAe+QrsDYb6QIHODxRxyz6fbHLXbDM//RNanPAS7?=
 =?us-ascii?Q?9+kdz4INiRTmyyk0kL8uv7tstf2/5b7ZPrYforq5TQEvwChKFP0NzG74qj9m?=
 =?us-ascii?Q?MdzOIm6Whj7U4LxQX61D7983y9XXqRnx0s85Wh0kHOw9ocTJJWhADffKLJMi?=
 =?us-ascii?Q?AYDyGLWQ0ciLS5DpMOrS0n78p0gtkc1BF97YRiObuKaB51U2yS5fknrJrTmu?=
 =?us-ascii?Q?viAjP0KyjqqLNqLUitL4nyGUSkqSUbVxMLdlNGCgSbDiCnUGbo09gepRIEKw?=
 =?us-ascii?Q?WZyoPQjGrSAsZBdeueqRWd+hMladXhsOBHO/FJ1mdhOtX4o+bYFyHYhQ9otE?=
 =?us-ascii?Q?7I+TmTdolFFsH3oynKzfI7RVJKpJAs3/3DSlZb1GUldmpQmCduf/OrpmVK2y?=
 =?us-ascii?Q?ve1aPF/L9M/BRdWEXEFxfFuoEN7mIjXKQpWlckRw0T5up/xCKUKTXmSx+29q?=
 =?us-ascii?Q?deS0oMm/o8rkC9PqvsQK2EsmZS6fSztJJvAy0EGWrbtH4xFcHBzx2K2ue+2c?=
 =?us-ascii?Q?GvziGMON5Xpb+L1jK5mQ0XDlupwN0rrCvXNiEzHiLJIO6Dwuw+qHhtfsvzGN?=
 =?us-ascii?Q?+3VystRkLejdFONW5Rf5jS7IBXuqvCyFADyxGBoA7aqCnGIgAvpPR62XEFL5?=
 =?us-ascii?Q?g9HML5pff82kRo67SYO5tWxc2aYn22mPEyCdidVobY5MwHqh8lrstsx5D9YT?=
 =?us-ascii?Q?xUHB+htX3gc90BLazuyaJr9+7/564FoIy5yVzkQz2yw/MH2R5Ba1oV/LTIU2?=
 =?us-ascii?Q?r2vmgy8jDwliOaQTYOp6QRs9zoZPXiHjfd2Ta2hAOvP+0N4eawHiR1MH1NkX?=
 =?us-ascii?Q?q6vfoDPkJNn8LpstxtxJqaJYhJeQQlwPj1VryNzQPTYCLhYdubPM+YY/HBM6?=
 =?us-ascii?Q?tPYC71aMhUyb+zQ33SjOh5JdF3vDd+WtvCHh3mKy5VbhzJzqJ95C57inL8LF?=
 =?us-ascii?Q?d6R6B48nV15GRP1+ZsJ4X2Czl+IafK1dk7bbzD+6+3mBN+pKRWWLuAI380X2?=
 =?us-ascii?Q?62LPtnsGSyGjus0xaDkUVpeGyxcqtdiBTQswOjP8Wvy4gleYznKqE6LIOZns?=
 =?us-ascii?Q?uYnmySAkK5UFKia5PHF7F1XKwku70kg3rAz9QVzXOfZZORPTwauHyLbsjnPO?=
 =?us-ascii?Q?TIrD4VxXFNGEiJTGpKnC9rVpASJO6KQTb4zLz7P29Qbv6KxPb4W2JQKFiicn?=
 =?us-ascii?Q?+5a6597M7hlt4DQ/e4x6dg+TKBibB/bXXnMN9FM0Ej5TudRa/igwZozlLQ5/?=
 =?us-ascii?Q?jL+pzb6JpVrQNzwDVOZbIrFeJPzyx94LxRv8KgT9BZZpQ31sHXMA8l7++XkC?=
 =?us-ascii?Q?+EI8ZPVkSDlJCEazJMt7wSZGKCU7sEtPZr1ky/O8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d985ad2-ebf8-4949-3e03-08ddf6880086
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:50:14.6880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfD5tXaHgV170hfIXZk032w0+LJhux1xsUOqWvHFkp1MbFqP6xt/cO9N0qxUSBOvba4YmdNLqNMr0a8BAaWmtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8268

On Wed, Sep 17, 2025 at 04:42:29PM +0800, Haibo Chen wrote:
>The spi nor on imx8mm evk board works under SDR mode, and
>driver use FlexSPIn_MCR0[RXCLKSRC] = 0x0 for SDR mode.
>According to the datasheet, there is IO limitation on this chip,
>the max frequency of such case is 66MHz, so add the limitation
>here to align with datasheet.
>
>Refer to 3.9.10 FlexSPI timing parameters on page 59.
>https://www.nxp.com/docs/en/data-sheet/IMX8MMIEC.pdf

The SoC SDR mode max supports 66MHz, 133MHz. DDR mode max supports 33MHz and
66MHz. Saying the driver now only use RXCLKSRC 0 to restrict the
device tree to 66MHz is not that correct.

The SoC max frequency could be coded in driver per my understanding.

For the QSPI-NOR chip, the spi-max-frequency should represent the NOR chip
frequency. But that chip supports SDR/DDR, so a new property
spi-ddr-max-frequency, if we take spi-max-frequency as the max NOR
CHIP SDR mode frequency?

So if spi-max-frequency is the maximum NOR chip SDR frequency, the driver
should also be update dthat DDR mode is not supported as of now.

Just my thoughts.

Regards
Peng.

