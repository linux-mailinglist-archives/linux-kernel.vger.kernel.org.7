Return-Path: <linux-kernel+bounces-757977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6447FB1C93A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F118118C55FD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495EA241664;
	Wed,  6 Aug 2025 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nrk7EAZU"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F9B2918DE;
	Wed,  6 Aug 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495204; cv=fail; b=Cfx6xP2i7TVI3inr23i+E0EStTQRfOPkeo3cIVBo2x92zAdc4zkP3TX0POxLQOBaNzOFnecBl+xaILcmoU9SM5b+F3/3StKs1XrF2YLdoAoQvwmHMQWUoJ6UqRqOb17taGSslitb2Qcd5uiniqQo88lHKkWC51WzqVcfQt0sU00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495204; c=relaxed/simple;
	bh=wDvOKxIKomwHRi6n3t2D1jHfcuJB3iZipegQi5OdD+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bjEp+cTcOjUKn/ZytVaD+FK0/WrHyd2surE8YOftDYSd04wnjKvE0Ut4nCi5u/732KPPMeMX9akS7In5cKtx1Ey7VwYY6CxkVoiJLz2W1KaGH6+BXaHT7NuA+Yk5/g54lMkrJKd2vI5lQZLHDKzSrVBGHZw02Wbyg2+5BaevnB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nrk7EAZU; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTfEfv2TFnoHomgYBr+Vurn8/1g9owx6d2WWAM7VnEIv5iWjKNXALvuswiGAjHP9v4l8m8s2K9YaWxmMJe6K0YUKAqS8iV5jhCm4/QgRHdKqNxKQ3xVP0SC0VoeGs1cO6f9V72gIFkCa4n4kLPK4994CeOUa8E5MbtNtP/BiEeTxfK9Zd4IrbvK+lKWjhe6HeC41NBC70Tm9bpjRcPnzQ1S9iUPhpVfesrts2CV8V0veiaGWjAd6/WpNvt7LmVc1infbbu0ueML2bdJUcbpr3eyYx5Re/BeuqewqzFCW7b6Ym+13VerRN6kUnPqF3+j8DiS15/YZe1yw8DkTgSdmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBLWBTLDhzirnugea7SNbiy/HO8lFTUm8SIRf9WO0Vo=;
 b=uNVMSfsGO3W31EGT7whAB23ke/jlqmy1Kbco9zwT+3M/p3GMnErN/X/BMXFc3D/rqS5wnLecLktGCOCOd7er9usFhzz4VAKNA1Re3+1o1wJBEEdQpc2iIVHhDeR6k1xCIxePQUKpUD7wxbZe9xbIdkmBSM4oAxP8CG2h0eAnwvPaaPe25b5y8DSx2UX0QLTvn7EtJKgjHRrZdXlABb+Shw7mxQvj2lUudvgbdF34WKtp8r/HoL9qEHz7bRFL71liNsLIILZTG8EUcbuSIgZZ81950voe7Z4qfx4LK0St/kOfdi+aPLolLEAXLoanOIDBT9duH9TxSCYZygVDR9jjFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBLWBTLDhzirnugea7SNbiy/HO8lFTUm8SIRf9WO0Vo=;
 b=nrk7EAZUCGW7GIFpuQ8QTQ+d6NhudAngNNwJgdCMnnNmdimkhH35zH/FUGhIqTZJK/m5g6Na1PgVJuyDSX9roEvDfOz28EMWKnqgDn+6GuXGI963yuNcPbmJOdUU5/qHSjFuCjRWxI19KpzMF5rzqEtzUa3lr62oOK71B7N/tFtbA+mu5bLe0kjtOODt34CJMcGP+KweZqFcU3jM259CYoLJfZ7zH0S3TCGBLoIf49faPmhRWe391Kng34ri0+IaDtdqNUreNEhT41PiuY9miInMzpY20XcB6yzyDY3ygOyp2Pyt6nIsXN6zQ5BSvOSylPw4kC67JRZS6rfiR5zgQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7611.eurprd04.prod.outlook.com (2603:10a6:10:1f4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 15:46:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 15:46:39 +0000
Date: Wed, 6 Aug 2025 11:46:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: imx@lists.linux.dev, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] arm64: dts: imx943: Add display pipeline nodes
Message-ID: <aJN42EJo4Bqu2S+8@lizhi-Precision-Tower-5810>
References: <20250806150521.2174797-1-laurentiu.palcu@oss.nxp.com>
 <20250806150521.2174797-8-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806150521.2174797-8-laurentiu.palcu@oss.nxp.com>
X-ClientProxiedBy: PH7PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:510:174::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: fed8f3e2-77c7-4634-f61e-08ddd5006e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ypLGHUziFuMul6OP+cCsBC9/jeAQ8Qcp6QL2rNy90zo6ArX5Kbat869YJusy?=
 =?us-ascii?Q?1sDEVRm9oI84RhuPaoVmWh1E4eQmPI4Hx9Q3WW7gY8p5nZj1eImQiNPnBnPU?=
 =?us-ascii?Q?+3E5FAp9qCWOTFTaekNKGBYfloWvluceRrKSdjZXduEKH9IPSEF3YurV3Cgl?=
 =?us-ascii?Q?jxr8GCnEyJB/3bX8XWM276bJKl9yVzQ1emcFGdWtWwDOR28Alzrq2BZu5tH7?=
 =?us-ascii?Q?qoomnXClQlD00PueofAFn2FqjJPHrMg6dcF354faribiYiM607R8NYdC18i7?=
 =?us-ascii?Q?j6f1qP3wLAePsTQhF21gtw5MwcqnWuh5kfZMcoaQbB0eNVBSAxU8ggH9oyd1?=
 =?us-ascii?Q?fbRvKZtwSN3hbANUtRr29exGxNgcAfqCdhk4SfTcinKbPXpKaKoEs05rTw7d?=
 =?us-ascii?Q?gVOuic1quZhx5kOKwciczfhT5ABNGTq5umx4cdZ/LQUZLK/qkFS8901NFH8N?=
 =?us-ascii?Q?tvB5Rozl+cr5s3SB4+0SHWwouwvdXGad2j6tQuONbAUJdhiy84BV8RQYiYC5?=
 =?us-ascii?Q?a+zn+8gc6K4k4HYC0NVW4sGzMTAWczzQEo8ccWPI/edoW/s7AchCScKat3E0?=
 =?us-ascii?Q?MTLxm79ykovS50UdDno2Pfo15jDgrc5EDhuhBlGxlWj11HQ4jZj+W6fSpor0?=
 =?us-ascii?Q?99bqGHx2UUCG994DCObZn8QA0OdbjCWv5pNDJeODVM/lgYX1DIbxDllhSDx2?=
 =?us-ascii?Q?D1OQQaVgqEdzPRzUitDLNU5Pje6OO4/o52kvmhivP5RV5u+fVgFUgXrnezpk?=
 =?us-ascii?Q?DTdhhDUVbbQVaMvt7fIBV9qg7/B4a9pAvkhhq1QbLKpI5uUn1No0CgC0lpvi?=
 =?us-ascii?Q?uOkWMtYxrfniT2WOY/RMcHCvn5B9zQuOEbOOyosJyDXH28dAaC+ck07vX4Fn?=
 =?us-ascii?Q?ZbQh2zasPJagllDYvQpOEBPnRpiobUKpxrpZNDqe0C4UYm4HKvnYOeOTv4Y/?=
 =?us-ascii?Q?PKvOvnPmQ33LcnMh7hYIB8u1+Qrk1ONYc0bkcJVECI0pntZ7qr2WlHsWoG6k?=
 =?us-ascii?Q?FCPpDw+WbdIPd96tyQcr53RhUmq+yAMjB8gH0L5paBcwgEseshmNGUcQ3q77?=
 =?us-ascii?Q?854COvF9gc2XKwA7V/VMN87fI5irOYfffn3NAU0K3fM9Ucxg9zIbPNgdIpw6?=
 =?us-ascii?Q?pxkdsMVezpfDwdYrmJl77XaAe4pd1w/BzLDZmPpDfwFHogsP/cMeI5nu+YYd?=
 =?us-ascii?Q?iJ2wdnV/uW6fuaW29CffIqSn0N87MUKvoOHnZMFmDsLtgFBcxxnxqGWKWwsJ?=
 =?us-ascii?Q?gJtVZAAls1DPsC38jsuxKn9wP2qu6wHXX8QddG4iTvFrUwTPYP3Yvfl5Wjfl?=
 =?us-ascii?Q?0onq9ox4+9p0pp2fnouqzXGdyU+GLvZubiC45hTltHUuopy2C7zcD3r/gnMB?=
 =?us-ascii?Q?PSP7i6M41UsbTzRZdyX+rLjPAOxQ1tCao/o1UiimP5sQu5d6mjjlONdhbpqz?=
 =?us-ascii?Q?iE94oMp5gZjNmx+TDJr2ssW8fwLy0d3B0h/1wYpzNul1GILp0LvAOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8VfNyrw4x3aJw8rF7kxeMNs6IZAyhtUxrWS097/kjRmsF6yFRu9ypvW49zVb?=
 =?us-ascii?Q?/RaCmBRye66JyNZmh9sh4mJ3R6JAApyPoSdHavvhjLtKzZ+So+g5U5Vh7yqH?=
 =?us-ascii?Q?1jrb3FWI/FmXoFyf5MUiFzU9/AjgMLiOda+I5vuodn1O4vVMjgQoJgGefzur?=
 =?us-ascii?Q?giKE0Ung1Kf8trOh4Crb5tdCBnkiKD3zEq/jrhCcgXMkFoivXPdpuavV3dsn?=
 =?us-ascii?Q?HAOxLpOXh3JcBWjDjJ2woXaj+msqxvPDBirA+WsgvUN6OT08wfFSXq2J+rea?=
 =?us-ascii?Q?pzEkc2qNGr7fZa0L9KKMZUnK1yb4GL43Hm04S0J2vsGN0dpcAuFRBW9qbFtD?=
 =?us-ascii?Q?OpROp7Mkd3zymYVnY6U7JNo4ZPjmkbDSas4orL5WDRiLF+weuyfvQP72elTf?=
 =?us-ascii?Q?ql97ioGpZOR/QiCQ5btUTnuunJIZIbuvKufk+0itWr3AeTuLIq301gVQ4UYn?=
 =?us-ascii?Q?Eh3hWcIh0006i3zoI0N+HRZ3OzVy3KDKKZmMsSOBMO9GfkD5SWKYVQfnvSZL?=
 =?us-ascii?Q?d6SNe8zMaMTOTJ4losMmPNVp/6UNL2Z6ji134Zr9V+VTRIQS95oEj5WCe+do?=
 =?us-ascii?Q?h92aA+aJKQOE0OAlImnfg5xmVmYZATdAcGsW3ClUZQ49VeS7v2sYwzGRfgKz?=
 =?us-ascii?Q?sBnTwa8hq5Mv9D0unLcM0abuF4F/NRF9DHlNGMtOfYySMIZWW0xzNBOBpGsh?=
 =?us-ascii?Q?kB6ikB4QP5yiT2HB+CHpWnlPJD2i8W0j2bWkPkn0684TG9QO2Kue1z7rH9+7?=
 =?us-ascii?Q?uSbRqABDP48KAbehOxYPOkPMi5a+DKpmadaSLmGtYpsiAjP3ZXiLC1a7JfMn?=
 =?us-ascii?Q?7hPgATREPBoUL7KsGFYzH2/IeTnMl24/w0RychHGkSFU8+N6ed3TkudH4wgD?=
 =?us-ascii?Q?nqFKy4zP3ug3rfjClFGb1O3KM2VvnxnFiB9360PIDxSGPUykt7U/+TQBIGOi?=
 =?us-ascii?Q?BWNd172H/iDHzeFHBFJBtgeti8kpUQKj++2brSC+69QiMsKR4nJghS6yYG7r?=
 =?us-ascii?Q?MuD5LJn87qdo86VvV/nOJ6D4FJP+l0AepcQRSvRZopma/JxNIjFnc6Rg3xgc?=
 =?us-ascii?Q?g6PgpRBvZa7zJ1O1oPa8K6hg8GYqEs4QxN4oZ0RdWLzHQ4uSbf1L+Ab0NPpA?=
 =?us-ascii?Q?ZTSB2i/PqOCYA6QEbQZtA4lPLx6ZtkAe5QHxc2vL6B5a6jhyblEv7Rsnp85k?=
 =?us-ascii?Q?VQHhuK/nJ5qPoaqSQMAYg/S7cs5YQsQrhVQB0lQh6IwdUg+Q1Sf3iRoF9vi0?=
 =?us-ascii?Q?xVv3lg2CSmY8oLWjQ7fGbGxvLa3Ksh/u+V/PpK41uwrUrqlZw9NSHxMGK8uL?=
 =?us-ascii?Q?FxqNPnrIc5x1vixLwyES4YTJsSENssNyWo83OO1Cd7IirFlXdrNDYzbJqelf?=
 =?us-ascii?Q?CExDnTkGOkZFlx6yfZc5y3RyXEbX1pdY7PUEPUMmHbnWZefyohbhpkgqrftU?=
 =?us-ascii?Q?+5RyqYC4CAbH/SJYJvM+Bbd2hyHt54fWpucer4GTWtAuxpceCU35HfLT9L5k?=
 =?us-ascii?Q?p2PKQfeQnj0VRAbc2qzhkhMUFoQ/SQp4vbA8SXLN3Y1o/QaRQ7FfO9voWr+j?=
 =?us-ascii?Q?81u/LqHncb1kDxINFkewKwFLs8wcUGhZdcNCUJJQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed8f3e2-77c7-4634-f61e-08ddd5006e91
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 15:46:38.9259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPnt89X7FGTj7tURQ5t17ueA//hSu9Il38dcLd6o+I54gWFpUWW9z2PjAkjN9Y7xLmzAKPQ/f2NYWGf/tlUytQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7611

On Wed, Aug 06, 2025 at 06:05:14PM +0300, Laurentiu Palcu wrote:
> Add display controller and LDB support in imx943.
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/imx943.dtsi | 55 ++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx943.dtsi b/arch/arm64/boot/dts/freescale/imx943.dtsi
> index 657c81b6016f2..70dec03c5608e 100644
> --- a/arch/arm64/boot/dts/freescale/imx943.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx943.dtsi
> @@ -148,7 +148,7 @@ l3_cache: l3-cache {
>  		};
>  	};
>
> -	clock-ldb-pll-div7 {
> +	clock_ldb_pll_div7: clock-ldb-pll-div7 {
>  		compatible = "fixed-factor-clock";
>  		#clock-cells = <0>;
>  		clocks = <&scmi_clk IMX94_CLK_LDBPLL>;
> @@ -174,9 +174,62 @@ dispmix_csr: syscon@4b010000 {
>  		lvds_csr: syscon@4b0c0000 {
>  			compatible = "nxp,imx94-lvds-csr", "syscon";
>  			reg = <0x0 0x4b0c0000 0x0 0x10000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
>  			clocks = <&scmi_clk IMX94_CLK_DISPAPB>;
>  			#clock-cells = <1>;
>  			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
> +
> +			ldb: ldb@4 {
> +				compatible = "fsl,imx94-ldb";
> +				reg = <0x4 0x4>, <0x8 0x4>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg-names = "ldb", "lvds";
> +				clocks = <&lvds_csr IMX94_CLK_DISPMIX_LVDS_CLK_GATE>;
> +				clock-names = "ldb";
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +
> +						lvds_in: endpoint {
> +							remote-endpoint = <&dcif_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +					};
> +				};
> +			};
> +		};
> +
> +		dcif: display-controller@4b120000 {
> +			compatible = "nxp,imx94-dcif";
> +			reg = <0x0 0x4b120000 0x0 0x300000>;
> +			interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "common", "bg_layer", "fg_layer";
> +			clocks = <&scmi_clk IMX94_CLK_DISPAPB>,
> +				 <&scmi_clk IMX94_CLK_DISPAXI>,
> +				 <&dispmix_csr IMX94_CLK_DISPMIX_CLK_SEL>;
> +			clock-names = "apb", "axi", "pix";
> +			assigned-clocks = <&dispmix_csr IMX94_CLK_DISPMIX_CLK_SEL>;
> +			assigned-clock-parents = <&clock_ldb_pll_div7>;
> +			power-domains = <&scmi_devpd IMX94_PD_DISPLAY>;
> +			status = "disabled";
> +
> +			port {
> +				dcif_out: endpoint {
> +					remote-endpoint = <&lvds_in>;
> +				};
> +			};
>  		};
>  	};
>  };
> --
> 2.49.0
>

