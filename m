Return-Path: <linux-kernel+bounces-860126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4A4BEF5BA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF37D3BFFBF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA14C23EAA3;
	Mon, 20 Oct 2025 05:32:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23538635D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760938324; cv=none; b=I6QU8ESYIw8Kfgk+u8Cxpk0xj+jK6z4vGg+4ZhqdPIukjSP8ggY8I4j2HjGn+UfETmyC1Mhx6GDAMOLjG1XSeUlMGdttyPVbB5HJ1Iqm4ACNmGel8fN0UgeN1bmL/w8F9C1fTaWWIbwCv8Z/hMH/Lk0dOFr/y/8T1sjUnqMAFWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760938324; c=relaxed/simple;
	bh=yFd5jssshs8ZvpSkWYi55/nW/GY6HWAT1qK0o5t2fok=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ny5jV0yqpFpqgftW715/bvKiXv7uKhzBzxZogIQGsDgxWeI6advpVlEwk6lKgRshC2sXRgaQnx3qE/n6CO3g/97pMXmzlitcSsk6uzaKKSkQCrXNzCRG9v/vonWaWHD6wUKpShXIPpUyi0pi3NRHpzHUI8CCIUTPPMWsSUb5N/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-93e7b0584c9so228592539f.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 22:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760938322; x=1761543122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHew1nT1YTG70UVWDKPR9uReuPl+j3B2kVokdiOT2mc=;
        b=moj/NjhMArZM9ZUdhVkDrXcn69uNVAJoyl9Z1uuIpc2u8JhTTwlKLgvYNrugrOEfMQ
         ERsMGdYw0ypiMpJTXdTLg3gQv37aL4QFZjkg6O+sa1cb41p+v5WL4eOkaIT8MOUD3JIX
         RgTgDhFmFSdhnWA1jBYer5b7VNWwglX2rb3CqeTMch9mjlb4a9MPQYGrS9obG3Fs0yiL
         Oug6c5xlcAwXUDc5Z9wszVY22DEMYA6jpuGXu4TRDESsg77MW+Wu/fWYzjcdaHL0WJ8Z
         JjJroga2QCdZiyVsorody3efr6I8uA+jX9LBYjTAjBmGbuEruev0G/PIvaIkfGwwjbkR
         Aftw==
X-Forwarded-Encrypted: i=1; AJvYcCXLna/F7qmS2Ra8VRenElj6LYKx6ceFZlukmQkNJWGgYy6np7iFGCNsAYS11nYK0o9mMQlGc5clfkbC/xI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP0/6ClqqTRTCz7Nc58qAuUKSZWBtD3R0i6Z0SRKsangFwIe2l
	bsGU81HAqm4RN+yZyKAaXuGBLhHShq+cfMHCMgSVsShe0x0cmTXSpBGAWeZrAfNcWFZShYNe9JA
	NPr3eLmGG3GHW9ACLQfDdvTXPc/LOmtunGPmloaVzcVexVE0Ja4WNnW2//BU=
X-Google-Smtp-Source: AGHT+IHbExlzADWVFwhGTLSVrnsL/Uo9+DdiVCg2bSy/QTJN46OVbyA1ln26dFCBzDtb/4pZUB1Mj8aAltTn/8dcyO4jT5Sj0sZe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:f715:0:b0:93b:bd28:b1af with SMTP id
 ca18e2360f4ac-93e762a87b4mr1605002539f.3.1760938321945; Sun, 19 Oct 2025
 22:32:01 -0700 (PDT)
Date: Sun, 19 Oct 2025 22:32:01 -0700
In-Reply-To: <20251020050706.473196-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f5c951.a70a0220.205af.0027.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (3)
From: syzbot <syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, stable@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in __ext4_journal_stop

------------[ cut here ]------------
kernel BUG at fs/ext4/ext4_jbd2.c:54!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 7077 Comm: syz.2.139 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
RIP: 0010:ext4_put_nojournal fs/ext4/ext4_jbd2.c:54 [inline]
RIP: 0010:__ext4_journal_stop+0x191/0x1a0 fs/ext4/ext4_jbd2.c:126
Code: e8 f4 39 50 ff e9 f8 fe ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 10 ff ff ff e8 ba ee b5 ff e9 06 ff ff ff e8 d0 39 50 ff 90 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90005097840 EFLAGS: 00010293
RAX: ffffffff826f68f0 RBX: 0000000000000000 RCX: ffff88802c95bc80
RDX: 0000000000000000 RSI: 000000000000034f RDI: ffffffff8d5e1065
RBP: ffffc90005097968 R08: ffffea0001c01337 R09: 1ffffd4000380266
R10: dffffc0000000000 R11: fffff94000380267 R12: 0000000000000078
R13: 000000000000034f R14: ffffffff8d5e1065 R15: ffff888072ba0298
FS:  00007fbd8db566c0(0000) GS:ffff88812646d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000674 CR3: 000000005d163000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ext4_write_inline_data_end+0x7a9/0xab0 fs/ext4/inline.c:847
 generic_perform_write+0x62a/0x900 mm/filemap.c:4263
 ext4_buffered_write_iter+0xce/0x3a0 fs/ext4/file.c:299
 ext4_file_write_iter+0x298/0x1bc0 fs/ext4/file.c:-1
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbd8cd8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbd8db56038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fbd8cfe5fa0 RCX: 00007fbd8cd8eec9
RDX: 0000000000000078 RSI: 0000200000000600 RDI: 0000000000000005
RBP: 00007fbd8ce11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbd8cfe6038 R14: 00007fbd8cfe5fa0 R15: 00007ffdf5505328
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_put_nojournal fs/ext4/ext4_jbd2.c:54 [inline]
RIP: 0010:__ext4_journal_stop+0x191/0x1a0 fs/ext4/ext4_jbd2.c:126
Code: e8 f4 39 50 ff e9 f8 fe ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 10 ff ff ff e8 ba ee b5 ff e9 06 ff ff ff e8 d0 39 50 ff 90 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90005097840 EFLAGS: 00010293
RAX: ffffffff826f68f0 RBX: 0000000000000000 RCX: ffff88802c95bc80
RDX: 0000000000000000 RSI: 000000000000034f RDI: ffffffff8d5e1065
RBP: ffffc90005097968 R08: ffffea0001c01337 R09: 1ffffd4000380266
R10: dffffc0000000000 R11: fffff94000380267 R12: 0000000000000078
R13: 000000000000034f R14: ffffffff8d5e1065 R15: ffff888072ba0298
FS:  00007fbd8db566c0(0000) GS:ffff88812636d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fab1c171880 CR3: 000000005d163000 CR4: 0000000000350ef0


Tested on:

commit:         211ddde0 Linux 6.18-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113e8de2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=308983f9c02338e8
dashboard link: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15536b04580000


