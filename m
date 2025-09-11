Return-Path: <linux-kernel+bounces-811758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD41B52D82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2A3A08543
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15592EC0B6;
	Thu, 11 Sep 2025 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="icRsZ7Ty"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478062EB869
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583815; cv=none; b=dLFWiDqbpKtpiLxlkTFGF13/YAqV9vBSNdw6P7b24I8yv8lQj9tnroT1Puw4INo6hscrtjtJfytCT/OEpyHMkxtYj1s91xbJBL9vicw0oh4mKb/QaY2/vwvzRimx6+u2mDrK5Nu/ABRmjdZGZkB+p3f7mUP7Lz6Q+fvtkbFIqy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583815; c=relaxed/simple;
	bh=cFuDo5Z2uP1vNw3Fz9+yS4AQ1ai8HrNLm9qBQebCrJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p4f0P6/Mdh7/NNbU52H56cwO7o7sZvNka5VtoMxFKmfOAaZmLNRQxxqX2qIA0MR7TAEsM/WEy9HJF0KF+GzIZbfOYr7M6n4o8bLiJ0qi4BbpvAwV/QUGW7J7pXYT3LUjsqLs7Nr3WqqA26BvrRAQ55brzs7Q41yxnBBR9SVo7Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=icRsZ7Ty; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e35d87f961so80822f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757583811; x=1758188611; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZV4GDPvDgh6nloAqz+zBTonlpmiF4OqD5ra6XGnPRtI=;
        b=icRsZ7Tywg4DHrqE2CMVaIIliy1uN13NdpCs7HE4043f7SvRfcZ3Lsbtxe5nbz+u4N
         fprnk/eWYh8RMUsT66im6dK4tIVIS+c4t65KJm3GIs5BYqhOB/C/wPclZcIK0R3oeF+O
         l+MW0e5nrjH/M32NzW97Bg0vujgCfHyb37WQWTUKNfjzLU40qGmTJ1KItdY0Hj+u2QzN
         mbHzP465q9cgIBfnIdxHhOh2HzCs/IUx1Ht+3NQisLbL5VZdnwacHyj43so7QKlZnxHw
         pUMU3ywTSFieHFck/sinD9lLGILAxDjW17k1Bi50Guesu3kekm7EJwl1M8j3wMe+jNwR
         K0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757583811; x=1758188611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZV4GDPvDgh6nloAqz+zBTonlpmiF4OqD5ra6XGnPRtI=;
        b=IJVtRhkT4QZIeE4Lt8WgAb0s1PEg7XeTJkKCbcatOCyO3zC64RQPd+h0Q75hY6+WG0
         VrNrzDcppmljhIqtzwigyscomIdvB48BI3WvmTqo3wWujt99PwyWExt0+LToQVcx3/US
         I4W6uBQZnqfYSGr3+I2E/d7qQCOzN2LowyqNJkDUMG0S0/2KwkHFGL2pc6Qi1wKTjrIW
         HxkFFD1dKCXNGBvU5vIEplaN84MbAzBbXkRObdmZU3iju7x4370fPb8ASEq5kJsSdRfu
         +MhCTtZfudJ6haim2gQEHDXeigJT96DPhj4mNzEGsm4SqG7GgpnUpQXFUprmR9O1F6fc
         HHpg==
X-Gm-Message-State: AOJu0Ywp5OOogzGdTEqpPIMRlyRggyLoYNEMeM6FH+sYSjIEPxQcJN6e
	/F5xQrM4qOakzK83wycdH7PWtIIdu8F4IEd2/iFk56aRdE9hbZUYYOLPCZIxC/tD5eoTb8snXC/
	Xqu9L
X-Gm-Gg: ASbGncsEduIjCIqn0b/SGvqoiMsR+xUoWBfHITGtF9a2F3a9n5GSKWWAIJtTYZlBLo+
	gkaHHyLUEDOyTRYznf8gM2CMX50zEa+4hidSKxAJxobYIjFwRNr+tc/+6nwTT6t/8r3665gYFtC
	R5LwJVMbi/JrHXnL9N9asQ2ZEgOcH0lssQNampq0GAy9+BPunJBqCBhy8evhMoZYRtrEigTRRgB
	2ffjP27BViV8mUhMox5HFRB74w1GHGqcHL84HO7Sv9mGJqBmdxSFZ8WZC27zhuNCuelrF0/7Lp1
	8Xjmvl63WEed1dkURJMJOjslULg1+Si/KLCLaTiLpp3C4k2ivm3YUFhqQDv2xUzWRKU3wP70OGR
	n/vYWr6xjOLsrWJitu+CVc5fmYA6S9lu4cbCcuco=
X-Google-Smtp-Source: AGHT+IH77lDTY1FG+waVIQeOJyVVL9Or9NAxNar8nZmacm66v/uym9jeHrXA1F4tlBZ3X+fRq2nh2Q==
X-Received: by 2002:a05:6000:2f87:b0:3d9:9347:b303 with SMTP id ffacd0b85a97d-3e63736d448mr7526749f8f.2.1757583811512;
        Thu, 11 Sep 2025 02:43:31 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e76078fe3bsm1759218f8f.28.2025.09.11.02.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 02:43:31 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 11 Sep 2025 11:43:15 +0200
Subject: [PATCH v2 04/13] memory: tegra20-emc: Do not print error on
 icc_node_create() failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250911-memory-tegra-cleanup-v2-4-d08022ff2f85@linaro.org>
References: <20250911-memory-tegra-cleanup-v2-0-d08022ff2f85@linaro.org>
In-Reply-To: <20250911-memory-tegra-cleanup-v2-0-d08022ff2f85@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=cFuDo5Z2uP1vNw3Fz9+yS4AQ1ai8HrNLm9qBQebCrJY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowpm0yiG9Cj04MQgd2COmd7fb2PCwWZ53WboHb
 erTOHPEy12JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMKZtAAKCRDBN2bmhouD
 13iLD/4xs7F24EsokEgirdfDDqjkHbCsP1pvzcEHDuqKtBhh9tI0UdQG68DH679lLSyTxjZwjbw
 1JTSwBoTjx8mnORC5X6aYD4LxtWs2eughZPa1+ahT0wUfPFhSWzvXIFFRy/1W/Dh8ZVEGFaG05u
 iqpxaKwmzafZh1OsdZ8cjQeFiNs5nPNRg7nMs8s3vEMaAAxCuXPTo2XkEyNqpq70SY+gMox4eEE
 XB8wBqlO6+GJbqIz8kEL3Bj8G5l9kj/Fnkes4Va41KeLuOUKDOnQYG+amcqDFWSAnqwc+ot6bxA
 bBT6Jo9Zx+1/rIWxhAkuchtdMRPdOBjeMs2t7tQdQ3HJS8c3OllDPk7SwlLbn5beSv8Beluhkrq
 q2ipXGTCmw8H/GkreviP1zJl0d8Mg4oEEgKQ64q+LQKHxCIyzY0OgQ2vROmNakEv1mfsx7hx7vi
 5yur8Fc/reChCG5CxqQF1PzYOZczRaWQLtqNYUC/m1SLM00dMjIQzVLlgWw1vTQvRbGfNCM4Rgv
 SaT+icMtmmfzOw5l3WDq+3WzpWucSvMykxXN3snkBHprG8mdN3swENO+pnFf+g73ZzsvrBA9bda
 Of0r0SpJAajHUaT9U/E9+e5zDCYVtmi47O3tLUnDEqYxnV5nBwBVwvdY6of3LTqLJj55hWl0+gN
 4shsc3mcmwACJkQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

icc_node_create() is alloc-like function, so no need to print error
messages on its failure.  Dropping one label makes the code a bit
simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra20-emc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 44ac55feacd3eef0bd095271bd3dceec60c34bb7..a34636a1c4c55419c323eabfe96c5f27375df344 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -1022,10 +1022,8 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 
 	/* create External Memory Controller node */
 	node = icc_node_create(TEGRA_ICC_EMC);
-	if (IS_ERR(node)) {
-		err = PTR_ERR(node);
-		goto err_msg;
-	}
+	if (IS_ERR(node))
+		return PTR_ERR(node);
 
 	node->name = "External Memory Controller";
 	icc_node_add(node, &emc->provider);
@@ -1053,7 +1051,6 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 
 remove_nodes:
 	icc_nodes_remove(&emc->provider);
-err_msg:
 	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
 
 	return err;

-- 
2.48.1


