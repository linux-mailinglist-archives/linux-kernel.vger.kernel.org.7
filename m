Return-Path: <linux-kernel+bounces-877877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1E4C1F410
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F52D19C0206
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE84342170;
	Thu, 30 Oct 2025 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="l+AfI/t1"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C2341AD0
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815950; cv=none; b=Gjz0cxqWA4qZ6I6fWKp3VgQPj54dhyr3wAjT0H8jXJBfywhCGkYmrIbgjaTTj2mW/4f20a15Fy6RPyIKzE9kEXJq+MJGc8l8vedqJIB2uxcXrUH7wgWgUuC73zX6NTJ08LdCHfGKCugarqZOed/hIq4ZPL/KYLBdCP+0BuHxqEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815950; c=relaxed/simple;
	bh=My+67m3RKIYhTGgscnRK/PbLhWzY3WuuDDNXstUgd64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kkdQSUkXa6KETebaNedRldKq1/7D3FtiGgeJ/qNMojhGJTIJiXsZwmNF/9DYBHVRJ9T5qan8fOufCzYrgxR8XVPj10sS+hmh+RYIkr18NkOv0VI1dHhhXTYBnejTOMrlMBVykUULkom5bI8BmgBLwoY312eilm9+waKiUMTTKV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=l+AfI/t1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4710683a644so8323875e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761815947; x=1762420747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8YyqJ4Mpj+JrYYcigX07q99vEPrtstJUifgILYXIvc=;
        b=l+AfI/t1YzGDkPW15xet29P28g7nPvbZLEemQyt/KWARgmFNovw+n01xkiEh684qrb
         39KMqfmGkUCLIXBgh+oAH6rZjpLIWEx0hJIkQZjzFakIoKrQqnWVDPHrFi447jJRxz00
         2XjxaTGqSpgAJxNNpUbC86wzbUhzoXimN8vnIZiGqG8pVu+s+srDPKdMql9feV58OP2J
         WYUK/GGUQL5VM2sQ6m3H1ddX7uriqV3RSCXHMGN4dYWNaPLt04g+FUw6Yp+tABaL7gYT
         m6tfQpD7P4Ac7gJiJXkvzCN5Qu5Bwp6GQKxuu7MEoHs8YGgWLEybhQJ2jjKeEOJKveWq
         heTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761815947; x=1762420747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8YyqJ4Mpj+JrYYcigX07q99vEPrtstJUifgILYXIvc=;
        b=wdUkU/nJs74VHGqdvuVUbpL8JxdxXDf5wpSGrRtCItHL8dIxIqaEgSxBk7a5mcAes3
         DRUEuBNab+bHBMgXZRDqzHni8t4HSH3QHFv+lUoymcAfkpCjP6MT88J6BG1hUAYg9+OR
         9fES4BroWo0TXoTtg9GJBdICv1V+7HGhPxk34P7rCON2zFQ1zwNJ0l5TwSK1tiiABxAu
         UIQo2HXLz29en80za5UeQYJ9+6vtrk9QvdBSNPGoA/r/woBOj1bUTHHwbcMtpd5bCuFo
         sAEPSaMdf5rtzV7x7W5ar9Sk90SrQpUuDSVnGe9mZIHX0/6HP9srF/3A6KsCKSlX964g
         +Dew==
X-Forwarded-Encrypted: i=1; AJvYcCV3w71TtQG7+iWnG5u8Jev8tHjxKOmkXSiDs0mqoOOr616lc5GzrIvm1kAh9qCAvB61krxSFJyyvu4CF2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC+lwvKo61HLF9jsjRgccpeC4rNTYfkbmJaJ+TTbcvWhlnssbu
	G3aURSL3CGyXIXpp4WF4FsZxnXksIOmxbJsSGzcC4VuTVO0XH+34tG2b0uA2VslM2aI=
X-Gm-Gg: ASbGnct63nuBNwju+bh/dzKFqsV43zLtHf17VlUDMbPtZVcD2SrktaobcPndJNRZDEy
	ydLbeIVgzLnR650aObU5xlTbWZZtdErjl/6TweQs5UvWGC2MQECmUea9VPl7DuGekahggPnuIJG
	ylCaU9b5uZimhtkOu4zKcrRhIR5xxhm8qUNQuL73WQ0SzboA25DC4Aac7pMDRhSp2hJQHBnwoLw
	8K/utkw5Z7yhXkoXUMraQCu8Nc0FoIZHGg5PvHS6CsSKz4bAxrcOBk2tLVLXuq2duRSL286xenn
	o5Oq03cZQPpycIegfzT25xS0al7Gfu5h5Ae9RBJpG9NVe+AGpYKqrSW1EarWkBwM7LAtW0Wtwv2
	Q8zUR1OCmu4s2ecUapSkZJXxXw8vZNTxCHK7/CecrS4M4KiJClQ1w1qvkXySRZhti7CGY1x3rsw
	4inWXuNJ9M
X-Google-Smtp-Source: AGHT+IEPj3CdqUuwMe/T9kfHnMLT0T0FRQZVC1TZ7tdmbBSLK4nCwkdMUM8n2LwuCMQiZxEn5qcu3A==
X-Received: by 2002:a05:600c:1554:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-477262ab666mr23564875e9.13.1761815947299;
        Thu, 30 Oct 2025 02:19:07 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952cb7dcsm31938479f8f.11.2025.10.30.02.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:19:06 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:17:26 +0100
Subject: [PATCH v4 4/6] arm64: dts: ti: k3-am62-lp-sk: Set wakeup-source
 system-states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-dt-partialio-v6-15-v4-4-6b520dfa8591@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2978; i=msp@baylibre.com;
 h=from:subject:message-id; bh=My+67m3RKIYhTGgscnRK/PbLhWzY3WuuDDNXstUgd64=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxm3Tzz3bOtZvp0+92u2iM5d/Km8811q6LXq29Xyk3ZH
 7WSXbi4o5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACbSmsLIsOP1d6U7R2Umbjzu
 4xXyLt9smZGbxJFJ766vz52ZqqOu/IqR4dJ+zUWNqusndSS+PLtH7aaXQsFLrasuf1ed69vH8rn
 4KRsA
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


