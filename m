Return-Path: <linux-kernel+bounces-780989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109FBB30BFF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBBDAC4A1B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 02:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8015021D3C0;
	Fri, 22 Aug 2025 02:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S/BAgFdq"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A0B21ADB9;
	Fri, 22 Aug 2025 02:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755830798; cv=none; b=mT33mbrKJgqaomIAGaBfKp/Cm6XVMfWWOliSxp15Gf/cL/dsAluYvrnWsge+GGNxDbUR7mFxmyQh3btYvfem0/6zE0fXdN1DRTkHQ8PqlUWhJET+topx7CYghMJnika58cHP/gYWFvA60MLkcH92ANQCrtn1WtJBhFOth2F5Yv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755830798; c=relaxed/simple;
	bh=Ywx7e4h2sBHfe1jk7/s3AaNTx3ChkLUEFIgXEVyKgeo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T2LHBPNFBUgVoQOyU3V+8hM+fgMvYDAE6NBH7txGK+TiQcXUus3w0EegM25KU2bSv04fPfDOEQR+NJMAFHlSfI+y8SlhLLMqSqnQSDX//Q2mYL4huc3p6jg3skYnMAcRJ99woihASEC6gnz6SiUXXJW4j0N/PDQl4KtDgH6SCkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S/BAgFdq; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=KD
	wtmxqmQM9tsvXEIkX1bqnD+g/okK51Yr1LWmD6FtQ=; b=S/BAgFdq1KJgUy1iY3
	ZV/J1xzDVVZEd97HLj8yqABh7m5xpW8TMtg7o4D9oWhf7dWCnId8krWsYGe2QxnK
	NW4cpHsViHrb9y4l09bvlVxHbmKQNyZLywPd2KAkBbHoBFOsdnbeMBZUNodg+jB4
	eHxOUURNEpM2B01NVXJZEU0HQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDHKo7t2adoOpKLDg--.63895S2;
	Fri, 22 Aug 2025 10:46:06 +0800 (CST)
From: ccc194101@163.com
To: gregkh@linuxfoundation.org
Cc: jannh@google.com,
	stern@rowland.harvard.edu,
	rex.nie@jaguarmicro.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenchangcheng <chenchangcheng@kylinos.cn>
Subject: [PATCH] usb: usbfs: Add reset_resume callback to usbfs.
Date: Fri, 22 Aug 2025 10:46:02 +0800
Message-Id: <20250822024602.42894-1-ccc194101@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHKo7t2adoOpKLDg--.63895S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw1UCF47Zw13tFWDGFyfJFb_yoW8Wr18pF
	WYya9Fyr1UJr47WrsYyFn5ZFyrAanYyay2kry3Z39xua43J34xtF18tFy5J3WDKr129r9x
	tF17Kwnxua4rGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7YFAUUUUU=
X-CM-SenderInfo: 5fffimiurqiqqrwthudrp/1tbiYxyx3min1YSMSQAAsL

From: chenchangcheng <chenchangcheng@kylinos.cn>

When an Apple device is inserted into the host, and the host
wakes up from S3/S4 power states, if the reset_resume process
is triggered, the absence of a reset_resume callback in usbfs will
cause the device to unbind.
By adding a reset_resume callback to usbfs and reporting REMOVE and ADD
uevents in reset_resume, the userspace is prompted to reissue commands
to re-establish the binding with usbfs.

Signed-off-by: chenchangcheng <chenchangcheng@kylinos.cn>
---
 drivers/usb/core/devio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index f6ce6e26e0d4..358850596b0d 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -749,6 +749,14 @@ static int driver_resume(struct usb_interface *intf)
 	return 0;
 }
 
+static int driver_reset_resume(struct usb_interface *intf)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+
+	kobject_uevent(&udev->dev.kobj, KOBJ_REMOVE);
+	kobject_uevent(&udev->dev.kobj, KOBJ_ADD);
+	return 0;
+}
 #ifdef CONFIG_PM
 /* The following routines apply to the entire device, not interfaces */
 void usbfs_notify_suspend(struct usb_device *udev)
@@ -776,6 +784,7 @@ struct usb_driver usbfs_driver = {
 	.disconnect =	driver_disconnect,
 	.suspend =	driver_suspend,
 	.resume =	driver_resume,
+	.reset_resume =	driver_reset_resume,
 	.supports_autosuspend = 1,
 };
 

base-commit: b19a97d57c15643494ac8bfaaa35e3ee472d41da
-- 
2.25.1


