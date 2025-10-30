Return-Path: <linux-kernel+bounces-878564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF450C21072
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0EA189FC43
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E0A3655E0;
	Thu, 30 Oct 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLalvD6H"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12C63590D2
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839115; cv=none; b=UxOf6kl3rqxkCAKZ7fxICGzZcSaUtNRsEYR5TIEjVlwLN9COB6FjulVevEKuyIKqmfcO4QP2n3OarRHsLDQLHhRmoDRa3VKwo2fZDYfXd2I7O2PHPDxS3xEOrB4hYiNMNX+Zbnj4MTG+poeK4oG53GjVs8wSQl6M0Z48cUecBXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839115; c=relaxed/simple;
	bh=8nbpw/Dbx8BV88ruGmonnUhStqv/ydJlXQBdhurH958=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eM/2jIMiGHSscXhSGkWQMwz8oyHoQIM50JTV2wkhIGJSvEFHHDy17VSAadarlfBTyJsMrCvNHhMPT/MusGmfVNNk8d2NeVTPvWV4t1nggYIwMqfSBPZtKiMEIGpeXoM0KKEIjfn+P3sWIk9L9LNPTPnatyB1mqnHlCR209vOMeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLalvD6H; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d53684cfdso248787166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761839112; x=1762443912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qQw58xDNeBDd4guJOX0xDWWFDhMFnZ1Z7Brimn3OHU=;
        b=kLalvD6HPuN1yIPPALjUo3HHe7KRgEsz3+FnIVwFisfWsWk2PekGqP9ZXP4T8jkMF6
         CnLSHHJwiGH5jQR7d7/0zYGLl6Mef7INaB7MBqbc3WIf4Y/QXkNzlz+g09Sv/B1Vz+jH
         QeQC0GRxig083XiX7rEyIzfBTmwxL6440dEDPP+4athFs4cWYjPfsQeZH4KtYeyW1RWk
         kSS7HPziSq8awNW/be6vXto+D4Z604twmzo5727GPN7Bq2kC2DMJbYIDOh2u1Ck4g6Sb
         RbHHS+EBZiZRwfruIKN82fhpXFK3UVF4m5wmawWZAH2b3qE2WGQsfwKOLTks4W9OAmSv
         WW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839112; x=1762443912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qQw58xDNeBDd4guJOX0xDWWFDhMFnZ1Z7Brimn3OHU=;
        b=eKTTLrR4vbXyOUzd+XkAgmglguBpv2ig0aotvBkbE+6eG5438+QefLHJIxraUnyqmQ
         014vsuC94dNiAKla6iOFQRXnqsiLk5eIr4tv8ObA8N7O/yru+fny32Ek3NEteE2ybEMo
         XiyKx3dhxHuFWO5bEqqGmbtIFeDLhiBNswS0VhkLRv2ne4Shs/gZdERP5HvXyhppGHK5
         g3KvmOarNcl1ToQgMDPtLDiKZNc2Z1Yef4/wpqlvQAw4fhowhNJYsCzaZ54cZ6G9h6/Y
         zAa+/Cr5XTzOotkWbJCNuyBs6Q5QuXLfuf7/NcQ4/vxG86sQJSXMVEoIoGvSugopqqnN
         ynDg==
X-Forwarded-Encrypted: i=1; AJvYcCVH2qLh+DWSlh9sCRFVJ7X0xoLlAv4ieDlOoDhZK1EJfm+rMhC/swZEgWJdCxCVDrVVe4gaU0gRGs1UjTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDzFkwLPTCw5eQSgvY4tO/+h7jZoHxMSeDMfIkiykiSbGK+sDA
	J36zt/cqC0tsEzTEoedUl682yagGk/L2qkMXPg8SkH2yekzE1x4MvoR0
X-Gm-Gg: ASbGncu0rLN4JfBdEqU8QrJ99Way3E7YbywVjQUOlm4mNmcl8GMcGCiXRuwoEZJU1xg
	X1qPy1nNdDs3ErrGw39nHIqCXjl/0f/fWHfRSPQWjYrVVAHnlRipeHHsN3+7SPeuuDTDCKnvp3Q
	6NTYOqPTj5aLehXm/EZp68rzBD7D1liWd5BjvgiUVS9dvF5ZL0YF+rcjmNpFD7eI04V/DxkyKuk
	4abUyLiU/7K92B71P6b4jqcBw4A6S10HcYoWu5Hqb6CwRS9s9BxdmcrkEzWIgblfjsPtDcyTxwT
	BWxpFKfLcML4A6tWyPRUsqGbI/scSEHA1sEH0lrk16qMpjmJCFGCB9r+AS0KRxGmnu4diJkIMKB
	qugkRYpSkrhI2f1SL4sR2QhVTLMvqjBuRUI/K2P2EY7boWrObl4EgeS6wu2o8hSEzCsivJ81Qzh
	YGpD/+4xzHv3PvkTFg8Q==
X-Google-Smtp-Source: AGHT+IEzLaX6xnN24gjJ3nuapivUZ/3QIkZYDJ5dwZxEoAozYXeov6rrWC970dmqb02bmp61fv9aUQ==
X-Received: by 2002:a17:907:3f02:b0:b0f:4ae:c83 with SMTP id a640c23a62f3a-b703d5fa986mr825834166b.63.1761839111607;
        Thu, 30 Oct 2025 08:45:11 -0700 (PDT)
Received: from Cryo-Lima.localdomain ([91.244.5.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853f9a0fsm1766101166b.50.2025.10.30.08.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:45:10 -0700 (PDT)
From: Oleksandr Suvorov <cryosay@gmail.com>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oleksandr Suvorov <cryosay@gmail.com>
Subject: [PATCH v3] usb: serial: ftdi_sio: add support for u-blox EVK-M101
Date: Thu, 30 Oct 2025 17:42:54 +0200
Message-ID: <20251030154509.3331963-1-cryosay@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030090056.3175217-1-cryosay@gmail.com>
References: <20251030090056.3175217-1-cryosay@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The U-Blox EVK-M101 enumerates as 1546:0506 [1] with four FTDI interfaces:
- EVK-M101 current sensors
- EVK-M101 I2C
- EVK-M101 UART
- EVK-M101 port D

Only the third USB interface is a UART. This change lets ftdi_sio probe
the VID/PID and registers only interface #3 as a TTY, leaving the rest
available for other drivers.

[1]
usb 5-1.3: new high-speed USB device number 11 using xhci_hcd
usb 5-1.3: New USB device found, idVendor=1546, idProduct=0506, bcdDevice= 8.00
usb 5-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 5-1.3: Product: EVK-M101
usb 5-1.3: Manufacturer: u-blox AG

Datasheet: https://content.u-blox.com/sites/default/files/documents/EVK-M10_UserGuide_UBX-21003949.pdf

Link: https://lore.kernel.org/all/20251030090056.3175217-1-cryosay@gmail.com/
Signed-off-by: Oleksandr Suvorov <cryosay@gmail.com>
---
v3:
 - Use USB_DEVICE_INTERFACE_NUMBER instead of custom probe()
v2:
 - Restrict probing to interface #3 only
 - Add a device model to commit message
 - Fix grammar in commit message
 - Add Link: to v1
Signed-off-by: Oleksandr Suvorov <cryosay@gmail.com>
---
 drivers/usb/serial/ftdi_sio.c     | 1 +
 drivers/usb/serial/ftdi_sio_ids.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 49666c33b41f..b37fa31f5694 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1074,6 +1074,7 @@ static const struct usb_device_id id_table_combined[] = {
 	/* U-Blox devices */
 	{ USB_DEVICE(UBLOX_VID, UBLOX_C099F9P_ZED_PID) },
 	{ USB_DEVICE(UBLOX_VID, UBLOX_C099F9P_ODIN_PID) },
+	{ USB_DEVICE_INTERFACE_NUMBER(UBLOX_VID, UBLOX_EVK_M101_PID, 2) },
 	/* FreeCalypso USB adapters */
 	{ USB_DEVICE(FTDI_VID, FTDI_FALCONIA_JTAG_BUF_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 4cc1fae8acb9..2539b9e2f712 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1614,6 +1614,7 @@
 #define UBLOX_VID			0x1546
 #define UBLOX_C099F9P_ZED_PID		0x0502
 #define UBLOX_C099F9P_ODIN_PID		0x0503
+#define UBLOX_EVK_M101_PID		0x0506
 
 /*
  * GMC devices
-- 
2.48.1


