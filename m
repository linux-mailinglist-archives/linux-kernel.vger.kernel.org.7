Return-Path: <linux-kernel+bounces-899818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F307C59254
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 113B04EA395
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC0335A126;
	Thu, 13 Nov 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VITPxZ7q"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013026.outbound.protection.outlook.com [40.107.159.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797DD35A120;
	Thu, 13 Nov 2025 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051325; cv=fail; b=KrwmDy8cCAuk4/zeEHa5qgNARDCPTIDv+a4fuEP0jcq2Lm0l34HWVupWn0Nhm7BlXv+HrfCFIodho7cvMzGDTe95crf8061tSw1ivgFHcqM6/PRLB7IvrTdmFOPwEULb5NJ7baZJJPm5sRNxDNTg4k0nplf40FWKbTQWVdCBkLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051325; c=relaxed/simple;
	bh=CGh+s7Q6xdvxkWSnDeVcO1hfJMtxac8CuKMYoNTc9Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HgLPmW8WH433yiGwQFXavxn65cMNz1+Ie+7cQDfugzFnDweiUh5JApHrVc6IncDYlotQat1ARYAOpBUFDjY0S7v3iEtdOM8vYXXXHfNAvJJPoPXH77+voMjSQpy3vZ3jWR1t+HeUm9n9hEzJYk6nMBnafniurucESpGr3Dt3VXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VITPxZ7q; arc=fail smtp.client-ip=40.107.159.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XblIkUxL29ACsKTHrkf+NaKRK/iPm8pVD0uANtmpHTqvuttdVl9y6aiE9xyFYhKgUvm3sFQt044J8hnxXSeDEYN8kEoTDq2ZyAwwm4tH6ZRyN3wdgo+BD1mZfQ60uBiJLWPqmtcLmOXTUR3bZvmsr6RODzUj8Shv6pPK1QJQDnEMgA5xaHTutWbEkBU4csOO0WoXzXJzIOzcrSH6trHOY2M5ud6JD5QJJ6N3SajL0ltXgpGzuSSK9kG0W9Cz59pipIlIStNqDZr6FZw1IFfszuLZmkE+ecqBYq21yel0y/a68fWZ/rxPcDSqStSA4sc1nz1uFn5MIXDWQfddkHtLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWAKa6GB/EYOnsD/KBNuIM3zVbu/DmENfxDTtKQBSLM=;
 b=QC0f3wDPOX0Y4wOIZvB0TdkcsamnAudFiKHPXCUMKNzDRmF5r1lV42EShLhruyKfMl6RTAvEUskTD1XqplEsGv7+6cVbwNaoahfX/h7/BeQeYfcaFmexNtsHTPPkFJYaqCqJ8bMU/6ScXF5t0I43VXMET6hmIPMHxYNK1kKiZQOucScDPYwibo/yUmVSepEu+iNKJ4OKRF6VdSxR30dvWYNZRF0EG1EQaDHllIovOdKUzhzsot3KNbIA7RwT4IQciYrZyih9q866yHlTxyH7xHJaGrcxAebGCZ2hMVl3RMpwKDCnLkHSrVzUp+vPQaZrx+3ZhB25RY5Mhc7s5r9wvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWAKa6GB/EYOnsD/KBNuIM3zVbu/DmENfxDTtKQBSLM=;
 b=VITPxZ7qDY4L0SvSsezrHZ/cymjgzLuprmbHttLXZxALW1j/dVjLKrq8aM030nmOF3pidrIHWmAJ/9k7BqeAe7Jh5aaT5ateOUqgk46AAAcQF7b6Qy6lXdXuoFvmIeB5ccNPw/yYDYRBPbleUscc9jQVzbP9YIkYJcnYV9aPu0nQ3yuvR8OXITeLb9KY4OqSpmuEjZP9/dkwTJVa+CIHIlLGvGQw7hhznTNP+plljX61A1mhih1Z5yLwvbh0CExUeEQ3bL+Yr4QszvIXcMelZNVEl2I7sGm7Nvj3Opz681bCmn/CvM3f1BGHs0/13b8pGK6fH2T2KU2UWm1GStRVJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM8PR04MB7762.eurprd04.prod.outlook.com (2603:10a6:20b:241::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 16:28:39 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 16:28:35 +0000
Date: Thu, 13 Nov 2025 11:28:28 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, jun.li@nxp.com, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8qm-mek: fix mux-controller
 select/enable-gpios polarity
Message-ID: <aRYHLAVjcr4jcpJG@lizhi-Precision-Tower-5810>
References: <20251113111444.888985-1-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113111444.888985-1-xu.yang_2@nxp.com>
X-ClientProxiedBy: PH8P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::13) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM8PR04MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac24369-98fd-45af-97db-08de22d1b164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ig70dKKgyGtDWr0NRlnaHsVkUNZSav2rMlRSDID5IBbwPI6DEbRFiE9ztWzI?=
 =?us-ascii?Q?+IEKnS0ehf8/NE1h87fNHkQ3QwpkpEy4sL5cZ/RHt8SN9SMUEk4VieGcfxbo?=
 =?us-ascii?Q?ryurV+/ku6vCtcbPiuhocX+m2qMatGdTyrHwZsHfxOJZyu7GyvoXpinThu8o?=
 =?us-ascii?Q?IPc6XlhlcDlv/rjt4hJXUCGyNxQSxYhk91qd65vq4yETV1jG3V2fd7p+ista?=
 =?us-ascii?Q?E7QKPxXRloeC2XxgNsTpnjFF36pJFebaaVPzH2irX8aXnV3l+ukZV+nqxij8?=
 =?us-ascii?Q?pJ3Ey7NYZiWnTB+5a0j6AIVEvx11tICI/Dh1b5V8Kj3VTAyvrc74mcnGoyLF?=
 =?us-ascii?Q?eLSf164X1HRnCZwCR8X0waQdpl3TokmP3w+8BMGt29DcYj4U8ESz3QuJfhMz?=
 =?us-ascii?Q?tUjtkH10gsEurnq2WxFkbjUR7vXLNhjYc616NYGWLsbIhcFMQ78RqxIt3jBc?=
 =?us-ascii?Q?2F0xgzy9WVO+m72UwceO2SLswDr9W+PWPIHZCCHJ2cawhRSIM02oCpJYzIox?=
 =?us-ascii?Q?7k4ZvnAMFipTTzC9ooXnj2kaAue3qOggy/EpgWW4dmr3BWiWr0SPVD+TjkvK?=
 =?us-ascii?Q?AjKJ6vOR/y9iqjhcosieBrSQGkZeOh3aSW41bLjNrQ8AjwoNxFoFO37RFW9m?=
 =?us-ascii?Q?BxXKcWl7h9/F66C4HGFmit+2UL/Psg3c+aPodjG0A9rfSJhd759dUypUy4vB?=
 =?us-ascii?Q?LBSvWMg3PU4HtEWe0V/8UNAzXDVp5jZn0xEooagVFvRTWsuVIq0x0HCri1v3?=
 =?us-ascii?Q?g9OaSxVzOYcuJlqd/5hql5uOH/DKzjjFKa24Q84fEwJNUFIXzLoj2ZFKeNZN?=
 =?us-ascii?Q?aXEMlAfU/X3hMamVcHTnLa5Yp8CdJzxLGWXHuQhvWXsgfsUUZVAMYtefkutp?=
 =?us-ascii?Q?DF1kIRUFLfsnyOUaQvrgULOPPXWGs1Xaw/IBwY5C7vr0kHUWkLno7VAab2/V?=
 =?us-ascii?Q?aFnrVhIOLh5ZPu0GhISva3XZetAJWWd3t7sPkU42xBBeXCNgybcP1NUHnxIC?=
 =?us-ascii?Q?Lx21PW+4Y7C9AEnbz6MoAm/iS+GEKcegXjzi7Q9XzFL4qc3jC3XmVZDWe6TU?=
 =?us-ascii?Q?uzmeRYYFlmBicgqYEFQ9H6aZ1Le7ianwT9dpFFQLeY+jtNrMloZ1OLr3nW7b?=
 =?us-ascii?Q?aq3FN2GlwUH2JWoXSPlAzTx5L2OX3HsUTMuMBS3tWFzz4LCVB5TXqBFcHgoj?=
 =?us-ascii?Q?BJt2phWCmO7yGEPfkfKhEUzNSfJtF0/q5l+csPj+7CinxYqFhwWRwCJtSmAE?=
 =?us-ascii?Q?xPDTkicsBqAw2H4gUSVXmGY/tOSMIC8DY+BS7Xev9VYPt8iwyFIb5M4m60D5?=
 =?us-ascii?Q?5CjuMp9Il+CCP72LYlsF5XyA0mH0ZB73iPY8mGL8tgd/pOI5H/rnGOTXrWHa?=
 =?us-ascii?Q?amDU4FQ1DvLmXHx6cNSvZrrqBUME0ajPMgcSMK7LqOz5ZrcNtCYaDpdfHhSx?=
 =?us-ascii?Q?D2xUKuLyR6QmCcB3hFsIcLYy3pKZ5XZKqichlsOsbtaMwauCY5mU4Tre4Dqk?=
 =?us-ascii?Q?4VAiUXJYp7t7t46kQhc1DdTdu0MgDBy8bb4f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?40KpYbxCFW3RLtSMWCaT9sFxq9Lo9DWrBbkVsqsVUVE8fk/VKPnLImKwluwa?=
 =?us-ascii?Q?e3ywl1t/WpuYWU09RsWwJft0lrQOE+CS1ICuuJ/kDD98E/Pz5lUb3wKnoYFw?=
 =?us-ascii?Q?xr/c8krs0XxIi6WW5nQWVDpxVs56h7TolVAmUmfLOMKoItIJEqmvcIXtf2V0?=
 =?us-ascii?Q?sFupwXUnsos/EwWDtfg7a+sYdX20JCP6nVqve8gk8ZHBairUeP576PrgqEr3?=
 =?us-ascii?Q?bMUJgAszyc0aScQvQGVESJ1JJVCqVNRRvKmLAqfW1K9zqZAe/ktH0qXTSZhX?=
 =?us-ascii?Q?bCMJdOg9cGsnTAsXCi9NMqbLBFx81H087ovhxNEzaxFH4gRLiz40FLi5rJBp?=
 =?us-ascii?Q?LtOJG6VdB1Bo7W9CAjDis120z+CQJLq8VVVDIIlYd8s4K5eTxN7h36m1VUrl?=
 =?us-ascii?Q?5AdElM9zFi4YuNZZl8h0PP/AAJkFB3IS8yHdmiI3qDc3oyJScjq62cmLclJG?=
 =?us-ascii?Q?QH0F4FxTgo5PKGddRgDPMKrQz02XiroQzqCYwzXYA15nsp+1Bu2OUqbEQM3Y?=
 =?us-ascii?Q?bMr3qRnqHWrhO2cz3S2I9+z0PEo2PtGff0TM26gYD4xIVLyL3cTe5+kFbPF2?=
 =?us-ascii?Q?cvdfKp2/Vo9q5GZ3SbzWhHPiI3q4dB1++CJAzEwyBprJ9wbQp9s8QxKrQ3qy?=
 =?us-ascii?Q?McWSuwUQYxbaLTumr4RBlkDuwLtDY1amdGu0ien2c6pG8LceZaGaWESeAcV7?=
 =?us-ascii?Q?pPwPQawOMg0a8HrI01c3aPXexHQ+CUz90Ga620QJ1Nu637iTYMg1j84he+/f?=
 =?us-ascii?Q?J+fpjViiwLT83yZINX+uoBmUduCxwLnWLo6+y6JE/guVio2XZTORUJlsJXdm?=
 =?us-ascii?Q?KImlIQpwlPLVZMLyDasaEmrOybGsVNDmhS+ylpiDGPuWpeBQaY5q4M84UjST?=
 =?us-ascii?Q?CPYcKGV69/OFEpGoMyO0ZEyqOKDc/GtFT8hZ0KxcUN34/rim/515ySacvwWS?=
 =?us-ascii?Q?s9fF6aEyTNJBVpxUU29ASl5/+rF4nX7/IDv0tMkBShlkrRZPRxk9/pqbDDdE?=
 =?us-ascii?Q?cMExcvPWQwigoTCYn626yIdtN3RWNfp2mbvd7FZNFWYOBFOe3N5GLhguTGIn?=
 =?us-ascii?Q?7UvmGVqzWRovAM83+ZDt/xRy5mF3YUvZlW6hh6wnD81UczyHlQdWIDEHFOst?=
 =?us-ascii?Q?Bcdev6q4XPK7FeObZuWzvUlE9Sf75IuRREE9O2crMT7r7e+EvCbeOesiSADY?=
 =?us-ascii?Q?A6sd4oQARFherYxWbF7Qi/J+qHLWGXzNU3kQ9PgSlCSm/1v37yu747XtmKV5?=
 =?us-ascii?Q?B0Tvo7sb9yZNQR4KhRS1OO7XnfFki43S+fn1NrWYsFb/cnh8Zn85vUlLt2ha?=
 =?us-ascii?Q?Bv8I1YgBXt2NuAJy6l1htF89PChHUpShPV57LtuEvxULhD5IefUTOBPCcClX?=
 =?us-ascii?Q?t/KXyvg4sHfcA0f5n9QrzssAOaTvb3rZEjnqlCA7h3mhDRAJUZP6xXj4u+Ic?=
 =?us-ascii?Q?egFVlW2h4XnFjpNtfSVGgaDfMbyRxyZXNmzdJWgxxNtmmd1CAEdl+UqiaD9J?=
 =?us-ascii?Q?bqXgNRB4csS5/trP3YTAMKDwlwkmtSwoz0Ti27QlwgsDVUcccvUderKmsXJo?=
 =?us-ascii?Q?2nt0aCNE97cEM1YvJvw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac24369-98fd-45af-97db-08de22d1b164
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 16:28:35.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urKrf3F8rIapTvzWBc79UCQCaX9+ieXJ+utyWMUankJPKze6MWHnwIBNVHkLVpFYSiY31rA7xkrmbcxcjiaT6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7762

On Thu, Nov 13, 2025 at 07:14:44PM +0800, Xu Yang wrote:
> According to the board design, set SEL to high means flipped
> connection (TX2/RX2). And the TCPM will output logical 1 if it needs
> flipped connection. So switch to active high for select-gpios.
> The EN pin on mux chip is low active, so switch to active low for
> enable-gpios too.
>
> Fixes: b237975b2cd5 ("arm64: dts: imx8qm-mek: add usb 3.0 and related type C nodes")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jun Li <jun.li@nxp.com>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> index 202d5c67ac40..9c0b6b8d6459 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> @@ -217,8 +217,8 @@ mux-controller {
>  		compatible = "nxp,cbdtu02043", "gpio-sbu-mux";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_typec_mux>;
> -		select-gpios = <&lsio_gpio4 6 GPIO_ACTIVE_LOW>;
> -		enable-gpios = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
> +		select-gpios = <&lsio_gpio4 6 GPIO_ACTIVE_HIGH>;
> +		enable-gpios = <&lsio_gpio4 19 GPIO_ACTIVE_LOW>;
>  		orientation-switch;
>
>  		port {
> --
> 2.34.1
>

