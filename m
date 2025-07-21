Return-Path: <linux-kernel+bounces-738998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9851CB0C06F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AAA189BD34
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653D628C2A0;
	Mon, 21 Jul 2025 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GiWHMiSW"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012030.outbound.protection.outlook.com [52.101.66.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F3228C02F;
	Mon, 21 Jul 2025 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753090592; cv=fail; b=V7GIKPsxZ/CzS1mtntawDVo0DTJ1knmc/arVnsmiOWNljVBt9ZNUh8JT/IFhLZVsaelrsX07iOnaSZC5oT8GnEGCnn71ulB2m62NnEpejX0ZrIRfF66jFEs/YnBACabfzREFCmnOTeVwBmiPnySkj2fCESMFfO+Ep2jNSNfYT8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753090592; c=relaxed/simple;
	bh=6v2Tr4weJMImUOFu5cIuX1hsZd/DCqL23AtcaASUoBc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZdtvJMgUntACCHa2M7ymvmAXken9oXFUyzupNWbX8RthHKOmpuhBFOYKOpiVllRgWVOT3/Fw1QucQCuGWqoya6KkK/D243jjc+GnXM+EEK8VHIHkmbXW5y7RvXidGTg2AgNJ4zSUMqJr0nUOJIGFBslCvqH0h0/pEGh3DgrW7Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GiWHMiSW; arc=fail smtp.client-ip=52.101.66.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrqxIS85aFlcGFGqozWLGq4o3G92OYI2lU0ILX/tmghW5D1Xc/YhM+Wft7soCL3xUoaOxjUkjmMai608WndBUD+nUWSMUrQlNjkoo2STHvhXoftn2Gcx0hepWUBVKXXuQ5QrlvNHJptY8mVvsGyQU02ghKFMX9tMCi514J3LRDLLrWNSiEOdAuqnBu6s7AApYSOEEBK/em2WmRaHC92tH05bvNnCP5ZwfJKKyJO0VAarlQfN6v9Br0d0s7ZPl6W3tLryW3O3FtxqtpphOah2JUYYEj0Jyh2M136HDH/UjMYr5by68A/qCcaJLC6YuJAFgYEue+4r3SLE3whSmAwrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6v2Tr4weJMImUOFu5cIuX1hsZd/DCqL23AtcaASUoBc=;
 b=A/hpaqFW72YOQDIrgXjf0GoFdGGaw/m5enoNytWkCpCZGfD6+j8o6xA7nobT3/RWoKGk2zE4+8JzWkl+0U2ydMSz8T0sOpJY2ecdE9zk5ABdFNmeXStfhIH5hbnJJvum5amVYeIAOPyFUPMsLMlpDFGNTtA/QJFuFgLDm2v8fAffzE/oRGYJSOe5nuQn76cTGf4FWsy1Ky7VceO9F7rc6h/fARNGQ5c5oDCd3uFtZGzqApBhCI61ENqkiO9BWvy+krQHZMQgKSNyJ32HR6MB/+Y9R1pCaBAQxij4Vg0SdOOOflrFgiXwvCAXJFdlqoQAoZq7vVvS6kRQ/cix/n4cCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6v2Tr4weJMImUOFu5cIuX1hsZd/DCqL23AtcaASUoBc=;
 b=GiWHMiSWIcPi5A5abQdLfMWlwJvR/x5lmT5aGduU/1ku1F14o3kNdFRur1cfRLrh8YdkQqEHpZ3eSUrfyIvHzxVbE7XqObbb1N1LX8hp6rpFltLyDSaWCm44p17nrsFB9F7YVPvXUWYlJaWuby/BwvuWdbDUonhdhL45rWGizpScbZUzaqfKuscHnbqT7LaaBNVHsm2hT35Q5lek6jCXfP5UOqOTXAzesbeRZgMG197FFkQ7/Iyu0Aj+cEWSqRNnv5kya4hUmyLve2YsoNbB2AhF7t6bW9bcCKy4tZFDXsf7eR22RJL+ZdXiJFxkIZiIa6krTE0crw1rvbY57fCNIg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU0PR04MB9467.eurprd04.prod.outlook.com (2603:10a6:10:35b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 09:36:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 09:36:26 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "linux-amarula@amarulasolutions.com" <linux-amarula@amarulasolutions.com>,
	Wolfgang Birkner <wolfgang.birkner@bshg.com>, Conor Dooley
	<conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] ARM: dts: imx6ulz-bsh-smm-m2: fix resume via console
Thread-Topic: [PATCH v2] ARM: dts: imx6ulz-bsh-smm-m2: fix resume via console
Thread-Index: AQHb9ZKixx02wPCQbUCjrhXm71kDpbQ8WliQ
Date: Mon, 21 Jul 2025 09:36:26 +0000
Message-ID:
 <PAXPR04MB8459C13B743A385FF26B2D09885DA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250715141322.1305512-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20250715141322.1305512-1-dario.binacchi@amarulasolutions.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU0PR04MB9467:EE_
x-ms-office365-filtering-correlation-id: fff12d36-f50d-4177-d717-08ddc83a1037
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?olIVRjUNvbGY6BypFJ0+WfePK+GFSj404kWs8cOO8vKmezB8rOHtTlsY1J0a?=
 =?us-ascii?Q?sSNt94r7+H2gJEvVDG11tN20VEEbqEqpdAKdyR9qxpCl1rllSZ9BqwoSwwWE?=
 =?us-ascii?Q?T0qtAIUVi69bQSG2rENmOMakuQnT3bRoZYFa3qBQCykZrbjw2kMEBaXq2qF8?=
 =?us-ascii?Q?c0KHQSzPPHzQxDx2Etb/2jPYNyFrzJVNNsVKr+L5VfGjWgepMroCRCPS4Jij?=
 =?us-ascii?Q?qEOyoxURbsDhG0OxwtLgYzE5cwlAqQsGGYZ5kfzCO9aIblIU7Q/2d64NzlBF?=
 =?us-ascii?Q?n926RVlWqHgWBB5R3mUnISJg1fJaaKIsWU8V9alKOV1RN5/chEmFBg2BE1VH?=
 =?us-ascii?Q?/N4GRn9osMIs0kWS+xMdJ3AcA8IrQt6laDMI9Nd0IhZpR7g+F4HqSZYuhmfE?=
 =?us-ascii?Q?yufaha3x/YkkQJI64NxjARBBYY3onsJlfxDOGWgk6w6Oa66NSjo3zm9wNxbx?=
 =?us-ascii?Q?47f1486qhVwSD6P8TAaFVZJZJT0rOLO+7Ea5iZGqwFBJBlyct8/M7/hgUX+u?=
 =?us-ascii?Q?fW8aEVEr2BNWTvA39AqjsQfynKopwJvYZLS4JqKaUHkztzJorgc1oCWb3/+B?=
 =?us-ascii?Q?woxFmVvXN5rTewv+GpcsplSx6yKgY8njmr6vUOkFG6RHtckI3bcZS6MkqFCR?=
 =?us-ascii?Q?Ebey3MLPsy9TB9cu9DHwJcVaJ45tQ2wfuiEzWeVNIWbzIweGnYur7nRlJK1d?=
 =?us-ascii?Q?Ar5z9FIPEEexFmNndKuhAg1B7ttmdxkcTt03nq86FEXVd6HHK1GygDNijuaq?=
 =?us-ascii?Q?fU0ZyKoPprWV525gaaZapXyKiAD9nvQIC3ZYx2AjnAchrarDd6nQotLRB/aV?=
 =?us-ascii?Q?QDApEoIgSgTQTJkPDAb864qba+Od98bC3sAeK4lvDJ6WLnn5Dn2L55nax4Rs?=
 =?us-ascii?Q?KL91RtPDvNDRx1KSDlnn5EmYRF0HzvUQPT8AQE2D6t62bTMpA/eIjbDAEROx?=
 =?us-ascii?Q?5MeXZgIeNUTT3wSz/27pqjYaNqDED5yOd85Y1teyaFG5uz2SlI/peiBvFlob?=
 =?us-ascii?Q?kCgC98G+HKbIitVPOMyqOjXQf2s8glA3mU7SCe42dY8Ah8fC6ftHdbpZtILR?=
 =?us-ascii?Q?C945fRnidnKjtn9N0MmTekHZmXYBxWddd3PGkvh1bLo+zVjxq3oJ294YpmYz?=
 =?us-ascii?Q?bc+Hf4MmVJULXE5ZoeINVqcb4kbIqlwit8N/9gSLTtIy8PTUedI1xUQRqr+r?=
 =?us-ascii?Q?uwmP5jVlM9bhKlUKoLdGpxVEU4jD3ReJpVGEu9ifwHkcj5u8IiuVmsQMaFHO?=
 =?us-ascii?Q?EyVAQHJL8frQopFJnoVyzq1Grn3hF/rWFpEMjSIQPukK6S0q3mf3DwgfXqBM?=
 =?us-ascii?Q?zAonGqAmx9vUs303RTMdSsyjvVPBFlkhG+aVbrzxf4+XBOgEYC3ScblWhmVu?=
 =?us-ascii?Q?cqHsqTXzUxvjkTwyikZmOyaMGCuzbNhCla66f02FVZJDnMUmNXD8KpVlZMIj?=
 =?us-ascii?Q?ZZyTVW2NyMwe/n4wjQsZdlYkGCqUiOUbKhmWRa8LPTFTPdbBeT8o6g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9jzAviua6AJcLDpnuqdnXzeY3KeEGU09lIL7SIHZb8ptlU1Py1IKyhU5Z1L6?=
 =?us-ascii?Q?LVFk8ak8HYSkW5p3lRB2Y5PA86xSKsnrwyKlxxbY+0tsII2tdJvvE7ZgTAug?=
 =?us-ascii?Q?HkGzYGr6LZKqIe4bpPu1/kwFiRPXfvdi1w/2tOYKwE4cgCSObFDY4FNghix1?=
 =?us-ascii?Q?VrQafqnTzrgnZaQmyEtGWZDSBwGjsm4TB8c6XjH218xRUWNQRl+Rj4ZKlEnM?=
 =?us-ascii?Q?RGPkulF1XWw/rStsTIovpObeks0gYO7RueYX2Ym5AeE//IQZG4QTPJInddi3?=
 =?us-ascii?Q?mBNOv+tuwmRuOEI7bRUBYvT4ZufYOEVIO4Fn2+1ZpZgJxG6a4RZ9bUopCnOw?=
 =?us-ascii?Q?F/h1gMgrl83NTFSRTADBwjJ60V83gZ2+WGSjhVy4O/65urG/OOJJok1IPw2b?=
 =?us-ascii?Q?BAdBggrocAIL6xrreuQYJp0dHRdhORyr7DunGWcrVf8bf+8TT4dpMYs0HbyQ?=
 =?us-ascii?Q?gRywnPVKv/Su33AJZoQLHVHweWImHAH/RYmt12OjJs/EkUwXfyjvu66Q5Ekr?=
 =?us-ascii?Q?cssbQvDlQZfNX156G0cosVE1A43bjXG5IFkLJ1wNdbP5aVEGzFQGRxdmjrch?=
 =?us-ascii?Q?9DaM6F63wwvM/pcYDcdeJd5msAN9izUZwK5lb4W7PzgHXePjVUKJkN9IAf5Z?=
 =?us-ascii?Q?BdgHQBJoMVFSsIKCq1bt4fC8wWqElWa0kq8oY/bT+5PTXTalFBLzInR5Ockr?=
 =?us-ascii?Q?vE+L5K1nxEGtxDjb3dQk0rmV8L98cBa2Wi5a39KyolmWVwsW+X/SfBV2WHNP?=
 =?us-ascii?Q?wR68UGHDA1CzGhJStklckLtK4xfpYjdxVd4mHbdxqXUq7DkP1raiNPKJ08lU?=
 =?us-ascii?Q?3X26hBvgaj9/wVJYAVztcQ8dTguKqdpcZO7WSE0AZcDWmYvSZL88v6n7YPWw?=
 =?us-ascii?Q?YA5j3uUryX/WM3KL9342BCCUITrBYKFkrJOsQC/i7C/yelPrQpuodir9Y9t3?=
 =?us-ascii?Q?h4O38nlJAkiIzkppSBF6c5SEe1HgGIxhmJjelQ4s3KGVJNkKo11VTNyQce2F?=
 =?us-ascii?Q?KRX/yBnz5ayqK/9gL0SW+xvncSGuL6q9MgRIxKMefgu8+SLRQGva97iEP4zO?=
 =?us-ascii?Q?++uxr9YCKAHYQs/qt9otdmtSMRpEzZHFZgBR3KrSLlOr7NUQETD60QjMO5sf?=
 =?us-ascii?Q?cgH5g/bQJNQQYD/JlQmx2rTZN/7NWp4hjDIIAsQO78zFtRzS/NpgmdJy0p0x?=
 =?us-ascii?Q?v2YQM5DUX3uVBtp3DgBWYr0bEaIO/w1IN0mO/t4jplWCs3cb0OBLl2skN02e?=
 =?us-ascii?Q?BLSuNq4FUWwnKQpyWZl1VxOuxuEvZE+sG9RcTxq41A6iCww/uw0vnOnriGR1?=
 =?us-ascii?Q?0cp4N3Vh5w8nwQG6/2/Y0kYR4YVRWBswqlSPot2XLdn3nBzYF3DOVu415axW?=
 =?us-ascii?Q?xifBkXUP5TYRxZKgcH4ICnULcoxNFQtHx4AITC7Mc+8vrdgpIRJ1leQDoGm0?=
 =?us-ascii?Q?GhWqB/gUGuZF2nmdjzUzVOmnJ162q8MA1zi3AJS8OoMW1nKrlSl6Kv3Yrz2b?=
 =?us-ascii?Q?hEkcuc0j5jo6vlciRXrVCwOCX6TZeodZHX7hA6o1EoutbhsA6/MFYNaHomBL?=
 =?us-ascii?Q?R6TwoT2E8NQe29GdX6Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fff12d36-f50d-4177-d717-08ddc83a1037
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 09:36:26.2085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UWHtjvw5iJQTf4PZPy2CSDizBQ0mmLzXaHGbDP39Vq0lRoX0D4JtUxIrGyGf8B0EVaTorFvZFvuvuusSHmMbew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9467

> Subject: [PATCH v2] ARM: dts: imx6ulz-bsh-smm-m2: fix resume via
> console
>=20
> From: Wolfgang Birkner <wolfgang.birkner@bshg.com>
>=20
> Despite the current configuration being compliant with the technical
> reference manual (TRM), testing on the system showed that resuming
> from suspend via UART4 (used as the console) fails unless any other
> UART is also enabled.
>=20
> In our use case, UART2 is enabled to ensure reliable resume when
> UART4 is used as the console.
>=20
> Signed-off-by: Wolfgang Birkner <wolfgang.birkner@bshg.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>=20

Not sure why there is dependency here, but enable it
does not harm, so

Ack-by: Peng Fan <peng.fan@nxp.com>

