Return-Path: <linux-kernel+bounces-764821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D05B2279D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603723A4EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEA627511F;
	Tue, 12 Aug 2025 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFoRCy/C"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AECE25EF81;
	Tue, 12 Aug 2025 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003401; cv=none; b=EX2oqi+C4YB3fn1BgPf0zCyGyLUiK+drOdREhNcu2avAnBr1dow9v3A9VNU74BLY1ztcN58ThQQSGgHydixbQAT0YIKfApw1QffCzPbMc/0Mpay54ASfyrLWMBfukuFU+RWG3mlf9pyOp4pU1nxA3KMuRb6UFl9kotNk99MsEUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003401; c=relaxed/simple;
	bh=ynoTq1/bwBXqXeejCZ6FKLFpgPLASDXZexFoDUHw91g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYH/7ScV+NO5jDsu/AUZcP3Und7bxL355bY6XA3k6aG/J2uO0SXCkQtpBhK1yqq9bScehAJM5lDjh9UPcOUVoZROwEe7PdKDLtROCecHQTt5dRgjKoSHTGT4YWnAQJ10+0xPlUqEEf+ZakrKUSlvoDy53gIQd/O6hGxIvV+/Wts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFoRCy/C; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af93c3bac8fso766022466b.2;
        Tue, 12 Aug 2025 05:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755003398; x=1755608198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUC1e+3QnP9V3PaLp8zCefmsZcTyYCpnVsVHZkiXKFI=;
        b=KFoRCy/CZ1Dnv+ayJCbmJan7kmYKP0xrr3qHGvYSSx7xQlOTpS3YFJGesBbKFnxa4m
         VtY1f3pIKFk+cVC14IXiXQkxE1+1HyNOhesfnyfcTceRSr9oX7Cw9rnxwB3qvPSxvbwK
         u8bahS1Cr01Eisfj0ftigmENnfQOt7utoTuM0e9yBEzkZ3+OzSqSqw9JWrrKph3bFGZv
         pARWQ2ZPBAxDUdLicij3gwsjjLVLjH/IcxzgvzX97nWFTlOkgE83kXs2xPDXNayMs853
         z0rPYGmSdiSIVMAvoHBn+G/otF+5VHfErf7veeTnHKDK16eHHMB3L9v8Mi9621CfgNOs
         QGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003398; x=1755608198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUC1e+3QnP9V3PaLp8zCefmsZcTyYCpnVsVHZkiXKFI=;
        b=PlKs2VZXYvwAr1pCBF9w/UyPm7Nvo9aIWMNQN4F0Q3LQtCpnib8HiWbhQgTe+Q8vE3
         cSHv6DfePyWDu/PMghjH9EnnyQBMvX4Fw/qhrbWcSrvHonanok1vsk7HyxKrNdkJeeua
         hcMcXWl+u1M8xwPTTKg+hGICZaksprjigCgsSUykegDzLd3+egquBrpWBSLPORsmAPFp
         bj8EHki/WOSbizRrdAupO+Eg4m0HOJ4nUKLYJVZCrYyXypmAxZNbVm05JaDbFyeHSFME
         GYGnWP3YND0CcKdH+hWzjEoX9DMctno+0oLRSZFdfX779LditQVc4tRthTBNDKibFeG9
         1zkg==
X-Forwarded-Encrypted: i=1; AJvYcCVQySybT48i3WhV93CNnK/kJ7hBff9qBnsHioRlKSJB9MjnBOOGtOFV4oXFfDLy9SD9y01FA2X+uPAc2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNzOuH1PWJ0NiUduD7HGqcYgxVGLzuGsp0bw4vMuGIXW0QbPR5
	/jrTTv8c23k/rk0IPsVys8ImCBCYI7f3dDxiqGDQ++LU8XpAK8KXtXS9g19taoyB/HA=
X-Gm-Gg: ASbGnctZ9qHqK8/ysSzhAWvYJzZG0e7/8GRm5puT8vPL4bDJ5pl4bJYtKItlURyV28t
	NRY8CbV4CtgG2z9GDLn0vF6XYIUwKuRWotxneFi2B49dhO6qbz/S0pdXdW7FtV/X1Y8GXQ26nWL
	CTtN1Ih4/nn70dMPf0sBzlNqBWT2m5opOeYJI6qMAYcEIuAzAefUe8DBJQXLa9eoSPNsejibboG
	2ExEdkjU6wBbGoYf5v5YdA6SeJrbz+u6Noa+cXHuPcKzb5UAgCnoxlsbvIQPcpoxQGmMqrMXn1C
	RX5bqEn9KcXQoDyhMLHmMtMpMmh28rY6fIAaIhGpq9591o7fkh0SzQIlgZCkEGB06IsaeK3JcmW
	fP+RPbP0wFpaLMcpJFmJ2cSoF49Nzbuy9dPttzkA94drNLuPkDG3G0HytrcuxwBob/apSpCwsNZ
	VlYRqYyw==
X-Google-Smtp-Source: AGHT+IHcLIjyu6J0yPAonsHbUa6HMGZifNM6A0nWre0/VFv1YDO6U6xEf4aeeMp1f5dccqLnqHhWBQ==
X-Received: by 2002:a17:907:d18:b0:ae3:24c:6a21 with SMTP id a640c23a62f3a-af9c643f89bmr1407342366b.26.1755003397200;
        Tue, 12 Aug 2025 05:56:37 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3361sm2199158266b.39.2025.08.12.05.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:56:36 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v2 1/6] ALSA: usb-audio: us144mkii: Add PCM core infrastructure
Date: Tue, 12 Aug 2025 14:56:22 +0200
Message-Id: <20250812125633.79270-3-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812125633.79270-1-ramiserifpersia@gmail.com>
References: <20250810124958.25309-1-ramiserifpersia@gmail.com>
 <20250812125633.79270-1-ramiserifpersia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds the ALSA PCM device infrastructure. It creates a new
PCM device with one playback and one capture stream.

The hardware capabilities (formats, rates, channels) are defined in
`tascam_pcm_hw`. The core PCM operations (`snd_pcm_ops`) for both
playback and capture are implemented, including open, close, hw_params,
prepare, and pointer callbacks.

The trigger callback is a stub for now. This commit allows user-space
applications to interact with the ALSA device, but no audio will be
streamed yet.

Signed-off-by: Šerif Rami <ramiserifpersia@gmail.com>
---
 sound/usb/usx2y/us144mkii.c          |  20 ++++-
 sound/usb/usx2y/us144mkii.h          |  67 +++++++++++++----
 sound/usb/usx2y/us144mkii_capture.c  | 108 +++++++++++++++++++++++++++
 sound/usb/usx2y/us144mkii_pcm.c      |  77 +++++++++++++++++++
 sound/usb/usx2y/us144mkii_pcm.h      |  76 +++++++++++++++++++
 sound/usb/usx2y/us144mkii_playback.c | 108 +++++++++++++++++++++++++++
 6 files changed, 437 insertions(+), 19 deletions(-)
 create mode 100644 sound/usb/usx2y/us144mkii_capture.c
 create mode 100644 sound/usb/usx2y/us144mkii_pcm.c
 create mode 100644 sound/usb/usx2y/us144mkii_pcm.h
 create mode 100644 sound/usb/usx2y/us144mkii_playback.c

diff --git a/sound/usb/usx2y/us144mkii.c b/sound/usb/usx2y/us144mkii.c
index f438f222baec..9b14390efb56 100644
--- a/sound/usb/usx2y/us144mkii.c
+++ b/sound/usb/usx2y/us144mkii.c
@@ -22,7 +22,7 @@ MODULE_LICENSE("GPL");
  *            Defaults to "US144MKII".
  * @param enable: Array of booleans to enable or disable each device.
  *                Defaults to {1, 0, ..., 0} (first device enabled).
- * @param dev_idx: Internal counter for probed TASCAM devices.
+ * @param dev_idx: Internal counter for the number of TASCAM devices probed.
  */
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
@@ -36,7 +36,7 @@ static int tascam_suspend(struct usb_interface *intf, pm_message_t message);
 static int tascam_resume(struct usb_interface *intf);
 
 /**
- * tascam_card_private_free() - Frees private data for the sound card.
+ * tascam_card_private_free() - Frees private data associated with the sound
  * card.
  * @card: Pointer to the ALSA sound card instance.
  *
@@ -58,12 +58,12 @@ static void tascam_card_private_free(struct snd_card *card)
  * @intf: The USB interface being probed.
  * @usb_id: The USB device ID.
  *
- * This function is the entry point for the USB driver on device match.
+ * This function is the entry point for the USB driver when a matching device
  * is found. It performs initial device setup, including:
  * - Checking for the second interface (MIDI) and associating it.
  * - Performing a vendor-specific handshake with the device.
  * - Setting alternate settings for USB interfaces.
- * - Creating and registering the ALSA sound card.
+ * - Creating and registering the ALSA sound card and PCM device.
  *
  * Return: 0 on success, or a negative error code on failure.
  */
@@ -152,6 +152,18 @@ static int tascam_probe(struct usb_interface *intf,
 	tascam->card = card;
 	tascam->iface0 = intf;
 
+	spin_lock_init(&tascam->lock);
+
+	err = snd_pcm_new(card, "US144MKII PCM", 0, 1, 1, &tascam->pcm);
+	if (err < 0)
+		goto free_card;
+	tascam->pcm->private_data = tascam;
+	strscpy(tascam->pcm->name, "US144MKII PCM", sizeof(tascam->pcm->name));
+
+	err = tascam_init_pcm(tascam->pcm);
+	if (err < 0)
+		goto free_card;
+
 	strscpy(card->driver, DRIVER_NAME, sizeof(card->driver));
 	if (dev->descriptor.idProduct == USB_PID_TASCAM_US144) {
 		strscpy(card->shortname, "TASCAM US-144",
diff --git a/sound/usb/usx2y/us144mkii.h b/sound/usb/usx2y/us144mkii.h
index 38731a1285ea..cbfcb062532f 100644
--- a/sound/usb/usx2y/us144mkii.h
+++ b/sound/usb/usx2y/us144mkii.h
@@ -1,38 +1,75 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 // Copyright (c) 2025 Šerif Rami <ramiserifpersia@gmail.com>
 
- #ifndef __US144MKII_H
- #define __US144MKII_H
+#ifndef __US144MKII_H
+#define __US144MKII_H
 
- #include <linux/usb.h>
- #include <sound/core.h>
- #include <sound/initval.h>
+#include <linux/usb.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
 
- #define DRIVER_NAME "us144mkii"
+#define DRIVER_NAME "us144mkii"
 
 /* --- USB Device Identification --- */
- #define USB_VID_TASCAM 0x0644
- #define USB_PID_TASCAM_US144 0x800f
- #define USB_PID_TASCAM_US144MKII 0x8020
+#define USB_VID_TASCAM 0x0644
+#define USB_PID_TASCAM_US144 0x800f
+#define USB_PID_TASCAM_US144MKII 0x8020
+
+/* --- Audio Format Configuration --- */
+#define BYTES_PER_SAMPLE 3
+#define NUM_CHANNELS 4
+#define BYTES_PER_FRAME (NUM_CHANNELS * BYTES_PER_SAMPLE)
 
 /* --- USB Control Message Protocol --- */
- #define RT_D2H_VENDOR_DEV (USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_DEVICE)
- #define VENDOR_REQ_MODE_CONTROL 0x49
- #define MODE_VAL_HANDSHAKE_READ 0x0000
- #define USB_CTRL_TIMEOUT_MS 1000
+#define RT_D2H_VENDOR_DEV (USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
+#define VENDOR_REQ_MODE_CONTROL 0x49
+#define MODE_VAL_HANDSHAKE_READ 0x0000
+#define USB_CTRL_TIMEOUT_MS 1000
+
+struct tascam_card;
+
+#include "us144mkii_pcm.h"
 
 /**
- * struct tascam_card - Driver data structure for TASCAM US-144MKII.
+ * struct tascam_card - Main driver data structure for the TASCAM US-144MKII.
  * @dev: Pointer to the USB device.
  * @iface0: Pointer to USB interface 0 (audio).
  * @iface1: Pointer to USB interface 1 (MIDI).
  * @card: Pointer to the ALSA sound card instance.
+ * @pcm: Pointer to the ALSA PCM device.
+ * @playback_substream: Pointer to the active playback PCM substream.
+ * @capture_substream: Pointer to the active capture PCM substream.
+ * @playback_active: Atomic flag indicating if playback is active.
+ * @capture_active: Atomic flag indicating if capture is active.
+ * @driver_playback_pos: Current position in the ALSA playback buffer (frames).
+ * @driver_capture_pos: Current position in the ALSA capture buffer (frames).
+ * @playback_frames_consumed: Total frames consumed by playback.
+ * @capture_frames_processed: Total frames processed for capture.
+ * @current_rate: Currently configured sample rate of the device.
+ * @lock: Main spinlock for protecting shared driver state.
  */
 struct tascam_card {
 	struct usb_device *dev;
 	struct usb_interface *iface0;
 	struct usb_interface *iface1;
 	struct snd_card *card;
+	struct snd_pcm *pcm;
+
+	struct snd_pcm_substream *playback_substream;
+	struct snd_pcm_substream *capture_substream;
+
+	atomic_t playback_active;
+	atomic_t capture_active;
+
+	snd_pcm_uframes_t driver_playback_pos;
+	snd_pcm_uframes_t driver_capture_pos;
+
+	u64 playback_frames_consumed;
+	u64 capture_frames_processed;
+
+	int current_rate;
+	spinlock_t lock;
 };
 
- #endif /* __US144MKII_H */
+#endif /* __US144MKII_H */
diff --git a/sound/usb/usx2y/us144mkii_capture.c b/sound/usb/usx2y/us144mkii_capture.c
new file mode 100644
index 000000000000..f2ce90743d22
--- /dev/null
+++ b/sound/usb/usx2y/us144mkii_capture.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2025 Šerif Rami <ramiserifpersia@gmail.com>
+
+#include "us144mkii.h"
+
+/**
+ * tascam_capture_open() - Opens the PCM capture substream.
+ * @substream: The ALSA PCM substream to open.
+ *
+ * This function sets the hardware parameters for the capture substream
+ * and stores a reference to the substream in the driver's private data.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_capture_open(struct snd_pcm_substream *substream)
+{
+	struct tascam_card *tascam = snd_pcm_substream_chip(substream);
+
+	substream->runtime->hw = tascam_pcm_hw;
+	tascam->capture_substream = substream;
+	atomic_set(&tascam->capture_active, 0);
+
+	return 0;
+}
+
+/**
+ * tascam_capture_close() - Closes the PCM capture substream.
+ * @substream: The ALSA PCM substream to close.
+ *
+ * This function clears the reference to the capture substream in the
+ * driver's private data.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_capture_close(struct snd_pcm_substream *substream)
+{
+	struct tascam_card *tascam = snd_pcm_substream_chip(substream);
+
+	tascam->capture_substream = NULL;
+
+	return 0;
+}
+
+/**
+ * tascam_capture_prepare() - Prepares the PCM capture substream for use.
+ * @substream: The ALSA PCM substream to prepare.
+ *
+ * This function initializes capture-related counters.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_capture_prepare(struct snd_pcm_substream *substream)
+{
+	struct tascam_card *tascam = snd_pcm_substream_chip(substream);
+
+	tascam->driver_capture_pos = 0;
+	tascam->capture_frames_processed = 0;
+
+	return 0;
+}
+
+/**
+ * tascam_capture_pointer() - Returns the current capture pointer position.
+ * @substream: The ALSA PCM substream.
+ *
+ * This function returns the current position of the capture pointer within
+ * the ALSA ring buffer, in frames.
+ *
+ * Return: The current capture pointer position in frames.
+ */
+static snd_pcm_uframes_t
+tascam_capture_pointer(struct snd_pcm_substream *substream)
+{
+	struct tascam_card *tascam = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	u64 pos;
+
+	if (!atomic_read(&tascam->capture_active))
+		return 0;
+
+	guard(spinlock_irqsave)(&tascam->lock);
+	pos = tascam->capture_frames_processed;
+
+	if (runtime->buffer_size == 0)
+		return 0;
+
+	u64 remainder = do_div(pos, runtime->buffer_size);
+
+	return runtime ? remainder : 0;
+}
+
+/**
+ * tascam_capture_ops - ALSA PCM operations for capture.
+ *
+ * This structure defines the callback functions for capture stream operations,
+ * including open, close, ioctl, hardware parameters, hardware free, prepare,
+ * trigger, and pointer.
+ */
+const struct snd_pcm_ops tascam_capture_ops = {
+	.open = tascam_capture_open,
+	.close = tascam_capture_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = tascam_pcm_hw_params,
+	.hw_free = tascam_pcm_hw_free,
+	.prepare = tascam_capture_prepare,
+	.trigger = tascam_pcm_trigger,
+	.pointer = tascam_capture_pointer,
+};
diff --git a/sound/usb/usx2y/us144mkii_pcm.c b/sound/usb/usx2y/us144mkii_pcm.c
new file mode 100644
index 000000000000..be6f0fa4750b
--- /dev/null
+++ b/sound/usb/usx2y/us144mkii_pcm.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2025 Šerif Rami <ramiserifpersia@gmail.com>
+
+#include "us144mkii.h"
+
+const struct snd_pcm_hardware tascam_pcm_hw = {
+	.info = (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
+		 SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_MMAP_VALID |
+		 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
+	.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+	.rates = (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+		  SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000),
+	.rate_min = 44100,
+	.rate_max = 96000,
+	.channels_min = NUM_CHANNELS,
+	.channels_max = NUM_CHANNELS,
+	.buffer_bytes_max = 1024 * 1024,
+	.period_bytes_min = 48 * BYTES_PER_FRAME,
+	.period_bytes_max = 1024 * BYTES_PER_FRAME,
+	.periods_min = 2,
+	.periods_max = 1024,
+};
+
+int tascam_pcm_hw_params(struct snd_pcm_substream *substream,
+			 struct snd_pcm_hw_params *params)
+{
+	return 0;
+}
+
+int tascam_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	return 0;
+}
+
+int tascam_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct tascam_card *tascam = snd_pcm_substream_chip(substream);
+	int err = 0;
+
+	guard(spinlock_irqsave)(&tascam->lock);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		if (!atomic_read(&tascam->playback_active)) {
+			atomic_set(&tascam->playback_active, 1);
+			atomic_set(&tascam->capture_active, 1);
+		}
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (atomic_read(&tascam->playback_active)) {
+			atomic_set(&tascam->playback_active, 0);
+			atomic_set(&tascam->capture_active, 0);
+		}
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+
+	return err;
+}
+
+int tascam_init_pcm(struct snd_pcm *pcm)
+{
+	struct tascam_card *tascam = pcm->private_data;
+
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &tascam_playback_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &tascam_capture_ops);
+
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
+				       tascam->dev->dev.parent, 64 * 1024,
+				       tascam_pcm_hw.buffer_bytes_max);
+
+	return 0;
+}
diff --git a/sound/usb/usx2y/us144mkii_pcm.h b/sound/usb/usx2y/us144mkii_pcm.h
new file mode 100644
index 000000000000..bb8b51f9b6fb
--- /dev/null
+++ b/sound/usb/usx2y/us144mkii_pcm.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+// Copyright (c) 2025 Šerif Rami <ramiserifpersia@gmail.com>
+
+#ifndef __US144MKII_PCM_H
+#define __US144MKII_PCM_H
+
+#include "us144mkii.h"
+
+/**
+ * tascam_pcm_hw - Hardware capabilities for TASCAM US-144MKII PCM.
+ *
+ * Defines the supported PCM formats, rates, channels, and buffer/period sizes
+ * for the TASCAM US-144MKII audio interface.
+ */
+extern const struct snd_pcm_hardware tascam_pcm_hw;
+
+/**
+ * tascam_playback_ops - ALSA PCM operations for playback.
+ *
+ * This structure defines the callback functions for playback stream operations.
+ */
+extern const struct snd_pcm_ops tascam_playback_ops;
+
+/**
+ * tascam_capture_ops - ALSA PCM operations for capture.
+ *
+ * This structure defines the callback functions for capture stream operations.
+ */
+extern const struct snd_pcm_ops tascam_capture_ops;
+
+/**
+ * tascam_init_pcm() - Initializes the ALSA PCM device.
+ * @pcm: Pointer to the ALSA PCM device to initialize.
+ *
+ * This function sets up the PCM operations and preallocates pages for the
+ * PCM buffer.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int tascam_init_pcm(struct snd_pcm *pcm);
+
+/**
+ * tascam_pcm_hw_params() - Configures hardware parameters for PCM streams.
+ * @substream: The ALSA PCM substream.
+ * @params: The hardware parameters to apply.
+ *
+ * This function is a stub for handling hardware parameter configuration.
+ *
+ * Return: 0 on success.
+ */
+int tascam_pcm_hw_params(struct snd_pcm_substream *substream,
+			 struct snd_pcm_hw_params *params);
+
+/**
+ * tascam_pcm_hw_free() - Frees hardware parameters for PCM streams.
+ * @substream: The ALSA PCM substream.
+ *
+ * This function is a stub for freeing hardware-related resources.
+ *
+ * Return: 0 on success.
+ */
+int tascam_pcm_hw_free(struct snd_pcm_substream *substream);
+
+/**
+ * tascam_pcm_trigger() - Triggers the start or stop of PCM streams.
+ * @substream: The ALSA PCM substream.
+ * @cmd: The trigger command (e.g., SNDRV_PCM_TRIGGER_START).
+ *
+ * This function handles starting and stopping of playback and capture streams
+ * by setting atomic flags.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int tascam_pcm_trigger(struct snd_pcm_substream *substream, int cmd);
+
+#endif /* __US144MKII_PCM_H */
diff --git a/sound/usb/usx2y/us144mkii_playback.c b/sound/usb/usx2y/us144mkii_playback.c
new file mode 100644
index 000000000000..ac582a534123
--- /dev/null
+++ b/sound/usb/usx2y/us144mkii_playback.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2025 Šerif Rami <ramiserifpersia@gmail.com>
+
+#include "us144mkii.h"
+
+/**
+ * tascam_playback_open() - Opens the PCM playback substream.
+ * @substream: The ALSA PCM substream to open.
+ *
+ * This function sets the hardware parameters for the playback substream
+ * and stores a reference to the substream in the driver's private data.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_playback_open(struct snd_pcm_substream *substream)
+{
+	struct tascam_card *tascam = snd_pcm_substream_chip(substream);
+
+	substream->runtime->hw = tascam_pcm_hw;
+	tascam->playback_substream = substream;
+	atomic_set(&tascam->playback_active, 0);
+
+	return 0;
+}
+
+/**
+ * tascam_playback_close() - Closes the PCM playback substream.
+ * @substream: The ALSA PCM substream to close.
+ *
+ * This function clears the reference to the playback substream in the
+ * driver's private data.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_playback_close(struct snd_pcm_substream *substream)
+{
+	struct tascam_card *tascam = snd_pcm_substream_chip(substream);
+
+	tascam->playback_substream = NULL;
+
+	return 0;
+}
+
+/**
+ * tascam_playback_prepare() - Prepares the PCM playback substream for use.
+ * @substream: The ALSA PCM substream to prepare.
+ *
+ * This function initializes playback-related counters.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_playback_prepare(struct snd_pcm_substream *substream)
+{
+	struct tascam_card *tascam = snd_pcm_substream_chip(substream);
+
+	tascam->driver_playback_pos = 0;
+	tascam->playback_frames_consumed = 0;
+
+	return 0;
+}
+
+/**
+ * tascam_playback_pointer() - Returns the current playback pointer position.
+ * @substream: The ALSA PCM substream.
+ *
+ * This function returns the current position of the playback pointer within
+ * the ALSA ring buffer, in frames.
+ *
+ * Return: The current playback pointer position in frames.
+ */
+static snd_pcm_uframes_t
+tascam_playback_pointer(struct snd_pcm_substream *substream)
+{
+	struct tascam_card *tascam = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	u64 pos;
+
+	if (!atomic_read(&tascam->playback_active))
+		return 0;
+
+	guard(spinlock_irqsave)(&tascam->lock);
+	pos = tascam->playback_frames_consumed;
+
+	if (runtime->buffer_size == 0)
+		return 0;
+
+	u64 remainder = do_div(pos, runtime->buffer_size);
+
+	return runtime ? remainder : 0;
+}
+
+/**
+ * tascam_playback_ops - ALSA PCM operations for playback.
+ *
+ * This structure defines the callback functions for playback stream operations,
+ * including open, close, ioctl, hardware parameters, hardware free, prepare,
+ * trigger, and pointer.
+ */
+const struct snd_pcm_ops tascam_playback_ops = {
+	.open = tascam_playback_open,
+	.close = tascam_playback_close,
+	.ioctl = snd_pcm_lib_ioctl,
+	.hw_params = tascam_pcm_hw_params,
+	.hw_free = tascam_pcm_hw_free,
+	.prepare = tascam_playback_prepare,
+	.trigger = tascam_pcm_trigger,
+	.pointer = tascam_playback_pointer,
+};
-- 
2.39.5


