Return-Path: <linux-kernel+bounces-759069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908D7B1D80D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F8E3BE161
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECDA25392A;
	Thu,  7 Aug 2025 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gZfLsR9V"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013035.outbound.protection.outlook.com [40.107.162.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC94251791;
	Thu,  7 Aug 2025 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570192; cv=fail; b=douonPmpupDrQljxK/tTBx0M4Usm35+nCZ3Xsq+jFvCw7vHRHYkFjQGfC+kjsVl+9e4qnUgsFuirT7tUWxnos/jH4ddkt/l0GLsXsP0ROYRTFbRFcyVkaivSqIo8lOKPAnzXHx+uT6Dzk3QpYuGEdQ5JxTHFyb3btXEov/dGNvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570192; c=relaxed/simple;
	bh=tD7c1DtHfueimnuMxkIP3SUPpGSIKu/982WfocMHaiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P9JM9wmAZtiUzvl1kpN8bGmA/gsaZFfjfkvvdqP9BMr1AyWm1ug+z6vcnIP0UwOkldfrnkLfDiSQiKoQo0IJ/ccZ0mMuHyRh6PesLy7E2vSfHlqaSioEV9BC4Po8wRD+LGmaevEaOEh4xpgyda57wp/O3SWvrwscxKMTDkFZ9sA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gZfLsR9V; arc=fail smtp.client-ip=40.107.162.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1M4D7BgHZC6XZclApg6Nr+Ub85fKX5GF8Ss4faD30MM9mAJhhfvj30Nq3CYng+aUcb8yAiInOenBX3IhANxq//rBkRjFCjlZEA8keFLgrVpkVWdfaAmTuy9iUr0xBcOOiGoPF7ScDXgnR7D59TPNQuJk7AjJjTcGNFgpRXeQr1wQFHXR4C7wXlUhrlqdYZ9L3xOWSzc9HKJLfsISDurNVPYZJJcWRJoloVIxfQCqlk4g0CKNOdmllhaqAc31R53H5bl/aEVMiBY6DIwjZaQrHo/q3ztuGLVwEM3UTrOUVeZ1Z14lnJDw/rKHO7breEhv1jVgVkrcet7NuR6rwZMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pJmpyDb+bOD7r1Ada3BGPenYgidhqu1wn5+DoZ5/48=;
 b=kB8xb87pPMSOwGyac6DGlMlL8TTmP8SxnJPUWt0OBGY4ExEeQVYJB+b++iK3zmvNXx0+D/KiWWV22xRdTsEWqY265KBLs5jnpkYG4TUTLs2DgSeEK8iuDHWlONP2iI94C4Qj+bt7nwK7owzRmZgMnBLUZhUSLIJfxaEeO4E2dg5sA/uTSNA5J2we0CSTYFN6745vOGBjZo0M1IhzR4WP33adbBMiqlx1EsLHtzQaqLDlPycJ7nbn9Bc8PWSYiHRHXYnISvBEAQxQoDBrHcXSR2F+2hWcxhk6UCJ+4nEv3s8Ca/F87EJpqb5E+X8+LxDLjGakd8refEcdZDnVuE4vnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pJmpyDb+bOD7r1Ada3BGPenYgidhqu1wn5+DoZ5/48=;
 b=gZfLsR9VIpE0oSfjy7rlRGenF6NK+rzt0nMdRVuWs288XbPeoA/0NKEf6I4FdRrT4QGerxRF6o+fAhLvkWzmYPA1YY1s3rOHq4DqPvKpDnJ4da7O+ruqXJzKYBnubR8heX6n0+H+vMq849bc7TTk4u9hjloyhtNlqPNACKaiDBqvomn0gR0iIP/IrBGqGjX4a4v0slyOtjDI7lNfiLz3HAyb8BKBESPI3HBZ0ONyr5cjU8RrurA/N9qCgJ/fbq6Nic+I33qbFWyFUsf+bcLJoSSyT0b3IYAexwa7P8FDsNpIPimac7mjRDiA6gBNub6pt9AuKZcl3N2sozsxvgy+kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by AM9PR04MB8178.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 12:36:22 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 12:36:22 +0000
Date: Thu, 7 Aug 2025 15:36:19 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: imx@lists.linux.dev, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] arm64: dts: imx943: Add display pipeline nodes
Message-ID: <rlyrteeb6hxh5rtbdh2ba7nnwsiv5bmob7j7a6h4ucmwff54m3@s2sucrbksx3e>
References: <20250806150521.2174797-1-laurentiu.palcu@oss.nxp.com>
 <20250806150521.2174797-8-laurentiu.palcu@oss.nxp.com>
 <20250807-illustrious-cuckoo-of-management-dacca0@kuoka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807-illustrious-cuckoo-of-management-dacca0@kuoka>
X-ClientProxiedBy: FR4P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::15) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|AM9PR04MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: 50fa0dde-6206-4d20-58f4-08ddd5af0432
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PdJ5DrWJSSUcbg4aU+XN/ov+4nWrNjiKVL9qDe46+fjswqkzBENh0Rrel2Pz?=
 =?us-ascii?Q?S48n6R7kI4BZ72MdMrjxxSCoOYFm3QKnkGD9HFAbRMrERIkh/y5SrnfFeDxb?=
 =?us-ascii?Q?KM/YFucWQBiD+3EY/Jed9Jq5SD5DcrOc4rLuYzrrq44ysuwNb7JMgu61lfPZ?=
 =?us-ascii?Q?bqkdUqDX6WvP7JcTqZHL6SodVCpRkmbl+dlF8c7VoDhHcA7lFBLAmZVZ7VJO?=
 =?us-ascii?Q?5yyIrL0qfrUYu7bNJ9zOUCUwyXMDdeH0jXjUTRAqdZ22ura/lVqcpKI0oksY?=
 =?us-ascii?Q?/mKUSJB+KcLQHHkxUEkFrb1awjz2mSdPI9Dp+3dKZQMp0F9tWDuMFZX0C0Vs?=
 =?us-ascii?Q?zqrJIipwTsY8mmZo5OvOySUoRnq678ZKp30Dd4oMbi8DylJ3WIU2hS5ebAnl?=
 =?us-ascii?Q?5e44M0Wl0kcrG5ty5Wzwn/9FciAuE0LXuQ8nfq4Tv/o/HoqcNud2kMqPkvwV?=
 =?us-ascii?Q?K7GYYSscdy118En0Lo/8Etjj77eShjvR5wkwQ7TaP5loCETVYvTwbHTk1mfX?=
 =?us-ascii?Q?/ZlYg8ctBlkcw90O/in2FjCWVGCbxVo8vrYLtPdl1/AjvDT4uNJPZKCQHqEa?=
 =?us-ascii?Q?WcpBgGGPxSzaYubDw3F86usV6EAT2Xie2StX3b2pZJvcDK0Fvu927QiSL2Hx?=
 =?us-ascii?Q?74uWyAxbLbbvgDYvvubr7HJCh4xvl+RyfGTx9SUvZ0COH5Y/jiTzzcx37qxH?=
 =?us-ascii?Q?MLQnSs4ZG7gnq7NKSmfNLs9H1bgG4xp1Z4PhVAiA6KPQ338ZZhKGM+DpVbGE?=
 =?us-ascii?Q?UPE+0fxfNegXjiZYvvHx5n2LLHmQdtZYs3tf/5Tud10clB8R9GSFdBwAdJ5l?=
 =?us-ascii?Q?QvpHqyFaROI33gbRNe0hwcmYRzC0caA/UQxoheRUJl7JiWvbhaOM9I0uhTx7?=
 =?us-ascii?Q?uW/VGZrmkgfuUc4itWfyl3QwejYo39IGWDukj0bgdjPSL62K0tv5H4mr8Hxl?=
 =?us-ascii?Q?pHK4xI4yDQIoDjF2Yl0uMmb1mmQpXvzHjPlIigKZs17OSYCcT0vy0Bf+FBOm?=
 =?us-ascii?Q?uk8co014zd5BqtcCplKAXQjS10srwlGsGXBMO6io8oGG0k3BI3/g7YXGtU9s?=
 =?us-ascii?Q?rLnWoRhhZNx3WlExuMgAP6vIfU6JfcwJElz/XIYXiE/zesTuYEljXIbEn2av?=
 =?us-ascii?Q?ZxhFMukSfrmGQHtBqc4YU2uL7qyGezKbaCm2vxgNwcjXEaXLs/vH8GV3GTRA?=
 =?us-ascii?Q?ryvqIfW23Al04pGyvbjgnmdinVhu1iXsQ7cPy3bd1c//JJECSWVT50ootKK0?=
 =?us-ascii?Q?xsN4+soGcMxrR32WeyuFDaeXyXB1ZN71zwpBOu+2ltWK7q12jIkrz7Z9R/Ma?=
 =?us-ascii?Q?Q5hm5m3c/gLtOGtNDR3o1XGSjwwNWiws7LcQeLz48p2hDM36G8hU1oipP9vP?=
 =?us-ascii?Q?zC99BR5OzQt3TtRx65uTi4tEeQIhEr/78KLufzlrAEJgwERnOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9135.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QCj3sK9KGrFs0t/E24//mdrfP58MW8HgR//tAu1U8giTSaLKHRO87+Y347RS?=
 =?us-ascii?Q?QNlfNK9sf+Swcm//15uomlcbzltJNIoiXNTj6+JwmazGF2Ilnzre3mlfszre?=
 =?us-ascii?Q?wMyKNedB/+8nT1F+9vO2qUBzq++U5P7e32Vk/4OZdlObZz9PDPsCxHWVqeiv?=
 =?us-ascii?Q?1rN2+frOSGuLmGHDxc4LFld2Hh03TRx4Y0bjfC7xesH2k2rlRI0FbJcEWV1g?=
 =?us-ascii?Q?w/SlQPIFyHTGc5VP+dEnw5PukODu+DJIrQc7b7P3QCNuIra3shN7OpNGdLGp?=
 =?us-ascii?Q?nzafLtPzIvAIiQBk9th0qgauiQCMM+oFJZPJNZdTQtu13VQU9Dbx6tuMmQ2c?=
 =?us-ascii?Q?5LIsas/q6wf6Jt1V2cZM998vTNPqjmQEWUCuD+8xwLyuwvFZfUV67Mma98lL?=
 =?us-ascii?Q?EORQOOwsVqjBaAUqcnLSnoOjE/u5f06YXKjqNXEjzjsmpQPBsKpgfcuuHC2R?=
 =?us-ascii?Q?rCi3AYB/+XzyerZF2mLHxBVDpoIyDNclB6A74wrN8GQVV1aCzqRSeiha80Sv?=
 =?us-ascii?Q?A54UXp9QQXr7z8lhtJYOYy11Pnp6YoFVHPidX6i/hvJztrxNnPr8/2sdo8vm?=
 =?us-ascii?Q?PzbbiIIjR2Q+XKJb5QhmiKvO1oKM4Do3Ff8VGAT/4i+aqKcFA2a+psI0bGKW?=
 =?us-ascii?Q?5V3XmCncu4U9sztV24x/ynpBe3pT79CTjX8F3m8/3Y+AhKdcjKanPBDQTsiN?=
 =?us-ascii?Q?0Q7anSQJe3TSY6WDIGqnn3kTdJxDQ6AO4/FzpC9UPiuauLvQizvI9R1k7978?=
 =?us-ascii?Q?AbZd0ilXO8CuGWNdwWPFxMZkbp5+FkPGMEUZeYeLcwzObjnLB5oMoJFbX8Qh?=
 =?us-ascii?Q?0eojJg+e9uhCleqBVVS1bw4aPAti0Ca5RfzyX1GDxh9Qn3oudbC1uaeidGBf?=
 =?us-ascii?Q?+z4KAMRynawuQ/anCFF8If5vmw8Lci6mN6EGlDcFdd6X+8qccYCI9psIgrqH?=
 =?us-ascii?Q?NaP/TKaWtVMIYG5oIcIinGuEr4tGe3QLoIJaiIW2cIyz33FSXh98nYZ210Gi?=
 =?us-ascii?Q?XO0mTyHsJJlOmWftenaEbV4x7RIwpDkU4unqxiiSdQfQu7ZNGTIkmp82T6a9?=
 =?us-ascii?Q?qT5+sD1lZWwBvSHDeUzb2QHTTPpJMyfroEOUYtaj/ASgHfSkLO2hVyn2o5L1?=
 =?us-ascii?Q?65XlTuGUjGKIzJyFL48DRemSpg1rNjpZ/GBgfVF1PznCy8LG83MyZvvBZYoA?=
 =?us-ascii?Q?ireVmYgzI5QkTXx5IPJ23C5ifQ/+ZOqJ2buSoeZQAN7E7XSQoMw04hQPV/4r?=
 =?us-ascii?Q?XrcHGnIyUQQSrNYj4dTpsGBzGfc4OFRNUZHLiMkS64HRZa3/Ci2Kx8/ztj6m?=
 =?us-ascii?Q?9dOy9AhI3t5xPVbXaBmc6fNOsf4XOVCRBkHTqEwiD5KW+LbhlWnNX8bjHoiv?=
 =?us-ascii?Q?P+tIcy/SfwFpGum2PJD3R8GbpHfcRynfqKvc0tYgUaj5w6LXCm6rLtSOui4G?=
 =?us-ascii?Q?EFNWtI7CsGqfbcIHQ61E9QCjN2F1v/yGTK2XMGTajb/7uKaDMFg/YCE9gaJH?=
 =?us-ascii?Q?idFYylRXZJtM64CX3dld+gn4sxQrdb2j+334n0I15ox+ay0Yg5Z0xsRrSH4e?=
 =?us-ascii?Q?EnPvq8GJZzxQEU8y0RrPiAUT+6/RX2UqQ27JXZ8YlS29ELNcTHsM+RwY3F1C?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fa0dde-6206-4d20-58f4-08ddd5af0432
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 12:36:22.4834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omOjhRZPE01nPSNB4wylzv/McdTThH8SZ4JG+iAIu2L+4VrYvPbQrL8fhnBGLUYKNnxJXS4sVwdgJyXdUv6/Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8178

On Thu, Aug 07, 2025 at 09:31:46AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Aug 06, 2025 at 06:05:14PM +0300, Laurentiu Palcu wrote:
> > Add display controller and LDB support in imx943.
> > 
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx943.dtsi | 55 ++++++++++++++++++++++-
> >  1 file changed, 54 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx943.dtsi b/arch/arm64/boot/dts/freescale/imx943.dtsi
> > index 657c81b6016f2..70dec03c5608e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx943.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx943.dtsi
> > @@ -148,7 +148,7 @@ l3_cache: l3-cache {
> >  		};
> >  	};
> >  
> > -	clock-ldb-pll-div7 {
> > +	clock_ldb_pll_div7: clock-ldb-pll-div7 {
> >  		compatible = "fixed-factor-clock";
> >  		#clock-cells = <0>;
> >  		clocks = <&scmi_clk IMX94_CLK_LDBPLL>;
> > @@ -174,9 +174,62 @@ dispmix_csr: syscon@4b010000 {
> >  		lvds_csr: syscon@4b0c0000 {
> >  			compatible = "nxp,imx94-lvds-csr", "syscon";
> >  			reg = <0x0 0x4b0c0000 0x0 0x10000>;
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> >  			clocks = <&scmi_clk IMX94_CLK_DISPAPB>;
> >  			#clock-cells = <1>;
> >  			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
> > +
> > +			ldb: ldb@4 {
> > +				compatible = "fsl,imx94-ldb";
> > +				reg = <0x4 0x4>, <0x8 0x4>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> 
> Why? There are no children with addressing. You never tested it because
> this would easily be flagged by tools.
I tested it but I realized I only checked the DTB against the
nxp,imx94-dcif.yaml schema... :/ After adding the fsl,ldb.yaml, the
error popped up. Thanks for the heads-up.

> 
> > +				reg-names = "ldb", "lvds";
> 
> Follow DTS coding style.
If this is about 'reg-names' not being immediately after 'reg', then
this will be fixed since 'address-cells' and 'size-cells' will be
removed. Or is it something else?

Thanks,
Laurentiu

> 
> Best regards,
> Krzysztof
> 

