Return-Path: <linux-kernel+bounces-853397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE21BDB86B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A293E1867
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696CC2E92D4;
	Tue, 14 Oct 2025 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iMEinAJ2"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9014523504B;
	Tue, 14 Oct 2025 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479303; cv=fail; b=J8pdWuzXyj7txDNr/zp+ySUQCcJYDuExG5yPbDkJQse12yGIqCoVq587fl+m9K/iH4FYt44BDNErtRaWrYQZPG8QmEPTX6MT7/yShB3vwCxVX4046kYvvZSxYwyJoxv1cu3xhIVk2MQEgjVzlEq1flZHZnwdahyw26g8R+WHqeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479303; c=relaxed/simple;
	bh=ktgbOgTy+tqXkDcTfYiKOjbl0NNfpCLrdedbODa48GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W/nkgYA+twsS+mijSi5mEclBfenzRC+UjO2/YUrtrPDkdgEuG0kXmAavNFaurHDRPHQzb2LJrmtBWgOnSfH+zjfwQNes7FLjtpx+AZh/ED30nhYDHemZwEVZPK1t0Ex0v18Wgg824WtSP7a7zrGIcMQXQK1zQExHJhiORrDpEmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iMEinAJ2; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRAun1sgKIqAiAZpErFBiU+UgHakNkhfgokA8vz2NMyXYuokigXPJ/lWb5O9fViGN9OUiT2bZqQO901d7GbEnUHxbr+05hbmbJASdgZD4tKVYIyUiNIR0kjKGrzx2MFkLymgFybhEZ22CtNemJgs8gwWxcwIBc0qgc9qYgrWz6ncKVM+7PHqL6I4ZhFGYgMYRGQkRRqq9BjLjLexl5c28U7Clle2qs7T5JkvJK1OmC1R9adBvzx5R6MTyrwAnd3NiL1nd6/WVvZopHuXz8qF41BXEMIwwjpgZyYY7oH1cUmL3HIL2G23UBHxW3xpysUcb25xiHXHw5lvdJ/Rj0qYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnMmvrNYmskI7u+aocAyQD6qSSVVYtjInY2fv2qrow0=;
 b=C8zC/C4UiIQAcoL1vtyb7l3DsoRwUNbIPp0ncXckddUXb9HH/Lc81Ja46+luM5ueDKf3MHIvJxTUOBckK+3/jxJZTXcpy1E5Qywy7SiUAjmzCyft5JnfnZZMclB9gTKdqNFUKUiUsnYaEvX1w42KOt2a791b3HUniaZYwULrmTXDRS/G2UUNnfi8JLnUzSFMtfnIS6w+sYMl/TWZwVBXbLwTnuATAWE1/DS5NjBLqwXk8MrxUj2soe9MBSzWRJcKNo6G37jNje/dQzX/tmx35ok8v94LQ/yHhDsaxmo06oTZ0aYbOqZeBWhOPlFWVwAhYcSiM6zEJP1/HpL23Xgt/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnMmvrNYmskI7u+aocAyQD6qSSVVYtjInY2fv2qrow0=;
 b=iMEinAJ27unKlDD8bBRzD0I4TrkxiPh6rD88bTiKlSPRTOTqyKvaaAqHOsDM2I3ZVtvamx5uc+aCOLbzFW9KM9gd4RKWblBLS/3eeof9yA6Yhy4cfPG3vMuIeIAobnL7saQ6Q6rzxynYdJgMc/g9d3NxLgXgGVX/oJJfAiJzVAsy7BQnl4/Rf12DsvrJuaRIVEnEX1JmoazUNSDbTdCTp+6CEirGBFZNXOchzEQc4Gh7C2ER1lw1ui8hL8JPNjK9ZnqfK64pBGs6f9VIHwcjOwiV6sUeGcl12ODG5Hrj1ESWKGskXeavVsf1gQhvx1hOsUlLFC52UU+w7xqx9BGG+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA2PR04MB10346.eurprd04.prod.outlook.com (2603:10a6:102:423::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 22:01:37 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 22:01:37 +0000
Date: Tue, 14 Oct 2025 18:01:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@dh-electronics.com
Subject: Re: [PATCH 1/8] ARM: dts: imx: add power-supply for lcd panel
Message-ID: <aO7IOCdq013j3rre@lizhi-Precision-Tower-5810>
References: <20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com>
 <20251014-imx6_dts_clean_2-v1-1-508b36e5a3fd@nxp.com>
 <ddc44948-4816-452f-8b78-b1dfe44d507b@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc44948-4816-452f-8b78-b1dfe44d507b@nabladev.com>
X-ClientProxiedBy: SJ0PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::35) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA2PR04MB10346:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b74ff3-e6d7-48af-8611-08de0b6d3f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C3v4u0NYy//4mxXsVG2tRCg4zjJ63sEHAxV/sW9w0X1E0ZS+K8YvIEt1RFHH?=
 =?us-ascii?Q?PdN67vXmSqDqDSlwP0tCLSoeY0z8PUnPi0GcUFnVaTVG5g/O88Cbce2JCZL1?=
 =?us-ascii?Q?mnisXp/qOF/mKcJoy9SLpsWoq07Wc6fkNgdwFxoia2ksoctxKzD4sctZ/9Du?=
 =?us-ascii?Q?t1sLxlQL8CUrQFOZ778CT6H6ZOZM5CGSWaiC6TE6KlBuDQJH4pRYLiuZEy7H?=
 =?us-ascii?Q?uBAwxu2Tgjy3Mzvz3jIl8Ji2IHOmZzKZa1zlEVIR3Mgjb+wfBmJyiyDjGKz1?=
 =?us-ascii?Q?klEvyO3y3mOIY2xQJj3NxHsVE6BmVMwhuVxo5qBIPCk8OLgN0Qk761kMoYS1?=
 =?us-ascii?Q?1njFy0784U1MBxIESvTZfiAL2jdgJswXM1ukmrhTHqxBHMaSUpfSN9ZoowHB?=
 =?us-ascii?Q?saXp1OM1rax4EmteLCrwFR4gerxJ9vLgO8LgzTrfAa/4IxrTB2C15RuzwW3p?=
 =?us-ascii?Q?TNIxQeiTvfKTqQtKBdmnz1Cghzfzyk0Ztd/PSCiYf0c5F13PkRWi/KbnxpIO?=
 =?us-ascii?Q?IXmIq/7MD2cokUeTD76js9fhDK2fFKfXn5THR6Yk4NsmBKQvGjknQ30jppS4?=
 =?us-ascii?Q?YWykl4vWbpwY5LdxadxaQI6OmH9Of3cvo9rQFlHlvLN/6Zde/9yfrchUPfsZ?=
 =?us-ascii?Q?ITd75PeBhPAS5C4L0l8CVcU0rwFR1zz3vXYLwopqT7hbsIfPQTscZbjpRBjG?=
 =?us-ascii?Q?X+kDXkmIF7/9Czvww3UIAfa7ji3PD2Wjdc9tniz6XbEYJSfEcqfHv5Hb+nT+?=
 =?us-ascii?Q?r/1C2/qLaSoGJqWJh4HHLj7I+un2BakrgkJshBcEfxMQ2Y7kWpLZZqRZaRCN?=
 =?us-ascii?Q?/os+Uq+X1H4Ng3su+sRsSpvXA8FquFip601P9D0WAyWRKrA02DolQNtdDuzF?=
 =?us-ascii?Q?HUWUWu6+zit79npAbXNqS+JRlQhHyH3/uO4AgWCub315cZDJsZRxyK0ScMB8?=
 =?us-ascii?Q?Xzueegx4L/gS+XH8u883/iB4ooh0Ma/PbPHq5re84GDkgyiyJDOpj92IWFC4?=
 =?us-ascii?Q?B1jHG2/abeleH4qH3Y8wOtCWPTIpyO3K8+ah/u5gznbKOEBMB/TOgEM2LFBV?=
 =?us-ascii?Q?4cuh/ZIOM6jwPCYW5N6BsmrI8NRKasvNRcBJlaTu23xuUm6EkZUbkMZdPCPN?=
 =?us-ascii?Q?bAdi5hGbtUMTUN4QyyQQt+YF4H5AiBWYxQClPPfsVJeuHX/TtdEQtfatt0zN?=
 =?us-ascii?Q?I2alksxx/j8RQTVYqSkblE6PbK1vBZBmNJGS1n23ZUMsyLsskISjq7VxqsXo?=
 =?us-ascii?Q?vaqIwGzS2CfIbe5V1mV98MSTADvkwZ5kJfNdGIZYUit6CwT+ZzpgCvHpi/NT?=
 =?us-ascii?Q?kxYUB2VboSfAyD+wim4VrRirgBljGwvbDWvLohOAdjll/yAeI+4k+hqyx1lF?=
 =?us-ascii?Q?xDji5Qk1vITgqa3VrQV7KZ9750uQSHSARBD9FfJP9VkmCsQFzRSPXbc0wiV7?=
 =?us-ascii?Q?TwaJdEFVcH0Ha4FrVGNhnB0WOQ8KewfgfUZxEA/K2LYrhNCDCXlMDlUxlfGq?=
 =?us-ascii?Q?+ZWdIdKOwVpYE6Lyg3YTUKdtzGRuEOg83iPS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JqYQvmlQ2gvo9acDAf0DzjDVqHAaLhobx5dOpTOtFZoas7sVZENWSll8QAQd?=
 =?us-ascii?Q?Dm47zswz0Gz2PdUDeVdNqig0V549ae9fMK7q4taIQHjBzJiv6YfOetn1ZnbU?=
 =?us-ascii?Q?Azb1ww4S/BDDxHxdznKZe47HxMRliq/49AH36LOj9fq/Sv2JWyBbQAEk72oC?=
 =?us-ascii?Q?eO+A2Ijr4nY9mNX79cJLXVksLHicYODKvzjopCo9QcSzIo2K/tTMc6RGJoI/?=
 =?us-ascii?Q?ObFYidXH7twaCnogCDCFzp3z3cdyjdy7JWUnrUeY/i4Yx05hgP/uWDTZ5hAz?=
 =?us-ascii?Q?yuNLuYjZag7p9DVVhYS5ZBPn/NRC9hfdtc6fmn/G9crICRq4JI7lurRNeY5R?=
 =?us-ascii?Q?SE3BPms0GjMyiAExP9VkLrL6VZCFc1jass92o0AlG0b/1Bw5d4+l/DRPSUB2?=
 =?us-ascii?Q?YhwMy2BHiQY25IdweI20pCmdRDpiP1IJvpuOqp0n84j7UdFeoEhi7opZCN2U?=
 =?us-ascii?Q?qiU6UpPXyzodx74dhmGVQyXvtAeI9L7Y8JcfzCwSAweQP8e8r5QpSgoWKXYN?=
 =?us-ascii?Q?oXBJC0Eq1w1BM8pXLCUV+K0+7k8yw59l6WGAI6cK37iyvuAvpfEcxk2cWdh3?=
 =?us-ascii?Q?2yPgaqsWlDma4qLwQcsSW5dJRlWQ42gUKuprT2IODxaxInLj0u7y8/6VAah8?=
 =?us-ascii?Q?W9ljHFJHSfoxJ2LYbHlo5SmQ6nDDfGPS/qUohyBDH2yJKPC3rvY8Rv2bOl5H?=
 =?us-ascii?Q?ICianX0HOJp8IXeH9cdziw8MvqHOHFBdPA414etzWUYhlpmW/eIUq1KajCww?=
 =?us-ascii?Q?Y/FsXAnEjNdm3FCoK4sF5G/kAO/u9cUwa2URl6XGArGXq2akDkaGPG4T5U3L?=
 =?us-ascii?Q?eQa3kqYvIaVfsdcKEZ1PkwD6ZSol4Tfrs5JatRhle07nHTkr7OiMy7Rw6adB?=
 =?us-ascii?Q?E0hUOOivZnsHYtWzWIFAUpwgvQJ0oebGo3gbKrlXyBgv0Autmx9z91W6OgEy?=
 =?us-ascii?Q?ZSj2K7biGmK0QFpRJQ9YRbjfTGwIFrvBRvgUmQp/FF31TkrtiKin/ApDO+Yq?=
 =?us-ascii?Q?0lg11T2wxkkmYgSuowpJnl+ERr4lsp5TtEYLdNhdozWlIup1I2Ma6Lk9CCdq?=
 =?us-ascii?Q?3vMUoBzOVJGdtwb0UpUGUb1TCuvNNeFEQP+UIwB3BjIV2KQxoE3zVxEthbhz?=
 =?us-ascii?Q?iF0qG9mcenLsl0pOahZoTLaD7ViRII4XxLZy29YjbO+GARY9rlIUiUuisutO?=
 =?us-ascii?Q?DkA36KJ4fVE7/rlgWSbepJn4whUV83O5Q2U1RHr+2tcwvc/eOYx44stPoqXi?=
 =?us-ascii?Q?If5YhG58LeK1Z+bb5KAO5zy21puxrzutbcBSP1qunp4gS8UYlFPubspm1sF/?=
 =?us-ascii?Q?PoCiRtpPWGpThaBFVAuUi4vWGJ7ZZocEk4aJpTtLASA/haHiZB4w/qWctGwJ?=
 =?us-ascii?Q?FmatdAmjpbROFEvda+ugaSRzTQGUSxEmpaZI2E1AYXvZB6O8LOO1Ctl7PFXK?=
 =?us-ascii?Q?PMdn5E8PCLWmEQHfbc3x94n17519fKCBkJqG48H2i7iLBCNi3K+EaBmtsfEp?=
 =?us-ascii?Q?xYqQXpWa8g1kTRw7upLlTDWggCNrKUTyLouMO4iwvN8av1CZz7vQvUefEyvm?=
 =?us-ascii?Q?MfkkyYNsF43Bf24aPb8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b74ff3-e6d7-48af-8611-08de0b6d3f24
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 22:01:37.2931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEHaJK1xRwNYfkgGpmeRuX6OQVYUY3qJVwNRvQvuQuBm1lq+5FI8JnzQItjP3zvVrMR8u3l988ks/dIQssDywA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10346

On Tue, Oct 14, 2025 at 10:46:56PM +0200, Marek Vasut wrote:
> On 10/14/25 9:38 PM, Frank Li wrote:
> > Add power-supply for lcd panel to fix below CHECK_DTBS warnings:
> >    arch/arm/boot/dts/nxp/imx/imx6q-evi.dtb: panel (sharp,lq101k1ly04): 'power-supply' is a required property
>
> ...
>
> > diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts
> > index b29713831a74489e8cc0e651c18a40d85f9f9113..04e570d76e42cd67a38e0f3b2301598f712e6bd4 100644
> > --- a/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts
> > +++ b/arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts
> > @@ -199,7 +199,7 @@ touchscreen@38 {
> >   		reg = <0x38>;
> >   		interrupt-parent = <&gpio5>;
> >   		interrupts = <4 IRQ_TYPE_EDGE_FALLING>; /* GPIO E */
> > -		power-supply = <&reg_panel_3v3>;
> > +		vcc-supply = <&reg_panel_3v3>;
> This looks like a different kind of change ?

It is touchscreen, It needs sperate patch fix it to align
edt-ft5x06.yaml.

Frank


