Return-Path: <linux-kernel+bounces-841621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FBCBB7D59
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68C1D3479F2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1032DF719;
	Fri,  3 Oct 2025 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IrkBkybK"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65422DCF4C;
	Fri,  3 Oct 2025 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514614; cv=none; b=Me3O2nwm+EQUrPIO7ayuu2bI6PHYQkk0MbKbsLayBXE3rhNwx65WmDWyF63gPPHos3eY93/Nw1sbtdUTBsigO7laVI2STrzI1bH9pYOSXcoy/h676X92NdUoDBcbUghTY7D/LUBjwYWOXyTrqFxlPoajv6dvfKWmv4tO4gxLIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514614; c=relaxed/simple;
	bh=JUPIQ0qb6eHCy9cI1y2tcCx0EM4NF0PNR9hoEG1qjMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CdD79YRKIkdPHPY4crE8RtpGgIUY8gVuMZJxOdKiWvy9sxm1j0IMW3zZE3bP3X3qblCXtgmoCUAnAGkY28pKN5eSo4XWnxSV6a6MMewDUo4pfyF+ZScyfTJ3l1B++PbI810vpiIGIiSrkfCjErqc7YZ0L1swidEfdMFx/0ceTj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IrkBkybK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759514610;
	bh=JUPIQ0qb6eHCy9cI1y2tcCx0EM4NF0PNR9hoEG1qjMw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IrkBkybKCYvYPT7sINzfH29CMUEjqWeURnjw4uaUfDK4MJwY9y+UlD2eOzkkMNlPF
	 T0Wnr1V6XFfMuS5Cctjo9U0zlH2EQlIx11eSZIY6Rx0xSNHM8PjocrviDaGEHOU+Rb
	 WEhwFRSKIICLC7+cNPTkMlO+dhvE7uhwq6DXnDapVi/P+uJaDELHiTcx9BGgkOpm5+
	 +G01c4uO1jfUWMQgPBJVOYcFaXbZv2GB3SZ5tAp/U5ZDFipWYHEM1p2wNkLjmOFiLv
	 e260QIiGL1OLCrHuEXpY1YPjThGeVzNrjdm0riWPiMOre1nR0C6YRKKfCDw5sn0jtF
	 p3uFhG3usYQyg==
Received: from localhost (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id EF6A817E13B9;
	Fri,  3 Oct 2025 20:03:29 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 03 Oct 2025 21:03:25 +0300
Subject: [PATCH 3/5] ASoC: nau8821: Consistently clear interrupts before
 unmasking
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-nau8821-jdet-fixes-v1-3-f7b0e2543f09@collabora.com>
References: <20251003-nau8821-jdet-fixes-v1-0-f7b0e2543f09@collabora.com>
In-Reply-To: <20251003-nau8821-jdet-fixes-v1-0-f7b0e2543f09@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Seven Lee <wtli@nuvoton.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

The interrupt handler attempts to perform some IRQ status clear
operations *after* rather than *before* unmasking and enabling
interrupts.  This is a rather fragile approach since it may generally
lead to missing IRQ requests or causing spurious interrupts.

Make use of the nau8821_irq_status_clear() helper instead of
manipulating the related register directly and ensure any interrupt
clearing is performed *after* the target interrupts are disabled/masked
and *before* proceeding with additional interrupt unmasking/enablement
operations.

This also implicitly drops the redundant clear operation of the ejection
IRQ in the interrupt handler, since nau8821_eject_jack() has been
already responsible for clearing all active interrupts.

Fixes: aab1ad11d69f ("ASoC: nau8821: new driver")
Fixes: 2551b6e89936 ("ASoC: nau8821: Add headset button detection")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/codecs/nau8821.c | 58 ++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index cefce97893123462198c2e66d1de9d06e4d3dd28..56e5a0d80782b85d8c256745911297f8edf5dd98 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -1057,20 +1057,24 @@ static void nau8821_eject_jack(struct nau8821 *nau8821)
 	snd_soc_component_disable_pin(component, "MICBIAS");
 	snd_soc_dapm_sync(dapm);
 
+	/* Disable & mask both insertion & ejection IRQs */
+	regmap_update_bits(regmap, NAU8821_R12_INTERRUPT_DIS_CTRL,
+			   NAU8821_IRQ_INSERT_DIS | NAU8821_IRQ_EJECT_DIS,
+			   NAU8821_IRQ_INSERT_DIS | NAU8821_IRQ_EJECT_DIS);
+	regmap_update_bits(regmap, NAU8821_R0F_INTERRUPT_MASK,
+			   NAU8821_IRQ_INSERT_EN | NAU8821_IRQ_EJECT_EN,
+			   NAU8821_IRQ_INSERT_EN | NAU8821_IRQ_EJECT_EN);
+
 	/* Clear all interruption status */
 	nau8821_irq_status_clear(regmap, 0);
 
-	/* Enable the insertion interruption, disable the ejection inter-
-	 * ruption, and then bypass de-bounce circuit.
-	 */
+	/* Enable & unmask the insertion IRQ */
 	regmap_update_bits(regmap, NAU8821_R12_INTERRUPT_DIS_CTRL,
-		NAU8821_IRQ_EJECT_DIS | NAU8821_IRQ_INSERT_DIS,
-		NAU8821_IRQ_EJECT_DIS);
-	/* Mask unneeded IRQs: 1 - disable, 0 - enable */
+			   NAU8821_IRQ_INSERT_DIS, 0);
 	regmap_update_bits(regmap, NAU8821_R0F_INTERRUPT_MASK,
-		NAU8821_IRQ_EJECT_EN | NAU8821_IRQ_INSERT_EN,
-		NAU8821_IRQ_EJECT_EN);
+			   NAU8821_IRQ_INSERT_EN, 0);
 
+	/* Bypass de-bounce circuit */
 	regmap_update_bits(regmap, NAU8821_R0D_JACK_DET_CTRL,
 		NAU8821_JACK_DET_DB_BYPASS, NAU8821_JACK_DET_DB_BYPASS);
 
@@ -1094,7 +1098,6 @@ static void nau8821_eject_jack(struct nau8821 *nau8821)
 			NAU8821_IRQ_KEY_RELEASE_DIS |
 			NAU8821_IRQ_KEY_PRESS_DIS);
 	}
-
 }
 
 static void nau8821_jdet_work(struct work_struct *work)
@@ -1151,6 +1154,15 @@ static void nau8821_setup_inserted_irq(struct nau8821 *nau8821)
 {
 	struct regmap *regmap = nau8821->regmap;
 
+	/* Disable & mask insertion IRQ */
+	regmap_update_bits(regmap, NAU8821_R12_INTERRUPT_DIS_CTRL,
+			   NAU8821_IRQ_INSERT_DIS, NAU8821_IRQ_INSERT_DIS);
+	regmap_update_bits(regmap, NAU8821_R0F_INTERRUPT_MASK,
+			   NAU8821_IRQ_INSERT_EN, NAU8821_IRQ_INSERT_EN);
+
+	/* Clear insert IRQ status */
+	nau8821_irq_status_clear(regmap, NAU8821_JACK_INSERT_DETECTED);
+
 	/* Enable internal VCO needed for interruptions */
 	if (nau8821->dapm->bias_level < SND_SOC_BIAS_PREPARE)
 		nau8821_configure_sysclk(nau8821, NAU8821_CLK_INTERNAL, 0);
@@ -1169,17 +1181,18 @@ static void nau8821_setup_inserted_irq(struct nau8821 *nau8821)
 	regmap_update_bits(regmap, NAU8821_R0D_JACK_DET_CTRL,
 		NAU8821_JACK_DET_DB_BYPASS, 0);
 
+	/* Unmask & enable the ejection IRQs */
 	regmap_update_bits(regmap, NAU8821_R0F_INTERRUPT_MASK,
-		NAU8821_IRQ_EJECT_EN, 0);
+			   NAU8821_IRQ_EJECT_EN, 0);
 	regmap_update_bits(regmap, NAU8821_R12_INTERRUPT_DIS_CTRL,
-		NAU8821_IRQ_EJECT_DIS, 0);
+			   NAU8821_IRQ_EJECT_DIS, 0);
 }
 
 static irqreturn_t nau8821_interrupt(int irq, void *data)
 {
 	struct nau8821 *nau8821 = (struct nau8821 *)data;
 	struct regmap *regmap = nau8821->regmap;
-	int active_irq, clear_irq = 0, event = 0, event_mask = 0;
+	int active_irq, event = 0, event_mask = 0;
 
 	if (regmap_read(regmap, NAU8821_R10_IRQ_STATUS, &active_irq)) {
 		dev_err(nau8821->dev, "failed to read irq status\n");
@@ -1195,14 +1208,13 @@ static irqreturn_t nau8821_interrupt(int irq, void *data)
 			NAU8821_MICDET_MASK, NAU8821_MICDET_DIS);
 		nau8821_eject_jack(nau8821);
 		event_mask |= SND_JACK_HEADSET;
-		clear_irq = NAU8821_JACK_EJECT_IRQ_MASK;
 	} else if (active_irq & NAU8821_KEY_SHORT_PRESS_IRQ) {
 		event |= NAU8821_BUTTON;
 		event_mask |= NAU8821_BUTTON;
-		clear_irq = NAU8821_KEY_SHORT_PRESS_IRQ;
+		nau8821_irq_status_clear(regmap, NAU8821_KEY_SHORT_PRESS_IRQ);
 	} else if (active_irq & NAU8821_KEY_RELEASE_IRQ) {
 		event_mask = NAU8821_BUTTON;
-		clear_irq = NAU8821_KEY_RELEASE_IRQ;
+		nau8821_irq_status_clear(regmap, NAU8821_KEY_RELEASE_IRQ);
 	} else if ((active_irq & NAU8821_JACK_INSERT_IRQ_MASK) ==
 		NAU8821_JACK_INSERT_DETECTED) {
 		cancel_work_sync(&nau8821->jdet_work);
@@ -1212,27 +1224,17 @@ static irqreturn_t nau8821_interrupt(int irq, void *data)
 			/* detect microphone and jack type */
 			schedule_work(&nau8821->jdet_work);
 			/* Turn off insertion interruption at manual mode */
-			regmap_update_bits(regmap,
-				NAU8821_R12_INTERRUPT_DIS_CTRL,
-				NAU8821_IRQ_INSERT_DIS,
-				NAU8821_IRQ_INSERT_DIS);
-			regmap_update_bits(regmap,
-				NAU8821_R0F_INTERRUPT_MASK,
-				NAU8821_IRQ_INSERT_EN,
-				NAU8821_IRQ_INSERT_EN);
 			nau8821_setup_inserted_irq(nau8821);
 		} else {
 			dev_warn(nau8821->dev,
 				"Inserted IRQ fired but not connected\n");
 			nau8821_eject_jack(nau8821);
 		}
+	} else {
+		/* Clear the rightmost interrupt */
+		nau8821_irq_status_clear(regmap, active_irq);
 	}
 
-	if (!clear_irq)
-		clear_irq = active_irq;
-	/* clears the rightmost interruption */
-	regmap_write(regmap, NAU8821_R11_INT_CLR_KEY_STATUS, clear_irq);
-
 	if (event_mask)
 		snd_soc_jack_report(nau8821->jack, event, event_mask);
 

-- 
2.51.0


