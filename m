Return-Path: <linux-kernel+bounces-832090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB4AB9E4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57327422CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688942EAB63;
	Thu, 25 Sep 2025 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdrJ04PB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38F42EA16A;
	Thu, 25 Sep 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792320; cv=none; b=bPGqpm/tBpFMHBFoXAGUFPV6p9Yc0JjYDZX3/8v+hMbRnhmYt+CaMloCN26dd1J4tGPWxkWxscaDsref19ecaV5tMEde0k/pTGGl6y6hHpzFlwkvIfQDypZ0s/DNJvpzU0Xv/GYutqCkKL5zLNuGDxLR0odYitzIjfMNKD3MnEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792320; c=relaxed/simple;
	bh=7MwQ+OHF3IXIra8rFsg12YiPv+kcsvqrMZnkT2skwU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OqvyFmvwkYWqbudqU156vW5xLYQNsP7ldRVusuMgRgTMh3Eeq1s2OEnCz2SjD6+xchzO4MGJdnQKZKejMh1WnLR7oI6nyBc1ZJ7hvdsuSqyuAU1TZG6JSO12kufCspHo19VDZNWclPPuZbES46xwD5ECRRNVaWrfde2btalxOtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdrJ04PB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4282DC4CEF4;
	Thu, 25 Sep 2025 09:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758792320;
	bh=7MwQ+OHF3IXIra8rFsg12YiPv+kcsvqrMZnkT2skwU0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PdrJ04PBVit9OiW4hGREjBDJJxM+kHVG3qQ+p7+MZEqZbxF8u2iw+LEDwTJlwl1lc
	 oLpplJsO0sWJfdgC/8MU4eDLobx/EOXySdFyUUEzCpHtaYLEQrkN9o1FsTU08J6mLY
	 UKSbypQ0xU/z60qoEDFn0LcRdPy0IV7g4GSPpBRQdZZaKXM3mU8kcCExMFrjVVbHaL
	 B6TQK/P2vjGcI46cLyhNRY501zbMtH3HTddBtdtVTgOuwWLAE2/w62+6gPvyZr5mHj
	 syp0O9wZuzp5BjgYbXn6SgXDKI0D1vLc3oI/XDZtpRl+ZEiP4ygIUIvQcxd8+0GnQt
	 QijZ9lNc8OpqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3889BCAC5B0;
	Thu, 25 Sep 2025 09:25:20 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Thu, 25 Sep 2025 17:25:18 +0800
Subject: [PATCH v5 3/4] ALSA: usb-audio: make param quirk_flags change-able
 in runtime
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-sound-v5-3-2593586ff350@uniontech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758792317; l=2885;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=yg0nraJKqEiHsTts0EQa1+T1J1+t0kLWXGBFQYtmL50=;
 b=5Z1wWHv2L8JGIs27buBuWW33B7eHGIGNr8unJzL8j/uiglLDxgB8BNHX3hjVRIPF9zV1P2hs8
 cKBUrVYdezEAUfHdpA9XlJRo5U2x7j8jaYvUEvdUt2n529n6SxhWeZ4
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

Developers now can change it during sysfs, without rebooting, for
debugging new buggy devices.

Co-developed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 sound/usb/card.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 68d8324fef3747c48d01088e7d1deb61e870db5c..4001a4d0ad2b30ccc03b11fc7a1ebb63efb6ab1f 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -103,13 +103,32 @@ module_param_array(delayed_register, charp, NULL, 0444);
 MODULE_PARM_DESC(delayed_register, "Quirk for delayed registration, given by id:iface, e.g. 0123abcd:4.");
 module_param_array(implicit_fb, bool, NULL, 0444);
 MODULE_PARM_DESC(implicit_fb, "Apply generic implicit feedback sync mode.");
-module_param_array(quirk_flags, charp, NULL, 0444);
-MODULE_PARM_DESC(quirk_flags, "Driver quirk bit flags.");
 module_param_named(use_vmalloc, snd_usb_use_vmalloc, bool, 0444);
 MODULE_PARM_DESC(use_vmalloc, "Use vmalloc for PCM intermediate buffers (default: yes).");
 module_param_named(skip_validation, snd_usb_skip_validation, bool, 0444);
 MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no).");
 
+/* protects quirk_flags */
+DEFINE_MUTEX(quirk_flags_mutex);
+
+static int param_set_quirkp(const char *val,
+			    const struct kernel_param *kp)
+{
+	guard(mutex)(&quirk_flags_mutex);
+	return param_set_charp(val, kp);
+}
+
+static const struct kernel_param_ops param_ops_quirkp = {
+	.set = param_set_quirkp,
+	.get = param_get_charp,
+	.free = param_free_charp,
+};
+
+#define param_check_quirkp param_check_charp
+
+module_param_array(quirk_flags, quirkp, NULL, 0644);
+MODULE_PARM_DESC(quirk_flags, "Add/modify USB audio quirks");
+
 /*
  * we keep the snd_usb_audio_t instances by ourselves for merging
  * the all interfaces on the same card as one sound device.
@@ -697,15 +716,13 @@ static void snd_usb_init_quirk_flags(int idx, struct snd_usb_audio *chip)
 	char *val;
 	size_t i;
 
+	mutex_lock(&quirk_flags_mutex);
+
 	/* old style option found: the position-based integer value */
 	if (quirk_flags[idx] &&
 	    !kstrtou32(quirk_flags[idx], 0, &chip->quirk_flags)) {
-		usb_audio_dbg(chip,
-			      "Set quirk flags 0x%x from param based on position %d for device %04x:%04x\n",
-			      chip->quirk_flags, idx,
-			      USB_ID_VENDOR(chip->usb_id),
-			      USB_ID_PRODUCT(chip->usb_id));
-		return;
+		snd_usb_apply_flag_dbg("module param", chip, chip->quirk_flags);
+		goto unlock;
 	}
 
 	/* take the default quirk from the quirk table */
@@ -725,6 +742,9 @@ static void snd_usb_init_quirk_flags(int idx, struct snd_usb_audio *chip)
 
 		kfree(val);
 	}
+
+unlock:
+	mutex_unlock(&quirk_flags_mutex);
 }
 
 /*

-- 
2.51.0



