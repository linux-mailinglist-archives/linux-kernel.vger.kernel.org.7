Return-Path: <linux-kernel+bounces-825443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D2CB8BD00
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE6937B2E0A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 01:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4270F20F08C;
	Sat, 20 Sep 2025 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyNxij0y"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0606820D4FF
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758332832; cv=none; b=s+B2ymNwZHRqBF6ngKevTuLUUmiiNd2Gl2iE3P0x1lo1meBMddhf7b+8AyoXdy8XuNvSCuFrwCPvw7cwgJ348HpMxmFpsUmDxe9/cSOr8Z/VApmQWBIpbp7fdzy6u9o2BUs4vnt3nAVqL6kylKkNzn9WyHO9KVsnCC2o45wpLlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758332832; c=relaxed/simple;
	bh=aRmp+/oecFFHV4rBizvkU5l0FhyGV7U0cEbn7zMDiEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEB3r7Uj5WCUbOP4iymWMBmQ0USL56ZHRJ6NIqau218Jr+Jg/uRAd6gnlLN58ug8B+1LGoZrwAYHncPWTF7JGGSAHIM0Rchre60tC4YAZWnWg7D0izxo8qpmPz03s0cj0PmX8W3YkcR0uZrCvTJvHRhLqLhnBpZvE7gXw80z6QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyNxij0y; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b54c86f3fdfso2804874a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758332830; x=1758937630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7npXYgxY41NPqzpSKfP+17vnrXdgVumONF2Se9aVSk=;
        b=YyNxij0yxn/G9ntS3O7fl/1dOx3qH6zSQ/PUAeLpDCTyDnypmQVDD+gVsxx+gdYQIM
         WCgHkFE9wemLC7wFslJyQu11Y6o1CbnKY9rDTpifIZAo8XvU8Bt5R/RL337FSm2tzcGk
         raQkcK97BwEMdvGA6gsd9Iop6MFZwZOoBMPzI4J3pcNFjP095c6JXrXKqecpabBRUzHu
         CWv2iOKuRVvTBtzdLolNBnf9T3E86UZ5lv/AAfueASdCjN9yRNcMVDPFvhczqPQZ+1as
         b2xONbVqaY57dQX+7aWBrRm6NgqFP4bgKVnn4m9a6wMAuQYDiQnLBkKfX92bCg6MQcxH
         D/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758332830; x=1758937630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7npXYgxY41NPqzpSKfP+17vnrXdgVumONF2Se9aVSk=;
        b=c4CuXVfoK6kYF095NyQMbJs2XW4+euGHU+JVnE1uUIC4X3v+v2v7fkqSdnXH25OLbl
         2YY6FArWhKjNnKn3VHtjVZHFTvZpWImEAKthzBusMOKc6YI8vnYBVpVjxwyXB00zu4DY
         HzYqxyjHj51hMAgaj2IsIyId0gbcgCzKOfnmbHFEFROog92UkoMhPCL6Qv8T00fKE1Jd
         tPBoLw86xb+CTw/qSkYaS/7c3E1mO846vGHssC8AJGH6Ti2b4rpyyoZwGFML0caLStav
         tEJ9oVx/AMocDbLSREpKyPktmEw3PJQw8jo8m7kEYJX2Y5aD9HlyDb+gUvDaXXqE6Bs6
         vIbA==
X-Forwarded-Encrypted: i=1; AJvYcCWpxV3sx+OGMFKqXvJ1x6yJRlR8EaAtrLph3DitW/ShGuNK+45bNBLNv0M6dZJd2d1+Ryz2RHlUbE84OnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYE6qWPv+sW884Xr2naiiSYUt3YfWvid1RtOGXW2VPQfx2PCH9
	CnSSCuJToXZRDkCVIWbPOXP+ofHMPVgR2sNW7iB68urwPhjb8Tq+AT5u
X-Gm-Gg: ASbGncsGxhz2tWdWops+QWkb8pH5oUsAf61UidYyOWHVnyKSMpHR2MIYD6PnA/iQ65l
	o+spjN96tMW2XVx+9iN9RcRrnwp2JYpkkQdpWDK7/aR+jmqtnblFEVUqfHbJhMNm8by3DvUEa7O
	Y83RaGZrJzFQVmFD7KTIAvLczERvIX5vbCSToolnrOHeFmmAjf531XeDr7SgWC/Eq/hHJo5Oshu
	AXA4v/wAstsM3TS8YRzjqZMvdQAUbyC0xPLwzebikEWzVSh0gdP288hjBDczgTPRIC8SWTXH6Eq
	ZGX4cmZxehi8h+/kn3KmQDMnihHnEBZQMN1EtVo9BIBxXvBgCI0IaALdA7+9UaBnDoZv5M25icM
	f+ef/m9u1UPfLqveHpfVQ
X-Google-Smtp-Source: AGHT+IGAi8vnQCWhOm+osD3zmZZvsfCltRPv2Y4dmfTI+E54VnE88ez9zVtoTAQLIcJ0gDclrNP1WA==
X-Received: by 2002:a17:902:dace:b0:272:56e:e296 with SMTP id d9443c01a7336-272056ee45dmr173405ad.30.1758332830258;
        Fri, 19 Sep 2025 18:47:10 -0700 (PDT)
Received: from archlinux ([191.193.70.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033c922sm65709455ad.131.2025.09.19.18.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 18:47:09 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] arm64: dts: qcom: r0q: add touchscreen support
Date: Sat, 20 Sep 2025 01:46:34 +0000
Message-ID: <20250920014637.38175-3-ghatto404@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920014637.38175-1-ghatto404@gmail.com>
References: <20250920014637.38175-1-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable the ST-Microelectronics FTS2BA61Y touchscreen. This patch
depends on "Input: add support for the STM FTS2BA61Y touchscreen".

The device has an issue where SPI 8 (the bus which the touchscreen is
connected to) is not working properly right now, so
spi-gpio is used instead.

Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
---
 .../boot/dts/qcom/sm8450-samsung-r0q.dts      | 167 ++++++++++++++++++
 1 file changed, 167 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
index 70e953824996..7bf56564dfc6 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
@@ -55,6 +55,45 @@ splash-region@b8000000 {
 		};
 	};
 
+	spi_gpio: spi-gpio@0 {
+		compatible = "spi-gpio";
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&spi_clk_tsp_active &spi_mosi_tsp_active &spi_miso_tsp_active>;
+		pinctrl-1 = <&spi_clk_tsp_sleep &spi_mosi_tsp_sleep &spi_miso_tsp_sleep>;
+
+		status = "okay";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sck-gpios = <&tlmm 30 GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&tlmm 29 GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&tlmm 28 GPIO_ACTIVE_HIGH>;
+		cs-gpios = <&tlmm 31 GPIO_ACTIVE_LOW>;
+
+		num-chipselects = <1>;
+
+		spi-max-frequency = <5000000>;
+
+		touchscreen@0 {
+			compatible = "st,fts2ba61y";
+			reg = <0>;
+			spi-max-frequency = <5000000>;
+
+			vdd-supply = <&vreg_l8c_1p8>;
+			avdd-supply = <&vreg_l11c_3p0>;
+
+			interrupt-parent = <&tlmm>;
+			interrupts = <46 IRQ_TYPE_LEVEL_LOW>;
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&tsp_int_active>;
+			pinctrl-1 = <&tsp_int_sleep>;
+
+			status = "okay";
+		};
+	};
+
 	vph_pwr: regulator-vph-pwr {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
@@ -132,6 +171,18 @@ vreg_l1c_1p8: ldo1 {
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
+
+		vreg_l8c_1p8: ldo8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11c_3p0: ldo11 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
 	};
 };
 
@@ -156,6 +207,122 @@ &pon_resin {
 
 &tlmm {
 	gpio-reserved-ranges = <36 4>; /* SPI (Unused) */
+
+	spi_clk_tsp_active: spi_clk_tsp_active {
+		mux {
+			pins = "gpio30";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio30";
+			drive-strength = <6>;
+			bias-disable;
+		};
+	};
+
+	spi_clk_tsp_sleep: spi_clk_tsp_sleep {
+		mux {
+			pins = "gpio30";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio30";
+			drive-strength = <6>;
+			input-enable;
+			bias-pull-down;
+		};
+	};
+
+	spi_cs_tsp_active: spi_cs_tsp_active {
+		mux {
+			pins = "gpio31";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio31";
+			drive-strength = <6>;
+			bias-disable;
+		};
+	};
+
+	spi_cs_tsp_sleep: spi_cs_tsp_sleep {
+		mux {
+			pins = "gpio31";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio31";
+			drive-strength = <6>;
+			input-enable;
+			bias-pull-down;
+		};
+	};
+
+	spi_miso_tsp_active: spi_miso_tsp_active {
+		mux {
+			pins = "gpio28";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio28";
+			drive-strength = <6>;
+			bias-disable;
+		};
+	};
+
+	spi_miso_tsp_sleep: spi_miso_tsp_sleep {
+		mux {
+			pins = "gpio28";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio28";
+			drive-strength = <6>;
+			input-enable;
+			bias-pull-down;
+		};
+	};
+
+	spi_mosi_tsp_active: spi_mosi_tsp_active {
+		mux {
+			pins = "gpio29";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio29";
+			drive-strength = <6>;
+			bias-disable;
+		};
+	};
+
+	spi_mosi_tsp_sleep: spi_mosi_tsp_sleep {
+		mux {
+			pins = "gpio29";
+			function = "gpio";
+		};
+		config {
+			pins = "gpio29";
+			drive-strength = <6>;
+			input-enable;
+			bias-pull-down;
+		};
+	};
+
+	tsp_int_active: tsp_int_active {
+		pins = "gpio46";
+		function = "gpio";
+		drive-strength = <2>;
+		input-enable;
+		bias-disable;
+	};
+
+	tsp_int_sleep: tsp_int_sleep_state {
+		pins = "gpio46";
+		function = "gpio";
+		drive-strength = <2>;
+		input-enable;
+		bias-disable;
+	};
 };
 
 &usb_1 {
-- 
2.51.0


