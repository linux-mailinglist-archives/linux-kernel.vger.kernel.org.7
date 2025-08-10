Return-Path: <linux-kernel+bounces-761435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D277B1FA00
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 14:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52AEA3BD36D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 12:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7720D266595;
	Sun, 10 Aug 2025 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTL80EA0"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC50B2609EE;
	Sun, 10 Aug 2025 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754830214; cv=none; b=LZbBIxaLubL7LqmyPc4PBjh5DU5yfXJjvex4xTxXMB4umG6YBXFNsbySG2c5ak6qwLdgkSGhhvDvuD707fvOezDy5hIhjGP7LRGg0KYaUonEcChU2q+H8Nv17F0ZhT7mymq2DfcAdk88H0NFEWkZymZW/5jt8z/qY7di6AK1hmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754830214; c=relaxed/simple;
	bh=arZnJXmoOJKhWbWAcpS6ht/gajjwWaE/UIcjKXQmTDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYupEldkbHVCYPfuwIiBn2sZ4YYXbMTiRrGgooFGkuLeZ8m6iZwAFR934qNkGbAOfhU5fe+EJP/P+0L5rRZD3Ocwo3mJ70vaJa3IqVK+TCtpXxkCy777SyhG3D/0XoT8P5dFL+czlquDEpp5740r20RJdyvVlw6I4GATUbmamD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTL80EA0; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6182ea5a6c0so49698a12.0;
        Sun, 10 Aug 2025 05:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754830210; x=1755435010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vq9wTkBsLSSMh7upQxNHd8g80sSc8UjlQSBDAR3TBns=;
        b=cTL80EA0n9ywDErV6Ef9Fw37B3NWyHd0U3lQuPur2JmthyvdcSUqyJtKdvSoEbnY4D
         9RvfdDPph1rBKWyruPIIW7RLblapJsPokOvwwW8NqvhJ7tDFH3mA9r4DEPT9JZI3Xdh7
         16Bqx7hoVcboVgzGz1Lets/lxQfsQ45dzrgNuQgRZPPuBhYqeI7RnQpLDQzSVlt9S47S
         tqcUBOF+kfRW+FlTqzQnjZtjdllbcyzEP1TJjaedrphWS1kcWcFKOSx4NQNOPRKvttW6
         0+1Y78KBeBQDtQBRWta0d7R7e2WeA4PNQJFxSvlyfsjy+gy4qxkSwxop1OksCzZAD+3n
         XGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754830210; x=1755435010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vq9wTkBsLSSMh7upQxNHd8g80sSc8UjlQSBDAR3TBns=;
        b=nCZrpa2sjYNJtmOCxWFOgmiTu9Loe9ybm8ClkuqU9bvfoDWUPYIqGVIIk+zEYt65iR
         z+eklCgOH3G3VNelxBx4SvPWXgD5egyUVckCPf2gfrSKatld9taGV9hd43C22pxXK20z
         0FAF9VRxKOiU8sFJlVY7AANtcrrHYoRsWW/+IpSRPy+PidFlCZkbiLc5aSKZq64B+9C6
         Zef+6WSfZ4LmTgkM96+XtEAPXyi5IDoftqxekXdNNnOew2KKAb68JdMgZEHFHJJKol7h
         5Wa61AQlIwuIQn2eKLU3GIUUZHuRyN5cX65Q+zx2zp3V+H02ELEI4pu5M9oJAGSKPjC1
         eJvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW32j82djnKfCHt0FZpPDlIRekr365CXV2zNCllnGWQI+TEMAwGUAjzUZO8oTxBXooSouGBqg2Drb5oOgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTD/asgap3/xoHjVAwtHXV1ay66TYljkGQGnjR/KGAzSz/C0NK
	bfcu3JlX6naXTJgs15PmAkxAXhuTnkGL9Fk/O2vrbkGyeMdR6ty7mCnt76ZJy4QcL8s=
X-Gm-Gg: ASbGncsKqbIW5+ygLGd/IexB7tea9qSc9Sks0q3taaYp+hntc5KzZkrMfpCxm6sflAE
	AF4OmSH4z3ntQiDbykm+fR0SX3gHIBfeX/BjpX5iyAFyWabuXgVaqNrRBTueRALZJM+YfeWOB14
	w8a8OibAZmV3t0k9RM4YF4WgdlAvdCK3QLm6+VpJejS+ZZ7L/7nH+G5eNZBJFbcqmRMV82Y47to
	dRfF65ECnw4xOMDhtCn4Z3Rs1lLOqBtg9v896lPU0vLtSUeBm2DE/ilPwo2J+BGaWlMPWzkwDXu
	p7JiFAZT7eDibcqHPmvNMsYwp20pBTIrz9nkYZvRtArqMQECYECT6NW1jz7wpIywnjCVNurNifW
	uVkBweyboqadG28x/xFT4WOr/N2SJrxNeH39/u0qQRyy5W9+BJUyva9v2+l30k8W/4DxqkhK91R
	jQiM/zTQ==
X-Google-Smtp-Source: AGHT+IEbRSTDonATc2F8RIz7Tqy6fgw8oS0LhPw0NGSmSUtZL5LGHuIugS8Auz31g7J9wqwbpap2Og==
X-Received: by 2002:a05:6402:50ca:b0:615:49c3:f347 with SMTP id 4fb4d7f45d1cf-617e2b7037amr7835357a12.2.1754830209950;
        Sun, 10 Aug 2025 05:50:09 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffbdb4sm16636594a12.52.2025.08.10.05.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 05:50:09 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH 7/7] ALSA: usb-audio: Add infrastructure for TASCAM US-144MKII
Date: Sun, 10 Aug 2025 14:49:58 +0200
Message-Id: <20250810124958.25309-8-ramiserifpersia@gmail.com>
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
 sound/usb/usx2y/us122l.c |  7 +------
 3 files changed, 15 insertions(+), 6 deletions(-)

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
index fc033aba03a4..eca3680ad231 100644
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
diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index 2ace3ba46091..6667b50e99a8 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -686,12 +686,7 @@ static const struct usb_device_id snd_us122l_usb_id_table[] = {
 		.idVendor =	0x0644,
 		.idProduct =	USB_ID_US122MKII
 	},
-	{
-		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE,
-		.idVendor =	0x0644,
-		.idProduct =	USB_ID_US144MKII,
-		.driver_info =	US122L_FLAG_US144
-	},
+
 	{ /* terminator */ }
 };
 MODULE_DEVICE_TABLE(usb, snd_us122l_usb_id_table);
-- 
2.39.5


