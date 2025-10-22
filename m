Return-Path: <linux-kernel+bounces-865360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C7FBFCE50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CC83BAEAA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2042E34DB5D;
	Wed, 22 Oct 2025 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tD2JOx+5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0BF32AABC;
	Wed, 22 Oct 2025 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146815; cv=none; b=X0mE4E5UC+y0D3bhDHod/6VNZqoLq6UAOQdJ7xI3Y1ti8ctITxb1R4juJ/zQQTLmQ8djdLNb29cRDfuN3KBv+zHAuOUgA7fOgeD3t4Mbgk8mYpFg8tsQ1O32lekt8RjSaqRb2PYiaB4uXDLhevIWFNCcklFoQGqAHw0FflZCEQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146815; c=relaxed/simple;
	bh=SRitKMujqENHu4ooLuqItGId6P9C+NeFm2BQUOUwf2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qU6/3OWAqr4zRnohw3iRMC+Yztvjm+4s8RLjjCwL+3qqUgvkKDi14u7CGiQ7OAT/OHvuYwrG8xEzKRc0lIHn0liuQrultEb/X9qUqJLJov1D6MXQQVAazyyvjdIpbUg/RvlQRm86VPkXN2rct+gmVeJls4/j5ecl8T9qMt0PF58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tD2JOx+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72932C19424;
	Wed, 22 Oct 2025 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761146813;
	bh=SRitKMujqENHu4ooLuqItGId6P9C+NeFm2BQUOUwf2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tD2JOx+5RMxlzJPDPZ3qqVCRT7cmFWVmKg7QO/bShpt82lp4P6I+S51MCeDfeiecD
	 pC7ZJSsvAYKwSIw8wtDE8sPBoGcaTaSEwmi6UAtnH0UnesZkKshnvAz6RMbkxAKApp
	 b/tS96sdKYinLz06W8udO9JpmI+GHt4FN+4Zq5gj9YCJUwDhMQJoELK6THAWZT6v30
	 5XA2fbjbY0EmN0klyd26E6jhZWiPuZKq0CtlrxYUpeSvZrw7w7NQLrRfRl2rkTJfHv
	 +zjUEblaj+Kc1nNFjM01uOONckRS0qxW8OrI5oTAteT1srieaz39z99PLHlqasjZkz
	 SnvCnwYJqaauQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vBajs-000000006JS-0Olm;
	Wed, 22 Oct 2025 17:27:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] USB: serial: kobil_sct: add control request helpers
Date: Wed, 22 Oct 2025 17:26:38 +0200
Message-ID: <20251022152640.24212-7-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251022152640.24212-1-johan@kernel.org>
References: <20251022152640.24212-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor by adding two control request helpers to make the code more
readable.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/kobil_sct.c | 108 +++++++++------------------------
 1 file changed, 27 insertions(+), 81 deletions(-)

diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
index e1015cab2770..3c13410520ec 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -109,6 +109,21 @@ struct kobil_private {
 	__u16 device_type;
 };
 
+static int kobil_ctrl_send(struct usb_serial_port *port, u8 req, u16 val)
+{
+	return usb_control_msg(port->serial->dev,
+			usb_sndctrlpipe(port->serial->dev, 0),
+			req, USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT,
+			val, 0, NULL, 0, KOBIL_TIMEOUT);
+}
+
+static int kobil_ctrl_recv(struct usb_serial_port *port, u8 req, u16 val, void *buf, u16 size)
+{
+	return usb_control_msg(port->serial->dev,
+			usb_rcvctrlpipe(port->serial->dev, 0),
+			req, USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_IN,
+			val, 0, buf, size, KOBIL_TIMEOUT);
+}
 
 static int kobil_port_probe(struct usb_serial_port *port)
 {
@@ -176,16 +191,8 @@ static int kobil_open(struct tty_struct *tty, struct usb_serial_port *port)
 		return -ENOMEM;
 
 	/* get hardware version */
-	result = usb_control_msg(port->serial->dev,
-			  usb_rcvctrlpipe(port->serial->dev, 0),
-			  SUSBCRequest_GetMisc,
-			  USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_IN,
-			  SUSBCR_MSC_GetHWVersion,
-			  0,
-			  transfer_buffer,
-			  transfer_buffer_length,
-			  KOBIL_TIMEOUT
-	);
+	result = kobil_ctrl_recv(port, SUSBCRequest_GetMisc, SUSBCR_MSC_GetHWVersion,
+			transfer_buffer, transfer_buffer_length);
 	dev_dbg(dev, "%s - Send get_HW_version URB returns: %i\n", __func__, result);
 	if (result >= 3) {
 		dev_dbg(dev, "Hardware version: %i.%i.%i\n", transfer_buffer[0],
@@ -193,16 +200,8 @@ static int kobil_open(struct tty_struct *tty, struct usb_serial_port *port)
 	}
 
 	/* get firmware version */
-	result = usb_control_msg(port->serial->dev,
-			  usb_rcvctrlpipe(port->serial->dev, 0),
-			  SUSBCRequest_GetMisc,
-			  USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_IN,
-			  SUSBCR_MSC_GetFWVersion,
-			  0,
-			  transfer_buffer,
-			  transfer_buffer_length,
-			  KOBIL_TIMEOUT
-	);
+	result = kobil_ctrl_recv(port, SUSBCRequest_GetMisc, SUSBCR_MSC_GetFWVersion,
+			transfer_buffer, transfer_buffer_length);
 	dev_dbg(dev, "%s - Send get_FW_version URB returns: %i\n", __func__, result);
 	if (result >= 3) {
 		dev_dbg(dev, "Firmware version: %i.%i.%i\n", transfer_buffer[0],
@@ -212,30 +211,12 @@ static int kobil_open(struct tty_struct *tty, struct usb_serial_port *port)
 	if (priv->device_type == KOBIL_ADAPTER_B_PRODUCT_ID ||
 			priv->device_type == KOBIL_ADAPTER_K_PRODUCT_ID) {
 		/* Setting Baudrate, Parity and Stopbits */
-		result = usb_control_msg(port->serial->dev,
-			  usb_sndctrlpipe(port->serial->dev, 0),
-			  SUSBCRequest_SetBaudRateParityAndStopBits,
-			  USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT,
-			  SUSBCR_SBR_9600 | SUSBCR_SPASB_EvenParity |
-							SUSBCR_SPASB_1StopBit,
-			  0,
-			  NULL,
-			  0,
-			  KOBIL_TIMEOUT
-		);
+		result = kobil_ctrl_send(port, SUSBCRequest_SetBaudRateParityAndStopBits,
+				SUSBCR_SBR_9600 | SUSBCR_SPASB_EvenParity | SUSBCR_SPASB_1StopBit);
 		dev_dbg(dev, "%s - Send set_baudrate URB returns: %i\n", __func__, result);
 
 		/* reset all queues */
-		result = usb_control_msg(port->serial->dev,
-			  usb_sndctrlpipe(port->serial->dev, 0),
-			  SUSBCRequest_Misc,
-			  USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT,
-			  SUSBCR_MSC_ResetAllQueues,
-			  0,
-			  NULL,
-			  0,
-			  KOBIL_TIMEOUT
-		);
+		result = kobil_ctrl_send(port, SUSBCRequest_Misc, SUSBCR_MSC_ResetAllQueues);
 		dev_dbg(dev, "%s - Send reset_all_queues URB returns: %i\n", __func__, result);
 	}
 	if (priv->device_type == KOBIL_USBTWIN_PRODUCT_ID ||
@@ -385,16 +366,8 @@ static int kobil_tiocmget(struct tty_struct *tty)
 	if (!transfer_buffer)
 		return -ENOMEM;
 
-	result = usb_control_msg(port->serial->dev,
-			  usb_rcvctrlpipe(port->serial->dev, 0),
-			  SUSBCRequest_GetStatusLineState,
-			  USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_IN,
-			  0,
-			  0,
-			  transfer_buffer,
-			  transfer_buffer_length,
-			  KOBIL_TIMEOUT);
-
+	result = kobil_ctrl_recv(port, SUSBCRequest_GetStatusLineState, 0,
+			transfer_buffer, transfer_buffer_length);
 	dev_dbg(&port->dev, "Send get_status_line_state URB returns: %i\n",
 			result);
 	if (result < 1) {
@@ -446,15 +419,7 @@ static int kobil_tiocmset(struct tty_struct *tty,
 	}
 
 	if (val) {
-		result = usb_control_msg(port->serial->dev,
-				usb_sndctrlpipe(port->serial->dev, 0),
-				SUSBCRequest_SetStatusLinesOrQueues,
-				USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT,
-				val,
-				0,
-				NULL,
-				0,
-				KOBIL_TIMEOUT);
+		result = kobil_ctrl_send(port, SUSBCRequest_SetStatusLinesOrQueues, val);
 		if (result < 0) {
 			dev_err(dev, "failed to set status lines: %d\n", result);
 			return result;
@@ -506,16 +471,7 @@ static void kobil_set_termios(struct tty_struct *tty,
 	tty->termios.c_cflag &= ~CMSPAR;
 	tty_encode_baud_rate(tty, speed, speed);
 
-	result = usb_control_msg(port->serial->dev,
-		  usb_sndctrlpipe(port->serial->dev, 0),
-		  SUSBCRequest_SetBaudRateParityAndStopBits,
-		  USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT,
-		  urb_val,
-		  0,
-		  NULL,
-		  0,
-		  KOBIL_TIMEOUT
-		);
+	result = kobil_ctrl_send(port, SUSBCRequest_SetBaudRateParityAndStopBits, urb_val);
 	if (result) {
 		dev_err(&port->dev, "failed to update line settings: %d\n",
 				result);
@@ -536,17 +492,7 @@ static int kobil_ioctl(struct tty_struct *tty,
 
 	switch (cmd) {
 	case TCFLSH:
-		result = usb_control_msg(port->serial->dev,
-			  usb_sndctrlpipe(port->serial->dev, 0),
-			  SUSBCRequest_Misc,
-			  USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT,
-			  SUSBCR_MSC_ResetAllQueues,
-			  0,
-			  NULL,
-			  0,
-			  KOBIL_TIMEOUT
-			);
-
+		result = kobil_ctrl_send(port, SUSBCRequest_Misc, SUSBCR_MSC_ResetAllQueues);
 		dev_dbg(&port->dev,
 			"%s - Send reset_all_queues (FLUSH) URB returns: %i\n",
 			__func__, result);
-- 
2.49.1


