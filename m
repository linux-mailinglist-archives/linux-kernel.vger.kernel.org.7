Return-Path: <linux-kernel+bounces-861457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96923BF2C38
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E85318A7728
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22CC3321BC;
	Mon, 20 Oct 2025 17:42:34 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BED21ABD7
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982154; cv=none; b=OHsNqJ14la/F5bro65Nrk5kjTZp8WVG/gXWJOGwYtKaWK6JNNsd2j+Wz6WFM7LXWNYJbq7+JsPgCVo8tWF7nPh9UXuX5Q51WjYEpP4pvj6Qq0XUvoH9ILyzGZ53bW+QUgfmboC7LdSPq0/dRKofeK5IPkwyuWm2HdhboaqW7ygI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982154; c=relaxed/simple;
	bh=qNsEYytiGRTReSMmoy2JakqeGw/R7wEdWRZO5PGzT9s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UOXrmpUXaQTjVH8xYk0iT/ACvCTRXZ81JiXM+QHUMHe1KV4StLW+rawJotVdJJWFocQqqy/cfW7gsvgeuJvUl/unrLv0U4USkLGEzHvXhShbADpBbiI0NtnlhG+1vqWIUMRWK47H++UEXeKv+RmIJQ1Frv4T8szfSAY/1p91s74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 20 Oct
 2025 20:42:26 +0300
Received: from localhost (10.0.253.101) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 20 Oct
 2025 20:42:26 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten
	<hsweeten@visionengravers.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<syzbot+ab8008c24e84adee93ff@syzkaller.appspotmail.com>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] comedi: check device's attached status in compat ioctls
Date: Mon, 20 Oct 2025 20:41:22 +0300
Message-ID: <20251020174125.150608-1-n.zhandarovich@fintech.ru>
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
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
Compile-tested only due to my QEMU setup currently being broken.
Also, there is no decent syzkaller repro for this problem so
testing this is a little tricky.

P.S. 'Fixes' tag is technically not correct, as each compat ioctl
that requires special handling arguments-wise has been modified
in separate commit. I've opted not to mention each and every one
of them.

P.P.S. While these multiple identical checks look abhorrent, I've
decided against changing current approach to compat functions.

 drivers/comedi/comedi_fops.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 7e2f2b1a1c36..123e9af2ed44 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -3023,6 +3023,11 @@ static int compat_chaninfo(struct file *file, unsigned long arg)
 	chaninfo.rangelist = compat_ptr(chaninfo32.rangelist);
 
 	mutex_lock(&dev->mutex);
+	if (!dev->attached) {
+		dev_dbg(dev->class_dev, "no driver attached\n");
+		mutex_unlock(&dev->mutex);
+		return -ENODEV;
+	}
 	err = do_chaninfo_ioctl(dev, &chaninfo);
 	mutex_unlock(&dev->mutex);
 	return err;
@@ -3044,6 +3049,11 @@ static int compat_rangeinfo(struct file *file, unsigned long arg)
 	rangeinfo.range_ptr = compat_ptr(rangeinfo32.range_ptr);
 
 	mutex_lock(&dev->mutex);
+	if (!dev->attached) {
+		dev_dbg(dev->class_dev, "no driver attached\n");
+		mutex_unlock(&dev->mutex);
+		return -ENODEV;
+	}
 	err = do_rangeinfo_ioctl(dev, &rangeinfo);
 	mutex_unlock(&dev->mutex);
 	return err;
@@ -3120,6 +3130,11 @@ static int compat_cmd(struct file *file, unsigned long arg)
 		return rc;
 
 	mutex_lock(&dev->mutex);
+	if (!dev->attached) {
+		dev_dbg(dev->class_dev, "no driver attached\n");
+		mutex_unlock(&dev->mutex);
+		return -ENODEV;
+	}
 	rc = do_cmd_ioctl(dev, &cmd, &copy, file);
 	mutex_unlock(&dev->mutex);
 	if (copy) {
@@ -3145,6 +3160,11 @@ static int compat_cmdtest(struct file *file, unsigned long arg)
 		return rc;
 
 	mutex_lock(&dev->mutex);
+	if (!dev->attached) {
+		dev_dbg(dev->class_dev, "no driver attached\n");
+		mutex_unlock(&dev->mutex);
+		return -ENODEV;
+	}
 	rc = do_cmdtest_ioctl(dev, &cmd, &copy, file);
 	mutex_unlock(&dev->mutex);
 	if (copy) {
@@ -3205,6 +3225,12 @@ static int compat_insnlist(struct file *file, unsigned long arg)
 	}
 
 	mutex_lock(&dev->mutex);
+	if (!dev->attached) {
+		dev_dbg(dev->class_dev, "no driver attached\n");
+		mutex_unlock(&dev->mutex);
+		kfree(insns);
+		return -ENODEV;
+	}
 	rc = do_insnlist_ioctl(dev, insns, insnlist32.n_insns, file);
 	mutex_unlock(&dev->mutex);
 	kfree(insns);
@@ -3224,6 +3250,11 @@ static int compat_insn(struct file *file, unsigned long arg)
 		return rc;
 
 	mutex_lock(&dev->mutex);
+	if (!dev->attached) {
+		dev_dbg(dev->class_dev, "no driver attached\n");
+		mutex_unlock(&dev->mutex);
+		return -ENODEV;
+	}
 	rc = do_insn_ioctl(dev, &insn, file);
 	mutex_unlock(&dev->mutex);
 	return rc;

