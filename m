Return-Path: <linux-kernel+bounces-745745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FED9B11DC7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 155887B5D21
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECF02114;
	Fri, 25 Jul 2025 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xnHYe6wn"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E62E7645
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753443805; cv=none; b=mAC16CmXDPk+EWoDkHOidCaUJFsqjuYmYDNKRGdHv2nC80eBJTkePqZUwqBk11x5d0OGFNeJ7cWnFN6GqVOAmKGtyFSstuLVM+NLxf5sebwRIK/quzILJaJLErt4r9Hz3hrnckFHJlVhnHFa10sLXMEPnT02NW84Kd7Stka6BIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753443805; c=relaxed/simple;
	bh=k6k/meNtnpI0AbZogIbblDVPY8C9zkYXASXrXZ2KXLo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gVlA53LwC4gdj5y7OETsoZncl3Nczw74whQuCdMKTyqtR323sR7wEyK0eKjZIwDtZWLfxLtkB3RHrkWVJbG7xcyNAuEXwXnc5GVyeT+3R/6Du9EK08u206/TrL9rqXdSREfoG9QWYg8iLPRRYaX1LCggtr8FLKxIVsxa7mwm44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--verhaegen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xnHYe6wn; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--verhaegen.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so1339734f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753443802; x=1754048602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aqRJeB3ZOhOyNMpaxrCuy+vXcmCv+FI9NJwY2DwIw1Q=;
        b=xnHYe6wnnaCpQ6dKnfd4mamda/mNOIXpa+qaVziuS7QHsxFgRH6Hj+o2LEf9KxrDyl
         hZlGz7hZsmVzNpAVdFrwzqHRQqUeXstCx+wADh7vX18Hlywm/wy9W1bGhxLV7I8m3R9n
         TGQ72oVGzWHxhd9os4MEWmWTNUOj+UzkgUsqs0FdFLA+30UB1wl6UP3dQlIeZv6CVbBd
         KRuoGu+VImCt9Wi3GYfxknM2Q4WiO+g3fDBYZoShra4DlUcSnDnfVFbvIXSBWUUzcEog
         bvmkRMbufej6Y1frGROvn19DpGmXRWenBOsjRugWgRSbjOhPH94hSrli+nRMG7xcfY6H
         T80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753443802; x=1754048602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqRJeB3ZOhOyNMpaxrCuy+vXcmCv+FI9NJwY2DwIw1Q=;
        b=PA1RxNXUTFEZpJmiyCdCUbMKyRvPmXJM2oubBFYidKdMtXnGAM+Vl2KLlDu1nE7y48
         liGfBFt0EbAWXt+jRPL0UyqtG6rcoXksWD0fe7BdzD8pmj+iDEWSD5WgY9HVWEW6SuQu
         lw7+zRqPYt0dm1eCQkZjopADqNp1aFuZpNOu27uOAcGTwAxc4bBE9x1tCeDg0jF5RwIJ
         aJ2Miu4todUuPP0rif9JYoxs+zCXWoYfOSsP3YUuD9XfpzTSKVY3OrCu5ndN7WENArmK
         BmAPl+iXsupndHfopglS5kr0kjVoZPLudbDtvOn5OOSz24Gie0gpw5crQDYVF5R/Tk6S
         t9bg==
X-Forwarded-Encrypted: i=1; AJvYcCXOoyZGPVIrufA4df0dmhINJddpRT72AM0T0wBXBojoOU2tAUsZgGZy7Jd7XiImP3ss9/kFnw1w7Uyn6QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwAfStzzi9IY84wO4UM90qezT1YOsUSTL9aQz3lNrWXHvJ9xy9
	gqpgke3WiUEheKd5H5uXyDWGcp1ttvpjbFQJux8LX4SUYSsjlDGUXyiS+qbOG1xSe8DngLjX3d5
	XH637GXBWhVsq1+3B2g==
X-Google-Smtp-Source: AGHT+IHGAUF8Q7Gd9qDiczST6gVfYuJvOxlipqHbB5s/ofwidCkWtf8SPhwLkjVb4BeR2JNZtpLO8MRs4iHGYDE=
X-Received: from wmbjn21.prod.google.com ([2002:a05:600c:6b15:b0:456:12af:6677])
 (user=verhaegen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4022:b0:3a3:7baf:f06a with SMTP id ffacd0b85a97d-3b77675db6amr1168191f8f.37.1753443802095;
 Fri, 25 Jul 2025 04:43:22 -0700 (PDT)
Date: Fri, 25 Jul 2025 12:42:45 +0100
In-Reply-To: <20250725114249.2086974-1-verhaegen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725114249.2086974-1-verhaegen@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725114249.2086974-4-verhaegen@google.com>
Subject: [PATCH v3 3/3] ALSA: compress_offload: Add SNDRV_COMPRESS_AVAIL64 ioctl
From: Joris Verhaegen <verhaegen@google.com>
To: Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
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
	Miller Liang <millerliang@google.com>
Content-Type: text/plain; charset="UTF-8"

The previous patch introduced a 64-bit timestamp ioctl
(SNDRV_COMPRESS_TSTAMP64). To provide a consistent API, this patch
adds a corresponding 64-bit version of the SNDRV_COMPRESS_AVAIL ioctl.

A new struct snd_compr_avail64 is added to the UAPI, which includes
the 64-bit timestamp. The existing ioctl implementation is refactored
to handle both the 32-bit and 64-bit variants.

Reviewed-by: Miller Liang <millerliang@google.com>
Tested-by: Joris Verhaegen <verhaegen@google.com>
Signed-off-by: Joris Verhaegen <verhaegen@google.com>
---
 include/uapi/sound/compress_offload.h | 11 +++++++
 sound/core/compress_offload.c         | 45 +++++++++++++++++----------
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index 70b8921601f9..26f756cc2e62 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -84,6 +84,16 @@ struct snd_compr_avail {
 	struct snd_compr_tstamp tstamp;
 } __attribute__((packed, aligned(4)));
 
+/**
+ * struct snd_compr_avail64 - avail descriptor with tstamp in 64 bit format
+ * @avail: Number of bytes available in ring buffer for writing/reading
+ * @tstamp: timestamp information
+ */
+struct snd_compr_avail64 {
+	__u64 avail;
+	struct snd_compr_tstamp64 tstamp;
+} __attribute__((packed, aligned(4)));
+
 enum snd_compr_direction {
 	SND_COMPRESS_PLAYBACK = 0,
 	SND_COMPRESS_CAPTURE,
@@ -231,6 +241,7 @@ struct snd_compr_task_status {
 #define SNDRV_COMPRESS_TSTAMP		_IOR('C', 0x20, struct snd_compr_tstamp)
 #define SNDRV_COMPRESS_AVAIL		_IOR('C', 0x21, struct snd_compr_avail)
 #define SNDRV_COMPRESS_TSTAMP64		_IOR('C', 0x22, struct snd_compr_tstamp64)
+#define SNDRV_COMPRESS_AVAIL64		_IOR('C', 0x23, struct snd_compr_avail64)
 #define SNDRV_COMPRESS_PAUSE		_IO('C', 0x30)
 #define SNDRV_COMPRESS_RESUME		_IO('C', 0x31)
 #define SNDRV_COMPRESS_START		_IO('C', 0x32)
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 445220fdb6a0..4d3cf49c0c47 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -203,13 +203,10 @@ static int snd_compr_update_tstamp(struct snd_compr_stream *stream,
 }
 
 static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
-		struct snd_compr_avail *avail)
+				   struct snd_compr_avail64 *avail)
 {
-	struct snd_compr_tstamp64 tstamp64 = { 0 };
-
 	memset(avail, 0, sizeof(*avail));
-	snd_compr_update_tstamp(stream, &tstamp64);
-	snd_compr_tstamp32_from_64(&avail->tstamp, &tstamp64);
+	snd_compr_update_tstamp(stream, &avail->tstamp);
 	/* Still need to return avail even if tstamp can't be filled in */
 
 	if (stream->runtime->total_bytes_available == 0 &&
@@ -233,32 +230,47 @@ static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
 	}
 
 	avail->avail = stream->runtime->total_bytes_available -
-			stream->runtime->total_bytes_transferred;
+		       stream->runtime->total_bytes_transferred;
 	if (stream->direction == SND_COMPRESS_PLAYBACK)
 		avail->avail = stream->runtime->buffer_size - avail->avail;
 
-	pr_debug("ret avail as %llu\n", avail->avail);
+	pr_debug("ret avail as %zu\n", (size_t)avail->avail);
 	return avail->avail;
 }
 
 static inline size_t snd_compr_get_avail(struct snd_compr_stream *stream)
 {
-	struct snd_compr_avail avail;
+	struct snd_compr_avail64 avail;
 
 	return snd_compr_calc_avail(stream, &avail);
 }
 
-static int
-snd_compr_ioctl_avail(struct snd_compr_stream *stream, unsigned long arg)
+static void snd_compr_avail32_from_64(struct snd_compr_avail *avail32,
+				      const struct snd_compr_avail64 *avail64)
 {
-	struct snd_compr_avail ioctl_avail;
+	avail32->avail = avail64->avail;
+	snd_compr_tstamp32_from_64(&avail32->tstamp, &avail64->tstamp);
+}
+
+static int snd_compr_ioctl_avail(struct snd_compr_stream *stream,
+				 unsigned long arg, bool is_32bit)
+{
+	struct snd_compr_avail64 ioctl_avail64;
+	struct snd_compr_avail ioctl_avail32;
 	size_t avail;
+	const void *copy_from = &ioctl_avail64;
+	size_t copy_size = sizeof(ioctl_avail64);
 
 	if (stream->direction == SND_COMPRESS_ACCEL)
 		return -EBADFD;
 
-	avail = snd_compr_calc_avail(stream, &ioctl_avail);
-	ioctl_avail.avail = avail;
+	avail = snd_compr_calc_avail(stream, &ioctl_avail64);
+	ioctl_avail64.avail = avail;
+	if (is_32bit) {
+		snd_compr_avail32_from_64(&ioctl_avail32, &ioctl_avail64);
+		copy_from = &ioctl_avail32;
+		copy_size = sizeof(ioctl_avail32);
+	}
 
 	switch (stream->runtime->state) {
 	case SNDRV_PCM_STATE_OPEN:
@@ -269,8 +281,7 @@ snd_compr_ioctl_avail(struct snd_compr_stream *stream, unsigned long arg)
 		break;
 	}
 
-	if (copy_to_user((__u64 __user *)arg,
-				&ioctl_avail, sizeof(ioctl_avail)))
+	if (copy_to_user((__u64 __user *)arg, copy_from, copy_size))
 		return -EFAULT;
 	return 0;
 }
@@ -1336,7 +1347,9 @@ static long snd_compr_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	case SNDRV_COMPRESS_TSTAMP64:
 		return snd_compr_tstamp(stream, arg, false);
 	case SNDRV_COMPRESS_AVAIL:
-		return snd_compr_ioctl_avail(stream, arg);
+		return snd_compr_ioctl_avail(stream, arg, true);
+	case SNDRV_COMPRESS_AVAIL64:
+		return snd_compr_ioctl_avail(stream, arg, false);
 	case SNDRV_COMPRESS_PAUSE:
 		return snd_compr_pause(stream);
 	case SNDRV_COMPRESS_RESUME:
-- 
2.50.1.470.g6ba607880d-goog


