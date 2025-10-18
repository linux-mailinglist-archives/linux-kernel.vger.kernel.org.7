Return-Path: <linux-kernel+bounces-859266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AC439BED2A8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACC5234DD9B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4211E22576E;
	Sat, 18 Oct 2025 15:35:10 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A68F354AEE
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760801709; cv=none; b=nDX6L4SrEaQ+D6ZmnTYbtU6bjPHhYq6Irfd8bi9nK6nWWYH8lBIIesTcShbnYW84GY81hrnmMbgFrTvseVfgL3GfHyekP9QoLPqrfT1ADBws9FO8tV39vNmSzkdQSEYzVH9IwyzUkbhUBpoA8AOYQ0yq8DlqsLr+mopJGxZXjS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760801709; c=relaxed/simple;
	bh=IR8ajtBRjRXYTpTxGxpisOBVKOIv6iBNlN54bjj+wqs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ANoK9fI/XHkmeVXiqwdZ8oPK1qLKO3LVnHUB4PPQCY3aeuk4T9VUv2LQhmtltx+DQAV+JlS+8CIR59pLeaE2fJtmclysrK3cwywKG7zeOvdUiDpzULpEsj1qFO+EUu3VLnL0pbEV5svTsE7yut9/RsdGcfauKdyNm2noQQLNoXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e7ece2ff4so425355639f.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 08:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760801703; x=1761406503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lVIxpu5egdc6nyJOmk5bTwYilCvcr30Ix3idtjl/w0=;
        b=fVhY5xCoO3TiREiqj4b6Dyh4ZueFqj1mEU1rxBE2EI2KDei3WJm21mWeuKsowE9oZ6
         ynNd9FbRjKAxO+wKHC7Ix4IhltfcfkiJYurkOIU3OuMG2RIhPLEmArYbW6PhmnICIq4L
         qCF1sIbc8urx14qxcqgoc7yFNqi+wlkX8IUX1Srt5AmhYE9O+W05EuKAjSJVBfB/3DQE
         dRjdwHGCQGy305yKpMPG3YbPgloZ7p4jU7HDLt/PfN/OlnDbdAzHfNFz4+PRMaIigL3S
         vJvuLnk3HRuYHZdqh4X7dPjO5R55G3GF46DmcoDJqQUx96NrulS4HuFG9JAiq0neYMUK
         ZQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCUgh8QkJ8geyurb3r6VNGju9npZGku+7vIX4fiHLeCnJ8FHgF3l84FIBJp6JEBbrlQcjpvEe0n7RIQ68Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbAbi4bwVO166+c8Vf1PvGNDJdMmd2OI9BLLl4U+99TKOtOF5T
	PZap6YN7y32cOGFpzH7DRfT7lbpID3t5nsTvKODTZiE4NMMAojcVEUrWc+276Z57q5OCq0/kEu9
	aAeZ60LLDAXIi8P/3FlRFMpMys+SYeCBWgMIkzRKBiyPpawkKF/tNCYT5PxI=
X-Google-Smtp-Source: AGHT+IHPPrOn7MaPqFDkCC5qdGIp1AcGiHlf4izcbCz8LcUaIcABH8BpzsjQ7qV5b4gyMVRnFchevb810z3CQIOJBITWi+rh+f33
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c22:b0:430:ab29:e75b with SMTP id
 e9e14a558f8ab-430c52bed72mr118264845ab.17.1760801703269; Sat, 18 Oct 2025
 08:35:03 -0700 (PDT)
Date: Sat, 18 Oct 2025 08:35:03 -0700
In-Reply-To: <20251018151148.411120-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f3b3a7.050a0220.1186a4.0520.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (3)
From: syzbot <syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in __ext4_journal_stop

------------[ cut here ]------------
kernel BUG at fs/ext4/ext4_jbd2.c:54!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 7268 Comm: syz.3.141 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:ext4_put_nojournal fs/ext4/ext4_jbd2.c:54 [inline]
RIP: 0010:__ext4_journal_stop+0x191/0x1a0 fs/ext4/ext4_jbd2.c:126
Code: e8 e4 3e 50 ff e9 f8 fe ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 10 ff ff ff e8 ba ee b5 ff e9 06 ff ff ff e8 c0 3e 50 ff 90 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc9000b107840 EFLAGS: 00010293
RAX: ffffffff826f6420 RBX: 0000000000000000 RCX: ffff88802e085ac0
RDX: 0000000000000000 RSI: 0000000000000361 RDI: ffffffff8d5e2286
RBP: ffffc9000b107968 R08: ffffea000175b077 R09: 1ffffd40002eb60e
R10: dffffc0000000000 R11: fffff940002eb60f R12: 0000000000000078
R13: 0000000000000361 R14: ffffffff8d5e2286 R15: ffff888074bb6bc8
FS:  00007ff117be16c0(0000) GS:ffff88812646b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555564fe588 CR3: 00000000546e9000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ext4_write_inline_data_end+0x7a9/0xab0 fs/ext4/inline.c:865
 generic_perform_write+0x62a/0x900 mm/filemap.c:4263
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
 ext4_file_write_iter+0x298/0x1bc0 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff116d8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff117be1038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ff116fe5fa0 RCX: 00007ff116d8eec9
RDX: 0000000000000078 RSI: 0000200000000600 RDI: 0000000000000005
RBP: 00007ff116e11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff116fe6038 R14: 00007ff116fe5fa0 R15: 00007ffd5125ed68
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_put_nojournal fs/ext4/ext4_jbd2.c:54 [inline]
RIP: 0010:__ext4_journal_stop+0x191/0x1a0 fs/ext4/ext4_jbd2.c:126
Code: e8 e4 3e 50 ff e9 f8 fe ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 10 ff ff ff e8 ba ee b5 ff e9 06 ff ff ff e8 c0 3e 50 ff 90 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc9000b107840 EFLAGS: 00010293
RAX: ffffffff826f6420 RBX: 0000000000000000 RCX: ffff88802e085ac0
RDX: 0000000000000000 RSI: 0000000000000361 RDI: ffffffff8d5e2286
RBP: ffffc9000b107968 R08: ffffea000175b077 R09: 1ffffd40002eb60e
R10: dffffc0000000000 R11: fffff940002eb60f R12: 0000000000000078
R13: 0000000000000361 R14: ffffffff8d5e2286 R15: ffff888074bb6bc8
FS:  00007ff117be16c0(0000) GS:ffff88812636b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555593914808 CR3: 00000000546e9000 CR4: 0000000000350ef0


Tested on:

commit:         f406055c Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173b2b04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=308983f9c02338e8
dashboard link: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b5767c580000


