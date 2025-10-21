Return-Path: <linux-kernel+bounces-863004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BF2BF6C50
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99BCA505607
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE03C3370FA;
	Tue, 21 Oct 2025 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="OHbYA/0v";
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="i1f5X8KM"
Received: from mailhub11-fb.kaspersky-labs.com (mailhub11-fb.kaspersky-labs.com [81.19.104.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F42E337113
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.104.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053259; cv=none; b=iG77FQTS3fP1Xudp/F8zhIgi0556q7YFntI6nJn5yzVmEU75mjTn1sN/8r0ZBjSxeQhGR+azG6xZokYfxlP8cexu+WqVsOwzT4vLDF9I07vGosWZWaxZEW9ys4ZiHXe6BuB0HuvWNCVS+P4XPf7N1J67GIXDf2Lnil8Jt3f0AQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053259; c=relaxed/simple;
	bh=IFOdNNDjqCDKwjLczwKxkaVfl6+h9/xu9tERcTtswZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZfEYWaKPspeypWFVOqjV6Y/vfpuJbmzFtWjr2mJuMzmzxidg87AwpYEFq9BFLoKYMG+SeTlg8QyRCStw/Svkzu6n7spOahrmo9KS15iPZE9pQ+cEj03EzbOTtjqVPVLfgIjhAsnMm0QmThJt82CbwBGvuIUfQ6JP8SROcFXVa5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=OHbYA/0v; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=i1f5X8KM; arc=none smtp.client-ip=81.19.104.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1761052646;
	bh=kz4mk2hoq8dtJYJ9cdE0KmjYVt5ckk4LauO3uUI1C9Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=OHbYA/0v8fCvW3SaF+xmEIOqllMfsTnj7tJlTmzwQfDBhCCv/d1A3Y1fB450OKWcl
	 3pEcpLbwkKvJV3wGCUHbLlnVjNp95k5sQeMWrEtLzGzrDSc3Dbo6De4FOfOYkJvjVk
	 TuOuaPsKT2W6hnDYyX8OG8yqJvWPWJ5pQzR2UCMRNtjg+MaaOrZUcabGcm65VrWlXf
	 lVgV/Toz3wH8wm0OD6v8Inw69T1mM7pnzjHq93yZvs2yuKXgVjdd7Tp7JSNUHkgbIu
	 kLD0qY2u+CY/Y20DW8GS/ygJkrknRdgXwQly+hn8CGQaHv1DwHF+9c+Zd+0UOZ0+Il
	 3zME2afbqrxNg==
Received: from mailhub11-fb.kaspersky-labs.com (localhost [127.0.0.1])
	by mailhub11-fb.kaspersky-labs.com (Postfix) with ESMTP id 2E9CAE80D7C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:17:26 +0300 (MSK)
Received: from mx13.kaspersky-labs.com (mx13.kaspersky-labs.com [91.103.66.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "mx13.kaspersky-labs.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub11-fb.kaspersky-labs.com (Postfix) with ESMTPS id DA65FE866FE
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:17:25 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1761052637;
	bh=kz4mk2hoq8dtJYJ9cdE0KmjYVt5ckk4LauO3uUI1C9Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=i1f5X8KMWv3SRjeWU/XaJnjB0KToHYyMyiCl8gK6W5Gk+WaThbYq45EYy+LzE1Meu
	 LgI6hVUbduOGu8fEEt8yc+ky3EkgFyqvX3b9UYpgycxcvtHfJlrXDm1RDLiRi8wys3
	 u5YZOBh6/6prqF6QcAkQmNRNAsWO9dljEmeCHd7XYMn5LeZ8aBVKw2vpHks/09UiMm
	 qas2qXDJtuyOT8aInFxCDuC6pGr6Yd8Ose9ZSuULdcttZ5xA6AGYvn70PGIf9CJCLb
	 nrM/HZlYTOtNxQyGQHZ5EW5JEicO0js4mAcKJQ4vWHSSQa6bOdTXipBEUtX3Va8hCQ
	 A1uEb1ELjYlRw==
Received: from relay13.kaspersky-labs.com (localhost [127.0.0.1])
	by relay13.kaspersky-labs.com (Postfix) with ESMTP id A72E53E23E9;
	Tue, 21 Oct 2025 16:17:17 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub13.kaspersky-labs.com (Postfix) with ESMTPS id 4B2443E243E;
	Tue, 21 Oct 2025 16:17:17 +0300 (MSK)
Received: from votokina.avp.ru (10.16.104.187) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Oct
 2025 16:16:36 +0300
From: Victoria Votokina <Victoria.Votokina@kaspersky.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
CC: Victoria Votokina <Victoria.Votokina@kaspersky.com>, Christian Gromm
	<christian.gromm@microchip.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <Oleg.Kazakov@kaspersky.com>
Subject: [PATCH v2 2/2] most: usb: hdm_probe: fix calling put_device() before device_initialize()
Date: Tue, 21 Oct 2025 16:16:25 +0300
Message-ID: <20251021131625.2707245-2-Victoria.Votokina@kaspersky.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20251021131625.2707245-1-Victoria.Votokina@kaspersky.com>
References: <20251021131625.2707245-1-Victoria.Votokina@kaspersky.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV2.avp.ru (10.64.57.52) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 10/21/2025 12:46:21
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 197285 [Oct 21 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Victoria.Votokina@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 72 0.3.72
 80ff96170b649fb7ebd1aa4cb544c36c109810bd
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: votokina.avp.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;kaspersky.com:7.1.1,5.0.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: {Tracking_References_header_contains_1_msgid}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/21/2025 12:48:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/21/2025 11:07:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/21 11:28:00 #27790297
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

Early failures in hdm_probe() could jump to err_free_mdev before 
&mdev->dev was initialized with device_initialize(), which triggered 
a device core WARN and kref_put() on an uninitialized kobject. 
Free the private struct directly in this pre-initialization path.

While here, replace a few unnecessary goto-based unwinds with 
direct returns and drop the now-unused err_free_dci label. On
device_register() failure, call put_device(&mdev->dci->dev) 
before returning to keep the reference model correct.

This removes the WARNING and simplifies the error paths 
without changing the success path behavior.


Fixes: 97a6f772f36b ("drivers: most: add USB adapter driver")
Signed-off-by: Victoria Votokina <Victoria.Votokina@kaspersky.com>
---
v2: Fixed error path for initialized interfaces requiring 
    most_deregister_interface

 drivers/most/most_usb.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index 3d8163bb7b46d..9d0a62023551c 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -1068,8 +1068,7 @@ hdm_probe(struct usb_interface *interface, const struct usb_device_id *id)
 		if (!mdev->dci) {
 			mutex_unlock(&mdev->io_mutex);
 			most_deregister_interface(&mdev->iface);
-			ret = -ENOMEM;
-			goto err_free_busy_urbs;
+			return -ENOMEM;
 		}
 
 		mdev->dci->dev.init_name = "dci";
@@ -1078,16 +1077,14 @@ hdm_probe(struct usb_interface *interface, const struct usb_device_id *id)
 		mdev->dci->dev.release = release_dci;
 		if (device_register(&mdev->dci->dev)) {
 			mutex_unlock(&mdev->io_mutex);
+			put_device(&mdev->dci->dev);
 			most_deregister_interface(&mdev->iface);
-			ret = -ENOMEM;
-			goto err_free_dci;
+			return -ENOMEM;
 		}
 		mdev->dci->usb_device = mdev->usb_device;
 	}
 	mutex_unlock(&mdev->io_mutex);
 	return 0;
-err_free_dci:
-	put_device(&mdev->dci->dev);
 err_free_busy_urbs:
 	kfree(mdev->busy_urbs);
 err_free_ep_address:
@@ -1097,7 +1094,7 @@ hdm_probe(struct usb_interface *interface, const struct usb_device_id *id)
 err_free_conf:
 	kfree(mdev->conf);
 err_free_mdev:
-	put_device(&mdev->dev);
+	kfree(mdev);
 	return ret;
 }
 
-- 
2.30.2


