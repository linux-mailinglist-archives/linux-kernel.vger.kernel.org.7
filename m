Return-Path: <linux-kernel+bounces-767475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0888CB254E1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DBB5A1FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4EE2F9996;
	Wed, 13 Aug 2025 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PFCsQaSo"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B762D8364
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118571; cv=none; b=BFTV2mVdAIwFiMt0J8Q1p3XUlW5CoIXHujofV1dLDX1NRCR2afhWSJiEHYi/wFzl8MDHaJYV8Lw4R+W+c6GwheVjgGmIQGffhNavLkEMRAAyWKJOsMv+Hqw7zOkOdV2k2uHFPnNtQ7HmYaI6BgMN0hknmuaeSnN2YWYr8U3QTC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118571; c=relaxed/simple;
	bh=JSLDnzUEROhn9DqEvlIOVti7KBHDKlVXMUvzgA4iXuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FgJTVoYSrtCZHIYTekUU+E0kiOFTZTJnMgOlnGqo+A3pxqNmhDMHhsKzgDsZy1o3EcoGGrErPpdFLICgpd7Y4qhmKbnQiaggTdW4RIOBn06lfUapQIQWj9/86FIu9wrpGBSOKWe5Yh58o6W25Fj/p8FKvE8utT7v3b1oUYs74dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PFCsQaSo; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755118567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zis8OIa6L0oQE6Xe1X36zgq5KrCMHrQD4UX7YdcdMJY=;
	b=PFCsQaSoMaFbsgdinKL6q9BkxnaNqfZ2Ubz3t0896tRmUPzYMV1OO1Xo7TdU/vQ39lUvU+
	NZ5TvB1OO2IBnmypqWBH5IvGAUuPBBkPNkney16/iwe2Q8HzRTgqFrACVW4G7YpvVk3U5Z
	PORunNfd3Ao3clwJHccfIz8EBhWacE4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Wentao Liang <vulab@iscas.ac.cn>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ALSA: hda: Use min() to simplify snd_hda_get_devices()
Date: Wed, 13 Aug 2025 22:55:02 +0200
Message-ID: <20250813205507.215658-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use min() to simplify snd_hda_get_devices() and improve its readability.

Change the function parameter 'max_devices' from 'int' to 'unsigned int'
to avoid a min() signedness error. Update all related local variables
and the function's return type to 'unsigned int' accordingly.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/sound/hda_codec.h |  4 ++--
 sound/hda/common/codec.c  | 11 +++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index ddc9c392f93f..006d4e4a8195 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -360,8 +360,8 @@ int snd_hda_override_conn_list(struct hda_codec *codec, hda_nid_t nid, int nums,
 int snd_hda_get_conn_index(struct hda_codec *codec, hda_nid_t mux,
 			   hda_nid_t nid, int recursive);
 unsigned int snd_hda_get_num_devices(struct hda_codec *codec, hda_nid_t nid);
-int snd_hda_get_devices(struct hda_codec *codec, hda_nid_t nid,
-			u8 *dev_list, int max_devices);
+unsigned int snd_hda_get_devices(struct hda_codec *codec, hda_nid_t nid,
+				u8 *dev_list, unsigned int max_devices);
 int snd_hda_get_dev_select(struct hda_codec *codec, hda_nid_t nid);
 int snd_hda_set_dev_select(struct hda_codec *codec, hda_nid_t nid, int dev_id);
 
diff --git a/sound/hda/common/codec.c b/sound/hda/common/codec.c
index eb268d442201..ce25608beff5 100644
--- a/sound/hda/common/codec.c
+++ b/sound/hda/common/codec.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
 #include <linux/pm.h>
@@ -323,18 +324,16 @@ EXPORT_SYMBOL_GPL(snd_hda_get_num_devices);
  * Copy the device list. This info is dynamic and so not cached.
  * Currently called only from hda_proc.c, so not exported.
  */
-int snd_hda_get_devices(struct hda_codec *codec, hda_nid_t nid,
-			u8 *dev_list, int max_devices)
+unsigned int snd_hda_get_devices(struct hda_codec *codec, hda_nid_t nid,
+				u8 *dev_list, unsigned int max_devices)
 {
-	unsigned int parm;
-	int i, dev_len, devices;
+	unsigned int parm, i, dev_len, devices;
 
 	parm = snd_hda_get_num_devices(codec, nid);
 	if (!parm)	/* not multi-stream capable */
 		return 0;
 
-	dev_len = parm + 1;
-	dev_len = dev_len < max_devices ? dev_len : max_devices;
+	dev_len = min(parm + 1, max_devices);
 
 	devices = 0;
 	while (devices < dev_len) {
-- 
2.50.1


