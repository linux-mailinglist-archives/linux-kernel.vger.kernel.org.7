Return-Path: <linux-kernel+bounces-618394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF40A9ADF8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 14:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4007A4E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D52327BF9A;
	Thu, 24 Apr 2025 12:51:36 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641427BF94
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499095; cv=none; b=US95hLzjsBez6+bhiwVAhcqg3WlyExIltmWzU/ZS6pi25SvJ/q3mF10L+Ba5Ip4qwqCjpvLtzTsNV9sx3TXR4HoSG5yAyz1nRfHBo8PthEYmk5767CFdq3efopKEvNxvq+iqc1DJzKCZfW2AET8jLKCXzFlrA28hN4xnxV6v9Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499095; c=relaxed/simple;
	bh=5D5/0LzL83w5CwpzVO/3IUS4QnFdqrpA9CPTI/PQNsk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F9Y0JFHiF5F9EkvfGGBy7iDxTL0+XYVuOezV78V8MaA9wPb8Tbtp0yLILM4UkPTi7TmgODXPy4NRVNfsA4ojdrQq0LJzn1absHSTcEfR9aSLgFtxkbGenoa5tmp8YSUGPtX3dogMDVCHpf4GHq2sMePD8Shs8244NsTj1r/JOFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d438be189bso11246605ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 05:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745499093; x=1746103893;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXeQR3Sx467CreFuYozB+CwcPPf8At1T2RKk614NSIM=;
        b=GNnWTGmAju0ulIKCeGC+dJiaxc2qHPaEkuBAzZkVEtOqEbS7X3adfLHI3SkbV89T15
         2jcCoCrR5oca1AbA+pjv/249UNKbOeGwHhX/B8C6OKxWnZXBLWr+berSQJ85LGKgvKFl
         Taz2TvOJzlYIhmQOyK//7nw3FrXX79dK28RqHi7axlGk5LTOBFy76ginP25v7H2uvbO1
         3pl2Ej9XzakYMkmE/BLS3fgr4WHXsEsFXkNV51UwtonywKnzBonOL8bhIroegkPIRKmi
         tzdCUJkv0tWxc9bTUKdr6kB16o2TZT6RRcU26iRaD0lRgUMgdwbucnkvIeTkYmFh3Jcy
         equw==
X-Forwarded-Encrypted: i=1; AJvYcCVDZPRJIiY5HaANpQc1YSkR08kQp+HFVJkDCs3C9Zn5pHkduDD0kXJNwlXPOR+KdaSaohuJA+9mRYiwB60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOB6da2pW4fdBmu6i8uzg56H0Y4HU/lqx+a2JdVNnIA2gFgp2B
	8UvTTQdY+s3kFLmUPKAQ9lY3MUxu9gkL48vYOO0McfGcdsoZpXMZNDbKlkd0Q6HQqdbg6letwI2
	DpKN19poT0GdpEdCIb3TIdFUV5hpJyutkbyS0czso1yBNw9EVRx2Ldf8=
X-Google-Smtp-Source: AGHT+IFbFt3HSXR88BYSQzj51++/VfgmJ/IPefkHR6Ckckpg9vTik2GiXujwkU8Gg++jibwHOKkP3ofhpGNJ8IpzpN82gk8IP0VZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216a:b0:3d8:1d2d:60ab with SMTP id
 e9e14a558f8ab-3d930388dc0mr27240175ab.3.1745499093220; Thu, 24 Apr 2025
 05:51:33 -0700 (PDT)
Date: Thu, 24 Apr 2025 05:51:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680a33d5.050a0220.10d98e.0006.GAE@google.com>
Subject: [syzbot] [kernel?] net test error: UBSAN: negation-overflow in corrupted
From: syzbot <syzbot+76fd07ed2518fb9303f9@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, davem@davemloft.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cc0dec3f659d Merge branch 'net-stmmac-fix-timestamp-snapsh..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=131c21b3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac0f76cd0f8e093a
dashboard link: https://syzkaller.appspot.com/bug?extid=76fd07ed2518fb9303f9
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d6f321414b4/disk-cc0dec3f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/072c28c931b0/vmlinux-cc0dec3f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bcb44ff40c55/bzImage-cc0dec3f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+76fd07ed2518fb9303f9@syzkaller.appspotmail.com

virtio-scsi blksize=512 sectors=4194304 = 2048 MiB
drive 0x000f27f0: PCHS=0/0/0 translation=lba LCHS=520/128/63 s=4194304
Sending Seabios boot VM event.
Booting from Hard Disk 0...
[    0serialport: Connected to syzkaller.us-central1-c.ci-upstream-net-this-kasan-gce-test-1 port 1 (session ID: e72bd3249fa5f4b40b974e21e6d99e16e8384254f2e85c0fe39918dcc479fa4d, active connections: 1).
.000000][    T0] UBSAN: negation-overflow in lib/sort.c:199:36


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

