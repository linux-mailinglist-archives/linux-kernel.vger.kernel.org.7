Return-Path: <linux-kernel+bounces-848135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C40CBCC9D5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D8F74FCE7D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B342EDD4D;
	Fri, 10 Oct 2025 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="mSdyt2Le"
Received: from mx12.kaspersky-labs.com (mx12.kaspersky-labs.com [91.103.66.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781622857E2
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760093596; cv=none; b=cFB/F+C/mAFovB0vUVc/O+nkl5jktde/Ak4AyI6L3DsC1QYZ4NDJbJZLwLfpLeMYNWrBXIEp0iIOYbl+0j/wgfKfPRYYqYsIckLnJy3LwbyvGDt6AnETRN82GF/AovpJHVnYxuGjpZ9bqH8It2AXxkpgw/UH3IvsvLSavHKEHUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760093596; c=relaxed/simple;
	bh=mBsKOlNivrEzgpNQ32Ja9d9uwLx82wEK7c+yWmSuoLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sGW4wyNqqM/WhRDtBKmSvVEc3qdrBQSSdlkeYRQkvlTg+RIBFkwRnNSHZNp8+FLTv+/c44H4YU1SshMjMSbgMPkYA9ksenMBbzSaP5uzVAsSONqsOru8ZYX9ntFb3GdCJm5o4UnIafbOnhtRHU/LmwMQ/ezcc2+dPwwe2B1PST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=mSdyt2Le; arc=none smtp.client-ip=91.103.66.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1760093586;
	bh=sSq/qbH13KPDbnk4+zW1ZLUgBfkISExmVwHZBjJ89Sg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=mSdyt2LeKfLbjH6kbTXEi4ypvL8pkY8sOFVWIIX3hADTtYymWlXZIlQOzp99Wj+jT
	 W+KIkqBEUZdgvMsirac28TLFrskiHwkukoNT40iabplOCjN8Puj/TwCeN8hzMdaG1E
	 +BXKrf2RX/b3ylbaGpcWEdANGFEb39NAD5bFTTtdCtsJONQxP12UNasikiCRPOX8Y3
	 bhp5O5qYISht/B/idsy1fXQ313+qYfmaIBn1b6w++WjmVHVswBwi4leIGGUucdlyye
	 a5tI6CyAZfFyoIvs/La2xJeJ4C+SneNRr2rYAi+Wli6fR9XEtXxUgNzV540YhSU0pA
	 FvRGkpEjiTLmw==
Received: from relay12.kaspersky-labs.com (localhost [127.0.0.1])
	by relay12.kaspersky-labs.com (Postfix) with ESMTP id E78725A1482;
	Fri, 10 Oct 2025 13:53:06 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub12.kaspersky-labs.com (Postfix) with ESMTPS id 9C04A5A1580;
	Fri, 10 Oct 2025 13:53:06 +0300 (MSK)
Received: from votokina.avp.ru (10.16.104.187) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Oct
 2025 13:53:05 +0300
From: Victoria Votokina <Victoria.Votokina@kaspersky.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
CC: Victoria Votokina <Victoria.Votokina@kaspersky.com>, Christian Gromm
	<christian.gromm@microchip.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <Oleg.Kazakov@kaspersky.com>,
	<syzbot+916742d5d24f6c254761@syzkaller.appspotmail.com>
Subject: [PATCH 1/2] most: usb: Fix use-after-free in hdm_disconnect
Date: Fri, 10 Oct 2025 13:52:40 +0300
Message-ID: <20251010105241.4087114-2-Victoria.Votokina@kaspersky.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20251010105241.4087114-1-Victoria.Votokina@kaspersky.com>
References: <20251010105241.4087114-1-Victoria.Votokina@kaspersky.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HQMAILSRV5.avp.ru (10.64.57.55) To HQMAILSRV2.avp.ru
 (10.64.57.52)
X-KSE-ServerInfo: HQMAILSRV2.avp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 10/10/2025 10:41:58
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 196985 [Oct 10 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: Victoria.Votokina@kaspersky.com
X-KSE-AntiSpam-Info: LuaCore: 71 0.3.71
 ee78c3da48e828d2b9b16d6d0b31328b8b240a3c
X-KSE-AntiSpam-Info: {Tracking_cluster_exceptions}
X-KSE-AntiSpam-Info: {Tracking_real_kaspersky_domains}
X-KSE-AntiSpam-Info: {Tracking_one_url}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: votokina.avp.ru:5.0.1,7.1.1;syzkaller.appspot.com:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;kaspersky.com:5.0.1,7.1.1
X-KSE-AntiSpam-Info: {Tracking_white_helo}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/10/2025 10:44:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10/10/2025 9:12:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/10/10 09:42:00
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/10 09:41:00 #27899163
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/10/10 09:42:00
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
Closes: https://syzkaller.appspot.com/bug?extid=916742d5d24f6c254761
Fixes: 97a6f772f36b ("drivers: most: add USB adapter driver")
Signed-off-by: Victoria Votokina <Victoria.Votokina@kaspersky.com>
---
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


