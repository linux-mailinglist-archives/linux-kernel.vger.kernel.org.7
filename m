Return-Path: <linux-kernel+bounces-775806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D083B2C539
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EA4240374
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3234F32BF29;
	Tue, 19 Aug 2025 13:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nUFt4jsH"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCA132BF55
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609379; cv=none; b=tf/zkpXJaVokHDvXkVCB90/25FTc4SRypkqLytySiUmMp9O8XVeuIdObruO36HjZtZq0Wr+ZQSgZe1gsMeRU1j1pa1h1vbu2hbdk8EItmtoNet7/6GDt5KpYrsDCo3j5nvqLwSapXzDa1Ph7VG0Tq4AbuLPO9KG+LkGuMukWDi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609379; c=relaxed/simple;
	bh=63JgKqF3bc5t1TwNQeM5U464DiEpmWFQDp6CzuzSqJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4iYZYpRQ6ZPVLzOFha1JHzoL/PXH+AExTqkRvShq9ikLhAkMQsBgiBmzgl8AetdnMoxqyno/VO+aZa5mf7NXdFiyMYYD/5je7PgYM0E6PELHGiM4pzi5DtjXr0+FnfbDQlZXDnJOB2EBPMhKXyX295E1WbFki/EgjjXLzZpDf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nUFt4jsH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7322aa0so75570566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609376; x=1756214176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPILFNpK7zCsqHWBHdQ9uG4ptTyRvqVrmGvIx37v5K4=;
        b=nUFt4jsH12d2RNYuoXfpEItS1tYHRaBgs9X6vOAGorC6HStjVwMpbvKDYJCgiPF7cr
         VvTKcgrt3L0M5TXhoXoLTlEmKaPSE8q0v+h3t0zpRDIUIlHou6H9xFxEVpFBhMNokFrY
         mbyVt2qDiBrCohgZ+yPL0iJems1bnu3XrPzDcp1fUYyM48l4NFsUITRJM7d48LmFsizg
         J3rhzF8EoE176SrzTAtXmMeS6n07zFZc95OCEWlEya7q0qK6GiKzyUlYqKxW99AZV2C3
         GiDj06gf853LbmnRiN3Vyz0dJNMl3qosz+rwh/ClK8NlA1iXuHAdwkdnHCrLFsqvAwP+
         cHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609376; x=1756214176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPILFNpK7zCsqHWBHdQ9uG4ptTyRvqVrmGvIx37v5K4=;
        b=EJ05Dm3fJ74hsP7XXl+Iq1kFSEKEXJdkiZE3Qacnu85MjKZ9JesjF3Q9yFkXWxWaCx
         oPAqcWGBvckuaYnMeiy/9q4zSu+R6fHf1Djzxum7PSxmil1qlr16/r/B0cW3FKb1SQ8e
         MpdZijgJzIlDVEU+tCqXMh7++9pUXD2SvOKPiqNQ32kNAkzP3GYTmCbxmllk2bAPlPu6
         spqiab9HYvvG9BLsmEM00o3Y93fgc7b9HJ08cL8Wwlfn/z3p0CtUVQ/ItSWgGMO3U3ph
         uYakpbqVQyvJGd2pM+vpwYw2rwvJLRndoX/FRr4JjxDs/n4bhK7aRsYc5+AyXfgR/JMi
         8RCA==
X-Forwarded-Encrypted: i=1; AJvYcCVcvsXGmkt7xUJow3gD7iKGQvBqCM61mXazASkULY1pmwzppqBI0Ng++dYRTWxdxaNRKoqnUvhf6HV/ej8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeWPUNk2hA2B1KA9Tdpt92kyF9NhbaisRb5568XV4aKD/JhjQH
	qaYtmXCJwKFiVVvBzFi2losvsQ2h3dEjmoAeCDLsxqkbbkcUZXxsE/QkVbwjHjQU+ww=
X-Gm-Gg: ASbGncs/WsONw/rgYeJfAOgjZ/4OBYvnZeFHjk618zBacB3iaqx4BOpeXAhxYO9UZr5
	Bl13FWkqpIy9k538MTH0PYYteDRAhUwzf8aAZLYZOPG1cBvU3UlPBfIKCzOIB39LFuqrh5FZ00e
	BzNybwm6DbaUZcnHfFVEJfymogFwkSOfKuSSzdi+VAPaglC1YboF+c9hbI+0vLnpUr4YP7ZGBGv
	IKyUWP5ekHUBBFJqA0hcFjetZYOk8IHZ9X3/ixzXmrbKBxTajVWC3fOVZWPhxIEK9Wm+Xg5v3Jl
	yCmXOBukcZPgsvnkXiIXau8JTNj4LziqF2DgnfN/e6H93Yi5DQjKWzLmRaxBkMxdlqmzYqcCeR1
	SneED1rfSq6QlGKemCUqCP/9nENiRbw+0fwZmgV4nGGrM
X-Google-Smtp-Source: AGHT+IFlSe6sbMbTSuOg6u2AFFHkncCf/aboZnrFBeb3plYt2M1g7caLrLJTlnNZL7b96zAaRKt4Pg==
X-Received: by 2002:a17:907:969e:b0:af8:fc60:5008 with SMTP id a640c23a62f3a-afddcd113eemr121159066b.4.1755609375493;
        Tue, 19 Aug 2025 06:16:15 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce53d60sm998744666b.20.2025.08.19.06.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:16:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: rockchip: Minor whitespace cleanup
Date: Tue, 19 Aug 2025 15:16:09 +0200
Message-ID: <20250819131607.86338-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250819131607.86338-3-krzysztof.kozlowski@linaro.org>
References: <20250819131607.86338-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6570; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=63JgKqF3bc5t1TwNQeM5U464DiEpmWFQDp6CzuzSqJM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHkYebIcahBFBqreRmNe33++dMlPkjj+8wJIZ
 2Hj40Y7qw6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5GAAKCRDBN2bmhouD
 15l7EACPLhACEmtJ9t9YjD/9I0wca/SoRWGRlR0miHb8fOJJ/ZUdZ/TqYmuFbUZdIYkCRNryYeO
 Ah3lx7QD+SfVtWmULtH8QaFr9yhHN4qXrmsfqUlDAYNILt3i0VBLjk+sFRM4bfSzGM+bsqbsvki
 xGDBMtiSNy8RJDs+PbrhGjDkGjmOao5H1V6WYcmjlWQ54n9UbXgZWvQcHCBiggl0cAnIn2P6nk1
 GZ1mJxgT0mdIz1AwoHLzRr6DUTJwHpf7LQScLxE3oNUN/QzqXsL7QSJyWcFWGgYj0Bltxi71UjL
 91LKtj8LKkaG/I1aavb1AWprGDlvw8dZ8LPTUlh/dm9nXTPAS2N/HgH63zOA8hEajXd55qPYjBs
 tRz4BuME5cyCK2V8ygLSIGT0pbCeFaV4tckpgiQPVnz/lLZ+V6NxNNdvDEUfnaaz3hpWvJNERpW
 n+LZDBATQT2QhPK/ciSfFfZtH3sunRKb6JTPRnfjemMV9CdxkSr92N0FV1/q/k6LcbMeIEbzbEz
 DhYZ+kmQccoc1SOIX27IgL925+XNT8hfXmiGKDOkgqKUFzDje0o01PkRrxKWDZSDOAxvjRVJ7v3
 MgeUWrS5Mo9/ANCZpbMFcmNRnTWLIeWvxlULSeQXODt3ChbQ08vwhyRoPwqZ9yeknpv1sSRi1Wl WaVtMluTg3SvWMg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '=' or '{'
characters.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi             | 8 ++++----
 .../dts/rockchip/px30-ringneck-haikou-video-demo.dtso     | 6 +++---
 arch/arm64/boot/dts/rockchip/rk3308-sakurapi-rk3308b.dts  | 2 +-
 .../boot/dts/rockchip/rk3399-puma-haikou-video-demo.dtso  | 6 +++---
 arch/arm64/boot/dts/rockchip/rk3566-bigtreetech-cb2.dtsi  | 4 ++--
 arch/arm64/boot/dts/rockchip/rk3588j.dtsi                 | 4 ++--
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi b/arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi
index b4bd4e34747c..192791993f05 100644
--- a/arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-pp1516.dtsi
@@ -72,7 +72,7 @@ vcc5v0_sys: regulator-vccsys {
 	};
 
 	vcc_cam_avdd: regulator-vcc-cam-avdd {
-		compatible  = "regulator-fixed";
+		compatible = "regulator-fixed";
 		regulator-name = "vcc_cam_avdd";
 		gpio = <&gpio3 RK_PC0 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
@@ -83,7 +83,7 @@ vcc_cam_avdd: regulator-vcc-cam-avdd {
 	};
 
 	vcc_cam_dovdd: regulator-vcc-cam-dovdd {
-		compatible  = "regulator-fixed";
+		compatible = "regulator-fixed";
 		regulator-name = "vcc_cam_dovdd";
 		gpio = <&gpio3 RK_PC1 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
@@ -94,7 +94,7 @@ vcc_cam_dovdd: regulator-vcc-cam-dovdd {
 	};
 
 	vcc_cam_dvdd: regulator-vcc-cam-dvdd {
-		compatible  = "regulator-fixed";
+		compatible = "regulator-fixed";
 		regulator-name = "vcc_cam_dvdd";
 		gpio = <&gpio3 RK_PC5 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
@@ -106,7 +106,7 @@ vcc_cam_dvdd: regulator-vcc-cam-dvdd {
 	};
 
 	vcc_lens_afvdd: regulator-vcc-lens-afvdd {
-		compatible  = "regulator-fixed";
+		compatible = "regulator-fixed";
 		regulator-name = "vcc_lens_afvdd";
 		gpio = <&gpio3 RK_PB2 GPIO_ACTIVE_LOW>;
 		pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou-video-demo.dtso b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou-video-demo.dtso
index ea5ce919984f..760d5139f95d 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou-video-demo.dtso
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou-video-demo.dtso
@@ -26,7 +26,7 @@ backlight: backlight {
 	};
 
 	cam_afvdd_2v8: regulator-cam-afvdd-2v8 {
-		compatible  = "regulator-fixed";
+		compatible = "regulator-fixed";
 		gpio = <&pca9670 2 GPIO_ACTIVE_LOW>;
 		regulator-max-microvolt = <2800000>;
 		regulator-min-microvolt = <2800000>;
@@ -35,7 +35,7 @@ cam_afvdd_2v8: regulator-cam-afvdd-2v8 {
 	};
 
 	cam_avdd_2v8: regulator-cam-avdd-2v8 {
-		compatible  = "regulator-fixed";
+		compatible = "regulator-fixed";
 		gpio = <&pca9670 4 GPIO_ACTIVE_LOW>;
 		regulator-max-microvolt = <2800000>;
 		regulator-min-microvolt = <2800000>;
@@ -44,7 +44,7 @@ cam_avdd_2v8: regulator-cam-avdd-2v8 {
 	};
 
 	cam_dovdd_1v8: regulator-cam-dovdd-1v8 {
-		compatible  = "regulator-fixed";
+		compatible = "regulator-fixed";
 	        gpio = <&pca9670 3 GPIO_ACTIVE_LOW>;
 	        regulator-max-microvolt = <1800000>;
 	        regulator-min-microvolt = <1800000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3308-sakurapi-rk3308b.dts b/arch/arm64/boot/dts/rockchip/rk3308-sakurapi-rk3308b.dts
index aee6643e33ab..3473db08b9b2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-sakurapi-rk3308b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-sakurapi-rk3308b.dts
@@ -260,6 +260,6 @@ &usb_host_ehci {
 	status = "okay";
 };
 
-&usb_host_ohci{
+&usb_host_ohci {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou-video-demo.dtso b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou-video-demo.dtso
index d28880b8dd44..5e8f729c2cf2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou-video-demo.dtso
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou-video-demo.dtso
@@ -26,7 +26,7 @@ backlight: backlight {
 	};
 
 	cam_afvdd_2v8: regulator-cam-afvdd-2v8 {
-		compatible  = "regulator-fixed";
+		compatible = "regulator-fixed";
 		gpio = <&pca9670 2 GPIO_ACTIVE_LOW>;
 		regulator-max-microvolt = <2800000>;
 		regulator-min-microvolt = <2800000>;
@@ -35,7 +35,7 @@ cam_afvdd_2v8: regulator-cam-afvdd-2v8 {
 	};
 
 	cam_avdd_2v8: regulator-cam-avdd-2v8 {
-		compatible  = "regulator-fixed";
+		compatible = "regulator-fixed";
 		gpio = <&pca9670 4 GPIO_ACTIVE_LOW>;
 		regulator-max-microvolt = <2800000>;
 		regulator-min-microvolt = <2800000>;
@@ -44,7 +44,7 @@ cam_avdd_2v8: regulator-cam-avdd-2v8 {
 	};
 
 	cam_dovdd_1v8: regulator-cam-dovdd-1v8 {
-		compatible  = "regulator-fixed";
+		compatible = "regulator-fixed";
 	        gpio = <&pca9670 3 GPIO_ACTIVE_LOW>;
 	        regulator-max-microvolt = <1800000>;
 	        regulator-min-microvolt = <1800000>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-bigtreetech-cb2.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-bigtreetech-cb2.dtsi
index e7ba477e75f9..7f578c50b4ad 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-bigtreetech-cb2.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-bigtreetech-cb2.dtsi
@@ -53,7 +53,7 @@ led-0 {
 			gpios = <&gpio4 RK_PA1 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 			pinctrl-names = "default";
-			pinctrl-0 =<&blue_led>;
+			pinctrl-0 = <&blue_led>;
 		};
 
 		led-1 {
@@ -62,7 +62,7 @@ led-1 {
 			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 			pinctrl-names = "default";
-			pinctrl-0 =<&heartbeat_led>;
+			pinctrl-0 = <&heartbeat_led>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
index 3045cb3bd68c..9884a5df47df 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588j.dtsi
@@ -28,7 +28,7 @@ cluster1_opp_table: opp-table-cluster1 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp-1200000000{
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <750000 750000 950000>;
 			clock-latency-ns = <40000>;
@@ -49,7 +49,7 @@ cluster2_opp_table: opp-table-cluster2 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp-1200000000{
+		opp-1200000000 {
 			opp-hz = /bits/ 64 <1200000000>;
 			opp-microvolt = <750000 750000 950000>;
 			clock-latency-ns = <40000>;
-- 
2.48.1


