Return-Path: <linux-kernel+bounces-877879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857DBC1F40B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641E6400AED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F5A3451CD;
	Thu, 30 Oct 2025 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nYH0ENTQ"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F4319617
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815963; cv=none; b=CU2qYCb8LFVHa59vd1Z7seDWtJGX3Mq3fLlsXoqgEdkeeh1+nGbzP+FatacMc/NEb7BoLQgD2BFSLoJg5Pq0MzMM9a5yRPa3CZPSwTYnrCepxsVR2GXSXI9XyZza6CjJkjczdBrIVot4HhxAxCYVIi5sfy2JKy942CXH1s+R/CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815963; c=relaxed/simple;
	bh=fmSTQ+NAhyqd5hnJaZ0RF1b/fo5Oy35WVR6j4Ev0AlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aHXsyzv3a/3xagvtCoQJlTu4nWYNAiAAvHqWsuJWdox3UhXTtR8pJgeEh/bhzgYKxZD88CR5szu8QRasEqt9AlSeIM1HYvnbmjyW5mj1fuveHYfMwS7MikatMuwWexb4fSO1Iqhqh4nSGsbFuIqxYbtR2GapLCzNKJJshx5Slhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nYH0ENTQ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-426fc536b5dso503001f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761815960; x=1762420760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wv1v1rCyNVZow/EufS/6YnSEiovq7wLtWvMHkvWDLt8=;
        b=nYH0ENTQEsCWpLHUUCtYR+GF0uvzVvNS5eE23domnDyzFrQTBxO2Xr2P4jEXIk/7WX
         EIMOOpZNngtktFtDvUT8cG7fjIUMEKHttyjMU7XzwS48wOBmlTDJnU7qSt7e/yzxIpSo
         KaDatqlno+Y6988BJMZfs/JSuTeKxufIDWAfAddiyLVnHeAXP/lJHUROIkwkuBSl3u8U
         54OQc8KHjX4rH7QPigy0rl+pgUgh7d5whLst3jODjVvAfh0ieVOVwdq8QNK0F7g5KGGG
         6/j7x0h0uQyfvmeugQ3oGwmpskk+BP32zvc+Cb5twj7PUEnoSTBGIuuv1HtTCYO/WiWJ
         RSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761815960; x=1762420760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wv1v1rCyNVZow/EufS/6YnSEiovq7wLtWvMHkvWDLt8=;
        b=iZM4xFncZ9ZJBN2O6U6EbyZih2vxaurMR3w9AnsZpRHX6Po5GnlMsMTQ6VBuMnZ0We
         +/9hcSlhcxvYVeyRPEGcYhp6WZ6V1cRjpnzgBHVjFzIz85pNCDRSV+SwyUEVKIxjbsH4
         BJ+OpPcH/FCOtUg6bejlb6q1bYeJKmwkdTdEsIHuq+ggJrAC6+pwcN2OmOkLsNQguJi8
         n8cT2eD0couE/y+EbJ+XwXPufpYRjBU3n2K+kPF32Qf/hLMviMoX4ykCm9ly2gB9NnuN
         Fe67WzcUp/3Na/NH3PTxFMze/cCRW4GSb9wNqrEyY9NGfOlKd2FlnGCinDPMvVhqaBvN
         9xqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEjXfcrgoHU2OJy5DZrgw6i+iZIVRRluUvgO7w1Rm35BpOGKmJBGtRKpArXA2rzixVaJvAYtkS5UkC71M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3FiDfsivRrtl9XjMMX2jBBUEHBy6h+yqx9G/sSkg7ZOieSOe4
	XSBLTvX9e2jReBwCvJORxUtvZUXNm3DA26ennUJSm7bqTFzoB8gDf9W3Jr2Hck22nT8=
X-Gm-Gg: ASbGncvHr8Lbd7OX2tle/gm1NCaKBxioykVCvoSEBxZ3RXf1KLxahbSl3WAZxQRlJb5
	AYmj1nAZANEaquVfZ3X8RIz8wwEku8Un+atnImtzmTvP6Nrs1DkLfA7t2EvFiKKScqIyV/F1VeP
	p4D1UDTecGWG5qDEjTtvDdGIDRuD3vtzxZEui7arfvKMxMV4JuAKWw4FyVcdwp6s5tn3e2fXYe+
	TOiaDYaqkEdPkMrLRgWX4ZRI7opddip9wftkhnWiMnvHZGQDf3XXa/WYshCIuiH3bwP/ADp0whv
	nASY3q8fBg6fWGOAbTl4DXyYN+kQ2A0XOqvVVUHRaIbUKyU2PhmXow8LvXMLpdO6jgvkgQ6lzq2
	nsWV05sbqRA4Xc8fu+M+ZU/kBiKxI2q3cZyEmeCpuTnknml3QoKl2vmkcO+rZd5iSbUhxs8Gfyg
	==
X-Google-Smtp-Source: AGHT+IFFqwsdTXuFRrWP5NVqrkbjoDC7E0r4aa1TEQNijfGZoanbwnRQzyG3OWW1GIVKppxS8yiu3g==
X-Received: by 2002:a05:6000:2212:b0:3ee:1461:1654 with SMTP id ffacd0b85a97d-429aeff11f1mr4513188f8f.50.1761815959934;
        Thu, 30 Oct 2025 02:19:19 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952de971sm30461198f8f.39.2025.10.30.02.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:19:19 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:17:28 +0100
Subject: [PATCH v4 6/6] arm64: dts: ti: k3-am62p5-sk: Set wakeup-source
 system-states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-dt-partialio-v6-15-v4-6-6b520dfa8591@baylibre.com>
References: <20251030-topic-am62-dt-partialio-v6-15-v4-0-6b520dfa8591@baylibre.com>
In-Reply-To: <20251030-topic-am62-dt-partialio-v6-15-v4-0-6b520dfa8591@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3461; i=msp@baylibre.com;
 h=from:subject:message-id; bh=fmSTQ+NAhyqd5hnJaZ0RF1b/fo5Oy35WVR6j4Ev0AlA=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxm3ZrbPitYVvvZd3cU7/SIMVksJbTW7bU3bwXj5pRO5
 ZPte307SlkYxLgYZMUUWToTQ9P+y+88lrxo2WaYOaxMIEMYuDgFYCKqrxn+ZwtPNp19c4b7RENZ
 9zUz59fdurXgd7mzwuraX7mmZwRvJjEynA/6cnghy0nxXV9vnah+KJCu8Hv67Feii1c061av0S8
 5wwMA
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
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 71 +++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index a064a632680ec69dba9dbe591fd49caeb9ac1111..36116210fbe6111ee8bb9a1736ed02bec0f20b67 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -716,12 +716,52 @@ AM62PX_MCU_IOPAD(0x028, PIN_OUTPUT, 0)	/* (D7) WKUP_UART0_TXD */
 		>;
 		bootph-all;
 	};
+
+	mcu_mcan0_tx_pins_default: mcu-mcan0-tx-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x034, PIN_OUTPUT, 0) /* (D6) MCU_MCAN0_TX */
+		>;
+	};
+
+	mcu_mcan0_rx_pins_default: mcu-mcan0-rx-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x038, PIN_INPUT, 0) /* (B3) MCU_MCAN0_RX */
+		>;
+	};
+
+	mcu_mcan0_rx_pins_wakeup: mcu-mcan0-rx-wakeup-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x038, PIN_INPUT | PIN_WKUP_EN, 0) /* (B3) MCU_MCAN0_RX */
+		>;
+	};
+
+	mcu_mcan1_tx_pins_default: mcu-mcan1-tx-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x03c, PIN_OUTPUT, 0) /* (E5) MCU_MCAN1_TX */
+		>;
+	};
+
+	mcu_mcan1_rx_pins_default: mcu-mcan1-rx-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x040, PIN_INPUT, 0) /* (D4) MCU_MCAN1_RX */
+		>;
+	};
+
+	mcu_mcan1_rx_pins_wakeup: mcu-mcan1-rx-wakeup-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x040, PIN_INPUT | PIN_WKUP_EN, 0) /* (D4) MCU_MCAN1_RX */
+		>;
+	};
 };
 
 &wkup_uart0 {
 	/* WKUP UART0 is used by DM firmware */
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_uart0_pins_default>;
+	wakeup-source = <&system_io_ddr>,
+			<&system_deep_sleep>,
+			<&system_mcu_only>,
+			<&system_standby>;
 	status = "reserved";
 	bootph-all;
 };
@@ -763,4 +803,35 @@ &epwm1 {
 	status = "okay";
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
+
 #include "k3-am62p-ti-ipc-firmware.dtsi"

-- 
2.51.0


