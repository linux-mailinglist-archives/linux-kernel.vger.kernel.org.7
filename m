Return-Path: <linux-kernel+bounces-897514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13C4C52F83
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4963E4A7337
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBCC3431E9;
	Wed, 12 Nov 2025 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gJwMYQgU"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68B7350A1C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959781; cv=none; b=r5yyl/xsfCwzyADS1EclV1c8IYEiHzmf0PjZ0Uq0fcNRZMGSVBp/p1QUlvkwYlsey5eDOjZNSBUlTemZZViHMWXrQgDcQpRAOaPb1o78RypgDRkUpbB0T0tiMOy8d7Pr3zmuxLTUp1WonP7zYlPAF2IiRBpk3EWwIiJAcL6x1PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959781; c=relaxed/simple;
	bh=QmSZ67gohs9dy9URdzH5vKIVw+fWFIaVv3vA9Shb4vI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z46vpIfRyDpz0HZbqW3RV61aSdfYZlJ10BOV1My2c3HSHME9f+36tHBEHrMS5+pb/HEvO707lZqVFhLCDczASnJM1muMriST4IVS/tc3d4cwgCnAHW9AadwdplTAOCSzoe58f4+oIsna1bG/Cz1rY4mFd8fmRPr9soFCUposo8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gJwMYQgU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47116aaf345so482495e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762959778; x=1763564578; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qvSXbHAFBzrDH8x6lcIVIDQmAV1fCz/Vk0nXJAQPy7c=;
        b=gJwMYQgUCHnPiKG+FNOUNayfiBvRmWB01aTSIIjqQVCPYuptQcOT1y+JTRhJgGF8Q+
         AnNamZeWSeIIfWbCUOyhqk89ag5vWrsLpJrFxPcCDFmqn160NdpJfrdRcnCMv+j01P6A
         05oZ9Sxfyi4MXAJih4GQm0RLisYuN+E7zG52ulRjD9IjRoBVY8JTE6CdBj3ixWpHVGOX
         ZsQU7BgN+65HRms3SZhKEvIvUKDhNcMuppMcMnxPHZqcxNAEf1YGLz+WkHJa4or4xWH6
         JNcY0V9jYzqDv5s44eX8RIjCfqqF9OrVMXlF6i0aqDa5TqYSEnqKJ8EEW5UG7igAzmSm
         C+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959778; x=1763564578;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qvSXbHAFBzrDH8x6lcIVIDQmAV1fCz/Vk0nXJAQPy7c=;
        b=oXFlLzaNv1FzbsnBNbJ7sgH2AtabEW2OvcOg7YWRVYHiYV5mifneNN8C0NTYaL1l/1
         7pBmDTU6gAuvcPXNcNLJLXr8ZmDnVBybXkf30uRJLWMG1rJtgtosl4Pq8lRPffaiweMM
         BPBspWz5KEMdNXPmcVOFNeJQg5kuRuzY6ITZbTLmIrNXNmBhWoJqPp/lCEKqkN2WlOAq
         AH6MtKgeMl6+0kHxyUs4GtkTEvJttOXrPoamPSumesCmhAmLn8bIz7niyOVGQHGFX0rB
         lYNHxUozD5AJTdJaNswtyV2EofgWs5LZDyWg7/OeYtPoG9nbbotTvXyAXoHinAID6qlE
         h23g==
X-Forwarded-Encrypted: i=1; AJvYcCWOarW1gpMTOA5+ZNT42SM0FqxsTRV1u4AZr/Fs2OnWUJnnG+rEmKkNdHr0CMNYBKCIZBDpWvh5X0bTTas=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhF6/KjyjioFaaUk6OslKjOH8eaU7WPn/rb6kZyc9N94lrCnN9
	10+cBwqAf84uAObffyBPOFX6piOEAM2MOPNs+uV0esMAzfh7tUUCECQ0tBP8ncPr8RI=
X-Gm-Gg: ASbGncsSbWB1XCKvvXhOKU0wMvbEk7MwNA28bgt/tj3aZ5Ih6NRaBuPOMjvKL/CDdff
	xYDGX4KHqMB6iZ0lgtFWVUrjG3TCZstiipHGCve/RLAg2uuTHZyyS0pX9xG5zN5p087/3LERV4W
	bNpJZIaeN5hk7VK9a+JVZ0i9R890yFyJCtfsFyZVHT7v+ifIrjOKEfgg1S7XM+0vcwCQ90+TPkh
	p1u25qkW+C/QD2ZHl5m6u8uppjqhaLmB8moGqhVbfkwWFxDDe83dSov1bfR9FAZLbVCu0DTbvrf
	i+fSTD5Xc+o7V+uJJgxbymjy+zkWguqtESIWGSqCdEHTuicHJjJqcGqsbAEVKk2S64TLK6D80po
	c/PnSKS2TVZn+A7cEn1RbstRUysgHn0uQBP2p3NXBP2+dmeC6ZLNpOBKXvHwq92hW1m03VSRzxm
	0vRb6xHLvyeWYoc+k8
X-Google-Smtp-Source: AGHT+IEb/+fjcpvQukTe0NSzMGRrw5Fhs7mkN94HJyvazvOekkZoPSiuq6KE1CN1ernVA58vDF3t8w==
X-Received: by 2002:a05:600c:450f:b0:477:bb0:5e13 with SMTP id 5b1f17b1804b1-477871f04damr15353575e9.8.1762959777600;
        Wed, 12 Nov 2025 07:02:57 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477889be9a1sm15134355e9.6.2025.11.12.07.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:02:57 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Nov 2025 16:02:40 +0100
Subject: [PATCH v2 3/4] arm64: dts: qcom: sm8750-mtp: Enable USB headset
 and Type-C altmode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-sm8750-display-dts-v2-3-d1567c583821@linaro.org>
References: <20251112-sm8750-display-dts-v2-0-d1567c583821@linaro.org>
In-Reply-To: <20251112-sm8750-display-dts-v2-0-d1567c583821@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jessica Zhang <jesszhan@quicinc.com>, 
 Abhinav Kumar <abhinavk@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2145;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=QmSZ67gohs9dy9URdzH5vKIVw+fWFIaVv3vA9Shb4vI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpFKGY3ELSMgVxLcHlaVvHvwDxtWbc14UQzWBA3
 Jg2d/6kwEOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaRShmAAKCRDBN2bmhouD
 1xNrD/wK++C4SiqGZOFp00OlrOCfTm/1WcePtPwD7GSvTRRSL9YndMklXZs1LO4bGZeDDmiYvYI
 cOqPgPGruzyFU8yI7nzzqqRIgigh3wpWcQuNGxEPdwGVdXH0ctjbpwu5/oTxZhh8nkjNB8o23id
 4p2X3At/nVMRftIwYgcg5Ej8W29TTcSk8GbdF/sdtonGNkQ3ru7FqbfdD16mHo/g2cJgbjmgZJV
 gM0lb+FNuU33Kqr54Oi2LKGyH0LloEWtEQYg7SsKdPIQ18Ey7iGubKTIGtC6WgoWF/drkf9J7b3
 8zAxlI0T6u5+QJz2C3XHpowS9lhHyjwt8K/MiSzyziJduo0Vk/qaSl6KI2WdHwfadaj/zIMLpcd
 k7cQ4wI+6RaLzA1JJi5szK/1ndFxKPD7mvIz4vpwcF84tKg1oovssimxD0e0VrnGRdNXzwkJiJW
 pioQyJ/koZtYnFbn6OpISnEder1vA+e11baGJCZcnVTDIwvjlnUQvMjYAqhDLhuAWA+1r3T9j7Y
 pNzGbypIEDBzGgxqBJ+e0YclypsT/fPVKVaJ5eVJCWu6EE9BkGXLdFOhKF+bwOMgxR7k0pzJ71V
 IY7wVer65eFCxzP1X+M8O6BFUqDnKwnnCc3v/MjLW6fiEkKn/ljOpReY4w2V9L12nsrhg42pP9T
 sleSzfJvRC8Qn6Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

MTP8750 does not have audio jack connected and relies on USB mux
(WCD9395).  Add necessary nodes for proper audio headset support along
with USB Type-C altmode and orientation.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 51 +++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 68644eccdbff..a08bedd2987e 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -54,6 +54,15 @@ wcd939x: audio-codec {
 		vdd-px-supply = <&vreg_l2i_1p2>;
 
 		#sound-dai-cells = <1>;
+
+		mode-switch;
+		orientation-switch;
+
+		port {
+			wcd_codec_headset_in: endpoint {
+				remote-endpoint = <&wcd_usbss_headset_out>;
+			};
+		};
 	};
 
 	chosen {
@@ -230,6 +239,7 @@ port@2 {
 					reg = <2>;
 
 					pmic_glink_sbu: endpoint {
+						remote-endpoint = <&wcd_usbss_sbu_mux>;
 					};
 				};
 			};
@@ -925,6 +935,42 @@ vreg_l7n_3p3: ldo7 {
 	};
 };
 
+&i2c3 {
+	status = "okay";
+
+	wcd_usbss: typec-mux@e {
+		compatible = "qcom,wcd9395-usbss", "qcom,wcd9390-usbss";
+		reg = <0xe>;
+
+		vdd-supply = <&vreg_l15b_1p8>;
+		reset-gpios = <&tlmm 152 GPIO_ACTIVE_HIGH>;
+
+		mode-switch;
+		orientation-switch;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				wcd_usbss_sbu_mux: endpoint {
+					remote-endpoint = <&pmic_glink_sbu>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				wcd_usbss_headset_out: endpoint {
+					remote-endpoint = <&wcd_codec_headset_in>;
+				};
+			};
+		};
+	};
+};
+
 &lpass_vamacro {
 	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";
@@ -1087,6 +1133,11 @@ &pmih0108_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&qup_i2c3_data_clk {
+	/* Use internal I2C pull-up */
+	bias-pull-up = <2200>;
+};
+
 &qupv3_1 {
 	status = "okay";
 };

-- 
2.48.1


