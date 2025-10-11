Return-Path: <linux-kernel+bounces-849153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C4CBCF4DB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A3774E5189
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17106267AF1;
	Sat, 11 Oct 2025 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DC2yVNuJ"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013030.outbound.protection.outlook.com [40.107.159.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E330C2E0;
	Sat, 11 Oct 2025 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760184092; cv=fail; b=DrMuS2OJsXDy0weP+4FkfXQyI5QFlHgBGrPUO2w0mPa6ka5g34pYAeZ+YKPFd5kINoYpqr/t0WCt9SjmxpyjIHYWVNeOrh7xiff8kCl1iI0zghMZ5GOgnaHeCtIXSh4Evmth2IGTv42RWai/h+SiuQh6lVa9h5zBCoMuNmNexX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760184092; c=relaxed/simple;
	bh=UnYN3sEjgcaTTucPq7h4gEKO7ds3EmRTgOfDN2tddTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c845HiTB/zmbGTkfOv8rYbaNAbWn3ypBR6xt0f7oXThSllJCjBymhMjS2ZrNvBrPaALVipyARE6KAaF0+hOKbHmHX+q3m6gDvwHgztc7i1bM/V92qdh8nxxHKQzXkRur+l0UMyyKGNOhc3X6sxRWRXRiUOMUQwApCmzMgRbUQdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=DC2yVNuJ; arc=fail smtp.client-ip=40.107.159.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n46rDsuleueMTMUknKQYV8h/Jptx1F2vp3q2oL6ctIL4KJjxRjBrMpfcwHaCCwF4h0DVqJAagreucVeLhm4fHjxytC4K2AIxQeKtMc8TA19qwErlO+WtwuT2Er/9j7I4HPwOdSck3el6gFa9TbIoxpmSS25Sp94WTG39eeoDOvy5eRyEd1o8SagLIJQXj/ttcmGio7//9WE0/DXDSbVenOSyML8NfvFPub27JQfF/xXI5aTLcIV7dnB00r1QeNZXLDRikOKZDLvKlKYcS67WzL1KZuVi3rS+hNMrHuCuLKqoF9zb3E0D0xndhNAc9+ltzuDfoMcMO6B3d6TfEIVmpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vRa+HchU+fOopQvsehRqxWvaJ215rsncHeMcPOgkSU=;
 b=MRHJdqXeTq429UCaLOYVD6qhi2O9K6y5xN9XeSvelODYexvzxL9ERvlzxS8qY0+1FhpnpOFsGD7WZGVCuUk/FytgT7q41rIJi5JAsMexP/sgPjuYJXqAHvcprAKutjIy4TuGu0j+YzUi/i5O5w7h1tX0w4XorEODx88pBunzhvOB4RcrPwMZzY8D9LKM/6wPa1x2ffkxWZbWDkINxY0orb4LyT04BcyPA1vP7Jm2v3hZ3zzEOE0xHHVnLb6j4+Hgv6/xryuIKHw70OHPWkPUWkXwoFEhTasn9E1zorAWwICdxtRUhVhuSBqK3dyr/y1hswsf6KR/ozjwDIlojzN7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vRa+HchU+fOopQvsehRqxWvaJ215rsncHeMcPOgkSU=;
 b=DC2yVNuJmEbXgOLWBVc2Gw+w7vHp2IVqYwOPHF7etpGU/KtZR0Z0n2L98ewmqBex8ZXUt1ShaX62lU7hfNMXtjk4+U02K0sOAs7bgkiWCQwyp5bNtJlJubBrepnaUvizXDktSA49RtQ6X3QguGpEtrPnxVgw2eJ+e76nCeBH2w7oKXI+bLtsLa8dA/S6rhCoUOaiTU5MKFXXSKzqKh46RXuZlvWTh1l1yrmTHKqJygP6jCpChAg5HYAtr9q5RcZrkqYOhhWRumbllRDDbKPNUFEQfYk3B8LyeORWN1KLUY6T1JsnuA6lk93WYaSf6E2mJwL8gKitrV9v/AICTRAoNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DU4PR04MB11364.eurprd04.prod.outlook.com (2603:10a6:10:5d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 12:01:23 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 12:01:23 +0000
Date: Sat, 11 Oct 2025 21:13:31 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Yannic Moog <y.moog@phytec.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH v3 3/4] arm64: dts: imx8mp pollux: add expansion board
 overlay
Message-ID: <20251011131331.GD20642@nxa18884-linux.ap.freescale.net>
References: <20251001-imx8mp-pollux-display-overlays-v3-0-87f843f6bed6@phytec.de>
 <20251001-imx8mp-pollux-display-overlays-v3-3-87f843f6bed6@phytec.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-imx8mp-pollux-display-overlays-v3-3-87f843f6bed6@phytec.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DU4PR04MB11364:EE_
X-MS-Office365-Filtering-Correlation-Id: 301a5b83-767b-473b-010c-08de08bde597
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yPqIArxz30cZPF3l0JB+SvZGA35rJf/zkHE/zneHj5w0NOGzTyxDKY8/aG0T?=
 =?us-ascii?Q?V+gNjWyhP7Xq5y0lcgGmDaDggbnWlEInaSjT97YOrPg0hVSmXvkhqm+HgxJH?=
 =?us-ascii?Q?qEYJOJCYrppGPOaWkCrsDw0YNE/zH+s01Unc1YeJJ/YdyE72l6EZ/qWRiuxH?=
 =?us-ascii?Q?i5MYDEv+EaxEkpPcN3qbHI+3ntMu0wyaV7d6OkItszPme5ULFHmH3FVHyfl/?=
 =?us-ascii?Q?tCsL5jwiDZYlt/6lHK0Bcc/uB+cud3PINWh4i68K7+H+z66MS2tn4b4Ad4jf?=
 =?us-ascii?Q?Wzj4BxPI9pQL06IzTDhRBGgxuE+PmG9TfmLlDRUjUM8XYSjloKAYzf4jr7y4?=
 =?us-ascii?Q?Ttw8uha28rukqyDx8fMXw/uO0yk+8rzmLcQkmvHSLA6Fxpy1v9Pq8m2B26fL?=
 =?us-ascii?Q?D/S8NdBKxstHBXCJ/kIwgpwKRig1j53tkM37rwfB9Pwutx7hARaygvNjGOsi?=
 =?us-ascii?Q?Q/M18kAelez01t8KSfylazqZKdZPy+sGyHX7l1u+69PmuWc3e/jXm1aCh40l?=
 =?us-ascii?Q?yq3lcNgfYmwhrlcTPJQ39uMq+zFMr5MnT9clBl9td2OHAiIjYoFMcS1J2KA4?=
 =?us-ascii?Q?BtSgQZpunqpg0YX0v9w3rQnRu/WwxisBqINrnqXlrRIQfDyjUI7Bv6J8LArJ?=
 =?us-ascii?Q?pyKA/qxAJDAyK/rrmkdyCobeFWDkMli7G1ZEciF/89y1KaYCEjzH/hVqAu/p?=
 =?us-ascii?Q?/DzRrKawlRhja6qOp9fzm2zhhK0dvThuaHAIZF1dk3ED/0VsJENYqjwBowAS?=
 =?us-ascii?Q?vQqO6zctPKHLK/bAzHLFok4v8RC3+/qgYg+Cf4oUXvblgY2U4cC/WphPu7Ir?=
 =?us-ascii?Q?vP9LC2giO33t/LklicvWJZPIEngIrGSw6E5j1unVGtP2TAOo/oj8kjv5YbT6?=
 =?us-ascii?Q?kzWbuob/8oOEwPzclitYON/12+SC/JPsPD7CYHkn5K0UO/5kmuaObnOJ+Uat?=
 =?us-ascii?Q?koe0i0emA9PkUs6h5LmHKGxK+K0YnlfJyVgBYPEHI1bLJyrOCBGfEUbmvY+C?=
 =?us-ascii?Q?+Nq5n4qvsWwm4YwWvI+/ieZie85jASjbGZHfsOCK/cZEoKR0DgFvpAyIJV/P?=
 =?us-ascii?Q?EcziU0oXz7dvSUeG/cXdJoVe10kBn1g9WXPwJeKqldHBbxYucztlWo0gNTF0?=
 =?us-ascii?Q?zae0LFED/7fDhB85DXRlBA2hAY1gG+pvkwaBLi5Nkb8VLlOwks31fu/rNr23?=
 =?us-ascii?Q?n3Wt1L3rUBUa/aiy2r3x5euPEL1fVFol7Kctc6ZtLXexVFKaRtTQBRYK1yZe?=
 =?us-ascii?Q?29AHSViQNo83nr61ZfbqguKipDXe8ZCYvt61xdwABLSy1quQitm9TpHWvnTf?=
 =?us-ascii?Q?x3SzdVrWrk4v6zYmymBJP9rhTfR6gkrOdrJ5R4DiS8MkvlkAxDrd2OgI37ll?=
 =?us-ascii?Q?dqke8XCJV/x5cxKcdSx5Ar71dQHyoiMBjXNwlw5XzLpRBiDU5h0Olia8JFZV?=
 =?us-ascii?Q?avxkzUYA53y48cifSn/E0O3ZvKAH3vlb38RozP8uOFYcfS1D6Mifti/p1LJl?=
 =?us-ascii?Q?28SN7m+5uJxKls791QS2yfhuLKgubXoA4UUW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T1dus1eWszz7C5+lcJ34j7v7uhcnPQKx9lFkOeNgTLFox7wc8KQH3PT0A8FX?=
 =?us-ascii?Q?fwwfTLnd0ovSnOCk2Nt7ACpuIHTHaNwhNglt35b+ybDnKzoU3K7JqoQi1aaR?=
 =?us-ascii?Q?CMXtFZs5nfcAHuJw60Wd+DloliFRFqDzh9dHyQbBBRSkRke0Pi/91S0h8NRZ?=
 =?us-ascii?Q?v3GQUFsJJ09uxGchR2TtDf36BCh/UbG2QXnWeV0wLUgkb+pfjZOwmBsfAgiK?=
 =?us-ascii?Q?6k56/nCrORKSjx0JB+YyfzR9K6P57U35oxANu0Ufl5tJBgqF6OhFN7rE3sir?=
 =?us-ascii?Q?oSVKosDgUY/ZrCULxyj64CVV6Mr6FLleNqm+V4ekRrSf4anx3w8K9qmhHh0G?=
 =?us-ascii?Q?gyWKRvqlSuitDskzSEw30tybxUG4dpPuRXyAtpPC1DB4G8aF2r4+crHoDfFd?=
 =?us-ascii?Q?BaX7ZTDcSXsJhHU3n0Qw3V1euJrD2QYW3l0CQRdYb7Fz11H5VBMN1PL/ZxOj?=
 =?us-ascii?Q?KE9LKncLXF04p/tneA3Uf19xXEb5K6j+3ZKk9OvlZMIrMLawYWM32k9qIwA4?=
 =?us-ascii?Q?1SdU6z6BG4xeOaXDwi7xwZhB3yyiQBZblNIGQ49kO8flzYRZWsrYXWWcZ+8k?=
 =?us-ascii?Q?uwmKdL2ivtRTmb8ZDqJjW6vuC7vkVSTmTGQfbNFO1alHiK9zBcrs6VxY5/S2?=
 =?us-ascii?Q?tX3kffJ53+dxHTT5CFtfGKIwgGBdPLsytAZVsZSXjPJ+ZHCbZUZLNM/ndmOZ?=
 =?us-ascii?Q?lppevHfJopx8Vh7DFVZSMjvPga6qB2CNLFrW7NOA2Msa/6KmSQgBrPRMNDqX?=
 =?us-ascii?Q?Dyrr6WdLi2OoumgenhYBSFVSax6IeJm0fe+ULlMmVSNL6JRU1QHDDuBGgiND?=
 =?us-ascii?Q?JcOopZMEcZXLJcH71tCxh47TVYfsEI+xWi9ohR5eL5cXQ6RLh4yJ7AM9Txg8?=
 =?us-ascii?Q?vILbL6LKnpjKHlRTFuMkvYSWpztRu+EXaw3IU317lC56tDHqytSjjSlbWnND?=
 =?us-ascii?Q?mX93qFmTe8/OS7jPu7jy5yqMrIw079UhXQTsf+R/MGVUO7BB36k4E/UpM01c?=
 =?us-ascii?Q?QWCw+B/+qDxF5yw76me4o0exH+KCe4FfsIK5lEamPjMbOhcFD2W0x9dk1Yd8?=
 =?us-ascii?Q?M3uuv5o0pNYrd7jbbaMN0EjY8DWCPbrLFbEYfnHNlFAEfPe1V98aZpv/ODFK?=
 =?us-ascii?Q?22CN077uw+l4QATZMZiciasYVv/8Oh1ID+pCushAkCzm8266zkyuQBMHLnGA?=
 =?us-ascii?Q?Y9jcGkqPSpJXxQSkN15/sn2lPT8as3MUh5WwL544cVtvX0JVjfE6WeTqhzOj?=
 =?us-ascii?Q?VtJ2W/O85PPLvGlgdprk+szhS0ZVg0JQUnZ9UfVtiXQPjRo0ueNMI3FMZOjA?=
 =?us-ascii?Q?QcG6fMq9nIYVQmA91uLdmcq3xsy9824q7d5O/TGi3BE3HdydgrFOBceQZTd9?=
 =?us-ascii?Q?7alkrmOkm7pUUdhtlBFFdZHsKWyOVNkO84Hfj/VWb/488K+sZ81XNEY3fm48?=
 =?us-ascii?Q?lkV2MT1bJSbTEgRhhj8uFB3vDqvIznIypGvusuxX8rB599CyZVyKHvkqfyMF?=
 =?us-ascii?Q?+XEqaxX+Yn7D3LzKjUdJ7P0kDFJPkxuMqd5dtnGuUUbkoVZxIDzc0nt33mjs?=
 =?us-ascii?Q?oHSAblbtgO06OYJLB4bCgVt8NqYnYL0P3+2Tr2Pv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 301a5b83-767b-473b-010c-08de08bde597
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 12:01:23.1655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: paJcnAsAhihRuI/TeAxeB1spI3oHWYCU2d0kIP0B815NPzx9yv/LurV6p96DTRh1/2NJ4biMZk0PwdAfoN1z3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11364

On Wed, Oct 01, 2025 at 02:33:53PM +0200, Yannic Moog wrote:
>An expansion board (PEB-AV-10) may be connected to the
>imx8mp-phyboard-pollux. Its main purpose is to provide multimedia
>interfaces, featuring a 3.5mm headphone jack, a USB-A port and LVDS as
>well as backlight connectors.
>Introduce the expansion board as dtsi, as it may be used standalone as
>an expansion board, as well as in combination with display panels. These
>display panels will include the dtsi.
>
>Signed-off-by: Yannic Moog <y.moog@phytec.de>
>---
....
>+
>+&i2c4 {
>+	clock-frequency = <400000>;
>+	pinctrl-0 = <&pinctrl_i2c4>;
>+	pinctrl-1 = <&pinctrl_i2c4_gpio>;
>+	pinctrl-names = "default", "gpio";
>+	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>+	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;

>+	#address-cells = <1>;
>+	#size-cells = <0>;
This two properties are in imx8mp.dts, no need add here. Otherwise,

Reviewed-by: Peng Fan <peng.fan@nxp.com>

