Return-Path: <linux-kernel+bounces-857706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5787EBE7C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42EC42253B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB95311C3F;
	Fri, 17 Oct 2025 09:20:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17FB3115B8
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692805; cv=none; b=iLwzTh+IRibo5QjoEe0JygowY4THDFznLQKvpMkEoUjjx7VWIuuJSUsSsAv7qGzrNzKmaK5iv5hellZr+Cf/dUu5sF1K/Z828/slo50EbuGGf+uiS1K/tB/vLrcG6sP87wOowqLxAspqNDfrrrDRbg/3jOMv2kSzktobUOwea88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692805; c=relaxed/simple;
	bh=v+b2itQo3qtdbNNDymti9Y+w3BnxKEthz95gxcwY/Tc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gIZwxIjdsgTAoDLteR7R1qqa1lnq+EiTWfFY0vMKmHN9g3QhFEnY6eKUzx/94Eyyiwwj3PfKxppPC+pq7oUzwYLdaKn2r55TsuNTxxB4CLBUrWP+/ebmHPEn2ei62Xbtb2XpWVe+VkkAC6FG0NARu0ug2K2mwm8zrUKAliMO134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430c684035eso11548255ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760692803; x=1761297603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qAC+6lRoCT+KFlg/f9zEFHL3RIpw6+ZChDwUaOt3Bpk=;
        b=RWSZdZnWIHT0Jz4NTxBh6A5YL7k6rmxrx+zw199Kv0Dh8dl6r5mn3gqSk/QTGPBqQ6
         kkpza/ndvxT/LUkOkbys/OwB/00tf+5WMmxxzbHExs0pDCNMf/XXA1FvodgCIZ8sv6mx
         pCcaFC2J0wBXPluTdOuEN39gC6X8YlYnoBrE5Ro+JYWeQmVtnkuoftj4sl+/ALveAAKK
         RhPjKcaw5SObZU3Wc7L/O4kYfKyoD/UAyOG0R3Wftegh+ps9u0ak7ZsXzlJ5XTJ9ZImv
         5FVIrRK1m7G2vsgol60rDjNPufHC+OLgUfjLxYgwk9xpVmNkScyRT2spHyqRJGWU6cPX
         KzNw==
X-Forwarded-Encrypted: i=1; AJvYcCWTMl1NCv7AzraR75omy+nhA8Dco6Id8xW9hx755SHhBCXDivrZuBZTHQuxMalUe8toDCfDXuXENotBa5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkcl8wvzEGA7zMsVAF7wzy/7CkkGdCk1eG8m1G2OgNlN8zDOst
	rEy/QuYFmtcck4v6ZurIg1VgCjn9at5fnt0oursVz1UAu6VDFxa01GsCGHE4IaqaloNX0vyZ104
	SbF9SihZUmTifvwdLlCE4tTd3bwVB+XRz3hZ8SOFFyqG7YXFttM2O8ei5wf4=
X-Google-Smtp-Source: AGHT+IFx9xHDxm4N5DE2EEVn1dwOaSFsoujGsgoZpu9AxJ1mBTy6VJOb4zyqSaD/cWZLIPHM20DJnKiYqun3WhZYRglrN+1ZsSFi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4c:0:b0:430:af6a:de13 with SMTP id
 e9e14a558f8ab-430b3ff7705mr89553095ab.2.1760692803102; Fri, 17 Oct 2025
 02:20:03 -0700 (PDT)
Date: Fri, 17 Oct 2025 02:20:03 -0700
In-Reply-To: <20251017085719.821125-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f20a43.a70a0220.b3ac9.0029.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING in chown_common
From: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in chown_common

WARNING: CPU: 0 PID: 5970 at kernel/locking/rwsem.c:1381 __up_write kernel/locking/rwsem.c:1380 [inline]
WARNING: CPU: 0 PID: 5970 at kernel/locking/rwsem.c:1381 up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Modules linked in:
CPU: 0 UID: 0 PID: 5970 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__up_write kernel/locking/rwsem.c:1380 [inline]
RIP: 0010:up_write+0x3a2/0x420 kernel/locking/rwsem.c:1643
Code: d0 48 c7 c7 20 ff 6a 8b 48 c7 c6 40 01 6b 8b 48 8b 14 24 4c 89 f1 4d 89 e0 4c 8b 4c 24 08 41 52 e8 b3 36 e6 ff 48 83 c4 08 90 <0f> 0b 90 90 e9 6d fd ff ff 48 c7 c1 94 6e 9e 8f 80 e1 07 80 c1 03
RSP: 0018:ffffc9000d497c50 EFLAGS: 00010296
RAX: 29f4d5975a11a300 RBX: ffff888043da5058 RCX: ffff888034730000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa650 R12: 0000000000000000
R13: ffff888043da50b0 R14: ffff888043da5058 R15: 1ffff110087b4a0c
FS:  00007f49f65fe6c0(0000) GS:ffff88808d300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c005567000 CR3: 0000000058d8f000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:990 [inline]
 chown_common+0x3fb/0x580 fs/open.c:794
 do_fchownat+0x161/0x270 fs/open.c:823
 __do_sys_lchown fs/open.c:848 [inline]
 __se_sys_lchown fs/open.c:846 [inline]
 __x64_sys_lchown+0x85/0xa0 fs/open.c:846
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f49f6f8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f49f65fe038 EFLAGS: 00000246 ORIG_RAX: 000000000000005e
RAX: ffffffffffffffda RBX: 00007f49f71e6270 RCX: 00007f49f6f8eec9
RDX: 000000000000ee01 RSI: 0000000000000000 RDI: 00002000000006c0
RBP: 00007f49f7011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f49f71e6308 R14: 00007f49f71e6270 R15: 00007fff9d14f498
 </TASK>


Tested on:

commit:         98ac9cc4 Merge tag 'f2fs-fix-6.18-rc2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171475e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2d7b4143707d3a0
dashboard link: https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1448b67c580000


