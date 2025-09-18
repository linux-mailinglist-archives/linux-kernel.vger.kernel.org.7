Return-Path: <linux-kernel+bounces-807809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C415BB4A99B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6281170707
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEC731C598;
	Tue,  9 Sep 2025 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HlhYB0Gh"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784DD31B83E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412496; cv=none; b=pJs3PpV9XDPe4iy66nCma5YlaJ6jlhDV87/0XJCgpLnfNatrXi08t3hOP1ACWwLilgWHi7iwwlmFBCNl6U9XFwSBNnqa5aGpGo0lluCsgIQVrryh3qO67O02E2w4wKNM07w3oozdYqlilJVJo2NnsQw1ieI5xeH/esjH1bDF9UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412496; c=relaxed/simple;
	bh=gd1/rQkOQZirFl18UzwZn/2cQtSjOyfCl1f0XILU2M8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=temo0MgHhc2CiwCMuUGweSse/BPObvIDBHLOqf/JEvao/2LVFQtWX9kfW3DiZXH3uAzkz/F85pxYGKEOk3jIcr6c4Ya0WwzaCYUhPxMdkVTHEISnmA9RvIXXZc95/qWMU2V34Dms2UwfG91xLyleytWkQ3+DTXkpGkI/QIv2nCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HlhYB0Gh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62598fcf41aso4259066a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757412492; x=1758017292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sIRaBk6vLQ8eD3uXidohEVpaoFfNVP9QHYmf2WgbQY=;
        b=HlhYB0GhFvHI/D/3jwPA/0gft6HZ68PUBHDF/mrn5L9CZq+wj446pQAk/8ezvlTLZW
         7R5ylQzGgQV/VfiH2XRKLYkNWQFBgsqK1NIxsW2PSmLkyrJzd6WP5fHRtopzqjxQWj2Z
         G4T0Qic6O3CYPinyEv1M/Fr933qQGi4exX4TGHUZ5rFOt588VDG5vo2UYsEWCdHANzcf
         XddkEnB9QqJofa4wCTw36pKRNYSyINYGpWmi5P00wSJYKs5MJRBdE+yurckOQ7t5de+R
         8HQWXxEO6ilW1RYIKNfleWLs4Q6OycHyVin1DEnnRrvMGCV6sBUdAsxBWUb9VNurN0zm
         1Keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412492; x=1758017292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sIRaBk6vLQ8eD3uXidohEVpaoFfNVP9QHYmf2WgbQY=;
        b=GcOdFH9KjuASlvEqkwvypH8+E6v2/zz9r9nqtsPxGFdCYOaTE6ry0n5gwQHM9Hv3q2
         58ga3O6zHcNoKDYWakQZCq95WBZee8k0dNb5xDjBNAWRoszRbUcmBymhaW51a0iLQmcs
         HnSpkVfzfQsCQSjgO4FY9H6BpD165JdeUIn5mrLIaGohflEXgREfgEz4dTU9xgLffUo+
         DUWl9zP5caFmJjAXtYlRGeC3FBotCRXbauXVFUxT0SWieqpLQRh4tB51u+fM5fqlaVxQ
         FEM7ejRkIObGYK6tuu3sZx160bp5jczfN6a1rpOHTMsPujPfqSS121XctfSeCfYXsPxK
         YqTg==
X-Forwarded-Encrypted: i=1; AJvYcCVS9zgRmML72n2obvU5Hr53O6ntYdUzyU0tRFJjfL3gtXbHok2R6q+hUpOaK4S0Qz5LSToZkgnSjjVv3mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGQtuRdm3epbJuMmu7h8YJagBcqlCQ/dbbYNenDHshIRW54AnU
	2C18fOxLCGQJnd1RstwldYWvjnhN7h/ojEiqkmeC3BxS2NXLe9+j7KCyROsvkXUg7HY=
X-Gm-Gg: ASbGncuANGl1tCFbcXAy4qC+AokuwPIUQ6yT//HOChhM7ku3upjmufeoDlaQJSwFf5K
	gW2Dv0ns1NN7Ewolf1gmYEczy2y/GAEXbmhixq6acE6Qd3mQ3OYheTVjh450nPD+4LRQuvspMNN
	USEZ8OmqzS8CGwkO9/QQMHxi06nczJvHnhVDO5PVTclvcXqiiqP8xhX7oMQi/wFXYfdZGEPz2dz
	t/5e87LUX4CwFx+udgiSUCvyANG5I+WTVDQuZVagTBBoUN8G1HN7RkpfVjLy8vTlgu5+JrjIdtM
	d5yJw3U/twWlJwG2xWBP/SLqIx2k7IYFevT3Vgcs1h8pdRhU8nm1sBIoKdJcYLy98U5qCUXFkEr
	UNhZA1S2O2+ByiCfTr8/e68suUkQELPRnZEA1ib0W6IjM
X-Google-Smtp-Source: AGHT+IG7P3FlTuDA+XmbsLkCjJ6D49ial374EyPCI74HQC/n+6HFLuSoKA47dmacX/A7pwMohgLIIg==
X-Received: by 2002:a05:6402:42c5:b0:61c:29e:db04 with SMTP id 4fb4d7f45d1cf-623725eda00mr11673342a12.6.1757412491857;
        Tue, 09 Sep 2025 03:08:11 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c018f65afsm965379a12.41.2025.09.09.03.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:08:10 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 09 Sep 2025 13:07:27 +0300
Subject: [PATCH v2 2/3] phy: qcom-qmp: qserdes-com: Add v8 DP-specific
 qserdes register offsets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-phy-qcom-edp-add-glymur-support-v2-2-02553381e47d@linaro.org>
References: <20250909-phy-qcom-edp-add-glymur-support-v2-0-02553381e47d@linaro.org>
In-Reply-To: <20250909-phy-qcom-edp-add-glymur-support-v2-0-02553381e47d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3063; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=gd1/rQkOQZirFl18UzwZn/2cQtSjOyfCl1f0XILU2M8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBov/yC3QqdbF6klANBZsX+CL1kBvV8fZ9czoaLo
 8esOnAp3+SJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaL/8ggAKCRAbX0TJAJUV
 Vui9D/9WVfDQazxzor8ykuyAa8Ck9zuEDfFCAwSGCfz/kWIKl2NOkAczaNvidpm3IUSBmQo6xD/
 pONPPtlVMlqWUYDhcOi3Ch2x1hSsa5roCxfCqLGRCkAzp7KSklCGsE4tICymSN2KxHCRTswLkXS
 QdzZSLG7gqZioIfnxnGI04QasWGHiyID6z6+99UAkPF8FSvB8BxX7Cd+5hN436Vzc8GvlVrXE3f
 6ki/4RpOZk3z6yw9y4nPbZFI+RgjvbCdnvdaodmRXomhaYordCP+NlWJ+GEWrMADgLNiya+OWA1
 7q8C/GIrDpXiaQXeJlMUFsNuh0gf0fwDVaFxh4kM8nF+52nSy6++IXXlnoHyOcw2uui3DMlHFeR
 6uxcoJVYRZvICEGqTxp66HAAGolJrohH6kYFtO3sSypoSECDufpdqaf6fzX1Woq5x9nGni33FX0
 WfhzOcNYccZNte1dcGF1rHSyvsRm3TsmUNVjUn29TPHdVU4qkLu5RH0sHp7HhyvvXHkspE25Sj1
 HHimCuHcRWXv4tw3edqI8GCSAZvyqdWYAe73mUzj+Yb5GaXZfkfJVanU/L4NoBsrj0BK5R3oN1/
 a8Cf55dbHWRXFSI3OKZshAWOAe8D/bmIS3lQgYUzinFPomhZbMrSqyKm09qhYhZh2svaAh8ZYo5
 g6LDF1wW2PZ4NYg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Starting with Glymur, the PCIe and DP PHYs qserdes register offsets differ
for the same version number. So in order to be able to differentiate
between them, add these ones with DP prefix.

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


