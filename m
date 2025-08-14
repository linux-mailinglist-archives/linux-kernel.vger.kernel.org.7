Return-Path: <linux-kernel+bounces-768581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E25FB262C4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8141CC5BCB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4EB302773;
	Thu, 14 Aug 2025 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV9/3g2X"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D71C3019B9;
	Thu, 14 Aug 2025 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167148; cv=none; b=jRxI/z91gVeDpxLVxxT1kLns9XZWFyCXO65XxjtOBvc1nwQ09kTcVNcIc/M2BQgvuTRMRQg4sKOeJyKfaG7FOwVRGIiQbk8UVtIiSbAhiaUKnmR1ua19VIAd4p9/sUdbKsx8zmCMN2wFYpTRcJydsQaxhsgRiJO/qCouLyDmg1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167148; c=relaxed/simple;
	bh=XXEWb42qJiWZo4Du0CRE6Yam0gPdSTS3/b8BYir1sbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scdN25ME26cvR5BUd+JwFAd36It/+5l8Q2UMb+SmYLsuFB9BSLfhLCQJ8Ni0C3P6tvnfxTfW4XF8uudD5i0uIOcHmqP0GwOjlg5MqVSOdtqlXZBsBH9NCHa37wqS10Di6HFSrX7jSfsMzrYUCZlfwANC28HBmhePxj2Flt4Orq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV9/3g2X; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so98768866b.3;
        Thu, 14 Aug 2025 03:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755167144; x=1755771944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SewnEnAKmtNzuvxDsbzRVoc3jMFrgs3azT7RAG1IenM=;
        b=YV9/3g2XK6AxpNghPGrojLGTy7YdVxXESeO3sPJ9FvqqEdfM22wSt9z0iPyI45LrrF
         BaNiSPvs3AtTvBg/malBMJqalccmwG0uojtugDRhEAvyA/SUYjogRIt16rglpL74zd+a
         rNtp5n45TB5o/6IwBxw9WNkOmckj5t+9tmH2pf3vxIRBpqgLumX96UBu5JncGZuW/pHk
         R/qEfFC6uN2U9LOh8+0F6ZgTihv2iGKEaZl4IOylxHOOwCTpHfc3uUMgMb/jooSmU9aJ
         wK09uf5PJi16HgcqJEcEBcg61EXrfw0POHnFYpyBmHMWK/SXGWtUUyUbqJxPXKIHzKpA
         an9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755167144; x=1755771944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SewnEnAKmtNzuvxDsbzRVoc3jMFrgs3azT7RAG1IenM=;
        b=WLXOfcngS116oBxsNap8d9DjYL0sTr6tUZkkhdp0+YDD5O31CVk/pECGcMRGs52rWe
         wTUWgY6iWGo3p7JJ5arX2tCPz+XID5rda8eEDWZCCxPAGDJaTN4y/XwsST2kuEnL4wkz
         m2pBZBQBzvjCCFSZa1xjpqsM8tip1kwVjouNoqM5LuM+mXgvcIODNzu/RuibRGvDFSGC
         mchF/jCEBUVsKdE4sjBYB7okJcwsi6M0V6NwkY9dg2qVk3Y2uurl9Q4wtF9+ycgsATKl
         7Xzggd/INiUs0ztCEhhAvpto8Z+djdZShsq2WhAQ+BGuTB3lguIm2fgc8S7qRNZqImYP
         g9XA==
X-Forwarded-Encrypted: i=1; AJvYcCWLPL3pfltlqO1WHlZhXpKFX4XgAi02JMDmSDB64b7w/lK3rNHb03lRc7vBS2JecWBWUK3/l9uiu4X09g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXRS2cbOnu6WXtnp7swj2ViAz76qH3jxzkVW7VxLfmqldHPO9g
	FF8qefXbc+krLHznFS1TXqnj2CbnK4lynjz66s9Hk4d7nR8lNtgbGqVD
X-Gm-Gg: ASbGnctw1YVf7Q+6Tjy42iYpOYvOkuOA5OaBVXMRZSfuxLFIlCC+G+e3rHKdGJ7RDew
	UUtRYrfYVKKvwOWQQ9uRu0gzDXWFC1jLRDouysBt/PP1Dp6yWawLXi+HqMJc3f2pg0l7nDTedH7
	zb+mU1tF0UqJyqNrzeDDaIrt9Jlb93p4UF7fo/i+EKbT763m2t1vo/dZRvd8O0q2WVpWkgVCkOa
	QjkRd6gLtblmbRy+oHyTxDqYMnhK10IAK5YmGTy85fGW352V8tXGjwCiHxiHnd8UoUgmfKQQj0E
	q6b8MG3TyYkDIlRG31YvUwLiq/BPtkNDgrnFdwv2bRKuD1XDOylZznXkvpg+Q33F6lJtN9/0BWB
	BJRpogaPEcuO1BdFx7LTHGaIb3/8NKfCQlZhr9uDZKwucElsFK1cc6RiQ4hgnQHbqktZ3vhbNLV
	OReMMMHVyHzgebDtJZ
X-Google-Smtp-Source: AGHT+IHnjPer6hGFqdqgcMR4LLZgrzX6AF/9gsUnLKsB2TR8vO6mtbamm4yE7uhseuAnQmBoX8mWDQ==
X-Received: by 2002:a17:907:9486:b0:af9:116c:61c4 with SMTP id a640c23a62f3a-afcb98fc88amr219387366b.48.1755167144261;
        Thu, 14 Aug 2025 03:25:44 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a219ef2sm2564819466b.96.2025.08.14.03.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:25:43 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v5 7/7] ALSA: usb-audio: Add infrastructure for TASCAM US-144MKII
Date: Thu, 14 Aug 2025 12:25:34 +0200
Message-Id: <20250814102534.34439-8-ramiserifpersia@gmail.com>
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


