Return-Path: <linux-kernel+bounces-849092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C1FBCF2F5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5645C34CABF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382CD238C1B;
	Sat, 11 Oct 2025 09:29:37 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9BF1B4156
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760174976; cv=none; b=bvYy2Nf4E7E2q4T6Izx/7Hd7hUXKJu4aNYDrUhvbBDl+Nl4ypu+jl05md2W/Z4XdnfGAH4G5GJtRITF64p8e0lYMotJZ8XiJb2cez+u1rkHKrkofULemDJPKJgFD7Av2Q3K17t1OmhrXS4q82ky0uxgaXmBj3Vd15owOIGIiZAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760174976; c=relaxed/simple;
	bh=SEGA1JxDVjgOdIyGz08khwlWsqBK3YqhFWfpsQKSfXg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mlMl2HyaJep2zqR6IxphvUYQk43n4bwCrF2ndwDotsIJlN0RmjvO4P4KhzBNuphtEUN9Wxan9QUdOy2df32Pidqdlr6FJq9lOUX1MZBx4VHyTMFGCAQKOaVlFnHDYi0ac9K7ft3HyI86EUvSJgaC8Z4lVLu6G3Trt3wT44BaMbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93bbaa774e2so965260239f.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 02:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760174970; x=1760779770;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x5oSErmb84+RFSlMkzc5ubC6mexejsfOehcVwZHA0vc=;
        b=BD9Jdh9Vnrts58wYfeq2lmDG7tObg6P931yHIoKXcoP8acLUUx1wKr0ZfkOVWm+G+H
         RweZ0u9ThfW21c+xHFKaOgy+t0Er0VMQ73UVQDQ/QxxnMpxazS0GcORjzmMc/sUK5DQO
         hFb+0cnmmVwbGD59x/Ya513CEFAHenOZl18pXZsBz7sK1ex4Zu+nHH/m6zzyT7eweUyf
         kflxY0FKXQK+BomjHEdEkT49G0eAAfpphULXsqMNTsLh+ufyKnm9juXR80+9Juk1SpeH
         mDbX172pubow9aXtQJp+QqPjJzqOYJKXKPM8wWCO6nBcFHLfLz6Ej5MjDOJKeFLx3hEf
         2AMA==
X-Forwarded-Encrypted: i=1; AJvYcCXTk5nFMBd3IVD7prMuWFYM8QAeQwfy8DuRB2YZiife2Tw9Hd3r+H4ZDLJqV9xI5tCe+SD24An1d+t1J8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9zqnzKWmIopkjJ//vAFbKC5fqifBHhAOCD+8q5hUrOe40g95L
	xOV6GxuChJbx5r8rLDcMoBTg7zLVNLS6Z5UjUWX4y86lW4PDvz7FF0Y/c5iq2sPkFj3Ws+rIH2C
	d0qPlbSb7NcqbTUvGutEcvMukfNbfFeuj1VHoU1PBsolbj5ZJyryqxtCtlyY=
X-Google-Smtp-Source: AGHT+IF/qjMIhiagL49pWqe0WUu8XHSftUwnRh7FtAO+KvqG5uhFqEtud28R7QmLyvMzCkHa51lWV+q8633wCGSmOSVBeAzyGhzm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1695:b0:8fa:23a2:cc36 with SMTP id
 ca18e2360f4ac-93bd198c54bmr1846350139f.15.1760174970644; Sat, 11 Oct 2025
 02:29:30 -0700 (PDT)
Date: Sat, 11 Oct 2025 02:29:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ea237a.a70a0220.b3ac9.0005.GAE@google.com>
Subject: [syzbot] Monthly bfs report (Oct 2025)
From: syzbot <syzbot+listc0c4fa3eba46796d30d8@syzkaller.appspotmail.com>
To: aivazian.tigran@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bfs maintainers/developers,

This is a 31-day syzbot report for the bfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 6 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 581     Yes   WARNING in mark_buffer_dirty (7)
                  https://syzkaller.appspot.com/bug?extid=2327bccb02eef9291c1c
<2> 2       No    possible deadlock in bfs_evict_inode
                  https://syzkaller.appspot.com/bug?extid=a12845fa0e9f51f7a601
<3> 1       Yes   INFO: task hung in bfs_lookup (6)
                  https://syzkaller.appspot.com/bug?extid=e7be6bf3e45b7b463bfa

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

