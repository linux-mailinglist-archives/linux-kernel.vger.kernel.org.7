Return-Path: <linux-kernel+bounces-848330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BB1BCD70A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 252C54FE605
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4233F2F5473;
	Fri, 10 Oct 2025 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KYVEq21D"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010052.outbound.protection.outlook.com [52.101.84.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7A2F3600;
	Fri, 10 Oct 2025 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105593; cv=fail; b=dQydNC181PjgfFl5AqsyKpkhsQUR32mfLaJOhv8oWLaFT6QDY/l5EqxpFCBDtEyInR+uSTQSsJrCYr5o0zuAWmW2lA6QHvFYgEuZoxcjPJ6fofw7l6i+KdwTMylsUiKZp7lGpkoTZwd6zvvEoMoQsFKAjn3vDqD795wyOik20dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105593; c=relaxed/simple;
	bh=oc/vBWzCvHiUDuqwCkNhSTTz1284DF+a/v4/uYIAA4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m+LUITUDfk3lm21Ft4bjjKqayL3owu76WpxbOmsIpULzkIuA44WqInD/KelZVwZlxytjuoRigP+zL87FBn+U1uqQCkk40JTa/BdRTKuBPYedOLbcX1ZoCXjyK/Z1m8A5IkG2eRLukbmHYK0ABkbZLD2B45zQ6NtOkCLxzITHV8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KYVEq21D; arc=fail smtp.client-ip=52.101.84.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z47klZkkKdeIKmFNbUpKxlclABCpNP3ddQ/Zt8ts5DHSNhTDP658k+t8R94wmdch7DYyDXTm8zrbQWCtyPndNEHXc6DciuqnJoqTc+e1cM/m6Qww4GWbPHiQq/wNl6W31rMjlwRNb587/L1O6IvlTPq1Zv741f5xgiVyq66ppBFZhJZVkh6yjSaCxRQXhpHjzu7tOMucHHhm+PterRb+gOt/SbQeaOHqObvfYtZQz8hSK5TojiYDJmcWt9GKowTFDYjUd0bdA4Y/mx0WrPQVnIY56mMnbt1ujNPVUmomGbqvgYZP1HiipmZboi5Px5Ck+cpsHTB+LCRBGqLRS2gSXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2Rv4iQy6E4dQna8+F/dEN397pB00qS/MxhzilLpz88=;
 b=fhlMhyhwjc8SWvrMRD1FDBUtnRZvablMYRXQrhxuuQSVX30XUTtwcekZo8Gpm2ygEtZjU270Ef99duyjx74eRs2yhxSoLrWLEuJXvB8MTU55A4AA/YWJ7XGNMuD3GsFIy+pSDL/17L8lKhhRhmChsqy2vkiMRM/TXpWuvH2FrowKIAvhijtbvG5WD4zEisJv1smijclUnX5XRE+7Rsert2A9GNttGfQMNZF99UlejAQv3cydu7bLmbxoPz62dTCORxdN1gdJyriD6+bV+5LF5HuZLk6ZJNxqPVPdh4J7cJ4XMR9/PX9QNYTit7vPOUytPvraAMMCeUEOc6ASGUw8Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2Rv4iQy6E4dQna8+F/dEN397pB00qS/MxhzilLpz88=;
 b=KYVEq21DGQTt/b0qET+GuhfQodp3KVaDMWLgtJw7e+adAUPdEvHKipfNdfE6HWd/7xOCVfoiSkBZHaQwvfZbTjjECWllv06gitP24DePXXMbLvj1veUCAqNDI4aOOm7481D44WvbNvifJ0DkRXuQkWWWygghKete7pvzC2gL0zA4svgFwhOIz1QduS+dUrdA42pP7F6ruIyqotwYbej1e4bLabtyiuyW6r7Ae3iQpuTDV8D+lIDEMbUxwd7diQ00vGeIoIodIVuMw5i8NmFhGlozM7GtvsY+Mp05PAGRIvh+squjDhPKm2WInjSZE04a0MGDR9M3U6bo/3pHduygnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB7671.eurprd04.prod.outlook.com (2603:10a6:20b:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 14:13:08 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 14:13:08 +0000
Date: Fri, 10 Oct 2025 10:12:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>,
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 4/4] clk: imx95-blk-ctl: Add one clock mux for HSIO
 block
Message-ID: <aOkUa2WcTkp89Jx9@lizhi-Precision-Tower-5810>
References: <20251010-usb-phy-alt-clk-support-v2-0-af4b78bb4ae8@nxp.com>
 <20251010-usb-phy-alt-clk-support-v2-4-af4b78bb4ae8@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-usb-phy-alt-clk-support-v2-4-af4b78bb4ae8@nxp.com>
X-ClientProxiedBy: PH8PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::15) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b02a241-af97-42e5-bebe-08de0807234a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k4flzeP06NA2VJ8va1ZpxmpN74JRAL8ESl8pzLuzuycrgU2VwEfBtm0zHOw9?=
 =?us-ascii?Q?eAYdMGuDy8yBw8y/Lnz2j2EXHM/AXnG6/VW57omwNJrqZtec/dloAcuDQfuy?=
 =?us-ascii?Q?Aslp+e+MV9A2Qy/jHEFI2ubSFDZ7TUmn6LNGeuP0uSooJ4Sotg63S/P1Vmsh?=
 =?us-ascii?Q?DWs6eMpgNYvbCYxaZUwPAe9CMztP7Em3t7pviSMRuVa/8/32o6SliWw76wrQ?=
 =?us-ascii?Q?Ijv8XYVI2zXk7dqlEo+2t7C3BsXPsSxyjiTbM5QXVbr6uxt7gcTPT4PBCmpX?=
 =?us-ascii?Q?WnPeBrpamsgR34FogsMZ1/EQd/Ym7k3n45JZOLs+3dktoO4+LwMWSWln/Onx?=
 =?us-ascii?Q?AqRu4tvAPYl9GRrefQBJ4Ya/XoA3SnQCdTofnshayvGOhKu0UZibu47FdjRP?=
 =?us-ascii?Q?1gYluBQRYRAO9b0S8hbilww5GSd/ihTy0bAGUjaY2Bw46HxFG5jaVRuBzVrS?=
 =?us-ascii?Q?7iTn0K58hPIXvQ08Af2TLX8hxx2BTcKguuqziWO7NLY8SfBVxULgaH3fB/qa?=
 =?us-ascii?Q?kMsFQwXFkk9cp1XM3qAReFlmONwPPZKiAEp+CfNcnZ9Rnv1YlyJxVvCT+/JQ?=
 =?us-ascii?Q?MBXxAFV1H2A3S4K49zdc8dUlfmEMMDSt2JrFPDGsmQP+krmzcMz1vhrznXjV?=
 =?us-ascii?Q?pKHyxcbPyb/OMWkMTKKtoI7O5zmZkDE6c4ER7JOoN8gG++ccP898nQvAYEvm?=
 =?us-ascii?Q?Yfyi3mEuEPvE9iYn88JYsm6+Tw0bG6pWBawsE+k9JsxjL5rIQhmwsIpUI/0/?=
 =?us-ascii?Q?Y0vtPa8U2oxU4fe3BXzLPYp1TGWM4V+qkLrSDSbcTIrLVH3SgSDhfcwJ3G2x?=
 =?us-ascii?Q?SmwjDZKe7x0IRBrao2E0vSONuGhmJ/nitz5Z5szwSP+ICyzvFy651CCdF4Rg?=
 =?us-ascii?Q?9vXWZoQ8f3FOfcGjRxUfQCb9okoHYFYAVcnGght4UdQYLu4SA5L+KGfRIrUS?=
 =?us-ascii?Q?TYbkvchb0RGtQTJcz7DQPJi1iFsJTcPlUUJVkXGYTjTHueRMftePdeEV4Jhu?=
 =?us-ascii?Q?Ia5bFehKo68kg5pTu0i7NOzFXPmn77OvbZ6FGdj2BOi6WlLHeP4bR9KsXFyE?=
 =?us-ascii?Q?M0uZ4hLaJbSN2FsYpKpZ26XtHBKewrTatZVy5Rq2dMLPGf2OJjZP0H1qQJh1?=
 =?us-ascii?Q?QBb6YKkZNnIF+v5u1qXhfoA4UAT5jw5WSZ3ZVhInZSf1srsWAOzAKTpEonRC?=
 =?us-ascii?Q?IRsb8cO0OeeO3jJ+ONXeoje1QA2QHsY7/FwsoHQ5ZHXfhE1/9fiUG34TocBW?=
 =?us-ascii?Q?488N9nF2znuuFT9/LVD97zQFJX8OKI3r2GpW7RudTr8LMNUKxu1dovo/xzsW?=
 =?us-ascii?Q?IRQmgZJDDsbYzQWdslVFksHfgA87qVVQmFAXniet5nKtaf4HjdkCFfaAr4KU?=
 =?us-ascii?Q?TWu3psaq6sslUfkjIWDeippid9W0C0gC1NZsf5InAmELK8mOitAZJEyHhc+6?=
 =?us-ascii?Q?sA0fRnm2ZlARdbxFD5equ6Z44MIN6AZQEcQljRZ0gxBmLWg5Gp0k8rRvVGVp?=
 =?us-ascii?Q?EysMxyBb9sTaUJdpg4vcG3/Lspm8rXfx/2XZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?71UiRtF9CdaSE/EvZifN6gVp562F+yoGBTHAYnpb1Pa0lfejza3Rbwwu0RIm?=
 =?us-ascii?Q?clo3afOv33wqNCotQfnWy6JbUrTNuAOvIO24a+7aPW54E/0W9KE1dGRjcQ4v?=
 =?us-ascii?Q?Yqa0tzJArJeL71G0ysFgsRWBlj/wbB1wO3nARRVmo0ovimsA3Wy44q+rGHAc?=
 =?us-ascii?Q?WmjJq8pEpfGHPm+p8VCvtN6D1TG8nP4EWCMIxs5OSTYCm5QKfwqU0pFjlXGQ?=
 =?us-ascii?Q?Zn8kzT57cHQtwjkuxQtjHlN/qmYrvKjv/Yz96D4fLlA9Gmin6Drxx4muWDbk?=
 =?us-ascii?Q?DTrPnT6Vgt/i+Aube9hYLp/OFt6quiY3Thni1lXj74VQYH9SxVsjS54PH4uy?=
 =?us-ascii?Q?WjSPPPZe48nvhSiWetdFKtNXYkkGeG3Tini9EO1FK1wMjjC3ulLambSid/qF?=
 =?us-ascii?Q?Wg4SIsaawrFD9kxceI4+kNGDuq9TUwXg2frgDTcDma6DzgDXEP0/pf7WaQD1?=
 =?us-ascii?Q?aF8fLculG7vRrvnNI0fjiZs+VAcbc3O974iS/WU2On9km0zaetko9pwmHx1n?=
 =?us-ascii?Q?K8VCGxPTvIwh4vRmOFpu8l9yHnlJ+3CRSdLz3448ajo38pLcYDgiM/F8HAVo?=
 =?us-ascii?Q?ZOS8dPcJO7aIS4kjfm9SYFQYWihX/EZCK5RZD+IeBPl8qgM0cjcGMGHb4Phw?=
 =?us-ascii?Q?gkT2n4YD/Q2vrsKpg5yc+2DvntpD6sEkYRZkD2QOgkRmSlckcBvE6BI9IVdz?=
 =?us-ascii?Q?mMgPlGzRyaBETgE65acERm4zN+5Mnpg2pzK/NAZ6WmE3TNRUWQb/noF3Upbc?=
 =?us-ascii?Q?AFhuT0V7ughTZ8TK92xTy64V9/yu8b4aLbM9hLixK/oQK78M/vUlUml728Tx?=
 =?us-ascii?Q?uStfWkRbZF3vlUw12TdUa5piEa7IoHnM2KQUmhaN68g3w7yj5xBakLaHe+9o?=
 =?us-ascii?Q?9vDXTSadHgVPWtOc1x1H0jM7nC7WzPCmI0ykbwYQri/wI6OGDH38VbQRpIf+?=
 =?us-ascii?Q?4zGuAXZlr+/4p3YYQCbfBYQu2Dd3zoEI1uUVs3yFSffXjY+EfhRsRd8l1WBb?=
 =?us-ascii?Q?2dILV7EsYMkIhgxpfZiTM8hF9comjsUQ87BHbUp6meNMPKEwrrSzaZKWdqR2?=
 =?us-ascii?Q?CpZySL23iuVzb6TGCn+s10yAy7AMyODdgoUq2PcQ+XVHarZabanm+VjC1On+?=
 =?us-ascii?Q?y5fCQcuaCVATE67BDzPRQbWzKfu4YLd+AoPqq020skhrJzOp7qOQeDl0wCcf?=
 =?us-ascii?Q?A7SXUP3B++tK2nwhDEgcBOAuiBsJJl2Jsjas0O9smtQdy9PStrKZQFevz3mk?=
 =?us-ascii?Q?oYzKED+bjUtMktLDI9/nBVGLoWOaM6KnPQ/EhoDsekOL3i86X7id6iceDVz1?=
 =?us-ascii?Q?6MHGWuhhMESZHFzPBXnb6OXXJW6dhans9TcIe7gIj412v6wr/MFwrhWMCtRV?=
 =?us-ascii?Q?K/wvicgXwIk29nXmJXYV2+8CWTo392N4JAqcV6iLs6kAEsVtmCnJM484wCGM?=
 =?us-ascii?Q?uSZOsdUMbLEsOG8DH6r5f5Xh67qcL7BHArFHnyWlDz+2DutYo38GFn77tske?=
 =?us-ascii?Q?OC7rCT8XHT1eY8efDIp0/3j2hiIEuClgzbSJpElREWdaHnEkNfsbw8smWrIf?=
 =?us-ascii?Q?Ei+R0sBNw1gLNhSfX+mQlnILHwtcGVdB9mxU5e5R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b02a241-af97-42e5-bebe-08de0807234a
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 14:13:08.6567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2J1gbga99EGS8D9tsE+9n3b/JnX76JbEYE4GSTabVmes/8tITT3cMNP4p4YoVOofT0Hf9a2VLhdDIeWQvgZs8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7671

On Fri, Oct 10, 2025 at 07:01:13PM +0800, Xu Yang wrote:
> The GPR_REG0 register has an USB_PHY_REF_CLK_SEL (bit 6) to select USB 3.0
> PHY reference clock.
>
> USB_PHY_REF_CLK_SEL:
> bit[6]   - 0b 24 MHz external oscillator
>          - 1b 100 MHz high performance PLL
>
> Add a clock multiplexer to support USB3.0 PHY clock selection.
>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> ---
> Changes in v2:
>  - add Rb tag
> ---
>  drivers/clk/imx/clk-imx95-blk-ctl.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
> index 56bed44719954d6a644606914b61dad672cd82cf..c078b2ee28e81155ca3a93d26c2e757c8ddc91be 100644
> --- a/drivers/clk/imx/clk-imx95-blk-ctl.c
> +++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
> @@ -302,6 +302,24 @@ static const struct imx95_blk_ctl_dev_data hsio_blk_ctl_dev_data = {
>  	.clk_reg_offset = 0,
>  };
>
> +static const struct imx95_blk_ctl_clk_dev_data hsio_usb_blk_ctl_clk_dev_data[] = {
> +	[0] = {
> +		.name = "usb_phy_ref_clk_sel",
> +		.parent_names = (const char *[]){"osc24m", "hsiopll"},
> +		.num_parents = 2,
> +		.reg = 0,
> +		.bit_idx = 6,
> +		.bit_width = 1,
> +		.type = CLK_MUX,
> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
> +	}
> +};
> +
> +static const struct imx95_blk_ctl_dev_data hsio_usb_blk_ctl_dev_data = {
> +	.num_clks = 1,
> +	.clk_dev_data = hsio_usb_blk_ctl_clk_dev_data,
> +};
> +
>  static const struct imx95_blk_ctl_clk_dev_data imx94_lvds_clk_dev_data[] = {
>  	[IMX94_CLK_DISPMIX_LVDS_CLK_GATE] = {
>  		.name = "lvds_clk_gate",
> @@ -519,6 +537,7 @@ static const struct of_device_id imx95_bc_of_match[] = {
>  	{ .compatible = "nxp,imx95-display-csr", .data = &imx95_dispmix_csr_dev_data },
>  	{ .compatible = "nxp,imx95-lvds-csr", .data = &imx95_lvds_csr_dev_data },
>  	{ .compatible = "nxp,imx95-hsio-blk-ctl", .data = &hsio_blk_ctl_dev_data },
> +	{ .compatible = "nxp,imx95-hsio-usb-blk-ctl", .data = &hsio_usb_blk_ctl_dev_data },
>  	{ .compatible = "nxp,imx95-vpu-csr", .data = &vpublk_dev_data },
>  	{ .compatible = "nxp,imx95-netcmix-blk-ctrl", .data = &netcmix_dev_data},
>  	{ /* Sentinel */ },
>
> --
> 2.34.1
>

