Return-Path: <linux-kernel+bounces-866137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6375EBFEFAB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C69274E25C5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0FF21B195;
	Thu, 23 Oct 2025 03:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PXJJdp46"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013030.outbound.protection.outlook.com [52.101.83.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0365B4C85;
	Thu, 23 Oct 2025 03:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761188968; cv=fail; b=fTHtnQe0OTlUhWDNu80qJPEYoH/4QVhlWv0xIURMO1lrW53TL3O0BNiO9Fg9qY8PfQUaxBNLPVAkNKVi3NZaLEclmiZBmIXlt7Sb/VfUtphgQeTDRYO6q5VHIMOCg3wLN8uh7eq4RJBDDxf+B5G2uhwe7PjAQIAhjDhSdbPGYLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761188968; c=relaxed/simple;
	bh=Dl/vn2SLRGpfxBw4d84UQqUhnLqAg2Fbo1Il12sUCPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A+vPJ1kY/qQtuPkWF+Kco0syBEKXkZXYX78jDXF5BEGDGAoQokHmMpiqI7ZYEJgXIZP37GmOKH1FcbdSAt9scsstJasucOvW7ybWfYE3Wq0BqcZdggZegii6SVJ7cbzWZMNTcrZJIvv+LbDm3qGNQw10SwrriLHLNXfB1YDWh9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PXJJdp46; arc=fail smtp.client-ip=52.101.83.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZizyn+owi+8cxAkWQxNAjUt0OVdF7gJCATK/H6FhByvKEbJlENok4fLa7+U+losBkjIgR11cEiIA+oLZ/IBv8eGF4wMQEspO8fkqtIALc0Dkn7w/frZxzr7ZSTqcC72XDqAztOs37y4YCBZinAfD0YO2P69eDpLf5SgozPdZkIRQ3EaSnDgIHTbGt0Cbq4w8B/VTia2ZCiQmQaCJ23kbFotnDjJOEnNHrpm2I57moOGX6lVGbvOxKia6a4q2vwJ4SrSeZWB6x4HCdk9qO/Fork6QGmrhtD6+qIOfQ61ZKSBjip7oZe4DYVVZx+3EyR+GwFbMiiKYe4fWcTTDsGXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jfPRAO0qHF+F/p0itrzMb8m/BJ9x1zpOFY9BCPauVw=;
 b=J0A89fnO0UwV+zGdgkJfTi1Vmmc2PePKAFdn36I+78FEaTS9tMS/w0YojRlAXeA9NGlBGZLVkSL6T0ZEYZXgtjWT51JJ/KcMk+Kcqv2bKr5aHEnWlkzho8xtrTqn39pZwZd1dWzqb7bnDQUwhPIcgqkU8PJZBEyWPTC+SWl1fe+Ve6A6n3hpwYLGMdgqTSDpB7whxjtLLCkNoED/KV4isVSaTBlet4rP2rUl4i15fZtEeqcyWGV1d4HMwFnlQ083/YbCTp4ULhLJqoWJM2Y2738ZcTXyzTCEWLmFHTT14EuWbewWyy8o4SryFVxANjWsd497GEkC3BXOXL6BKRiL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jfPRAO0qHF+F/p0itrzMb8m/BJ9x1zpOFY9BCPauVw=;
 b=PXJJdp46EWfLMoe9MPvp9uP/azyJLsHIjxpeFhEwaQpgRXL4xrJVE/ey+fRDoKvKTEK08tGuYTMaD+dEARaV5PdYRaw0bqHzJNfIq4AH9dMhMTv/k9w+CZ7fCNUclcKXSDG9cAvl8tZx+9Af/ZNqIp2tioBoiGz1Xx1dTllDoZiLAY6GPNgz2zhBdIyyCMaqOHOPXP4KQLwOIXihTYkfkzMoYYEf+iAbMqDaoZhrq9VMl5b+MG4iz5MPR1ReCRUKf+ZBYdQ+P1DhsbTZ0hZtyERRVPOXW0tyAjNjRWdpKriOd+2cNCd88IbJimh6N5XZQDJlTZ4AonE3Ymi0t2DHqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB10784.eurprd04.prod.outlook.com (2603:10a6:800:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 03:09:21 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 03:09:20 +0000
Date: Wed, 22 Oct 2025 23:09:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: imx8mp-audiomix: Use the auxiliary device
 creation helper
Message-ID: <aPmcVGAtCZNaWnFo@lizhi-Precision-Tower-5810>
References: <20251023-auxiliary-v1-1-0a16fa4c3cdd@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023-auxiliary-v1-1-0a16fa4c3cdd@nxp.com>
X-ClientProxiedBy: PH7P220CA0105.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::20) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB10784:EE_
X-MS-Office365-Filtering-Correlation-Id: 697cea85-8f28-4df4-1277-08de11e18f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9H3uvZc7CwCCP+2/Hjx7c9AjJqT43P99TndFJKIZcrFm/b826yfPAZsJblT0?=
 =?us-ascii?Q?b86bg6EoZ8UHox1khbqtJsi+oYVQgl3c+57D3VKdMs7YG4AzHgkjnN7DpGEA?=
 =?us-ascii?Q?sM2QTU9JUlbyK+VjMpSFB1w/hPtcF3Yon/bFqd78enNXXhk1izJps2SKvvn0?=
 =?us-ascii?Q?KNyeBorVqxxVikwyZmCdtNdYZqZjQ/t4sED4fDiHf8eUCfutRE8fLQS/sYbr?=
 =?us-ascii?Q?GQPRlb/eeSavbxCH/8DgyZFAUHjtoIcAdpyhgG1KVSdZld0xVxwWD6/1NwAx?=
 =?us-ascii?Q?MV9wl3iym1qZ2eLsWLpC3w1+YOg+gLLoltejnRjIKoSPVOaN+BuPW/aniow/?=
 =?us-ascii?Q?A1qErimJOCJjs1um93lJa2Cej0/j3sw2r/likF/jqprbobAvqa9vXlNGiIX/?=
 =?us-ascii?Q?paStvbHV+ZXGApBH2+y4CEhOoiqG87mWXg3/9wze2cGgTEx323taAIIQgpWZ?=
 =?us-ascii?Q?YtmBCpgoLa4Z6irxYAD8Zte133MceVewZLzUWVgA17JzWvRODpCr/bDtOIzV?=
 =?us-ascii?Q?4CfEIJKwDXussUL9AzA5Pz2mXTn91UjsxefrqvVIPMX+WWOlrMRK+PyLWe0F?=
 =?us-ascii?Q?q6TqLXisTYzdkiVclNslRWEGVe2jIOS7WcQTrpqiYeH+e5+iQ/Qtfd6ea97d?=
 =?us-ascii?Q?V2cVGLohB3ZCLvFCU/k+hDK7AKeb8TGXkfGKV75Y053nVUeSmBbmYjXfzpK3?=
 =?us-ascii?Q?/b/MUW4qdsU8OyVW/qEqMBCyJy3odLkTvj41ea1SHNZrgZleUT+NDUBC9WgF?=
 =?us-ascii?Q?q621IgSDBLRwm2UcZ5jeDsn4jC6kKPfT6jJpX402OZowjzGMk4bbbBairbYW?=
 =?us-ascii?Q?v4KijcEwMbWBNRrh/LM4V0AW9/UeQskPQey5puKdHjLB/QWbnVA7Zbh9Bku1?=
 =?us-ascii?Q?fFhnIFqktWNPZeswBuwPpS9EZZ6y07a5HsN9IOdcfxmuQYlmpU32sDFaW3w1?=
 =?us-ascii?Q?Cn9/2rK/K21QfScStJKeqMzip6V2F+3F6npV3pKbgOVQn0vyHcfjnuDi2s8H?=
 =?us-ascii?Q?6PwCyelQsu8YZQJsKA2DbPTTTVzMEZGP4hrr9duwUcRwFHRSl5bea1+AAvOa?=
 =?us-ascii?Q?hiqWopz5ApnEiKzZqCFse6pObZ9+edcKuu2oOds5IcsWAMcBuPag6485fgSp?=
 =?us-ascii?Q?xR1EkJiBrWEwKKgRKWYH+J8ud11BY2HbQ5vNE0nVce3bMqbE0IdzjN60PeOA?=
 =?us-ascii?Q?1sUEM7oUjGLiHPBVCZU9KZjBpCcs59B2VpKfOtqTptJ/aDIAh2Q1//F/IlmW?=
 =?us-ascii?Q?pbgudj/gVcT5ehgLngoucd+RyVxTFxXNp/RYCshnqDEJMzV2GwDVFpXsIR7k?=
 =?us-ascii?Q?vSx+i0GZJ4TA+j92B31cc/1t/d/gAEkbZlXRBRDENGPjjTmfZmXeFm6gSHQM?=
 =?us-ascii?Q?Br5MgS3M3+E/5eJWca5KpTCnUDT83fwcJnZubUtJ3YPLRvS30so/EJRPCNPm?=
 =?us-ascii?Q?YJmvm1iJfNQB8o2AHU55VwSQEPSzjJw1u7HaLZYvm/CEgcsWM2Ow9Bak8Pcc?=
 =?us-ascii?Q?8dW0gOo+aF/DssoYsUqaOLgykZhMg/v5da8p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZKPl+ssO6MDZ/YL1rzldLxeRS+ejbDOlmiI8j7N6frJCBk7pvwuu6+KP5HQV?=
 =?us-ascii?Q?vSYeTPV6ERQcVZi0d96nXp66Y4SiWPd3yEgGDQB3YBwuUMo6nnmxrC5Uf/bQ?=
 =?us-ascii?Q?3rfCa8agWTwetqACFiTTBiVkROtEcfkqwZLfXOpCw8p8bUzlJgCTX9SFgGQ9?=
 =?us-ascii?Q?HIfSSmZlm7qD+BQgHbLWm/qyomYMnu/SIIaAVqdh67nkEcEVhKtjSldNmNiL?=
 =?us-ascii?Q?jry8Kk0EUGsCKYBXNXO8FHSFjlOpUcHufZ65UgudavBhB6lsGiv6+Nla5Epo?=
 =?us-ascii?Q?Q09pNjQ/JKrTRI6iPboSvP1cAcUbxEonz+kPiMrM3EIUYmXyyxCrT/ypk/OO?=
 =?us-ascii?Q?QrqkDF1qwT8C178isc53V9lP7Gz76p3AMitZ7wzaRQSKESm92Wfey19l31Qh?=
 =?us-ascii?Q?jo0bXtsvoYRYXVoI9i/5ew2zoWyALeBfTHctqjhiD1c+aYpjdGV4CjXs4yDI?=
 =?us-ascii?Q?QlnwF4GaBbElmzYsHpiYYeJ3O58BKIKdhmtHb/mGwg3PjBp3aa1K/qxBavZH?=
 =?us-ascii?Q?DHIc6/XefEdkG24dPw40c/XXW2y0ftrpK+NBIfEbi5IfHWp7f7STpiog4ZvR?=
 =?us-ascii?Q?tWupyMzycky3yfnZ0LdH6ph9wcjqX9Js31ix1I0/gP94okXR/7lHyl/naQso?=
 =?us-ascii?Q?QVhN9uePp3ZnjHC7EPVtGnXZNR308rB+P8mIPKjlenZ8ELiEuaUw7iobq+5z?=
 =?us-ascii?Q?k+v+dpMdO0erJoy8PfosUdSCZwS7hwjPh9rRtpu1tiEL3N8QbPYloqAYhpgg?=
 =?us-ascii?Q?oF/JWDlEVh1WcLp/62/EFcc4fY2T7xNIiL3Y93MBiN83SeIHe4r6Z5GXeqmA?=
 =?us-ascii?Q?87gIlplMtFxB+bimFL07J/aQs607YnWsZk5Bl1hw8uTe+kUZBj9C53hIkYTQ?=
 =?us-ascii?Q?aFUfHXaopo2f6S5cVUWcMcPO12v2KHqOobT5+K+zCptDa9KQDcPl55d3Ozpv?=
 =?us-ascii?Q?FLFRyiSKoOwfqbeQan7IMBQ9S1LMsHnL8ksjuOCfA5hlE4l1BQ/Mv+l2H92N?=
 =?us-ascii?Q?45X7j0x+IPoi4AKczYs6y9S2SO6ehz8ncVTA2xHA4gV5J5bNsPADRjrlzfK4?=
 =?us-ascii?Q?XIdIvpPi9CO+bAL/U4faJwRJnG/s6/DJS+yiPNb5Q9fIUBv/OhFe2Tikz7ct?=
 =?us-ascii?Q?XzrcWFYJ6OToM6a/d+eRvZjOwRymoIKkKPpw7jUhCFoJwj686V+QMi/B0Bbs?=
 =?us-ascii?Q?FLKZqIVgfR0N+VmIzUVMHotqOG6JDgMjOeUqUEdIAQeGsv4YvfS4Rcrz1o7q?=
 =?us-ascii?Q?wxONsQN7J1HKUiGkfBE6gtqZmpN1Ph9eNpZ+RjPrDIDBDUc5yD0isS9Z4H5v?=
 =?us-ascii?Q?EajSzinuM+uJXXiqfM8NkH7u423DC7ij8SG7sqOvW2V8YKf6Eb3shMHeWDf+?=
 =?us-ascii?Q?8aHhj3MvvoK+ZX1QOgwe1ne4foc+QvMlgsFUbUpekSDcsZosrzdXADpaMCKl?=
 =?us-ascii?Q?yXDw7XknG3jsqXgYvKW7vTBPX9NKuxPpBQaU92gULGqVJIwT26hcpepY3221?=
 =?us-ascii?Q?tr98vAKxHxCaVo9GL8M0ckVOIoVNwE9hkc0QgzWn2ygJkdc+qkfe0tb1QHsJ?=
 =?us-ascii?Q?2c76EVYYIJO1IVJYW2/KMjyZ0movMAyexLdGVjIy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697cea85-8f28-4df4-1277-08de11e18f98
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 03:09:20.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DL0chKX1UISayUrPRZvx0UFnaU4CUfxyD77dGOfsFP68Nn/G1Smcu2oIRRL9k0D+fKanWuhy9sjdIEDxXJMRcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10784

On Thu, Oct 23, 2025 at 09:49:32AM +0800, Peng Fan wrote:
> Use the auxiliary device creation helper to remove some boilerplate code.

clk: imx: imx8mp-audiomix: use devm_auxiliary_device_create() to simple code

Use helper function devm_auxiliary_device_create() to remove some
boilerplate code.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mp-audiomix.c | 39 ++++-------------------------------
>  1 file changed, 4 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
> index 775f62dddb11d8cfd17a4ebf7a677ef399c5e617..131702f2c9ecfd693af47094fe61b486ae6e8f6d 100644
> --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> @@ -230,50 +230,19 @@ struct clk_imx8mp_audiomix_priv {
>
>  #if IS_ENABLED(CONFIG_RESET_CONTROLLER)
>
> -static void clk_imx8mp_audiomix_reset_unregister_adev(void *_adev)
> -{
> -	struct auxiliary_device *adev = _adev;
> -
> -	auxiliary_device_delete(adev);
> -	auxiliary_device_uninit(adev);
> -}
> -
> -static void clk_imx8mp_audiomix_reset_adev_release(struct device *dev)
> -{
> -	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> -
> -	kfree(adev);
> -}
> -
>  static int clk_imx8mp_audiomix_reset_controller_register(struct device *dev,
>  							 struct clk_imx8mp_audiomix_priv *priv)
>  {
> -	struct auxiliary_device *adev __free(kfree) = NULL;
> -	int ret;
> +	struct auxiliary_device *adev;
>
>  	if (!of_property_present(dev->of_node, "#reset-cells"))
>  		return 0;
>
> -	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> +	adev = devm_auxiliary_device_create(dev, "reset", NULL);
>  	if (!adev)
> -		return -ENOMEM;
> -
> -	adev->name = "reset";
> -	adev->dev.parent = dev;
> -	adev->dev.release = clk_imx8mp_audiomix_reset_adev_release;
> -
> -	ret = auxiliary_device_init(adev);
> -	if (ret)
> -		return ret;
> +		return -ENODEV;
>
> -	ret = auxiliary_device_add(adev);
> -	if (ret) {
> -		auxiliary_device_uninit(adev);
> -		return ret;
> -	}
> -
> -	return devm_add_action_or_reset(dev, clk_imx8mp_audiomix_reset_unregister_adev,
> -					no_free_ptr(adev));
> +	return 0;
>  }
>
>  #else /* !CONFIG_RESET_CONTROLLER */
>
> ---
> base-commit: aaa9c3550b60d6259d6ea8b1175ade8d1242444e
> change-id: 20251023-auxiliary-3998bced9cb9
>
> Best regards,
> --
> Peng Fan <peng.fan@nxp.com>
>

