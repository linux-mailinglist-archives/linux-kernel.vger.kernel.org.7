Return-Path: <linux-kernel+bounces-841623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 28550BB7D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A71B347E9D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7DE2DFA31;
	Fri,  3 Oct 2025 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="joWgKKRr"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E4A2DCF7C;
	Fri,  3 Oct 2025 18:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514615; cv=none; b=p+QqXBN9jQmKQHQUgWGdPVBw7PzrrLNaboB/7FJUQesjMhtjG8KG3zhUVlGRgqcf8CdcIaZSyOFQ10kgbGM3YJieYAYFS/36o/RUhUuUXvV/zMwrilA/R+Idpxjw6Y1r9j5RdnwUGXDQ3WNjhSu8Lb0DcjHFpSWDXhQd9N8wSOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514615; c=relaxed/simple;
	bh=r9BeudjsMH6lI7IndJz+R0dMlSTF75UDl/Hoh5nL3fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ju3j02lNhOwuBqiIr3WKOVSAIoniwwS3rQURjGTWwaDpx2aB97XIdeATN1neWju4l7V4A75Dmi+4qgKfhzTfvQNr920toICLCe6a9KkPCCdWE8BwXck2DqA2tW3oPgj/Isk4qwb+LzxDxXY106njLI1jS/gGr4zZ+riOOqKhB+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=joWgKKRr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759514611;
	bh=r9BeudjsMH6lI7IndJz+R0dMlSTF75UDl/Hoh5nL3fg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=joWgKKRrPUfr+ZVUb31WMu9Lq9EYmFEKDeUIpTeGxd91B5BY559n7PtiE5lko71/N
	 2h51SS5Svz9JAz/5YQ1C6XsuN9yp7k2oTlVit+3j7LTtRTywVsu5m2GQyE+O69nCiZ
	 FR0EX6pJ0mRBmqNybMorj7k5shy80mS+YIDL3g6G/48BG5+rQxCK4aA6eqOdWGxTfA
	 w5KsNgkRpLBrjeieQrVvGh4tMhV4Zagb82XuF5gfDv+1/6X2sk1goghM0M6bnkKOq2
	 kRqJdRvt33QKeH32cvilcnWv/lQWIsPmxgv/q07nBrBWRXm54HjciCAtu7Nfj3hRcv
	 LM2ncX/NG/YaQ==
Received: from localhost (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 92E5C17E13C3;
	Fri,  3 Oct 2025 20:03:31 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 03 Oct 2025 21:03:27 +0300
Subject: [PATCH 5/5] ASoC: nau8821: Avoid unnecessary blocking in IRQ
 handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-nau8821-jdet-fixes-v1-5-f7b0e2543f09@collabora.com>
References: <20251003-nau8821-jdet-fixes-v1-0-f7b0e2543f09@collabora.com>
In-Reply-To: <20251003-nau8821-jdet-fixes-v1-0-f7b0e2543f09@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Seven Lee <wtli@nuvoton.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

The interrupt handler offloads the microphone detection logic to
nau8821_jdet_work(), which implies a sleep operation.  However, before
being able to process any subsequent hotplug event, the interrupt
handler needs to wait for any prior scheduled work to complete.

Move the sleep out of jdet_work by converting it to a delayed work.
This eliminates the undesired blocking in the interrupt handler when
attempting to cancel a recently scheduled work item and should help
reducing transient input reports that might confuse user-space.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/codecs/nau8821.c | 22 ++++++++++++----------
 sound/soc/codecs/nau8821.h |  2 +-
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index a8ff2ce70be9a94e7094696e06bda93f27fdea93..4fa9a785513e52ae509b32a8acda7e96dde218d6 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -1104,16 +1104,12 @@ static void nau8821_eject_jack(struct nau8821 *nau8821)
 static void nau8821_jdet_work(struct work_struct *work)
 {
 	struct nau8821 *nau8821 =
-		container_of(work, struct nau8821, jdet_work);
+		container_of(work, struct nau8821, jdet_work.work);
 	struct snd_soc_dapm_context *dapm = nau8821->dapm;
 	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
 	struct regmap *regmap = nau8821->regmap;
 	int jack_status_reg, mic_detected, event = 0, event_mask = 0;
 
-	snd_soc_component_force_enable_pin(component, "MICBIAS");
-	snd_soc_dapm_sync(dapm);
-	msleep(20);
-
 	regmap_read(regmap, NAU8821_R58_I2C_DEVICE_ID, &jack_status_reg);
 	mic_detected = !(jack_status_reg & NAU8821_KEYDET);
 	if (mic_detected) {
@@ -1146,6 +1142,7 @@ static void nau8821_jdet_work(struct work_struct *work)
 		snd_soc_component_disable_pin(component, "MICBIAS");
 		snd_soc_dapm_sync(dapm);
 	}
+
 	event_mask |= SND_JACK_HEADSET;
 	snd_soc_jack_report(nau8821->jack, event, event_mask);
 }
@@ -1194,6 +1191,7 @@ static irqreturn_t nau8821_interrupt(int irq, void *data)
 {
 	struct nau8821 *nau8821 = (struct nau8821 *)data;
 	struct regmap *regmap = nau8821->regmap;
+	struct snd_soc_component *component;
 	int active_irq, event = 0, event_mask = 0;
 
 	if (regmap_read(regmap, NAU8821_R10_IRQ_STATUS, &active_irq)) {
@@ -1205,7 +1203,7 @@ static irqreturn_t nau8821_interrupt(int irq, void *data)
 
 	if ((active_irq & NAU8821_JACK_EJECT_IRQ_MASK) ==
 		NAU8821_JACK_EJECT_DETECTED) {
-		cancel_work_sync(&nau8821->jdet_work);
+		cancel_delayed_work_sync(&nau8821->jdet_work);
 		regmap_update_bits(regmap, NAU8821_R71_ANALOG_ADC_1,
 			NAU8821_MICDET_MASK, NAU8821_MICDET_DIS);
 		nau8821_eject_jack(nau8821);
@@ -1219,12 +1217,15 @@ static irqreturn_t nau8821_interrupt(int irq, void *data)
 		nau8821_irq_status_clear(regmap, NAU8821_KEY_RELEASE_IRQ);
 	} else if ((active_irq & NAU8821_JACK_INSERT_IRQ_MASK) ==
 		NAU8821_JACK_INSERT_DETECTED) {
-		cancel_work_sync(&nau8821->jdet_work);
+		cancel_delayed_work_sync(&nau8821->jdet_work);
 		regmap_update_bits(regmap, NAU8821_R71_ANALOG_ADC_1,
 			NAU8821_MICDET_MASK, NAU8821_MICDET_EN);
 		if (nau8821_is_jack_inserted(regmap)) {
-			/* detect microphone and jack type */
-			schedule_work(&nau8821->jdet_work);
+			/* Detect microphone and jack type */
+			component = snd_soc_dapm_to_component(nau8821->dapm);
+			snd_soc_component_force_enable_pin(component, "MICBIAS");
+			snd_soc_dapm_sync(nau8821->dapm);
+			schedule_delayed_work(&nau8821->jdet_work, msecs_to_jiffies(20));
 			/* Turn off insertion interruption at manual mode */
 			nau8821_setup_inserted_irq(nau8821);
 		} else {
@@ -1661,7 +1662,8 @@ int nau8821_enable_jack_detect(struct snd_soc_component *component,
 
 	nau8821->jack = jack;
 	/* Initiate jack detection work queue */
-	INIT_WORK(&nau8821->jdet_work, nau8821_jdet_work);
+	INIT_DELAYED_WORK(&nau8821->jdet_work, nau8821_jdet_work);
+
 	ret = devm_request_threaded_irq(nau8821->dev, nau8821->irq, NULL,
 		nau8821_interrupt, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 		"nau8821", nau8821);
diff --git a/sound/soc/codecs/nau8821.h b/sound/soc/codecs/nau8821.h
index f0935ffafcbecbd1ac52da3c5122a0da28d0ed2a..88602923780d85971135be4ac32b45e2d2d67517 100644
--- a/sound/soc/codecs/nau8821.h
+++ b/sound/soc/codecs/nau8821.h
@@ -561,7 +561,7 @@ struct nau8821 {
 	struct regmap *regmap;
 	struct snd_soc_dapm_context *dapm;
 	struct snd_soc_jack *jack;
-	struct work_struct jdet_work;
+	struct delayed_work jdet_work;
 	int irq;
 	int clk_id;
 	int micbias_voltage;

-- 
2.51.0


