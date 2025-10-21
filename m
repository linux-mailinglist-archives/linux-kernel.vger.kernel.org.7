Return-Path: <linux-kernel+bounces-862980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E2CBF6B78
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FFD19A50DF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F46334C0D;
	Tue, 21 Oct 2025 13:17:13 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF721D590
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052632; cv=none; b=bCDW/z9W6Hs+Lb3QsnVA9H/oK6/GQ/ckaP91+341vLOdVz+2LrHD2f/6bOnEVnJbzcOHHzE6pBnStwSC6WI/rBsEuMu5JyQ1fSiEARIfu215KDmotquRnJXd9mAJxcJmKFfIjuGJCmd30GasIK07XAjHIAvJw2RrzkEY5XXZhEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052632; c=relaxed/simple;
	bh=FfiejyCIuDpjyWPKEELXN4hAsPCZryQHEyfxdtTqgkE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jVG+snytknDY/p7uwonPuvhiI1/BYxrUEfrrhwyAOh/xhTu/SozL6YcddogFuqPS0TvIKRmeT+BDqFhQLveJ3JWzWd+sk+gupPLEtdnBoWX3PH2vy4qjiR4cNq5qJYtb8VKxmXc/RPpJZyK8GVvUGruYgBI5JLAyY87laQH9VT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 21 Oct
 2025 16:17:05 +0300
Received: from localhost (10.0.253.101) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 21 Oct
 2025 16:17:05 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten
	<hsweeten@visionengravers.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>, Hillf Danton
	<hdanton@sina.com>, <syzbot+6616bba359cec7a1def1@syzkaller.appspotmail.com>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] comedi: drivers: do not detach device if driv->attach() fails
Date: Tue, 21 Oct 2025 16:16:55 +0300
Message-ID: <20251021131656.164783-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Syzbot identified an issue [1] in comedi_device_attach() that occurs
when kernel attempts to detach a comedi device via
comedi_device_detach() even if a driver-specific attach() method
already failed. Attempts to follow through with detaching the
device and unregistering the driver trigger a warning.

Fix this by rearranging cleanup calls so that comedi_device_detach()
runs only if the device in question has been successfully attached.

Original idea for this patch belongs to Hillf Danton
<hdanton@sina.com>.

[1] Syzbot crash:
Unexpected driver unregister!
WARNING: CPU: 0 PID: 5970 at drivers/base/driver.c:273 driver_unregister drivers/base/driver.c:273 [inline]
WARNING: CPU: 0 PID: 5970 at drivers/base/driver.c:273 driver_unregister+0x90/0xb0 drivers/base/driver.c:270
...
Call Trace:
 <TASK>
 comedi_device_detach_locked+0x12f/0xa50 drivers/comedi/drivers.c:207
 comedi_device_detach+0x67/0xb0 drivers/comedi/drivers.c:215
 comedi_device_attach+0x43d/0x900 drivers/comedi/drivers.c:1011
 do_devconfig_ioctl+0x1b1/0x710 drivers/comedi/comedi_fops.c:872
 comedi_unlocked_ioctl+0x165d/0x2f00 drivers/comedi/comedi_fops.c:2178
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
...

Reported-by: syzbot+6616bba359cec7a1def1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6616bba359cec7a1def1
Suggested-by: Hillf Danton <hdanton@sina.com>
Fixes: 74ece108f9e5 ("staging: comedi: move detach out of post-config")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/comedi/drivers.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
index c9ebaadc5e82..001083f96138 100644
--- a/drivers/comedi/drivers.c
+++ b/drivers/comedi/drivers.c
@@ -1005,10 +1005,13 @@ int comedi_device_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	dev->board_name = dev->board_ptr ? *(const char **)dev->board_ptr
 					 : dev->driver->driver_name;
 	ret = driv->attach(dev, it);
-	if (ret >= 0)
+	if (ret >= 0) {
 		ret = comedi_device_postconfig(dev);
-	if (ret < 0) {
-		comedi_device_detach(dev);
+		if (ret < 0) {
+			comedi_device_detach(dev);
+			module_put(driv->module);
+		}
+	} else {
 		module_put(driv->module);
 	}
 	/* On success, the driver module count has been incremented. */

