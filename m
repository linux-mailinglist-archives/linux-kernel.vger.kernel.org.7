Return-Path: <linux-kernel+bounces-800085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB66B4333B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55A86868DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EFC28980A;
	Thu,  4 Sep 2025 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gUAcJJ3k"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA6228850B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968988; cv=none; b=Qtp8tlh0QSyc29qBFSLjPqqaZcJ/aVZXX0XHp1gWdJguEA9lHa2Tcbhv735n87KDVRhasEjn8X4jqesvE6/5phgCliuDNQGxpbZHT0x8seKA+hzE+RWNmW2/P91cVqcWU6qGpq+89AxvHhLRzyrhv8CUZGA89RDZEA+8KJGd6us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968988; c=relaxed/simple;
	bh=jfzN/ldSxbD//tqugQGgHnEZ1hcjELAxuOulbu9UKOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ts7rELVJtXAQa1NX+XMlrvlKVKbFwYPsu8Ef/HBnB68NDySzOCGjYqC4kd3wRJDiq7kiz5dATXjfmjBGuOJ6zxkXFiKy1/mXxX4YLHQmhOYByDsBiukOgzuPMokG4yyxYR0RetZk0U0D0hDBAIdvaeedLmyjL8+7ULL+v53UiZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gUAcJJ3k; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b7d485173so4776295e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756968984; x=1757573784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/G87kyp/pfaxxUGK2NUKqpezATDG2ia4UyLkERw3KmM=;
        b=gUAcJJ3kiEmYaduxK6nyhqW/ve5Ohxmug11TpqsRaXn1OFjtQDT0ZumEfRYYWVaqdq
         vv3BQ3tldiLNekXChC4vzwKkRS9Ij7SVtjvC/8L7TMS2rpuF46LafBq1MODTvmfGqqnV
         1+7rg2lf29BuDBqfkoATK9RJQBPFFmcXWCPwrmKxmbhKaYbeJCH8WQhCL2Jo8n7rArPw
         RLu0vCQUZstkCYzJ1YGloeR5WxsUkbNATAC5B31Gu/NfjL1sIkE1z/y+U5fB7qvoCs6C
         tHyRiwlZ2luKEbA4adaqK4z66onXwh9t4grw+67GdPIQEDqz7veWyFEZv9azJk24YOpC
         Jd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968984; x=1757573784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/G87kyp/pfaxxUGK2NUKqpezATDG2ia4UyLkERw3KmM=;
        b=jbVy79Jy7abfYX7kabZiWDnTMY67CDtVeOv6I1z+L4ehYKwiTMSEeXSXTr/txQuTXk
         Y4gR5LtFpnhNydtCxGeohJwVX8UFfka7hiul+WBlja/Pwbp2qHewT4LC9Ho9HLZACBVu
         IWveqGsHwpeXt/NLYlTQ6hmXEOY5pe1EEx4f3dQovbcBALSsOZR1LvLX5i2B536bOjJp
         iQEwiL0Pfy4tOx14yX3w2mxHeiiJ9pmtwWVfejOdKWc7FFD+r0efF49CiR0k9n3P69Lj
         fsQF42RQWE9Pf5UZZ949qAbQEJSVXh7XwMQn69E9qeDcbGHfb0vQkgMwxkeOJRAW2Vy3
         m/hA==
X-Forwarded-Encrypted: i=1; AJvYcCWX/IJizakMUU4o3wOnJ8BK67z5WdhCX1Pjgp+5NTyO0NJkWpyDRIS3jKx9Xec4sVOeTOs+APA9qlrusLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyysuaUHp+8Xc5mQ6wZ+uPkPz/5aKpxvQJ/hrouaRryI5gaJmA4
	UjMQxL/IfWy4LAWFHeYCS8BK29R3I86RRx3wUXZ+6eObXFA42X3HaJ4hZDAjCKdB+VINPBGhPQg
	80Xnu
X-Gm-Gg: ASbGncthTDPzVmHMPWPGk7TQxweTBxOdRMHU56VRDhdrA0BE4bMLBg9NdS1ubBYAv0B
	iaCt40R4JNIWDCtOLwXw9oPptcIb7HPXxA3TvG9nyHMaOfbYjIqmwjvqEKYLhvX2of13cneO36K
	/2yvHsG1vURxdlU7WwxznsZVSjV1XRX3fD7jGnc3TrpG6z+QBLHMTqd/DJY7MruBxS899TMr1LE
	uf5S5t1jRmf3w2iYFYviFILKuzIpBqg6Ycr66tddaJsS73tF/m97P4Z62gRO8QaSFLCurPaKWDL
	qjEzJgUnCQLLJ45o0hDXLiM1Jius86Wjt/dDrgqoBHLoXOC7LZ4QjBbzIdJMmhX2tjXMq01jEMJ
	nGAJ6mqCy3qQ4S2ASfQufAUI=
X-Google-Smtp-Source: AGHT+IGLpTHusCG88E6aPMx5XgydXW/TqsLoxaZrUvpMn95f0fLXzfbFIT7BrF9m0X4BdLAf7NE9/Q==
X-Received: by 2002:a05:600c:3546:b0:459:dc99:51bf with SMTP id 5b1f17b1804b1-45b8557b680mr134917665e9.25.1756968984254;
        Wed, 03 Sep 2025 23:56:24 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d701622b92sm15256075f8f.58.2025.09.03.23.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:56:23 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 04 Sep 2025 09:55:52 +0300
Subject: [PATCH 2/3] phy: qcom-qmp: qserdes-com: Add some more v8 register
 offsets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-phy-qcom-edp-add-glymur-support-v1-2-e83c6b9a145b@linaro.org>
References: <20250904-phy-qcom-edp-add-glymur-support-v1-0-e83c6b9a145b@linaro.org>
In-Reply-To: <20250904-phy-qcom-edp-add-glymur-support-v1-0-e83c6b9a145b@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=jfzN/ldSxbD//tqugQGgHnEZ1hcjELAxuOulbu9UKOg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBouTgOvDY/6mTpV6oXDGupvZt038nd7Su5EthEU
 afAzIQ6deGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaLk4DgAKCRAbX0TJAJUV
 VqBkD/wJINCKAk++NiefvogMxEuq8c5BErQWHuAff0xOb2ncynGXwTa7lJlzFleG8HALLvmvQrY
 4EpsYSanHdOCAwqXFr2/tMw9gieUmFs6MfwqmLq0wKfb4uuGZN4175Nw1E0LatK4QjQ8UpSWU3P
 fO+z9H1z0bxMY+hahGQyF7Y4GQAEloAuopJ6Vx0p7UoKfY84lO8YnDmnZGkQUjlbWthg/PvT4EX
 bhrl/9opLDWgzxvIbvXFT/SYBXrMXVmYSxK9z2ZHNP58/8dZW7uKgyBfO49EXw06XHfHHwvsYI/
 BPSOD/qz+lpY8LH0YuCUNQylLFE5iNO/Kky7Uq8k0biBZaQU3eFUelZ2oKUDtguiqJPuXsxn/C1
 /bjA1dYaCldR65ukku9ynO4WpCIymYg6iyFPgNmqIcfbbgBx1pyo4hob9hRBUspJ6OtKCeNjIcW
 Bxi/qe3ExDH+lo7a43ygLaYWWr/jg39TtpmJk2fjsaKQTeiT6XX8tGkCLKqz3P+KrHNxkyL2YEL
 2sEZUJyAHe214CggoG7ZF2+MumhU16kVYDeHI5z86Jzzol7yv9Tpashb0s2KlgquCHE1cfQjsIq
 3nBGQ51BNSZlQ6WWjcS0ov54OcwMtKfcfV2q0XbbHY6jwZQcvKxWhVVMlSLO92FEY15B6XJpjRb
 wcU2c9MXLVpVJiw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add the missing v8 register offsets needed by the eDP/DP PHY driver.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h
index d3b2292257bc521cb66562a5b6bfae8dc8c92cc1..7143925fbeecd9586d27ffef98ed3e8a232f39e7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h
@@ -33,6 +33,7 @@
 #define QSERDES_V8_COM_CP_CTRL_MODE0			0x070
 #define QSERDES_V8_COM_PLL_RCTRL_MODE0			0x074
 #define QSERDES_V8_COM_PLL_CCTRL_MODE0			0x078
+#define QSERDES_V8_COM_CORECLK_DIV_MODE0		0x07c
 #define QSERDES_V8_COM_LOCK_CMP1_MODE0			0x080
 #define QSERDES_V8_COM_LOCK_CMP2_MODE0			0x084
 #define QSERDES_V8_COM_DEC_START_MODE0			0x088
@@ -40,25 +41,36 @@
 #define QSERDES_V8_COM_DIV_FRAC_START1_MODE0		0x090
 #define QSERDES_V8_COM_DIV_FRAC_START2_MODE0		0x094
 #define QSERDES_V8_COM_DIV_FRAC_START3_MODE0		0x098
+#define QSERDES_V8_COM_INTEGLOOP_GAIN0_MODE0		0x0a0
 #define QSERDES_V8_COM_VCO_TUNE1_MODE0			0x0a8
+#define QSERDES_V8_COM_INTEGLOOP_GAIN1_MODE0		0x0a4
 #define QSERDES_V8_COM_VCO_TUNE2_MODE0			0x0ac
 #define QSERDES_V8_COM_BG_TIMER				0x0bc
 #define QSERDES_V8_COM_SSC_EN_CENTER			0x0c0
+#define QSERDES_V8_COM_SSC_ADJ_PER1			0x0c4
 #define QSERDES_V8_COM_SSC_PER1				0x0cc
 #define QSERDES_V8_COM_SSC_PER2				0x0d0
 #define QSERDES_V8_COM_BIAS_EN_CLKBUFLR_EN		0x0dc
+#define QSERDES_V8_COM_CLK_ENABLE1			0x0e0
+#define QSERDES_V8_COM_SYS_CLK_CTRL			0x0e4
 #define QSERDES_V8_COM_SYSCLK_BUF_ENABLE		0x0e8
+#define QSERDES_V8_COM_PLL_IVCO				0x0f4
 #define QSERDES_V8_COM_SYSCLK_EN_SEL			0x110
 #define QSERDES_V8_COM_RESETSM_CNTRL			0x118
+#define QSERDES_V8_COM_LOCK_CMP_EN			0x120
 #define QSERDES_V8_COM_LOCK_CMP_CFG			0x124
+#define QSERDES_V8_COM_VCO_TUNE_CTRL			0x13c
 #define QSERDES_V8_COM_VCO_TUNE_MAP			0x140
+#define QSERDES_V8_COM_CLK_SELECT			0x164
 #define QSERDES_V8_COM_CORE_CLK_EN			0x170
 #define QSERDES_V8_COM_CMN_CONFIG_1			0x174
+#define QSERDES_V8_COM_SVS_MODE_CLK_SEL			0x180
 #define QSERDES_V8_COM_AUTO_GAIN_ADJ_CTRL_1		0x1a4
 #define QSERDES_V8_COM_AUTO_GAIN_ADJ_CTRL_2		0x1a8
 #define QSERDES_V8_COM_AUTO_GAIN_ADJ_CTRL_3		0x1ac
 #define QSERDES_V8_COM_ADDITIONAL_MISC			0x1b4
 #define QSERDES_V8_COM_CMN_STATUS			0x2c8
 #define QSERDES_V8_COM_C_READY_STATUS			0x2f0
+#define QSERDES_V8_COM_CLK_FWD_CONFIG_1			0x2f4
 
 #endif

-- 
2.45.2


