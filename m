Return-Path: <linux-kernel+bounces-835295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1705CBA6A7C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F71F1890412
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A27929D276;
	Sun, 28 Sep 2025 08:00:10 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD6529BD8C;
	Sun, 28 Sep 2025 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759046410; cv=none; b=BaMVTzhDXa9QrLlF6wPp93MbkBpedDh2U1H94S5cp+xGIcyKpi1FDHy1vfivVnRk4O8EcRYiHoDXDgDQSrh+GxaxZZoMZeNna/NmlOJixzi5/CrK621HE334nXCM2RnATWLixTOvwtNS7lHUhwDpIl79gCSwZ1pkI0dX2NcMtgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759046410; c=relaxed/simple;
	bh=t8+oTToBqxeRTKHXe9jfIOm5UVO8360nSROgjG7l19s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBckgzPLflTpOaKWGhym99umu+S44vALxORQegJ91RqUS6VbGgPyCL7h9XOM2rJKcQcywAutXrxcOYDybM5S44aYH0hyzePlZFMzNWi+rZmD7Mrxw/duoKjI+RXno5Xy0iaHN4tG6QHdv/xesz/XOvwE8xQET4Qi0uYahwygvOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 36C4E340DAF;
	Sun, 28 Sep 2025 08:00:06 +0000 (UTC)
Date: Sun, 28 Sep 2025 16:00:03 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Troy Mitchell <troy.mitchell@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: dts: spacemit: Add MusePi Pro board device
 tree
Message-ID: <20250928080003-GYB1344940@gentoo.org>
References: <20250928-k1-musepi-pro-dts-v1-0-64d0659dfdbc@linux.spacemit.com>
 <20250928-k1-musepi-pro-dts-v1-2-5efcca0ce3ae@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928-k1-musepi-pro-dts-v1-2-5efcca0ce3ae@linux.spacemit.com>

Hi Troy,

On 12:16 Sun 28 Sep     , Troy Mitchell wrote:
> From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> 
> Add initial device tree support for the MusePi Pro board [1].
> The board is using the SpacemiT K1/M1 SoC.
> 
> The device tree is adapted from the SpacemiT vendor tree [2].
> 
> This minimal device tree enables booting into a serial console with UART
> output and a blinking LED.
> 
> Link:
> https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf [1]
> https://gitee.com/bianbu-linux/linux-6.6/blob/k1-bl-v2.2.y/arch/riscv/boot/dts/spacemit/k1-x_MUSE-Pi-Pro.dts [2]
> 
same as patch 1
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  arch/riscv/boot/dts/spacemit/Makefile          |  1 +
>  arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts | 40 ++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
> index 152832644870624d8fd77684ef33addb42b0baf3..76b98096e2a46c3192651d6d66af7742f740c635 100644
> --- a/arch/riscv/boot/dts/spacemit/Makefile
> +++ b/arch/riscv/boot/dts/spacemit/Makefile
> @@ -2,3 +2,4 @@
>  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-bananapi-f3.dtb
>  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-milkv-jupiter.dtb
>  dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-rv2.dtb
> +dtb-$(CONFIG_ARCH_SPACEMIT) += k1-musepi-pro.dtb
please sort

> diff --git a/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> new file mode 100644
> index 0000000000000000000000000000000000000000..3791186ce47b88887eab4321dcd7035668e7f02d
> --- /dev/null
> +++ b/arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
> + * Copyright (C) 2025 Troy Mitchell <troy.mitchell@linux.spacemit.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "k1.dtsi"
> +#include "k1-pinctrl.dtsi"
> +
> +/ {
> +	model = "MusePi Pro";
this is a little bit short, how about make it "SpacemiT MusePi Pro"?

> +	compatible = "spacemit,musepi-pro", "spacemit,k1";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led1 {
> +			label = "sys-led";
> +			gpios = <&gpio K1_GPIO(96) GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +			default-state = "on";
> +		};
> +	};
> +};
> +
> +&uart0 {
..
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_2_cfg>;
swap these two lines, for similar reason, see my comment here
https://lore.kernel.org/all/20250918133209-GYB1273705@gentoo.org/

> +	status = "okay";
> +};
> 
> -- 
> 2.51.0
> 

while you are here, I'd suggest to push as many features as possible
instead of this minimal DT, which say - PMU, emmc, ethernet should be ready..
(ethernet is in next, should show up at v6.18-rc1)

-- 
Yixun Lan (dlan)

