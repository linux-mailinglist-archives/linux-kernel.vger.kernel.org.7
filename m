Return-Path: <linux-kernel+bounces-792936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D075B3CAA8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 13:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF28C5606EF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EEE279DC4;
	Sat, 30 Aug 2025 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUScDMe9"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B46277037;
	Sat, 30 Aug 2025 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756554704; cv=none; b=g6gRyLYgqoe/CeF1dFtizhaDtaZy+Ib4T8YfHWyTh4X2kLPxqmVKLqL0XZi7/uP6+ZyNVCSGDkQ6Utg28+VvO1rc30zxQfUZyOVl/QFQj0xntjXJENDiprBX7xjj2jbNAw+zgVTzsWuQW5VJwi8ydyYZEquO8HS1HbmTmHYjNEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756554704; c=relaxed/simple;
	bh=LUysgtYWavqj6FrnoG2LzToUjWEBSSbwdiCcC6S2U/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=US/sB4De/cUlpqw5Dsu0K8DD+mDUDRN8zjSuMGhkjLT4JLyxs1qlhf8cq8UPK/JWLW+IoC+FJRZWk+kNgQHF8yNonDTmBpGPP8cKyY6DsXihXLuw37J7Ye6t9uiwNTimXpd90tMCzLDYmmahJBFbgDbgAhvMQlSLxrlNYmGQQLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUScDMe9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b869d35a0so1579775e9.1;
        Sat, 30 Aug 2025 04:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756554701; x=1757159501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=je5dBrj3vm985BEWP7xJBvRk6bSW3/nDeB6FvhlFHgM=;
        b=EUScDMe9EMkQY48CWeWo3lvz8Mzvx5Zg1cGFJBly0Obbp2NvNo/eeXmLyPoMXPuCX2
         o2C98Jy2OlLVEsWffQk4nJ1R/YBK2nomdL9A93Kr5UwSdSYmHegqBFy2MtF1tPldgtRq
         KXgftEzm81yG6s5Lgx6WUHb2wiIwKx9KwZqv9fS3iLz7Xd0nzspdzZHXKeOQamNs/bTP
         hhQc80KuwjOaXqWWaDmy7zvNXXUG7iGWakwedtUujw9EaZpK+8YUkdjoho9GkbLgbOGP
         mOAGuSNt25RChL/VnaPbzFumkUaBqnG5jhimSI7Q0IEflEmMMApCqiSlL/9yWzsJxzpp
         sWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756554701; x=1757159501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=je5dBrj3vm985BEWP7xJBvRk6bSW3/nDeB6FvhlFHgM=;
        b=a0suLTB/lVRthe/hsq2RGl1r8jPK9tPzEk7h8SWwh+aHZi80YygJrjU4hwjO0w15zf
         OUrpc89rBfb/h/f75TL0uk58aAfclkpV8g5c7KDHJI2kw4sYJdvkdxrNYo7icOE2yYLO
         iCwBOAd/igDtG8KytYV0JAQ2uoasIsneI7frWdFyhQ+hSoZeCj71PeBixeS2pxeOb+Wi
         deZtX2M1mODrIokcmSggMj+/qeqJcgtcxKKmqGSRpfXg/W+2yA7n/wmIjylzaHFf+er4
         V1mwl7u6GNaSo9NXbpL6Z96naJLwujuntH0nK4213HagXB6zpdQemRCX6eHcfXyFzq5G
         ai8A==
X-Forwarded-Encrypted: i=1; AJvYcCUMVQnu8wu05nLiCsKXU4VkZEDSc7sbUPTRphPmRMEYgHTHE5VHPAzEqOunpeN2dFwPB/3VS3LAbjAIAzjx@vger.kernel.org, AJvYcCXuQjPpCgWdLNEoFwppZM+buwFgyRmkPrACyU4y2NkqrTK4GN5nGjaU894KL5sGHiNO7SulJecCn0Fh@vger.kernel.org
X-Gm-Message-State: AOJu0YxdnWGDb+ozBddzg1zRuoGp1RaakSIQHpzpwsn15DGsTmuc5egY
	P8U12EqEzQa7MXO4U6NxpPYXbe8WFCpSp3maPdi/FpBXVTKMBOO4yezY
X-Gm-Gg: ASbGncuiZfSNJ4MRI43pLEYY/QeLilp84l6bJUGxRfhWA//E67cGC6Bqetv8W//CGyl
	hTX+j8lKb/cWFNdH2YUmC+QJV8sp1/E3/HpLLoX73y/FGv5/KCmQXLCQzK4uE/sm9zHxIETZ5CG
	Ze1mVDUgyIyL1KstPq53g1s26NaAdWMau2KwWy1BhoUbcHuFf9WN+BjK3QMOPxpcEmxXkT1fgG1
	n8OyLNoB3SLZ2FoM5oLg89RmXnGrOZxRDt5d9+bhLrh0uTjUBymV1nhFIE18a3fydv9SnNjAplq
	4dTIbq0m8qnuwHozgdwXB6oTDKNr9MKcR0D0KAwDzYNIHV4JmekxxhxMPOV5sZfFnVXtkVOdJMx
	9Qs+SaRIgB2Ya/yokrHUQjuL4Fpeyd2vvYumjug==
X-Google-Smtp-Source: AGHT+IGGvKDGAltmu1fh2shx8QY2vgKaepr59Vv01ZMlUK3ev4dZ878EJwGDNjdAFH+LHASm8Pr2+g==
X-Received: by 2002:a05:600c:3b9d:b0:45b:7b00:c113 with SMTP id 5b1f17b1804b1-45b8553f25fmr11981225e9.2.1756554701360;
        Sat, 30 Aug 2025 04:51:41 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b732671b7sm68161555e9.3.2025.08.30.04.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:51:41 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: enable the Mali GPU on RK3328 boards
Date: Sat, 30 Aug 2025 11:51:35 +0000
Message-Id: <20250830115135.3549305-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250830115135.3549305-1-christianshewitt@gmail.com>
References: <20250830115135.3549305-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Bee <knaerzche@gmail.com>

Add a gpu node to the rock64 board to enable the Mali GPU and
move the existing node from roc-pc to the shared roc dtsi to
enable it also for the roc-cc board.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
Note: the a1 board already carries the same change. All other
RK3328 boards appear to be headless designs that have no HDMI
or obvious media capabilities, so no need for a gpu.

 arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts | 4 ----
 arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi   | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 4 ++++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts
index 329d03172433..c0b7b98ff788 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dts
@@ -44,10 +44,6 @@ &codec {
 	mute-gpios = <&grf_gpio 0 GPIO_ACTIVE_LOW>;
 };
 
-&gpu {
-	mali-supply = <&vdd_logic>;
-};
-
 &pinctrl {
 	ir {
 		ir_int: ir-int {
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
index aa1d5a6d7fd5..3fe0c17fd2b1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc.dtsi
@@ -167,6 +167,10 @@ &gmac2io {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_logic>;
+};
+
 &hdmi {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 5367e5fa9232..592fd8ca21df 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -152,6 +152,10 @@ &gmac2io {
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&vdd_logic>;
+};
+
 &hdmi {
 	avdd-0v9-supply = <&vdd_10>;
 	avdd-1v8-supply = <&vcc_18>;
-- 
2.34.1


