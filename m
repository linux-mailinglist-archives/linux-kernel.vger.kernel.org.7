Return-Path: <linux-kernel+bounces-884914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03980C317B8
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DA9A4E7BC2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F72332C942;
	Tue,  4 Nov 2025 14:21:34 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBB1320A0A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266094; cv=none; b=uuz1BZEqkyWyT+JiT8FSWoK1m3XDAXVmAhhziWaT/20h3e8nKUGUBqOqgzVdfL/M06s8IwjGViKd9MGH5wEqeNh4hc8iuXUUGXg0Zq6G/suAQYIatgr0H/xzQB/HW9kKRduWO5oy7Kc04nSjmzm8C9ICddEGXqX0Nkq+hwuSIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266094; c=relaxed/simple;
	bh=5mXvuTR1PiKSIZIeQ+mXYzLrB9FmHxAaPAEgu0nL7Io=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HMJlaZGQm+5gYD95NKzbDvl2jgqqR2/BM005wZ9UtQ9ooh6hPLdcNxuJDzwvEy1X/yCq1VhNYqPVoRiqrZEG4FycT/xU3BKPlB5Tz+aIIhARG51sG8NIrzLgNzyf3/QWNekXdnORD3AEKwiGjA39kWtwKx2/YB8yjpfwZJmUyCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4332ae73d5cso18715205ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:21:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762266092; x=1762870892;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7L/jSGya7egt/NiedCx/1BfP1PKnwqFiSMxG2dzvm6E=;
        b=RImDisz22TixrEw/O5pGJtEtT9Mqt09H5O49SRCc0ijCYBGrV3k6tSqL/Wt7dN6dEL
         MF3cedqrPCVRHsR7TpfOosI2YZKRayakCzUvIM3BySL0XemfFbYxsAhpbe6NnTSYA+XU
         6IW50588KwGc9FBTT7Dxr4sU07+Sous//jtz7xSCh21P35X/h/7b27QtnmB72yA7WcxX
         ycmfXV3kvSXUBFO+nTFGtcM74F8qeQTZbbcwm5ynlSKuR+AoqWa8rF7j4KTsW6Te59BE
         G5loFgXp07liue7fJXwRZqfgV3qFuXeTwtUc4+c6Z+ZhDknHhTKpS/jEqnVrz11UIrnb
         lNww==
X-Forwarded-Encrypted: i=1; AJvYcCUNQF3X02Sw45HiHbzOuH+UP7ICNJCHJFYtYF8OKXbD3WEEvp+zoBpESFwok0dW4K4AukRoTvEX3e5yu/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgc8+CX2FH+Xe/lwAXFdAg+McyHgZ8Ddd9vb23RlpP0rQ+WK6y
	sUqSPhQ5jV8RKaEuq9Cqq8/0OEKCFlMzatKcBpdG9HNoSdIAeAYEPVqL6gmmuoAyNo8vEKzeHTq
	JkqTLYPTZwPu/wW5C800hFYoGqYbdTHdxRUFAbtrGSYknJ0FrDb/GA+s+wVo=
X-Google-Smtp-Source: AGHT+IHmghhbRbHc2151lEMdR+Fkctnu2OMAFAv+53FJy/pwcW/nqwYE+rSNRwYm8lpm9Ln89ZBat27dAoQpv/kgtCP6eb3W0aQ4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:718b:b0:945:cbd9:55cc with SMTP id
 ca18e2360f4ac-948229840a8mr2134810839f.15.1762266091838; Tue, 04 Nov 2025
 06:21:31 -0800 (PST)
Date: Tue, 04 Nov 2025 06:21:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690a0beb.050a0220.98a6.00af.GAE@google.com>
Subject: [syzbot] Monthly nbd report (Nov 2025)
From: syzbot <syzbot+listc0bf6fe607a7f411a734@syzkaller.appspotmail.com>
To: josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nbd maintainers/developers,

This is a 31-day syzbot report for the nbd subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nbd

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 8 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2373    Yes   possible deadlock in pcpu_alloc_noprof (2)
                  https://syzkaller.appspot.com/bug?extid=91771b3fb86ec2dd7227
<2> 339     Yes   INFO: task hung in nbd_queue_rq
                  https://syzkaller.appspot.com/bug?extid=30c16035531e3248dcbc
<3> 64      Yes   possible deadlock in nbd_queue_rq
                  https://syzkaller.appspot.com/bug?extid=3dbc6142c85cc77eaf04
<4> 4       Yes   KASAN: slab-use-after-free Write in recv_work (3)
                  https://syzkaller.appspot.com/bug?extid=56fbf4c7ddf65e95c7cc

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

