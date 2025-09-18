Return-Path: <linux-kernel+bounces-822265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 003E7B83691
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B6B1C81A68
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D0D191F6A;
	Thu, 18 Sep 2025 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="v+8FpZgF"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012014.outbound.protection.outlook.com [52.101.66.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C222A523A;
	Thu, 18 Sep 2025 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182486; cv=fail; b=fiAKWlIxD+B3PLLGs5spOWnE4x/D38fEujsZ8q3eN1iE0ma7ntWSEGYE1qLmjGAR32Pjy5XvUZxOxqISl4LT09idDZAE7ilEXVANmm1GuRPPs16VvW83LHqHWwpgenrn19klDfKjbG2GpYJXM3HIONIN6wTAMBGkpLBqko5qI/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182486; c=relaxed/simple;
	bh=5o68XfI/ASorIZV3Cp1RW6rVq0B++NwFZ4FyEuyK0cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TcpfLIagbtSpsnE2tXOK3EJKlsJL0utilyT1FoIDgySAVMeqlkZo84sUVptsrLGPi/tHm3Whfa7bDfEYL89AQ5z2GxPBeeOEZ002bDCrQ5D7BO5fueMy3xItg2p7dS0PLV/pUwzhFjIQEFx93X23FkVywhmQN3/QiqgZKQrs/oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=v+8FpZgF; arc=fail smtp.client-ip=52.101.66.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhFu+F1CY0BOcvcS3SK32YI14J29FDCFVBr9k3uLiIwkNhCB6ZekBtK/Vj+/t0gl7R4Vg6bopQat6W5nA3EXoVeX+Bjp3LN2dqA9feWYS8VUv05WsswR3BElDSA3li2qdkaCAJ5243YUwJ4cVWIcWIas9sg/BIipJm6L6AAUXUIUayiGQksQ70nv63wbejF5MLilNShydf9Qast57Jzo+mmfMKnqmfE6R6aq7xz7JPNxNL8/mM5sqH/SvUAnCUNN+X+K85Tj4ZmGA+F33DpC46Z8MDOB6e27ddHByYswFyZu8l3hdocUGttU6o9sKnWFW+iq63Z6ZsBkpNqfovK5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5o68XfI/ASorIZV3Cp1RW6rVq0B++NwFZ4FyEuyK0cA=;
 b=rd8J7gM7Y4G7L20Sdw0FM0mYp7uLZSYYtgP6kpacuIOUad1+ys579+p6nAy3R5/SN4URvhNY2psVsT2hw3W2pRhBIrVLsapnulD79AvhxHtyJqyiwjlabgmLD0RUwFjiODjwaJqIyKUzrrm8per4AS4RTkDrwOEbm2RF+naH0eRx+Zxf9z+ohTaA4P+R84QU8yTeciAjJL8Pq8M5Ux39M2iFjsKm6v5uxGuqrcE1zknzuSw065TdkBBX6gnsKMwHTLpMHdb0Id9j/0YrdBemYaDx6/skNmFw/kBZ0oAFg+S5X+HMsCRBCeyPWItbA83FOeqyZM13VofE+f1TTbhjjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5o68XfI/ASorIZV3Cp1RW6rVq0B++NwFZ4FyEuyK0cA=;
 b=v+8FpZgFri72H8lekJh77c8Ublym3zuOxSFxjIoIWHHWbJdA7mBTPKBtqe/ObY7nlOblD+sKVpkSZglb/01Ye2MdR4GluK6PTVVR9IahY7uzqAvY7hJXzQ0vh7uUL8KLs4q16Ij3xJS2wxSPRLQDkJ+B+/DksJ6SeKTigs60m9OlUIVRjkW5UmWkgKXMhWR5zv7MaG4RvQEVZcrCMbyauRm7bUPHJd5doTCOGL0XRqLh0KVJsQAemmGkN2BsxNZGdv1OjR+kgXggFwP74CRai253D56HIyRLKL/iN/qxMt9KquSnrLj92dNRpqoKfwHD8cmTgB06aTgF2hgeeHk/AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8268.eurprd04.prod.outlook.com (2603:10a6:10:240::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 08:01:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 08:01:21 +0000
Date: Thu, 18 Sep 2025 17:12:59 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] arm64: dts: imx8mp-venice-gw702x: remove off-board
 uart
Message-ID: <20250918091259.GF23028@nxa18884-linux.ap.freescale.net>
References: <20250916153216.1042625-1-tharvey@gateworks.com>
 <20250916153216.1042625-7-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916153216.1042625-7-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: a97e4188-b18a-41fc-e92e-08ddf6898e39
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?o2vVE9Eqct8c/5lOMwpUYBWPKnoxYwBmHOlywXYFFm5dzCArBA4PqNzPaJqx?=
 =?us-ascii?Q?MhetmTPjWcA+MXHf3WDBSne9Un6qYHUOIg3p3PdDErNS3WjyrjIUUipFrM3o?=
 =?us-ascii?Q?szjDMvGkAwAgN9Npd5MY5DNLT5bCOm1PDcKIsgSEG4zXlbJU7ye5Z4wMqMnY?=
 =?us-ascii?Q?bSZMQ9RxWETcDU94VYVLuOdV+RD4e9tW68zA9U4X6EiKcpkGwuzrpeRLwkEj?=
 =?us-ascii?Q?OCSvqyG+77URrCURKiwT8FN5YfnhAdHdCOibobJvKolzCQFyxPoZrLKEjs64?=
 =?us-ascii?Q?2K6xzC/W0wl2HyQrEjoqlnUBi9rIoj93Rh22xufMZX51Y4LgBFngQ22Oys5k?=
 =?us-ascii?Q?1xIvBKwmzKkr58KZSnqMFvU2L+p6PNqzTsPGBge7bnJriwS8FEAfRl2IlXtT?=
 =?us-ascii?Q?zah/ZL+VPzDrRQxjmdV1x0AEWJAu9ojhPJ/4zfwR6hWOtQV1Vk6yNctjllOY?=
 =?us-ascii?Q?1lPk+52uwiC5G4RWGLcCk1/isE48u2T6ojPuFm1/ZQhnCbjlCaoxldiq5R5J?=
 =?us-ascii?Q?OST1E0QLiwjCeMlmN+zPT4umhUBrtNhBBl4gs8W408UAD6c/R+he7shTqxBP?=
 =?us-ascii?Q?SqUw+PdijbeDpz7jufW3lmdmor+XJvl5PZKGxJUfS3quK1pzZ0goOlqP+pUM?=
 =?us-ascii?Q?U/2cJIFG34ioguY4o/fWhgnsHH38+4HMo6ODjbn4bEwiqGOw+jw4h78sFdQj?=
 =?us-ascii?Q?UV89VXaJumZTej41LDCPYmkBCAkuilKBEBz8Rjt2ThPj2/7SZh1q3WxL4wJO?=
 =?us-ascii?Q?MbDSoT4/CX2zTchjxhpS1eCPps5iZ8ZQCqUe7sYcH67/udGCywwzm/Apkasi?=
 =?us-ascii?Q?yx0aJzy990W9+xI3AK9VjYWQVi+K9lwmXTVyVFXcHRbNmD/YvSxMpeGL15it?=
 =?us-ascii?Q?XMErFM6D3NTDCoZ8eXeI3UVKsa0ebJOGODl9+tpSKoIf8t//mmSQZZdgUbIY?=
 =?us-ascii?Q?1O41Qd6Eb0MhXw2ADpcEteHhShMQ73X4elXIJNB6MPDszMSlMyxVoutsrX3v?=
 =?us-ascii?Q?RUM2m13uLZgSpmLwvV3p/XZE6WLtbYlYeKWqonmwZ17LXLEKP46OFJk+0nfl?=
 =?us-ascii?Q?cLsPoVnY3jg+IZT9OQWUZnurHsbGaEu+P1qhRbSFR/wKfTwWgnWKpC0cBAeK?=
 =?us-ascii?Q?/2lFhrYEpmdxGH1QdomhHGgdUiHLAUHClKBBry9ROMa8CSYfg5e3gfhwfr1E?=
 =?us-ascii?Q?vpZfmJKk7Y+TX61U/gPzbcPR3NWDZcIJtzXMrNt6myqYr43Qh7uM/szw71tY?=
 =?us-ascii?Q?50Oy7MBXndgvxcmc1iHgMidamJyEClGYZ163aNFQaMfIzmdL4hPBP06ChQ7V?=
 =?us-ascii?Q?57QlE/piDJh3Ci1WMdAGnSMPXbeP3CCmEDH0hHmX84E3lmWNsZ84jh9hcs3k?=
 =?us-ascii?Q?J1v3evtxoegdQrhJI/W03u8krT2Dv4S9xX/H59OcgMzpgBlcfWkeRI/k9148?=
 =?us-ascii?Q?RSKX2d2J0Uh5brsve1EQ1FHfFykA2xflrEAp5scEe/h2eIUVITqdMA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?fuqcYnvXUgTbGhdIqYNj/use+hhN3kjSuwOQrpdbWXvfFzpTWXIWiaYufEc7?=
 =?us-ascii?Q?pwNSHPbxmNIeGHZpAhZzz0NbTGctO1t2ktI/fPV8NNV32oLNNP3QL3QUr09d?=
 =?us-ascii?Q?/AyrdPoJxYxHCCK0bR+lfivgOaAqaiQzE9hbtp7dhMWcESKTrts0AytJLZ5l?=
 =?us-ascii?Q?3juMzQzM5ODqofIynLdDjltoS+2a0jSNH6daGrfW7McflBEo0PDqGBDFbW1i?=
 =?us-ascii?Q?6kmXPKiSVKMUF0PNOXJ0yulj0cpdN39Y6Fg1BP4ePrHLupiEA13LB7tWrece?=
 =?us-ascii?Q?nwqlgsJVlpc/Vy7LDEwMkIXC0GzPIlCVmK4pSiHwNy1Ss47UgcnZqgRQAl3A?=
 =?us-ascii?Q?TLWtGxoT+grIFzWiZ2Uy+PE2MSVeKveNO4kiioo2cAcNzg5KbVQGnFMo8hXF?=
 =?us-ascii?Q?NM9DyenNXqtr+lAtNf/H4/cYUR/0YblDyqNmJEWdlnNy8/ysahBxE+TDj8Eo?=
 =?us-ascii?Q?eZ05iFoaF73iD26u0ovrMQsVGhy7Vm9N7UCxI11jahxXmhClW771s0TCVOlu?=
 =?us-ascii?Q?gAoiHNJi2mtXfqecKpb111pG8TlyogRbS2axMIKRj3/A41YpX667fenhc5CO?=
 =?us-ascii?Q?HOWIFb94FWBiEwDUyL51jfc5j6WKF0xlJOBx15x0S7zVntW4frrxduIx4gZY?=
 =?us-ascii?Q?CH3dgOzCuRW4gathIp6lA/JCYAnolztnzKAOAF9H5p31RFUfHsoTfFtAdRE4?=
 =?us-ascii?Q?4m/MRnMghkUTriBnDi5Pk5aa3E1fnQh7Ycf8OZysZKkm6w8hY/3BQ8vwanbK?=
 =?us-ascii?Q?miGhGsvVcy8tqQXHLAmFg3QlcfASFdtiEf4szhRE0xFMBycMmacde739S1xw?=
 =?us-ascii?Q?jqXihabLZy8oVWWdORvZpQVnUyfLF3Op3Jz7N4XmWE4MQT06saehQQY1eimE?=
 =?us-ascii?Q?h69GnkVTAYc+CqJRVoRLHK8x7XX+nLgftft38gi7IVKvw4x79qewxbAGr4aO?=
 =?us-ascii?Q?+NnSgqsxRxHJljjhHvGwhnldZFWrw3wrf5a16e+DxmT/bNVgurN9Ltry94AU?=
 =?us-ascii?Q?LlaM/3jgPfb2oYHUzOHwkxItIKQ4Ap+RaW6PKpUvg91oC1EgF4Y61CMGobjK?=
 =?us-ascii?Q?ot3iYQwt3xYVdpNdK4HTljnryWtwKTfKMbMSR43wdTpiKDJUAL7z1ZHKSjVh?=
 =?us-ascii?Q?ZBxHa6fMQcQ+KSGRg/Oh4y6s6rYrXXYaPWnOE5/hlnx1bfZvn7EUvXKQnF3y?=
 =?us-ascii?Q?EZnvzya70vHiN2TqRRMdneyhbIcopkBXRei9MZ6drZLnHcCHSKdD4Ulr0P9a?=
 =?us-ascii?Q?H0h94fQ0TX1uDp0SdspzQrgZ5njQMUReOPItJ4xUK+SzSzFlRJj9MtxiOxd9?=
 =?us-ascii?Q?ue+7Ec/IuQYBhFQTvmTyi9cruBtXNPij26iMMthD28e9NIRDb13lzyp3MEj7?=
 =?us-ascii?Q?rHHIMrXfAWcRfFg7tQXOINioR/qf5RPnqyQFLqtrbodHe77K0wWgkJhphe4B?=
 =?us-ascii?Q?QAQDZgE5ZAGFLK+GMUoOZuhxCfuW66mqTyWD9cPy0ucbyHQoIoghsEO2BbjB?=
 =?us-ascii?Q?ZPbFM9KPPtS/RY5qu3RraDPOkZieCFqV0A876CcYM0kWg5RApxC1ON7HPNcm?=
 =?us-ascii?Q?Wse6HD55j0dH+MuDFQk2cjJmlfbsXWx8WJoTDxmV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97e4188-b18a-41fc-e92e-08ddf6898e39
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:01:21.5332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQ4zMj5dYdf2yzv0rgS4RGt6FuugmjcjS0Pt605EZBYY1lXusgpuoc1zUUjZZeFqGvMg2Bu1PgfxjIZgenAmDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8268

On Tue, Sep 16, 2025 at 08:32:15AM -0700, Tim Harvey wrote:
>UART1 and UART3 go to a connector for use on a baseboard and as such are
>defined in the baseboard device-trees. Remove them from the gw702x SOM
>device-tree.
>
>Fixes: 0d5b288c2110 ("arm64: dts: freescale: Add imx8mp-venice-gw7905-2x")
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

