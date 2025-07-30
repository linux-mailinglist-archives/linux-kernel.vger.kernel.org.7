Return-Path: <linux-kernel+bounces-751311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7C5B1678A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C882D189B6BA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07367215783;
	Wed, 30 Jul 2025 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="erFUgLNo"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C751DF754;
	Wed, 30 Jul 2025 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906929; cv=fail; b=L6EleL6elCVRP7QYYZteKdNil2e35OsQH4QL0OFS3uvzhkUB4Q3ayMoih2R5XNdiXJcpS0B+jUBOGM7SGYR01PZA8eBPLehNNRkTlgEDDpDQzL22cm4EZXjzxckhBGzZvYerpra6IlFT823oxzYhSx1+LVKoozwRxEKUrdPFg0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906929; c=relaxed/simple;
	bh=B9m8KBWskJLMrHGtGLQXurVdn4IUkH2ROd3rtkv/0pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k+PLrvFWz4v8J+aEGNOW7gvi5HlwDeIy5TK2pW/yslhmw5/Z0nVWYJgn4PgY5vSCZ9VNS/gt/qxwgLW12ZZ3KQgLXbQe3jtpCsEqoXoAQpx1X05Olrxw8zVSkzZQtF0bi53KAPD1DYpoOiu5gDNbZHnBjM84NQ5RhLogEjeznvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=erFUgLNo; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuVn1VWTwI8r3Hy2IfypNb4GgcJhwiJ3FCc6KrbmafYb9J6PtYItqhPyTbzwDcK4sw9T2XAu+Bslk7VBxcb/Sspb5wj49fOAEme5r2LHzWN9qhzxH4yJgIgp8vGHu9bdSlYdbLcHI27bJ37XuFxa8OPbwVZ7rCifVUkCJuZufQYamarjX95Jq3LNp02zQTkkCx2NxvgEw/UZ5CPkGyI9tHtQfawZbBPcw1/FyUlxzJ1j2kaVoy/iJgMmO+8gBc9BoSx6XiGoqzRaw+1Igl3Pr7Rico3gxQFxDJs0dViyeNfLW2uszF0tWCtFvgX4mYtG4sRDQc1kkbzoiYagkKqtcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4FPH9YCKQaFZubLIDqAEjIb0ohJ9rnN5hwCH5ohuDM=;
 b=wDkF26UqaJ5SqRAo2ymt88WCDhoAeRfTj82QSHaUiGuVNr9fc6CA+sfgehClYhAw3BaKbQ62v4c5pEquC6QWYhKEap7Pi4BcjmPUYhVcm9tuhxARqA9qEyFRgv7x3V8EvHT/2+RmxKPbW1xX43cfz8hZhXHxdZ5+hTvmrkKOdwFRDhz8PDFJQjDUHN0bKBaT8Kh6ZCGAyDSwBzyUGRf2G/vxA8Y/hpbGB1ta4sBKXB4kiX8n3PkSFvv3EU6QRc304tDWQ8LBMnR50F68nS/PzNBlj/N2B8Y4Sjm6nZxLuZbmoFGPjdkk06CDrsjgw1y1KvowxLGWo8h2CUbX8UzMdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4FPH9YCKQaFZubLIDqAEjIb0ohJ9rnN5hwCH5ohuDM=;
 b=erFUgLNoeAb7fTFCs23R4vlWt3SQyA/wW3uhn5vsOE3gQWsvl4sRR+FqKMkYuPoJ/AAY9Sx+Ntky8U5AgWchLB3j/BjAC6iloDpir05IKSlf4/r0Cw8KYhZN5rgw45A6SdDpDTm8Etvmg0248mO+T6gd5g5dlMkNKFfOJGk6+EyLTA9QlSzfJRI2bknV55j5XHDkprWTrs3RyLaWJk9Uqt7iVY6cpDcNaZBXb4MWfZCzLHTEgjuOXQ0B4qtfnkCU0aP/GF7aa6OgNkTrp3sP4ToY4terAGF8AES/66Plf9Yfmyj19xWoDqwgrIUFW6gwNBDjJBMajP7X2xWmMGPJjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11056.eurprd04.prod.outlook.com (2603:10a6:10:58c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 20:22:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8989.011; Wed, 30 Jul 2025
 20:22:04 +0000
Date: Wed, 30 Jul 2025 16:21:54 -0400
From: Frank Li <Frank.li@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: mbrugger@suse.com, chester62515@gmail.com,
	ghennadi.procopciuc@oss.nxp.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, s32@nxp.com, kernel@pengutronix.de,
	festevam@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Thomas Fossati <thomas.fossati@linaro.org>
Subject: Re: [PATCH 2/8] arm64: dts: s32g274-rd2: Enable the STM timers
Message-ID: <aIp+4mWS1k73Vf/A@lizhi-Precision-Tower-5810>
References: <20250730195022.449894-1-daniel.lezcano@linaro.org>
 <20250730195022.449894-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730195022.449894-3-daniel.lezcano@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0361.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB11056:EE_
X-MS-Office365-Filtering-Correlation-Id: fe7fabdd-e253-4e09-bed2-08ddcfa6bfaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|7416014|376014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HATLhJAfR2+Eyr00aP6zatPYeOmTvMGjELwFSjDnBLVGEam9wjHnVIVc6uqP?=
 =?us-ascii?Q?E5nTYCY9JEfpUK56xA3cTR9XsFf6RHJ0SPVAEbuJwMN8CxkUC6dG99OGmf0n?=
 =?us-ascii?Q?cV1ZmmwqTm2AZS9L0Z60BhyyOddCABunhnbw/hhBNLEh0dcW6g+LDEL65JXY?=
 =?us-ascii?Q?vOiYaogZgN5l7PxaLRQMzaQ43uhEhzTjkab5QTns4hUE3+fI6xzbLcY8cUmz?=
 =?us-ascii?Q?K87xfHBJWQEYY4LKFjsNnFWtGmcxVBpLtQz/ZMyq04FzgM+xntGXThEYTZ8P?=
 =?us-ascii?Q?YBGXZ12eVvfCethPRt2RPhgYtgB1QeUg71nihSScQ0AJ+gTt9DbxfOD8bKRA?=
 =?us-ascii?Q?HhDxvVhhWLmXjv23D/WhXj0QOwviL0vPTY92xpQMmrpdx/YkWUtSprynvzm/?=
 =?us-ascii?Q?KHy52y4TCzmgWUYKijRG1cBJBB1uebCn+XGRw4Vcpz2B7wkJkFpIBkMLPedS?=
 =?us-ascii?Q?tEAazXtBMEY4XCt2vA64PHDPr4EEq5QHfdQfXCbM27XqkRc7K07LLD4PSGeF?=
 =?us-ascii?Q?WUVnxWJy8Z7Dorl46QeTTrF0t1/QMOkEGX6IFU2seoXiPkDorfHFvJKqPyqE?=
 =?us-ascii?Q?gxGPzOKVZIvQNdhog+Udn2JR1zM5U4Iz7zlCm4GJC3V/JXHp8njdm1MMHZnE?=
 =?us-ascii?Q?yFud52KBOtpyzBlWdtr4XLv3vlwgWGpXMLCxvm9xNwffy+Iix72za11PrS3d?=
 =?us-ascii?Q?ARcAp1hM7oAQS8Hly9e3PUl6NFArDmHr0kJBiHJfmR2QFoLqSVpl7WqiCkN9?=
 =?us-ascii?Q?NlYCD46gITYfSs41943nQONA3WP/8kJw7ogxmA3odB9B8p5sLVqFb0EcYxQ9?=
 =?us-ascii?Q?H5AvvYzkSdFKNbBGAPQ2VPbmbFqQbsPg/d3Zc0D9mbEOxO6eNtZtK7ZDAmGe?=
 =?us-ascii?Q?DXy0wgJKj3/FyUAmyKe5eLu+ldo1eK/WLCGkzKhFnBBBraG6oNHwA06mD0iE?=
 =?us-ascii?Q?iWC86qJfOya3eS6njcJNBIabTjIgoUD7wHaJZNnJ8VhoATDG1cL+aVv0d1t/?=
 =?us-ascii?Q?v8bUkQlzYAT83jpJT+/jndm5Kz3btH6fLMZbGdRPZwDqTyMpHIZGCoYpdqRZ?=
 =?us-ascii?Q?nXPYRlFD6plQO7FBBdW92PPGcwIpHegnQPiacvRhzljCF1+v/aEQ0fC8MN+G?=
 =?us-ascii?Q?9h0CoybWJWORPGa6jXeHWx5gny3c7BzKehMGxsXK20P3vPzTeH8K1gFrr3fD?=
 =?us-ascii?Q?IEE0pSzOiQhMCDSj0MBOhBjaKFsxHueKBlso5kJIrUkUMswfi5gSAhHRKSvu?=
 =?us-ascii?Q?3nLrEkOGKVxyPcAXr2Uihv4v/l68EMyMjfPvTINeKi5MtKi99fmRlw0c1wtj?=
 =?us-ascii?Q?G3b6zJbBArCUAMAyt5zsqOByB3p61TNRhgnwxO5gaxad97fscSK++B3WsQrg?=
 =?us-ascii?Q?xeVemkRsNsFOVWEHhGCAEqg+DRiJ/mpJZELmmzG9O7eDIC4Oj8VKTV2qUuH2?=
 =?us-ascii?Q?Yd6R+0kteflfo0QjVYiw+g25ahe+zDPmuCtappge9Pz3Xv3mRJkaqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gyISWUSOczttPKsi5H7S9E8luOxnipOt7ttfOfM41hrqWFCI0kSkztbKu9DE?=
 =?us-ascii?Q?k3BQ1hpzrorjh/aWg5TjjZ96VrXBOnh/CNQ1ox+gOm8YXQ1kpwkwiHPuvW8N?=
 =?us-ascii?Q?eQ7amfHlsvCwHtgGqKJFs/0oKTgLc6v26p2ebG22bjQHut8qg1WGs57N4Mud?=
 =?us-ascii?Q?4Hd2Z4v/SIBusk8DAQbfauc55RXPag2TBS9N98DD/aRqg0UnXPANtiE85+S3?=
 =?us-ascii?Q?ssPAhrg0bAZRjFSNLD7w4dYwbcFKi0jcT+ClKO2mlBYN7B2w994aZOBdsqWr?=
 =?us-ascii?Q?jat2Hd2mBGp2io8ifF60SPZOlAVdxn0x8cYSTctkMsu6y4W47+TztvDg2+hr?=
 =?us-ascii?Q?Iw9Ne101Sg5KMkOeaGwn1FeWhP8Xum4SPpfF6DKqEEYTnTWJPksoO5hDLQ/u?=
 =?us-ascii?Q?/J5B5L+vwD3LbBfz5nM3B+ESf1kEOiAOekwEJ1O8+YWqbGTdQTVmDAo6Wgr9?=
 =?us-ascii?Q?PDPH+69xBCNUxrIPA391MdMI71ijsIkO5hTsrtA/rGuTU87C3z0wPj+p4guW?=
 =?us-ascii?Q?lNdOoPbacgZbEuijfaCJEAivMNRBFpjNli6gEYhJEzpuvQU22U/6o2mk1eGL?=
 =?us-ascii?Q?GwU/qW3HeFOUCJ5sXV546RgQzC+2dXIYv5kBakiyns4S7erZHLTCM0/F2Ue2?=
 =?us-ascii?Q?g0vseKZBZOHZYieGOryMtvKDibJuOmZyfQ+rxMMJJxgzczbBxnhmOOCOJL8N?=
 =?us-ascii?Q?e6gTXupFAgWnTWr9cRitqqVXxyIkqzNY/sSSe/RAGjbs0TpAYeSV8Hn1Oiet?=
 =?us-ascii?Q?QIac9egvyPDrljqwJwJo3FJSYnmi/KtK6iue715PtgzJEoatTqzbTHgayXso?=
 =?us-ascii?Q?qOzMiVWofIJ6UgApG0Z2t7aNNTrjrhDHcKCGemWpAeX/AVCYSCZmxvQl1yNY?=
 =?us-ascii?Q?mKwR0sEbp1GlnvE/nHemvTq0gvCeAp3ND9eEWvbA8WKIznBgh2JGwipNe6MM?=
 =?us-ascii?Q?4j50WRF2e03iuAamVuj/0s/ZuxgxIhxOXey56tJKtej6YzZ7t1NsQxhn9qdo?=
 =?us-ascii?Q?gl6eQOl/0jNlWjj9MA+3xPAjuyeitXdWipyPFMN5lTgmP4AsnbDJUqNPO3xq?=
 =?us-ascii?Q?9bo7VstIX4gdJEStnYKpVIgL/atlcC7xZsCuoUNUZYDIBgZl0VMmFr/8H59L?=
 =?us-ascii?Q?SIafGMIOaYwzH+svbkfEMYNSGVTUECLAbC703R8oqIa2gvl5YAL6U3nCKzzV?=
 =?us-ascii?Q?Kp4KK96/2sm9rO+86Oj6f0W0/tDnnjDx/SE8LrWjyHM+egyP5/8f3hTE5aaT?=
 =?us-ascii?Q?2lQYPG5iD56fo5oOtZCbCU/kjm7fwt95ps2sVdVjg/OHx0RzEVD49YiynsN3?=
 =?us-ascii?Q?AHno24KaTfWEjCVzvqKD9tmLcOzfkP2RyRapRfOcBx2hHUtelTxpIXKJeaCV?=
 =?us-ascii?Q?PlvQqKTYnLxUwSLvaV5CJyEbp6bukGpmBNkellXwqMinBIy+QWVkQ0PgLoc9?=
 =?us-ascii?Q?RLe+nS1FUEk6G3nbi3nYekY/IH2ruVHgv8LS+iPTFlr6fHHCyH9y5OZlXdar?=
 =?us-ascii?Q?Uz4hrTJlqxl3C0CS3vDhaGigDxB55aqassUov9Jv/RtazB3Jfsd/IZIYv/LD?=
 =?us-ascii?Q?DYyDqXrO+wRYkgqsrGw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe7fabdd-e253-4e09-bed2-08ddcfa6bfaf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 20:22:04.5491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrlugKFqV4DApo40Nycufnt4dV21MZVUl58B04wW5MiLjMF8qPSTnwXqO+Ih/ExHxmqi3D1fM+abwIfrI2PLSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11056

On Wed, Jul 30, 2025 at 09:50:15PM +0200, Daniel Lezcano wrote:
> Enable the timers STM0 -> STM3 on the s32g274-rd2
>
> The platform has 4 CPUs and the Linux STM timer driver is per
> CPU. Enable 4 timers which will be used, other timers are useless for
> the Linux kernel and there is no benefit to enable them.

S32 have not ARM local timer? It is quite strange!

Frank

>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> Cc: Thomas Fossati <thomas.fossati@linaro.org>
> ---
>  arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> index b5ba51696f43..505776d19151 100644
> --- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> @@ -40,6 +40,22 @@ &uart1 {
>  	status = "okay";
>  };
>
> +&stm0 {
> +	status = "okay";
> +};
> +
> +&stm1 {
> +	status = "okay";
> +};
> +
> +&stm2 {
> +	status = "okay";
> +};
> +
> +&stm3 {
> +	status = "okay";
> +};
> +
>  &usdhc0 {
>  	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>  	pinctrl-0 = <&pinctrl_usdhc0>;
> --
> 2.43.0
>

