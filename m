Return-Path: <linux-kernel+bounces-882893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FBCC2BC49
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 016173475A4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FD6313559;
	Mon,  3 Nov 2025 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B93wK5Mg"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593493126AB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173622; cv=none; b=MqDWnpz4GejMs6oDckXIFN6+dECVmX5JgeGUBOP0mz4lbYmwFLUpyUcv1ZRRPOymtYVwKqZoieqg+KCThh+hfgHQ+vaidL2uv4zrsKv1ZC2J96ftOKMFUjaw/WtXhqKfH17lrWuNxAaCEwhGlTbpQt2G7ndOKywEl41d5yLOwmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173622; c=relaxed/simple;
	bh=HUyVsZ1Uo+y8zY0jQWgZxPIdkvaeFXYf2apVmFo9zRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hiy0ERovu2DhuWI+NL3WVxFgwc38HZMxQxutFyAuVlkMpL1JTb83GN5sAObWlkUMXQU02nmlgYtcgZFE2byLwTtreorFHNT79j20cxyBE9TE2hZ8XU2os/tGJWw3qUuERiYHiNH42nCiC+mtIKcnN4gYd0zdv8GLtSHyELTJHCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B93wK5Mg; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b6d3effe106so666958666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762173619; x=1762778419; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4x8toXQoMnFvquaDgnJ+GkHe0JMDPrO2jJ2prwKygxE=;
        b=B93wK5MgiUstp9j9pH+jh7+QO7d/MB0l7/ysHKc826C5YoViozySAIBS2+spmG2EhV
         LoiFXl4rSMOkuVSvJLFtLvAUi1PcMOBR48Sx7BvmWfD8rWNbhcRnpcdQJF28biL9x1Dz
         mvMGh43PEi+b2xpmVdjxXATq9etbSwD1ZsSmqE5G3bfTMn2DZh1+Fa6YJ0/a6sSrLdzo
         maVY7XQT7AUKLL9iN+s4JVAhT1I9Cc0Dj5MQAKHn6cfVzxsAt01jtZzQOb7la6RBD2/H
         UCPyRuPBKNkPCk1pub6MKw6y/sUBMw7nN1VjxX53eVSjRZDWDvmSqHKtqRI8QAW/LhCo
         j/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173619; x=1762778419;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4x8toXQoMnFvquaDgnJ+GkHe0JMDPrO2jJ2prwKygxE=;
        b=aP59TKuJv4Q+uhQkIHHemzdTlpSXU+Hww1aubcuGlUSP9HJnUk6wIaGS6ae7hupNIQ
         MSUXavVGk1ELOc9jlVugRUQsh7d9bK3qm77JSxcLVujhaWAB14edigA6nbTRj4I72+jJ
         90Php6lk0d2MXBlOp2MNXjwG4dIJZtGba5rNNFm29/AZx1jcyPsjQOr/K3RXYSBmjm+x
         jfFB9SpFhyUl1LKE3o+N5GIkQBJPP7nRJz66seMBtrHK74M8Z/iiBCPb21D5ipTfREeM
         OSCZSvF9/RSZOQP+Ptqri4HtIniMU9Apcml9HKnxVX5QW8GCoLsGjgcpgj+68BjOGVIP
         5/Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUT/+FLHq0VBJtTiUq/gO++RJDU3qNBfvKHsfw8xeS6vLJlyFc7sLRuknQ/4oJnHkSLZ1xtBq9nUjis7BU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp/XAqEeuHw2RVkHOU6D1Y3g1+cC7PemDi1U+QAhUHFougXO3h
	6QAhIQI9LtcW0+lq6QdrrtyPpvZuZ+QyYlVDAhtifhboGKfFWCOPcBphBOiUlVqF8IA=
X-Gm-Gg: ASbGnctWzkDKlFeKYbAP/SvM9a80CFxU9tkqLmHyRV8de1uMHpY/hPieqrJyqI5/px/
	5z9htla/QeaoCFK9vWGuL1M/KsMq6tr4DqAGRMBbs4LkMV+G5VdtVsgZWshDg89MRkTeV9jtd97
	06+2PWErmbBc67zc96Y/WZ3+pu76wsM80m+9Oi0pMjFPGvPBY0h6jPdxX+QtcBFf6+DghWhmf9Q
	sxWOO+ngX/x6hwzFDSN230WJHniA4l/9EazNXJhfoaCXPa02Spfj3cNAos4zLoGhhxMGK5RMux+
	EYu023QvwsgVJsA0xrq7llMutuwIq5WmfbXZXKzoPr/VeHkaoKhCkIGU2PhtvgnvCQhwzj6bIlh
	T2BpgAe6uEHo2AfnOVWhvAC9WcCXiGNuMGtX/E1w1d1ANMQjlWr0ddmzZsqvnYUBiJt7fdqE=
X-Google-Smtp-Source: AGHT+IHV/4ImtALhytuKHNJv14h0KzIDzlo+tB1lyxS9YabYqtnsudfPUUOoQRyLSp22oOCAqc45fw==
X-Received: by 2002:a17:907:1c94:b0:b4b:cb5:133a with SMTP id a640c23a62f3a-b70704b9243mr1143893666b.39.1762173618456;
        Mon, 03 Nov 2025 04:40:18 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b71012241a7sm254039766b.14.2025.11.03.04.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:40:18 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 03 Nov 2025 13:39:32 +0100
Subject: [PATCH v5 5/6] arm64: dts: ti: k3-am62a7-sk: Set wakeup-source
 system-states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-topic-am62-dt-partialio-v6-15-v5-5-b8d9ff5f2742@baylibre.com>
References: <20251103-topic-am62-dt-partialio-v6-15-v5-0-b8d9ff5f2742@baylibre.com>
In-Reply-To: <20251103-topic-am62-dt-partialio-v6-15-v5-0-b8d9ff5f2742@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3535; i=msp@baylibre.com;
 h=from:subject:message-id; bh=HUyVsZ1Uo+y8zY0jQWgZxPIdkvaeFXYf2apVmFo9zRw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkyORfPc0vYtnOlx/EXs80U3apNyJ379LFi17yrPjdbYg
 wYyErO0O0pZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAi96QY/um4cqWLPPF59cht
 8/85QjbWcze7ql6usnZ+vnB70cqN13UZGW6suePT2S/SPP+G86x9K7hZ5t1dzbX0yJ39OlNaU0+
 xW7EBAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

The CANUART pins of mcu_mcan0, mcu_mcan1, mcu_uart0 and wkup_uart0 are
powered during Partial-IO and I/O Only + DDR and are capable of waking
up the system in these states. Specify the states in which these units
can do a wakeup on this board.

Note that the UARTs are not capable of wakeup in Partial-IO because of
of a UART mux on the board not being powered during Partial-IO.

Add pincontrol definitions for mcu_mcan0 and mcu_mcan1 for wakeup from
Partial-IO. Add these as wakeup pinctrl entries for both devices.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 69 +++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index af591fe6ae4f0a91991d2904a9a61905a0eeb614..b61370db6986308ec97983f796b993a26debcabc 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -233,6 +233,10 @@ AM62AX_MCU_IOPAD(0x0030, PIN_OUTPUT, 0) /* (C8) WKUP_UART0_RTSn */
 &wkup_uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_uart0_pins_default>;
+	wakeup-source = <&system_io_ddr>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
 	status = "reserved";
 };
 
@@ -426,6 +430,42 @@ pmic_irq_pins_default: pmic-irq-default-pins {
 			AM62AX_MCU_IOPAD(0x000, PIN_INPUT, 7) /* (E11) MCU_GPIO0_0 */
 		>;
 	};
+
+	mcu_mcan0_tx_pins_default: mcu-mcan0-tx-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_MCU_IOPAD(0x034, PIN_OUTPUT, 0) /* (D6) MCU_MCAN0_TX */
+		>;
+	};
+
+	mcu_mcan0_rx_pins_default: mcu-mcan0-rx-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_MCU_IOPAD(0x038, PIN_INPUT, 0) /* (B3) MCU_MCAN0_RX */
+		>;
+	};
+
+	mcu_mcan0_rx_pins_wakeup: mcu-mcan0-rx-wakeup-pins {
+		pinctrl-single,pins = <
+			AM62AX_MCU_IOPAD(0x038, PIN_INPUT | PIN_WKUP_EN, 0) /* (B3) MCU_MCAN0_RX */
+		>;
+	};
+
+	mcu_mcan1_tx_pins_default: mcu-mcan1-tx-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_MCU_IOPAD(0x03c, PIN_OUTPUT, 0) /* (E5) MCU_MCAN1_TX */
+		>;
+	};
+
+	mcu_mcan1_rx_pins_default: mcu-mcan1-rx-default-pins {
+		pinctrl-single,pins = <
+			AM62AX_MCU_IOPAD(0x040, PIN_INPUT, 0) /* (D4) MCU_MCAN1_RX */
+		>;
+	};
+
+	mcu_mcan1_rx_pins_wakeup: mcu-mcan1-rx-wakeup-pins {
+		pinctrl-single,pins = <
+			AM62AX_MCU_IOPAD(0x040, PIN_INPUT | PIN_WKUP_EN, 0) /* (D4) MCU_MCAN1_RX */
+		>;
+	};
 };
 
 &mcu_gpio0 {
@@ -852,4 +892,33 @@ AM62AX_IOPAD(0x008, PIN_INPUT, 0) /* (J24) OSPI0_DQS */
 	};
 };
 
+&mcu_mcan0 {
+	pinctrl-names = "default", "wakeup";
+	pinctrl-0 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_default>;
+	pinctrl-1 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_wakeup>;
+	wakeup-source = <&system_partial_io>,
+			<&system_io_ddr>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
+};
+
+&mcu_mcan1 {
+	pinctrl-names = "default", "wakeup";
+	pinctrl-0 = <&mcu_mcan1_tx_pins_default>, <&mcu_mcan1_rx_pins_default>;
+	pinctrl-1 = <&mcu_mcan1_tx_pins_default>, <&mcu_mcan1_rx_pins_wakeup>;
+	wakeup-source = <&system_partial_io>,
+			<&system_io_ddr>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
+};
+
+&mcu_uart0 {
+	wakeup-source = <&system_io_ddr>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
+};
+
 #include "k3-am62a-ti-ipc-firmware.dtsi"

-- 
2.51.0


