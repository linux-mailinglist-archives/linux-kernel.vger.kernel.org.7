Return-Path: <linux-kernel+bounces-727598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7270DB01CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D483D5C0888
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B406E2E8DF0;
	Fri, 11 Jul 2025 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wXp66qFu"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DBD2E6D37
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752238699; cv=none; b=njWEKd5yJKGtYHFwmregd3DgQ6oUIKo8DtfZdzJkQVbqXZy6KzB02WtyJJiCvfZV7HqPjVmzly6CmmuWv7HGXbeLKSIXoqg0NBV74dQElOucZ6NSCeNkx4R5q5dPrUbLOoNaZmnLaji0OnRxPZ+dmdLn5tHpXa6Le402r/ZwWCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752238699; c=relaxed/simple;
	bh=OIbZXI7Fqtsr2N1ErAtcz28YXQvukvskASHmIGTxHjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BRQsmdSgxv0BWQeE4zCgkTdhF51jOg+NoiM/dGJ8/XZ7iAAK0neMB0tdpJ+qhmrqDcerTFddrTbNK11MVFBPB5J4wnNU3Mbp0MFi3DoUtAAdeqLVtrU2Q5u0FC2Tcx3mg7kRsmB2NiK6HW9rZrFxg9hy7J5anGU30HD3LJWC9QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wXp66qFu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4530921461aso13568295e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752238696; x=1752843496; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SucpDS7vC9cfAy5LQNwU3pNWXAJDKjkDJcjlvI3KuA=;
        b=wXp66qFu0JL510CjxMxZY9O/WNLiwQGRSB8BPxY+vd3ytmRusqG5iGVxIGwS6SpMzX
         +LH4pSeBhbmyKJoCbva5C7TA/3qHgf2I4erjlVYXYQoLspLowS+lihMSD8a/q4KgTjbh
         q1MCYjCRsVWxzNH+QrtQSVgiIUicNHlhiWUyN4W4vXxVIA4I81Dsk9XzOy54/uq5J+Zn
         ohDEkix+xujgLY1fOdjQpByRT6eahZDr5Fs9/appWlLXRtjQaBxm/MI2/HNN3UBa00TG
         iFxICAS+BIj9g4QuLeitLJptsmG14OgJKZ3N3BL9kj1QBTwJGqaAxmrRRw0eSB9E+Kst
         SWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752238696; x=1752843496;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SucpDS7vC9cfAy5LQNwU3pNWXAJDKjkDJcjlvI3KuA=;
        b=OIYGRC9ertEeKQDXAPJuoAdi3YW3C5y7N7vhReRNEChwcJJlgpDdh/YbQQzqicO2kt
         wbLxLtZ62Dq79pc6QaBWkYZBxz3Xg8aNWPAmX51Q3zMHd5YCj7soaIQVIKijiveGVFTk
         4byGulONonSa6/wljAWeT5g43D4qezW/FpjM7Djqh2mHRGxsf/jnq+un+Ef6V4Fw58s/
         P3yi9tatgWJWLU2ry+ShpOLXLaeIpcyq/RLZK10xy8A78o1Iz4/OxtGQ/85xJXwH12pK
         biX/ySHBMqBnd4b/HiZ4HbjWbAk2LK29Rxf2se/gpsyYZyBqnkRFid0/26oPzGvrD3aD
         7chw==
X-Forwarded-Encrypted: i=1; AJvYcCXjtgXfKLgQbHg1fvs1Zx5GALZreawRaNDuDLf8rlfPG0xbdy9qeGbtoLWE92M36++Yi26GX0ahpYvOnSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQdEAOeZZqt00Chhwlv02dlyiYIrV0cKRB+QHyj4dlb+yChYaX
	poFUn1b6DMLdZ9YJayfpwKpa8k5QuIBPhNk0eWspWWT5c41obfpcepOuXiwvNCuU964=
X-Gm-Gg: ASbGnctrlgKqMoEEjaco/fRT0qOuN8yIMSmqz/7fPAyycp0Dz2Zt/ILhzHhgc8B5LJE
	YJR12YsJeLA/SEBjPYE6dgDObYsYv7LgtT+zEbVy2C4mqBf2x/CfgRuOH0AxZiuUE1tHKKy9R/m
	snSgdjMMpr9ZmsaOl1P1EIHrrigZDDfpKdE5oK1s8kIjDScp3m/VkG5d+HRqyA7kP2pDJiRoCb+
	7m9ZmABl5s2ud/bz8RSFTWUv9OxDroMlP6/jE8IlWMxiWIYQoh8VNDEjNVDpL3N6+mKbyD+SVLh
	8oqrFjWQJ0Sh4W0AMe14tsTSd1S98WPbkweVOnLsYjcbiZw1PcjFbB+nMvCtlO//rF26bsCP7W6
	XensuH/+Coi9nJbosUsdzGSnVFg4UUn45at9wNnzcvWBHtbmNMq0MagkILqGtAb2X
X-Google-Smtp-Source: AGHT+IEIJnot7r7LRs2kSwUSDm+1stPbB9hmDcKHwINPC/bVI0UDi3/vu0xGOR7MGNjXTWyEMDaR3w==
X-Received: by 2002:a05:600c:3d8f:b0:43b:ca39:6c75 with SMTP id 5b1f17b1804b1-45565ed6320mr25875905e9.16.1752238695515;
        Fri, 11 Jul 2025 05:58:15 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1f70sm4373648f8f.27.2025.07.11.05.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 05:58:15 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Fri, 11 Jul 2025 13:58:05 +0100
Subject: [PATCH v7 13/15] arm64: dts: qcom: x1e80100-t14s: Add on ov02c10
 RGB sensor on CSIPHY4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-13-0bc5da82f526@linaro.org>
References: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-0-0bc5da82f526@linaro.org>
In-Reply-To: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-0-0bc5da82f526@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>, 
 Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2678;
 i=bryan.odonoghue@linaro.org; h=from:subject:message-id;
 bh=OIbZXI7Fqtsr2N1ErAtcz28YXQvukvskASHmIGTxHjQ=;
 b=owEBbQKS/ZANAwAIASJxO7Ohjcg6AcsmYgBocQpU1dDFIG1VZpzK3GiFeC6wBxppvGh3XV3IO
 XbnUs2etYuJAjMEAAEIAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCaHEKVAAKCRAicTuzoY3I
 Or65D/4jFFRq2KshTyiflYVc7Ui+U+HW+98zn6d/hWNWxtkl12OQNIkZOhSVtyof0njhsMYBi/r
 E15fwPHQgM2ZMYvCOxPXTAanBoUHRajNevlUNvHrCTB/ExultpXyaN4VkXJWiR4PMi5n3/89cuC
 hazED5SXphSeMhFwgo91ZNjza7KCou3GYetRezVZQC+tiOkUCig38RjAuNVCpOcYXvMnXHR/FCs
 FJHFsenF1EfpsEPkjs4ml+hUzVhO3KLTkxw5xk4QWQi88f6bLvdexME3jebRENlAyBWgwohL360
 qjR5+WnkqpiO5eIhsTqY3qlx5aBz0bkLTONqPMQpVJsUK4FNpzAs8NI3yGcmGljczoLzD60Dd1F
 0lkN+4/2DCRpwwqKUZ+30Dh89Ab5PcFCsPGg3kEgsVoMV8KXDDDgj8YI4wzNAzTm8caR8115ALv
 91OWIu8+rS9U/XEJtPxE3EwMQzquHzRPQa+uBCWAgR+jpqpGzChg+0Y49n4vOq7uKclTxqdJWSZ
 OsHD4E5DBbpJIYCxORyZ2VpuE6c42s7CZNk7e8lDWrrUaMwF4gqQu9WdXqTzAZ+BN0/R1qmyaAk
 HPZnOr4wkM5yiLDR3TwXILUGZTj3PxF2mzJWAM3y7pL+SvAozlV3j+BnwQHMaborfPRSqu+A1ci
 nCi3Kn1jiH40zbA==
X-Developer-Key: i=bryan.odonoghue@linaro.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

Switch on the ov02c10 RGB sensor on CSIPHY4.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index c9215c1a37cf4e7bad1512f52afdfc18ea616127..2930921b624f03e72da1fc22506391e6764e1ef9 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
@@ -884,6 +885,68 @@ vreg_l7m_2p8: ldo7 {
 
 };
 
+&camss {
+	status = "okay";
+
+	ports {
+		/*
+		 * port0 => csiphy0
+		 * port1 => csiphy1
+		 * port2 => csiphy2
+		 * port3 => csiphy4
+		 */
+		port@3 {
+			csiphy4_ep: endpoint@4 {
+				reg = <4>;
+				clock-lanes = <7>;
+				data-lanes = <0 1>;
+				remote-endpoint = <&ov02c10_ep>;
+			};
+		};
+	};
+};
+
+&cci1 {
+	status = "okay";
+};
+
+&cci1_i2c1 {
+	camera@36 {
+		compatible = "ovti,ov02c10";
+		reg = <0x36>;
+
+		reset-gpios = <&tlmm 237 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cam_rgb_default>;
+
+		clocks = <&camcc CAM_CC_MCLK4_CLK>;
+		assigned-clocks = <&camcc CAM_CC_MCLK4_CLK>;
+		assigned-clock-rates = <19200000>;
+
+		orientation = <0>; /* front facing */
+
+		avdd-supply = <&vreg_l7m_2p8>;
+		dvdd-supply = <&vreg_l2m_1p2>;
+		dovdd-supply = <&vreg_l4m_1p8>;
+
+		port {
+			ov02c10_ep: endpoint {
+				data-lanes = <1 2>;
+				link-frequencies = /bits/ 64 <400000000>;
+				remote-endpoint = <&csiphy4_ep>;
+			};
+		};
+	};
+};
+
+&csiphy4 {
+	vdda-0p8-supply = <&vreg_l2c_0p8>;
+	vdda-1p2-supply = <&vreg_l1c_1p2>;
+	phy-type = <PHY_TYPE_DPHY>;
+
+	status = "okay";
+};
+
 &gpu {
 	status = "okay";
 
@@ -1448,6 +1511,22 @@ &tlmm {
 			       <72 2>, /* Secure EC I2C connection (?) */
 			       <238 1>; /* UFS Reset */
 
+	cam_rgb_default: cam-rgb-default-state {
+		mclk-pins {
+			pins = "gpio100";
+			function = "cam_aon";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		reset-n-pins {
+			pins = "gpio237";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
 	eusb3_reset_n: eusb3-reset-n-state {
 		pins = "gpio6";
 		function = "gpio";

-- 
2.49.0


