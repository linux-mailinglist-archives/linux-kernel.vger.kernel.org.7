Return-Path: <linux-kernel+bounces-768580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F41F8B262C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4FC1C8159C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0933F3019B7;
	Thu, 14 Aug 2025 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na8nrwX8"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2EE3019B0;
	Thu, 14 Aug 2025 10:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167147; cv=none; b=j2e5s7YYeJRNPn39VrblPHbdG4QxKfmqjJo4jQ+h7L/QWtAoIBqKS658WhgvBnD2asVvCRnwg5ceCMc4uCptb2u0exzBMz54ffuDYGygRFL8gOCnlExu30mGfDqHg7HumVDsFSUIwhU7/wLOZE06WiT0emE04DW6WqcW368EP44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167147; c=relaxed/simple;
	bh=zYImU4jxvzbeYDCcwW8grQtTwXDcIZSor5qvW0OKkxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nb7beBIyj6Xt8/bxTnxXfGy6GpcxGACZc9BROVUNdglmp/PaDKqOJWqcE4YRJNnIx7ZON/Gtxu+ptoYkRcyn9QkicDPZT1rTwJnw9Zxrcu/TL8BeGlC/gRxRW5pVHM5/L7lLLJK2Vs8TMi1zbhkeAgfAMnEsB9tiY/fXOUiK8Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Na8nrwX8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6188b73e6ddso1564053a12.3;
        Thu, 14 Aug 2025 03:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755167143; x=1755771943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bhnbn+hKgeh6Jp1ra5XQn6HuC0UPdIm1P7jBz/93Tj0=;
        b=Na8nrwX8tj/fHjGYy+R2wCStmaZZ0cOAMxMIXPYFFAk53rxid+8o1B/rZY90zRtOK2
         Pl9Vw/3pBiLtcGk+SSMGwFNqsW+QyD7aK2HIAuqTLSuIU4Te2NoFG88hSuvTBefxlZ35
         QZ1fMkI89Hqk1Et6LBWEvGxld2HFDiFFPp1SXP1CROYzsBt6envmqgm3OvgtiP67F7Af
         hAhOKOp/iUUnwe7g8X6pgkfqHaL738geEObQr8GM/AzqbRXfU9ua6Q/dIUrMd80O0aHY
         bfEJP9IIs8P5cHKMSUV3D5fXgGb1ze3wMhZMmoeg3bJblzrPiuSEm/hBXE8k3KEhuVFo
         6Gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755167143; x=1755771943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bhnbn+hKgeh6Jp1ra5XQn6HuC0UPdIm1P7jBz/93Tj0=;
        b=a90fL7G40nqTZCfKuq6dKqJC3isauqLm677x/Uy/MsewQPWUkN9QmCBDMtfkUphGSD
         X5Tcj8VaKUG4tKGNPxyhxr7iMKYuxqtrel05YZ7FB2fCQaUpac76XTRdjtUUwCAlXb9J
         +RYIvzyd1p+TdccxRHSUBGyBJvGrsfeZ4w9AxnoEDXg8bcvsGL9UmA14CynO8l2hP2+w
         bSR37V3Q5xwqNGbBmVKkyhkKMOhV/XSFnPVzGLVhxxdFnQmGKee12A3o8xNb97vL6W6E
         9/2ssV5f0ILyjbXizrHotKZvMKK3SQcpPww9CbtlUOu9QFSZ2+1tuge6ZwGCoUb/fpqz
         4PwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO15/2RGB8A32ltCSFPNrZs08xrCpKhvFcxPTmz2zOnUQqdDHKFfiUu5aUoirGG2UbC4CwejKr3RkQTA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt6KGH/xHS/5fTkpw/8sLxoZ46D0gzb6KogSulB80XIakQzhAg
	4OEvxdftIjE2SyICSTs4KJ7FACzdSCu6o8kYJTUhxtXLYH/gqAX7vd/m
X-Gm-Gg: ASbGncuhy56mJ9ovuytWXKpLkeCWsFt0jrUddpSzXWQvJbGpINIXDYvN2smVrEdinv4
	0B/nOPn6/pJ21zYU32P7xv4fhev6DhNw6ctX20x89mGWU9YGKHoDbxaNQ/OoRKCeXEHYYBKnaYK
	ZUOx+RFgMqk8+BkayLN+E9Bfjn46wkKFa6lv8i+7ss+wy0WqG7NB9jNv+E9++t1aULv8tsrdMfh
	k3Nn/7PTa+XQ3xQW71vFM7Gu8Uhrh/TnU7LYPO65kg8jLPwcVw8nPZzOer+6FFyoFo9GitKQF6a
	TmwoBrMnjA95rj+Gutp9t8QManvxTlH7bq1uPwSuSvRKOwwuEfuvyuKgEVLHYpPiU6iCUJCz4Ih
	wcu2evTOq51E8XrYjgL/0dHSHOloW/RkHg56yZiBiYsvxmwMwBY5zi3vZrXo1Fa3nujG8YvKlWa
	C2jfrfog==
X-Google-Smtp-Source: AGHT+IFcGgxId88aljBNRQKF6svIaoLBnEDf56ipxTP08mxMnlXdWuj2y+klCB306Z1a7RWZCCS+xQ==
X-Received: by 2002:a17:907:7208:b0:ae9:ca8f:9642 with SMTP id a640c23a62f3a-afcb979b5b1mr247786466b.15.1755167143380;
        Thu, 14 Aug 2025 03:25:43 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-223.dynamic.isp.telekom.rs. [93.87.121.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a219ef2sm2564819466b.96.2025.08.14.03.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:25:43 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH v5 6/7] ALSA: usb-audio: us144mkii: Add deep sleep command
Date: Thu, 14 Aug 2025 12:25:33 +0200
Message-Id: <20250814102534.34439-7-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814102534.34439-1-ramiserifpersia@gmail.com>
References: <20250814102534.34439-1-ramiserifpersia@gmail.com>
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


