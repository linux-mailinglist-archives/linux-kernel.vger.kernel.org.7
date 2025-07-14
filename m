Return-Path: <linux-kernel+bounces-729519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93403B037D4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37613ABFBD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA34E2356B9;
	Mon, 14 Jul 2025 07:23:36 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6357233714
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477816; cv=none; b=exaDFqRUReKEYUuFGe7+HKuNJUAr9q3zlMUd0WhlwlrANUlFCKTXH0miFWJyPXwTby5OTS7Z5Dhn6SrIQxyl4lzIe9e783lFPqhp6s2Yrx+reKUwzqhZ8INaKWcPKfqzwiDEpdRRsdxZ/m2icyhbUTEdDLAfveDRYNme4PTTIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477816; c=relaxed/simple;
	bh=D0XbUHo/Xa8r/hQ7PBSxD9mQQ3DZQ104XS2Izw8FPPk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H2bXiM1QCdnbczg9sR5Q0ephuq6XS929dMT6b5zeRSLDfOpips6QMmD7tlxoaYq78xYF5BO7wbEOw4A1Zz2MxYGDBquH+gpnhLwdMA+WiPxERYjWFRRm3ympp1RaNJztU7DaVzSopJei1yGQRekDWePhWJ60+PeUCkBl/pFsLBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddbec809acso48221955ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752477814; x=1753082614;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3IODY77gcvcd2KKIR3n98mmWxpmu21fUMmL5zBmpSWg=;
        b=Kw0QIzllSW9GNIQyV1VefI7eGvsO+fabvtDkZUrg99xfoFAtSlNKh3sqej40r8hWns
         3LcChq/r3CRzsTHR11CbzGqWb4FwM9P+XV0JUXk+BydydYuxe1lLGDZwV/yknHorYQOZ
         tNF7pbsM841uC2kSRCcYHbrlNtVfsEFFGeuf1l7LXRUqzktLbwyIRnCbhsEooaYkxgat
         WhezZN9pohSeobohMs03JpMMN+T5GW84SvBr5S4/3Lczaq2Wqopcek9ZMHACe9Q5mqdw
         DBQM71deYtTJPp8yX1rORViyiMAf3ekCubaUSU7hz4FcHHKCyG1LEMpHj4JRKTESK5vG
         Q3Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWqONHvR/7RX0ITJZtCZ35QLw6VU+NUuYnL5R08Ms5/kLRsoAfO89W3I7s/6gruvWYn4LMyn9egKnP/Xx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNULPloX64nvXWf98Tyh3ILdeGnd6o8ZUkMa/OjL34vj4YwiZA
	oLOTMz7mCzY9PjsNvU05xLZkESmHnWSGizB9Q2/ngfNu0//nJahlVBRpbHQs/bn0OS5GKDaD+ED
	I39wxn/JVWjaLdmdsA1dtCJ5d3wbSIxuXFhZRHXb1LkFb49zM4MgnuesdsJA=
X-Google-Smtp-Source: AGHT+IH9WdWdISWHMOSZyObAIsSi6oFJavmp4y5tPClzzemUAp8EkpGozowkz7vMhGCoHqPKmtJxGDEYtXVlfNt1ILVyMyczLDE0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378a:b0:3df:29a6:ffbc with SMTP id
 e9e14a558f8ab-3e2533140c2mr121077165ab.17.1752477814084; Mon, 14 Jul 2025
 00:23:34 -0700 (PDT)
Date: Mon, 14 Jul 2025 00:23:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6874b076.a70a0220.3b380f.004e.GAE@google.com>
Subject: [syzbot] Monthly input report (Jul 2025)
From: syzbot <syzbot+list03999ad301cf3e834e43@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello input maintainers/developers,

This is a 31-day syzbot report for the input subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/input

During the period, 1 new issues were detected and 0 were fixed.
In total, 20 issues are still open and 59 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2359    Yes   WARNING in cm109_urb_irq_callback/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=2d6d691af5ab4b7e66df
<2>  1228    No    possible deadlock in evdev_pass_values (2)
                   https://syzkaller.appspot.com/bug?extid=13d3cb2a3dc61e6092f5
<3>  853     Yes   WARNING in enable_work
                   https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
<4>  719     Yes   KASAN: slab-out-of-bounds Read in mcp2221_raw_event
                   https://syzkaller.appspot.com/bug?extid=52c1a7d3e5b361ccd346
<5>  166     Yes   KASAN: stack-out-of-bounds Read in sched_show_task
                   https://syzkaller.appspot.com/bug?extid=8d2757d62d403b2d9275
<6>  72      Yes   WARNING in cm109_input_open/usb_submit_urb (3)
                   https://syzkaller.appspot.com/bug?extid=ac0f9c4cc1e034160492
<7>  44      Yes   possible deadlock in uinput_request_submit
                   https://syzkaller.appspot.com/bug?extid=159077b1355b8cd72757
<8>  27      Yes   WARNING in bcm5974_start_traffic/usb_submit_urb (2)
                   https://syzkaller.appspot.com/bug?extid=b064b5599f18f7ebb1e1
<9>  9       Yes   INFO: rcu detected stall in call_timer_fn (5)
                   https://syzkaller.appspot.com/bug?extid=03dd0f0cbfcf5c5c24f1
<10> 9       No    KASAN: slab-use-after-free Read in report_descriptor_read
                   https://syzkaller.appspot.com/bug?extid=bc537ca7a0efe33988eb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

