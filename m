Return-Path: <linux-kernel+bounces-882894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A02C2BD03
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012B93B98A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511CE31355D;
	Mon,  3 Nov 2025 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oX90j611"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5B31326D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173622; cv=none; b=pHaY9ZmSJXJ0TyDXDN6Rh6CL1CRXr+dnCDtOPe7jsxQXDj7T8MLwXk+MXoIAF3VY1oHZp8vmriEQe4PQFrd/Xfv632B9H0JWGdn8y0a78Ngjf+V6ZC2FIu6MqrMlJNgJdINT5ua8ZUmx+GzKnZIVN5+2lWJvNrd1wlffiTsH3Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173622; c=relaxed/simple;
	bh=My+67m3RKIYhTGgscnRK/PbLhWzY3WuuDDNXstUgd64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNhivdTTKv0I88eCuzi2bu18ZIdbYsITAspPBV/TzaX+JO5Plo7PNN4qPojIKbS5BAnc8XfN+a5kHAuJQ22unKFLvQJhl7/N1gQlS0RT+RmeqR6HeaAl8jJEHVTXLkIi8nflNuKnlGx8FWGeD3RmLlpRxbaUPTcrdJr9gkvTvHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oX90j611; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so3042373a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762173617; x=1762778417; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8YyqJ4Mpj+JrYYcigX07q99vEPrtstJUifgILYXIvc=;
        b=oX90j611PjbAoLZVNiPcYH2egsx4la4TnSSRH84IMoAOzKEPdZMzZH8FCIYJfTeMkO
         Daxorto9fWjS04FpyF9lLIE/LQ8YCngjOhrPnCtm4aU8rJI1wpQTRq4hxn0YHCVF0NVU
         snP3xnizoD3mrUyxrGE+ElPfOxmAmAOpWi9aKqhP/llNJeoesrB9y2M9DGQa86WrSVtd
         weYufAeZsDcKHT0vkzys5l32/ub45BkuyZXOuq8NYZChSs6XTSCv2SvDRPFqjCSvfa/k
         RQw73/TlPbaKMV7WkXsDInOuCBwy91C0JaGB+FqMZShbfukor+mLo9DItDU6ERj69o1Z
         46yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173617; x=1762778417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8YyqJ4Mpj+JrYYcigX07q99vEPrtstJUifgILYXIvc=;
        b=V4/ROyk4Jp+R+hq4qBkwaqE+mKbnIn6iG+2l7Sq49Twnwoh2CUdDxtuJM2ZGAwhAov
         yUEXaNqL0vh8XUxdEsYIP8z7j1tC1TkfG8BOFSLAVBhqfyvyozVekS8unAlO40S88wxD
         QW/nbWxtlAE6HWxoR9cpnvu7h8sbH+COesOjjNcV6PHhigeNvVi6ofT24lDdR0HcYDX6
         W8ud1OEPyNz6+4SXi8Vnw3fpbz3s53KXhGWBpNM7Nr3xTbqOx19VYa2Y8bcFPdEiKgaU
         QYroms0jMN2g62YfppOAd1xZTUfG4BxxoA75iO7nZ6JhoiErY3rtVTD9MgreRe/CSn8A
         QrbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbpPTW4k5UaNLSZHbayy10QM60SC+G3dDXd8NBtBs8kjrQ5ain6D1TQADZT2a0XcJGTl5cwNx5C6JOCfM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3JF5kuyzgyi63bFy3KesyW7gT7qA0A3voXfdSTbYW9LtY5IFg
	lEMrZqrwiNzTKsj4KmqOrYVSmT0hzo1JZdnM+j31sQjfXfgdQxbdmi3Y5vX0opa3474=
X-Gm-Gg: ASbGncs/dNIm84DYRnH+YgePh1Bq5G6CTU9OjlixB35AfRTIz/jpOWStEaqjN7DlMCR
	7vsg4vNcp6lEp7UilkBKR2O2C+ULz7e56sTThM+M6x4CUMxcb4HtYZuFAOrdSRt8XpcUki51pPS
	9UvKg5CZKHXgVqqKNMt+nCrerkZekFZy3UPNPPQYzFTy2YHzZAQWoY1PBw0srAn6c9c5ItotTrW
	ooI2R6r7sZ7evFiOD9UCCMrZbkS1nt3upkuFxasQW2QF6a4AC0hzmjpiyr5MPt53k41HFYX32sb
	8mo2Q3S3ZZqUr5w0O1R2vMEs7EoPdU9rDMOWQ/B1tZARPo0BVllm0JQG50yOKkCl3314Cm4PiLn
	X1iJoS2jD7DtR7pmA9S5B7urtlcssKtjMZOB58hPpxas6/g2U8PLFfhBFT76RZQbDr5KuM5Y=
X-Google-Smtp-Source: AGHT+IGIaEPB9InpMwc7+C802tcMPSbzxBhJrtyKVRnUVFSYpjnjRtfxcKkqDE6hgYF9CpxesRD8Iw==
X-Received: by 2002:a05:6402:2710:b0:640:c394:5c7 with SMTP id 4fb4d7f45d1cf-640c3940662mr2707319a12.11.1762173617422;
        Mon, 03 Nov 2025 04:40:17 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6407b428119sm9481228a12.24.2025.11.03.04.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:40:16 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 03 Nov 2025 13:39:31 +0100
Subject: [PATCH v5 4/6] arm64: dts: ti: k3-am62-lp-sk: Set wakeup-source
 system-states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-topic-am62-dt-partialio-v6-15-v5-4-b8d9ff5f2742@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2978; i=msp@baylibre.com;
 h=from:subject:message-id; bh=My+67m3RKIYhTGgscnRK/PbLhWzY3WuuDDNXstUgd64=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkyORTOPO5yvm8u56fd3jrNzt1YtvaaytLv2ttjODfoTd
 2cpVy8x7ihlYRDjYpAVU2TpTAxN+y+/81jyomWbYeawMoEMYeDiFICJCGxl+GfU3lGzrc5gTaG3
 SptW9omwRe82HUiM5auuqucqOvH8xkpGhgeeXTmbdByWnyz2KDtz+Py61TP0K3v32Rj2/0iI+ul
 6kwEA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

The CANUART pins of mcu_mcan0, mcu_mcan1, mcu_uart0 and wkup_uart0 are
powered during Partial-IO and I/O Only + DDR and are capable of waking
up the system in these states. Specify the states in which these units
can do a wakeup on this board.

Note that the UARTs are not capable of wakeup in Partial-IO because of
of a UART mux on the board not being powered during Partial-IO. As I/O
Only + DDR is not supported on AM62x, the UARTs are not added in this
patch.

Add pincontrol definitions for mcu_mcan0 and mcu_mcan1 for wakeup from
Partial-IO. Add these as wakeup pinctrl entries for both devices.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index ecfba05fe5c273c671cd0968f3eceaf54d22ac7d..cb63db337b2bc4c83b48dde693b95dd9fd93cd26 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -276,3 +276,63 @@ &main_gpio1 {
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
+			AM62X_IOPAD(0x038, PIN_INPUT | PIN_WKUP_EN, 0) /* (B3) MCU_MCAN0_RX */
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
+			AM62X_IOPAD(0x040, PIN_INPUT | PIN_WKUP_EN, 0) /* (D4) MCU_MCAN1_RX */
+		>;
+	};
+};

-- 
2.51.0


