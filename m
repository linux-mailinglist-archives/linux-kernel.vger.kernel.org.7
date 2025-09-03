Return-Path: <linux-kernel+bounces-798122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3089B419C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57DBD7A142F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6502A1922DD;
	Wed,  3 Sep 2025 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TBJMEEMX"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1C9156CA;
	Wed,  3 Sep 2025 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891108; cv=fail; b=RZC2I9gZP4uAV01Xf/RfOwTm5V1P3PBCjuqJ3AOIjnr/TQNP6Moby1XrstXDCiqUR+yZStqqAYU+mNgKi9547nkLVvmWfWuyrTIIW6MP4sAVNcmekrxlpXggzsH9JEzxsC1PpIswMmm5G8zPlkUvI4x3e3xzYI98FXmL6ORBbX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891108; c=relaxed/simple;
	bh=eUGm97hFuKHYftLsmHzi8zPVqOkSPDydnQ7B2HBnWI8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HkhbX5p7gPaR8r+xbvxTxqN4csEgutFJl3xpGKzkHoHWUQ7jQ0B6MRBzMB2O++m+zLpIPUnhnNdkrAhXD7duWNrUCNJdek6T2lw5JDJOxY8N+6brTWd1DAn7aWd2+jmYm+0VOXe6FabqwDAvjOnlCvYFdCFbvDUuSY5hHSe+hcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TBJMEEMX; arc=fail smtp.client-ip=40.107.130.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4AcqZFcPF061uMwVskiodSdWlDZWKuXK4lsd5bC77shDgeIzSgxtOoGD3e8/nO2O1xzUWxJMpePQQb97bLhEUZThpzE6Kjbj+EVuzZq4N6DeVvObia3N7EnocCrG+/hdZNyvyLBGV0Sh4UHXUeOYxGMsY3GiXBGYHCU/4+LqrxKjJ/h96eJWqQF7808AQzxdyXgAQlm0QE4E1t+pcksr6McVTFsU/jChaqlhndjosD+EgzRXb+C6YtNQv1Cq9MT4jwoPsiGrT+6do1zFTzol3dAz/VVsfxCkugiJqSPuIhhllfYRrOWMqnf02t/l9abqjrOoHkSLbt8IYSmhSur5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smOenIN1pWOP3rDx2r9J1cEk3NSRN/Q8EgvFC4x+WF8=;
 b=jgXw+TfkwH23GtEbH3Ztd/vmGb8k359OQJpxPSWK7vKFaTm4F+SYpwY+hKruL/Xgw+xVGq5pen9Exk+XlFzKoHJgBYqJ/CfJNtZN/QfMNctV0S9+yBNchIxa1QYNFux/ucH9OkA9yTom2JIZGM3vMl/v+vklLdCMTEG8LU04RxoEi2N4jkK+Zxs8ORQdYrFy40BKddisfNImfLJCWDocp9YnZLsQNynBe7FgYLai4c2t+5C8bYYbRtlv6b5Ux2/eyxa8r9RLoYrg6N6aiB+OMzEat9yrfigWNZXY0lZrPYg5IpFfuGPlSs7Hv4IYW/pvTZNIrBlFNDmuhMpJm7hQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smOenIN1pWOP3rDx2r9J1cEk3NSRN/Q8EgvFC4x+WF8=;
 b=TBJMEEMXkaE3+bO+3de+a0glgyT+ayeqzcG86N/8jCdItAFd/FIZZCK5SgOwNkMoTf2bTdEQal9vjeg2XwRsSvAiQO+HGXjjruBcprly9Wx5uHQb2cnQoUERJ6exuZlMZSK55ivbQo+h1dNtjOAIbFszMmzp52DdHnJWXEbvH51V0URSIm/ikAiRjWbc13lI6Q7r8vqGrOqNQQG2X4JpNNWyC6b0DmpL3y0OwV3sBWvBR/SxUHlKVc9IpJuJR5vGv82ko5pA/wjMoQHQw7387jSIkp+3DNCOil2m/3OzofOij+ziS1bYrLsTiRfyxen5YOnTeR96N8hHMd0mciNAUQ==
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AS8PR04MB7525.eurprd04.prod.outlook.com (2603:10a6:20b:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 09:18:22 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 09:18:21 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Varun Sethi <V.Sethi@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>
CC: Frieder Schrempf <frieder.schrempf@kontron.de>, Jonathan Corbet
	<corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Frank Li <frank.li@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Sahil Malhotra
	<sahil.malhotra@nxp.com>
Subject: RE: [EXT] Re: [PATCH v18 3/7] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Topic: [EXT] Re: [PATCH v18 3/7] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Index:
 AQHb4RFy2NjRRk9es0SVz8O1dms9rLQTvUUAgALjSvCAAB1dgIAE1IEAgAAdTACAAXh9AIAJZc0QgAr2xgCAI+auAIAAffuAgBY8mkCAAVTSgIAHWPTwgAUCyHCAB81v4A==
Date: Wed, 3 Sep 2025 09:18:21 +0000
Message-ID:
 <AM9PR04MB8604F5A7DD8B1E41FDAD09039501A@AM9PR04MB8604.eurprd04.prod.outlook.com>
References:
 <AM9PR04MB8604611B8D91B5526C9704E69545A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20250627084653.6vgwnm3llf3zknlp@pengutronix.de>
 <b02055bb-0995-4fd8-99f3-4ca5146eedd4@kontron.de>
 <20250630121722.wviidlggt7hguyt7@pengutronix.de>
 <087b8689-7443-4720-a94c-160edd31a5da@kontron.de>
 <AM9PR04MB8604C05882605EDB4913DA089549A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20250714094124.e6fnkrocnqagbm22@pengutronix.de>
 <AM9PR04MB8604EFCC5400DEBB7DF0CF49952DA@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20250806132701.fouikyuqtzdsxqwh@pengutronix.de>
 <AM9PR04MB8604A636762E81DF9EA9A9B89532A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20250821132129.hwnnqdagalvxw2uk@pengutronix.de>
 <DU2PR04MB859982BC71F6CB8182EA1F5F9539A@DU2PR04MB8599.eurprd04.prod.outlook.com>
 <AM0PR0402MB33631F1A9448AE91B58AA406E83AA@AM0PR0402MB3363.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM0PR0402MB33631F1A9448AE91B58AA406E83AA@AM0PR0402MB3363.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AS8PR04MB7525:EE_
x-ms-office365-filtering-correlation-id: 3c22509a-4b92-41e4-e57b-08ddeacad3ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EK/dKVMkzi5O1MeHhYTlsI4hJkjYR0koT3aq/z4p60iycP8EEIit3mH5xG5Z?=
 =?us-ascii?Q?ejrPuVowACZvGfBZz+aYYuJgUb6lpVgQS5EPLQwxZhb/TikCaTBNLfMCFj8V?=
 =?us-ascii?Q?XEy3jMWNQBcFmz2Rvbq8XumHStnhCM1foYxmAfC+bg+o2u1kBqvWyOA57aT8?=
 =?us-ascii?Q?g11TEXJ2nwR4qC3W1d+JqC8E+V2ySVa3pOgNsp26t+r08HZo2Yd6bElVaUVZ?=
 =?us-ascii?Q?zfMT5iXsrn89UduTrlhW1GmU2wvvPkHjFpFoft5s77fNllP9V2vKrqJPPky/?=
 =?us-ascii?Q?Xjriswln4juxuc+TYLrjEvJjEs8I8un6E/UXyJyB1ZW7h9MjCunYS4QjLjZ/?=
 =?us-ascii?Q?l2UQU5hMYtwgaAZXdE+5+t7zDbKo0eASj1jwJZ/1t4DCIXV5jJr4fx02n+So?=
 =?us-ascii?Q?jUZvBW3b1w2mTlJO/ASohVGpSzieKn4mcm03ntSuvDRyKmRgNQVzMs0mTVN1?=
 =?us-ascii?Q?e2s5hFtM8SxDs5nGdFN75ouVgoXpOsC5yU2rmmWrwDl2fbNFEtlzi5ruZxcS?=
 =?us-ascii?Q?PtPkMJOhIFalwb78kh1DnxVzmXOLXqbzgznS5u2BISltys2gg1YMK4y38d12?=
 =?us-ascii?Q?ylW6u/MutOnTfTl0E5AXCCbTBXOKqDURMX3P/1zlq3c0WOpZlJyknRJTHqqx?=
 =?us-ascii?Q?mEzFXJuCVWwe0surEYKKudXLqoN4r7RmObyjL7n169BOuyaDbFmpJ1MwMB6f?=
 =?us-ascii?Q?Juh06+hWz7cOruyM30TDnQgTO71ViGJ64p7qyAgIz5SCCYNJL6cPZWxavTAu?=
 =?us-ascii?Q?OdGMqwhhtjf5A0S9XQ5tY9yBHeTzT8/0jAeC0mIzKwDkhm47r50e3meFtigO?=
 =?us-ascii?Q?y3cNPUACu6CtHeoj54JZdXthcrXXby2YciMFQBAEQWqgbPnHbhQjqryqyLRd?=
 =?us-ascii?Q?EILr/7wWgJGpIQKaGuZLXzk+/+uDVBHJ5bcca2pGZmHo6EV6pAW03U9wCyPW?=
 =?us-ascii?Q?WU8/kUur+y9YiaNsXlBIurmHhlDGpQ115q9XuPcSU1OhW6yq3SZ0djnVmHB5?=
 =?us-ascii?Q?JOLtzEiCoP6Wxc7peG48ldVpQI2W8RHiIhXTbPj5Z0yISd49hoyLRLPfQ92M?=
 =?us-ascii?Q?2VlAoXv3sVuwePVROTZ4KCEBw25jsojm7usAi1PwUKEhK26XVzRC8gf2LMNo?=
 =?us-ascii?Q?jGbgk5EgW5/jSnJvoBBTifSb736BBvgg7wuedSZ4vZlJdS2Jxe6XAtxZP3We?=
 =?us-ascii?Q?2nuFlHiTrTy9sRu8QzMirJjbiDkrdHigWuglCcfMJRJiXFebGNOc14b1lqKy?=
 =?us-ascii?Q?jh9YEqBIjpP5Zg8zruo5zks2tgGbHGNpQ21As8ZsU5Iwv0yJ0nIQdZDGG2Sw?=
 =?us-ascii?Q?qm7itoXdSviBaFd2LWcsQb8lJNf8109YQBXhZvaho79GwUrEt2InBXpNVelN?=
 =?us-ascii?Q?9qMl40n+6X89/iAq96uX/Zi6yFljaOJfmvRLbaiaGz0LaEzaOnByEom5dRdh?=
 =?us-ascii?Q?yDapABuWGO3CenNFqCOPDay7mqJJ6WsKydLVjSX5XSH/iIqoV5NOw/vXqnuw?=
 =?us-ascii?Q?vAfZR6KODNL1gH8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(38070700018)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tFHZfJ7I2x9NvAaEmgnZUc1jCkFCu1dIeo85yn/lK2Onifr1jZ+0hhgtPnYl?=
 =?us-ascii?Q?TgtXdIQ+q5yhENvDJ6ySNLM0hjlfR+S3Bkzk7WlkxF+KgNESzh5lcvuKXrSU?=
 =?us-ascii?Q?TPdMDir/XI7m5tUW+vd6XYZcrZZjcRt0BkNXlnGS9CplyibR9A0sT2V3L4MA?=
 =?us-ascii?Q?cXEl95XDtRkuBQTOecMPAUtZj3zroVTSn3SjlVafrB/AUftPdmoATZ4NcqeJ?=
 =?us-ascii?Q?fr8/K7VOyAA3lE2fvhhOnqfZ451fwP0pK3Yb9mNxSQhZcyuCDC5WaNs/Qkef?=
 =?us-ascii?Q?HIMNT7h0qB6xmUHHDNjg7YS/9kEva2cBjW0MnL/gfSmzc4mreUVOpJPQ7Chu?=
 =?us-ascii?Q?/LaAl0RAAya/etIMcK4RFTJRZojbGBvMEGtalCGIsCGa0R/C1PigYLEEAh27?=
 =?us-ascii?Q?KJclXWDyXm5L6GaY60XNIBl70W6zMPYdMXcbSEUO/oeNCZQ/0tzJJK1rassc?=
 =?us-ascii?Q?8t0jEKpoJs1im/eOzeqELcKC5MauL5j8ELS3e+coo1+YlEo4S0mMVkcEHmhy?=
 =?us-ascii?Q?7aaR489O/gt0rquPcvAq5CJaBSepqc2ekIeIVYsAdA0x2ZM0pkm47D4xKJhy?=
 =?us-ascii?Q?ZzhnB4dnRtE+evSmD9wViATEdm7JzUUscPvjru4FrtwBylcDqOLgQYqv0BpM?=
 =?us-ascii?Q?ni9EtCfbajFOgTmWSHoQKGqIHmxS0fjCmu2rtCxlSED07JuXgeC6zSt9RdTI?=
 =?us-ascii?Q?ZslH8yw1OZiBCyu6l1bic7mx2w9r2hjlbQrMptXrjlLAzdLPZpRqKsWyduAv?=
 =?us-ascii?Q?IzWtLGIkrLcjSij1bRuR0jaFizD8dfFmACpfu73ZzSJPLNVcx2lhizlCxIBh?=
 =?us-ascii?Q?FT4cZ60E31VgdQ8dSwWRKwkhf3pH9xi2u7Cul8L3E9n3vE3myq7hQ3+sgGsG?=
 =?us-ascii?Q?irgAfPw6pKxvR/Dl1gjy7iQ1CB+c5cgDRp8/44c5mFf5LCRWc1nJ6htKRvy6?=
 =?us-ascii?Q?xmNSxXijdQxq97XZi1mw8x1BAOM7u/s6TNi0YxMxVaEfR6wXP5zwLKXT65BC?=
 =?us-ascii?Q?+j6lgahgkFa8VEdNS9OTG3OBdVwZ5bEN9y3ZoazsIOnsDdDSp9xMr+2d+zs5?=
 =?us-ascii?Q?WL7FDXvj+Gjn2AIfQXW3GWaiecp2ubmtYQKXaQSy/K7cqoNkjCKmtZF2DGOx?=
 =?us-ascii?Q?hiAIF9jbyHGxC6kDbNH8IDz2ObaQfB04PLFBaGP63Pi2DaqysJXF8lg8LROH?=
 =?us-ascii?Q?OQq4nUqysjtFB1E9Kzgx9CXP4+OdNRyxuE2JwpDo1tLxZXGgRvHbP8kaGEbU?=
 =?us-ascii?Q?POqp3sNqTRtEGYcSL2VzizsSOr0CBk6RWQp5O22RRMbCbE7LWRYwt74RGrqb?=
 =?us-ascii?Q?cfb8kar1kFjLeZNozh5HGAql5DuauSMopK9ONglcaT7nyvMQZLC0drKJ0cqs?=
 =?us-ascii?Q?Hta4Bo9pdgy492WgQDMj+cG2IoN4Nz4ccCadRTr95gbJxvsRiTlNm1k/0Ftq?=
 =?us-ascii?Q?teek641fz+xNGNLBiH743ip1MNBTwRj/sr5pvjxreulKF3k6OuOJziR1Ybxv?=
 =?us-ascii?Q?kx5UBa50KNtyXDHqHf3Z4ZeqXU1OYpkVz8QkBWTR5Shlk5ODWgXW83KV8Npw?=
 =?us-ascii?Q?LCGyrgppXD0sGznkGRt+T/Xw2s2cC8NtcZGyc9M0?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_001E_01DC1CE1.C898F900"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c22509a-4b92-41e4-e57b-08ddeacad3ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 09:18:21.6131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Hh/TL0YMeIkqwK69dp4aAIGPONQpqE/vY9Tb2aPrK59eI/8MwXmvHi2d5GoSh72VSx0FfQe5fZh7ijqzV0uUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7525

------=_NextPart_000_001E_01DC1CE1.C898F900
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Varun, 

> 
> Hi Marco,
> Please find response inline.
> 
> Regards
> Varun
> 
> >
> > > > ...
> > > >
> > > > > > Lockdown: For a verified boot setup you need to burn an eFuse at
> > > > > > some
> > > > > point,
> > > > > > to tell the bootROM to boot only correct verified firmware
images.
> > > > > >
> > > > > > After this lockdown it's no longer possible to burn eFuses from
> > > > > > the REE
> > > > > albeit
> > > > > > the production line setup still requires the support.
> > > > > >
> > > > > Understood. ELE access from both secure and non-secure world is
> > > > > fixed in Q3 release.
> > > > > User can be able to modify eFuses via OPTEE.
> > > >
> > > > Splitting the read and write between two drivers is even worse.
> > >
> > > This could be use-case dependent. Depends on how customer will deploy
> > > its solution.
> >
> > I don't get this. You introduce even more segmentation if the read-path
> uses
> > another driver than the write-path and if this is optional.
> >
> [Varun Sethi] The secure enclave firmware can restrict accesses to fuses
> based on the MU (from where the request is received) and core security
> state. So, we are not talking about segmentation but rather partitioning.

Agree.

> 
> > > > Can you please point out why you can't just move the driver parts
> > > > into the tee? I do see many advantages if only op-tee is used:
> > >
> > > The ELE's KEY derivation function takes account of world from where,
> > > the operations are requested.
> > > - The key derived from secure world and from non-secure world will be
> > > different.
> >
> > Which is correct and no reason for not having an OP-TEE only solution.
> [Varun Sethi]Yes, driver instances would be available in both OP-TEE and
in
> Linux. Secure enclave services exposed by these instances would vary.

Agree.

> 
> >
> > > There are different use-case for ELE accesses from both the worlds.
> > >
> > > Using OPTEE ELE driver for Linux specific ELE-HSM requests, it will
> > > add significant overhead.
> > >
> > > Usecases like Transparent TLS offload while securing the secrets in
> > > HSM, would incur additional overhead.
> >
> > Of course, the ELE communication itself will be faster if Linux
> communicates
> > directly with the ELE instead of going through OP-TEE.
> >
> > But to be honest I don't think that the ELE usage itself is much faster
> than
> > using OP-TEE and the ARMv8 Crypto-Extensions.
> [Varun Sethi] That's true, the main point for using secure enclave is
about
> key protection at rest and runtime.
Agree.

> 
> >
> > For the ELE you need to:
> >  - setup the context (incl. the message and all mailbox mechanism)
> >  - wait for the ELE to be accessible (only one ELE, only one
> >    normal-world MU).
> >  - transfered the messages to/from the ELE
> >  - the ELE processing should be equal to the CPU processing time
> [Varun Sethi] Well, this is similar to any look aside accelerator.
> 
> >
> > (Side note: What is the ELE behavior if the secure-world stresses the
ELE?
> > Is there a MU priority so the normal-world MU may get blocked (never
> > addressed) or are both MUs scheduled in round-robin?)
> [Varun Sethi] Priority based message handling is a possibility but
currently
> it's round robin.
> 
> >
> > For OP-TEE you need to:
> >  - setup the context
> >  - switch the CPU mode
> >  - make use of ARMv8 Crypte-Extensions
> [Varun Sethi] You will also have an option to use the secure enclave via
> OPTEE.
Agree

> 
> >
> > On i.MX8M, which uses the CAAM (the ELE predecessor), we can verify that
> the
> > ARMv8 crypto extensions are much faster than the crypto-engine itself.
> > Therefore the CAAM is mostly unused.
> [Varun Sethi] CAAM does offer capability for runtime and at rest key
> protection. That capability is used by multiple customers.
> 
> >
> > Are there measurements/application-notes that show that the usage of the
> ELE
> > is more performant than using the crypto-extensions?
> >
> [Varun Sethi]It's not more performant but offers protection for secrets.
> 
> > > IOT-cases where real-time encrypted feed from sensors, will take
> > > latency hit.
> >
> > Does the ELE support inline en-/decryption? If not, I don't think so.
> [Varun Sethi] Again, it's about key protection. It's possible to combine
> secure enclave key protection with other high performance crypto
> accelerators.
> 
> >
> > The data needs to be read from the CPU first, afterwards it needs to be
> > prepared for the ELE and transfered to/from the ELE. Also there is just
a
> > single ELE with a single normal-world MU, so you need to handle
> concurrent
> > access if there are multiple ELE-users (sensor+tls-offloading).
> >
> > If CPU is used, the data still needs to be read from the communication
> > interface but afterwards doesn't need to be passed to another IP. Also
> there
> > are multiple CPUs.
> [Varun Sethi]You are right, but please note that secure enclave offers key
> protection and offers support for asymmetric crypto operations. So, for
> cases where we need to establish secure TLS/IPSec connection and ensure
> protection for long term secrets (asymmetric keys) secure enclave is
> suitable. For bulk crypto operations you can use high performance crypto
> accelerators along with secure enclave.
> 
> Secure enclave use cases can vary for OP-TEE and Linux. We are enabling
> drivers for both environments.
> 
Agree.
> >
> > Regards,
> >   Marco

------=_NextPart_000_001E_01DC1CE1.C898F900
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIImZTCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
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
ggEKAoIBAQCsljsxzffby7IAt42e7cJH7K+49RL+7i56h3ORt8dS8WNVSdDlejp6uS6mLk/UX0wn
sSxDK1S5KquGJQzaT/3gxE8tdgvfFNBVdrgr48DeCVwWDr1o/UF3RmGcMdxqRz1M/oLDJ03C8n6h
L/0JXiwsNx0KZJoqDrN/48yX5TkoeKJmHFftZ5Op57xV0WkZJ/yLxSC1Om75jOG/UPdqsDzl+wi7
YVj5egV24hoaXgHBxtCeJzUgsHcJlo9nFtGe11j6H1vqFzkPzN9ydjRmhQATV/WLqpG8uot79u0m
6n7Mjwsd/HmJf+8xpovMcHPO2a0axppssKso/3APP6mR1FuVAgMBAAGjggORMIIDjTAOBgNVHQ8B
Af8EBAMCB4AwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAwGA1UdEwEB/wQCMAAwHQYD
VR0OBBYEFLNr0DCWM1fCXv4ubOt/elkvcoiaMEUGA1UdEQQ+MDygJAYKKwYBBAGCNxQCA6AWDBRw
YW5rYWouZ3VwdGFAbnhwLmNvbYEUcGFua2FqLmd1cHRhQG54cC5jb20wHwYDVR0jBBgwFoAU5TJ6
9GbBR5Ykf/wngDlY3ysX4rswggFKBgNVHR8EggFBMIIBPTCCATmgggE1oIIBMYaByGxkYXA6Ly8v
Q049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNCxDTj1ubGFtc3BraTAwMDQsQ049Q0RQLENOPVB1
YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2Jp
LERDPW54cCxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNz
PWNSTERpc3RyaWJ1dGlvblBvaW50hjFodHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFAtRW50
ZXJwcmlzZS1DQTQuY3JshjFodHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFAtRW50ZXJwcmlz
ZS1DQTQuY3JsMIIBEAYIKwYBBQUHAQEEggECMIH/MIG7BggrBgEFBQcwAoaBrmxkYXA6Ly8vQ049
TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNCxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2Vydmlj
ZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jQUNl
cnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTA/BggrBgEF
BQcwAoYzaHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFAtRW50ZXJwcmlzZS1DQTQuY2Vy
MDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRVhu2FOILrmUuaklY/hMbNXILljX4C
AWQCAT8wJwYJKwYBBAGCNxUKBBowGDAKBggrBgEFBQcDAjAKBggrBgEFBQcDBDANBgkqhkiG9w0B
AQsFAAOCAQEAWS4IrHXWhCGNWk5vn20xV7mlLkM7JPwltVJzB6MRzwUB438upbyUMwNHcEgAmHcs
xL9hafErN+n9rLL00wEqZsCV732s7YOxSRRjZTE3CmZQ2+TYjXR7A6AzQKo0fv/x43bpSes8ttQ6
Qtt8nzIbGBkDAcI7wfXsUPF5o0NwLOxre+Z+JCPNH0eaOj2J7EKD2ERLCClmvohrYdlmu85iXfyi
nJo42eq9g08FtnxTXVQSIZCtiETiGtXA7+t2Aa8429XXunsijRznaYw2SwI/s4sVmvaK3XHaif0D
QaUYxQp4s2ctzgz3eU6hK68OnNzbhBtF/lx6PHbifqHDzrtUbzCCB+8wggbXoAMCAQICEy0ACwRu
JYOozH+yQuYAAQALBG4wDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNl
IENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVu
MRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPy
LGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMzEyMjAwOTIw
NDdaFw0yNTEyMTkwOTIwNDdaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQB
GRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAklOMRYw
FAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGEx
ODcxNzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL2JT+kRihW1mBdeZFOoCLGIl4DZ
VL7FWt3V1iFFJJe/bZDw/SUf5z1HeA8xv9+S8rqMyybjlSRHFLgiMm7qrGpVEDniKe8eiqP8Un4Y
3fHgK5FKZIVVn0KlaMuD5G30AMk9HyUdc2MkVRL8YSQCewkQDEVjB8gnx/e6xfbWEVHf5+dOWJoR
aket5+0JKV0l/dPV7cT4hL3BFtiBhq8976Li6rn8gxIi63u0G3qvm9Scqk+EHzemDhw/W+eMmGR4
nwKVLKzumxko8l6EOnnvqqF4vj2hKTpB+2lsEXH1giireMEsvB2RY40lnRUXVQ0FDklOIQV4Qdgi
EJfUdq/ZhCUCAwEAAaOCBA4wggQKMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRV
hu2FOILrmUuaklY/gbeCPIPthzICAWQCAT4wEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/
BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZI
hvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4G
CCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwHQYDVR0OBBYEFMJ81PK4p3H8Q7gn7u/5OwWx
uAwGMEUGA1UdEQQ+MDygJAYKKwYBBAGCNxQCA6AWDBRwYW5rYWouZ3VwdGFAbnhwLmNvbYEUcGFu
a2FqLmd1cHRhQG54cC5jb20wHwYDVR0jBBgwFoAUWJVg7k5072Uiqr3tGakreo4XnQcwggFGBgNV
HR8EggE9MIIBOTCCATWgggExoIIBLYaByGxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENB
JTIwNSxDTj1ubGFtc3BraTAwMDUsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENO
PVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y2VydGlmaWNh
dGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hi9o
dHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybIYvaHR0cDovL3d3
dy5wa2kubnhwLmNvbS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmwwggEQBggrBgEFBQcBAQSCAQIw
gf8wgbsGCCsGAQUFBzAChoGubGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENO
PUFJQSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0
aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2NBQ2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1j
ZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MD8GCCsGAQUFBzAChjNodHRwOi8vbnd3LnBraS5ueHAuY29t
L2NlcnRzL05YUC1FbnRlcnByaXNlLUNBNS5jZXIwDQYJKoZIhvcNAQELBQADggEBALwIIuww1PaF
EbpQoy5vgJ/4N3xS+niIpFTKyYNAD0Ar38FcUlSnj0FIHKRj8rUmZP9WTky3U8m5B3LOyhJ14FPh
iy1EwkhZmds9fJiZyEEFiwQWYDG/uknu6zIKOTlLmtlYPfbzfi58keGcjD3T5H8D8DpCGWI1lAwe
clR9fJCbcYnQSQnuicSCfrHjjXiDZ2O8h7WbE1CC6Cj/qwo5nmS0lMv7yoG94rTNBvYe8iqOkcav
7KiZA6SdhXms3ppvFmBukI6pTheMvT39SM0S6E0dgeqZSGSxHrM7dcxUdAL4fnYMv3Sa+GAgyXB6
rihWC11+goz2eawt5TRU2w45TmcxggSzMIIErwIBATCBzjCBtjEcMBoGA1UEAwwTTlhQIEVudGVy
cHJpc2UgQ0EgNDELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5k
aG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJ
kiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MAhM/AAV1goSs
wyqoLYNbAAUABXWCMAkGBSsOAwIaBQCgggK5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTI1MDkwMzA5MTgxN1owIwYJKoZIhvcNAQkEMRYEFDQ7ifnZh1QZhlcetQCF
ppCiUruOMIGTBgkqhkiG9w0BCQ8xgYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggq
hkiG9w0DBzALBglghkgBZQMEAQIwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIaMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIBMIHfBgkrBgEEAYI3EAQx
gdEwgc4wgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYD
VQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50
MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDY29tMQswCQYDVQQGEwJOTAITLQALBG4lg6jMf7JC5gABAAsEbjCB4QYLKoZIhvcNAQkQAgsx
gdGggc4wgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYD
VQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50
MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDY29tMQswCQYDVQQGEwJOTAITLQALBG4lg6jMf7JC5gABAAsEbjANBgkqhkiG9w0BAQEFAASC
AQA7agIWoqsBPxHv8iqw7aipENpSvpDfTN/cH8AZ86P0SpE6Msev4wLqQt/5/kKppVyF8gVRARxd
sz6wNm6kr5+arXmYkf98rXTqC7qaa5SbAkXJ0oZiare69ELv5c9Le3U3xICO9Cv+7s10Cx2rEsEw
czg9vzeSGVpwdGRDCi3eGPFPwAeDGFvdEoJQAA3s3rO0fhmkDkHdE1C/lWvXNEe87Ll7CH2WuOUM
4flGEeUCUpAMyzuj4km9gFCzgS8IZYUpBuwhGqtnWKl+ZVcl2gQBLRStV+58dH7LpBrLIkT1wDYE
/N0jVwZUcNPIUU6xL1l9ctAKSle2KGiFQr/d3gaHAAAAAAAA

------=_NextPart_000_001E_01DC1CE1.C898F900--

