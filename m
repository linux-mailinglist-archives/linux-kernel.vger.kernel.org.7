Return-Path: <linux-kernel+bounces-782402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8602B32004
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9987F5E10F1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65626266B56;
	Fri, 22 Aug 2025 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zL8V0nfy"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348F2472BC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878224; cv=none; b=B+mgpmn7I4FCRZUSWjO3OVVFkM/XRkMgMvGuBQNLuXZ79V9ZNJuVc0AH4XutRygf0MP43YfKnzEmwx+X1rNouxn///BNrSpo9Geb08g28efvPWjdXXDowntjh9dn1iYBE6w+siPGOZGHqKQCDUuBdK/QDX8WlVDJNOE2cbETQM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878224; c=relaxed/simple;
	bh=RXNwtS2EB/XgMHsPwffhQQ6cv/0BGdA9+5dc06pDkBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sLN3lGz541Ifs5MqtfAyMFlrYZs62M+8PLBzMYN0F/ITJLNN4CA7bZaBfVFoiPqSST9Yzyq+gaxeyZtSQzx9clRm5PTxv8DAJ77wgpiSJ10pPwP2v+m2OaD/le9YBF0WV1bZ1VucNex/8e+C/tIqRaPBhaTahDGovF+r59JsrhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zL8V0nfy; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c51f015a1cso1038864f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755878220; x=1756483020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMNvJ09N/9TdiQdCVO0uS/C2xMlkflJ7U48e0oR1Qmg=;
        b=zL8V0nfyGa7HnPrFYvVsHYIZMxrRffYpnrwNIzTVm4lqD5I+vvi4HWRO1rZoHQusEs
         LU+Y38OlzVjhv26lvY9JV9sLEkqlMc5vC1wk8rqm7Y3Rjg0TDR5T4zQlK5g4pwtY+elN
         KnaQ4hsBMcMADPtY8RqBZtLMV067UPIfRV7jvNaQKmnLml/618UsN5so4KeQl8er08Al
         Z0eWNN0vjxPPyLnfZ26RgCM1dJAkaxTFo9+LJZ+Fjc1u9tUI1hvQgOd6U9GBCS9WCKeR
         eXTqk7080zjrPIBFQr7lnnOTKWMHgUwustnFq0xTxCbTCJlXqjYYFWXEANx8oM9Ovscb
         clUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755878220; x=1756483020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMNvJ09N/9TdiQdCVO0uS/C2xMlkflJ7U48e0oR1Qmg=;
        b=dNSHMZWT3Qebv8sja/F5tEoULDVLfeadQYuejC6G1mXv4bFkiMIgGSYHTgZ7OBhnvx
         7Ce2dpZzVeYCngoqRg9PGHwfrDD0vJNArGXGkng6fh10LdM0EVHqD8qX6y/2hWh8dloq
         pc9tyIiD7+LWcmEHfk7dZuG3pdx0tV/4qjgGOoJWdqOYvzKi/nccrmW7/KuEIJJyIOaV
         Tce1e/+L2nndOzFhGXdMR68s42IrKnL4hz67hovAqIWDECqt908X3zGnAsYzgTInsP4X
         /pTr8Ap9kQvy8nf4DMTSZzLBffP4BJUdbFM0BUamLWmxuyZFJT8ZYdLZ85EoCPUmL8O6
         C2Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVt9EgV70H4B508iAS6nOW0tq4k3X5Q0JKcD1lhnqm5VPq+unRpAMNAy50cflUqlF/tHfUr4x4r32mZuUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYSFU7Wms/kE99QVPWYePRX5QnrL23e+P+vC8mzAOC4IwhOC4y
	6I2GLUzZ5HPT0EvOn4v6b7zm3pvG6/Lv1dp/WV8QybFtl88ryvfgpqK8jJMMldvk6ho=
X-Gm-Gg: ASbGnctetPeLj1UhsVueKL2jnLBTl3lhCYOR6aZhEyKVM+WOYWTXYOOYKwC8VULnxYo
	eQqE19rys2EF7y72fgwNWSCJQSWLsnAxOeEBRG62FbN+cOlP+Yr7Je3dhygou+w7rBo1Nstc8VW
	EKDknlFN6slSUSrVcvSi0MDsIAOTbgCeLYppsu+9IEc6fYuYlfTmtTxXbC38nHXuZoGlbtzbBxP
	TKEL0ac55RT9iIIYGxKyQ/S0td2p+A9VzK+tJBpZNK6JCbRL41XZAJ6l8KnzK4VY4awyrI2/Ha3
	rmqZCwYRCYpp9F5CFQnewQ70IKVy1iT8o5bgLa4ZA3gc/yQc1UglSDFU8tw6SRHceIGmpHnFs3x
	7a6A6oYGSVUxr6UYUNpUmyY9044D7RqjfTwuqiFO5IYA=
X-Google-Smtp-Source: AGHT+IERmB0PR9y0DV27mbGLpsXITt8jpcCmN2vindEbPvdNOo31trMg++Jt/W/Q3ADTFruoyLSDrg==
X-Received: by 2002:a05:6000:18ad:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-3c5dcdf9bd9mr3177477f8f.44.1755878220314;
        Fri, 22 Aug 2025 08:57:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c3c89cd4d4sm10095765f8f.42.2025.08.22.08.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 08:57:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 17:56:53 +0200
Subject: [PATCH v3 5/9] arm64: dts: qcom: sm8650: move dp0 data-lanes to
 SoC dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-x1e80100-4lanes-v3-5-5363acad9e32@linaro.org>
References: <20250822-topic-x1e80100-4lanes-v3-0-5363acad9e32@linaro.org>
In-Reply-To: <20250822-topic-x1e80100-4lanes-v3-0-5363acad9e32@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1885;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=RXNwtS2EB/XgMHsPwffhQQ6cv/0BGdA9+5dc06pDkBE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqJNGHblH5gHil6ZVXZSOuUgExa1pone/1zDZn4Yk
 RSoLC9aJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKiTRgAKCRB33NvayMhJ0Zr2D/
 92ZsPfP0nbaSc0E7A5yH1pVmGwod+Q4b7wvVUWDaP2Os/wvUFbrVMexKpSWw/mpICnZugkjogyUiQi
 3VXyJNBALELVDSc4xpe2yvO5U7L+eCNiPjTJkorfwsaDdjVPqMgWrbNFWitO+FvI0saaMphDo5rzOh
 aks/h3s87h7+xB2cIiz0t0lKXmO0MLJnM9YiDmQoQaYtBDXEoQEerjPxuNVvl9tFolbus53Ejxy7hv
 JzSmfkYEIARdvWHjhBkiuVNDgz7i1rTLck3ln9FVgDTIY84xTZ9cO3GSDDREqWoiQ6uadZknWhiSx4
 0JXwgllMDkQnl6rX7DphFPD+5W+lu72NHO97WF9PWeSBc0Krn7jsfC4WpFz5V3LIGf3edC6Ba/8Qj4
 s1WEO0uF+LEqK4YaWtx5cNJCQsifEfvQFXwLsSS4+UFbcse5rfrHz0dVJBQlXWcdHcmmdp0/UxOZRL
 VDmqAUXlxPGpTWC+ZA0x95G8vzwHzp8+M/p5k6H9stQQ67pp7RK3iEPnqHT9U3ZvpH9yNFKkQrAWRK
 HntOCImHUMOY0tMvCt0BDkoZGV2Fx39Kq6/olpyS3TRd7h0VvNsaUo3G4GV47kaXfIJBzkCdZygV2m
 TM4T/Uhc2HrhASpukXNSUl8OrPqYxGS1EG1dQl+om30GBiuv6eFFyCn0EPIQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The connection between the QMP Combo PHY and the DisplayPort
controller is fixed in SoC, so move the data-lanes property
in the SoC dtsi.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 4 ----
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 4 ----
 arch/arm64/boot/dts/qcom/sm8650.dtsi    | 1 +
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
index a00da76a60620b998973cab189f12eeaa0a448fa..d4e5c95e93395b84292366a6ad8bc1ee7d7c362b 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
@@ -941,10 +941,6 @@ &mdss_dp0 {
 	status = "okay";
 };
 
-&mdss_dp0_out {
-	data-lanes = <0 1>;
-};
-
 &pcie0 {
 	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
 	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index 081b7e40f5742120a611cbfa57a59dfb1dc19b9f..d71031cb26e2ecb1bf5c4e8b200e68f2d3b5d3a4 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -892,10 +892,6 @@ &mdss_dp0 {
 	status = "okay";
 };
 
-&mdss_dp0_out {
-	data-lanes = <0 1>;
-};
-
 &pcie0 {
 	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
 	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 1a750ae39232419d3b496f5a009f16ac8de40fa0..289ab35210c1b429d2337cbe4a5a479eb36d8b7d 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5721,6 +5721,7 @@ port@1 {
 						reg = <1>;
 
 						mdss_dp0_out: endpoint {
+							data-lanes = <0 1>;
 							remote-endpoint = <&usb_dp_qmpphy_dp_in>;
 						};
 					};

-- 
2.34.1


