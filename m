Return-Path: <linux-kernel+bounces-747062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BE1B12F3C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 12:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E161899C76
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 10:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124F120E71D;
	Sun, 27 Jul 2025 10:41:33 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E120110B
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753612892; cv=none; b=ORmgtBCQWjY94gtzlC4qQiTVu/UsXzMUKR6zvM5fDORsEFlC2bciEbdKgg3qMCVLXn7b5Tpwz/WQvUYnzS9BRyWW4uuI1TY/kouAUJ3gX31srfj/XGIsnWAJjhUFTKOM91U5xxVMKSdxufT7ZLBRKZXXP+ew93WAajvbFekcx/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753612892; c=relaxed/simple;
	bh=1z+sY1r1bSt4nt1yX8yYd2JVtkgNGqXWy+V7F6uQyKU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OLOcT3FKPWOY9QiMSmBeNnHMvq7oNljYjVJkibiHpR0OgVKDJyz10pfsAc21WYHERVmdvqLQjMuRIH3W9yGamXyOQ7/mhzfa6OPHJ9nrM89NjMkkoAhjhnx9TiuyT6RIlp7h+3eEK5z3wfA2wN7fMO72g7iMO4j2NYzf1WPx3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c1d1356f3so373682339f.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 03:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753612890; x=1754217690;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLVby4S1Yu+vhV3PiAuJdUuMMrGFCuoKaOzd1A0hB/4=;
        b=rJLLWog8SgRDzEPlXPbsfGV7GusdPztFPislvQxYoDxJHkORDTjLFySpaFXsrOJ2fD
         GrKlstKJniBNhqwnRLYDR4eZXkJoAEG5izFMmXcofE689Mjn5oGA3EreWSjfklP9qJHE
         oaolWx8bNs/N3ErrW1BPjRHD/kMu42P20Lv/E6dkheBvUaSx30ELBTiL3v3EzouqPR+L
         lvr00YAgQPKrPCrj3u+CYuBSM7J9isKSMSgbolBaZL1eNVWB+xJoZ/R+acHYAWUVu9W2
         JaAYHjsaj72RhgmE6NskM3o+J9tysMFbJ0lZH1XBG5GAcEGjfPrqC0m8RmIrOFMM1TT7
         gyaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNPap+bGdn4wrDrpGnclzCu+YGiPPm2rtQJ/CcpJSzaoITCHwjLyzotm3EzxKiuvIoh9+l9bOJBQAATMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdlJZw8vA3D+UakvMal0obnfZncklY9/UqHeSE5Lpurn1M2VO7
	lleCTSeKhi7fRTlEloc8VesbzxVPhCpqPVGxy9s0Z5E5egTLjp8vmyDtd/L9Dhh6+c5DHzhCdrQ
	GMr+JCDJIVUfJsf92Wx6lb8CupJLUipWp1pxmJ646fNb5hNnzOMLW0l678EQ=
X-Google-Smtp-Source: AGHT+IHa5mexOEUXQyXKRMMdscS6zJUVkwHr/EVOLI0DTP9KCYuQK4A4ovInfTYL9hrAWMzIpMf5X/p0g8nMvmwIkexmfcQYPO5Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2490:b0:3df:154d:aa60 with SMTP id
 e9e14a558f8ab-3e3c5322bdemr164937335ab.22.1753612890411; Sun, 27 Jul 2025
 03:41:30 -0700 (PDT)
Date: Sun, 27 Jul 2025 03:41:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6886025a.a00a0220.b12ec.0050.GAE@google.com>
Subject: [syzbot] Monthly ext4 report (Jul 2025)
From: syzbot <syzbot+listafafd041af3fe421a01a@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 5 new issues were detected and 0 were fixed.
In total, 52 issues are still open and 156 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  73190   Yes   possible deadlock in dqget
                   https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
<2>  2590    Yes   KASAN: out-of-bounds Read in ext4_xattr_set_entry
                   https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
<3>  2524    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<4>  2514    Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<5>  2132    Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<6>  440     Yes   INFO: task hung in do_get_write_access (3)
                   https://syzkaller.appspot.com/bug?extid=e7c786ece54bad9d1e43
<7>  413     No    KCSAN: data-race in generic_buffers_fsync_noflush / writeback_single_inode (3)
                   https://syzkaller.appspot.com/bug?extid=35257a2200785ea628f5
<8>  386     Yes   WARNING in ext4_xattr_inode_lookup_create
                   https://syzkaller.appspot.com/bug?extid=fe42a669c87e4a980051
<9>  242     Yes   INFO: task hung in do_renameat2 (2)
                   https://syzkaller.appspot.com/bug?extid=39a12f7473ed8066d2ca
<10> 211     Yes   possible deadlock in ext4_xattr_inode_lookup_create
                   https://syzkaller.appspot.com/bug?extid=d91a6e2efb07bd3354e9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

