Return-Path: <linux-kernel+bounces-865104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAC8BFC40B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0E06614DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CC734847E;
	Wed, 22 Oct 2025 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPTX2EcV"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9B8320A34
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140182; cv=none; b=Uxk90kiMuI08vCDZaDgopfuEn3gPICrvCYauAsxZKjblGgSpkTvhVhkZk92cxSi9D8O6S+zrKskpgoJRL+drSr6Op1ZKPm1etfJdbVtM8PsKIIpuD+fypyS3jLnRf1Z53s9yZqFm+fbqTG4OdSHLMb0jO6qStVLUS6oL6YRO7uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140182; c=relaxed/simple;
	bh=iTsJRmqNa3slkYZC0WXqGOX9CSNODhCwke55eAgwU34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qy1vvZ2iNuU3nRJHNhyDUEfQ4sLWuwwzfGKlfdGtEKxCEten5EaBvuJPvHvGwNNRuzHLohfOdmqL9E+2Oh+Rxjcyyhv8GIjf3+GdMCM+N18XC7azSrNYn2OWz1AH/IqkSWPdC/Kqcqf+Ow8p5J+W36ImbtUx9AWnqrr3MgLL/UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GPTX2EcV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4710c507f47so2307755e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761140179; x=1761744979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dmvGzByM5O4N9sfFvXRYfnFUo6WgQWqvYDajZ7pSaE4=;
        b=GPTX2EcVgBEXqTC+ED58YxPZ8aNhSDo294KIFo5DmIlDwlDBButqKPkvM1x8Q/Z1Hk
         ssHpjZzHXNnVOlbz2bKy9yPi/zLGaJbKxX9veuP/2ew+Db0RUy3te4zN0PuseS8YAmvW
         YdTM1MPz2ksjC5DvFjaZTlmg8QlGOTVpTZAJGWcUQ+1IssxsLo8oUauvQxPlnGeD38nO
         SPWJnUEKKVJ01FGid95HI9BEfbqchhy/heYkENcNeMNrgsRFfGaEyeOvGZfRlZYtF1ia
         cCmOwDnpVOVCnLZSbE1i0ESj32bXxN/3a8a/4YJS0UWFKa9AtxGebtpbRwHIrG/LVx3B
         Pj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140179; x=1761744979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmvGzByM5O4N9sfFvXRYfnFUo6WgQWqvYDajZ7pSaE4=;
        b=uyQOf9Fs37q1Dz180X8l2T6LmVnLB/g2WNZLAzTeH7unFC0pTvJkYk90/8awdjTueM
         svMODlEseH4B5ME9IoXXC5+DbEB7HQetTt+gr584drFC3GYogap7W17+PAh22d0CiQVM
         h1UBQMy3nXAz9ft4nPgONRwya7/1P3cgQ/V6iRmMaE7G8SQMFZxLmCj2Rja2Cr2P1r1y
         8KJi3H7Of3kCdRUR4+1i9T3I3XLuf46Fo1kGKJc4AoBb5i5d1joxVLteXnp2OxWe1oAS
         SKBpRPS3v6HMw1CCL4a29wvbQdVNW4nzHW4yWe7uuXeah4ozrIqeJnz5UqL4AWEzV08F
         rpSg==
X-Forwarded-Encrypted: i=1; AJvYcCWi4fK73cS/Dk+3KWiy0Qeh1EkdS3b9BRKDTFifTN0itBRjRjbezBZUuOrSlX+xQWd+Y9ZrVzbRh2sZpC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6n6CES4AYO8NO29x7LfmzZICA4VOYzoqSp7C6TI8KlpMmjXOV
	GldAvKnqeHGL+qb9zqb5nJyESWKfmzJhbEUL4JTeIbaSwBpDLGX93mxIcQWoxro/EoY=
X-Gm-Gg: ASbGncvHes8IbSzisIpT9JDG7RlpKcC7ln2AhV9m3Az+CTQgEaaOi1l39rN7JKoOG0e
	mmSpxdmIbjUJaYXyysZs0uGIxpiwr9+TBRpjsSfrYA8Uz/+2MLWGvwm3GAJtpvOKOH/k90jQB6W
	kzTeGKn01+409ErgfLQBuXJ6U1M3/01g5iqNdQ6U+w6PDaLtwO0JAzG8/R+BHrPU35RAZWv3Eac
	+uTgkrN+EDu+VjXcIGk5q9WStXl7zlkamQSli+Lh50RSFPTcbDhhOgGoIOxp1E5XSWjC66jSP1A
	ONhAJvD7BB7kJr8My1b6mgz5OT0bdRlyMaK3Dn2y3R6qBsDmr2GmvaHco9oDmR3trE9BedtQ4Ii
	TtFCXYrsmmN40/UjN5l9mPDrG9gM8v1vo58gG/9H/xcg82exl80jgOGC39St/NevjRo0dkcGF7D
	kMzJrg6gur2qs=
X-Google-Smtp-Source: AGHT+IF11NRjqeuEZAE/OBiadKOc1mEMhPEL48ZpZiu16lUe5zj1hRs6GGA2fA/Q4luhxo1H23TAsw==
X-Received: by 2002:a05:600c:3b0a:b0:46e:3c73:2f9d with SMTP id 5b1f17b1804b1-474943059b7mr31754245e9.6.1761140179357;
        Wed, 22 Oct 2025 06:36:19 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427c3bfsm51915465e9.3.2025.10.22.06.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:36:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: toshiba: tmpv7708: Align node names with DT bindings
Date: Wed, 22 Oct 2025 15:36:17 +0200
Message-ID: <20251022133616.74492-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DT bindings expect node names to follow certain pattern, dtbs_check
warnings:

  tmpv7708-rm-mbrc.dtb: pmux@24190000 (toshiba,tmpv7708-pinctrl):
    'pwm_mux' does not match any of the regexes: '-pins$', '^pinctrl-[0-9]+$'
  tmpv7708-rm-mbrc.dtb pmux@24190000 (toshiba,tmpv7708-pinctrl):
    $nodename:0: 'pmux@24190000' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
  tmpv7708-rm-mbrc.dtb: wdt@28330000 (toshiba,visconti-wdt):
    $nodename:0: 'wdt@28330000' does not match '^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi      | 4 ++--
 arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
index 9aa7b1872bd6..88e38d6efcaa 100644
--- a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
+++ b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
@@ -161,7 +161,7 @@ gic: interrupt-controller@24001000 {
 			      <0 0x24006000 0 0x2000>;
 		};
 
-		pmux: pmux@24190000 {
+		pmux: pinctrl@24190000 {
 			compatible = "toshiba,tmpv7708-pinctrl";
 			reg = <0 0x24190000 0 0x10000>;
 		};
@@ -463,7 +463,7 @@ piether: ethernet@28000000 {
 			status = "disabled";
 		};
 
-		wdt: wdt@28330000 {
+		wdt: watchdog@28330000 {
 			compatible = "toshiba,visconti-wdt";
 			reg = <0 0x28330000 0 0x1000>;
 			clocks = <&pismu TMPV770X_CLK_WDTCLK>;
diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi b/arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi
index a480c6ba5f5d..5ea835fe08a8 100644
--- a/arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi
+++ b/arch/arm64/boot/dts/toshiba/tmpv7708_pins.dtsi
@@ -91,7 +91,7 @@ i2c8_pins: i2c8-pins {
 		bias-pull-up;
 	};
 
-	pwm_mux: pwm_mux {
+	pwm_mux: pwm-pins {
 		function = "pwm";
 	};
 
-- 
2.48.1


