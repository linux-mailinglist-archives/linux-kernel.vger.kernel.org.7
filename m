Return-Path: <linux-kernel+bounces-779492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3861B2F4C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBC76042C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5972F0C4C;
	Thu, 21 Aug 2025 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dhirPAFp"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C78E2EF657;
	Thu, 21 Aug 2025 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770384; cv=fail; b=MQbuXX/OPlBRs/n+h7dkfuH4VRhnk42LxeLc8Ks1iSubDvbu57Cawi3VKZpUIQfZLJtHRwSDAMixZuTcSGhkWWiR+gyuLW9mZBMhYCoPG21BIHs8IsIs+EApL/jjjUiPOZEJEQW2pdl5VAH1iTOH4V+HoUmTpwnfL2vOjXTEK5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770384; c=relaxed/simple;
	bh=WhH9FVq4RFSyDdGS2D/uZ38fVOK/AGgViieXqCexbEk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JMLTbBGcEO9zidjHtXnCfRMxgoAouUGJF33MK7HN1KlnIjAMlq3UTW0xgVpmFstBckpaZKTc/6wzJsvQ7gvVyyLZ7k2dRy7axd35Y24gugOsM7og9Rca4MsZz3NczpRy3Rae5ZwLp57O6FawXoqgcBZWMIphCt3+Z85EFYU0yQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dhirPAFp; arc=fail smtp.client-ip=40.107.130.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/bdco+MUCWCDsxCgRofSRyjfSs+m6aGmiLv9Sk/hp2ntxgZdXcY6bTv4unWKgmR7muKWi8K4SopArawNe2aS7clDpVyAwVJITaa85M9xrGewv/HvZ1Htc2fEiC9auo24Ey6MgeNFInRCiVj906HdRkAOekPDqMJxhhyUSTsIFvVSOzE3tbvMzN2hln1WkTF0Cj8Scq+HRKSAbj8da28/Z+vk2C2VmLausn6lbEXf7zCwKVuoJyoAUPJm9daUFlDytL8Qdb8TPK1Z748k7HiZGneLMsTvpFy+O4c0YzdOZYM2rKvckis/w1uFuRoxIb5+hJCRBM/duB+GTTdFBR/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwfKAn/aXiBJY8BtSjaAUOAYns1FD6lFnHqKdPla9Jo=;
 b=uzpHP3erAESxVlX6jl0LZvp968MootVwzCbS5ltBfYEYNv3Si3t2HRNlXBRa9HfiD2o563gr94926/CErUPvRSnoOqvRB4GcMj2OASe+3yQgp6EiPDoOBN98mAUUgKQqcunOcHpHA4KVWUKY6xAy9Gb6oj6L7NktDg3JFguH3FDMV9PhxKejbzvBewjGQ0/3PrLl6aizP8aGiJ8o3JQkZY3ozkwdMvzg1i+/Huzg9sne0QZTt7G3w/FbzFAt5bL7ajKnO317xosvXruaN35l/f/hSXJoZBBXAmNQpnadHZAMyHbJFWzIumvXly6r3DrHK07+T/Cls93aM1YOsoiLqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwfKAn/aXiBJY8BtSjaAUOAYns1FD6lFnHqKdPla9Jo=;
 b=dhirPAFpKw2hp3QZ5t5UHr7s3mEkfOr4uq+6r3Q3vRJFTBrS2T0WqrPznzY/6p+lZ404wmVTRGM4PmZsysaXvjfloGc4NUqYgxUrJeXjWP0kGTkwnSnzITG4W6bSp6u0Qx44RZFTtQUd4eGbLa4oIdhFIORvjnD6b4FGYzs+516jF8npBwKPiavN8yfWqX3nkuiwvXeQaxqI/gXDDbM6TQ4m2EF+11oRFyQQj9X0AiIbATTb5d43gOex3kwLMFtq10S6KTwSPOKq+3uoyX5MYfb0QmlnVzFKI1okWEmFM59nOnLMW+IyxCvSrXK6/+g8XDRDL2Dub1WXC2gsOhIxHQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8615.eurprd04.prod.outlook.com (2603:10a6:10:2da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Thu, 21 Aug
 2025 09:59:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 09:59:36 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>, Frieder Schrempf
	<frieder.schrempf@kontron.de>
CC: Pankaj Gupta <pankaj.gupta@nxp.com>, Jonathan Corbet <corbet@lwn.net>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH v18 0/7] firmware: imx: driver for NXP secure-enclave
Thread-Topic: [PATCH v18 0/7] firmware: imx: driver for NXP secure-enclave
Thread-Index: AQHb4RG8Q9tiJOeRiEiHZ+j0dQaPJLRr8EoAgAFPowCAAAD5UA==
Date: Thu, 21 Aug 2025 09:59:36 +0000
Message-ID:
 <PAXPR04MB845980CB4C7EDB091495DC058832A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250619-imx-se-if-v18-0-c98391ba446d@nxp.com>
 <41909d9a-0ee8-460b-8c0a-1ceee0cf8723@kontron.de>
 <20250821095032.5o2trkwf6mdmyx4w@pengutronix.de>
In-Reply-To: <20250821095032.5o2trkwf6mdmyx4w@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU2PR04MB8615:EE_
x-ms-office365-filtering-correlation-id: 3e0e400e-5a75-4e65-a46c-08dde0996fce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|19092799006|376014|366016|1800799024|38070700018|13003099007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PSVeco6irk74ejw6byUscgRccT65VvwsMBKqZsQ9LejXdQyXSaP4wBVrKLP6?=
 =?us-ascii?Q?zflO+Gm8MF31s9vgg+z/QCV74IVoe1ncyqS+4MuVSJ8uJE/4Ww/enP0TMqrk?=
 =?us-ascii?Q?CfPmm1yopxuO5nMMZ/shEIffCwuJ0UybIuOyVu1z3vI5hYp+YX50O+fN3AcT?=
 =?us-ascii?Q?mht/EzDre4y2Xtvuk6VmdoxyEisECXO6YNipf3V3yTzq37bxJpVfJ6TRM70e?=
 =?us-ascii?Q?tQIK2ZH6+tpOuIYajrImcUySL4qoet6qgCmvcsSatVDaCZX0If1YGHFZp42L?=
 =?us-ascii?Q?DOEYGgA2NII2BuoFV94ZftOPyULdY/U/x6+7J0SznKfrI2Jy2AfX52DaPvgm?=
 =?us-ascii?Q?n806mn9ngW3LRq3FKXwMxldTPXyt/xtMQQyCOH30Uf/tgvjqjNOmNsqxnpeL?=
 =?us-ascii?Q?jGVTl1cjFJVaYEKCVxLmLX81in68F+YV6DxqZO98iCL2DBF2jD4NuvK+Xvk5?=
 =?us-ascii?Q?lHVGKMR2u3/NVBwCbHuTEhSByMRsV/K+BNu801M+z/Qh52Ww4lrdcnyI2cNn?=
 =?us-ascii?Q?gX96PLalGACR7ahyXhaUN6LywF/ZNSPpYx3p73Kd+9LgS9buTr8Baxr61IZ8?=
 =?us-ascii?Q?IOPgYkWn0Cz1ZTeh1Drw1uriPPmiO9zP7goFllHo1ly/CEkILeIcnpWSGzTl?=
 =?us-ascii?Q?HBvVPmRO3oA0ynaY6DXEC1mjKdHcP0BhakR22TkNH0VVFhL0q80egiIYKnGw?=
 =?us-ascii?Q?pI/1M5ZLUlGQgeFjwtZVPegFJYH1iBRCi7ZIxeT1KM/4HWDBgO3mt9YTJXpY?=
 =?us-ascii?Q?SfybTK8q4nNSJuBjfk7Y3Bwukd+ZhLj33NCJWYHtPiVpFr40Ki+dUa6QbBQO?=
 =?us-ascii?Q?cZHNUKhQEzOw/Hd2rcPPa7xyqVMU8CusI5ySIe9chz/LLPcQ1b0M6FuZuAS+?=
 =?us-ascii?Q?A34WRPq85A7f+dVygg4ZnYyaWOzH6jDo1RuC5vh/AAXkKLW9MwvVaX+3yERn?=
 =?us-ascii?Q?1ZcSmd+wXr8+ZPwkzgcE4yPa6HXdfKoiYHK7Ta8mBVihZKLU6h17kZLQKgrq?=
 =?us-ascii?Q?rUOMK9TL1h4F3+CswahdUryc1UOaJ9TsJdXCiw1GW2Ww/HNqh3KNj3Sv5BpT?=
 =?us-ascii?Q?BQBHImy6GjX7NzX4efOtS/Te5SpVJBLUf0VxX3cM+rDki+cEF28thVq9mamp?=
 =?us-ascii?Q?/Q6nxFYPCNSJtpOiGz++N1oC+/LL4gIRgEukd2C0aI7/Iomr4Wz1Js/MxvY+?=
 =?us-ascii?Q?K1RdkAwGaV7wtkioBUUsL3n90sjHrZoTmtntkTGjPopyuY27rkcjDwA15YAX?=
 =?us-ascii?Q?bhdOdUFMFBZG4baphTwKa65PP9uBhFcrafOpvLq770sDZPjFINvfcHsrO920?=
 =?us-ascii?Q?Rf0R8o+M0eKL6GAmnFJr2FlIlxHqWRMt/KK7KgQWmLMPz4sD0CHi5kSYcugd?=
 =?us-ascii?Q?T+5j3FcV9ULbmny6MZCZs+6DusjIUvTv1D/Hi98Q0L2QdDXK05dThOKrjcW6?=
 =?us-ascii?Q?3xrPvxPT+Ps=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(366016)(1800799024)(38070700018)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gxbe3zaZxJ6N11mM9cwrcK7FLaWlqzG6cqHdoO6EbJ1DkSS/UgNsL5nYsZTl?=
 =?us-ascii?Q?tT7qL7BML2RGOr24GT9N/t0bWc2FWldG2V9jiMeXzqK0N5ZK1ptmarAz5kd+?=
 =?us-ascii?Q?fjUXZ/o6qVt6uSjvztaySvB7BryO6Tb2FrC9Ox2sCzN3DJC+HYKtO58yQHAd?=
 =?us-ascii?Q?dzWKVtYUTz+8B5MDCIGwEuaga6lfLBsO/+YBFAwuPQtytAXzgure4QftW1JA?=
 =?us-ascii?Q?Fc0c6u9sF71UhPhAiPiFk6Vkrklna3YwwSPjA0W1GHv0bfYyPZn+En4SI2W4?=
 =?us-ascii?Q?Ds32PNfDz0P+qRsB5kK0LVOYP2ocffzADdo7hYWmi9ysxoJ4MCSh6EaCIWNx?=
 =?us-ascii?Q?lV5UcliWuvqtWm5amsiq5C6jfkXC4DUwD+btexrKhJMa/afgcn5oaSLiaVEW?=
 =?us-ascii?Q?RRBP85TKtApIffZ29PKpbhZHRSOyroF3hNwtjYmSBcSeQAU7Xm+fCnAl5537?=
 =?us-ascii?Q?iq683om0DkBV6zSUAwN/rlgKw1pxthQldmZNzRq21BewURuGkwUNvFgsVRhm?=
 =?us-ascii?Q?oQMvNT3ZFFn6FdVp0ehqc9lAUo/BEGvpC4BIhXztRH8p4GR+EdSa/1q8xbjj?=
 =?us-ascii?Q?BJS6plrzozAK1Z7WNMKbINblO7o0c7yag9xiGnSXRSM2e2pdVVK3dmuHnZrf?=
 =?us-ascii?Q?0ejmZV5Jv2ddi2Qu/d4SfrYqalwwLibZt5sDX5xhPOdvnYnYKOkYbU8XK6G6?=
 =?us-ascii?Q?Po9HgZgVixr+XYMR1V0mG4P66ZKc4R1LSOsWW2gwomcB2+fN+m8KrAYTnvdZ?=
 =?us-ascii?Q?BMzgWA/3xAyTpUP2mR7BBXnQ0uc3nk/1OnkvHueBMIOwOJYzuF3KBE7VbzFF?=
 =?us-ascii?Q?LR52Nggoc9393/zNv4AULN86Qjwp56S+KlUl5stQJ+NllIwjkt1LZWUQsnhh?=
 =?us-ascii?Q?eu7npfyNEJUOCbkGKtc0s6ft3U5KkIoelA/LcwrGAWkKxTL0sHtcWc8Uvo5s?=
 =?us-ascii?Q?Bm71R+W3rXMRWaL4zUyB3nRc/8EgDaQYZ5Ilu/PjnPMqKcmIXuOeuWPtCFG2?=
 =?us-ascii?Q?d6A2QgaVbDAo/YHoeXKYdI8f0AZlOtmvGLZFp+5aqk2Qe+uU0pwMVDX/5bhw?=
 =?us-ascii?Q?Jnk+ADLYrIPm8dphsgxoAu5cWlXelJESFWj/uHFMTdc2flM1BF/vgmuXktr7?=
 =?us-ascii?Q?Pi/OJNHt8F/YH6aoblnbG7j7ibSsAXBGkIq8TrzoUo8DoyyheqzGgA0D8f2F?=
 =?us-ascii?Q?JoUOY8jeExdtTDCzSGSLbbWlnRa/SYRtSzEbR/QuJwyKymM2l4N6QTdlHCP2?=
 =?us-ascii?Q?7Kxl47I9f6pqaXo/zEsgJL192oON7XTeCvKqMGG2ZJjruACS+/78OVFJfX6m?=
 =?us-ascii?Q?tRTg/zW1vQ3sPMVhla9zYdStrqPjr1qdzuSQ7pq4I8A4h946IlEu3pKleH89?=
 =?us-ascii?Q?tKgD7WRT/q0/dRd1RxF3/5p0UF4rpLXlsHhvqoqtHqhCl/3VQi9ch5irXNaw?=
 =?us-ascii?Q?PJSkRSb/LNUbfO6p4mDZTgfHsP+t22a5E97CI9GSk6a/8uNn5N5t7FILTb7p?=
 =?us-ascii?Q?vH27/eTPjRMc6sSdBmKk6BZbna8LmnHnwJPZVeOvrcS6skF6nOYBlOjY5iZx?=
 =?us-ascii?Q?j204dcrod/7GND/UcoE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0e400e-5a75-4e65-a46c-08dde0996fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 09:59:36.6405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SGKj8VQ/hOMIrFfZ+iuIM0y4FXIkmLPTuUqwbzJ4Gau4EqvMfBapcR7Bf1OCUtzjvoKHwLhrtbzsaUqBkvKJmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8615

Hi Marco,

> Subject: Re: [PATCH v18 0/7] firmware: imx: driver for NXP secure-
> enclave
>=20
> > Shawn mentioned for the v17, he wanted to test this [1]. Marco had
> > some concerns on the general approach [2]. How can we move on?
> >
> > FWIW I have tested the v15 of this series with the ELE OTP driver [3]
> > on
> > i.MX93 and we use this currently in our downstream kernel.
>=20
> From my pov, this series causes more confusions till the ELE FW fix is
> available because you need to be really careful during the integration
> in case of a verified-boot setup which are the most common setups
> these days.
>=20
> Not sure why NXP doesn't just add the OP-TEE support for the required
> features e.g. eFuses, watchdog, HWRNG. The whole Linux part is mostly
> in place.

You mean let OP-TEE handle eFuses, watchdog, HWRNG, then linux
relies on OP-TEE to use the features?

Thanks,
Peng.

>=20
> Regards,
>   Marco
>=20
> >
> > [1]
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> patc
> > hwork.kernel.org%2Fproject%2Flinux-
> mm%2Fpatch%2F20250424111632.103637-
> > 1-
> lorenzo.stoakes%40oracle.com%2F%2326356782&data=3D05%7C02%7C
> peng.fan%4
> >
> 0nxp.com%7C1ac2ac137e8a41d871c508dde098450d%7C686ea1d3bc
> 2b4c6fa92cd99c
> >
> 5c301635%7C0%7C0%7C638913666802700666%7CUnknown%7CTW
> FpbGZsb3d8eyJFbXB0
> >
> eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiT
> WFpbCIsIl
> >
> dUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D%2FSC9WU4CoKtPrVuhjL
> uLC7trQhAcbEkaCu
> > xohN%2FIuM0%3D&reserved=3D0
> > [2]
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> patc
> > hwork.kernel.org%2Fproject%2Flinux-arm-
> kernel%2Fpatch%2F20250619-imx-s
> > e-if-v18-3-
> c98391ba446d%40nxp.com%2F%2326443037&data=3D05%7C02%7Cpe
> ng.fa
> >
> n%40nxp.com%7C1ac2ac137e8a41d871c508dde098450d%7C686ea1
> d3bc2b4c6fa92cd
> >
> 99c5c301635%7C0%7C0%7C638913666802714776%7CUnknown%7C
> TWFpbGZsb3d8eyJFb
> >
> XB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOI
> joiTWFpbCI
> >
> sIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DB%2BUZWN6OjkEu27C
> By1%2FFKte9Uw9NQ
> > DA%2Be9EdPZhtAUk%3D&reserved=3D0
> > [3]
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> patc
> > hwork.kernel.org%2Fproject%2Flinux-arm-
> kernel%2Fpatch%2F20250416142715
> > .1042363-2-
> frieder%40fris.de%2F&data=3D05%7C02%7Cpeng.fan%40nxp.com%7C1a
> >
> c2ac137e8a41d871c508dde098450d%7C686ea1d3bc2b4c6fa92cd99c
> 5c301635%7C0%
> >
> 7C0%7C638913666802731697%7CUnknown%7CTWFpbGZsb3d8eyJFb
> XB0eU1hcGkiOnRyd
> >
> WUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoy
> fQ%3D%3
> >
> D%7C0%7C%7C%7C&sdata=3DRilSInf5N%2FfrF04qOubqT2yNjC%2FwAhy
> Oe6GIEfwtIGs%3
> > D&reserved=3D0
> >


