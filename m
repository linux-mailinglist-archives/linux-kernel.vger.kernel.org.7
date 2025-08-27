Return-Path: <linux-kernel+bounces-787894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBDEB37D58
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6382C5E0B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D39D335BBB;
	Wed, 27 Aug 2025 08:15:37 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194C8273800
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282536; cv=none; b=olw0jBzGS6sLQsmvz2dY3eo24NihjZphvDTpL3Z19Jo9bdv5lR7TZdW1SiJsAxGZDkqkhNb5hNLs8J8qJ+vmlDD7fwUakJE59KSVo1Vfn62WjBzRy4HO+TPr8FB660aZ5oMAb7CcInxwabOB8G0XlMgQ5MFMtxHun+PN3cRoUsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282536; c=relaxed/simple;
	bh=g5EAdOq4nbNrMDycLfDUT5qkoEvJRCbcq/nzuV8pmmo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Wzwt7EzkFVZdbYCffxXURgnhR7hq4WkuKHY9YX/CnALVr3fw6DPVLyusbWBaZWtz2uzHmxQErRNSllu9y5SjaRX+kBCX6i8C3rVaWtARc9yWxpbQzuxYwvKxapXYD/tPa3+UnPJgQXqtN/ZTpcOC9LfEBWLn1FY+mb/ezfp8R2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ed6502add9so27272965ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756282534; x=1756887334;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mY5T3saMw+ScB7Jfgl0MCq8x+xrVCw4jczqPzVND7KA=;
        b=InjlqdYxeRLPSX+ytSkMZH+xlUwz2r3ZTvHOiT7KhXL7awOcocIHS0/B4pKI1tE395
         5vck7Igy8qWRTAD2P7Z4faGIaz71CTHVtLYUoO6rj9z8C8LV9s4etS+nlSXv3WGWHif6
         wGWSjr6T6Sii1GXyU/Mw/sbaPCAO6xsp1AL4YgO+vC5CpE8PuJhv+Yzn6+eXCV63cEz2
         7x4+U6PYl8FmYAwwawrMv4aLlj28K3RKWzg3duL44R/YWuLP0KR92wGhzmQNXfmQz6nx
         /BXNjEhbhRJC5tY1x51dJ95oLArPwpLHxI5AY7WX33Zx6grCdEnfYRL7pxTOB1j5ewIb
         d3aA==
X-Forwarded-Encrypted: i=1; AJvYcCWj1HRcnFGK0/2YdsotCE6b9lWiooGXQloS01kloWh98hSOaAmVT2zKzZOwUUwFdzff+6CqbhRciNyepoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy85/4zHoYPr8s+odSc7EK5qHW8tecwYBrTbARdBepQbF4UwaA0
	SHJnWUJjx44pQUh7pu0cdwD9jTHboi/e9Ctq5epv8rTRnEEIhcsOPlrtes3H4Bth3Ig8mjHRMMB
	MlYOQcLImIjQQOYxzfju9Ue6s35z0D7thsI6vBxqF5/KZXc6lHB0p5f/1fPQ=
X-Google-Smtp-Source: AGHT+IFXBQbKGcOq5qKykhKok3Tn6HIV67C1PxK+uXdesng0mbm5G+jKzdDjNhsUTouLcjhgjsLpao5fKS6f/frf9uQ916S9Mei1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3cc6:b0:3e5:7e02:a06d with SMTP id
 e9e14a558f8ab-3e91f93e0dbmr246066775ab.4.1756282534333; Wed, 27 Aug 2025
 01:15:34 -0700 (PDT)
Date: Wed, 27 Aug 2025 01:15:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aebea6.a70a0220.3cafd4.0014.GAE@google.com>
Subject: [syzbot] Monthly ext4 report (Aug 2025)
From: syzbot <syzbot+liste757592c95c323314d50@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 4 new issues were detected and 0 were fixed.
In total, 51 issues are still open and 157 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  77827   Yes   possible deadlock in dqget
                   https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
<2>  2920    Yes   KASAN: out-of-bounds Read in ext4_xattr_set_entry
                   https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
<3>  2624    Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<4>  2555    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<5>  2135    Yes   INFO: task hung in jbd2_journal_commit_transaction (5)
                   https://syzkaller.appspot.com/bug?extid=3071bdd0a9953bc0d177
<6>  844     Yes   KMSAN: uninit-value in aes_encrypt (5)
                   https://syzkaller.appspot.com/bug?extid=aeb14e2539ffb6d21130
<7>  837     Yes   WARNING in ext4_xattr_inode_lookup_create
                   https://syzkaller.appspot.com/bug?extid=fe42a669c87e4a980051
<8>  476     No    KCSAN: data-race in generic_buffers_fsync_noflush / writeback_single_inode (3)
                   https://syzkaller.appspot.com/bug?extid=35257a2200785ea628f5
<9>  443     Yes   INFO: task hung in do_get_write_access (3)
                   https://syzkaller.appspot.com/bug?extid=e7c786ece54bad9d1e43
<10> 254     Yes   INFO: task hung in do_renameat2 (2)
                   https://syzkaller.appspot.com/bug?extid=39a12f7473ed8066d2ca

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

