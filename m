Return-Path: <linux-kernel+bounces-729511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DB7B037B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44B13A352C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5236233155;
	Mon, 14 Jul 2025 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=technexion.onmicrosoft.com header.i=@technexion.onmicrosoft.com header.b="2fAW3blX"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022081.outbound.protection.outlook.com [40.107.75.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A3155C82;
	Mon, 14 Jul 2025 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477493; cv=fail; b=dB67T0SyWlwhIsGdw9eR0IOkRO3XYJSCcHA5iPqtzenOaPrR6Eq/Q1SDmRcyf8VRdbt1eRBxK52zG1Cfsuc44W6xNCQu/AnAbS6L1d+qtpepUjNmlrSl1Y95ci5cJLlmKL27m6XlIZ7TKUoKYd1NL2NwbLbPmSm1Qg1UgL4QzBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477493; c=relaxed/simple;
	bh=+v2I2W6BDs5Yt1HXoStYgQWk3jD3pBjPhtDRRudLU6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ga41QXcELTDjRqCia1zKp9D09MSeY7aJk/tVLMu0QLVN8SnY97fwP4ordV2XeIy3wRqONjDsY9NgaFXfUtINunschWlYbmKI43Xdpa3VMXTlEawwL22AtTeGNG8GGGzQT4qw1C6gPxYr/Ouz06EwN3MfZzU8eY9Mkc6ze8WaF7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=technexion.com; spf=pass smtp.mailfrom=technexion.com; dkim=pass (1024-bit key) header.d=technexion.onmicrosoft.com header.i=@technexion.onmicrosoft.com header.b=2fAW3blX; arc=fail smtp.client-ip=40.107.75.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=technexion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=technexion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrlT+uCMXBeRir3gR2WYE3w330yrzI888f8LZmNz9yGrecoTyF6ujhi9i8mJXZGLgzHXT2qRPB2RL+EidnRgZGgChNN3ytmhFpqX6j6fk0iWxVqjRNVlr8QNcf9k2iC9NO+oSX9lA7CFv6e7rhEgd05u5aGxOv4AP3yHFe27+dcNfVYqf4q39/a3UEQfnKHQg3bB16RZTpvANFwXZuS0m5/OijRqNH7TSssEyKr0yVMAZ7VcP7gVXFiMEkX7nQ/yAenOMl/62ytIfvv8txsBczLZR8lLdHaT6D2btQ+Zy04hOs0GcBq1dkzaL1msaaQ3mAJtfeu155JT9RNqXK8BsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30EL6wxzSs//PEaPQj8tpMERf1htR7z8kJqF8TynsjM=;
 b=rpluB+Cu76EHdExgqXJslKaO01Xz7PQvoKCL2N/mFylLB+7BEOklkIQ8zWIy82TRkOu68njFFPyn2inikkgDJ60PyeQ0mtGEVfblFgLYeaN4ZR5rE3pbJht58sBWS3W/LGIrFZjth917npkBgVZ9MDf3M5BJdBa6AMC5GhCSzJ1a4fPEr8EN/4ih0827w1U/SqN5QPhZoLKoIV9SgEj6iN9vmxqFJDC+K5R6RmkQqzqHoKubK8z/Pn+RneM52wo48r7NUzl93x9yliNT45v6HeTEYG98erxcVSWIkjgHMwo62X/IXBHdecEgP0qnWdry2JqoEH+IRoaUcQwkagIP1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technexion.com; dmarc=pass action=none
 header.from=technexion.com; dkim=pass header.d=technexion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technexion.onmicrosoft.com; s=selector2-technexion-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30EL6wxzSs//PEaPQj8tpMERf1htR7z8kJqF8TynsjM=;
 b=2fAW3blXWMLdCVjJ0A+ZtMNApeRQ+NViseyJKzT2vjZVk+ydSCHECzF7i8s/ouj49ev0j2XOANrhn4Sbnwb6QwX6D9S3V9zwkFwG7GF+mHvE5Sjk02bJ5m+Foe94A/8PHulves4H7NJTDsmJMJS71epL0S5VgrksRf21Jmf9S24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=technexion.com;
Received: from KL1PR03MB7454.apcprd03.prod.outlook.com (2603:1096:820:ed::7)
 by SEYPR03MB7142.apcprd03.prod.outlook.com (2603:1096:101:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Mon, 14 Jul
 2025 07:18:03 +0000
Received: from KL1PR03MB7454.apcprd03.prod.outlook.com
 ([fe80::5ac3:4497:4694:db94]) by KL1PR03MB7454.apcprd03.prod.outlook.com
 ([fe80::5ac3:4497:4694:db94%6]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 07:18:03 +0000
Date: Mon, 14 Jul 2025 15:17:58 +0800
From: Richard Hu <richard.hu@technexion.com>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Ray Chang <ray.chang@technexion.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: imx8mp: Add TechNexion
 EDM-G-IMX8M-PLUS SOM on WB-EDM-G carrier board
Message-ID: <aHSvJv6zbndPx72h@vm>
References: <20250709-add-technexion-edm-g-imx8m-plus-som-v3-0-721d198ce20b@technexion.com>
 <20250709-add-technexion-edm-g-imx8m-plus-som-v3-2-721d198ce20b@technexion.com>
 <aHDJJNVOsX7K-m4d@dragon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHDJJNVOsX7K-m4d@dragon>
X-ClientProxiedBy: TPYP295CA0052.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::18) To KL1PR03MB7454.apcprd03.prod.outlook.com
 (2603:1096:820:ed::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7454:EE_|SEYPR03MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f803ea-ee19-4ce9-6656-08ddc2a691f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sYH3Ix0kywfKI2KyaDMeGq78stQz3e0qOLgKwZ58oSyp5xSWsgZsy4wu21Uo?=
 =?us-ascii?Q?TtiX/YJWPzQhKKzJ08WGF91fpMLZFp7G5Lv/5jBSzNxw04irCJm1+1sy5o/m?=
 =?us-ascii?Q?EL+c9yjKgURIWUQXyDsTsersFq2eboDH/7I4ITBM4k/nacWCvimG2hJN7dgb?=
 =?us-ascii?Q?GeaTxi0BVfFTrfm3ttBLTPHjCjoZs2IXxUk6WX1HYcF36R6SKWX0x7zfFk7P?=
 =?us-ascii?Q?Jc2Elnw0Qku8H84AwQG+V70SbDlm4bcS/qvzh+aCTysd9T2AafSdt71Gf/9F?=
 =?us-ascii?Q?odNozYUMlDFc/z6SHfBJyegpTwNpiHZdEJObvwQ1Diqoo3E77uQlyj8xyiyt?=
 =?us-ascii?Q?rx+MGI76vOm6wGMr2Zab36/jlMbu+T2+PmeAgDdN7io3D/gwLnr6OfPTKd07?=
 =?us-ascii?Q?FNdnMke/HUA1boOJjuXBPzuYe8z/9CHqlT9qhHBHis4Yw8kTwzmvBslg4sGo?=
 =?us-ascii?Q?52qh+csQQMKkm0tCH7nS6pxmxltE3+FDp4aWgHzXdDzfs5oBKWokp26NOo2K?=
 =?us-ascii?Q?E0hl+efOC0F7ERMqh9M4drDl6KCmQwHUQL82tAELi+TJlJVmkdkZmFplciq+?=
 =?us-ascii?Q?zonb12gKPc2lVfMFnxQkWmZTpCd82mXi/XMcsCZz4yzXqCSwIgbZ6A0CnV+X?=
 =?us-ascii?Q?ewX00FHivZPAjgYDgwiE8R2d/C0HyVrKwGDKM82a5Qv3pBUww/1B/HrWUml/?=
 =?us-ascii?Q?YDnO76A6Bd6MS+T9yyGwftG1UEIwqQx4NXvfhWzKYxyd7f6dFqmM/XnPUjQm?=
 =?us-ascii?Q?ZRcGrcSA47CYWJQJZm0PSNOXhAuHTF36iB0vHNnTGxC2kIGdfBiwoMopEKNw?=
 =?us-ascii?Q?NjlrZYuedoJJDKvivJgeXrd3vZIGd2izdqPjRLQj5/jrvtW+iPSV06E/kQEl?=
 =?us-ascii?Q?wd22TFJMa6j2xRImDTjv3BZr1AwvDGp1QD9MjARPfOhrpwyQOTtH0GkaX7To?=
 =?us-ascii?Q?nrwe99kTvEFAkXaEZtI3c3BuMYstPCPQnF9jsUkS/rGoCB+ofjft8Tx1otM2?=
 =?us-ascii?Q?buploU0GOHHFnJZlFFACSj8CHu/3mp+lushv5Bh08kN+rKRCfNqpq75SAoeu?=
 =?us-ascii?Q?tnwiiU75aLm8F3Y3rP+moqqGSe7POpZ863M0825dRyMnf6x/jGICIkIaYUPP?=
 =?us-ascii?Q?RQ7KsX9ouFp/ucJCQ/LSn2WzirlJRzEpxrcOV/MkU8jiPih8UEiReZP+0kNK?=
 =?us-ascii?Q?1KPegYxuSVNRaHrbkk/aO3ZvLptoWQ7fdQhsie9KgyTwJwodsUJbgUvG3W6q?=
 =?us-ascii?Q?ctlPUZTIGWLTDVPcJfcgrs18UtmD+ApAGTHjNJHZWqneHo1K14hmqpbWRo+n?=
 =?us-ascii?Q?yD9nMmidGyxEK2DCPXhEV4N9aqri4ozVz3Jhw6OLu/XJp5vY0W0NnSl31qkL?=
 =?us-ascii?Q?tna0oiNzq/yDP/IFOt3ZrpHgi18ouckMdB8mmsi/31iSm6KTJNqO45t2qa5s?=
 =?us-ascii?Q?w2rbe4TEMdXJqEwzQ0ZmQt7ltK/rYURNZKuPf8nfcLmehQkDEY+yBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7454.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LOu9Bna+Pe43/9GLSY+45PbCRvF8exeAQ+BFd96jAH3oQ+mBO9YKwq/1c8ng?=
 =?us-ascii?Q?nAxIfNE2bfkQT/TTfCoO7+UmwlTY7r479TCRhpIwWNM+V45V4N1BA7g6KkS3?=
 =?us-ascii?Q?kZJgTMxGBrQeXXgU7alQ/h7m5+aVZUrQ5uAV4AcJP/c7C9vULmQ6GgDPHolF?=
 =?us-ascii?Q?A9glYuTRZaUbsfp83ZqRiyGMe3XkPCu+k43w18hvPP1SF0wBB13q9/2LfHbJ?=
 =?us-ascii?Q?uq3jlh24mfnEGr4Rf54Sqa2BwazknxbB2E5hIHx0/9neMT18sB/ITqHk3x+1?=
 =?us-ascii?Q?LIMpLhBP08KUt+6xX8LkuKRZwSwcvoh+sXrK+CFeXRRhpUd43+ug5LWRsZ3m?=
 =?us-ascii?Q?+tXCGCmuzvuGwqgcZBnBQT/0YQZNFi79S5VNRSKrvPNBau6HMWDJPKMkYb+s?=
 =?us-ascii?Q?1J4GqTfhNI55ipn6S6iLsLw2dWikzSmJQRwL9KATf+q5YwYjlUDmldD8Y6So?=
 =?us-ascii?Q?oooDP+1Sqv+HvGHnmQhyRzG+UmX+JkgjLr8iqZAY1B1aBPFApaU1vwo7eUs9?=
 =?us-ascii?Q?+2Shp2FE3dXkW7K1G7CjlVPYvs4o/b77Gy9up6hvKu/xKNZH3oTwMc5bUFHQ?=
 =?us-ascii?Q?5uGAmBSL3KYL/Jcje0hfD9YYuMoLhuNFEtY07KfKYl86Dm0uEIrl+b3SaNfp?=
 =?us-ascii?Q?czE/mlgwhzkLqMC6Wh/d8rampvxHxTnvbTZQ6aSCI9WBT+N/magL3g3ay1TM?=
 =?us-ascii?Q?wZrRfw5QdXvYr058MHL/tpCd2eQwhEIHr4ok5c/NjrfggWsy3BxNT23XcczG?=
 =?us-ascii?Q?A/gCYBqWyJMa7yZD8TKetILqNVPwHhSxRCylcnxnfAePHU70btqhOhJDfi2e?=
 =?us-ascii?Q?d8vRQBUDV4ueDuzhQVu2NAW0xW0f0cUAbNj5zNczRSWgyxegwz0NXTu8H06Y?=
 =?us-ascii?Q?n8hK851KchSFlJsN3mYkVJbNCYRGYSiXrz0YrC8BdHezwej+kj5xGL8qEoOR?=
 =?us-ascii?Q?MggAPOJ9YDnUFVa1eC/Puz/YaNxcgZ2wbrrDvgqWn51kWodY9jg1ChuyvceR?=
 =?us-ascii?Q?nOMmW+e1aUYaWKK6h9LI4QNiqBrIh2lftv6XB+APjNXT/kdbX2WvnKi/Tk0U?=
 =?us-ascii?Q?++s8JuX3YkJcA4Bx2NfrnJMPGzRSm+lbEfuxKE2AezbH3CiW/VhXEGWCFWBS?=
 =?us-ascii?Q?NDFJ9tXFgfx3dwmRUZosBgxCVGkgwvtzUpnlq0EeP1o8CKAXBHSOWigJRVwn?=
 =?us-ascii?Q?v4Eim9ilQVcLaZPyIWJdjHWW/40XOZb0ndyc1jGU+5DFDMh+HzzFo6RAtjmF?=
 =?us-ascii?Q?eYIZxGDFZ++R6Gfcy9pnI+i1Ay8jZw9eejoiHs9mBDZeVU3/D2xtuFoMM3ik?=
 =?us-ascii?Q?ldcJCZwIr7a+CQp1Kp+Mup+q2mewXZEm5z/xMZvYzXogfonuj1giiGilxxZm?=
 =?us-ascii?Q?vpFTjC6XYtlJViYO3lSuBp+E8WY7BefDpICWQy49etKMbaBzf1pQhHu0tAer?=
 =?us-ascii?Q?S8OQ2X5bNNhbMU4+Haavt8Vm1MLoWarLdYE6VZ9w76YxMVjqFmgwaE1YaByi?=
 =?us-ascii?Q?yFmSgJ3eyew6frSkML5DiS1qX+jGyGQvtNrNvlBDoqFFs9anjghbnmYg2IvE?=
 =?us-ascii?Q?kP2rpMrPivjiUMEWiEM0QgPs9zrdGEHhMSHyS7HtvaEiwUwve0IMXibOGEGG?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: technexion.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f803ea-ee19-4ce9-6656-08ddc2a691f8
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7454.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 07:18:03.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5ee19679-b9a6-4497-8ed2-1eda849e753b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ju7v8ucH0FzOxR+FoPhRQI3Cl0AxH+JGJIlGyWaANl92hKwRCR4h1ZRb7Ugx28AGiLEcT85HaWhutPNopb38FV39C5Ijjgke+NecMeYTKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7142

On Fri, Jul 11, 2025 at 04:19:48PM +0800, Shawn Guo wrote:
> On Wed, Jul 09, 2025 at 01:47:45PM +0800, Richard Hu wrote:
> > Add support for TechNexion EDM-G-IMX8M-PLUS SOM and WB-EDM-G carrier board.
> > Key interfaces include:
> > - Gigabit Ethernet
> > - USB 3.0
> > - I2S, UART, SPI, I2C, PWM, GPIO
> > 
> > Signed-off-by: Richard Hu <richard.hu@technexion.com>
> > Signed-off-by: Ray Chang <ray.chang@technexion.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile            |   1 +
> >  arch/arm64/boot/dts/freescale/imx8mp-edm-g-wb.dts | 373 ++++++++++
> >  arch/arm64/boot/dts/freescale/imx8mp-edm-g.dtsi   | 806 ++++++++++++++++++++++
> >  3 files changed, 1180 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > index 0b473a23d120..b56c866d4a9d 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -201,6 +201,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-drc02.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk2.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-pdk3.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-dhcom-picoitx.dtb
> > +dtb-$(CONFIG_ARCH_MXC) += imx8mp-edm-g-wb.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-icore-mx8mp-edimm2.2.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-iota2-lumpy.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-edm-g-wb.dts b/arch/arm64/boot/dts/freescale/imx8mp-edm-g-wb.dts
> > new file mode 100644
> > index 000000000000..0e5c7bf219b0
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-edm-g-wb.dts
> > @@ -0,0 +1,373 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2024 TechNexion Ltd.
> > + *
> > + * Author: Ray Chang <ray.chang@technexion.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "imx8mp-edm-g.dtsi"
> > +
> > +/ {
> > +	compatible = "technexion,edm-g-imx8mp-wb", "technexion,edm-g-imx8mp", "fsl,imx8mp";
> > +	model = "TechNexion EDM-G-IMX8MP SOM on WB-EDM-G";
> > +
> > +	connector {
> > +		compatible = "usb-c-connector";
> > +		data-role = "dual";
> > +		label = "USB-C";
> > +
> > +		ports {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			port@0 {
> > +				reg = <0>;
> 
> Have a newline between properties and child node.

Thanks for pointing this out. You're right, I'll add the newline to fix this.

> > +				hs_ep: endpoint {
> > +					remote-endpoint = <&usb3_hs_ep>;
> > +				};
> > +			};
> > +
> > +			port@1 {
> > +				reg = <1>;
> > +				ss_ep: endpoint {
> > +					remote-endpoint = <&hd3ss3220_in_ep>;
> > +				};
> > +			};
> > +		};
> > +	};
> > +
> > +	gpio-leds {
> > +		compatible = "gpio-leds";
> > +
> > +		led {
> > +			default-state = "on";
> > +			gpios = <&expander2 1 GPIO_ACTIVE_HIGH>;
> > +			label = "gpio-led";
> > +		};
> > +	};
> > +
> > +	lvds_backlight: lvds-backlight {
> > +		compatible = "pwm-backlight";
> > +		brightness-levels = <0 36 72 108 144 180 216 255>;
> > +		default-brightness-level = <6>;
> > +		pwms = <&pwm2 0 50000 0>;
> > +		status = "disabled";
> 
> Just out of curiosity, why is it disabled?

That's a good question. We disabled the backlight because the LVDS panel is an optional accessory.
We were planning to enable this lvds_backlight node in the overlay,
but would you recommend we move the node definition itself entirely into the overlay file?
We're happy to follow the best practice here.

> > +	};
> > +
> > +	native-hdmi-connector {
> > +		compatible = "hdmi-connector";
> > +		label = "HDMI OUT";
> > +		type = "a";
> > +
> > +		port {
> > +			hdmi_in: endpoint {
> > +				remote-endpoint = <&hdmi_tx_out>;
> > +			};
> > +		};
> > +	};
> > +
> > +	pcie0_refclk: pcie0-refclk {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <100000000>;
> > +	};
> > +
> > +	reg_pcie0: regulator-pcie {
> > +		compatible = "regulator-fixed";
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-name = "PCIE_CLKREQ_N";
> > +		gpio = <&gpio1 13 GPIO_ACTIVE_LOW>;
> > +	};
> > +
> > +	reg_pwr_3v3: regulator-pwr-3v3 {
> > +		compatible = "regulator-fixed";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-max-microvolt = <3300000>;
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-name = "pwr-3v3";
> > +	};
> > +
> > +	reg_pwr_5v: regulator-pwr-5v {
> > +		compatible = "regulator-fixed";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-max-microvolt = <5000000>;
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-name = "pwr-5v";
> > +	};
> > +
> > +	sound-hdmi {
> > +		compatible = "fsl,imx-audio-hdmi";
> > +		audio-cpu = <&aud2htx>;
> > +		hdmi-out;
> > +		model = "audio-hdmi";
> > +	};
> > +
> > +	sound-wm8960 {
> > +		compatible = "simple-audio-card";
> > +		simple-audio-card,bitclock-master = <&cpudai>;
> > +		simple-audio-card,format = "i2s";
> > +		simple-audio-card,frame-master = <&cpudai>;
> > +		simple-audio-card,name = "wm8960-audio";
> > +		simple-audio-card,routing = "Headphone Jack", "HP_L",
> > +			"Headphone Jack", "HP_R",
> > +			"External Speaker", "SPK_LP",
> > +			"External Speaker", "SPK_LN",
> > +			"External Speaker", "SPK_RP",
> > +			"External Speaker", "SPK_RN",
> > +			"LINPUT1", "Mic Jack",
> > +			"RINPUT1", "Mic Jack",
> > +			"Mic Jack", "MICB";
> > +		simple-audio-card,widgets = "Headphone", "Headphone Jack",
> > +			"Speaker", "External Speaker",
> > +			"Microphone", "Mic Jack";
> > +
> > +		simple-audio-card,codec {
> > +			sound-dai = <&wm8960>;
> > +		};
> > +
> > +		cpudai: simple-audio-card,cpu {
> > +			sound-dai = <&sai3>;
> > +		};
> > +	};
> > +};
> > +
> > +&aud2htx {
> > +	status = "okay";
> > +};
> > +
> > +&flexcan1 {
> > +	status = "okay";
> > +};
> > +
> > +&gpio1 {
> > +	gpio-line-names = \
> 
> Hmm, not sure "\" is necessary.

You're right, it's not needed. I'll remove the unnecessary backslashes from the gpio-line-names properties.

> > +		"", "", "", "", "", "", "DSI_RST", "",	\
> > +		"", "", "", "", "", "", "", "",	\
> > +		"", "", "", "", "", "", "", "",	\
> > +		"", "", "", "", "", "", "", "";
> > +	pinctrl-0 = <&pinctrl_gpio1>;
> > +};
> > +
> > +&gpio4 {
> > +	gpio-line-names = \
> > +		"", "", "", "", "", "", "GPIO_P249", "GPIO_P251",	\
> > +		"", "GPIO_P255", "", "", "", "", "", "",	\
> > +		"DSI_BL_EN", "DSI_VDDEN", "", "", "", "", "", "",	\
> > +		"", "", "", "", "", "", "", "";
> > +	pinctrl-0 = <&pinctrl_gpio4>;
> > +};
> > +
> > +&hdmi_pvi {
> > +	status = "okay";
> > +};
> > +
> > +&hdmi_tx {
> > +	pinctrl-0 = <&pinctrl_hdmi>;
> > +	pinctrl-names = "default";
> > +	status = "okay";
> > +
> > +	ports {
> > +		port@1 {
> > +			hdmi_tx_out: endpoint {
> > +				remote-endpoint = <&hdmi_in>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&hdmi_tx_phy {
> > +	status = "okay";
> > +};
> > +
> > +&i2c2 {
> > +	status = "okay";
> > +
> > +	wm8960: codec@1a {
> 
> audio-codec for the node name.

Got it. I will rename the node from codec@1a to audio-codec@1a to follow the standard convention.

> > +		compatible = "wlf,wm8960";
> > +		reg = <0x1a>;
> > +		clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_SAI3_MCLK1>;
> > +		clock-names = "mclk";
> > +		#sound-dai-cells = <0>;
> > +		AVDD-supply = <&reg_pwr_3v3>;
> > +		DBVDD-supply = <&reg_pwr_3v3>;
> > +		DCVDD-supply = <&reg_pwr_3v3>;
> > +		SPKVDD1-supply = <&reg_pwr_5v>;
> > +		SPKVDD2-supply = <&reg_pwr_5v>;
> > +		wlf,hp-cfg = <2 2 3>;
> > +		wlf,shared-lrclk;
> > +	};
> > +
> > +	expander1: gpio@21 {
> > +		compatible = "nxp,pca9555";
> > +		reg = <0x21>;
> > +		#gpio-cells = <2>;
> > +		gpio-controller;
> > +		gpio-line-names = "EXPOSURE_TRIG_IN1", "FLASH_OUT1",
> > +				  "INFO_TRIG_IN1", "CAM_SHUTTER1", "XVS1",
> > +				  "PWR1_TIME0", "PWR1_TIME1", "PWR1_TIME2",
> > +				  "EXPOSURE_TRIG_IN2", "FLASH_OUT2",
> > +				  "INFO_TRIG_IN2", "CAM_SHUTTER2", "XVS2",
> > +				  "PWR2_TIME0", "PWR2_TIME1", "PWR2_TIME2";
> > +	};
> > +
> > +	expander2: gpio@23 {
> > +		compatible = "nxp,pca9555";
> > +		reg = <0x23>;
> > +		#interrupt-cells = <2>;
> > +		interrupt-controller;
> > +		interrupt-parent = <&gpio4>;
> > +		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> > +		#gpio-cells = <2>;
> > +		gpio-controller;
> > +		gpio-line-names = "M2_DISABLE_N", "LED_EN", "", "",
> > +				  "", "", "", "USB_OTG_OC",
> > +				  "EXT_GPIO8", "EXT_GPIO9", "", "",
> > +				  "", "CSI1_PDB", "CSI2_PDB", "PD_FAULT";
> > +		pinctrl-0 = <&pinctrl_expander2_irq>;
> > +		pinctrl-names = "default";
> > +	};
> > +
> > +	usb_typec: usb-typec@67 {
> > +		compatible = "ti,hd3ss3220";
> > +		reg = <0x67>;
> > +		interrupt-parent = <&gpio4>;
> > +		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> > +		pinctrl-0 = <&pinctrl_hd3ss3220_irq>;
> > +		pinctrl-names = "default";
> > +
> > +		ports {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			port@0 {
> > +				reg = <0>;
> 
> Have a newline between properties and child node.

Okay, I'll add a newline for better readability as suggested.

> Shawn


Thank you!


Best regards

Richard

