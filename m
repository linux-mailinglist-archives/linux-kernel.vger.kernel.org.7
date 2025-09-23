Return-Path: <linux-kernel+bounces-829005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A8BB9606A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E432E6024
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72F3327A20;
	Tue, 23 Sep 2025 13:33:31 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2893233FE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634411; cv=none; b=GZ1asU/7wDUPwkDpX8qTGQN7bADZivB10Ob3uPqyEkFIY1fxvDfQBUxcSQKqwBadmYzV+XUQXytmduKeHuNGGR74578z0FnRqe7aJkNYi6HfmCwroUIrnRKP8hRQbc/hJGx0+AwWejuQrQkeCbVu699LVe6ccU3z3NzB7WmVP6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634411; c=relaxed/simple;
	bh=E688SA2ur8pdhDMKGP0y0zNwUkmL1KK0E2KKszEQgu4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RhfigrwAFhznwu173HRurUwOqE8PbPojC8UqTmYvr3ca5VLZ8K3Lz0sIPDEPkQbS9M4GvtCERz35NCyYM7LmsFb2KJUoN3NQvVA7Vv6NM1zmXPp8mZdMPSBfQzaoNjNBZFT1mDU5bgGTLyB/aqyDZBSR8UpcBb0c4nQgmrN0YXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4248b59ea91so94312815ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758634409; x=1759239209;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CnFEheBcFQ9GIZwypq53PINvHcyzivG0Keb/zGJdWl0=;
        b=H7KDdCSs1lnlixKo9sXoWw0w+EUrrqpGO49a2Uf5Ip5LiC4XQhHV8D8FF31l9q+JbJ
         Id1fS+s63OECCRXHI1qh9Uiqh4XV3VvCkVpsfeRjW9OxDFqYv08Vd1qZIEjZxD4GPAn5
         l2z0cc417nslX1UtGGPnDYyiWxEqwBAGUQkRBrvfZrQavF+XvQrilhWTS8yYz9uJr22q
         N0iVpWxHDYj2xVDpj1us3+vs3OY8ArKgH9QfkHx7FScuqpk3OwkiaSpAa029vjrY1ZqI
         br35F/8q1jsgHPhEg4bzuKBkTofw56hVrcUZb8/VYNfR47VuCmKJCh3pUcsu9Xukg3un
         58/g==
X-Forwarded-Encrypted: i=1; AJvYcCXYk0olRZXBngJdzsyoBNedFOwdkqu+bOzj7J4WhjHwJQoRX4WF6oUp4TFsG2bkXhQ4+wICs83pmF4lzg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4lqeu8Ou7+KrnJEsKBPB7A7jLTF9RXBFyNQ0BLU9+MmuIcrcR
	/073JhUib6l6EuN+V8MXVGzjvEl5lJA28j5SlXkr0mG1lkSXkqhYWzmTiE8RJ58e5S35pjK3PpK
	P+rzERM62MhLO5w6+e7JxxNBLCi8s+ZvTvageWHVQ2mqZgBko/RkdBdNb0hY=
X-Google-Smtp-Source: AGHT+IF+wgIXgkOJXcUn4ha1722njeR7A5N05y/cuCdCL5x3cjEn8+ifFpSsGAZYXL0xgQJe5WK/skelzVAZKneqRyB31DVL7ZCT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:471b:b0:425:8744:de85 with SMTP id
 e9e14a558f8ab-4258744e0cfmr18369315ab.26.1758634408705; Tue, 23 Sep 2025
 06:33:28 -0700 (PDT)
Date: Tue, 23 Sep 2025 06:33:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d2a1a8.a70a0220.1b52b.02ac.GAE@google.com>
Subject: [syzbot] Monthly kernfs report (Sep 2025)
From: syzbot <syzbot+list16151cba7370e3751c41@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernfs maintainers/developers,

This is a 31-day syzbot report for the kernfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kernfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 26 issues are still open and 24 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1201    Yes   possible deadlock in kernfs_iop_getattr
                   https://syzkaller.appspot.com/bug?extid=4bb2305559463e8f6a2a
<2>  480     Yes   WARNING in kernfs_remove_by_name_ns (3)
                   https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
<3>  473     Yes   WARNING in kernfs_get (5)
                   https://syzkaller.appspot.com/bug?extid=2f44671e54488d20f0e6
<4>  359     No    possible deadlock in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=65459fd3b61877d717a3
<5>  121     Yes   INFO: task hung in kernfs_dop_revalidate (4)
                   https://syzkaller.appspot.com/bug?extid=da20d108162166514db6
<6>  109     Yes   INFO: task hung in fdget_pos
                   https://syzkaller.appspot.com/bug?extid=0ee1ef35cf7e70ce55d7
<7>  91      Yes   possible deadlock in kernfs_remove
                   https://syzkaller.appspot.com/bug?extid=2d7d0fbb5fb979113ff3
<8>  71      Yes   INFO: task hung in kernfs_add_one
                   https://syzkaller.appspot.com/bug?extid=e4804edf2708e8b7d2a5
<9>  59      Yes   INFO: rcu detected stall in sys_unshare (9)
                   https://syzkaller.appspot.com/bug?extid=872bccd9a68c6ba47718
<10> 52      No    possible deadlock in kernfs_fop_readdir
                   https://syzkaller.appspot.com/bug?extid=8fd10d8928ed1f715290

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

