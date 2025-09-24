Return-Path: <linux-kernel+bounces-830424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDB0B99A08
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C809E4A640D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC5A2FE072;
	Wed, 24 Sep 2025 11:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F0bnpBlH"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA0B2DE6FC;
	Wed, 24 Sep 2025 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714246; cv=fail; b=R1JxQd7OmoGiuP/5DGB9s2ZWQJUx92O3FAXfT6iT4itl0ndm6DE9ljAn9Wq0U1mH8BloDn6+XJJi5QTb9TfHk8dKbIgpKUoOzUv6owBHqqzR+UHnMu+pDOYi4nNACXyMlgygLIm3SE2h120wRWnpMRA1ho97F5G6ikEqHFdYucs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714246; c=relaxed/simple;
	bh=aqSniAT3oeH51va3llffGg69Ue6TAXpGSMerqbsJR3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D09PSRgF3GSRWEFhpLH4iPoeLOZeyk7D3ZzmET3goRvgdf/ulPZMQvMup8mqHGoQcIU0m+UejVeXXGovvdllYLeZJZrNMYSMh8Div9a8pyBG+lJveH/lv9zjg5JZFSs9K2phu+jx0fYf4My2kjpTeF3mtMr94zNVzBx2gplqgv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F0bnpBlH; arc=fail smtp.client-ip=52.101.69.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4OymnpqedUDx71DuN8z+Y5Ikdaoh2NcGSFsGdMlZxz9pp4UL4/9eg4pxlRy6QV23X7XRMFQEVG0zOdUHUK8pALhdAw4xLPo8SNMt2dMJFnsf8yniGrZVZ8exfWCJSF8hvswJOnM4y0butFv+LSo6uU3EitgGWarRMat5UQiZIdozSevnRyeNS+iGbPYvEV7LhFiwq0Cv1XqgIyZUDjfuT2pD9m0rBJHJBdZXMyLZ5bTDUJW2AuuMNLWuWcqxKj07bTNxgkbBlmhVMzF9i+H/sSE4/zljr+ThS87clbv76WICo1pJHsY1KO22rfGTKyYBQDbFeHKWURFzkYLj215YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nNAkP+cgLjPY4uArU/9N0urthk+bE7X9hwMfi1ZfXk=;
 b=hScjQVwkJkSFqEzVZLfv9gPcimU+mwxNKD4qMqhAupSTjcj83aC6RD2KFo++Chx1myar1jh6JNxAGgHhvBhnsl2rjtR+4UaQgY8LoUnBj8gSJ7w2N+yP0AObljhfWeUas0Agc5Y4Q26CF8agP1rJmUsyXPhiNofvzXoyOEuxSE3JW/yr9vH0h2msWp+PE/orYVwABiigj6T++PiRzCnIjNkh3FaWg+GVMtyp4TovlVCRtFlfs063v/SedEy3hz0w2VDZos+rbTzYm3tP6rsa+36bEYx7U//dTskIwU3VSo1OlZfZgiF49kMnNYuUObXyhkEL302/TZjar27EPAPW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nNAkP+cgLjPY4uArU/9N0urthk+bE7X9hwMfi1ZfXk=;
 b=F0bnpBlHR9e56l0idxhxT7rNZ+ZFdoJ0WvBo4zVr+krKf1uy+bce40XgfPyikDmc3yRoRKB7E/NPg4sDRIs1qo7wQA156icTJbbIo6BRDsuvArWFabUzfOFQiZ4y8wL5w2tiFCyDVLSS6x3uRgG/dwg/cTfALlQN2kE1+FgYqxrUMHCpPBgiMdZUf9BKIn0shHQVXfxh0nwEcXwztkvf6u+xE99lt/p6DUgP8zeT85OftKFL3kle6L/FXL3fUtzH5VjCYnpk0VGaX6234Rdg8nWovYJwAlYQh6EgdUE2gDeMgrZULEkZLsxLCs2dVGGS2vHgPMpgGXkDrsTXL5tYwg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB11604.eurprd04.prod.outlook.com (2603:10a6:800:300::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 11:43:56 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 11:43:56 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sebin Francis <sebin.francis@ti.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, Marco
 Felsch <m.felsch@pengutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brian
 Masney <bmasney@redhat.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Geert Uytterhoeven
	<geert@linux-m68k.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for NXP i.MX95
Thread-Topic: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for NXP i.MX95
Thread-Index: AQHcJhsCzmRSrEp0oEyqjCzMN4tqC7SgpByAgAAO97CAAWsJAIAAIANw
Date: Wed, 24 Sep 2025 11:43:56 +0000
Message-ID:
 <PAXPR04MB84590D5AAAB56ED7E1CBDE05881CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
 <20250915-clk-ssc-version1-v4-5-5a2cee2f0351@nxp.com>
 <5f508f1d-2d08-4687-86cd-d1944caa0a49@ti.com>
 <PAXPR04MB8459CE9F22CD56A9BFDB5E78881DA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <082735e7-956b-4574-952e-06ba69db41f1@ti.com>
In-Reply-To: <082735e7-956b-4574-952e-06ba69db41f1@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB11604:EE_
x-ms-office365-filtering-correlation-id: ce11d940-158f-4b16-0ca5-08ddfb5fa528
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|19092799006|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5COekL2XHPy2I9T1wcHqN2DJEO71OzJBOr98NKMAwfaUpmHjVK64eJxCxSu7?=
 =?us-ascii?Q?RbRlPcAeRRavzMMSwAC13ZRi+rbUQdvALELF0joFiquii7kcZjRTd4iUxQP1?=
 =?us-ascii?Q?eFTdFq4CKXHT87YJIc41X/4N8roFRIgw7yXLUIbEqOphPZIk1IwtiPikXWxS?=
 =?us-ascii?Q?3etP7Jj90fKmduv89iQEO+/vQkXYec4U4d2ZakOg70BdTT942KhVjd75LiCt?=
 =?us-ascii?Q?6ok1PLEGJuAAO4b0AX106D2cA08GOkuJw6cIKMZWMeiU1Am+nmE/vYERNQKO?=
 =?us-ascii?Q?o5fhuuHIT0gLJem7eypYbxaT1vAGDvdBHpi67PU7WC7aOqVbmMRtcgCVKVl7?=
 =?us-ascii?Q?AvFOdQEwHYYbtYItcIF+HihYo2mkJ4BtFHnt6/hLGfkuq1MNDx/W0v7QnAgx?=
 =?us-ascii?Q?TMBv6NrqfPMbQV37NlT15XCcNcThjUyuXmwYTezxOl7QrQyuPmqL0AgHN9AU?=
 =?us-ascii?Q?OoLv95UXaX534nb8NqOdnQQw9jUuNuZfaPTip6kcLPjreLWrPYNEfZ6wT64Q?=
 =?us-ascii?Q?89C9/CJjHzjaMiYAcvabWvCrHMseCdYGU4SLFMGCdk7h1XOsovZEMxyk3xdD?=
 =?us-ascii?Q?ALt3yoTTkBvLjEaW9v72lHnfdfmbxg4h5byYeOQYSWcTxy6fn9WBoLiys9QM?=
 =?us-ascii?Q?+6xGQTKqrSEgPQWcnRIYj6pUKXTueHwnNpN8IfPcpl6sOqBOjMeTE5fZVDVF?=
 =?us-ascii?Q?Q9ts99FnGaUpEjQ4dwjKvw/KGZJPRksWrFbxa0QPlMg8YwBKMQRj6lplZjwG?=
 =?us-ascii?Q?+SHT1gc1Q4uvIo5l8Z1Anzn9EGdLy7OcQeFL9ZCfovks3t7tiRLrBiby6FT1?=
 =?us-ascii?Q?Hd1Viw/OcZqSmwy8hfK2+/v8zs25eNiSslaWji8zuVcV5zWU5v6JBYzqxmrY?=
 =?us-ascii?Q?5EQVFvvlKD9wEy523LE8n8ZCfwn/dMzpR66/tJXoKaz3Dr3bFV8HLs2IEKir?=
 =?us-ascii?Q?v95VhBpYJVXkUZOhCvowPOnpyes/6n48YjAU8ezfwWwSmla6pEYuaLonJ3Kw?=
 =?us-ascii?Q?R1W6YgC/2vcfP8uzUw304Tz/1tyi5cfopb1bS+a9Q02hG+t5vLY0xesujkDo?=
 =?us-ascii?Q?ae7pUj6dCndqpx+yjCis+g3uYV0W5iChWlGu/1FTzH9AP/5cqxCSO49hmJPc?=
 =?us-ascii?Q?VW39gr3ZoC4Mse6PyOrwL6AWCqSSwqhFWLuT9/cNDnpnlFOujrjafeUpkTqB?=
 =?us-ascii?Q?cL/IlGEBy8JCcBZ2mll0Zygd2fj0swg2zTykBsLQNrugG+KNEFolN3vVJM4e?=
 =?us-ascii?Q?hJp+VulGZFTUX7Sj0aR7wgch6TN8dJ1rpAbHW8FViPIii511d8R4vCpV8LYD?=
 =?us-ascii?Q?wS9bY5jf61ZKA/N/JdXYxbANw+spgiZyGmNGQB6jCmOm9ko5Wr3N4mNpWuA+?=
 =?us-ascii?Q?triKNn1H6/kkHrI+1AKCnzXm/D3pGgY4LQzMd9QyAXeZ8wDJ/K00QNmbgNW+?=
 =?us-ascii?Q?9BItJzG0+/n56TQB3Fc5v/t4afhR215T?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o+BpVvhIC6Fjz5k3MflTa2yi7IPjPE8Z+Bbr9Vd4yXM47anPf4fpwHHxt97h?=
 =?us-ascii?Q?VBAVqY+cqETIMaF6gxxxNdc8ZVUYMmS80CzFyv8/nGIE4o4m5a5eQi8GXaYo?=
 =?us-ascii?Q?lofp7by+V93jg2IRzLJjIRHG/XLOZ7n76KUINpWykCEnHOs3C+QPVZsgzG0b?=
 =?us-ascii?Q?e4+bG7iCWWcWWGGh64Wblu4PJ+DGXGb0Rnd4avH4HoM6KkXahJ+58HPvXZCG?=
 =?us-ascii?Q?yg/kPvD7RW9siPrZ/namVIec9G2+Mpciv5cnmscpiNRNagRm16DNn59Iw4T7?=
 =?us-ascii?Q?rnSprcTaa0ED/bHuykI91soV6ga+VYZL6RRBip8w1aEON7qUXGonVBpGBoRk?=
 =?us-ascii?Q?lPEIORYPnIrjcJWgZfo7jv6untg9sTmzKDXM0sgCtVs3xFRbUpNfWYjJl9bA?=
 =?us-ascii?Q?LOeMGFYbFXPioRuxUgjRI180YauyFkcbD73/CMuqXCHrt+aKHRQL1rTlYeno?=
 =?us-ascii?Q?/HlA8+0AHdUs+NPRc8dfSI7k/ltfJovFVbxdizkc3sQDhYznzUpn/uQXkkOi?=
 =?us-ascii?Q?KxaVdDE0REoogi/s53NIwJsyq5VRVBtIwjhyHvTuMy++aKqHkkAQ7fJnPibx?=
 =?us-ascii?Q?2RSwYF2bUlEmiGrRrx9h0PGbU9wVjnaFBVCqohDJ41OpOLl1PGM1HM1jXZZM?=
 =?us-ascii?Q?1BpyWAc/d3PcHqmBOIrhM8rPDiGc5vDGCsU31lqFlONF/f0vBk3IzcjmmtSz?=
 =?us-ascii?Q?f0200AS5RD/jNTo8lGlBXhSFiJ+7Meg9CDhTWcQc1KoDh8z4LTTmZe8CnnDN?=
 =?us-ascii?Q?G7MJjdQvwJR4HXijQC4yE/MWpHSAQOqz1Ag8Y5yS4ffH5HMz4bOvPidn8+Yh?=
 =?us-ascii?Q?kkFRAsbgk+yv61B7HGfIh3TNpexn4xkNuFHADXA6jOlUp1981Ng8zX+UV64D?=
 =?us-ascii?Q?/ydeERjK/hX+bOof9qkuynFghlT5qap4LZIkyHViQQ+XpfvTze1ReISNaAYI?=
 =?us-ascii?Q?Hql1vU/zyDRymkf1zwUCKcB/SQXMwFAADA+n+4i5DKdWaQhfGTVab09VyrgV?=
 =?us-ascii?Q?KVIHnZX2gcpoUWMHktpBU+jZBWXoab1pRma8X+sybRg8AAujgLT4AAynns2q?=
 =?us-ascii?Q?aCmfgpGfP2LDdojHMf4RVSc9O5lyyXt3bNFum5FZwubyq0UMkLlDRMZB7k7G?=
 =?us-ascii?Q?v407Oq1W39P3v3szQ31+jtynjaqXJmvqId0lmVpaskHt/soJd814M0px+GM7?=
 =?us-ascii?Q?183uRmGnLriHOijpctITO7fXn6a63boKL4IGnSt7RMheG2uMtrJMd0vQLbg7?=
 =?us-ascii?Q?AqfkcirLXifoZnvKerwFlJQFJ2DUROl/1g2AYyyhobIjiui7XwbOWLVPRaph?=
 =?us-ascii?Q?Dv7dXaHSwymaLVneioPvtHPNxksQZ0LXXy59MzVwVzSoFiwj/V1vHHxpWgIl?=
 =?us-ascii?Q?kw6XLLl1Jffn7rSO3gphNT1pCbyBKFJInWPNXGBIAZjmWAtJux9Wev7IjCLi?=
 =?us-ascii?Q?Z/m+bfFtN83tiRklYf7+k6uJpYCcRnKLBC3XkfqK12yhbBzfLw7cmbMxJzIs?=
 =?us-ascii?Q?xPcuQaXltNVtYTaEzPx6RPAQZnXIms2+WnmWNoqyHHDMNRB94PyUc4P+FIDA?=
 =?us-ascii?Q?nj3YwEOj5YB0nMtaxcg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ce11d940-158f-4b16-0ca5-08ddfb5fa528
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 11:43:56.7755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1aKeDaOj6kq147VS+SvYE50kq+h4NFp+giib9QaDntN0p+UcrLvNnRS4wafULSI2nnW1PFDL3za5wC6i2ccSHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11604

> Subject: Re: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for
> NXP i.MX95
...
> >>>        SCMI_CLOCK_CFG_OEM_START =3D 0x80,
> >>> +     SCMI_CLOCK_CFG_IMX_SSC =3D 0x80,
> >>
> >> TI is also planning to implement the same in our upcoming platform.
> >> so can we use a generic ID instead of vender specfic message ID?
> >
> > I tried to push to new generic ID [1] in half a year ago, but in the
> > end ARM decided not to add generic ID for spread spectrum support.
> >
> > To i.MX, it is too late to use a generic ID and waiting spec, i.MX
> > firmware has been public for quite some time and passed several
> external releases.
> > So I need to use what our firmware adds and spec allows: vendor
> > extension.
>=20
> Thanks for the quick response,
> Since this implementation is specific to i.MX, can you move this to a
> vendor specific file, so that it will not break i.MX's firmware and TI ca=
n
> implement SSC in TI specific file.

i.MX has encountered issue with pinctrl-scmi.c and pinctrl-imx-scmi.c
both supports SCMI PINCTRL. Current linux scmi does not support
both drivers built in kernel image, because scmi devlink issue.

Sudeep said he would address the devlink issue in 6.19 cycle.

Given the current situation, I'm hesitant to introduce a new driver
saying clk-imx-scmi.c.

What I'm unclear about is whether moving to a vendor-specific file
implies creating a new driver (i.e., clk-imx-scmi.c), or if it could be
handled via a callback or another mechanism. Could you help
clarify the intended direction?

Sudeep, Cristian

Would you please jump in and say something?

Thanks,
Peng.

>=20
> >
> > [1]
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> lore
> > .kernel.org%2Farm-
> scmi%2FZ8iKErarE0lHWxEy%40pluto%2F&data=3D05%7C02%7Cpe
> >
> ng.fan%40nxp.com%7C4bd4c6b93ff146fbfc4c08ddfb4c5ab5%7C686ea
> 1d3bc2b4c6f
> >
> a92cd99c5c301635%7C0%7C0%7C638943027585856649%7CUnknow
> n%7CTWFpbGZsb3d8
> >
> eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiI
> sIkFOIjoiTW
> >
> FpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DzEREeXuiaC5wWS
> C%2FUAIe6wfiTf
> > MG5AEY5vZ7D4OEIGI%3D&reserved=3D0
> >
> > Regards,
> > Peng.
>=20
> Thanks
> Sebin

