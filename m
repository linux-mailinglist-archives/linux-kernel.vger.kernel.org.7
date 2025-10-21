Return-Path: <linux-kernel+bounces-863003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE470BF6C41
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D7A95034AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0943A337109;
	Tue, 21 Oct 2025 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="fZaAxkTn";
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="mL5RJNEl"
Received: from mailhub11-fb.kaspersky-labs.com (mailhub11-fb.kaspersky-labs.com [81.19.104.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D4F333733
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.104.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053255; cv=none; b=GofvNXm74jsnAATAdVQt80+BYLEicbzs8RpVte8+NDnECdPmUV8AXWeGtlZAlkI+ahj+s9+ZP8P/2P7ltimd8Rcv76dteeyE+l7NtquAI+GZgfUOLdtzVfl+62+CbtsY3sgNkX7fpRPjo5T8w0y5Q3/IjAfpdwZlo5rkGox2qMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053255; c=relaxed/simple;
	bh=HgtVxvLsM2Y04i9cD3E1Pb5w5+YwriGOWaBQnbm09l0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S1Pt1D7I3pQ+b7hZfC4o9ESnanUaifa7PnsGvzp2c8fFyGYrpbEpef9+RomJ5hPFsLLIKBDgQ3bTQuTVeDXWnCZgcchL++WXnLxz95j0/4NYKZS31vvG+XtHVkQkzVRCbEmzRYfbt0NHvyv5iy9rvwFn6XXWV3+S7SzhrBaPyH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=fZaAxkTn; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=mL5RJNEl; arc=none smtp.client-ip=81.19.104.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1761052646;
	bh=PclPcpn1MS39EVb55l2NxWn34CNSSLPIBLb4ulkm+kg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=fZaAxkTnm3mOKla5EK1nl4ClB5Vbkbni3QFKqtx9IgqD0/ZmZuLtSkUidCIhLOPQk
	 3Mxt8DDSJmIjF96QrBmGV1C0tk5rO6GLVtj4hhNN9vG1d/r3jl/UqYGTJoe0IOImoO
	 1VZIYf0lzeVeqNYZFr96rXHdjjWI/yRlIvZZ8rx91LWr2ydOsFg4iYvy/dkArICd+T
	 3LHNjuBppPNvO2KoHJ4SX9m3SiFIWgZs/Ur553kvdrDzHaVDiqI+eQQsB1d5wLPAt1
	 mtQ769+M7SpmrOamXvlE76JaRoF0SlJleNqR00Hd2kj/obAWvMRyki1YoRLKToKVpn
	 SArUpVD8oi0zQ==
Received: from mailhub11-fb.kaspersky-labs.com (localhost [127.0.0.1])
	by mailhub11-fb.kaspersky-labs.com (Postfix) with ESMTP id 170FFE867A8
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:17:26 +0300 (MSK)
Received: from mx13.kaspersky-labs.com (mx13.kaspersky-labs.com [91.103.66.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "mx13.kaspersky-labs.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub11-fb.kaspersky-labs.com (Postfix) with ESMTPS id D96CBE80D7C
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:17:25 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1761052637;
	bh=PclPcpn1MS39EVb55l2NxWn34CNSSLPIBLb4ulkm+kg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=mL5RJNElDLlAopUSQ0lqIKBo4MTeupIZmIPuGDMCCNO4bLCRXSbseOqcbSu91ZCAM
	 3JQGI4y4syBBdwNd9gQLDQwV1Tz0zPgt6xwvmOraANAKrddRwlQ55rQL0W4yU+AOQy
	 2bzK7tNCz1WctCU+pZ3KEgXEcAljIv3pK0MFQ23ySYxxIhN1N7nz586IRJAcEY5228
	 5AXjWFiTv5fwqDAQ67uEKQIHaWJfVvh4vAQsxLqlkzfOOcHPviRQsohAZ2jVHoFxET
	 ZfxyWOXakpjlfu9RymUybEv2Vw3PPQ4mHj7z/4LOTcC3WDBlzpO8yW/TkAAr6oG95u
	 DiuTP0f9OZK4w==
Received: from relay13.kaspersky-labs.com (localhost [127.0.0.1])
	by relay13.kaspersky-labs.com (Postfix) with ESMTP id AC2873E458A;
	Tue, 21 Oct 2025 16:17:17 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub13.kaspersky-labs.com (Postfix) with ESMTPS id D252E3E2468;
	Tue, 21 Oct 2025 16:17:16 +0300 (MSK)
Received: from votokina.avp.ru (10.16.104.187) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Oct
 2025 16:16:33 +0300
From: Victoria Votokina <Victoria.Votokina@kaspersky.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
CC: Victoria Votokina <Victoria.Votokina@kaspersky.com>, Christian Gromm
	<christian.gromm@microchip.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <Oleg.Kazakov@kaspersky.com>,
	<syzbot+916742d5d24f6c254761@syzkaller.appspotmail.com>
Subject: [PATCH v2 1/2] most: usb: fix use-after-free/double-free in hdm_disconnect
Date: Tue, 21 Oct 2025 16:16:24 +0300
Message-ID: <20251021131625.2707245-1-Victoria.Votokina@kaspersky.com>
X-Mailer: git-send-email 2.30.2
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
X-KSE-AntiSpam-Info: {Tracking_one_url}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: votokina.avp.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;kaspersky.com:7.1.1,5.0.1;syzkaller.appspot.com:7.1.1,5.0.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
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
X-KSMG-AntiPhishing: NotDetected, bases: 2025/10/21 12:37:00
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/21 11:28:00 #27790297
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/10/21 12:37:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

hdm_disconnect() calls most_deregister_interface(), which eventually
unregisters the MOST interface device with device_unregister(iface->dev).
If that drops the last reference, the device core may call release_mdev()
immediately while hdm_disconnect() is still executing.

The old code also freed several mdev-owned allocations in
hdm_disconnect() and then performed additional put_device() calls.
Depending on refcount order, this could lead to use-after-free or
double-free when release_mdev() ran (or when unregister paths also
performed puts).

Fix by moving the frees of mdev-owned allocations into release_mdev(),
so they happen exactly once when the device is truly released, and by
dropping the extra put_device() calls in hdm_disconnect() that are
redundant after device_unregister() and most_deregister_interface().

This addresses the KASAN slab-use-after-free reported by syzbot in
hdm_disconnect(). See report and stack traces in the bug link below.

Reported-by: syzbot+916742d5d24f6c254761@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=916742d5d24f6c254761
Fixes: 97a6f772f36b ("drivers: most: add USB adapter driver")
Signed-off-by: Victoria Votokina <Victoria.Votokina@kaspersky.com>
---
v2: Nothing changed

 drivers/most/most_usb.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index cf5be9c449a55..3d8163bb7b46d 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -929,6 +929,10 @@ static void release_mdev(struct device *dev)
 {
 	struct most_dev *mdev = to_mdev_from_dev(dev);
 
+	kfree(mdev->busy_urbs);
+	kfree(mdev->cap);
+	kfree(mdev->conf);
+	kfree(mdev->ep_address);
 	kfree(mdev);
 }
 /**
@@ -1121,13 +1125,6 @@ static void hdm_disconnect(struct usb_interface *interface)
 	if (mdev->dci)
 		device_unregister(&mdev->dci->dev);
 	most_deregister_interface(&mdev->iface);
-
-	kfree(mdev->busy_urbs);
-	kfree(mdev->cap);
-	kfree(mdev->conf);
-	kfree(mdev->ep_address);
-	put_device(&mdev->dci->dev);
-	put_device(&mdev->dev);
 }
 
 static int hdm_suspend(struct usb_interface *interface, pm_message_t message)
-- 
2.30.2


