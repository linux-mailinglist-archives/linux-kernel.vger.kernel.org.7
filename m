Return-Path: <linux-kernel+bounces-821095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF08B805AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E22C3B51C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E650A33B46C;
	Wed, 17 Sep 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fUMsXvjU"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316EA33AEBB;
	Wed, 17 Sep 2025 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121023; cv=fail; b=ounmNf8f8FliyaRjoVKok/rQQ6wjkxPTbm8UHttt19L9jaNwWQtadRTtJk8TtI+qoku7PTn4CHQekxR7QUtbg1NmVTgo6HJCb1L5XRr2O7AFB9X69hv5hwvZlisxr55+ZxC5wQGYc1u/NeUuhPawkk7cX4IyBXzCrtPeSzH00+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121023; c=relaxed/simple;
	bh=3xclVPdGqBQxPTV7AZ0kEoRCtk1xBTAlMHwlfax5lDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UEQbAwPEk5cAs69M9MNWATePBWdtAqqyMgvWLFeDGpzg9AdsKlytPfKoa4vl7SCPs0yQUlyq+b52LGPxrK9i4/NKi2kHij4wOGdbIi+bJmY2aSbiZ+3/ng7VPaeb0N8EjyrLpp1tV0mKgm7Po5DGL+K9QIdZsNu9PIByXmgNm3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fUMsXvjU; arc=fail smtp.client-ip=52.101.72.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbHwVrZzd4i//El64mUj9eCrHas2Xbv+W9bPhjImWuPnuObC4eCPwWRcmaRVqzsRW9/tAO5BxtdzPwnxWIsuZb/0yX9WtuH1KeD7R2K70l/kSrgDeyX/fdaRWp5aTmE3j3j32KCi2M70x5BsCTbnu+YTc3bmU1exCVL18MRZfa8YL6Eq8hV7vroQMs7QaLSxHI8aFcv7juOLSK5lKHRLENDDuinggRkmUhJGvRVH39XrFeCEV1pPxcdi2pU2MXd1yFVjCqy5JfoZNbI2cqidCF8B5xnd6kGAN4E0SVVdqDMNcrzN5ayNinNFPDrs3eVZmgOKPxm7HgItM8K9zakB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQ9U4EvttPVbg2OaRFS5IcJ858qB/52NLLxmxWvjQiM=;
 b=kiEzqFSz9UlM6K+j5DPVyizpHc9+8sRqv57VQ9sx5Q8X1S43+r1uQjO0dKxtlg/W3dGvL2xLqc8EO2G+hEj+3gCXxo+n/cDNcEOLu4NPn5HbbW3hsz0TgDlTgnR5jkWNAzjBPJzGs7EI+Y3JIyrCmvVrHJukcNKJOjq3Mvr2wUdZleQc+Rbp53/J5ERQCkI5NpOaBJ1WRuYhQKjjf/2co5Pc+ybjuLVvcBQA2jyldR4/urllmtLMngvZhBf6TENAjGwq1Gl8Kk1hnBqEc26wWssc73GCpEcbI8f+hgkQGRgU9BM+12nnrGCAS77X0Ftk4no3KlZ8bdAv4avKPs3mIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQ9U4EvttPVbg2OaRFS5IcJ858qB/52NLLxmxWvjQiM=;
 b=fUMsXvjUAOsP4V3y22t5TfwIEiuJDtKc6g4TVcnEN/H9Camvl1nezh8wFanFwoGa1E2OQWK7k4JSGw1EAAzF4B25DIxHx+eu3A/uHavI11HLokgxbUXSMdpcwtnUgGWXQRB6vJ3XT6xndMI/t22/WqzJkgoxFKN0+ZCwotfM5NYIcgsx3gaWQ0ormQOgiXKLlu2kCCNdAF9xw6MEEyGLWbuy+qIK/o1d5yGIWUMsU+v726Rl5Sa+fb3jgTANLaaItX9R+A2RoFGvuuhuiTJCqfLLIWjc5rE2aJkHc2tILrcGHx1cNqIGCRb9YoF+9xR9bJteyBap9eKchbYa/x1Z6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10095.eurprd04.prod.outlook.com (2603:10a6:800:246::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 14:56:57 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 14:56:57 +0000
Date: Wed, 17 Sep 2025 10:56:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Walle <michael@walle.cc>, Peng Fan <peng.fan@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>, Han Xu <han.xu@nxp.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: imx8mn-evk: limit the max frequency
 of spi nor chip
Message-ID: <aMrMMgezCH0GnAZW@lizhi-Precision-Tower-5810>
References: <20250917-flexspi-dts-v2-0-7e2a95e3cf4d@nxp.com>
 <20250917-flexspi-dts-v2-2-7e2a95e3cf4d@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-flexspi-dts-v2-2-7e2a95e3cf4d@nxp.com>
X-ClientProxiedBy: PH7PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:510:23d::22) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB10095:EE_
X-MS-Office365-Filtering-Correlation-Id: b78f2830-178f-4eed-1dd0-08ddf5fa72cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E6S/FPuxBFOiez7vCLYBiNwsM0O7fWONgjw3me/UN5h1gx3BBg+MXpG1tCLH?=
 =?us-ascii?Q?gzQhK6Gzo3hJVLAAUg9FFWwkv3k0u7hh/jiEzyNFNSvSpzVoGyYSbNOGfh+7?=
 =?us-ascii?Q?3exgF2ov6T87WlHDhDYjmz/4Pait1JleHu8Oiv3IBuIK+BXV3IR+ue/UeA1k?=
 =?us-ascii?Q?tWM5LCTwG7peMwy5IcQkAvvN/ulWkmFKJFbE/5WIF8PZ+rIoVL18ruJgureP?=
 =?us-ascii?Q?p9FAK5CC2cf/HOpGkyZailmZP9cSO/mmZalsH9PD59iASnOUfFU75R2KFq5N?=
 =?us-ascii?Q?V9iGOBnLZMjz7MQ+eercEkyhYbgDX2Xwb6VFIVq4eV0CcxccIZlB6z1FOiQm?=
 =?us-ascii?Q?Hbl1Ef8IrvO1zVqEXncnIZ9ysk9Syfa0T6/xYrbcTQs8vdL9NIn7LEU2axz8?=
 =?us-ascii?Q?vI1nMfZfJuMjzUVaJGEI33i3n90Z7WtJTKExo7+SBYKoxD5FrARVSfYJvx2b?=
 =?us-ascii?Q?0ftukr8rPTy6bguIAXSk0jxnO9eBkK63sl/Ru5DkEprLiUiG5pqZOtr3yANZ?=
 =?us-ascii?Q?fOEeNZ+3OA68cFV+GnfmoRgPSzMsiHKwJ84e/imUCQjd57DzMTG3qdAbRZzn?=
 =?us-ascii?Q?2t9Wk+KN18IdPOjbImiunGMBD/FZGJO7aNGn1zKSQVFJ+Vfvt6+ri9+8rD5g?=
 =?us-ascii?Q?K/N68lPo69KF8O2Chzqg0nRwWWx983/zpi+LgbMzyNsbsp8yshHh9LJGicWj?=
 =?us-ascii?Q?cmuvFh4IVcoqvdC3P8AY5CIKiyPxZ1roV6qj8ycaocSeN0hGLofiZkE7myER?=
 =?us-ascii?Q?V3xd3X9NBOaswC4ziH6nISlwRu9CpeQLrbQAjp+Y66PbTncWijV1yd9+1PG7?=
 =?us-ascii?Q?oVvLCtRyDsOr3pGJeGGtgLGmH54+jZECKv5+tgEF5PZE9TrLez5YhVhjfamX?=
 =?us-ascii?Q?ErfblDJmx3tUzkge2uXTZtxKCFqqx3BVgMT3TTH7WhHcGv6SFTkjMFzP+m+A?=
 =?us-ascii?Q?OYCQBW6uUV92//6yaQQbF5yoxH9OuCnEnhDhVH1NCzhF9pke87e1EZoJy9nC?=
 =?us-ascii?Q?uZ2UznKgySyUJh3Z6Gqq/kcLLlJVN70AxZUDEenzK6ujHVKPZ1b2DKwqGtu2?=
 =?us-ascii?Q?sWWVcf/B034tXqSkpVh7NC4HBWPV4Th6p178BMzT0jHvURXgbzYYHoREUysc?=
 =?us-ascii?Q?2eZOtOpZ2GfSq6pgbSnjhMQNdt2134MTmaD+fW/p8F+Y5Pxd5LkunJ5UClqu?=
 =?us-ascii?Q?HTUE/FZ98ENl1Fk0GTMkNGyAn3j3Six1fofxIusn4C4QdPGNlZf530iDMIKZ?=
 =?us-ascii?Q?Tap6i56i023KizTIVCnwhqS8I3NfdIY1yQIBCH4be9+JHV5AyFJ0VwpWuVvQ?=
 =?us-ascii?Q?0psawwBh1tLZnJBzn6s5APeCY2u1AbJkhfxiA82vvFGzyqMoJNfqd+5v7MVq?=
 =?us-ascii?Q?P78EeBScx0bOJWPubmWkk+mwSTZo3Rp7/YB+dF0Fh+nTwOeLJ3li5zK1uvmM?=
 =?us-ascii?Q?s18nEXVvgjQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X3u0jsq2OYgN55vMPkLUkrt0f5dAT95U6AuEzxeoFZ6+Q+P8ADXzttQSlCNy?=
 =?us-ascii?Q?XOJAWg5QfqqYBDJcGBpK0lVfmzrtx2BA5itDSGNp+j0C/YSkleHPazQmv1J7?=
 =?us-ascii?Q?2J1igOVrk9OFN6kgxKh1rnrsBpR9K0/2IydPen4r6X8iKbHlSNt3HX97UQGQ?=
 =?us-ascii?Q?ilTlh36Og8nYyPP+c1Bjnc96lbuMoowD/K01WWMggQFjKloVENoyLU+AmSdZ?=
 =?us-ascii?Q?jC/2T1gz7rc8U1xpiKizzZOZgDG/PT0CsomaNZwQn4tQiQcZPAfoWW3STypi?=
 =?us-ascii?Q?rcMCLfgf4XzPB7I++O1aUzu4gapGEn2cUUcjXZIZGJ3Zdms8sO4H76cnOFC/?=
 =?us-ascii?Q?cKq/MLVzZonE2pI0+1ZsnCH22YxeZc5kWOTIlOWFm+kkdJ/5wOZ8mFr6pR1Q?=
 =?us-ascii?Q?i3D0hlmHD/oOeGMSTYLPXDqqtm8BHvmFNLBM/9qyJStHOQDf7xnMoSVbu1aL?=
 =?us-ascii?Q?7KZ3A5P6JdFOj4QuhC5Hx0gMki+cxlgOEuX5f4iWnREd9X7oTa9SfaaRNbNg?=
 =?us-ascii?Q?vmyUqZIKMUQBNbUUD71RNUpD2vwBrUpa3eimj1sS4dnGRIAeLA6z/Dl9rN4B?=
 =?us-ascii?Q?Vy6ajHJ2ody3wogSC3JM6eh2s/v500638hhQ9aGdhoUAl4X0SudmoRlC2cUa?=
 =?us-ascii?Q?EdRF9WHeu08piP92LIv00vfvadUvvHU5EZoT6m9fxby6XICzrJEQZfTPTCqY?=
 =?us-ascii?Q?Wbvv3nbl00pnwupZXwI3Cp4SQ+XZSP3uezfvnWESROiUrrotT0WLvVFXAbJL?=
 =?us-ascii?Q?0vI5TfUaM1DGxx/MoTJnFroWzKk6RLyDDv+FCzONIDcVmYOxfejrG5fTTd1j?=
 =?us-ascii?Q?x8psuRkyOYngr27YyAHJr0fj9Yo6jv5g+k2wxAgdClKo9+CzbH3gy9NBLyf/?=
 =?us-ascii?Q?KjeLevAXQbE9RmXTkiaESt5ulyqbzKrdDMImsJxX+eE6lE4E6qa5MPHfP065?=
 =?us-ascii?Q?FgaDc4KhbDaRj3LndC8dQsQWUnYwAInW9geWZN3TZeyXDlZWafThnCdvhcMI?=
 =?us-ascii?Q?1PgEq5j8nPogU9tQ2yM38BgsY6v3NQ9ns4lgX3liL32WoNCq8RgAFvsm+W8I?=
 =?us-ascii?Q?+kxgjiT/UGCQ5IQYTjCsaICr+7wigUX5KmZR8JTTV0HNJFeqD5dWICiHVYzH?=
 =?us-ascii?Q?wK4kH5DbLZX9iN9c+W4ziO/RworySmmmXeuXb4WJSGSbsjPFZ1GP6dWVWLma?=
 =?us-ascii?Q?U5AC/IYtRYJ7RW+aDYhM5dz92TLgb6WGrMpa5S9NaVJBEkwC6sP1AA4LRtWN?=
 =?us-ascii?Q?HmnqrO/fm2G9EEdg08uHaQsYHDbrmoVlusiu4ikQAmw0Jkk3c7O2o9Y0qEAi?=
 =?us-ascii?Q?ygpb0M/itWo9xsoe/CyzLjazfcufJTzW2Uj3UgblDrRzEWnepNP+tbzWmiWx?=
 =?us-ascii?Q?JC+BLT4RSkArN4jJ+47WLYVHGsbo2Ek4XUfj+U3aUZrlNId8Y2G79azTxSR5?=
 =?us-ascii?Q?L+ARWDdi7kY3AW/LDE/1YXZeNarvHk6pF4jzxJWooje2DaCAbFG/xEFhXWjB?=
 =?us-ascii?Q?zpaB4inIqD4k9at3kZXdXdvS6wiMWsb4VPdLA5yH8j5BBraNr1x+w486xx9k?=
 =?us-ascii?Q?RV2VR3Rk4A7SX9mexqlsNA5fNJYAFFP1eVpWT+eU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78f2830-178f-4eed-1dd0-08ddf5fa72cf
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 14:56:57.5389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtbU7ImKOLHOxbA+ICnpqBRYdex/B4dBhqft5G1FJPi2htN2LXZY8mr7YNEJzgPxX6C25F38OlJy6HV8vUZi+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10095

On Wed, Sep 17, 2025 at 04:42:28PM +0800, Haibo Chen wrote:
> The spi nor on imx8mn evk board works under SDR mode, and
> driver use FlexSPIn_MCR0[RXCLKSRC] = 0x0 for SDR mode.
> According to the datasheet, there is IO limitation on this chip,

'chip' means spi-nor flash or imx8mn SoC? Looks like it is 8mn according
to below refers. can you change 'chip' to i.MX8MN

> the max frequency of such case is 66MHz, so add the limitation
> here to align with datasheet.
>
> Refer to 3.9.9 FlexSPI timing parameters on page 65.
> https://www.nxp.com/docs/en/data-sheet/IMX8MNCEC.pdf
>
> Fixes: 579df4288896 ("arm64: dts: imx8mn-evk: add QSPI flash")
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> index 145355ff91b454795478b504eb403b0590848d46..fa43238e7b917a5b5f0bd9af96bd900f6dbacb8d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
> @@ -199,7 +199,7 @@ flash0: flash@0 {
>  		reg = <0>;
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -		spi-max-frequency = <166000000>;
> +		spi-max-frequency = <66000000>;

Looks like flash's limiation, any common property in spi controller to limit
frequency?

Frank
>  		spi-tx-bus-width = <4>;
>  		spi-rx-bus-width = <4>;
>  	};
>
> --
> 2.34.1
>

