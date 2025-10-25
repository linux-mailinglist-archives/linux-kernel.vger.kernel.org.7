Return-Path: <linux-kernel+bounces-869806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F385C08C8D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 09:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BED44E80D3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 07:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD1B2DAFAA;
	Sat, 25 Oct 2025 07:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="BmHxK6ZW"
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010049.outbound.protection.outlook.com [52.101.228.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F425747F;
	Sat, 25 Oct 2025 07:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375706; cv=fail; b=nzIuEL+VmL1KbzNFXBga8m9CfGblFESSqapvNbMTw4oKefnv+dgG9oqhs1xscOAOgf5Jos1IrVOrx29gx0FA6SuIKuYzU5WjVxqyj8VLylU786aARhkSEFngm8+BiZGIZ9JYIbbbSYkq4+C+VMbCUhdYPAWyeB1Jv4a9ywlPoyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375706; c=relaxed/simple;
	bh=7aLf/t80+XY8NGG9bQFwYXOy0BfKiXDvqSFuCxuV9DQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HmBy+jwUvp4dAhAvoKTrZqfWMBAMOx9Ng/jn5T57lHcMT502XDZ/rRkdMBRbF3v8Z3qAFH5/btt6a3lRj+bab8OYhQqWtVv6rMUyvKVQAjmoMN3y4dBZ3CHIyy8dq0yxRwZcN2AYbhtsRoc9k69tey3IatcYR6OgS3y85b6rxt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=BmHxK6ZW; arc=fail smtp.client-ip=52.101.228.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWtCv4slyG/qu1KGwpmBzVpPtih4WG2O89wT3Cb8S60cZPVtV0FWMxqgLiUbhRh56+Fw9Xwo3WHLdwhzgmA/h3bJ7prsiTsSAZLxxfeXS/cy7iW3ocoBtwYkur6jhb5zzyNvPVIka29BkjWROF1xTlQSYUMQsQ59nSFPlpPCPb/VzNpqMCZgl90SIOV3xqZkIhh4ZxLe1Ft6wXb1TD2pnXeNudG0cYw//4ISTZC7wIvjnUkss8XUUDG5OYPHzII2HGzSRMYjml3pHUTtIRgRFcCDmrqO1Cddr24h/pirI3w2KZcGwJfhzr6ZazE07WIM/fTGR0sDO4LkhdlJDytf1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3B/2HYmI1c7E1MRSKB9rHdxw7YsGhSR8BaNvpzH75A=;
 b=jQoPOzCo7tZvAdcakh29LyqlyU9EgnhxsRgsQJBJGs2OSnn5ohuBNS2wVDKBMDKSgD6wwF0t9FyajkzQdDFMpcgIVjqNvlEK6K9fcnnCQRlTnadSKb49DocB9UvYSnCbQdytfaQFc8bgj/HQXEz/Ah+ijUu7EfOk0cNRQMVuD/Epdx0ZXECn6/tr8DProEr+FNKO1wvBxcXg5KfwstYwbwWuEC9F8d/7KGNUCbj+5d5Sq4qwZZ/tpT/7HiGvR2eT09tzsJPJs7WyK6vj43PM3x+26ldP8bdu9SMqxO5Iyr5P81nTg/tmXRgNILccbKUXQ1T3IdwoA+EkRXbqIJGqrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3B/2HYmI1c7E1MRSKB9rHdxw7YsGhSR8BaNvpzH75A=;
 b=BmHxK6ZWejB73VTf9/SueGCxF9TW6MlAxZT+ALdcdPy80s4UydKlHIy5iMa2DYWKbu0+tqED/t4CaP3F7yNJtSMa8uM1pmJTSiAK4sYGanCAlPlBU1THt0a0hFcrKGS4qUfh9qSne73f+M4+SJNfRQpY5Q26lu3Izy4lLESJIiQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB11227.jpnprd01.prod.outlook.com (2603:1096:400:3c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.9; Sat, 25 Oct
 2025 07:01:39 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.9275.009; Sat, 25 Oct 2025
 07:01:32 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Dmitry Baryshkov
	<dmitry.baryshkov@oss.qualcomm.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID pin
 state
Thread-Topic: [PATCH v3 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID
 pin state
Thread-Index: AQHcRRKvhP4wQTQytEactMmaKsxS6rTSb8LQ
Date: Sat, 25 Oct 2025 07:01:32 +0000
Message-ID:
 <TY3PR01MB113464EA259DDA069E7453DF986FEA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251024181832.2744502-1-krishna.kurapati@oss.qualcomm.com>
 <20251024181832.2744502-3-krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <20251024181832.2744502-3-krishna.kurapati@oss.qualcomm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB11227:EE_
x-ms-office365-filtering-correlation-id: 835c42bf-e170-4479-030d-08de13945469
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EgvgBQR6iPWcfPBXODSsuz3ZSxIwwz4Too+lrNomXYwstpHrLJexfO12+lJE?=
 =?us-ascii?Q?N2NWirFcUVhOR6c6LbjFoOksnOmPvJrrAHB8gVd8O5D6Pk1O28Ahwymh1FN8?=
 =?us-ascii?Q?NDe9AoqNuJhqmLvTLkhfoJMYihLwdrwBDKhGLMx4Vu9qMtL1nq3LKo2nuxmZ?=
 =?us-ascii?Q?WqIBufKWv+7YRah/aqaQDE5H8vyfcqzw7xFXXY4KeZ9RhHQUJGUS+5mwV6o0?=
 =?us-ascii?Q?jQSHW+3LRgIV+kZ6W8bKFhN7CHvrLSacbof/bmhLVbopTnrAYeq+o6apLyLw?=
 =?us-ascii?Q?rf/Jm4LrK2qbHXZCC2GElgGxnDdUUxlZhFdPfShsZSHvQvj4rnXRnfKMTm7i?=
 =?us-ascii?Q?wYbwPUh4pVESUqYi6NAP6L5f4tcB2V16LZMYX9FkbNqdo9qY6WFpJly16sTP?=
 =?us-ascii?Q?53AGrdQAd8XLcrrSM5XiwMYxExTTgTDDP0R2U7pBKCmEOQiIjk8pkBcDpiMB?=
 =?us-ascii?Q?2Pdh6OrO8ISeh1wSM3cEhp72whHaAHPM9A6GSQanO5yGM03GKZfUYJjMKi0d?=
 =?us-ascii?Q?PLT06ba462XxGp0dOshPQ+HkHQNhnXDZJ2jQeJyKweFni8C1vO2UPQeLovqL?=
 =?us-ascii?Q?5VERLAIwrjRPlk5iqLZp+U/rcj5ybNc52IUPabQIJ4gKm85f5bnQrPzVFLhq?=
 =?us-ascii?Q?0PxE7mUQB0yp8ahn1orDhS2+gKrPosqGrZ60M27pQ1eqPcu1+j9o6KRvLs9K?=
 =?us-ascii?Q?nJ+/y9vhR6xlOqbi5fs6HHIiNcNKIKqD6ATxc+PtFC3bIMHvgWHhVELD7frf?=
 =?us-ascii?Q?t9SFZS6mIp0C5qm1QrQmXVXwV9J/GiECNBN9UeUmKaKJWUzcgsoqnDiP6o+a?=
 =?us-ascii?Q?Zfl9q9qvQoiX7BGgwVqkd0FBmqfMDe0CQ7N8RIVo70cd8FK2w+NCJ0AjBgBm?=
 =?us-ascii?Q?Wj0xrIvMb54k83y9Y/8mp6v2KHEWv+YiBP3KLM+Th98on4ZvMrzlnUUY+0if?=
 =?us-ascii?Q?HS+h08n3PnWK7vH/EN3qlTv809UZFgpOGQe5OfgTSJM/oCf9udZ+SeZAt3HS?=
 =?us-ascii?Q?0YgZVc+3gPBE2KwoS8OkzuRLAGlUetj3pxKTdYVxQjnqLJMD+tUAkI8R6Iqo?=
 =?us-ascii?Q?xpTV8LdfA+bGpvcE0eM2A73HQ6ugB2c60wJ/dnkRYtZu2PqPI631MWLjSAAJ?=
 =?us-ascii?Q?mzyRbxZ68zLr+aETxx1H38CswDafUWrOshQXp9pAfT079rlxpJFqpwIpHWSS?=
 =?us-ascii?Q?4Is78LmtXjNOo3COZAQcMTnu5T/vU2qyd0Y5UdQzy+nbWxyvW4MvjOap7ved?=
 =?us-ascii?Q?E+jD7jSrvLA20TTlJKCm+TKktzDBAD9iRpvxxwzhkhhXS44pkygcYokp2NUD?=
 =?us-ascii?Q?0bLLprsCC4Ife5Ed9wmRw0j036+By4tM1bNLe873S34YnL0hAvkaI7rP5ktI?=
 =?us-ascii?Q?S86QYsgqJDIZU3Sb3GnsJWbXkpM7YTfbyi7KVX/0iTrvsiKIYzlRr7iaOhOU?=
 =?us-ascii?Q?GWT9mHadDn8wbzQ3+Z9sQvKtkTrLlNTQTBFXs6unufbamAyxJ3Q/jg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sKhYOyTsKv4VeVEIeyVRm4rPKs5TClYKowKZk4MtOXz3V8LaBTaqgv+6noLi?=
 =?us-ascii?Q?xU6VTXdZBNKO42gxaPOX67f0Cs0fmf1i0Dm7RJzMEJidmv5DTh9jx3LDc638?=
 =?us-ascii?Q?1cN9Vx4ZfPls2CVDeTTv0UsUvG1wTxOkmC8kGamKFt1aTqqs1Dm63RZp4g9v?=
 =?us-ascii?Q?yw4daxhe5hvtYiQCSVgi89C3UvO5RJhlldzaJMTOfw5lJhaYyNaBpdArtimk?=
 =?us-ascii?Q?HxhGMu4Y0ne0zwSYXkAKpV+ONW7VwBhUDlN8XJDJq900maaNd/LyNQc1oIR4?=
 =?us-ascii?Q?ljx0chzLcVK+DM2bmgI2efkX0b8sIC3ukNPe7sfvz/47jERoKxOv1xelvAs+?=
 =?us-ascii?Q?aU/XveS05DpoifAAX7zz7XCr+AefuQe0f0iGPGkJGpppyOgCYte1l9ukaAH2?=
 =?us-ascii?Q?BvFqDPXkEC8Evg2JCTHxkRruuy8bNwcN4wCJuvZtb+ybinOWmdv0N5ji04Fy?=
 =?us-ascii?Q?vwg5g/dJXXZGXckfdGjMytT/Ds/AfO53NqIagqbJvGRnnMP76/4CfcUCOLoI?=
 =?us-ascii?Q?8GMeHsPKuTliA8SBFpY1y9dCnWCZ6JfSlEzXoKi/wOybFPcsHzA2NnHetREe?=
 =?us-ascii?Q?hyVJ0adY5TRcGmkKTH3gheS64sLCMx4sMNW5yDty1QJe6hn8JNscGI2WxSQE?=
 =?us-ascii?Q?KU+e5dF1e1OLqchmPnYDCYemcfatqGF9+H7LZUcL5xv5fCSTeNTnZgIWyjem?=
 =?us-ascii?Q?pyf3t7XpeqGQz3Y0VWsuWFRvTGFZRK/aRnobhO3ZNc5wheeO0asjVbs5zyus?=
 =?us-ascii?Q?TXNTIUpHCbzYw/RRr4duagI0TqZwtjgVlrSDqBlUQ6yQliMJ92rxy9m0kSu0?=
 =?us-ascii?Q?ucBkMpmivF/vJ9T0d5n0zDaLGcqMUj/PLUkeabQAhf2OAMGO9treWaZUT9ui?=
 =?us-ascii?Q?wv+bOGp32YXiRAqA0HGnm8JeS3uodPzQRplhwudN7kNtovtDQQz+h/48QJ6C?=
 =?us-ascii?Q?w/0vkTKvO/fpsU7njVAPP/ujwfYedi1545DQ7yN4DwzNnUAMayUasRinOGfH?=
 =?us-ascii?Q?lTVVKkd81hs8n7FdndjJkbjsPw1SRG67fy1Z9dvEJmSgVPAR8p2t2JWfOrUl?=
 =?us-ascii?Q?jM682BTq2lpoE9Rl5ylJvWtS2rCL6SAK4rBrOoRsbMlHKO2o9hYPu78cPjZA?=
 =?us-ascii?Q?cNLYeWILqD/TffGA8CR/xHCBzYfq28FsZ6ypeZmYjZjZEf2xvtMtymwhtuzk?=
 =?us-ascii?Q?aPL9bey0BWZegv8XU+vdqWaXUHKEXz9EVKjKpiuW7XnnuFSSEns8ViNWmvfq?=
 =?us-ascii?Q?fGYjFJg1F8o/lu6S/krkKoAwqJxL6JnnlkrnqxC7PDduTz5IrVGyVIZ6lhhY?=
 =?us-ascii?Q?Rw64bl9N4VPzs0OjzYYBtozRfVdWmzRY/jQuPNW5tE1xHVsR7oHezLybb2xO?=
 =?us-ascii?Q?kWcz+Hl+jQIkdbU9HhTYRKWpbiRomjt0awq6P+TAIKqf9kMgwcmfa7F+p+QF?=
 =?us-ascii?Q?UtjglaNceRUnX9q2TIjfeDk46n1SmqzzRzSrHvjQXZ16e7QEixACZzOhkQQJ?=
 =?us-ascii?Q?IOiS2dSypM5PQ90N4c+9JcdgF0v1pnp3CNGtbTAUgY0eOsxM9i2dc0Auzen4?=
 =?us-ascii?Q?ak7wV9HEAGap9N8vsygIgY4xVY1cn+J8sbOEU+ZJQOiSQRRoMln374sh7zpB?=
 =?us-ascii?Q?ZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835c42bf-e170-4479-030d-08de13945469
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2025 07:01:32.5245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNQyedwztDrLymzjzF8iXd+C2s1SmpHHlRecBEVI0/pwExDBf8X1rVY/kRaKEsagPDoUmWBRjgAVq6/vKFu4+PRv4QaZFHkcTt3rth/fPXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11227



> -----Original Message-----
> From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> Sent: 24 October 2025 19:19
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring <robh@ke=
rnel.org>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Heikk=
i Krogerus
> <heikki.krogerus@linux.intel.com>; Biju Das <biju.das.jz@bp.renesas.com>;=
 Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com>
> Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@v=
ger.kernel.org; Krishna
> Kurapati <krishna.kurapati@oss.qualcomm.com>
> Subject: [PATCH v3 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID pi=
n state
>=20
> There is a ID pin present on HD3SS3220 controller that can be routed to S=
oC. As per the datasheet:
>=20
> "Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is =
not at VSafe0V. Once VBUS is
> at VSafe0V, the HD3SS3220 will assert ID pin low. This is done to enforce=
 Type-C requirement that VBUS
> must be at VSafe0V before re-enabling VBUS"
>=20
> Add support to read the ID pin state and enable VBUS accordingly.
>=20
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
>  drivers/usb/typec/hd3ss3220.c | 101 ++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>=20
> diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.=
c index
> 3ecc688dda82..089c4168c7b5 100644
> --- a/drivers/usb/typec/hd3ss3220.c
> +++ b/drivers/usb/typec/hd3ss3220.c
> @@ -15,6 +15,9 @@
>  #include <linux/usb/typec.h>
>  #include <linux/delay.h>
>  #include <linux/workqueue.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/of_graph.h>
>=20
>  #define HD3SS3220_REG_CN_STAT		0x08
>  #define HD3SS3220_REG_CN_STAT_CTRL	0x09
> @@ -54,6 +57,11 @@ struct hd3ss3220 {
>  	struct delayed_work output_poll_work;
>  	enum usb_role role_state;
>  	bool poll;
> +
> +	struct gpio_desc *id_gpiod;
> +	int id_irq;
> +
> +	struct regulator *vbus;
>  };
>=20
>  static int hd3ss3220_set_power_opmode(struct hd3ss3220 *hd3ss3220, int p=
ower_opmode) @@ -319,6
> +327,71 @@ static const struct regmap_config config =3D {
>  	.max_register =3D 0x0A,
>  };
>=20
> +static irqreturn_t hd3ss3220_id_isr(int irq, void *dev_id) {
> +	struct hd3ss3220 *hd3ss3220 =3D dev_id;
> +	int ret;
> +	int id;
> +
> +	if (IS_ERR_OR_NULL(hd3ss3220->vbus))
> +		return IRQ_HANDLED;
> +
> +	id =3D hd3ss3220->id_gpiod ?
> +gpiod_get_value_cansleep(hd3ss3220->id_gpiod) : 1;
> +
> +	if (!id) {
> +		ret =3D regulator_enable(hd3ss3220->vbus);
> +		if (ret)
> +			dev_err(hd3ss3220->dev, "enable vbus regulator failed\n");
> +	} else {
> +		regulator_disable(hd3ss3220->vbus);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int hd3ss3220_get_vbus_supply(struct hd3ss3220 *hd3ss3220) {
> +	struct device_node *hd3ss3220_node =3D hd3ss3220->dev->of_node;
> +	const char *compat_string;
> +	struct device_node *np;
> +	int num_ports =3D 0;
> +	int ret =3D 0;
> +	int i =3D 0;
> +
> +	num_ports =3D of_graph_get_port_count(hd3ss3220_node);
> +
> +	for (i =3D 0; i < num_ports; i++) {
> +		np =3D of_graph_get_remote_node(hd3ss3220_node, i, 0);
> +		if (!np) {
> +			dev_err(hd3ss3220->dev, "failed to get device node");
> +			ret =3D -ENODEV;
> +			goto done;
> +		}
> +
> +		ret =3D of_property_read_string(np, "compatible", &compat_string);
> +		if (ret) {
> +			of_node_put(np);
> +			dev_err(hd3ss3220->dev, "failed to get compatible string");
> +			ret =3D -ENODEV;
> +			goto done;
> +		}
> +
> +		if (strcmp(compat_string, "usb-c-connector") =3D=3D 0) {
> +			hd3ss3220->vbus =3D of_regulator_get(hd3ss3220->dev, np, "vbus");
> +			if (PTR_ERR(hd3ss3220->vbus) =3D=3D -ENODEV)
> +				hd3ss3220->vbus =3D NULL;
> +
> +			if (IS_ERR(hd3ss3220->vbus))
> +				ret =3D -ENODEV;
> +		}
> +
> +		of_node_put(np);
> +	}
> +
> +done:
> +	return ret;
> +}
> +
>  static int hd3ss3220_probe(struct i2c_client *client)  {
>  	struct typec_capability typec_cap =3D { }; @@ -354,6 +427,34 @@ static =
int hd3ss3220_probe(struct
> i2c_client *client)
>  		hd3ss3220->role_sw =3D usb_role_switch_get(hd3ss3220->dev);
>  	}
>=20
> +	hd3ss3220->id_gpiod =3D devm_gpiod_get_optional(hd3ss3220->dev, "id", G=
PIOD_IN);
> +	if (IS_ERR(hd3ss3220->id_gpiod))
> +		return PTR_ERR(hd3ss3220->id_gpiod);
> +
> +	if (hd3ss3220->id_gpiod) {
> +		hd3ss3220->id_irq =3D gpiod_to_irq(hd3ss3220->id_gpiod);
> +		if (hd3ss3220->id_irq < 0) {
> +			dev_err(hd3ss3220->dev, "failed to get ID IRQ\n");
> +			return hd3ss3220->id_irq;
> +		}
> +
> +		ret =3D devm_request_threaded_irq(hd3ss3220->dev,
> +						hd3ss3220->id_irq, NULL,
> +						hd3ss3220_id_isr,
> +						IRQF_TRIGGER_RISING |
> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +						dev_name(hd3ss3220->dev), hd3ss3220);
> +		if (ret < 0) {
> +			dev_err(hd3ss3220->dev, "failed to get id irq\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret =3D hd3ss3220_get_vbus_supply(hd3ss3220);
> +	if (ret)
> +		return dev_err_probe(hd3ss3220->dev,
> +				     PTR_ERR(hd3ss3220->vbus), "failed to get vbus\n");

Does this code backward compatible? There is no vbus definition here [1]

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/ar=
ch/arm64/boot/dts/renesas/r8a774c0-cat874.dts?h=3Dnext-20251024#n208

Cheers,
Biju

> +
>  	if (IS_ERR(hd3ss3220->role_sw)) {
>  		ret =3D PTR_ERR(hd3ss3220->role_sw);
>  		goto err_put_fwnode;
> --
> 2.34.1


