Return-Path: <linux-kernel+bounces-890872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1678AC41408
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C593B7AC1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0803C33A030;
	Fri,  7 Nov 2025 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="QkAu5WsZ"
Received: from mx13.kaspersky-labs.com (mx13.kaspersky-labs.com [91.103.66.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B50156661;
	Fri,  7 Nov 2025 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539407; cv=none; b=LBOGYaI5OO7Es+d8hlzHqHH5EgOzDoeR5dFa96jog2iFxigUud/WcoDFr19lyYxOY9v1STsBXcWTj/5e7/n2HaoKFfku9l6HswPCcpLGJxdbHWK4f1WCnm5OgDUBLgIIWlgcn/aqcSFR57S6XYi/tEFUJyOFfOjs6Vah3iUCI1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539407; c=relaxed/simple;
	bh=ndFuoBgzAEtJzWu1RzN/QKCBDX2vUxBDOj01h5OQs+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDcX3wXw3y8b53ukruWQO/87ZQXKxS5svch/6pdOpQuiybGlnz2NMyTDWzIqNozkwXrEiCvtZj5dTcXTiMdm/iD1b4hHakN9uPX5Q70HMcxDN2THvCVsQCNLV0/WPq8qjx23D8ln7g9+d1EszpOJRa5BRtMrZqGWmMLwDzlczMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=QkAu5WsZ; arc=none smtp.client-ip=91.103.66.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1762539403;
	bh=u0WWEeIw1GkNNwwcBS69Y9DGaZ234QeUBpcIVueR8D0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=QkAu5WsZoAs23+bCVrZ/ZT4oVb/i3oGXAPHAkhB0YrwLaKPkVFfuwQOzWBDyhgACW
	 300Qi8dWReWUU11Plt6ZTj4i6dRJyYmn5g6XTBWZiU/bVirKS8aY7wvwneZhR+bb/H
	 EejpM390Lm2tqaOp0tnzrEHNTw6OaAU9HCj3U27w5BUbDgSECoUD/jevcV0NzexttJ
	 Lg5JTT30ZOPkgXUSnI9IAyK9oBmnukNUa6r3sSd/lo1UTe5PYHyaRtxIi0xdFwc4rb
	 VvQq5Tg26HjD8BtVlIPBDBcRRbsjnIW8+C1CUGaFBe8zgHzsxKRCJmi7xvQMXG4FTF
	 LvHfekMGJEAKQ==
Received: from relay13.kaspersky-labs.com (localhost [127.0.0.1])
	by relay13.kaspersky-labs.com (Postfix) with ESMTP id 1B5B73E262D;
	Fri,  7 Nov 2025 21:16:43 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub13.kaspersky-labs.com (Postfix) with ESMTPS id 684BC3E2806;
	Fri,  7 Nov 2025 21:16:42 +0300 (MSK)
Received: from Nalivayko.avp.ru (10.16.105.14) by HQMAILSRV3.avp.ru
 (10.64.57.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 7 Nov
 2025 21:16:39 +0300
From: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>
To: <linux-media@vger.kernel.org>
CC: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Michael Krufky <mkrufky@linuxtv.org>
Subject: [PATCH v2 1/2] media: dvb-usb-v2: add device init_ready flag
Date: Fri, 7 Nov 2025 21:16:22 +0300
Message-ID: <20251107181623.2139080-2-Sergey.Nalivayko@kaspersky.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251107181623.2139080-1-Sergey.Nalivayko@kaspersky.com>
References: <20251107181623.2139080-1-Sergey.Nalivayko@kaspersky.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV3.avp.ru (10.64.57.53) To HQMAILSRV3.avp.ru
 (10.64.57.53)
X-KSE-ServerInfo: HQMAILSRV3.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/07/2025 18:01:40
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 197893 [Nov 07 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Sergey.Nalivayko@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 75 0.3.75
 aab2175a55dcbd410b25b8694e49bbee3c09cdde
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: kaspersky.com:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/07/2025 18:04:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/7/2025 4:59:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/11/07 16:52:00 #27893595
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

The current implementation of dvb-usb-v2 initializes device in
dvb_usbv2_probe() while making it immediately available for use in the I2C,
Remote Control, demux and potentially other kernel subsystems before
the driver has fully completed initialization. As a result, the device
becomes accessible through these subsystem interfaces prematurely,
allowing to invoke read/write operations on the device before it is
fully initialized.

Introduce an atomic init_ready flag in struct dvb_usb_device for
the DVB-USB-V2 driver.

Allow driver code to check this flag before performing actions
that access device state (for example I2C reads) which may race
with device initialization.

Signed-off-by: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>
---
 drivers/media/usb/dvb-usb-v2/dvb_usb.h      | 4 ++++
 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/dvb_usb.h b/drivers/media/usb/dvb-usb-v2/dvb_usb.h
index ecdc20d45132..d4c22f979abd 100644
--- a/drivers/media/usb/dvb-usb-v2/dvb_usb.h
+++ b/drivers/media/usb/dvb-usb-v2/dvb_usb.h
@@ -365,6 +365,7 @@ struct dvb_usb_adapter {
  * @usb_mutex: mutex for usb control messages
  * @i2c_mutex: mutex for i2c-transfers
  * @i2c_adap: device's i2c-adapter
+ * @init_ready: set when the device is initialized
  * @adapter: adapters
  * @rc_dev: rc device for the remote control
  * @rc_phys: rc path
@@ -389,6 +390,9 @@ struct dvb_usb_device {
 	struct mutex i2c_mutex;
 	struct i2c_adapter i2c_adap;
 
+	/* Check in drivers to prevent read from uninitialized device */
+	atomic_t init_ready;
+
 	struct dvb_usb_adapter adapter[MAX_NO_OF_ADAPTER_PER_DEVICE];
 
 	/* remote control */
diff --git a/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c b/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
index f1c79f351ec8..d1cd68f242cc 100644
--- a/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
+++ b/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
@@ -988,6 +988,8 @@ int dvb_usbv2_probe(struct usb_interface *intf,
 exit:
 	usb_set_intfdata(intf, d);
 
+	atomic_set(&d->init_ready, 1);
+
 	return 0;
 err_free_all:
 	dvb_usbv2_exit(d);
@@ -1012,6 +1014,8 @@ void dvb_usbv2_disconnect(struct usb_interface *intf)
 	dev_dbg(&d->udev->dev, "%s: bInterfaceNumber=%d\n", __func__,
 			intf->cur_altsetting->desc.bInterfaceNumber);
 
+	atomic_set(&d->init_ready, 0);
+
 	if (d->props->exit)
 		d->props->exit(d);
 
-- 
2.39.5


