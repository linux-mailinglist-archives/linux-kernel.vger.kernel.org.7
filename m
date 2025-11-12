Return-Path: <linux-kernel+bounces-897118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A181C520BA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B2F3B0C62
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EA7311C33;
	Wed, 12 Nov 2025 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oQjhwHTd"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDE2E56A;
	Wed, 12 Nov 2025 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762947496; cv=fail; b=qu0LW9YdTVbKEPL29BsjRKYAANossYP+PjVZdwIIrDxitcyPJBQIeERqvDyu6VTCdc/j0K/lrI0wuDDB7qjoQsvk3Sg4S2ORR/3LD1Yv10vXC6YxdyNWNxbgu7DerBKHoC2Q1swc9DPIF91I1TOpWOUkfw/vvxZQ6c6hRGUJ7/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762947496; c=relaxed/simple;
	bh=dadx+1xfvRn5ceuxZzOoJhrEQyl0oau6tpOO10/Iwbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nCT3ywra34cYHSffP1lViXJh/5bO5ScwxF2GNReKPoqNLDgSiRwZ4ZvNq6OWYgrBqDVxrNE54zsJp2vlWXJFkqzhzekFcT6JuuLmM8JUts8UWmPHwIIEGO9eIt9NaVsdsSDEqSc0NajfbCS0Z8mEXh7biH7F9KR4qeIiqa0Mk4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oQjhwHTd; arc=fail smtp.client-ip=40.107.130.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4zdK1RzQglNaJwSPeMjrYmS16XbNnmir3M1OnhLmyvbTAxhefm70GT6GbFdsnkH70qvYagavfG/0Cm3jpNqfMHOGDu7lhpZHXoJ8np9hG2fWRGB3HaJpjLjFvihnjDmqtJQua7y80ZWRkpy6nkeH26fCuh3km3OCxFKudKfahzk/yiMXIbD0KmKnmC9RRie9YnlK9QljZhdGlzqCCRKVw7bTD4GVUQ/J682WICGVyGUA0Pt4ce6lDbJpvyvbitBtcNPl4tv+zbV4wxLgpetv+XNcEqgceitncoZR2fOfrCsOpKP2Q3xXob83UOo1VVGbwZWXitEGC3S6FyeTde/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cucGafVCKh94xNHf3vtUH96WRUAfp6W3URky+uAgXJ8=;
 b=wcKQzjkLqEc4ntXuKgPDb6AQ53TeN9f1b37s5Y0hIyn180aiyaqbPQqFOv17UkQXNKA941AGaNBKZ44yF5RJf6NxuEoXGAIkTbhpm8uDV50KzJuxx0izvVpcRj3Rds3lyyQmkzCPU4l9cnz/6ODfrHtZAIMCPqcHZs3zlbs8GIoEyWTcWlV8GZKD81iyYKCadTjuCMIXB2f5jlTRSU9jRfzNIxZU0VVu1yJ6a+9fVOheUNYcV/Ail7SFKbBVan02s0mvoF5PmnUmvJBaK7B/TD+QFghKjS8Wfm1NfmE0XK7cO7gSwd0W54T/hW3PLsUxZLRrVZzt7FJlZtY269NfFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cucGafVCKh94xNHf3vtUH96WRUAfp6W3URky+uAgXJ8=;
 b=oQjhwHTd9xgXeNpKe/zs3ZgSutHsCKS3B3yUEWTvSa2ieZh7PN32JcffWDfqV2XmK1lZ30y02Kaakrcaup84PFtVl6E78x4D+X/8V6F+DCPmzuzv3d7B0dZhQ1z2g8wxl767LqXu/kfKnwH7VyJIy4Rlt+PAQvyEkt/q4NtMh0Rmum+zDmIRRRbwBZafj9mQBsS4oaOY4jlP2oOlOEsIP3Z0teFzjKehE0Ok6HB0oV7IBWcIefMe216TEBqfkeikInt5ymX2mA+IhKVz+ivB8ZNe9HLkforLP6ViHRa1yA3teKs9E018OREP966u0TMSTeMGksmw49Pewz3O28Znbg==
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB9PR04MB8265.eurprd04.prod.outlook.com (2603:10a6:10:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 11:38:10 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 11:38:10 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Frank Li <frank.li@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v19 0/7] firmware: imx: driver for NXP
 secure-enclave
Thread-Topic: [EXT] Re: [PATCH v19 0/7] firmware: imx: driver for NXP
 secure-enclave
Thread-Index:
 AQHcLvztIykpoCx+vU2TOsTcO77HnbTExb+AgBDxjcGAC9UegIAFbnEAgAbBcwCAAR8p0A==
Date: Wed, 12 Nov 2025 11:38:10 +0000
Message-ID:
 <AM9PR04MB86047231B5320C01759BFCAE95CCA@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
 <20251016114151.jzmapaecsmmnkpt3@pengutronix.de>
 <AM9PR04MB8604C2AAA70406883320C5C995FCA@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20251103190811.wp4o7hlnus6ynn32@pengutronix.de>
 <AM9PR04MB8604AA80EC97E06AADBF334695C3A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20251111131442.nddhk3475oapf2zh@pengutronix.de>
In-Reply-To: <20251111131442.nddhk3475oapf2zh@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|DB9PR04MB8265:EE_
x-ms-office365-filtering-correlation-id: b7c94aaf-87af-4501-1827-08de21dff513
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?X5/GfL4/1QjT1IOAnMbgYUtyFk0N/S8AAE5Yp0gyFZgpVNchaUd15NA/vrOD?=
 =?us-ascii?Q?Qdi2XeMYqnpT0dLnB4IAXxFhYrzlgk5zXIAfuAX/puDvgUf+Kcic4AeL5IYl?=
 =?us-ascii?Q?VnMzMd7BX2/wHZw1qHiFi2HHg7zfxkwVG9V0I9RVWHY4/15jCVqBnEgdykA3?=
 =?us-ascii?Q?KHKkIXV+3/p4P5ldgtCxVtHmdNxEWy3nOWRdkvS7Wp1kViqqnHE60EATPn2t?=
 =?us-ascii?Q?YpCOJTshDgsJHXgZqQnTEdUDtDa3w9euIFtbFYUoa/TCtvEPcQy1WrOL1WQ7?=
 =?us-ascii?Q?m0yTDOe4ylszIXmfOFJ6woNnB/8gZRH23GP3ZDFzKv8OIk9n+BvY2xF2p+wE?=
 =?us-ascii?Q?XdnZag381KWsWprLxIkIsjQFysB6PWNk60Jl8gqOUc5jzaQZMulZfV2thLBx?=
 =?us-ascii?Q?pMc4P3DfvBIcKO0kcrpDuynl3upXB5oqj8s9ZPPmBcK/M4gjPNBr7vPe+GkA?=
 =?us-ascii?Q?AOaGDYGUZ32bzXOCAz6EFdTAhbNN5sN1Ww2tqHeWBLpr0ZemiQL5kUnOkFzg?=
 =?us-ascii?Q?3gz1PbYYOjIFvJTxoanEaZy1yL2QpXQlCpqKCkmsZNRdMj8S3M6vfqjxpCJV?=
 =?us-ascii?Q?AmrIrjKR2uDgf/fAXo5VGACnQwUElQ34yLp68eMyprWBs03jIi7LEvgSSrny?=
 =?us-ascii?Q?H/zZ2EkBfEO7a5MFBfmPRu35WNhnu2+hWkBPAbygrPEVPwdKZkS4z1k2U0Ef?=
 =?us-ascii?Q?zV6GP6fRKzuuLDIi+bSTg79KdxhCh/5rzx27SCnn8NJgyaE3Rp86bdex+M5J?=
 =?us-ascii?Q?o2D3hO2x1xouMip8kRKeExPbK5RXl7ubip9Swj8s3pJ7WUAQm20Vopb4fEWy?=
 =?us-ascii?Q?6b8zYHgBVarsdMDxnUxZsjdVBkmJf3vFOTlFEvb3xgOfsAqisZ2JaKLvSyS8?=
 =?us-ascii?Q?lm9cwix3phHXLlH3KX+rSSb4NqIDXIODrVsJe9XnQz2wrnTjdSyRcHbUNfI/?=
 =?us-ascii?Q?5ms92o3W7mDAzrtLkt+GduZxBf0i0yz4fWhPChDBR6lrtozRU/9VRNDSEu+6?=
 =?us-ascii?Q?ypYrQZeCEKqHag/9wJYFG/lL/0TH5qhi/H7+HbXisUFpqJRITO82AHNwpC0p?=
 =?us-ascii?Q?Ll8RL7vqMKDvo8J9Oc2ZGFF3wZidZ2FaUrzfrrumd4Qw3T5jGynNQ1UakMx8?=
 =?us-ascii?Q?vepx+USTZiTeh0b9IDkfdTBm3LxQeVtZ0+RdQ4O0BW4K0s9SJObhxnfeqWhy?=
 =?us-ascii?Q?2XpfRgaOdV5V5EUGdJWYe0b4m+maIzAnqJvk9EWIcf/Q+ZCOURZUBv0lskFB?=
 =?us-ascii?Q?p0jUZnC+3M9HnbfyU5HsEahRJZDn3HWAnHlXtw8EMOp846IoodQGZ0EE8Tfi?=
 =?us-ascii?Q?gC8Nxek+q/NOE49JVwNmSkwVbPD9J6yknyrof8avcA5LQMY6mJOOgxVzfOeC?=
 =?us-ascii?Q?xUku3b6sn9PCVUFHuUtyCsvtaXhChnQkaxG092ZaqCQFm3+RC8ssOZrRcewM?=
 =?us-ascii?Q?ulE1NAxiET6UKxz6QSO9ZTX7D3eD851zbjAtrL6w2b4faoc+gTjPIg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YKTo+m50ZcsfxrtJRssk1CAF7wJhYvQgy63IR77Jz0UY1dxIoluQkjs++POm?=
 =?us-ascii?Q?Rpn1Rj/8PVXD0D/W927J+Z7SpZuvAB0wgIr81yJe1Syu6sw6KG+7UsK1SUqK?=
 =?us-ascii?Q?ORCh49/gN0mU7bzO1/HjU7nSxu9GrUFsg10msjghtRwiknnBmPx2zaDo+Xdf?=
 =?us-ascii?Q?7RX0Xoi0g6md0068TBu5R/PILv/gDQ/nNzDluu63mgMDtzN2Hy1Ng3b2Blca?=
 =?us-ascii?Q?6bvMHeDZTc/jaI83bkekaaJ6/e010Uti1J4nBiuaeFVdCJXM20DaA49ta9Az?=
 =?us-ascii?Q?ho4H2FW2IeWV/dKyPVoIFkeaH+18KRBCG0O05HdFk3qJT7m03dtFVrBv/vDT?=
 =?us-ascii?Q?IBU+heyv64RUhmOoVkG//pDKsiSg1X8tm3WGWAYHHFHING4DOPaezVzdUHjl?=
 =?us-ascii?Q?sEgmB72aXcTE2elTzlJ7Q1pnXzSqye1lPY9SyTp0gQOm4Ub7wDoc5YwiFX9R?=
 =?us-ascii?Q?9snu9j+yR/Y2xUxggjY4hXnj2aKwdJSCjilT9/8/8VwiQ7EnABJdPGU+MbNq?=
 =?us-ascii?Q?yEmboDjeXRP4XS91Gsu0AaEHkoVa2UCItjXtegCfvYTCYA0wqE5EsUVYGH+Q?=
 =?us-ascii?Q?80cW2Ul1boaaFDZD6b+b0/F5AYSGiTWxeNOUVD8zIPZ/zgITazVoj4AMhu7v?=
 =?us-ascii?Q?8gMPgaIhCK8QrPNVKKByMAAc2HSYYCfzkPHG+IHeDCdWf7fhmoh81/KWk13Z?=
 =?us-ascii?Q?Cfboz1R/gtlKckCJMD/7PxY+70eC4/rdB49faHQYyesit2pPEYz4Ywcemgg3?=
 =?us-ascii?Q?r5UoXIL6poG4+3L9rizjXapvjkc57z53IzQ6EHV9Eh0jSiBPUbUjt6u+B70g?=
 =?us-ascii?Q?cH/18oeWrZMsl8c3o8RHgVt57H4AwbbkIqQebGUpMstychCtXHSW47cauyj/?=
 =?us-ascii?Q?jbOYqv56e8tdhTmxlISiOYXHpYp7Yh2w/k8v1NE3clxEXYtztQFYbSdnTEa3?=
 =?us-ascii?Q?lH8gjanC9u8nVb8hzwh0jZ1VjxJvKk04g4+XnwgcnSuijson6GLauVHNRdgQ?=
 =?us-ascii?Q?OLdjT3BZF1kYLBkjyNLA0VDlSM4ZUl8gf+JDB8zBhgmtF9wMim82ooLXiEYl?=
 =?us-ascii?Q?GI+6Z00jShkRGtFXm0H6cKcYisDXBS8ThuSKGnjjUnwFpQKpOU6Yssu8WaAh?=
 =?us-ascii?Q?3iSbMEVl2Eaicz9LBxknW/Io2CB5ReMg42jibresASU+RvfjTYh4zuLefvfG?=
 =?us-ascii?Q?JlbpRkhUC2AxiSFoGZZ0uunWKbqxRiAXpqHMmKHPd/BVJMOyQMTgAbYRfnt7?=
 =?us-ascii?Q?Zs04FjcU4P7CJWMj6x/lmJU4IUBG8/C8goD4dn0CYK3HC+zUbI1Z0JcfQdg/?=
 =?us-ascii?Q?yhhv8mSTp4pg+BvcXXLMG9TvYYZNKZCEyjyXudPOINEZAGRRfHykvRbnS5CX?=
 =?us-ascii?Q?8sgsEVxAm7tgh1j/5I10ZDfyH6yKAvMzRJPqmsG6XCtl1RgDFb9K0Y/Nc/ad?=
 =?us-ascii?Q?5OnkN+7Ahd/WLpafLyRdYNSfOsR6Iv+l1LRfAEpCGYDd60KQBANJL32+ot0C?=
 =?us-ascii?Q?hjVibj8c97jnoTszuwH239ZlKIkWz9/tfP0ZBv+1MefEYH+DfyJvnBf2NkwR?=
 =?us-ascii?Q?r9TPRKO1zsNfwtRE6zkFGDE2AOxBTRVYN0fec3ON?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c94aaf-87af-4501-1827-08de21dff513
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 11:38:10.5744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U3HBV7zMAT6wcHdlqlUhyEJHvhgFFTQgY99FMvNKJIEQGhLFgy1PuVTtQ4GG6PqvRwbrX/bHsnMuZM+7FA7lBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8265

> On 25-11-07, Pankaj Gupta wrote:
> > >> On 25-10-27, Pankaj Gupta wrote:
> > >>> On 25-09-27, Pankaj Gupta wrote:
>=20
> ...
>=20
> > > > It is not yet up-streamed to OPTEE-OS repo.
> > >
> > > My intention of adding the above OP-TEE discussion link was to point
> > > out that an ELE-FW bug exists which needs to be fixed.
>=20
> ...
>=20
> > > This adapts the timeout value to 100ms and seems more like an
> workaround.
> > >
> > There are additional fixes in OPTEE-OS, that will be part of LF Q4'25.
>=20
> Thanks for this info.
>=20
> > > However, can NXP confirm that the ELE concurrent access is possible
> > > without a previous ELE FW update?
> >
> > Fix in the ELE FW, released as part of LF Q3 2025,  is a must to
> > include. OPTEE fixes are also needed.  OPTEE fixes will be up-streamed
> > soon.
>=20
> Okay, so there are ELE-FW fixes too, thanks.
>=20
> ...
>=20
> > > Does this mean that all i.MX9x, i.MX10x and so on do have the the
> > > secure and non-secure MU setup? Or is it based on the SoC release dat=
e?
> > > Because regarding the datasheet the i.MX8ULP is newer than the
> > > i.MX93, therefore I assumed that the i.MX8ULP has two MUs as well.
> >
> > From i.MX93 and onward, there is only one RoT. Hence , it is designed
> > to have dedicated MU for each world.
>=20
> Okay.
>=20
> > > I checked the the NXP OP-TEE source code and found the following
> commit:
> > >
> > > 8<----------------
> > > commit 44388d37e68000ee50a9b1d656e0a60ae6614977
> > > Author: Sahil Malhotra <sahil.malhotra@nxp.com>
> > > Date:   Tue Apr 1 20:04:44 2025 +0200
> > >
> > >     core: imx: disable ELE on i.MX8ULP by default
> > >
> > >     On i.MX8ULP, there is only one MU to communicate with ELE,
> > >     which cannot be dedicated on OP-TEE side all the time.
> > >     There may be ELE services running on Linux side, which can
> > >     cause conflict with OP-TEE, So disabling ELE by default.
> > >     Moreover i.MX8ULP also has CAAM, so HUK and Random number
> > >     are coming from CAAM.
> > >
> > >     Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
> > >     Acked-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > 8<----------------
> > >
> > > So it's possible to configure the XRDC (configured in the TF-A) in a
> > > way to map the ELE access to the secure world. If I got the TF-A and =
OP-TEE
> commits right.
> > >
> > > To me this sound more like a NXP design decision to move the ELE to
> > > the non- secure and the CAAM to the secure world.
> >
> > As per the i.MX8ULP boot-up sequence and ELE's initial role in
> > boot-up, with CAAM co-exists, ELE is logical to be with Linux.
> >
> > Another point here that CAAM has 4 JR(s) and hence CAAM can be shared
> > between Linux and OPTEE-OS.
>=20
> Please see my answer below where you explained the ELE functions.
>=20
> ...
>=20
> > > i.MX8ULP is getting really interesting, though.
> > >
> > > May I ask what RoT is used by this SoC if there are two?
> > >
> > ELE is Root of Trust during secure boot.
> > For OPTEE-OS, CAAM is RoT.
>=20
> The i.MX8ULP is very interesting, since you also need to handle the SoC
> secure-state twice, right? However, this topic alone is worth it a standa=
lone
> discussion thread, therefore no further comments.
>=20
> ...
>=20
> > > How does the i.MX8ULP fuse flow work, after the LOCK_DOWN fuse is
> blown?
> > There is no such issue on i.MX8ULP
> > >
> > > This was one of my main concers why having OP-TEE required in the
> > > first place, because the i.MX93 requires the that the fuse-request
> > > comes from the secure-world if the device is in LOCK_DOWN state.
> > >
> > > Is this also the case for the i.MX8ULP?
> > >
> >
> > No, this is not a valid case for i.MX8ULP.
>=20
> Thanks for the input.
>=20
> > > > > Also according your IOCTL docuementation you want to expose the
> > > > > whole device to the user-space?
> > > >
> > > > > | What:          /dev/<se>_mu[0-9]+_ch[0-9]+
> > > > > | Date:          Mar 2025
> > > > > | KernelVersion: 6.8
> > > > > | Contact:       linux-imx@nxp.com, pankaj.gupta@nxp.com
> > > > > | Description:
> > > > > |                NXP offers multiple hardware IP(s) for secure
> > > > > | enclaves like
> > > EdgeLock-
> > > > > |                Enclave(ELE), SECO. The character device file de=
scriptors
> > > > > |                /dev/<se>_mu*_ch* are the interface between
> > > > > | userspace NXP's
> > > secure-
> > > > > |                enclave shared library and the kernel driver.
> > > > > |
> > > > > |                The ioctl(2)-based ABI is defined and documented=
 in
> > > > > |                [include]<linux/firmware/imx/ele_mu_ioctl.h>.
> > > > > |                ioctl(s) are used primarily for:
> > > > > |                        - shared memory management
> > > > > |                        - allocation of I/O buffers
> > > > > |                        - getting mu info
> > > > > |                        - setting a dev-ctx as receiver to
> > > > > | receive all the commands
> > > from FW
> > > > > |                        - getting SoC info
> > > > > |                        - send command and receive command
> > > > > | response
> > > >                                 ^
> > > > > This is a rather uncommon approach. The kernel has interfaces to
> > > > > abstract hardware. You completely bypass this if you expose
> > > > > everything to the userspace.
> > > >
> > > > It is in-correct.
> > > > Not everything, just exposed file-operation. and ioctl(s) for
> > > > DMA(eable)
> > > buffer allocation from reserved lower memory region.
> > > > Things managed by Kernel:
> > > > * Send/receive path to ELE, is managed by Kernel.
> > > > * Receive/send patch to the ELE's slave NVM-manager, is managed by
> kernel.
> > > > * Low power management handled by kernel driver. In case of
> > > > low-power
> > > state, ELE driver re-init the V2X IP as part of resume.
> > > > * Other kernel management layers like NVMEM, kernel HWRNG, will
> > > > use the
> > > api(s) exposed by this driver.
> > >
> > > But you also expose an uAPI which allows the user to bypass
> > > everything via sending arbitrary commands, right?
> >
> > Yes. But it's not unusual at all. The pattern of userspace sending
> > commands directly to the kernel, is quite common
>=20
> Please see below.
>=20
> ...
>=20
> > > Some features require the device to be in LOCK_DOWN mode, which
> > > requires secure-world eFuse write path only afterwards. But it seems
> > > like NXP really wants to maintain two write paths.
> > >
> > > > * Low power management at Linux driver.
> > >
> > > The power-modes are selected via the ELE?
> >
> >
> > Voltage regulation for i.MX93 in Linux kernel, is done by ELE.
> >
> > During Linux suspend-resume, Secure-enclave (V2X on i.MX95) part of
> > wake-up domain, will be managed by secure-enclaves(ELE) part of
> > always-on domain.
>=20
> So to sum-up, please correct me if I got it wrong:
>=20
>  - NXP puts the ELE into the non-secure world, in case only one MU
>    exists. The reason for this is that the ELE is also used to handle
>    power-management.
For NXP SoCs with multi-MU(s) too, NXP proposes to put ELE driver into non-=
secure world.

>=20
>  - NXP exposes an uAPI which can be used to send arbitrary commands from
>    userspace to the ELE. (no filtering done yet)
It is not correct to say that no filtering is done.
Before sending as well as after receiving the message, the message header o=
f the buffers
are parsed to check:
- TX-buffer with Command-tag is allowed to be sent, RX-buffer with response=
-tag is allowed to be received, without logging errors.
- TX buffer size & Rx-Buffer size should match the size mentioned in the bu=
ffer.
- FW version from the header is checked, if required secondary or runtime F=
W Is loaded, before forwarding the request to ELE.
- In certain cases especially for exceptions, the message IDs are also comp=
ared.

>=20
>  --> Sounds to me that the userpace can influence the system behavior
>      very badly.
>=20
Messages created and sent by User-space library(https://github.com/nxp-imx/=
imx-secure-enclave), are scrutinized as stated above in the kernel driver.

Moreover,
As part of this library, message creation, send-receive, IOCTLS etc. kernel=
 interface implementation logic, is not exposed to users of this library.
With the help of secure-boot and IMA-EVM, rootfs can be restricted to not a=
llow any new application or modified userspace library, to execute.
This way bad impact to the system behavior can be prevented.

> > > > * Linux HWRNG.
> > > > * Loading the secondary runtime fw.
> > >
> > > What is a secondary runtime-fw?
> > ELE FW size is larger than the size of ELE internal secure memory.
> > Hence FW is split into two.
> >
> > Primary FW, is the FW, that enables features that helps for SoC boot-up=
.
> > Secondary runtime FW, is the FW, that enables features like HSM.
>=20
> Ah okay, thanks for the input.
>=20
> > > To conclude this longly discussion:
>=20
> ...
>=20
> > > I still have mixed feeling about the fusing (including the 1-MU
> > > case), since it requires a secure-world OS in place once the LOCK_DOW=
N
> fuse was burned.
> > > It's fine by me if NXP wants to have and wants to maintain a multi-pa=
th
> here.
> >
> > Write fuse API will be added, to allow writing fuses from secure world
> > too.
>=20
> This is a device life-cycle problem and if NXP decides to maintain multip=
le write
> paths, depending on the runtime-SoC state, this is fine by me.
>=20
> What needs to be ensured is, that the fuse-issue doesn't exist for the 1-=
MU
> case (i.MX8ULP) as you said.
As said above "Write fuse API will be added, to allow writing fuses from se=
cure world too."
This will be true for 1 MU or multi-MU.

>=20
> > > Last but least, the uAPI which can be used to send arbitrary ELE
> > > commands seems unusual. But I don't know how secure-enclaves are
> > > abstracted within the kernel, so these are just my two cents.
> >
> > it's not unusual at all. The pattern of userspace sending commands
> > directly to the kernel via a queue is quite common like:
> >
> > GPUs: As you mentioned, userspace drivers (like those in Vulkan or
> > CUDA) often build command buffers and submit them directly to the
> > kernel or hardware.
>=20
> That's right, but these drivers do at least some filtering on the OPs and=
 check if
> they are allowed. According your patchset, you just write
> (se_if_fops_write()) the provided userspace buffer.

We are validating the buffer size against the size mentioned in the buffer =
header.
Refer above comments for more details.

> > Secure Enclaves: In systems like Intel SGX or AMD SEV, userspace
> > applications interact with enclaves via ioctl or mmap interfaces,
> > often sending structured commands or messages.
>=20
> What I'm aware of is, that most secure-enclaves are switching to the stan=
dard
> TPM API.
In case of NXP SoC with ELE HW IP, ELE is considered as on-SoC TPM. No addi=
tional or external TPM is needed, if ELE is present on SoC.

>=20
> Regards,
>   Marco
>=20

Regards
Pankaj

