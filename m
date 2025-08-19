Return-Path: <linux-kernel+bounces-775815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BF4B2C558
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1919016D6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE3F340DBA;
	Tue, 19 Aug 2025 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9y7A+2k"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F72340DB8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609436; cv=none; b=mMiyws8WSNYfhl97ljVKX0bOzpZV+77jSHpXsYBsuVRm6Wk3jdZ/htGpxz1UcoiA0vr018ZTicD2EeXVeVqDK/DOAonnHr+jMT7oPNR+MYwJjlQeK+qqEGOvSg5OJ+eBidjSxsDgOvB7xuqlplMlTPpJtI/ZBk8Nmt4hXEl0kR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609436; c=relaxed/simple;
	bh=B3zj8kIxlI6NNxjczKCH38wkItfXZHU2cc6N45nCziM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qHgvhCF3/HHZ607JGczuC0HcSJkV+GPemsdPRxw/Qt66+vMncFkxfREhRiCvXv4DUewV/g22WCmWKfmz8E2hel0mZHWe6WPM1VcgIzC7x5u52655WOOgA03GXsLQm78epuvGrRnbApc2yTMf4zeKkQzAch1L3Ex2bcXGPJkaLZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S9y7A+2k; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61a483149e8so269094a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609433; x=1756214233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JKZOwRgVgk/u0KdrUt1cAkiGVJS+RKkMWzXrX75b1m0=;
        b=S9y7A+2khAAmcHXfpA07aS2nU5j/JXECTWVI0FWyhHwHkPOet9P+b5YmD4m0oVDwX9
         PGAxoKjZ/FyDtQIIHWdOUcziIhaM4A4HWoKsawi2F8D4qwaUaG3d+PcwGeROPG9niNmM
         V+k73dPCTN9vTIeyqPZ9JIB9h5ArfJ5aYrYqFa8ylTpb0GX7wiKcRmhRBmgYUzehqxdR
         lGhagwk8X0dUlhjszA5qgQvU+9FVdVIFbC9F2OMvxdLudnhFjSEZvY3533XUjVoEhoDT
         5f+SmAdq6TnDPmFS6tlrWXgeYU7Ea54IiDyGbQpBgwd1u2k9mYnGjoW8Q9f+TX/oyM4y
         SUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609433; x=1756214233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKZOwRgVgk/u0KdrUt1cAkiGVJS+RKkMWzXrX75b1m0=;
        b=vIk/C9Nap3PJJw6pnct+LKr8weJfC5UYwvUy/0Vz9yCQg6o/GMcYzYCV2FgdOB2HXm
         J0vgs25JmVlPXWJGJNbwUlaZi8TxO35Bt2nPqCahDUK0EZkt0jVVPHzTa2djhcp0wRJf
         Znmwfw2H4too+T7A/XOs/eAzjfIXXJ6aFyFvYlo41dhiniWls4K8yGLkqHRFbQ0J6mxS
         AlqPA7ZWFksDpQaUGG6BbmcA++qe85uuLYZetnyqLThPz18FKBs7fn35o16EIloArTPN
         velZmyzc0A9cpJ52wWK/5LfggO4sd6fy7i3n5andIiArQD5UEZCb3wwqflJRDynghSw7
         b/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjaq8JaZ06YqnTN0e06k93JStzXm/aLB7aZEEOwhGm5G2zQZiwH4OIlVQAfDIk+HrO/Tib5GltCvLjDsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRGHWJ5GpwyeloJVh+6yK2EeN01wioQwzSqK4XieR/V/jJh/SL
	BePXh61Gy+6qKV3i0y6k5g4jxf4hUUrTU4Ied05cM7NXI8R3WLUgcbWPboFekx8pwjM=
X-Gm-Gg: ASbGncvTrf3tPRzZureC3bfuOIzNz+cvkRAZFT57dkTrC7DuRRW/2N03EHW8QneeriH
	ivb8gsvxEg6p2GO8oVFpQl8KpvxcXR/tIVrDHplVH3gkkvcGFexP41vYA84Q9wMn6OofbxDxxZT
	1E7OAapENhetSAxlPbDHXC0ZJisz/pfqxjppLlBH3MQY37Uov1Aqx5fgShmJAepxTiEIIRt0vZr
	wVHrCZZFKvY9K3HVyqfiw+E+NmUSDLqoOe4VOKk29mcfaacefR/nM7uVgMqNJnS9L/YkDn+kMVH
	AqI8U9cqhTHLB6pk3jHGtgroxps+1h1f5eza1ZsPBZL2TQ4+jkiErbM5kAG2VVnGuLK+NTw7MIi
	z8+fdBIbbSwZJE5wCjFENneaq0knm31Xfrg==
X-Google-Smtp-Source: AGHT+IE/vAUGvaFZ7UmmcB7vUKiiYyvdlgsGn3EINffXwUbDoJ0n2eu7BMJecMYq+4729BjHVfjv/w==
X-Received: by 2002:a05:6402:13c7:b0:612:e258:33e2 with SMTP id 4fb4d7f45d1cf-61a7e768851mr1075178a12.4.1755609432667;
        Tue, 19 Aug 2025 06:17:12 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a92678f45sm129674a12.18.2025.08.19.06.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:17:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>,
	=?UTF-8?q?B=C3=B6rge=20Str=C3=BCmpfel?= <boerge.struempfel@gmail.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: stm32: Minor whitespace cleanup
Date: Tue, 19 Aug 2025 15:17:08 +0200
Message-ID: <20250819131707.86657-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=B3zj8kIxlI6NNxjczKCH38wkItfXZHU2cc6N45nCziM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHlTkXi33JJKHIMfKBoPhPxIx908F+l6S81a7
 m1fzcytzaeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5UwAKCRDBN2bmhouD
 1346EACYQWFZHMhc9Q28PrXrM2zH4iKyydMy43eCV8WTv37Msn65uyxgguJ7kyC7hc5MaL4HKOa
 d0JKgl4tyaTwoIkCHUvT5ZewBrP+RHxyq7mTQqTfVHCIwKXtFf8liWHQ1noXqVcWnsy0I1sbcw5
 MMU25nXzXQvz4Aqiv/BIDN0C5N2e4znVVzQcaoHiSjB2Fzdrgi4d3UKDrMCK5gZKfDE8cbFVIbf
 GksfXa95bREav2g46bo/xcVRDYQhRp5Hfk1zyG2Dr3ck7eqQ3AVOxp4tVT9/Hwxgz0bykWSIxCV
 qA0chuos9BWz/JF2cwNxHR27T+R9ezSXbSjMoVf6tjFnZkJXuXKlrRWa3WZ57CRAPFZnnSNH/d5
 lPVdiZiTTBEEw1oySG4+ukrMqs6VEJdNa6ZnSeFclm1PGWhmRyfrRGCJWOf+SZ0YF6tkbbSJUmU
 0sHwyexaVYtKSrY3polDkTaDIU8gPZkHYBIfW7dwPd8bojdX5ghigh+k14+ZGDnSINFI4dJZVKy
 kITbrPn1Udz5I2aRC2GSFK4c75IxREqD4ZxqgKjgakZoc2eY8zLdzJNgY+ps4sHu6GWPhxaam1f
 VRpB5DfQ4FaAdxO7awxj+qtl9dsqEsRQBSoMxHLrpuW7ZYfe+kBEy4aEquCc7+hIY3redt+aRdS E6E7i24wVw2SGxA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '=' or '{'
characters.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts        | 2 +-
 arch/arm/boot/dts/st/stm32mp157c-ultra-fly-sbc.dts | 2 +-
 arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts b/arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts
index 39a3211c6133..b886aa91bb86 100644
--- a/arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts
+++ b/arch/arm/boot/dts/st/stm32mp151c-plyaqm.dts
@@ -255,7 +255,7 @@ &m4_rproc {
 	/delete-property/ st,syscfg-holdboot;
 	resets = <&scmi_reset RST_SCMI_MCU>,
 		 <&scmi_reset RST_SCMI_MCU_HOLD_BOOT>;
-	reset-names =  "mcu_rst", "hold_boot";
+	reset-names = "mcu_rst", "hold_boot";
 };
 
 &mdma1 {
diff --git a/arch/arm/boot/dts/st/stm32mp157c-ultra-fly-sbc.dts b/arch/arm/boot/dts/st/stm32mp157c-ultra-fly-sbc.dts
index ac42d462d449..2531f4bc8ca4 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ultra-fly-sbc.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ultra-fly-sbc.dts
@@ -92,7 +92,7 @@ gpu_reserved: gpu@f8000000 {
 	leds: leds {
 		compatible = "gpio-leds";
 
-		led0{
+		led0 {
 			label = "buzzer";
 			gpios = <&gpiof 2 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
index be0c355d3105..154698f87b0e 100644
--- a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
@@ -262,7 +262,7 @@ &i2c5 {
 	status = "okay";
 
 	usbhub: usbhub@2c {
-		compatible ="microchip,usb2514b";
+		compatible = "microchip,usb2514b";
 		reg = <0x2c>;
 		vdd-supply = <&v3v3>;
 		reset-gpios = <&gpiob 6 GPIO_ACTIVE_LOW>;
-- 
2.48.1


