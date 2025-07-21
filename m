Return-Path: <linux-kernel+bounces-738544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F07B0B9D7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF8917676F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 01:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40279187554;
	Mon, 21 Jul 2025 01:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="WPXvFXUf"
Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5913F1552E0
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 01:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753062885; cv=none; b=BNGrpJJ7noeQGOcBmdMix80yzYSIPPq9kihU6HeF51zpJ3uZEa65fQAifLrJWJPY2SoXyeefet5abptmQ5x+FUVFMRVM/fXXlfGNCo8p6dcqQ9LOCIWCQreaLmIZGsNxNU/ZgDSfu7tLAej748cqzNO8k2+AuxMm9+c9qkpy2Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753062885; c=relaxed/simple;
	bh=MTeILvIWndtm1ffzHzoYdvPwWE9UfV4Rx7MrMAfThPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhJOO5v1Caj5XnpjxtpAqItrxnhI4zGkVJw4+8nPwL5PS2uwmmH/zEMxT9bISYKbi68frj1W4eNPDREXKs7UxuosXaX4MFdN0WIl2ePxMIPQJAd1+rCAarMXrKMTKIYSCjf+MYt89XBgr6rrNAnazd30biZzMip+gw0ydLcB2ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=WPXvFXUf; arc=none smtp.client-ip=202.108.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753062880;
	bh=SRgqWfSYU2IOF/GWkWH19U+vCR6e26EDXiwGfe8nhEk=;
	h=From:Subject:Date:Message-ID;
	b=WPXvFXUfnDcfW5gkFFHzs3HtHOvBTk/Zi2NUH58h5DIOP8FE2DiZbgfDOqketfZq2
	 UkpKKTY5ij5d6yvdI0iEehU7ATNpCCPkSffo8xvYmZ8dF1UgbUZbFm/hsjzY5J4vNa
	 Z2xGJOaHQI6Kmk5N1bek1mN1pNap0CeE2kwK/1mA=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 687D9DB300003481; Mon, 21 Jul 2025 09:53:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5011026816558
X-SMAIL-UIID: 992DC0AA2BF14D88B1685A709B085724-20250721-095356-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4bb2305559463e8f6a2a@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_iop_getattr
Date: Mon, 21 Jul 2025 09:53:43 +0800
Message-ID: <20250721015344.2609-1-hdanton@sina.com>
In-Reply-To: <67f82b19.050a0220.355867.000f.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Thu, 10 Apr 2025 13:33:29 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    2eb959eeecc6 Merge tag 'for-linus-6.15a-rc2-tag' of git://..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16fdf23f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4c918722cb7e3d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=4bb2305559463e8f6a2a
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1352b7e4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17499d78580000

#syz test  upstream  master

--- x/drivers/block/loop.c
+++ y/drivers/block/loop.c
@@ -443,9 +443,8 @@ static void loop_reread_partitions(struc
 			__func__, lo->lo_number, lo->lo_file_name, rc);
 }
 
-static unsigned int loop_query_min_dio_size(struct loop_device *lo)
+static unsigned int loop_query_min_dio_size(struct file *file)
 {
-	struct file *file = lo->lo_backing_file;
 	struct block_device *sb_bdev = file->f_mapping->host->i_sb->s_bdev;
 	struct kstat st;
 
@@ -497,7 +496,8 @@ static int loop_validate_file(struct fil
 	return 0;
 }
 
-static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
+static void loop_assign_backing_file(struct loop_device *lo, struct file *file,
+					unsigned int min_dio_size)
 {
 	lo->lo_backing_file = file;
 	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
@@ -505,7 +505,7 @@ static void loop_assign_backing_file(str
 			lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
 	if (lo->lo_backing_file->f_flags & O_DIRECT)
 		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
-	lo->lo_min_dio_size = loop_query_min_dio_size(lo);
+	lo->lo_min_dio_size = min_dio_size;
 }
 
 static int loop_check_backing_file(struct file *file)
@@ -532,7 +532,7 @@ static int loop_change_fd(struct loop_de
 {
 	struct file *file = fget(arg);
 	struct file *old_file;
-	unsigned int memflags;
+	unsigned int memflags, blksz;
 	int error;
 	bool partscan;
 	bool is_loop;
@@ -581,9 +581,10 @@ static int loop_change_fd(struct loop_de
 
 	/* and ... switch */
 	disk_force_media_change(lo->lo_disk);
+	blksz = loop_query_min_dio_size(file);
 	memflags = blk_mq_freeze_queue(lo->lo_queue);
 	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
-	loop_assign_backing_file(lo, file);
+	loop_assign_backing_file(lo, file, blksz);
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
@@ -974,6 +975,7 @@ static int loop_configure(struct loop_de
 {
 	struct file *file = fget(config->fd);
 	struct queue_limits lim;
+	unsigned int blksz;
 	int error;
 	loff_t size;
 	bool partscan;
@@ -1043,8 +1045,9 @@ static int loop_configure(struct loop_de
 	disk_force_media_change(lo->lo_disk);
 	set_disk_ro(lo->lo_disk, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
+	blksz = loop_query_min_dio_size(file);
 	lo->lo_device = bdev;
-	loop_assign_backing_file(lo, file);
+	loop_assign_backing_file(lo, file, blksz);
 
 	lim = queue_limits_start_update(lo->lo_queue);
 	loop_update_limits(lo, &lim, config->block_size);
--

