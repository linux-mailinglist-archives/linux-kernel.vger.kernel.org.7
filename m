Return-Path: <linux-kernel+bounces-756888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D9FB1BABD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F61A161946
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343E429AB0E;
	Tue,  5 Aug 2025 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uZ2D7Eb6"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142E29A33E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420923; cv=none; b=SzkBIOjAK586SVVWRW7OkHlUpeyc3EtkazQySN9QMkT3G8pr34kxb5whcyvpFQ63HsqH6aYVywuxJ+wDmd3aE9efE9ErhpFaXR5eX2nsVdcZri2bmUsz7hlj7igK3NOMdl1Kjn340S+5Xaz8ZAk76Xv1LgrGzi+saVMOJxMy7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420923; c=relaxed/simple;
	bh=1G/p2V5tlFGL5QUKvVznyqDeicxAg5ho7UcilI4OmCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kfV5OI9wn9dfS7K9gGc38Mw7kJZ8XZkZ0dQzIWeuddBweOGIcQQaf4YTKojGx4tLpPat1nits+NmATbaL3MBujc7JzSUN0km3uQVvmNYPhG/X3B9OuQnPfkZh+UhvJpwhbF+n6YylgP5S9YNXLjGnRnqgGBRFtoVX4J0EL+MQrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uZ2D7Eb6; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754420909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iww/0GG+VqqZokX+rrsjlR73+9XBUylwsVCP+JJtueM=;
	b=uZ2D7Eb6ZxbWTNfwVI3hckDaobrI5N5eO1Kq5PzhcaT+i36jC24RUAi6oHStuh5BujOe5t
	5YKxa0dV9RIlVo3LzFES3KSZ+0vQFMaYIEM2YhO8AuM1gICLF2I4OnrIyDDF73S2Xono66
	cfxZIJ54wwaRwK2igMQxP1kfdHqwiQ8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Joe Perches <joe@perches.com>
Cc: stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: intel_hdmi: Fix off-by-one error in __hdmi_lpe_audio_probe()
Date: Tue,  5 Aug 2025 21:08:06 +0200
Message-ID: <20250805190809.31150-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In __hdmi_lpe_audio_probe(), strscpy() is incorrectly called with the
length of the source string (excluding the NUL terminator) rather than
the size of the destination buffer. This results in one character less
being copied from 'card->shortname' to 'pcm->name'.

Since 'pcm->name' is a fixed-size buffer, we can safely omit the size
argument and let strscpy() infer it using sizeof(). This ensures the
card name is copied correctly.

Cc: stable@vger.kernel.org
Fixes: 75b1a8f9d62e ("ALSA: Convert strlcpy to strscpy when return value is unused")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/x86/intel_hdmi_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index cc54539c6030..fbef0cbe8f1a 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1765,7 +1765,7 @@ static int __hdmi_lpe_audio_probe(struct platform_device *pdev)
 		/* setup private data which can be retrieved when required */
 		pcm->private_data = ctx;
 		pcm->info_flags = 0;
-		strscpy(pcm->name, card->shortname, strlen(card->shortname));
+		strscpy(pcm->name, card->shortname);
 		/* setup the ops for playback */
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &had_pcm_ops);
 
-- 
2.50.1


