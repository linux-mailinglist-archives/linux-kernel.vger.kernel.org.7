Return-Path: <linux-kernel+bounces-884887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718FAC316CD
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2856618983B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5BC320CCD;
	Tue,  4 Nov 2025 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YptXjI4a"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DFF32BF4C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265210; cv=none; b=NNNJz+juLYE08AQpYrZUh8HpzUSXrdmCeBV3JUJCjGFPm2ECej1q/14UW/uIcledOkE3tOJLh+j3/jBNhWT6RZWPdZZtz1jdeb9m43SC6JJQfdmb+cH4i255avAvgQG+HCSSeouVA00tI2EQ1LERUTlP1QyedF3Cl7ytXqc3nCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265210; c=relaxed/simple;
	bh=J7o+qvVj/pTXaFpXaAcj2Tg3Jq+K/NDPOk446ICszDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WnUVJz11I9FdsgEKbIBCPhQxjzuiUXmeg0rWW5eC9Aq5t/HGUguEIJIw/QFua2JoS9JdtxUmAxLKv0PGKeiqFOuRhpZmLf82xeTyGvCYlCDU/NRyki8kfnYmUYhAmY3xqKbp5WozBchIWu5gwTg5YYsZwFQQuB2u3mD4yOfXDiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YptXjI4a; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47721743fd0so30121575e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762265206; x=1762870006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0YVoVEFCaf8aeEHsaoJ6V5EGSx1RgPZYK2i+8/mRSY=;
        b=YptXjI4adkOTCyiRqXG3uqUAAMK98so0pcxjH7BsYWb4FzmqRhOgFmu12Pf5xqm2tx
         g5O/gmF/bXw3NLLlOyCeR4eYskUi5RmIiPmeMWllZ8O1hWaQqwenKtRQkZ6fJwqQzWpe
         aoRVg8H+r1w5EFWRdSPeQPqZ/pEYsQpj9tz+L5w84EGm89HaFKiJqCd7TS5QtP1Ofqzj
         tTX7W+f54GdCu/HDrtYg1C/28HzeJzWy1GH2GBe/Tbw9J5aEd2JLz8FbNS24MzzWIUYA
         WXFMCYV1mQH2nYAqg9O+7HZGXwLKVXSxSVzGramPI0RK4YH05QM3xqan3/ms2fCLsL+t
         SgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762265206; x=1762870006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0YVoVEFCaf8aeEHsaoJ6V5EGSx1RgPZYK2i+8/mRSY=;
        b=VZj0E4g5QjvLlDnLyaBtbt2vXwu7BXRoa4I1At881lmNYrAaRF2VIkIEPLJl+UHKSD
         5l1rMoOLiMQcPArCT30zzndgte17Spl/439XZTZA14adz2vcXJE3ZKDHj8BfeKChamXO
         o4BjqziAl+hDM1g+4qeIDvEMvgQ8k2uJwsZADfNWZKF7zvk8VInIQilo1yHywSrPsCp8
         FY0ul5CRzpAEX09ggnsGqD5pVgenr+fG44S/c6eMYvvQEkHlYP81+aIw8GEtr840ANEU
         Qt1YsmCSjZPVMHN2CK42zoT88JkQDoAtXQCgeZQCUJNHaS4Xq6Zyf49rPtPyAknLQTe2
         WBfg==
X-Forwarded-Encrypted: i=1; AJvYcCUzJ31L1AaBhtU1HFkmQ4+qFEtvl+jCL9SHeGaFVCUGTOZtOhwOAohyHnZBmGH+eCk9NQynJ86bTLTi6dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQuTt5x62r1fFmW9Z+iT4JhBEwih2ttgzRLTL9vUm0Zzz5nv+E
	6ShLfCw2VotJIhBfhuEgUpqqybiXmtFloG1n/7cMe0iVArEwOM3vVkp9
X-Gm-Gg: ASbGncsA9pKbmVy+ArJF5G9QX4aloQnZptJeo3kOfMDknXkKvFDgmTZMPk8nQk2cTta
	B5+sJs/hkCqNtqcI1V5qg0ImxSDSRsyg1j/nmjZgycftHq+PnIA7q9tcwz6+PWKoSnu/6w5Ny9a
	esZLjD3lu9cJFBfJnCoCtFgYdwqrw9VwS4LxAfAre/w8VqbifDzICAztWnYtr1fxRB+S0BhwPC5
	UsYDH1lrrAyq057ospAAlyEAIQ0SX8DxTfZ/GQGMRD1FkFBycwmOvbJCGGQLPYD+ztg8isfy7bA
	NKhdJQsw3JtoW7hgIVU+D89ERbeAvbIv1SsiWhXs+/PBw+QLpRbcmN4fgW8rVuzQjlzB0Qu0B3A
	g2mz6MXPFsVClexxY9RMXFxNr4IMvtIj6Xx8kChZJqDW6Bf1jBkT8coYbn/Hbi5vH1CJopPcsJc
	3N7CuNGLVV4IeoM+gchQ51qgNbdOxnmA==
X-Google-Smtp-Source: AGHT+IHysG3/qeAR1noZEqq9C4WhUroWJnqAclS/5AWKKIu7XUXyFIQ1hIfpstDAPpN5e6K90GHyhQ==
X-Received: by 2002:a05:600c:5020:b0:471:700:f281 with SMTP id 5b1f17b1804b1-477308a15a7mr136413305e9.25.1762265205897;
        Tue, 04 Nov 2025 06:06:45 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47754adcd08sm52511205e9.5.2025.11.04.06.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:06:45 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 1/1] cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM
Date: Tue,  4 Nov 2025 15:06:30 +0100
Message-ID: <20251104140635.25965-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104140635.25965-1-ansuelsmth@gmail.com>
References: <20251104140635.25965-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
case for some Google devices (the OnHub family) that can't make use of
SMEM to detect the SoC ID.

To handle these specific case, check if the SMEM is not initialized (by
checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
OF machine compatible checking to identify the SoC variant.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 35 ++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 3a8ed723a23e..17c79955ff2f 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -252,13 +252,22 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 	return ret;
 }
 
+static const struct of_device_id qcom_cpufreq_ipq806x_match_list[] = {
+	{ .compatible = "qcom,ipq8062", .data = (const void *)QCOM_ID_IPQ8062 },
+	{ .compatible = "qcom,ipq8064", .data = (const void *)QCOM_ID_IPQ8064 },
+	{ .compatible = "qcom,ipq8065", .data = (const void *)QCOM_ID_IPQ8065 },
+	{ .compatible = "qcom,ipq8066", .data = (const void *)QCOM_ID_IPQ8066 },
+	{ .compatible = "qcom,ipq8068", .data = (const void *)QCOM_ID_IPQ8068 },
+	{ .compatible = "qcom,ipq8069", .data = (const void *)QCOM_ID_IPQ8069 },
+};
+
 static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
 					     struct nvmem_cell *speedbin_nvmem,
 					     char **pvs_name,
 					     struct qcom_cpufreq_drv *drv)
 {
+	int msm_id = -1, ret = 0;
 	int speed = 0, pvs = 0;
-	int msm_id, ret = 0;
 	u8 *speedbin;
 	size_t len;
 
@@ -275,8 +284,30 @@ static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
 	get_krait_bin_format_a(cpu_dev, &speed, &pvs, speedbin);
 
 	ret = qcom_smem_get_soc_id(&msm_id);
-	if (ret)
+	if (ret == -ENODEV) {
+		const struct of_device_id *match;
+		struct device_node *root;
+
+		root = of_find_node_by_path("/");
+		if (!root) {
+			ret = -ENODEV;
+			goto exit;
+		}
+
+		/* Fallback to compatible match with no SMEM initialized */
+		match = of_match_node(qcom_cpufreq_ipq806x_match_list, root);
+		of_node_put(root);
+		if (!match) {
+			ret = -ENODEV;
+			goto exit;
+		}
+
+		/* We found a matching device, get the msm_id from the data entry */
+		msm_id = (int)match->data;
+		ret = 0;
+	} else if (ret) {
 		goto exit;
+	}
 
 	switch (msm_id) {
 	case QCOM_ID_IPQ8062:
-- 
2.51.0


