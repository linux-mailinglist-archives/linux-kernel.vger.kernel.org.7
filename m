Return-Path: <linux-kernel+bounces-764826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D0CB227B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64361501994
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744F7265CD8;
	Tue, 12 Aug 2025 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz2BYieu"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7DD260578;
	Tue, 12 Aug 2025 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003409; cv=none; b=ikeg4MyhIIU3jFVfpbudbzJHim0k5/zPpK7N0AI8qmzPaOISR/m+9jBXziwARmxIumnFIFfI+Osy/FEDImEDWn6irF2giuFOz8b/Q1H+71cgnRx7IULTx7rcK/pcQUKYkplf/Jqaioac/xsBJjyBtv4RL2Yp55MZXBQ8f1qyJ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003409; c=relaxed/simple;
	bh=zYImU4jxvzbeYDCcwW8grQtTwXDcIZSor5qvW0OKkxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBe40FhctbtpJySzGngNCY9mZ1nkfMet3HrBPGfRGVlcWIyjj6QCpTJj88vX54catj+jk02hhXwSCMAgTh2ZCh4Mg+KM9EP1J1ErXebHh80pnhjFEcj+/C3ucdXKiDMJKjcINl1dUnd74QiX/eCMY3vjBj3/jAqs4MC3N6xsQKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lz2BYieu; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-617b36cc489so10672547a12.0;
        Tue, 12 Aug 2025 05:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755003405; x=1755608205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bhnbn+hKgeh6Jp1ra5XQn6HuC0UPdIm1P7jBz/93Tj0=;
        b=lz2BYieuGkAiWRb3aZ9zG4FOGr7B6BeiEPrDpRT6SpxOOnwUaxSE04Dr/kcQqdROBy
         yea+TdNYRkIvHFGIhd1PIubi0wf514uuLQ3u5jiHzcxtlsq3lmrpA9M776Z8An7pZNP5
         To33zAggCueJinibAL+YnzTWyGGQgRGvBspHE5kLNTiOVX9DI5dJ5Pp2VXYq4B0r4l70
         QUBZUp1UgAH3PfrORUIRUDJmXhVDKf0U0nWE3N0dzarXG8e8Pi2jGdKrDoauZvheZxbT
         +jJassJGKQEAaKLbPHs+9Q7vu3JVBDbfpYufQPC6xR7qtD+k5+6fGWXEtNK4JhKKd4HN
         rZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003405; x=1755608205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bhnbn+hKgeh6Jp1ra5XQn6HuC0UPdIm1P7jBz/93Tj0=;
        b=hGb65BI9FnJNIte1H0OJeJFsZo4BwlEvIUo6q4aGOeGXUfszXNssOetDFaha+73FUu
         UW3VSZpbn8GSirzGJacvF+3Jked9/KL5ahuYwUg/8kk/qXpiQfIvBeKV5Jd9XengwQZ5
         srd1/nCVwTO6foImZg53reNOli+9zhLmXoIKraLNywUYPNMkbtJ9NXl9U8DCTT6mvFQS
         gJK2oM6nOGJHJHbjSuFHf7Eug1UcJLrJN+et6UbrRF9MJ8EfGznOERv9EVoxA77pUEgd
         nl5Y90QWfFh+AeiQJBQJP4o6sx5Z+bcpfZBba+6HSZq2VM8sjlHdvIu7vXug4HhsiM+7
         rpUw==
X-Forwarded-Encrypted: i=1; AJvYcCUY6a2GtZJiL+7sCsXbRRve76NlxCcEZtZZ8RVPDSj7DnIJjAfS+Hv7AKEuiRdpRQ7EePRjhZKhTgW66g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpo5tZnc/038xI9D2pBlttgQMRd0TTJ6irxEmnJ1FAQUMShtfa
	/9Pv+JXpMePiDbv+kYNhFsmaI+yl/XmWSCW2iJstyvlxJljjLGe5Ioz8
X-Gm-Gg: ASbGncuJl2uJy+Mk5VFtUdB6mLAdGcXC0BYXPNJonQ7ZlpU8CeW0t1uvRQtbe4TSAWs
	XCfhHtiBqiiFTK9QWtTz7vSv31BFiO4QJHVbDcM2bioahNkr4B+RmvMe5mzzqHls326aIhOw2ao
	ukoIakRSC1Sm1R9OAIfxuPP/JCcwS+DZgM6v+oKxk7PixcXwbzNtoEhdLBy84qBMFuNExkrk2XH
	/tSBndl0WjxXJfgmh1Vf7AAM40JUl4MZoPq4mEUE3ba6qbhREXEkNnlcn/vkfYE/vjR8YrYhIuo
	5YQC6gQhaUGL57xsW9DWwG+7WXpPbpv6tX6aFxTgFOxPZmYGR9vN2evHrZacBpcmo972xPEURdM
	RscMx2ZqDJD9tknxOY8Hni5Sc3SDi29eMFA6dANFzXZDFaDGTDTy50u09dRl3Ad0Qdy4kIa/Kjv
	m1Lg89Jw==
X-Google-Smtp-Source: AGHT+IFEbzeg47RnZlLER74FWNsQLSf6qWS2thYftTTm+R8uXIUhrDrcY1Qb7lgGzi1WrQiGU1SO2g==
X-Received: by 2002:a17:907:9287:b0:ae3:d5f2:393a with SMTP id a640c23a62f3a-afa1e1e82ebmr301526666b.44.1755003405457;
        Tue, 12 Aug 2025 05:56:45 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3361sm2199158266b.39.2025.08.12.05.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:56:44 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v2 5/6] ALSA: usb-audio: us144mkii: Add deep sleep command
Date: Tue, 12 Aug 2025 14:56:29 +0200
Message-Id: <20250812125633.79270-10-ramiserifpersia@gmail.com>
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

Add a deep sleep vendor command to be sent during suspend, allowing the
device to enter a lower power state.

Signed-off-by: Šerif Rami <ramiserifpersia@gmail.com>
---
 sound/usb/usx2y/us144mkii.c | 7 +++++++
 sound/usb/usx2y/us144mkii.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/sound/usb/usx2y/us144mkii.c b/sound/usb/usx2y/us144mkii.c
index f7944eb2fb93..e452250fc5b4 100644
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
 
diff --git a/sound/usb/usx2y/us144mkii.h b/sound/usb/usx2y/us144mkii.h
index c740a0b5a0ea..ecc4c2fed9e6 100644
--- a/sound/usb/usx2y/us144mkii.h
+++ b/sound/usb/usx2y/us144mkii.h
@@ -46,6 +46,7 @@ enum uac_control_selector {
 
 enum tascam_vendor_request {
 	VENDOR_REQ_REGISTER_WRITE = 0x41,
+	VENDOR_REQ_DEEP_SLEEP = 0x44,
 	VENDOR_REQ_MODE_CONTROL = 0x49,
 };
 
-- 
2.39.5


