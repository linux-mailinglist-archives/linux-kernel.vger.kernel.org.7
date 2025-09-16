Return-Path: <linux-kernel+bounces-819378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B75C5B59FAC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1E52A6485
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932292FFF9E;
	Tue, 16 Sep 2025 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXKiqZOr"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87332D5D3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044640; cv=none; b=P1uKKIxt+rFVjzwo+QSCfjviivp+K/mPL4JTlxZ9lK3CFfA1X2yduJ+aTQxUJf7pYZJdxgS6tGYSSPdoKesJqFuGKZG+OEMVWR+h0m0y286hQ9Cb75qkrYnakgrnUeYgA+9+5TE2ua7nSwTJsTsRdLYixom5vkoBm7GwyFQR1B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044640; c=relaxed/simple;
	bh=mKgs+n56LLSQMG9QE/M+UFcraHvC1S2nEabKpRewBlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iczcU0ajwxPNiRo0mP19VMzX+RXUyxP9unyNGnLwRmGKiSQaiHUA1BeQ87Qer+HgH9h6azVAso8eVQSTM6k5WUKtMa6VfbUJXCaUuQ3OiQ0cR1/j38aBpwlN8DWgsv9auC7KddchBDpGr/CuiJiCz1wEC73tf9hTUZT+aa8UHxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXKiqZOr; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0e7bc49263so430933866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758044638; x=1758649438; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yb9yeYyn+7ficz6XHyvPVxnyEFz7ITRXLsOtF/kZ6LU=;
        b=VXKiqZOrGkQK9w9h/pbxSGdEPVdHf7E8rwR09aaD+BwqiQdsoKxCXD7OtXGUUy1PRC
         BQMFZx84ZsdBk+BUAeEUAWYs8jis4+e73ndT07mVuPV+wQx8wKNDe1akcdwu8osnj9Sk
         ajbdAx7U2gEoAQDaw2Dkj23uR2EiZIAaNa6DSvZLHy82FTUzthLLJLuQdkkYwU83IEw/
         TGF4oVTUKQOPC1L9lWlAaABNmah2my+kc1iSg271iDSBzyKkuSInu+J5Hd72auKUFW4F
         rzWXGDP5JUiNvMAySMEFZ9rKsitnoXYRjop74WWxeu/8fp1VtviIRBUCCcnTj7s/venB
         Etrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758044638; x=1758649438;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yb9yeYyn+7ficz6XHyvPVxnyEFz7ITRXLsOtF/kZ6LU=;
        b=lOmjxKCCKqtgCyXlSJ8YeVGHmQ+WfWRkp4l2AuN9Q9qlA7e2uWP2F/w5Qmos+JAAFa
         k9AcQEuLaOuIQhGUbAlHtdUVnjT1Pz58j2GWQ8vpIneOV+xSMnyJ7i3WjNMmswkj7Yop
         8mzduYX3vAAVfu7D1CqXHwWrR8eUDD20fMXqfXvGyzqWPVnqwS53Sp5AAimBTw45ty5N
         jhaWv0dPIz84rC7p01NtcuDZfystsr0JW/KwQplocqoYnk9rWr6it+Hg/T1U51mwbYY2
         dotoWS1uHm3UtZkmUOl/k1Pw/Rygy2gIx+A5qs73CjKpaaZC38gMsDSuo8HPp6jMyXnj
         IK0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgb7dvZcAzCxUopOpB0TMp0sI0tvfciXCXO8ZFwrvOHDH04eOSIjujzJlzqK63fgaEVXEsvAy/iEQp0lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLLyhDapNf5v0r3MnSIhFRkue3KbKnEoOq/5J2SHq3frMnz5nP
	NDE6rHzCJ821rSffEnsuOpb3ITJvM59XkBj918qjAqLCVst+pJRjEZZP3ae1DA==
X-Gm-Gg: ASbGncuG6qSlRM8AE0CYPDaVLA2mb4gkgZ8jF2iMbm3wvhkEHMe3F8WAEQsbv9Tlk9Y
	nh1YilfQw+mrg18BN8zFwwydnYBYB5hfFlrEx4AJ+3ZgUAc31nEC2PknG7yznwpzx7c7OQQLTbL
	VK6/U8Eri20cyXVHCsl1agVtz88IyUnZnO6bUkbN9yxokeig0YwzkNdVvTgc4Cf2Z9sLYJdhMjT
	rzGW2KzZkpj4UZmqjMuFjr9UTYiyUIU0AXzM9qlnyA9jNXhOS9z0OgjBvHDnpyJ3Y0i/tw+4SQT
	ztqXNrbyG0jw0ZETyJlLaOyIPb1H/cUAh4VpwYj7rBIb6z6YDZrXxPJVjoWgvP6ze8opU3k9Ge3
	jG7IgimSb0L9fmFFaHVKV8xlciYBfUhOYUjYMMmhpnijhg/VfCo7H
X-Google-Smtp-Source: AGHT+IH5l1Uw6AXpT3WeVxFHCThmWlH8lQJghDeYiJ7Wq3FJZCatyS/+o80jJ1zg9OagGHYLuLMNiw==
X-Received: by 2002:a17:906:d185:b0:b07:de95:1c70 with SMTP id a640c23a62f3a-b07de9543bdmr1258795266b.31.1758044637559;
        Tue, 16 Sep 2025 10:43:57 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b07b30da327sm1212806366b.11.2025.09.16.10.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 10:43:57 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 16 Sep 2025 19:43:46 +0200
Subject: [PATCH] spi: spi-qpic-snand: simplify clock handling by using
 devm_clk_get_enabled()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-qpic-snand-devm_clk_get_enabled-v1-1-09953493b7f1@gmail.com>
X-B4-Tracking: v=1; b=H4sIANGhyWgC/y3NQQrCMBCF4auUWTuQBKzUq4iEJDOtg3Vsk1qE0
 rsb1OX3Fu/foHAWLnBuNsi8SpGnVthDA+kWdGAUqgZn3NF01uA8ScKiQQmJ14dP490PvHjWEEc
 mbOPJho7a3sUI9WXK3Mv7W7hcf848v2po+Y/7/gGmNTmghgAAAA==
X-Change-ID: 20250910-qpic-snand-devm_clk_get_enabled-6b71a9d6f2bb
To: Mark Brown <broonie@kernel.org>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, linux-spi@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

The devm_clk_get_enabled() function prepares and enables the
particular clock, which then automatically gets disabled and
unprepared on probe failure and on device removal.

Use that function instead of devm_clk_get() and remove the
clk_prepare_enable()/clk_disable_unprepare() calls in order
to simplify the code.

This also ensures that the clocks are handled in the correct
order during device removal.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 29 +++--------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 28755dbce399d836ab6209e44f02f05532386344..58ceea1ea8fb4e02b4c9989a38d1ea38520d88b0 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1542,15 +1542,15 @@ static int qcom_spi_probe(struct platform_device *pdev)
 
 	snandc->props = dev_data;
 
-	snandc->core_clk = devm_clk_get(dev, "core");
+	snandc->core_clk = devm_clk_get_enabled(dev, "core");
 	if (IS_ERR(snandc->core_clk))
 		return PTR_ERR(snandc->core_clk);
 
-	snandc->aon_clk = devm_clk_get(dev, "aon");
+	snandc->aon_clk = devm_clk_get_enabled(dev, "aon");
 	if (IS_ERR(snandc->aon_clk))
 		return PTR_ERR(snandc->aon_clk);
 
-	snandc->qspi->iomacro_clk = devm_clk_get(dev, "iom");
+	snandc->qspi->iomacro_clk = devm_clk_get_enabled(dev, "iom");
 	if (IS_ERR(snandc->qspi->iomacro_clk))
 		return PTR_ERR(snandc->qspi->iomacro_clk);
 
@@ -1564,18 +1564,6 @@ static int qcom_spi_probe(struct platform_device *pdev)
 	if (dma_mapping_error(dev, snandc->base_dma))
 		return -ENXIO;
 
-	ret = clk_prepare_enable(snandc->core_clk);
-	if (ret)
-		goto err_dis_core_clk;
-
-	ret = clk_prepare_enable(snandc->aon_clk);
-	if (ret)
-		goto err_dis_aon_clk;
-
-	ret = clk_prepare_enable(snandc->qspi->iomacro_clk);
-	if (ret)
-		goto err_dis_iom_clk;
-
 	ret = qcom_nandc_alloc(snandc);
 	if (ret)
 		goto err_snand_alloc;
@@ -1616,12 +1604,6 @@ static int qcom_spi_probe(struct platform_device *pdev)
 err_spi_init:
 	qcom_nandc_unalloc(snandc);
 err_snand_alloc:
-	clk_disable_unprepare(snandc->qspi->iomacro_clk);
-err_dis_iom_clk:
-	clk_disable_unprepare(snandc->aon_clk);
-err_dis_aon_clk:
-	clk_disable_unprepare(snandc->core_clk);
-err_dis_core_clk:
 	dma_unmap_resource(dev, res->start, resource_size(res),
 			   DMA_BIDIRECTIONAL, 0);
 	return ret;
@@ -1636,11 +1618,6 @@ static void qcom_spi_remove(struct platform_device *pdev)
 	spi_unregister_controller(ctlr);
 	nand_ecc_unregister_on_host_hw_engine(&snandc->qspi->ecc_eng);
 	qcom_nandc_unalloc(snandc);
-
-	clk_disable_unprepare(snandc->aon_clk);
-	clk_disable_unprepare(snandc->core_clk);
-	clk_disable_unprepare(snandc->qspi->iomacro_clk);
-
 	dma_unmap_resource(&pdev->dev, snandc->base_dma, resource_size(res),
 			   DMA_BIDIRECTIONAL, 0);
 }

---
base-commit: b28a55db452edb1d997edee723d8dcbef7f065a3
change-id: 20250910-qpic-snand-devm_clk_get_enabled-6b71a9d6f2bb

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


