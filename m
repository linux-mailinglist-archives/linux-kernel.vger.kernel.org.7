Return-Path: <linux-kernel+bounces-845021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AF9BC34C6
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A21F350B27
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38EA2C0271;
	Wed,  8 Oct 2025 04:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="R0gPE6xM"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F5F2BEFE7
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897540; cv=none; b=f7LsU7jp6NwEYFW/r2vMWGjnVrijJD2UtPm6eYv9WCvIW6Kzr0LKL9gSR1RHsXGsB0wM37Y/dWbo8AYfV5UyBmtEUVFS+fz0TidmzAvpyHSqY0fu6KsbfPcuePLO1iPZlAjWpMItC8azKHURwrJQ//pLgALyV7Te6FCAMjQ1UAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897540; c=relaxed/simple;
	bh=/cwkr9llp/mR6slfiaeDTI1dTaMIIZN5Dk0EHahwG00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R71/y5t4rJK3U0AFcK2BjoLwXlX9Cmw1pDfTwLr/PAwBS02o9SGy2xP8dijlhjaVQT2edKdxaWDJ6zg8JNe+jdE7plpWzguVE0tu72rpdjdTd3ACD3QxgCuDVNH+oWD8gsBoKZjimotr43Fh95tXF7mXvTL1xBxrhVCxUTmcTuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=R0gPE6xM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b4f323cf89bso342870366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1759897536; x=1760502336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iosQWc3K2vVa/XAvobbGpvWGWDlaRdHniq3qdqd8DhM=;
        b=R0gPE6xM8Pg5WRAWPEV3gWgeEpFQpa0w+WHJmWhCxBpGyKCAQPjMQHL/kOqZyrlacK
         bzIFP95kO0wdB+5Fh5GQ9rVsu+oEDdFJDITcBYl3fObG9Xs5cxBnXJpqooc9jCcEZb/m
         547CO7TdlJZyUyTwU6yc/SMRW/5mPWNTzgaon/3HljFlFZOWYetiXS0Y6Fj/8lp5tc7g
         7hZSrLZsEmSrLHfVo1+DSjvxYIqmLwf/01fMd4q8mt3Ui3MlUvnfYhCqZUoOEnw+QVCm
         GRSAxzt/iVnRBXcaFFhL2BreynV6BCejZ6iZ4BDJGuTA2aU1Qaj9/nDr7ZAGlp6bW9TG
         XqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759897536; x=1760502336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iosQWc3K2vVa/XAvobbGpvWGWDlaRdHniq3qdqd8DhM=;
        b=qjNOxenaOLI883XtbnboCfw3BEgA32R6fR0LO+AlTOTIjlDocvetiuHwl9/2t1szBU
         w0P4bAlY0hlq1ZInJrssvauowtnzf/yip0jjWi+OffTWHkofvgGbYn/LbtMg0EtSApj5
         YkALAldw6RsTIs1+NxIvigrEPnMXi3JmfUFAbclC8EqKvRMlSGbF0kl5Z7E08AXOMQVj
         EIhTg4/10DnTG9OqIZMIGQG133uVAhJFn0XDR9bXLcqW5i4G8M1+sUakjSdepM4ovWZO
         bckJwF8m9xaQy6qXYC/ZvhAJ9OZFYmHYFpRa3n8GRDF8oF43qELRtjsB2WnwzIl9hvnL
         reSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRFPob10HNr1VxQo1YoGMHDv/E7fsuxl7iF3MMZejHhnMCXedV0g2pL+lRsDewF/R6mAF84HT/Sn2Yxds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze3mL/irtAQIr8nZIU/t1w8Oz25EAfB5Yfg+I8pijn7f9gcj5l
	t0x93VHu5LOxr8Pwm7OXKrDzyZFZD32aT2TIdIzLjFHfSDPlEFtBp9Bu/gex00yNvVY=
X-Gm-Gg: ASbGnct+ZJN20VgNY64zlOxhMrUxuDWutfAYOCdmv5y/lsmZhCQQZ53hJy1e7/1TlU9
	ifKqLaIsgJgzRoqmxfJYoSH/b2P8iww+xQgG28RAZitgD79S1FzKyFahfs6nptWACIElWuBjN3K
	EYSDv3EzukWjZZ58VEIFnZYDz8QLdE2goCvTGdcXLUqoq05LGhb7ReMfcYY+MbDJ1uSaJKJcF7X
	JkKkj+dhV6pPxmGnZBZ82jMjpWpxmeRTVSBS0dXwGtyu1pcSf/iYotoywVhgV3SYNx1j+c/vlCV
	lJ9iDrxCIo6d6L/mWQVyXqeFI/bIRsF+oQGrTAALPnRiM7RXcGwUFZWC/HtXjGOYSiQJujc3ke/
	Pj9JpuBSo92opPYpa9umlDxntodYIJCTC7btZ/AJx+E7DkhYxWfD34dg6BSjwX13HOugPr5qNnE
	Y=
X-Google-Smtp-Source: AGHT+IGeUnd2/6aVeIDKjhrDUfDyL/wkoJPBTkCJVt+SNcjIJPmnFTJLzgMbr2ZsLUVCNbNaLjPvlQ==
X-Received: by 2002:a17:907:3e92:b0:b4d:2ac5:81b4 with SMTP id a640c23a62f3a-b50aa48fc85mr225136266b.19.1759897536567;
        Tue, 07 Oct 2025 21:25:36 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e77427sm1583124466b.36.2025.10.07.21.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 21:25:35 -0700 (PDT)
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
Subject: [PATCH 3/3] mmc: renesas_sdhi: Add suspend/resume hooks
Date: Wed,  8 Oct 2025 07:25:25 +0300
Message-ID: <20251008042526.3312597-4-claudiu.beznea.uj@bp.renesas.com>
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

Add suspend/resume hooks which assert/deassert the reset signals, along
with forcing runtime suspend/resume. This allows using the driver in
scenarios where the resume is done with the help of bootloader and the
bootloader disables the SDHI clocks, resets, IRQs before passing execution
to Linux.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h               |  3 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 37 +++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 084964cecf9d..afc36a407c2c 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -9,6 +9,7 @@
 #ifndef RENESAS_SDHI_H
 #define RENESAS_SDHI_H
 
+#include <linux/device.h>
 #include <linux/dmaengine.h>
 #include <linux/platform_device.h>
 #include <linux/workqueue.h>
@@ -107,4 +108,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		       const struct renesas_sdhi_of_data *of_data,
 		       const struct renesas_sdhi_quirks *quirks);
 void renesas_sdhi_remove(struct platform_device *pdev);
+int renesas_sdhi_suspend(struct device *dev);
+int renesas_sdhi_resume(struct device *dev);
 #endif
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index c4aaf534868c..2a310a145785 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -31,6 +31,7 @@
 #include <linux/platform_data/tmio.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
@@ -1317,5 +1318,41 @@ void renesas_sdhi_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
 
+int renesas_sdhi_suspend(struct device *dev)
+{
+	struct tmio_mmc_host *host = dev_get_drvdata(dev);
+	struct renesas_sdhi *priv = host_to_priv(host);
+	int ret;
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
+
+	ret = reset_control_assert(priv->rstc);
+	if (ret)
+		pm_runtime_force_resume(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(renesas_sdhi_suspend);
+
+int renesas_sdhi_resume(struct device *dev)
+{
+	struct tmio_mmc_host *host = dev_get_drvdata(dev);
+	struct renesas_sdhi *priv = host_to_priv(host);
+	int ret;
+
+	ret = reset_control_deassert(priv->rstc);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		reset_control_assert(priv->rstc);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(renesas_sdhi_resume);
+
 MODULE_DESCRIPTION("Renesas SDHI core driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 7ceb7b977a0b..9347017d47c4 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -18,7 +18,6 @@
 #include <linux/pagemap.h>
 #include <linux/platform_data/tmio.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
 #include <linux/sys_soc.h>
 
@@ -599,7 +598,7 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
-	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SYSTEM_SLEEP_PM_OPS(renesas_sdhi_suspend, renesas_sdhi_resume)
 	RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
 		       tmio_mmc_host_runtime_resume,
 		       NULL)
-- 
2.43.0


