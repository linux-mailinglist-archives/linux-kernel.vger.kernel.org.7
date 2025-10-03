Return-Path: <linux-kernel+bounces-840937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93195BB5C58
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 03:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D2334E53CA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 01:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF0028A1ED;
	Fri,  3 Oct 2025 01:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkzbNi+C"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4428228EA56
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 01:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759456548; cv=none; b=iB7dJV/TuJNq2KelMUppezYrgkO0hMoq6fvNErrqIZkFiz/m/5C34M1s/dvY8+8aRY/S2ihpGpkXWHoCm1VgOwGBv2jEFwajR2MbuxQ2m6exsAkOQ/tMiYn6zUEzn/pzVH9dXJ0c15c9Md/s+2Iw5ja38g5XWKsVQ9ar4isAKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759456548; c=relaxed/simple;
	bh=DdeTXVGp7oP7duDuRGBegQV5/pMBDOatuo/gmvEaDco=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QPpiEzppqRYS+PclJIZUYPpBGDFFS1FCw7pV9+0z/GEezWcplLVFb6Hv0cs4lhht5Or4SLhJipRX0/3NBe0CiQRfrtfkkcYavMAmthtKe3wlCKKK+Naek7pxMTvOhP0izvjUeq5YDhZaLKQN63j7F1mb3iHIst8xJaeIgzXDoK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkzbNi+C; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso13960275e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 18:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759456544; x=1760061344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qmyUzZrpmTJlmcakNjcT/508MsJBSIIpSMThJvllt+M=;
        b=YkzbNi+CIxYbgrmyoWl0VckPKLblnzXkU6udGag+i5HHo2H2LCssisJL8agwxlZnbB
         N0NQJAXEwpgmaIzDWtGv3g2V+wyfx/teOuv0mAbWNM2BrYchtdwCahVX9gXyojgBOyJs
         s+0v8T+LlMKVX4dby3vExlO4DZuI9pPTbK3/QqR0p9G36OIfV+8gqJBpv8TEUECIljf4
         5bkfAG8LsL8UOZXsD6gg2LTAN/o0aZWZMEXBkeMVjJfrblUW/g/JBHxFt6bIdfueB2lx
         ookObIagXXI4M1sRodhlIo/hgLIp9yxbb4j+pBqKXimpdTiRT+v1jxrkWf1+R0GHIXHG
         r6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759456544; x=1760061344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmyUzZrpmTJlmcakNjcT/508MsJBSIIpSMThJvllt+M=;
        b=gizsYneE/hN7AqIIyruW8NPD0RZ+FY3nb5y/WM+//XJR5myfUcee1GhlulRft4KvHM
         JqwVW9asdkCFp6Rr6o8gSge0tPVdr2yxzOJ40SRi8AXYUqnHwUvEgUMiHRkFDsFA4cpn
         +b9cYNUm7ATwqo6D0oSlcE6rr84FnrGEBgS6TmFqimhImcVUEIAq4l2P2FC75c5nCcU5
         1RRrbDZ4hrxpX7eoBO1UH/dCJPx0XeIe+z3LuMhaHaei2fY72jyiAIUrsFxt+YU4UMZm
         RX1mpLeI5N4aAIvpCpFB2MA5J1yN1HwP1pOsBQpMOjf0B+7icDkMbVJgTuC/osmtToRS
         FfnA==
X-Forwarded-Encrypted: i=1; AJvYcCVjxJrB0XtblEYmOcUHFwmQUS6NDMOv6M3xGlL/B01KfdRXkp7Fe6AS1fcmv8/C5JeQKvB5Z18MrTrbFv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB+GELpAYX0NveZ0bJcxlFY3nER/g6y/gn5sbxMIsw+n/Jetsz
	selpw0F8oxLnNNwHGODCy13VQcrjVe3vRjLaZJ5lzSeC8uSK/QzdHmP/
X-Gm-Gg: ASbGncvklmTWpClySSJHgyfrrwcmtC+QtNb99V1WKzpHPuaPFNJfgNDrvIveHTady9E
	IMVZrrFmfqOgYZ4vWGt+rBCKAjyGdAjOvKzjfy4IZwlWGWZjVbtCC5ZZTeX1B+LAzbQ3HHVIE0O
	g5aPW/XFnIpM92/v1ph/3jUS5fw6fAIpIh2ZVTnfE8l7ZW0tADk0TUyJXvMaVSy+TILi+FQakQZ
	SHYneIMbbaEQ3uU1cu++p5OJY5B6qyP1y3TI9OcTAr1dQDVKUMoCFUNJQkBP62Y2HyGkcPbSf8J
	NJ46e3fHuC26Y1N8LklyF8QVQncwr5GbA1eSGrQLburTu/yZlE8PFA5902Nn8uHC2eXpRNP9box
	5h7hLj4s8zj06LF6GuCVlWcUrHii5OjvVUfgV6FWQN/+BObvICa9ng4OzT6VL0RjgdfXehCeY25
	S76GjVzEmU7vuWwGAH5AFthZvpQgRqPg==
X-Google-Smtp-Source: AGHT+IGwHMj+AdZKUcT08AoJ217jlk5n+LRt8DFWkOl7rdGTsZPjpumrzgk0tjlixJT6zGqAvYPPrw==
X-Received: by 2002:a05:600c:354d:b0:46e:6a6a:5cf7 with SMTP id 5b1f17b1804b1-46e711026c4mr8513605e9.12.1759456544323;
        Thu, 02 Oct 2025 18:55:44 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e723431d0sm8000105e9.5.2025.10.02.18.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 18:55:43 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	upstream@airoha.com
Subject: [RFC PATCH] sound: airoha: add support for AN7581 PCM driver
Date: Fri,  3 Oct 2025 03:54:42 +0200
Message-ID: <20251003015521.2244-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Airoha AN7581 SoC have alternative Sound Card that expose PCM OPs
dedicated for VoIP application.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 sound/Kconfig             |   2 +
 sound/Makefile            |   2 +-
 sound/airoha/Kconfig      |   9 +
 sound/airoha/Makefile     |   3 +
 sound/airoha/an7581-pcm.c | 637 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 652 insertions(+), 1 deletion(-)
 create mode 100644 sound/airoha/Kconfig
 create mode 100644 sound/airoha/Makefile
 create mode 100644 sound/airoha/an7581-pcm.c

diff --git a/sound/Kconfig b/sound/Kconfig
index 8b40205394fe..7886c2460e86 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -63,6 +63,8 @@ source "sound/ppc/Kconfig"
 
 source "sound/ac97/Kconfig"
 
+source "sound/airoha/Kconfig"
+
 source "sound/aoa/Kconfig"
 
 source "sound/arm/Kconfig"
diff --git a/sound/Makefile b/sound/Makefile
index 5942311a4232..85008bb22b7e 100644
--- a/sound/Makefile
+++ b/sound/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_SOUND) += soundcore.o
 obj-$(CONFIG_DMASOUND) += oss/dmasound/
 obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ sh/ synth/ usb/ \
 	firewire/ sparc/ spi/ parisc/ pcmcia/ mips/ soc/ atmel/ hda/ x86/ xen/ \
-	virtio/
+	virtio/ airoha/
 obj-$(CONFIG_SND_AOA) += aoa/
 
 # This one must be compilable even if sound is configured out
diff --git a/sound/airoha/Kconfig b/sound/airoha/Kconfig
new file mode 100644
index 000000000000..fe226fedd1a4
--- /dev/null
+++ b/sound/airoha/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config SND_AN7581_PCM
+	tristate "PCM support for Airoha AN7581 chip"
+	help
+	  This adds PCM driver for Airoha AN7581 boards
+	  that can be used with other codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
diff --git a/sound/airoha/Makefile b/sound/airoha/Makefile
new file mode 100644
index 000000000000..039b8853d5a2
--- /dev/null
+++ b/sound/airoha/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SND_AN7581_PCM) += an7581-pcm.o
diff --git a/sound/airoha/an7581-pcm.c b/sound/airoha/an7581-pcm.c
new file mode 100644
index 000000000000..bf1fc447aed4
--- /dev/null
+++ b/sound/airoha/an7581-pcm.c
@@ -0,0 +1,637 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Airoha ALSA SoC PCM platform driver for AN7581
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/dma-mapping.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#define AN7581_PCM_PICR				0x0
+#define   AN7581_PCM_CFG_VALID			BIT(26)
+#define   AN7581_PCM_SAMPLE_CLK			BIT(4)
+#define     AN7581_PCM_SAMPLE_CLK_8KHZ		FIELD_PREP_CONST(AN7581_PCM_SAMPLE_CLK, 0x0)
+#define     AN7581_PCM_SAMPLE_CLK_16KHZ		FIELD_PREP_CONST(AN7581_PCM_SAMPLE_CLK, 0x1)
+#define   AN7581_PCM_BIT_CLK			GENMASK(3, 1)
+#define     AN7581_PCM_BIT_CLK_256KHZ		FIELD_PREP_CONST(AN7581_PCM_BIT_CLK, 0x0)
+#define     AN7581_PCM_BIT_CLK_512KHZ		FIELD_PREP_CONST(AN7581_PCM_BIT_CLK, 0x1)
+#define     AN7581_PCM_BIT_CLK_1024KHZ		FIELD_PREP_CONST(AN7581_PCM_BIT_CLK, 0x2)
+#define     AN7581_PCM_BIT_CLK_2048HZ		FIELD_PREP_CONST(AN7581_PCM_BIT_CLK, 0x3)
+#define     AN7581_PCM_BIT_CLK_4096KHZ		FIELD_PREP_CONST(AN7581_PCM_BIT_CLK, 0x4)
+#define     AN7581_PCM_BIT_CLK_8192KHZ		FIELD_PREP_CONST(AN7581_PCM_BIT_CLK, 0x5)
+#define   AN7581_PCM_BIT_MSTSLV_MODE		BIT(0)
+#define     AN7581_PCM_BIT_MSTSLV_MODE_MASTER	FIELD_PREP_CONST(AN7581_PCM_BIT_MSTSLV_MODE, 0x0)
+#define     AN7581_PCM_BIT_MSTSLV_MODE_SLAVE	FIELD_PREP_CONST(AN7581_PCM_BIT_MSTSLV_MODE, 0x1)
+/* Same bitmap for all TX timeslot reg */
+#define AN7581_PCM_PTTSCR0			0x4
+#define   AN7581_PCM_TXTS1_BW			BIT(28)
+#define     AN7581_PCM_TXTS1_BW_8BIT		FIELD_PREP_CONST(AN7581_PCM_TXTS1_BW, 0x0)
+#define     AN7581_PCM_TXTS1_BW_16BIT		FIELD_PREP_CONST(AN7581_PCM_TXTS1_BW, 0x1)
+#define   AN7581_PCM_TXTS1_START		GENMASK(25, 16)
+#define   AN7581_PCM_TXTS0_BW			BIT(12)
+#define     AN7581_PCM_TXTS0_BW_8BIT		FIELD_PREP_CONST(AN7581_PCM_TXTS0_BW, 0x0)
+#define     AN7581_PCM_TXTS0_BW_16BIT		FIELD_PREP_CONST(AN7581_PCM_TXTS0_BW, 0x1)
+#define   AN7581_PCM_TXTS0_START		GENMASK(9, 0)
+#define AN7581_PCM_PTTSCR1			0x8
+#define AN7581_PCM_PTTSCR2			0xc
+#define AN7581_PCM_PTTSCR3			0x10
+/* Same bitmap for all RX timeslot reg */
+#define AN7581_PCM_PRTSCR0			0x14
+#define   AN7581_PCM_RXTS1_BW			BIT(28)
+#define     AN7581_PCM_RXTS1_BW_8BIT		FIELD_PREP_CONST(AN7581_PCM_RXTS1_BW, 0x0)
+#define     AN7581_PCM_RXTS1_BW_16BIT		FIELD_PREP_CONST(AN7581_PCM_RXTS1_BW, 0x1)
+#define   AN7581_PCM_RXTS1_START		GENMASK(25, 16)
+#define   AN7581_PCM_RXTS0_BW			BIT(12)
+#define     AN7581_PCM_RXTS0_BW_8BIT		FIELD_PREP_CONST(AN7581_PCM_RXTS0_BW, 0x0)
+#define     AN7581_PCM_RXTS0_BW_16BIT		FIELD_PREP_CONST(AN7581_PCM_RXTS0_BW, 0x1)
+#define   AN7581_PCM_RXTS0_START		GENMASK(9, 0)
+#define AN7581_PCM_PRTSCR1			0x18
+#define AN7581_PCM_PRTSCR2			0x1c
+#define AN7581_PCM_PRTSCR3			0x20
+#define AN7581_PCM_ISR				0x24
+#define AN7581_PCM_IMR				0x28
+#define   AN7581_PCM_IMR_ISI2_INT		BIT(16)
+#define   AN7581_PCM_IMR_ZSI2_INT		BIT(15)
+#define   AN7581_PCM_IMR_SLIC_INT		BIT(14)
+#define   AN7581_PCM_IMR_SFC_INT		BIT(13)
+#define   AN7581_PCM_IMR_ISI1_INT		BIT(12)
+#define   AN7581_PCM_IMR_ZSI1_INT		BIT(11)
+#define   AN7581_PCM_IMR_HUNT_OVERTIME_INT	BIT(10)
+#define   AN7581_PCM_IMR_HUNT_ERR_INT		BIT(9)
+#define   AN7581_PCM_IMR_AHB_BUS_ERR_INT	BIT(8)
+#define   AN7581_PCM_IMR_RBUF_OVERRUN_INT	BIT(7)
+#define   AN7581_PCM_IMR_TBUF_UNDERRUN_INT	BIT(6)
+#define   AN7581_PCM_IMR_RDESC_END_INT		BIT(5)
+#define   AN7581_PCM_IMR_TDESC_END_INT		BIT(4)
+#define   AN7581_PCM_IMR_RDESC_UPDATE_INT	BIT(3)
+#define   AN7581_PCM_IMR_TDESC_UPDATE_INT	BIT(2)
+#define   AN7581_PCM_IMR_TXRX_FB_INT		BIT(0)
+#define AN7581_PCM_TPDR				0x2c
+#define   AN7581_PCM_TX_POLLING			BIT(0)
+#define AN7581_PCM_RPDR				0x30
+#define   AN7581_PCM_RX_POLLING			BIT(0)
+#define AN7581_PCM_TDRBAR			0x34
+#define   AN7581_TDESC_BASE			GENMASK(31, 0)
+#define AN7581_PCM_RDRBAR			0x38
+#define   AN7581_RDESC_BASE			GENMASK(31, 0)
+#define AN7581_PCM_TRDRSR			0x3c
+#define   AN7581_DESC_OFFSET			GENMASK(7, 4)
+#define   AN7581_DESC_SIZE			GENMASK(3, 0)
+#define AN7581_PCM_TRDCR			0x40
+#define   AN7581_PCM_DMA_POLICY			GENMASK(3, 2)
+#define   AN7581_PCM_DMA_POLICY_RR		FIELD_PREP_CONST(AN7581_PCM_DMA_POLICY, 0x0)
+#define   AN7581_PCM_DMA_POLICY_RSVD		FIELD_PREP_CONST(AN7581_PCM_DMA_POLICY, 0x1)
+#define   AN7581_PCM_DMA_POLICY_TX_PRIORITY	FIELD_PREP_CONST(AN7581_PCM_DMA_POLICY, 0x2)
+#define   AN7581_PCM_DMA_POLICY_RX_PRIORITY	FIELD_PREP_CONST(AN7581_PCM_DMA_POLICY, 0x3)
+#define   AN7581_PCM_RXDMA_ENABLE		BIT(0)
+#define   AN7581_PCM_TXDMA_ENABLE		BIT(0)
+#define AN7581_PCM_PTTSCR4			0x48
+#define AN7581_PCM_PTTSCR5			0x4c
+#define AN7581_PCM_PTTSCR6			0x50
+#define AN7581_PCM_PTTSCR7			0x54
+#define AN7581_PCM_PTTSCR8			0x58
+#define AN7581_PCM_PTTSCR9			0x5c
+#define AN7581_PCM_PTTSCR10			0x60
+#define AN7581_PCM_PTTSCR11			0x64
+#define AN7581_PCM_PTTSCR12			0x68
+#define AN7581_PCM_PTTSCR13			0x6c
+#define AN7581_PCM_PTTSCR14			0x70
+#define AN7581_PCM_PTTSCR15			0x74
+#define AN7581_PCM_PTTSCR(chan)			((chan) / 2 < 8 ? AN7581_PCM_PTTSCR0 : AN7581_PCM_PTTSCR4)
+#define   AN7581_PCM_TXTS_BW(chan)		((chan) % 2 ? AN7581_PCM_TXTS0_BW : AN7581_PCM_TXTS1_BW)
+#define     AN7581_PCM_TXTS_BW_8BIT(chan)	0x0
+#define     AN7581_PCM_TXTS_BW_16BIT(chan)	AN7581_PCM_TXTS_BW(chan)
+#define   AN7581_PCM_TXTS_START(chan)		((chan) % 2 ? AN7581_PCM_TXTS0_START : AN7581_PCM_TXTS1_START)
+#define AN7581_PCM_PRTSCR4			0x78
+#define AN7581_PCM_PRTSCR5			0x7c
+#define AN7581_PCM_PRTSCR6			0x80
+#define AN7581_PCM_PRTSCR7			0x84
+#define AN7581_PCM_PRTSCR8			0x88
+#define AN7581_PCM_PRTSCR9			0x8c
+#define AN7581_PCM_PRTSCR10			0x90
+#define AN7581_PCM_PRTSCR11			0x94
+#define AN7581_PCM_PRTSCR12			0x98
+#define AN7581_PCM_PRTSCR13			0x9c
+#define AN7581_PCM_PRTSCR14			0xa0
+#define AN7581_PCM_PRTSCR15			0xa4
+#define AN7581_PCM_PRTSCR(chan)			((chan) / 2 < 8 ? AN7581_PCM_PRTSCR0 : AN7581_PCM_PRTSCR4)
+#define   AN7581_PCM_RXTS_BW(chan)		((chan) % 2 ? AN7581_PCM_RXTS0_BW : AN7581_PCM_RXTS1_BW)
+#define     AN7581_PCM_RXTS_BW_8BIT(chan)	0x0
+#define     AN7581_PCM_RXTS_BW_16BIT(chan)	AN7581_PCM_RXTS_BW(chan)
+#define   AN7581_PCM_RXTS_START(chan)		((chan) % 2 ? AN7581_PCM_RXTS0_START : AN7581_PCM_RXTS1_START)
+#define AN7581_PCM_CHBFOSR			0xa8
+#define   AN7581_PCM_DESC_CHBF_OFFSET		GENMASK(15, 0)
+#define AN7581_PCM_DCHENR			0xac
+/* Each channel correspond to a bit.
+ * Example:
+ * BIT(0) -> chan 0
+ * BIT(1) -> chan 1
+ * ...
+ *
+ * Notice that it's expected the channel are sequential
+ * aka it's not possible to have empty channel in between.
+ * (example BIT(0) | BIT(2))
+ */
+#define   AN7581_PCM_CHAN_EN			GENMASK(31, 0)
+
+#define AN7581_PCM_MAX_CHANNELS			32
+#define AN7581_PCM_TX_DESCRIPTORS		15
+#define AN7581_PCM_RX_DESCRIPTORS		15
+#define AN7581_PCM_DESCRIPTORS			(AN7581_PCM_TX_DESCRIPTORS + AN7581_PCM_RX_DESCRIPTORS)
+#define AN7581_PCM_SAMPLE_SIZE			80
+#define AN7581_PCM_BUFFER_SIZE			160
+
+#define AN7581_PCM_DESC_STATUS_OWNERSHIP	BIT(31)
+#define AN7581_PCM_DESC_STATUS_OWNERSHIP_CPU	FIELD_PREP_CONST(AN7581_PCM_DESC_STATUS_OWNERSHIP, 0x0)
+#define AN7581_PCM_DESC_STATUS_OWNERSHIP_DMA	FIELD_PREP_CONST(AN7581_PCM_DESC_STATUS_OWNERSHIP, 0x1)
+#define AN7581_PCM_DESC_STATUS_SAMPLE_SIZE	GENMASK(9, 0)
+
+struct an7581_pcm_desc {
+	u32 status;
+	u32 channel_mask;
+	dma_addr_t buf;
+};
+
+enum an7581_pcm_direction {
+	AN7581_PCM_PLAYBACK,
+	AN7581_PCM_CAPTURE,
+};
+
+enum an7581_pcm_bitwidth {
+	AN7581_PCM_BITWIDTH_8BIT = 8,
+	AN7581_PCM_BITWIDTH_16BIT = 16,
+};
+
+struct an7581_pcm_priv {
+	struct regmap *map;
+	struct reset_control *reset;
+
+	struct snd_pcm_substream *playback_stream;
+	struct snd_pcm_substream *capture_stream;
+
+	/* Protect descriptor idx */
+	spinlock_t desc_lock;
+
+	struct an7581_pcm_desc *tx_descs;
+	int tx_desc_idx;
+	dma_addr_t tx_dma;
+
+	struct an7581_pcm_desc *rx_descs;
+	int rx_desc_idx;
+	dma_addr_t rx_dma;
+};
+
+static const struct snd_pcm_hardware an7581_pcm_hardware = {
+	.info			= SNDRV_PCM_INFO_MMAP |
+				  SNDRV_PCM_INFO_MMAP_VALID |
+				  SNDRV_PCM_INFO_INTERLEAVED,
+	.formats		= SNDRV_PCM_FMTBIT_U8,
+	.buffer_bytes_max	= AN7581_PCM_BUFFER_SIZE,
+	.periods_min		= AN7581_PCM_SAMPLE_SIZE,
+	.periods_max		= AN7581_PCM_BUFFER_SIZE / AN7581_PCM_SAMPLE_SIZE,
+	.channels_min		= 1,
+	.channels_max		= AN7581_PCM_MAX_CHANNELS,
+};
+
+static int an7581_pcm_setup_time_slot(struct an7581_pcm_priv *priv,
+				      int direction, int bit_width)
+{
+	int bit_counter = 0;
+	int chan;
+
+	for (chan = 0; chan < AN7581_PCM_MAX_CHANNELS; chan++) {
+		u32 mask, val;
+
+		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
+			mask = AN7581_PCM_TXTS_BW(chan) |
+			       AN7581_PCM_TXTS_START(chan);
+
+			if (bit_width == 8)
+				val = AN7581_PCM_TXTS_BW_8BIT(chan);
+			else
+				val = AN7581_PCM_TXTS_BW_16BIT(chan);
+			val |= bit_counter << __bf_shf(AN7581_PCM_TXTS_START(chan));
+		} else {
+			mask = AN7581_PCM_RXTS_BW(chan) |
+			       AN7581_PCM_RXTS_START(chan);
+
+			if (bit_width == 8)
+				val = AN7581_PCM_RXTS_BW_8BIT(chan);
+			else
+				val = AN7581_PCM_RXTS_BW_16BIT(chan);
+			val |= bit_counter << __bf_shf(AN7581_PCM_RXTS_START(chan));
+		}
+
+		regmap_update_bits(priv->map, AN7581_PCM_PTTSCR(chan),
+				   mask, val);
+
+		bit_counter += bit_width;
+	}
+
+	return 0;
+}
+
+static int an7581_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct an7581_pcm_priv *priv = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		priv->playback_stream = substream;
+	else
+		priv->capture_stream = substream;
+
+	/* On open mask interrupt and disable DMA */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		regmap_clear_bits(priv->map, AN7581_PCM_IMR,
+				  AN7581_PCM_IMR_TDESC_END_INT |
+				  AN7581_PCM_IMR_TDESC_UPDATE_INT);
+		regmap_clear_bits(priv->map, AN7581_PCM_TRDCR,
+				  AN7581_PCM_TXDMA_ENABLE);
+	} else {
+		regmap_clear_bits(priv->map, AN7581_PCM_IMR,
+				  AN7581_PCM_IMR_RDESC_END_INT |
+				  AN7581_PCM_IMR_RDESC_UPDATE_INT);
+		regmap_clear_bits(priv->map, AN7581_PCM_TRDCR,
+				  AN7581_PCM_RXDMA_ENABLE);
+	}
+
+	usleep_range(10, 20);
+
+	regmap_clear_bits(priv->map, AN7581_PCM_PICR,
+			  AN7581_PCM_CFG_VALID);
+
+	usleep_range(5000, 10000);
+
+	/* Enable channels */
+	regmap_update_bits(priv->map, AN7581_PCM_DCHENR,
+			   AN7581_PCM_CHAN_EN,
+			   FIELD_PREP(AN7581_PCM_CHAN_EN,
+				      BIT(AN7581_PCM_MAX_CHANNELS) - 1));
+
+	/* Enable interrupt */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		regmap_set_bits(priv->map, AN7581_PCM_IMR,
+				AN7581_PCM_IMR_TDESC_END_INT |
+				AN7581_PCM_IMR_TDESC_UPDATE_INT);
+	} else {
+		regmap_set_bits(priv->map, AN7581_PCM_IMR,
+				AN7581_PCM_IMR_RDESC_END_INT |
+				AN7581_PCM_IMR_RDESC_UPDATE_INT);
+	}
+
+	snd_soc_set_runtime_hwparams(substream, &an7581_pcm_hardware);
+	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+
+	return 0;
+}
+
+static int an7581_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct an7581_pcm_priv *priv = snd_pcm_substream_chip(substream);
+
+	/* On close mask interrupt and disable DMA */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		regmap_clear_bits(priv->map, AN7581_PCM_IMR,
+				  AN7581_PCM_IMR_TDESC_END_INT |
+				  AN7581_PCM_IMR_TDESC_UPDATE_INT);
+		regmap_clear_bits(priv->map, AN7581_PCM_TRDCR,
+				  AN7581_PCM_TXDMA_ENABLE);
+	} else {
+		regmap_clear_bits(priv->map, AN7581_PCM_IMR,
+				  AN7581_PCM_IMR_RDESC_END_INT |
+				  AN7581_PCM_IMR_RDESC_UPDATE_INT);
+		regmap_clear_bits(priv->map, AN7581_PCM_TRDCR,
+				  AN7581_PCM_RXDMA_ENABLE);
+	}
+
+	usleep_range(10, 20);
+
+	regmap_clear_bits(priv->map, AN7581_PCM_PICR,
+			  AN7581_PCM_CFG_VALID);
+
+	return 0;
+}
+
+static int an7581_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+static int an7581_pcm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct an7581_pcm_priv *priv = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct an7581_pcm_desc *desc;
+	int num_desc, i;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		desc = priv->tx_descs;
+		num_desc = AN7581_PCM_TX_DESCRIPTORS;
+	} else {
+		desc = priv->rx_descs;
+		num_desc = AN7581_PCM_RX_DESCRIPTORS;
+	}
+
+	/* Setup timeslot */
+	an7581_pcm_setup_time_slot(priv, substream->stream, params_width(params));
+
+	/* Setup Descriptor size and number */
+	regmap_update_bits(priv->map, AN7581_PCM_TRDRSR,
+			   AN7581_DESC_OFFSET | AN7581_DESC_SIZE,
+			   FIELD_PREP(AN7581_DESC_OFFSET, sizeof(*desc) / sizeof(u32) |
+			   FIELD_PREP(AN7581_DESC_SIZE, AN7581_PCM_TX_DESCRIPTORS)));
+
+	/* FIXME: Confirm this actually set buffer size */
+	regmap_update_bits(priv->map, AN7581_PCM_CHBFOSR,
+			   AN7581_PCM_DESC_CHBF_OFFSET,
+			   FIELD_PREP(AN7581_PCM_DESC_CHBF_OFFSET,
+				      AN7581_PCM_BUFFER_SIZE));
+
+	/* Configure each RX descriptor for DMA ownership and sample size */
+	for (i = 0; i < num_desc; i++) {
+		/* Assign to each descriptor the dma_addr + offset of period bytes */
+		desc->buf = runtime->dma_addr + (i * params_period_bytes(params));
+		desc->status = AN7581_PCM_DESC_STATUS_OWNERSHIP_DMA |
+				  FIELD_PREP(AN7581_PCM_DESC_STATUS_SAMPLE_SIZE,
+					     AN7581_PCM_SAMPLE_SIZE);
+		desc->channel_mask = BIT(AN7581_PCM_MAX_CHANNELS) - 1;
+
+		desc++;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		regmap_set_bits(priv->map, AN7581_PCM_TRDCR,
+				AN7581_PCM_TXDMA_ENABLE);
+	else
+		regmap_set_bits(priv->map, AN7581_PCM_TRDCR,
+				AN7581_PCM_RXDMA_ENABLE);
+
+	/* Signal PCM configuration is now valid */
+	regmap_set_bits(priv->map, AN7581_PCM_PICR,
+			AN7581_PCM_CFG_VALID);
+
+	return 0;
+}
+
+static int an7581_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct an7581_pcm_priv *priv = snd_pcm_substream_chip(substream);
+	unsigned long flags;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		/* Trigger PCM to POLL new descriptor */
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			rcu_assign_pointer(priv->playback_stream, substream);
+
+			spin_lock_irqsave(&priv->desc_lock, flags);
+			priv->rx_desc_idx = 0;
+			spin_unlock_irqrestore(&priv->desc_lock, flags);
+
+			regmap_set_bits(priv->map, AN7581_PCM_TPDR,
+					AN7581_PCM_TX_POLLING);
+		} else {
+			rcu_assign_pointer(priv->capture_stream, substream);
+
+			spin_lock_irqsave(&priv->desc_lock, flags);
+			priv->tx_desc_idx = 0;
+			spin_unlock_irqrestore(&priv->desc_lock, flags);
+
+			regmap_set_bits(priv->map, AN7581_PCM_RPDR,
+					AN7581_PCM_RX_POLLING);
+		}
+
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			rcu_assign_pointer(priv->playback_stream, NULL);
+		else
+			rcu_assign_pointer(priv->capture_stream, NULL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static snd_pcm_uframes_t an7581_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct an7581_pcm_priv *priv = snd_pcm_substream_chip(substream);
+	unsigned long flags;
+	int idx;
+
+	spin_lock_irqsave(&priv->desc_lock, flags);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		idx = priv->tx_desc_idx;
+	else
+		idx = priv->rx_desc_idx;
+
+	spin_unlock_irqrestore(&priv->desc_lock, flags);
+
+	return idx;
+}
+
+static irqreturn_t an7581_pcm_irq_handler(int irq, void *data)
+{
+	struct snd_pcm_substream *substream;
+	struct an7581_pcm_priv *priv = data;
+	unsigned long flags;
+	u32 isr;
+	int i;
+
+	regmap_read(priv->map, AN7581_PCM_ISR, &isr);
+
+	/* Scan descriptor on receiving RX desc update interrupt */
+	if (isr & AN7581_PCM_IMR_RDESC_UPDATE_INT) {
+		spin_lock_irqsave(&priv->desc_lock, flags);
+
+		for (i = 0; i < AN7581_PCM_RX_DESCRIPTORS; i++) {
+			if (FIELD_GET(AN7581_PCM_DESC_STATUS_OWNERSHIP,
+				      priv->rx_descs[i].status) ==
+			    AN7581_PCM_DESC_STATUS_OWNERSHIP_CPU)
+				priv->rx_desc_idx++;
+		}
+
+		spin_unlock_irqrestore(&priv->desc_lock, flags);
+	}
+
+	/* Scan descriptor on receiving TX desc update interrupt */
+	if (isr & AN7581_PCM_IMR_TDESC_UPDATE_INT) {
+		spin_lock_irqsave(&priv->desc_lock, flags);
+
+		for (i = 0; i < AN7581_PCM_TX_DESCRIPTORS; i++) {
+			if (FIELD_GET(AN7581_PCM_DESC_STATUS_OWNERSHIP,
+				      priv->tx_descs[i].status) ==
+			    AN7581_PCM_DESC_STATUS_OWNERSHIP_CPU)
+				priv->tx_desc_idx++;
+		}
+
+		spin_unlock_irqrestore(&priv->desc_lock, flags);
+	}
+
+	/* Signal elapsed if we are finished handling TX/RX frame */
+	if (isr & AN7581_PCM_IMR_RDESC_END_INT ||
+	    isr & AN7581_PCM_IMR_TDESC_END_INT) {
+		rcu_read_lock();
+
+		if (isr & AN7581_PCM_IMR_TDESC_END_INT) {
+			substream = rcu_dereference(priv->playback_stream);
+
+			if (substream && snd_pcm_running(substream))
+				snd_pcm_period_elapsed(substream);
+		}
+
+		if (isr & AN7581_PCM_IMR_RDESC_END_INT) {
+			substream = rcu_dereference(priv->capture_stream);
+
+			if (substream && snd_pcm_running(substream))
+				snd_pcm_period_elapsed(substream);
+		}
+
+		rcu_read_unlock();
+	}
+
+	return IRQ_HANDLED;
+}
+
+static const struct snd_pcm_ops an7581_pcm_ops = {
+	.open		= an7581_pcm_open,
+	.close		= an7581_pcm_close,
+	.prepare	= an7581_pcm_prepare,
+	.hw_params	= an7581_pcm_hw_params,
+	.trigger	= an7581_pcm_trigger,
+	.pointer	= an7581_pcm_pointer,
+};
+
+static int an7581_pcm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct an7581_pcm_priv *priv;
+	struct snd_card *card;
+	struct snd_pcm *pcm;
+	int irq;
+	int ret;
+
+	ret = snd_devm_card_new(dev, 1, "AN7581 PCM SOUND",
+				THIS_MODULE, 0, &card);
+	if (ret)
+		return ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->map = device_node_to_regmap(dev->of_node);
+	if (!IS_ERR(priv->map))
+		return PTR_ERR(priv->map);
+
+	priv->reset = devm_reset_control_get_exclusive(dev, "pcm1");
+	if (IS_ERR(priv->reset))
+		return PTR_ERR(priv->reset);
+
+	irq = of_irq_get(dev_of_node(dev), 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, an7581_pcm_irq_handler,
+					NULL, IRQF_ONESHOT,
+					dev_name(dev), priv);
+	if (ret)
+		return ret;
+
+	spin_lock_init(&priv->desc_lock);
+
+	ret = snd_pcm_new(card, "AN7581 PCM", 0,
+			  1, /* 1 playback substreams */
+			  1, /* 1 capture substream */
+			  &pcm);
+	if (ret)
+		return ret;
+
+	/* Reset the PCM interface */
+	reset_control_assert(priv->reset);
+	usleep_range(5000, 10000);
+	reset_control_deassert(priv->reset);
+	usleep_range(5000, 10000);
+
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+			&an7581_pcm_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
+			&an7581_pcm_ops);
+	pcm->private_data = priv;
+
+	priv->tx_descs = dma_alloc_coherent(dev, sizeof(struct an7581_pcm_desc) *
+					    AN7581_PCM_TX_DESCRIPTORS, &priv->tx_dma,
+					    GFP_KERNEL);
+	if (!priv->tx_descs)
+		return -ENOMEM;
+
+	priv->rx_descs = dma_alloc_coherent(dev, sizeof(struct an7581_pcm_desc) *
+					    AN7581_PCM_RX_DESCRIPTORS, &priv->rx_dma,
+					    GFP_KERNEL);
+	if (!priv->rx_descs) {
+		ret = -ENOMEM;
+		goto err_free_tx;
+	}
+
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_DEV, NULL,
+				       AN7581_PCM_BUFFER_SIZE * AN7581_PCM_TX_DESCRIPTORS,
+				       0);
+
+	strscpy(card->driver, "an7581-pcm", sizeof(card->driver));
+	strscpy(card->shortname, "AN7581 PCM SOUND", sizeof(card->shortname));
+	strscpy(card->longname, "Airoha AN7581 PCM Dedicated Sound Card",
+		sizeof(card->longname));
+
+	ret = snd_card_register(card);
+	if (ret) {
+		dev_err_probe(dev, ret, "%s snd_soc_register_card fail\n", __func__);
+		goto err_free_rx;
+	}
+
+	return 0;
+
+err_free_rx:
+	dma_free_coherent(dev, sizeof(struct an7581_pcm_desc) *
+			  AN7581_PCM_RX_DESCRIPTORS, priv->rx_descs, priv->rx_dma);
+err_free_tx:
+	dma_free_coherent(dev, sizeof(struct an7581_pcm_desc) *
+			  AN7581_PCM_TX_DESCRIPTORS, priv->tx_descs, priv->tx_dma);
+
+	return ret;
+}
+
+static const struct of_device_id an7581_pcm_dt_match[] = {
+	{ .compatible = "airoha,an7581-pcm" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, an7581_pcm_dt_match);
+
+static struct platform_driver an7581_pcm_driver = {
+	.driver = {
+		   .name = "an7581-pcm",
+		   .of_match_table = an7581_pcm_dt_match,
+	},
+	.probe = an7581_pcm_probe,
+};
+module_platform_driver(an7581_pcm_driver);
+
+MODULE_DESCRIPTION("Airoha SoC PCM platform driver for ALSA AN7581");
+MODULE_LICENSE("GPL");
-- 
2.51.0


