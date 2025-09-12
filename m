Return-Path: <linux-kernel+bounces-813255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA65B542BC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491A9562857
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29813287259;
	Fri, 12 Sep 2025 06:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mm4wKv5J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D5F27F736;
	Fri, 12 Sep 2025 06:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757658158; cv=none; b=dfsuakEXLBADIMiRlaPj477OuRr+lsReq1HPkeTOBFMnGpDDsA32YMA/e9JZcg6x6MZMKeSHIZj2X9zL1EYa1n5ImQBw5LTe2dt5bkAH8fsMsfQ+lopJzt8wXmU55Wz0CKH3Yk+JmK1ap3ww1Vlu72oYTg2TFTfTBHlm2Q+79U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757658158; c=relaxed/simple;
	bh=vCjPSSITIzPRQT8N5oaqQJbFO4omiAxBTAfZpvgTWcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=asI8ZFHj7X4qnpKMLimmpnsChH8m838cCxlFp+Xfuw/P8MXXOVnF4ETMbEDg49iT46u7MXH9lSCS1ctSs7wGLBa6ro4Go6pBcWrBSoEXq1fSRyIQAYv727xzgv/8K/37vQ8cV3aGuDwEuGw0p4eyxEertw5wodClcSKKooR1n4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mm4wKv5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B70C5C4CEF5;
	Fri, 12 Sep 2025 06:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757658157;
	bh=vCjPSSITIzPRQT8N5oaqQJbFO4omiAxBTAfZpvgTWcA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mm4wKv5JDw67C4lVSCiX+wWpWk9iHc+riu6dl43QMX9ebduCfiaOzWdYB2Jcx/6W3
	 DIi58VGI9SybgknaXp4hM3x7MpEf4ohs1E/NiiJKjQ63pqA0WmDHyD9LkS5b8s3tkp
	 +knqPIbfPRKXjnGgTtwoQrDMRHc4OJCdiQKaA5rrWZ03yC2XzLOOAzqy88EqfbVPZQ
	 yZEKlfCOR0R5wWUxe7YoadkBqjyASg6L8wkBZrQj5txyC5UhtxOGsoEjBxAx5unCjb
	 Dtqf23fitfUrpccjnwr6jRfezrzBUF/WaZQ0t7vfCkMJcCHwXNbHonL4ny4rh5N61c
	 8hO/eLi6NRYCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91CFCAC594;
	Fri, 12 Sep 2025 06:22:37 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Fri, 12 Sep 2025 14:22:36 +0800
Subject: [PATCH 2/3] ALSA: usb-audio: add module param device_quirk_flags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-sound-v1-2-cc9cfd9f2d01@uniontech.com>
References: <20250912-sound-v1-0-cc9cfd9f2d01@uniontech.com>
In-Reply-To: <20250912-sound-v1-0-cc9cfd9f2d01@uniontech.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>, 
 Feng Yuan <fengyuan@uniontech.com>, qaqland <anguoli@uniontech.com>, 
 kernel@uniontech.com, Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757658156; l=8762;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=PKErF/ur/Uw2za/xtmSbMpGPjwDMtMdvq6Cej79B92w=;
 b=89LOfVHoq9hjHWiu3lHa2GF2iwvEGiuAEN1Dh0wAoRZ55I4B3dURFzuPgeE7NpTPuUtQSxcwg
 m5YnUsZ6JTDBOUK+hP0nuffYJngpT3jVCgwZ65niSKBALkfv5E46Tx9
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

For apply and unapply quirk flags more flexibly though param and sysfs

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 sound/usb/card.c     | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 sound/usb/quirks.c   |  51 ++++++++++++++++
 sound/usb/quirks.h   |   2 +
 sound/usb/usbaudio.h |  13 ++++
 4 files changed, 230 insertions(+), 1 deletion(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 0265206a8e8cf31133e8463c98fe0497d8ace89e..e53fd868f34e93d42b1447958fc136658a6f9dd2 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -77,6 +77,7 @@ static unsigned int quirk_flags[SNDRV_CARDS];
 
 bool snd_usb_use_vmalloc = true;
 bool snd_usb_skip_validation;
+char device_quirk_flags[MAX_QUIRK_PARAM_LEN];
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for the USB audio adapter.");
@@ -110,6 +111,149 @@ MODULE_PARM_DESC(use_vmalloc, "Use vmalloc for PCM intermediate buffers (default
 module_param_named(skip_validation, snd_usb_skip_validation, bool, 0444);
 MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no).");
 
+DEFINE_MUTEX(device_quirk_mutex); /* protects device_quirk_list */
+
+struct device_quirk_entry *device_quirk_list;
+unsigned int device_quirk_count;
+
+static int device_quirks_param_set(const char *value,
+				   const struct kernel_param *kp)
+{
+	char *val, *p, *field, *flag_field;
+	u32 mask_flags, unmask_flags, bit;
+	bool is_unmask;
+	u16 vid, pid;
+	size_t i;
+	int err;
+
+	val = kstrdup(value, GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
+
+	err = param_set_copystring(val, kp);
+	if (err) {
+		kfree(val);
+		return err;
+	}
+
+	mutex_lock(&device_quirk_mutex);
+
+	if (!*val) {
+		device_quirk_count = 0;
+		kfree(device_quirk_list);
+		device_quirk_list = NULL;
+		goto unlock;
+	}
+
+	for (device_quirk_count = 1, i = 0; val[i]; i++)
+		if (val[i] == ';')
+			device_quirk_count++;
+
+	kfree(device_quirk_list);
+
+	device_quirk_list = kcalloc(device_quirk_count,
+				    sizeof(struct device_quirk_entry),
+				    GFP_KERNEL);
+	if (!device_quirk_list) {
+		device_quirk_count = 0;
+		mutex_unlock(&device_quirk_mutex);
+		kfree(val);
+		return -ENOMEM;
+	}
+
+	for (i = 0, p = val; p && *p;) {
+		/* Each entry consists of VID:PID:flags */
+		field = strsep(&p, ":");
+		if (!field)
+			break;
+
+		if (strcmp(field, "*") == 0)
+			vid = 0;
+		else if (kstrtou16(field, 16, &vid))
+			break;
+
+		field = strsep(&p, ":");
+		if (!field)
+			break;
+
+		if (strcmp(field, "*") == 0)
+			pid = 0;
+		else if (kstrtou16(field, 16, &pid))
+			break;
+
+		field = strsep(&p, ";");
+		if (!field || !*field)
+			break;
+
+		/* Collect the flags */
+		mask_flags = 0;
+		unmask_flags = 0;
+		while (field && *field) {
+			flag_field = strsep(&field, ",");
+
+			if (!flag_field)
+				break;
+
+			if (*flag_field == '!') {
+				is_unmask = true;
+				flag_field++;
+			} else {
+				is_unmask = false;
+			}
+
+			if (!kstrtou32(flag_field, 16, &bit)) {
+				if (is_unmask)
+					unmask_flags |= bit;
+				else
+					mask_flags |= bit;
+
+				break;
+			}
+
+			bit = snd_usb_quirk_flags_from_name(flag_field);
+
+			if (bit) {
+				if (is_unmask)
+					unmask_flags |= bit;
+				else
+					mask_flags |= bit;
+			} else {
+				pr_warn("snd_usb_audio: unknown flag %s while parsing param device_quirk_flags\n",
+					flag_field);
+			}
+		}
+		device_quirk_list[i++] = (struct device_quirk_entry){
+			.vid = vid,
+			.pid = pid,
+			.mask_flags = mask_flags,
+			.unmask_flags = unmask_flags,
+		};
+	}
+
+	if (i < device_quirk_count)
+		device_quirk_count = i;
+
+unlock:
+	mutex_unlock(&device_quirk_mutex);
+	kfree(val);
+
+	return 0;
+}
+
+static const struct kernel_param_ops device_quirks_param_ops = {
+	.set = device_quirks_param_set,
+	.get = param_get_string,
+};
+
+static struct kparam_string device_quirks_param_string = {
+	.maxlen = sizeof(device_quirk_flags),
+	.string = device_quirk_flags,
+};
+
+device_param_cb(device_quirk_flags, &device_quirks_param_ops,
+		&device_quirks_param_string, 0644);
+MODULE_PARM_DESC(device_quirk_flags, "Add/modify USB audio quirks");
+
 /*
  * we keep the snd_usb_audio_t instances by ourselves for merging
  * the all interfaces on the same card as one sound device.
@@ -755,6 +899,8 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 	else
 		snd_usb_init_quirk_flags(chip);
 
+	snd_usb_init_dynamic_quirks(chip);
+
 	card->private_free = snd_usb_audio_free;
 
 	strscpy(card->driver, "USB-Audio");
@@ -1290,4 +1436,21 @@ static struct usb_driver usb_audio_driver = {
 	.supports_autosuspend = 1,
 };
 
-module_usb_driver(usb_audio_driver);
+static int __init usb_audio_init(void)
+{
+	return usb_register_driver(&usb_audio_driver, THIS_MODULE,
+							   KBUILD_MODNAME);
+}
+
+static void __exit usb_audio_exit(void)
+{
+	mutex_lock(&device_quirk_mutex);
+	kfree(device_quirk_list);
+	device_quirk_list = NULL;
+	mutex_unlock(&device_quirk_mutex);
+
+	usb_deregister(&usb_audio_driver);
+}
+
+module_init(usb_audio_init);
+module_exit(usb_audio_exit);
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 022e5691d6797c0a17a1132b05856e816f822ab0..88481e34f9b85ce223c989ee4ad54908eff73e2c 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2539,3 +2539,54 @@ void snd_usb_init_quirk_flags(struct snd_usb_audio *chip)
 		}
 	}
 }
+
+void snd_usb_init_dynamic_quirks(struct snd_usb_audio *chip)
+{
+	u16 vid = USB_ID_VENDOR(chip->usb_id);
+	u16 pid = USB_ID_PRODUCT(chip->usb_id);
+	int i, flags = 0;
+
+	mutex_lock(&device_quirk_mutex);
+
+	for (i = 0; i < device_quirk_count; i++) {
+		if (device_quirk_list[i].vid == 0 ||
+		    (vid == device_quirk_list[i].vid &&
+		     device_quirk_list[i].pid == 0) ||
+		    (vid == device_quirk_list[i].vid &&
+		     pid == device_quirk_list[i].pid)) {
+			flags |= device_quirk_list[i].mask_flags;
+			flags &= ~device_quirk_list[i].unmask_flags;
+			usb_audio_dbg(chip,
+				      "Set mask quirk flag 0x%x and unmask quirk flag 0x%x from param for device %04x:%04x\n",
+				      device_quirk_list[i].mask_flags,
+				      device_quirk_list[i].unmask_flags,
+				      USB_ID_VENDOR(chip->usb_id),
+				      USB_ID_PRODUCT(chip->usb_id));
+			break;
+		}
+	}
+
+	mutex_unlock(&device_quirk_mutex);
+}
+
+void snd_usb_init_dynamic_quirks(struct snd_usb_audio *chip)
+{
+	u16 vid = USB_ID_VENDOR(chip->usb_id);
+	u16 pid = USB_ID_PRODUCT(chip->usb_id);
+	int i;
+
+	mutex_lock(&device_quirk_mutex);
+
+	for (i = 0; i < device_quirk_count; i++) {
+		if (device_quirk_list[i].vid == 0 ||
+		    (vid == device_quirk_list[i].vid &&
+		     device_quirk_list[i].pid == 0) ||
+		    (vid == device_quirk_list[i].vid &&
+		     pid == device_quirk_list[i].pid)) {
+			chip->quirk_flags |= device_quirk_list[i].mask_flags;
+			chip->quirk_flags &= ~device_quirk_list[i].unmask_flags;
+		}
+	}
+
+	mutex_unlock(&device_quirk_mutex);
+}
diff --git a/sound/usb/quirks.h b/sound/usb/quirks.h
index 749d493eb532c071ee40cf4b2840bb4902ab4681..e8e32432df69f2eb16f84b8a9c72f0a753a3589f 100644
--- a/sound/usb/quirks.h
+++ b/sound/usb/quirks.h
@@ -54,4 +54,6 @@ const char *snd_usb_quirk_flag_find_name(unsigned long flag);
 
 u32 snd_usb_quirk_flags_from_name(char *name);
 
+void snd_usb_init_dynamic_quirks(struct snd_usb_audio *chip);
+
 #endif /* __USBAUDIO_QUIRKS_H */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 0a22cb4a02344b2dcf4009c560a759f2da25ca67..cb6cab37d749a258258394816e74c939cdd471fe 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -20,6 +20,7 @@ struct media_device;
 struct media_intf_devnode;
 
 #define MAX_CARD_INTERFACES	16
+#define MAX_QUIRK_PARAM_LEN	128
 
 /*
  * Structure holding assosiation between Audio Control Interface
@@ -165,6 +166,11 @@ DEFINE_CLASS(snd_usb_lock, struct __snd_usb_lock,
 extern bool snd_usb_use_vmalloc;
 extern bool snd_usb_skip_validation;
 
+extern struct mutex device_quirk_mutex;
+extern char device_quirk_flags[MAX_QUIRK_PARAM_LEN];
+extern unsigned int device_quirk_count;
+extern struct device_quirk_entry *device_quirk_list;
+
 /*
  * Driver behavior quirk flags, stored in chip->quirk_flags
  *
@@ -254,4 +260,11 @@ extern bool snd_usb_skip_validation;
 #define QUIRK_FLAG_MIXER_CAPTURE_MIN_MUTE	(1U << 25)
 /* Please also edit snd_usb_audio_quirk_flag_names */
 
+struct device_quirk_entry {
+	u16 vid;
+	u16 pid;
+	u32 mask_flags;
+	u32 unmask_flags;
+};
+
 #endif /* __USBAUDIO_H */

-- 
2.51.0



