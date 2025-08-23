Return-Path: <linux-kernel+bounces-783292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B4BB32B64
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 19:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0822D7A36C1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E842E5B14;
	Sat, 23 Aug 2025 17:50:58 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2125.outbound.protection.partner.outlook.cn [139.219.17.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF2920B801;
	Sat, 23 Aug 2025 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755971458; cv=fail; b=WwO/V7sWOV33S3lK6wPwFhqXXJSf0Fs0bvOTSl6sI2TL571ALfWEg2M/Lx7wjpySSN41O8DFIGDaHNM4HJFhdKSPdvHn5eMmSEesC6Eee/omD9Vc6VrrcJZolO/dDQPWJer+aUSdDFjISc8e+jZSP++pawiEcZYJODbVAAzYRZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755971458; c=relaxed/simple;
	bh=AyCeLWiMku7v9iWkYnGqi80ibZL8ViH6Is6RPCBUNb8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=erxcqGIYBsIQ3UPbGRMDaX9x1xyD2sKBiTXOMEd6nZn//31F3Dyzw04064FnTCurhO9CQ88e/t2x8/Tdw3wy4X6Omz/BPkMNK+8dur+dPzozDZDYBYE5YCwGpVp/YOKEgNZuEtuM1vyoLxDdquNRjvhpM+6qAVjSFXFcNANVyxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xowu1I4Y1wZxR6sa7+ZCinan3WbLIIB887kFNW+PhOt5Y0VKxF0ROZTZ9Yn2+Y+SRdSxQhg3jwMShamh0Uw1CcH5hXB0329BsfLLzYbCRw2JtMRFBkIXJsdPk3RHYV6WP39FjXUlZ9WGGVhSutfHuOJRj69boUXWdvxiWr5/hHnxk009d4v/p9mDD1N2kZh9ACIvKfrd3YpyxYf/2xvcbEhotSbz2tMnudpYSoGifJIA648mVUl8RxAsVm56g3rSa+dZ3THgUR+7oJBF2R48ZrfPhh/QYjhbIyyt9qeoJBbptuAtdBoMnpRvYxCEHe4IlG39zSzTpHnxln9ncV+Jfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQb/s63SWWkJpTT9zSj3PvHphjVEAQauNL+M/cmO8nU=;
 b=fDvjlAIESJ5/1TwY7KRRHdsg8/Z6HAmMblWP3rXbFUCZbImoQv5tcbWBepCZb1KcJitmxtU3i5FXwtENcURyyKVEtZBtg5OK3C9vtZYIy6DcI6PQynB742wjQdC+v60m6yC8XLC3FfehXe/uzCLMe925RKjz6Erj/XXz8XXGne0yygLQPGg1XTwd6FXvHwde1hR2nbgvBJUCTsEYfZhzSMyyclhhCVrVxyHZUQAXp7kfQFel/9pYs5MlWpmkRzEdGLuBnZI0kgUUYysZxAKXWH+4Kuo+f5MEXu2Zzt9+OqN1SgYBgBL8LviDKM0L8Mwwc7IqvppFpQgHpIYgcvEBIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1257.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.30; Sat, 23 Aug
 2025 17:36:09 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9031.026; Sat, 23 Aug 2025
 17:36:09 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Emil Renner Berthing <kernel@esmil.dk>, Conor
 Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] riscv: dts: starfive: jh7110: bootph-pre-ram
 hinting needed by boot loader
Thread-Topic: [PATCH v3 3/3] riscv: dts: starfive: jh7110: bootph-pre-ram
 hinting needed by boot loader
Thread-Index: AQHcFBUwxbTSpgwK80uhPwpdWrt8a7RwgDYQ
Date: Sat, 23 Aug 2025 17:36:09 +0000
Message-ID:
 <ZQ2PR01MB1307F15B7A9D4E8EF6319837E63C2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250823100159.203925-1-e@freeshell.de>
 <20250823100159.203925-4-e@freeshell.de>
In-Reply-To: <20250823100159.203925-4-e@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1257:EE_
x-ms-office365-filtering-correlation-id: 1e646d9a-56ea-403a-e2e0-08dde26b8c0d
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|41320700013|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 uM6iIpqFNuUhfPRjZ8tNIVvdTWoSIvxP6/Ix63CiGAaX+e/E1ISdHThYqtfTjEAbdEZlHBKC/u/aDajMJp/qLqpDXgahNasuprsD7tsRyLuU7XZ6wTvtrhHnQk23q1z/yikd89ZWIjeLIPT8cUdkJX/LsEEP0Q2gUyoMHEVr8Xr1vmMk2JQImEk6w4FSDoONov385NmF+LvrFo+LDgJ3SfoOAuhZ4twXvWS05yWjduWtWK2MbVlC30CMNEMjNLF4aLUGYIU4JhXn9vtYic9jYcuemR1vWKLuEVG7aN8MaDVoLXQ4YoYnnp1+n1cfTfwoQSj2JFcEeRF6xxhcjRbRAwAPmcL+TBm6MJrOX7Th5rnKaeX6vBOYfcr/ElLd8AdTxgxkhrTF6TCVhNDjxSJVValJWoISIPBzF4P8k1XIXXyesdDGNHD5e+QMZjX0pB7IHnDk3unb5upTd5E5wpmXUgxiv1ruLP02Y2hv8t0PX6pgJuijgnyTE9+jBKUx3jZ6VHTdeSjmiURW7iteIe2027A5DJJGyc7CsEU/244HnUsFkuwlWdb5jjE0nsSvJGMOaa90v5jYWlcfFAOYKJdD/XoK4jUcQTamM3gZLweLyjc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(41320700013)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3sXUqG9CIZ0LXiOx257aVc3OMrgDlIHi0ZCyYArFqkq4jrReRX5pD4zS+woY?=
 =?us-ascii?Q?/dK6hOUMXZ+lsxhh41yRXJJoLuCDGz6GlM7xrJq62FolqbjfHdalZSd0dYEu?=
 =?us-ascii?Q?6lxlF0/AX6S1phB8xIXdQpzox8UrkSXnQDeoSE/TI4V5yjQsmE0+AU3jMns6?=
 =?us-ascii?Q?IenBvYgYH7q4s4R5go4dbmy6ox6Nj8Ke4wvM2FWBMuL9EIvy21LoBL3MUPOs?=
 =?us-ascii?Q?BAcjRGstbBdvYzDEyDvDAtIKvnOjGoJak1TDTUjVeKlp1ZH6wDuvI9nWvuiw?=
 =?us-ascii?Q?tibmfTJft+nIP4lVjYD6MpoAaCk5XOWZezw411n98aRlgXXGfdKa/LHaU3hL?=
 =?us-ascii?Q?X83HPhxG3SGRij+Vw2tMWnqELfmz7Oq6OJez1oCP5S53PY7crSkSiPFFuaCc?=
 =?us-ascii?Q?jKeUFCRGsoE43PO5BC3L15E5XD8Kd+pY/qsOJR4gU9pMzOi/cUOFJ11OuI0I?=
 =?us-ascii?Q?5HU9GAVPvzaqK9Se6XHsElIj/Cy61aAcL+g7VrTULprwxcNyb9uZkhpT5iY5?=
 =?us-ascii?Q?WboXDjbUtzbpkLM3kJ4CTS40iOwzIJZu4TNyOGHWfnGtv6CKrGU1rDUoARLW?=
 =?us-ascii?Q?hv72egH3s60m6vdJoypvXl7o5QbpBxBPKUT15EFt7gvVpBDy4Zeg/+1uRYIQ?=
 =?us-ascii?Q?h0a/aeAkhcVmt4ds2AHAP1z40QAQgH2PBYzpzcaDv1lGuKfaioNw9dY/5bC0?=
 =?us-ascii?Q?lcpWXLVgNwiKGtyhJnwsgqI3ZBbkYwJM1LKBORUbd1y4ixWTo64czQjKUO6A?=
 =?us-ascii?Q?I+q2S/Mc7+H5SaCjW7HjQWkOtDSCUzxm3/+8WGoAExb/0IiwjZG4QP/5Qv7z?=
 =?us-ascii?Q?VaawZiKRvnToyfreFqCqCqjaXmZ5YYecK6TMzRo/QcDuaN8JKk19RrNMYU1E?=
 =?us-ascii?Q?ABmInZAkwEXUnEDEfLMcV1kRUmXVtZiZld5kPTbC4GTFyRqrSAuhDFV4WR74?=
 =?us-ascii?Q?V426PbzxThaZpEQq58lOJEsM+BMbzatLQcER9W+j4cUnU5ylzC1cTo5yxe1U?=
 =?us-ascii?Q?6uRwGcSD8qR4tpC9TitTdr5DvXlujscyYYYR58mJeMJob6xwv7UZNSzem32y?=
 =?us-ascii?Q?+gnu03Pu4bMNJT5zAGR3MAUqNNNJ06EjtiKqV94ikXdEYjdCW++gnXEczQsa?=
 =?us-ascii?Q?tS5JTobN5h195nqTZV2J+8U8QL92YBijBVEhLwJXWKAOm0vXTBXJVXsBzPQe?=
 =?us-ascii?Q?CO2540X7X1e0vcKMD3r1aDwrA40ZOz/KzTKfaVbc3ayvpmw7CS1MFVBfAZYR?=
 =?us-ascii?Q?G5R0SQ7NZMumoLVlVZlZDyhAw1BP+nIjMlXki/yqUbMrRJfPSBeBWwSVaVcW?=
 =?us-ascii?Q?JSuW9zQbYbQFQGY16quNZ/ky1ciJglLcM01EzC6DuO3ZTU74TJpkIPD2Z6m9?=
 =?us-ascii?Q?t/Odma5xOckczU7PyvP32u6+Lnn8LVSL0hSGjkqP+eA9/Wz+Ow+FQRWbPCVS?=
 =?us-ascii?Q?XL/C06HvPyNAwthV5dMjLyxPYcrhRPIsiyVClHejAotJOp0U5O9zyxjIOXQu?=
 =?us-ascii?Q?JCDOfjXxV9r7z5G2NnP3AC8aGFUnLVaH3EY2pnHhqnqMAHuDNjQsoVwz6osz?=
 =?us-ascii?Q?P0tX/1J0vf6AY41u0XRQkCIbGb7nLusLNRSmHULL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e646d9a-56ea-403a-e2e0-08dde26b8c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2025 17:36:09.5105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2RwqBzaHnpzPMzCAqTygb7k/tQv+0uE+WeVEF/OcGGXC29/1B3apLg0d7ou+A8uoWn7Phx6hpxb9DPfgjRee9Exbb3p/wZ79VW/9HkhyA6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1257

> On 23.08.25 18:02, E Shattow wrote:
> Add bootph-pre-ram hinting to jh7110.dtsi:
>   - CPU interrupt controller(s)
>   - gmac1_rgmii_rxin fixed-clock (dependency of syscrg)
>   - gmac1_rmii_refin fixed-clock (dependency of syscrg)
>   - oscillator
>   - core local interrupt timer
>   - syscrg clock-controller
>   - pllclk clock-controller (dependency of syscrg)
>   - DDR memory controller
>=20
> Signed-off-by: E Shattow <e@freeshell.de>

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Best regards,
Hal

> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index f3876660c07f..6e56e9d20bb0 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -35,6 +35,7 @@ S7_0: cpu@0 {
>=20
>  			cpu0_intc: interrupt-controller {
>  				compatible =3D "riscv,cpu-intc";
> +				bootph-pre-ram;
>  				interrupt-controller;
>  				#interrupt-cells =3D <1>;
>  			};
> @@ -68,6 +69,7 @@ U74_1: cpu@1 {
>=20
>  			cpu1_intc: interrupt-controller {
>  				compatible =3D "riscv,cpu-intc";
> +				bootph-pre-ram;
>  				interrupt-controller;
>  				#interrupt-cells =3D <1>;
>  			};
> @@ -101,6 +103,7 @@ U74_2: cpu@2 {
>=20
>  			cpu2_intc: interrupt-controller {
>  				compatible =3D "riscv,cpu-intc";
> +				bootph-pre-ram;
>  				interrupt-controller;
>  				#interrupt-cells =3D <1>;
>  			};
> @@ -134,6 +137,7 @@ U74_3: cpu@3 {
>=20
>  			cpu3_intc: interrupt-controller {
>  				compatible =3D "riscv,cpu-intc";
> +				bootph-pre-ram;
>  				interrupt-controller;
>  				#interrupt-cells =3D <1>;
>  			};
> @@ -167,6 +171,7 @@ U74_4: cpu@4 {
>=20
>  			cpu4_intc: interrupt-controller {
>  				compatible =3D "riscv,cpu-intc";
> +				bootph-pre-ram;
>  				interrupt-controller;
>  				#interrupt-cells =3D <1>;
>  			};
> @@ -273,12 +278,14 @@ gmac0_rmii_refin: gmac0-rmii-refin-clock {
>=20
>  	gmac1_rgmii_rxin: gmac1-rgmii-rxin-clock {
>  		compatible =3D "fixed-clock";
> +		bootph-pre-ram;
>  		clock-output-names =3D "gmac1_rgmii_rxin";
>  		#clock-cells =3D <0>;
>  	};
>=20
>  	gmac1_rmii_refin: gmac1-rmii-refin-clock {
>  		compatible =3D "fixed-clock";
> +		bootph-pre-ram;
>  		clock-output-names =3D "gmac1_rmii_refin";
>  		#clock-cells =3D <0>;
>  	};
> @@ -321,6 +328,7 @@ mclk_ext: mclk-ext-clock {
>=20
>  	osc: oscillator {
>  		compatible =3D "fixed-clock";
> +		bootph-pre-ram;
>  		clock-output-names =3D "osc";
>  		#clock-cells =3D <0>;
>  	};
> @@ -354,6 +362,7 @@ soc {
>  		clint: timer@2000000 {
>  			compatible =3D "starfive,jh7110-clint", "sifive,clint0";
>  			reg =3D <0x0 0x2000000 0x0 0x10000>;
> +			bootph-pre-ram;
>  			interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_intc
> 7>,
>  					      <&cpu1_intc 3>, <&cpu1_intc 7>,
>  					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> @@ -880,6 +889,7 @@ qspi: spi@13010000 {
>  		syscrg: clock-controller@13020000 {
>  			compatible =3D "starfive,jh7110-syscrg";
>  			reg =3D <0x0 0x13020000 0x0 0x10000>;
> +			bootph-pre-ram;
>  			clocks =3D <&osc>, <&gmac1_rmii_refin>,
>  				 <&gmac1_rgmii_rxin>,
>  				 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>, @@ -
> 904,6 +914,7 @@ sys_syscon: syscon@13030000 {
>=20
>  			pllclk: clock-controller {
>  				compatible =3D "starfive,jh7110-pll";
> +				bootph-pre-ram;
>  				clocks =3D <&osc>;
>  				#clock-cells =3D <1>;
>  			};
> @@ -935,6 +946,7 @@ memory-controller@15700000 {
>  			compatible =3D "starfive,jh7110-dmc";
>  			reg =3D <0x0 0x15700000 0x0 0x10000>,
>  			      <0x0 0x13000000 0x0 0x10000>;
> +			bootph-pre-ram;
>  			clocks =3D <&syscrg JH7110_PLLCLK_PLL1_OUT>;
>  			clock-names =3D "pll";
>  			resets =3D <&syscrg JH7110_SYSRST_DDR_AXI>,
> --
> 2.50.0


