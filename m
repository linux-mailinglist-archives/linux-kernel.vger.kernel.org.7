Return-Path: <linux-kernel+bounces-785794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE164B3511C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7013ADF08
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 01:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAB31F8691;
	Tue, 26 Aug 2025 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="aq2Eh6eB"
Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn [202.108.3.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA511EF091
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756172629; cv=none; b=iWeaclZ2NbJzJy2nH0AFrbURWGYxSyzBiXdShrRGP6iVSTLY5k+OX27hKmhGp6RGxWg2noQkUswj3xdd78EPyxThslLFHTTG+JQQkITn8fJnO3MhNh60V8XMOSTFWGUCo5RgOyT2JTkwIgfzo+hzLppIu65Caqrw2KMSHarWMRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756172629; c=relaxed/simple;
	bh=UXZKR5dF4NX11pKVChTvXuOq4IVYEkXj264KHcdHcaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzNv0nRCDbfkiVHfNpnRTyVi3/D8qX+JR1QMSDCD/H0WsnlDJLPoICyvqemct7b0W4eWx/P/tBl+L+tWZGJXwvyuUjSSqJwnQ5JUR1X3fJmK5rBhHY0d4KKhzrpfUttpZl3dqernn5+OjoDDklOsk/NqjlHizIlYnkaFkNi1yYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=aq2Eh6eB; arc=none smtp.client-ip=202.108.3.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756172624;
	bh=Tbhnr0l1zaZOva43TI8YP7AIx9ZfJ0Pg9NZx9yR/fxM=;
	h=From:Subject:Date:Message-ID;
	b=aq2Eh6eBFFJLrIHcSSnA2ixXy6QXrTJWbzXepTjVA0YOc/jZ2Pl2hlmaMWoCG8/7J
	 6POq/XLHW4esIr8CTbxoLqhxyhkYZqy8ACdFYnxmlxsPzfv8xFgk/x0p/xhfkT8ewz
	 1BmGkuGBPxBh9SHD+9djpqvuOPuxibUTZFGgs7U0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68AD114500004683; Tue, 26 Aug 2025 09:43:35 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1098236292010
X-SMAIL-UIID: A20D0D8576D448AF976B4696FFC99B2C-20250826-094335-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c5c9c223a721d7353490@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_truncate (2)
Date: Tue, 26 Aug 2025 09:43:22 +0800
Message-ID: <20250826014323.5493-1-hdanton@sina.com>
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
@@ -4645,6 +4646,7 @@ int ext4_truncate(struct inode *inode)
 		ext4_ind_truncate(handle, inode);
 
 	up_write(&ei->i_data_sem);
+	subclass--;
 	if (err)
 		goto out_stop;
 
--

