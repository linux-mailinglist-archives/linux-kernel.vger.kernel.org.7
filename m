Return-Path: <linux-kernel+bounces-865359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB27DBFCDFC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D6F1887163
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E506D2BE03C;
	Wed, 22 Oct 2025 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag9rRglk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1B334B434;
	Wed, 22 Oct 2025 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146815; cv=none; b=eMr+T375jWcSPngQrPvajqzjIagIZ0cHVzh/cISrrhtsu/eawqmeJkV9MF0RuF19BvPA8L7noSrrN5Eoh9AOX7HBmLyUNH2/ESTU4781G7pQ7szoDotwgc02nUFmkq1d/ioq2pqcXiak1PGEKz6gYezkwRB4QC6cySsCMKWnS+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146815; c=relaxed/simple;
	bh=JowAr2pRjS1kkLEPho/c3TcgpU4Ln6t1Sp2K+I6eKNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ia9w/hGEQ7gXb3XOmgYSa0FjsP8LPerMJ9NwfRirF7xSU8CdvNB6VxzNcQCYBWQxJ5aHD0hmHjkmAECQTUUPoaMhw6hswOokuyDn/393QakuFJ9ZH8/zzluRHa9uozR1H59R6V1XDpbzCaOoLV88CJS8CiDvkzLty4w3Ut73YQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag9rRglk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D411C4AF0B;
	Wed, 22 Oct 2025 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761146813;
	bh=JowAr2pRjS1kkLEPho/c3TcgpU4Ln6t1Sp2K+I6eKNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ag9rRglkeOjap1N/KRj8B0cFtgQwOzIZKaju4z9NrKdslCL+3UaquiYlNqZ+tvP6h
	 AlytpSfclvp4fVhMrTcX5w8c4K7Va+mXMAmSm2IOpoWA0LElHy2voUdi9ZIX2PIgsM
	 CYx75BcDwZsR4G2rwuXBvplYl8dkKWEu06xpEd3ilcWzPr44cRNMxnpmJEt3Pxp12/
	 UeARsObA38LRNsLpdp3I/7vMKW5zmIpuynUjzsKVmYJoDEl3azY5XMCFJuZFgCQrZn
	 ZnnbeAYSPQy2yjcNNpnJK9ydwyGBJ1OmosvxHqm3uvraaP9XFT7bymcuUjC2DrjmyW
	 27fk47dQQkZ/w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vBajr-000000006JM-3qE3;
	Wed, 22 Oct 2025 17:26:59 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] USB: serial: kobil_sct: clean up tiocmset()
Date: Wed, 22 Oct 2025 17:26:36 +0200
Message-ID: <20251022152640.24212-5-johan@kernel.org>
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

Clean up the tiocmset() implementation by simplifying the flag check,
dropping some dev_dbg(), logging errors using dev_err() and using a
common control message call for both DTR and RTS to make the existing
logic easier to follow.

Note that the modem control lines are currently only manipulated in this
function, which therefore does not require any locking.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/kobil_sct.c | 61 +++++++++++++++-------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
index 96ea571c436a..b8169783f6f0 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -418,11 +418,10 @@ static int kobil_tiocmset(struct tty_struct *tty,
 	struct usb_serial_port *port = tty->driver_data;
 	struct device *dev = &port->dev;
 	struct kobil_private *priv;
-	int result = 0;
-	int dtr = 0;
-	int rts = 0;
+	int dtr, rts;
+	int result;
+	u16 val = 0;
 
-	/* FIXME: locking ? */
 	priv = usb_get_serial_port_data(port);
 	if (priv->device_type == KOBIL_USBTWIN_PRODUCT_ID
 		|| priv->device_type == KOBIL_KAAN_SIM_PRODUCT_ID) {
@@ -430,46 +429,38 @@ static int kobil_tiocmset(struct tty_struct *tty,
 		return -EINVAL;
 	}
 
-	if (set & TIOCM_RTS)
-		rts = 1;
-	if (set & TIOCM_DTR)
-		dtr = 1;
-	if (clear & TIOCM_RTS)
-		rts = 1;
-	if (clear & TIOCM_DTR)
-		dtr = 1;
+	dtr = (set | clear) & TIOCM_DTR;
+	rts = (set | clear) & TIOCM_RTS;
 
 	if (dtr && priv->device_type == KOBIL_ADAPTER_B_PRODUCT_ID) {
 		if (set & TIOCM_DTR)
-			dev_dbg(dev, "%s - Setting DTR\n", __func__);
+			val = SUSBCR_SSL_SETDTR;
 		else
-			dev_dbg(dev, "%s - Clearing DTR\n", __func__);
-		result = usb_control_msg(port->serial->dev,
-			  usb_sndctrlpipe(port->serial->dev, 0),
-			  SUSBCRequest_SetStatusLinesOrQueues,
-			  USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT,
-			  ((set & TIOCM_DTR) ? SUSBCR_SSL_SETDTR : SUSBCR_SSL_CLRDTR),
-			  0,
-			  NULL,
-			  0,
-			  KOBIL_TIMEOUT);
+			val = SUSBCR_SSL_CLRDTR;
 	} else if (rts) {
 		if (set & TIOCM_RTS)
-			dev_dbg(dev, "%s - Setting RTS\n", __func__);
+			val = SUSBCR_SSL_SETRTS;
 		else
-			dev_dbg(dev, "%s - Clearing RTS\n", __func__);
+			val = SUSBCR_SSL_CLRRTS;
+	}
+
+	if (val) {
 		result = usb_control_msg(port->serial->dev,
-			usb_sndctrlpipe(port->serial->dev, 0),
-			SUSBCRequest_SetStatusLinesOrQueues,
-			USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT,
-			((set & TIOCM_RTS) ? SUSBCR_SSL_SETRTS : SUSBCR_SSL_CLRRTS),
-			0,
-			NULL,
-			0,
-			KOBIL_TIMEOUT);
+				usb_sndctrlpipe(port->serial->dev, 0),
+				SUSBCRequest_SetStatusLinesOrQueues,
+				USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT,
+				val,
+				0,
+				NULL,
+				0,
+				KOBIL_TIMEOUT);
+		if (result < 0) {
+			dev_err(dev, "failed to set status lines: %d\n", result);
+			return result;
+		}
 	}
-	dev_dbg(dev, "%s - Send set_status_line URB returns: %i\n", __func__, result);
-	return (result < 0) ? result : 0;
+
+	return 0;
 }
 
 static void kobil_set_termios(struct tty_struct *tty,
-- 
2.49.1


