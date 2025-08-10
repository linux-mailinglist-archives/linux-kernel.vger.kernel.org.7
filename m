Return-Path: <linux-kernel+bounces-761421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AC7B1F9E3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 14:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34831799B4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 12:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0D5258CD9;
	Sun, 10 Aug 2025 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="o/6gEqd9"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FC4258CCB
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 12:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754828510; cv=none; b=dgoLlm4y6otrCOOLL6CydBNKbmuXIdcB/E/7kz37XQyDzIgHAp4EaJNvQ3d0oTFCuX7Q1CLtqLcHeO4+fti5VTzIkQCGJIVkGjegwpkjt/757F2ckjRmX7M9FBYUsNvahYuhvglGKRBuz8cprhgbrqRhzgerKlh901swAGqAHtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754828510; c=relaxed/simple;
	bh=iTQFHP39FE3WpDLqzx5etZHG59YzOhgdZXjfCTF7D4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzMg+TcuRtrEAizMaK9vVhnOjsm7ACO5BRXOWcoPPqO+r7Zp1FpKf7FuczuIQDWrIjNjoruQN3ETLelZJRbBkDTLSjZRFmL80GcaKMXB0WDddS/EpGG/fXFHu1ekrMal/hzvdZe0chs/Tx2NEWZZu6yNqumVzl45xj7ER4bV8SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=o/6gEqd9; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af98841b4abso593743566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754828507; x=1755433307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czkhJoG2Gc/7FyisTMqLRYvCWAiMp1iGp7hQ46B82n8=;
        b=o/6gEqd9xaZOW2MtAxOQmWKhK5KQ5p1ataXVNdCOB4v1cowZb3uk7ZoPmT6KxbFN0x
         MQZfu5dVKUfr4h3P38ZtxoSCEhHTVnqraz5tbxVzTEBCk7GT8HlYaORCAXAW8AogSoaJ
         WzFxiBEb8kcN50XR8TaIF5fZ0LqtvdKRxCd1ruPcmflorx4FR25cU3i2Ig7vdzTXmP3Q
         i57l7AxwIdx1uKmeI7CWK6Ftj52QeUtd08VKckeKOmKocHSaCj7U+UaWF5Uc6CGkb4i2
         lOwe26yav/VNsX0Y+dr2Vzmx4dSwlgMrHyX/bORTr+HPkDgu5afG1W568TnyQm5sM3a9
         GDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754828507; x=1755433307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czkhJoG2Gc/7FyisTMqLRYvCWAiMp1iGp7hQ46B82n8=;
        b=d3BAm+NjEjgknbXOmLMydBiYmxy9jB0bb6bM2wnGfQMSbEHLDMVDijGH7Jp2nnplvx
         yVJECBEa+3FM9qLgr2LDwE6UWbXNtHGBGidm4B8dkd9UgIhJjGDnT5vHJAubgQrv5p7E
         b9s1Gr7B+qk+yiftbpoNEWjhom6mSK7I6Lof2TFN9Vhb0vWOnTaQvXoeUlYYdkuaATDz
         AN3PLL/8mbAIZp3UkHPLhAfywfhRWFLLKLH1CySdWh1NvApoS68iNb+r0hSk205FsH8D
         qyn00HmtzZR9EKtoVbCKmqNBnzDLustXJGYUFYvY4PlAGVAMmSx92NaTG/qGqFPeO/nZ
         OK+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXT6htkrx+fGACdzfXWRMx6WSI1qLPrMFcfWGhh5rzYThNKE5SsV1zW6mBwzGnvV+VzRcm6SbDhDgc+td0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5z0w6HyWrVlGEacptEaAlkNiYqiy7Yb76DweGqaXmUECZHECR
	AjDKhoAkPjtlmHKjNaPkw2i7LH48gdPxSXDLL99QZbvICC8dsIUVn1E4zamVc9OAq3o=
X-Gm-Gg: ASbGncvJvpOcH1itPBi3mV0sbIuHeBdyNSEJodaSnyDS8ESCc+86e/fMmNzAGccjGxx
	k/jwUVh62c+G4tv5l/iodNb9wSKehwnoDimlvKJNfvFr/tBdly/kN6O3SeG/WXKiHxoA3326rMn
	2E8gucM5QA1wjQCma19aIV97QJb1GdXlgLNTGf92S/WOpTTBL7Xp6UEBGXx8Xu9yn/somv6XIdr
	VUoVPh6b74vbDt54zbCmrj4xMmHvuSp5fkW5ttue1S2xZ0GqPeAr2hyjulUTtMbn0LVQ3ni+WQf
	OySUe/mGz268rbUxQKBe9km097jEj9xG7zIbPePjiSESUHTmHNyU8aVcoTov5q9LzdaamNdw5aY
	L24qGd8vuhBgFwCHsjk3rfZMVUkbABLI5LYU1IhO+hGrM8SfMIhEb
X-Google-Smtp-Source: AGHT+IEtxors3X7Rdp3bYfeRsAV85kpmN7w+thRk3VDKj4rUsmhSECv/3nQi8r+6f+zFV+oHk5YoZw==
X-Received: by 2002:a17:907:d23:b0:ae3:635c:53c1 with SMTP id a640c23a62f3a-af9c6518c68mr911773766b.54.1754828506589;
        Sun, 10 Aug 2025 05:21:46 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a86758fcsm16611897a12.0.2025.08.10.05.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:21:45 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	niklas.soderlund@ragnatech.se,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 3/4] arm64: dts: renesas: r9a08g045: Add TSU node
Date: Sun, 10 Aug 2025 15:21:24 +0300
Message-ID: <20250810122125.792966-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add TSU node along with thermal zones and keep it enabled in the SoC DTSI.
The temperature reported by the TSU can only be read through channel 8 of
the ADC. Therefore, enable the ADC by default.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- collected Geert's tag
- adjusted the trip points temperature as suggested in the review
  process
- added cpu_alert1 passive trip point as suggested in the review
  process; along with it changed the trip point nodes and label names

Hi, Geert,

I kept your Rb tag. Please let me know if it should be dropped.

Thank you,
Claudiu

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 49 ++++++++++++++++++-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |  4 --
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 0364f89776e6..3f56fff7d9b0 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -233,7 +233,6 @@ adc: adc@10058000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
-			status = "disabled";
 
 			channel@0 {
 				reg = <0>;
@@ -272,6 +271,17 @@ channel@8 {
 			};
 		};
 
+		tsu: thermal@10059000 {
+			compatible = "renesas,r9a08g045-tsu";
+			reg = <0 0x10059000 0 0x1000>;
+			clocks = <&cpg CPG_MOD R9A08G045_TSU_PCLK>;
+			resets = <&cpg R9A08G045_TSU_PRESETN>;
+			power-domains = <&cpg>;
+			#thermal-sensor-cells = <0>;
+			io-channels = <&adc 8>;
+			io-channel-names = "tsu";
+		};
+
 		vbattb: clock-controller@1005c000 {
 			compatible = "renesas,r9a08g045-vbattb";
 			reg = <0 0x1005c000 0 0x1000>;
@@ -717,6 +727,43 @@ timer {
 				  "hyp-virt";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsu>;
+			sustainable-power = <423>;
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device = <&cpu0 0 2>;
+					contribution = <1024>;
+				};
+			};
+
+			trips {
+				cpu_crit: cpu-critical {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+
+				cpu_alert1: trip-point1 {
+					temperature = <90000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				cpu_alert0: trip-point0 {
+					temperature = <85000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+	};
+
 	vbattb_xtal: vbattb-xtal {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 39845faec894..6f25ab617982 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -84,10 +84,6 @@ x3_clk: x3-clock {
 	};
 };
 
-&adc {
-	status = "okay";
-};
-
 #if SW_CONFIG3 == SW_ON
 &eth0 {
 	pinctrl-0 = <&eth0_pins>;
-- 
2.43.0


