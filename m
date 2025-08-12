Return-Path: <linux-kernel+bounces-764417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F7AB222B1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 246A37AA725
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6BA2EA463;
	Tue, 12 Aug 2025 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XOwnmq1c"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA32E9738
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990200; cv=none; b=OLEIKCf5fbxhRPhEAlT/4tqIMUxmmQhj7tRhPe1sII8T/BLYoKivl0d02T0TzllJLJgLCaeazhpiLnBF8B1+nMENFBCUUjaew3Ni4EPQdNQqcQQqfXkT2OS6FFOX49n8haRNZh8gLI/xJ3YcvgK9HPE+qyciGfuAh5Zy/efERFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990200; c=relaxed/simple;
	bh=OPrdV/kq3oQ4NMu6+ZP/Aox16FucBvf0qyM2mttIasw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YUskuzU/uneg9UARr+lvAgtWKw8OwBBGmx4rBLE/wV1WVVmKQ3qL/rCJL1uGZOeHSNwL/1Fb63+oGwf/C05J1sY23xeZAuVErxZZoHrBqvR9YTEJqyrw9ENdso+qT/VFPNWIoiTl3YLXy/Jfcaiw+CPgeyls2Cwc6qW9tJThK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XOwnmq1c; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af8fd1b80e5so931365566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754990196; x=1755594996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UcUtzC99ftVpjJ1J3VgzsG5YR1VSr0yd8VomMVp9if8=;
        b=XOwnmq1cDjxpCh5cWAisZZKkev1FvSjX+VnmYACgDbF92JNQvg44gfP0kEJXvuHVBO
         Ajl0VerYIvDdixNNLiUBzBFVP+/ZQstZN3BtJZcR+Zf3wp3wnzxMW1oFSxrusO+uFyOD
         EiYRvQbQ5Q44MzmW8/KUt98TqNSqpxn3Xs5aETtXN9TdckKIjwlmKupnDCFzItPzpbIJ
         mdIhHbgFrXt8vzbpkUYViNh2AMI81hn2Sa4Ikdt+DY+j3mD/iwjraw9yseQsp9qW2xxA
         kKc5jUFqGBSwjqRyhA3Iaz9PVblaCOiUTUY2z0CwUq8M92ZCEymsTo+4vjYl34AIARsY
         S0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990196; x=1755594996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcUtzC99ftVpjJ1J3VgzsG5YR1VSr0yd8VomMVp9if8=;
        b=YJvkSB6LcefiQo7Mbw89L+Lg5uhaAclmjIme1JG6y0rs1plZIpMT88rZHPBn2TpqMw
         /ABnnuoDJtwfXClgjmcmD+gpCSwEeK4Uj5OrHyiY8qX1oC7R5We0jcJ8Fq85b2lMULEC
         XdRpIMEiCRHY/RPydKSLcJ4/4zoeZ+6ihoxEI3tMk3e1ycD/4ocIJAVEXdBv1TBdgdd2
         ZQgtAQ5O3cKP7+odfF4tMbVsmuLvvwSj6dF2xvBFPaFTGvHq7lsnw0owGbi0ywO+Hll2
         cMDc7bzirrzz2kgzPG4BSWObcH9V/jSycfdQcmQjcMx/QoojTT0yEAWxdAADMJnrVh56
         5beA==
X-Forwarded-Encrypted: i=1; AJvYcCUX/TFtefjxWar2qfhbmqds4LJui2OK15Rd5hlViNhb7V4Y+ZSLHN4V/rGgnI18QErpfFjavT1OtIdh3uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzmeFXn1fuUrl4PXZh3dtfA8iqJKTNEjSosrdBkRqS1XZktw7O
	KeYeg2c8ccv9k6FXNLxE60QOL5j/lOin7uy+fSWhpcGhQ0ghNa2zT34xbtSii2C24kw=
X-Gm-Gg: ASbGncshqXcsuXwFVbyvaDSZ5uwvLjF3xb/+HRO86ucp7S1aWmYyEYwPNrr+QZjkh5A
	d5fwbysFRUEPNTyl36VDsyFV9ROveYvt8Kt5wNw9/JLJa4MkprGzVF648dd/9oMhuOtJ/7jBPxq
	6GQrHqChfej921eCq1Sl46QaiIUhBsF6mZvdne0dwkCC1Hfz8L7Wx0nUqvdcfHiwGGJ//pTXQLY
	b7uGejV97IQFD3fuufDEfqa6oHjd7aVY8+1d621XaU5V6jFeL1BouWY5BR6+Ki26dEEB16OnjIv
	C2HCOJoEF47UocS14tnvSe5bGEQ4yTslJjrBGKeVeULPmZ7qoCyP3dJsTSGaiEuK3/Bq/N3a0Mu
	Gf/ohOx8M+5lugXTFkQ==
X-Google-Smtp-Source: AGHT+IGjmqCb8DEPLnwSyiS2QWeezAQQ+KKWlCxBysNRgGnNSYGKAawEo108hymrlXQ0G//GA/rI2w==
X-Received: by 2002:a17:907:980a:b0:af7:37d1:93b6 with SMTP id a640c23a62f3a-afa1dff7b28mr245132966b.15.1754990196377;
        Tue, 12 Aug 2025 02:16:36 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8691:4b7a:7bbd:bac:c56e])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af91a23fec4sm2174076666b.121.2025.08.12.02.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:16:35 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 12 Aug 2025 11:15:24 +0200
Subject: [PATCH v2 5/7] arm64: dts: ti: k3-am62-lp-sk: Set wakeup-source
 system-states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-topic-am62-dt-partialio-v6-15-v2-5-25352364a0ac@baylibre.com>
References: <20250812-topic-am62-dt-partialio-v6-15-v2-0-25352364a0ac@baylibre.com>
In-Reply-To: <20250812-topic-am62-dt-partialio-v6-15-v2-0-25352364a0ac@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2943; i=msp@baylibre.com;
 h=from:subject:message-id; bh=OPrdV/kq3oQ4NMu6+ZP/Aox16FucBvf0qyM2mttIasw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhozZbHFznnLvnFN71nNa7RbZsizHJx1t1zdy/vpZ8oNZu
 1byWd3OjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZhIqwvDPz3xjKeuj+amsZ6Z
 8Wwms9bqXUxJXnxrhVQ4lIu2LE0K/sfI8OH83Eklmz5P9pN5tudYSuKFIF+Oym6dbf6NAfIzTzg
 e4AIA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

The CANUART pins of mcu_mcan0, mcu_mcan1, mcu_uart0 and wkup_uart0 are
powered during Partial-IO and IO+DDR and are capable of waking up the
system in these states. Specify the states in which these units can do a
wakeup on this board.

Note that the UARTs are not capable of wakeup in Partial-IO because of
of a UART mux on the board not being powered during Partial-IO. As
IO+DDR is not supported on am62, the UARTs are not added in this patch.

Add pincontrol definitions for mcu_mcan0 and mcu_mcan1 for wakeup from
Partial-IO. Add these as wakeup pinctrl entries for both devices.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index 4609f366006e4cdf0c162f72634ce90623f60a90..0314f857ea05acc4ffc62bccb5184e58d19a6103 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -268,3 +268,63 @@ &main_gpio1 {
 &gpmc0 {
 	ranges = <0 0 0x00 0x51000000 0x01000000>; /* CS0 space. Min partition = 16MB */
 };
+
+&mcu_mcan0 {
+	pinctrl-names = "default", "wakeup";
+	pinctrl-0 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_default>;
+	pinctrl-1 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_wakeup>;
+	wakeup-source = <&system_partial_io>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
+	status = "okay";
+};
+
+&mcu_mcan1 {
+	pinctrl-names = "default", "wakeup";
+	pinctrl-0 = <&mcu_mcan1_tx_pins_default>, <&mcu_mcan1_rx_pins_default>;
+	pinctrl-1 = <&mcu_mcan1_tx_pins_default>, <&mcu_mcan1_rx_pins_wakeup>;
+	wakeup-source = <&system_partial_io>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
+	status = "okay";
+};
+
+&mcu_pmx0 {
+	mcu_mcan0_tx_pins_default: mcu-mcan0-tx-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x034, PIN_OUTPUT, 0) /* (D6) MCU_MCAN0_TX */
+		>;
+	};
+
+	mcu_mcan0_rx_pins_default: mcu-mcan0-rx-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x038, PIN_INPUT, 0) /* (B3) MCU_MCAN0_RX */
+		>;
+	};
+
+	mcu_mcan0_rx_pins_wakeup: mcu-mcan0-rx-wakeup-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x038, PIN_INPUT | WKUP_EN, 0) /* (B3) MCU_MCAN0_RX */
+		>;
+	};
+
+	mcu_mcan1_tx_pins_default: mcu-mcan1-tx-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x03c, PIN_OUTPUT, 0) /* (E5) MCU_MCAN1_TX */
+		>;
+	};
+
+	mcu_mcan1_rx_pins_default: mcu-mcan1-rx-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x040, PIN_INPUT, 0) /* (D4) MCU_MCAN1_RX */
+		>;
+	};
+
+	mcu_mcan1_rx_pins_wakeup: mcu-mcan1-rx-wakeup-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x040, PIN_INPUT | WKUP_EN, 0) /* (D4) MCU_MCAN1_RX */
+		>;
+	};
+};

-- 
2.50.1


