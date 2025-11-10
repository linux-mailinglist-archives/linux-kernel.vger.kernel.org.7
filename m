Return-Path: <linux-kernel+bounces-892948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19907C462EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449291896A84
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878C130E83F;
	Mon, 10 Nov 2025 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZAcRRrm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD0E309EF4;
	Mon, 10 Nov 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773293; cv=none; b=YISm0M9BFlamacFwAsVp4jEk7KfvrONtf3Qf4e9tHKzSR32tZ9WfVERd7h2k+LK3m7+iLxnPhDJ0295va+D/u7dMRePdlUdOoccXcDiL8hhtVV4xe3Dp5ScA+wvdNd8nokdicF9yTuGTGVKbtuQvbgtg8ahjJx9yFlCIvtQZkEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773293; c=relaxed/simple;
	bh=RidSro2FqSuYFKqagjZJtSqsh9yhbofm+SRtOM9H/RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqO/hEtR3lefPB0rJC5EV9ijnOrQKI/+zGTSCp8Cr5xrO3PnedulXaE5p7ldoY8YKzHCZkC8p4WpEhU+NFBRFEtmrf4jtfOAT9WzBtqiZQ20p+gSto+RPhHoJ0ZAPdzUpzRAvVEelNCtkG9rxEa4EPUKii+CPWQT7VdXmP8YcwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZAcRRrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F627C2BCB8;
	Mon, 10 Nov 2025 11:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762773292;
	bh=RidSro2FqSuYFKqagjZJtSqsh9yhbofm+SRtOM9H/RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZAcRRrmW5b1kM9fzcTZ4SealeTGtjMaBjHPaw/ZZ9b9dETWfLKw9XczMX4KX6eql
	 g4cwtw4fZJ9i59UA7l5CV/1vwhoSw/ZWO7g7PfjYxWMbXD7uFfRXfrE2mYeLUCohe2
	 BKLTn8tMnmN9DEVhPEeLdBZZSwldi1D9s/1Nsbcovb1bvyajOyasw7LIGHUIEKi+QO
	 14fcUIV5zsy6hBYC3oJvCPGGWgVxFHxZmji3JrVdeMOm1JJFbA7MXXY4idlEkOhN/X
	 mdgw3xTpYaBYPexU2HYP0yyqzM/BILBQfLA3Hy8DYmUj8Rs6RdNyDI1bxWH50eFuH7
	 ec0j12v1aUMOQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vIPrI-0000000007s-3F0c;
	Mon, 10 Nov 2025 12:14:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ryan Mann <rmann@ndigital.com>,
	Andreas Messer <andi@bastelmap.de>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] USB: serial: ftdi_sio: drop NDI quirk module parameter
Date: Mon, 10 Nov 2025 12:12:12 +0100
Message-ID: <20251110111212.32702-9-johan@kernel.org>
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

NDI devices have been using a latency timer of 1 ms since commit
b760dac290c3 ("USB: ftdi: support NDI devices"), which also added a
vendor specific module parameter that could be used to override the
default value for these devices.

Module parameters should generally be avoided as they apply to all
devices managed by a driver and vendor specific hacks should be kept out
of mainline.

Drop the module parameter in favour of the generic sysfs interface for
setting the latency timer (e.g. using udev rules) while keeping the
default 1 ms timer for NDI devices.

Note that there seems to be no (correct) public references to the module
parameter and most likely no one is using it.

Cc: Ryan Mann <rmann@ndigital.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 41 +++--------------------------------
 1 file changed, 3 insertions(+), 38 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 26f1260ff995..fe2f21d85737 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -107,7 +107,6 @@ struct ftdi_quirk {
 };
 
 static int   ftdi_jtag_probe(struct usb_serial *serial);
-static int   ftdi_ndi_probe(struct usb_serial *serial);
 static int   ftdi_stmclite_probe(struct usb_serial *serial);
 static int   ftdi_8u2232c_probe(struct usb_serial *serial);
 static void  ftdi_usb_uirt_setup(struct ftdi_private *priv);
@@ -118,7 +117,6 @@ static const struct ftdi_quirk ftdi_jtag_quirk = {
 };
 
 static const struct ftdi_quirk ftdi_ndi_quirk = {
-	.probe	= ftdi_ndi_probe,
 };
 
 static const struct ftdi_quirk ftdi_usb_uirt_quirk = {
@@ -2205,7 +2203,9 @@ static int ftdi_port_probe(struct usb_serial_port *port)
 		goto err_free;
 
 	ftdi_set_max_packet_size(port);
-	if (read_latency_timer(port) < 0)
+	if (quirk == &ftdi_ndi_quirk)
+		priv->latency = 1;
+	else if (read_latency_timer(port) < 0)
 		priv->latency = 16;
 	write_latency_timer(port);
 
@@ -2247,38 +2247,6 @@ static void ftdi_he_tira1_setup(struct ftdi_private *priv)
 	priv->force_rtscts = 1;
 }
 
-/*
- * Module parameter to control latency timer for NDI FTDI-based USB devices.
- * If this value is not set in /etc/modprobe.d/ its value will be set
- * to 1ms.
- */
-static int ndi_latency_timer = 1;
-
-/*
- * Setup for the NDI FTDI-based USB devices, which requires hardwired
- * baudrate (19200 gets mapped to 1200000).
- */
-static int ftdi_ndi_probe(struct usb_serial *serial)
-{
-	struct usb_device *udev = serial->dev;
-	int latency = ndi_latency_timer;
-
-	if (latency == 0)
-		latency = 1;
-	if (latency > 99)
-		latency = 99;
-
-	dev_dbg(&udev->dev, "%s setting NDI device latency to %d\n", __func__, latency);
-	dev_info(&udev->dev, "NDI device with a latency value of %d\n", latency);
-
-	/* FIXME: errors are not returned */
-	usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-				FTDI_SIO_SET_LATENCY_TIMER_REQUEST,
-				FTDI_SIO_SET_LATENCY_TIMER_REQUEST_TYPE,
-				latency, 0, NULL, 0, WDR_TIMEOUT);
-	return 0;
-}
-
 /*
  * First port on JTAG adaptors such as Olimex arm-usb-ocd or the FIC/OpenMoko
  * Neo1973 Debug Board is reserved for JTAG interface and can be accessed from
@@ -2906,6 +2874,3 @@ module_usb_serial_driver(serial_drivers, id_table_combined);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
-
-module_param(ndi_latency_timer, int, 0644);
-MODULE_PARM_DESC(ndi_latency_timer, "NDI device latency timer override");
-- 
2.51.0


