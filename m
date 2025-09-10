Return-Path: <linux-kernel+bounces-809687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457EDB510F6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E967BFE2E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED04E315794;
	Wed, 10 Sep 2025 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="k9OW7Ic/"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83D2314B75;
	Wed, 10 Sep 2025 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491694; cv=none; b=Dfd2UtGVMy5PADRMgUGAq7GESOSwAdtVia4Y0ymrtXt7jROaoP7uBePPQxbqo3kji8MhHrXHKmA6BA4Sz/eG/aj11aP8r72XqV1iy3YgQrs4Gm23Cq23BVPFJxsq8GENTDcRtpD1RWvfzO8ER3mvQ9dWSJfLn4YMk9mvE/Qugl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491694; c=relaxed/simple;
	bh=ewJW9uXlncTo2CtudqjwkqrHwdZRf+Dps7gnHmeAfms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXKoGq6B3Sycfy/xZmRvs0utboZF2TM/Cm8pJilfHCH1LtNISV/+XxFOytBL4HrE0aVBgLVC4NMRr9QQC6OBjHNAQxto2l7DWOYxi2lUNgwUf2XxGvGO7hHm/rCgrjt9a2LkNNyo524dlgZgQSraZEKNzrpH3FwPzDL3uJyRWtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=k9OW7Ic/; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=OKtae1/MTEFxe7xmafsPAa0wGzFLGfdejPFoPYDGp2U=; b=k9OW7Ic/qBSej1y4jPGXZrPgeX
	oL+IcP7PA+rtbDaMdMDqroOQsPB4DpioOg6ekYmCUmRZ9Wn77nr/UCZl9a5JVsLGEeXPCqp43YuQZ
	xcT/lIUokAjFQGEXdK4apfXuyoZfJTmLHtLS7+4oqVxnatty+LP1YMlnthZKCmPbgljmAfdt8V12Q
	jTD9Njalu5FVDuZEm/XX3kx+pftHkn7uCGQmKcteo2/RiiA6C1b07Ie91eQHh9Ev3P38lzkmK6Him
	NsTCzidqF1M5lG8NTZd8+y7WNo5rDe9zebEvFjynP1BJTw8o8WpJPtoKp156j8bU2fbrKkBhZpwlN
	ryXgTZ5Q==;
Received: from i53875b8a.versanet.de ([83.135.91.138] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uwFrr-0008H8-RD; Wed, 10 Sep 2025 10:07:51 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Jonas Karlman <jonas@kwiboo.se>, FUKAUMI Naoki <naoki@radxa.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
 Chukun Pan <amadeus@jmu.edu.cn>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Radxa E24C
Date: Wed, 10 Sep 2025 10:07:49 +0200
Message-ID: <3331537.aV6nBDHxoP@diego>
In-Reply-To: <AF1546E3BE23C6D5+08234a44-4321-45da-9c74-5690f3437e03@radxa.com>
References:
 <20250727144409.327740-1-jonas@kwiboo.se>
 <a443fca9-e660-4a7a-b637-ec840ac8ed1e@kwiboo.se>
 <AF1546E3BE23C6D5+08234a44-4321-45da-9c74-5690f3437e03@radxa.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 10. September 2025, 04:43:30 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb FUKAUMI Naoki:
> Hi Jonas, Heiko,
>=20
> On 9/10/25 04:36, Jonas Karlman wrote:
> > On 9/9/2025 5:39 PM, Heiko St=C3=BCbner wrote:
> >> Am Dienstag, 9. September 2025, 16:48:25 Mitteleurop=C3=A4ische Sommer=
zeit schrieb Jonas Karlman:
> >>> On 9/9/2025 2:28 PM, FUKAUMI Naoki wrote:
> >>>> Hi Jonas,
> >>>>
> >>>> On 7/27/25 23:44, Jonas Karlman wrote:
> >>>>> The Radxa E24C is a compact, high-performance network computer
> >>>>> developed by Radxa, based on the Rockchip RK3528A SoC.
> >>>>>
> >>>>> Add initial device tree for the Radxa E24C.
> >>>>>
> >>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> >>>>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> >>>>> ---
> >>>>> Schematics: https://dl.radxa.com/e/e24c/docs/radxa_e24c_v1200_schem=
atic.pdf
> >>>>> ---
> >>>>>    arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >>>>>    .../boot/dts/rockchip/rk3528-radxa-e24c.dts   | 519 ++++++++++++=
++++++
> >>>>>    2 files changed, 520 insertions(+)
> >>>>>    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-radxa-e24=
c.dts
> >>>>>
> >>>>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boo=
t/dts/rockchip/Makefile
> >>>>> index 0662fcf00628..dc62fd5305be 100644
> >>>>> --- a/arch/arm64/boot/dts/rockchip/Makefile
> >>>>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> >>>>> @@ -92,6 +92,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399pro-rock-p=
i-n10.dtb
> >>>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3528-armsom-sige1.dtb
> >>>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3528-nanopi-zero2.dtb
> >>>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3528-radxa-e20c.dtb
> >>>>> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3528-radxa-e24c.dtb
> >>>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3528-rock-2a.dtb
> >>>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3528-rock-2f.dtb
> >>>>>    dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3562-evb2-v10.dtb
> >>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts b/a=
rch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
> >>>>> new file mode 100644
> >>>>> index 000000000000..225f2b0c5339
> >>>>> --- /dev/null
> >>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e24c.dts
> >>>>> @@ -0,0 +1,519 @@
> >>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >>>>> +
> >>>>> +/dts-v1/;
> >>>>> +
> >>>>> +#include <dt-bindings/input/input.h>
> >>>>> +#include <dt-bindings/leds/common.h>
> >>>>> +#include "rk3528.dtsi"
> >>>>> +
> >>>>> +/ {
> >>>>> +	model =3D "Radxa E24C";
> >>>>> +	compatible =3D "radxa,e24c", "rockchip,rk3528";
> >>>>> +
> >>>>> +	aliases {
> >>>>> +		ethernet0 =3D &gmac1;
> >>>>> +		i2c0 =3D &i2c0;
> >>>>> +		i2c1 =3D &i2c1;
> >>>>> +		i2c5 =3D &i2c5;
> >>>>> +		mmc0 =3D &sdhci;
> >>>>> +		mmc1 =3D &sdmmc;
> >>>>> +		rtc0 =3D &hym8563;
> >>>>> +		rtc1 =3D &rk805;
> >>>>> +		serial0 =3D &uart0;
> >>>>> +	};
> >>>>> +
> >>>>> +	chosen {
> >>>>> +		stdout-path =3D "serial0:1500000n8";
> >>>>> +	};
> >>>>> +
> >>>>> +	adc-keys {
> >>>>> +		compatible =3D "adc-keys";
> >>>>> +		io-channels =3D <&saradc 0>;
> >>>>> +		io-channel-names =3D "buttons";
> >>>>> +		keyup-threshold-microvolt =3D <1800000>;
> >>>>> +		poll-interval =3D <100>;
> >>>>> +
> >>>>> +		button-maskrom {
> >>>>> +			label =3D "MASKROM";
> >>>>> +			linux,code =3D <KEY_SETUP>;
> >>>>> +			press-threshold-microvolt =3D <0>;
> >>>>> +		};
> >>>>> +	};
> >>>>> +
> >>>>> +	gpio-keys {
> >>>>> +		compatible =3D "gpio-keys";
> >>>>> +		pinctrl-names =3D "default";
> >>>>> +		pinctrl-0 =3D <&gpio0_a0_user>;
> >>>>> +
> >>>>> +		button-user {
> >>>>> +			gpios =3D <&gpio0 RK_PA0 GPIO_ACTIVE_LOW>;
> >>>>> +			label =3D "USER";
> >>>>> +			linux,code =3D <BTN_1>;
> >>>>
> >>>> I prefer to assign BTN_0 to the 1st button :)
> >>>
> >>> The E20C (and other RK boards) already use BTN_1 for user button, it
> >>> only seem to be the recently added E54C that is using BTN_0.
> >>>
> >>> For consistency I suggest we keep using BTN_1 for this user button and
> >>> possible fixup E54C, if you want to use same button for all variants.
> >>
> >> Yep, that would also keep the amount of userspace-facing changes
> >> minimal.
> >=20
> > I mixed up e54c and e52c so my statement was not fully correct above,
> > however there is a mixed use of BTN_1 and BTN_0 for user button:
> >=20
> > - rk3588s-nanopi-r6c/r6s uses BTN_1, added in v6.9-rc1
> > - rk3588-friendlyelec-cm3588-nas uses BTN_1, added in v6.11-rc1
> > - rk3582-radxa-e52c uses BTN_0, added in v6.14-rc1
> > - rk3528-radxa-e20c uses BTN_1, added in v6.15-rc1
> > - rk3576-nanopi-m5 uses BTN_1, added in v6.17-rc1
> >=20
> > Majority seem to be using BTN_1 for a user button.
>=20
> If we can unify to BTN_1 even if it breaks backward compatibility, I=20
> wouldn't be opposed to it.
>=20
> (I remember a "sync with others" patch being rejected in the past, but I=
=20
> might be remembering it wrong.)

you remember correctly :-) .

Changing the reported key just for "syncing" is generally not desired.
It'd be like your "a" key reporting "z" with a new kernel version, even
if the label on the key states "z" since the beginning [0]

So any adaptation always is on a case-by-case basis.

My hunch right now is that we might be able to adapt the button
on that rk3582 board, because I assume due to the lottery soc
(disabled cores and/or disabled gpu/...) it might not be overly
spread out in the wild?


[0] https://xkcd.com/1172/ ;-)





