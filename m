Return-Path: <linux-kernel+bounces-865361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AFBBFCE29
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 606935050C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54D734D4F0;
	Wed, 22 Oct 2025 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgAzVxLw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE5C34D933;
	Wed, 22 Oct 2025 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146815; cv=none; b=NVjmAJDWkqBwUUjLT3izVteJJLCGw0ruhXKRd6d6026ptO0fm7xT/3Y1Sm6WLZ0WOIMntzp6f1snJB7qJp0vedTS7Jwj2HZPzayWIBMEFE8Rh9WYA39BzQYQdInjzIGRvwDyymMYCAuLR5YqC5CaygMRIL89B34oIZLhLrtHro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146815; c=relaxed/simple;
	bh=Dx85VVs25HOQaToVZX33ToHNqh/5RZl7+mhYzPCaM7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEbodm1BTz8/89Tti7o9Y3HF6mvqoBLBLXlyshJkZZTXPWZrPA5g4PPT6jRiIbaPJh0nU5Vcxh74R+LMfgh8NNERgpJCY8oeA9D8PtOZ/rS4dqrFvDpwk/sSwJYTz4oLPQrkerkvY6hUFqqELfK/hSKbXMzjiGpWyD8KeuogziU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgAzVxLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A103C16AAE;
	Wed, 22 Oct 2025 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761146813;
	bh=Dx85VVs25HOQaToVZX33ToHNqh/5RZl7+mhYzPCaM7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgAzVxLw0wVb97glM2wQle1hRxHi347Tg3ocAD7dp/WhPgvO8EMf0EyYRFqg19oYh
	 3uyVMXWY/URD5iNY7/6SLu1Le5b5cPFzsuV5fV0cwFHe80xY5gcDwBrgu6iZMWs9Sb
	 JsETR7cnCx45yZzpa7NA3maqQVNliz7GRFsqZaOGpRAhEDxW6FEEZ4ELrlxM3jgEyY
	 SLhHVRpCtSW3pMvUAehWZUAnCcyh0Vlm4ll+fyD7AWmTjM/OjAfb4Kmq2p25qfw4Tz
	 W35BipQnYVqRkzH4OUDIEbGTmUjm+sHi0BUDFr81uTaoFvuhtFPpOCljVE3PnbfvUb
	 LUH9CXuzaZ9VQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vBajs-000000006JV-0inT;
	Wed, 22 Oct 2025 17:27:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] USB: serial: kobil_sct: clean up set_termios()
Date: Wed, 22 Oct 2025 17:26:39 +0200
Message-ID: <20251022152640.24212-8-johan@kernel.org>
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

Clean up set_termios() by using a shorter identifier for the control
request value, replacing a ternary operator and adding some missing
braces to make it more readable.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/kobil_sct.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
index 3c13410520ec..cad3cfc63ce7 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -435,9 +435,9 @@ static void kobil_set_termios(struct tty_struct *tty,
 {
 	struct kobil_private *priv;
 	int result;
-	unsigned short urb_val = 0;
 	int c_cflag = tty->termios.c_cflag;
 	speed_t speed;
+	u16 val;
 
 	priv = usb_get_serial_port_data(port);
 	if (priv->device_type == KOBIL_USBTWIN_PRODUCT_ID ||
@@ -450,28 +450,34 @@ static void kobil_set_termios(struct tty_struct *tty,
 	speed = tty_get_baud_rate(tty);
 	switch (speed) {
 	case 1200:
-		urb_val = SUSBCR_SBR_1200;
+		val = SUSBCR_SBR_1200;
 		break;
 	default:
 		speed = 9600;
 		fallthrough;
 	case 9600:
-		urb_val = SUSBCR_SBR_9600;
+		val = SUSBCR_SBR_9600;
 		break;
 	}
-	urb_val |= (c_cflag & CSTOPB) ? SUSBCR_SPASB_2StopBits :
-							SUSBCR_SPASB_1StopBit;
+
+	if (c_cflag & CSTOPB)
+		val |= SUSBCR_SPASB_2StopBits;
+	else
+		val |= SUSBCR_SPASB_1StopBit;
+
 	if (c_cflag & PARENB) {
 		if  (c_cflag & PARODD)
-			urb_val |= SUSBCR_SPASB_OddParity;
+			val |= SUSBCR_SPASB_OddParity;
 		else
-			urb_val |= SUSBCR_SPASB_EvenParity;
-	} else
-		urb_val |= SUSBCR_SPASB_NoParity;
+			val |= SUSBCR_SPASB_EvenParity;
+	} else {
+		val |= SUSBCR_SPASB_NoParity;
+	}
+
 	tty->termios.c_cflag &= ~CMSPAR;
 	tty_encode_baud_rate(tty, speed, speed);
 
-	result = kobil_ctrl_send(port, SUSBCRequest_SetBaudRateParityAndStopBits, urb_val);
+	result = kobil_ctrl_send(port, SUSBCRequest_SetBaudRateParityAndStopBits, val);
 	if (result) {
 		dev_err(&port->dev, "failed to update line settings: %d\n",
 				result);
-- 
2.49.1


