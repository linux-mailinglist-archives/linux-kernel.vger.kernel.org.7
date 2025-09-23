Return-Path: <linux-kernel+bounces-829004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B7EB96067
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA47419C3C68
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91111327A11;
	Tue, 23 Sep 2025 13:33:31 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761E83277A4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634411; cv=none; b=lguFuNkjn7QOJzGQHkP37PuO9oNG+A5S+lBwrg1LokUeYLCLOOxenrVFDC36aJnISX8RoHZzI/YhLCdEKPe/meMEeHuTcEbu56dpq1Y2epvfdshnl3sWUNdD9ie3cOhQQtFs7JJCKPhzA3ynW+qxtXCYy6tE3AfxXxlwmdb71Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634411; c=relaxed/simple;
	bh=YlvkxxU77XFmk3dFpiO+TJOZ+LinsW79rmGkl5x0l+o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lKW8xb4fUWXfYX1H6ExD+gs5NN7c5ysOfxZ7ujYtstDItq38t+PZNeSfC4aeQAONpnuFMbS4iPsG2yEjwiUsqiz896pMY1HqMSKdktneontuUwZbVFq5JqAIoqMCI0zHekXPRSfz7LGvYQvv+HhDHzz1yC1AV/T0H8c3UNlR6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42486b1d287so44919115ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758634408; x=1759239208;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5mKuQ5JO4bcOvETst34ZttPMYoeDhLNrrso5xYmAvg=;
        b=H2boX2Vehj0R/Lm0BoiYNeD+zIaZbDUEkThEv8NpF3SeS4EcXvZ95UxhdpS1drobEh
         phxWI77N9y++MHUM0CKpqsm0NnE2V42qGaYJxW44TgzcNsPMuGoVwEZIbiPGaQ5uxM6U
         pYLIvDpobJ9RZGIjIzXGsqFs9EXDSK1M8PAaUQX9aLRsQDzCmQjfYUolK7rYdZUSchcZ
         RURun+rIk4HG23pxNW719BpAS0bIpHOWMbnxeO1snyJM//jMkTA1JPVqZ2ESOTLscGN/
         MJGgheG+Ey902/s1s0abUpaPNXUI3LiUKcv1m3BJqrW3cHExbBBKl7QrnFT4fKb0K5aS
         V2xA==
X-Forwarded-Encrypted: i=1; AJvYcCVJbyiQtXLjvkueCd3ZUIOz38PlHNILCowXtltK29sEI0nYWUgSMmHqWd9g/pRjob6MJfwv0m9sIDdJCFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9fVokQ/iXPMVx80eh0Ivipwerd02X5wCW9Ey8VfEb8TQzhle
	JoszWsC87QNPOoo4FNU/Y9QcFKreuUSxgJVO5AHhPUYYO5YkR1CGYx4YSxRfy7TPUu/mLuYdTuR
	8FLHs+UwpvtmHA1+p7cHBsSWJmBWtGCjXtWDLz+Zjn3rEuB8VrlV9uxgdXno=
X-Google-Smtp-Source: AGHT+IHJNsc7viNdVlbFrHEq7xL7TBDhlzADDNsNE+LVVzoSddN+60fNp0PjXPNlqlaprDwc1wvOTKb2O96lwV4ajBoirHD+b/jg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1542:b0:415:fe45:3dfe with SMTP id
 e9e14a558f8ab-42581e05edbmr39620545ab.3.1758634408463; Tue, 23 Sep 2025
 06:33:28 -0700 (PDT)
Date: Tue, 23 Sep 2025 06:33:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d2a1a8.a70a0220.1b52b.02ab.GAE@google.com>
Subject: [syzbot] Monthly hams report (Sep 2025)
From: syzbot <syzbot+listbffebb470b0c3b001515@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 1 new issues were detected and 1 were fixed.
In total, 9 issues are still open and 43 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 6492    Yes   possible deadlock in nr_rt_device_down (3)
                  https://syzkaller.appspot.com/bug?extid=ccdfb85a561b973219c7
<2> 1509    Yes   possible deadlock in nr_rt_ioctl (2)
                  https://syzkaller.appspot.com/bug?extid=14afda08dc3484d5db82
<3> 438     Yes   possible deadlock in nr_remove_neigh (2)
                  https://syzkaller.appspot.com/bug?extid=8863ad36d31449b4dc17
<4> 323     No    WARNING: ODEBUG bug in handle_softirqs
                  https://syzkaller.appspot.com/bug?extid=60db000b8468baeddbb1
<5> 63      No    WARNING: ODEBUG bug in __run_timers (3)
                  https://syzkaller.appspot.com/bug?extid=7287222a6d88bdb559a7
<6> 8       Yes   WARNING: refcount bug in ax25_setsockopt
                  https://syzkaller.appspot.com/bug?extid=0ee4da32f91ae2a3f015

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

