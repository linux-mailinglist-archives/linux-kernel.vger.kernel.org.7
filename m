Return-Path: <linux-kernel+bounces-889212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 599BCC3CF87
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D91E4E1999
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BE9225D6;
	Thu,  6 Nov 2025 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WaGUWfp2"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013045.outbound.protection.outlook.com [52.101.83.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FB234F25E;
	Thu,  6 Nov 2025 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451836; cv=fail; b=qvyNOGh3PxxwOzAaJ07N2dj4EIfBMzagHrjyMMDoeRNrHogkENQpvi3Dx0ssXCJIKygQprCtKH7a2sIq6AW2LztDx5MWETtMPOJsPVo9P0XvxPgJYkY7gDxN1mWBXuBf8cTxK2ZVuFdpa/02+bzFDulk/E2NhBNbpWB04PM/7xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451836; c=relaxed/simple;
	bh=63N+X4tiS35nXp2sbInqHAL/66n59zJGn8QOY+71HVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d4i7mbqpTnwq9C0WK6MM8gyyhURZjBdIXyv4SIccUPIGdsF68Eik+fecrCOa0ZH45p0s7sQglwlszu/yAJymGEUpW+t+Y8jOfmvQI6zEZReVcw+nbmzPDNtJlloPj48BFGgFPrfsXTrOB52mPSGQSCa1mZCMV0EQGaGwaXCupwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WaGUWfp2; arc=fail smtp.client-ip=52.101.83.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gw5UgocDPMg9XWaXwlz10p8EN4OiUUu5oWalILTXgLHv6AyhIk/J9GjZ+BM2uPWagru/TtrnIAgJhFd5M+fhrKGcAzTbuf0k/v4zUQ2ROD6x63Au/rHAQZrrPnGjFH5EU7/4SbvsImrQMZF9qH28KE54ZTHZqSzetCp2KO8hka2U7TwKQZ1yo9b/5vWjWWlsLTTs2Vdx1j2RjlJK2MCos0vAttcsJpyMlmdE3j3f9GMy4S0vs+o8F/SNR6WBNp97h2NofzSLtA/htmXNjA1hxC7c35G5AV1af6WLe7X56kkdWE6qyNrRw8+tkxvZyG3/4AwUf9fchZBZdgDhgdX4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9D5/VWgSaUvoGdMc87MGnQOk+hy9LaSzjWdMr00dhRk=;
 b=gCh0DAKBrdI6rpd8tGLD2NFBg7FrLRm4c17czRE5i3uk9Y/BIMpOC96VtN4xTOB3P2Ta9mHBRUsofTSB+AdDJgvQUgigavHJSTnfV0o1SC9ZH0ACXkjjodz18oF852zWc5RCqjTtOr1Ya6JZHQxvBIKchs5ixaWrKvYCgdQmtvVxQ/jQ7jWuMi1iRdpyU2sUt396eijVlMOFY3woCFIFQez1U9YgyAOj9LVN8X3a2JVbN50Hf4172xt1AkAzTjgZZSPTwQDO3Fp/lBAadEvfTKIOHGUyro1z6/VCe3kRBaas3LpuS5ahUcS5J9qNTjYo4VwvVcU/dQ3N9oIaAIxdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9D5/VWgSaUvoGdMc87MGnQOk+hy9LaSzjWdMr00dhRk=;
 b=WaGUWfp2HValfbAFyj+DRkfBa9jAK7GMsvkS7r3Lec5xouQE6Ft2sq4h6gcijd3iEVQYrYSc2YYeU9R2Rs6JZ9Pb+2MeYIsRKTfJrPKahfLa9ibWDMgUYLycL7v4oVPKGYkz6jVlOo0tDh4TT0LUN837lvEaksdDatEG5W0QbFtupaww+or5kXgn5igVE90yXPnU8YrbgUq/Rg7dNwsZod9hmzzqVQiHwqTpvEl58SaKiEudrp0ElQMX73UjRKveMVDza6wgn/c35uf07sj8j8POF3CWy9PTPwmHoCbH4rOFZr7LChu3ivB8B5NrPDjWEIJ/QWYTJ5jMtMRFVZr3eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB8201.eurprd04.prod.outlook.com (2603:10a6:10:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 17:57:11 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 17:57:11 +0000
Date: Thu, 6 Nov 2025 12:57:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: imx6ul-clock: add optional clock
 enet1_ref_pad
Message-ID: <aQzhbZwEYgALKqPJ@lizhi-Precision-Tower-5810>
References: <20251105-ccm_dts-v1-0-6aadcdf97cb8@nxp.com>
 <20251105-ccm_dts-v1-1-6aadcdf97cb8@nxp.com>
 <20251106-seventeen-gilled-5146c6dc9720@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-seventeen-gilled-5146c6dc9720@spud>
X-ClientProxiedBy: SJ0PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::19) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB9PR04MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f2aec1-c35d-4453-0a97-08de1d5de8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9hJaOPlOvUQbCVpiEWc5AeGoOAwHkFB84fIwDKXZDHhLM6TDlfCTnMDeogLX?=
 =?us-ascii?Q?lD5e0jwv5uMrrlUI2lrEBOeVWnsl32JqCIJ9liErm+yKHg4KQZ6duqPvZyho?=
 =?us-ascii?Q?nGVMM+jI+UqYl/ywa4kvTX4ol6pjv7OsxW99Bj4s1NK+MvBseBBFSCqswmpC?=
 =?us-ascii?Q?np2KIVO6pUYiXIgyrk+5RDs+7DKis5yOAwooDW911+QG8YnePiQEikYswXji?=
 =?us-ascii?Q?zmgngyu0luTcgz/RmpNSwq2N0WF7qTWHGvot4BeI4AdMkG1em/4gem0Qla59?=
 =?us-ascii?Q?3e+ee/W/SMWg/G8NRakbIX9E5USs7pxzuLFYdsjwNtbmBfjz19HlDXuFY58g?=
 =?us-ascii?Q?G25pcLKrnWyd4oArZ8V9h8MVFy+CL9F9O81igOZZ93K9Dg4fDU5EdXyrdha/?=
 =?us-ascii?Q?8NEtnXqXSydV97b6xLnZRByZkiSYSmDZ4N+t7os2IOAMXaiicDILUF+8grPs?=
 =?us-ascii?Q?i5VJ7rSEt0gdTtVWBgN/UxAhFq+PduqDsK6eNtdcraIm3iCay3H5GupG29lB?=
 =?us-ascii?Q?8Wyc2+HGTKfsSGlAHxnSUOmdjgoKImuAFcqFQVecZpjck7LX6vPFpA6DXvAb?=
 =?us-ascii?Q?TJ2NCvZM1LhErN6YDbkiWeaUCCVgVZSz0crMCOeKXDoWJaeVM1QTT5p7X4DA?=
 =?us-ascii?Q?aNKiKeca2UwGU5g5mjJQwRwRTAg9+PJSkT4A00Rbj52vyO18BK5eGJ+gASgI?=
 =?us-ascii?Q?Z2xelN4xGrR9zjdkbzAnIQfdVl71SPVGarRlWPy+L9lElr35f5AYF2YePKZV?=
 =?us-ascii?Q?8UKvUzYiPRIPZuojStrbTjmYrilCL8DdpmvlJp6aFqUkM+SED9rwnLg7S7GH?=
 =?us-ascii?Q?1VN2ptrUndBsrW3rzJx2jAdr/6krBn2D1sS6xMx56M27MlgtOtqHaE03oSBj?=
 =?us-ascii?Q?HGw4+lIrZGeLVzccPchaRmNvsZHq9dcqpYaYt8S2FXWtwPVPZ6YQpcZleldS?=
 =?us-ascii?Q?G6hqdTovDdDiQC+X3uLCCoMmAFMYG/TZVoKpTSRcJ7LrSaHwr1YkqSvVqaaB?=
 =?us-ascii?Q?063FG2p6iSt61e9czcjm3MwCq0NApPcR+hi9JErjAKsEdmUd9O/pCyhr4hK+?=
 =?us-ascii?Q?jRFrQ3GHnz94Afdatz4U22zArLmyhPWyNcFHFolM8kPmhkSR65riEDzLWnfF?=
 =?us-ascii?Q?lbodzwCw1pn8uPySRNl2qQltWTWlKKcN3gw7DjMxLa1I4jXirwkOPyPPjUQd?=
 =?us-ascii?Q?fq/ix7bNc1UyMN2BjoSADvljLO6wpLpcmeEZ2egP7Au45ABnJKF1DHYucEhU?=
 =?us-ascii?Q?7hdc4Ex7sfEGptpxhqBThf49pXudhCGBIsTa6foIlV/gTnKAOo8Ot0qg7vWF?=
 =?us-ascii?Q?4SZV5Vt/NrbvxRbv3jLUOr7BngNhLiddxlGJa4uADOIxFwF1TriJnjpjAcoz?=
 =?us-ascii?Q?ugVpdN0fXAXUazcfJDeEwy7DescNHzDeKW6uWwdODbKZaWp7ncbk3voq2+Q/?=
 =?us-ascii?Q?URLCHiuyVoNM6c0MCHItwhHIKLNrV+AJsuzffjtwLqKGhGRHu9blbbMwl323?=
 =?us-ascii?Q?A2XwxAldlu8AYBTn3mo8HOthkHWyakkfQtji?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GLMkaSHf8njaQv1EgjViDsRPthjAAomPgeJSlt/NTi558nZqukTIwe59MSmS?=
 =?us-ascii?Q?cWFfcmyXKfsJbP5oO5FFJxq5dSSpv1IIIP+WRU3qc37fcwzqRHuI6vHjmnqC?=
 =?us-ascii?Q?TNx0yrg88vQ35kaZ0gjnUOYj1OMB0d2JI5Gl4/gHvblSqF2SeVQh5cuGJiom?=
 =?us-ascii?Q?xxQbEQ6RQ9r20PJxsAQ/3Sx4gwjCTl2/websAywnztSKGryyCcWKX/LQ52Zz?=
 =?us-ascii?Q?pQYwfRlLU/RATXKG3CMk2I9SqusokMQzHBZ1KCT21jxgYHH9BFVmnqi01hnQ?=
 =?us-ascii?Q?Tzn7ITirNK3vBIWh3EWaGmA72T9YHRXZsokNOUDTHr9PyOBNedAq5i3K/GbK?=
 =?us-ascii?Q?MV+Ls41YRLstrsLcmykN4NkHFkk5rYP8Mpse4I0DLOeQrQm5ZCjuf9dxhE0i?=
 =?us-ascii?Q?lDiuinaKzGAMaW4f9azHKK5N2oX4qmPLoidgtWn8RiQqEpx/okHiqIccNzbU?=
 =?us-ascii?Q?PgGNsU1VEzZleaLCgGyK3ndwLCOr4/ZQay75i3N4TGPw3DQC+akhgI/ZGhFJ?=
 =?us-ascii?Q?opG6zZqVvh7lngh2mOJ4gM2+Lx2KE+RFezOaZh7p1r+1wyezmg5fvw74S39x?=
 =?us-ascii?Q?4HYFd/4ZFi5ViaofBmJauuoxpxXbRcHCVAqZYWMRZGlqKkGlQ6CLLWYF7RnE?=
 =?us-ascii?Q?Pq0Gi0GB3WP6jPa8QuJ9qyTOWhpbfJfNdw/riD+ZWCedW6U8wVCaf3lP834Q?=
 =?us-ascii?Q?KfIHgXmIJT5+shH3/PqGTL1h4/zups8mb2EhayTqsN0fpQAVBBl+58ikM1VN?=
 =?us-ascii?Q?zQuoFsTfBughSL5cw8DJjC0sUfwAfmaPPtbVQA+7s80HokNukr9SXubS1Cj0?=
 =?us-ascii?Q?9HlGNWYhmUgjgNz6eBq0r64w39Tp71nAeZgslr+38MYDQnBry0po4lmxfEAn?=
 =?us-ascii?Q?4xlXfjVE9dDtdVZz2chWwkxG6+yrObWwDedBm6JSTmcrVb7ClS+GvbxpaG6Y?=
 =?us-ascii?Q?30SDGcKUfmZ8BPKQg4vycwkUeQ5tcdmi8GISNPjDtGpyyL7Dh1t9joXNdFjX?=
 =?us-ascii?Q?Xuu7trXdxNKfX0cPxO6KLDM62IwG8lYl1xomxojj1/Up2atQnUnc5tA07PkD?=
 =?us-ascii?Q?kbS210BPapXuQHOT2DFZY94pD0ZsFE2og+oIKj5jTQYWTNHurlGlLiIuxugn?=
 =?us-ascii?Q?i1R/Ud633kMTuWhwjDyBkk5VX8h2bB5RchcT8xq/dfjgFBApXOJytRp00hHJ?=
 =?us-ascii?Q?6UySoUtXdSduUEafZ1KNETH2/oQ0Qsjbfa00nVjPSDgODjCEvYsK7nm6TL8d?=
 =?us-ascii?Q?nKaViu690gnW6gR6XFmXMTjOQWUNe9x8PLu01ztJb4Ts1qb/VZrNYxSeEvec?=
 =?us-ascii?Q?W9giqpW/3DfpXSllPA87LGE57gGF0v0BgvT+TqITpiIHqmP+ljoyXeQXmISl?=
 =?us-ascii?Q?4hNs1YhxhbLWRfJhK7d+gTF/iEGcJtJ0aclG4aPGfXz3xDvyfPxMivl/B5m9?=
 =?us-ascii?Q?GsjsQrB1JnnMOT9xDSQ7WwBDDnF3ddBfc52sC4IzobdoBs9UznETkh6mAE6y?=
 =?us-ascii?Q?+yQdvVPXaDspXkL+QeRJb0UVEGDzPWjO5EecxD+XBoUFNd7rj4/MMr1FERN3?=
 =?us-ascii?Q?qcClA6hjRZcitrhrIuYctt8EO55iwgJVDT+trUDX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f2aec1-c35d-4453-0a97-08de1d5de8d8
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:57:11.0349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gw5wTg8PWJGojkOnzzQ0iZ8r6pNuAiPDmtwoV6vsByKjWRq/kiAwP7bvKhgn0pRk99YYwzVo/irS+qzD1Og8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8201

On Thu, Nov 06, 2025 at 05:44:36PM +0000, Conor Dooley wrote:
> On Wed, Nov 05, 2025 at 11:55:28AM -0500, Frank Li wrote:
> > Add optional clock source enet1_ref_pad, which input from ENET ref pad.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/clock/imx6q-clock.yaml  | 4 ++++
> >  Documentation/devicetree/bindings/clock/imx6ul-clock.yaml | 4 ++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> > index cd3c04c883df4ab02af29582369757df36269cb6..49475aec22a81ba87048eef588368261cbb38465 100644
> > --- a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> > +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> > @@ -29,20 +29,24 @@ properties:
> >      const: 1
> >
> >    clocks:
> > +    minItems: 4
> >      items:
> >        - description: 24m osc
> >        - description: 32k osc
> >        - description: ckih1 clock input
> >        - description: anaclk1 clock input
> >        - description: anaclk2 clock input
> > +      - description: clock input from enet1 ref pad
> >
> >    clock-names:
> > +    minItems: 4
> >      items:
> >        - const: osc
> >        - const: ckil
> >        - const: ckih1
> >        - const: anaclk1
> >        - const: anaclk2
> > +      - const: enet1_ref_pad
>
> I think you could drop the _pad from here, and just make it enet1_ref.
> Only a suggestion though,

The old dts already use enet1_ref_pad. But anyway, after I double check
that it should be enet_ref_pad for 6q, enet1_ref_pad for 6ul.

Frank

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable
>
> >
> >    fsl,pmic-stby-poweroff:
> >      $ref: /schemas/types.yaml#/definitions/flag
> > diff --git a/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml b/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
> > index d57e18a210cc1d8a836b50058613dfb0308fbf11..035002721a3b3b65fe67734e13b686b91539f328 100644
> > --- a/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
> > +++ b/Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
> > @@ -29,18 +29,22 @@ properties:
> >      const: 1
> >
> >    clocks:
> > +    minItems: 4
> >      items:
> >        - description: 32k osc
> >        - description: 24m osc
> >        - description: ipp_di0 clock input
> >        - description: ipp_di1 clock input
> > +      - description: clock input from enet1 ref pad
> >
> >    clock-names:
> > +    minItems: 4
> >      items:
> >        - const: ckil
> >        - const: osc
> >        - const: ipp_di0
> >        - const: ipp_di1
> > +      - const: enet1_ref_pad
> >
> >  required:
> >    - compatible
> >
> > --
> > 2.34.1
> >



