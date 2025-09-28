Return-Path: <linux-kernel+bounces-835164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA04BA66D8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B7213BF80A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456BE24EAB1;
	Sun, 28 Sep 2025 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rU7gq+PQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C55119CC0A;
	Sun, 28 Sep 2025 03:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759028888; cv=none; b=SoZMMeP0u7dSNggKrYY4ZfhOvVY1UikiNP1PFB41IIDiLqlcCp+uU2EDLvfjwK8uU/TRLDpoL1MXAc1wk+eWJUABW5bfqCxCPKbFCLVECoI94+c2TK7kG0FLx0lKZCCyMFgB+cKzni28v/qwCu2quQ3l92Rjuk/nyWtKm2dOicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759028888; c=relaxed/simple;
	bh=baYmA+gJCAoPLZ0L+pOlxpEJ4IwojqUfdXTx5x4slO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fZ1b0QxhEOJCKibsBMaNLVHRUpCtjvaen97chu+3nfINkSvnIOyXSJKXTqILADHPaw8Y7oI+cEuYnHHCmYt0H2ijoxpo1ZCe09Z+653bdTp/CFrtMqd91tQAfTYAw1MOg6Uyh1zT8XscNXQSjgGEFcim5PIMgCRrzCj+AOoapQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rU7gq+PQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF263C116B1;
	Sun, 28 Sep 2025 03:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759028887;
	bh=baYmA+gJCAoPLZ0L+pOlxpEJ4IwojqUfdXTx5x4slO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rU7gq+PQ6lpXgwIyd+bnZHnB5+HpauhU+3uVN5KFYAkQDF14uk60s+wUaXsGnkHBk
	 adOK4LfJr/lDKIyNZPIthtBa16LW6+KtJzIDpj9Lz9y8zOMUKJbUYZj8GwAkZLun1s
	 ka65Kn1sIY5WL/sf04ssGLP/+G5ArXUaugM+NEGi2GSuNaXTRNCCyquP8WpRuqrqpB
	 izfW7JUeiovS410mknK8Mh4GLMfycC32glsBbADvwIsW0EBTGSegToxB8FFlDFxz+5
	 5NJXw53iE7RuPj4CgFQvguFgrHx16f1UHd/6tgVRX93hmy4bwyyyTG/oogAxoP+dyt
	 X8b+AEMlFSVyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95E9CAC5B8;
	Sun, 28 Sep 2025 03:08:07 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Sun, 28 Sep 2025 11:07:59 +0800
Subject: [PATCH v6 1/4] ALSA: usb-audio: add two-way convert between name
 and bit for QUIRK_FLAG_*
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250928-sound-v6-1-7da6e5982432@uniontech.com>
References: <20250928-sound-v6-0-7da6e5982432@uniontech.com>
In-Reply-To: <20250928-sound-v6-0-7da6e5982432@uniontech.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>, 
 Feng Yuan <fengyuan@uniontech.com>, qaqland <anguoli@uniontech.com>, 
 kernel@uniontech.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Cryolitia PukNgae <cryolitia@uniontech.com>, Takashi Iwai <tiwai@suse.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759028886; l=9102;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=K1p0F9jbShhOrIs/WgYau9/iU6zuv7n7ZsZXRiU6JEU=;
 b=f6Ilk3rSv2brapB938yN4qX75T2NeN+3+AlVeAVIIIek/5NhlmCM/IhEcUQWCssRYplMbuKmH
 2G77zi6XdlTC0Lp41zYzGEbb5qtXdhpQaLGVg03HGx+C5q9OriOom01
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

Define quirk flags enum and its name.

Add helper for converting between quirk flags' name and bit.
  - snd_usb_quirk_flag_find_name()
  - snd_usb_quirk_flags_from_name()

Add helper for printing debug: log snd_usb_apply_flag_dbg()

Co-developed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 sound/usb/quirks.c   | 83 ++++++++++++++++++++++++++++++++++++++++++++++++---
 sound/usb/quirks.h   |  7 +++++
 sound/usb/usbaudio.h | 84 ++++++++++++++++++++++++++++++++++++----------------
 3 files changed, 144 insertions(+), 30 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index d736a4750356597bfb0f9d5ab01cdaeaac0f907c..def1573f65df91ae26a988a45a10267ffba18739 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2446,6 +2446,84 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	{} /* terminator */
 };
 
+#define QUIRK_STRING_ENTRY(x) \
+	[QUIRK_TYPE_ ## x] = __stringify(x)
+
+static const char *const snd_usb_audio_quirk_flag_names[] = {
+	QUIRK_STRING_ENTRY(GET_SAMPLE_RATE),
+	QUIRK_STRING_ENTRY(SHARE_MEDIA_DEVICE),
+	QUIRK_STRING_ENTRY(ALIGN_TRANSFER),
+	QUIRK_STRING_ENTRY(TX_LENGTH),
+	QUIRK_STRING_ENTRY(PLAYBACK_FIRST),
+	QUIRK_STRING_ENTRY(SKIP_CLOCK_SELECTOR),
+	QUIRK_STRING_ENTRY(IGNORE_CLOCK_SOURCE),
+	QUIRK_STRING_ENTRY(ITF_USB_DSD_DAC),
+	QUIRK_STRING_ENTRY(CTL_MSG_DELAY),
+	QUIRK_STRING_ENTRY(CTL_MSG_DELAY_1M),
+	QUIRK_STRING_ENTRY(CTL_MSG_DELAY_5M),
+	QUIRK_STRING_ENTRY(IFACE_DELAY),
+	QUIRK_STRING_ENTRY(VALIDATE_RATES),
+	QUIRK_STRING_ENTRY(DISABLE_AUTOSUSPEND),
+	QUIRK_STRING_ENTRY(IGNORE_CTL_ERROR),
+	QUIRK_STRING_ENTRY(DSD_RAW),
+	QUIRK_STRING_ENTRY(SET_IFACE_FIRST),
+	QUIRK_STRING_ENTRY(GENERIC_IMPLICIT_FB),
+	QUIRK_STRING_ENTRY(SKIP_IMPLICIT_FB),
+	QUIRK_STRING_ENTRY(IFACE_SKIP_CLOSE),
+	QUIRK_STRING_ENTRY(FORCE_IFACE_RESET),
+	QUIRK_STRING_ENTRY(FIXED_RATE),
+	QUIRK_STRING_ENTRY(MIC_RES_16),
+	QUIRK_STRING_ENTRY(MIC_RES_384),
+	QUIRK_STRING_ENTRY(MIXER_PLAYBACK_MIN_MUTE),
+	QUIRK_STRING_ENTRY(MIXER_CAPTURE_MIN_MUTE),
+	NULL
+};
+
+const char *snd_usb_quirk_flag_find_name(unsigned long index)
+{
+	if (index >= ARRAY_SIZE(snd_usb_audio_quirk_flag_names))
+		return NULL;
+
+	return snd_usb_audio_quirk_flag_names[index];
+}
+
+u32 snd_usb_quirk_flags_from_name(const char *name)
+{
+	int i;
+
+	if (!name || !*name)
+		return 0;
+
+	for (i = 0; snd_usb_audio_quirk_flag_names[i]; i++) {
+		if (strcasecmp(name, snd_usb_audio_quirk_flag_names[i]) == 0)
+			return BIT_U32(i);
+	}
+
+	return 0;
+}
+
+void snd_usb_apply_flag_dbg(const char *reason,
+			    struct snd_usb_audio *chip,
+			    unsigned long flag)
+{
+	unsigned long bit;
+
+	for_each_set_bit(bit, &flag, BYTES_TO_BITS(sizeof(flag))) {
+		const char *name = snd_usb_audio_quirk_flag_names[bit];
+
+		if (name)
+			usb_audio_dbg(chip,
+				      "From %s apply quirk flag %s for device %04x:%04x\n",
+				      reason, name, USB_ID_VENDOR(chip->usb_id),
+				      USB_ID_PRODUCT(chip->usb_id));
+		else
+			usb_audio_warn(chip,
+				       "From %s apply unknown quirk flag 0x%lx for device %04x:%04x\n",
+				       reason, bit, USB_ID_VENDOR(chip->usb_id),
+				       USB_ID_PRODUCT(chip->usb_id));
+	}
+}
+
 void snd_usb_init_quirk_flags(struct snd_usb_audio *chip)
 {
 	const struct usb_audio_quirk_flags_table *p;
@@ -2454,10 +2532,7 @@ void snd_usb_init_quirk_flags(struct snd_usb_audio *chip)
 		if (chip->usb_id == p->id ||
 		    (!USB_ID_PRODUCT(p->id) &&
 		     USB_ID_VENDOR(chip->usb_id) == USB_ID_VENDOR(p->id))) {
-			usb_audio_dbg(chip,
-				      "Set quirk_flags 0x%x for device %04x:%04x\n",
-				      p->flags, USB_ID_VENDOR(chip->usb_id),
-				      USB_ID_PRODUCT(chip->usb_id));
+			snd_usb_apply_flag_dbg("builtin table", chip, p->flags);
 			chip->quirk_flags |= p->flags;
 			return;
 		}
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index f9bfd5ac7bab01717de3a76227482a128bf73165..1b727d3c35c7033b85b56ce43d66fd76c8f2d4ef 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -48,6 +48,13 @@ void snd_usb_audioformat_attributes_quirk(struct snd_usb_audio *chip,
 					  struct audioformat *fp,
 					  int stream);
 
+void snd_usb_apply_flag_dbg(const char *reason,
+			    struct snd_usb_audio *chip,
+			    unsigned long flag);
+
 void snd_usb_init_quirk_flags(struct snd_usb_audio *chip);
 
+const char *snd_usb_quirk_flag_find_name(unsigned long flag);
+u32 snd_usb_quirk_flags_from_name(const char *name);
+
 #endif /* __USBAUDIO_QUIRKS_H */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 30b5102e3caed01eeb86d0075c41338104c58950..79978cae9799cd14da2c7d2391df104df40fa672 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -226,31 +226,63 @@ extern bool snd_usb_skip_validation;
  *  Similar to QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE, but for capture streams
  */
 
-#define QUIRK_FLAG_GET_SAMPLE_RATE	(1U << 0)
-#define QUIRK_FLAG_SHARE_MEDIA_DEVICE	(1U << 1)
-#define QUIRK_FLAG_ALIGN_TRANSFER	(1U << 2)
-#define QUIRK_FLAG_TX_LENGTH		(1U << 3)
-#define QUIRK_FLAG_PLAYBACK_FIRST	(1U << 4)
-#define QUIRK_FLAG_SKIP_CLOCK_SELECTOR	(1U << 5)
-#define QUIRK_FLAG_IGNORE_CLOCK_SOURCE	(1U << 6)
-#define QUIRK_FLAG_ITF_USB_DSD_DAC	(1U << 7)
-#define QUIRK_FLAG_CTL_MSG_DELAY	(1U << 8)
-#define QUIRK_FLAG_CTL_MSG_DELAY_1M	(1U << 9)
-#define QUIRK_FLAG_CTL_MSG_DELAY_5M	(1U << 10)
-#define QUIRK_FLAG_IFACE_DELAY		(1U << 11)
-#define QUIRK_FLAG_VALIDATE_RATES	(1U << 12)
-#define QUIRK_FLAG_DISABLE_AUTOSUSPEND	(1U << 13)
-#define QUIRK_FLAG_IGNORE_CTL_ERROR	(1U << 14)
-#define QUIRK_FLAG_DSD_RAW		(1U << 15)
-#define QUIRK_FLAG_SET_IFACE_FIRST	(1U << 16)
-#define QUIRK_FLAG_GENERIC_IMPLICIT_FB	(1U << 17)
-#define QUIRK_FLAG_SKIP_IMPLICIT_FB	(1U << 18)
-#define QUIRK_FLAG_IFACE_SKIP_CLOSE	(1U << 19)
-#define QUIRK_FLAG_FORCE_IFACE_RESET	(1U << 20)
-#define QUIRK_FLAG_FIXED_RATE		(1U << 21)
-#define QUIRK_FLAG_MIC_RES_16		(1U << 22)
-#define QUIRK_FLAG_MIC_RES_384		(1U << 23)
-#define QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE	(1U << 24)
-#define QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE	(1U << 25)
+enum {
+	QUIRK_TYPE_GET_SAMPLE_RATE		= 0,
+	QUIRK_TYPE_SHARE_MEDIA_DEVICE		= 1,
+	QUIRK_TYPE_ALIGN_TRANSFER		= 2,
+	QUIRK_TYPE_TX_LENGTH			= 3,
+	QUIRK_TYPE_PLAYBACK_FIRST		= 4,
+	QUIRK_TYPE_SKIP_CLOCK_SELECTOR		= 5,
+	QUIRK_TYPE_IGNORE_CLOCK_SOURCE		= 6,
+	QUIRK_TYPE_ITF_USB_DSD_DAC		= 7,
+	QUIRK_TYPE_CTL_MSG_DELAY		= 8,
+	QUIRK_TYPE_CTL_MSG_DELAY_1M		= 9,
+	QUIRK_TYPE_CTL_MSG_DELAY_5M		= 10,
+	QUIRK_TYPE_IFACE_DELAY			= 11,
+	QUIRK_TYPE_VALIDATE_RATES		= 12,
+	QUIRK_TYPE_DISABLE_AUTOSUSPEND		= 13,
+	QUIRK_TYPE_IGNORE_CTL_ERROR		= 14,
+	QUIRK_TYPE_DSD_RAW			= 15,
+	QUIRK_TYPE_SET_IFACE_FIRST		= 16,
+	QUIRK_TYPE_GENERIC_IMPLICIT_FB		= 17,
+	QUIRK_TYPE_SKIP_IMPLICIT_FB		= 18,
+	QUIRK_TYPE_IFACE_SKIP_CLOSE		= 19,
+	QUIRK_TYPE_FORCE_IFACE_RESET		= 20,
+	QUIRK_TYPE_FIXED_RATE			= 21,
+	QUIRK_TYPE_MIC_RES_16			= 22,
+	QUIRK_TYPE_MIC_RES_384			= 23,
+	QUIRK_TYPE_MIXER_PLAYBACK_MIN_MUTE	= 24,
+	QUIRK_TYPE_MIXER_CAPTURE_MIN_MUTE	= 25,
+/* Please also edit snd_usb_audio_quirk_flag_names */
+};
+
+#define QUIRK_FLAG(x)	BIT_U32(QUIRK_TYPE_ ## x)
+
+#define QUIRK_FLAG_GET_SAMPLE_RATE		QUIRK_FLAG(GET_SAMPLE_RATE)
+#define QUIRK_FLAG_SHARE_MEDIA_DEVICE		QUIRK_FLAG(SHARE_MEDIA_DEVICE)
+#define QUIRK_FLAG_ALIGN_TRANSFER		QUIRK_FLAG(ALIGN_TRANSFER)
+#define QUIRK_FLAG_TX_LENGTH			QUIRK_FLAG(TX_LENGTH)
+#define QUIRK_FLAG_PLAYBACK_FIRST		QUIRK_FLAG(PLAYBACK_FIRST)
+#define QUIRK_FLAG_SKIP_CLOCK_SELECTOR		QUIRK_FLAG(SKIP_CLOCK_SELECTOR)
+#define QUIRK_FLAG_IGNORE_CLOCK_SOURCE		QUIRK_FLAG(IGNORE_CLOCK_SOURCE)
+#define QUIRK_FLAG_ITF_USB_DSD_DAC		QUIRK_FLAG(ITF_USB_DSD_DAC)
+#define QUIRK_FLAG_CTL_MSG_DELAY		QUIRK_FLAG(CTL_MSG_DELAY)
+#define QUIRK_FLAG_CTL_MSG_DELAY_1M		QUIRK_FLAG(CTL_MSG_DELAY_1M)
+#define QUIRK_FLAG_CTL_MSG_DELAY_5M		QUIRK_FLAG(CTL_MSG_DELAY_5M)
+#define QUIRK_FLAG_IFACE_DELAY			QUIRK_FLAG(IFACE_DELAY)
+#define QUIRK_FLAG_VALIDATE_RATES		QUIRK_FLAG(VALIDATE_RATES)
+#define QUIRK_FLAG_DISABLE_AUTOSUSPEND		QUIRK_FLAG(DISABLE_AUTOSUSPEND)
+#define QUIRK_FLAG_IGNORE_CTL_ERROR		QUIRK_FLAG(IGNORE_CTL_ERROR)
+#define QUIRK_FLAG_DSD_RAW			QUIRK_FLAG(DSD_RAW)
+#define QUIRK_FLAG_SET_IFACE_FIRST		QUIRK_FLAG(SET_IFACE_FIRST)
+#define QUIRK_FLAG_GENERIC_IMPLICIT_FB		QUIRK_FLAG(GENERIC_IMPLICIT_FB)
+#define QUIRK_FLAG_SKIP_IMPLICIT_FB		QUIRK_FLAG(SKIP_IMPLICIT_FB)
+#define QUIRK_FLAG_IFACE_SKIP_CLOSE		QUIRK_FLAG(IFACE_SKIP_CLOSE)
+#define QUIRK_FLAG_FORCE_IFACE_RESET		QUIRK_FLAG(FORCE_IFACE_RESET)
+#define QUIRK_FLAG_FIXED_RATE			QUIRK_FLAG(FIXED_RATE)
+#define QUIRK_FLAG_MIC_RES_16			QUIRK_FLAG(MIC_RES_16)
+#define QUIRK_FLAG_MIC_RES_384			QUIRK_FLAG(MIC_RES_384)
+#define QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE	QUIRK_FLAG(MIXER_PLAYBACK_MIN_MUTE)
+#define QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE	QUIRK_FLAG(MIXER_CAPTURE_MIN_MUTE)
 
 #endif /* __USBAUDIO_H */

-- 
2.51.0



