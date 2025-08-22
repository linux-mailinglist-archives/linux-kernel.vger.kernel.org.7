Return-Path: <linux-kernel+bounces-781294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A8CB310A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34058AC841B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7555B2EA17F;
	Fri, 22 Aug 2025 07:37:46 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2100.outbound.protection.partner.outlook.cn [139.219.17.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328292E5432;
	Fri, 22 Aug 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848265; cv=fail; b=tdGGrzh8/KJH1Mql7EA50Y5kEMLC5Qw4UuEoSxwejEwJJhqBW1WkdEuM+7kkXaltvQo9S3ohgy0ebD5n1uh9x3jjTTpyJBz35XnDYnq59oAXaFV0IhY/BM39Slyee+QuENDDlKJAY1QsCTw4Iq+Ac/7s7H9N78wZjJWSYTa8jKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848265; c=relaxed/simple;
	bh=DUkcVt/Qdb1E6om3PhVptTDDdTlf+kxfbCnWSS/9sDk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hPKzs9Oupu9m1fVnOje+VSOH1VIBmBj3+8+QGSAjwfKg/B6wmb1loQ1ugIBfLxgP49njTtxla0MZWqLuxQjVOd7IMVIF1z9zEMOc2QaHLO5yZ6pRXc9OJmJdnxi78Sc4+hDkmgE5+XXgDmM1DHLCKxGJPsc2hpmVIEe858G7x3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+QsuWYu96IcYYZFqRXuBz/w6V6M65WeN0RWDhxUggcxLLZmPMt21+ndhLrDCUBINZ5rHUUQHmC/VZLrP293vPmOpmSru0n3iZL4K+EdtADO89nlCyFfDLYzhk8Qml9ic/3ru0x+Ey1QuvbLFsxbCu44Uigfqqete8ZiKHGq2Cq+bI6rN8NqpAc9SDqHFP/AtHZdhJzWmQEvb7BNnEvjW10P9pKIcT8dz1Fwqi0dGkO3d+2bUWjyAt8MV8nH4Zw6ivr3X+AjyirEHeRvGRq9SXeAVo+m2oj0KMU6HFG3AOLs0d/sstov9+LGnOdnDSiuoEkFpSybUmb40bfGThsrPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oz46rODv3zrUnfE4RZmC3CaelLXPJwS0aNM2pcx8MAQ=;
 b=lbM6OV+NL5xUlPBwv6UK033AHKufimGY3ryirmmmH4xGyBnrB7b2RwCWrMRGs62VC5M0OnPn9vYZfr7PIrjeMvisLxQTZUt8gj86CqJQ1wKm4EGPrfArrUw1+4GHbmIwhRcs7HJd/ni26zo+KCV+LufKXF/1I+FibdhV3KjCE9vF6uZS5KeH96PFIqwqKRiaq3yu6UGXnujgIJfkF2Akrm0Y4vy1n45WPfYyNQt6Wuj43lda4hukh7dmYyNeTUw3IcsyrxQUO5wXDYAh/eC6a6uZQkE3xAXV5EmE37rbhVbYcZZ/vvfw1XWtpt2FUXTBUTjT/vfYjC3fXZ+Vxr8bag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1324.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.29; Fri, 22 Aug
 2025 07:37:30 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9031.026; Fri, 22 Aug 2025
 07:37:30 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Heinrich Schuchardt
	<heinrich.schuchardt@canonical.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 1/3] dt-bindings: riscv: Add StarFive JH7110S SoC and
 VisionFive 2 Lite board
Thread-Topic: [RFC 1/3] dt-bindings: riscv: Add StarFive JH7110S SoC and
 VisionFive 2 Lite board
Thread-Index: AQHcEoPRMcVk0PpLJ0SdIzsLiWRBo7Rtaq2AgADIPAA=
Date: Fri, 22 Aug 2025 07:37:29 +0000
Message-ID:
 <ZQ2PR01MB13071F6F2732451DBE3BEE9DE63D2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250821100930.71404-1-hal.feng@starfivetech.com>
 <20250821100930.71404-2-hal.feng@starfivetech.com>
 <20250821-pencil-anguished-6b8467adbd38@spud>
In-Reply-To: <20250821-pencil-anguished-6b8467adbd38@spud>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1324:EE_
x-ms-office365-filtering-correlation-id: c995247c-6e37-4b35-5cbd-08dde14ebfe9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|41320700013|366016|38070700018;
x-microsoft-antispam-message-info:
 kPhOmft8HW9znV3Zvl9X5M8shEin8NsNe3k0o8U/jkro3adx0WSeo9hOLq8lVo4olSGQyS9zUW1owdkXBlXjHDDhc0jxo1pA1GaROUYEsBzHrFtV0kotc/+itYqoSftiJFMpsHWTckWFsbAQkj6e/5RVgWn3wZMWfQQ52DhRBOXn4rGdwlMuRhXpa4NIrr2lIG4d5Uy6BBxtN/a2T41HhQUUw33ILbe9BvvXYYwoYEAg4k/gD+b7nkguIFU8AZrC6oQQzIN2mtYY9A0NtFhE5ZtCCdcAvrFhU8MI6SDvDa9AdxAz+T116AyJjQgBMSoGj44zXp0dnp7BHLM07tI9hf0J4whbvF6VDzBDHTitvMVpPIaJmkBGMil/9Fk44AsNyvCjxYFY1Y4fjVMtqyZ3/R1LtCaQTeQVn5ukysF5OqcaJVQmU1Q5mqeue+AOhfyIpBcZWKs7fqqni/if1IoR2QX8XMGTV55cD2K3ri0uxvws+xRtI7jZjSXsd4KvPepNcl1tS1fO/gT6trWMVfSL/zl2Jv381lgqWvWNnRqhVdydeDigsJOrEzNAFRiQnafpc3zgLzQypmMu1s7ENZA/cE/m80S2Z8n583eedbc8xXM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(41320700013)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+j5k5X+h/P5acdPEaKgENspJO5ZD7yWdY4irQgzCvHIxgg1+eDcIQcBdMHUv?=
 =?us-ascii?Q?V6cTp+0JErJ07RVW183IA8MsBwgp6SZH4wrhDMaD9bk0OE3SEITInZ82GtT1?=
 =?us-ascii?Q?+iMO250OkmTP+/2QRLyFMfK3a7bIHDuvxb+LuENAsrdDePGCsQ1ukW/DlNd8?=
 =?us-ascii?Q?tT0kUj6nDm6hmMCUFrUDeLMENfkKctGZ08f9ptbIpUo+75J4yULw/VuMkQd0?=
 =?us-ascii?Q?JeTd5iBp9ce7WUABxXpn8YC3mGp3m3TfgissdwffB9BHmCucCq4EI2D6QMns?=
 =?us-ascii?Q?/I0JkU+hU5bImQLEFn4wGj4hr57MooLdxTJD9hJOOlWmJoN3inOij4IWBwIW?=
 =?us-ascii?Q?GxF9OwppYWD1MjjjQ9v3/kEmk1G5QuLDjiZb0rPIjI+f5N6Ax0g/WHaYsnQA?=
 =?us-ascii?Q?6aRncx9oPDrztGzAWD7xBo3qSllU/O34SyMOSnHPRNXN47NLDNN6MHNKN552?=
 =?us-ascii?Q?mrMImbJmxEg4YI/NfuW8IC36nxpNPX1UBWC+y06kyzwc1e8Rg+QOMqz9yIMc?=
 =?us-ascii?Q?P2mp1DLgdwIHtZQEl1JyZ5E6i+1rnUmJj6TucRKsnOibXtC6T5rr2A/abiMR?=
 =?us-ascii?Q?KmiGrCsmHou9BX4nok2rCDw5IRC0F8GXgMJZA5UFC6XjoOrvOsHQaXI7b8gV?=
 =?us-ascii?Q?DMcHJGqkLOzjy742F/04amR85p9bKJCR8+7h8BHeGPk3T7iiYhTIz4+7edec?=
 =?us-ascii?Q?7WIKvAfKVxh+NVms3oXQWq+pjLdNRUPLdZhORaS8VqaSuVRTbIl7NMRAx0Jv?=
 =?us-ascii?Q?Fi3wy1sSxPe5NrykTzQQ/ywI0sG753cdG46oMlFEr9aKoL4NP8foCMD2pvSB?=
 =?us-ascii?Q?ONQJKmXtq8XZeU0jHe/n4jthl2Nfp9HFra35ZJ6wFqjV8gIzBJujXGYDGVcq?=
 =?us-ascii?Q?AP4bHfwI9O+nw5ytz+Mh7y9yLG9NYlTBRBt98D20gar5GgfIW6JBf5wQi4Xo?=
 =?us-ascii?Q?HH5Af9qYNOALhSS58SIijHl/eOlee9x5c94rQE7qkvDUwSn4WdcdTneYEynj?=
 =?us-ascii?Q?f3UEFztZO/Q7cA9IZgnBr2TzAdV20U9HhR2y8Y3xgKtesy2sVUOobHcUUjMm?=
 =?us-ascii?Q?s3S/c7H6AXvql7T30S2pkv7mm1+Yanh4Cn9MiWla1A4keKZwB7NivAM2r+uR?=
 =?us-ascii?Q?yXGnRMbE461cieupT5W94iwUZM3d4jp97kQvl98/7S+Wj+a474HMQGg9Q9in?=
 =?us-ascii?Q?A2I3zgfwIZVKdaNvucOJTny2tJDdeI1UqoG/OjAinEfuo8r5M9HVjMJLVgls?=
 =?us-ascii?Q?BIiw1dYADWZuxifwD1O3uEGEWA4PvNrzsJHF4bqoS0eA2Ksf5KtGz1qcPQBh?=
 =?us-ascii?Q?fel1IhJ6cjIg2TiICAF6Q6NokUam91w6sifwu/v6cuAezi/8fBMZCQKGct2t?=
 =?us-ascii?Q?/syIMrYR9wb4TZtu7VtHjgBO2qJgJ/rveL6Sy61+BJ7vA5VQEhXc/lIQqVXk?=
 =?us-ascii?Q?9ZV7vfg/UKdYPTJutpW6XuRef7yyQOjzy233RqweVhl80zEdmdPL+Il5gle7?=
 =?us-ascii?Q?/evwHNAkuORIk3W/FoedpU0ig0TuNaeMUqRR0K6LRMIGXuXnMy6Ku5fYmyN+?=
 =?us-ascii?Q?hLwvqPL5BzelGkfUgZvkj/LzTlTA11QqZkNCjPgV/0Wkj0abaY4VW+waLcEA?=
 =?us-ascii?Q?YQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: c995247c-6e37-4b35-5cbd-08dde14ebfe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 07:37:29.9655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQkqaUOU+A6AtNP9DFSb46AE8KE1y5XBsP237zKVjkaru+X2AjkESIYEkrutA7CNRnzxxHteqRHCbKPkE4qA/7s8k5ljH52/c9qmMevEFsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1324

> On 22.08.25 02:17, Conor Dooley wrote:
> On Thu, Aug 21, 2025 at 06:09:28PM +0800, Hal Feng wrote:
> > Add device tree bindings for the StarFive JH7110S SoC and the
> > VisionFive 2 Lite board equipped with it.
> >
> > JH7110S SoC is an industrial SoC which can run at -40~85 degrees
> > centigrade and up to 1.25GHz. Its CPU cores and peripherals are mostly
> > similar to those of the JH7110 SoC.
>=20
> How "mostly" is mostly? Are there memory map or capability differences?

To be precise, the CPU cores and peripherals are the same as those of the
JH7110 SoC. I will improve the commit description in the next version.

Here are the differences between them:=20
JH7110 supports 0~70 degrees centigrade and up to 1.5GHz.
JH7110S supports -40~85 degrees centigrade and up to 1.25GHz.

Best regards,
Hal

>=20
> >
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  Documentation/devicetree/bindings/riscv/starfive.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml
> > b/Documentation/devicetree/bindings/riscv/starfive.yaml
> > index 7ef85174353d..a2952490709f 100644
> > --- a/Documentation/devicetree/bindings/riscv/starfive.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> > @@ -33,6 +33,11 @@ properties:
> >                - starfive,visionfive-2-v1.3b
> >            - const: starfive,jh7110
> >
> > +      - items:
> > +          - enum:
> > +              - starfive,visionfive-2-lite
> > +          - const: starfive,jh7110s
> > +
> >  additionalProperties: true
> >
> >  ...
> > --
> > 2.43.2
> >

