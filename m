Return-Path: <linux-kernel+bounces-850182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DA7BD22B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C333B2B51
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056AE2FC013;
	Mon, 13 Oct 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oji2zlUp"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A0C2FB985
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345754; cv=none; b=ZbP8X2q1d2cwqf9xRPjoaUsCQOGZlW6iaYpWPYD0KY8FpD76A6Do5ZmUjStryKqucRTYLVj3EtJcqx15S3Qlq/ZPkMiqi4v2MlKqX4Wt+Wm7IgvRII9OQ4ELGnNza9DR725Gmzi92brJUxq0DCufaB9iwOP4EMeGT9xO/MUyZsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345754; c=relaxed/simple;
	bh=wNTs0h0y/mlTB3wnqH1wfrtLFenOEC7p4UTXqV1uWNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UALKX9nNAzMzjzYwTCYI7cn4tgvEZQrqnGnDjFNzGAzD7agvBweezvFUXgJrBUy8U5s2cdE2d8vhNIvKkMeIG2Eu32at7tL0n191eWYJvTjujV63XbtDdmoKRuddGBr8zknUjLeynHK1SvCUQQNUrNZexOtGtIuqEfkW4K266lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oji2zlUp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so4388328f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760345750; x=1760950550; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fqs1h8Bd8tnY+khxrYUQ40FHMHiv2RkeVoWTqnCne3w=;
        b=Oji2zlUp5RUad48mlshMmLEEEzPw4A8Cwc182nhgyH/6P82VkK0lcGEB6VpjhgG2m5
         g3sBpzsvKimxwmgKX7BOpYAt0O3pKqw39pocbQvVWDQ19S6vPkZFqtpmODE8x0PouBsw
         jqh87F+VUATt6GwwuvUwJ+eL7q2CxVH4m9iG3vJMu/SS/y3O5LWIsv3EsHbS1SbiB+ZZ
         yood4Qrk1HV1K63A8uNzkxje6HslPNdR3HUUZjoUZDC/hEmDS3fmbhet/+XrdNfa1ZI3
         wsx2T2JiCWSDkz6xmo6iW4H3vcFlht4BQPbeGLnlEZKfqc7E2cCcMjIcauf69aFTbLCg
         EeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760345750; x=1760950550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fqs1h8Bd8tnY+khxrYUQ40FHMHiv2RkeVoWTqnCne3w=;
        b=K1SaL5hV+Wi8JL8zcouWPqwO2ZtCFj/QHFxmi5ZhWG4EDqEqP9VkFRee08MWIFCgpP
         rpbdQ0U9Nnv0ELuKF+2kN/zrGn1fDVx0YgFApPYHZNxqGtlRhVZxOGbBJ2Mc9us8VTWG
         gr02LXl3XqoLsPtKUFDC88Ve8aGc0QQZxazJU0xXjU1E5y3b5U/1Yhtg/VhPNe8xmslX
         dy9ehQMJZL/mQnbzPpPhKLh+CdNLT8COZ+SMvMnpQNBoBzx5nqFcZhQG9AMeEUTaxN6x
         gnEEsXJj3WxZLgNe47yahSEmMnQna9xmZ/ocdD//DD37zOc4TD9cJQ7/+a2sQi8uk4Ri
         /s5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVv6fFZ9dce+0OKqeHGUAVcqui1myvxbwWjtGjPxzXpyq7T/06Xc9vLkfwwfKi88MZwTs14lEttUbNJaG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyvXoND3+nQgWRFt9EKc4W1qiAbiD5j79XgFkjz7GK14vNe3O7
	yO1W+fYHrIWojLmt4PBU+V7dR8aD0wW24KZ59PGQODlaaaTnU8QL1j8REKsdZzckzFU=
X-Gm-Gg: ASbGnctuNYyDu55bbkJheY804QNxHRYf8SVPsqbVo+2x1t8j4NdEM8ci/YI4/h7RubU
	nQFV3kp6GRVatgi1JdVJ2T4R+feBBvNLDFEgrc/SoklsEIuv+HBDvZIeclhIcYY8WMcj4JcRS/p
	oyUisbl/Kv7kpEs3QNfbmCGpTNtjH32Mr/Q223gvjuWg5Dw36XfXVYvJMtgbjnIlOy/afnxNM8C
	e4GQBKb7F5NI7DUYE/UtaNSqw/7N1QvD1A3kkY031A60rhRdLVCawywjT1xkKruC00j/KEu9TzC
	vbo4aIbkrvn5SCYjUOFUYQOB/dG7POcMUtfafAcEL33y048HfL8lHx9zf4ZJOeWeigH7Kr6JWSG
	OzmfbnBeZ30FY/VKseF4rk8CvkDW/ZNMts3z2U749mP0u8Tg1gKbZtRQJQbgwepFBScNggBEOkF
	12
X-Google-Smtp-Source: AGHT+IGP5IDXQAmHWOWz6/zckhmsPQrndtPggKZTPs6kb5X7JCxQcZO9bc2Qh688Ni5MHdA3GNrqkw==
X-Received: by 2002:a05:6000:24ca:b0:3ea:15cd:ac3b with SMTP id ffacd0b85a97d-4266e7e15eemr11113987f8f.30.1760345750168;
        Mon, 13 Oct 2025 01:55:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482b99fsm180016185e9.3.2025.10.13.01.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:55:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 13 Oct 2025 10:55:46 +0200
Subject: [PATCH v6 3/3] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s:
 add HDMI nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-topic-x1e80100-hdmi-v6-3-3a9c8f7506d6@linaro.org>
References: <20251013-topic-x1e80100-hdmi-v6-0-3a9c8f7506d6@linaro.org>
In-Reply-To: <20251013-topic-x1e80100-hdmi-v6-0-3a9c8f7506d6@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3047;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=wNTs0h0y/mlTB3wnqH1wfrtLFenOEC7p4UTXqV1uWNo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo7L6Sb8/jIFHNl0mZLen92n4SCFHIDHBjot2TJdk7
 KJMvytmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOy+kgAKCRB33NvayMhJ0Q3zD/
 9L6F7G6cDWgL+5CXPMwystvEJj2Ra0aiMFSJOtPHvXjnwBEQbVkLAdiwlj/0tWMymdThJ1Tzpp28sB
 DzF+hBVkGtYyC6qb4GFiHhPaOWfoaJMRmO8RWKCc6jY2EyDNCj9vvF6uSKh2SaSRFJRLfOPjSzJAhv
 BxQTn6/tHmtEMHoNcLBW3h8lRObtzCSywFXLz9xV+6syQT8QUkHlyKUiWXpsWjkKQEmebj5DtFtfrD
 m+o1bP2lzCYUgbvoQPAACFrqmYGSoF+EFAt+zMFyQsCOqesTpRU/KTn2CvF/byLRRCSyOJXi1VaQrK
 iGhIuxf7eOYu4PlLXCYPpD9EneX66R/PYs/nMC4kRh1eWQSY3XlHEsCYhuctIEs2ZF6wWD77XeuqIP
 o4rTF0m+QHeKOcPo7Z9p09l+yS95Qo4WihBpKmfxt1Asj1H0IBAp/Vgjnl6o8V2B5eaQDNc9ParGaH
 kHAKMEeYlCK5B4cZ4AbYPcp1YDlLA8D99rRW2W4B+hmMQh4JBQHUaCo+pHi28KXnNaQt4PkcMPJht+
 GDPddmetVnMGAcrg3TCFXNmXyvCZsVTwfcofq4pvL+8u+rZVcflG4uDnasY7BiwR16FqSnodBRV7fG
 UnqvllzaWC60JnjeDX7895JxrwIETobwi/q3uPKWBhrCfJFWho85MxKN9EmA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Thinkpad T14s embeds a transparent 4lanes DP->HDMI transceiver
connected to the third QMP Combo PHY 4 lanes.

Add all the data routing, disable mode switching and specify the
QMP Combo PHY should be in DP-Only mode to route the 4 lanes to
the underlying DP phy.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index 654cbce9d6ecb61c8a6e874d16385d66e362e439..7aa7ae66f49a7a179652757fd826e9d11b9b29da 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -62,6 +62,45 @@ switch-lid {
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
@@ -1028,6 +1067,14 @@ &mdss_dp1_out {
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
 
@@ -1317,6 +1364,12 @@ eusb6_reset_n: eusb6-reset-n-state {
 		output-low;
 	};
 
+	hdmi_hpd_default: hdmi-hpd-default-state {
+		pins = "gpio126";
+		function = "usb2_dp";
+		bias-disable;
+	};
+
 	tpad_default: tpad-default-state {
 		pins = "gpio3";
 		function = "gpio";
@@ -1548,6 +1601,34 @@ &usb_1_ss1_qmpphy_out {
 	remote-endpoint = <&retimer_ss1_ss_in>;
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
+				data-lanes = <3 2 1 0>;
+				remote-endpoint = <&hdmi_bridge_dp_in>;
+			};
+
+			/* No USB3 lanes connected */
+		};
+	};
+};
+
 &usb_2 {
 	status = "okay";
 };

-- 
2.34.1


