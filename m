Return-Path: <linux-kernel+bounces-851797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EFCBD74A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C363E828A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEF030BB89;
	Tue, 14 Oct 2025 04:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZxAcZ+q"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610E530C609
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760416958; cv=none; b=ejrM3tUhtp0yeCblgz79DNQiOfsIf7cSwjTPSv2zap6f+H9tHuAAhnW6vnOLYj4UxiCF5fHEJllKYZpjq59O6ttYecKy1drGahJVA/C6W4L3sm3z/Q8bWHINuzOvWfcP2m3mtrbDIw+F4lF7m5HUQFET2JYlkC7ptOZG9H69vUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760416958; c=relaxed/simple;
	bh=Lu+Wm6RQz65oFffbhnH7FkqqT/nKySBHieK5G4x8NUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcG4gg0XAiI4teTqWmcaaTzSfZyBDys4yCvlCJn/2QwDHLy0XDch0ANRWvhlZdxEOMb6WyiZON2oH91NJ9o+QSGh14hIyHXCwktH/+9QtdxR82ZGw1W9eYNwx8/iW0OixJpmLvmPRE3kG70nLwF7Ov+UN20mq/GqwdEq7FIjOig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZxAcZ+q; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781db5068b8so3897765b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760416956; x=1761021756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43dpYvG6mRE+3ZFMhinncIOl4K5qjfPZSeQUmpbj9wc=;
        b=SZxAcZ+qI+EXeGMOquWeSTnNtAXFDHLl0ryUxhueWvkBwvECpLxADInoUoGpgpW0AR
         rR/HND2RqpJf85JB9870bjMYUJSo4qY90eWBHo1ElpyVf+Y8EeqrWQ/AI9SeJCT8WeNG
         y9PiDAHxIrpXpcNoCfGoax+F3EXNbXTGDbeBULZYsE1tqJ2xmmRgT0Of70Gx/HmkFUvc
         wF8iJspX17oZponpExxYd9M2VMGccKbBC51J7FZRwv/Tt95P8W/UVMHZlU/PuaBkUlcm
         p3gfQk03OP+JjhPOqFA48XtWcUTUrRxLFDXeu3SfQyFpS9WR4lcyDo1TVp21YTyDaLAL
         rN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760416956; x=1761021756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43dpYvG6mRE+3ZFMhinncIOl4K5qjfPZSeQUmpbj9wc=;
        b=KEDRqt8uGo0TautHBx9erazdv/TkDbsi3wY2k+PYVMVrojKc7ebA1xvSjifw4I5k5c
         oUIuyV+gYsmIwYGhYUK1uSab4w4Nc9ypHz94HSOxhLidkzMi+ScnnBtmYu13pd0aMXYT
         Veeso5xdYP2wRCH/KkYfSZ0RTI7rY2sprcwMDnrhPOmiWnwMK9kWGyts6sXa+S0PDV5f
         I52f8h0/8tplroAIpvpRszTYXsdil+HOSncS8DsdgAkTe+P+gsWm9ZGmC79M3KWcqsz5
         4Os0pVdEZLxtML7RCehcYoALXvc1kCt7gDFeMRWu8b/3Nicz5QRG1BVpsxQmc02vMp6L
         7QGw==
X-Forwarded-Encrypted: i=1; AJvYcCVcwl3fm1Zc1ImhZEKRTWBN3co7oJXC5jsqRmvi2nTHDraKBoZ2xKuGh7FrMb4eMmX+rRLhZ/f3r0CwLCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ADYtxMDT0T9g8IryUCGrDbRBn8oEhoeXBSBUfmw+BqtVOHve
	IgvBb4/L2xhgOcCdvzHHLK62Ny7c/jrw/r/XYwVBC8Tib6WxmQ+a1n0F
X-Gm-Gg: ASbGncv48i87i9Q8AH0WMHSczbz0ZRso7Z44NIZTJ9O9RX3pyxpXkwQIdcUVS7fMtjp
	z2mXZygraMOU2NrntRi/6/rH7EqEuk/rknzplp3V1Z8hlC6sdAu9YaFD29x+CrZs/uBAVk9cfsM
	wVSTAIGweQdnzfq6R1RRMkH5AOOXaKvinfXg/OJA1eTT4k8afXYsqRoDwwDXTm06MPLatMGpkj0
	UKN5XAnXC+DKuCSriLJMwVSJv9Mq+FU2xmdkKqCZfxQFfbJfzKAH5ONqOMUbKbX2zOFBr/jk2lb
	nwJiHgaeX9hf2EBfU/vXiOhi5UXNWcEXXRb08/5OQkd3ahPpFB5rC3Cvqhi3F40IW7ZMv7FHpDq
	5d6yBmB+RdOu4RNFEljAwUbkuaGg37s+PXASy
X-Google-Smtp-Source: AGHT+IFN2HtgJRh8s6x+tEn3p7J0qJhA4Hv1IhkpMVdDgnw3oWKkvvVOM6cfaI6fXuL+XUT5z02ecw==
X-Received: by 2002:a05:6a00:3e27:b0:781:2582:822a with SMTP id d2e1a72fcca58-79385ed2f30mr28375639b3a.8.1760416955694;
        Mon, 13 Oct 2025 21:42:35 -0700 (PDT)
Received: from archlinux ([177.9.216.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-79b65528a51sm8440684b3a.85.2025.10.13.21.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 21:42:35 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] arm64: dts: qcom: r0q: add touchscreen support
Date: Tue, 14 Oct 2025 00:41:32 -0400
Message-ID: <20251014044135.177210-4-ghatto404@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014044135.177210-1-ghatto404@gmail.com>
References: <20251014044135.177210-1-ghatto404@gmail.com>
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
 .../boot/dts/qcom/sm8450-samsung-r0q.dts      | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
index 5ca45b040a99..96a8a0e69681 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
@@ -56,6 +56,50 @@ splash-region@b8000000 {
 		};
 	};
 
+	/*
+	 * The device has an issue where SPI 8 (the bus which the touchscreen is
+	 * connected to) is not working properly right now, so spi-gpio
+	 * is used instead.
+	 */
+
+	spi8 {
+		compatible = "spi-gpio";
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&spi_clk_tsp_active &spi_mosi_tsp_active &spi_miso_tsp_active>;
+		pinctrl-1 = <&spi_clk_tsp_sleep &spi_mosi_tsp_sleep &spi_miso_tsp_sleep>;
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
@@ -138,6 +182,20 @@ vreg_l1c_1p8: ldo1 {
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
+
+		vreg_l8c_1p8: ldo8 {
+			regulator-name = "vreg_l8c_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11c_3p0: ldo11 {
+			regulator-name = "vreg_l11c_3p0";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
 	};
 };
 
@@ -162,6 +220,82 @@ &pon_resin {
 
 &tlmm {
 	gpio-reserved-ranges = <36 4>; /* SPI (Unused) */
+
+	spi_clk_tsp_active: spi-clk-tsp-active {
+		pins = "gpio30";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-disable;
+	};
+
+	spi_clk_tsp_sleep: spi-clk-tsp-sleep {
+		pins = "gpio30";
+		function = "gpio";
+		drive-strength = <6>;
+		input-enable;
+		bias-pull-down;
+	};
+
+	spi_cs_tsp_active: spi-cs-tsp-active {
+		pins = "gpio31";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-disable;
+	};
+
+	spi_cs_tsp_sleep: spi-cs-tsp-sleep {
+		pins = "gpio31";
+		function = "gpio";
+		drive-strength = <6>;
+		input-enable;
+		bias-pull-down;
+	};
+
+	spi_miso_tsp_active: spi-miso-tsp-active {
+		pins = "gpio28";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-disable;
+	};
+
+	spi_miso_tsp_sleep: spi-miso-tsp-sleep {
+		pins = "gpio28";
+		function = "gpio";
+		drive-strength = <6>;
+		input-enable;
+		bias-pull-down;
+	};
+
+	spi_mosi_tsp_active: spi-mosi-tsp-active {
+		pins = "gpio29";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-disable;
+	};
+
+	spi_mosi_tsp_sleep: spi-mosi-tsp-sleep {
+		pins = "gpio29";
+		function = "gpio";
+		drive-strength = <6>;
+		input-enable;
+		bias-pull-down;
+	};
+
+	tsp_int_active: tsp-int-active {
+		pins = "gpio46";
+		function = "gpio";
+		drive-strength = <2>;
+		input-enable;
+		bias-disable;
+	};
+
+	tsp_int_sleep: tsp-int-sleep-state {
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


