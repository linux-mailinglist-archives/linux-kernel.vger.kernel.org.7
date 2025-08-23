Return-Path: <linux-kernel+bounces-783226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 491A5B32ADC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A025A127E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4645205502;
	Sat, 23 Aug 2025 16:32:31 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C122155C97
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755966751; cv=none; b=s8IOIrcwlveKq+9k3WAoahhSvknpFsjpRLWu2TChmC9hPN4OJyfO7XE3/yvSGJRNjUYI02o/UpF0Pt99su/ZkRYXFLkUa2lsY53tg5vfa5lRx5PZzRM1jhVOWDbfKUdQIktE0tEYL698beQNHMVFJw5sovdch7c0BXMoCN3EGSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755966751; c=relaxed/simple;
	bh=Ixqw/hp30/DHUOKHuiafJGeec1MGisIVO9zmHr6m99E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=umjQ8w19vsAVba0bvoZV+80Kk1DcayMNbt7zB6/N1QgxkxvNdsk+uMJtYbXR9K+iBRy1ljd4bA0XdUwcD0/6oTSTsivwM7jT6CkyGHTzvXbMiuMOocT5WLde4Kur0+YGD+UGf674EuO/8suIHwnGoxe4MgOb1yXljauY/fMMNf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-886ca8326a0so49581339f.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 09:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755966749; x=1756571549;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lcf3G7AZTZ3BvIAmrod20JI+uK6LJ+LwOSTLr17yDAc=;
        b=eA3U1FhQ7GcWGr6PNpLFZpXGcprAQBrITyw93xomnNGHzFXSIDa+Sr1z53B5tc0Xla
         bGI75OcKGCwvhdyoQwmvXAomWg+T3PeNHcnK5VHvSp81Y7WXONKD3hW2mwg4VecEGbWB
         T7UVlYNVTFJd8uwsGe+51rykWO09xSMBTZpamzkY3R9pE+8dblMUOjnTTcDuv87HVkNe
         abVtPPDxV7lhXexNJ25heuCxmeoqPvNJMGQoMaH3pLbdYSKbNOYCbklIWj8IfuCySQpY
         60hdQ8qAwtR5RWTwX5+gl4EYTMIWT6AzUxx4AR3bcR0ZwqLCbTQPVrUVeuRfTVLXJ+II
         XSUw==
X-Forwarded-Encrypted: i=1; AJvYcCUxa24hwrtga7nvvAQ7NcXN/dPufXD3W5Mh7Pj7h1q3Tf68e30wRqH5pPyjyPTvKmZ9lVK3tS59Qyzcktg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzhCrIkxC8C9SRqffsnfIeioGBpqZN68fgU6daSyJ6jmcJzjlW
	PPSoUwA4FF5CMuUN4B8LY5Lm6SQLdadpU3mJDmYw4HU2t9ZE60+BFUtkiIS1viTriaoDnJR5xCz
	zrS+h/dTLouAIw5djbodT8tc5sxPbsNXXNPBaVkVF0WFURN9m6m4a6ojv1X8=
X-Google-Smtp-Source: AGHT+IHJPaZdZeiieNToh/ejIdh6QqDYkdfCshI9TpRc1PfNLpu25wa/9cQjXni1aK3BptqLhk9QEBuC9/QmJBhWzOXwvF/EJ0qs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4405:20b0:3e9:eec4:9b61 with SMTP id
 e9e14a558f8ab-3e9eec49f5emr47223185ab.32.1755966749190; Sat, 23 Aug 2025
 09:32:29 -0700 (PDT)
Date: Sat, 23 Aug 2025 09:32:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a9ed1d.a00a0220.3557d1.0020.GAE@google.com>
Subject: [syzbot] Monthly kernfs report (Aug 2025)
From: syzbot <syzbot+list18a75a435a40d93e3954@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernfs maintainers/developers,

This is a 31-day syzbot report for the kernfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kernfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 26 issues are still open and 24 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  869     Yes   possible deadlock in kernfs_iop_getattr
                   https://syzkaller.appspot.com/bug?extid=4bb2305559463e8f6a2a
<2>  450     Yes   WARNING in kernfs_remove_by_name_ns (3)
                   https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
<3>  445     Yes   WARNING in kernfs_get (5)
                   https://syzkaller.appspot.com/bug?extid=2f44671e54488d20f0e6
<4>  355     No    possible deadlock in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=65459fd3b61877d717a3
<5>  108     Yes   INFO: task hung in fdget_pos
                   https://syzkaller.appspot.com/bug?extid=0ee1ef35cf7e70ce55d7
<6>  69      Yes   INFO: task hung in kernfs_add_one
                   https://syzkaller.appspot.com/bug?extid=e4804edf2708e8b7d2a5
<7>  64      Yes   possible deadlock in kernfs_remove
                   https://syzkaller.appspot.com/bug?extid=2d7d0fbb5fb979113ff3
<8>  53      Yes   INFO: rcu detected stall in sys_unshare (9)
                   https://syzkaller.appspot.com/bug?extid=872bccd9a68c6ba47718
<9>  43      No    INFO: task hung in sb_start_write (2)
                   https://syzkaller.appspot.com/bug?extid=b3fba2e269970207b61d
<10> 11      No    BUG: unable to handle kernel paging request in kernfs_remove_by_name_ns
                   https://syzkaller.appspot.com/bug?extid=4faa3fd832279bd35a81

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

