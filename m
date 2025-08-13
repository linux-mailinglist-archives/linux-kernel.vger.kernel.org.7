Return-Path: <linux-kernel+bounces-766727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 199A9B24A67
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 066C27B944C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D052E9EA1;
	Wed, 13 Aug 2025 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imyT2u83"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492FF1E51D;
	Wed, 13 Aug 2025 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090994; cv=none; b=nOeTtHhVpXx8INrE9xX9Et4ihCBiDFsbRiXGnRbCZ9Zqft1C6aBjwSQJ7kAVjMvqHKVt4OZ6opX7l3xaL1+Deaagb/h1eQ/dnLh+mQjcNV8EzI0Xf32/Fd4f0rtbXeraJ8gF2YJt4O6pK+29l7xP6VPhQc55KaMioXphKmuCBPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090994; c=relaxed/simple;
	bh=zYImU4jxvzbeYDCcwW8grQtTwXDcIZSor5qvW0OKkxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaG/8yyKZ0Gk3K9C9kS14neM6PtHZSEEx0oGO8YjUqPpzd8cMr48twsAYjSWhUzJdJhYnNt27irILTnU8ho4cWZq7gnRgDVzy16hwKwJNxY613vIyxh4Ifiqhly5rERI8TAztidTQ19fH3Mdfm6wFGQ5dTL9IybtKXgvkcHIWAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imyT2u83; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-615756b1e99so8808178a12.0;
        Wed, 13 Aug 2025 06:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755090990; x=1755695790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bhnbn+hKgeh6Jp1ra5XQn6HuC0UPdIm1P7jBz/93Tj0=;
        b=imyT2u83JkUo0B6XDskNziSG5PuoK31SsDj17bn4KzZlHFI9lPfAFRlAW7ZU5Z5jpN
         OtU/mJvQHq7FvVue+DPSbjw3mpLjPWqxQc+ZtXWMJ1STeq6q+Lgser5sv1tnC+AwH7On
         iixGY4t+oB3lUuPXz/8yEM47X4+S8bLARJpN+wTCUKF1URk09SDrYpL03tIiKjAzTcCE
         my7/QgiOE+Cra5axSFs79dYAAuPG+fSGnybHbIS+3hTCM9Gd9QrwYXLaQgbnJz24Unrp
         j/89r3Dw+7totfgkGDrfe2gvOt3OjLJMBVVlDCbxAVhPtDmGHwWyKxwZPPlQ0Yi4YqiD
         zxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090990; x=1755695790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bhnbn+hKgeh6Jp1ra5XQn6HuC0UPdIm1P7jBz/93Tj0=;
        b=Na3FuVF/l3yDECFZe+Iv6bSo+4B1V3bivFaKNv/Hj/PYfIFpJds5HLIbnnwJIPltFY
         fdo4qdCQQqmiwlOEOBUtqF3Sl7r6DYQQuJhLi80cN9VcVIsIj5kz1Rm4paryB4uTEO1z
         u5tuORCxj7vn2cmXog6SdvU6ni3qBxMEriRikpHGEbScdio5jldExMj8z4GD1ALSHpI/
         p2vgRCmVhyqKUDstSTlj++eu++EJPKRLTGPDsdwJGOXOWOmVrQBwkLZX6D8XtzozqAya
         AlgXqOP1ACDQK915uLQi2JMZgCOjCsG1PRu2Kxu63YDNjm+fbdAzl1psmnkG1DKpdZeM
         +rXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDOFfdRupGfPotrLfpYFX0pGqcA/65hQdh1FOsapytaKe40dCDJ5036jc3bVJL4LUUN2Zrt9W+I8SGiw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ySRohdi+scVJgym/v4ggeB05qi7Ovw1dVvPzgvIXY7wS3v02
	RNBNcrMh88pyzBs4V0zPbryWBzwQPUniXpo7tIkLXUaxeJjsHxxBatH5
X-Gm-Gg: ASbGncuYRk2Vx0seW843JMnryDE1KA8vjof5ByA+CTzIEBhrmqVuX7aQTTvXOwwPBEf
	1jzw0XCl99e4m6q+uPbf+QqZ71cXjKcmtBUp2h1xPlr8+kmXx+auXduAfVCCV8TzpBxNqc+HGbb
	5yoqgYgRn+rP2zDFoTLV+TGl3EJlk1SakGjVrriORrpaXwptCiQcAGiCp/3smza9Ctwiyo5/6PF
	aFn0WLeDSNNTaR0Jl0eQlFNMnD9Zs5cNwEP+AlK7C0Xbl147qIudICyLcwJPzAZlDN+GIN7ew0E
	btqGAKv3HkkMhugyckxjEmQyBOFJwf/Fq34aYUeQAwaCEFtZ3NjaY2hAY6mDkatDKEisazbaD+U
	xRnXND+QKxS3nyUWt1lzGaHUYTYqmVrTVq4ADtp7Jwa/MoSzv5dqvpkKlD14Dcdcp+XkR/AAECp
	YnX8o2CA==
X-Google-Smtp-Source: AGHT+IGoIdL6p9jy9ix/JIgZYMzk9vduFibPr7vwT5f+APwBedGWjGu2zrz014pU4jXaaRYgPVodvQ==
X-Received: by 2002:a17:907:97c4:b0:ade:44f8:569 with SMTP id a640c23a62f3a-afca4ec18dfmr285588566b.42.1755090990410;
        Wed, 13 Aug 2025 06:16:30 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e88desm2420481266b.71.2025.08.13.06.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:16:30 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v4 6/7] ALSA: usb-audio: us144mkii: Add deep sleep command
Date: Wed, 13 Aug 2025 15:15:17 +0200
Message-Id: <20250813131518.18985-7-ramiserifpersia@gmail.com>
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


