Return-Path: <linux-kernel+bounces-707777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17273AEC7C7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 16:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E037189F1CD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE3A248F55;
	Sat, 28 Jun 2025 14:44:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B6A1FBEA2
	for <linux-kernel@vger.kernel.org>; Sat, 28 Jun 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751121870; cv=none; b=t9+7FKIAyx5vXEgnZKDOvcXM1vjQgxuKqr3DBivIaraRjI4gexkKOiIJc6FbYsfFzKmuB5C7i/ae188dPvwFAQRHv+NEts32Wu5lQoTpTCH2QA5fVD0AWvfv/a7oZmyhddsSt32sA92vlyRFL0H1vO5i0Z7ec+8VbgxL9Xqfc94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751121870; c=relaxed/simple;
	bh=LKKcI/g4wEGKKlALVyktoAsOdP8fNQaeNmSsEulzJrA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LmgW1h/m9ednNQ+R+AVIs9iQewu7RsNdMYuGQZCJddnerybQj/y7b7XRuIM2p5mPezEg2Vy0f2LVY2IWUlH02DGzrqR6zF5hBJ0Zobl2biueyGEL53YHiuNCyPcsoj2FmRg1Howd7o/zv5I7w7jBqxVZU625hpyNLR+b0L8fw+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ddc1af1e5bso72140735ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jun 2025 07:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751121868; x=1751726668;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fTzNunO4rfG0fdB04phZ0ETjFxrQY1IFOAPqwxnBfHg=;
        b=L+euLt4x5F5QXYo7vN7CYbA5qYasImKEmgk5LiA/Uh47NMC0NyKC49HATlbMoo5qnf
         gAQt0NpHvBfELv43aaCJviPDZk7hLUmNeAKwYWrV7dPXghEy412AP5/ljMKckrPNz01x
         2bj55IwK1/LN90Aais8i6Zb/6ThIlE4vG47a0xf7N2Fg0/bWVhKmgUraOOUXiPGiEKUv
         hT/m/P0znOwcbGJtbQdpqfJJM8zgrBLS+hM1SSkcze291PIizclPgeU/AOnIFu4XRs9q
         97BXn/pm9DIOF5Evsx3AyoQ/MEtakSa0Ngz7FtKV1DL9OdLoF9E4m4t4YRzJzrqasPVy
         X6Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVmuZVDQUJx/4Z+xVq2aL3F2ZaAdvzR2qDoY/PArHkt9E5Qg+E9tUn0fuuxjRD8a7L8sbultcAkn3GHk3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAxA2wlvQk8c+snSCzWG/hNlYaCiSumaDxjmDzdYnkVkswaygn
	dMKMeQmzepwGSLandHWbHnrTQoSxebbcJmdFeWQdCyq806J4krfRifU/2bFhBJN0y/NgzX3T3ic
	/tWG0eW0RdlVbcR4dyoRKXxFlFtZ2Sbb5n/AHgXKR8KasvFyEsXhCmIBCFCA=
X-Google-Smtp-Source: AGHT+IFGNIUoyjIVkiQ/X1QGq48lDsVBwYiB/qjNy7sKa/EEiDX4c0THu7Y8I1BqGRan7zFFLrgLia40oBa+pVfBkKeCpdLmKANQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4416:20b0:3df:5309:e962 with SMTP id
 e9e14a558f8ab-3df5309ec82mr37521915ab.19.1751121868218; Sat, 28 Jun 2025
 07:44:28 -0700 (PDT)
Date: Sat, 28 Jun 2025 07:44:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685fffcc.a70a0220.2f4de1.000e.GAE@google.com>
Subject: [syzbot] Monthly cgroups report (Jun 2025)
From: syzbot <syzbot+listd2f490173279536fd88e@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello cgroups maintainers/developers,

This is a 31-day syzbot report for the cgroups subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/cgroups

During the period, 3 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 38 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3931    Yes   possible deadlock in task_rq_lock
                  https://syzkaller.appspot.com/bug?extid=ca14b36a46a8c541b509
<2> 18      No    WARNING in css_rstat_flush
                  https://syzkaller.appspot.com/bug?extid=7a605e85e5b5a7e4a5e3
<3> 14      No    BUG: unable to handle kernel paging request in percpu_ref_get_many (2)
                  https://syzkaller.appspot.com/bug?extid=3109abc43c8fcf15212b
<4> 10      Yes   BUG: unable to handle kernel paging request in css_rstat_flush
                  https://syzkaller.appspot.com/bug?extid=36ca05bdc071f7ba8f75

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

