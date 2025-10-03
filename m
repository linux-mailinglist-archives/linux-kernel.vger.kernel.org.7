Return-Path: <linux-kernel+bounces-841624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FDBBB7D72
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509BF4A5B10
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EF52DFA3E;
	Fri,  3 Oct 2025 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pvS4V9Pd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DB82D47FE;
	Fri,  3 Oct 2025 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514615; cv=none; b=i947oiZBj23GrUbDv/8drgp8+YY2F0l8vk4TQZ8kUrC2rPc/RvkHeqUN8qwQNxcumU3sbHfLsz9LsOD02myMxDqKsmNzME1oMzgIzsuxqzp4JFKv+P0g/Fk7p5rq1bSoSQgZ2V21sp9nBYr0bEI88LO7nzZNgrsJo91x7lxhFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514615; c=relaxed/simple;
	bh=Vgbgk+y+NPB1wmd8wO1pCyaZssvyi61KBIIiInoyMKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6qbb2Vn68Ra8kCnCe/fCBYfiOxROqQKLt5wvID9u0MDFx22DopOQshUVd06vWc+zk0scCJPUUGkEBkh3KD6t/FnZJDJFMUm4jIZc31veAhPOHLtwk7BoLPqsdoreSN+v5HBXHnbSkdy0WMKE0T7XigcxWW+la9NJ5jpkjc2Guc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pvS4V9Pd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759514610;
	bh=Vgbgk+y+NPB1wmd8wO1pCyaZssvyi61KBIIiInoyMKQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pvS4V9PdYqUuACK8Q9VoF7zBKyW/1ZIG+GgerwIs9LlUAVUEHMHmDlhBh7HjQJwRM
	 FQF45+f2InCX7tuqnr77JbSNtpzUoVnGyodQ+ExAGvZ/n98sF9SnbMw1EoKuEbbVZw
	 sqH6QMMQ+ZgSjluq0IjoNcf93ukV2PR2/yIP1uOEk2kmQMXrjiaWeoblVJt9Y3Fdh3
	 WPofQvdtPjZ7Bw07OpFeJNYMiOsCnSZ+JJ8raI0/jagGnhIMmTj9tUEXA4d2MRH5Cs
	 QShZmvmklRy3VD1qKcYudC/HLv9jweC1VCBt84M3Velmf3yfrFxDnpS9SUzejvC4b/
	 W5+6U33jflCRg==
Received: from localhost (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id BDDB617E13C1;
	Fri,  3 Oct 2025 20:03:30 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 03 Oct 2025 21:03:26 +0300
Subject: [PATCH 4/5] ASoC: nau8821: Add DMI quirk to bypass jack debounce
 circuit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-nau8821-jdet-fixes-v1-4-f7b0e2543f09@collabora.com>
References: <20251003-nau8821-jdet-fixes-v1-0-f7b0e2543f09@collabora.com>
In-Reply-To: <20251003-nau8821-jdet-fixes-v1-0-f7b0e2543f09@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Seven Lee <wtli@nuvoton.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Stress testing the audio jack hotplug handling on a few Steam Deck units
revealed that the debounce circuit is responsible for having a negative
impact on the detection reliability, e.g. in some cases the ejection
interrupt is not fired, while in other instances it goes into a kind of
invalid state and generates a flood of misleading interrupts.

Add new entries to the DMI table introduced via commit 1bc40efdaf4a
("ASoC: nau8821: Add DMI quirk mechanism for active-high jack-detect")
and extend the quirk logic to allow bypassing the debounce circuit used
for jack detection on Valve Steam Deck LCD and OLED models.

While at it, rename existing NAU8821_JD_ACTIVE_HIGH quirk bitfield to
NAU8821_QUIRK_JD_ACTIVE_HIGH.  This should help improve code readability
by differentiating from similarly named register bits.

Fixes: aab1ad11d69f ("ASoC: nau8821: new driver")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/codecs/nau8821.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index 56e5a0d80782b85d8c256745911297f8edf5dd98..a8ff2ce70be9a94e7094696e06bda93f27fdea93 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -26,7 +26,8 @@
 #include <sound/tlv.h>
 #include "nau8821.h"
 
-#define NAU8821_JD_ACTIVE_HIGH			BIT(0)
+#define NAU8821_QUIRK_JD_ACTIVE_HIGH			BIT(0)
+#define NAU8821_QUIRK_JD_DB_BYPASS			BIT(1)
 
 static int nau8821_quirk;
 static int quirk_override = -1;
@@ -1177,9 +1178,10 @@ static void nau8821_setup_inserted_irq(struct nau8821 *nau8821)
 	regmap_update_bits(regmap, NAU8821_R1D_I2S_PCM_CTRL2,
 		NAU8821_I2S_MS_MASK, NAU8821_I2S_MS_SLAVE);
 
-	/* Not bypass de-bounce circuit */
-	regmap_update_bits(regmap, NAU8821_R0D_JACK_DET_CTRL,
-		NAU8821_JACK_DET_DB_BYPASS, 0);
+	/* Do not bypass de-bounce circuit */
+	if (!(nau8821_quirk & NAU8821_QUIRK_JD_DB_BYPASS))
+		regmap_update_bits(regmap, NAU8821_R0D_JACK_DET_CTRL,
+				   NAU8821_JACK_DET_DB_BYPASS, 0);
 
 	/* Unmask & enable the ejection IRQs */
 	regmap_update_bits(regmap, NAU8821_R0F_INTERRUPT_MASK,
@@ -1864,7 +1866,23 @@ static const struct dmi_system_id nau8821_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
 			DMI_MATCH(DMI_BOARD_NAME, "CW14Q01P-V2"),
 		},
-		.driver_data = (void *)(NAU8821_JD_ACTIVE_HIGH),
+		.driver_data = (void *)(NAU8821_QUIRK_JD_ACTIVE_HIGH),
+	},
+	{
+		/* Valve Steam Deck LCD */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
+		},
+		.driver_data = (void *)(NAU8821_QUIRK_JD_DB_BYPASS),
+	},
+	{
+		/* Valve Steam Deck OLED */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Galileo"),
+		},
+		.driver_data = (void *)(NAU8821_QUIRK_JD_DB_BYPASS),
 	},
 	{}
 };
@@ -1906,9 +1924,12 @@ static int nau8821_i2c_probe(struct i2c_client *i2c)
 
 	nau8821_check_quirks();
 
-	if (nau8821_quirk & NAU8821_JD_ACTIVE_HIGH)
+	if (nau8821_quirk & NAU8821_QUIRK_JD_ACTIVE_HIGH)
 		nau8821->jkdet_polarity = 0;
 
+	if (nau8821_quirk & NAU8821_QUIRK_JD_DB_BYPASS)
+		dev_dbg(dev, "Force bypassing jack detection debounce circuit\n");
+
 	nau8821_print_device_properties(nau8821);
 
 	nau8821_reset_chip(nau8821->regmap);

-- 
2.51.0


