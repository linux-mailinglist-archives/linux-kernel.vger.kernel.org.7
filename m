Return-Path: <linux-kernel+bounces-886362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AF6C3556C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8817B4F8B39
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEC2304BB7;
	Wed,  5 Nov 2025 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmE1gds5"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C849E30C370
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341716; cv=none; b=a+olj8pLw8h5wx71I3wyAipGtD7/Jehfk7iaXOdSW9NwHHYNgkkH8PyxzFT/UBBaf9hI+uMr9L2JdVO3sWUzs9BDckHYQg+n+ZJxBy75sXz/svex6M97PSx204HqwVgWz534p61qNCutbvPQ3Tr9zpwTtKzZheHyVqbemaNEkxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341716; c=relaxed/simple;
	bh=FNrJaRSuWPP0+80IFUuNsbxE+kHLaf+ZpsE+hL238yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HB81MejsqfFGkQkOl37HYzhrbG+VkmQAKAr5NfL0Lq7G3TK+WmrXI5F7D78/HXTf4aaSFGBJLkqRNw1aRVI5wNNAbN8klmhgWsMVCXizTa+zfopmpqLoQhr8JhGgF56hiDDmVIerh8vPHIc/obx19wVjwUH2g3JZe8DTwxlwec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmE1gds5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so51506025e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 03:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762341713; x=1762946513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5pLNnnbL3rHvQzwwY3VC7rigAYhAoNQuK8omShAyWoA=;
        b=kmE1gds5txHh3bcNv0X1XBtAy4gzQQpwtP0cGffTbcwD5CbOS63QOQ5nYIS+U3yoAw
         KQLq/6aHkaQcVHhexaT1Yn+2aRIcdUw1DqEDfzFajcrX12dBEXnViXLP+lZgn4rs/OCd
         30mz6d9uWZHnku+OslvwivGSRL51VkpTA9ueg7XeGF7IAnxu3HNuQMxbEcdw9esC9rkk
         nK5XRHxh33naDn3AKG2KP6afo4JkOd7JqnwbSyK9qG+rUAoHn/4fVkKywNEq8rIRGDhW
         sflsgf9w1frh6NQkoFF3lKHsPj3e9A3Ojntz9OBPCs1N/CEYhEGuOticmoUFHyKUbvjV
         u0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341713; x=1762946513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pLNnnbL3rHvQzwwY3VC7rigAYhAoNQuK8omShAyWoA=;
        b=nXXy7sS4xSh0U1kL//l+2reTbyjKEVdp15/ScUvL7Wb7so8S7k4fI8SrplaNV1nsE2
         XaWibXM3gQ1+xTLHMGVl2cY+HG8p20yFMN63v54TP6FmekW+VESVVjZb913oBKrnZm23
         pM4JAjHxCEUfTqXm0q0JB5tUDF1w6aKcLv6UVHX4zieSNuk2tFLPzvci66jVOkhRYB2l
         qbxFXxNU02T+aGayGYm7sdqqAVH1pFvhMJxgYNE5FwBZd7IKx6ZE58KV3JrG9uTyB0Nw
         OrW0h8oTPNGrgm+h6kJynnRN6PjDzv7cpidheuzxn6lacjNAdCOtG5QQJSNAgAxNd2+H
         FOlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkjNK1IQxm0O1RS/6/vnyzU1VmpxRTwcParPFYkeVuzvMRMivIXIl63yEuWwvKYTAN3420/duzyjqa6Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyffu0TZvz8zSiIRzTVQMoeubLQwtcXpIFcBj4s73EPA6ze1lzg
	q+DeiNYGU8WIPXUs0GomPUbWgEqqnOJ7KVM2AuzzP3XogHRxximUOMZk
X-Gm-Gg: ASbGncviMlbgXnnXJ0wZMMppMMAAwzs78geC7NnGFeRMTmpFlDsLFez9Sn+61TZPt1g
	C7tAYNsR7Et8MU5oMKxzwKLWOXB4Z1hovfFgOV1QQ8WotBWPQtjeZCCURG56HXTzRZagfSqShal
	LtqTpPLaQ5FuxKhVi2AafG4aZdzEEcj8HPZg47ojaDbvYpll/Nh4XpIlvin/DMaZRMYZE8/4sTE
	ZaEFAQX0cMcT1hCH94HEkLZ0brZdLSDmV/M0Anr3gU84djvHgODsktbGZVJ5mqaHcmjS/1yJUWI
	rGDjPKNi0qNx26SPBAHZSLmetVJMpmcsm2Rs9SitUzL4gO0ytMTuBeIao+tjsjICw8o74oCNBEv
	rHna2C7PjmJLsqVgGVsn4XCoXBORtWVMANVSszNqi7jEZsxm55e21BVUUv6oh2ZVvgHLhcpA2BZ
	ZDqYGU33l97yoqVhLqA67ULxxqtBm2qg==
X-Google-Smtp-Source: AGHT+IHIgIQLMjyfsUy/DCWrg95x6zDlVpO8mQEr6nvagaJBa/yhqQLKmWsXV6I9BNH25BymBpPrSw==
X-Received: by 2002:a05:600c:348f:b0:46f:b43a:aee1 with SMTP id 5b1f17b1804b1-4775ce2c7eemr18402505e9.38.1762341712907;
        Wed, 05 Nov 2025 03:21:52 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429dc200878sm9829851f8f.45.2025.11.05.03.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:21:52 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v4 1/1] cpufreq: qcom-nvmem: add compatible fallback for ipq806x for no SMEM
Date: Wed,  5 Nov 2025 12:21:34 +0100
Message-ID: <20251105112136.371376-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105112136.371376-1-ansuelsmth@gmail.com>
References: <20251105112136.371376-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
case for some Google devices (the OnHub family) that can't make use of
SMEM to detect the SoC ID (and socinfo can't be used either as it does
depends on SMEM presence).

To handle these specific case, check if the SMEM is not initialized (by
checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
OF machine compatible checking to identify the SoC variant.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 35 ++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 3a8ed723a23e..be44a8965e3a 100644
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
+		msm_id = (int)(uintptr_t)match->data;
+		ret = 0;
+	} else if (ret) {
 		goto exit;
+	}
 
 	switch (msm_id) {
 	case QCOM_ID_IPQ8062:
-- 
2.51.0


