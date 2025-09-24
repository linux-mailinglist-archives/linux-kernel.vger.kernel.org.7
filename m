Return-Path: <linux-kernel+bounces-830695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EA6B9A516
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468193B37F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4C9308F13;
	Wed, 24 Sep 2025 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="emXSvxG5"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013031.outbound.protection.outlook.com [52.101.72.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ED53093DB;
	Wed, 24 Sep 2025 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725040; cv=fail; b=kte9dTFhrgLtba8ovmwZbA0yiuqozrTIb5mDsUTsqysR/uW7vs1We0zqeQEV0oHOSHzmKU5mwva5WhNosEZxDQYpDdNgekawadxVLBqQffJmPxbJdeXh+yC5NTJrAVddkGkS9y2v7V9MbbCSOr+DJOJPx+ceXjsFffqYAM7//lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725040; c=relaxed/simple;
	bh=lYbmulv2Q9XmS0qhZ9QSamklb284dV2FlNcYYrj9A9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UIar73hqzbe/EE2EaTJr/rwdKYm2kAjR+lelisJtK6QolKE0t/vr6SOgmTCaIAbOHOLDxt5bsAPoXqL5nkG0Bkyh99nfP+h7iYHRX6WdJgi4d+bdQ/1EI/KDS4hFebgHtNGT/Csm3MI/ZQaij+PfoDPiWLoGjyf9tzMKnF7rOwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=emXSvxG5; arc=fail smtp.client-ip=52.101.72.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuZM2+ABxACG4SmYRZabkn1EobxY8eMLNtYP8WBUXqmFbvEzv77blO6E7Agr4q6nKXNEQykl+hiJ0QmLiy7jlb8XpBvWq9+PDWQdXQBsONpdQaBXkXsRzbjbUKR9cN/Dtj+cUpYB8Ad3dm5jYLAJVDKESsDslTDVKskRA3SfJVmYbDDqBAuT4uYgjHspS2XFrtDiA+1s+HeuKc1zFg2MPPn52dg5x/Kq0WX8gIG3hONXE+3InsahNs70KZr9n32hhl/WzBPeFaGqctZgTbx8XT+De4c9hP74VnPEfuC5SiolmdO65ijaoIf1gF+o7IdxCsufRsy/E27dOXvmL9jXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFio9Kzjk+c6LD/5aI7KYxSW8P5RZLQhdKAn8Rsv54k=;
 b=SJBzDiVwEhalD9HA7surK5l0vuIy/Vokguir0VGww4Iq04QvqT4PYapxDwyQFOU0XkyUlN3P3YE6lHRvfB3AME3BgxxmVWuAc/cgQLW5TSxXaUDzIGOgB+9/qAaDngsbK41h56IswZiC+iNPKQ/nRQLglHcVdmiN8pojJfBJIyRsw0M5XIL4FPh7jqc30QcAgCBrkh3RKyoCgRnv8omRm8B2KmR7Db4pzAIQqX/HavGKsFxIWy9NLJPp61d2HJnsEY9LYQvA3beutgmHXa2aMlIHJD73cfBjqTWOwxju73dqhLYOooZPJoIEkYUzCYE8rQe9raTNQOoH3Zi6nx6jXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFio9Kzjk+c6LD/5aI7KYxSW8P5RZLQhdKAn8Rsv54k=;
 b=emXSvxG5GW4plAtjqbKl1zPNEegcClLSbIqBD82ZMuJ32RhSfNCU77CRxW5SfRel1bRwOgmIU6Br0RBjdL+Ip/QyBMh3Z4Ms7ThsqJJ/kbCwzFU5BaqYbA02dYuTU3J4LEvgvz/ahATPBcLpM3xMtl9AnIbMhpSHHwfWQkCvsx3vHElimFf5d7Lz7M7pMlMvJ7RXvlHs3oDONW4Ll2+FtT19L1TGpZduYHVYUQfDQGbCu4yNGUIQvRTVNr75eXlNc4cUFyyurjjqc/lhzVb1XY/2ELo6A+tS41atYGXacWS3G7KUDtWtiW9k+0M8SkrAjLwThdjLijgVkY38OSO1bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AM9PR04MB8522.eurprd04.prod.outlook.com (2603:10a6:20b:431::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:43:55 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 14:43:55 +0000
Date: Wed, 24 Sep 2025 10:43:50 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Alice Guo <alice.guo@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v1 2/3] nvmem: imx-ocotp-ele: Add support for i.MX94 OCOTP
Message-ID: <aNQDpr+Uq939nMAk@lizhi-Precision-Tower-5810>
References: <20250924-imx943-v1-0-0d32d7852ecb@oss.nxp.com>
 <20250924-imx943-v1-2-0d32d7852ecb@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-imx943-v1-2-0d32d7852ecb@oss.nxp.com>
X-ClientProxiedBy: AM4PR05CA0008.eurprd05.prod.outlook.com (2603:10a6:205::21)
 To AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AM9PR04MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: 4205806a-85dd-4013-7318-08ddfb78c944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RPMU/g4rkvhyJ1AG9Nbzr0G2KUdm1KvD8XJPuaq0PX1l/YRvKUTa2Ko8nu9M?=
 =?us-ascii?Q?zvnJBbxODy6Nne5RkyRZeJ9VhgrMlmaBpkefkA6tcL1AdVmJIC8FTZ0P8zy9?=
 =?us-ascii?Q?5i/0NPJ60eJYMHeEb2yQPx8z+5iicFV66vshWMDDKW2Eusb78e+hgt7WJUPE?=
 =?us-ascii?Q?rRDD6EQ19+Dudl2KbaH8bo9hRwO3ebuHOEWWjXyJXyDQnpOlrbOZMoiCuWHy?=
 =?us-ascii?Q?stUj/97ttuuCkUNhywkWWL0kuEkIPdrDMWhACTU1dKtIGqSAbhqyryRvQP0u?=
 =?us-ascii?Q?A+PYuSKKKmUFABYNlo/usTntPuyg/k+exHdOB8LMR4zeqpk09QLyJm+ormNu?=
 =?us-ascii?Q?T702drD0S8nZk8dwLSunVgKa0//erIHC6m2Eu6CmvTVQTxvp8nOTzKWjYD2n?=
 =?us-ascii?Q?2jmMiX7zLmIY8re3A5c+2UiS0OqJrbsmCotbxpXkskhZUxscmCblkqEk8+Oh?=
 =?us-ascii?Q?4NOrAg/Sh7/mGlSQ6No3FO2URSeuBdEZ7EpPiY7YaD2Hef5nFzPHUUp1zUAM?=
 =?us-ascii?Q?mgFMIJkprrVr/rdobdW9TxcBW1IUVtXb922u0oJCSzCXcM2gsN2ISonZcMJz?=
 =?us-ascii?Q?9HNW2qGLwuPgyiLYPEhIVIc00MpHIaqZjRiygUcdnNYkB8zUlgdN6THR8J83?=
 =?us-ascii?Q?vaZYxxo8IHxDw3O3oWyFEKLMAprDCgINLNabfhGZD+xeLngYoE9ojRzB1nCs?=
 =?us-ascii?Q?al4BsP3C/5/L87J2jW+MKoojG+3ZaNDS7lIfqPXcUZbqnFSgfRXRpkuGk+dP?=
 =?us-ascii?Q?n0BYACf7EUpUnwUjybg2u+1zEW9SJEPzLwyXmQ06JcuWqbh3ucNE/3tiODYO?=
 =?us-ascii?Q?p3fafqKxsUfQ8sNGUPBKhKabYVCqdI4QEvmr3cPoPiVOY7H9iL1cRI4jWDLy?=
 =?us-ascii?Q?2rGbu8W2/jzGafW7Tb/mVtM2GvyzKSuMIy2cVvfoJQPRjDBdNzEhRZ/wBIZP?=
 =?us-ascii?Q?CGg/ToZYS9C8GhCA92bflR04W0ox/lS8GYSSXJYf8YWamt4RdFzaERCwSeq2?=
 =?us-ascii?Q?B6NzNFPyjiAkuHM/5CvPAKnrFE8Lok+X8+DLZ1vGki6VhWZabuyJsNrtIPwZ?=
 =?us-ascii?Q?Dt+N3v0Ul0elNA4uNOM0bhycm774RV3kzJbu/nQigQ/yYkwgtPLLD7VHEBP4?=
 =?us-ascii?Q?tZv+87odr7vwWuvefdUrDi17rnTS7/IMI6Qvn3XN5ajd/L1JGGguBodhvKQB?=
 =?us-ascii?Q?zNVE/+HIMSVzSokk6fLvIFNpQlVBl6RpC/Sz/ydIZWRgLB+ucyApqn3zZaT4?=
 =?us-ascii?Q?L3RZBYdsU7efGlIHsY4sLPCpWK+Ld8jUhICbckpn2HiDM06L0w19K1Xm3uw8?=
 =?us-ascii?Q?l4Oz7DXQkY9pAQkACIXFk1Iv5o6xvedcsarMrySWPEeANVmiS1a4BviJPZfw?=
 =?us-ascii?Q?E6LKuGRpp/28TI0Kag9r9Hp+AsLQEoOYqWXdPxKDW2r54xKZUjiwHMshNhK3?=
 =?us-ascii?Q?HLBseBi05EUAVCtJg9UVId5ILld6BhGG0PaD6SEumtJIrQNmXO+CRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mGj7cDCqZK8/ng0L7FPB+pILEnvPLdysWrKRD1pTSZnHkOMEEAijjys2t1dh?=
 =?us-ascii?Q?wfI2ghLHG2c58RX2Ip/P5awNr+4Plo/Ya4YWzQSUUvB5aWUsvyw0SJMw3h8t?=
 =?us-ascii?Q?qFFlaZ1zs/jWEOd3WUNFi8j9gU29vqWnqVwhEBYPu6KxojMJ8uD+lP7IeKbC?=
 =?us-ascii?Q?NB4F7XkZ4zGjGms4la5G2vDqe/H0Ba99EpORba32W0HrqfTdETWsx77HBmk3?=
 =?us-ascii?Q?v710uu9tgbMqEYGKErb4VKJhlCr+1wdzSEE5Kq82Tv6VO8yHtRz8kRHNGoJP?=
 =?us-ascii?Q?2sQgbqx1a74mQZ4IntiP3nH1VgUkRnQP4ZbUd4mg4f/SPMRCwG1q7Pvuxcwj?=
 =?us-ascii?Q?BZZuV+otb30fgY4sg8A4WsfaNLpRRa/DIF/1Xq7K9I93RkLvuDZD50kUNUX6?=
 =?us-ascii?Q?oMhhF6+J1bA92lhAlOcMZ9HWs+cs0WUKIXBjfBSWGj+izSkW8nMu9nhBad1S?=
 =?us-ascii?Q?ch5nDpsIs7EfQdMbMeM+DCSgvXDydow/8gWYi0KxF37PDbvN2GYd1CSmMElS?=
 =?us-ascii?Q?IbHsqW8lmc/wRcTbzJ06csiJ7a/xSMYVFPmcLAStzNKbSaQDED3vK6PH6ET6?=
 =?us-ascii?Q?ku3seErc7cVU50dgve9C65wAYWwsmTsMZbXHOsOznHu65WnVFjMSXVgCpFQb?=
 =?us-ascii?Q?r/wUsR0U3600V9M3SZ56OHcPhG/ormI+jsjea3Sla30Ie7m+GzTIH5MBdl/4?=
 =?us-ascii?Q?Mvd4OBtd12bmTea7QZTB0JjvU9Jt+SK+b6/zPjqGwcKpfKQDvc8ntayaPubj?=
 =?us-ascii?Q?JRUzn2Xbi/S4AhiatP6omJPr4/fYVODsVinq/DA1Lncs7VhlmDyE2Ln2zGa/?=
 =?us-ascii?Q?elIBxJyVo7P2kzvbIKPiNcy9zYrXGOL9ZJ35onQrqAEOMI3mHCtI9AR0C/hf?=
 =?us-ascii?Q?afsL3BLEAT+qypHs6M1gDtX1QTBXRYs6e/7sVLOqlN1Y9uVqw7fxBdc2q6si?=
 =?us-ascii?Q?+p9w1NI9HhxmE+63TQdcynYFvX7YEXZNmHAKvskcNkvsUjdPd37y6jEXK2WI?=
 =?us-ascii?Q?1WjJrdVotQtPeBEu+wzmyRj96G014T6PQDoNLz4StM8ro146AXv/5BLpLOaL?=
 =?us-ascii?Q?iu9UFg66TG+PlxuGQ0zDj/dMyQP5HPDNE84dkPICYBpl4gFUbmnQy8YM2aiU?=
 =?us-ascii?Q?KiKPTDYytw7Uf3xrNaBd/Gtuh6FjCNfK7m5ZEaPiWFnY65pdGJynnTBKlDmE?=
 =?us-ascii?Q?q5pRuljYR60gSdIi3RYXEhOF42f1x/Jqfig5JIEBSATCatujZTNQho68mt/f?=
 =?us-ascii?Q?aHzEtoJ/Ct+Djw0LLz6mfwccjTsm1L7GIkfwM6jHijfHkop7FnNWJctIR9vH?=
 =?us-ascii?Q?xn9vQ//rZBaWn7pKL0sCD+K0FhSKU3NbVAtoEcsu8XaTANwVVHkQ9ExmqVf4?=
 =?us-ascii?Q?36kXNHuByRV41eOSL1cuoRUB492VWv1AY/T7G3m6WW49FOPiLPg7I1zzCPYh?=
 =?us-ascii?Q?tvBC2m+HcM3008+OTvnlvLwsguLgi/XP9QiZMiN4nG8Emo7K/ecZYMx0brKh?=
 =?us-ascii?Q?QFdvm/H+pMvRB3gZ8vANJdo33rtOQJGcaS8JfvMyh3whXDfw85pHHsCkr6xT?=
 =?us-ascii?Q?8jjoRo1iYVKwoqXzyL8XjPEUCSKH1VoFwFyBOqIx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4205806a-85dd-4013-7318-08ddfb78c944
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:43:55.0976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCYIBmJLl2QWf1gC9gbn2cwhDfmXs4H1NLdNfWkTYgF2ddYd6fsTTIcotPakgcOJiEi3Upm+kJMWhOebVoXxdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8522

On Wed, Sep 24, 2025 at 06:06:24PM +0800, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
>
> Add OCOTP device type data for i.MX94 SoC, including register offset,
> total size, and fuse bank layout. This enables NVMEM access to the
> i.MX94's eFuse regions.
>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/nvmem/imx-ocotp-ele.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
> index 7807ec0e2d18..7cf7e809a8f5 100644
> --- a/drivers/nvmem/imx-ocotp-ele.c
> +++ b/drivers/nvmem/imx-ocotp-ele.c
> @@ -186,6 +186,25 @@ static const struct ocotp_devtype_data imx93_ocotp_data = {
>  	},
>  };
>
> +static const struct ocotp_devtype_data imx94_ocotp_data = {
> +	.reg_off = 0x8000,
> +	.reg_read = imx_ocotp_reg_read,
> +	.size = 3296, /* 103 Banks */
> +	.num_entry = 10,
> +	.entry = {
> +		{ 0, 1, FUSE_FSB | FUSE_ECC },
> +		{ 7, 1, FUSE_FSB | FUSE_ECC },
> +		{ 9, 3, FUSE_FSB | FUSE_ECC },
> +		{ 12, 24, FUSE_FSB },
> +		{ 36, 2, FUSE_FSB  | FUSE_ECC },
> +		{ 38, 14, FUSE_FSB },
> +		{ 59, 1, FUSE_ELE },
> +		{ 525, 2, FUSE_FSB | FUSE_ECC },
> +		{ 528, 7, FUSE_FSB },
> +		{ 536, 280, FUSE_FSB },
> +	},
> +};
> +
>  static const struct ocotp_devtype_data imx95_ocotp_data = {
>  	.reg_off = 0x8000,
>  	.reg_read = imx_ocotp_reg_read,
> @@ -209,6 +228,7 @@ static const struct ocotp_devtype_data imx95_ocotp_data = {
>
>  static const struct of_device_id imx_ele_ocotp_dt_ids[] = {
>  	{ .compatible = "fsl,imx93-ocotp", .data = &imx93_ocotp_data, },
> +	{ .compatible = "fsl,imx94-ocotp", .data = &imx94_ocotp_data, },
>  	{ .compatible = "fsl,imx95-ocotp", .data = &imx95_ocotp_data, },
>  	{},
>  };
>
> --
> 2.43.0
>

