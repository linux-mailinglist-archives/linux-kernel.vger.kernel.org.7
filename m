Return-Path: <linux-kernel+bounces-776280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24635B2CB48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213CF3B17E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAD834AAEA;
	Tue, 19 Aug 2025 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob8kXsqS"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB90A30F7F8;
	Tue, 19 Aug 2025 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625154; cv=none; b=DwHb7byu+UJSfxBGmXrJR2a98WKopnrE6hGstmGxmzdXGYX5DrExnt60EIPfpntyV0V3AK14liWCMU30OWzPPQn6Yt0PpU1OsgRGnPzlcUdz1WaPdz1MM9DImtsYli6CrNZpJvSSQEo/ZY00oCm4zmxgKorJdBH0PQbpuGMrIGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625154; c=relaxed/simple;
	bh=C8T7nnFfVi/R//bXZaaIRsb8AMvcerVkwQ86T42vMek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u5w/o2aYujfzg+mG6nIs1bc2alJIZKjnyGMu2OLOAKcXqXnyzkSgJ5Q6cq6gkm8Pc2WZWq0Ge9gOcArzrKJXFXH8NmmHsipS5pL1uc3ehOKyvMybe1QesjR4ZB1CvVIw84CR+Z7XgqZdapxIdsilBDT3lCEj3e6c9v+MdeR6F6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ob8kXsqS; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afca41c7d7fso21394366b.1;
        Tue, 19 Aug 2025 10:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755625151; x=1756229951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0gEeKMeiocFCY5j4zKzhYSdZVtabcvvZ6/3Qtils6Y=;
        b=Ob8kXsqSjr+H0Apcj/1wHbD7SXJL7DB/wpo3Exl6gr3yjzao8qvIznlQbaf0K4SlVF
         h4yv21w/Uxi+ZIP8VpxN1SXZkfl9wgMOVX+d689z8+noo9IUPutoucQO6mGE/OZtecAQ
         SGfvrXIw6cx4awVqele4SAXbeChTtc3SshD8H4dYDzBC1Rt9utU/KcJJTGJgcfw0rfzJ
         kIdyugsxMjO1Q/KrsAQcpvWSwKE8nWtf36a2ANzd7s4hHShYG0T2CBD5G0YNILIVkmhe
         Q+juiLsDDAn5srV+Beki9VBqAtsZjdzv8KLb0BUJ/L4WE4ugF5pvD/qAdkCoiVMu2Gmz
         GZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755625151; x=1756229951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0gEeKMeiocFCY5j4zKzhYSdZVtabcvvZ6/3Qtils6Y=;
        b=QAX1W5ppXrNsG8OUzj/fSPN8Kz8dzRg/Wm/FGghvbbqWkqSFQjaVWPBOqTUZs8j+vP
         TNx34HBH1iRPnrOrAkceO6bfmjF2MPIgGHmKXjzgMcfwVTuI2XBC8QrY7haDQEAKga+8
         JFvELemtZQE/U4CSiChXMGg29KkaEH/H5M25hs4zktxi/Bqz6RZ5R4QJ+RhtQJJllVSb
         o7clUUNQBz/svDHJCXOI+wM8wtRAgjmRCVn6k5RcBh7YRnl09ljyImD4hJFC3uRbQ9br
         8rDGWVqWceVg+JzMiD7P1T8nn0Id+go2ApPZWeKLwgqOcnOYKr1LgAstK5NQfpVFoQh4
         LNuA==
X-Forwarded-Encrypted: i=1; AJvYcCUpPwDc4YPJP3sebAE1Tz4n9I+vEAczEFdaNWrJHtkRW/7EAodnTAg0jRvdElOjmACliCli5GcRR9kiFCQ=@vger.kernel.org, AJvYcCXe2ypWTf9xULbnnyHNzhZe5h6rXhpmRs/J4QmmmSzWMR1IwZrTmIIpicxl0izeC1onvpqDAnsMZLvBRjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeRsqRkIuR6cZj6yYrvJ6C/ytlI17dT2zdGvJQZyEsz4vhsuiu
	U8Yno96pn088Hc0VJ0bEW3VKQyKPD+GA2xWbQk0JL7yLOu5UnqVPPZ3E
X-Gm-Gg: ASbGncuhrR9bOgfyOreK6CxCV28rGwp4QiGZwMkEVq98RcuIpaAlb3pdy4c2dC6LhRI
	V4xt3v6xRTJdTumzvmLQnIG3pmIBWsAgDu911SzbI37URfdexKezFV0uRlt6qhfVLFapbdXHj6V
	1t1nOAuiW9ff4doFym6DV8sCbtL6CYa+v1DdqB1V9yPOGT35fUYaYXEWhLmPt+Gl/2dyx3e943K
	vFK7Y3O3y+SwSu3PrYvDWcWRNVh257mKHDoXUu/Pgofj348kv/0QQ2gyJzeevXjfxd+N1BEV43S
	b+ZmCIjSNZDLaX6+TXld7RcwLnvHEJFpOesyaJPyB2d+tN7Bi7MMzvrDMiGzXfuxS/KRVNMSZ5g
	q3RxMpL0OpAd8s7ZmThyMnQJE93b9f6Fj2YJ59u9iGMOA+NJ6N4FMn5s7EN0o4fh8D3pumuJm
X-Google-Smtp-Source: AGHT+IHb1rd3q617BOaoayVdRbhoDW0n7rRMKkxNycOIB3uwNq59L6y5svDY8v/qu9qraRdEpD+4FQ==
X-Received: by 2002:a17:907:3c89:b0:afc:d246:8425 with SMTP id a640c23a62f3a-afdee4aad91mr18959466b.19.1755625150700;
        Tue, 19 Aug 2025 10:39:10 -0700 (PDT)
Received: from cachyos-x8664 (93-87-121-239.dynamic.isp.telekom.rs. [93.87.121.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded52ea4asm19026566b.101.2025.08.19.10.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 10:39:10 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>,
	linux-sound@vger.kernel.org (open list:SOUND),
	linux-kernel@vger.kernel.org (open list)
Cc: kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] ALSA: usb-audio: us144mkii: Fix null-deref in tascam_midi_in_urb_complete()
Date: Tue, 19 Aug 2025 19:38:30 +0200
Message-ID: <20250819173831.30818-1-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The smatch tool reported a potential null pointer dereference in
tascam_midi_in_urb_complete(). The 'tascam' variable, derived from
'urb->context', was checked for nullity in one place, but dereferenced
without a check in several other places.

This patch fixes the issue by adding a null check at the beginning of
the function. If 'tascam' is null, the function now safely exits.
This prevents any potential crashes from null pointer dereferences.

It also fixes a latent bug where 'usb_put_urb()' could
be called twice for the same URB on submission failure, which would
lead to a use-after-free error.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202508192109.lcMrINK1-lkp@intel.com/
Signed-off-by: Šerif Rami <ramiserifpersia@gmail.com>
---
 sound/usb/usx2y/us144mkii_midi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/us144mkii_midi.c b/sound/usb/usx2y/us144mkii_midi.c
index 5759f6010..1aca38f38 100644
--- a/sound/usb/usx2y/us144mkii_midi.c
+++ b/sound/usb/usx2y/us144mkii_midi.c
@@ -41,6 +41,9 @@ void tascam_midi_in_urb_complete(struct urb *urb)
 	struct tascam_card *tascam = urb->context;
 	int ret;
 
+	if (!tascam)
+		goto out;
+
 	if (urb->status) {
 		if (urb->status != -ENOENT && urb->status != -ECONNRESET &&
 		    urb->status != -ESHUTDOWN && urb->status != -EPROTO) {
@@ -51,7 +54,7 @@ void tascam_midi_in_urb_complete(struct urb *urb)
 		goto out;
 	}
 
-	if (tascam && atomic_read(&tascam->midi_in_active) &&
+	if (atomic_read(&tascam->midi_in_active) &&
 	    urb->actual_length > 0) {
 		kfifo_in_spinlocked(&tascam->midi_in_fifo, urb->transfer_buffer,
 				    urb->actual_length, &tascam->midi_in_lock);
@@ -66,11 +69,14 @@ void tascam_midi_in_urb_complete(struct urb *urb)
 			"Failed to resubmit MIDI IN URB: error %d\n", ret);
 		usb_unanchor_urb(urb);
 		usb_put_urb(urb);
+		goto out;
 	}
+
 out:
 	usb_put_urb(urb);
 }
 
+
 /**
  * tascam_midi_in_open() - Opens the MIDI input substream.
  * @substream: The ALSA rawmidi substream to open.
-- 
2.50.1


