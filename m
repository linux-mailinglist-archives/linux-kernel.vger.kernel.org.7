Return-Path: <linux-kernel+bounces-764418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EBAB222CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747A05057BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB71E2EA473;
	Tue, 12 Aug 2025 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VW56nI3+"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363C2E8DF1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990201; cv=none; b=Wn6t3509CYgwYiHes3zUcpsv2c0Gzs6iA7GTGB9H3Z/4UdYKV2H1jnjyXDFQawSGqtSTt1GbiCzNglT93SPRlBIC6uBWH9AabN4XuV3+BZELZ5YFFx3f9V6h/v1c6JkJZI1tUAnd2eLuuU5A+69Bos4VJxmAp/ECDMrGGrwA3pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990201; c=relaxed/simple;
	bh=us/rMp3k23RwZc1Qh9H3phEU99cwVMWCdJeqp4TweV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i0AsSdPCBA1bDp2IZ6mw05AVhPQAP1sTRJz9yG2Vt0RgRC84dTeqsSz6yU5sPnrf+XB3Z0yxt/2RSqYJ7L6KeTLtXQUCVxH2sBtrVCFmnLqPl3fAb1JJm+wthJsFu2K5m13+WBTAWCAcfNefktEOa6e4ReAAV5G+MUcystaTASk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VW56nI3+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af922ab4849so789431466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754990197; x=1755594997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKKPbk2zjLmByP+VE7hKfl8sJvKaWXdOt8nmsyt9BjM=;
        b=VW56nI3+bH4hH/P+GRr+ji+usxIlIkp1Nmm65A55ihJDoBW0NfBXQCIpjwZUMvetqO
         LCBc8Pjs+DX7gcsHBbz3x+5lv4nYEt0It3NxXT5Smq6W53Q2M/DhWhXVsLSXPObPFJyj
         fxPiZMpdZfVw0ZZBYlED61Ku4A6A2RywhVAB9FTF6RIBAI2DpEBVF1yfjayfQbBWr8lx
         +is/h6wtsqtK8DiGgjLBiaLkmn4tvno9mYT/CLX3tMvPMUtcvZJv+aFu7fpb4vWtx1Wx
         mKcr1B+V+92nTHO1dDw5Z1o7weITIYdIVBYuMW6Y9P1Y0Ggr6NugJwx4KYeUcLD2fq9M
         Q6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990197; x=1755594997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKKPbk2zjLmByP+VE7hKfl8sJvKaWXdOt8nmsyt9BjM=;
        b=Fh4nKFPRNqAIQljTAHDj1DpH6XEEkvQAOmP68KhwKbSPkaMMg5JbdffHZo1zEDgoO5
         zv4EZwiFcpaRqwcPPaNEEE8VyubLvj09Ug8QBwVzrI9pO/cOWbppMV4LZRN/wubCEVDm
         tvXIVR50e/XaTgBc6jOnoZBOGZwx3biCLiLomDp2es5H4mCNd7CBckPAoaNfc+9Yl0sR
         8lvEp8SAA7Xpyt6egSfuAOypwV3uOjSC0iEUORRol/7VqxFE0sFzuQ4w0gIbsAiCgIf9
         SfpFd0G0k6VyRcDuBF2ra4YT7XZKTzeSjqOTyw8kSlhKW532JOIj3IL0Tv4JQHH9CczU
         yBhg==
X-Forwarded-Encrypted: i=1; AJvYcCVypfieweCAkGnxaZp79clZ7ZnZ+6MQm1nvYjX8Qlu26lsig6qbfWjnaGEQjL54NPfXyj7e9bKr2YEC7xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyQ8YlJIYMm4DJodzcGJsSG1T/8K384S3PaOTdl7Bv/v+oME1E
	aANu22nFv1owpGAHeBNcM3AgPQEMgYN6El3Ph+/n+zGmqQd5+7Ion323Ji/z0QvS0nk=
X-Gm-Gg: ASbGncsiB2tf64DOPmPRTNLt3AlWDrafzTFHtt0VKOd5VlQz+PvXaTkLFaBrPDdsi1X
	78WR+1BflpetQChipZZdLTmh0qnxPxK7ad2q0GCF5M+e4YXNIWu6t11/KHz8duUQxeeaPYZhreP
	U7vtsqmjgKM7MUhzbbmrWXQQJV1tbLXYvNdTTUNWte6Mm9OUU0JQNsm/XMrHAHDDiN/xRvKc16E
	F3+uWEPytaN6ziQMBQTMfRwPs5R2SliOE9ZkhkiNcDmT0P5tfy08As2fK/dfLfycEpur/K0Wk7C
	tG5dYP5TG0tnB+HXaqnidQbcTfaI5DJ1coofuCVq1g0ye4/ZnuEpm312NWpen21sxJ1N9aE901f
	AYDx1rY/6cEgXfTJWIw==
X-Google-Smtp-Source: AGHT+IEgkIjROZI/Yz+CBqPaPHop4dqppzi0LKkPjz7/zfImtMWZEtkEpTDytLSR1EZwKCTNbupqMA==
X-Received: by 2002:a17:906:794a:b0:af3:7645:43e1 with SMTP id a640c23a62f3a-afa1df5e53fmr257639366b.17.1754990197493;
        Tue, 12 Aug 2025 02:16:37 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8691:4b7a:7bbd:bac:c56e])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-af91a0a37a8sm2181325866b.40.2025.08.12.02.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:16:37 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 12 Aug 2025 11:15:25 +0200
Subject: [PATCH v2 6/7] arm64: dts: ti: k3-am62a7-sk: Set wakeup-source
 system-states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-topic-am62-dt-partialio-v6-15-v2-6-25352364a0ac@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3528; i=msp@baylibre.com;
 h=from:subject:message-id; bh=us/rMp3k23RwZc1Qh9H3phEU99cwVMWCdJeqp4TweV0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhozZbElvJ4dv3vD162bNiPfXcv6vSzKoYDvBoiQQ3HS4e
 3HFeUnZjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjIpVcM//QaP0od4jj67HkJ
 77x78qH/AxdUxy+/8yXNW/VIf/oWi1ZGhpns8zijFqz8IX83+uV/ZicR7RdXmAur7ype7dsvPfH
 iLk4A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

The CANUART pins of mcu_mcan0, mcu_mcan1, mcu_uart0 and wkup_uart0 are
powered during Partial-IO and IO+DDR and are capable of waking up the
system in these states. Specify the states in which these units can do a
wakeup on this board.

Note that the UARTs are not capable of wakeup in Partial-IO because of
of a UART mux on the board not being powered during Partial-IO.

Add pincontrol definitions for mcu_mcan0 and mcu_mcan1 for wakeup from
Partial-IO. Add these as wakeup pinctrl entries for both devices.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

- Combine k3-am62a7-sk.dts devicetree nodes
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 71 +++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index bceead5e288e6d78c671baf0afabd1a9aa23fbee..55cab49f26382f08e2cc93d17afc424af8c59caa 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -257,6 +257,10 @@ AM62AX_MCU_IOPAD(0x0030, PIN_OUTPUT, 0) /* (C8) WKUP_UART0_RTSn */
 &wkup_uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_uart0_pins_default>;
+	wakeup-source = <&system_io_ddr>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
 	status = "reserved";
 };
 
@@ -450,6 +454,42 @@ pmic_irq_pins_default: pmic-irq-default-pins {
 			AM62AX_MCU_IOPAD(0x000, PIN_INPUT, 7) /* (E11) MCU_GPIO0_0 */
 		>;
 	};
+
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
 };
 
 &mcu_gpio0 {
@@ -935,3 +975,34 @@ AM62AX_IOPAD(0x008, PIN_INPUT, 0) /* (J24) OSPI0_DQS */
 		>;
 	};
 };
+
+&mcu_mcan0 {
+	pinctrl-names = "default", "wakeup";
+	pinctrl-0 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_default>;
+	pinctrl-1 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_wakeup>;
+	wakeup-source = <&system_partial_io>,
+			<&system_io_ddr>,
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
+			<&system_io_ddr>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
+	status = "okay";
+};
+
+&mcu_uart0 {
+	wakeup-source = <&system_io_ddr>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
+};

-- 
2.50.1


