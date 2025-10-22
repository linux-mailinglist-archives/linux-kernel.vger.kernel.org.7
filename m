Return-Path: <linux-kernel+bounces-865355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D92BFCE1D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D023AAB84
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA7931283D;
	Wed, 22 Oct 2025 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po78gJQb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A12934D4F4;
	Wed, 22 Oct 2025 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146814; cv=none; b=jsohzrR2B5xoYPMbsWuCS+tayeuhPsyrLkJvo2cDsQtrfUobkBD+LmJWsUrKUaPdwy89OjWp/QxgGhGGJGXOk7CIz2FarU0l4+j+wu7xABSFs9mUYGrD+V8oZqq4Fh8QnUIQr9FSTimfyvJ1zrZMfOU3I2Bm5mx/Z02JFRPvl/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146814; c=relaxed/simple;
	bh=4QXspED8JrnEGsVaasD9a+i+F8oDDicgcZNuwSuqeIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fr1GFB4UGvBUvHV541mBlUFozSqX1pSyC5l5EXMddx/FpzRkG9lDinkw8+ciQxpPrLx63K676EJIipKQvgiQqqDzrobmHZUETC2Fok0HCXemURtM0dNWtdV2S/DZ8nH6Z9KQ/5MO22nKrIKnSBiqU5w2C3FNauxNCs8b0lUROKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po78gJQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB5AC116B1;
	Wed, 22 Oct 2025 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761146813;
	bh=4QXspED8JrnEGsVaasD9a+i+F8oDDicgcZNuwSuqeIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Po78gJQbmTgX01fuV2umKC9/FhPJSCs1Tx87dSH+MPLw8bkJo9VREBHfehj0Yqeem
	 CGDmvRsomoskE1xaCrF7W/PXDnovkJsb44+EC+MHqAeMNlV/C/QT2YjR+dmMx/ZvFW
	 pmZlTqwZB61vo5A/cqHu1IffbJF3gyWrnGharryLFtmtE6ssm1pm8eNRZpzFXlXW4N
	 rGEeCsN7unDGEhPOQI9+Z3CWXz1SL0r8HVGcSW12g7jIXueW8rEwkVKDkCbt7iEWTf
	 3QZaF0R/MNeFPeG00DhdIgm+ur07Wz/jDDWf8fLOI5gLGGrHRPAkpOBmLgOzLKLNdg
	 MF/a9sye5MQrg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vBajs-000000006JP-059G;
	Wed, 22 Oct 2025 17:27:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] USB: serial: kobil_sct: clean up device type checks
Date: Wed, 22 Oct 2025 17:26:37 +0200
Message-ID: <20251022152640.24212-6-johan@kernel.org>
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

Clean up the driver device type checks by moving logical operators to
the previous line and using consistent indentation of continuation
lines.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/kobil_sct.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
index b8169783f6f0..e1015cab2770 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -239,8 +239,8 @@ static int kobil_open(struct tty_struct *tty, struct usb_serial_port *port)
 		dev_dbg(dev, "%s - Send reset_all_queues URB returns: %i\n", __func__, result);
 	}
 	if (priv->device_type == KOBIL_USBTWIN_PRODUCT_ID ||
-	    priv->device_type == KOBIL_ADAPTER_B_PRODUCT_ID ||
-	    priv->device_type == KOBIL_KAAN_SIM_PRODUCT_ID) {
+			priv->device_type == KOBIL_ADAPTER_B_PRODUCT_ID ||
+			priv->device_type == KOBIL_KAAN_SIM_PRODUCT_ID) {
 		/* start reading (Adapter B 'cause PNP string) */
 		result = usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL);
 		dev_dbg(dev, "%s - Send read URB returns: %i\n", __func__, result);
@@ -318,9 +318,10 @@ static int kobil_write(struct tty_struct *tty, struct usb_serial_port *port,
 	if (((priv->device_type != KOBIL_ADAPTER_B_PRODUCT_ID) && (priv->filled > 2) && (priv->filled >= (priv->buf[1] + 3))) ||
 	     ((priv->device_type == KOBIL_ADAPTER_B_PRODUCT_ID) && (priv->filled > 3) && (priv->filled >= (priv->buf[2] + 4)))) {
 		/* stop reading (except TWIN and KAAN SIM) */
-		if ((priv->device_type == KOBIL_ADAPTER_B_PRODUCT_ID)
-			|| (priv->device_type == KOBIL_ADAPTER_K_PRODUCT_ID))
+		if (priv->device_type == KOBIL_ADAPTER_B_PRODUCT_ID ||
+				priv->device_type == KOBIL_ADAPTER_K_PRODUCT_ID) {
 			usb_kill_urb(port->interrupt_in_urb);
+		}
 
 		todo = priv->filled - priv->cur_pos;
 
@@ -347,7 +348,7 @@ static int kobil_write(struct tty_struct *tty, struct usb_serial_port *port,
 
 		/* start reading (except TWIN and KAAN SIM) */
 		if (priv->device_type == KOBIL_ADAPTER_B_PRODUCT_ID ||
-			priv->device_type == KOBIL_ADAPTER_K_PRODUCT_ID) {
+				priv->device_type == KOBIL_ADAPTER_K_PRODUCT_ID) {
 			result = usb_submit_urb(port->interrupt_in_urb,
 					GFP_ATOMIC);
 			dev_dbg(&port->dev, "%s - Send read URB returns: %i\n", __func__, result);
@@ -373,8 +374,8 @@ static int kobil_tiocmget(struct tty_struct *tty)
 	int transfer_buffer_length = 8;
 
 	priv = usb_get_serial_port_data(port);
-	if (priv->device_type == KOBIL_USBTWIN_PRODUCT_ID
-			|| priv->device_type == KOBIL_KAAN_SIM_PRODUCT_ID) {
+	if (priv->device_type == KOBIL_USBTWIN_PRODUCT_ID ||
+			priv->device_type == KOBIL_KAAN_SIM_PRODUCT_ID) {
 		/* This device doesn't support ioctl calls */
 		return -EINVAL;
 	}
@@ -423,8 +424,8 @@ static int kobil_tiocmset(struct tty_struct *tty,
 	u16 val = 0;
 
 	priv = usb_get_serial_port_data(port);
-	if (priv->device_type == KOBIL_USBTWIN_PRODUCT_ID
-		|| priv->device_type == KOBIL_KAAN_SIM_PRODUCT_ID) {
+	if (priv->device_type == KOBIL_USBTWIN_PRODUCT_ID ||
+			priv->device_type == KOBIL_KAAN_SIM_PRODUCT_ID) {
 		/* This device doesn't support ioctl calls */
 		return -EINVAL;
 	}
-- 
2.49.1


