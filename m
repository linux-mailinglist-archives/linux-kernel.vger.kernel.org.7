Return-Path: <linux-kernel+bounces-750354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D362B15A84
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BB01655B8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C89625DB1A;
	Wed, 30 Jul 2025 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="slyO+lRl"
Received: from r3-25.sinamail.sina.com.cn (r3-25.sinamail.sina.com.cn [202.108.3.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3580256C9B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753863902; cv=none; b=XIja5vtjNyt2/h3I1DbmBXI2tfr6sooNi1GpLk08jNB8p5O4VzKv7uE+HcdCYUHz9l+/S34QRDHS4sl9Lrjd3hD/BDWnBIv7kwp1RMbmMHhYsLThUxtNLebDTu25giSU2Wk1JUszMCU2DJX7VNqQT3vFtNkNKuHK3zHQsjouK+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753863902; c=relaxed/simple;
	bh=LVf7z5IkvtAjn2TNPIEjestIOqBN+8Nl5a05xdzNjfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iU/AvO/rZhWgbK1T6lJcfgoyw3xJUWeOo47s+zWXn76+Cm04eFnIeTbqBgfh/U9mqFYB99EkHFMmFUqDP7aOm/mCGbmYuDNXRzhs3Srb0z4DPt77v+plAveDXw2AN/EPfgMxN+zkK0xhuj2XP3fOHTeQLa3rExQxbW1SoslGRIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=slyO+lRl; arc=none smtp.client-ip=202.108.3.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753863896;
	bh=R/V85lJkChw++muQIWdlTZ35MpoKx0BuIaUTHp/ov+I=;
	h=From:Subject:Date:Message-ID;
	b=slyO+lRl7pskrER5tYj3mtTZK+0nZQ6+kZx0mgiBmm7hp14n99S9jGya8Zi1aUB1O
	 fkHd2wr+DtxeLayNnPjDilDbKEpUDbp9MBxG+HzmZv79Gkv9KDyEMB7l3spU6gmL2l
	 ae2bWZYxRs2eNd5/R1Xle0/F6gO9Yjg4X29S+fhI=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 6889D6AD000028CF; Wed, 30 Jul 2025 16:24:15 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2958436816282
X-SMAIL-UIID: ED8C2EF7B88E4EE4B8599A563CF568CC-20250730-162415-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9921e319bd6168140b40@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fuse?] WARNING: refcount bug in process_scheduled_works
Date: Wed, 30 Jul 2025 16:24:03 +0800
Message-ID: <20250730082404.3487-1-hdanton@sina.com>
In-Reply-To: <68894408.a00a0220.26d0e1.0012.GAE@google.com> (raw)
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 29 Jul 2025 14:58:32 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ced1b9e0392d Merge tag 'ata-6.17-rc1' of git://git.kernel...
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15c89782580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d51af648924b64c9
> dashboard link: https://syzkaller.appspot.com/bug?extid=9921e319bd6168140b40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177f7034580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165e44a2580000

#syz test

--- x/drivers/md/md.c
+++ y/drivers/md/md.c
@@ -632,10 +632,13 @@ static void mddev_delayed_delete(struct
 
 static void __mddev_put(struct mddev *mddev)
 {
+	struct kobject *kobj = &mddev->kobj;
+
 	if (mddev->raid_disks || !list_empty(&mddev->disks) ||
 	    mddev->ctime || mddev->hold_active)
 		return;
 
+	BUG_ON(kref_read(&kobj->kref) < 1);
 	/*
 	 * Call queue_work inside the spinlock so that flush_workqueue() after
 	 * mddev_find will succeed in waiting for the work to be done.
@@ -5983,6 +5986,7 @@ struct mddev *md_alloc(dev_t dev, char *
 		goto out_put_disk;
 
 	kobject_init(&mddev->kobj, &md_ktype);
+	kobject_get(&mddev->kobj);
 	error = kobject_add(&mddev->kobj, &disk_to_dev(disk)->kobj, "%s", "md");
 	if (error) {
 		/*
--

