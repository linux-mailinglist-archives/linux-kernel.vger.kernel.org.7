Return-Path: <linux-kernel+bounces-761433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 405ADB1FA01
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 14:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8998E189B270
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 12:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A455E267B02;
	Sun, 10 Aug 2025 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzQSLWTq"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B1325A651;
	Sun, 10 Aug 2025 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754830212; cv=none; b=IEVpWRfe7Gw2nxUspmT6kSsUkCfNGJyjG3dPwreJW4UMa4ln28B9UJH3R9rer+Zygn5OVzAlWStm88i4taV2c/XGGv+9W+XVR3JnEkHh/0PPhz+l0qNnmcYI6NCwRf4XVhw+JQzQcT3VbaA6t3AGL7fnTKT2jCJaT2d0sNgq53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754830212; c=relaxed/simple;
	bh=xC5Bj4/BLWCWJ4ehyQmgVC/9KRBmCrfJb7GtFEmb1BA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4MVbDjKFR0D3Igr+2M3bKIzS5sZ2Hhk7NnFDAF+SPe8xXGDCQHRhi696zAfh/RgCb1fiWs1sWuPmnG+NuEFsPrrHJbt7K4iAhDcgiwT83hFvvcCxNpTTFDdZraZk038xQXtRwHmWQmNal8a6hQpwZW+jh6hjJwey2TRpFijVLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzQSLWTq; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-615c29fc31eso6760790a12.0;
        Sun, 10 Aug 2025 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754830207; x=1755435007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTPFwwUQmJNqBrwT4Mdl3LPTrc4zYP2kZYedJxtZo1Q=;
        b=FzQSLWTq3EXOTCKcNj3dw+nazv361jqmU3R25M92qaoWc+wSuYqN5Tq+zYSuIxh+V4
         71KlRFVo3R+aea8yvCL5exN182vZ6/RlQR0LLw3f0qX09aUDkgQJNBu0BNx+kQC3yoNy
         o+9Yuaw/KvSWgkCjkFzxKstj64FzPXvNEuQtRU3R7ZN7IzYAVCGb6G8z95tkwn2Qw844
         Ga6ufKHvo/fv4DiFxGMImrzkIxfUmVrnuat1ZIJqwSq6KO8t8yeVK4NH8wvsFp7Gi2CV
         GHQgk4Xj/bdjonrC7aT3hAaE70ivpf5DY+nGH32yhHlW6RPLUryVazmzAh0jTpgXQ95U
         bYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754830207; x=1755435007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTPFwwUQmJNqBrwT4Mdl3LPTrc4zYP2kZYedJxtZo1Q=;
        b=C0/VhpXzqsrfK0nTc5TEwmVKI9j1Ba71XyVsh3zb5wd1vQ7IHzWLmP/TgvvvVh2fNq
         iyR1m7yFLCkqNQoJyMSBghKGTdNqn4eAYk9JQ3ik5zq1zbi/5mngYN9CtC1zt9ji23Rj
         G9FWxrQlr7eWaQh/gi7PFM/ES4ZHQ5fnSsdOIV8TttxZciQrvlf0LBRznUlyNa37bM8D
         nYVNfTeYzYpVkjwio+p1O2V046+lDhqQ9JKc1I36GqggEbkWVq/MX0vAZC65kfewHMkc
         J/i0ctMzgOsTC1p9V+fOJ4Gxp6jiNPfd+8b80NKsBSaLF3cV16JOeRRaxlmRPlLXuv/5
         SQkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5HcHp2SS90tMTTm4OE8hVe9MGAAChrBvUqiHefVLfmwzcQOLDlb7MgR4IEz/Lru4glCWzP+yS92mOzhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaxyvz5AquWKCi+jCjIamj+PXEozC3ucTjJw61Wnffao6I+SO7
	3fDMz6YUHBq8KMRmzMC20AoimMqCSJp+zbgGYbcHzYrpD1NfpufJCe9V
X-Gm-Gg: ASbGncurZh96ZUtEekFFpvUUsOwjg/XWLFlaHE4j+sFpSrr9dzOhfECgl2jtuwqCuW4
	vHWjQTdgzRW/UINa8VGfb2lnMuyTSaL8SkO0NxCmqJs7BzXAbrDfMRniZP48+Xqq4X9qRMoEj/h
	94qpdebM3oj5/ziVV77ech7WOiQR4Wlu9iuTrBczek60zQnRIk3H6qfHwRb8AV+CLNOPen81vs+
	nnr285IR7JlVJ+8ml7oBT622i4KqRVanoAIXBD1qf1VPXZQN1pU6/K9lJr11rIu+Lei3zDrX0x8
	ima9oG5vA0CfTT4Lp0SQgLE+ZhNyshvJLqs/lDtoP9Cq7AuCEfei46tWCLjcbRflwkD0n4BNzfV
	G/HrJKzCDJnfW6h7YBaQ151ZY0KziQoBNQW7Yu1+8LccS6uQYeRwR4cxMzRDmwX+NhFaHasN9a2
	3say2mFQ==
X-Google-Smtp-Source: AGHT+IGD18Xo+BJkvd0ZyxQxMp0NAWfB+iAyGpbdKTulls1FbdGL7lbLW5J/Kb2TVCBPlAHPk5NKHQ==
X-Received: by 2002:a05:6402:50c6:b0:617:b2aa:576a with SMTP id 4fb4d7f45d1cf-617e2b70dd6mr7979013a12.3.1754830206786;
        Sun, 10 Aug 2025 05:50:06 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffbdb4sm16636594a12.52.2025.08.10.05.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:50:06 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH 5/7] ALSA: usb-audio: us144mkii: Add MIDI support and mixer controls
Date: Sun, 10 Aug 2025 14:49:56 +0200
Message-Id: <20250810124958.25309-6-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250810124958.25309-1-ramiserifpersia@gmail.com>
References: <20250810124958.25309-1-ramiserifpersia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds the remaining features to the driver: MIDI I/O and
ALSA mixer controls.

A raw MIDI device is created, supporting one input and one output port.
The implementation handles the device-specific 9-byte packet format for
both sending and receiving MIDI data, using bulk URBs and workqueues for
processing.

ALSA kcontrols are added to the mixer interface, allowing user-space
control over the audio routing matrix (e.g., selecting analog/digital
sources for capture channels, and routing playback streams to different
outputs). A read-only control to display the current sample rate is
also included.

Finally, the stub routing functions are replaced with the full logic
to apply the user-selected mixer settings to the audio streams.

With this commit, the driver is feature-complete.

Signed-off-by: Šerif Rami <ramiserifpersia@gmail.com>
---
 sound/usb/usx2y/us144mkii.c          | 307 +++++++++++++-------
 sound/usb/usx2y/us144mkii.h          | 125 +++++++-
 sound/usb/usx2y/us144mkii_controls.c | 414 +++++++++++++++++++++++++++
 sound/usb/usx2y/us144mkii_midi.c     | 401 ++++++++++++++++++++++++++
 sound/usb/usx2y/us144mkii_pcm.c      |  55 +++-
 5 files changed, 1188 insertions(+), 114 deletions(-)
 create mode 100644 sound/usb/usx2y/us144mkii_controls.c
 create mode 100644 sound/usb/usx2y/us144mkii_midi.c

diff --git a/sound/usb/usx2y/us144mkii.c b/sound/usb/usx2y/us144mkii.c
index 47c3888880a4..a225963c50d2 100644
--- a/sound/usb/usx2y/us144mkii.c
+++ b/sound/usb/usx2y/us144mkii.c
@@ -75,6 +75,30 @@ void tascam_free_urbs(struct tascam_card *tascam)
 		}
 	}
 
+	usb_kill_anchored_urbs(&tascam->midi_in_anchor);
+	for (i = 0; i < NUM_MIDI_IN_URBS; i++) {
+		if (tascam->midi_in_urbs[i]) {
+			usb_free_coherent(
+				tascam->dev, MIDI_IN_BUF_SIZE,
+				tascam->midi_in_urbs[i]->transfer_buffer,
+				tascam->midi_in_urbs[i]->transfer_dma);
+			usb_free_urb(tascam->midi_in_urbs[i]);
+			tascam->midi_in_urbs[i] = NULL;
+		}
+	}
+
+	usb_kill_anchored_urbs(&tascam->midi_out_anchor);
+	for (i = 0; i < NUM_MIDI_OUT_URBS; i++) {
+		if (tascam->midi_out_urbs[i]) {
+			usb_free_coherent(
+				tascam->dev, MIDI_OUT_BUF_SIZE,
+				tascam->midi_out_urbs[i]->transfer_buffer,
+				tascam->midi_out_urbs[i]->transfer_dma);
+			usb_free_urb(tascam->midi_out_urbs[i]);
+			tascam->midi_out_urbs[i] = NULL;
+		}
+	}
+
 	kfree(tascam->capture_routing_buffer);
 	tascam->capture_routing_buffer = NULL;
 	kfree(tascam->capture_decode_dst_block);
@@ -164,6 +188,44 @@ int tascam_alloc_urbs(struct tascam_card *tascam)
 		c_urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 	}
 
+	/* MIDI URB and buffer allocation */
+	for (i = 0; i < NUM_MIDI_IN_URBS; i++) {
+		struct urb *m_urb = usb_alloc_urb(0, GFP_KERNEL);
+
+		if (!m_urb)
+			goto error;
+		tascam->midi_in_urbs[i] = m_urb;
+		m_urb->transfer_buffer =
+			usb_alloc_coherent(tascam->dev, MIDI_IN_BUF_SIZE,
+					   GFP_KERNEL, &m_urb->transfer_dma);
+		if (!m_urb->transfer_buffer)
+			goto error;
+		usb_fill_bulk_urb(m_urb, tascam->dev,
+				  usb_rcvbulkpipe(tascam->dev, EP_MIDI_IN),
+				  m_urb->transfer_buffer, MIDI_IN_BUF_SIZE,
+				  tascam_midi_in_urb_complete, tascam);
+		m_urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+	}
+
+	for (i = 0; i < NUM_MIDI_OUT_URBS; i++) {
+		struct urb *m_urb = usb_alloc_urb(0, GFP_KERNEL);
+
+		if (!m_urb)
+			goto error;
+		tascam->midi_out_urbs[i] = m_urb;
+		m_urb->transfer_buffer =
+			usb_alloc_coherent(tascam->dev, MIDI_OUT_BUF_SIZE,
+					   GFP_KERNEL, &m_urb->transfer_dma);
+		if (!m_urb->transfer_buffer)
+			goto error;
+		usb_fill_bulk_urb(m_urb, tascam->dev,
+				  usb_sndbulkpipe(tascam->dev, EP_MIDI_OUT),
+				  m_urb->transfer_buffer,
+				  0, /* length set later */
+				  tascam_midi_out_urb_complete, tascam);
+		m_urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+	}
+
 	tascam->capture_ring_buffer =
 		kmalloc(CAPTURE_RING_BUFFER_SIZE, GFP_KERNEL);
 	if (!tascam->capture_ring_buffer)
@@ -213,16 +275,112 @@ void tascam_stop_work_handler(struct work_struct *work)
  * @card: Pointer to the ALSA sound card instance.
  *
  * This function is called when the sound card is being freed. It releases
- * the reference to the USB device.
+ * resources allocated for the tascam_card structure, including the MIDI
+ * input FIFO and decrements the USB device reference count.
  */
 static void tascam_card_private_free(struct snd_card *card)
 {
 	struct tascam_card *tascam = card->private_data;
 
-	if (tascam && tascam->dev) {
-		usb_put_dev(tascam->dev);
-		tascam->dev = NULL;
+	if (tascam) {
+		kfifo_free(&tascam->midi_in_fifo);
+		if (tascam->dev) {
+			usb_put_dev(tascam->dev);
+			tascam->dev = NULL;
+		}
+	}
+}
+
+/**
+ * tascam_suspend() - Handles device suspension.
+ * @intf: The USB interface being suspended.
+ * @message: Power management message.
+ *
+ * This function is called when the device is suspended. It stops all active
+ * streams, kills all URBs, and sends a vendor-specific deep sleep command
+ * to the device to ensure a stable low-power state.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct tascam_card *tascam = usb_get_intfdata(intf);
+
+	if (!tascam)
+		return 0;
+
+	snd_pcm_suspend_all(tascam->pcm);
+
+	cancel_work_sync(&tascam->stop_work);
+	cancel_work_sync(&tascam->capture_work);
+	cancel_work_sync(&tascam->midi_in_work);
+	cancel_work_sync(&tascam->midi_out_work);
+	cancel_work_sync(&tascam->stop_pcm_work);
+	usb_kill_anchored_urbs(&tascam->playback_anchor);
+	usb_kill_anchored_urbs(&tascam->capture_anchor);
+	usb_kill_anchored_urbs(&tascam->feedback_anchor);
+	usb_kill_anchored_urbs(&tascam->midi_in_anchor);
+	usb_kill_anchored_urbs(&tascam->midi_out_anchor);
+
+	return 0;
+}
+
+/**
+ * tascam_resume() - Handles device resumption from suspend.
+ * @intf: The USB interface being resumed.
+ *
+ * This function is called when the device resumes from suspend. It
+ * re-establishes the active USB interface settings and re-configures the sample
+ * rate if it was previously active.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int tascam_resume(struct usb_interface *intf)
+{
+	struct tascam_card *tascam = usb_get_intfdata(intf);
+	int err;
+
+	if (!tascam)
+		return 0;
+
+	dev_info(&intf->dev, "resuming TASCAM US-144MKII\n");
+
+	/*
+	 * The device requires a full re-initialization sequence upon resume.
+	 * First, re-establish the active USB interface settings.
+	 */
+	err = usb_set_interface(tascam->dev, 0, 1);
+	if (err < 0) {
+		dev_err(&intf->dev,
+			"resume: failed to set alt setting on intf 0: %d\n",
+			err);
+		return err;
 	}
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
+	return 0;
+}
+
+static void tascam_error_timer(struct timer_list *t)
+{
+	struct tascam_card *tascam =
+		container_of(t, struct tascam_card, error_timer);
+
+	if (atomic_read(&tascam->midi_in_active))
+		schedule_work(&tascam->midi_in_work);
+	if (atomic_read(&tascam->midi_out_active))
+		schedule_work(&tascam->midi_out_work);
 }
 
 /**
@@ -235,8 +393,8 @@ static void tascam_card_private_free(struct snd_card *card)
  * - Checking for the second interface (MIDI) and associating it.
  * - Performing a vendor-specific handshake with the device.
  * - Setting alternate settings for USB interfaces.
- * - Creating and registering the ALSA sound card and PCM device.
- * - Allocating and initializing URBs for audio transfers.
+ * - Creating and registering the ALSA sound card, PCM device, and MIDI device.
+ * - Allocating and initializing URBs for audio and MIDI transfers.
  *
  * Return: 0 on success, or a negative error code on failure.
  */
@@ -255,14 +413,13 @@ static int tascam_probe(struct usb_interface *intf,
 			&dev->dev,
 			"Device is connected to a USB 1.1 port, this is not supported.\n");
 
-	/* The device has two interfaces; we drive both from this driver. */
 	if (intf->cur_altsetting->desc.bInterfaceNumber == 1) {
 		tascam = usb_get_intfdata(usb_ifnum_to_if(dev, 0));
 		if (tascam) {
 			usb_set_intfdata(intf, tascam);
 			tascam->iface1 = intf;
 		}
-		return 0; /* Let the core handle this interface */
+		return 0;
 	}
 
 	if (dev_idx >= SNDRV_CARDS) {
@@ -279,7 +436,6 @@ static int tascam_probe(struct usb_interface *intf,
 	if (!handshake_buf)
 		return -ENOMEM;
 
-	/* Perform vendor-specific handshake */
 	err = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
 			      VENDOR_REQ_MODE_CONTROL, RT_D2H_VENDOR_DEV,
 			      MODE_VAL_HANDSHAKE_READ, 0x0000, handshake_buf, 1,
@@ -296,7 +452,6 @@ static int tascam_probe(struct usb_interface *intf,
 		return -ENODEV;
 	}
 
-	/* Set alternate settings to enable audio/MIDI endpoints */
 	err = usb_set_interface(dev, 0, 1);
 	if (err < 0) {
 		dev_err(&dev->dev,
@@ -327,27 +482,24 @@ static int tascam_probe(struct usb_interface *intf,
 	tascam->iface0 = intf;
 
 	spin_lock_init(&tascam->lock);
+	spin_lock_init(&tascam->midi_in_lock);
+	spin_lock_init(&tascam->midi_out_lock);
 	init_usb_anchor(&tascam->playback_anchor);
 	init_usb_anchor(&tascam->capture_anchor);
 	init_usb_anchor(&tascam->feedback_anchor);
+	init_usb_anchor(&tascam->midi_in_anchor);
+	init_usb_anchor(&tascam->midi_out_anchor);
+
+	timer_setup(&tascam->error_timer, tascam_error_timer, 0);
 
 	INIT_WORK(&tascam->stop_work, tascam_stop_work_handler);
 	INIT_WORK(&tascam->stop_pcm_work, tascam_stop_pcm_work_handler);
 	INIT_WORK(&tascam->capture_work, tascam_capture_work_handler);
 
-	err = snd_pcm_new(card, "US144MKII PCM", 0, 1, 1, &tascam->pcm);
-	if (err < 0)
-		goto free_card;
-	tascam->pcm->private_data = tascam;
-	strscpy(tascam->pcm->name, "US144MKII PCM", sizeof(tascam->pcm->name));
-
-	err = tascam_init_pcm(tascam->pcm);
-	if (err < 0)
-		goto free_card;
-
-	err = tascam_alloc_urbs(tascam);
-	if (err < 0)
-		goto free_card;
+	if (kfifo_alloc(&tascam->midi_in_fifo, MIDI_IN_FIFO_SIZE, GFP_KERNEL)) {
+		snd_card_free(card);
+		return -ENOMEM;
+	}
 
 	strscpy(card->driver, DRIVER_NAME, sizeof(card->driver));
 	if (dev->descriptor.idProduct == USB_PID_TASCAM_US144) {
@@ -364,6 +516,28 @@ static int tascam_probe(struct usb_interface *intf,
 		 card->shortname, USB_VID_TASCAM, dev->descriptor.idProduct,
 		 dev_name(&dev->dev));
 
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
+	err = tascam_create_midi(tascam);
+	if (err < 0)
+		goto free_card;
+
+	err = tascam_create_controls(tascam);
+	if (err < 0)
+		goto free_card;
+
+	err = tascam_alloc_urbs(tascam);
+	if (err < 0)
+		goto free_card;
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto free_card;
@@ -384,8 +558,8 @@ static int tascam_probe(struct usb_interface *intf,
  * @intf: The USB interface being disconnected.
  *
  * This function is called when the device is disconnected from the system.
- * It cleans up all allocated resources by freeing the sound card, which in
- * turn triggers freeing of URBs and other resources.
+ * It cleans up all allocated resources, including killing URBs, freeing
+ * the sound card, and releasing memory.
  */
 static void tascam_disconnect(struct usb_interface *intf)
 {
@@ -395,89 +569,26 @@ static void tascam_disconnect(struct usb_interface *intf)
 		return;
 
 	if (intf->cur_altsetting->desc.bInterfaceNumber == 0) {
+		/* Ensure all deferred work is complete before freeing resources */
 		snd_card_disconnect(tascam->card);
 		cancel_work_sync(&tascam->stop_work);
 		cancel_work_sync(&tascam->capture_work);
+		cancel_work_sync(&tascam->midi_in_work);
+		cancel_work_sync(&tascam->midi_out_work);
 		cancel_work_sync(&tascam->stop_pcm_work);
+
+		usb_kill_anchored_urbs(&tascam->playback_anchor);
+		usb_kill_anchored_urbs(&tascam->capture_anchor);
+		usb_kill_anchored_urbs(&tascam->feedback_anchor);
+		usb_kill_anchored_urbs(&tascam->midi_in_anchor);
+		usb_kill_anchored_urbs(&tascam->midi_out_anchor);
+		timer_delete_sync(&tascam->error_timer);
 		tascam_free_urbs(tascam);
 		snd_card_free(tascam->card);
 		dev_idx--;
 	}
 }
 
-/**
- * tascam_suspend() - Handles device suspension.
- * @intf: The USB interface being suspended.
- * @message: Power management message.
- *
- * This function is called when the device is suspended. It stops all active
- * streams and kills all URBs.
- *
- * Return: 0 on success.
- */
-static int tascam_suspend(struct usb_interface *intf, pm_message_t message)
-{
-	struct tascam_card *tascam = usb_get_intfdata(intf);
-
-	if (!tascam)
-		return 0;
-
-	snd_pcm_suspend_all(tascam->pcm);
-
-	cancel_work_sync(&tascam->stop_work);
-	cancel_work_sync(&tascam->capture_work);
-	cancel_work_sync(&tascam->stop_pcm_work);
-	usb_kill_anchored_urbs(&tascam->playback_anchor);
-	usb_kill_anchored_urbs(&tascam->capture_anchor);
-	usb_kill_anchored_urbs(&tascam->feedback_anchor);
-
-	return 0;
-}
-
-/**
- * tascam_resume() - Handles device resumption from suspend.
- * @intf: The USB interface being resumed.
- *
- * This function is called when the device resumes from suspend. It
- * re-establishes the active USB interface settings and re-configures the sample
- * rate if it was previously active.
- *
- * Return: 0 on success, or a negative error code on failure.
- */
-static int tascam_resume(struct usb_interface *intf)
-{
-	struct tascam_card *tascam = usb_get_intfdata(intf);
-	int err;
-
-	if (!tascam)
-		return 0;
-
-	dev_info(&intf->dev, "resuming TASCAM US-144MKII\n");
-
-	/* Re-establish the active USB interface settings. */
-	err = usb_set_interface(tascam->dev, 0, 1);
-	if (err < 0) {
-		dev_err(&intf->dev,
-			"resume: failed to set alt setting on intf 0: %d\n",
-			err);
-		return err;
-	}
-	err = usb_set_interface(tascam->dev, 1, 1);
-	if (err < 0) {
-		dev_err(&intf->dev,
-			"resume: failed to set alt setting on intf 1: %d\n",
-			err);
-		return err;
-	}
-
-	/* Re-configure the sample rate if one was previously active */
-	if (tascam->current_rate > 0)
-		us144mkii_configure_device_for_rate(tascam,
-						    tascam->current_rate);
-
-	return 0;
-}
-
 static const struct usb_device_id tascam_usb_ids[] = {
 	{ USB_DEVICE(USB_VID_TASCAM, USB_PID_TASCAM_US144) },
 	{ USB_DEVICE(USB_VID_TASCAM, USB_PID_TASCAM_US144MKII) },
diff --git a/sound/usb/usx2y/us144mkii.h b/sound/usb/usx2y/us144mkii.h
index 34b9b275b905..9b7749764fc8 100644
--- a/sound/usb/usx2y/us144mkii.h
+++ b/sound/usb/usx2y/us144mkii.h
@@ -4,13 +4,18 @@
 #ifndef __US144MKII_H
 #define __US144MKII_H
 
+#include <linux/kfifo.h>
+#include <linux/timer.h>
 #include <linux/usb.h>
 #include <linux/workqueue.h>
+#include <sound/control.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
+#include <sound/rawmidi.h>
 
 #define DRIVER_NAME "us144mkii"
+#define DRIVER_VERSION "1.7.6"
 
 /* --- USB Device Identification --- */
 #define USB_VID_TASCAM 0x0644
@@ -20,13 +25,15 @@
 /* --- USB Endpoints (Alternate Setting 1) --- */
 #define EP_PLAYBACK_FEEDBACK 0x81
 #define EP_AUDIO_OUT 0x02
+#define EP_MIDI_IN 0x83
+#define EP_MIDI_OUT 0x04
 #define EP_AUDIO_IN 0x86
 
 /* --- USB Control Message Protocol --- */
 #define RT_H2D_CLASS_EP (USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_ENDPOINT)
 #define RT_D2H_CLASS_EP (USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_ENDPOINT)
-#define RT_D2H_VENDOR_DEV (USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
 #define RT_H2D_VENDOR_DEV (USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
+#define RT_D2H_VENDOR_DEV (USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
 
 enum uac_request {
 	UAC_SET_CUR = 0x01,
@@ -48,6 +55,8 @@ enum tascam_mode_value {
 	MODE_VAL_STREAM_START = 0x0030,
 };
 
+#define HANDSHAKE_SUCCESS_VAL 0x12
+
 enum tascam_register {
 	REG_ADDR_UNKNOWN_0D = 0x0d04,
 	REG_ADDR_UNKNOWN_0E = 0x0e00,
@@ -70,6 +79,11 @@ enum tascam_register {
 #define NUM_CAPTURE_URBS 8
 #define CAPTURE_URB_SIZE 512
 #define CAPTURE_RING_BUFFER_SIZE (CAPTURE_URB_SIZE * NUM_CAPTURE_URBS * 4)
+#define NUM_MIDI_IN_URBS 4
+#define MIDI_IN_BUF_SIZE 64
+#define MIDI_IN_FIFO_SIZE (MIDI_IN_BUF_SIZE * NUM_MIDI_IN_URBS)
+#define MIDI_OUT_BUF_SIZE 64
+#define NUM_MIDI_OUT_URBS 4
 #define USB_CTRL_TIMEOUT_MS 1000
 #define FEEDBACK_SYNC_LOSS_THRESHOLD 41
 
@@ -85,10 +99,6 @@ enum tascam_register {
 #define FRAMES_PER_DECODE_BLOCK 8
 #define RAW_BYTES_PER_DECODE_BLOCK 512
 
-struct tascam_card;
-
-#include "us144mkii_pcm.h"
-
 /**
  * struct us144mkii_frame_pattern_observer - State for dynamic feedback
  * patterns.
@@ -117,6 +127,7 @@ struct us144mkii_frame_pattern_observer {
  * @iface1: Pointer to USB interface 1 (MIDI).
  * @card: Pointer to the ALSA sound card instance.
  * @pcm: Pointer to the ALSA PCM device.
+ * @rmidi: Pointer to the ALSA rawmidi device.
  *
  * @playback_substream: Pointer to the active playback PCM substream.
  * @playback_urbs: Array of URBs for playback.
@@ -142,14 +153,35 @@ struct us144mkii_frame_pattern_observer {
  * @capture_decode_dst_block: Buffer for decoded 32-bit capture samples.
  * @capture_routing_buffer: Intermediate buffer for capture routing.
  * @capture_work: Work struct for deferred capture processing.
- *
  * @stop_work: Work struct for deferred stream stopping.
  * @stop_pcm_work: Work struct for stopping PCM due to a fatal error (e.g.
  * xrun).
  *
+ * @midi_in_substream: Pointer to the active MIDI input substream.
+ * @midi_out_substream: Pointer to the active MIDI output substream.
+ * @midi_in_urbs: Array of URBs for MIDI input.
+ * @midi_out_urbs: Array of URBs for MIDI output.
+ * @midi_in_active: Atomic flag indicating if MIDI input is active.
+ * @midi_out_active: Atomic flag indicating if MIDI output is active.
+ * @midi_in_fifo: FIFO for raw MIDI input data.
+ * @midi_in_work: Work struct for deferred MIDI input processing.
+ * @midi_out_work: Work struct for deferred MIDI output processing.
+ * @midi_in_lock: Spinlock for MIDI input FIFO.
+ * @midi_out_lock: Spinlock for MIDI output.
+ * @midi_out_urbs_in_flight: Bitmap of MIDI output URBs currently in flight.
+ * @midi_running_status: Stores the last MIDI status byte for running status.
+ * @error_timer: Timer for MIDI error retry logic.
+ *
  * @lock: Main spinlock for protecting shared driver state.
  * @active_urbs: Atomic counter for active URBs.
  * @current_rate: Currently configured sample rate of the device.
+ * @line_out_source: Source for Line Outputs (0: Playback 1-2, 1: Playback 3-4).
+ * @digital_out_source: Source for Digital Outputs (0: Playback 1-2, 1: Playback
+ * 3-4).
+ * @capture_12_source: Source for Capture channels 1-2 (0: Analog In, 1: Digital
+ * In).
+ * @capture_34_source: Source for Capture channels 3-4 (0: Analog In, 1: Digital
+ * In).
  *
  * @feedback_accumulator_pattern: Stores the calculated frames per packet for
  * feedback.
@@ -164,6 +196,8 @@ struct us144mkii_frame_pattern_observer {
  * @playback_anchor: USB anchor for playback URBs.
  * @capture_anchor: USB anchor for capture URBs.
  * @feedback_anchor: USB anchor for feedback URBs.
+ * @midi_in_anchor: USB anchor for MIDI input URBs.
+ * @midi_out_anchor: USB anchor for MIDI output URBs.
  */
 struct tascam_card {
 	/* --- Core device pointers --- */
@@ -172,6 +206,7 @@ struct tascam_card {
 	struct usb_interface *iface1;
 	struct snd_card *card;
 	struct snd_pcm *pcm;
+	struct snd_rawmidi *rmidi;
 
 	/* --- PCM Substreams --- */
 	struct snd_pcm_substream *playback_substream;
@@ -184,9 +219,13 @@ struct tascam_card {
 	size_t feedback_urb_alloc_size;
 	struct urb *capture_urbs[NUM_CAPTURE_URBS];
 	size_t capture_urb_alloc_size;
+	struct urb *midi_in_urbs[NUM_MIDI_IN_URBS];
+	struct urb *midi_out_urbs[NUM_MIDI_OUT_URBS];
 	struct usb_anchor playback_anchor;
 	struct usb_anchor capture_anchor;
 	struct usb_anchor feedback_anchor;
+	struct usb_anchor midi_in_anchor;
+	struct usb_anchor midi_out_anchor;
 
 	/* --- Stream State --- */
 	spinlock_t lock;
@@ -211,6 +250,18 @@ struct tascam_card {
 	s32 *capture_decode_dst_block;
 	s32 *capture_routing_buffer;
 
+	/* --- MIDI State --- */
+	struct snd_rawmidi_substream *midi_in_substream;
+	struct snd_rawmidi_substream *midi_out_substream;
+	atomic_t midi_in_active;
+	atomic_t midi_out_active;
+	struct kfifo midi_in_fifo;
+	spinlock_t midi_in_lock;
+	spinlock_t midi_out_lock;
+	unsigned long midi_out_urbs_in_flight;
+	u8 midi_running_status;
+	struct timer_list error_timer;
+
 	/* --- Feedback Sync State --- */
 	unsigned int feedback_accumulator_pattern[FEEDBACK_ACCUMULATOR_SIZE];
 	unsigned int feedback_pattern_out_idx;
@@ -224,14 +275,23 @@ struct tascam_card {
 	struct work_struct stop_work;
 	struct work_struct stop_pcm_work;
 	struct work_struct capture_work;
+	struct work_struct midi_in_work;
+	struct work_struct midi_out_work;
+
+	/* --- Mixer/Routing State --- */
+	unsigned int line_out_source;
+	unsigned int digital_out_source;
+	unsigned int capture_12_source;
+	unsigned int capture_34_source;
 };
 
+/* main.c */
 /**
  * tascam_free_urbs() - Free all allocated URBs and associated buffers.
  * @tascam: the tascam_card instance
  *
- * This function kills, unlinks, and frees all playback, feedback, and
- * capture URBs, along with their transfer buffers and the capture
+ * This function kills, unlinks, and frees all playback, feedback, capture,
+ * and MIDI URBs, along with their transfer buffers and the capture
  * ring/decode buffers.
  */
 void tascam_free_urbs(struct tascam_card *tascam);
@@ -241,7 +301,7 @@ void tascam_free_urbs(struct tascam_card *tascam);
  * @tascam: the tascam_card instance
  *
  * This function allocates and initializes all URBs for playback, feedback,
- * and capture, as well as the necessary buffers for data processing.
+ * capture, and MIDI, as well as the necessary buffers for data processing.
  *
  * Return: 0 on success, or a negative error code on failure.
  */
@@ -256,4 +316,51 @@ int tascam_alloc_urbs(struct tascam_card *tascam);
  */
 void tascam_stop_work_handler(struct work_struct *work);
 
+/* us144mkii_pcm.h */
+#include "us144mkii_pcm.h"
+
+/* us144mkii_midi.c */
+/**
+ * tascam_midi_in_urb_complete() - Completion handler for MIDI IN URBs
+ * @urb: The completed URB.
+ *
+ * This function runs in interrupt context. It places the raw data from the
+ * USB endpoint into a kfifo and schedules a work item to process it later,
+ * ensuring the interrupt handler remains fast.
+ */
+void tascam_midi_in_urb_complete(struct urb *urb);
+
+/**
+ * tascam_midi_out_urb_complete() - Completion handler for MIDI OUT bulk URB.
+ * @urb: The completed URB.
+ *
+ * This function runs in interrupt context. It marks the output URB as no
+ * longer in-flight. It then re-schedules the work handler to check for and
+ * send any more data waiting in the ALSA buffer. This is a safe, non-blocking
+ * way to continue the data transmission chain.
+ */
+void tascam_midi_out_urb_complete(struct urb *urb);
+
+/**
+ * tascam_create_midi() - Create and initialize the ALSA rawmidi device.
+ * @tascam: The driver instance.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int tascam_create_midi(struct tascam_card *tascam);
+
+/* us144mkii_controls.c */
+/**
+ * tascam_create_controls() - Creates and adds ALSA mixer controls for the
+ * device.
+ * @tascam: The driver instance.
+ *
+ * This function registers custom ALSA controls for managing audio routing
+ * (line out source, digital out source, capture 1-2 source, capture 3-4 source)
+ * and displaying the current sample rate.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int tascam_create_controls(struct tascam_card *tascam);
+
 #endif /* __US144MKII_H */
diff --git a/sound/usb/usx2y/us144mkii_controls.c b/sound/usb/usx2y/us144mkii_controls.c
new file mode 100644
index 000000000000..4262b7f45139
--- /dev/null
+++ b/sound/usb/usx2y/us144mkii_controls.c
@@ -0,0 +1,414 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2025 Šerif Rami <ramiserifpersia@gmail.com>
+
+#include "us144mkii.h"
+
+/**
+ * @brief Text descriptions for playback output source options.
+ *
+ * Used by ALSA kcontrol elements to provide user-friendly names for
+ * the playback routing options (e.g., "Playback 1-2", "Playback 3-4").
+ */
+static const char *const playback_source_texts[] = { "Playback 1-2",
+						     "Playback 3-4" };
+
+/**
+ * @brief Text descriptions for capture input source options.
+ *
+ * Used by ALSA kcontrol elements to provide user-friendly names for
+ * the capture routing options (e.g., "Analog In", "Digital In").
+ */
+static const char *const capture_source_texts[] = { "Analog In", "Digital In" };
+
+/**
+ * tascam_playback_source_info() - ALSA control info callback for playback
+ * source.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @uinfo: The ALSA control element info structure to fill.
+ *
+ * This function provides information about the enumerated playback source
+ * control, including its type, count, and available items (Playback 1-2,
+ * Playback 3-4).
+ *
+ * Return: 0 on success.
+ */
+static int tascam_playback_source_info(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	return snd_ctl_enum_info(uinfo, 1, 2, playback_source_texts);
+}
+
+/**
+ * tascam_line_out_get() - ALSA control get callback for Line Outputs Source.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @ucontrol: The ALSA control element value structure to fill.
+ *
+ * This function retrieves the current selection for the Line Outputs source
+ * (Playback 1-2 or Playback 3-4) from the driver's private data and populates
+ * the ALSA control element value.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_line_out_get(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct tascam_card *tascam = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = tascam->line_out_source;
+	return 0;
+}
+
+/**
+ * tascam_line_out_put() - ALSA control put callback for Line Outputs Source.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @ucontrol: The ALSA control element value structure containing the new value.
+ *
+ * This function sets the Line Outputs source (Playback 1-2 or Playback 3-4)
+ * based on the user's selection from the ALSA control element. It validates
+ * the input and updates the driver's private data.
+ *
+ * Return: 1 if the value was changed, 0 if unchanged, or a negative error code.
+ */
+static int tascam_line_out_put(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct tascam_card *tascam = snd_kcontrol_chip(kcontrol);
+
+	if (ucontrol->value.enumerated.item[0] > 1)
+		return -EINVAL;
+	if (tascam->line_out_source == ucontrol->value.enumerated.item[0])
+		return 0;
+	tascam->line_out_source = ucontrol->value.enumerated.item[0];
+	return 1;
+}
+
+/**
+ * tascam_line_out_control - ALSA kcontrol definition for Line Outputs Source.
+ *
+ * This defines a new ALSA mixer control named "Line OUTPUTS Source" that allows
+ * the user to select between "Playback 1-2" and "Playback 3-4" for the analog
+ * line outputs of the device. It uses the `tascam_playback_source_info` for
+ * information and `tascam_line_out_get`/`tascam_line_out_put` for value
+ * handling.
+ */
+static const struct snd_kcontrol_new tascam_line_out_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Line OUTPUTS Source",
+	.info = tascam_playback_source_info,
+	.get = tascam_line_out_get,
+	.put = tascam_line_out_put,
+};
+
+/**
+ * tascam_digital_out_get() - ALSA control get callback for Digital Outputs
+ * Source.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @ucontrol: The ALSA control element value structure to fill.
+ *
+ * This function retrieves the current selection for the Digital Outputs source
+ * (Playback 1-2 or Playback 3-4) from the driver's private data and populates
+ * the ALSA control element value.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_digital_out_get(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct tascam_card *tascam = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = tascam->digital_out_source;
+	return 0;
+}
+
+/**
+ * tascam_digital_out_put() - ALSA control put callback for Digital Outputs
+ * Source.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @ucontrol: The ALSA control element value structure containing the new value.
+ *
+ * This function sets the Digital Outputs source (Playback 1-2 or Playback 3-4)
+ * based on the user's selection from the ALSA control element. It validates
+ * the input and updates the driver's private data.
+ *
+ * Return: 1 if the value was changed, 0 if unchanged, or a negative error code.
+ */
+static int tascam_digital_out_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct tascam_card *tascam = snd_kcontrol_chip(kcontrol);
+
+	if (ucontrol->value.enumerated.item[0] > 1)
+		return -EINVAL;
+	if (tascam->digital_out_source == ucontrol->value.enumerated.item[0])
+		return 0;
+	tascam->digital_out_source = ucontrol->value.enumerated.item[0];
+	return 1;
+}
+
+/**
+ * tascam_digital_out_control - ALSA kcontrol definition for Digital Outputs
+ * Source.
+ *
+ * This defines a new ALSA mixer control named "Digital OUTPUTS Source" that
+ * allows the user to select between "Playback 1-2" and "Playback 3-4" for the
+ * digital outputs of the device. It uses the `tascam_playback_source_info` for
+ * information and `tascam_digital_out_get`/`tascam_digital_out_put` for value
+ * handling.
+ */
+static const struct snd_kcontrol_new tascam_digital_out_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Digital OUTPUTS Source",
+	.info = tascam_playback_source_info,
+	.get = tascam_digital_out_get,
+	.put = tascam_digital_out_put,
+};
+
+/**
+ * tascam_capture_source_info() - ALSA control info callback for capture source.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @uinfo: The ALSA control element info structure to fill.
+ *
+ * This function provides information about the enumerated capture source
+ * control, including its type, count, and available items (Analog In, Digital
+ * In).
+ *
+ * Return: 0 on success.
+ */
+static int tascam_capture_source_info(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *uinfo)
+{
+	return snd_ctl_enum_info(uinfo, 1, 2, capture_source_texts);
+}
+
+/**
+ * tascam_capture_12_get() - ALSA control get callback for Capture channels 1
+ * and 2 Source.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @ucontrol: The ALSA control element value structure to fill.
+ *
+ * This function retrieves the current selection for the Capture channels 1 and
+ * 2 source (Analog In or Digital In) from the driver's private data and
+ * populates the ALSA control element value.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_capture_12_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct tascam_card *tascam = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = tascam->capture_12_source;
+	return 0;
+}
+
+/**
+ * tascam_capture_12_put() - ALSA control put callback for Capture channels 1
+ * and 2 Source.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @ucontrol: The ALSA control element value structure containing the new value.
+ *
+ * This function sets the Capture channels 1 and 2 source (Analog In or Digital
+ * In) based on the user's selection from the ALSA control element. It validates
+ * the input and updates the driver's private data.
+ *
+ * Return: 1 if the value was changed, 0 if unchanged, or a negative error code.
+ */
+static int tascam_capture_12_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct tascam_card *tascam = snd_kcontrol_chip(kcontrol);
+
+	if (ucontrol->value.enumerated.item[0] > 1)
+		return -EINVAL;
+	if (tascam->capture_12_source == ucontrol->value.enumerated.item[0])
+		return 0;
+	tascam->capture_12_source = ucontrol->value.enumerated.item[0];
+	return 1;
+}
+
+/**
+ * tascam_capture_12_control - ALSA kcontrol definition for Capture channels 1
+ * and 2 Source.
+ *
+ * This defines a new ALSA mixer control named "ch1 and ch2 Source" that allows
+ * the user to select between "Analog In" and "Digital In" for the first two
+ * capture channels of the device. It uses the `tascam_capture_source_info` for
+ * information and `tascam_capture_12_get`/`tascam_capture_12_put` for value
+ * handling.
+ */
+static const struct snd_kcontrol_new tascam_capture_12_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "ch1 and ch2 Source",
+	.info = tascam_capture_source_info,
+	.get = tascam_capture_12_get,
+	.put = tascam_capture_12_put,
+};
+
+/**
+ * tascam_capture_34_get() - ALSA control get callback for Capture channels 3
+ * and 4 Source.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @ucontrol: The ALSA control element value structure to fill.
+ *
+ * This function retrieves the current selection for the Capture channels 3 and
+ * 4 source (Analog In or Digital In) from the driver's private data and
+ * populates the ALSA control element value.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_capture_34_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct tascam_card *tascam = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = tascam->capture_34_source;
+	return 0;
+}
+
+/**
+ * tascam_capture_34_put() - ALSA control put callback for Capture channels 3
+ * and 4 Source.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @ucontrol: The ALSA control element value structure containing the new value.
+ *
+ * This function sets the Capture channels 3 and 4 source (Analog In or Digital
+ * In) based on the user's selection from the ALSA control element. It validates
+ * the input and updates the driver's private data.
+ *
+ * Return: 1 if the value was changed, 0 if unchanged, or a negative error code.
+ */
+static int tascam_capture_34_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct tascam_card *tascam = snd_kcontrol_chip(kcontrol);
+
+	if (ucontrol->value.enumerated.item[0] > 1)
+		return -EINVAL;
+	if (tascam->capture_34_source == ucontrol->value.enumerated.item[0])
+		return 0;
+	tascam->capture_34_source = ucontrol->value.enumerated.item[0];
+	return 1;
+}
+
+/**
+ * tascam_capture_34_control - ALSA kcontrol definition for Capture channels 3
+ * and 4 Source.
+ *
+ * This defines a new ALSA mixer control named "ch3 and ch4 Source" that allows
+ * the user to select between "Analog In" and "Digital In" for the third and
+ * fourth capture channels of the device. It uses the
+ * `tascam_capture_source_info` for information and
+ * `tascam_capture_34_get`/`tascam_capture_34_put` for value handling.
+ */
+static const struct snd_kcontrol_new tascam_capture_34_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "ch3 and ch4 Source",
+	.info = tascam_capture_source_info,
+	.get = tascam_capture_34_get,
+	.put = tascam_capture_34_put,
+};
+
+/**
+ * tascam_samplerate_info() - ALSA control info callback for Sample Rate.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @uinfo: The ALSA control element info structure to fill.
+ *
+ * This function provides information about the Sample Rate control, defining
+ * it as an integer type with a minimum value of 0 and a maximum of 96000.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_samplerate_info(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 96000;
+	return 0;
+}
+
+/**
+ * tascam_samplerate_get() - ALSA control get callback for Sample Rate.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @ucontrol: The ALSA control element value structure to fill.
+ *
+ * This function retrieves the current sample rate from the device via a USB
+ * control message and populates the ALSA control element value. If the rate
+ * is already known (i.e., `current_rate` is set), it returns that value
+ * directly.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int tascam_samplerate_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct tascam_card *tascam =
+		(struct tascam_card *)snd_kcontrol_chip(kcontrol);
+	u8 *buf __free(kfree);
+	int err;
+	u32 rate = 0;
+
+	if (tascam->current_rate > 0) {
+		ucontrol->value.integer.value[0] = tascam->current_rate;
+		return 0;
+	}
+
+	buf = kmalloc(3, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	err = usb_control_msg(tascam->dev, usb_rcvctrlpipe(tascam->dev, 0),
+			      UAC_GET_CUR, RT_D2H_CLASS_EP,
+			      UAC_SAMPLING_FREQ_CONTROL, EP_AUDIO_IN, buf, 3,
+			      USB_CTRL_TIMEOUT_MS);
+
+	if (err >= 3)
+		rate = buf[0] | (buf[1] << 8) | (buf[2] << 16);
+
+	ucontrol->value.integer.value[0] = rate;
+	return 0;
+}
+
+/**
+ * tascam_samplerate_control - ALSA kcontrol definition for Sample Rate.
+ *
+ * This defines a new ALSA mixer control named "Sample Rate" that displays
+ * the current sample rate of the device. It is a read-only control.
+ */
+static const struct snd_kcontrol_new tascam_samplerate_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Sample Rate",
+	.info = tascam_samplerate_info,
+	.get = tascam_samplerate_get,
+	.access = SNDRV_CTL_ELEM_ACCESS_READ,
+};
+
+int tascam_create_controls(struct tascam_card *tascam)
+{
+	int err;
+
+	err = snd_ctl_add(tascam->card,
+			  snd_ctl_new1(&tascam_line_out_control, tascam));
+	if (err < 0)
+		return err;
+	err = snd_ctl_add(tascam->card,
+			  snd_ctl_new1(&tascam_digital_out_control, tascam));
+	if (err < 0)
+		return err;
+	err = snd_ctl_add(tascam->card,
+			  snd_ctl_new1(&tascam_capture_12_control, tascam));
+	if (err < 0)
+		return err;
+	err = snd_ctl_add(tascam->card,
+			  snd_ctl_new1(&tascam_capture_34_control, tascam));
+	if (err < 0)
+		return err;
+
+	err = snd_ctl_add(tascam->card,
+			  snd_ctl_new1(&tascam_samplerate_control, tascam));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
diff --git a/sound/usb/usx2y/us144mkii_midi.c b/sound/usb/usx2y/us144mkii_midi.c
new file mode 100644
index 000000000000..36a05d52a8c8
--- /dev/null
+++ b/sound/usb/usx2y/us144mkii_midi.c
@@ -0,0 +1,401 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2025 Šerif Rami <ramiserifpersia@gmail.com>
+
+#include "us144mkii.h"
+
+/**
+ * tascam_midi_in_work_handler() - Deferred work for processing MIDI input.
+ * @work: The work_struct instance.
+ *
+ * This function runs in a thread context. It safely reads raw USB data from
+ * the kfifo, processes it by stripping protocol-specific padding bytes, and
+ * passes the clean MIDI data to the ALSA rawmidi subsystem.
+ */
+static void tascam_midi_in_work_handler(struct work_struct *work)
+{
+	struct tascam_card *tascam =
+		container_of(work, struct tascam_card, midi_in_work);
+	u8 buf[9];
+	u8 clean_buf[8];
+	unsigned int count, clean_count;
+
+	if (!tascam->midi_in_substream)
+		return;
+
+	while (kfifo_out_spinlocked(&tascam->midi_in_fifo, buf, sizeof(buf),
+				    &tascam->midi_in_lock) == sizeof(buf)) {
+		clean_count = 0;
+		for (count = 0; count < 8; ++count) {
+			if (buf[count] != 0xfd)
+				clean_buf[clean_count++] = buf[count];
+		}
+
+		if (clean_count > 0)
+			snd_rawmidi_receive(tascam->midi_in_substream,
+					    clean_buf, clean_count);
+	}
+}
+
+void tascam_midi_in_urb_complete(struct urb *urb)
+{
+	struct tascam_card *tascam = urb->context;
+	int ret;
+
+	if (urb->status) {
+		if (urb->status != -ENOENT && urb->status != -ECONNRESET &&
+		    urb->status != -ESHUTDOWN && urb->status != -EPROTO) {
+			dev_err_ratelimited(tascam->card->dev,
+					    "MIDI IN URB failed: status %d\n",
+					    urb->status);
+		}
+		goto out;
+	}
+
+	if (tascam && atomic_read(&tascam->midi_in_active) &&
+	    urb->actual_length > 0) {
+		kfifo_in_spinlocked(&tascam->midi_in_fifo, urb->transfer_buffer,
+				    urb->actual_length, &tascam->midi_in_lock);
+		schedule_work(&tascam->midi_in_work);
+	}
+
+	usb_get_urb(urb);
+	usb_anchor_urb(urb, &tascam->midi_in_anchor);
+	ret = usb_submit_urb(urb, GFP_ATOMIC);
+	if (ret < 0) {
+		dev_err(tascam->card->dev,
+			"Failed to resubmit MIDI IN URB: error %d\n", ret);
+		usb_unanchor_urb(urb);
+		usb_put_urb(urb);
+	}
+out:
+	usb_put_urb(urb);
+}
+
+/**
+ * tascam_midi_in_open() - Opens the MIDI input substream.
+ * @substream: The ALSA rawmidi substream to open.
+ *
+ * This function stores a reference to the MIDI input substream in the
+ * driver's private data.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_midi_in_open(struct snd_rawmidi_substream *substream)
+{
+	struct tascam_card *tascam = substream->rmidi->private_data;
+
+	tascam->midi_in_substream = substream;
+	return 0;
+}
+
+/**
+ * tascam_midi_in_close() - Closes the MIDI input substream.
+ * @substream: The ALSA rawmidi substream to close.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_midi_in_close(struct snd_rawmidi_substream *substream)
+{
+	return 0;
+}
+
+/**
+ * tascam_midi_in_trigger() - Triggers MIDI input stream activity.
+ * @substream: The ALSA rawmidi substream.
+ * @up: Boolean indicating whether to start (1) or stop (0) the stream.
+ *
+ * This function starts or stops the MIDI input URBs based on the 'up'
+ * parameter. When starting, it resets the kfifo and submits all MIDI input
+ * URBs. When stopping, it kills all anchored MIDI input URBs and cancels the
+ * associated workqueue.
+ */
+static void tascam_midi_in_trigger(struct snd_rawmidi_substream *substream,
+				   int up)
+{
+	struct tascam_card *tascam = substream->rmidi->private_data;
+	int i, err;
+
+	if (up) {
+		if (atomic_xchg(&tascam->midi_in_active, 1) == 0) {
+			{
+				guard(spinlock_irqsave)(&tascam->midi_in_lock);
+				kfifo_reset(&tascam->midi_in_fifo);
+			}
+
+			for (i = 0; i < NUM_MIDI_IN_URBS; i++) {
+				usb_get_urb(tascam->midi_in_urbs[i]);
+				usb_anchor_urb(tascam->midi_in_urbs[i],
+					       &tascam->midi_in_anchor);
+				err = usb_submit_urb(tascam->midi_in_urbs[i],
+						     GFP_KERNEL);
+				if (err < 0) {
+					dev_err(tascam->card->dev,
+						"Failed to submit MIDI IN URB %d: %d\n",
+						i, err);
+					usb_unanchor_urb(
+						tascam->midi_in_urbs[i]);
+					usb_put_urb(tascam->midi_in_urbs[i]);
+				}
+			}
+		}
+	} else {
+		if (atomic_xchg(&tascam->midi_in_active, 0) == 1) {
+			usb_kill_anchored_urbs(&tascam->midi_in_anchor);
+			cancel_work_sync(&tascam->midi_in_work);
+		}
+	}
+}
+
+/**
+ * tascam_midi_in_ops - ALSA rawmidi operations for MIDI input.
+ *
+ * This structure defines the callback functions for MIDI input stream
+ * operations, including open, close, and trigger.
+ */
+static const struct snd_rawmidi_ops tascam_midi_in_ops = {
+	.open = tascam_midi_in_open,
+	.close = tascam_midi_in_close,
+	.trigger = tascam_midi_in_trigger,
+};
+
+void tascam_midi_out_urb_complete(struct urb *urb)
+{
+	struct tascam_card *tascam = urb->context;
+	int i, urb_index = -1;
+
+	if (urb->status) {
+		if (urb->status != -ENOENT && urb->status != -ECONNRESET &&
+		    urb->status != -ESHUTDOWN) {
+			dev_err_ratelimited(tascam->card->dev,
+					    "MIDI OUT URB failed: %d\n",
+					    urb->status);
+		}
+		goto out;
+	}
+
+	if (!tascam)
+		goto out;
+
+	for (i = 0; i < NUM_MIDI_OUT_URBS; i++) {
+		if (tascam->midi_out_urbs[i] == urb) {
+			urb_index = i;
+			break;
+		}
+	}
+
+	if (urb_index < 0) {
+		dev_err_ratelimited(tascam->card->dev,
+				    "Unknown MIDI OUT URB completed!\n");
+		goto out;
+	}
+
+	{
+		guard(spinlock_irqsave)(&tascam->midi_out_lock);
+		clear_bit(urb_index, &tascam->midi_out_urbs_in_flight);
+	}
+
+	if (atomic_read(&tascam->midi_out_active))
+		schedule_work(&tascam->midi_out_work);
+
+out:
+	usb_put_urb(urb);
+}
+
+/**
+ * tascam_midi_out_work_handler() - Deferred work for sending MIDI data
+ * @work: The work_struct instance.
+ *
+ * This function handles the proprietary output protocol: take the raw MIDI
+ * message bytes from the application, place them at the start of a 9-byte
+ * buffer, pad the rest with 0xFD, and add a terminator byte (0x00).
+ * This function pulls as many bytes as will fit into one packet from the
+ * ALSA buffer and sends them.
+ */
+static void tascam_midi_out_work_handler(struct work_struct *work)
+{
+	struct tascam_card *tascam =
+		container_of(work, struct tascam_card, midi_out_work);
+	struct snd_rawmidi_substream *substream = tascam->midi_out_substream;
+	int i;
+
+	if (!substream || !atomic_read(&tascam->midi_out_active))
+		return;
+
+	while (snd_rawmidi_transmit_peek(substream, (u8[]){ 0 }, 1) == 1) {
+		int urb_index;
+		struct urb *urb;
+		u8 *buf;
+		int bytes_to_send;
+
+		{
+			guard(spinlock_irqsave)(&tascam->midi_out_lock);
+
+			urb_index = -1;
+			for (i = 0; i < NUM_MIDI_OUT_URBS; i++) {
+				if (!test_bit(
+					    i,
+					    &tascam->midi_out_urbs_in_flight)) {
+					urb_index = i;
+					break;
+				}
+			}
+
+			if (urb_index < 0)
+				return; /* No free URBs, will be rescheduled by
+					 * completion handler
+					 */
+
+			urb = tascam->midi_out_urbs[urb_index];
+			buf = urb->transfer_buffer;
+			bytes_to_send = snd_rawmidi_transmit(substream, buf, 8);
+
+			if (bytes_to_send <= 0)
+				break; /* No more data */
+
+			if (bytes_to_send < 9)
+				memset(buf + bytes_to_send, 0xfd,
+				       9 - bytes_to_send);
+			buf[8] = 0x00;
+
+			set_bit(urb_index, &tascam->midi_out_urbs_in_flight);
+			urb->transfer_buffer_length = 9;
+		}
+
+		usb_get_urb(urb);
+		usb_anchor_urb(urb, &tascam->midi_out_anchor);
+		if (usb_submit_urb(urb, GFP_KERNEL) < 0) {
+			dev_err_ratelimited(
+				tascam->card->dev,
+				"Failed to submit MIDI OUT URB %d\n",
+				urb_index);
+			{
+				guard(spinlock_irqsave)(&tascam->midi_out_lock);
+				clear_bit(urb_index,
+					  &tascam->midi_out_urbs_in_flight);
+			}
+			usb_unanchor_urb(urb);
+			usb_put_urb(urb);
+			break; /* Stop on error */
+		}
+	}
+}
+
+/**
+ * tascam_midi_out_open() - Opens the MIDI output substream.
+ * @substream: The ALSA rawmidi substream to open.
+ *
+ * This function stores a reference to the MIDI output substream in the
+ * driver's private data and initializes the MIDI running status.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_midi_out_open(struct snd_rawmidi_substream *substream)
+{
+	struct tascam_card *tascam = substream->rmidi->private_data;
+
+	tascam->midi_out_substream = substream;
+	/* Initialize the running status state for the packet packer. */
+	tascam->midi_running_status = 0;
+	return 0;
+}
+
+/**
+ * tascam_midi_out_close() - Closes the MIDI output substream.
+ * @substream: The ALSA rawmidi substream to close.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_midi_out_close(struct snd_rawmidi_substream *substream)
+{
+	return 0;
+}
+
+/**
+ * tascam_midi_out_drain() - Drains the MIDI output stream.
+ * @substream: The ALSA rawmidi substream.
+ *
+ * This function cancels any pending MIDI output work and kills all
+ * anchored MIDI output URBs, ensuring all data is sent or discarded.
+ */
+static void tascam_midi_out_drain(struct snd_rawmidi_substream *substream)
+{
+	struct tascam_card *tascam = substream->rmidi->private_data;
+	bool in_flight = true;
+
+	while (in_flight) {
+		in_flight = false;
+		for (int i = 0; i < NUM_MIDI_OUT_URBS; i++) {
+			if (test_bit(i, &tascam->midi_out_urbs_in_flight)) {
+				in_flight = true;
+				break;
+			}
+		}
+		if (in_flight)
+			schedule_timeout_uninterruptible(1);
+	}
+
+	cancel_work_sync(&tascam->midi_out_work);
+	usb_kill_anchored_urbs(&tascam->midi_out_anchor);
+}
+
+/**
+ * tascam_midi_out_trigger() - Triggers MIDI output stream activity.
+ * @substream: The ALSA rawmidi substream.
+ * @up: Boolean indicating whether to start (1) or stop (0) the stream.
+ *
+ * This function starts or stops the MIDI output workqueue based on the
+ * 'up' parameter.
+ */
+static void tascam_midi_out_trigger(struct snd_rawmidi_substream *substream,
+				    int up)
+{
+	struct tascam_card *tascam = substream->rmidi->private_data;
+
+	if (up) {
+		atomic_set(&tascam->midi_out_active, 1);
+		schedule_work(&tascam->midi_out_work);
+	} else {
+		atomic_set(&tascam->midi_out_active, 0);
+	}
+}
+
+/**
+ * tascam_midi_out_ops - ALSA rawmidi operations for MIDI output.
+ *
+ * This structure defines the callback functions for MIDI output stream
+ * operations, including open, close, trigger, and drain.
+ */
+static const struct snd_rawmidi_ops tascam_midi_out_ops = {
+	.open = tascam_midi_out_open,
+	.close = tascam_midi_out_close,
+	.trigger = tascam_midi_out_trigger,
+	.drain = tascam_midi_out_drain,
+};
+
+int tascam_create_midi(struct tascam_card *tascam)
+{
+	int err;
+
+	err = snd_rawmidi_new(tascam->card, "US144MKII MIDI", 0, 1, 1,
+			      &tascam->rmidi);
+	if (err < 0)
+		return err;
+
+	strscpy(tascam->rmidi->name, "US144MKII MIDI",
+		sizeof(tascam->rmidi->name));
+	tascam->rmidi->private_data = tascam;
+
+	snd_rawmidi_set_ops(tascam->rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+			    &tascam_midi_in_ops);
+	snd_rawmidi_set_ops(tascam->rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
+			    &tascam_midi_out_ops);
+
+	tascam->rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT |
+				     SNDRV_RAWMIDI_INFO_OUTPUT |
+				     SNDRV_RAWMIDI_INFO_DUPLEX;
+
+	INIT_WORK(&tascam->midi_in_work, tascam_midi_in_work_handler);
+	INIT_WORK(&tascam->midi_out_work, tascam_midi_out_work_handler);
+
+	return 0;
+}
diff --git a/sound/usb/usx2y/us144mkii_pcm.c b/sound/usb/usx2y/us144mkii_pcm.c
index 47ef2fddbe54..953d5e7a7235 100644
--- a/sound/usb/usx2y/us144mkii_pcm.c
+++ b/sound/usb/usx2y/us144mkii_pcm.c
@@ -56,19 +56,60 @@ void process_playback_routing_us144mkii(struct tascam_card *tascam,
 					const u8 *src_buffer, u8 *dst_buffer,
 					size_t frames)
 {
-	/* This is a stub. Routing will be added in a later commit. */
-	if (src_buffer != dst_buffer)
-		memcpy(dst_buffer, src_buffer, frames * BYTES_PER_FRAME);
+	size_t f;
+	const u8 *src_12, *src_34;
+	u8 *dst_line, *dst_digital;
+
+	for (f = 0; f < frames; ++f) {
+		src_12 = src_buffer + f * BYTES_PER_FRAME;
+		src_34 = src_12 + (2 * BYTES_PER_SAMPLE);
+		dst_line = dst_buffer + f * BYTES_PER_FRAME;
+		dst_digital = dst_line + (2 * BYTES_PER_SAMPLE);
+
+		/* LINE OUTPUTS (ch1/2 on device) */
+		if (tascam->line_out_source == 0) /* "ch1 and ch2" */
+			memcpy(dst_line, src_12, 2 * BYTES_PER_SAMPLE);
+		else /* "ch3 and ch4" */
+			memcpy(dst_line, src_34, 2 * BYTES_PER_SAMPLE);
+
+		/* DIGITAL OUTPUTS (ch3/4 on device) */
+		if (tascam->digital_out_source == 0) /* "ch1 and ch2" */
+			memcpy(dst_digital, src_12, 2 * BYTES_PER_SAMPLE);
+		else /* "ch3 and ch4" */
+			memcpy(dst_digital, src_34, 2 * BYTES_PER_SAMPLE);
+	}
 }
 
 void process_capture_routing_us144mkii(struct tascam_card *tascam,
 				       const s32 *decoded_block,
 				       s32 *routed_block)
 {
-	/* This is a stub. Routing will be added in a later commit. */
-	memcpy(routed_block, decoded_block,
-	       FRAMES_PER_DECODE_BLOCK * DECODED_CHANNELS_PER_FRAME *
-		       DECODED_SAMPLE_SIZE);
+	int f;
+	const s32 *src_frame;
+	s32 *dst_frame;
+
+	for (f = 0; f < FRAMES_PER_DECODE_BLOCK; f++) {
+		src_frame = decoded_block + (f * DECODED_CHANNELS_PER_FRAME);
+		dst_frame = routed_block + (f * DECODED_CHANNELS_PER_FRAME);
+
+		/* ch1 and ch2 Source */
+		if (tascam->capture_12_source == 0) { /* analog inputs */
+			dst_frame[0] = src_frame[0]; /* Analog L */
+			dst_frame[1] = src_frame[1]; /* Analog R */
+		} else { /* digital inputs */
+			dst_frame[0] = src_frame[2]; /* Digital L */
+			dst_frame[1] = src_frame[3]; /* Digital R */
+		}
+
+		/* ch3 and ch4 Source */
+		if (tascam->capture_34_source == 0) { /* analog inputs */
+			dst_frame[2] = src_frame[0]; /* Analog L (Duplicate) */
+			dst_frame[3] = src_frame[1]; /* Analog R (Duplicate) */
+		} else { /* digital inputs */
+			dst_frame[2] = src_frame[2]; /* Digital L */
+			dst_frame[3] = src_frame[3]; /* Digital R */
+		}
+	}
 }
 
 int us144mkii_configure_device_for_rate(struct tascam_card *tascam, int rate)
-- 
2.39.5


