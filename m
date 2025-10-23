Return-Path: <linux-kernel+bounces-867016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC22EC01575
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04761A62C22
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF384314A70;
	Thu, 23 Oct 2025 13:22:44 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06406311C1E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225764; cv=none; b=WoiduQe5loFC9/MxV2dM0zW/j1R87vfY33ZQ9cBQLXgt9XXJr1t02WD/HnF+2KI6ycou3kj4yBtmo2vv2FbPmb+Zmq5M2QOy+r61RXCmmgyRfPCfwD9G387zyfK7kfQ26VWZjjRCau5AqBhWg0hFzh+KfF4ma4uMEmMMJTFzo5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225764; c=relaxed/simple;
	bh=UDu63K63IcwjyrRx1h5d5L4y2nXwo4skSJzAMA87vTo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p9KgGDB6cFJxoTPxX7X1W71W8RH3/2iQGvayjJbwS/pQwZ2Sve3g+wFd7PxRH3DIke46mEoXBlKpSuqjzbwyMcu7A6VqWLlabFF2W9gSlN+ePJvoGUURBUzozbb1J1Egop2sPYTbHpo1CUR/sc7L5M7y4zOpT3njsgvfSbedAQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 23 Oct
 2025 16:22:39 +0300
Received: from localhost (10.0.253.101) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 23 Oct
 2025 16:22:38 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten
	<hsweeten@visionengravers.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<syzbot+ab8008c24e84adee93ff@syzkaller.appspotmail.com>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH v2] comedi: check device's attached status in compat ioctls
Date: Thu, 23 Oct 2025 16:22:32 +0300
Message-ID: <20251023132234.395794-1-n.zhandarovich@fintech.ru>
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

Syzbot identified an issue [1] that crashes kernel, seemingly due to
unexistent callback dev->get_valid_routes(). By all means, this should
not occur as said callback must always be set to
get_zero_valid_routes() in __comedi_device_postconfig().

As the crash seems to appear exclusively in i386 kernels, at least,
judging from [1] reports, the blame lies with compat versions
of standard IOCTL handlers. Several of them are modified and
do not use comedi_unlocked_ioctl(). While functionality of these
ioctls essentially copy their original versions, they do not
have required sanity check for device's attached status. This,
in turn, leads to a possibility of calling select IOCTLs on a
device that has not been properly setup, even via COMEDI_DEVCONFIG.

Doing so on unconfigured devices means that several crucial steps
are missed, for instance, specifying dev->get_valid_routes()
callback.

Fix this somewhat crudely by ensuring device's attached status before
performing any ioctls, improving logic consistency between modern
and compat functions.

[1] Syzbot report:
BUG: kernel NULL pointer dereference, address: 0000000000000000
...
CR2: ffffffffffffffd6 CR3: 000000006c717000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 get_valid_routes drivers/comedi/comedi_fops.c:1322 [inline]
 parse_insn+0x78c/0x1970 drivers/comedi/comedi_fops.c:1401
 do_insnlist_ioctl+0x272/0x700 drivers/comedi/comedi_fops.c:1594
 compat_insnlist drivers/comedi/comedi_fops.c:3208 [inline]
 comedi_compat_ioctl+0x810/0x990 drivers/comedi/comedi_fops.c:3273
 __do_compat_sys_ioctl fs/ioctl.c:695 [inline]
 __se_compat_sys_ioctl fs/ioctl.c:638 [inline]
 __ia32_compat_sys_ioctl+0x242/0x370 fs/ioctl.c:638
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
...

Reported-by: syzbot+ab8008c24e84adee93ff@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ab8008c24e84adee93ff
Fixes: 3fbfd2223a27 ("comedi: get rid of compat_alloc_user_space() mess in COMEDI_CHANINFO compat")
Cc: stable@vger.kernel.org
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
v1 -> v2: Use proper if/else structure to avoid duplicate calls per
Ian Abbott's <abbotti@mev.co.uk> suggestion. Add Reviewed-by tag as
well.

 drivers/comedi/comedi_fops.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 7e2f2b1a1c36..b2e62e04afd9 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -3023,7 +3023,12 @@ static int compat_chaninfo(struct file *file, unsigned long arg)
 	chaninfo.rangelist = compat_ptr(chaninfo32.rangelist);
 
 	mutex_lock(&dev->mutex);
-	err = do_chaninfo_ioctl(dev, &chaninfo);
+	if (!dev->attached) {
+		dev_dbg(dev->class_dev, "no driver attached\n");
+		err = -ENODEV;
+	} else {
+		err = do_chaninfo_ioctl(dev, &chaninfo);
+	}
 	mutex_unlock(&dev->mutex);
 	return err;
 }
@@ -3044,7 +3049,12 @@ static int compat_rangeinfo(struct file *file, unsigned long arg)
 	rangeinfo.range_ptr = compat_ptr(rangeinfo32.range_ptr);
 
 	mutex_lock(&dev->mutex);
-	err = do_rangeinfo_ioctl(dev, &rangeinfo);
+	if (!dev->attached) {
+		dev_dbg(dev->class_dev, "no driver attached\n");
+		err = -ENODEV;
+	} else {
+		err = do_rangeinfo_ioctl(dev, &rangeinfo);
+	}
 	mutex_unlock(&dev->mutex);
 	return err;
 }
@@ -3120,7 +3130,12 @@ static int compat_cmd(struct file *file, unsigned long arg)
 		return rc;
 
 	mutex_lock(&dev->mutex);
-	rc = do_cmd_ioctl(dev, &cmd, &copy, file);
+	if (!dev->attached) {
+		dev_dbg(dev->class_dev, "no driver attached\n");
+		rc = -ENODEV;
+	} else {
+		rc = do_cmd_ioctl(dev, &cmd, &copy, file);
+	}
 	mutex_unlock(&dev->mutex);
 	if (copy) {
 		/* Special case: copy cmd back to user. */
@@ -3145,7 +3160,12 @@ static int compat_cmdtest(struct file *file, unsigned long arg)
 		return rc;
 
 	mutex_lock(&dev->mutex);
-	rc = do_cmdtest_ioctl(dev, &cmd, &copy, file);
+	if (!dev->attached) {
+		dev_dbg(dev->class_dev, "no driver attached\n");
+		rc = -ENODEV;
+	} else {
+		rc = do_cmdtest_ioctl(dev, &cmd, &copy, file);
+	}
 	mutex_unlock(&dev->mutex);
 	if (copy) {
 		err = put_compat_cmd(compat_ptr(arg), &cmd);
@@ -3205,7 +3225,12 @@ static int compat_insnlist(struct file *file, unsigned long arg)
 	}
 
 	mutex_lock(&dev->mutex);
-	rc = do_insnlist_ioctl(dev, insns, insnlist32.n_insns, file);
+	if (!dev->attached) {
+		dev_dbg(dev->class_dev, "no driver attached\n");
+		rc = -ENODEV;
+	} else {
+		rc = do_insnlist_ioctl(dev, insns, insnlist32.n_insns, file);
+	}
 	mutex_unlock(&dev->mutex);
 	kfree(insns);
 	return rc;
@@ -3224,7 +3249,12 @@ static int compat_insn(struct file *file, unsigned long arg)
 		return rc;
 
 	mutex_lock(&dev->mutex);
-	rc = do_insn_ioctl(dev, &insn, file);
+	if (!dev->attached) {
+		dev_dbg(dev->class_dev, "no driver attached\n");
+		rc = -ENODEV;
+	} else {
+		rc = do_insn_ioctl(dev, &insn, file);
+	}
 	mutex_unlock(&dev->mutex);
 	return rc;
 }

