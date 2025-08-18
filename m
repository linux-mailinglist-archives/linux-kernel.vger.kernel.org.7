Return-Path: <linux-kernel+bounces-772941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E775B2999A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68B8B7A305B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA7B27466D;
	Mon, 18 Aug 2025 06:24:00 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31658274649;
	Mon, 18 Aug 2025 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755498240; cv=fail; b=p4eFNggTT5lKwH3vAx10tQ09Emz024xpVHrh+czKPVf331BtdxbMky2sc4EMUedkXqidPBL5NJmB0oUP0AT2kVGX46whYGMYmFPgXaEvWE5EneIdOqBwXKAVl9/giusSF+s1A4bWtHAtChAMPKlpBa8LtvN35r8GCQBQEfJpY3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755498240; c=relaxed/simple;
	bh=us/elKf4I/zHZYKSy03Abl/FXdVlEJMeMif9HnsygHs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dQHwitwEe7J/4x/vjt/86iBADQzBSSLi1hxb2FP5gV+JilU4d4mUkFnEYVKS/3Te06yNprKTmm2sHWg6qBXmhMDioTUXJFFys0QElqE3J5rv6B+/QRdHaevpSZm6suKU3vB6HSuM+hWScoqUfNmK+8/Avq68X4FSEPfFnj+oE78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKxsscpU0CCsuZ6Hjg7AB7ypHJXUs+AHB8ZlVerjZ0RFnJnVbuJu2vvWPWHw+doZp+aYLICYrVqP9N2GYjMJMGA3TjaGxt1iue+XNoHsCvhWf/Of1Bc3sJG0tEuZ1WF6Ztf254HLNP6tiOw28frckrEqg1L7nEk+SJ1g8Hf7ezzRkAUEoiuOUarkG0f5NtH61OSwRbdqwdZLNMzIuNMvc3+E69hcOQWpMIYpZFM3FvfZdn1huRhOwZA+knmw9zUt/VK+dXNej3MiZUKg0nWHmShrcq/XSO9t86liGdS354W2NaVc4QjcQfsmnVb75TJRW5x3uhT0bW/QHDONP6sJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fitEpvgShXGLdAJ61X5Wk3M3JBBS/wP5ohlXY4R4Q/g=;
 b=ISTgoNa/AAYaD1TQ2fDgUMWjXyTxeiDGT+vxUDdxpRRWO7Oge+3kMpTM7fvpRyKOY6wiSdm1O4XOLTmUTZQ1p88FTfFFmbsvxiG1qOs9Cnabcn10tK2QTlvNQ+zAFeV7m+Tk0y+FN/j7y/p26MpyCjupkEwAm9pS29mOyJuY55FOJEkeFWMXu4sx9YMqgp6nBmkY6r2FiH8y8iUsuJX5SVu32nwyvgza81N3QzFCGgus9pdxUswkURv/0eCtuUg4douuIAG1LyhRuEnP3SaEqIV/fS5+E131TuR0Qp4rsDnrz3hE+O41HDhfW89nraT4VXfCrqADY1D6YuAg+wd0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1244.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Mon, 18 Aug
 2025 06:23:43 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:23:43 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Conor Dooley <conor@kernel.org>, Emil Renner
 Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Minda Chen
	<minda.chen@starfivetech.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v2 2/3] riscv: dts: starfive: jh7110: add DMC memory
 controller
Thread-Topic: [PATCH v2 2/3] riscv: dts: starfive: jh7110: add DMC memory
 controller
Thread-Index: AQHcDbfYxH1ag1jnT0auH7pULaAKobRn8yww
Date: Mon, 18 Aug 2025 06:23:42 +0000
Message-ID:
 <ZQ2PR01MB1307ABC4F86CBFEA8E73D3F7E6312@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250815073739.79241-1-e@freeshell.de>
 <20250815073739.79241-3-e@freeshell.de>
In-Reply-To: <20250815073739.79241-3-e@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1244:EE_
x-ms-office365-filtering-correlation-id: 3c4f18d5-312d-4e77-a424-08ddde1fc798
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|41320700013|366016|38070700018;
x-microsoft-antispam-message-info:
 vLLjx5FDvlsqz5WTC4sfrvlLjrOjdH0BA/ViupLJrhPCO5b9Qf9NGSqt57KlSBLHSeWSV6GImzsBoM0VM/zASZ0ByNGzuq9on1MzZL6RHF+dF88tovLmhe/hpLhdkqrspRboCaByri2SRLp9sXfraoGGMvmLxklk5DnuYiC/Znu0Br3Cm1Utdf5Bh3XJ8NDJWM/UKh/fNez0gTIt9f02EXugysQT2kCQ5hKU4wp4XbQ5AKo6/35MH3+cYLDO2i2TlEoN98aLqetmj0M5PhcROpj6TDjjN2OnbO84U+HgTXOTh+nOxVJooLjT/NYN8bLU3M87MAVJvs5cvSNagLSKZeLZCc1wvg/yX9EIrQno1fJlRM5qZ6F3Vsrhs2cNC0OxU9KS33iEOveoYvXlTk40/8TtdyFHxSWw9wNCPrMzuGHPDXbI/cspg8iKiMReGvnZ4rDNOMpyIh0KKr+DEQV0VLGrA2dPo7tximoExGAnbeJj6LtzQ45hkzxvAPJRDujP1eJoAEfpnZxCyEfLVQPBiSYDYNualEuzA3U9EHFiE//iO5aKlw3P0B6yf4Xawr7oxNc0/Z7q6HfTedbdxrTRwJg8aLMDDZYn3COFwgcUYDk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(41320700013)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jpmD2HDKB5QfUsephWYdVKDM79ppnKrTY07S7Sv9u7Egl3HHYyNwYS9bUUoA?=
 =?us-ascii?Q?5CQmeLPTV4uUb+4qJv47mi+S2MTSDd1OPUejcS2w87qfWXdJHqAVOlhHbfC9?=
 =?us-ascii?Q?kdQxHpSHzI8AdhoPH+t3K0Mo3h4YrBqSKXkduIY6ErI6ofj2bRGYIvDXx9bi?=
 =?us-ascii?Q?PQpw1Y+1KEmG5CDr8UoGHggXV7WUPmYrmquHTgRa9Q0B2p8RKFLRd9s6a0VS?=
 =?us-ascii?Q?odQLq3fh+FhijFWk89YNpmBNn57fGwce2l3m3DSe0eSrDM3aAE0rH2tghAuH?=
 =?us-ascii?Q?+33Xa8x8nJ+CxAGAZmKG0gOLn5BywUuNBQUNg0NmdWwpFwwJXG0o2AuoazLb?=
 =?us-ascii?Q?FVDe9iA8cN0nnEMNCXBz7Zuo6y8yS/8KmW944VJaVyKDxyzw/2t0qfz/LRcx?=
 =?us-ascii?Q?1bP2lktfihMt6IJzBzA0HwAKc7svnpY/h4Rx7AntllVAiJUq5fZKtWSjerde?=
 =?us-ascii?Q?OrHAZFwjYbbKSzPD2Grkr7M2DLiI3t3c+mceV6937DTS94XOBSjv1bwlmYNL?=
 =?us-ascii?Q?LXwBi8mMyjprRx0P6+ruGBD1nhTLsljkSDBNASrftPxwFCN3RszvVCcDe2bQ?=
 =?us-ascii?Q?F5hOfH4Q97NfGGWPqpb0uIp7yz3R0duT0lFlULV2TtLrp5zVoJq9I3waI7b/?=
 =?us-ascii?Q?S84L3XZ1D2G92odhRN51Sm1yNzLQ5M0B7rFvAiiQj05MNrZkf7wg1e06w6Xa?=
 =?us-ascii?Q?2NC4GTE38846l8qmM/s9gRvoA9Q6dznS0NBkLZOOcDtsu0Yn4TieqR6Bu0Et?=
 =?us-ascii?Q?Oc2LVSr/Jy7hlVx98RMFINe0tYQ348JkSORIVs1YkIRu/Ihjv8tiSimff6YU?=
 =?us-ascii?Q?vDJsZoWs50ueNGpmPDLSRSZt2iFRToMreVqsyvw2HiBfAJ33ykel4juuTRey?=
 =?us-ascii?Q?SNe0LWLlYIx+pPtG821ZyZqAeFlqDY4QAP92m9lSLndze00xeJAIXZjnKMs4?=
 =?us-ascii?Q?yjV2ObxSydmMmZbF/i7N66IKNn5HEdv1J4GLNKtNVCBdZnBFmB+qzzWdV6BT?=
 =?us-ascii?Q?u+z05R2SmtHGR5YkCQ2Jf6CYCl6KecYfYZ6qUSCGqKKWcVJeA+k2oQH64VKu?=
 =?us-ascii?Q?seSTtCQa82HC0GvJdA1iNZz7z0qTG0Tbwml4fNZdpl4x321Xaont7gEdwkWI?=
 =?us-ascii?Q?KZIgCaq6+aHi7Ox36/an/JAVvCM61Ua0nJczRIVGSZ4IxXm1aItp8Pcudrb2?=
 =?us-ascii?Q?ARiqVRoqsGeEBvKIQAanNYYIWfWdVnx2r/Q0E5AAZGU0O1AuSIKsRYkzQErW?=
 =?us-ascii?Q?PHxO6O0d0IQZN7xYoKzik1NRXQ255ghEp2D+qjM00Lf4lyf8y15vKGmMr7W5?=
 =?us-ascii?Q?K7eUQaMzXu/lhfks8zIf8yV1O1ZasWTVBpuGtPHlFxK1tEsoYZQ+9jw9wYLO?=
 =?us-ascii?Q?b8OqNsxIdEGtFf2+j2ZVGegJPteG4IXGCzd91ZYYh+9AZkgWWxA2kIFJ9HwH?=
 =?us-ascii?Q?Y2ArM5I2JbScBGKXLzS/mnHrrLI5sgKEjFy4nUI25O+/w5MpKzlPPP34crDV?=
 =?us-ascii?Q?2vhsH3peMaQqy8cQqIvCElDwXYAQQl2TP6DyDkRshE2dwa5MR0ShD9Qy8cdj?=
 =?us-ascii?Q?MmODf2uicc9/66f+wWkTezOXcfnL/YQ3bNKuatPvBuphWOYK5tEanK31idxS?=
 =?us-ascii?Q?JQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4f18d5-312d-4e77-a424-08ddde1fc798
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 06:23:43.0040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ey7TFVTzACh/4YNlg7f5GrtxPW5bMZjSrRAb8SHiYt3cspuXC8J/m6og5X/cDSniv6AoWcmeuwSXykjJ6zrzcfGr1vqk6AYufK+J4QfqeMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1244

> On 15.08.25 15:37, E Shattow wrote:
> Add JH7110 SoC DDR external memory controller.
>=20
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 0ba74ef04679..14df3d062a45 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -372,6 +372,18 @@ ccache: cache-controller@2010000 {
>  			cache-unified;
>  		};
>=20
> +		memory-controller@15700000 {
> +			compatible =3D "starfive,jh7110-dmc";
> +			reg =3D <0x0 0x15700000 0x0 0x10000>,
> +			      <0x0 0x13000000 0x0 0x10000>;
> +			clocks =3D <&syscrg JH7110_PLLCLK_PLL1_OUT>;
> +			clock-names =3D "pll1_out";
> +			resets =3D <&syscrg JH7110_SYSRST_DDR_AXI>,
> +				 <&syscrg JH7110_SYSRST_DDR_OSC>,
> +				 <&syscrg JH7110_SYSRST_DDR_APB>;
> +			reset-names =3D "axi", "osc", "apb";
> +		};
> +
>  		plic: interrupt-controller@c000000 {
>  			compatible =3D "starfive,jh7110-plic", "sifive,plic-1.0.0";
>  			reg =3D <0x0 0xc000000 0x0 0x4000000>;

Nodes are sorted by reg address. So please place memory-controller@15700000
between watchdog@13070000 and crypto@16000000. Thanks.

Best regards,
Hal

