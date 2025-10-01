Return-Path: <linux-kernel+bounces-839062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB59BB0BC6
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1FA3C18DD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D994F30277F;
	Wed,  1 Oct 2025 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fOtAU7L9"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4CF2FCBF1
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329327; cv=none; b=OEbgrYQcN96jXwfwFF3CetDknQtlacYAGYQrCV2Bp7E9L6pCW8LxVsZyN7Ls2foaRmR2gjdLr2f6yb8/umONRz1whNvozV5IzVJYiOB9dQovERgVFmXTWiqyVor67vp1AWeA8fCsaJ05e4D3gr0i37mEfowA5PpnXay/ERWmtGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329327; c=relaxed/simple;
	bh=fmSTQ+NAhyqd5hnJaZ0RF1b/fo5Oy35WVR6j4Ev0AlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nR3vNXXE2U5BEJz8QvT1QbEsatxMfS7UZSPNK4lR323tEQMhS1cL3jL68qf8HhA8kvFMtWJY2ZihRFh5e7b9Ged8RWmTzxitnyMMnAmROE9mYMWvXQK5G/zLi3zLIcBa2vBK964qrsvSyQs8SXtKf1IGkEbP3S3jgChPYBJx/f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fOtAU7L9; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-636de696e18so318141a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759329323; x=1759934123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wv1v1rCyNVZow/EufS/6YnSEiovq7wLtWvMHkvWDLt8=;
        b=fOtAU7L9nJF2PGvJwISkBUEGqihK0pBaIYQwjV8kDlNTiZ3KYtHg7nh5tKHyN16aO1
         eETZTsMCxhE0JnElaSknurdBh9C2cWoZDQypLnEVFwzeguL2+8Cn8cTnht3xHNqLkPDD
         X6k1VyvLSpEjwVVRTRn0CeTScUn5UlPKU2PEPTyS6UjkayxN4xteAhNyBpWub1lUq+iK
         26CTL6L/Qyn9vTwH4ntHIl7cMF6WvrLuK+alipruWjg72BCpbz7q6RITiY3CGH+BoupP
         j5YcmjtNsQFTyoe5l/yz1g9TEsBcEpdpNDmBCYbhZIwMYnCCOBIi5ApzQA4ZmSHekNXl
         ImYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329323; x=1759934123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wv1v1rCyNVZow/EufS/6YnSEiovq7wLtWvMHkvWDLt8=;
        b=A8L4NOawvPl8BbEreY73+lJXBbcCOR18a2Vb4edYepoI52BrAIV6yWZ/qWufKPd1cB
         FU1ycbj6BbyA8iPupwL0L0hqfLgA8ABjK+ThbkZl2A0u85xiqDDZbA6ATOdARE3b+cA0
         6WVD5J4KJ1U7F/Knphq9xctewSvGTicwiyex44eg78lBe/p8uzX2G35h5lbZ1F3muTLi
         lNWx+y1P38DkgGhXitaALHDnFwm1AAR8OBLiATD+WnxAuleRE531LERzkARzTTJSe1B6
         Q8NTmogmEEtn3CdkEVj7hVPx/9M3Rdn1ufl5e+3n2G1y/yILM2T/b3wg720h7DARfezt
         UxxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiE6w+K4pSWZ4Cty1hX3ulYnSPvpgIDsS2bHD6xsG6fUGqGii5yCCnNs+/f6BTg1Ymxc74Y8M5RomSzWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDJyFmpb/Pj8TEM6LQlyJ4BrFHqEW7QdsLgbBrN02dPT/GxdP8
	QXqIQ1tKEjXxdvR+IJzFlJJcj5kpN8bqkr335vlBz+mwQ8VXqjv2+w7Wqs43YV0fhYg=
X-Gm-Gg: ASbGncudKkyOEKiKq7EasUtCp8wI+WkwMEEsnHdpZOiiNFJuXMbvoYemlxDSVwdubfo
	a/fjAVDjm8+lQMD4OsI17LT2b92oBu4ktszBkuq/BdYCsDirEbtWL39HtP7CN5apIBVri0sQsN8
	0p4xIWA87d+w3ss/uu9znuiUxJj/1WCYuzES2FWPOAwaMH64hA2xqwGAfFwCsOqSX8haYegu2v1
	x5/BzGBOjBz23/UoHaGYrIYfbiLDSCF0TUMiJmD6b7SceH+6qNyyyQ/Pow3bSy05Sg83D0zXwqj
	0ndzJm7UJG7pjQiKsUM4rtUJTUaUF3bm1cuWfH35El15zYUIqllyvi8mUBQCWac14UPCARy/zIY
	QQUW4F6FFFEOWBAZwBwGRQSS8a72EuDTMDvFhUfhprEc5
X-Google-Smtp-Source: AGHT+IHXTlr6hMwOEdJJpqBV4TMV8ge8bItPiUQfnDU+pVip/S84k8hnYZeWqUPXz9KdDsMvP84M+w==
X-Received: by 2002:aa7:c60c:0:b0:634:bc7b:440e with SMTP id 4fb4d7f45d1cf-63678c9f531mr3386752a12.36.1759329323126;
        Wed, 01 Oct 2025 07:35:23 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-634b46dca59sm10770760a12.8.2025.10.01.07.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:35:22 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 01 Oct 2025 16:34:18 +0200
Subject: [PATCH v3 6/6] arm64: dts: ti: k3-am62p5-sk: Set wakeup-source
 system-states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-topic-am62-dt-partialio-v6-15-v3-6-7095fe263ece@baylibre.com>
References: <20251001-topic-am62-dt-partialio-v6-15-v3-0-7095fe263ece@baylibre.com>
In-Reply-To: <20251001-topic-am62-dt-partialio-v6-15-v3-0-7095fe263ece@baylibre.com>
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
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoy7NtIOJyXa982e0NF0+aJG1Yfla+P23fDaE/LkRt2yL
 cKteh+dOkpZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BeAiDxkZbkTyMO75rFOZcfnN
 Qk+ezG+JlVqCSpem10/tUfomHSkSzsiwrX1JX/ZhruQD7ZnJBVKno+ytZedOTdP+9JjD+9inXZb
 MAA==
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


