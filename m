Return-Path: <linux-kernel+bounces-581905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F76DA76694
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 15:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AB516A9F3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 13:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEE2211466;
	Mon, 31 Mar 2025 13:08:23 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2CC1DF73C
	for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743426503; cv=none; b=sXMPRdgBujWWG3S3OyxswZa/yxOWQkn2W7kUllfr2K6SZNubvL+dGQPLroKZ6jrGGs/PxjT4uVN4cnnFO0v1xqd9AFYB1Mh3CSPFK6TxBLbdxuC7PJl5Gq6RBG8UBCR8lt+v7Qd7CjiH9tN57RmnJ98a6gZ9e/pfgSxbgmgzKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743426503; c=relaxed/simple;
	bh=lQcciuXGdeI+gMHGUsufMwWOrrIFBfsxM70zLAB5wC4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=V8FRsKB5+6877KKLQao2flENthSAjv3vy931K4AZbW1vXGzigg5Q/j84lIw/aU/VOnUfsQ6ewjoE2vNKsIPlNwgUKPgdrtaS2jnEtZIfjMWJsN69Sp5tEQo2DHkM2VPJBx+dNVZjuRr0mHc70FJshOvsG0KjcMXi0TspTxPlZZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-849d26dd331so516585139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 06:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743426501; x=1744031301;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQm97m3F2hf17H9sSC0zFvTaV5xTq5eG+zcc0Ysc7gY=;
        b=MPk0j0vd323TXiuC4I7JkybUMSJj/82GvqPrrwRx6U2d2orqrUjzkGC9ELhUYuKHZK
         ndD+MD8QXZ+liy+BFWuuObI8t1UHMMSm5dsZsjXYsOYZGQ7/ZHsuZJgTjiV4xsiUYEiN
         vYlIZMkn44bVxFuUdlbai5yGwPm8Xp7v0cBUoDT11zcj80Hcguk3MyRPnQm9lyTDu7U/
         0DE0sbuiSqcUVeEHplIHVY0WpjZDA1rKDPGjBRmktOuS31A5iJac2s+0Tl2Mrg/SrI0r
         +f20oSg5J41mMSe7rzYS1Jlj7P6DpDMeq0OTzvSBL6Z76FetKhFtgE0FGbMVqxlGR4m9
         QkhA==
X-Forwarded-Encrypted: i=1; AJvYcCVQvFzwtkTVHmgfW1eCCDGjGjBxPwO73gs+vwXCYtGz92tMl1xQnGwBnN0+UIIOfcezxuX/yNmYEzzaxtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6wPlLOEann8eaZu4ZgGxu1pCxJIuHSFGKNg4pXs9S7XZk23YD
	cPAjaFLs+TQipnhvfdPOtdNeZp7+zjlKAO5eNYWozpMQKIhg2WKFcegn3UI7UKUA6m8YUgS/GcA
	XBlRj2nwJgXA0Vvvq6wHxpXAqma695S4bvzzBnVPr/zjG+yBFvru+QKM=
X-Google-Smtp-Source: AGHT+IHIaGFv45CH9yP1SffeoWvG2028p1ktltDelf5T5UC2qndIIoinYo63hKIwG71cL4xQRElrEOk1KdPJWahGv071nX2vW6XE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:3d2:ed3c:67a8 with SMTP id
 e9e14a558f8ab-3d5d6c8346amr107275575ab.4.1743426501208; Mon, 31 Mar 2025
 06:08:21 -0700 (PDT)
Date: Mon, 31 Mar 2025 06:08:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ea93c5.050a0220.1547ec.0142.GAE@google.com>
Subject: [syzbot] Monthly f2fs report (Mar 2025)
From: syzbot <syzbot+listcca4438a6792bfb39532@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello f2fs maintainers/developers,

This is a 31-day syzbot report for the f2fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/f2fs

During the period, 1 new issues were detected and 1 were fixed.
In total, 9 issues are still open and 57 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1246    Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<2> 59      Yes   kernel BUG in f2fs_evict_inode (4)
                  https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
<3> 11      No    WARNING: locking bug in f2fs_getxattr (2)
                  https://syzkaller.appspot.com/bug?extid=44090b62afaabafe828a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

