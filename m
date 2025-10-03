Return-Path: <linux-kernel+bounces-841619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D71DFBB7D53
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 20:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB194A4758
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 18:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88662DCF71;
	Fri,  3 Oct 2025 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RtJSKRZq"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488C52D47E6;
	Fri,  3 Oct 2025 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514612; cv=none; b=EYvc1uY/sHMCT3Ve6g1BLCigsmJWKaYAAGCjAiXKrai4F+YFHlvZGUm8y+nXQkm4GNL8gXe1HeOi9idmLWq3eynAEjakKvKlrlwRhl4Uv1mROyUzKYZYVHmke94WxdnwGWm6onP0IWfvN+DdZzBhHYta7r4yhTFLbs4n97aXKHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514612; c=relaxed/simple;
	bh=GV/xLeikzitu0xIP/oUS/Qla+TzEuIi496JxSHqMe6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mRnjJx9B4n0W3Pn6CBzbEOEa/D1ZC8Z92EYrU7KjFAvCI9zLP5Q/SZPXjeutDwbJXIwB+JWzv8N6A/2gt7yG34ruTEN/jbkwfzRC4ZiR7hTtHEiQv6ZV1OovpVLy1claf0tYM13aEUtoK8vEmyKXrEPoGDSuwxsSK/0EaFVM08Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RtJSKRZq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759514608;
	bh=GV/xLeikzitu0xIP/oUS/Qla+TzEuIi496JxSHqMe6I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RtJSKRZqI9xEg3W1ftPPYDW1J2LI6scpGhQGBWvnbhR65yZtZG7jXjGm6kpxl/OL6
	 thF0JtpDiONRYUWFdWxLl3nOcISrQraWlqgGNH91XaKY6SQGWJFo0MbWMPZkKZAttl
	 s9hnSsM3AL4e32uEFf62Cf3mhjMDI/EjRFjRkxNB00P4bRVIcWNLfMTLh4KIajiW+Q
	 LkEBDhNePdZ4ZOhaFmJ4gmG/4PdX+aeAzgsJw/IwsZT6NsoH4OeD6+84alHdHH2eAR
	 gZGI7DpscEz94vhtgvKw1ODRfsHbt2sGd31PIWCMiha24xsNBIy4pRB1FzGh/508Ky
	 e5B94WMDxjgOg==
Received: from localhost (unknown [82.79.138.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 5B77017E12F7;
	Fri,  3 Oct 2025 20:03:28 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 03 Oct 2025 21:03:23 +0300
Subject: [PATCH 1/5] ASoC: nau8821: Cancel jdet_work before handling jack
 ejection
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-nau8821-jdet-fixes-v1-1-f7b0e2543f09@collabora.com>
References: <20251003-nau8821-jdet-fixes-v1-0-f7b0e2543f09@collabora.com>
In-Reply-To: <20251003-nau8821-jdet-fixes-v1-0-f7b0e2543f09@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Seven Lee <wtli@nuvoton.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

The microphone detection work scheduled by a prior jack insertion
interrupt may still be in a pending state or under execution when a jack
ejection interrupt has been fired.

This might lead to a racing condition or nau8821_jdet_work() completing
after nau8821_eject_jack(), which will override the currently
disconnected state of the jack and incorrectly report the headphone or
the headset as being connected.

Cancel any pending jdet_work or wait for its execution to finish before
attempting to handle the ejection interrupt.

Proceed similarly before launching the eject handler as a consequence of
detecting an invalid insert interrupt.

Fixes: aab1ad11d69f ("ASoC: nau8821: new driver")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/codecs/nau8821.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index edb95f869a4a6ba63622b2d27d7b359c6aeea5ef..fed5d51fa5c3b4ea6060cc3b8287261d7509e225 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -1185,6 +1185,7 @@ static irqreturn_t nau8821_interrupt(int irq, void *data)
 
 	if ((active_irq & NAU8821_JACK_EJECT_IRQ_MASK) ==
 		NAU8821_JACK_EJECT_DETECTED) {
+		cancel_work_sync(&nau8821->jdet_work);
 		regmap_update_bits(regmap, NAU8821_R71_ANALOG_ADC_1,
 			NAU8821_MICDET_MASK, NAU8821_MICDET_DIS);
 		nau8821_eject_jack(nau8821);
@@ -1199,11 +1200,11 @@ static irqreturn_t nau8821_interrupt(int irq, void *data)
 		clear_irq = NAU8821_KEY_RELEASE_IRQ;
 	} else if ((active_irq & NAU8821_JACK_INSERT_IRQ_MASK) ==
 		NAU8821_JACK_INSERT_DETECTED) {
+		cancel_work_sync(&nau8821->jdet_work);
 		regmap_update_bits(regmap, NAU8821_R71_ANALOG_ADC_1,
 			NAU8821_MICDET_MASK, NAU8821_MICDET_EN);
 		if (nau8821_is_jack_inserted(regmap)) {
 			/* detect microphone and jack type */
-			cancel_work_sync(&nau8821->jdet_work);
 			schedule_work(&nau8821->jdet_work);
 			/* Turn off insertion interruption at manual mode */
 			regmap_update_bits(regmap,

-- 
2.51.0


