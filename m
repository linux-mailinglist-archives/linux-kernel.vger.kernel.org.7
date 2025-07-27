Return-Path: <linux-kernel+bounces-747061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 347E1B12F3B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 12:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6811899C36
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 10:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D360220C000;
	Sun, 27 Jul 2025 10:41:32 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED1F1FC0E2
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753612892; cv=none; b=jl+UTkI359hZ+Rt6PO7RFvbeqsI0VvDnkne76yGj9EtVASGaqIyOfGVy7ULDlrJ80lceE2PtupR58VCHGMe/W/HKMr/LEcKGjq1qw7oHGk1124fy+tuBq9Z9/kQwi2CssD/MfGCn604Gy9cDe25b69TH/TieWpNk+Oni6EH8b1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753612892; c=relaxed/simple;
	bh=4jd+r3D2RcrZO98uB2Ibbu67T7Z08+hjRveOyKEc4P8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RqiOj3uQW7p1z7Nzb5wEaxg0ezs9HpGO7Fft6cRJ/CwQNCLtX9RYtR6eHb5ud8P/oMj033BEq4hW+0bg7jKanYK8++TCDdFtwI8+2f5gJM885NzuF0P717mvndFSfQ16xEMBEbomLnqDI+zFqEwcMGugC0r61sI1TrzdHx9a/Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e05997f731so78543465ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 03:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753612890; x=1754217690;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CfZ0JwHzGjBpAY4VrTrIkFjFu/w9P7ORWKY3YHrRzN4=;
        b=oHGFWSJLvdbu0DDrx5806TzSypQVsCJJQ6+RLYoz8e0qAmTg/KeKM26e+e22OaLl1L
         hksZThtZGBhj2ba/qv8kFKqE9fK7mc0wjikrBRhWZScDJiPwbpkbcwtLmiBLVG6rcn2u
         EbVOJw/PT+iTSSuucQ/10Z6VZ/YtN0CD19asYNEu/o3JnVGDjY64L9+UHo15dZ0ODUlo
         uKDpE2G8xhZ1M6PhqnkzqPuzw4DJummwqBVx4vnsw668nW+22j4W/tNJIPkCqJzHHHbe
         OtsHLWNu/9nKwnxwluTiYs4A8ZMw1H1yWPgjcaqXu6zKABf0rCPmhiqf9xSgnliGkM2i
         SXAA==
X-Forwarded-Encrypted: i=1; AJvYcCUPVmd2KJHw8sOV92byPUEiw6VoMLzwuYETPyUXm/dN6g7ohp0Mj2s01Qw6mTs6tLmr0BKdvR/BTInfFPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuc+JwivB7zXPkTKzoXEB586maLeDPvNUj9DU4uI4xtiuVEYiB
	7CNoL0POlzY00Wm/9oEq4D5HvoGU4YQJNrYe70aWcjRkrZi7r1dLF8SUqC7qd2NzOcWr2qFLGp+
	xdHckFKLpnVaXE+UcYa2DMf/hBjXW7FyG0+5F7BVOEHb6RW5JDdaDFBXnDLQ=
X-Google-Smtp-Source: AGHT+IEsRhyeI6yT0gVQGdL9ZNEFieSNilDoo9V2IktQyCbviBuiHgfAiDWLZfgQ1SsjHNQRGvTNXtNYgZZp86S4rGcFxTWWN52y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e90:b0:3e3:d197:b567 with SMTP id
 e9e14a558f8ab-3e3d197b93bmr48605845ab.9.1753612890129; Sun, 27 Jul 2025
 03:41:30 -0700 (PDT)
Date: Sun, 27 Jul 2025 03:41:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6886025a.a00a0220.b12ec.004f.GAE@google.com>
Subject: [syzbot] Monthly block report (Jul 2025)
From: syzbot <syzbot+listf1e285e4117196663a19@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 0 new issues were detected and 2 were fixed.
In total, 37 issues are still open and 102 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  40868   Yes   possible deadlock in blk_mq_update_nr_hw_queues
                   https://syzkaller.appspot.com/bug?extid=6279b273d888c2017726
<2>  40756   Yes   possible deadlock in __del_gendisk
                   https://syzkaller.appspot.com/bug?extid=2e9e529ac0b319316453
<3>  6513    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<4>  2597    Yes   INFO: task hung in bdev_release
                   https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<5>  1681    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<6>  1171    No    INFO: task hung in read_part_sector (2)
                   https://syzkaller.appspot.com/bug?extid=82de77d3f217960f087d
<7>  1016    Yes   INFO: task hung in bdev_open
                   https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
<8>  521     Yes   possible deadlock in queue_requests_store
                   https://syzkaller.appspot.com/bug?extid=48928935f5008dde0a41
<9>  415     No    INFO: task hung in sync_bdevs (3)
                   https://syzkaller.appspot.com/bug?extid=97bc0b256218ed6df337
<10> 378     Yes   possible deadlock in elevator_change
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

