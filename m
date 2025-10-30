Return-Path: <linux-kernel+bounces-878437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 378B6C2098C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46AFF1A218ED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3682773D3;
	Thu, 30 Oct 2025 14:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VXGqRoTa"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1123275106
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834535; cv=none; b=PKCHkbUNWVO7hE+7g3t8TtD8FavoTdfjmtdCfqfrONyL1k3cT1p2YMoXVeJdypkNRDgQsI7NxWO4Uz2LyVmlaRADhlHOM90tEpq/bAZdStbbYycEir/RvrB/VQ12i+wqTOPCyQcgyggAyC2jOgT4PmYDliPIM2F/wX6y5IvEflA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834535; c=relaxed/simple;
	bh=LwKDeDbaB/qNO5GHXE665iLTfSrN9deeeAEkKC4gPHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMqJIekkzZIcnIe5ypxS5/L0r1B+6DbBotitAIY0NVyq90wCNyRY8nTLF6yPX084st9HMoXR7nR7aQ8QhD35XAd+s19y1j/WB8HxQ/hEY3Q6ruQRY/6Nx816LuSZcam0SeKRJUNkhZiNqGeo3NuBbyy87SRDE1P0vqPz1wAzeB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VXGqRoTa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so11264815e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761834531; x=1762439331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hky9aZYZhqPebPVWCtl7ijJ819/bzTMDH0Hz4vsdJA=;
        b=VXGqRoTatioBvfiSylTZoqpcCh0xpgKQZ05X0Dj2CiTKifrQCs/LwOv6Hwjghebcaq
         G4VGEYfhXU2SqV1MdVrSZUEs6edtyFytCVYJc6c7eUHXGbMBzf0GHykHw235azN8O5AG
         /czhuEaLcXC/kfSkNVPGQylXqee1gB2GD8YCR5FMw7D563xhBk/NnfRTbWdL3JPZvgcv
         tyMUr6nxBgLgTWNq7zYEY2K35w5dUWGVOJa5+6XMWEqrEcWjjhzyo9g7z1E0nyJIb472
         1gTUxZJr1z4+6wu9N36va42UFCixxzlV0ma9/ie48bu5ezsHaZ06fp5iw42nuwO8bFsy
         CIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761834531; x=1762439331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hky9aZYZhqPebPVWCtl7ijJ819/bzTMDH0Hz4vsdJA=;
        b=KxAdlRsr5Ks3WAGOdRIo78tmqDW83bCBUfN29crLpf7ZNYAIaLPJ5Ih8d1mRdUG5V7
         WcHHX83rBzM9lw00NMBPvN8UIjflRjkh7laHgpyCFTFQDBAswKSUsGGDa5p04Qwj+Eba
         BGqudGFP8ZslhhnFVXRyjWKk87e8k4P6Ol5SqZ3QfJ0vxif5zLChsbTc6T9YcV2edWHM
         +8Y3CpktsXv/VOdKWtrwokxkY8xrw4DkxSXnwJmP5cr8u7boDPDwGoKt6xZkhs4temOY
         mykwQuoyFGeiJ3HuSjjXvU162Q1D2hYgt4HF4mxH3O1p3WjTEPwcA2aNag4d4qEo4wzx
         R5XA==
X-Forwarded-Encrypted: i=1; AJvYcCUuXBMa1i/YGFBMueg5R471c36d057FSBjZ5LARjANSlmCP2JXL9ynk5B2MBAR8vVJOT8hmUfYhdIydA+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd7kHTUPvVvFWo7IHktvjtWYYH4Rq/L1mgGRPETAURm275ZbQs
	ptPEjmT7yKmjNmWPf5861KzBNLqL59s9fK3+ZhvpCO1pJ2JgWgYunebVG4AZaN++UbI=
X-Gm-Gg: ASbGnctWTPTQD82XxNdnmLxURDGFVFN0l0QFWJElEFN7TsHcoKi7UDZWwX2cIOxTVuH
	ZZfOrSdYBXYHAyWoScOfwYzDhhaEBQHcLX8mj6sAREdiWVQZ3ewq446H0jakK/T6C4Nbld3PrlF
	3l6UUkRQQIESVPZH1vNUx04k2R1DZw0PgKxh37P1y+1Zfv9X2Gx4uYvsI0sdWFfireoAY1vRFN0
	cItHbNKv+oGUkUlSR/0W/KOYkOaLmf+VZ6owNhKoG9/SbP8PnPwrpkN3nabvbCrXqIOT2ZAwlgG
	mUQ5LsnImzsgXd6messXr9P8o/DtZUcWX9Opfmgz8JfWqV6LWP28GhPgCjGjdxaFWUVDX9VRbad
	KsQAQaTry379szwkJI8mqYKDzKB9yEFOT1U66GleB8MkHwnYqZjRP3HYiFaSqWbWTyJzAbaIspe
	G6QIA8HpKW
X-Google-Smtp-Source: AGHT+IEQ2IyXRDcnIR3RPu3dYi/RV8FM42o3crX9ZDsG/wo/02yDOOqeF7iZ59gxjUjBQUJ3Gx2uBA==
X-Received: by 2002:a05:600c:1c1a:b0:477:1af2:f40a with SMTP id 5b1f17b1804b1-4772673665cmr31213715e9.17.1761834530750;
        Thu, 30 Oct 2025 07:28:50 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772899fdfbsm42230475e9.4.2025.10.30.07.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:28:49 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 30 Oct 2025 16:28:31 +0200
Subject: [PATCH v5 3/3] arm64: dts: qcom: x1e80100: Add missing TCSR ref
 clock to the DP PHYs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-phy-qcom-edp-add-missing-refclk-v5-3-fce8c76f855a@linaro.org>
References: <20251030-phy-qcom-edp-add-missing-refclk-v5-0-fce8c76f855a@linaro.org>
In-Reply-To: <20251030-phy-qcom-edp-add-missing-refclk-v5-0-fce8c76f855a@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1887; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=LwKDeDbaB/qNO5GHXE665iLTfSrN9deeeAEkKC4gPHM=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpA3YYkG+n2s2QP25YZJkhRj+64fBjigIHVQhOr
 ljmQoEGuImJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaQN2GAAKCRAbX0TJAJUV
 Vn/4EACEkEbtxyf3mOVY1BDh7gwSldWCpPcz5fLbcP4lZ0hYKcvvQv7C0o1MXscxfkbbye6riSx
 WMvFfaAbGEdlLocol1aGWy28k6ce81iMXlqhQBJZX1YnpC22dBvElFdFk6KHpM9Y+KY3m5GEkv7
 n9vC6MGwZTXoZDtd6ArJxHl0PY2+YT1+qXnypTvy8DMdqrQmDykkCN5SJQA5gmVqn3VgS6VEWCM
 fum4bTQOeRJ5ZO9/AP11QROQ+MzQeUJ0hTR7S/wphKlfG/85M3eWjvhFfNOi7ZncmLUJ50j5cKj
 UGk4Cc5Q9neWb/YxmvCCZSzgKDAK17HKw4TOmdwGV0iyaRQiHjeP1JAr1/APS/ppprI6GbkDQdr
 KsJcvWMH1C/Sl7uzRoWL2Eb1Q70Hs5c9rUWxvjEBwQUjFglk1gQNeK3AaV1/Hv6s/D0Za6aqGP4
 FKC2yza37pZT2NL1sZKqF3GHIPuCDztT0q8byzy+ntPrZbntWPuYhtkc7EfubOTBYA+2uI89CGP
 ffx9zHhp/cChkCDL+nYjDRtJ7Wq5LfvCPaXxoX86n4g+kd0/P27xmQsPDNCWypCQXTA4xSYenT2
 +wGylqHHFIenX9+uhCB8EmJ+AXPjFAd2lZVFq3HzSN5cU5AUUe50q6XjgIRtNWK3OGhJh8PSkv/
 /PnBWeCfujozQzg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The DP PHYs on X1E80100 need the ref clock which is provided by the
TCSR CC.

The current X Elite devices supported upstream work fine without this
clock, because the boot firmware leaves this clock enabled. But we should
not rely on that. Also, even though this change breaks the ABI, it is
needed in order to make the driver disables this clock along with the
other ones, for a proper bring-down of the entire PHY.

So lets attach it to each of the DP PHYs in order to do that.

Cc: stable@vger.kernel.org # v6.9
Fixes: 1940c25eaa63 ("arm64: dts: qcom: x1e80100: Add display nodes")
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index a17900eacb20396a9792efcfcd6ce6dd877435d1..59603616a3c229c69467c41e6043c63daa62b46b 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -5896,9 +5896,11 @@ mdss_dp2_phy: phy@aec2a00 {
 			      <0 0x0aec2000 0 0x1c8>;
 
 			clocks = <&dispcc DISP_CC_MDSS_DPTX2_AUX_CLK>,
-				 <&dispcc DISP_CC_MDSS_AHB_CLK>;
+				 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+				 <&tcsr TCSR_EDP_CLKREF_EN>;
 			clock-names = "aux",
-				      "cfg_ahb";
+				      "cfg_ahb",
+				      "ref";
 
 			power-domains = <&rpmhpd RPMHPD_MX>;
 
@@ -5916,9 +5918,11 @@ mdss_dp3_phy: phy@aec5a00 {
 			      <0 0x0aec5000 0 0x1c8>;
 
 			clocks = <&dispcc DISP_CC_MDSS_DPTX3_AUX_CLK>,
-				 <&dispcc DISP_CC_MDSS_AHB_CLK>;
+				 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+				 <&tcsr TCSR_EDP_CLKREF_EN>;
 			clock-names = "aux",
-				      "cfg_ahb";
+				      "cfg_ahb",
+				      "ref";
 
 			power-domains = <&rpmhpd RPMHPD_MX>;
 

-- 
2.48.1


