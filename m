Return-Path: <linux-kernel+bounces-830258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B05CB99386
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931183A4776
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0794A2DAFD8;
	Wed, 24 Sep 2025 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wws6VjMz"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377F12BE658
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707098; cv=none; b=mTlNAnJA6OovwgnlmObByoaM/7/OMLjqOkOV25rC9vZ+nImIofG6XEEY12a/QBl3ArPfOKio96i9hXLyB3jslFjwM8JP2XcFDH7fsE+g4RNXAcAUfU8kJMZS4wCcAMmtfqAT5+VuY33dguenEt2G6AtKRjB6Mmo6Z9Lvn1YjJC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707098; c=relaxed/simple;
	bh=ciJyOR3eGK2gidrZT8YeI5fy6dg+FxklvW19mrX4w1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jBmq/8VOnYTT4skq3DQ8ZuQfmGG/i59u/ru+GgCk9YJNVSe37/EEZI0j0Zzfj7zawI6ag8L2mma/CMAuuZl/yWnT+Zrx3pG3XEJ+wv853jp9/4p20aiJn1FxGA7sNfmAhR3UPA47mEgrfzPqpF0u9Ajy9tQeWyvyr6kisRCQG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wws6VjMz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso46105505e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758707090; x=1759311890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPzMl9444DyFsyhIlxZU2alp+KEUomV9x8N6sGCMpt4=;
        b=Wws6VjMzHCcBeuBqc/VWUPquM3KzllnF+5VZgNsPQqiGXKl7p+BonBA9x+ew9HLdzx
         1Knq3VunrDzaOquoQqX2N276RjQX4aqgILjQjz+ti55ASQwGT4qrJal2T5Va9tTcDT7o
         Kv2/anThBiV+g0L9fxXFb2bLBH01uKqYPJISWdqDiAX98miSLMwn3rEHfKJHXe/PsRX9
         xX6vv2j5XOw7iYdMAZFSLd/pTZAaxHPswi5m7MJ6+ut/gH1beVhLxXyifEY3vboKPQWo
         mPBZ/0NqfmpcpoiLXCNHs3Fq3BNYcvlATSMScxua2EGbrEz2bzbUeNsFxk35gTpfg7MB
         fuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758707090; x=1759311890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPzMl9444DyFsyhIlxZU2alp+KEUomV9x8N6sGCMpt4=;
        b=NEge3tFSk9GYmJAj4QXee/4gXxJJL/+pOzqqNsKUQ+mdqjrCeIr7UO5FI0OKCO74HR
         Qtl8JnJtqoiWlEf/Ug2WQOWN+r9ph7V+1QImzULmcCyUzZXiLj14Ww3OOPFhSb/nwObP
         vViA7f0ODssjt8e9HbFpk9Uw979WAejdygkHiFCuNxRVXTOrfZp9zrCB7d/xMROR+Vqz
         bw1aMI2+Y9u9IPADi6N1+z1T6idbFLMkk9Z7ckTFY3NuMqlL6lFe8AErsn3M3T+stas5
         WDzq52ndmeDE31Lcw0et2qSOHBlnz46cA4ul5mNuFPD2QVcV2Mnz5VQSikCrcfsfO+cz
         9gZg==
X-Forwarded-Encrypted: i=1; AJvYcCWaJ0Iek1DwaKH9UEMhtPGkR2taPESyh5C4ab6fLClRDNskBeet/+Q42mIBT5110Iesw3G2aiTDMz0KKxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2B5vj6byEqLpsErR43lNxkaANVpaWabl1ou88v5ZCVLkN9cBj
	Gz0l4zAKILKCkfuzQyCwLmfT9YnhJfJ+dTgo9l5dek0uZu9JVnG0hY3D
X-Gm-Gg: ASbGncuTMEaDKnSoAN16JNCN4QbF8sVewvDnmdNhtxm8MGiUcINu11+lfCXo1HChVDx
	3yDpfLDoPWrw3dOaAhdYJeFFoabiL1vAgP95VZdka2KNeY9JgFWxv+Iw7qWwnpF5jSXcfzfTuwQ
	bGBqaEFs5L7/GZcG7pWx6zsrnnmihaqjDlrqqRY0ECbu41rLvPLpZfqywZ71ahOO+WgrckQ9K+3
	J0LLVNKrzXyQyQZktsaiaWlFwaQ7zJptoqP3tNaEKKZtIk4IWTAUPUELoDIPWdefuiEOZbh1FpN
	qGKJ+EPVFk0NMyi285pC4ksTPVxBOVz5bTHeWbJ53cirrYrn8hArj523DDuZmbhm/O0lWd4WyjN
	pEi2AzDRGHGzYgZ9sB2ZBwt0Wv3RWwGYNn7MQDZElEgRrTq2lpMrssLLh7Cof46YcbjubeQCof+
	VyTnfwME3hmLLryw==
X-Google-Smtp-Source: AGHT+IEhM0YgF2Kn4HKT8PplTIrFiGxgI+VDLPFn2Qw0xzee/LIuyoGd6FHnJttuYVQuUAjdxDoCmw==
X-Received: by 2002:a05:600c:468f:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-46e1d979fc5mr51230185e9.1.1758707090354;
        Wed, 24 Sep 2025 02:44:50 -0700 (PDT)
Received: from localhost (2a02-8440-7503-805b-0076-f865-8f03-23d3.rev.sfr.net. [2a02:8440:7503:805b:76:f865:8f03:23d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9ac5basm30729625e9.7.2025.09.24.02.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 02:44:50 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Wed, 24 Sep 2025 11:44:43 +0200
Subject: [PATCH v8 2/3] clk: stm32mp25: add firewall grant_access ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250924-b4-rcc-upstream-v8-2-b32d46f71a38@gmail.com>
References: <20250924-b4-rcc-upstream-v8-0-b32d46f71a38@gmail.com>
In-Reply-To: <20250924-b4-rcc-upstream-v8-0-b32d46f71a38@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-0dae4

From: Clément Le Goffic <clement.legoffic@foss.st.com>

On STM32MP25, the RCC peripheral manages the secure level of resources
that are used by other devices such as clocks.
Declare this peripheral as a firewall controller.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 drivers/clk/stm32/clk-stm32mp25.c | 40 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/stm32/clk-stm32mp25.c b/drivers/clk/stm32/clk-stm32mp25.c
index 52f0e8a12926..af4bc06d703a 100644
--- a/drivers/clk/stm32/clk-stm32mp25.c
+++ b/drivers/clk/stm32/clk-stm32mp25.c
@@ -4,8 +4,10 @@
  * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
  */
 
+#include <linux/bus/stm32_firewall.h>
 #include <linux/bus/stm32_firewall_device.h>
 #include <linux/clk-provider.h>
+#include <linux/device.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
@@ -1602,6 +1604,11 @@ static int stm32_rcc_get_access(void __iomem *base, u32 index)
 	return 0;
 }
 
+static int stm32mp25_rcc_grant_access(struct stm32_firewall_controller *ctrl, u32 firewall_id)
+{
+	return stm32_rcc_get_access(ctrl->mmio, firewall_id);
+}
+
 static int stm32mp25_check_security(struct device_node *np, void __iomem *base,
 				    const struct clock_config *cfg)
 {
@@ -1970,6 +1977,7 @@ MODULE_DEVICE_TABLE(of, stm32mp25_match_data);
 
 static int stm32mp25_rcc_clocks_probe(struct platform_device *pdev)
 {
+	struct stm32_firewall_controller *rcc_controller;
 	struct device *dev = &pdev->dev;
 	void __iomem *base;
 	int ret;
@@ -1982,7 +1990,36 @@ static int stm32mp25_rcc_clocks_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return stm32_rcc_init(dev, stm32mp25_match_data, base);
+	ret = stm32_rcc_init(dev, stm32mp25_match_data, base);
+	if (ret)
+		return ret;
+
+	rcc_controller = devm_kzalloc(&pdev->dev, sizeof(*rcc_controller), GFP_KERNEL);
+	if (!rcc_controller)
+		return -ENOMEM;
+
+	rcc_controller->dev = dev;
+	rcc_controller->mmio = base;
+	rcc_controller->name = dev_driver_string(dev);
+	rcc_controller->type = STM32_PERIPHERAL_FIREWALL;
+	rcc_controller->grant_access = stm32mp25_rcc_grant_access;
+
+	platform_set_drvdata(pdev, rcc_controller);
+
+	ret = stm32_firewall_controller_register(rcc_controller);
+	if (ret) {
+		dev_err(dev, "Couldn't register as a firewall controller: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void stm32mp25_rcc_clocks_remove(struct platform_device *pdev)
+{
+	struct stm32_firewall_controller *rcc_controller = platform_get_drvdata(pdev);
+
+	stm32_firewall_controller_unregister(rcc_controller);
 }
 
 static struct platform_driver stm32mp25_rcc_clocks_driver = {
@@ -1991,6 +2028,7 @@ static struct platform_driver stm32mp25_rcc_clocks_driver = {
 		.of_match_table = stm32mp25_match_data,
 	},
 	.probe = stm32mp25_rcc_clocks_probe,
+	.remove = stm32mp25_rcc_clocks_remove,
 };
 
 static int __init stm32mp25_clocks_init(void)

-- 
2.43.0


