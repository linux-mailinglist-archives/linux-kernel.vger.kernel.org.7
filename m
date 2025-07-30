Return-Path: <linux-kernel+bounces-750115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEB4B1576F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 04:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D6337A1CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DC41A08AF;
	Wed, 30 Jul 2025 02:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="EUfiOjrV"
Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB21156CA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753841345; cv=none; b=MOw9YRVXXj3YcnmYzBDFlBpwvXTrzXfWvhHsW12NTjTg2gEX9oL1GAcS8JjlCHHezwNpkp/ztZkNxcHHNCEAegE6gk/JzVz3NkYRc0PAXy7IQxPcBMUet8rooWWNRgfVXJJyg9ZcazaWlkJLNFmkCpUgiy4wuL6+xf6srlq8Al4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753841345; c=relaxed/simple;
	bh=o9KBsZRW9asy9Vyz9ECeG7Nlcg5RkCPs98yedGaU8eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caVtWPCw5bu7cxmyi3rE2E9N8jVLhUkVy26qARzCMD1LbVk6oZe1HyWpKHGx3fe54X8pp/pe2F6DWdo09mgVWp/4O6ipa4cGbfTIApd3JdO4F0tukdVj1f/afuDsbeFryUA8TEb8tbF4zJAMYVeL2B76ls7nQEaVooEwdYWM3Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=EUfiOjrV; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753841336;
	bh=yY9jez1HB94PtjWZDN5sbboUpAgoKw097P/B2TR9a1Q=;
	h=From:Subject:Date:Message-ID;
	b=EUfiOjrVViTZsAh9rv9GO6bjaAqlrEP6nSKhVn/yVumRU1H+xXqJmnO5WwkSd5vZ4
	 9rmQgrPm4bDEfjPh+cEJGFzhykoQ+2xDbxMv+7PtSpGglYZX2lWgFELtbdGxCG0Too
	 Vt1oxGzN67DS4UxMQ5J91L4NatMSnJUrfajp09Es=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68897D6E000045B4; Wed, 30 Jul 2025 10:03:28 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8040466685343
X-SMAIL-UIID: 9E0DD5E463AD46BD991820629B4AFB70-20250730-100328-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9921e319bd6168140b40@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fuse?] WARNING: refcount bug in process_scheduled_works
Date: Wed, 30 Jul 2025 10:03:17 +0800
Message-ID: <20250730020318.3428-1-hdanton@sina.com>
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
@@ -710,6 +713,7 @@ int mddev_init(struct mddev *mddev)
 
 	INIT_WORK(&mddev->sync_work, md_start_sync);
 	INIT_WORK(&mddev->del_work, mddev_delayed_delete);
+	kobject_init(&mddev->kobj, &md_ktype);
 
 	return 0;
 }
@@ -5982,7 +5986,6 @@ struct mddev *md_alloc(dev_t dev, char *
 	if (error)
 		goto out_put_disk;
 
-	kobject_init(&mddev->kobj, &md_ktype);
 	error = kobject_add(&mddev->kobj, &disk_to_dev(disk)->kobj, "%s", "md");
 	if (error) {
 		/*
--

