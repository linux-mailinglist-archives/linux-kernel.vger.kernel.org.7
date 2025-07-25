Return-Path: <linux-kernel+bounces-745744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87C4B11DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82386172B35
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A431C2E7652;
	Fri, 25 Jul 2025 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QCAvnuqa"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B9B2E7198
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753443797; cv=none; b=U1U11TSy3x05WNEOZczsgBMkdExihAeS1sWsnvoCvJta1rme57ZOLy7knkoL94sg8QBRbVpvGxNMwAkJdnAHQGQX/pej06/aFC5E3AhFRKjyFhiCPu4gEyRk+cx867qw/Jf9xG4CBm6QDsTsSpliP6l1xPd0j3/pKiLfYsTIVeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753443797; c=relaxed/simple;
	bh=xYkxiSGB3HiyrpwMmesA1Pdc4KekDGsxkxYb8FOqOsg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HdE5M2mHqiL+HFNP4+JEu24FfnWRnwCJvvfBw80vM8ytNWKXK/W1nzFFIFluBXed6itWsD7vCY15iglhXTu+KAgJ9FlVOPdqUa57Hq5q3zygJDXnMQ1tGqa6rXsdpif5ovat2AKjcpgcj7wkI98KrStJ2SeOURugQmF1WkMrFe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--verhaegen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QCAvnuqa; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--verhaegen.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b77738050fso274523f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 04:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753443794; x=1754048594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+a+TqK/s3X4ICiheNo2EUiGxut07xdB8F6iCq61W8U=;
        b=QCAvnuqacFtjmtznrz5Pd1zL22ykpTdZFMU1I6Hzc1PUqlHTHDN+CAPtpAM6ixWSyN
         J08IWfFgU26wJuycDnfjMJidbQlCqYWoeEo8qYgmzzEWdDXWiALyyopvrW7nqYtWwLwC
         BHznZRmYr+ZG61nl80dluKe5Tt0CZN8E7XWdQUCETuFj88TMGt494LECKqnQ2Z08FeJ9
         jzZYLlGs9SmxqZtrZUv6eaYKGNF3ziAvoj2llJ2r8lMQoRsguX1ZBuIhmShYAB9PT4gu
         iRwa71mV/dpPjKmVZ8i+lKt2AVUxHno8VOOFM7S1iKPZCxV7leKn77MLGsiOUWzrS+M6
         0Llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753443794; x=1754048594;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+a+TqK/s3X4ICiheNo2EUiGxut07xdB8F6iCq61W8U=;
        b=buMD24FHCnkOkL1vVvDvGCni/8OG+mQEQQdKwH/O8nnJ5/60mqFEd+igaFITXdTsXR
         C2oLHFVROWUpl3S37e1xzJgxHTewGLKMfdqmuWoCHverPVnjCrL2eBuIZpq4AoYX9uJm
         YgVFDJCUDb8q/sGimJHWHEUjrThkJykMc4zLkkBT5ppkCs/5NZehVw3VYwRX5yQ4uIOr
         YoMyFnfyNjjcvyEz68SJd/ZYZ629qnTBnVhjrwtbgzncnV9CjnEsUg/NZGc0tulpLJB8
         wS+wQBu2oKPtRhfHRbCO2+KhQPB2B+6bquksleS7gV1Ib17T9EGlwD5apGOy/KTmLCxc
         j57A==
X-Forwarded-Encrypted: i=1; AJvYcCWYtbXRAUO7HSTPnnk4ybeA5MAgmLO6GjcGcP5eoCwd7Uyn7/sCkN02tnRXNh4CcqdCfaoSSJKUTT/+ZHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZBZNZN44fKZpIpmyPDowBd1dTiXFN6sMhx/R7xWTPMECP+1Xr
	b7HjUGtCrSIEMoyQKL1Hw0P8qMiE0+6QZ1jj3wSXM3Set7/g2MASZFoHw8pO98hx+GeHE04URmT
	OL6MXdkVI+GVI9LNU7w==
X-Google-Smtp-Source: AGHT+IEjxdJR1uJLIOVLqBDV0bDsdc/XTQjcc+CXgCRPq1R1chA9MEbontl1NBvD61YpGImuSVWX6wytCW9/eOc=
X-Received: from wrbee12.prod.google.com ([2002:a05:6000:210c:b0:3b7:6ea1:a86f])
 (user=verhaegen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1889:b0:3a4:dc93:1e87 with SMTP id ffacd0b85a97d-3b7765e614amr1746678f8f.1.1753443794521;
 Fri, 25 Jul 2025 04:43:14 -0700 (PDT)
Date: Fri, 25 Jul 2025 12:42:44 +0100
In-Reply-To: <20250725114249.2086974-1-verhaegen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725114249.2086974-1-verhaegen@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725114249.2086974-3-verhaegen@google.com>
Subject: [PATCH v3 2/3] ALSA: compress_offload: Add SNDRV_COMPRESS_TSTAMP64 ioctl
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

The previous patch introduced the internal infrastructure for handling
64-bit timestamps. This patch exposes this capability to user-space.

Define the new ioctl command SNDRV_COMPRESS_TSTAMP64, which allows
applications to fetch the overflow-safe struct snd_compr_tstamp64.

The ioctl dispatch table is updated to handle the new command by
calling a new snd_compr_tstamp64 handler, while the legacy path is
renamed to snd_compr_tstamp32 for clarity.

This patch bumps the SNDRV_COMPRESS_VERSION to 0.4.0.

Reviewed-by: Miller Liang <millerliang@google.com>
Tested-by: Joris Verhaegen <verhaegen@google.com>
Signed-off-by: Joris Verhaegen <verhaegen@google.com>
---
 include/uapi/sound/compress_offload.h |  5 +++--
 sound/core/compress_offload.c         | 19 +++++++++++++------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index abd0ea3f86ee..70b8921601f9 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -13,8 +13,7 @@
 #include <sound/asound.h>
 #include <sound/compress_params.h>
 
-
-#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 3, 0)
+#define SNDRV_COMPRESS_VERSION SNDRV_PROTOCOL_VERSION(0, 4, 0)
 /**
  * struct snd_compressed_buffer - compressed buffer
  * @fragment_size: size of buffer fragment in bytes
@@ -208,6 +207,7 @@ struct snd_compr_task_status {
  * Note: only codec params can be changed runtime and stream params cant be
  * SNDRV_COMPRESS_GET_PARAMS: Query codec params
  * SNDRV_COMPRESS_TSTAMP: get the current timestamp value
+ * SNDRV_COMPRESS_TSTAMP64: get the current timestamp value in 64 bit format
  * SNDRV_COMPRESS_AVAIL: get the current buffer avail value.
  * This also queries the tstamp properties
  * SNDRV_COMPRESS_PAUSE: Pause the running stream
@@ -230,6 +230,7 @@ struct snd_compr_task_status {
 						 struct snd_compr_metadata)
 #define SNDRV_COMPRESS_TSTAMP		_IOR('C', 0x20, struct snd_compr_tstamp)
 #define SNDRV_COMPRESS_AVAIL		_IOR('C', 0x21, struct snd_compr_avail)
+#define SNDRV_COMPRESS_TSTAMP64		_IOR('C', 0x22, struct snd_compr_tstamp64)
 #define SNDRV_COMPRESS_PAUSE		_IO('C', 0x30)
 #define SNDRV_COMPRESS_RESUME		_IO('C', 0x31)
 #define SNDRV_COMPRESS_START		_IO('C', 0x32)
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index d3164aa07158..445220fdb6a0 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -736,18 +736,23 @@ snd_compr_set_metadata(struct snd_compr_stream *stream, unsigned long arg)
 	return retval;
 }
 
-static inline int
-snd_compr_tstamp(struct snd_compr_stream *stream, unsigned long arg)
+static inline int snd_compr_tstamp(struct snd_compr_stream *stream,
+				   unsigned long arg, bool is_32bit)
 {
 	struct snd_compr_tstamp64 tstamp64 = { 0 };
 	struct snd_compr_tstamp tstamp32 = { 0 };
+	const void *copy_from = &tstamp64;
+	size_t copy_size = sizeof(tstamp64);
 	int ret;
 
 	ret = snd_compr_update_tstamp(stream, &tstamp64);
 	if (ret == 0) {
-		snd_compr_tstamp32_from_64(&tstamp32, &tstamp64);
-		ret = copy_to_user((struct snd_compr_tstamp __user *)arg,
-				   &tstamp32, sizeof(tstamp32)) ?
+		if (is_32bit) {
+			snd_compr_tstamp32_from_64(&tstamp32, &tstamp64);
+			copy_from = &tstamp32;
+			copy_size = sizeof(tstamp32);
+		}
+		ret = copy_to_user((void __user *)arg, copy_from, copy_size) ?
 			      -EFAULT :
 			      0;
 	}
@@ -1327,7 +1332,9 @@ static long snd_compr_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 
 	switch (cmd) {
 	case SNDRV_COMPRESS_TSTAMP:
-		return snd_compr_tstamp(stream, arg);
+		return snd_compr_tstamp(stream, arg, true);
+	case SNDRV_COMPRESS_TSTAMP64:
+		return snd_compr_tstamp(stream, arg, false);
 	case SNDRV_COMPRESS_AVAIL:
 		return snd_compr_ioctl_avail(stream, arg);
 	case SNDRV_COMPRESS_PAUSE:
-- 
2.50.1.470.g6ba607880d-goog


