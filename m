Return-Path: <linux-kernel+bounces-732408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD2CB0665A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2741AA1B13
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13EB2BE7B8;
	Tue, 15 Jul 2025 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="eNDMsA6L"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CDB1FECB0;
	Tue, 15 Jul 2025 18:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605810; cv=none; b=d39F832ATCOM2ysYYCde0jWKtZbMSZk1aNMD/VIFWjOdK3nAYhiEKcEmCuO8flsMZLVu4b21lwOcw2MvCS1MInFIBAA8NZbBKAkgpf0l75SYWLAaTlWDsQYeyBmrcN0o+k/8ObLQv83oVMgKXHMytqZNmCGmAH7STnr84BoF+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605810; c=relaxed/simple;
	bh=3SG28qd3V+cyGSsL9bPlgOU8EAvNxqXxzlgSXCPYjuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxyVVJafyyvY5larBeco7RARIzkuXkqiICN55eUSpv+y9lbAK32JY5nP+SerEQCGwaU/LkvwJPWTf+Dr8SE8SO/jTGVDubfmReV06y4B3xT/hwbs2ULCa60z+w/Jxnh81mg+Lk3B7FzH3xjPzTeMnnEellIxgC4WlKDnTMBVfJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=eNDMsA6L; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=c3FvSx6o8Ig7hqIemWG3aGM0Aly8D1whtV4O1eHlt+Y=; b=eNDMsA6LcsaN7pYQ7Z/QS7JEyZ
	O8jVUSPdMmuprxx3e8zpoYvuTYkKu7wFrqC1tWmCvdBsD43uRaPIW+prYIUgJcmzXX88LsTbjm3B/
	jeKPCpEcOW6wSzu/r2PL+pkR9iP2EVQGNgMlIskhL19++pwTWtxUaUIMkUs/qUb46D+OjhmnKrUZy
	TmazskNXfcV6TCtsQ2F7L53l/EYaxSafCt/8Ku1RPXcqTGaIp3E7L2GnNRrT30TRwDI4HjFAFtrgP
	l+R+DhUHmpoK4UxoRYgXD4o+sPtRc1KsSJSJyawS5cX0Q8ulYcsGwF35hLvG0dCPg2+X+W/qkVH40
	L+rRkGKA==;
Received: from i53875a5c.versanet.de ([83.135.90.92] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ubkpQ-00040J-A1; Tue, 15 Jul 2025 20:56:36 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Jonas Karlman <jonas@kwiboo.se>, Yao Zi <ziyao@disroot.org>,
 Alex Bee <knaerzche@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] arm64: dts: rockchip: Add ROCK 2A/2F,
 Sige1 and NanoPi Zero2
Date: Tue, 15 Jul 2025 20:56:38 +0200
Message-ID: <11576357.nUPlyArG6x@diego>
In-Reply-To: <063ec197-bbd7-4ad2-add9-40f028e800b7@gmail.com>
References:
 <20250712173805.584586-1-jonas@kwiboo.se>
 <16d99271-ba04-4ce1-a335-fab1917637c7@kwiboo.se>
 <063ec197-bbd7-4ad2-add9-40f028e800b7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 14. Juli 2025, 07:53:09 Mitteleurop=C3=A4ische Sommerzeit schrie=
b Alex Bee:
> Hi Jonas, Hi Yao,
>=20
> > Hi Alex,
> >
> > On 7/13/2025 10:56 PM, Alex Bee wrote:
> >> Hi Jonas,
> >>
> >>> Hi Alex,
> >>>
> >>> On 7/13/2025 9:13 PM, Alex Bee wrote:
> >>>> Hi list, Hi Jonas,
> >>>>
> >>>>> This series adds dt-bindings and initial device tree for the follow=
ing
> >>>>> Rockchip RK3528A boards:
> >>>>> - Radxa ROCK 2A/2F
> >>>>> - ArmSoM Sige1
> >>>>> - FriendlyElec NanoPi Zero2
> >>>> this only sub-related to this series: Is there any particular reason=
, why
> >>>> we call the compatible "rockchip,rk3528" and not "rockchip,rk3528a"?=
 From
> >>>> what I can see all boards currently supported (and those in this ser=
ies)
> >>>> are having the RK3528A version of the SoC. I didn't follow the devel=
opment
> >>>> here, but there are differences - I did a quick compare of the datas=
heets
> >>>> of those two SoC versions - it looks like RK3528 version has USB3-DRD
> >>>> controller, while RK3528A has USB3 host-only controller. Also it see=
ms to
> >>>> have different video codec IPs and the DRAM controller additionally
> >>>> supports LPDDR4X.
> >>> What datasheet versions did you check? I can only find:
> >>> - RK3528 Rev 1.0 (2023-05-22)
> >>> - RK3528A Rev 1.2 (2024-04-10)
> >> I used
> >>
> >> 2023-07-12 Revision V1.0
> >>
> >> which didn't include these features - which is interesting: Why would a
> >> SoC vendor not try to sell all features in the first place :)
> >>
> >> But I now double checked in
> >>
> >> 2025-05-12 Revision 1.4
> >>
> >> and you are right: It appears there also for RK3528A.
> >>
> >> The only difference I could now make out by comparing v1.4 of both ver=
sions
> >> is the cipher engine: RK3528 additionally supports "SM2/SM3/SM4 cipher=
" -
> >> but still it exists and additionally the different video codec (if mpp
> >> userspace library is correct about that).
> >>
> >> Anyway: My question was more about: Why didn't we choose the correct
> >> compatible from the beginning? And of course the dts files would have =
to be
> >> renamed if the compatible is changed, as they are named according to t=
heir
> >> SoC-compatible.
> > Not sure, possible due to lack of technical documentation for this SoC,
> > to my knowledge all upstream development has been done without any
> > access to a TRM for the SoC.
> Hhm, OK: Without any documentation, I'm seeing "RK3528A" silkscreened
> directly on the SoC package :)

So ... the TRM I meanwhile got, calls itself
	"Rockchip RK3528A Technical Reference Manual"
in the title and=20
	"RK3528A TRM (Part 1)"
on each page.

The one thing with an "A" I remember was the rk3066a. There even was
a rk3066b variant ... which was quite different, but I've never seen any
products using that variant.

So for the things to do:

=2D renaming devicetree _files_ later is no problem ... the given "guarante=
e"
  is that the kernel is supposed to boot with an old devicetree blob, you
  found in the attic ;-) . (if it follows established bindings)
=2D renaming compatibles is more difficult - and a lot of stuff already
  calls itself rk3528 - without-a in a bunch of bindings.

So part of me just sees continuing without-a as the way to go, that
rk3518 mentioned below even has a different number ;-)

And wait until an actual rk3528 b-c-whatever variant needing different
stuff comes along.


Heiko


>=20
> > Based on vendor code (u-boot and linux) there does not seem to be
> > anything special about the A-variant, so my thinking has always been
> > that the A-variant may have just been an updated/fixed hw revision and
> > is the version that went into newer production devices.
> >
> > The recently released U-Boot 2025.07 is referencing the filename
> > rk3528-radxa-e20c.dtb from the synced devicetree-rebasing tree. So a
> > possible rename will affect a future release of U-Boot, and possible
> > devices in the field depending on when a rename would land in linux.
> >
> > For this series I tried to just follow what is currently used for the
> > Radxa E20C.
> >
> > If I am correct there is now also a RK3518 tvbox variant of this SoC,
> > do not know how that would fit into all this :-S
> Yeah, that's why I started comparing the features - and according to
> RK3518's datasheet it only has the features I mentioned in my first mail
> for RK3528A minus PCIe and the ability to connect an external ethernet phy
> to the gmac controller (it probably has only one). Well, it's version 1.0=
 of
> the datasheet ...
>=20
> Regards,
> Alex
>=20
> > Regards,
> > Jonas
> >
> >> Regards,
> >> Alex
> >>> And both list LPDDR4X support and the A-variant seem to list USB3-DRD
> >>> support, did you mix them up above?
> >>>
> >>> I think these SoCs are similar to rk3228/rk3229, rk3228h/rk3328 and n=
ow
> >>> rk3528/rk3528a, in that only the second variant support VP9 decoding.
> >>>
> >>> Use of rockchip,rk3528a compatible could be something to change,
> >>> could also be something that bootloader set at runtime, similar to
> >>> what it does for rk3288w.
> >>>
> >>>> I guess it would be good to discuss this before this series is merge=
d,
> >>>> because re-naming *.dts files after they have been in a release is s=
omewhat
> >>>> impossible.
> >>> I think renaming the device tree files is unnecessary, as there seem =
to
> >>> be very little difference. All boards I have come across are currently
> >>> RK3528A variants. How would we treat the Radxa E20C?, it is not named
> >>> rk3528-radxa-e20c.dtb, yet uses the A-variant.
> >>>
> >>> For mainline U-Boot I have included printing out the SoC-variant,
> >>> however the compatible is not adjusted:
> >>>
> >>>     Model: Radxa E20C
> >>>     SoC:   RK3528A
> >>>     DRAM:  2 GiB
> >>>
> >>> Regards,
> >>> Jonas
> >>>
> >>>> Regards,
> >>>> Alex
> >>>>> The bt/wifi_reg_on pins are described in the device tree using
> >>>>> rfkill-gpio nodes.
> >>>>>
> >>>>> Changes in v3:
> >>>>> - Rename led nodes to led-0/led-1
> >>>>> - Remove pinctrl* props from sdio0
> >>>>> - Collect a-b tags
> >>>>>
> >>>>> Changes in v2:
> >>>>> - Limit sdmmc max-frequency to 100 MHz on ROCK 2A/2F
> >>>>> - Drop clock-output-names prop from rtc node on Sige1 and NanoPi Ze=
ro2
> >>>>> - Drop regulator-boot-on from usb 2.0 host regulators on Sige1
> >>>>> - Add bluetooth and wifi nodes on Sige1
> >>>>> - Collect t-b tag for NanoPi Zero2
> >>>>>
> >>>>> These boards can be booted from emmc or sd-card using the U-Boot 20=
25.07
> >>>>> generic-rk3528 target or work-in-progress patches for these boards =
[1].
> >>>>>
> >>>>> For working bluetooth on ArmSoM Sige1 the patch "arm64: dts: rockch=
ip:
> >>>>> Fix UART DMA support for RK3528" [2] is required.
> >>>>>
> >>>>> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/comm=
its/rk3528
> >>>>> [2] https://lore.kernel.org/r/20250709210831.3170458-1-jonas@kwiboo=
=2Ese
> >>>>>
> >>>>> Jonas Karlman (6):
> >>>>>      dt-bindings: arm: rockchip: Add Radxa ROCK 2A/2F
> >>>>>      arm64: dts: rockchip: Add Radxa ROCK 2A/2F
> >>>>>      dt-bindings: arm: rockchip: Add ArmSoM Sige1
> >>>>>      arm64: dts: rockchip: Add ArmSoM Sige1
> >>>>>      dt-bindings: arm: rockchip: Add FriendlyElec NanoPi Zero2
> >>>>>      arm64: dts: rockchip: Add FriendlyElec NanoPi Zero2
> >>>>>
> >>>>>     .../devicetree/bindings/arm/rockchip.yaml     |  17 +
> >>>>>     arch/arm64/boot/dts/rockchip/Makefile         |   4 +
> >>>>>     .../boot/dts/rockchip/rk3528-armsom-sige1.dts | 465 +++++++++++=
+++++++
> >>>>>     .../boot/dts/rockchip/rk3528-nanopi-zero2.dts | 340 +++++++++++=
++
> >>>>>     .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 293 +++++++++++
> >>>>>     .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 +++
> >>>>>     .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
> >>>>>     7 files changed, 1211 insertions(+)
> >>>>>     create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-armsom-s=
ige1.dts
> >>>>>     create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-nanopi-z=
ero2.dts
> >>>>>     create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.d=
tsi
> >>>>>     create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.=
dts
> >>>>>     create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.=
dts
> >>>>>
>=20





