Return-Path: <linux-kernel+bounces-892118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC67C445F0
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 20:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CDB64E2E2E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 19:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCE621D5AA;
	Sun,  9 Nov 2025 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUKLYQeJ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCEC4C81
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762716101; cv=none; b=YY3/IYl+LB600GD3ksDUyVpNDK0nX+g/dgnAceib45DGSNgrbGdvUyXz1EsQir1AJGalkY5n/LNwYY9LhZq/++v/lwoI0wk1okC4rLdULSlq/mw24rIe2P1/ASET0VWayjZjtx5JE98EeD11olRc74jaYExtr85qeirn7VkOMIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762716101; c=relaxed/simple;
	bh=vA2TQqnBx9IQODBIRnR8HiIllBg9XNr7ijLGbLxx2zU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UhHwk4PZN2L0D2wszQ4UGny0/vSJpKe1KOyWEh1GksLBN2kOrqlx3R0oHFwKDvDxcp7SNS2BPMhbdb9qRtMgqzxPsAw8JWgY4i/VDvCcsLJU6SXAWZW6YXHk+MOhZC6U+k8hS24OaWLwjPrBc8zqxczwEjBjPWt+olLG0Jr8gvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUKLYQeJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477442b1de0so15419345e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 11:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762716098; x=1763320898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6vH5fXGe4VkkrWElN9kTcP4/mFYhBdwL1V1ZVaN0zdo=;
        b=UUKLYQeJZbkUuchj9IEZ18ICBTJSog9t9pysgI907TXyuW+rql0H9FLriVTF7iipLx
         hvCUeg5kmhGLZcJeP5I1RFsdRHwhSsMo2LjElfdR0aN9pvlZqSVrbzQk/2p3m+sWCbOg
         ZZVPeydNkScJmkSeTSyzgFzOYRrzOlgGLo+pvsakyBdIhOgNR58MKI1Geblcqf3k43BE
         uSR/OG1iAjjSKjCFqEj5J/HYn2JfR3Y6l5ZSuPK5n1+6wDJhGwjSqy0Nj62l1QccJJiy
         We5GrPqLfWMwdIJawFStHFdXkYm4qeXFFUvGDBGPcVba069VSs+aKy0qWBwJpdyp+eLR
         0s+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762716098; x=1763320898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vH5fXGe4VkkrWElN9kTcP4/mFYhBdwL1V1ZVaN0zdo=;
        b=uTpxiKtU0c1xMIP5OQEfLjTseZNipuFVPv5wnlmwkHU02VJmSNevZEwPAdbmdehogT
         mcXV5HKbSaTJiGIX2mCN5lVvEHqt+VEbgDTGCevq+ow7XxYIaL+PtzBcpyG371cK5ivH
         XqCYRFRTWcFJwm4ymYvnbvuZldI+yXQv3XuUdwjDo4ck6lymfZISj3E+a9HHDut2fUU6
         JSLnE07NEvdb/JXAofNyh8AlzmofEuy2To0FgQN+zn3UJPkh8840d3thdypfgHwlNCkf
         MXd6qdmoE7+J2pSYbpgbLMXmWqpBZRlrFgEX99uj1V1dYgDg6u16PhT7mUfb/KXrjMa9
         fLwA==
X-Forwarded-Encrypted: i=1; AJvYcCWPQyUdoqO3xAzh3uaZCPVV+IuZ4DoCR5+WbGjN7HhZ2K8syeJIS41lWYwGNPaZ8o4WBxkI8Ges2W9dsNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJuCr74WYmLGjCMmcSOESCAg4zXCQA2vSUJNix84zb5/x2HJyD
	7Nogj3xsxPEqmm0jUY92e2mQgJdJO0K+293+X9bem8nMcUra2cHDrTZc
X-Gm-Gg: ASbGncstXLQuIS3U3kOheltZLKMa5or/Ju6z89jhLsxp+29EAZONxotVCGUUKEY4w6a
	B+G/bPIao616xqi5/x/0NlsRv8YUO42Ej6NR7Mo4delUvpL7LzfmDVUZYzf8OwJnNGPkMzOmf7B
	MuqGimB9c3pwAdP/WHilyEhgSlmElZbFZwrKVSiEyG25958IeQdXBcpPDM8qXwMAlV2CFeG9xcG
	fDOYKHsCKScuJDwO+RSN8Yb8aapPEzWf9iWoCU6d85dwDboNMrorl/dYscUl0VbrYNPkVuJ7zyk
	ILrWk+HVo4g/HnuDz61tDfjBq4wFR1WZbzP1bQ4d9hnZiYxfCivYWOp7LMLTPqqfrLCJT8qkd+Y
	awOp9g4Drb5u3QGwJDhOyyl7H1e9QpibF4zx4zpAvDPcuyw9I7xuepZZe4iu3m9v4u092qk9Rde
	fNz64qrXHus7nTh/k8mdKGOkfE6mrlNvDd7LmRfegiDg==
X-Google-Smtp-Source: AGHT+IHEGGaPojLqJnQJyx/eRJbJgTm2GWxMz4aHcXLzOtk0tX2JbG/6GFj/8DCLl3D0UN/5mSd4Yw==
X-Received: by 2002:a05:600c:3554:b0:477:557b:6917 with SMTP id 5b1f17b1804b1-4777323ae5bmr54155475e9.18.1762716097419;
        Sun, 09 Nov 2025 11:21:37 -0800 (PST)
Received: from apple.sigmaris.info ([2a02:8010:6606:0:d132:d099:e4e7:cb00])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e7a6desm91150875e9.8.2025.11.09.11.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 11:21:35 -0800 (PST)
From: Hugh Cole-Baker <sigmaris@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Dragan Simic <dsimic@manjaro.org>,
	Alexey Charkov <alchark@gmail.com>,
	Hugh Cole-Baker <sigmaris@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: add pwm-fan for NanoPC-T6
Date: Sun,  9 Nov 2025 19:20:51 +0000
Message-ID: <20251109192128.72527-1-sigmaris@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FriendlyELEC offers an optional heatsink and fan addon for the NanoPC-T6
and T6 LTS, which plugs in to the fan connector on the board driven by
pwm1. Add the fan as an active cooling device for the SoC package.

Signed-off-by: Hugh Cole-Baker <sigmaris@gmail.com>
---
Changes from v1: https://lore.kernel.org/linux-rockchip/20251026194858.92461-1-sigmaris@gmail.com/
* add the fan to the base board dtsi instead of overlay (Heiko)
* just use 2 trip points for warm and hot temperatures (Dragan, Alexey)

References:
FriendlyELEC heatsink with fan addon:
https://www.friendlyelec.com/index.php?route=product/product&product_id=305
Vendor DT with trip points and PWM duty cycle values:
https://github.com/friendlyarm/kernel-rockchip/blob/4944602540b62f5aad139fe602a76cf7c3176128/arch/arm64/boot/dts/rockchip/rk3588-nanopi6-rev01.dts#L75-L90

 .../boot/dts/rockchip/rk3588-nanopc-t6.dtsi   | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
index fafeabe9adf9e..9164a0ee6228e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/soc/rockchip,vop2.h>
+#include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/usb/pd.h>
 #include "rk3588.dtsi"
 
@@ -89,6 +90,14 @@ usr_led: led-1 {
 		};
 	};
 
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		cooling-levels = <0 35 64 100 150 255>;
+		fan-supply = <&vcc5v0_sys>;
+		pwms = <&pwm1 0 50000 0>;
+		#cooling-cells = <2>;
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		pinctrl-names = "default";
@@ -591,6 +600,36 @@ &i2s6_8ch {
 	status = "okay";
 };
 
+&package_thermal {
+	polling-delay = <1000>;
+
+	trips {
+		package_warm: package-warm {
+			temperature = <50000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+
+		package_hot: package-hot {
+			temperature = <60000>;
+			hysteresis = <2000>;
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map0 {
+			trip = <&package_warm>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+
+		map1 {
+			trip = <&package_hot>;
+			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
 &pcie2x1l0 {
 	reset-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc_3v3_pcie20>;
-- 
2.50.1 (Apple Git-155)


