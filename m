Return-Path: <linux-kernel+bounces-787610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE7BB3788C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893723BD953
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8BB3090D1;
	Wed, 27 Aug 2025 03:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3MzqBYq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7F0304BDB;
	Wed, 27 Aug 2025 03:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756265344; cv=none; b=iwATy8jT5WyvsQ4IZSF3lUJUo8RNK3/7EkfJn95LVSm2918Gov4RxynkwYIldRCgO0FV+OQg7m1o2B9womo8XHyCJ5eQ8tPlx4iHj7o8PD9GFaq+G+W5DteKeq9BCcgM3RKzBpQsT0pxh5wUwR8NsmHOnUZ+4El0OrYOOwe2JOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756265344; c=relaxed/simple;
	bh=UOtn/EgV9OgwgFU9YlJ9O3EdVzi26FriVBDF0GKjUhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CMQD1VlMse76cNNZyL0mF+EiSmVAOsqd5ixXjUb1cqBIiJYBamAPiSxdDazHEbPA3f5ktpbSaButapyAcgNH6DCV1Dxooh7Ue/2zai5ngydJEO1hsDkJDMI8+NtVhkqBnfyv8Ej8qkuMG6J8Z8dYVniVaF2LrXel1YeFcTamnhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3MzqBYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10BCFC4CEEB;
	Wed, 27 Aug 2025 03:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756265344;
	bh=UOtn/EgV9OgwgFU9YlJ9O3EdVzi26FriVBDF0GKjUhk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=m3MzqBYqHAAts9rzbqDmknS5YiSt7jMgcM/VzOZZJtJk4SuAclpzGF/TPigwttYPD
	 6LxuIiEQPYoz1W5OwB2cPYjb9GwGcW/agGq/lWoaQcSTH5aq+L5MUSSkWklG5Hy88z
	 VoZXw7AtuJnymzxy6YHRQggFERnnTZxl77OEvfRW/yko7ixE0gaXiJW/DejkJYVxT3
	 cKOBvVgqbZ/rnlX4bb18ht9CSHPgwErCIGjzXCDvB55qSdUcSJySXjWVorGlGN228c
	 L2dzixzQh6iODGTDacxvhRZOxn4LFx/062o6rLXNI+eatyiT12OdyCqe6RzEL99LXZ
	 myd+Yi5xpmkxg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FAECA0EFF;
	Wed, 27 Aug 2025 03:29:03 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Wed, 27 Aug 2025 11:29:02 +0800
Subject: [PATCH] ALSA: usb-audio: move mixer_quirks' min_mute into common
 quirk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-sound-quirk-min-mute-v1-1-4717aa8a4f6a@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAH17rmgC/x3MTQ5AMBBA4avIrE1SQxtxFbHwM5iIolWRiLtrL
 L/Few94dsIequQBx5d42WxElibQz62dGGWIBlKkVUkG/RbsgEcQt+AqFtdwMpYZ5Zo61ZqugJj
 ujke5/23dvO8HPNLnZ2YAAAA=
X-Change-ID: 20250826-sound-quirk-min-mute-812352b0a6b4
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Wang Yuli <wangyuli@deepin.org>, Guan Wentao <guanwentao@uniontech.com>, 
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>, 
 Celeste Liu <CoelacanthusHex@gmail.com>, Guoli An <anguoli@uniontech.com>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756265342; l=5419;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=XM4ODXE91Bv/DpvME8axcOEDeEvWXinY6fXYQ3VvonM=;
 b=KKjy1xNjC7ijCwUpbdaYMUlrqS3ki5Xzkennqj6EpYPywDgVMiSOylGRim2B141goHfcZz5t+
 Cx1JMYYk/QdBnxMG9zXeHGcFDuTqr0LN4uvTJcqrn+10rhZqwfHlAzr
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

We have found more and more devices that have the same problem, that
the mixer's minimum value is muted. Accroding to pipewire's MR[1]
and Arch Linux wiki[2], this should be a very common problem in USB
audio devices. Move the quirk into common quirk,as a preparation of
more devices' quirk's patch coming on the road[3].

1. https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/2514
2. https://wiki.archlinux.org/index.php?title=PipeWire&oldid=804138#No_sound_from_USB_DAC_until_30%_volume
3. On the road, in the physical sense. We have been buying ton of
   these devices for testing the problem.

Tested-by: Guoli An <anguoli@uniontech.com>
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
I also would like to know if the quirk worth a kernel param.
---
 sound/usb/mixer_quirks.c | 10 +++-------
 sound/usb/quirks.c       | 12 ++++++++++--
 sound/usb/usbaudio.h     |  4 ++++
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 48e8c2014f0f27406ddca29f36e8b1d03be92f31..b8275c81802e60314ee483a31a0fcb7306b24c76 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -4540,16 +4540,12 @@ void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
 		if (unitid == 7 && cval->control == UAC_FU_VOLUME)
 			snd_dragonfly_quirk_db_scale(mixer, cval, kctl);
 		break;
+	}
+
 	/* lowest playback value is muted on some devices */
-	case USB_ID(0x0572, 0x1b09): /* Conexant Systems (Rockwell), Inc. */
-	case USB_ID(0x0d8c, 0x000c): /* C-Media */
-	case USB_ID(0x0d8c, 0x0014): /* C-Media */
-	case USB_ID(0x19f7, 0x0003): /* RODE NT-USB */
-	case USB_ID(0x2d99, 0x0026): /* HECATE G2 GAMING HEADSET */
+	if (mixer->chip->quirk_flags & QUIRK_FLAG_MIXER_MIN_MUTE)
 		if (strstr(kctl->id.name, "Playback"))
 			cval->min_mute = 1;
-		break;
-	}
 
 	/* ALSA-ify some Plantronics headset control names */
 	if (USB_ID_VENDOR(mixer->chip->usb_id) == 0x047f &&
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index e75b0b1df6eb2120b1446b7bd54f3ba50a79f567..8bc1e247cdf1af0a3e9c506830d8428a86c25595 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2199,6 +2199,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_SET_IFACE_FIRST),
 	DEVICE_FLG(0x0556, 0x0014, /* Phoenix Audio TMX320VC */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x0572, 0x1b09, /* Conexant Systems (Rockwell), Inc. */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x05a3, 0x9420, /* ELP HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x05a7, 0x1020, /* Bose Companion 5 */
@@ -2245,8 +2247,10 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0c45, 0x636b, /* Microdia JP001 USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
-	DEVICE_FLG(0x0d8c, 0x0014, /* USB Audio Device */
-		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x0d8c, 0x000c, /* C-Media */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
+	DEVICE_FLG(0x0d8c, 0x0014, /* C-Media */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
@@ -2293,6 +2297,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
 	DEVICE_FLG(0x1901, 0x0191, /* GE B850V3 CP2114 audio interface */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x19f7, 0x0003, /* RODE NT-USB */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x19f7, 0x0035, /* RODE NT-USB+ */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1bcf, 0x2281, /* HD Webcam */
@@ -2353,6 +2359,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x2d95, 0x8021, /* VIVO USB-C-XE710 HEADSET */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x2d99, 0x0026, /* HECATE G2 GAMING HEADSET */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x2fc6, 0xf0b7, /* iBasso DC07 Pro */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x30be, 0x0101, /* Schiit Hel */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 7521098ba391c04a83c2b6b6180c88c52ac6c5dc..59335b94103004b900285e4990b971d74bf37532 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -219,6 +219,9 @@ extern bool snd_usb_skip_validation;
  *  for the given endpoint.
  * QUIRK_FLAG_MIC_RES_16 and QUIRK_FLAG_MIC_RES_384
  *  Set the fixed resolution for Mic Capture Volume (mostly for webcams)
+ * QUIRK_FLAG_MIXER_MIN_MUTE
+ *  Set minimum volume control value as mute for devices where the lowest
+ *  playback value represents muted state instead of minimum audible volume
  */
 
 #define QUIRK_FLAG_GET_SAMPLE_RATE	(1U << 0)
@@ -245,5 +248,6 @@ extern bool snd_usb_skip_validation;
 #define QUIRK_FLAG_FIXED_RATE		(1U << 21)
 #define QUIRK_FLAG_MIC_RES_16		(1U << 22)
 #define QUIRK_FLAG_MIC_RES_384		(1U << 23)
+#define QUIRK_FLAG_MIXER_MIN_MUTE	(1U << 24)
 
 #endif /* __USBAUDIO_H */

---
base-commit: 7656e95cbd3ee0c67bbedf0a184eb307bb9aa65f
change-id: 20250826-sound-quirk-min-mute-812352b0a6b4

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



