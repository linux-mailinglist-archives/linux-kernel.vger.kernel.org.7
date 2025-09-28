Return-Path: <linux-kernel+bounces-835165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4382CBA66D2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D7F3BF75D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F6824E4C3;
	Sun, 28 Sep 2025 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmpI+P9O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A81F1302;
	Sun, 28 Sep 2025 03:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759028888; cv=none; b=TQKOoWB4yZ0Ytap9l69SwzpOzYQfo+z7DrVJdyjf5NrpGQUI8cRk1wcbJOGG1MtYlzoB3XyGn4/8vTnx9R5WMEUSmjv2dMvz4inN4nHT9JATYSKFi9QyIlHDZv19asmUYzxUtrnKm7BOMycTc/EeJkfvm6JPUZeHkOM7/l6qwG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759028888; c=relaxed/simple;
	bh=+16o0l7dnjQiZi0yMDNGvQVrpUUpveogkGeX05FQ4r8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WW7Z9zPb67Iw2ZJWTCtcxXhx5mVFNfxp8ifYEuLEw5EyKcRhVi0DFggBfpXhiOjXppuunoMy1BBEhZJQuPsdO1xIYjJvfXcOvhwxraDQ+EFivZ2Alw8w6JDCTpx5HTEUI5RZ42vvoRR71e0MFXccPMNWxYg9BnzvqlPnghYH0DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmpI+P9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D86EAC113D0;
	Sun, 28 Sep 2025 03:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759028887;
	bh=+16o0l7dnjQiZi0yMDNGvQVrpUUpveogkGeX05FQ4r8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KmpI+P9OHCYia80la05AskJDYn2g3G/iAGpzBMQuvu2t6jFYK0FK4yrxz5201aMZf
	 3c4kGptCE433rLFMvMZUiPmVFQqQvr1wxb/ntRaEdC/Ua/K5IHqFkq5gXTb1fOpt/S
	 ozKbmmcbJ0GL/IMLv6E9PDLR0fIhQzFbgPFpyxPmiYPGIOyAkxRLLegV7FeYY5VLUX
	 mtXpIGMwdz6C+sEkORjH3GG6KN6mGmO3TWaGFRkBSzuI/HXrO8GfRbJCZzF0oR3RHm
	 CBS2Kx+dTpvPNvNdGWmMC3pqDFGF2iVszXe3Y3oGvYX4OjQaaqEj3wCKcLVn8nMaXK
	 VqkiLzK2zDNeQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BBDCAC5BC;
	Sun, 28 Sep 2025 03:08:07 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Sun, 28 Sep 2025 11:08:00 +0800
Subject: [PATCH v6 2/4] ALSA: usb-audio: improve module param quirk_flags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250928-sound-v6-2-7da6e5982432@uniontech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759028886; l=6014;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=6cs94liQClaGAIzwtJgxPeNFLVMt00l3vEH6r+gRVa8=;
 b=exYXdhzlMgCLjiXGLRair8weI8gWAJn4PNfor/TvZUFgyA1uAXmRfmX58ACtxyTQfPlq1i5uE
 +NGWzvEI5+8DjXluF/jGSSTeKpOS52/h4JW7wko71V+4+zAMxSTz/AU
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

It accepts strings like `VID:PID:quirk_flag_name1|quirk_flag_name2;...`
from now on, so that we can use it to debug USB audio devices more
intuitive and flexible. The compatibility of previous form is kept.

Co-developed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 sound/usb/card.c   | 32 +++++++++++++++----
 sound/usb/quirks.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 sound/usb/quirks.h |  4 ++-
 3 files changed, 118 insertions(+), 8 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 0265206a8e8cf31133e8463c98fe0497d8ace89e..66c6c92fa9e8d2d04cc297a3dc8de9c8a2e99465 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -73,7 +73,7 @@ static bool lowlatency = true;
 static char *quirk_alias[SNDRV_CARDS];
 static char *delayed_register[SNDRV_CARDS];
 static bool implicit_fb[SNDRV_CARDS];
-static unsigned int quirk_flags[SNDRV_CARDS];
+static char *quirk_flags[SNDRV_CARDS];
 
 bool snd_usb_use_vmalloc = true;
 bool snd_usb_skip_validation;
@@ -103,7 +103,7 @@ module_param_array(delayed_register, charp, NULL, 0444);
 MODULE_PARM_DESC(delayed_register, "Quirk for delayed registration, given by id:iface, e.g. 0123abcd:4.");
 module_param_array(implicit_fb, bool, NULL, 0444);
 MODULE_PARM_DESC(implicit_fb, "Apply generic implicit feedback sync mode.");
-module_param_array(quirk_flags, uint, NULL, 0444);
+module_param_array(quirk_flags, charp, NULL, 0444);
 MODULE_PARM_DESC(quirk_flags, "Driver quirk bit flags.");
 module_param_named(use_vmalloc, snd_usb_use_vmalloc, bool, 0444);
 MODULE_PARM_DESC(use_vmalloc, "Use vmalloc for PCM intermediate buffers (default: yes).");
@@ -692,6 +692,29 @@ static void usb_audio_make_longname(struct usb_device *dev,
 	}
 }
 
+static void snd_usb_init_quirk_flags(int idx, struct snd_usb_audio *chip)
+{
+	size_t i;
+
+	/* old style option found: the position-based integer value */
+	if (quirk_flags[idx] &&
+	    !kstrtou32(quirk_flags[idx], 0, &chip->quirk_flags)) {
+		snd_usb_apply_flag_dbg("module param", chip, chip->quirk_flags);
+		return;
+	}
+
+	/* take the default quirk from the quirk table */
+	snd_usb_init_quirk_flags_table(chip);
+
+	/* add or correct quirk bits from options */
+	for (i = 0; i < ARRAY_SIZE(quirk_flags); i++) {
+		if (!quirk_flags[i] || !*quirk_flags[i])
+			break;
+
+		snd_usb_init_quirk_flags_parse_string(chip, quirk_flags[i]);
+	}
+}
+
 /*
  * create a chip instance and set its names.
  */
@@ -750,10 +773,7 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 	INIT_LIST_HEAD(&chip->midi_v2_list);
 	INIT_LIST_HEAD(&chip->mixer_list);
 
-	if (quirk_flags[idx])
-		chip->quirk_flags = quirk_flags[idx];
-	else
-		snd_usb_init_quirk_flags(chip);
+	snd_usb_init_quirk_flags(idx, chip);
 
 	card->private_free = snd_usb_audio_free;
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index def1573f65df91ae26a988a45a10267ffba18739..e7ba25f3df9ec2837744ca6d6fa33791e7893842 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2524,7 +2524,7 @@ void snd_usb_apply_flag_dbg(const char *reason,
 	}
 }
 
-void snd_usb_init_quirk_flags(struct snd_usb_audio *chip)
+void snd_usb_init_quirk_flags_table(struct snd_usb_audio *chip)
 {
 	const struct usb_audio_quirk_flags_table *p;
 
@@ -2538,3 +2538,91 @@ void snd_usb_init_quirk_flags(struct snd_usb_audio *chip)
 		}
 	}
 }
+
+void snd_usb_init_quirk_flags_parse_string(struct snd_usb_audio *chip,
+					   const char *str)
+{
+	u16 chip_vid = USB_ID_VENDOR(chip->usb_id);
+	u16 chip_pid = USB_ID_PRODUCT(chip->usb_id);
+	u32 mask_flags, unmask_flags, bit;
+	char *p, *field, *flag;
+	bool is_unmask;
+	u16 vid, pid;
+
+	char *val __free(kfree) = kstrdup(str, GFP_KERNEL);
+
+	if (!val)
+		return;
+
+	for (p = val; p && *p;) {
+		/* Each entry consists of VID:PID:flags */
+		field = strsep(&p, ":");
+		if (!field)
+			break;
+
+		if (strcmp(field, "*") == 0)
+			vid = 0;
+		else if (kstrtou16(field, 16, &vid))
+			break;
+
+		field = strsep(&p, ":");
+		if (!field)
+			break;
+
+		if (strcmp(field, "*") == 0)
+			pid = 0;
+		else if (kstrtou16(field, 16, &pid))
+			break;
+
+		field = strsep(&p, ";");
+		if (!field || !*field)
+			break;
+
+		if ((vid != 0 && vid != chip_vid) ||
+		    (pid != 0 && pid != chip_pid))
+			continue;
+
+		/* Collect the flags */
+		mask_flags = 0;
+		unmask_flags = 0;
+		while (field && *field) {
+			flag = strsep(&field, "|");
+
+			if (!flag)
+				break;
+
+			if (*flag == '!') {
+				is_unmask = true;
+				flag++;
+			} else {
+				is_unmask = false;
+			}
+
+			if (!kstrtou32(flag, 16, &bit)) {
+				if (is_unmask)
+					unmask_flags |= bit;
+				else
+					mask_flags |= bit;
+
+				break;
+			}
+
+			bit = snd_usb_quirk_flags_from_name(flag);
+
+			if (bit) {
+				if (is_unmask)
+					unmask_flags |= bit;
+				else
+					mask_flags |= bit;
+			} else {
+				pr_warn("snd_usb_audio: unknown flag %s while parsing param quirk_flags\n",
+					flag);
+			}
+		}
+
+		chip->quirk_flags &= ~unmask_flags;
+		chip->quirk_flags |= mask_flags;
+		snd_usb_apply_flag_dbg("module param", chip,
+				       chip->quirk_flags);
+	}
+}
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index 1b727d3c35c7033b85b56ce43d66fd76c8f2d4ef..f24d6a5a197a641dac36eb3c6eca5dbf5076b495 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -52,7 +52,9 @@ void snd_usb_apply_flag_dbg(const char *reason,
 			    struct snd_usb_audio *chip,
 			    unsigned long flag);
 
-void snd_usb_init_quirk_flags(struct snd_usb_audio *chip);
+void snd_usb_init_quirk_flags_table(struct snd_usb_audio *chip);
+void snd_usb_init_quirk_flags_parse_string(struct snd_usb_audio *chip,
+					   const char *str);
 
 const char *snd_usb_quirk_flag_find_name(unsigned long flag);
 u32 snd_usb_quirk_flags_from_name(const char *name);

-- 
2.51.0



