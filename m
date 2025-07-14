Return-Path: <linux-kernel+bounces-729666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F14FB039EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733FF1884E28
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D390123BF9B;
	Mon, 14 Jul 2025 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="aRlmpvpf"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5D52E3718;
	Mon, 14 Jul 2025 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752483178; cv=pass; b=R0SKT0KNaN2gdk4TRuE3AfC/c23vbjhjWre1+iAQPmfKMvkJCUs1XWaa0Yq0anzo0NfUEhoec4NkyX9x3TM8Mi3LVRPDzCcD5SMGX7Ch39F8vaXckpMOUYjkFpxlkRnd2HdRnmmOdZl6dEBfqcshV5bO+H76dpssD6SSJ6zakHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752483178; c=relaxed/simple;
	bh=89ZBrSM6CUw+jNcJJob/MTrJtZ6+iX1RGAGI/vpn3ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZOJRLLWHlANvDVEUWo37XpNGRZ0sZbiGdKGSaZRqAQUgC1IynMEBy+c+OMvx42X9871krOQ1KfrO1L/89J6utZor7c2Z/galVzaTAvqtZIg4LbA/PydngbnuX6WGbRkP0214qa9ItOK1jNcQ66Vtlqqd401NH/FyGJXiv9b28A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=aRlmpvpf; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752483145; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cPIvEWqgyPzfPU2Pzl4YkZxowH0/lPVy7yb660klPkA6fT6qLmtzHqPgv570Jz8zrXsozQ44gA1ww2BrymQ2I2bgPDcuKY8Fxu/T96rin4jmK7JKOjQ6WugRP+Iyawq3odYVMAUL7I3FlmvCJVTmB7q97Qx72nmGx6jogycH5mY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752483145; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aAmMtPikedDzzrWNEE4etFqjFIi0lZYc3D9DwNk0y+U=; 
	b=jt9y2WhoNnM4SmJsJv9wT7lX2EZq1F/M7CkIQWYOa5TDg2rv+ZD5wAloQvBHMX7Kot22OV/SDCPLYf7mEocKcdL08rt204KOlu6lkMW7Jaa5l6GtNB+zmHpEgvTYuO4pi4zYKFWqB3bPdxNPx7csXPBwUJB59rb/hDddDDWISgI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752483145;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=aAmMtPikedDzzrWNEE4etFqjFIi0lZYc3D9DwNk0y+U=;
	b=aRlmpvpfXLglPznghkrAXTJQRU1ayaqRIDd2Xtwqn98e3zaPKq+fCS7Ph5Q9/HeG
	oFq+8p97xAcDIN9/jWDB5y6IWwZUpLHXfhJHhd5/m+gJ4/fFFrwZWb47N5emgnCZ0qs
	yt86GP4VB9YIYypqen0iUWqG+EUHrtPDpoKEMxlg=
Received: by mx.zohomail.com with SMTPS id 1752483141694960.830248739222;
	Mon, 14 Jul 2025 01:52:21 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Alex Bee <knaerzche@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 linux-rockchip@lists.infradead.org, Kever Yang <kever.yang@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chukun Pan <amadeus@jmu.edu.cn>, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH v3 0/6] arm64: dts: rockchip: Add ROCK 2A/2F,
 Sige1 and NanoPi Zero2
Date: Mon, 14 Jul 2025 10:52:17 +0200
Message-ID: <13801788.uLZWGnKmhe@workhorse>
In-Reply-To: <aHRWmMFTh7leEhrq@pie.lan>
References:
 <20250712173805.584586-1-jonas@kwiboo.se>
 <88c7b90d-4c29-453b-9a5c-9679b371a3a9@gmail.com> <aHRWmMFTh7leEhrq@pie.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hello,

+To: kever, as he may have some insight on the differences between
RK3528 and RK3528A.

On Monday, 14 July 2025 03:00:08 Central European Summer Time Yao Zi wrote:
> On Sun, Jul 13, 2025 at 10:56:59PM +0200, Alex Bee wrote:
> > Hi Jonas,
> > 
> > > Hi Alex,
> > > 
> > > On 7/13/2025 9:13 PM, Alex Bee wrote:
> > > > Hi list, Hi Jonas,
> > > > 
> > > > > This series adds dt-bindings and initial device tree for the following
> > > > > Rockchip RK3528A boards:
> > > > > - Radxa ROCK 2A/2F
> > > > > - ArmSoM Sige1
> > > > > - FriendlyElec NanoPi Zero2
> > > > 
> > > > this only sub-related to this series: Is there any particular reason, why
> > > > we call the compatible "rockchip,rk3528" and not "rockchip,rk3528a"? From
> > > > what I can see all boards currently supported (and those in this series)
> > > > are having the RK3528A version of the SoC. I didn't follow the development
> > > > here, but there are differences - I did a quick compare of the datasheets
> > > > of those two SoC versions - it looks like RK3528 version has USB3-DRD
> > > > controller, while RK3528A has USB3 host-only controller. Also it seems to
> > > > have different video codec IPs and the DRAM controller additionally
> > > > supports LPDDR4X.
> > > What datasheet versions did you check? I can only find:
> > > - RK3528 Rev 1.0 (2023-05-22)
> > > - RK3528A Rev 1.2 (2024-04-10)
> > I used
> > 
> > 2023-07-12 Revision V1.0
> > 
> > which didn't include these features - which is interesting: Why would a
> > SoC vendor not try to sell all features in the first place :)
> > 
> > But I now double checked in
> > 
> > 2025-05-12 Revision 1.4
> > 
> > and you are right: It appears there also for RK3528A.
> > 
> > The only difference I could now make out by comparing v1.4 of both versions
> > is the cipher engine: RK3528 additionally supports "SM2/SM3/SM4 cipher" -
> > but still it exists and additionally the different video codec (if mpp
> > userspace library is correct about that).
> > 
> > Anyway: My question was more about: Why didn't we choose the correct
> > compatible from the beginning? And of course the dts files would have to be
> > renamed if the compatible is changed, as they are named according to their
> > SoC-compatible.
> 
> Just like what Jonas said, I was not aware of any technical
> documentation at the time of writing the basic devicetree, and even for
> now the only datasheet I manage to find is the 2023 revision about
> RK3528 without A suffix, so I didn't realize the difference between
> RK3528 and RK3528A, but just followed the vendor code and devicetree[1],
> where only RK3528 is mentioned :-(

I wouldn't be too worried about getting this wrong, the only set-in-
stone part of this is the name of the device tree for devices and the
compatible; we can still rename rk3528.dtsi to rk3528a.dtsi and shuffle
things around internally. Furthermore, if the only difference is
something that can be enumerated at runtime (e.g. if a different set
of supported features in the crypto accel is identifiable with some
config register bits initial value), then I don't think we need to
distinguish them at all.

As another data point, rkbin mentions "Add support for rk3528A" in the
changelog file `doc/release/RK3528_EN.md` for `rk3528_bl31_v1.15.elf`.

Someone could contrast and compare that BL31 binary with the v1.14 one
to see if they have any immediately obvious differences.

My personal guess for what happened here is that they switched
the packaging process after release to optimize supply, like what
happened with RK3568 -> RK3568B2, and the only change is some OTP
values to identify the chip variant. This would also explain why
everything we've seen on the market so far, at least to my knowledge,
has been RK3528A.

Kind regards,
Nicolas Frattaroli

> 
> Regards,
> Yao Zi
> 
> [1]: https://github.com/rockchip-linux/kernel, branch develop-5.10
> 
> > Regards,
> > Alex
> > > 
> > > And both list LPDDR4X support and the A-variant seem to list USB3-DRD
> > > support, did you mix them up above?
> > > 
> > > I think these SoCs are similar to rk3228/rk3229, rk3228h/rk3328 and now
> > > rk3528/rk3528a, in that only the second variant support VP9 decoding.
> > > 
> > > Use of rockchip,rk3528a compatible could be something to change,
> > > could also be something that bootloader set at runtime, similar to
> > > what it does for rk3288w.
> > > 
> > > > I guess it would be good to discuss this before this series is merged,
> > > > because re-naming *.dts files after they have been in a release is somewhat
> > > > impossible.
> > > I think renaming the device tree files is unnecessary, as there seem to
> > > be very little difference. All boards I have come across are currently
> > > RK3528A variants. How would we treat the Radxa E20C?, it is not named
> > > rk3528-radxa-e20c.dtb, yet uses the A-variant.
> > > 
> > > For mainline U-Boot I have included printing out the SoC-variant,
> > > however the compatible is not adjusted:
> > > 
> > >    Model: Radxa E20C
> > >    SoC:   RK3528A
> > >    DRAM:  2 GiB
> > > 
> > > Regards,
> > > Jonas
> > > 
> > > > Regards,
> > > > Alex
> > > > > The bt/wifi_reg_on pins are described in the device tree using
> > > > > rfkill-gpio nodes.
> > > > > 
> > > > > Changes in v3:
> > > > > - Rename led nodes to led-0/led-1
> > > > > - Remove pinctrl* props from sdio0
> > > > > - Collect a-b tags
> > > > > 
> > > > > Changes in v2:
> > > > > - Limit sdmmc max-frequency to 100 MHz on ROCK 2A/2F
> > > > > - Drop clock-output-names prop from rtc node on Sige1 and NanoPi Zero2
> > > > > - Drop regulator-boot-on from usb 2.0 host regulators on Sige1
> > > > > - Add bluetooth and wifi nodes on Sige1
> > > > > - Collect t-b tag for NanoPi Zero2
> > > > > 
> > > > > These boards can be booted from emmc or sd-card using the U-Boot 2025.07
> > > > > generic-rk3528 target or work-in-progress patches for these boards [1].
> > > > > 
> > > > > For working bluetooth on ArmSoM Sige1 the patch "arm64: dts: rockchip:
> > > > > Fix UART DMA support for RK3528" [2] is required.
> > > > > 
> > > > > [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528
> > > > > [2] https://lore.kernel.org/r/20250709210831.3170458-1-jonas@kwiboo.se
> > > > > 
> > > > > Jonas Karlman (6):
> > > > >     dt-bindings: arm: rockchip: Add Radxa ROCK 2A/2F
> > > > >     arm64: dts: rockchip: Add Radxa ROCK 2A/2F
> > > > >     dt-bindings: arm: rockchip: Add ArmSoM Sige1
> > > > >     arm64: dts: rockchip: Add ArmSoM Sige1
> > > > >     dt-bindings: arm: rockchip: Add FriendlyElec NanoPi Zero2
> > > > >     arm64: dts: rockchip: Add FriendlyElec NanoPi Zero2
> > > > > 
> > > > >    .../devicetree/bindings/arm/rockchip.yaml     |  17 +
> > > > >    arch/arm64/boot/dts/rockchip/Makefile         |   4 +
> > > > >    .../boot/dts/rockchip/rk3528-armsom-sige1.dts | 465 ++++++++++++++++++
> > > > >    .../boot/dts/rockchip/rk3528-nanopi-zero2.dts | 340 +++++++++++++
> > > > >    .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 293 +++++++++++
> > > > >    .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 +++
> > > > >    .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
> > > > >    7 files changed, 1211 insertions(+)
> > > > >    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts
> > > > >    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-nanopi-zero2.dts
> > > > >    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
> > > > >    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
> > > > >    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
> > > > > 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 





