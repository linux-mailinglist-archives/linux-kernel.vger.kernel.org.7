Return-Path: <linux-kernel+bounces-761434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFB6B1F9FE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 14:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D5754E1AFA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 12:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA0C264A60;
	Sun, 10 Aug 2025 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNfyCGVZ"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FCE25FA0F;
	Sun, 10 Aug 2025 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754830212; cv=none; b=bQ7FGj9AuLB7TZPpJ1HVlx72D9irvXgdB2pkcRLAPZwOs5gNC3idVZ+MhC5SzVpdXeuyWBT7S/bF7hjs6BnvMCB7tIUoVAlj/WH3I0fYW4+8j7RE1WbQ3hCB4RdOKW+VeoqLxHfKCWxt9z7L1C0JAXeo939B7GkKRskmZMtO5Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754830212; c=relaxed/simple;
	bh=Hol6FTiuhnxNoFj+LeMFXbgala02jFTzkoqZz/fzEq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRzK+aITJ+qiCFVXKoMjZLCyCk3IxQ0iRmGmJNNvQURol1GB4DlLGFaUXlEOn/Ckl4jZZng+lLLWpzTZbnEN+kYwjMY7qVE168NQt7bMfPkUVI7+RWf/IkCfQb9PI+eECw6yvJ1Mw5VjYV/pDYZkr7d/rxFG/CpPLraltaRsB/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNfyCGVZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61557997574so5044044a12.3;
        Sun, 10 Aug 2025 05:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754830209; x=1755435009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0T2oTDEMu0cNGfNCGbYqPa+Bpgqo9lJMKkFHW5PkvY=;
        b=ZNfyCGVZaKAAYRM269qWUE21pXZavQPtCgWziF0KmvexX5jPNzbufcYUp3ZW/o2Zii
         iYLoyg6vQEAL/AoPP2rYzt0u/ZGYvdbAiSuDT3QNY8dcHO8zO7lZrt3cE0ye/pwYV6Oy
         YWvZGfLasbI2sxEWj5hSNDGuJEmBnPRghC0HXUvtTrVBo1K/R5stA9AJkiE1I3IpGOmM
         YOo1aDJa1xabihJXnzAj6BnjkPRS3pWzkI1JD/SG7SxcmzVwSoYCjYYregCrIUi8/eMQ
         BjR6VrUnbj9yc5oM6lOa9mSwdn7Wj2UKN8jQYvNDgMKc/UdD03lO/J7JF2Q6mdd6mJiI
         4DVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754830209; x=1755435009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0T2oTDEMu0cNGfNCGbYqPa+Bpgqo9lJMKkFHW5PkvY=;
        b=nPYuKqwZ0cB2NOWAxL0y+Bou2Xtub+XzIbknFIAnFA/BQGITywRs0AqPbjcrGJWmMu
         1ibQV/KmqgHxhYn7/OfVLBzJyN8JM1ceS8I6e23+gqFrxxgPWdlEy0aXsV/UxpYsXYfk
         bMVAzbPjuWnJIBpweTFs0YX4jQDQVMdwK7sqw/sfHPdIjQW5w1Nrjb0tpEf+D8KI1dk+
         OXpSKKSIBgfk0E8fmlwPpj0KIkYun1tx98Vro4G2XnBlRonSXm8Wc2KMhhCtm8i5pABH
         66lGpRQxKc33N6JWMwqDcOpnZ77idxt7/5koIGk8mbfP9sdY5/Qgh7RnIdeM7W4hQd1R
         e1Yw==
X-Forwarded-Encrypted: i=1; AJvYcCU27aAZZjWoriIPHGPlhcp9+ZY69JBaUVXiEVhchVPqopoxsElO2m/UDZjpkrCf1hB09vKsrdjlcUywnG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yziuyb0+inasQyG6YM4FuCYuacwijQV0qkeU4KSdj8EMzBptbQC
	Re0Wve0XsJcoy9KchZnXlhV5FzF0gASf0miyMaziHqlHm/++kbo70Agj
X-Gm-Gg: ASbGncuI8TTGaCIoqCM0YHyqsKoMXT0Z0OYTMj4lcWd9ZLlJjYBFH/FcVJKlfNJqIqK
	g2/yliQ0YKwf37fTRbLYGzp/Y8y3TLjhga/RCq2C0qzrS/sdO2H38c2MT9SErvl0w5l8RkwXWNo
	QirCyv7GhZotTiAzN65bERck37Jej+GquQQXRhWoc5B9wF0mdkgYrWq9rTHndRZMCCIMogOFFxF
	7rnPLPuSXOcIF9mNnTn+iPgifv9Bo08Xnrq3/dSYR7F7gmxMwYbrDigmyGFtXMcfYl96Sm/pEzs
	WM6L5APYyiDy9cIMzh+eju2kLAXzUqgH9QIKOlM79IAHNK8vD5GAWHfe6OeFD1CK1tdLbg7lU+B
	LJBLJ8o8XEtW4wQEMu5k6hKPm03TE3RSZleb08Eg/f/PcQFzki4GKFucgjscZtsoe2pRUnCylQq
	GFNVoH6A==
X-Google-Smtp-Source: AGHT+IFDaztN8F6u8Lfh3PPW+JoY5Sn2z/piLwLd9k+Fli3Nx426BJQEv1p4wq7FgERlvH9/UcaSyQ==
X-Received: by 2002:a05:6402:518e:b0:618:20c1:7e74 with SMTP id 4fb4d7f45d1cf-61820c18075mr1606002a12.25.1754830209121;
        Sun, 10 Aug 2025 05:50:09 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffbdb4sm16636594a12.52.2025.08.10.05.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:50:07 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH 6/7] ALSA: usb-audio: us144mkii: Add deep sleep and code style alignments
Date: Sun, 10 Aug 2025 14:49:57 +0200
Message-Id: <20250810124958.25309-7-ramiserifpersia@gmail.com>
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

Add a deep sleep vendor command to be sent during suspend, allowing the
device to enter a lower power state.

This commit also includes code style alignments and implements some
leftover suggestions that were missed in previous commits.

Signed-off-by: Šerif Rami <ramiserifpersia@gmail.com>
---
 sound/usb/usx2y/us144mkii.c          |  8 ++++
 sound/usb/usx2y/us144mkii.h          |  2 +
 sound/usb/usx2y/us144mkii_controls.c | 70 ++++++++++++++++++++--------
 sound/usb/usx2y/us144mkii_pcm.c      |  5 +-
 4 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/sound/usb/usx2y/us144mkii.c b/sound/usb/usx2y/us144mkii.c
index a225963c50d2..de2abea5c889 100644
--- a/sound/usb/usx2y/us144mkii.c
+++ b/sound/usb/usx2y/us144mkii.c
@@ -322,6 +322,13 @@ static int tascam_suspend(struct usb_interface *intf, pm_message_t message)
 	usb_kill_anchored_urbs(&tascam->midi_in_anchor);
 	usb_kill_anchored_urbs(&tascam->midi_out_anchor);
 
+	dev_info(&intf->dev, "sending deep sleep command\n");
+	int err = usb_control_msg(tascam->dev, usb_sndctrlpipe(tascam->dev, 0),
+				  VENDOR_REQ_DEEP_SLEEP, RT_H2D_VENDOR_DEV,
+				  0x0000, 0x0000, NULL, 0, USB_CTRL_TIMEOUT_MS);
+	if (err < 0)
+		dev_err(&intf->dev, "deep sleep command failed: %d\n", err);
+
 	return 0;
 }
 
@@ -495,6 +502,7 @@ static int tascam_probe(struct usb_interface *intf,
 	INIT_WORK(&tascam->stop_work, tascam_stop_work_handler);
 	INIT_WORK(&tascam->stop_pcm_work, tascam_stop_pcm_work_handler);
 	INIT_WORK(&tascam->capture_work, tascam_capture_work_handler);
+	init_completion(&tascam->midi_out_drain_completion);
 
 	if (kfifo_alloc(&tascam->midi_in_fifo, MIDI_IN_FIFO_SIZE, GFP_KERNEL)) {
 		snd_card_free(card);
diff --git a/sound/usb/usx2y/us144mkii.h b/sound/usb/usx2y/us144mkii.h
index 9b7749764fc8..ecc4c2fed9e6 100644
--- a/sound/usb/usx2y/us144mkii.h
+++ b/sound/usb/usx2y/us144mkii.h
@@ -46,6 +46,7 @@ enum uac_control_selector {
 
 enum tascam_vendor_request {
 	VENDOR_REQ_REGISTER_WRITE = 0x41,
+	VENDOR_REQ_DEEP_SLEEP = 0x44,
 	VENDOR_REQ_MODE_CONTROL = 0x49,
 };
 
@@ -261,6 +262,7 @@ struct tascam_card {
 	unsigned long midi_out_urbs_in_flight;
 	u8 midi_running_status;
 	struct timer_list error_timer;
+	struct completion midi_out_drain_completion;
 
 	/* --- Feedback Sync State --- */
 	unsigned int feedback_accumulator_pattern[FEEDBACK_ACCUMULATOR_SIZE];
diff --git a/sound/usb/usx2y/us144mkii_controls.c b/sound/usb/usx2y/us144mkii_controls.c
index 4262b7f45139..bbc8da5c8e8d 100644
--- a/sound/usb/usx2y/us144mkii_controls.c
+++ b/sound/usb/usx2y/us144mkii_controls.c
@@ -53,8 +53,11 @@ static int tascam_line_out_get(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
 	struct tascam_card *tascam = snd_kcontrol_chip(kcontrol);
+	int val;
 
-	ucontrol->value.enumerated.item[0] = tascam->line_out_source;
+	guard(spinlock_irqsave)(&tascam->lock);
+	val = tascam->line_out_source;
+	ucontrol->value.enumerated.item[0] = val;
 	return 0;
 }
 
@@ -73,13 +76,17 @@ static int tascam_line_out_put(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
 	struct tascam_card *tascam = snd_kcontrol_chip(kcontrol);
+	int changed = 0;
 
 	if (ucontrol->value.enumerated.item[0] > 1)
 		return -EINVAL;
-	if (tascam->line_out_source == ucontrol->value.enumerated.item[0])
-		return 0;
-	tascam->line_out_source = ucontrol->value.enumerated.item[0];
-	return 1;
+
+	guard(spinlock_irqsave)(&tascam->lock);
+	if (tascam->line_out_source != ucontrol->value.enumerated.item[0]) {
+		tascam->line_out_source = ucontrol->value.enumerated.item[0];
+		changed = 1;
+	}
+	return changed;
 }
 
 /**
@@ -115,8 +122,11 @@ static int tascam_digital_out_get(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
 	struct tascam_card *tascam = snd_kcontrol_chip(kcontrol);
+	int val;
 
-	ucontrol->value.enumerated.item[0] = tascam->digital_out_source;
+	guard(spinlock_irqsave)(&tascam->lock);
+	val = tascam->digital_out_source;
+	ucontrol->value.enumerated.item[0] = val;
 	return 0;
 }
 
@@ -136,13 +146,17 @@ static int tascam_digital_out_put(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol)
 {
 	struct tascam_card *tascam = snd_kcontrol_chip(kcontrol);
+	int changed = 0;
 
 	if (ucontrol->value.enumerated.item[0] > 1)
 		return -EINVAL;
-	if (tascam->digital_out_source == ucontrol->value.enumerated.item[0])
-		return 0;
-	tascam->digital_out_source = ucontrol->value.enumerated.item[0];
-	return 1;
+
+	guard(spinlock_irqsave)(&tascam->lock);
+	if (tascam->digital_out_source != ucontrol->value.enumerated.item[0]) {
+		tascam->digital_out_source = ucontrol->value.enumerated.item[0];
+		changed = 1;
+	}
+	return changed;
 }
 
 /**
@@ -196,8 +210,11 @@ static int tascam_capture_12_get(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct tascam_card *tascam = snd_kcontrol_chip(kcontrol);
+	int val;
 
-	ucontrol->value.enumerated.item[0] = tascam->capture_12_source;
+	guard(spinlock_irqsave)(&tascam->lock);
+	val = tascam->capture_12_source;
+	ucontrol->value.enumerated.item[0] = val;
 	return 0;
 }
 
@@ -217,13 +234,17 @@ static int tascam_capture_12_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct tascam_card *tascam = snd_kcontrol_chip(kcontrol);
+	int changed = 0;
 
 	if (ucontrol->value.enumerated.item[0] > 1)
 		return -EINVAL;
-	if (tascam->capture_12_source == ucontrol->value.enumerated.item[0])
-		return 0;
-	tascam->capture_12_source = ucontrol->value.enumerated.item[0];
-	return 1;
+
+	guard(spinlock_irqsave)(&tascam->lock);
+	if (tascam->capture_12_source != ucontrol->value.enumerated.item[0]) {
+		tascam->capture_12_source = ucontrol->value.enumerated.item[0];
+		changed = 1;
+	}
+	return changed;
 }
 
 /**
@@ -260,8 +281,11 @@ static int tascam_capture_34_get(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct tascam_card *tascam = snd_kcontrol_chip(kcontrol);
+	int val;
 
-	ucontrol->value.enumerated.item[0] = tascam->capture_34_source;
+	guard(spinlock_irqsave)(&tascam->lock);
+	val = tascam->capture_34_source;
+	ucontrol->value.enumerated.item[0] = val;
 	return 0;
 }
 
@@ -281,13 +305,17 @@ static int tascam_capture_34_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct tascam_card *tascam = snd_kcontrol_chip(kcontrol);
+	int changed = 0;
 
 	if (ucontrol->value.enumerated.item[0] > 1)
 		return -EINVAL;
-	if (tascam->capture_34_source == ucontrol->value.enumerated.item[0])
-		return 0;
-	tascam->capture_34_source = ucontrol->value.enumerated.item[0];
-	return 1;
+
+	guard(spinlock_irqsave)(&tascam->lock);
+	if (tascam->capture_34_source != ucontrol->value.enumerated.item[0]) {
+		tascam->capture_34_source = ucontrol->value.enumerated.item[0];
+		changed = 1;
+	}
+	return changed;
 }
 
 /**
@@ -349,10 +377,12 @@ static int tascam_samplerate_get(struct snd_kcontrol *kcontrol,
 	int err;
 	u32 rate = 0;
 
+	guard(spinlock_irqsave)(&tascam->lock);
 	if (tascam->current_rate > 0) {
 		ucontrol->value.integer.value[0] = tascam->current_rate;
 		return 0;
 	}
+	// Lock is released here before kmalloc and usb_control_msg
 
 	buf = kmalloc(3, GFP_KERNEL);
 	if (!buf)
diff --git a/sound/usb/usx2y/us144mkii_pcm.c b/sound/usb/usx2y/us144mkii_pcm.c
index 953d5e7a7235..5a066ce0dbd8 100644
--- a/sound/usb/usx2y/us144mkii_pcm.c
+++ b/sound/usb/usx2y/us144mkii_pcm.c
@@ -115,11 +115,12 @@ void process_capture_routing_us144mkii(struct tascam_card *tascam,
 int us144mkii_configure_device_for_rate(struct tascam_card *tascam, int rate)
 {
 	struct usb_device *dev = tascam->dev;
-	u8 *rate_payload_buf;
 	u16 rate_vendor_wValue;
 	int err = 0;
 	const u8 *current_payload_src;
 
+	u8 *rate_payload_buf __free(kfree);
+
 	static const u8 payload_44100[] = { 0x44, 0xac, 0x00 };
 	static const u8 payload_48000[] = { 0x80, 0xbb, 0x00 };
 	static const u8 payload_88200[] = { 0x88, 0x58, 0x01 };
@@ -209,14 +210,12 @@ int us144mkii_configure_device_for_rate(struct tascam_card *tascam, int rate)
 	if (err < 0)
 		goto fail;
 
-	kfree(rate_payload_buf);
 	return 0;
 
 fail:
 	dev_err(&dev->dev,
 		"Device configuration failed at rate %d with error %d\n", rate,
 		err);
-	kfree(rate_payload_buf);
 	return err;
 }
 
-- 
2.39.5


