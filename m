Return-Path: <linux-kernel+bounces-817969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551D9B58A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F4616EAE9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15AB1EB193;
	Tue, 16 Sep 2025 01:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="gc2lks6n"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022134.outbound.protection.outlook.com [52.101.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9B83A1DB;
	Tue, 16 Sep 2025 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984670; cv=fail; b=l3Hw1J5gj/E1rBn0V77ms+tWXjBTajd90XTdQIzqSzPoyFpiQavlB/ZfqEPmQczZHW+Y8Xyn70a/gRFAXNfp9Rz4FN8TE0nYB+BqZzUgfiCvWkPGzgjO8vs5bLhGU2DOjhCYjG2VKorEK3K8lnso6Rd93730M8/Ve15GtOpUVWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984670; c=relaxed/simple;
	bh=eeg1+7kXoSAJ1omyXToZHu3UKI8/b4EA3pqnXznxfbU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GQdybmSQBSgmOfrfcC+aOtGA8v4a9TueK6DRt1oNtMOuhtQy0vl0rwLWwh92FecTsjm0AP/kYXxLyMYKK9cWu4SuhVIfQZswYXuEXCM/7AG5CRRW3CttkLSHM+J2ym7CTngbAgX6mgRQeLNdmf/r/asphG3JltUEtvZk2W28JBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=gc2lks6n; arc=fail smtp.client-ip=52.101.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZayM0S1E2ZuliZq9+kXJc52GaLVk0OZyAJXB3pTvJHKec6tqY1jV7P1rtmHkV4YbnoaiSU849PRicyNhuKY5FBLO7xvZM9MMG3hTrqrGPq2NWTXFioauQq9WNB0MarNT9PyWCNGF1rWcCPiayCN7k5Kvq77ehLRB6YAd3Q9wazky10nrIS+I8BnPpfqYFKcZy40EjoVeJ4x+w4nMELMzt1/TqNBZs7Jev/rskPuLYrmqnxSGB9PR+JBbxiEEh0Kf5wZ04BN9jz1604JqFKsZhTLbVJG3zFM4S6BUxOi2BPu6qVgchDy/apEFZkHEUHqb9LjhC9ZlrJzxr9lxz9LKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMpfAQ+xe3+7G5D6Q5f/tq9NYwKuvCmJKnCOcU8OIPM=;
 b=E4YRQo8gRgCSAYcvLJo90i1P1Hqu2ezd1zZGo4CrbaoNp2mIhgbD5rP+1gT9/gMo9MOGID09GnHXgXUNwGp/RDAyXj7HLiNS7ZMbenvMOwxcFE6P/f3MWppYq9QvqbshEL6jdpqECniMV1f84u/Pp8+wMC/Os2SWX5a/iNTKhCjAPDfZEkWFe08uwnHD0dM5BYEfHVS58KuPgHFApWPx5PhHga+QyRzBNXKbe4tKQMYyRk5EcRebA1riCAePIecCiAT+RrA6vQjhGWD9CzikE8nPK35CbFbROois3LIcrmcGL+03MvBUbs5g7LAgU0UjII8HxTn/bJgZfkARcyZIMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMpfAQ+xe3+7G5D6Q5f/tq9NYwKuvCmJKnCOcU8OIPM=;
 b=gc2lks6n0m4obxYNnwL9LL3Q4wLpku5ZZycNqUxQlzuP0IZQX9DfGcoMe4NXeHEEX9fIvU6p8H/8qRjZxS4J1H8thu/uI36jjykrdks8ha5D4xueC6sNYn6xh1VwPmifWbmGhe1pOSjoNLKpRh6rvVrOT1puPu5vYX1nUkmxWa2CkkCxygddwKKkjdvWw0BiVJEx3U93l+AYYJ9ISGJj2LGSYQoBvCHUQAw3gS7VP/YgblGjYTW1XaXGBBCJKzqrptRQAlW8AHEYwJTdCVB/cqfKVFGxwcQnFelO7yXrRRwxPkzwUfwIfU+Zfu+SMqD8ZCudSoi7rzVGZVw847Ktvg==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEYPR06MB8115.apcprd06.prod.outlook.com (2603:1096:101:2da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 01:04:25 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%6]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 01:04:25 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Conor Dooley <conor@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Philipp Zabel
	<p.zabel@pengutronix.de>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] dt-bindings: usb: uhci: Add reset property
Thread-Topic: [PATCH 1/4] dt-bindings: usb: uhci: Add reset property
Thread-Index: AQHcJhPguoKJzJBy+Eq6KXY5LwuI1bSUglCAgAB892A=
Date: Tue, 16 Sep 2025 01:04:25 +0000
Message-ID:
 <OS8PR06MB75419B97CDB5EA24560FB9ECF214A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250915073926.3057368-1-ryan_chen@aspeedtech.com>
 <20250915073926.3057368-2-ryan_chen@aspeedtech.com>
 <20250915-fifteen-sappy-82f26231843a@spud>
In-Reply-To: <20250915-fifteen-sappy-82f26231843a@spud>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEYPR06MB8115:EE_
x-ms-office365-filtering-correlation-id: 867c3d6a-2e84-4847-af7a-08ddf4bcfab8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dHP3tT7OTZx0QsZWGI+W9XaMt05yVwRKa7Vl/CaMnDP+SYJHcRCtc9ih2n3L?=
 =?us-ascii?Q?oTHL9aUswau/3XzW/sxigPtWgFdC6En/xhaSWFxX+6gjpa/oy6DID3nicDc0?=
 =?us-ascii?Q?Yv+eYqhnPbYbrARwe6JhPwm35FYKPgR7UmW+8pe1JcHwsAGR289i97Fosg8L?=
 =?us-ascii?Q?h8LPfhBUPY8ic5AJD14kOH2Fj2CTNjoPGRp7+VLv/tl6RR0dYn2tNdMcoSoO?=
 =?us-ascii?Q?HMr9yHa5bnq9fCEtnVFmcuWXrOSJcrZNEir39gEn/i3iXWwlnYmVIiGpPn4U?=
 =?us-ascii?Q?sbNRMvnmlM0Z3BQW72N28kUkv9WJShSuIuJt+PbyS7PgVl/igbe2uVqZmTMJ?=
 =?us-ascii?Q?O3UTTJCMWJGooW6jeh0+qj99/8hylMUL1nfkz/RAhWpSA3zWM/oOTpx2DFZH?=
 =?us-ascii?Q?CoQsD+F0Ap2Irn5zYTTn599rT4StZVx85lYU06NqwR1FGjAsBmabgYvfzEfX?=
 =?us-ascii?Q?k+9Am9k70nJ1+yu0xSQYNx6DR9UPYrkS6DgCjp5ZFZshBQoaySQmw3oehGgv?=
 =?us-ascii?Q?p1VV1aRAd70IV2w+pMxwymK6rdavqrglFinBqGwqhwKqYlMb7N6DnqxN6rFe?=
 =?us-ascii?Q?uU0oJiRtQRUf8gm9JJzQvqfXJgpYRkr+k5+mVGx236YDt3+mDu1Blh0JhxB0?=
 =?us-ascii?Q?SGrudC2vIY8sQjVhfprdAPaLJTdudakJdcCMUKjOPxGKak+2d/XeL0GTT5m7?=
 =?us-ascii?Q?Q7oPP4zsrFsCj+SLpyybjuZ4Qt5np2lGcOWefA7c9Kjxodi5mzIwmZBHK7B7?=
 =?us-ascii?Q?y7uc0fDlN+pQpJAx2tZfM9m+dysW/HDqVl4CwjVZMZCL9Qpje9KnNwEEXXvC?=
 =?us-ascii?Q?PPrm/E5GaCUuiL9S1qfv6SHhWbqBx+u2osnAGvtZZYpcOalEFX9reukgU151?=
 =?us-ascii?Q?vvTlib6oHTipR1EkO2MZGJaC9Vhvv5ozLdjVqERvcSrzMYh5NWaIyY/mcTGd?=
 =?us-ascii?Q?qJlS0Ecrz25fOCLQWamBzJ1/6GL6y1NeXvv0RQBdW5L12G3iFVa6BhPIQp9d?=
 =?us-ascii?Q?NPEgI6DzShYEdEUNJgsg/0TU2mG+dMm83Kd//DJPMXchL+243qLy65a8iVOt?=
 =?us-ascii?Q?On/2aDhk3QkMtpB/0FLUIwVcXmEYTnNntVnxjnnRWduJ+jokn8iSSiq1V1JA?=
 =?us-ascii?Q?l+0Bvgdw44Z/eSr72+u28cXmxg11EKQ4yqYExtKS8TUuO46sltoAdcKF0mrD?=
 =?us-ascii?Q?WLI5JjLoKOfaIImbdynashIk6QKCEAi7P6OLcGAIFZf4aHiF/wpfYFqSYnIP?=
 =?us-ascii?Q?a1rE5ybNHObXqVHIOqsa4/oLKNNRbPXcyml9vYDf7oy3/TiJBKs7vt1hOB1s?=
 =?us-ascii?Q?3dr9qIS6v5WYUMIYGEchquICvoQqx/kAD+sdxA3Pi3uC8NrRJxvh8+Y1DtFI?=
 =?us-ascii?Q?V5XXC175Z3Ieub9N4frlHL2IOuBlcjqhu8Hxl/4dV22oVcH+1lYfBAkRp8pF?=
 =?us-ascii?Q?wzMmShf00og+OAB2B5Wv0TOPqh6dw9a3ZnPjoTT5/9k0iRLzoP2UYw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XBbAn5P2y1+7ejLGwQXxdkaekL9YEBUukmbsOalRn0xzSKB1qvHAbDU45bHM?=
 =?us-ascii?Q?JNXNCGzFgbh+BbYB4sitv84ZJu9UhLgviyM3TCFPbCtmDDyMU+aEyYYqaN34?=
 =?us-ascii?Q?UsaTkvhF2AsNrCS0BPLlvA7LGa6UxP61N4PDHplvZ8B5pSUgFMrQruhWTJT2?=
 =?us-ascii?Q?MnZPP//bAi42Rc1/Q7QrJ+Ri43PKLrKglAq7Dw9SDNAyFbYdHVFe6BaxgEV/?=
 =?us-ascii?Q?t3xzIuPiM2sSf2WEe5vZJXu3LoBjaAx9TkajtfyYxyK+dVcNjph2UhOqEdeg?=
 =?us-ascii?Q?6WPoPGnLabNqi+Q3UHsz/0Om0+r+6gLTsNS4CDDHQW26KFr5B4CZdHFamaKu?=
 =?us-ascii?Q?ljcLq1VZncJ9LnaVf4mmGehMa1SaVE7dsVVzS25hnbdR9msphnA7S9IpMunx?=
 =?us-ascii?Q?Wvj28dVrVLORkxt6OpztjWAA+icpBiy+QAw+K4WofGtqF++4/zXAJehaz1bs?=
 =?us-ascii?Q?1K1QO2XF38q5GNTHbWQuykhcGj/J0bwISbb8NnXj6ewZZ5GV/i0Bo7Lkjews?=
 =?us-ascii?Q?o4o/2RF+gGqA65qQ8mfOH9P8vlPAc+du9+PiHweU8pmM/Qj2y/WEHV9I94Xh?=
 =?us-ascii?Q?/yLmOY4FHZEVIfAqs/4/82kqDJDH15gPhM5Lhp/l/hFBOtdZaRHWmjwcIh1l?=
 =?us-ascii?Q?Lojc/byFpuuXEGqXXE2nKVyK2vu+bYO2ikUBGkszIx6rMf2k8VtP37yY8hFU?=
 =?us-ascii?Q?3as40SmODnDNyWnpu948ibg8KondIeKdOvaogGN2JZEVf76tcS8Z+m10x9cf?=
 =?us-ascii?Q?gRfvsKFrv4PuZ+yQm7+w+Y76DWe1OwPZNO87JTR5zBzYYeRyrTc/oXNqMA2Q?=
 =?us-ascii?Q?uDZzGTUG0eiuKgumey2u3OtQtXumf9KtcMZRna31dIUkLgjo5cWxYNQz9Oan?=
 =?us-ascii?Q?dXjpNDCuLg4ZMAwSYUS873M6wnn2FxnGCzK0szL2/P6KC5M83A5we8+QXfCk?=
 =?us-ascii?Q?g59j+VO2aRTx/eyzZJtVB2uzCczp2JZEmwdwRwGQ1bkBVGZYZtDsE+heHdlS?=
 =?us-ascii?Q?xULSY5V/XTZvjsu2rSKWRnis5upz1LXGpzG95+AfY5OqMUgvnoHAINu6xYUv?=
 =?us-ascii?Q?r9z977ZXNPyVxyrV6kl+9tJwCyDBsrDaoKBDW8lHePlP0TtRhI8k1gmnrvwG?=
 =?us-ascii?Q?k2wRMoSo/dma9TAlL0DSJc+tv0PSXUKuqfTGOocvGd50RZcRkH+s5+zyF048?=
 =?us-ascii?Q?fhOh+9BLySrbyALFmPJjWI76kuhoYMsqC3BCtC9aP2USVLGqq0gK/P566aOu?=
 =?us-ascii?Q?A+tWgWHdsMJWKInju1P4Tt5O8Yz4PAWgmAHIuWE50eg1VUPfeJfBZgQ5+n2v?=
 =?us-ascii?Q?lQKt81of6EcoOoXhkLbxTSUL8vF1+IA2o3nICpKycqaZ/mJB9dklC0uHBIdX?=
 =?us-ascii?Q?upY8Qvtbjha7yDmjsdg+k2pMshR4k+6/ztiTfhln2shNd2KDVaQ45K3SOEx6?=
 =?us-ascii?Q?M/d5cADNfIXKyigFbZ2YqR0ouCvPteOb/v8jzesOM0ffSU36nVib4li02GtP?=
 =?us-ascii?Q?4CYB3iE9h8J/GzWeBgEOWF5xgYAz+o1iMbiuS2nZGfPlWQZ8vZLJmD69H2m1?=
 =?us-ascii?Q?ykbUEsXuRnoC0/GW7oSnan0oKKSd+IcSpghQ1dwc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 867c3d6a-2e84-4847-af7a-08ddf4bcfab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 01:04:25.3466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a2J3I4lbAnmkmDZE9ChvP26Wq9y18JGtV3oFmVqh+iUugS4judJ/As9jHTJM+//ZACI75+ieLB5zjtlOkuSowogyP/IfEtpKNXVP2kuu6h4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8115

> Subject: Re: [PATCH 1/4] dt-bindings: usb: uhci: Add reset property
>=20
> On Mon, Sep 15, 2025 at 03:39:23PM +0800, Ryan Chen wrote:
> > The UHCI controller on Aspeed SoCs (including AST2700) requires its
> > reset line to be deasserted before the controller can be used.
> > Add an optional "resets" property to the UHCI device tree bindings to
> > describe the phandle to the reset controller.
>=20
> Looks like the property is not optional at all for your aspeed devices, a=
nd you
> should require it for those compatibles.
>=20
> >
> > This property is optional for platforms which do not require explicit
> > reset handling.

Thanks, resets is required for ast2700-uhci.
I will add in following.

- if:
      properties:
        compatible:
          contains:
            const: aspeed,ast2700-uhci
    then:
      required:
        - resets

> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  Documentation/devicetree/bindings/usb/usb-uhci.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/usb-uhci.yaml
> > b/Documentation/devicetree/bindings/usb/usb-uhci.yaml
> > index d8336f72dc1f..b1f2b9bd7921 100644
> > --- a/Documentation/devicetree/bindings/usb/usb-uhci.yaml
> > +++ b/Documentation/devicetree/bindings/usb/usb-uhci.yaml
> > @@ -28,6 +28,9 @@ properties:
> >    interrupts:
> >      maxItems: 1
> >
> > +  resets:
> > +    maxItems: 1
> > +
> >    '#ports':
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >
> > --
> > 2.34.1
> >

