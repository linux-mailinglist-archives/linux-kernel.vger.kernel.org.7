Return-Path: <linux-kernel+bounces-773315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64960B29E28
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 962BD7A5026
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE9730E0FF;
	Mon, 18 Aug 2025 09:39:24 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782A030DECA;
	Mon, 18 Aug 2025 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509963; cv=fail; b=VXuEcFNMxbEszbNeJ9NqwT0O5/qFjW3INXlNuHFPcEOctn4o5VAI0KxCAY2ByAdUkjEQvbhTCJZRDYpxpFtoOaaw9GuBOBB8Y3AXU73GiwE0rFZlmNY51icO6cpt0KgOshKCsmED0KKJkPf6SAZdDaCE7aHq0mbljpWNAM8cS8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509963; c=relaxed/simple;
	bh=mcTYQHV/brCRiY/D292+UyeBy2FPSioqzodybVibVnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g8ihp64go5tZmvHx/m3xLK+zufO98WQ8+EYLUbZ/DINnClQc7Hps+dpyy3DqEDZe/Wm5OfQVNhMA/Rr+bArdVwHt2//fMLFIokV63EVEGIg+VqZkQb+51uTC7E77CsEo5jhUSwKyLM+HESp7RSZrwzpZ+xLEQtLtNnimQaRR2MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4LjWilmZ+Cbha/0S81zHYfCvqACUWzMkRJEh3ra0glj6OOt7ZFC8HO54MlH9is79V9nQmOximqUXubfLDSiNMxvlTqgLW7eDlhLE5qN6liFi2Wd6SvPwNfShjjjUm0FiB4LpK8CdR56wDNBtKn3tEQXaFeMslJwXtUPoLNRgKxUlx1gij8i7RKM3oIHXKiHP9VbGix4uV/g6bJW143dpzuFruS/7jjnG+ob0MWXh5vSiVwosL3Cx2qGLewxx1QT+mqrdjT6h045Bd//Ds57dvosXT0RMoW3cAXXJhum+0WlcKAO1EUJebN3Bdp5WQ/onMcUBQavJ4YG8lGWTP3Efw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sk5HRt83ejDx8HUvz4F+zgnWFAiZyavV10DZzdV4P7o=;
 b=ESK0lPX2lJc95/X5G5ChBpCDpOYisQQqVk+1yZiJpQ9uBahRl7uFDD8B18Pw/1Vp4V0oSPFB8wVTtGj3nOuDK+8fvmTP3IcFFIy2w/d14pw72OQqHIE3XHVZJHrQTiJ0ZWDx14wR3OYCKMjE4+asaomK0lm3iJ1B9xqs5ZbjipZp3xK3nPsytmsdiPMKBbVMvbLYNXuX/NB0ExAfWYM/zCPFXc70WAwzO32dVAob/I0RJfA+p62AafvC9pMHaSDEbMFwszhHT4S6aeF4YrH39an4p4ULQseDMmXkYhZFlxaU/foam8qeegiKzYggM3bHUnzmuKZWK6rK5+avPfA3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1161.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 06:05:40 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 06:05:40 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Conor Dooley <conor@kernel.org>, Emil Renner
 Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v2 3/3] riscv: dts: starfive: jh7110: bootph-pre-ram
 hinting needed by boot loader
Thread-Topic: [PATCH v2 3/3] riscv: dts: starfive: jh7110: bootph-pre-ram
 hinting needed by boot loader
Thread-Index: AQHcDbfjrd5j87sKqkyiqAyP5B2/v7Rn7XHQ
Date: Mon, 18 Aug 2025 06:05:40 +0000
Message-ID:
 <ZQ2PR01MB1307CE398A5993B9E5B93357E6312@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250815073739.79241-1-e@freeshell.de>
 <20250815073739.79241-4-e@freeshell.de>
In-Reply-To: <20250815073739.79241-4-e@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1161:EE_
x-ms-office365-filtering-correlation-id: 1255fb70-e384-4fd5-04ae-08ddde1d420e
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|41320700013|366016|38070700018;
x-microsoft-antispam-message-info:
 xEz6NGJN2LGx/78JNqOYdbBgmKf1/5u1QqSqRKrbLMU7OEMef938KneYxD9VTLDLtPCEVuJk5Ovvt+5mWFgcHbY5NUHV78WYzN+GDWi+whuYaamY3doaKBvgt41mmw+S3Cc+aQqrnNcTcqbr7h42jLoFBy8aROxmBfJ2I/muZ1Gl7+tFzSe7aYqLmbapP+05dqbr1ZhLKNv6YBZFNFEcUWekR6OSxmCtV/+vvNOfD3iI7tuQQNOgfo8IWpVNtZfTXTlvkHfzCCqKmHDkJWnuDckWeQwsajrtY842f+Lru4SJiZrpV/oYvW3FXCBkw08QNFNBLWg65d6Og7jhrGOQdf/MtYFLEI+cTJe+EBGBm0Te2GaN8N7iIuhl7M/pSmYuHA33xRr52PAuzdC2GIYc9XQGQ7WhEkO36kIlsOhYxXLk5JKz52qTmqWjjSzeej+OSYc3JikRe77cYwRyIdKUowFPORQeww7hWRK+mDFyLudc51HBZ0Po5WChXXiHyROr/1AyuvJrIlZkbYi9Tpl6vw5lTCSIgiM7p7pDPp8iNVs6Kz1SLbms+ZC88b650K82oZ7TNCH8pmDFsPIJRazxrGukU2IeSyt7lXawRYvY99Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(41320700013)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YVolEmx+kdPGNnZ+GAEsDXT0xDS5eBDJJIT/okrNtKzayQ2w47Ecmh/j7U1/?=
 =?us-ascii?Q?SNhV8Vlr50OZXyZ0A7GZUfH2dLw655Y/D7E+cNskT7e3D3rYjKGG3gyaaWAP?=
 =?us-ascii?Q?/GSKFDKv7MF049PZ6/usLfaiO31aQ68oOylls7vamhlMSEIus9AeelpLhEwQ?=
 =?us-ascii?Q?ubDJ9B0Zs1FVaDVOEw0Nlqr9VvfCpSfeHkJxp7to32GtdsLKBEJYS0sX1Lmx?=
 =?us-ascii?Q?ZvzDRFSTdXUcRPSsWhLx+8cyTyejzUcl51tyRTqMwfjOrxHUwVGh8L/98tG1?=
 =?us-ascii?Q?S5YMjdxlQY/C2PQIvTNj/bTwa+X/qghv+wnmWQHesDY3/RZlVXqGfoEVH0cT?=
 =?us-ascii?Q?APkpr7T/BlHCBg36tjt0LyqzI3gjaPX0XIJg3tqXMB/vDMz2dMvSbNtc2Hx4?=
 =?us-ascii?Q?qDPCiCIPNq2uJX5srCfG66EvR9ywNQlkX2gDgxnKlPy2tGsPBYUiGv/Z5uNb?=
 =?us-ascii?Q?bQHnLpzXFhJlpBQYUfaCqo4xCpXaPLH5o2jMUtEzxlvY+xz6EAvWwGaX5qms?=
 =?us-ascii?Q?k8Lvhr29PTGpSKNBfcUtwUMuARibt8AI6uzk9jq1TnXG4Ffo1Ffx6nnR2E3Y?=
 =?us-ascii?Q?svFzVWKLMWNVTgq77xhdTNabJ5LPi+DfjS6/yRk8M7lAzMk8C2l5xbWEDw2+?=
 =?us-ascii?Q?6R18nkq6+4VGFQqqXiJ35OyIytIetSZ/hMEcAgnjBfDc7PEegvGwZbXMb9Xt?=
 =?us-ascii?Q?Bjhzn8CV8QRGqVVdKWg00IusFvWCMVdYNO/34L3WbGWeBfy+zHmMsZh1VYCg?=
 =?us-ascii?Q?HNJq0EAd0NwJ4jxAYJYz0dW+Hhf3Fak0AWLrqMpav5pUZyocqF5xwGoxhAC+?=
 =?us-ascii?Q?PySc8y/t20VL/nn+7DXhWRXy0LRmPDbgVoLnS4dxSVY8WF6fT1tyh6LRvlhw?=
 =?us-ascii?Q?xOt1nhtMoL5oUAxb8ZVE1fkeYKUQblc1M1CnTu+R+rkU1It9NAocr6EfCIKJ?=
 =?us-ascii?Q?sEgJL/+92Aw2uT/xF7AcvkZGv0c6QMnaVnH5OvHL0JHa7LEyYgyLEOuOzZJJ?=
 =?us-ascii?Q?C5LtJ1IKlJzOYIMFIMwcneiHsQuZhIkbQbDjLwjdzhZ5w8qWfhwsKCnzbWqU?=
 =?us-ascii?Q?hUzyZirbnytI2qFrxC4PHUE42kEzm7R/jnZtdZAScg/xh2rywRromZhTHyKU?=
 =?us-ascii?Q?i/nXUzGZRGUtD3pd+Hqy6UmmQmaYHeww/IjqIdFgLOZ3xC4EePLvIwjxs4jO?=
 =?us-ascii?Q?K7HF6+HPfvmLqoBll1OLnBmKM8v0JqD72ZsmlOWrTMyt3nM9kdq7AqMCuTkN?=
 =?us-ascii?Q?ZhbveWOwqvyXFaE6qbi3h2GBUARtrQq4iX7FI5nzmx2Kj+H9I0jzcA1EKeCh?=
 =?us-ascii?Q?/CWULE90Q9aySuY5q2UAa1rDqdSP+CeMR36riHmogCAUaKuWvRSwD4JYIxqH?=
 =?us-ascii?Q?sb1MAPAoy/6vsIEmwoxb7IR043dZ6mx2ngyJCjMaW/Cj+XS8RHr6yIxWwhtB?=
 =?us-ascii?Q?aLSXG8c802zhsGWttmbRtiSFuxTi6EYQ64paDngSXr6ap1eV2ESp/8UkKgfA?=
 =?us-ascii?Q?MrsPGTde4yCODDga5gCLAROLbKXj4T7hvS5E5EsLAEwygWxD3I2p+GG9HWW2?=
 =?us-ascii?Q?BhnB1t3oaHKrDE2SG+7mdxvWue/dGTl48UTmMHxtm0c0LOIK2rYQMQfefWXa?=
 =?us-ascii?Q?xQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1255fb70-e384-4fd5-04ae-08ddde1d420e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 06:05:40.0089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3CNYOlMQHsfuFdz1k6RiVOMYjbbQA0YQn45HJNcvop7q7+ecp8wC4mFpXfqThRuBgYuRucEpmAPyVgrzJTTSMVxKEnRET5LVVMjX/5MQYto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1161

> On 15.08.25 15:37, E Shattow wrote:
> Add bootph-pre-ram hinting to jh7110.dtsi:
>   - CPU interrupt controller(s)
>   - core local interrupt timer
>   - DDR memory controller
>   - oscillator
>   - syscrg clock-controller
>=20
> Signed-off-by: E Shattow <e@freeshell.de>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 14df3d062a45..884a3526cb0f 100644
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
> @@ -321,6 +326,7 @@ mclk_ext: mclk-ext-clock {
>=20
>  	osc: oscillator {
>  		compatible =3D "fixed-clock";
> +		bootph-pre-ram;
>  		clock-output-names =3D "osc";
>  		#clock-cells =3D <0>;
>  	};
> @@ -354,6 +360,7 @@ soc {
>  		clint: timer@2000000 {
>  			compatible =3D "starfive,jh7110-clint", "sifive,clint0";
>  			reg =3D <0x0 0x2000000 0x0 0x10000>;
> +			bootph-pre-ram;
>  			interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_intc
> 7>,
>  					      <&cpu1_intc 3>, <&cpu1_intc 7>,
>  					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> @@ -376,6 +383,7 @@ memory-controller@15700000 {
>  			compatible =3D "starfive,jh7110-dmc";
>  			reg =3D <0x0 0x15700000 0x0 0x10000>,
>  			      <0x0 0x13000000 0x0 0x10000>;
> +			bootph-pre-ram;
>  			clocks =3D <&syscrg JH7110_PLLCLK_PLL1_OUT>;
>  			clock-names =3D "pll1_out";
>  			resets =3D <&syscrg JH7110_SYSRST_DDR_AXI>, @@ -
> 892,6 +900,7 @@ qspi: spi@13010000 {
>  		syscrg: clock-controller@13020000 {
>  			compatible =3D "starfive,jh7110-syscrg";
>  			reg =3D <0x0 0x13020000 0x0 0x10000>;
> +			bootph-pre-ram;
>  			clocks =3D <&osc>, <&gmac1_rmii_refin>,
>  				 <&gmac1_rgmii_rxin>,
>  				 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,

pllclk also needs to add bootph-pre-ram. Because it is the dependency of sy=
scrg.

		pllclk: clock-controller {
			compatible =3D "starfive,jh7110-pll";
+			bootph-pre-ram;
			clocks =3D <&osc>;
			#clock-cells =3D <1>;
		};

Best regards,
Hal

