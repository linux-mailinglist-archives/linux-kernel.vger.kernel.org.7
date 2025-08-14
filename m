Return-Path: <linux-kernel+bounces-769371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9647CB26D88
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E285E55D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E2C3019C0;
	Thu, 14 Aug 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHlgfoFr"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9E52FD1B5;
	Thu, 14 Aug 2025 17:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192156; cv=none; b=bHw+vGRbEC5Uzih/n/ZSzFHuOeIgPgg/laoIXoNSGyQ71f61FSEFOUQqA+4rZhDshayhpVbwORQdBfss0OoeHfYD5GQOK7V1RPhHbnrXx/xuGa3/nAdPxxYBVDyqkcYv4PNXAfhgJFuOyweb+9wKKSUXJQK8YfYezJcSE+61mAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192156; c=relaxed/simple;
	bh=7+ZMLHHSleO75755IiS7qQZzO5m/6l8SyfFmuy7PTw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3RBTrrEMe4mqZMLuZJcD8XRtpcplYlXEipwY5Mv+7Nd1XJtMw+8z/0cVtYoCxhP9YuvTfOUFHTPB1E83wAAMQsix2/0BLxRRmS6fnHTTBtSiXZkOih5aiWK51zvoOoW+KSM1sQP4yDKv6oTlANRBZxVlDWTh2dzS2xp/9UKEgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHlgfoFr; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-618896b3ff9so2518166a12.1;
        Thu, 14 Aug 2025 10:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755192153; x=1755796953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPEQ9+fX39Pb16FrUTWzG6EMhVmwiQrVi7huAGQElb4=;
        b=kHlgfoFrHUq343hsMb7+AlXDlWhfCxG/vj3SsPEXCGk36AC71Us4BzncWFk3urUECS
         T27hp44ZN6Xm6vL5yV3+wMzOCAAH+DGLvoA+3gaCaLFFq45HZEdfgcdVd8S7OWkdhhOQ
         +gCqW1pT5P6+QeAXwy+3cW9X99CkH8GICqFA3zxFo3uKDSny/uKNTMWEQJfbVQMHZtJl
         RvXb9u0P6UoLZ4jK1wtS0yxHYE7ZNzMHZM0cd8EJAvzLdHQHzJIUHnnsFYVnY8kuUhVd
         mriag3ZnR1N39ilG++JARKYILeczl9Ui93tqIZv9C0C0HRcAH85y0OvlWN9pL+1ZEMkZ
         dD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755192153; x=1755796953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPEQ9+fX39Pb16FrUTWzG6EMhVmwiQrVi7huAGQElb4=;
        b=Mmw4spUjG99ExzD/cCG7GhQk+icEVxsN6uB1S5lQV6wgOIeU9r6oIT+Zi/gBoNzqFc
         HDUWNha31vJy+4bNURXVrVrn4mT37kBHaO88hYEt6T7q2I5jCxl3pg7fNteSzEr56ieQ
         znr62sgPxIEh2l5M3683zQBJZyhl+mDZBOW44YBzkAp1oofUzsALNUiTXc5TsgbAH6dl
         W09RM3bk7YY3vkqpvljDgUqh8I1NGePvuGa3QCuvG4gpa94+hVsjk9YURJn0WkpW/wqE
         lu94OVTxp5OiVBWRQyzlcjXYJWGshWJUYEafcHfxUNOjXfSlFM1P4vzQFQ+ddDr1RL2E
         GiHg==
X-Forwarded-Encrypted: i=1; AJvYcCVGt6N1NSG0LL6JmcmjKfMT2SkUeqIu+zMgz6Vp+rbzj0yiBcyTiGHlbhaE0BZD0v3zG0rbr+zok5KOrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxqoQymd6d3btvuw92UayTxDwE50moxMj+naURHVo2JnvYLs72
	xdufuMkHCs8+qOE+ZXTH/2CXTl2lVn00t9t9KYwi/eT0y8JV9cSpqaKG
X-Gm-Gg: ASbGnctYAn+Rt9WXb9syWUpPbOXDz/jhaoD9h1fP5Yw4R6UOeiiREJmsHZPvCneLuXK
	vVNGeLzQhphCFWMk8Wz2DLoCi/iDaobyoKQ8jvxXHrs3vvrOHCvpnypbjDl1uPPwf2bDBuR0po/
	MTmbAOXLsTL134p1EsExYvQ7oY7rY7x89KTBnPvACzhmQlNVqcRt8peywU18KTgdsM040Ij/vam
	grzv1y48Oh12gi342Sc/X7zOz9FhQew0UifSX/bZkKi6i4SNklzgWORnCTISavie7DZsjkU6O5N
	zWlQCWaDGgMxD4102ql+eljBZuRVEJMl72hxSLdbSbDYM/4nABG4/NejmqU5b6yjBYviRtIr09K
	YmY4Kxgp6YhG2wtB9pXfyEPUTbXDi3H/R6nW+Nsy0Rb/1y7gYDa+glBm/v1GnZoA3Z3CU4CprZY
	TQboFkxg==
X-Google-Smtp-Source: AGHT+IErrGwt6Ih4JQ64rsTo51VoZ0QgtXyquWb6VPM0cDJao7Su/mOFgSt+3u9wXL/ovbRTxy2Lhg==
X-Received: by 2002:a05:6402:3250:b0:615:9247:e2fa with SMTP id 4fb4d7f45d1cf-618919bdfe3mr2648105a12.8.1755192153185;
        Thu, 14 Aug 2025 10:22:33 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2c265sm23774115a12.26.2025.08.14.10.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 10:22:32 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v6 6/7] ALSA: usb-audio: us144mkii: Add deep sleep command
Date: Thu, 14 Aug 2025 19:22:21 +0200
Message-Id: <20250814172222.9448-7-ramiserifpersia@gmail.com>
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

Add a deep sleep vendor command to be sent during suspend, allowing the
device to enter a lower power state.

Signed-off-by: Šerif Rami <ramiserifpersia@gmail.com>
---
 sound/usb/usx2y/us144mkii.c | 7 +++++++
 sound/usb/usx2y/us144mkii.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/sound/usb/usx2y/us144mkii.c b/sound/usb/usx2y/us144mkii.c
index 55d6e002a310..da53c1908c4a 100644
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


