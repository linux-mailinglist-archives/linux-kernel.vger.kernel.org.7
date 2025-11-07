Return-Path: <linux-kernel+bounces-890678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC05EC40A65
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3E31892960
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C7732E13C;
	Fri,  7 Nov 2025 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="PhooyY3I";
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="bPqVF78q"
Received: from mailhub9-fb.kaspersky-labs.com (mailhub9-fb.kaspersky-labs.com [195.122.169.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088838DE1;
	Fri,  7 Nov 2025 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.122.169.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530345; cv=none; b=aG4bmCM0G3zoX08Fnb6I/CRYk/lcgswcbTBu5e8RsE7vh5JoPKyc6gX1AydCZMfefZzW5owGAMZb0RBIjJF535P4LdLXfUvm25nRkkZ7BiqigdwtNp0k3F0a44Gr+qrhGiYG9XYAlyLp5QSEEuchuL5HmDUpaQft4l1jODgY744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530345; c=relaxed/simple;
	bh=nsCJ6a381lZvXja5H/Dqoj6c/Rc2k2EOWhfoNqA+Fw0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsBqjNmVss9RxJCvkqBGFf9RSDP0Xlq6WJxGnVcxnTT5uER7EgpPpZqCKV6Yz4q2YSZAsNSyH099Lg62aca48gk0CrNTqcxFEbW0sKLjl/ki8kXWT4pFoEezMQ5wjqs6xHFnrIIWFINXYfJtHMW1ybOAan6S9G6OgPyvSRaWmyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=PhooyY3I; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=bPqVF78q; arc=none smtp.client-ip=195.122.169.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1762530340;
	bh=JInZQS1g+rhl7OoPvdNtZ79da3janGd3rLGqkYOhSjM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=PhooyY3I2ZFBPyJLUgb6e0B3olAAzgZoMuTYIaTbXVRnpHXGYY/9JwjsE1nfZgcJ6
	 MEYba8EF+NK5F2tgVcGn1bVBCjV2d55I5OA8864saCmwxWz22WLAarZqmfa6F2vRVP
	 k8u+eQbqz6y0YUqdCXDB+kBVzTJIr2inhCHzb9Fs50H6ENvxQ1n2dhOUFCbPX8/WWR
	 LMjCvqZI3u21MvQURxy8bjjy7D29gJMbNaWbLPRUyTTaW7vWBfaDonMRMvbPVpy52q
	 A3SpPvPbJ5XnaLjFm24QQDHwTgs3ErRw7VpCg4Ez1kcSUh/UexGDrezl5858CzyYKP
	 TLxGxjHTOkc7w==
Received: from mailhub9-fb.kaspersky-labs.com (localhost [127.0.0.1])
	by mailhub9-fb.kaspersky-labs.com (Postfix) with ESMTP id DE68790122D;
	Fri,  7 Nov 2025 18:45:40 +0300 (MSK)
Received: from mx12.kaspersky-labs.com (mx12.kaspersky-labs.com [91.103.66.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "mx12.kaspersky-labs.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub9-fb.kaspersky-labs.com (Postfix) with ESMTPS id A96F39000C3;
	Fri,  7 Nov 2025 18:45:40 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1762530331;
	bh=JInZQS1g+rhl7OoPvdNtZ79da3janGd3rLGqkYOhSjM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=bPqVF78q98WTcYGobI9hLzSoNdn5zviMygQrA9ngaZYOSLlQA5sikJWWa5zpg4E0B
	 ACj7yncowQZzWqgTZZDtkYVS94wrRdepRQeHeglXaUVlI6Xmlb349h7tumBEaLKrk5
	 +AFbYF0NTwT5Xp3SviZJDu/tDjYF6EiUBYx1lbhToi+4TxB0Ixjo/vO1cx517LV/S1
	 b4c4tJmmmb04j/4+7Vy0MmG16b94P6VWP1oP4pBkrM4CS/3mRlG3m4JX0hzKXac5EO
	 khxpapk8r935uUCT372FyxSuPHRNp7wxHhEnaeWx5/06Mchb7/t2Z6a2R27JiFijJe
	 udjvvKT+e1a5w==
Received: from relay12.kaspersky-labs.com (localhost [127.0.0.1])
	by relay12.kaspersky-labs.com (Postfix) with ESMTP id 918DF5A197C;
	Fri,  7 Nov 2025 18:45:31 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub12.kaspersky-labs.com (Postfix) with ESMTPS id BAE7A5A4942;
	Fri,  7 Nov 2025 18:45:30 +0300 (MSK)
Received: from Nalivayko.avp.ru (10.16.105.14) by HQMAILSRV3.avp.ru
 (10.64.57.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 7 Nov
 2025 18:45:16 +0300
From: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>
To: <linux-media@vger.kernel.org>
CC: Nalivayko Sergey <Sergey.Nalivayko@kaspersky.com>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Michael Krufky <mkrufky@linuxtv.org>
Subject: [PATCH 1/2] media: dvb-usb-v2: add device init_ready flag
Date: Fri, 7 Nov 2025 18:44:25 +0300
Message-ID: <20251107154426.2116743-2-Sergey.Nalivayko@kaspersky.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251107154426.2116743-1-Sergey.Nalivayko@kaspersky.com>
References: <20251107154426.2116743-1-Sergey.Nalivayko@kaspersky.com>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/07/2025 15:33:04
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 197892 [Nov 07 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Sergey.Nalivayko@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 75 0.3.75
 aab2175a55dcbd410b25b8694e49bbee3c09cdde
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;kaspersky.com:7.1.1,5.0.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/07/2025 15:34:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/7/2025 12:14:00 PM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/11/07 15:09:00 #27893311
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
 drivers/media/usb/dvb-usb-v2/dvb_usb.h      | 3 +++
 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/dvb_usb.h b/drivers/media/usb/dvb-usb-v2/dvb_usb.h
index ecdc20d45132..ecb929e006ba 100644
--- a/drivers/media/usb/dvb-usb-v2/dvb_usb.h
+++ b/drivers/media/usb/dvb-usb-v2/dvb_usb.h
@@ -389,6 +389,9 @@ struct dvb_usb_device {
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


