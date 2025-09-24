Return-Path: <linux-kernel+bounces-830558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D110B99FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D43617A4F38
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E66A302CDF;
	Wed, 24 Sep 2025 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oguRnnOk"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD3330217E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719277; cv=none; b=fz77eTtMBY26JmlKZwYi/iw9fr/zWX2GI0fJATty0Rpux2gPpnk/C0jkGkvP4fWVZaprigkY3gMZHXDdbBOgaSLQYmFql2a6HeBEK/NkuvU1x+ZpR/oyh3lqHA/n2LuQ3FVR7HxoVjOFe/bZJN+xH0EsR8nX5iMZoHssJ3vdYIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719277; c=relaxed/simple;
	bh=/qGCNh8abWDm3X5xS+Iz+DznKUJ2gBpds0vUYbMtcNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhdjLvjnZNzUl0+YE2o8+yiu9JMAGaKoNYoO5fC85GVHPUBSd4tDnHJwVaxLQAU7HCdwh38XsWAKw6Tzdr36AXGg41AndUcGaKSdIMvpekFgm1yz5EIIjGmsRur2KT4yJWodhfW2EDpZJXlkcBL2NX6POpVaCSkiWOtodXeqBCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=oguRnnOk; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso11397762a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758719272; x=1759324072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pL2uoqzypHbRpbvTBPNzb3YECUS6GHGmBJvJaUK0ytc=;
        b=oguRnnOktPA0WABF8aBPlE7cgLZlSmbcnk9eF5JEw6pmOtIaJuqj0s6or6FcAav7RO
         0kEv6k1ISG7aj+ikrw5QD1wWdP26IwL8KCFaK4piXcnujxcxqYjs3k47eGf7ndIB49Ri
         QLTHEIqXhu6aaDV7KzK5n3AwFUJ7xTHk+hGYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758719272; x=1759324072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pL2uoqzypHbRpbvTBPNzb3YECUS6GHGmBJvJaUK0ytc=;
        b=TjrVDB/hIHcNwd1O8FIV5Czt89V/T8VqNDROcUKb3VXSQr+cRF9DUYrU7w4lCyUSnq
         S55P+eOfOlw09WoXqGY7CXBpUqTtZ3Qi0h+mm19PuD/AdG877Ud7TDyy4l2OlAiaOQGw
         FA5NIbCoZsnOeHfBXcvVU4Usv4KQIVDI4mEbTtFT+G+T2/SU3I91lpgFaDvHPBjy/lv+
         8AQpZHat5A7T4ZAiGGqyoaD1gXvVbUg0gSj4DA0j/pfNtZXTVK0q3om83bJl8MKPVn5K
         Oeek7EkAAFSBtsNrhP+MN+EQczKiuSixkT645n42IfPiWMSL5ItPe0ZotYXrMw44b5A6
         X/xg==
X-Gm-Message-State: AOJu0YzH1CN7GJUU6mdA9cWmxVKhvfqMI0LVkljhi3cKC4Z1v5eOYfE6
	tyrJAKLxd0WPEfkvpbiHmQWaPIajjGo578X7QZKhsPRij1ZQ5LDzTW/eg9rnhqZdXhvYJaTC9XT
	HadU5Mx8=
X-Gm-Gg: ASbGnct7F7oVDLv/M8BzARlBYH8leQAxnLKHIZjhv0Vvl36QEkJQNNTWvn0R5gwrYCH
	YsB9b2t1K+VyTTsiHCU/wMDfJsVFtEdemnIvqvEIql4It9OmwtfQ0JtCNAfQY4N9xINuLRIoekh
	GuTf6EZ9llssJrGS+Q7NaYVgxUbVO+nRhsV/8ZYpVbHCBSXq8kXs9EY3e0+jxcWSQVrm6AWDEkF
	2FbmYGZzX6FVQwvlxLPgrREJrRGdz2KiGBc3WSLuHiCPzsZ57HwB4df8QMQHtb93ztclZT5YliV
	Cpkh0iW2g8crJwV1NUJhz2per2WzUDwQA48gdtVl7QnBQ96d3ktELV/v/+EXIv7XpS1lDJdu8ff
	SjkxN6qMh6LWGi96v5NMosz7QYo8r1cROuliNxeucshMfKC0swGZfsqVA2S+d8ifxxZUO5TOHwt
	JaWE/CbBvILlUAy4Mx2V+0nra3NydFjb5I+V8w2SFgJ1w8RD7+k7C8/6k9yNo=
X-Google-Smtp-Source: AGHT+IFYMpB/hfnnMwqXioIIY9YN2MfPYZ5TpMlDu73cNBgIUPkKRv7kC+0WMvzmPN4O0yWcKdtA3Q==
X-Received: by 2002:a17:907:3f20:b0:b2e:34f1:9dbf with SMTP id a640c23a62f3a-b30261c1e6amr601703866b.1.1758719272475;
        Wed, 24 Sep 2025 06:07:52 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f382b0sm1574379866b.2.2025.09.24.06.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 06:07:51 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Takashi Iwai <tiwai@suse.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sound@vger.kernel.org
Subject: [RESEND PATCH 1/3] ASoC: mxs-saif: support usage with simple-audio-card
Date: Wed, 24 Sep 2025 15:07:44 +0200
Message-ID: <20250924130749.3012071-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for enabling MCLK output when using the simple-audio-card
driver. In the sound/soc/mxs/mxs-sgtl5000.c use case, that driver
handles MCLK enable/disable by calling mxs_saif_get_mclk() and
mxs_saif_put_mclk() at probe/remove. This does not happen when the
simple-audio-card driver is used. Extend the mxs-saif driver to enable
MCLK output in that scenario.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 sound/soc/mxs/mxs-saif.c | 123 ++++++++++++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 33 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 3e3a62df3d7e..a01a680ad4d7 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -24,8 +24,79 @@
 #define MXS_SET_ADDR	0x4
 #define MXS_CLR_ADDR	0x8
 
+#define MXS_SAIF_BUSY_TIMEOUT_US 10000
+
 static struct mxs_saif *mxs_saif[2];
 
+/*
+ * Since SAIF may work on EXTMASTER mode, IOW, it's working BITCLK&LRCLK
+ * is provided by other SAIF, we provide a interface here to get its master
+ * from its master_id.
+ * Note that the master could be itself.
+ */
+static inline struct mxs_saif *mxs_saif_get_master(struct mxs_saif *saif)
+{
+	return mxs_saif[saif->master_id];
+}
+
+static int __mxs_saif_put_mclk(struct mxs_saif *saif)
+{
+	u32 stat;
+	int ret;
+
+	ret = readx_poll_timeout(__raw_readl, saif->base + SAIF_STAT, stat,
+				 (stat & BM_SAIF_STAT_BUSY) == 0,
+				 MXS_SAIF_BUSY_TIMEOUT_US,
+				 USEC_PER_SEC);
+	if (ret) {
+		dev_err(saif->dev, "error: busy\n");
+		return -EBUSY;
+	}
+
+	/* disable MCLK output */
+	__raw_writel(BM_SAIF_CTRL_CLKGATE,
+		saif->base + SAIF_CTRL + MXS_SET_ADDR);
+	__raw_writel(BM_SAIF_CTRL_RUN,
+		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
+
+	saif->mclk_in_use = 0;
+
+	return 0;
+}
+
+static int __mxs_saif_get_mclk(struct mxs_saif *saif)
+{
+	u32 stat;
+	struct mxs_saif *master_saif;
+
+	if (!saif)
+		return -EINVAL;
+
+	/* Clear Reset */
+	__raw_writel(BM_SAIF_CTRL_SFTRST,
+		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
+
+	/* FIXME: need clear clk gate for register r/w */
+	__raw_writel(BM_SAIF_CTRL_CLKGATE,
+		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
+
+	master_saif = mxs_saif_get_master(saif);
+	if (saif != master_saif) {
+		dev_err(saif->dev, "can not get mclk from a non-master saif\n");
+		return -EINVAL;
+	}
+
+	stat = __raw_readl(saif->base + SAIF_STAT);
+	if (stat & BM_SAIF_STAT_BUSY) {
+		dev_err(saif->dev, "error: busy\n");
+		return -EBUSY;
+	}
+
+	saif->mclk_in_use = 1;
+
+	return 0;
+}
+
 /*
  * SAIF is a little different with other normal SOC DAIs on clock using.
  *
@@ -48,6 +119,7 @@ static int mxs_saif_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 			int clk_id, unsigned int freq, int dir)
 {
 	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
+	int ret;
 
 	switch (clk_id) {
 	case MXS_SAIF_MCLK:
@@ -56,18 +128,22 @@ static int mxs_saif_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	default:
 		return -EINVAL;
 	}
-	return 0;
-}
 
-/*
- * Since SAIF may work on EXTMASTER mode, IOW, it's working BITCLK&LRCLK
- * is provided by other SAIF, we provide a interface here to get its master
- * from its master_id.
- * Note that the master could be itself.
- */
-static inline struct mxs_saif *mxs_saif_get_master(struct mxs_saif * saif)
-{
-	return mxs_saif[saif->master_id];
+	if (!saif->mclk_in_use && freq) {
+		ret = __mxs_saif_get_mclk(saif);
+		if (ret)
+			return ret;
+
+		/* enable MCLK output */
+		__raw_writel(BM_SAIF_CTRL_RUN,
+		saif->base + SAIF_CTRL + MXS_SET_ADDR);
+	} else if (saif->mclk_in_use && freq == 0) {
+		ret = __mxs_saif_put_mclk(saif);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 /*
@@ -238,34 +314,15 @@ int mxs_saif_get_mclk(unsigned int saif_id, unsigned int mclk,
 					unsigned int rate)
 {
 	struct mxs_saif *saif = mxs_saif[saif_id];
-	u32 stat;
 	int ret;
-	struct mxs_saif *master_saif;
 
 	if (!saif)
 		return -EINVAL;
 
-	/* Clear Reset */
-	__raw_writel(BM_SAIF_CTRL_SFTRST,
-		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
-
-	/* FIXME: need clear clk gate for register r/w */
-	__raw_writel(BM_SAIF_CTRL_CLKGATE,
-		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
-
-	master_saif = mxs_saif_get_master(saif);
-	if (saif != master_saif) {
-		dev_err(saif->dev, "can not get mclk from a non-master saif\n");
-		return -EINVAL;
-	}
-
-	stat = __raw_readl(saif->base + SAIF_STAT);
-	if (stat & BM_SAIF_STAT_BUSY) {
-		dev_err(saif->dev, "error: busy\n");
-		return -EBUSY;
-	}
+	ret = __mxs_saif_get_mclk(saif);
+	if (ret)
+		return ret;
 
-	saif->mclk_in_use = 1;
 	ret = mxs_saif_set_clk(saif, mclk, rate);
 	if (ret)
 		return ret;
-- 
2.43.0

base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
branch: microgea-rmm-audio

