Return-Path: <linux-kernel+bounces-787893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C75DB37D54
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C1C365755
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE966319860;
	Wed, 27 Aug 2025 08:15:36 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AAA277C94
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282536; cv=none; b=PJwNwcfpQGtyfWSeroPWMOmhRNzFbYErsB2XZayflD/YXo8DsL1eWQtcEaoA9swfktHT8dzcBxpPAAaqfoKBoY5nqOGC9rTxeI4H+QhZGxcZDVrExDfkAKcxry7GrsoAaZROfP6gCg9JuX6tVGUCZ+y1wofFQSl/ZlThp651484=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282536; c=relaxed/simple;
	bh=m9fZPyREP9mMFo5dFbqtZdxitG/UM8cTyXcCwjYqFmA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZwN5kwRHdQpBdFc0bCT/pMgjy+yY+EdP3kGFl8/Rg+AchTDjwzkwM5DehVuaYdVcNrE2ofUq83x/wuFtU3UkENCJliYgn5EHDOkeT+ye5tcHPlweqVLo66+7TCJkZNV5YyxSTvgzsXF9ywRg+YQP3GNqv63nqxhMvCTUuWpJSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3efe9b72960so7154935ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756282534; x=1756887334;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k03l+q/FPZAUzkeruzpDHLoZk+YpUT83RQwZwMZ2xes=;
        b=fGWsNqhrhKeTo/MdlMUdbSS1AkP5nWmpiQXam40wsZFVzJOwjHLv3cO7nmUHZsKcTz
         ZHCnEC0sgT0Bj6jnE+tCx82CdCdb21b8NTwESHaHNCQbSnzvjLUeSpzq/1TXA5iW/eRP
         sMFu6r8rOirePR4sf3Y8NED9KA8+SWPFlqQ6bC4m/xxuzH0eO1GetPJ/NWwPJ+32Bs7h
         sMvjCb6vWo/qj5W3wvNHbnTVEfSf+AUmNn5hXrYxAIm0GhRRRv860tMuwWDcabpQm6cB
         HYn4O9PQ9g7XxsZtQc7KQvqNL+q9xZpwzl2fm+MZR1/CnyG3mjte1aLUYgXMkFCVZxPk
         jZ8A==
X-Forwarded-Encrypted: i=1; AJvYcCWCNUL+o9omXs+TuWURzcqLBjlf1eZbSw08nqDx2Mec/F4SOPgEYN3YzNire/EXztXWdexSHkXXjzsoKTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJoDCOrpOgZrDERJla78vLi8HuZ17E6maY1xDnTv9ubSkRhgk
	NBZWVJ6+M6/maVvmdsRODwXoWR7xc048b02ltznrTPOndgjHtB+DsrQtR+Zg5GIPlu4TClySxXF
	lWMOWY+0Ws5t1myKTxJHM6ZLXx2lHnsXWAzvBTFjOrmDFsvygTuX/9y6YyCw=
X-Google-Smtp-Source: AGHT+IGPV1rmArovvxBES9M6nYuG/AQ0qtDQVHQmVeIxOvvA2ISNOPKVqA4rbcbm1J7DmA3RXVNekHGR3ZyEWLZ/ZxmOlNPShute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e1:b0:3ec:88e3:903b with SMTP id
 e9e14a558f8ab-3ec88e392f1mr150014815ab.24.1756282534104; Wed, 27 Aug 2025
 01:15:34 -0700 (PDT)
Date: Wed, 27 Aug 2025 01:15:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aebea6.a70a0220.3cafd4.0013.GAE@google.com>
Subject: [syzbot] Monthly block report (Aug 2025)
From: syzbot <syzbot+list17848dc1d79bb6dd245d@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 2 new issues were detected and 1 were fixed.
In total, 42 issues are still open and 104 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  44250   Yes   possible deadlock in blk_mq_update_nr_hw_queues
                   https://syzkaller.appspot.com/bug?extid=6279b273d888c2017726
<2>  43987   Yes   possible deadlock in __del_gendisk
                   https://syzkaller.appspot.com/bug?extid=2e9e529ac0b319316453
<3>  6788    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<4>  2605    Yes   INFO: task hung in bdev_release
                   https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<5>  2281    No    INFO: task hung in read_part_sector (2)
                   https://syzkaller.appspot.com/bug?extid=82de77d3f217960f087d
<6>  1685    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<7>  1384    Yes   INFO: task hung in bdev_open
                   https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
<8>  747     Yes   INFO: task hung in sync_bdevs (3)
                   https://syzkaller.appspot.com/bug?extid=97bc0b256218ed6df337
<9>  574     Yes   possible deadlock in elevator_change
                   https://syzkaller.appspot.com/bug?extid=ccae337393ac17091c34
<10> 105     No    KCSAN: data-race in block_uevent / inc_diskseq (2)
                   https://syzkaller.appspot.com/bug?extid=c147f9175ec6cc7bd73b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

