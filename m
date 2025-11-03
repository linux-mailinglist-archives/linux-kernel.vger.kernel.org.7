Return-Path: <linux-kernel+bounces-883183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5A8C2CD94
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7D1463F30
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A419F3191D2;
	Mon,  3 Nov 2025 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f8f3Z3zg"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528C43191B8;
	Mon,  3 Nov 2025 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182584; cv=fail; b=ltOSU8qzcUAMvzw3cqjJouRBtPt1aGafiM9sILUFqh/xSPuVj2dnff2BB5Z3T3oXd22EC7ekJydaHVa0cp/S+orJetPdk98wv8RGXBai3pxqcYVnd+5s/bzNin9Uv/lGMO6YVH8CmdY6gRX4uqlbQ+LwZVJQGN/w3MHxWPAiHvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182584; c=relaxed/simple;
	bh=+tUZ2+rjMzffcc4POVBJybGqXoM/vyulnPtej7eVGfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JBtTXtl+nEbjjjE000eyLA4hEd5Hfi1hVuy4NjcdEzlvLzuCQzvmJvi1cVwg2hYduQRFlWssF9gvKLTkpJsL4cd+PPaSJKmTZAJuLqN8H0qfCLJ0FcjzsDo08brMAhe485NT2z6cr4PQF6byY9Xu/v8zML/RpMZNxDzDvwI0Hvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f8f3Z3zg; arc=fail smtp.client-ip=52.101.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKuhqqatKHjzHe2aqZP95QDMpfzjWSKHDlyBFoytZmsNHEFkZ4+Q95YBuJ01MbfgTIreBOF59CMtTPOTxrCO8O5Fc9aM71QFLaVUiQkEYN9QX/HscFSGAeL8Z5UFalHC2J5pwxhMxKho9e1ghl6CXBQiDBhm5CN7H2Su1pknJ21YMFl8aXnTCaKGJAnlvOmWWMgm15Uf/5nOIGHABhvAvzLwpP+uPG6bKvnSW5Cm1mukfiVgz9tlEhDvc/82DXtTZpuio/opjQ4dXIX1Zt5LcYgFXp6KnAghsEJzmGgRiVSuqV07NprtWTqzh+5h1/5uDzT/4Z6ZPJjJeYmSwMG/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS/R/fb93uch3ul7nDODOBnlRnx2p7hCCM2A/NGFTYE=;
 b=EvRwb0CEDSCSHy2CBcm0jYW2SDHSn2J/fzXFD3OPu2J58EavSLQa/8KlKDGHwMFQLD3EiXGcOLDBNE7xcFZiigXFXNpJSFoUOvAVfA0TkSpWhnLo2cmZx7IoiO1BsfGRWmUJA/qZchwWzm5FOPz2l/bSDdADJ28rHUh+E+3y3GEWWzxpNdCEiHK6TAn+T407dTcId3vmrISI+uYQWgffvUpyaSgdkWoyKL7mHTuJWoY1d3r8CDqlMRYHSIy3RSMpHFx9w/wQAwENNYA07RTqm6huMbU6PI5X3ocXaqiVlSk4c/9FPacqQGNUqYtKR9FjySrvgzlIKISjge0J47nJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS/R/fb93uch3ul7nDODOBnlRnx2p7hCCM2A/NGFTYE=;
 b=f8f3Z3zgy4SYEqIJZefS+m+MRN6ujTwEXGH+ric16/wTiV1nmoIAcEf8PQdDegXvTVoK2dQ3UOMlLfMosCEtZJH3OoloM8jVz6oH0UJ2cjdAdk7yKCZGEyvuqBxSGlHmC1ufXGRuOSMN0+dot7RsCo8wquQ+q1/mirvZ9XLpJAsWdSitfGtLZS2OF8G4Xnd0GIbejaTXX7ipX90i97UxXJ6hOvyB4cttMtwlANHJooRFZpQ6Fa+Q43RYHLZmavL/+xPi44uBtmW3QUlUWFx8wR+YabCv6w7/tzUjni84cCeMVc2ByPeeCAahNqh02VHh8RH604XWt03ltNds5+bLBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM7PR04MB6901.eurprd04.prod.outlook.com (2603:10a6:20b:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:09:38 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:09:35 +0000
Date: Mon, 3 Nov 2025 10:09:25 -0500
From: Frank Li <Frank.li@nxp.com>
To: John Ernberg <john.ernberg@actia.se>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/12] arm64: dts: imx8qxp: add readonly for ocotp
Message-ID: <aQjFpSCHrrt2JG2n@lizhi-Precision-Tower-5810>
References: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
 <20251029-8qxp_dts-v1-2-cf61b7e5fc78@nxp.com>
 <aQiQiIaVH3TTVLHV@w447anl.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQiQiIaVH3TTVLHV@w447anl.localdomain>
X-ClientProxiedBy: PH8P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::30) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM7PR04MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d70644-8da4-498e-48e1-08de1aeaff7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H1AFyJwOK1IQFDpwMtV2B8K6lBUP1agYK+UXcxFDv6NG81K0AZlM+Mtxa9sw?=
 =?us-ascii?Q?Jeo4/V2CWSEk59gjNnmGGuWEgJYE1IOor8FqyzekBCKigBIhhdTrutuKgQXX?=
 =?us-ascii?Q?KupwYy0wmH/N477+ITlRy65VUm7EFWEGelg0qdiUx8YHFB9GkloQ4rtG2Dnp?=
 =?us-ascii?Q?P8uhCTtaq2QiJ99fEn2nk1Vgk1YYgsV+5iVZLDUkK4ZfCqO1wBvqD/u9CZDA?=
 =?us-ascii?Q?fwa/wyoHJesaC0RjRn9Io+EM66lPYKxIo/aQ1vu0t/PKwj7P8VyQyAD27AUR?=
 =?us-ascii?Q?+a0smU2ZgiATIVvdcXgCFdKy0Ji1kuBf1LHBsuFpPOExbvlizal1mVBadC0l?=
 =?us-ascii?Q?crlcun/1ifOpeQeC0m+p9yLVqladI9YGTAIzENWfCzrgD8/dvJcQ1DrikISA?=
 =?us-ascii?Q?bMfuM29VYemHZT8/eg8ikt2tDX21iFWUG+VVLRqPCVTlqNdqniU/UxsRt/f1?=
 =?us-ascii?Q?DKrbd3mlVov4S8WXMpAYY6qY56TK4N3yzNjjbTSGE4hafjsuL1wouPnvGG06?=
 =?us-ascii?Q?wQWfttrnEcQMEpe+Cv63QkdKGKPeU9EQXULAO6ObsV1J7odZQjxBW/Som5Zw?=
 =?us-ascii?Q?HT+RUnamN3tgmTNvkl7rKhrmQOmzbBVympGhAYtNe6v6/13sONKMotyYDcfe?=
 =?us-ascii?Q?sURHcwMyXqSomxJfg7WDnP/tDKZ9NyEiMaznZ7qg4Uw/AIF68Agqival63wL?=
 =?us-ascii?Q?RLXuyrk0oZY6XP3Mam9WjoytbXIUVJkjYb6aLIa9ukRsUz8eFw/ND61CUsH4?=
 =?us-ascii?Q?ubS+wm1bsx0F+fEqlQtLwkTFp0vObUfPJ1fk+vPoJcdte03tG/wZJMTQFKtx?=
 =?us-ascii?Q?hnVrljTqn73592dsM8FZWHEdp5pnIx+9ME3dglmsNp/3K/danWuz3gSUNS2k?=
 =?us-ascii?Q?DDdkbkGMQ9faft51tip9pU/jJn2Hab4xCwN0e92iD9/xPKQ6508Wgl3LrjmG?=
 =?us-ascii?Q?l+5rhIdeQ4aKA80iCrKh+yDHarhafT+T3CaPCrOx9T1mWe6/Y/ExQga//F/q?=
 =?us-ascii?Q?y1c84+I9Tryq0i9WRBI0Jv6UPTiJyUQ86JrMuUnVax7K/dwCWHmz1io0RRfC?=
 =?us-ascii?Q?k5XIjT+hNpN0JAcPwVrE3xj1Oj5YHPsZN7hF3Aj2DrQM6Hy6R8IWHGBowG88?=
 =?us-ascii?Q?jZjz9Hy6pkTzQQZR07zWl7W7yzvj+hmxxcej3d+zoGf19sg72otgWv7POSqE?=
 =?us-ascii?Q?ChBrRjfQnATSIj7WZ5jMWXGgHAFfiR3QlEbAWHS7/gomIZvYlK616YhsjlTd?=
 =?us-ascii?Q?xioLV0WOXRB2LBD3BMG0cjXX+GQYvz6vxwIP42uBtVY10qG9mu7kQrgyOpfj?=
 =?us-ascii?Q?rYHWfhQuhmKjEKyjHDlNJ7IT/ZbLnY9FG3crD1HM4vZjOXRJxE9nn/mQDspi?=
 =?us-ascii?Q?OxiPMxaShs8NHEi9Uo57xeykdSW7fkRCNegF1H+/KwyFQZmtigrnp8b6mGmm?=
 =?us-ascii?Q?6OkbK/JLFdFbQYo1chSwZ34/+TqJp51MOAvaiYvs7AH/+E5fJNa8vRKQD2Uh?=
 =?us-ascii?Q?D4k0WuXKAFpYD8TZyy/6NGqu5ONxiKyVu03d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3fJ/9KhKRfYrIvG37qKgm9fclkq+Bpq5RTT5+T5Hj9hJyfy0ZYUoLSAb/tn2?=
 =?us-ascii?Q?ONY5ZG59e9chSy0TlEK4ervHdySFuIJYBSAsnh+BMQsPatpYeZUN7Nd9NfZ0?=
 =?us-ascii?Q?pMez5PWZE5K+xOJIV+8nkYK1FtcSn4T37lBbok6jdJ+Zan2UOOJi/JsMKXqw?=
 =?us-ascii?Q?MfBoPnSU2aNHVu2ueJY/wWuk2BnMVwoVNImEE161Ux4Bd/reFLfQZR8/LwHu?=
 =?us-ascii?Q?P5uDHbcwZ2omhnltvaiTHyzdX/puqI0bhnCjE37wd+w37CFEAdTUpJMzOa9k?=
 =?us-ascii?Q?yMlwqPe0+DurxhNEDft0miq9yQo4wpdMz37XJy4WsNhOOwjI8MH78zIcU4st?=
 =?us-ascii?Q?ldyaiGuVip5E1Tnww9MoRKfRnRWY2Htaopwqq5TQBZWEI2xrFQGC0GEhqcjA?=
 =?us-ascii?Q?MjHml1EZUKFGixA1e4zLtlorBuHKCag0svl4l7d4uwrwHkqqVuQ0bZQbY1is?=
 =?us-ascii?Q?g92K5yv7VRH93uMhaBpJU06EL0h+4I+pHzeNhgg8m89P4DtMGx3xQPVUY6TF?=
 =?us-ascii?Q?Cca+/QIvFn8rRCa4TQDpWII34JGQ/h9WyEfq5DmGg6OoD/W0QAae7dXkH4Df?=
 =?us-ascii?Q?sfQ8nJHX/cwmQmoI/s00xK4XX4KY8qtc4Hd24nKUX3HTy4lUedS4S6hlbkp0?=
 =?us-ascii?Q?HYmJQgn0gThRMm3KCDRF+mobMdN5TD28Bs6IJYSuHHaNo2f7GVHtpyDCQEtc?=
 =?us-ascii?Q?eWHv9ee4H9vEiFQ0+J/PdhNOUjC1ILgkOfk27NKTMmn9mtDKFVyhErCCfmaL?=
 =?us-ascii?Q?kUTr6YJ+5fl3QFXOiKzkR7jIMwp+214LK0tXmHyZFcRcK8AMUzocbI/LJPih?=
 =?us-ascii?Q?efKdWYCxTSn2Nb9QdFSe+JqA0B5P3rOzi08CjgNad8G0eRo0Mk63sIVBEqDn?=
 =?us-ascii?Q?0cGVb4TgrMe1gQNr9BN392NX4KWA2A5YRhGMugbintSwBR7PNKN4fny7yYNE?=
 =?us-ascii?Q?0FFakyT82vmxJv9uzvAu0B8AjVMjw8VqVd0BqCowXxRVUpWMGAfbQF3Phs4k?=
 =?us-ascii?Q?RSfgIIDeyGl9+C0u247Hy5vOsH8s5uBHXEk1RXq1ReGmWWrlGHpXOjdXCOCl?=
 =?us-ascii?Q?LEyUe6jVT2Ua31a/s/4W7dADbNMGIwmmx1L2pssjoPGOF4VmHS4DAlvEuwAb?=
 =?us-ascii?Q?/PW1EF22BCE/x/7u+Jx8fVMrxtgkojSec5fgkf7KB8eixD+kPPCV4TbUSuoY?=
 =?us-ascii?Q?JgRCT1XujMR9BvtGg1e+sjazIMcEqcRFVd0xAUAD/hPCCjn8DUvqcwrDeg9m?=
 =?us-ascii?Q?TxvnUXl3NeWWtgNBVdQZnITUr3MDmyonAwKyauwLduFQzXTrqVYetOAqRFD+?=
 =?us-ascii?Q?ky/xK/6Sd5Epu2XHDUArI1+FhrvvM1fr4cOabBYdP+W12frsD4/9HGsnSwn5?=
 =?us-ascii?Q?nHcu8tAMtseDB5Wta+98Nx8OlWMVSKGoxPeJC1fCazkvWENrH5hbpwt/GfTS?=
 =?us-ascii?Q?wR6HIi52EMvx5R8blWul9+pMltspWpniTdF86eJcdHUdUb67wpTtS9sMfbf/?=
 =?us-ascii?Q?Ldi8m8q0UnqxbetCvgEbg7IAvU2ejOSTh07zTdlymQ2Btm4BKIyeIz0lmsIf?=
 =?us-ascii?Q?gkxDN03rC8pgECapIes=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d70644-8da4-498e-48e1-08de1aeaff7c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 15:09:35.3787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7SJMRKq1KBFJD3Qg6S5RdzYJfM/Z36Me3qjWm6eXWmYPBMeOI+uEIuWUeApCzPt7iwDEACSsCyuFTJBu+a03Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6901

On Mon, Nov 03, 2025 at 11:22:55AM +0000, John Ernberg wrote:
> Hi Frank,
>
> On Wed, Oct 29, 2025 at 03:54:38PM -0400, Frank Li wrote:
> > Add readonly for ocotp because i.MX8QXP only support program fuse by scu.
>
> This is not true? The driver supports writing the fuses via the SCFW API,
> and we are using this way to populate the MAC fuses.

Yes!

Shanw:
	You can skip this patch. If need respin, I will drop it.

Frank
>
> Best regards // John Ernberg
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > index def6de8d579d40919e4bf7f88e119611ae4cb69a..cc82cc319159c2558400fa641570cddd3ad3083d 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > @@ -234,6 +234,7 @@ ocotp: ocotp {
> >  			compatible = "fsl,imx8qxp-scu-ocotp";
> >  			#address-cells = <1>;
> >  			#size-cells = <1>;
> > +			read-only;
> >
> >  			fec_mac0: mac@2c4 {
> >  				reg = <0x2c4 6>;
> >
> > --
> > 2.34.1
> >

