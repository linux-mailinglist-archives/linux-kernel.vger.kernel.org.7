Return-Path: <linux-kernel+bounces-746973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8A2B12DAE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 06:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E137D189BC8F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE39194A65;
	Sun, 27 Jul 2025 03:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="tiWQGLbM"
Received: from mail3-163.sinamail.sina.com.cn (mail3-163.sinamail.sina.com.cn [202.108.3.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDBACA4B
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 03:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753588794; cv=none; b=stF9L/Z58CS0xriMRTNvQYHj9cBNQiFrFAFZqEr5AGNb/xRgna6HoJGqkqSFH/0iBjtwucbrKWtx2vMxr8AjWANQXBCVRjJN0ftojpQ4YeKwVZhNQcxBH2KSjz1Qgbim19WVF/3vHXEsr9aGpgdWaksBPQrrFVwmalf3TfTN/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753588794; c=relaxed/simple;
	bh=Ry8pXu+F+zu8VSxH0DP7v1yB6FdqN8GfOO2O+zffyNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGwn014pMak/KpLgq1IKsPvbWOlrIsN3TcBtmyg7Z59b4rFCoZL7iopZjSYn/TDehtgwSz6hyvWym/tyLROlIYqZ7BwSBTWDvIc26u28OKNOa7xoLfUgTj65Du9rutefMHKiyR4rZbXRCOk3LAuokU7ViiUnm++hOqJvV37YPVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=tiWQGLbM; arc=none smtp.client-ip=202.108.3.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753588789;
	bh=eHEeeInrPQpBr0c8Kw0bOxR08yEk9ct5jx2k/yFV8f4=;
	h=From:Subject:Date:Message-ID;
	b=tiWQGLbMwQXXPyvQU0mgzd3iifRwlqbQQjDaF5ZgHD9F6Gbn7CKaO4sIc8lFQLEpx
	 VLMgt2Yvf+Re9Bv35SIvTzQOwaqgkhU6No7uN3s5rDqD1I6C8yhZV3HWiXDA1VGqlA
	 RYPPWq+/OyMHCBdwdHxgE1gLYa85YsZQeesFtScM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 6885A42A0000294F; Sun, 27 Jul 2025 11:59:39 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7534546291942
X-SMAIL-UIID: A331C2A585C04072B46AD69F32627E72-20250727-115939-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ed7c6209f62eba1565aa@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] possible deadlock in input_ff_flush
Date: Sun, 27 Jul 2025 11:59:27 +0800
Message-ID: <20250727035928.3238-1-hdanton@sina.com>
In-Reply-To: <68852286.a00a0220.b12ec.0028.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sat, 26 Jul 2025 11:46:30 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    5f33ebd2018c Merge tag 'drm-fixes-2025-07-26' of https://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=130d4034580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9f175a9275d2cdd7
> dashboard link: https://syzkaller.appspot.com/bug?extid=ed7c6209f62eba1565aa
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108d4034580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148d4034580000

#syz test

--- x/drivers/input/misc/uinput.c
+++ y/drivers/input/misc/uinput.c
@@ -35,7 +35,7 @@
 #define UINPUT_NUM_REQUESTS	16
 #define UINPUT_TIMESTAMP_ALLOWED_OFFSET_SECS 10
 
-enum uinput_state { UIST_NEW_DEVICE, UIST_SETUP_COMPLETE, UIST_CREATED };
+enum uinput_state { UIST_NEW_DEVICE, UIST_SETUP_COMPLETE, UIST_REGISTERING, UIST_CREATED };
 
 struct uinput_request {
 	unsigned int		id;
@@ -289,6 +289,8 @@ static void uinput_destroy_device(struct
 	struct input_dev *dev = udev->dev;
 	enum uinput_state old_state = udev->state;
 
+	if (udev->state == UIST_REGISTERING)
+		return;
 	udev->state = UIST_NEW_DEVICE;
 
 	if (dev) {
@@ -309,8 +311,10 @@ static void uinput_destroy_device(struct
 static int uinput_create_device(struct uinput_device *udev)
 {
 	struct input_dev *dev = udev->dev;
+	enum uinput_state old_state = udev->state;
 	int error, nslot;
 
+	lockdep_assert_held(&udev->mutex);
 	if (udev->state != UIST_SETUP_COMPLETE) {
 		printk(KERN_DEBUG "%s: write device info first\n", UINPUT_NAME);
 		return -EINVAL;
@@ -362,7 +366,11 @@ static int uinput_create_device(struct u
 
 	input_set_drvdata(udev->dev, udev);
 
+	udev->state = UIST_REGISTERING;
+	mutex_unlock(&udev->mutex);
 	error = input_register_device(udev->dev);
+	mutex_lock(&udev->mutex);
+	udev->state = old_state;
 	if (error)
 		goto fail2;
 
--

