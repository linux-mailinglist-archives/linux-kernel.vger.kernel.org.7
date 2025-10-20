Return-Path: <linux-kernel+bounces-860514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2574BF04B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF670188F148
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAA33F9FB;
	Mon, 20 Oct 2025 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b="aptjzpRb"
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E5523D29A;
	Mon, 20 Oct 2025 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.156.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953628; cv=none; b=N1Qc+Fn7q18XyZF2gLAo8YjNsq+Z6XHIJV3Aqu/VstN+NeBSxD1PDlXhlXifM4kY9GtNqBbbuGOAfmtUtSYdcoim/bdUiAwaYzEr4NXIo74RX08BdueGjcQCCiTe+6cG8CxQpS2RuzYj/t8PjOn4SpPMSAEHsHcVLtz7iggIzxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953628; c=relaxed/simple;
	bh=I6MEwWVoT8bn+A9rQd+UdRZGsHz/qLFaZYAb75feCiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2I3dwDXUCm80h+suXPmOU+e8RBl4ScqI1FfLOHKgGnHQlb/0N3Sh9ZiddAX+DvLN3/JyOSc+LYtCgu4j34U92PX1s07mYofKf8Us0pk8ZSj/JTW+XRfqa97LZ3aE5rrUX0DWqDR4lV48TOf/9bqpe3eLJLhz/FAsH/bFQ8420c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; spf=pass smtp.mailfrom=bewilderbeest.net; dkim=pass (1024-bit key) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.b=aptjzpRb; arc=none smtp.client-ip=71.19.156.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bewilderbeest.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1760953240;
	bh=OCbONFN78XpgRKAC0O9n8v5Ot2s4SJuk+oXKqyYYcm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aptjzpRbLNK18PePpTlYK3Ta3tm2B6yYpVnLCfkvKXEfjhNNsUocyvhpodPmW0RkQ
	 XbIVRPvkYeiN+LQR7b4xuv9p8RAWaVVuvm4PvRXEdlpSb/YJmzRcAGorehH7XYDEdi
	 Oc8ODPoqb2YI4tkvMxpHazLfnCJFMCt6GB29oHdk=
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:713c:eb00::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 94B0B1BF;
	Mon, 20 Oct 2025 02:40:40 -0700 (PDT)
Date: Mon, 20 Oct 2025 02:40:33 -0700
From: Zev Weiss <zev@bewilderbeest.net>
To: Tan Siewert <tan@siewert.io>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: add asrock x470d4u bmc
Message-ID: <c6ee0814-1d36-45b5-8598-2a30efeee5a5@hatter.bewilderbeest.net>
References: <20251011112124.17588-1-tan@siewert.io>
 <20251011112124.17588-3-tan@siewert.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251011112124.17588-3-tan@siewert.io>

On Sat, Oct 11, 2025 at 04:21:20AM PDT, Tan Siewert wrote:
>The ASRock Rack X470D4U X470D4U is a single-socket X470-based microATX
>motherboard for Ryzen processors with an AST2500 BMC and either 32MB or
>64MB SPI flash.
>
>This mainboard exists in three known "flavors" which only differ in the
>used host NIC, the BMC SPI size and some parts that may be un-populated.
>
>To keep the complexity low with the BMC SPI, use the 32MB layout
>regardless of the used SPI or mainboard flavor.
>
>Signed-off-by: Tan Siewert <tan@siewert.io>
>---
>v2:
>  - fix led node names [robh]
>  - fix missing gfx memory region and other offenses [Tan]
>---
> arch/arm/boot/dts/aspeed/Makefile             |   1 +
> .../dts/aspeed/aspeed-bmc-asrock-x470d4u.dts  | 350 ++++++++++++++++++
> 2 files changed, 351 insertions(+)
> create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
>
>diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
>index 0f0b5b707654..c601af36915e 100644
>--- a/arch/arm/boot/dts/aspeed/Makefile
>+++ b/arch/arm/boot/dts/aspeed/Makefile
>@@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
> 	aspeed-bmc-asrock-e3c256d4i.dtb \
> 	aspeed-bmc-asrock-romed8hm3.dtb \
> 	aspeed-bmc-asrock-spc621d8hm3.dtb \
>+	aspeed-bmc-asrock-x470d4u.dtb \
> 	aspeed-bmc-asrock-x570d4u.dtb \
> 	aspeed-bmc-asus-x4tf.dtb \
> 	aspeed-bmc-bytedance-g220a.dtb \
>diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
>new file mode 100644
>index 000000000000..e9804b0ace9f
>--- /dev/null
>+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
>@@ -0,0 +1,350 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+/dts-v1/;
>+
>+#include "aspeed-g5.dtsi"
>+#include <dt-bindings/gpio/aspeed-gpio.h>
>+#include <dt-bindings/leds/common.h>
>+#include <dt-bindings/interrupt-controller/irq.h>
>+
>+/ {
>+	model = "Asrock Rack X470D4U-series BMC";
>+	compatible = "asrock,x470d4u-bmc", "aspeed,ast2500";
>+
>+	aliases {
>+		serial4 = &uart5;
>+	};
>+
>+	chosen {
>+		stdout-path = &uart5;
>+	};
>+
>+	iio-hwmon {
>+		compatible = "iio-hwmon";
>+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
>+			<&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>,
>+			<&adc 10>, <&adc 11>, <&adc 12>;
>+	};
>+
>+	leds {
>+		compatible = "gpio-leds";
>+
>+		led-heartbeat {
>+			/* led-heartbeat-n */
>+			gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
>+			color = <LED_COLOR_ID_GREEN>;
>+			function = LED_FUNCTION_HEARTBEAT;
>+			linux,default-trigger = "timer";
>+		};
>+
>+		led-systemfault {
>+			/* led-fault-n */
>+			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
>+			color = <LED_COLOR_ID_AMBER>;
>+			function = LED_FUNCTION_FAULT;
>+			panic-indicator;
>+		};
>+
>+		led-identify {
>+			/* led-identify-n */
>+			gpios = <&gpio ASPEED_GPIO(D, 6) GPIO_ACTIVE_LOW>;
>+		};
>+	};
>+
>+	memory@80000000 {
>+		reg = <0x80000000 0x20000000>;
>+	};
>+
>+	reserved-memory {
>+		#address-cells = <1>;
>+		#size-cells = <1>;
>+		ranges;
>+
>+		pci_memory: region@9a000000 {
>+			no-map;
>+			reg = <0x9a000000 0x00010000>; /* 64K */
>+		};
>+
>+		video_engine_memory: jpegbuffer {
>+			size = <0x02800000>;	/* 40M */
>+			alignment = <0x01000000>;
>+			compatible = "shared-dma-pool";
>+			reusable;
>+		};
>+
>+		gfx_memory: framebuffer {
>+			size = <0x01000000>;
>+			alignment = <0x01000000>;
>+			compatible = "shared-dma-pool";
>+			reusable;
>+		};
>+	};
>+};
>+
>+&adc {
>+	status = "okay";
>+	pinctrl-names = "default";
>+	pinctrl-0 = <&pinctrl_adc0_default		/* 3VSB */
>+			&pinctrl_adc1_default		/* 5VSB */
>+			&pinctrl_adc2_default		/* VCPU */
>+			&pinctrl_adc3_default		/* VSOC */
>+			&pinctrl_adc4_default		/* VCCM */
>+			&pinctrl_adc5_default		/* APU-VDDP */
>+			&pinctrl_adc6_default		/* 1V05-PROM-S5 */
>+			&pinctrl_adc7_default		/* 2V5-PROM */
>+			&pinctrl_adc8_default		/* 1V05-PROM-RUN */
>+			&pinctrl_adc9_default		/* VBAT */
>+			&pinctrl_adc10_default		/* 3V */
>+			&pinctrl_adc11_default		/* 5V */
>+			&pinctrl_adc12_default>;	/* 12V */
>+};
>+
>+&ehci1 {
>+	status = "okay";
>+};
>+
>+/*
>+ * Although some board flavors have a 64MB SPI, use the
>+ * 32MB SPI layout to be compatible with all boards.
>+ */
>+&fmc {
>+	status = "okay";
>+	flash@0 {
>+		status = "okay";
>+		label = "bmc";
>+		m25p,fast-read;
>+		spi-max-frequency = <10000000>;
>+#include "openbmc-flash-layout.dtsi"
>+	};
>+};

Hmm -- I can see the simplicity argument, but it seems a bit of a shame 
to let the other 32MB go to waste on boards with 64MB chips (especially 
given how tight a fit OpenBMC is getting in 32MB these days).

Could we maybe have an aspeed-bmc-asrock-x470d4u-64.dts alongside this 
one that #includes it and then drops in the 64M layout over the default 
32?  You could then arrange for a flag in the OpenBMC bitbake recipes to 
opt in to using that dts if you want to.


Zev


