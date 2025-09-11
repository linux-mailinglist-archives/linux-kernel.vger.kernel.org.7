Return-Path: <linux-kernel+bounces-812647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5087B53AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F4C47BD422
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C361036934F;
	Thu, 11 Sep 2025 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNcMGdhS"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DD736298F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613446; cv=none; b=AVlnOO4zmk7PkuiAEjSuqfzEwOpa5v3pJEui1pjxaRvOBhPYYsTeWanSrBRaNR7PopcYd+Z6+uNKkCvPIYVBHoXKpdCMLfg52/XRW/WNrA5I2TZDHyh6pXjVjMuxCeMU4b7WWp9EGhOEkI6TpT+RYjqeC5sG1bhUvbjY9z27OoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613446; c=relaxed/simple;
	bh=7FnUwbEmejwVSnUIHfEhq3amFSr92wAVZ9/qi8x2QuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eurguV74fEcRbsIkdJyzXUcVhfkaD6OXqoAl48B6o+WZP1r96afZq1VbsyLGZ9wGtR464vx2WUnlO+Q5CiPo8IOsmINvOgltvfgois7Uh9641HDSss87nQUSNKmAIIZ6ta5Bfwf8/oAMDSmeygFySymdcbfXvGCHbN/wt/07Juw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNcMGdhS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7322da8so197497066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757613442; x=1758218242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ns7BKmWktTmho4BiSMW2JK0id4rh12+/PwSt6cjLKJc=;
        b=DNcMGdhStlQ25auDk2a2W5tU3cyPjYOWkQlBeBfQEvq48P4w7ZAxjA+5TsdDs7JQpX
         1vfCqL2a446/3BtPcrwkQdu2FRLxj1ISgoP8dJJe9MxKLE8nRHLrAx9tTt7NNHzxA/xJ
         QJsGfVmCMqD/WkmH2P6xmCn19XHGQgV/KS5IeA8JEDK1dTE+Olq9DsFhcg4X0LBOtvII
         R/1kVveIY9WKQZAuc5Fanr0g15K3vEF9p9WPKDn+dEWamTa4zBb4blGaoaPzX5FRUO8+
         ybolcybdbtQaMneKM710E4DA+gTVX0MOmyBNNbJ3G04GTHJTeYvERZcEkgmxDxSExaif
         3HXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757613442; x=1758218242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ns7BKmWktTmho4BiSMW2JK0id4rh12+/PwSt6cjLKJc=;
        b=c/XhUiDjCZr/+j1ZdHwwd3oF84zbAwvWnPRs3icY9TSHhYKtNe249l2zoQJC0XWJP5
         yzEJ4iD9F0GTXxaemw8vn1OQY0qtJQWc0uRY909DlN8RF7qvtRPtsfUv9piOwwBis/8P
         1RrfoaprceKHZ3wDAzQNlCZ8o54r5oaj3UX8JpgDu4tWm1eaWn7oHCIGR3PzNn+Kx3Tv
         cPMTwKr0KAiwJ1Fn5N1tNgI9pwNZwhUYwtJ9kvhddmeOjAB93YWKp+ih01jCDtefXiUK
         q3EIAeg6jXmerl3s5tZWnhH/gFwV04G7UJXCoFktWYxjt2EesK7bUqGPC5jhYrW9El9q
         CpuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3U0VZMQwvu4ApoK13SLZbYDy1RGcNbMN9u6PEniNfaT6orWk69dfrwtJBrFu5Q6dW184pAq8WxEcC2UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW/9F/KlkeRixpGU3+dYGTfsg0QW3jdjOTfqpEKBXutiu5ylrg
	WaUaCa61a32fQjMTdvcOyw+a591OWQ9n762yVxsQ6x/uP0lUe0q6VP1Q
X-Gm-Gg: ASbGnctVGrMTlMdVsdN8TarYayrXxJQ7bk1SEJOlphJTJ80KtyaOAM3msnTealdIwM3
	iAQSseGPx+7e0wJnvYqDAZ3/q1VpqFCMN6rx7k5E/hH+RX3ISsAnj4z1BnG6HAT738L7wf6fSaL
	6OZoO+hh8Y6WNpSsLlmapGS8fEer+wGELTRubk0Nd+kM85OY+P2zgBNUkuOuazJ630xGtU75bsM
	W1hv/gDPQvYscoOJYLcqsNZTJAVVptwEMijrDKHdXz8Vm/q3gWibYqUtIr2EiMefoZTAFGr+w6w
	Dfsz1+t4I7+tu+tJw4KK0uB6EBjeVSnKWPHkgmR1YAva6fmZkTPjOgsHJ4dcePqbfIad8F6C2Ye
	lVEpaSeG6xZS0JKNiHOU8eTCb4J9RI4Rpj7ZaBfAXTg==
X-Google-Smtp-Source: AGHT+IGiVvnqUjZ3ceOMlaWQ8YjsGzVxQQRaI5M4RP4yNgm8xaWg6d0U/yhQgijoQolYs+NLoeB72g==
X-Received: by 2002:a17:906:9f8c:b0:b04:274a:fc87 with SMTP id a640c23a62f3a-b07c354f750mr3604666b.4.1757613442420;
        Thu, 11 Sep 2025 10:57:22 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07b312845esm171377166b.26.2025.09.11.10.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 10:57:22 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 11 Sep 2025 20:57:14 +0300
Subject: [PATCH v3 6/9] power: supply: max77705_charger: rework interrupts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-max77705_77976_charger_improvement-v3-6-35203686fa29@gmail.com>
References: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
In-Reply-To: <20250911-max77705_77976_charger_improvement-v3-0-35203686fa29@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757613434; l=2453;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=7FnUwbEmejwVSnUIHfEhq3amFSr92wAVZ9/qi8x2QuU=;
 b=II891kbNlU3RziHR48fRjxFXo101646zv9UIy591I8Z9TPlXzeTqFbGb6muQG0Zlw1v8aoee6
 Kvx8pr/3h0/B2rnYNXmsvZtIMa5fs+ZAuQdBs9p1ksFQeTlVjSQ2/8K
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Current implementation uses handle_post_irq to actually handle chgin
irq. This is not how things are meant to work in regmap-irq.

Remove handle_post_irq, and request a threaded interrupt for chgin.

Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Changes to v3:
- move irq initialization after workqueue and charger initialization
---
 drivers/power/supply/max77705_charger.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index d6a3cd98c898..5f831c25b150 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -40,13 +40,13 @@ static enum power_supply_property max77705_charger_props[] = {
 	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 };
 
-static int max77705_chgin_irq(void *irq_drv_data)
+static irqreturn_t max77705_chgin_irq(int irq, void *irq_drv_data)
 {
 	struct max77705_charger_data *chg = irq_drv_data;
 
 	queue_work(chg->wqueue, &chg->chgin_work);
 
-	return 0;
+	return IRQ_HANDLED;
 }
 
 static const struct regmap_irq max77705_charger_irqs[] = {
@@ -64,7 +64,6 @@ static struct regmap_irq_chip max77705_charger_irq_chip = {
 	.name			= "max77705-charger",
 	.status_base		= MAX77705_CHG_REG_INT,
 	.mask_base		= MAX77705_CHG_REG_INT_MASK,
-	.handle_post_irq	= max77705_chgin_irq,
 	.num_regs		= 1,
 	.irqs			= max77705_charger_irqs,
 	.num_irqs		= ARRAY_SIZE(max77705_charger_irqs),
@@ -593,12 +592,6 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 					     "cannot allocate regmap field\n");
 	}
 
-	ret = regmap_update_bits(chg->regmap,
-				MAX77705_CHG_REG_INT_MASK,
-				MAX77705_CHGIN_IM, 0);
-	if (ret)
-		return ret;
-
 	pscfg.fwnode = dev_fwnode(dev);
 	pscfg.drv_data = chg;
 
@@ -630,6 +623,15 @@ static int max77705_charger_probe(struct i2c_client *i2c)
 		goto destroy_wq;
 	}
 
+	ret = devm_request_threaded_irq(dev, regmap_irq_get_virq(irq_data, MAX77705_CHGIN_I),
+				 NULL, max77705_chgin_irq,
+				 IRQF_TRIGGER_HIGH,
+	"chgin-irq", chg);
+	if (ret) {
+		pr_err("%s: Failed to Request IRQ (%d)\n", __func__, ret);
+		goto destroy_wq;
+	}
+
 	ret = max77705_charger_enable(chg);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to enable charge\n");

-- 
2.39.5


