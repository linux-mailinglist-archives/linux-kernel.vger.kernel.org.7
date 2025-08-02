Return-Path: <linux-kernel+bounces-754145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68343B18E9B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 15:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5F5561907
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 13:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB93423817F;
	Sat,  2 Aug 2025 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpYda5UX"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E79218AA0;
	Sat,  2 Aug 2025 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754140198; cv=none; b=J4Xb5o50444Yrw4sv3/XktKjZ0uKZThZPjcL87jyS6J/k5a4di/YXZLeTGFSpG40lrmU70M4dtna0ynoj/rDxzqD5x5OBzltAehko9xxffF0pvhgFpnEks+tq4yWMkQxzVKKELN+P29xMm5OiqIEwsrVtDW1WRHZGSKFf9A1QJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754140198; c=relaxed/simple;
	bh=+fjEitTWUqymG1AswjZlKY18yA+zriS2DkP+mvQ+Fls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUGkASF3V9TrmiiojtTJFTuEJoYkdsdQ2YBaVtXKYClzPmHcOQaBzkPj1nqc9qLxw8obdxa9xvkghxB2O2cjX7nWTHTVbBX1A0RYDRG7sxMPAxloasG24w7TZsgVDrYrX9WjhhrCaGt5X5O33slX1S47kISKxaE/C5yxapkvvcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpYda5UX; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-87c46159b24so78354239f.0;
        Sat, 02 Aug 2025 06:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754140192; x=1754744992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzSwzCGUW7kjtHwD6H4ENTzR/mob9U3zvPELdRMVvi8=;
        b=IpYda5UX0Kr8r3JEwIDlsYMrjoMMe4geHiHgRhSP5qQHux1nEJlvRw7EwwRCnsCVLN
         AJnwl6y7U7yuu9XQcrhfQ7Gh4wagUrt+D/M6vHSLYhDHhbrmW0ST8GTmzWYy/Rm6irK5
         sMK9Yf+fBWjNW2J3glhq3Ig7eZWoJPBmlrptt/xdD4GSs41V7sfx7U3zQGfTSpzeKSg/
         hpP4kQa0GatA2ROfsQy1OOOwED59Ex1GEDG8aPQ+wK3+Cv20E8JiVm2avRKmwfZMHvv1
         7e0KfxYp00Zu3z4a613H8hGAwhtyy09LmTlflq4y1vTtmdp+TJh1M0stSG0QBvDInopI
         GtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754140192; x=1754744992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RzSwzCGUW7kjtHwD6H4ENTzR/mob9U3zvPELdRMVvi8=;
        b=VmYZhVEB8En+bF7iX7aevsVZyDtIwAaDNBkR+78ORSQcT3tXB0oRItibN8mIOz8yK2
         iw/Clb0qThbNia0AzUArRz4M0WccuSbkwPwZ8EfRvXERNLbt2j53qc5UlQMWeAnPMhGY
         uIibo+G/R1FIt+itTPRqmOgM+w8wiYzbCGX9SR9O1n2COua/Z/K8cG5wOjaqREhsRpBG
         Foe+M6U+OmYlg18uNkenxCkRbj0ERK69BDN8dIJG4b4n61ugNis8ug+Ne6mc4188jM/v
         BOKCSCnpe6WVmIM0/cEYEsP5d1hAUnrdrNsHpmDIM1m5SF4mjq6xzR7GsjNQE7/hh+uh
         xRfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPtWH55E9DoaaeOpZcNn88AsZdvo2L67zFthwoPAbtImSJUOczZBF16Xo5iSYnYQA+wurpseZEKpwvXNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDpP8bECneZNJ4dUCOPGNDfsIBeq4JBkXFdk1SIkDgi4nnhG2i
	RnrkeaaIR2TmaDkVAH/inkhqD37uqb8+vFT1kXRmVhhKi67V57KcbEZPqD9s4Np9Z7m0hSr1hDm
	YFAeW0D5wRGjXQ8OufhSLz/zjMAek5NwiyRO77xQ=
X-Gm-Gg: ASbGnctFBLyK/JbrCq+YlUzHwKKs8VC3E/e3uzHTpdBqHH2vBSRAP4xeQgMjrl+Zb7G
	ylHuFOkBNOavjYHT7id8UanPPT4MzUFpPK9fqnGRrX/VQaNiL4Goz+GAHRvRbbr6oIeIJ20zAmo
	sg7SEH2t4iOIYeShd6U3QZS2hbb4NdD0mCm62nA0RuuNoYiuphHfM8knE6x71XEgh+SBkgycSO0
	QHvqWaa7TYTj2pJPA==
X-Google-Smtp-Source: AGHT+IGxb6uYeFBc10r7YvDKnpGQbmf/OgRHMtmupoAZXFXbYHHhVyuGNnJbR339A3yfnQzuJiCYJoeAjIMwKHI4Kas=
X-Received: by 2002:a05:6e02:2194:b0:3e3:fc32:3178 with SMTP id
 e9e14a558f8ab-3e4162d3021mr51339765ab.8.1754140190402; Sat, 02 Aug 2025
 06:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF1NMdC2QouNLdgCFXmFhu5V4UVttGxF9VjL2KkkMeSthC_zJA@mail.gmail.com>
In-Reply-To: <CAF1NMdC2QouNLdgCFXmFhu5V4UVttGxF9VjL2KkkMeSthC_zJA@mail.gmail.com>
From: serifpersia <ramiserifpersia@gmail.com>
Date: Sat, 2 Aug 2025 15:09:38 +0200
X-Gm-Features: Ac12FXzzoxZYIYSZObRXzjgK46GPyTwfmiWwlrn1kRZKDwUIYbhg761FvZzZ88w
Message-ID: <CAF1NMdC11QKXmg_XU=Wb3VUcd3XgW4DsjVi10j-TaS_fXsYeHA@mail.gmail.com>
Subject: Re: [RSC PATCH v2] ALSA: usb-audio: Add support for TASCAM US-144MKII
To: perex@perex.cz, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi there again,

My initial patch had a compile error due to code style changes. This
patch should work without any hiccups.
Hopefully this isn't an issue.

Thanks,
---
diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index 41c47301b..ef6be7c06 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -117,6 +117,19 @@ config SND_USB_US122L
       To compile this driver as a module, choose M here: the module
       will be called snd-usb-us122l.

+config SND_USB_US144MKII
+    tristate "Tascam US-144MKII USB driver"
+    depends on X86 || COMPILE_TEST
+    select SND_HWDEP
+    select SND_RAWMIDI
+    select SND_PCM
+    help
+      Say Y here to include support for Tascam US-144MKII USB Audio/MIDI
+      interfaces.
+
+      To compile this driver as a module, choose M here: the module
+      will be called snd-usb-us144mkii.
+
 config SND_USB_6FIRE
     tristate "TerraTec DMX 6Fire USB"
     select FW_LOADER
diff --git a/sound/usb/usx2y/Makefile b/sound/usb/usx2y/Makefile
index fc033aba0..5adee9898 100644
--- a/sound/usb/usx2y/Makefile
+++ b/sound/usb/usx2y/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 snd-usb-usx2y-y :=3D usbusx2y.o usX2Yhwdep.o usx2yhwdeppcm.o
 snd-usb-us122l-y :=3D us122l.o
+snd-usb-us144mkii-y :=3D us144mkii.o us144mkii_capture.o
us144mkii_playback.o us144mkii_midi.o us144mkii_controls.o
us144mkii_pcm.o

 obj-$(CONFIG_SND_USB_USX2Y) +=3D snd-usb-usx2y.o
 obj-$(CONFIG_SND_USB_US122L) +=3D snd-usb-us122l.o
+obj-$(CONFIG_SND_USB_US144MKII) +=3D snd-usb-us144mkii.o
diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index 2ace3ba46..9428c1bb5 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -33,8 +33,7 @@ MODULE_PARM_DESC(id, "ID string for "NAME_ALLCAPS".");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable "NAME_ALLCAPS".");

-/* driver_info flags */
-#define US122L_FLAG_US144    BIT(0)
+

 static int snd_us122l_card_used[SNDRV_CARDS];

@@ -60,27 +59,7 @@ static int us122l_create_usbmidi(struct snd_card *card)
                   &US122L(card)->midi_list, &quirk);
 }

-static int us144_create_usbmidi(struct snd_card *card)
-{
-    static const struct snd_usb_midi_endpoint_info quirk_data =3D {
-        .out_ep =3D 4,
-        .in_ep =3D 3,
-        .out_cables =3D    0x001,
-        .in_cables =3D    0x001
-    };
-    static const struct snd_usb_audio_quirk quirk =3D {
-        .vendor_name =3D    "US144",
-        .product_name =3D    NAME_ALLCAPS,
-        .ifnum =3D    0,
-        .type =3D QUIRK_MIDI_US122L,
-        .data =3D &quirk_data
-    };
-    struct usb_device *dev =3D US122L(card)->dev;
-    struct usb_interface *iface =3D usb_ifnum_to_if(dev, 0);

-    return snd_usbmidi_create(card, iface,
-                  &US122L(card)->midi_list, &quirk);
-}

 static void pt_info_set(struct usb_device *dev, u8 v)
 {
@@ -493,7 +472,7 @@ static int usx2y_create_card(struct usb_device *device,
     mutex_init(&US122L(card)->mutex);
     US122L(card)->sk.dev =3D device;
     init_waitqueue_head(&US122L(card)->sk.sleep);
-    US122L(card)->is_us144 =3D flags & US122L_FLAG_US144;
+
     INIT_LIST_HEAD(&US122L(card)->midi_list);
     strscpy(card->driver, "USB "NAME_ALLCAPS"");
     sprintf(card->shortname, "TASCAM "NAME_ALLCAPS"");
@@ -686,12 +665,7 @@ static const struct usb_device_id
snd_us122l_usb_id_table[] =3D {
         .idVendor =3D    0x0644,
         .idProduct =3D    USB_ID_US122MKII
     },
-    {
-        .match_flags =3D    USB_DEVICE_ID_MATCH_DEVICE,
-        .idVendor =3D    0x0644,
-        .idProduct =3D    USB_ID_US144MKII,
-        .driver_info =3D    US122L_FLAG_US144
-    },
+
     { /* terminator */ }
 };
 MODULE_DEVICE_TABLE(usb, snd_us122l_usb_id_table);
diff --git a/sound/usb/usx2y/us144mkii.c b/sound/usb/usx2y/us144mkii.c
new file mode 100644
index 000000000..e5e863531
--- /dev/null
+++ b/sound/usb/usx2y/us144mkii.c
@@ -0,0 +1,610 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2025 =C5=A0erif Rami <ramiserifpersia@gmail.com>
+/*
+ * ALSA Driver for TASCAM US-144MKII Audio Interface
+ */
+
+#include "us144mkii.h"
+
+MODULE_AUTHOR("=C5=A0erif Rami <ramiserifpersia@gmail.com>");
+MODULE_DESCRIPTION("ALSA Driver for TASCAM US-144MKII");
+MODULE_LICENSE("GPL v2");
+
+/**
+ * @brief Module parameters for ALSA card instantiation.
+ *
+ * These parameters allow users to configure how the ALSA sound card
+ * for the TASCAM US-144MKII is instantiated.
+ *
+ * @param index: Array of integers specifying the ALSA card index for
each device.
+ *               Defaults to -1 (automatic).
+ * @param id: Array of strings specifying the ALSA card ID for each device=
.
+ *            Defaults to "US144MKII".
+ * @param enable: Array of booleans to enable or disable each device.
+ *                Defaults to {1, 0, ..., 0} (first device enabled).
+ * @param dev_idx: Internal counter for the number of TASCAM devices probe=
d.
+ */
+static int index[SNDRV_CARDS] =3D SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS] =3D SNDRV_DEFAULT_STR;
+static bool enable[SNDRV_CARDS] =3D {1, [1 ... (SNDRV_CARDS - 1)] =3D 0};
+static int dev_idx;
+
+static struct usb_driver tascam_alsa_driver;
+
+/* --- Forward Declarations --- */
+static int tascam_probe(struct usb_interface *intf, const struct
usb_device_id *usb_id);
+static void tascam_disconnect(struct usb_interface *intf);
+static int tascam_suspend(struct usb_interface *intf, pm_message_t message=
);
+static int tascam_resume(struct usb_interface *intf);
+
+/**
+ * driver_version_show() - Sysfs attribute to display the driver version.
+ * @dev: Pointer to the device structure.
+ * @attr: Pointer to the device attribute structure.
+ * @buf: Buffer to write the version string into.
+ *
+ * This function is a sysfs callback that provides the current driver vers=
ion
+ * string to user-space when the 'driver_version' attribute is read.
+ *
+ * Return: The number of bytes written to the buffer.
+ */
+static ssize_t driver_version_show(struct device *dev,
+                   struct device_attribute *attr, char *buf)
+{
+    return sysfs_emit(buf, "%s\n", DRIVER_VERSION);
+}
+static DEVICE_ATTR_RO(driver_version);
+
+
+/**
+ * tascam_free_urbs() - Free all allocated URBs and associated buffers.
+ * @tascam: the tascam_card instance
+ *
+ * This function kills, unlinks, and frees all playback, feedback,
+ * capture, and MIDI URBs, along with their transfer buffers and the
+ * capture ring/decode buffers.
+ */
+void tascam_free_urbs(struct tascam_card *tascam)
+{
+    int i;
+
+    usb_kill_anchored_urbs(&tascam->playback_anchor);
+    for (i =3D 0; i < NUM_PLAYBACK_URBS; i++) {
+        if (tascam->playback_urbs[i]) {
+            usb_free_coherent(tascam->dev, tascam->playback_urb_alloc_size=
,
+                      tascam->playback_urbs[i]->transfer_buffer,
+                      tascam->playback_urbs[i]->transfer_dma);
+            usb_free_urb(tascam->playback_urbs[i]);
+            tascam->playback_urbs[i] =3D NULL;
+        }
+    }
+
+    usb_kill_anchored_urbs(&tascam->feedback_anchor);
+    for (i =3D 0; i < NUM_FEEDBACK_URBS; i++) {
+        if (tascam->feedback_urbs[i]) {
+            usb_free_coherent(tascam->dev, tascam->feedback_urb_alloc_size=
,
+                      tascam->feedback_urbs[i]->transfer_buffer,
+                      tascam->feedback_urbs[i]->transfer_dma);
+            usb_free_urb(tascam->feedback_urbs[i]);
+            tascam->feedback_urbs[i] =3D NULL;
+        }
+    }
+
+    usb_kill_anchored_urbs(&tascam->capture_anchor);
+    for (i =3D 0; i < NUM_CAPTURE_URBS; i++) {
+        if (tascam->capture_urbs[i]) {
+            usb_free_coherent(tascam->dev, tascam->capture_urb_alloc_size,
+                      tascam->capture_urbs[i]->transfer_buffer,
+                      tascam->capture_urbs[i]->transfer_dma);
+            usb_free_urb(tascam->capture_urbs[i]);
+            tascam->capture_urbs[i] =3D NULL;
+        }
+    }
+
+    usb_kill_anchored_urbs(&tascam->midi_in_anchor);
+    for (i =3D 0; i < NUM_MIDI_IN_URBS; i++) {
+        if (tascam->midi_in_urbs[i]) {
+            usb_free_coherent(tascam->dev, MIDI_IN_BUF_SIZE,
+                      tascam->midi_in_urbs[i]->transfer_buffer,
+                      tascam->midi_in_urbs[i]->transfer_dma);
+            usb_free_urb(tascam->midi_in_urbs[i]);
+            tascam->midi_in_urbs[i] =3D NULL;
+        }
+    }
+
+    usb_kill_anchored_urbs(&tascam->midi_out_anchor);
+    for (i =3D 0; i < NUM_MIDI_OUT_URBS; i++) {
+        if (tascam->midi_out_urbs[i]) {
+            usb_free_coherent(tascam->dev, MIDI_OUT_BUF_SIZE,
+                      tascam->midi_out_urbs[i]->transfer_buffer,
+                      tascam->midi_out_urbs[i]->transfer_dma);
+            usb_free_urb(tascam->midi_out_urbs[i]);
+            tascam->midi_out_urbs[i] =3D NULL;
+        }
+    }
+
+    kfree(tascam->playback_routing_buffer);
+    tascam->playback_routing_buffer =3D NULL;
+    kfree(tascam->capture_routing_buffer);
+    tascam->capture_routing_buffer =3D NULL;
+    kfree(tascam->capture_decode_dst_block);
+    tascam->capture_decode_dst_block =3D NULL;
+    kfree(tascam->capture_decode_raw_block);
+    tascam->capture_decode_raw_block =3D NULL;
+    kfree(tascam->capture_ring_buffer);
+    tascam->capture_ring_buffer =3D NULL;
+}
+
+/**
+ * tascam_alloc_urbs() - Allocate all URBs and associated buffers.
+ * @tascam: the tascam_card instance
+ *
+ * This function allocates and initializes all URBs for playback, feedback=
,
+ * capture, and MIDI, as well as the necessary buffers for data processing=
.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int tascam_alloc_urbs(struct tascam_card *tascam)
+{
+    int i;
+    size_t max_packet_size;
+
+    max_packet_size =3D ((96000 / 8000) + 2) * BYTES_PER_FRAME;
+    tascam->playback_urb_alloc_size =3D max_packet_size * PLAYBACK_URB_PAC=
KETS;
+
+    for (i =3D 0; i < NUM_PLAYBACK_URBS; i++) {
+        struct urb *urb =3D usb_alloc_urb(PLAYBACK_URB_PACKETS, GFP_KERNEL=
);
+
+        if (!urb)
+            goto error;
+        tascam->playback_urbs[i] =3D urb;
+
+        urb->transfer_buffer =3D usb_alloc_coherent(tascam->dev,
tascam->playback_urb_alloc_size,
+                        GFP_KERNEL, &urb->transfer_dma);
+        if (!urb->transfer_buffer)
+            goto error;
+
+        urb->dev =3D tascam->dev;
+        urb->pipe =3D usb_sndisocpipe(tascam->dev, EP_AUDIO_OUT);
+        urb->transfer_flags =3D URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
+        urb->interval =3D 1;
+        urb->context =3D tascam;
+        urb->complete =3D playback_urb_complete;
+    }
+
+    tascam->feedback_urb_alloc_size =3D FEEDBACK_PACKET_SIZE *
MAX_FEEDBACK_PACKETS;
+
+    for (i =3D 0; i < NUM_FEEDBACK_URBS; i++) {
+        struct urb *f_urb =3D usb_alloc_urb(MAX_FEEDBACK_PACKETS, GFP_KERN=
EL);
+
+        if (!f_urb)
+            goto error;
+        tascam->feedback_urbs[i] =3D f_urb;
+
+        f_urb->transfer_buffer =3D usb_alloc_coherent(tascam->dev,
tascam->feedback_urb_alloc_size,
+                          GFP_KERNEL, &f_urb->transfer_dma);
+        if (!f_urb->transfer_buffer)
+            goto error;
+
+        f_urb->dev =3D tascam->dev;
+        f_urb->pipe =3D usb_rcvisocpipe(tascam->dev, EP_PLAYBACK_FEEDBACK)=
;
+        f_urb->transfer_flags =3D URB_ISO_ASAP | URB_NO_TRANSFER_DMA_MAP;
+        f_urb->interval =3D 4;
+        f_urb->context =3D tascam;
+        f_urb->complete =3D feedback_urb_complete;
+    }
+
+    tascam->capture_urb_alloc_size =3D CAPTURE_URB_SIZE;
+    for (i =3D 0; i < NUM_CAPTURE_URBS; i++) {
+        struct urb *c_urb =3D usb_alloc_urb(0, GFP_KERNEL);
+
+        if (!c_urb)
+            goto error;
+        tascam->capture_urbs[i] =3D c_urb;
+
+        c_urb->transfer_buffer =3D usb_alloc_coherent(tascam->dev,
tascam->capture_urb_alloc_size,
+                          GFP_KERNEL, &c_urb->transfer_dma);
+        if (!c_urb->transfer_buffer)
+            goto error;
+
+        usb_fill_bulk_urb(c_urb, tascam->dev,
+                  usb_rcvbulkpipe(tascam->dev, EP_AUDIO_IN),
+                  c_urb->transfer_buffer,
+                  tascam->capture_urb_alloc_size,
+                  capture_urb_complete,
+                  tascam);
+        c_urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
+    }
+
+    /* MIDI URB and buffer allocation */
+    for (i =3D 0; i < NUM_MIDI_IN_URBS; i++) {
+        struct urb *m_urb =3D usb_alloc_urb(0, GFP_KERNEL);
+
+        if (!m_urb)
+            goto error;
+        tascam->midi_in_urbs[i] =3D m_urb;
+        m_urb->transfer_buffer =3D usb_alloc_coherent(tascam->dev,
+            MIDI_IN_BUF_SIZE, GFP_KERNEL, &m_urb->transfer_dma);
+        if (!m_urb->transfer_buffer)
+            goto error;
+        usb_fill_bulk_urb(m_urb, tascam->dev,
usb_rcvbulkpipe(tascam->dev, EP_MIDI_IN),
+                  m_urb->transfer_buffer, MIDI_IN_BUF_SIZE,
+                  tascam_midi_in_urb_complete,
+                  tascam);
+        m_urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
+    }
+
+    for (i =3D 0; i < NUM_MIDI_OUT_URBS; i++) {
+        struct urb *m_urb =3D usb_alloc_urb(0, GFP_KERNEL);
+
+        if (!m_urb)
+            goto error;
+        tascam->midi_out_urbs[i] =3D m_urb;
+        m_urb->transfer_buffer =3D usb_alloc_coherent(tascam->dev,
+            MIDI_OUT_BUF_SIZE, GFP_KERNEL, &m_urb->transfer_dma);
+        if (!m_urb->transfer_buffer)
+            goto error;
+        usb_fill_bulk_urb(m_urb, tascam->dev,
+                  usb_sndbulkpipe(tascam->dev, EP_MIDI_OUT),
+                  m_urb->transfer_buffer, 0, /* length set later */
+                  tascam_midi_out_urb_complete,
+                  tascam);
+        m_urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
+    }
+
+    tascam->capture_ring_buffer =3D kmalloc(CAPTURE_RING_BUFFER_SIZE,
GFP_KERNEL);
+    if (!tascam->capture_ring_buffer)
+        goto error;
+
+    tascam->capture_decode_raw_block =3D
kmalloc(RAW_BYTES_PER_DECODE_BLOCK, GFP_KERNEL);
+    if (!tascam->capture_decode_raw_block)
+        goto error;
+
+    tascam->capture_decode_dst_block =3D
kmalloc(FRAMES_PER_DECODE_BLOCK * DECODED_CHANNELS_PER_FRAME *
DECODED_SAMPLE_SIZE, GFP_KERNEL);
+    if (!tascam->capture_decode_dst_block)
+        goto error;
+
+    tascam->playback_routing_buffer =3D
kmalloc(tascam->playback_urb_alloc_size, GFP_KERNEL);
+    if (!tascam->playback_routing_buffer)
+        goto error;
+
+    tascam->capture_routing_buffer =3D kmalloc(FRAMES_PER_DECODE_BLOCK
* DECODED_CHANNELS_PER_FRAME * DECODED_SAMPLE_SIZE, GFP_KERNEL);
+    if (!tascam->capture_routing_buffer)
+        goto error;
+
+    return 0;
+
+error:
+    dev_err(tascam->card->dev, "Failed to allocate URBs\n");
+    tascam_free_urbs(tascam);
+    return -ENOMEM;
+}
+
+void tascam_stop_work_handler(struct work_struct *work)
+{
+    struct tascam_card *tascam =3D container_of(work, struct
tascam_card, stop_work);
+
+    usb_kill_anchored_urbs(&tascam->playback_anchor);
+    usb_kill_anchored_urbs(&tascam->feedback_anchor);
+    usb_kill_anchored_urbs(&tascam->capture_anchor);
+    atomic_set(&tascam->active_urbs, 0);
+    cancel_work_sync(&tascam->capture_work);
+}
+
+/**
+ * tascam_card_private_free() - Frees private data associated with
the sound card.
+ * @card: Pointer to the ALSA sound card instance.
+ *
+ * This function is called when the sound card is being freed. It releases
+ * resources allocated for the tascam_card structure, including the MIDI
+ * input FIFO and decrements the USB device reference count.
+ */
+static void tascam_card_private_free(struct snd_card *card)
+{
+    struct tascam_card *tascam =3D card->private_data;
+
+    if (tascam) {
+        kfifo_free(&tascam->midi_in_fifo);
+        if (tascam->dev) {
+            usb_put_dev(tascam->dev);
+            tascam->dev =3D NULL;
+        }
+    }
+}
+
+/**
+ * tascam_suspend() - Handles device suspension.
+ * @intf: The USB interface being suspended.
+ * @message: Power management message.
+ *
+ * This function is called when the device is suspended. It stops all acti=
ve
+ * streams, kills all URBs, and sends a vendor-specific deep sleep command
+ * to the device to ensure a stable low-power state.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_suspend(struct usb_interface *intf, pm_message_t message=
)
+{
+    struct tascam_card *tascam =3D usb_get_intfdata(intf);
+    int err;
+
+    if (!tascam)
+        return 0;
+
+    /*
+     * The device requires a specific sequence to enter a stable low-power
+     * state. First, ensure all data transmission is stopped before
+     * sending the final vendor command.
+     */
+    if (tascam->pcm)
+        snd_pcm_suspend_all(tascam->pcm);
+
+    /*
+     * Terminate all in-flight URBs to prevent access to the device
+     * after it has been put to sleep.
+     */
+    cancel_work_sync(&tascam->stop_work);
+    cancel_work_sync(&tascam->capture_work);
+    cancel_work_sync(&tascam->midi_in_work);
+    cancel_work_sync(&tascam->midi_out_work);
+    usb_kill_anchored_urbs(&tascam->playback_anchor);
+    usb_kill_anchored_urbs(&tascam->capture_anchor);
+    usb_kill_anchored_urbs(&tascam->feedback_anchor);
+    usb_kill_anchored_urbs(&tascam->midi_in_anchor);
+    usb_kill_anchored_urbs(&tascam->midi_out_anchor);
+
+    /*
+     * Send the vendor-specific "Deep Sleep" command. Failure to send this
+     * command before host-initiated suspend can leave the device in an
+     * unstable state, leading to system freezes on idle (autosuspend).
+     */
+    err =3D usb_control_msg(tascam->dev,
+                  usb_sndctrlpipe(tascam->dev, 0),
+                  0x00,       /* bRequest */
+                  0x40,       /* bmRequestType: H2D, Vendor, Device */
+                  0x0044,     /* wValue */
+                  0x0000,     /* wIndex */
+                  NULL,       /* data */
+                  0,          /* size */
+                  1000);      /* timeout */
+    if (err < 0)
+        dev_err(&intf->dev, "failed to send deep sleep command: %d\n", err=
);
+
+    return 0;
+}
+
+/**
+ * tascam_resume() - Handles device resumption from suspend.
+ * @intf: The USB interface being resumed.
+ *
+ * This function is called when the device resumes from suspend. It
re-establishes
+ * the active USB interface settings and re-configures the sample rate if =
it
+ * was previously active.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int tascam_resume(struct usb_interface *intf)
+{
+    struct tascam_card *tascam =3D usb_get_intfdata(intf);
+    int err;
+
+    if (!tascam)
+        return 0;
+
+    dev_info(&intf->dev, "resuming TASCAM US-144MKII\n");
+
+    /*
+     * The device requires a full re-initialization sequence upon resume.
+     * First, re-establish the active USB interface settings.
+     */
+    err =3D usb_set_interface(tascam->dev, 0, 1);
+    if (err < 0) {
+        dev_err(&intf->dev, "resume: failed to set alt setting on
intf 0: %d\n",
+            err);
+        return err;
+    }
+    err =3D usb_set_interface(tascam->dev, 1, 1);
+    if (err < 0) {
+        dev_err(&intf->dev, "resume: failed to set alt setting on
intf 1: %d\n",
+            err);
+        return err;
+    }
+
+    /* Re-configure the sample rate if one was previously active */
+    if (tascam->current_rate > 0)
+        us144mkii_configure_device_for_rate(tascam, tascam->current_rate);
+
+    return 0;
+}
+
+/**
+ * tascam_probe() - Probes for the TASCAM US-144MKII device.
+ * @intf: The USB interface being probed.
+ * @usb_id: The USB device ID.
+ *
+ * This function is the entry point for the USB driver when a matching dev=
ice
+ * is found. It performs initial device setup, including:
+ * - Checking for the second interface (MIDI) and associating it.
+ * - Performing a vendor-specific handshake with the device.
+ * - Setting alternate settings for USB interfaces.
+ * - Creating and registering the ALSA sound card, PCM device, and MIDI de=
vice.
+ * - Allocating and initializing URBs for audio and MIDI transfers.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int tascam_probe(struct usb_interface *intf, const struct
usb_device_id *usb_id)
+{
+    struct usb_device *dev =3D interface_to_usbdev(intf);
+    struct snd_card *card;
+    struct tascam_card *tascam;
+    int err;
+    char *handshake_buf;
+
+    if (dev->speed !=3D USB_SPEED_HIGH)
+        dev_info(&dev->dev, "Device is connected to a USB 1.1 port,
this is not supported.\n");
+
+    if (intf->cur_altsetting->desc.bInterfaceNumber =3D=3D 1) {
+
+        tascam =3D usb_get_intfdata(usb_ifnum_to_if(dev, 0));
+        if (tascam) {
+            usb_set_intfdata(intf, tascam);
+            tascam->iface1 =3D intf;
+        }
+        return 0;
+    }
+
+    if (dev_idx >=3D SNDRV_CARDS) {
+        dev_err(&dev->dev, "Too many TASCAM devices present");
+        return -ENODEV;
+    }
+
+    if (!enable[dev_idx]) {
+        dev_info(&dev->dev, "TASCAM US-144MKII device disabled");
+        return -ENOENT;
+    }
+
+    handshake_buf =3D kmalloc(1, GFP_KERNEL);
+    if (!handshake_buf)
+        return -ENOMEM;
+
+    err =3D usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
VENDOR_REQ_MODE_CONTROL, RT_D2H_VENDOR_DEV, MODE_VAL_HANDSHAKE_READ,
0x0000, handshake_buf, 1, USB_CTRL_TIMEOUT_MS);
+    if (err < 0) {
+        dev_err(&dev->dev, "Handshake read failed with %d\n", err);
+        kfree(handshake_buf);
+        return err;
+    }
+
+    if (handshake_buf[0] !=3D 0x12 && handshake_buf[0] !=3D 0x16 &&
handshake_buf[0] !=3D 0x30) {
+        dev_err(&dev->dev, "Unexpected handshake value: 0x%x\n",
handshake_buf[0]);
+        kfree(handshake_buf);
+        return -ENODEV;
+    }
+    kfree(handshake_buf);
+
+    err =3D usb_set_interface(dev, 0, 1);
+    if (err < 0) {
+        dev_err(&dev->dev, "Failed to set alt setting 1 on interface
0: %d\n", err);
+        return err;
+    }
+
+    err =3D usb_set_interface(dev, 1, 1);
+    if (err < 0) {
+        dev_err(&dev->dev, "Failed to set alt setting 1 on interface
1: %d\n", err);
+        return err;
+    }
+
+    err =3D snd_card_new(&dev->dev, index[dev_idx], id[dev_idx],
THIS_MODULE, sizeof(struct tascam_card), &card);
+    if (err < 0) {
+        dev_err(&dev->dev, "Failed to create sound card instance\n");
+        return err;
+    }
+
+    tascam =3D card->private_data;
+    tascam->dev =3D usb_get_dev(dev);
+    tascam->card =3D card;
+    tascam->iface0 =3D intf;
+
+    spin_lock_init(&tascam->lock);
+    spin_lock_init(&tascam->midi_in_lock);
+    spin_lock_init(&tascam->midi_out_lock);
+    init_usb_anchor(&tascam->playback_anchor);
+    init_usb_anchor(&tascam->capture_anchor);
+    init_usb_anchor(&tascam->feedback_anchor);
+    init_usb_anchor(&tascam->midi_in_anchor);
+    init_usb_anchor(&tascam->midi_out_anchor);
+
+    INIT_WORK(&tascam->stop_work, tascam_stop_work_handler);
+
+    if (kfifo_alloc(&tascam->midi_in_fifo, MIDI_IN_FIFO_SIZE, GFP_KERNEL))
+        goto free_card;
+
+    card->private_free =3D tascam_card_private_free;
+
+    strscpy(card->driver, DRIVER_NAME, sizeof(card->driver));
+    strscpy(card->shortname, "TASCAM US-144MKII", sizeof(card->shortname))=
;
+    snprintf(card->longname, sizeof(card->longname), "%s (%04x:%04x) at %s=
",
+         card->shortname, USB_VID_TASCAM, USB_PID_TASCAM_US144MKII,
dev_name(&dev->dev));
+
+
+
+    err =3D snd_pcm_new(card, "US144MKII PCM", 0, 1, 1, &tascam->pcm);
+    if (err < 0)
+        goto free_card;
+    tascam->pcm->private_data =3D tascam;
+    strscpy(tascam->pcm->name, "US144MKII PCM", sizeof(tascam->pcm->name))=
;
+
+    err =3D tascam_init_pcm(tascam->pcm);
+    if (err < 0)
+        goto free_card;
+
+    err =3D tascam_create_midi(tascam);
+    if (err < 0)
+        goto free_card;
+
+    err =3D tascam_create_controls(tascam);
+    if (err < 0)
+        goto free_card;
+
+    err =3D tascam_alloc_urbs(tascam);
+    if (err < 0)
+        goto free_card;
+
+    err =3D snd_card_register(card);
+    if (err < 0)
+        goto free_card;
+
+    usb_set_intfdata(intf, tascam);
+
+    dev_idx++;
+    return 0;
+
+free_card:
+    snd_card_free(card);
+    return err;
+}
+
+/**
+ * tascam_disconnect() - Disconnects the TASCAM US-144MKII device.
+ * @intf: The USB interface being disconnected.
+ *
+ * This function is called when the device is disconnected from the system=
.
+ * It cleans up all allocated resources, including killing URBs, freeing
+ * the sound card, and releasing memory.
+ */
+static void tascam_disconnect(struct usb_interface *intf)
+{
+    struct tascam_card *tascam =3D usb_get_intfdata(intf);
+
+    if (!tascam)
+        return;
+
+    if (intf->cur_altsetting->desc.bInterfaceNumber =3D=3D 0) {
+        device_remove_file(&intf->dev, &dev_attr_driver_version);
+        usb_kill_anchored_urbs(&tascam->playback_anchor);
+        usb_kill_anchored_urbs(&tascam->capture_anchor);
+        usb_kill_anchored_urbs(&tascam->feedback_anchor);
+        usb_kill_anchored_urbs(&tascam->midi_in_anchor);
+        usb_kill_anchored_urbs(&tascam->midi_out_anchor);
+        snd_card_disconnect(tascam->card);
+        tascam_free_urbs(tascam);
+        snd_card_free(tascam->card);
+        dev_idx--;
+    }
+}
+
+static const struct usb_device_id tascam_usb_ids[] =3D {
+    { USB_DEVICE(USB_VID_TASCAM, USB_PID_TASCAM_US144MKII) },
+    { /* Terminating entry */ }
+};
+MODULE_DEVICE_TABLE(usb, tascam_usb_ids);
+
+static struct usb_driver tascam_alsa_driver =3D {
+    .name =3D DRIVER_NAME,
+    .probe =3D tascam_probe,
+    .disconnect =3D tascam_disconnect,
+    .suspend =3D tascam_suspend,
+    .resume =3D tascam_resume,
+    .id_table =3D tascam_usb_ids,
+};
+
+module_usb_driver(tascam_alsa_driver);
diff --git a/sound/usb/usx2y/us144mkii.h b/sound/usb/usx2y/us144mkii.h
new file mode 100644
index 000000000..b77ad1880
--- /dev/null
+++ b/sound/usb/usx2y/us144mkii.h
@@ -0,0 +1,333 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+// Copyright (c) 2025 =C5=A0erif Rami <ramiserifpersia@gmail.com>
+
+#ifndef __US144MKII_H
+#define __US144MKII_H
+
+#include <linux/usb.h>
+#include <linux/workqueue.h>
+#include <linux/kfifo.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/rawmidi.h>
+#include <sound/initval.h>
+#include <sound/control.h>
+
+#define DRIVER_NAME "us144mkii"
+#define DRIVER_VERSION "1.7.4"
+
+/* --- USB Device Identification --- */
+#define USB_VID_TASCAM                0x0644
+#define USB_PID_TASCAM_US144MKII    0x8020
+
+/* --- USB Endpoints (Alternate Setting 1) --- */
+#define EP_PLAYBACK_FEEDBACK        0x81
+#define EP_AUDIO_OUT            0x02
+#define EP_MIDI_IN            0x83
+#define EP_MIDI_OUT            0x04
+#define EP_AUDIO_IN            0x86
+
+/* --- USB Control Message Protocol --- */
+#define RT_H2D_CLASS_EP        (USB_DIR_OUT | USB_TYPE_CLASS |
USB_RECIP_ENDPOINT)
+#define RT_D2H_CLASS_EP        (USB_DIR_IN | USB_TYPE_CLASS |
USB_RECIP_ENDPOINT)
+#define RT_H2D_VENDOR_DEV    (USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DE=
VICE)
+#define RT_D2H_VENDOR_DEV    (USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEV=
ICE)
+
+enum uac_request {
+    UAC_SET_CUR            =3D 0x01,
+    UAC_GET_CUR            =3D 0x81,
+};
+
+enum uac_control_selector {
+    UAC_SAMPLING_FREQ_CONTROL    =3D 0x0100,
+};
+
+enum tascam_vendor_request {
+    VENDOR_REQ_REGISTER_WRITE    =3D 0x41,
+    VENDOR_REQ_MODE_CONTROL        =3D 0x49,
+};
+
+enum tascam_mode_value {
+    MODE_VAL_HANDSHAKE_READ        =3D 0x0000,
+    MODE_VAL_CONFIG            =3D 0x0010,
+    MODE_VAL_STREAM_START        =3D 0x0030,
+};
+
+#define HANDSHAKE_SUCCESS_VAL        0x12
+
+enum tascam_register {
+    REG_ADDR_UNKNOWN_0D        =3D 0x0d04,
+    REG_ADDR_UNKNOWN_0E        =3D 0x0e00,
+    REG_ADDR_UNKNOWN_0F        =3D 0x0f00,
+    REG_ADDR_RATE_44100        =3D 0x1000,
+    REG_ADDR_RATE_48000        =3D 0x1002,
+    REG_ADDR_RATE_88200        =3D 0x1008,
+    REG_ADDR_RATE_96000        =3D 0x100a,
+    REG_ADDR_UNKNOWN_11        =3D 0x110b,
+};
+
+#define REG_VAL_ENABLE            0x0101
+
+
+
+/* --- URB Configuration --- */
+#define NUM_PLAYBACK_URBS        8
+#define PLAYBACK_URB_PACKETS        4
+#define NUM_FEEDBACK_URBS        4
+#define MAX_FEEDBACK_PACKETS        5
+#define FEEDBACK_PACKET_SIZE        3
+#define NUM_CAPTURE_URBS        8
+#define CAPTURE_URB_SIZE        512
+#define CAPTURE_RING_BUFFER_SIZE    (CAPTURE_URB_SIZE * NUM_CAPTURE_URBS *=
 4)
+#define NUM_MIDI_IN_URBS        4
+#define MIDI_IN_BUF_SIZE        64
+#define MIDI_IN_FIFO_SIZE        (MIDI_IN_BUF_SIZE * NUM_MIDI_IN_URBS)
+#define MIDI_OUT_BUF_SIZE        64
+#define NUM_MIDI_OUT_URBS        4
+#define USB_CTRL_TIMEOUT_MS        1000
+#define FEEDBACK_SYNC_LOSS_THRESHOLD    41
+
+/* --- Audio Format Configuration --- */
+#define BYTES_PER_SAMPLE        3
+#define NUM_CHANNELS            4
+#define BYTES_PER_FRAME            (NUM_CHANNELS * BYTES_PER_SAMPLE)
+#define FEEDBACK_ACCUMULATOR_SIZE    128
+
+/* --- Capture Decoding Defines --- */
+#define DECODED_CHANNELS_PER_FRAME    4
+#define DECODED_SAMPLE_SIZE        4
+#define FRAMES_PER_DECODE_BLOCK        8
+#define RAW_BYTES_PER_DECODE_BLOCK    512
+
+/**
+ * struct tascam_card - Main driver data structure for the TASCAM US-144MK=
II.
+ * @dev: Pointer to the USB device.
+ * @iface0: Pointer to USB interface 0 (audio).
+ * @iface1: Pointer to USB interface 1 (MIDI).
+ * @card: Pointer to the ALSA sound card instance.
+ * @pcm: Pointer to the ALSA PCM device.
+ * @rmidi: Pointer to the ALSA rawmidi device.
+ *
+ * @playback_substream: Pointer to the active playback PCM substream.
+ * @playback_urbs: Array of URBs for playback.
+ * @playback_urb_alloc_size: Size of allocated buffer for each playback UR=
B.
+ * @feedback_urbs: Array of URBs for feedback.
+ * @feedback_urb_alloc_size: Size of allocated buffer for each feedback UR=
B.
+ * @playback_active: Atomic flag indicating if playback is active.
+ * @playback_frames_consumed: Total frames consumed by playback.
+ * @driver_playback_pos: Current position in the ALSA playback buffer (fra=
mes).
+ * @last_period_pos: Last reported period position for playback.
+ * @playback_routing_buffer: Intermediate buffer for playback routing.
+ *
+ * @capture_substream: Pointer to the active capture PCM substream.
+ * @capture_urbs: Array of URBs for capture.
+ * @capture_urb_alloc_size: Size of allocated buffer for each capture URB.
+ * @capture_active: Atomic flag indicating if capture is active.
+ * @driver_capture_pos: Current position in the ALSA capture buffer (frame=
s).
+ * @capture_frames_processed: Total frames processed for capture.
+ * @last_capture_period_pos: Last reported period position for capture.
+ * @capture_ring_buffer: Ring buffer for raw capture data from USB.
+ * @capture_ring_buffer_read_ptr: Read pointer for the capture ring buffer=
.
+ * @capture_ring_buffer_write_ptr: Write pointer for the capture ring buff=
er.
+ * @capture_decode_raw_block: Buffer for a raw 512-byte capture block.
+ * @capture_decode_dst_block: Buffer for decoded 32-bit capture samples.
+ * @capture_routing_buffer: Intermediate buffer for capture routing.
+ * @capture_work: Work struct for deferred capture processing.
+ * @stop_work: Work struct for deferred stream stopping.
+ *
+ * @midi_in_substream: Pointer to the active MIDI input substream.
+ * @midi_out_substream: Pointer to the active MIDI output substream.
+ * @midi_in_urbs: Array of URBs for MIDI input.
+ * @midi_in_active: Atomic flag indicating if MIDI input is active.
+ * @midi_in_fifo: FIFO for raw MIDI input data.
+ * @midi_in_work: Work struct for deferred MIDI input processing.
+ * @midi_in_lock: Spinlock for MIDI input FIFO.
+ * @midi_out_urbs: Array of URBs for MIDI output.
+ * @midi_out_active: Atomic flag indicating if MIDI output is active.
+ * @midi_out_work: Work struct for deferred MIDI output processing.
+ * @midi_out_urbs_in_flight: Bitmap of MIDI output URBs currently in fligh=
t.
+ * @midi_out_lock: Spinlock for MIDI output.
+ * @midi_running_status: Stores the last MIDI status byte for running stat=
us.
+ *
+ * @lock: Main spinlock for protecting shared driver state.
+ * @active_urbs: Atomic counter for active URBs.
+ * @current_rate: Currently configured sample rate of the device.
+ * @line_out_source: Source for Line Outputs (0: Playback 1-2, 1:
Playback 3-4).
+ * @digital_out_source: Source for Digital Outputs (0: Playback 1-2,
1: Playback 3-4).
+ * @capture_12_source: Source for Capture channels 1-2 (0: Analog In,
1: Digital In).
+ * @capture_34_source: Source for Capture channels 3-4 (0: Analog In,
1: Digital In).
+ *
+ * @feedback_accumulator_pattern: Stores the calculated frames per
packet for feedback.
+ * @feedback_pattern_out_idx: Read index for feedback_accumulator_pattern.
+ * @feedback_pattern_in_idx: Write index for feedback_accumulator_pattern.
+ * @feedback_synced: Flag indicating if feedback is synced.
+ * @feedback_consecutive_errors: Counter for consecutive feedback errors.
+ * @feedback_urb_skip_count: Number of feedback URBs to skip
initially for stabilization.
+ * @feedback_patterns: Pointer to the current feedback patterns based
on sample rate.
+ * @feedback_base_value: Base value for feedback pattern lookup.
+ * @feedback_max_value: Max value for feedback pattern lookup.
+ *
+ * @playback_anchor: USB anchor for playback URBs.
+ * @capture_anchor: USB anchor for capture URBs.
+ * @feedback_anchor: USB anchor for feedback URBs.
+ * @midi_in_anchor: USB anchor for MIDI input URBs.
+ * @midi_out_anchor: USB anchor for MIDI output URBs.
+ */
+struct tascam_card {
+    struct usb_device *dev;
+    struct usb_interface *iface0;
+    struct usb_interface *iface1;
+    struct snd_card *card;
+    struct snd_pcm *pcm;
+    struct snd_rawmidi *rmidi;
+
+    /* Playback stream */
+    struct snd_pcm_substream *playback_substream;
+    struct urb *playback_urbs[NUM_PLAYBACK_URBS];
+    size_t playback_urb_alloc_size;
+    struct urb *feedback_urbs[NUM_FEEDBACK_URBS];
+    size_t feedback_urb_alloc_size;
+    atomic_t playback_active;
+    u64 playback_frames_consumed;
+    snd_pcm_uframes_t driver_playback_pos;
+    u64 last_period_pos;
+    u8 *playback_routing_buffer;
+
+    /* Capture stream */
+    struct snd_pcm_substream *capture_substream;
+    struct urb *capture_urbs[NUM_CAPTURE_URBS];
+    size_t capture_urb_alloc_size;
+    atomic_t capture_active;
+    snd_pcm_uframes_t driver_capture_pos;
+    u64 capture_frames_processed;
+    u64 last_capture_period_pos;
+    u8 *capture_ring_buffer;
+    size_t capture_ring_buffer_read_ptr;
+    size_t capture_ring_buffer_write_ptr;
+    u8 *capture_decode_raw_block;
+    s32 *capture_decode_dst_block;
+    s32 *capture_routing_buffer;
+    struct work_struct capture_work;
+    struct work_struct stop_work;
+
+    /* MIDI streams */
+    struct snd_rawmidi_substream *midi_in_substream;
+    struct snd_rawmidi_substream *midi_out_substream;
+    struct urb *midi_in_urbs[NUM_MIDI_IN_URBS];
+    atomic_t midi_in_active;
+    struct kfifo midi_in_fifo;
+    struct work_struct midi_in_work;
+    spinlock_t midi_in_lock;
+    struct urb *midi_out_urbs[NUM_MIDI_OUT_URBS];
+    atomic_t midi_out_active;
+    struct work_struct midi_out_work;
+    unsigned long midi_out_urbs_in_flight;
+    spinlock_t midi_out_lock;
+    u8 midi_running_status;
+
+    /* Shared state & Routing Matrix */
+    spinlock_t lock;
+    atomic_t active_urbs;
+    int current_rate;
+    unsigned int line_out_source;     /* 0: Playback 1-2, 1: Playback 3-4 =
*/
+    unsigned int digital_out_source;  /* 0: Playback 1-2, 1: Playback 3-4 =
*/
+    unsigned int capture_12_source;   /* 0: Analog In, 1: Digital In */
+    unsigned int capture_34_source;   /* 0: Analog In, 1: Digital In */
+
+    unsigned int feedback_accumulator_pattern[FEEDBACK_ACCUMULATOR_SIZE];
+    unsigned int feedback_pattern_out_idx;
+    unsigned int feedback_pattern_in_idx;
+    bool feedback_synced;
+    unsigned int feedback_consecutive_errors;
+    unsigned int feedback_urb_skip_count;
+
+    const unsigned int (*feedback_patterns)[8];
+    unsigned int feedback_base_value;
+    unsigned int feedback_max_value;
+
+    struct usb_anchor playback_anchor;
+    struct usb_anchor capture_anchor;
+    struct usb_anchor feedback_anchor;
+    struct usb_anchor midi_in_anchor;
+    struct usb_anchor midi_out_anchor;
+};
+
+/* main */
+/**
+ * tascam_free_urbs() - Free all allocated URBs and associated buffers.
+ * @tascam: the tascam_card instance
+ *
+ * This function kills, unlinks, and frees all playback, feedback, capture=
,
+ * and MIDI URBs, along with their transfer buffers and the capture
+ * ring/decode buffers.
+ */
+void tascam_free_urbs(struct tascam_card *tascam);
+
+/**
+ * tascam_alloc_urbs() - Allocate all URBs and associated buffers.
+ * @tascam: the tascam_card instance
+ *
+ * This function allocates and initializes all URBs for playback, feedback=
,
+ * capture, and MIDI, as well as the necessary buffers for data processing=
.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int tascam_alloc_urbs(struct tascam_card *tascam);
+
+/**
+ * tascam_stop_work_handler() - Work handler to stop all active streams.
+ * @work: Pointer to the work_struct.
+ *
+ * This function is scheduled to stop all active URBs (playback,
feedback, capture)
+ * and reset the active_urbs counter. It is used to gracefully stop stream=
s
+ * from a workqueue context.
+ */
+void tascam_stop_work_handler(struct work_struct *work);
+
+/* us144mkii_pcm.h */
+#include "us144mkii_pcm.h"
+
+/* us144mkii_midi.c */
+/**
+ * tascam_midi_in_urb_complete() - Completion handler for MIDI IN URBs
+ * @urb: The completed URB.
+ *
+ * This function runs in interrupt context. It places the raw data from th=
e
+ * USB endpoint into a kfifo and schedules a work item to process it later=
,
+ * ensuring the interrupt handler remains fast.
+ */
+void tascam_midi_in_urb_complete(struct urb *urb);
+
+/**
+ * tascam_midi_out_urb_complete() - Completion handler for MIDI OUT bulk U=
RB.
+ * @urb: The completed URB.
+ *
+ * This function runs in interrupt context. It marks the output URB as no
+ * longer in-flight. It then re-schedules the work handler to check for an=
d
+ * send any more data waiting in the ALSA buffer. This is a safe, non-bloc=
king
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
+ * tascam_create_controls() - Creates and adds ALSA mixer controls
for the device.
+ * @tascam: The driver instance.
+ *
+ * This function registers custom ALSA controls for managing audio routing
+ * (line out source, digital out source, capture 1-2 source, capture
3-4 source)
+ * and displaying the current sample rate.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int tascam_create_controls(struct tascam_card *tascam);
+
+#endif /* __US144MKII_H */
diff --git a/sound/usb/usx2y/us144mkii_capture.c
b/sound/usb/usx2y/us144mkii_capture.c
new file mode 100644
index 000000000..4759a8683
--- /dev/null
+++ b/sound/usb/usx2y/us144mkii_capture.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2025 =C5=A0erif Rami <ramiserifpersia@gmail.com>
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
+    struct tascam_card *tascam =3D snd_pcm_substream_chip(substream);
+
+    substream->runtime->hw =3D tascam_pcm_hw;
+    tascam->capture_substream =3D substream;
+    atomic_set(&tascam->capture_active, 0);
+
+    return 0;
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
+    struct tascam_card *tascam =3D snd_pcm_substream_chip(substream);
+
+    tascam->capture_substream =3D NULL;
+
+    return 0;
+}
+
+/**
+ * tascam_capture_prepare() - Prepares the PCM capture substream for use.
+ * @substream: The ALSA PCM substream to prepare.
+ *
+ * This function initializes capture-related counters and ring buffer poin=
ters.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_capture_prepare(struct snd_pcm_substream *substream)
+{
+    struct tascam_card *tascam =3D snd_pcm_substream_chip(substream);
+
+    tascam->driver_capture_pos =3D 0;
+    tascam->capture_frames_processed =3D 0;
+    tascam->last_capture_period_pos =3D 0;
+    tascam->capture_ring_buffer_read_ptr =3D 0;
+    tascam->capture_ring_buffer_write_ptr =3D 0;
+
+    return 0;
+}
+
+/**
+ * tascam_capture_pointer() - Returns the current capture pointer position=
.
+ * @substream: The ALSA PCM substream.
+ *
+ * This function returns the current position of the capture pointer withi=
n
+ * the ALSA ring buffer, in frames.
+ *
+ * Return: The current capture pointer position in frames.
+ */
+static snd_pcm_uframes_t tascam_capture_pointer(struct
snd_pcm_substream *substream)
+{
+    struct tascam_card *tascam =3D snd_pcm_substream_chip(substream);
+    struct snd_pcm_runtime *runtime =3D substream->runtime;
+    u64 pos;
+    unsigned long flags;
+
+    if (!atomic_read(&tascam->capture_active))
+        return 0;
+
+    spin_lock_irqsave(&tascam->lock, flags);
+    pos =3D tascam->capture_frames_processed;
+    spin_unlock_irqrestore(&tascam->lock, flags);
+
+    return runtime ? pos % runtime->buffer_size : 0;
+}
+
+/**
+ * tascam_capture_ops - ALSA PCM operations for capture.
+ *
+ * This structure defines the callback functions for capture stream operat=
ions,
+ * including open, close, ioctl, hardware parameters, hardware free, prepa=
re,
+ * trigger, and pointer.
+ */
+const struct snd_pcm_ops tascam_capture_ops =3D {
+    .open =3D tascam_capture_open,
+    .close =3D tascam_capture_close,
+    .ioctl =3D snd_pcm_lib_ioctl,
+    .hw_params =3D tascam_pcm_hw_params,
+    .hw_free =3D tascam_pcm_hw_free,
+    .prepare =3D tascam_capture_prepare,
+    .trigger =3D tascam_pcm_trigger,
+    .pointer =3D tascam_capture_pointer,
+};
+
+/**
+ * decode_tascam_capture_block() - Decodes a raw 512-byte block from
the device.
+ * @src_block: Pointer to the 512-byte raw source block.
+ * @dst_block: Pointer to the destination buffer for decoded audio frames.
+ *
+ * The device sends audio data in a complex, multiplexed format. This func=
tion
+ * demultiplexes the bits from the raw block into 8 frames of 4-channel,
+ * 24-bit audio (stored in 32-bit containers).
+ */
+static void decode_tascam_capture_block(const u8 *src_block, s32 *dst_bloc=
k)
+{
+    int frame, bit;
+
+    memset(dst_block, 0, FRAMES_PER_DECODE_BLOCK *
DECODED_CHANNELS_PER_FRAME * DECODED_SAMPLE_SIZE);
+
+    for (frame =3D 0; frame < FRAMES_PER_DECODE_BLOCK; ++frame) {
+        const u8 *p_src_frame_base =3D src_block + frame * 64;
+        s32 *p_dst_frame =3D dst_block + frame * 4;
+
+        s32 ch[4] =3D {0};
+
+        for (bit =3D 0; bit < 24; ++bit) {
+            u8 byte1 =3D p_src_frame_base[bit];
+            u8 byte2 =3D p_src_frame_base[bit + 32];
+
+            ch[0] =3D (ch[0] << 1) | (byte1 & 1);
+            ch[2] =3D (ch[2] << 1) | ((byte1 >> 1) & 1);
+
+            ch[1] =3D (ch[1] << 1) | (byte2 & 1);
+            ch[3] =3D (ch[3] << 1) | ((byte2 >> 1) & 1);
+        }
+
+        /*
+         * The result is a 24-bit sample. Shift left by 8 to align it to
+         * the most significant bits of a 32-bit integer (S32_LE format).
+         */
+        p_dst_frame[0] =3D ch[0] << 8;
+        p_dst_frame[1] =3D ch[1] << 8;
+        p_dst_frame[2] =3D ch[2] << 8;
+        p_dst_frame[3] =3D ch[3] << 8;
+    }
+}
+
+/**
+ * tascam_capture_work_handler() - Deferred work for processing capture da=
ta.
+ * @work: the work_struct instance
+ *
+ * This function runs in a kernel thread context, not an IRQ context. It r=
eads
+ * raw data from the capture ring buffer, decodes it, applies routing, and
+ * copies the final audio data into the ALSA capture ring buffer. This off=
loads
+ * * the CPU-intensive decoding from the time-sensitive URB
completion handlers.
+ */
+void tascam_capture_work_handler(struct work_struct *work)
+{
+    struct tascam_card *tascam =3D container_of(work, struct
tascam_card, capture_work);
+    struct snd_pcm_substream *substream =3D tascam->capture_substream;
+    struct snd_pcm_runtime *runtime;
+    unsigned long flags;
+    u8 *raw_block =3D tascam->capture_decode_raw_block;
+    s32 *decoded_block =3D tascam->capture_decode_dst_block;
+    s32 *routed_block =3D tascam->capture_routing_buffer;
+
+    if (!substream || !substream->runtime)
+        return;
+    runtime =3D substream->runtime;
+
+    if (!raw_block || !decoded_block || !routed_block) {
+        dev_err(tascam->card->dev, "Capture decode/routing buffers
not allocated!\n");
+        return;
+    }
+
+    while (atomic_read(&tascam->capture_active)) {
+        size_t write_ptr, read_ptr, available_data;
+        bool can_process;
+
+        spin_lock_irqsave(&tascam->lock, flags);
+        write_ptr =3D tascam->capture_ring_buffer_write_ptr;
+        read_ptr =3D tascam->capture_ring_buffer_read_ptr;
+        available_data =3D (write_ptr >=3D read_ptr) ? (write_ptr -
read_ptr) : (CAPTURE_RING_BUFFER_SIZE - read_ptr + write_ptr);
+        can_process =3D (available_data >=3D RAW_BYTES_PER_DECODE_BLOCK);
+
+        if (can_process) {
+            size_t i;
+
+            for (i =3D 0; i < RAW_BYTES_PER_DECODE_BLOCK; i++)
+                raw_block[i] =3D tascam->capture_ring_buffer[(read_ptr
+ i) % CAPTURE_RING_BUFFER_SIZE];
+            tascam->capture_ring_buffer_read_ptr =3D (read_ptr +
RAW_BYTES_PER_DECODE_BLOCK) % CAPTURE_RING_BUFFER_SIZE;
+        }
+        spin_unlock_irqrestore(&tascam->lock, flags);
+
+        if (!can_process)
+            break;
+
+        decode_tascam_capture_block(raw_block, decoded_block);
+        process_capture_routing_us144mkii(tascam, decoded_block, routed_bl=
ock);
+
+        spin_lock_irqsave(&tascam->lock, flags);
+        if (atomic_read(&tascam->capture_active)) {
+            int f;
+
+            for (f =3D 0; f < FRAMES_PER_DECODE_BLOCK; ++f) {
+                u8 *dst_frame_start =3D runtime->dma_area +
frames_to_bytes(runtime, tascam->driver_capture_pos);
+                s32 *routed_frame_start =3D routed_block + (f * NUM_CHANNE=
LS);
+                int c;
+
+                for (c =3D 0; c < NUM_CHANNELS; c++) {
+                    u8 *dst_channel =3D dst_frame_start + (c * BYTES_PER_S=
AMPLE);
+                    s32 *src_channel_s32 =3D routed_frame_start + c;
+
+                    memcpy(dst_channel, ((char *)src_channel_s32) + 1, 3);
+                }
+
+                tascam->driver_capture_pos =3D
(tascam->driver_capture_pos + 1) % runtime->buffer_size;
+            }
+        }
+        spin_unlock_irqrestore(&tascam->lock, flags);
+    }
+}
+
+/**
+ * capture_urb_complete() - Completion handler for capture bulk URBs.
+ * @urb: the completed URB
+ *
+ * This function runs in interrupt context. It copies the received raw dat=
a
+ * into an intermediate ring buffer and then schedules the workqueue to pr=
ocess
+ * it. It then resubmits the URB to receive more data.
+ */
+void capture_urb_complete(struct urb *urb)
+{
+    struct tascam_card *tascam =3D urb->context;
+    int ret;
+    unsigned long flags;
+
+    if (urb->status) {
+        if (urb->status !=3D -ENOENT && urb->status !=3D -ECONNRESET &&
urb->status !=3D -ESHUTDOWN &&
+            urb->status !=3D -ENODEV && urb->status !=3D -EPROTO)
+            dev_err_ratelimited(tascam->card->dev, "Capture URB
failed: %d\n", urb->status);
+        goto out;
+    }
+    if (!tascam || !atomic_read(&tascam->capture_active))
+        goto out;
+
+    if (urb->actual_length > 0) {
+        size_t i;
+        size_t write_ptr;
+
+        spin_lock_irqsave(&tascam->lock, flags);
+        write_ptr =3D tascam->capture_ring_buffer_write_ptr;
+        for (i =3D 0; i < urb->actual_length; i++) {
+            tascam->capture_ring_buffer[write_ptr] =3D ((u8
*)urb->transfer_buffer)[i];
+            write_ptr =3D (write_ptr + 1) % CAPTURE_RING_BUFFER_SIZE;
+        }
+        tascam->capture_ring_buffer_write_ptr =3D write_ptr;
+        spin_unlock_irqrestore(&tascam->lock, flags);
+
+        schedule_work(&tascam->capture_work);
+    }
+
+    usb_get_urb(urb);
+    usb_anchor_urb(urb, &tascam->capture_anchor);
+    ret =3D usb_submit_urb(urb, GFP_ATOMIC);
+    if (ret < 0) {
+        dev_err_ratelimited(tascam->card->dev, "Failed to resubmit
capture URB: %d\n", ret);
+        usb_unanchor_urb(urb);
+        usb_put_urb(urb);
+    }
+out:
+    usb_put_urb(urb);
+}
diff --git a/sound/usb/usx2y/us144mkii_controls.c
b/sound/usb/usx2y/us144mkii_controls.c
new file mode 100644
index 000000000..897eeada1
--- /dev/null
+++ b/sound/usb/usx2y/us144mkii_controls.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2025 =C5=A0erif Rami <ramiserifpersia@gmail.com>
+
+#include "us144mkii.h"
+
+/**
+ * @brief Text descriptions for playback output source options.
+ *
+ * Used by ALSA kcontrol elements to provide user-friendly names for
+ * the playback routing options (e.g., "Playback 1-2", "Playback 3-4").
+ */
+static const char * const playback_source_texts[] =3D {"Playback 1-2",
"Playback 3-4"};
+
+/**
+ * @brief Text descriptions for capture input source options.
+ *
+ * Used by ALSA kcontrol elements to provide user-friendly names for
+ * the capture routing options (e.g., "Analog In", "Digital In").
+ */
+static const char * const capture_source_texts[] =3D {"Analog In", "Digita=
l In"};
+
+/**
+ * tascam_playback_source_info() - ALSA control info callback for
playback source.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @uinfo: The ALSA control element info structure to fill.
+ *
+ * This function provides information about the enumerated playback source
+ * control, including its type, count, and available items (Playback
1-2, Playback 3-4).
+ *
+ * Return: 0 on success.
+ */
+static int tascam_playback_source_info(struct snd_kcontrol *kcontrol,
struct snd_ctl_elem_info *uinfo)
+{
+    uinfo->type =3D SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+    uinfo->count =3D 1;
+    uinfo->value.enumerated.items =3D 2;
+    if (uinfo->value.enumerated.item >=3D 2)
+        uinfo->value.enumerated.item =3D 1;
+    strscpy(uinfo->value.enumerated.name,
+        playback_source_texts[uinfo->value.enumerated.item],
+        sizeof(uinfo->value.enumerated.name));
+    return 0;
+}
+
+/**
+ * tascam_line_out_get() - ALSA control get callback for Line Outputs Sour=
ce.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @ucontrol: The ALSA control element value structure to fill.
+ *
+ * This function retrieves the current selection for the Line Outputs sour=
ce
+ * (Playback 1-2 or Playback 3-4) from the driver's private data and popul=
ates
+ * the ALSA control element value.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_line_out_get(struct snd_kcontrol *kcontrol, struct
snd_ctl_elem_value *ucontrol)
+{
+    struct tascam_card *tascam =3D snd_kcontrol_chip(kcontrol);
+
+    ucontrol->value.enumerated.item[0] =3D tascam->line_out_source;
+    return 0;
+}
+
+/**
+ * tascam_line_out_put() - ALSA control put callback for Line Outputs Sour=
ce.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @ucontrol: The ALSA control element value structure containing the
new value.
+ *
+ * This function sets the Line Outputs source (Playback 1-2 or Playback 3-=
4)
+ * based on the user's selection from the ALSA control element. It validat=
es
+ * the input and updates the driver's private data.
+ *
+ * Return: 1 if the value was changed, 0 if unchanged, or a negative
error code.
+ */
+static int tascam_line_out_put(struct snd_kcontrol *kcontrol, struct
snd_ctl_elem_value *ucontrol)
+{
+    struct tascam_card *tascam =3D snd_kcontrol_chip(kcontrol);
+
+    if (ucontrol->value.enumerated.item[0] > 1)
+        return -EINVAL;
+    if (tascam->line_out_source =3D=3D ucontrol->value.enumerated.item[0])
+        return 0;
+    tascam->line_out_source =3D ucontrol->value.enumerated.item[0];
+    return 1;
+}
+
+/**
+ * tascam_line_out_control - ALSA kcontrol definition for Line Outputs Sou=
rce.
+ *
+ * This defines a new ALSA mixer control named "Line OUTPUTS Source"
that allows
+ * the user to select between "Playback 1-2" and "Playback 3-4" for the an=
alog
+ * line outputs of the device. It uses the `tascam_playback_source_info` f=
or
+ * information and `tascam_line_out_get`/`tascam_line_out_put` for
value handling.
+ */
+static const struct snd_kcontrol_new tascam_line_out_control =3D {
+    .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, .name =3D "Line OUTPUTS Source"=
,
+    .info =3D tascam_playback_source_info, .get =3D tascam_line_out_get,
.put =3D tascam_line_out_put,
+};
+
+/**
+ * tascam_digital_out_get() - ALSA control get callback for Digital
Outputs Source.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @ucontrol: The ALSA control element value structure to fill.
+ *
+ * This function retrieves the current selection for the Digital Outputs s=
ource
+ * (Playback 1-2 or Playback 3-4) from the driver's private data and popul=
ates
+ * the ALSA control element value.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_digital_out_get(struct snd_kcontrol *kcontrol,
struct snd_ctl_elem_value *ucontrol)
+{
+    struct tascam_card *tascam =3D snd_kcontrol_chip(kcontrol);
+
+    ucontrol->value.enumerated.item[0] =3D tascam->digital_out_source;
+    return 0;
+}
+
+/**
+ * tascam_digital_out_put() - ALSA control put callback for Digital
Outputs Source.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @ucontrol: The ALSA control element value structure containing the
new value.
+ *
+ * This function sets the Digital Outputs source (Playback 1-2 or Playback=
 3-4)
+ * based on the user's selection from the ALSA control element. It validat=
es
+ * the input and updates the driver's private data.
+ *
+ * Return: 1 if the value was changed, 0 if unchanged, or a negative
error code.
+ */
+static int tascam_digital_out_put(struct snd_kcontrol *kcontrol,
struct snd_ctl_elem_value *ucontrol)
+{
+    struct tascam_card *tascam =3D snd_kcontrol_chip(kcontrol);
+
+    if (ucontrol->value.enumerated.item[0] > 1)
+        return -EINVAL;
+    if (tascam->digital_out_source =3D=3D ucontrol->value.enumerated.item[=
0])
+        return 0;
+    tascam->digital_out_source =3D ucontrol->value.enumerated.item[0];
+    return 1;
+}
+
+/**
+ * tascam_digital_out_control - ALSA kcontrol definition for Digital
Outputs Source.
+ *
+ * This defines a new ALSA mixer control named "Digital OUTPUTS
Source" that allows
+ * the user to select between "Playback 1-2" and "Playback 3-4" for the di=
gital
+ * outputs of the device. It uses the `tascam_playback_source_info` for
+ * information and `tascam_digital_out_get`/`tascam_digital_out_put`
for value handling.
+ */
+static const struct snd_kcontrol_new tascam_digital_out_control =3D {
+    .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, .name =3D "Digital OUTPUTS Sour=
ce",
+    .info =3D tascam_playback_source_info, .get =3D
tascam_digital_out_get, .put =3D tascam_digital_out_put,
+};
+
+/**
+ * tascam_capture_source_info() - ALSA control info callback for
capture source.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @uinfo: The ALSA control element info structure to fill.
+ *
+ * This function provides information about the enumerated capture source
+ * control, including its type, count, and available items (Analog
In, Digital In).
+ *
+ * Return: 0 on success.
+ */
+static int tascam_capture_source_info(struct snd_kcontrol *kcontrol,
struct snd_ctl_elem_info *uinfo)
+{
+    uinfo->type =3D SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+    uinfo->count =3D 1;
+    uinfo->value.enumerated.items =3D 2;
+    if (uinfo->value.enumerated.item >=3D 2)
+        uinfo->value.enumerated.item =3D 1;
+    strscpy(uinfo->value.enumerated.name,
+        capture_source_texts[uinfo->value.enumerated.item],
+        sizeof(uinfo->value.enumerated.name));
+    return 0;
+}
+
+/**
+ * tascam_capture_12_get() - ALSA control get callback for Capture
channels 1 and 2 Source.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @ucontrol: The ALSA control element value structure to fill.
+ *
+ * This function retrieves the current selection for the Capture
channels 1 and 2 source
+ * (Analog In or Digital In) from the driver's private data and populates
+ * the ALSA control element value.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_capture_12_get(struct snd_kcontrol *kcontrol,
struct snd_ctl_elem_value *ucontrol)
+{
+    struct tascam_card *tascam =3D snd_kcontrol_chip(kcontrol);
+
+    ucontrol->value.enumerated.item[0] =3D tascam->capture_12_source;
+    return 0;
+}
+
+/**
+ * tascam_capture_12_put() - ALSA control put callback for Capture
channels 1 and 2 Source.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @ucontrol: The ALSA control element value structure containing the
new value.
+ *
+ * This function sets the Capture channels 1 and 2 source (Analog In
or Digital In)
+ * based on the user's selection from the ALSA control element. It validat=
es
+ * the input and updates the driver's private data.
+ *
+ * Return: 1 if the value was changed, 0 if unchanged, or a negative
error code.
+ */
+static int tascam_capture_12_put(struct snd_kcontrol *kcontrol,
struct snd_ctl_elem_value *ucontrol)
+{
+    struct tascam_card *tascam =3D snd_kcontrol_chip(kcontrol);
+
+    if (ucontrol->value.enumerated.item[0] > 1)
+        return -EINVAL;
+    if (tascam->capture_12_source =3D=3D ucontrol->value.enumerated.item[0=
])
+        return 0;
+    tascam->capture_12_source =3D ucontrol->value.enumerated.item[0];
+    return 1;
+}
+
+/**
+ * tascam_capture_12_control - ALSA kcontrol definition for Capture
channels 1 and 2 Source.
+ *
+ * This defines a new ALSA mixer control named "ch1 and ch2 Source" that a=
llows
+ * the user to select between "Analog In" and "Digital In" for the first t=
wo
+ * capture channels of the device. It uses the `tascam_capture_source_info=
` for
+ * information and `tascam_capture_12_get`/`tascam_capture_12_put`
for value handling.
+ */
+static const struct snd_kcontrol_new tascam_capture_12_control =3D {
+    .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, .name =3D "ch1 and ch2 Source",
+    .info =3D tascam_capture_source_info, .get =3D tascam_capture_12_get,
.put =3D tascam_capture_12_put,
+};
+
+/**
+ * tascam_capture_34_get() - ALSA control get callback for Capture
channels 3 and 4 Source.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @ucontrol: The ALSA control element value structure to fill.
+ *
+ * This function retrieves the current selection for the Capture
channels 3 and 4 source
+ * (Analog In or Digital In) from the driver's private data and populates
+ * the ALSA control element value.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_capture_34_get(struct snd_kcontrol *kcontrol,
struct snd_ctl_elem_value *ucontrol)
+{
+    struct tascam_card *tascam =3D snd_kcontrol_chip(kcontrol);
+
+    ucontrol->value.enumerated.item[0] =3D tascam->capture_34_source;
+    return 0;
+}
+
+/**
+ * tascam_capture_34_put() - ALSA control put callback for Capture
channels 3 and 4 Source.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @ucontrol: The ALSA control element value structure containing the
new value.
+ *
+ * This function sets the Capture channels 3 and 4 source (Analog In
or Digital In)
+ * based on the user's selection from the ALSA control element. It validat=
es
+ * the input and updates the driver's private data.
+ *
+ * Return: 1 if the value was changed, 0 if unchanged, or a negative
error code.
+ */
+static int tascam_capture_34_put(struct snd_kcontrol *kcontrol,
struct snd_ctl_elem_value *ucontrol)
+{
+    struct tascam_card *tascam =3D snd_kcontrol_chip(kcontrol);
+
+    if (ucontrol->value.enumerated.item[0] > 1)
+        return -EINVAL;
+    if (tascam->capture_34_source =3D=3D ucontrol->value.enumerated.item[0=
])
+        return 0;
+    tascam->capture_34_source =3D ucontrol->value.enumerated.item[0];
+    return 1;
+}
+
+/**
+ * tascam_capture_34_control - ALSA kcontrol definition for Capture
channels 3 and 4 Source.
+ *
+ * This defines a new ALSA mixer control named "ch3 and ch4 Source" that a=
llows
+ * the user to select between "Analog In" and "Digital In" for the
third and fourth
+ * capture channels of the device. It uses the `tascam_capture_source_info=
` for
+ * information and `tascam_capture_34_get`/`tascam_capture_34_put`
for value handling.
+ */
+static const struct snd_kcontrol_new tascam_capture_34_control =3D {
+    .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, .name =3D "ch3 and ch4 Source",
+    .info =3D tascam_capture_source_info, .get =3D tascam_capture_34_get,
.put =3D tascam_capture_34_put,
+};
+
+/**
+ * tascam_samplerate_info() - ALSA control info callback for Sample Rate.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @uinfo: The ALSA control element info structure to fill.
+ *
+ * This function provides information about the Sample Rate control, defin=
ing
+ * it as an integer type with a minimum value of 0 and a maximum of 96000.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_samplerate_info(struct snd_kcontrol *kcontrol,
struct snd_ctl_elem_info *uinfo)
+{
+    uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
+    uinfo->count =3D 1;
+    uinfo->value.integer.min =3D 0;
+    uinfo->value.integer.max =3D 96000;
+    return 0;
+}
+
+/**
+ * tascam_samplerate_get() - ALSA control get callback for Sample Rate.
+ * @kcontrol: The ALSA kcontrol instance.
+ * @ucontrol: The ALSA control element value structure to fill.
+ *
+ * This function retrieves the current sample rate from the device via a U=
SB
+ * control message and populates the ALSA control element value. If the ra=
te
+ * is already known (i.e., `current_rate` is set), it returns that
value directly.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int tascam_samplerate_get(struct snd_kcontrol *kcontrol,
struct snd_ctl_elem_value *ucontrol)
+{
+    struct tascam_card *tascam =3D (struct tascam_card
*)snd_kcontrol_chip(kcontrol);
+    u8 *buf;
+    int err;
+    u32 rate =3D 0;
+
+    if (tascam->current_rate > 0) {
+        ucontrol->value.integer.value[0] =3D tascam->current_rate;
+        return 0;
+    }
+
+    buf =3D kmalloc(3, GFP_KERNEL);
+    if (!buf)
+        return -ENOMEM;
+
+    err =3D usb_control_msg(tascam->dev, usb_rcvctrlpipe(tascam->dev, 0),
+                  UAC_GET_CUR, RT_D2H_CLASS_EP,
+                  UAC_SAMPLING_FREQ_CONTROL, EP_AUDIO_IN,
+                  buf, 3, USB_CTRL_TIMEOUT_MS);
+
+    if (err >=3D 3)
+        rate =3D buf[0] | (buf[1] << 8) | (buf[2] << 16);
+
+    ucontrol->value.integer.value[0] =3D rate;
+    kfree(buf);
+    return 0;
+}
+
+/**
+ * tascam_samplerate_control - ALSA kcontrol definition for Sample Rate.
+ *
+ * This defines a new ALSA mixer control named "Sample Rate" that displays
+ * the current sample rate of the device. It is a read-only control.
+ */
+static const struct snd_kcontrol_new tascam_samplerate_control =3D {
+    .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
+    .name =3D "Sample Rate",
+    .info =3D tascam_samplerate_info,
+    .get =3D tascam_samplerate_get,
+    .access =3D SNDRV_CTL_ELEM_ACCESS_READ,
+};
+
+/**
+ * tascam_create_controls() - Creates and adds ALSA mixer controls
for the device.
+ * @tascam: The driver instance.
+ *
+ * This function registers custom ALSA controls for managing audio routing
+ * (line out source, digital out source, capture 1-2 source, capture
3-4 source)
+ * and displaying the current sample rate.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int tascam_create_controls(struct tascam_card *tascam)
+{
+    int err;
+
+    err =3D snd_ctl_add(tascam->card,
snd_ctl_new1(&tascam_line_out_control, tascam));
+    if (err < 0)
+        return err;
+    err =3D snd_ctl_add(tascam->card,
snd_ctl_new1(&tascam_digital_out_control, tascam));
+    if (err < 0)
+        return err;
+    err =3D snd_ctl_add(tascam->card,
snd_ctl_new1(&tascam_capture_12_control, tascam));
+    if (err < 0)
+        return err;
+    err =3D snd_ctl_add(tascam->card,
snd_ctl_new1(&tascam_capture_34_control, tascam));
+    if (err < 0)
+        return err;
+
+    err =3D snd_ctl_add(tascam->card,
snd_ctl_new1(&tascam_samplerate_control, tascam));
+    if (err < 0)
+        return err;
+
+    return 0;
+}
diff --git a/sound/usb/usx2y/us144mkii_midi.c b/sound/usb/usx2y/us144mkii_m=
idi.c
new file mode 100644
index 000000000..f6a7eda27
--- /dev/null
+++ b/sound/usb/usx2y/us144mkii_midi.c
@@ -0,0 +1,401 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2025 =C5=A0erif Rami <ramiserifpersia@gmail.com>
+
+#include "us144mkii.h"
+
+/**
+ * tascam_midi_in_work_handler() - Deferred work for processing MIDI input=
.
+ * @work: The work_struct instance.
+ *
+ * This function runs in a thread context. It safely reads raw USB data fr=
om
+ * the kfifo, processes it by stripping protocol-specific padding bytes, a=
nd
+ * passes the clean MIDI data to the ALSA rawmidi subsystem.
+ */
+static void tascam_midi_in_work_handler(struct work_struct *work)
+{
+    struct tascam_card *tascam =3D container_of(work, struct
tascam_card, midi_in_work);
+    u8 buf[MIDI_IN_BUF_SIZE];
+    unsigned int len;
+    int i;
+
+    if (!tascam->midi_in_substream)
+        return;
+
+    while (!kfifo_is_empty(&tascam->midi_in_fifo)) {
+        len =3D kfifo_out_spinlocked(&tascam->midi_in_fifo,
+                       buf, sizeof(buf), &tascam->midi_in_lock);
+
+        if (len =3D=3D 0)
+            continue;
+
+        if (!tascam->midi_in_substream)
+            continue;
+
+        for (i =3D 0; i < len; ++i) {
+            /* Skip padding bytes */
+            if (buf[i] =3D=3D 0xfd)
+                continue;
+
+            /* The last byte is often a terminator (0x00, 0xFF). Ignore it=
. */
+            if (i =3D=3D (len - 1) && (buf[i] =3D=3D 0x00 || buf[i] =3D=3D=
 0xff))
+                continue;
+
+            /* Submit valid MIDI bytes one by one */
+            snd_rawmidi_receive(tascam->midi_in_substream, &buf[i], 1);
+        }
+    }
+}
+
+/**
+ * tascam_midi_in_urb_complete() - Completion handler for MIDI IN URBs
+ * @urb: The completed URB.
+ *
+ * This function runs in interrupt context. It places the raw data from th=
e
+ * USB endpoint into a kfifo and schedules a work item to process it later=
,
+ * ensuring the interrupt handler remains fast.
+ */
+void tascam_midi_in_urb_complete(struct urb *urb)
+{
+    struct tascam_card *tascam =3D urb->context;
+    int ret;
+
+    if (urb->status) {
+        if (urb->status !=3D -ENOENT && urb->status !=3D -ECONNRESET &&
+            urb->status !=3D -ESHUTDOWN && urb->status !=3D -EPROTO)
+            dev_err_ratelimited(tascam->card->dev,
+                        "MIDI IN URB failed: status %d\n",
+                        urb->status);
+        goto out;
+    }
+
+    if (tascam && atomic_read(&tascam->midi_in_active) &&
urb->actual_length > 0) {
+        kfifo_in_spinlocked(&tascam->midi_in_fifo,
+                    urb->transfer_buffer,
+                    urb->actual_length,
+                    &tascam->midi_in_lock);
+        schedule_work(&tascam->midi_in_work);
+    }
+
+    usb_get_urb(urb);
+    usb_anchor_urb(urb, &tascam->midi_in_anchor);
+    ret =3D usb_submit_urb(urb, GFP_ATOMIC);
+    if (ret < 0) {
+        dev_err(tascam->card->dev,
+            "Failed to resubmit MIDI IN URB: error %d\n", ret);
+        usb_unanchor_urb(urb);
+        usb_put_urb(urb);
+    }
+out:
+    usb_put_urb(urb);
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
+    struct tascam_card *tascam =3D substream->rmidi->private_data;
+
+    tascam->midi_in_substream =3D substream;
+    return 0;
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
+    return 0;
+}
+
+/**
+ * tascam_midi_in_trigger() - Triggers MIDI input stream activity.
+ * @substream: The ALSA rawmidi substream.
+ * @up: Boolean indicating whether to start (1) or stop (0) the stream.
+ *
+ * This function starts or stops the MIDI input URBs based on the
'up' parameter.
+ * When starting, it resets the kfifo and submits all MIDI input URBs.
+ * When stopping, it kills all anchored MIDI input URBs and cancels the
+ * associated workqueue.
+ */
+static void tascam_midi_in_trigger(struct snd_rawmidi_substream
*substream, int up)
+{
+    struct tascam_card *tascam =3D substream->rmidi->private_data;
+    int i, err;
+    unsigned long flags;
+
+    if (up) {
+        if (atomic_xchg(&tascam->midi_in_active, 1) =3D=3D 0) {
+            spin_lock_irqsave(&tascam->midi_in_lock, flags);
+            kfifo_reset(&tascam->midi_in_fifo);
+            spin_unlock_irqrestore(&tascam->midi_in_lock, flags);
+
+            for (i =3D 0; i < NUM_MIDI_IN_URBS; i++) {
+                usb_get_urb(tascam->midi_in_urbs[i]);
+                usb_anchor_urb(tascam->midi_in_urbs[i],
&tascam->midi_in_anchor);
+                err =3D usb_submit_urb(tascam->midi_in_urbs[i], GFP_KERNEL=
);
+                if (err < 0) {
+                    dev_err(tascam->card->dev, "Failed to submit MIDI
IN URB %d: %d\n", i, err);
+                    usb_unanchor_urb(tascam->midi_in_urbs[i]);
+                    usb_put_urb(tascam->midi_in_urbs[i]);
+                }
+            }
+        }
+    } else {
+        if (atomic_xchg(&tascam->midi_in_active, 0) =3D=3D 1) {
+            usb_kill_anchored_urbs(&tascam->midi_in_anchor);
+            cancel_work_sync(&tascam->midi_in_work);
+        }
+    }
+}
+
+/**
+ * tascam_midi_in_ops - ALSA rawmidi operations for MIDI input.
+ *
+ * This structure defines the callback functions for MIDI input
stream operations,
+ * including open, close, and trigger.
+ */
+static const struct snd_rawmidi_ops tascam_midi_in_ops =3D {
+    .open =3D tascam_midi_in_open,
+    .close =3D tascam_midi_in_close,
+    .trigger =3D tascam_midi_in_trigger,
+};
+
+/**
+ * tascam_midi_out_urb_complete() - Completion handler for MIDI OUT bulk U=
RB.
+ * @urb: The completed URB.
+ *
+ * This function runs in interrupt context. It marks the output URB as no
+ * longer in-flight. It then re-schedules the work handler to check for an=
d
+ * send any more data waiting in the ALSA buffer. This is a safe, non-bloc=
king
+ * way to continue the data transmission chain.
+ */
+void tascam_midi_out_urb_complete(struct urb *urb)
+{
+    struct tascam_card *tascam =3D urb->context;
+    unsigned long flags;
+    int i, urb_index =3D -1;
+
+    if (urb->status) {
+        if (urb->status !=3D -ENOENT && urb->status !=3D -ECONNRESET &&
urb->status !=3D -ESHUTDOWN)
+            dev_err_ratelimited(tascam->card->dev, "MIDI OUT URB
failed: %d\n", urb->status);
+    }
+
+    if (!tascam)
+        goto out;
+
+    for (i =3D 0; i < NUM_MIDI_OUT_URBS; i++) {
+        if (tascam->midi_out_urbs[i] =3D=3D urb) {
+            urb_index =3D i;
+            break;
+        }
+    }
+
+    if (urb_index < 0) {
+        dev_err_ratelimited(tascam->card->dev, "Unknown MIDI OUT URB
completed!\n");
+        goto out;
+    }
+
+    spin_lock_irqsave(&tascam->midi_out_lock, flags);
+    clear_bit(urb_index, &tascam->midi_out_urbs_in_flight);
+    spin_unlock_irqrestore(&tascam->midi_out_lock, flags);
+
+    if (atomic_read(&tascam->midi_out_active))
+        schedule_work(&tascam->midi_out_work);
+out:
+    usb_put_urb(urb);
+}
+
+/**
+ * tascam_midi_out_work_handler() - Deferred work for sending MIDI data
+ * @work: The work_struct instance.
+ *
+ * This function handles the proprietary output protocol: take the raw MID=
I
+ * message bytes from the application, place them at the start of a 9-byte
+ * buffer, pad the rest with 0xFD, and add a terminator byte (0x00).
+ * This function pulls as many bytes as will fit into one packet from the
+ * ALSA buffer and sends them.
+ */
+static void tascam_midi_out_work_handler(struct work_struct *work)
+{
+    struct tascam_card *tascam =3D
+        container_of(work, struct tascam_card, midi_out_work);
+    struct snd_rawmidi_substream *substream =3D tascam->midi_out_substream=
;
+    int i;
+
+    if (!substream || !atomic_read(&tascam->midi_out_active))
+        return;
+
+    while (snd_rawmidi_transmit_peek(substream, (u8[]){ 0 }, 1) =3D=3D 1) =
{
+        unsigned long flags;
+        int urb_index;
+        struct urb *urb;
+        u8 *buf;
+        int bytes_to_send;
+
+        spin_lock_irqsave(&tascam->midi_out_lock, flags);
+
+        urb_index =3D -1;
+        for (i =3D 0; i < NUM_MIDI_OUT_URBS; i++) {
+            if (!test_bit(i, &tascam->midi_out_urbs_in_flight)) {
+                urb_index =3D i;
+                break;
+            }
+        }
+
+        if (urb_index < 0) {
+            spin_unlock_irqrestore(&tascam->midi_out_lock, flags);
+            return; /* No free URBs, will be rescheduled by
completion handler */
+        }
+
+        urb =3D tascam->midi_out_urbs[urb_index];
+        buf =3D urb->transfer_buffer;
+        bytes_to_send =3D snd_rawmidi_transmit(substream, buf, 8);
+
+        if (bytes_to_send <=3D 0) {
+            spin_unlock_irqrestore(&tascam->midi_out_lock, flags);
+            break; /* No more data */
+        }
+
+        if (bytes_to_send < 9)
+            memset(buf + bytes_to_send, 0xfd, 9 - bytes_to_send);
+        buf[8] =3D 0x00;
+
+        set_bit(urb_index, &tascam->midi_out_urbs_in_flight);
+        urb->transfer_buffer_length =3D 9;
+        spin_unlock_irqrestore(&tascam->midi_out_lock, flags);
+
+        usb_get_urb(urb);
+        usb_anchor_urb(urb, &tascam->midi_out_anchor);
+        if (usb_submit_urb(urb, GFP_KERNEL) < 0) {
+            dev_err_ratelimited(
+                tascam->card->dev,
+                "Failed to submit MIDI OUT URB %d\n", urb_index);
+            spin_lock_irqsave(&tascam->midi_out_lock, flags);
+            clear_bit(urb_index,
+                  &tascam->midi_out_urbs_in_flight);
+            spin_unlock_irqrestore(&tascam->midi_out_lock, flags);
+            usb_unanchor_urb(urb);
+            usb_put_urb(urb);
+            break; /* Stop on error */
+        }
+    }
+}
+
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
+    struct tascam_card *tascam =3D substream->rmidi->private_data;
+
+    tascam->midi_out_substream =3D substream;
+    /* Initialize the running status state for the packet packer. */
+    tascam->midi_running_status =3D 0;
+    return 0;
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
+    return 0;
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
+    struct tascam_card *tascam =3D substream->rmidi->private_data;
+
+    cancel_work_sync(&tascam->midi_out_work);
+    usb_kill_anchored_urbs(&tascam->midi_out_anchor);
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
+static void tascam_midi_out_trigger(struct snd_rawmidi_substream
*substream, int up)
+{
+    struct tascam_card *tascam =3D substream->rmidi->private_data;
+
+    if (up) {
+        atomic_set(&tascam->midi_out_active, 1);
+        schedule_work(&tascam->midi_out_work);
+    } else {
+        atomic_set(&tascam->midi_out_active, 0);
+    }
+}
+
+/**
+ * tascam_midi_out_ops - ALSA rawmidi operations for MIDI output.
+ *
+ * This structure defines the callback functions for MIDI output
stream operations,
+ * including open, close, trigger, and drain.
+ */
+static const struct snd_rawmidi_ops tascam_midi_out_ops =3D {
+    .open =3D tascam_midi_out_open,
+    .close =3D tascam_midi_out_close,
+    .trigger =3D tascam_midi_out_trigger,
+    .drain =3D tascam_midi_out_drain,
+};
+
+/**
+ * tascam_create_midi() - Create and initialize the ALSA rawmidi device.
+ * @tascam: The driver instance.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int tascam_create_midi(struct tascam_card *tascam)
+{
+    int err;
+
+    err =3D snd_rawmidi_new(tascam->card, "US144MKII MIDI", 0, 1, 1,
&tascam->rmidi);
+    if (err < 0)
+        return err;
+
+    strscpy(tascam->rmidi->name, "US144MKII MIDI",
sizeof(tascam->rmidi->name));
+    tascam->rmidi->private_data =3D tascam;
+
+    snd_rawmidi_set_ops(tascam->rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
&tascam_midi_in_ops);
+    snd_rawmidi_set_ops(tascam->rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
&tascam_midi_out_ops);
+
+    tascam->rmidi->info_flags |=3D SNDRV_RAWMIDI_INFO_INPUT |
+                     SNDRV_RAWMIDI_INFO_OUTPUT |
+                     SNDRV_RAWMIDI_INFO_DUPLEX;
+
+    INIT_WORK(&tascam->midi_in_work, tascam_midi_in_work_handler);
+    INIT_WORK(&tascam->midi_out_work, tascam_midi_out_work_handler);
+
+    return 0;
+}
diff --git a/sound/usb/usx2y/us144mkii_pcm.c b/sound/usb/usx2y/us144mkii_pc=
m.c
new file mode 100644
index 000000000..1a994914f
--- /dev/null
+++ b/sound/usb/usx2y/us144mkii_pcm.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2025 =C5=A0erif Rami <ramiserifpersia@gmail.com>
+
+#include "us144mkii.h"
+
+/**
+ * @brief Rate-to-Packet Fixing Data
+ *
+ * These static arrays define the number of audio frames per USB isochrono=
us
+ * packet for various sample rates. This data is crucial for maintaining
+ * audio synchronization and preventing xruns, as the device's feedback
+ * mechanism indicates how many samples it has consumed.
+ *
+ * The patterns are indexed by a feedback value received from the device,
+ * which helps the driver adjust the packet size dynamically to match the
+ * device's consumption rate.
+ */
+static const unsigned int patterns_48khz[5][8] =3D {
+    {5, 6, 6, 6, 6, 6, 6, 6},
+    {6, 6, 6, 6, 6, 6, 6, 6},
+    {6, 6, 6, 6, 6, 6, 6, 6},
+    {6, 6, 6, 7, 6, 6, 6, 6},
+    {7, 6, 6, 7, 6, 6, 7, 6}
+};
+static const unsigned int patterns_96khz[5][8] =3D {
+    {11, 12, 12, 12, 12, 12, 12, 12},
+    {12, 12, 12, 12, 12, 12, 12, 12},
+    {12, 12, 12, 12, 12, 12, 12, 12},
+    {12, 12, 13, 12, 12, 12, 12, 12},
+    {13, 12, 12, 13, 12, 12, 13, 12}
+};
+static const unsigned int patterns_88khz[5][8] =3D {
+    {10, 11, 11, 11, 11, 11, 11, 11},
+    {11, 11, 11, 11, 11, 11, 11, 11},
+    {11, 11, 11, 11, 11, 11, 11, 11},
+    {11, 11, 12, 11, 11, 11, 11, 11},
+    {12, 11, 11, 12, 11, 11, 12, 11}
+};
+static const unsigned int patterns_44khz[5][8] =3D {
+    {5, 5, 5, 5, 5, 5, 5, 6},
+    {5, 5, 5, 6, 5, 5, 5, 6},
+    {5, 5, 6, 5, 6, 5, 5, 6},
+    {5, 6, 5, 6, 5, 6, 5, 6},
+    {6, 6, 6, 6, 6, 6, 6, 5}
+};
+
+const struct snd_pcm_hardware tascam_pcm_hw =3D {
+    .info =3D (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
+         SNDRV_PCM_INFO_BLOCK_TRANSFER | SNDRV_PCM_INFO_MMAP_VALID |
+         SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
+    .formats =3D SNDRV_PCM_FMTBIT_S24_3LE,
+    .rates =3D (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+          SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000),
+    .rate_min =3D 44100, .rate_max =3D 96000,
+    .channels_min =3D NUM_CHANNELS,
+    .channels_max =3D NUM_CHANNELS,
+    .buffer_bytes_max =3D 1024 * 1024,
+    .period_bytes_min =3D 48 * BYTES_PER_FRAME,
+    .period_bytes_max =3D 1024 * BYTES_PER_FRAME,
+    .periods_min =3D 2, .periods_max =3D 1024,
+};
+
+/**
+ * process_playback_routing_us144mkii() - Apply playback routing matrix
+ * @tascam: The driver instance.
+ * @src_buffer: Buffer containing 4 channels of S24_3LE audio from ALSA.
+ * @dst_buffer: Buffer to be filled for the USB device.
+ * @frames: Number of frames to process.
+ */
+void process_playback_routing_us144mkii(struct tascam_card *tascam,
+                       const u8 *src_buffer,
+                       u8 *dst_buffer, size_t frames)
+{
+    size_t f;
+    const u8 *src_12, *src_34;
+    u8 *dst_line, *dst_digital;
+
+    for (f =3D 0; f < frames; ++f) {
+        src_12 =3D src_buffer + f * BYTES_PER_FRAME;
+        src_34 =3D src_12 + (2 * BYTES_PER_SAMPLE);
+        dst_line =3D dst_buffer + f * BYTES_PER_FRAME;
+        dst_digital =3D dst_line + (2 * BYTES_PER_SAMPLE);
+
+        /* LINE OUTPUTS (ch1/2 on device) */
+        if (tascam->line_out_source =3D=3D 0) /* "ch1 and ch2" */
+            memcpy(dst_line, src_12, 2 * BYTES_PER_SAMPLE);
+        else /* "ch3 and ch4" */
+            memcpy(dst_line, src_34, 2 * BYTES_PER_SAMPLE);
+
+        /* DIGITAL OUTPUTS (ch3/4 on device) */
+        if (tascam->digital_out_source =3D=3D 0) /* "ch1 and ch2" */
+            memcpy(dst_digital, src_12, 2 * BYTES_PER_SAMPLE);
+        else /* "ch3 and ch4" */
+            memcpy(dst_digital, src_34, 2 * BYTES_PER_SAMPLE);
+    }
+}
+
+/**
+ * process_capture_routing_us144mkii() - Apply capture routing matrix
+ * @tascam: The driver instance.
+ * @decoded_block: Buffer containing 4 channels of S32LE decoded audio.
+ * @routed_block: Buffer to be filled for ALSA.
+ */
+void process_capture_routing_us144mkii(struct tascam_card *tascam,
+                      const s32 *decoded_block,
+                      s32 *routed_block)
+{
+    int f;
+    const s32 *src_frame;
+    s32 *dst_frame;
+
+    for (f =3D 0; f < FRAMES_PER_DECODE_BLOCK; f++) {
+        src_frame =3D decoded_block + (f * DECODED_CHANNELS_PER_FRAME);
+        dst_frame =3D routed_block + (f * DECODED_CHANNELS_PER_FRAME);
+
+        /* ch1 and ch2 Source */
+        if (tascam->capture_12_source =3D=3D 0) { /* analog inputs */
+            dst_frame[0] =3D src_frame[0]; /* Analog L */
+            dst_frame[1] =3D src_frame[1]; /* Analog R */
+        } else { /* digital inputs */
+            dst_frame[0] =3D src_frame[2]; /* Digital L */
+            dst_frame[1] =3D src_frame[3]; /* Digital R */
+        }
+
+        /* ch3 and ch4 Source */
+        if (tascam->capture_34_source =3D=3D 0) { /* analog inputs */
+            dst_frame[2] =3D src_frame[0]; /* Analog L (Duplicate) */
+            dst_frame[3] =3D src_frame[1]; /* Analog R (Duplicate) */
+        } else { /* digital inputs */
+            dst_frame[2] =3D src_frame[2]; /* Digital L */
+            dst_frame[3] =3D src_frame[3]; /* Digital R */
+        }
+    }
+}
+
+/**
+ * us144mkii_configure_device_for_rate() - Set sample rate via USB control=
 msgs
+ * @tascam: the tascam_card instance
+ * @rate: the target sample rate (e.g., 44100, 96000)
+ *
+ * This function sends a sequence of vendor-specific and UAC control messa=
ges
+ * to configure the device hardware for the specified sample rate.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int us144mkii_configure_device_for_rate(struct tascam_card *tascam, int ra=
te)
+{
+    struct usb_device *dev =3D tascam->dev;
+    u8 *rate_payload_buf;
+    u16 rate_vendor_wValue;
+    int err =3D 0;
+    const u8 *current_payload_src;
+
+    static const u8 payload_44100[] =3D {0x44, 0xac, 0x00};
+    static const u8 payload_48000[] =3D {0x80, 0xbb, 0x00};
+    static const u8 payload_88200[] =3D {0x88, 0x58, 0x01};
+    static const u8 payload_96000[] =3D {0x00, 0x77, 0x01};
+
+    switch (rate) {
+    case 44100:
+        current_payload_src =3D payload_44100;
+        rate_vendor_wValue =3D REG_ADDR_RATE_44100;
+        break;
+    case 48000:
+        current_payload_src =3D payload_48000;
+        rate_vendor_wValue =3D REG_ADDR_RATE_48000;
+        break;
+    case 88200:
+        current_payload_src =3D payload_88200;
+        rate_vendor_wValue =3D REG_ADDR_RATE_88200;
+        break;
+    case 96000:
+        current_payload_src =3D payload_96000;
+        rate_vendor_wValue =3D REG_ADDR_RATE_96000;
+        break;
+    default:
+        dev_err(&dev->dev, "Unsupported sample rate %d for
configuration\n", rate);
+        return -EINVAL;
+    }
+
+    rate_payload_buf =3D kmemdup(current_payload_src, 3, GFP_KERNEL);
+    if (!rate_payload_buf)
+        return -ENOMEM;
+
+    dev_info(&dev->dev, "Configuring device for %d Hz\n", rate);
+
+    err =3D usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
VENDOR_REQ_MODE_CONTROL, RT_H2D_VENDOR_DEV, MODE_VAL_CONFIG, 0x0000,
NULL, 0, USB_CTRL_TIMEOUT_MS);
+    if (err < 0)
+        goto fail;
+    err =3D usb_control_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
RT_H2D_CLASS_EP, UAC_SAMPLING_FREQ_CONTROL, EP_AUDIO_IN,
rate_payload_buf, 3, USB_CTRL_TIMEOUT_MS);
+    if (err < 0)
+        goto fail;
+    err =3D usb_control_msg(dev, usb_sndctrlpipe(dev, 0), UAC_SET_CUR,
RT_H2D_CLASS_EP, UAC_SAMPLING_FREQ_CONTROL, EP_AUDIO_OUT,
rate_payload_buf, 3, USB_CTRL_TIMEOUT_MS);
+    if (err < 0)
+        goto fail;
+    err =3D usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
VENDOR_REQ_REGISTER_WRITE, RT_H2D_VENDOR_DEV, REG_ADDR_UNKNOWN_0D,
REG_VAL_ENABLE, NULL, 0, USB_CTRL_TIMEOUT_MS);
+    if (err < 0)
+        goto fail;
+    err =3D usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
VENDOR_REQ_REGISTER_WRITE, RT_H2D_VENDOR_DEV, REG_ADDR_UNKNOWN_0E,
REG_VAL_ENABLE, NULL, 0, USB_CTRL_TIMEOUT_MS);
+    if (err < 0)
+        goto fail;
+    err =3D usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
VENDOR_REQ_REGISTER_WRITE, RT_H2D_VENDOR_DEV, REG_ADDR_UNKNOWN_0F,
REG_VAL_ENABLE, NULL, 0, USB_CTRL_TIMEOUT_MS);
+    if (err < 0)
+        goto fail;
+    err =3D usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
VENDOR_REQ_REGISTER_WRITE, RT_H2D_VENDOR_DEV, rate_vendor_wValue,
REG_VAL_ENABLE, NULL, 0, USB_CTRL_TIMEOUT_MS);
+    if (err < 0)
+        goto fail;
+    err =3D usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
VENDOR_REQ_REGISTER_WRITE, RT_H2D_VENDOR_DEV, REG_ADDR_UNKNOWN_11,
REG_VAL_ENABLE, NULL, 0, USB_CTRL_TIMEOUT_MS);
+    if (err < 0)
+        goto fail;
+    err =3D usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
VENDOR_REQ_MODE_CONTROL, RT_H2D_VENDOR_DEV, MODE_VAL_STREAM_START,
0x0000, NULL, 0, USB_CTRL_TIMEOUT_MS);
+    if (err < 0)
+        goto fail;
+
+    kfree(rate_payload_buf);
+    return 0;
+
+fail:
+    dev_err(&dev->dev, "Device configuration failed at rate %d with
error %d\n", rate, err);
+    kfree(rate_payload_buf);
+    return err;
+}
+
+/**
+ * tascam_pcm_hw_params() - Configures hardware parameters for PCM streams=
.
+ * @substream: The ALSA PCM substream.
+ * @params: The hardware parameters to apply.
+ *
+ * This function allocates pages for the PCM buffer and, for playback stre=
ams,
+ * selects the appropriate feedback patterns based on the requested
sample rate.
+ * It also configures the device hardware for the selected sample rate if =
it
+ * has changed.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int tascam_pcm_hw_params(struct snd_pcm_substream *substream,
+                   struct snd_pcm_hw_params *params)
+{
+    struct tascam_card *tascam =3D snd_pcm_substream_chip(substream);
+    int err;
+    unsigned int rate =3D params_rate(params);
+
+    err =3D snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params=
));
+    if (err < 0)
+        return err;
+
+    if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
+        switch (rate) {
+        case 44100:
+            tascam->feedback_patterns =3D patterns_44khz;
+            tascam->feedback_base_value =3D 43;
+            tascam->feedback_max_value =3D 45;
+            break;
+        case 48000:
+            tascam->feedback_patterns =3D patterns_48khz;
+            tascam->feedback_base_value =3D 47;
+            tascam->feedback_max_value =3D 49;
+            break;
+        case 88200:
+            tascam->feedback_patterns =3D patterns_88khz;
+            tascam->feedback_base_value =3D 87;
+            tascam->feedback_max_value =3D 89;
+            break;
+        case 96000:
+            tascam->feedback_patterns =3D patterns_96khz;
+            tascam->feedback_base_value =3D 95;
+            tascam->feedback_max_value =3D 97;
+            break;
+        default:
+            return -EINVAL;
+        }
+    }
+
+    if (tascam->current_rate !=3D rate) {
+        err =3D us144mkii_configure_device_for_rate(tascam, rate);
+        if (err < 0) {
+            tascam->current_rate =3D 0;
+            return err;
+        }
+        tascam->current_rate =3D rate;
+    }
+
+    return 0;
+}
+
+/**
+ * tascam_pcm_hw_free() - Frees hardware parameters for PCM streams.
+ * @substream: The ALSA PCM substream.
+ *
+ * This function frees the pages allocated for the PCM buffer.
+ *
+ * Return: 0 on success.
+ */
+int tascam_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+    return snd_pcm_lib_free_pages(substream);
+}
+
+
+/**
+ * tascam_pcm_trigger() - Triggers the start or stop of PCM streams.
+ * @substream: The ALSA PCM substream.
+ * @cmd: The trigger command (e.g., SNDRV_PCM_TRIGGER_START,
SNDRV_PCM_TRIGGER_STOP).
+ *
+ * This function handles starting and stopping of playback and capture str=
eams
+ * by submitting or killing the associated URBs. It ensures that both stre=
ams
+ * are started/stopped together.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int tascam_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+    struct tascam_card *tascam =3D snd_pcm_substream_chip(substream);
+    unsigned long flags;
+    int err =3D 0;
+    int i;
+    bool do_start =3D false;
+    bool do_stop =3D false;
+
+    spin_lock_irqsave(&tascam->lock, flags);
+    switch (cmd) {
+    case SNDRV_PCM_TRIGGER_START:
+    case SNDRV_PCM_TRIGGER_RESUME:
+        if (!atomic_read(&tascam->playback_active)) {
+            atomic_set(&tascam->playback_active, 1);
+            atomic_set(&tascam->capture_active, 1);
+            do_start =3D true;
+        }
+        break;
+    case SNDRV_PCM_TRIGGER_STOP:
+    case SNDRV_PCM_TRIGGER_SUSPEND:
+    case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+        if (atomic_read(&tascam->playback_active)) {
+            atomic_set(&tascam->playback_active, 0);
+            atomic_set(&tascam->capture_active, 0);
+            do_stop =3D true;
+        }
+        break;
+    default:
+        err =3D -EINVAL;
+        break;
+    }
+    spin_unlock_irqrestore(&tascam->lock, flags);
+
+    if (do_start) {
+        if (atomic_read(&tascam->active_urbs) > 0) {
+            dev_WARN(tascam->card->dev, "Cannot start, URBs still active.\=
n");
+            return -EAGAIN;
+        }
+
+        for (i =3D 0; i < NUM_FEEDBACK_URBS; i++) {
+            usb_get_urb(tascam->feedback_urbs[i]);
+            usb_anchor_urb(tascam->feedback_urbs[i], &tascam->feedback_anc=
hor);
+            err =3D usb_submit_urb(tascam->feedback_urbs[i], GFP_ATOMIC);
+            if (err < 0) {
+                usb_unanchor_urb(tascam->feedback_urbs[i]);
+                usb_put_urb(tascam->feedback_urbs[i]);
+                goto start_rollback;
+            }
+            atomic_inc(&tascam->active_urbs);
+        }
+        for (i =3D 0; i < NUM_PLAYBACK_URBS; i++) {
+            usb_get_urb(tascam->playback_urbs[i]);
+            usb_anchor_urb(tascam->playback_urbs[i], &tascam->playback_anc=
hor);
+            err =3D usb_submit_urb(tascam->playback_urbs[i], GFP_ATOMIC);
+            if (err < 0) {
+                usb_unanchor_urb(tascam->playback_urbs[i]);
+                usb_put_urb(tascam->playback_urbs[i]);
+                goto start_rollback;
+            }
+            atomic_inc(&tascam->active_urbs);
+        }
+        for (i =3D 0; i < NUM_CAPTURE_URBS; i++) {
+            usb_get_urb(tascam->capture_urbs[i]);
+            usb_anchor_urb(tascam->capture_urbs[i], &tascam->capture_ancho=
r);
+            err =3D usb_submit_urb(tascam->capture_urbs[i], GFP_ATOMIC);
+            if (err < 0) {
+                usb_unanchor_urb(tascam->capture_urbs[i]);
+                usb_put_urb(tascam->capture_urbs[i]);
+                goto start_rollback;
+            }
+            atomic_inc(&tascam->active_urbs);
+        }
+
+        return 0;
+start_rollback:
+        dev_err(tascam->card->dev, "Failed to submit URBs to start
stream: %d\n", err);
+        do_stop =3D true;
+    }
+
+    if (do_stop)
+        schedule_work(&tascam->stop_work);
+
+    return err;
+}
+
+/**
+ * tascam_init_pcm() - Initializes the ALSA PCM device.
+ * @pcm: Pointer to the ALSA PCM device to initialize.
+ *
+ * This function sets up the PCM operations for playback and capture,
+ * preallocates pages for the PCM buffer, and initializes the workqueue
+ * for deferred capture processing.
+ *
+ * Return: 0 on success.
+ */
+int tascam_init_pcm(struct snd_pcm *pcm)
+{
+    struct tascam_card *tascam =3D pcm->private_data;
+
+    snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &tascam_playback_ops);
+    snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &tascam_capture_ops);
+    snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
+                                      tascam->dev->dev.parent,
+                                      64 * 1024,
+                                      tascam_pcm_hw.buffer_bytes_max);
+
+    INIT_WORK(&tascam->capture_work, tascam_capture_work_handler);
+
+    return 0;
+}
diff --git a/sound/usb/usx2y/us144mkii_pcm.h b/sound/usb/usx2y/us144mkii_pc=
m.h
new file mode 100644
index 000000000..5082d90fd
--- /dev/null
+++ b/sound/usb/usx2y/us144mkii_pcm.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+// Copyright (c) 2025 =C5=A0erif Rami <ramiserifpersia@gmail.com>
+
+#ifndef __US144MKII_PCM_H
+#define __US144MKII_PCM_H
+
+#include "us144mkii.h"
+
+/**
+ * tascam_pcm_hw - Hardware capabilities for TASCAM US-144MKII PCM.
+ *
+ * Defines the supported PCM formats, rates, channels, and buffer/period s=
izes
+ * for the TASCAM US-144MKII audio interface.
+ */
+extern const struct snd_pcm_hardware tascam_pcm_hw;
+
+/**
+ * tascam_playback_ops - ALSA PCM operations for playback.
+ *
+ * This structure defines the callback functions for playback stream
operations,
+ * including open, close, ioctl, hardware parameters, hardware free, prepa=
re,
+ * trigger, and pointer.
+ */
+extern const struct snd_pcm_ops tascam_playback_ops;
+
+/**
+ * tascam_capture_ops - ALSA PCM operations for capture.
+ *
+ * This structure defines the callback functions for capture stream operat=
ions,
+ * including open, close, ioctl, hardware parameters, hardware free, prepa=
re,
+ * trigger, and pointer.
+ */
+extern const struct snd_pcm_ops tascam_capture_ops;
+
+/**
+ * playback_urb_complete() - Completion handler for playback isochronous U=
RBs.
+ * @urb: the completed URB
+ *
+ * This function runs in interrupt context. It calculates the number of by=
tes
+ * to send in the next set of packets based on the feedback-driven clock,
+ * copies the audio data from the ALSA ring buffer (applying routing), and
+ * resubmits the URB.
+ */
+void playback_urb_complete(struct urb *urb);
+
+/**
+ * feedback_urb_complete() - Completion handler for feedback isochronous U=
RBs.
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
+ * capture_urb_complete() - Completion handler for capture bulk URBs.
+ * @urb: the completed URB
+ *
+ * This function runs in interrupt context. It copies the received raw dat=
a
+ * into an intermediate ring buffer and then schedules the workqueue to pr=
ocess
+ * it. It then resubmits the URB to receive more data.
+ */
+void capture_urb_complete(struct urb *urb);
+
+/**
+ * tascam_init_pcm() - Initializes the ALSA PCM device.
+ * @pcm: Pointer to the ALSA PCM device to initialize.
+ *
+ * This function sets up the PCM operations, adds ALSA controls for routin=
g
+ * and sample rate, and preallocates pages for the PCM buffer.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int tascam_init_pcm(struct snd_pcm *pcm);
+
+/**
+ * us144mkii_configure_device_for_rate() - Set sample rate via USB control=
 msgs
+ * @tascam: the tascam_card instance
+ * @rate: the target sample rate (e.g., 44100, 96000)
+ *
+ * This function sends a sequence of vendor-specific and UAC control messa=
ges
+ * to configure the device hardware for the specified sample rate.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int us144mkii_configure_device_for_rate(struct tascam_card *tascam, int ra=
te);
+
+/**
+ * process_playback_routing_us144mkii() - Apply playback routing matrix
+ * @tascam: The driver instance.
+ * @src_buffer: Buffer containing 4 channels of S24_3LE audio from ALSA.
+ * @dst_buffer: Buffer to be filled for the USB device.
+ * @frames: Number of frames to process.
+ */
+void process_playback_routing_us144mkii(struct tascam_card *tascam,
const u8 *src_buffer, u8 *dst_buffer, size_t frames);
+
+/**
+ * process_capture_routing_us144mkii() - Apply capture routing matrix
+ * @tascam: The driver instance.
+ * @decoded_block: Buffer containing 4 channels of S32LE decoded audio.
+ * @routed_block: Buffer to be filled for ALSA.
+ */
+void process_capture_routing_us144mkii(struct tascam_card *tascam,
const s32 *decoded_block, s32 *routed_block);
+
+/**
+ * tascam_pcm_hw_params() - Configures hardware parameters for PCM streams=
.
+ * @substream: The ALSA PCM substream.
+ * @params: The hardware parameters to apply.
+ *
+ * This function allocates pages for the PCM buffer and, for playback stre=
ams,
+ * selects the appropriate feedback patterns based on the requested
sample rate.
+ * It also configures the device hardware for the selected sample rate if =
it
+ * has changed.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int tascam_pcm_hw_params(struct snd_pcm_substream *substream, struct
snd_pcm_hw_params *params);
+
+/**
+ * tascam_pcm_hw_free() - Frees hardware parameters for PCM streams.
+ * @substream: The ALSA PCM substream.
+ *
+ * This function frees the pages allocated for the PCM buffer.
+ *
+ * Return: 0 on success.
+ */
+int tascam_pcm_hw_free(struct snd_pcm_substream *substream);
+
+/**
+ * tascam_pcm_trigger() - Triggers the start or stop of PCM streams.
+ * @substream: The ALSA PCM substream.
+ * @cmd: The trigger command (e.g., SNDRV_PCM_TRIGGER_START,
SNDRV_PCM_TRIGGER_STOP).
+ *
+ * This function handles starting and stopping of playback and capture str=
eams
+ * by submitting or killing the associated URBs. It ensures that both stre=
ams
+ * are started/stopped together.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int tascam_pcm_trigger(struct snd_pcm_substream *substream, int cmd);
+
+/**
+ * tascam_capture_work_handler() - Deferred work for processing capture da=
ta.
+ * @work: the work_struct instance
+ *
+ * This function runs in a kernel thread context, not an IRQ context. It r=
eads
+ * raw data from the capture ring buffer, decodes it, applies routing, and
+ * copies the final audio data into the ALSA capture ring buffer. This off=
loads
+ * * the CPU-intensive decoding from the time-sensitive URB
completion handlers.
+ */
+void tascam_capture_work_handler(struct work_struct *work);
+
+#endif /* __US144MKII_PCM_H */
diff --git a/sound/usb/usx2y/us144mkii_playback.c
b/sound/usb/usx2y/us144mkii_playback.c
new file mode 100644
index 000000000..9608b0e4a
--- /dev/null
+++ b/sound/usb/usx2y/us144mkii_playback.c
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2025 =C5=A0erif Rami <ramiserifpersia@gmail.com>
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
+    struct tascam_card *tascam =3D snd_pcm_substream_chip(substream);
+
+    substream->runtime->hw =3D tascam_pcm_hw;
+    tascam->playback_substream =3D substream;
+    atomic_set(&tascam->playback_active, 0);
+
+    return 0;
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
+    struct tascam_card *tascam =3D snd_pcm_substream_chip(substream);
+
+    tascam->playback_substream =3D NULL;
+
+    return 0;
+}
+
+/**
+ * tascam_playback_prepare() - Prepares the PCM playback substream for use=
.
+ * @substream: The ALSA PCM substream to prepare.
+ *
+ * This function initializes playback-related counters and flags, and
configures
+ * the playback URBs with appropriate packet sizes based on the nominal fr=
ame
+ * rate and feedback accumulator.
+ *
+ * Return: 0 on success.
+ */
+static int tascam_playback_prepare(struct snd_pcm_substream *substream)
+{
+    struct tascam_card *tascam =3D snd_pcm_substream_chip(substream);
+    struct snd_pcm_runtime *runtime =3D substream->runtime;
+    int i, u;
+    size_t nominal_frames_per_packet, nominal_bytes_per_packet;
+    size_t total_bytes_in_urb;
+    unsigned int feedback_packets;
+
+    tascam->driver_playback_pos =3D 0;
+    tascam->playback_frames_consumed =3D 0;
+    tascam->last_period_pos =3D 0;
+    tascam->feedback_pattern_in_idx =3D 0;
+    tascam->feedback_pattern_out_idx =3D 0;
+    tascam->feedback_synced =3D false;
+    tascam->feedback_consecutive_errors =3D 0;
+    tascam->feedback_urb_skip_count =3D NUM_FEEDBACK_URBS;
+
+    nominal_frames_per_packet =3D runtime->rate / 8000;
+    for (i =3D 0; i < FEEDBACK_ACCUMULATOR_SIZE; i++)
+        tascam->feedback_accumulator_pattern[i] =3D nominal_frames_per_pac=
ket;
+
+    feedback_packets =3D 1;
+
+    for (i =3D 0; i < NUM_FEEDBACK_URBS; i++) {
+        struct urb *f_urb =3D tascam->feedback_urbs[i];
+        int j;
+
+        f_urb->number_of_packets =3D feedback_packets;
+        f_urb->transfer_buffer_length =3D feedback_packets *
FEEDBACK_PACKET_SIZE;
+        for (j =3D 0; j < feedback_packets; j++) {
+            f_urb->iso_frame_desc[j].offset =3D j * FEEDBACK_PACKET_SIZE;
+            f_urb->iso_frame_desc[j].length =3D FEEDBACK_PACKET_SIZE;
+        }
+    }
+
+    nominal_bytes_per_packet =3D nominal_frames_per_packet * BYTES_PER_FRA=
ME;
+    total_bytes_in_urb =3D nominal_bytes_per_packet * PLAYBACK_URB_PACKETS=
;
+
+    for (u =3D 0; u < NUM_PLAYBACK_URBS; u++) {
+        struct urb *urb =3D tascam->playback_urbs[u];
+
+        memset(urb->transfer_buffer, 0, tascam->playback_urb_alloc_size);
+        urb->transfer_buffer_length =3D total_bytes_in_urb;
+        urb->number_of_packets =3D PLAYBACK_URB_PACKETS;
+        for (i =3D 0; i < PLAYBACK_URB_PACKETS; i++) {
+            urb->iso_frame_desc[i].offset =3D i * nominal_bytes_per_packet=
;
+            urb->iso_frame_desc[i].length =3D nominal_bytes_per_packet;
+        }
+    }
+
+    return 0;
+}
+
+/**
+ * tascam_playback_pointer() - Returns the current playback pointer positi=
on.
+ * @substream: The ALSA PCM substream.
+ *
+ * This function returns the current position of the playback pointer with=
in
+ * the ALSA ring buffer, in frames.
+ *
+ * Return: The current playback pointer position in frames.
+ */
+static snd_pcm_uframes_t tascam_playback_pointer(struct
snd_pcm_substream *substream)
+{
+    struct tascam_card *tascam =3D snd_pcm_substream_chip(substream);
+    struct snd_pcm_runtime *runtime =3D substream->runtime;
+    u64 pos;
+    unsigned long flags;
+
+    if (!atomic_read(&tascam->playback_active))
+        return 0;
+
+    spin_lock_irqsave(&tascam->lock, flags);
+    pos =3D tascam->playback_frames_consumed;
+    spin_unlock_irqrestore(&tascam->lock, flags);
+
+    return runtime ? pos % runtime->buffer_size : 0;
+}
+
+/**
+ * tascam_playback_ops - ALSA PCM operations for playback.
+ *
+ * This structure defines the callback functions for playback stream
operations,
+ * including open, close, ioctl, hardware parameters, hardware free, prepa=
re,
+ * trigger, and pointer.
+ */
+const struct snd_pcm_ops tascam_playback_ops =3D {
+    .open =3D tascam_playback_open,
+    .close =3D tascam_playback_close,
+    .ioctl =3D snd_pcm_lib_ioctl,
+    .hw_params =3D tascam_pcm_hw_params,
+    .hw_free =3D tascam_pcm_hw_free,
+    .prepare =3D tascam_playback_prepare,
+    .trigger =3D tascam_pcm_trigger,
+    .pointer =3D tascam_playback_pointer,
+};
+
+/**
+ * playback_urb_complete() - Completion handler for playback isochronous U=
RBs.
+ * @urb: the completed URB
+ *
+ * This function runs in interrupt context. It calculates the number of by=
tes
+ * to send in the next set of packets based on the feedback-driven clock,
+ * copies the audio data from the ALSA ring buffer (applying routing), and
+ * resubmits the URB.
+ */
+void playback_urb_complete(struct urb *urb)
+{
+    struct tascam_card *tascam =3D urb->context;
+    struct snd_pcm_substream *substream;
+    struct snd_pcm_runtime *runtime;
+    unsigned long flags;
+    u8 *src_buf, *dst_buf;
+    size_t total_bytes_for_urb =3D 0;
+    snd_pcm_uframes_t offset_frames;
+    snd_pcm_uframes_t frames_to_copy;
+    int ret, i;
+
+    if (urb->status) {
+        if (urb->status !=3D -ENOENT && urb->status !=3D -ECONNRESET &&
urb->status !=3D -ESHUTDOWN &&
+            urb->status !=3D -ENODEV)
+            dev_err_ratelimited(tascam->card->dev, "Playback URB
failed: %d\n", urb->status);
+        goto out;
+    }
+    if (!tascam || !atomic_read(&tascam->playback_active))
+        goto out;
+
+    substream =3D tascam->playback_substream;
+    if (!substream || !substream->runtime)
+        goto out;
+    runtime =3D substream->runtime;
+
+    spin_lock_irqsave(&tascam->lock, flags);
+
+    for (i =3D 0; i < urb->number_of_packets; i++) {
+        unsigned int frames_for_packet;
+        size_t bytes_for_packet;
+
+        if (tascam->feedback_synced) {
+            frames_for_packet =3D
tascam->feedback_accumulator_pattern[tascam->feedback_pattern_out_idx];
+            tascam->feedback_pattern_out_idx =3D
(tascam->feedback_pattern_out_idx + 1) % FEEDBACK_ACCUMULATOR_SIZE;
+        } else {
+            frames_for_packet =3D runtime->rate / 8000;
+        }
+        bytes_for_packet =3D frames_for_packet * BYTES_PER_FRAME;
+
+        urb->iso_frame_desc[i].offset =3D total_bytes_for_urb;
+        urb->iso_frame_desc[i].length =3D bytes_for_packet;
+        total_bytes_for_urb +=3D bytes_for_packet;
+    }
+    urb->transfer_buffer_length =3D total_bytes_for_urb;
+
+    offset_frames =3D tascam->driver_playback_pos;
+    frames_to_copy =3D bytes_to_frames(runtime, total_bytes_for_urb);
+    tascam->driver_playback_pos =3D (offset_frames + frames_to_copy) %
runtime->buffer_size;
+
+    spin_unlock_irqrestore(&tascam->lock, flags);
+
+    if (total_bytes_for_urb > 0) {
+        src_buf =3D runtime->dma_area + frames_to_bytes(runtime, offset_fr=
ames);
+        dst_buf =3D tascam->playback_routing_buffer;
+
+        /* Handle ring buffer wrap-around */
+        if (offset_frames + frames_to_copy > runtime->buffer_size) {
+            size_t first_chunk_bytes =3D frames_to_bytes(runtime,
runtime->buffer_size - offset_frames);
+            size_t second_chunk_bytes =3D total_bytes_for_urb -
first_chunk_bytes;
+
+            memcpy(dst_buf, src_buf, first_chunk_bytes);
+            memcpy(dst_buf + first_chunk_bytes, runtime->dma_area,
second_chunk_bytes);
+        } else {
+            memcpy(dst_buf, src_buf, total_bytes_for_urb);
+        }
+
+        /* Apply routing to the contiguous data in our routing buffer */
+        process_playback_routing_us144mkii(tascam, dst_buf, dst_buf,
frames_to_copy);
+        memcpy(urb->transfer_buffer, dst_buf, total_bytes_for_urb);
+    }
+
+    urb->dev =3D tascam->dev;
+    usb_get_urb(urb);
+    usb_anchor_urb(urb, &tascam->playback_anchor);
+    ret =3D usb_submit_urb(urb, GFP_ATOMIC);
+    if (ret < 0) {
+        dev_err_ratelimited(tascam->card->dev, "Failed to resubmit
playback URB: %d\n", ret);
+        usb_unanchor_urb(urb);
+        usb_put_urb(urb);
+    }
+out:
+    usb_put_urb(urb);
+}
+
+/**
+ * feedback_urb_complete() - Completion handler for feedback isochronous U=
RBs.
+ * @urb: the completed URB
+ *
+ * This is the master clock for the driver. It runs in interrupt context.
+ * It reads the feedback value from the device, which indicates how many
+ * samples the device has consumed. This information is used to adjust the
+ * playback rate and to advance the capture stream pointer, keeping both
+ * streams in sync. It then calls snd_pcm_period_elapsed if necessary and
+ * resubmits itself.
+ */
+void feedback_urb_complete(struct urb *urb)
+{
+    struct tascam_card *tascam =3D urb->context;
+    struct snd_pcm_substream *playback_ss, *capture_ss;
+    struct snd_pcm_runtime *playback_rt, *capture_rt;
+    unsigned long flags;
+    u64 total_frames_in_urb =3D 0;
+    int ret, p;
+    unsigned int old_in_idx, new_in_idx;
+    bool playback_period_elapsed =3D false;
+    bool capture_period_elapsed =3D false;
+
+    if (urb->status) {
+        if (urb->status !=3D -ENOENT && urb->status !=3D -ECONNRESET &&
urb->status !=3D -ESHUTDOWN &&
+            urb->status !=3D -ENODEV)
+            dev_err_ratelimited(tascam->card->dev, "Feedback URB
failed: %d\n", urb->status);
+        goto out;
+    }
+    if (!tascam || !atomic_read(&tascam->playback_active))
+        goto out;
+
+    playback_ss =3D tascam->playback_substream;
+    if (!playback_ss || !playback_ss->runtime)
+        goto out;
+    playback_rt =3D playback_ss->runtime;
+
+    capture_ss =3D tascam->capture_substream;
+    capture_rt =3D capture_ss ? capture_ss->runtime : NULL;
+
+    spin_lock_irqsave(&tascam->lock, flags);
+
+    if (tascam->feedback_urb_skip_count > 0) {
+        tascam->feedback_urb_skip_count--;
+        goto unlock_and_continue;
+    }
+
+    old_in_idx =3D tascam->feedback_pattern_in_idx;
+
+    for (p =3D 0; p < urb->number_of_packets; p++) {
+        u8 feedback_value =3D 0;
+        const unsigned int *pattern;
+        bool packet_ok =3D (urb->iso_frame_desc[p].status =3D=3D 0 &&
+                  urb->iso_frame_desc[p].actual_length >=3D 1);
+
+        if (packet_ok)
+            feedback_value =3D *((u8 *)urb->transfer_buffer +
urb->iso_frame_desc[p].offset);
+
+        if (packet_ok && feedback_value >=3D tascam->feedback_base_value &=
&
+            feedback_value <=3D tascam->feedback_max_value) {
+            pattern =3D tascam->feedback_patterns[feedback_value -
tascam->feedback_base_value];
+            tascam->feedback_consecutive_errors =3D 0;
+            int i;
+
+            for (i =3D 0; i < 8; i++) {
+                unsigned int in_idx =3D
(tascam->feedback_pattern_in_idx + i) % FEEDBACK_ACCUMULATOR_SIZE;
+
+                tascam->feedback_accumulator_pattern[in_idx] =3D pattern[i=
];
+                total_frames_in_urb +=3D pattern[i];
+            }
+        } else {
+            unsigned int nominal_frames =3D playback_rt->rate / 8000;
+            int i;
+
+            if (tascam->feedback_synced) {
+                tascam->feedback_consecutive_errors++;
+                if (tascam->feedback_consecutive_errors >
FEEDBACK_SYNC_LOSS_THRESHOLD) {
+                    dev_err(tascam->card->dev, "Fatal: Feedback sync
lost. Stopping stream.\n");
+                    if (playback_ss)
+                        snd_pcm_stop(playback_ss, SNDRV_PCM_STATE_XRUN);
+                    if (capture_ss)
+                        snd_pcm_stop(capture_ss, SNDRV_PCM_STATE_XRUN);
+                    tascam->feedback_synced =3D false;
+                    goto unlock_and_continue;
+                }
+            }
+            for (i =3D 0; i < 8; i++) {
+                unsigned int in_idx =3D
(tascam->feedback_pattern_in_idx + i) % FEEDBACK_ACCUMULATOR_SIZE;
+
+                tascam->feedback_accumulator_pattern[in_idx] =3D nominal_f=
rames;
+                total_frames_in_urb +=3D nominal_frames;
+            }
+        }
+        tascam->feedback_pattern_in_idx =3D
(tascam->feedback_pattern_in_idx + 8) % FEEDBACK_ACCUMULATOR_SIZE;
+    }
+
+    new_in_idx =3D tascam->feedback_pattern_in_idx;
+
+    if (!tascam->feedback_synced) {
+        unsigned int out_idx =3D tascam->feedback_pattern_out_idx;
+        bool is_ahead =3D (new_in_idx - out_idx) %
FEEDBACK_ACCUMULATOR_SIZE < (FEEDBACK_ACCUMULATOR_SIZE / 2);
+        bool was_behind =3D (old_in_idx - out_idx) %
FEEDBACK_ACCUMULATOR_SIZE >=3D (FEEDBACK_ACCUMULATOR_SIZE / 2);
+
+        if (is_ahead && was_behind) {
+            dev_dbg(tascam->card->dev, "Sync Acquired! (in: %u, out:
%u)\n", new_in_idx, out_idx);
+            tascam->feedback_synced =3D true;
+            tascam->feedback_consecutive_errors =3D 0;
+        }
+    }
+
+    if (total_frames_in_urb > 0) {
+        tascam->playback_frames_consumed +=3D total_frames_in_urb;
+        if (atomic_read(&tascam->capture_active))
+            tascam->capture_frames_processed +=3D total_frames_in_urb;
+    }
+
+    if (playback_rt->period_size > 0) {
+        u64 current_period =3D
div_u64(tascam->playback_frames_consumed, playback_rt->period_size);
+
+        if (current_period > tascam->last_period_pos) {
+            tascam->last_period_pos =3D current_period;
+            playback_period_elapsed =3D true;
+        }
+    }
+
+    if (atomic_read(&tascam->capture_active) && capture_rt &&
capture_rt->period_size > 0) {
+        u64 current_capture_period =3D
div_u64(tascam->capture_frames_processed, capture_rt->period_size);
+
+        if (current_capture_period > tascam->last_capture_period_pos) {
+            tascam->last_capture_period_pos =3D current_capture_period;
+            capture_period_elapsed =3D true;
+        }
+    }
+
+unlock_and_continue:
+    spin_unlock_irqrestore(&tascam->lock, flags);
+
+    if (playback_period_elapsed)
+        snd_pcm_period_elapsed(playback_ss);
+    if (capture_period_elapsed)
+        snd_pcm_period_elapsed(capture_ss);
+
+    urb->dev =3D tascam->dev;
+    usb_get_urb(urb);
+    usb_anchor_urb(urb, &tascam->feedback_anchor);
+    ret =3D usb_submit_urb(urb, GFP_ATOMIC);
+    if (ret < 0) {
+        dev_err_ratelimited(tascam->card->dev, "Failed to resubmit
feedback URB: %d\n", ret);
+        usb_unanchor_urb(urb);
+        usb_put_urb(urb);
+    }
+out:
+    usb_put_urb(urb);
+}

Signed-off-by: =C5=A0erif Rami <ramiserifpersia@gmail.com>

