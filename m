Return-Path: <linux-kernel+bounces-729263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD1CB0340A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 03:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337251899CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 01:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED511624DD;
	Mon, 14 Jul 2025 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="L2Cl8Gez"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A0C1FC3;
	Mon, 14 Jul 2025 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752454827; cv=none; b=SLcdlBW4J2xkYnSEhnMC4Rn9nc6E+3/TXkA0qdy4mp00QjzFm7h43ao6W++VY6qxGA534WmVVyfUFPjDs7fXb+/bKghSznsIis68OjkoNBUP6GFtwIDTD05J7+l0jMbv6YtYrpVPHlg4sfXjqJjPXRYFBi8Ih4OoUWqnR7gO8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752454827; c=relaxed/simple;
	bh=/PImNDpsKBHTO5j8+6O63P7nRRG2EcEQFHDZOqoJskc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kR+ik5ApRKV7gCL9qoTBblD7DTuicKAC6cExWmgifcO43C1D4/OPZZUKKorh/9pDkPxcb2iHhtZTNuSvyveXi8V7Is69kmnTvsE0Cf8+T34nYRjp0ZJVYKLJ1PgIxu80/qLK+Z3ZidsNr9Eq/o4sL1k9TZuYecOs+sxb/oUdIBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=L2Cl8Gez; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 43FC020E25;
	Mon, 14 Jul 2025 03:00:22 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kg2EVRnGv0KQ; Mon, 14 Jul 2025 03:00:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1752454820; bh=/PImNDpsKBHTO5j8+6O63P7nRRG2EcEQFHDZOqoJskc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L2Cl8GezlIwKoGgZFR8yBr8t4BeY99hAAyG2YOMFivhA13G8l1yvip8kC9fOsAsDa
	 0QfQnVByuNOBylf+8CkyBNKLvHl0WmYxPSBu5TQBbO1LUJlBF3FNt29WTOrWf6LnyJ
	 y4zDEwyRudmKlhtTAFasswlprzXe2fZHP8eVb8iGJb8ZvzebnRdG1UVGcT8ocArvKK
	 YG1WnAI3vPTipgF3WCudVKsN4iOHxXMXZWryN/IpfZXtkznwofBKsH0l6CoqeKnx08
	 pywbyqrW52aTWNq38Tu2RvI4ETeG3DubsNIoqW6d836NLPrr3Xuf8E8oJDurYEYI/i
	 j0N+xUOJkz16w==
Date: Mon, 14 Jul 2025 01:00:08 +0000
From: Yao Zi <ziyao@disroot.org>
To: Alex Bee <knaerzche@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] arm64: dts: rockchip: Add ROCK 2A/2F, Sige1 and
 NanoPi Zero2
Message-ID: <aHRWmMFTh7leEhrq@pie.lan>
References: <20250712173805.584586-1-jonas@kwiboo.se>
 <702dc4bb-7b3c-4647-b84f-8516989b0836@gmail.com>
 <9aae8b30-23ae-4866-9ce8-02bbc8b44a82@kwiboo.se>
 <88c7b90d-4c29-453b-9a5c-9679b371a3a9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88c7b90d-4c29-453b-9a5c-9679b371a3a9@gmail.com>

On Sun, Jul 13, 2025 at 10:56:59PM +0200, Alex Bee wrote:
> Hi Jonas,
> 
> > Hi Alex,
> > 
> > On 7/13/2025 9:13 PM, Alex Bee wrote:
> > > Hi list, Hi Jonas,
> > > 
> > > > This series adds dt-bindings and initial device tree for the following
> > > > Rockchip RK3528A boards:
> > > > - Radxa ROCK 2A/2F
> > > > - ArmSoM Sige1
> > > > - FriendlyElec NanoPi Zero2
> > > 
> > > this only sub-related to this series: Is there any particular reason, why
> > > we call the compatible "rockchip,rk3528" and not "rockchip,rk3528a"? From
> > > what I can see all boards currently supported (and those in this series)
> > > are having the RK3528A version of the SoC. I didn't follow the development
> > > here, but there are differences - I did a quick compare of the datasheets
> > > of those two SoC versions - it looks like RK3528 version has USB3-DRD
> > > controller, while RK3528A has USB3 host-only controller. Also it seems to
> > > have different video codec IPs and the DRAM controller additionally
> > > supports LPDDR4X.
> > What datasheet versions did you check? I can only find:
> > - RK3528 Rev 1.0 (2023-05-22)
> > - RK3528A Rev 1.2 (2024-04-10)
> I used
> 
> 2023-07-12 Revision V1.0
> 
> which didn't include these features - which is interesting: Why would a
> SoC vendor not try to sell all features in the first place :)
> 
> But I now double checked in
> 
> 2025-05-12 Revision 1.4
> 
> and you are right: It appears there also for RK3528A.
> 
> The only difference I could now make out by comparing v1.4 of both versions
> is the cipher engine: RK3528 additionally supports "SM2/SM3/SM4 cipher" -
> but still it exists and additionally the different video codec (if mpp
> userspace library is correct about that).
> 
> Anyway: My question was more about: Why didn't we choose the correct
> compatible from the beginning? And of course the dts files would have to be
> renamed if the compatible is changed, as they are named according to their
> SoC-compatible.

Just like what Jonas said, I was not aware of any technical
documentation at the time of writing the basic devicetree, and even for
now the only datasheet I manage to find is the 2023 revision about
RK3528 without A suffix, so I didn't realize the difference between
RK3528 and RK3528A, but just followed the vendor code and devicetree[1],
where only RK3528 is mentioned :-(

Regards,
Yao Zi

[1]: https://github.com/rockchip-linux/kernel, branch develop-5.10

> Regards,
> Alex
> > 
> > And both list LPDDR4X support and the A-variant seem to list USB3-DRD
> > support, did you mix them up above?
> > 
> > I think these SoCs are similar to rk3228/rk3229, rk3228h/rk3328 and now
> > rk3528/rk3528a, in that only the second variant support VP9 decoding.
> > 
> > Use of rockchip,rk3528a compatible could be something to change,
> > could also be something that bootloader set at runtime, similar to
> > what it does for rk3288w.
> > 
> > > I guess it would be good to discuss this before this series is merged,
> > > because re-naming *.dts files after they have been in a release is somewhat
> > > impossible.
> > I think renaming the device tree files is unnecessary, as there seem to
> > be very little difference. All boards I have come across are currently
> > RK3528A variants. How would we treat the Radxa E20C?, it is not named
> > rk3528-radxa-e20c.dtb, yet uses the A-variant.
> > 
> > For mainline U-Boot I have included printing out the SoC-variant,
> > however the compatible is not adjusted:
> > 
> >    Model: Radxa E20C
> >    SoC:   RK3528A
> >    DRAM:  2 GiB
> > 
> > Regards,
> > Jonas
> > 
> > > Regards,
> > > Alex
> > > > The bt/wifi_reg_on pins are described in the device tree using
> > > > rfkill-gpio nodes.
> > > > 
> > > > Changes in v3:
> > > > - Rename led nodes to led-0/led-1
> > > > - Remove pinctrl* props from sdio0
> > > > - Collect a-b tags
> > > > 
> > > > Changes in v2:
> > > > - Limit sdmmc max-frequency to 100 MHz on ROCK 2A/2F
> > > > - Drop clock-output-names prop from rtc node on Sige1 and NanoPi Zero2
> > > > - Drop regulator-boot-on from usb 2.0 host regulators on Sige1
> > > > - Add bluetooth and wifi nodes on Sige1
> > > > - Collect t-b tag for NanoPi Zero2
> > > > 
> > > > These boards can be booted from emmc or sd-card using the U-Boot 2025.07
> > > > generic-rk3528 target or work-in-progress patches for these boards [1].
> > > > 
> > > > For working bluetooth on ArmSoM Sige1 the patch "arm64: dts: rockchip:
> > > > Fix UART DMA support for RK3528" [2] is required.
> > > > 
> > > > [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528
> > > > [2] https://lore.kernel.org/r/20250709210831.3170458-1-jonas@kwiboo.se
> > > > 
> > > > Jonas Karlman (6):
> > > >     dt-bindings: arm: rockchip: Add Radxa ROCK 2A/2F
> > > >     arm64: dts: rockchip: Add Radxa ROCK 2A/2F
> > > >     dt-bindings: arm: rockchip: Add ArmSoM Sige1
> > > >     arm64: dts: rockchip: Add ArmSoM Sige1
> > > >     dt-bindings: arm: rockchip: Add FriendlyElec NanoPi Zero2
> > > >     arm64: dts: rockchip: Add FriendlyElec NanoPi Zero2
> > > > 
> > > >    .../devicetree/bindings/arm/rockchip.yaml     |  17 +
> > > >    arch/arm64/boot/dts/rockchip/Makefile         |   4 +
> > > >    .../boot/dts/rockchip/rk3528-armsom-sige1.dts | 465 ++++++++++++++++++
> > > >    .../boot/dts/rockchip/rk3528-nanopi-zero2.dts | 340 +++++++++++++
> > > >    .../boot/dts/rockchip/rk3528-rock-2.dtsi      | 293 +++++++++++
> > > >    .../boot/dts/rockchip/rk3528-rock-2a.dts      |  82 +++
> > > >    .../boot/dts/rockchip/rk3528-rock-2f.dts      |  10 +
> > > >    7 files changed, 1211 insertions(+)
> > > >    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-armsom-sige1.dts
> > > >    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-nanopi-zero2.dts
> > > >    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2.dtsi
> > > >    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2a.dts
> > > >    create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-rock-2f.dts
> > > > 

