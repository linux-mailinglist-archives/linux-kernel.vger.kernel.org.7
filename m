Return-Path: <linux-kernel+bounces-808572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4731EB501AC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F3987BD57E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C98B32CF95;
	Tue,  9 Sep 2025 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="VKaksjaK"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428DA13774D;
	Tue,  9 Sep 2025 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432411; cv=none; b=acFuBUOiXRjCWEZaRrQH29zKv+5/nvip3TsOdsuj9utryAaZpVwPvRIO2DXux5kgEcOaZHlaQjIJZMxnYeghz1h8W4kxLaaKeXPGyEWQIwz/56eA08SsT7I3Tz0VneFw19gIk51r8BBhF+G8/QHFFchC44oXwjB9lHw1JPjEos4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432411; c=relaxed/simple;
	bh=SGkJqEtEt8KPYvxelhtfd+T9SOuen3INZEsE1NNTfzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7ssiMTaxKtWNsfZli10k9LqOEAO90MTGn3EICN4j5PcMg8m8VCjsc7+Uc+2xKpQrxhSjd2D2O6xKTnJU2srnDuoLeSqN/sV281HoQp8sOXQhjR0KsLySZznhgMdaVrhWueoPezz6gYmDCbmpcRfrsGbQK8lsp59tesM4n/q3i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=VKaksjaK; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=BFeRB9wMbzR5Lg36gM813vRngWsNJslGbR1E32rRVEo=; b=VKaksjaK+PgOCh7qIEUxmdJKsp
	6NIzmASvKY3ll8cRpNyZ7Zb49fbx4YmufT0Qkv1J2MAlBK8IatmJOOkQscTWmcTN9XCcdcKSy5PE8
	/igNLIQ8mJPOGzvXFT3aN54Eu+aXkAUUWVG2LYoPTFe0deG6ileAh8dqYeCsD4Uwn9xM4HqiJtWl/
	aHjwUIK635NEuWeyVnYbmL/Dv4mOjsvPcyHM7zNQcPCPx3uZlXZ2IImbPKPJVNnX9fROqhaiRzCWc
	GgmAJyrTSNeeNkJMwwyDi2Z5DnWiXWcdaNEHFZ52l8u9R3VOq7Zm506BRLSYoihpDOZTAePtnIaTG
	CDhVtw7A==;
Received: from i53875b3d.versanet.de ([83.135.91.61] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uw0Rm-0002H9-HC; Tue, 09 Sep 2025 17:39:54 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: FUKAUMI Naoki <naoki@radxa.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
 Chukun Pan <amadeus@jmu.edu.cn>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Radxa E24C
Date: Tue, 09 Sep 2025 17:39:53 +0200
Message-ID: <17232684.geO5KgaWL5@diego>
In-Reply-To: <7d3c3b29-f89f-4801-8fd7-d6d0645095af@kwiboo.se>
References:
 <20250727144409.327740-1-jonas@kwiboo.se>
 <B055BC95C67D129C+d7a2ff39-8367-48cf-8697-f12fd9f885a4@radxa.com>
 <7d3c3b29-f89f-4801-8fd7-d6d0645095af@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 9. September 2025, 16:48:25 Mitteleurop=C3=A4ische Sommerzeit =
schrieb Jonas Karlman:
> On 9/9/2025 2:28 PM, FUKAUMI Naoki wrote:
> > Hi Jonas,
> >=20
> > On 7/27/25 23:44, Jonas Karlman wrote:
> >> The Radxa E24C is a compact, high-performance network computer
> >> developed by Radxa, based on the Rockchip RK3528A SoC.
> >>
> >> Add initial device tree for the Radxa E24C.
> >>
> >> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> >> ---
> >> Schematics: https://dl.radxa.com/e/e24c/docs/radxa_e24c_v1200_schemati=
c.pdf
> >> ---
> >>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >>   .../boot/dts/rockchip/rk3528-radxa-e24c.dts   | 519 ++++++++++++++++=
++
> >>   2 files changed, 520 insertions(+)
> >>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/d=
ts/rockchip/Makefile
> >> index 0662fcf00628..dc62fd5305be 100644
> >> --- a/arch/arm64/boot/dts/rockchip/Makefile
> >> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> >> @@ -92,6 +92,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399pro-rock-pi-n=
10.dtb
> >>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3528-armsom-sige1.dtb
> >>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3528-nanopi-zero2.dtb
> >>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3528-radxa-e20c.dtb
> >> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3528-radxa-e24c.dtb
> >>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3528-rock-2a.dtb
> >>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3528-rock-2f.dtb
> >>   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3562-evb2-v10.dtb
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts b/arch=
/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
> >> new file mode 100644
> >> index 000000000000..225f2b0c5339
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
> >> @@ -0,0 +1,519 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> +
> >> +/dts-v1/;
> >> +
> >> +#include <dt-bindings/input/input.h>
> >> +#include <dt-bindings/leds/common.h>
> >> +#include "rk3528.dtsi"
> >> +
> >> +/ {
> >> +	model =3D "Radxa E24C";
> >> +	compatible =3D "radxa,e24c", "rockchip,rk3528";
> >> +
> >> +	aliases {
> >> +		ethernet0 =3D &gmac1;
> >> +		i2c0 =3D &i2c0;
> >> +		i2c1 =3D &i2c1;
> >> +		i2c5 =3D &i2c5;
> >> +		mmc0 =3D &sdhci;
> >> +		mmc1 =3D &sdmmc;
> >> +		rtc0 =3D &hym8563;
> >> +		rtc1 =3D &rk805;
> >> +		serial0 =3D &uart0;
> >> +	};
> >> +
> >> +	chosen {
> >> +		stdout-path =3D "serial0:1500000n8";
> >> +	};
> >> +
> >> +	adc-keys {
> >> +		compatible =3D "adc-keys";
> >> +		io-channels =3D <&saradc 0>;
> >> +		io-channel-names =3D "buttons";
> >> +		keyup-threshold-microvolt =3D <1800000>;
> >> +		poll-interval =3D <100>;
> >> +
> >> +		button-maskrom {
> >> +			label =3D "MASKROM";
> >> +			linux,code =3D <KEY_SETUP>;
> >> +			press-threshold-microvolt =3D <0>;
> >> +		};
> >> +	};
> >> +
> >> +	gpio-keys {
> >> +		compatible =3D "gpio-keys";
> >> +		pinctrl-names =3D "default";
> >> +		pinctrl-0 =3D <&gpio0_a0_user>;
> >> +
> >> +		button-user {
> >> +			gpios =3D <&gpio0 RK_PA0 GPIO_ACTIVE_LOW>;
> >> +			label =3D "USER";
> >> +			linux,code =3D <BTN_1>;
> >=20
> > I prefer to assign BTN_0 to the 1st button :)
>=20
> The E20C (and other RK boards) already use BTN_1 for user button, it
> only seem to be the recently added E54C that is using BTN_0.
>=20
> For consistency I suggest we keep using BTN_1 for this user button and
> possible fixup E54C, if you want to use same button for all variants.

Yep, that would also keep the amount of userspace-facing changes
minimal.

Heiko




