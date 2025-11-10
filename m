Return-Path: <linux-kernel+bounces-892947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADD8C462F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9B93BD97A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836DE307AD6;
	Mon, 10 Nov 2025 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8BXThbC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC506309EF2;
	Mon, 10 Nov 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773293; cv=none; b=dgA4jrlx3S+JCVr/lc/FUlsPq4Ig63Rh01ezJv6GTZLfhIhhAv1v3OuJeXTm/dgZx79b6fpRT2G0PfxA0q0AxtIsTHl7Qxpv/8H3UOo1hprF63fPHqKqiwlHmepu8ejr3AeBMahxV9dpL/+cmalz3ki1CCM+eKgWOQghAb8df68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773293; c=relaxed/simple;
	bh=ZzMXXcK2ibnaYB+vldrs9yutdNQe7KsNN4GFGYZ96ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPW24SdUAvTYzHw2R+O4BboGsq4j8mo1JuXH3fyfxGwFWUlT3qJg9okIJbizdoW4yaUg9zOsYn9cL0Yf8z+1McpgABfa7+CeRzAB/6Flo4RHlHSYXCQJL3ynaGg+ra67OE/NxdyMRT9FytPmU8Uhb4WlhicosXq5va+JihfKpmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8BXThbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D31C2BCB4;
	Mon, 10 Nov 2025 11:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762773292;
	bh=ZzMXXcK2ibnaYB+vldrs9yutdNQe7KsNN4GFGYZ96ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c8BXThbCKVWV5/Zw07Je5mYDHogxEPsM4KhwjjsDSrAxLRn53o8c9Mi1Zi6Gzlln6
	 LhTxp6T2XUHAL1G/gsdcOwP0WOomxLxirfdumUgpJ7JzCY5/9dkgaGU/nkumpPBw7j
	 g8q+RsS2Dnhp/OJmLVU7c2xAch3jPYu6XeCKYTJhdCVTWVwkJXS86zn2GEWvMwyJzp
	 QRntoor/5so31UUif5NkRT6sYtQBXOA+SJBPuvq1fGNp8g4s6QxpGxB2AnAOD+gZdJ
	 HrHcWHG7RH/s6Myt+rM45xyIAZDWr6bDyXvwj0Ffmvu0REEBGhjoavzIMeCLnmlcsZ
	 D6I3fkcHfnVlg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vIPrI-0000000007p-2uqR;
	Mon, 10 Nov 2025 12:14:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ryan Mann <rmann@ndigital.com>,
	Andreas Messer <andi@bastelmap.de>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] USB: serial: ftdi_sio: clean up NDI speed hack
Date: Mon, 10 Nov 2025 12:12:11 +0100
Message-ID: <20251110111212.32702-8-johan@kernel.org>
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

NDI devices remap the 19200 line speed to 1.2 Mbps.

Use the quirk pointer from the match table to enable the quirk instead
of comparing PIDs on every speed change.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index f5786689697c..26f1260ff995 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1247,6 +1247,7 @@ static int update_mctrl(struct usb_serial_port *port, unsigned int set,
 static u32 get_ftdi_divisor(struct tty_struct *tty,
 						struct usb_serial_port *port)
 {
+	const struct ftdi_quirk *quirk = usb_get_serial_data(port->serial);
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	struct device *dev = &port->dev;
 	u32 div_value = 0;
@@ -1306,17 +1307,8 @@ static u32 get_ftdi_divisor(struct tty_struct *tty,
 	case FT232R:
 	case FTX:
 		if (baud <= 3000000) {
-			u16 product_id = le16_to_cpu(
-				port->serial->dev->descriptor.idProduct);
-			if (((product_id == FTDI_NDI_HUC_PID)		||
-			     (product_id == FTDI_NDI_SPECTRA_SCU_PID)	||
-			     (product_id == FTDI_NDI_FUTURE_2_PID)	||
-			     (product_id == FTDI_NDI_FUTURE_3_PID)	||
-			     (product_id == FTDI_NDI_AURORA_SCU_PID)	||
-			     (product_id == FTDI_NDI_EMGUIDE_GEMINI_PID)) &&
-			    (baud == 19200)) {
+			if (quirk == &ftdi_ndi_quirk && baud == 19200)
 				baud = 1200000;
-			}
 			div_value = ftdi_232bm_baud_to_divisor(baud);
 		} else {
 			dev_dbg(dev, "%s - Baud rate too high!\n", __func__);
-- 
2.51.0


