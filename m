Return-Path: <linux-kernel+bounces-892943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A8CC462BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4CD64E7D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5083730B50B;
	Mon, 10 Nov 2025 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3u7gDaU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9424D3093A5;
	Mon, 10 Nov 2025 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773292; cv=none; b=LXmO9xlVqXl1T92pM1cUaHuPXfeYi/Adv5koTpccLGjqfKf65V4gmcl2Hu5xCSy59lKF9LgyITFdlH2VvXkJU5CWeo4Irn7W/GzaI0e9qYPUYR+4OnfLnHN3lxjJROUYn2ZmHFGI5Czz9ZoCEzHYAxiqldtoMlSDQGjRk56o12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773292; c=relaxed/simple;
	bh=N17Ib8bb3w21sz9mn5ucm905LTujMgnmC5VTAxmFFLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgrbq/Czgrpzsh6YPhqbG1HQpTLbnUFPPd+6u+TtTIJwfZ5BEwTy1Tv2glrGc4wa5t/VJU0KfgQ+ABWZjZIwCY0gQNt1whW0HgxvJa2KinbSljp4iebkqx/8babxa37W7H+6kTu3MwfT5tqvhg+aeHCe8kLHNObpEpPR6L/KtjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3u7gDaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18132C19422;
	Mon, 10 Nov 2025 11:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762773292;
	bh=N17Ib8bb3w21sz9mn5ucm905LTujMgnmC5VTAxmFFLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3u7gDaUFPY1S8ybG63jNv6bfTlkPKZ9J/HjsL6EFTaRHz5VUB6e6GkrC8GWjzpbD
	 NLmuZ/E6RgyhFzk7jbJYSdYGexz3WQ0e8IjKW8y0naTNn5cqY3uXHjyWtPfsvbi3en
	 OC51wLE3m7/SsNFM6sL8JBvJUjikNYtCS8SYKZSQtcLFoLLDiQ0c6yd82iSy5/Fz4R
	 wqu6jnBCytokO8uWUUL/YHfU6jY9T/XJGpGcQa209ZUlJhSbA5Mtx1MRz+AnwU97N6
	 gwjlMztZKPoes7f3046ZlCPNm3q6B7Xd0oDYV9fTmUXCpXwdCMbLiHs2WTnza0+GhR
	 s736j2pcBFgCw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vIPrI-0000000007d-1bH9;
	Mon, 10 Nov 2025 12:14:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ryan Mann <rmann@ndigital.com>,
	Andreas Messer <andi@bastelmap.de>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] USB: serial: ftdi_sio: rewrite 8u2232c quirk
Date: Mon, 10 Nov 2025 12:12:07 +0100
Message-ID: <20251110111212.32702-4-johan@kernel.org>
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

Rewrite the 8u2232c quirk to avoid the manufacturer and product string
comparisons for the second port which will always be bound.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index a9d3451cd628..dd03d9458441 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2303,16 +2303,21 @@ static int ftdi_jtag_probe(struct usb_serial *serial)
 
 static int ftdi_8u2232c_probe(struct usb_serial *serial)
 {
+	struct usb_interface *intf = serial->interface;
 	struct usb_device *udev = serial->dev;
+	int ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
 
-	if (udev->manufacturer && !strcmp(udev->manufacturer, "CALAO Systems"))
-		return ftdi_jtag_probe(serial);
+	if (ifnum == 0) {
+		if (udev->manufacturer &&
+				!strcmp(udev->manufacturer, "CALAO Systems"))
+			return -ENODEV;
 
-	if (udev->product &&
-		(!strcmp(udev->product, "Arrow USB Blaster") ||
-		 !strcmp(udev->product, "BeagleBone/XDS100V2") ||
-		 !strcmp(udev->product, "SNAP Connect E10")))
-		return ftdi_jtag_probe(serial);
+		if (udev->product &&
+				(!strcmp(udev->product, "Arrow USB Blaster") ||
+				 !strcmp(udev->product, "BeagleBone/XDS100V2") ||
+				 !strcmp(udev->product, "SNAP Connect E10")))
+			return -ENODEV;
+	}
 
 	return 0;
 }
-- 
2.51.0


