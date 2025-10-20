Return-Path: <linux-kernel+bounces-861363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C92ABF2895
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC07189567D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046883314D9;
	Mon, 20 Oct 2025 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ypQCze4x"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F43330B17
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979125; cv=none; b=e7ChGmuIuGqHwAXaafe3UXR9mTGX6axbBrWRT2/+4dxE25IfVHfeKO13z2ZkeWgkY0/kcTDRGTWlPDWFX9Fh4T1/6GwXyO7KcO+o/J1fFdULKWs1qIkOnKz5ifBzb7w7FrVsXAI/Go8tvwfbtf6kME0co0iJbIhACBj9aLvktu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979125; c=relaxed/simple;
	bh=uePi/hbf6hWUzA21sUbV+8rs4D8g62rLtBk48VZwAjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TM3sxTL1NKbd2SwWacQej67oUEy8/+76Nj7neYnFMp7v6j6qY0kXc39seSJ5heO1EyTnIMiTPYh52rBNug7NVwhZbxHWQsRJvi+DCxEN+gzeSm9F1VTnHBh9tO+jQX1tMuaNyLbcBKwAGXx4iTUBlYDnSReYDudXe4kMflKxoVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ypQCze4x; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-430ca464785so30230005ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760979122; x=1761583922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQXVbISA4WvqnIZXTg13FJ7YaYjfMgMauMrkyToUbl4=;
        b=ypQCze4x5DCXx00AaRIUgbEp50LjIVoe/1NXkIV47o67NduiZhjYyMUFq7h1H4hB8E
         ftZFP83bxpkXHyIm8S5oy+cLQXvbrfY6egmWCR7u4nFXG4AdgEUOEO6RiosRF5HTPz2/
         td7vENeNnDmz+Wuso5v/dgCXPeE9AyXtxmWEhUSv5tdmC1KZVeShrq2D0DuPlsA5o977
         r3Y2DCzlWV1FFA++Tn2rulwQL3C8xk9oKVf5sr5ibroEOfxR7/g08SjZTIo++p78HpSI
         WXRfoa42UoDV8GpLmfavDvBit4UaIvr1KOu5PGjddKgwiMzyPKuW/qb1ELfhWl3+EdCM
         bH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979122; x=1761583922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQXVbISA4WvqnIZXTg13FJ7YaYjfMgMauMrkyToUbl4=;
        b=lr0aA9Gf1ywajnxqG4CWB0bb/wmSenO2+XyU1LkZymzqr8J3jsEOIqThWLYNnv0vQt
         Pkw31xJkwu6fLp7fp2uk8us4/Xinb5o2PXNx+n+rCFDyeAiw7/HUF7MKIouKrk1drxrY
         uvJ7hK5vCfILNuaj3DNbhIjK2L+Rc5SunbJJOtH+zUb9Iftqdk3jiSQASaTO7wmsGp/p
         mk7ketzjx+WGl7I3rQQSQES2mPShQtPa2hD4OJ4UpeqpuatGX7nGzLiE43V5/lQDd4+H
         2Osp/kzRuffX07v4TaEEgWHWFEcRYvBCvuwhRLAzX1TS8MxThLpSzXx8lkSJAs9cgERT
         R4dg==
X-Forwarded-Encrypted: i=1; AJvYcCV00XI4dNPuT2wgyljT4Xrwol15tr9DiYS58EF5puzR2GoZIpZ99R66spjuOkRA9+OALssFGpLg/miWlQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywit+Ep3pdt2nULFHBDTo/0WNtjbd7suEDrDSCUhvaYwcduxxCd
	aU09flatQsl30AMycsfW8ZY8adjiGv8KplmR/AOXvF7yqWu2Ssh43cxxQtQLR5net+0=
X-Gm-Gg: ASbGncvGuDDB2+ubyLz8bHC8sCtbcv3IqEf0i3XJNy6+RKXueFb6Tcngs9KOXdldRX+
	5ts2JvL6En233+0NXFjQIQsy93kwkd1ecDxwF7L40rOnbzAZ6+MvelJeKAySwQ75wKUqB4ApseN
	mhHcr+fPJuBWNI8pgCQzhqRdR9xzVroQPFGQC0rW0THbSYj0yDE8nEy7x0Chzqm3GuCMIoxjHmw
	zc63UNAz1PWvhdZ0Hf4NEq5VjkFuaVmQNN3OcYlR2L7qLq+oTXQb4Onz2Jwyp1G9NSG/SmYLurk
	HV3sr7nes7YZdmB/mDC1zcvb0gQ5bzWRONlBsOTIFTTeoaSHF6xHl6FU59NA8b0sHOknTrAic8+
	mEVSQ806KhUvnGMCeNCCzVZd9VJepKKgF5npAbalP5t4mzzS3ScWvX+aihWTYl/+rn0Ehln/I+9
	hX2d1x+aFw5f6zAmr3rDhzqJpGuhAC4qJVYepIr8HA2QeJQie8/5LhOw==
X-Google-Smtp-Source: AGHT+IF2Mm9OQGidsZhPs2Ov77+yd0T2fLJcTJpQ1EVmkmzq5AdT/vC3cNejClhwLlxQGd1xeq/XeQ==
X-Received: by 2002:a92:c24f:0:b0:427:6e7f:89f8 with SMTP id e9e14a558f8ab-430c5263cfdmr219177275ab.10.1760979122272;
        Mon, 20 Oct 2025 09:52:02 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9799428sm3116783173.63.2025.10.20.09.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:52:01 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] spi: fsl-qspi: add a clock disable quirk
Date: Mon, 20 Oct 2025 11:51:47 -0500
Message-ID: <20251020165152.666221-5-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251020165152.666221-1-elder@riscstar.com>
References: <20251020165152.666221-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT K1 SoC QSPI implementation needs to avoid shutting
off the clock when changing its rate.  Add a new quirk to indicate
the clock should not be disabled/enabled when changing its rate
for operations.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/spi/spi-fsl-qspi.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 1e27647dd2a09..703a7df394c00 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -197,6 +197,11 @@
  */
 #define QUADSPI_QUIRK_USE_TDH_SETTING	BIT(5)
 
+/*
+ * Do not disable the "qspi" clock when changing its rate.
+ */
+#define QUADSPI_QUIRK_NO_CLK_DISABLE	BIT(6)
+
 struct fsl_qspi_devtype_data {
 	unsigned int rxfifo;
 	unsigned int txfifo;
@@ -306,6 +311,11 @@ static inline int needs_tdh_setting(struct fsl_qspi *q)
 	return q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING;
 }
 
+static inline int needs_clk_disable(struct fsl_qspi *q)
+{
+	return !(q->devtype_data->quirks & QUADSPI_QUIRK_NO_CLK_DISABLE);
+}
+
 /*
  * An IC bug makes it necessary to rearrange the 32-bit data.
  * Later chips, such as IMX6SLX, have fixed this bug.
@@ -536,15 +546,18 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
 	if (needs_4x_clock(q))
 		rate *= 4;
 
-	fsl_qspi_clk_disable_unprep(q);
+	if (needs_clk_disable(q))
+		fsl_qspi_clk_disable_unprep(q);
 
 	ret = clk_set_rate(q->clk, rate);
 	if (ret)
 		return;
 
-	ret = fsl_qspi_clk_prep_enable(q);
-	if (ret)
-		return;
+	if (needs_clk_disable(q)) {
+		ret = fsl_qspi_clk_prep_enable(q);
+		if (ret)
+			return;
+	}
 
 	q->selected = spi_get_chipselect(spi, 0);
 
-- 
2.48.1


