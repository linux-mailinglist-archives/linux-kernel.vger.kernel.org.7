Return-Path: <linux-kernel+bounces-813297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF52BB5433D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282B11BC7D77
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBF62BD5B2;
	Fri, 12 Sep 2025 06:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2SRpwkP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822972874F2;
	Fri, 12 Sep 2025 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659751; cv=none; b=URIAh//OHLnSGbtsctbOJwHTM/75iLuoiDVna3S6NzMmX6Fv/orBmTUWs91mwjfWebYONJAdgf6r8I3JoCOznLzngdAKLwBunQQdUSv3gu8CZhPDP89Z68xIzRbzkDoX74vR1HIr3xaQLYERb4YDv70sZ+ZXctd5b1poybSVWxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659751; c=relaxed/simple;
	bh=AfD1lGXGhBJ72syghpA4tAQn0Om1/q15shkj744ZzgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EowA3t4n2+zZQGW1vJ/ljyOiIHmk6bpMhH0qe7yfinEUM729dPLI0XBygk6pwhBPekRwx/GCxRTwuBV/gs4/t6jjXJjPnYSSTLuNvJmq8gM87aCz3RkGBwaI5MqEZ40w9TyTABE6SuvlsztK2WbXOeO7lwX3CTeFr5NIDxiECvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2SRpwkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12153C4CEF7;
	Fri, 12 Sep 2025 06:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757659751;
	bh=AfD1lGXGhBJ72syghpA4tAQn0Om1/q15shkj744ZzgI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=j2SRpwkPWcUQ4gvQPoXrle8m2BOLrU/Dn9Umm9FZY80I+aB8KeVjSyOmhpwo+s9lf
	 KPTdXZ1xiWXrQigYeIMflEvl8cgDyC3vpZ4E6Fkk84bE1AfHoDIcgB1flVfbwuFDc4
	 +Al7tq7HdPYHqRl2vk3JOTknZ9cG4PhMvORIsZbttSlzqnbnYdjfb3c4B9zIdguR8b
	 +/+vvpbUSrxqTPHVyV6j7iC5qgtDHRn7nTNJT31oOHbustolRy0drsFLWHOmNB2tE/
	 2vn4wchPPOf+3htry11Erbo5ohDjtBSlufhQGqrQkQ6Ctix849buX7QmdkUPFonC/p
	 YKeEiN5vM1e6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CCCCA101F;
	Fri, 12 Sep 2025 06:49:11 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Fri, 12 Sep 2025 14:48:58 +0800
Subject: [PATCH v2 1/3] ALSA: usb-audio: add two-way convert between name
 and bit for QUIRK_FLAG_*
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-sound-v2-1-01ea3d279f4b@uniontech.com>
References: <20250912-sound-v2-0-01ea3d279f4b@uniontech.com>
In-Reply-To: <20250912-sound-v2-0-01ea3d279f4b@uniontech.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>, 
 Feng Yuan <fengyuan@uniontech.com>, qaqland <anguoli@uniontech.com>, 
 kernel@uniontech.com, Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757659749; l=4063;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=/BXquMWJMNiFdz+nh5s6GogPhAqR6jecE2iPTQLfG8w=;
 b=+sfLtT4u8nox/3hjkxd/5tp3ulZEsn8icd5sLuV50YzaSnwSLQFiixNhBdw2yzRdjeQhN4Udi
 EL3r0yhHFRLD4xa0q6nNqDHp2ITf6aMhuyqRR2Yjv+l1ICVaGEZaF8i
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

Also improve debug logs for applied quirks

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 sound/usb/quirks.c   | 82 +++++++++++++++++++++++++++++++++++++++++++++++++---
 sound/usb/quirks.h   |  3 ++
 sound/usb/usbaudio.h |  1 +
 3 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index d736a4750356597bfb0f9d5ab01cdaeaac0f907c..94854f352b1702b491e1bf3c8b769f7088e03976 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2446,6 +2446,62 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	{} /* terminator */
 };
 
+static const char *const snd_usb_audio_quirk_flag_names[] = {
+	"get_sample_rate",
+	"share_media_device",
+	"align_transfer",
+	"tx_length",
+	"playback_first",
+	"skip_clock_selector",
+	"ignore_clock_source",
+	"itf_usb_dsd_dac",
+	"ctl_msg_delay",
+	"ctl_msg_delay_1m",
+	"ctl_msg_delay_5m",
+	"iface_delay",
+	"validate_rates",
+	"disable_autosuspend",
+	"ignore_ctl_error",
+	"dsd_raw",
+	"set_iface_first",
+	"generic_implicit_fb",
+	"skip_implicit_fb",
+	"iface_skip_close",
+	"force_iface_reset",
+	"fixed_rate",
+	"mic_res_16",
+	"mic_res_384",
+	"mixer_playback_min_mute",
+	"mixer_capture_min_mute",
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
+u32 snd_usb_quirk_flags_from_name(char *name)
+{
+	u32 flag = 0;
+	u32 i;
+
+	if (!name || !*name)
+		return 0;
+
+	for (i = 0; snd_usb_audio_quirk_flag_names[i]; i++) {
+		if (strcmp(name, snd_usb_audio_quirk_flag_names[i]) == 0) {
+			flag = (1U << i);
+			break;
+		}
+	}
+
+	return flag;
+}
+
 void snd_usb_init_quirk_flags(struct snd_usb_audio *chip)
 {
 	const struct usb_audio_quirk_flags_table *p;
@@ -2454,10 +2510,28 @@ void snd_usb_init_quirk_flags(struct snd_usb_audio *chip)
 		if (chip->usb_id == p->id ||
 		    (!USB_ID_PRODUCT(p->id) &&
 		     USB_ID_VENDOR(chip->usb_id) == USB_ID_VENDOR(p->id))) {
-			usb_audio_dbg(chip,
-				      "Set quirk_flags 0x%x for device %04x:%04x\n",
-				      p->flags, USB_ID_VENDOR(chip->usb_id),
-				      USB_ID_PRODUCT(chip->usb_id));
+			unsigned long flags = p->flags;
+			unsigned long bit;
+
+			for_each_set_bit(bit, &flags,
+					 BYTES_TO_BITS(sizeof(p->flags))) {
+				const char *name =
+					snd_usb_audio_quirk_flag_names[bit];
+
+				if (name)
+					usb_audio_dbg(chip,
+						      "Set quirk flag %s for device %04x:%04x\n",
+						      name,
+						      USB_ID_VENDOR(chip->usb_id),
+						      USB_ID_PRODUCT(chip->usb_id));
+				else
+					usb_audio_warn(chip,
+						       "Set unknown quirk flag 0x%lx for device %04x:%04x\n",
+						       bit,
+						       USB_ID_VENDOR(chip->usb_id),
+						       USB_ID_PRODUCT(chip->usb_id));
+			}
+
 			chip->quirk_flags |= p->flags;
 			return;
 		}
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index f9bfd5ac7bab01717de3a76227482a128bf73165..bd5baf2b193a1985f3a0e52bf4a77ca741364769 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -50,4 +50,7 @@ void snd_usb_audioformat_attributes_quirk(struct snd_usb_audio *chip,
 
 void snd_usb_init_quirk_flags(struct snd_usb_audio *chip);
 
+const char *snd_usb_quirk_flag_find_name(unsigned long flag);
+u32 snd_usb_quirk_flags_from_name(char *name);
+
 #endif /* __USBAUDIO_QUIRKS_H */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 30b5102e3caed01eeb86d0075c41338104c58950..0a22cb4a02344b2dcf4009c560a759f2da25ca67 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -252,5 +252,6 @@ extern bool snd_usb_skip_validation;
 #define QUIRK_FLAG_MIC_RES_384		(1U << 23)
 #define QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE	(1U << 24)
 #define QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE	(1U << 25)
+/* Please also edit snd_usb_audio_quirk_flag_names */
 
 #endif /* __USBAUDIO_H */

-- 
2.51.0



