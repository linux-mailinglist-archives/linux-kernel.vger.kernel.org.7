Return-Path: <linux-kernel+bounces-791128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242C9B3B24C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C63C5E6D51
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3B521859A;
	Fri, 29 Aug 2025 05:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbpRMY84"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B9B1E1DF2;
	Fri, 29 Aug 2025 05:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756444264; cv=none; b=PDuwzx/P2VXxCBZ0I0mUzKmffRzVZmtQugyqz6qCKzWkl1TdyP7z6sDUwIajBhSQFHNA+sOFoIuUO1/LDUQpxwXzoM8EECd3Ngieb0jBqXyXQe3Z3mu2pfFgCYRfPo1u4ezgW7LsF4FoLgu+xOKs8psN5TtIPKs1/bsHc4z+HmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756444264; c=relaxed/simple;
	bh=GRwLPBbaFTV6GFMn0tsScJTJKih42wsfR6S52yPN3Qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QUANy1iUIiOiU7NfzMWWDRNR0HFZKMu7CKpF8Dfmff2wB/iXESjzR2sir9wGkMDGPmjY49WzdFbJ6ua0GWGy8VU1XIlqYJr98M9e1k4RonnFWxyzmG1xCnVLyTJxiuSVb1u9gHXwRdKzz9EsSRio5KvQjTccbcPP38seMAWDQ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbpRMY84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 096EEC4CEF4;
	Fri, 29 Aug 2025 05:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756444264;
	bh=GRwLPBbaFTV6GFMn0tsScJTJKih42wsfR6S52yPN3Qs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fbpRMY84mjfg1bEi+7/5sgzEkiE/ZFyJlGiAwvlnEuVKdUGMbbcc4ivsjJhUd4QCl
	 a5wuRWAIV1gg3mrsTgiV2n7wRUOc6nEIl9lB8aZyXCYj4zF3AyoswozwzPbjL5YUHl
	 MBpCBaKPewSOGakhIvwFUsmv5CxJ4kgaWB2gCaT+3SYLUygQwpFdCQRigsn8JI6SOq
	 +nicyLa3w7HI90dPsvrewaco1Sp/cgg40hyBikBvQmZenwcX8S4rn2HM84LMM7Z/DT
	 xHD1x1A9ByoiutcUOwXFOKaT2nXN4g0rwv+rcTtSmaMD0B0OfJ6ThFGongbmVLL5YJ
	 uBd/hZ3B7PfZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB738C8303F;
	Fri, 29 Aug 2025 05:11:03 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Fri, 29 Aug 2025 13:10:59 +0800
Subject: [PATCH 1/2] ALSA: usb-audio: Add module param mixer_min_mute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-sound-param-v1-1-3c2f67cd7c97@uniontech.com>
References: <20250829-sound-param-v1-0-3c2f67cd7c97@uniontech.com>
In-Reply-To: <20250829-sound-param-v1-0-3c2f67cd7c97@uniontech.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Wang Yuli <wangyuli@deepin.org>, Guan Wentao <guanwentao@uniontech.com>, 
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>, 
 Celeste Liu <CoelacanthusHex@gmail.com>, Guoli An <anguoli@uniontech.com>, 
 linux-doc@vger.kernel.org, Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756444262; l=1950;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=+99QuTAVSYELP6NAKN8XeWv9qym77uQKo+/WgpeA+2g=;
 b=HnggGRou4PiMYDTU3AYipRu+GaNa/iVDrSJQhpBq+CYS0vzcYQIq78ibXM36rZyhm2bdKKlfz
 aRqIp2XWoxMCdotnsi9id0iyJ48QPRojXpF5ltHe0/IK5IIoJ4vdx3j
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

As already discussed[1], a module parameter called mixer_min_mute is
added to make it easier for end users to debug the widespread problem
without recompiling the kernel, where USB audio devices are muted when
the volume is set to the minimum value.

1.
https://lore.kernel.org/all/20250827-sound-quirk-min-mute-v1-1-4717aa8a4f6a@uniontech.com/

Tested-by: Guoli An <anguoli@uniontech.com>
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 sound/usb/card.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 0265206a8e8cf31133e8463c98fe0497d8ace89e..bf65727ad213f2897d735c1f3c55bfc3f85971cf 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -74,6 +74,7 @@ static char *quirk_alias[SNDRV_CARDS];
 static char *delayed_register[SNDRV_CARDS];
 static bool implicit_fb[SNDRV_CARDS];
 static unsigned int quirk_flags[SNDRV_CARDS];
+static bool mixer_min_mute;
 
 bool snd_usb_use_vmalloc = true;
 bool snd_usb_skip_validation;
@@ -109,6 +110,9 @@ module_param_named(use_vmalloc, snd_usb_use_vmalloc, bool, 0444);
 MODULE_PARM_DESC(use_vmalloc, "Use vmalloc for PCM intermediate buffers (default: yes).");
 module_param_named(skip_validation, snd_usb_skip_validation, bool, 0444);
 MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no).");
+module_param(mixer_min_mute, bool, 0444);
+MODULE_PARM_DESC(mixer_min_mute,
+		 "Set minimum volume control value as mute (default: no).");
 
 /*
  * we keep the snd_usb_audio_t instances by ourselves for merging
@@ -959,6 +963,9 @@ static int usb_audio_probe(struct usb_interface *intf,
 	if (ignore_ctl_error)
 		chip->quirk_flags |= QUIRK_FLAG_IGNORE_CTL_ERROR;
 
+	if (mixer_min_mute)
+		chip->quirk_flags |= QUIRK_FLAG_MIXER_MIN_MUTE;
+
 	if (chip->quirk_flags & QUIRK_FLAG_DISABLE_AUTOSUSPEND)
 		usb_disable_autosuspend(interface_to_usbdev(intf));
 

-- 
2.51.0



