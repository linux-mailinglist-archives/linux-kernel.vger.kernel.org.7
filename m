Return-Path: <linux-kernel+bounces-830697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D411B9A525
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9023B623F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AC3309DBD;
	Wed, 24 Sep 2025 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N/KJ1UFj"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB15F1F5F6;
	Wed, 24 Sep 2025 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725093; cv=fail; b=RtTd6zE9f3L4Cwsu52Rq+bB7CV/Yww47IgAZxTZxT+FD2kiODwPva6itublCm4ysqM/rxfbL1nwLF57b+mDZw0A7Z8dISw8/yJg5TzDQ2piQgbJXNNlq3Y/aSdsTUgXIPZBLlvaxXePsU1ZUk3z6y6WpLJCJNr6xPgaHYTVvQDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725093; c=relaxed/simple;
	bh=lLBFNOtRNCV34yUaobsyx82/JhQjOfomM0MufVkmmrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sinp+rw+NHaEuUrkOpT1mCBTA99W7v1fkuyYpzXHvFxO5292hof0if9Wo51JNBHDj6rmNwTr0n8uhJpMi7pYAb0u2JHILfBw8c5ntcxafTIm/Qv8k/aU9wx9IYwGfa2A/nGv3FmohRRDxExr2K0fZoLWR74QHdxvZn/tNiy2BXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N/KJ1UFj; arc=fail smtp.client-ip=52.101.69.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tklmvLPHoKEejd8lFqSm+BAW1PBWyAHHZEVn8f4PyjU4FxRliNOfyStAB0vTBmCrE167ZvP6MaA4HKOw0BftBL46PSXXhwfqhQUfcndAZQKsQkm7+wEk7KeCbIO1R+o0BFXujC20ZFvfwwoE5DWJxSWCMvqJ1jiAZxuYrP88pvqMkNVqrsUnEygJxyFzPcVKM4My2T4Gom2A+bTHdZNFd29bYO37Opp6gwM9f73VBGIJIJT1SKbIl1BMUXMH6uf5AgBZPt1Oa8EohqxJLLI+BsCYbUL3Zp7B1owN1GDajNEeaeG1hNtfgdVjdvCTKIuCrvV4zFZ6z6o5vd1Ihi23CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYrBHz+3dznKSKWrRdBZ24bPNvhohmZ9sUgN/nDa+O0=;
 b=BWZvDM+V/poImrtlVKDmCPB9ymOJZYrGKnl6rta4lspWPFB3zqotNf6FG/YH/1PKhP+BkImax/lAZ+i+xj522CNmkpSqmXrv3UOfOztO8e5eNbG9LtDMU6xhywdawjZnuSUSQp92SVqsV6tocpfK5rNtcAMXp5pbaXnu1x7hB/h8tYU/nZarMzh/JXrwdC9Qu97yCRD/t3WwuTNoWWyqmLazASOc5PhMB+fOTxcFsXsuJBogpygZVLNE9FxjCqouS0IjPRMlECvPHfVnvXTpWqIrOfFXvfkaE2cshcMRWGQNNSxiBtrtZRXACI/z2uewHUcFJ8vSTfmJVf5FJiE84Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYrBHz+3dznKSKWrRdBZ24bPNvhohmZ9sUgN/nDa+O0=;
 b=N/KJ1UFjdigliD/+iDVTkfLBNhNVUDNhCcZH6M0ZB9WC+iLvE5hyFZym5//jyc9ELwA7V7EKN6l9lkIQmkf0rH7st525Z27afEah7RXGcL1jCEvifWCohuJ++3JAC1PbSSbjhIq7FOu2z9EIB+Rs/mtIzgLVpQEeW0/XKbXfVOX9NGsWddQBJyUC3yRWZvSWnYd6IsGreigfS61z6ABIvTga7rbtb2LSwNb22lznWhSuy0NJN0qD5FZXfNTF8oEzt6SO8ByNrhJ5dRqUSuwUx7gwF42i2XvZu3Lsz5uCkEV5PTNSXUpoI0mhX/8AgPYWZE18QioGP67lw7Tn8dw6qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AMDPR04MB11554.eurprd04.prod.outlook.com (2603:10a6:20b:718::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:44:49 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 14:44:49 +0000
Date: Wed, 24 Sep 2025 10:44:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 3/3] arm64: dts: imx94: Add OCOTP node
Message-ID: <aNQD2MU4oOmkYtsE@lizhi-Precision-Tower-5810>
References: <20250924-imx943-v1-0-0d32d7852ecb@oss.nxp.com>
 <20250924-imx943-v1-3-0d32d7852ecb@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-imx943-v1-3-0d32d7852ecb@oss.nxp.com>
X-ClientProxiedBy: BYAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::42) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AMDPR04MB11554:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9eb648-edd1-4ea6-34fb-08ddfb78e98d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bYpKyXP7PNrqzAxePLLKAKDjsaycFBbf2TWHLLi37sqAJaIzFI6JIrdET+b4?=
 =?us-ascii?Q?pigQXwGDbIQZjXIt+cDrTi8NDC7825f7+5KHj21lTkawpXBwzV2TBANZenqZ?=
 =?us-ascii?Q?/RkFQ0/ID7t/liV4CzZciEfq6gLOkD63N1WmA74oVzQHtFhK6wsMuEAaurk/?=
 =?us-ascii?Q?x5FPc3/hqJ6Z/j801rjdWFVAzkpxzw5Xc+WEnLQ2Pdue7rdYcVhXTl39/eNm?=
 =?us-ascii?Q?yhwMJsqknTyS1i98yN2NEpKGLy2qXt4t9JrGFsizwBY4tfbP1kJI5ixwpdLo?=
 =?us-ascii?Q?yQYUjIYTWgWG1J23XvMkifP5I8AUHs+I5zTYQX2DGToClSAoKNrsDQ3qzSyx?=
 =?us-ascii?Q?MeD4yfFLHOPOzZdrdokacs8z1Sh+e7UDWxP0OgKiKlHIEOsM4X+n3Nvu9a+i?=
 =?us-ascii?Q?ii6TyIQBjs5HFJFJtkJTz/KX76O8rpG29auNKP/PGWN1L0as4svlvTZr1h2b?=
 =?us-ascii?Q?q8IQEHC6vTLv+hQydlyjSxoLf1rJ+QEem4zBlTDxD9bX8aGdRNg/EJy2Qoho?=
 =?us-ascii?Q?OqJOwGJEbdBJlGlUgMPI0cXlgYwq4m/Hu9bdwAUM6D1owgb92doe1q97GJDA?=
 =?us-ascii?Q?fHghgPuiRLrDydGnkh9hPIEOK4u0dySJE5VcYW4GSNynBi4qY69sEf3xR5r8?=
 =?us-ascii?Q?73genXvI2mEB8BzixSuR7nwz+F8tGxacFSRScJOhEOKyR6CAD99m/hUbajjF?=
 =?us-ascii?Q?57a4lMn3xOQdoxzR5QcaQ0uQeWQYhbfxbSp8byRE/4nNQYrqsvsIadVgDUln?=
 =?us-ascii?Q?LU1s8rHr+G7cP4vVPbEObd6Z1HrEYnyvOxiUV2kARzzSgIhdii9hC1uKk1aL?=
 =?us-ascii?Q?Sdkyi/zPO132awo1hdszAOEu2O1+8vQI4qvvx9URnIMGWmkX4ZJ8HOyuzCuK?=
 =?us-ascii?Q?iMwTz/rsYcffCIAZWrBqNH7E/5DhrmKJ2kp7Eeo8WTIljlEe/wV02xUaGRGr?=
 =?us-ascii?Q?TPnlap2V8w1s11lP4NGNC2W6gar9YZvDxqPw38Bf26Rz7ypz44ywwjoG/n5g?=
 =?us-ascii?Q?2idc1DdAZQ4N4bR94IozoeKccV/jAGYx36UhrmLq5R3rzxgI6HLZzxgGZDy6?=
 =?us-ascii?Q?iqoPddugeCz1X7NDGJFMyNbN94Q+59dLO80B0Q0PteFnbbXsT1Gx5TAaymF8?=
 =?us-ascii?Q?44O8QpxSETkiuUn33loDPY1UT3x0LfE2B5Ns5JsdaW+qLl9SuWHQ+JCWk5W5?=
 =?us-ascii?Q?4Viz1pfpCvyOch+7UYkoyygmwlY536dHQ/mUoDtQEgHSQ6rrm3GSp2bw0TB2?=
 =?us-ascii?Q?OQ6zI74+31rfgH7xczotjJRHcBJZxEf0iyBmPo4qHnTYM8ymga1LaNkKiN0c?=
 =?us-ascii?Q?EkCpazyXG1gk0oGUWgDgD6jponVMCi14Qhmf0Zjbltt2UJ1eH8vociAiSrbI?=
 =?us-ascii?Q?8usVXae4sBB8NEoJKCqfHBqOvuoxNFRcXFxH9Z3rGeXVUJN4ZcD9xLqV58yD?=
 =?us-ascii?Q?boBwIW0gOmGDf8OupzmKWgYWO1njfz0Vl+8rirQw4/csBJOZZgOqSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dyBQHXVmptqPkGQjk8+nGS5es67Vr6nYHM+6yJTo0cO5XlYceeAuOmjMLYc+?=
 =?us-ascii?Q?FFIebrjHFI+i5u1/PrHLyLjwUDUf3jD/qIe4ZgJzlDeqbdPjJeBeYFQt4Bhw?=
 =?us-ascii?Q?a7MivWjvKQO86ruRkFRksM/rwFFwmDckdbpcs27tbL4nLQ/THE034elY7nUa?=
 =?us-ascii?Q?FWj4CvCqq380vJBi2gjUGROcwu9Q16BtJFFLaux1d6xwhk8Ia/tBELQ5U2JZ?=
 =?us-ascii?Q?1QTSkYOWOzq3JuLhUH3OBiM2RT+RBQBNlPWCggGohuW0FcQ9OtksNX2nhgut?=
 =?us-ascii?Q?QzNKAZSc8xfjjIiPUyWckGXs1N6F4pv3Dqnx7tNBCrn6q9RpMX0d64YKLDlZ?=
 =?us-ascii?Q?FiczT2yyW3w2Y3H8N51KUpQnbQc9UbCgQDhkhCRAO4rg6VvrIRFnHr9NdfIP?=
 =?us-ascii?Q?en+eYCJZhWciPe3dfg7Eq2MZz5nyj+nohvjW82/53Pj+7bAZoYfszW7NK/wS?=
 =?us-ascii?Q?ZpCj3wkEchALWrHRZd1gSJNlcwECjvR1Abu8PmNjf8LTIpi6qmSUtvkFceUW?=
 =?us-ascii?Q?akE16vtlgCj/lXl/4fh/jn67Coe1KiiTS1vmYNuHCo/CTv/Gw0dKhtPNz72t?=
 =?us-ascii?Q?Y37HySTg2xx3TWCPx8YRMUJPEhgOz1AINJDw5I2KXQPIhcK0nbrZNThVHQMM?=
 =?us-ascii?Q?r+Q4/MV0Nyd0NzCknlTKh/w7bAmZDTQdqyUz3Yd91v8r4IlO6XC56FQV7Vyv?=
 =?us-ascii?Q?x4OukEcnfS+mYmFAL9OPKujDdIzYsJweSLE0b9cJaGcsCVFoYAW+700Rry3P?=
 =?us-ascii?Q?m+IntMl+3awQRTuCaZmGpgCPAuGvL01GlsGCS2zf6dAeYOcJV32dkN3WPvqg?=
 =?us-ascii?Q?ijJOeCRTlp/Sg7CSvOvsXUkr24WzSOyYPBsviXNNemrQykwhdb+yju0lHV8L?=
 =?us-ascii?Q?h1fv+/tSMyXo3qc47JWZLOBgrFB95ypYLemnwHyt7DaaDdK93HHaaJVW5/vk?=
 =?us-ascii?Q?1QKn3Us4fd3EhX1Au8uLx38J4obbMCBD8mLFZv8HTtN4Em0dUMLLxL+klYhG?=
 =?us-ascii?Q?md2YvxXIJUVqj9HNdz8gKc7cV138nUfFbgp1KHhEYWnI+6Sy65W/2pjWA7H7?=
 =?us-ascii?Q?zIKmDVlExn+TOnn1KM/6uSvVtOYsp7iwXRe3vl2GgSPaxvM8wM/iiaobSgk9?=
 =?us-ascii?Q?31tVgGiX7ujmHY5G5w1V9eANXKeITK7SyjdpUPjwDlwJ3SNrOnDpL9DFPU2e?=
 =?us-ascii?Q?PWy8doA1IonGTIJjyUE2c4nN9Ykt4LzJoXuvbJfjzoU+LsJBSdz7IiPDcTHH?=
 =?us-ascii?Q?DyKWI5dP00r6lZ2VflM710FE/KMyGBhfvIWebjnjtvIDQMKpkEUylzT7ZXeH?=
 =?us-ascii?Q?twIWczgfs40CYNzzkcgsNU+SKKAXcsr2JpKzwVterRBTvEc26cKoBLJstrsw?=
 =?us-ascii?Q?pGK7wuzhsxI8SSCvEQOOG69e9g2G646BPECrAr5KHSwV/4Tkb2U6mORtEaiU?=
 =?us-ascii?Q?r8LW6Iq76+2WtYgR/Zyqs9m8WOEoEu1/x0g4C5PSjkuoAz04PMYOIjN4XetD?=
 =?us-ascii?Q?w6UzX+HlYNbFQzUZgLcYwh4vW12s0NDP8spxC4gd1YKj74Ty/6EsjhsrJCHC?=
 =?us-ascii?Q?n7OQcgT5X0eEgpYejFzKpvcGY39F/uzexhW7uVLz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9eb648-edd1-4ea6-34fb-08ddfb78e98d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:44:49.1591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4UhyGHmqHOZyuE4GWUmL5IC6KeNJ56dHIYYcu0WJl0g+CWrvMNgUWzZZuhK691bfkzFtCXzuo9pQRY+5apFbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11554

On Wed, Sep 24, 2025 at 06:06:25PM +0800, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
>
> Add the OCOTP controller node to the i.MX94 device tree. This enables
> support for accessing eFuse regions on i.MX94 SoCs via the imx-ocotp
> driver.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/imx94.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx94.dtsi b/arch/arm64/boot/dts/freescale/imx94.dtsi
> index 44dee2cbd42d..1f1148405193 100644
> --- a/arch/arm64/boot/dts/freescale/imx94.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx94.dtsi
> @@ -1171,6 +1171,13 @@ a55_irqsteer: interrupt-controller@446a0000 {
>  			};
>  		};
>
> +		ocotp: efuse@47510000 {
> +			compatible = "fsl,imx94-ocotp";
> +			reg = <0x0 0x47510000 0x0 0x10000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +		};
> +
>  		aips4: bus@49000000 {
>  			compatible = "fsl,aips-bus", "simple-bus";
>  			reg = <0x0 0x49000000 0x0 0x800000>;
>
> --
> 2.43.0
>

