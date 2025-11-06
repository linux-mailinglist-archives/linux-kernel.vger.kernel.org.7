Return-Path: <linux-kernel+bounces-888980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E070C3C67A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73A6563570
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B11E34FF78;
	Thu,  6 Nov 2025 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYqYR3EY"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418C034F483
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445808; cv=none; b=EMr83lIyC/txix0sPlxJr9R9lGnrNOB7pU9Pf1bYE0/IZ4WiWP7kFM5XThYCRfOzeXDG4LNMgP0riSnf8McYLEW6vm9xiKJecKJV7xF8JSEJOuUGcxL8u1aYcg6XhfEpy4hCGVfx8GzhhgOC1gmHbCYw66GgTA2XKs4SNgcMDTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445808; c=relaxed/simple;
	bh=KyCK4WaX8DTPr8e9FQEpVrY1lPGKIUEEeXomozdcgIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QOouEFRoY8vDMSDk60S0luyxuoOQtboIedns9TXi35AX21DL/xc6Ewo5TLcB9QRW0SEfwKPNTamluOx7B4urVIfuGSrGCzItfiR4RLHYZuz6WAwzbO48+d32uFCIpULXgdBLaq6Qj28kC/m1co/jgMxIY6BJqYVpTu+epDtq+Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eYqYR3EY; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64093f3f7ddso203317a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762445805; x=1763050605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNxxLoSaj80bOvxwS+x8aO/LQaPqTkbFKbIYZM/ccx0=;
        b=eYqYR3EY1SGVHnzqn6o8bJcAx2GD0uMt9befhAT69J/qFgfL/XJULmb2l60UVV8VwA
         rGfmmTIhdjSS60/olz75EDibyz0IMhKWhDPNCxoQ+CG9DguagXAtHi262iTA0HLsZOiY
         dIZFx9BB5eUp4wS2MsPXLpKxcYjIJd1EbLuDSDWj2yR2kLdkXwVXUYsMByTLr39a8H6F
         tt7/GEvzn9oADTSWG6+Rl2hgmY60iRd7qMLKBYcb3eaNmFI5E7gPkWxKq1p+QiyX6TUw
         +StnFAUfv0/IZ5fYo1kGEmFmtVCjWg4q9mrQSeOOTG/q+9dZssnvxyOOWUCtuKPJQwL/
         uT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445805; x=1763050605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LNxxLoSaj80bOvxwS+x8aO/LQaPqTkbFKbIYZM/ccx0=;
        b=PlC95nEI+z5AqmjZmKIZbBYVeNPIbbTAwjs8kSA49MnDYPjAeK6KgtMFFUCRcF3hwA
         l67sDu5HeDT/m0U7W1PcBgHksOv5kZLJo2YSzvtt35JDnnDUfUHW1pwP0MVdzlShVT/e
         WHEvfXKD6hs6EeiXo/IveWgakg+3fTZXP/U+9G0+j0EMxpepYOXYRrHEAaWeDAGwKYuC
         gdJSCI1kd8W5tCUR+QLyxsKRhk538cg9kjD7TZSdWPy9FK+BqyJw2ltgHTUkJI0R3Bd3
         sVTGRB1LaM46nMNtXExW9uE7f18bCoWkKrjPiy9sHs+n3+flAZInMcYSH4yL6WUTRU6a
         ZhMA==
X-Forwarded-Encrypted: i=1; AJvYcCU6bCnzOxj79CNsvPxjrfBjzx1LRsBC4fsHLMiRSiXsbQGjBjjXwpxMw0D8DY43TDbTdLH9XxdrJ61FvHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwtico+p4wn+zbwe4349xBmeJPewoPNGBs/+vzci/jWnmCKt+X
	j/YNQIqgMiPSEXc/sCt4eO0MC46nlxwKcytfg4O3Bpz0eoDERQC+pDjXIgtFbISuhN8=
X-Gm-Gg: ASbGnctprSvRcP/CDO/AA+3Q6QDmfdXqegYds8YqzQCjjQPvPPY4LuZmQzkHsH2b6iL
	/aiIajhc6KsBP0ObyExBRvWbWl1eFs83pj6WOQasa8mndQw8soPi3H7vJTPnVilEUQlB/EZEBur
	MFE3hvJhIyyjnhO6ZzDft3lIxQeX1OhSHaYfHJ/iJWQabZzjglqE6Iu2NmG6FeLRli8o7paSxo0
	rMAmk2PWroQu4426Sglq0iOyfQsNQrFR111FLT9UtFmt6fgRKS5C5CCEPhrVTn8NZYueg5kFfJZ
	ji3EAwZsGutwHxLzo2tC4FFGcMC+fSzeX0QOyZx9gGgWYOIgxLPU7XaTNgt3nLtqQK9qTnTZXGb
	ord45SZbbGRgWV8DAeRVz4M02sxtlZec7o5gdtq5fynoQdJvIK+8ffSJNxAx1jSoD9IAmNBBie/
	O6SpsJyBmYrnJMEU3yfIqXPoRLONE=
X-Google-Smtp-Source: AGHT+IGxqQY1TKHhlv59jD9rXPj3NM3yoBtmJAbJOzQqYLTcCXhQ3w1hdyfA1R6qDfeGfCwDVofBBg==
X-Received: by 2002:a05:6402:35cb:b0:640:9b11:5d7d with SMTP id 4fb4d7f45d1cf-64105b79e3cmr4181740a12.7.1762445804550;
        Thu, 06 Nov 2025 08:16:44 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eabsm2113408a12.11.2025.11.06.08.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:16:43 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 17:16:28 +0100
Subject: [PATCH 4/4] gpio: zynq: Simplify with of_device_get_match_data()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-gpio-of-match-v1-4-50c7115a045e@linaro.org>
References: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
In-Reply-To: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 Srinivas Neeli <srinivas.neeli@amd.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=KyCK4WaX8DTPr8e9FQEpVrY1lPGKIUEEeXomozdcgIk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDMnhaeYJvXX2uO3vKVe9JEZmeNPGFfrC9cmTl
 8PnkWe0SIaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzJ4QAKCRDBN2bmhouD
 14SHD/0RJ4iQBsacOdNNfDcM2yGY5n7EhMle4k1LQGwzgE8xaJZd0bNJ5SuXB7KiK8M0d+ncBIG
 Vpgc5uJxPllzlkLTWU57w6XNurghRyy10l5bLnj3zVPqE8uDm8zaYb2f2KCLUY0ZFHBwC6ZZD0S
 EywKXF8tXCNuyHqUd/d2gc/hufQSKswUKOk0awanMijo9zIoPIAvdWP/68XTrDaJrUggH0VLWDA
 DirP1LDVncWKXiLonYBU0Dzj+E6zW9e09uUsKpYlzqLp9X5b0nZqAky4VSuFbrlQOTYP5qOQYI8
 6mcG6WQJGAQizQ5aDwZqz9BVLYC5A4wUFrZEOzZITZlVateMtaA36tFKB9ykvpXKYOtZbyDNzrY
 vF5L6KKkjCRSQMKv/97axV9dFeuK62nPFn6zCzJhtfuVW2X5gl/S7p4SKcVW+XzIb9B9Fd6UgWP
 xPUerlWtE7IzxdDyf5dKH0FnDkSm6SsqecuZaHZHyj1YvZOa8P+CK9o5BudRj9cUprLWEckBgGh
 vyk+OrhUR9i6hakDiow8oUA49HjhJCl3AAtwwFm9u0lRDlNi1XKdtGXrfZWUXbgT+BcW316eDTy
 c8bwP6f+3kHFzKoVOnytycrNZ1R3CfM400ReIYFDpY5ucGP37m3DcHa3ZSoiNYwzWaMPxuK5DhU
 Mad4nYQwDNFnyyw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver's probe function matches against driver's of_device_id table,
where each entry has non-NULL match data, so of_match_node() can be
simplified with of_device_get_match_data().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpio-zynq.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 0ffd76e8951f..26071ed1bf22 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -904,18 +904,16 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 	struct zynq_gpio *gpio;
 	struct gpio_chip *chip;
 	struct gpio_irq_chip *girq;
-	const struct of_device_id *match;
 
 	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
 	if (!gpio)
 		return -ENOMEM;
 
-	match = of_match_node(zynq_gpio_of_match, pdev->dev.of_node);
-	if (!match) {
-		dev_err(&pdev->dev, "of_match_node() failed\n");
+	gpio->p_data = of_device_get_match_data(&pdev->dev);
+	if (!gpio->p_data) {
+		dev_err(&pdev->dev, "of_device_get_match_data() failed\n");
 		return -EINVAL;
 	}
-	gpio->p_data = match->data;
 	platform_set_drvdata(pdev, gpio);
 
 	gpio->base_addr = devm_platform_ioremap_resource(pdev, 0);

-- 
2.48.1


