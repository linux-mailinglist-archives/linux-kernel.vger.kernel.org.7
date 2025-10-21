Return-Path: <linux-kernel+bounces-862574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84972BF5A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 329D93A4F28
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4E02EBDD7;
	Tue, 21 Oct 2025 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XX+F1M4k"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714011DED4C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040447; cv=none; b=olpiWsTkNoaLsxRa46VyAKndHzykFudR+YUYYs3ZV0PPV5kT77SNG9NsI2N5URoMsFZONqC/WLNJEYrjRhK9TRRBii8oegZn686drSeXuU0FNS4dDOdhbllUDe4LFfyuIdpZTb0yrX0GmsjrcLK06IFy4DOB9Ae0RmHyAqdqXCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040447; c=relaxed/simple;
	bh=toT9t2eGfju2yGlPenQq9corbvXWwN14ISXD1j2rNHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rjDx/8kYAXA9RiFU75qEBGhVzEcpy8QS5Ru+jOXPOnJ/kI8XXZKMAeIQggGYPc5m1wWYCXBn4ki6m555SU9aKBlf0pb23oCwf9nwa1rE3NiRuQJDGWgB3es560anppnuLA4MbS8FqwqiwK0dxkGIKPmvtfKqPdEboyde75tZu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XX+F1M4k; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-426f7da0b64so470318f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761040442; x=1761645242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xZEqEaIIhSQ9NiJHAhDHkl5sUBeC8+EiE67tel3zAWE=;
        b=XX+F1M4kSKd6ynQ6YzMkvFkfnKJvnLS248FKHrgLkT3/TSItmWe28zkDfu/PctWxFH
         XZju1KrhzzcPeO2BWX+Cme2yweavQxt1M/Xg8lskvKxxjVju6FaCnaS7EAxGnMl1UhGD
         yzFrZcZER5q7cb3aXdse0I6+j4EAX7v55HLz3hudrs5diBiGWQCCrgcj2i6fIszJ6cPM
         MH9aV2CrpTSEhZBNXj0tjE6zv0I18EhJTzJKVfhUR0eMnB0wDjUYl1DzrN0mrKhV5fDj
         8trQsLZGtdoLTbPQtpUNLjA979UlRRXF4Gu8CqdNJDHp6xocclP1wp2Ysvk57x0wjiyX
         qV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761040442; x=1761645242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZEqEaIIhSQ9NiJHAhDHkl5sUBeC8+EiE67tel3zAWE=;
        b=hQFqbbmWT8uoSX+Kud5YUfwc1pyPqKqdE8MmvIdm/eGC3C++FiYZm855ELnltAuCSM
         x5rNCHWoPriWhzfCBgrkCFTWPCoDIaSMKGemVGYZQZCxdy2WbegmXwMkRlcUUUX7o0m7
         2zp4XE+P95kzPD47oGJ4JXu9QeY7S6PKM3puArv2dJSBIdzBHNILU/xIJ/zoQAKhtrnR
         U49CZlK3NhW7tIj1X5Jyxg9QurYLGonhe7qYFWtPS3knoubpJXsF49GSuq4mZ0e8QRRi
         L+QDRn6YfPz/LTo93zE9HBIP6M1cl0DhZN46HGfqMstAu5MD8CIySmsiABOv++CLnOct
         DxtA==
X-Forwarded-Encrypted: i=1; AJvYcCVc9lUg7Oe2b/dPyrocmYE9zm16lQqAEz8mXq90Xqc+zOOELHYbM+UxqG4aGyvJPGUDLt1GjaAu2Wz6wx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkFFvTin9TY4qZS6FEMMSjEebQXxWO8K1AOb0NHFH/hetGL4d
	Mu9P5aY1bGS4caIkMLY2CoEeBLIFjJQHdP7IUVOiVlFF5nDp4JVMMLjPfGmO8zBvX27xS/mRxST
	3NOCY
X-Gm-Gg: ASbGncvpXD725v9jak8G8yUhdJdZynR51KJkHdd0mbm44NcDSVT+zQ8to5LTeGnuzk0
	KuKCNi1IVzRdQtEM3tGbvAqdhVPLliCE2nYqDcIUH1m6Bx4ZXP5AJv+1m0GeEI2YDrpVpMfssY9
	M8I8SMylq6VhdbHJo4NQAPsEV0TRZgFi0jtKHZurdGRE0joCheqbmlBD+FGgdpj4wKoLfslrzNp
	MwA/lQlvbBmXBQgob7cw3wdzvYjb/QhYcVlTTnFIfRPFc+Nqd3CzgaGn0IJnJmZ3ReayN9gYS4K
	1MP7+hrlJDlbG9wUDd2oKLZakIlhJqprVvP+vhsZ3lwBUWl5yNCprJ1M0OLxqRr66Z8Y58Rxqmn
	BeyQvT8nWMxdwbSQjAsq/90fCQ8LvTunYt0nA6aWSwuu3OidO7ozalu1vWM6tiECxQTcHTnZf46
	Fg/hXI91aJHDMzJjbUxImaHA==
X-Google-Smtp-Source: AGHT+IFEiN4sLEw3fcFRGpw6JAxthmcFeTBaGfvAMqR6Hz5fMeuAM8RkyUFBMZW/GNOXuUUQ4OCfRA==
X-Received: by 2002:a05:600c:474c:b0:471:1387:375e with SMTP id 5b1f17b1804b1-4749436b96emr12266045e9.5.1761040441588;
        Tue, 21 Oct 2025 02:54:01 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496afd459sm13882665e9.1.2025.10.21.02.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:54:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: Update Krzysztof Kozlowski's email
Date: Tue, 21 Oct 2025 11:53:55 +0200
Message-ID: <20251021095354.86455-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update Krzysztof Kozlowski's email address to kernel.org account to stay
reachable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Rob,
This should apply cleanly on v6.18-rc1, can you grab it?

Maintainers + mailmap will go separately.
---
 Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml         | 2 +-
 .../devicetree/bindings/display/bridge/parade,ps8622.yaml       | 2 +-
 .../devicetree/bindings/display/bridge/sil,sii8620.yaml         | 2 +-
 .../devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml       | 2 +-
 Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml         | 2 +-
 Documentation/devicetree/bindings/input/cypress,cyapa.yaml      | 2 +-
 .../devicetree/bindings/input/touchscreen/st,stmfts.yaml        | 2 +-
 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml    | 2 +-
 .../bindings/interrupt-controller/ti,omap4-wugen-mpu.yaml       | 2 +-
 Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml     | 2 +-
 .../devicetree/bindings/media/i2c/samsung,s5k5baf.yaml          | 2 +-
 Documentation/devicetree/bindings/media/i2c/samsung,s5k6a3.yaml | 2 +-
 Documentation/devicetree/bindings/media/qcom,sm8750-iris.yaml   | 2 +-
 .../devicetree/bindings/media/samsung,exynos4210-csis.yaml      | 2 +-
 .../devicetree/bindings/media/samsung,exynos4210-fimc.yaml      | 2 +-
 .../devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml   | 2 +-
 .../devicetree/bindings/media/samsung,exynos4212-fimc-lite.yaml | 2 +-
 Documentation/devicetree/bindings/media/samsung,fimc.yaml       | 2 +-
 Documentation/devicetree/bindings/media/samsung,s5c73m3.yaml    | 2 +-
 .../devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml          | 2 +-
 .../devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml          | 2 +-
 .../devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml       | 2 +-
 .../devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml          | 2 +-
 .../devicetree/bindings/pinctrl/qcom,lpass-lpi-common.yaml      | 2 +-
 .../devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml       | 2 +-
 .../devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml       | 2 +-
 .../devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml       | 2 +-
 .../devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml       | 2 +-
 .../devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml       | 2 +-
 .../devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml       | 2 +-
 .../devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml       | 2 +-
 .../devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml       | 2 +-
 .../devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml        | 2 +-
 .../devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml        | 2 +-
 .../devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml        | 2 +-
 .../devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml        | 2 +-
 .../devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml        | 2 +-
 .../bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml         | 2 +-
 .../bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml         | 2 +-
 .../bindings/pinctrl/qcom,sm8650-lpass-lpi-pinctrl.yaml         | 2 +-
 .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml      | 2 +-
 Documentation/devicetree/bindings/serial/qcom,msm-uart.yaml     | 2 +-
 Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml   | 2 +-
 Documentation/devicetree/bindings/slimbus/qcom,slim-ngd.yaml    | 2 +-
 Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.yaml       | 2 +-
 Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml        | 2 +-
 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml      | 2 +-
 Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml       | 2 +-
 Documentation/devicetree/bindings/sound/adi,adau7002.yaml       | 2 +-
 Documentation/devicetree/bindings/sound/maxim,max98090.yaml     | 2 +-
 Documentation/devicetree/bindings/sound/maxim,max98095.yaml     | 2 +-
 Documentation/devicetree/bindings/sound/maxim,max98504.yaml     | 2 +-
 Documentation/devicetree/bindings/sound/qcom,q6adm-routing.yaml | 2 +-
 Documentation/devicetree/bindings/sound/qcom,q6adm.yaml         | 2 +-
 Documentation/devicetree/bindings/sound/qcom,q6afe.yaml         | 2 +-
 .../devicetree/bindings/sound/qcom,q6apm-lpass-dais.yaml        | 2 +-
 Documentation/devicetree/bindings/sound/qcom,q6apm.yaml         | 2 +-
 Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml    | 2 +-
 Documentation/devicetree/bindings/sound/qcom,q6asm.yaml         | 2 +-
 Documentation/devicetree/bindings/sound/qcom,q6core.yaml        | 2 +-
 Documentation/devicetree/bindings/sound/qcom,q6prm.yaml         | 2 +-
 Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml       | 2 +-
 Documentation/devicetree/bindings/sound/wlf,wm8994.yaml         | 2 +-
 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml   | 2 +-
 Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml         | 2 +-
 Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.yaml | 2 +-
 66 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
index 90cd3feab5fa..ab97d4b7dba8 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml
@@ -8,7 +8,7 @@ title: Qualcomm RPM Clock Controller
 
 maintainers:
   - Bjorn Andersson <bjorn.andersson@linaro.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description: |
   The clock enumerators are defined in <dt-bindings/clock/qcom,rpmcc.h> and
diff --git a/Documentation/devicetree/bindings/display/bridge/parade,ps8622.yaml b/Documentation/devicetree/bindings/display/bridge/parade,ps8622.yaml
index e6397ac2048b..235018a81e85 100644
--- a/Documentation/devicetree/bindings/display/bridge/parade,ps8622.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/parade,ps8622.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Parade PS8622/PS8625 DisplayPort to LVDS Converter
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml b/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
index 6d1a36b76fcb..a5fe46de3535 100644
--- a/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Silicon Image SiI8620 HDMI/MHL bridge
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml
index 4151f475f3bc..d55fda9a523e 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm SM8750 Display MDSS
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   SM8650 MSM Mobile Display Subsystem(MDSS), which encapsulates sub-blocks like
diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml
index 758d8f6321e1..06a04db3eda2 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-qup.yaml
@@ -9,7 +9,7 @@ title: Qualcomm Universal Peripheral (QUP) I2C controller
 maintainers:
   - Andy Gross <agross@kernel.org>
   - Bjorn Andersson <bjorn.andersson@linaro.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 allOf:
   - $ref: /schemas/i2c/i2c-controller.yaml#
diff --git a/Documentation/devicetree/bindings/input/cypress,cyapa.yaml b/Documentation/devicetree/bindings/input/cypress,cyapa.yaml
index 29515151abe9..da629d511da1 100644
--- a/Documentation/devicetree/bindings/input/cypress,cyapa.yaml
+++ b/Documentation/devicetree/bindings/input/cypress,cyapa.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Cypress All Points Addressable (APA) I2C Touchpad / Trackpad
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
index c593ae63d0ec..12256ae7df90 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ST-Microelectronics FingerTip touchscreen controller
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   The ST-Microelectronics FingerTip device provides a basic touchscreen
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 256de140c03d..afa4d3539f5c 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Interconnect Bandwidth Monitor
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description: |
   Bandwidth Monitor measures current throughput on buses between various NoC
diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu.yaml
index 6e3d6e6d9e07..61b30a7732ec 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: TI OMAP4 Wake-up Generator
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description: >
   All TI OMAP4/5 (and their derivatives) are interrupt controllers that route
diff --git a/Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml b/Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml
index fa03e73622d4..b409b2a8b5c5 100644
--- a/Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml
+++ b/Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm PM8058 PMIC LED
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description: |
   The Qualcomm PM8058 contains an LED block for up to six LEDs:: three normal
diff --git a/Documentation/devicetree/bindings/media/i2c/samsung,s5k5baf.yaml b/Documentation/devicetree/bindings/media/i2c/samsung,s5k5baf.yaml
index ebd95a8d9b2f..4cb0f5aa1301 100644
--- a/Documentation/devicetree/bindings/media/i2c/samsung,s5k5baf.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/samsung,s5k5baf.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Samsung S5K5BAF UXGA 1/5" 2M CMOS Image Sensor with embedded SoC ISP
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/media/i2c/samsung,s5k6a3.yaml b/Documentation/devicetree/bindings/media/i2c/samsung,s5k6a3.yaml
index e563e35920c4..9df1e0f872f2 100644
--- a/Documentation/devicetree/bindings/media/i2c/samsung,s5k6a3.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/samsung,s5k6a3.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Samsung S5K6A3(YX) raw image sensor
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   S5K6A3(YX) is a raw image sensor with MIPI CSI-2 and CCP2 image data
diff --git a/Documentation/devicetree/bindings/media/qcom,sm8750-iris.yaml b/Documentation/devicetree/bindings/media/qcom,sm8750-iris.yaml
index c9a0fcafe53f..c42d3470bdac 100644
--- a/Documentation/devicetree/bindings/media/qcom,sm8750-iris.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sm8750-iris.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm SM8750 SoC Iris video encoder and decoder
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   The Iris video processing unit on Qualcomm SM8750 SoC is a video encode and
diff --git a/Documentation/devicetree/bindings/media/samsung,exynos4210-csis.yaml b/Documentation/devicetree/bindings/media/samsung,exynos4210-csis.yaml
index dd6cc7ac1f7c..2ddca4167b0b 100644
--- a/Documentation/devicetree/bindings/media/samsung,exynos4210-csis.yaml
+++ b/Documentation/devicetree/bindings/media/samsung,exynos4210-csis.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Samsung S5P/Exynos SoC series MIPI CSI-2 receiver (MIPI CSIS)
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Sylwester Nawrocki <s.nawrocki@samsung.com>
 
 properties:
diff --git a/Documentation/devicetree/bindings/media/samsung,exynos4210-fimc.yaml b/Documentation/devicetree/bindings/media/samsung,exynos4210-fimc.yaml
index 2ba27b230559..17ece4eb300c 100644
--- a/Documentation/devicetree/bindings/media/samsung,exynos4210-fimc.yaml
+++ b/Documentation/devicetree/bindings/media/samsung,exynos4210-fimc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Samsung S5P/Exynos SoC Fully Integrated Mobile Camera
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Sylwester Nawrocki <s.nawrocki@samsung.com>
 
 description:
diff --git a/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml b/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml
index 71d63bb9abb5..9c90cb6a93bd 100644
--- a/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml
+++ b/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-is.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Samsung Exynos4212/4412 SoC Imaging Subsystem (FIMC-IS)
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Sylwester Nawrocki <s.nawrocki@samsung.com>
 
 description:
diff --git a/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-lite.yaml b/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-lite.yaml
index f80eca0a4f41..bda724897293 100644
--- a/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-lite.yaml
+++ b/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-lite.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Samsung Exynos SoC series camera host interface (FIMC-LITE)
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Sylwester Nawrocki <s.nawrocki@samsung.com>
 
 description:
diff --git a/Documentation/devicetree/bindings/media/samsung,fimc.yaml b/Documentation/devicetree/bindings/media/samsung,fimc.yaml
index 2a54379d9509..1bfba84f8854 100644
--- a/Documentation/devicetree/bindings/media/samsung,fimc.yaml
+++ b/Documentation/devicetree/bindings/media/samsung,fimc.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Samsung S5P/Exynos SoC Camera Subsystem (FIMC)
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Sylwester Nawrocki <s.nawrocki@samsung.com>
 
 description: |
diff --git a/Documentation/devicetree/bindings/media/samsung,s5c73m3.yaml b/Documentation/devicetree/bindings/media/samsung,s5c73m3.yaml
index 1b75390fdaac..1af5d7ac382c 100644
--- a/Documentation/devicetree/bindings/media/samsung,s5c73m3.yaml
+++ b/Documentation/devicetree/bindings/media/samsung,s5c73m3.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Samsung S5C73M3 8Mp camera ISP
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Sylwester Nawrocki <s.nawrocki@samsung.com>
 
 description:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml
index 23300606547c..96635b2f6a27 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml
@@ -8,7 +8,7 @@ title: Qualcomm IPQ5018 TLMM pin controller
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm IPQ5018 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml
index e571cd64418f..22685c479983 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml
@@ -8,7 +8,7 @@ title: Qualcomm IPQ5332 TLMM pin controller
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description: |
   Top Level Mode Multiplexer pin controller in Qualcomm IPQ5332 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml
index 6f90dbbdbdcc..40def3ac3bf7 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml
@@ -8,7 +8,7 @@ title: Qualcomm IPQ8074 TLMM pin controller
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm IPQ8074 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
index bca903b5da6d..7afec315b63e 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Technologies, Inc. IPQ9574 TLMM block
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm IPQ9574 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-common.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-common.yaml
index 3b5045730471..619341dd637c 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-common.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-common.yaml
@@ -9,7 +9,7 @@ title: Qualcomm SoC LPASS LPI TLMM Common Properties
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   Common properties for the Top Level Mode Multiplexer pin controllers in the
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml
index 61f5be21f30c..203ad69e99e8 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml
@@ -8,7 +8,7 @@ title: Qualcomm MSM8660 TLMM pin controller
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm MSM8660 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml
index 904af87f9eaf..9bf098cf18ee 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml
@@ -8,7 +8,7 @@ title: Qualcomm MSM8916 TLMM pin controller
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm MSM8916 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml
index 46618740bd31..435f0dc7a82e 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml
@@ -8,7 +8,7 @@ title: Qualcomm MSM8960 TLMM pin controller
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm MSM8960 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml
index 840fdaabde12..a9aff442824c 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml
@@ -8,7 +8,7 @@ title: Qualcomm MSM8974 TLMM pin controller
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm MSM8974 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml
index d4391c194ff7..501329bff905 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml
@@ -8,7 +8,7 @@ title: Qualcomm MSM8976 TLMM pin controller
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm MSM8976 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml
index fa90981db40b..2ec10908d556 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml
@@ -8,7 +8,7 @@ title: Qualcomm MSM8994 TLMM pin controller
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm MSM8994 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml
index c5010c175b23..496f38009c7d 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml
@@ -8,7 +8,7 @@ title: Qualcomm MSM8996 TLMM pin controller
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm MSM8996 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml
index bcaa231adaf7..3b098a226a67 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml
@@ -8,7 +8,7 @@ title: Qualcomm MSM8998 TLMM pin controller
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm MSM8998 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml
index 4009501b3414..9a6408c33574 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml
@@ -8,7 +8,7 @@ title: Qualcomm QCS404 TLMM pin controller
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm QCS404 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
index 5606f2136ad1..ec0bf4fdfa4f 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
@@ -8,7 +8,7 @@ title: Qualcomm SC7180 TLMM pin controller
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm SC7180 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
index a00cb43df144..80627a1ad663 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
@@ -8,7 +8,7 @@ title: Qualcomm SDM630 and SDM660 TLMM pin controller
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm SDM630 and SDM660 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
index 0f331844608c..4fcac2e55b55 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
@@ -8,7 +8,7 @@ title: Qualcomm SDM845 TLMM pin controller
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm SDM845 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
index bdb7ed4be026..c4542e2d7108 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
@@ -8,7 +8,7 @@ title: Qualcomm SM8150 TLMM pin controller
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   Top Level Mode Multiplexer pin controller in Qualcomm SM8150 SoC.
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml
index 9d782f910b31..46aec0713775 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm SM8350 SoC LPASS LPI TLMM
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 description:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml
index bf4a72facae1..89821871c606 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm SM8550 SoC LPASS LPI TLMM
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 description:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-lpass-lpi-pinctrl.yaml
index e90a5274647d..74df912e60ad 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-lpass-lpi-pinctrl.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm SM8650 SoC LPASS LPI TLMM
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 description:
diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 4c5b0629aa3e..df8feee51202 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -8,7 +8,7 @@ title: Qualcomm Technologies, Inc. RPMh Regulators
 
 maintainers:
   - Bjorn Andersson <bjorn.andersson@linaro.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description: |
     rpmh-regulator devices support PMIC regulator management via the Voltage
diff --git a/Documentation/devicetree/bindings/serial/qcom,msm-uart.yaml b/Documentation/devicetree/bindings/serial/qcom,msm-uart.yaml
index ea6abfe2d95e..bc2e48754805 100644
--- a/Documentation/devicetree/bindings/serial/qcom,msm-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/qcom,msm-uart.yaml
@@ -8,7 +8,7 @@ title: Qualcomm MSM SoC Serial UART
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   The MSM serial UART hardware is designed for low-speed use cases where a
diff --git a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml
index e0fa363ad7e2..788ef5c1c446 100644
--- a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml
+++ b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml
@@ -9,7 +9,7 @@ title: Qualcomm MSM Serial UARTDM
 maintainers:
   - Andy Gross <agross@kernel.org>
   - Bjorn Andersson <bjorn.andersson@linaro.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description: |
   The MSM serial UARTDM hardware is designed for high-speed use cases where the
diff --git a/Documentation/devicetree/bindings/slimbus/qcom,slim-ngd.yaml b/Documentation/devicetree/bindings/slimbus/qcom,slim-ngd.yaml
index abf61c15246e..27a92b79c724 100644
--- a/Documentation/devicetree/bindings/slimbus/qcom,slim-ngd.yaml
+++ b/Documentation/devicetree/bindings/slimbus/qcom,slim-ngd.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm SoC SLIMBus Non Generic Device (NGD) Controller
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 description:
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.yaml
index c33704333e49..d9f6d34a61c6 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,gsbi.yaml
@@ -9,7 +9,7 @@ title: Qualcomm General Serial Bus Interface (GSBI)
 maintainers:
   - Andy Gross <agross@kernel.org>
   - Bjorn Andersson <bjorn.andersson@linaro.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   The GSBI controller is modeled as a node with zero or more child nodes, each
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
index d9fabefc8147..b667f4afdb55 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.yaml
@@ -9,7 +9,7 @@ title: Qualcomm Shared Memory Driver
 maintainers:
   - Andy Gross <agross@kernel.org>
   - Bjorn Andersson <bjorn.andersson@linaro.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   The Qualcomm Shared Memory Driver is a FIFO based communication channel for
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
index 1ba1d419e83b..f91276822858 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.yaml
@@ -9,7 +9,7 @@ title: Qualcomm Shared Memory Point 2 Point
 maintainers:
   - Andy Gross <agross@kernel.org>
   - Bjorn Andersson <bjorn.andersson@linaro.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   The Shared Memory Point to Point (SMP2P) protocol facilitates communication
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml
index 4900215f26af..67d4a7cb9eeb 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml
@@ -9,7 +9,7 @@ title: Qualcomm Shared Memory State Machine
 maintainers:
   - Andy Gross <agross@kernel.org>
   - Bjorn Andersson <bjorn.andersson@linaro.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   The Shared Memory State Machine facilitates broadcasting of single bit state
diff --git a/Documentation/devicetree/bindings/sound/adi,adau7002.yaml b/Documentation/devicetree/bindings/sound/adi,adau7002.yaml
index fcca0fde7d86..7858f3f8ec2f 100644
--- a/Documentation/devicetree/bindings/sound/adi,adau7002.yaml
+++ b/Documentation/devicetree/bindings/sound/adi,adau7002.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analog Devices ADAU7002 Stereo PDM-to-I2S/TDM Converter
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 allOf:
   - $ref: dai-common.yaml#
diff --git a/Documentation/devicetree/bindings/sound/maxim,max98090.yaml b/Documentation/devicetree/bindings/sound/maxim,max98090.yaml
index 65e4c516912f..9df1296aacb7 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max98090.yaml
+++ b/Documentation/devicetree/bindings/sound/maxim,max98090.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Maxim Integrated MAX98090/MAX98091 audio codecs
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description: |
   Pins on the device (for linking into audio routes):
diff --git a/Documentation/devicetree/bindings/sound/maxim,max98095.yaml b/Documentation/devicetree/bindings/sound/maxim,max98095.yaml
index 77544a9e1587..76ea4fe711de 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max98095.yaml
+++ b/Documentation/devicetree/bindings/sound/maxim,max98095.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Maxim Integrated MAX98095 audio codec
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 allOf:
   - $ref: dai-common.yaml#
diff --git a/Documentation/devicetree/bindings/sound/maxim,max98504.yaml b/Documentation/devicetree/bindings/sound/maxim,max98504.yaml
index 23f19a9d2c06..6d33bb4a98ae 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max98504.yaml
+++ b/Documentation/devicetree/bindings/sound/maxim,max98504.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Maxim Integrated MAX98504 class D mono speaker amplifier
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   Maxim Integrated MAX98504 speaker amplifier supports I2C control interface
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm-routing.yaml b/Documentation/devicetree/bindings/sound/qcom,q6adm-routing.yaml
index 3f11d2e183e1..26fe8cc66b3c 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6adm-routing.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6adm-routing.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Audio Device Manager (Q6ADM) routing
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 description:
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6adm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6adm.yaml
index fe14a97ea616..3c32c5b0fad8 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6adm.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6adm.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Audio Device Manager (Q6ADM)
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 allOf:
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.yaml b/Documentation/devicetree/bindings/sound/qcom,q6afe.yaml
index 268f7073d797..4624b3d461d5 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6afe.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Audio FrontEnd (Q6AFE)
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 allOf:
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm-lpass-dais.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm-lpass-dais.yaml
index 894e653d37d7..2fb95544db8b 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6apm-lpass-dais.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6apm-lpass-dais.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm DSP LPASS (Low Power Audio SubSystem) Audio Ports
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 allOf:
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
index ef1965aca254..ec06769a2b63 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6apm.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Audio Process Manager (Q6APM)
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 allOf:
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml b/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
index ce811942a9f1..47a105a97ecf 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Audio Stream Manager (Q6ASM)
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 description:
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6asm.yaml
index cb49f9667cca..a6f88ce92299 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6asm.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Audio Stream Manager (Q6ASM)
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 allOf:
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6core.yaml b/Documentation/devicetree/bindings/sound/qcom,q6core.yaml
index e240712de9ca..8642ef9f9142 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6core.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6core.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Audio Core (Q6Core)
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 allOf:
diff --git a/Documentation/devicetree/bindings/sound/qcom,q6prm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6prm.yaml
index f6dbb1267bfe..3eafe189e699 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6prm.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,q6prm.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Proxy Resource Manager (Q6PRM)
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 allOf:
diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
index 83e0360301e1..866c5e780fb0 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm WSA8840/WSA8845/WSA8845H smart speaker amplifier
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 description:
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8994.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8994.yaml
index 8f045de02850..0db04a90ac6b 100644
--- a/Documentation/devicetree/bindings/sound/wlf,wm8994.yaml
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8994.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Wolfson WM1811/WM8994/WM8958 audio codecs
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
   - patches@opensource.cirrus.com
 
 description: |
diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
index d12c5a060ed0..edf399681d7a 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
@@ -9,7 +9,7 @@ title: GENI based Qualcomm Universal Peripheral (QUP) Serial Peripheral Interfac
 maintainers:
   - Andy Gross <agross@kernel.org>
   - Bjorn Andersson <bjorn.andersson@linaro.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   The QUP v3 core is a GENI based AHB slave that provides a common data path
diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
index 88be13268962..7df21b15a0d4 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml
@@ -9,7 +9,7 @@ title: Qualcomm Universal Peripheral (QUP) Serial Peripheral Interface (SPI)
 maintainers:
   - Andy Gross <agross@kernel.org>
   - Bjorn Andersson <bjorn.andersson@linaro.org>
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 description:
   The QUP core is an AHB slave that provides a common data path (an output FIFO
diff --git a/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.yaml
index dc6af204e8af..a519422c371c 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm PM8916 watchdog timer controller
 
 maintainers:
-  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Krzysztof Kozlowski <krzk@kernel.org>
 
 allOf:
   - $ref: watchdog.yaml#
-- 
2.48.1


