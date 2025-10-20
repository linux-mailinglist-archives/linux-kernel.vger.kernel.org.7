Return-Path: <linux-kernel+bounces-861236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBC4BF221F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F73E42722F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449E6264A97;
	Mon, 20 Oct 2025 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EMuWOJaE"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82031E47B7;
	Mon, 20 Oct 2025 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974552; cv=fail; b=Mw1Ia+Ire63u+ag+r/b42ikxA2C9f345fTb2nAUGXzDutgjxO0ymdLrcJk49Dq/TtV5P33h06XIX6cJ3Ae/c+vpIPMvRC2IyQQRf0Rh3k6BZwfgmJYy3VX1OQmAI8rSbP3hNHTrUu3MVX4GG4AKVdH173bO39LJEGBcXmACDJuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974552; c=relaxed/simple;
	bh=voGFfGTr3KDdvgeDYV4i6n5Ap4UFfZCblpQ/XsJSyTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XEY8zUNo44oQYMRFotfRTLasMPmAahb48k9j8g3FUeAMLWh+hKDVkolGLbA+OY8YE4TXKhib/znj0fxIVpyb2CRjbaiRgowvryKpGZBxkP654nwiTep4gfE4WBpSTd1/EBXuqyIViCWG/rIfsDbyVWkQl0vhKc9Ucq4yf1yxhj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EMuWOJaE; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwyGt/cLaOBrh0K/ihwYHreZjawZpMEoF/MexJCw5y2YOWkaZMQJTuA2G48+Ahc/RBxI0wgEeKbPJyXq0ZOOJQwun5ssCFPAvPt4SRJy23uKggs4sDoRgIA1UM0Su8m/S6NxMLHywipX21gVmntC2FLweuyccGnL024BQScI/TcAnplAqaEZfC5I9TiPHoRO6lRFMBjbuUsD8GYxXGp4WLmGp/1hC8ArSGWPQo+odrjwuNRSOplKtrj2yBB6JrwG6ndjvDB1iuotj07SFeDiBACCWRZKGKMvQ7QMgm6R+7SYbP0OJeNMGPHF8dgl4QRWQT8LxG5cC3j76zjsRSSwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R25DAJh5+U4+NS74d2lT6sqCWc6wuk8fXPYSvrQJhTw=;
 b=a/IQ1eTsT+k8/bUUEwOl8NJKQOUMjHsbEQEaU78aBatv62PUg84mk2C4GydD66qlI7VeEblXmRTPIbKZLECnpcm43KGompC5c1iHF/ZrJuf/Bc0gj/6RSQoTgGm8rLa7MSPgx7cNl90BmdD73YmI0V19x+uC3DWhU0lNXPJ348LjxifKGFCWEgUagu354o/wEi4ECbXb2oSCalOpsqfeu+F1y6CKr4yvstW/B0q7ayYZk5ppH+a5w63gjzM0lR2fKooguNyV9Rg3AE1UMOQ9xIiFeetq1z+ugLplA1Tgt/HykZHF9fXu4XcK2njMwv3S7Hp96DvVDPoe3UZGpigatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R25DAJh5+U4+NS74d2lT6sqCWc6wuk8fXPYSvrQJhTw=;
 b=EMuWOJaExbDabuLezzxY3D4m/LLPGWL6Xd+61rf0glG3upklH+lOfPExT23q704gWwv3WJNM4b3mMygozGoySwZHBPnL2FJvKsFsx0lzNR0NnEI5RSM0Jhlmw7xTNquLf2a6GIBQX53ioOYshCL9JqMatT0j+iCFIuh7oApArBKQKMoMD8Xyq87EpWCYYxcT2Zg34bTpa5t34A7lvPuNIECLVt6pbSGCvYdQSdQS3Dlh4fJ6mRJhSEQavTRnR8W9KhoyudycNJHB5mIMskSEYamVWW6T1IZxRKw8krIDA3UrHwT6sQNT+FgYCLISpoGTS/YLVq4qL0dSBOeb5qMZRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI0PR04MB10541.eurprd04.prod.outlook.com (2603:10a6:800:26a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 15:35:47 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 15:35:47 +0000
Date: Mon, 20 Oct 2025 11:35:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Yannic Moog <y.moog@phytec.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, upstream@lists.phytec.de,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] arm64: dts: imx8mp-phyboard-pollux: add fan-supply
Message-ID: <aPZWzbRKquauLco4@lizhi-Precision-Tower-5810>
References: <20251020-imx8mp-dts-additions-v1-0-ea9ac5652b8b@phytec.de>
 <20251020-imx8mp-dts-additions-v1-1-ea9ac5652b8b@phytec.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-imx8mp-dts-additions-v1-1-ea9ac5652b8b@phytec.de>
X-ClientProxiedBy: CH2PR18CA0054.namprd18.prod.outlook.com
 (2603:10b6:610:55::34) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI0PR04MB10541:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d3e81f-6da0-4cf6-b777-08de0fee5720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w0EmIMmRT9qfEpbpPWVpm4THApMUjwv87rEkTWwQx5rIMuMiYGNcR0Cd+eK8?=
 =?us-ascii?Q?GVGbpFkmwh2H9+QundYfmuDpZ0dWjyAlXOmirIf52yu1YMeZWqDv3m4zq/Sr?=
 =?us-ascii?Q?cHjfm1ghnjCgSUYYMzs/kwj5mS3ZWa8Vq5h6P4a/+JpSP/SGLv10GQdGlysm?=
 =?us-ascii?Q?7ME3rxLvyMtMUzhvnGP5Nvp9VaA18xQmUrSgQAXejpqA5Mrb91qy6OCxgQZr?=
 =?us-ascii?Q?hjoINwYO585KXfdSKMJlrrl3XWsDsssIjD1HUcO4GgQ5Fp7w8sgFEIv3eRC1?=
 =?us-ascii?Q?AH9b/0EC15yvzB/PF6I7VK0KhKVaAzosyynuT2MNzbqZzmyjt7RR665W2LpX?=
 =?us-ascii?Q?S1ZX9LEj0uZonRFslne4c32m3AzcejnugPs7Mn3ycsBKhwjUleJZGgzWkjac?=
 =?us-ascii?Q?Wp1USa1R/qbGw4zjeEt9TjF4ZrW4YwgBruLBgrb5TN+qDrXkoBfvSlCIyWbN?=
 =?us-ascii?Q?biylLrM/iwhWOqFL3biYmVz5Usw+PU3dCzaYHel+3u1viIUMraSaBg5t74NH?=
 =?us-ascii?Q?q7RaBX51vxOhPIdx0XNSdPJWHeZdbigxwJFCSBHM6AY2HmuM/NqHRv/ua2cZ?=
 =?us-ascii?Q?+JmmLUP7QbK3mTxS/tmYOhTMTKy/oNXRno6HLaCsXVbhq0YmGSn3J0ane8dr?=
 =?us-ascii?Q?OiLsdVTKy+u3A5VgrjdntqYaKe+4ph//EAncsbhEfvxy88Qc2cLC9Qr9duQS?=
 =?us-ascii?Q?UVrIOrrged7O2UFnDzEdYpk/+JGAUlaGvO6YJMyMUoOs/Epwr/ZlpHGa/foi?=
 =?us-ascii?Q?ThFkqzUb+E9RDeOH2JET7LISG5OvswI3zz43zV9qvZ6ryVISwI7e9ytao0C6?=
 =?us-ascii?Q?MymHsLW2rV2njIcat5Vt56b1YRVyDFDEnTQVUUGyMKxeL7FPN2D5z0mpqyib?=
 =?us-ascii?Q?nFPIA8lAtAdI4tAxvFToZ+MvmpWVnhHXdZpQo26RhNPhdKf2J1/8f4P33UPu?=
 =?us-ascii?Q?CKr8tDlGUy/XNDQWBnWKaQmjACybgWw0pNSdrVejjFjqR4WlqaEUYF1ARCJw?=
 =?us-ascii?Q?RmPNmFXQEQTDSSEfgmnsSIUGPEGEhjzoLs+aDUiVz1TvP/BKJ46snezKYSYA?=
 =?us-ascii?Q?LtJDl5ZDaqyEQFeNyJ4nhRCO8ZbSWOYxmYCKTEFLHeDb5HkRgjgMzl+jxeDI?=
 =?us-ascii?Q?bhNLxNbucBS2ykS3FBPVwPRu2QXYXSxBTfvp35A8jbbhfrhUyOZhqLYioTdQ?=
 =?us-ascii?Q?cdDiQWhCQ2o446hgVYCCE4JaLdkC3JgBxn2I07eWyjEJEoCbC7EKyo6U5Af3?=
 =?us-ascii?Q?lOMnrXRhan+Q6M1UUfB25fpTkv/Tdg7eKPR4ujGYI+Qe8LZr2UcYVU1IDZvX?=
 =?us-ascii?Q?cnYn2t5xnXWWrXWOkzH50k6lSsWu6YZT3h6ahVo0FLtb+4MMSgEAWTenchkD?=
 =?us-ascii?Q?RD0kK+x00DE2HWcexLn31P3w0wkyUtpQjuRd5JYjkq97ezohkjf3aLrlWui2?=
 =?us-ascii?Q?JiCYuzX27g5CmM+kwq/PkU8mZ1DuZMOrwkvdptkTr+jSIH3f2LERZPdiQp0C?=
 =?us-ascii?Q?PfC3KX6/dZUNM6wqlPpmiLRL6QCGalBulDse?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vofvGIicCb1ySmFXW9sPwbj9M9InYBi6ZPvZ0WKnhfh4RDZgUdqnQCv6LL40?=
 =?us-ascii?Q?bkq+AGd9srm/JDKR89q7dOUjLMTjWFKpPstsBJBeEQlUcDJAxoSIaCNZ1yQg?=
 =?us-ascii?Q?rWNCJetaKrcO7otv253K8QbywYUCUP9l1j1Q2TOVJ9+FefEYDN3NnX/A3z3Q?=
 =?us-ascii?Q?P7GoctTguNx5EmGCFl6PuLjTMP16kuSPG8ytyzrjEGYcPDEorUp8vGa5/mb4?=
 =?us-ascii?Q?qOlPo01FsBSxCwjO06bvD7UMHf2nqJLD2FxQJJJhrbqMYsnjBqAH7xwmqAnR?=
 =?us-ascii?Q?Qg6/RMhxLO3BzyXRsUQ/2P6xI1rGO2/R/O0Qtf6gmwKBsOVeCJQuKnZfOmd9?=
 =?us-ascii?Q?uO6mtngPKN0hutK+ZJzAXmkus2te35ctX1n8Lr0Z3T2u/JmeUSUf2cdjuKVR?=
 =?us-ascii?Q?GU5li8L6Eb1vHY88T9MsfL7bw9wJ1YJFwmQBJCRr0QpYX1EuZUuI6ajVX0PT?=
 =?us-ascii?Q?fUKh0C0BzRK5umk90mViZCkxtBVV0bNwhaXJwVzDOr4ePRc9/EVrspKtdc74?=
 =?us-ascii?Q?mrG7dB8j7Tz+UZUidjmY1WRR9vCr99e2CrojAq7qWfUvFZq595bQYcmIW9Kk?=
 =?us-ascii?Q?w2UlqX++hI+pTVBQFx067fjS182fc34/EJdOb13AOS4rdJaAwGvI4hya6PIi?=
 =?us-ascii?Q?jVLkxlzEHUfD+IlYluRIsLUTZdk6Zad8LHkHhACuqGqBmjaroHpYeQIh36wo?=
 =?us-ascii?Q?w/Gnt+cdjIBPiyNNPMzIyopLoMuQXBAcCmYCwWKTbgSV1ndTDZbCDtiDJN/j?=
 =?us-ascii?Q?MEZuPI9C0MuZRf1dke5B/zH1BTzBOI0pME+yHB9Dq4MRtD8eht82a0mbjaSW?=
 =?us-ascii?Q?yaEb9h40S4aq2DjSX9l//vA8B48zrDijbsLGE4RC/PqCzJES6Z/05mnhhq/u?=
 =?us-ascii?Q?e6Sd/1W75nvOiLvWNU8yuqbX67YL0K4IG/eVSy/F32od9a+E2nAJqkj9kYKA?=
 =?us-ascii?Q?VeB9uzIYU7X/IeoZDLzv41OhaJALFr877mt7LysTVcowY+CQeWsAkX0UNtf5?=
 =?us-ascii?Q?7YOztf4gYJ6TBVC2BWg5D9nuZoFdDUXg7IjYbmdXwxIkNSeaN0KLoZksVjUh?=
 =?us-ascii?Q?XK0rACIpv0tvFf/t57h8ICiepfoj9R8jYNU0aXK9rNOEoKwznn+Wn7lhdWLT?=
 =?us-ascii?Q?3SRyCi/euH59BI+bnHE9Br7axG3bzYkCj8MGi6kfuXDl4GPN48KfgtqpSd1R?=
 =?us-ascii?Q?CGix+SzBNDKjkb4BA0DlL1+2mwwfXc9Bs0SRzgzlsiYgP7mou789AvDAf4OE?=
 =?us-ascii?Q?99Q/2QNKdEiJTlnv/c9QRg+lUzGskzeOr/PV4H19nVceyt3vxdHHXNIvbwCi?=
 =?us-ascii?Q?rEisse3ZEonMM1Bs7oblykzXWP0pWRlDSvo6Ee4aKH0uDGZq7XT+0wBPPvdT?=
 =?us-ascii?Q?nBWlgbTvlN9waDBSiFoBTWhHDBTWrirWVfyY5RA00LQY2gMuOD0ChF+HCDmK?=
 =?us-ascii?Q?0iRVKQ50cAlFekiU2b5VUszZTgAeqVhQB52FhslJiQaKG0Qw/ac0kJK1GBDw?=
 =?us-ascii?Q?yr8Icq6p8k4i1SxkRN3qjOzgqFicDoP3tC+wWU+gBvu+eEcGGJ+Dwar+zNGL?=
 =?us-ascii?Q?YUJB/i8y4tnWue6XKDIJKXqS0iv69qxspMr7yid/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d3e81f-6da0-4cf6-b777-08de0fee5720
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 15:35:47.5390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x81+v0qUPdaqSFGIh4ubDOFgaNF8swvvZZxPNarIc/jMBgq0mnk4oR+Ei9uQN7xNUkQWbRPB/dpbthVh15vAXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10541

On Mon, Oct 20, 2025 at 03:11:22PM +0200, Yannic Moog wrote:
> Add 5v regulator to gpio fan node.
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> index 9687b4ded8f4c98fe68bcbeedcb5ea03434e27a3..6203e39bc01be476f16f5ac80b6365bce150ae37 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
> @@ -31,6 +31,7 @@ fan0: fan {
>  		compatible = "gpio-fan";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_fan>;
> +		fan-supply = <&reg_vcc_5v_sw>;
>  		gpio-fan,speed-map = <0     0
>  				      13000 1>;
>  		gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
>
> --
> 2.51.0
>

