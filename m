Return-Path: <linux-kernel+bounces-783225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4057CB32ADB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D015A3AAD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD7D215179;
	Sat, 23 Aug 2025 16:31:35 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175E5202C58
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755966694; cv=none; b=iiceEQ+HvTyej832cPo1g+piyLFzbsoHijp24ecQBE05V5buQta7lk2TXeZP5Sh1dll8cB+5Tz90peM/KFxfP+DYptsWgbSFEePNtKfTdWJLsm2dvhnnF57yzTewqgei8LkzjxYYXBwYssXCYKJjAuAtwy41/TCIvBfSMNzS6xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755966694; c=relaxed/simple;
	bh=hoo0x+gEH7iZlgPOKew4cUj34glxKTGakvspYipyTow=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=epblPSI2ej56Fiml3aTEGlGJYVbfJQ3NHoiUOfeZGIDTeH16YSHhVmBGWVEWMd2xVHAH+oawTTXIK6DDcLSnei8pIDRlWxZYIoLUj0pqEGY6qJNhOF9nWUUX5sF+nNc/HrP4c4BVlUoifHvmXB2e2RiALL9w0HYme5iO5wXD6Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3eab737b99cso5061665ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 09:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755966692; x=1756571492;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHv33q9ltfCocvMdwHSFsTpUPmOGS5z30Wm1W0NFv2w=;
        b=ftD0zUWZarbN4ghcb/N1t/31ftSuQAwxK1Si1jezrisvEM+pdaKLa9iAJzlbHu9Z90
         KAE5cjowGRHyD6MIxauFumuhngRTR+kvKBcv7Jcw5UqlGKOTQrC3NxMFkT/milynNkKD
         5Lc+XssHAyOrQEiPq8Yzj8FnPA0XdCNOaNFtyxWiyjGLFz3QI3vKg/k7YfqOssSgmKlT
         MDMnqXztbiOpEkAN9hpy+oT+osHM6NW1yjZGFkURDDU4KIFVhGS6cZMa4rijNxQX4PJz
         l2UELBevBRlaASacDmV+2YgUGNKJd+HrWhYv/b5u3S7KvRXC1+N1iHqsIll+slmDyDYm
         jYzg==
X-Forwarded-Encrypted: i=1; AJvYcCVdSOM5F/rUeZ9yBLpQ0Yxt7UUtGjEHTXjQhFywd3HolW3ULFnxoUNsomuLZ1IEl74NCyzG2SmsGD7RuUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnOo9L/IylpJQ70rdgepxliTiUbtY5b1I/VE27BfqBmG01Qjca
	yFQ3AQ8g7FPYzV1gTrEPhWRgCrPDJGWO1wlOqu3Hdx1REef+lkL2xrn7TEIJX5xhzcgvvFObPkd
	X5FH4ibr8fJdtrMR3Z3kV2sHAwVqXBZZviPL07xfNV6TnM8SQX1bpD05cxO8=
X-Google-Smtp-Source: AGHT+IF6Tfp2VNYDcZUSmpcuYAeZn7vJwvVWCyMRTdvjlwAHlgV6P1Qi4eoDFtRInJTnca7iFFEha/J6U8xwWIHJZvYK6DoDy6/0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e9:b0:3e5:75cb:44fc with SMTP id
 e9e14a558f8ab-3e921a5d155mr119122465ab.12.1755966692271; Sat, 23 Aug 2025
 09:31:32 -0700 (PDT)
Date: Sat, 23 Aug 2025 09:31:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a9ece4.a00a0220.3557d1.001f.GAE@google.com>
Subject: [syzbot] Monthly jfs report (Aug 2025)
From: syzbot <syzbot+list00c376a6da959bb421c2@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 55 issues are still open and 64 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  62723   Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<2>  33520   Yes   WARNING in dbAdjTree
                   https://syzkaller.appspot.com/bug?extid=ab18fa9c959320611727
<3>  31065   Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<4>  7046    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<5>  4338    Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
<6>  3652    Yes   INFO: task hung in lock_metapage
                   https://syzkaller.appspot.com/bug?extid=1d84a1682e4673d5c4fb
<7>  3419    Yes   INFO: trying to register non-static key in txEnd (2)
                   https://syzkaller.appspot.com/bug?extid=5b27962d84feb4acb5c1
<8>  3371    Yes   KASAN: user-memory-access Write in __destroy_inode
                   https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3
<9>  2512    Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<10> 2416    Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

