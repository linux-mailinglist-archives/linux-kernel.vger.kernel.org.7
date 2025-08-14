Return-Path: <linux-kernel+bounces-769373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A452DB26D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A037E5E57ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEB2230D1E;
	Thu, 14 Aug 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F92Yl7dy"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED313002D7;
	Thu, 14 Aug 2025 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192158; cv=none; b=F4kzHySrBw0ZGphJqfWpeDQi0lY9Mt/7YfI7GcBVUvIReuMHCxDyhi4j6/TWNAwxGDU+wBPkwh7OHK6AqKF/w6lyMnOVYz7vVwPvourbJXMlDN3Kb69WVGMR3/PNfWF1PP+aT9Htxf7rbYBJK4612rLVBq3PFNBlr4s43JzeONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192158; c=relaxed/simple;
	bh=XXEWb42qJiWZo4Du0CRE6Yam0gPdSTS3/b8BYir1sbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KznZ+MzYfQ/qqF/Qei5QNmmZ9jI7yfeXAi6h9S50cTtT8q8FSiT/n9wb64VzlJ6JGWpN5F/nByHTT/rtxQtRXlojsUs5b9LCg6YVVf8qC7csZtr9QO9QEJWokeRsBiHxlWCvToIJMuy6cOMJIjWCg881v7385TM92vILmZpQaNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F92Yl7dy; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6188b656f21so1398934a12.1;
        Thu, 14 Aug 2025 10:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755192154; x=1755796954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SewnEnAKmtNzuvxDsbzRVoc3jMFrgs3azT7RAG1IenM=;
        b=F92Yl7dymbaj8gWEdZaX3BNLqyNRIbDm+g4dThzP1bithr8wedwv8QXtBaXuctyUQf
         FN9d0NBWUdZe0orSvh3U99KdsHgEfEqhs/znbBgI6YbAp5aO23b1U5DPJeRY4kGCw7nc
         3xdEDO/IDMX5eWkzVt33LX7m4drEvxQ2FZVGiJJH7s+bYrJG0/sWq/v4nHRzRMRXkREt
         3pjWhrckPkk5WwMlgR2g6YTPyW0mNMY3EArqrlx02Oq53rgKACXKL5uL0ufzptoh4pdQ
         Oo1r7aolgWQd/Rde7d3Sg13Q47YdU9ktSDGNk7o2qHH9LcH0LxXIJJwdhbx4uTAhh3oJ
         0ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755192154; x=1755796954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SewnEnAKmtNzuvxDsbzRVoc3jMFrgs3azT7RAG1IenM=;
        b=Q/aG+XJhD6xVoBAsZFOQRcDnSR/lKR5B8fprZcmWJAC3LzTnROGZnfmg++/hiG3XJE
         P3h2kqgZwnm28vGdg/TbGkUvQUFzY5Naj6s7iiLwuH1GkBVPlpdr/Ic8MBboWeSnKNUk
         Zozl5CdJKR+2dHf0MuOzQLmwtIk0XLdg/hlBzsyVO+q9lx0jooBtx4VX9ZedRUip9/30
         FnYobH8SuaWVGe0wqsMuTG+oHakcjMcA+sr0Ilf08Pt2a6pehMfMhYWUvqGiD3xHahmt
         zU82+SXPVvLMglho7Vfd2UMBihGuuw1tiAWMy3f//E3QkN84GzXi+Ex4SfPquJFJVG/S
         a0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWblU5F4I+ZjNFIowphm2oU1D5Y7+MhXr4HW/jMgK/9nzISwbCRpEPWinE8bSGmDdiJl1jiBnJQ0jNpww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxct+kIvxAVMZfBJ3h9ZGpm5llTawvN/ne/Z/SCHSXtTn4iDY84
	b9MfpqHTnn9074V0M/crPCD4Tj33K18c2ACkGvYupG58LFRKIsNsxW+Uh7ZhVewDjzM=
X-Gm-Gg: ASbGncu8TJh/LgntC8itLLmUcWr5e0rsb6+eEf6LjczkAuW2ecOgGL6u9GrmD7iyxeF
	gEKp0gK5LJSaHn7tMQytifhUtztaccgZDqqs+x+oKFW3205RdELD7e/kmaurBoMTh5boQZrg9Ba
	aM8H3l2jxO1LG4FAayDHh6+5evQQ6nkpQS+84Pym3FPZwvdUtYQIT5U2Hv6eFlhaU/JhYMuUOhu
	HQ+wKCuk3526as+3nbJ0c+kShxXoE9HTNsGdp+QAjkDjISOHpWV9FtK+wrN/EQmH84y+xAj5yjn
	OLIifikmuqTt4eA6lnP8+LMHaPdMy9h+UND2R/J/0iHL0EZzicevHP3uq2N9l+t9RyKaAECROJ/
	b6I4JJwLlrqM1qNesGy3WFDP7gzW6KdC/NkplgSx4fm19cX5gBR/zm4gAyGpnQ/k2j8aM48YoM9
	JHPfzLRg==
X-Google-Smtp-Source: AGHT+IHGRs2EtvC7VXupYG0XxPbbMwY1lLnnLmKE7vM+VVnO1hsXp+fo5RNio5E30EUW1UY+gi19jw==
X-Received: by 2002:a05:6402:1e8c:b0:618:3a61:b1c with SMTP id 4fb4d7f45d1cf-6188c0ec2f7mr3635677a12.31.1755192154253;
        Thu, 14 Aug 2025 10:22:34 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2c265sm23774115a12.26.2025.08.14.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 10:22:33 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v6 7/7] ALSA: usb-audio: Add infrastructure for TASCAM US-144MKII
Date: Thu, 14 Aug 2025 19:22:22 +0200
Message-Id: <20250814172222.9448-8-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814172222.9448-1-ramiserifpersia@gmail.com>
References: <20250814172222.9448-1-ramiserifpersia@gmail.com>
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


