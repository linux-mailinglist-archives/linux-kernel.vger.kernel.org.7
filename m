Return-Path: <linux-kernel+bounces-832088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C33B9E4F5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBCB07A94D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFBD2EAB64;
	Thu, 25 Sep 2025 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFCMIvtB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A4B2E9ED6;
	Thu, 25 Sep 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792320; cv=none; b=oFkcHOKXDwBIkXQhALsvXd/dqB4XMJWEyhIZjbpUnJ7DR+U7DXx7HVZTdlvZ2Vwu9bbXbJYj9Up8Cx4efFC5/WO63h6swUBe3F3JdW8UuJ+cEML5ChJKAwHe5maaMRc/apU+YWkL9e2iW3k8rn2b9Yr1sPBda2JM7Cz8xghtlrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792320; c=relaxed/simple;
	bh=a5BLZ0yQuNQMFP8AbETRPuf0kS6Cb4iH1M97iZL0BRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M/fbBAInxn0GYQqf5ddnLyLwYDYGpmphxp3u51FNFJ/6MAvnPKHQp1XtQgzQtYZ4m2GSqQ2/L8LYh86EzIWYEltUKGXcukTz34ozsNhqPkva+MBMq8qrEzeWxjo0hd7Fh2lA/UIz3ANWn0Ymdpx+kbE9wPsaqE7bC/254oWKfgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFCMIvtB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32B03C4CEF7;
	Thu, 25 Sep 2025 09:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758792320;
	bh=a5BLZ0yQuNQMFP8AbETRPuf0kS6Cb4iH1M97iZL0BRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KFCMIvtBgYyl2wyByMjPI8OviHmceMDL+uFD1B/folIIutdM7SLBszvJIcR/MV0GA
	 d6cx51jEjAuUMn6xfWCPj1P/End2y78GVyx0QpadPLeNHO8Jr9ezkz1jaFkKrcGfet
	 x7XEvqIR1mwvlm/cZeXfiZgpP+YalbJylXCTeRb+IN/+oAv9IB3XPF6Fo7I4itmHL6
	 KwHuBpgxv+NyHEojQcpMqu2dKsPzcvHiy7haeMHDU2TSlmR2uLyuwKlJHO2f8CAK1n
	 fhZmAV9AlQzpaqroJykjdxGsXKuNyfGhCZl39wFNNyupupytFTQzq0O9wQzyGSjVAW
	 jtmsBhjrdmhJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295F0CAC5B7;
	Thu, 25 Sep 2025 09:25:20 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Thu, 25 Sep 2025 17:25:17 +0800
Subject: [PATCH v5 2/4] ALSA: usb-audio: improve module param quirk_flags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-sound-v5-2-2593586ff350@uniontech.com>
References: <20250925-sound-v5-0-2593586ff350@uniontech.com>
In-Reply-To: <20250925-sound-v5-0-2593586ff350@uniontech.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>, 
 Feng Yuan <fengyuan@uniontech.com>, qaqland <anguoli@uniontech.com>, 
 kernel@uniontech.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Cryolitia PukNgae <cryolitia@uniontech.com>, Takashi Iwai <tiwai@suse.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758792317; l=6031;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=DeHH/RKF3WlR+hMKB5Jt/o4nGz4FXa6E8YUcn0eQOOg=;
 b=QrcX3hQPeC0w3XcG+K2GN7bWGcs2cUevDohxpk5XdMGdvwAq7V+nTrhe5FFgfEA8x8nDNnI32
 6QADG8geEbID3Kyprjb30pltphkOG2loGG/Vtw+uq4EPvwrnxFSDHcV
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

For apply and unapply quirk flags more flexibly though param

Co-developed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 sound/usb/card.c   | 44 ++++++++++++++++++++++++----
 sound/usb/quirks.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 sound/usb/quirks.h |  4 ++-
 3 files changed, 124 insertions(+), 8 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 0265206a8e8cf31133e8463c98fe0497d8ace89e..68d8324fef3747c48d01088e7d1deb61e870db5c 100644
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
@@ -692,6 +692,41 @@ static void usb_audio_make_longname(struct usb_device *dev,
 	}
 }
 
+static void snd_usb_init_quirk_flags(int idx, struct snd_usb_audio *chip)
+{
+	char *val;
+	size_t i;
+
+	/* old style option found: the position-based integer value */
+	if (quirk_flags[idx] &&
+	    !kstrtou32(quirk_flags[idx], 0, &chip->quirk_flags)) {
+		usb_audio_dbg(chip,
+			      "Set quirk flags 0x%x from param based on position %d for device %04x:%04x\n",
+			      chip->quirk_flags, idx,
+			      USB_ID_VENDOR(chip->usb_id),
+			      USB_ID_PRODUCT(chip->usb_id));
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
+		val = kstrdup(quirk_flags[i], GFP_KERNEL);
+
+		if (!val)
+			return;
+
+		snd_usb_init_quirk_flags_parse_string(chip, val);
+
+		kfree(val);
+	}
+}
+
 /*
  * create a chip instance and set its names.
  */
@@ -750,10 +785,7 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 	INIT_LIST_HEAD(&chip->midi_v2_list);
 	INIT_LIST_HEAD(&chip->mixer_list);
 
-	if (quirk_flags[idx])
-		chip->quirk_flags = quirk_flags[idx];
-	else
-		snd_usb_init_quirk_flags(chip);
+	snd_usb_init_quirk_flags(idx, chip);
 
 	card->private_free = snd_usb_audio_free;
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index db6d6e324d78c4da3fc3c676f6f076f01841204e..5bcad4997ed2a4642903d5ef9d43109fb0b20324 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2536,7 +2536,7 @@ void snd_usb_apply_flag_dbg(const char *reason,
 	}
 }
 
-void snd_usb_init_quirk_flags(struct snd_usb_audio *chip)
+void snd_usb_init_quirk_flags_table(struct snd_usb_audio *chip)
 {
 	const struct usb_audio_quirk_flags_table *p;
 
@@ -2550,3 +2550,85 @@ void snd_usb_init_quirk_flags(struct snd_usb_audio *chip)
 		}
 	}
 }
+
+void snd_usb_init_quirk_flags_parse_string(struct snd_usb_audio *chip, char *val)
+{
+	u16 chip_vid = USB_ID_VENDOR(chip->usb_id);
+	u16 chip_pid = USB_ID_PRODUCT(chip->usb_id);
+	u32 mask_flags, unmask_flags, bit;
+	char *p, *field, *flag;
+	bool is_unmask;
+	u16 vid, pid;
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
index 1b727d3c35c7033b85b56ce43d66fd76c8f2d4ef..218ae0e1bd7ea890fc05227bec7ab81b1562e316 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -52,7 +52,9 @@ void snd_usb_apply_flag_dbg(const char *reason,
 			    struct snd_usb_audio *chip,
 			    unsigned long flag);
 
-void snd_usb_init_quirk_flags(struct snd_usb_audio *chip);
+void snd_usb_init_quirk_flags_table(struct snd_usb_audio *chip);
+void snd_usb_init_quirk_flags_parse_string(struct snd_usb_audio *chip,
+					   char *val);
 
 const char *snd_usb_quirk_flag_find_name(unsigned long flag);
 u32 snd_usb_quirk_flags_from_name(const char *name);

-- 
2.51.0



