Return-Path: <linux-kernel+bounces-753136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0B6B17F19
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 859B87A44B9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5375B225417;
	Fri,  1 Aug 2025 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl8Cf3aI"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13A9223DDD;
	Fri,  1 Aug 2025 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039929; cv=none; b=tVxgd2JwyAIySZxDWjXya13vCmpysK7ftT2KfFzxX3HdWzMybVMPsEg3TgfUgalWD4H16geIbXYLsrUyazdfBsrmgOgb+LkJsYBshgDMsAiEk9JjDKX7QRe6bpwMaOGrvHnuv654U3uH5pWdatkFeDnh6bdW8ESy92qBmQv6Jn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039929; c=relaxed/simple;
	bh=EZ9coIo9VdjSkRUbAibPRCDdd0sc/5sH13gzaeUrJX0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+KxJk35P5fuvXSGeS0UZG2xF9y+SgMz5/uWEXgnpHusO6F0AiByGEofrCIHihUI8SE1YXBX0Ol0/J/cWVeZGhj+6WVZVNj3bHGOtav2QTMJ3R19N+QetWELx+Dn8LI0sLhCOVAzCZEUpDwNbNHJJMAPN53kC27+ZuPaizzgU74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gl8Cf3aI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4589968e001so10991295e9.0;
        Fri, 01 Aug 2025 02:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754039925; x=1754644725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROhyw+t7FAuJ/neKZ5R3uau4fvGt/s6iE4pUlePNK0k=;
        b=gl8Cf3aIhvYASp21JvK62UMrCRYk0pM00so9cMAA5DeiFb+d7GNH2bSC81MOZf/d6f
         rMRS2kunV3pJOq96oqrBmNVwUMrbzk/B4Kn4HMpVUPBRFFUWBxKvIX3PhH4xBhgsJGRn
         SOO6OSWp4VcQQdxisfcqcVGKRxMjOVTQXORP1ktpCAGC5FsarUQxfW3zbhPtn+GIuRGc
         XM/0rJaC4Wqwyrwm0Qhbyya4pH6mbpMI3QCc5OMu8Hm94qDvWgyFr2nqeXp0CxKYL6xc
         BxfvwltJ2Ml+6jVqrbZ6a6YFypaBEvFxGC34r26iPdqH8iESABDDoE3gKW7cbnq/ZafL
         o0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754039925; x=1754644725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROhyw+t7FAuJ/neKZ5R3uau4fvGt/s6iE4pUlePNK0k=;
        b=gTssBPBv6+TBPEy5v5jUIDnRrUitXz5nxfxOFbTXk8v5uMnef1oyPMFVtPkaMJ4SuR
         RrQFsDnWx9sHnYYFVwUljMbUAwy1nf/ykOl73/HJLyk8sDOH1eM6kgVzzCcaq0yibGon
         326QtcG2GT5rB9Xr7Nwr9IJmrMMeBz9mrADvVSjpaO+gUVh8Jjt4Fo/W6+8d9zv7pbXX
         jYDifRu/dRbBo+S5iINsMiJxz/eh72Uk0PgjyH7J0VBkOJtNvbz6B18KDERdiocnp4AE
         kHkGn2L9B9CNDN3O21HWZy88++ByNoc7kzdCrts3wOmpw/Kgd+rwz/qYopTUKZx2iiQM
         lSCg==
X-Forwarded-Encrypted: i=1; AJvYcCU1Rm9KfyH3S+Bc6BROZAb3+Le0pWMn0oNTaSbgNg9VjYXsdiJrSh2Bc+GNWIVzhoV7YHBofzNpsdbX2Aw=@vger.kernel.org, AJvYcCVh6iZcehABxkiq57qXvQb23gUMhgkTPQJCA3V6fYnhfQdU/equEelf4R9mXPW6AKVH2IRIKmAc06eZAdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNHLoCPXCpaP3utiuFhrvy0syDcgGfwxpXhNkJt9OooklV0WH7
	caZhLSNQfPsN753czHbkV50dV2LfXOcICf6tGYmJgX3WdTdHxPgwkt0Y
X-Gm-Gg: ASbGncvp0eHPUyhvya6GhR7xcg/6SdPChWbo3VkbSivwQEaev8W6O0Wky9cT5fsrF/E
	+4YsXHx3mIbBZ3bpGZ2j+0v+f2fuPPOAn3qbCAfG16Dhu6r+r2VywcMtoBMfhwbPsFpnarvbrSM
	SJ622WcOTHMcj8GZcIpQ6zyfGwFCPh1ussM/c+i71pJDr2Z4qbuB4uYn/QtpUSVl52icTO0KBr0
	7WmCbxQg5TWrHZrS3DWzeW+5BVi0lFcxX8UUUTvqcPen70RP9vhZIffXrjEShcJwcfqY0/SQZIR
	XO/4D3ezpJCSgJ28nWeCrgv58CzKVrV/SPbS/LXBAerLaVV/ZX66iqpPjnelTpY8AGb5T25XIEe
	5cqSrJ5hfuKwOYSGhX4dHWZ9XnVuJpEbQqU6F6cix8SRGPV0lEQY2eXscpvwanleI3dl0gAXPNu
	VIEefQ7kmJq5/t
X-Google-Smtp-Source: AGHT+IF0EPte8HqaVBIYXtF1RnC8Y0lOpWJbe9LERhVuYpNScsmKQadfRHJvlxBAdqbO8bu+1FMb/A==
X-Received: by 2002:a05:600c:138e:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-45892bdf9admr85140375e9.32.1754039924825;
        Fri, 01 Aug 2025 02:18:44 -0700 (PDT)
Received: from Ansuel-XPS24 (host-80-181-255-224.pool80181.interbusiness.it. [80.181.255.224])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458953787a8sm95789065e9.14.2025.08.01.02.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 02:18:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Tang Bin <tangbin@cmss.chinamobile.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	parkeryang <Parker.Yang@mediatek.com>,
	YR Yang <yr.yang@mediatek.com>,
	Zhang Yi <zhangyi@everest-semi.com>,
	Fei Shao <fshao@chromium.org>,
	Julien Massot <julien.massot@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RFC RESEND PATCH 2/2] ASoC: airoha: Add AFE driver for Airoha AN7581
Date: Fri,  1 Aug 2025 11:18:09 +0200
Message-ID: <20250801091812.4866-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250801091812.4866-1-ansuelsmth@gmail.com>
References: <20250801091812.4866-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Sound system present on Airoha AN7581 SoC. This is
based on the mediatek AFE drivers.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 sound/soc/Makefile                          |   1 +
 sound/soc/airoha/Kconfig                    |  10 +
 sound/soc/airoha/Makefile                   |   2 +
 sound/soc/airoha/an7581/Makefile            |   7 +
 sound/soc/airoha/an7581/an7581-afe-common.h |  35 ++
 sound/soc/airoha/an7581/an7581-afe-pcm.c    | 455 ++++++++++++++++++++
 sound/soc/airoha/an7581/an7581-reg.h        |  29 ++
 7 files changed, 539 insertions(+)
 create mode 100644 sound/soc/airoha/Kconfig
 create mode 100644 sound/soc/airoha/Makefile
 create mode 100644 sound/soc/airoha/an7581/Makefile
 create mode 100644 sound/soc/airoha/an7581/an7581-afe-common.h
 create mode 100644 sound/soc/airoha/an7581/an7581-afe-pcm.c
 create mode 100644 sound/soc/airoha/an7581/an7581-reg.h

diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 462322c38aa4..a6a9f5e84bad 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_SND_SOC)	+= codecs/
 obj-$(CONFIG_SND_SOC)	+= generic/
 obj-$(CONFIG_SND_SOC)	+= apple/
 obj-$(CONFIG_SND_SOC)	+= adi/
+obj-$(CONFIG_SND_SOC)	+= airoha/
 obj-$(CONFIG_SND_SOC)	+= amd/
 obj-$(CONFIG_SND_SOC)	+= atmel/
 obj-$(CONFIG_SND_SOC)	+= au1x/
diff --git a/sound/soc/airoha/Kconfig b/sound/soc/airoha/Kconfig
new file mode 100644
index 000000000000..01e84daba8fa
--- /dev/null
+++ b/sound/soc/airoha/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config SND_SOC_AN7581
+	tristate "ASoC support for Airoha AN7581 chip"
+	depends on ARCH_AIROHA
+	select SND_SOC_MEDIATEK
+	help
+	  This adds ASoC driver for Airoha AN7581 boards
+	  that can be used with other codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
diff --git a/sound/soc/airoha/Makefile b/sound/soc/airoha/Makefile
new file mode 100644
index 000000000000..fef7fed384a9
--- /dev/null
+++ b/sound/soc/airoha/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_SND_SOC_AN7581) += an7581/
diff --git a/sound/soc/airoha/an7581/Makefile b/sound/soc/airoha/an7581/Makefile
new file mode 100644
index 000000000000..bf475e14096a
--- /dev/null
+++ b/sound/soc/airoha/an7581/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# platform driver
+snd-soc-an7581-afe-y := \
+	an7581-afe-pcm.o
+
+obj-$(CONFIG_SND_SOC_AN7581) += snd-soc-an7581-afe.o
diff --git a/sound/soc/airoha/an7581/an7581-afe-common.h b/sound/soc/airoha/an7581/an7581-afe-common.h
new file mode 100644
index 000000000000..d2528735b75f
--- /dev/null
+++ b/sound/soc/airoha/an7581/an7581-afe-common.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * an7581-afe-common.h  --  Airoha AN7581 audio driver definitions
+ */
+
+#ifndef _AN_7581_AFE_COMMON_H_
+#define _AN_7581_AFE_COMMON_H_
+
+#include <sound/soc.h>
+#include <linux/list.h>
+#include <linux/regmap.h>
+#include "../common/mtk-base-afe.h"
+
+enum {
+	AN7581_MEMIF_DL1,
+	AN7581_MEMIF_UL1,
+	AN7581_MEMIF_NUM,
+	AN7581_DAI_NUM = AN7581_MEMIF_NUM,
+};
+
+enum {
+	AN7581_IRQ_0,
+	AN7581_IRQ_1,
+	AN7581_IRQ_NUM,
+};
+
+struct an7581_afe_private {
+	/* dai */
+	void *dai_priv[AN7581_DAI_NUM];
+};
+
+unsigned int an7581_afe_rate_transform(struct device *dev,
+				       unsigned int rate);
+
+#endif
diff --git a/sound/soc/airoha/an7581/an7581-afe-pcm.c b/sound/soc/airoha/an7581/an7581-afe-pcm.c
new file mode 100644
index 000000000000..456d402ba0ed
--- /dev/null
+++ b/sound/soc/airoha/an7581/an7581-afe-pcm.c
@@ -0,0 +1,455 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Airoha ALSA SoC AFE platform driver for AN7581
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/pm_runtime.h>
+
+#include "an7581-afe-common.h"
+#include "an7581-reg.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
+#include <sound/mediatek/mtk-afe-fe-dai.h>
+
+enum {
+	ARH_AFE_RATE_7K = 16,
+	ARH_AFE_RATE_8K = 0,
+	ARH_AFE_RATE_11K = 17,
+	ARH_AFE_RATE_12K = 1,
+	ARH_AFE_RATE_14K = 18,
+	ARH_AFE_RATE_16K = 2,
+	ARH_AFE_RATE_22K = 19,
+	ARH_AFE_RATE_24K = 3,
+	ARH_AFE_RATE_29K = 20,
+	ARH_AFE_RATE_32K = 4,
+	ARH_AFE_RATE_44K = 21,
+	ARH_AFE_RATE_48K = 5,
+	ARH_AFE_RATE_88K = 22,
+	ARH_AFE_RATE_96K = 6,
+	ARH_AFE_RATE_176K = 23,
+	ARH_AFE_RATE_192K = 7,
+	ARH_AFE_RATE_352K = 24,
+	ARH_AFE_RATE_384K = 8,
+};
+
+unsigned int an7581_afe_rate_transform(struct device *dev, unsigned int rate)
+{
+	switch (rate) {
+	case 7350:
+		return ARH_AFE_RATE_7K;
+	case 8000:
+		return ARH_AFE_RATE_8K;
+	case 11025:
+		return ARH_AFE_RATE_11K;
+	case 12000:
+		return ARH_AFE_RATE_12K;
+	case 14700:
+		return ARH_AFE_RATE_14K;
+	case 16000:
+		return ARH_AFE_RATE_16K;
+	case 22050:
+		return ARH_AFE_RATE_22K;
+	case 24000:
+		return ARH_AFE_RATE_24K;
+	case 29400:
+		return ARH_AFE_RATE_29K;
+	case 32000:
+		return ARH_AFE_RATE_32K;
+	case 44100:
+		return ARH_AFE_RATE_44K;
+	case 48000:
+		return ARH_AFE_RATE_48K;
+	case 88200:
+		return ARH_AFE_RATE_88K;
+	case 96000:
+		return ARH_AFE_RATE_96K;
+	case 176400:
+		return ARH_AFE_RATE_176K;
+	case 192000:
+		return ARH_AFE_RATE_192K;
+	case 352800:
+		return ARH_AFE_RATE_352K;
+	case 384000:
+		return ARH_AFE_RATE_384K;
+	default:
+		dev_warn(dev, "%s(), rate %u invalid, using %d!!!\n",
+			 __func__, rate, ARH_AFE_RATE_48K);
+		return ARH_AFE_RATE_48K;
+	}
+}
+
+static const int an7581_memif_specified_irqs[AN7581_MEMIF_NUM] = {
+	[AN7581_MEMIF_DL1] = AN7581_IRQ_0,
+	[AN7581_MEMIF_UL1] = AN7581_IRQ_1,
+};
+
+static const struct snd_pcm_hardware an7581_afe_hardware = {
+	.info = SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_MMAP_VALID,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE |
+		   SNDRV_PCM_FMTBIT_S24_LE |
+		   SNDRV_PCM_FMTBIT_S32_LE,
+	.period_bytes_min = 512,
+	.period_bytes_max = 128 * 1024,
+	.periods_min = 2,
+	.periods_max = 256,
+	.buffer_bytes_max = 256 * 1024,
+	.fifo_size = 0,
+};
+
+static int an7581_memif_fs(struct snd_pcm_substream *substream,
+			   unsigned int rate)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+
+	return an7581_afe_rate_transform(afe->dev, rate);
+}
+
+static int an7581_irq_fs(struct snd_pcm_substream *substream,
+			 unsigned int rate)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+
+	return an7581_afe_rate_transform(afe->dev, rate);
+}
+
+#define ARH_PCM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver an7581_memif_dai_driver[] = {
+	/* FE DAIs: memory intefaces to CPU */
+	{
+		.name = "DL1",
+		.id = AN7581_MEMIF_DL1,
+		.playback = {
+			.stream_name = "DL1",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = SNDRV_PCM_RATE_8000_192000,
+			.formats = ARH_PCM_FORMATS,
+		},
+		.ops = &mtk_afe_fe_ops,
+	},
+	{
+		.name = "UL1",
+		.id = AN7581_MEMIF_UL1,
+		.capture = {
+			.stream_name = "UL1",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_192000,
+			.formats = ARH_PCM_FORMATS,
+		},
+		.ops = &mtk_afe_fe_ops,
+	},
+};
+static const struct snd_soc_component_driver an7581_afe_pcm_dai_component = {
+	.name = "an7581-afe-pcm-dai",
+};
+
+static const struct mtk_base_memif_data memif_data[AN7581_MEMIF_NUM] = {
+	[AN7581_MEMIF_DL1] = {
+		.name = "DL1",
+		.id = AN7581_MEMIF_DL1,
+		.reg_ofs_base = AFE_DL1_BASE,
+		.reg_ofs_cur = AFE_DL1_CUR,
+		.reg_ofs_end = AFE_DL1_END,
+		.fs_reg = -1,
+		.fs_shift = -1,
+		.fs_maskbit = -1,
+		.mono_reg = -1,
+		.mono_shift = -1,
+		.hd_reg = -1,
+		.hd_shift = -1,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = 17,
+		.msb_reg = -1,
+		.msb_shift = -1,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+	},
+	[AN7581_MEMIF_UL1] = {
+		.name = "UL1",
+		.id = AN7581_MEMIF_UL1,
+		.reg_ofs_base = AFE_UL1_BASE,
+		.reg_ofs_cur = AFE_UL1_CUR,
+		.reg_ofs_end = AFE_UL1_END,
+		.fs_reg = -1,
+		.fs_shift = -1,
+		.fs_maskbit = -1,
+		.mono_reg = -1,
+		.mono_shift = -1,
+		.hd_reg = -1,
+		.hd_shift = -1,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = 1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+	},
+};
+
+static const struct mtk_base_irq_data irq_data[AN7581_IRQ_NUM] = {
+	[AN7581_IRQ_0] = {
+		.id = AN7581_IRQ_0,
+		.irq_cnt_reg = -1,
+		.irq_cnt_shift = -1,
+		.irq_cnt_maskbit = -1,
+		.irq_en_reg = AFE_IRQ1_CON0,
+		.irq_en_shift = 4,
+		.irq_fs_reg = -1,
+		.irq_fs_shift = -1,
+		.irq_fs_maskbit = -1,
+		.irq_clr_reg = AFE_IRQ1_CON0,
+		.irq_clr_shift = 0,
+	},
+	[AN7581_IRQ_1] = {
+		.id = AN7581_IRQ_1,
+		.irq_cnt_reg = -1,
+		.irq_cnt_shift = -1,
+		.irq_cnt_maskbit = -1,
+		.irq_en_reg = AFE_IRQ0_CON0,
+		.irq_en_shift = 4,
+		.irq_fs_reg = -1,
+		.irq_fs_shift = -1,
+		.irq_fs_maskbit = -1,
+		.irq_clr_reg = AFE_IRQ0_CON0,
+		.irq_clr_shift = 1,
+	},
+};
+
+static const struct regmap_config an7581_afe_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = AFE_MAX_REGISTER,
+	.num_reg_defaults_raw = ((AFE_MAX_REGISTER / 4) + 1),
+};
+
+static irqreturn_t an7581_afe_irq_handler(int irq_id, void *dev)
+{
+	struct mtk_base_afe *afe = dev;
+	struct mtk_base_afe_irq *irq;
+	u32 status;
+	u32 reg;
+	int i;
+
+	regmap_read(afe->regmap, AFE_IRQ_STS, &status);
+
+	if (status & AFE_IRQ_STS_RECORD)
+		reg = AFE_IRQ0_CON0;
+	else
+		reg = AFE_IRQ1_CON0;
+
+	regmap_set_bits(afe->regmap, reg, BIT(2));
+	regmap_clear_bits(afe->regmap, reg, BIT(2));
+
+	regmap_set_bits(afe->regmap, reg, BIT(3));
+	regmap_clear_bits(afe->regmap, reg, BIT(3));
+
+	for (i = 0; i < AN7581_MEMIF_NUM; i++) {
+		struct mtk_base_afe_memif *memif = &afe->memif[i];
+
+		if (!memif->substream)
+			continue;
+
+		if (memif->irq_usage < 0)
+			continue;
+
+		irq = &afe->irqs[memif->irq_usage];
+
+		if (status & (1 << irq->irq_data->irq_clr_shift))
+			snd_pcm_period_elapsed(memif->substream);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int an7581_afe_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int an7581_afe_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+
+static int an7581_dai_memif_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = an7581_memif_dai_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(an7581_memif_dai_driver);
+
+	return 0;
+}
+
+typedef int (*dai_register_cb)(struct mtk_base_afe *);
+static const dai_register_cb dai_register_cbs[] = {
+	an7581_dai_memif_register,
+};
+
+static int an7581_afe_pcm_dev_probe(struct platform_device *pdev)
+{
+	struct mtk_base_afe *afe;
+	struct an7581_afe_private *afe_priv;
+	struct device *dev;
+	int i, irq_id, ret;
+
+	afe = devm_kzalloc(&pdev->dev, sizeof(*afe), GFP_KERNEL);
+	if (!afe)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, afe);
+
+	afe->platform_priv = devm_kzalloc(&pdev->dev, sizeof(*afe_priv),
+					  GFP_KERNEL);
+	if (!afe->platform_priv)
+		return -ENOMEM;
+
+	afe_priv = afe->platform_priv;
+	afe->dev = &pdev->dev;
+	dev = afe->dev;
+
+	afe->base_addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(afe->base_addr))
+		return PTR_ERR(afe->base_addr);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	pm_runtime_get_sync(&pdev->dev);
+
+	afe->regmap = devm_regmap_init_mmio(&pdev->dev, afe->base_addr,
+					    &an7581_afe_regmap_config);
+
+	pm_runtime_put_sync(&pdev->dev);
+	if (IS_ERR(afe->regmap))
+		return PTR_ERR(afe->regmap);
+
+
+	mutex_init(&afe->irq_alloc_lock);
+
+	/* irq initialize */
+	afe->irqs_size = AN7581_IRQ_NUM;
+	afe->irqs = devm_kcalloc(dev, afe->irqs_size, sizeof(*afe->irqs),
+				 GFP_KERNEL);
+	if (!afe->irqs)
+		return -ENOMEM;
+
+	for (i = 0; i < afe->irqs_size; i++)
+		afe->irqs[i].irq_data = &irq_data[i];
+
+	/* request irq */
+	irq_id = platform_get_irq(pdev, 0);
+	if (irq_id < 0)
+		return irq_id;
+
+	ret = devm_request_irq(dev, irq_id, an7581_afe_irq_handler,
+			       IRQF_TRIGGER_NONE, "asys-isr", (void *)afe);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request irq for asys-isr\n");
+
+	/* init memif */
+	afe->memif_size = AN7581_MEMIF_NUM;
+	afe->memif = devm_kcalloc(dev, afe->memif_size, sizeof(*afe->memif),
+				  GFP_KERNEL);
+	if (!afe->memif)
+		return -ENOMEM;
+
+	for (i = 0; i < afe->memif_size; i++) {
+		int sel_irq = an7581_memif_specified_irqs[i];
+
+		afe->memif[i].data = &memif_data[i];
+		afe->memif[i].irq_usage = sel_irq;
+		afe->memif[i].const_irq = 1;
+		afe->irqs[sel_irq].irq_occupyed = true;
+	}
+
+	/* init sub_dais */
+	INIT_LIST_HEAD(&afe->sub_dais);
+
+	for (i = 0; i < ARRAY_SIZE(dai_register_cbs); i++) {
+		ret = dai_register_cbs[i](afe);
+		if (ret)
+			return dev_err_probe(dev, ret, "DAI register failed, i: %d\n", i);
+	}
+
+	/* init dai_driver and component_driver */
+	ret = mtk_afe_combine_sub_dai(afe);
+	if (ret)
+		return dev_err_probe(dev, ret, "mtk_afe_combine_sub_dai fail\n");
+
+	afe->mtk_afe_hardware = &an7581_afe_hardware;
+	afe->memif_fs = an7581_memif_fs;
+	afe->irq_fs = an7581_irq_fs;
+
+	afe->runtime_resume = an7581_afe_runtime_resume;
+	afe->runtime_suspend = an7581_afe_runtime_suspend;
+
+	/* register component */
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &mtk_afe_pcm_platform,
+					      NULL, 0);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot register AFE component\n");
+
+	ret = devm_snd_soc_register_component(afe->dev,
+					      &an7581_afe_pcm_dai_component,
+					      afe->dai_drivers,
+					      afe->num_dai_drivers);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot register PCM DAI component\n");
+
+	return 0;
+}
+
+static void an7581_afe_pcm_dev_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		an7581_afe_runtime_suspend(&pdev->dev);
+}
+
+static const struct of_device_id an7581_afe_pcm_dt_match[] = {
+	{ .compatible = "airoha,an7581-afe" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, an7581_afe_pcm_dt_match);
+
+static const struct dev_pm_ops an7581_afe_pm_ops = {
+	RUNTIME_PM_OPS(an7581_afe_runtime_suspend,
+		       an7581_afe_runtime_resume, NULL)
+};
+
+static struct platform_driver an7581_afe_pcm_driver = {
+	.driver = {
+		   .name = "an7581-audio",
+		   .of_match_table = an7581_afe_pcm_dt_match,
+		   .pm = pm_ptr(&an7581_afe_pm_ops),
+	},
+	.probe = an7581_afe_pcm_dev_probe,
+	.remove = an7581_afe_pcm_dev_remove,
+};
+module_platform_driver(an7581_afe_pcm_driver);
+
+MODULE_DESCRIPTION("Airoha SoC AFE platform driver for ALSA AN7581");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/airoha/an7581/an7581-reg.h b/sound/soc/airoha/an7581/an7581-reg.h
new file mode 100644
index 000000000000..2b14a66afa68
--- /dev/null
+++ b/sound/soc/airoha/an7581/an7581-reg.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * an7581-reg.h  --  Airoha AN7581 audio driver reg definition
+ */
+
+#ifndef _AN7581_REG_H_
+#define _AN7581_REG_H_
+
+#define AFE_DAC_CON0			0x0
+
+#define AFE_DL1_BASE			0xa8
+#define AFE_DL1_END			0xac
+#define AFE_DL1_CUR			0xb0
+
+#define AFE_UL1_BASE			0xc4
+#define AFE_UL1_END			0xc8
+#define AFE_UL1_CUR			0xcc
+
+#define AFE_IRQ0_CON0			0xe4
+
+#define AFE_IRQ_STS			0xf8
+#define  AFE_IRQ_STS_PLAY		BIT(1)
+#define  AFE_IRQ_STS_RECORD		BIT(0)
+
+#define AFE_IRQ1_CON0			0x100
+
+#define AFE_MAX_REGISTER		AFE_IRQ1_CON0
+
+#endif
-- 
2.50.0


