Return-Path: <linux-kernel+bounces-811683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FD0B52C8A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650B9A84B73
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB2D2E765E;
	Thu, 11 Sep 2025 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="XvGiajxt"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023117.outbound.protection.outlook.com [40.107.44.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD94C19C546;
	Thu, 11 Sep 2025 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581343; cv=fail; b=AISD7BO3Hu+56dqNDdmut8++0BC35SjpGCvsoBiu6XZKW9P4XXuUpJYJAn7wFXvi9ShvmWue9hyDndICahrlhOzIFycfGzulnUdLQIhg97YjaoKHhlBH+dFhTfJ478xvA+t4vNsRn4qTu5psFNV+H7flultD1x4mqHMeS3SB4aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581343; c=relaxed/simple;
	bh=ANjJDZFUrYrjMQ99aT8y7qY/jgXxo9cP2uZRKmZdNEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bJy1ICXT+KMoBUDyZsSoVpHNbfWrGWXuH5V2SLv+N5QbCk6bC51kvOYjlxHlL03snmD4UIOcgWgUWPPauiSwPCeUgjoRH89YO246q4HJht1JlgW1tjDEQnueO+9tA8ABMtRJeU1B+HQNMQTzePCjGLXYv3MH8iXNETlxmJRT7Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=XvGiajxt; arc=fail smtp.client-ip=40.107.44.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0a0MzClhk8Zfww1u1JpGg2HkCpaeTPyg9HXFKVG/smxTki+5/D8Zybx58jV8c3uXlYibFm616ZBs6w0vdNXFrqxfoaR+NrVxeFp/+9jkx0irhj8lQox1LNOJ3NeYejdDkmX7c3wSKwlMzql3W3qgmMdSlWKb+JXwKOsw4QDgKG+urHXWtwzMGzwEWAvO2g1NuvbLwnCklCb0QNRVUb1YTDiN63cx72KnXE3s9V0PpCWuICOtk0oeXOu9Ou1NepgQjHq/UhvxxeYTfQGQxPC7/nUpZHhwyy2vjyDNd+lYMkDEi8a6ekMY1ck1yD7IZrZMpXhaxxbjxKA7J3mCYOFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTr2JqWEJ6Y0DcSbqbZpElLP9NrSbesab6sCBQFIdzw=;
 b=knEzO0v+tuBK+NGapynvazy8kBMrVjOsFd4jhWTogOmLMAKFEToRY33DqCs1rS4UU7IqnnhomNVGMxtPWPdgMjoXfTam3hs0WAZEFATt8TaUZJ/LL7EaYW82MEHlpVqolz2tt8qQLE81BFrAANnd2uU2Mqx1kIR/I4CNSYq0U5KgJVF3tkUGSczkOPDkpfJAaJvXa6M4HoqD+sxtkcHP2tw/W8QLRqnNyV/nrFInENgA8+MXqrwQ4wCBTF1DBBzpn7hvRrwLbzCv87OTPDGQvcLF/W/TatDCAp6fdq4sW8P04w/RN9eZsamTKljkul2XPEaoSxkJb+ALvH2KXPPEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTr2JqWEJ6Y0DcSbqbZpElLP9NrSbesab6sCBQFIdzw=;
 b=XvGiajxt4MjHDgP9PGWsmRRjqdQnjauf9jQbGct5HSSt/48DKs/ra/w8EhZG5lGvYxyZ/2F6Nce5hRr16Rv5JPqUvtEL4VacZON83pUoaEz7TbY/FcWlDypg6GSizfULOJ6gxVHfDCR5En9lxkKn/2CvNFKMQX2RCByln7HgBvQ7bHIeOHOU3AazvcNdAydljZ3JveVcpJXQlwUJwClNSEZRXWlb/u+Giyv8UgKPX5yOs5NdAEq7ULRL3CIX4xoMaxaOP45NMQQLbH8HYcGSy7TNcje0GjXhUDtJYdqdyldeV+p7tMUX+MFAwwy5BJWxE0+GvSGuac3gsNJsKM0KGA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by OSQPR06MB7109.apcprd06.prod.outlook.com (2603:1096:604:2a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 09:02:15 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 09:02:15 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Brian Masney <bmasney@redhat.com>
CC: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Mo Elbadry <elbadrym@google.com>, Rom
 Lemarchand <romlem@google.com>, William Kennington <wak@google.com>, Yuxiao
 Zhang <yuxiaozhang@google.com>, "wthai@nvidia.com" <wthai@nvidia.com>,
	"leohu@nvidia.com" <leohu@nvidia.com>, "dkodihalli@nvidia.com"
	<dkodihalli@nvidia.com>, "spuranik@nvidia.com" <spuranik@nvidia.com>
Subject: RE: [PATCH v12 3/3] clk: aspeed: add AST2700 clock driver
Thread-Topic: [PATCH v12 3/3] clk: aspeed: add AST2700 clock driver
Thread-Index: AQHb78lA+IAukcGqZkm+EFuCwOI247SM2tMAgAE6szA=
Date: Thu, 11 Sep 2025 09:02:15 +0000
Message-ID:
 <OS8PR06MB7541F0274104DB687F6BDE51F209A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250708052909.4145983-1-ryan_chen@aspeedtech.com>
 <20250708052909.4145983-4-ryan_chen@aspeedtech.com> <aMGHvHf6BPrJD1pC@x1>
In-Reply-To: <aMGHvHf6BPrJD1pC@x1>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|OSQPR06MB7109:EE_
x-ms-office365-filtering-correlation-id: b1efd926-094a-4e3a-34f7-08ddf111e73b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hY9hfZ5kIf3PFdRn/aLOjoACYjaE+C1mMc8Sh5hoqNC1XkvtwG+cIzlpIBFl?=
 =?us-ascii?Q?fAR7Jc9QbrdfioeJ5lS4UkMKhAfBU1Wie0OnCs/GhTGkhQbeUTk3LBMYcja2?=
 =?us-ascii?Q?dfEKzdrPIOZlKf2mEft9szXlO65ne2aofUv+x3DNV9Y5YkC9VEHaXNM2ape3?=
 =?us-ascii?Q?6RqRgJ929uuhFueKSr968iZoptgxMXEsTs2qXLGEiLK0QXmxJkTtGIkvlnRM?=
 =?us-ascii?Q?bcFAq7wkjDyf+/FvdJW+AJfjqFYTEyOaOKSboKU3wJQCjSJt+zW/wo++/Yex?=
 =?us-ascii?Q?O0bskmMA34xVtHnIVh5N1DQHYTalla2Tc/Lt7fDDYJTXQRo1gklfdgFH0XZR?=
 =?us-ascii?Q?vMiJI+7SQ901T1kUMUj8Djn78FGhRFK1y23oFRpXiJpxTIVbMQixRYTR/Xty?=
 =?us-ascii?Q?5cJCYpN5UplwFFlexHZuk2CuzYqzFICXHpcUviEIlVoOwGtZcFXaKExGOXvt?=
 =?us-ascii?Q?1+Mqxtov/5Q8LR/vE1QciClYqMjthIsiw1uDSJ6f3QSDJJ40ajHUomkMbFBu?=
 =?us-ascii?Q?sTikHwKwyxi6yyT4OQyO2TeGuESEg4pEW50sqab5YtubwyBXjIGBqCjq00Ph?=
 =?us-ascii?Q?yqqYuyrN8PbiCdEtVRFysgflYvVWVxyoYCXtgxyWciHIw8eDbSbtenlP8lLl?=
 =?us-ascii?Q?neoZN0GB25a3FKdjPjizm002ph009GFXm5Goo8Zzz2mzkAiZWARQL6q8Vbtl?=
 =?us-ascii?Q?soSAdLlag0uG1/uBeEdUakJlCdZC6Nix88Q4GXN2MUVpEJ19n3nwk2317uia?=
 =?us-ascii?Q?vEzt7sEd6DTHgIrjQpVXoHt21VF2Xg7kX6ZniY2xRagNeoIPL0aO5NXHRTOs?=
 =?us-ascii?Q?xgMKm2Rk9/Z4H2X8CSZdXzmiWzxOfKBr2iztUO7aQjiT8A7aBtB8busTGsYh?=
 =?us-ascii?Q?K0p4q3QUYf7sdCC8P0UthDmzeog59zm5gNEz52uFO2qdM0tWRAJkBki3B2JJ?=
 =?us-ascii?Q?DaGBRtIH8mY++sBKyU2Mqesjg8vx5TJD0gEDQzFQDs8MtHoUOGusDId0zrN3?=
 =?us-ascii?Q?bl6+0i53gj5bHUgGJoKOOO1sBv/z/4Hu9ewrmFKx/CZNGsjiWAC5WC6iIHCG?=
 =?us-ascii?Q?vtWMiF7m3F00UwBrNAi6UEPrbO/tEwVY8Y+ymtR1gBAk+tWl1BnEXckgXMX/?=
 =?us-ascii?Q?0WlW21K/sNvDpBKIs4tRPsYpPHxrLsCVcTJLMNNu8xQanCN7txy+tibJK1jC?=
 =?us-ascii?Q?O85EgpqFHwvnXiyWxQc49TKXuBzlR1Y2Qx9rNUMcMdtEMWUzKNRnx12uxTMT?=
 =?us-ascii?Q?5219rUtWZSIQSz86dPXIXRXJ60Qgq4AVYJeWRGtnCETtIVZj73PgqiEP3emx?=
 =?us-ascii?Q?o1WHhZhbMKRYRBRqZaJjpAF2HiXJrJdh+E3rYlSjhPmeqRQLSZJje6K/8fCf?=
 =?us-ascii?Q?UuzHA5+74/WkGL1FZDZclWtJ631FjPuXjHkeqld4NeISSArwys8euEClrAzo?=
 =?us-ascii?Q?USMfnuARtk5uyxUHpJQ0u1B9BlUcei7oFu4pYEUNrfEa89XPQLx+1o4SKAFq?=
 =?us-ascii?Q?t68YTrH96EM5Hso=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?70y152IvK81AmCLldqEBZOza1cv62tRdp+kutw92OFnWpCWuOnIpKmFRylm9?=
 =?us-ascii?Q?HwTzFML1Co2Qp6YQ0d/vNlOm95ddOS8dfcucIPAedfmN+4191f73fk+LQH+3?=
 =?us-ascii?Q?SjVx2V483by7bknarGVCL+Y/3MhP+alpXsjbatboKuxGjhGcsrb/YWiTdjEW?=
 =?us-ascii?Q?ARU4a5JPyss9HfQWzopkoNCyE8q9ub0llUrYr6SqB8hyLiQLcxWA+Nc204a/?=
 =?us-ascii?Q?uoCLJ3Mj2FSgfeyzaukuCXfUInS3oSRbyXxG/BOiwI6ABri53Bgoc34M4pbb?=
 =?us-ascii?Q?pQEdlg+5FlpBTDDL2sZaM//QIZG7U3UL3hrb/3drAI1u69eRnJKudG+6VEo2?=
 =?us-ascii?Q?q2/v9dz62cWqsSyKx6AbU1+XyPHkhpHTIYJhQabxJ/bV2tlBhZ2w9IQq7083?=
 =?us-ascii?Q?UqEL+nWMEXuwgMMueApXM4i78cz57TCfn1xBeQz1Mi2goe5Y5r4CDEaJCuA7?=
 =?us-ascii?Q?QX9opBsHDgvpew64OHWBwEchgEUYRjEJkwHjzs25lgR42hnBBDi1UMV/8ypY?=
 =?us-ascii?Q?qNCkK+i2m/XV8Jm1Ya3TlkrP1eOZZ03sJi1Yw3guhHVCGSS+etjAcEm4EMFs?=
 =?us-ascii?Q?wbGixLQspprM+ybk5mcMugDSxvClTWaUMM+JVEDSz9LgacKvc5A5dK2Km8c6?=
 =?us-ascii?Q?Af3f9kUTypAIVsEQkbPYY3kAo5Te05bZ4sSZulkebsdLl8MVlI5L2XoqqL7J?=
 =?us-ascii?Q?4fCdxaceBBTCEm/G/seK9JqcerffK21ZcW0PvWo5BSxf6509x10WeMJEDt9E?=
 =?us-ascii?Q?vOTPCgTbSM+BF7nNZP91SBF74HZPR6901FLgGFN71z9dD8QMQOazXZlREjJD?=
 =?us-ascii?Q?oJD+Tj3WlxYsxkP9xJDFklCTtjuuzEhIS0JV84aTFNP1N5ZHvPFbPJAWGkjg?=
 =?us-ascii?Q?86CCAmysK/Uhj4mA0VQck/a+TC+yjfkIt4HsVITilcqeHMpjfN1HxHh2ojde?=
 =?us-ascii?Q?S3ZQKZKewtG8lprs1JI+BsAD0RBdZeF9u+coBRtjraEVOvB9cCj0yCHBAap/?=
 =?us-ascii?Q?HsBHnbqNuyjNFEtgBbkvCQ0Gcu33vNeGU1Yw94wPRrAbGTzp4DYAd5C438Lt?=
 =?us-ascii?Q?V+8uO+KZOrJysv+KKcCu6bkC/zu/k0sa4bir1Xv5ZJwWMc1eM03UtFw29eHR?=
 =?us-ascii?Q?NTGykbIwye75lmRh/svZa+mD06LEPkSToiWlQWfzfbAe4FkwqLFps7LNygwM?=
 =?us-ascii?Q?APFdZ1Kvs82PwupF9ao946F4Q4smm3iZacLjypjl+DOM2JTDZUUvnt/NzhjY?=
 =?us-ascii?Q?UjKkGZqMsfKaRw30yhEED5RUA/eTJMoAHxm0L9OTpvuEMKz0/W3O9VG+0tfs?=
 =?us-ascii?Q?LmT/3BtNKW0NZLDCP7SeLQ0uySy+pEawou4Ide4EbGc7Fvn0rAfvEHsdtOQc?=
 =?us-ascii?Q?RQR7ssDw2lIqio9PVP5NEt3r309XIxutjpkSI0mzIKZoTva9OZkjEUgAdtPz?=
 =?us-ascii?Q?C/kzreWjh5Wgbqn5QAIx0TwvqASYB21JsQAS1mQFNi2x/QxepUo89ZfF2W93?=
 =?us-ascii?Q?W0CbBl0MqdwPZwVUkE3CmlSAzqFKC7ua3pnUT3X5vLkittpLZcJcRvBiQKVT?=
 =?us-ascii?Q?ln1U7JT22rKeBf1tVTxuCM/eQSiEWZeH4pEz7bDx?=
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
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1efd926-094a-4e3a-34f7-08ddf111e73b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 09:02:15.2084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LaYY9h3BNhZGOTwivGE0/KQtJ5G2u4SMqABSjqMLDbE0tQqcRWb9T5vQWxU8p5bhD0DYyrGPgjqf+NctVTqFHmNVfOBQ9s3CcGh09jmwr2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7109

Hello Brian,
	Thanks a lot for review.

> Subject: Re: [PATCH v12 3/3] clk: aspeed: add AST2700 clock driver
>=20
> Hi Ryan,
>=20
> On Tue, Jul 08, 2025 at 01:29:09PM +0800, Ryan Chen wrote:
> > Add AST2700 clock controller driver and also use axiliary device
> > framework register the reset controller driver.
> > Due to clock and reset using the same register region.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
>=20
> I just have a few very minor style comments below. Otherwise the driver l=
ooks
> good to me.
>=20
> > +static struct clk_hw *ast2700_clk_hw_register_hpll(void __iomem *reg,
> > +						   const char *name, const char *parent_name,
> > +						   struct ast2700_clk_ctrl *clk_ctrl) {
> > +	unsigned int mult, div;
> > +	u32 val;
> > +
> > +	val =3D readl(clk_ctrl->base + SCU0_HWSTRAP1);
> > +	if ((readl(clk_ctrl->base) & REVISION_ID) && (val & BIT(3))) {
> > +		switch ((val & GENMASK(4, 2)) >> 2) {
> > +		case 2:
> > +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> NULL,
> > +							       0, 1800 * HZ_PER_MHZ);
> > +		case 3:
> > +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> NULL,
> > +							       0, 1700 * HZ_PER_MHZ);
> > +		case 6:
> > +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> NULL,
> > +							       0, 1200 * HZ_PER_MHZ);
> > +		case 7:
> > +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> NULL,
> > +							       0, 800 * HZ_PER_MHZ);
> > +		default:
> > +			return ERR_PTR(-EINVAL);
> > +		}
> > +	} else if ((val & GENMASK(3, 2)) !=3D 0) {
> > +		switch ((val & GENMASK(3, 2)) >> 2) {
> > +		case 1:
> > +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> NULL,
> > +							       0, 1900 * HZ_PER_MHZ);
> > +		case 2:
> > +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> NULL,
> > +							       0, 1800 * HZ_PER_MHZ);
> > +		case 3:
> > +			return devm_clk_hw_register_fixed_rate(clk_ctrl->dev, name,
> NULL,
> > +							       0, 1700 * HZ_PER_MHZ);
> > +		default:
> > +			return ERR_PTR(-EINVAL);
> > +		}
> > +	} else {
> > +		val =3D readl(reg);
> > +
> > +		if (val & BIT(24)) {
> > +			/* Pass through mode */
> > +			mult =3D 1;
> > +			div =3D 1;
> > +		} else {
> > +			u32 m =3D val & 0x1fff;
> > +			u32 n =3D (val >> 13) & 0x3f;
> > +			u32 p =3D (val >> 19) & 0xf;
> > +
> > +			mult =3D (m + 1) / (2 * (n + 1));
> > +			div =3D (p + 1);
>=20
> The ( ) is unnecessary here.
Will update div =3D p + 1; in next version.

>=20
> > +		}
> > +	}
> > +
> > +	return devm_clk_hw_register_fixed_factor(clk_ctrl->dev, name,
> > +parent_name, 0, mult, div); }
> > +
> > +static struct clk_hw *ast2700_clk_hw_register_pll(int clk_idx, void
> __iomem *reg,
> > +						  const char *name, const char *parent_name,
> > +						  struct ast2700_clk_ctrl *clk_ctrl) {
> > +	int scu =3D clk_ctrl->clk_data->scu;
> > +	unsigned int mult, div;
> > +	u32 val =3D readl(reg);
> > +
> > +	if (val & BIT(24)) {
> > +		/* Pass through mode */
> > +		mult =3D 1;
> > +		div =3D 1;
> > +	} else {
> > +		u32 m =3D val & 0x1fff;
> > +		u32 n =3D (val >> 13) & 0x3f;
> > +		u32 p =3D (val >> 19) & 0xf;
> > +
> > +		if (scu) {
> > +			mult =3D (m + 1) / (n + 1);
> > +			div =3D (p + 1);
> > +		} else {
> > +			if (clk_idx =3D=3D SCU0_CLK_MPLL) {
> > +				mult =3D m / (n + 1);
> > +				div =3D (p + 1);
Will update in next version.

> > +			} else {
> > +				mult =3D (m + 1) / (2 * (n + 1));
> > +				div =3D (p + 1);
Will update in next version.
>=20
> The ( ) is unnecessary on div on the three places above.
>=20
> > +static void ast2700_soc1_configure_i3c_clk(struct ast2700_clk_ctrl
> > +*clk_ctrl) {
> > +	if (readl(clk_ctrl->base + SCU1_REVISION_ID) & REVISION_ID)
> > +		/* I3C 250MHz =3D HPLL/4 */
> > +		writel((readl(clk_ctrl->base + SCU1_CLK_SEL2) &
> > +			~SCU1_CLK_I3C_DIV_MASK) |
> > +			       FIELD_PREP(SCU1_CLK_I3C_DIV_MASK,
> > +					  SCU1_CLK_I3C_DIV(4)),
> > +		       clk_ctrl->base + SCU1_CLK_SEL2);
>=20
> This block is hard to read. What do you think about this instead?
>=20
>         if (readl(clk_ctrl->base + SCU1_REVISION_ID) & REVISION_ID) {
>         	u32 val;
>=20
>                 /* I3C 250MHz =3D HPLL/4 */
>                 val =3D readl(clk_ctrl->base + SCU1_CLK_SEL2) &
> ~SCU1_CLK_I3C_DIV_MASK;
>                 val |=3D FIELD_PREP(SCU1_CLK_I3C_DIV_MASK,
> SCU1_CLK_I3C_DIV(4));
>                 writel(val, clk_ctrl->base + SCU1_CLK_SEL2);
>         }
>=20
> With those addressed:
Will update in next version.


>=20
> Reviewed-by: Brian Masney <bmasney@redhat.com>


