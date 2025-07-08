Return-Path: <linux-kernel+bounces-721834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB02AFCE6D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885F4188715C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B642E0923;
	Tue,  8 Jul 2025 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="N0QXvoBv"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD922E03E9;
	Tue,  8 Jul 2025 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986806; cv=fail; b=iHn6YjwOLKgu8deWeBSVZE0DCGGbXF3qN0GyLXmTdxi1W6SdgXGy9Cw3WmoDTum7Pdcky4s0kEEh1T0KEsnHsigc25+2UdzWu2OQIPIucU6mlYyxZ8o3Ly8pmwRNNBY6sTJFM6Fe/lK9ItRtw53+B2837hzYaPU0Yb5pd51liR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986806; c=relaxed/simple;
	bh=D1gLF0JL1oLvLh3wT47P1+a0X0u4VZYaDRTEVyatjik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g5J11CX/qgCbtMzDrZqQ23QPIiAn8LloPG63cZCsp146Zq5q63iKhCLjRcXTgngRQ1ZjuDTrue/nWLl9KsWMTKiqcZA7AgcRBynC3S9YdExyrd77w3Lo4s2xW2GDgi4alyu4Og8HRmV+4JpHLCulBlAOvKyuAr4W649LKNhdIx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=N0QXvoBv; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vz2Oef5IiCd6wozSfuEx2pQKtG30VVZCtly+9sPZQLqhTAJP+pvY6ZMUarBX580goD6i9IM3ivRYR59ZZXO8afEStjdT+wFRNLrONvEJx7sxQwQFZbmsSaYjZPPf4OF6imLvqzx0ds4DEJJEItMigsgTT4Ktq6eOXb5PyWVKCc8jNcURmcpfyxfhtcfCTvSADV2db7E50ds7mHRJooiU6Ta4+Lc+uicrVq3ZB8UoSgXeWljSlRluPCs+dfiL0a+TeCGIwW33G4GsHmbfJTTdruQ1dvEEOMtgdrSTAgx2plx9wbYUmb14c8+LWaloCKGe6OMc2tEhcqcdtjlJdcJ6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wy6mITw6F3LXNDHbYtpx72ZP8ZmclUjNX7PB6TIEDw=;
 b=CzfA4yzj2gZ5jbWmiZ+T0jd3ncZj5KzjMSjhTHK3xNRmLUsetxs85SPxGhMYntZ3Os7sAmZgZha7X093MeMMpXqIbIOeh4JDkh4gfUHZ+Y7FarjP3OBqmvPFhDRlsmy9uYVyYI5PcdxsVsn2dNP15x2bXouJMQoNInCO7vSO77eGuan9BhVn9q27hCQqPQtF/cK02HUUAkX6Hi4QwE+RexsM3iQm+RZ9tz7brkt8e5M00FoJsGeNmcqIGn9ny5yWw/v/JZnFbf9Lm2wi6ZTIrcFei93BPdicPikPa313n2iB0qhHEKRUiERDQmVHDJfCb7l9LLQ7dQYPFHhpqiss9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wy6mITw6F3LXNDHbYtpx72ZP8ZmclUjNX7PB6TIEDw=;
 b=N0QXvoBvi3wxzgMhXEFQC2b/EtF53aEYoOGFSKLK2s8L+Q9MCzWaKm1qXSUQ45vlG8uBA9EjpUqJv6yl2BIifRxwcg4i5JCgaRutakJ/A+IJtINbez7/qF2ynwkyFFXtuZhsftLDcAuWG4v+gf7BpqoDIQ29iSItGl0PYb+23WKSsaPtkyDdn0nZJnRXrBFi8FlPUPlIMsWS9cb9tptBtt7S7Q//XVpZFBaOggQFNoZeQvWpisUqSZv/C3sjJsFirxQtQffpl6ueGw0KXtOtRwv92zcXZ4CZINQPkei6Uk4egYelGdVT0UpQvFZYkDn+Tb1uo8h+BPaFNBWGnlsc8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9835.eurprd04.prod.outlook.com (2603:10a6:800:1e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 14:59:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 14:59:59 +0000
Date: Wed, 9 Jul 2025 00:10:06 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Chuck Cannon <chuck.cannon@nxp.com>,
	Souvik Chakravarty <souvik.chakravarty@arm.com>,
	Peng Fan <peng.fan@nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, arm-scmi@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] firmware: arm_scmi: imx: Support discovering
 buildinfo of MISC protocol
Message-ID: <20250708161006.GA13177@nxa18884-linux>
References: <20250627-sm-misc-api-v1-v1-0-2b99481fe825@nxp.com>
 <20250627-sm-misc-api-v1-v1-2-2b99481fe825@nxp.com>
 <aGVOhMr7vg9Sl7Z2@bogus>
 <20250704051204.GB4525@nxa18884-linux>
 <aGeX5NQycd5WFxZ8@bogus>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGeX5NQycd5WFxZ8@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: cc47d658-ec19-43a7-603f-08ddbe301a8d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hjFKR8zB2ZdiQ+iQPemLhUuoFXtOtFpLRt8x3B2fR9llbvBLRM0+bX+DITH3?=
 =?us-ascii?Q?D2qHCqRCd0tALegB9B14phFVY33YclxOIU5yr7PFeAFuzCG6rJGlmX8qbKpc?=
 =?us-ascii?Q?MofmjFhs15nqbtDskafi9QvE39zoKmowcqQTof1bBV4lbXmLGT+1I57WqZ6l?=
 =?us-ascii?Q?cI6SIb5lIHsoqChx5WVbgqLvCz4XD/iL9rGWpGi8BlmRBPqSIitbCYjSk6YZ?=
 =?us-ascii?Q?/Usthm8nddNy0VB6EFP+Xd0qtnRjbGteJgfmt1SRjleEbMLp3aSmlUdZuSiE?=
 =?us-ascii?Q?I5qqrDPojFSZ253JM9lt4ItRxK1QfA1g5BEyXPMjH5eBLdwUZ5ehngbkhTlW?=
 =?us-ascii?Q?xuRN16DbjizsuP85rnYKB+QGV7Y5SD+xc5LuQZeBb6RssIxDuH+peuskchJ7?=
 =?us-ascii?Q?IKYHw2LB8900P9Aca+QQCRkvzjPhja5M5EBCwzRUBz74Mno5T5Y+Js4ZniX/?=
 =?us-ascii?Q?HcAWGhy5+t7SGhaYGm4+fxOn7ExBkokJIcRBtFRF0zYCrP3Ei+TLghnMX2Jw?=
 =?us-ascii?Q?pYvsw2WM/sjTqqGcesF4uI8g0u2ovtjXjeuYbm1PDCr2zauUoKTB1faF40ip?=
 =?us-ascii?Q?hw0zJ8stL1QaY8HN+MnBnSk8yDGDBWJnSVEPfPBBFrwiYVxlxuzC9EaJKpVu?=
 =?us-ascii?Q?ViehLcTRayiApiy/Vp2vk7ctyqmZSPFW/3EShXnR3fwx+EHilQ8VAv4CV3LD?=
 =?us-ascii?Q?n4HoEzE1dp7US2dqOWP0Jc8MXxIgoIE1llhYhKdUnnDy5cFq48lIQRPxGWAa?=
 =?us-ascii?Q?gyL955MU+6RDKo/JT1ZdldPvsnrxHbWjbTcz+vQeSAVXX38fXm3xAlagRJgA?=
 =?us-ascii?Q?S+8YuR/XmksMq9QeYuNyy2az1c+uDnxQmASFr48UC5NnyDoNa5x3XPuHNTuH?=
 =?us-ascii?Q?6syXW1ORqGUq/y7Q5zx52a4jOZUivp5JcG/P8rmrKjyuIrxkyyXTJQhkc+W+?=
 =?us-ascii?Q?M3ipN376JAGt+voMLCaUVUFgB+8P69ecBTX6j1uIXkibXMYUo8CQkJhYLks0?=
 =?us-ascii?Q?nfDndo7OFWPurUEVL3KrqYOD3fWahzEDMi04m5ZZICwZgUmmkz5cXOukgVp4?=
 =?us-ascii?Q?xRCF57rPwSeq0zJ76rpkEsWKuFkvUy+9BXoZ8VJiCS3tHjq1FJK+e1VtLJmG?=
 =?us-ascii?Q?hm6cCZvDE8Ja1AE6Z7T7gaLeLqpWQ//ittufq65iCQrb9yfxAMyiFKl8QgyV?=
 =?us-ascii?Q?dRr08uU/+2BS5KyHAggj78EB23OiXKNrKgRIbExMnSJFOBNByJD4WC0dQF0E?=
 =?us-ascii?Q?8cdB/SNKZBsNfAEEjY4iltRyFSiZ5wEp4n2Okrttba+Bjc+GhPrzTOp6gA5R?=
 =?us-ascii?Q?FhDCUxraz3V3GrCeeEsp4CXYvPAwG9U9ZTO29/RN7W9ZZKa4NNfQu+wUE/l1?=
 =?us-ascii?Q?boDBWcrMU6aVD0MQucdPmC2AugJbF3YLE3SW1Bo1qqV2Qb9rywe/5gRp2Z7O?=
 =?us-ascii?Q?BxQyH/QuJyRt6+jak/xozNRajOBBjodJK8PfUHXQfSZO9FMnsjkbmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?61PVceliUKbTeyMIL2WOYDwCFhWoKEbfqJgGThlKLZC1ouqIaMf0ZLMvbSQ2?=
 =?us-ascii?Q?o9LYqcHveXtHHUOLVRwT9URZ0FWZDducafLhz6/cnL9KynKuDPW/3264JH4B?=
 =?us-ascii?Q?gmg2gGytIvv+WgSQwAZu/XvOXzQWsHSZ7h/OrMZwgu/WkeV920AzRLCwun4N?=
 =?us-ascii?Q?PJKJvxy2oNQ2UPL5np+aqbw/R6j4EeDP5iCDU7b2TehOPiJz9YNYZv+6R0df?=
 =?us-ascii?Q?RaBwQqWmoU/ufsbiUcsZJtrF7WH/gWJhPyVaPwck2AXXO9UfOj8XRVfJMQd6?=
 =?us-ascii?Q?c6QiZtDl5DHjlBf5rFijeYUawIi5zUqXFN3r67grNGFGD3FpV+47PoWr5qzb?=
 =?us-ascii?Q?P0JwilR56d5SEB5Ue3riF9d0X1tMvsk5yPkJvv6yn22BZOTUOEzaDzd4eFpo?=
 =?us-ascii?Q?O5K6f/zcR4QyXPnYQ0JFxaur4C38HdzQfWKNTnB+HbdxxImThnbwDzK5+D53?=
 =?us-ascii?Q?K3aMLym5q/LnRN1yMu2HXf2n2jQWrWUBi5vnCyXIvG27ldevpYcqmbV2ujIq?=
 =?us-ascii?Q?UIeC78rwuMAX7bnlXGqzt0gAvg1CN1fg4sdLna2KwnZXou6n+gWNx4mNpBJz?=
 =?us-ascii?Q?0gU3Qtf6Jkoz5h3UMnuzD1D1Tl8lcbR/1NUEU6rquNdzoXbf1BPwFde7LTnO?=
 =?us-ascii?Q?W59H5XuiJ5xcWzy+P4DhzQZl4rgNFLmPOOWj1wqdoJNPBdtzS5Izt01AxLxx?=
 =?us-ascii?Q?KZPx8vzYk3fV9yv+HLYJu24u0n9lfvaNtTOe+z/K6cK3oG0Vqz+0hY9A2d9x?=
 =?us-ascii?Q?FprPNYuLjuc/msm0uDYvHrvrP4wKAYZ4lUoneQ0OnIumMFCV5GI0Dx6B4DMl?=
 =?us-ascii?Q?1bVftkaRB5DNq8u48CM83lutH0hqdxBTGscqwQjONZp3DX9sDTq31F/Y2WDJ?=
 =?us-ascii?Q?YCXGSl56P6t+dCxoUgr55qIgUquUA/HtHzrzL3Il5l8jBGSLeeJ2iB2+HHgq?=
 =?us-ascii?Q?5TnE+XoRpf2U3wo+HX8lJfwXAPYs9DeQhjmw0DF5+7ZVtkrke+POPGWZV2JG?=
 =?us-ascii?Q?pXiDbHNtQAerncAG3YuDWb17Sx/4I1TsNPVLVtcALt2viRN1k8cjP8AVf10m?=
 =?us-ascii?Q?T5n1IQVswPOgnuPIIbFYVbZ50JFYd96KcE+BNpE1YPDNAQAgbepE8qKhebWh?=
 =?us-ascii?Q?39XB4f1yvhGN38JTnZZP+6C6wtOzERNJILyw46r2WwjVBy0bfREAI4eQCcwQ?=
 =?us-ascii?Q?74b7LOxLLYfYlxtbJtM1GlYWTH5PuDhyIqB/6sYnDpKJWimHUw6xQR6xxpdW?=
 =?us-ascii?Q?fw8COYA+GHPIjYO1PiTh8i0byeO5M+3CrZkO12fL+qDtEIr+OZIoIw9wu+k6?=
 =?us-ascii?Q?K+5Rupfj23+H2CJW7YiK6LnRU5yB2pr1Gpz45ixBmIy11W1n/rvuKKAOUXnc?=
 =?us-ascii?Q?oF7TNT2Vy2YcmN5oWUtdd/DhtW7saFoRdOcMiu2XDXrrcw8CpyuDdqBVMrnf?=
 =?us-ascii?Q?cfZ3JPDP//Cmb4kNqt1pRFAxwYkUQqLhC35cRepbKuowcXppW+cDqTbyGOmk?=
 =?us-ascii?Q?y+jRBFdoCtI/c5l66bJXG/+ZJwXJzfTcIfVahGHwmjXVLiifH83r9zfzLIik?=
 =?us-ascii?Q?gmlQglTIEDFMPY+xrZQwqRH+UsqpOJESiQNoVzgi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc47d658-ec19-43a7-603f-08ddbe301a8d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:59:59.6953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ce8Qbi8vstvyfoRerM175gbjimw7c7R7q06+zaKNlqeaZkTiTFG9fbT0tNmHxwCz5aMuyAcpJIZy+I6v2GwgNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9835

Hi Sudeep,

Sorry for late reply.
On Fri, Jul 04, 2025 at 09:59:16AM +0100, Sudeep Holla wrote:
>On Fri, Jul 04, 2025 at 01:12:04PM +0800, Peng Fan wrote:
>> Hi Sudeep,
>> 
>> On Wed, Jul 02, 2025 at 04:21:40PM +0100, Sudeep Holla wrote:
>> >On Fri, Jun 27, 2025 at 02:03:45PM +0800, Peng Fan wrote:
>> >> MISC protocol supports discovering the System Manager(SM) build
>> >> information including build commit, build time and etc. Add the API
>> >> for user to retrieve the information from SM.
>> >> 
>> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> >> ---
>> >>  .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 35 ++++++++++++++++++++++
>> >>  include/linux/scmi_imx_protocol.h                  | 12 ++++++++
>> >>  2 files changed, 47 insertions(+)
>> >> 
>> >> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
>> >> index a8915d3b4df518719d56bfff38922625ad9b70f6..1b24d070c6f4856b92f515fcdba5836fd6498ce6 100644
>> >> --- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
>> >> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
>> >> @@ -25,6 +25,7 @@
>> >>  enum scmi_imx_misc_protocol_cmd {
>> >>  	SCMI_IMX_MISC_CTRL_SET	= 0x3,
>> >>  	SCMI_IMX_MISC_CTRL_GET	= 0x4,
>> >> +	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
>> >
>> >I clearly missed to raise this point when the documentation for this command
>> >was added. Anyways I assume, you had explored all the options before adding
>> >this as generic tools may not be able to pick this up. Instead, I would have
>> >just stuck with vendor version in the standard protocol with build number
>> >embedded into it. The date and other info must be implicit from the build.
>> >
>> >I try to be more cautious and ask questions in the future as I don't want
>> >vendor extensions to be dumping ground for really random things like this.
>> 
>> +Souvik
>> 
>> And Loop our firmware owner to help comment. I just add what the firmware
>> supports here and allow linux to see the information when the firmware
>> does not have uart output in some builds.
>> 
>> From SCMI spec, it does not restrict what vendor extensions should be like
>> as I know. So I am not sure what we should do when we define vendor
>> extensions and what I should do next for this patch.
>> 
>
>Just to be clear, I am not against vendor extensions. I am just saying
>this interface is not strictly needed. The vendor version could encode
>this nicely and you could have a map. The only and main concern is having
>such extensions will not help generic tools as these are very vendor specific.
>
>It is good to have firmware version and other related details in a standard
>format that anyone can understand without the need to dig deeper into vendor
>specific extensions.
>
>Again I am not saying to drop these interfaces, but you will get questioned
>for its use in the kernel if that doesn't seem like the right approach.

This is mostly for debug purpose to export the build information to linux,
such as firmware commit hash.

Should I still keep current patch, or do you have any suggestions
with current SM API?  I think there is little chance to update SM to encode
vendor version to include build date, build num, and commit hash.

Thanks,
Peng

>
>-- 
>Regards,
>Sudeep

