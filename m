Return-Path: <linux-kernel+bounces-880787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5A1C268EE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254F33B164D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0182623D28B;
	Fri, 31 Oct 2025 18:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dqkhfJLc"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D929D2C0F63;
	Fri, 31 Oct 2025 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935276; cv=fail; b=PmUk4eLP5UzmDPJBCiW7JQjJPthkyP7cJaFu0f2+kJe1EN2iAAhmlPYirJPGRSxAJD4EMCsuoxL6hN+eUY9VFwpUWRnk7xQNWumaGAE6msZ4s03lZ4kbxJY819mEuOzedvFWeadsY6SGXKbyS5T5quPdxlcRK2XwBMhCTwT636s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935276; c=relaxed/simple;
	bh=mv4rZ5SEdTsvW08VNr5saAr17eizhfQ7zrnUhjBKues=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GDkdIcCkOTSP/dGMxDR2XtajjVyANjVAouKTLuV7ol9PCcGyO5FYgMDdicqMNeRegWEkntdMdyKG5g8l0qf3gqIuaU3FJz3XVzeREJkg2mEa26TdT10azKyVlTS+NL7MjRSi4vSIiXz7ium7qBTn/rRyQG6LExu/Cf15gY6BRng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dqkhfJLc; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mwdxv892Hk9kG5TPFTpsi/MPH8pTdcHB0IM99Ds5HjeTHsP144K/reQgrzTNKwLQSaF+ZfTmfVCpossS45f1q82jOIeKh6Ye1GZJxlckqD8TgzJ2hVPhw342hPddgzx3zYX+VMTklONW5Z2boc6lORvJ8172uT5jVW3BI5TagQpPIVynoha46jbmtnMfLnlYCxE8Qwf1Uae+9nx7Xfrtx7t+B8fKxY7ykvWuqX3QEpulBHZ7qOgpmn61qApW7dcUFSuZ9QeZ3q7c/bQCEY5WzmEEVeI0dwUwdYmnfzghyCrPESMx5zSO57ZxAaXHj75/60B4vHTfea7tdXHjmR3riw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjEOCZC8LIxlkGBHt4qQDPI0/IrWFo0VkiysBNXdOD8=;
 b=DkBpXjPpR8Ff63ujxhwMlGayMNAE4803NzpLT+WI4lSsV6Y2eEBGlpCnSET0np7mVDsBfEX/J+WAeManOIPSkgYEIdgPOKw5I3NDSvQEvl2iD6ldhUJANfRsvbBY2FjQmPPyNYV1WIJZtBa7Wu7MXEjFStaQObImZacwISKe/HVJGv7DWYZH6H7L1dvcWslEnXiXG66ufgW6EQV1j1aIZ704lwlQ2HqGeZZWz3yJh/wiYAXr4xljwefUrjIGDOa6ZCzSPsEcnfvUI05JvMimc6jqBbTTQE51u2TCgFaFF3qyY262rlbUgcF1+96KfFTu5IdAslRMv264Hw6Ebe4w5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjEOCZC8LIxlkGBHt4qQDPI0/IrWFo0VkiysBNXdOD8=;
 b=dqkhfJLcPwet1AlaFsIBqRXp5YI+xvul5jcF4Y+Sugh4BgCNkzVjPwVHLKCANUV8qrcp/16z7pI33W8/aY5KzGVeaPoSgQ79WadcMz1J5cSlXKcD5F3WKzYFwSRLtYYlq9A+lxG5sekQN/1JYdaqy+WbPmxkIom+Y37WOWAX1I+D+0tOaH2r5sAACEaYhu4MnlvyzXFJNAbB9BijaNo6Er4C4OnwP2IJCtgsCnjVJAbs38Q3SPYIUEdWflxGk0dwZ0M7X32on81bGEVnpYNjxVb2iHChe5iQKdkpHACgMGKYQgU4tC6e4FLoR+udUGifX3rYX+AdoO2hgPUneV8YnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV1PR04MB10536.eurprd04.prod.outlook.com (2603:10a6:150:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 18:27:50 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Fri, 31 Oct 2025
 18:27:50 +0000
Date: Fri, 31 Oct 2025 14:27:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: max.oss.09@gmail.com
Cc: Max Krummenacher <max.krummenacher@toradex.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] arm64: dts: colibri-imx8x: Add wi-fi 32kHz clock
Message-ID: <aQT/nj7Up76QZZQ/@lizhi-Precision-Tower-5810>
References: <20251031125003.275033-1-max.oss.09@gmail.com>
 <20251031125003.275033-3-max.oss.09@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031125003.275033-3-max.oss.09@gmail.com>
X-ClientProxiedBy: PH7P220CA0049.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::16) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV1PR04MB10536:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d5bd79-2a26-4333-e9a3-08de18ab32cf
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?BtKJ11MDk06CamzvqYAA7wKUROu1c+YwhclRRvI8z77lPJK1Zh0uGYBGKWVP?=
 =?us-ascii?Q?N+33Q4EI1Zv+LVEdwr8j5pHuC6NPhTob+/xuJGkrOP8b/t5xfwtOOL862FVu?=
 =?us-ascii?Q?eElx00fKy/g6V5Dz0USVSyK2dcYyZD05CpZC7v19Anv99vrE6IUwbbJmhgeS?=
 =?us-ascii?Q?W+ym2tWKep2ob4g89LwwX5m3/+qDwhpeGKIL51kxX6cV44C/L3cBZKB8o6mk?=
 =?us-ascii?Q?pXAjlt8owZ7jEuIkiNKg51ThuR977DT9uahgBfKcnPH89VUJWYG5Lz4vwekt?=
 =?us-ascii?Q?s3uADiGUUPDC9FZqtaft+d31IwXJJ2O1HviBi9zIThaEcUckrKJi1fSRoW4O?=
 =?us-ascii?Q?nF7JABTj98NGSWfz5aSR+W4nnE3KUwxGsGSIfSTmNtfyInMh5CwWWzEzuEBX?=
 =?us-ascii?Q?iRvlPmdoF0TpmwtWEjRiBvdIPssOvSy4LxLY319Y/mpEXRbBWl/aqJ9pxSC5?=
 =?us-ascii?Q?Ighae7wFlc8dJq7uH/lvCIUM10mI2Es2jNgaRxbhMg6FKeqQkixrFhNOrxRP?=
 =?us-ascii?Q?DKB7QlyffkHIG27kkYKzZTP4nYz6w+BvJ5no6VzgVhEWU069YcRzyUOxGaoD?=
 =?us-ascii?Q?tbEMbm+I4vZTRXvURgR4gtmRe5po9Esa/WFoO5N/XvPgcwwmzhOEmpnApOjl?=
 =?us-ascii?Q?n8/MGHNbWHQvyXexB8gCYur2MivZbH31PssGgWaV8onwBI6K8xG7L4IZjHy2?=
 =?us-ascii?Q?co3Vm/NLZeAr+85G/bmq6Zz1XYEsik2BitVx6dVNCKqHmzqb3UJ6xG8kKJO1?=
 =?us-ascii?Q?/vm4MuSGvb/HxmtTVgU5OymAajlB3XmpwGs9a9IKI3WILgVxeEGWiHGG2tFU?=
 =?us-ascii?Q?1VQwM00H+Ly4w75I4QHG6dGViDsFBKR1YtehoZIfD+PZ3vAsJlhFcmNbXSmQ?=
 =?us-ascii?Q?uijA1nCdQQalATo7iPAy0a+5APf/czGL4ExCTphiHAhI1M6eD7851Okl/kMy?=
 =?us-ascii?Q?XvIhxXSPZuP5H/fa/nO+ANglVhS5/tYxlAYf3Ne8ltboOpAbca/IZeITZDZh?=
 =?us-ascii?Q?NsduKTymLeh2OqK4T172OvimdugL7udbhu55CNc/I0Mje9h9nXBJH5ODhk9m?=
 =?us-ascii?Q?cC8OqfqBVLBaNNtNkabXZyppq7nKLkY4AotSO1/rGkkqnpD/rVLjvU/TuoIK?=
 =?us-ascii?Q?ROFlmqTNdV5P7U/vmzSSZQjuWU6QdYfthH/AJ62g72tyHAtq0LS1Rzdob1jt?=
 =?us-ascii?Q?GK6puvkGG3cmrtMVlXuvW/i2FKErZ9VcFGihz9UptfVw1WSF50WVBVGd1u8w?=
 =?us-ascii?Q?NY0PGkOxyinWdBOF42IgEYvqiYhZOATlQLrmpf3LdEZYiqhhx3UK9DPjoPOw?=
 =?us-ascii?Q?Hx72264PScMyDn+ybvOLDJYENhTDQE6RHNQB5kXgNsvX+ORfro/I7qs8gf7n?=
 =?us-ascii?Q?ifUFxj5Xor77glErgdpJRKCtjqbKVSj9FG+UFN63IVsH7F7y1Uc+vt0vPujJ?=
 =?us-ascii?Q?2mTwl8G1ezlH/LIrlwnKeI66aJNbrTtW0Vbf1XWERomwFZ3yQq4S7I9JOGFS?=
 =?us-ascii?Q?g7pgnDQgPb2DLlCyNqhxI7Isp4IlocW6JCwi?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?lx9RtdtoByXICRgGdB7dpWwMzB9GJxWEPNQvvrt8v9V5Re/TfZoHb08HkvJ2?=
 =?us-ascii?Q?0bl7Aq0xFSIk2KawLdpIl8QthNbDs1HtjJn1qo7i8njNrKJ0oT0iAvfMNGcn?=
 =?us-ascii?Q?XZRtP8Lib9kr2d5wWQcrdeMz3dWFj0eAtsJ3R20WYCUx5XUGUe080eAwNF1m?=
 =?us-ascii?Q?hevEMbGlGXu8M8X1UuyFyuaVJP/zLZHDz02/HJ2PLJbjxyB1HD2GGwmOl3+f?=
 =?us-ascii?Q?UWf403BsSaqUSUd18HgP2Dl0TaGYswXKhK4PrCRydaGwp/q8USugtmK2iabu?=
 =?us-ascii?Q?5MeuLHDjeG8eoB3wlb3bbG0aPu+CoH754Y4R3PoDUelocMdEVgQcmGZW6guV?=
 =?us-ascii?Q?YJhYW0hlIFZdmIIOU9uHnIJWHd9aVSQ+A+s99bRoNuGVC0WkmvABDZ4PEa+j?=
 =?us-ascii?Q?9bdiC8WBIvIbHXLAtm18t8HUoaXaNhtNMVukmSPWKIHmEqv5CitAzCjpC5lk?=
 =?us-ascii?Q?FwdpPLS//9faMImb0PX8V73ljX2lhypX4H44o2iUsbQN1Hd8fYZoBh8Tc8Qn?=
 =?us-ascii?Q?vZukDGk5xXazZ8iPSAUMgZ8R6O+XkYrLGB3n9BIU3p5KO3naxjZ9Px9wBJGg?=
 =?us-ascii?Q?wA30Pq/0MOAaUW5IyuBNAK7V3Yy9IKXLonnUq/FGTtDIyxxdpoEN+wuiOgAo?=
 =?us-ascii?Q?z2XllOJjx0IXONemYyFY6XYTiIHmghXDnooR1yNDBTuDa8X6i1N1vXoFDgG5?=
 =?us-ascii?Q?UIxHUoeIBae8qq2hjvSc5nAzl4WRWo9FJybsJZb+v1L/UEO4SLeuDTvUqI2o?=
 =?us-ascii?Q?bKTl/DTqUmFba2eM+Rg5NgIvUPCAfBezo6ejF14UsIFCBR57eoXZDfoeIJJ+?=
 =?us-ascii?Q?kanVMBHt/hBFYcXIbP9CgI0kMELJhr95p1mhxLaCOrnqo7ryauW7Q8AdqLV4?=
 =?us-ascii?Q?tb/i18THShMbyfBwMKvFgRYmj8BZcI4gu1XAj7aNr1NQVXfTxMztfE5U1gQw?=
 =?us-ascii?Q?z23BImJymMYJ3zFliHR3WD8sFrXJMAB/VYMrtwOtwcWwrMuYIcjXlw4SqSEk?=
 =?us-ascii?Q?kOlEhVaZanNUbzNtuFFo3KzN2hSFkf5cqztvomlOIogXP/Tkvq/V05CAwO+Q?=
 =?us-ascii?Q?8gu9YSGEUWXFnBMFLlLuAnA8qJa6Q3XtwBQQph2nIuLzTE6Db8hBmtrGIcRR?=
 =?us-ascii?Q?dnxcMr50IANqRcrxHVNeGD2DAS0+BwNGFQLS+aT+vs8AaCE8zAIygiR5SVVg?=
 =?us-ascii?Q?P3LlUDnGFrpULNx7qt0zPWCKW5z8opk/vbuxazbN9UpLeLI6MZ3t6WF9bFfl?=
 =?us-ascii?Q?aRMmDAuuOZ+7bvrq9p2E7f1sOpTuVlngFxjiSeru3qlL7A3SUtYkfmbgCgSO?=
 =?us-ascii?Q?NMgGYS2zwM6sgAzcnT8nGBREm7VZev4BTavzRB8OlGeFrgd3vCX4gLU7suwu?=
 =?us-ascii?Q?RjQisitkNqhAn5mk/ue0fezOs93Coaejvggkd1axZUHuHz1J88Vh1UlJgrtj?=
 =?us-ascii?Q?wfpa3o5NRiWb9rWOphqNQSjcWuF7qqq0+wa09a2TX3JsPWKWjE+mW0ccX41t?=
 =?us-ascii?Q?s7zzEM29hQCX322aqC3DFXhHLHpdCk3dapwWGAWdCTlSfIA30AyYm7Q3+hJt?=
 =?us-ascii?Q?KaAlToKDloUgX8D/7IyxBkBuLkXtzGufPbEh5XTc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d5bd79-2a26-4333-e9a3-08de18ab32cf
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 18:27:50.7603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBqHkDV4dDOZ/R045uziA36WzybP54rQCN2lRb5eKR6S+rEeuNHzX4XWN/ZH0M3EEHwAKyhPEI36lybkgHVziw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10536

On Fri, Oct 31, 2025 at 01:49:42PM +0100, max.oss.09@gmail.com wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
>
> The Wi-Fi module requires a 32kHz clock to support Wi-Fi/BT low power
> operation.

Need extra space line between paragraph.

Frank

> Setting the pinmuxing option on the connected pin to 32kHz is all
> needed to generated the signal.
>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> ---
>
>  arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> index 318fe4db1b64..32bca4c6f37e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
> @@ -490,7 +490,7 @@ &mu1_m0 {
>  /* On-module PCIe for Wi-Fi */
>  &pcieb {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_pcieb>;
> +	pinctrl-0 = <&pinctrl_pcieb>, <&pinctrl_wifi>;
>  	phys = <&hsio_phy 0 PHY_TYPE_PCIE 0>;
>  	phy-names = "pcie-phy";
>  	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
> --
> 2.42.0
>

