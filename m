Return-Path: <linux-kernel+bounces-764829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5844FB227B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF893B114D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14DA27FD49;
	Tue, 12 Aug 2025 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYzUdJ2G"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B349527E052;
	Tue, 12 Aug 2025 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003411; cv=none; b=AQ2XyLKwqbFGAd4RbY5nQabXslBJn3gsPa1wJgif0EAkToxQF7k5cmzSytBGLt6ey0NBAU8VEyHWOS1CugqjfqD/SVS8lW8qSAh3TBYFnya5saiyqGhKejkfmnRj/9fJaqlXn6rFUuuHoyxTJiTP5T12S1JzQgLpQnWvA7VETcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003411; c=relaxed/simple;
	bh=XXEWb42qJiWZo4Du0CRE6Yam0gPdSTS3/b8BYir1sbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngktJ8UyDIpoPnxV5eSTOEdDPhu3SttBWehOE6t1gbjeJ5O1nCFAinuR/N6QHaLplo9bDlmUq3pIRZOBjrEzSLmr+jE4xbx+2fHAibeU4sKWqorcpTx7L3Ktv5w3v80qqHt5I345B5GNVS/KOFE9wdJCNhe52J617RnBXuARl4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYzUdJ2G; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so1028774066b.3;
        Tue, 12 Aug 2025 05:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755003408; x=1755608208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SewnEnAKmtNzuvxDsbzRVoc3jMFrgs3azT7RAG1IenM=;
        b=XYzUdJ2GB0V1Mx6PtxehS9OPqFkU2fzRMb5K5W7lKJeKxB8PdYQJv4kkDue8lPvpGY
         4TlFwyu6fPFekJpYdO4XygFUny4FH1px8eFnA9LPXQKNAraxzTVCn0v0eebzd7I0LOUp
         NHwTts6hFEOgkRQobPazpS4J2tNTpbu2+83rAJ4w1KDzKP9moN4TXmKVSsivc1kPWc1E
         doRRxEvPaK4tOWyxbG0FJWrWwPSQkcRO4OfaQjRhT60w4YWFrXL1qKjFJVWDVNUjJR79
         79dkR1KXltMjOTXIqjOj1ij3I4LFraiYJgoE39jU2MZvZmk5llai8a6P8slNjIA76Fu5
         hyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003408; x=1755608208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SewnEnAKmtNzuvxDsbzRVoc3jMFrgs3azT7RAG1IenM=;
        b=afK1G9sG839FQWTJZFzJ5bFaBKJhW7yHFW7EBH7Cl4ERNz9/5D/h2WPIfIK0iTuWDe
         4+mNmYGwXpW15AOlRCDjd9awLH2vZiIxR2CeqLJ00CbvaAvO7E3NbTkjslpilYwAl+ui
         HEdAL6ZbUhFwS4bk+MIvVwgKexCuggPcHMtkndbGj2G5Ds+z+qLjV2JiCk7EhtluWxs7
         JTi8BhokmmxkdFerKnkPSfJQglxnY1td3YfEI5u7EJaxJR52byXjzwGmGf6VOf/SXB3Z
         md1rWn6dOzA0kw0uSnKGbunfxr/0ta9OfTG7DldRprBypW/neESauyJqLJij5EJ6v5BV
         9Feg==
X-Forwarded-Encrypted: i=1; AJvYcCWDUOw9JIXOmPnfGDHvab0V6b8qYxBF4tI108YJYH/EhvOvd2nnR+gLXFScctc4B3ftykLTl2uacmCE9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQRpephtA5rO8xlYtfSFU1MH9ITukz4uZVk5lSytY8Hi0IZcpM
	p9EQWF74yWgd33bNJRrsyJDusP03er7JRPVCVphYXujFQv/ThsC25JrgFja8S12JFLk=
X-Gm-Gg: ASbGncsTkgUbsURuq+854K5tnF6lIJH1gJd4AwDMH3ju0t916qIp82tozSu+fDLn+oR
	xmNYiFQzTm325oBHjL76/8tr+RElIh4A3zZDxWjn4zwuNbp0+xgxj0eOL70NWXNDI2vqC9I8WL4
	1vfQgyZ/o2/CHxB6wEs+amqaDVeIlKmwL9N9HdNz81YJRr1WaaNQqaxl5021IoEjac7i3c6IUDg
	Dkd6mMjdnXFUg3YyctijIo6kLuE9qzsISaUaZWBnBoqutW9pGPrq/m0BWtlddFQyv69M7m4VxAZ
	aF5SlU+tMvDKMny5prlhT7JxuuqrAWA9KFqcrcO0KmZVlNs3hpcMwv1ofhuiVU/9nxbxdJ5h+fE
	+FIBnaaYSZh1rBd3LuRJDsCNl+sG8wHDuK9VHNIidnjCFqKI4l2X4b1PYX8qAKYdpd5y44MMVVx
	5uqMFZ6A==
X-Google-Smtp-Source: AGHT+IGFUwzn9SgWCoSQwab1IZjr+bv7V/GhxUzzQI+mWECUjzjGRevi0nAm8U1fnF7mcrUrwIMjtw==
X-Received: by 2002:a17:906:794a:b0:af9:d6c1:155a with SMTP id a640c23a62f3a-afa1e128db6mr303424366b.44.1755003407660;
        Tue, 12 Aug 2025 05:56:47 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3361sm2199158266b.39.2025.08.12.05.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:56:47 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v2 6/6] ALSA: usb-audio: Add infrastructure for TASCAM US-144MKII
Date: Tue, 12 Aug 2025 14:56:31 +0200
Message-Id: <20250812125633.79270-12-ramiserifpersia@gmail.com>
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


