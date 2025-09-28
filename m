Return-Path: <linux-kernel+bounces-835167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7537BA66CF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8463BF6C1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 03:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F396B24E00F;
	Sun, 28 Sep 2025 03:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaH2ZJof"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A00F204F8B;
	Sun, 28 Sep 2025 03:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759028888; cv=none; b=FUGkunQpj/PLOqkezvHyZ7sI8QN3xY+OiFjS4dzxm8ZeRx3gll9yy4KnzB/efjgBQ9Ua6rimTAxh6BUnaYpCzLJw+5V1zr3OQjmW6UYWzKyxGLocdhJ7mahou1vtpSQrjQctdYD/LDbWfp0kDeAFgQKAGyPLWeCLRfefWSX9jtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759028888; c=relaxed/simple;
	bh=LB0VBxfGlatGtA6+CtimRj7E4EIK0fuTYyW3+vO/KBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZROnQXr9WbGZuy/GEvvS96nNK5XkTVrnsmEd/QVwUy5lMeK+ZaFIDTvQNYonGd33ZTh3haJqcL54iVvf5zsbW8iENnhKnbG7VJaJ7lTXW4EmZ5/IriK61GszdOMEjnw9EAQuya7oLvcdFlyF2q7Qzq/YmptuLHsi7QcJj3FV/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaH2ZJof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3478C116C6;
	Sun, 28 Sep 2025 03:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759028887;
	bh=LB0VBxfGlatGtA6+CtimRj7E4EIK0fuTYyW3+vO/KBo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZaH2ZJofzREW8SMosYLPEtFMmLyQ5CwmmFIhdaMlNvHdfunXpyyu7xrvfwyc0VNno
	 CBzN+JsIN+fh32WFjfh74mwo9vvSLFxcPBoCwh6CfGwzfw4hMTXygYTa6NcTFO4+nX
	 Vc/WckF/UyMebaGbDs+KrqKKGszjCl3O8/tRzLefAVM5zWBBky9f75wo/ubkb6xFQj
	 7s7YU05L4EzyzVafntRs5TQTY63Up2HOT/VdtMMKJ92Fiq5ukQf6No9v3zngjnD++M
	 F4QChloha6anhtPJYlJ10XiOG7W1VkCKLncenCld/wIZnIyHysC0rY5WFhrIxhlfdB
	 wJMACZqybh6yg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5880CAC5B0;
	Sun, 28 Sep 2025 03:08:07 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Sun, 28 Sep 2025 11:08:01 +0800
Subject: [PATCH v6 3/4] ALSA: usb-audio: make param quirk_flags change-able
 in runtime
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250928-sound-v6-3-7da6e5982432@uniontech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759028886; l=2371;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=5AZ8qoRZXO0BUCPWWDvotB46JtFmUotG234iZIRjw4Y=;
 b=hHxiRHqOCdray7vQeCQ6uIlfgLX91sBf7tAYsF6YdOccMiacn0u887MlaJtLN84f8/MHQlqKP
 BhR6AK4Lgt3Cd0D3jQqrgrdiCXj24P0aAMoFxPPM7nzMosMnVqOflX9
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

Change its permision from 0644 to 0444, and add runtime processing.

Developers now can change it during sysfs, without rebooting, for
debugging new buggy devices.

Co-developed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 sound/usb/card.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 66c6c92fa9e8d2d04cc297a3dc8de9c8a2e99465..1d5a65eac9335028cfeabd2d80b389e364477387 100644
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
+static DEFINE_MUTEX(quirk_flags_mutex);
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
@@ -696,6 +715,8 @@ static void snd_usb_init_quirk_flags(int idx, struct snd_usb_audio *chip)
 {
 	size_t i;
 
+	guard(mutex)(&quirk_flags_mutex);
+
 	/* old style option found: the position-based integer value */
 	if (quirk_flags[idx] &&
 	    !kstrtou32(quirk_flags[idx], 0, &chip->quirk_flags)) {

-- 
2.51.0



