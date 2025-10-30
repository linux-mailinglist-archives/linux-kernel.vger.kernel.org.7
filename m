Return-Path: <linux-kernel+bounces-877878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFCDC1F3E6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65D8234D8BD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB16341AD0;
	Thu, 30 Oct 2025 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RA7ay26d"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4078D33CEB5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815962; cv=none; b=TiNF+vlRzwt3d+T0F6ihrawRLuXq0AbZr4eY+145QkTknmmyGnZPmJNnJgg1xAzyGwVrz1n3OnT8KA43qdCD8D8DfO4QhbWl89J2Gdt5EZw3MIcVoU7oOidRVlQjDa3nr3ucZwus6XnscjqRAUsvlRqQ6BruqnzlHkh6XeGmBvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815962; c=relaxed/simple;
	bh=DlDTQjPaKp6J+FVUMs+te99gGVccW2aVrvQUcaozCNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TcFQgwRw+U1GhXLv5uwIZRycbkdm9lfk+UQP1xRr4UieRjRSc2w8clEQGf6wdEY4lLuSk0GQeRC7oCvp+cPYFbwsOlI+y/7agp4zijFsVc5OM2ZmuQBF7wpqT8EUIUVXIWiPtE2Q32VQiOkVQlDk+x/Y3CLNfdzJf7aEO0YrgNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RA7ay26d; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so11508105e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761815959; x=1762420759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tPbQqMIhSr6O3bhSUBYsPWZBJsuNCJDVVpT6zmr8+4=;
        b=RA7ay26dQxTFdr+kYG3EydkT1Uf4+cN6snYqyjsKK2l306QdiZ6ciwMBz+XUzU4npG
         xExROe3t4l6ACSZxA3XhTlWueSxWPJSkYFBYuhBuzdUlPsX7aI+g/8o0dsvCAW3HpV5R
         FPldDNBPbkZeOgKd0uxKGI/UnfLf5BvxG1BtEqsq4HXz54TD3VGdqcfY0Wk7XrdpMqNY
         7SudUbRdI+hvnPbDYOt/JzTMaYke2TGvLTeqogsjEfv9Llz5KJdDXGcMHDHA/HOmejHt
         byBJ8XcHhOjJ6BmH3NEtCHAGCjKBEPivJr3QDb74HjEpnJ7qqEeZqFR8h3SpqtvWyUgV
         skog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761815959; x=1762420759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tPbQqMIhSr6O3bhSUBYsPWZBJsuNCJDVVpT6zmr8+4=;
        b=IO4VwYwr0NNUsBu6qZHUvx7X3fU3r5hZk/dkmhQNFcaTC6PhtFqEgoJ3P0t0PBisru
         wWN/NVS7Pg8FbR+prWIkkH3V0PPgaL3rZH4tBIPKlTR+KgiTFs32XQyd7LD07/EtcJJ/
         oaFFZiTvF4hyLN/sh2kqG00NhgGj+pfjReDC7kvYqAPoXPOD2y+Z4OVpcL63n7uhnIIM
         P+AMxcxjuixtKz7ytadcEMp3zIzGfxapUks0V9iLjwYK9+z0xzMrtScNcNpDo9olVcxc
         +yuidfRWB7Lpt36/UEkEN5LKQ2PLHIPU2QPoctHQnzMpZ2ds+yvc3HWIkiJuKRtTOXl6
         pm8g==
X-Forwarded-Encrypted: i=1; AJvYcCUUzGlMXJgwJQ2lr6bPnJIX86fcokh0XDMk5gEhxb0y2gQMRjC0YyCjEp9wwC02HvZccmSNAQ8gRhuBlFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf+LmF6K1+lUZGlJgFV0mK6wYN1HO27jSmVAhyLRwpcTJ1i203
	GzVQgf8qDDuun9A4zZdGsNBPW1xZBb6OpAr2cKhZM0RyCPkWRiH+u4x82c3r1sfMk+c=
X-Gm-Gg: ASbGncv1q3bF7/tIhHAlIVJPbU2V1CtZG2xUIn1kOB5o6z9BjMUtZ95l7rFB0Yux6M3
	ym3SynVjAAa9ryaDaX1c6dXnen8ab+jWCkFGuv2ck/ablrznnKNerh5318jxLIUv2A01oBKanC5
	+aQoSx/Im+UfZFVPYfwaLqbTOaRa9INmbNeDIUGyI5/BgsHKIUUFMOM/0OQmRmJib+By2RJlkAC
	IdGVw07ABoY8mJ1F/MJuYVBW4vfFAUntrjYtu5F2gBSuldjhwvhqfm7JgbrvpE4GV85dUTLS/BP
	tC3iRi8U/REFUelSYxZuanFYepHspnmYWwynaxPZZ597q9xhgxuXnhWnBXXwMZSBbEWATe4MWFC
	s3MhnWLhk20YYY9cUDdYR0ZskI9yIK1j4gOPCWPCXKnYUCxEab2zwCqrv8i0HmtkfKpkPOftCR1
	czrVGqqCL3
X-Google-Smtp-Source: AGHT+IFcE9q/kyflF9AMCkU9/dO/5fz26ntsTtcUbDvLfoDxfh/eegwIiNQAhehq4TE+V1RtsJ7O8Q==
X-Received: by 2002:a5d:5f47:0:b0:429:8b4a:c3a0 with SMTP id ffacd0b85a97d-429b4c0f3f3mr2278972f8f.2.1761815948696;
        Thu, 30 Oct 2025 02:19:08 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477184251c4sm66858255e9.1.2025.10.30.02.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:19:08 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:17:27 +0100
Subject: [PATCH v4 5/6] arm64: dts: ti: k3-am62a7-sk: Set wakeup-source
 system-states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-dt-partialio-v6-15-v4-5-6b520dfa8591@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3575; i=msp@baylibre.com;
 h=from:subject:message-id; bh=DlDTQjPaKp6J+FVUMs+te99gGVccW2aVrvQUcaozCNs=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxm3dIV/ZtySxkD1Na2iyvHt+1lYdc7d415fazqpRsXp
 KyEd4t0lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwERm9jH89/HQeffVbPm8N+lC
 Eo3M0ybf7jdPF1n4Vv3+GYWYfSLXnRn+VzJXzas7fD8rKi9885dFyUunq2yqTy/nnXj/rufFSQu
 SGAE=
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
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 71 +++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index af591fe6ae4f0a91991d2904a9a61905a0eeb614..8525aa5ab812c51e2d3371b39baa5e936e616158 100644
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
@@ -852,4 +892,35 @@ AM62AX_IOPAD(0x008, PIN_INPUT, 0) /* (J24) OSPI0_DQS */
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
 #include "k3-am62a-ti-ipc-firmware.dtsi"

-- 
2.51.0


