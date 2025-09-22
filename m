Return-Path: <linux-kernel+bounces-827813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F2AB932E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773EE2A446D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B9C311959;
	Mon, 22 Sep 2025 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="monluQec"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF9C262D14;
	Mon, 22 Sep 2025 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758571660; cv=none; b=I19avMlohOaBdE5lSq9NuHblwVXvhER4P6JlWkkD8OF44IT1ALGSSHJTA8ZoXPiK2l+9xvLSla2WiKLF1q25pdrq0L5Nhk62YsgQtBj6CQaMBz1rY+TYojcYZ+uAtt9MQOQ/7mfqJPr3qXcaKa7+F+/hUNQ1Q6DByHctfUHNyXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758571660; c=relaxed/simple;
	bh=gtKQtJ/YDcC6QiYeZV6qf7suqJhBgfA3Ye1KfJV9y9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjk0PwD6xCk8F9K/5UHMuRCYPmVxno4qNKcFYZTeA4UShoZEhLpYqSLH6Vs4S61mMoJ/bwqYRWjXcp1XtesgVXH7hG+5RisfwWO0fhyecnB4hrUyDEdXmduvaVFOde9kv8Z7vxKQX20RzTFWyU5VqUEaNgTjVsxjPDJJjQ49I0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=monluQec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E0DC4CEF0;
	Mon, 22 Sep 2025 20:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758571660;
	bh=gtKQtJ/YDcC6QiYeZV6qf7suqJhBgfA3Ye1KfJV9y9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=monluQecJyK0YMI7Arhl/QJKcH/Sl5qAvE49lBKMiiNRTEcsRbHVSI6tfR2nrB5Mp
	 M1mtmvsGAb+4wriRQ7y4QP9+xxnGAXxgCAwjdB3KByeTtGLjBvCaBYeo6qvBerWL1C
	 x3+c9h+fVcrml7zamn/EPGmGbkIvK4Ogh4ltSLrdrU3nGY1BTRYUWYudIQHCvfUOPG
	 aMZWTIVIVnHT6xyxSyD/sIP+/dt4Rdft4QGCafqd+GBQZ07JdadR18cBcnJy17p6z1
	 LwW7IBHzoQgYqrMiyXWY7iLnSE8wa65PEqu/3t9TN+ovogrg1umBsLCJHHrR+FS6ok
	 lU82jti4gwd8Q==
Date: Mon, 22 Sep 2025 15:07:38 -0500
From: Rob Herring <robh@kernel.org>
To: Tan Siewert <tan@siewert.io>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add asrock x470d4u bmc
Message-ID: <20250922200738.GA1124791-robh@kernel.org>
References: <20250919185621.6647-1-tan@siewert.io>
 <20250919185621.6647-3-tan@siewert.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919185621.6647-3-tan@siewert.io>

On Fri, Sep 19, 2025 at 08:56:18PM +0200, Tan Siewert wrote:
> The ASRock Rack X470D4U X470D4U is a single-socket X470-based microATX
> motherboard for Ryzen processors with an AST2500 BMC and either 32MB or
> 64MB SPI flash.
> 
> This mainboard exists in three known "flavors" which only differ in the
> used host NIC, the BMC SPI size and some parts that may be un-populated.
> 
> To keep the complexity low with the BMC SPI, use the 32MB layout
> regardless of the used SPI or mainboard flavor.
> 
> Signed-off-by: Tan Siewert <tan@siewert.io>
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../dts/aspeed/aspeed-bmc-asrock-x470d4u.dts  | 345 ++++++++++++++++++
>  2 files changed, 346 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
> 
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> index aba7451ab749..fae97b5183e5 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>  	aspeed-bmc-asrock-e3c256d4i.dtb \
>  	aspeed-bmc-asrock-romed8hm3.dtb \
>  	aspeed-bmc-asrock-spc621d8hm3.dtb \
> +	aspeed-bmc-asrock-x470d4u.dtb \
>  	aspeed-bmc-asrock-x570d4u.dtb \
>  	aspeed-bmc-asus-x4tf.dtb \
>  	aspeed-bmc-bytedance-g220a.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
> new file mode 100644
> index 000000000000..bae2b521f708
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
> @@ -0,0 +1,345 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/dts-v1/;
> +
> +#include "aspeed-g5.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	model = "Asrock Rack X470D4U-series BMC";
> +	compatible = "asrock,x470d4u-bmc", "aspeed,ast2500";
> +
> +	aliases {
> +		serial4 = &uart5;
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
> +			<&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>,
> +			<&adc 10>, <&adc 11>, <&adc 12>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		heartbeat {

led-0

This should have given you a warning. You did run "make dtbs_check" 
check the warnings, right?

Use "function" to define the function.

> +			/* led-heartbeat-n */
> +			gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "timer";
> +		};
> +
> +		systemfault {

led-1

> +			/* led-fault-n */
> +			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
> +			panic-indicator;
> +		};
> +
> +		identify {

led-2

> +			/* led-identify-n */
> +			gpios = <&gpio ASPEED_GPIO(D, 6) GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +

