Return-Path: <linux-kernel+bounces-768578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA67B262D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4052CA22EB0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E261F302760;
	Thu, 14 Aug 2025 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFxs89SO"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BC8318129;
	Thu, 14 Aug 2025 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167146; cv=none; b=XkgLMzIlY4kav5Y9tw4MSrl7O5G050jX6dxGPwDHvF0Ukto2QtFEwdMxZ4Yk6KUagEwPTyuDE3OlJL+6AC+IW7IJhtW3lEN+Kh4P5CngEEcclHYW17Hcgkhs0iBkoh1x56bRTCEnNaqth5YI7UzBPzrG3rx96u7RmcmLpSxB5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167146; c=relaxed/simple;
	bh=/CrFbW0Zg3QW+BtKxrns66Ozk1tozaQdO8Vo3LfFSjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyFpsafdfS9B1Wd7VyeE1l3iAqzFiQ9xDBdg59JNcT6mZY8Q746ZAxHTA0ijCRwTXzO2J0tXqYFFFpkRyd3HfjsUicNRNwcjiWWdQScg23/nU1wSZXThV+7Y3NycauV5wW4hvK4/7LjWJfBf6tf6QiGtd0DDqbTVCYEl2Ta0McQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFxs89SO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb72d5409so127383866b.0;
        Thu, 14 Aug 2025 03:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755167141; x=1755771941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tb2cJpFZl7+ZR/GhR5buiXmrwHMEkzJnRAMX3JhMRDA=;
        b=dFxs89SOd7HBWgSPa9heyiDdn4SDIZHf2QrYBHN3OPOmghOZW0CRscKOMWrjkh/CeP
         W2LRDpa+M+kx1cAdgoFVWVlyCgy6UdtSZjW0c+W5y7Re1swx7T9V+uszYEeBe7Hgklp1
         Cv03huQ5C0z+48AdZ6cVRpkIjZLScaa+Z9QHxVGsQT0578mWdmQmLXla5PUzfXWI9/HJ
         aQCVYA5fCk+HL4AX+JgmKGhwiA/8QoJzlpCgpVtksZjJPKfTQXkPsDvgvcFBazYe8btZ
         zhtSdSoDRH3zGHQuJ+gfholflinPwA1h+gv7Z39JWBj3YVAa2dyKaajgE2TDfmIl40EO
         9BJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755167141; x=1755771941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tb2cJpFZl7+ZR/GhR5buiXmrwHMEkzJnRAMX3JhMRDA=;
        b=UXCprCksT9iXmQKuwgRmpRvRtTWi3LDApuvatmRAbqEmwQm5y+c9tE1WGwexr3b5HZ
         OMkZRNYRRyVD/d6QoNGxLKrKPsUUizgBXbeRd1KTCjN1A02o+wPF0qZSmkkimMN9KcOj
         56C8u3fwmc1PafMIZOxNl7VD3Qbsr3Qxcl5El+LPHBp7W3MURBY68hYkwT0ztEs2/1v5
         ByuINL3Xiq7EZQWX7plf7D6/UnIA+M6m4xWNLyiTyD0bhWjI+BT1IvQ8c0/vIR6Bfh4Z
         Lx2QCDcLHJl1WgQSeoCMNvx2dclw/V3lIr/PEdw+6wlQP8z3nqzFYWx/qYY2/Dq2lTXN
         nMKw==
X-Forwarded-Encrypted: i=1; AJvYcCXsuSdSxpeseVlOt1kijIaWaMYFlr95Bo9wNXLXB2FyAREJ2uRIcscaxdCIm0VhMmKF0XzuznIEzFKVgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YylpgdhKLgoEnBhH1yw+N+qvhmu/3Uikp+Rb+ya6K+866s3PxDi
	ZeD0Kva5H9UmQwQMug4Nt9dMhAsQgvG+XFQowlLzCMy7pcj0BImrlmzo
X-Gm-Gg: ASbGncuZ4OrR3ylQWM6EPplFy5wzuPO4FYyCXkSdM4mlMZwMc73FmtfRw786VQRDIVU
	8uyMCgeArk+j0A/2XtLvJdKDoOWMQcV4A7w1qv4rQ7X+nSxeMTgV0o6ciWpdKkOairBoz8/IaNu
	hY4dpbn4Z7GllQO4qL+Ma6eI2OoUa+FHYTDc83FgZxRn002nJhehGilkvCzrg+gkbCVCoyJsOGT
	QM/9aFYTaLQjhgivMJ3Qx2A+t7V/a82HUilp3Sj+HGSIWrB9eVPiBBhf/bAeFipXXUzDUka1VMW
	dApFC0oM1Pmsnk59PQ2tVx81zK4YVgsid9YCfKKpho83/mG/C12Zf8ypb0QnrlQuhYMIHUosM2p
	tsvLkMRyhDkkdMmf83rtmAv7EZzG+TAtDtp4D9nUabXA9VTf0C/ocXWnD65LrThDO7Z26onXzFo
	JwXIdYng==
X-Google-Smtp-Source: AGHT+IFWfvakOwdIiVh8rnz254zkj50ak90TuEdlTaC5q5/b982GWQAWxcO2iAOrrzsF0n7UOLVfJg==
X-Received: by 2002:a17:907:7e90:b0:afc:a18d:f125 with SMTP id a640c23a62f3a-afcb9900ad0mr200337466b.40.1755167140442;
        Thu, 14 Aug 2025 03:25:40 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a219ef2sm2564819466b.96.2025.08.14.03.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:25:39 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v5 3/7] ALSA: usb-audio: us144mkii: Implement audio playback and feedback
Date: Thu, 14 Aug 2025 12:25:30 +0200
Message-Id: <20250814102534.34439-4-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814102534.34439-1-ramiserifpersia@gmail.com>
References: <20250814102534.34439-1-ramiserifpersia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch implements the full audio playback data path. It introduces
the allocation, submission, and completion handling for isochronous
playback and feedback URBs.

The feedback URB completion handler is the core of the driver's clocking
mechanism. It reads the number of samples consumed by the device and
uses a pattern-based algorithm to adjust the size of outgoing playback
packets. This keeps the host and device synchronized and prevents xruns.

The patch also adds the necessary vendor and UAC control messages to
configure the device's sample rate. The PCM trigger is updated to
start and stop the playback and feedback URBs. Basic suspend and resume
handlers are included to manage stream state across power cycles.

Signed-off-by: Šerif Rami <ramiserifpersia@gmail.com>
---
 sound/usb/usx2y/us144mkii.c          | 171 ++++++++++++-
 sound/usb/usx2y/us144mkii.h          | 180 ++++++++++++--
 sound/usb/usx2y/us144mkii_capture.c  |   1 +
 sound/usb/usx2y/us144mkii_pcm.c      | 226 ++++++++++++++++-
 sound/usb/usx2y/us144mkii_pcm.h      |  64 ++++-
 sound/usb/usx2y/us144mkii_playback.c | 352 ++++++++++++++++++++++++++-
 6 files changed, 965 insertions(+), 29 deletions(-)

diff --git a/sound/usb/usx2y/us144mkii.c b/sound/usb/usx2y/us144mkii.c
index 9b14390efb56..3a147fba873e 100644
--- a/sound/usb/usx2y/us144mkii.c
+++ b/sound/usb/usx2y/us144mkii.c
@@ -35,6 +35,110 @@ static void tascam_disconnect(struct usb_interface *intf);
 static int tascam_suspend(struct usb_interface *intf, pm_message_t message);
 static int tascam_resume(struct usb_interface *intf);
 
+void tascam_free_urbs(struct tascam_card *tascam)
+{
+	int i;
+
+	usb_kill_anchored_urbs(&tascam->playback_anchor);
+	for (i = 0; i < NUM_PLAYBACK_URBS; i++) {
+		if (tascam->playback_urbs[i]) {
+			usb_free_coherent(
+				tascam->dev, tascam->playback_urb_alloc_size,
+				tascam->playback_urbs[i]->transfer_buffer,
+				tascam->playback_urbs[i]->transfer_dma);
+			usb_free_urb(tascam->playback_urbs[i]);
+			tascam->playback_urbs[i] = NULL;
+		}
+	}
+
+	usb_kill_anchored_urbs(&tascam->feedback_anchor);
+	for (i = 0; i < NUM_FEEDBACK_URBS; i++) {
+		if (tascam->feedback_urbs[i]) {
+			usb_free_coherent(
+				tascam->dev, tascam->feedback_urb_alloc_size,
+				tascam->feedback_urbs[i]->transfer_buffer,
+				tascam->feedback_urbs[i]->transfer_dma);
+			usb_free_urb(tascam->feedback_urbs[i]);
+			tascam->feedback_urbs[i] = NULL;
+		}
+	}
+}
+
+int tascam_alloc_urbs(struct tascam_card *tascam)
+{
+	int i;
+	size_t max_packet_size;
+
+	max_packet_size = ((96000 / 8000) + 2) * BYTES_PER_FRAME;
+	tascam->playback_urb_alloc_size =
+		max_packet_size * PLAYBACK_URB_PACKETS;
+
+	for (i = 0; i < NUM_PLAYBACK_URBS; i++) {
+		struct urb *urb =
+			usb_alloc_urb(PLAYBACK_URB_PACKETS, GFP_KERNEL);
+
+		if (!urb)
+			goto error;
+		tascam->playback_urbs[i] = urb;
+
+		urb->transfer_buffer = usb_alloc_coherent(
+			tascam->dev, tascam->playback_urb_alloc_size,
+			GFP_KERNEL, &urb->transfer_dma);
+		if (!urb->transfer_buffer)
+			goto error;
+
+		urb->dev = tascam->dev;
+		urb->pipe = usb_sndisocpipe(tascam->dev, EP_AUDIO_OUT);
+		urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
+		urb->interval = 1;
+		urb->context = tascam;
+		urb->complete = playback_urb_complete;
+	}
+
+	tascam->feedback_urb_alloc_size =
+		FEEDBACK_PACKET_SIZE * FEEDBACK_URB_PACKETS;
+
+	for (i = 0; i < NUM_FEEDBACK_URBS; i++) {
+		struct urb *f_urb =
+			usb_alloc_urb(FEEDBACK_URB_PACKETS, GFP_KERNEL);
+
+		if (!f_urb)
+			goto error;
+		tascam->feedback_urbs[i] = f_urb;
+
+		f_urb->transfer_buffer = usb_alloc_coherent(
+			tascam->dev, tascam->feedback_urb_alloc_size,
+			GFP_KERNEL, &f_urb->transfer_dma);
+		if (!f_urb->transfer_buffer)
+			goto error;
+
+		f_urb->dev = tascam->dev;
+		f_urb->pipe =
+			usb_rcvisocpipe(tascam->dev, EP_PLAYBACK_FEEDBACK);
+		f_urb->transfer_flags = URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
+		f_urb->interval = 4;
+		f_urb->context = tascam;
+		f_urb->complete = feedback_urb_complete;
+	}
+
+	return 0;
+
+error:
+	dev_err(tascam->card->dev, "Failed to allocate URBs\n");
+	tascam_free_urbs(tascam);
+	return -ENOMEM;
+}
+
+void tascam_stop_work_handler(struct work_struct *work)
+{
+	struct tascam_card *tascam =
+		container_of(work, struct tascam_card, stop_work);
+
+	usb_kill_anchored_urbs(&tascam->playback_anchor);
+	usb_kill_anchored_urbs(&tascam->feedback_anchor);
+	atomic_set(&tascam->active_urbs, 0);
+}
+
 /**
  * tascam_card_private_free() - Frees private data associated with the sound
  * card.
@@ -64,6 +168,7 @@ static void tascam_card_private_free(struct snd_card *card)
  * - Performing a vendor-specific handshake with the device.
  * - Setting alternate settings for USB interfaces.
  * - Creating and registering the ALSA sound card and PCM device.
+ * - Allocating and initializing URBs for audio transfers.
  *
  * Return: 0 on success, or a negative error code on failure.
  */
@@ -153,6 +258,11 @@ static int tascam_probe(struct usb_interface *intf,
 	tascam->iface0 = intf;
 
 	spin_lock_init(&tascam->lock);
+	init_usb_anchor(&tascam->playback_anchor);
+	init_usb_anchor(&tascam->feedback_anchor);
+
+	INIT_WORK(&tascam->stop_work, tascam_stop_work_handler);
+	INIT_WORK(&tascam->stop_pcm_work, tascam_stop_pcm_work_handler);
 
 	err = snd_pcm_new(card, "US144MKII PCM", 0, 1, 1, &tascam->pcm);
 	if (err < 0)
@@ -164,6 +274,10 @@ static int tascam_probe(struct usb_interface *intf,
 	if (err < 0)
 		goto free_card;
 
+	err = tascam_alloc_urbs(tascam);
+	if (err < 0)
+		goto free_card;
+
 	strscpy(card->driver, DRIVER_NAME, sizeof(card->driver));
 	if (dev->descriptor.idProduct == USB_PID_TASCAM_US144) {
 		strscpy(card->shortname, "TASCAM US-144",
@@ -189,6 +303,7 @@ static int tascam_probe(struct usb_interface *intf,
 	return 0;
 
 free_card:
+	tascam_free_urbs(tascam);
 	snd_card_free(card);
 	return err;
 }
@@ -198,7 +313,8 @@ static int tascam_probe(struct usb_interface *intf,
  * @intf: The USB interface being disconnected.
  *
  * This function is called when the device is disconnected from the system.
- * It cleans up all allocated resources by freeing the sound card.
+ * It cleans up all allocated resources by freeing the sound card, which in
+ * turn triggers freeing of URBs and other resources.
  */
 static void tascam_disconnect(struct usb_interface *intf)
 {
@@ -209,6 +325,9 @@ static void tascam_disconnect(struct usb_interface *intf)
 
 	if (intf->cur_altsetting->desc.bInterfaceNumber == 0) {
 		snd_card_disconnect(tascam->card);
+		cancel_work_sync(&tascam->stop_work);
+		cancel_work_sync(&tascam->stop_pcm_work);
+		tascam_free_urbs(tascam);
 		snd_card_free(tascam->card);
 		dev_idx--;
 	}
@@ -219,12 +338,25 @@ static void tascam_disconnect(struct usb_interface *intf)
  * @intf: The USB interface being suspended.
  * @message: Power management message.
  *
- * This function is a stub for handling device suspension.
+ * This function is called when the device is suspended. It stops all active
+ * streams and kills all URBs.
  *
  * Return: 0 on success.
  */
 static int tascam_suspend(struct usb_interface *intf, pm_message_t message)
 {
+	struct tascam_card *tascam = usb_get_intfdata(intf);
+
+	if (!tascam)
+		return 0;
+
+	snd_pcm_suspend_all(tascam->pcm);
+
+	cancel_work_sync(&tascam->stop_work);
+	cancel_work_sync(&tascam->stop_pcm_work);
+	usb_kill_anchored_urbs(&tascam->playback_anchor);
+	usb_kill_anchored_urbs(&tascam->feedback_anchor);
+
 	return 0;
 }
 
@@ -232,12 +364,43 @@ static int tascam_suspend(struct usb_interface *intf, pm_message_t message)
  * tascam_resume() - Handles device resumption from suspend.
  * @intf: The USB interface being resumed.
  *
- * This function is a stub for handling device resumption.
+ * This function is called when the device resumes from suspend. It
+ * re-establishes the active USB interface settings and re-configures the sample
+ * rate if it was previously active.
  *
- * Return: 0 on success.
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int tascam_resume(struct usb_interface *intf)
 {
+	struct tascam_card *tascam = usb_get_intfdata(intf);
+	int err;
+
+	if (!tascam)
+		return 0;
+
+	dev_info(&intf->dev, "resuming TASCAM US-144MKII\n");
+
+	/* Re-establish the active USB interface settings. */
+	err = usb_set_interface(tascam->dev, 0, 1);
+	if (err < 0) {
+		dev_err(&intf->dev,
+			"resume: failed to set alt setting on intf 0: %d\n",
+			err);
+		return err;
+	}
+	err = usb_set_interface(tascam->dev, 1, 1);
+	if (err < 0) {
+		dev_err(&intf->dev,
+			"resume: failed to set alt setting on intf 1: %d\n",
+			err);
+		return err;
+	}
+
+	/* Re-configure the sample rate if one was previously active */
+	if (tascam->current_rate > 0)
+		us144mkii_configure_device_for_rate(tascam,
+						    tascam->current_rate);
+
 	return 0;
 }
 
diff --git a/sound/usb/usx2y/us144mkii.h b/sound/usb/usx2y/us144mkii.h
index 44f3b44bbf3b..53a74178e373 100644
--- a/sound/usb/usx2y/us144mkii.h
+++ b/sound/usb/usx2y/us144mkii.h
@@ -5,6 +5,7 @@
 #define __US144MKII_H
 
 #include <linux/usb.h>
+#include <linux/workqueue.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 
@@ -15,27 +16,87 @@
 #define USB_PID_TASCAM_US144 0x800f
 #define USB_PID_TASCAM_US144MKII 0x8020
 
+/* --- USB Endpoints (Alternate Setting 1) --- */
+#define EP_PLAYBACK_FEEDBACK 0x81
+#define EP_AUDIO_OUT 0x02
+
 /* --- USB Control Message Protocol --- */
-#define RT_D2H_VENDOR_DEV (USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_DEVICE)
-#define VENDOR_REQ_MODE_CONTROL 0x49
-#define MODE_VAL_HANDSHAKE_READ 0x0000
+#define RT_H2D_CLASS_EP (USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_ENDPOINT)
+#define RT_D2H_VENDOR_DEV (USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
+#define RT_H2D_VENDOR_DEV (USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
+
+enum uac_request {
+	UAC_SET_CUR = 0x01,
+};
+
+enum uac_control_selector {
+	UAC_SAMPLING_FREQ_CONTROL = 0x0100,
+};
+
+enum tascam_vendor_request {
+	VENDOR_REQ_REGISTER_WRITE = 0x41,
+	VENDOR_REQ_MODE_CONTROL = 0x49,
+};
+
+enum tascam_mode_value {
+	MODE_VAL_HANDSHAKE_READ = 0x0000,
+	MODE_VAL_CONFIG = 0x0010,
+	MODE_VAL_STREAM_START = 0x0030,
+};
+
+enum tascam_register {
+	REG_ADDR_UNKNOWN_0D = 0x0d04,
+	REG_ADDR_UNKNOWN_0E = 0x0e00,
+	REG_ADDR_UNKNOWN_0F = 0x0f00,
+	REG_ADDR_RATE_44100 = 0x1000,
+	REG_ADDR_RATE_48000 = 0x1002,
+	REG_ADDR_RATE_88200 = 0x1008,
+	REG_ADDR_RATE_96000 = 0x100a,
+	REG_ADDR_UNKNOWN_11 = 0x110b,
+};
+
+#define REG_VAL_ENABLE 0x0101
+
+/* --- URB Configuration --- */
+#define NUM_PLAYBACK_URBS 4
+#define PLAYBACK_URB_PACKETS 8
+#define NUM_FEEDBACK_URBS 4
+#define FEEDBACK_URB_PACKETS 1
+#define FEEDBACK_PACKET_SIZE 3
 #define USB_CTRL_TIMEOUT_MS 1000
+#define FEEDBACK_SYNC_LOSS_THRESHOLD 41
 
 /* --- Audio Format Configuration --- */
 #define BYTES_PER_SAMPLE 3
 #define NUM_CHANNELS 4
 #define BYTES_PER_FRAME (NUM_CHANNELS * BYTES_PER_SAMPLE)
-
-/* --- USB Control Message Protocol --- */
-#define RT_D2H_VENDOR_DEV (USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
-#define VENDOR_REQ_MODE_CONTROL 0x49
-#define MODE_VAL_HANDSHAKE_READ 0x0000
-#define USB_CTRL_TIMEOUT_MS 1000
+#define FEEDBACK_ACCUMULATOR_SIZE 128
 
 struct tascam_card;
 
 #include "us144mkii_pcm.h"
 
+/**
+ * struct us144mkii_frame_pattern_observer - State for dynamic feedback
+ * patterns.
+ * @sample_rate_khz: The current sample rate in kHz.
+ * @base_feedback_value: The nominal feedback value for the current rate.
+ * @feedback_offset: An offset to align the feedback value range.
+ * @full_frame_patterns: A 2D array of pre-calculated packet size patterns.
+ * @current_index: The current index into the pattern array.
+ * @previous_index: The previous index, used for state tracking.
+ * @sync_locked: A flag indicating if the pattern has locked to the stream.
+ */
+struct us144mkii_frame_pattern_observer {
+	unsigned int sample_rate_khz;
+	unsigned int base_feedback_value;
+	int feedback_offset;
+	unsigned int full_frame_patterns[5][8];
+	unsigned int current_index;
+	unsigned int previous_index;
+	bool sync_locked;
+};
+
 /**
  * struct tascam_card - Main driver data structure for the TASCAM US-144MKII.
  * @dev: Pointer to the USB device.
@@ -43,38 +104,121 @@ struct tascam_card;
  * @iface1: Pointer to USB interface 1 (MIDI).
  * @card: Pointer to the ALSA sound card instance.
  * @pcm: Pointer to the ALSA PCM device.
+ *
  * @playback_substream: Pointer to the active playback PCM substream.
- * @capture_substream: Pointer to the active capture PCM substream.
+ * @playback_urbs: Array of URBs for playback.
+ * @playback_urb_alloc_size: Size of allocated buffer for each playback URB.
+ * @feedback_urbs: Array of URBs for feedback.
+ * @feedback_urb_alloc_size: Size of allocated buffer for each feedback URB.
  * @playback_active: Atomic flag indicating if playback is active.
- * @capture_active: Atomic flag indicating if capture is active.
+ * @playback_frames_consumed: Total frames consumed by playback.
  * @driver_playback_pos: Current position in the ALSA playback buffer (frames).
+ * @last_period_pos: Last reported period position for playback.
+ *
+ * @capture_substream: Pointer to the active capture PCM substream.
+ * @capture_active: Atomic flag indicating if capture is active.
  * @driver_capture_pos: Current position in the ALSA capture buffer (frames).
- * @playback_frames_consumed: Total frames consumed by playback.
  * @capture_frames_processed: Total frames processed for capture.
- * @current_rate: Currently configured sample rate of the device.
+ * @last_capture_period_pos: Last reported period position for capture.
+ *
+ * @stop_work: Work struct for deferred stream stopping.
+ * @stop_pcm_work: Work struct for stopping PCM due to a fatal error (e.g.
+ * xrun).
+ *
  * @lock: Main spinlock for protecting shared driver state.
+ * @active_urbs: Atomic counter for active URBs.
+ * @current_rate: Currently configured sample rate of the device.
+ *
+ * @feedback_accumulator_pattern: Stores the calculated frames per packet for
+ * feedback.
+ * @feedback_pattern_out_idx: Read index for feedback_accumulator_pattern.
+ * @feedback_pattern_in_idx: Write index for feedback_accumulator_pattern.
+ * @feedback_synced: Flag indicating if feedback is synced.
+ * @feedback_consecutive_errors: Counter for consecutive feedback errors.
+ * @feedback_urb_skip_count: Number of feedback URBs to skip initially for
+ * stabilization.
+ * @fpo: Holds the state for the dynamic feedback pattern generation.
+ *
+ * @playback_anchor: USB anchor for playback URBs.
+ * @feedback_anchor: USB anchor for feedback URBs.
  */
 struct tascam_card {
+	/* --- Core device pointers --- */
 	struct usb_device *dev;
 	struct usb_interface *iface0;
 	struct usb_interface *iface1;
 	struct snd_card *card;
 	struct snd_pcm *pcm;
 
+	/* --- PCM Substreams --- */
 	struct snd_pcm_substream *playback_substream;
 	struct snd_pcm_substream *capture_substream;
 
+	/* --- URBs and Anchors --- */
+	struct urb *playback_urbs[NUM_PLAYBACK_URBS];
+	size_t playback_urb_alloc_size;
+	struct urb *feedback_urbs[NUM_FEEDBACK_URBS];
+	size_t feedback_urb_alloc_size;
+	struct usb_anchor playback_anchor;
+	struct usb_anchor feedback_anchor;
+
+	/* --- Stream State --- */
+	spinlock_t lock;
 	atomic_t playback_active;
 	atomic_t capture_active;
+	atomic_t active_urbs;
+	int current_rate;
 
+	/* --- Playback State --- */
+	u64 playback_frames_consumed;
 	snd_pcm_uframes_t driver_playback_pos;
-	snd_pcm_uframes_t driver_capture_pos;
+	u64 last_period_pos;
 
-	u64 playback_frames_consumed;
+	/* --- Capture State --- */
 	u64 capture_frames_processed;
-
-	int current_rate;
-	spinlock_t lock;
+	snd_pcm_uframes_t driver_capture_pos;
+	u64 last_capture_period_pos;
+
+	/* --- Feedback Sync State --- */
+	unsigned int feedback_accumulator_pattern[FEEDBACK_ACCUMULATOR_SIZE];
+	unsigned int feedback_pattern_out_idx;
+	unsigned int feedback_pattern_in_idx;
+	bool feedback_synced;
+	unsigned int feedback_consecutive_errors;
+	unsigned int feedback_urb_skip_count;
+	struct us144mkii_frame_pattern_observer fpo;
+
+	/* --- Workqueues --- */
+	struct work_struct stop_work;
+	struct work_struct stop_pcm_work;
 };
 
+/**
+ * tascam_free_urbs() - Free all allocated URBs and associated buffers.
+ * @tascam: the tascam_card instance
+ *
+ * This function kills, unlinks, and frees all playback and feedback URBs,
+ * along with their transfer buffers.
+ */
+void tascam_free_urbs(struct tascam_card *tascam);
+
+/**
+ * tascam_alloc_urbs() - Allocate all URBs and associated buffers.
+ * @tascam: the tascam_card instance
+ *
+ * This function allocates and initializes all URBs for playback and feedback.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int tascam_alloc_urbs(struct tascam_card *tascam);
+
+/**
+ * tascam_stop_work_handler() - Work handler to stop all active streams.
+ * @work: Pointer to the work_struct.
+ *
+ * This function is scheduled to stop all active URBs (playback, feedback)
+ * and reset the active_urbs counter.
+ */
+void tascam_stop_work_handler(struct work_struct *work);
+
 #endif /* __US144MKII_H */
diff --git a/sound/usb/usx2y/us144mkii_capture.c b/sound/usb/usx2y/us144mkii_capture.c
index 9239229716c7..75e8518c4910 100644
--- a/sound/usb/usx2y/us144mkii_capture.c
+++ b/sound/usb/usx2y/us144mkii_capture.c
@@ -55,6 +55,7 @@ static int tascam_capture_prepare(struct snd_pcm_substream *substream)
 
 	tascam->driver_capture_pos = 0;
 	tascam->capture_frames_processed = 0;
+	tascam->last_capture_period_pos = 0;
 
 	return 0;
 }
diff --git a/sound/usb/usx2y/us144mkii_pcm.c b/sound/usb/usx2y/us144mkii_pcm.c
index 9d1704f2b82e..423c775051ad 100644
--- a/sound/usb/usx2y/us144mkii_pcm.c
+++ b/sound/usb/usx2y/us144mkii_pcm.c
@@ -3,6 +3,37 @@
 
 #include "us144mkii.h"
 
+/**
+ * fpo_init_pattern() - Generates a packet distribution pattern.
+ * @size: The number of elements in the pattern array (e.g., 8).
+ * @pattern_array: Pointer to the array to be populated.
+ * @initial_value: The base value to initialize each element with.
+ * @target_sum: The desired sum of all elements in the final array.
+ *
+ * This function initializes an array with a base value and then iteratively
+ * adjusts the elements to match a target sum, distributing the difference
+ * as evenly as possible.
+ */
+static void fpo_init_pattern(unsigned int size, unsigned int *pattern_array,
+	unsigned int initial_value, int target_sum)
+{
+	int diff, i;
+
+	if (!size)
+		return;
+
+	for (i = 0; i < size; ++i)
+		pattern_array[i] = initial_value;
+
+	diff = target_sum - (size * initial_value);
+	for (i = 0; i < abs(diff); ++i) {
+		if (diff > 0)
+			pattern_array[i]++;
+		else
+			pattern_array[i]--;
+	}
+}
+
 const struct snd_pcm_hardware tascam_pcm_hw = {
 	.info = (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
 		 SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_MMAP_VALID |
@@ -21,9 +52,148 @@ const struct snd_pcm_hardware tascam_pcm_hw = {
 	.periods_max = 1024,
 };
 
+void process_playback_routing_us144mkii(struct tascam_card *tascam,
+					const u8 *src_buffer, u8 *dst_buffer,
+					size_t frames)
+{
+	/* This is a stub. Routing will be added in a later commit. */
+	if (src_buffer != dst_buffer)
+		memcpy(dst_buffer, src_buffer, frames * BYTES_PER_FRAME);
+}
+
+int us144mkii_configure_device_for_rate(struct tascam_card *tascam, int rate)
+{
+	struct usb_device *dev = tascam->dev;
+	u8 *rate_payload_buf __free(kfree) = NULL;
+	u16 rate_vendor_wValue;
+	int err = 0;
+	const u8 *current_payload_src;
+
+	static const u8 payload_44100[] = { 0x44, 0xac, 0x00 };
+	static const u8 payload_48000[] = { 0x80, 0xbb, 0x00 };
+	static const u8 payload_88200[] = { 0x88, 0x58, 0x01 };
+	static const u8 payload_96000[] = { 0x00, 0x77, 0x01 };
+
+	switch (rate) {
+	case 44100:
+		current_payload_src = payload_44100;
+		rate_vendor_wValue = REG_ADDR_RATE_44100;
+		break;
+	case 48000:
+		current_payload_src = payload_48000;
+		rate_vendor_wValue = REG_ADDR_RATE_48000;
+		break;
+	case 88200:
+		current_payload_src = payload_88200;
+		rate_vendor_wValue = REG_ADDR_RATE_88200;
+		break;
+	case 96000:
+		current_payload_src = payload_96000;
+		rate_vendor_wValue = REG_ADDR_RATE_96000;
+		break;
+	default:
+		dev_err(&dev->dev,
+			"Unsupported sample rate %d for configuration\n", rate);
+		return -EINVAL;
+	}
+
+	rate_payload_buf = kmemdup(current_payload_src, 3, GFP_KERNEL);
+	if (!rate_payload_buf)
+		return -ENOMEM;
+
+	dev_info(&dev->dev, "Configuring device for %d Hz\n", rate);
+
+	err = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+			      VENDOR_REQ_MODE_CONTROL, RT_H2D_VENDOR_DEV,
+			      MODE_VAL_CONFIG, 0x0000, NULL, 0,
+			      USB_CTRL_TIMEOUT_MS);
+	if (err < 0)
+		goto fail;
+	err = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
+			      RT_H2D_CLASS_EP, UAC_SAMPLING_FREQ_CONTROL,
+			      EP_AUDIO_OUT, rate_payload_buf, 3,
+			      USB_CTRL_TIMEOUT_MS);
+	if (err < 0)
+		goto fail;
+	err = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+			      VENDOR_REQ_REGISTER_WRITE, RT_H2D_VENDOR_DEV,
+			      REG_ADDR_UNKNOWN_0D, REG_VAL_ENABLE, NULL, 0,
+			      USB_CTRL_TIMEOUT_MS);
+	if (err < 0)
+		goto fail;
+	err = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+			      VENDOR_REQ_REGISTER_WRITE, RT_H2D_VENDOR_DEV,
+			      REG_ADDR_UNKNOWN_0E, REG_VAL_ENABLE, NULL, 0,
+			      USB_CTRL_TIMEOUT_MS);
+	if (err < 0)
+		goto fail;
+	err = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+			      VENDOR_REQ_REGISTER_WRITE, RT_H2D_VENDOR_DEV,
+			      REG_ADDR_UNKNOWN_0F, REG_VAL_ENABLE, NULL, 0,
+			      USB_CTRL_TIMEOUT_MS);
+	if (err < 0)
+		goto fail;
+	err = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+			      VENDOR_REQ_REGISTER_WRITE, RT_H2D_VENDOR_DEV,
+			      rate_vendor_wValue, REG_VAL_ENABLE, NULL, 0,
+			      USB_CTRL_TIMEOUT_MS);
+	if (err < 0)
+		goto fail;
+	err = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+			      VENDOR_REQ_REGISTER_WRITE, RT_H2D_VENDOR_DEV,
+			      REG_ADDR_UNKNOWN_11, REG_VAL_ENABLE, NULL, 0,
+			      USB_CTRL_TIMEOUT_MS);
+	if (err < 0)
+		goto fail;
+	err = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
+			      VENDOR_REQ_MODE_CONTROL, RT_H2D_VENDOR_DEV,
+			      MODE_VAL_STREAM_START, 0x0000, NULL, 0,
+			      USB_CTRL_TIMEOUT_MS);
+	if (err < 0)
+		goto fail;
+	return 0;
+
+fail:
+	dev_err(&dev->dev,
+		"Device configuration failed at rate %d with error %d\n", rate,
+		err);
+	return err;
+}
+
 int tascam_pcm_hw_params(struct snd_pcm_substream *substream,
-			 struct snd_pcm_hw_params *params)
+					 struct snd_pcm_hw_params *params)
 {
+	struct tascam_card *tascam = snd_pcm_substream_chip(substream);
+	int err;
+	unsigned int rate = params_rate(params);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		tascam->fpo.sample_rate_khz = rate / 1000;
+		tascam->fpo.base_feedback_value = tascam->fpo.sample_rate_khz;
+		tascam->fpo.feedback_offset = 2;
+		tascam->fpo.current_index = 0;
+		tascam->fpo.previous_index = 0;
+		tascam->fpo.sync_locked = false;
+
+		unsigned int initial_value = tascam->fpo.sample_rate_khz / 8;
+
+		for (int i = 0; i < 5; i++) {
+			int target_sum = tascam->fpo.sample_rate_khz -
+					 tascam->fpo.feedback_offset + i;
+			fpo_init_pattern(8, tascam->fpo.full_frame_patterns[i],
+					       initial_value, target_sum);
+		}
+	}
+
+	if (tascam->current_rate != rate) {
+		err = us144mkii_configure_device_for_rate(tascam, rate);
+		if (err < 0) {
+			tascam->current_rate = 0;
+			return err;
+		}
+		tascam->current_rate = rate;
+	}
+
 	return 0;
 }
 
@@ -36,15 +206,18 @@ int tascam_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct tascam_card *tascam = snd_pcm_substream_chip(substream);
 	int err = 0;
+	int i;
+	bool do_start = false;
+	bool do_stop = false;
 
-	scoped_guard(spinlock_irqsave, &tascam->lock)
-	{
+	scoped_guard(spinlock_irqsave, &tascam->lock) {
 		switch (cmd) {
 		case SNDRV_PCM_TRIGGER_START:
 		case SNDRV_PCM_TRIGGER_RESUME:
 			if (!atomic_read(&tascam->playback_active)) {
 				atomic_set(&tascam->playback_active, 1);
 				atomic_set(&tascam->capture_active, 1);
+				do_start = true;
 			}
 			break;
 		case SNDRV_PCM_TRIGGER_STOP:
@@ -53,6 +226,7 @@ int tascam_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 			if (atomic_read(&tascam->playback_active)) {
 				atomic_set(&tascam->playback_active, 0);
 				atomic_set(&tascam->capture_active, 0);
+				do_stop = true;
 			}
 			break;
 		default:
@@ -61,6 +235,52 @@ int tascam_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		}
 	}
 
+	if (do_start) {
+		if (atomic_read(&tascam->active_urbs) > 0) {
+			dev_warn(tascam->card->dev,
+				 "Cannot start, URBs still active.\n");
+			return -EAGAIN;
+		}
+
+		for (i = 0; i < NUM_FEEDBACK_URBS; i++) {
+			usb_get_urb(tascam->feedback_urbs[i]);
+			usb_anchor_urb(tascam->feedback_urbs[i],
+					       &tascam->feedback_anchor);
+			err = usb_submit_urb(tascam->feedback_urbs[i],
+						     GFP_ATOMIC);
+			if (err < 0) {
+				usb_unanchor_urb(tascam->feedback_urbs[i]);
+				usb_put_urb(tascam->feedback_urbs[i]);
+				atomic_dec(&tascam->active_urbs);
+				goto start_rollback;
+			}
+			atomic_inc(&tascam->active_urbs);
+		}
+		for (i = 0; i < NUM_PLAYBACK_URBS; i++) {
+			usb_get_urb(tascam->playback_urbs[i]);
+			usb_anchor_urb(tascam->playback_urbs[i],
+					       &tascam->playback_anchor);
+			err = usb_submit_urb(tascam->playback_urbs[i],
+						     GFP_ATOMIC);
+			if (err < 0) {
+				usb_unanchor_urb(tascam->playback_urbs[i]);
+				usb_put_urb(tascam->playback_urbs[i]);
+				atomic_dec(&tascam->active_urbs);
+				goto start_rollback;
+			}
+			atomic_inc(&tascam->active_urbs);
+		}
+
+		return 0;
+start_rollback:
+		dev_err(tascam->card->dev,
+			"Failed to submit URBs to start stream: %d\n", err);
+		do_stop = true;
+	}
+
+	if (do_stop)
+		schedule_work(&tascam->stop_work);
+
 	return err;
 }
 
diff --git a/sound/usb/usx2y/us144mkii_pcm.h b/sound/usb/usx2y/us144mkii_pcm.h
index bb8b51f9b6fb..6ca00c3ce53d 100644
--- a/sound/usb/usx2y/us144mkii_pcm.h
+++ b/sound/usb/usx2y/us144mkii_pcm.h
@@ -28,6 +28,38 @@ extern const struct snd_pcm_ops tascam_playback_ops;
  */
 extern const struct snd_pcm_ops tascam_capture_ops;
 
+/**
+ * playback_urb_complete() - Completion handler for playback isochronous URBs.
+ * @urb: the completed URB
+ *
+ * This function runs in interrupt context. It calculates the number of bytes
+ * to send in the next set of packets based on the feedback-driven clock,
+ * copies the audio data from the ALSA ring buffer, and resubmits the URB.
+ */
+void playback_urb_complete(struct urb *urb);
+
+/**
+ * feedback_urb_complete() - Completion handler for feedback isochronous URBs.
+ * @urb: the completed URB
+ *
+ * This is the master clock for the driver. It runs in interrupt context.
+ * It reads the feedback value from the device, which indicates how many
+ * samples the device has consumed. This information is used to adjust the
+ * playback rate and to advance the capture stream pointer, keeping both
+ * streams in sync. It then calls snd_pcm_period_elapsed if necessary and
+ * resubmits itself.
+ */
+void feedback_urb_complete(struct urb *urb);
+
+/**
+ * tascam_stop_pcm_work_handler() - Work handler to stop PCM streams.
+ * @work: Pointer to the work_struct.
+ *
+ * This function is scheduled to stop PCM streams (playback and capture)
+ * from a workqueue context, avoiding blocking operations in interrupt context.
+ */
+void tascam_stop_pcm_work_handler(struct work_struct *work);
+
 /**
  * tascam_init_pcm() - Initializes the ALSA PCM device.
  * @pcm: Pointer to the ALSA PCM device to initialize.
@@ -39,14 +71,40 @@ extern const struct snd_pcm_ops tascam_capture_ops;
  */
 int tascam_init_pcm(struct snd_pcm *pcm);
 
+/**
+ * us144mkii_configure_device_for_rate() - Set sample rate via USB control msgs
+ * @tascam: the tascam_card instance
+ * @rate: the target sample rate (e.g., 44100, 96000)
+ *
+ * This function sends a sequence of vendor-specific and UAC control messages
+ * to configure the device hardware for the specified sample rate.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int us144mkii_configure_device_for_rate(struct tascam_card *tascam, int rate);
+
+/**
+ * process_playback_routing_us144mkii() - Apply playback routing matrix
+ * @tascam: The driver instance.
+ * @src_buffer: Buffer containing 4 channels of S24_3LE audio from ALSA.
+ * @dst_buffer: Buffer to be filled for the USB device.
+ * @frames: Number of frames to process.
+ */
+void process_playback_routing_us144mkii(struct tascam_card *tascam,
+					const u8 *src_buffer, u8 *dst_buffer,
+					size_t frames);
+
 /**
  * tascam_pcm_hw_params() - Configures hardware parameters for PCM streams.
  * @substream: The ALSA PCM substream.
  * @params: The hardware parameters to apply.
  *
- * This function is a stub for handling hardware parameter configuration.
+ * This function allocates pages for the PCM buffer and, for playback streams,
+ * selects the appropriate feedback patterns based on the requested sample rate.
+ * It also configures the device hardware for the selected sample rate if it
+ * has changed.
  *
- * Return: 0 on success.
+ * Return: 0 on success, or a negative error code on failure.
  */
 int tascam_pcm_hw_params(struct snd_pcm_substream *substream,
 			 struct snd_pcm_hw_params *params);
@@ -67,7 +125,7 @@ int tascam_pcm_hw_free(struct snd_pcm_substream *substream);
  * @cmd: The trigger command (e.g., SNDRV_PCM_TRIGGER_START).
  *
  * This function handles starting and stopping of playback and capture streams
- * by setting atomic flags.
+ * by submitting or killing the associated URBs.
  *
  * Return: 0 on success, or a negative error code on failure.
  */
diff --git a/sound/usb/usx2y/us144mkii_playback.c b/sound/usb/usx2y/us144mkii_playback.c
index 3c22d86e47dc..d18314f65ec3 100644
--- a/sound/usb/usx2y/us144mkii_playback.c
+++ b/sound/usb/usx2y/us144mkii_playback.c
@@ -45,16 +45,65 @@ static int tascam_playback_close(struct snd_pcm_substream *substream)
  * tascam_playback_prepare() - Prepares the PCM playback substream for use.
  * @substream: The ALSA PCM substream to prepare.
  *
- * This function initializes playback-related counters.
+ * This function initializes playback-related counters and flags, and configures
+ * the playback URBs with appropriate packet sizes based on the nominal frame
+ * rate.
  *
  * Return: 0 on success.
  */
 static int tascam_playback_prepare(struct snd_pcm_substream *substream)
 {
 	struct tascam_card *tascam = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int i, u;
+	size_t nominal_frames_per_packet, nominal_bytes_per_packet;
+	size_t total_bytes_in_urb;
 
 	tascam->driver_playback_pos = 0;
 	tascam->playback_frames_consumed = 0;
+	tascam->last_period_pos = 0;
+	tascam->feedback_pattern_in_idx = 0;
+	tascam->feedback_pattern_out_idx = 0;
+	tascam->feedback_synced = false;
+	tascam->feedback_consecutive_errors = 0;
+	tascam->feedback_urb_skip_count = NUM_FEEDBACK_URBS;
+
+	nominal_frames_per_packet = runtime->rate / 8000;
+	for (i = 0; i < FEEDBACK_ACCUMULATOR_SIZE; i++)
+		tascam->feedback_accumulator_pattern[i] =
+			nominal_frames_per_packet;
+
+	for (i = 0; i < NUM_FEEDBACK_URBS; i++) {
+		struct urb *f_urb = tascam->feedback_urbs[i];
+		int j;
+
+		f_urb->number_of_packets = FEEDBACK_URB_PACKETS;
+		f_urb->transfer_buffer_length =
+			FEEDBACK_URB_PACKETS * FEEDBACK_PACKET_SIZE;
+		for (j = 0; j < FEEDBACK_URB_PACKETS; j++) {
+			f_urb->iso_frame_desc[j].offset =
+				j * FEEDBACK_PACKET_SIZE;
+			f_urb->iso_frame_desc[j].length = FEEDBACK_PACKET_SIZE;
+		}
+	}
+
+	nominal_bytes_per_packet = nominal_frames_per_packet * BYTES_PER_FRAME;
+	total_bytes_in_urb = nominal_bytes_per_packet * PLAYBACK_URB_PACKETS;
+
+	for (u = 0; u < NUM_PLAYBACK_URBS; u++) {
+		struct urb *urb = tascam->playback_urbs[u];
+
+		memset(urb->transfer_buffer, 0,
+		       tascam->playback_urb_alloc_size);
+		urb->transfer_buffer_length = total_bytes_in_urb;
+		urb->number_of_packets = PLAYBACK_URB_PACKETS;
+		for (i = 0; i < PLAYBACK_URB_PACKETS; i++) {
+			urb->iso_frame_desc[i].offset =
+				i * nominal_bytes_per_packet;
+			urb->iso_frame_desc[i].length =
+				nominal_bytes_per_packet;
+		}
+	}
 
 	return 0;
 }
@@ -106,3 +155,304 @@ const struct snd_pcm_ops tascam_playback_ops = {
 	.trigger = tascam_pcm_trigger,
 	.pointer = tascam_playback_pointer,
 };
+
+void playback_urb_complete(struct urb *urb)
+{
+	struct tascam_card *tascam = urb->context;
+	struct snd_pcm_substream *substream;
+	struct snd_pcm_runtime *runtime;
+	size_t total_bytes_for_urb = 0;
+	snd_pcm_uframes_t offset_frames;
+	snd_pcm_uframes_t frames_to_copy;
+	int ret, i;
+
+	if (urb->status) {
+		if (urb->status != -ENOENT && urb->status != -ECONNRESET &&
+		    urb->status != -ESHUTDOWN && urb->status != -ENODEV)
+			dev_err_ratelimited(tascam->card->dev,
+					    "Playback URB failed: %d\n",
+					    urb->status);
+		goto out;
+	}
+	if (!tascam || !atomic_read(&tascam->playback_active))
+		goto out;
+
+	substream = tascam->playback_substream;
+	if (!substream || !substream->runtime)
+		goto out;
+	runtime = substream->runtime;
+
+	scoped_guard(spinlock_irqsave, &tascam->lock) {
+		for (i = 0; i < urb->number_of_packets; i++) {
+			unsigned int frames_for_packet;
+			size_t bytes_for_packet;
+
+			if (tascam->feedback_synced) {
+				frames_for_packet =
+					tascam->feedback_accumulator_pattern
+						[tascam->feedback_pattern_out_idx];
+				tascam->feedback_pattern_out_idx =
+					(tascam->feedback_pattern_out_idx + 1) %
+					FEEDBACK_ACCUMULATOR_SIZE;
+			} else {
+				frames_for_packet = runtime->rate / 8000;
+			}
+			bytes_for_packet = frames_for_packet * BYTES_PER_FRAME;
+
+			urb->iso_frame_desc[i].offset = total_bytes_for_urb;
+			urb->iso_frame_desc[i].length = bytes_for_packet;
+			total_bytes_for_urb += bytes_for_packet;
+		}
+		urb->transfer_buffer_length = total_bytes_for_urb;
+
+		offset_frames = tascam->driver_playback_pos;
+		frames_to_copy = bytes_to_frames(runtime, total_bytes_for_urb);
+		tascam->driver_playback_pos =
+			(offset_frames + frames_to_copy) % runtime->buffer_size;
+	}
+
+	if (total_bytes_for_urb > 0) {
+		u8 *dst_buf = urb->transfer_buffer;
+
+		/* Handle ring buffer wrap-around */
+		if (offset_frames + frames_to_copy > runtime->buffer_size) {
+			size_t first_chunk_bytes = frames_to_bytes(
+				runtime, runtime->buffer_size - offset_frames);
+			size_t second_chunk_bytes =
+				total_bytes_for_urb - first_chunk_bytes;
+
+			memcpy(dst_buf,
+			       runtime->dma_area +
+				       frames_to_bytes(runtime, offset_frames),
+			       first_chunk_bytes);
+			memcpy(dst_buf + first_chunk_bytes, runtime->dma_area,
+			       second_chunk_bytes);
+		} else {
+			memcpy(dst_buf,
+			       runtime->dma_area +
+				       frames_to_bytes(runtime, offset_frames),
+			       total_bytes_for_urb);
+		}
+
+		process_playback_routing_us144mkii(tascam, dst_buf, dst_buf,
+						   frames_to_copy);
+	}
+
+	urb->dev = tascam->dev;
+	usb_get_urb(urb);
+	usb_anchor_urb(urb, &tascam->playback_anchor);
+	ret = usb_submit_urb(urb, GFP_ATOMIC);
+	if (ret < 0) {
+		dev_err_ratelimited(tascam->card->dev,
+				    "Failed to resubmit playback URB: %d\n",
+				    ret);
+		usb_unanchor_urb(urb);
+		usb_put_urb(urb);
+		atomic_dec(
+			&tascam->active_urbs); /* Decrement on failed resubmission */
+	}
+out:
+	usb_put_urb(urb);
+}
+
+void feedback_urb_complete(struct urb *urb)
+{
+	struct tascam_card *tascam = urb->context;
+	struct snd_pcm_substream *playback_ss, *capture_ss;
+	struct snd_pcm_runtime *playback_rt, *capture_rt;
+	u64 total_frames_in_urb = 0;
+	int ret, p;
+	unsigned int old_in_idx, new_in_idx;
+	bool playback_period_elapsed = false;
+	bool capture_period_elapsed = false;
+
+	if (urb->status) {
+		if (urb->status != -ENOENT && urb->status != -ECONNRESET &&
+		    urb->status != -ESHUTDOWN && urb->status != -ENODEV) {
+			dev_err_ratelimited(tascam->card->dev,
+					    "Feedback URB failed: %d\n",
+					    urb->status);
+			atomic_dec(
+				&tascam->active_urbs); /* Decrement on failed resubmission */
+		}
+		goto out;
+	}
+	if (!tascam || !atomic_read(&tascam->playback_active))
+		goto out;
+
+	playback_ss = tascam->playback_substream;
+	if (!playback_ss || !playback_ss->runtime)
+		goto out;
+	playback_rt = playback_ss->runtime;
+
+	capture_ss = tascam->capture_substream;
+	capture_rt = capture_ss ? capture_ss->runtime : NULL;
+
+	scoped_guard(spinlock_irqsave, &tascam->lock)
+	{
+		if (tascam->feedback_urb_skip_count > 0) {
+			tascam->feedback_urb_skip_count--;
+			break;
+		}
+
+		old_in_idx = tascam->feedback_pattern_in_idx;
+
+		for (p = 0; p < urb->number_of_packets; p++) {
+			u8 feedback_value = 0;
+			const unsigned int *pattern;
+			bool packet_ok =
+				(urb->iso_frame_desc[p].status == 0 &&
+				 urb->iso_frame_desc[p].actual_length >= 1);
+
+			if (packet_ok)
+				feedback_value =
+					*((u8 *)urb->transfer_buffer +
+					  urb->iso_frame_desc[p].offset);
+
+			if (packet_ok) {
+				int delta = feedback_value -
+						    tascam->fpo.base_feedback_value +
+						    tascam->fpo.feedback_offset;
+				int pattern_idx;
+
+				if (delta < 0) {
+					pattern_idx =
+						0; // Clamp to the lowest pattern
+				} else if (delta >= 5) {
+					pattern_idx =
+						4; // Clamp to the highest pattern
+				} else {
+					pattern_idx = delta;
+				}
+
+				pattern =
+					tascam->fpo
+						.full_frame_patterns[pattern_idx];
+				tascam->feedback_consecutive_errors = 0;
+				int i;
+
+				for (i = 0; i < 8; i++) {
+					unsigned int in_idx =
+						(tascam->feedback_pattern_in_idx +
+						 i) %
+						FEEDBACK_ACCUMULATOR_SIZE;
+
+					tascam->feedback_accumulator_pattern
+						[in_idx] = pattern[i];
+					total_frames_in_urb += pattern[i];
+				}
+			} else {
+				unsigned int nominal_frames =
+					playback_rt->rate / 8000;
+				int i;
+
+				if (tascam->feedback_synced) {
+					tascam->feedback_consecutive_errors++;
+					if (tascam->feedback_consecutive_errors >
+					    FEEDBACK_SYNC_LOSS_THRESHOLD) {
+						dev_err(tascam->card->dev,
+							"Fatal: Feedback sync lost. Stopping stream.\n");
+						schedule_work(
+								&tascam->stop_pcm_work);
+						tascam->feedback_synced = false;
+						break;
+					}
+				}
+				for (i = 0; i < 8; i++) {
+					unsigned int in_idx =
+						(tascam->feedback_pattern_in_idx +
+						 i) %
+						FEEDBACK_ACCUMULATOR_SIZE;
+
+					tascam->feedback_accumulator_pattern
+						[in_idx] = nominal_frames;
+					total_frames_in_urb += nominal_frames;
+				}
+			}
+			tascam->feedback_pattern_in_idx =
+				(tascam->feedback_pattern_in_idx + 8) %
+				FEEDBACK_ACCUMULATOR_SIZE;
+		}
+
+		new_in_idx = tascam->feedback_pattern_in_idx;
+
+		if (!tascam->feedback_synced) {
+			unsigned int out_idx = tascam->feedback_pattern_out_idx;
+			bool is_ahead = (new_in_idx - out_idx) %
+						FEEDBACK_ACCUMULATOR_SIZE <
+					(FEEDBACK_ACCUMULATOR_SIZE / 2);
+			bool was_behind = (old_in_idx - out_idx) %
+						FEEDBACK_ACCUMULATOR_SIZE >=
+					(FEEDBACK_ACCUMULATOR_SIZE / 2);
+
+			if (is_ahead && was_behind) {
+				dev_dbg(tascam->card->dev,
+					"Sync Acquired! (in: %u, out: %u)\n",
+					new_in_idx, out_idx);
+				tascam->feedback_synced = true;
+				tascam->feedback_consecutive_errors = 0;
+			}
+		}
+
+		if (total_frames_in_urb > 0) {
+			tascam->playback_frames_consumed += total_frames_in_urb;
+			if (atomic_read(&tascam->capture_active))
+				tascam->capture_frames_processed +=
+					total_frames_in_urb;
+		}
+
+		if (playback_rt->period_size > 0) {
+			u64 current_period =
+				div_u64(tascam->playback_frames_consumed,
+						playback_rt->period_size);
+
+			if (current_period > tascam->last_period_pos) {
+				tascam->last_period_pos = current_period;
+				playback_period_elapsed = true;
+			}
+		}
+
+		if (atomic_read(&tascam->capture_active) && capture_rt &&
+		    capture_rt->period_size > 0) {
+			u64 current_capture_period =
+				div_u64(tascam->capture_frames_processed,
+						capture_rt->period_size);
+
+			if (current_capture_period >
+			    tascam->last_capture_period_pos) {
+				tascam->last_capture_period_pos =
+					current_capture_period;
+				capture_period_elapsed = true;
+			}
+		}
+	}
+	if (playback_period_elapsed)
+		snd_pcm_period_elapsed(playback_ss);
+	if (capture_period_elapsed)
+		snd_pcm_period_elapsed(capture_ss);
+
+	urb->dev = tascam->dev;
+	usb_get_urb(urb);
+	usb_anchor_urb(urb, &tascam->feedback_anchor);
+	ret = usb_submit_urb(urb, GFP_ATOMIC);
+	if (ret < 0) {
+		dev_err_ratelimited(tascam->card->dev,
+				    "Failed to resubmit feedback URB: %d\n",
+				    ret);
+		usb_unanchor_urb(urb);
+		usb_put_urb(urb);
+	}
+out:
+	usb_put_urb(urb);
+}
+
+void tascam_stop_pcm_work_handler(struct work_struct *work)
+{
+	struct tascam_card *tascam =
+		container_of(work, struct tascam_card, stop_pcm_work);
+
+	if (tascam->playback_substream)
+		snd_pcm_stop(tascam->playback_substream, SNDRV_PCM_STATE_XRUN);
+	if (tascam->capture_substream)
+		snd_pcm_stop(tascam->capture_substream, SNDRV_PCM_STATE_XRUN);
+}
-- 
2.39.5


