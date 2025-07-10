Return-Path: <linux-kernel+bounces-725023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D201CAFF9DF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23C03A6D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C153285062;
	Thu, 10 Jul 2025 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7YQ2hRt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AF572602;
	Thu, 10 Jul 2025 06:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752129065; cv=none; b=A/XkTvj4MhoJP4LnY1MGE+D43kFR4RGTNIP7Y4YtInEyX+sfj5Soki8/7CHG1ayuoY9IBkHGRK1beLIMVOwwjV0hh8+JNy81nhP7XDwI1noWy3UDavJrZNWqzh5NuuxwZaymmlGfUTL4t920giCxEqJHRnzM273N5UJ7fN12PSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752129065; c=relaxed/simple;
	bh=DFVCqLr5F1OAIbWkD0g9t54tR1JHwxI8rK7jZnnbmmw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HR+cMQM4SAriQXbZuAW6kh/kMusodqaM/wxXplBavbrAXcHbzmkqiDL0bBiZKn50Rr/jkePgqFUV34Gw7n+8K83RpcSoavJuVHT/z3p2uzT7AP3HgTV+uh46pC+EUSs5JhKgi4XFwtHcRl3q4dFtNr0+Kd/tGRisw6vDXdl9DuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7YQ2hRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8DBC4CEE3;
	Thu, 10 Jul 2025 06:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752129065;
	bh=DFVCqLr5F1OAIbWkD0g9t54tR1JHwxI8rK7jZnnbmmw=;
	h=From:To:Cc:Subject:Date:From;
	b=I7YQ2hRt3BjkJZtXr4C0blvqg/1tymdtIuOfongQdirR9/6Z6dLi8CZdZpUF6mAFG
	 Tvok+NBvfec2o1340G1tuUQn0u5DxrPM0imfrSJBxwO3gPp5T4KntCz4KnTBlOxtGU
	 BI9dpDMgl91r48mrjke0cGe4yHxICmtSKVYtXjvvyD6zR6sWeUj11cN4TQbFPRUUiJ
	 PBsxIpJELBFonDWUNlSJVPeRAgMp8E42Z5taJLOps1pJ6fOZP/h1cgm4WFIHAa1B6z
	 XhJU1895s9NfIE7ztZ07LYSOzEUf70Iebrz0Xith/Vqq8SEOzEdPm8ajqZ8+UER9uW
	 N/1jPaBF/syjQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Yu Jiaoliang <yujiaoliang@vivo.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: compress_offload: tighten ioctl command number checks
Date: Thu, 10 Jul 2025 08:30:49 +0200
Message-Id: <20250710063059.2683476-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The snd_compr_ioctl() ignores the upper 24 bits of the ioctl command
number and only compares the number of the ioctl command, which can
cause unintended behavior if an application tries to use an unsupprted
command that happens to have the same _IOC_NR() value.

Remove the truncation to the low bits and compare the entire ioctl
command code like every other driver does.

Fixes: b21c60a4edd2 ("ALSA: core: add support for compress_offload")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I could not find any indication on why this driver did this in
the first place, it already was this way in the original commit
back in 2011.
---
 sound/core/compress_offload.c | 48 +++++++++++++++++------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 840bb9cfe789..a66f258cafaa 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -1269,62 +1269,62 @@ static long snd_compr_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	stream = &data->stream;
 
 	guard(mutex)(&stream->device->lock);
-	switch (_IOC_NR(cmd)) {
-	case _IOC_NR(SNDRV_COMPRESS_IOCTL_VERSION):
+	switch (cmd) {
+	case SNDRV_COMPRESS_IOCTL_VERSION:
 		return put_user(SNDRV_COMPRESS_VERSION,
 				(int __user *)arg) ? -EFAULT : 0;
-	case _IOC_NR(SNDRV_COMPRESS_GET_CAPS):
+	case SNDRV_COMPRESS_GET_CAPS:
 		return snd_compr_get_caps(stream, arg);
 #ifndef COMPR_CODEC_CAPS_OVERFLOW
-	case _IOC_NR(SNDRV_COMPRESS_GET_CODEC_CAPS):
+	case SNDRV_COMPRESS_GET_CODEC_CAPS:
 		return snd_compr_get_codec_caps(stream, arg);
 #endif
-	case _IOC_NR(SNDRV_COMPRESS_SET_PARAMS):
+	case SNDRV_COMPRESS_SET_PARAMS:
 		return snd_compr_set_params(stream, arg);
-	case _IOC_NR(SNDRV_COMPRESS_GET_PARAMS):
+	case SNDRV_COMPRESS_GET_PARAMS:
 		return snd_compr_get_params(stream, arg);
-	case _IOC_NR(SNDRV_COMPRESS_SET_METADATA):
+	case SNDRV_COMPRESS_SET_METADATA:
 		return snd_compr_set_metadata(stream, arg);
-	case _IOC_NR(SNDRV_COMPRESS_GET_METADATA):
+	case SNDRV_COMPRESS_GET_METADATA:
 		return snd_compr_get_metadata(stream, arg);
 	}
 
 	if (stream->direction == SND_COMPRESS_ACCEL) {
 #if IS_ENABLED(CONFIG_SND_COMPRESS_ACCEL)
-		switch (_IOC_NR(cmd)) {
-		case _IOC_NR(SNDRV_COMPRESS_TASK_CREATE):
+		switch (cmd) {
+		case SNDRV_COMPRESS_TASK_CREATE:
 			return snd_compr_task_create(stream, arg);
-		case _IOC_NR(SNDRV_COMPRESS_TASK_FREE):
+		case SNDRV_COMPRESS_TASK_FREE:
 			return snd_compr_task_seq(stream, arg, snd_compr_task_free_one);
-		case _IOC_NR(SNDRV_COMPRESS_TASK_START):
+		case SNDRV_COMPRESS_TASK_START:
 			return snd_compr_task_start_ioctl(stream, arg);
-		case _IOC_NR(SNDRV_COMPRESS_TASK_STOP):
+		case SNDRV_COMPRESS_TASK_STOP:
 			return snd_compr_task_seq(stream, arg, snd_compr_task_stop_one);
-		case _IOC_NR(SNDRV_COMPRESS_TASK_STATUS):
+		case SNDRV_COMPRESS_TASK_STATUS:
 			return snd_compr_task_status_ioctl(stream, arg);
 		}
 #endif
 		return -ENOTTY;
 	}
 
-	switch (_IOC_NR(cmd)) {
-	case _IOC_NR(SNDRV_COMPRESS_TSTAMP):
+	switch (cmd) {
+	case SNDRV_COMPRESS_TSTAMP:
 		return snd_compr_tstamp(stream, arg);
-	case _IOC_NR(SNDRV_COMPRESS_AVAIL):
+	case SNDRV_COMPRESS_AVAIL:
 		return snd_compr_ioctl_avail(stream, arg);
-	case _IOC_NR(SNDRV_COMPRESS_PAUSE):
+	case SNDRV_COMPRESS_PAUSE:
 		return snd_compr_pause(stream);
-	case _IOC_NR(SNDRV_COMPRESS_RESUME):
+	case SNDRV_COMPRESS_RESUME:
 		return snd_compr_resume(stream);
-	case _IOC_NR(SNDRV_COMPRESS_START):
+	case SNDRV_COMPRESS_START:
 		return snd_compr_start(stream);
-	case _IOC_NR(SNDRV_COMPRESS_STOP):
+	case SNDRV_COMPRESS_STOP:
 		return snd_compr_stop(stream);
-	case _IOC_NR(SNDRV_COMPRESS_DRAIN):
+	case SNDRV_COMPRESS_DRAIN:
 		return snd_compr_drain(stream);
-	case _IOC_NR(SNDRV_COMPRESS_PARTIAL_DRAIN):
+	case SNDRV_COMPRESS_PARTIAL_DRAIN:
 		return snd_compr_partial_drain(stream);
-	case _IOC_NR(SNDRV_COMPRESS_NEXT_TRACK):
+	case SNDRV_COMPRESS_NEXT_TRACK:
 		return snd_compr_next_track(stream);
 	}
 
-- 
2.39.5


