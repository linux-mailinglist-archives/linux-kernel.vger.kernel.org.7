Return-Path: <linux-kernel+bounces-764830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A60A7B227B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F684560649
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85203280329;
	Tue, 12 Aug 2025 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIN/drrG"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A736A27F170;
	Tue, 12 Aug 2025 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003412; cv=none; b=d0EpC5swR+eKvtvHkW6nt32Yq2CcNp09Pw2nabgMmKBbcPysNI2p777itF7slY8Eae3eCDonxzlBOVZqkdO2jri4VWmFIFwcfEO+kWvSRRqpXNETCDtBGhvkoIG9M2IM7T2a4E/KI/xS0h3elbpDPsGOTusRZ1gQPm/IP7706NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003412; c=relaxed/simple;
	bh=zYImU4jxvzbeYDCcwW8grQtTwXDcIZSor5qvW0OKkxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ef9gcOV2oi5fhytGR9ShWHFiM1hkUpE8ZdwK1U3biAVAwHK0FkggTv/r/JRUJ3VPgR5t9LYFEh0DD/GFvAByoXsT1vqud5V+hJbQhBMP32qopEKYjcv1yH8+mXsUfF3BdKzkqpHRTjc8Xd5rNJUua98cdS3sRxE7BSk0DOe+D+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIN/drrG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af90fd52147so805719066b.3;
        Tue, 12 Aug 2025 05:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755003409; x=1755608209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bhnbn+hKgeh6Jp1ra5XQn6HuC0UPdIm1P7jBz/93Tj0=;
        b=IIN/drrGsHd5hKU2s3x8m/fNWDRo1hmdGb1M74cPebvx+bnnmYVmxnSbbHJSmj2VxW
         ghvYYRsoOxy8p29Zs0IgivCeEdx45Cl3VlYXiSgCUaE7Nm0OVj+l/o0QklOlcdTGyNqH
         RaVrz29rBAYMN9BDJVGG9QlEP9nqyiZbjoioEF+Il5qQpZwpn4j22Ha2BwO+2OnV0gUK
         xhdEoFG2nxBoz62SvZpR9CHuMu7aa+4FXrpKhyCmrxwOWpzrsHHnC1p+JuTvZHhZIoYl
         M+uWi2aqRJiHulawV+Vd/zUyCR0MB8YUHTMpfWNSAwn08ZkAflMNPKc3cFxDQCyzwLhH
         Cgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755003409; x=1755608209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bhnbn+hKgeh6Jp1ra5XQn6HuC0UPdIm1P7jBz/93Tj0=;
        b=WndMbL2L3+Oui/LzLM/2I2kySTsZEup3nSnn5ZhZoLcQnJWxRI7MCncTQh58IffHhV
         34f/aHPIi31q2Nn1cvUeCKO0D3EvUamensr4YGWcI3U0YL8jNhbvMgQ3wqNBk93G8Mjm
         d3QZV4vQibTi0xse35xQJWdOR8LaU6u3j4cu74HmZmUFHq2kzC0P38x2a8pd2aHpRx0h
         K84xWmpQeKA6p3RZKwLAUndqW6pGJJey12dSgVXOZMy8FQ18YnRrB32tYDiDla9Wze9N
         NR8VgS6pnBW6FrHkMV0DZi2r8J+xkKfhG0LGW2PgLZ8wEGLURyiLNT+gIucFK4h/m7t/
         UGgw==
X-Forwarded-Encrypted: i=1; AJvYcCXdxX1RWtvIW1Xi5wvZzNvLODYdm0fl++Uld9X+bOQffE1FljrzoV4Y3DG/60z/O729yf3IpLNlGaR11w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEzDPMxS5aceiYMGfLrD8SoCMNVJzjl5YYbJ0jPENCFzy7nQBm
	qsYvr51Cj7kIlN/abmL595NFmVfxZ4qjBTJMlIL6E1CTM+dQodQWXtWkbDzosTxOAK4=
X-Gm-Gg: ASbGncv5L4iXcdW3+9v50Of7j2efv4B0X90xnvO84HrQRvLDPk4JwPhunC26nSsrxQ7
	mF8SMh8WpMGg6+chTeVf+V6KMrMqoVXUlrA+z03QclPqNcqMgZ9lrdhmlKuH2pzsbq3YxpKfB8A
	aDssR40lGh7ksUeJ6jy+GeACpg4Jllm8VcuwfuQe5b7jwVj93tqajme828z5PSGG6pBkyJpQKM/
	ZlDLElSjnKdKZHYnD1A24M7RKArIyerEK6ogmItRs1mAMWOdHCMlVdHX+R22viwFXJxW0wa8pEt
	kpIJ3FQMcONhKAC2H4yq3hcLlmq61NT1iWXOpbrpjU7RhYJXsFH/yiTQ5Hcj/qvRAjfSaV1fE7U
	UbHNGnMLk/uY7hW0rBoANanlicD4n7u+HsTrb7CHZBVjZhINjQydUYoOFSzaNc3NFF34cNW0lTQ
	aWDin9pQ==
X-Google-Smtp-Source: AGHT+IE4hB7CzeSMV3N0nGmhP4M7UVj+96HqC8KgrLHNgURg/MyFI0YKtInajyFewoYW3Ji34tn1Aw==
X-Received: by 2002:a17:907:3ea4:b0:af9:c1fa:92af with SMTP id a640c23a62f3a-af9c6375c9fmr1563320866b.6.1755003408679;
        Tue, 12 Aug 2025 05:56:48 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3361sm2199158266b.39.2025.08.12.05.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:56:48 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v2 6/7] ALSA: usb-audio: us144mkii: Add deep sleep command
Date: Tue, 12 Aug 2025 14:56:32 +0200
Message-Id: <20250812125633.79270-13-ramiserifpersia@gmail.com>
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


