Return-Path: <linux-kernel+bounces-892941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA40C462D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E9D188FB84
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FDD30ACFD;
	Mon, 10 Nov 2025 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xu4gUvaV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8897B221542;
	Mon, 10 Nov 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773292; cv=none; b=q+ycue6NytgGAShPI9XYVrPBdpfGQmUcsCfR/kqLvOebq+Z/bC25goOy8J/12ngrC8sQX8Bk3Wiaf7AiwFXzClKVK3vnk2AS2SkKY5wChJTpz6d22RXSo3CSwRJAyhx07xBOTjDQQceN4rbITlNKtrXs5N0EoCt8QhCains3Ip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773292; c=relaxed/simple;
	bh=kwQY3H5DoP/1fPz7GTUnd4gUvsw6u2ogPid7SVdDGFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6LEY5Wk3bpv7n0jU4K9pH4PEuEDwS/U0CLds2VV80TWaT703rvXYbOk+tnOFrLp1LJZMLSky5o0PKpJZLEN+LtEyvay0JDLGe49WMZ0XZ1/RXyKEv4LFfL1AbWqLJxdW9P5TpIXQvG5hwQy9hZpIRy1xqt3xnQdQSl9zucGfdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xu4gUvaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09854C19421;
	Mon, 10 Nov 2025 11:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762773292;
	bh=kwQY3H5DoP/1fPz7GTUnd4gUvsw6u2ogPid7SVdDGFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xu4gUvaVu8AgWziONxV9OsMhF43ktHbocnLyTcPaSL5H+my9xRlpRbNNFc4fMjNnY
	 0WgpeF935ouKDI+rKUJzoYteI6+8uC2y0u4FnPw+FrTt22h8aba52Aakl/5GZKvJ7+
	 BimZ3CBH980oSnVSqWDc22SyqDBIFQqynfsiQy8RbLlDuyfjrUFRe6SdUCbY5775Uj
	 wf33OCGvaOOKwrM9RgNr+oiVNmMX5yO7dXA0gkWRsuVzOOT4p8ZoXmyPl8I6HLNIy2
	 PjuRXy5PEuYZx+7LEvtFHO/aVYvgKOIQnK419LArDPf7T45bkPql9eApsf5cBuPJH2
	 NKwViQfWsbuJw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vIPrI-0000000007a-1Gn5;
	Mon, 10 Nov 2025 12:14:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ryan Mann <rmann@ndigital.com>,
	Andreas Messer <andi@bastelmap.de>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] USB: serial: ftdi_sio: silence jtag probe
Date: Mon, 10 Nov 2025 12:12:06 +0100
Message-ID: <20251110111212.32702-3-johan@kernel.org>
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

Probe of a device should generally be silent unless errors are
encountered.

Stop logging that the JTAG port is ignored when probing devices with
such a reserved port.

This also maintains consistency with devices that match on interface
number to avoid binding to reserved ports.

Note that the message is not even correct for the second port of the ST
Micro Connect Lite.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 9993a5123344..a9d3451cd628 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2295,10 +2295,8 @@ static int ftdi_jtag_probe(struct usb_serial *serial)
 	struct usb_interface *intf = serial->interface;
 	int ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
 
-	if (ifnum == 0) {
-		dev_info(&intf->dev, "Ignoring interface reserved for JTAG\n");
+	if (ifnum == 0)
 		return -ENODEV;
-	}
 
 	return 0;
 }
@@ -2331,10 +2329,8 @@ static int ftdi_stmclite_probe(struct usb_serial *serial)
 	struct usb_interface *intf = serial->interface;
 	int ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
 
-	if (ifnum < 2) {
-		dev_info(&intf->dev, "Ignoring interface reserved for JTAG\n");
+	if (ifnum < 2)
 		return -ENODEV;
-	}
 
 	return 0;
 }
-- 
2.51.0


