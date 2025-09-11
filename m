Return-Path: <linux-kernel+bounces-812315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D21DEB53627
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA591888879
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A082B3469F3;
	Thu, 11 Sep 2025 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YtChM1VT"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4883451D1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601950; cv=none; b=SgaP2tvia/xE5b2tYDlnSUKF4usaDB9V9pl8VtSpk+dpF1p6TNyO6r1CKPy8GXqSd/rmiilZzlJ8MGDK/L6z4iSZ+hMTOyAz2uer+fLeMH4IZUhQ/gDhC0kVZtcobJgSuRhJWCFq7ixDgb1ZQP7A4t+odKVn0UWXRIKqxJfsSu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601950; c=relaxed/simple;
	bh=hHQLYPrS95HhfGu/5yJz6rF+PZQQgVsSP41YzrqnMf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gsuCqAELEi5hkKFmZiFvygfKLMMJ8L9rtdQOs0ZuSLUb/EYeRqhUP2Y3lCkNzaIaxaVfCjqoe9bCSA3tlksUZx4u6zBheKDLqVShpf+CtC1/ZaMj5SXdRrjm6jg8+2IGqf9W1U4MeJlWhPxYOZOI3hyThEW0Sc/ut8h9L7vUTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YtChM1VT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b04271cfc3eso104265566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757601947; x=1758206747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xj8+ODxk5TPgmrm1epN9Zg+MtdZ3FT1uQ44Z3bdR4/c=;
        b=YtChM1VTajPtiKvk/rtoVflJms7mj7LudFZUXLbEOGiUSd1oa79krTcC4ub0iiGajn
         SNgPmekMh9PT6Gw6l8Mr162wRPK72CXgmPFQgPSuEBFuUmr7djjEW9RlbCT0ujfsyzyb
         l2z+dJQB5KH772cN1j7yomQZpu7+b80qsXW8kTkEoZBq2Q2Yr2s4aMZYMcbLrCuqc1Mp
         96VZk/MQBjtCK8pHgx220KjpzZU6dXCbA0L+FCeP2g2CFqI2fz+W/aemzLif5/5WkXiP
         gLYz08couAFT8x5V5gjnJ+fIwaB6pOmKdt2ciZ0dx3dlaGQnpyrBO31+AJdrXh1h4nUt
         JAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757601947; x=1758206747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xj8+ODxk5TPgmrm1epN9Zg+MtdZ3FT1uQ44Z3bdR4/c=;
        b=ZVtAH8XeKh2nOK5GOIzBRt0eDGyb8/wl42rm8XfLh1EMPVi+VrunYxUgvy/fgy029l
         lCe65/FIwuNf76i4lwf+2p/WEMMwRLaiixtPiOIW5SUnJ/6DrI5oHWllMwIyk9zALg32
         7ws7to6KMGf/I0QjYN5Z5f9KbAbtK/kXQsCNeClUYPyO/milEwJ7dWAYvBzHzeREHbPI
         J38BsK4UxHI46GwPYigz1vyjjjg+MByVZwHSUMgtyVGPRQO6l1GJ9Lq0Xy7+uMcu+hnN
         EhzB2IVnsCtTHREnC+Vd4pTVUuP0DfUm/A0HLZdwlnTszyWQDWvOBC3bgljYz/H7Wofy
         l0wA==
X-Forwarded-Encrypted: i=1; AJvYcCX0PtU/5TVF0DZGeljImE9wHq4Zp2PyeVA9YpFEeo9diWaxOv5HoWkGmtIBJE8JnLCScMlZvqN8qh0sh4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5y5Zkwye4BGg09vR1Xu7QOpWkjBBKrdy5tYjKY8NgXXfXNifw
	epXULnbNJu8OwNDZisS/qU5hKsbUB2QQilE3jhsPxkEM2M32MY8euLfhfImZMOOa2II=
X-Gm-Gg: ASbGncsWjtTh1QB54CT+9B0uPUHTBv94+QUouZSf8jiQiPCXUAzJCkbOG9qcj3CnW9i
	VL/pMWHwUXWPc+jGt9I7xFy5j601sB91tacElWd7w1sbqU3BMgSYsW2T/cvjR90/W0qyMis8MLy
	PQBzesaHQvw1cwnNhTcVv2Ni1klh8q/dRM2C5TEd04iEB09Ws3LOKvH6573chO2e1rvpEiQ81UG
	Rowy91s5KjECA8WT1ZDR0ZpseJ3UudUE3gC+h2hQDzCE0litp+hXpJYBufuYt2ncfYswJs6l8gU
	CfBvNyITokJSrY+/sFfgH8GmMlFOMFOZD+nsQU275JKt6/ttQX2lNb4/2F18XWCKRQoYsr0E/S1
	1WmoxhX24z1hYkmjseAP9gZ6ROkXEDiQGAQ==
X-Google-Smtp-Source: AGHT+IGkALLpWTe3A8RNhgP0uFdtVHraWmoT4jDSLkYh5kEm44UzmREGpHh3iFHLZsyP0xNJwzIkSA==
X-Received: by 2002:a17:906:4910:b0:b07:880c:145a with SMTP id a640c23a62f3a-b07880c14c2mr560536066b.55.1757601947220;
        Thu, 11 Sep 2025 07:45:47 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31282e7sm147196266b.23.2025.09.11.07.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 07:45:46 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 11 Sep 2025 17:45:24 +0300
Subject: [PATCH v3 3/4] phy: qcom-qmp: qserdes-com: Add v8 DP-specific
 qserdes register offsets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-phy-qcom-edp-add-glymur-support-v3-3-1c8514313a16@linaro.org>
References: <20250911-phy-qcom-edp-add-glymur-support-v3-0-1c8514313a16@linaro.org>
In-Reply-To: <20250911-phy-qcom-edp-add-glymur-support-v3-0-1c8514313a16@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3130; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=hHQLYPrS95HhfGu/5yJz6rF+PZQQgVsSP41YzrqnMf4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBowuCRH6z1M9ZM9ZaMTneqmIBMUwkkH/Rm3J46W
 VSbWcYEXWqJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaMLgkQAKCRAbX0TJAJUV
 Vky8D/4xUcAwz/9INS6hx17pBLcIJ27QhH/9ni3u7g+9jubACJ4SDt8qnk124AGe/aEcSs14e7J
 DQtD+FMHsCRv7vRKKbbSaWTHhfULnVIRQDszqSE13G0nj44oVe+oTG3289fhcxjQxNEiVzR/bCX
 z4tEbsGo7Q3kNCkVfo4HSo249GFwuY1Vew0w8DyD0gKMm8v1JcN3/VyFy92cQ5pl+LqupWnMXN5
 pbuAAcqlrI+5OLeONR5jpdif/xGwG5kk6ttATn/isPlleo7p5fk6taCOQxWDRH0WNoMX2dEtQIw
 vBnSWlQw2iNC1gHu6kt9e1zcgUjkTxj3QV01asDJ2JwxdRz8xirzZ0iICJG4NIuI7+j/7EAYjnj
 GJ1XYlL7FtsKNy7OJrt0ne6ZHB8vXdCy62Q4qTyXnBfAmBMK+l2P+T930whYQipniv0XbB6C4Zm
 h1Z6ltjSplscLuw2h4AQ63TVvW0CEEu2JErQhoyMqzZm7XCe3NtLz2IsowgeHfKVe6+w7OF6/y3
 +KJZqQVzd6l4V5EYSSyYCF/in4pwXTm3hdazcYKiVqPXqmJ6+4gHG26W6QXzCDkwi+qCsLT2S6m
 e4O3r0KFYq9oyd8TDgmKmCd5gvoYvY4QWc9gfjHSXpuM1Jldc2M4iy272pYqw+0s5pmbfAyAr38
 IU4E8k9DdkFAGrg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Starting with Glymur, the PCIe and DP PHYs qserdes register offsets differ
for the same version number. So in order to be able to differentiate
between them, add these ones with DP prefix.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h  | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h b/drivers/phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h
new file mode 100644
index 0000000000000000000000000000000000000000..2bef1eecdc56a75e954ebdbcd168ab7306be1302
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2025 Linaro Ltd.
+ */
+
+#ifndef QCOM_PHY_QMP_DP_QSERDES_COM_V8_H_
+#define QCOM_PHY_QMP_DP_QSERDES_COM_V8_H_
+
+/* Only for DP QMP V8 PHY - QSERDES COM registers */
+#define DP_QSERDES_V8_COM_HSCLK_SEL_1			0x03c
+#define DP_QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE1_MODE0	0x058
+#define DP_QSERDES_V8_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x05c
+#define DP_QSERDES_V8_COM_SSC_STEP_SIZE1_MODE0		0x060
+#define DP_QSERDES_V8_COM_SSC_STEP_SIZE2_MODE0		0x064
+#define DP_QSERDES_V8_COM_CP_CTRL_MODE0			0x070
+#define DP_QSERDES_V8_COM_PLL_RCTRL_MODE0		0x074
+#define DP_QSERDES_V8_COM_PLL_CCTRL_MODE0		0x078
+#define DP_QSERDES_V8_COM_CORECLK_DIV_MODE0		0x07c
+#define DP_QSERDES_V8_COM_LOCK_CMP1_MODE0		0x080
+#define DP_QSERDES_V8_COM_LOCK_CMP2_MODE0		0x084
+#define DP_QSERDES_V8_COM_DEC_START_MODE0		0x088
+#define DP_QSERDES_V8_COM_DIV_FRAC_START1_MODE0		0x090
+#define DP_QSERDES_V8_COM_DIV_FRAC_START2_MODE0		0x094
+#define DP_QSERDES_V8_COM_DIV_FRAC_START3_MODE0		0x098
+#define DP_QSERDES_V8_COM_INTEGLOOP_GAIN0_MODE0		0x0a0
+#define DP_QSERDES_V8_COM_VCO_TUNE1_MODE0		0x0a8
+#define DP_QSERDES_V8_COM_INTEGLOOP_GAIN1_MODE0		0x0a4
+#define DP_QSERDES_V8_COM_VCO_TUNE2_MODE0		0x0ac
+#define DP_QSERDES_V8_COM_BG_TIMER			0x0bc
+#define DP_QSERDES_V8_COM_SSC_EN_CENTER			0x0c0
+#define DP_QSERDES_V8_COM_SSC_ADJ_PER1			0x0c4
+#define DP_QSERDES_V8_COM_SSC_PER1			0x0cc
+#define DP_QSERDES_V8_COM_SSC_PER2			0x0d0
+#define DP_QSERDES_V8_COM_BIAS_EN_CLKBUFLR_EN		0x0dc
+#define DP_QSERDES_V8_COM_CLK_ENABLE1			0x0e0
+#define DP_QSERDES_V8_COM_SYS_CLK_CTRL			0x0e4
+#define DP_QSERDES_V8_COM_SYSCLK_BUF_ENABLE		0x0e8
+#define DP_QSERDES_V8_COM_PLL_IVCO			0x0f4
+#define DP_QSERDES_V8_COM_SYSCLK_EN_SEL			0x110
+#define DP_QSERDES_V8_COM_RESETSM_CNTRL			0x118
+#define DP_QSERDES_V8_COM_LOCK_CMP_EN			0x120
+#define DP_QSERDES_V8_COM_VCO_TUNE_CTRL			0x13c
+#define DP_QSERDES_V8_COM_VCO_TUNE_MAP			0x140
+#define DP_QSERDES_V8_COM_CLK_SELECT			0x164
+#define DP_QSERDES_V8_COM_CORE_CLK_EN			0x170
+#define DP_QSERDES_V8_COM_CMN_CONFIG_1			0x174
+#define DP_QSERDES_V8_COM_SVS_MODE_CLK_SEL		0x180
+#define DP_QSERDES_V8_COM_CLK_FWD_CONFIG_1		0x2f4
+#define DP_QSERDES_V8_COM_CMN_STATUS			0x314
+#define DP_QSERDES_V8_COM_C_READY_STATUS		0x33c
+
+#endif

-- 
2.45.2


