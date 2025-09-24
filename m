Return-Path: <linux-kernel+bounces-829941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC461B9848B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A311119C3718
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7483233D85;
	Wed, 24 Sep 2025 05:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="D8pcxwDT"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022136.outbound.protection.outlook.com [52.101.126.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795D81C84C7;
	Wed, 24 Sep 2025 05:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758691676; cv=fail; b=PbDrk7OJgU5yFHxW397iiNyvOIZixo0s3r0uafNLLMmg7KpbNTUDRrqFCT/774BnGr+AWaebtci4kbr6jmRoLqoSwZdWhtHHoLB5poAolWwEBKSNI3xrlDM4HY4A4EWwMeQ45+bZ8rFEQgzaQxq0SkXMwUxaiPPADKu4eOfBk8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758691676; c=relaxed/simple;
	bh=iz95rRyuhh5BfgWbjpSbN5CWg2hyXqkjGMydQbergSk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=onMc42TJ8ODS02p/FtDWXzPO/CK3PpI6JeUnr60z7d+CyMVjPoh9udagF3epE9K4q4qTbX72zZ8nZ3xllgkS0ph4Lm2RjZYnESJmurOm+M/ZKQ2OpFNRQE6/UCl6Xf0z4dJ06lgEIdUjAQj+mRBrTvfZm9ILHQ9ikW/fhtheNdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=D8pcxwDT; arc=fail smtp.client-ip=52.101.126.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oooxyJnGX9LM0TGT1svWPnT+alUVgtaiyXhW0keYRT29pMKuzbvuA0Wy6tmMFIQEyOHldY5H464vQRoFEufm2hwkjj0/tYYAnuZ44MryFB2t0L+0HxPPFSimQ2sGYXWTjXxnGrqRImSUizF1zNeXgSrioTrUe97pdNZ8RXiErhdvrNZxUcqs2YBVGv1YvA+F17PXHElWQ3B2uD7PaNe3ZQBmj6CReshl0lirI+GEMhgW5RqeKsHRyoI2g00CS2NAoDWgP6Avj+cRGLzIyuj/k8u1g9lFt2mPMOibzJ8/X8W9NV4ZmrMK3vR/+OamE6rml7Dtfd90B6CRqlvuqcetkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjXpKXewvKv85KMvNnzu6uMkdQZcAtgaVLQAVoWFNgc=;
 b=JVauQvgfUqV9KUs8/knGYqLTzeXKDtZ0pX25e8Kmi7S5TyEtNcik8mTj8dZ1ifJWvYFlo1KdxMqN4HPwKbvTfr8Gc4TQafj59Ow1SV8ClU/88vn8GKn/HtLtEf4s2Db6nacTP2bd/rGx1HtrQIylXTwi00AL4ote0Idhw3FfxKF1Ey0XRPg2lB+VILuj2SBqk9FMVqbYQj2bvIPicYZOHQ+Duoow2pSue48A6rABuTn28jQZccm0M+D1uxgSaW2iUb3fEk6u/+lrMGVpcehh0K29q4kJdOgzSYQjvumjC/dhagYUNiZs+rDi3x936JOqGyPic3EKq16w56p8WNwCUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjXpKXewvKv85KMvNnzu6uMkdQZcAtgaVLQAVoWFNgc=;
 b=D8pcxwDTxqmcIjU/d+X2HmbDvXviO9jybhFwmGlE1+3eIZtqfxMJtLhhEoSXUtxhBQ8kLVKv3Wg1k81ZGDcssyzvIp/rVl1FfjPk7D4HZIEJxUYTNt2c+MABhQYGy9gM+P/vjbCe88fqa4UDFY0kzfv7Pi04DoxaPK8JXo0kkm/TzvS9jxkii7FnNkg8ar+YY9VNCQeEIEZ/kQ97bKcBgGjssCkw7c2yuIne/aqSoej7y/FI396nHMeyJJT4HskAZWgqAImBDm1seWQUCVLyOtVLE+wmT1/Ahkhd/c/Zuv7WOO36tGuXSbNkxIv6+Fy0wENROr/vMmJf1yQx0MXorQ==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYZPR06MB6327.apcprd06.prod.outlook.com (2603:1096:400:424::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 05:27:51 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%6]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 05:27:50 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] usb: ehci: Add Aspeed AST2700 support
Thread-Topic: [PATCH 2/2] usb: ehci: Add Aspeed AST2700 support
Thread-Index: AQHcKGhfX6zMMKIs10CQ+TAzfOSFlbSY+OyAgAi5CeA=
Date: Wed, 24 Sep 2025 05:27:50 +0000
Message-ID:
 <OS8PR06MB75418A889FF9E2FF4851DB4CF21CA@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250918064919.224927-1-ryan_chen@aspeedtech.com>
 <20250918064919.224927-3-ryan_chen@aspeedtech.com>
 <95dfea8a-f5ec-488b-bdd0-fa12acd3dce8@rowland.harvard.edu>
In-Reply-To: <95dfea8a-f5ec-488b-bdd0-fa12acd3dce8@rowland.harvard.edu>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYZPR06MB6327:EE_
x-ms-office365-filtering-correlation-id: 1f22244b-c60a-40f8-c544-08ddfb2b1ab9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Iptm77oF/Eh4KFu1nPKGLeBvj4lH5vfUmCKptGPm4bok/kWHTnOgyOtmb51c?=
 =?us-ascii?Q?rdBP1AoQtbWlFY26d4JLeZUKxcKUjADx+YRt6fyAMY1zTK2PP14Tv16sk99N?=
 =?us-ascii?Q?PTJ+1inDXeH/3UA0C78tQfsJ9grb4zUcKMawO/IWA4+7PigGwZCwD+la1Igb?=
 =?us-ascii?Q?a4hZ9RlEbZjMQhftyeubhcm2MsvELEUfXnK6j1jtmYLrLSPTt4Dj0oIE6Q0f?=
 =?us-ascii?Q?w4O8XcenX4WWRYe/DOlAcUnXoeAPQj17+hJarMP7evBczPnEsVNCOb8Q0K7+?=
 =?us-ascii?Q?WKuWBosuLFALbgYM8cAsRPW2jPLLBZWX5FqHf3P/rPUY0bHg8c5WS6S17A/k?=
 =?us-ascii?Q?5lYklo9Gl/G1n4ujLFmPpQfjU4bqV/w1YtNjn4Q5RqbEv3HUZcqhKwvnV+MP?=
 =?us-ascii?Q?6OIK+shmCW1vw26i97NjrU6Bu60XZpe7IUWhuqit4vd8vdtbWvZWDbXBvkDZ?=
 =?us-ascii?Q?ebdNyo1orLs7uBl/giUuGcUkt0MsPG0lE+ifV08pHQ5PX8scTqnVPiV0YI2P?=
 =?us-ascii?Q?NopkAiVpg3gAkk+qgVQAfZ8qUGAtM67QGyB/4XQFoUcTi+E8eji7mt52qU3t?=
 =?us-ascii?Q?l8DuE2V9SsUgAxmyQs1HhyXWKdvv1rUH/liMyz1+MWqmfyamFncm5gj/y71j?=
 =?us-ascii?Q?g4n4d415VdjwGgSl/DDldxywrdp1jRwJs0kpj+hU9zcRwIcXt1rV+6hx4GZ0?=
 =?us-ascii?Q?2qEcLFnlcyFpwDm/iVEjVZXqtMXm7FqW+s3lDkRdcSPVGauko+F1fr8QZUWM?=
 =?us-ascii?Q?qsU3DZFR+UmKPlT/HDYvIpMHPcIMA7eUjvUrMMx2yviISQSFmRWVS1C3VGCz?=
 =?us-ascii?Q?HIO9FiWP4NftWea4gOVI5hxGb8/hrN/Bsa0/7Yg1IGNk9OO9xHmiS44YR2B2?=
 =?us-ascii?Q?Yu1oEN12foa0LtsFzTF/7eqf33n4z4GRhMHxQQLeoqTCpVXQw7y+l/7h3Eri?=
 =?us-ascii?Q?6QJtLeTn3eaGsWlPvzyYxxmJ02aUKUrXqVWFm17PlwZWDYDMZNuj01fWWFUQ?=
 =?us-ascii?Q?bWrQ/lKwIONkRnToUa9WBwKY3WVlIEt43UtnEPDtlsurae7udjxHpqeQJnzY?=
 =?us-ascii?Q?ogOVsd4dxC9uOz2ixGP6iFV5xNKTkEpya4HR5MHuynWr6qAclYoRQqgaHH9s?=
 =?us-ascii?Q?arHcMWqIqxjmu1ExPATQUL+buYuKs8NokitXXnP93/8SIHC3azcT5AYTgIIv?=
 =?us-ascii?Q?jrbHbv+4x4lXjXVEtueMsaN/LIQ3elupA5lV+ava9gZukIbeeOJKrqrBAyEy?=
 =?us-ascii?Q?fkqHtuG8AKZHDnN3A0fkVIP/XG2wr9VIzHArqdLUnDZknckRqMuwuHhiJBmI?=
 =?us-ascii?Q?4MCEh1jpgWVyPzq5eMLHt785CN96e2tp7HIwKIF+GSJSuZOFu1XFT3wtNmo1?=
 =?us-ascii?Q?RBWbnarLKFscsVGp/bjP9XiPREvfnl9Z/YWQp0ULCU1tfSZC2Ds7l6beeLlw?=
 =?us-ascii?Q?+OyOR/HnsQq/6kGNsmhzXZEAeOyDcr3CFLU8pKj49u10/WWxvSr19V+jEpRq?=
 =?us-ascii?Q?+vi2uV1lKKC0Obk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LahfC100dIcHXNcRL12j6sO5yeM4ed9pC5v7wP0BEsdjXFW7biWRKrfpYx/t?=
 =?us-ascii?Q?NtEOkaDmu6DkiDfP6hVw2pxCKPQ7sTfkX7UBKlZIJAn3cDI+HpSCFxLflQNx?=
 =?us-ascii?Q?GPuIdRkbTBs4kG6PAhibfs1onh2eUOp9U9Ad4YblILaN9+U4isYjVYvfOM1K?=
 =?us-ascii?Q?ziWO11xgFWBqdG+2Fkx2x5c+Zb77b7qsNDd/x874omiiKrHV6EY6aPuL+lbv?=
 =?us-ascii?Q?SsQKpoX2tVbfCqWV9qzMgxkEVMGizC/bTekdQUOFWrd1nC02PFxy937Jg+J2?=
 =?us-ascii?Q?6j0ns034fhgJFJApUpJEL7IjZSUK+AhBMQdmlz+D9XfuQzq/8h+w9xByOU+e?=
 =?us-ascii?Q?PhXm+7psTCp3/JLM2xouEEIl14un3spFrot3xZGgG66BCiu+8yOtkHn0anez?=
 =?us-ascii?Q?utfdUAReY6VoUlpZRSmBnndc8pSS95Vvq64GmTezeFzdgWZldRqIQNUptVIK?=
 =?us-ascii?Q?93qbOqJeI58GgXTrtzDwL/x9J34Qyl3jgvzbW6qsK+4Cvh84PnaLe8bn0hhF?=
 =?us-ascii?Q?2YFw8ScqFtn4VlKP8ImHFqDmFO3NXQwRuQ+yiNk+canHl8P22023RohCkTZX?=
 =?us-ascii?Q?pEWcUzkIPFm8TAKibuNRCxKlBu/27FBgw4IocOiqhk0hyrHz9fQLTuAir+lV?=
 =?us-ascii?Q?yyfSRN+BhAbFwhr+Dpa1JOPl9eXXFVf9oOdO8G6722SDgzrpNJBEMej+8KPM?=
 =?us-ascii?Q?JFuM8di7BCCd+Ww164Psjg1QWb7Vgqst/12dN3rGTEQfz0E/md/8dVp9dS1t?=
 =?us-ascii?Q?g0MfXg6QW67ykUdnJ2enWUzgFamja37mmSQ7JRkW8uiK8UzZFBB/8a06xXVg?=
 =?us-ascii?Q?00mOv2/EoeSkdgw0KspkaDoiKsbIMRSgccvJSAXXfE3olxTLVKQ45qyWD4dA?=
 =?us-ascii?Q?WTw9hK+H9Fcm3sTpbtBYvOie7SCTlkDOJkYKRrgWCXvYiCQPM/tavUSA5Yfm?=
 =?us-ascii?Q?0/tiIrelVSoM0DytOHHTdt8Jby92WnCH076GXPGG8GYZ/byVna/zHRfAfPRG?=
 =?us-ascii?Q?/Z7LhmFoXNxkULRhHMQE3IxMuNszlKwXo0MLCuV5s11WdjirhVhviuo0ys0v?=
 =?us-ascii?Q?YB/1gQZeEnItzhMZ+XscFrQ/pG2RhVnE4RXBLvPrMTqU3/hQYvfhv5xdtJV5?=
 =?us-ascii?Q?wXz26fPRFIbvOgR/F5kGgMBlQ/Yg0PC6vFXSxeKvBYh6rkbJNbswaAoD8fLw?=
 =?us-ascii?Q?CjFIB9XU3/5eBjxS26ZiMbQdEgi3Z4aYG9LHHGw6RzB0hbLqS+0C6Y+0WnLI?=
 =?us-ascii?Q?CBgxgWvoj26mCRMJiMHLy2ZmpfgZg/uZt+DgPX8TtOak1jMIzIhrVa1lqCdG?=
 =?us-ascii?Q?QScxVDafEm3OiyVBkdD6JRmmrj9xNQQnMknXwdtaINpEWA5GXCE7Ni/UigTw?=
 =?us-ascii?Q?yAuJASGkLyEZh36RM8Kn501gscms4vCguMnJqscPj7m/OYRZOz5kWd3anaU3?=
 =?us-ascii?Q?lB8RzaqwYb62NQnrj+Dl7uTeeodOpOTZ8A1PW42TKokV7QXejiaVJEBD0GFP?=
 =?us-ascii?Q?YSTHd2Ks4ECk0+tECx6L1q+Anvk7ZY2YlllFuhegOimu8xfA/emafHylRQKa?=
 =?us-ascii?Q?YPxAr2/w3BX8otOvNgOeJw6zUUDkfjoAQjEC9uZf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f22244b-c60a-40f8-c544-08ddfb2b1ab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 05:27:50.6767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C5i3hKNy0KSzhbY3uC+3sFVp2LVbm3YjsPAs4kVI7Lwz0sn5BfAeyaMfPGWaz7HgqdxtvHsZPzck9MfoGl3X7L+0+gZqjMaF6oqQSeEE2b0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6327

> Subject: Re: [PATCH 2/2] usb: ehci: Add Aspeed AST2700 support
>=20
> On Thu, Sep 18, 2025 at 02:49:19PM +0800, Ryan Chen wrote:
> > Unlike earlier Aspeed SoCs (AST2400/2500/2600) which are limited to
> > 32-bit DMA addressing, the EHCI controller in AST2700 supports 64-bit
> > DMA. Update the EHCI platform driver to make use of this capability by
> > selecting a 64-bit DMA mask when the "aspeed,ast2700-ehci" compatible
> > is present in device tree.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  drivers/usb/host/ehci-platform.c | 26 +++++++++++++++++++++-----
> >  1 file changed, 21 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/usb/host/ehci-platform.c
> > b/drivers/usb/host/ehci-platform.c
> > index 6aab45c8525c..edf1fb4033c2 100644
> > --- a/drivers/usb/host/ehci-platform.c
> > +++ b/drivers/usb/host/ehci-platform.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/reset.h>
> >  #include <linux/sys_soc.h>
> > @@ -122,10 +123,18 @@ static const struct ehci_driver_overrides
> platform_overrides __initconst =3D {
> >  	.extra_priv_size =3D	sizeof(struct ehci_platform_priv),
> >  };
> >
> > +#define EHCI_PDATA_COMMON        \
> > +	.power_on		=3D ehci_platform_power_on,	\
> > +	.power_suspend	=3D ehci_platform_power_off,	\
> > +	.power_off		=3D ehci_platform_power_off
> > +
> >  static struct usb_ehci_pdata ehci_platform_defaults =3D {
> > -	.power_on =3D		ehci_platform_power_on,
> > -	.power_suspend =3D	ehci_platform_power_off,
> > -	.power_off =3D		ehci_platform_power_off,
> > +	EHCI_PDATA_COMMON,
> > +};
> > +
> > +static const struct usb_ehci_pdata ehci_ast2700_platform =3D {
> > +	EHCI_PDATA_COMMON,
> > +	.dma_mask_64 =3D 1,
> >  };
>=20
> Arggh!  This is dreadful.  Just have two copies of the initializers.
>=20
> Better yet, change your of_match data into a boolean property for overrid=
ing
> the default DMA mask and then use the original ehci_platform_defaults
> structure.  Look at ohci_platform_probe() in ohci-platform.c for an examp=
le.
>=20
Sorry, I may not see the implement on ohci probe.
https://github.com/torvalds/linux/blob/master/drivers/usb/host/ohci-platfor=
m.c#L100-L111
But I think I will modify by following.

if (!pdata)
    pdata =3D &ehci_platform_defaults;

match =3D of_match_device(dev->dev.driver->of_match_table, &dev->dev);
if (match && match->data)
    pdata->dma_mask_64 =3D 1;

err =3D dma_coerce_mask_and_coherent(&dev->dev,
        dma64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));

and=20
+ { .compatible =3D "aspeed,ast2700-ehci", .data =3D (void *)1 },

Thanks.

> >
> >  /**
> > @@ -239,6 +248,7 @@ static int ehci_platform_probe(struct
> platform_device *dev)
> >  	struct usb_hcd *hcd;
> >  	struct resource *res_mem;
> >  	struct usb_ehci_pdata *pdata =3D dev_get_platdata(&dev->dev);
> > +	const struct of_device_id *match;
> >  	struct ehci_platform_priv *priv;
> >  	struct ehci_hcd *ehci;
> >  	int err, irq, clk =3D 0;
> > @@ -250,7 +260,10 @@ static int ehci_platform_probe(struct
> platform_device *dev)
> >  	 * Use reasonable defaults so platforms don't have to provide these
> >  	 * with DT probing on ARM.
> >  	 */
> > -	if (!pdata)
> > +	match =3D of_match_device(dev->dev.driver->of_match_table, &dev->dev)=
;
> > +	if (match && match->data)
> > +		pdata =3D (struct usb_ehci_pdata *)match->data;
>=20
> Do you really want the of_match data to override the platform data?
> Consider a system that has both.  Which one do you think would be more
> important?
>=20
> (If you take my suggestion above, this question becomes moot.)
>=20
> Alan Stern
>=20
> > +	else if (!pdata)
> >  		pdata =3D &ehci_platform_defaults;
> >
> >  	err =3D dma_coerce_mask_and_coherent(&dev->dev,
> > @@ -298,7 +311,9 @@ static int ehci_platform_probe(struct
> platform_device *dev)
> >  		if (of_device_is_compatible(dev->dev.of_node,
> >  					    "aspeed,ast2500-ehci") ||
> >  		    of_device_is_compatible(dev->dev.of_node,
> > -					    "aspeed,ast2600-ehci"))
> > +					    "aspeed,ast2600-ehci") ||
> > +		    of_device_is_compatible(dev->dev.of_node,
> > +					    "aspeed,ast2700-ehci"))
> >  			ehci->is_aspeed =3D 1;
> >
> >  		if (soc_device_match(quirk_poll_match))
> > @@ -485,6 +500,7 @@ static const struct of_device_id vt8500_ehci_ids[] =
=3D {
> >  	{ .compatible =3D "wm,prizm-ehci", },
> >  	{ .compatible =3D "generic-ehci", },
> >  	{ .compatible =3D "cavium,octeon-6335-ehci", },
> > +	{ .compatible =3D "aspeed,ast2700-ehci",	.data =3D &ehci_ast2700_plat=
form },
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, vt8500_ehci_ids);
> > --
> > 2.34.1
> >

