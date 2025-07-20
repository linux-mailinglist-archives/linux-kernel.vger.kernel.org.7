Return-Path: <linux-kernel+bounces-738113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD4BB0B477
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882991786E2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F398B1E9B0B;
	Sun, 20 Jul 2025 09:04:32 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D8F1B87C9
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753002272; cv=none; b=tUTodgiXSiqcP2JAOhZqtpmGglJ0dfLCSZ7/GK3qlEY5AqMrS0XbavybgV6e2AXW2Qb6hfPq/20z5wsUgd5vYv4F4GGBmglMHAGB8Pqk2qkDzaq73GHuAQclcM5TgxCsSLjoKfYwhQ0Z9Q1U3DhpRAL4kC3Pgba+ihwddXtOTt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753002272; c=relaxed/simple;
	bh=DV+d7fQsOplJtUuPgom5MOBYAFtcG5VOuZQYlQjQOg0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AHXQf0sUUt+HfiK0DgsFLsIEaRnEmfJ8g/iI5f7HB6NJZ06zdios1WrFcuHlrmagsOQ8Q2QmctMNOfJBjsAoCJYaFjsN09z4Fr6//9k7bSBJKtNLJFw+vmQw2+obcjCsS487snzFzSQFTXmXW2kU3fusUn9k/N6/SqWo1g2rhHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e29099056eso33759335ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 02:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753002270; x=1753607070;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bp6FP9yK5sZE5gMe6Mw+JGVsx/wyOJ2DCfwx+rTMhVM=;
        b=ojWJIU1BLgun27iVaFr1b2YKJq6r3O7cztnorLfdCfaRod7i53bRNrkEpbQzgdS8eu
         beakHrJtOt7g6MM726qnxMAu54y2kqNvGPeFhBU8W9gTWkBzEBn1nm2Ci74jldrqTHTd
         +37kuEFsyOtwapMGjfWBEib2r51ZG7L79E9f7LwrddtGIXCTA/flSlsbJ3kjtlhV41q8
         e+nFGTvcveLOQk/XFMF4Ud04Qewu518jdrZWIf/oruJmsEriWpKI3bq/DHFwLyxGXWHX
         JC72Ti/pb0IZY+WsQBYGXSrpTJ3wbz8tk+in2SXPSnDrmWyjj6dOgs1NePisTL+H3EYC
         3RPg==
X-Gm-Message-State: AOJu0YzCjvSmEeQyMeJU+Lo2EgFdDzieaZtdgthcle6PDjxgLfsU8s74
	w/t9Rr2KLktTPRXH926xCwTHD6z4dnzS9Gt2kJgqYLTMMMyBZ12nw5XiIpIHjusyTS1XvRj4S54
	P1sKumJfPTwQDfJJVIPjh3k3roXIFcEknbf9Hl/R9vKsgxrcSSsI0Nvx2Guw=
X-Google-Smtp-Source: AGHT+IEogKAS3P/6OQF2OCALURdXUEXElveBV+V2WhZsMf+r7/rUJVDZby4lK+SAi6ZVOefFDg9dI9SdcvWDfo1ZGkTZaQuU041H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f01:b0:3dd:d995:30ec with SMTP id
 e9e14a558f8ab-3e297409f97mr87646355ab.12.1753002270296; Sun, 20 Jul 2025
 02:04:30 -0700 (PDT)
Date: Sun, 20 Jul 2025 02:04:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687cb11e.a70a0220.693ce.00b8.GAE@google.com>
Subject: [syzbot] Monthly trace report (Jul 2025)
From: syzbot <syzbot+list7b00f28fbeff30efd2db@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 0 new issues were detected and 2 were fixed.
In total, 11 issues are still open and 49 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 350     Yes   WARNING in tracing_buffers_mmap_close
                  https://syzkaller.appspot.com/bug?extid=ddc001b92c083dbf2b97
<2> 77      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<3> 50      Yes   WARNING in tracepoint_probe_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
<4> 48      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<5> 35      Yes   INFO: task hung in blk_trace_remove (2)
                  https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
<6> 14      No    BUG: soft lockup in hsr_announce (3)
                  https://syzkaller.appspot.com/bug?extid=6c68a0400c33951a023c
<7> 7       Yes   INFO: task hung in blk_trace_setup (4)
                  https://syzkaller.appspot.com/bug?extid=9c1ebb9957045e00ac63
<8> 7       No    WARNING in tracing_start_tr
                  https://syzkaller.appspot.com/bug?extid=ccdec3bfe0beec58a38d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

