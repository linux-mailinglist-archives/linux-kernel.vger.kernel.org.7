Return-Path: <linux-kernel+bounces-841273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B60D3BB6AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 14:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84D2D4E886B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 12:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E502F0695;
	Fri,  3 Oct 2025 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZi20jRQ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C6E2F066D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759495868; cv=none; b=phE2ERPrQstcuGqy5tz/8hQl2WSG6ubK6H7MayWZkZb2XXUUOV0DXCzm5o7BBKcnPK9oMQepBglCCCFq5F4+8KvvDjTys6/iasmLSQ7B4OKSMy+diD9jrJI2373xRMZMUZcVpWaxkdZXWdfMODsO1uNMZ2dSbzgJOb86hiVQakk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759495868; c=relaxed/simple;
	bh=eAUUl63uFcupRJTMuIWFtoPfkLEkUQYqZN3KWZyQ4lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQjfK95YA02NOHYHZsioJkJvsM28CA0moMgzKeJaN7l1hYzRq/Xkkpz0Vm0TJrRgjW61gKUwleLvCutPZdlcpFuwyjgilRWpEmr18JBgrBnQkn4Bsv15V6dF0poSRnpD9ylJVMGeTGM/Vh/k9n3nS7qIpwspXuvqD46Z7PT8fFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZi20jRQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e47cca387so23631005e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 05:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759495863; x=1760100663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IZoiErPJ/Pg70gKqGC9T9EhwBHZBMlbbY6bGBGZt7o=;
        b=FZi20jRQOVdX7AfDtyHLohSSTkWZzP9wraDweoALH9qtJUS+9ZIIHyQ5FnMT74WX3R
         hzfEl9x5BzGGPtXo2yzbEraOd5WM5IL7hqHKt1Wl91e5rXEk0hYCjUtRlKweVrirC9Xe
         cIwUtSWfIPBrqNIvfAOb44E7FAJSSRsXWguvm8lim+aketYt3LXr/zKS1OqSkXQX0goe
         za3SrK//uHaJ7fgFH5HL1T+zqMiXHUrw+UdUWzRDl36tvzfkEnnvNhrdrq+NjYh4Fj2x
         +LRM0a9Ey4UMbFdymIa5WvSBpqx6kD8zaOTvBTSNPzIHPrslSKr/HNk21k1JiUB3RbqL
         AKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759495863; x=1760100663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IZoiErPJ/Pg70gKqGC9T9EhwBHZBMlbbY6bGBGZt7o=;
        b=qI4rjSoQAWoviIaD4dMspWelC3BKhlRDCuXaInCM5Lms4KbEMVUFhXoUb8BBXmP82r
         Q0NN1h52NqtxI32ReorHRvoqVAkKBN0q4I2wny9Np8QB88wNnJJsXOX81tysKFjle8Pp
         lwymdPKRx08JHlUfrJoIxb/KvJbjt9pZYGumtviOjdHewgAUi0IMlEheKdd/ofqUpoLM
         6mV4wXpqGWmeV9IUAtb4w5YJUiZideGwEr+2E7vJUtYjaHnKzhUIz9EIIeWamBoTBPBR
         xpO1hT6PThNRStcmEgdSKs9FOOEp2AzF9dYkXZRtEq5081vD4fId/UqF4wEqREuuSmiH
         r2zA==
X-Forwarded-Encrypted: i=1; AJvYcCUjB0Vj2owtKnJgj//WJN3kkJmox3DpwTw6Vo9drp4Qio6eK5jTi1El/Wtr9IelQ1q34iNnYIFAkPi1XmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoxsmVPAsk6e0gI12GR4iAGw2Lno0tToc95rHTE3GzyQX2+wIx
	ZEPLOT+BtBNVPM6x2BWm1JR8BfgIoR7AJjKVnlPSpfDztDwheAfAIJ+w
X-Gm-Gg: ASbGncuAZAyeyZTzdZIRE5uOH5JDltcAJ8mLMrDieoeJRtoh3OBks2obeUqNdgHEFr/
	HmrzEw6mAFPjsKsw8Ry6Cz8bvp9Uho8t050PCQKOmnE/HUrClUJ0hgA6MCHF6+YXHYv1M/kWidw
	L6J8UGHn7kPWIj3PgN4im8TVG0dM0Ks4Akm37uegxL63LRxN+G4y2B7PD//hc/uaXOwp+1sh5d2
	sMbcxNBt4bg5AEJP6K9nwAQdvNlbozbNsKOhZVCFo2pD3dbBuo+82TeL76g8ZAMPqCsS+ezvrJf
	/yWs24t5PT1dxEcMU8IRGeXAQlJGUZjRE23q6R9FLA9ZJ6b8PbQed9uJItLlTUf9DFbjRhk8m7h
	oJqLeDPPnu5iToOLjZxAYdDVPxRnV5TF7u2mujDRZO892d405lSkyiUhugW00RGsVCUOUWw==
X-Google-Smtp-Source: AGHT+IHs8dFUCY+WdReUoM1aWDsIS9GNN231DHH3c/6nXzIw+XZO5N/Hg3PQQ7yZp2JlTomt4pJKHg==
X-Received: by 2002:a05:600c:4e94:b0:46e:1d01:11dd with SMTP id 5b1f17b1804b1-46e7110436bmr21072345e9.2.1759495862813;
        Fri, 03 Oct 2025 05:51:02 -0700 (PDT)
Received: from localhost.localdomain ([37.159.33.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c40983asm80598605e9.3.2025.10.03.05.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 05:51:02 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 2/3] arm64: dts: ti: var-som-am62p: Add support for WM8904 audio codec
Date: Fri,  3 Oct 2025 14:50:28 +0200
Message-ID: <20251003125031.30539-3-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251003125031.30539-1-stefano.radaelli21@gmail.com>
References: <20251003125031.30539-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VAR-SOM-AM62P can integrate the WM8904, a high-performance
ultra-low-power stereo codec optimized for portable audio applications.

This patch adds the WM8904 device to the appropriate I2C bus, enables
the McASP1 peripheral, and introduces the sound node to expose the
sound card to the system.

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
index b93372f22732..aba72d0b767c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-var-som.dtsi
@@ -112,6 +112,38 @@ reg_3v3_phy: regulator-3v3-phy {
 		enable-active-high;
 		regulator-always-on;
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&codec_dai>;
+		simple-audio-card,format = "dsp_b";
+		simple-audio-card,frame-master = <&codec_dai>;
+		simple-audio-card,name = "wm8904-audio";
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"IN2L", "Line In Jack",
+			"IN2R", "Line In Jack",
+			"IN1L", "Microphone Jack",
+			"IN1R", "Microphone Jack";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack",
+			"Line", "Line In Jack";
+
+		codec_dai: simple-audio-card,codec {
+			sound-dai = <&wm8904>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcasp1>;
+		};
+	};
+};
+
+&audio_refclk1 {
+	assigned-clock-rates = <100000000>;
 };
 
 &cpsw3g {
@@ -149,6 +181,19 @@ &main_i2c2 {
 	pinctrl-0 = <&pinctrl_i2c2>;
 	clock-frequency = <400000>;
 	status = "okay";
+
+	wm8904: audio-codec@1a {
+		compatible = "wlf,wm8904";
+		reg = <0x1a>;
+		#sound-dai-cells = <0>;
+		clocks = <&audio_refclk1>;
+		clock-names = "mclk";
+		AVDD-supply = <&reg_1v8>;
+		CPVDD-supply = <&reg_1v8>;
+		DBVDD-supply = <&reg_3v3>;
+		DCVDD-supply = <&reg_1v8>;
+		MICVDD-supply = <&reg_1v8>;
+	};
 };
 
 &main_i2c3 {
@@ -179,6 +224,16 @@ AM62PX_IOPAD(0x01d4, PIN_INPUT_PULLUP, 2) /* (C22) UART0_RTSn.I2C3_SDA */
 		>;
 	};
 
+	pinctrl_mcasp1: main-mcasp1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0090, PIN_INPUT, 2) /* (U24) GPMC0_BE0n_CLE.MCASP1_ACLKX */
+			AM62PX_IOPAD(0x0098, PIN_INPUT, 2) /* (AA24) GPMC0_WAIT0.MCASP1_AFSX */
+			AM62PX_IOPAD(0x008c, PIN_OUTPUT, 2) /* (T25) GPMC0_WEn.MCASP1_AXR0 */
+			AM62PX_IOPAD(0x0084, PIN_INPUT, 2) /* (R25) GPMC0_ADVn_ALE.MCASP1_AXR2 */
+			AM62PX_IOPAD(0x00a0, PIN_OUTPUT, 1) /* (P24) GPMC0_WPn.AUDIO_EXT_REFCLK1 */
+		>;
+	};
+
 	pinctrl_mdio1: main-mdio1-default-pins {
 		pinctrl-single,pins = <
 			AM62PX_IOPAD(0x0160, PIN_OUTPUT, 0) /* (F17) MDIO0_MDC */
@@ -280,6 +335,23 @@ bluetooth {
 	};
 };
 
+&mcasp1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mcasp1>;
+	op-mode = <0>;  /* MCASP_IIS_MODE */
+	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+		1 0 2 0
+		0 0 0 0
+		0 0 0 0
+		0 0 0 0
+	>;
+	tdm-slots = <2>;
+	tx-num-evt = <0>;
+	rx-num-evt = <0>;
+	#sound-dai-cells = <0>;
+	status = "okay";
+};
+
 &sdhci0 {
 	/* On-module eMMC */
 	ti,driver-strength-ohm = <50>;
-- 
2.47.3


