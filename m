Return-Path: <linux-kernel+bounces-743472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309BAB0FF13
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26268967041
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599C01D86DC;
	Thu, 24 Jul 2025 03:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="PwA/O+oQ"
Received: from smtp153-165.sina.com.cn (smtp153-165.sina.com.cn [61.135.153.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60461BF58
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753326836; cv=none; b=PGoa9fV0OTmlemeSJV7jkMCyReZSCf4mfRmaB4VqtP2gHIkCYA64EpJjThUp9QeVVT/ZHmpQuDL4ysNoG1UzQa8DtkT9wHLyyFAT4xgW6RTvhSOMuiRLbH/+6Qe2tXwfu5BJwqknyLbCQyah6aHYLQEKkU7cdkW4GY1CJ0FvGuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753326836; c=relaxed/simple;
	bh=ETaR0jx60+vu0q19/QsOIjM2qNNCIyq7MEvAAPhAASw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KE77J0tUv3fQaGJDPWAOPbic5+gqRDJy5afUvBB3KwgkqseYf7N5kuNp1rBkBPe3aXj24bFuIo3S6cmOKJhd3gVhJ0T1z5xaS277z02xh+GYmYXgpbjjrUe9iglM3+gdknVFbJ21k2qRI5RgIHt//WHsuk2L58rf0zpnGeNb/JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=PwA/O+oQ; arc=none smtp.client-ip=61.135.153.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753326828;
	bh=U0N40smuyfMtWvZDfUHYKVkWYhtRfo4i+EstIKfJOJU=;
	h=From:Subject:Date:Message-ID;
	b=PwA/O+oQ+LXcyeP3lTN2MdN0BK/YHP6K3ka/vpB2iERU+Pbtrb19nMZDHw4HyD8ST
	 nrGEenWisJ9TUP/KwcXEYbNuqcg23Uy0IC5THIDawbrIajv6NQJio6WDZOb/qbaoIp
	 0d9/Ml3PkcOOtKjUvnIWsXjXXtCb6pMVVxrr0Ysg=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 6881A4E600001E91; Thu, 24 Jul 2025 11:13:44 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 973164457072
X-SMAIL-UIID: 5A544BCDE61D444382784B8DBBC1B04A-20250724-111344-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+e328767eafd849df0a78@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] [io-uring?] INFO: task hung in io_wq_put_and_exit (5)
Date: Thu, 24 Jul 2025 11:13:31 +0800
Message-ID: <20250724031332.2898-1-hdanton@sina.com>
In-Reply-To: <6880f54c.050a0220.248954.0000.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Wed, 23 Jul 2025 07:44:28 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    bf61759db409 Merge tag 'sched_ext-for-6.16-rc6-fixes' of g..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12b877d4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=415e83411fefd73f
> dashboard link: https://syzkaller.appspot.com/bug?extid=e328767eafd849df0a78
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110b938c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1622a38c580000

#syz test

--- x/io_uring/io-wq.c
+++ y/io_uring/io-wq.c
@@ -954,7 +954,7 @@ static bool io_wq_worker_wake(struct io_
 {
 	__set_notify_signal(worker->task);
 	wake_up_process(worker->task);
-	return false;
+	return true;
 }
 
 static void io_run_cancel(struct io_wq_work *work, struct io_wq *wq)
--

