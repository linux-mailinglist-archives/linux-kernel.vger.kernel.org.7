Return-Path: <linux-kernel+bounces-605346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2967FA8A001
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 15:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC1019016D1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 13:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B1B2989B6;
	Tue, 15 Apr 2025 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QzSzgRl2"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC748192B81
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724888; cv=none; b=Ll60v6Ey0ubp/43Ivb9cFnLYJSs+ZeoYsN4ZYEn1FbKg7bVArkYaLXrqtBf4gVX6hz/Ju3entetObDOBVrGOKPv+MruOcWUttCp4WQ0mMPk4irtuTvGosUjGO2eI8yISFVnNpw7TLAo//oNE2QtL2fS8ivs1u6zQoc5x5bX/YrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724888; c=relaxed/simple;
	bh=fdVB/WDnUbOKrbnaFpC+5KLneXfwe1Hbvq+oQZ56p8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cFSq5ECX8LApQKHAu50+Epxte4yyk9a3D7ksEPSVO/aWYOVRsdJhP/Pc6mTquwq2V0QVlZ2BjQT40V3pX1L/oaG6EBc1YhQUtrID780tn2zB1vvedWcB5fbyoa2ztEN5UFNi8rjn6o3VFKy+nPYYrvW1rmKZMvrch2m8VH5Ot98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QzSzgRl2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso42023555e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 06:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744724883; x=1745329683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjNA/3yEeV6k5zGB03XZkp0NfQT5RQXMDZFss0yeJfc=;
        b=QzSzgRl2mW6UvALkCplQZf7lfklwB5nZAhsYA4NH+QrByOngIwE9hxR4/npCgYVQeg
         NN8eJri7ciU7tQ4y8LvrGDHvHBY7X1whUdfixKgXaZL5A5UQ2NL7gixfQD5PySHKsXYW
         4Wy0eQMZ7Ou5hYNUaaYBKL/QXTADlrZKmjgKKUfY4qRHGUo9wUPuFGqgCQHArkHcvOA/
         Dm7H3/L+sbx/C4V6OLhco1o4zKVQ1qPuNTJOeqvE1zj89NK+ZpIOptcOPnkfftmmG1Sg
         y135tw6XNe7mApVhfa9fpIVujYOf+A5MwuqLBZEh1ejHk2U+7w0ejFur9R4J8fzSPGcT
         9IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744724883; x=1745329683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjNA/3yEeV6k5zGB03XZkp0NfQT5RQXMDZFss0yeJfc=;
        b=HXhlIEOFMeskma04ZK9NpJJ/Ll6570GOuN1OKe3SbRnvJgrrdsvFseVEqQbtu7woRP
         mS/s5kyn+m4Mawkt2jTB7/VSwGqR7eX727+3NlMLl2De+wTGfJHPMGwzxfMYjk12REHx
         4tHvrnUPmtRZQfDMZViT76svwnuG2uXKoBYQ5PhvPHa3QBm4wTM3uzEN8ZFoYlZtsQXY
         FocfVHsdSWgrgdEUumttDY294JbP5s0HJurIvf6PN+4NaSRITL5lHhuhu70MWGw2CGO9
         jiIXyX5dyjs3jtxNxG6ThLMix3YgkGl9F6MS3v+uuSyMRMvZZGOBmY3xPbgcTUZQMnJz
         IIlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAaN/B7DtJyb6PYTULvLB/8a775i0YSepZEtDy3dRwP93nVN5L66nejO0INaKas084LzKQ9ytPtcnIFY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNBYgre2ACDrCAhonS4Nb6HGg7sPCNpu+VL2t5w7T1MjW6ys+3
	oFHUUl4L2bs2evYV7X2bnEQlyv+06dEN0RG7EB6JOcxul3TPWa2Bfzu+7zVG+eA=
X-Gm-Gg: ASbGncvji+NNNi+l4xuntlnCHytuq9wwpzLHrNErOfhPYYPNwVfQs8Mk+DuX0eEgkat
	BE5acfUkEOkOJoOUxamHJxBXApnpla7EL4hSNVMJIzMO3zHfJJ50DPwF8XT2WVHpZr53N69f1zj
	cckWapK09jubjRqDH/uPUmxgpmUSi/FmtMb0bZVnCBWX2/jVluAtgVJ+QllZom9n4WPxACv2TdN
	nU6nna3+tsdQk8gikKKCmK//C17R/3s1U8CG8Dt8IPAPlKiwg7rfiupQsdSxhWPxjRPJVkkB3K8
	5EBFYZFdC8hBfe2qUbVAxGw415hNR+UELfRGG2HHr3Zxc3qnAhv6Y9Sp+zMKVg==
X-Google-Smtp-Source: AGHT+IHwtmeKJgSljlrI2gdnG1lCG5/Q8u68/ZeTzxGPZ6Qgi0tbZCTFEksRkrA7PPWO9hcta2nGYQ==
X-Received: by 2002:a05:600c:1546:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-43f3a93cdeamr149800645e9.12.1744724882698;
        Tue, 15 Apr 2025 06:48:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d0fcsm210434195e9.19.2025.04.15.06.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 06:48:02 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 15 Apr 2025 15:47:57 +0200
Subject: [PATCH v6 5/7] media: platform: qcom/iris: add support for vpu33
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-topic-sm8x50-iris-v10-v6-5-8ad319094055@linaro.org>
References: <20250415-topic-sm8x50-iris-v10-v6-0-8ad319094055@linaro.org>
In-Reply-To: <20250415-topic-sm8x50-iris-v10-v6-0-8ad319094055@linaro.org>
To: Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8847;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=fdVB/WDnUbOKrbnaFpC+5KLneXfwe1Hbvq+oQZ56p8Q=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn/mOMw8dhG7gp7EC/6WMpJXB5TdVeiHQ5sZ5GeCAI
 344dZYeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ/5jjAAKCRB33NvayMhJ0SMLEA
 CtqajFkOjgN7gJf83X8Hk8VWSpGX0choZ6u97HIZMU+ot1Jn9hPjkzYolk5h8swWA3w/Ixa0aytF++
 nPyiHAgbwOus41b/XXrQpwnFdl7AnjK/4KhEsH0ueBHfTBApY+wJTHS5wU8ELqxiLuI8UJtr0pWEr7
 yN/ILObJQbamAGhH2sRyCv/L4JD/v5KIAzCHFM8K/YbubAloZHoooq79hBmkzry5WSYZtA/ilmCEG8
 V0fGGoEQk45nHXr2cZKQxzXywWvM4CaQzGWEtyRrNEHskuqpau3d075om224PO3K1EUyFYjopDTzSx
 wuJYL248TBcvzAWvk/cJrirTHsHmVGsG1sXoXir0eR5o9qUsCuwj+wZdyhR1aHD+uPwsOyGwRtpPTd
 d1mNoBiOsD9FjnN3eittZJwG5Lme9AyKaiB83KDNB6t8MfpQ8AKLe4nuvnAZ4QEqmNg1vfcIVTFw3D
 Hxufs3GEDyzk1BIc1L+zvZRK61h241vXWVXQw6hRX8uSt5adK3NUupd7ba1AvhVbbrRv9Qm3AX+0dO
 ZzBwVVbu/1tmh9ZYLzUN4Nj+TF/H+7zfCJ9X0GVhgYL2r8U30sOJlCYlpvLC2ULnL940Phzr9cAiWk
 cize7FaGF4AzkP19JmvJfCVMUaafYQVbISTg2PChyS0DgLUb3CkEk2sz/DTw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The IRIS acceleration found in the SM8650 platforms uses the vpu33
hardware version, and requires a slighly different reset and power off
sequences in order to properly get out of runtime suspend.

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # x1e Dell
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 160 ++++++++++++++++++++-
 drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
 2 files changed, 157 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
index 13dab61427b8bd0491b69a9bc5f5144d27d17362..9b7c9a1495ee2f51c60b1142b2ed4680ff798f0a 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
@@ -4,20 +4,39 @@
  */
 
 #include <linux/iopoll.h>
+#include <linux/reset.h>
 
 #include "iris_instance.h"
 #include "iris_vpu_common.h"
 #include "iris_vpu_register_defines.h"
 
+#define WRAPPER_TZ_BASE_OFFS			0x000C0000
+#define AON_BASE_OFFS				0x000E0000
 #define AON_MVP_NOC_RESET			0x0001F000
 
+#define WRAPPER_DEBUG_BRIDGE_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x54)
+#define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
+#define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
+#define REQ_POWER_DOWN_PREP			BIT(0)
+#define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
 #define WRAPPER_CORE_CLOCK_CONFIG		(WRAPPER_BASE_OFFS + 0x88)
 #define CORE_CLK_RUN				0x0
 
+#define WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG		(WRAPPER_TZ_BASE_OFFS + 0x14)
+#define CTL_AXI_CLK_HALT			BIT(0)
+#define CTL_CLK_HALT				BIT(1)
+
+#define WRAPPER_TZ_QNS4PDXFIFO_RESET		(WRAPPER_TZ_BASE_OFFS + 0x18)
+#define RESET_HIGH				BIT(0)
+
 #define CPU_CS_AHB_BRIDGE_SYNC_RESET		(CPU_CS_BASE_OFFS + 0x160)
 #define CORE_BRIDGE_SW_RESET			BIT(0)
 #define CORE_BRIDGE_HW_RESET_DISABLE		BIT(1)
 
+#define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
+#define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
+#define MSK_CORE_POWER_ON			BIT(1)
+
 #define AON_WRAPPER_MVP_NOC_RESET_REQ		(AON_MVP_NOC_RESET + 0x000)
 #define VIDEO_NOC_RESET_REQ			(BIT(0) | BIT(1))
 
@@ -25,7 +44,16 @@
 
 #define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
 
-static bool iris_vpu3_hw_power_collapsed(struct iris_core *core)
+#define AON_WRAPPER_MVP_NOC_LPI_CONTROL		(AON_BASE_OFFS)
+#define AON_WRAPPER_MVP_NOC_LPI_STATUS		(AON_BASE_OFFS + 0x4)
+
+#define AON_WRAPPER_MVP_NOC_CORE_SW_RESET	(AON_BASE_OFFS + 0x18)
+#define SW_RESET				BIT(0)
+#define AON_WRAPPER_MVP_NOC_CORE_CLK_CONTROL	(AON_BASE_OFFS + 0x20)
+#define NOC_HALT				BIT(0)
+#define AON_WRAPPER_SPARE			(AON_BASE_OFFS + 0x28)
+
+static bool iris_vpu3x_hw_power_collapsed(struct iris_core *core)
 {
 	u32 value, pwr_status;
 
@@ -40,7 +68,7 @@ static void iris_vpu3_power_off_hardware(struct iris_core *core)
 	u32 reg_val = 0, value, i;
 	int ret;
 
-	if (iris_vpu3_hw_power_collapsed(core))
+	if (iris_vpu3x_hw_power_collapsed(core))
 		goto disable_power;
 
 	dev_err(core->dev, "video hw is power on\n");
@@ -79,7 +107,125 @@ static void iris_vpu3_power_off_hardware(struct iris_core *core)
 	iris_vpu_power_off_hw(core);
 }
 
-static u64 iris_vpu3_calculate_frequency(struct iris_inst *inst, size_t data_size)
+static void iris_vpu33_power_off_hardware(struct iris_core *core)
+{
+	u32 reg_val = 0, value, i;
+	int ret;
+
+	if (iris_vpu3x_hw_power_collapsed(core))
+		goto disable_power;
+
+	dev_err(core->dev, "video hw is power on\n");
+
+	value = readl(core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+	if (value)
+		writel(CORE_CLK_RUN, core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+
+	for (i = 0; i < core->iris_platform_data->num_vpp_pipe; i++) {
+		ret = readl_poll_timeout(core->reg_base + VCODEC_SS_IDLE_STATUSN + 4 * i,
+					 reg_val, reg_val & 0x400000, 2000, 20000);
+		if (ret)
+			goto disable_power;
+	}
+
+	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS,
+				 reg_val, reg_val & BIT(0), 200, 2000);
+	if (ret)
+		goto disable_power;
+
+	/* set MNoC to low power, set PD_NOC_QREQ (bit 0) */
+	writel(BIT(0), core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+
+	writel(CORE_BRIDGE_SW_RESET | CORE_BRIDGE_HW_RESET_DISABLE,
+	       core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+
+disable_power:
+	iris_vpu_power_off_hw(core);
+}
+
+static int iris_vpu33_power_off_controller(struct iris_core *core)
+{
+	u32 xo_rst_tbl_size = core->iris_platform_data->controller_rst_tbl_size;
+	u32 clk_rst_tbl_size = core->iris_platform_data->clk_rst_tbl_size;
+	u32 val = 0;
+	int ret;
+
+	writel(MSK_SIGNAL_FROM_TENSILICA | MSK_CORE_POWER_ON, core->reg_base + CPU_CS_X2RPMH);
+
+	writel(REQ_POWER_DOWN_PREP, core->reg_base + WRAPPER_IRIS_CPU_NOC_LPI_CONTROL);
+
+	ret = readl_poll_timeout(core->reg_base + WRAPPER_IRIS_CPU_NOC_LPI_STATUS,
+				 val, val & BIT(0), 200, 2000);
+	if (ret)
+		goto disable_power;
+
+	writel(0x0, core->reg_base + WRAPPER_DEBUG_BRIDGE_LPI_CONTROL);
+
+	ret = readl_poll_timeout(core->reg_base + WRAPPER_DEBUG_BRIDGE_LPI_STATUS,
+				 val, val == 0, 200, 2000);
+	if (ret)
+		goto disable_power;
+
+	writel(CTL_AXI_CLK_HALT | CTL_CLK_HALT,
+	       core->reg_base + WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG);
+	writel(RESET_HIGH, core->reg_base + WRAPPER_TZ_QNS4PDXFIFO_RESET);
+	writel(0x0, core->reg_base + WRAPPER_TZ_QNS4PDXFIFO_RESET);
+	writel(0x0, core->reg_base + WRAPPER_TZ_CTL_AXI_CLOCK_CONFIG);
+
+	reset_control_bulk_reset(clk_rst_tbl_size, core->resets);
+
+	/* Disable MVP NoC clock */
+	val = readl(core->reg_base + AON_WRAPPER_MVP_NOC_CORE_CLK_CONTROL);
+	val |= NOC_HALT;
+	writel(val, core->reg_base + AON_WRAPPER_MVP_NOC_CORE_CLK_CONTROL);
+
+	/* enable MVP NoC reset */
+	val = readl(core->reg_base + AON_WRAPPER_MVP_NOC_CORE_SW_RESET);
+	val |= SW_RESET;
+	writel(val, core->reg_base + AON_WRAPPER_MVP_NOC_CORE_SW_RESET);
+
+	/* poll AON spare register bit0 to become zero with 50ms timeout */
+	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_SPARE,
+				 val, (val & BIT(0)) == 0, 1000, 50000);
+	if (ret)
+		goto disable_power;
+
+	/* enable bit(1) to avoid cvp noc xo reset */
+	val = readl(core->reg_base + AON_WRAPPER_SPARE);
+	val |= BIT(1);
+	writel(val, core->reg_base + AON_WRAPPER_SPARE);
+
+	reset_control_bulk_assert(xo_rst_tbl_size, core->controller_resets);
+
+	/* De-assert MVP NoC reset */
+	val = readl(core->reg_base + AON_WRAPPER_MVP_NOC_CORE_SW_RESET);
+	val &= ~SW_RESET;
+	writel(val, core->reg_base + AON_WRAPPER_MVP_NOC_CORE_SW_RESET);
+
+	usleep_range(80, 100);
+
+	reset_control_bulk_deassert(xo_rst_tbl_size, core->controller_resets);
+
+	/* reset AON spare register */
+	writel(0, core->reg_base + AON_WRAPPER_SPARE);
+
+	/* Enable MVP NoC clock */
+	val = readl(core->reg_base + AON_WRAPPER_MVP_NOC_CORE_CLK_CONTROL);
+	val &= ~NOC_HALT;
+	writel(val, core->reg_base + AON_WRAPPER_MVP_NOC_CORE_CLK_CONTROL);
+
+	iris_disable_unprepare_clock(core, IRIS_CTRL_CLK);
+
+disable_power:
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
+	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+
+	return 0;
+}
+
+static u64 iris_vpu3x_calculate_frequency(struct iris_inst *inst, size_t data_size)
 {
 	struct platform_inst_caps *caps = inst->core->iris_platform_data->inst_caps;
 	struct v4l2_format *inp_f = inst->fmt_src;
@@ -119,5 +265,11 @@ static u64 iris_vpu3_calculate_frequency(struct iris_inst *inst, size_t data_siz
 const struct vpu_ops iris_vpu3_ops = {
 	.power_off_hw = iris_vpu3_power_off_hardware,
 	.power_off_controller = iris_vpu_power_off_controller,
-	.calc_freq = iris_vpu3_calculate_frequency,
+	.calc_freq = iris_vpu3x_calculate_frequency,
+};
+
+const struct vpu_ops iris_vpu33_ops = {
+	.power_off_hw = iris_vpu33_power_off_hardware,
+	.power_off_controller = iris_vpu33_power_off_controller,
+	.calc_freq = iris_vpu3x_calculate_frequency,
 };
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
index f8965661c602f990d5a7057565f79df4112d097e..93b7fa27be3bfa1cf6a3e83cc192cdb89d63575f 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
@@ -10,6 +10,7 @@ struct iris_core;
 
 extern const struct vpu_ops iris_vpu2_ops;
 extern const struct vpu_ops iris_vpu3_ops;
+extern const struct vpu_ops iris_vpu33_ops;
 
 struct vpu_ops {
 	void (*power_off_hw)(struct iris_core *core);

-- 
2.34.1


