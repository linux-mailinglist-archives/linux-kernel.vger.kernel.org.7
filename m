Return-Path: <linux-kernel+bounces-797702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 674F8B41428
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D531BA2533
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771DB2D6607;
	Wed,  3 Sep 2025 05:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRQLEDip"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905842D3756;
	Wed,  3 Sep 2025 05:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756876187; cv=none; b=mWNI/JVdfUH4+HNssH8zYPe2H1gKWg2ZOhjr+5PSeudeg2PsZ9uZ2KionvcvfERn0tZ6qrkFEnc1Z2Yo7B062vs9hBPA4qMNSvAqMhKaGpnOkuihIlh+NaMAtg4iHDFcX0mJ+fR8OlXzXAs97AA0jhrGv5CiNT9FM6NioLV40VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756876187; c=relaxed/simple;
	bh=ZjGf7KRdQMIWqObCWHGDvqYtXHaO3bEOfOsDJRMqxzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=st/fsYptpPlhZms6cNMxt8akNCvGkJB/9oe0fmde1M9gIk+CIcciaJN4/JViwAXVIKMFowXEApJ+VQ4pDA6yyRpjFWBvAqolQAEyK4ITgsphTG5km0/KPcir2/IsQ7LlQ+zW4U/oZnHlHnMaETj/cGduZN4HspYEVLXjbCEYcGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRQLEDip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F173C4CEF7;
	Wed,  3 Sep 2025 05:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756876187;
	bh=ZjGf7KRdQMIWqObCWHGDvqYtXHaO3bEOfOsDJRMqxzg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MRQLEDipl9uf/f0sZjmZ4rnEjxYM60JO47JkQXXRc9UykrBoX43cjuVk1HgO6m7rV
	 JuRGmembZ5uwNA8bZM+6Zv2GckU89nuY8vhatBe192enrTiWtJf1c7QMBSngA7VQnv
	 A9CX9VVSFHZ8rM2ocjNKfuLW7StDss/4VKN88V6+MXznNaXVVrPuEJqT2d4dAjt5wd
	 D+7xZGw9Dtnx20NVo/w0sIMsgBU/fg80aoaB/fFC3BepwAKF0MAGdsx9sEUgWe17M2
	 u+u8ggJI4TYC5R5g+JUbjGwNRMsVY4imvLfxNBeuuBZ1Nov45a4BkJyPJWY4YwuKYM
	 9TGcdEXoe3t2Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194D7CA0FF2;
	Wed,  3 Sep 2025 05:09:47 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Wed, 03 Sep 2025 13:09:45 +0800
Subject: [PATCH 1/4] ALSA: usb-audio: rename QUIRK_FLAG_MIXER_MIN_MUTE to
 QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-sound-v1-1-d4ca777b8512@uniontech.com>
References: <20250903-sound-v1-0-d4ca777b8512@uniontech.com>
In-Reply-To: <20250903-sound-v1-0-d4ca777b8512@uniontech.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>, 
 Feng Yuan <fengyuan@uniontech.com>, Celeste Liu <uwu@coelacanthus.name>, 
 qaqland <anguoli@uniontech.com>, linux-doc@vger.kernel.org, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756876185; l=6310;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=5X9enJVM8lgCdKEd8wCN4JgL4HiyGxy1lLZ9NGOnxNA=;
 b=RzN4zMhU8g6S2Zz6pu9d00t5feSyVsNC7BBiZKsAlX6Wq1Eu8HiUTSDYDCj5kUSk0oN69Z909
 qf1JnRkQGkRBlUG8Y1ArO3FiCKxiM3Kr+Zh2SKTear4Uc52O4LQlqYy
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

As a preparation of introduction QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE

Also make it printing an info while applying

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 sound/usb/mixer_quirks.c |  7 +++++--
 sound/usb/quirks.c       | 20 ++++++++++----------
 sound/usb/usbaudio.h     |  4 ++--
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index b8275c81802e60314ee483a31a0fcb7306b24c76..2a1abc24dbfc0c6b69d64529eda01bc25f1a6dd1 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -4543,9 +4543,12 @@ void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
 	}
 
 	/* lowest playback value is muted on some devices */
-	if (mixer->chip->quirk_flags & QUIRK_FLAG_MIXER_MIN_MUTE)
-		if (strstr(kctl->id.name, "Playback"))
+	if (mixer->chip->quirk_flags & QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE)
+		if (strstr(kctl->id.name, "Playback")) {
+			usb_audio_info(mixer->chip,
+				       "applying playback min mute quirk\n");
 			cval->min_mute = 1;
+		}
 
 	/* ALSA-ify some Plantronics headset control names */
 	if (USB_ID_VENDOR(mixer->chip->usb_id) == 0x047f &&
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 766db7d00cbc95984afa834200ebe3adfdf182ef..0fe31af3158f08a39849f8df99dbbfb10c5fdcc1 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2200,9 +2200,9 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x0556, 0x0014, /* Phoenix Audio TMX320VC */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0572, 0x1b08, /* Conexant Systems (Rockwell), Inc. */
-		   QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x0572, 0x1b09, /* Conexant Systems (Rockwell), Inc. */
-		   QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x05a3, 0x9420, /* ELP HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x05a7, 0x1020, /* Bose Companion 5 */
@@ -2246,15 +2246,15 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x0b0e, 0x0349, /* Jabra 550a */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0bda, 0x498a, /* Realtek Semiconductor Corp. */
-		   QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0c45, 0x636b, /* Microdia JP001 USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0d8c, 0x000c, /* C-Media */
-		   QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x0d8c, 0x0014, /* C-Media */
-		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
@@ -2264,7 +2264,7 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x1101, 0x0003, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x12d1, 0x3a07, /* Huawei Technologies Co., Ltd. */
-		   QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x1395, 0x740a, /* Sennheiser DECT */
@@ -2304,7 +2304,7 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x1901, 0x0191, /* GE B850V3 CP2114 audio interface */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x19f7, 0x0003, /* RODE NT-USB */
-		   QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x19f7, 0x0035, /* RODE NT-USB+ */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1bcf, 0x2281, /* HD Webcam */
@@ -2356,7 +2356,7 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x2a70, 0x1881, /* OnePlus Technology (Shenzhen) Co., Ltd. BE02T */
-		   QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x2b53, 0x0023, /* Fiero SC-01 (firmware v1.0.0 @ 48 kHz) */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x2b53, 0x0024, /* Fiero SC-01 (firmware v1.0.0 @ 96 kHz) */
@@ -2368,13 +2368,13 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x2d95, 0x8021, /* VIVO USB-C-XE710 HEADSET */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x2d99, 0x0026, /* HECATE G2 GAMING HEADSET */
-		   QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x2fc6, 0xf0b7, /* iBasso DC07 Pro */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x30be, 0x0101, /* Schiit Hel */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x339b, 0x3a07, /* Synaptics HONOR USB-C HEADSET */
-		   QUIRK_FLAG_MIXER_MIN_MUTE),
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x413c, 0xa506, /* Dell AE515 sound bar */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x534d, 0x0021, /* MacroSilicon MS2100/MS2106 */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 59335b94103004b900285e4990b971d74bf37532..707b3037b1b3a3d2997157154cf78d71455bfe4b 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -219,7 +219,7 @@ extern bool snd_usb_skip_validation;
  *  for the given endpoint.
  * QUIRK_FLAG_MIC_RES_16 and QUIRK_FLAG_MIC_RES_384
  *  Set the fixed resolution for Mic Capture Volume (mostly for webcams)
- * QUIRK_FLAG_MIXER_MIN_MUTE
+ * QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE
  *  Set minimum volume control value as mute for devices where the lowest
  *  playback value represents muted state instead of minimum audible volume
  */
@@ -248,6 +248,6 @@ extern bool snd_usb_skip_validation;
 #define QUIRK_FLAG_FIXED_RATE		(1U << 21)
 #define QUIRK_FLAG_MIC_RES_16		(1U << 22)
 #define QUIRK_FLAG_MIC_RES_384		(1U << 23)
-#define QUIRK_FLAG_MIXER_MIN_MUTE	(1U << 24)
+#define QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE	(1U << 24)
 
 #endif /* __USBAUDIO_H */

-- 
2.51.0



