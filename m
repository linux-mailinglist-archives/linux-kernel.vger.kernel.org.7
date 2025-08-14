Return-Path: <linux-kernel+bounces-768576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FBFB262C1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038961CC55CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C373330149E;
	Thu, 14 Aug 2025 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTXsCvw8"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1273301036;
	Thu, 14 Aug 2025 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167142; cv=none; b=eIUsgL7RzsMnAyFnMggTJuGZ1bPbGkKrBlZj5K/00Rdu1cGr/tLaQcFd/k3XRQngjdukqsAcE2IvRkfqUBzk18+hl9ksf3KEkrwtbK2cE85G6NmUBnRef+eaVLnP1KvcGogGOBHVxoXF3rn3U2ya4WQWWPLQNRqgWRFW2LtNis4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167142; c=relaxed/simple;
	bh=pKDUrC7hgxvwgrzOicYA+xBMzPZ8xhcfhEXeXWc0PLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4htZGed4SwByXFW9+ToZh+RVtBVZbORp8hYkGsewE6a2bO3Hcm0H6+DUNjCTD8G1eIIss4MeXH991At3VJ3SoS5lobV1zuxOFAwqyVdfluQCbgJaDkHBTCv6YviALk5EYn0j1K7V04IrtKtzKSsv1+UTMwdCnDJjG1omYd+Ses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTXsCvw8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb78ead12so112208866b.1;
        Thu, 14 Aug 2025 03:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755167139; x=1755771939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsBpRceug6zBeKGJcK3RPp4MD8fKEt+4iAopQCkzTpU=;
        b=WTXsCvw8RxZQ9bMLm3L1Dpk27ryd56Fs3W+jBkNu8FAkmnAB2G3vP4W7o8QwFOZOyZ
         /8YXTljmC5HNrB7Z2cbnqCA0bmYBgFGansozXP4yAjtrhz6NnQDDJxql/FIzNUM4U1y6
         bn9W9EdPAg0wHAgKwHQhJWuI49VTrkSXFaA5aOErcMVZ0QKvt15/aQKBBxuMXUxT+UT6
         Kjy8wM3o6m5E+8cOpqQYv46eVBgaxAfiWPzrydxEvZJMedQV6r4W6hbMCndqffsNR9A7
         j9XPdCJDYH8UqPOi9TXaW+eg0Id1lNoakbxe1O6rOoRQSFw340fAFMWt1WgENPlyjxM/
         iuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755167139; x=1755771939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsBpRceug6zBeKGJcK3RPp4MD8fKEt+4iAopQCkzTpU=;
        b=ZNxBi19SqYGCx9b47VydKb5mqoZpNQkMs7rIFDB3dzK1FjEihmDo2xFyF8LKpx9sjN
         5hzefj/GrWnpUpae/aDJf30f2ouF3zloOxWliQSzrT442gLECc8il9fAXtIU8INetL8g
         Q4AkvpG55iPGUNG4RMjKl6YX3GPIB2dc3dLztGKQHCy0Ehq5CWniSVvtWtK6PWBIKKwh
         zsVQjTdacjRD9UcPZ+jHo3UJDQWSIG6BcwBwSo3v84E9EQ81umiqrAV9AiqVSh+jsL8f
         Au4m/lXDXP1qgRKybOd0XTFNUhBazgEPml3gwsHVejzoxJf0usqDQa5TwhWXyQvjSPa6
         c40A==
X-Forwarded-Encrypted: i=1; AJvYcCXQqO5+iwdaJnXcW4TICsnrfmPGuQBnoMkIZPnHJlmCwyHDFE10Pr+s6Jj7SiUrgFwQpyvoC2mMsoPITw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlH+Ou36sYvNisXiClY/iXhM0/QIKz8tkauejFc0O7iIKGeDYi
	7QXgsLY6kUCBNWNkl68qzbFwlDkvFmnOsU1vozLklfDIGBaMeN1mBnPm
X-Gm-Gg: ASbGnctKsCvXq4KboPiuMssNh/Qm344c418bFSRHjLt9rAaYW4ePhUqRiWXKiz/z87x
	QNekB+FxW4/N7Fr1fsthc7u4+5BxujnU2NW+sfM0p68re9MevlOjCPIGs6fNIdwyP0yTryt9IbH
	2gCShLsAHm4ZeNsZSIbAP8P2D43C89AiUYhuo0t1F3SfNlxOC4KkY+P6z13arP2y77UN03nVdIf
	mDuk3dCok59GPO5Y2iI+kdelBi3HUG8UHFFp/yBqpi5AKjSoVgfizmrMWYa5MYNShL3RQ7aF5re
	lUaHoTD9P+sVGWM7cQ4933/5nC6df1t67iXyd/59FYFKg++AboJ1bu0GG5mVzyR7DNPJadmuuQj
	jdU1nb7bnfOWlqmrxFK7K4RKsYGM6dQN/g/0ArexnKzaK91SKe/9/rICMFk/WyWA5La7M4cIMvC
	It2EFCWA==
X-Google-Smtp-Source: AGHT+IF9UJqQFfrXB2INJFX0LYdUG5/3OO3fqofzbIi8Q8nI4EXGeAwjPO8h87fRqD16zfFrAf13Jw==
X-Received: by 2002:a17:907:9406:b0:af9:4075:4ea5 with SMTP id a640c23a62f3a-afcb97e05a5mr263091766b.25.1755167138417;
        Thu, 14 Aug 2025 03:25:38 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a219ef2sm2564819466b.96.2025.08.14.03.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:25:38 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v5 1/7] ALSA: usb-audio: Add initial driver for TASCAM US-144MKII
Date: Thu, 14 Aug 2025 12:25:28 +0200
Message-Id: <20250814102534.34439-2-ramiserifpersia@gmail.com>
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

This patch introduces a new driver for the TASCAM US-144MKII USB
audio/MIDI interface.

It includes the basic driver structure for probing and disconnecting from
the USB device. It correctly identifies the device using its VID/PID,
performs the necessary initial handshake, and sets the required USB
interface alternate settings to prepare the device for operation.

At this point, no ALSA devices (PCM or MIDI) are created. This commit
forms the foundational skeleton upon which audio and MIDI functionality
will be built.

Signed-off-by: Šerif Rami <ramiserifpersia@gmail.com>
---
 sound/usb/usx2y/us144mkii.c | 248 ++++++++++++++++++++++++++++++++++++
 sound/usb/usx2y/us144mkii.h |  38 ++++++
 2 files changed, 286 insertions(+)
 create mode 100644 sound/usb/usx2y/us144mkii.c
 create mode 100644 sound/usb/usx2y/us144mkii.h

diff --git a/sound/usb/usx2y/us144mkii.c b/sound/usb/usx2y/us144mkii.c
new file mode 100644
index 000000000000..f438f222baec
--- /dev/null
+++ b/sound/usb/usx2y/us144mkii.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2025 Šerif Rami <ramiserifpersia@gmail.com>
+/*
+ * ALSA Driver for TASCAM US-144MKII Audio Interface
+ */
+
+#include "us144mkii.h"
+
+MODULE_AUTHOR("Šerif Rami <ramiserifpersia@gmail.com>");
+MODULE_DESCRIPTION("ALSA Driver for TASCAM US-144MKII");
+MODULE_LICENSE("GPL");
+
+/**
+ * @brief Module parameters for ALSA card instantiation.
+ *
+ * These parameters allow users to configure how the ALSA sound card
+ * for the TASCAM US-144MKII is instantiated.
+ *
+ * @param index: Array of integers specifying the ALSA card index for each
+ * device. Defaults to -1 (automatic).
+ * @param id: Array of strings specifying the ALSA card ID for each device.
+ *            Defaults to "US144MKII".
+ * @param enable: Array of booleans to enable or disable each device.
+ *                Defaults to {1, 0, ..., 0} (first device enabled).
+ * @param dev_idx: Internal counter for probed TASCAM devices.
+ */
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
+static bool enable[SNDRV_CARDS] = { 1, [1 ...(SNDRV_CARDS - 1)] = 0 };
+static int dev_idx;
+
+static int tascam_probe(struct usb_interface *intf,
+			const struct usb_device_id *usb_id);
+static void tascam_disconnect(struct usb_interface *intf);
+static int tascam_suspend(struct usb_interface *intf, pm_message_t message);
+static int tascam_resume(struct usb_interface *intf);
+
+/**
+ * tascam_card_private_free() - Frees private data for the sound card.
+ * card.
+ * @card: Pointer to the ALSA sound card instance.
+ *
+ * This function is called when the sound card is being freed. It releases
+ * the reference to the USB device.
+ */
+static void tascam_card_private_free(struct snd_card *card)
+{
+	struct tascam_card *tascam = card->private_data;
+
+	if (tascam && tascam->dev) {
+		usb_put_dev(tascam->dev);
+		tascam->dev = NULL;
+	}
+}
+
+/**
+ * tascam_probe() - Probes for the TASCAM US-144MKII device.
+ * @intf: The USB interface being probed.
+ * @usb_id: The USB device ID.
+ *
+ * This function is the entry point for the USB driver on device match.
+ * is found. It performs initial device setup, including:
+ * - Checking for the second interface (MIDI) and associating it.
+ * - Performing a vendor-specific handshake with the device.
+ * - Setting alternate settings for USB interfaces.
+ * - Creating and registering the ALSA sound card.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int tascam_probe(struct usb_interface *intf,
+			const struct usb_device_id *usb_id)
+{
+	struct usb_device *dev = interface_to_usbdev(intf);
+	struct snd_card *card;
+	struct tascam_card *tascam;
+	int err;
+	char *handshake_buf __free(kfree) = NULL;
+
+	if (dev->speed != USB_SPEED_HIGH)
+		dev_info(
+			&dev->dev,
+			"Device is connected to a USB 1.1 port, this is not supported.\n");
+
+	/* The device has two interfaces; we drive both from this driver. */
+	if (intf->cur_altsetting->desc.bInterfaceNumber == 1) {
+		tascam = usb_get_intfdata(usb_ifnum_to_if(dev, 0));
+		if (tascam) {
+			usb_set_intfdata(intf, tascam);
+			tascam->iface1 = intf;
+		}
+		return 0; /* Let the core handle this interface */
+	}
+
+	if (dev_idx >= SNDRV_CARDS) {
+		dev_err(&dev->dev, "Too many TASCAM devices present");
+		return -ENODEV;
+	}
+
+	if (!enable[dev_idx]) {
+		dev_info(&dev->dev, "TASCAM US-144MKII device disabled");
+		return -ENOENT;
+	}
+
+	handshake_buf = kmalloc(1, GFP_KERNEL);
+	if (!handshake_buf)
+		return -ENOMEM;
+
+	/* Perform vendor-specific handshake */
+	err = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
+			      VENDOR_REQ_MODE_CONTROL, RT_D2H_VENDOR_DEV,
+			      MODE_VAL_HANDSHAKE_READ, 0x0000, handshake_buf, 1,
+			      USB_CTRL_TIMEOUT_MS);
+	if (err < 0) {
+		dev_err(&dev->dev, "Handshake read failed with %d\n", err);
+		return err;
+	}
+
+	if (handshake_buf[0] != 0x12 && handshake_buf[0] != 0x16 &&
+	    handshake_buf[0] != 0x30) {
+		dev_err(&dev->dev, "Unexpected handshake value: 0x%x\n",
+			handshake_buf[0]);
+		return -ENODEV;
+	}
+
+	/* Set alternate settings to enable audio/MIDI endpoints */
+	err = usb_set_interface(dev, 0, 1);
+	if (err < 0) {
+		dev_err(&dev->dev,
+			"Failed to set alt setting 1 on interface 0: %d\n",
+			err);
+		return err;
+	}
+
+	err = usb_set_interface(dev, 1, 1);
+	if (err < 0) {
+		dev_err(&dev->dev,
+			"Failed to set alt setting 1 on interface 1: %d\n",
+			err);
+		return err;
+	}
+
+	err = snd_card_new(&dev->dev, index[dev_idx], id[dev_idx], THIS_MODULE,
+			   sizeof(struct tascam_card), &card);
+	if (err < 0) {
+		dev_err(&dev->dev, "Failed to create sound card instance\n");
+		return err;
+	}
+
+	tascam = card->private_data;
+	card->private_free = tascam_card_private_free;
+	tascam->dev = usb_get_dev(dev);
+	tascam->card = card;
+	tascam->iface0 = intf;
+
+	strscpy(card->driver, DRIVER_NAME, sizeof(card->driver));
+	if (dev->descriptor.idProduct == USB_PID_TASCAM_US144) {
+		strscpy(card->shortname, "TASCAM US-144",
+			sizeof(card->shortname));
+	} else if (dev->descriptor.idProduct == USB_PID_TASCAM_US144MKII) {
+		strscpy(card->shortname, "TASCAM US-144MKII",
+			sizeof(card->shortname));
+	} else {
+		strscpy(card->shortname, "TASCAM Unknown",
+			sizeof(card->shortname));
+	}
+	snprintf(card->longname, sizeof(card->longname), "%s (%04x:%04x) at %s",
+		 card->shortname, USB_VID_TASCAM, dev->descriptor.idProduct,
+		 dev_name(&dev->dev));
+
+	err = snd_card_register(card);
+	if (err < 0)
+		goto free_card;
+
+	usb_set_intfdata(intf, tascam);
+
+	dev_idx++;
+	return 0;
+
+free_card:
+	snd_card_free(card);
+	return err;
+}
+
+/**
+ * tascam_disconnect() - Disconnects the TASCAM US-144MKII device.
+ * @intf: The USB interface being disconnected.
+ *
+ * This function is called when the device is disconnected from the system.
+ * It cleans up all allocated resources by freeing the sound card.
+ */
+static void tascam_disconnect(struct usb_interface *intf)
+{
+	struct tascam_card *tascam = usb_get_intfdata(intf);
+
+	if (!tascam)
+		return;
+
+	if (intf->cur_altsetting->desc.bInterfaceNumber == 0) {
+		snd_card_disconnect(tascam->card);
+		snd_card_free(tascam->card);
+		dev_idx--;
+	}
+}
+
+/**
+ * tascam_suspend() - Handles device suspension.
+ * @intf: The USB interface being suspended.
+ * @message: Power management message.
+ *
+ * This function is a stub for handling device suspension.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	return 0;
+}
+
+/**
+ * tascam_resume() - Handles device resumption from suspend.
+ * @intf: The USB interface being resumed.
+ *
+ * This function is a stub for handling device resumption.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_resume(struct usb_interface *intf)
+{
+	return 0;
+}
+
+static const struct usb_device_id tascam_usb_ids[] = {
+	{ USB_DEVICE(USB_VID_TASCAM, USB_PID_TASCAM_US144) },
+	{ USB_DEVICE(USB_VID_TASCAM, USB_PID_TASCAM_US144MKII) },
+	{ /* Terminating entry */ }
+};
+MODULE_DEVICE_TABLE(usb, tascam_usb_ids);
+
+static struct usb_driver tascam_alsa_driver = {
+	.name = DRIVER_NAME,
+	.probe = tascam_probe,
+	.disconnect = tascam_disconnect,
+	.suspend = tascam_suspend,
+	.resume = tascam_resume,
+	.id_table = tascam_usb_ids,
+};
+
+module_usb_driver(tascam_alsa_driver);
diff --git a/sound/usb/usx2y/us144mkii.h b/sound/usb/usx2y/us144mkii.h
new file mode 100644
index 000000000000..9f59863fab57
--- /dev/null
+++ b/sound/usb/usx2y/us144mkii.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+// Copyright (c) 2025 Šerif Rami <ramiserifpersia@gmail.com>
+
+#ifndef __US144MKII_H
+#define __US144MKII_H
+
+#include <linux/usb.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+
+#define DRIVER_NAME "us144mkii"
+
+/* --- USB Device Identification --- */
+#define USB_VID_TASCAM 0x0644
+#define USB_PID_TASCAM_US144 0x800f
+#define USB_PID_TASCAM_US144MKII 0x8020
+
+/* --- USB Control Message Protocol --- */
+#define RT_D2H_VENDOR_DEV (USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_DEVICE)
+#define VENDOR_REQ_MODE_CONTROL 0x49
+#define MODE_VAL_HANDSHAKE_READ 0x0000
+#define USB_CTRL_TIMEOUT_MS 1000
+
+/**
+ * struct tascam_card - Driver data structure for TASCAM US-144MKII.
+ * @dev: Pointer to the USB device.
+ * @iface0: Pointer to USB interface 0 (audio).
+ * @iface1: Pointer to USB interface 1 (MIDI).
+ * @card: Pointer to the ALSA sound card instance.
+ */
+struct tascam_card {
+	struct usb_device *dev;
+	struct usb_interface *iface0;
+	struct usb_interface *iface1;
+	struct snd_card *card;
+};
+
+ #endif /* __US144MKII_H */
-- 
2.39.5


