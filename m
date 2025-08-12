Return-Path: <linux-kernel+bounces-764883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D31B2285E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA995188A42F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862F327F006;
	Tue, 12 Aug 2025 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTM+WMCv"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A79527B50F;
	Tue, 12 Aug 2025 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004935; cv=none; b=R5fZ440UVD9s8X8165JnH6UEWOl22l7OMnBRB5VoLxePrZvoFJOt3BcpMyMLs+QOGrWNt6HD4I5VHLmHMMBNUzPerOgJPWRBbLZHpFOX//Ie3TNDptRx/ibJ9g2+ErVHOWEy7durHn4PbIx/ybC4FwByCgFqOLP4s3mr10UkJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004935; c=relaxed/simple;
	bh=o+xSp3EubIpQffb3y4D6KiwESyZOriGzen9hJgFzCg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9Y67yDYYj091lvI9tZvZZ9FDJeBPYeCPR6fDdMtAeMqUSA5C5BoE/Ksoxa5o2Rf5uS4g5uZqsp6ECs44bCGdz3VFVEAm6NjqjwnUC5sVuf/uegYhXmeM0b+wl5y79NXrqTdHwI9sAg/x2vw8UVc+j9Rlw12MirPtXvqePbsytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTM+WMCv; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6152faff57eso8645433a12.1;
        Tue, 12 Aug 2025 06:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755004932; x=1755609732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPJ0pN/RvHB5WLTR3vby3H9Qi10hzmuI98P3X9tF0H4=;
        b=PTM+WMCvlRf+wqZ8xjwngar6V+oSK0QofvceC2zqazqze5ciPq7WWoe8vFE9gDaoAf
         yaiXsZrZ2ETX53wcFtI5zjAuz82hYJWzGA0gjMx4krlYsn7ncV01Lq22Te98gHxzJ2hW
         qLYpJr0tpotLFBTshuOBI2cq8xh2ae6DEyVEel3Np3ze+/FoeZJA3eXB9yL316eFV6sB
         iyp++8qeEkoZPdTzd2hfAnYqmDeMXD1IZoksSbkMrtWlx7a8BgmkP/hoLSk5AbNHwUgY
         FTkrw/xgSNK69pHSKgGcby/ODrq+JXI8EWGe9gPd44WT7j1cmQpBZnSbv35aUJx2WIo9
         wxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755004932; x=1755609732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPJ0pN/RvHB5WLTR3vby3H9Qi10hzmuI98P3X9tF0H4=;
        b=wJUiDRp4l/+qGeBqqiuagBOsV02kpcN+SpHjWEM5UjQwKa7mLfiR9F7kO2TkBGX1AY
         6xjC92EkNOYvks7GKO+72nCbx9QL4eGnRUgy7iLUyOt8wdbWleeOX0Q1iiDCX0BUY9WG
         Uh9ANchUt0f4uRDlzxihXjzfC/medLQnUFZdsewE8ok3EFHxJXq2sLou7CCjnHbAHiAU
         5IuhcNbRKH29CszZdxgE+cFYmDKe81K65GZZUrOttKydm97S/hQi/JRLXVYEOmY5Z+S1
         kgDeYtpH8CC8vvRebm7uWp18FrGRQGAQR8Zh3Qzv5DfiGyozDPicRzjxncNnPcD/M98B
         Y/Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUrlfOGUZ7cIU6Z1dq8ys7q2r4A16NEvvHxnJzCMU64QmCwKYcSu47yMGChviXsGaOxPH69TXtN5KENeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEECnU5mPGmkeQrwvedbDOFAgOPlsx2SVjcrG+7VTC831w5o+1
	8Mbdtsec/nona0zOed6S+m3ion6zopwIrbCBmE5nSe3Gs9HJJudmtKIk
X-Gm-Gg: ASbGnctYUOnIVT+iUarmTaz0yIa/ByrJohD1wbeS/Cs6leY06gqfOd+YmwnztzmZMN+
	170wza2gQUc75KC0FlTv+j2iOwKwIhzIjMaOvbVSZWkbIKg5slwaauxJ88s7Jt35XOYN8lsS7Lo
	KwPIXvBh/mVlvcgfRoz6o/QNzh+SJhMQwvbDYWzNpy2ghJAri/wnxPXpEq8U0TD7TkPynmFh6u/
	iWGFxt+PZqSx2HI+Tznd1xte02bWvPXEn6IpEPZqJROSg+vCIo3eCIVfPS52ZNRix2px5esPpVq
	4QP8zr5KPMr+XX6iC8t1rlkMmDcdHKmKCNl0JBZd4JKVlmi9aePKGeMtucOQGKPFB7jDCOv6/JQ
	qB8JUtmkP214dYU4eRci6eTZcXsI1bphT96vwOIsjqtgffUtCy9m6v1eRBV12sF/aT7/i7Rw3wf
	NroaWucA==
X-Google-Smtp-Source: AGHT+IFia95DCFYqgte+hI76HZcwv8+C4vLc8tfEN/NTY3KbIvRI46bqk4OYwxKBDSfuowO9WQ1Kwg==
X-Received: by 2002:a05:6402:2791:b0:618:3182:9ef3 with SMTP id 4fb4d7f45d1cf-6184ec90610mr2606851a12.27.1755004931586;
        Tue, 12 Aug 2025 06:22:11 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61850794509sm1315511a12.31.2025.08.12.06.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:22:11 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v3 1/7] ALSA: usb-audio: Add initial driver for TASCAM US-144MKII
Date: Tue, 12 Aug 2025 15:22:03 +0200
Message-Id: <20250812132209.83728-2-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812132209.83728-1-ramiserifpersia@gmail.com>
References: <20250810124958.25309-1-ramiserifpersia@gmail.com>
 <20250812132209.83728-1-ramiserifpersia@gmail.com>
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
index 000000000000..38731a1285ea
--- /dev/null
+++ b/sound/usb/usx2y/us144mkii.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+// Copyright (c) 2025 Šerif Rami <ramiserifpersia@gmail.com>
+
+ #ifndef __US144MKII_H
+ #define __US144MKII_H
+
+ #include <linux/usb.h>
+ #include <sound/core.h>
+ #include <sound/initval.h>
+
+ #define DRIVER_NAME "us144mkii"
+
+/* --- USB Device Identification --- */
+ #define USB_VID_TASCAM 0x0644
+ #define USB_PID_TASCAM_US144 0x800f
+ #define USB_PID_TASCAM_US144MKII 0x8020
+
+/* --- USB Control Message Protocol --- */
+ #define RT_D2H_VENDOR_DEV (USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_DEVICE)
+ #define VENDOR_REQ_MODE_CONTROL 0x49
+ #define MODE_VAL_HANDSHAKE_READ 0x0000
+ #define USB_CTRL_TIMEOUT_MS 1000
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


