Return-Path: <linux-kernel+bounces-661679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EBBAC2EC3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 12:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01EEC1BC1146
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 10:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5066B1AB6D4;
	Sat, 24 May 2025 10:05:37 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3137E19D898
	for <linux-kernel@vger.kernel.org>; Sat, 24 May 2025 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748081136; cv=none; b=M2OOLXhGjYUyLv0zPwBX3BsiZS5fR7gvqPEcGH6QvwYkPpKSTdl4qyXnRYlBGQa1D1R9ctZdwlPrk4aBUlAtZ2ovGG8xEYcyM+KiPxFk9NNNFOqhSG3eVowmF5R5uDsvz2t/WeWt5hpUqfKe8BSkWkASDKYPE3sTxXMMfMfHa2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748081136; c=relaxed/simple;
	bh=lGw3DY65ueQVYKXqtXWX8gnFKsdoVy88glIX9gkXqQs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o6UPveI7wy6f17A3epjNofa/cRt6xb+9wq47ny1XVtbF+LvnhLN7armsjjG9Uyen5bvhXnZgDHE/K4bP7JYCFuiegPTsFOuU7L5kqTrGniQzd0hwuYo5GGeWBHk/x6Xzhm05LHvlTFTHj365Te6i7XBICzIvXekPK9qgOX3vKyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8649be94fa1so118066439f.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 May 2025 03:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748081134; x=1748685934;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZF0QGYyssk/KtoqKqz083DqbcjhDRw8W0phBEuMFFi4=;
        b=IEn5y8G4+T8cs/lxGYrqq/TDjkWLlneG7n+5Pv6ZaAwOpYrAjnDWo9bgWXQ5mR6pbJ
         FF1zJOZe6VmrEThrmyTlgLbJ3yjvaJ6Zv2CU0y4RpJP+UzMvQw6ZNrHbTvOjIqCrsKqX
         E22OFJV9MJSNpv4+ny+QOv4WJVHUSc+GYP0TAvbIA95kki5nP734QmYjMhp3pUWGGFW+
         7hohC4X/BCsM1hvsZWTBRWzglv5+EG4feTNc+HhTZqhzHSXeXPTrmab/XJAw30xXbYWA
         vu33qk+QEYJqsD8Ko1wMUBpPYhXy5gIwidTTMmIHwS8HuI0lrHjckRAjwNsmvhtxnXb8
         mDKg==
X-Forwarded-Encrypted: i=1; AJvYcCWD770FvB2bnzxZOtgtU5yMnGUNvtRgkk9Ha9pc3iFRbcymaYf9ViOHTvzOaO05abKSDJl0jhItdw8bUmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGAWflH6lb2KzQGRutIp0HzvpUisOiNIBKiqxcOahecrEkt2dQ
	fEIikGVV/pgKsmFHt50wm1fCJVWdTfyKS3/xlFv0Qw+uObtOya3RRqmnE9qX826iM+18DQngqSk
	hCZkNVzfcd0SU4wewXRpfboB+JGvCS46aR58QqE4+czQFXBHYjVY6NVpuglI=
X-Google-Smtp-Source: AGHT+IGBeRgaOle5h3604R+qkWqBVgjEkp5aLPVs03gg96GrLNb1jQCpQ4W+eEhTp+837c0PKI3pSX9/bYFYdl4KHW0NjGTzJvj5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3684:b0:86a:93b:c7de with SMTP id
 ca18e2360f4ac-86cbb7b5de5mr265760139f.3.1748081134401; Sat, 24 May 2025
 03:05:34 -0700 (PDT)
Date: Sat, 24 May 2025 03:05:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683199ee.a70a0220.29d4a0.07f9.GAE@google.com>
Subject: [syzbot] Monthly exfat report (May 2025)
From: syzbot <syzbot+list9e94a023fafdc8e336d3@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 22 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3314    Yes   INFO: task hung in exfat_write_inode
                  https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8
<2> 96      Yes   KMSAN: uninit-value in iov_iter_alignment_iovec
                  https://syzkaller.appspot.com/bug?extid=f2a9c06bfaa027217ebb
<3> 14      Yes   INFO: task hung in vfs_rmdir (2)
                  https://syzkaller.appspot.com/bug?extid=42986aeeddfd7ed93c8b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

