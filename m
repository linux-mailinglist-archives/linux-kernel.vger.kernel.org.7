Return-Path: <linux-kernel+bounces-812908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C2DB53E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7073AA94B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A98A2DF144;
	Thu, 11 Sep 2025 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VJ7nEJoU"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B84F21D5BC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627073; cv=none; b=LnKOdBDZb2ZldgGURhNosld3we9sxEWdUmMsRys8neMwr0pzClcCiE94+BKtwHeB73OTX5osCrWuJxDPjgMjwY6n6rgQaqyiani2k9CO2+lZwI9GoikUg9jBAoh2XHVHdu/XTbqNbPCiMLRsu+jGW3zHHoJ1fB/Xs3sWd8+xfyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627073; c=relaxed/simple;
	bh=mUvIbGyVkrFQ44a7PRrcV1n+CvoSl3HqAUu9F1HIHoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JPfqnnI1J2a6PVFdR0PiE01jw4EFp7yh9FDKawmotUOe0KyyIq4qAgD9n15GCk/I1Z6n4dNukiUFEEl4xYbDyeiJ2OfislfIk39qgJsO+r6FyvSGgPMUcosUM4hgXRNjanZQXGLjRKH2UGueC+fTynriFQpqvAWkP45naZx3Y0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VJ7nEJoU; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757627057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oSsmD+PT9J7Rok4sUSj0iKhGngM/Czt934IPRIT54X8=;
	b=VJ7nEJoURZKTp3AMNtFWZTZunptkFQ3hJgZglAaJad3SE5RQGE7N02UZ9TARw4BB+lpOR5
	nURSLtXRGfi5KPF/YKeyNijYlKtsPbK0w3DVsbSa/OA1fa+SDxUn9LX65EXs8w2JP0qL/2
	+4WjlieDhlKy932EffdHd3HHlTcvCYk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Johannes Berg <johannes@sipsolutions.net>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Takashi Iwai <tiwai@suse.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: aoa: Remove redundant size arguments from strscpy()
Date: Thu, 11 Sep 2025 23:43:22 +0200
Message-ID: <20250911214334.1482982-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The size parameter of strscpy() is optional if the destination buffer
has a fixed length and strscpy() can automatically determine its size
using sizeof(). This makes many explicit size arguments redundant.

Remove them to shorten and simplify the code.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/aoa/codecs/onyx.c    | 2 +-
 sound/aoa/codecs/tas.c     | 2 +-
 sound/aoa/codecs/toonie.c  | 2 +-
 sound/aoa/core/alsa.c      | 8 ++++----
 sound/aoa/fabrics/layout.c | 9 +++------
 5 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index ac347a14f282..fe59a7c59091 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -1013,7 +1013,7 @@ static int onyx_i2c_probe(struct i2c_client *client)
 		goto fail;
 	}
 
-	strscpy(onyx->codec.name, "onyx", MAX_CODEC_NAME_LEN);
+	strscpy(onyx->codec.name, "onyx");
 	onyx->codec.owner = THIS_MODULE;
 	onyx->codec.init = onyx_init_codec;
 	onyx->codec.exit = onyx_exit_codec;
diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
index 804b2ebbe28f..68b420a35fec 100644
--- a/sound/aoa/codecs/tas.c
+++ b/sound/aoa/codecs/tas.c
@@ -892,7 +892,7 @@ static int tas_i2c_probe(struct i2c_client *client)
 	/* seems that half is a saner default */
 	tas->drc_range = TAS3004_DRC_MAX / 2;
 
-	strscpy(tas->codec.name, "tas", MAX_CODEC_NAME_LEN);
+	strscpy(tas->codec.name, "tas");
 	tas->codec.owner = THIS_MODULE;
 	tas->codec.init = tas_init_codec;
 	tas->codec.exit = tas_exit_codec;
diff --git a/sound/aoa/codecs/toonie.c b/sound/aoa/codecs/toonie.c
index 0da5af129492..b59967c49e0a 100644
--- a/sound/aoa/codecs/toonie.c
+++ b/sound/aoa/codecs/toonie.c
@@ -126,7 +126,7 @@ static int __init toonie_init(void)
 	if (!toonie)
 		return -ENOMEM;
 
-	strscpy(toonie->codec.name, "toonie", sizeof(toonie->codec.name));
+	strscpy(toonie->codec.name, "toonie");
 	toonie->codec.owner = THIS_MODULE;
 	toonie->codec.init = toonie_init_codec;
 	toonie->codec.exit = toonie_exit_codec;
diff --git a/sound/aoa/core/alsa.c b/sound/aoa/core/alsa.c
index 7fce8581ddbd..aad7dfe089c7 100644
--- a/sound/aoa/core/alsa.c
+++ b/sound/aoa/core/alsa.c
@@ -28,10 +28,10 @@ int aoa_alsa_init(char *name, struct module *mod, struct device *dev)
 		return err;
 	aoa_card = alsa_card->private_data;
 	aoa_card->alsa_card = alsa_card;
-	strscpy(alsa_card->driver, "AppleOnbdAudio", sizeof(alsa_card->driver));
-	strscpy(alsa_card->shortname, name, sizeof(alsa_card->shortname));
-	strscpy(alsa_card->longname, name, sizeof(alsa_card->longname));
-	strscpy(alsa_card->mixername, name, sizeof(alsa_card->mixername));
+	strscpy(alsa_card->driver, "AppleOnbdAudio");
+	strscpy(alsa_card->shortname, name);
+	strscpy(alsa_card->longname, name);
+	strscpy(alsa_card->mixername, name);
 	err = snd_card_register(aoa_card->alsa_card);
 	if (err < 0) {
 		printk(KERN_ERR "snd-aoa: couldn't register alsa card\n");
diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index e68b4cb4df29..bb2a0ef3004b 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -949,8 +949,7 @@ static void layout_attached_codec(struct aoa_codec *codec)
 				ldev->gpio.methods->set_lineout(codec->gpio, 1);
 			ctl = snd_ctl_new1(&lineout_ctl, codec->gpio);
 			if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
-				strscpy(ctl->id.name,
-					"Headphone Switch", sizeof(ctl->id.name));
+				strscpy(ctl->id.name, "Headphone Switch");
 			ldev->lineout_ctrl = ctl;
 			aoa_snd_ctl_add(ctl);
 			ldev->have_lineout_detect =
@@ -964,15 +963,13 @@ static void layout_attached_codec(struct aoa_codec *codec)
 						   ldev);
 				if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 					strscpy(ctl->id.name,
-						"Headphone Detect Autoswitch",
-						sizeof(ctl->id.name));
+						"Headphone Detect Autoswitch");
 				aoa_snd_ctl_add(ctl);
 				ctl = snd_ctl_new1(&lineout_detected,
 						   ldev);
 				if (cc->connected & CC_LINEOUT_LABELLED_HEADPHONE)
 					strscpy(ctl->id.name,
-						"Headphone Detected",
-						sizeof(ctl->id.name));
+						"Headphone Detected");
 				ldev->lineout_detected_ctrl = ctl;
 				aoa_snd_ctl_add(ctl);
 			}
-- 
2.50.1


