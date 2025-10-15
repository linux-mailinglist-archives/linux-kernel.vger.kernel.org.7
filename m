Return-Path: <linux-kernel+bounces-854591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A526BDECED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD89C48325F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5541E24E4BD;
	Wed, 15 Oct 2025 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yw/Jhg2Q"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C1D199E94
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535812; cv=none; b=hMjjWFa1sbz8SZ+EKIVgJTp7v+KpXs+kzPb/O8UZwqwAkpG+BTWnyiO2erZqAr2NI/aDBVECcq+NHIFEAHnsD1CwYc+qFIvC9H/lhGdyDMS0Y7ff1IA2hSqblRSTT7HOCR/ZKkddKPMQY9SIRp8RCkCixjsLR9hhJQGhy0Ecg/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535812; c=relaxed/simple;
	bh=hDyc9oMypUvZah5yy7M2nEL/OkN7nQfGT80oOv3HFeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZCzGWrVYjQwvmoxHVEjXtXRMSm83trCwuwG1lhcu0/XzznurrjQEdiu3WviuSpnq7p2BpSeWlw0XeNhlfBMyHx1+puzUN+km+MGi1NTqW8iKx50+2SkilrcfVBQlijDpbEEedjRAYho23Kb31YdMIDSRViZm6AZsfEEgsZcoSW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yw/Jhg2Q; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso5719652f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760535808; x=1761140608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPOcqrHoAC0pIWNV4V+SfzH8kNwkAKjv45j4Ggbs9iE=;
        b=yw/Jhg2QVJcPNT3vU1DiENTk/trRGszhBNW5iZtFNh56t1yN9UjZwV2Xq6tjyd4f7y
         1z/Evf8gjbQ3TgeyuEHAhgwCSIdXtUOwdSv7cCbJilYynSbhzt3erk1szaCnh8zcG+y2
         3rJbXV6yz41G01cpx8xzILS/mrTFzn6EX6y9lc20lgqG/IeNKaoYHqUyvYaXkszItlqq
         HeWaaPnK2Q7xqvoO4bfLcrE4v2/0QCAIOTzg1gUrm2PAwhBP734hOpnzyR3e2qR4yDfK
         rTVs5tLpJZFoof0vl5WhLDhCEbmNm7+V3iDKfF7MywYEE3gVEZaIOZMkRdik5snmWswI
         rg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760535808; x=1761140608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPOcqrHoAC0pIWNV4V+SfzH8kNwkAKjv45j4Ggbs9iE=;
        b=Fp+FrkTQNmm9Q5K0oEb8uAsRQePoe8A1779B3aFjDbwM7DlVaChcE/MjQGoEU6mmGO
         mCouWPP1eaBgbo0yH9CQPVmVQz9RZg9Tdo34XZXNet9DxLdkWDHt5QoWzkGOVbTw+u7f
         wO2b+OMyZ/+I1Ck2G7Arsa0g+3x2lYxuvH0fe9BGuOawqyC+zwK9NvHsMnzuNmTZc2hU
         6qfTGSvWOxK1LLEYxl6c53HejMFE1ukybOsh7wuFlSIJdYDhBfb9ORHdFVj/UFpN4myW
         8XFk8Ia0t8WLo2SDppo3kw5hZ6TRNqYsM9SeELAcGNADhQsgAnqFjMFHlsqgF4KoFvZx
         1bVw==
X-Forwarded-Encrypted: i=1; AJvYcCWoB3lxmIEeHnhuSb3D6TBE3udC3rBEUQWX7NUFoHDeVwoTC188/IJ5R8Qc18Tx47Z+cSNIeJXbbCUA9dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMjbY+PCTdvV0u0zLovBRBVAYUJpB+/3x89LsdBrT8nzx9MaOG
	7JgIYIQDZBcWbYJyYCoF7+xwyJ4w5kx+8gRoGlPORVJWI2Q2qY2Bd7xVmEWPThqOiFY=
X-Gm-Gg: ASbGncv3phzI0JXGOfjoyP6FRJMr/aqI5d15MnHzNOfFae/UquRPqMQzvfkS+N/ZJ2X
	oYuQnltMtqYJbu9kaEj+0wmbCNnM6MMDXB+8BnmJwzO6jMf8ILGFXhmpAWf2jeIcdBzlzPLi//H
	deZzZKyFn2Vd45rQtfIIuzNjGnWU7J8bawKeQFyFvhAUUEzdCr+wYaGWR/2cJxlEU7P4GEMzFuM
	0DhF2vycrHyPIkz2INxDW7317QycJ5NnorNIqIqRKL+W+Sc+gMjNq30GIYI9BH2eVgPjQGNAbTl
	TDU2a8pLOK50Bj6LTSpL7m5BSTvnVgZuCIla8Cwk0lQv5+rUTFmciR5Nq85UroHX7BRY3qV0PKf
	MLf1agpmBuG8YNfnInBl29juVYShJqTpm7Jt8lkIoLec=
X-Google-Smtp-Source: AGHT+IH5nePTE53pHld2Sv5dcJlhv6pAzkVfdu25NMHubXSnvoEtpHJoJrj6fKK8sk5BAorl+dF75Q==
X-Received: by 2002:a05:6000:1863:b0:40e:604:8e29 with SMTP id ffacd0b85a97d-4266e7bf05dmr18232349f8f.15.1760535807748;
        Wed, 15 Oct 2025 06:43:27 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3d2d65sm174180795e9.2.2025.10.15.06.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:43:26 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 15 Oct 2025 16:42:55 +0300
Subject: [PATCH 2/2] phy: qcom: qmp-pcie: Add support for Glymur PCIe
 Gen4x2 PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-phy-qcom-pcie-add-glymur-v1-2-1af8fd14f033@linaro.org>
References: <20251015-phy-qcom-pcie-add-glymur-v1-0-1af8fd14f033@linaro.org>
In-Reply-To: <20251015-phy-qcom-pcie-add-glymur-v1-0-1af8fd14f033@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Wenbin Yao <wenbin.yao@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2674; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=hDyc9oMypUvZah5yy7M2nEL/OkN7nQfGT80oOv3HFeM=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo76Tz246TVdgYwl7XyaA1hooKuk1gfiyCLjkrL
 veKksGRQV+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaO+k8wAKCRAbX0TJAJUV
 VnE+EACgHF6z44JrMDOGOXuJHtM06s2ipBDBhaxlkkuI4rpJK+VE3FluKrAZOwaVdWOM14W+Iq1
 EYT5fytjGVAXUEG9L9xMkkR0PD3PnG3a3U9uy8vQptZmi21m/MoSbGAtLiL+3/eMu0cCNSOMlbF
 01vp7QwZM2m0C3yg7yO8G5qxfEhPjqtUXjlQ+YLRiaYajeGgdO0GcQ5Qa1s5MWLjDyB85c5fxUI
 37Dg3/cwtRxt2/L7+lxQEAojifm1NttjKoLn/BB6WFU8QYxYrba7xtQQiBBBvXfMeZpzqxAMp8/
 Rb85Bey0dYOIp++cvNI8QUXNQArDk1JJP6JNKMCFWAi02Ck7nNhfE94dDYpnw5vrY6wek916V8z
 5whKi/GEYt5eTfZZ67TF4vinSvmSfhusCOT3FIl+3bmJ2OT89Mlmh4pWa0TMKlncTcHvgRuu0f5
 Gd/Bdg4/yVG+r6H96DHp9o9TrerLPsmhnWMLHveahSU2kl7cyxzlwkByslbinC1E5zfySKjmhI0
 os8RO/xs4WqQDCb8i+j5dJLfcosb2UZP2PtmqPx+qWvnu8a3RY5azi0tiM9hiQSBOtCF1yaF5Am
 BsFBMNpSg/SIa0e/kkFBPmZnkZ6YleiZTOUr/r2opLqzErAvv3XfYO+cwzd+EBFH4F+X6ZCPPY/
 gYayPulvuUgPVuQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Glymur platform has two Gen4 2-lanes controllers, the fourth and
sixth instances. Add support for their PHYs.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 86b1b7e2da86a8675e3e48e90b782afb21cafd77..5b53f03771d8fa54ac146e1832f70fdc69c762ff 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -100,6 +100,12 @@ static const unsigned int pciephy_v7_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V7_PCS_POWER_DOWN_CONTROL,
 };
 
+static const unsigned int pciephy_v8_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_START_CTRL]		= QPHY_V8_PCS_START_CONTROL,
+	[QPHY_PCS_STATUS]		= QPHY_V8_PCS_PCS_STATUS1,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V8_PCS_POWER_DOWN_CONTROL,
+};
+
 static const unsigned int pciephy_v8_50_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_START_CTRL]		= QPHY_V8_50_PCS_START_CONTROL,
 	[QPHY_PCS_STATUS]		= QPHY_V8_50_PCS_STATUS1,
@@ -3363,6 +3369,15 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_30 = {
 	.ln_shrd	= 0x8000,
 };
 
+static const struct qmp_pcie_offsets qmp_pcie_offsets_v8 = {
+	.serdes		= 0x1000,
+	.pcs		= 0x1400,
+	.tx		= 0x0000,
+	.rx		= 0x0200,
+	.tx2		= 0x0800,
+	.rx2		= 0x0a00,
+};
+
 static const struct qmp_pcie_offsets qmp_pcie_offsets_v8_50 = {
 	.serdes     = 0x8000,
 	.pcs        = 0x9000,
@@ -4441,6 +4456,22 @@ static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_cfg = {
 	.phy_status		= PHYSTATUS_4_20,
 };
 
+static const struct qmp_phy_cfg glymur_qmp_gen4x2_pciephy_cfg = {
+	.lanes = 2,
+
+	.offsets		= &qmp_pcie_offsets_v8,
+
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+
+	.regs			= pciephy_v8_regs_layout,
+
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS_4_20,
+};
+
 static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -5192,6 +5223,9 @@ static int qmp_pcie_probe(struct platform_device *pdev)
 
 static const struct of_device_id qmp_pcie_of_match_table[] = {
 	{
+		.compatible = "qcom,glymur-qmp-gen4x2-pcie-phy",
+		.data = &glymur_qmp_gen4x2_pciephy_cfg,
+	}, {
 		.compatible = "qcom,glymur-qmp-gen5x4-pcie-phy",
 		.data = &glymur_qmp_gen5x4_pciephy_cfg,
 	}, {

-- 
2.48.1


