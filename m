Return-Path: <linux-kernel+bounces-858183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B0ABE9377
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C411AA3BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248022F6938;
	Fri, 17 Oct 2025 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W3OOrgkD"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011049.outbound.protection.outlook.com [40.107.130.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78102F6916;
	Fri, 17 Oct 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711610; cv=fail; b=mYWFhfNwoCLEv7cvuHprzpkptn7xkYa9UshJQQsCATRA1SOGnSijpDicYIaJ+XUHLOjHngZAg1elh3Q6UhlkZPeFUkMAG9vj9bAkIY1xsusqKic7fCC1nQmMnjaTnygMODQ/okFnXhouM0nRtqh021v4gVfwYqwOWVAw4CLBnCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711610; c=relaxed/simple;
	bh=OyGmErxeZil+wBGpX0kD1peH7xErhhIB60uDye0kBmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NyYezpCKV1tmXxZ11NngQjxkC4N+G6c1rJ8MyGWTySkReENgbF6R752bWK/dh/oe+WrfihnP0w8/vv2FMS1Fnx2AXDW3RTQ4qanrFypHL2IWlxZEHnErr0tyyFBQI9BYf6f43jv6MIfXtHDoSVPKprgViq4ZQiMzsvkT3J2IxKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W3OOrgkD; arc=fail smtp.client-ip=40.107.130.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFF9LSpFeowqCll9qJi/YZHEahKFUbY+y/cHlmYNWCBd2PaMRZMp24nMYS8hjZiMjNObCX1v/JeyYsIv2SEkr3NKvUEU4enATMhJQrucZcGOvgFdn7cK6fnsVgRUCUcO9PQf+CPGrc0364xDVbcpG47Wa33OmLVjm4sP2v8GzcXEgQAU9XIr02OzKid9PC9Bvyc1EeT2aEOo7n2oGAJz9dpsuSsgV8zTQeEGeM6H7yQ1EY01QTB3bHjEpW9ijO3dVQSPXDXLqRyC+F5QEp5ZUqXHYIB8fNdduRv2QbJTcXvlIchTCUzVj9DcJjGVSAguqQz9fq8yQhsC+J9HP8xI6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NGVIyqWM4zcFV0z/wE5LwqWc6cS0OmWQN427oN+oQQ=;
 b=AMuCAqjr/p2Z5ddfpezE/stgr1vEUpkWiFgYyUDdjBhes7L/7wHfs0+HznuQcB1bJmSkCDO4UW32hSBmArbZfigmB2pSqjOJ2oZPhahoTLG2bjAehNLvJS/Ti2aqidjs64GUIw+8blmv0oeV6Xp29dDegSw8zOi7jVskJTZ/7A9CtiQX1JI3PkXmS2GdorRZV2cgUzXP5+bbuba+wQiH/R2RncA5PW2tEhGqrcCh0ZskLmQPtGjPjJPI0JllnNpWyavOLBhw9ayn3m7djFyYS1M7W3x1NidioL858tltZhFKRWg0U2ZlTF4Ycj646swIYq6faTpHSPRRABYg85pgoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NGVIyqWM4zcFV0z/wE5LwqWc6cS0OmWQN427oN+oQQ=;
 b=W3OOrgkD3Fd6eN16vqysT0TfqkgWf4EfhnPbj1yTp3cO/Y7O1iA6HIiLpCHSKBi6Jtkfwi4wKD+cY+j89EtVqL/ZCGiy/g4rbemrmGMZNSrSmnpe/0zXomuKHfz6o+OX1/+xmBiaw8htuZHCEIYD8Ffcm3pExpA1Vey3QA5qnbc3s6aJNOjM25QT83+C67wb95YxxSPVw9gz534m8sQrveXjx80y4obs3CdTf3OvPT+r4x4b5H1BPcnnLaWAddok6Hkv9M2RJ7q1eplxJ0c1S7agUZgTsL8/ZrwLs4nSim7Xo/x9Fa3DkYvVeCq8QdOjMnqf69nncW5mvEFAz2UYdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8527.eurprd04.prod.outlook.com (2603:10a6:102:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 14:33:24 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 14:33:23 +0000
Date: Fri, 17 Oct 2025 10:33:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 2/8] dt-bindings: clock: document 8ULP's SIM LPAV
Message-ID: <aPJTquVc8zl727bC@lizhi-Precision-Tower-5810>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-3-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017112025.11997-3-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: PH2PEPF00003853.namprd17.prod.outlook.com
 (2603:10b6:518:1::73) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: c3fd8402-b051-46e9-7939-08de0d8a2055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?us4EC/W6QI41txiy+4XADixWmQWxGQrnArBnelOLVKn/td9drwgJ8olmsHST?=
 =?us-ascii?Q?kFppm9wJm7UA6U/Nj+GibPrGbDDpBaQ1pr4HzXvztb2WmebgjlMufpc5G911?=
 =?us-ascii?Q?BAI/TwGw2rEH62aQ3BvVyD6GoR7+AL0jWorY9D0lpqxVlCGuc2yzE/Pgqx1l?=
 =?us-ascii?Q?dOBbpceVgsyOOBLzbvboduTcOvrkqfizgeVjuNVshjqs1EVxGQ6snX/yQ0Vp?=
 =?us-ascii?Q?kZLk4p8TyCJwLAAqqoqw4fhGljzcPegdJnd9IfoCORMZfZ8L77hxNsTfvvc+?=
 =?us-ascii?Q?i9Az1Jiog/aeWo8oQ8wYn8+e4TaJc4aqXBwTFvQUlIYy77nAfWlTFLCZs+Cg?=
 =?us-ascii?Q?MagcNfbDwSrEZnxgU5JeMFze3H7hA8eGkGCebKXQquuuVc2aFNJb1+OOR4Iv?=
 =?us-ascii?Q?6F54p7+C7sz5/X43eftli03bkzC1RDFkXrpDCbuRSCFaTGyy98qXoB8rs1lj?=
 =?us-ascii?Q?No+yPm7yvY0iE3jVBIvpqxSbhl+dUPJYVTyR8FXbDTrBAHzfRcJuwOqsmVda?=
 =?us-ascii?Q?WTvcjF87HTb+ro1UhDiVqlmOJ5xUczEHQ8yGH73tvs1jPJ+KtHMCxYP9Eazn?=
 =?us-ascii?Q?eFZwlod+wf1YC7fyEm/nZnuMnEHJwPIawLL1I8VIsokshe/nmSrApccfA+Fz?=
 =?us-ascii?Q?+RxEPr2U80nJjBdTEmOCcfsl49bWaTkBgg1OaZItRtRCnbuvof5Q6X5+HVnH?=
 =?us-ascii?Q?jaMXqWzMoBh4d44JfKH+ecdDP2nW4h/il92eoqVsmTtry+oihvPM3UFAxQ+v?=
 =?us-ascii?Q?iVIvOmXH4cOV72gWDdZRDdCgYf4dqR2pJFB9TAM6F2rEo4zGuAv3RhdArA/4?=
 =?us-ascii?Q?6f76wKQG/aHsdvkU9O/nKubmQYUX8j+AewSccrJhvWiCobS01Duq132N9ca/?=
 =?us-ascii?Q?dB4GmxFtIb437es8Psadj2w6yjiohwC6oWM3quLEIYZ09i2HxJFZiX1Mspu0?=
 =?us-ascii?Q?My+NCG4zyD/ho2jxV1HCaVbWUMVN7+0INnkD14LC/obDOjEPijz7G3KUDYuZ?=
 =?us-ascii?Q?xiqnpSM49WP1AxKTWH7BJeugx+RzQLrXETnS5djd2G1UlbhnkvhXCRDLgEsc?=
 =?us-ascii?Q?PtCJgGIhaj/OY0n96WO/QaRA1h6H0ktcvuCphlJTEccsstCdMztxIUO5nwWU?=
 =?us-ascii?Q?oq3LXt34MOKgUZQzmhaFURqrH82Se92TtPeE03goLUgXZsEWsIC/y0JYeJ7h?=
 =?us-ascii?Q?RaMaryB3Lk1cjoK8zVEXSNwCj+/FPlGcudwD40kX4jpLxZ7gYfgosAyYj/wl?=
 =?us-ascii?Q?Cb/sh52BJg9ppPC5wBw2tIk7wS8NruYbU+bDdpRNMugpNXu8cSaDCbBvzn7v?=
 =?us-ascii?Q?XkV8NisuEbLeOhcoer9Tu0nUQkezU0qbIEZSzxezq4gAnWDwvOkYAZay1VxS?=
 =?us-ascii?Q?6c2ksjE6QIWFmHXYoKAEGn5rlg+zNFuGdpkLoTLdgu4/95BEXQPvFYAdljZd?=
 =?us-ascii?Q?CAZ6byXU++JQJDGyHv8M2HOob0ImJgXVsU70pX/GfhDCRuanHXhw0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k3/GtIqcHsxSg0XjN6FG3Jfmloe+P6uHty7LPzPr2sRYLL73pZa40PKKMTxO?=
 =?us-ascii?Q?ytKQvaeJvBLwPKs102pC38he2mZrTI7ZRxwhh54TKWiMCEiT7ZB+Yx6FXOZ2?=
 =?us-ascii?Q?OCgS2Z1sbUDgHc6pp5NbeKoYYx0obBYnNVHFPdl6RckLC4lu/JQVr/euCIdG?=
 =?us-ascii?Q?IMi9r2qPa/krAqUwhWAcna3QrismDl4IJj0LxShxjODUKTeabIm0gluMeTTG?=
 =?us-ascii?Q?S6Xr8ylYui6ZWWfCT0/2sFGQMh032qGVzLsjmgzfINHNS8ld1ynXMGa9DROL?=
 =?us-ascii?Q?v4mh1W03spMJdzLDwHWJ0PEZYpuTCr34Nocx7rLky0SwQZwRpVs7V5gitPCi?=
 =?us-ascii?Q?n9xK2abe34TFYvdCJqeNBg3iHlnjEmqla+zBh17ZzMzvKDqEx2k/br+/l5De?=
 =?us-ascii?Q?6FlMXXpHCRKKCvDLYB98YcAU3KVMgHblNrpBZuI/rSqkUY5A3YKkaiLMuCV8?=
 =?us-ascii?Q?YaaIcwO2diGUAvJ7EKLO1Lynr7e7maZkzs3FtzlaSQWdW7QnlSxNEr4/ssne?=
 =?us-ascii?Q?Ube03NRWzPHP70eQhqgj+iQNvN0TsPA+P0Mq4+a/3rT9fkB1WuAO4YYDsu+i?=
 =?us-ascii?Q?sWrhLieBW+xORT9TfLBXg3GZUCPf6NeOlvKPDWlwcD6ewyGpZBlIBtYM2fKQ?=
 =?us-ascii?Q?Y5NxloCBsxgXnVvug0AnMlyNNIGyAAkVCjEoVMEkaLho21n0onP+zsh84lZ6?=
 =?us-ascii?Q?TJSjACKLAdoFMESDXyN1ASmmj6kJNPWG/70jkiBODotuzDUQluWPLmZlbUib?=
 =?us-ascii?Q?qaWfk06lh1AA3QboFRrwGVb0WkewpVKMzjQXGD2szCg0iXLcAboHpp8rRnr+?=
 =?us-ascii?Q?/VVBhMKD8HsWMRzhkTLcpbGLXQVQDOF3QnNjeuwQIEyOsmTRhPByihu7fgj1?=
 =?us-ascii?Q?/ifvCMxS2n3jtI+Wd4UXKn0s7L7xL7xp2j/0oRzoU0stXzktVhMLUEz8m+wa?=
 =?us-ascii?Q?5BW/A9RFMYnDRmln2hJBVBK3irwQOS+0UWyn2QRqzuAF0sTGgv8A1Ym2ig26?=
 =?us-ascii?Q?udJW3oleQsGdCPqNGKSHydQtyvBazFuPGjEQ377txjyIcpQ8PfLIA74TblYm?=
 =?us-ascii?Q?6P67rujYfRM/CLScRGDl0FWY3hQef0x3HOqt9F1f15WCJ4OwwFDuTAeRmd/G?=
 =?us-ascii?Q?sWlHwjt8aprfhkd38Nlwc7oV8QKGJHeFRrkOBhVyaHam7UcDWBfDqBQyDWWi?=
 =?us-ascii?Q?Vdd/rFS+7ZtWE5ZphWSuU0JuggwO2T2/BKxnm1CUG92nZ35ex4lDUB2enufL?=
 =?us-ascii?Q?8tzgZLBZk63xef7ruXu54qVzAfboN7/GTmeaKBDMOEygEgisq/KjA1swCG3P?=
 =?us-ascii?Q?AbjTQGyjbM5mqaDwZLUYVx3AHCN6INVzh4Mjbnm281Q8yL7/MfcPqG6VGDZ5?=
 =?us-ascii?Q?QfBGYRxucyxNNCGYW+OtWHahyShbpaM/6ZkztKS9BKzmZW1LApvf3NIOga6g?=
 =?us-ascii?Q?bARJA/+hYzrMQIGrc1hb46+iMPn+aqId1RgYm0xxNfqnDDrGURKhqfyfG66o?=
 =?us-ascii?Q?BRKG3ie4mHhgO926uV2kMG/lE3TgzlYBaT5IdB7sduXF/9CuSSQAzw7MX12O?=
 =?us-ascii?Q?UCZGIMIQ1OLGVXS7tdj+wKOCnMe0JOuaCjCAqYuh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fd8402-b051-46e9-7939-08de0d8a2055
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:33:23.4205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHNFyjTHOKU5nSSFC/u0RZ0Z+J6huSIiyrX6QeqNeGWCSHLGXo2r3VaWLWfxzm/aTuOfyM2XE7G20QFXTltNDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8527

On Fri, Oct 17, 2025 at 04:20:19AM -0700, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Add documentation for i.MX8ULP's SIM LPAV module.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../bindings/clock/fsl,imx8ulp-sim-lpav.yaml  | 72 +++++++++++++++++++
>  include/dt-bindings/clock/imx8ulp-clock.h     |  5 ++
>  .../dt-bindings/reset/fsl,imx8ulp-sim-lpav.h  | 16 +++++
>  3 files changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
>  create mode 100644 include/dt-bindings/reset/fsl,imx8ulp-sim-lpav.h
>
> diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
> new file mode 100644
> index 000000000000..fb3b9028a4c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/fsl,imx8ulp-sim-lpav.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX8ULP LPAV System Integration Module (SIM)
> +
> +maintainers:
> +  - Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> +
> +description:
> +  The i.MX8ULP LPAV subsystem contains a block control module known as
> +  SIM LPAV, which offers functionalities such as clock gating or reset
> +  line assertion/de-assertion.
> +
> +properties:
> +  compatible:
> +    const: fsl,imx8ulp-sim-lpav
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: lpav_bus
> +      - const: hifi_core
> +      - const: hifi_plat
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  mux-controller:
> +    $ref: /schemas/mux/reg-mux.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +  - '#reset-cells'
> +  - mux-controller
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8ulp-clock.h>
> +
> +    clock-controller@2da50000 {

Maybe mfd is better, this is clock, reset and mux controller actually.

Frank Li

> +        compatible = "fsl,imx8ulp-sim-lpav";
> +        reg = <0x2da50000 0x10000>;
> +        clocks = <&cgc2 IMX8ULP_CLK_LPAV_BUS_DIV>,
> +                 <&cgc2 IMX8ULP_CLK_HIFI_DIVCORE>,
> +                 <&cgc2 IMX8ULP_CLK_HIFI_DIVPLAT>;
> +        clock-names = "lpav_bus", "hifi_core", "hifi_plat";
> +        #clock-cells = <1>;
> +        #reset-cells = <1>;
> +
> +        mux-controller {
> +            compatible = "reg-mux";
> +            #mux-control-cells = <1>;
> +            mux-reg-masks = <0x8 0x00000200>;
> +        };
> +    };
> diff --git a/include/dt-bindings/clock/imx8ulp-clock.h b/include/dt-bindings/clock/imx8ulp-clock.h
> index 827404fadf5c..c62d84d093a9 100644
> --- a/include/dt-bindings/clock/imx8ulp-clock.h
> +++ b/include/dt-bindings/clock/imx8ulp-clock.h
> @@ -255,4 +255,9 @@
>
>  #define IMX8ULP_CLK_PCC5_END		56
>
> +/* LPAV SIM */
> +#define IMX8ULP_CLK_SIM_LPAV_HIFI_CORE		0
> +#define IMX8ULP_CLK_SIM_LPAV_HIFI_PBCLK		1
> +#define IMX8ULP_CLK_SIM_LPAV_HIFI_PLAT		2
> +
>  #endif
> diff --git a/include/dt-bindings/reset/fsl,imx8ulp-sim-lpav.h b/include/dt-bindings/reset/fsl,imx8ulp-sim-lpav.h
> new file mode 100644
> index 000000000000..adf95bb26d21
> --- /dev/null
> +++ b/include/dt-bindings/reset/fsl,imx8ulp-sim-lpav.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#ifndef DT_BINDING_RESET_IMX8ULP_SIM_LPAV_H
> +#define DT_BINDING_RESET_IMX8ULP_SIM_LPAV_H
> +
> +#define IMX8ULP_SIM_LPAV_HIFI4_DSP_DBG_RST	0
> +#define IMX8ULP_SIM_LPAV_HIFI4_DSP_RST		1
> +#define IMX8ULP_SIM_LPAV_HIFI4_DSP_STALL	2
> +#define IMX8ULP_SIM_LPAV_DSI_RST_BYTE_N		3
> +#define IMX8ULP_SIM_LPAV_DSI_RST_ESC_N		4
> +#define IMX8ULP_SIM_LPAV_DSI_RST_DPI_N		5
> +
> +#endif /* DT_BINDING_RESET_IMX8ULP_SIM_LPAV_H */
> --
> 2.43.0
>

