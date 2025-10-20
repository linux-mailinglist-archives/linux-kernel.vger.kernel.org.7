Return-Path: <linux-kernel+bounces-861212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0DBBF2156
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82FE64F80B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEB9263C69;
	Mon, 20 Oct 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cFoo15rx"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDE8242D98;
	Mon, 20 Oct 2025 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973841; cv=fail; b=Ufn+u0Kgxu22tViLgJktYawujdpxbf/nCfUT6DSWutINXlgWrXYcbIvXK+Uq0Jh6+Bk5tlhJeVTa6BnmwLndyNDaK7U674hUzEwC+zP2KKS6ayO7jTvqgiVY6J6UcRz2G+d4x2yAvQ9qGsyvIAxjwRe3HPjbxZSieX9UC91/m2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973841; c=relaxed/simple;
	bh=sJ0q1AfcvJR6oIhwh+UKj+53zKXPqQoxOVve1jsxQfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EEQ75H+v+pXGRlNdS2QK9u7U4EYF3Xe/gnCZS4R8dVs+oX3rP6JJtImEv+8jKFWY8eOX7ijwgPcr87M11n8pOG57ScsPjg1M97UdMVnInVfcfATq6oPcAV15Z5KrzNqsRLavVLw43tekgMVegl1NgWFAsXx/L4WrwK0ygGG+us8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cFoo15rx; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndYZQm7rYSEofqIP2CyvvZTE7VgBNiOAkzJqNPzJj2LuO4BKSruCTA418xjQln6Qlm/4NKEBy5ZIk80HfUzraf9y/egCvOILfy01YjoM2nGcqj3K0kif4seZcL3/oMRnOTuEqytKxnIOQweQK9co86qLXwkK7e6md33NfxvjXF1EzRyhAoDqSwPtk4qTWN3MV3Zd2sGDOZZNY/HpHS1noQT1/qjAf9uYpC6zxGG2gp5oTSj1rFT1dGbDD01gNZETLejsdHeEJRdtz73vD+vIpKNTAeIZlriuvSOwoHsa9nfjbiO7YZrUwWcqevc0AmBI0CCgmodq2jcPgxQaNFkqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiy9wK565qGFPhSV+X/wdmYfkGhWaCPuIiMcDkQy1to=;
 b=mA7uHzrZaNlGuPkhVxL41bSDXekcEQV7ReucNra9fvCU95k/JJx6eyFpJha3l98ZUGbhL0N+u1HbrSvzEX3No9dDan9VZu+nWi4fAG/uha83bY5f6OCHAEtu7Fhs0eXLX2Km9Hzq647XwSi/Nb+lfIELGGGiuamB4GDbE6H0CFxt1pMFvvhib0Qsn041a3vDNdDsfx6u5ZAQY8cv01yTmgPAIIwsKLMAAp8CZyqM4H0ebhOFCMlN31to+SNpQh2FJshH0ayhSCYHAr0r5or9SFfpr0PZEsRYDK7CBAZhm2eiHetNaCq2tpGTjh+PzxiObsfWYQakxY3VagjnLymZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiy9wK565qGFPhSV+X/wdmYfkGhWaCPuIiMcDkQy1to=;
 b=cFoo15rxJRIlTSeF5+8Tq9f9C5edbbYkr2kMi0ztsXj/VPT2aJQoghD0qmphXKv9MzTM4KwgBFdzvmGIDSYzSDLb0iYH7p/A/x/OgoEcRqgFzYwb7PWeZMpGPXfGWve7dXRhe76w6baf5Bww7OeRy9bPyWK67aT3aOGF4MyheVBNrfIts6dj6issddnJxu8r5zshkchlX0PEy2C9pBd+61IzO8nlapk6/Y0QmMYU0oqywx1qIppUCCyqsccSIQVgpfOvkXJnSUaPjg8FrVAh+Q0NUKslC48OvbXvfe1QFHnRhKLko5DvlinjpS4YjbIhPZSSBksh6Kcsx4+93sgrUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by DB9PR04MB8235.eurprd04.prod.outlook.com (2603:10a6:10:243::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 15:23:56 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 15:23:56 +0000
Date: Mon, 20 Oct 2025 11:23:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: fsl: add TQ-Systems boards
 MBLS1028A and MBLS1028A-IND
Message-ID: <aPZUBJaY3gz4ysT2@lizhi-Precision-Tower-5810>
References: <20251020133536.303471-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020133536.303471-1-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: PH0PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:510:5::10) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|DB9PR04MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: e65c407b-50d3-4f93-1626-08de0fecaf71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NeUUcLMR7bN90KxSj31xDPdYArwJHUg6/egyrmHRWpmVP8XfkBi8kXxsUEBK?=
 =?us-ascii?Q?hDXkgQHt2VeZgyMI9e8rz6nxGDf1KOGYYKmDwyFxBqXwWqeMJCWffMtllRcb?=
 =?us-ascii?Q?Vz1GftDHYe9j/sqJqgLY4jSrWNjuM64oBp5kokY+BEepaKUHTmRFQOOUX5R/?=
 =?us-ascii?Q?WTkDgCihfApefd7VE9L/BlwqzrdtYgh4yNBRlTtspZSuYsr4g/gC7y/+BKjE?=
 =?us-ascii?Q?SZrkqZipaCuieUpddUaGnAElhWT11A/rIlNAgx84mMfR8zq9FnZBo0eyI0nc?=
 =?us-ascii?Q?jU7kaGxdtSOqHYkD8pHSbQBgdsUiJNNpSVog3bwPNBhhjZFqozlejqUT6x/p?=
 =?us-ascii?Q?SU/ZnjKIxba+gYo+DLrlQcfaH/Pb7wi19P/b/stmji+wHVJnbyqqjuRDSede?=
 =?us-ascii?Q?nMSTLQQL4o324crRsfRe4a8mKLNQbjwH9dn8DidR78rr3qASeMoay08bkqju?=
 =?us-ascii?Q?HWxZ/4KGiuOf1It/pW4hx1Htj701EA9R+N9Y12BCaAqz/lDP932lokLA5OLx?=
 =?us-ascii?Q?wS0N1HTmHuomSQINiPktbV7JMsKQiwQoH2AWMGllP6WTIK+AKLeA4XAxXkfl?=
 =?us-ascii?Q?Kg9xgy5Dg8DUDqzaDfx8J1JsVS1oVEO6jd33KteTAUFCv16husRS5IQxfA37?=
 =?us-ascii?Q?Z1s9qZifFTrQW5bOpo/Zj1vH/4dEyh7SFYZo7oOldigKBiNzLkYzHTJiuIP/?=
 =?us-ascii?Q?s1qNJDdyBAQ5fb0n4fIePYAfKvyy0TXciJVOeCwq+7ulXv9ktrt6ylBvBlON?=
 =?us-ascii?Q?L/6zNjnJ6e2JjP9smPMmT9tWgGpZCSN9f4u1uAasmA6hsP89ZG3gk6S3ncxt?=
 =?us-ascii?Q?73n0XZ29KsQCaOCNxvErMsk6CMg8B9ncRxSjla/qp9MmXqCZNUc/tcQaIUUz?=
 =?us-ascii?Q?HpKLcirPQr5r8WgbzDtPSCWP+/ScqnjoU0W2KU4Fj1G57walUcANW9ERUknQ?=
 =?us-ascii?Q?LhvYS28FjN4O+FJPIOTe6DInm8ccS5fcxlNqrpBwneMrtJjc2mhvpk7COcX+?=
 =?us-ascii?Q?HDX9Q3M3Np/yx2QHzJ69Fmri+ab79V4B1slDpg7Z6WRLmN3VQJFhy65xGdNk?=
 =?us-ascii?Q?VWA3GZqC2h/k4Ilym/6jTf2MZbhETDm8l3Ed2RSpPcju5iQTHH9uc/zIWfn+?=
 =?us-ascii?Q?akqpIe08XvJfzeXcudaH9AgnwTRBBzphjIs2LwtKVpXqtSzK/lsu6X6Z5xip?=
 =?us-ascii?Q?Ud485pS80p210FsIFRPgXAk3yjxfDD7KPurYlI/S+IoMF4ZDM7YoQ+wgi2uV?=
 =?us-ascii?Q?fCTrK53Nu3NtrHqa6UE1Jo3b6oSCmsmWlDjmDsFCup1RxGQn5DqNR7eOHxnG?=
 =?us-ascii?Q?1/BDnUhjpq5hsFZCWZjqwClynX66ddZWyuq9KnkFG+O5edYuYjyTlDDjz85+?=
 =?us-ascii?Q?1ZBt8PLLvt4C/s74URFik5+tDK8gfyLuhJ9fvMGFHcRvL5XsrFLomlfHQYw6?=
 =?us-ascii?Q?oMdPnHFB+5KAoRvPSyNGm7BEQchB8u2pq1tD1qBLLfm/iOnkFHZmaIs2b427?=
 =?us-ascii?Q?vlSu2MD/pAnKio/cPCZPq+3dl5dSdoYCM5DX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MyvPzLry3Xinf27iuAIpm1JgziVif2f7C1aKYXzttZ/ou9sawPks5MTz34Ao?=
 =?us-ascii?Q?dtOq2GNTawNoQ9wCqLnXu2gT2zptxgxKtZcOV0GkuEtgUScgkQQucZ1wmOaP?=
 =?us-ascii?Q?HFtFnnMX+uLDjk300naj3THm+WDga071t9MLsMS+QDl55WOz2ueibjq7gwJh?=
 =?us-ascii?Q?LBiiBCxchf39upjcfz2tDJH0KxTYuky3LqXE/ReoxDVdg2KilLg9YRpVcQea?=
 =?us-ascii?Q?GVc72sKnxnHjLDTokKuTl3qIYKZV/XAIeR3kXspmDkgmQ4CYtXvj9rM5JDjk?=
 =?us-ascii?Q?iMYkwGVJUl34epI9Q8r0WXSCm99MVqeDY7eFTbCG9RPHflJDYf5TuoLaHcYe?=
 =?us-ascii?Q?HcmzyLUR/IUR41wARG9uJ7TlcQ1XIFTxJCLQRoBtWieEeYEz70VD5MZ2eZfb?=
 =?us-ascii?Q?WhNn3wcPMLT8zGgL/RVmZFVmWVPWlcFWV6yPIQEgO6yePUAOoj5Qf231g5oE?=
 =?us-ascii?Q?ai6dQfDVTycAdgb7WyjhWOOG4XPKZXH5M1XH7pG5/bBSd91Nc2I+Qwq8rlEV?=
 =?us-ascii?Q?5ro+HOPlUDgSDqmUcBS2WlnLqxL5KOxSzRN+3mN2FZuvYhAZNJ/F+obNIbDA?=
 =?us-ascii?Q?aSlp60LP6/wuEHOPVMB9PP8hdryusq4i06AFOpc5y+TcoT8SyciROWuw++S1?=
 =?us-ascii?Q?55V/QKYn3I4aek5LC8k77x2861+lWr6YSojqNa3R634GBtqBDdw8LzVrEzh7?=
 =?us-ascii?Q?Xu8q6+JMSOuj3bFjcxtBJ7rxYlLPgYU11+M5pfpTHYJLmODTNe0tF+P47eat?=
 =?us-ascii?Q?CFHe/93xTJtqdVTQvo6DnM94SUvic9jNEC1e97OIGhoxWMvSaT789OnFXR7l?=
 =?us-ascii?Q?x1pViM4VApDzC0XZvmu2a2OdHtkyaBDAUnZ+U2r0+3ZkT0yIsljL7w/Yg7IJ?=
 =?us-ascii?Q?dOq6Rz2eP702hzFRGiG94uPPxQmExYk8zxcoMXL7EYPVlwz4/EhwpGgvOjpl?=
 =?us-ascii?Q?beH8luZbftCSJ+tPNbEa7uRQP03U1aFLqaOmkz7IOjDi7UwH+u4f/aTLcx8b?=
 =?us-ascii?Q?HmjYJRczWIAmqzE4Qtf21OaFAEJvbhzierxXApJvv6TMBF0O8XnQusfZni3n?=
 =?us-ascii?Q?b9Sycu8LWFTemVsY9kqxQTbMwPUt2tckRdbCJuNg1fPd81lf0JBkoQ74yGQ5?=
 =?us-ascii?Q?tbBAk1mcFSBskI10rXSQcVTBKIBwoNCgcPGmuvSbqdPpl4r4ABgs8Pv8HZ1Y?=
 =?us-ascii?Q?1DZOCiaAD8RfN8wCks4z7oHGEx1fisaWr6ci2lvq76KrUed7Hk05bwGyJInk?=
 =?us-ascii?Q?5vLelsD3VyrgnOpZa2lvDn2H0PZvZFPvn328/mlQjciUL7SEck1EJVHeogb8?=
 =?us-ascii?Q?EY/jCfagpJGb1LZPGcN64wj64lACbMouN/xNR4NCg1MrNrnPxCxCaLGB1TcQ?=
 =?us-ascii?Q?xoAMXvox4W7hrnTcxSEcw745Tqnkt+1jMoeylF2n01b/w0G+NZydirIMe3fT?=
 =?us-ascii?Q?cFFLsykpiXCoyGVolDxOR7sz/vA3SfoaVAVIZzGysVZtLfaubqx9G0qQS5Y8?=
 =?us-ascii?Q?Y0qVdJepzzIP01gfjlrXzk35dryFUGcHP2k9ji3y23UuHl1X0JJrkkNebNAN?=
 =?us-ascii?Q?Sym/muTL94V7OtQA5fY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65c407b-50d3-4f93-1626-08de0fecaf71
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:23:56.5647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgvAEB9JXlXGFgo688MMNp65qXBU2EP7MLCpuB3z8oDkFOmSOR22Ozk8aHjrNid3Rzf7aa5HMibvDCfKb1aJxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8235

On Mon, Oct 20, 2025 at 03:35:32PM +0200, Alexander Stein wrote:
> From: Matthias Schiffer <matthias.schiffer@tq-group.com>
>
> Add two mainboards for the TQ-Systems TQMLS1028A SoM, based on the NXP
> Layerscape LS1028A.
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Changes in v2:
> * Fix indentation

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
>  Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 34c822a52a5e3..12bf25fb0a97a 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1665,6 +1665,15 @@ properties:
>            - const: kontron,sl28
>            - const: fsl,ls1028a
>
> +      - description:
> +          TQ-Systems TQMLS1028A SoM on MBLS1028A/MBLS1028A-IND board
> +        items:
> +          - enum:
> +              - tq,ls1028a-tqmls1028a-mbls1028a
> +              - tq,ls1028a-tqmls1028a-mbls1028a-ind
> +          - const: tq,ls1028a-tqmls1028a
> +          - const: fsl,ls1028a
> +
>        - description: LS1043A based Boards
>          items:
>            - enum:
> --
> 2.43.0
>

