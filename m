Return-Path: <linux-kernel+bounces-797701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A836B41425
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49523A2488
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FDA2D640A;
	Wed,  3 Sep 2025 05:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKsQO427"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905152D2382;
	Wed,  3 Sep 2025 05:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756876187; cv=none; b=LC2NpqSMYeNNZTZinNBDEePwyvaK8NB59Honnifw+5H5dNwQeSi4H0vwdedUYWt3tl/UpX8OrPK/OYL5i6U2baZTY58N+DdhaoDC1hnXr4ZgdUgmHXkEy+4gRQaB5j9qQ1faRKQy8511FUznrT3zBWJwwJKt2wZH5uLAd7htQ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756876187; c=relaxed/simple;
	bh=wfgQLINE+rLYXjlgnjlErA+lp8Av5ThpURzDubhNvEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LR/YUHkiHcL8RRMYVr24Mr10bGvG4bWwz/B9eo9tO4CdAQ5irgAZy4bXu7RL+4U9kXy3qvt3sIgkd9i/rl7j8GnJhgNIG5zpoiHOZ3YC9r/NMAX+d5uHGRuiYePpYgaPMbSUs7tarT2SrnDmlSzW06NBmVTC5KiUHgugU2wIGF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKsQO427; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AD29C4CEF1;
	Wed,  3 Sep 2025 05:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756876187;
	bh=wfgQLINE+rLYXjlgnjlErA+lp8Av5ThpURzDubhNvEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mKsQO427c1urE6y3eHGSlJ0BBPG4FSde/HsHiJJfuKiZ2sjzY0dNJ3vhy9P1gtkMS
	 g4Bt9xiWlGrjCAV7zgSezlcK/ZD//RZ2wIjIdOUb6ZI6XtvOhrRRhInbmWikW0bB4i
	 u33uaSpvepqJugvMUnkkgxqKDh4HepCjzi2uXDGYHf3VultkX9iK8tNA1Zbb81ccPy
	 LpB7JgIv4BpdJbvwyuumozLbUMf3VkC8c0dy8gmgYdUES5qwpHQPhDC4sp91tN76VX
	 VUgFTiL4MwI0A8lP8Y1iCkWs/lWgC1WoUg+YXaXvxcRlWZAE7XzRTAvBUDcqOYs5wT
	 sQ/R1jSXQrp9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A531CA1007;
	Wed,  3 Sep 2025 05:09:47 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Wed, 03 Sep 2025 13:09:46 +0800
Subject: [PATCH 2/4] ALSA: usb-audio: add quirk
 QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-sound-v1-2-d4ca777b8512@uniontech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756876185; l=2954;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=96cffDbepRmoALzdF1FSb7F0QqJtNTtbDzVfX1s6B4Y=;
 b=1xID+OM09wKkCbq4mYuoUra031C0SMSRp8IgO3DkOilYh3ENGuVTBAiaX+EO+Dw97X+ppHjUq
 YtTR8KYtbsjDh6ng8vs2NO1XUY5BZ4hp+w3cVLHqQIicPRqRd+MvXwc
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

The same hardware problem to QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE also
occurs on the capture streams on some USB devices. Add a new flag for
processing the quirk.

Link: https://lore.kernel.org/all/C22C1A172EBB9BD9+eccc2e4a-d21e-4a7d-848c-bbf3982feb94@uniontech.com/
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 Documentation/sound/alsa-configuration.rst | 1 +
 sound/usb/mixer_quirks.c                   | 7 +++++++
 sound/usb/usbaudio.h                       | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/sound/alsa-configuration.rst b/Documentation/sound/alsa-configuration.rst
index 062b86522e4d9cc7ec19e978e0efc934dae9ab1b..bf45df1558bbc361ca165abaf9c5d83bfe3188e2 100644
--- a/Documentation/sound/alsa-configuration.rst
+++ b/Documentation/sound/alsa-configuration.rst
@@ -2329,6 +2329,7 @@ quirk_flags
         * bit 24: Set minimum volume control value as mute for devices
           where the lowest playback value represents muted state instead
           of minimum audible volume
+        * bit 25: Be similar to bit 24 but for capture streams
 
 This module supports multiple devices, autoprobe and hotplugging.
 
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 2a1abc24dbfc0c6b69d64529eda01bc25f1a6dd1..828af3095b86ee0aa8f2d248d8e714b5d3ae20eb 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -4550,6 +4550,13 @@ void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
 			cval->min_mute = 1;
 		}
 
+	/* lowest capture value is muted on some devices */
+	if (mixer->chip->quirk_flags & QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE)
+		if (strstr(kctl->id.name, "Capture")) {
+			usb_audio_info(mixer->chip,
+				       "applying capture min mute quirk\n");
+			cval->min_mute = 1;
+		}
 	/* ALSA-ify some Plantronics headset control names */
 	if (USB_ID_VENDOR(mixer->chip->usb_id) == 0x047f &&
 	    (cval->control == UAC_FU_MUTE || cval->control == UAC_FU_VOLUME))
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 707b3037b1b3a3d2997157154cf78d71455bfe4b..30b5102e3caed01eeb86d0075c41338104c58950 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -222,6 +222,8 @@ extern bool snd_usb_skip_validation;
  * QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE
  *  Set minimum volume control value as mute for devices where the lowest
  *  playback value represents muted state instead of minimum audible volume
+ * QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE
+ *  Similar to QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE, but for capture streams
  */
 
 #define QUIRK_FLAG_GET_SAMPLE_RATE	(1U << 0)
@@ -249,5 +251,6 @@ extern bool snd_usb_skip_validation;
 #define QUIRK_FLAG_MIC_RES_16		(1U << 22)
 #define QUIRK_FLAG_MIC_RES_384		(1U << 23)
 #define QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE	(1U << 24)
+#define QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE	(1U << 25)
 
 #endif /* __USBAUDIO_H */

-- 
2.51.0



