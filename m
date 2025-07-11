Return-Path: <linux-kernel+bounces-727168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE09EB015ED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BCD64785F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3E920E032;
	Fri, 11 Jul 2025 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q/jCYJrc"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1AC20298D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222357; cv=none; b=DbZNmHX+t781MyMarkBrkiMGOrRKJwtWN0DK7J5u8SXllkcYhlzxuWiEaj8B7zbShr45FKH90lBIdBw5QJo6KgRTuDZ/4b2Bsy3quVEZXfGOGJlWgtTpLG+ToooBSUrkltye51FbLtFBty7N8pGguYDCw8xdMMaHXmBRgaomrQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222357; c=relaxed/simple;
	bh=6a+4TCE/XMdBY8XCQGqf4jLOM9sFzs2NSof6bp+3vgQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HFQmmM2r8u69ZcNPI0a/lUBGDl4oJgvjCuOL3CEO1yEgNAgreuKbpiFgICrL5Pl8UnL29YSgBqyMgHHYBa4TvJdLM5uT0KyFH4Kc72Dj9YAVJ5xEBWqDbd3BgS4DD9EATsN9fb67ij05FzZsmNcFzk/+k45/+028cYo2Uq7aCRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--verhaegen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q/jCYJrc; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--verhaegen.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-455d95e711cso1194105e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 01:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752222354; x=1752827154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8L1+KbxtaiQj6sn8lQLye+giidcKEKOPXNRznqTkxqk=;
        b=Q/jCYJrcpxR8y58eEanFNCTeYjhGS88FN0wkH9CC8U59cFx2BRTyCdpxMrTMjsS9tH
         Dp0GOvz03wFsRXHzdYd05RPzacnsCEnt6TQZp2G7cq//IakiI/zsHiqYWBLNKAe1PHIG
         N6TI9cVoYmWXim3/w9I2zo8CypWtBqQp2eYDTGxD1Wddq3Co+qHlNxaI/XsuGnBlRryY
         Pfu3Js7k3cTIBcKJxaiuqXp2OvW0cgz3NIR0mFako4vroeM/3Ab/62PC2rJivj2/LzYd
         UvY/6mx3IDPcwIMeWs43vYFQfonI2Ip9knPh3QD/Flq9sZmUKxiBNIFEs5OI648eGYud
         x64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752222354; x=1752827154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8L1+KbxtaiQj6sn8lQLye+giidcKEKOPXNRznqTkxqk=;
        b=nbRevwGhU3VW4aqaSibXsMx8tfgOifiIpas/+2WUpPIt/sVUC7HcATjMyGtnebXgHU
         CmQjabKiFkh2AH44m1k0qxzaYEGpK8yL5KB4eu2+RpslplJBOexO1RGeyGL6nb3B6Dlh
         DI+Su7g9GyAAuVGPT+XAsQ7ABiZdAaC9XCgaXwPM3vW5RCSCdRWP0l+gH0YB7qZkZU04
         p7XaNxstqY6H8OW57VVv2G6iLbdeR569kZkCXtyp04OWFoeXJyCsr8lQoDIW2+1DzOek
         Z0qaPYiyjzipxLp/9qV0htlCb7C9gvnLTmWbiQd/av6s75YeTXjSn+aBTz5PqvN3dkkz
         4r+w==
X-Forwarded-Encrypted: i=1; AJvYcCXyyfCNbX3tT1FbTEZaL+uqft7/D7l8KqrYI3wsENnX1Q+ijsBRyrugwRGdOqeJoVKfIhro6OOT8XuleuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt4RL6PCUs6mHBN843K68Qq9Cp6VVx8ur0P9Au9w1iII35HIWj
	w7FyK4Wbm2v57CRb0AaYAVW83087P62i+j0/kIEy9bmzvn4qqZ4PZ0gY4/7RZuG1IvpEXcIUIRh
	fC4ix6EgyUasq3XTSZg==
X-Google-Smtp-Source: AGHT+IEhhhO+Ek1toZERYmrZMeqyTAhmBuFzPDQDq9WLvA9pxxXLVvjyXL3kguu3RptTS4+kf0xbW/3oRFlCSYQ=
X-Received: from wmbeq14.prod.google.com ([2002:a05:600c:848e:b0:453:6ee6:e62a])
 (user=verhaegen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e83:b0:453:92e:a459 with SMTP id 5b1f17b1804b1-454db8d8d06mr65138905e9.16.1752222354317;
 Fri, 11 Jul 2025 01:25:54 -0700 (PDT)
Date: Fri, 11 Jul 2025 09:24:34 +0100
In-Reply-To: <20250711082441.4193295-1-verhaegen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711082441.4193295-1-verhaegen@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711082441.4193295-3-verhaegen@google.com>
Subject: [PATCH v1 2/4] ALSA: compress_offload: Add SNDRV_COMPRESS_TSTAMP64 ioctl
From: George Verhaegen <verhaegen@google.com>
To: Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Cezary Rojewski <cezary.rojewski@intel.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Srinivas Kandagatla <srini@kernel.org>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Joris Verhaegen <verhaegen@google.com>, kernel-team@android.com, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-arm-msm@vger.kernel.org, 
	sound-open-firmware@alsa-project.org, linux-arm-kernel@lists.infradead.org, 
	David Li <dvdli@google.com>, Miller Liang <millerliang@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Joris Verhaegen <verhaegen@google.com>

The previous patch introduced the internal infrastructure for handling
64-bit timestamps. This patch exposes this capability to user-space.

Define the new ioctl command SNDRV_COMPRESS_TSTAMP64, which allows
applications to fetch the overflow-safe struct snd_compr_tstamp64.

The ioctl dispatch table is updated to handle the new command by
calling a new snd_compr_tstamp64 handler, while the legacy path is
renamed to snd_compr_tstamp32 for clarity.

Signed-off-by: Joris Verhaegen <verhaegen@google.com>
Tested-by: Joris Verhaegen <verhaegen@google.com>
Reviewed-by: David Li <dvdli@google.com>
Reviewed-by: Miller Liang <millerliang@google.com>
---
 include/uapi/sound/compress_offload.h |  2 ++
 sound/core/compress_offload.c         | 50 +++++++++++++++++++++++----
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index abd0ea3f86ee..2758d9ee3d91 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -208,6 +208,7 @@ struct snd_compr_task_status {
  * Note: only codec params can be changed runtime and stream params cant be
  * SNDRV_COMPRESS_GET_PARAMS: Query codec params
  * SNDRV_COMPRESS_TSTAMP: get the current timestamp value
+ * SNDRV_COMPRESS_TSTAMP64: get the current timestamp value in 64 bit format
  * SNDRV_COMPRESS_AVAIL: get the current buffer avail value.
  * This also queries the tstamp properties
  * SNDRV_COMPRESS_PAUSE: Pause the running stream
@@ -230,6 +231,7 @@ struct snd_compr_task_status {
 						 struct snd_compr_metadata)
 #define SNDRV_COMPRESS_TSTAMP		_IOR('C', 0x20, struct snd_compr_tstamp)
 #define SNDRV_COMPRESS_AVAIL		_IOR('C', 0x21, struct snd_compr_avail)
+#define SNDRV_COMPRESS_TSTAMP64		_IOR('C', 0x22, struct snd_compr_tstamp64)
 #define SNDRV_COMPRESS_PAUSE		_IO('C', 0x30)
 #define SNDRV_COMPRESS_RESUME		_IO('C', 0x31)
 #define SNDRV_COMPRESS_START		_IO('C', 0x32)
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 6a8873bd62ae..40c1e69961b7 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -211,8 +211,8 @@ snd_compr_tstamp32_from_64(struct snd_compr_tstamp *tstamp32,
 	tstamp32->sampling_rate = tstamp64->sampling_rate;
 }
 
-static int snd_compr_update_tstamp(struct snd_compr_stream *stream,
-		struct snd_compr_tstamp *tstamp)
+static int snd_compr_update_tstamp32(struct snd_compr_stream *stream,
+				     struct snd_compr_tstamp *tstamp)
 {
 	u64 copied_total64;
 	struct snd_compr_tstamp64 tstamp64;
@@ -238,11 +238,30 @@ static int snd_compr_update_tstamp(struct snd_compr_stream *stream,
 	return 0;
 }
 
+static int snd_compr_update_tstamp64(struct snd_compr_stream *stream,
+				     struct snd_compr_tstamp64 *tstamp)
+{
+	int retval = snd_compr_get_tstamp64(stream, tstamp);
+
+	if (retval != 0)
+		return retval;
+
+	pr_debug("dsp consumed till %u total %llu bytes\n", tstamp->byte_offset,
+		 tstamp->copied_total);
+
+	if (stream->direction == SND_COMPRESS_PLAYBACK)
+		stream->runtime->total_bytes_transferred = tstamp->copied_total;
+	else
+		stream->runtime->total_bytes_available = tstamp->copied_total;
+
+	return 0;
+}
+
 static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
 		struct snd_compr_avail *avail)
 {
 	memset(avail, 0, sizeof(*avail));
-	snd_compr_update_tstamp(stream, &avail->tstamp);
+	snd_compr_update_tstamp32(stream, &avail->tstamp);
 	/* Still need to return avail even if tstamp can't be filled in */
 
 	if (stream->runtime->total_bytes_available == 0 &&
@@ -769,19 +788,34 @@ snd_compr_set_metadata(struct snd_compr_stream *stream, unsigned long arg)
 	return retval;
 }
 
-static inline int
-snd_compr_tstamp(struct snd_compr_stream *stream, unsigned long arg)
+static inline int snd_compr_tstamp32(struct snd_compr_stream *stream,
+				     unsigned long arg)
 {
 	struct snd_compr_tstamp tstamp = {0};
 	int ret;
 
-	ret = snd_compr_update_tstamp(stream, &tstamp);
+	ret = snd_compr_update_tstamp32(stream, &tstamp);
 	if (ret == 0)
 		ret = copy_to_user((struct snd_compr_tstamp __user *)arg,
 			&tstamp, sizeof(tstamp)) ? -EFAULT : 0;
 	return ret;
 }
 
+static inline int snd_compr_tstamp64(struct snd_compr_stream *stream,
+				     unsigned long arg)
+{
+	struct snd_compr_tstamp64 tstamp = { 0 };
+	int ret;
+
+	ret = snd_compr_update_tstamp64(stream, &tstamp);
+	if (ret == 0)
+		ret = copy_to_user((struct snd_compr_tstamp64 __user *)arg,
+				   &tstamp, sizeof(tstamp)) ?
+			      -EFAULT :
+			      0;
+	return ret;
+}
+
 static int snd_compr_pause(struct snd_compr_stream *stream)
 {
 	int retval;
@@ -1355,7 +1389,9 @@ static long snd_compr_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 
 	switch (_IOC_NR(cmd)) {
 	case _IOC_NR(SNDRV_COMPRESS_TSTAMP):
-		return snd_compr_tstamp(stream, arg);
+		return snd_compr_tstamp32(stream, arg);
+	case _IOC_NR(SNDRV_COMPRESS_TSTAMP64):
+		return snd_compr_tstamp64(stream, arg);
 	case _IOC_NR(SNDRV_COMPRESS_AVAIL):
 		return snd_compr_ioctl_avail(stream, arg);
 	case _IOC_NR(SNDRV_COMPRESS_PAUSE):
-- 
2.50.0.727.gbf7dc18ff4-goog


