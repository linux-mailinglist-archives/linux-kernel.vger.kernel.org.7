Return-Path: <linux-kernel+bounces-784531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BBCB33D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8447189CFAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784992DECB9;
	Mon, 25 Aug 2025 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Ogy7x/Gb"
Received: from smtp153-162.sina.com.cn (smtp153-162.sina.com.cn [61.135.153.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2078A2D7DC2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118543; cv=none; b=WK5F7cvwJKFmUvIV87XtlSaR0X696srXwtzeGeI6BEsdiiii+Gz2ZNkDNjcPOt6OWviU9208kmBE2LIhHmcWZQCXrG+SQeE7eTmt1u88yVmIJe/o+DCom6QLx+wgTB/9AEsLFrs9cY2PUDtMKgdmiRyu29+AU+AFm5FBdS5UW20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118543; c=relaxed/simple;
	bh=gHmttsVtAfpvJQmj23sMSruEoqi1BFyRp2BrUmg0OBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIzpWbfWr2ppUWVSdwfFEut9G1ikRD0sDgiasJox+2SUebY7mA6UFKmJHJV+MEWX8NJM788HVu9iyS5k/VZpYvEvY/PfIe1JoglhqbDLqBcC6E2n7s/vMEoUKGgdxuwBJ7p4seHQTbaoixkropQi4DXtbHvstBKUrZrnD4OI8qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Ogy7x/Gb; arc=none smtp.client-ip=61.135.153.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756118535;
	bh=JlegskvpdBwb9bQFfgX3kyWPDFOo5MFwM5Q6/13FiCs=;
	h=From:Subject:Date:Message-ID;
	b=Ogy7x/Gbq5ClGYqvnvrnmsnovIn5XUOLbcKwvzmYD2MEuUKagBH+JyBfgPBWR7cIY
	 GsvVFrMj/r8+S12adjnMTW0AJSjUt4E74RkBVFgP7G/Z4gRNxzqFg8lHn8cVea8TvX
	 7M8hOcjAgb8OuWHVxLxZylEa04H08cLUZM60M9fM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68AC3DFD000063AC; Mon, 25 Aug 2025 18:42:06 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9522596816215
X-SMAIL-UIID: A589EE98F9B44F0DBD28E47B836A7A3F-20250825-184206-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c5c9c223a721d7353490@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_truncate (2)
Date: Mon, 25 Aug 2025 18:41:52 +0800
Message-ID: <20250825104155.5420-1-hdanton@sina.com>
In-Reply-To: <68ac2412.050a0220.37038e.0089.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 25 Aug 2025 01:51:30 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8d245acc1e88 Merge tag 'char-misc-6.17-rc3' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1654ac42580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=da02162f945f3311
> dashboard link: https://syzkaller.appspot.com/bug?extid=c5c9c223a721d7353490
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d1cef0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f4e7bc580000

#syz test

--- x/fs/ext4/inode.c
+++ y/fs/ext4/inode.c
@@ -4573,6 +4573,7 @@ int ext4_truncate(struct inode *inode)
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	unsigned int credits;
 	int err = 0, err2;
+	static int subclass = 0;
 	handle_t *handle;
 	struct address_space *mapping = inode->i_mapping;
 
@@ -4636,7 +4637,7 @@ int ext4_truncate(struct inode *inode)
 	ext4_fc_track_inode(handle, inode);
 	ext4_check_map_extents_env(inode);
 
-	down_write(&EXT4_I(inode)->i_data_sem);
+	down_write_nested(&EXT4_I(inode)->i_data_sem, subclass++);
 	ext4_discard_preallocations(inode);
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
--

