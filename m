Return-Path: <linux-kernel+bounces-895683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D987C4EA9D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C97C34F683C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD0A3246F1;
	Tue, 11 Nov 2025 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiwSP0s0"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AB22C028A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872945; cv=none; b=bbOdFCFIJMSfboTBLadyOkEpY0ZVzydeTUrWYaXt9ZfFvCQEQTsu23SYK3eOROBUMEkYS8L8xhkuLIOKDevqCw46gOKSWbCE3n4rwsjDqDbzTPfVuyeL88YF/iTLaxeKYJEQzV6+iudXMAMv+qu78d6OzmF3Soio6fjoOwMEd4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872945; c=relaxed/simple;
	bh=poiBwz5mAEg50OMJ/f1mGkL7ppAET8+TVF8zgnle07Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1C7fwdT6/wQdKotCnaYxdXf85Ndjrm4audqdUgMwWE/EGxfH341LxyTp9TXFoI6uH9MGPlzWj/BIbpSZaGI4mYsDldWjdq0FObUzIdWvzgrSbfsej2XXUh1qdHb/7ve+kXNwdbLcigjtyTP1Q3RqJIjg2d4c4T3nRzS/gPmV78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiwSP0s0; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5943d1d6471so4298658e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762872942; x=1763477742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+2iTAdNXPyvzz+6ao8nXIdlLksRACyGhcHi8QO3xHY=;
        b=LiwSP0s012NLOVJ6Sc935al6PMrPiN4nCgoeDjjGxiEV0zPQ0oLYJOH3Tg4sabJ7Xq
         LNkxxwAecouyUbDgBn88mJSPcYCZ04rcTV0ppRokwys72urln2a2YwreEXfB1J/ga7Pm
         eyTB9CeNOi/+1J563RLy3khLdfXdsMrzRHTzoFDzxvTOgK06enHD4xsXutBW8uvXLoSW
         DQS2PhNvGbBj/C3Vb32i6mS8Zy5jOdDNFVBhdeS4yqJni5xR5lIRkrbX+Lda9AFRV3hA
         9Xr728rt+OB53k8yP7yLRNuGMuCiqFYa8bbuIsGJNl3XM2YMNPQ6rTfWWWhFu8A9ZQvP
         9KnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762872942; x=1763477742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5+2iTAdNXPyvzz+6ao8nXIdlLksRACyGhcHi8QO3xHY=;
        b=hnoK8BZATReWGgMiwdT7M0nsvozJjUdjky3rw0VoVS3swM475H6u6YtIITaQHrU8eV
         hetBu0ohjB+g7hmYRL/Ur8uq8eaLvnJA7mQa3ajsj+kWarFp5V2jfSWQOFjLnWXMwbdc
         SCOHSw3PknYHjVJ55YrqH9Zv3HKsKTbZ5IuR9uCf+GVD+OCmqKyJWIK29cZwQdnKzqXo
         qVLW/F1KxSqgEtbP3kdOQIptvHKPaDSfzeTuzmYriH1vSPT0DEr7zDRBuzrLOxLV/EXU
         d9HZkbSEVIyPp/rEtmHSqZw4jY3hSXgU7uiQRB8wdOqgW0OWwSFhhh06ObcDhZvdHdOE
         RwfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI66G9iNfptp1q9+D7vRwXywklrtl0DAF/jNkRfLiD1z0cFzP/uYa1/SIobH/4j2NLCqMxoDvi95NtlmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPFtaT9cJFjR7sTMuzDIZ+u8muaAiNFS4Pfbjokl6jbG8W6yMP
	7WyPr3JwTGNJQp6821fzmuh1UcTrpHOMo3KvL3FGWVBr2Rm+oK7o7AKOqJC2WXT93xU=
X-Gm-Gg: ASbGncuSU5390sCmPa3KXW5AsA4GBqNye3nS90Jc1qC7xva8lWKuFEguT5rUvmiiBld
	Ztw+IlOxZkWV0Uis5qvj/V5W1lv6kwWW+nQC2fqGfYt4+1Jcuo8Jp9Vc7VPdVCk8+5Uc3cnTjrY
	Amsxi2RLL3+07KkVhXom7I8pQz5Xrrb+9+qI7JACU5armLWEXjfCmDJhMs91uTpeR4r/GHbm4zh
	bWTx2PW2BMdaVbQnp31FopQrGPtoysmzW8SJHHPtQsiL4e9N3BcxsQuhabwegNDizmcaljuGuXf
	T8IR+VSacLr1tFJKIK7Z1p5+zS7lO0BssvXDpitQbIvFLwHjcLiv4C4XXC24hu4tEo1TASb1ZGv
	TgLTCZxYVkLIHbm/npI/6S1KXBDD9WeMmZt7JYl51wv9gCuFWUSpqK2QL596CI8gWPVOoEon86p
	cuK8ulaE9ruNF3xxuPYWPtJq8Ptzol
X-Google-Smtp-Source: AGHT+IFD6IXaxNvIC1u7RqWRp2Nrx86AijzV4Ae4+U9y+/bNW2XoNjpyIk+eMC+4lF0z28KBdYXa/Q==
X-Received: by 2002:a05:6512:e9c:b0:594:2d53:545 with SMTP id 2adb3069b0e04-5945f1db920mr3654712e87.46.1762872942045;
        Tue, 11 Nov 2025 06:55:42 -0800 (PST)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944ff427d0sm4780145e87.68.2025.11.11.06.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:55:41 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: p.zabel@pengutronix.de
Cc: a.shimko.dev@gmail.com,
	andi.shyti@kernel.org,
	andriy.shevchenko@linux.intel.com,
	jsd@semihalf.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com
Subject: [PATCH v4] i2c: designware-platdrv: simplify reset control and error handling
Date: Tue, 11 Nov 2025 17:55:36 +0300
Message-ID: <20251111145536.3232456-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <743a73399327e0f11825b1b50b4a0fc90948625d.camel@pengutronix.de>
References: <743a73399327e0f11825b1b50b4a0fc90948625d.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation uses separate calls to acquire and deassert
reset control, requiring manual error handling for the deassertion
operation. This can be simplified using the dedicated devm function that
combines both operations.

Replace devm_reset_control_get_optional_exclusive() with
devm_reset_control_get_optional_exclusive_deasserted(), which handles both
reset acquisition and deassertion in a single call as well as
reset_control_put() which is called automatically on driver detach. This
eliminates the need for explicit deassertion and its associated error
checking while maintaining the same functional behavior through automatic
resource management.

As part of this cleanup, streamline the error handling by removing goto
exit_reset and goto exit_probe labels, using direct returns with
dev_err_probe() for cleaner and more linear code flow.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---

Oh sorry Philipp, now I got it

If you have a time, could you please have a look at this version?

Thank you!

--
Regards,
Artem

 drivers/i2c/busses/i2c-designware-platdrv.c | 43 +++++++--------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 34d881572351..147eda5f5268 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -236,40 +236,32 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	dev->rst = devm_reset_control_get_optional_exclusive(device, NULL);
+	dev->rst = devm_reset_control_get_optional_exclusive_deasserted(device, NULL);
 	if (IS_ERR(dev->rst))
-		return dev_err_probe(device, PTR_ERR(dev->rst), "failed to acquire reset\n");
-
-	reset_control_deassert(dev->rst);
+		return PTR_ERR(dev->rst);
 
 	ret = i2c_dw_fw_parse_and_configure(dev);
 	if (ret)
-		goto exit_reset;
+		return ret;
 
 	ret = i2c_dw_probe_lock_support(dev);
-	if (ret) {
-		ret = dev_err_probe(device, ret, "failed to probe lock support\n");
-		goto exit_reset;
-	}
+	if (ret)
+		return dev_err_probe(device, ret, "failed to probe lock support\n");
 
 	i2c_dw_configure(dev);
 
 	/* Optional interface clock */
 	dev->pclk = devm_clk_get_optional(device, "pclk");
-	if (IS_ERR(dev->pclk)) {
-		ret = dev_err_probe(device, PTR_ERR(dev->pclk), "failed to acquire pclk\n");
-		goto exit_reset;
-	}
+	if (IS_ERR(dev->pclk))
+		return dev_err_probe(device, PTR_ERR(dev->pclk), "failed to acquire pclk\n");
 
 	dev->clk = devm_clk_get_optional(device, NULL);
-	if (IS_ERR(dev->clk)) {
-		ret = dev_err_probe(device, PTR_ERR(dev->clk), "failed to acquire clock\n");
-		goto exit_reset;
-	}
+	if (IS_ERR(dev->clk))
+		return dev_err_probe(device, PTR_ERR(dev->clk), "failed to acquire clock\n");
 
 	ret = i2c_dw_prepare_clk(dev, true);
 	if (ret)
-		goto exit_reset;
+		return ret;
 
 	if (dev->clk) {
 		struct i2c_timings *t = &dev->timings;
@@ -309,16 +301,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 	pm_runtime_enable(device);
 
 	ret = i2c_dw_probe(dev);
-	if (ret)
-		goto exit_probe;
-
-	return ret;
+	if (ret) {
+		dw_i2c_plat_pm_cleanup(dev);
+		i2c_dw_prepare_clk(dev, false);
+	}
 
-exit_probe:
-	dw_i2c_plat_pm_cleanup(dev);
-	i2c_dw_prepare_clk(dev, false);
-exit_reset:
-	reset_control_assert(dev->rst);
 	return ret;
 }
 
@@ -340,8 +327,6 @@ static void dw_i2c_plat_remove(struct platform_device *pdev)
 	i2c_dw_prepare_clk(dev, false);
 
 	i2c_dw_remove_lock_support(dev);
-
-	reset_control_assert(dev->rst);
 }
 
 static const struct of_device_id dw_i2c_of_match[] = {
-- 
2.43.0


