Return-Path: <linux-kernel+bounces-762586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD459B208BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A68F57A511D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE712D29D0;
	Mon, 11 Aug 2025 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBnOkGry"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0DA2D3A8C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915125; cv=none; b=NLlXJRQ789QgwyprgzlKB5/nw/r3jjFA673IlNshu6rIT/vmsQp3R7MVPoZeBQwnPFEdkjnklZt40gRrNttdmny8pyjZaH4VF+HvLyAAOSfLsQJEGkEyYeo147LBacObwuKKpMDoMa0uxFyTenBg4ZzbVlCVFJMAH6VVHuSI8gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915125; c=relaxed/simple;
	bh=E6EpzJPTESLvnjqzhszJRKba7xo8Q4+acZhnQGMvoUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JBbuvAbgvR3Ttifxq4hWUkxranY/cxFGhyvCXb148cXGuUUsBjfz8YwETLN9rc15b2ulrSKttJdZ0d9ybX2fCTZbsyssFNEKWlXwnCTgnppFEfGm3+HzCmKcDORJdRDVhq7SMC/fXg9haQNdoRQ02yVKt8ZKEC+LtHX1OqpYGAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JBnOkGry; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-458bf6d69e4so39625445e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754915122; x=1755519922; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etivZ7e+0kguo0gK+8IF/PpV+Adfh+Nn8xqpoIKE9zQ=;
        b=JBnOkGryd5ir06hwuwDV+SediYHhBshzefPbEb5tNZyIFrmJuu0EeUChR1ATkFzmoH
         lMYHkkTrvS6AcyvfCFxZtSA6bBGu/u8pHHqB44JlpNTiQ4sWbWdPbfBazJfuQ2XmteTi
         +PzvgJsFlrbM54ojX6OcypBwPKj08K79652yUbk0e1Wmz4+3FGI/kvsT9KZkbvl1nc6D
         8+dHXx+ADmrqXDwZ96lEnHfiXnbmz9UobJz3q6Wb6Y04orW5FWdAwn5tYTJDtCQexUee
         HQS4O/+sZk637YRfXeQei0s8HMmg/astiV8WJCHlxDDe3UnuX7vWTbloIOaPId0FvKyZ
         wSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754915122; x=1755519922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etivZ7e+0kguo0gK+8IF/PpV+Adfh+Nn8xqpoIKE9zQ=;
        b=ZmLiToRnlQRRq/FiEmpyHQL1T0S44qchwj7IC8wrU7u5YiSo91lCw5LQWBk5T89SS0
         e6B6kULkXVrwTSMZybW2UxOMafFhVFBa/SY7/8y/SUoL08umFL0uSEyGlU9uIjJfXmvt
         bbb2wjK6VxK9HL8bx9LTLrJ/oXZFUOHgb8rE6GJyYx4KrcxfS+seeK4+k4ApMhjOYwnb
         2RBAveg7oGIk8IvZRE912obUFi6Zm55vILbEgDTWV+ZlILzWQLtiPHfkSpWJ0QZeDnO0
         9mJzI6kiqjjo6l+1BiwVY2o9NHwiqlvTtd4adewNcu58LX/Vhv2NE2PiM7lq24qTiTZr
         YySQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe/Zk/vkyVdyh03svNPQWPh4hIdkJ165sgExhqUFjAzC51TuA+TFtqqoM09MVdQrTIaYVX0TfAPJJCQVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLQGOcxqA/Y8qKXOGxjkmVoCSDedKaHL0i2CgBV9BtSkwAIv65
	aSuxIS0fI+ni/9JhPKznuesVTiHjScgINEX4NrM4rhmR58EanFt3/4x6aoQkN8azfS4=
X-Gm-Gg: ASbGncs3JH5xm7IH7zt8qSKNadSnmYwZ8AIJhY9pdAK2SNC+RJdSHRhjz26OoTt3QTa
	N1vCu/EpLS63xT7RE0Sd3LOTtIoVV06je+QTtcxiS1HjWl+ziuAleiflfrELrOIUHf+cyPtxzbV
	WYMaRUaIavQguAU2XYWXRKKzWeXNDnmifSmmXElkZWe6Ppz96ZOrUO8tSgOnqBgU3kZ5+8/EOgZ
	I/7Dz8HS/qXjxUEDtd4WhoJ96QbnLCeRQnPH+T/vW42yDvkJo8WtS6T/KcgX4xMD8jFKLDCdczQ
	/ntZcKyWDLS/sc5P6OATo1RK6/Btg/hQimbI2ldCNIUPLVt9ccTlVYYh1yPdvs4NL1HXY71OgV0
	Tz8lp6Q0pvhy3LbJlzh5tfKPtQmzmdRWcKAWY5mUGN+6tzcETdKE8yQ==
X-Google-Smtp-Source: AGHT+IGUr95wE+u93q0vSmOmXp2/y9tli6pPk887xnwSyMiOxxtfYzlWTj9sJPKnAhzf/3cHhtET5Q==
X-Received: by 2002:a05:600c:5395:b0:458:c059:7d9c with SMTP id 5b1f17b1804b1-459fa71d713mr92177285e9.6.1754915121583;
        Mon, 11 Aug 2025 05:25:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5d0b1afsm248013475e9.26.2025.08.11.05.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 05:25:21 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 11 Aug 2025 14:25:17 +0200
Subject: [PATCH v2 1/2] arm64: dts: qcom: sm8550: Flatten the USB nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-topic-sm8x50-usb-flatten-v2-1-0bbb3ac292e4@linaro.org>
References: <20250811-topic-sm8x50-usb-flatten-v2-0-0bbb3ac292e4@linaro.org>
In-Reply-To: <20250811-topic-sm8x50-usb-flatten-v2-0-0bbb3ac292e4@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4086;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=E6EpzJPTESLvnjqzhszJRKba7xo8Q4+acZhnQGMvoUU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBomeEv1lNuaeeR1zoBkMkCI01a0HE0ROxrrqcWa3Zk
 qKhbZP+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaJnhLwAKCRB33NvayMhJ0dQLEA
 CoWU7XsGGHWfzWFGnl5ydGcCnFK5TROYKBabhal8PsD5CZMQWATGKq5pB2zbwZGLdYbUiAQQNEt/Sg
 RJJ5kGDYj/FDx/Xq6+5EuXm7dLWzwy+Pseck46oxTQFjEJf3Cy5oIu/OWkjXKg5pV4lf+uApLVTYDB
 nOqY8jqBHhUM3ekCSpOvfjykSkmPb+eLZxXXPNnY8eqT6S6iXkwSWRtiCPkE6M3VlxRZgfuai+Vsqq
 ctIzWtpeWH2KGdRLE/4fxqhqZ87FeNZJYrZXRp1uqGUJZNL9/EynM+FqAz+BNtlMgBK1aINfybOPdz
 jPlRqW+DqJ5nRJOTJUWU26gRMz4quaGa8HQXBGtgFFWt/gqe6wkY8cCVPkMkkYeWdZ+cIH25n10D3u
 pyqSYQLYArqRfzaJz10pd4u7B7xnHY6sFDcJdBM0AhoNgqKs8an7SHe6QVt2ryrMhAEwH/nafDZ9TJ
 FytOrjc+eBQBwkalcQvSxL3jv5wc/CkUJMXdI8Z8Yo07xyXw0vMOtygn5OkUP8Kfmq5Hgn8y+fvLOy
 GIsR6C2lmAHWMrrGUFRtP93CRGuCogHhKNRyj7z7X/5mzlKLRZeOBPjfU7+KbJ9DzAb0mnq20ToeUr
 UJCNuf49GMurTKd61MrgTLN5jUHVB3EVR4tosrtlhF7kgWViCi1EQZghIYYA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Transition the USB controllers found in the SM8550 SoC to the newly
introduced, flattened representation of the Qualcomm USB block.

The reg and interrupts properties from the usb child node are merged
with their counterpart in the outer node, remaining properties and child
nodes are simply moved.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 84 ++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 45713d46f3c52487d2638b7ab194c111f58679ce..4f81a6fac6cc0a4fadce96e84c70a1c6dc52d8f3 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -4084,12 +4084,11 @@ usb_dp_qmpphy_dp_in: endpoint {
 			};
 		};
 
-		usb_1: usb@a6f8800 {
-			compatible = "qcom,sm8550-dwc3", "qcom,dwc3";
-			reg = <0x0 0x0a6f8800 0x0 0x400>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+		usb_1: usb@a600000 {
+			compatible = "qcom,sm8550-dwc3", "qcom,snps-dwc3";
+			reg = <0x0 0x0a600000 0x0 0xfc100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 
 			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
 				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
@@ -4108,12 +4107,14 @@ usb_1: usb@a6f8800 {
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <200000000>;
 
-			interrupts-extended = <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&intc GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
 					      <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "pwr_event",
+			interrupt-names = "dwc_usb3",
+					  "pwr_event",
 					  "hs_phy_irq",
 					  "dp_hs_phy_irq",
 					  "dm_hs_phy_irq",
@@ -4130,47 +4131,46 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 					 &config_noc SLAVE_USB3_0 QCOM_ICC_TAG_ACTIVE_ONLY>;
 			interconnect-names = "usb-ddr", "apps-usb";
 
-			status = "disabled";
+			iommus = <&apps_smmu 0x40 0x0>;
 
-			usb_1_dwc3: usb@a600000 {
-				compatible = "snps,dwc3";
-				reg = <0x0 0x0a600000 0x0 0xcd00>;
-				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
-				iommus = <&apps_smmu 0x40 0x0>;
-				phys = <&usb_1_hsphy>,
-				       <&usb_dp_qmpphy QMP_USB43DP_USB3_PHY>;
-				phy-names = "usb2-phy", "usb3-phy";
-				snps,hird-threshold = /bits/ 8 <0x0>;
-				snps,usb2-gadget-lpm-disable;
-				snps,dis_u2_susphy_quirk;
-				snps,dis_enblslpm_quirk;
-				snps,dis-u1-entry-quirk;
-				snps,dis-u2-entry-quirk;
-				snps,is-utmi-l1-suspend;
-				snps,usb3_lpm_capable;
-				snps,usb2-lpm-disable;
-				snps,has-lpm-erratum;
-				tx-fifo-resize;
-				dma-coherent;
-				usb-role-switch;
+			phys = <&usb_1_hsphy>,
+			       <&usb_dp_qmpphy QMP_USB43DP_USB3_PHY>;
+			phy-names = "usb2-phy", "usb3-phy";
 
-				ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
+			snps,hird-threshold = /bits/ 8 <0x0>;
+			snps,usb2-gadget-lpm-disable;
+			snps,dis_u2_susphy_quirk;
+			snps,dis_enblslpm_quirk;
+			snps,dis-u1-entry-quirk;
+			snps,dis-u2-entry-quirk;
+			snps,is-utmi-l1-suspend;
+			snps,usb3_lpm_capable;
+			snps,usb2-lpm-disable;
+			snps,has-lpm-erratum;
+			tx-fifo-resize;
 
-					port@0 {
-						reg = <0>;
+			dma-coherent;
 
-						usb_1_dwc3_hs: endpoint {
-						};
+			usb-role-switch;
+
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_dwc3_hs: endpoint {
 					};
+				};
 
-					port@1 {
-						reg = <1>;
+				port@1 {
+					reg = <1>;
 
-						usb_1_dwc3_ss: endpoint {
-							remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
-						};
+					usb_1_dwc3_ss: endpoint {
+						remote-endpoint = <&usb_dp_qmpphy_usb_ss_in>;
 					};
 				};
 			};

-- 
2.34.1


