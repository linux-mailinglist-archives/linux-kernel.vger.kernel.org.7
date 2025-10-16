Return-Path: <linux-kernel+bounces-855744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9A1BE22BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23FED4EE1CD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D29305E19;
	Thu, 16 Oct 2025 08:36:28 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049712E7647
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603787; cv=none; b=fKRaihVxt0SeT1iYdE3aClOk/toMdU7jBVVUflDT2HFdUDVx+zD4PwUlpEPhQblkRpt9ROQKoMMYNxDMhf/oqQvvxwlzz+hN1pnwFVnlzWtg+a/rZ6bSUXlrJ234bzzjzv2+CEEyvs2zLH241a/6UFogw3qwuMz9iHesOANff1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603787; c=relaxed/simple;
	bh=SdcHay0WXkFqLNNCg32vsm4Xob0lPiDeLJwuqqs+4EA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nUOIN5zSz3Cliubpg68RGSeTnBqohU9fDPNZ9BLJ8vQOaZCL80JtH0WLMuf0lR60t4P4aF+Ejc2H91MLDJqELzuwww+RB96pxl1vut6e9IuMs4fXNJzNdaCdEy/43/a8sLEQFhu3k5K0BnLNnh0Q0ZOw4XI8uNcGJMLLmJQBD/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430a6113286so5961705ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760603785; x=1761208585;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ODVMCUuglEM66AgpA48vPPpWwPga7eh5csdCvtlp0w=;
        b=NGsCaf4jFDpSoyk49BhefUehjY3mj0HE8WjRskd2rU0P4USfUTaPult6w1jvctw9Ev
         eBhMiuk9NwwfRU/eVf7G3vQQ+wsITF47v+xchR67+jtv028tOB0IfSZHJOXQ90BIX+Jx
         q/+nweSeIRiwxo9PBeFeX8tF6xqmnOH2f7xjbbHhoSKXyZt2SWDinkCgLgZI6Z5oDAG6
         YmWY/gjtbKeIyBEs/TlBjXbVHFI5ikM/XAGcBBl6ESDhSfGZ6HNtDCZdD+ffdcaOseMd
         mIplbb8aAwcas9wIEcIbcDJ3KMCsHkmpLM9XFii/CgM7xWeyxTjZ58o5mjxxsyG2389f
         RHAw==
X-Forwarded-Encrypted: i=1; AJvYcCXxszySJJJc56okUYftJsZ9Nm3jM/sD7QymcMUQEExLqSnAJBSDwUKkCehj+qP9Z3OVzRp34mZTbOIyogs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpinl1j6QFTuBcQnjPersFAX/AHUXaaSjB94GxNcdQv0hZNqmt
	0GEyEBmf7hy+9XDYz3Mp8XZ9obw1h+GU4L7kDsTi82SRiXrN67Uh2U0ywMovP3D/z/YyvkmITPd
	37Xmb0Td4fr9ucw1NpbOTc9CPxz8oQHiyu25Trj8lIQacHdsHgtCUBsQd6PA=
X-Google-Smtp-Source: AGHT+IEX9O7K4PDPS1zDzFSGCyp3SKlA5AHnJSa9vWaniPBHBnSu4kMAi8FP5SHL31UgC6/3gErOuM9yQRG3zmWv4YMSYD+mX9cJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1523:b0:430:bf84:e941 with SMTP id
 e9e14a558f8ab-430bf84ea22mr7550725ab.3.1760603785165; Thu, 16 Oct 2025
 01:36:25 -0700 (PDT)
Date: Thu, 16 Oct 2025 01:36:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f0ae89.050a0220.91a22.03e0.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Oct 2025)
From: syzbot <syzbot+list0466b925309ecf3d9218@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 3 new issues were detected and 0 were fixed.
In total, 34 issues are still open and 39 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1415    Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<2>  641     Yes   INFO: task hung in __gfs2_lookup
                   https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<3>  477     Yes   WARNING in vfs_setxattr (3)
                   https://syzkaller.appspot.com/bug?extid=5ce48a14916462cec450
<4>  409     No    kernel BUG in __gfs2_glock_put (2)
                   https://syzkaller.appspot.com/bug?extid=ef4ad020dc976d178975
<5>  381     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                   https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<6>  292     Yes   kernel BUG in gfs2_jindex_free (2)
                   https://syzkaller.appspot.com/bug?extid=150563285f78ac3e9bd4
<7>  195     Yes   WARNING in do_mknodat (3)
                   https://syzkaller.appspot.com/bug?extid=0cee785b798102696a4b
<8>  137     Yes   WARNING in chown_common
                   https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
<9>  98      Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                   https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
<10> 66      Yes   KASAN: slab-use-after-free Read in folio_evictable (3)
                   https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

