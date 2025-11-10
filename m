Return-Path: <linux-kernel+bounces-892946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F65DC462F1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3EF3A75C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A36A30E83C;
	Mon, 10 Nov 2025 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVmHu02Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC423309EF1;
	Mon, 10 Nov 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773293; cv=none; b=Y6BiOK0RGmosh/CD1Y4I2XR4V8TBkE97J3vimV6+FHxqBze9XwQgZSVzFAKXWnVE6nJXDdcQUdV/y5uh4TR9qQFMgh2CMN0TZJW9WrQfhUPEpitHT+O5rGznjs5RnFI+MBGf9NmXlCYMFp12Gp2jdDiVRl2KcYyv7tYOOQ3PB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773293; c=relaxed/simple;
	bh=0UwlUDgT3perp5FbE2RK+9MjtXHhAakco6uZEwvthyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBUto7yLtzpOqotchlwwtQmxGLF8ax1HiDAAYxvWTVjad0mJmvQ7KhrDHt47syl6esknd8TuDu7UonybEXhJHpIgo0JvJTKKsJZeLXzhlL9KFgDnYK1Ce/EsWIz3TX5c6KaSqLbi6UQUFci72a1/rp77XKYO4splsiHnbvJyp1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVmHu02Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE7AC19425;
	Mon, 10 Nov 2025 11:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762773292;
	bh=0UwlUDgT3perp5FbE2RK+9MjtXHhAakco6uZEwvthyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GVmHu02ZtLMlTFpax38NpmDH1B68RQOGCocQlbU78dcWSLwPWtYfrC/7sivg9Qi08
	 fbaGlKtaSxdO3jFBqcvvk2jyUCScIvGG4EePAvPEgP/hIpT66S9rdi+jSDrsl3myot
	 D5Z0I1B15sesDn6sxX6ZZPTLZylwTMFYlbCSkjhAqkmRYEW82t3myvi7wLOZST9KPA
	 65JegDTsFRXZ4qHXRitx5PSuZ5D6AZpkL/Ep7oJ8s8lu0VexFlZ+h663KEAW3zUCyA
	 Ql+iwPl8BP5iENkmyVtXoWp6UKtyPVLYbTP6IdOGY1tSc7NeXfBeAjfJRN8BfWt9Pr
	 aZd3whd/8qqmQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vIPrI-0000000007j-2G37;
	Mon, 10 Nov 2025 12:14:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ryan Mann <rmann@ndigital.com>,
	Andreas Messer <andi@bastelmap.de>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] USB: serial: ftdi_sio: rename quirk symbols
Date: Mon, 10 Nov 2025 12:12:09 +0100
Message-ID: <20251110111212.32702-6-johan@kernel.org>
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

Use lower case names for the quirk symbols and rename the NDI quirk
probe function for consistency.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 40 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 75f354ef6095..d583b39b64cc 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -107,26 +107,26 @@ struct ftdi_quirk {
 };
 
 static int   ftdi_jtag_probe(struct usb_serial *serial);
-static int   ftdi_NDI_device_setup(struct usb_serial *serial);
+static int   ftdi_ndi_probe(struct usb_serial *serial);
 static int   ftdi_stmclite_probe(struct usb_serial *serial);
 static int   ftdi_8u2232c_probe(struct usb_serial *serial);
-static void  ftdi_USB_UIRT_setup(struct ftdi_private *priv);
-static void  ftdi_HE_TIRA1_setup(struct ftdi_private *priv);
+static void  ftdi_usb_uirt_setup(struct ftdi_private *priv);
+static void  ftdi_he_tira1_setup(struct ftdi_private *priv);
 
 static const struct ftdi_quirk ftdi_jtag_quirk = {
 	.probe	= ftdi_jtag_probe,
 };
 
-static const struct ftdi_quirk ftdi_NDI_device_quirk = {
-	.probe	= ftdi_NDI_device_setup,
+static const struct ftdi_quirk ftdi_ndi_quirk = {
+	.probe	= ftdi_ndi_probe,
 };
 
-static const struct ftdi_quirk ftdi_USB_UIRT_quirk = {
-	.port_probe = ftdi_USB_UIRT_setup,
+static const struct ftdi_quirk ftdi_usb_uirt_quirk = {
+	.port_probe = ftdi_usb_uirt_setup,
 };
 
-static const struct ftdi_quirk ftdi_HE_TIRA1_quirk = {
-	.port_probe = ftdi_HE_TIRA1_setup,
+static const struct ftdi_quirk ftdi_he_tira1_quirk = {
+	.port_probe = ftdi_he_tira1_setup,
 };
 
 static const struct ftdi_quirk ftdi_stmclite_quirk = {
@@ -590,9 +590,9 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(OCT_VID, OCT_US101_PID) },
 	{ USB_DEVICE(OCT_VID, OCT_DK201_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_HE_TIRA1_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_HE_TIRA1_quirk },
+		.driver_info = (kernel_ulong_t)&ftdi_he_tira1_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_USB_UIRT_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_USB_UIRT_quirk },
+		.driver_info = (kernel_ulong_t)&ftdi_usb_uirt_quirk },
 	{ USB_DEVICE(FTDI_VID, PROTEGO_SPECIAL_1) },
 	{ USB_DEVICE(FTDI_VID, PROTEGO_R2X0) },
 	{ USB_DEVICE(FTDI_VID, PROTEGO_SPECIAL_3) },
@@ -792,17 +792,17 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(FTDI_VID, FTDI_TACTRIX_OPENPORT_13U_PID) },
 	{ USB_DEVICE(ELEKTOR_VID, ELEKTOR_FT323R_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_NDI_HUC_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
+		.driver_info = (kernel_ulong_t)&ftdi_ndi_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_NDI_SPECTRA_SCU_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
+		.driver_info = (kernel_ulong_t)&ftdi_ndi_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_NDI_FUTURE_2_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
+		.driver_info = (kernel_ulong_t)&ftdi_ndi_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_NDI_FUTURE_3_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
+		.driver_info = (kernel_ulong_t)&ftdi_ndi_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_NDI_AURORA_SCU_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
+		.driver_info = (kernel_ulong_t)&ftdi_ndi_quirk },
 	{ USB_DEVICE(FTDI_NDI_VID, FTDI_NDI_EMGUIDE_GEMINI_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
+		.driver_info = (kernel_ulong_t)&ftdi_ndi_quirk },
 	{ USB_DEVICE(TELLDUS_VID, TELLDUS_TELLSTICK_PID) },
 	{ USB_DEVICE(NOVITUS_VID, NOVITUS_BONO_E_PID) },
 	{ USB_DEVICE(FTDI_VID, RTSYSTEMS_USB_VX8_PID) },
@@ -2235,7 +2235,7 @@ static int ftdi_port_probe(struct usb_serial_port *port)
  * Setup for the USB-UIRT device, which requires hardwired baudrate
  * (38400 gets mapped to 312500).
  */
-static void ftdi_USB_UIRT_setup(struct ftdi_private *priv)
+static void ftdi_usb_uirt_setup(struct ftdi_private *priv)
 {
 	priv->flags |= ASYNC_SPD_CUST;
 	priv->custom_divisor = 77;
@@ -2246,7 +2246,7 @@ static void ftdi_USB_UIRT_setup(struct ftdi_private *priv)
  * Setup for the HE-TIRA1 device, which requires hardwired baudrate
  * (38400 gets mapped to 100000) and RTS-CTS enabled.
  */
-static void ftdi_HE_TIRA1_setup(struct ftdi_private *priv)
+static void ftdi_he_tira1_setup(struct ftdi_private *priv)
 {
 	priv->flags |= ASYNC_SPD_CUST;
 	priv->custom_divisor = 240;
@@ -2265,7 +2265,7 @@ static int ndi_latency_timer = 1;
  * Setup for the NDI FTDI-based USB devices, which requires hardwired
  * baudrate (19200 gets mapped to 1200000).
  */
-static int ftdi_NDI_device_setup(struct usb_serial *serial)
+static int ftdi_ndi_probe(struct usb_serial *serial)
 {
 	struct usb_device *udev = serial->dev;
 	int latency = ndi_latency_timer;
-- 
2.51.0


