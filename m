Return-Path: <linux-kernel+bounces-866434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B402DBFFC0C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D32D1893733
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252B62E36EC;
	Thu, 23 Oct 2025 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lNfB5VzX"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B062E0920;
	Thu, 23 Oct 2025 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206369; cv=fail; b=Mbc5rcCtg4KoGJFHrFCeh/6qZvZgRisJ84qJQxWYikiSV06uMaABdJmhx89ISSXgYxLKTbb9Toa7iRAjqb6UFCrxo4Z+NDh3B1ADVY0xIzJFPI/NJVRUJcDKu3be10pkmcrASZZsQOoKvtz+DM/LeBvLIqNlvLkdcChrdpJPcbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206369; c=relaxed/simple;
	bh=OrJbq/itHMz6N1tc7feUa79XgG+n6TDPK+KMl7TTT7M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uorC3iFW7ZymQ/HGrK6Jv46CjRrinbBeZgqZrZX+Tg58Zb8n9N3r+podnawTJl2e5zVVcfJbwhGuF6TXC1Wgn0h18xcwnaBcOtXAlSjXOc+ko3TeiheKGjku/TX3KUftymqHv2/9E7hQrCtDIslEdKlvpAV4u9Nrxr4NAZA8/Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lNfB5VzX; arc=fail smtp.client-ip=40.107.130.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDjUOM88M51kNFv6dPTGeaZKTNwK2/tUd5O0H8FMHeA5ugHHE0nSHUnrtSGHXys5h+y8z1cSLAg3TvFA40LF/RNsY+RqsPRu89+xPS07/8Ll+BN3V6HtlDpncrHT2eFoINA3cJBbTPleFGuwL/Yorjd1JOIY2QoL3kwBfM8hnA7wxvf4s6qp2eBLby5x93KKKj///4Tb8+HrLUWQqighSLLvdcUMCxUKyijOR29k+2lcSqOC7fukSFRoFR0tYHn5xkM6WfEk0RvT1y67uW/uDh3p0HN9RPQbIleV1ee3sdCY2WN9i+APpLCJBSSVPRO5LnjF2zJHtr+Xn5Q57VF5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mgIhGL0Uypu4Xk2X6bydRiGCnAy01bmn3kDvEYNTjwA=;
 b=TeAePvWS8fJUcO/Fjo/bm9X1KmxQR2G4vVOtDscl4O+1GCtbXhsYg965q6ZtssTmxdH6L4XCsdrM7IsHTLRNyTlGiQl2lEeEP4fCOqdKL560iIicxd+4Wah2c0bLkoD2SqgCuWORawLhGhKHyo44U7k1USj78sJk/TWZGd/u5+nmSFfeT/NPBVMGcLnRRk46WkQeQls240XQHxq7m+kL2I0ce8G/kbvo0ezo/PPSmoOF9G2Z42sll8pea7fQbnmQ1tPC8cvwtWn9LCH56pbHItI87bd0kSjMxpYtAlzSTT57XtChzVsPTQfPZzlIalbxl/FBsUNVUnXMaiFC7er0LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgIhGL0Uypu4Xk2X6bydRiGCnAy01bmn3kDvEYNTjwA=;
 b=lNfB5VzXeTxp7otqXzRwT0ex/DwxrjH9RKnzH8VztgoY9jdgLagNLf2vyqbLMFk4ZY47spexZZz9dLgZMGo3Clm/uRLaRBR780NKgvLH7STgKm5KN91tpDyXEJil9TspY/qSkW615QshJ6mleGeiD5xBsC3HNDjK4AShTfqOqLerjldadp+qmZ0RY4j7lJulrEDzFlyd+OiepBQCZAehKxbrHFGaJdmYm9kHmbnMiUjcw10LsvoMtNncpK+1sksQanDzIBPqvUMJoMVlXZ7FE2rWQz9XnCNNZjzyo+kf5BZ6KqNpkHE44gGp8rvOSqz+VQ8aUs/yHAPee1+lq6AcQw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB11444.eurprd04.prod.outlook.com (2603:10a6:20b:6c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Thu, 23 Oct
 2025 07:59:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:59:23 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Laurentiu Mihalcea
	<laurentiumihalcea111@gmail.com>
CC: Abel Vesa <abelvesa@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam
	<festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Daniel Baluta
	<daniel.baluta@nxp.com>, "S.J. Wang" <shengjiu.wang@nxp.com>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Pengutronix Kernel Team
	<kernel@pengutronix.de>
Subject: RE: [PATCH v2 3/8] clk: imx: add driver for imx8ulp's sim lpav
Thread-Topic: [PATCH v2 3/8] clk: imx: add driver for imx8ulp's sim lpav
Thread-Index: AQHcP1g+dKKPWpW5QkCQippvlTZ7Q7TOOoeAgAEsRSA=
Date: Thu, 23 Oct 2025 07:59:23 +0000
Message-ID:
 <PAXPR04MB84599A2457B84474ED6FD3ED88F0A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-4-laurentiumihalcea111@gmail.com>
 <20251022140315.GA11174@nxa18884-linux.ap.freescale.net>
In-Reply-To: <20251022140315.GA11174@nxa18884-linux.ap.freescale.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS5PR04MB11444:EE_
x-ms-office365-filtering-correlation-id: 70482176-a559-4e91-1001-08de120a146d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RrqBqm71iKnnJOGWmhYK1MmyQQq6HGJHVQzEreW9k7qiDYL3XjoFITn6X2dC?=
 =?us-ascii?Q?FuLri+wmgE9R2n69diEWUMOyzYVkCdYoJ4d9bFWXswvR2/y6oozy8Szhj9bC?=
 =?us-ascii?Q?rZeH4K68EpKeJzXg+1qBaK5DbG8WOsuG3aTBltwp8JytZ+KG6Oj7+V6NjUIB?=
 =?us-ascii?Q?QSoonUwRWUIddhQ9QeSXbWkFtb38EWWtcuIRFYpRs4D8kveQXbNYSJhtQhQD?=
 =?us-ascii?Q?/SaGtISvBlAqVef9dPiQxM+iLybS88K1C5jvruwT+ie4z7qdFVKZl2Kvfy53?=
 =?us-ascii?Q?3u+09ji1+Y0weKug+PRE08bnoTJV0egKIDL+gBdksSISDVR41vhuYVP2hXnu?=
 =?us-ascii?Q?nX0SS0N5C6mkeA1ZeslntHe7KuLLx4P4UlOHNANv/VYS3NLzGXbYR1tQF+44?=
 =?us-ascii?Q?OJ3Kz0aCIetEQBeJqFZE1/UAVglb4VuMGJdgeI6iL7o389DZQnFHnFq77EVG?=
 =?us-ascii?Q?qwB5AtuuRRLuIxo56yQm1YVS0pdtNTSRp0yUvf5S+MyDxWsgZsU5QcW1ghYj?=
 =?us-ascii?Q?3QbXj6Q1L8qPAdckolfTLbliv3tFC/qkT1wQoCT/Nq6uUsgcc+FPCzdwK6Tt?=
 =?us-ascii?Q?9KfbP9JUrm8gruGuWcB0Gaq81Kqk/Gh59yPaJQFSJbQyoXpjyuNGvsFQ9WU+?=
 =?us-ascii?Q?ZY8GqgR9wdybdWsQEcrm4pLQq0Z1W8wZUwW/awVmADyG+TNdIOTh1iyE7Zt0?=
 =?us-ascii?Q?sMXKqHyUH6qJQheYSPdghu5oS1fY4zyCzqx9FLqyUhN3D39WMf8iJ0bioLGz?=
 =?us-ascii?Q?3/bx8YK0EzTkQB/WEqqw3YcvNpIk8Z5BAqjl8CKtSIpmsL1qyIWa31Zyuqg1?=
 =?us-ascii?Q?aR+EBFxHzF2weLKxLT+y7HC4VMq9CaubTCBpUFJMz+eoN7TimNlg5SshtCT5?=
 =?us-ascii?Q?hN54LxqiHWy/zCOOc9qvK/MPd73gvefflbqrjuJIkX0fZbHwEPPqImdiGxCv?=
 =?us-ascii?Q?NIg0wgUrP0KeespFk3W0e4Z1IxMz3um2sHK/luR+esgbnPiwDHtd5PlkkS4n?=
 =?us-ascii?Q?UPm2emzscbpCCSGtqyWtn9xfJtnmKy9iwJ5BEnt6KLuuTcO6J6rnIhOrycMk?=
 =?us-ascii?Q?n1d9Hcnv2zECETRyQHLRTgO8hPrr9MjDp4+vMpeFsFs4MIevtVVBjibM6m/L?=
 =?us-ascii?Q?Bdq9xzUZ60ymua7AhvZXAdOQoNzeF+eSZQNuVBJjrKgkafPQKTYSh42EdeHK?=
 =?us-ascii?Q?Gl2nOgMmmTgpvilK3f68z7fy257iUmu3lGKGRxGXoUe5lmStWekWzTK7KBRo?=
 =?us-ascii?Q?m7A35Wl/NHwvHhoj6dUkQNGNuX+AAG6n70v49qMQL/McCGo6ZHECW7BTl4sR?=
 =?us-ascii?Q?6jRKKNx4yt/qXbC+61rGNgAWrNWPuifACBab7Qxv1s5+Pbt1DIi/NtUw2GHz?=
 =?us-ascii?Q?pGRJXuvWxq1VKxn+qq9UYx7BZLhHU6w7Zq07735MYcvyBjKfdyf6PrSID5bc?=
 =?us-ascii?Q?K+x+SFJk3cUt5N4CqOBw67aIyHWhmVFca7rUlu9XQ0a41sqdGR4gtmCVIuRV?=
 =?us-ascii?Q?2hw1YLw+CBM+s5jbeW4L6yfg7Ymc7excsFG3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KL9TME6xqUFtli39nrglETRrYs+zKcM1YBbMPTRo85a3YydLEXlib3E0s2O1?=
 =?us-ascii?Q?eR86FkKkNhVL/VKlYIBaGmU1i5CK4v3KIpYl3U6kU7SbWIae17xLIhqZSR2Q?=
 =?us-ascii?Q?RF04oMqa3cPd3eGBlPbnfYnUyuqJu8Ji3DhyMr/AeSZ9A5kqTsE4kige2Pdx?=
 =?us-ascii?Q?tE9y58PAFgBav25x6xGXuNAAz+xIJG4ZvdeGR7mCv1SE02g4LucsNFV3KQVR?=
 =?us-ascii?Q?bwul4UYn6m6U2ZhV4NRUbbFfxnoufahDXWpr98G+62Z5Fcjei7sZgjg43MNu?=
 =?us-ascii?Q?YL8DDIyk6BHw4mZNB0uNnKt4ZphPk0AduURq6q3uThD5WuWtZ4dOUOMZwaDq?=
 =?us-ascii?Q?1d4nZOjG9fna3sO5U3qjrS5G85XsYTAHmBaAdKGljtjb0TvBTL3Gol+mn337?=
 =?us-ascii?Q?+b108KRJptpblw3HEgMX6rKKpZukkma6W46xWr6ATPrjPS71sCd7Km7gOnRo?=
 =?us-ascii?Q?2gIdZaTfEJP5snaGWSzRfiyJvaiDQiEizzIJ3Gj2QDpx7V6fPsnbROt5kFYS?=
 =?us-ascii?Q?l5+btk/YbQ2Ls1jSk8vrQZJTSLLohUrvQGvnt0I2SlUxt27VrBDrmLWD/yUT?=
 =?us-ascii?Q?lNoBwzbrk0rznETyBy5nc+ygPZWan0Tn3Jd7znAv/AvSUztNiRVAYAjgtlpI?=
 =?us-ascii?Q?w/Ib0wV2eHHW9BUZbPpRakJcxY/TmPxPAu0V1UNKOwoECUaSaRAoawDVopqz?=
 =?us-ascii?Q?N9IkIEc9DjPRujV7x8MZhYrpLzne2ubsGPjMBKb7efLqllT73mNaXqxxAhMv?=
 =?us-ascii?Q?bnhnnj4qrYi5ErrVzHsMXZbyYD6PEQs0ftBKP+M1XAR2lM/pyy/HVteJifax?=
 =?us-ascii?Q?GiDpEP5zBZOYpAjabQSOIHlsps7cKxPeR2YUw1+czWlUW71elJ1DuPXFpxFR?=
 =?us-ascii?Q?G0hnu361LwhyAk1Y2SK+iuF/cVeMem+kyazmyMyM67zAgwLTFABcZmlH7riN?=
 =?us-ascii?Q?N0XZJpVwwkKczz8HvkQ5uZqVjpy7AToke4qgQc1Yz9IOOD30npIRe0x9pYug?=
 =?us-ascii?Q?/ydV1hE7UyzGgOZ2YeYO+UW+Rga69GNKgFmsd2Fw7+wF+3m/26tEkHm19BTo?=
 =?us-ascii?Q?b1CuykMwbyNCzHNolqW/C2qXsv46tttdT/mtH8zj9MWYVWjZhtt4A/CJ9XUw?=
 =?us-ascii?Q?GLGh9j4zLLykJWacCDZdfsPNr2Tm1Kiy4PHH0qCLbAUcEmxBWEvVdMVIhxuC?=
 =?us-ascii?Q?1SsRTFVvf/XePmPVxh4cvw7Sgo5fFgQ1u3oVhAzGCS61LRkc05lwnWI1hFHw?=
 =?us-ascii?Q?mWiZ5akV58IYCcnCgSWVm/DINIlwV8HOGieIBg51pxS+1cN6ZZYiUU8Mj3+U?=
 =?us-ascii?Q?91irgwWNzKIe31hhCifqTqa8OgFi9vjKT9+Iv0qQLcLFz+WLHhflZIDFE27I?=
 =?us-ascii?Q?Q+ScVmrP5O92DQnLNYZ87DMMiJWQtBbO0f2TaDk0acvRK/lkdtoAs/okjywl?=
 =?us-ascii?Q?Ci5hfWaxTYntYNyuF4V7uZXRdGN3f06wWv03M7tJQQSnM8tUhXIwzG4XtZRA?=
 =?us-ascii?Q?I1rZegOXhnV92IPb8HpeXDaUPoHGotZ/crMBWcreV+blkP2mTJ+2awVgC09j?=
 =?us-ascii?Q?hj1UkF7HZVAmeWko8bE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70482176-a559-4e91-1001-08de120a146d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 07:59:23.4742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACzmy6SqCfMi/9xrosinKNFw4XQ9UngEsIAZBUBJF2Jkekxt16mvUbIogfrs5uNlaJgTIcwFmGV5gRFMWVTnUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11444

> Subject: Re: [PATCH v2 3/8] clk: imx: add driver for imx8ulp's sim lpav
>=20
> Hi Laurentiu,
>=20
> On Fri, Oct 17, 2025 at 04:20:20AM -0700, Laurentiu Mihalcea wrote:
> >From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >
> >The i.MX8ULP System Integration Module (SIM) LPAV module is a
> block
> >control module found inside the LPAV subsystem, which offers some
> clock
> >gating options and reset line assertion/de-assertion capabilities.
> >
> >Therefore, the clock gate management is supported by registering the
> >module's driver as a clock provider, while the reset capabilities are
> >managed via the auxiliary device API to allow the DT node to act as a
> >reset and clock provider.
> >
> >Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >---
> ....
> >+struct clk_imx8ulp_sim_lpav_data {
> >+	void __iomem *base;
> >+	struct regmap *regmap;
> >+	spinlock_t lock; /* shared by MUX, clock gate and reset */
> >+	unsigned long flags; /* for spinlock usage */
>=20
> This does not need to be here, put it as function local variable should
> be fine.

Ignore this comment. It should be in the structure.

Thanks,
Peng.

>=20
> >+	struct clk_hw_onecell_data clk_data; /*  keep last */ };
> >+
> >+struct clk_imx8ulp_sim_lpav_gate {
> >+	const char *name;
> >+	int id;
> >+	const struct clk_parent_data parent;
> >+	u8 bit;
> >+};
> >+
> >+static struct clk_imx8ulp_sim_lpav_gate gates[] =3D {
> >+	IMX8ULP_HIFI_CLK_GATE("hifi_core", CORE, "hifi_core", 17),
> >+	IMX8ULP_HIFI_CLK_GATE("hifi_pbclk", PBCLK, "lpav_bus", 18),
> >+	IMX8ULP_HIFI_CLK_GATE("hifi_plat", PLAT, "hifi_plat", 19)
>=20
> For the parent name, my understanding is they should be the one from
> clk-imx8ulp.c, but I not find them, or may I miss something?
>=20
> >+};
> >+
> >+#ifdef CONFIG_RESET_CONTROLLER
> >+static void clk_imx8ulp_sim_lpav_aux_reset_release(struct device
> *dev)
> >+{
> >+	struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> >+
> >+	kfree(adev);
> >+}
> >+
> >+static void clk_imx8ulp_sim_lpav_unregister_aux_reset(void *data) {
> >+	struct auxiliary_device *adev =3D data;
> >+
> >+	auxiliary_device_delete(adev);
> >+	auxiliary_device_uninit(adev);
> >+}
> >+
> >+static int clk_imx8ulp_sim_lpav_register_aux_reset(struct
> >+platform_device *pdev) {
> >+	struct auxiliary_device *adev __free(kfree) =3D NULL;
> >+	int ret;
> >+
> >+	adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
> >+	if (!adev)
> >+		return -ENOMEM;
> >+
> >+	adev->name =3D "reset";
> >+	adev->dev.parent =3D &pdev->dev;
> >+	adev->dev.release =3D clk_imx8ulp_sim_lpav_aux_reset_release;
> >+
> >+	ret =3D auxiliary_device_init(adev);
> >+	if (ret) {
> >+		dev_err(&pdev->dev, "failed to initialize aux dev\n");
> >+		return ret;
> >+	}
> >+
> >+	ret =3D auxiliary_device_add(adev);
> >+	if (ret) {
> >+		auxiliary_device_uninit(adev);
> >+		dev_err(&pdev->dev, "failed to add aux dev\n");
> >+		return ret;
> >+	}
> >+
> >+	return devm_add_action_or_reset(&pdev->dev,
> >+
> 	clk_imx8ulp_sim_lpav_unregister_aux_reset,
> >+					no_free_ptr(adev));
>=20
> clk_imx8ulp_sim_lpav_unregister_aux_reset() clean up the resources, if
> moving this before auxiliary_device_add(), then no need
> auxiliary_device_uninit() when add fails?
>=20
> >+}
>=20
> Regards
> Peng

