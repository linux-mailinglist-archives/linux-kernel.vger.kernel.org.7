Return-Path: <linux-kernel+bounces-757082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D538BB1BD75
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E093AF8B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD4D25EFBD;
	Tue,  5 Aug 2025 23:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m5uxXU3f"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E31D61AA;
	Tue,  5 Aug 2025 23:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754437344; cv=none; b=t3C9dqxyaiOtM+Cjc3wjriYn2MvR385oQh2ylH3j5su1j/fAFLaFwpSBDNGconjH0P+37bdQK3nj4b2inY1xLP7tq/pp8M6rmslj4+To4/yMg4jHo94lLLRSgYTwkjbIIeMEgLtQAtAjIDUZvajUujga80RL8VD03GazgHkxdvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754437344; c=relaxed/simple;
	bh=/jtN9awwVbOPVWc3dr62v/y502n3rqHyUG1C8pKVe0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YLw+fLtw5f2tLt/MXoz9ZwsMCHz/uoHlB2Q2a2srq1jDwqLR83Xlws/t4Z3fVLxAmeChtd0MfVFwNZ+Zrmlzt2JGJiqE2bdzqqnAZif3UyQe2uOyD3hKf5fLxCY+Db1axZfPt48WBqQtXELNRfsbYx+MAaw3DSlLS1kzHxBcd7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m5uxXU3f; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754437330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nkx09rJ+LEyAgM4BQY44PNDPxqhQRPaCfDjd4zu2Xf0=;
	b=m5uxXU3fLsHGhx8s2GlaFlkQRKJE2HkCeNroSmNnBZSpr47LznJZTRumGsLl6c2/9/Cexc
	/vI69E4MozuYi+fWBbXtHUjJd27c4Rk3KfIxQXKiGpye67RIXmBmyQ7OUmBxCjPOjjsTr0
	AR5GK8T226I36K6H3ZTcr1Pkvuv0TEY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Joe Perches <joe@perches.com>,
	Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: intel_hdmi: Fix off-by-one error in __hdmi_lpe_audio_probe()
Date: Wed,  6 Aug 2025 01:41:53 +0200
Message-ID: <20250805234156.60294-1-thorsten.blum@linux.dev>
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

Use the destination buffer size instead to ensure the card name is
copied correctly.

Cc: stable@vger.kernel.org
Fixes: 75b1a8f9d62e ("ALSA: Convert strlcpy to strscpy when return value is unused")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use three parameter variant of strscpy() for backporting as suggested
  by Sakari Ailus <sakari.ailus@linux.intel.com>
- Link to v1: https://lore.kernel.org/lkml/20250805190809.31150-1-thorsten.blum@linux.dev/
---
 sound/x86/intel_hdmi_audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index cc54539c6030..01f49555c5f6 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1765,7 +1765,7 @@ static int __hdmi_lpe_audio_probe(struct platform_device *pdev)
 		/* setup private data which can be retrieved when required */
 		pcm->private_data = ctx;
 		pcm->info_flags = 0;
-		strscpy(pcm->name, card->shortname, strlen(card->shortname));
+		strscpy(pcm->name, card->shortname, sizeof(pcm->name));
 		/* setup the ops for playback */
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &had_pcm_ops);
 
-- 
2.50.1


