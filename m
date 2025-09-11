Return-Path: <linux-kernel+bounces-811762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29228B52D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48474586DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938852EDD60;
	Thu, 11 Sep 2025 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uni7XEXv"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B452EDD52
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583819; cv=none; b=fGrPl8KmebrwjwRKCDQLuGbdX/3vBS2WjZfYYIp4r9oj4dT6KgLxK5U1OjIEeHMjRxffKnZl2gusTbqwlG/9pHcD+iDKpfoLU+uV3LDgxbnf4HYbQ2CAsyw3j3uzBay73qzcQY7QiS97B42oIbX8qwQiknHA90uWZbsaP6M4jMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583819; c=relaxed/simple;
	bh=RkEbb4vtXH/1xa3ZAFyhmneUOFAU8k6zYcos8ICuhT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q2o2hm+yJRnLbK99LamuQMy4d56pPAhVo6GIqM2esI1bQxqmOd5NQ7y6mEWsm9NWXdxCftKUdNNdtws8rHFgJ3JdsUxDJfUpAYltwPOEJj6ymOzsCXVlwXOgY+PB5xb3s1yr0UY6/MGgTBbBfbECOe6VOxOP7HiW4B3h7z35uic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uni7XEXv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45cb5c60ed3so463135e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757583816; x=1758188616; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5m3ByHgnOeEhXsQQzbVD5zJSTnURIXU/8oB9ElOads=;
        b=uni7XEXvpezQ0f9yVmHVSHkVoU4tSlBcmiwPur3oOPgfUu0G+E28TwoaSSMqGPoRkg
         4ma7e/tA2Bx5tgkNMny6SIeAHmiT27BRKAmASZi4Yjj6dsiVVp0nyuOlOsWQXA2wvH9w
         P7L5jdQpPpjnGHfVXu3oXzLmzRs+X193/QZYPjJdysLm8I4KrAIvzBxGLkLa2tie+0cE
         1K0nVfqDl8+eAENInh9jAuoItcWJ7r5IVC2sPwDdzlVuf0Gpq2GeMSVWZcEJsRChZQr8
         00HVuhzZampz8B8F0eIKFXOV+nnB+IJbFxItayyDrFvyLY66ZnP70fzuZdbGdWa+57jM
         yRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757583816; x=1758188616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5m3ByHgnOeEhXsQQzbVD5zJSTnURIXU/8oB9ElOads=;
        b=Ek7iklwJUxtvip2Xrc4q257mFEJLa45Wi9lDO9hvpRWI/f0vsBEMAfcT1ULqaSuT31
         AOJYj2AvIoWpVJ+vFOKx7GpkU2CPduK8HaPz+8KiEtHYp16bzkkysY+rU5hA//2XkMxR
         +0HO2Gjsaa+Rks/2Mfwi75pUz47E7WaqXTb7e4eXHDWrqJlbSw1Di/OEPTiECXKc0ihl
         KwXwZV9eGk97MlZDyfVZQW3htgrgj6xHGXONmZhtQW7MzYicAWRv0/0e3zpe+N234NUj
         rgGNwxX/EmKsY6aPjdTNvgCFeWpRrwFWE0Aajv1lS285NTzb1riC2ho3yMEozsUu8iTc
         iMkQ==
X-Gm-Message-State: AOJu0Yy344JW3Z3nroUBdfpbV9COBG3crpaU2oIiqQg1tIxmXQCcl3iZ
	0G1dIFHH7mvFkF2knXPYmIKr5FnAr0SDnUnZ629fr07QVYnNsRWY2aysSscokajSZDw=
X-Gm-Gg: ASbGncsSjON+25oEJBbdufdckByqKWwh1/S2w6I8aAlBpk4cpjBWOo47NNbMqIhnKuv
	77q14kjb9fLdxcFAPP5dUMHKAtv447MuQsNPqXqMyHjC6jK2We9YRchwKiYeUqMIW5aVEfpl2R4
	7+yudj4vdcbkAO6HZ4dhO2CIB405Nr3VNHtXUMdPjAOlFyTxLrPOZbHOOARTMGdczqwsfAw19q8
	nZnrjU8yeYS6zlqYmgxuAthoAitlHM8KNdyyZU9tFgpSzW43itverxdR6MAkFrXlOblM72fRtPI
	RsTsQZyuCNtKzG8GJDIa6bE4IBGgtzKPoYtmDRr2p0pS5UcDLRzY/tYs0BRTIAMO2YEf85oIxUb
	T86Q5dNuqJ3XraE9Qxy4DEFG0tgA16DuuyXVtKghGcuOmc7xNgg==
X-Google-Smtp-Source: AGHT+IGdWCIF1BMNbE6xqBraxyICJw6etdGWZx6LlrGJw3xFOwFuyThGq1KYi3b5AvIEEioeX/sfiQ==
X-Received: by 2002:a05:600c:870f:b0:45d:c85f:5030 with SMTP id 5b1f17b1804b1-45dddea1c78mr86161325e9.2.1757583816226;
        Thu, 11 Sep 2025 02:43:36 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e76078fe3bsm1759218f8f.28.2025.09.11.02.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 02:43:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 11 Sep 2025 11:43:19 +0200
Subject: [PATCH v2 08/13] memory: tegra186-emc: Simplify and handle
 deferred probe with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-memory-tegra-cleanup-v2-8-d08022ff2f85@linaro.org>
References: <20250911-memory-tegra-cleanup-v2-0-d08022ff2f85@linaro.org>
In-Reply-To: <20250911-memory-tegra-cleanup-v2-0-d08022ff2f85@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=RkEbb4vtXH/1xa3ZAFyhmneUOFAU8k6zYcos8ICuhT4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowpm4Aa1oUYSFXi/sOsTHz4twSK2bs9ZcZMbr6
 uho3feukkKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMKZuAAKCRDBN2bmhouD
 18y9D/9R09f1RgS8aqXPAwB5hy/F//5GLx350tJRizHtJ/kE7iuk+2uhHkNeriG3vYgy4fvQ7D4
 LmjAjJB2Jq25o/QYP18SgNiNy44O/AChi2GvJX9YU4z+O1ANxod02E/nrmUn2l/d1fZI9hkfWOp
 YkITq0xOtHRTJ7SgNs1xo5pkoSSQImG5LGtrTtD/uyRLr5tvXEWgLILfarG3nJvEpGCNyBlFhkA
 UmxWNZqknk0kfLG4vTIP8lYYpK+s/z7tAVMLU+0ng3jp0aWdbiJoLl97iwRaiMe9CSkZbAjEJQS
 DgAalqcJKKTehusrhtilyTMKXNjH2I+/9dOG3B4e/FeoNy6Q43DbckzvbV0aYE6r9gytL9fx+gd
 Fdm8SYsuOoVADpS5Ve7SvNYjyIyrEKsncm4LC3p1jfPZrmAD/sg5ys+O6woBGfUs1hdI5jiIt5g
 nZwuV3tlh/OxFUfqY46kroJkHv6pZuAX55mSp7lOtUYRmMgMEaY7HocODHohsN+Zao/Wd+RRc1w
 CqIcnSIRZ3tFXLx6fTGfg1D3vM46eSWAgF5ct1z+Ema+CQRVPlTtDjPUwUFrCqJ9HBdozW7sfkU
 MbnGSbmM0Q9zL1aARXYE9W3bCNumVwxcAR/aHLCH+KfXdXLKpyvGIqovpTUuXd9Xi3/E9OFYefR
 yshHh3nnHKbKA4w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Certain calls, like clk_get, can cause probe deferral and driver should
handle it.  Use dev_err_probe() to fix that and also change other
non-deferred errors cases to make the code simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra186-emc.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 00baa7ab89214b1a151ab0c0a9ab76f90f922478..a0de80afe3e90531fcfb29d20773aed0d04478c5 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -302,9 +302,8 @@ static int tegra_emc_interconnect_init(struct tegra186_emc *emc)
 
 remove_nodes:
 	icc_nodes_remove(&emc->provider);
-	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
 
-	return err;
+	return dev_err_probe(emc->dev, err, "failed to initialize ICC\n");
 }
 
 static int tegra186_emc_probe(struct platform_device *pdev)
@@ -319,14 +318,13 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 
 	emc->bpmp = tegra_bpmp_get(&pdev->dev);
 	if (IS_ERR(emc->bpmp))
-		return dev_err_probe(&pdev->dev, PTR_ERR(emc->bpmp), "failed to get BPMP\n");
+		return dev_err_probe(&pdev->dev, PTR_ERR(emc->bpmp),
+				     "failed to get BPMP\n");
 
 	emc->clk = devm_clk_get(&pdev->dev, "emc");
-	if (IS_ERR(emc->clk)) {
-		err = PTR_ERR(emc->clk);
-		dev_err(&pdev->dev, "failed to get EMC clock: %d\n", err);
-		goto put_bpmp;
-	}
+	if (IS_ERR(emc->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(emc->clk),
+				     "failed to get EMC clock\n");
 
 	platform_set_drvdata(pdev, emc);
 	emc->dev = &pdev->dev;

-- 
2.48.1


