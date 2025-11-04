Return-Path: <linux-kernel+bounces-885153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC4CC3220F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 17:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C06DE4E227C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 16:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F33D337106;
	Tue,  4 Nov 2025 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HHk6ESrx"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013039.outbound.protection.outlook.com [40.107.159.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C31C3BE0;
	Tue,  4 Nov 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274869; cv=fail; b=ZER/IOpKUpGfW5uY12coqiVWlfcf80s9C41N91qZ9fpexdr0MVhZQZVGLjx5Sym4SJ3oSj6RV3cu67+lKIMQE/4Po4Cx9L1RpEQIMbEtv2zVSGkTbTrf2UDjcHQOEGcqK0Bblv0JadPloLx85/yyw1Nxq3KaUem15y3I+yXjVEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274869; c=relaxed/simple;
	bh=JH0RCzqteyS/dyV9aaHacrKZ+0NGYVku/WvZzpuGND0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pI0g4wiyaawKp3fXWIE2FSsPoGk129OZ2bZoUdlMe6UiiqpiFiBJNiXIaQjREx7ucoxK82yuOYU15zHXyZzuuw44PesKFrxvYvfTXnlj7cIIGHfhYzb698Cio44XFIS5V/YpkVUUIfmS7xwWhmjqwDs+KrF/xYlXMtt1N67Rvlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HHk6ESrx; arc=fail smtp.client-ip=40.107.159.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2BHdC+1HUU7VLDbbQJSgjwnGFy2ZV6ZMesTjR/HoOewJhjgnyVaRR2ahi3t5WtdYyGqxeMoyU6Xxdau2WueewObhYz2hXkIxBo2xChQ7lRRXL3MG8b1wO11XN5/keJKDZ2sffYxnZMEPYKCklrJxlnJjp3PMs/CUpfHxbfC8BPQGT3oSYe29QjoebEyi2BpLX25ElVS/nj/2dx+WnU+Hf6FM0tn8V30awg3MZZWe8V5M5Ylv5A6uZpt9jQzpbpGDTuN7FBatGxcxmLcwYGFOcJheSWYTcEjnC3mD0dHG+H7ekclI6uKN81egQrApzqLswjAYQl6i8uYngsbzl7pGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WTjemw2wPrAimT+oNEuNQM/NiqvdjGN412lBOH4YJ8=;
 b=zTni/E+OakEI2G4102CZQxCyrWibKr3xhSCHLKS+J8fFKuOVg3yBe4WbTw5za0WzMD/GalwT5MivpLnDmk10BG1Y8kozHqxBwdJRsOP8p0UyjvlJREz7T6Uy4LSTXLCkxYpWjrMFkB9hXdlWrvtx2My/lBd0a1xLymxNDx2zrC3eQ5nrHJ8zvolj2NFMhlkNvg0chC7VZUELEcylbqXk9LL7L7ZD2K+lj4XMi2bhcKBhzpgLdvxkQXQno1mJ5Cz7JuLnCnFxbTOKHRkniVA46yqhVrWkTfJJ42LQolZIoEgg/Fx1NE+VxlxbbzpFm7gcAm02LM2PDdk8ttBjIhcyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WTjemw2wPrAimT+oNEuNQM/NiqvdjGN412lBOH4YJ8=;
 b=HHk6ESrx+R/smctlaSemzzNwNklXPtcMb21NYzpMUMdoEjLvz7UDqui0IrTCVEPrRtTrJOFJ/QPMwCu847hT0KClSrzBDrcPg04BQW4IE4pVO8BtUVA80dtVCC8NMSpCs2078RIzIWhmPhvqTIAv/YmcWuIf8Kybc3tYoJPsgguknryoCRm/e0s8wsAlt+iGjgB9XK42d9gAxpOJAsBHhcUldVgQh8FomZue6fPwtktZf5k/VybTPSlmIf6muRcvr22Q0ukKFf2P5IUJpCJwhaL2JOxAI9cEEEVdNmmF8CHclomTDtAtpqofesDIDfMcvun+D2TtvpD8BY2VILc5mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM0PR04MB7188.eurprd04.prod.outlook.com (2603:10a6:208:192::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 4 Nov
 2025 16:46:32 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 16:46:32 +0000
Date: Tue, 4 Nov 2025 11:46:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v4 6/8] reset: imx8mp-audiomix: Extend the driver usage
Message-ID: <aQot4AQ5DzryY8iW@lizhi-Precision-Tower-5810>
References: <20251104120301.913-1-laurentiumihalcea111@gmail.com>
 <20251104120301.913-7-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104120301.913-7-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: PH2PEPF0000385A.namprd17.prod.outlook.com
 (2603:10b6:518:1::7c) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM0PR04MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c74fc0f-737b-428e-2d09-08de1bc1b556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w045mCYHr6CAuznsCjXhLu2lLVEyXiQrqFJmrXXSodzbV1mVk3kaJQlgq+VQ?=
 =?us-ascii?Q?+yBqmRtEd3SL3PNBTJaKyIVw4sTji/JbAl2Qcaz0gEQ6ezKAkwqhBnGxeqeI?=
 =?us-ascii?Q?EZ3Sv2TXObR/u1zP3h28jGB9qzsCSa7ZHdNKFzs5BllHm3dWvSYzu0aOVOTf?=
 =?us-ascii?Q?+LDcaZR+9p0wEYUvwbMIws+OQu3XHANuXlPqw1OihRFWrqM5hGBlSpQ2Vq6h?=
 =?us-ascii?Q?j3PO0qSiTo4OhQGOpAFw6QJjJlS5JZEe64QKIGG8MIEQt8SorARMOQuq0fJ+?=
 =?us-ascii?Q?g0nKAbMDDMRZRebI1B+m8c3DG5wFeoyOX7UhkI/yS0oVg2ZfGSm6d8YKVgLU?=
 =?us-ascii?Q?SBhaRUfXfCcIGGJ7dnVU01JbjrwVTA/j7rP+TZ5VoLPDtpU7kG7hYLKzFrJN?=
 =?us-ascii?Q?FRDgnvqkw+wzAbHGzh4YppuSLYYfcnSzfwZlIlviTFvmDvg58fNzc54HVf7W?=
 =?us-ascii?Q?Yg+Yza4xe+WeD2eutvNJvI8ZBzBGhT6RLZzR/cxckHW5+67iMNVTZPvnuk5v?=
 =?us-ascii?Q?TsR0JXFmcGZ9252+/RUPUKbVi7yd/ui+D0xm/yJ+oxXKmFCd6U6KmoIhjdBL?=
 =?us-ascii?Q?TVUi69S1bMup8UeAUH/SBOfodjPPwRvzwVvLcI7zHqVJ98nts7d3q8E5EiR1?=
 =?us-ascii?Q?yBpAXkkD+QeyH/DsdlHeNEjjvrTihTTNa8owscjKU+3AQBV3OjWWWa3Sjn6k?=
 =?us-ascii?Q?8atv9KxddiEodfJgWrUq19N2BQk9rcW1vdWFY5qWHX4eYkSbkMBCGKbkxgIe?=
 =?us-ascii?Q?po/dvfuJkYnSiVtzb9RvWgABe7OdccOeNaRla5JRokuWwOuQrxgwr0jeNky/?=
 =?us-ascii?Q?8OblC/5uNmFWEV3fS2gMA7zmBta5I7eCclgs6gANc1WpMLn5t/cVd2MoEgYn?=
 =?us-ascii?Q?h+nAnNXMYDRfDsxBv3ZTt/FKAbQum98ciS9oRpt19aczj/vgRoM9ysPTMUqo?=
 =?us-ascii?Q?s9bNSzpRfn+dDi4A+sQPDz12NCxUXBzkSIm+K/3/7W1+4rglgMLuE7ifTRIb?=
 =?us-ascii?Q?mh+9MU71zX3byWZEPbAlJ836+5eyYz2ILICh8dowYbgzHKHfUnEdsQeGF8Hr?=
 =?us-ascii?Q?mr2H1XWrhincLfO2V3AkVGy4jwexGDLRac7lHlvuFkAvcgRWKxpU/Dr7eRRS?=
 =?us-ascii?Q?vAZkn3VIlLcyZCP8GPpuB9uIQZutRRH3CETGiRY4DR/zvYwSFm05bC4D8Q0a?=
 =?us-ascii?Q?d1Amm8rK7ZqXxXcpxAGpnvsf0Uy0GbgSsOqfs5dATbddyvXGuDtfRFV1es+R?=
 =?us-ascii?Q?WcaK0mu8xEeY5es62Lsch3ZAzInILKj1cWBJMJgesQD9+ezJUuQd23b2kaew?=
 =?us-ascii?Q?rkUE7XatU+YpP0yh4ujRDsii8YbHge+l3DVkdr1M4EHXlBNBxnBeqvf/Jeai?=
 =?us-ascii?Q?NcTR40HTnL0m80LsM1AGqFXcb77KilpzI02f3TY1cWZOM9iEOnonhuW2lwoa?=
 =?us-ascii?Q?d+yMfzKI1Hm5ZlzXX5a4pr27YDI/RJ/2OYVTsX4LdbHS9LJQqXSzoFgIS+hS?=
 =?us-ascii?Q?3AcgosZvRj+PggLCc+UX64vnXqsE0vc487DW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oci7oE/gl+b8gHeALQ8OZTS5doz4EdaIhbjMAPXgKo2za/X2AAXeFe4UZpMM?=
 =?us-ascii?Q?bWkY+QGEHi2mT2UwuPZ9smO+A4joqHECqJauqgsrBo8x1B6fUi0tRyW9tUmT?=
 =?us-ascii?Q?7MTX22z5ODtHi7IqVs5L4zfidPzfgpuoHf9BOvYs2EcNwAxxhhOfERA+hc+V?=
 =?us-ascii?Q?kt0z9MRBLBgnWPu3NB58GFIpVCOWGYCH/qADnzwfcpo7ur6lOdLxCuTJ+Ilc?=
 =?us-ascii?Q?rrbDbhN1rWgReaHmsfZYpEXc/p6MPmHVnNi71V+uMQSZzJH6GI2guaJWf1x9?=
 =?us-ascii?Q?98yRt6gxR4hw4bdTxme4P2eYabgfEqFMH54l3YHnPqZR7ekDXypCmBPqs2gV?=
 =?us-ascii?Q?MDTo+yyjuBa/Zty4S2tCpRuhkxgSYP/ruWuV62VTI2kqFtMyCnVb9xHCRCVx?=
 =?us-ascii?Q?dvbvwQeLK7GUhhRbtxhbsJcx+aEDyWfRd8Noah+lnWhvwQG485qoUdVYNfnm?=
 =?us-ascii?Q?QmflBhCELqgxaTbfUqo6uWRrgoY6B8nmgBZfOtfvER9g+tJ70sod7sQSKfbZ?=
 =?us-ascii?Q?rEX6f665eLf6M23HvnkN+RJ61plIoaS8Z1adEBAH2iPlFd/cwZP694PsPSXk?=
 =?us-ascii?Q?ZC5ko1/rJ7lG7peAiTV20IMKQuoCrtoLiLyRuyQCBreM5xyiQvTyNV+LYGfC?=
 =?us-ascii?Q?5SDKU6rAToIk/vYeQi0auRqnRMbRMr2BvGvYwP67Or/Pg6ltQjFwqu5Z2ADN?=
 =?us-ascii?Q?+pkb7jT0fmzt0z0rPSEq7RwDxL0I+qD2/h6uq0kaNMZiLFpPQYYrNmVtsOi9?=
 =?us-ascii?Q?VmC4cJaRFFzHpnrQIludRBqcHrN24jFif3dWW0OJHK/UN48I0x+v77Tcg3gk?=
 =?us-ascii?Q?iED+eG5JIkqh0e2oxWE4AVAXO3A//A05gcB4JMR20Npf/Yetxuj3vDsF/3ul?=
 =?us-ascii?Q?fvbMAHuwocvRCZH2zeikbPbKWhoZ0ywot/+3fxlK1MfkkVsc/3cDwLrulnbF?=
 =?us-ascii?Q?4XmDsFGrCtSP/0qLuyLgJDpvlv3lOTDczxbBXDbRfjmK6PuVD5CO8St0hdDT?=
 =?us-ascii?Q?3oJ84MqZaBKcK0m2enA0yX+mNUlqZ+HCWMfBdlHwdawkc1/0SJS7HerwXO0D?=
 =?us-ascii?Q?nzt2GJNm46RITbgH+eSKmbdWuqQFGRUJC4CPuars+yu/Za4dcyTlX12Bel4K?=
 =?us-ascii?Q?wa0S5/xFuEHayImkHKT5M0WKsZXCFfarX4C0Vt0GYy1BaAqEr0pb2gzM4uMw?=
 =?us-ascii?Q?gllAOScTQpRs3/jV2yZrJRCeq1XZzadplgqGYWzSgV17yQF60DFrvB3tsvym?=
 =?us-ascii?Q?whluAvmsgBGvfKxl1jQRU/om+EhljLVNBYKaDeFYDOlwPDZXGK+J5Cgd+/lw?=
 =?us-ascii?Q?XM3Heqt7jwz7szOc64vNYdo+Ade+AevxxHZ3stIchJiPcBEn35ZA815oHXWC?=
 =?us-ascii?Q?+GzELSZktmUkS2Rdgs586NkYdJGLMy+1Im+QXTUUlFWiV8UVMPKAFWnHz0mt?=
 =?us-ascii?Q?iJKPmUZEP476m7Q8VH8Cmf55Fdq2mbEdCN3bvrj4QdfGvg9Y+1IkzICsZRoO?=
 =?us-ascii?Q?vq5p1YlQhQqy1wM08rX0LuLmW2WwOK1GlHscKMBSuzUHfEi8AEKdQn+PhaVV?=
 =?us-ascii?Q?IPOLRNvG4c3LQ6Hx2E4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c74fc0f-737b-428e-2d09-08de1bc1b556
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 16:46:31.9617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /socSe5aaK+dDk87TCJYVqpwkzUESP9MdiwVkHw8YE9NPGWhm8MZSoEK+pDj6qLr9ZnmtYM0VUv5jZFjrpD+9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7188

On Tue, Nov 04, 2025 at 04:02:59AM -0800, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Switch to per-device reset map to allow reusing the driver for other NXP
> block control IPs.
>
> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/reset/reset-imx8mp-audiomix.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> index 18a7f68aa59f..745b7e22b954 100644
> --- a/drivers/reset/reset-imx8mp-audiomix.c
> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> @@ -23,7 +23,12 @@ struct imx8mp_reset_map {
>  	bool active_low;
>  };
>
> -static const struct imx8mp_reset_map reset_map[] = {
> +struct imx8mp_reset_info {
> +	const struct imx8mp_reset_map *map;
> +	int num_lines;
> +};
> +
> +static const struct imx8mp_reset_map imx8mp_reset_map[] = {
>  	[IMX8MP_AUDIOMIX_EARC_RESET] = {
>  		.offset	= IMX8MP_AUDIOMIX_EARC_RESET_OFFSET,
>  		.mask = BIT(0),
> @@ -41,9 +46,15 @@ static const struct imx8mp_reset_map reset_map[] = {
>  	},
>  };
>
> +static const struct imx8mp_reset_info imx8mp_reset_info = {
> +	.map = imx8mp_reset_map,
> +	.num_lines = ARRAY_SIZE(imx8mp_reset_map),
> +};
> +
>  struct imx8mp_audiomix_reset {
>  	struct reset_controller_dev rcdev;
>  	struct regmap *regmap;
> +	const struct imx8mp_reset_info *rinfo;
>  };
>
>  static struct imx8mp_audiomix_reset *to_imx8mp_audiomix_reset(struct reset_controller_dev *rcdev)
> @@ -55,6 +66,7 @@ static int imx8mp_audiomix_update(struct reset_controller_dev *rcdev,
>  				  unsigned long id, bool assert)
>  {
>  	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
> +	const struct imx8mp_reset_map *reset_map = priv->rinfo->map;
>  	unsigned int mask, offset, active_low, shift, val;
>
>  	mask = reset_map[id].mask;
> @@ -141,7 +153,8 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
>  		return -ENOMEM;
>
>  	priv->rcdev.owner     = THIS_MODULE;
> -	priv->rcdev.nr_resets = ARRAY_SIZE(reset_map);
> +	priv->rinfo           = (void *)id->driver_data;
> +	priv->rcdev.nr_resets = priv->rinfo->num_lines;
>  	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
>  	priv->rcdev.of_node   = dev->parent->of_node;
>  	priv->rcdev.dev	      = dev;
> @@ -164,6 +177,7 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
>  static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
>  	{
>  		.name = "clk_imx8mp_audiomix.reset",
> +		.driver_data = (kernel_ulong_t)&imx8mp_reset_info,
>  	},
>  	{ }
>  };
> --
> 2.43.0
>

