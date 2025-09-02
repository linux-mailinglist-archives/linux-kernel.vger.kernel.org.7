Return-Path: <linux-kernel+bounces-795920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F8AB3F970
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862AE482726
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AA02EAB96;
	Tue,  2 Sep 2025 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mO0Us49U"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E8C2EA481
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803642; cv=none; b=MgDN+Xnl7WazH3JctxAT9DNRQDI6LiByo7WaIax0sudhq77xI9Tn8j3BwV2QKWL3mtedsk+BrZCEfGiVYJ5nyjnGKI0fMhM9XG90JtKu8DHgEkMXOgdQupGnTFY++ZDhZNxH8FNdbuM+GV+19S7PlogChQvJp1YmWcI3EBL/n+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803642; c=relaxed/simple;
	bh=9hYVY7VJpLHKc+fjiw16Zkq8W4WOmrto8l6+8H9lR/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=stBXGIlq1qKewWLyN6a5SvVwWNrCNAIPsGHUxw+hj78YXOER1+YmYVEoPOr5KmIZkeTen23jnSdufCQKZtdUqbU996RbYg5/Se1Ox3EppB1/RlgrwYPa7dvwkoDglLLmJi7f66dyboKLzd7FKNIofqVQVINvLxtR76K2il1AjCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mO0Us49U; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b7d485173so31916295e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756803638; x=1757408438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zx3flAD2tM7boXAz2/Brkk0fygpQR/lnc3aW0wO9axk=;
        b=mO0Us49UG7WM2d5qDu8kwiNUYyyEp5fuqmehOQQJlWpVqbqNH3BTWmpb1REDbPoxwA
         xjuLzly4W78CGx0DfxP0Dedyb2vwfAQXJGFExzkENIXuhRaazepdD1Fv1HevIVTLqHOX
         u3VtlxqkuA20qt+bWYgRkbIS3zbtK7BvtYEhXggVrYNdpyPYnZ47afv9w98hLMViKSKE
         mXqJbriZ8rH+XpLIoMpZ/6a1aiIJwuYmZvKSYgrWaWQDGyJjHxDfRqMXolEEIWGyvzyB
         sri3jBnZ5ty3LV0Wj5FuPvo91Xpb9iwE+N8ExtFdRc2UEni4Q3pITLv3hRugzZUCYGxm
         rY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756803638; x=1757408438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zx3flAD2tM7boXAz2/Brkk0fygpQR/lnc3aW0wO9axk=;
        b=hVlIWAN0nsL4fM5z1MZaoC6MgcUAJ8983bgGQZoHk89Ao5l0KcFLqL1ZuNpylHqSoH
         7uKzSeIO/L/STRH/JulHRUqt4fYdlpVsTyx+qoMjVeALJNxP+07FXBshr0g2xplC0rSB
         /xJL9LipTErbpJaDe3TnS/BPCeldZqz0LYt73/tokh5eTENbiCPbuupM4KMgtObB8jds
         Sg6yubf+brcshOYT0wXV1ZgyhC/tlSg89sBx3TPbBaKc7qwR4Td/GLYxq6x7g2QlL/HW
         Zq+mXjtn6Ut9XW/wGjnfnqcZHt+V2s7EL88bSFRc400hZyCr9SIoOOsP1ghzOlCD6gZn
         WV5A==
X-Forwarded-Encrypted: i=1; AJvYcCVvm2Ap1QcTYPop/JBesqvzqWyhvcpc0hgSJBX+Tc1NWo3nzMgyCsQpqycSlj6KxHBkUo8O/gUtaO6VO8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRTqibLkn2YjiaWySX6whmSj6Kl/b0lXqrst5y24QgPYpFjhTE
	eJlJhiF36C8+kKgdlgrlmOfBFrNjecQa3FhRL0PPR1jYLLj6lezxAhz3QzAqa+nlUa0=
X-Gm-Gg: ASbGncuqHQCWF7qKyZLTzQDp9dq5YEXDbyndr86Dt/ZS98X7MUQS3WqK/sMh85J6+k1
	0Kmw4z32ZWjon2pfpXiEhTT1ajbZfrUrtMbBJ3v25d/+bBmU7gjQtMHKAR+kViZWn03Je+jbz0a
	ZnH+qHxj9rsRWWZSgWLT7rWYIEO8z65XQHrqN2/nryuoUg6ykH+C9CtkwM5H/KZtEAgxUia9SW3
	WzRP1yS7j61oJjY3ee/kpcKoIHmq/fsWTZoABuEWb0a20fHBT0x9cSO+PE24KA4xfnCQ95Pc6/Y
	wPNo5xTacFD4YwttJ3VkZo5czxwEFL3Y9Hk8rot/4bIuqqo17o3101+1vIVukhMyNFlDF08cPH1
	Ms1eJpliUNhe6vKCVcgraMjUkMO6HHsfFZq9i6lSIQamRt4/MxR7ccw==
X-Google-Smtp-Source: AGHT+IGij0ie2Kz1Bgob+LBfjmeb9ZeUV3Yq9N4Ha8C0Mceh6P8zBrbcRv8Ri3pPkr9v5oW9bYbvYA==
X-Received: by 2002:a05:600c:1f84:b0:45b:7ce0:fb8a with SMTP id 5b1f17b1804b1-45b8559bd2fmr85788675e9.35.1756803638238;
        Tue, 02 Sep 2025 02:00:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7271cd01sm261112045e9.23.2025.09.02.02.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:00:37 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 02 Sep 2025 11:00:32 +0200
Subject: [PATCH v2 5/5] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s:
 add HDMI nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-topic-x1e80100-hdmi-v2-5-f4ccf0ef79ab@linaro.org>
References: <20250902-topic-x1e80100-hdmi-v2-0-f4ccf0ef79ab@linaro.org>
In-Reply-To: <20250902-topic-x1e80100-hdmi-v2-0-f4ccf0ef79ab@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3093;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9hYVY7VJpLHKc+fjiw16Zkq8W4WOmrto8l6+8H9lR/0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBotrIwu0sNoblRGMg/0v5iPuw5a57X5zTkoD58YXhD
 q564EnGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaLayMAAKCRB33NvayMhJ0XORD/
 9YQAu9Ntnbhk0gv94yL4gdqIpoyK9YjqPgH7Y+GJklbEO52Lll1leq/BaEKzlZDHqFiyyQourvx5JF
 nkOXgQTvLJdVdrVSuDv3RihURsY3n5Fnk4vU14gOEf9ApYAM2SHSKOjmtleeGq3jVcEIGunbg8ERAS
 ntOpRLIcNv2nSbFwuH8/ArwkrKFiDD2TOvCZQPKS5AuZFihTs4SWH+X6qTyaze7kAcCcKD7g5wFINp
 Yq06J9ieaJB8GbPDUGqXmhr6GUlviK55y7AuwCEt7T+FwtmPNu4jvqeCU9f00S0LyzeZljHh/Icob6
 CkfSTeaDYjdvNsTzHwYQOulsE+zTjEZKCobCuGG7fyk1W4vTx2hRiFIgirktwJ+B5UQ28x6IibUUh/
 Cy7dBhLpt0M3OQTQx4JBGxcCDy7ONh3aTGA2Sr9cHkbParyVoo50GhNqhG3mm9TYI2wrIiJy4ZkNyS
 E3EFhTw6YGf3qtxoBAy5VBgq/Rql1ep80JvWVUmtGqEqZ99Oc2MX2uub64Zzd1xOp38LHMgc5u1laB
 XpunOut8RFkj9AkbZC/bOdgnvGQ0G5FwoWsjTpKCCipb01c2jhHCe3eDnFz4mK3rF5jPh1awFYr0L8
 K6wWOLuuo61Cja1Toh2xw2fXMXh+s4mvhjZ2WymEILU2KBhsEzcpeVjOjJjA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Thinkpad T14s embeds a transparent 4lanes DP->HDMI transceiver
connected to the third QMP Combo PHY 4 lanes.

Add all the data routing, disable mode switching and specify the
QMP Combo PHY should be in DP-Only mode to route the 4 lanes to
the underlying DP phy.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index 4cf61c2a34e31233b1adc93332bcabef22de3f86..1ff183844a48d67888a0f4cf8342575ce7f7af47 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
@@ -62,6 +63,45 @@ switch-lid {
 		};
 	};
 
+	hdmi-bridge {
+		compatible = "realtek,rtd2171";
+
+		pinctrl-0 = <&hdmi_hpd_default>;
+		pinctrl-names = "default";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				hdmi_bridge_dp_in: endpoint {
+					remote-endpoint = <&usb_1_ss2_qmpphy_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				hdmi_bridge_tmds_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&hdmi_bridge_tmds_out>;
+			};
+		};
+	};
+
 	pmic-glink {
 		compatible = "qcom,x1e80100-pmic-glink",
 			     "qcom,sm8550-pmic-glink",
@@ -1007,6 +1047,14 @@ &mdss_dp1_out {
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
+&mdss_dp2 {
+	status = "okay";
+};
+
+&mdss_dp2_out {
+	data-lanes = <0 1 2 3>;
+};
+
 &mdss_dp3 {
 	/delete-property/ #sound-dai-cells;
 
@@ -1263,6 +1311,12 @@ &tlmm {
 			       <72 2>, /* Secure EC I2C connection (?) */
 			       <238 1>; /* UFS Reset */
 
+	hdmi_hpd_default: hdmi-hpd-default-state {
+		pins = "gpio126";
+		function = "usb2_dp";
+		bias-disable;
+	};
+
 	eusb3_reset_n: eusb3-reset-n-state {
 		pins = "gpio6";
 		function = "gpio";
@@ -1486,6 +1540,22 @@ &usb_1_ss0_qmpphy_out {
 	remote-endpoint = <&retimer_ss0_ss_in>;
 };
 
+&usb_1_ss2_qmpphy {
+	vdda-phy-supply = <&vreg_l2j_1p2>;
+	vdda-pll-supply = <&vreg_l2d_0p9>;
+
+	qcom,static-lanes-mapping = <PHY_TYPE_DP PHY_TYPE_DP PHY_TYPE_DP PHY_TYPE_DP>;
+
+	/delete-property/ mode-switch;
+	/delete-property/ orientation-switch;
+
+	status = "okay";
+};
+
+&usb_1_ss2_qmpphy_out {
+	remote-endpoint = <&hdmi_bridge_dp_in>;
+};
+
 &usb_1_ss1_hsphy {
 	vdd-supply = <&vreg_l3j_0p8>;
 	vdda12-supply = <&vreg_l2j_1p2>;

-- 
2.34.1


