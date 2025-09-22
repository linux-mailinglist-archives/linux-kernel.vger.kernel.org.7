Return-Path: <linux-kernel+bounces-827601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37D3B922E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180C93ACB72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3AE3126C4;
	Mon, 22 Sep 2025 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="JSMYWnY6"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD1631196F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557849; cv=none; b=eQ6XX4+uWVO+gZ0N9pm2Zql48Gcd2YNjehPgKsXKZh0c3QRxkdmJnE1PdaUUCSQ0GU72x7W+S20k6M+rc05sNshn585gdZ5t8B6PacF9CAHbSCXZVcB04dcBfhtJPJRkMG3mFeQm/qUb3nCBQUWuwvgJpKMemKJz0PU75PxETjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557849; c=relaxed/simple;
	bh=NlbheDXpECv8KOzHHrPYOJU3W86bTH3Ut6RJOpS2J+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mle4LHL0snX1EOWoZB7jqxWXHDsqAV3gFf1hP465pN95WGY5vQQZWMR+hSYL7DlKp+goWIy7gKe41NVidXNHMfir4Dxx5BTpj/Mo869eJv4EUU3B9iyXsTS+ZCB1PNNONx/RiAwo3ravxxYGwEnaFoZ50aVcvH0nClh7i3HPki0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=JSMYWnY6; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-4248b079780so10128905ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758557846; x=1759162646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoOY7RfK5Srk9OHnvU+owYvzqDNBeS7oAz1E0iurER0=;
        b=JSMYWnY6b1aq4LTuusPdEF/bkDK0s6nCSWl9YiXI7gGUysANeAbWXN4FNarI5TtzLu
         ZksnaVez5PvYEuXlH8QtmN9XNoaZHH3uxEppeahuBDfTkI/R2pHFpJcGjDTU0YKUsQiu
         U7Wdl6vcvmMYh7lbxnn2dWfFHwx19ePptC3Hk0JUjZ3/U9xvZSL19hFFsTE5thPfZT5h
         BjEXaHLieOgbkuYhfhIvLl3cCp0JjRMYCJ7VYWLH92C6ho4aKEs+5xZJrXRH/TNDtiUh
         Vy6hNruaAIjxkJDtT+LGVgEDpl8apXzt2i+41NghenN3zUWqQkoS76m4/Mu97yahgDvD
         ySWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758557846; x=1759162646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aoOY7RfK5Srk9OHnvU+owYvzqDNBeS7oAz1E0iurER0=;
        b=ilQwe9qLl/jvl5FRIefnFWD4cy3iSrf49bpX0bfxwOckVT3wqRr01suIw+xQV3TMRM
         YD0xiPkZIxk81CFdRTmSvRq9u1O5fIWgl1E4sD2aSNq94GioeOhf0zVtCjRN1ZkCaE+r
         0ZhdN0YHVfdxshesKpOss8Ri0LLISRw8w9NvYcWqB6Rtw29dTLRDcXOX9jCZuaOZFj+V
         Gf4p/L2l90IemWcYO4n7nk3R/C1jb6YyOIivLuyqmQAEna72FDCbsRiZD2dV2XCFqMQY
         KWFXhpLnImz1ykW8EGftJVao/hODiWCZJAS+qAPufg8CUYuZfctCLBIFF4vmQWfRKvcQ
         qn4w==
X-Forwarded-Encrypted: i=1; AJvYcCV+Jpbv4sYaPE2hKQEAr4MDymZRxCNz6oTulUcsISaIy8XCfhP0XfOqT8w81pE706UzfyqfDb/0RrUD83I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRik99VcbPOZXObh3wFoWnxRFTu+/zp4qiw3W4+NqJnwvTLLx/
	FoVLJd5XAm3ngmqbJLzp1S6bMErV2UClVcTe5UCQEvdFsNx4Nmpp9VU1dddOBjWmXAs=
X-Gm-Gg: ASbGnctyqXYkndo/Jm4KPaLmiMmJ6whyfwO6Xea2sXpYjxwRjQ7LK8ZB2mW/epZrlns
	8D8ItLncf9zlZi3NeVWc37CYIovmMsUz7Oyk8z4rdvLAJy0rYnKj3GPHiKTQtUfU7Mu3399Q5AN
	7dAmfI/F6npsV2ReG+sSZ/WjJLsOF0Fysm5cMbZaI0aSXrqkyiuo6UUcpH70/mGME7vT5dEydzU
	N+0Hk8Wiuep43Y/OUwkl0zI8RHxeFE8MsPL1+safv0xug7qzyAVehsFSRtlyU7mBkN/S8Zem5fk
	xlBSBLxKVNSZe5l+AgSmsiQpTuBKu79uuJrgTsOSjEWu3QaQvSxnSEucjVPQ3mImF4LTQLjoanu
	NwB0zHz9vPoGJ/glk48rpVu+LQuLb6cH9X+u8klxvguQCem/1PQOwRtJwbZKM6o7FJw==
X-Google-Smtp-Source: AGHT+IGtbLw0Yh8YMxa0k32ja3gy2lmtWw7KYJ5toaZ8D6XiMR5qUSNHvj3Y8EAnz6GgOP6IVLuhZg==
X-Received: by 2002:a05:6e02:164d:b0:402:b8e3:c9f5 with SMTP id e9e14a558f8ab-42481911960mr204709235ab.2.1758557846329;
        Mon, 22 Sep 2025 09:17:26 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425711d9aa0sm25207185ab.48.2025.09.22.09.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:17:26 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	ziyao@disroot.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] riscv: dts: spacemit: define a SPI controller node
Date: Mon, 22 Sep 2025 11:17:16 -0500
Message-ID: <20250922161717.1590690-4-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250922161717.1590690-1-elder@riscstar.com>
References: <20250922161717.1590690-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a node for the fourth SoC SPI controller (number 3) on
the SpacemiT K1 SoC.

Enable it on the Banana Pi BPI-F3 board, which exposes this feature
via its GPIO block:
  GPIO PIN 19:  MOSI
  GPIO PIN 21:  MISO
  GPIO PIN 23:  SCLK
  GPIO PIN 24:  SS (inverted)

Define pincontrol configurations for the pins as used on that board.

(This was tested using a GigaDevice GD25Q64E SPI NOR chip.)

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v3: - Moved the SPI controller into the dma-bus memory region

 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  7 +++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  | 20 +++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 16 +++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 2aaaff77831e1..d9d865fbe320e 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -14,6 +14,7 @@ aliases {
 		ethernet0 = &eth0;
 		ethernet1 = &eth1;
 		serial0 = &uart0;
+		spi3 = &spi3;
 	};
 
 	chosen {
@@ -92,6 +93,12 @@ &pdma {
 	status = "okay";
 };
 
+&spi3 {
+	pinctrl-0 = <&ssp3_0_cfg>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;
diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index aff19c86d5ff3..205c201a3005c 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -76,4 +76,24 @@ pwm14-1-pins {
 			drive-strength = <32>;
 		};
 	};
+
+	ssp3_0_cfg: ssp3-0-cfg {
+		ssp3-0-no-pull-pins {
+			pinmux = <K1_PADCONF(75, 2)>,	/* SCLK */
+				 <K1_PADCONF(77, 2)>,	/* MOSI  */
+				 <K1_PADCONF(78, 2)>;	/* MISO */
+
+			bias-disable;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+
+		ssp3-0-frm-pins {
+			pinmux = <K1_PADCONF(76, 2)>;	/* FRM (frame) */
+
+			bias-pull-up = <0>;
+			drive-strength = <19>;
+			power-source = <3300>;
+		};
+	};
 };
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 6cdcd80a7c83b..eb8a14dd72ea4 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -797,6 +797,22 @@ uart9: serial@d4017800 {
 				status = "disabled";
 			};
 
+			spi3: spi@d401c000 {
+				compatible = "spacemit,k1-spi";
+				reg = <0x0 0xd401c000 0x0 0x30>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&syscon_apbc CLK_SSP3>,
+					 <&syscon_apbc CLK_SSP3_BUS>;
+				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_SSP3>;
+				interrupts = <55>;
+				dmas = <&pdma 20>,
+				       <&pdma 19>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			/* sec_uart1: 0xf0612000, not available from Linux */
 		};
 
-- 
2.48.1


