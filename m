Return-Path: <linux-kernel+bounces-796564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3433DB402A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A08616B110
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3162E3043BA;
	Tue,  2 Sep 2025 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ov/uQ46s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751972E1F1C;
	Tue,  2 Sep 2025 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819072; cv=none; b=sm4/ml5rb8dCnP+GSSAx8NRDc/I006N7rR3+O8u+k2jJD0699kGlyL1hiA9eohucFauJP7jhcrHDxC9qmJLms0BzKCdg5+7XByQ2KUbe+J6XcCHKvoKc9J4+qTACGAQqJA1mU3kVLFem6+dZqbIqRpQMSryDMw0iAPPGhKyw8s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819072; c=relaxed/simple;
	bh=0xocXOa6y0rnRdA2Z5T9f2V5CZOoroCxOVuasw3Mk80=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=DJcTsq6YJDC3yuw8yFhFGy4NDATSg4nWsmX4ZRbHXfQDu2rgPdaobbUot+bWkAoul5wi40nobGUV32m1EIDJNhbGQIOSlqp2peG1vJT71ousOVefk+B7v++gq7RUM4A+eWnNochkCbCwjeePEjy38JYgeBVdP/zHIRK4a70Fbcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ov/uQ46s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28A0C4CEED;
	Tue,  2 Sep 2025 13:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756819072;
	bh=0xocXOa6y0rnRdA2Z5T9f2V5CZOoroCxOVuasw3Mk80=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ov/uQ46s6uLHRT28cJtvqU4C1PYT6pAHKmdPbhEkLxQlRXtMtWdx3n/NT86WxYUNQ
	 /QemBJckw/cd0Kl7IM9F6QuvSHXE1xkDjxkNDX1RU6bzAnw8GvZJBFagAMj7t9RJ9M
	 5irkdLBSAGWfn56K8XDFA+9HD217jMMXhBD2QmxEd7NxHslC4kVXBuMX3tbaYS1okJ
	 c5IpMkelGqNn2SlB3WCRqMLWKbBNSHiG+m//O67IJcgJWMMILEBtsIIEfO04POm8Ps
	 fsbG2OdRJEAMGPNcPbHwfNMVJuRY6k0ECarHwiOlaL1DmrRVkHAeqE5HfoW+7mKXhC
	 YZCNwUpN9YqYw==
Date: Tue, 02 Sep 2025 08:17:49 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-riscv@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, devicetree@vger.kernel.org, 
 Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev, 
 Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>, 
 Samuel Holland <samuel@sholland.org>
To: Lukas Schmid <lukas.schmid@netcube.li>
In-Reply-To: <20250831162536.2380589-1-lukas.schmid@netcube.li>
References: <20250831162536.2380589-1-lukas.schmid@netcube.li>
Message-Id: <175678730955.877897.3145791714848835564.robh@kernel.org>
Subject: Re: [PATCH v8 0/5] Add support for NetCube Systems Nagami SoM and
 its carrier boards


On Sun, 31 Aug 2025 18:25:29 +0200, Lukas Schmid wrote:
> This series adds support for the NetCube Systems Nagami SoM and its
> associated carrier boards, the Nagami Basic Carrier and the Nagami Keypad
> Carrier.
> 
> Changes in v8:
>   - Use a gpio-mux instead of the gpio-hog for the USB0_SEC_EN signal
>   - Fix the dt-schema issues
> 
> Changes in v7:
>   - Fix the gpio numbering for the USB_SEC_EN gpio hog
>   - Fix the gpio-line-names for the keypad carrier
> 
> Changes in v6:
>   - Add 'usb0-enable-hog' to the som to enable the USB-OTG port by default
>   - Update the keypad carrier dts to match actual board revision
> 
> Changes in v5:
>   - Re-add the non-removable property to the ESP32 interface
>   - Add the mmc-pwrseq node for the ESP32 to initialize the ESP32 correctly
>   - Remove the unused ehci0 and ohci0 nodes from the Keypad Carrier since
>     USB port is peripheral only
> 
> Changes in v4:
>   - Disable the default interfaces on the card-edge but keep the pinctrl
>     definitions for them
>   - Split the pinctrl definitions for the SPI interface into the basic spi
>     pins and the hold/wp pins
>   - Move some mmc0 properties to the Basic Carrier dts
>   - Remove non-removable property from the ESP32 interface
>   - Fix typo in the keypad matrix definition
> 
> Changes in v3:
>   - Add missing dcxo node to the SoM dtsi
>   - Rename the multi-led node
>   - Change dr_mode to "peripheral" for the Keypad Carrier
> 
> Changes in v2:
>  - Squash the binding patches into one patch
>  - Fix formatting of the phy node in the SoM dtsi
>  - Add description on where the phy is located in the SoM dtsi
>  - Fix the phy address in the SoM dtsi
>  - Move the carrier bindings into the same description as enums
> 
> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> ---
> Lukas Schmid (5):
>   dt-bindings: arm: sunxi: Add NetCube Systems Nagami SoM and carrier
>     board bindings
>   riscv: dts: allwinner: d1s-t113: Add pinctrl's required by NetCube
>     Systems Nagami SoM
>   ARM: dts: sunxi: add support for NetCube Systems Nagami SoM
>   ARM: dts: sunxi: add support for NetCube Systems Nagami Basic Carrier
>   ARM: dts: sunxi: add support for NetCube Systems Nagami Keypad Carrier
> 
>  .../devicetree/bindings/arm/sunxi.yaml        |   8 +
>  arch/arm/boot/dts/allwinner/Makefile          |   3 +
>  ...n8i-t113s-netcube-nagami-basic-carrier.dts |  67 +++++
>  ...8i-t113s-netcube-nagami-keypad-carrier.dts | 129 +++++++++
>  .../allwinner/sun8i-t113s-netcube-nagami.dtsi | 250 ++++++++++++++++++
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  48 ++++
>  6 files changed, 505 insertions(+)
>  create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-basic-carrier.dts
>  create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-keypad-carrier.dts
>  create mode 100644 arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami.dtsi
> 
> --
> 2.39.5
> 
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20250829 (best guess, 2/3 blobs matched)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/allwinner/' for 20250831162536.2380589-1-lukas.schmid@netcube.li:

arch/arm/boot/dts/allwinner/sun8i-t113s-netcube-nagami-keypad-carrier.dtb: /soc/i2c@2502800/keypad@34: failed to match any schema with compatible: ['ti,tca8418']






