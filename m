Return-Path: <linux-kernel+bounces-835084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF52BA636C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 22:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB98E17D9E7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 20:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E422367D7;
	Sat, 27 Sep 2025 20:43:35 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7682367CC
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 20:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759005814; cv=none; b=OHQCzctPgK2xhsXbry6t552tAVl3H08i1Je8bQQE61JqW3F1uQqaseOSKTgNlehTwGzV77/oxkAkfgId6jLvSsgMsOBHiWjSzXEiZh8vstO0RAVUpbwKKvK0hjFCIn0bTBJjBYbXsZi2dg0Piyq5OXwosmG172yFBGzw4N5+qak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759005814; c=relaxed/simple;
	bh=dOpy1uFMogH9oUpga4sGkLtnXPycy0bQ8U8zm4cYFsY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=st/XhbJ2HE5AhW0q/iwCCqX0+E81O8dyehQi7gCnc2eJ9rbYeXAuJpcQ5MHzC+9gOzmYSkbZlNF3Gdh6RstfQRcI3TfeWjmRQIpD5ZVwGrkW/feU4Ejg7lBfq9b4WyvZKrM0sOD36kZtRY2KUzJo0la+IyiH1AM5KXF724KcugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8ea63b6f262so820979939f.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 13:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759005812; x=1759610612;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QlAW+0wrGfNlAnLDwb/Td7PyZFz7EaBiXfsOSWBu5UM=;
        b=UwDSfb/dGl49qN2iW4kyn44g7y6dD2FnnVgH6x/u/aoU6jXnlzsU/FAobgNb9tW43q
         koIqHUE4KyYzb5aLi87bneToVDH6RLrP3ZsxJgA2Jfm5udUWKkaXGHFinH97M0jLOVrP
         imbjinxKbXD14kvzp9lynCQeVeQj7VIPY/yFGt6ZDssAsnLmbWEhF/GPytzjEk0KMurn
         8KVhbFcHmNybEEEVwtYtzQ2iDpnWJ3GNH+euVO99bOoFgQv5jjbCKVgqLhGRE58Rvk4v
         8W8FLlEClWKxszW+W7FRN9g24kvuOJoQ0OgmbSxkDDTRpJ59fBFVvldin+ygyOsS6aOr
         Xp/A==
X-Forwarded-Encrypted: i=1; AJvYcCUd+DWs3eP8z0/dJjNiLjwfvnmwF1EbmhmzthJQsu+ZyKODKjn2bJruENhakN4aPij5ZAwH+5M4MBZ8DlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPejImY0YVbgrAEg4TMolw4k5vID0KtLmgQdjfeIzxMUiCaIeC
	e4bCG2uPmpYy9Ke24ZTDZWcbBE8QEme55ah6sGw7DHCpW8BbzUbDVYaeiUgO4WLBUTqxTGhqnbv
	fFMJU3GBpaJxCIs1WRfm0wVgoWjb838ldKzq1mDFkpQ0rzgtqdSy2cNAR9pU=
X-Google-Smtp-Source: AGHT+IE8+QEvDWEplb9mrqkOLIWlOZvmtg04ERRzNd5VCbE6l6R0DxWfVByHrj+3tU8cyg/NHN+Qw0vHAeA4lLZ5QvTGhD6Jmk79
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:482:b0:425:79b4:9ef6 with SMTP id
 e9e14a558f8ab-4259564482amr131687875ab.27.1759005812428; Sat, 27 Sep 2025
 13:43:32 -0700 (PDT)
Date: Sat, 27 Sep 2025 13:43:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d84c74.a00a0220.102ee.001e.GAE@google.com>
Subject: [syzbot] Monthly xfs report (Sep 2025)
From: syzbot <syzbot+list07b27ac0a85d2c843468@syzkaller.appspotmail.com>
To: cem@kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello xfs maintainers/developers,

This is a 31-day syzbot report for the xfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/xfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 27 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2750    Yes   INFO: task hung in sync_inodes_sb (5)
                  https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<2> 232     Yes   KASAN: slab-use-after-free Read in xfs_inode_item_push
                  https://syzkaller.appspot.com/bug?extid=1a28995e12fd13faa44e
<3> 105     Yes   INFO: task hung in xfs_buf_item_unpin (2)
                  https://syzkaller.appspot.com/bug?extid=837bcd54843dd6262f2f
<4> 40      Yes   INFO: task hung in vfs_setxattr (7)
                  https://syzkaller.appspot.com/bug?extid=3d0a18cd22695979a7c6
<5> 13      Yes   INFO: task hung in xfs_ail_push_all_sync (3)
                  https://syzkaller.appspot.com/bug?extid=92fbc8b664c9bbc40bf6
<6> 13      Yes   KASAN: slab-out-of-bounds Read in xlog_cksum
                  https://syzkaller.appspot.com/bug?extid=9f6d080dece587cfdd4c
<7> 11      Yes   KASAN: slab-use-after-free Read in xfs_buf_rele (4)
                  https://syzkaller.appspot.com/bug?extid=0391d34e801643e2809b
<8> 1       Yes   INFO: task hung in xfs_file_fsync
                  https://syzkaller.appspot.com/bug?extid=9bc8c0586b39708784d9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

