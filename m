Return-Path: <linux-kernel+bounces-882895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA8DC2BC52
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8129434B9DF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C6C307ADD;
	Mon,  3 Nov 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="068+1gBs"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46840313529
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173623; cv=none; b=LKO599mQZq+Loc25aCQsYMM5fZX5dlrg4zFrFF+0vnW1G6gcosy1wEvie2qR6ljRxdrx/yx6NDYKNdAe3acNarGbnJ0xsD4xXODT/dCVOcc5EXMQBibyhwqZEn9vVW0PE4+d1L8GyUV6NrRlwBWNOMJinFYsGiLA598ARkvu2ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173623; c=relaxed/simple;
	bh=PBPbTiaRFBCUflC//sGsNqP/r7El5dOHwJAilCXJgpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XRilk6wpU8SdVGnrMQM+JTe+9u+vvuRP4FNGfRVD6JBCDqkmSW9vmJ0F8ZwmOPwCHbUf47UTkjq0Jrddcc+uduTUs8qEIgNlt3agk6igsqb4vjBN0izKnVKvI9f03A6vmdh20/UbIx2XsIjnN+lOJALX6eCooJdz4AFU5Hr4JE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=068+1gBs; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b5e19810703so581100666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762173619; x=1762778419; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEOzYQjb3bYzTT0+rBoXJ8LwprKU2LjyQuBHnHtCHRU=;
        b=068+1gBssx8bdhH2Xu1b+rj46RtEeOuYzvSj0QnYJzzleFOkZpHz3ps3imJ6CimtWg
         cHbPzylroVhx0JvGLIuxh74tkC661hmvE+1NvqrxxNxQ7ItxPIsO6gYY1HQhOw1laSeD
         uMW/58laUXu1jzI6xKcqmd2YDt0pI+YwDVjJvAPXInkQ/MFrbvjMd9OLufhrD1OAslNx
         pgebytlYqTZdABEqXyYm8nzL3oZdJNtatvqIbZRdgTAVuEbbvHPTgm/h5aWmQWdXbR4X
         M2I/JebDVLrShQsHEc3bCRCz7+csg2b48oX8TlL4/CcU11MLcr0gwmTDSOGMUu6NjqgD
         ZbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173619; x=1762778419;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEOzYQjb3bYzTT0+rBoXJ8LwprKU2LjyQuBHnHtCHRU=;
        b=G6ptsVczgGI0nm7yl6cyTpUWrBveOgKuwk2oHy7+ZTbroQ5B3uIluNYO1/JWD8/i2d
         57FvILG0KoWYwvUEOpkGzHU7wx9/pMusC+xs1Vn4mqZslGlaD6p1NruU3mwbe/Jjm9z0
         NS0CU9kIYS1w5WzoXs/FB4EnunZZrjsd4W+3rMUk90P/Kmm11PYSFUdK7c3CJkrldP6G
         saoUTxdoNdO1K3bfBFRPPsGB5rf5dOIpafjUUZI65AZs8dWI4+7j0mb8IBEw+AS1HM+b
         SzGiJG4WIRC+BJLmZfn4Ntm+X1MLJnzuDSLMaFEmgyyePSPGRxFSRavc8lfX1/hHHy/6
         Qp5A==
X-Forwarded-Encrypted: i=1; AJvYcCW4wc/TJF5lYuEJpIjUPDjo6AD7+pWgb52S98EmRG5AfQpp6xXoTPns4aGGfaRhx0CNd6XQk8MSu8S8vd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwguEu8yuPhjrrO22RBGwmbgsdnaoSEdMD5KNKrzjeJMi25T0r8
	TtzaICiArg5PmFhbi7kWqQ1FkX+vS+eFh/E/PQhIF2xDUMYnpVscHj+5PEiKWrXwQgo=
X-Gm-Gg: ASbGncs6TBGIRmK5jiYCqb1E47vkD+RFcbx0HvV3WLCK7Yr35QMylREIkUG0ekrKqZr
	N24jqU85XgrwetzvS3me401S5GUaf4yumEaVNh5RItnpOaIpEK2VxZ9KuDWN3wI6AEjft7c8ewO
	WzRal4b4miuQsU8KccSzcA20Dq7Gl59MPQI48bPQbq5irVmS7C33ZeH/jCBjM59VBHKcwZdL0J5
	DLOPcIohgYECmp5MdxCPs2J6v1Qm0a+J4j3byys/luvIHuM5gNvXuKca4ajA4C4M3AZIackNAOw
	xyh+FUjVyDmFfor+2R1IAQ/HG+1gpB9+b2Y0bcMhlaOWxbcrg/1vMpjxwiO0N9xwb3/qL0bCo/w
	NppxGpb85ECtW5rgBXXTgYZ5aN50pCVDT1Wa55QfHodefNr7KYPQ2vYkWdquHm/eh+UXuVPyXop
	ebL64NHw==
X-Google-Smtp-Source: AGHT+IHn0eJ3Tu256jIPX9/GzApN5tFapxvyPCs9nNGcBmAd/Kc3dyXibpeRl/PQ7VLIbeGw643Wbg==
X-Received: by 2002:a17:907:d94:b0:b6d:3fc9:e60c with SMTP id a640c23a62f3a-b707016b28cmr1301623866b.20.1762173619542;
        Mon, 03 Nov 2025 04:40:19 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b707bf79e72sm1007193366b.51.2025.11.03.04.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:40:19 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 03 Nov 2025 13:39:33 +0100
Subject: [PATCH v5 6/6] arm64: dts: ti: k3-am62p5-sk: Set wakeup-source
 system-states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-topic-am62-dt-partialio-v6-15-v5-6-b8d9ff5f2742@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3421; i=msp@baylibre.com;
 h=from:subject:message-id; bh=PBPbTiaRFBCUflC//sGsNqP/r7El5dOHwJAilCXJgpw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkyORYtTeNIY98i/fH75983651w+v7YdE53D9Z4567Xyu
 13NmQJaHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCRlJUM/1NnpeWGFTKo3uHZ
 xPzwi9CJnOJze+z3TdAWCdbaUNR2oYORoYcxYY0F21Kr/dO+ta16ZfTm+IE5akd279pXcCDge/X
 0JGYA
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
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 69 +++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index a064a632680ec69dba9dbe591fd49caeb9ac1111..caa2f7d97aca8a48d3f165362601ebdf41d0b2e6 100644
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
@@ -763,4 +803,33 @@ &epwm1 {
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
 #include "k3-am62p-ti-ipc-firmware.dtsi"

-- 
2.51.0


