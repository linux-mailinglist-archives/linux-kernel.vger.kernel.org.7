Return-Path: <linux-kernel+bounces-835080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A98BA6354
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 22:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62EF17D7E2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 20:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4310B238C15;
	Sat, 27 Sep 2025 20:43:34 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC1314A91
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759005813; cv=none; b=uQNTCtKanEOlvfPheToEOoZ8i8PMtKsA9G+ojt3NgdYkK4XQBpRu/gNCcppGvKQw9gYHhj+EOQGR3CZAFE1RuH0YFAZ6g2jV0SrHjRxHHfH6vJOMudPtuAcBwbpgSx2HtDZHUFwSXEHeVKZviprftnKOuqXh8inaEYD++P02zYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759005813; c=relaxed/simple;
	bh=VF9+/08UrQyGYkSmyG+Qk1tbK6/TiYCHA02wWiFDAbE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JnUbTg426tYJjTMD6xQfKIhthtkHKtUFz5tdudCXkGSbCiYO6ZxpMXbA1hsHYh8UpMzLsq5ly4cXY/Cof/ATwCNebtvalH42xkWlbx1tc/SRjme6jeH0JfnJtH3UdY0l1blxLBNwCbkJZydQcrzX6A+e/iTUoDuKgaQREk50eR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42594db9398so89164365ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 13:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759005811; x=1759610611;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XnbVeuxyJuDhtaz+8EpGwocy6j6R3G98UG3mDObVIjg=;
        b=i+GOW4LuYX3wIVPm9WCAoNYzNpSlDWDthF2aYjhqhbtxiSi8Yk92++egtcpBqVBfUd
         qJdP34r6+i8t7YTgEtBUZK6/NpVWUgeFcOz0Qn8cphP6/WFpHhCXZu0HTxzyARLQtNE6
         FFSVej4AKBVYK/+Yio67Eeylx76WeGQJ3PnilxnmSXf3NT9YbvJhd1gsgsFfRWcC3lzY
         PWukABEjbCcIs2vQ4+AL1j3i59RLuxUYn7pUWKNlJtFuhLMX7MzZb53uXi710LvQRqJN
         C9IUIvmohsWS9izjyg/n36jfsbtdPytLjLota3Nmcdnwg232WsMz7VlKCRqgHxXkyhZP
         EhJg==
X-Forwarded-Encrypted: i=1; AJvYcCU9NgT2gZgShoT+y1ZJo6jjb8ey4KkopIRORxXC+hpwYp5Dlxj5ttHAcIozCb1pv7w7u5Jqltu0NupfGBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWtRwfhpj2XmPI54I7sxnweCEVz830+arBkDziwLB4DzLKUQlW
	DccDomyAMNqfQEMnM/nuDolVOlBB/a6MlbszN5YcvKOZsu5RcntxJfnX9eX95zzm/CiMwgcgGU+
	tqco4i81voY8bL5C/buFVksjGREatSe4Tinq+MVE8UBuAd4k4NMGzRCowK0s=
X-Google-Smtp-Source: AGHT+IEgAb6RUoUuUU6+VNUs0Cd19ohLNg0qyy6d4iLZhugK2w+73jMiz73PKLRfta/zoGVthLjHt3qE5iSNH5xXM3eJhiT2yG+r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e93:b0:418:3b13:d810 with SMTP id
 e9e14a558f8ab-425955fb6a0mr178031145ab.9.1759005811598; Sat, 27 Sep 2025
 13:43:31 -0700 (PDT)
Date: Sat, 27 Sep 2025 13:43:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d84c73.a00a0220.102ee.001a.GAE@google.com>
Subject: [syzbot] Monthly block report (Sep 2025)
From: syzbot <syzbot+liste73e8cca2b92b2455106@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 1 new issues were detected and 0 were fixed.
In total, 44 issues are still open and 104 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  44250   Yes   possible deadlock in blk_mq_update_nr_hw_queues
                   https://syzkaller.appspot.com/bug?extid=6279b273d888c2017726
<2>  43987   Yes   possible deadlock in __del_gendisk
                   https://syzkaller.appspot.com/bug?extid=2e9e529ac0b319316453
<3>  7133    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<4>  3286    No    INFO: task hung in read_part_sector (2)
                   https://syzkaller.appspot.com/bug?extid=82de77d3f217960f087d
<5>  2746    Yes   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
                   https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
<6>  2614    Yes   INFO: task hung in bdev_release
                   https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<7>  1688    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<8>  1586    Yes   INFO: task hung in bdev_open
                   https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
<9>  1007    Yes   INFO: task hung in sync_bdevs (3)
                   https://syzkaller.appspot.com/bug?extid=97bc0b256218ed6df337
<10> 606     Yes   possible deadlock in elevator_change
                   https://syzkaller.appspot.com/bug?extid=ccae337393ac17091c34

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

