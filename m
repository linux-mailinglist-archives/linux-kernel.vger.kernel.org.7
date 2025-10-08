Return-Path: <linux-kernel+bounces-845020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDC0BC34BD
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007801884DAF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD292BF015;
	Wed,  8 Oct 2025 04:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="X981XozF"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077C22BEC32
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897538; cv=none; b=SLoLnc3pj843ZL9uoohPMSrwba6nn10ySaNckoXNEupl0QoweJSngoCUskZrbDtpjx1NSuZqwYCxd4n9dsVmI68Md1cqXDy0Nct5/BflmkHTWGO/jFAxuvNpDd42238nP/w0schGniUwQ+vf5/2VzQKGEGBWMjhAp2CHMBDq55s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897538; c=relaxed/simple;
	bh=3Ao8jjoBvZBqtIVC8MLuT4qJo/yZzdO/7FeFgmIHd4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABbpnQDgmPX0gh+V8YzIo/fDt5FlVAjcq1CWImVEcCG2klKF7oa27CsLp52VS8+cruTjp/DSrLJPh/RoMyH8CSnxkiV7wEUph8TJzA0Yy7WAJMHRKTB8RhvZf9FanuuZk+r1Q+5/GsUPc7YbAG9IX2JauSYt5lU8v7gNhj5Q2uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=X981XozF; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b4539dddd99so1066372566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1759897535; x=1760502335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krVPS+tcjWILrBEvMprlBs9nTWS64bL3aDSTEllEXZo=;
        b=X981XozFPtxiTvt1xFuIxbC3iJWYGlMjGGditmLOem2yclKeRZEd8bJ512jqpUwGOv
         p+MFnvovM7VBRueD/Yj+wyJ64CjceUQVnTnwLRnx0bWCm/F13vfawFgBreXVnihDNWte
         UinQLB42teI/y5fiu+h1V0SuM9qwFl5a9vtUUKWGw9d9kbYwgZnciCw5UYQq8PfxVSKZ
         njGYOJLOgjGEm0yABDWWPjOqBBbae29Yj+xkwjFm4OZKVTLCGmVw615znEWbvYv+BFQ5
         XbVFj8sT2aa2lJe2pBhwBUv9jRQYbynAQtJ6/LdGGE+tftMUZUOvkmZl6HzqebXc47gM
         oXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759897535; x=1760502335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krVPS+tcjWILrBEvMprlBs9nTWS64bL3aDSTEllEXZo=;
        b=YOmWYfd2ZA1eEggfeuBo6a8nrNI8tIcsyMTflGLcL0NYRhJIz4B6tVFU1qQpTVun9a
         ZRAxx5Cts3b5Ej3m+/CP/BOu2mqmQVSRLsJlFl91VkFvShM+DLqtDGGJB1wsHnZ/sGOA
         sRwZmOO72OI5l+lLC3gO6ivcuABA57OVxtGaNcqleZDiVk76UeP3SJknpA0YXhYnCnZB
         bXtgqLrK1+ffzxQXLbchVoBAkIrbSAbn0O2j2lLx6ZRDzu6TmKJPJOjBuzUiYphKAbHP
         AIer5I/YptWUtmyVZxj4TbpLzHvSVJE0wzDiGCMgsKBnFvNjJBxutvYGn2NZ82H9DUUv
         cKDA==
X-Forwarded-Encrypted: i=1; AJvYcCVN5hER1N8tuYaqx4yTvR+J7PH4CqalzkxqEctSUT3BqPeaeU0MfgTh4wZkBIfn7yGUpQ52dke/TyZZGos=@vger.kernel.org
X-Gm-Message-State: AOJu0YyumibtEAKCU747nYK1AZqII8U1gVEjdIfq4CZofXv4VYs1kglU
	/YDqZQISlp4zRg4qIwcAmtg4bLaTvr0lrd0fPzhiPuBnI0mupSZzo24FZz4r1Qrgqa8=
X-Gm-Gg: ASbGncu4RpBSUbgcwof/g1KlEeh19CwOVmwDKB20/q6SQyPcRXjS2v4ibcAX2H0LQ5H
	Mo5GsxdqrhKKfon5WA7IOM31J9oY8Ij/9IZyn198SVDQEoaDTCugd6bnDmKjH7qmENmtpKYzTop
	ZdSwq9+Zv/6MYTJUfQgp6aA3cAHGaA++mbHBA390VU8oeiz6gLWxdkS3/3kWlseEyRI9vJL37A6
	3SOJiXSm3tkQFN5PZP+nVtDBZfe7fyMYCIuhzEotceTJ1zZ3pXzxp4iKafRESU6nr0e1QqmlYma
	L1SahWOpubZa1PEJo7aVjx7woeVBa2SmygYznG0YVUs4ji7N9eKUcmEz0XYMhoMqGVr2GHPq4+t
	RytmRSUoDqbrTna9oHUTdLT8+PxwQLH019FoOM68HnR2ivztRq24DtbuGlzrFfezVUtiK9g/Jxj
	k=
X-Google-Smtp-Source: AGHT+IEWNGUd2OZUlsC69nHjiF4VLGxKkwz/yIUFi5UKCe5EfHzFMpRTzUw4PGXAnxeWFWWemf2FfQ==
X-Received: by 2002:a17:907:948f:b0:b40:e7ee:b5ec with SMTP id a640c23a62f3a-b50ac6c92d4mr212093266b.59.1759897535287;
        Tue, 07 Oct 2025 21:25:35 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e77427sm1583124466b.36.2025.10.07.21.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 21:25:34 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 2/3] mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
Date: Wed,  8 Oct 2025 07:25:24 +0300
Message-ID: <20251008042526.3312597-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() are deprecated now
and require __maybe_unused protection against unused function warnings.
The usage of pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows
the compiler to see the functions, thus suppressing the warning. Thus
drop the __maybe_unused markings.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 11 +++++------
 drivers/mmc/host/tmio_mmc.h                   |  2 --
 drivers/mmc/host/tmio_mmc_core.c              |  2 --
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 9e3ed0bcddd6..7ceb7b977a0b 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -599,18 +599,17 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
-			   tmio_mmc_host_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
+		       tmio_mmc_host_runtime_resume,
+		       NULL)
 };
 
 static struct platform_driver renesas_internal_dmac_sdhi_driver = {
 	.driver		= {
 		.name	= "renesas_sdhi_internal_dmac",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm	= &renesas_sdhi_internal_dmac_dev_pm_ops,
+		.pm	= pm_ptr(&renesas_sdhi_internal_dmac_dev_pm_ops),
 		.of_match_table = renesas_sdhi_internal_dmac_of_match,
 	},
 	.probe		= renesas_sdhi_internal_dmac_probe,
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index c8cdb1c0722e..b9de03325c58 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -209,10 +209,8 @@ void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 irqreturn_t tmio_mmc_irq(int irq, void *devid);
 
-#ifdef CONFIG_PM
 int tmio_mmc_host_runtime_suspend(struct device *dev);
 int tmio_mmc_host_runtime_resume(struct device *dev);
-#endif
 
 static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
 {
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 775e0d9353d5..8be642f737c7 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1286,7 +1286,6 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
 
-#ifdef CONFIG_PM
 static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
 {
 	if (!host->clk_enable)
@@ -1331,7 +1330,6 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tmio_mmc_host_runtime_resume);
-#endif
 
 MODULE_DESCRIPTION("TMIO MMC core driver");
 MODULE_LICENSE("GPL v2");
-- 
2.43.0


