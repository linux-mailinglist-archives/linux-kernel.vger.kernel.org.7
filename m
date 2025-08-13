Return-Path: <linux-kernel+bounces-766729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F306BB24A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623292A134C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9822E92A6;
	Wed, 13 Aug 2025 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZdA7pXl"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEA62A8C1;
	Wed, 13 Aug 2025 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090995; cv=none; b=fVH5m6lSAfSHVO/VB8eibTXMYLJsoR0GhR2xemsTYNlwFcpYK2R7oNJaAXFUor41+rtb/Q3R0VCi+Ela/9AogqY33W0HUL9rQPqyMz5xXznXrj0VM2ubKsl+7nWrBG+lCMkH/9OoIFebPfrshVAMmeIy/8tZneyz0k8VyWkgycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090995; c=relaxed/simple;
	bh=XXEWb42qJiWZo4Du0CRE6Yam0gPdSTS3/b8BYir1sbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HiJQVgj11JkfKb6VqtS8setPhNAwMiaiGyx3yC3pr69nm7BAGBpDy6/gSBDulfjHHf8kUabeF2n+RgePqWuUXnQM1bYbsMdwnYbXUFSyT971emP+4bLwAvFFeNhl5qKC6OQ8poVQDVxRi8o/Mpl2r0/Rs9A1cWhNoz1ScmMK5xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZdA7pXl; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af93381a1d2so1032665166b.3;
        Wed, 13 Aug 2025 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755090992; x=1755695792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SewnEnAKmtNzuvxDsbzRVoc3jMFrgs3azT7RAG1IenM=;
        b=LZdA7pXl18nFn4+aN+dUFIFu1avnx/gi8LlnzB17wX/SoTV07ZEBzo4jRsv6HsyIkR
         TYXBYxzbNtaoWLl01fKCWjFdWNtazA9BdAM3gOBsAI8KkJflUD635+5QjjTc1MsgqlLD
         xbfNvTyOeW5ob/FpW+IQ0rx09um+7B8O505YVOcoVBz6WBGysi/tARnv2JesE099/ZNo
         ft2Mu4n2mOrQhbKm8k6wFa3PM6Aq4OAbiB0qeVx3BpSqQXTMTOght86Q2Aem7967uZjQ
         ma1vsCaqVi4FCfkAz9MoLi4DigvaMKNeur1BPlEDZZbj2CjAbmuJXgOJ0Wk+i6jr8clW
         EBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090992; x=1755695792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SewnEnAKmtNzuvxDsbzRVoc3jMFrgs3azT7RAG1IenM=;
        b=olnqnxnlhsqWTGramHW/dbb5SyfhCcbCZ5ZgneMv7h6COqWz3SaTWipkzb+pSb80pV
         z3j9jvlJ/+fWe4a/Lfa6CFJP4z3wRyMFLRWAB2Hy0RP1f+HiOmxjcVbSjUbLAXFoAGvU
         NNbrhzP+zvotBL7Abw4KOalojC6LagooFf1URI8Kb3wCI0PMmHVxTx8uDrWfJhaLzqSH
         mfWei6rxR3SpJOdTyRJROblz5PFbs6knqympUc/vbCJ+rqc+wKk0s9ebyy7nz8acKinF
         djRcQH9VPmjosSgPJipZBSBt4m5L0DH3QHFwQUQwMLZMLY6FNXkbNsLtHjAGYJEMtHMk
         Zdzg==
X-Forwarded-Encrypted: i=1; AJvYcCXDM5GAHygseUIWmfX1O/S3q57IHFif32Pz/3d12l7tHPEenIjPgwMB5PzaAu3sxqQ55AzXCwwcGk9lsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsEqn7mkISjRK2qjtDGdXmd45YgZ/z+olkaTgTnlZa75J2iQOw
	mzv7yIm1w7Qs/IH1RwA/5CmlC+goJl+Go1YSmBb12lgyM3PSbq61u5fcVYOnY7IXwUg=
X-Gm-Gg: ASbGncuvNzQQVL5OmKA/TviNI5/HbZlbIKi7GVoyShk1m5a/PY0KBA6QCTDYME5E8Np
	rYkUQze97GieVoqfSwTmlfSA6tJybZIZ2JTPsTJUovbj/hlfg1deae52isyA7vuh8uszuAWDo6F
	xhoApDRMQ+/ZNbXS7nM3s/KP1egEjDiQhuR5qi8tp+NL64yoCpLqAyFnSrVjnR0XvLqrnLJao8S
	ji62Fho3LW1EM6TnLA2C+YGz7O+uhDoX6SjwHtNdPf54xi7TH61rYvZB87qA9cGnoUq81eYPq1S
	vpgVnQ8/VQmbDU0zKgvrST+a7k5CIH0wtatL4gJVpNtgo0vicgJfD3UETGypW09YGmFNyIqX+oZ
	2eJrndo7jUJUKoRVvZU45klon5cQdqFtI1DYNSX+ax2LdI6Un/wqls9o3VO/+u4el/bnsOH/KGe
	uF+ubQHg==
X-Google-Smtp-Source: AGHT+IGdLD/mKtGs2SkWWjKvBnLfzmPtLtyxho1PiIq52Q6gLppnFZOBfW+IJASiduJuJkBjSpTDlA==
X-Received: by 2002:a17:907:2d26:b0:af9:a2cb:f1a1 with SMTP id a640c23a62f3a-afca4dff3d1mr329785666b.38.1755090992256;
        Wed, 13 Aug 2025 06:16:32 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e88desm2420481266b.71.2025.08.13.06.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:16:31 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v4 7/7] ALSA: usb-audio: Add infrastructure for TASCAM US-144MKII
Date: Wed, 13 Aug 2025 15:15:18 +0200
Message-Id: <20250813131518.18985-8-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813131518.18985-1-ramiserifpersia@gmail.com>
References: <20250813131518.18985-1-ramiserifpersia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit adds Kconfig and Makefile entries for TASCAM US-144MKII
USB audio/MIDI interface support. It includes the configuration option
and links new driver files.

The Kconfig entry for US-144MKII is added. The Makefile is updated to
compile new driver components.

The US-122L driver's device ID table is adjusted to remove the US-144MKII
entry, as it will now be handled by its dedicated driver.

Signed-off-by: Šerif Rami <ramiserifpersia@gmail.com>
---
 sound/usb/Kconfig        | 12 ++++++++++++
 sound/usb/usx2y/Makefile |  2 ++
 sound/usb/usx2y/us122l.c |  6 ------
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index 41c47301bc19..9b890abd96d3 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -117,6 +117,18 @@ config SND_USB_US122L
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-usb-us122l.
 
+config SND_USB_US144MKII
+	tristate "Tascam US-144MKII USB driver"
+	depends on X86 || COMPILE_TEST
+	select SND_RAWMIDI
+	select SND_PCM
+	help
+	  Say Y here to include support for Tascam US-144MKII USB Audio/MIDI
+	  interface.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-usb-us144mkii.
+
 config SND_USB_6FIRE
 	tristate "TerraTec DMX 6Fire USB"
 	select FW_LOADER
diff --git a/sound/usb/usx2y/Makefile b/sound/usb/usx2y/Makefile
index fc033aba03a4..9db87ae39ee9 100644
--- a/sound/usb/usx2y/Makefile
+++ b/sound/usb/usx2y/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 snd-usb-usx2y-y := usbusx2y.o usX2Yhwdep.o usx2yhwdeppcm.o
 snd-usb-us122l-y := us122l.o
+snd-usb-us144mkii-y := us144mkii.o us144mkii_pcm.o us144mkii_playback.o us144mkii_capture.o us144mkii_midi.o us144mkii_controls.o
 
 obj-$(CONFIG_SND_USB_USX2Y) += snd-usb-usx2y.o
 obj-$(CONFIG_SND_USB_US122L) += snd-usb-us122l.o
+obj-$(CONFIG_SND_USB_US144MKII) += snd-usb-us144mkii.o
\ No newline at end of file
diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index 2ace3ba46091..8dbbefe3e730 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -686,12 +686,6 @@ static const struct usb_device_id snd_us122l_usb_id_table[] = {
 		.idVendor =	0x0644,
 		.idProduct =	USB_ID_US122MKII
 	},
-	{
-		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE,
-		.idVendor =	0x0644,
-		.idProduct =	USB_ID_US144MKII,
-		.driver_info =	US122L_FLAG_US144
-	},
 	{ /* terminator */ }
 };
 MODULE_DEVICE_TABLE(usb, snd_us122l_usb_id_table);
-- 
2.39.5


