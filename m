Return-Path: <linux-kernel+bounces-897513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272D9C53168
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5307621E8D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B041E3431F5;
	Wed, 12 Nov 2025 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xOQzuV7X"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068F3351FBA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959780; cv=none; b=jf6/3P0JqE8Fb8MFhwteIl4TRfsMTh8Hsl597IJZ7RXDqRlrPGBsscuZlNNAT1ysSCjAoF71e2pwB78peLQJ1oruR2ok3PgdVeuGMYRagJhqS4XM5EY1W7SRTHHZFCjWvGtM5YPJ9UPh2h776e/0TmUDG1tul2lAClSjh2jn5hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959780; c=relaxed/simple;
	bh=9wI3XI3vhU2/1t7DVfjRwTFblg1SWjTrVbr5Qsqq9gE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D3EEEncofQIhr+Ml3zV/SDYilvd/Yke/vpWcLm3c/Ka1/cr3uSPNQemAjrBHdYjkTbA72jIBPoZGhHSMVYS0FMlAm7qkcLWWqBs0U4CjoR/bZ5hn7JhzQH4ECfX7xmnQ3o0+iJRq9FuTvQzLU6vdcenLxhTZZKIgYcaE2vCfBPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xOQzuV7X; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b2de74838so101444f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762959776; x=1763564576; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l7GbuBQ988JH0ZhSiVFagMg/s2WGUhsawfzvur8N2Co=;
        b=xOQzuV7XmO6FeyuHeCW5WP7NGRr38Uq2rTVBRDuCSkX/aVSnoxj6u9YPLI8OLObc5/
         QefGJJSXynyyoDyYNzKVVEsB7X4NxA+4Ay/l+zBFVQuhJa6FuFW4ENvOUwCvpvp3q3y4
         nBr5zQxGyK3Xew90ZULie0kPWQlTBuxWU9xBwgoMOHcGdyV00LUTa/RppbLYm5WHqEJf
         uWMZN+LIHMmk/NvMDEpGizWewFYovqXT5rGGITTY+obUu1l9Sz1Y1A/NsDu/yel10y1N
         F2rbx6xAunrqWsvoI5ywpRKqlNshkEvmmbe7nbDLGICbJC4sfOLMseMO2nS//SIZyB4c
         DVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959776; x=1763564576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l7GbuBQ988JH0ZhSiVFagMg/s2WGUhsawfzvur8N2Co=;
        b=o23GZiLKT4xYceeeO1A/A1nmDn8NBTeACn0AsBuLyP1xJMRB7Z23g06cJoKtH8qLPS
         wDWrhgCKq7vu1l3OdLCjVVcd6OvqewJ2EO3UbQslpkXxPFZIMKY4tmhRPtw2RLsVVEos
         qAjplitE8xQt0MT/usPqow0wXPVdt+CoRKE81OCQSD9q7pQjcKrYuz8PFtdVSgjNj6ku
         K+Mgs/fgoqwCUKKrRHrxyiBhFfVslAI2xvKltRyBbb+qbt9dVb0zmTvE0YkhfWcitIcf
         YGd7j2qQcOoOIYjAKoPvkxST+PNleMC74+WeJEkqiEzRytIX/p5xXxdFDuQQ+D1HFIGb
         WMdg==
X-Forwarded-Encrypted: i=1; AJvYcCW3ObFI7IW4h+nkAPm6546tzPVf9dHxt/zaVvacSyVH8fC1Hpf5x73WEjGvLwPYHkj/+C/Me3K+hmkQdOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMyIAY9Wlz2d73auOujg+mDFGXkgl/yqRIGdKOnuiQIXZpXQF6
	4vJHIQmXoMs6Zs6s6xDyYcijdi5h/uvh7oyfQCYiiZIntwomngwGmGLbVV2AwFk4S4w=
X-Gm-Gg: ASbGncudfSYJ0B+fPC+1Jl8yy67XWHqzHl599UswxAIVU2822YPkcpnUZyJUdN9zvld
	ZWLDMZKbt4FpnFKiSC+E0GzZyg8DqZgBBb2l5Yy9/diYFyXnBIGs3z/l7KQMvKEs59joAjIaEmb
	S0/iekmYokEJyBKcH52a9Q0/5n/tZoN3OUUgL8BXr9hi+ZooSmLU8bIw3KMJ9wYRh0V1RGJUzjJ
	hRT4f1Le6HO8HN6e+I802gHEGU/XXvmc6psvflrKFV8R4sxlWi6yt9kI57n7Lk/3klDN2K3qjTC
	s4sQm+rStsop4Ha8iq7Gb3Z/aqyXx6I2VdJxc3k3lsCa0v/5UAZopaozNriKND3ZSWHJJSSFrgr
	cBdTa2mp7AWL0KW4WAE4LZ2pBOmozLPEWcvMOfZ/jTL21XfBJjblJJWRSI/AQy/PS+3IwKgZTJz
	sPKdLoRKdd8XkvEDW0XIo1wDgYmJU=
X-Google-Smtp-Source: AGHT+IF4vqpVhka8/jFdEYgRGP+JAXApvr6mWEmwiz38pK4RlMObIbzFbJ1c92mmewKPgGRpo/JYjw==
X-Received: by 2002:a05:600c:1f95:b0:46f:da97:91cc with SMTP id 5b1f17b1804b1-477870b6229mr17052135e9.6.1762959776126;
        Wed, 12 Nov 2025 07:02:56 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477889be9a1sm15134355e9.6.2025.11.12.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:02:55 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Nov 2025 16:02:39 +0100
Subject: [PATCH v2 2/4] arm64: dts: qcom: sm8750-mtp: Enable display
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-sm8750-display-dts-v2-2-d1567c583821@linaro.org>
References: <20251112-sm8750-display-dts-v2-0-d1567c583821@linaro.org>
In-Reply-To: <20251112-sm8750-display-dts-v2-0-d1567c583821@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jessica Zhang <jesszhan@quicinc.com>, 
 Abhinav Kumar <abhinavk@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2169;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=9wI3XI3vhU2/1t7DVfjRwTFblg1SWjTrVbr5Qsqq9gE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpFKGX8hk+ml9OdnfHvyxw3a/Bo+Vncy5kjOznV
 Pn1h1F0yRaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaRShlwAKCRDBN2bmhouD
 16e1D/43pXkQ9jlQQMaJ84xSuA3DVggOqUQg9O9sQp4lEeQF7ThhnpFrbU4jhd/+68VpEtHPfk7
 vrnoYEk/6UXQYG6Nz76PTUzoZ7meD36MIhT7F4SJ0e7ufw0+/SZkczrfUrXpfITn5GM8mDKEYX8
 /i6duT5z674K/bIv/oRQrcL5uibE8g1nwl6i5TmL3hUqWsKFucuOdmbZaUVMCVqto8qOet0sWTg
 EdAUjRPq8wkXPOnudjo8ZstqOc+qvhrGCQmnVa0bAckxwbNlLv33c59sL9FcicO5RWP6XfU2Byw
 m5YSkkcvZ0J6AIXktjWVUUxlDmLSu4BU9V4Q9NBW2NN3H0Y4h3VC42IkEQP/gCZ3+TLdD8O0rbB
 bOTTzjLyx4Vr26cBKxkGMMbQBJysYDgw8ygsOK60H5kGY7LQjSCavxejpSwF18TWOX9W+Eczt8x
 80gJczFuN6CgaY4VwDnnSI/Xjxvy9MVStca7B0+pkPCfJheqhqGZmz+ce3pilH3j4Pcz1eh6u1z
 FImDE3dhdcCc4ZIDrOKpEDnUXEuCuTphV2wxSa13Wf3Y8bcMwzor0cjCa9zoQzbA91c1ZGcEfDE
 z/Foj2ezIAijH+EvifUlHDJnVCGutcdVIqYreQp7uM3adFtWghHnZWKpRbFrwOAoE2ASFKyxvEI
 gkp52+m1WSsomTA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Enable display on MTP8750 board with Novatek NT37801 panel.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 70 +++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index c8cb521b4c26..68644eccdbff 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -933,6 +933,48 @@ &lpass_vamacro {
 	qcom,dmic-sample-rate = <4800000>;
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l3g_1p2>;
+
+	status = "okay";
+
+	panel@0 {
+		compatible = "novatek,nt37801";
+		reg = <0>;
+
+		reset-gpios = <&tlmm 98 GPIO_ACTIVE_LOW>;
+
+		vddio-supply = <&vreg_l12b_1p8>;
+		vci-supply = <&vreg_l13b_3p0>;
+		vdd-supply = <&vreg_l11b_1p0>;
+
+		pinctrl-0 = <&disp0_reset_n_active>, <&mdp_vsync_active>;
+		pinctrl-1 = <&disp0_reset_n_suspend>, <&mdp_vsync_suspend>;
+		pinctrl-names = "default", "sleep";
+
+		port {
+			panel0_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&panel0_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l3i_0p88>;
+
+	status = "okay";
+};
+
 &pm8550_flash {
 	status = "okay";
 
@@ -1194,6 +1236,34 @@ sw-ctrl-pins {
 		};
 	};
 
+	disp0_reset_n_active: disp0-reset-n-active-state {
+		pins = "gpio98";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	disp0_reset_n_suspend: disp0-reset-n-suspend-state {
+		pins = "gpio98";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	mdp_vsync_active: mdp-vsync-active-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	mdp_vsync_suspend: mdp-vsync-suspend-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
 	wcd_default: wcd-reset-n-active-state {
 		pins = "gpio101";
 		function = "gpio";

-- 
2.48.1


