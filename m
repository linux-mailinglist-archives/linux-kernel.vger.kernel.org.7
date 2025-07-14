Return-Path: <linux-kernel+bounces-730553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7045FB04631
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9718E4A6527
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB88262FFC;
	Mon, 14 Jul 2025 17:10:35 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12908251791
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513034; cv=none; b=nSyiL74fAy+VYaSoCW6kWuvWxLVnqlBis1YPHTUy5PV73IArI+mIZ/HtBmsY1Rc0hkLqr6gjxqfNvvdFsR9LMXkKfAazJ7KVTE+4cRzo8ew+DiAJI41ezcctYOnLKrJhCpB+A0UstTx5eJ6PGAtQ+Ji3ExTYNeD/A0oQiFWUfN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513034; c=relaxed/simple;
	bh=xosleCPydwPw9RCR058KdQwnjvCAVwqnuNSaOkY/Rtc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QLvpcbP6VwILXtQ2HYYbpdDDatkJB3Qc+izvUK/h3h7JUvJnn2rCWiAD0/GubnihWe2f+U5iy7azXkTc8sGUz/guNx1e9n0WokpkFPINSzv0EImK+rgZRg96YBcj5S90XHIgb/fB0oRENeo2quzf7BncLH2S7WARQncEcMiPISI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86cfccca327so935991739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752513032; x=1753117832;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ME68ccWQSqf6a9g6Y3F69O0j0q4dSJ8e2JfndJwfe78=;
        b=dT9oOItGznMr29GlnUJuzjJA7tlbJlvGWNp5kNRm48OvLpsU+QEuUHPOShW/K54k6w
         dzMRyC0gMqu2nQ7kfgJFxrhnxd4YFAKTCeJEkfuYH4WSiRpbnQYx5mf1zjbUmT923jLE
         9pPqMFZxM8m5v1cC8e5UUGkHcGzIVb7jPHyw8tm0iiiMWTv3RyTUEpoCwBAKJUdr/08U
         MpU/L/eRhpL+3iwCNDq3sAMPKdOrUv2GTB+C9Npno+dgaseQQmatj6uob6Kl20Emp9sV
         DpaKD8maB4ncsoXBtVXNLZGnSo31RxYWHGqe15wnb2xrYmvpll+rHW6uu42yG/0GeAeV
         YuIg==
X-Forwarded-Encrypted: i=1; AJvYcCV03IimDzDJQFk2rDUgFy7aRaZ3vdWN+vvm0ICwTv+xGcwvXIzV7muhpMJJcsgOBz04n0vx1aika1FKxEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygFYNaNQSEQBG78Y8ukRclZxCgt6PT8QqDHQjl+EjcJEHf0DCz
	8LYp33hzk5UJAT+797DnoC4xLhsC2RRQ56mgBKDybl2aVGP2p+k7W0WmOfnzlC3U9LTPCItr7Jy
	aATYkjGkJr2OgzttKBcivpg2YeD+n50e+Ga5XB26P8nS1BeuOGdllV/P1bqE=
X-Google-Smtp-Source: AGHT+IG18/7Y1Y6Nj3Cp2fRJ3VxUVXub/V9E26+tmvg0lc4t/97T7y/1XgN/UaRn5K+OpKRurxa5f22laEGXq5QOYOffqIN6VxLr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1353:b0:876:5527:fe2a with SMTP id
 ca18e2360f4ac-87977fd0670mr1601323939f.11.1752513032004; Mon, 14 Jul 2025
 10:10:32 -0700 (PDT)
Date: Mon, 14 Jul 2025 10:10:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68753a07.050a0220.33d347.0007.GAE@google.com>
Subject: [syzbot] [fs?] WARNING: lock held when returning to user space in query_matching_vma
From: syzbot <syzbot+add57955be940be754a1@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a62b7a37e6fc Add linux-next specific files for 20250711
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11e2ce8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d42120e19faaef
dashboard link: https://syzkaller.appspot.com/bug?extid=add57955be940be754a1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132750f0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167507d4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/691b5f8ab5b1/disk-a62b7a37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/47d1a209784d/vmlinux-a62b7a37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eb70d73c9e55/bzImage-a62b7a37.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+add57955be940be754a1@syzkaller.appspotmail.com

================================================
WARNING: lock held when returning to user space!
6.16.0-rc5-next-20250711-syzkaller #0 Not tainted
------------------------------------------------
syz.0.22/6099 is leaving the kernel with locks still held!
1 lock held by syz.0.22/6099:
 #0: ffff888069d41588 (vm_lock){++++}-{0:0}, at: get_next_vma fs/proc/task_mmu.c:182 [inline]
 #0: ffff888069d41588 (vm_lock){++++}-{0:0}, at: query_vma_find_by_addr fs/proc/task_mmu.c:512 [inline]
 #0: ffff888069d41588 (vm_lock){++++}-{0:0}, at: query_matching_vma+0x319/0x5c0 fs/proc/task_mmu.c:544


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

