Return-Path: <linux-kernel+bounces-892942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4120CC462D5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1591895F20
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE0930B501;
	Mon, 10 Nov 2025 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmHj47P2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941353090F1;
	Mon, 10 Nov 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773292; cv=none; b=jv9WNBbEXXnzERPY3exP2wk+r1UDM5ABjWIPE3TcO9wYIn4tTtYT0AqHyH9Mv9k33KAj07zBYdqT6bNdht7qgDdOdR3ht8Loh2TJW6W0v8K5WI0dRXxy27rPSTzqRgBcYJvg8gYLhbV/3CGBT2GEBc3KosB4VLolDARD4hfsVbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773292; c=relaxed/simple;
	bh=qtlbEijNTRgy4G2zYateQGOchcMq+rxXhmt/aXmDSjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLso6WvEK+x+C4RMOSMxPH3wpejPoAwIcvk4ATM+Y8VGfWQv4W0GhtG3RaluLj2waE4wkiwn3x4RuvpAh41SsEmyBUVO4MvJShyp870oQMayQ6Ur55zuxbpSrdozSn3jYTu4L6XvF5HnFm/JTm68KDD9ypUV8NEWQD+TivOw6rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmHj47P2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAF9C2BC86;
	Mon, 10 Nov 2025 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762773292;
	bh=qtlbEijNTRgy4G2zYateQGOchcMq+rxXhmt/aXmDSjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hmHj47P2uiyK78L52tNVxq2Hx9VvqcLymtiju4rRLPR4rmPyXdlX6VxXsr//+FGGL
	 a8InCZGpnx6V9krPd3dBIafONERd1CGTuF/bjjm0AJGE3SbAyGxlXmorTNDapPknxm
	 Uu3nAV1bCxh81zBlYK4KZyXudk+in+mR/if03BJnlsBPVq8evLcjyPqVIfI2JRKzHQ
	 H4DcuqAOm2+zav/a1UnWmXpBNkka0itQt+FhSpmfnm9lOrNCfVLQLF2WOzXNOUmR3X
	 vrAm744ACw8YEbjra+KwY6m+n3Cd/OyC7xJy8YbQ0BB/U4ftG3WRF5RAaOd75B2tcg
	 qMaDhTNgTTAmQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vIPrI-0000000007g-1vRq;
	Mon, 10 Nov 2025 12:14:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ryan Mann <rmann@ndigital.com>,
	Andreas Messer <andi@bastelmap.de>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] USB: serial: ftdi_sio: clean up quirk comments
Date: Mon, 10 Nov 2025 12:12:08 +0100
Message-ID: <20251110111212.32702-5-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110111212.32702-1-johan@kernel.org>
References: <20251110111212.32702-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up the quirk function comments that were using odd formatting and
were referring to a non-existing function.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index dd03d9458441..75f354ef6095 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2231,9 +2231,10 @@ static int ftdi_port_probe(struct usb_serial_port *port)
 	return result;
 }
 
-/* Setup for the USB-UIRT device, which requires hardwired
- * baudrate (38400 gets mapped to 312500) */
-/* Called from usbserial:serial_probe */
+/*
+ * Setup for the USB-UIRT device, which requires hardwired baudrate
+ * (38400 gets mapped to 312500).
+ */
 static void ftdi_USB_UIRT_setup(struct ftdi_private *priv)
 {
 	priv->flags |= ASYNC_SPD_CUST;
@@ -2241,9 +2242,10 @@ static void ftdi_USB_UIRT_setup(struct ftdi_private *priv)
 	priv->force_baud = 38400;
 }
 
-/* Setup for the HE-TIRA1 device, which requires hardwired
- * baudrate (38400 gets mapped to 100000) and RTS-CTS enabled.  */
-
+/*
+ * Setup for the HE-TIRA1 device, which requires hardwired baudrate
+ * (38400 gets mapped to 100000) and RTS-CTS enabled.
+ */
 static void ftdi_HE_TIRA1_setup(struct ftdi_private *priv)
 {
 	priv->flags |= ASYNC_SPD_CUST;
@@ -2259,10 +2261,9 @@ static void ftdi_HE_TIRA1_setup(struct ftdi_private *priv)
  */
 static int ndi_latency_timer = 1;
 
-/* Setup for the NDI FTDI-based USB devices, which requires hardwired
+/*
+ * Setup for the NDI FTDI-based USB devices, which requires hardwired
  * baudrate (19200 gets mapped to 1200000).
- *
- * Called from usbserial:serial_probe.
  */
 static int ftdi_NDI_device_setup(struct usb_serial *serial)
 {
-- 
2.51.0


