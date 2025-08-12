Return-Path: <linux-kernel+bounces-764827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 160F7B227A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DF03AF40C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFFC27F195;
	Tue, 12 Aug 2025 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OszGWezo"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D0127A107;
	Tue, 12 Aug 2025 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003409; cv=none; b=sE4jgAMt21w4YHBsp85zO/NPKsCBNYyaXFfqpb5pDPcYLivLdnFHIIInQPsvwD7GPeH8PzryB+/s54HHh0qFLcI+vLd6CGrH/+8fPqzySMueuYeqSy4ZZH9tXJoeB+PjP4qavK7EDF0MTtqmGg0STWfBbVUCFHEd54TchHuZgTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003409; c=relaxed/simple;
	bh=fEVl6dr/OTv7oiBvGgjw4LMV8VYApwKCRV0uvvNPm9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWqovJikWEs9AVr3sX5S9bEBEJVUffeVw3b3ZVg2DIs1KYlKHSnWiA4CxsQYff/sSLKSmlYUGXGxPj52Og+Ghr+A3cnzmGo3bsEHQrRvDYeEdQ0lEsrmn9Ua6WQvOkjB6F+CSEqQ9+9AGjq2mIRQ+80T9DmFHkey11/sOLja5lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OszGWezo; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af98b77d2f0so1010648366b.3;
        Tue, 12 Aug 2025 05:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755003405; x=1755608205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg0v+2hv5mjXiI0Fnsf0f/fkTLS5cbrfyLOw8faegMY=;
        b=OszGWezoa8YKKcMikncSd1BnEwMTUtx6sf//udkGdnB50bRRs5szbt3vX3LSnRKZEP
         8NoOlMIQzlHK7rtt4p5aIOs2+HgqUTWfK7dm1cnpKY7rWhDjgqfpTEYS3LXw8TZOZPeQ
         09dAZEOXkEJa/Jbf3V9wDj74s9IF1wSwgpFT3rX4mN1dKXMsywX+g8Clzdb+IJAJ8RiT
         r8NcnSK1NuhvWUv2wuTYh7qTSqm25oSGQkB49iNNdbxNdgQy7ZsvymE4joXhG5r0EEli
         UZHxGUP0GmM/hltrYAo9ahofGVplocOYWHULZujteiaeQSbi5h2COX9uQAhLAhvKbUmB
         O/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003405; x=1755608205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fg0v+2hv5mjXiI0Fnsf0f/fkTLS5cbrfyLOw8faegMY=;
        b=eyUcl4bRTA2EDSvIEjOMX/fiuskpWbDH1kNXjz+IaBcJrXvHx9Vopndvd24AmOUVV6
         wmDual5wikmSM1kSuq+uBYSbVP7t5tjOvJBjfHVYB8VWHqXucYZb0teposSSATFxl6TL
         XLhWRWVkDWI4b7156BA3FHzO+hVBWFLt/Fk0ECEURABTyQGWP/2EHPsfBVqGpJkjIYHk
         RxU1w6jYeVyvP5dTNCyYDfwxDg/zvWUgsNicyAmH2sL8eSTtGmdPl9ZqRb929nPgr4Dk
         OyhoHlfeOBSdQ31rDKfdBCeTh8JZL5Nl5iz87Qug+EH3595gvd44Zcea5uzsBe/mIh1e
         kpaw==
X-Forwarded-Encrypted: i=1; AJvYcCWQZur5QwlJFJSCgrDLAv0XVfTy2IMNNMf5nxFlYWnshH/k5TY4X+M4F4O7hLX5fJFNs3C6f2JpBuanbw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm29hnldkqoXFLy5gac6/FJsAnAu1Mp2cYiCHDGOlJj2hlOP8O
	9qoIm0p7t4iUYw5TpUBlFOyL0iDRzhnnxsSATVOKZ2AXKvGBeTORV+Dt
X-Gm-Gg: ASbGncuwAs90YFXy6/DhqDuOQ5UvYTWL8BJtz3A4u+Fc+2hMILK3SlVIYl+11B2NrHi
	fy/TlNqfxtdmL5J9X8ozvSaniwCe4QSdKN9bDxU9OYnWSE70cZZu+vu4Mbdbe3zPBvrlK+ylsg/
	furbL3bQ5pA3EoD5z9H7R37jI3ZhXpBZpiyw7xcl4D6pA0TYda62YNyWMGEC0ZliYgNIUsj0kRN
	67ulaaYHLO75K7zLCg8jboeNSatSEalgUq0pptdS9CnO9W3gk8CmhSNmUdNlqJeUhctjmPO2uw1
	gzoRCymtTQ14Yf2eP2PswdWFDA3MN2lGJ5B2xRCztbvJn+8yt1DCEj+gIn9bz+KyDIYCBopZKY2
	jePwUUjIKtFWl/h1zpHEefJQMZ1AhbaZh/Hw9O8SpOgyH/2ksV5UHOkQF4+GBiMNGi6sKjT3mZu
	EwPBADrA==
X-Google-Smtp-Source: AGHT+IH4FpzbActkwiCSIa1u3lmCoTream+ryG18f0vT8/a8YyoiLT2zoJE+15kYOYiydXKbaSA4kA==
X-Received: by 2002:a17:907:3d4b:b0:ae0:c441:d54b with SMTP id a640c23a62f3a-af9c63b09a5mr1585867166b.9.1755003404318;
        Tue, 12 Aug 2025 05:56:44 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3361sm2199158266b.39.2025.08.12.05.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:56:43 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v2 4/7] ALSA: usb-audio: us144mkii: Implement audio capture and decoding
Date: Tue, 12 Aug 2025 14:56:28 +0200
Message-Id: <20250812125633.79270-9-ramiserifpersia@gmail.com>
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

This patch adds the full audio capture data path. It allocates and
manages bulk URBs to receive audio data from the device.

The incoming data is in a custom multiplexed format. A workqueue is
used to offload the decoding process from the interrupt context. The
`capture_urb_complete` handler copies raw data into a ring buffer and
schedules the work. The `tascam_capture_work_handler` then reads from
this buffer, decodes the data into standard S32_LE samples, and copies
it to the ALSA capture buffer.

The PCM trigger is updated to manage the submission of capture URBs,
and the feedback handler now also advances the capture stream pointer
to keep it synchronized with playback.

Signed-off-by: Šerif Rami <ramiserifpersia@gmail.com>
---
 sound/usb/usx2y/us144mkii.c         |  73 ++++++++++
 sound/usb/usx2y/us144mkii.h         |  44 +++++-
 sound/usb/usx2y/us144mkii_capture.c | 218 +++++++++++++++++++++++++++-
 sound/usb/usx2y/us144mkii_pcm.c     |  30 ++++
 sound/usb/usx2y/us144mkii_pcm.h     |  35 ++++-
 5 files changed, 392 insertions(+), 8 deletions(-)

diff --git a/sound/usb/usx2y/us144mkii.c b/sound/usb/usx2y/us144mkii.c
index 3a147fba873e..7a114e64fb1f 100644
--- a/sound/usb/usx2y/us144mkii.c
+++ b/sound/usb/usx2y/us144mkii.c
@@ -62,6 +62,27 @@ void tascam_free_urbs(struct tascam_card *tascam)
 			tascam->feedback_urbs[i] = NULL;
 		}
 	}
+
+	usb_kill_anchored_urbs(&tascam->capture_anchor);
+	for (i = 0; i < NUM_CAPTURE_URBS; i++) {
+		if (tascam->capture_urbs[i]) {
+			usb_free_coherent(
+				tascam->dev, tascam->capture_urb_alloc_size,
+				tascam->capture_urbs[i]->transfer_buffer,
+				tascam->capture_urbs[i]->transfer_dma);
+			usb_free_urb(tascam->capture_urbs[i]);
+			tascam->capture_urbs[i] = NULL;
+		}
+	}
+
+	kfree(tascam->capture_routing_buffer);
+	tascam->capture_routing_buffer = NULL;
+	kfree(tascam->capture_decode_dst_block);
+	tascam->capture_decode_dst_block = NULL;
+	kfree(tascam->capture_decode_raw_block);
+	tascam->capture_decode_raw_block = NULL;
+	kfree(tascam->capture_ring_buffer);
+	tascam->capture_ring_buffer = NULL;
 }
 
 int tascam_alloc_urbs(struct tascam_card *tascam)
@@ -121,6 +142,52 @@ int tascam_alloc_urbs(struct tascam_card *tascam)
 		f_urb->complete = feedback_urb_complete;
 	}
 
+	tascam->capture_urb_alloc_size = CAPTURE_URB_SIZE;
+	for (i = 0; i < NUM_CAPTURE_URBS; i++) {
+		struct urb *c_urb = usb_alloc_urb(0, GFP_KERNEL);
+
+		if (!c_urb)
+			goto error;
+		tascam->capture_urbs[i] = c_urb;
+
+		c_urb->transfer_buffer = usb_alloc_coherent(
+			tascam->dev, tascam->capture_urb_alloc_size, GFP_KERNEL,
+			&c_urb->transfer_dma);
+		if (!c_urb->transfer_buffer)
+			goto error;
+
+		usb_fill_bulk_urb(c_urb, tascam->dev,
+				  usb_rcvbulkpipe(tascam->dev, EP_AUDIO_IN),
+				  c_urb->transfer_buffer,
+				  tascam->capture_urb_alloc_size,
+				  capture_urb_complete, tascam);
+		c_urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+	}
+
+	tascam->capture_ring_buffer =
+		kmalloc(CAPTURE_RING_BUFFER_SIZE, GFP_KERNEL);
+	if (!tascam->capture_ring_buffer)
+		goto error;
+
+	tascam->capture_decode_raw_block =
+		kmalloc(RAW_BYTES_PER_DECODE_BLOCK, GFP_KERNEL);
+	if (!tascam->capture_decode_raw_block)
+		goto error;
+
+	tascam->capture_decode_dst_block =
+		kmalloc(FRAMES_PER_DECODE_BLOCK * DECODED_CHANNELS_PER_FRAME *
+				DECODED_SAMPLE_SIZE,
+			GFP_KERNEL);
+	if (!tascam->capture_decode_dst_block)
+		goto error;
+
+	tascam->capture_routing_buffer =
+		kmalloc(FRAMES_PER_DECODE_BLOCK * DECODED_CHANNELS_PER_FRAME *
+				DECODED_SAMPLE_SIZE,
+			GFP_KERNEL);
+	if (!tascam->capture_routing_buffer)
+		goto error;
+
 	return 0;
 
 error:
@@ -136,6 +203,7 @@ void tascam_stop_work_handler(struct work_struct *work)
 
 	usb_kill_anchored_urbs(&tascam->playback_anchor);
 	usb_kill_anchored_urbs(&tascam->feedback_anchor);
+	usb_kill_anchored_urbs(&tascam->capture_anchor);
 	atomic_set(&tascam->active_urbs, 0);
 }
 
@@ -259,10 +327,12 @@ static int tascam_probe(struct usb_interface *intf,
 
 	spin_lock_init(&tascam->lock);
 	init_usb_anchor(&tascam->playback_anchor);
+	init_usb_anchor(&tascam->capture_anchor);
 	init_usb_anchor(&tascam->feedback_anchor);
 
 	INIT_WORK(&tascam->stop_work, tascam_stop_work_handler);
 	INIT_WORK(&tascam->stop_pcm_work, tascam_stop_pcm_work_handler);
+	INIT_WORK(&tascam->capture_work, tascam_capture_work_handler);
 
 	err = snd_pcm_new(card, "US144MKII PCM", 0, 1, 1, &tascam->pcm);
 	if (err < 0)
@@ -326,6 +396,7 @@ static void tascam_disconnect(struct usb_interface *intf)
 	if (intf->cur_altsetting->desc.bInterfaceNumber == 0) {
 		snd_card_disconnect(tascam->card);
 		cancel_work_sync(&tascam->stop_work);
+		cancel_work_sync(&tascam->capture_work);
 		cancel_work_sync(&tascam->stop_pcm_work);
 		tascam_free_urbs(tascam);
 		snd_card_free(tascam->card);
@@ -353,8 +424,10 @@ static int tascam_suspend(struct usb_interface *intf, pm_message_t message)
 	snd_pcm_suspend_all(tascam->pcm);
 
 	cancel_work_sync(&tascam->stop_work);
+	cancel_work_sync(&tascam->capture_work);
 	cancel_work_sync(&tascam->stop_pcm_work);
 	usb_kill_anchored_urbs(&tascam->playback_anchor);
+	usb_kill_anchored_urbs(&tascam->capture_anchor);
 	usb_kill_anchored_urbs(&tascam->feedback_anchor);
 
 	return 0;
diff --git a/sound/usb/usx2y/us144mkii.h b/sound/usb/usx2y/us144mkii.h
index 257ab22dafc1..34b9b275b905 100644
--- a/sound/usb/usx2y/us144mkii.h
+++ b/sound/usb/usx2y/us144mkii.h
@@ -20,14 +20,17 @@
 /* --- USB Endpoints (Alternate Setting 1) --- */
 #define EP_PLAYBACK_FEEDBACK 0x81
 #define EP_AUDIO_OUT 0x02
+#define EP_AUDIO_IN 0x86
 
 /* --- USB Control Message Protocol --- */
 #define RT_H2D_CLASS_EP (USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_ENDPOINT)
+#define RT_D2H_CLASS_EP (USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_ENDPOINT)
 #define RT_D2H_VENDOR_DEV (USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
 #define RT_H2D_VENDOR_DEV (USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
 
 enum uac_request {
 	UAC_SET_CUR = 0x01,
+	UAC_GET_CUR = 0x81,
 };
 
 enum uac_control_selector {
@@ -64,6 +67,9 @@ enum tascam_register {
 #define NUM_FEEDBACK_URBS 4
 #define FEEDBACK_URB_PACKETS 1
 #define FEEDBACK_PACKET_SIZE 3
+#define NUM_CAPTURE_URBS 8
+#define CAPTURE_URB_SIZE 512
+#define CAPTURE_RING_BUFFER_SIZE (CAPTURE_URB_SIZE * NUM_CAPTURE_URBS * 4)
 #define USB_CTRL_TIMEOUT_MS 1000
 #define FEEDBACK_SYNC_LOSS_THRESHOLD 41
 
@@ -73,6 +79,12 @@ enum tascam_register {
 #define BYTES_PER_FRAME (NUM_CHANNELS * BYTES_PER_SAMPLE)
 #define FEEDBACK_ACCUMULATOR_SIZE 128
 
+/* --- Capture Decoding Defines --- */
+#define DECODED_CHANNELS_PER_FRAME 4
+#define DECODED_SAMPLE_SIZE 4
+#define FRAMES_PER_DECODE_BLOCK 8
+#define RAW_BYTES_PER_DECODE_BLOCK 512
+
 struct tascam_card;
 
 #include "us144mkii_pcm.h"
@@ -117,10 +129,19 @@ struct us144mkii_frame_pattern_observer {
  * @last_period_pos: Last reported period position for playback.
  *
  * @capture_substream: Pointer to the active capture PCM substream.
+ * @capture_urbs: Array of URBs for capture.
+ * @capture_urb_alloc_size: Size of allocated buffer for each capture URB.
  * @capture_active: Atomic flag indicating if capture is active.
  * @driver_capture_pos: Current position in the ALSA capture buffer (frames).
  * @capture_frames_processed: Total frames processed for capture.
  * @last_capture_period_pos: Last reported period position for capture.
+ * @capture_ring_buffer: Ring buffer for raw capture data from USB.
+ * @capture_ring_buffer_read_ptr: Read pointer for the capture ring buffer.
+ * @capture_ring_buffer_write_ptr: Write pointer for the capture ring buffer.
+ * @capture_decode_raw_block: Buffer for a raw 512-byte capture block.
+ * @capture_decode_dst_block: Buffer for decoded 32-bit capture samples.
+ * @capture_routing_buffer: Intermediate buffer for capture routing.
+ * @capture_work: Work struct for deferred capture processing.
  *
  * @stop_work: Work struct for deferred stream stopping.
  * @stop_pcm_work: Work struct for stopping PCM due to a fatal error (e.g.
@@ -141,6 +162,7 @@ struct us144mkii_frame_pattern_observer {
  * @fpo: Holds the state for the dynamic feedback pattern generation.
  *
  * @playback_anchor: USB anchor for playback URBs.
+ * @capture_anchor: USB anchor for capture URBs.
  * @feedback_anchor: USB anchor for feedback URBs.
  */
 struct tascam_card {
@@ -160,7 +182,10 @@ struct tascam_card {
 	size_t playback_urb_alloc_size;
 	struct urb *feedback_urbs[NUM_FEEDBACK_URBS];
 	size_t feedback_urb_alloc_size;
+	struct urb *capture_urbs[NUM_CAPTURE_URBS];
+	size_t capture_urb_alloc_size;
 	struct usb_anchor playback_anchor;
+	struct usb_anchor capture_anchor;
 	struct usb_anchor feedback_anchor;
 
 	/* --- Stream State --- */
@@ -179,6 +204,12 @@ struct tascam_card {
 	u64 capture_frames_processed;
 	snd_pcm_uframes_t driver_capture_pos;
 	u64 last_capture_period_pos;
+	u8 *capture_ring_buffer;
+	size_t capture_ring_buffer_read_ptr;
+	size_t capture_ring_buffer_write_ptr;
+	u8 *capture_decode_raw_block;
+	s32 *capture_decode_dst_block;
+	s32 *capture_routing_buffer;
 
 	/* --- Feedback Sync State --- */
 	unsigned int feedback_accumulator_pattern[FEEDBACK_ACCUMULATOR_SIZE];
@@ -192,14 +223,16 @@ struct tascam_card {
 	/* --- Workqueues --- */
 	struct work_struct stop_work;
 	struct work_struct stop_pcm_work;
+	struct work_struct capture_work;
 };
 
 /**
  * tascam_free_urbs() - Free all allocated URBs and associated buffers.
  * @tascam: the tascam_card instance
  *
- * This function kills, unlinks, and frees all playback and feedback URBs,
- * along with their transfer buffers.
+ * This function kills, unlinks, and frees all playback, feedback, and
+ * capture URBs, along with their transfer buffers and the capture
+ * ring/decode buffers.
  */
 void tascam_free_urbs(struct tascam_card *tascam);
 
@@ -207,7 +240,8 @@ void tascam_free_urbs(struct tascam_card *tascam);
  * tascam_alloc_urbs() - Allocate all URBs and associated buffers.
  * @tascam: the tascam_card instance
  *
- * This function allocates and initializes all URBs for playback and feedback.
+ * This function allocates and initializes all URBs for playback, feedback,
+ * and capture, as well as the necessary buffers for data processing.
  *
  * Return: 0 on success, or a negative error code on failure.
  */
@@ -217,8 +251,8 @@ int tascam_alloc_urbs(struct tascam_card *tascam);
  * tascam_stop_work_handler() - Work handler to stop all active streams.
  * @work: Pointer to the work_struct.
  *
- * This function is scheduled to stop all active URBs (playback, feedback)
- * and reset the active_urbs counter.
+ * This function is scheduled to stop all active URBs (playback, feedback,
+ * capture) and reset the active_urbs counter.
  */
 void tascam_stop_work_handler(struct work_struct *work);
 
diff --git a/sound/usb/usx2y/us144mkii_capture.c b/sound/usb/usx2y/us144mkii_capture.c
index 22b8faa9bbe8..68ff07d7e441 100644
--- a/sound/usb/usx2y/us144mkii_capture.c
+++ b/sound/usb/usx2y/us144mkii_capture.c
@@ -45,7 +45,7 @@ static int tascam_capture_close(struct snd_pcm_substream *substream)
  * tascam_capture_prepare() - Prepares the PCM capture substream for use.
  * @substream: The ALSA PCM substream to prepare.
  *
- * This function initializes capture-related counters.
+ * This function initializes capture-related counters and ring buffer pointers.
  *
  * Return: 0 on success.
  */
@@ -56,6 +56,8 @@ static int tascam_capture_prepare(struct snd_pcm_substream *substream)
 	tascam->driver_capture_pos = 0;
 	tascam->capture_frames_processed = 0;
 	tascam->last_capture_period_pos = 0;
+	tascam->capture_ring_buffer_read_ptr = 0;
+	tascam->capture_ring_buffer_write_ptr = 0;
 
 	return 0;
 }
@@ -107,3 +109,217 @@ const struct snd_pcm_ops tascam_capture_ops = {
 	.trigger = tascam_pcm_trigger,
 	.pointer = tascam_capture_pointer,
 };
+
+/**
+ * decode_tascam_capture_block() - Decodes a raw 512-byte block from the device.
+ * @src_block: Pointer to the 512-byte raw source block.
+ * @dst_block: Pointer to the destination buffer for decoded audio frames.
+ *
+ * The device sends audio data in a complex, multiplexed format. This function
+ * demultiplexes the bits from the raw block into 8 frames of 4-channel,
+ * 24-bit audio (stored in 32-bit containers).
+ */
+static void decode_tascam_capture_block(const u8 *src_block, s32 *dst_block)
+{
+	int frame, bit;
+
+	memset(dst_block, 0,
+	       FRAMES_PER_DECODE_BLOCK * DECODED_CHANNELS_PER_FRAME *
+		       DECODED_SAMPLE_SIZE);
+
+	for (frame = 0; frame < FRAMES_PER_DECODE_BLOCK; ++frame) {
+		const u8 *p_src_frame_base = src_block + frame * 64;
+		s32 *p_dst_frame = dst_block + frame * 4;
+
+		s32 ch[4] = { 0 };
+
+		for (bit = 0; bit < 24; ++bit) {
+			u8 byte1 = p_src_frame_base[bit];
+			u8 byte2 = p_src_frame_base[bit + 32];
+
+			ch[0] = (ch[0] << 1) | (byte1 & 1);
+			ch[2] = (ch[2] << 1) | ((byte1 >> 1) & 1);
+
+			ch[1] = (ch[1] << 1) | (byte2 & 1);
+			ch[3] = (ch[3] << 1) | ((byte2 >> 1) & 1);
+		}
+
+		/*
+		 * The result is a 24-bit sample. Shift left by 8 to align it to
+		 * the most significant bits of a 32-bit integer (S32_LE format).
+		 */
+		p_dst_frame[0] = ch[0] << 8;
+		p_dst_frame[1] = ch[1] << 8;
+		p_dst_frame[2] = ch[2] << 8;
+		p_dst_frame[3] = ch[3] << 8;
+	}
+}
+
+void tascam_capture_work_handler(struct work_struct *work)
+{
+	struct tascam_card *tascam =
+		container_of(work, struct tascam_card, capture_work);
+	struct snd_pcm_substream *substream = tascam->capture_substream;
+	struct snd_pcm_runtime *runtime;
+	u8 *raw_block = tascam->capture_decode_raw_block;
+	s32 *decoded_block = tascam->capture_decode_dst_block;
+	s32 *routed_block = tascam->capture_routing_buffer;
+
+	if (!substream || !substream->runtime)
+		return;
+	runtime = substream->runtime;
+
+	if (!raw_block || !decoded_block || !routed_block) {
+		dev_err(tascam->card->dev,
+			"Capture decode/routing buffers not allocated!\n");
+		return;
+	}
+
+	while (atomic_read(&tascam->capture_active)) {
+		size_t write_ptr, read_ptr, available_data;
+		bool can_process;
+
+		{
+			guard(spinlock_irqsave)(&tascam->lock);
+			write_ptr = tascam->capture_ring_buffer_write_ptr;
+			read_ptr = tascam->capture_ring_buffer_read_ptr;
+			available_data = (write_ptr >= read_ptr) ?
+						 (write_ptr - read_ptr) :
+						 (CAPTURE_RING_BUFFER_SIZE -
+						  read_ptr + write_ptr);
+			can_process =
+				(available_data >= RAW_BYTES_PER_DECODE_BLOCK);
+
+			if (can_process) {
+				size_t bytes_to_end =
+					CAPTURE_RING_BUFFER_SIZE - read_ptr;
+				if (bytes_to_end >=
+				    RAW_BYTES_PER_DECODE_BLOCK) {
+					memcpy(raw_block,
+					       tascam->capture_ring_buffer +
+						       read_ptr,
+					       RAW_BYTES_PER_DECODE_BLOCK);
+				} else {
+					memcpy(raw_block,
+					       tascam->capture_ring_buffer +
+						       read_ptr,
+					       bytes_to_end);
+					memcpy(raw_block + bytes_to_end,
+					       tascam->capture_ring_buffer,
+					       RAW_BYTES_PER_DECODE_BLOCK -
+						       bytes_to_end);
+				}
+				tascam->capture_ring_buffer_read_ptr =
+					(read_ptr +
+					 RAW_BYTES_PER_DECODE_BLOCK) %
+					CAPTURE_RING_BUFFER_SIZE;
+			}
+		}
+
+		if (!can_process)
+			break;
+
+		decode_tascam_capture_block(raw_block, decoded_block);
+		process_capture_routing_us144mkii(tascam, decoded_block,
+						  routed_block);
+
+		{
+			guard(spinlock_irqsave)(&tascam->lock);
+			if (atomic_read(&tascam->capture_active)) {
+				int f;
+
+				for (f = 0; f < FRAMES_PER_DECODE_BLOCK; ++f) {
+					u8 *dst_frame_start =
+						runtime->dma_area +
+						frames_to_bytes(
+							runtime,
+							tascam->driver_capture_pos);
+					s32 *routed_frame_start =
+						routed_block +
+						(f * NUM_CHANNELS);
+					int c;
+
+					for (c = 0; c < NUM_CHANNELS; c++) {
+						u8 *dst_channel =
+							dst_frame_start +
+							(c * BYTES_PER_SAMPLE);
+						s32 *src_channel_s32 =
+							routed_frame_start + c;
+
+						memcpy(dst_channel,
+						       ((char *)src_channel_s32) +
+							       1,
+						       3);
+					}
+
+					tascam->driver_capture_pos =
+						(tascam->driver_capture_pos +
+						 1) %
+						runtime->buffer_size;
+				}
+			}
+		}
+	}
+}
+
+void capture_urb_complete(struct urb *urb)
+{
+	struct tascam_card *tascam = urb->context;
+	int ret;
+
+	if (urb->status) {
+		if (urb->status != -ENOENT && urb->status != -ECONNRESET &&
+		    urb->status != -ESHUTDOWN && urb->status != -ENODEV &&
+		    urb->status != -EPROTO)
+			dev_err_ratelimited(tascam->card->dev,
+					    "Capture URB failed: %d\n",
+					    urb->status);
+		goto out;
+	}
+	if (!tascam || !atomic_read(&tascam->capture_active))
+		goto out;
+
+	if (urb->actual_length > 0) {
+		size_t write_ptr;
+		size_t bytes_to_end;
+
+		{
+			guard(spinlock_irqsave)(&tascam->lock);
+			write_ptr = tascam->capture_ring_buffer_write_ptr;
+			bytes_to_end = CAPTURE_RING_BUFFER_SIZE - write_ptr;
+
+			if (urb->actual_length > bytes_to_end) {
+				memcpy(tascam->capture_ring_buffer + write_ptr,
+				       urb->transfer_buffer, bytes_to_end);
+				memcpy(tascam->capture_ring_buffer,
+				       urb->transfer_buffer + bytes_to_end,
+				       urb->actual_length - bytes_to_end);
+			} else {
+				memcpy(tascam->capture_ring_buffer + write_ptr,
+				       urb->transfer_buffer,
+				       urb->actual_length);
+			}
+
+			tascam->capture_ring_buffer_write_ptr =
+				(write_ptr + urb->actual_length) %
+				CAPTURE_RING_BUFFER_SIZE;
+		}
+
+		schedule_work(&tascam->capture_work);
+	}
+
+	usb_get_urb(urb);
+	usb_anchor_urb(urb, &tascam->capture_anchor);
+	ret = usb_submit_urb(urb, GFP_ATOMIC);
+	if (ret < 0) {
+		dev_err_ratelimited(tascam->card->dev,
+				    "Failed to resubmit capture URB: %d\n",
+				    ret);
+		usb_unanchor_urb(urb);
+		usb_put_urb(urb);
+		atomic_dec(
+			&tascam->active_urbs); /* Decrement on failed resubmission */
+	}
+out:
+	usb_put_urb(urb);
+}
diff --git a/sound/usb/usx2y/us144mkii_pcm.c b/sound/usb/usx2y/us144mkii_pcm.c
index 7d1bbd547504..7bee8b4210a6 100644
--- a/sound/usb/usx2y/us144mkii_pcm.c
+++ b/sound/usb/usx2y/us144mkii_pcm.c
@@ -61,6 +61,16 @@ void process_playback_routing_us144mkii(struct tascam_card *tascam,
 		memcpy(dst_buffer, src_buffer, frames * BYTES_PER_FRAME);
 }
 
+void process_capture_routing_us144mkii(struct tascam_card *tascam,
+				       const s32 *decoded_block,
+				       s32 *routed_block)
+{
+	/* This is a stub. Routing will be added in a later commit. */
+	memcpy(routed_block, decoded_block,
+	       FRAMES_PER_DECODE_BLOCK * DECODED_CHANNELS_PER_FRAME *
+		       DECODED_SAMPLE_SIZE);
+}
+
 int us144mkii_configure_device_for_rate(struct tascam_card *tascam, int rate)
 {
 	struct usb_device *dev = tascam->dev;
@@ -110,6 +120,12 @@ int us144mkii_configure_device_for_rate(struct tascam_card *tascam, int rate)
 			      USB_CTRL_TIMEOUT_MS);
 	if (err < 0)
 		goto fail;
+	err = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
+			      RT_H2D_CLASS_EP, UAC_SAMPLING_FREQ_CONTROL,
+			      EP_AUDIO_IN, rate_payload_buf, 3,
+			      USB_CTRL_TIMEOUT_MS);
+	if (err < 0)
+		goto fail;
 	err = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
 			      RT_H2D_CLASS_EP, UAC_SAMPLING_FREQ_CONTROL,
 			      EP_AUDIO_OUT, rate_payload_buf, 3,
@@ -274,6 +290,20 @@ int tascam_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 			}
 			atomic_inc(&tascam->active_urbs);
 		}
+		for (i = 0; i < NUM_CAPTURE_URBS; i++) {
+			usb_get_urb(tascam->capture_urbs[i]);
+			usb_anchor_urb(tascam->capture_urbs[i],
+				       &tascam->capture_anchor);
+			err = usb_submit_urb(tascam->capture_urbs[i],
+					     GFP_ATOMIC);
+			if (err < 0) {
+				usb_unanchor_urb(tascam->capture_urbs[i]);
+				usb_put_urb(tascam->capture_urbs[i]);
+				atomic_dec(&tascam->active_urbs);
+				goto start_rollback;
+			}
+			atomic_inc(&tascam->active_urbs);
+		}
 
 		return 0;
 start_rollback:
diff --git a/sound/usb/usx2y/us144mkii_pcm.h b/sound/usb/usx2y/us144mkii_pcm.h
index 6ca00c3ce53d..74da8564431b 100644
--- a/sound/usb/usx2y/us144mkii_pcm.h
+++ b/sound/usb/usx2y/us144mkii_pcm.h
@@ -51,6 +51,16 @@ void playback_urb_complete(struct urb *urb);
  */
 void feedback_urb_complete(struct urb *urb);
 
+/**
+ * capture_urb_complete() - Completion handler for capture bulk URBs.
+ * @urb: the completed URB
+ *
+ * This function runs in interrupt context. It copies the received raw data
+ * into an intermediate ring buffer and then schedules the workqueue to process
+ * it. It then resubmits the URB to receive more data.
+ */
+void capture_urb_complete(struct urb *urb);
+
 /**
  * tascam_stop_pcm_work_handler() - Work handler to stop PCM streams.
  * @work: Pointer to the work_struct.
@@ -64,8 +74,8 @@ void tascam_stop_pcm_work_handler(struct work_struct *work);
  * tascam_init_pcm() - Initializes the ALSA PCM device.
  * @pcm: Pointer to the ALSA PCM device to initialize.
  *
- * This function sets up the PCM operations and preallocates pages for the
- * PCM buffer.
+ * This function sets up the PCM operations, adds ALSA controls for routing
+ * and sample rate, and preallocates pages for the PCM buffer.
  *
  * Return: 0 on success, or a negative error code on failure.
  */
@@ -94,6 +104,16 @@ void process_playback_routing_us144mkii(struct tascam_card *tascam,
 					const u8 *src_buffer, u8 *dst_buffer,
 					size_t frames);
 
+/**
+ * process_capture_routing_us144mkii() - Apply capture routing matrix
+ * @tascam: The driver instance.
+ * @decoded_block: Buffer containing 4 channels of S32LE decoded audio.
+ * @routed_block: Buffer to be filled for ALSA.
+ */
+void process_capture_routing_us144mkii(struct tascam_card *tascam,
+				       const s32 *decoded_block,
+				       s32 *routed_block);
+
 /**
  * tascam_pcm_hw_params() - Configures hardware parameters for PCM streams.
  * @substream: The ALSA PCM substream.
@@ -131,4 +151,15 @@ int tascam_pcm_hw_free(struct snd_pcm_substream *substream);
  */
 int tascam_pcm_trigger(struct snd_pcm_substream *substream, int cmd);
 
+/**
+ * tascam_capture_work_handler() - Deferred work for processing capture data.
+ * @work: the work_struct instance
+ *
+ * This function runs in a kernel thread context, not an IRQ context. It reads
+ * raw data from the capture ring buffer, decodes it, applies routing, and
+ * copies the final audio data into the ALSA capture ring buffer. This offloads
+ * the CPU-intensive decoding from the time-sensitive URB completion handlers.
+ */
+void tascam_capture_work_handler(struct work_struct *work);
+
 #endif /* __US144MKII_PCM_H */
-- 
2.39.5


