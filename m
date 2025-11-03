Return-Path: <linux-kernel+bounces-882951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD663C2C073
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794F93A9EF9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B926830E0CD;
	Mon,  3 Nov 2025 13:10:37 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C630C360
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762175437; cv=none; b=H9cl8L1OkpBT15Zb3g4q3Mux/ktfvL2vX+3kTkF4bl9mG61XGfavtdgx2EnG40+1lXQmD2FSLLpDGo/KWz0Mj9F/D4Xl0ZmM7L1eZyFijPuKMFgoR1WKLj3fUQ+2VssP36xmGz5+PmwfCpp9yG4xa9J0jndDAhhBPLjsAzVHgGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762175437; c=relaxed/simple;
	bh=QgMbAU0piTe1Tt9s5V6k4yo5gsBWo9hkKn1VVh/SgkE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SKQJnBZqFZVmBVsLjI9W2kkBnAtGOCl/198cWp2aruok+jbUltRpfF+vfnsL/W/MLeTHgcgpeX9hWZxAUMH8lKHuUIo5NFE74t6haeGHCNWBIrquXn/RrX2QscVEa/n+egrG3INR7SN7IRi3gJnRQFzZLWE1x24HW+zcsSrpbH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-433296252f8so51159735ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762175435; x=1762780235;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VL7x8R2BK+VALfhl69aR2ef06obUa6CZ6jh58ZHWalo=;
        b=dJaLutCVbSt+kJjvRKTljJU/3/Ou7x88FHqdwdAH/60tPLkHC6ldktfsxWO59Hqdgf
         81BMM/j97T0pzpPuRIJJ73lpvpFDMSAgLFR4s2qkmOpovGZ89MMkO3zwQwQUYEaabmkC
         6cja4YAB04Ab+XdwO+VvIgFaKBGV1Fm651fV5CzgNrPwfxyORSPF1veimxAaMMPuBy90
         g5x1D8t2VRnkj2Oxe392lwHrwrac545JGUalWrkTWUnvDFS453IJNlB8hX0kA0KxT31V
         2lW6KeR7fm6j9oD8vipu9DDbZF149WwntxkSqk1hKvWrwmQY8r/2u+h57bomIiDG0SbY
         WkXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYWtS+JdKu082XT85a4PbM4aqr1bIsHxS1uHWfxIMUKXm42qwU1TzKGjKrdFLWiiposy2Vuisq+rO8Vxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJCVxns5YQ+74vQNW36mD5X4dtJPnaCSihtqBKJm+E+yJ1L+uV
	ynAKZ4dGZBIW2ywY4JPU0ufktcCpKdKz6+5ZsFXpOmx7Pfwpl6enTPWfmigeYK8Qvao8uGZ97e1
	p3hrwT89rPYVR4X7YXzevsUXwljLsbgal7NlJtXVs0fJaDLHsWv23U7fNBu4=
X-Google-Smtp-Source: AGHT+IFZPezBQoxUtz5l3cjCzp9qzPrhtDLwkqWEgtBsfR6oBXgBjo1B55DjRjj9w2mcKQvel4P3FIXqgvU65veqbmSiiLWjLg0O
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2d:b0:433:3095:909c with SMTP id
 e9e14a558f8ab-433309591e1mr33407455ab.20.1762175434831; Mon, 03 Nov 2025
 05:10:34 -0800 (PST)
Date: Mon, 03 Nov 2025 05:10:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6908a9ca.050a0220.29fc44.0045.GAE@google.com>
Subject: [syzbot] Monthly f2fs report (Nov 2025)
From: syzbot <syzbot+list6d5e07b82ce5d672a81d@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello f2fs maintainers/developers,

This is a 31-day syzbot report for the f2fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/f2fs

During the period, 4 new issues were detected and 0 were fixed.
In total, 11 issues are still open and 68 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1330    Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<2> 1315    Yes   kernel BUG in f2fs_evict_inode (4)
                  https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
<3> 914     Yes   WARNING in get_data
                  https://syzkaller.appspot.com/bug?extid=f5d91b1897d5b094c6b4
<4> 155     Yes   INFO: task hung in f2fs_issue_checkpoint (2)
                  https://syzkaller.appspot.com/bug?extid=8a7eea50810efde15b0a
<5> 133     Yes   kernel BUG in f2fs_write_end_io
                  https://syzkaller.appspot.com/bug?extid=803dd716c4310d16ff3a
<6> 10      No    kernel BUG in __update_extent_tree_range
                  https://syzkaller.appspot.com/bug?extid=24124df3170c3638b35f
<7> 5       No    possible deadlock in f2fs_do_truncate_blocks
                  https://syzkaller.appspot.com/bug?extid=14b90e1156b9f6fc1266
<8> 3       No    kernel BUG in f2fs_do_truncate_blocks
                  https://syzkaller.appspot.com/bug?extid=1867a378155795cb1680

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

