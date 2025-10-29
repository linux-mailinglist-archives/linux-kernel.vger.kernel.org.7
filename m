Return-Path: <linux-kernel+bounces-876222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A77C1AD64
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5EF834EF2A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31963559DE;
	Wed, 29 Oct 2025 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLt9FAw2"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBAF3559DC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744716; cv=none; b=jr2v9HOPs8qhUu8mGLASVv5UayVcHPGEwaflTe+CBnkHRYjUfgkV6FGUwgLuEePgGy7fvDlJIKiPqoCCQ5s7UUNDGL0UzwAo4szyNoEmkfN8/dzii5YHA13zwn2ZRsYeOL4xWgPnB1Se1R/NgAFAeZEG7NoNTA1GN+bq+/BMYO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744716; c=relaxed/simple;
	bh=KPHt1suJLdA9xJbwn2KTdFAVkwcQfxRACwyO17/eejI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JIT83pP2By1ZEl2AbmH//x1e1hHg24Tfz1dBmdnQerlHlrCj052hwWHAvsCxMQjziY53Eo7h83nXZluiMqDsOlLHNytoGp8WgcvdUsDS8pKoh2Rg/U9kh6CHJ5+IOreOzSpectGjBeIo/xlVam0izHxDXADJhggTl0hQkJ+cyKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vLt9FAw2; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475dab5a5acso27988365e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761744713; x=1762349513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxFx9AVopbicqvEHjs4lmh9jOTKVKMn3jkGcEi+fwfw=;
        b=vLt9FAw2eUHRYdCwsWxckB5hsRo2HYZuAQ7aEcIZHEeNpYVdcu3m/dbllSGKtM5ZuP
         qTSRfHatLR0ttH23LyL5x5U09j3gQ2hKl5bUiaCEZgR82xGMXQ02byZlTdpAToaoSNbL
         yYB6EyybRBDRWxqLtZMa3u4ExQ8HcYdvkUbSBmhVNKVbBBlq1QI5G30R6+rhsy2A9W8i
         OiYU/hWB3YBeHirrx1//NfBvQklD5pBlrw5jt7dBULy7gbWf8GjgFRoybysmxqBrLPcc
         5GsDElrXFbjwerpw0/rCm3/9zBY+syDCZAOCrkMMyI8jf9xMvqWFGcGH6Sty+JZw4QAp
         UYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761744713; x=1762349513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxFx9AVopbicqvEHjs4lmh9jOTKVKMn3jkGcEi+fwfw=;
        b=pEXQeajsriffqn5JeZ2pPSWGsbmkEOAvDuMkzInnwsu+RPXPQQ6I26xKuKZoKvyPlR
         /kCttmQElx3uO7bOQenJ7SQcZrbY4K/hkk+oXjw2hAmlgl7SRJju6CoR/gTYncJhm5Ng
         T4TgCzafaRJLcMZqhvbptlebhmcgBv727Crv+I7Fn6xmXP/9Zt8xdb7zmZXfGCHgPxdh
         M+1z3Onp9B6MkagSkSyW6tGlmheXFeJxg1YKOwRUTJdtguWqkLo/Qf9ZcSmmcCWvU+bB
         lEO5Mao0oPP9R8OoU9EOWWc8ezla+FJ7ScmyfB9mYgXcLvTmikF6qIo6Cz5jN83wiAt2
         a6zA==
X-Forwarded-Encrypted: i=1; AJvYcCVZs6Mn3XIzASnJbKMSpg47Ez1eaAysx93Eezvr0odfmXk7w5T2vz3O4aob4jsivS1vNprmuhnT6ZN4sFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv5KGuABceMpcKhcab4kXiQu4z8xkiXjsKUPGGEd0fu6aX4mru
	VmtY+iJTgjOQv0dBez0A11bjs4R0v/H0B5cekwUbHZ60I6Tmh1L9UWKCOKeKDWK0uX8=
X-Gm-Gg: ASbGncvbwDH/mEAXg0rG5Z1VWHMlBqd2fMzJMNNg7PfRXrTr242NNaGdgm4yztPiLHh
	3dcOCibQhAVpkW4wCbS8Yysy9aTVQN/+nOrcxE4hlaTj68EgUkgT57TJH7u/ulPv7z281HVkQsB
	v5JvARHm0+QM4YpqjYiPS5AfQUMjrNNkjEfsrTrE27f1/+8Je53bm4O77NvlmT9sLZnx3VCSq9X
	zQoqhIHWkkAtKU60NsvgZZbWQ4eOzuYf4FIv8t7fu1CqMVVJNCrsgKn9dIcYZtOfLUaNUqpnWZ8
	Bspx21I0WQPEDNB0kK9vhHbUFsl306udeEknVmisVZFR0HDe+jYvAVb2J/QUGhix8+5UyBEhEQp
	jED4qW4QY0+8Nhc9iECFCzjqsEo871gLavnhCjSWxs0C1t6l5VXmNfFJlddy4U/8zQuOqz4mGIA
	==
X-Google-Smtp-Source: AGHT+IH0r1cHcYhclN+lddpFSTpYRQm37SvwBdJsO9ETQMGuuRIVJvR1BxyxAyy4GGcFpYwjtQMFpQ==
X-Received: by 2002:a05:600c:3509:b0:477:da4:364c with SMTP id 5b1f17b1804b1-4771e316d15mr29213535e9.4.1761744712875;
        Wed, 29 Oct 2025 06:31:52 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3b7cb9sm58273015e9.15.2025.10.29.06.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:31:51 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 29 Oct 2025 15:31:32 +0200
Subject: [PATCH v4 3/3] arm64: dts: qcom: x1e80100: Add missing TCSR ref
 clock to the DP PHYs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-phy-qcom-edp-add-missing-refclk-v4-3-adb7f5c54fe4@linaro.org>
References: <20251029-phy-qcom-edp-add-missing-refclk-v4-0-adb7f5c54fe4@linaro.org>
In-Reply-To: <20251029-phy-qcom-edp-add-missing-refclk-v4-0-adb7f5c54fe4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=KPHt1suJLdA9xJbwn2KTdFAVkwcQfxRACwyO17/eejI=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpAhc78Huk1DUxx69JKQSG5U4czu0+QGuk2fxft
 ec98SugJk2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaQIXOwAKCRAbX0TJAJUV
 Vm/+D/9CM974LmK6eWlkBPTFJajwpYn6wuv7c739h4bugBgRVu0GzJ30jM6vHpkuKcg3VwGflxw
 qDNk31xmb15SwWqmZc+iFO5SRgKTbq25gECsaHWDJ8ErmxvR/NNKL5WkLE2XkgfLGqr2xsSijob
 NFsToK94sSWO+86qgY8VTmvOwV0R5Uxm29EZG/4cBOPKleO0jmIh9HAlXfoPKI0w5S4x2zSoStm
 OTTFCp+sMFVYoZwdYq35GCiVom/y14FwUregArwG+Sq63JRy7r8xiWTg8XiKi7JmAcKfERiIA0e
 P7jpf6jT3sOjVMjv2J7Z8/nYAMdqUg1zq9eJlTGGlKnE1pPvz3PDvVBwscjJh6OhY1umkI7nwaP
 xnTGCAJZ7V20qXf1kuccr/gNkRpJk/5xm5+ZywkYuMW3h/J1qlOUNx0bAZfa6AZfVI8AdyxOjlP
 kNzjhzlIvZFKSH26uKHmoTcwYp2MKqkpHHq3/eQIrqpjb2tpgKU2slJJFfdu4FYNarVrVRXq/ad
 7xTkEJfPUt5NGMAZmX2dqg1lm8tDg3KxRuYipdxii7RfY+OKcjYAcPpxYIrf/MmsDZ9vusThXJH
 oo/0C+OQ65NUi38EqEnlPl1IXa9FSZ5GLSrilhN+83R5Zm/GPN75Xn7lPsiDUaU22mOmwhJ2oga
 0k7P0GxytieUtEg==
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


