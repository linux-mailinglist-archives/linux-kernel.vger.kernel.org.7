Return-Path: <linux-kernel+bounces-776784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80960B2D17A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6BC1C277F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1AC239E7E;
	Wed, 20 Aug 2025 01:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="M50rNK95"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011065.outbound.protection.outlook.com [52.101.70.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C56121019C;
	Wed, 20 Aug 2025 01:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755653652; cv=fail; b=ca6iqGiMOvXBvGrVzFvX8wsOH4e70PZhyY04s3CvJDMBQWHEwMx2bzKsLTc1zJytBJs5MDNt6N/y4+vTbV5jN3iC75Li+opkFX3rWGJ3AYL5Cb0QpbQhxGBRYOGSCUpL9sQneisuZX+/vLEvn5mGYeQHFCgzf25OcvOXrCwo+4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755653652; c=relaxed/simple;
	bh=cZukic368o8gY+rlkHmwV/OfnLjDqAlsDkBrIp2i9VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g7dkNxzCmXd273k6kMaRkZcSedEfxLWvXW8G19os1PnCdVUEqK2NqthOk9R5g3J7ChChwGzvJa5PJA560OLL94fzcMJfDO8it+dHRrMtkbP6QgxaEXjWB3G8OX2W67uwv3niVbE2DVAy7opgLiNMdCa4eYrspmHIrp+j755DCaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=M50rNK95; arc=fail smtp.client-ip=52.101.70.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6VlA5HZ8uyHb22wzJ27d8TkrK9uHfnDsOJskPjLiYQ2u3Ki/UbZdmK3bfojZfy/DtAKzwU4jpdOngFLbAna2JXa0693KWRKKV7+cjKOyLX4OIGBIXzDUMoDlomC8vK/DWsE2V6018jC4QFhv+bOohp39XzMPjn2ADWFuUeTZcThYh1m+KzcrTp3QRQ6GlpMLEAU3VMzS0icsR+mr7zr7ou+THVmbFjHnqb2/IzCZHRs+HIWAWL1zxH8EVDWn2nONnRwQ8bic2JoHe13DRBxiOVOb9Qq7tvvPzOkoEm2AjKkHnIkwX+fz5FJJrE9S3W6vT+NnIV7mpG7T9Re/d2QFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3Ipok0sKa4CF0MBPsUKOOEzHc5+wUPZsMxN4YjvsMM=;
 b=LA8Ckb2G4epAO3MzsftXWa12ty9KTFZl9cioTHjXBAz3OQxc1v3VhD8DWfQVSq3BubBQ+n+cSsf6P/hxHRaPwrdXgsFR67d32loDSbeAFtuFTpKtyt0opFM/4zCYwth9lykr9cD8yfhu1bAdv3Dy7Q1ZF9B2RexlM8/+sufbgD8wRAChtPck1yNzIekt6BRMXsT2co9wTsWJFU6E3X/SrzHH68ZzaZVOPvZkqMxF0ivJ0moRNipgck4oXPqNzTseQHIhB1NhmDikhO7/UmbwSM6+IvmxB6jniuVFN7MMzBhVxNJeXlJnoHYOzupFFuBZ9FiflgiB0J3pRGWVvKoQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3Ipok0sKa4CF0MBPsUKOOEzHc5+wUPZsMxN4YjvsMM=;
 b=M50rNK9579Q4AEdfnbZI1bm/MjpM7/Oz2UFIFehqZ01i8MN5JSzSKykQW0EOSq81uLx8YzK+HYaiyuZuOTSUYfCpo6ZB/gBhRHK7CHgzrrC3sD3f+MNFJHCnath8IcqJKcMo95dZWRDn0xa/hQxVvHhBysjo8Q2f3UluFIidcUrNSV+0BigJJdR57YmafWwl5HvFY4ntkJ6lBagP086MPuN9+RcY07uMJLJob+tb7tfZ7PJfo9HNj09VudYEQ1E4BZ5wQ/BputjEmxH8TJB0nH8oJWT9xdYpJWxcyfyJIP72w12HJ+CHjTtaCK1e6CKgSazTFHdquwXnLosjy8TLJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8258.eurprd04.prod.outlook.com (2603:10a6:20b:3e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 01:34:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 01:34:06 +0000
Date: Wed, 20 Aug 2025 10:45:10 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH v3 0/3] arm64: dts: imx8m: support more sample rates
Message-ID: <20250820024510.GA17332@nxa18884-linux.ap.freescale.net>
References: <20250815102317.910014-1-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815102317.910014-1-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bcad4d2-13af-495c-3e99-08dddf89a700
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0YLP9sJ1itBRkmN6uoaikTzmohPjxB2jFvPJJy7oj89CqTxSoTvPpRWLIUoo?=
 =?us-ascii?Q?hp3NQEExHbT5TxGgVFVEEqYZPllfEtVFgtU4/D2MZj3QOLju91DeG3lKy0fu?=
 =?us-ascii?Q?pJKDNQSA7ab8XIIArDuS0eKYSAbT52eJP7tT2ClXPBLtm7HvEJMTJ0ThXQtg?=
 =?us-ascii?Q?mzpzRvrV4p26NuRVXhkEaMN0ocPe2Y17RDE+zZ6zmimwvecbd+uhq8xokZE6?=
 =?us-ascii?Q?LIzHaMc8Ssa4CzUl7MakZXEFicZQIA7jKLbnY6+o8ZhITItdlxsVmt1voKWZ?=
 =?us-ascii?Q?LK9jmlB2b5Fkgkbqhun+RqO0KPZD4G3hsSfPHc2BngxfOqV7t65hwgts7pE9?=
 =?us-ascii?Q?63k1xt4m9qAZmsnx77jkwzcV96xVTepXQw0JobmcINmc3zYyvQJhZ6uAITo/?=
 =?us-ascii?Q?XTpYyGKiRL/ewC//NvaUTGKo3Lfo7YP7bOXlNBLJDCfwD03lCKpgNNxMeN45?=
 =?us-ascii?Q?jSNvG6DKIeBBCzMvI2o0oyxC9EuhRbk2CpTH9g4Z5ktIuHHOsa/ZWeBN7/FF?=
 =?us-ascii?Q?IpzDmI8PIy8Whii8BJRJm06fOvN6u5BUtJWDcXLt5Wl+T9mh8qsjP0C3AhCc?=
 =?us-ascii?Q?+Wj5nxMUane9hIc2P25DS4USli61MBGfKC//W/g0PnUqf6sAnQ98kdpSNr01?=
 =?us-ascii?Q?sJt/S8X7Nol93NYfTOsE8IioyDEFyS5DUyXMFAa9Zcux8EDP+64T8H79/ibE?=
 =?us-ascii?Q?lHMybh2zhBaOi/9k9RjTIzSyX0s22stZFb/ye8rctwrPX47RdVk+BAUdaWS+?=
 =?us-ascii?Q?2P6v9Kq4iLFcXZOlnOwYIPMJV3yUjFioA43wTq/P74d+njZlBBpk3+d1NQEk?=
 =?us-ascii?Q?3JefHXAC1dKIwNTzMUf4KCoSLaBlptmpFcEskJjLN4LzenelolmzN+2IrRa+?=
 =?us-ascii?Q?TqtgYlE7LR10QDrDaQHnTpFzY66S4IJ+MYGJaGycUy1CPyFR1tn+OEdP8sF+?=
 =?us-ascii?Q?IpPSrHFOya1CYzNOXxkXA5MjGo2W02xWg7umfffbiCIwHRJpRI8ExuBoxELs?=
 =?us-ascii?Q?I0e0PYutMEyhBo3a1FRn/7RiU+YsjOsoaZvU+E7XAg/OizinbE/n/dKIZ5py?=
 =?us-ascii?Q?K8Mp85WILdpTiXmt46ObeRIlvFgLBZgV5aO2EJH15wBVs0CEWJ3azRej4Dv/?=
 =?us-ascii?Q?TjXTChfiTPcvWypXYK0SP2MchzAiPwR9k03Y+5uT1uViFC998glEfwadmF2F?=
 =?us-ascii?Q?3udtKGcPQrj6QXlJ+M2Z5ppUkUXu6u3t1Ygk72p7uYxVQuAagZC8htW1x4V+?=
 =?us-ascii?Q?UlRoVv3Htd6QI1zg/G1GTSGig7h/Thquq/O5DtXNeSG+xwGQBEw7zG16U5OL?=
 =?us-ascii?Q?yAMp2HwwHl12WjnWsKuGVvsBGZq+DruzGLO0EB4TqwUkVz3sagdm0TEXqaJR?=
 =?us-ascii?Q?xw83hnxlil5mEkw6giNL2OaoE8/CA5qqR4BGRVNkL79PC9noL6hoHwEX0JWq?=
 =?us-ascii?Q?Ra6W3Xf8qNupzJT4fACMdIxKllW99P6YYnhovWGgSwdNlSHE+lC11w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3YSMkXJhxwMQz45cbpesNRQy7ANeqph9wlWq4ri3uuXFxv0T4g0yTVjtboAg?=
 =?us-ascii?Q?5Wb7HxxGc6D6Lt679snhLPD0+Sbmf8yWkGmy6uWWEP861/AJJz8e63tQs+mY?=
 =?us-ascii?Q?TyyfQVBiim3lljWTIAsAydVZXhiYGzHwidMSm2c3ef7DupIrwzsfiYJrftKB?=
 =?us-ascii?Q?kaxnR0uQ/5UXA4d/US17eiefE1gmL7XRsbEQ4vQFRA4B2Yb0exl7n/STRdkZ?=
 =?us-ascii?Q?1KlsEZDBAtRZRtTYZClnStkkzEuQQgq96HQjwaJyVMRruoFUb+PP4BXOTFRq?=
 =?us-ascii?Q?ktw8SH1DO36s8veSl1SqKbU4aHcs0idRu/u9bD0lm8Zq3cqf/h2yttAjGLZ7?=
 =?us-ascii?Q?TxeBukOHAn+JXOsEzJv2UZY6+onNNLFt7T2YtKtjr+Tr4r3sV+Jx8vcAtAnZ?=
 =?us-ascii?Q?60U7Ahcwy8Za8DRslV/fK4t6TWFC5QmAr+9Rt6ZSxIKXRWMcloiuH09OYQ7j?=
 =?us-ascii?Q?nEahP30oPDJC/j3b31dm7xiayLXWLbGGceF0MHpdhCgCNDKuebzzdGgqoM2b?=
 =?us-ascii?Q?cosHDL6OWECRVhGxAZgyrSa3HO8Y5kcKRinZ3X+zA6g+kacsASJfBmt1wOdD?=
 =?us-ascii?Q?/ATHiGhKJGUzOMRYmqjDdAjV38WiTQEjo4Nk9bnmABo/z5StYQObzbdgdJ1O?=
 =?us-ascii?Q?H4b6dybgjIIAB4MR7NskPNQuvjOslx2grV8ny4UvUjoSaQh5lxww/ViESmuY?=
 =?us-ascii?Q?hglPWmN1/nySugCLEUX8dIZCi92xXhzF1Q/1RK0skRVwIHOYeDwJLfslhKT8?=
 =?us-ascii?Q?2i0X+cwxHHlTLrguvJKW7dVasOUPDRLDbWu1PXECGAbcSuNnbLeYNpauZmus?=
 =?us-ascii?Q?SeUCPXHxgOMlRqGjZqxyzgBIKePpr9M1NVyubsXExr987HBwxUirUVLF13f4?=
 =?us-ascii?Q?CYdWXJo8jicLE+kGxSZW4IXZE08wFBU0JN8Z4AtnElJytsHm6naDXXGtfnwT?=
 =?us-ascii?Q?lqUELUs6pSh2Logs0MzX2ZTPVyTR61YOU8Z7Pwel/aHSG5hsH0CyLNn9mqq2?=
 =?us-ascii?Q?d1LNwJIfc9yUWaCQF+NnNPTKp8Cb9cUTRsAPSOL8kJpB6M7luBLc4rY6x0Lz?=
 =?us-ascii?Q?E2szoQj+BtjJLfLKoYSXhdfU81Wec6sdI7zqBDyZtwAHFs3mplFcf708G6Ca?=
 =?us-ascii?Q?KeEjWbD7Ci41LBYaHZgmMytWvBO7Zutmf+T1dfhuf68BwY1ZTtqcIW6iGJJ1?=
 =?us-ascii?Q?u4AtYQ2CHoYNZSypB3ph/xoO+Z+S1RvM7k9nMEiPZ73LwsdeqtY5S2KNJfGg?=
 =?us-ascii?Q?QAgmRnt8bQYlmYklnmaWiTVHSCi784fAsRJeczg/coBKUt04pJoU4lVXPFg2?=
 =?us-ascii?Q?sjPeCEoO4mgx1fnOsLGEzL2c2ylX9ctntsMzfkQJsGH9dHYNASt8M9l7w3KS?=
 =?us-ascii?Q?xg3o23uthnC14Pu3KX6xN9e2T7/bELdzEezCMc5XNQQKOyZ+xvWxnSLQWVrD?=
 =?us-ascii?Q?hAKEXdGxqW7calyVhCMncqLOZIrbbcfahC6XgRTLO8C1EVdEZ31yYEB3WaSC?=
 =?us-ascii?Q?CDJbH7/LLakvzQcBJ5zf19vQo9i+KQ9VNYTsC/8d7xMZJMOB6cXcGPeZK0ym?=
 =?us-ascii?Q?RaRSNIuWslJdH58eMcFMpOQiFm+TaxNxjncStGPG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bcad4d2-13af-495c-3e99-08dddf89a700
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 01:34:06.5324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sG15jxUqNqwLo8JHu5fMs2zdpPd7RAcP6Dp5E+dYq4aNxcZgvu+7MyNo+XrWgMJ1DVuXiw4nOp8CasUVANdMZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8258

On Fri, Aug 15, 2025 at 06:23:14PM +0800, Shengjiu Wang wrote:
>The wm8524 codec is connected to the SAI interface. There are two audio
>plls on i.MX8MQ, i.MX8MM, i.MX8MN, one pll can be the clock source of
>44kHz series rates, another pll can be clock source of 48kHz series rates.
>
>Previously it only supported 48kHz series rates, with this change the
>supported rates will include 44kHz series rates, from 8kHz to 192kHz.
>
>changes in v3:
>- Minor change in commit message for comments from Frank Li
>
>changes in v2:
>- Add more comments in commit message.
>
>Shengjiu Wang (3):
>  arm64: dts: imx8mm-evk: support more sample rates for wm8524 card
>  arm64: dts: imx8mq-evk: support more sample rates for wm8524 card
>  arm64: dts: imx8mn-evk: support more sample rates for wm8524 card
>
> arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 17 +++++++++++++----
> arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi |  5 +++++
> arch/arm64/boot/dts/freescale/imx8mq-evk.dts  |  8 +++++++-
> 3 files changed, 25 insertions(+), 5 deletions(-)

Reviewed-by: Peng Fan <peng.fan@nxp.com>

