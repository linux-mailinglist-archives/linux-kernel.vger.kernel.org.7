Return-Path: <linux-kernel+bounces-764832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166EDB227B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE10C3B91A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03379281372;
	Tue, 12 Aug 2025 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+Ti5DK2"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CFB27D77A;
	Tue, 12 Aug 2025 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003414; cv=none; b=dMObUjEKNSfEfR0HClXEBEnIhh0qAEnKTdtYpcJQsiD+r98brU/9JHtuRxZ9h4YqiKjZ8w3vug5E1B2yCHI6YYJWTj8z+87yTSVzqYzhioO1dzhH72ZbNRUx95XSHnBao1pzxpnViTCJ69Ko6bJK4RxDPUDfbjU0slCGI+vfyTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003414; c=relaxed/simple;
	bh=XXEWb42qJiWZo4Du0CRE6Yam0gPdSTS3/b8BYir1sbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U07rZCbQT3CkrekVL+VwsyjzE++MXHDatwSisFAWYT6PiofafoWYI7pj6Dyd7/NrMp5BxAGWfiP5tKLaSamSEchzHFJ5eTok++DANwmpbmCDJ3oyU6+7kIzv7o8pQO2TAfkR0AV3sfCcgjy2ZQIs2KN/Mgg+HMji2w5dtD/RIYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+Ti5DK2; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af937728c3eso1005497966b.0;
        Tue, 12 Aug 2025 05:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755003410; x=1755608210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SewnEnAKmtNzuvxDsbzRVoc3jMFrgs3azT7RAG1IenM=;
        b=i+Ti5DK2KEUJJbCUeYjMippZmW3SVa+ZiK99aBQDA1UfPTwJYu5Md5gyfxG9pxHFKQ
         kSx5d52EYnfQcRm5Bzsjwlk21EWbDB7D7koNvpsl5oUCyckgQogpzTK7OYhKwbklBtG1
         a6G1JopkOfT2BAQvZ3z/hV/BLIHErJUhPJ4PCBV6yK8cl8FEbACJ0xHHD7bvCH2fxb5a
         AWgm6wgusWDG+lSrRMjDC/InQEYOLv9JmvHGURGK2DZyzT3vC4ISjdxLHtOPFXz3XMRZ
         TA3E+sL+1ROIKpTBXr5j9bCyVwN2siIZI3Vkr1WPhclUluFdlUs3Af4oxC5J+tlJDvTv
         Fxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003410; x=1755608210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SewnEnAKmtNzuvxDsbzRVoc3jMFrgs3azT7RAG1IenM=;
        b=CJX6zu2pb4V0pS217PF01x+XwzpaYnXDFS0veeil2JlDrw+QxXY2vbAAEz5+SIXc0i
         62WyjI/0Ap3c2R5dR1dPC4dxdfYOKBHCS9p6Tp+IOJp98dYR2jgwZDRVeBR2+piHlvva
         rTmwHdqFNZzuxjGkjyDpyzyvmyRCg4axm4gvHBV2HL7BQ90dOMvQpDOsybZo3BaRwPa/
         9MEaHCQF+V9siNweUcI5tMeaVR0PXNfXUQPfGK2WBscj1+3s6LGvUrRqmXWWsu+5OunI
         ltp/bNxPZ+uf9fP77P2Xk7v7Tou6sF7/8pRHdxZdR8CRt97bHwuN7fg+GSGWBBW73K2g
         5Nrg==
X-Forwarded-Encrypted: i=1; AJvYcCXaVqLpdQYbZSWAaGLPfXpKOfGrscg0KSZo3g0+I+5PmXUFczrM6e5VUeJUgDFsflQPcjQzcppuMp1PJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHu+b/BooTIUL2IXkrxj/yH4Q8X8mu6qqWsmjO7H/sg+PaDtFz
	rq1QqSLXIVMOSxTgG6P1/MQykDvly5vgND6XFV0yLVGsMBILrvY/hXRM
X-Gm-Gg: ASbGncsvkgZCKEYdZ/hGPBFgVFKoNuUw3IDkuhtPQnrT90C8nVKtU/g4Lq5DbtsxKlc
	MbUEEtRH4U4TSeOgEyxQW2NSawuZMLvSIvo5WcxGIG5IorGeFGKYSJSjPIpE72mrCKxVWTazBEz
	NXwXGeaqBbDQA3MLh2mJS9fD84mRdJM68UtW5Gu0wgNYyTNi/v30N/1X38IUYkrFjeMxXcH4nv7
	lKhsr8iRiUV+IzpzlwmonEAn6srYiIsHtDcRKfR1XxbX7Sqd77nA4qbMY4PXzuTCSpujUCGGWkc
	HZHA+PKLYPTZ6SJjlVRFPsW7VhdGP/xF0L5oa/cHQl68bIH9qa44ye9ra+4ZmTJkvoDaXkZuf82
	jBT+DRvR7HWZGxpRphQo17hUgIYcTF6YSuz5gw3WHNrHEAP3rMYsDYpY3cD6Tl0wg10rVjIpp1i
	UoRVXCQg==
X-Google-Smtp-Source: AGHT+IE+vqMk4P+MbwM4HWioLeesfqRDxLFJLOEVmi3u1V2IOOh3UjDUrPNmruLk95l264+D8ZPyow==
X-Received: by 2002:a17:906:f5a9:b0:ae8:8d00:76c3 with SMTP id a640c23a62f3a-afa1d772c6dmr326631966b.29.1755003409748;
        Tue, 12 Aug 2025 05:56:49 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3361sm2199158266b.39.2025.08.12.05.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:56:49 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v2 7/7] ALSA: usb-audio: Add infrastructure for TASCAM US-144MKII
Date: Tue, 12 Aug 2025 14:56:33 +0200
Message-Id: <20250812125633.79270-14-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812125633.79270-1-ramiserifpersia@gmail.com>
References: <20250810124958.25309-1-ramiserifpersia@gmail.com>
 <20250812125633.79270-1-ramiserifpersia@gmail.com>
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


