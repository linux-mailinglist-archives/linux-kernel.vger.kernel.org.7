Return-Path: <linux-kernel+bounces-783313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EC0B32B95
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 21:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90BD1BA54D2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 19:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D052528EF;
	Sat, 23 Aug 2025 19:06:26 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2093.outbound.protection.partner.outlook.cn [139.219.17.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C480511185;
	Sat, 23 Aug 2025 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755975986; cv=fail; b=QYe6f+nV13ndjnLZ3i0YXfgMQCpKo13HFu5aTcirn8NwtyMxitgCMhzEIhsFaoUGwECkRe3QbDEP84B4LnQP9cXSJFUx+I2o4eEhdxQ0ezdBpNMg478hMbZlNpHBY818n1S1TGJP5fEbLzmMTkHxeJ22dYsjJCMAQd7UjHkD+kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755975986; c=relaxed/simple;
	bh=5E/Fl5WFRidsA/03ThXNygPZ0NFNXNmuNA2EKxnROCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bPQXkm+kc8ThGP/IXGl6UEr1agXHUzpsAFkpOSpwxda/64UYqhg+8Rn76x29NLfG0TqDy/HAbkyjBqVN7nC5gosZu/gSF/8O/zPiCKL+6n/bjPeVhn4SYjWymKm8vWuqF+V0/W1PhHPOETLxsgNYe3/dC/Yyiqc0dxIXKdFITWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Du5Go4ia76yR0G90uA6DCxw97awTdXWs/wsvYzo1F3bJ2PYnNeZ381RH6J7g7RyJZj9d1IjAretsp5OkYU02O+Xj2RaeaTiI9gkOPch8U/q/EU57YNuhEkAO0TaBXz7DfI4AkQeTnP2eoQ0mlqnF2tgynJLRLze8B8tD7kUW4lbfw75Ag+x3np0gNDmHbrS6kyM85hGFSZhiw+fKvF2X1gPlH1PF/WzRnBCYt6ir3XHbphWNfK3Znav802wwxwU5x4hFKSucGTRhRczf8o2AuEJFGMZTi6oDMCCNDdom6KUNvggwc4u+OO4gNHez//9dEJ3bClF6Ssq2GugPndjJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wd08FzE4MB1+X43mMvm1rSLicUPxkm7Tn+pbIZB2jf4=;
 b=bC3X/OEueAvEm3HlR8AFglpuYU0iup35BNPPSneKgANpDO/sMqHiGltyrbmGlrKsp6ISpwWziMGBI0VqYXR2vgS94EUY6sWwiY+6aGcgeieqMql/cGHtVTtZ/NPLAbyVQbfoiL8E6Yyngnyxbk3+XsDrr7a7X9QYEk37V7CATrKubGbeTOObDQYBKqOeNrBUYeuRBEPvCe2PLBJHT8EZ2cj3s34lchNVYiXEMC2hjCkis8A39BYsOikJRoiAJPHTrPwShQvhp70ER4cLybSGUwM5hJvaRYOLsRZ8m8Zb6lx29LAw0sigAknoBpN7WwCLxvJMsBqU/TYGQ0bcDBjV/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1257.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.30; Sat, 23 Aug
 2025 17:34:20 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9031.026; Sat, 23 Aug 2025
 17:34:20 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Emil Renner Berthing <kernel@esmil.dk>, Conor
 Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] riscv: dts: starfive: jh7110: add DMC memory
 controller
Thread-Topic: [PATCH v3 2/3] riscv: dts: starfive: jh7110: add DMC memory
 controller
Thread-Index: AQHcFBUr/Wi+rXdTz0evSu8cVkna0bRwf43g
Date: Sat, 23 Aug 2025 17:34:20 +0000
Message-ID:
 <ZQ2PR01MB1307D52CDAE655997B6AF864E63C2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250823100159.203925-1-e@freeshell.de>
 <20250823100159.203925-3-e@freeshell.de>
In-Reply-To: <20250823100159.203925-3-e@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1257:EE_
x-ms-office365-filtering-correlation-id: 26346ecc-c854-48d8-83f1-08dde26b4afa
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|41320700013|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 zQS1YArfLl7JbtbGH+EaTgv2RFUU+FdYkg787wmGDOcvgv6qY86zPzDqrmfBbRrRBB3ov9YmoiOpBXyUfHbHoZqQgp2B2vwTjKze3RuTWJELK7R2fl8bAqKbaX9r3NUkgB1QJpxL78UtK8cO6gV2Zs54A9eJv+N0L+FHE8iQ4gBo8sIRRCtHWMZFiqkuOXN0MPYlMwjv8a+z2h34xqV2DhBnv1aVYIiNyweh4xM4ELwc6hkT84na4jExAFDKa+i/+8nq7G14RiuMjDPnnPFKNrhtTRxM6rUNbSlwg7srOT73I51G/pcNEz4YV5xTyCiQtYMg/y4aIGLvP/dApz3skKnzSRyu26EQ7Kejp/PO+p8gFjAOB2RyN8giEP2SlKVbxhELcqV6DkJ0Mq3bgMs/FUB8xKz1qUCQjrncieBAdFpEO54RUYFyeVAO+R5dK2Ms3JkPmhxABbVDUg6esg55xuBeSfmV1bxsXWAipb3yhh0JuD8iib6b3R3WMvjYn3vS9gGF5BWTISLH5Gq4/OrZT1nRQIDGbt02zEBOkS6sDQaY3Lkrr/Yz/jO6kxcV6ey9r4Z7km9F6GTrMY9qqeo6LA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(41320700013)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dVpxo6vWpUj63XwUNHu9oMmeub48Udz8pHJFlhyO1khcVIlpEL4pqkjSsbtm?=
 =?us-ascii?Q?syabbgN0lF2k2yKWw9cDW6zUk7kNmdkG0k9+mF1I1YmfL3aZA5ZcvLKye+xk?=
 =?us-ascii?Q?mC627JYSE/EnTucZga1JeVE4DiV/syFhZefR+V6Co8UcGswEXIF9VTnfzWNn?=
 =?us-ascii?Q?bgzsWmB1w9hMiU2JWptwoTefFRyv3Z70Z+VBQ+q7/2Eyx7hUx/+PvP2jf134?=
 =?us-ascii?Q?IXZo0h8QwYElwr1an5WbefZw3tLTOCCn7BdxZzPvNSIJBSIN1I4xaS/ROim9?=
 =?us-ascii?Q?un9jAc+x0U9tn54oh4wEHxrUaYqownH7/t5zZ9WtJl5AcXeuxyDYNCsLGyY0?=
 =?us-ascii?Q?LCSVbs8q3cAXCWwt2hHo7o5ROtCgnacMXVY6P2Ql3WkcN6/81iEbE4gGmcYJ?=
 =?us-ascii?Q?gZpL+EDOtvAiTJC/KaOQlHlURpxs29x9XtXs6eGbqgLhivB6oYDj70KfBXxr?=
 =?us-ascii?Q?XeSR6oZu2ePA3n+d6fnQF9nC1CO2069m5WX0utk3wc3gJ4A3ijVVDPqBSYUS?=
 =?us-ascii?Q?xwGYdpXrho8t8SCevFDY6Gkq/ohIPhRir0yTX4brUSkrpktugf4FGitxfwPC?=
 =?us-ascii?Q?DJR46vmAtUbBXQ6IKywEM1rXz7up3WNJfTGZ9yuINgfvMhZq3uoL9jz6m0vr?=
 =?us-ascii?Q?gGubw6xh2+FQGamhTp3L226dt64xx/qt99TvnBTZMksqdmJn9Gx4dWOXDFlO?=
 =?us-ascii?Q?iD6WSchf21PUjHEV/bk9BhQQ7/H6bc8RN+D6EQZu+ZKV5tAHDFKRA7HDPu66?=
 =?us-ascii?Q?h0m3YUUe46MCQaTLaWPajxeqs/aGDCpu3BcExlQPi82zTy/b4GZ5ratOtr1N?=
 =?us-ascii?Q?VrlQPWaEA0XW+jgEHsBcp90c6tKtXa2pLu0GrEYWI58TMfsZqgjqCv4VsYpU?=
 =?us-ascii?Q?uj94/tqBW5KTJlVWuVi7g8S/7x9Ep8pdMeExJ8fE/3Hfe4sTFqaf5ckMgl9c?=
 =?us-ascii?Q?5Ox1wezCuatODiPGtbZCuqedBJvJGgvQBA9zu3QRghIXhQpgZ1KBL7qh3eWd?=
 =?us-ascii?Q?aqvLX2iGn52ltRzKatw/o1Uf7DLXeuS9sW28LlRBrgJU6r5XIAUdFyiOOLNM?=
 =?us-ascii?Q?vc6qr1czFgC+Bt1LzYVUaL2JibvmZGcCpW/JAvKWfT5WIEiRzHD46MrulAC4?=
 =?us-ascii?Q?3ow6vpz1m24D2/6x6RmFDR0y3YSUHw8Qc41kiqeULw11edjm3M0cu+njWMMj?=
 =?us-ascii?Q?Dhh/scGVcccccTCEijYiO64leftCXjMYxuL+QzcPbyYXxZnUUAILBqEoeBa8?=
 =?us-ascii?Q?EhlN6jIP/NQ9+o/eWhBUfnEEn0MXCaSxiJVkFmyJdQZ7cHk07bslx4hNkDbr?=
 =?us-ascii?Q?IYqIBCeRRpc6cho6V9XqbFPdSYoOHaIbr5/mfWGHyY06p2mBM430hADuVkaK?=
 =?us-ascii?Q?EzM7NKH0yJpzCOGoj/mSTsTk0i2UIM723QpzLBuh2gjhtMcd6jw1W5Rrz5U0?=
 =?us-ascii?Q?Fs9iIvrIv0cOFE77OQ+pbRRnj84ej6dcpdVai/MpEJlqCAjujQopO6ktHibT?=
 =?us-ascii?Q?M+JKkcpdRl96HNoJ8oevA9ixCCvZhxxpGi7Jni1OHKFopLlZd64dkX6Pmz3s?=
 =?us-ascii?Q?pGwjfRUNfbhKa/alv9T7Yay51DSE4lb+cl7rM8ql?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26346ecc-c854-48d8-83f1-08dde26b4afa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2025 17:34:20.3297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wCxZfeXJUfaHDlfDZgzz10cY5A+xrbV8sLQh/8X3a7P/ZgCgmU5Ds6NAa4QwlpKpJHXszuTcPiGf1tf6HbN1VsxXmDpIKtFHUkjjb1p6n/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1257

> On 23.08.25 18:02, E Shattow wrote:
>
> Add JH7110 SoC DDR external memory controller.
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
> index 0ba74ef04679..f3876660c07f 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -931,6 +931,18 @@ watchdog@13070000 {
>  				 <&syscrg JH7110_SYSRST_WDT_CORE>;
>  		};
>=20
> +		memory-controller@15700000 {
> +			compatible =3D "starfive,jh7110-dmc";
> +			reg =3D <0x0 0x15700000 0x0 0x10000>,
> +			      <0x0 0x13000000 0x0 0x10000>;
> +			clocks =3D <&syscrg JH7110_PLLCLK_PLL1_OUT>;
> +			clock-names =3D "pll";
> +			resets =3D <&syscrg JH7110_SYSRST_DDR_AXI>,
> +				 <&syscrg JH7110_SYSRST_DDR_OSC>,
> +				 <&syscrg JH7110_SYSRST_DDR_APB>;
> +			reset-names =3D "axi", "osc", "apb";
> +		};
> +
>  		crypto: crypto@16000000 {
>  			compatible =3D "starfive,jh7110-crypto";
>  			reg =3D <0x0 0x16000000 0x0 0x4000>;
> --
> 2.50.0


