Return-Path: <linux-kernel+bounces-841026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4E7BB5FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 08:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6203334462F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 06:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF8D20298C;
	Fri,  3 Oct 2025 06:37:34 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CCB1CEAB2
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759473453; cv=none; b=uEJ865KBLgEbUomH5i1FtxyDORjGSl0Dn4mCMLc+zwVBXYcZ9GP51PCrRW+S8hN8WLIGmKXESZIHjCLIsF5sY3U2l8pgkkQgfCl2hHWdwfLPC5lG7kPk9k5UPwRHuIcMN4wZne9G+/ie62iURAMoRq7NBvSoe3MoNFsYTyPTJ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759473453; c=relaxed/simple;
	bh=Iw9xjZ1vWLPSTLaVnGi84/o4A8VHXmGMgcZQsWzTbaI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kAfzdG4VbPg9XOzzfBDulGU7Z0Gnuz9zegAay6yo5Jx0g4Lk4ghLgIxIdpnL3zJfbjQ1dyRZdDIG7HpzaGGRkSiSJzewdItXFSBE1b5FQOZOflGa17D7m5Jjz8EoVxc9nTFt5INx5VTk196u+IelFH1ruUShfolNMOQ/BCv6szE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42e74499445so13173565ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 23:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759473451; x=1760078251;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwfPH6QsY0nv1o1GdekHEB1BRHSJMz8P6fbDeMft/k0=;
        b=YaOh9wcJ8qXfKySFr9beF+17xL6tNsQWNzz2/lZg7oNYXuunNJ1oPgGMzmOcSexGoc
         3QqwAjmoVW6J57ufBhc50czDbZAfxoJfULOQiAeHeq0qZ+RdyKg/dsYLF7vk2gNgWnDe
         5wXAT1zhXDbKJcHPZZR6b8iGb7dVHn7N3lMEzCR+qc8SBjhw5Q4nWz9vs5i+PXcKH9CQ
         mRCURS4rPcHy/iztMSHzR7JvrJZ/rqDHQObEZlYluuN7c91JMzOluk3SM2X3umKHx59+
         XOjACd1iLp6KIbqOYxbWo7hiXGFk/CueWvEj0EPSJ6qM7UgJRir4/Veij8XHlFlDIEVh
         xIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEZxl8IY2ysYdOH/4DAWjX6sDgpwY0EUN3W/b2AV+1MWFngDFlUGeHtn/+6l2XJMwuwpc4nsC+PU6qma8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybTKUCYv7qBM6MmzQP45ds2w4R9yfU36U5LkulmwpFd46NRhYz
	rvmPOIUzdDC4T3wstLX+V5RSu71CBZbHsGsxQvvtc90CngF7XvJnlnIGaZPIbuBcThPgcUIxyQU
	mOUIt10M0zMAbZtRHPJ7SYBnl5V6ybQvIKemWm70Hs8KyZ0RbFpjLBeDWMO0=
X-Google-Smtp-Source: AGHT+IH6Ys1z6GxkrIh1QKXWVeCKFXB29e28kBd0pswO2vcf8bOKMsllkyPPHe5Ns0Wr7tP9v9SAkubuzXBBdbgJsTucOSe3S/Ef
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3783:b0:42d:cea4:eca2 with SMTP id
 e9e14a558f8ab-42e7adb4ba5mr23963615ab.29.1759473451426; Thu, 02 Oct 2025
 23:37:31 -0700 (PDT)
Date: Thu, 02 Oct 2025 23:37:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df6f2b.050a0220.2c17c1.001a.GAE@google.com>
Subject: [syzbot] Monthly ocfs2 report (Oct 2025)
From: syzbot <syzbot+list9f3b98537c8cbdd7becc@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ocfs2 maintainers/developers,

This is a 31-day syzbot report for the ocfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ocfs2

During the period, 3 new issues were detected and 0 were fixed.
In total, 68 issues are still open and 22 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  281324  Yes   possible deadlock in ocfs2_try_remove_refcount_tree
                   https://syzkaller.appspot.com/bug?extid=1fed2de07d8e11a3ec1b
<2>  83983   Yes   possible deadlock in dqget
                   https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
<3>  59630   Yes   possible deadlock in ocfs2_acquire_dquot
                   https://syzkaller.appspot.com/bug?extid=51244a05705883616c95
<4>  30450   Yes   possible deadlock in ocfs2_reserve_suballoc_bits
                   https://syzkaller.appspot.com/bug?extid=5d516fba7bc3c966c9a9
<5>  19560   Yes   possible deadlock in ocfs2_init_acl
                   https://syzkaller.appspot.com/bug?extid=4007ab5229e732466d9f
<6>  18277   Yes   possible deadlock in ocfs2_reserve_local_alloc_bits
                   https://syzkaller.appspot.com/bug?extid=843fa26882088a9ee7e3
<7>  11625   Yes   possible deadlock in ocfs2_setattr
                   https://syzkaller.appspot.com/bug?extid=d78497256d53041ee229
<8>  4857    No    possible deadlock in ocfs2_xattr_set
                   https://syzkaller.appspot.com/bug?extid=ba9a789bd1f4d21fcefe
<9>  3408    Yes   kernel BUG in ocfs2_write_cluster_by_desc
                   https://syzkaller.appspot.com/bug?extid=18a87160c7d64ba2e2f6
<10> 3185    Yes   possible deadlock in ocfs2_lock_global_qf
                   https://syzkaller.appspot.com/bug?extid=b53d753ae8fb473e2397

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

