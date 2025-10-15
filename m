Return-Path: <linux-kernel+bounces-855294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA061BE0C48
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F26634E9F29
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4931D2DEA6E;
	Wed, 15 Oct 2025 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="JR2Fl9FP"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BE2D7DDD;
	Wed, 15 Oct 2025 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760562737; cv=pass; b=ax62fNUMBBzdhiwr4OeWfruqMML4XE188t94YGIUZkzxPMQyHTsCenA6DkZZu++sZXYIy1mkHghwxDSPXy+IcfOVC/G3plVQD3FbdzkBOsPs9WXliXj63Mh6TWrE6U77awZFOdpEsmXUnKFsLwrOVk7HSAFtV4wNv4DHyo3rE0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760562737; c=relaxed/simple;
	bh=0bodvicrpin/dvsDWbAo2MiSFccRTuzMYhtTYiZ8bXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uR9U+V62VESb3exhjptvylLQSPQulrIROIq4iDtlirppCdOjXwvUrwvL0xhmfsK4xU42N5/D32w8l4HAh0Jj0jhWUYVRgiAMFylGjgmQMZu7sqtlwtDynxf65/BlPwzQLZux48Wehpf0HzPYoT7VRFDlnq9BZ8fFc1p9OY9e68c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=JR2Fl9FP; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cn3gW64qnzyTs;
	Thu, 16 Oct 2025 00:12:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1760562728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nuC1mtiNoaXsTD5lEkpSJDX6D66KcrewjiM1y6swJXc=;
	b=JR2Fl9FPNBVDZgzDLsMmVESyXZqBtGEwD8TMOKlCMT5bROQru1xY2Qf4HfLWCDv0F+ogke
	DBy///GSPLktuWV+4e4G7XQO02GnK4rPjHXVS+zuHaBgY4a7HZCMhoe1w1FBOQmFGYR/97
	DZS0kkVNeijBblxVn3csfD04P2q0LFU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1760562728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nuC1mtiNoaXsTD5lEkpSJDX6D66KcrewjiM1y6swJXc=;
	b=ZD+wfNRpp2D7MuZ7e95YTG1JfbeQ1G+iM22AR+WEWK/bgkkaE4s74OF2ycOnV/+pQdEA4j
	WYqmQchUQWej9zgC8KqZzqbNlesRXMzPHhUCIdxW85QOe2eFeaHPEQZRYVuWDMCjEh8lf8
	cdlKIRRJUX5oJbhtXcyXrV0EkhhAM2U=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1760562728; a=rsa-sha256; cv=none;
	b=hMD5vb7JdTY5S+9q0I2r7gyZ8frju8CLR+jQT+cuQcLTRdBUNeyc/zo7h5eEqjbZhLAlHD
	5juFj9UsOiyVOlOot8SIsc5CY+T7KnqttR47QpjvGUwGleSYgf39ZAl0hlAO0npEhI5fFl
	6QZiqfbMkZ84VGyoKr11IT73a3U9xs4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-sound@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: fix vendor quirk for Logitech H390
Date: Thu, 16 Oct 2025 00:11:30 +0300
Message-ID: <11bbdceb778c30173d540e198db740127f8306ed.1760562126.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vendor quirk QUIRK_FLAG_CTL_MSG_DELAY_1M was inadvertently missing when
adding quirk for Logitech H390. Add it back.

Fixes: 2b929b6eec0c ("ALSA: usb-audio: add mixer_playback_min_mute quirk for Logitech H390")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    Sorry, I missed that there was a Logitech-wide vendor quirk
    QUIRK_FLAG_CTL_MSG_DELAY_1M when sending the previous patch.

 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 43793a5c3f51..f1aacf491848 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2181,6 +2181,7 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 	DEVICE_FLG(0x046d, 0x09a4, /* Logitech QuickCam E 3500 */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x046d, 0x0a8f, /* Logitech H390 headset */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M |
 		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
 	DEVICE_FLG(0x0499, 0x1506, /* Yamaha THR5 */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
-- 
2.51.0


