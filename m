Return-Path: <linux-kernel+bounces-877841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC115C1F2DE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5B41885693
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1243133DEC8;
	Thu, 30 Oct 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzSRLFwM"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D5E311C3D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814883; cv=none; b=RjFBA7OxvkNFmAIAbgInnImmCqVlpJ68MW2C6/ocKf7yJPLuXA/ZQXBZDIklxrW2aB+nwRixfb9677a0053+4QPssyDXZJM1+pPhJ15oUlb43AEu28TBnTxKzbmbwWhzG0j/aR334+FUb9YAAgk6PQUZbUEkUHKgeU+imPzb5bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814883; c=relaxed/simple;
	bh=oTXH1HSFJLJZw91fOW+WljD2l5wCGInb49O0XJLH7G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLVQK/rzE4/ImELvGo8BiFdTylFy/L5xUUpcWWYScol/G40kMGHLi4sEqM54yqvhKgtBfEyWZdVGPjK4dWx0GGdSwf5mG8vLty1o4B51f69/wXMaqsa7ew/ZCGPWUSl++k9lfp+j1INsXg6bPdpvvonJiBKrDdVN6jGkycqujX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzSRLFwM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b472842981fso116224466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761814880; x=1762419680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0I1RDzCXpmn0YP4V5s1DEMEUTTTHY2hb0kzAlUdjY0=;
        b=MzSRLFwM0r0uUGM0p7U831dgfPk27xw+UgScYTJKI8vtaY8shuUHrajrS6CLO9MzU5
         ow5BA8n7YW/O9kIY1BmZmHyj/La5Ew3SZBv6Piiede22yTA6RpcHsN68/fxZylBhCpxD
         diT65E+AMv4rizdfKKzqH5uA2cZ0SEIiTgPb5xfOrCT3TtjJuuzMbMz3eukkUK1luLLz
         L6ZKO0na0dQJGyo/IBZ/HF2UON9pKSCmqUgUhS6zoOKXZC+IzRtehOXTvlp+fwKmXWci
         yDhewURuI5nPoFxQASvKi16/TnCnujosExwSWUSQz4fJPKvMtFYoc/lRy4adxuciGl70
         jxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814880; x=1762419680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0I1RDzCXpmn0YP4V5s1DEMEUTTTHY2hb0kzAlUdjY0=;
        b=f7gVwV/4B/VX3nco5+VfSktYs287QIWd29Ku6HoMuwKCAwktcqJVojJow/0MtQU7DX
         VLwCI5v8hp1lQrV4EJP7rZaRJiLjjUKTEcwILWG5b8SH7vrjc1/3Tmslws/Yv54EuvJw
         okPJZR6IlDRp4ZwmDxTNsILic2+GcHU38baYZQ4F9uwO9nC2x2i8TkGkllHK8Gq3SFhr
         sywbOci6rRNjM0c0H8WBzPOUF889ZNXrMhKyjKKjomRs9gR66tUXHJac3OXrCO2/qU28
         AMBgkZi72AUIrQ3waZepBptz+ui0nj3HMqI2jF1kvxwOQSJqmJnec1CfvC20yWvG6D89
         mzMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRJdBdknnIPt8OZhD+KCvz8ZOO6RRFknZd+lNoCOmY5w8pIeEC48qWtfMSHFFEH0KlsfQrguBr1YdmCRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyIWN+RmLjeuZdR47qxV+0YeFSLxDuZ7caszJs8u88leZ5U4Ac
	m+Rxsx1Ug6/YPVIvXgTJ6kOIOR1ixsxv+6e4ItDKOpkFT1UPn/tivelGB1WlYw==
X-Gm-Gg: ASbGncvEC1PjYCb+NrxLJImVUevO1xoRtk8a42+mDry3aA7CYEjyrgHhgZzRxGGX8v4
	mjBPtkzYa+ZFlmRrgbEDKC6WQVN8/NswE1VnhC/OSxcSeEAVR43XImz9kArnAv4PRohAoxfh6rh
	6jUUQwlFUEr46bLCR+yvXWaNUxRSeU08iOUoGH//RSM14Z555bOkyJiRZYcMTaQ6jl7Sf/DL/3b
	Wm7cfdZjO3T4upO97gFKxulBhoRBA4MPT6lR3MWyrTki36t596yM9JhSS3zY1g2mlbgqalfJS4S
	LPEHpaEIxZZb0/3rXw8E53NkwllSbETC++VpDRUde1OAwZfDVUxbSZZMW6wgRSmdFLOf6wwqYwA
	rtYk4m1nwuZz32shgTu35YdrYx+2QmtIkqJ0gjL+0G+X4OTzkWO9Yx1zj6DOGKQAHRC9hoTmb7a
	P+nTf196t1leAFvAxH1g==
X-Google-Smtp-Source: AGHT+IGkEXaqj19+vVocV4VEjZ7JC+wQatYMwdbAdhHxu79TOdyH9dqrXl6kOlTFI7dE0RDJjHOHXA==
X-Received: by 2002:a17:906:794e:b0:b6d:536f:ada with SMTP id a640c23a62f3a-b703d5243ddmr637882566b.43.1761814879283;
        Thu, 30 Oct 2025 02:01:19 -0700 (PDT)
Received: from Cryo-Lima.localdomain ([91.244.5.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8536968csm1705784366b.29.2025.10.30.02.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:01:18 -0700 (PDT)
From: Oleksandr Suvorov <cryosay@gmail.com>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oleksandr Suvorov <cryosay@gmail.com>
Subject: [PATCH v2] usb: serial: ftdi_sio: add support for u-blox EVK-M101
Date: Thu, 30 Oct 2025 11:00:15 +0200
Message-ID: <20251030090056.3175217-1-cryosay@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <aO5kBAjE6EMG2aUE@hovoldconsulting.com>
References: <aO5kBAjE6EMG2aUE@hovoldconsulting.com>
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

Link: https://lore.kernel.org/r/20250926060235.3442748-1-cryosay@gmail.com
Signed-off-by: Oleksandr Suvorov <cryosay@gmail.com>
---
v2:
 - Restrict probing to interface #3 only
 - Add a device model to commit message
 - Fix grammar in commit message
 - Add Link: to v1
---
 drivers/usb/serial/ftdi_sio.c     | 25 +++++++++++++++++++++++++
 drivers/usb/serial/ftdi_sio_ids.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 49666c33b41f..4902b496d6de 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -110,6 +110,7 @@ static int   ftdi_jtag_probe(struct usb_serial *serial);
 static int   ftdi_NDI_device_setup(struct usb_serial *serial);
 static int   ftdi_stmclite_probe(struct usb_serial *serial);
 static int   ftdi_8u2232c_probe(struct usb_serial *serial);
+static int   ftdi_evkm101_probe(struct usb_serial *serial);
 static void  ftdi_USB_UIRT_setup(struct ftdi_private *priv);
 static void  ftdi_HE_TIRA1_setup(struct ftdi_private *priv);
 
@@ -137,6 +138,10 @@ static const struct ftdi_quirk ftdi_8u2232c_quirk = {
 	.probe	= ftdi_8u2232c_probe,
 };
 
+static const struct ftdi_quirk ftdi_evkm101_quirk = {
+	.probe	= ftdi_evkm101_probe,
+};
+
 /*
  * The 8U232AM has the same API as the sio except for:
  * - it can support MUCH higher baudrates; up to:
@@ -1074,6 +1079,8 @@ static const struct usb_device_id id_table_combined[] = {
 	/* U-Blox devices */
 	{ USB_DEVICE(UBLOX_VID, UBLOX_C099F9P_ZED_PID) },
 	{ USB_DEVICE(UBLOX_VID, UBLOX_C099F9P_ODIN_PID) },
+	{ USB_DEVICE(UBLOX_VID, UBLOX_EVK_M101_PID),
+		.driver_info = (kernel_ulong_t)&ftdi_evkm101_quirk },
 	/* FreeCalypso USB adapters */
 	{ USB_DEVICE(FTDI_VID, FTDI_FALCONIA_JTAG_BUF_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
@@ -2362,6 +2369,24 @@ static int ftdi_stmclite_probe(struct usb_serial *serial)
 	return 0;
 }
 
+/*
+ * 1st, 2nd and 4th ports on U-Blox EVK-M101 using an FTDI FT4232H USB-to-UART
+ * are reserved for non-UART interfaces. The only 3rd port can be used as UART.
+ */
+static int ftdi_evkm101_probe(struct usb_serial *serial)
+{
+	struct usb_interface *intf = serial->interface;
+	int ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
+
+	if (ifnum != 2) {
+		dev_info(&intf->dev,
+			 "Ignoring interface reserved as non-UART\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static void ftdi_port_remove(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
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


