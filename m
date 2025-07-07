Return-Path: <linux-kernel+bounces-720634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABC7AFBE8D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36C117FB27
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 23:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A6A2877FA;
	Mon,  7 Jul 2025 23:22:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932F31C3C04;
	Mon,  7 Jul 2025 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751930569; cv=none; b=LBnBPL0hhkGeMZR5Lv9sBCcj+vQN91BWSns1Bx5SGQfQwWik7WD7wnzkM3a7OpuifzcKamFB9vV/eBQNIIiGWcIOVtg2Vh5hsrJBexUtQ83a87bou4b6bN8DZg+YYr8f14jcGgD8KhqpBoddNZX44DC6Zwo5nCepiENGC69fLJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751930569; c=relaxed/simple;
	bh=TVd+BThgguhDuctJHZ7us+KGSDEn3V3ESQwr4IIBBAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDRYmv3QEbDjCh1ffxabUeZNNN6p0OE9BWD4tcG0Fd9wSk51gxE71KfnxhWm0/eE1EHvFXwO5uhMdNYEm3pxgFKr8UaBA8cSPiCnEMsxcCoKPZUDPQgDaoHD0hB5PGeTZn1rW+Evdcb8ZDN/BlgfzA/bJvlaLBSdi+N9dEAowZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67E621595;
	Mon,  7 Jul 2025 16:22:34 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E56F3F66E;
	Mon,  7 Jul 2025 16:22:44 -0700 (PDT)
Date: Tue, 8 Jul 2025 00:20:58 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Lukas Schmid <lukas.schmid@netcube.li>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Maxime Ripard <mripard@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/5] riscv: dts: allwinner: d1s-t113: Add pinctrl's
 required by NetCube Systems Nagami SoM
Message-ID: <20250708002032.71167d46@minigeek.lan>
In-Reply-To: <20250706183601.157523-3-lukas.schmid@netcube.li>
References: <20250706183601.157523-1-lukas.schmid@netcube.li>
	<20250706183601.157523-3-lukas.schmid@netcube.li>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Jul 2025 20:35:55 +0200
Lukas Schmid <lukas.schmid@netcube.li> wrote:

Hi,

> Added the following pinctrl's used by the NetCube Systems Nagami SoM
>   * i2c2_pins
>   * i2c3_pins
>   * i2s1_pins, i2s1_din_pins, i2s1_dout_pins
>   * spi1_pins
> 
> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> ---
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> index e4175adb0..8dc3deccb 100644
> --- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> +++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
> @@ -78,6 +78,36 @@ dsi_4lane_pins: dsi-4lane-pins {
>  				function = "dsi";
>  			};
>  
> +			/omit-if-no-ref/
> +			i2c2_pins: i2c2-pins {
> +				pins = "PD20", "PD21";
> +				function = "i2c2";
> +			};
> +
> +			/omit-if-no-ref/
> +			i2c3_pins: i2c3-pins {
> +				pins = "PG10", "PG11";
> +				function = "i2c3";
> +			};
> +
> +			/omit-if-no-ref/
> +			i2s1_pins: i2s1-pins {
> +				pins = "PG12", "PG13";
> +				function = "i2s1";
> +			};
> +
> +			/omit-if-no-ref/
> +			i2s1_din_pins: i2s1-din-pins {
> +				pins = "PG14";
> +				function = "i2s1_din";
> +			};
> +
> +			/omit-if-no-ref/
> +			i2s1_dout_pins: i2s1-dout-pins {
> +				pins = "PG15";
> +				function = "i2s1_dout";
> +			};
> +
>  			/omit-if-no-ref/
>  			lcd_rgb666_pins: lcd-rgb666-pins {
>  				pins = "PD0", "PD1", "PD2", "PD3", "PD4", "PD5",
> @@ -126,6 +156,12 @@ spi0_pins: spi0-pins {
>  				function = "spi0";
>  			};
>  
> +			/omit-if-no-ref/
> +			spi1_pins: spi1-pins {
> +				pins = "PD10", "PD11", "PD12", "PD13", "PD14", "PD15";

Can you please split this up, to have the MISO/MOSI/CLK signals under a
separate label, so that basic users can reuse this group?
CS should be a separate group, and I guess HOLD and WP can be in
another.

The rest looks alright, compared against the manual.

Cheers,
Andre

> +				function = "spi1";
> +			};
> +
>  			/omit-if-no-ref/
>  			uart1_pg6_pins: uart1-pg6-pins {
>  				pins = "PG6", "PG7";


