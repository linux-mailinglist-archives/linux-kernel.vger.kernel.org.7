Return-Path: <linux-kernel+bounces-805871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E23DB48EA0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C522D7A7877
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DBB30C374;
	Mon,  8 Sep 2025 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHtPC0Bw"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9870F30B51E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336673; cv=none; b=WKOgzPtz+lbelm/bHqMsRPTClD4H5ffP/5EqsQweN9sn2kJUU1MnDsGaA5hLbU6ynE507Q/RBBVmgmV3K8qAq3F0bhoFuL6KDGxxCk12l9LqyAdGjkbqHGLAkwC2Z9RbaioYJkgxQ1XUF1fTiFxC2M2JpEtM6KMGLkQw3U4hcP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336673; c=relaxed/simple;
	bh=HrSq9QX+rRZZn6/cR+hy9Izp3f7Ikd1Wm8zLBwjaDxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/ZE7rl3/znfw9iAAUYYZOHf7phZkNRKv9bDWvijdH3AVF4nOK8xhRlDqcmUEFqwuhrQw9L3I2YY5M2CBMe7gSsi8iv/FzB0wZEQuz3VAmGR1+m7ZLxgtXl8sWpLBlDZcWTBGVMV4LNGFfyCr5yS9w+BSVdqQbgMHRB5pIUGPS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UHtPC0Bw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dec268f2aso503595e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757336670; x=1757941470; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDyuAKF3Y98UqjyyRF0OYRaWszlGNwULvWxPJjSxWt0=;
        b=UHtPC0BwYM7hRxQlKUQrw9P48f+wFx0vSsuVjrWigwQZZHLTjsRcO3cW32ctey9aM+
         nquTvx5mTtoOeG6RkwsWFmmcBhMgIyIeHDN9hU837OGskuLOLIHJpkwPk17fyKRwwXYn
         geNXBBbV2AJKlo0rEYzjRWFj5tmpMTYHZLpaayMFfy/iOZXjMUMvGe7KQRXQn/bjsVvE
         y2yytVtlFSIDDAam+s3uYCHDRdsaTWZws+ebpryycR0Mqb324U8cC/b3t/ALh9fINjSS
         xzjAb3+dtR4EZAfTi+aKmaJ1mCAUomm+In/mtlLqMym8krC2MPNk1o7PhX8CXnqV9lIF
         8DYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757336670; x=1757941470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDyuAKF3Y98UqjyyRF0OYRaWszlGNwULvWxPJjSxWt0=;
        b=cyU5lfCK/u/hV2N4qnRReD5utd5kBKLGNCYnB0QijqwdnKlD4jxzMtmloHiIVvb5XD
         8m3NRh9Eov94h8GxD+YB24CNavvgzL+0HJ+kzOkTfF1MXZfnlrawTotrpkDfuKX5ItuR
         CL1QozbfhPiZk/bQwZ4G8fjCv6aLSicv/X75PGPreQG1WeooJo7igSa+JF7ab/cA66Wl
         nd4glq8vYr0VpV6nUuqD2rLaDiZxtQ3hjSvKH3NiEadLLkbHqX13JfGbt+OXYBGYzOek
         jqMCir3b+ti/3A6ixMnenVsQ2qpu28rGriovKobjovnmFtwRisM1u2tx93JpqMxVZZ9q
         K9WA==
X-Forwarded-Encrypted: i=1; AJvYcCXhw2nLSfi5VIPFZw6PprooWneOWXMYozbIt4VVJ6SJlkHX3sN2OixzuinyajLav4IGuHyatAnQfR4GkiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAYn9a7FywNBOle6g2pOKQCtTU+Q3HgTo7YGQOMv8gEdpUSklc
	CU2DJiQi9DcuLqt9K7rCNUVGuRzsH+oTH2FS2WahteQ3StLwPHM5zNC7NcQOUL8ccTQ=
X-Gm-Gg: ASbGncu/bOKmVIN7vMTF3nKntLOE8MNr7gjN6UQg652c3ZujGp+mUWcnytOdaLsZilf
	gWbBblLFh9mt7naxlEvsTm8Dcne4RYAzk02lLG3CIqIfAgFe7vgA56d+NG8ON0On0JQEhPHswuV
	cQPPx5O6LQ4xuUYBwSsNdUI4mg9aCWn0+Qt0p26WbB0yIFbaleuC4eRgB5cFHZeH9zwWh0kpeh7
	TcZg+rxUSba8850H0tpn7UATE0tAt0Y31uG2pU6HdhxXAootd7zVW/DGEjKcXyvSCYvHv9bxjt6
	CsKdiJFsmprOUlm5XajreBKqwQPRZnQS/HPjKfq63Zi0oaVxtiAsL1K/SGKprN5eAS+dOv8+mmb
	1W3DqxB0JeT8rHVFqkX3+n4W1CGO5obj2pvF2D4ow7TMVY82LyEJobw==
X-Google-Smtp-Source: AGHT+IG0ZjbfMijZhAL81qHoPX21zRJo3pFZjpyCCWzSjGWv7KwJCCXF42mhC1fWc6KxMzh5zfhfmg==
X-Received: by 2002:a05:600c:4f0f:b0:45d:e211:da8f with SMTP id 5b1f17b1804b1-45de936287amr17504015e9.36.1757336669870;
        Mon, 08 Sep 2025 06:04:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd6891d23sm145632475e9.4.2025.09.08.06.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 06:04:29 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 08 Sep 2025 15:04:22 +0200
Subject: [PATCH v3 5/5] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s:
 add HDMI nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-topic-x1e80100-hdmi-v3-5-c53b0f2bc2fb@linaro.org>
References: <20250908-topic-x1e80100-hdmi-v3-0-c53b0f2bc2fb@linaro.org>
In-Reply-To: <20250908-topic-x1e80100-hdmi-v3-0-c53b0f2bc2fb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3297;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=HrSq9QX+rRZZn6/cR+hy9Izp3f7Ikd1Wm8zLBwjaDxk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBovtRXCAk1A5GYFI4lxepbD+HCSVr8CgQQq0D8xcF8
 d7k3yNyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaL7UVwAKCRB33NvayMhJ0ZhND/
 9lclVjyWMFDPeiGeKHHbcI/xMBqTcupaELGi1+5gFDGmiPkp8eH6QbIIJ1DPYYTItWggZzNNuly0KB
 8Ckq16igtfaJ5uoR9hBVOedkbGSKSiAu7Nb3YyPtoOQl54qhHGbHd52ASn+Y8RhSOzlHS2CfIAkMyN
 unEnHLMqqAa0VFgl3ozr3LHnXfxadl6MVzWEyy5anAjGdEkjaXGlYQC57tMrytmh5AYHpFVm6juUTf
 +sDJ72wrulwWLk1A5wGa6Fe8m+afxHNlcIjnXQVTDRiOL/sag4vIgoA/5Smi5p8vne01OwzP28CHsC
 bIa5GHL2z6xNLILOB/Z+NFJAsTa58hU/ZksNn6Sfcer3c8zEyK3NVVWbgiwUyJoTy2MweOJuYSgB7u
 OdgyxMNC5T5VyjdNuMqdAvAAAD+AJyPRTk+fLJA8B8iSkaF/ZPXRCHH0JYi9cRlV8wy43jm2n27ua9
 Vf3xlxoQ2VxvLg5shxJTMBTvTdah6X6iSBeKyoCrXDLEUYOrwxr+t0Vv0M4LkWECuqtdDf7pnVgYDp
 VmDOE/Fp74Ehyw1XsUtSXPyqzm+P2THYGrSrsmM66wpRVVjA9B8CAigmjMLqIvJOaKIPiMW+KAP3bj
 FMItlozn2k37M726g5Gh6rF9TzxG+0mUKCmQynfFpwxgld+0E8Gft0j+J+WA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Thinkpad T14s embeds a transparent 4lanes DP->HDMI transceiver
connected to the third QMP Combo PHY 4 lanes.

Add all the data routing, disable mode switching and specify the
QMP Combo PHY should be in DP-Only mode to route the 4 lanes to
the underlying DP phy.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index 23213b0d9582822e9503e4acf18c62d5c8c7867d..077aa71e79b548cb1f7c76d297a6afae717f7663 100644
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
+					remote-endpoint = <&usb_1_ss2_qmpphy_out_dp>;
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
@@ -1005,6 +1045,14 @@ &mdss_dp1_out {
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
+&mdss_dp2 {
+	status = "okay";
+};
+
+&mdss_dp2_out {
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+};
+
 &mdss_dp3 {
 	/delete-property/ #sound-dai-cells;
 
@@ -1264,6 +1312,12 @@ &tlmm {
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
@@ -1487,6 +1541,34 @@ &usb_1_ss0_qmpphy_out {
 	remote-endpoint = <&retimer_ss0_ss_in>;
 };
 
+&usb_1_ss2_qmpphy {
+	vdda-phy-supply = <&vreg_l2j_1p2>;
+	vdda-pll-supply = <&vreg_l2d_0p9>;
+
+	/delete-property/ mode-switch;
+	/delete-property/ orientation-switch;
+
+	status = "okay";
+
+	ports {
+		port@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/delete-node/ endpoint;
+
+			usb_1_ss2_qmpphy_out_dp: endpoint@0 {
+				reg = <0>;
+
+				data-lanes = <0 1 2 3>;
+				remote-endpoint = <&hdmi_bridge_dp_in>;
+			};
+
+			/* No USB3 lanes connected */
+		};
+	};
+};
+
 &usb_1_ss1_hsphy {
 	vdd-supply = <&vreg_l3j_0p8>;
 	vdda12-supply = <&vreg_l2j_1p2>;

-- 
2.34.1


