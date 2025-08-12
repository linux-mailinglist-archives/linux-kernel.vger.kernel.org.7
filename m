Return-Path: <linux-kernel+bounces-764888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED15FB22866
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDE71AA0CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23268280CEA;
	Tue, 12 Aug 2025 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je9PcbM0"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE4727FD46;
	Tue, 12 Aug 2025 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004941; cv=none; b=gXmFqIFl0COFMrJb3XkzLLiXV7DoU7mnmUfhRDiwW44hQlxjN5F5gGRAIIooVQ600Ybb4GammHlk41b4drfiSiemAg5yRyIiGAuLWwjZ8aENiMOmdti0iOh7g6vduqO7Nps4VDVzryssLgvxaCrOWD1GTe9wCdRhyqnZJMNJLHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004941; c=relaxed/simple;
	bh=XXEWb42qJiWZo4Du0CRE6Yam0gPdSTS3/b8BYir1sbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4qfwJEdgrCcyWLR0VuY3Q7QkVgX2NC6ur7ej/coqJzZ+XzJLZNFP1GmZncavDsy1R2wjn2Y4XFe+IhU9pbefj1LLRzF6JeS5iZXq2cw2SDPtXBZJtBwpGRFkWgMpe8+B+dcQuZNImRzaUOLiiejvyrlY9pa7VrpGlyHmA/S4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je9PcbM0; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61580eb7995so11044335a12.0;
        Tue, 12 Aug 2025 06:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755004938; x=1755609738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SewnEnAKmtNzuvxDsbzRVoc3jMFrgs3azT7RAG1IenM=;
        b=Je9PcbM0qCMQ2GnNN/mhnIu2EDVNYSIQAfjyFb1T9JsmdsoTDjaHe59LNf14WizB7q
         dB8KC8pihjmLgfUAhf6ANqI54br5I6pG8lmwu1+3AsLqAzExa3It0K1sQKBe1b7mmw+N
         E4a8LHUjGwnW7C0Z4lYKZRX1xRAQ6uFSQCaBUR78FAPpC3Fv2IhlNT6fKgo0LLVn/WCi
         /Ao/cPOA2od1grV0jxB8/A3n5GnUtXDTAGDSr6LMURVv86SpmfOXilyT10gE9+HrwP6g
         RsoB+39xuUrMISAqqgvB0zZAFxPeU+1AQCY1ntx2fogou7Q6Ql/Kk7mvEGnXL8sd7EO8
         U6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755004938; x=1755609738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SewnEnAKmtNzuvxDsbzRVoc3jMFrgs3azT7RAG1IenM=;
        b=uVUn28trHy9nSnkOh5H7GX9CF6NdRck2bn0nPCPFYovlDnmssrrUOTFGZExvCRdcQu
         kuO5pvyVxRmKelFIENI/NllcNhfRl6V+7uOo2VfFAoMF0/ATo6EpS5z1y7zAdS/O/1EP
         ocAfXcp8QOVIsZZ7ZoL8RRNvR34e0a1t2Jw9xNvsAuN1cVyaWKamcFZXivlNzL+YmlUA
         yVqqJNZGAltnkLWBBdDVPLw+9JX1OrciXYtzImb7U7f3i8Fi1X5InxjfJnD2J6C/GQXK
         ZAC5nf6zRSlPkIJXAr6apC9MN7qocMb/WDEljBi66TfL+/RxOh2vDlrpef32ISKTCctp
         CagQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhQ07pdD4D6BfgHEZklSIa6JjvCQqM7EUSFhK+nQZgRDpncUhPKkmumljKr0joxQXdYhzvnzpgpm0e6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYOh15L1YIBeWD27Zs7xT+mDRX3AyIBVRMST5hZBzVrmceBNyn
	51y36RGV/PDBHbgtMdMEebsVREcxhJvRvGYeXTT8wFOLJkEA0eS3+GmM
X-Gm-Gg: ASbGnctqPHC3E1pO3x0QBj0UYxNONg9D1IpzOMqqhdjgL7iefp+w+fmeeRMe+Wk858f
	GBKLDAhVOlxHfmRPQiy/WaBBLKSpfyAJB1RZQC0gYijjuLd927k6pddxP8YJqs5NAvWC8XfNrRs
	iUdQdbuf5xTs7KCsUSyDziyLG1/53N5kijaRNYg1cOlPJ/7h+zVTiOMIBFW74fO1p0EIIoRre9C
	fUnMzsht5+jTE3t7qRXB4xzXejKPH9fratsL+muqL6c2U+cAJLNoOUkAJ33tWtJIhy6MpxeUZcq
	J95/AqQ4CCERiRF6Bn69yWf8Yh6zTRkFhpiStVVLcf2AQp8PNVn1UFVd0bB4LvJdeRL1k3+T4FW
	YPwr4HdsMMYEV8PNR5OOb2MaUIu+lbL2vT7rxyX8rXfTjeQmtMRdiQzQPUo4+G0Kb3udlvVA0o7
	1Eaq8dbQ==
X-Google-Smtp-Source: AGHT+IGw6dl48kxurr+D+3byaRM8uZg+6+5OVG90W9kalsUW0FaaXTZZI5P+y9cu21RtZnlXvU5GTA==
X-Received: by 2002:a05:6402:704:b0:615:4a9e:af11 with SMTP id 4fb4d7f45d1cf-6184d8475acmr2291269a12.3.1755004937637;
        Tue, 12 Aug 2025 06:22:17 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61850794509sm1315511a12.31.2025.08.12.06.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:22:17 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v3 7/7] ALSA: usb-audio: Add infrastructure for TASCAM US-144MKII
Date: Tue, 12 Aug 2025 15:22:09 +0200
Message-Id: <20250812132209.83728-8-ramiserifpersia@gmail.com>
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


