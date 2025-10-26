Return-Path: <linux-kernel+bounces-870540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34467C0B16F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061B3189D5D1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 19:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4172741DA;
	Sun, 26 Oct 2025 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf5CXgJA"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF111E1E00
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761508147; cv=none; b=mjjjqDAR8i1zGtIF2gsSB+uAtvn1XCDddqfB3SAa06V0kiV3ktI869QA5Wpg0nKZVbs3u5Zd36kH/rR0u6n6qKtK+3HEB4pGqxU/CbU7YmTNp8mEvG3id2qC31FbKyGsB/nbTyyTfJ2Y9yFIm0XilbIJU/nDJGxHpz6onvG8WOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761508147; c=relaxed/simple;
	bh=yEDM5djfStEQKMjG1jKwNq677sq7Oympi+OJl1BgcBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LOg9c/c8Hlm5EaBBrBBjLYOyXXqAOeducyLVGD37HOQUcowrEIy7OwE37veEV6294V0vOEoqdpEFcm2SBFt0VEhqlal8YMlB9z6szxqy2sNKjrdoHbRcNZCDqQJQkfm8yAoJv8THMLE56oL2wOpjX8xcLlGJRSwQTQxsgFjmax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf5CXgJA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-475de184058so4167075e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761508144; x=1762112944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dGAlA6xEEpg5Sg3NpocSMWJ7GFQOTpi3dlaTTRDDDLM=;
        b=Sf5CXgJAJVBgfbmWIB/1/N4dB37FvGhGcfSF5L1dBSKgdNzKGEsoIMMnPWKv+NPGmW
         CfcwXKZATG1bC3lelxCnACSWyV7k071fCGhQ57YbwP8caDtvVRlqswKO3OjqkNRathag
         nDo3hVy0SFnWwuFirpuirnsmu5KL9XW8fhx1QtVhtoAI1GOge4ytm1vHWwVO1vuGu8AL
         rgzhuZO+EwB4j42ZdRt+/brYhq4+d2IOskfYeUY4B+TPMDN0OE8sm0wiwBr18ExXCpgT
         uem1kr7o/Br1J/G3hjkdr5WdNQSvcyzqujh8j6LAIXIhwDgdwpvG2YOFTaCR4wzul9e0
         blfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761508144; x=1762112944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGAlA6xEEpg5Sg3NpocSMWJ7GFQOTpi3dlaTTRDDDLM=;
        b=UAfWe/rUeLy6wZFVGqGGos8VzUoPyr6W7DP+EOerEyNwHOQSnMB+IfTs3dA/lail7Y
         GEmF684Fd6hZ6gmHc65+zU/CRyE/N78M1CfgPZQ6Zz+gfCW50r+LDJfu55kojocTbfWk
         eLIqAAxcZvOSBYk/9WUGfjLve20+yKm3gaZV41zqzwROtna8Lbp7imS+MvsOvU8W77N+
         rPCK1v7Sj1pT9YgHmv1KBKZUF+rHMx8ONlUs6XFPVRcrPbW4rTDK8ZFRq89Lt4V7u8CE
         lzF6BVxjdoTiY33olz+aUknKMRebHsgE9c16ymoIgfI3Di17qNH9/QV6FeH4BgdJ9xNK
         bMPw==
X-Forwarded-Encrypted: i=1; AJvYcCWuEtkrXQLZkZuMxKLBCCsDEnIqH4BAwXJPYqgQw6fHY/b8Cvup8ICj3I2lUxrldur4+6m8xHfXZN+CiCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyitjxzGqfVW3r/iweOWfi3Bfq3gsYB09xZuerHEHephgyoRWU0
	TV6hWOHr1obDNQeSOsQFas65yJTeeCXQkrYymVliIwnXtvuvYWZtiUmz
X-Gm-Gg: ASbGncvcB8vdxbDhtw3Pbyu+JOn7mYLkC6AOIaKV0+6Cg5izy7n6o8dqL0bARGz+vic
	yuj4Pb10MWFbbXYt4JfnP1yGWyAJRKL4vGOhUif5BTrB/mxMsR77ffg/DhFEtrDkJhOMuiG1ETH
	TVkxXuVua3QCogThdI0sIRkAsTgKg3WjVVyDz7SQjX+K8LLPnPv1MZvACaOQF7J+AU2sQN7SSxf
	7INIuBMMsk7SLfplwq4lamh66VYpDwzP27ipLxftGPhizEzX5U0Dq/q24GNiM0Z+lEokn96pQXb
	HgWuXm3ysl13hyTUvH9wri7zAw+E7CABCyYC5aOWjt/dO5fc7NH54eRl7p+2hOT1T4UmgXuYYy+
	xSIdWG/2qCUJ0408Pa4tjcFjQtDeqbZ/4YHkpeIKbSED46Vv/7G9Np1pHjAR+3/CgKZtY4cazxj
	p40W3K8ZdlPMY7nA==
X-Google-Smtp-Source: AGHT+IHxjRQnRW5DZRFV2Qwhcw+akufX9vynEkSIauiFSd7fK9owVylMsihE4r48/PVg7PHb0yVz6Q==
X-Received: by 2002:a05:600c:468d:b0:471:95a:60b1 with SMTP id 5b1f17b1804b1-475d2ed6e11mr100007385e9.32.1761508143555;
        Sun, 26 Oct 2025 12:49:03 -0700 (PDT)
Received: from orange.info ([2a02:8010:6606:0:8fa:2ba2:6886:7fe4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd05098dsm45244265e9.5.2025.10.26.12.49.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 12:49:02 -0700 (PDT)
From: Hugh Cole-Baker <sigmaris@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Hugh Cole-Baker <sigmaris@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: pwm-fan overlay for NanoPC-T6
Date: Sun, 26 Oct 2025 19:48:40 +0000
Message-ID: <20251026194858.92461-1-sigmaris@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FriendlyELEC offers an optional heatsink and fan addon for the NanoPC-T6
and T6 LTS. Add an overlay which can be applied if the fan is fitted and
configures the fan as an active cooling device for the SoC package.

Signed-off-by: Hugh Cole-Baker <sigmaris@gmail.com>
---
FriendlyELEC heatsink with fan addon:
https://www.friendlyelec.com/index.php?route=product/product&product_id=305
Vendor DT with trip points and PWM duty cycle values:
https://github.com/friendlyarm/kernel-rockchip/blob/4944602540b62f5aad139fe602a76cf7c3176128/arch/arm64/boot/dts/rockchip/rk3588-nanopi6-rev01.dts#L75-L90

 arch/arm64/boot/dts/rockchip/Makefile         |  9 +++
 .../dts/rockchip/rk3588-nanopc-t6-fan.dtso    | 78 +++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-fan.dtso

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 4cd8ef607f55c..7a67b68a6bb03 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -178,6 +178,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-jaguar-ethernet-switch.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-jaguar-pre-ict-tester.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-mnt-reform2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-nanopc-t6.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-nanopc-t6-fan.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-nanopc-t6-lts.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-ok3588-c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-orangepi-5-max.dtb
@@ -271,6 +272,14 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-jaguar-pre-ict-tester.dtb
 rk3588-jaguar-pre-ict-tester-dtbs := rk3588-jaguar.dtb \
 	rk3588-jaguar-pre-ict-tester.dtbo
 
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-nanopc-t6-with-fan.dtb
+rk3588-nanopc-t6-with-fan-dtbs := rk3588-nanopc-t6.dtb \
+	rk3588-nanopc-t6-fan.dtbo
+
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-nanopc-t6-lts-with-fan.dtb
+rk3588-nanopc-t6-lts-with-fan-dtbs := rk3588-nanopc-t6-lts.dtb \
+	rk3588-nanopc-t6-fan.dtbo
+
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b-pcie-ep.dtb
 rk3588-rock-5b-pcie-ep-dtbs := rk3588-rock-5b.dtb \
 	rk3588-rock-5b-pcie-ep.dtbo
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-fan.dtso b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-fan.dtso
new file mode 100644
index 0000000000000..08c4782fb4148
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6-fan.dtso
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/thermal/thermal.h>
+
+&{/} {
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		cooling-levels = <0 35 64 100 150 255>;
+		fan-supply = <&vcc5v0_sys>;
+		pwms = <&pwm1 0 50000 0>;
+		#cooling-cells = <2>;
+	};
+};
+
+&package_thermal {
+	polling-delay = <1000>;
+
+	trips {
+		package_fan0: package-fan0 {
+			temperature = <50000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		package_fan1: package-fan1 {
+			temperature = <55000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		package_fan2: package-fan2 {
+			temperature = <60000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		package_fan3: package-fan3 {
+			temperature = <65000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		package_fan4: package-fan4 {
+			temperature = <70000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&package_fan0>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+
+		map1 {
+			trip = <&package_fan1>;
+			cooling-device = <&fan 2 3>;
+		};
+
+		map2 {
+			trip = <&package_fan2>;
+			cooling-device = <&fan 3 4>;
+		};
+
+		map3 {
+			trip = <&package_fan3>;
+			cooling-device = <&fan 4 5>;
+		};
+
+		map4 {
+			trip = <&package_fan4>;
+			cooling-device = <&fan 5 THERMAL_NO_LIMIT>;
+		};
+	};
+};
-- 
2.50.1 (Apple Git-155)


