Return-Path: <linux-kernel+bounces-753135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AF0B17F18
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4320B188CE7D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB28223DFD;
	Fri,  1 Aug 2025 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsKDelXO"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FEB221DB4;
	Fri,  1 Aug 2025 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039926; cv=none; b=BJHzWKthgZWtZ4xtV2StGarv9BIG1UQVHrhWAgq11Mq3YphJVU8NF68PILjPpKrUj+zfTzx+07ybJI9MH2tlZ72MVvWaulHLZPo1N31wwc+X38XaDQw9yGkJyzIkl2OnJr3mETjEPM6uTinjGVUGfngmLvjooDktENpMG9HedC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039926; c=relaxed/simple;
	bh=QcoOAH1s06MPN/im803hG8+hLavbNrR9KDrB42elT/I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFTxUynQOucIVYbQbS2p0fy4UqP24MwqEaOtqV1PU6xxkW9TahFdi0g8dFJEiM44Yth1AeiGnJUi4E8i/FR+Pm2Eu8OXXfuOB5OoDeA3NIxGXuxxM0s0cRKDdU4FlKtmVD8Dg9wQllCRUx+0cdwKtusp05THLfPwQSc6BhlmO+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsKDelXO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45610582d07so12916575e9.0;
        Fri, 01 Aug 2025 02:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754039923; x=1754644723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtLunnP4TedJqPo1vsBP+WsJ5NT7Bmy4r8DnYlq+CEY=;
        b=lsKDelXONGBW+S9SglkMQu6Kv6drcpZyEYiWWawZAgySW+Xcs7uLwiqt7rj8FwAhD9
         QSvQz2kTaL4/azZ2BzNpM7m39QdEOsJlMY1KXjp5+7mmjNmXozmmdRJcIRaTVp5TQ9r9
         CwoGWkK6Yc1TTsfLiHFZ59w+uDgLujQYbRnbbiMf5g4fPCs/ff51UtQzeF4Pw2Jy5Ql7
         PB66LJSgSHy+093aMslKN6F+iQWdfKC/Gqd0mp63oYaG9FJE0tlmU11+S1ju0R137p3C
         uvJdexVErzsuxoMLm9i8uLVbQjgO1w70VmkKX+yfuceNe7u5K+SpLJkLyTvoe1l4RWQE
         KM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754039923; x=1754644723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtLunnP4TedJqPo1vsBP+WsJ5NT7Bmy4r8DnYlq+CEY=;
        b=u6GLo18851jTJEQqYw1ZpouPujx4iuTXdGTbsDeK41D0lcd+XtOz5aGmCynNQ2Yo+e
         +hFH0nOZoU3x9mAyaIZKXqU3W6Rl9CFbKAwxPQ5Hpr9leiJ8Ij5Qt+NRW8wAuuMSvnXr
         GIkgKhJrF+dfaauR3T32e3liJBc2kRLXUDQZWbmJ0QNJ4dI2ieA9wVXEslLVD07ayCis
         IS3vt5HRv3HsiwQOqeJB8OSwX/dNIknj2sQFL0sgRoFR323KL62H6/hNfxGXkKCyRRs4
         wBnqo8FGTl0rWA1rgqYWRoHNhzj8vp/GRY7qnmbh1+3ATOk5whUCni069tUvTTk+X79j
         yq/g==
X-Forwarded-Encrypted: i=1; AJvYcCVHuU7/B0l6FqEMEcUh/IwY3tjql3mMsGwedGI3hlciGzjxFDgXVnZcuuWJLOjWF9iR08q/lM47c4IR6Ac=@vger.kernel.org, AJvYcCVRuAZgh5MRMTgWKFpXbpZy1RjWzoFZKVAEuD75IyHMUiyj1fyps8qcFHhKD7uGZ5xgAHJKZjMEErFefI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzutTRWxHKSHYUs/q51p5rAe7aXVFfMgOFwsqF0KwF5Moj+cVY/
	UvaibwiJaolSVSYO6C7CzPV3jVTePIcZDG9eZFlm6XXsWYJVF1RiSWfn
X-Gm-Gg: ASbGncsHorKwBshlj6LxV9ry+e4vtve3Dfk6zioYVubpKJoYwycHmnmaVDc0sbYER6U
	eNkqvk8J3pqgZ62uK2T4sxxY9dPxMhiEaaYVBBH3ov7AS6CexJXoFXykS6++r59hkNaG/Zqnvxy
	CNQcJUIspC/v1JUz6SejRF7RhgoKLcek/rjGH3BO5s1AQ3YsIwqCCm5dgBAA1O0vpW/IBwkOYCs
	oQNQemSBZQJYnPV+zX7XG4APOZvyYlSR1JcVLhAFQkC1q87cLwJLkJtXmLMdzvux1RT/uNyNrSU
	0YF595J4GjytdvbqaTq3T/51d9OIYMZSOjaMcu/MdpBiArkDJifLVeMr5Fvv6uq73jQg5xBdtQ3
	1RqxMfALLl6LqAhQcOy89/v6xy1VLI2/tnztZeV9Q4KuehzOpdeLHWEd69vbSsY9RnoabrTJpFM
	Ssdl7WEdHGjo5s
X-Google-Smtp-Source: AGHT+IFi/skLLCRiAqQgbi5epGmUch5tPREIEOTjh2ICmnSbjfdG3rTwP7VXpgf+GU2FtdKGaxac6w==
X-Received: by 2002:a05:600c:3e1b:b0:455:e858:cd04 with SMTP id 5b1f17b1804b1-45892bd217bmr88566565e9.25.1754039922271;
        Fri, 01 Aug 2025 02:18:42 -0700 (PDT)
Received: from Ansuel-XPS24 (host-80-181-255-224.pool80181.interbusiness.it. [80.181.255.224])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458953787a8sm95789065e9.14.2025.08.01.02.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 02:18:41 -0700 (PDT)
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
Subject: [RFC RESEND PATCH 1/2] ASoC: mediatek: move some header to global include
Date: Fri,  1 Aug 2025 11:18:08 +0200
Message-ID: <20250801091812.4866-2-ansuelsmth@gmail.com>
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

In preparation for support of Airoha SoC sound system based on Mediatek
AFE, move some header to global include to prevent having to use complex
redirection for inclusion.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../common => include/sound/mediatek}/mtk-afe-fe-dai.h        | 0
 .../sound/mediatek}/mtk-afe-platform-driver.h                 | 0
 sound/soc/mediatek/common/mtk-afe-fe-dai.c                    | 4 ++--
 sound/soc/mediatek/common/mtk-afe-platform-driver.c           | 2 +-
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c                    | 4 ++--
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c                    | 4 ++--
 sound/soc/mediatek/mt7986/mt7986-afe-pcm.c                    | 4 ++--
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c                    | 4 ++--
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c                    | 4 ++--
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c            | 2 +-
 sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c    | 2 +-
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c                    | 4 ++--
 sound/soc/mediatek/mt8186/mt8186-misc-control.c               | 4 ++--
 sound/soc/mediatek/mt8186/mt8186-mt6366-common.c              | 2 +-
 sound/soc/mediatek/mt8186/mt8186-mt6366.c                     | 2 +-
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c                    | 4 ++--
 sound/soc/mediatek/mt8188/mt8188-mt6359.c                     | 2 +-
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c                    | 4 ++--
 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c       | 2 +-
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c                    | 4 ++--
 sound/soc/mediatek/mt8195/mt8195-mt6359.c                     | 2 +-
 sound/soc/mediatek/mt8365/mt8365-afe-pcm.c                    | 4 ++--
 22 files changed, 32 insertions(+), 32 deletions(-)
 rename {sound/soc/mediatek/common => include/sound/mediatek}/mtk-afe-fe-dai.h (100%)
 rename {sound/soc/mediatek/common => include/sound/mediatek}/mtk-afe-platform-driver.h (100%)

diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.h b/include/sound/mediatek/mtk-afe-fe-dai.h
similarity index 100%
rename from sound/soc/mediatek/common/mtk-afe-fe-dai.h
rename to include/sound/mediatek/mtk-afe-fe-dai.h
diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.h b/include/sound/mediatek/mtk-afe-platform-driver.h
similarity index 100%
rename from sound/soc/mediatek/common/mtk-afe-platform-driver.h
rename to include/sound/mediatek/mtk-afe-platform-driver.h
diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.c b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
index 3809068f5620..de58ee0afe27 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.c
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
@@ -11,9 +11,9 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <sound/soc.h>
-#include "mtk-afe-platform-driver.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
 #include <sound/pcm_params.h>
-#include "mtk-afe-fe-dai.h"
+#include <sound/mediatek/mtk-afe-fe-dai.h>
 #include "mtk-base-afe.h"
 
 #define AFE_BASE_END_OFFSET 8
diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index 6b6330583941..fc1681281ad5 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -10,7 +10,7 @@
 #include <linux/dma-mapping.h>
 #include <sound/soc.h>
 
-#include "mtk-afe-platform-driver.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
 #include "mtk-base-afe.h"
 
 int mtk_afe_combine_sub_dai(struct mtk_base_afe *afe)
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index fcae38135d93..ce50eda77bd9 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -16,8 +16,8 @@
 
 #include "mt2701-afe-common.h"
 #include "mt2701-afe-clock-ctrl.h"
-#include "../common/mtk-afe-platform-driver.h"
-#include "../common/mtk-afe-fe-dai.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
+#include <sound/mediatek/mtk-afe-fe-dai.h>
 
 static const struct snd_pcm_hardware mt2701_afe_hardware = {
 	.info = SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED
diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
index f62a32f2f2b6..dd8583df7d0a 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
@@ -16,8 +16,8 @@
 #include "mt6797-afe-clk.h"
 #include "mt6797-interconnection.h"
 #include "mt6797-reg.h"
-#include "../common/mtk-afe-platform-driver.h"
-#include "../common/mtk-afe-fe-dai.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
+#include <sound/mediatek/mtk-afe-fe-dai.h>
 
 enum {
 	MTK_AFE_RATE_8K = 0,
diff --git a/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c b/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c
index 7a6ad9116e55..640c3a7bff2d 100644
--- a/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c
+++ b/sound/soc/mediatek/mt7986/mt7986-afe-pcm.c
@@ -16,8 +16,8 @@
 
 #include "mt7986-afe-common.h"
 #include "mt7986-reg.h"
-#include "../common/mtk-afe-platform-driver.h"
-#include "../common/mtk-afe-fe-dai.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
+#include <sound/mediatek/mtk-afe-fe-dai.h>
 
 enum {
 	MTK_AFE_RATE_8K = 0,
diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 04ed0cfec174..6c58daa0a963 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -18,8 +18,8 @@
 #include <sound/soc.h>
 #include "mt8173-afe-common.h"
 #include "../common/mtk-base-afe.h"
-#include "../common/mtk-afe-platform-driver.h"
-#include "../common/mtk-afe-fe-dai.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
+#include <sound/mediatek/mtk-afe-fe-dai.h>
 
 /*****************************************************************************
  *                  R E G I S T E R       D E F I N I T I O N
diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index e8884354995c..9e1fa40bcb56 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -17,8 +17,8 @@
 #include "mt8183-afe-clk.h"
 #include "mt8183-interconnection.h"
 #include "mt8183-reg.h"
-#include "../common/mtk-afe-platform-driver.h"
-#include "../common/mtk-afe-fe-dai.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
+#include <sound/mediatek/mtk-afe-fe-dai.h>
 
 enum {
 	MTK_AFE_RATE_8K = 0,
diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index 3388e076ccc9..faba30a58e9e 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -16,7 +16,7 @@
 
 #include "../../codecs/da7219.h"
 #include "../../codecs/rt1015.h"
-#include "../common/mtk-afe-platform-driver.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
 #include "mt8183-afe-common.h"
 
 #define DA7219_CODEC_DAI "da7219-hifi"
diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 497a9043be7b..5d6bcaaebd8f 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -15,7 +15,7 @@
 
 #include "../../codecs/rt1015.h"
 #include "../../codecs/ts3a227e.h"
-#include "../common/mtk-afe-platform-driver.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
 #include "mt8183-afe-common.h"
 
 #define RT1015_CODEC_DAI "rt1015-aif"
diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
index db7c93401bee..2ffb64d88c56 100644
--- a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
@@ -14,8 +14,8 @@
 #include <linux/reset.h>
 #include <sound/soc.h>
 
-#include "../common/mtk-afe-platform-driver.h"
-#include "../common/mtk-afe-fe-dai.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
+#include <sound/mediatek/mtk-afe-fe-dai.h>
 
 #include "mt8186-afe-common.h"
 #include "mt8186-afe-clk.h"
diff --git a/sound/soc/mediatek/mt8186/mt8186-misc-control.c b/sound/soc/mediatek/mt8186/mt8186-misc-control.c
index 2317de8c44c0..96ee69fdc8a6 100644
--- a/sound/soc/mediatek/mt8186/mt8186-misc-control.c
+++ b/sound/soc/mediatek/mt8186/mt8186-misc-control.c
@@ -11,8 +11,8 @@
 #include <linux/regmap.h>
 #include <sound/soc.h>
 
-#include "../common/mtk-afe-fe-dai.h"
-#include "../common/mtk-afe-platform-driver.h"
+#include <sound/mediatek/mtk-afe-fe-dai.h>
+#include <sound/mediatek/mtk-afe-platform-driver.h>
 #include "mt8186-afe-common.h"
 
 static const char * const mt8186_sgen_mode_str[] = {
diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-common.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-common.c
index fa08eb0654d8..4155db56c59a 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366-common.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-common.c
@@ -9,7 +9,7 @@
 #include <sound/soc.h>
 
 #include "../../codecs/mt6358.h"
-#include "../common/mtk-afe-platform-driver.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
 #include "mt8186-afe-common.h"
 #include "mt8186-mt6366-common.h"
 
diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366.c b/sound/soc/mediatek/mt8186/mt8186-mt6366.c
index 43546012cf61..9c47949864fc 100644
--- a/sound/soc/mediatek/mt8186/mt8186-mt6366.c
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366.c
@@ -22,7 +22,7 @@
 #include "../../codecs/da7219.h"
 #include "../../codecs/mt6358.h"
 #include "../../codecs/rt5682.h"
-#include "../common/mtk-afe-platform-driver.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
 #include "../common/mtk-dsp-sof-common.h"
 #include "../common/mtk-soc-card.h"
 #include "../common/mtk-soundcard-driver.h"
diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
index ac4fdf8ba78f..30bb0cd34953 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
@@ -24,8 +24,8 @@
 #include "mt8188-afe-common.h"
 #include "mt8188-afe-clk.h"
 #include "mt8188-reg.h"
-#include "../common/mtk-afe-platform-driver.h"
-#include "../common/mtk-afe-fe-dai.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
+#include <sound/mediatek/mtk-afe-fe-dai.h>
 
 #define MT8188_MEMIF_BUFFER_BYTES_ALIGN  (0x40)
 #define MT8188_MEMIF_DL7_MAX_PERIOD_SIZE (0x3fff)
diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index a2a76b6df631..0801c26ef36d 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -19,7 +19,7 @@
 #include "../../codecs/mt6359.h"
 #include "../../codecs/mt6359-accdet.h"
 #include "../../codecs/rt5682.h"
-#include "../common/mtk-afe-platform-driver.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
 #include "../common/mtk-soundcard-driver.h"
 #include "../common/mtk-dsp-sof-common.h"
 #include "../common/mtk-soc-card.h"
diff --git a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
index fd6af74d7995..1498714ff6c0 100644
--- a/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
@@ -16,8 +16,8 @@
 #include <linux/reset.h>
 #include <sound/soc.h>
 
-#include "../common/mtk-afe-fe-dai.h"
-#include "../common/mtk-afe-platform-driver.h"
+#include <sound/mediatek/mtk-afe-fe-dai.h>
+#include <sound/mediatek/mtk-afe-platform-driver.h>
 
 #include "mt8192-afe-common.h"
 #include "mt8192-afe-clk.h"
diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
index bf483a8fb34a..910ff56cc607 100644
--- a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
+++ b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
@@ -19,7 +19,7 @@
 #include "../../codecs/mt6359.h"
 #include "../../codecs/rt1015.h"
 #include "../../codecs/rt5682.h"
-#include "../common/mtk-afe-platform-driver.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
 #include "../common/mtk-soc-card.h"
 #include "../common/mtk-soundcard-driver.h"
 #include "mt8192-afe-common.h"
diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index 5d025ad72263..a18fdfd9049c 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -20,8 +20,8 @@
 #include "mt8195-afe-common.h"
 #include "mt8195-afe-clk.h"
 #include "mt8195-reg.h"
-#include "../common/mtk-afe-platform-driver.h"
-#include "../common/mtk-afe-fe-dai.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
+#include <sound/mediatek/mtk-afe-fe-dai.h>
 
 #define MT8195_MEMIF_BUFFER_BYTES_ALIGN  (0x40)
 #define MT8195_MEMIF_DL7_MAX_PERIOD_SIZE (0x3fff)
diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
index e57391c213e7..9594689d935a 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -19,7 +19,7 @@
 #include "../../codecs/mt6359.h"
 #include "../../codecs/rt1011.h"
 #include "../../codecs/rt5682.h"
-#include "../common/mtk-afe-platform-driver.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
 #include "../common/mtk-dsp-sof-common.h"
 #include "../common/mtk-soc-card.h"
 #include "../common/mtk-soundcard-driver.h"
diff --git a/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c b/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
index 10793bbe9275..ddedf55e0d8c 100644
--- a/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
+++ b/sound/soc/mediatek/mt8365/mt8365-afe-pcm.c
@@ -19,8 +19,8 @@
 #include "mt8365-afe-clk.h"
 #include "mt8365-reg.h"
 #include "../common/mtk-base-afe.h"
-#include "../common/mtk-afe-platform-driver.h"
-#include "../common/mtk-afe-fe-dai.h"
+#include <sound/mediatek/mtk-afe-platform-driver.h>
+#include <sound/mediatek/mtk-afe-fe-dai.h>
 
 #define AFE_BASE_END_OFFSET 8
 
-- 
2.50.0


