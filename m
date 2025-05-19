Return-Path: <linux-kernel+bounces-653517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC74CABBAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 12:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B6C3A8C08
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 10:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB9E26F462;
	Mon, 19 May 2025 10:12:37 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974735957
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649556; cv=none; b=euwciou2mCqZDAn6PazsE+ODNze0FkrN0QnEd2V3vk/i4D5/gA13BVdl5j3y2uhiCtIwvKALmwMPnyn+oOiSHnIykS5OtwWSgWw67Xgpvcfd4KRig++PSYHxRxA9NDWsGnR1u2DndUN15lv3GyUt2JGa5U4hvNX0+vbONsOMJfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649556; c=relaxed/simple;
	bh=EsQNEZuGqoVKZGjEHuRYqZnPmosQfdrB444gfd1dMLA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MusOmkuQzwRWW/l+BKi2AKMNJ08+G6VN62LrB3hm39nEbo4vEAR800o/mD/jFICc/AQrPxTvHQg4kAEl2iuz/3tWm3PU9RS7muRXOARoSWsiOfY+ch5d8cjbl4S7jeQJl+I8lFVetN6A7kTMsGu5/0u1yTlJJr2WwW941AAzI2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-85b418faf73so767686039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 03:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747649554; x=1748254354;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Uzz1AxszAO+PF9ibC0zz8xp6JcJ1BC5ZEytJhZFUKk=;
        b=I8AXT2xe249owakZucSbthh5HtO86cQ8NO+IHterBtBiK/YCmzMxXX3XSK09gbaNXl
         LpYo9tAX52RHhb742cLrsMqYPU5LRi+aCHYN6dg0XXvr6sdCW+jIZPZBsFnuupzx25QD
         mY4gmiYJu9UbaD1fovt/7+cV1dBLKGfjgzA/stHUOS42Bm1ng4RWNouEJHpX2BzDrr6B
         i5ZWK4kzMixULC1ZxRZXigyfgC6L5Mz9P6p4Tg9N1B97EDi5psiF5kJ2UPTyuhY8eSwR
         Rd84K7UgdQVopBxPfVZ9m12f6hOLXT7qFBYiz3A5dxLNb0c/jykbE2mSvWqZ3AZvRi2w
         qqVg==
X-Forwarded-Encrypted: i=1; AJvYcCXxtc2qoxOws3aPEB6bz6JZI7IMRrW+XDPvJ+WRLjbwvDP72dZmi/ESG1QgYbM/BpQnR18w1b+DuTGaqC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFFy4SeQPUI8XyBYUtx4NoZDxL53gH3BjG+nTHDP6tLXaz+ArS
	NZuTHTqllzGcXk/aJGS3jGwVZwffPLxvuoLpeQm0qCHivVGi236ivx0Rjb68kngBNVRgktaTiWf
	XXzfulUX8ZYJvWU5heiM9/IbIqFUILplD61S9Yon2Mb0Lk7xVA60JZ2xKi8k=
X-Google-Smtp-Source: AGHT+IG2Y0u+RSiUdq+RUnS4edusSPDCIYfX3VwkA1by3DVqjfO2+y5isVYDZPvl5V2L2cxYCnKf2XMjBzdmiPaSH+d7VoQfjBzJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:380d:b0:864:4aa2:d796 with SMTP id
 ca18e2360f4ac-86a231e19e9mr1507000039f.8.1747649554248; Mon, 19 May 2025
 03:12:34 -0700 (PDT)
Date: Mon, 19 May 2025 03:12:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682b0412.a70a0220.3849cf.00b1.GAE@google.com>
Subject: [syzbot] riscv/fixes test error: can't ssh into the instance (2)
From: syzbot <syzbot+2cae92ded758083f5bde@syzkaller.appspotmail.com>
To: aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    01534f3e0dd7 Merge tag 'riscv-fixes-6.15-rc6' of ssh://git..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=158796f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c32351e59d854b7
dashboard link: https://syzkaller.appspot.com/bug?extid=2cae92ded758083f5bde
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/a741b348759c/non_bootable_disk-01534f3e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4ca1cbb891a9/vmlinux-01534f3e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5fb1db315d47/Image-01534f3e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2cae92ded758083f5bde@syzkaller.appspotmail.com



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

