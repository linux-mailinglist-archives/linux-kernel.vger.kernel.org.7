Return-Path: <linux-kernel+bounces-855216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B53BE08AF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897B94832C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EB6306D54;
	Wed, 15 Oct 2025 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="putED+MK"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A9630276F;
	Wed, 15 Oct 2025 19:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557650; cv=pass; b=URr+oj5cGMYLkER4k2hAw/1WdpFLoYPRN5U1p7n8MNt40Hnjl7ZWWV1OP8AGB8QJ7uVY7WwKtw/+JjdWb6ntev+Ls1uGIWv26BZg6gJIVzsjfimhRl3ls0klw3FX3Fmn2lVAylTy9hz8g7Q+gf3wdAMUYM4D/RLk6HcVx6vZwLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557650; c=relaxed/simple;
	bh=pCgJHmwl08f6J8nRC3dweSFLnUJgjNGTQ6VqthcuRg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FqC8CfMNtm8B4kSiSTfv68XxEM5V9uB12TL64NYHgMvnIOYl7CO2LhDaAyEnbmHTI47djNbCrEnnBItxeUwuM0ePg8kIWVVJRc4WRsCfc7w4tVeo46N+3FjO7AlLcqZINh+FFXWeEEBvh3wFFEHUNGkE0xnzxc7pBtNqc9NsXto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=putED+MK; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cn1ng2mxkzyQw;
	Wed, 15 Oct 2025 22:47:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1760557639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0GXc8Cz/craa2/0XYF5Ca9jDzKu+plgHykELScRn5oQ=;
	b=putED+MKKhcPnzI3kI8Sn205uTlb9BDVUS9KdSNkE/Lut3MinQZ7AAdtub/mS1V0f5ZKdb
	1MAeAyTZrj0HvnbmmrPFNWe50X9iV7x70bV7bX9LkUNOdhi1lOF9UdMlxIdLZ5FzXUUoSu
	ZYlls/sSYfwo9AcMOyeqU+DkltDJ9tc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1760557639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0GXc8Cz/craa2/0XYF5Ca9jDzKu+plgHykELScRn5oQ=;
	b=pvigfaDjqNzhtlSMx+anaT/k0xVquZ0guSrx3SZOB6tScBO28BAb2tblInLk6CJROnGG+F
	laqX2dnQL+bJ5Sps55Q8cggkmedlM1OOeNsy+Ve24l522iPuR7DZFCR9Y41VaDmhPfcKkO
	eKoW/WCEvBAyI+gEkgJbrpcbKlCqxwU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1760557639; a=rsa-sha256; cv=none;
	b=TKCNo/uK7/jy0yeDpb/ldGGfxL/npt0xH9BCkwHt1/BLOT0gfLNby+4ux/uuCZNqNFSx23
	AHiLYwDO7cWkQJX++YSbUJtT+DJv4idiMumPdnU6OlBY1JEvkkmUzVCTcJZOt1H0JqoG/i
	bu0xBX3auCXbxUeTNkHbJtB3P/AbLYg=
From: Pauli Virtanen <pav@iki.fi>
To: linux-sound@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: add volume quirks for MS LifeChat LX-3000
Date: Wed, 15 Oct 2025 22:47:10 +0300
Message-ID: <c6e6991fd3f1099f5919593a68a4e7819c204068.1760557349.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ID 045e:070f Microsoft Corp. LifeChat LX-3000 Headset
has muted minimum Speaker Playback Volume, and 4 amixer steps were
observed to produce 1 actual volume step.

Apply min_mute quirk and correct res=48 -> 4*48.
Tested with the device.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 sound/usb/mixer.c  | 8 ++++++++
 sound/usb/quirks.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index ae412e651faf..6f00e0d52382 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1147,6 +1147,14 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 		}
 		break;
 
+	case USB_ID(0x045e, 0x070f): /* MS LifeChat LX-3000 Headset */
+		if (!strcmp(kctl->id.name, "Speaker Playback Volume")) {
+			usb_audio_info(chip,
+				"set volume quirk for MS LifeChat LX-3000\n");
+			cval->res = 192;
+		}
+		break;
+
 	case USB_ID(0x0471, 0x0101):
 	case USB_ID(0x0471, 0x0104):
 	case USB_ID(0x0471, 0x0105):
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 43793a5c3f51..dac469a8d07a 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2153,6 +2153,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x045e, 0x083c, /* MS USB Link headset */
 		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_CTL_MSG_DELAY |
 		   QUIRK_FLAG_DISABLE_AUTOSUSPEND),
+	DEVICE_FLG(0x045e, 0x070f, /* MS LifeChat LX-3000 Headset */
+		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x046d, 0x0807, /* Logitech Webcam C500 */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
 	DEVICE_FLG(0x046d, 0x0808, /* Logitech Webcam C600 */
-- 
2.51.0


