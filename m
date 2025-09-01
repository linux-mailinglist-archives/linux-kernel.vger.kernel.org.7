Return-Path: <linux-kernel+bounces-795189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18298B3EDFE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE8777AD922
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F2E32A823;
	Mon,  1 Sep 2025 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZzdT1ir"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D5832A80E;
	Mon,  1 Sep 2025 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756752055; cv=none; b=fd/pZtPPLt/UKZltpPJnphSbkk7CRRHs8N9CWMpE7XpkN2cuU5ZfFgL/MeWdWZ87+suswDAD8qik/WNqJmic9K3Sy6dbuXrA965OpCo8JMK46pE/dQ+y2n3e73d6ac59M8bNxG9wpGwnhkC0O5P2YXOAM5CNyNI+gxOIGPgPkzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756752055; c=relaxed/simple;
	bh=bVjI3ASTWWEltUdaK4FfNGdsnCPoWYmsdvySx6ZeYYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R62cxMbmTGZrROPNy6jAb+xOWf6tLEX6o+t8G2DQEoU6bavLdFxO2s6LRXSRz2qt2yPUu3ONyB+frCGEYOJf2oxbYw3NvRV2LS6rKNG5EZoyA++xyFCkysljPkjxoAU1eqZVoILMlvSqZ7ZJdqQnaOoSfO7k/kfuMOxWw7+CAtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZzdT1ir; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77252278757so950796b3a.3;
        Mon, 01 Sep 2025 11:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756752053; x=1757356853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7DeDWqH8wYhNot7WnxoPcAYXoxWoVz3/zDldviAMp0=;
        b=YZzdT1ir/nIqTJQ+QvKakojgBxza4fl8M6Y/pVxrOL8gxEAQ/sdF+DCeropy3zExBO
         b8Y5z9KIxSXt48osQOk5A+eGIMDQwOFmP7tqbJb6KyJ49xnlFUdN9fSDHKcOkfvg+5aH
         89pItEw9Zbh1I1q4YqCaHGLint2cfPGRPrgIhVTo4Nfd2dgVga2z2u3IQdxHq7DEM+fD
         yb1lOWk0plviilVjPRjv7LOJfRk8keH9Xn/OnIig8StRTUXiuBArWvUwO97Q6xycUWko
         bjQwh6oaL2aG7h5x7CrBsaKDCDH0NNF9Enpy3ovOdZr1wG9Nue821maVc7bT7YXGW9//
         OFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756752053; x=1757356853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7DeDWqH8wYhNot7WnxoPcAYXoxWoVz3/zDldviAMp0=;
        b=mMHTwlw097FFtoBwYHvg7ObVEIb+5G+sMlNg8/LJWGCEnHLw4gkeWC7cybTM7DKMT5
         ETTDhHFqhZ4sbc71e7HAqlk0WX9XJNswoqAfnnD84StEZRZ4yVetyDwwCAPIFW/ZM+9i
         TCohpzQzInGKwAe+hLd+TQOSm/+eFpz98KWyA/74I5q1z7VdwUqzabsz0t0tMAr9Pb+8
         8Zwl28Clt1MIK+tVh+bTRmFxQGlDGm2jwSQLZSV1tlYtfHGKIrKzHsEymt5AQYHXMYiL
         86Cd7OKIMvQJMw5bcHRRd/Hmh9dpm7sf/PnjpAOZ4722x7UuyF1B3ikNtZID2OkxdjrB
         Lktg==
X-Forwarded-Encrypted: i=1; AJvYcCUz9ZPATXkBif8Oh1kIRFrm9Kt9blhxwj4b2Zj4QQPoLcmZSRR1qQqzDtkiHmRYVoiydNpAmAh83i30Fok=@vger.kernel.org, AJvYcCVCrpCQ7hBuosCmEMCAJWeH73D70Zs9iOE9ZRKLRM009CfEMNpfP1+JSWfsoZqWN3QxZ10eOksCZVu7e7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMiNrP60OsAjqBPFi+fczDhP/DM/Wu4Xbj8w7GLZPwpenDLECJ
	cpH5dIoD4MLnn+iR/Yrkbig7CbjLyTksye5Gt1gef5JlAOc3QPIH1H3x
X-Gm-Gg: ASbGnctDQlQ44j8Wp25YOJJAdAlllOVSoHT3hN7vCrPcBtpcVvCkqCdAoX6/WQogKtZ
	CnqjcmozkVxMN90L1yjAaxmnk14/gDr9WfH3lAu5ETDOP52HNe0ZlTysdVazs/jmd+zkHQW57bz
	r5f1gX6fli8gA3rBP6GnQtU/jSXAeTTGeC9OSAJ25rpjwQR0jyFzSjk6guqHnO0l2nwCFDYfpWL
	3DL+/xQ+3WlbrSw4EPWvkyFIGSiapdOUB9EcKWL0N0ypBlkwstGf6GXZ65rDBRPksZXOGUzeXa8
	Va6Rx+1N8HmxVRbWMFAAP+aj0o6SSc151ef6+zvIBtC557gtCdvt/xT6aEDjY1klv1yfAylpIEV
	l8I/yYSNTmm9/rhktkZ8+lw2UaCVEIq4u3UQWQjs3SK7EEfudtT5HGQT4O3hMqcY=
X-Google-Smtp-Source: AGHT+IGPSI2opYejr2p48bBaXvMx+ZJhg4jl4U8OHSS/IbewuOmBpwDLgpe9og2Eioj2wcUDT2UugQ==
X-Received: by 2002:a05:6a20:72a4:b0:21a:e751:e048 with SMTP id adf61e73a8af0-243d6f0a632mr13384415637.35.1756752052876;
        Mon, 01 Sep 2025 11:40:52 -0700 (PDT)
Received: from fedora ([172.59.162.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77236d7eb7fsm9436621b3a.54.2025.09.01.11.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 11:40:52 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v3 1/3] ASoC: codecs: tlv320dac33: Remove unused struct tlv320dac33_platform_data and header file tlv320dac33-plat.h
Date: Mon,  1 Sep 2025 11:40:08 -0700
Message-ID: <20250901184008.1249535-3-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901184008.1249535-1-alex.t.tran@gmail.com>
References: <20250901184008.1249535-1-alex.t.tran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the tlv320dac33_platform_data struct and header file
tlv320dac33-plat.h as they are not used anywhere in the kernel
or outside this driver.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
Changes in v2:
- Included removal of struct 'tlv320dac33_platform_data'
  and header file 'tlv320dac33-plat.h'
Changes in v3:
- Split into separate patches as per request
- Moved inter-version changelogs after '---' line

 include/sound/tlv320dac33-plat.h | 21 ---------------------
 sound/soc/codecs/tlv320dac33.c   | 12 ------------
 2 files changed, 33 deletions(-)
 delete mode 100644 include/sound/tlv320dac33-plat.h

diff --git a/include/sound/tlv320dac33-plat.h b/include/sound/tlv320dac33-plat.h
deleted file mode 100644
index 7a7249a89..000000000
--- a/include/sound/tlv320dac33-plat.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Platform header for Texas Instruments TLV320DAC33 codec driver
- *
- * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
- *
- * Copyright:   (C) 2009 Nokia Corporation
- */
-
-#ifndef __TLV320DAC33_PLAT_H
-#define __TLV320DAC33_PLAT_H
-
-struct tlv320dac33_platform_data {
-	int power_gpio;
-	int mode1_latency; /* latency caused by the i2c writes in us */
-	int auto_fifo_config; /* FIFO config based on the period size */
-	int keep_bclk;	/* Keep the BCLK running in FIFO modes */
-	u8 burst_bclkdiv;
-};
-
-#endif /* __TLV320DAC33_PLAT_H */
diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 423b9264a..36b3de75a 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -24,7 +24,6 @@
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
-#include <sound/tlv320dac33-plat.h>
 #include "tlv320dac33.h"
 
 /*
@@ -1462,16 +1461,9 @@ static struct snd_soc_dai_driver dac33_dai = {
 
 static int dac33_i2c_probe(struct i2c_client *client)
 {
-	struct tlv320dac33_platform_data *pdata;
 	struct tlv320dac33_priv *dac33;
 	int ret, i;
 
-	if (client->dev.platform_data == NULL) {
-		dev_err(&client->dev, "Platform data not set\n");
-		return -ENODEV;
-	}
-	pdata = client->dev.platform_data;
-
 	dac33 = devm_kzalloc(&client->dev, sizeof(struct tlv320dac33_priv),
 			     GFP_KERNEL);
 	if (dac33 == NULL)
@@ -1488,10 +1480,6 @@ static int dac33_i2c_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, dac33);
 
-	dac33->power_gpio = pdata->power_gpio;
-	dac33->burst_bclkdiv = pdata->burst_bclkdiv;
-	dac33->keep_bclk = pdata->keep_bclk;
-	dac33->mode1_latency = pdata->mode1_latency;
 	if (!dac33->mode1_latency)
 		dac33->mode1_latency = 10000; /* 10ms */
 	dac33->irq = client->irq;
-- 
2.51.0


