Return-Path: <linux-kernel+bounces-866499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B6FBFFED4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C16F3AA54D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5702FB99A;
	Thu, 23 Oct 2025 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="EmT1uYpg"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022124.outbound.protection.outlook.com [40.107.75.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF822FCC06;
	Thu, 23 Oct 2025 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208177; cv=fail; b=QxY+v5cIhfpOYOJNQaI79VaNhUmkAOsxVQUPJ+NSdB4UV86eStNFr4KJXhojfrYcPeUajFRTOio81PdZ759FY3XpWJ0sydTN2WUCjYKEXHPZUbrxljynRqYNF77K1TOegxIsNgPIEDDeDkGUYS3EcNFYuWFz/LezZ6D7aEviy7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208177; c=relaxed/simple;
	bh=0tgitGA/0sxG6qja7A/xrOT5NEBfX0tFpIX+mcksAP0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q4TWzPrgZZAe3oqGbVK/VJRDgULuqNuxw8VzIx2GsLWBWq6VX++BaUhnpKBkW2ndV3pdk7UOnqUJlHGOJodVrfBW0ZrtkDa70poJH6Qy726PzE0Uko1QtxFBqWqwylNt19R1nnVBJGKgVXpPkbW4XfJrmLXuJhhXHHI38dLlzvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=EmT1uYpg; arc=fail smtp.client-ip=40.107.75.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQSeIBn5N5odynob03swtvYUJqCzk+Wr4/0W87MkA/aUiO/S05B5+F7b+gEAVU3vnULMiGs/QA4uTUCl282OCLJYMND2Z+e1LGFIr2+fXOgP7qWfpyd8Phya84qCgf9YjQDnQuC1ktt6cvYi8r5vhTvEakKN4Lk612LCiEiDdy/GDI2s6v4KeQl+72JRyE3iYL+457AH8NLEWexMfEuv3NV1k2Hhsmht0ZGg2tjsoQe9yhYPk6zHRj1nYlw+BPIpHBBQwF22xlbvM7X06QVmzhkaTLoAYv9+5UykUSPLyRI8i/hmyFEa3VwVyZOcVMWKSw+J6cMOnRCM9WUjY/d88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLXj+X2nyyxuKXeHjDsw43Fi55PMCTIb2UDXTrS2poQ=;
 b=UDyx7Un9L2wW3qN4uzBx5E39eo5xnH5FyyM7J2L1fgEFkql009tLm2JKZyyIhy8zLNdjgg0HA3JgioHqalHtQEjxNn0xTEIL6AasutfBw2JICxVKosAiPC/Z1ZEsAyWrYMLdTYw/QqlI3tXXs/hSNWHZiJmv3G5Nr1KD+isRDP/Av3A7uk2pUgH+3YLT1JEM7uI0gKW1kCrkTKMe0YIKfawII1QuJmQYUpBfzg42UNXG4eAS9asd/J551/ns7M7bC7v/re4hsHFwBl8x3c9VZKiSi+e1mebJusN3BQAWgwtVDGzrF9fXMST5Q0qHAc2t2MTilqycXYSFqYjcqQJJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLXj+X2nyyxuKXeHjDsw43Fi55PMCTIb2UDXTrS2poQ=;
 b=EmT1uYpg4185MRSZzFtgMHj0B1ImcgKO/8lvTvBjzuqSuLb99eJ4pDsxoER6xbAZ2n2WzT1XoONyWhxV1+4gClNGRK3F8VFO6rR+n4XSbPKwj0DIjfwR/6oQm89JGDjIV3/6DQDQtaGOXGFeJR3C6Eqn6NUPtVAXvU6/Sa6Yx7qcq0hgrJLSwmVXsgza2Tw+k5Qy6thIsFgPAa+pschPgvbe1BwYHlnBf2Y10OthRumFSMXReUQcYpVNYcw6X8YIPp3tEA7d1hesohTawlj9LzlEjLC7klQnKpPS90mur0cdF+lGvGXPdQBbuVZMCPJxuoFR9byB2yTji+QHPJqPDQ==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SI2PR06MB5340.apcprd06.prod.outlook.com (2603:1096:4:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 08:29:30 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 08:29:29 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"jk@codeconstruct.com.au" <jk@codeconstruct.com.au>, Kevin Chen
	<kevin_chen@aspeedtech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v5 3/3] irqchip: aspeed: add compatible strings for
 ast2700-intc0-ic and ast2700-intc1-ic
Thread-Topic: [PATCH v5 3/3] irqchip: aspeed: add compatible strings for
 ast2700-intc0-ic and ast2700-intc1-ic
Thread-Index: AQHcQyDSWW55133XQ0ux9XL7yULGOLTOYeUAgAEEmEA=
Date: Thu, 23 Oct 2025 08:29:29 +0000
Message-ID:
 <TY2PPF5CB9A1BE69A2BDA1BC2C78A7FFFCDF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
 <20251022065507.1152071-4-ryan_chen@aspeedtech.com> <87ecquyj5p.ffs@tglx>
In-Reply-To: <87ecquyj5p.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SI2PR06MB5340:EE_
x-ms-office365-filtering-correlation-id: 5b56b752-2574-4adc-2e5e-08de120e4917
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?J/ac8x460gn4WuLnhvotq1xq69MF+pjUlGTsZRxYbgMEiRbuv2it4cTfinRT?=
 =?us-ascii?Q?tOG+dIIilYjioNJ0JtwBnhqdtGj5ZgXtr2qTSaQTk9EsRPwGc65lX43Hin7/?=
 =?us-ascii?Q?SiY9y355N/8dIsT+HCMAAK06/az1OP9Q29PcI0fvTLtUGrYSRGPgK0M8UGlO?=
 =?us-ascii?Q?hGbjU6kxRPPizNh6n6E7DxRQ8zZcW3d2bGMZPgo+klRqyEqTwVYl/N7Uy3bf?=
 =?us-ascii?Q?hzUbjmB4MJL7S7VtT+T8aHESKbIw5vpmWkvdYm3LOWc3JmpF+onI8Q4rw1+h?=
 =?us-ascii?Q?wJzEar2GmN1BamRZlDCOp5ARz3pEwmgBVS2LIv7mbd8Qfp/ALXrih3h5i15i?=
 =?us-ascii?Q?LfriTkyDWYqtCmpgJ9EuyelnvLYMYbL+QftwC0+CCGyFo3G319UitAwLubZt?=
 =?us-ascii?Q?iPMTIa66F6PrUaM22xi09Fo7clYUxJ3siDtuV53usGCX/+bAH6xUN3XF2d3h?=
 =?us-ascii?Q?fQcqK7qjiI3JfHQ2pVlimkSpFs3W24nnHHY+YdyE53YxVKhxwtaqpAuzhyKN?=
 =?us-ascii?Q?lQXyL0FTnHY4PYIyPu06Rv7DGVEcs0E2L2aODFF8suEl7yNI8cNQiroH8rc3?=
 =?us-ascii?Q?9ucURkxf8ICyq6xmqtbX259VQkjGM0OM5igViAiMunun7ulEHs4swHqBsM3s?=
 =?us-ascii?Q?rtQQEUk8FRbM82Zs96FowTfOFaKn/OJa31UEY1qA73qmt5K9zxZJntlBk8ua?=
 =?us-ascii?Q?uhncCTvan/1TY4mzBRoRXMQMSd9B5gIZXsC2HqyyW/SMOuusgoCz3HUa9Oom?=
 =?us-ascii?Q?mQDi5Ucl83XSVKP6USuYFRrMUbeUtaGdCF7sDA6szywXNvowh5jMOdIynnfW?=
 =?us-ascii?Q?TTp+FMHTtVVnPEg2w3BcrSEQp5vdR6RZMr9oarrwr9sVqTd+Bm7hSBIunxl5?=
 =?us-ascii?Q?58QMT+4n0/zaY4fGANqdoEuLAYKVHZ6q5mxruu0DxUQz/3Gzm1p7Bm+bskip?=
 =?us-ascii?Q?oI05hwc2GCsEwMLAW7/0B4LQVsSsc+6Cc+LRtUvWq/ck+sFWuh99NGMu5o3e?=
 =?us-ascii?Q?iftDQn6AEyoX0bzOBahJG+gAe12pelAffoUTFayxhGtUPbkkjmba/nKf4f2T?=
 =?us-ascii?Q?MsFPGOoRys1KHNCaX0KBzVGnrLGP4BEyeMdCjFEGHZnaEJ2M21bAmFTk6TF/?=
 =?us-ascii?Q?dQTJdbUFeN1c0BvBhtJRzlTEOfLQzFBX94zDg2fJ6dTFZiu5pL9OPEGLv/Aq?=
 =?us-ascii?Q?W2LmYnJTM10LG5+bd0r1rwKJtVsv9wbpE8+xn6t7O78cVGZUOjuEQYpJkgyA?=
 =?us-ascii?Q?3XXigxQtuezRGV//BMdxepaY7tpho2ewLePXDYYDB/NEJ/yyapGVTtx/ETEE?=
 =?us-ascii?Q?eeVS2HBHwZOOjF3n11RBYcGhStDdkwcSzQEojDxIHVCRDoVM6qmOUJUK7B4N?=
 =?us-ascii?Q?iHYklX7etpJVabwAKgkmtgjdusKX6JH32sti4U5TbLK9K5wU63yEi3mZlkue?=
 =?us-ascii?Q?1oNlwzgD7QkhvbckD8F2ayleRCSSRI6K1YnwZ29WKKBXpbuijxPSrBcllkaQ?=
 =?us-ascii?Q?6G5if2am1hgaC0yLOECqUN6VgjrheawoxbzRvSaAGVsx46ZHLcuPoHHuRQ?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PCW684PiVcblFdXQovrPgb+OeXEsW6hWMk6DzbN4q5ZyqgrhO/SfwqF33Pvm?=
 =?us-ascii?Q?uXQVFKoYoiRQ8ATL7Ylk1E/QP8iKTyx7yHOcDWjdSyDamXn9cXom3FfG1qax?=
 =?us-ascii?Q?sIJ5ioHWaX1xEsxAPloN7jrts+MHHU29otMHhN/6SVGcVKGdIerMqd1Gnqmh?=
 =?us-ascii?Q?bl0jnBJGuz2MYpk24rl7pCocBHOiexfcYEAdY7pMH6C5X59wlGEtscQARJKH?=
 =?us-ascii?Q?3aEFN+XJvr2UVtS5jtXPEv3hlq4kmzGvD13l8CSgOhP7lms1K9itCZPocSWm?=
 =?us-ascii?Q?I6khqkvAGl6OHdqFQXYM+aEwG4iiyGNTRBJQ9gy/cgiqoB8Z5rO6PcCRM4c6?=
 =?us-ascii?Q?aApu0BpB9JAur73gz2Uusm28FWyN9gEBn+4AO1p/FkINUC8jOtk/K1rOIpU3?=
 =?us-ascii?Q?yTt5pb772VP4ya6xDYxGzMVI6hGG0m4dt4WTG18VgJaccwiMccKpp7SNGWBu?=
 =?us-ascii?Q?x0s+3SU+MyfWMBYIGaYu8ROzJCdayifu5kvO1J8nsY6ETFP6l0PsyIkAWPtH?=
 =?us-ascii?Q?44h82XuciowFS5i99Y/GjDmZK7V8HX/HCB9S3zMqdkKXdMcgSpzDa0jleVVs?=
 =?us-ascii?Q?OjBx/lwcEUMaoXmbFQVrgg1VM4pT1kGmL99xcEKd2Uk5DUQukp3vwvR0MXxK?=
 =?us-ascii?Q?b4s4lpTPZ4bzGLVr8sDguwsFaKfSauCVKYaTCLIkZhcIWR4yhRupfF/w8RHe?=
 =?us-ascii?Q?Yl7nSo09HM+MhZE5jPPfFcyHgXf5NoaSyKOE9w0SFReMuWkZ2GeX+wWaRhf0?=
 =?us-ascii?Q?1znSC2bgqcCEizmoRBOOsEGBLRpx4WhFlDWWt0UHVIswwTcJk0AM+JWgUVoo?=
 =?us-ascii?Q?YlLjj+8wds9SVtE/ei7m7qn7ijvoRWc9GLom4twAZDppVz2xWWWrpUbAz3ag?=
 =?us-ascii?Q?QJeAQENG3JDHhBOZkhF1D13+MVnPNK0HKB4/l4iZrW5QBNhksaj/7V4hrNRe?=
 =?us-ascii?Q?3BNTo4qLAr1eIUN6/SG96qrqV2gfxDEJetJLwHWTklTQsCP8QoceYt84UrdF?=
 =?us-ascii?Q?ASko6mpQ/R3+hz133NcvWWQsUhblW4dAcaQyRubbBFOoe3/Fhjw3KVnF2lFX?=
 =?us-ascii?Q?FmIVpUtzlwy2TS/oReyU7sQUpC+U86VO344z7K+YyHFPRmfLAP+qXEXBimgS?=
 =?us-ascii?Q?s8EuoQp9rr+2bD9geyGWo3ytZCVtSKwpWjF+KCd4ZMRs7lHY6UqGDJAhBSEb?=
 =?us-ascii?Q?iZ/rVPcjJ8hxM4pAUuTAGuz6I8iVoeFsEj7A5e/tbH+SM2FXdXk6SqO+47yj?=
 =?us-ascii?Q?b4/SJ+0CXDLHIh6TqiEsAqwuNyV+zwpz6U63QxJ9dR+vaEESgdAeSaCjSUxv?=
 =?us-ascii?Q?1dW1ERu25KQAfmHaF+/jxEYrXa1/HtK7VcZzkvU9eqlyrq9ORcWlWgMB9+6T?=
 =?us-ascii?Q?Xm1ix6MDdXC4O6Csj+PzbBbXe3K+m3cp8ard+FPZaPCzojPruEwutuqq8QZ8?=
 =?us-ascii?Q?TVqU+3hn9e2CzOL1l0hVlOF+DZLJoKg8vXCAzkoyJ71UUTvjPprbLNbl+1yM?=
 =?us-ascii?Q?ZRJjHvESBIhihPymsNovykIn7cEgJsGpYH0IKJGA2/Q8pGJstoQs9+OoQcYc?=
 =?us-ascii?Q?8C4VH0H/RRt8R2ikQMHgSpoRAHLW5tMlKi5uWYtM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b56b752-2574-4adc-2e5e-08de120e4917
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 08:29:29.8250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VW+OoHH7VzsmibS1UIfqDS352bI1JnJhbkxgx2Vqt6344WBrVYxxgwIsHmrh+UXN4KVqeSeBKk2P/GWhjn5ahiObTkd/KgL0PtI8d3lerm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5340

> Subject: Re: [PATCH v5 3/3] irqchip: aspeed: add compatible strings for
> ast2700-intc0-ic and ast2700-intc1-ic
>=20
> On Wed, Oct 22 2025 at 14:55, Ryan Chen wrote:
>=20
> The subject prefix is: irqchip/aspeed-intc:
>=20
> It's documented how to make them:
>=20
>=20
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-=
su
> bject

Thanks, will fix.
>=20
> > The AST2700 SoC defines two parent interrupt controller blocks
> > (INTC0 and INTC1), each containing multiple interrupt-controller child
> > instances ("*-intc-ic"). The existing irqchip driver
> > (irq-aspeed-intc.c) currently only registers a single compatible
> > string: "aspeed,ast2700-intc-ic"
> >
> > To support device trees that describe the INTC0 and INTC1 hierarchy
> > more precisely, this patch adds two additional
>=20
> s/this patch adds/add/
will fix.
>=20
> git grep 'This patch' Documentation/process/
>=20
will fix.

> > compatible strings:
> >  - "aspeed,ast2700-intc0-ic"
> >  - "aspeed,ast2700-intc1-ic"
> >
> > Both map to the same initialization function
> > `aspeed_intc_ic_of_init()`.
>=20
> The backticks are pointless. Just write aspeed...init()

will fix.

Thanks a lot.
>=20
> Thanks,
>=20
>         tglx

