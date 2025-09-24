Return-Path: <linux-kernel+bounces-830640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ADBB9A325
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5891F16469F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0DC3074A0;
	Wed, 24 Sep 2025 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iPEuwlfM"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295DF306B39;
	Wed, 24 Sep 2025 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723256; cv=fail; b=MmqoEKwzyU68UAfoyqLvlCDJtzJdq/7lWDyi37tVYk0eY5Lxs0gPI22CQZKU/psftNn4S6q25i2EwDYPdoy3quF3kr4SJPT7hGJuFBxR0ddj3R5EnvLNP+iTcXY9hD2L2WrhSf1Ud++DD3seMYag7Nx84dpL4Ny8u8wQSe+mT+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723256; c=relaxed/simple;
	bh=C14OYAc7cnZMJf20GUplVUGtSC1SKvqKVikb8C2YDuI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ALXPy02XtFaH5h8dy1aI3s+2q8T5BySbBl4lQVL2jboMTh8S9tH2NiIJWTUUB4/Y3Jvom1JU+Q9sv4z89UF9SPcQ42CxfzZAW8XskBEIoEcsW8YWRgQI+fF2a/m+Hu4qude6E1aPy9Too4R4qc20DZPYegIMM69hTNJ5Si46Rro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iPEuwlfM; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gh540P2aEH4axanDSETJ8NLoUoAiWZUh84Sn+t2ml+i331pSurZwpxJZmdwFOV8D+F8VT2e75pVA6HfM5HgJwtHAy9c1QwK6RuQmMampkDSEvUnX+CpSwU8rTPaKolnDkDQY+JCkjsxp63GDnew275QAoJL5AjchxC+VEf2rRRYkiUJqcsLY+MyzjOi1oVJQoe/ClkcZrZ4AX+E+IbdIFFY+zWwfZ8/Nj4psRhQjSvX/TnmhLGrlWMROz319nFI2CG46bexAKUBJyKa7WHXe9FzYSD6zn5QYkdiTubbDnROwRz8JWjI+1Xszb4o2uGq9VhFrZL/wuCCc+vuS2tiqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C14OYAc7cnZMJf20GUplVUGtSC1SKvqKVikb8C2YDuI=;
 b=ejvlGX+MaOKfsg5AuOwEmLZIrOeemv9Z63/mk2v6ldUxkJgdXS5XOTSz17Pkyf737wjV9DycyxTDnFQH+Sq3zUKbuzykZg+cIVvGvr7qEzKCLzef+R/X/F1m+Q4eKoqXyJrQrlUxZicEUmt0YGqd3edYtcGqPgF7y6P4BngXBJ58/BRexQdKgQcwWeKKoPUNd0ZTKRCRnI1w9ULEujmixpCbor88MQl27x4TQvNQi7doBgEDW8XBzjrx8pK8BXxwqF2pBg+K9U30/jPHWyfKNNzNViQ68pEWBVc2b0c2/sDHAHndwbegPMCcMzjAhg+NfEZCRxWC+5QPrgf08GEGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C14OYAc7cnZMJf20GUplVUGtSC1SKvqKVikb8C2YDuI=;
 b=iPEuwlfMgrsLhF5KVTOZcsnmC6km4kNlvWSlY3ecXSoMQCAjGoW5cICpE/47cup43qcbZk7SHhXEHM6FWY+EIKJC3+Z7lNU4ZVROWvk8CYGHr9f9mf2JK5bAQcXnYPBwWKEFcJNVGwMqvniwYj6ZV1A4+TVoxdN912Fyu8ea9PBx2QotROcl5Mz2j73/ucPholYpWGV2ggAah6YA0VfR5tN8+fCTrUVLFew2CPsV6sv2DIrT3ujZQWeQtWdbaFniQJSLcAM6AMFT5UIsM3uTHqnukuO1ktueZEoLrtB4r8DFk6zib1iXHo6zIFEzHdOkT13IrtaYy/rZIsHkfqY7xQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8718.eurprd04.prod.outlook.com (2603:10a6:102:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 14:14:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 14:14:11 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, Sebin Francis
	<sebin.francis@ti.com>
CC: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Marco Felsch
	<m.felsch@pengutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brian Masney
	<bmasney@redhat.com>, Dhruva Gole <d-gole@ti.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for NXP i.MX95
Thread-Topic: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for NXP i.MX95
Thread-Index:
 AQHcJhsCzmRSrEp0oEyqjCzMN4tqC7SgpByAgAAO97CAAWsJAIAAIANwgAAPgwCAAAcZAIAAF/pA
Date: Wed, 24 Sep 2025 14:14:11 +0000
Message-ID:
 <PAXPR04MB84594DDFFE47E67552718F77881CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
 <20250915-clk-ssc-version1-v4-5-5a2cee2f0351@nxp.com>
 <5f508f1d-2d08-4687-86cd-d1944caa0a49@ti.com>
 <PAXPR04MB8459CE9F22CD56A9BFDB5E78881DA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <082735e7-956b-4574-952e-06ba69db41f1@ti.com>
 <PAXPR04MB84590D5AAAB56ED7E1CBDE05881CA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <c34157c5-cd13-4e85-a9ee-22446111f633@ti.com> <aNPmydbv6Xm0Tj9B@pluto>
In-Reply-To: <aNPmydbv6Xm0Tj9B@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8718:EE_
x-ms-office365-filtering-correlation-id: dc926516-d70d-4df8-8c75-08ddfb74a23a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KIDdcr2e2CFn7IfEkVzqGn1oVMaFfbvf2QatH0fNZMCrkL3d5lbg6iWx388B?=
 =?us-ascii?Q?36S7pJezpZ4V/tdCbSelLBXVrpYQz5/oG1gYS+1QLmMu7ms+XpaS4I0x9e7h?=
 =?us-ascii?Q?zAPeRH8aoDZaw5bhhw5gh2bs7i4L8GGpmYifVwjn4bn0pf6zz0Vgn+z1FLNT?=
 =?us-ascii?Q?8EXDvx+Fsdn4+0oozxVYcMSIi4sNeQOptUvbgKPkagTlnH0O3luS9Y2z3QPe?=
 =?us-ascii?Q?LXbsOwhh0YxqaY8y2vaUhmPz/cUM+NqxIEIsWHzsJVGaim925Spe5i5Xi6gN?=
 =?us-ascii?Q?d1F7RQliaxd1MC6YEBvCAu2Sz8QRIue9tyTXSDBsYZaLwaq9m9JC8pwb+95w?=
 =?us-ascii?Q?F3u2cLWPRjtNt6raEPnSuqEAb2xYgLAxiUvr+TUm4LD5hzz159LfuTlMAcEq?=
 =?us-ascii?Q?REa4k07NChchGUuT/ZFQoyEufVGVa1uOHq8OCD35eEjh/PFB/7TAdBiJDiga?=
 =?us-ascii?Q?+9IqwaitI/JLbbq2W5+YGQgKXOs53xmi9JGUbzJ+MYTMG3r+uytTv0uaXUEZ?=
 =?us-ascii?Q?IdKd21/qGrYXl9SaqrnI1fbAqgu9U4BmjqgX9ixKY/lXQRkDqoci62zrxpBZ?=
 =?us-ascii?Q?SN5jdogKWP8oIWGj0QOYfpngsOR+qwlodi3MheEM07yfEhfdAZzwW9V8f15b?=
 =?us-ascii?Q?mq9ww6WLp7Un8o6pptmu4q4h6F7Zor1UfxykZDY9nGq0Mw+6+4m553O7XAqk?=
 =?us-ascii?Q?Kp9YDXeups0B/LuYnotqn5BNUBSl6Z5tZq1uGVMMm0qXXnZ3eMXWo9ud2hQ7?=
 =?us-ascii?Q?nLi8uH2Y8a5IQDe8vi8oy1IlUmxnMQhluiKcawWpc/8wZCQHH8Cb5Pga3TU2?=
 =?us-ascii?Q?W5JuZdULfINRUtTbv+NpQgl42ojGmcxygg9XZKOLczd9bg89ArKcZ+ixOWJS?=
 =?us-ascii?Q?vq0yAhYa60whOuiXwAtQjWpeNxy+nXU9LUwR12kT4ls0IRxInNlgjNIJkB2A?=
 =?us-ascii?Q?5xp1Gb34iAr7BD8Dc41mnAQz02VyMpejaZQALPkeooit6eOBq7CLgs7rhNja?=
 =?us-ascii?Q?DBE8j1fqhGaEKjWS3D5X1jCX6k9WwO0FcGNdAzcpLqyylADq2TpBYnPXVB2O?=
 =?us-ascii?Q?5FS71w3AM+k9k1tSt8uuJTRsb/kuGFgDts6fN++qWd6IW1o55KR3qSeZoPzx?=
 =?us-ascii?Q?LDLD066XFBKcIYGEHulZ7VO1gWlttfDTenwCz0g2flJXe/7Y/jLMm+Fe8jvI?=
 =?us-ascii?Q?mQUVPNB9kmCjjKwbrpzTFj09AF5yuZOtv3/hKjbBOuOwRuhW9W43V7Kq9/Tq?=
 =?us-ascii?Q?1g976+Yq/bYZIqT/9dymoPC25qEuHoWOcZ4YSYHRfyoVygiFzUvX10c1K/28?=
 =?us-ascii?Q?rJcev/gzi/pTufv2aEEzT4Uk39ZnEn5YsQixCS8rs3Rr9MjACZL0diYR6Cdq?=
 =?us-ascii?Q?pBTGkuVK5D2g/faOmc5l3czrsL1egYa5t7zz47Wnz6CskA6D1ZSfDjp31AS8?=
 =?us-ascii?Q?OqODn01cctzh1zwBDSirs57L/siQQ0yaeRY/O9fEkFf1+JH65r51JPEPwGDh?=
 =?us-ascii?Q?FGu6kbtwxn8sjlM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CvYvFyB6h+t4G/ARSVwqjR4qTtxp4I+8GNQq00B88hH2MRaVDkK1sXGIJK47?=
 =?us-ascii?Q?5Y20GSX2MX0wfHUs31OyLBEGU3DQyb9h8xAGpyvtMbDzdaey1xyXQHfYUdSE?=
 =?us-ascii?Q?/JmpgbMIl0WjW3fFr6VCyGPJTfyxfD3pG/QU1UqD+Wbkz0no/iqGS+rMNfGk?=
 =?us-ascii?Q?CHNG85rnBlwU06HMGb6R1C2ryealLZjegAvv6Gi+nnaBogXV/B8ozalH8KSl?=
 =?us-ascii?Q?12FcRZHR5qHuUtZTZjjvtwWcK5uRezBuHXA1dsA/2W8WL03FVslJIsod6mIo?=
 =?us-ascii?Q?FlRHQQNMivLCzGyBfAdmfmVSn42t19Dn2VijtZUVJMlOsDE7u8jJPahb5cFg?=
 =?us-ascii?Q?hwItYrafq2ZAKTAPRjY3ftMnnOaoUhPAuS5CFX0MaoOGh3/WS53WA4emDZC7?=
 =?us-ascii?Q?e5jtuPXRUVxSj0JaI5wzpAbeoHaB2Q77gJKWOFwMtOVYDfp3lE4Di9pN2kJ8?=
 =?us-ascii?Q?8pChoiglZH7zNYpsl2o8xEmkF5ohS6zovUg0QHysYYjO/VQGqhA2iVzJljcH?=
 =?us-ascii?Q?mSmmCaqMkEUnrzgFpZAhFpTSPoD7HF6n/zAOyeEW1Kc7I+kGEyJzZCQIMs7c?=
 =?us-ascii?Q?vPgpFRjdErU6BeiR3er6DYwSPvMSvCs2EvffaFN03MojGYamSsUUWzg84a7l?=
 =?us-ascii?Q?79xVRVxqtBtIMsTtsDS7q7XCOlmjbSScdkw9+7wN3iSR+wRSc5gd9bhcVbsg?=
 =?us-ascii?Q?v9QhfYiQGbHUdSxNHEi03EG7JAQhL+yIwJNSYUL6DuIZBgKB5toUBzO84X+K?=
 =?us-ascii?Q?3qII5i/GDPaO9rS06g70uSjDT4oyUdOrsOIemgp+QETx3/mMfpPxuet1Fhs1?=
 =?us-ascii?Q?0EbC1mGOEYkAU7OxZNTyL+xHZgwpB9/fs5NFUV2EbG2x1ncsN4FhXO9dwH08?=
 =?us-ascii?Q?99X1+wRq4NZSPJM5+gJVVvsr4kBvDvbDY6QlJ365ZDnKaPCnX8Nd2l9e+t8E?=
 =?us-ascii?Q?p+DC+R+YEUjNOXkaxBmd+ZDTFB+X+wReIA0xz522UA558YkswhiGshauGsQP?=
 =?us-ascii?Q?21BifwsBZ9YS1zMsZwVavwe0gblb0inesw9b4z4B8wUtQDHZPPx/Bl105Rtf?=
 =?us-ascii?Q?ejfRUcCD33K3hrpPun+DnIr65lnww3wxJWOogmeW6ckJLmFoNgvbyI14fhke?=
 =?us-ascii?Q?sd69jWBLPO3GA6choLRcB/Swb+VboH6H48Adg2yNZSL2zK/bKDB6hurr0yWx?=
 =?us-ascii?Q?TxucmAKDLKwmBXQH9Y79NScNIvYi2XYFGyJ4C9L15FLTmZA9u1nmUFol8p6W?=
 =?us-ascii?Q?rmmc1gI8s7uE4oujzZT1T6s/S4VQsnxKVF+HhqlW2NLkvlFKdRsacv87bWx1?=
 =?us-ascii?Q?gYgho/09a6Zb926fGnhD0mrTvELCz8kUYYxE8md418ROB7csY2R8j9m0A8la?=
 =?us-ascii?Q?jXEncuIoo2JbIIB0ot2rLNowoHsLClocxuDTBNGCKCyo3LssU7jg4lJ/0a6b?=
 =?us-ascii?Q?X/efnmaAXZLXlsOX09kKBaRkxUHxVZQM93uAEU0JaZTBCcCucQdiQewf5yxy?=
 =?us-ascii?Q?YVd6/qSFIHBwMO2qRhN8p1q9wn0vzzCSCFuf+5VYZ9VgPG5OMYUNVaUq+DSw?=
 =?us-ascii?Q?WOvN2O4W2m4KYtjnjOg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dc926516-d70d-4df8-8c75-08ddfb74a23a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 14:14:11.2446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 35zVaSG/JvSniGOtAsRcZFQGOt+Qz94BLHh++wXEz8w9GNDGdRf5fbEWTSe+9SdyNvnGm6VRdhVHdVCBVqLknQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8718

Hi Cristian,

> Subject: Re: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for
> NXP i.MX95
>
...
=20
>=20
> So yes the ideal solutiomn would be to extend in a generic way the
> SCMI framework so that you can add in these cases custom handling of
> vendor extensions for standard protocols (and then generalize the
> current clk-scmi IMX support and add the new TI one...)...but I have not
> thought about this and I certainly dont have enough bandwidth now to
> work on this

I see. So I get the point IMX SSC OEM is allowed, but need an elegant way
to extend SCMI framework or extend clk-scmi.c in an elegant way to make
it easier to support other platforms.=20

...beside having already in the pipeline other stuff/fixes like
> a proper fix for vendor drivers coex like Peng askes (rightly so a few
> months ago)

Thanks for working on that.

I could continue give a look on this, if any suggestions, I would appreciat=
e
that.

Thanks
Peng

>=20
> Thanks,
> Cristian

