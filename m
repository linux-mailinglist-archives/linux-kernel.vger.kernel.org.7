Return-Path: <linux-kernel+bounces-782403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B093B31FD2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7C5EBA6634
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB14428137A;
	Fri, 22 Aug 2025 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nc4RBFX3"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61EC24A06A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878225; cv=none; b=sZvbCFJNTFFqPWnW6keI7wB+1wElERLX6HbFfKPs5ycWCWc7pBpAgyvW7kk3cJ3kwF2z9c1rrNi9zu2K3CGOQb3YD/JGX2Bs+/XhAGK1E/EcC9wbtzPqTqXX46j96Y6I8kcvSWGPma99CDBdIPWbv/azPdOq2Vpa8bd/NSktWHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878225; c=relaxed/simple;
	bh=YFqi6/NWrUlmt2b3QOkHs1JyvEC+8LOPUYSaxL53bJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=niDk/pOYuNO2Ny2TloKAwJog5KdZEexiceXU1CEgGn/o7qh+NtVKbjwyC6+x8r1c2IaOoL3WS5OtP+gQP6Y3ovRk+Sk24eq3DUx3v0KSpk0TE0xC436yPr3N1jPr8lM47RC+R3M8v+T9HM255gwQodBJHn145LUwbszywufkg0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nc4RBFX3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9dc5c6521so1195552f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755878221; x=1756483021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAVGtahgYWKfPyILUb2iy7548QDqDVffD4gGLjCb7tc=;
        b=Nc4RBFX3RuNwYoCDZAMj1XEIyD1zWnLp5CIzd1YSoJ/SPi/2kc1MaPaL2da/L5iXUr
         /K5U4eLiz+u5mIN1fXmft2HKnJk00PvqEYtWFbj/GU4mA/RBBfCnOFIzo1lyqIxMVAPZ
         wvdWM81wSTbwjQVP4RHusmwqnB4v0Tj27Deg6TLYAqp9xodHILvq7k0zYOTjWaJywx85
         Kl/vWmrVOaSHDmXEZGp9o8FqDJexVgWhsvJmuFh9k2b/WGus340d/fmqGwpmTyGaFF66
         LumCLqnn4rXe4m+l4t7uJW308nyrjwjxB1O1gE1pDhjmmz4cuAYDFAtpMUCOBsCHq0JG
         yQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755878221; x=1756483021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAVGtahgYWKfPyILUb2iy7548QDqDVffD4gGLjCb7tc=;
        b=PRD2s+OgKusXtr1C5W2zPm1ZDGD49jqbKiLsdmsx9j0PUuAaFMc2OE2ReQEK/Hw1lD
         +NgZH2y+HhABaA7+b5nWjMQ5WbWAmuXzyZZ11S1qOrRrvRK13epOt89MFWDH3/QhLKxD
         4WKLFbK4yqly4Z7ktfHf2OlEPXpfhMZ490oTH15T66RfQjkeaAsg63VOOsi4sBDa4oZz
         8SJ4qWjaabHwHcmm8CpjWxIwLslcZPjxRkoP/D/TTfWL4YZt7vMG1hKwjukbIos2/oUW
         b73bXUPXsfcm323dO24pH+4e7ruGTN3+FbzRQA57hfh442I5Hf7JuQeD5KlX9T9bgLo2
         l/2g==
X-Forwarded-Encrypted: i=1; AJvYcCXWwQEPgR6m77UMutLH53Hvduw7Cg0pqlmNUgssS5tXisiaXI4cwJQgTztIIFmFwzw3rtptmc5w5ZaxX0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy591tJboIJpxiTB8eorKkM8C4Ah0TGpSqcpDOfjxIL1Gl0SUJI
	LwuVJ6zL84AA6hcXGgFgW+ehFC2hRziw763XMTNWWCmiSzFYin7u7pmFLyDxUVIwYJo=
X-Gm-Gg: ASbGnctKfaCP92+orPzfO1GCxDN2yLd3DAAa7OihU3aErzpjTZz/kTBzoiq/K2XHrME
	l9xoC0PkQVV6hT8EqTyUpW8a/7cr40hHMIYKuYrNNuJR5KP44EMkfnRFJ8yB5tMf4M20Qse1Xtf
	h+euWmAhrsLQuGiPEd60qIopss4vuxTkO2HwJFkfbdEdei1XTMZElrhzuWQh7/pxpbCj0a1aZey
	VIZ/OVHlEb9nauCXMLuEwnQ2UjZm5qqShP4u9/JMSIfsFQEtR/hqmN+lkq0M0x2SDP4+ttw00oR
	N2NeAdvqsXbb9ayZKCu215X2alDp7/0BoF1h1X1eKEBPmesd/JFsVLwtxF+qDzeNdRS7TJU6hxO
	fF7SJDiOCh3sVnLxbzb8Y6pX4fkTJTDF38LUuO2NYDWc=
X-Google-Smtp-Source: AGHT+IHqvo2qrzcZn2XOlsTRHSHZltKx0LNhC0cPRmaBvxwSQIOoJzj6Bw0KG2/5ozgdsZKpaf90ig==
X-Received: by 2002:a05:6000:2891:b0:3b9:13d6:cb4a with SMTP id ffacd0b85a97d-3c5dd0ebe98mr2485153f8f.59.1755878220996;
        Fri, 22 Aug 2025 08:57:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c3c89cd4d4sm10095765f8f.42.2025.08.22.08.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 08:57:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 17:56:54 +0200
Subject: [PATCH v3 6/9] arm64: dts: qcom: x1e80100: move dp0/1/2 data-lanes
 to SoC dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-x1e80100-4lanes-v3-6-5363acad9e32@linaro.org>
References: <20250822-topic-x1e80100-4lanes-v3-0-5363acad9e32@linaro.org>
In-Reply-To: <20250822-topic-x1e80100-4lanes-v3-0-5363acad9e32@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8534;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=YFqi6/NWrUlmt2b3QOkHs1JyvEC+8LOPUYSaxL53bJs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqJNGURAyNRdY1ykneNLWuM1nhqLnFzD1WEBzXh6J
 r7oqbHiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKiTRgAKCRB33NvayMhJ0e4gEA
 C/VvnEc7rXXzbZDTKULNE6IAZRCvyw+i+kuGGvuO0c1PQ5FdKZKJLMIx3gFgVKWV3yhxI2j2ptBbXs
 ZnN1n8UnvmRoSn9tFYxIZrvYZZ6jbBaCum7aZiPzi28ktSrxUXxtl6Kv8vP4meftZW6rB4ffE9De8Z
 G0SxCmrwBQYK2iGmA+qXw3ZqPoibgC6JFxGnKss8svmAJQLaGZ2mp61LPkiKVoymSx675NW1FDwemj
 VRgQOVX7D7dQFY8rpdV6rZXd3/utj2ojnBk6F+HDM1Oyfh2ayz1t4CDma4aY2kI9KI+O2kF/gp12H0
 LcmaiYArtZJ5j1bJqhbHx3T/mOVOAvTMHSnH+E9HyArrw3L1xBx4BiItiQ6BiBeKpOyudzD2ShHFnG
 5lsT7w29bQ+z5Lc6SJ4e1HSU9zSQtuVeXidejlDJHVKuT9YyGrYqSwNKlMlDf+bvJQfOXxH06F1JEi
 ahia0XaN4VdH5RkyNhyBarcqWdlxAB9MC740pvOLgZji3Jvn3NS6KeG4CXyKb6SRLsH/gj5a6cgZuw
 1K8XCB7XPnLjDHMZsRMWMh9ccVlq4ho64agz9C7LWCas2JWa/2SgV5wg9+0y+xogKz/MziDOfSQFHQ
 E0GOviT5/SjnofE1gsXZYxpiqmBc0zid0kes79/U6N9nJS99TZX0sxa7zbbA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The connection between the QMP Combo PHY and the DisplayPort
controller is fixed in SoC, so move the data-lanes properties
in the SoC dtsi.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi           | 2 --
 arch/arm64/boot/dts/qcom/x1-crd.dtsi                        | 3 ---
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts                | 3 ---
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi | 2 --
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts       | 2 --
 arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts       | 2 --
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts    | 3 ---
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi    | 2 --
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                   | 3 ---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                      | 3 +++
 10 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
index 16d045cf64c08c02c420787e000f4f45cfc2c6ff..beb484e36b0473fd52106e0752a11424d1530337 100644
--- a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
@@ -985,7 +985,6 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -994,7 +993,6 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
index e3d2fc342bd184473b37882f3bc4f9c4d23135bd..47dd99ecf02650ceee8247c9908dfc86c0f45aa2 100644
--- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
@@ -1149,7 +1149,6 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -1158,7 +1157,6 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -1167,7 +1165,6 @@ &mdss_dp2 {
 };
 
 &mdss_dp2_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
index 2d9627e6c7983daedba87619ba01074ee22b43c9..1c46f69308a6a726f61ac4121bf6027c7d474e95 100644
--- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
+++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
@@ -983,7 +983,6 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -992,7 +991,6 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -1001,7 +999,6 @@ &mdss_dp2 {
 };
 
 &mdss_dp2_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index 4cf61c2a34e31233b1adc93332bcabef22de3f86..abea14aa1a16437ec3ae21a68dd085c97914a452 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -994,7 +994,6 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -1003,7 +1002,6 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
index 6b27067f0be66b5c41fa681ff3b4f535100bdf59..6f646b23305e7497794d01b7744c753695d94a2b 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
@@ -884,7 +884,6 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -893,7 +892,6 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts b/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
index f9ce2a63767c151192b0618ee2154e8d97316c1b..ce1885e4c56300bf09c0f59deef4f6a38c80d1b0 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
@@ -1028,7 +1028,6 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -1037,7 +1036,6 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index 71becfc5e6f649299b05b0b93cf74b81dea9fa57..c03dbded1624ea52013b40a9bef4dfadde0863fe 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -1061,7 +1061,6 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -1070,7 +1069,6 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -1079,7 +1077,6 @@ &mdss_dp2 {
 };
 
 &mdss_dp2_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
index 27dd5e4e9939124360544ee9c59900ebb01f3f49..eeef0cb2606a350594f03d91762a73e4dce021a9 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
@@ -949,7 +949,6 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -958,7 +957,6 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index 9369b76c668b5c008fefd85d5ca18e87ab9ce93f..2d557dd9c4fb59ef72174401f418335b4c1e13e2 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -890,7 +890,6 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -899,7 +898,6 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -908,7 +906,6 @@ &mdss_dp2 {
 };
 
 &mdss_dp2_out {
-	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 48c715e9ada33d4909049bca28c68a6b24ca0b0a..be1c2152fcd66aabe275527ca756f2598887e34b 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5380,6 +5380,7 @@ port@1 {
 						reg = <1>;
 
 						mdss_dp0_out: endpoint {
+							data-lanes = <0 1>;
 							remote-endpoint = <&usb_1_ss0_qmpphy_dp_in>;
 						};
 					};
@@ -5463,6 +5464,7 @@ port@1 {
 						reg = <1>;
 
 						mdss_dp1_out: endpoint {
+							data-lanes = <0 1>;
 							remote-endpoint = <&usb_1_ss1_qmpphy_dp_in>;
 						};
 					};
@@ -5545,6 +5547,7 @@ port@1 {
 						reg = <1>;
 
 						mdss_dp2_out: endpoint {
+							data-lanes = <0 1>;
 							remote-endpoint = <&usb_1_ss2_qmpphy_dp_in>;
 						};
 					};

-- 
2.34.1


