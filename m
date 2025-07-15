Return-Path: <linux-kernel+bounces-732620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8A3B069A4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5546C7AF871
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478672D29C2;
	Tue, 15 Jul 2025 23:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hSxU2Ubu"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D7927147F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752620462; cv=none; b=M8lY/B8ZYyw6ZHiaC+xMrfcggY5cKXsfhbUT3JHrsiOC4C1NSmBCx5TLqCBCGkVsXeb7qXAtsAPODmqT0j7wQbyTk4zMfDl79XKscVL4i7ZWi5MqwVj6wVeEt53iGYf/WRH2Rov5RqexkH14Og090PVoX6P0RoW5DOIqVkm508o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752620462; c=relaxed/simple;
	bh=M6ZlHU6FLX2CA9QPMHjn/+MEhADmPo6CNAXX8jHSGfo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FOaws/aM8aQP6UCrMbritJ1a8H765aD+ejQynJk8b4xMzY1+By7YhNeUs1o5HFosKLwth/wOwRr8YVcMgCiGN30TKSPEPVxFs/4clh33bWtZk/YmZBBMPXG5gZUTqtlliya2LNLOO8kdfJPRz17nkLqWK/XpwwdYkjW1wyQoNt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hSxU2Ubu; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-73e5c79784fso753068a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752620460; x=1753225260; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HjmjRwrY70wx2CHWgUgdB7zU+MT5vMpT8bTQPJScVgc=;
        b=hSxU2Ubu52wQfGMq/dXtCFEhU2rK+OssajI/TEODBmZYw1q5ezDslKFkrsaXzH30Mh
         mGmFsQOxKlZ/B4u5RNJgSk0Sp5IqZ65MyojZqWXssuGMzfXJx7ksx+k3JHLw8Duy63XO
         4+UoKOr2jIAhWQApbRE0SIRkanK7bSs4m3tad9ISd/K5cUmY8/43hwZQwy7Vx49I/Uvm
         /DKN32a+XNl+xsT/ueUcu8Uq89UYGkJGtLwoDRXJJ7EiJoWxCZEcjZg9UOpXlfFskMAZ
         XZS93TB7WgbOyWHidqz9rnVys44AIq254J+WIY4MjDmTT/JNAjGFsXR7YsjDGUzk42rT
         cNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752620460; x=1753225260;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HjmjRwrY70wx2CHWgUgdB7zU+MT5vMpT8bTQPJScVgc=;
        b=VhCDDn39FLDKT1aF5Yj2EAqEBXMm1Ojjcgcc/M5+R5okmu/fAD6D/2mmU63D10Whja
         NE07A6cbqrR++lGX14XWU93QYWK3V57mwOAolWoG697ATCqYcWzBCGhSOqHr2v8Q+Bxn
         IRB61sLozctl9FJyjBQnSdx7q7QajxmdO7DBgHA6d8GrsClHzshLvBdVP4rw9ooPVrZL
         8MZRJhn2oXztMfLulpPvWYAH999CbwMR/f3p9yaV5cih4Cbkm6VLPJPF/J1NxlzlmxDj
         d5GE0MfpWsAt09MlqEC/ZjX3r/vhjzR1YtqXTuPsJbX1k7pa67oFnKehkmtZQsv3WNui
         Qo8g==
X-Forwarded-Encrypted: i=1; AJvYcCUBHbsAP/Ai7uChYGpkeiFMLmZb/zA+GcsZ1mzFA4/5ELa1P/LDi4rxfNPVAOZvGezqSUA9gjX4H9A0xNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzWTNlaCMI3noJ6jFMyl0d7QeS+E/tnJOth21WhZ0ty0L0RUml
	iGPsROhudxKZalsFFS6gohPn0wIBS6afZVetsgInb+L1KkFXDikmPTY/oRLl7wc292A=
X-Gm-Gg: ASbGnctMrSYW8E1K6GNokUZhF7A2BaQveSiXg/SbK4y36T2wa17SeWDmG3PpSsLFcrW
	62v54mnGbz1WyhAbDgd2y67kIP2+5265QymUubZlUuE60MyEUQ/stR1GE9cBOfaIUdxP1no1pSR
	HEbRm3GuLyt+j0X6TLjR267IvA1LFIqRbsi/9VAae8M44St43rcei2szYXNZoy77++rh7F22o2F
	EmSpJ5rQk0XUHxvuveGyc50jyAz/7jiXULguTafPOBr4jeKJUvKPvaHGyB6pbDjeZ56sP3DineX
	s0xV+MPRAPYVbd2+/mc/dX9OFtSR0QUIwA62x54d+mV/6DcninqJMick7xegYWl7q5bjjASquCk
	jV7AGqId+qNQRq58sGQd2F4vM515r
X-Google-Smtp-Source: AGHT+IFzTAUh/H2WsdNWY9R0rFIJq9Rr261iK4dEmF89rYSxkR/WcE1QAJcgUum3s7/cBaN7xF2qow==
X-Received: by 2002:a05:6830:720e:b0:73c:e30d:c273 with SMTP id 46e09a7af769-73e65f2d943mr315168a34.0.1752620460253;
        Tue, 15 Jul 2025 16:01:00 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:9b4e:9dd8:875d:d59])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73e54ff7384sm1012741a34.35.2025.07.15.16.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:00:59 -0700 (PDT)
Date: Tue, 15 Jul 2025 18:00:58 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] mmc: loongson2: Fix error code in
 loongson2_mmc_resource_request()
Message-ID: <847bf395-6d62-49c9-a39d-8e82c5b17bf7@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

There is a cut and paste bug so we accidentally return the wrong
variable.  It should be "ret" instead of PTR_ERR(host->clk).

Fixes: 2115772014bd ("mmc: loongson2: Add Loongson-2K SD/SDIO controller driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mmc/host/loongson2-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
index ba6bb8fd5535..63d01d2cd978 100644
--- a/drivers/mmc/host/loongson2-mmc.c
+++ b/drivers/mmc/host/loongson2-mmc.c
@@ -887,7 +887,7 @@ static int loongson2_mmc_resource_request(struct platform_device *pdev,
 	if (host->clk) {
 		ret = devm_clk_rate_exclusive_get(dev, host->clk);
 		if (ret)
-			return PTR_ERR(host->clk);
+			return ret;
 
 		host->current_clk = clk_get_rate(host->clk);
 	} else {
-- 
2.47.2


