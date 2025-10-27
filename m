Return-Path: <linux-kernel+bounces-870979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 891D4C0C241
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07D054EF22E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38B82DF14F;
	Mon, 27 Oct 2025 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="ua/TIxIj"
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011037.outbound.protection.outlook.com [40.107.74.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9770B35B131;
	Mon, 27 Oct 2025 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550340; cv=fail; b=CSq8ddv3kA1CK/Fcv3KN/ntFfjxJU3hF1KhQwiYeCrqvAj5E6udaMP6UTo2/LlJWA89m9TnJNqkO3yXXIlfadCGhBPilQowJjtA5GEJGsyhNr9KJsHeuuik86wbyKvE2NxiJFgWCbwCQNgbvdSx3cV91C5i8EJDDZ34PBs3PppQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550340; c=relaxed/simple;
	bh=L3Ma28aC+9ztHtryl7eflh3HGiPfEgiv3dGrHAx4qT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Feqez0O9czeFdm1ZvRhk19/5YgMDlheGiSJs0Dy5lw48u1myv7/TxZMrTH6Z2p9lgB6xObBYJji7XXG308fazWygLDbaba6VSQPPwXqH8XxH4t+YUziOUHv/WVZS0jTExCI0TeG9/Rof1QFGWHcCtxOd2QlRte3O9BF/k8BpRbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=ua/TIxIj; arc=fail smtp.client-ip=40.107.74.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjn3ibvtksJVnInjcF61azLfYK+O0udZc2u3I+B6W90aW8Y7jxBQvrLcgtfzCjwRydK9J97/bt2o6XpUjR3PxMQ8IWkW0lh3Ct/3U2nwPVgAxzWt56ZglbjuVeqNp1cAcTe52oo+iq2y3x+zbbyUUAaVT3Ic+a5gqnHTCwK84fO6+6SxUDCXvox+uyzW5kOtqbmDekwfrmSonMZYYKsZ4ViVQ3Bp84V+meZePAN4Q6SaiMkyFryevcsWuIgEsPJygXuApeGP+ZPqYSgJUq8hkTlUCvlzCwJtsIs2hlRT1CEfrxtP/pkmG0CDEkWZP5VYFTWaLtuW9jA8ApRGaNOGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvffGGLs2Zpt4SGEYNvVFtKVXPd+Gpgq8YMW3Hrm1rw=;
 b=UI5UYAeV2iOYOy2Yc1tnWOqDcWakhcVCe8tVUtfmjwBJ4pQHS0RaM5FDDVA3FV7RMk8rg5FUOHf7ywJKyUIrRHov1Vtr2kx4uGs29UR3sM1FR89CuyIC4iE9sXNLzhhCNd2PDVJbBFEeM3OSqe4XZ9UOCFKHrM+ecRlcYwo3XdEOO/jLVev7kfP5MBUAbk8/7beb/xAhbvSWyo3SOER74V98VvCT83k/N+HvzcKOQ1npCzfqLwZHWD0w5A/pk+xzwlm/vjho579ot1EphCcSpjkoDkABoBlpmLSfXhFlP5VKGYxk+rgjk/YDG1iE8yyFvytKGl4mNJhNEx4C6f68Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvffGGLs2Zpt4SGEYNvVFtKVXPd+Gpgq8YMW3Hrm1rw=;
 b=ua/TIxIj864rAKGq4NNXxFIxoZj3cPUi+urAhEhBZIBAF0Q7VqaRuhsRnj1GZ2x/secFzlrZiYpdVXhKneo/V68DoJ4if1XvyxpoUDF7vWRXEVyoBkqPd+SDFE7ovPHyZl5NZo3/L8Akbf7V3UvhYqzBTPjrimiATI514VubBMY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB14061.jpnprd01.prod.outlook.com (2603:1096:405:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Mon, 27 Oct
 2025 07:32:12 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.9275.011; Mon, 27 Oct 2025
 07:32:12 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Dmitry Baryshkov
	<dmitry.baryshkov@oss.qualcomm.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for
 VBUS based on ID state
Thread-Topic: [PATCH v5 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for
 VBUS based on ID state
Thread-Index: AQHcRxM5EedFYnj970OO3gpVzFQbFLTVmUIg
Date: Mon, 27 Oct 2025 07:32:12 +0000
Message-ID:
 <TY3PR01MB113460779967E7BC8FEE11DEF86FCA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251027072741.1050177-1-krishna.kurapati@oss.qualcomm.com>
 <20251027072741.1050177-2-krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <20251027072741.1050177-2-krishna.kurapati@oss.qualcomm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB14061:EE_
x-ms-office365-filtering-correlation-id: 723de98a-2290-4969-a613-08de152af201
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tMkoJnUOA/bzwKxAjC95hJxiVAQ56eedMg2gGeAKmOi0JKxrBN/BLUw87aIx?=
 =?us-ascii?Q?lxKVD7v2aVbA3/xou0wE3CkbzAlYOAsTP38Vndynor/1quQa7UVpEnBqpQtJ?=
 =?us-ascii?Q?WOmrZcJkMLQRocerL/CcLPls7gg2+aO1cUzeb4QexOB7tEpUAj4pa3QOqYlm?=
 =?us-ascii?Q?aOlw9rrhckBDoWtF6JDM2roEo81Rj8ckk4xr+bknLI+R1dQmr9Sc3mr26XKV?=
 =?us-ascii?Q?b+xy1S0KGQMggevz7rBEDPbPcYSlX8MRsNPmwe9t5vm+dg65Dkdepth86rLT?=
 =?us-ascii?Q?dkjDuK/kkyrn1atTnx/kv80p94LecZi4Qb1wBanAQaoFIWbkWSbgRzVbJk5Y?=
 =?us-ascii?Q?gwAL4O+4xyLn/MaSj7qiaPgC5fTrrL4hfqXu7Job8grw9lAhjNQSk6Ha23NL?=
 =?us-ascii?Q?X/TuVWmwW2ZPoK/Uex/7M4jzxoSBP23wPV/2atUFM5HM0zARzWngMLlnfXW4?=
 =?us-ascii?Q?Z8KTqSUC77GDcDQ4IOoZehtTl1qRRbysdUHkaA+2rWlRY83da2UYI2kPc9YW?=
 =?us-ascii?Q?70RkaCOXxJPaZS7iz6+jFZCnTQAC3c8+ucPYuu3hRbjD0V7SFZ4U+AyViCYO?=
 =?us-ascii?Q?ixt+UBju38diJrIY5uO8TJT1VGvt4gF6ceLozOmv8nPjldTNhhwukg3Y01+a?=
 =?us-ascii?Q?i42rzE4W1xCv7HY/Hn/WgABZhHHbwzzZCfIoiGjPv0SmdFTP+efuVfNTwOYa?=
 =?us-ascii?Q?asO8tZHlC/tydK/HJS+m1rM8wZ21+lcZuCOexVRAy/o8VNni6vs6SZGvAvHg?=
 =?us-ascii?Q?ztSMuSi1jBikwew7LWL+lKZ9vXfNzx28O2hcIg0NyeLxRjwhgyYRHKgUCIxN?=
 =?us-ascii?Q?HCyps/IMIyhD55XsssrWO7GEpfnoHbMIV4UdHuXuXoGs2sW/GL3WFPnJykNM?=
 =?us-ascii?Q?bq4EoN8NCpdgD0Ft9NrVz3RZ4cCIjCGMVvIZNXrObg6YK/uXrQ1iJc45u404?=
 =?us-ascii?Q?+BR+7yqPBmgkcBe9H5cltdy1Pa69TXXwMEsPjhVfyNIDbPzs8TXdmmyFhaHF?=
 =?us-ascii?Q?QymZUPSmxipCnvDmelhTzMHpE+Qhth3AIM9q0dbvQWGaeGvF/z8ijUj2qCif?=
 =?us-ascii?Q?ff6x7ZjgpS3LMjvkZZa8LnWzLfhNds4n10pxjWKXFy4GT30bvzP6z9jJQstH?=
 =?us-ascii?Q?zr/EgKlmDW7pIh5VAvTt0KSjgrnmX+CaTcNYwj5IVhzZKvTadsZ43eIsJoc8?=
 =?us-ascii?Q?EpqeODTOUsnPWidjizsKa317HzlNuVThm68pZS90G6GDpqN0G1F7Wuf2b4Dj?=
 =?us-ascii?Q?iDm8ySTqa9CXqTymvCSjQ/od+uIeU9VPHF+L5XO9MPeHShCqNAswR0VuQyWr?=
 =?us-ascii?Q?C2Is+R5SMb61vYDI35TU/FSYg6wwksxlaJxZZa2KZB3qGjNO4nQjcWVwqGYL?=
 =?us-ascii?Q?EHSD5xmnO+OvJIu1r04LqGjl1O8j2xA4oA8yz16YQXQLLtyvSsuNSs4c7Pa7?=
 =?us-ascii?Q?OjDYQSe47tW7LpC7/ShEhnM/cQaMy16V4BW7X+o1vpNxllKfIDn4uGDaA+Ro?=
 =?us-ascii?Q?+11IurMfkSAd4Wos2+txY25krcf2rBZ+zxjo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3wqveZuaRUJ2PSPSGnIcCJcGvhNaWTg6Vpz7/spDxQURVsp7XbytJvGK10QK?=
 =?us-ascii?Q?f9Fh1gqt+DyF5tJ0tnpByY8FWdxb67syPaBATTUWNQo6Y09TeGOMesYUIetN?=
 =?us-ascii?Q?5+tvVeagqVlE7mAJObYdSQERB3yv1d31Hk4Z3zKWKONZHscGqEbs63AcBReS?=
 =?us-ascii?Q?TDYpQIHNh/0IDYbRZ4bAbJKMEXr39wCt4bOayYa3yZtPmU1J2dO2KYLuyuNF?=
 =?us-ascii?Q?PZIFHO/23qJqjTIfm8Es2QpnMoVacSz60RkiL5K+7L9j70qzG6BA+kMgETkb?=
 =?us-ascii?Q?4X5U9FqtYh46x5CrftJMrLh4dd7tI/LPWskJgAa2pMlXxFTcSGDZMj6YAxTO?=
 =?us-ascii?Q?e31CXztQ1s7i9VWrGWuK8S5xBzxGGsE2glY+n/H7IUxQmIimGPefLJ+h2HNv?=
 =?us-ascii?Q?STxjcKpjOC3Qv710uNCwvz8jYQzAMea24TRc94yu5Qtdsb2+EmiHx7QiQedV?=
 =?us-ascii?Q?diY966K3TpIWMeNDog3vIEKPIGTLay+anDIbZudIipzS6NFvrfhvblNQXqB7?=
 =?us-ascii?Q?JvEge/PirAwzty6M9nbCHpIpaPpGVkeQfl0PGDbKXFq3obO6Kgauz10Zx81z?=
 =?us-ascii?Q?oVoikqHkDJt3pqhZPyq7CroKtxyTcV7IeziBPFWhVCWMjrIqzveVJLIIM8t2?=
 =?us-ascii?Q?rT71t22VKrkwMq5UmCg/+7FM6qhv0qlmyTn/PGBJS+x4HZ5G4zof4B3WC+ff?=
 =?us-ascii?Q?yt22TgHzp/lwCkK8GMDKCejiPR3tJqW7mj0BnyZlo853LK2HXUuj6nKFeOUq?=
 =?us-ascii?Q?XbIRNdZ7qFlKxh4WdpiNNwJm5gWpGHM2JRLbOWDGEH+o5Noj/mO8+L2zQggY?=
 =?us-ascii?Q?jTa9nA0tiCnCUedXt2kjAijHDhGinAWBEozx8v9jHLktCpbLjJz/qMkJLQTZ?=
 =?us-ascii?Q?JAAUm1ouX4uj/kpFM7E/q1H7dXrrj3GDOZIrDJrBoayV1LgxC2S3CfTSkA2X?=
 =?us-ascii?Q?vAiXgLOH0enx6udRDxHAir3b3gpehWH122/AijALvgRmX1AM4XtTanf18o0Z?=
 =?us-ascii?Q?jMBONsKOccqC71FXZGtbmLY0lGsIB/u9D5HWnhc8ktJcImKDQS2GjVcqoLh3?=
 =?us-ascii?Q?MWAxF8fN43leFixZJKOSotIEVA1FZzWmlxQcqgkjij9zGIlaM0JRxlQzx6yv?=
 =?us-ascii?Q?VGf0WqeIPPXIwTjkb/JIRYrMZ48ZijKMCgswaqUCwfcOtPNNUbtAkSGBRpKz?=
 =?us-ascii?Q?3CuMhjFJSYKkZQZwtIOiTDwhMv02zlsYSwUVaBog04O1mIGdP+KmLnhTxm3E?=
 =?us-ascii?Q?D9Sbo0eEswbd5lHJ4/wRM6nSz+868T7pCIqbfe1zh1pGeE/UehrAmj77Lufs?=
 =?us-ascii?Q?sBe2ShY6HdlEBZMfp1pszVXT+oUfmhPsEtup75Dmqt1kxeoIEVdXgaG79sHo?=
 =?us-ascii?Q?gx9FfzS2+zGcDXH6Z/nRHRxWZVQVJC4rYQ5mWfzdFiUenSf6SbSycoPpX1H3?=
 =?us-ascii?Q?pPjRlBqUJ0/rleLig6h7edzqUh0GPrdwnF4YmJO+6SxNs12qTByl3/vapslD?=
 =?us-ascii?Q?J/Mn8nmFcbpReLJBuxMtJHrNBY51bww0mwukhXjjdueOblzh6+ZYW29L37y+?=
 =?us-ascii?Q?Phlcm8TZbke/OWGSIdUEuOooLs+l5Uf/ak3VT5CFdJei89gY/URWeth6re7b?=
 =?us-ascii?Q?NA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 723de98a-2290-4969-a613-08de152af201
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 07:32:12.5812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EAdyV9NsXfw6tbimjaTtA/cKoUcOV2n72DmJ25hAUayBUHuDOql9ytphTPk/kkjREZyhhmaFzVGwIv85oH/uzAZiABSZzp7gJ1yazggUIaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14061



> -----Original Message-----
> From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> Sent: 27 October 2025 07:28
.kernel.org; linux-kernel@vger.kernel.org; Krishna
> Kurapati <krishna.kurapati@oss.qualcomm.com>
> Subject: [PATCH v5 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for V=
BUS based on ID state
>=20
> Update the bindings to support reading ID state and VBUS, as per the
> HD3SS3220 data sheet. The ID pin is kept high if VBUS is not at VSafe0V a=
nd asserted low once VBUS is
> at VSafe0V, enforcing the Type-C requirement that VBUS must be at VSafe0V=
 before re-enabling VBUS.
>=20
> Add id-gpios property to describe the input gpio for USB ID pin.
>=20
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> index bec1c8047bc0..06099e93c6c3 100644
> --- a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> @@ -25,6 +25,14 @@ properties:
>    interrupts:
>      maxItems: 1
>=20
> +  id-gpios:
> +    description:
> +      An input gpio for USB ID pin. Upon detecting a UFP device, HD3SS32=
20
> +      will keep ID pin high if VBUS is not at VSafe0V. Once VBUS is at V=
Safe0V,
> +      the HD3SS3220 will assert ID pin low. This is done to enforce Type=
-C
> +      requirement that VBUS must be at VSafe0V before re-enabling VBUS.
> +    maxItems: 1
> +

Maybe to help DT users, add an example for this use case??

Cheers,
Biju

>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>      description: OF graph bindings (specified in bindings/graph.txt) tha=
t model
> --
> 2.34.1


