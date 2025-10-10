Return-Path: <linux-kernel+bounces-848134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DCDBCC9D0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C0E19E2501
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA13C2ED16C;
	Fri, 10 Oct 2025 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b="rQTJPbJM"
Received: from mx12.kaspersky-labs.com (mx12.kaspersky-labs.com [91.103.66.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49E3285CB3
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.103.66.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760093596; cv=none; b=UgVdgLRD2CvBOo0h37y6AGcrqpJiGxCvEFpKgyBBOAoAAf2cg8lf5kBUH7TAfIe9XhweZIl5KKZT2dADU79CY5rfusGvUxTWKwCVnKCM/KlkOM9Nn55jb+nTdW+91NkTIJPiXQpDyON79B+rOQ/kVoNWoZNaZKw6mq6IkUcp/UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760093596; c=relaxed/simple;
	bh=dLM/NVixiJ8Ndann+yslE5kGh8Pdt806yWPi8ckApjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srpwVn9BWmim3U9LGEeJAL7utmhdxigeKth4fFFs8128wmixJ1Tc0QMmBQPU68b3/RosPtsR0J72EvJh9L/smtvxargAhW7XzoG2nhp3vi5ED6eDJXeM/8RUMVFXj9ie36wypU6Mih1rnhdx/idxJbSB5klJliMGZNHBWdHmsMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com; spf=pass smtp.mailfrom=kaspersky.com; dkim=pass (2048-bit key) header.d=kaspersky.com header.i=@kaspersky.com header.b=rQTJPbJM; arc=none smtp.client-ip=91.103.66.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaspersky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaspersky.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaspersky.com;
	s=mail202505; t=1760093591;
	bh=l85TPikRtUlCZlamIjR7KkwXkiIpECfn7+oYENsonn8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=rQTJPbJMFa8mpPMiecv3r43AdGohvBlOVq/OS/iWXHO3mgGBmEu4RtiYH4pcyBr4Z
	 JqpQBrnpzGyaoJ5AdRHcrbVyJ4jXZ4pg7E5gHy4U50zNJW5LlNLRH7dldvYwqWPU+g
	 0/CV5EZ7Q1o3xbcqtXa+onBFOv+y5HwGUeSiq+o4rauTYLjetxMB5HwGkCHNSffBK/
	 z19uybrgjivBJHzjYYpYXlpwhKBWnWRbYYYICejdYrIA0A9TRBqSTDUdRjEDcI6ooJ
	 vKzEqsnRHRv+6qr9JuGjD19W6Vnt+7THz39J6jL5dk39H23oh4JmWSJre8jR54lnH9
	 NNQYUx6Z0Tj6w==
Received: from relay12.kaspersky-labs.com (localhost [127.0.0.1])
	by relay12.kaspersky-labs.com (Postfix) with ESMTP id 0926E5A179B;
	Fri, 10 Oct 2025 13:53:11 +0300 (MSK)
Received: from mail-hq2.kaspersky.com (unknown [91.103.66.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail-hq2.kaspersky.com", Issuer "Kaspersky MailRelays CA G3" (verified OK))
	by mailhub12.kaspersky-labs.com (Postfix) with ESMTPS id D25E95A178E;
	Fri, 10 Oct 2025 13:53:10 +0300 (MSK)
Received: from votokina.avp.ru (10.16.104.187) by HQMAILSRV2.avp.ru
 (10.64.57.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Oct
 2025 13:53:10 +0300
From: Victoria Votokina <Victoria.Votokina@kaspersky.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
CC: Victoria Votokina <Victoria.Votokina@kaspersky.com>, Christian Gromm
	<christian.gromm@microchip.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <Oleg.Kazakov@kaspersky.com>
Subject: [PATCH 2/2] most: usb: hdm_probe: Fix calling put_device() before device initialization
Date: Fri, 10 Oct 2025 13:52:41 +0300
Message-ID: <20251010105241.4087114-3-Victoria.Votokina@kaspersky.com>
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
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;kaspersky.com:5.0.1,7.1.1;127.0.0.199:7.1.2;votokina.avp.ru:5.0.1,7.1.1
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
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/10/10 09:41:00 #27899163
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 52

The early error path in hdm_probe() can jump to err_free_mdev before
&mdev->dev has been initialized with device_initialize(). Calling
put_device(&mdev->dev) there triggers a device core WARN and ends up
invoking kref_put(&kobj->kref, kobject_release) on an uninitialized
kobject.

In this path the private struct was only kmalloc'ed and the intended
release is effectively kfree(mdev) anyway, so free it directly instead
of calling put_device() on an uninitialized device.

This removes the WARNING and fixes the pre-initialization error path.

Fixes: 97a6f772f36b ("drivers: most: add USB adapter driver")
Signed-off-by: Victoria Votokina <Victoria.Votokina@kaspersky.com>
---
 drivers/most/most_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index 3d8163bb7b46d..10064d7b72498 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -1097,7 +1097,7 @@ hdm_probe(struct usb_interface *interface, const struct usb_device_id *id)
 err_free_conf:
 	kfree(mdev->conf);
 err_free_mdev:
-	put_device(&mdev->dev);
+	kfree(mdev);
 	return ret;
 }
 
-- 
2.30.2


