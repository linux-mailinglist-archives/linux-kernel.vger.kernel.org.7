Return-Path: <linux-kernel+bounces-841966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 956B1BB8A54
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 08:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DE454E171F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 06:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28484230BFD;
	Sat,  4 Oct 2025 06:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpwAO1Nu"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6881662E7
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759560988; cv=none; b=TVv6CgtEv5+0vchltxg6DI/qQ9KsDJ84eUXIK7rKc+lhTiLxTKwBbYnhHqVj3hz7PgE0jV1PSripuQQh1KtWjamCQR2bYeRSHbE6/e17kARBQR96j1GLV4zj2g9FuujGjQzk3T0VC6XHEKp/zwE/Su8F1U8yfNlen1GVnLVq2es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759560988; c=relaxed/simple;
	bh=Akg62ZfHSXk8/MAeJYQ188NE63lSNc+b3eVzEJKBmqc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aavSGCVT+TRsVqreLXKDv+7DZs4p354KlrY+TszMeVeUsaLb7C0AhROyXotkaglVt8MX54l/J0RkrM2ThyJw5PdSAHMw7mCn5QlyP/x9lzlXNCDIHleODiHJ4JqjGMyGtlwXX+PI61H+QX77+lQVhigWrBguvEEdrjAtO1/+BQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpwAO1Nu; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77c1814ca1dso2224998b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 23:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759560986; x=1760165786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/31utkvfUNb/M8r9xoY+/XrOhevw5/hi8IXZ2URA6Q=;
        b=jpwAO1NusXWJVf0e/4CQmHLh8EsABqHwebnybBocDtM3SxFDX1UwlpGFXSPyC0J0g0
         Y2EJAfKgi2AOzLg3AmdRVvFKqfNeyHowX56q6cFovnUCUYHE5pun2GjDcwyRxS/+0IQ7
         GfMEB2pL4WDEJMH9awYidVYjL0rqt4fjTBhv/gzjtpUdxqDMykdMISL+tGejlguZ7DB4
         niJX6ekFihrAPFYNwezBCRRuxYPVuAblppjFc+KXCQDgXnUkMrYFESuqgA5SSOuWbOqT
         /Q5la7sItuKpFWbl3++IUHTQoaJgWapA/O08cymfNXe+uR/vP8qHdFkFg/GiHHPIMfCw
         C5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759560986; x=1760165786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/31utkvfUNb/M8r9xoY+/XrOhevw5/hi8IXZ2URA6Q=;
        b=lCOgdZDXEKxmlP72sDK9E2skxtHonqai6D6vOr4RjSUNxMg01AyhndsLlk70vYYFDa
         wd3eMtSd7dC0nwFIJsQMaSzFXzQKHHnkZqPpDoTyH6fiEd/uhCL286H5c81K2MoyMYB+
         zYsMbMWZoxI1xRxzFrPThIkC8IFLnz+iXW92c8GqoKAiUSZfVpQCVrMsWSSg3oPZuh3l
         VBhTYBj9Cd2PF8MMxZheEMphMhft/5U9k0XpRgx+5i9B1ulBDNgvXdW7UNpbvB5VC8W8
         lsWv3M+tDYCI7k3M4B36rWu3puNKWoUHwRXAD79KOm3luo3FZgQ/lo3UR/yTPZqAIEHU
         TDdg==
X-Gm-Message-State: AOJu0Yy1gZV5wUZKImw7S6ofVRbj+ChwrHVhkdiIarNDv+Oys4EdhjGH
	YrHO9gkxKTaQX0jyoxXHwAomFZ/NY3ddD+plP+RExwpKoU4t9Ia/Re24
X-Gm-Gg: ASbGnctt2Cqw/m9e8BOwmNwDPAP7dXtoXcX5a5F4dYdSN0qt3ICft2t0qQzZwKW4pjo
	lbAPZrW8DYVCX5fcfpd4mvWubhWfhUVOMJkGLcnCjaKMFhjr1k+zTN1C+G6nLoxkZo5sFgbF3Du
	4l0Fgnd136TdMt1O6mkqYlxLWZy65gR7c2OSs2ift7T3iKudCKjTO6V4otMUVvn9WoC8vvHF8iK
	DMXctUHZO1x81AVDhV85pa6iqZdoOSBC2oro6HEfzQm7dSneTCH2I5APf977mbed5NreaZAIBP0
	cbJGVt+6K0ksNrPWIx1AGJOtH+jKL2Y8VxiDDWPMUc5QvputYfQikvIPQ6r5+593YlEim2EX9ac
	NNPENXN/XRhnKeZXG5oudRUaMzjNLLr3Pw6EpY6xjn8r2CBRPkbT/v2ngZN2A3Q==
X-Google-Smtp-Source: AGHT+IFD7GHyG9wTtVtGlBN3EdoD8sakaAaNr/H/4XHW4uSuPD+X3zU0Xm9uor2HWS1YrnouFiQMmA==
X-Received: by 2002:a05:6a21:32a8:b0:2fd:a3b:933d with SMTP id adf61e73a8af0-32b6212a95amr8167723637.58.1759560986198;
        Fri, 03 Oct 2025 23:56:26 -0700 (PDT)
Received: from mentee25.. ([2405:201:d003:7033:7b72:2259:4f28:5ecc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ebe5f2sm10022160a91.11.2025.10.03.23.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 23:56:25 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: johan@kernel.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH] usb: serial: fix: space prohibited before comma separator
Date: Sat,  4 Oct 2025 12:26:18 +0530
Message-ID: <20251004065618.70151-1-vivekyadav1207731111@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vivek Yadav <vivekyadav1207731111@gmail.com>

Run `checkpatch.pl` script on path `drivers/usb/serial/*`.
Find ERROR: space prohibited before that ',' (ctx:WxE).

Doesn't claim any functionality changes in any of the modified
file.

Signed-off-by: Vivek Yadav <vivekyadav1207731111@gmail.com>
---
 drivers/usb/serial/ark3116.c          | 12 ++++++------
 drivers/usb/serial/ftdi_sio.c         |  2 +-
 drivers/usb/serial/iuu_phoenix.c      |  4 ++--
 drivers/usb/serial/keyspan_usa90msg.h |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index 800b04fe37fa..f1cc4e36e4e6 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -143,18 +143,18 @@ static int ark3116_port_probe(struct usb_serial_port *port)
 	ark3116_write_reg(serial, UART_FCR, 0);
 	/* handshake control */
 	priv->hcr = 0;
-	ark3116_write_reg(serial, 0x8     , 0);
+	ark3116_write_reg(serial, 0x8, 0);
 	/* modem control */
 	priv->mcr = 0;
 	ark3116_write_reg(serial, UART_MCR, 0);
 
 	if (!(priv->irda)) {
-		ark3116_write_reg(serial, 0xb , 0);
+		ark3116_write_reg(serial, 0xb, 0);
 	} else {
-		ark3116_write_reg(serial, 0xb , 1);
-		ark3116_write_reg(serial, 0xc , 0);
-		ark3116_write_reg(serial, 0xd , 0x41);
-		ark3116_write_reg(serial, 0xa , 1);
+		ark3116_write_reg(serial, 0xb, 1);
+		ark3116_write_reg(serial, 0xc, 0);
+		ark3116_write_reg(serial, 0xd, 0x41);
+		ark3116_write_reg(serial, 0xa, 1);
 	}
 
 	/* setup baudrate */
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 49666c33b41f..f5d4335c4f6c 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -190,7 +190,7 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(FTDI_VID, FTDI_8U232AM_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_8U232AM_ALT_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_232RL_PID) },
-	{ USB_DEVICE(FTDI_VID, FTDI_8U2232C_PID) ,
+	{ USB_DEVICE(FTDI_VID, FTDI_8U2232C_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_8u2232c_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_4232H_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_232H_PID) },
diff --git a/drivers/usb/serial/iuu_phoenix.c b/drivers/usb/serial/iuu_phoenix.c
index c21dcc9b6f05..fc71aaea3229 100644
--- a/drivers/usb/serial/iuu_phoenix.c
+++ b/drivers/usb/serial/iuu_phoenix.c
@@ -360,7 +360,7 @@ static void iuu_led_activity_on(struct urb *urb)
 	usb_fill_bulk_urb(port->write_urb, port->serial->dev,
 			  usb_sndbulkpipe(port->serial->dev,
 					  port->bulk_out_endpointAddress),
-			  port->write_urb->transfer_buffer, 8 ,
+			  port->write_urb->transfer_buffer, 8,
 			  iuu_rxcmd, port);
 	usb_submit_urb(port->write_urb, GFP_ATOMIC);
 }
@@ -380,7 +380,7 @@ static void iuu_led_activity_off(struct urb *urb)
 	usb_fill_bulk_urb(port->write_urb, port->serial->dev,
 			  usb_sndbulkpipe(port->serial->dev,
 					  port->bulk_out_endpointAddress),
-			  port->write_urb->transfer_buffer, 8 ,
+			  port->write_urb->transfer_buffer, 8,
 			  iuu_rxcmd, port);
 	usb_submit_urb(port->write_urb, GFP_ATOMIC);
 }
diff --git a/drivers/usb/serial/keyspan_usa90msg.h b/drivers/usb/serial/keyspan_usa90msg.h
index c4ca0f631d20..e01df75140c7 100644
--- a/drivers/usb/serial/keyspan_usa90msg.h
+++ b/drivers/usb/serial/keyspan_usa90msg.h
@@ -69,7 +69,7 @@ struct keyspan_usa90_portControlMessage
 		txMode,			// TXMODE_DMA or TXMODE_BYHAND
 
 		setTxFlowControl,	// host requests tx flow control be set
-		txFlowControl	,	// use TX_FLOW... bits below
+		txFlowControl,	        // use TX_FLOW... bits below
 		setRxFlowControl,	// host requests rx flow control be set
 		rxFlowControl,	// use RX_FLOW... bits below
 		sendXoff,		// host requests XOFF transmitted immediately
-- 
2.43.0


